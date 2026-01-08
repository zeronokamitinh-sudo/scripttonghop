local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- [1. CẤU HÌNH]
local CORRECT_KEY = "ADMIN-TÌNH" 
local SCRIPT_NAME = "SCRIPT TỔNG HỢP"
local ADMIN_NAME = "BY TINHDZ"

-- Clean up
if CoreGui:FindFirstChild("BananaCatHub_Ultimate") then
    CoreGui.BananaCatHub_Ultimate:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaCatHub_Ultimate"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- [HÀM HỖ TRỢ KÉO THẢ]
local function MakeDraggable(Frame, ClickObject)
    local dragging, dragStart, startPos
    ClickObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- [2. INTRO ANIMATION]
local function PlayIntro()
    local IntroFrame = Instance.new("Frame")
    IntroFrame.Size = UDim2.new(1, 0, 1, 100)
    IntroFrame.Position = UDim2.new(0, 0, 0, -50)
    IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    IntroFrame.BorderSizePixel = 0
    IntroFrame.ZIndex = 999
    IntroFrame.Parent = ScreenGui

    local IntroText = Instance.new("TextLabel")
    IntroText.Size = UDim2.new(1, 0, 0, 50)
    IntroText.Position = UDim2.new(0, 0, 0.45, 0)
    IntroText.BackgroundTransparency = 1
    IntroText.Text = SCRIPT_NAME
    IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
    IntroText.Font = Enum.Font.GothamBold
    IntroText.TextSize = 35
    IntroText.TextTransparency = 1
    IntroText.ZIndex = 1000
    IntroText.Parent = IntroFrame

    local SubText = Instance.new("TextLabel")
    SubText.Size = UDim2.new(1, 0, 0, 30)
    SubText.Position = UDim2.new(0, 0, 0.52, 0)
    SubText.BackgroundTransparency = 1
    SubText.Text = ADMIN_NAME
    SubText.TextColor3 = Color3.fromRGB(255, 230, 100)
    SubText.Font = Enum.Font.GothamSemibold
    SubText.TextSize = 20
    SubText.TextTransparency = 1
    SubText.ZIndex = 1000
    SubText.Parent = IntroFrame

    -- Hiệu ứng hiện chữ
    TweenService:Create(IntroText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    task.wait(0.5)
    TweenService:Create(SubText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    task.wait(2)

    -- Hiệu ứng ẩn chữ và mở màn hình
    TweenService:Create(IntroText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(SubText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.wait(0.5)

    -- Hiệu ứng Frame đen mở ra (Scale to 0)
    IntroFrame:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quart", 0.8, true)
    TweenService:Create(IntroFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    
    task.wait(0.8)
    IntroFrame:Destroy()
end

-- [3. FLOATING TOGGLE BUTTON]
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 55, 0, 55)
OpenBtn.Position = UDim2.new(0, 20, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
OpenBtn.Text = "🇻🇳"
OpenBtn.TextSize = 25
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
local OpenStroke = Instance.new("UIStroke", OpenBtn)
OpenStroke.Thickness = 2
MakeDraggable(OpenBtn, OpenBtn)

--- [4. KEY SYSTEM FRAME] ---
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 300, 0, 160)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyFrame.Active = true
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame)
local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(255, 230, 100)
KeyStroke.Thickness = 2

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyInput.PlaceholderText = "Nhập Key tại đây..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 14
KeyInput.Parent = KeyFrame
Instance.new("UICorner", KeyInput)

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.5, 0, 0, 30)
SubmitBtn.Position = UDim2.new(0.25, 0, 0.75, 0)
SubmitBtn.Text = "XÁC NHẬN"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 230, 100)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextColor3 = Color3.fromRGB(0,0,0)
SubmitBtn.Parent = KeyFrame
Instance.new("UICorner", SubmitBtn)

--- [5. MAIN MENU] ---
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.ClipsDescendants = true 
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2

local ResizeBtn = Instance.new("TextButton")
ResizeBtn.Size = UDim2.new(0, 20, 0, 20)
ResizeBtn.Position = UDim2.new(1, -20, 1, -20)
ResizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ResizeBtn.BackgroundTransparency = 0.8
ResizeBtn.Text = ""
ResizeBtn.Parent = MainFrame
Instance.new("UICorner", ResizeBtn).CornerRadius = UDim.new(1, 0)

local DragBar = Instance.new("Frame")
DragBar.Size = UDim2.new(1, 0, 0, 40)
DragBar.BackgroundTransparency = 1
DragBar.Parent = MainFrame
MakeDraggable(MainFrame, DragBar)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = SCRIPT_NAME .. "-" .. ADMIN_NAME
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Parent = DragBar

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(0, 100, 0, 40)
FPSLabel.Position = UDim2.new(1, -145, 0, 0)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: 0"
FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSLabel.Font = Enum.Font.GothamSemibold
FPSLabel.TextSize = 14
FPSLabel.TextXAlignment = Enum.TextXAlignment.Right
FPSLabel.Parent = DragBar

-- Rainbow & FPS
local lastUpdate = 0
local fpsCount = 0
RunService.RenderStepped:Connect(function(dt)
    local color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
    MainStroke.Color = color
    OpenStroke.Color = color
    ResizeBtn.BackgroundColor3 = color
    
    fpsCount = fpsCount + 1
    if tick() - lastUpdate >= 1 then
        FPSLabel.Text = "FPS: " .. fpsCount
        if fpsCount >= 50 then FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        elseif fpsCount >= 30 then FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        else FPSLabel.TextColor3 = Color3.fromRGB(255, 50, 50) end
        fpsCount = 0
        lastUpdate = tick()
    end
end)

-- Resize Logic
local resizing = false
ResizeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mousePos = UserInputService:GetMouseLocation()
        local framePos = MainFrame.AbsolutePosition
        local newWidth = math.max(300, mousePos.X - framePos.X)
        local newHeight = math.max(200, (mousePos.Y - 36) - framePos.Y)
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 35
CloseBtn.Parent = DragBar

local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -85)
Container.Position = UDim2.new(0, 10, 0, 70)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 0)
Container.ScrollBarThickness = 2
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = Container
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Container.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end)

