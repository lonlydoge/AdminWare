local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local InsertService = game:GetService("InsertService")

if (syn) then
    local TranslationSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/lonlydoge/TranslationSystem/main/main.lua"))()
end
local NotificationSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/lonlydoge/NotificationSystem/main/main.lua"))()

for i, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "UI" then
        CoreGui["UI"]:Destroy()
    end
end

warn("Waiting for events to reset")
wait(0.1)

if CoreGui:FindFirstChild("UI") then
    CoreGui["UI"]:Destroy()
end

if ReplicatedStorage:FindFirstChild("Container") then
    ReplicatedStorage["Container"]:Destroy()
end

-- gui loading

local UI = InsertService:LoadLocalAsset("rbxassetid://9625648426"):Clone();

local Container = UI.CommandList.ScrollBar.Container

Container.Parent = ReplicatedStorage

UI.IntroGui:Destroy()

UI.CommandList.BackgroundTransparency = 1
UI.CommandList.Visible = false
Container.TextLabel.TextTransparency = 1
Container.TextLabel.Description.TextTransparency = 1

UI.CommandBar.BackgroundTransparency = 1
UI.CommandBar.TextBox.TextTransparency = 1
UI.CommandBar.ImageButton.ImageTransparency = 1
UI.CommandBar.Position = UDim2.new(0.5, 0, 1, 35)

UI.Parent = game.CoreGui

-- ok it finished :)

local universalAdmin = {
    Commands = {},
    Prefix = ".",
    Events = {ChatLogs = {}},
    Debounce = true,
}

local RespawnTimes = {}

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

repeat task.wait() until universalAdmin["Events"];

local PlayerAdded = function(Player)
    RespawnTimes[Player.Name] = tick();
    universalAdmin.Events[Player] = Player.CharacterAdded:Connect(function()
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
    for i, v in pairs(universalAdmin.Commands) do
        if string.lower(v[1]) == string.lower(commandname) then
            return nil
        end
    end

    if typeof(mainfunction) == "function" then
        if cmdargs then
            table.insert(universalAdmin.Commands, {commandname, description, mainfunction, cmdargs})
        else
            table.insert(universalAdmin.Commands, {commandname, description, mainfunction})
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
        if string.sub(Message, 1, 1) == universalAdmin.Prefix then
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

    for _, v in pairs(universalAdmin.Commands) do
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

local function openCmdBar()
    if not universalAdmin.Debounce then
        universalAdmin.Debounce = true
        
        local openCmdBarTween = TweenService:Create(UI.CommandBar, TweenInfo.new(.75, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 1, -100)})
        local fadeBar = TweenService:Create(UI.CommandBar, TweenInfo.new(.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})
        local fadeText = TweenService:Create(UI.CommandBar.TextBox, TweenInfo.new(.75, Enum.EasingStyle.Quint), {TextTransparency = 0})
        local fadeIcon = TweenService:Create(UI.CommandBar.ImageButton, TweenInfo.new(.75, Enum.EasingStyle.Quint), {ImageTransparency = 0})
        
        openCmdBarTween:Play()
        fadeBar:Play()
        fadeText:Play()
        fadeIcon:Play()
        
        wait(.35)
        
        UI.CommandBar.TextBox:CaptureFocus()
        universalAdmin.Debounce = false
    end
end 

local function closeCmdBar()
    if not universalAdmin.Debounce then
        universalAdmin.Debounce = true
        
        local openCmdBarTween = TweenService:Create(UI.CommandBar, TweenInfo.new(.75, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 1, 35)})
        local fadeBar = TweenService:Create(UI.CommandBar, TweenInfo.new(.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 1})
        local fadeText = TweenService:Create(UI.CommandBar.TextBox, TweenInfo.new(.75, Enum.EasingStyle.Quint), {TextTransparency = 1})
        local fadeIcon = TweenService:Create(UI.CommandBar.ImageButton, TweenInfo.new(.75, Enum.EasingStyle.Quint), {ImageTransparency = 1})
        
        openCmdBarTween:Play()
        fadeBar:Play()
        fadeText:Play()
        fadeIcon:Play()
        
        wait(.35)
        
        universalAdmin.Debounce = false
    end
