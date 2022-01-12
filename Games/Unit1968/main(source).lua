local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local Main = library.new("UNIT 1968 V6.5 | H3LLLO", 5013109572)
print("Loading")
-- themes
local themes = 
{
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),  
    TextColor = Color3.fromRGB(255, 255, 255)
}
--#vars
local Character_Parts ={ "Head","LeftHand","LeftLowerArm","LeftUpperArm","RightHand","RightLowerArm","RightUpperArm","UpperTorso","LowerTorso","RightFoot","RightLowerLeg","RightUpperLeg","LeftFoot","LeftLowerLeg","LeftUpperLeg"}
--ESP
local ESP_Boxes = false
local ESP_Names = false 
local ESP_Health = false
local ESP_Enabled = false
local ESP_Chams = false
local ESP_Chams2 = false
local ESP_Chams_Outline = false
local ESP_Main_Color = Color3.new(1,0,0)
local ESP_Chams_Color = Color3.new(0,0,0)
local ESP_Chams_Color2 = Color3.new(0,0,0)
local ESP_Chams_Outline_Color = Color3.new(1,0,0)
--World
local World_Visuals_Enabled = false
local World_Ambient = Color3.new(0,0,0)
local World_OutDoorAmbient = nil
local World_Brightness = nil
local World_Time = nil
--Gun Mods
local gunmod1 = false 
local gunmod2 = false 
local gunmod3 = false 
local gunmod4 = false 
local gunmod5 = false 
local gunmod6 = false
local gunmod7 = false
local gunmod8 = false
local gunmod9 = false
local gunmod10 = false
local RGBGun = false 
local RGBGunMaterial = "Glass"
local WhizzerEnabled = false
--Player
local SpinbotEnabled = false
local SpinStrength
local MovementOveride = false
local WalkSpeed = 17
local JumPower = 50
local Nofall = false
local RenderPlayer = false
local CameraoffsetX = 0
local CameraoffsetY = 0
local CameraoffsetZ = 0
local chatSpammer = false
local chatSpammerOptions = nil
local teamEvent = "changeteam"
local teamOption = nil
local chatSpammerText = ""
local customChatSpammerText = ""
local myEmojojies = { '🤣', '😈', '😭', '🙃', '👽'}
local Health_Spam = false
local Ammo_Spam = false
--Other
local XLighting = game.GetService(game, "Lighting") 
local Players = game:GetService("Players")
local LPlayer = Players.LocalPlayer
local Mouse     = LPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local SAEnabled = false
local ShowSAFov = false
local FovAmount = 200
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
-- functions
local function whizzPlayer(Player, Size, Distance) 
    game:GetService("ReplicatedStorage").Events.Whizz:FireServer(Player, Size, Distance)
end
getfenv().lock = "Head" -- Head or Hitbox or Random
print("Loading | %20")
-- first page
local SA_Page = Main:addPage("Aimbot", 5012544693)
local SASection = SA_Page:addSection("Silent Aim")
SASection:addToggle("Silent Aim Enabled", nil, function(state)
    SAEnabled = state
end)
SASection:addDropdown("Hitbox", {"Head", "Chest", "Random", 1, 2, 3}, function(text)
    getfenv().lock = text
end)
SASection:addToggle("Show FOV", nil, function(state)
    ShowSAFov = state
end)
SASection:addSlider("Circle Fov", 0, 0, 500, function(valuex)
    FovAmount = valuex
end)

local Playerpage = Main:addPage("Player", 5012544693)
local PlayerSection = Playerpage:addSection("Player Mods")
PlayerSection:addToggle("Movement Overide", nil, function(state)
    MovementOveride = state
end)
PlayerSection:addSlider("Walk Speed", 16, 0, 200, function(valuex)
    WalkSpeed = valuex
end)
PlayerSection:addSlider("Jump Power", 50, 0, 100, function(valuex)
    JumPower = valuex
end)
PlayerSection:addToggle("No fall damage", nil, function(state)
    Nofall = state
end)
PlayerSection:addButton("No Restricted area kill", function()
    game:GetService("ReplicatedStorage").Events.KillMe:Destroy()
end)

