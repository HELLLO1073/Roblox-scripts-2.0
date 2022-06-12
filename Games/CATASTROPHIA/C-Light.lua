--// Catastrophia Lite, Built for these free exploit users...

local logger = true
rconsoleclear()

local function CLog(txtColor, txt)
    if logger then

        if txtColor then
            rconsoleprint("@@"..txtColor.."@@") 
        else
            rconsoleprint("@@LIGHT_CYAN@@") 
        end
        
        rconsoleprint("[C-Light]: ") rconsoleprint("@@WHITE@@") rconsoleprint(txt.."\n")
    end
end

rconsoleprint("@@MAGENTA@@") rconsoleprint("C-Light | Created by H4\n")

CLog(nil, "Loading %10")

-- // Initialising the UI
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Venyx-UI-Library/main/source2.lua"))()
local libraryUI = library.new({title = "C-Lite | Created by H4"})

local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()
 
espLib.whitelist = {} -- insert string that is the player's name you want to whitelist (turns esp color to whitelistColor in options)
espLib.blacklist = {} -- insert string that is the player's name you want to blacklist (removes player from esp)
espLib.options = {
    enabled = true,
    scaleFactorX = 4,
    scaleFactorY = 5,
    font = 2,
    fontSize = 13,
    limitDistance = true,
    maxDistance = 5000,
    visibleOnly = false,
    teamCheck = false,
    teamColor = false,
    fillColor = nil,
    whitelistColor = Color3.new(1, 0, 0),
    outOfViewArrows = false,
    outOfViewArrowsFilled = false,
    outOfViewArrowsSize = 15,
    outOfViewArrowsRadius = 300,
    outOfViewArrowsColor = Color3.fromRGB(244, 244, 0),
    outOfViewArrowsTransparency = 0.5,
    outOfViewArrowsOutline = false,
    outOfViewArrowsOutlineFilled = false,
    outOfViewArrowsOutlineColor = Color3.new(0, 0, 0),
    outOfViewArrowsOutlineTransparency = 0,
    names = false,
    nameTransparency = 1,
    nameColor = Color3.fromRGB(244, 244, 0),
    boxes = false,
    boxesTransparency = 1,
    boxesColor = Color3.fromRGB(244, 244, 0),
    boxFill = false,
    boxFillTransparency = 0.5,
    boxFillColor = Color3.fromRGB(244, 244, 0),
    healthBars = false,
    healthBarsSize = 1,
    healthBarsTransparency = 1,
    healthBarsColor = Color3.new(0, 1, 0),
    healthText = false,
    healthTextTransparency = 1,
    healthTextSuffix = "%",
    healthTextColor = Color3.new(1, 1, 1),
    distance = false,
    distanceTransparency = 1,
    distanceSuffix = " Studs",
    distanceColor = Color3.new(1, 1, 1),
    tracers = false,
    tracerTransparency = 1,
    tracerColor = Color3.fromRGB(244, 244, 0),
    tracerOrigin = "Bottom", -- Available [Mouse, Top, Bottom]
    chams = false,
    chamsColor = Color3.new(1, 0, 0),
    chamsTransparency = 0.5,
}

CLog(nil, "Loading %15")

--// Game Vars
local CCamera = game:GetService("Workspace").CurrentCamera
local UserInput = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local AnimalFolder = workspace.Animals
local objectFolder = game:GetService("Workspace").Suroviny

CLog(nil, "Loading %16")

local CameraOveride = false
local CameraFov = 70

CLog(nil, "Loading %16.5")

--// Pages
local local_page = libraryUI:addPage({title = "LocalPlayer", icon = 5012544693})
CLog(nil, "Loading %17")
local esp_page = libraryUI:addPage({title = "Visuals", icon = 5012544693})
CLog(nil, "Loading %17.5")
local player_page = libraryUI:addPage({title = "Players", icon = 6031280883})
local ui_page = libraryUI:addPage({title = "Settings", icon = 6022860343})

CLog(nil, "Loading %18")

--// Sections
--// LocalPlayer
local misc_section = local_page:addSection({title = "Player Visuals"})

CLog(nil, "Loading %19")

--// Visuals
local EspSection = esp_page:addSection({title = "Player Visuals"})
local WorldVisualSection = esp_page:addSection({title = "World Visuals"})
local EspSectionSettings = esp_page:addSection({title = "Visual settings"})

CLog(nil, "Loading %20")
--// Settings
local UISection = ui_page:addSection({title = "UI"})

--// Players 
local target_section = player_page:addSection({title = "Target Player"})

