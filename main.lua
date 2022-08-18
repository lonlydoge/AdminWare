-- van inspired by rocket admin

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local InsertService = game:GetService("InsertService")

for i, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "UI" then
        CoreGui["UI"]:Destroy()
    end
end

if CoreGui:FindFirstChild("UI") then
    CoreGui["UI"]:Destroy()
end

if ReplicatedStorage:FindFirstChild("Container") then
    ReplicatedStorage["Container"]:Destroy()
end

-- gui loading

local UI = InsertService:LoadLocalAsset("rbxassetid://9625648426"):Clone();

CommandBar = UI.CommandBar;
CommandList = UI.CommandList;

Container = CommandList.ScrollBar.Container
CommandInput = CommandBar.TextBox;
CommandsImage = CommandBar.ImageButton;

Container.Parent = ReplicatedStorage

UI.IntroGui:Destroy()

CommandList.BackgroundTransparency = 1
CommandList.Visible = false
Container.TextLabel.TextTransparency = 1
Container.TextLabel.Description.TextTransparency = 1

CommandBar.BackgroundTransparency = 1
CommandInput.TextTransparency = 1
CommandsImage.ImageTransparency = 1
CommandBar.Position = UDim2.new(0.5, 0, 1, 35)

UI.Parent = game.CoreGui

-- ok it finished :)

local Admin = {
    Commands = {},
    Prefix = ".",
    Events = {ChatLogs = {}},
    Welds = {},
    Debounce = false,
    Flying = false,
}

local RespawnTimes = {}

local FlyTable = {
    ["W"] = 0,
    ["A"] = 0,
    ["S"] = 0,
    ["D"] = 0,
}

local Keys = {}

local function getKeyFromValue(table, value)
    for i, v in ipairs(table) do -- i want it organized
        if v == value then
            return i
        end
    end
end

local function getIndex(Table, item)
    for index, v  in pairs(Table) do
        if v == item then
            return index 
        end
    end
end

repeat task.wait() until Admin["Events"];

local PlayerAdded = function(Player)
    RespawnTimes[Player.Name] = tick();
    Admin.Events[Player] = Player.CharacterAdded:Connect(function()
        RespawnTimes[Player.Name] = tick();
    end)
end

local function getTool()
    for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v:FindFirstChild("Handle") and v:IsA("Tool") then
            return v
        end
    end

    return nil
end

local getRoot = function(Character)
    return Character and Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso") or Character:FindFirstChild("LowerTorso")
end

local function Define(commandname, description, mainfunction, cmdargs)
    for i, v in pairs(Admin.Commands) do
        if string.lower(v[1]) == string.lower(commandname) then
            return nil
        end
    end

    if typeof(mainfunction) == "function" then
        if cmdargs then
            table.insert(Admin.Commands, {commandname, description, mainfunction, cmdargs})
        else
            table.insert(Admin.Commands, {commandname, description, mainfunction})
        end
    else --goto line 428
        return nil
    end
