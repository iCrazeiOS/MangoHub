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
	}, [5617870058] = {
		[1] = "Pet Battle Simulator",
		[2] = "PetBattleSimulator"
	}, [6345296373] = {
		[1] = "CLICKER Simulator",
		[2] = "CLICKERSimulator"
	}, [60654525] = {
		[1] = "The Legendary Swords RPG",
		[2] = "TheLegendarySwordsRPG"
	}, [5598577415] = {
		[1] = "Frog Simulator",
		[2] = "FrogSimulator"
	}, [2533391464] = {
	    [1] = "Snowman Simulator",
	    [2] = "SnowmanSimulator"
	}
}

if supportedGames[game.placeId] then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/iCrazeiOS/MangoHub/main/"..supportedGames[game.placeId][2]..".lua"))()
else
	local MainUI = UILibrary.Load("MangoHub - by iCraze")
	local infoPage = MainUI.AddPage("Info")
	local movementPage = MainUI.AddPage("Movement")
	local visualsPage= MainUI.AddPage("Visual")
	infoPage.AddLabel("\n\n\n\n\n\n\n\n\nMangoHub does not have any\ngame-specific modules for this game...\n\nA basic menu will be loaded.\nIt may or may not work with this game.")
	
	getgenv().speedEnabled = false
	getgenv().jumpEnabled = false
	getgenv().flightEnabled = false
	getgenv().playerESP = false
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

	local playerESPToggle = visualsPage.AddToggle("Player ESP", false, function(Value)
		getgenv().playerESP = Value
		spawn(function()
			while wait() do
				for i, v in pairs(game.Players:GetPlayers()) do
					if v.Name ~= game.Players.LocalPlayer.Name then
						if v.Character then
							for i2, v2 in pairs(v.Character:GetChildren()) do
								if v2.ClassName == "Part" or v2.ClassName == "MeshPart" then
									if not v2:FindFirstChild("BoxHandleAdornment") then
										box = Instance.new("BoxHandleAdornment")
										box.Parent = v2
										box.Adornee = v2
										box.Size = v2.Size
										box.ZIndex = 0
										box.Transparency = 0.5
										box.Visible = true
										box.AlwaysOnTop = true
										wait()
									elseif not getgenv().playerESP then v2:FindFirstChild("BoxHandleAdornment"):Destroy() end
								end
							end
						end
					end
				end
			end
			
		end)
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
		else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end

		if getgenv().jumpEnabled and not getgenv().flightEnabled then
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
		elseif not getgenv().flightEnabled then game.Players.LocalPlayer.Character.Humanoid.JumpPower = 57
		end
	end
end
