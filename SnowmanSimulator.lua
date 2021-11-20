if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
getgenv().autoCanes = false

local MainUI = UILibrary.Load("Snowman Simulator Menu - by iCraze")
local movementPage = MainUI.AddPage("Movement")
local autoPage = MainUI.AddPage("Auto")



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

local flightToggle = movementPage.AddToggle("Flight", false, function(Value)
	getgenv().flightEnabled = Value
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

local autoCanesToggle = autoPage.AddToggle("Auto Redeem Canes", false, function(Value)
	getgenv().autoCanes = Value
	if Value then
    	spawn(function()
            while true do
                if not getgenv().autoCanes then break end
                game:GetService("ReplicatedStorage").ThisGame.Calls.candycaneSell:FireServer("sellCandycanes", 0, workspace.sellSpots.goldA.Nutcracker)
                game:GetService("ReplicatedStorage").ThisGame.Calls.candycaneSell:FireServer("sellCandycanes", 1, workspace.sellSpots.redA.Nutcracker)
                game:GetService("ReplicatedStorage").ThisGame.Calls.candycaneSell:FireServer("sellCandycanes", 2, workspace.sellSpots.greenA.Nutcracker)
                wait(1)
            end
    	end)
    end
end)



spawn(function()
    getgenv().originalSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
    getgenv().originalJumpPower = game.Players.LocalPlayer.Character.Humanoid.JumpPower
    while wait(0.1) do
        if getgenv().speedEnabled then
        	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().customSpeed
        else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().originalSpeed
        end
        
        if getgenv().jumpEnabled and not getgenv().flightEnabled then
        	game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
        elseif not getgenv().flightEnabled then game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().originalJumpPower
        end
    end
end)



function onJumpRequest()
	if getgenv().flightEnabled then
		local oldJP = game.Players.LocalPlayer.Character.Humanoid.JumpPower
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 60
		wait(0.05)
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
		wait(0.05)
		if getgenv().jumpEnabled then
    		game.Players.LocalPlayer.Character.Humanoid.JumpPower = oldJP
    	else game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().originalJumpPower end
	end
end

game:GetService("UserInputService").JumpRequest:connect(onJumpRequest)
