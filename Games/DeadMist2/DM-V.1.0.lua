--// Made by H4 | 

print("Loading | 1%")
--// Load library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vozoid/ui-libraries/main/drawing/void/source.lua"))()
local main = library:Load{Name = "Dead Mist H4 testing",SizeX = 600,SizeY = 650,Theme = "Midnight",Extension = "json",Folder = "Dead Mist H4"}

--// Tabs
local CombatTab = main:Tab("Combat")
local LPlayerTab = main:Tab("LocalPlayer")
local VisualsTab = main:Tab("Visuals")

--// Game Variables
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local CCamera = game:GetService("Workspace").CurrentCamera
local mouse = localPlayer:GetMouse()

local DrawingFonts = {}

for Font, _ in next, Drawing.Fonts do
    table.insert(DrawingFonts, Font);
end;

print("Loading | 5%")

--// Menu variables
local esp_settings = {
    esp_enabled = false;
    esp_nametag = false;
    esp_heldTool = false;
    esp_boxes = false;
    esp_healthBars = false;
    esp_chams_self = false;
    esp_chams = false;
    esp_cham_outlines = false;

    esp_maxdistance = 1000;
    esp_cham_transparency = 0.5;
    esp_cham_outline_transparency = 0.1;

    esp_colour_main = Color3.fromRGB(255,0,0);
    esp_colour_cham = Color3.fromRGB(0,255,255);
    esp_colour_cham_outline = Color3.fromRGB(0,0,0);
    esp_selected_font = 1;
}
local vMaterial = {
    'SmoothPlastic';
    'ForceField';
    'Neon';
    'Glass';
}
local viewmodel_settings = {
    gun_enabled = false;
    gun_color = Color3.fromRGB(255,255,255);
    gun_transparency = 0;
    gun_material = "SmoothPlastic"
}
local combat_settings = {
    aimbot_enabled = false;
    aimbot_fov_circle = false;
    aimbot_fov_circle_color = Color3.fromRGB(255,255,255);
    aimbot_fov = 120;
    aimbot_sense = 0.32;

    hitboxes_enabled = false;
    hitboxes_size = 5;
    hitboxes_type = "Head";
    hitboxes_transparency = 0.4;
}

local infiniteJump = false

--// Menu other
local storage = {}
local highlight;
local function applyChams(player: Player)
    highlight = Instance.new("Highlight")
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = esp_settings.esp_colour_cham
    highlight.FillTransparency = 0.1

    highlight.OutlineColor = esp_settings.esp_colour_cham_outline
    highlight.OutlineTransparency = 1

    local function onAdded(character)
        highlight.Adornee = character
        highlight.Parent = character
    end

    local function onRemoved()
        highlight.Adornee = nil
        highlight.Parent = nil
    end

    if player.Character then
        onAdded(player.Character)
    end

    player.CharacterAdded:Connect(onAdded)
    player.CharacterRemoving:Connect(onRemoved)

    storage[player] = highlight
end

local function removeChams(player: Player)
    local highlight = storage[player]
    if highlight then
        highlight:Destroy()
        highlight = nil
        storage[player] = nil
    end
end

local function updateViewModel()
    if localPlayer and localPlayer.Character then
        local curTool = localPlayer.Character:FindFirstChildWhichIsA("Tool")
        if curTool and viewmodel_settings.gun_enabled then
            for i,v in next, curTool:GetChildren() do
                if v:IsA('Part') or v:IsA('BasePart') or v:IsA('MeshPart') or v:IsA("UnionOperation") then    
                    if v.Name ~= "EjectionPort" and v.Name ~= "AimPart" and v.Name ~= "SlideJoint" and v.Name ~= "Tip" and v.Name ~= "Handle" and v.Name ~= "Base" and v.Name ~= "AttachmentPointBarrel" then                
                        v.Color = viewmodel_settings.gun_color
                        v.Transparency = viewmodel_settings.gun_transparency
                        v.Material = Enum.Material[viewmodel_settings.gun_material]
                        if  v:IsA("UnionOperation") then
                            v.UsePartColor = true
                        end
                    end
                end
            end
        end
    end
end

