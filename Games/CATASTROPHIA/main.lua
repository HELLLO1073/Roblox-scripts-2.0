--// By H3#3534

--// Keybind: Right control
Library = loadstring(game:HttpGet('https://pastebin.com/raw/EkM5gta4'))();

--// Varibles
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local uis = game:GetService("UserInputService")
local SetHiddenProp = sethiddenprop or set_hidden_prop

local Loot = game:GetService("Workspace"):WaitForChild("Loot")
local animals = game:GetService("Workspace"):WaitForChild("Animals")
local items = game:GetService("Workspace"):WaitForChild("Items")
local objectFolder = game:GetService("Workspace"):WaitForChild("Suroviny")
local Monuments = game:GetService("Workspace").Monuments
local oldWells = Monuments:WaitForChild("OldWells")

loadstring(game:HttpGet('https://raw.githubusercontent.com/HELLLO1073/Roblox-scripts-2.0/main/Games/CATASTROPHIA/bypass.lua'))();
Library:Notify('Loading bypasser V.3.0')

local Fonts = {};
for Font, _ in next, Drawing.Fonts do
  table.insert(Fonts, Font);
end;

local inventoryView = {}
function inventoryView:refresh(player,enabled)

    if game:GetService("CoreGui"):FindFirstChild("2XinventoryView") then
        game:GetService("CoreGui"):FindFirstChild("2XinventoryView"):Destroy()
    end

    if enabled and player then
        local mainUI = Instance.new("ScreenGui")
        local MainFrame = Instance.new("Frame")
        local ItemFrame = Instance.new("Frame")
        local UIListLayout = Instance.new("UIListLayout")
        local PlayerNameLabel = Instance.new("TextLabel")
        local NameLabel = Instance.new("TextLabel")

        mainUI.Name = "2XinventoryView"
        mainUI.Parent = game:GetService("CoreGui")
        mainUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                
        MainFrame.Name = "MainFrame"
        MainFrame.Parent = mainUI
        MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        MainFrame.BorderColor3 = Color3.fromRGB(70, 70, 70)
        MainFrame.BorderSizePixel = 1.2
        MainFrame.BackgroundTransparency = 0.250
        MainFrame.Position = UDim2.new(0, 1660, 0, 300)
        MainFrame.Size = UDim2.fromOffset(257,25)
        MainFrame.AutomaticSize = Enum.AutomaticSize.Y
        MainFrame.Draggable = true

        NameLabel.Name = "NameLabel"
        NameLabel.Parent = MainFrame
        NameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NameLabel.BackgroundTransparency = 1.000
        NameLabel.Position = UDim2.new(0.0281010643, 0, -0.00293789315, 0)
        NameLabel.Size = UDim2.new(0, 243, 0, 27)
        NameLabel.Font = Enum.Font.SourceSans
        NameLabel.Text = "Inventory Viewer"
        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameLabel.TextSize = 24.000
        NameLabel.TextWrapped = true
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.TextYAlignment = Enum.TextYAlignment.Bottom

        PlayerNameLabel.Name = "PlayerNameLabel"
        PlayerNameLabel.Parent = NameLabel
        PlayerNameLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        PlayerNameLabel.BackgroundTransparency = 0.800
        PlayerNameLabel.BorderColor3 = Color3.fromRGB(70, 70, 70)
        PlayerNameLabel.Position = UDim2.new(0, 0, 0, 28)
        PlayerNameLabel.Size = UDim2.new(0, 243, 0, 27)
        PlayerNameLabel.Font = Enum.Font.SourceSans
        PlayerNameLabel.Text = tostring(player.Name)
        PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayerNameLabel.TextSize = 23.000
        PlayerNameLabel.TextWrapped = true
        PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Center
        PlayerNameLabel.TextYAlignment = Enum.TextYAlignment.Center

        ItemFrame.Name = "ItemFrame"
        ItemFrame.Parent = MainFrame
        ItemFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        ItemFrame.BackgroundTransparency = 0.800
        ItemFrame.BorderColor3 = Color3.fromRGB(70, 70, 70)
        ItemFrame.ClipsDescendants = true
        ItemFrame.Size = UDim2.fromOffset(0,0)
        ItemFrame.Position = UDim2.new(0, 7, 0, 58)
        ItemFrame.AutomaticSize = Enum.AutomaticSize.XY
        ItemFrame.Draggable = true

        UIListLayout.Parent = ItemFrame
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder       

        local insideViewer = {}
        function insideViewer:AddItem(textName,color)
            local Item = Instance.new("TextLabel")
            Item.Name = "Item: "..tostring(textName)
            Item.Parent = ItemFrame
            Item.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Item.BackgroundTransparency = 1.000
            Item.Size = UDim2.new(0, 243, 0, 19)
            Item.Font = Enum.Font.SourceSans
            Item.Text = tostring(textName)
            Item.TextColor3 = color
            Item.TextSize = 20.000
        end       
         
        for i,v in pairs(player.Backpack:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Stack") then
                insideViewer:AddItem(v.Name.." ["..v.Stack.Value.."]",Color3.fromRGB(255,255,255))
            end
        end
        if player.Character and player.Character:FindFirstChildWhichIsA("Tool") then
            local tool = player.Character:FindFirstChildWhichIsA("Tool")
            insideViewer:AddItem(tool.Name.." ["..tool.Stack.Value.."]",Color3.fromRGB(68, 0, 255))
        end
    else
        if game:GetService("CoreGui"):FindFirstChild("XinventoryView") then
            game:GetService("CoreGui"):FindFirstChild("XinventoryView"):Destroy()
        end
    end
end
local function GetClosestPlayer()
    local ClosestDistance, ClosestPlayer = math.huge, nil;
    for _,Player in next, game:GetService("Players"):GetPlayers() do
        if Player ~= LocalPlayer then
        local Character = Player.Character
            if Character and Character:FindFirstChildWhichIsA("Humanoid") and Character.Humanoid.Health > 1 then
            local ScreenPosition, IsVisibleOnViewPort = Camera:WorldToViewportPoint(Character.HumanoidRootPart.Position)
                if IsVisibleOnViewPort then
                local MDistance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
                    if MDistance < ClosestDistance then
                        ClosestPlayer = Player
                        ClosestDistance = MDistance
                    end
                end
            end
        end
    end
    return ClosestPlayer, ClosestDistance
end
local function objectClip(args,tranparent)
    local canCollide = not args
    for i,v in pairs(objectFolder:GetChildren()) do
        if v:FindFirstChild("Trunk") then
            v.Trunk.Transparency = tranparent
            v.Trunk.CanCollide = canCollide            
        end
        if v:FindFirstChild("Jehlici") then
            for _,d in pairs(v:GetChildren()) do              
                if d.Name == "Jehlici" then
                    d.Decal.Transparency = tranparent
                end
            end
        end
        if string.find(v.Name, "Ore") or v.Name == "Barrel" then
            v.Transparency = tranparent
            v.CanCollide = canCollide
            if v:FindFirstChild("Decal") then
                v.Decal.Transparency = tranparent
            end
        end
        if v.Name == "Bush" and v:IsA("Model") then
            for _,p in pairs(v:GetChildren()) do
                if p:IsA("Part") then
                    p.Transparency = tranparent
                    p.CanCollide = canCollide
                end
            end
        end
    end
    for i,v in pairs(Monuments:GetChildren()) do
        if v.Name == "Guard Tower" and v:IsA("Model") then
            for _,p in pairs(v:GetChildren()) do
                if p:IsA("Part") and p.Name ~= "Platform" then
                    p.Transparency = tranparent
                    p.CanCollide = canCollide
                end
                if p:IsA("UnionOperation") and p.Name ~= "Platform" then
                    p.Transparency = tranparent
                    p.CanCollide = canCollide
                end
            end
        end
        if v.Name == "Statue" and v:IsA("Model") then
            for _,p in pairs(v:GetChildren()) do
                if p:IsA("Part") or p:IsA("UnionOperation") then
                    p.Transparency = tranparent
                    p.CanCollide = canCollide
                end
            end
        end
        if v.Name == "RadTown" and v:IsA("Model") then
            for _,p in pairs(v:GetDescendants()) do
                if p.Name ~= "RadTownFloor" and p.Parent.Name ~= "Watch Tower" and p:IsA("Part") then
                    if p.Name == "Fence" then
                        p.Transparency = 1
                    else
                        p.Transparency = tranparent
                    end                    
                    p.CanCollide = canCollide
                end
                if p.Name ~= "RadTownFloor" and p.Parent.Name ~= "Watch Tower" and p:IsA("UnionOperation") then                    
                    p.Transparency = tranparent                                        
                    p.CanCollide = canCollide
                end
            end
        end
    end
    for i,v in pairs(oldWells:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") then
            v.Transparency = tranparent
            v.CanCollide = canCollide
        end
    end
end
local freecaming = false
local cam = workspace.CurrentCamera
local userInput = game:GetService("UserInputService")
local speed = 60
local lastUpdate = 0

local camerax = Instance.new('Part', workspace)
camerax.CanCollide = false
camerax.Anchored = true
camerax.Transparency = 1
camerax.Name = 'FreeCam'
camerax.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,5,0)    

function getNextMovement(deltaTime)
    local nextMove = Vector3.new()
    -- Left/Right
    if userInput:IsKeyDown("A") or userInput:IsKeyDown("Left") then
        nextMove = nextMove + Vector3.new(-1,0,0)
    end
    if userInput:IsKeyDown("D") or userInput:IsKeyDown("Right") then
        nextMove = nextMove + Vector3.new(1,0,0)
    end
    -- Forward/Back
    if userInput:IsKeyDown("W") or userInput:IsKeyDown("Up") then
        nextMove = nextMove + Vector3.new(0,0,-1)
    end
    if userInput:IsKeyDown("S") or userInput:IsKeyDown("Down") then
        nextMove = nextMove + Vector3.new(0,0,1)
    end
    -- Up/Down
    if userInput:IsKeyDown("Space") or userInput:IsKeyDown("Q") then
        nextMove = nextMove + Vector3.new(0,1,0)
    end
    if userInput:IsKeyDown("LeftControl") or userInput:IsKeyDown("E") then
        nextMove = nextMove + Vector3.new(0,-1,0)
    end
    return CFrame.new( nextMove * (speed * deltaTime) )
end     
function onSelected()
    local char = LocalPlayer.Character
    if char then
        local root = camerax
        currentPos = root.Position        
        lastUpdate = tick()
        cam.CameraSubject = root
        LocalPlayer.Character.HumanoidRootPart.Anchored = true
        while freecaming do
            local delta = tick()-lastUpdate
            local look = (cam.Focus.p-cam.CoordinateFrame.p).unit
            local move = getNextMovement(delta)
            local pos = root.Position
            root.CFrame = CFrame.new(pos,pos+look) * move
            lastUpdate = tick()
            wait(0.01)      
        end
        LocalPlayer.Character.HumanoidRootPart.Anchored = false
        cam.CameraSubject = LocalPlayer.Character.Humanoid
        root.Velocity = Vector3.new()
    end
end

local MainWind = Library:CreateWindow('Cata testing V.2.7: H3');
Library:SetWatermark('Made by H3#3534 ;)');
Library:Notify("Welcome: "..game.Players.LocalPlayer.Name.." loading UI!");

local lPlayerWind = MainWind:AddTab('LocalPlayer');

local playerTabbox1 = lPlayerWind:AddLeftTabbox();
local lplayer1 = playerTabbox1:AddTab('Exploits');

lplayer1:AddToggle('SilentFarm', { Text = 'Silent Farm' });
lplayer1:AddToggle('MeleeAura', { Text = 'Melee Aura' });
lplayer1:AddToggle('AutoPick', { Text = 'Auto PickUp' });
lplayer1:AddToggle('AutoDrink', { Text = 'Auto Drink' });
lplayer1:AddToggle('object_clip', { Text = 'Object Clip' }):OnChanged(function()
    if Toggles.object_clip.Value then
        objectClip(true,0.5)
    else
        objectClip(false,0)
    end
end);

local playerTabbox2 = lPlayerWind:AddLeftTabbox();
local lplayer2 = playerTabbox2:AddTab('Movement');

lplayer2:AddToggle('Highjump', { Text = 'High Jump'}):OnChanged(function()
    if Toggles.Highjump.Value then
        LocalPlayer.Character.Humanoid.JumpPower = 46
    else
        LocalPlayer.Character.Humanoid.JumpPower = 25
    end
end);
lplayer2:AddToggle('AutoSprint', { Text = 'Omni Sprint' }):OnChanged(function()
    if Toggles.Highjump.Value then
        LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if Toggles.AutoSprint.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.Humanoid.WalkSpeed = Options.ASprintSpeed.Value
            end
        end)
    end
end);
lplayer2:AddSlider('ASprintSpeed', { Text = 'Omni Speed', Default = 31, Min = 16, Max = 50, Rounding = 0 });
lplayer2:AddLabel('SpeedBoost', { Text = 'Speed Bypass' }):AddKeyPicker('SpeedBypassKey', { Text = 'Speed Bypass', Default = 'X', Mode = 'Hold', Toggled = false });
lplayer2:AddToggle('MaxSlope', { Text = 'Max Slope angle'}):OnChanged(function()
    if not Toggles.MaxSlope.Value then
        LocalPlayer.Character.Humanoid.MaxSlopeAngle = 45
    end
end);
lplayer2:AddToggle('SpinbotX', { Text = 'Spinbot'}):OnChanged(function()
    if Toggles.SpinbotX.Value then
        local spinSpeed = 20        

        for i,v in pairs(LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
            if v.Name == "Spinning" then
                v:Destroy()
            end
        end

        local Spin = Instance.new("BodyAngularVelocity")
        Spin.Name = "Spinning"
        Spin.Parent = LocalPlayer.Character.HumanoidRootPart
        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
        Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)        
    else
        for i,v in pairs(LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
            if v.Name == "Spinning" then
                v:Destroy()
            end
        end
    end
end);

local speeding = false
uis.InputBegan:connect(function(input)
    if input.KeyCode == Enum.KeyCode[Options.SpeedBypassKey.Value] then
        speeding = true
        repeat wait(0.05)
            if speeding then
                for i = 0, 4, 1 do    
                    if LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        LocalPlayer.Character:TranslateBy(LocalPlayer.Character.Humanoid.MoveDirection)
                    end        
                end
            end
        until not speeding
    end
end)
uis.InputEnded:connect(function(input)
    if input.KeyCode == Enum.KeyCode[Options.SpeedBypassKey.Value] then        
        speeding = false
    end
end)

local playerBox = lPlayerWind:AddRightTabbox();
local lPlayerMain = playerBox:AddTab('Player');

lPlayerMain:AddLabel('Visuals');
lPlayerMain:AddSlider('CameraFOV', { Text = 'Camera FOV', Default = math.round(workspace.CurrentCamera.FieldOfView), Min = 0, Max = 120, Rounding = 0 });
lPlayerMain:AddToggle('ThirdPerson', { Text = 'Third Person' }):OnChanged(function()
    if Toggles.ThirdPerson.Value then
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
    else
        LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    end
end);
lPlayerMain:AddToggle('Freecam', { Text = 'Freecam'}):OnChanged(function()
    if Toggles.Freecam.Value then
        freecaming = true
        onSelected()       
        camerax.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,5,0)        
    else
        freecaming = false
    end
end);


