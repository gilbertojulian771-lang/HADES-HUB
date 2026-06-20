-- ==========================================
--               HADES HUB 
--      Estilo Elerium V2 Fiel (60148.jpg)
-- ==========================================

local Library = {}
local LocalPlayer = game:GetService("Players").LocalPlayer

function Library:CreateWindow(Config)
    local Name = Config.Name or "HADES HUB"
    
    -- GUI Base
    local HadesGui = Instance.new("ScreenGui")
    HadesGui.Name = "HadesHub_EleriumV2"
    HadesGui.Parent = game:GetService("CoreGui")
    HadesGui.ResetOnSpawn = false
    
    -- Marco Principal
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = HadesGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18) -- Fondo oscuro
    MainFrame.BorderSizePixel = 1
    MainFrame.BorderColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
    MainFrame.Size = UDim2.new(0, 560, 0, 350)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    -- Barra Superior Amarilla (Fiel a la imagen 60148.jpg)
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(241, 196, 15) -- Amarillo SuperNova/Elerium
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -45, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "▼ 👤 " .. Name .. " 👤 | - Bienvenido " .. LocalPlayer.Name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Botón de cerrar integrado en la barra
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TopBar
    CloseBtn.Size = UDim2.new(0, 30, 1, 0)
    CloseBtn.Position = UDim2.new(1, -30, 0, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Font = Enum.Font.SourceSansBold
    CloseBtn.TextSize = 16
    CloseBtn.MouseButton1Click:Connect(function()
        HadesGui:Destroy()
    end)
    
    -- Contenedor de Pestañas Horizontales
    local TabBar = Instance.new("Frame")
    TabBar.Name = "TabBar"
    TabBar.Parent = MainFrame
    TabBar.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    TabBar.Position = UDim2.new(0, 0, 0, 30)
    TabBar.Size = UDim2.new(1, 0, 0, 35)
    TabBar.BorderSizePixel = 1
    TabBar.BorderColor3 = Color3.fromRGB(40, 40, 40)
    
    local TabBarLayout = Instance.new("UIListLayout")
    TabBarLayout.Parent = TabBar
    TabBarLayout.FillDirection = Enum.FillDirection.Horizontal
    TabBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabBarLayout.Padding = UDim.new(0, 2)
    
    -- Contenedor de Contenido Principal
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Parent = MainFrame
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 10, 0, 75)
    Container.Size = UDim2.new(1, -20, 1, -85)
    
    local Tabs = {}
    local firstTab = true
    
    function Tabs:CreateTab(TabName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabBar
        TabBtn.Size = UDim2.new(0, 75, 1, 0) -- Botones horizontales compactos
        TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabBtn.BorderSizePixel = 1
        TabBtn.BorderColor3 = Color3.fromRGB(60, 60, 60)
        TabBtn.Text = TabName
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.TextSize = 14
        
        local ContentFrame = Instance.new("ScrollingFrame")
        ContentFrame.Parent = Container
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.Visible = false
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ContentFrame.ScrollBarThickness = 4
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Parent = ContentFrame
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 6)
        
        -- Auto-ajuste de tamaño del scroll
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
        end)
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, btn in pairs(TabBar:GetChildren()) do
                if btn:IsA("TextButton") then btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end
            end
            ContentFrame.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        end)
        
        if firstTab then
            ContentFrame.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            firstTab = false
        end
        
        local Elements = {}
        
        -- Separador de Texto (Ej: === Buy pets and auras ===)
        function Elements:CreateLabel(LabelText)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 20)
            Label.BackgroundTransparency = 1
            Label.Text = LabelText
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.Font = Enum.Font.SourceSans -- Tipo de letra fiel
            Label.TextSize = 15
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = ContentFrame
        end
        
        -- Interruptor (Toggle Amarillo Clásico)
        function Elements:CreateToggle(ToggleConfig)
            local TName = ToggleConfig.Name or "Toggle"
            local Callback = ToggleConfig.Callback or function() end
            local TState = false
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 28)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = ContentFrame
            
            local Box = Instance.new("TextButton")
            Box.Size = UDim2.new(0, 18, 0, 18)
            Box.Position = UDim2.new(0, 2, 0, 5)
            Box.BackgroundColor3 = Color3.fromRGB(50, 41, 15) -- Amarillo apagado inicial
            Box.BorderSizePixel = 1
            Box.BorderColor3 = Color3.fromRGB(120, 100, 30)
            Box.Text = ""
            Box.Parent = ToggleFrame
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -30, 1, 0)
            Label.Position = UDim2.new(0, 30, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = TName
            Label.TextColor3 = Color3.fromRGB(180, 180, 180)
            Label.Font = Enum.Font.SourceSans
            Label.TextSize = 15
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = ToggleFrame
            
            Box.MouseButton1Click:Connect(function()
                TState = not TState
                if TState then
                    Box.BackgroundColor3 = Color3.fromRGB(241, 196, 15) -- Amarillo encendido al activar
                    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                else
                    Box.BackgroundColor3 = Color3.fromRGB(50, 41, 15)
                    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
                end
                Callback(TState)
            end)
        end
        return Elements
    end
    return Tabs
end

-- ==========================================
--     CREACIÓN DE PESTAÑAS Y FUNCIONES
-- ==========================================

local Window = Library:CreateWindow({
    Name = "HADES HUB"
})

-- Pestañas distribuidas horizontalmente
local FarmTab = Window:CreateTab("Farm")
local CrystalsTab = Window:CreateTab("Crystals")
local TPAreasTab = Window:CreateTab("TP Areas")

-- Variables de control
getgenv().autoPunch = false
getgenv().autoLift = false

local function doPunch()
    while getgenv().autoPunch do
        local args = { [1] = "punchClick" }
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then p.MuscleEvent:FireServer(unpack(args)) end
        task.wait(0.15)
    end
end

local function doLift()
    while getgenv().autoLift do
        local args = { [1] = "liftWeight" }
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then p.MuscleEvent:FireServer(unpack(args)) end
        task.wait(0.15)
    end
end

-- Estructura de la pestaña Farm
FarmTab:CreateLabel("=== Entrenamiento Automático ===")
FarmTab:CreateToggle({
    Name = "Auto Golpe (Punch)",
    Callback = function(Value)
        getgenv().autoPunch = Value
        if Value then task.spawn(doPunch) end
    end
})

FarmTab:CreateToggle({
    Name = "Auto Levantar Pesas (Lift)",
    Callback = function(Value)
        getgenv().autoLift = Value
        if Value then task.spawn(doLift) end
    end
})

-- Estructura de la pestaña Crystals (Igual a la imagen 60148.jpg)
CrystalsTab:CreateLabel("=== Buy pets and auras ===")
CrystalsTab:CreateLabel("[ Próximamente: Selectores de Mascota/Aura ]")
CrystalsTab:CreateLabel("=== System to buys ===")
CrystalsTab:CreateToggle({
    Name = "Auto Buy Pet",
    Callback = function(Value) print("Auto Buy Pet:", Value) end
})
CrystalsTab:CreateToggle({
    Name = "Auto buy Aura",
    Callback = function(Value) print("Auto Buy Aura:", Value) end
})