local function aimbot_target()
    local Closest = nil;
    local DistanceToMouse = math.huge;

    for _, Player in pairs(game.GetChildren(Players)) do
        if Player ~= localPlayer and Player.Character and game.FindFirstChild(Player.Character, "HumanoidRootPart") and game.FindFirstChild(Player.Character, "Head") and game.FindFirstChild(Player.Character, "Humanoid") then        

            local Character = Player.Character
            local HumanoidRootPart = game.FindFirstChild(Character, "HumanoidRootPart")
            local Humanoid = game.FindFirstChild(Character, "Humanoid")

            local vec3, OnScreen = CCamera.WorldToScreenPoint(CCamera, HumanoidRootPart.Position)
            local ScreenPosition = Vector2.new(vec3.X, vec3.Y)

            local Distance = (Vector2.new(mouse.X, mouse.Y) - ScreenPosition).Magnitude

            if Humanoid.Health > 0.0 and OnScreen then    
                if Distance <= DistanceToMouse and Distance <= combat_settings.aimbot_fov then
                    Closest = Character
                    DistanceToMouse = Distance
                end                
            end
        end
    end    
    return Closest
end

local function getPlayerFromName(name)
    for i,v in pairs(Players:GetPlayers()) do
        if v.Name == tostring(name) then
            return v;
        end
    end
end

print("Loading | 10%")

--// PFly stuff
local curPlatform;
local qUp, eUp, qDown, eDown;
local flying = false;
local floatName = "23r98n908n23wf0b"

--// Aimbot stuff
local fov_circle
local aiming = false

local aimbotSection = CombatTab:Section{Name = "Aimbot", Side = "Left"}
aimbotSection:Toggle{Name = "Enabled", Flag = "aenabled 1",--Default = true,
    Callback = function(bool)
        combat_settings.aimbot_enabled = bool        
    end
}
local fov_circle_toggle = aimbotSection:Toggle{Name = "Fov circle", Flag = "aenabled 1",--Default = true,
    Callback = function(bool)
        combat_settings.aimbot_fov_circle = bool
        if combat_settings.aimbot_fov_circle then
            fov_circle = Drawing.new("Circle")
            fov_circle.Visible = true
            fov_circle.Color = combat_settings.aimbot_fov_circle_color
            fov_circle.Radius = combat_settings.aimbot_fov
            fov_circle.Thickness = 1
            fov_circle.Filled = false
            fov_circle.NumSides = 125
        elseif not combat_settings.aimbot_fov_circle and fov_circle ~= nil then
            fov_circle:Remove()
        end
    end
}
fov_circle_toggle:ColorPicker{Default = combat_settings.aimbot_fov_circle_color, Flag = "aenabled 1 Picker 1",
    Callback = function(color)
        combat_settings.aimbot_fov_circle_color = color
    end
}
aimbotSection:Slider{Name = "Aim Speed",Text = "[value]/1",Default = combat_settings.aimbot_sense, Min = 0,Max = 1,Float = 0.01,Flag = "fveiw 2",
    Callback = function(value)
        combat_settings.aimbot_sense = value
    end
}
aimbotSection:Slider{Name = "Field of view",Text = "[value]/1000",Default = combat_settings.aimbot_fov, Min = 1,Max = 1000,Float = 1,Flag = "fveiw 2",
    Callback = function(value)
        combat_settings.aimbot_fov = value
    end
}
aimbotSection:Label("Hitboxes")
aimbotSection:Toggle{Name = "Enabled", Flag = "aenabled 1",--Default = true,
    Callback = function(bool)
        combat_settings.hitboxes_enabled = bool
        
        if not combat_settings.hitboxes_enabled then
            for i,v in next, Players:GetPlayers() do
                if v ~= localPlayer and v.Character and v.Character[combat_settings.hitboxes_type] then
                    v.Character[combat_settings.hitboxes_type].Size = localPlayer.Character[combat_settings.hitboxes_type].Size
                end
            end
        end

    end
}
aimbotSection:Dropdown{Name = "Hitbox Type",Default = 1, Content = {"Head", "HumanoidRootPart"}, Flag = "awdcx 1",
    Callback = function(option)
        combat_settings.hitboxes_type = option
    end
}
aimbotSection:Slider{Name = "Hitbox size",Text = "[value]/100",Default = combat_settings.hitboxes_size, Min = 0, Max = 100, Float = 0.1,Flag = "wad 1",
    Callback = function(value)
        combat_settings.hitboxes_size = value
    end
}
aimbotSection:Slider{Name = "Hitbox Transparency",Text = "[value]/1",Default = combat_settings.hitboxes_size, Min = 0, Max = 100, Float = 0.1,Flag = "wad 1",
    Callback = function(value)
        combat_settings.hitboxes_size = value
    end
}