local VisualsTab = MainWind:AddTab('Visuals');
local PlayerESPBox = VisualsTab:AddLeftTabbox();
local PlayerESP = PlayerESPBox:AddTab('Player ESP');

--// Player esp's
PlayerESP:AddToggle('Nametags', { Text = 'Nametags' }):AddColorPicker('name_color', { Default = Color3.new(1, 1, 1) });
PlayerESP:AddToggle('cur_weapon', { Text = 'Current Weapon' }):AddColorPicker('cw_color', { Default = Color3.new(1, 1, 1) });
PlayerESP:AddToggle('Boxes', { Text = 'Boxes' }):AddColorPicker('box_color', { Default = Color3.new(1, 1, 1) });
PlayerESP:AddToggle('Healthbars', { Text = 'Health bars' }):AddColorPicker('health_color', { Default = Color3.new(0, 1, 0) });
PlayerESP:AddToggle('Chams', { Text = 'Chams' }):AddColorPicker('cham_color', { Default = Color3.new(1, 1, 1) });
PlayerESP:AddToggle('Vis_Chams', { Text = 'Visible chams' }):AddColorPicker('vis_cham_color', { Default = Color3.new(1, 0, 0) });
PlayerESP:AddToggle('inv_viewer', { Text = 'Inventory Viewer' }):OnChanged(function()
    if not Toggles.inv_viewer.Value then
        inventoryView:refresh(GetClosestPlayer(),false)
    end
end);

