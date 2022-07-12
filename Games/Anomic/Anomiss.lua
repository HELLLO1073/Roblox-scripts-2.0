--// Anomic Original | Anomiss beta | Open source
--// Credits: ESP Library : Sirius esp lib, Script Creator : H4#0321
--// If you want to use any scripts from here please dm me, thanks

--// Variables
print("Loading | %0")
local CharacterParts = {"Head", "HumanoidRootPart", "LeftHand", "RightHand", "LeftFoot", "RightFoot"}
local MessageCard = game:GetService("ReplicatedStorage"):WaitForChild("UserInterface").Card
local CSEvents = game:GetService("ReplicatedStorage"):WaitForChild("_CS.Events")
local Entities = game:GetService("Workspace"):WaitForChild("Entities")
local UserInput = game:GetService("UserInputService")
local Players = game:GetService("Players")
print("Loading | %5")
local LocalPlayer = Players.LocalPlayer
local CCamera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()

print("Loading | %10")

espLib.whitelist = {} 
espLib.blacklist = {}
espLib.options = {
    enabled = false,
    scaleFactorX = 4,
    scaleFactorY = 5,
    font = 2,
    fontSize = 13,
    limitDistance = true,
    maxDistance = 500,
    visibleOnly = false,
    teamCheck = false,
    teamColor = false,
    fillColor = nil,
    whitelistColor = Color3.new(1, 0, 0),
    outOfViewArrows = false,
    outOfViewArrowsFilled = false,
    outOfViewArrowsSize = 15,
    outOfViewArrowsRadius = 300,
    outOfViewArrowsColor = Color3.new(1, 1, 1),
    outOfViewArrowsTransparency = 0.5,
    outOfViewArrowsOutline = false,
    outOfViewArrowsOutlineFilled = false,
    outOfViewArrowsOutlineColor = Color3.new(1, 1, 1),
    outOfViewArrowsOutlineTransparency = 0,
    names = false,
    nameTransparency = 1,
    nameColor = Color3.new(1, 1, 1),
    boxes = false,
    boxesTransparency = 1,
    boxesColor = Color3.new(1, 1, 1),
    boxFill = false,
    boxFillTransparency = 0.5,
    boxFillColor = Color3.new(1, 1, 1),
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
    tracerColor = Color3.new(1, 1, 1),
    tracerOrigin = "Bottom", -- Available [Mouse, Top, Bottom]
    chams = false,
    chamsColor = Color3.new(1, 0, 0),
    chamsTransparency = 0.5,
}

local ChatSettings = require(game.Chat.ClientChatModules.ChatSettings)
local ChatFrame = LocalPlayer.PlayerGui.Chat.Frame
ChatSettings.WindowResizable = true
ChatSettings.WindowDraggable = true
ChatFrame.ChatChannelParentFrame.Visible = true
ChatFrame.ChatBarParentFrame.Position = ChatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),ChatFrame.ChatChannelParentFrame.Size.Y)

local BeamPart = Instance.new("Part", workspace)    
BeamPart.Name = "BeamPart"
BeamPart.Transparency = 1

print("Loading | %15")

--// Settings
local Anomiss = {
    Aimbot = {
        Enabled = false,
        HitPart = "Head",
        AimSpeed = 0.32,
        FOV = {Enabled = false, NumSides = 120, Radius = 150, Color = Color3.fromRGB(200, 200, 200), Position = "Center"}, --// Center, Mouse
        Silent_aim = {
            Enabled = false, 
            Origin = "Called",
            PrintCallingScript = false,
            CallingScript = "",
            Beams = false,
            BeamProperties = {Color = Color3.fromRGB(131, 0, 253)},
            Origin_Ignore = "",
            AutoFire = false,
            InstantKill = false,
            HitMuliplier = 0
        },
        Checks = {
           Visible = false, 
           Forcefield = false 
        }
    },
    Visuals = {
        MaxDistance = 500,
        Enables = {
            TargetHighlight = false;
            Aimbient = false;
            OutDoorAimbient = false;
            Terrain = false;
            TerrainGround = false;
            Shadows = game.Lighting.GlobalShadows;
            HiddenGrass = false;
            Chams = {Enabled = false, Color = Color3.fromRGB(255,0,0), Rainbow = false, Transparency = 0.5, OutlineTransparency = 0}
        };
        Colors = {
            Aimbient =  game.Lighting.Ambient;
            OutDoorAimbient = game.Lighting.OutdoorAmbient;    
            TerrainGrassMaterial = Enum.Material.Grass,
            TerrainGrassColor = workspace.Terrain:GetMaterialColor(Enum.Material.Grass),
            TerrainGroundMaterial = Enum.Material.Ground,
            TerrainGroundColor = workspace.Terrain:GetMaterialColor(Enum.Material.Ground), 
        },
        Other = {
            Thirdperson = false,
            ThirdpersonX = 0,
            ThirdpersonY = 0,
            ThirdpersonZ = 0,
    
            AA_Enabled = false, 
            AA_Mode = "Spin", --// Spin, Custom
            SpinSpeed = 5,
        }
    },
    Movement = {
        Overide = false,
        jumppower = 30, 
        Walkspeed = 13,
        RunSpeed = 23,
        Running = false,
        Flying = false,
        InfiniteJump = false,
        Noclip = false 
    },
    GunModifiers = {
        FlightShot = false,

    }
}

local ValidItemList = {
	semis = {"Combat Pistol", "Classic Pistol", "Snubnose", "Revolver", "Pistol .50", "Heavy Pistol", "Handgun", "Autorevolver"},
	autos = {"Service Rifle", "PDW .45", "Bullpup Rifle", "Skorpion", "Tactical SMG", "Micro SMG", "Riot PDW", "Carbine", "Battle Rifle MKII", "Kalashnikov", "SMG", "Bullpup SMG", "Battle Rifle", "AR"},
	shotguns = {"Riot Shotgun", "Bullpup Shotgun", "Sawed Off", "Shotgun"},
	Tools = {"Sprayer", "Stamina Booster", "Lockpick", "Health Booster", "Medi Kit", "Drill", "Repair Kit"},
	armors = {"Heavy Vest", "Balaclava", "Battle Helmet", "Riot Helmet", "Light Vest"},
	Ammo = {"9mm", "5.7x28", "12 Gauge", ".50", ".45 ACP", "5.56"},
	cars = {"Supercar", "Sport Hatch", "Hypercar", "Muscle Car", "SUV (Dune)", "SUV", "Luxury SUV", "Humvee", "Cab", "Van", "Convertible", "Hatchback", "RV", "Pickup", "Coupe", "Lowrider", "Sedan (Facelift)", "Caracal Van", "Sedan", "Sports Car", "Limousine", "Minivan", "Bus", "Luxury Car", "Ambulance"}
}
    
local Settings = {
    EndColor = Color3.new(1, 1, 1),
    StartWidth = 0.1,
    EndWidth = 0.05,    
    Time = 1
}

--// Other Variables
local fovOveride = false
local fovValue = 120
local Fov_Circle = nil
local Aiming = false
local ChamCache = {}
local FLYING = false
local FlightSpeed = 2
local ChamColorPicker

print("Loading | %20")

--// Functions 
local function PlayerFromName(name)                     for i,v in pairs(Players:GetPlayers()) do if v.Name == tostring(name) then return v; end end end
local function CheckVisible(Origin, Character, Part)    if Anomiss.Aimbot.Checks.Visible then local MyCharacter = LocalPlayer.Character if MyCharacter ~= nil and Character ~= nil then local PartFound = workspace.FindPartOnRayWithIgnoreList(workspace, Ray.new(Origin, Part.Position - Origin), {MyCharacter, CCamera, Character}, false, true) return PartFound == nil end else return true end end
local function FireGun(FireKey)
    --print("Fired gun!")
    if FireKey == "Mouse1" then
        mouse1press()
        task.wait(0.5)
        mouse1release()
    elseif FireKey == "Mouse2" then
        mouse2press()
        task.wait(0.5)
        mouse2release()
    end