end
local function getPlayer(name)
    local PlayersList = Players:GetPlayers()
    name = string.lower(tostring(name))

    if Players:FindFirstChild("random") and name == "random" then
        return Players["random"]
    elseif name == "random" then
        table.remove(PlayersList, getIndex(PlayersList, LocalPlayer))

        return {PlayersList[math.random(1, #PlayersList)]}
    elseif name == "all" then
        return PlayersList
    elseif name == "others" then
        table.remove(PlayersList, getIndex(PlayersList, LocalPlayer))

        return PlayersList
    elseif name == "me" then
        return {LocalPlayer}
    else
        for i, v in pairs(Players:GetPlayers()) do
            if string.lower(string.sub(v.Name, 1, #name)) == name then
                return {v}
            end
        end
    end

    for _, v in pairs(Players:GetPlayers()) do
        print(string.lower(string.sub(v.DisplayName, 1, #name)).." "..name)
        if string.lower(string.sub(v.DisplayName, 1, #name)) == name then
            return {v}
        end
    end
end

local function commandCheck(Message, CommandBar)
    Message = Message:lower()
    
    local Splitted = string.split(Message, " ")
    local noPrefixMessage

    if CommandBar then
        if string.sub(Message, 1, 1) == Admin.Prefix then
            noPrefixMessage = Splitted[1]:sub(2)
        else
            noPrefixMessage = Splitted[1]
        end
    else
        noPrefixMessage = Splitted[1]:sub(2)
    end

    local args = {} -- spoderman wanted
        
    for i, v in pairs(Splitted) do
        if i ~= 1 then
            table.insert(args, v)
        end
    end

    for _, v in pairs(Admin.Commands) do
        local Aliases = v[1]:lower():split("/")
            for _, Alias in pairs(Aliases) do
            if Alias == noPrefixMessage then
                if v[4] then
                    v[3](unpack(args))
                else
                    v[3]()
                end
            end 
        end
    end
end -- wait ill test something

local cframeTool = function(tool, pos)
    local RightArm = LocalPlayer.Character:FindFirstChild("RightLowerArm") or LocalPlayer.Character:FindFirstChild("Right Arm")
    local Arm = RightArm.CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
    local Frame = Arm:ToObjectSpace(pos):Inverse()

    tool.Grip = Frame
end

local AttachTool = function(Tool, Position)
    for _, Object in pairs(Tool:GetDescendants()) do
        if not Object:IsA("BasePart") then
            Object:Destroy()
        end
    end

    local RightGrip1 = Instance.new("Weld")

	RightGrip1.Name = "RightGrip"

	RightGrip1.Part0 = LocalPlayer.Character:FindFirstChild("RightLowerArm") or LocalPlayer.Character:FindFirstChild("Right Arm")
	RightGrip1.Part1 = Tool.Handle

	RightGrip1.C0 = Position
	RightGrip1.C1 = Tool.Grip

	RightGrip1.Parent = LocalPlayer.Character:FindFirstChild("RightLowerArm") or LocalPlayer.Character:FindFirstChild("Right Arm")

    Tool.Parent = LocalPlayer.Backpack
    Tool.Parent = LocalPlayer.Character.Humanoid
    Tool.Parent = LocalPlayer.Character
    
    Tool.Handle:BreakJoints()

    Tool.Parent = LocalPlayer.Backpack
    Tool.Parent = LocalPlayer.Character.Humanoid

    local RightGrip2 = Instance.new("Weld")
	RightGrip2.Name = "RightGrip"

	RightGrip2.Part0 = LocalPlayer.Character:FindFirstChild("RightLowerArm") or LocalPlayer.Character:FindFirstChild("Right Arm")
	RightGrip2.Part1 = Tool.Handle

	RightGrip2.C0 = Position
	RightGrip2.C1 = Tool.Grip

	RightGrip2.Parent = LocalPlayer.Character:FindFirstChild("RightLowerArm") or LocalPlayer.Character:FindFirstChild("Right Arm")

    return RightGrip2
end

local GetNetlessVelocity = function(PartVelocity)
	if PartVelocity.Y > 1 or PartVelocity.Y < -1 then
		return PartVelocity * (25.1 / PartVelocity.Y)
	end

	PartVelocity = PartVelocity * Vector3.new(1, 0, 1)

	local Magnitude = PartVelocity.Magnitude

	if Magnitude > 1 then
		PartVelocity = PartVelocity * 100 / Magnitude
	end

	return PartVelocity + Vector3.new(0, 26, 0);
end

local Align = function(Part0, Part1, Position, Rotation)
    Part0.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0.0001, 0.0001, 0.0001, 0.0001);
    Part0.CFrame = Part1.CFrame;

    local Attachment0 = Instance.new("Attachment", Part0);

    Attachment0.Orientation = Rotation or Vector3.new(0, 0, 0);
    Attachment0.Position = Position or Vector3.new(0, 0, 0);

    Attachment0.Name = Part0.Name.."_Attachment0";

    local Attachment1 = Instance.new("Attachment", Part1);

    Attachment1.Orientation = Vector3.new(0, 0, 0);
    Attachment1.Position = Position or Vector3.new(0, 0, 0);

    Attachment1.Name = Part1.Name.."_Attachment1";

    local AlignPosition = Instance.new("AlignPosition", Attachment0);
    AlignPosition.ApplyAtCenterOfMass = false;

	AlignPosition.MaxForce = math.huge;
	AlignPosition.MaxVelocity = math.huge;

	AlignPosition.ReactionForceEnabled = false;

	AlignPosition.Responsiveness = 200;

	AlignPosition.Attachment1 = Attachment1;
	AlignPosition.Attachment0 = Attachment0;

	AlignPosition.RigidityEnabled = false;

    local AlignOrientation = Instance.new("AlignOrientation", Attachment0);
	AlignOrientation.MaxAngularVelocity = math.huge;

	AlignOrientation.MaxTorque = math.huge;

	AlignOrientation.PrimaryAxisOnly = false;
	AlignOrientation.ReactionTorqueEnabled = false;

	AlignOrientation.Responsiveness = 200;

	AlignOrientation.Attachment1 = Attachment1;
	AlignOrientation.Attachment0 = Attachment0;

	AlignOrientation.RigidityEnabled = false;

    local Heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
        Part0.Velocity = Vector3.new(30, 0, 0);
    end)

    Part0.Destroying:Connect(function()
        Part0 = nil;

        Heartbeat:Disconnect()
    end)

    Attachment0.Orientation = Rotation or Vector3.new(0, 0, 0);
    Attachment0.Position = Vector3.new(0, 0, 0);

    Attachment1.Orientation = Vector3.new(0, 0, 0);
    Attachment1.Position = Position or Vector3.new(0, 0, 0);

	Part0.CFrame = Part1.CFrame
end

local ReplaceCharacter = function()
    local Char = LocalPlayer.Character
    local Model = Instance.new("Model");
    LocalPlayer.Character = Model
    LocalPlayer.Character = Char
    Model:Destroy()
end

local replaceHumanoid = function()
    local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
    local NewHumanoid = Humanoid:Clone()
    NewHumanoid.Name = "1"

    NewHumanoid.Parent = Humanoid.Parent
    NewHumanoid.Name = Humanoid.Name
    workspace.Camera.CameraSubject = NewHumanoid
    Humanoid:Destroy();
    return NewHumanoid
end

local function isAnchored(Character)
    for _, v in pairs(Character:GetDescendants()) do
        pcall(function()
            if v.Anchored == true then
                return true
            end
        end)
    end

    return false
end

CommandList.ScrollBar.Positioner:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local absoluteSize = CommandList.ScrollBar.Positioner.AbsoluteContentSize
    CommandList.ScrollBar.CanvasSize = UDim2.new(0, absoluteSize.X, 0, absoluteSize.Y + 50)
end)

Admin.Events.InputBegan = UserInputService.InputBegan:Connect(function(Input, ProcessedEvent)
    if ProcessedEvent then
        return
    end

    local KeyCode = tostring(Input.KeyCode):split(".")[3]
    Keys[KeyCode] = true

    if Input.KeyCode == Enum.KeyCode.Semicolon and not Admin.Debounce then
        Admin.Debounce = true;

        local Tweens = {}

        table.insert(Tweens, TweenService:Create(CommandBar, TweenInfo.new(.75, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 1, -100)}))
        table.insert(Tweens, TweenService:Create(CommandBar, TweenInfo.new(.75, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}))
        table.insert(Tweens, TweenService:Create(CommandInput, TweenInfo.new(.75, Enum.EasingStyle.Quint), {TextTransparency = 0}))
        table.insert(Tweens, TweenService:Create(CommandsImage, TweenInfo.new(.75, Enum.EasingStyle.Quint), {ImageTransparency = 0}))
        
        for _, Tween in pairs(Tweens) do
            Tween:Play();
        end

        task.wait();

        CommandInput:CaptureFocus();
    end
end)

Admin.Events.InputEnded = UserInputService.InputEnded:Connect(function(Input, ProcessedEvent)
    if ProcessedEvent then
        return
    end
    
    local KeyCode = tostring(Input.KeyCode):split(".")[3]

    if Keys[KeyCode] then
        Keys[KeyCode] = false
    end
end)

Admin.Events.FocusLost = CommandInput.FocusLost:Connect(function(Enter)
    if Enter then
        local Access = CommandInput.Text

        spawn(function()
            commandCheck(Access, true)
        end)

        local Tweens = {};

        table.insert(Tweens, TweenService:Create(CommandBar, TweenInfo.new(.75, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 1, 35)}))
        table.insert(Tweens, TweenService:Create(CommandBar, TweenInfo.new(.75, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}))
        table.insert(Tweens, TweenService:Create(CommandInput, TweenInfo.new(.75, Enum.EasingStyle.Quint), {TextTransparency = 1}))
        table.insert(Tweens, TweenService:Create(CommandsImage, TweenInfo.new(.75, Enum.EasingStyle.Quint), {ImageTransparency = 1}))
        
        for _, Tween in pairs(Tweens) do
            Tween:Play();
        end

        CommandInput.Text = ""

        task.wait();

        Admin.Debounce = false;
    end
end)

CommandsImage.MouseButton1Click:Connect(function()
    CommandList.Visible = true
    
    local commandsTween = TweenService:Create(CommandList, TweenInfo.new(.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})
    commandsTween:Play()

    commandsTween.Completed:Wait()

    for _, v in ipairs(CommandList.ScrollBar:GetDescendants()) do
        if v.Name == "Container" then
            local TextLabelTween = TweenService:Create(v.TextLabel, TweenInfo.new(.025, Enum.EasingStyle.Quint), {TextTransparency = 0})
            TextLabelTween:Play()

            local DescriptionTween = TweenService:Create(v.TextLabel.Description, TweenInfo.new(.025, Enum.EasingStyle.Quint), {TextTransparency = 0})
            DescriptionTween:Play()

            DescriptionTween.Completed:Wait()
        end
    end
end)

Players.PlayerAdded:Connect(function(Player)
    PlayerAdded(Player);
end)

for _, Player in pairs(Players:GetPlayers()) do
    PlayerAdded(Player);
end

local IntroGuiTweens = {
    ["Headbar"] = "BackgroundTransparency",
    ["MainText"] = "TextTransparency",
    ["TextLabel"] = "TextTransparency",
    ["LoadingBar"] = "BackgroundTransparency",
    ["LoadingBarThing"] = "BackgroundTransparency",
    ["LoadingText"] = "TextTransparency",
    ["Icon"] = "ImageTransparency"
}

Admin.Debounce = false

Admin.Events.LocalPlayerConnection = LocalPlayer.Chatted:Connect(function(Message)
    if string.sub(Message, 1, 1) == Admin.Prefix then
        spawn(function()
            commandCheck(Message, true)
        end)
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge) * math.huge
    pcall(function() sethiddenproperty(LocalPlayer, "SimulationRadius", math.pow(math.huge, math.huge) * math.huge) end)

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer then
            LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge) * math.huge
            pcall(function() settings().Physics.AllowSleep = false ; sethiddenproperty(LocalPlayer, "SimulationRadius", math.pow(math.huge, math.huge) * math.huge) end)
            LocalPlayer.ReplicationFocus = workspace
        end
    end
end)

--commands
Define("commands/cmds", "opens commands menu", function()
    CommandList.Visible = true
    
    local commandsTween = TweenService:Create(CommandList, TweenInfo.new(.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})
    commandsTween:Play()

    commandsTween.Completed:Wait()

    for _, v in ipairs(CommandList.ScrollBar:GetDescendants()) do
        if v.Name == "Container" then
            local TextLabelTween = TweenService:Create(v.TextLabel, TweenInfo.new(.025, Enum.EasingStyle.Quint), {TextTransparency = 0})
            TextLabelTween:Play()

            local DescriptionTween = TweenService:Create(v.TextLabel.Description, TweenInfo.new(.025, Enum.EasingStyle.Quint), {TextTransparency = 0})
            DescriptionTween:Play()

            DescriptionTween.Completed:Wait()
        end
    end
end)

Define("infjump", "makes you infinite jump", function() 
    Admin.Events.infJump = UserInputService.JumpRequest:Connect(function()
        LocalPlayer.Character:FindFirstChild('Humanoid'):ChangeState("Jumping")
    end)
end)

Define("uninfjump", "stops infinite jumping", function() 
    if Admin.Events.infJump then
        Admin.Events.infJump:Disconnect()
    end
end)

Define("jumppower", "set your jump power", function(value) 
    LocalPlayer.Character.Humanoid.JumpPower = value
end, "number")

Define("walkspeed", "set your walk speed", function(value) 
    LocalPlayer.Character.Humanoid.WalkSpeed = value
end, "number")

Define("goto", "teleports you to a player", function(player)
    local Target = getPlayer(player)

    if Target ~= nil then
        for _, v in pairs(Target) do
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = getRoot(v.Character).CFrame
        end
    end
end,"player")

Define("respawnTime", "prints the respwanTime", function(player)
    local Target = getPlayer(player)

    if Target ~= nil then
        for _, v in pairs(Target) do
            print(RespawnTimes[v.Name], v.Name)
        end
    end
end, "player")

Define("kill", "kills a player", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil then
        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - .10)
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
                    
                    AttachTool(Tool, getRoot(v.Character).CFrame:ToObjectSpace(LocalPlayer.Character:FindFirstChild("Right Arm").CFrame):Inverse())

                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            end
        end

        LocalPlayer.Character.Humanoid:ChangeState(15);
        LocalPlayer.Character = nil;

        LocalPlayer.CharacterAdded:Wait()
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
    end
end, "player")

Define("kill2", "kill but better/worse", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    local Destroy_;

    if Target ~= nil then
        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - .10)
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        if #Target == 1 then
            Destroy_ = true;
        end

        ReplaceCharacter()
        wait(Players.RespawnTime - .5)
        Humanoid = replaceHumanoid()
        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
        
                    AttachTool(Tool, getRoot(v.Character).CFrame:ToObjectSpace(LocalPlayer.Character:FindFirstChild("Right Arm").CFrame):Inverse())

                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end

            end
        end

        Humanoid:ChangeState(15)
        if (Destroy_) then
            wait(.2);
            ReplaceCharacter();
        end

        LocalPlayer.CharacterAdded:Wait()
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
    end
end, "player")

Define("bring", "brings a player", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    local TWait;

    if Target ~= nil then
        if #Target == 1 then
            TWait = true;
        end

        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - .10)
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    local Weld = AttachTool(Tool, CFrame.new(0, 0, 0))

                    table.insert(Admin.Welds, Weld);
        
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)

                    if TWait then
                        Tool.AncestryChanged:Wait();
                    end
                end
            end
        end

        if not TWait then
            wait(.5);
        end

        for _, Weld in pairs(Admin.Welds) do
            Weld:Destroy()
        end
    end
