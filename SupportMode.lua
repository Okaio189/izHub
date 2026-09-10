local P=game:GetService("Players")
local R=game:GetService("RunService")
local U=game:GetService("UserInputService")
local L=game:GetService("Lighting")
local W=game:GetService("Workspace")

local p=P.LocalPlayer
local c=W.CurrentCamera

local g=Instance.new("ScreenGui")
g.Name="G"
g.ResetOnSpawn=false
g.Parent=p:WaitForChild("PlayerGui")

local f=Instance.new("Frame")
f.Size=UDim2.new(0,220,0,270)
f.Position=UDim2.new(0,20,0,20)
f.BackgroundColor3=Color3.fromRGB(30,30,30)
f.BorderSizePixel=0
f.Active=true
f.Draggable=true
f.Parent=g

local l=Instance.new("UIListLayout")
l.Padding=UDim.new(0,8)
l.Parent=f

local d=Instance.new("UIPadding")
d.PaddingTop=UDim.new(0,10)
d.PaddingLeft=UDim.new(0,10)
d.PaddingRight=UDim.new(0,10)
d.Parent=f

local function b(t,o)
	local x=Instance.new("TextButton")
	x.Size=UDim2.new(1,0,0,36)
	x.BackgroundColor3=Color3.fromRGB(60,60,60)
	x.TextColor3=Color3.fromRGB(255,255,255)
	x.Font=Enum.Font.GothamBold
	x.TextSize=14
	x.Text=t..": OFF"
	x.LayoutOrder=o
	x.Parent=f
	return x
end

local function s(x,t,o)
	x.Text=t..": "..(o and "ON" or "OFF")
	x.BackgroundColor3=o and Color3.fromRGB(40,130,70) or Color3.fromRGB(60,60,60)
end

local n={a=false,c=nil}
local function startN()
	n.c=R.Stepped:Connect(function()
		local k=p.Character
		if k then
			for _,v in ipairs(k:GetDescendants()) do
				if v:IsA("BasePart") then v.CanCollide=false end
			end
		end
	end)
end
local function stopN()
	if n.c then n.c:Disconnect() n.c=nil end
	local k=p.Character
	if k then
		for _,v in ipairs(k:GetDescendants()) do
			if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then v.CanCollide=true end
		end
	end
end