end
local function ClosestTarget(target_part) 
    local Closest = nil; 
    local Distance = math.huge; 
 
    if Anomiss.Aimbot.HitPart == "Random" then
        target_part = CharacterParts[math.random(1, #CharacterParts)]
    elseif Anomiss.Aimbot.HitPart == "Anti-God" then
        target_part = "LeftHand" or "RightHand"
    end

    for i,v in next, game.GetChildren(Players) do  
        if v ~= LocalPlayer and v.Character and game.FindFirstChild(v.Character, target_part) and game.FindFirstChild(v.Character, "Humanoid") then 
            if Anomiss.Aimbot.Enabled or Anomiss.Aimbot.Silent_aim.Enabled then
                local CenterOfScreen = Vector2.new(CCamera.ViewportSize.X / 2, CCamera.ViewportSize.Y / 2)
                local Character = v.Character 
                local Humanoid = game.FindFirstChild(Character, "Humanoid") 
                local targetPart = game.FindFirstChild(Character, target_part) 
                local vector3, onscreen = CCamera.WorldToScreenPoint(CCamera, targetPart.Position)
                local screenVec = Vector2.new(vector3.X, vector3.Y)

                local distanceFromCenter = nil

                if Anomiss.Aimbot.FOV.Position == "Center" then
                    distanceFromCenter = (CenterOfScreen-screenVec).Magnitude 
                elseif Anomiss.Aimbot.FOV.Position == "Mouse" then
                    distanceFromCenter = (Vector2.new(Mouse.X, Mouse.Y + 36) - screenVec).Magnitude
                end

                if Anomiss.Aimbot.Checks.Forcefield and game.FindFirstChild(Character, "ForceField") then 
                    continue 
                end 

                if onscreen and Humanoid.Health > 0.0 and CheckVisible(CCamera.CFrame.Position, Character, targetPart) then 
                    if distanceFromCenter <= Distance and distanceFromCenter <= Anomiss.Aimbot.FOV.Radius then 
                        Closest = targetPart Distance = distanceFromCenter 
                    end 
                end 
            else
                return nil
            end
        end 
    end 

    return Closest; 
end 
local function ChamPlayer(player)
    local Highlight = Instance.new("Highlight")
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    Highlight.FillColor = Anomiss.Visuals.Enables.Chams.Color
    Highlight.FillTransparency = Anomiss.Visuals.Enables.Chams.Transparency

    Highlight.OutlineColor = Color3.fromRGB(0,0,0)
    Highlight.OutlineTransparency = Anomiss.Visuals.Enables.Chams.OutlineTransparency
    
    Highlight.Adornee = player.Character
    Highlight.Parent = player.Character
    
    player.CharacterAdded:Connect(function()
        Highlight.Adornee = player.Character
        Highlight.Parent = player.Character
    end)
    player.CharacterRemoving:Connect(function()
        Highlight.Adornee = nil
        Highlight.Parent = nil
    end)

    ChamCache[player] = Highlight
end
local function ClearChamCache()
    for i, h in next, ChamCache do 
        if h then
            h:Destroy()
            if ChamCache[i] then
                ChamCache[i] = nil
            end
        end
    end
    table.clear(ChamCache)
end
local function UpdateChams()
    ClearChamCache()
    if Anomiss.Visuals.Enables.Chams.Enabled then
        for i,v in next, Players:GetChildren() do
            if v ~= LocalPlayer and v.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("HumanoidRootPart") then         
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position-v.Character.HumanoidRootPart.Position).Magnitude   
                if distance <= Anomiss.Visuals.MaxDistance then                  
                    ChamPlayer(v)                
                end
            end
        end
    end
end
local function StartFly()  
    if game.Workspace:FindFirstChild('ABC') ~= nil then game.Workspace:FindFirstChild('ABC'):Destroy() end
    local part = Instance.new('Part')
    part.Parent = workspace
    part.Name = "ABC"
    part.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
    part.Transparency = 1
    part.CanCollide = false
    part.Size = LocalPlayer.Character.HumanoidRootPart.Size
    local weld = Instance.new('WeldConstraint')
    weld.Parent = LocalPlayer.Character
    weld.Part0 = LocalPlayer.Character.HumanoidRootPart
    weld.Part1 = workspace.ABC

	repeat wait() until LocalPlayer and LocalPlayer.Character and workspace.ABC and LocalPlayer.Character:FindFirstChild('Humanoid')
	repeat wait() until Mouse
    
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
        local yes = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = workspace.ABC
		BV.Parent = workspace.ABC
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = workspace.CurrentCamera.CoordinateFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

		spawn(function()
			repeat wait()
				if not yes and LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					LocalPlayer.Character.Humanoid.PlatformStand = false
				end
			 	if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame --* CFrame.Angles(0, 0, math.rad(180))
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				LocalPlayer.Character.Humanoid.PlatformStand = false
				workspace:FindFirstChild('ABC'):Destroy()
				LocalPlayer.Character.WeldConstraint:Destroy()
			end
		end)

	end

	flyKeyDown = Mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and FlightSpeed or FlightSpeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and FlightSpeed or FlightSpeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and FlightSpeed or FlightSpeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and flySpeed or FlightSpeed)
		elseif KEY:lower() == 'e' then
			CONTROL.Q = (vfly and FlightSpeed or FlightSpeed) * 2
		elseif KEY:lower() == 'q' then
			CONTROL.E = -(vfly and FlightSpeed or FlightSpeed) * 2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
    
	flyKeyUp = Mouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)

	FLY()   
end
local function StopFly()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end
local function StopConnections()
    local hum = LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    repeat wait() until hum.Anchored == false    
    for i, v in next, getconnections(LocalPlayer.Character.DescendantAdded) do
        v:Disable()
    end    
end 
local function CustomNotify(title, text, backgroundColor, ismenu)
	local Card = MessageCard:Clone()

	if ismenu then
		Card.Parent = LocalPlayer.PlayerGui:WaitForChild("MainMenu").Messages
	else
		Card.Parent = LocalPlayer.PlayerGui:WaitForChild("MainUIHolder").Messages;
	end

	if title == "" then
		Card.TextLabel.Text = title..": "..text
	else
		Card.TextLabel.Text = text
	end	

	Card.LocalScript.Disabled = false
	Card.BackgroundColor3 = backgroundColor
	LocalPlayer.PlayerGui.Notify:Play()
end

CustomNotify("[Anomiss]", "Loading GUI", Color3.fromRGB(46, 46, 46), false)
local locationNames = { "Unkown1","Safe 1","Safe 2","Safe 3","Airfield","Lobby room","Police","Hospital","Bank","Okby Steppe","Eastdike","Logs","Outlook","Arway","Pahrump","ATM 1","Tow yard","Gas station Eastdike"}
local locationPositions = {
    ["Unkown1"] = CFrame.new(34.3238869, -34.2613297, 62.5588074),
    ["Safe 1"] = CFrame.new(2945.68628, -137.835602, -632.04187),
    ["Safe 2"] = CFrame.new(1338.85901, 8.42657185, 697.082153),
    ["Safe 3"] = CFrame.new(4300.32715, -59.3234367, -1883.43359),
    ["Airfield"] = CFrame.new(1887.15381, -21.3613129, -35.1375847),    
    ["Lobby room"] = CFrame.new(447.605194, -8.47341442, -1337.55042),
    ["Police"] = CFrame.new(1613.58093, -62.9234428, -1276.74622),
    ["Hospital"] = CFrame.new(1620.96814, -65.4234467, -1398.38928),    
    ["Bank"] = CFrame.new(2046.23425, -67.4034424, -1436.45581),
    ["Okby Steppe"] = CFrame.new(3821.61816, -2.04217649, -3285.22583),
    ["Eastdike"] = CFrame.new(2718.69604, -3.83149028, -3638.85547),
    ["Logs"] = CFrame.new(1275.26843, -18.4427071, -2766.00391),    
    ["Outlook"] = CFrame.new(1645.70691, -27.104681, -1872.46082),
    ["Arway"] = CFrame.new(1645.70691, -27.104681, -1872.46082),    
    ["Pahrump"] = CFrame.new(-101.309013, 9.67657185, 23.9057484),
    ["ATM 1"] = CFrame.new(754.357971, -19.4670086, -242.627563),
    ["Tow yard"] = CFrame.new(364.241394, -3.38592649, -1720),
    ["Gas station Eastdike"] = CFrame.new(364.241394, -3.38592649, -1720)
}