end

local cframeTool = function(tool, pos)
    local RightArm = LocalPlayer.Character:FindFirstChild("RightLowerArm") or LocalPlayer.Character:FindFirstChild("Right Arm")
    local Arm = RightArm.CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
    local Frame = Arm:ToObjectSpace(pos):Inverse()

    tool.Grip = Frame
end

local AttachTool = function(Tool, Position)
    for _, Object in pairs(Tool:GetDescendants()) do
        if not (Object:IsA("BasePart") or Object:IsA("Mesh") or Object:IsA("SpecialMesh")) then
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

local ReplaceCharacter = function()
    NotificationSystem.Notify("Replacing Character...", 5)

    local Char = LocalPlayer.Character
    local Model = Instance.new("Model");
    LocalPlayer.Character = Model
    LocalPlayer.Character = Char
    Model:Destroy()
end

local replaceHumanoid = function()
    NotificationSystem.Notify("Replacing Humanoid...", 5)

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

UI.CommandList.ScrollBar.Positioner:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local absoluteSize = UI.CommandList.ScrollBar.Positioner.AbsoluteContentSize
    UI.CommandList.ScrollBar.CanvasSize = UDim2.new(0, absoluteSize.X, 0, absoluteSize.Y + 50)
end)

universalAdmin.Events.prefixTrigger = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not universalAdmin.Debounce then
        if gameProcessedEvent then
            return
        elseif input.KeyCode == Enum.KeyCode.Semicolon then
            openCmdBar()
        end
    end
end)

UI.CommandBar.TextBox.FocusLost:Connect(function(Enter)
    if not universalAdmin.Debounce and Enter then
        spawn(function()
            commandCheck(UI.CommandBar.TextBox.Text, true)
        end)
        closeCmdBar()
        UI.CommandBar.TextBox.Text = ""
    end
end)

