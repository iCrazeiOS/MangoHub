if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
getgenv().autoSellCanes = false
getgenv().autoCollectCanes = false
getgenv().autoAddSnow = false
getgenv().autoRebirth = false
getgenv().autoPresents = false

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



local autoAddToSnowmanToggle = autoPage.AddToggle("Auto Add To Snowman", false, function(Value)
	getgenv().autoAddSnow = Value
	if Value then
		spawn(function()
			while getgenv().autoAddSnow do
			    if getgenv().autoRebirth then
			        game:GetService("ReplicatedStorage").ThisGame.Calls.snowmanEvent:FireServer("acceptRebirth", workspace.snowmanBases.LandPlot, true)
			        wait(0.1)
			    end
				game:GetService("ReplicatedStorage").ThisGame.Calls.snowballController:FireServer("addToSnowman")
				wait(1)
			end
		end)
	end
end)

local autoRebirthToggle = autoPage.AddToggle("Auto Rebirth", false, function(Value)
	getgenv().autoRebirth = Value
	if Value then
		spawn(function()
			while getgenv().autoRebirth do
				game:GetService("ReplicatedStorage").ThisGame.Calls.snowmanEvent:FireServer("acceptRebirth", workspace.snowmanBases.LandPlot, true)
				wait(1)
			end
		end)
	end
end)

local autoCanesToggle = autoPage.AddToggle("Auto Sell Canes", false, function(Value)
	getgenv().autoSellCanes = Value
	if Value then
		spawn(function()
			while getgenv().autoSellCanes do
				game:GetService("ReplicatedStorage").ThisGame.Calls.candycaneSell:FireServer("sellCandycanes", 1, workspace.sellSpots.redA.Nutcracker)
				game:GetService("ReplicatedStorage").ThisGame.Calls.candycaneSell:FireServer("sellCandycanes", 2, workspace.sellSpots.greenA.Nutcracker)
				game:GetService("ReplicatedStorage").ThisGame.Calls.candycaneSell:FireServer("sellCandycanes", 3, workspace.sellSpots.goldA.Nutcracker)
				wait(1)
			end
		end)
	end
end)

local getAllCanes = autoPage.AddToggle("Collect All Canes", false, function(Value)
	getgenv().autoCollectCanes = Value
	if Value then
		spawn(function()
			while getgenv().autoCollectCanes do
				for i, v in pairs(game:GetService("Workspace").gameCandyCanes:GetChildren()) do
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:GetChildren()[1].CFrame
					wait(0.25)
				end
				wait(0.1)
			end
		end)
	end
end)

local openAllPresents = autoPage.AddToggle("Open All Presents", false, function(Value)
	getgenv().autoPresents = Value
	if Value then
		spawn(function()
			while getgenv().autoPresents do
				wait(0.5)
				for i, v in pairs(game:GetService("Workspace").giftSpawns:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then
                        if not getgenv().autoPresents then break end
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.WorldCFrame
                        wait(0.2)
                        fireproximityprompt(v, 10)
                        v.Parent.Parent:WaitForChild("unwrapProgressBar")
                        while v.Parent.Parent:FindFirstChild("unwrapProgressBar") do wait() end
                    end
                end
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
