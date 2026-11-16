local ReplicatedStorage = game:GetService("ReplicatedStorage")
print("--- DANH SÁCH REMOTE EVENT TRONG GAME ---")
for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("UnreliableRemoteEvent") then
        print("Tên Remote tìm thấy: " .. obj.Name .. " | Đường dẫn: " .. obj:GetFullName())
    end
end
print("-----------------------------------------")
