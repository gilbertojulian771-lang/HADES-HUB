-- ==========================================
--               HADES HUB 
--         Game: Muscle Legends
-- ==========================================

-- LIBRERÍA ELERIUM INCRUSTADA (Evita el error HTTP 404)
local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function Library:CreateWindow(Config)
    local Name = Config.Name or "HADES HUB"
    
    -- Crear ScreenGui base compatible con ejecutores móviles
    local HadesGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Container = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    
    HadesGui.Name = "HadesHub_Gui"
    HadesGui.Parent = game:GetService("CoreGui")
    HadesGui.ResetOnSpawn = false
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = HadesGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.Size = UDim2.new(0, 450, 0, 320)
    MainFrame.Active = true
    MainFrame.Draggable = true -- Permite moverlo en la pantalla del celular
    
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "  " .. Name
    Title.TextColor3 = Color3.fromRGB(255, 0, 0) -- Rojo Hades
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Botón para cerrar la GUI fácilmente en móvil
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = Title
    CloseBtn.Size = UDim2.new(0, 35, 1, 0)
    CloseBtn.Position = UDim2.new(1, -35, 0, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 16
    CloseBtn.MouseButton1Click:Connect(function()
        HadesGui:Destroy()
    end)
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabContainer.Position = UDim2.new(0, 5, 0, 40)
    TabContainer.Size = UDim2.new(0, 110, 1, -45)
    
    UIListLayout.Parent = TabContainer
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 4)
    
    Container.Name = "Container"
    Container.Parent = MainFrame
    Container.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Container.Position = UDim2.new(0, 120, 0, 40)
    Container.Size = UDim2.new(1, -125, 1, -45)
    
    local Tabs = {}
    function Tabs:CreateTab(TabName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.Size = UDim2.new(1, 0, 0, 30)
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabBtn.Text = TabName
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.TextSize = 14
        
        local ContentFrame = Instance.new("ScrollingFrame")
        ContentFrame.Parent = Container
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.Visible = false
        ContentFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
        ContentFrame.ScrollBarThickness = 4
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Parent = ContentFrame
        ContentLayout.Padding = UDim.new(0, 5)
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            ContentFrame.Visible = true
        end)
        
        if #Container:GetChildren() == 1 then
            ContentFrame.Visible = true
        end
        
        local Elements = {}
        function Elements:CreateToggle(ToggleConfig)
            local TName = ToggleConfig.Name or "Toggle"
            local Callback = ToggleConfig.Callback or function() end
            local TState = false
            
            local ToggleFrame = Instance.new("Frame")
            local ToggleBtn = Instance.new("TextButton")
            local ToggleLabel = Instance.new("TextLabel")
            
            ToggleFrame.Size = UDim2.new(1, -10, 0, 35)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = ContentFrame
            
            ToggleBtn.Size = UDim2.new(0, 20, 0, 20)
            ToggleBtn.Position = UDim2.new(0, 5, 0, 7)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleBtn.Text = ""
            ToggleBtn.Parent = ToggleFrame
            
            ToggleLabel.Size = UDim2.new(1, -35, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 35, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = TName
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.Font = Enum.Font.SourceSans
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            ToggleBtn.MouseButton1Click:Connect(function()
                TState = not TState
                if TState then
                    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Rojo activo
                else
                    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                end
                Callback(TState)
            end)
        end
        return Elements
    end
    return Tabs
end

-- CONFIGURACIÓN DEL SCRIPT DE MUSCLE LEGENDS
local Window = Library:CreateWindow({
    Name = "HADES HUB | Muscle Legends"
})

local FarmTab = Window:CreateTab("Auto Farm")

getgenv().autoPunch = false
getgenv().autoLift = false

local function doPunch()
    while getgenv().autoPunch do
        local args = { [1] = "punchClick" }
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then
            p.MuscleEvent:FireServer(unpack(args))
        end
        task.wait(0.15)
    end
end

local function doLift()
    while getgenv().autoLift do
        local args = { [1] = "liftWeight" }
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then
            p.MuscleEvent:FireServer(unpack(args))
        end
        task.wait(0.15)
    end
end

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