local ESP_Page = Main:addPage("ESP", 5012544693)
local ESPSection0 = ESP_Page:addSection("ESP Enabled")
local ESPSection = ESP_Page:addSection("ESP")
local ESPSection2 = ESP_Page:addSection("Team ESP")
ESPSection0:addToggle("ESP Enabled", nil, function(state)
    ESP_Enabled = state
end)
ESPSection:addToggle("ESP Boxes", nil, function(state)
    ESP_Boxes = state
end)
ESPSection:addToggle("ESP Health", nil, function(state)
    ESP_Health = state
end)
ESPSection:addToggle("ESP Names", nil, function(state)
    ESP_Names = state
end)
ESPSection:addToggle("ESP Chams", nil, function(state)
    ESP_Chams = state
end)
ESPSection:addToggle("ESP Chams Visible outline", nil, function(state)
    ESP_Chams_Outline = state
end)
ESPSection:addColorPicker("ESP Main Color", Color3.fromRGB(200, 0, 0), function(s)
    ESP_Main_Color = s
end)
ESPSection:addColorPicker("ESP Chams Color", Color3.fromRGB(255, 255, 255), function(s)
    ESP_Chams_Color = s
end)
ESPSection:addColorPicker("ESP Chams Visible Color", Color3.fromRGB(255, 0, 0), function(s)
    ESP_Chams_Outline_Color = s
end)
--Section 2
ESPSection2:addToggle("Team Chams", nil, function(state)
    ESP_Chams2 = state
end)
ESPSection2:addColorPicker("Team Chams Color", Color3.fromRGB(255, 255, 255), function(s)
    ESP_Chams_Color2 = s
end)

local Gunpage = Main:addPage("Gun Mods", 5012544693)
local GunSection = Gunpage:addSection("Gun Mods")
GunSection:addToggle("Infinite Ammo", nil, function(b)
    gunmod1 = b
end)
GunSection:addToggle("Nospread", nil, function(b)
    gunmod2 = b
end)
GunSection:addToggle("No bullet drop", nil, function(b)
    gunmod3 = b
end)
GunSection:addToggle("No recoil", nil, function(b)
    gunmod4 = b
end)
GunSection:addToggle("Increase fire rate", nil, function(b)
    gunmod5 = b
end)
GunSection:addToggle("Infinite Grenades", nil, function(b)
    gunmod6 = b
end)
GunSection:addToggle("Inf Ammoboxes/Meds", nil, function(b)
    gunmod7 = b
end)
GunSection:addToggle("Fast Reload", nil, function(b)
    gunmod8 = b
end)
GunSection:addToggle("Fast Aim", nil, function(b)
    gunmod9 = b
end)

local AAPAge = Main:addPage("Anti-Aim", 5012544693)
local AAsec = AAPAge:addSection("Anti-Aim")
AAsec:addToggle("Spinbot", nil, function(b)
    SpinbotEnabled = b
end)
AAsec:addSlider("Spinbot strength", 0, 0, 250, function(valuex)
    SpinStrength = valuex
end)
local AAsec2 = AAPAge:addSection("Visual")
AAsec2:addToggle("Render Player", nil, function(b)
    RenderPlayer = b
end)
AAsec2:addSlider("Camera offset Z", 0, 0, 10, function(valuex)
    CameraoffsetZ = valuex
end)
AAsec2:addSlider("Camera offset Y", 0, 0, 10, function(valuex)
    CameraoffsetY = valuex
end)
AAsec2:addSlider("Camera offset X", 0, 0, 10, function(valuex)
    CameraoffsetX = valuex
end)