local function TeleportToLocation(location, bool)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if bool then
            LocalPlayer.Character.HumanoidRootPart.CFrame = locationPositions[location]
        else
            LocalPlayer.Character.HumanoidRootPart.CFrame = location
        end
    end
end

local function ValidToolModel(toolModel)
    if toolModel:FindFirstChild("PlayerWhoDropped") then
        return false
    end
    if toolModel:FindFirstChild("Handle") then
        local ToolBG = toolModel.Handle:FindFirstChild("ToolBG")
        if ToolBG and ToolBG:FindFirstChild("ToolName") then
            return true
        else
            return false
        end
    end

    return false
end

local function GrabTool(toolModel)
    if toolModel == nil then
        CustomNotify("[Anomiss]", "Tool sniper error (Tool is nil)", Color3.fromRGB(200, 0, 0), false)
        return
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local OldCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
        if toolModel:FindFirstChild("Handle") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = toolModel.Handle.CFrame
            task.wait(.2)
            CSEvents.Dropper:FireServer(toolModel, "PickUp")
            task.wait(.2)
            LocalPlayer.Character.HumanoidRootPart.CFrame = toolModel.Handle.CFrame
            CSEvents.Dropper:FireServer(toolModel, "PickUp")
            wait(.6)
            LocalPlayer.Character.HumanoidRootPart.CFrame = OldCFrame
        end
    end
end

local function GrabToolFromName(name)
    local count = 0
    local tool = nil

    for i,v in next, Entities:GetChildren() do
        if count >= 1 then
            break
        end

        if v.Name == "ToolModel" and ValidToolModel(v) and v:FindFirstChild("Handle") then
            local toolName = v.Handle.ToolBG.ToolName.Value
            if toolName == name then
                count += 1
                tool = v
            end
        end

    end

    GrabTool(tool)
end

local function PurchaseItems(name, quantity, isCrate)
    if not isCrate then
        for i = 1, quantity, 1 do 
            task.wait(.2)   
            CSEvents.PurchaseTeamItem:FireServer(name, "Single", nil)
        end
    else 
        CSEvents.PurchaseTeamItem:FireServer(name,"Crate",nil)
		CSEvents.DeliveryFunction:FireServer("PickUpDelivery",name)
    end
end

local noclipConnection = nil
local function ToggleNoclip()

    local function ClipLoop()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            for i,v in next, LocalPlayer.Character:GetDescendants() do
                if v:IsA("BasePart") and v.CanCollide == true then
                    if Anomiss.Movement.Noclip then
                        v.CanCollide = false
                    else
                        v.CanCollide = true
                    end
                end
            end
        end
    end

    if noclipConnection == nil then
        Settings.nocliploop = game:GetService("RunService").Stepped:Connect(ClipLoop)
    end

end

local function GetCurrentGun()
    if LocalPlayer.Character then
		for i,v in next, LocalPlayer.Character:GetChildren() do
			if v:IsA("Tool") and v:FindFirstChild("MainGunScript") then
				return v
			end
		end
	end
end

print("Loading | %40")
print("Loading | %45 Loading UI Library")
-- Initialize Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Anomiss01/RS_wadwd/main/lib/library1"))({cheatname = 'Anomiss 1.0.2', gamename = 'Anomic Original [BETA]'}); 
library:init();

-- Create New Window
local window = library.NewWindow({title = library.cheatname..' | '..library.gamename, size = UDim2.new(0,525,0,650)})
print("Loading | %47")

-- Hardcoded Settings Tab [Configs, Themes, Etc]
local tab_settings = library:CreateSettingsTab(window)
print("Loading | %48")

-- Create New Tab's
local A_Tab = window:AddTab('Aimbot-Combat')
local V_Tab = window:AddTab('Visuals')
local M_Tab = window:AddTab('Miscellaneous')
local L_Tab = window:AddTab('LocalPlayer')

-- Create Aimbot Tab
local Aimbot = A_Tab:AddSection('Aimlock', 1) 
local Aimbot_Settings = A_Tab:AddSection('Settings', 1) 
local Silent_Aimbot = A_Tab:AddSection('Silent Aimbot', 2) 
local Fov_Section = A_Tab:AddSection('FOV', 1) 
local Gun_Section = A_Tab:AddSection('Gun Mods', 1) 

-- Create Local Tab
local Local_Movement = L_Tab:AddSection('Movement', 1) 
local Local_Misc = L_Tab:AddSection('Miscellaneous', 2) 
local Local_Char = L_Tab:AddSection('Character', 2) 

-- Create Visauls Tab
local PVisauls = V_Tab:AddSection('Player Visuals', 1) 
local VSettings = V_Tab:AddSection('Visual Settings', 1) 
local VPlayers = V_Tab:AddSection('Players', 2) 
local VWSettings = V_Tab:AddSection('World Visuals', 2) 

-- Create Miscellaneous tab
local ItemSectionMisc = M_Tab:AddSection('Tool sniper', 1) 
local LocalTeleport = M_Tab:AddSection('Teleportation', 1) 
local TeamSectionMisc = M_Tab:AddSection('Teams', 2) 

print("Loading | %60 | Main tabs")

do --// Aimbot main 
    Aimbot:AddToggle({text = 'Enabled', flag = '', tooltip = 'Enables default aimbot.', callback = function(bool)
        Anomiss.Aimbot.Enabled = bool
    end})
    Aimbot:AddSlider({text = 'Lock Speed', flag = '', tooltip = 'The speed of which the aimbot snaps.', min = 0, max = 1, increment = 0.01, callback = function(number)
        Anomiss.Aimbot.AimSpeed = number
    end})       

    local silentToggle = Silent_Aimbot:AddToggle({text = 'Silent Aim', flag = '', tooltip = 'Enables silent aim.', callback = function(bool)
        Anomiss.Aimbot.Silent_aim.Enabled = bool
    end})
    silentToggle:AddBind({mode = 'hold', default = Enum.KeyCode.F, callback = function(bool)
        Anomiss.Aimbot.Silent_aim.Enabled = bool
    end})
    Silent_Aimbot:AddToggle({text = 'Auto Fire', flag = '', tooltip = 'Enables silent aim auto fire.', callback = function(bool)
        Anomiss.Aimbot.Silent_aim.AutoFire = bool
    end})    
    Silent_Aimbot:AddList({text = 'Bullet Origin', flag = '', values = {'Called', 'MyHead', 'Camera', 'Teleport'}, callback = function(option)
        Anomiss.Aimbot.Silent_aim.Origin = option
    end})  

    local beamToggle = Silent_Aimbot:AddToggle({text = 'Raycast tracers', flag = '', tooltip = 'Enables silent aim bullet beams.', callback = function(bool)
        Anomiss.Aimbot.Silent_aim.Beams = bool
    end}) 
    beamToggle:AddColor({flag = '', default = Anomiss.Aimbot.Silent_aim.BeamProperties.Color, callback = function(c)
        Anomiss.Aimbot.Silent_aim.BeamProperties.Color = c
    end});
    Silent_Aimbot:AddToggle({text = 'Print Calling script', flag = '', tooltip = 'Prints the calling script of ray.', callback = function(bool)
        Anomiss.Aimbot.Silent_aim.PrintCallingScript = bool
    end})
    Silent_Aimbot:AddBox({text = 'Calling script', flag = 'aimbot_cscript', callback = function(input)
        Anomiss.Aimbot.Silent_aim.CallingScript = input        
    end})

    Aimbot_Settings:AddList({text = 'Aimbot Part', flag = 'dropdown', tooltip = 'The part of which aimbot targets', values = {'Head', 'Torso', 'Random', 'Anti-God'}, callback = function(value)
        Anomiss.Aimbot.HitPart = value
    end})    
    Aimbot_Settings:AddToggle({text = 'Visible Check', flag = '23d', tooltip = 'Checks if player is visible.', callback = function(bool)
        Anomiss.Aimbot.Checks.Visible = bool
    end})
    Aimbot_Settings:AddToggle({text = 'Forcefield Check', flag = 'awd', tooltip = 'Checks if player has a forcefield.', callback = function(bool)
        Anomiss.Aimbot.Checks.Forcefield = bool
    end})    

    local fovCircle = Fov_Section:AddToggle({text = 'FOV Circle', flag = 'x', tooltip = 'Enables fov circle for aimbot.', callback = function(bool)
        Anomiss.Aimbot.FOV.Enabled = bool
        if Anomiss.Aimbot.FOV.Enabled then
            Fov_Circle = Drawing.new("Circle")
            Fov_Circle.Visible = true
            Fov_Circle.Color = Color3.fromRGB(0,0,200)
            Fov_Circle.Radius = Anomiss.Aimbot.FOV.Radius
            Fov_Circle.Thickness = 1
            Fov_Circle.Filled = false
            Fov_Circle.NumSides = 125
        elseif not Anomiss.Aimbot.FOV.Enabled and Fov_Circle ~= nil then
            Fov_Circle:Remove()
        end
    end}) 
    fovCircle:AddColor({flag = '', default = Color3.fromRGB(0,0,200), callback = function(c)
        Anomiss.Aimbot.FOV.Color = c
    end});
    Fov_Section:AddSlider({text = 'Radius', flag = 'Fov2x', tooltip = 'The aimbot fov radius.', min = 1, default = 120, max = 1000, increment = 1, callback = function(number)
        Anomiss.Aimbot.FOV.Radius = number
    end})
    Fov_Section:AddSlider({text = 'Sides', flag = 'Fov2x1', min = 3, default = 120, max = 150, increment = 1, callback = function(number)
        Anomiss.Aimbot.FOV.NumSides = number
    end})
    Fov_Section:AddList({text = 'Position', flag = 'AimbotFovPosition', values = {"Center", "Mouse"}, callback = function(option)
        Anomiss.Aimbot.FOV.Position = option
    end})

    Gun_Section:AddToggle({text = 'Fire while flying', flag = 'AirShotToggle', tooltip = 'Shoot while flying.', callback = function(bool)
        Anomiss.GunModifiers.FlightShot = bool
    end})  
