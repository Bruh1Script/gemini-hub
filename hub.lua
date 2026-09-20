local scriptCode = [[
-- Gemini Hub - Full Dashboard Layout with Tabs & Keybinds
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Clipboard = setclipboard or toclipboard or function() end

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove existing GUI if open
if playerGui:FindFirstChild("GeminiHubDashboard") then
    playerGui.GeminiHubDashboard:Destroy()
end

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GeminiHubDashboard"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame (Dark Purple/Gray Theme)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 680, 0, 500)
mainFrame.Position = UDim2.new(0.5, -340, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(24, 22, 33)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(115, 75, 200)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, -20, 0, 45)
topBar.Position = UDim2.new(0, 10, 0, 10)
topBar.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 8)
topBarCorner.Parent = topBar

-- Logo / Hub Title (Using your custom star image ID)
local logoIcon = Instance.new("ImageLabel")
logoIcon.Size = UDim2.new(0, 26, 0, 26)
logoIcon.Position = UDim2.new(0, 9, 0.5, -13)
logoIcon.BackgroundTransparency = 1
logoIcon.Image = "rbxassetid://123714556246693"
logoIcon.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 150, 1, 0)
titleLabel.Position = UDim2.new(0, 44, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Gemini Hub\nRoblox Hub | v1.0.0"
titleLabel.TextColor3 = Color3.fromRGB(225, 228, 237)
titleLabel.TextSize = 11
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- FPS Counter in Top Bar
local fpsDisplay = Instance.new("TextLabel")
fpsDisplay.Size = UDim2.new(0, 120, 1, 0)
fpsDisplay.Position = UDim2.new(0.45, 0, 0, 0)
fpsDisplay.BackgroundTransparency = 1
fpsDisplay.Text = "000 FPS   000ms"
fpsDisplay.TextColor3 = Color3.fromRGB(119, 153, 0)
fpsDisplay.TextSize = 12
fpsDisplay.Font = Enum.Font.GothamBold
fpsDisplay.Parent = topBar

-- User Info Badge (Showing player's actual username)
local userBadge = Instance.new("Frame")
userBadge.Size = UDim2.new(0, 150, 0, 32)
userBadge.Position = UDim2.new(1, -165, 0.5, -16)
userBadge.BackgroundColor3 = Color3.fromRGB(24, 22, 33)
userBadge.Parent = topBar

local userBadgeCorner = Instance.new("UICorner")
userBadgeCorner.CornerRadius = UDim.new(0, 6)
userBadgeCorner.Parent = userBadge

local userText = Instance.new("TextLabel")
userText.Size = UDim2.new(1, -10, 1, 0)
userText.Position = UDim2.new(0, 8, 0, 0)
userText.BackgroundTransparency = 1
userText.Text = player.Name
userText.TextColor3 = Color3.fromRGB(255, 255, 255)
userText.TextSize = 11
userText.Font = Enum.Font.GothamBold
userText.TextXAlignment = Enum.TextXAlignment.Left
userText.Parent = userBadge

-- Navigation Bar with Home and Builders Of Fame tabs
local navBar = Instance.new("Frame")
navBar.Size = UDim2.new(1, -20, 0, 35)
navBar.Position = UDim2.new(0, 10, 0, 62)
navBar.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
navBar.Parent = mainFrame

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 6)
navCorner.Parent = navBar

local function createTab(name, xPos, width)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, width, 1, 0)
    btn.Position = UDim2.new(0, xPos, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 190)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamMedium
    btn.Parent = navBar
    return btn
end

local homeTabBtn = createTab("Home", 10, 70)
local buildersTabBtn = createTab("Builders Of Fame", 85, 130)

-- Set Home active color initially
homeTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local keybindInfo = Instance.new("TextLabel")
keybindInfo.Size = UDim2.new(0, 200, 1, 0)
keybindInfo.Position = UDim2.new(1, -210, 0, 0)
keybindInfo.BackgroundTransparency = 1
keybindInfo.Text = "RIGHT SHIFT | SHOW/HIDE"
keybindInfo.TextColor3 = Color3.fromRGB(150, 150, 160)
keybindInfo.TextSize = 10
keybindInfo.Font = Enum.Font.GothamBold
keybindInfo.TextXAlignment = Enum.TextXAlignment.Right
keybindInfo.Parent = navBar

