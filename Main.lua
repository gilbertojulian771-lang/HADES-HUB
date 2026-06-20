-- ==========================================
--               HADES HUB 
--         Game: Muscle Legends
-- ==========================================

-- Cargar la librería Elerium GUI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenon-Design/Elerium-Lib/main/Source.lua"))()

-- Crear la ventana principal
local Window = Library:CreateWindow({
    Name = "HADES HUB | Muscle Legends",
    Size = Vector2.new(500, 400),
    Theme = "Dark"
})

-- Crear pestañas principales
local FarmTab = Window:CreateTab("Auto Farm")

-- Variables de control globales
getgenv().autoPunch = false
getgenv().autoLift = false

-- Funciones de automatización
local function doPunch()
    while getgenv().autoPunch do
        local args = { [1] = "punchClick" }
        game:GetService("Players").LocalPlayer.MuscleEvent:FireServer(unpack(args))
        task.wait(0.1)
    end
end

local function doLift()
    while getgenv().autoLift do
        local args = { [1] = "liftWeight" }
        game:GetService("Players").LocalPlayer.MuscleEvent:FireServer(unpack(args))
        task.wait(0.1)
    end
end

-- [Pestaña: Auto Farm]
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
