local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().customSpeed = 50
getgenv().customJump = 50


local MainUI = UILibrary.Load("Tower of Hell Menu - by iCraze")
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

local makeX2Button = gamePage.AddButton("Finish Game", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").tower.sections.finish.FinishGlow.CFrame
end)

local teleportMenu = movementPage.AddButton("Teleport to player", function()
    local teleportUI = UILibrary.Load("Teleport to player")
    local playersPage = teleportUI.AddPage("Players")
    for i, v in pairs(game.Players:GetChildren()) do
        if v ~= game.Players.LocalPlayer then
            playersPage.AddButton(v.Name, function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
            end)
        end
    end
end)


while wait(1) do
    if getgenv().speedEnabled == true then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().customSpeed
    else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end

    if getgenv().jumpEnabled == true then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
    else game.Players.LocalPlayer.Character.Humanoid.JumpPower = 57
    end
end
