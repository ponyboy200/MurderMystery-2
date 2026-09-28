--========================================================
-- muna_boost_off
-- GitHub script.lua
-- VISUAL TRADE / INVENTORY SHOWCASE
-- For own Roblox Murder Mystery 2
--========================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- CLEAN OLD GUI
--========================================================

local old = PlayerGui:FindFirstChild("MunaBoostGUI")
if old then
	old:Destroy()
end

--========================================================
-- COLORS
--========================================================

local COLORS = {
	Background = Color3.fromRGB(25, 25, 45),
	Panel = Color3.fromRGB(35, 35, 55),
	Secondary = Color3.fromRGB(45, 45, 68),
	Purple = Color3.fromRGB(82, 62, 155),
	PurpleHover = Color3.fromRGB(105, 80, 190),
	Input = Color3.fromRGB(27, 27, 45),
	White = Color3.fromRGB(255, 255, 255),
	Muted = Color3.fromRGB(170, 170, 190),
	Green = Color3.fromRGB(65, 180, 105),
	Red = Color3.fromRGB(190, 65, 75)
}

--========================================================
-- LOCAL DATA
--========================================================

local selectedPlayer = nil
local blockedPlayers = {}
local fakeInventory = {}
local currentTrade = nil

local Godlys = {
	"Chroma Luger",
	"Chroma Fang",
	"Chroma Heat",
	"Chroma Shark",
	"Chroma Slasher",
	"Chroma Laser",
	"Darkbringer",
	"Lightbringer",
	"Corrupt",
	"Harvester",
	"Swirly Blade",
	"Swirly Gun",
	"Bat",
	"Vampire's Edge",
	"Evergreen",
	"Elderwood Blade",
	"Nightblade",
	"Gemstone",
	"Red Luger",
	"Laser",
	"Shark",
	"Fang",
	"Heat",
	"Deathshard",
	"Slasher"
}

--========================================================
-- SCREEN GUI
--========================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "MunaBoostGUI"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--========================================================
-- MAIN WINDOW
--========================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(360, 520)
Main.Position = UDim2.new(0.5, -180, 0.5, -260)
Main.BackgroundColor3 = COLORS.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

--========================================================
-- TOP BAR
--========================================================

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 52)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.fromOffset(10, 0)
Title.BackgroundTransparency = 1
Title.Text = "muna_boost_off"
Title.TextColor3 = COLORS.White
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

--========================================================
-- DRAG WINDOW
--========================================================

local dragging = false
local dragStart
local startPosition

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = Main.Position
	end
end)

TopBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not dragging then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.MouseMovement
		and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	local delta = input.Position - dragStart

	Main.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)
end)

--========================================================
-- RESIZE HANDLE
--========================================================

local Resize = Instance.new("TextButton")
Resize.Size = UDim2.fromOffset(24, 24)
Resize.Position = UDim2.new(1, -28, 1, -28)
Resize.BackgroundColor3 = COLORS.Secondary
Resize.BorderSizePixel = 0
Resize.Text = "↘"
Resize.TextColor3 = COLORS.Muted
Resize.TextSize = 13
Resize.Parent = Main

local ResizeCorner = Instance.new("UICorner")
ResizeCorner.CornerRadius = UDim.new(0, 5)
ResizeCorner.Parent = Resize

local resizing = false
local resizeStart
local originalSize

Resize.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		resizing = true
		resizeStart = input.Position
		originalSize = Main.Size
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		resizing = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not resizing then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.MouseMovement
		and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	local delta = input.Position - resizeStart

	Main.Size = UDim2.fromOffset(
		math.max(290, originalSize.X.Offset + delta.X),
		math.max(400, originalSize.Y.Offset + delta.Y)
	)
end)

--========================================================
-- TABS
--========================================================

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.fromOffset(10, 48)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabBar

local Tabs = {}
local Pages = {}

local function createTab(name)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 62, 1, 0)
	button.BackgroundColor3 = COLORS.Secondary
	button.BorderSizePixel = 0
	button.Text = name
	button.TextColor3 = COLORS.White
	button.Font = Enum.Font.GothamSemibold
	button.TextSize = 9
	button.AutoButtonColor = false
	button.Parent = TabBar

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = button

	Tabs[name] = button

	return button
end

createTab("Control")
createTab("Players")
createTab("Items")
createTab("Spawner")
createTab("Values")

--========================================================
-- CONTENT
--========================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -135)
Content.Position = UDim2.fromOffset(10, 92)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function createPage(name)
	local page = Instance.new("Frame")
	page.Name = name .. "Page"
	page.Size = UDim2.fromScale(1, 1)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = Content

	Pages[name] = page

	return page
end

