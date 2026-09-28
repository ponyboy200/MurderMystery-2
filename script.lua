

-- [[ MURDER MYSTERY 2 SHOWCASE BOOSTING GUI ]] ---- Watermark: muna_boost_off-- Compatibility: Delta, Fluxus, Arceus X
local UserInputService = game:GetService("UserInputService")local Players = game:GetService("Players")local LocalPlayer = Players.LocalPlayerlocal CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MunaBoostGui"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGuiend)
local function makeDrag(gui, dragPart)
    local dragging, dragInput, dragStart, startPos
    dragPart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    dragPart.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)end
local function makeResize(gui, resizeBtn, minW, minH, maxW, maxH)
    local resizing = false
    local dragStart, startSize
    resizeBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            dragStart = input.Position
            startSize = gui.Size
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local newW = math.clamp(startSize.X.Offset + delta.X, minW, maxW)
            local newH = math.clamp(startSize.Y.Offset + delta.Y, minH, maxH)
            gui.Size = UDim2.new(0, newW, 0, newH)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)end
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 480)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0.12, 0)
MainCorner.Parent = MainFrame
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar
local TopWatermark = Instance.new("TextLabel")
TopWatermark.Size = UDim2.new(0.7, 0, 1, 0)
TopWatermark.Position = UDim2.new(0, 10, 0, 0)
TopWatermark.Text = "muna_boost_off"
TopWatermark.TextColor3 = Color3.fromRGB(255, 255, 255)
TopWatermark.Font = Enum.Font.GothamBold
TopWatermark.TextSize = 14
TopWatermark.TextXAlignment = Enum.TextXAlignment.Left
TopWatermark.BackgroundTransparency = 1
TopWatermark.Parent = TopBar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 2.5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.BackgroundTransparency = 1
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

makeDrag(MainFrame, TopBar)
local ResizeMain = Instance.new("TextButton")
ResizeMain.Size = UDim2.new(0, 15, 0, 15)
ResizeMain.Position = UDim2.new(1, -15, 1, -15)
ResizeMain.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
ResizeMain.Text = "◢"
ResizeMain.TextColor3 = Color3.fromRGB(255, 255, 255)
ResizeMain.TextSize = 10
ResizeMain.BorderSizePixel = 0
ResizeMain.Parent = MainFrame
makeResize(MainFrame, ResizeMain, 250, 350, 500, 700)
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 25)
StatusLabel.Position = UDim2.new(0, 10, 1, -30)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 30)
TabContainer.Position = UDim2.new(0, 10, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame
local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabContainer
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -20, 1, -115)
ContentContainer.Position = UDim2.new(0, 10, 0, 80)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame
local tabs = {"Control", "Players", "Items", "Spawner", "Values"}local tabFrames = {}
local function createTabButton(name, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 56, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.LayoutOrder = order
    btn.Parent = TabContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.CanvasSize = UDim2.new(0, 0, 2, 0)
    frame.ScrollBarThickness = 4
    frame.Parent = ContentContainer
    
    local frameList = Instance.new("UIListLayout")
    frameList.SortOrder = Enum.SortOrder.LayoutOrder
    frameList.Padding = UDim.new(0, 8)
    frameList.Parent = frame
    
    tabFrames[name] = frame
    
    btn.MouseButton1Click:Connect(function()
        for _, tName in ipairs(tabs) do
            tabFrames[tName].Visible = false
            TabContainer:GetChildren()[table.find(tabs, tName) + 1].BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        end
        frame.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(80, 60, 150)
    end)end
for i, tName in ipairs(tabs) do createTabButton(tName, i) end
tabFrames["Control"].Visible = true 
TabContainer:GetChildren().BackgroundColor3 = Color3.fromRGB(80, 60, 150)
local function createStyledButton(text, parent, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 34)
    b.BackgroundColor3 = Color3.fromRGB(80, 60, 150)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Parent = parent
    local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(0, 6) bc.Parent = b
    b.MouseButton1Click:Connect(callback)
    return bend
local FakeProfile = Instance.new("Frame")local FakeTrade = Instance.new("Frame")
local function setupExtraWindow(window, titleText, size, pos)
    window.Size = size
    window.Position = pos
    window.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    window.BorderSizePixel = 0
    window.Visible = false
    window.Parent = ScreenGui
    
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 12) c.Parent = window
    
    local tb = Instance.new("Frame")
    tb.Size = UDim2.new(1, 0, 0, 30)
    tb.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    tb.Parent = window
    local tbc = Instance.new("UICorner") tbc.CornerRadius = UDim.new(0, 12) tbc.Parent = tb
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.8, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.Text = titleText
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = tb
    
    local cb = Instance.new("TextButton")
    cb.Size = UDim2.new(0, 30, 0, 30)
    cb.Position = UDim2.new(1, -30, 0, 0)
    cb.Text = "X"
    cb.TextColor3 = Color3.fromRGB(255, 100, 100)
    cb.BackgroundTransparency = 1
    cb.Parent = tb
    cb.MouseButton1Click:Connect(function() window.Visible = false end)
    
    local rb = Instance.new("TextButton")
    rb.Size = UDim2.new(0, 12, 0, 12)
    rb.Position = UDim2.new(1, -12, 1, -12)
    rb.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    rb.Text = "◢"
    rb.TextColor3 = Color3.fromRGB(255, 255, 255)
    rb.TextSize = 8
    rb.Parent = window
    
    makeDrag(window, tb)
    makeResize(window, rb, 220, 220, 600, 600)end

