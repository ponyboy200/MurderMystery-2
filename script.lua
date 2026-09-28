local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Створюємо головний GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FakeTradeGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Головна рамка меню
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Водяний знак
local Watermark = Instance.new("TextLabel", MainFrame)
Watermark.Text = "muna_boost_off"
Watermark.Size = UDim2.new(1, 0, 0, 30)
Watermark.Position = UDim2.new(0, 0, 0, 0)
Watermark.TextColor3 = Color3.fromRGB(200, 200, 200)
Watermark.BackgroundTransparency = 1

-- Вкладка Control
local ControlTab = Instance.new("Frame", MainFrame)