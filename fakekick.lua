local P = game:GetService("Players")
local L = game:GetService("Lighting")
local W = game:GetService("Workspace")
local p = P.LocalPlayer

local function cleanup()
	local pg = p:FindFirstChild("PlayerGui")
	if pg then
		for _, v in ipairs(pg:GetChildren()) do
			if v.Name == "RobloxKickGUI" or v.Name == "FakeKickGUI" or v.Name == "izHub" then
				v:Destroy()
			end
		end
	end
	for _, v in ipairs(L:GetChildren()) do
		if v:IsA("BlurEffect") or v.Name == "izESP" then
			v:Destroy()
		end
	end
end

cleanup()

local blur = Instance.new("BlurEffect")
blur.Size = 24
blur.Parent = L

local sg = Instance.new("ScreenGui")
sg.Name = "RobloxKickGUI"
sg.ResetOnSpawn = false
sg.DisplayOrder = 2147483647
pcall(function() sg.Parent = p:WaitForChild("PlayerGui") end)

local bg = Instance.new("Frame", sg)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.45
bg.BorderSizePixel = 0

local card = Instance.new("Frame", bg)
card.Size = UDim2.new(0, 480, 0, 260)
card.Position = UDim2.new(0.5, -240, 0.5, -130)
card.BackgroundColor3 = Color3.fromRGB(57, 59, 61)
card.BorderSizePixel = 0
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", card)
title.Size = UDim2.new(1, 0, 0, 55)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Disconnected"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24

local line = Instance.new("Frame", card)
line.Size = UDim2.new(1, -40, 0, 1)
line.Position = UDim2.new(0, 20, 0, 55)
line.BackgroundColor3 = Color3.fromRGB(80, 83, 86)
line.BorderSizePixel = 0

local msg = Instance.new("TextLabel", card)
msg.Size = UDim2.new(1, -40, 0, 110)
msg.Position = UDim2.new(0, 20, 0, 60)
msg.BackgroundTransparency = 1
msg.Text = "You have been kicked for cheating. Please remove all cheats to continue.\n(Error Code: 3667)\nchan bo m di:)"
msg.TextColor3 = Color3.fromRGB(220, 220, 220)
msg.Font = Enum.Font.SourceSans
msg.TextSize = 16
msg.TextWrapped = true

local btn = Instance.new("TextButton", card)
btn.Size = UDim2.new(1, -40, 0, 40)
btn.Position = UDim2.new(0, 20, 1, -55)
btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
btn.BorderSizePixel = 0
btn.Text = "Respawn"
btn.TextColor3 = Color3.fromRGB(35, 37, 39)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 18
btn.Modal = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

local char = p.Character
local hum = char and char:FindFirstChildOfClass("Humanoid")
local oldSpeed, oldJump = 16, 50
if hum then
	oldSpeed = hum.WalkSpeed
	oldJump = hum.JumpPower
	hum.WalkSpeed = 0
	hum.JumpPower = 0
end

local processing = false
btn.MouseButton1Click:Connect(function()
	if processing then return end
	processing = true
	btn.Text = "Please wait..."
	
	task.wait(2)
	
	if hum then
		hum.WalkSpeed = oldSpeed
		hum.JumpPower = oldJump
	end
	
	if char and char:FindFirstChild("HumanoidRootPart") then
		pcall(function()
			char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 500, 0)
		end)
		if hum then hum:ChangeState(Enum.HumanoidStateType.Dead) end
		cleanup()
	else
		msg.Text = "You're playing trash game not support respawn.Please join another game and execute the script again to continue."
		msg.TextColor3 = Color3.fromRGB(255, 85, 85)
		btn.Text = "Leave"
		btn.MouseButton1Click:Connect(function()
			p:Kick("You're playing trash game not support respawn.")
		end)
	end
end)