game.RunService.Heartbeat:Connect(function()
    if Toggles.inv_viewer.Value then
        inventoryView:refresh(GetClosestPlayer(),true)
        game.RunService.Heartbeat:wait()    
    end
end)

local ESPSettings = PlayerESPBox:AddTab('ESP Settings');

ESPSettings:AddSlider('FontSize', { Text = 'Font Size', Default = 14, Min = 8, Max = 24, Rounding = 0 });
ESPSettings:AddDropdown('SelectedFont', { Text = 'ESP Font', Default = 1, Values = Fonts });
ESPSettings:AddSlider('Wepoffset', { Text = 'Weptag Y-offset', Default = 43, Min = -100, Max = 200, Rounding = 0 });
ESPSettings:AddSlider('Nameoffset', { Text = 'Nametag Y-offset', Default = 26, Min = -100, Max = 200, Rounding = 0 });

local WorldVisualsBox = VisualsTab:AddLeftTabbox();
local WorldVisuals = WorldVisualsBox:AddTab('World Visuals');
local lighting = game:GetService("Lighting")

WorldVisuals:AddLabel('Ambient'):AddColorPicker('lAmbient', { Default = lighting.Ambient });
WorldVisuals:AddLabel('OutdoorAmbient'):AddColorPicker('lOutDoorAmbient', { Default = lighting.OutdoorAmbient });
WorldVisuals:AddToggle('lShadows', { Text = 'Shadows' });