UI.CommandBar.ImageButton.MouseButton1Click:Connect(function()
    spawn(closeCmdBar)
    
    UI.CommandList.Visible = true
    
    local commandsTween = TweenService:Create(UI.CommandList, TweenInfo.new(.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})
    commandsTween:Play()

    commandsTween.Completed:Wait()

    for _, v in ipairs(UI.CommandList.ScrollBar:GetDescendants()) do
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

universalAdmin.Debounce = false

universalAdmin.Events.LocalPlayerConnection = LocalPlayer.Chatted:Connect(function(Message)
    if string.sub(Message, 1, 1) == universalAdmin.Prefix then
        commandCheck(Message)
    end
end)

--commands
Define("commands/cmds", "opens commands menu", function()
    UI.CommandList.Visible = true
    
    local commandsTween = TweenService:Create(UI.CommandList, TweenInfo.new(.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})
    commandsTween:Play()

    commandsTween.Completed:Wait()

    for _, v in ipairs(UI.CommandList.ScrollBar:GetDescendants()) do
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
    universalAdmin.Events.infJump = UserInputService.JumpRequest:Connect(function()
        LocalPlayer.Character:FindFirstChild('Humanoid'):ChangeState("Jumping")
    end)
end)

Define("uninfjump", "stops infinite jumping", function() 
    if universalAdmin.Events.infJump then
        universalAdmin.Events.infJump:Disconnect()
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

                wait(Players.RespawnTime - (1 / 60))
            
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
            else
                NotificationSystem.Notify(v.Name.." could not be killed ", 5)
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

                wait(Players.RespawnTime - (1 / 60))
            
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
            else
                NotificationSystem.Notify(v.Name.." could not be killed ", 5)
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

    if Target ~= nil then
        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - (1 / 60))
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        local Welds = {};

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    local Weld = AttachTool(Tool, CFrame.new(0, 0, 0))

                    table.insert(Welds, Weld);
        
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            else
                NotificationSystem.Notify(v.Name.." could not be bringed ", 5)
            end
        end

        wait(.3);

        for _, Weld in pairs(Welds) do
            Weld:Destroy()
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

                wait(Players.RespawnTime - (1 / 60))
            
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

                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            else
                NotificationSystem.Notify(v.Name.." could not be bringed ", 5)
            end
        end
    end
end, "player")

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

                wait(Players.RespawnTime - (1 / 60))
            
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

        local Welds = {};

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    local Weld = AttachTool(Tool, (getRoot(teleportedTo.Character).CFrame * CFrame.new(0, 2.5, 0)):ToObjectSpace(LocalPlayer.Character.HumanoidRootPart.CFrame):Inverse());
        
                    table.insert(Welds, Weld);

                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            else
                NotificationSystem.Notify(v.Name.." could not be teleported ", 5)
            end
        end
        
        wait(.3)

        for _, Weld in pairs(Welds) do
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

        local Welds = {};

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Handle.CanCollide = false;

                    local Weld = AttachTool(Tool, CFrame.new(-1.5, -(100 - (Tool.Handle.Size.Y/2)), 0))

                    table.insert(Welds, Weld);

                    getRoot(LocalPlayer.Character).CFrame = getRoot(v.Character).CFrame;
                    LocalPlayer.Character.Humanoid.HipHeight = 100;

                    LocalPlayer.Character.Animate.Disabled = true;

                    v.Character.Humanoid.PlatformStand = true;

                    workspace.CurrentCamera.CameraSubject = v.Character.Humanoid;
        
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)
                end
            else
                NotificationSystem.Notify(v.Name.." could not be bringed ", 5)
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

    wait(Players.RespawnTime - (1 / 60))

    local Position = LocalPlayer.Character.HumanoidRootPart.CFrame

    LocalPlayer.Character.Humanoid:ChangeState(15);

    LocalPlayer.CharacterAdded:Wait()
    LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
end)

Define("noclip", "noclips your character", function()
    universalAdmin.Events.Noclip = game:GetService("RunService").Stepped:Connect(function()
        for _, v in next, LocalPlayer.Character:GetChildren() do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end)

    spawn(function()
        LocalPlayer.CharacterAdded:wait()
        if universalAdmin.Events.Noclip then
            universalAdmin.Events.Noclip:Disconnect()
            NotificationSystem.Notify("Noclip disabled", 5)
        end
    end)
end)

Define("unnoclip/clip", "clips your character", function()
    if universalAdmin.Events.Noclip then
        universalAdmin.Events.Noclip:Disconnect()
    end
end)

Define("fling", "flings a player", function(player)
    local Target = getPlayer(player)

    if Target ~= nil then

        local oldPos, oldVelocity = LocalPlayer.Character.HumanoidRootPart.CFrame, LocalPlayer.Character.HumanoidRootPart.Velocity

        for _, v in pairs(Target) do
            local vPos = getRoot(v.Character).Position

            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Running = game:GetService("RunService").Stepped:Connect(function(step)
                    step = step - workspace.DistributedGameTime

                    LocalPlayer.Character.HumanoidRootPart.CFrame = (getRoot(v.Character).CFrame - (Vector3.new(0, 1e6, 0) * step)) + (getRoot(v.Character).Velocity * (step * 30))
                    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1e6, 0)
                end)
                local startTime = tick()

                repeat wait() until (vPos - getRoot(v.Character).Position).magnitude >= 60 or tick() - startTime >= 3.5
                Running:Disconnect()
            else
                NotificationSystem.Notify(v.Name.." could not be flung ", 5)
            end
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

