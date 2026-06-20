return loadstring(game:HttpGet("https://raw.githubusercontent.com/AnsuzHub/WindUI/main/Source.lua"))()(function() local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/AnsuzHub/WindUI/main/Source.lua"))() local Window = WindUI:CreateWindow({Title = "HADES HUB", Author = "gilbertojulian771-lang"}) local FarmTab = Window:Tab({ Title = "Auto Farm", Icon = "dumbbell" }) getgenv().autoPunch = false; getgenv().autoLift = false; local function doPunch() while getgenv().autoPunch do local p = game:GetService("Players").LocalPlayer; if p and p:FindFirstChild("MuscleEvent") then p.MuscleEvent:FireServer("punchClick") end task.wait(0.12) end end; local function doLift() while getgenv().autoLift do local p = game:GetService("Players").LocalPlayer; if p and p:FindFirstChild("MuscleEvent") then p.MuscleEvent:FireServer("liftWeight") end task.wait(0.12) end end; FarmTab:Section({ Title = "Entrenamiento Automático" }); FarmTab:Toggle({Title = "Auto Golpe (Punch)", Value = false, Callback = function(state) getgenv().autoPunch = state; if state then task.spawn(doPunch) end end}); FarmTab:Toggle({Title = "Auto Pesas (Lift)", Value = false, Callback = function(state) getgenv().autoLift = state; if state then task.spawn(doLift) end end}) end)()
-- ==========================================
--               HADES HUB 
--        WindUI Original Premium
-- ==========================================

-- PARCHE: Creamos el entorno falso para que la librería no falle en Muscle Legends
local ReplicatedStorage = game:GetService("ReplicatedStorage")
if not ReplicatedStorage:FindFirstChild("GetIcons") then
    local fakeFolder = Instance.new("Folder")
    fakeFolder.Name = "GetIcons"
    
    local fakeRemote = Instance.new("RemoteFunction")
    fakeRemote.Name = "GetIcons"
    fakeRemote.Parent = fakeFolder
    
    -- Evitamos que InvokeServer() rompa el script
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if self == fakeRemote and method == "InvokeServer" then
            return {} -- Devuelve una tabla vacía para los íconos
        end
        return oldNamecall(self, ...)
    end)
    
    setreadonly(mt, true)
    fakeFolder.Parent = ReplicatedStorage
end

