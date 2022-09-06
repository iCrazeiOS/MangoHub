if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
getgenv().speedEnabled = false
getgenv().jumpEnabled = false
getgenv().noRagdollEnabled = false
getgenv().flightEnabled = false
getgenv().noclipEnabled = false
getgenv().noclipEvent = nil
getgenv().disableGlue = false
getgenv().playerESP = false
getgenv().coinESP = false
getgenv().xray = false
getgenv().customSpeed = 50
getgenv().customJump = 50

local MainUI = UILibrary.Load("Hide and Seek Extreme Menu - by iCraze")
local movementPage = MainUI.AddPage("Movement")
local gamePage = MainUI.AddPage("Game")
local visualsPage = MainUI.AddPage("Visuals")

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

local noRagdollToggle = movementPage.AddToggle("No Ragdoll", false, function(Value)
	getgenv().noRagdollEnabled = Value
end)

local flightToggle = movementPage.AddToggle("Flight", false, function(Value)
	getgenv().flightEnabled = Value
end)

local noClipToggle = movementPage.AddToggle("Noclip", false, function(Value)
	getgenv().noclipEnabled = Value
	if getgenv().noclipEnabled then
		local function removeCollisions()
			if getgenv().noclipEnabled and game.Players.LocalPlayer.Character ~= nil then
				for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					-- don't change if Part already has no collision
					if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
				end
			end
		end
		getgenv().noclipEvent = game:GetService("RunService").Stepped:Connect(removeCollisions)
	elseif getgenv().noclipEvent then
		getgenv().noclipEvent:Disconnect()
	end
end)

local teleportMenu = movementPage.AddButton("Teleport to player", function()
	local teleportUI = UILibrary.Load("Teleport to player")
	local playersPage = teleportUI.AddPage("Players")
	for i, v in pairs(game.Players:GetChildren()) do
		if v.PlayerData.It.Value then
			playersPage.AddButton(v.Name.." (IT)", function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			end)
		elseif v ~= game.Players.LocalPlayer then
			playersPage.AddButton(v.Name, function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			end)
		end
	end
end)



local getAllCoins = gamePage.AddButton("Collect All Coins", function()
	for i, v in pairs(game.Workspace.GameObjects:GetChildren()) do
		if v.name == "Credit" then
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
		end
	end
end)

local killEveryone = gamePage.AddButton("Kill Everyone (Need to be IT)", function()
	for i, v in pairs(game.Players:GetChildren()) do
		if v ~= game.Players.LocalPlayer and v.PlayerData.InGame then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
		end
		wait(0.5)
	end
end)

local semiRevive = gamePage.AddButton("Fake Respawn", function()
	game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	game.Players.LocalPlayer.PlayerGui.MainGui.ItCamFrame.TopFrame.Visible = false
	game.Players.LocalPlayer.PlayerGui.MainGui.SpectatingFrame.TopFrame.Visible = false
	game.Players.LocalPlayer.PlayerGui.MainGui.SpectatingFrame.BottomFrame.Visible = false
	game.Players.LocalPlayer.PlayerGui.MainGui.SpectatingFrame.Q.Visible = false
	game.Players.LocalPlayer.PlayerGui.MainGui.SpectatingFrame.E.Visible = false
	
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Map.ItSpawn.Position + Vector3.new(0, 5, 0))
	game.Players.LocalPlayer.PlayerData.InGame.Value = true
end)

local disableGlueToggle = gamePage.AddToggle("Disable Glue/Cameras", false, function(Value)
	getgenv().disableGlue = Value
end)

local spectateMenu = gamePage.AddButton("Spectate player", function()
	local teleportUI = UILibrary.Load("Spectate player")
	local playersPage = teleportUI.AddPage("Players")
	playersPage.AddButton("STOP SPECTATING", function()
		game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	end)
	for i, v in pairs(game.Players:GetChildren()) do
		local title = v.Name
		if v.PlayerData.It.Value then title = title.." (IT)" end
		if v ~= game.Players.LocalPlayer and v.PlayerData.InGame.Value then
			playersPage.AddButton(title, function()
				game.Workspace.Camera.CameraSubject = v.Character.Humanoid
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

local coinESPToggle = visualsPage.AddToggle("Coin ESP", false, function(Value)
	getgenv().coinESP = Value
	spawn(function()
		while wait() do
			if not getgenv().coinESP then break end
			for i, v in pairs(game.Workspace.GameObjects:GetChildren()) do
				if v.name == "Credit" then
					if not v:FindFirstChild("BoxHandleAdornment") then
						box = Instance.new("BoxHandleAdornment")
						box.Parent = v
						box.Adornee = v
						box.Size = v.Size
						box.ZIndex = 0
						box.Transparency = 0.5
						box.Visible = true
						box.AlwaysOnTop = true
						wait()
					elseif not getgenv().playerESP then v:FindFirstChild("BoxHandleAdornment"):Destroy() end
				end
			end
		end
	end)
end)

local xrayToggle = visualsPage.AddToggle("Xray", false, function(Value)
	getgenv().xray = Value
	spawn(function()
		while wait(1) do
			for i, v in pairs(game.workspace.Map.Map:GetDescendants()) do 
				if (v:IsA("Part") or v:IsA("BasePart")) then
					transparency = 0
					if getgenv().xray then transparency = 0.5 end
					v.LocalTransparencyModifier = transparency
				end
			end
			if not getgenv().xray then break end
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
	if getgenv().disableGlue then
		for i, v in pairs(game.Workspace.GameObjects:GetChildren()) do
			if v.name == "GlueServer" or v.name == "Glue"  or v.name == "GluePlaced" or v.name == "Camera1" or v.name == "Camera2" or v.name == "CameraServer" then
				v:Destroy()
			end
		end
	end

	if getgenv().speedEnabled then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().customSpeed
	else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end

	if getgenv().jumpEnabled and not getgenv().flightEnabled then
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
	elseif not getgenv().flightEnabled then game.Players.LocalPlayer.Character.Humanoid.JumpPower = 57
	end

	if getgenv().noRagdollEnabled then
		game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	else
		game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
		game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
	end
end
