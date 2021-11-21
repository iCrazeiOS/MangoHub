if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().godModeEnabled = false
getgenv().customSpeed = 50
getgenv().customJump = 50



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
	if getgenv().speedEnabled then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().customSpeed
	else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end

	if getgenv().jumpEnabled then
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
	else game.Players.LocalPlayer.Character.Humanoid.JumpPower = 57
	end
end