-- Content Container (Home Page Frame)
local homeContent = Instance.new("ScrollingFrame")
homeContent.Name = "HomeContent"
homeContent.Size = UDim2.new(1, -20, 1, -110)
homeContent.Position = UDim2.new(0, 10, 0, 102)
homeContent.BackgroundTransparency = 1
homeContent.ScrollBarThickness = 4
homeContent.CanvasSize = UDim2.new(0, 0, 0, 480)
homeContent.Visible = true
homeContent.Parent = mainFrame

-- Builders Of Fame Content Frame
local buildersContent = Instance.new("ScrollingFrame")
buildersContent.Name = "BuildersContent"
buildersContent.Size = UDim2.new(1, -20, 1, -110)
buildersContent.Position = UDim2.new(0, 10, 0, 102)
buildersContent.BackgroundTransparency = 1
buildersContent.ScrollBarThickness = 4
buildersContent.CanvasSize = UDim2.new(0, 0, 0, 250)
buildersContent.Visible = false
buildersContent.Parent = mainFrame

-- Tab switching logic
homeTabBtn.MouseButton1Click:Connect(function()
    homeContent.Visible = true
    buildersContent.Visible = false
    homeTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    buildersTabBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
end)

buildersTabBtn.MouseButton1Click:Connect(function()
    homeContent.Visible = false
    buildersContent.Visible = true
    homeTabBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
    buildersTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

-- --- HOME CONTENT POPULATION ---
local welcomeBox = Instance.new("Frame")
welcomeBox.Size = UDim2.new(1, 0, 0, 60)
welcomeBox.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
welcomeBox.Parent = homeContent

local welcomeBoxCorner = Instance.new("UICorner")
welcomeBoxCorner.CornerRadius = UDim.new(0, 6)
welcomeBoxCorner.Parent = welcomeBox

local welcomeTitle = Instance.new("TextLabel")
welcomeTitle.Size = UDim2.new(1, -20, 1, 0)
welcomeTitle.Position = UDim2.new(0, 15, 0, 0)
welcomeTitle.BackgroundTransparency = 1
welcomeTitle.Text = "WELCOME TO GEMINI HUB\n" .. string.upper(player.Name)
welcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeTitle.TextSize = 14
welcomeTitle.Font = Enum.Font.GothamBold
welcomeTitle.TextXAlignment = Enum.TextXAlignment.Left
welcomeTitle.Parent = welcomeBox

local function createInfoCard(title, value, xPos, width)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(width, -5, 0, 50)
    card.Position = UDim2.new(xPos, 0, 0, 70)
    card.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
    card.Parent = homeContent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = card
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -15, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = title .. "\n" .. value
    label.TextColor3 = Color3.fromRGB(200, 200, 210)
    label.TextSize = 11
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card
end

createInfoCard("KEY TIER", "Eevee Tier", 0, 0.49)
createInfoCard("ACCESS STATUS", "Infinite", 0.51, 0.49)

local commBox1 = Instance.new("Frame")
commBox1.Size = UDim2.new(1, 0, 0, 50)
commBox1.Position = UDim2.new(0, 0, 0, 130)
commBox1.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
commBox1.Parent = homeContent

local commBox1Corner = Instance.new("UICorner")
commBox1Corner.CornerRadius = UDim.new(0, 6)
commBox1Corner.Parent = commBox1

local commText1 = Instance.new("TextLabel")
commText1.Size = UDim2.new(1, -20, 1, 0)
commText1.Position = UDim2.new(0, 12, 0, 0)
commText1.BackgroundTransparency = 1
commText1.Text = "COMMUNITY\nhttps://discord.gg/9rWUK4P6A"
commText1.TextColor3 = Color3.fromRGB(200, 200, 210)
commText1.TextSize = 11
commText1.Font = Enum.Font.GothamBold
commText1.TextXAlignment = Enum.TextXAlignment.Left
commText1.Parent = commBox1

local supportBtn = Instance.new("TextButton")
supportBtn.Size = UDim2.new(0, 80, 0, 26)
supportBtn.Position = UDim2.new(1, -90, 0.5, -13)
supportBtn.BackgroundColor3 = Color3.fromRGB(45, 130, 75)
supportBtn.Text = "SUPPORTED"
supportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
supportBtn.TextSize = 10
supportBtn.Font = Enum.Font.GothamBold
supportBtn.Parent = commBox1

local supportCorner = Instance.new("UICorner")
supportCorner.CornerRadius = UDim.new(0, 4)
supportCorner.Parent = supportBtn

local keyBox = Instance.new("Frame")
keyBox.Size = UDim2.new(1, 0, 0, 65)
keyBox.Position = UDim2.new(0, 0, 0, 190)
keyBox.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
keyBox.Parent = homeContent

local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0, 6)
keyBoxCorner.Parent = keyBox

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, -20, 0, 20)
keyTitle.Position = UDim2.new(0, 12, 0, 6)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "YOUR ACCESS KEY"
keyTitle.TextColor3 = Color3.fromRGB(150, 150, 160)
keyTitle.TextSize = 10
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextXAlignment = Enum.TextXAlignment.Left
keyTitle.Parent = keyBox