local MiscPage = Main:addPage("Miscellaneous", 5012544693)
local MiscSection0 = MiscPage:addSection("Discord")
local MiscSection = MiscPage:addSection("Visuals")
local MiscSection2 = MiscPage:addSection("Players")
local MiscSection3 = MiscPage:addSection("Team Changer")
MiscSection0:addButton("Copy discord link", function()
    setclipboard([[https://discord.gg/chBXmh2C4Q]])
end)
MiscSection:addToggle("Rainbow Gun", nil, function(state)
    RGBGun = state
end)
MiscSection:addDropdown("RGB Material", {"ForceField", "Glass", "Neon", "Plastic", 1, 2, 3}, function(text)
    RGBGunMaterial = text
end)
MiscSection2:addToggle("Whizz annoy all", nil, function(state)
    WhizzerEnabled = state
end)
MiscSection2:addToggle("Mass Ammo bags", nil, function(state)
    Ammo_Spam = state
end)
MiscSection2:addToggle("Mass Health bags", nil, function(state)
    Health_Spam = state
end)
MiscSection2:addToggle("Chat Spammer", nil, function(state)
    chatSpammer = state
end)
MiscSection2:addDropdown("ChatSpammer Text", {"Custom", "Emoji", "Wack", "EZ", "H3LLL0"}, function(text)
    chatSpammerOptions = text
end)
MiscSection2:addTextbox("Custom Text", "", function(value, focusLost)
    customChatSpammerText = value
end)
MiscSection3:addDropdown("Team Option", {"NV", "USA","None"}, function(teamx)
    local args = {[1] = {[1] = "changeteam",[2] = teamx}}
    game:GetService("ReplicatedStorage").Events.RemoteEvent:FireServer(unpack(args))
end)

local WorldPage = Main:addPage("Client World", 5012544693)
local WorldSection = WorldPage:addSection("World")
WorldSection:addToggle("World Enabled", nil, function(state)
    World_Visuals_Enabled = state
end)
WorldSection:addColorPicker("Ambient", Color3.fromRGB(200, 0, 0), function(s)
    World_Ambient = s
end)
WorldSection:addColorPicker("ColorCorrection", Color3.fromRGB(255, 255, 255), function(s)
    World_OutDoorAmbient = s
end)
WorldSection:addSlider("Brightness", 0, 0, 100, function(valuex)
    World_Brightness = valuex
end)
WorldSection:addSlider("Time", 0, 0, 23, function(valuex)
    World_Time = valuex
end)


print("Loading | %40")
local theme = Main:addPage("UI", 5012544693)
local Keybind = theme:addSection("Keybind")
Keybind:addKeybind("Toggle Keybind", Enum.KeyCode.P, function()    
    Main:toggle()
    end, function()
    print("Changed Keybind")
end)

local colors = theme:addSection("Colors")
for theme, color in pairs(themes) do 
colors:addColorPicker(theme, color, function(color3)
Main:setTheme(theme, color3)
end)
end

print("Loading | %50")
--Main
coroutine.wrap(function()
    while wait() do
        pcall(function()
            if Health_Spam then
                game:GetService("ReplicatedStorage").Events.ThrowHP:FireServer()
            end
            if Ammo_Spam then
                game:GetService("ReplicatedStorage").Events.ThrowAmmo:FireServer()
            end
        end)
    end
end)()
coroutine.wrap(function()
    while wait() do
        pcall(function()
            if chatSpammer then   
                local emo = myEmojojies[math.random(#myEmojojies)]
                if chatSpammerOptions == "Custom" then 
                    chatSpammerTxt = customChatSpammerText
                    else if chatSpammerOptions == "Emoji" then
                        chatSpammerTxt = "😀😄😆😂🤣😏"                        
                            else if chatSpammerOptions == "Wack" then
                                chatSpammerTxt = "WaCk wAcK wAcK WacK WaCk WaCk wAcK wAcK WacK WaCk WaCk wAcK wAcK WacK WaCk WaCk wAcK wAcK WacK WaCk WaCk wAcK wAcK WacK WaCk WaCk wAcK wAcK WacK WaCk"
                                else if chatSpammerOptions == "EZ" then
                                    chatSpammerTxt = "|           EZ          |" 
                                        else if chatSpammerOptions == "H3LLL0" then
                                            chatSpammerTxt = 
                                            [[
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                             l0l      H3LLL0 - SKripts     l0l
                                            ]]
                                        end
                                    end
                                end
                            end                            
                        end
                    local b1 = false
                local b2 = false            
                game:GetService("ReplicatedStorage").Events.Chat:FireServer(chatSpammerTxt,b1,b2)       
            end
        end)
    end
end)()
coroutine.wrap(function()
    while wait(.09)do
        pcall(function()
            if WhizzerEnabled then                
                for _,v in pairs(game.Players:GetChildren())do
                    whizzPlayer(v, "Large", -1)                    
                    whizzPlayer(v, "Medium", 9999) 
                end
            end
        end)
    end
end)()
coroutine.wrap(function()
    while wait(.1)do
        pcall(function()            
            if RenderPlayer then
                for i,q in pairs(game:GetService("Workspace").Camera:GetChildren()) do
                    if q.Name == "Arms" then
                        for i,v in pairs(q:GetDescendants()) do                            
                            if v.ClassName == 'MeshPart' or v.ClassName == "Part" then 
                                v.Transparency = 1
                            end                                   
                        end
                    end
                end 
            end            
        end)
    end
end)()
coroutine.wrap(function()
    while wait(.1)do
        pcall(function()            
            if RenderPlayer then
                for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants())do
                    if v:IsA("BasePart")or v:IsA("Decal")then
                        if v.LocalTransparencyModifier ~= 0 then
                            v.LocalTransparencyModifier = 0
                        end
                    end
                end
            end            
        end)
    end
end)()
coroutine.wrap(function()
    while wait(1)do
        pcall(function()
            if ESP_Enabled then
                if ESP_Chams then
                    for _,v in pairs(game.Players:GetPlayers()) do
                        if v.Name ~= LPlayer.Name and v.TeamColor ~= LPlayer.TeamColor then
                            for _,c in pairs(Character_Parts)do
                                if v.Character:FindFirstChild(c)then
                                    local part=v.Character[c]
                                    local a=Instance.new("BoxHandleAdornment")
                                    if c=="Head"then
                                        a.Size=Vector3.new(1.05,1.05,1.05)
                                    else
                                        a.Size=part.Size+Vector3.new(.05,.05,.05)
                                    end
                                    a.Parent=game.CoreGui
                                    a.AlwaysOnTop=true
                                    a.Adornee=part
                                    a.ZIndex=0
                                    a.Transparency = 0.5
                                    a.Color3=ESP_Chams_Color
                                    coroutine.wrap(function()
                                        wait(1)
                                        a:Destroy()
                                    end)()                               
                                    if ESP_Chams_Outline then
                                    local part=v.Character[c]
                                    local a=Instance.new("BoxHandleAdornment")
                                    local off=0.4
                                    if c=="Head"then
                                        a.Size=Vector3.new(1+off,1+off,1+off)
                                    else
                                        a.Size=part.Size+Vector3.new(off,off,off)
                                    end
                                    a.Parent=game.CoreGui
                                    a.AlwaysOnTop=false
                                    a.Adornee=part
                                    a.ZIndex=0
                                    a.Color3=ESP_Chams_Outline_Color
                                    coroutine.wrap(function()
                                        wait(1.1)
                                        a:Destroy()
                                        end)()
                                    end
                                end
                            end
                        end
                    end
                end
                if ESP_Chams2 then
                    for _,v in pairs(game.Players:GetPlayers()) do
                        if v.Name ~= LPlayer.Name and v.TeamColor == LPlayer.TeamColor then
                            for _,c in pairs(Character_Parts)do
                                if v.Character:FindFirstChild(c)then
                                    local part=v.Character[c]
                                    local a=Instance.new("BoxHandleAdornment")
                                    if c=="Head"then
                                        a.Size=Vector3.new(1.05,1.05,1.05)
                                    else
                                        a.Size=part.Size+Vector3.new(.05,.05,.05)
                                    end
                                    a.Parent=game.CoreGui
                                    a.AlwaysOnTop=true
                                    a.Adornee=part
                                    a.ZIndex=0
                                    a.Transparency = 0.5
                                    a.Color3=ESP_Chams_Color2
                                    coroutine.wrap(function()
                                        wait(1)
                                        a:Destroy()
                                    end)()                               
                                    if ESP_Chams_Outline then
                                    local part=v.Character[c]
                                    local a=Instance.new("BoxHandleAdornment")
                                    local off=0.4
                                    if c=="Head"then
                                        a.Size=Vector3.new(1+off,1+off,1+off)
                                    else
                                        a.Size=part.Size+Vector3.new(off,off,off)
                                    end
                                    a.Parent=game.CoreGui
                                    a.AlwaysOnTop=false
                                    a.Adornee=part
                                    a.ZIndex=0
                                    a.Color3=ESP_Chams_Outline_Color
                                    coroutine.wrap(function()
                                        wait(1.1)
                                        a:Destroy()
                                        end)()
                                    end
                                end
                            end
                        end
                    end 
                end
            end 
            game.Workspace.CurrentCamera.CFrame= 
            game.Workspace.CurrentCamera.CFrame* 
            CFrame.new(CameraoffsetX,CameraoffsetY,CameraoffsetZ)          
            if World_Visuals_Enabled then                
                XLighting.Ambient = World_Ambient
                XLighting.ColorCorrection.TintColor = World_OutDoorAmbient
                XLighting.Brightness = World_Brightness
                XLighting.TimeOfDay = World_Time
            end
        end)
    end
end)()

print("Loading | %70")
local c = 1
function zigzag(X)
return math.acos(math.cos(X * math.pi)) / math.pi
end

game:GetService("RunService").RenderStepped:connect(function()   
    if RenderPlayer then
        game.Workspace.CurrentCamera.CFrame=
        game.Workspace.CurrentCamera.CFrame*
        CFrame.new(CameraoffsetX,CameraoffsetY,CameraoffsetZ)
    end
    if LPlayer.Backpack.CLIENT ~= nil then    
        local env = getsenv(LPlayer.Backpack.CLIENT)
        if env then 
            if env.equipped == "melee" or env.equipped == "grenade" then
                if env.gun.FireRate ~= nil and gunmod5 then
                    env.gun.Automatic.Value = true 
                    env.gun.FireRate.Value = 0.1                    
                    env.primarymode = "automatic"
                end
            else 
                if gunmod1 then 
                    env.ammocount  = 11
                    env.ammocount2 = 11
                    env.ammocount3 = 11
                end
                if gunmod2 then 
                    env.spread = 0                    
                end
                if gunmod3 then 
                    env.gravity = 0 
                    env.bulletspeedm = 8
                end
                if env.gun and env.gun.Name ~= melee then 
                    if env.gun.Recoil ~= nil and gunmod4 then 
                        env.gun.Recoil.Value  = 0 
                        env.gun.LRecoil.Value = 0
                        env.gun.RRecoil.Value = 0 
                    end
                    if env.gun.FireRate ~= nil and gunmod5 then
                        env.gun.Automatic.Value = true 
                        env.gun.FireRate.Value = 0.001
                        env.bolted = true
                        env.primarymode = "automatic"
                    end
                    if gunmod6 then
                        env.maxgrenades = 10
                        env.grenades    = 10
                    end
                    if gunmod7 then
                        env.ammoboxes = 2
                    end
                    if gunmod8 and env.gun.ReloadTime ~= nil then
                        env.gun.ReloadTime.Value   = 0.001 
                        env.gun.EReloadTime.Value  = 0.001 
                        env.gun.PReloadTime.Value  = 0.001
                    end
                    if gunmod9 then                        
                        env.AimSpeed.Value = 10                        
                    end
                end                        
            end             
        end
    end 
    if SpinbotEnabled then
        game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SpinStrength), 0)
    else 
        game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true           
    end 
    if ESP_Enabled then
        for _,v in pairs(game.Players:GetPlayers()) do
            if v.Name ~= LPlayer.Name and v.TeamColor ~= LPlayer.TeamColor then
            local part=v.Character.HumanoidRootPart
            local _,b=game.Workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                if b then
                    if ESP_Names then
                        local a=Drawing.new("Text")
                        a.Text=v.Name
                        a.Size=math.clamp(16-(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,16,83)
                        a.Center=true
                        a.Outline=true
                        a.OutlineColor=Color3.new()
                        a.Font=Drawing.Fonts.UI
                        a.Visible=true
                        a.Transparency=1
                        a.Color=ESP_Main_Color
                        a.Position=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.UpVector*(3+(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.UpVector*(3+(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).Y)
                        coroutine.wrap(function()
                        game.RunService.RenderStepped:Wait()
                        a:Remove()
                        end)()
                    end
                    if ESP_Boxes then
                        local a=Drawing.new("Quad")
                        a.Visible=true
                        a.Color=ESP_Main_Color
                        a.Thickness=1
                        a.Transparency=1
                        a.Filled=false
                        a.PointA=Vector2.new(
                         game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*-2+part.CFrame.UpVector*2.5).X,
                        game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*-2+part.CFrame.UpVector*2.5).Y)-->^
                        a.PointB=Vector2.new(
                        game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).X,
                        game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).Y)--<^
                        a.PointC=Vector2.new(
                        game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).X,
                        game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).Y)--<V
                        a.PointD=Vector2.new(
                        game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*-2+part.CFrame.UpVector*-2.5).X,
                        game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*-2+part.CFrame.UpVector*-2.5).Y)-->V
                        coroutine.wrap(function()
                        game.RunService.RenderStepped:Wait()
                        a:Remove()
                        end)()
                    end
                    if ESP_Health then
                        local healthnum=v.Character.Humanoid.Health
                        local maxhealth=v.Character.Humanoid.MaxHealth
                        local c=Drawing.new("Quad")
                        c.Visible=true
                        c.Color=Color3.new(0,1,0)
                        c.Thickness=1
                        c.Transparency=1
                        c.Filled=false
                        c.PointA=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*2.5).Y)-->^
                        c.PointB=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).Y)--<^
                        c.PointC=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).Y)--<V
                        c.PointD=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*-2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*-2.5).Y)-->V
                        coroutine.wrap(function()
                        game.RunService.RenderStepped:Wait()
                            c:Remove()
                        end)()
                        local e=Drawing.new("Quad")
                        e.Visible=true
                        e.Color=Color3.new(1,0,0)
                        e.Thickness=1
                        e.Transparency=1
                        e.Filled=true
                        e.PointA=Vector2.new(
                        game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*2.5).Y)-->^
                        e.PointB=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).Y)--<^
                        e.PointC=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).Y)--<V
                        e.PointD=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*-2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*-2.5).Y)-->V
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            e:Remove()
                        end)()
                        local d=Drawing.new("Quad")
                        d.Visible=true
                        d.Color=Color3.new(0,1,0)
                        d.Thickness=1
                        d.Transparency=1
                        d.Filled=true
                        d.PointA=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*(-2.5+healthnum/(maxhealth/5))).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*(-2.5+healthnum/(maxhealth/5))).Y)-->^
                        d.PointB=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*(-2.5+healthnum/(maxhealth/5))).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*(-2.5+healthnum/(maxhealth/5))).Y)--<^
                        d.PointC=c.PointC--<V
                        d.PointD=c.PointD-->V
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            d:Remove()
                        end)()
                    end                                                         
                end
            end
        end
    end
    if ShowSAFov then
        local FOVx = Drawing.new("Circle")
        FOVx.Visible = true
        FOVx.Position= Vector2.new(Mouse.X,Mouse.Y)
        FOVx.Color = Color3.new(0,0,175/255)
        FOVx.Thickness = 2.5
        FOVx.Transparency = 1
        FOVx.NumSides = 100
        FOVx.Radius = FovAmount
        coroutine.wrap(function()
            game.RunService.RenderStepped:wait()
            FOVx:Remove()
        end)()
    end
    if MovementOveride then
        LPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
        LPlayer.Character.Humanoid.JumpPower = JumPower
    end
    if RGBGun then        
        for i,q in pairs(game:GetService("Workspace").Camera:GetChildren()) do
            if q.Name == "Arms" then
                for i,v in pairs(q:GetDescendants()) do
                    if v.ClassName == 'MeshPart' then 
                        v.TextureID = ""
                        v.Color = Color3.fromHSV(zigzag(c),1,1)
                        c = c + .0001
                        v.Material = RGBGunMaterial
                    end                
                end
            end
        end     
    end  