-- =======================================================
-- local a a={cache={}, load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()local b=(cloneref or clonereference or function(b)return b end)

local d=b(game:GetService"ReplicatedStorage":WaitForChild("GetIcons",99999):InvokeServer())

local function parseIconString(e)
if type(e)=="string"then
local f=e:find":"
if f then
local g=e:sub(1,f-1)
local h=e:sub(f+1)
return g,h
end
end
return nil,e
end

function d.AddIcons(e,f)
if type(e)~="string"or type(f)~="table"then
error"AddIcons: packName must be string, iconsData must be table"
return
end

if not d.Icons[e]then
d.Icons[e]={
Icons={},
Spritesheets={}
}
end

for g,h in pairs(f)do
if type(h)=="number"or(type(h)=="string"and h:match"^rbxassetid://")then
local i=h
if type(h)=="number"then
i="rbxassetid://"..tostring(h)
end

d.Icons[e].Icons[g]={
Image=i,
ImageRectSize=Vector2.new(0,0),
ImageRectPosition=Vector2.new(0,0),
Parts=nil
}
d.Icons[e].Spritesheets[i]=i

elseif type(h)=="table"then
if h.Image and h.ImageRectSize and h.ImageRectPosition then
local i=h.Image
if type(i)=="number"then
i="rbxassetid://"..tostring(i)
end

d.Icons[e].Icons[g]={
Image=i,
ImageRectSize=h.ImageRectSize,
ImageRectPosition=h.ImageRectPosition,
Parts=h.Parts
}

if not d.Icons[e].Spritesheets[i]then
d.Icons[e].Spritesheets[i]=i
end
else
warn("AddIcons: Invalid spritesheet data format for icon '"..g.."'")
end
else
warn("AddIcons: Unsupported data type for icon '"..g.."': "..type(h))
end
end
end

function d.SetIconsType(e)
d.IconsType=e
end

local e
function d.Init(f,g)
d.New=f
d.IconThemeTag=g

e=f
return d
end

function d.Icon(f,g,h)
h=h~=false
local i,j=parseIconString(f)

local l=i or g or d.IconsType
local m=j

local p=d.Icons[l]

if p and p.Icons and p.Icons[m]then
return{
p.Spritesheets[tostring(p.Icons[m].Image)],
p.Icons[m],
}
elseif p and p[m]and string.find(p[m],"rbxassetid://")then
return h and{
p[m],
{ImageRectSize=Vector2.new(0,0),ImageRectPosition=Vector2.new(0,0)}
}or p[m]
end
return 
nil
end

function d.GetIcon(f,g)
return d.Icon(f,g,false)
end


function d.Icon2(f,g,h)
return d.Icon(f,g,true)
end

function d.Image(f)
local g={
Icon=f.Icon or nil,
Type=f.Type,
Colors=f.Colors or{(d.IconThemeTag or Color3.new(1,1,1)),Color3.new(1,1,1)},
Transparency=f.Transparency or{0,0},
Size=f.Size or UDim2.new(0,24,0,24),

IconFrame=nil,
}

local h={}
local i={}

for j,l in next,g.Colors do
h[j]={
ThemeTag=typeof(l)=="string"and l,
Color=typeof(l)=="Color3"and l,
}
end

for j,l in next,g.Transparency do
i[j]={
ThemeTag=typeof(l)=="string"and l,
Value=typeof(l)=="number"and l,
}
end


local j=d.Icon2(g.Icon,g.Type)
local l=typeof(j)=="string"and string.find(j,'rbxassetid://')

if d.New then
local m=e or d.New



local p=m("ImageLabel",{
Size=g.Size,
BackgroundTransparency=1,
ImageColor3=h[1].Color or nil,
ImageTransparency=i[1].Value or nil,
ThemeTag=h[1].ThemeTag and{
ImageColor3=h[1].ThemeTag,
ImageTransparency=i[1].ThemeTag,
},
Image=l and j or j[1],
ImageRectSize=l and nil or j[2].ImageRectSize,
ImageRectOffset=l and nil or j[2].ImageRectPosition,
})


if not l and j[2].Parts then
for r,u in next,j[2].Parts do
local v=d.Icon(u,g.Type)

m("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ImageColor3=h[1+r].Color or nil,
ImageTransparency=i[1+r].Value or nil,
ThemeTag=h[1+r].ThemeTag and{
ImageColor3=h[1+r].ThemeTag,
ImageTransparency=i[1+r].ThemeTag,
},
Image=v[1],
ImageRectSize=v[2].ImageRectSize,
ImageRectOffset=v[2].ImageRectPosition,
Parent=p,
})
end
end

g.IconFrame=p
else
local m=Instance.new"ImageLabel"
m.Size=g.Size
m.BackgroundTransparency=1
m.ImageColor3=h[1].Color
m.ImageTransparency=i[1].Value or nil
m.Image=l and j or j[1]
m.ImageRectSize=l and nil or j[2].ImageRectSize
m.ImageRectOffset=l and nil or j[2].ImageRectPosition


if not l and j[2].Parts then
for p,r in next,j[2].Parts do
local u=d.Icon(r,g.Type)

local v=Instance.New"ImageLabel"
v.Size=UDim2.new(1,0,1,0)
v.BackgroundTransparency=1
v.ImageColor3=h[1+p].Color
v.ImageTransparency=i[1+p].Value or nil
v.Image=u[1]
v.ImageRectSize=u[2].ImageRectSize
v.ImageRectOffset=u[2].ImageRectPosition
v.Parent=m
end
end

g.IconFrame=m
end


return g
end

