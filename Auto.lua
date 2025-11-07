local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "DiscordInviteUI"
gui.ResetOnSpawn = false
gui.Parent = pg

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = gui

local vnLabel = Instance.new("TextLabel")
vnLabel.Text = "VN : vào discord tôi để lấy script"
vnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
vnLabel.BackgroundTransparency = 1
vnLabel.Font = Enum.Font.GothamBold
vnLabel.TextScaled = true
vnLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
vnLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
vnLabel.Parent = frame

local enLabel = Instance.new("TextLabel")
enLabel.Text = "EN : join my discord to get the script"
enLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
enLabel.BackgroundTransparency = 1
enLabel.Font = Enum.Font.Gotham
enLabel.TextScaled = true
enLabel.Size = UDim2.new(0.9, 0, 0.08, 0)
enLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
enLabel.Parent = frame

local linkBox = Instance.new("TextBox")
linkBox.Text = "https://discord.gg/YwAbjsqnR5"
linkBox.TextColor3 = Color3.fromRGB(255, 255, 255)
linkBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
linkBox.BorderColor3 = Color3.fromRGB(70, 70, 70)
linkBox.Font = Enum.Font.GothamBold
linkBox.TextScaled = true
linkBox.ClearTextOnFocus = false
linkBox.Size = UDim2.new(0.6, 0, 0.07, 0)
linkBox.Position = UDim2.new(0.2, 0, 0.58, 0)
linkBox.Parent = frame

local copyBtn = Instance.new("TextButton")
copyBtn.Text = "Sao chép"
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextScaled = true
copyBtn.Size = UDim2.new(0.25, 0, 0.07, 0)
copyBtn.Position = UDim2.new(0.375, 0, 0.68, 0)
copyBtn.Parent = frame

copyBtn.MouseButton1Click:Connect(function()
	local success = false
	if setclipboard then
		setclipboard(linkBox.Text)
		success = true
	elseif toclipboard then
		toclipboard(linkBox.Text)
		success = true
	end
	
	copyBtn.Text = success and "Đã sao chép" or "Không hỗ trợ"
	task.wait(2)
	copyBtn.Text = "Sao chép"
end)

frame.BackgroundTransparency = 1
for i = 1, 20 do
	frame.BackgroundTransparency = 1 - i * 0.05
	task.wait(0.03)
end