end

do --// LocalPlayer
    Local_Movement:AddToggle({text = 'Infinite Jump', flag = '', tooltip = 'Enables Infinite jump.', callback = function(bool)
        Anomiss.Movement.InfiniteJump = bool
    end})
    Local_Movement:AddToggle({text = 'Max slope angle', flag = '', tooltip = 'Helps you climb terrain and certain objects.', callback = function(bool)
        if bool then
            LocalPlayer.Character.Humanoid.MaxSlopeAngle = 90
        elseif LocalPlayer.Character then
            LocalPlayer.Character.Humanoid.MaxSlopeAngle = 45
        end
    end})
    
    local FlightToggle = Local_Movement:AddToggle({text = 'Flight', flag = '', tooltip = '', callback = function(bool)
        Anomiss.Movement.Flying = bool
        if Anomiss.Movement.Flying then
            StartFly()
        else
            StopFly()
        end
    end})    
    FlightToggle:AddBind({mode = 'toggle', callback = function(bool)
        Anomiss.Movement.Flying = bool
        if Anomiss.Movement.Flying then
            StartFly()
        else
            StopFly()
        end
    end})

    local NoclipToggle = Local_Movement:AddToggle({text = 'Noclip', flag = '', tooltip = '', callback = function(bool)
        Anomiss.Movement.Noclip = bool
        ToggleNoclip()
    end})    
    NoclipToggle:AddBind({mode = 'toggle', callback = function(bool)
        Anomiss.Movement.Noclip = bool
        ToggleNoclip()
    end})

    Local_Movement:AddSlider({text = 'Flight Speed', flag = 'FlightSpeed', tooltip = 'The speed at which flight travels.', default = 2, min = 1, max = 10, increment = 1, callback = function(number)
        FlightSpeed = number
    end})

    Local_Movement:AddSeparator({text = "Movement Bypass"})
    Local_Movement:AddToggle({text = 'Overide Movement', flag = '', callback = function(bool)
        Anomiss.Movement.Overide = bool
    end})
    Local_Movement:AddSlider({text = 'Walkspeed', flag = '', tooltip = 'Your walk speed.', default = 13, min = 1, max = 250, increment = 1, callback = function(number)
        Anomiss.Movement.Walkspeed = number
    end})
    Local_Movement:AddSlider({text = 'Run Speed', flag = '', tooltip = 'Your running speed.', default = 23, min = 1, max = 250, increment = 1, callback = function(number)
        Anomiss.Movement.RunSpeed = number
    end})
    Local_Movement:AddSlider({text = 'Jump Power', flag = '', tooltip = 'Your jump height.', default = 30, min = 1, max = 250, increment = 1, callback = function(number)
        Anomiss.Movement.jumppower = number
    end})
    
    Local_Misc:AddToggle({text = 'Overide FOV', flag = '', tooltip = 'Overides fov incase game changes it.', callback = function(bool)
        fovOveride = bool
    end})
    Local_Misc:AddSlider({text = 'Field of view', flag = '', tooltip = 'Camera field of view.', min = 0.5, max = 120, increment = 1, callback = function(number)
        fovValue = number
        CCamera.FieldOfView = number
    end}) 

    Local_Misc:AddSeparator({text = "Camera Offsetting"})
    Local_Misc:AddToggle({text = 'Camera Offset', flag = '', tooltip = 'Overides camera to make thirdperson.', callback = function(bool)
        Anomiss.Visuals.Other.Thirdperson = bool
    end})
    Local_Misc:AddSlider({text = 'Cam offset X', flag = '', tooltip = 'Camera offset.', min = -30, max = 30, increment = 0.5, callback = function(number)
        Anomiss.Visuals.Other.ThirdpersonX = number
    end})
    Local_Misc:AddSlider({text = 'Cam offset Y', flag = '', tooltip = 'Camera offset.', min = -30, max = 30, increment = 0.5, callback = function(number)
        Anomiss.Visuals.Other.ThirdpersonY = number
    end})
    Local_Misc:AddSlider({text = 'Cam offset Z', flag = '', tooltip = 'Camera offset.', min = -30, max = 30, increment = 0.5, callback = function(number)
        Anomiss.Visuals.Other.ThirdpersonZ = number
    end})

    Local_Char:AddSeparator({text = "Appearence"})
    Local_Char:AddToggle({text = 'Outfit editor', flag = '', tooltip = '', callback = function(bool)
        LocalPlayer.PlayerGui.AvatarEditor.Enabled = bool
        LocalPlayer.PlayerGui.AvatarEditor.WearButton.Visible = not bool
    end})
    Local_Char:AddList({text = 'Outfit Presets', flag = '', values = {"Black", "Glitch", "Black Super", "Jedi", "Black & White", "Hacker"}, callback = function(t)
        if t == "Black" then
            CSEvents.EquipAvatarItem:FireServer("CustomCloth",6523367474)
            CSEvents.EquipAvatarItem:FireServer("CustomCloth",745499244)
            CSEvents.EquipAvatarItem:FireServer("Color",Color3.fromRGB(61, 48, 40),"HairColor")   
            CSEvents.EquipAvatarItem:FireServer("Color",Color3.fromRGB(255, 255, 255),"SkinColor")  --// else if..
            else if t == "Glitch" then
                    CSEvents.EquipAvatarItem:FireServer("CustomCloth",6296322488)
                    CSEvents.EquipAvatarItem:FireServer("CustomCloth",6296389518)
                else if t == "Hacker" then
                    CSEvents.EquipAvatarItem:FireServer("CustomCloth",5594922955)
                    CSEvents.EquipAvatarItem:FireServer("CustomCloth",6967030358)
                    else if t == "Black & White"  then
                        CSEvents.EquipAvatarItem:FireServer("CustomCloth",4797295258)
                        CSEvents.EquipAvatarItem:FireServer("CustomCloth",4977671127)
                        CSEvents.EquipAvatarItem:FireServer("Color",Color3.fromRGB(61, 48, 40),"HairColor")   
                                CSEvents.EquipAvatarItem:FireServer("Color",Color3.fromRGB(234, 184, 146),"SkinColor")
                        else if t == "Black Super"  then
                            CSEvents.EquipAvatarItem:FireServer("CustomCloth",5424698549)
                            CSEvents.EquipAvatarItem:FireServer("CustomCloth",6585862428)                                     
                            else if t == "Jedi"  then
                                CSEvents.EquipAvatarItem:FireServer("CustomCloth",5234814023)
                                CSEvents.EquipAvatarItem:FireServer("CustomCloth",5234818204)     
                                CSEvents.EquipAvatarItem:FireServer("Color",Color3.fromRGB(61, 48, 40),"HairColor")   
                                CSEvents.EquipAvatarItem:FireServer("Color",Color3.fromRGB(234, 184, 146),"SkinColor")              
                            end                                    
                        end
                    end
                end
            end
        end
    end})
    Local_Char:AddColor({text = "Hair color", flag = '', default = Color3.fromRGB(255, 255, 255), callback = function(c)
        CSEvents.EquipAvatarItem:FireServer("Color", c, "HairColor")
    end})
    Local_Char:AddColor({text = "Skin color", flag = '', default = Color3.fromRGB(255, 255, 255), callback = function(c)
        CSEvents.EquipAvatarItem:FireServer("Color", c, "SkinColor")
    end})
    Local_Char:AddButton({text = 'Untradeable', callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.LocalPlayerBG:Destroy()
        end
    end})
    Local_Char:AddButton({text = 'Force respawn', callback = function()
        CSEvents.PayLoad:FireServer()
    end})


    Local_Char:AddSeparator({text = "Antiaim"})
    Local_Char:AddToggle({text = 'Anti-Aim', flag = '', callback = function(bool)
        Anomiss.Visuals.Other.AA_Enabled = bool
        if not bool and LocalPlayer.Character.PrimaryPart then
            LocalPlayer.Character.Humanoid.AutoRotate = true
        end
    end})
    Local_Char:AddList(  {text = 'AA Mode', flag = '', default == 'spin', values = {'Spin', 'Custom'}, callback = function(option)
        Anomiss.Visuals.Other.AA_Mode = option
    end})
    Local_Char:AddSlider({text = 'Spin Speed', flag = '', tooltip = 'How fast the character spins.', min = -30, max = 30, increment = 0.1, callback = function(number)
        Anomiss.Visuals.Other.SpinSpeed = number
    end})    

