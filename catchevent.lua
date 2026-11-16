-- how to use: execute it and press F9 in Roblox
local player = game:GetService("Players").LocalPlayer
local char = player.Character
if char and char:FindFirstChild("HumanoidRootPart") then
    local pos = char.HumanoidRootPart.Position
    print("--- TỌA ĐỘ BỆ PHÓNG HIỆN TẠI ---")
    print(string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z))
    print("---------------------------------")
end
