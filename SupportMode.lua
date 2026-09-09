local Players = game:GetService(&quot;Players&quot;)
local RunService = game:GetService(&quot;RunService&quot;)
local UserInputService = game:GetService(&quot;UserInputService&quot;)
local Lighting = game:GetService(&quot;Lighting&quot;)
local Workspace = game:GetService(&quot;Workspace&quot;)
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local ScreenGui = Instance.new(&quot;ScreenGui&quot;)
ScreenGui.Name = &quot;ClientToolsUI&quot;
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild(&quot;PlayerGui&quot;)
local MainFrame = Instance.new(&quot;Frame&quot;)
MainFrame.Name = &quot;MainFrame&quot;
MainFrame.Size = UDim2.new(0, 220, 0, 270)
MainFrame.Position = UDim2.new(0, 20, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local UIListLayout = Instance.new(&quot;UIListLayout&quot;)
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = MainFrame
local UIPadding = Instance.new(&quot;UIPadding&quot;)
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 10)
UIPadding.Parent = MainFrame
local function CreateToggleButton(labelText, order)
local Button = Instance.new(&quot;TextButton&quot;)
Button.Name = labelText .. &quot;Button&quot;

Button.Size = UDim2.new(1, 0, 0, 36)
Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14
Button.Text = labelText .. &quot;: OFF&quot;
Button.LayoutOrder = order
Button.Parent = MainFrame
return Button
end
local function SetButtonState(Button, LabelText, IsOn)
Button.Text = LabelText .. &quot;: &quot; .. (IsOn and &quot;ON&quot; or &quot;OFF&quot;)
Button.BackgroundColor3 = IsOn and Color3.fromRGB(40, 130, 70) or
Color3.fromRGB(60, 60, 60)
end
local NoclipState = {
Active = false,
Connection = nil
}
local function StartNoclip()
NoclipState.Connection = RunService.Stepped:Connect(function()
local Character = LocalPlayer.Character
if Character then
for _, Part in ipairs(Character:GetDescendants()) do
if Part:IsA(&quot;BasePart&quot;) then
Part.CanCollide = false
end
end
end
end)
end
local function StopNoclip()
if NoclipState.Connection then
NoclipState.Connection:Disconnect()
NoclipState.Connection = nil
end
local Character = LocalPlayer.Character
if Character then
for _, Part in ipairs(Character:GetDescendants()) do

if Part:IsA(&quot;BasePart&quot;) and Part.Name ~= &quot;HumanoidRootPart&quot; then
Part.CanCollide = true
end
end
end
end
local FreeCamState = {
Active = false,
Connections = {},
Speed = 60,
AngleX = 0,
AngleY = 0,
}
local function SetCharacterVisibility(IsVisible)
local Character = LocalPlayer.Character
if not Character then
return
end
local Modifier = IsVisible and 0 or 1
for _, Descendant in ipairs(Character:GetDescendants()) do
if Descendant:IsA(&quot;BasePart&quot;) or Descendant:IsA(&quot;Decal&quot;) then
Descendant.LocalTransparencyModifier = Modifier
end
end
end
local function StartFreeCam()
local RX, RY, _ = Camera.CFrame:ToOrientation()
FreeCamState.AngleY = RX
FreeCamState.AngleX = RY
SetCharacterVisibility(false)
Camera.CameraType = Enum.CameraType.Scriptable
UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
local InputChangedConn = UserInputService.InputChanged:Connect(function(Input)
if Input.UserInputType == Enum.UserInputType.MouseMovement then
FreeCamState.AngleX -= Input.Delta.X * 0.003
FreeCamState.AngleY -= Input.Delta.Y * 0.003
FreeCamState.AngleY = math.clamp(FreeCamState.AngleY, -

math.rad(85), math.rad(85))
end
end)

local RenderConn = RunService.RenderStepped:Connect(function(DeltaTime)
local Rotation = CFrame.fromOrientation(FreeCamState.AngleY,

FreeCamState.AngleX, 0)

local MoveDir = Vector3.new()
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
MoveDir += Rotation.LookVector
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
MoveDir -= Rotation.LookVector
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
MoveDir -= Rotation.RightVector
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
MoveDir += Rotation.RightVector
end
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
MoveDir += Vector3.new(0, 1, 0)
end
if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
MoveDir -= Vector3.new(0, 1, 0)
end
if MoveDir.Magnitude &gt; 0 then
MoveDir = MoveDir.Unit
end
local NewPosition = Camera.CFrame.Position + MoveDir *

FreeCamState.Speed * DeltaTime

Camera.CFrame = CFrame.new(NewPosition) * Rotation
end)
table.insert(FreeCamState.Connections, InputChangedConn)
table.insert(FreeCamState.Connections, RenderConn)
end
local function StopFreeCam()
for _, Conn in ipairs(FreeCamState.Connections) do
Conn:Disconnect()
end
FreeCamState.Connections = {}
UserInputService.MouseBehavior = Enum.MouseBehavior.Default
Camera.CameraType = Enum.CameraType.Custom
SetCharacterVisibility(true)
end

local AntiLagState = {
Active = false,
OriginalStates = {},
}
local function ApplyAntiLag()
for _, Descendant in ipairs(Workspace:GetDescendants()) do
if Descendant:IsA(&quot;ParticleEmitter&quot;) or Descendant:IsA(&quot;Trail&quot;) or

