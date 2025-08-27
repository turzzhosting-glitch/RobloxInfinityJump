local player = game.Players.LocalPlayer
local checkpoints = workspace:WaitForChild("Checkpoints")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

_G.lastStage = _G.lastStage or 0

-- Anti Kick
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...) 
	if tostring(self) == "Kick" or getnamecallmethod() == "Kick" then
		return nil
	end
	return old(self, ...)
end)

-- God Mode
local function godMode(char)
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.Name = "God"
		hum.Health = 999999
		hum.MaxHealth = 999999
	end
end

-- Auto refill HP
RunService.Heartbeat:Connect(function()
	local char = player.Character
	if char then
		local hum = char:FindFirstChild("God")
		if hum then
			hum.Health = 999999
		end
	end
end)

-- Infinity Jump UI and Logic
local infinityJumpEnabled = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "InfinityJumpUI"
screenGui.Parent = player.PlayerGui

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 150, 0, 50)
toggleButton.Position = UDim2.new(0.05, 0, 0.05, 0) -- Top-left corner
toggleButton.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2) -- Green
toggleButton.TextColor3 = Color3.new(1, 1, 1) -- White
toggleButton.TextSize = 20
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Text = "Infinity Jump: OFF"
toggleButton.Parent = screenGui

local function updateButtonText()
	if infinityJumpEnabled then
		toggleButton.Text = "Infinity Jump: ON"
		toggleButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2) -- Red
	else
		toggleButton.Text = "Infinity Jump: OFF"
		toggleButton.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2) -- Green
	end
end

toggleButton.MouseButton1Click:Connect(function()
	infinityJumpEnabled = not infinityJumpEnabled
	updateButtonText()
end)

-- Modified Infinity Jump
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if infinityJumpEnabled and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space and not gameProcessedEvent then
		local char = player.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.Jump = true
				-- You can add a small delay here if needed, but for true 'infinity jump', it's often not necessary.
				-- task.wait(0.1) -- Uncomment if you want a slight delay between jumps
				-- hum.Jump = false
			end
		end
	end
end)


