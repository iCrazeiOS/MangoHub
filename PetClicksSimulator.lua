if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().customSpeed = 50
getgenv().customJump = 50
getgenv().autoClickEnabled = false


local MainUI = UILibrary.Load("Pet Clicks Simulator Menu - by iCraze")
local movementPage = MainUI.AddPage("Movement")
local autoPage = MainUI.AddPage("Auto")

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



local autoClickerToggle = autoPage.AddToggle("Auto Clicker", false, function(Value)
    getgenv().autoClickEnabled = Value
end)



spawn(function()
    while wait(0.025) do
        if getgenv().autoClickEnabled then workspace.Events.AddClick:FireServer() end
        if getgenv().speedEnabled == true then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().customSpeed
        else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end

        if getgenv().jumpEnabled == true then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
        else game.Players.LocalPlayer.Character.Humanoid.JumpPower = 57
        end
    end
end)