end, "player")

Define("void", "voids a player", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    local TWait;

    if Target ~= nil then
        if #Target == 1 then
            TWait = true;
        end

        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - .10)
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    local Weld = AttachTool(Tool, CFrame.new(0, workspace.FallenPartsDestroyHeight - LocalPlayer.Character.HumanoidRootPart.Position.Y, 0))

                    table.insert(Admin.Welds, Weld);
        
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)

                    if TWait then
                        Tool.AncestryChanged:Wait();
                    end
                end
            end
        end

        if not TWait then
            wait(.5);
        end

        for _, Weld in pairs(Admin.Welds) do
            Weld:Destroy()
        end
    end
end, "player")

Define("rape", "i don't need to explain this one", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil then
        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - .10)
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        for _, Animation in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
            Animation:Stop()
        end

        local Animation = Instance.new("Animation")
        Animation.AnimationId = "rbxassetid://148840371"

        local LoadedAnimation = LocalPlayer.Character.Humanoid:LoadAnimation(Animation)
        LoadedAnimation.Looped = true

        LoadedAnimation:Play(0)
        LoadedAnimation:AdjustSpeed(5)

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Handle.CanCollide = false;

                    local Weld = AttachTool(Tool, CFrame.new(0.2, 4, 2) * CFrame.Angles(math.rad(90), 0, 0))                

                    v.Character.Humanoid.PlatformStand = true;

                    table.insert(Admin.Welds, Weld);

                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            end
        end
    end