end

do --// Visuals
    local mainToggle = PVisauls:AddToggle({text = 'Enabled', flag = '', callback = function(bool)
        espLib.options.enabled = bool
    end}) mainToggle:AddColor({flag = '', default = Color3.fromRGB(255, 255, 255), callback = function(c)
        espLib.options.nameColor = c 
        espLib.options.boxesColor = c
        espLib.options.outOfViewArrowsColor = c
        espLib.options.tracerColor = c
        espLib.options.distanceColor = c
    end})
    local targetToggle = PVisauls:AddToggle({text = 'Target Highlight', flag = '', callback = function(bool)
        Anomiss.Visuals.Enables.TargetHighlight = bool
    end}) targetToggle:AddColor({flag = 'xcv', default = Color3.fromRGB(255,0,0), callback = function(c)
        espLib.options.whitelistColor = c
    end})
    PVisauls:AddToggle({text = 'Nametags', flag = '', callback = function(bool)
        espLib.options.names = bool
    end})
    PVisauls:AddToggle({text = 'Distance', flag = '', callback = function(bool)
        espLib.options.distance = bool
    end})
    PVisauls:AddToggle({text = 'Boxes', flag = '', callback = function(bool)
        espLib.options.boxes = bool
    end})
    PVisauls:AddToggle({text = 'Healthbars', flag = '', callback = function(bool)
        espLib.options.healthBars = bool        
    end})
    PVisauls:AddToggle({text = 'Tracers', flag = '', callback = function(bool)
        espLib.options.tracers = bool
    end})
    PVisauls:AddToggle({text = 'OutOfView arrows', flag = '', callback = function(bool)
        espLib.options.outOfViewArrows = bool
        espLib.options.outOfViewArrowsOutline = bool
        espLib.options.outOfViewArrowsFilled = bool       
    end})

    PVisauls:AddSeparator({text = "Chams"})
    local ChamToggle = PVisauls:AddToggle({text = 'Chams', flag = '', callback = function(bool)
        Anomiss.Visuals.Enables.Chams.Enabled = bool
        
    end}) 
    ChamColorPicker = ChamToggle:AddColor({flag = 'ChamColor', default = Color3.fromRGB(200,0,0), callback = function(c)
        Anomiss.Visuals.Enables.Chams.Color = c
    end})
    PVisauls:AddSlider({text = 'Transparency', flag = '', tooltip = '', min = 0, max = 1, default = 0.5, increment = 0.05, callback = function(number)
        Anomiss.Visuals.Enables.Chams.Transparency = number
    end})
    PVisauls:AddSlider({text = 'Outline Transparency', flag = '', tooltip = '', default = 0, min = 0, max = 1, increment = 0.05, callback = function(number)
        Anomiss.Visuals.Enables.Chams.OutlineTransparency = number
    end})
    PVisauls:AddToggle({text = 'Rainbow Chams', flag = 'RChams', callback = function(bool)
        Anomiss.Visuals.Enables.Chams.Rainbow = bool
    end})
    

    local playerlist = {}
    local selectedPlayer = nil
    local nameLabel;
    local ageLabel;
    local teamLabel;
    local healthLabel;
    
    local function RefreshStats()
        if selectedPlayer ~= nil and selectedPlayer.Character then
            nameLabel:SetText("Name: "..selectedPlayer.Name)
            ageLabel:SetText("Account Age: "..tostring(selectedPlayer.AccountAge))
            teamLabel:SetText("Team: "..tostring(selectedPlayer.Team))        
    
            if selectedPlayer.Character.Humanoid then
                healthLabel:SetText("Health: "..tostring(selectedPlayer.Character.Humanoid.Health))           
            end
    
        end
    end     

    for i,v in next,Players:GetPlayers() do 
        if v ~= LocalPlayer then
            table.insert(playerlist, v.Name)    
        end
    end    
    local PlayerList = VPlayers:AddList({text = 'Target Player', flag = '', tooltip = 'Select player of choice.', values = playerlist, callback = function(value)
        selectedPlayer = PlayerFromName(value); 
        RefreshStats()
    end})
    Players.PlayerAdded:Connect(function(player)
       PlayerList:AddValue(tostring(player.Name))
    end)
    Players.PlayerRemoving:Connect(function(player)
        PlayerList:RemoveValue(tostring(player.Name))           
    end)

    local isSpectating = false    
    VPlayers:AddToggle({text = 'Spectate', flag = '', callback = function(bool)
        isSpectating = bool
        if isSpectating and selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Humanoid") then
            repeat                
                CCamera.CameraSubject = selectedPlayer.Character.Humanoid                           
                task.wait(0.4)
            until not isSpectating      
        elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then       
            CCamera.CameraSubject = LocalPlayer.Character.Humanoid           
        end        
    end})

    VPlayers:AddButton({text = 'Teleport to', callback = function()
        if selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            TeleportToLocation(selectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0), false)
        end
    end})

    nameLabel = VPlayers:AddText({text = "Name: "})
    ageLabel = VPlayers:AddText({text = "Account Age: "})
    teamLabel = VPlayers:AddText({text = "Team: "})
    healthLabel = VPlayers:AddText({text = "Health: "})       

    VSettings:AddSlider({text = 'Max distance', flag = '', tooltip = 'Distance at which esp is drawn.', default = 500, min = 1, max = 3000, increment = 1, callback = function(number)
        espLib.options.maxDistance = number
        Anomiss.Visuals.MaxDistance = number
    end})
    
    local Aimbient1 = VWSettings:AddToggle({text = 'Aimbient', flag = '', callback = function(bool)
        Anomiss.Visuals.Enables.Aimbient = bool
        if Anomiss.Visuals.Enables.Aimbient then
            repeat task.wait(0.0001)
                game.Lighting.Ambient = Anomiss.Visuals.Colors.Aimbient
            until not Anomiss.Visuals.Enables.Aimbient
        end
    end})  Aimbient1:AddColor({flag = '', default = game.Lighting.Ambient, callback = function(c)
        Anomiss.Visuals.Colors.Aimbient = c
    end})
    local Aimbient2 = VWSettings:AddToggle({text = 'Outdoor Aimbient', flag = '', callback = function(bool)
        Anomiss.Visuals.Enables.OutDoorAimbient = bool
        if Anomiss.Visuals.Enables.OutDoorAimbient then
            repeat task.wait(0.0001)
                game.Lighting.OutdoorAmbient = Anomiss.Visuals.Colors.OutDoorAimbient
            until not Anomiss.Visuals.Enables.OutDoorAimbient
        end
    end})  Aimbient2:AddColor({flag = '', default = game.Lighting.OutdoorAmbient, callback = function(c)
        Anomiss.Visuals.Colors.OutDoorAimbient = c
    end})
    local GrassToggle = VWSettings:AddToggle({text = 'Grass Color', flag = '', callback = function(bool)
        Anomiss.Visuals.Enables.Terrain = bool
        if Anomiss.Visuals.Enables.Terrain then
            repeat task.wait(0.0001)
                workspace.Terrain:SetMaterialColor(Anomiss.Visuals.Colors.TerrainGrassMaterial, Anomiss.Visuals.Colors.TerrainGrassColor)
            until not Anomiss.Visuals.Enables.Terrain
        end
    end})  GrassToggle:AddColor({flag = '', default = Anomiss.Visuals.Colors.TerrainGrassColor, callback = function(c)
        Anomiss.Visuals.Colors.TerrainGrassColor = c
    end})
    local TerrainGroundToggle = VWSettings:AddToggle({text = 'Ground Color', flag = '', callback = function(bool)
        Anomiss.Visuals.Enables.TerrainGround = bool
        if Anomiss.Visuals.Enables.TerrainGround then
            repeat task.wait(0.0001)
                workspace.Terrain:SetMaterialColor(Anomiss.Visuals.Colors.TerrainGroundMaterial, Anomiss.Visuals.Colors.TerrainGroundColor)
            until not Anomiss.Visuals.Enables.TerrainGround
        end
    end})  TerrainGroundToggle:AddColor({flag = '', default = Anomiss.Visuals.Colors.TerrainGroundColor, callback = function(c)
        Anomiss.Visuals.Colors.TerrainGroundColor = c
    end})
    VWSettings:AddToggle({text = 'Global Shadows', default = game.Lighting.GlobalShadows, flag = '', callback = function(bool)
        Anomiss.Visuals.Enables.Shadows = bool
        game.Lighting.GlobalShadows = Anomiss.Visuals.Enables.Shadows
    end})
    VWSettings:AddToggle({text = 'Remove Decoration', flag = '', callback = function(bool)
        Anomiss.Visuals.Enables.HiddenGrass = bool
        sethiddenprop(workspace.Terrain, "Decoration", not Anomiss.Visuals.Enables.HiddenGrass)
    end})
    VWSettings:AddSlider({text = 'Exposure Compensation', flag = '', tooltip = '', min = 0, max = 15, increment = 0.1, callback = function(number)
        game.Lighting.ExposureCompensation = number
    end})