setupExtraWindow(FakeProfile, "muna_boost_off - Profile", UDim2.new(0, 280, 0, 350), UDim2.new(0.4, 0, 0.15, 0))
setupExtraWindow(FakeTrade, "Fake Trade Session", UDim2.new(0, 400, 0, 300), UDim2.new(0.4, 0, 0.45, 0))
local Avatar = Instance.new("ImageLabel")
Avatar.Size = UDim2.new(0, 60, 0, 60)
Avatar.Position = UDim2.new(0, 10, 0, 40)
Avatar.BackgroundColor3 = Color3.fromRGB(45, 45, 65)

Avatar.Image = "rbxassetid://12543415160"
Avatar.Parent = FakeProfile
local ac = Instance.new("UICorner") ac.CornerRadius = UDim.new(0, 30) ac.Parent = Avatar
local ProfileGrid = Instance.new("ScrollingFrame")
ProfileGrid.Size = UDim2.new(1, -20, 1, -120)
ProfileGrid.Position = UDim2.new(0, 10, 0, 110)
ProfileGrid.BackgroundTransparency = 1
ProfileGrid.CanvasSize = UDim2.new(0, 0, 3, 0)
ProfileGrid.Parent = FakeProfile
local UIGrid = Instance.new("UIGridLayout")
UIGrid.CellSize = UDim2.new(0, 55, 0, 55)
UIGrid.Padding = UDim2.new(0, 8, 0, 8)
UIGrid.Parent = ProfileGrid
local fakeKnives = {"Shadow Knife", "Red Fang", "Blue Crystal", "Dark Blade", "Golden Knife", "Night Scythe", "Chroma Laser", "Corrupt"}
for _, kName in ipairs(fakeKnives) do
local item = Instance.new("Frame")
item.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
local ic = Instance.new("UICorner") ic.CornerRadius = UDim.new(0, 6) ic.Parent = item
local ilbl = Instance.new("TextLabel")
ilbl.Size = UDim2.new(1, 0, 1, 0)
ilbl.Text = kName
ilbl.TextColor3 = Color3.fromRGB(200, 200, 200)
ilbl.TextScaled = true
ilbl.BackgroundTransparency = 1
ilbl.Parent = item
item.Parent = ProfileGrid
end
local YourSide = Instance.new("ScrollingFrame")
YourSide.Size = UDim2.new(0.48, 0, 0.7, 0)
YourSide.Position = UDim2.new(0, 5, 0, 35)
YourSide.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
YourSide.Parent = FakeTrade
local ysList = Instance.new("UIListLayout") ysList.Parent = YourSide
local TheirSide = Instance.new("ScrollingFrame")
TheirSide.Size = UDim2.new(0.48, 0, 0.7, 0)
TheirSide.Position = UDim2.new(0.52, -5, 0, 35)
TheirSide.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
TheirSide.Parent = FakeTrade
local tsList = Instance.new("UIListLayout") tsList.Parent = TheirSide
for _, kName in ipairs(fakeKnives) do
local l1 = Instance.new("TextLabel")
l1.Size = UDim2.new(1, 0, 0, 20)
l1.Text = " " .. kName
l1.TextColor3 = Color3.fromRGB(255, 255, 255)
l1.TextXAlignment = Enum.TextXAlignment.Left
l1.BackgroundTransparency = 1
l1.Parent = YourSide
end
local AcceptTradeBtn = createStyledButton("Accept", FakeTrade, function()
StatusLabel.Text = "Status: Trade accepted!"
FakeTrade.Visible = false
end)
AcceptTradeBtn.Size = UDim2.new(0.45, 0, 0, 30)
AcceptTradeBtn.Position = UDim2.new(0, 5, 0.85, 0)
AcceptTradeBtn.BackgroundColor3 = Color3.fromRGB(60, 150, 60)
local DeclineTradeBtn = createStyledButton("Decline", FakeTrade, function()
StatusLabel.Text = "Status: Trade declined."
FakeTrade.Visible = false
end)
DeclineTradeBtn.Size = UDim2.new(0.45, 0, 0, 30)
DeclineTradeBtn.Position = UDim2.new(0.55, 0, 0.85, 0)
DeclineTradeBtn.BackgroundColor3 = Color3.fromRGB(150, 60, 60)
local ctrl = tabFrames["Control"]
local partnerLbl = Instance.new("TextLabel")
partnerLbl.Size = UDim2.new(1, 0, 0, 15)
partnerLbl.Text = "Partner user:"
partnerLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
partnerLbl.Font = Enum.Font.Gotham
partnerLbl.TextSize = 12
partnerLbl.TextXAlignment = Enum.TextXAlignment.Left
partnerLbl.BackgroundTransparency = 1
partnerLbl.Parent = ctrl
local partnerInput = Instance.new("TextBox")
partnerInput.Size = UDim2.new(1, 0, 0, 30)
partnerInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
partnerInput.Text = "muna_boost_off"
partnerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
partnerInput.Font = Enum.Font.Gotham
partnerInput.TextSize = 14
partnerInput.Parent = ctrl
local pic = Instance.new("UICorner") pic.CornerRadius = UDim.new(0, 6) pic.Parent = partnerInput
createStyledButton("Recent trade", ctrl, function() StatusLabel.Text = "Status: Showing recent trades..." end)
createStyledButton("Start trade", ctrl, function()
StatusLabel.Text = "Status: Trade session started with " .. partnerInput.Text
FakeTrade.Visible = true
end)
createStyledButton("Accept the other", ctrl, function() StatusLabel.Text = "Status: Accepted partner offer" end)
createStyledButton("Block player", ctrl, function() StatusLabel.Text = "Status: Player " .. partnerInput.Text .. " blocked." end)
createStyledButton("View Profile", ctrl, function() FakeProfile.Visible = true end)
local pTab = tabFrames["Players"]
local function updatePlayerList()
for _, child in ipairs(pTab:GetChildren()) do
if child:IsA("TextButton") then child:Destroy() end
end
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer then
createStyledButton(player.Name, pTab, function()
partnerInput.Text = player.Name
StatusLabel.Text = "Status: Selected target " .. player.Name
end)
end
end
end
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()
local iTab = tabFrames["Items"]
for _, kName in ipairs(fakeKnives) do
local itemLbl = Instance.new("TextLabel")
itemLbl.Size = UDim2.new(1, 0, 0, 30)
itemLbl.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
itemLbl.Text = " " .. kName
itemLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
itemLbl.Font = Enum.Font.Gotham
itemLbl.TextSize = 13
itemLbl.TextXAlignment = Enum.TextXAlignment.Left
itemLbl.Parent = iTab
local ic = Instance.new("UICorner") ic.CornerRadius = UDim.new(0, 6) ic.Parent = itemLbl
end
local sTab = tabFrames["Spawner"]
createStyledButton("Spawn Knife", sTab, function()
StatusLabel.Text = "Status: Successfully spawned visual knife!"
end)
local vTab = tabFrames["Values"]
local function createValueText(txt)
local l = Instance.new("TextLabel")
l.Size = UDim2.new(1, 0, 0, 25)
l.BackgroundTransparency = 1
l.Text = txt
l.TextColor3 = Color3.fromRGB(255, 255, 255)
l.Font = Enum.Font.GothamBold
l.TextSize = 14
l.TextXAlignment = Enum.TextXAlignment.Left
l.Parent = vTab
end
createValueText("Coins: 9999")
createValueText("Level: 100")
createValueText("Knives unlocked: 184")
StatusLabel.Text = "Status: GUI Loaded in MM2!"




			