end, "player")

Define("carry", "carries a player", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil then
        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - .10)
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    local Weld = AttachTool(Tool, CFrame.new(1.5, -3, 1) * CFrame.Angles(math.rad(-90), 0, 0))
        
                    v.Character.Humanoid.PlatformStand = true

                    table.insert(Admin.Welds, Weld);

                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            end
        end
    end
end, "player")

Define("dupe/dupetools", "dupes your tools", function(amount)
    for Duped = 1, amount do
        local Tools = {};

        ReplaceCharacter();

        wait(Players.RespawnTime - .10);
            
        local Position = LocalPlayer.Character.HumanoidRootPart.CFrame

        for _, Tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            Tool.Parent = LocalPlayer.Character;
        end

        for _, Tool in pairs(LocalPlayer.Character:GetChildren()) do
            if Tool:IsA("Tool") then
                Tool.Parent = workspace;

                table.insert(Tools, Tool)
            end
        end
    
        LocalPlayer.Character.Humanoid:ChangeState(15);
    
        LocalPlayer.CharacterAdded:Wait()
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

        for _, Tool in pairs(Tools) do
            LocalPlayer.Character.Humanoid:EquipTool(Tool);
        end

        print(Duped)
    end
end, "amount")

Define("fly", "flies your character", function(flyspeed)
    if Admin.Flying == false then
        Admin.Flying = true
        local Character = LocalPlayer.Character

        Character.Humanoid:ChangeState(8)

        local BodyVelocity = Instance.new("BodyVelocity");
        local BodyGyro = Instance.new("BodyGyro");

        BodyVelocity.Parent = Character.HumanoidRootPart;
        BodyGyro.Parent = Character.HumanoidRootPart;

        BodyGyro.P = 9e9;
        BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * 9e9;
        BodyGyro.CFrame = Character.HumanoidRootPart.CFrame;

        BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 9e9;
        BodyVelocity.Velocity = Vector3.new(0, 0.1, 0);

        local Speed = 2;

        if flyspeed then
            Speed = tonumber(flyspeed)
        end

        coroutine.wrap(function()
            while Admin.Flying do
                FlyTable["W"] = Keys["W"] and Speed or 0
                FlyTable["A"] = Keys["A"] and -Speed or 0
                FlyTable["S"] = Keys["S"] and -Speed or 0
                FlyTable["D"] = Keys["D"] and Speed or 0

                if ((FlyTable["W"] + FlyTable["S"]) ~= 0 or (FlyTable["A"] + FlyTable["D"]) ~= 0) then
                    BodyVelocity.Velocity = ((workspace.Camera.CoordinateFrame.lookVector * (FlyTable["W"] + FlyTable["S"])) + ((workspace.Camera.CoordinateFrame * CFrame.new(FlyTable["A"] + FlyTable["D"], (FlyTable["W"] + FlyTable["S"]) * 0.2, 0).p) - workspace.Camera.CoordinateFrame.p)) * 50
                else
                    BodyVelocity.Velocity = Vector3.new(0, 0.1, 0);
                end
                BodyGyro.CFrame = workspace.Camera.CoordinateFrame;
                task.wait();
            end

            BodyVelocity:Destroy()
            BodyGyro:Destroy()
        end)()
    end
end, "speed")