end

do --// Miscellaneous
    local GunList = game:GetService("ReplicatedStorage"):WaitForChild("_CS.Events").GetList:Invoke()
    local SemiWeapons = {Names = {}}
    local AutoWeapons = {Names = {}}
    local ShotWeapons = {Names = {}}   
    local Logger = false
    local GunSemiList; local selectedSemi;
    local GunAutoList; local selectedAuto;
    local ShotGunList; local selectedShotty;


    for i,v in next, Entities:GetChildren() do
        if v.Name == "ToolModel" and ValidToolModel(v) then
            local toolName = v.Handle.ToolBG.ToolName.Value

            if GunList[toolName] and GunList[toolName].Firemode then
                if GunList[toolName].Firemode == "Auto" and not table.find(AutoWeapons.Names, toolName) then                    
                    table.insert(AutoWeapons.Names, toolName)        
                elseif GunList[toolName].Firemode == "Semi" and not table.find(SemiWeapons.Names, toolName) then                    
                    table.insert(SemiWeapons.Names, toolName)  
                elseif GunList[toolName].Firemode == "Shot" and not table.find(ShotWeapons.Names, toolName) then                    
                    table.insert(ShotWeapons.Names, toolName)
                end
            end  
                          
        end
    end

    local AButton, SAButton, SButton

    --// Semi
    GunSemiList = ItemSectionMisc:AddList({text = "Semi's in server", flag = '', tooltip = '', values = SemiWeapons.Names, callback = function(value)
        selectedSemi = value
        SAButton:SetText("Grab: ["..selectedSemi.."]")
    end}) SAButton = ItemSectionMisc:AddButton({text = 'Grab none', callback = function()
        GrabToolFromName(selectedSemi)
    end})   
    
    --// Rifle
    GunAutoList = ItemSectionMisc:AddList({text = "Auto's in server", flag = '', tooltip = '', values = AutoWeapons.Names, callback = function(value)
        selectedAuto = value
        AButton:SetText("Grab: ["..selectedAuto.."]")
    end}) AButton = ItemSectionMisc:AddButton({text = 'Grab none', callback = function()
        GrabToolFromName(selectedAuto)
    end})

    --// Shotgun  
    ShotGunList = ItemSectionMisc:AddList({text = "Shotgun's in server", flag = '', tooltip = '', values = ShotWeapons.Names, callback = function(value)
        selectedShotty = value
        SButton:SetText("Grab: ["..selectedShotty.."]")
    end}) SButton =  ItemSectionMisc:AddButton({text = 'Grab none', callback = function()
        GrabToolFromName(selectedShotty)
    end})

    ItemSectionMisc:AddToggle({text = 'Drop logger', flag = '', tooltip = '', callback = function(bool)
        Logger = bool
    end})

    Entities.ChildAdded:Connect(function(Model)
        task.wait(0.6)
        if Model.Name == "ToolModel" and ValidToolModel(Model) then
            local toolName = Model:WaitForChild("Handle", 100).ToolBG.ToolName.Value

            if GunList[toolName] and GunList[toolName].Firemode then
                if GunList[toolName].Firemode == "Auto"  then         
                    if not table.find(AutoWeapons.Names, toolName) then
                        table.insert(AutoWeapons.Names, toolName)     
                        if Logger then
                            CustomNotify("[Anomiss Logger]", "Auto weapon dropped: ["..toolName.."]", Color3.fromRGB(110, 110, 110), false)
                        end                   
                    end
                elseif GunList[toolName].Firemode == "Semi" then           
                    if not table.find(SemiWeapons.Names, toolName) then
                        table.insert(SemiWeapons.Names, toolName)   
                        if Logger then
                            CustomNotify("[Anomiss Logger]", "Semi weapon dropped: ["..toolName.."]", Color3.fromRGB(110, 110, 110), false)
                        end                    
                    end        
                elseif GunList[toolName].Firemode == "Shot" and not table.find(ShotWeapons.Names, toolName) then  
                    if not table.find(ShotWeapons.Names, toolName) then
                        table.insert(ShotWeapons.Names, toolName)      
                        if Logger then
                            CustomNotify("[Anomiss Logger]", "Shotgun dropped: ["..toolName.."]", Color3.fromRGB(110, 110, 110), false)
                        end                       
                    end      
                end
            end 
        end
    end)
    Entities.ChildRemoved:Connect(function(Model)
        if Model.Name == "ToolModel" and ValidToolModel(Model) then
            local toolName = Model.Handle.ToolBG.ToolName.Value

            if GunList[toolName] and GunList[toolName].Firemode then
                if GunList[toolName].Firemode == "Auto" then                    
                    local tempTable = {}
                    for i,v in next, Entities:GetChildren() do
                        if v.Name == "ToolModel" and ValidToolModel(v) then
                            local tempName = Model.Handle.ToolBG.ToolName.Value
                            if tempName == toolName then
                                table.insert(tempTable, tempName)
                            end
                        end
                    end                    
                    if #tempTable >= 2 then            
                        if table.find(AutoWeapons.Names, toolName) then                            
                            table.remove(AutoWeapons.Names, table.find(AutoWeapons.Names, toolName))
                        end                                                                          
                    end
                elseif GunList[toolName].Firemode == "Semi" then                    
                    local tempTable = {}
                    for i,v in next, Entities:GetChildren() do
                        if v.Name == "ToolModel" and ValidToolModel(v) then
                            local tempName = Model.Handle.ToolBG.ToolName.Value
                            if tempName == toolName then                                
                                table.insert(tempTable, tempName)
                            end
                        end
                    end                    
                    if #tempTable >= 2 then                              
                        if table.find(SemiWeapons.Names, toolName) then                          
                            table.remove(SemiWeapons.Names, table.find(SemiWeapons.Names, toolName))
                        end                                                                                        
                    end
                elseif GunList[toolName].Firemode == "Shot" then                    
                    local tempTable = {}
                    for i,v in next, Entities:GetChildren() do
                        if v.Name == "ToolModel" and ValidToolModel(v) then
                            local tempName = Model.Handle.ToolBG.ToolName.Value
                            if tempName == toolName then
                                table.insert(tempTable, tempName)
                            end
                        end
                    end                    
                    if #tempTable >= 2 then                   
                        if table.find(ShotWeapons.Names, toolName) then                         
                            table.remove(ShotWeapons.Names, table.find(ShotWeapons.Names, toolName))
                        end                                                                      
                    end
                end
            end 

        end
    end)    
    
    TeamSectionMisc:AddList({text = "Change team", flag = '', tooltip = '', values = {"Deliverant","Advanced Gunsmith","Car Dealer","Safe Seven","Gunsmith","Crafter","Cab Driver","Paramedic","SWAT","Civilian","Criminal","Sheriff","Advanced Car Dealer","Secret Service","Tow Trucker","Trucker"}, callback = function(value)
        CSEvents.TeamChanger:FireServer(value)
    end})

    TeamSectionMisc:AddSeparator({text = "Auto buy (Requires roles)"})
    local SelectedAmmo = nil local SelectedCar = nil local SelectedArmor = nil    
    local SelectedAuto local SelectedSemi local SelectedShotty
    local AmmoButton=nil local CarButton=nil local ArmorButton=nil  local AutoButton=nil local SemiButton=nil local ShotButton=nil
    local Ammount = 1
    local IsCrate = false

    TeamSectionMisc:AddSlider({text = 'Purchase Quantity', flag = '', tooltip = 'How many items you want to buy', min = 1, max = 100, increment = 1, callback = function(number)
        Ammount = number
    end})
    TeamSectionMisc:AddToggle({text = 'Is Crate', flag = '', tooltip = '', callback = function(bool)
        IsCrate = bool
    end})

    TeamSectionMisc:AddList({text = "Selected Ammo", flag = '', tooltip = '', values = ValidItemList.Ammo, callback = function(value)
        SelectedAmmo = value
        if AmmoButton then            
            AmmoButton:SetText("Buy "..tostring(Ammount).." ["..SelectedAmmo.."]")            
        end
    end}) AmmoButton = TeamSectionMisc:AddButton({text = 'Buy none', callback = function()
        if SelectedAmmo ~= nil then
            PurchaseItems(SelectedAmmo, Ammount, IsCrate)
        end
    end})

    TeamSectionMisc:AddList({text = "Selected Auto", flag = '', tooltip = '', values = ValidItemList.autos, callback = function(value)
        SelectedAuto = value
        if AutoButton then
            if IsCrate then
                AutoButton:SetText("Buy ".."crate: ["..SelectedAuto.."]")
            else
                AutoButton:SetText("Buy "..tostring(Ammount).." ["..SelectedAuto.."]")
            end
        end
    end}) AutoButton = TeamSectionMisc:AddButton({text = 'Buy none', callback = function()
        if SelectedAuto ~= nil then
            PurchaseItems(SelectedAuto, Ammount, IsCrate)
        end
    end})

    TeamSectionMisc:AddList({text = "Selected Semi", flag = '', tooltip = '', values = ValidItemList.semis, callback = function(value)
        SelectedSemi = value
        if SemiButton then
            if IsCrate then
                SemiButton:SetText("Buy ".."crate: ["..SelectedSemi.."]")
            else
                SemiButton:SetText("Buy "..tostring(Ammount).." ["..SelectedSemi.."]")
            end
        end
    end}) SemiButton = TeamSectionMisc:AddButton({text = 'Buy none', callback = function()
        if SelectedSemi ~= nil then
            PurchaseItems(SelectedSemi, Ammount, IsCrate)
        end
    end})

    TeamSectionMisc:AddList({text = "Selected Shotty", flag = '', tooltip = '', values = ValidItemList.shotguns, callback = function(value)
        SelectedShotty = value
        if ShotButton then
            if IsCrate then
                ShotButton:SetText("Buy ".."crate: ["..SelectedShotty.."]")
            else
                ShotButton:SetText("Buy "..tostring(Ammount).." ["..SelectedShotty.."]")
            end
        end
    end}) ShotButton = TeamSectionMisc:AddButton({text = 'Buy none', callback = function()
        if SelectedShotty ~= nil then
            PurchaseItems(SelectedShotty, Ammount, IsCrate)
        end
    end})

    TeamSectionMisc:AddList({text = "Selected Armor", flag = '', tooltip = '', values = ValidItemList.armors, callback = function(value)
        SelectedArmor = value
        if ArmorButton then
            if IsCrate then
                ArmorButton:SetText("Buy ".."crate: ["..SelectedArmor.."]")
            else
                ArmorButton:SetText("Buy "..tostring(Ammount).." ["..SelectedArmor.."]")
            end
        end
    end}) ArmorButton = TeamSectionMisc:AddButton({text = 'Buy none', callback = function()
        if SelectedArmor ~= nil then
            PurchaseItems(SelectedArmor, Ammount, IsCrate)
        end
    end})

    TeamSectionMisc:AddList({text = "Selected Car", flag = '', tooltip = '', values = ValidItemList.cars, callback = function(value)
        SelectedCar = value
        if CarButton then
            if IsCrate then
                CarButton:SetText("Buy ".."crate: ["..SelectedCar.."]")
            else
                CarButton:SetText("Buy "..tostring(Ammount).." ["..SelectedCar.."]")
            end
        end
    end}) CarButton = TeamSectionMisc:AddButton({text = 'Buy none', callback = function()
        if SelectedCar ~= nil then
            PurchaseItems(SelectedCar, Ammount, IsCrate)
        end
    end})

    -- Teleportation --
    LocalTeleport:AddList({text = 'Teleport to location', flag = '', values = locationNames, callback = function(option)
        TeleportToLocation(option, true)
    end})
