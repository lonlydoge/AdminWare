local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local TranslationSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/lonlydoge/TranslationSystem/main/main.lua"))()
local NotificationSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/lonlydoge/NotificationSystem/main/main.lua"))()

for i, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "UI" then
        CoreGui["UI"]:Destroy()
    end
end

warn("Waiting for events to reset")
wait(0.1)

-- gui loading

local UI = Instance.new("ScreenGui")
local IntroGui = Instance.new("Frame")
local Headbar = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local UICorner = Instance.new("UICorner")
local MainText = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local LoadingText = Instance.new("TextLabel")
local UIGradient_2 = Instance.new("UIGradient")
local LoadingBar = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local LoadingBarThing = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local UIGradient_3 = Instance.new("UIGradient")
local CommandBar = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local Frame = Instance.new("Frame")
local UIGradient_4 = Instance.new("UIGradient")
local TextBox = Instance.new("TextBox")
local CommandList = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local ScrollBar = Instance.new("ScrollingFrame")
local UICorner_7 = Instance.new("UICorner")
local Positioner = Instance.new("UIListLayout")
local Container = Instance.new("Frame")
local Text = Instance.new("Frame")
local UIGradient_5 = Instance.new("UIGradient")
local TextLabel_2 = Instance.new("TextLabel")
local CommandsLabel = Instance.new("TextLabel")

--Properties:

UI.Name = "UI"
UI.Parent = CoreGui

IntroGui.Name = "IntroGui"
IntroGui.Parent = UI
IntroGui.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
IntroGui.AnchorPoint = Vector2.new(0.5, 0.5)
IntroGui.Position = UDim2.new(0.5, 0, 0.5, 0)
IntroGui.Size = UDim2.new(0, 617, 0, 370)
IntroGui.Visible = true

Headbar.Name = "Headbar"
Headbar.Parent = IntroGui
Headbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Headbar.BorderSizePixel = 0
Headbar.ClipsDescendants = true
Headbar.Size = UDim2.new(0, 617, 0, 40)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(115, 0, 255))}
UIGradient.Parent = Headbar

UICorner.Parent = Headbar

MainText.Name = "MainText"
MainText.Parent = Headbar
MainText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainText.BackgroundTransparency = 1.000
MainText.Position = UDim2.new(0.0145867094, 0, 0.230769232, 0)
MainText.Size = UDim2.new(0, 598, 0, 21)
MainText.Font = Enum.Font.GothamSemibold
MainText.Text = "AdminWare"
MainText.TextColor3 = Color3.fromRGB(255, 255, 255)
MainText.TextScaled = true
MainText.TextSize = 14.000
MainText.TextWrapped = true

UICorner_2.Parent = IntroGui

TextLabel.Parent = IntroGui
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.335991532, 0, 0.406196088, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 30)
TextLabel.Font = Enum.Font.GothamSemibold
TextLabel.Text = "Welcome, "..LocalPlayer.Name
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

LoadingText.Name = "LoadingText"
LoadingText.Parent = TextLabel
LoadingText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.BackgroundTransparency = 1.000
LoadingText.Position = UDim2.new(0.0421150215, 0, 0.774775207, 0)
LoadingText.Size = UDim2.new(0, 184, 0, 16)
LoadingText.Font = Enum.Font.GothamSemibold
LoadingText.Text = "Loading..."
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextScaled = true
LoadingText.TextSize = 14.000
LoadingText.TextWrapped = true

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(142, 3, 255))}
UIGradient_2.Parent = LoadingText

LoadingBar.Name = "LoadingBar"
LoadingBar.Parent = TextLabel
LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingBar.Position = UDim2.new(-0.494959503, 0, 1.60090089, 0)
LoadingBar.Size = UDim2.new(0, 397, 0, 14)

UICorner_3.CornerRadius = UDim.new(0, 4)
UICorner_3.Parent = LoadingBar

LoadingBarThing.Name = "LoadingBarThing"
LoadingBarThing.Parent = LoadingBar
LoadingBarThing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingBarThing.Size = UDim2.new(0, 8, 0, 14)

UICorner_4.CornerRadius = UDim.new(0, 4)
UICorner_4.Parent = LoadingBarThing

UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(115, 0, 255))}
UIGradient_3.Parent = LoadingBarThing

CommandBar.Name = "CommandBar"
CommandBar.Parent = UI
CommandBar.AnchorPoint = Vector2.new(0.5, 0.5)
CommandBar.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
CommandBar.AnchorPoint = Vector2.new(0.5, 0.5)
CommandBar.Visible = true
CommandBar.Size = UDim2.new(0, 529, 0, 44)
CommandBar.Position = UDim2.new(0.5, 0, 1, CommandBar.Size.Y.Offset)
CommandBar.BackgroundTransparency = 1

UICorner_5.Parent = CommandBar

Frame.Parent = CommandBar
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.0359168239, 0, 0.75, 0)
Frame.Size = UDim2.new(0, 491, 0, 2)

UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(115, 0, 255))}
UIGradient_4.Parent = Frame

TextBox.Parent = CommandBar
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.0359168239, 0, 0.227272734, 0)
TextBox.Size = UDim2.new(0, 491, 0, 20)
TextBox.Font = Enum.Font.Gotham
TextBox.PlaceholderColor3 = Color3.fromRGB(214, 214, 214)
TextBox.PlaceholderText = "Enter A Command"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextScaled = true
TextBox.TextSize = 14.000
TextBox.TextWrapped = true

CommandList.Name = "CommandList"
CommandList.Parent = UI
CommandList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CommandList.Position = UDim2.new(-0.1, 0, 0.5, 0)
CommandList.AnchorPoint = Vector2.new(0.5, 0.5)
CommandList.Size = UDim2.new(0, 285, 0, 364)
CommandList.Visible = true
CommandList.Draggable = true
CommandList.Active = true

UICorner_6.Parent = CommandList

CommandsLabel.Name = "CommandsLabel"
CommandsLabel.Parent = CommandList
CommandsLabel.BackgroundTransparency = 1
CommandsLabel.Font = "Gotham"
CommandsLabel.Position = UDim2.new(0.5, 0, 0, 15)
CommandsLabel.AnchorPoint = Vector2.new(0.5, 0.5)
CommandsLabel.Size = UDim2.new(0, 142, 0, 20)
CommandsLabel.TextScaled = true
CommandsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandsLabel.Text = "Commands"

ScrollBar.Name = "ScrollBar"
ScrollBar.Parent = CommandList
ScrollBar.Active = true
ScrollBar.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
ScrollBar.BorderColor3 = Color3.fromRGB(27, 42, 53)
ScrollBar.Position = UDim2.new(0.0566437244, 0, 0.0875975192, 0)
ScrollBar.Size = UDim2.new(0, 251, 0, 302)
ScrollBar.ScrollBarThickness = 10

UICorner_7.Parent = ScrollBar

Positioner.Name = "Positioner"
Positioner.Parent = ScrollBar
Positioner.SortOrder = Enum.SortOrder.LayoutOrder
Positioner.Padding = UDim.new(0, 25)

Container.Name = "Container"
Container.Parent = ReplicatedStorage
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.BackgroundTransparency = 1.000
Container.Position = UDim2.new(0.100202426, 0, 0.456260651, 0)
Container.Size = UDim2.new(0, 228, 0, 36)

Text.Name = "Text"
Text.Parent = Container
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BorderSizePixel = 0
Text.Position = UDim2.new(-0.000183045864, 0, 0.939203858, 0)
Text.Size = UDim2.new(0, 228, 0, 2)

UIGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(115, 0, 255))}
UIGradient_5.Parent = Text

TextLabel_2.Parent = Text
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(-0.000743053854, 0, -13.8056335, 0)
TextLabel_2.Size = UDim2.new(0, 200, 0, 21)
TextLabel_2.Font = Enum.Font.Gotham
TextLabel_2.Text = "Cmd"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left


-- ok it finished :)

local universalAdmin = {
    Commands = {},
    Prefix = ".",
    Events = {ChatLogs = {}},
    Debounce = true,
}

local RespawnTimes = {}

