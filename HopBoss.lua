local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
api.script_id = "380cc68ed2994b631a11e758ea96bc36"

local KEY_FILE = "baconhub_key.txt"
local GETKEY_URL = "https://ads.luarmor.net/get_key?for=Bacon_Hub_X_Linkvertise-bmglDWXwvDJu"

if isfile(KEY_FILE) then
	local savedKey = readfile(KEY_FILE)
	local ok, status = pcall(function()
		return api.check_key(savedKey)
	end)
	if ok and status.code == "KEY_VALID" then
		getgenv().script_key = savedKey
		task.defer(function()
			api.load_script()
		end)
		return
	end
end

local gui = Instance.new("ScreenGui")
gui.Name = "LuarmorKeyGUI"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 210)
frame.Position = UDim2.new(0.5, -180, 0.5, -105)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Text = "Bacon Hub Key System"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextSize = 18
title.Position = UDim2.new(0, 0, 0, 10)
title.Size = UDim2.new(1, 0, 0, 25)

local textBox = Instance.new("TextBox", frame)
textBox.PlaceholderText = "Enter your key..."
textBox.Size = UDim2.new(0.85, 0, 0, 35)
textBox.Position = UDim2.new(0.075, 0, 0.38, 0)
textBox.Font = Enum.Font.Gotham
textBox.TextColor3 = Color3.new(1,1,1)
textBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
textBox.Text = ""
textBox.TextSize = 14
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0,6)

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0.78, 0)
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.TextColor3 = Color3.fromRGB(200,200,200)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""

local verifyBtn = Instance.new("TextButton", frame)
verifyBtn.Text = "Verify"
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextColor3 = Color3.new(1,1,1)
verifyBtn.BackgroundColor3 = Color3.fromRGB(60,120,255)
verifyBtn.Size = UDim2.new(0.4, 0, 0, 35)
verifyBtn.Position = UDim2.new(0.075, 0, 0.58, 0)
verifyBtn.TextSize = 15
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0,6)

local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Text = "Get Key"
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextColor3 = Color3.new(1,1,1)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
getKeyBtn.Size = UDim2.new(0.4, 0, 0, 35)
getKeyBtn.Position = UDim2.new(0.525, 0, 0.58, 0)
getKeyBtn.TextSize = 15
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0,6)

getKeyBtn.MouseButton1Click:Connect(function()
	setclipboard(GETKEY_URL)
	statusLabel.Text = "Copied"
	statusLabel.TextColor3 = Color3.fromRGB(120,200,255)
end)

verifyBtn.MouseButton1Click:Connect(function()
	local key = textBox.Text
	if key == "" then
		statusLabel.Text = "Enter key"
		statusLabel.TextColor3 = Color3.fromRGB(255,150,0)
		return
	end

	statusLabel.Text = "Verifying..."
	statusLabel.TextColor3 = Color3.fromRGB(150,150,255)

	task.spawn(function()
		local ok, status = pcall(function()
			return api.check_key(key)
		end)

		if not ok then
			statusLabel.Text = "API error"
			statusLabel.TextColor3 = Color3.fromRGB(255,80,80)
			return
		end

		if status.code == "KEY_VALID" then
			writefile(KEY_FILE, key)
			getgenv().script_key = key
			statusLabel.Text = "Success"
			statusLabel.TextColor3 = Color3.fromRGB(80,255,120)
			gui:Destroy()
			task.defer(function()
				api.load_script()
			end)
		else
			statusLabel.Text = status.message or "Invalid key"
			statusLabel.TextColor3 = Color3.fromRGB(255,80,80)
		end
	end)
end)