local fc={a=false,c={},s=60,x=0,y=0}
local function setV(v)
	local k=p.Character
	if not k then return end
	local m=v and 0 or 1
	for _,v in ipairs(k:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("Decal") then v.LocalTransparencyModifier=m end
	end
end
local function startF()
	local rx,ry,_=c.CFrame:ToOrientation()
	fc.y=rx
	fc.x=ry
	setV(false)
	c.CameraType=Enum.CameraType.Scriptable
	U.MouseBehavior=Enum.MouseBehavior.LockCenter
	local i=U.InputChanged:Connect(function(ip)
		if ip.UserInputType==Enum.UserInputType.MouseMovement then
			fc.x-=ip.Delta.X*0.003
			fc.y-=ip.Delta.Y*0.003
			fc.y=math.clamp(fc.y,-math.rad(85),math.rad(85))
		end
	end)
	local r=R.RenderStepped:Connect(function(dt)
		local rot=CFrame.fromOrientation(fc.y,fc.x,0)
		local mv=Vector3.new()
		if U:IsKeyDown(Enum.KeyCode.W) then mv+=rot.LookVector end
		if U:IsKeyDown(Enum.KeyCode.S) then mv-=rot.LookVector end
		if U:IsKeyDown(Enum.KeyCode.A) then mv-=rot.RightVector end
		if U:IsKeyDown(Enum.KeyCode.D) then mv+=rot.RightVector end
		if U:IsKeyDown(Enum.KeyCode.Space) then mv+=Vector3.new(0,1,0) end
		if U:IsKeyDown(Enum.KeyCode.LeftControl) then mv-=Vector3.new(0,1,0) end
		if mv.Magnitude>0 then mv=mv.Unit end
		c.CFrame=CFrame.new(c.CFrame.Position+mv*fc.s*dt)*rot
	end)
	table.insert(fc.c,i)
	table.insert(fc.c,r)
end
local function stopF()
	for _,v in ipairs(fc.c) do v:Disconnect() end
	fc.c={}
	U.MouseBehavior=Enum.MouseBehavior.Default
	c.CameraType=Enum.CameraType.Custom
	setV(true)
end

local al={a=false,o={}}
local function applyA()
	for _,v in ipairs(W:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
			al.o[v]={Enabled=v.Enabled}
			v.Enabled=false
		elseif v:IsA("BasePart") then
			al.o[v]={CastShadow=v.CastShadow}
			v.CastShadow=false
		end
	end
	L.GlobalShadows=false
end
local function revertA()
	for k,v in pairs(al.o) do
		if k and k.Parent then
			if v.Enabled~=nil then k.Enabled=v.Enabled end
			if v.CastShadow~=nil then k.CastShadow=v.CastShadow end
		end
	end
	al.o={}
	L.GlobalShadows=true
end

local fb={a=false,o={}}
local function applyFB()
	fb.o={Ambient=L.Ambient,OutdoorAmbient=L.OutdoorAmbient,FogEnd=L.FogEnd,FogStart=L.FogStart}
	L.Ambient=Color3.new(1,1,1)
	L.OutdoorAmbient=Color3.new(1,1,1)
	L.FogStart=0
	L.FogEnd=100000
end
local function revertFB()
	L.Ambient=fb.o.Ambient or Color3.new(0,0,0)
	L.OutdoorAmbient=fb.o.OutdoorAmbient or Color3.new(0,0,0)
	L.FogStart=fb.o.FogStart or 0
	L.FogEnd=fb.o.FogEnd or 100000
end

local ch=Instance.new("Frame")
ch.Name="CH"
ch.Size=UDim2.new(0,20,0,20)
ch.Position=UDim2.new(0.5,-10,0.5,-10)
ch.BackgroundTransparency=1
ch.Visible=false
ch.Parent=g

local h=Instance.new("Frame")
h.Size=UDim2.new(1,0,0,2)
h.Position=UDim2.new(0,0,0.5,-1)
h.BackgroundColor3=Color3.fromRGB(255,0,0)
h.BorderSizePixel=0
h.Parent=ch

local v=Instance.new("Frame")
v.Size=UDim2.new(0,2,1,0)
v.Position=UDim2.new(0.5,-1,0,0)
v.BackgroundColor3=Color3.fromRGB(255,0,0)
v.BorderSizePixel=0
v.Parent=ch

local bN=b("NoClip",1)
bN.MouseButton1Click:Connect(function()
	n.a=not n.a
	if n.a then startN() else stopN() end
	s(bN,"NoClip",n.a)
end)

local bF=b("Free-Cam",2)
bF.MouseButton1Click:Connect(function()
	fc.a=not fc.a
	if fc.a then startF() else stopF() end
	s(bF,"Free-Cam",fc.a)
end)

local bA=b("Anti-Lag",3)
bA.MouseButton1Click:Connect(function()
	al.a=not al.a
	if al.a then applyA() else revertA() end
	s(bA,"Anti-Lag",al.a)
end)

local bB=b("Fullbright",4)
bB.MouseButton1Click:Connect(function()
	fb.a=not fb.a
	if fb.a then applyFB() else revertFB() end
	s(bB,"Fullbright",fb.a)
end)

local bC=b("Crosshair",5)
bC.MouseButton1Click:Connect(function()
	ch.Visible=not ch.Visible
	s(bC,"Crosshair",ch.Visible)
end)

p.CharacterAdded:Connect(function()
	if fc.a then setV(false) end
end)