misc_section:addSlider({title = "Field of view", default = CameraFov, min = 1, max = 120,
    callback = function(value)
        if not CameraOveride then
            CameraOveride = true
        end
        CameraFov = value
    end
})
misc_section:addToggle({title = "Third person",
    callback = function(bool)
        if bool then 
            LocalPlayer.CameraMode = Enum.CameraMode.Classic      
        else
            LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        end
    end
})

EspSection:addToggle({title = "ESP Enabled",
    callback = function(bool)
        espLib.options.enabled = bool
        espLib.options.outOfViewArrows = bool
        espLib.options.outOfViewArrowsOutline = bool
        if bool then
            espLib.options.outOfViewArrowsOutlineTransparency = 1
        else
            espLib.options.outOfViewArrowsOutlineTransparency = 0
        end
    end
})
EspSection:addToggle({title = "Names",
    callback = function(bool)
        espLib.options.names = bool
    end
})
EspSection:addToggle({title = "Boxes",
    callback = function(bool)
        espLib.options.boxes = bool
    end
})
EspSection:addToggle({title = "Health bars",
    callback = function(bool)
        espLib.options.healthBars = bool
    end
})
EspSection:addToggle({title = "OutOfView Arrows",
    callback = function(bool)
        espLib.options.outOfViewArrows = bool
        espLib.options.outOfViewArrowsOutline = bool
        espLib.options.outOfViewArrowsFilled = bool
        
    end
})
EspSection:addToggle({title = "Tracers",
    callback = function(bool)
        espLib.options.tracers = bool
    end
})

local VisualSettings = {
    World = {
        Animals = {Enabled = false; Color = Color3.fromRGB(0, 220, 205)};
        OreChams = {Enabled = false};
        ChestChams = {Enabled = false};
    };
}

local hObjectStorage = {
    GrassMesh = {};
    OreMesh = {};
    ChestMesh = {};
}
 
local function chamObject(objectType, object, color, OutColor)
    if object and objectType then
        local highlight = Instance.new("Highlight")
 
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop        
 
        highlight.FillColor = color
        highlight.FillTransparency = 0.4
 
        highlight.OutlineColor = OutColor
        highlight.OutlineTransparency = 0
 
        highlight.Adornee = object
        highlight.Parent = object
 
        hObjectStorage[objectType][object] = highlight
    end
end
 
local function unChamObject(objectType, object)
    if object and objectType then
        local highlight = hObjectStorage[objectType][object]
        if highlight then 
            highlight:Destroy()
            hObjectStorage[objectType][object] = nil
            highlight = nil
        end
    end
end

WorldVisualSection:addToggle({title = "Ore Chams",
    callback = function(bool)
        VisualSettings.World.OreChams.Enabled = bool
        if  VisualSettings.World.OreChams.Enabled then
            for i,v in next, objectFolder:GetChildren() do
                if v.Name:match("Ore") and v:IsA("UnionOperation") then
                    chamObject("OreMesh", v, v.Color, Color3.fromRGB(0,0,0))
                end
            end
        else
            for i,v in next, objectFolder:GetChildren() do
                if v.Name:match("Ore") and v:IsA("UnionOperation") then
                    unChamObject("OreMesh", v)
                end
            end
        end
    end
})
WorldVisualSection:addToggle({title = "Chest Chams",
    callback = function(bool)
        VisualSettings.World.ChestChams.Enabled = bool
        if VisualSettings.World.ChestChams.Enabled then
            for i,v in next, game:GetService("Workspace").Items:GetChildren() do
                if v.Name:match("Chest") and v:IsA("Model") then
                    chamObject("ChestMesh", v, Color3.fromRGB(255, 217, 0), Color3.fromRGB(0,0,0))
                end
            end
        else
            for i,v in next, game:GetService("Workspace").Items:GetChildren() do
                if v.Name:match("Chest") and v:IsA("Model") then
                    unChamObject("ChestMesh", v)
                end
            end
        end
    end
})
WorldVisualSection:addToggle({title = "Animal ESP",
    callback = function(bool)
        VisualSettings.World.Animals.Enabled = bool
    end
})

CLog(nil, "Loading %25")

EspSectionSettings:addColorPicker({title = "Main Color", default = Color3.fromRGB(244, 244, 0),
    callback = function(color3)
        espLib.options.nameColor = color3 
        espLib.options.boxesColor = color3
        espLib.options.outOfViewArrowsColor = color3 
        espLib.options.tracerColor = color3        
    end
})
EspSectionSettings:addColorPicker({title = "Animal Color", default = Color3.fromRGB(0, 220, 205),
    callback = function(color3)
        VisualSettings.World.Animals.Color = color3
    end
})
EspSectionSettings:addSlider({title = "Max Distance", default = 5000, min = 1, max = 10000,
    callback = function(value)
        espLib.options.maxDistance = value
    end
})