local keyInputBox = Instance.new("TextBox")
keyInputBox.Size = UDim2.new(1, -24, 0, 28)
keyInputBox.Position = UDim2.new(0, 12, 0, 28)
keyInputBox.BackgroundColor3 = Color3.fromRGB(24, 22, 33)
keyInputBox.Text = "fjkaq-qwertya-devdc"
keyInputBox.TextColor3 = Color3.fromRGB(200, 200, 210)
keyInputBox.TextSize = 11
keyInputBox.Font = Enum.Font.GothamMedium
keyInputBox.TextXAlignment = Enum.TextXAlignment.Left
keyInputBox.ClearTextOnFocus = false
keyInputBox.Parent = keyBox

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.CornerRadius = UDim.new(0, 4)
keyInputCorner.Parent = keyInputBox

local commBox2 = Instance.new("Frame")
commBox2.Size = UDim2.new(1, 0, 0, 50)
commBox2.Position = UDim2.new(0, 0, 0, 265)
commBox2.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
commBox2.Parent = homeContent

local commBox2Corner = Instance.new("UICorner")
commBox2Corner.CornerRadius = UDim.new(0, 6)
commBox2Corner.Parent = commBox2

local commText2 = Instance.new("TextLabel")
commText2.Size = UDim2.new(1, -20, 1, 0)
commText2.Position = UDim2.new(0, 12, 0, 0)
commText2.BackgroundTransparency = 1
commText2.Text = "COMMUNITY\nhttps://discord.gg/9rWUK4P6A"
commText2.TextColor3 = Color3.fromRGB(200, 200, 210)
commText2.TextSize = 11
commText2.Font = Enum.Font.GothamBold
commText2.TextXAlignment = Enum.TextXAlignment.Left
commText2.Parent = commBox2

local controlBox = Instance.new("Frame")
controlBox.Size = UDim2.new(1, 0, 0, 130)
controlBox.Position = UDim2.new(0, 0, 0, 325)
controlBox.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
controlBox.Parent = homeContent

local controlCorner = Instance.new("UICorner")
controlCorner.CornerRadius = UDim.new(0, 6)
controlCorner.Parent = controlBox

local controlTitle = Instance.new("TextLabel")
controlTitle.Size = UDim2.new(1, -20, 0, 25)
controlTitle.Position = UDim2.new(0, 12, 0, 5)
controlTitle.BackgroundTransparency = 1
controlTitle.Text = "BIKE SPEED & ACCELERATION TUNER"
controlTitle.TextColor3 = Color3.fromRGB(225, 228, 237)
controlTitle.TextSize = 11
controlTitle.Font = Enum.Font.GothamBold
controlTitle.TextXAlignment = Enum.TextXAlignment.Left
controlTitle.Parent = controlBox

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.48, 0, 0, 35)
speedBox.Position = UDim2.new(0, 12, 0, 35)
speedBox.BackgroundColor3 = Color3.fromRGB(24, 22, 33)
speedBox.Text = "1000"
speedBox.TextColor3 = Color3.fromRGB(255, 100, 100)
speedBox.TextSize = 13
speedBox.Font = Enum.Font.GothamBold
speedBox.PlaceholderText = "Speed"
speedBox.Parent = controlBox

local sCorner = Instance.new("UICorner")
sCorner.CornerRadius = UDim.new(0, 4)
sCorner.Parent = speedBox