Define("unfly", "stops flying", function()
    if Admin.Flying then
        Admin.Flying = not Admin.Flying;
    end
end)

Define("teleport/tp", "teleports a player to another", function(player, player2)
    local Humanoid
    local Target = getPlayer(player)
    local teleportedTo = getPlayer(player2)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil and teleportedTo ~= nil then
        if #teleportedTo > 1 then
            return "💀"
        else
            teleportedTo = teleportedTo[1]
        end
        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - .10)
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        for i, v in pairs(Target) do
            if v == teleportedTo then
                table.remove(Target, i)
                break
            end
        end

        

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    local Weld = AttachTool(Tool, (getRoot(teleportedTo.Character).CFrame * CFrame.new(0, 2.5, 0)):ToObjectSpace(LocalPlayer.Character.HumanoidRootPart.CFrame):Inverse());
        
                    table.insert(Admin.Welds, Weld);

                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            end
        end
        
        wait(.3)

        for _, Weld in pairs(Admin.Welds) do
            Weld:Destroy()
        end
    end
end, "player, player2")

Define("control", "controls a player", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil then
        if #Target == 1 then
            if RespawnTimes[Target[1].Name] >= RespawnTimes[LocalPlayer.Name] then
                LocalPlayer.Character:Destroy()
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                wait(.15)
            end
        else
            return
        end

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Handle.CanCollide = false;

                    local Weld = AttachTool(Tool, CFrame.new(-1.5, -(100 - (Tool.Handle.Size.Y/2)), 0))

                    table.insert(Admin.Welds, Weld);

                    getRoot(LocalPlayer.Character).CFrame = getRoot(v.Character).CFrame;
                    LocalPlayer.Character.Humanoid.HipHeight = 100;

                    LocalPlayer.Character.Animate.Disabled = true;

                    for _, v in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                        v:Stop()
                    end

                    v.Character.Humanoid.PlatformStand = true;

                    workspace.CurrentCamera.CameraSubject = v.Character.Humanoid;
        
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            end
        end
    end
end, "player")