local Control = createPage("Control")
local PlayersPage = createPage("Players")
local ItemsPage = createPage("Items")
local Spawner = createPage("Spawner")
local Values = createPage("Values")

--========================================================
-- STATUS
--========================================================

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 32)
Status.Position = UDim2.new(0, 10, 1, -40)
Status.BackgroundColor3 = COLORS.Secondary
Status.BorderSizePixel = 0
Status.Text = "Status: Ready"
Status.TextColor3 = COLORS.Muted
Status.Font = Enum.Font.Gotham
Status.TextSize = 10
Status.Parent = Main

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 7)
StatusCorner.Parent = Status

local function setStatus(text)
	Status.Text = "Status: " .. text
end

--========================================================
-- BUTTON CREATOR
--========================================================

local function makeButton(parent, text, callback)
	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, 0, 0, 40)
	button.BackgroundColor3 = COLORS.Purple
	button.BorderSizePixel = 0
	button.Text = text
	button.TextColor3 = COLORS.White
	button.Font = Enum.Font.GothamSemibold
	button.TextSize = 11
	button.AutoButtonColor = false
	button.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = button

	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = COLORS.PurpleHover
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = COLORS.Purple
	end)

	button.MouseButton1Click:Connect(callback)

	return button
end

--========================================================
-- CONTROL
--========================================================

local controlLayout = Instance.new("UIListLayout")
controlLayout.Padding = UDim.new(0, 7)
controlLayout.Parent = Control

local partnerLabel = Instance.new("TextLabel")
partnerLabel.Size = UDim2.new(1, 0, 0, 18)
partnerLabel.BackgroundTransparency = 1
partnerLabel.Text = "Partner user:"
partnerLabel.TextColor3 = COLORS.White
partnerLabel.Font = Enum.Font.Gotham
partnerLabel.TextSize = 11
partnerLabel.TextXAlignment = Enum.TextXAlignment.Left
partnerLabel.Parent = Control

local partnerBox = Instance.new("TextBox")
partnerBox.Size = UDim2.new(1, 0, 0, 38)
partnerBox.BackgroundColor3 = COLORS.Input
partnerBox.BorderSizePixel = 0
partnerBox.Text = ""
partnerBox.PlaceholderText = "Select a player..."
partnerBox.PlaceholderColor3 = COLORS.Muted
partnerBox.TextColor3 = COLORS.White
partnerBox.Font = Enum.Font.Gotham
partnerBox.TextSize = 11
partnerBox.ClearTextOnFocus = false
partnerBox.Parent = Control

local partnerCorner = Instance.new("UICorner")
partnerCorner.CornerRadius = UDim.new(0, 7)
partnerCorner.Parent = partnerBox

--========================================================
-- FAKE TRADE WINDOW
--========================================================

local TradeWindow = Instance.new("Frame")
TradeWindow.Size = UDim2.fromOffset(600, 400)
TradeWindow.Position = UDim2.new(0.5, -300, 0.5, -200)
TradeWindow.BackgroundColor3 = COLORS.Background
TradeWindow.BorderSizePixel = 0
TradeWindow.Visible = false
TradeWindow.ZIndex = 20
TradeWindow.Parent = Gui

local tradeCorner = Instance.new("UICorner")
tradeCorner.CornerRadius = UDim.new(0, 12)
tradeCorner.Parent = TradeWindow

local tradeTitle = Instance.new("TextLabel")
tradeTitle.Size = UDim2.new(1, -20, 0, 38)
tradeTitle.Position = UDim2.fromOffset(10, 5)
tradeTitle.BackgroundTransparency = 1
tradeTitle.Text = "Fake Trade"
tradeTitle.TextColor3 = COLORS.White
tradeTitle.Font = Enum.Font.GothamBold
tradeTitle.TextSize = 17
tradeTitle.TextXAlignment = Enum.TextXAlignment.Left
tradeTitle.ZIndex = 21
tradeTitle.Parent = TradeWindow

local tradeTarget = Instance.new("TextLabel")
tradeTarget.Size = UDim2.new(1, -20, 0, 25)
tradeTarget.Position = UDim2.fromOffset(10, 42)
tradeTarget.BackgroundTransparency = 1
tradeTarget.Text = "Partner: none"
tradeTarget.TextColor3 = COLORS.Muted
tradeTarget.Font = Enum.Font.Gotham
tradeTarget.TextSize = 11
tradeTarget.ZIndex = 21
tradeTarget.Parent = TradeWindow

local yourOffer = Instance.new("ScrollingFrame")
yourOffer.Size = UDim2.new(0.47, -10, 0, 215)
yourOffer.Position = UDim2.fromOffset(10, 75)
yourOffer.BackgroundColor3 = COLORS.Panel
yourOffer.BorderSizePixel = 0
yourOffer.ScrollBarThickness = 4
yourOffer.ZIndex = 21
yourOffer.Parent = TradeWindow

