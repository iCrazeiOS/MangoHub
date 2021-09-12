getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

local supportedGames = {
    [205224386] = {
        [1] = "Hide and Seek Extreme",
        [2] = "HideAndSeekExtreme"
    }, [1962086868] = {
        [1] = "Tower of Hell",
        [2] = "TowerOfHell"
    }, [3101667897] = {
        [1] = "Legends Of Speed",
        [2] = "LegendsOfSpeed"
    }, [4545436299] = {
        [1] = "Pet Clicks Simulator",
        [2] = "PetClicksSimulator"
    }
}

if supportedGames[game.placeId] then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/iCrazeiOS/RobloxScripts/main/"..supportedGames[game.placeId][2]..".lua"))()
else
    local MainUI = UILibrary.Load("MangoHub - by iCraze")
    local infoPage = MainUI.AddPage("Info")
    local movementPage = MainUI.AddPage("Movement")
    infoPage.AddLabel("\n\n\n\n\n\n\n\n\nMangoHub does not have any\ngame-specific modules for this game...\n\nA basic menu will be loaded.\nIt may or may not work with this game.")
    
    getgenv().speedEnabled = false
    getgenv().jumpEnabled = false
    getgenv().customSpeed = 50
    getgenv().customJump = 50

    movementPage.AddToggle("Enable Custom Speed", false, function(Value)
        getgenv().speedEnabled = Value
    end)

    movementPage.AddSlider("Speed", {Min = 0, Max = 255, Def = 50}, function(Value)
        getgenv().customSpeed = Value
    end)

    movementPage.AddToggle("Enable Custom Jump Power", false, function(Value)
        getgenv().jumpEnabled = Value
    end)

    movementPage.AddSlider("Jump Power", {Min = 0, Max = 255, Def = 50}, function(Value)
        getgenv().customJump = Value
    end)

    movementPage.AddButton("Teleport to player", function()
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
end