coroutine.wrap(function()
    local function doIt()
        Players.PlayerAdded:Connect(function(Player)
            Player.CharacterAdded:Wait()

            spawn(function()
                RespawnTimes[Player.Name] = 0
                
                universalAdmin.Events[Player.Name] = Player.CharacterAdded:Connect(function()
                    RespawnTimes[Player.Name] = 0
                    Player.Character:WaitForChild("Humanoid")
                    while Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead do
                        RespawnTimes[Player.Name] = RespawnTimes[Player.Name] + 0.02
                        if universalAdmin == nil then
                            return
                        end
                        wait(0.01)
                    end
                end)
                RespawnTimes[Player.Name] = 0
                Player.Character:WaitForChild("Humanoid")
                while Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead do
                    RespawnTimes[Player.Name] = RespawnTimes[Player.Name] + 0.02
                    if universalAdmin == nil then
                        return
                    end
                    wait(0.01)
                end
            end)
        end)

        for _, Player in pairs(Players:GetPlayers()) do
            spawn(function()
                RespawnTimes[Player.Name] = 0

                universalAdmin.Events[Player.Name] = Player.CharacterAdded:Connect(function()
                    RespawnTimes[Player.Name] = 0
                    Player.Character:WaitForChild("Humanoid")
                    while Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead do
                        RespawnTimes[Player.Name] = RespawnTimes[Player.Name] + 0.02
                        if universalAdmin == nil then
                            return
                        end
                        wait(0.01)
                    end
                end)
                RespawnTimes[Player.Name] = 0
                Player.Character:WaitForChild("Humanoid")
                while Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead do
                    RespawnTimes[Player.Name] = RespawnTimes[Player.Name] + 0.02
                    if universalAdmin == nil then
                        return
                    end
                    wait(0.01)
                end
            end)
        end
    end

    doIt()
end)()

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

local function getTool()
    for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v:FindFirstChild("Handle") and v:IsA("Tool") then
            return v
        end
    end

    return nil
end

local function addCommand(commandname, description, mainfunction, cmdargs)
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
        local openCmdBarTween = TweenService:Create(CommandBar, TweenInfo.new(.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 1, -(CommandBar.Size.Y.Offset * 2))})
        local fadeText = TweenService:Create(CommandBar, TweenInfo.new(.7), {BackgroundTransparency = 0})
        openCmdBarTween:Play()
        fadeText:Play()
        wait(.35)
        TextBox:CaptureFocus()
        universalAdmin.Debounce = false
    end
end 

local function closeCmdBar()
    if not universalAdmin.Debounce then
        universalAdmin.Debounce = true
        local closeCmdBarTween = TweenService:Create(CommandBar, TweenInfo.new(.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 1, CommandBar.Size.Y.Offset)})
        local fadeText = TweenService:Create(CommandBar, TweenInfo.new(.7), {BackgroundTransparency = 1})
        closeCmdBarTween:Play()
        fadeText:Play()
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

Positioner:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local absoluteSize = Positioner.AbsoluteContentSize
    ScrollBar.CanvasSize = UDim2.new(0, absoluteSize.X, 0, absoluteSize.Y + 25)
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

TextBox.FocusLost:Connect(function(Enter)
    if not universalAdmin.Debounce and Enter then
        spawn(function()
            commandCheck(TextBox.Text, true)
        end)
        closeCmdBar()
        TextBox.Text = ""
    end
end)

local OpeningTween = TweenService:Create(LoadingBarThing, TweenInfo.new(5), {Size = UDim2.new(0, 397, 0, 14)})
OpeningTween:Play()
OpeningTween.Completed:wait()

LoadingText.Text = "Loaded!"
wait(1.5)

local ClosingTween = TweenService:Create(IntroGui, TweenInfo.new(1), {Size = UDim2.new(0, 0, IntroGui.Size.Y.Scale, IntroGui.Size.Y.Offset)})
ClosingTween:Play()

for i, v in pairs(IntroGui:GetDescendants()) do
    if not v:IsA("UICorner") and not v:IsA("UIGradient") then
        local ClosingTween = TweenService:Create(v, TweenInfo.new(1), {Size = UDim2.new(0, 0, v.Size.Y.Scale, v.Size.Y.Offset)})
        ClosingTween:Play()
    end
end
wait(1)
IntroGui:Destroy()