Define("view", "views a player", function(player)
    local Target = getPlayer(player)

    if Target ~= nil then
        if #Target > 1 then
            return "💀" -- easter egg
        end

        workspace.CurrentCamera.CameraSubject = Target[1].Character.Humanoid
    end
end, "player")


Define("refresh/re", "refreshes your character", function() 
    ReplaceCharacter();

    wait(Players.RespawnTime - .10)

    local Position = LocalPlayer.Character.HumanoidRootPart.CFrame

    LocalPlayer.Character.Humanoid:ChangeState(15);

    LocalPlayer.CharacterAdded:Wait()
    LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
end)

Define("noclip", "noclips your character", function()
    Admin.Events.Noclip = game:GetService("RunService").Stepped:Connect(function()
        for _, v in next, LocalPlayer.Character:GetChildren() do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end)

    spawn(function()
        LocalPlayer.CharacterAdded:wait()
        if Admin.Events.Noclip then
            Admin.Events.Noclip:Disconnect()
        end
    end)
end)

Define("unnoclip/clip", "clips your character", function()
    if Admin.Events.Noclip then
        Admin.Events.Noclip:Disconnect()
    end
end)

Define("fling", "flings a player", function(player)
    local Target = getPlayer(player)

    if Target ~= nil then

        local oldPos, oldVelocity = LocalPlayer.Character.HumanoidRootPart.CFrame, LocalPlayer.Character.HumanoidRootPart.Velocity

        for _, v in pairs(Target) do
            local vPos = getRoot(v.Character).Position

            local Running = game:GetService("RunService").Stepped:Connect(function(step)
                step = step - workspace.DistributedGameTime

                LocalPlayer.Character.HumanoidRootPart.CFrame = (getRoot(v.Character).CFrame - (Vector3.new(0, 1e6, 0) * step)) + (getRoot(v.Character).Velocity * (step * 30))
                LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1e6, 0)
            end)
            local startTime = tick()

            repeat wait() until (vPos - getRoot(v.Character).Position).magnitude >= 60 or tick() - startTime >= 3.5
            Running:Disconnect()
        end
        local Running = game:GetService("RunService").Stepped:Connect(function()
            LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
            LocalPlayer.Character.HumanoidRootPart.Velocity = oldVelocity
        end)
        wait(.2)
        LocalPlayer.Character.HumanoidRootPart.Anchored = true
        Running:Disconnect()
        LocalPlayer.Character.HumanoidRootPart.Anchored = false
        LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
        LocalPlayer.Character.HumanoidRootPart.Velocity = oldVelocity
    end