local yourLayout = Instance.new("UIListLayout")
yourLayout.Padding = UDim.new(0, 5)
yourLayout.Parent = yourOffer

local otherOffer = Instance.new("Frame")
otherOffer.Size = UDim2.new(0.47, -10, 0, 215)
otherOffer.Position = UDim2.new(0.53, 0, 0, 75)
otherOffer.BackgroundColor3 = COLORS.Panel
otherOffer.BorderSizePixel = 0
otherOffer.ZIndex = 21
otherOffer.Parent = TradeWindow

local otherText = Instance.new("TextLabel")
otherText.Size = UDim2.fromScale(1, 1)
otherText.BackgroundTransparency = 1
otherText.Text = "Other player's offer\n\nVisual simulation"
otherText.TextColor3 = COLORS.Muted
otherText.Font = Enum.Font.Gotham
otherText.TextSize = 12
otherText.TextWrapped = true
otherText.ZIndex = 22
otherText.Parent = otherOffer

local closeTrade = makeButton(TradeWindow, "Close", function()
	TradeWindow.Visible = false
	setStatus("Fake trade closed")
end)

closeTrade.Size = UDim2.fromOffset(120, 38)
closeTrade.Position = UDim2.fromOffset(10, 315)
closeTrade.ZIndex = 21

local acceptTrade = makeButton(TradeWindow, "Accept the offer", function()
	setStatus("Fake offer accepted")
end)

acceptTrade.Size = UDim2.fromOffset(180, 38)
acceptTrade.Position = UDim2.new(1, -190, 0, 315)
acceptTrade.ZIndex = 21

--========================================================
-- REFRESH TRADE ITEMS
--========================================================

local function refreshTradeItems()
	for _, child in ipairs(yourOffer:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	for _, itemName in ipairs(fakeInventory) do
		local item = Instance.new("TextButton")

		item.Size = UDim2.new(1, -8, 0, 34)
		item.BackgroundColor3 = COLORS.Secondary
		item.BorderSizePixel = 0
		item.Text = itemName
		item.TextColor3 = COLORS.White
		item.Font = Enum.Font.Gotham
		item.TextSize = 10
		item.ZIndex = 22
		item.Parent = yourOffer

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 6)
		corner.Parent = item

		item.MouseButton1Click:Connect(function()
			setStatus(itemName .. " added to fake offer")
		end)
	end

	yourOffer.CanvasSize = UDim2.new(
		0,
		0,
		0,
		yourLayout.AbsoluteContentSize.Y + 10
	)
end

--========================================================
-- CONTROL BUTTONS
--========================================================

makeButton(Control, "Recent trade", function()
	setStatus("Recent trade selected")
end)

makeButton(Control, "Start trade", function()
	if partnerBox.Text == "" then
		setStatus("Select a player first")
		return
	end

	selectedPlayer = partnerBox.Text

	tradeTarget.Text = "Partner: " .. selectedPlayer

	TradeWindow.Visible = true

	refreshTradeItems()

	setStatus("Fake trade started with " .. selectedPlayer)
end)

makeButton(Control, "Accept the offer", function()
	if not selectedPlayer then
		setStatus("Select a player first")
		return
	end

	setStatus("Fake offer accepted for " .. selectedPlayer)
end)

makeButton(Control, "Block player", function()
	if partnerBox.Text == "" then
		setStatus("Select a player first")
		return
	end

	blockedPlayers[partnerBox.Text] = true

	setStatus(partnerBox.Text .. " blocked locally")

	-- Remove from player list visually
	task.defer(function()
		for _, child in ipairs(PlayersPage:GetChildren()) do
			if child:IsA("TextButton") and child.Text == partnerBox.Text then
				child:Destroy()
			end
		end
	end)
end)

--========================================================
-- PLAYERS PAGE
--========================================================

local playerScroll = Instance.new("ScrollingFrame")
playerScroll.Size = UDim2.fromScale(1, 1)
playerScroll.BackgroundTransparency = 1
playerScroll.BorderSizePixel = 0
playerScroll.ScrollBarThickness = 4
playerScroll.Parent = PlayersPage

local playerLayout = Instance.new("UIListLayout")
playerLayout.Padding = UDim.new(0, 6)
playerLayout.Parent = playerScroll

