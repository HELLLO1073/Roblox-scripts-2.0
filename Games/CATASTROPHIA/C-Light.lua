--// Catastrophia Lite, Built for these free exploit users...

local logger = true
rconsoleclear()

--// Console logger
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

--// Sirius esp library
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


--// Pages
local esp_page = libraryUI:addPage({title = "Visuals", icon = 5012544693})
local ui_page = libraryUI:addPage({title = "Settings", icon = 6022860343})

--// Sections
--// Visuals
local EspSection = esp_page:addSection({title = "Player Visuals"})
local EspSectionSettings = esp_page:addSection({title = "Visual settings"})

--// Settings
local UISection = ui_page:addSection({title = "UI"})

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

EspSectionSettings:addColorPicker({title = "Main Color", default = Color3.fromRGB(244, 244, 0),
    callback = function(color3)
        espLib.options.nameColor = color3 
        espLib.options.boxesColor = color3
        espLib.options.outOfViewArrowsColor = color3 
        espLib.options.tracerColor = color3        
    end
})
EspSectionSettings:addSlider({title = "Max Distance", default = 0, min = 1, max = 10000,
    callback = function(value)
        espLib.options.maxDistance = value
    end
})

UISection:addKeybind({title = "UI Keybind", key = Enum.KeyCode.LeftAlt,
    callback = function()
        libraryUI:toggle()
    end,
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
function espLib.GetHealth(player, character) -- Change how you get health 
    local health = game.FindFirstChild(character, "Health") -- Make sure they have a humanoid / health container 
    if (health) then 
        return health.Value,health.MaxHealth.Value -- Return their current health and their max health 
    end
    return 100, 100 -- If no humanoid just return 100,100 so no error 
end

espLib:Init()
CLog(nil, "Loading %100")

--// Created by H4#0321