end

print("Loading | %70 | Connections")

UserInput.InputBegan:Connect(function(input, game)
    if input.KeyCode == Enum.KeyCode.LeftShift and not game then
       Anomiss.Movement.Running = true
    end
end) 
UserInput.InputEnded:Connect(function(input, game)
    if input.KeyCode == Enum.KeyCode.LeftShift and not game then
        Anomiss.Movement.Running = false
    end
end) 
UserInput.InputBegan:Connect(function(input, game)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and not game then
        Aiming = true
    end
end)
UserInput.InputEnded:Connect(function(input, game)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and not game then
        Aiming = false
    end
end)

UserInput.InputEnded:Connect(function(input, game)
    if Anomiss.Movement.InfiniteJump and input.KeyCode == Enum.KeyCode.Space and not game then
        LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, 40, 0)
    end
end) 

game:GetService("RunService").RenderStepped:Connect(function() 

    if Anomiss.Visuals.Enables.Chams.Enabled then
        UpdateChams()
    end

    if Fov_Circle and Anomiss.Aimbot.FOV.Enabled then
        local CenterOfScreen = Vector2.new(CCamera.ViewportSize.X / 2, CCamera.ViewportSize.Y / 2)
        Fov_Circle.Radius = Anomiss.Aimbot.FOV.Radius
        Fov_Circle.Visible = true   
        Fov_Circle.Color = Anomiss.Aimbot.FOV.Color
        Fov_Circle.NumSides = Anomiss.Aimbot.FOV.NumSides
        
        if Anomiss.Aimbot.FOV.Position == "Center" then
            Fov_Circle.Position = CenterOfScreen
        elseif Anomiss.Aimbot.FOV.Position == "Mouse" then
            Fov_Circle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
        end   
    end

    if fovOveride then
        CCamera.FieldOfView = fovValue
    end

    if Anomiss.Visuals.Other.Thirdperson and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart ~= nil then              
        CCamera.CFrame = CCamera.CFrame * CFrame.new(Anomiss.Visuals.Other.ThirdpersonX, Anomiss.Visuals.Other.ThirdpersonY, Anomiss.Visuals.Other.ThirdpersonZ)
    end

    if Anomiss.Visuals.Enables.Chams.Enabled then       
        for i, highlight in next, ChamCache do 
            if highlight then
                local rcolor = tick() % 5 / 5
                highlight.FillTransparency = Anomiss.Visuals.Enables.Chams.Transparency
                highlight.OutlineTransparency = Anomiss.Visuals.Enables.Chams.OutlineTransparency
                if Anomiss.Visuals.Enables.Chams.Rainbow then
                    highlight.FillColor = Color3.fromHSV(rcolor, 1, 1)
                    ChamColorPicker:SetColor(rcolor)                                 
                else
                    highlight.FillColor = Anomiss.Visuals.Enables.Chams.Color
                end
            end
        end        
    end    

end)
game:GetService("RunService").RenderStepped:Connect(function()     
    --// Aimbots
    if Anomiss.Aimbot.Enabled and Fov_Circle ~= nil or Anomiss.Aimbot.Silent_aim.Enabled and Fov_Circle ~= nil or Anomiss.Aimbot.FOV.Enabled and Fov_Circle ~= nil then
        

        local AimbotTarget = ClosestTarget(Anomiss.Aimbot.HitPart)         
        
        if AimbotTarget and AimbotTarget.Parent ~= nil then
            local AimbotPlayer = PlayerFromName(AimbotTarget.Parent.Name) 
 
            if Aiming and Anomiss.Aimbot.Enabled and not Anomiss.Aimbot.Silent_aim.Enabled then                               
                local position, b = CCamera:WorldToScreenPoint(AimbotTarget.Position)                   
                mousemoverel((position.X - Mouse.X) * Anomiss.Aimbot.AimSpeed, (position.Y - Mouse.Y) * Anomiss.Aimbot.AimSpeed)                   
            end    

            --// Target ESP Color
            if Anomiss.Visuals.Enables.TargetHighlight then            
                for i,p in next, Players:GetPlayers() do
                    if p ~= LocalPlayer then                    
                        if p.Name == AimbotPlayer.Name and not table.find(espLib.whitelist, AimbotPlayer.Name) then
                            table.insert(espLib.whitelist, tostring(AimbotPlayer.Name))                    
                        end
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            table.clear(espLib.whitelist)
                        end)()
                    end
                end
            end

        end
    end    

    if Anomiss.Visuals.Other.AA_Enabled and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart ~= nil then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if Anomiss.Visuals.Other.AA_Mode == "Spin" then
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0,Anomiss.Visuals.Other.SpinSpeed,0)
        elseif Anomiss.Visuals.Other.AA_Mode == "Custom" then
            
        end
    end