CLog(nil, "Loading %30")

--// Settings
UISection:addKeybind({title = "UI Keybind", key = Enum.KeyCode.LeftAlt,
    callback = function()
        libraryUI:toggle()
    end,
})

--// Players
local playerlist = {}
local selectedPlayer = nil

local function getPlayerFromName(name)
    for i,v in pairs(Players:GetPlayers()) do
        if v.Name == tostring(name) then
            return v;
        end
    end
end
for i,v in pairs(game.Players:GetPlayers()) do 
    table.insert(playerlist, v.Name)    
end

CLog(nil, "Loading %40")
 
local PlayersDropdown = target_section:addDropdown({
    title = "Target Player",
    list = playerlist,
    callback = function(text)
        selectedPlayer = getPlayerFromName(text); 
    end
})

CLog(nil, "Loading %45")

Players.PlayerAdded:Connect(function(player)
    local name = player.Name
    table.insert(playerlist, name)
    PlayersDropdown:Update(playerlist)
end)
Players.PlayerRemoving:Connect(function(player)
    local name = player.Name
    for i,v in pairs(playerlist)do
        if v == name then  
            table.remove(playerlist,i)
        end
    end
    PlayersDropdown:Update(playerlist)
end)

local isSpectating = false;
target_section:addToggle({title = "Spectate Player",
    callback = function(bool)
        isSpectating = bool
        if isSpectating and selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Humanoid") then
            repeat                
                CCamera.CameraSubject = selectedPlayer.Character.Humanoid
                LocalPlayer.CameraMode = Enum.CameraMode.Classic             
                task.wait(0.4)
            until not isSpectating      
        elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then       
            CCamera.CameraSubject = LocalPlayer.Character.Humanoid
            LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        end  
    end
})

CLog(nil, "Loading %50")

--// Simple spectate bypass
pcall(function()
    if not _G.spectateBypassEnabled then
        local game_mt = getrawmetatable(game)
        setreadonly(game_mt, false)
        local namecall = game_mt.__namecall

        game_mt.__namecall = function(self,...)
            local args = {...}
            local method = getnamecallmethod() 

            if method == "Kick" then                
                return nil                    
            end

            if tostring(method) == "FireServer" and typeof(args[1]) == "number" then
                if string.find(tostring(args[2]), ".Humanoid after") then                    
                    return nil
                end
            end       

            return namecall(self,...)            
        end    
    end

    wait(.5)
    setreadonly(game_mt, true)
    _G.spectateBypassEnabled = true
end) 

game:GetService("RunService").RenderStepped:Connect(function()
    if CameraOveride then
        CCamera.FieldOfView = CameraFov
    end
    if VisualSettings.World.Animals.Enabled then
        for _,v in pairs(AnimalFolder:GetChildren()) do            
            local part = v.Torso
            local dist = math.round((v.Torso.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
            local _,b = game.Workspace.CurrentCamera:WorldToViewportPoint(part.Position)
 
            if b and VisualSettings.World.Animals.Enabled then
                local a = Drawing.new("Text")
                a.Text = v.Name.." | "..dist
                a.Size = math.clamp( 16 - (part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,16,83)
                a.Center = true
                a.Outline = true
                a.OutlineColor=Color3.new()
                a.Font=Drawing.Fonts.UI
                a.Visible=true
                a.Transparency=1
                a.Color = VisualSettings.World.Animals.Color
                a.Position=Vector2.new(
                    game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.UpVector*(3+(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).X,
                    game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.UpVector*(3+(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).Y)
                coroutine.wrap(function()
                    game.RunService.RenderStepped:Wait()
                    a:Remove()
                end)()
            end
        end
    end
end)

CLog(nil, "Loading %90")

task.wait(0.5)
 
local function GetPlayerFromCharacter(Character)
    if Character.Name then
        for i,v in next, Players:GetChildren() do
            if v.Name == Character.Name then
                return v
            end
        end
    end
end
 
local playerList = {}
for i,v in ipairs(workspace.Characters:GetChildren()) do 
    playerList[GetPlayerFromCharacter(v).Name] = v    
end
workspace.Characters.ChildAdded:connect(function(v)
    playerList[v.Name] = v
end)
workspace.Characters.ChildRemoved:connect(function(v)
    playerList[GetPlayerFromCharacter(v).Name] = nil
end)
Players.PlayerRemoving:connect(function(v)
    playerList[v.Name] = nil 
end)
function espLib.GetCharacter(player) -- Change how you get characters for your game
    local character = playerList[player.Name]
    return character, character and game.FindFirstChild(character, "HumanoidRootPart") -- Return the character and that the character has it's primary part
end

espLib:Init()

CLog(nil, "Loading %100")