coroutine.wrap(function()    
    while wait(1) do
        if combat_settings.hitboxes_enabled then
            pcall(function()                  
                for i,v in pairs(Players:GetPlayers()) do
                    if v ~= localPlayer and v.Character and v.Character:FindFirstChild('Head') then
                        v.Character[combat_settings.hitboxes_type].Size = Vector3.new(combat_settings.hitboxes_size,combat_settings.hitboxes_size,combat_settings.hitboxes_size)
                        v.Character[combat_settings.hitboxes_type].Transparency = combat_settings.hitboxes_transparency
                        v.Character[combat_settings.hitboxes_type].CanCollide = false
                        if v.Character.Humanoid.Health == 0 then
                            v.Character[combat_settings.hitboxes_type].Size = localPlayer.Character[combat_settings.hitboxes_type].Size
                            v.Character[combat_settings.hitboxes_type].Transparency = localPlayer.Character[combat_settings.hitboxes_type].Transparency                        
                        end
                    end
                end
            end)
        end
    end
end)()

local lPlayerMovSection = LPlayerTab:Section{Name = "Movement", Side = "Left"}
lPlayerMovSection:Toggle{Name = "P-Flight", Flag = "pflye 1",--Default = true,
    Callback = function(isEnabled)
        flying = isEnabled     
        if flying then
            curPlatform = Instance.new('Part')      
            local FloatValue = -3.5;  

            curPlatform.Name = floatName
            curPlatform.Parent = localPlayer.Character
            curPlatform.Transparency = 1
            curPlatform.Size = Vector3.new(6,1,6)
            curPlatform.Anchored = true   

            curPlatform.CFrame = localPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, FloatValue, 0)
                
            eUp = mouse.KeyUp:Connect(function(KEY)
                print(KEY)
            end)  

            qUp = mouse.KeyUp:Connect(function(KEY)
                if KEY == 'q' then
                    FloatValue = FloatValue + 0.5
                end
            end)                               
            eUp = mouse.KeyUp:Connect(function(KEY)
                if KEY == ' ' then
                    FloatValue = FloatValue - 0.5
                end
            end)            
            qDown = mouse.KeyDown:Connect(function(KEY)
                if KEY == 'q' then
                    FloatValue = FloatValue - 0.5
                end
            end)            
            eDown = mouse.KeyDown:Connect(function(KEY)
                if KEY == ' ' then
                    FloatValue = FloatValue + 0.5
                end
            end)              

            local function FloatPadLoop()
                if localPlayer.Character:FindFirstChild(floatName) and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    curPlatform.CFrame = localPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,FloatValue,0)
                else
                    FloatingFunc:Disconnect()
                    curPlatform:Destroy()
                    qUp:Disconnect()
                    eUp:Disconnect()
                    qDown:Disconnect()
                    eDown:Disconnect()                        
                end
            end 
            
            FloatingFunc = game:GetService('RunService').Heartbeat:Connect(FloatPadLoop)             
        end

        if not flying and curPlatform then
            FloatingFunc:Disconnect()
            curPlatform:Destroy()
            qUp:Disconnect()
			eUp:Disconnect()
			qDown:Disconnect()
			eDown:Disconnect()
        end
        
    end
}
lPlayerMovSection:Toggle{Name = "Infinite Jump", Flag = "ijump 1",--Default = true,
    Callback = function(bool)
        infiniteJump = bool
    end
}

local lPlayerMiscSection = LPlayerTab:Section{Name = "Miscellaneous", Side = "Right"}
lPlayerMiscSection:Slider{Name = "Field of view",Text = "[value]/120",Default = CCamera.FieldOfView,Min = 0,Max = 120,Float = 1,Flag = "fveiw 1",
    Callback = function(value)
        CCamera.FieldOfView = value
    end
}