local function refreshPlayers()
	for _, child in ipairs(playerScroll:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	for _, target in ipairs(Players:GetPlayers()) do
		if target ~= LocalPlayer and not blockedPlayers[target.Name] then

			local button = makeButton(playerScroll, target.Name, function()

				selectedPlayer = target.Name
				partnerBox.Text = target.Name

				for _, page in pairs(Pages) do
					page.Visible = false
				end

				Control.Visible = true

				for _, tab in pairs(Tabs) do
					tab.BackgroundColor3 = COLORS.Secondary
				end

				Tabs.Control.BackgroundColor3 = COLORS.Purple

				setStatus("Selected " .. target.Name)
			end)

			button.Size = UDim2.new(1, -5, 0, 38)
		end
	end

	task.defer(function()
		playerScroll.CanvasSize = UDim2.new(
			0,
			0,
			0,
			playerLayout.AbsoluteContentSize.Y + 10
		)
	end)
end

Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

refreshPlayers()

--========================================================
-- ITEMS PAGE
--========================================================

local itemsScroll = Instance.new("ScrollingFrame")
itemsScroll.Size = UDim2.fromScale(1, 1)
itemsScroll.BackgroundTransparency = 1
itemsScroll.BorderSizePixel = 0
itemsScroll.ScrollBarThickness = 4
itemsScroll.Parent = ItemsPage

local itemsLayout = Instance.new("UIListLayout")
itemsLayout.Padding = UDim.new(0, 6)
itemsLayout.Parent = itemsScroll

for _, itemName in ipairs(Godlys) do

	local item = Instance.new("TextButton")

	item.Size = UDim2.new(1, -5, 0, 36)
	item.BackgroundColor3 = COLORS.Secondary
	item.BorderSizePixel = 0
	item.Text = itemName
	item.TextColor3 = COLORS.White
	item.Font = Enum.Font.Gotham
	item.TextSize = 11
	item.Parent = itemsScroll

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = item

	item.MouseButton1Click:Connect(function()

		table.insert(fakeInventory, itemName)

		refreshTradeItems()

		setStatus(itemName .. " added to local showcase inventory")
	end)
end

task.defer(function()
	itemsScroll.CanvasSize = UDim2.new(
		0,
		0,
		0,
		itemsLayout.AbsoluteContentSize.Y + 10
	)
end)

--========================================================
-- SPAWNER PAGE
--========================================================

local spawnerLayout = Instance.new("UIListLayout")
spawnerLayout.Padding = UDim.new(0, 8)
spawnerLayout.Parent = Spawner

makeButton(Spawner, "Spawn Knife", function()

	table.insert(fakeInventory, "Showcase Knife")

	refreshTradeItems()

	setStatus("Visual knife added")
end)

makeButton(Spawner, "Spawn All Godly Tradeable", function()

	table.clear(fakeInventory)

	for _, itemName in ipairs(Godlys) do
		table.insert(fakeInventory, itemName)
	end

	refreshTradeItems()

	setStatus(#Godlys .. " Godlys added to local showcase inventory")
end)

local spawnerInfo = Instance.new("TextLabel")
spawnerInfo.Size = UDim2.new(1, 0, 0, 70)
spawnerInfo.BackgroundTransparency = 1
spawnerInfo.Text = "LOCAL SHOWCASE\nThese items are visual only.\nYour real Roblox inventory is unchanged."
spawnerInfo.TextColor3 = COLORS.Muted
spawnerInfo.Font = Enum.Font.Gotham
spawnerInfo.TextSize = 10
spawnerInfo.TextWrapped = true
spawnerInfo.Parent = Spawner

--========================================================
-- VALUES PAGE
--========================================================

local valuesLayout = Instance.new("UIListLayout")
valuesLayout.Padding = UDim.new(0, 6)
valuesLayout.Parent = Values

local values = {
	"Coins: 9999",
	"Level: 100",
	"Godlys: 25",
	"Trades: 42",
	"Inventory items: 128"
}

for _, text in ipairs(values) do

	local value = Instance.new("TextLabel")

	value.Size = UDim2.new(1, 0, 0, 36)
	value.BackgroundColor3 = COLORS.Secondary
	value.BorderSizePixel = 0
	value.Text = text
	value.TextColor3 = COLORS.White
	value.Font = Enum.Font.Gotham
	value.TextSize = 11
	value.Parent = Values

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = value
end

--========================================================
-- TAB SWITCHING
--========================================================

local function openTab(name)

	for pageName, page in pairs(Pages) do
		page.Visible = pageName == name
	end

	for tabName, tab in pairs(Tabs) do
		if tabName == name then
			tab.BackgroundColor3 = COLORS.Purple
		else
			tab.BackgroundColor3 = COLORS.Secondary
		end
	end

	setStatus(name .. " opened")
end

for name, tab in pairs(Tabs) do
	tab.MouseButton1Click:Connect(function()
		openTab(name)
	end)
end

--========================================================
-- START
--========================================================

openTab("Control")
refreshTradeItems()

print("muna_boost_off loaded successfully")