WorldVisuals:AddToggle('lgrass', { Text = 'Remove grass' }):OnChanged(function()
    SetHiddenProp(workspace.Terrain, "Decoration", not Toggles.lgrass.Value)
end);

WorldVisuals:AddToggle('lxray', { Text = 'x-ray' });

--// World esp's
local WorldESPBox = VisualsTab:AddRightTabbox();
local WorldESP = WorldESPBox:AddTab('World / Object ESP');

WorldESP:AddToggle('AnimalESP', { Text = 'Animal ESP' }):AddColorPicker('as_color', { Default = Color3.fromRGB(0, 215, 255) });
WorldESP:AddToggle('ItemESP',   { Text = 'Item ESP' }):AddColorPicker('is_color', { Default = Color3.new(1, 1, 1) });
WorldESP:AddSlider('idistance', { Text = 'Item distance', Default = 1000, Min = 0, Max = 3000, Rounding = 0 });
WorldESP:AddToggle('ChestESP',  { Text = 'Chest ESP' });
WorldESP:AddToggle('OreESP',    { Text = 'Ore ESP'   });
WorldESP:AddToggle('BerryESP',  { Text = 'Berry ESP' });
WorldESP:AddToggle('GrassESP',  { Text = 'Grass ESP' });
WorldESP:AddToggle('WellESP',  { Text = 'Well ESP' });

local SettingsTab = MainWind:AddTab('Settings');

local function UpdateTheme()
    Library.BackgroundColor = Options.BackgroundColor.Value;
    Library.MainColor = Options.MainColor.Value;
    Library.AccentColor = Options.AccentColor.Value;
    Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);
    Library.OutlineColor = Options.OutlineColor.Value;
    Library.FontColor = Options.FontColor.Value;

    Library:UpdateColorsUsingRegistry();
end;

local function SetDefault()
    Options.FontColor:SetValueRGB(Color3.fromRGB(255, 255, 255));
    Options.MainColor:SetValueRGB(Color3.fromRGB(28, 28, 28));
    Options.BackgroundColor:SetValueRGB(Color3.fromRGB(20, 20, 20));
    Options.AccentColor:SetValueRGB(Color3.fromRGB(0, 85, 255));
    Options.OutlineColor:SetValueRGB(Color3.fromRGB(50, 50, 50));
    Toggles.Rainbow:SetValue(false);

    UpdateTheme();
end;