end)
print("Loading | %80")
function getnearest()
	local nearestmagnitude = math.huge
	local nearestenemy = nil
	local vector = nil	
	for i,v in next, Players:GetChildren() do
		if v.Name ~= LocalPlayer.Name then
            if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.TeamColor ~= LocalPlayer.TeamColor then
				local vector, onScreen = Camera:WorldToScreenPoint(v.Character["HumanoidRootPart"].Position)
				if onScreen then				
					local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
						if magnitude < nearestmagnitude and magnitude <= FovAmount then
							nearestenemy = v
							nearestmagnitude = magnitude
						end
					end
				end
			end
		end
	return nearestenemy
end
print("Loading | %90")
local mt = getrawmetatable(game)
setreadonly(mt, false)
local namecall = mt.__namecall

mt.__namecall = function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "Bullet" and tostring(method) == "FireServer" then
        if target and SAEnabled == true then
            args[1] = target
            return self.FireServer(self, unpack(args))
        end
    end
   return namecall(self,...)
end

print("Loading | %95")

RunService:BindToRenderStep("SilentAim",1,function()
	if UserInputService:IsMouseButtonPressed(0) and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") and Players.LocalPlayer.Character.Humanoid.Health > 0 then
		local enemy = getnearest()
		if enemy and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character.Humanoid.Health > 0 then                
			local vector, onScreen = Camera:WorldToScreenPoint(enemy.Character["Head"].Position)
			local head = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
			local vector, onScreen = Camera:WorldToScreenPoint(enemy.Character["HumanoidRootPart"].Position)
			local hitbox = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
			if head <= hitbox then
				magnitude = head
			else
				magnitude = hitbox;
			end;
			if getfenv().lock == "Head" then
				target = workspace[enemy.Name]["Head"]
			else
				if getfenv().lock == "Random" then
					if magnitude == hitbox then
						target = workspace[enemy.Name]["HumanoidRootPart"];
					else
						target = workspace[enemy.Name]["Head"]
					end;
				else
					target = workspace[enemy.Name]["HumanoidRootPart"];
				end;

			end;
		else
			target = nil
		end
	end
end)

local mt = getrawmetatable(game)
local namecall = mt.__namecall

setreadonly(mt, false)
mt.__namecall = newcclosure(function(Self,...)
	local Args = {...}
	local name = getnamecallmethod()
	if not checkcaller() and Self == game.ReplicatedStorage.Events.Fall and name == "FireServer" and Nofall then 
		table.insert(Args, 1, 0)
		return namecall(Self, Args)
	end
	return namecall(Self,...)
end)

setreadonly(mt, true)

print("Done Loading")