Descendant:IsA(&quot;Smoke&quot;) or Descendant:IsA(&quot;Fire&quot;) then

AntiLagState.OriginalStates[Descendant] = { Enabled =

Descendant.Enabled }

Descendant.Enabled = false
elseif Descendant:IsA(&quot;BasePart&quot;) then
AntiLagState.OriginalStates[Descendant] = { CastShadow =

Descendant.CastShadow }

Descendant.CastShadow = false
end
end
Lighting.GlobalShadows = false
end
local function RevertAntiLag()
for Descendant, OriginalState in pairs(AntiLagState.OriginalStates) do
if Descendant and Descendant.Parent then
if OriginalState.Enabled ~= nil then
Descendant.Enabled = OriginalState.Enabled
end
if OriginalState.CastShadow ~= nil then
Descendant.CastShadow = OriginalState.CastShadow
end
end
end
AntiLagState.OriginalStates = {}
Lighting.GlobalShadows = true
end
local FullbrightState = {
Active = false,
Original = {},
}
local function ApplyFullbright()
FullbrightState.Original = {

Ambient = Lighting.Ambient,
OutdoorAmbient = Lighting.OutdoorAmbient,
FogEnd = Lighting.FogEnd,
FogStart = Lighting.FogStart,
}
Lighting.Ambient = Color3.new(1, 1, 1)
Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
Lighting.FogStart = 0
Lighting.FogEnd = 100000
end
local function RevertFullbright()
Lighting.Ambient = FullbrightState.Original.Ambient or Color3.new(0, 0, 0)
Lighting.OutdoorAmbient = FullbrightState.Original.OutdoorAmbient or
Color3.new(0, 0, 0)
Lighting.FogStart = FullbrightState.Original.FogStart or 0
Lighting.FogEnd = FullbrightState.Original.FogEnd or 100000
end
local CrosshairFrame = Instance.new(&quot;Frame&quot;)
CrosshairFrame.Name = &quot;Crosshair&quot;
CrosshairFrame.Size = UDim2.new(0, 20, 0, 20)
CrosshairFrame.Position = UDim2.new(0.5, -10, 0.5, -10)
CrosshairFrame.BackgroundTransparency = 1
CrosshairFrame.Visible = false
CrosshairFrame.Parent = ScreenGui
local HorizontalLine = Instance.new(&quot;Frame&quot;)
HorizontalLine.Name = &quot;HorizontalLine&quot;
HorizontalLine.Size = UDim2.new(1, 0, 0, 2)
HorizontalLine.Position = UDim2.new(0, 0, 0.5, -1)
HorizontalLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
HorizontalLine.BorderSizePixel = 0
HorizontalLine.Parent = CrosshairFrame
local VerticalLine = Instance.new(&quot;Frame&quot;)
VerticalLine.Name = &quot;VerticalLine&quot;
VerticalLine.Size = UDim2.new(0, 2, 1, 0)
VerticalLine.Position = UDim2.new(0.5, -1, 0, 0)
VerticalLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
VerticalLine.BorderSizePixel = 0
VerticalLine.Parent = CrosshairFrame

local NoclipButton = CreateToggleButton(&quot;NoClip&quot;, 1)
NoclipButton.MouseButton1Click:Connect(function()
NoclipState.Active = not NoclipState.Active
if NoclipState.Active then
StartNoclip()
else
StopNoclip()
end
SetButtonState(NoclipButton, &quot;NoClip&quot;, NoclipState.Active)
end)
local FreeCamButton = CreateToggleButton(&quot;Free-Cam&quot;, 2)
FreeCamButton.MouseButton1Click:Connect(function()
FreeCamState.Active = not FreeCamState.Active
if FreeCamState.Active then
StartFreeCam()
else
StopFreeCam()
end
SetButtonState(FreeCamButton, &quot;Free-Cam&quot;, FreeCamState.Active)
end)
local AntiLagButton = CreateToggleButton(&quot;Anti-Lag&quot;, 3)
AntiLagButton.MouseButton1Click:Connect(function()
AntiLagState.Active = not AntiLagState.Active
if AntiLagState.Active then
ApplyAntiLag()
else
RevertAntiLag()
end
SetButtonState(AntiLagButton, &quot;Anti-Lag&quot;, AntiLagState.Active)
end)
local FullbrightButton = CreateToggleButton(&quot;Fullbright&quot;, 4)
FullbrightButton.MouseButton1Click:Connect(function()
FullbrightState.Active = not FullbrightState.Active
if FullbrightState.Active then
ApplyFullbright()
else
RevertFullbright()
end
SetButtonState(FullbrightButton, &quot;Fullbright&quot;, FullbrightState.Active)
end)

local CrosshairButton = CreateToggleButton(&quot;Crosshair&quot;, 5)
CrosshairButton.MouseButton1Click:Connect(function()
CrosshairFrame.Visible = not CrosshairFrame.Visible
SetButtonState(CrosshairButton, &quot;Crosshair&quot;, CrosshairFrame.Visible)
end)
LocalPlayer.CharacterAdded:Connect(function()
if FreeCamState.Active then
SetCharacterVisibility(false)
end
end)