Define("toolfling", "flings a player using a tool", function(player)
    local Target = getPlayer(player)

    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    if Target ~= nil then
        for _, v in pairs(Target) do
            if RespawnTimes[v.Name] >= RespawnTimes[LocalPlayer.Name] then
                ReplaceCharacter();

                wait(Players.RespawnTime - (1 / 60))
            
                local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
            
                LocalPlayer.Character.Humanoid:ChangeState(15);
            
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position

                break
            end
        end

        local newHumanoid = replaceHumanoid()

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] < RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Parent = LocalPlayer.Character
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
        
                    cframeTool(Tool, getRoot(v.Character).CFrame)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 0)
                    firetouchinterest(getRoot(v.Character), Tool.Handle, 1)

                    repeat game:GetService("RunService").Stepped:Wait() until Tool.Parent ~= LocalPlayer.Character
                end
            else
                NotificationSystem.Notify(v.Name.." could not be flung ", 5)
            end
        end

        local Running = game:GetService("RunService").Stepped:Connect(function()
            LocalPlayer.Character.HumanoidRootPart.Velocity = LocalPlayer.Character.HumanoidRootPart.Velocity * LocalPlayer.Character.HumanoidRootPart.Velocity
        end)

        wait(2.5);
        LocalPlayer.Character:Destroy()

        LocalPlayer.CharacterAdded:Wait()
        Running:Disconnect()

        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
    end
end, "player")

Define("chatlogs", "logs chat", function()
    NotificationSystem.Notify("Starting to log messages...", 5)

    local Has_Synapse = false;

    if (syn) then
        Has_Synapse = true;
        NotificationSystem.Notify("You have synapse x! Translation will be enabled.", 5)
    else
        NotificationSystem.Notify("You don't have synapse x! Translation will be disabled.", 5)
        NotificationSystem.Notify("We're currently searching for a method that isn't syn x only.", 5)
    end

    Players.PlayerAdded:Connect(function(Player)
        universalAdmin.Events.ChatLogs[Player.Name] = Player.Chatted:Connect(function(Message)
            if Has_Synapse then
                NotificationSystem.Notify("<"..Player.Name.."> "..TranslationSystem.translateFrom(Message), 5)
            else
                NotificationSystem.Notify("<"..Player.Name.."> "..Message, 5)
            end
        end)
    end)

    for _, Player in pairs(Players:GetPlayers()) do
        universalAdmin.Events.ChatLogs[Player.Name] = Player.Chatted:Connect(function(Message)
            if Has_Synapse then
                NotificationSystem.Notify("<"..Player.Name.."> "..TranslationSystem.translateFrom(Message), 5)
            else
                NotificationSystem.Notify("<"..Player.Name.."> "..Message, 5)
            end
        end)
    end
end)

Define("nochatlogs", "stops logging", function()
    for _, v in pairs(universalAdmin.Events.ChatLogs) do
        v:Disconnect()
        v = nil
    end
    NotificationSystem.Notify("Stopped logging messages", 5)
end)

-- end of Admin script

NotificationSystem.Notify("You are ready to go!", 5)

table.sort(universalAdmin.Commands, function(a, b)
    return a[1]:lower() < b[1]:lower()
end)


for _, v in ipairs(universalAdmin.Commands) do
    local clonedContainer = Container:Clone()

    if v[4] then
        clonedContainer.TextLabel.Text = v[1].." { "..v[4].." }"
    else
        clonedContainer.TextLabel.Text = v[1]
    end

    clonedContainer.TextLabel.Description.Text = v[2]
    
    clonedContainer.Parent = UI.CommandList.ScrollBar
end

spawn(function()
    repeat game:GetService("RunService").Heartbeat:wait() until not CoreGui:FindFirstChild("UI")

    for i, v in pairs(universalAdmin.Events) do
        pcall(function()
            if v then
                v:Disconnect()
            end
        end)
    end

    universalAdmin = nil
end)
