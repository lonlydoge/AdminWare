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

UI.CommandList.BackgroundTransparency = 1
UI.CommandList.Visible = false
Container.TextLabel.TextTransparency = 1
Container.TextLabel.Description.TextTransparency = 1

UI.CommandBar.BackgroundTransparency = 1
UI.CommandBar.TextBox.TextTransparency = 1
UI.CommandBar.ImageButton.ImageTransparency = 1
UI.CommandBar.Position = UDim2.new(0.5, 0, 1, 35)

UI.IntroGui.BackgroundTransparency = 1
UI.IntroGui.Headbar.BackgroundTransparency = 1
UI.IntroGui.Headbar.MainText.TextTransparency = 1
UI.IntroGui.Headbar.Icon.ImageTransparency = 1

UI.IntroGui.TextLabel.TextTransparency = 1
UI.IntroGui.TextLabel.LoadingBar.BackgroundTransparency = 1
UI.IntroGui.TextLabel.LoadingBar.LoadingBarThing.BackgroundTransparency = 1
UI.IntroGui.TextLabel.LoadingText.TextTransparency = 1

UI.Parent = game.CoreGui

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

local IntroGuiTweens = {
    ["Headbar"] = "BackgroundTransparency",
    ["MainText"] = "TextTransparency",
    ["TextLabel"] = "TextTransparency",
    ["LoadingBar"] = "BackgroundTransparency",
    ["LoadingBarThing"] = "BackgroundTransparency",
    ["LoadingText"] = "TextTransparency",
    ["Icon"] = "ImageTransparency"
}

local MainIntroGuiTween = TweenService:Create(UI.IntroGui, TweenInfo.new(.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})
MainIntroGuiTween:Play()
MainIntroGuiTween.Completed:Wait()

for _, v in ipairs(UI.IntroGui:GetDescendants()) do
    if IntroGuiTweens[v.Name] then
        local Tween = TweenService:Create(v, TweenInfo.new(.25, Enum.EasingStyle.Quint), {[IntroGuiTweens[v.Name]] = 0})

        Tween:Play()
        Tween.Completed:wait()
    end
end

local LoadingBarTween = TweenService:Create(UI.IntroGui.TextLabel.LoadingBar.LoadingBarThing, TweenInfo.new(5, Enum.EasingStyle.Quint), {Size = UI.IntroGui.TextLabel.LoadingBar.Size})
LoadingBarTween:Play()
LoadingBarTween.Completed:wait()

wait(1)

for _, v in ipairs(UI.IntroGui:GetDescendants()) do
    if IntroGuiTweens[v.Name] then
        local Tween = TweenService:Create(v, TweenInfo.new(.25, Enum.EasingStyle.Quint), {[IntroGuiTweens[v.Name]] = 1})

        Tween:Play()
        Tween.Completed:wait()
    end
end

local MainIntroGuiTween = TweenService:Create(UI.IntroGui, TweenInfo.new(.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 1})
MainIntroGuiTween:Play()
MainIntroGuiTween.Completed:Wait()

UI.IntroGui:Destroy()

universalAdmin.Debounce = false

universalAdmin.Events.LocalPlayerConnection = LocalPlayer.Chatted:Connect(function(Message)
    if string.sub(Message, 1, 1) == universalAdmin.Prefix then
        commandCheck(Message)
    end
end)

--commands
addCommand("commands/cmds", "opens commands menu", function()
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
