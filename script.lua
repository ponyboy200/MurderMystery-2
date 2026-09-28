-- muna_boost_off
-- GUI for your own Roblox experience

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUI
local oldGui = PlayerGui:FindFirstChild("MunaBoostGUI")
if oldGui then
	oldGui:Destroy()
end

--==================================================
-- COLORS
--==================================================

local BG = Color3.fromRGB(25, 25, 45)
local SECONDARY = Color3.fromRGB(40, 40, 60)
local PURPLE = Color3.fromRGB(80, 60, 150)
local PURPLE_HOVER = Color3.fromRGB(100, 75, 180)
local INPUT = Color3.fromRGB(30, 30, 50)
local WHITE = Color3.fromRGB(255, 255, 255)
local MUTED = Color3.fromRGB(170, 170, 190)

--==================================================
-- SCREEN GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "MunaBoostGUI"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(320, 480)
Main.Position = UDim2.new(0.5, -160, 0.5, -240)
Main.BackgroundColor3 = BG
Main.BorderSizePixel = 0
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 32)
Title.Position = UDim2.fromOffset(10, 8)
Title.BackgroundTransparency = 1
Title.Text = "muna_boost_off"
Title.TextColor3 = WHITE
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

--==================================================
-- TAB BAR
--==================================================

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 36)
TabBar.Position = UDim2.fromOffset(10, 45)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabBar

local tabs = {}
local pages = {}

local function createTab(name)
	local button = Instance.new("TextButton")
	button.Name = name .. "Tab"
	button.Size = UDim2.fromOffset(56, 36)
	button.BackgroundColor3 = SECONDARY
	button.BorderSizePixel = 0
	button.Text = name
	button.TextColor3 = WHITE
	button.Font = Enum.Font.GothamSemibold
	button.TextSize = 9
	button.AutoButtonColor = false
	button.Parent = TabBar

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = button

	tabs[name] = button

	return button
end

createTab("Control")
createTab("Players")
createTab("Items")
createTab("Spawner")
createTab("Values")

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -135)
Content.Position = UDim2.fromOffset(10, 88)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function createPage(name)
	local page = Instance.new("Frame")
	page.Name = name .. "Page"
	page.Size = UDim2.fromScale(1, 1)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = Content

	pages[name] = page

	return page
end

local Control = createPage("Control")
local PlayersPage = createPage("Players")
local ItemsPage = createPage("Items")
local Spawner = createPage("Spawner")
local Values = createPage("Values")

--==================================================
-- STATUS
--==================================================

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 32)
Status.Position = UDim2.new(0, 10, 1, -40)
Status.BackgroundColor3 = SECONDARY
Status.BorderSizePixel = 0
Status.Text = "Status: Ready"
Status.TextColor3 = MUTED
Status.Font = Enum.Font.Gotham
Status.TextSize = 10
Status.Parent = Main

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 7)
StatusCorner.Parent = Status

local function setStatus(text)
	Status.Text = "Status: " .. text
end

--==================================================
-- BUTTON CREATOR
--==================================================

local function makeButton(parent, text, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 40)
	button.BackgroundColor3 = PURPLE
	button.BorderSizePixel = 0
	button.Text = text
	button.TextColor3 = WHITE
	button.Font = Enum.Font.GothamSemibold
	button.TextSize = 11
	button.AutoButtonColor = false
	button.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = button

	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = PURPLE_HOVER
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = PURPLE
	end)

	button.MouseButton1Click:Connect(callback)

	return button
end

--==================================================
-- CONTROL
--==================================================

local controlLayout = Instance.new("UIListLayout")
controlLayout.Padding = UDim.new(0, 7)
controlLayout.Parent = Control

local partnerLabel = Instance.new("TextLabel")
partnerLabel.Size = UDim2.new(1, 0, 0, 18)
partnerLabel.BackgroundTransparency = 1
partnerLabel.Text = "Partner user:"
partnerLabel.TextColor3 = WHITE
partnerLabel.Font = Enum.Font.Gotham
partnerLabel.TextSize = 11
partnerLabel.TextXAlignment = Enum.TextXAlignment.Left
partnerLabel.Parent = Control

local partnerBox = Instance.new("TextBox")
partnerBox.Size = UDim2.new(1, 0, 0, 38)
partnerBox.BackgroundColor3 = INPUT
partnerBox.BorderSizePixel = 0
partnerBox.Text = ""
partnerBox.PlaceholderText = "Select a player..."
partnerBox.PlaceholderColor3 = MUTED
partnerBox.TextColor3 = WHITE
partnerBox.Font = Enum.Font.Gotham
partnerBox.TextSize = 11
partnerBox.ClearTextOnFocus = false
partnerBox.Parent = Control

local partnerCorner = Instance.new("UICorner")
partnerCorner.CornerRadius = UDim.new(0, 7)
partnerCorner.Parent = partnerBox