local Theme = SettingsTab:AddLeftGroupbox('Theme');
Theme:AddLabel('Background Color'):AddColorPicker('BackgroundColor', { Default = Library.BackgroundColor });
Theme:AddLabel('Main Color'):AddColorPicker('MainColor', { Default = Library.MainColor });
Theme:AddLabel('Accent Color'):AddColorPicker('AccentColor', { Default = Library.AccentColor });
Theme:AddToggle('Rainbow', { Text = 'Rainbow Accent Color' });
Theme:AddLabel('Outline Color'):AddColorPicker('OutlineColor', { Default = Library.OutlineColor });
Theme:AddLabel('Font Color'):AddColorPicker('FontColor', { Default = Library.FontColor });
Theme:AddButton('Default Theme', SetDefault);
Theme:AddToggle('Keybinds', { Text = 'Show Keybinds Menu', Default = true }):OnChanged(function()
    Library.KeybindFrame.Visible = Toggles.Keybinds.Value;
end);
Theme:AddToggle('Watermark', { Text = 'Show Watermark', Default = true }):OnChanged(function()
    Library:SetWatermarkVisibility(Toggles.Watermark.Value);
end);

task.spawn(function()
    while game:GetService('RunService').RenderStepped:Wait() do
        if Toggles.Rainbow.Value then
            local Registry = MainWind.Holder.Visible and Library.Registry or Library.HudRegistry;

            for Idx, Object in next, Registry do
                for Property, ColorIdx in next, Object.Properties do
                    if ColorIdx == 'AccentColor' or ColorIdx == 'AccentColorDark' then
                        local Instance = Object.Instance;
                        local yPos = Instance.AbsolutePosition.Y;

                        local Mapped = Library:MapValue(yPos, 0, 1080, 0, 0.5) * 1.5;
                        local Color = Color3.fromHSV((Library.CurrentRainbowHue - Mapped) % 1, 0.8, 1);

                        if ColorIdx == 'AccentColorDark' then
                            Color = Library:GetDarkerColor(Color);
                        end;

                        Instance[Property] = Color;
                    end;
                end;
            end;
        end;
    end;
end);

--// functions
local function xray(trans)
    for i,v in pairs(game:GetService("Workspace").Buildings:GetDescendants()) do           
        if v:IsA("Decal") or v:IsA("Part") or v:IsA("UnionOperation") then            
            v.Transparency = trans             
        end
    end
end

Toggles.Rainbow:OnChanged(function()
    if not Toggles.Rainbow.Value then
        UpdateTheme();
    end;
end);
Options.CameraFOV:OnChanged(function()
    Camera.FieldOfView = Options.CameraFOV.Value
end);

local ligtingOveride = false
Options.lAmbient:OnChanged(function()
    ligtingOveride = true    
end)
Options.lOutDoorAmbient:OnChanged(function()
    ligtingOveride = true    
end)
Toggles.lShadows:OnChanged(function()
    lighting.GlobalShadows = Toggles.lShadows.Value
end)