local playervisSection = VisualsTab:Section{Name = "Player visuals", Side = "Left"}
local esp_toggle = playervisSection:Toggle{Name = "ESP Enabled", Flag = "Toggle 1",--Default = true,
    Callback = function(bool)
       esp_settings.esp_enabled = bool;
    end
}
local colorpicker_esp_toggle = esp_toggle:ColorPicker{Default = esp_settings.esp_colour_main, Flag = "esp_main 1 Picker 1",
    Callback = function(color)
        esp_settings.esp_colour_main = color
    end
}
local nametag_toggle = playervisSection:Toggle{Name = "Nametags",Flag = "nametag 2",--Default = true,
    Callback  = function(bool)
        esp_settings.esp_nametag = bool
    end
}
local boxes_toggle = playervisSection:Toggle{Name = "Boxes",Flag = "boxes 2",--Default = true,
    Callback  = function(bool)
        esp_settings.esp_boxes = bool
    end
}
local healthbar_toggle = playervisSection:Toggle{Name = "Health bars",Flag = "hBar 2",--Default = true,
    Callback  = function(bool)
        esp_settings.esp_healthBars = bool
    end
}
local cur_tool_toggle = playervisSection:Toggle{Name = "Current tool",Flag = "curTool 2",--Default = true,
    Callback  = function(bool)
        esp_settings.esp_heldTool = bool
    end
}
playervisSection:Label("Chams")
local cham_toggle = playervisSection:Toggle{Name = "Chams", Flag = "Toggle 1",--Default = true,
    Callback = function(bool)
        esp_settings.esp_chams = bool;
        if not esp_settings.esp_chams then
            for i,v in pairs(Players:GetPlayers()) do
                if (v.Character) then
                    removeChams(v)
                end
            end
        else
            for i,v in pairs(Players:GetPlayers()) do
                if (v ~= localPlayer and v.Character) then                                  
                    applyChams(v)                
                end
            end 
        end
    end
}
playervisSection:Toggle{Name = "Self Chams", Flag = "Toggle 1",--Default = true,
    Callback = function(bool)
        esp_settings.esp_chams_self = bool;      
        if not esp_settings.esp_chams_self then            
            removeChams(localPlayer)           
        else
            applyChams(localPlayer)
        end
    end
}
cham_toggle:ColorPicker{Default = esp_settings.esp_colour_cham, Flag = "esp_cham 1 Picker 1",
    Callback = function(color)
        esp_settings.esp_colour_cham = color
    end
}

local cham_outline_toggle = playervisSection:Toggle{Name = "Cham outlines", Flag = "Toggle 1",Default = true,
    Callback = function(bool)
       esp_settings.esp_cham_outlines = bool;
    end
}
cham_outline_toggle:ColorPicker{Default = esp_settings.esp_colour_cham_outline, Flag = "esp_chamo 1 Picker 1",
    Callback = function(color)
        esp_settings.esp_colour_cham_outline = color
    end
}
playervisSection:Slider{Name = "Cham Transparency",Text = "[value]/1",Default = 0.5,Min = 0,Max = 1,Float = 0.01,Flag = "cham_trans 1",
    Callback = function(value)
        esp_settings.esp_cham_transparency = value
    end
}
playervisSection:Slider{Name = "Cham outline Transparency",Text = "[value]/1",Default = 0.1,Min = 0,Max = 1,Float = 0.01,Flag = "cham_trans 2",
    Callback = function(value)
        esp_settings.esp_cham_outline_transparency = value
    end
}
playervisSection:Slider{Name = "Max distance",Text = "[value]/10000",Default = 1000,Min = 16,Max = 10000,Float = 1,Flag = "esp_dist 1",
    Callback = function(value)
        esp_settings.esp_maxdistance = value
    end
}
local esp_font_dropdown = playervisSection:Dropdown{Name = "ESP Font",Default = 1,Content = DrawingFonts,Flag = "esp_font 1",
    Callback = function(option)
        esp_settings.esp_selected_font = option
    end
}
esp_font_dropdown:Set("UI") 

local playerViewSection = VisualsTab:Section{Name = "Local Viewmodel", Side = "Right"}
playerViewSection:Label("Weapon")
playerViewSection:Toggle{Name = "Weapon model", Flag = "Toggle gv 1", --Default = true,
    Callback = function(bool)
       viewmodel_settings.gun_enabled = bool
    end
}
playerViewSection:ColorPicker{Name = "Weapon color",Default = Color3.fromRGB(0, 255, 0),Flag = "gcolor 1",
    Callback = function(color)
        viewmodel_settings.gun_color = color
        updateViewModel()
    end
}
playerViewSection:Slider{Name = "Weapon transparency",Text = "[value]/1",Default = 0,Min = 0,Max = 1,Float = 0.01,Flag = "gtrans 1",
    Callback = function(value)
        viewmodel_settings.gun_transparency = value
        updateViewModel()
    end
}
local gmaterial_dropdown = playerViewSection:Dropdown{Name = "Weapon material",Default = 1,Content = vMaterial,Flag = "gmat 1",
    Callback = function(option)
        viewmodel_settings.gun_material = option
        updateViewModel()
    end
}
gmaterial_dropdown:Set("SmoothPlastic") 

local playersSection = VisualsTab:Section{Name = "Players", Side = "Right"}
local playerlist = {}
local selectedPlayer = nil

for i,v in pairs(game.Players:GetPlayers()) do 
    table.insert(playerlist, v.Name)    
end

