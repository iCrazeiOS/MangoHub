local UID = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()
getgenv().xpEnabled = false
getgenv().gemsEnabled = false
getgenv().autoRebirthEnabled = false



local MainUI = UILibrary.Load("Legends of Speed Menu - by iCraze")
local menuPage = MainUI.AddPage("Menu")
local xpPage = MainUI.AddPage("XP")
local gemsPage = MainUI.AddPage("Gems")



-- Menu Page --

local rebirthButton = menuPage.AddButton("Rebirth (Need to be max level)", function()
    rebirth()
end)

local maxSpeedButton = menuPage.AddButton("Max Speed", function()
    ReplicatedStorage.rEvents.changeSpeedJumpRemote:InvokeServer(unpack({[1] = "changeSpeed", [2] = math.huge}))
end)

local maxSpeedButton = menuPage.AddButton("Max Jump", function()
    ReplicatedStorage.rEvents.changeSpeedJumpRemote:InvokeServer(unpack({[1] = "changeJump", [2] = math.huge}))
end)

local autoRebirthToggle = menuPage.AddToggle("Auto Rebirth", false, function(Value)
    getgenv().autoRebirthEnabled = Value
end)



-- XP Page --

local teleportHoopsButton = xpPage.AddButton("Teleport all rings to you", function()
    teleportHoops()
end)

local xpLabel = xpPage.AddLabel("-- Select the area you're currently in --")

local xpLoopToggleCity = xpPage.AddToggle("XP Loop - City", false, function(Value)
    getgenv().xpEnabled = Value
    collectOrb("City")
end)

local xpLoopToggleSC = xpPage.AddToggle("XP Loop - Snow City", false, function(Value)
    getgenv().xpEnabled = Value
    collectOrb("Snow City")
end)

local xpLoopToggleMC = xpPage.AddToggle("XP Loop - Magma City", false, function(Value)
    getgenv().xpEnabled = Value
    collectOrb("Magma City")
end)

local xpLoopToggleLH = xpPage.AddToggle("XP Loop - Legends Highway", false, function(Value)
    getgenv().xpEnabled = Value
    collectOrb("Legends Highway")
end)



-- Gems Page --

local gemsLabel = gemsPage.AddLabel("-- Select the area you're currently in --")

local gemLoopToggleCity = gemsPage.AddToggle("Gem Loop - City", false, function(Value)
    getgenv().gemsEnabled = Value
    getGems("City")
end)

local gemLoopToggleSC = gemsPage.AddToggle("Gem Loop - Snow City", false, function(Value)
    getgenv().gemsEnabled = Value
    getGems("Snow City")
end)

local gemLoopToggleMC = gemsPage.AddToggle("Gem Loop - Magma City", false, function(Value)
    getgenv().gemsEnabled = Value
    getGems("Magma City")
end)

local gemLoopToggleLH = gemsPage.AddToggle("Gem Loop - Legends Highway", false, function(Value)
    getgenv().gemsEnabled = Value
    getGems("Legends Highway")
end)



function getGems(area)
    for i = 1, 10000, 1 do
        if getgenv().gemsEnabled then
            ReplicatedStorage.rEvents.orbEvent:FireServer(unpack({[1] = "collectOrb", [2] = "Gem", [3] = area}))
        end
        wait(0.05)
    end
end

function collectOrb(area)
    local orb = "Red Orb"
    if area == "City" then orb = "Orange Orb"
    end

    while wait(0.05) do
        if getgenv().xpEnabled then
            ReplicatedStorage.rEvents.orbEvent:FireServer(unpack({[1] = "collectOrb", [2] = orb, [3] = area}))
        end
    end
end

function teleportHoops()
    for i,v in pairs(game.Workspace.Hoops:GetChildren()) do
        v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end

function rebirth()
    ReplicatedStorage.rEvents.rebirthEvent:FireServer(unpack({"rebirthRequest"}))
end


while wait(1) do
    if getgenv().autoRebirthEnabled then
        rebirth()
    end
end