local accelBox = Instance.new("TextBox")
accelBox.Size = UDim2.new(0.48, 0, 0, 35)
accelBox.Position = UDim2.new(0.51, 0, 0, 35)
accelBox.BackgroundColor3 = Color3.fromRGB(24, 22, 33)
accelBox.Text = "100"
accelBox.TextColor3 = Color3.fromRGB(255, 100, 100)
accelBox.TextSize = 13
accelBox.Font = Enum.Font.GothamBold
accelBox.PlaceholderText = "Acceleration"
accelBox.Parent = controlBox

local aCorner = Instance.new("UICorner")
aCorner.CornerRadius = UDim.new(0, 4)
aCorner.Parent = accelBox

local autoApplyLabel = Instance.new("TextLabel")
autoApplyLabel.Size = UDim2.new(1, -20, 0, 20)
autoApplyLabel.Position = UDim2.new(0, 12, 0, 85)
autoApplyLabel.BackgroundTransparency = 1
autoApplyLabel.Text = "Status: Live injecting values to active vehicle..."
autoApplyLabel.TextColor3 = Color3.fromRGB(119, 153, 0)
autoApplyLabel.TextSize = 10
autoApplyLabel.Font = Enum.Font.GothamMedium
autoApplyLabel.TextXAlignment = Enum.TextXAlignment.Left
autoApplyLabel.Parent = controlBox


-- --- BUILDERS OF FAME CONTENT POPULATION ---
local buildersHeader = Instance.new("Frame")
buildersHeader.Size = UDim2.new(1, 0, 0, 50)
buildersHeader.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
buildersHeader.Parent = buildersContent

local buildersHeaderCorner = Instance.new("UICorner")
buildersHeaderCorner.CornerRadius = UDim.new(0, 6)
buildersHeaderCorner.Parent = buildersHeader

local buildersHeaderText = Instance.new("TextLabel")
buildersHeaderText.Size = UDim2.new(1, -20, 1, 0)
buildersHeaderText.Position = UDim2.new(0, 15, 0, 0)
buildersHeaderText.BackgroundTransparency = 1
buildersHeaderText.Text = "BUILDERS OF FAME\nHonoring the creators and testers"
buildersHeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
buildersHeaderText.TextSize = 13
buildersHeaderText.Font = Enum.Font.GothamBold
buildersHeaderText.TextXAlignment = Enum.TextXAlignment.Left
buildersHeaderText.Parent = buildersHeader

local function createFameCard(nameText, roleText, yPos)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 50)
    card.Position = UDim2.new(0, 0, 0, yPos)
    card.BackgroundColor3 = Color3.fromRGB(35, 31, 46)
    card.Parent = buildersContent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = card
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = nameText .. " - " .. roleText
    label.TextColor3 = Color3.fromRGB(200, 200, 210)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card
end

createFameCard("zk32er", "Owner Builder", 60)
createFameCard("Opiumware", "Tester", 120)
createFameCard("Gemini", "co owner", 180)


-- FPS & MS Loop + Vehicle Injector Loop
local lastTick = tick()
local frames = 0
RunService.RenderStepped:Connect(function()
    frames = frames + 1
    local current = tick()
    if current - lastTick >= 1 then
        local fps = math.floor(frames / (current - lastTick))
        local ms = math.floor((current - lastTick) / frames * 1000)
        fpsDisplay.Text = string.format("%03d FPS   %03dms", fps, ms)
        frames = 0
        lastTick = current
    end
    
    -- Inject bike stats
    local bikesFolder = workspace:FindFirstChild("Bikes")
    if bikesFolder then
        local playerBike = bikesFolder:FindFirstChild(player.Name)
        if playerBike then
            local customize = playerBike:FindFirstChild("Customize")
            if customize then
                local maxSpeed = customize:FindFirstChild("MaxSpeed")
                local acceleration = customize:FindFirstChild("Acceleration")
                
                local sVal = tonumber(speedBox.Text)
                local aVal = tonumber(accelBox.Text)
                
                if maxSpeed and sVal then maxSpeed.Value = sVal end
                if acceleration and aVal then acceleration.Value = aVal end
            end
        end
    end
end)

-- Keybind to toggle open/close (Right Shift)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("Gemini Hub loaded successfully with your custom star logo!")
]]

local success, err = pcall(function()
    loadstring(scriptCode)()
end)

if not success then
    warn("Failed to execute loader: " .. tostring(err))
end