return d 
end function a.b()
return function(b)
return{


Primary="Icon",

White=Color3.new(1,1,1),
Black=Color3.new(0,0,0),

Dialog="Accent",

Background="Accent",
BackgroundTransparency=0,
Hover="Text",

PanelBackground="White",
PanelBackgroundTransparency=.95,

WindowBackground="Background",

WindowShadow="Black",


WindowTopbarTitle="Text",
WindowTopbarAuthor="Text",
WindowTopbarIcon="Icon",
WindowTopbarButtonIcon="Icon",

WindowSearchBarBackground="Background",

TabBackground="Hover",
TabBackgroundHover="Hover",
TabBackgroundHoverTransparency=.97,
TabBackgroundActive="Hover",
TabBackgroundActiveTransparency=0.93,
TabText="Text",
TabTextTransparency=0.3,
TabTextTransparencyActive=0,
TabTitle="Text",
TabIcon="Icon",
TabIconTransparency=0.4,
TabIconTransparencyActive=0.1,
TabBorderTransparency=1,
TabBorderTransparencyActive=0.75,
TabBorder="White",


ElementBackground="Text",
ElementBackgroundTransparency=.93,
ElementBackgroundHover=b:AddColor("ElementBackground","#ffffff",0.1),
ElementTitle="Text",
ElementDesc="Text",
ElementIcon="Icon",

PopupBackground="Background",
PopupBackgroundTransparency="BackgroundTransparency",
PopupTitle="Text",
PopupContent="Text",
PopupIcon="Icon",

DialogBackground="Background",
DialogBackgroundTransparency="BackgroundTransparency",
DialogTitle="Text",
DialogContent="Text",
DialogIcon="Icon",

Toggle="Button",
ToggleBar="White",

Checkbox="Primary",
CheckboxIcon="White",
CheckboxBorder="White",
CheckboxBorderTransparency=.75,

SliderIcon="Icon",

Slider="Primary",
SliderThumb="White",
SliderIconFrom="SliderIcon",
SliderIconTo="SliderIcon",

Tooltip=Color3.fromHex"4C4C4C",
TooltipText="White",
TooltipSecondary="Primary",
TooltipSecondaryText="White",

TabSectionIcon="Icon",

SectionIcon="Icon",

SectionExpandIcon="White",
SectionExpandIconTransparency=.4,
SectionBox="White",
SectionBoxTransparency=.95,
SectionBoxBorder="White",
SectionBoxBorderTransparency=.75,
SectionBoxBackground="White",
SectionBoxBackgroundTransparency=.95,

SearchBarBorder="White",
SearchBarBorderTransparency=.75,

Notification="Background",
NotificationTitle="Text",
NotificationTitleTransparency=0,
NotificationContent="Text",
NotificationContentTransparency=.4,
NotificationDuration="White",
NotificationDurationTransparency=.95,
NotificationBorder="White",
NotificationBorderTransparency=.75,

DropdownTabBorder="White",

LabelBackground="White",
LabelBackgroundTransparency=.95,
}

end end function a.c()
local b=(cloneref or clonereference or function(b)
return b
end)

local d=b(game:GetService"RunService")
local e=b(game:GetService"UserInputService")
local f=b(game:GetService"TweenService")
local g=b(game:GetService"LocalizationService")
local h=b(game:GetService"HttpService")local i=

d.Heartbeat

local j="https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"

local l
if d:IsStudio()or not writefile then
l=a.load'a'
else
l=loadstring(
game.HttpGetAsync and game:HttpGetAsync(j)or h:GetAsync(j)
)()
end

l.SetIconsType"lucide"

local m

