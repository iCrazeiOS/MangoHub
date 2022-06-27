if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
local StarterGui = game:GetService("StarterGui")
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().godModeEnabled = false
getgenv().customSpeed = 50
getgenv().customJump = 50
getgenv().flightEnabled = false


function showToast(message)
    StarterGui:SetCore("SendNotification", {
    	Title = "HangoHub",
    	Text = message,
    	Duration = 2
    })
end


-- anticheat bypass from v3rmillion
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
	local args = {...}
	local method = getnamecallmethod()
	if method == "Kick" then return end
	return old(self, ...)
end)
setreadonly(mt, true)
game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript2:Destroy()
game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript:Destroy()
-- another one ????
local reg = getreg()
for i, Function in next, reg do
    if type(Function) == 'function' then
        local info = getinfo(Function)
        if info.name == 'kick' then
            if (hookfunction(info.func, function(...)end)) then
                print "lol no kick"
            end
        end
    end
end



local MainUI = UILibrary.Load("Tower of Hell Menu - by iCraze")
local movementPage = MainUI.AddPage("Movement")
local gamePage = MainUI.AddPage("Game")
local disablesPage = MainUI.AddPage("Disables")

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

local flightToggle = movementPage.AddToggle("Flight", false, function(Value)
	getgenv().flightEnabled = Value
end)

local makeX2Button = gamePage.AddButton("Finish Game", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").tower.finishes:GetChildren()[1].CFrame
end)

local godModeToggle = gamePage.AddToggle("Godmode", false, function(Value)
	getgenv().godModeEnabled = Value
	spawn(function()
		while wait do
			if not getgenv().godModeEnabled then break end
			game.Players.LocalPlayer.Character.KillScript:Destroy() 
		end
	end)
end)

local removeKillZonesButton = gamePage.AddButton("Delete kill zones", function()
	-- from v3rmillion
	for i,v in pairs(game:GetService("Workspace").tower:GetDescendants()) do
		if v:IsA("BoolValue") and v.Name == "kills" then v.Parent:Destroy() end
	end
end)

local freezeTimeToggle = gamePage.AddToggle("Freeze Time", game.Players.LocalPlayer.PlayerScripts.timefreeze.Value, function(Value)
    print(game:GetService("Players").LocalPlayer.PlayerScripts:GetChildren())
	game.Players.LocalPlayer.PlayerScripts.timefreeze.Value = Value
end)

local teleportTool = movementPage.AddButton("Receive teleporter", function()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Click TP"
    tool.Activated:Connect(function()
        local rootPart = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        local pos = game:GetService("Players").LocalPlayer:GetMouse().Hit.Position+Vector3.new(0,3,0)
        rootPart.CFrame = rootPart.CFrame-rootPart.Position+pos
    end)
    
    tool.Parent = game:GetService("Players").LocalPlayer.Backpack
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

local disableFogToggle = disablesPage.AddButton("Disable fog", function()
	local fog = require(game:GetService("ReplicatedStorage").Mutators.fog)
    fog.isEnabled = function() return false end
    fog:revert()
    showToast("Removed fog")
end)

local disableNegativeEffectToggle = disablesPage.AddButton("Disable negative effect", function()
	local negative = require(game:GetService("ReplicatedStorage").Mutators.negative)
    negative.isEnabled = function() return false end
    negative:revert()
    game.Lighting.Negative.Enabled = false
    showToast("Removed negative effect")
end)

-- local disableInvisibilityToggle = disablesPage.AddButton("Disable invisibility", function()
-- 	local invisibility = require(game:GetService("ReplicatedStorage").Mutators.invisibility)
--     invisibility.isEnabled = function() return false end
--     invisibility:revert()
--     showToast("Removed invisibility??")
-- end)

local disableBunnyJumpingToggle = disablesPage.AddButton("Disable bunny jumping", function()
	game:GetService("ReplicatedStorage").bunnyJumping.Value = false
    showToast("Removed bunny jumping")
end)


function onJumpRequest()
	if getgenv().flightEnabled then
		local oldJP = game.Players.LocalPlayer.Character.Humanoid.JumpPower
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 30
		wait(0.05)
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
		wait(0.05)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = oldJP
	end
end

game:GetService("UserInputService").JumpRequest:connect(onJumpRequest)


while wait(1) do
	if getgenv().speedEnabled then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().customSpeed
	else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 end

	if getgenv().jumpEnabled and not getgenv().flightEnabled then
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
	elseif not getgenv().flightEnabled then game.Players.LocalPlayer.Character.Humanoid.JumpPower = 57 end
end