universalAdmin.Debounce = false

universalAdmin.Events.LocalPlayerConnection = LocalPlayer.Chatted:Connect(function(Message)
    if string.sub(Message, 1, 1) == universalAdmin.Prefix then
        commandCheck(Message)
    end
end)

--commands
addCommand("commands/cmds", "opens commands menu", function()
    local commandsTween = TweenService:Create(CommandList, TweenInfo.new(.75, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {Position = UDim2.new(0.1, 0, 0.5, 0)})
    commandsTween:Play()
end)

addCommand("infjump", "makes you infinite jump", function() 
    universalAdmin.Events.infJump = UserInputService.JumpRequest:Connect(function()
        LocalPlayer.Character:FindFirstChild('Humanoid'):ChangeState("Jumping")
    end)
end)

addCommand("uninfjump", "stops infinite jumping", function() 
    if universalAdmin.Events.infJump then
        universalAdmin.Events.infJump:Disconnect()
    end
end)

addCommand("jumppower", "set your jump power", function(value) 
    LocalPlayer.Character.Humanoid.JumpPower = value
end, "number")

addCommand("walkspeed", "set your walk speed", function(value) 
    LocalPlayer.Character.Humanoid.WalkSpeed = value
end, "number")

addCommand("notify/notification", "roblox notification", function(title, message, duration) 
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = message;
        Duration = duration;
    })
end, "title, message, duration")


addCommand("goto", "teleports you to a player", function(player)
    local Target = getPlayer(player)

    if Target ~= nil then
        for i, v in pairs(Target) do
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.Character.HumanoidRootPart.CFrame
        end
    end
end,"player")

addCommand("respawnTime", "prints the respwanTime", function(player)
    local Target = getPlayer(player)

    if Target ~= nil then
        for _, v in pairs(Target) do
            print(RespawnTimes[v.Name], v.Name)
        end
    end
end, "player")

addCommand("kill", "kills a player", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil then
        if #Target == 1 then
            if RespawnTimes[Target[1].Name] <= RespawnTimes[LocalPlayer.Name] then
                LocalPlayer.Character:Destroy()
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
            end
        else
            LocalPlayer.Character:Destroy()
            LocalPlayer.CharacterAdded:Wait()
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
        end

        Humanoid = replaceHumanoid()
        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] > RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Parent = LocalPlayer.Character
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
        
                    cframeTool(Tool, v.Character.HumanoidRootPart.CFrame)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 0)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 1)
                end
            else
                NotificationSystem.Notify(v.Name.." could not be killed ", 5)
            end
        end

        Humanoid:ChangeState(15)
        wait(.3)
        LocalPlayer.Character:Destroy()
        LocalPlayer.CharacterAdded:Wait()
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
    end
end, "player")

addCommand("kill2", "kill but better/worse", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    local Destroy_;

    if Target ~= nil then
        if #Target == 1 then
            Destroy_ = true
            if RespawnTimes[Target[1].Name] <= RespawnTimes[LocalPlayer.Name] then
                LocalPlayer.Character:Destroy()
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
            end
        else
            LocalPlayer.Character:Destroy()
            LocalPlayer.CharacterAdded:Wait()
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
        end

        ReplaceCharacter()
        wait(Players.RespawnTime - .5)
        Humanoid = replaceHumanoid()
        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] > RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Parent = LocalPlayer.Character
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
        
                    cframeTool(Tool, v.Character.HumanoidRootPart.CFrame)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 0)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 1)
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


addCommand("bring", "brings a player but better/worse", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil then
        if #Target == 1 then
            if RespawnTimes[Target[1].Name] <= RespawnTimes[LocalPlayer.Name] then
                LocalPlayer.Character:Destroy()
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
            end
        else
            LocalPlayer.Character:Destroy()
            LocalPlayer.CharacterAdded:Wait()
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
        end

        Humanoid = replaceHumanoid()
        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] > RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Parent = LocalPlayer.Character
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
        
                    cframeTool(Tool, LocalPlayer.Character.HumanoidRootPart.CFrame)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 0)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 1)
                end
            else
                NotificationSystem.Notify(v.Name.." could not be bringed ", 5)
            end
        end

        wait(.3)
        LocalPlayer.Character:Destroy()
        LocalPlayer.CharacterAdded:Wait()
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
    end
