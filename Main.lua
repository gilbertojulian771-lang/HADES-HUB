-- ==========================================
--               HADES HUB 
--         Game: Muscle Legends (Imgui Style)
-- ==========================================

-- Cargar la librería Imgui usando el código base optimizado
local Imgui = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-compile-dp/main/imgui.lua"))()

-- Crear la ventana principal de HADES HUB
local Window = Imgui:CreateWindow({
    Name = "HADES HUB | Muscle Legends",
    Size = Vector2.new(450, 400),
    Theme = "Dark", -- El tema oscuro nativo de Imgui que pasaste
    Link = "https://github.com/gilbertojulian771-lang/HADES-HUB"
})

-- Crear las pestañas principales (Tabs)
local FarmTab = Window:CreateTab("Auto Farm")
local MiscTab = Window:CreateTab("Misceláneos")

-- Variables de control globales
getgenv().autoPunch = false
getgenv().autoLift = false

-- Funciones de automatización optimizadas para Delta
local function doPunch()
    while getgenv().autoPunch do
        local args = { [1] = "punchClick" }
        local localPlayer = game:GetService("Players").LocalPlayer
        if localPlayer and localPlayer:FindFirstChild("MuscleEvent") then
            localPlayer.MuscleEvent:FireServer(unpack(args))
        end
        task.wait(0.12)
    end
end

local function doLift()
    while getgenv().autoLift do
        local args = { [1] = "liftWeight" }
        local localPlayer = game:GetService("Players").LocalPlayer
        if localPlayer and localPlayer:FindFirstChild("MuscleEvent") then
            localPlayer.MuscleEvent:FireServer(unpack(args))
        end
        task.wait(0.12)
    end
end

-- ==========================================
--        ELEMENTOS DE LA PESTAÑA: FARM
-- ==========================================

FarmTab:CreateLabel("=== Opciones de Entrenamiento ===")

-- Toggle para Golpes
FarmTab:CreateToggle({
    Name = "Auto Golpe (Punch)",
    Default = false,
    Callback = function(Value)
        getgenv().autoPunch = Value
        if Value then
            task.spawn(doPunch)
        end
    end
})

-- Toggle para Pesas
FarmTab:CreateToggle({
    Name = "Auto Levantar Pesas (Lift)",
    Default = false,
    Callback = function(Value)
        getgenv().autoLift = Value
        if Value then
            task.spawn(doLift)
        end
    end
})

-- ==========================================
--     ELEMENTOS DE LA PESTAÑA: MISCELÁNEOS
-- ==========================================

MiscTab:CreateLabel("=== Utilidades ===")

MiscTab:CreateButton({
    Name = "Destruir Interfaz",
    Callback = function()
        local b = game:GetService("CoreGui"):FindFirstChild("imgui")
        if b then 
            b:Destroy() 
        end
    end
})