end)
game:GetService("RunService").Heartbeat:Connect(function()

    if Anomiss.Movement.Overide and LocalPlayer.Character then
        local humanoid =  LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if Anomiss.Movement.Running then
                humanoid.WalkSpeed = Anomiss.Movement.RunSpeed
            else
                humanoid.WalkSpeed = Anomiss.Movement.Walkspeed
            end
            humanoid.JumpPower = Anomiss.Movement.jumppower
        end
    end

end)

print("Loading | %75")

local function CorrectArguments(Args)
    local Matching = 0
    local Required = 2
    local TypeList = {"Instance", "Ray", "Instance", "boolean", "boolean"}

    if #Args < Required then
        return false    
    end

    for i, a in next, Args do
        if typeof(a) == TypeList[i] then
            Matching += 1
        end
    end   

    return Matching >= Required
end
local function Beam(origin, end_part)    
    if Anomiss.Aimbot.Silent_aim.Beams then
        
        local colorSequence = ColorSequence.new({ColorSequenceKeypoint.new(0, Anomiss.Aimbot.Silent_aim.BeamProperties.Color),ColorSequenceKeypoint.new(1, Settings.EndColor),})
        local Part = Instance.new("Part", BeamPart)

        Part.Size = Vector3.new(1, 1, 1)
        Part.Transparency = 1
        Part.CanCollide = false
        Part.CFrame = CFrame.new(origin)
        Part.Anchored = true

        local Attachment = Instance.new("Attachment", Part)        

        local Attachment2 = Instance.new("Attachment", end_part)
        local Beam = Instance.new("Beam", Part)

        Beam.FaceCamera = true
        Beam.Color = colorSequence
        Beam.Attachment0 = Attachment
        Beam.Attachment1 = Attachment2
        Beam.LightEmission = 6
        Beam.LightInfluence = 1
        Beam.Width0 = Settings.StartWidth
        Beam.Width1 = Settings.EndWidth  

        delay(Settings.Time, function()        
            for i = 0.5, 1, 0.02 do
                wait()
                --Beam.Transparency = NumberSequence.new(i)
            end
            Part:Destroy()
            Attachment2:Destroy()
        end)

    end
end   
coroutine.wrap(function()
    while true do 
        if Anomiss.Aimbot.Silent_aim.Enabled and Anomiss.Aimbot.Silent_aim.AutoFire then
            local hitpart = ClosestTarget(Anomiss.Aimbot.HitPart) 
            if hitpart ~= nil and hitpart.Parent then
                FireGun("Mouse1")
                task.wait(0.15)
            end            
        end
        task.wait(0.01)
    end
end)()
coroutine.wrap(function()
    while true do
        StopConnections()
        task.wait(30)
    end    
end)

print("Loading | %80 | Hooking")
--// Hooking
local RayCastLength = 4500
local oldNamecall, oldIndex
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local CallingScript = getcallingscript()
    local Arguments = {...}
    local self = Arguments[1]

    local ray_origin = nil       

    if Anomiss.Aimbot.Silent_aim.Enabled and tostring(self) == "Workspace" then
        local HitPart = ClosestTarget(Anomiss.Aimbot.HitPart)      

        if HitPart ~= nil and LocalPlayer.Character and game.FindFirstChild(LocalPlayer.Character, "Head") then        
            if (Anomiss.Aimbot.Silent_aim.CallingScript ~= "" and CallingScript.Name == Anomiss.Aimbot.Silent_aim.CallingScript) or (Anomiss.Aimbot.Silent_aim.CallingScript == "") then

                if Anomiss.Aimbot.Silent_aim.PrintCallingScript then
                    print("Calling script: "..tostring(CallingScript.Name))    
                end   

                if Anomiss.Aimbot.Silent_aim.Origin == "Camera" then
                    ray_origin = CCamera.CFrame.Position
                elseif Anomiss.Aimbot.Silent_aim.Origin == "MyHead" then
                    ray_origin = game.FindFirstChild(LocalPlayer.Character, "Head").Position                              
                elseif Anomiss.Aimbot.Silent_aim.Origin == "Teleport" then
                    ray_origin = HitPart.Position + Vector3.new(0,1,0)               
                end

                if tostring(Method) == "FindPartOnRay" and CorrectArguments(Arguments) then

                    local CurrentRay = Arguments[2] 
                    local origin = CurrentRay.Origin              

                    if Anomiss.Aimbot.Silent_aim.Origin == "Called" then
                        Arguments[2] = Ray.new(origin, (HitPart.Position-origin).Unit * RayCastLength)                
                        task.spawn(Beam, origin, HitPart) 
                    else
                        Arguments[2] = Ray.new(ray_origin, (HitPart.Position-ray_origin).Unit * RayCastLength)            
                        task.spawn(Beam, ray_origin, HitPart)     
                    end             

                    return oldNamecall(unpack(Arguments))   
                end     

            end
        end

    end  

    if tostring(Method) == "FindPartOnRayWithWhitelist" and CallingScript == LocalPlayer.PlayerGui["_L.Handler"].GunHandlerLocal then
        wait(9e9)
        return
    end

    if Anomiss.GunModifiers.FlightShot and tostring(Method) == "FindPartOnRayWithIgnoreList" and CallingScript.Name == "MainGunScript" then
        return true
    end

    if Method == "Kick" then		
		return nil                    
	end 
    
    return oldNamecall(...)
end))

oldIndex = hookmetamethod(game, "__index", newcclosure(function(Self, index)

    if tostring(Self) == "Humanoid" then
        if index == "WalkSpeed" then
            return 13
        end
        if index == "JumpPower" then
            return 30
        end
    end

    return oldIndex(Self, index)
end))

print("Loading | %90")
StopConnections()
LocalPlayer.CharacterAdded:Connect(StopConnections)
espLib:Init()  

print("Loading | %95")

CustomNotify("[Anomiss]", "Welcome "..LocalPlayer.Name..", made by H4#0321", Color3.fromRGB(46, 46, 46), false)
print("Loading | %100 | Finished")
