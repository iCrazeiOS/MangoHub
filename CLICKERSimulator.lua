if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().flightEnabled = false
getgenv().customSpeed = 50
getgenv().customJump = 50
getgenv().autoClickEnabled = false


local MainUI = UILibrary.Load("CLICKER Simulator - by iCraze")
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

local flightToggle = movementPage.AddToggle("Flight", false, function(Value)
	getgenv().flightEnabled = Value
end)



local autoClickerToggle = autoPage.AddToggle("Auto Clicker", false, function(Value)
	getgenv().autoClickEnabled = Value
	for x = 1, 100, 1 do
		spawn(function()
			while wait(0.25) do
				if getgenv().autoClickEnabled then workspace.Events.AddClick:FireServer()
				else break end
			end
		end)
	end
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

spawn(function()
	while wait(1) do
		if getgenv().speedEnabled then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().customSpeed
		else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end

		if getgenv().jumpEnabled and not getgenv().flightEnabled then
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
		elseif not getgenv().flightEnabled then game.Players.LocalPlayer.Character.Humanoid.JumpPower = 57
		end
	end
end)
