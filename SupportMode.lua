local P,R,L,W,U,V=game:GetService("Players"),game:GetService("RunService"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("UserInputService"),game:GetService("VirtualUser")
local p=P.LocalPlayer
local c=W.CurrentCamera

local g=Instance.new("ScreenGui")
g.Name="izHub"
g.ResetOnSpawn=false
pcall(function() g.Parent=p:WaitForChild("PlayerGui") end)

local f=Instance.new("Frame",g)
f.Size,f.Position,f.BackgroundColor3,f.BorderSizePixel,f.Active,f.Draggable=UDim2.new(0,340,0,420),UDim2.new(0.5,-170,0.5,-210),Color3.fromRGB(15,20,28),0,true,true
local cr=Instance.new("UICorner",f) cr.CornerRadius=UDim.new(0,10)
local str=Instance.new("UIStroke",f) str.Color,str.Thickness=Color3.fromRGB(0,140,255),1.5

-- TopBar
local top=Instance.new("Frame",f)
top.Size,top.BackgroundColor3,top.BorderSizePixel=UDim2.new(1,0,0,40),Color3.fromRGB(10,14,22),0
local topCr=Instance.new("UICorner",top) topCr.CornerRadius=UDim.new(0,10)

-- Cyber Eye Logo (Custom Unique Vector)
local eyeContainer=Instance.new("Frame",top)
eyeContainer.Size,eyeContainer.Position,eyeContainer.BackgroundTransparency=UDim2.new(0,26,0,26),UDim2.new(0,10,0,7),1

local eyeOuter=Instance.new("Frame",eyeContainer)
eyeOuter.Size,eyeOuter.Position,eyeOuter.BackgroundColor3,eyeOuter.Rotation=UDim2.new(0,18,0,18),UDim2.new(0,4,0,4),Color3.fromRGB(0,140,255),45
local eyeOuterCr=Instance.new("UICorner",eyeOuter) eyeOuterCr.CornerRadius=UDim.new(0,4)

local eyeInner=Instance.new("Frame",eyeOuter)
eyeInner.Size,eyeInner.Position,eyeInner.BackgroundColor3=UDim2.new(0,12,0,12),UDim2.new(0,3,0,3),Color3.fromRGB(10,14,22)
local eyeInnerCr=Instance.new("UICorner",eyeInner) eyeInnerCr.CornerRadius=UDim.new(0,3)

local eyePupil=Instance.new("Frame",eyeInner)
eyePupil.Size,eyePupil.Position,eyePupil.BackgroundColor3=UDim2.new(0,6,0,6),UDim2.new(0,3,0,3),Color3.fromRGB(0,220,255)
local eyePupilCr=Instance.new("UICorner",eyePupil) eyePupilCr.CornerRadius=UDim.new(1,0)

local t=Instance.new("TextLabel",top)
t.Size,t.Position,t.BackgroundTransparency,t.Text,t.TextColor3,t.Font,t.TextSize=UDim2.new(1,-80,1,0),UDim2.new(0,42,0,0),1,"izHub",Color3.fromRGB(0,170,255),Enum.Font.GothamBold,15
t.TextXAlignment=Enum.TextXAlignment.Left

local minBtn=Instance.new("TextButton",top)
minBtn.Size,minBtn.Position,minBtn.BackgroundTransparency,minBtn.Text,minBtn.TextColor3,minBtn.Font,minBtn.TextSize=UDim2.new(0,30,0,30),UDim2.new(1,-32,0,5),1,"-",Color3.fromRGB(200,220,255),Enum.Font.GothamBold,18

-- Tab Container
local tabFrame=Instance.new("Frame",f)
tabFrame.Size,tabFrame.Position,tabFrame.BackgroundColor3=UDim2.new(0,90,1,-45),UDim2.new(0,5,0,40),Color3.fromRGB(12,16,23)
local tabCr=Instance.new("UICorner",tabFrame) tabCr.CornerRadius=UDim.new(0,6)
local tabLayout=Instance.new("UIListLayout",tabFrame) tabLayout.Padding=UDim.new(0,4)

local container=Instance.new("Frame",f)
container.Size,container.Position,container.BackgroundTransparency=UDim2.new(1,-105,1,-45),UDim2.new(0,100,0,40),1

local tabs,pages={},{}
local function createTab(name)
	local tb=Instance.new("TextButton",tabFrame)
	tb.Size,tb.BackgroundColor3,tb.TextColor3,tb.Font,tb.TextSize,tb.Text=UDim2.new(1,0,0,32),Color3.fromRGB(20,26,36),Color3.fromRGB(150,180,210),Enum.Font.GothamBold,11,name
	local r=Instance.new("UICorner",tb) r.CornerRadius=UDim.new(0,6)
	
	local pg=Instance.new("ScrollingFrame",container)
	pg.Size,pg.BackgroundTransparency,pg.BorderSizePixel,pg.ScrollBarThickness,pg.Visible=UDim2.new(1,0,1,0),1,0,3,false
	pg.CanvasSize=UDim2.new(0,0,0,450) pg.ScrollBarImageColor3=Color3.fromRGB(0,140,255)
	local l=Instance.new("UIListLayout",pg) l.Padding=UDim.new(0,5)
	
	tb.MouseButton1Click:Connect(function()
		for _,v in pairs(pages) do v.Visible=false end
		for _,v in pairs(tabs) do v.BackgroundColor3=Color3.fromRGB(20,26,36) v.TextColor3=Color3.fromRGB(150,180,210) end
		pg.Visible=true tb.BackgroundColor3=Color3.fromRGB(0,120,230) tb.TextColor3=Color3.fromRGB(255,255,255)
	end)
	table.insert(tabs,tb) pages[name]=pg
	return pg
end

local mainPage=createTab("Main")
local pvpPage=createTab("Combat")
local visualPage=createTab("Visuals")
local miscPage=createTab("Misc")

-- Tab Mặc Định
pages["Main"].Visible=true tabs[1].BackgroundColor3=Color3.fromRGB(0,120,230) tabs[1].TextColor3=Color3.fromRGB(255,255,255)

local min=false
minBtn.MouseButton1Click:Connect(function()
	min=not min
	f:TweenSize(min and UDim2.new(0,340,0,40) or UDim2.new(0,340,0,420),"Out","Quad",0.2,true)
end)

local function b(parent,k)
	local x=Instance.new("TextButton",parent)
	x.Size,x.BackgroundColor3,x.TextColor3,x.Font,x.TextSize,x.Text=UDim2.new(1,-5,0,32),Color3.fromRGB(22,30,42),Color3.fromRGB(180,210,245),Enum.Font.GothamBold,11,k..": OFF"
	local r=Instance.new("UICorner",x) r.CornerRadius=UDim.new(0,6)
	local xs=Instance.new("UIStroke",x) xs.Color,xs.Thickness=Color3.fromRGB(35,50,70),1
	return x
end

local function s(x,k,o)
	x.Text=k..": "..(o and "ON" or "OFF")
	x.BackgroundColor3=o and Color3.fromRGB(0,110,220) or Color3.fromRGB(22,30,42)
	x.TextColor3=o and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,210,245)