local nameLabel;
local ageLabel;
local teamLabel;
local banditKillsLabel;
local DaysAliveLabel;
local PlayerKillsLabel;
local ZombieKillsLabel;
local MinutesAliveLabel;
local healthLabel;
local toolLabel;

local function RefreshStats()
    if selectedPlayer ~= nil and selectedPlayer.Character then
        nameLabel:Set("Name: "..selectedPlayer.Name)
        ageLabel:Set("Account Age: "..tostring(selectedPlayer.AccountAge))
        teamLabel:Set("Team: "..tostring(selectedPlayer.Team))

        if selectedPlayer.PlayerStats then
            banditKillsLabel:Set("BanditKills: "..tostring(selectedPlayer.PlayerStats.BanditKills.Value))
            DaysAliveLabel:Set("DaysAlive: "..tostring(selectedPlayer.PlayerStats.DaysAlive.Value))
            PlayerKillsLabel:Set("PlayerKills: "..tostring(selectedPlayer.PlayerStats.PlayerKills.Value))
            ZombieKillsLabel:Set("ZombieKills: "..tostring(selectedPlayer.PlayerStats.ZombieKills.Value))
            MinutesAliveLabel:Set("MinutesAlive: "..tostring(selectedPlayer.PlayerStats.MinutesAlive.Value))
        end

        if selectedPlayer.Character.Humanoid then
            healthLabel:Set("Health: "..tostring(selectedPlayer.Character.Humanoid.Health))

            local currentTool = selectedPlayer.Character:FindFirstChildWhichIsA("Tool")
            if currentTool then
                toolLabel:Set("Cuurent Tool: "..currentTool.Name)
            else
                toolLabel:Set("Cuurent Tool: ")
            end
        end

    end
end

local players_dropdown = playersSection:Dropdown{Name = "Target Player",Default = 1,Content = playerlist, Flag = "gmat 1",
    Callback = function(option)
        selectedPlayer = getPlayerFromName(option); 
        RefreshStats()      
    end
}

Players.PlayerAdded:Connect(function(player)
    local name = player.Name
    table.insert(playerlist, name)
    players_dropdown:Refresh(playerlist)
end)
Players.PlayerRemoving:Connect(function(player)
    local name = player.Name
    for i,v in pairs(playerlist)do
        if v == name then  
            table.remove(playerlist,i)
        end
    end
    players_dropdown:Refresh(playerlist)
end)
local isSpectating = false;
playersSection:Toggle{Name = "Spectate player", Flag = "d gv 1", --Default = true,
    Callback = function(bool)
        isSpectating = bool
        if isSpectating then
            repeat 
                if selectedPlayer then
                    CCamera.CameraSubject = selectedPlayer.Character.Humanoid                
                end
                task.wait(0.4)
            until not isSpectating      
        else       
            CCamera.CameraSubject = localPlayer.Character.Humanoid
        end  
    end
}

nameLabel = playersSection:Label("Name: ")
ageLabel = playersSection:Label("Account Age: ")
teamLabel = playersSection:Label("Team: ")
banditKillsLabel = playersSection:Label("BanditKills: ")
DaysAliveLabel = playersSection:Label("DaysAlive: ")
PlayerKillsLabel = playersSection:Label("PlayerKills: ")
ZombieKillsLabel = playersSection:Label("ZombieKills: ")
MinutesAliveLabel = playersSection:Label("MinutesAlive: ")
healthLabel = playersSection:Label("Health: ")
toolLabel = playersSection:Label("Cuurent Tool: ")

print("Loading | 20%")

--// Configuration

--library:SaveConfig("config", true) -- universal config
--library:SaveConfig("config") -- game specific config
--library:DeleteConfig("config", true) -- universal config
--library:DeleteConfig("config") -- game specific config
--library:GetConfigs(true) -- return universal and game specific configs (table)
--library:GetConfigs() -- return game specific configs (table)
--library:LoadConfig("config", true) -- load universal config
--library:LoadConfig("config") -- load game specific config

local configs = main:Tab("Configuration")
local themes = configs:Section{Name = "Theme", Side = "Left"}

local themepickers = {}

local themelist = themes:Dropdown{
   Name = "Theme",
   Default = library.currenttheme,
   Content = library:GetThemes(),
   Flag = "Theme Dropdown",
   Callback = function(option)
       if option then
           library:SetTheme(option:lower())

           for option, picker in next, themepickers do
               picker:Set(library.theme[option])
           end
       end
   end
}

library:ConfigIgnore("Theme Dropdown")

local namebox = themes:Box{
   Name = "Custom Theme Name",
   Placeholder = "Custom Theme",
   Flag = "Custom Theme"
}

