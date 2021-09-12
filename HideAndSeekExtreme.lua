local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().noRagdollEnabled = false
getgenv().disableGlue = false
getgenv().customSpeed = 50
getgenv().customJump = 50

local MainUI = UILibrary.Load("Hide and Seek Extreme Menu - by iCraze")
local movementPage = MainUI.AddPage("Movement")
local gamePage = MainUI.AddPage("Game")

local customSpeedToggle = movementPage.AddToggle("Enable Custom Speed", false, function(Value)
    getgenv().speedEnabled = Value
end)

local customSpeedSlider = movementPage.AddSlider("Speed", {Min = 0, Max = 255, Def = 50}, function(Value)
    getgenv().customSpeed = Value
end)

local customJumpToggle = movementPage.AddToggle("Enable Custom Jump Power", false, function(Value)
    getgenv().jumpEnabled = Value
end)

local customJumpSlider = movementPage.AddSlider("Jump Power", {Min = 0, Max = 255, Def = 50}, function(Value)
    getgenv().customJump = Value
end)

local noRagdollToggle = movementPage.AddToggle("No Ragdoll", false, function(Value)
    getgenv().noRagdollEnabled = Value
end)

local teleportMenu = movementPage.AddButton("Teleport to player", function()
    local teleportUI = UILibrary.Load("Teleport to player")
    local playersPage = teleportUI.AddPage("Players")
    for i, v in pairs(game.Players:GetChildren()) do
        if v.PlayerData.It.Value then
            playersPage.AddButton(v.Name.." (IT)", function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
            end)
        elseif v ~= game.Players.LocalPlayer then
            playersPage.AddButton(v.Name, function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
            end)
        end
    end
end)



local getAllCoins = gamePage.AddButton("Collect All Coins", function()
    for i, v in pairs(game.Workspace.GameObjects:GetChildren()) do
        if v.name == "Credit" then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
        end
    end
end)

local killEveryone = gamePage.AddButton("Kill Everyone (Need to be IT)", function()
    for i, v in pairs(game.Players:GetChildren()) do
        if v ~= game.Players.LocalPlayer then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
        end
        wait(0.5)
    end
end)

local disableGlueToggle = gamePage.AddToggle("Disable Glue/Cameras", false, function(Value)
    getgenv().disableGlue = Value
end)



while wait(1) do
    if getgenv().disableGlue then
        for i, v in pairs(game.Workspace.GameObjects:GetChildren()) do
            if v.name == "GlueServer" or v.name == "Camera1" or v.name == "Camera2" then
                v:Destroy()
            end
        end
    end

    if getgenv().speedEnabled == true then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().customSpeed
    else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end

    if getgenv().jumpEnabled == true then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
    else game.Players.LocalPlayer.Character.Humanoid.JumpPower = 57
    end

    if getgenv().noRagdollEnabled == true then
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    else
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
    end
end
