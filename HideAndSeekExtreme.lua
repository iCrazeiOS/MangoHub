local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().noRagdollEnabled = false
getgenv().customSpeed = 50
getgenv().customJump = 50

local MainUI = UILibrary.Load("Hide and Seek Extreme Menu - by iCraze")
local menuPage = MainUI.AddPage("Menu")

local customSpeedToggle = menuPage.AddToggle("Enable Custom Speed", false, function(Value)
    getgenv().speedEnabled = Value
end)

local customSpeedSlider = menuPage.AddSlider("Speed", {Min = 0, Max = 255, Def = 50}, function(Value)
    getgenv().customSpeed = Value
end)

local customJumpToggle = menuPage.AddToggle("Enable Custom Jump Power", false, function(Value)
    getgenv().jumpEnabled = Value
end)

local customJumpSlider = menuPage.AddSlider("Jump Power", {Min = 0, Max = 255, Def = 50}, function(Value)
    getgenv().customJump = Value
end)

local noRagdollToggle = menuPage.AddToggle("No Ragdoll", false, function(Value)
    getgenv().noRagdollEnabled = Value
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

    if getgenv().noRagdollEnabled == true then
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    else
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
    end
end
