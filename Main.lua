-- ==========================================
--               HADES HUB 
--         Game: Muscle Legends (Delta Mobile)
-- ==========================================

-- Intentar cargar Elerium usando un enlace altamente compatible con Delta
local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/Elerium", true))()
end)

-- Si por alguna razón Delta bloquea el primer enlace, usamos este método alternativo
if not success or not Library then
    Library = loadstring(game:HttpGet("https://pastebin.com/raw/AHe4gP6G"))()
end

-- Crear la ventana principal de HADES HUB
local Window = Library:CreateWindow({
    Name = "HADES HUB | Muscle Legends",
    Size = Vector2.new(480, 360), -- Tamaño ligeramente optimizado para pantallas de celular
    Theme = "Dark"
})

-- Crear pestañas principales
local FarmTab = Window:CreateTab("Auto Farm")

-- Variables de control globales
getgenv().autoPunch = false
getgenv().autoLift = false

-- Funciones de automatización con task.wait optimizado para móviles
local function doPunch()
    while getgenv().autoPunch do
        local args = { [1] = "punchClick" }
        local localPlayer = game:GetService("Players").LocalPlayer
        if localPlayer and localPlayer:FindFirstChild("MuscleEvent") then
            localPlayer.MuscleEvent:FireServer(unpack(args))
        end
        task.wait(0.15) -- Un delay ligeramente mayor para evitar lag en Delta
    end
end

local function doLift()
    while getgenv().autoLift do
        local args = { [1] = "liftWeight" }
        local localPlayer = game:GetService("Players").LocalPlayer
        if localPlayer and localPlayer:FindFirstChild("MuscleEvent") then
            localPlayer.MuscleEvent:FireServer(unpack(args))
        end
        task.wait(0.15)
    end
end

-- [Pestaña: Auto Farm] - Toggles compatibles con Elerium
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