local char_parts ={ "Head", "LeftFoot", "LeftHand", "LeftLowerArm", "LeftLowerLeg", "LeftUpperArm", "LeftUpperLeg", "LowerTorso", "RightFoot", "RightHand", "RightLowerArm", "RightLowerLeg", "RightUpperArm", "RightUpperLeg", "UpperTorso" }  
Toggles.Chams:OnChanged(function()
    if Toggles.Chams.Value then
        repeat wait(1)
            pcall(function()
                for _,v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        for _,p in pairs(char_parts) do
                            if v.Character:FindFirstChild(p) then
                                if Toggles.Chams.Value then
                                    local part = v.Character[p]
                                    local box = Instance.new("BoxHandleAdornment")                                
                                    box.Parent = game.CoreGui
                                    box.AlwaysOnTop = true
                                    box.Adornee = part
                                    box.ZIndex = 0
                                    box.Transparency = 0.8
                                    box.Color3 = Options.cham_color.Value
                                    if p == "Head"then
                                        box.Size = Vector3.new(1.05,1.05,1.05)
                                    else
                                        box.Size = part.Size + Vector3.new(.05,.05,.05)
                                    end
                                    coroutine.wrap(function()
                                        wait(1)
                                        box:Destroy()
                                    end)()
                                end
                            end
                        end
                    end
                end
            end)          
        until not Toggles.Chams.Value
    end
end)
Toggles.Vis_Chams:OnChanged(function()
    if Toggles.Vis_Chams.Value then
        repeat wait(1)            
            pcall(function()
                for _,v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        for _,p in pairs(char_parts) do
                            if v.Character:FindFirstChild(p) then                                
                                if Toggles.Vis_Chams.Value then
                                    local part = v.Character[p]
                                    local box = Instance.new("BoxHandleAdornment")     
                                    local th = 0.05
                                    box.Parent = game.CoreGui
                                    box.AlwaysOnTop = false
                                    box.Adornee = part
                                    box.ZIndex = 0
                                    box.Transparency = 0.6
                                    box.Color3 = Options.vis_cham_color.Value
                                    if p == "Head"then
                                        box.Size = Vector3.new(1.05,1.05,1.05) 
                                    else
                                        box.Size = part.Size + Vector3.new(.05,.05,.05) + Vector3.new(th,th,th)
                                    end
                                    coroutine.wrap(function()
                                        wait(1)
                                        box:Destroy()
                                    end)()
                                end
                            end
                        end
                    end
                end
            end)          
        until not Toggles.Vis_Chams.Value
    end
end)
Toggles.ChestESP:OnChanged(function()
    if Toggles.ChestESP.Value then
        repeat 
            for i,v in pairs(items:GetChildren()) do
                if v.Name == "ChestLarge" or v.Name == "ChestSmall" then
                    local targetPart = v:FindFirstChild("ChestPrimaryPart")                               
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "chesty"
                    box.Parent = targetPart
                    box.Adornee = targetPart
                    box.AlwaysOnTop = true
                    box.ZIndex = 0
                    box.Transparency = 0.7
                    box.Size = targetPart.Size   
                    box.SizeRelativeOffset = Vector3.new(0, 0, 0)           
                    box.Color = BrickColor.new("Daisy orange")
                    coroutine.wrap(function()
                        wait(10)
                        box:Destroy()
                    end)()
                end
            end      
        wait(10)      
        until not Toggles.ChestESP.Value
    end
end)
Toggles.OreESP:OnChanged(function()
    if Toggles.OreESP.Value then
        repeat
            for i,v in pairs(objectFolder:GetChildren()) do
                if string.find(v.Name,"Ore") then
                    local targetPart = v                                              
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "oreBox"
                    box.Parent = targetPart
                    box.Adornee = targetPart
                    box.AlwaysOnTop = true
                    box.ZIndex = 0
                    box.Transparency = 0.5
                    box.Size = targetPart.Size / Vector3.new(2,3,2)  
                    box.SizeRelativeOffset = Vector3.new(0, 0, 0)  
                    if v.Name == "StoneOre" then         
                        box.Color = BrickColor.new("Dark stone grey")
                        else if v.Name == "SulfurOre" then
                            box.Color = BrickColor.new("Daisy orange")
                            else if v.Name == "IronOre" then
                                box.Color = BrickColor.new("Rust")
                            end
                        end                
                    end
                    coroutine.wrap(function()
                        wait(10)
                        box:Destroy()
                    end)()
                end
            end
        wait(10)           
        until not Toggles.OreESP.Value       
    end
end)
Toggles.BerryESP:OnChanged(function()
    if Toggles.BerryESP.Value then
        repeat
            for i,v in pairs(objectFolder:GetChildren()) do
                if v.Name == "Bush" and v:IsA("Model") then
                    local mainPart;
                    for _,p in pairs(v:GetChildren()) do
                        if p.Name == "MeshPart" and p.Color == Color3.fromRGB(58, 125, 21) then
                            mainPart = p
                        end
                    end
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "bushBox"
                    box.Parent = mainPart
                    box.Adornee = mainPart
                    box.AlwaysOnTop = true
                    box.ZIndex = 0
                    box.Transparency = 0.5
                    box.Size = Vector3.new(3, 2, 3)
                    box.SizeRelativeOffset = Vector3.new(0, -4, 0)
                    box.Color = BrickColor.new("Crimson")
                    coroutine.wrap(function()
                        wait(10)
                        box:Destroy()
                    end)
                end
            end
        wait(10)           
        until not Toggles.BerryESP.Value       
    end
end)
Toggles.GrassESP:OnChanged(function()
    if Toggles.GrassESP.Value then
        repeat
            for i,v in pairs(objectFolder:GetChildren()) do
                if v.Name == "Grass" and v:IsA("MeshPart") then
                    local mainPart = v                
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "grassBox"
                    box.Parent = mainPart
                    box.Adornee = mainPart
                    box.AlwaysOnTop = true
                    box.ZIndex = 0
                    box.Transparency = 0.4
                    box.Size = Vector3.new(1, 2, 1)     
                    box.SizeRelativeOffset = Vector3.new(0, -0.5, 0)           
                    box.Color = BrickColor.new("Bright green")
                    coroutine.wrap(function()
                        wait(10)
                        box:Destroy()
                    end)
                end
            end
        wait(10)           
        until not Toggles.GrassESP.Value       
    end
end)
Toggles.SilentFarm:OnChanged(function()
    if Toggles.SilentFarm.Value and LocalPlayer and LocalPlayer.Character then 
        repeat wait(.2)
            for i,v in pairs(objectFolder:GetChildren()) do            
                if LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
        
                    local tTool = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                    local lookVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector
        
                    local currentTool;            
                    local mainPart; 
        
                    if tTool:FindFirstChild("AxeScriptUhel") then
                        currentTool = tTool
                    end                            

                    for _,p in pairs(v:GetChildren()) do
                        if p.Name == "Trunk" then
                            mainPart = p
                            local dist = (mainPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if dist < 20 then
                                game:GetService("ReplicatedStorage").Events.Sekani:FireServer(currentTool, mainPart, lookVector, mainPart.Size)
                            end
                        end
                        if string.find(p.Parent.Name,"Ore") then
                            mainPart = p.Parent
                            local dist = (mainPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if dist < 20 then
                                game:GetService("ReplicatedStorage").Events.Sekani:FireServer(currentTool, mainPart, lookVector, mainPart.Size)
                            end
                        end
                    end 

                end             
            end
        until not Toggles.SilentFarm.Value
    end
end)
Toggles.AutoPick:OnChanged(function() --< game:GetService("ReplicatedStorage").Events.Sebrat:FireServer(ohInstance1)
    if Toggles.AutoPick.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        local pickUpRemote = "Sebrat"
        repeat wait(.2)       
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then                
                local remote = game:GetService("ReplicatedStorage").Events[pickUpRemote]          
                for i,v in pairs(Loot:GetChildren()) do
                    local mainPart = v:FindFirstChild("Handle")
                    local dist = (mainPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 20 then
                        remote:FireServer(mainPart)
                    end
                end   
                for i,object in pairs(objectFolder:GetChildren()) do 
                    if object.Name == "Grass" then
                        local dist = (object.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 9 then
                            remote:FireServer(object)
                        end
                    end
                    if object.Name == "Bush" then
                        for _, berry in pairs(object:GetChildren()) do
                            if berry:IsA("Part") and berry.Name == "berry"  then
                                local dist = (berry.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                if dist < 10 then
                                    remote:FireServer(berry)
                                end                            
                            end                        
                        end                    
                    end         
                end
            end
        until not Toggles.AutoPick.Value
    end
end)
Toggles.AutoDrink:OnChanged(function()
    if Toggles.AutoDrink.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        repeat wait(1)       
            for i,v in pairs(oldWells:GetChildren()) do
                if v.Name == "OldWell" and v:IsA("Model") then
                    local dist = (v.Kbelik.Voda.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 20 then 
                        game:GetService("ReplicatedStorage").Events.NapitZeStudny:FireServer(v.Kbelik)
                    end
                end
            end
        until not Toggles.AutoDrink.Value
    end
end)
Toggles.MeleeAura:OnChanged(function()
    if Toggles.MeleeAura.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        repeat wait(.1)
            for i,v in pairs(Players:GetChildren()) do
                if LocalPlayer.Character:FindFirstChildWhichIsA("Tool") and LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("AxeScriptUhel") and v.Character and v.Character:FindFirstChild("Head") and v ~= LocalPlayer then
                    local currentTool = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                    local lookVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector

                    local mainPart = v.Character.Head
                    local dist = (mainPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 25 then
                        game:GetService("ReplicatedStorage").Events.Sekani:FireServer(currentTool, mainPart, lookVector, LocalPlayer.Character.Head.Size)
                    end                                                 
                end            
            end
        until not Toggles.MeleeAura.Value
    end
end)
Toggles.lxray:OnChanged(function()
    if Toggles.lxray.Value then
        xray(0.6)
    else
        xray(0)
    end
end)


Options.BackgroundColor:OnChanged(UpdateTheme);
Options.MainColor:OnChanged(UpdateTheme);
Options.AccentColor:OnChanged(UpdateTheme);
Options.OutlineColor:OnChanged(UpdateTheme);
Options.FontColor:OnChanged(UpdateTheme);

--// Main Service
local boxheight1 = 2.5
local boxWidth1 = 1.5
local boxheight2 = 3
local boxWidth2 = 1.5

game:GetService("RunService").RenderStepped:Connect(function()
    --// Player ESP
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        for i,v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                local dist = (v.Character:FindFirstChild("HumanoidRootPart").Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                local headPart = v.Character.Head
                local boxPart = v.Character.HumanoidRootPart
                local vector, onScreen = Camera:WorldToViewportPoint(headPart.Position)
                local vector_2, onScreen2 = Camera:WorldToViewportPoint(boxPart.Position)
                if Toggles.Nametags.Value and onScreen then                     
                    local nameTag = Drawing.new("Text")            
                    nameTag.Visible = true            
                    nameTag.Font = Drawing.Fonts[tostring(Options.SelectedFont.Value)]
                    nameTag.Center = true
                    nameTag.Outline = true
                    nameTag.Size = math.clamp(Options.FontSize.Value-(headPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,Options.FontSize.Value,83)
                    nameTag.Color = Options.name_color.Value
                    nameTag.Text = v.Name.." | "..math.round(dist)
                    nameTag.Position = Vector2.new(
                        game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).X,
                        game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/Options.Nameoffset.Value)).Y)                     
                    coroutine.wrap(function()                    
                        game.RunService.RenderStepped:Wait()
                        nameTag:Remove()
                    end)()
                end
                if Toggles.cur_weapon.Value and onScreen2 then
                    local wepTag = Drawing.new("Text")            
                    wepTag.Visible = true            
                    wepTag.Font = Drawing.Fonts[tostring(Options.SelectedFont.Value)]
                    wepTag.Center = true
                    wepTag.Outline = true
                    wepTag.Size = math.clamp(Options.FontSize.Value-(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,Options.FontSize.Value,83)
                    wepTag.Color = Options.cw_color.Value
                    if v.Character:FindFirstChildWhichIsA("Tool") and v.Character:FindFirstChildWhichIsA("Tool").Stack then    
                        wepTag.Text = v.Character:FindFirstChildWhichIsA("Tool").Name.." [Stack: "..v.Character:FindFirstChildWhichIsA("Tool").Stack.Value.."]"
                    else
                        wepTag.Text = "none"
                    end
                    wepTag.Position = Vector2.new(
                        game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).X,
                        game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/Options.Wepoffset.Value)).Y)  
    
                    coroutine.wrap(function()                    
                        game.RunService.RenderStepped:Wait()
                        wepTag:Remove()
                    end)()
                end
                if Toggles.Nametags.Value and onScreen then                     
                    local nameTag = Drawing.new("Text")            
                    nameTag.Visible = true            
                    nameTag.Font = Drawing.Fonts[tostring(Options.SelectedFont.Value)]
                    nameTag.Center = true
                    nameTag.Outline = true
                    nameTag.Size = math.clamp(Options.FontSize.Value-(headPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,Options.FontSize.Value,83)
                    nameTag.Color = Options.name_color.Value
                    nameTag.Text = v.Name.." | "..math.round(dist)
                    nameTag.Position = Vector2.new(
                        game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).X,
                        game.Workspace.CurrentCamera:WorldToViewportPoint(boxPart.CFrame.Position+boxPart.CFrame.UpVector*(3+(boxPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/Options.Nameoffset.Value)).Y)                     
                    coroutine.wrap(function()                    
                        game.RunService.RenderStepped:Wait()
                        nameTag:Remove()
                    end)()
                end
                if Toggles.Boxes.Value and onScreen2 then
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
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * boxheight1).X,
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * boxheight1).Y)  
                    boxOutline.PointB = Vector2.new(
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * boxheight1).X,
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * boxheight1).Y)  
                    boxOutline.PointC = Vector2.new(
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * -boxheight2).X,
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * -boxheight2).Y)  
                    boxOutline.PointD = Vector2.new(
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * -boxheight2).X,
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * -boxheight2).Y)
    
                    --// Main box                    
                    local box = Drawing.new("Quad")       
                    box.Visible = true
                    box.Color = Options.box_color.Value
                    box.Thickness = 1
                    box.Transparency = 1
                    box.Filled = false
                    box.ZIndex = 2                  
                    box.PointA = Vector2.new(
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * boxheight1).X,
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * boxheight1).Y)  
                    box.PointB = Vector2.new(
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * boxheight1).X,
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * boxheight1).Y)  
                    box.PointC = Vector2.new(
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * -boxheight2).X,
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector * boxWidth1 + boxPart.CFrame.UpVector * -boxheight2).Y)  
                    box.PointD = Vector2.new(
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * -boxheight2).X,
                        Camera:WorldToViewportPoint(boxPart.CFrame.Position + boxPart.CFrame.RightVector *-boxWidth2 + boxPart.CFrame.UpVector * -boxheight2).Y)             
                    coroutine.wrap(function()
                        game.RunService.RenderStepped:wait()
                        box:Remove()
                        boxOutline:Remove()
                    end)() 
                end
                if Toggles.Healthbars.Value and onScreen then
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
                    d.Color = Options.health_color.Value
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
        --// Item ESP
        if Toggles.ItemESP.Value then
            for i,v in pairs(Loot:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("Handle") then
                    local mainPart = v:FindFirstChild("Handle")
                    local partDist = (mainPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    local vec, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(mainPart.Position)
                    if onScreen and partDist < Options.idistance.Value and partDist > 5 then
                        local txt = Drawing.new("Text")
                        txt.Text = mainPart.Parent.Name.." | "..tostring(math.round(partDist))
                        txt.Outline = true 
                        txt.Visible = true 
                        txt.Center = true                                   
                        txt.Font = 1
                        txt.Size = 15                    
                        txt.Color = Options.is_color.Value
                        txt.Position = Vector2.new(vec.X,vec.Y - 10)
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            txt:Remove()
                        end)()
                    end
                end
            end
        end
        --// Animals 
        if Toggles.AnimalESP.Value then
            for _,animal in pairs(animals:GetChildren()) do
                if animal:IsA("Model") and animal:FindFirstChild("Torso") then
                    local mainPart = animal.Torso
                    local dist = (mainPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    local vec, onScreen = Camera:WorldToViewportPoint(mainPart.Position)
                    if onScreen then
                        local nameTag = Drawing.new("Text")
                        nameTag.Visible = true
                        nameTag.Font = 1
                        nameTag.Outline = true
                        nameTag.Center = true
                        nameTag.Size = math.clamp(14-(mainPart.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,14,83)
                        nameTag.Color = Options.as_color.Value 
                        nameTag.Text = animal.Name.." | "..math.round(dist)
                        nameTag.Position = Vector2.new(vec.X,vec.Y)
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            nameTag:Remove()
                        end)()
                    end
                end
            end
        end
        --// Well ESP
        if Toggles.WellESP.Value then
            for i,v in pairs(oldWells:GetChildren()) do
                if v.Name == "OldWell" and v:IsA("Model") then
                    local targetPart;
                    for _,p in pairs(v:GetChildren()) do
                        if p.Name == "Part" and p.Color == Color3.fromRGB(110, 153, 202) then
                            targetPart = p
                        end
                    end
                    local partDist = (targetPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    local vec, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local txt = Drawing.new("Text")
                        txt.Text = targetPart.Parent.Name.." | "..tostring(math.round(partDist))
                        txt.Outline = true 
                        txt.Visible = true 
                        txt.Center = true                                   
                        txt.Font = 1
                        txt.Size = 15                    
                        txt.Color = Color3.fromRGB(0, 132, 255)
                        txt.Position = Vector2.new(vec.X,vec.Y - 10)
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            txt:Remove()
                        end)()
                    end
                end
            end
        end
        if ligtingOveride then
            lighting.Ambient = Options.lAmbient.Value
            lighting.OutdoorAmbient = Options.lOutDoorAmbient.Value
        end
        if Toggles.MaxSlope.Value then
            LocalPlayer.Character.Humanoid.MaxSlopeAngle = 99
        end
    end
end)

local Char = LocalPlayer.Character or workspace:FindFirstChild(LocalPlayer.Name)
local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")

Human:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if Toggles.AutoSprint.Value then
        Human.WalkSpeed = Options.ASprintSpeed.Value
    end
end)

wait(1)
Library:Notify('Loaded UI!');
