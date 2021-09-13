if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().customSpeed = 50
getgenv().customJump = 50
getgenv().farmEnabled = false


local MainUI = UILibrary.Load("The Legendary Swords RPG Menu - by iCraze")
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



local moneyLoopToggle = autoPage.AddToggle("50M Gold every 10 seconds (loop)", false, function(Value)
	getgenv().farmEnabled = Value
	spawn(function()
		while true do
			if not getgenv().farmEnabled then break end
			local event = game:GetService("Players").LocalPlayer.RemoteFunctions.SwordShopSystem
			event:FireServer("Buy", 0, "Frostbrand")
			wait(5)
			event:FireServer("Sell", 100000000, "Frostbrand")
			wait(5)
		end
	end)
end)



spawn(function()
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
end)
