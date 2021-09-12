if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().customSpeed = 50
getgenv().customJump = 50
getgenv().autoRebirthEnabled = false


local MainUI = UILibrary.Load("Pet Battle Simulator Menu - by iCraze")
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



local autoClickerToggle = autoPage.AddToggle("Auto Rebirth", false, function(Value)
    getgenv().autoRebirthEnabled = Value
end)



spawn(function()
    while wait(0.5) do
        if getgenv().autoRebirthEnabled then game:GetService("ReplicatedStorage").RemoteFunctions.MainRemoteFunction:InvokeServer(unpack({[1] = "RebirthPlayer", [2] = 1, [3] = UDim2.new({0, 1028}, {0, 279}), [4] = false})) end
    end
end)



spawn(function()
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
end)