end, "player")

Define("van", "kidnaps player", function(player)
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil then
        if #Target == 1 then
            if RespawnTimes[Target[1].Name] >= RespawnTimes[LocalPlayer.Name] then
                LocalPlayer.Character:Destroy()
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                wait(.15)
            end
        else
            return
        end

        for _, v in pairs(Target) do
            print(Target)

            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()
                local Car = LocalPlayer.Character:FindFirstChild("MeshPartAccessory")

                if Tool and Car then
                    Tool.Handle.CanCollide = false;
                    Car.Handle.CanCollide = false;

                    LocalPlayer.Character.Animate.Disabled = true;

                    for _, v in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                        v:Stop()
                    end

                    LocalPlayer.Character.HumanoidRootPart.CFrame = getRoot(v.Character).CFrame * CFrame.new(50, 0, -15)

                    wait(.25);

                    Car.Handle:BreakJoints();

                    Align(Car.Handle, LocalPlayer.Character.HumanoidRootPart, Vector3.new(0, -1.5, 10), Vector3.new(0, -90, 0));

                    local Tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {CFrame = getRoot(v.Character).CFrame * CFrame.new(0, 0, -15);})

                    Tween:Play();
                    Tween.Completed:wait();

                    wait(.5)

                    AttachTool(Tool, (Car.Handle.CFrame:ToObjectSpace(LocalPlayer.Character:FindFirstChild("Right Arm").CFrame) * CFrame.new(0, -1.5, 1.5)):Inverse())

                    v.Character.Humanoid.PlatformStand = true;

                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0);
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1);

                    Tool.AncestryChanged:wait();

                    wait(.15)

                    local Tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(-100, 0, 0);})

                    Tween:Play();
                    Tween.Completed:wait();
                end
            end
        end

        LocalPlayer.Character.Humanoid:ChangeState(15);
        LocalPlayer.Character = nil;
    end