end, "player")

addCommand("bring2", "brings a player", function(player)
    local Humanoid
    local Target = getPlayer(player)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    local Destroy_;

    if Target ~= nil then
        if #Target == 1 then
            Destroy_ = true
            if RespawnTimes[Target[1].Name] <= RespawnTimes[LocalPlayer.Name] then
                LocalPlayer.Character:Destroy()
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
            end
        else
            LocalPlayer.Character:Destroy()
            LocalPlayer.CharacterAdded:Wait()
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
        end

        ReplaceCharacter()
        wait(Players.RespawnTime - .5)
        Humanoid = replaceHumanoid()
        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] > RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Parent = LocalPlayer.Character
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
        
                    cframeTool(Tool, LocalPlayer.Character.HumanoidRootPart.CFrame)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 0)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 1)
                end
            else
                NotificationSystem.Notify(v.Name.." could not be bringed ", 5)
            end
        end

        if (Destroy_) then
            wait(.2)
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, workspace.FallenPartsDestroyHeight + 50, 0)
            LocalPlayer.Character:Destroy()
        end
        LocalPlayer.CharacterAdded:Wait()
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
    end
end, "player")

addCommand("teleport/tp", "teleports a player to another", function(player, player2)
    local Humanoid
    local Target = getPlayer(player)
    local teleportedTo = getPlayer(player2)
    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame

    if Target ~= nil and teleportedTo ~= nil then
        if #teleportedTo > 1 then
            return "💀" -- easter egg
        else
            teleportedTo = teleportedTo[1]
        end
        if #Target == 1 then
            if RespawnTimes[Target[1].Name] <= RespawnTimes[LocalPlayer.Name] then
                LocalPlayer.Character:Destroy()
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
            end
        else
            LocalPlayer.Character:Destroy()
            LocalPlayer.CharacterAdded:Wait()
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
        end

        for i, v in pairs(Target) do
            if v == teleportedTo then
                table.remove(Target, i)
                break
            end
        end


        Humanoid = replaceHumanoid()
        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] > RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Parent = LocalPlayer.Character
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
        
                    cframeTool(Tool, teleportedTo.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 0)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 1)
                end
            else
                NotificationSystem.Notify(v.Name.." could not be teleported ", 5)
            end
        end
        
        wait(.3)
        LocalPlayer.Character:Destroy()
        LocalPlayer.CharacterAdded:Wait()
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
    end
end, "player, player2")

addCommand("view", "views a player", function(player)
    local Target = getPlayer(player)

    if Target ~= nil then
        if #Target > 1 then
            return "💀" -- easter egg
        end

        workspace.CurrentCamera.CameraSubject = Target[1].Character.Humanoid
    end
end, "player")


addCommand("refresh/re", "refreshes your character", function() 
    local Character = LocalPlayer.Character
    local Position = LocalPlayer.Character.HumanoidRootPart.CFrame
    Character:Destroy()

    LocalPlayer.CharacterAdded:Wait()
    LocalPlayer.Character.HumanoidRootPart.CFrame = Position
end)

addCommand("noclip", "noclips your character", function()
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

addCommand("unnoclip/clip", "clips your character", function()
    if universalAdmin.Events.Noclip then
        universalAdmin.Events.Noclip:Disconnect()
    end
end)

addCommand("sink", "sinks a player", function(player)
    local Target = getPlayer(player)

    Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    if Target ~= nil then
        if #Target == 1 then
            if RespawnTimes[Target[1].Name] <= RespawnTimes[LocalPlayer.Name] then
                LocalPlayer.Character:Destroy()
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
            end
        else
            LocalPlayer.Character:Destroy()
            LocalPlayer.CharacterAdded:Wait()
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
        end

        replaceHumanoid()
        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] > RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Parent = LocalPlayer.Character
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
        
                    cframeTool(Tool, v.Character.HumanoidRootPart.CFrame)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 0)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 1)
                end
            else
                NotificationSystem.Notify(v.Name.." could not be sunk ", 5)
            end
        end

        local sinkTween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -20, 0)})
        sinkTween:Play()

        LocalPlayer.CharacterAdded:Wait()
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
    end
