local P = game:GetService("Players")
local p = P.LocalPlayer

local sg = Instance.new("ScreenGui")
sg.Name = "FakeKickGUI"
sg.ResetOnSpawn = false
sg.DisplayOrder = 999999999
pcall(function() sg.Parent = p:WaitForChild("PlayerGui") end)

local bg = Instance.new("Frame", sg)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(35, 37, 39)
bg.BorderSizePixel = 0

local card = Instance.new("Frame", bg)
card.Size = UDim2.new(0, 420, 0, 240)
card.Position = UDim2.new(0.5, -210, 0.5, -120)
card.BackgroundColor3 = Color3.fromRGB(57, 59, 61)
card.BorderSizePixel = 0
local cardCorner = Instance.new("UICorner", card) cardCorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", card)
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Disconnected"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

local line = Instance.new("Frame", card)
line.Size = UDim2.new(0.9, 0, 0, 1)
line.Position = UDim2.new(0.05, 0, 0, 55)
line.BackgroundColor3 = Color3.fromRGB(80, 83, 86)
line.BorderSizePixel = 0

local msg = Instance.new("TextLabel", card)
msg.Size = UDim2.new(0.9, 0, 0, 95)
msg.Position = UDim2.new(0.05, 0, 0, 65)
msg.BackgroundTransparency = 1
msg.Text = "You have been kicked for cheating. Please remove all cheats to continue.\nErrorCode: 3667\nchan bo m di:)"
msg.TextColor3 = Color3.fromRGB(200, 200, 200)
msg.Font = Enum.Font.SourceSans
msg.TextSize = 15
msg.TextWrapped = true

local btn = Instance.new("TextButton", card)
btn.Size = UDim2.new(0.85, 0, 0, 36)
btn.Position = UDim2.new(0.075, 0, 1, -50)
btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
btn.BorderSizePixel = 0
btn.Text = "Respawn"
btn.TextColor3 = Color3.fromRGB(35, 37, 39)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 18
local btnCorner = Instance.new("UICorner", btn) btnCorner.CornerRadius = UDim.new(0, 6)

btn.MouseButton1Click:Connect(function()
	local char = p.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	
	if hum and hum.Health > 0 then
		hum.Health = 0
		sg:Destroy()
	else
		msg.Text = "You're playing trash game not support respawn.Please join another game and execute the script again to continue."
		msg.TextColor3 = Color3.fromRGB(255, 100, 100)
		btn.Text = "Leave"
		btn.MouseButton1Click:Connect(function()
			p:Kick("You're playing trash game not support respawn.")
		end)
	end
end)