library:ConfigIgnore("Custom Theme")

themes:Button{
   Name = "Save Custom Theme",
   Callback = function()
       if library:SaveCustomTheme(library.flags["Custom Theme"]) then
           themelist:Refresh(library:GetThemes())
           themelist:Set(library.flags["Custom Theme"])
           namebox:Set("")
       end
   end
}

local customtheme = configs:Section{Name = "Custom Theme", Side = "Right"}

themepickers["Accent"] = customtheme:ColorPicker{
   Name = "Accent",
   Default = library.theme["Accent"],
   Flag = "Accent",
   Callback = function(color)
       library:ChangeThemeOption("Accent", color)
   end
}

library:ConfigIgnore("Accent")

themepickers["Window Background"] = customtheme:ColorPicker{
   Name = "Window Background",
   Default = library.theme["Window Background"],
   Flag = "Window Background",
   Callback = function(color)
       library:ChangeThemeOption("Window Background", color)
   end
}

library:ConfigIgnore("Window Background")

themepickers["Window Border"] = customtheme:ColorPicker{
   Name = "Window Border",
   Default = library.theme["Window Border"],
   Flag = "Window Border",
   Callback = function(color)
       library:ChangeThemeOption("Window Border", color)
   end
}

library:ConfigIgnore("Window Border")

themepickers["Tab Background"] = customtheme:ColorPicker{
   Name = "Tab Background",
   Default = library.theme["Tab Background"],
   Flag = "Tab Background",
   Callback = function(color)
       library:ChangeThemeOption("Tab Background", color)
   end
}

library:ConfigIgnore("Tab Background")

themepickers["Tab Border"] = customtheme:ColorPicker{
   Name = "Tab Border",
   Default = library.theme["Tab Border"],
   Flag = "Tab Border",
   Callback = function(color)
       library:ChangeThemeOption("Tab Border", color)
   end
}

library:ConfigIgnore("Tab Border")

themepickers["Tab Toggle Background"] = customtheme:ColorPicker{
   Name = "Tab Toggle Background",
   Default = library.theme["Tab Toggle Background"],
   Flag = "Tab Toggle Background",
   Callback = function(color)
       library:ChangeThemeOption("Tab Toggle Background", color)
   end
}

library:ConfigIgnore("Tab Toggle Background")

themepickers["Section Background"] = customtheme:ColorPicker{
   Name = "Section Background",
   Default = library.theme["Section Background"],
   Flag = "Section Background",
   Callback = function(color)
       library:ChangeThemeOption("Section Background", color)
   end
}

library:ConfigIgnore("Section Background")

themepickers["Section Border"] = customtheme:ColorPicker{
   Name = "Section Border",
   Default = library.theme["Section Border"],
   Flag = "Section Border",
   Callback = function(color)
       library:ChangeThemeOption("Section Border", color)
   end
}

library:ConfigIgnore("Section Border")

themepickers["Text"] = customtheme:ColorPicker{
   Name = "Text",
   Default = library.theme["Text"],
   Flag = "Text",
   Callback = function(color)
       library:ChangeThemeOption("Text", color)
   end
}

library:ConfigIgnore("Text")

themepickers["Disabled Text"] = customtheme:ColorPicker{
   Name = "Disabled Text",
   Default = library.theme["Disabled Text"],
   Flag = "Disabled Text",
   Callback = function(color)
       library:ChangeThemeOption("Disabled Text", color)
   end
}

library:ConfigIgnore("Disabled Text")

themepickers["Object Background"] = customtheme:ColorPicker{
   Name = "Object Background",
   Default = library.theme["Object Background"],
   Flag = "Object Background",
   Callback = function(color)
       library:ChangeThemeOption("Object Background", color)
   end
}

library:ConfigIgnore("Object Background")

themepickers["Object Border"] = customtheme:ColorPicker{
   Name = "Object Border",
   Default = library.theme["Object Border"],
   Flag = "Object Border",
   Callback = function(color)
       library:ChangeThemeOption("Object Border", color)
   end
}

library:ConfigIgnore("Object Border")

themepickers["Dropdown Option Background"] = customtheme:ColorPicker{
   Name = "Dropdown Option Background",
   Default = library.theme["Dropdown Option Background"],
   Flag = "Dropdown Option Background",
   Callback = function(color)
       library:ChangeThemeOption("Dropdown Option Background", color)
   end
}

library:ConfigIgnore("Dropdown Option Background")

local configsection = configs:Section{Name = "Configs", Side = "Left"}