local p
p={
Font="rbxassetid://12187365364",
Localization=nil,
CanDraggable=true,
Theme=nil,
Themes=nil,
Icons=l,
Signals={},
Objects={},
LocalizationObjects={},
FontObjects={},
Language=string.match(g.SystemLocaleId,"^[a-z]+"),
Request=http_request or(syn and syn.request)or request,
DefaultProperties={
ScreenGui={
ResetOnSpawn=false,
ZIndexBehavior="Sibling",
},
CanvasGroup={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
Frame={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
TextLabel={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
RichText=true,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
AutoButtonColor=false,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextBox={
BackgroundColor3=Color3.new(1,1,1),
BorderColor3=Color3.new(0,0,0),
ClearTextOnFocus=false,
Text="",
TextColor3=Color3.new(0,0,0),
TextSize=14,
},
ImageLabel={
BackgroundTransparency=1,
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
},
ImageButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AutoButtonColor=false,
},
UIListLayout={
SortOrder="LayoutOrder",
},
ScrollingFrame={
ScrollBarImageTransparency=1,
BorderSizePixel=0,
},
VideoFrame={
BorderSizePixel=0,
},
},
Colors={
Red="#e53935",
Orange="#f57c00",
Green="#43a047",
Blue="#039be5",
White="#ffffff",
Grey="#484848",
},
ThemeFallbacks=nil,
Shapes={Square=
"rbxassetid://82909646051652",
["Square-Outline"]="rbxassetid://72946211851948",Squircle=

"rbxassetid://80999662900595",SquircleOutline=
"rbxassetid://117788349049947",
["Squircle-Outline"]="rbxassetid://117817408534198",SquircleOutline2=

"rbxassetid://117817408534198",

["Shadow-sm"]="rbxassetid://84825982946844",

["Squircle-TL-TR"]="rbxassetid://73569156276236",
["Squircle-BL-BR"]="rbxassetid://93853842912264",
["Squircle-TL-TR-Outline"]="rbxassetid://136702870075563",
["Squircle-BL-BR-Outline"]="rbxassetid://75035847706564",

["Glass-0.7"]="rbxassetid://79047752995006",
["Glass-1"]="rbxassetid://97324581055162",
["Glass-1.4"]="rbxassetid://95071123641270",
},
ThemeChangeCallbacks={},
}

function p.Init(r)
m=r

p.ThemeFallbacks=a.load'b'(p)
end

function p.AddSignal(r,u)
local v=r:Connect(u)
table.insert(p.Signals,v)
return v
end

function p.DisconnectAll()
for r,u in next,p.Signals do
local v=table.remove(p.Signals,r)
v:Disconnect()
end
end

function p.SafeCallback(r,...)
if not r then
return
end

local u,v=pcall(r,...)
if not u then
if m and m.Window and m.Window.Debug then local
x, z=v:find":%d+: "

warn("[ WindUI: DEBUG Mode ] "..v)

return m:Notify{
Title="DEBUG Mode: Error",
Content=not z and v or v:sub(z+1),
Duration=8,
}
end
end
end

function p.Gradient(r,u)
if m and m.Gradient then
return m:Gradient(r,u)
end

local v={}
local x={}

for z,A in next,r do
local B=tonumber(z)
if B then
B=math.clamp(B/100,0,1)
table.insert(v,ColorSequenceKeypoint.new(B,A.Color))
table.insert(x,NumberSequenceKeypoint.new(B,A.Transparency or 0))
end
end

table.sort(v,function(z,A)
return z.Time<A.Time
end)
table.sort(x,function(z,A)
return z.Time<A.Time
end)

if#v<2 then
error"ColorSequence requires at least 2 keypoints"
end

local z={
Color=ColorSequence.new(v),
Transparency=NumberSequence.new(x),
}

if 
u then
for A,B in pairs(u)do
z[A]=B
end
end

return z
end

function p.SetTheme(r)
local u=p.Theme
p.Theme=r
p.UpdateTheme(nil,false)

for v,x in next,p.ThemeChangeCallbacks do
p.SafeCallback(x,r,u)
end
end

function p.AddFontObject(r)
table.insert(p.FontObjects,r)
p.UpdateFont(p.Font)
end

function p.UpdateFont(r)
p.Font=r
for u,v in next,p.FontObjects do
v.FontFace=Font.new(r,v.FontFace.Weight,v.FontFace.Style)
end
end

function p.GetThemeProperty(r,u)
local function getValue(v,x)
local z=x[v]

if z==nil then
return nil
end

if typeof(z)=="string"and string.sub(z,1,1)=="#"then
return Color3.fromHex(z)
end

if typeof(z)=="Color3"then
return z
end

if typeof(z)=="number"then
return z
end

if typeof(z)=="table"and z.Color and z.Transparency then
return z
end

if typeof(z)=="function"then
return z(x)
end

return z
end

local v=getValue(r,u)
if v~=nil then
if typeof(v)=="string"and string.sub(v,1,1)~="#"then
local x=p.GetThemeProperty(v,u)
if x~=nil then
return x
end
else
return v
end
end

local x=p.ThemeFallbacks[r]
if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
return p.GetThemeProperty(x,u)
else
return getValue(r,{[r]=x})
end
end

v=getValue(r,p.Themes.Dark)
if v~=nil then
if typeof(v)=="string"and string.sub(v,1,1)~="#"then
local z=p.GetThemeProperty(v,p.Themes.Dark)
if z~=nil then
return z
end
else
return v
end
end

if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
return p.GetThemeProperty(x,p.Themes.Dark)
else
return getValue(r,{[r]=x})
end
end

return nil
end

function p.AddThemeObject(r,u,v)
if p.Objects[r]then
for x,z in pairs(u)do
p.Objects[r].Properties[x]=z
end
else
p.Objects[r]={Object=r,Properties=u}
end

if not v then
p.UpdateTheme(r,false)
end
return r
end

function p.AddLangObject(r)
local u=p.LocalizationObjects[r]
if not u then
return
end

local v=u.Object

p.SetLangForObject(r)

return v
end

function p.UpdateTheme(r,u,v,x,z,A)
local function ApplyTheme(B)
for C,F in pairs(B.Properties or{})do
local G=p.GetThemeProperty(F,p.Theme)
if G~=nil then
if 
typeof(G)=="Color3"then
local H=B.Object:FindFirstChild"LibraryGradient"
if H then
H:Destroy()
end

if v then
p.Tween(
B.Object,
x or 0.2,
{[C]=G},
z or Enum.EasingStyle.Quint,
A or Enum.EasingDirection.Out
):Play()
elseif u then
p.Tween(B.Object,0.08,{[C]=G}):Play()
else
B.Object[C]=G
end
elseif typeof(G)=="table"and G.Color and G.Transparency then
B.Object[C]=Color3.new(1,1,1)

local H=B.Object:FindFirstChild"LibraryGradient"
if not H then
H=Instance.new"UIGradient"
H.Name="LibraryGradient"
H.Parent=B.Object
end

H.Color=G.Color
H.Transparency=G.Transparency

for J,L in pairs(G)do
if J~="Color"and J~="Transparency"and H[J]~=nil then
H[J]=L
end
end
elseif typeof(G)=="number"then
if v then
p.Tween(
B.Object,
x or 0.2,
{[C]=G},
z or Enum.EasingStyle.Quint,
A or Enum.EasingDirection.Out
):Play()
elseif u then
p.Tween(B.Object,0.08,{[C]=G}):Play()
else
B.Object[C]=G
end
end
else
local H=B.Object:FindFirstChild"LibraryGradient"
if H then
H:Destroy()
end
end
end
end

if r then
local B=p.Objects[r]
if B then
ApplyTheme(B)
end
else
for B,C in pairs(p.Objects)do
ApplyTheme(C)
end
end
end

function p.SetThemeTag(r,u,v,x,z)
p.AddThemeObject(r,u)
p.UpdateTheme(r,false,true,v,x,z)
end

function p.SetLangForObject(r)
if p.Localization and p.Localization.Enabled then
local u=p.LocalizationObjects[r]
if not u then
return
end

local v=u.Object
local x=u.TranslationId

local z=p.Localization.Translations[p.Language]
if z and z[x]then
v.Text=z[x]
else
local A=p.Localization
and p.Localization.Translations
and p.Localization.Translations.en
or nil
if A and A[x]then
v.Text=A[x]
else
v.Text="["..x.."]"
end
end
end
end

function p.ChangeTranslationKey(r,u,v)
if p.Localization and p.Localization.Enabled then
local x=string.match(v,"^"..p.Localization.Prefix.."(.+)")
if x then
for z,A in ipairs(p.LocalizationObjects)do
if A.Object==u then
A.TranslationId=x
p.SetLangForObject(z)
return
end
end

table.insert(p.LocalizationObjects,{
TranslationId=x,
Object=u,
})
p.SetLangForObject(#p.LocalizationObjects)
end
end
end

function p.UpdateLang(r)
if r then
p.Language=r
end

for u=1,#p.LocalizationObjects do
local v=p.LocalizationObjects[u]
if v.Object and v.Object.Parent~=nil then
p.SetLangForObject(u)
else
p.LocalizationObjects[u]=nil
end
end
end

function p.SetLanguage(r)
p.Language=r
p.UpdateLang()
end

function p.Icon(r,u)
return 
l.Icon2(r,nil,u~=false)
end

function p.AddIcons(r,u)
return l.AddIcons(r,u)
end

function p.New(r,u,v)
local x=Instance.new(r)

for z,A in next,p.DefaultProperties[r]or{}do
x[z]=A
end

for z,A in next,u or{}do
if z~="ThemeTag"then
x[z]=A
end
if p.Localization and p.Localization.Enabled and z=="Text"then
local B=string.match(A,"^"..p.Localization.Prefix.."(.+)")
if B then
local C=#p.LocalizationObjects+1
p.LocalizationObjects[C]={TranslationId=B,Object=x}

p.SetLangForObject(C)
end
end
end

for z,A in next,v or{}do
A.Parent=x
end

if u and u.ThemeTag then
p.AddThemeObject(x,u.ThemeTag)
end
if u and u.FontFace then
p.AddFontObject(x)
end
return x
end

function p.Tween(r,u,v,...)
return f:Create(r,TweenInfo.new(u,...),v)
end

function p.NewRoundFrame(r,u,v,x,z,A)
local function getImageForType(B)
return p.Shapes[B]
end

local function getSliceCenterForType(B)
return not table.find({"Shadow-sm","Glass-0.7","Glass-1","Glass-1.4"},B)
and Rect.new(256,256,256,256)
or Rect.new(512,512,512,512)
end

local B=p.New(z and"ImageButton"or"ImageLabel",{
Image=getImageForType(u),
ScaleType="Slice",
SliceCenter=getSliceCenterForType(u),
SliceScale=1,
BackgroundTransparency=1,
ThemeTag=v.ThemeTag and v.ThemeTag,
},x)

for C,F in pairs(v or{})do
if C~="ThemeTag"then
B[C]=F
end
end

local function UpdateSliceScale(C)
local F=not table.find({"Shadow-sm","Glass-0.7","Glass-1","Glass-1.4"},u)
and(C/(256))
or(C/512)
B.SliceScale=math.max(F,0.0001)
end

local C={}

function C.SetRadius(F,G)
UpdateSliceScale(G)
end

function C.SetType(F,G)
u=G
B.Image=getImageForType(G)
B.SliceCenter=getSliceCenterForType(G)
UpdateSliceScale(r)
end

function C.UpdateShape(F,G,H)
if H then
u=H
B.Image=getImageForType(H)
B.SliceCenter=getSliceCenterForType(H)
end
if G then
r=G
end
UpdateSliceScale(r)
end

function C.GetRadius(F)
return r
end

function C.GetType(F)
return u
end

UpdateSliceScale(r)

return B,A and C or nil
end

local r=p.New local u=
p.Tween

function p.SetDraggable(v)
p.CanDraggable=v
end

function p.Drag(v,x,z)
local A
local B,C,F
local G={
CanDraggable=true,
}

if not x or typeof(x)~="table"then
x={v}
end

local function update(H)
if not B or not G.CanDraggable then
return
end

local J=H.Position-C
p.Tween(v,0.02,{
Position=UDim2.new(
F.X.Scale,
F.X.Offset+J.X,
F.Y.Scale,
F.Y.Offset+J.Y
),
}):Play()
end

for H,J in 
pairs(x)do
J.InputBegan:Connect(function(L)
if
(
L.UserInputType==Enum.UserInputType.MouseButton1
or L.UserInputType==Enum.UserInputType.Touch
)and G.CanDraggable
then
if A==nil then
A=J
B=true
C=L.Position
F=v.Position

if z and typeof(z)=="function"then
z(true,A)
end

L.Changed:Connect(function()
if L.UserInputState==Enum.UserInputState.End then
B=false
A=nil

if z and typeof(z)=="function"then
z(false,nil)
end
end
end)
end
end
end)

J.InputChanged:Connect(function(L)
if B and A==J then
if
L.UserInputType==Enum.UserInputType.MouseMovement
or L.UserInputType==Enum.UserInputType.Touch
then
update(L)
end
end
end)
end

e.InputChanged:Connect(function(H)
if B and A~=nil then
if
H.UserInputType==Enum.UserInputType.MouseMovement
or H.UserInputType==Enum.UserInputType.Touch
then
update(H)
end
end
end)

function G.Set(H,J)
G.CanDraggable=J
end

return G
end

l.Init(r,"Icon")

function p.SanitizeFilename(v)
local x=v:match"([^/]+)$"or v

x=x:gsub("%.[^%.]+$","")

x=x:gsub("[^%w%-_]","_")

if#x>50 then
x=x:sub(1,50)
end

return x
end

function p.Image(v,x,z,A,B,C,F,G)
A=A or"Temp"
x=p.SanitizeFilename(x)

local H=r("Frame",{
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
},{
r("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ScaleType="Crop",
ThemeTag=(p.Icon(v)or F)and{
ImageColor3=C and(G or"Icon")or nil,
}or nil,
},{
r("UICorner",{
CornerRadius=UDim.new(0,z),
}),
}),
})
if p.Icon(v)then
H.ImageLabel:Destroy()

local J=l.Image{
Icon=v,
Size=UDim2.new(1,0,1,0),
Colors={
(C and(G or"Icon")or false),
"Button",
},
}.IconFrame
J.Parent=H
elseif string.find(v,"http")and not string.find(v,"roblox.com")then
local J="WindUI/"..A.."/assets/."..B.."-"..x..".png"
local L,M=pcall(function()
task.spawn(function()
local L=p.Request
and p.Request{
Url=v,
Method="GET",
}.Body
or{}

if not d:IsStudio()and writefile then
writefile(J,L)
end


local M,N=pcall(getcustomasset,J)
if M then
H.ImageLabel.Image=N
else
warn(
string.format(
"[ WindUI.Creator ] Failed to load custom asset '%s': %s",
J,
tostring(N)
)
)
H:Destroy()

return
end
end)
end)
if not L then
warn(
"[ WindUI.Creator ] '"..identifyexecutor()
or"Studio".."' doesnt support the URL Images.
Error: "..M
)

H:Destroy()
end
elseif v==""then
H.Visible=false
else
H.ImageLabel.Image=v
end

return H
end

function p.Color3ToHSB(v)
local x,z,A=v.R,v.G,v.B
local B=math.max(x,z,A)
local C=math.min(x,z,A)
local F=B-C

local G=0
if F~=0 then
if B==x then
G=(z-A)/F%6
elseif B==z then
G=(A-x)/F+2
else
G=(x-z)/F+4
end
G=G*60
else
G=0
end

local H=(B==0)and 0 or(F/B)
local J=B

return{
h=math.floor(G+0.5),
s=H,
b=J,
}
end

function p.GetPerceivedBrightness(v)
local x=v.R
local z=v.G
local A=v.B
return 0.299*x+0.587*z+0.114*A
end

function p.GetTextColorForHSB(v,x)
local z=p.Color3ToHSB(v)local
A, B, C=z.h, z.s, z.b
        if p.GetPerceivedBrightness(v)>(x or 0.5)then
            return Color3.fromHSV(A/360,0,0.05)
        else
            return Color3.fromHSV(A/360,0,0.98)
        end
    end
end
-- ==========================================
--        INICIALIZACIÓN DE LA INTERFAZ
-- ==========================================
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/AnsuzHub/WindUI/main/Source.lua"))()

local Window = WindUI:CreateWindow({
    Title = "HADES HUB",
    Author = "gilbertojulian771-lang"
})

local FarmTab = Window:Tab({ Title = "Auto Farm", Icon = "dumbbell" })

-- ==========================================
--         FUNCIONES DE MUSCLE LEGENDS
-- ==========================================
getgenv().autoPunch = false
getgenv().autoLift = false

local function doPunch()
    while getgenv().autoPunch do
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then 
            p.MuscleEvent:FireServer("punchClick") 
        end
        task.wait(0.12)
    end
end

local function doLift()
    while getgenv().autoLift do
        local p = game:GetService("Players").LocalPlayer
        if p and p:FindFirstChild("MuscleEvent") then 
            p.MuscleEvent:FireServer("liftWeight") 
        end
        task.wait(0.12)
    end
end

-- ==========================================
--                 BOTONES
-- ==========================================
FarmTab:Section({ Title = "Entrenamiento Automático" })

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
