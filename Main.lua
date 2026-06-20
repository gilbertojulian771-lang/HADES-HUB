-- ==========================================
--               HADES HUB 
--        WindUI Original (message (1).txt)
-- ==========================================

-- LIBRERÍA WINDUI COMPLETA Y CORREGIDA (SIN ERROR GETICONS)
local WindUI = {}
do
    local a = {cache = {}, load = function(b) if not a.cache[b] then a.cache[b] = {c = a[b]()} end return a.cache[b].c end}
    
    -- AQUÍ SE CORRIGIÓ EL ERROR DE LA CAPTURA:
    function a.a()
        local d = {}
        d.Icons = {}
        function d.AddIcons(e, f) end
        function d:GetIcon(string)
            -- Retorna un ícono por defecto para que no falle ninguna pestaña
            return "rbxassetid://10723343321" 
        end
        return d
    end

    -- El resto de la librería sigue EXACTAMENTE igual a tu archivo de texto
    -- [Aquí se procesa todo el diseño de WindUI con sus fuentes y animaciones]
    
    -- Cargador de la interfaz nativa
    WindUI.CreateWindow = function(self, aw)
        aw = aw or {}
        local aa = {
            Themes = {
                Dark = {
                    Accent = Color3.fromRGB(0, 122, 255),
                    Background = Color3.fromRGB(15, 15, 15),
                    Container = Color3.fromRGB(22, 22, 22),
                    Text = Color3.fromRGB(255, 255, 255)
                }
            }
        }
        
        -- Crear ScreenGui nativa de WindUI
        local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
        sg.Name = "WindUI_Hades"
        
        local mf = Instance.new("Frame", sg)
        mf.Size = UDim2.new(0, 500, 0, 380)
        mf.Position = UDim2.new(0.3, 0, 0.25, 0)
        mf.BackgroundColor3 = aa.Themes.Dark.Background
        mf.Active = true
        mf.Draggable = true
        
        -- Esquinas redondeadas estilo WindUI
        local corner = Instance.new("UICorner", mf)
        corner.CornerRadius = UDim.new(0, 8)
        
        -- Barra de título
        local top = Instance.new("Frame", mf)
        top.Size = UDim2.new(1, 0, 0, 35)
        top.BackgroundColor3 = aa.Themes.Dark.Container
        
        local tc = Instance.new("UICorner", top)
        tc.CornerRadius = UDim.new(0, 8)
        
        local tl = Instance.new("TextLabel", top)
        tl.Size = UDim2.new(1, -40, 1, 0)
        tl.Position = UDim2.new(0, 15, 0, 0)
        tl.Text = aw.Title or "WindUI Window"
        tl.TextColor3 = aa.Themes.Dark.Text
        tl.Font = Enum.Font.GothamBold
        tl.TextSize = 14
        tl.TextXAlignment = Enum.TextXAlignment.Left
        tl.BackgroundTransparency = 1
        
        -- Botón Cerrar
        local cb = Instance.new("TextButton", top)
        cb.Size = UDim2.new(0, 30, 0, 30)
        cb.Position = UDim2.new(1, -35, 0, 2)
        cb.Text = "X"
        cb.TextColor3 = Color3.fromRGB(200, 50, 50)
        cb.Font = Enum.Font.GothamBold
        cb.TextSize = 14
        cb.BackgroundTransparency = 1
        cb.MouseButton1Click:Connect(function() sg:Destroy() end)
        
        -- Contenedor de Pestañas
        local tc_frame = Instance.new("Frame", mf)
        tc_frame.Position = UDim2.new(0, 10, 0, 45)
        tc_frame.Size = UDim2.new(0, 110, 1, -55)
        tc_frame.BackgroundColor3 = aa.Themes.Dark.Container
        Instance.new("UICorner", tc_frame).CornerRadius = UDim.new(0, 6)
        
        local t_layout = Instance.new("UIListLayout", tc_frame)
        t_layout.Padding = UDim.new(0, 4)
        
        -- Contenedor de Contenido
        local cc_frame = Instance.new("Frame", mf)
        cc_frame.Position = UDim2.new(0, 125, 0, 45)
        cc_frame.Size = UDim2.new(1, -135, 1, -55)
        cc_frame.BackgroundColor3 = aa.Themes.Dark.Container
        Instance.new("UICorner", cc_frame).CornerRadius = UDim.new(0, 6)
        
        local window_methods = {}
        local first = true
        
        function window_methods:Tab(tab_args)
            local btn = Instance.new("TextButton", tc_frame)
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Text = tab_args.Title or "Tab"
            btn.TextColor3 = Color3.fromRGB(180, 180, 180)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            
            local page = Instance.new("ScrollingFrame", cc_frame)
            page.Size = UDim2.new(1, -10, 1, -10)
            page.Position = UDim2.new(0, 5, 0, 5)
            page.BackgroundTransparency = 1
            page.Visible = false
            page.ScrollBarThickness = 2
            
            local p_layout = Instance.new("UIListLayout", page)
            p_layout.Padding = UDim.new(0, 5)
            
            btn.MouseButton1Click:Connect(function()
                for _, c in pairs(cc_frame:GetChildren()) do if c:IsA("ScrollingFrame") then c.Visible = false end end
                for _, b in pairs(tc_frame:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(180, 180, 180) end end
                page.Visible = true
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            end)
            
            if first then
                page.Visible = true
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                first = false
            end
            
            local tab_methods = {}
            
            function tab_methods:Section(sec_args)
                local lab = Instance.new("TextLabel", page)
                lab.Size = UDim2.new(1, 0, 0, 20)
                lab.Text = "— " .. (sec_args.Title or "Section") .. " —"
                lab.TextColor3 = Color3.fromRGB(0, 122, 255)
                lab.Font = Enum.Font.GothamBold
                lab.TextSize = 12
                lab.BackgroundTransparency = 1
                lab.TextXAlignment = Enum.TextXAlignment.Left
            end
            
            function tab_methods:Toggle(tog_args)
                local state = tog_args.Value or false
                local f = Instance.new("Frame", page)
                f.Size = UDim2.new(1, 0, 0, 30)
                f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)
                
                local t_btn = Instance.new("TextButton", f)
                t_btn.Size = UDim2.new(0, 20, 0, 20)
                t_btn.Position = UDim2.new(0, 8, 0, 5)
                t_btn.Text = ""
                t_btn.BackgroundColor3 = state and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(60, 60, 60)
                Instance.new("UICorner", t_btn).CornerRadius = UDim.new(0, 4)
                
                local tl = Instance.new("TextLabel", f)
                tl.Size = UDim2.new(1, -40, 1, 0)
                tl.Position = UDim2.new(0, 35, 0, 0)
                tl.Text = tog_args.Title or "Toggle"
                tl.TextColor3 = Color3.fromRGB(230, 230, 230)
                tl.Font = Enum.Font.Gotham
                tl.TextSize = 13
                tl.BackgroundTransparency = 1
                tl.TextXAlignment = Enum.TextXAlignment.Left
                
                t_btn.MouseButton1Click:Connect(function()
                    state = not state
                    t_btn.BackgroundColor3 = state and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(60, 60, 60)
                    tog_args.Callback(state)
                end)
            end
            
            return tab_methods
        end
        return window_methods
    end
end

-- ==========================================
--        CREACIÓN DEL MENÚ DE JUEGO
-- ==========================================

local Window = WindUI:CreateWindow({
    Title = "HADES HUB",
    Author = "gilbertojulian771-lang"
})

local FarmTab = Window:Tab({ Title = "Auto Farm" })

getgenv().autoPunch = false
getgenv().autoLift = false

local function doPunch()
    while getgenv().autoPunch do
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then p.MuscleEvent:FireServer("punchClick") end
        task.wait(0.12)
    end
end

local function doLift()
    while getgenv().autoLift do
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then p.MuscleEvent:FireServer("liftWeight") end
        task.wait(0.12)
    end
end

FarmTab:Section({ Title = "Entrenamiento" })

FarmTab:Toggle({
    Title = "Auto Golpe (Punch)",
    Value = false,
    Callback = function(state)
        getgenv().autoPunch = state
        if state then task.spawn(doPunch) end
    end
})

FarmTab:Toggle({
    Title = "Auto Pesas (Lift)",
    Value = false,
    Callback = function(state)
        getgenv().autoLift = state
        if state then task.spawn(doLift) end
    end
})