--- [LOGIC KEY] ---
local function ShakeFrame(frame)
    local originalPos = frame.Position
    for i = 1, 6 do
        local offset = (i % 2 == 0 and 5 or -5)
        frame.Position = originalPos + UDim2.new(0, offset, 0, 0)
        task.wait(0.05)
    end
    frame.Position = originalPos
end

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        SubmitBtn.Text = "ĐÚNG RỒI ĐẤY!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        task.wait(0.5)
        KeyFrame:Destroy()
        MainFrame.Visible = true
        MainFrame.Position = UDim2.new(0.5, -250, 1.2, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -250, 0.5, -175)}):Play()
    else
        SubmitBtn.Text = "SAI RỒI THẰNG NGU!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        KeyStroke.Color = Color3.fromRGB(255, 50, 50)
        ShakeFrame(KeyFrame)
        task.wait(1.5)
        SubmitBtn.Text = "XÁC NHẬN"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 230, 100)
        KeyStroke.Color = Color3.fromRGB(255, 230, 100)
    end
end)

local function AddButton(Name, Callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.Text = Name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.Gotham
    Btn.Parent = Container
    Instance.new("UICorner", Btn)
    Btn.MouseButton1Click:Connect(Callback)
end

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

AddButton("Load Banana Hub", function()
    getgenv().Key = "7fa9974c2a7bc7a21f337e8d" 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"))()
end)

AddButton("Load Maru Hub", function()
    getgenv().Key = "MARU-LEBQW-MU4H-MBOCC-FP2L-HSDO2"
    getgenv().id = "1205858242077655051"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/MaruBitkub/main/Mobile.lua"))()
end)

-- Chạy hiệu ứng Intro trước khi hiện Key
task.spawn(PlayIntro)
print("Banana Cat Script Loaded with Intro!")