local configlist = configsection:Dropdown{
   Name = "Configs",
   Content = library:GetConfigs(), -- GetConfigs(true) if you want universal configs
   Flag = "Config Dropdown"
}

library:ConfigIgnore("Config Dropdown")
local loadconfig = configsection:Button{
   Name = "Load Config",
   Callback = function()
       library:LoadConfig(library.flags["Config Dropdown"]) -- LoadConfig(library.flags["Config Dropdown"], true)  if you want universal configs
   end
}
local delconfig = configsection:Button{
   Name = "Delete Config",
   Callback = function()
       library:DeleteConfig(library.flags["Config Dropdown"]) -- DeleteConfig(library.flags["Config Dropdown"], true)  if you want universal configs
   end
}
local configbox = configsection:Box{
   Name = "Config Name",
   Placeholder = "Config Name",
   Flag = "Config Name"
}
library:ConfigIgnore("Config Name")
local save = configsection:Button{
   Name = "Save Config",
   Callback = function()
       library:SaveConfig(library.flags["Config Name"]) -- SaveConfig(library.flags["Config Name"], true) if you want universal configs
       configlist:Refresh(library:GetConfigs())
   end
}

print("Loading | 60%")

--// Main Service
local boxheight1 = 2.5
local boxWidth1 = 1.5
local boxheight2 = 3
local boxWidth2 = 1.5

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = true
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    --// Player ESP
    if esp_settings.esp_enabled and localPlayer and localPlayer.Character then
        for i,v in pairs(Players:GetPlayers()) do
            if v ~= localPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (v.Character:FindFirstChild("HumanoidRootPart").Position-localPlayer.Character.HumanoidRootPart.Position).Magnitude
                local headPart = v.Character.Head
                local boxPart = v.Character.HumanoidRootPart
                local vector, onScreen = CCamera:WorldToViewportPoint(headPart.Position)
                local vector_2, onScreen2 = CCamera:WorldToViewportPoint(boxPart.Position)

                if dist < esp_settings.esp_maxdistance and dist > 7 then
                    if esp_settings.esp_nametag and onScreen then                     
                        local nameTag = Drawing.new("Text")            
                        nameTag.Visible = true            
                        nameTag.Font = Drawing.Fonts[tostring(esp_settings.esp_selected_font)]
                        nameTag.Center = true
                        nameTag.Outline = true
                        nameTag.Size = math.clamp(16-(headPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,16,83)
                        nameTag.Color = esp_settings.esp_colour_main
                        nameTag.Text = v.Name.." | "..math.round(dist)
                        nameTag.Position = Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/26)).Y)                     
                        coroutine.wrap(function()                    
                            game.RunService.RenderStepped:Wait()
                            nameTag:Remove()
                        end)()
                    end

                    if esp_settings.esp_heldTool and onScreen2 then
                        local wepTag = Drawing.new("Text")            
                        wepTag.Visible = true            
                        wepTag.Font = Drawing.Fonts[tostring(esp_settings.esp_selected_font)]
                        wepTag.Center = true
                        wepTag.Outline = true
                        wepTag.Size = math.clamp(16-(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,16,83)
                        wepTag.Color = esp_settings.esp_colour_main
                        if v.Character:FindFirstChildWhichIsA("Tool") then    
                            wepTag.Text = v.Character:FindFirstChildWhichIsA("Tool").Name
                        else
                            wepTag.Text = "none"
                        end
                        wepTag.Position = Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/43)).Y)  
        
                        coroutine.wrap(function()                    
                            game.RunService.RenderStepped:Wait()
                            wepTag:Remove()
                        end)()
                    end

                    if esp_settings.esp_boxes and onScreen2 then
                        local boxPart = v.Character.HumanoidRootPart                            
                        --// Outline box          
                        local boxOutline = Drawing.new("Quad")       
                        boxOutline.Visible = true
                        boxOutline.Color = Color3.new(0, 0, 0)
                        boxOutline.Thickness = 2.5
                        boxOutline.Transparency = 1
                        boxOutline.Filled = false
                        boxOutline.ZIndex = 1     
                        boxOutline.PointA = Vector2.new(
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * boxheight1).X,
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * boxheight1).Y)  
                        boxOutline.PointB = Vector2.new(
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * boxheight1).X,
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * boxheight1).Y)  
                        boxOutline.PointC = Vector2.new(
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * -boxheight2).X,
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * -boxheight2).Y)  
                        boxOutline.PointD = Vector2.new(
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * -boxheight2).X,
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * -boxheight2).Y)
        
                        --// Main box                    
                        local box = Drawing.new("Quad")       
                        box.Visible = true
                        box.Color = esp_settings.esp_colour_main
                        box.Thickness = 1
                        box.Transparency = 1
                        box.Filled = false
                        box.ZIndex = 2                  
                        box.PointA = Vector2.new(
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * boxheight1).X,
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * boxheight1).Y)  
                        box.PointB = Vector2.new(
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * boxheight1).X,
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * boxheight1).Y)  
                        box.PointC = Vector2.new(
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * -boxheight2).X,
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * -boxheight2).Y)  
                        box.PointD = Vector2.new(
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * -boxheight2).X,
                            CCamera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * -boxheight2).Y)             
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:wait()
                            box:Remove()
                            boxOutline:Remove()
                        end)() 
                    end

                    if esp_settings.esp_healthBars and onScreen then
                        local healthnum=v.Character.Humanoid.Health
                        local maxhealth=v.Character.Humanoid.MaxHealth
                        local c=Drawing.new("Quad")
                        c.Visible=true
                        c.Color = Color3.fromRGB(0,0,0)
                        c.Thickness=1
                        c.Transparency=1
                        c.Filled=false
                        c.PointA=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*2.5).Y)
                        c.PointB=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*2.5).Y)
                        c.PointC=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*-boxheight2).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*-boxheight2).Y)
                        c.PointD=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*-boxheight2).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*-boxheight2).Y)
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
                        game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*2.5).Y)
                        e.PointB=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*2.5).Y)
                        e.PointC=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*-boxheight2).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*-boxheight2).Y)
                        e.PointD=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*-boxheight2).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*-boxheight2).Y)
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            e:Remove()
                        end)()
                        local d = Drawing.new("Quad")
                        d.Visible=true
                        d.Color = Color3.fromRGB(0, 255, 0)
                        d.Thickness=1
                        d.Transparency=1
                        d.Filled=true
                        d.PointA=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*(-boxheight2+healthnum/(maxhealth/5))).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2.5+boxPart.CFrame.UpVector*(-boxheight2+healthnum/(maxhealth/5))).Y)
                        d.PointB=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*(-boxheight2+healthnum/(maxhealth/5))).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.RightVector*2+boxPart.CFrame.UpVector*(-boxheight2+healthnum/(maxhealth/5))).Y)
                        d.PointC=c.PointC
                        d.PointD=c.PointD
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            d:Remove()
                        end)()
                    end
                end
            end
        end             
    end
    
    for i,v in next, storage do
        local highlight = storage[i]
        if highlight then

            highlight.FillColor = esp_settings.esp_colour_cham
            highlight.OutlineColor = esp_settings.esp_colour_cham_outline
            highlight.FillTransparency = esp_settings.esp_cham_transparency

            if esp_settings.esp_cham_outlines then
                highlight.OutlineTransparency = esp_settings.esp_cham_outline_transparency
            else
                highlight.OutlineTransparency = 1
            end   

        end
    end

    --// Aimbots
    if combat_settings.aimbot_enabled and fov_circle ~= nil then
        fov_circle.Position = Vector2.new(mouse.X, mouse.Y + 36)    
        fov_circle.Radius = combat_settings.aimbot_fov
        fov_circle.Visible = true   
        fov_circle.Color = combat_settings.aimbot_fov_circle_color     
        
        if aimbot_target() then
            local target = aimbot_target()           
            local position, b = CCamera:WorldToScreenPoint(target["Head"].Position)         
            
            if aiming and target and target:FindFirstChild("Head") then                                
                mousemoverel((position.X - mouse.X) * combat_settings.aimbot_sense, (position.Y - mouse.Y) * combat_settings.aimbot_sense)
            end   
        end      
    end

end)

mouse.KeyDown:Connect(function(Key)
	if infiniteJump == true and Key == " " then
		localPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
	end
end)

coroutine.wrap(function()
    while esp_settings.esp_chams do
        for i,v in pairs(Players:GetPlayers()) do
            if (v ~= localPlayer and v.Character) then
                coroutine.wrap(function()
                    task.wait(3)
                    removeChams(v)
                end)()                
                applyChams(v)                
            end
        end
        task.wait(3)
    end
end)()
coroutine.wrap(function()
    while esp_settings.esp_chams_self do
        if localPlayer and localPlayer.Character then
            coroutine.wrap(function()
                task.wait(3)
                removeChams(localPlayer)
            end)()                
            applyChams(localPlayer)            
        end
        task.wait(3)
    end
end)()
coroutine.wrap(function()
    while true do 
        RefreshStats()
        task.wait(1)
    end
end)()

print("Loading | 100%")