end, "player")

Define("attach", "attaches a player to you", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil then
        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - .10)
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    local Weld = AttachTool(Tool, CFrame.new(0, -1.5, 0) * CFrame.Angles(math.rad(-90), 0, 0))
        
                    v.Character.Humanoid.PlatformStand = true

                    table.insert(Admin.Welds, Weld);

                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            end
        end
    end
end, "player")

Define("releasewelds/rw", "releases welds", function()
    print("here")

    for _, Weld in pairs(Admin.Welds) do
        Weld:Destroy();
    end
end)

Define("nochatlogs", "stops logging", function()
    for _, v in pairs(Admin.Events.ChatLogs) do
        v:Disconnect()
        v = nil
    end
end)

-- end of Admin script

table.sort(Admin.Commands, function(a, b)
    return a[1]:lower() < b[1]:lower()
end)


for _, v in ipairs(Admin.Commands) do
    local clonedContainer = Container:Clone()

    if v[4] then
        clonedContainer.TextLabel.Text = v[1].." { "..v[4].." }"
    else
        clonedContainer.TextLabel.Text = v[1]
    end

    clonedContainer.TextLabel.Description.Text = v[2]
    
    clonedContainer.Parent = CommandList.ScrollBar
end

warn("thanks for using fsd' admin lil boy")

spawn(function()
    repeat game:GetService("RunService").Heartbeat:wait() until not CoreGui:FindFirstChild("UI")

    for i, v in pairs(Admin.Events) do
        pcall(function()
            if v then
                v:Disconnect()
            end
        end)
    end

    Admin = nil
end)