end, "player")

addCommand("fling", "flings a player", function(player)
    local Target = getPlayer(player)

    if Target ~= nil then

        local oldPos, oldVelocity = LocalPlayer.Character.HumanoidRootPart.CFrame, LocalPlayer.Character.HumanoidRootPart.Velocity

        for _, v in pairs(Target) do
            local vPos = v.Character.HumanoidRootPart.Position

            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Running = game:GetService("RunService").Stepped:Connect(function(step)
                    step = step - workspace.DistributedGameTime

                    LocalPlayer.Character.HumanoidRootPart.CFrame = (v.Character.HumanoidRootPart.CFrame - (Vector3.new(0, 1e6, 0) * step)) + (v.Character.HumanoidRootPart.Velocity * (step * 30))
                    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1e6, 0)
                end)
                local startTime = tick()

                repeat wait() until (vPos - v.Character.HumanoidRootPart.Position).magnitude >= 60 or tick() - startTime >= 3.5
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

addCommand("toolfling", "flings a player using a tool", function(player)
    local Target = getPlayer(player)

    local Position = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    if Target ~= nil then
        if #Target == 1 then
            if RespawnTimes[Target[1].Name] <= RespawnTimes[LocalPlayer.Name] then
                LocalPlayer.Character:Destroy()
                LocalPlayer.CharacterAdded:Wait()
                LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
            end
        else
            LocalPlayer.Character:Destroy()
            LocalPlayer.CharacterAdded:Wait()
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position
        end

        local newHumanoid = replaceHumanoid()

        for _, v in pairs(Target) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and (not v.Character.Humanoid.Sit) and (RespawnTimes[v.Name] > RespawnTimes[LocalPlayer.Name]) and (not isAnchored(v.Character)) and (v.Character:FindFirstChild("Humanoid")) then
                local Tool = getTool()

                if Tool then
                    Tool.Parent = LocalPlayer.Character
                    Tool.Handle.Size = Vector3.new(4, 4, 4)
        
                    cframeTool(Tool, v.Character.HumanoidRootPart.CFrame)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 0)
                    firetouchinterest(Tool.Handle, v.Character.HumanoidRootPart, 1)

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

addCommand("chatlogs", "logs chat", function()
    NotificationSystem.Notify("Starting to log messages...", 5)

    local Has_Synapse = false;

    if (syn) then
        Has_Synapse = true;
        NotificationSystem.Notify("You have synapse x! Translation will be enabled.", 5)
    else
        NotificationSystem.Notify("You don't have synapse x! Translation will be disabled.", 5)
    end

    Players.PlayerAdded:Connect(function(Player)
        universalAdmin.Events.ChatLogs[Player.Name] = Player.Chatted:Connect(function(Message)
            if (syn) then
                NotificationSystem.Notify("<"..Player.Name.."> "..TranslationSystem.translateFrom(Message), 5)
            else
                NotificationSystem.Notify("<"..Player.Name.."> "..Message, 5)
            end
        end)
    end)

    for _, Player in pairs(Players:GetPlayers()) do
        universalAdmin.Events.ChatLogs[Player.Name] = Player.Chatted:Connect(function(Message)
            if (syn) then
                NotificationSystem.Notify("<"..Player.Name.."> "..TranslationSystem.translateFrom(Message), 5)
            else
                NotificationSystem.Notify("<"..Player.Name.."> "..Message, 5)
            end
        end)
    end
end)

addCommand("nochatlogs", "stops logging", function()
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


for i, v in ipairs(universalAdmin.Commands) do
    local clonedContainer = Container:Clone()

    if v[4] then
        clonedContainer.Text.TextLabel.Text = v[1].." { "..v[4].." }"
    else
        clonedContainer.Text.TextLabel.Text = v[1]
    end
    clonedContainer.Parent = ScrollBar
end

spawn(function()
    repeat game:GetService("RunService").Heartbeat:wait() until not CoreGui:FindFirstChild("UI")

    for i, v in pairs(universalAdmin.Events) do
        if v then
            v:Disconnect()
        end
    end

    universalAdmin = nil
end)