end

---------------- TAB MAIN ----------------
local al={a=false,o={}}
local function toggleAL()
	al.a=not al.a
	if al.a then
		for _,v in ipairs(W:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then al.o[v]={Enabled=v.Enabled} v.Enabled=false
			elseif v:IsA("BasePart") then al.o[v]={CastShadow=v.CastShadow} v.CastShadow=false end
		end
		L.GlobalShadows=false
	else
		for k,v in pairs(al.o) do if k and k.Parent then if v.Enabled~=nil then k.Enabled=v.Enabled end if v.CastShadow~=nil then k.CastShadow=v.CastShadow end end end
		al.o={} L.GlobalShadows=true
	end
end

local fl={a=false,bv=nil,bg=nil,c=nil}
local function toggleFly()
	fl.a=not fl.a
	local char=p.Character local hrp=char and char:FindFirstChild("HumanoidRootPart") local hum=char and char:FindFirstChildOfClass("Humanoid")
	if fl.a and hrp then
		fl.bv=Instance.new("BodyVelocity") fl.bv.Name="izFlyVelocity" fl.bv.MaxForce=Vector3.new(1e9,1e9,1e9) fl.bv.Parent=hrp
		fl.bg=Instance.new("BodyGyro") fl.bg.Name="izFlyGyro" fl.bg.MaxTorque=Vector3.new(1e9,1e9,1e9) fl.bg.Parent=hrp
		fl.c=R.Heartbeat:Connect(function()
			if not fl.a or not hrp then return end
			local mv=Vector3.new()
			if U:IsKeyDown(Enum.KeyCode.W) then mv+=c.CFrame.LookVector end
			if U:IsKeyDown(Enum.KeyCode.S) then mv-=c.CFrame.LookVector end
			if U:IsKeyDown(Enum.KeyCode.A) then mv-=c.CFrame.RightVector end
			if U:IsKeyDown(Enum.KeyCode.D) then mv+=c.CFrame.RightVector end
			if U:IsKeyDown(Enum.KeyCode.Space) then mv+=Vector3.new(0,1,0) end
			if U:IsKeyDown(Enum.KeyCode.LeftControl) then mv-=Vector3.new(0,1,0) end
			if mv.Magnitude>0 then mv=mv.Unit end
			fl.bv.Velocity=mv*60 fl.bg.CFrame=c.CFrame
		end)
	else
		if fl.c then fl.c:Disconnect() fl.c=nil end
		if fl.bv then fl.bv:Destroy() fl.bv=nil end
		if fl.bg then fl.bg:Destroy() fl.bg=nil end
		if hrp then
			for _,v in ipairs(hrp:GetChildren()) do if v.Name=="izFlyVelocity" or v.Name=="izFlyGyro" or v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end
			hrp.Velocity=Vector3.new(0,0,0)
		end
		if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
	end
end

local nc={a=false,c=nil}
local function toggleNC()
	nc.a=not nc.a
	if nc.a then nc.c=R.Stepped:Connect(function() local k=p.Character if k then for _,v in ipairs(k:GetChildren()) do if v:IsA("BasePart") then v.CanCollide=false end end end end)
	else if nc.c then nc.c:Disconnect() nc.c=nil end end
end

local sp={a=false}
local function toggleSP()
	sp.a=not sp.a local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
	if h then h.WalkSpeed=sp.a and 80 or 16 h.JumpPower=sp.a and 100 or 50 end
end

local ij={a=false,c=nil}
local function toggleIJ()
	ij.a=not ij.a
	if ij.a then ij.c=U.JumpRequest:Connect(function() if ij.a and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then p.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)
	else if ij.c then ij.c:Disconnect() ij.c=nil end end
end

---------------- TAB COMBAT ----------------
local ab={a=false,c=nil}
local function getClosest()
	local cl,dist=nil,math.huge
	for _,v in ipairs(P:GetPlayers()) do
		if v~=p and v.Character and v.Character:FindFirstChild("Head") then
			local pos,vis=c:WorldToViewportPoint(v.Character.Head.Position)
			if vis then local mag=(Vector2.new(pos.X,pos.Y)-U:GetMouseLocation()).Magnitude if mag<dist then cl=v.Character.Head dist=mag end end
		end
	end return cl
end
local function toggleAB()
	ab.a=not ab.a
	if ab.a then ab.c=R.RenderStepped:Connect(function() local t=getClosest() if t then c.CFrame=CFrame.new(c.CFrame.Position,t.Position) end end)
	else if ab.c then ab.c:Disconnect() ab.c=nil end end
end

local hb={a=false,c=nil}
local function toggleHB()
	hb.a=not hb.a
	if hb.a then
		hb.c=R.RenderStepped:Connect(function()
			for _,v in ipairs(P:GetPlayers()) do
				if v~=p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
					local hrp=v.Character.HumanoidRootPart hrp.Size=Vector3.new(12,12,12) hrp.Transparency=0.7 hrp.Color=Color3.fromRGB(0,140,255) hrp.CanCollide=false
				end
			end
		end)
	else
		if hb.c then hb.c:Disconnect() hb.c=nil end
		for _,v in ipairs(P:GetPlayers()) do if v~=p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then local hrp=v.Character.HumanoidRootPart hrp.Size=Vector3.new(2,2,1) hrp.Transparency=1 end end
	end
end

local ac={a=false,c=nil}
local function toggleAC()
	ac.a=not ac.a
	if ac.a then ac.c=R.RenderStepped:Connect(function() local tool=p.Character and p.Character:FindFirstChildOfClass("Tool") if tool then tool:Activate() end end)
	else if ac.c then ac.c:Disconnect() ac.c=nil end end
end

local sa={a=false,c=nil}
local function toggleSA()
	sa.a=not sa.a
	if sa.a then
		sa.c=R.RenderStepped:Connect(function()
			local t=getClosest()
			if t and p.Character and p.Character:FindFirstChildOfClass("Tool") then
				p.Character:FindFirstChildOfClass("Tool").SetPrimaryPartCFrame=CFrame.new(t.Position)
			end
		end)
	else if sa.c then sa.c:Disconnect() sa.c=nil end end
end

---------------- TAB VISUALS ----------------
local esp={a=false,h={}}
local function toggleESP()
	esp.a=not esp.a
	if not esp.a then for _,v in pairs(esp.h) do if v then v:Destroy() end end esp.h={}
	else
		for _,v in ipairs(P:GetPlayers()) do
			if v~=p and v.Character then
				local h=Instance.new("Highlight") h.Name="izESP" h.FillColor=Color3.fromRGB(0,150,255) h.OutlineColor=Color3.fromRGB(255,255,255) h.FillTransparency=0.5 h.Adornee=v.Character h.Parent=v.Character esp.h[v]=h
			end
		end
	end
end

local fb={a=false,o={}}
local function toggleFB()
	fb.a=not fb.a
	if fb.a then fb.o={a=L.Ambient,oa=L.OutdoorAmbient} L.Ambient=Color3.new(1,1,1) L.OutdoorAmbient=Color3.new(1,1,1)
	else L.Ambient=fb.o.a or Color3.new(0,0,0) L.OutdoorAmbient=fb.o.oa or Color3.new(0,0,0) end
end

local fov={a=false}
local function toggleFOV()
	fov.a=not fov.a
	c.FieldOfView=fov.a and 120 or 70
end

---------------- TAB MISC ----------------
local afk={a=false,c=nil}
local function toggleAFK()
	afk.a=not afk.a
	if afk.a then afk.c=p.Idled:Connect(function() V:Button2Down(Vector2.new(0,0),c.CFrame) task.wait(1) V:Button2Up(Vector2.new(0,0),c.CFrame) end)
	else if afk.c then afk.c:Disconnect() afk.c=nil end end
end

local function giveBTools()
	for i=1,4 do local t=Instance.new("HopperBin") t.BinType=i t.Parent=p:WaitForChild("Backpack") end
end

local function giveTPTool()
	local tool=Instance.new("Tool") tool.Name="TP Click" tool.RequiresHandle=false tool.Parent=p:WaitForChild("Backpack")
	tool.Activated:Connect(function()
		local pos=p:GetMouse().Hit
		if pos and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.CFrame=CFrame.new(pos.Position+Vector3.new(0,3,0)) end
	end)
end

-- Connect Buttons
local bM1=b(mainPage,"Anti-Lag") bM1.MouseButton1Click:Connect(function() toggleAL() s(bM1,"Anti-Lag",al.a) end)
local bM2=b(mainPage,"Fly OP") bM2.MouseButton1Click:Connect(function() toggleFly() s(bM2,"Fly OP",fl.a) end)
local bM3=b(mainPage,"No Clip") bM3.MouseButton1Click:Connect(function() toggleNC() s(bM3,"No Clip",nc.a) end)
local bM4=b(mainPage,"Speed/Jump") bM4.MouseButton1Click:Connect(function() toggleSP() s(bM4,"Speed/Jump",sp.a) end)
local bM5=b(mainPage,"Inf Jump") bM5.MouseButton1Click:Connect(function() toggleIJ() s(bM5,"Inf Jump",ij.a) end)

local bC1=b(pvpPage,"Aimbot Lock") bC1.MouseButton1Click:Connect(function() toggleAB() s(bC1,"Aimbot Lock",ab.a) end)
local bC2=b(pvpPage,"Hitbox Expander") bC2.MouseButton1Click:Connect(function() toggleHB() s(bC2,"Hitbox Expander",hb.a) end)
local bC3=b(pvpPage,"Auto Clicker") bC3.MouseButton1Click:Connect(function() toggleAC() s(bC3,"Auto Clicker",ac.a) end)
local bC4=b(pvpPage,"Silent Aim") bC4.MouseButton1Click:Connect(function() toggleSA() s(bC4,"Silent Aim",sa.a) end)

local bV1=b(visualPage,"ESP Highlight") bV1.MouseButton1Click:Connect(function() toggleESP() s(bV1,"ESP Highlight",esp.a) end)
local bV2=b(visualPage,"Fullbright") bV2.MouseButton1Click:Connect(function() toggleFB() s(bV2,"Fullbright",fb.a) end)
local bV3=b(visualPage,"Pro FOV (120)") bV3.MouseButton1Click:Connect(function() toggleFOV() s(bV3,"Pro FOV (120)",fov.a) end)

local bX1=b(miscPage,"Anti-AFK") bX1.MouseButton1Click:Connect(function() toggleAFK() s(bX1,"Anti-AFK",afk.a) end)
local bX2=b(miscPage,"Get BTools") bX2.MouseButton1Click:Connect(function() giveBTools() bX2.Text="BTools Added!" end)
local bX3=b(miscPage,"Get TP Tool") bX3.MouseButton1Click:Connect(function() giveTPTool() bX3.Text="TP Tool Added!" end)
