--disableCheat by OkaioDevs
--This code was coded by me and AI recheck 
--enjoy script:)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
pcall(function()
	if getgenv then
		local k = {"chili", "redz", "hub", "aimbot", "esp", "autofarm", "farm", "kavo", "linoria", "fluent", "loop", "tween", "bot"}
		for i, _ in pairs(getgenv()) do
			if type(i) == "string" then
				local l = string.lower(i)
				for _, w in ipairs(k) do
					if l:find(w) then
						getgenv()[i] = nil
					end
				end
			end
		end
	end
end)
local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
if pg then
	for _, g in ipairs(pg:GetChildren()) do
		if g:IsA("ScreenGui") then
			local n = string.lower(g.Name)
			if n:find("hub") or n:find("gui") or n:find("menu") or n:find("chili") or n:find("redz") or n:find("cheat") or n:find("ui") or n:find("script") or n:find("lib") or n:find("farm") then
				g:Destroy()
			end
		end
	end
end
local char = LocalPlayer.Character
if char then
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = 16
		hum.JumpPower = 50
		hum.AutoRotate = true
	end
	for _, pt in ipairs(char:GetDescendants()) do
		if pt:IsA("BasePart") then
			pt.CanCollide = true
		end
	end
end
if Camera then
	Camera.CameraType = Enum.CameraType.Custom
	Camera.FieldOfView = 70
	Camera.CameraSubject = char and char:FindFirstChildOfClass("Humanoid") or nil
end