makeButton(Control, "Recent trade", function()
	setStatus("Recent trade selected")
end)

makeButton(Control, "Start trade", function()
	if partnerBox.Text == "" then
		setStatus("Select a player first")
	else
		setStatus("Trade started with " .. partnerBox.Text)
	end
end)

makeButton(Control, "Accept the other", function()
	if partnerBox.Text == "" then
		setStatus("Select a player first")
	else
		setStatus("Accept action selected for " .. partnerBox.Text)
	end
end)

makeButton(Control, "Block player", function()
	if partnerBox.Text == "" then
		setStatus("Select a player first")
	else
		setStatus("Block selected for " .. partnerBox.Text)
	end
end)

--==================================================
-- PLAYERS
--==================================================

local playerScroll = Instance.new("ScrollingFrame")
playerScroll.Size = UDim2.fromScale(1, 1)
playerScroll.BackgroundTransparency = 1
playerScroll.BorderSizePixel = 0
playerScroll.ScrollBarThickness = 4
playerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
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
		if target ~= LocalPlayer then

			local button = makeButton(playerScroll, target.Name, function()

				partnerBox.Text = target.Name

				for _, page in pairs(pages) do
					page.Visible = false
				end

				Control.Visible = true

				for _, tab in pairs(tabs) do
					tab.BackgroundColor3 = SECONDARY
				end

				tabs.Control.BackgroundColor3 = PURPLE

				setStatus("Selected " .. target.Name)
			end)

			button.Size = UDim2.new(1, -5, 0, 38)
		end
	end

	task.wait()

	playerScroll.CanvasSize = UDim2.new(
		0,
		0,
		0,
		playerLayout.AbsoluteContentSize.Y + 10
	)
end

Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

refreshPlayers()

--==================================================
-- ITEMS
--==================================================

local itemLayout = Instance.new("UIListLayout")
itemLayout.Padding = UDim.new(0, 6)
itemLayout.Parent = Items

local itemNames = {
	"Shadow Knife",
	"Red Fang",
	"Blue Crystal",
	"Dark Blade",
	"Golden Knife",
	"Purple Blade",
	"Night Dagger"
}

for _, itemName in ipairs(itemNames) do

	local item = Instance.new("TextButton")
	item.Size = UDim2.new(1, 0, 0, 36)
	item.BackgroundColor3 = SECONDARY
	item.BorderSizePixel = 0
	item.Text = itemName
	item.TextColor3 = WHITE
	item.Font = Enum.Font.Gotham
	item.TextSize = 11
	item.Parent = Items

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = item

	item.MouseButton1Click:Connect(function()
		setStatus(itemName .. " selected")
	end)
end

--==================================================
-- SPAWNER
--==================================================

local spawnerLayout = Instance.new("UIListLayout")
spawnerLayout.Padding = UDim.new(0, 8)
spawnerLayout.Parent = Spawner

makeButton(Spawner, "Spawn Knife", function()
	setStatus("Visual knife spawned")
end)

makeButton(Spawner, "Spawn All Godly Tradeable", function()
	setStatus("Godly showcase objects spawned")
end)

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, 0, 0, 70)
info.BackgroundTransparency = 1
info.Text = "Spawner\nShowcase objects only"
info.TextColor3 = MUTED
info.Font = Enum.Font.Gotham
info.TextSize = 11
info.TextWrapped = true
info.Parent = Spawner

--==================================================
-- VALUES
--==================================================

local valueLayout = Instance.new("UIListLayout")
valueLayout.Padding = UDim.new(0, 6)
valueLayout.Parent = Values

local valueList = {
	"Coins: 9999",
	"Level: 100",
	"Godlys: 25",
	"Trades: 42",
	"Inventory items: 128"
}

for _, valueText in ipairs(valueList) do

	local value = Instance.new("TextLabel")
	value.Size = UDim2.new(1, 0, 0, 36)
	value.BackgroundColor3 = SECONDARY
	value.BorderSizePixel = 0
	value.Text = valueText
	value.TextColor3 = WHITE
	value.Font = Enum.Font.Gotham
	value.TextSize = 11
	value.Parent = Values

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = value
end

--==================================================
-- TAB SWITCHING
--==================================================

local function openTab(name)

	for pageName, page in pairs(pages) do
		page.Visible = pageName == name
	end

	for tabName, tab in pairs(tabs) do
		if tabName == name then
			tab.BackgroundColor3 = PURPLE
		else
			tab.BackgroundColor3 = SECONDARY
		end
	end

	setStatus(name .. " opened")
end

for name, tab in pairs(tabs) do
	tab.MouseButton1Click:Connect(function()
		openTab(name)
	end)
end

--==================================================
-- START
--==================================================

openTab("Control")

print("muna_boost_off GUI loaded")