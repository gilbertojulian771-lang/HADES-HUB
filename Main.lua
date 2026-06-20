-- ==========================================
--               HADES HUB 
--         Estilo Imgui Nativo Fiel
-- ==========================================

local Imgui = {}
local LocalPlayer = game:GetService("Players").LocalPlayer

function Imgui:CreateWindow(Config)
    local Name = Config.Name or "HADES HUB"
    local SizeX = Config.Size and Config.Size.X or 450
    local SizeY = Config.Size and Config.Size.Y or 400

    -- Eliminar interfaz vieja si existe
    local oldGui = game:GetService("CoreGui"):FindFirstChild("imgui_hades")
    if oldGui then oldGui:Destroy() end

    -- Base ScreenGui
    local b = Instance.new("ScreenGui")
    b.Name = "imgui_hades"
    b.Parent = game:GetService("CoreGui")
    b.ResetOnSpawn = false

    -- Ventana Principal (Estilo Imgui 4px roundify nativo)
    local e = Instance.new("ImageLabel")
    e.Name = "Window"
    e.Parent = b
    e.Active = true
    e.BackgroundColor3 = Color3.new(1,1,1)
    e.BackgroundTransparency = 1
    e.ClipsDescendants = true
    e.Position = UDim2.new(0.2, 0, 0.15, 0)
    e.Selectable = true
    e.Size = UDim2.new(0, SizeX, 0, SizeY)
    e.Image = "rbxassetid://2851926732"
    e.ImageColor3 = Color3.fromRGB(21, 22, 23) -- Gris oscuro Imgui
    e.ScaleType = Enum.ScaleType.Slice
    e.SliceCenter = Rect.new(12,12,12,12)
    e.Draggable = true

    -- Barra superior (main_color)
    local g = Instance.new("Frame")
    g.Name = "Bar"
    g.Parent = e
    g.BackgroundColor3 = Color3.fromRGB(41, 74, 122) -- Color Azul Imgui solicitado
    g.BorderSizePixel = 0
    g.Position = UDim2.new(0,0,0,0)
    g.Size = UDim2.new(1,0,0,25)

    -- Título
    local l = Instance.new("TextLabel")
    l.Name = "Title"
    l.Parent = e
    l.BackgroundColor3 = Color3.new(1,1,1)
    l.BackgroundTransparency = 1
    l.Position = UDim2.new(0, 12, 0, 2)
    l.Size = UDim2.new(1, -50, 0, 20)
    l.Font = Enum.Font.FredokaOne
    l.Text = Name
    l.TextColor3 = Color3.new(1,1,1)
    l.TextSize = 14
    l.TextXAlignment = Enum.TextXAlignment.Left

    -- Botón Cerrar
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = g
    closeBtn.Size = UDim2.new(0, 25, 1, 0)
    closeBtn.Position = UDim2.new(1, -25, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.Font = Enum.Font.FredokaOne
    closeBtn.TextSize = 14
    closeBtn.MouseButton1Click:Connect(function() b:Destroy() end)

    -- Contenedor de Pestañas Horizontales
    local tabContainer = Instance.new("Frame")
    tabContainer.Parent = e
    tabContainer.BackgroundTransparency = 1
    tabContainer.Position = UDim2.new(0, 10, 0, 32)
    tabContainer.Size = UDim2.new(1, -20, 0, 25)

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabContainer
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 4)

    -- Contenedor de Páginas
    local pagesContainer = Instance.new("Frame")
    pagesContainer.Parent = e
    pagesContainer.BackgroundTransparency = 1
    pagesContainer.Position = UDim2.new(0, 10, 0, 65)
    pagesContainer.Size = UDim2.new(1, -20, 1, -75)

    local Tabs = {}
    local firstTab = true

    function Tabs:CreateTab(TabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Parent = tabContainer
        tabButton.Size = UDim2.new(0, 85, 1, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        tabButton.Font = Enum.Font.FredokaOne
        tabButton.Text = TabName
        tabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
        tabButton.TextSize = 12

        local roundify = Instance.new("ImageLabel")
        roundify.Parent = tabButton
        roundify.Size = UDim2.new(1,0,1,0)
        roundify.BackgroundTransparency = 1
        roundify.Image = "rbxassetid://2851929490"
        roundify.ImageColor3 = Color3.fromRGB(41, 74, 122)
        roundify.ScaleType = Enum.ScaleType.Slice
        roundify.SliceCenter = Rect.new(4,4,4,4)
        roundify.ImageTransparency = 1

        local page = Instance.new("ScrollingFrame")
        page.Parent = pagesContainer
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.ScrollBarThickness = 3

        local pageLayout = Instance.new("UIListLayout")
        pageLayout.Parent = page
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding = UDim.new(0, 6)

        pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 10)
        end)

        tabButton.MouseButton1Click:Connect(function()
            for _, p in pairs(pagesContainer:GetChildren()) do p.Visible = false end
            for _, btn in pairs(tabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
                    btn.TextButton_Roundify_4px.ImageTransparency = 1
                end
            end
            page.Visible = true
            tabButton.TextColor3 = Color3.new(1,1,1)
            roundify.ImageTransparency = 0
        end)

        if firstTab then
            page.Visible = true
            tabButton.TextColor3 = Color3.new(1,1,1)
            roundify.ImageTransparency = 0
            firstTab = false
        end

        local Elements = {}

        function Elements:CreateLabel(Text)
            local label = Instance.new("TextLabel")
            label.Parent = page
            label.Size = UDim2.new(1, 0, 0, 20)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.FredokaOne
            label.Text = Text
            label.TextColor3 = Color3.new(1,1,1)
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
        end

        function Elements:CreateToggle(TName, Callback)
            local state = false
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Parent = page
            toggleFrame.Size = UDim2.new(1, 0, 0, 24)
            toggleFrame.BackgroundTransparency = 1

            local box = Instance.new("TextButton")
            box.Parent = toggleFrame
            box.Size = UDim2.new(0, 16, 0, 16)
            box.Position = UDim2.new(0, 2, 0, 4)
            box.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            box.Text = ""

            local boxRound = Instance.new("ImageLabel")
            boxRound.Parent = box
            boxRound.Size = UDim2.new(1,0,1,0)
            boxRound.BackgroundTransparency = 1
            boxRound.Image = "rbxassetid://2851929490"
            boxRound.ImageColor3 = Color3.fromRGB(41, 74, 122)
            boxRound.ScaleType = Enum.ScaleType.Slice
            boxRound.SliceCenter = Rect.new(4,4,4,4)
            boxRound.ImageTransparency = 1

            local label = Instance.new("TextLabel")
            label.Parent = toggleFrame
            label.Position = UDim2.new(0, 26, 0, 0)
            label.Size = UDim2.new(1, -30, 1, 0)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.FredokaOne
            label.Text = TName
            label.TextColor3 = Color3.fromRGB(180, 180, 180)
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left

            box.MouseButton1Click:Connect(function()
                state = not state
                if state then
                    boxRound.ImageTransparency = 0
                    label.TextColor3 = Color3.new(1,1,1)
                else
                    boxRound.ImageTransparency = 1
                    label.TextColor3 = Color3.fromRGB(180, 180, 180)
                end
                Callback(state)
            end)
        end

        return Elements
    end

    return Tabs
end

-- ==========================================
--        CONSTRUCCIÓN DEL MENÚ (MAIN)
-- ==========================================

local Win = Imgui:CreateWindow({
    Name = "HADES HUB | Imgui Premium",
    Size = Vector2.new(450, 400)
})

local FarmTab = Win:CreateTab("Auto Farm")
local MiscTab = Win:CreateTab("Misc")

getgenv().autoPunch = false
getgenv().autoLift = false

local function doPunch()
    while getgenv().autoPunch do
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then 
            p.MuscleEvent:FireServer("punchClick") 
        end
        task.wait(0.14)
    end
end

local function doLift()
    while getgenv().autoLift do
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then 
            p.MuscleEvent:FireServer("liftWeight") 
        end
        task.wait(0.14)
    end
end

FarmTab:CreateLabel("=== Sistema de Entrenamiento ===")
FarmTab:CreateToggle("Auto Golpe (Punch)", function(v)
    getgenv().autoPunch = v
    if v then task.spawn(doPunch) end
end)

FarmTab:CreateToggle("Auto Pesas (Lift)", function(v)
    getgenv().autoLift = v
    if v then task.spawn(doLift) end
end)

MiscTab:CreateLabel("=== Créditos ===")
MiscTab:CreateLabel("Hades Hub - Estilo Imgui Rehecho")
