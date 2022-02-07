--// By H3#3534
--// Keybind: Right control

Library = loadstring(game:HttpGet('https://pastebin.com/raw/EkM5gta4'))();

loadstring(game:HttpGet('https://raw.githubusercontent.com/HELLLO1073/Roblox-scripts-2.0/main/Games/CATASTROPHIA/bypass.lua'))();
Library:Notify('Bypasser')

local Fonts = {};
for Font, _ in next, Drawing.Fonts do
  table.insert(Fonts, Font);
end;

local MainWind = Library:CreateWindow('Cata testing V.1.0: H3');
Library:SetWatermark('Made by H3#3534 ;)');
Library:Notify("Welcome: "..game.Players.LocalPlayer.Name.." loading UI!");

local lPlayerWind = MainWind:AddTab('LocalPlayer');

local playerTabbox1 = lPlayerWind:AddLeftTabbox();
local lplayer1 = playerTabbox1:AddTab('Exploits');

lplayer1:AddToggle('SilentFarm', { Text = 'Silent Farm' });
lplayer1:AddToggle('MeleeAura', { Text = 'Melee Aura' });
lplayer1:AddToggle('AutoPick', { Text = 'Auto PickUp' });
lplayer1:AddToggle('AutoDrink', { Text = 'Auto Drink' });

local playerBox = lPlayerWind:AddRightTabbox();
local lPlayerMain = playerBox:AddTab('Player');

lPlayerMain:AddLabel('Visuals');
lPlayerMain:AddSlider('CameraFOV', { Text = 'Camera FOV', Default = math.round(workspace.CurrentCamera.FieldOfView), Min = 0, Max = 120, Rounding = 0 });


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

--// Varibles
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local Loot = game:GetService("Workspace"):WaitForChild("Loot")
local animals = game:GetService("Workspace"):WaitForChild("Animals")
local items = game:GetService("Workspace"):WaitForChild("Items")
local objectFolder = game:GetService("Workspace"):WaitForChild("Suroviny")
local Monuments = game:GetService("Workspace").Monuments
local oldWells = Monuments:WaitForChild("OldWells")

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
    if Toggles.SilentFarm.Value then 
        repeat wait(.2)
            for i,v in pairs(objectFolder:GetChildren()) do            
                if LocalPlayer.Character:FindFirstChildWhichIsA("Tool") and LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("AxeScriptUhel") then
        
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
Toggles.AutoPick:OnChanged(function()
    if Toggles.AutoPick.Value then 
        repeat wait(.1)                       
            local remote = game:GetService("ReplicatedStorage").Events.PickUp              
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
                        game:GetService("ReplicatedStorage").Events.PickUp:FireServer(object)
                    end
                end
                if object.Name == "Bush" then
                    for _, berry in pairs(object:GetChildren()) do
                        if berry:IsA("Part") and berry.Name == "berry"  then
                            local dist = (berry.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if dist < 10 then
                                game:GetService("ReplicatedStorage").Events.PickUp:FireServer(berry)
                            end                            
                        end                        
                    end                    
                end         
            end
        until not Toggles.AutoPick.Value
    end
end)
Toggles.AutoDrink:OnChanged(function()
    if Toggles.AutoDrink.Value then 
        repeat wait(.1)       
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
    if Toggles.MeleeAura.Value then
        repeat wait(.1)
            for i,v in pairs(players:GetChildren()) do
                if LPlayer.Character:FindFirstChildWhichIsA("Tool") and LPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("AxeScriptUhel") and v.Character and v.Character:FindFirstChild("Head") and v ~= LPlayer then
                    local currentTool = LPlayer.Character:FindFirstChildWhichIsA("Tool")
                    local localCframe = LPlayer.Character.HumanoidRootPart.CFrame
                    local mainPart = v.Character.Head
                    local dist = (mainPart.Position-LPlayer.Character.HumanoidRootPart.Position).Magnitude
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
end)

wait(1)
Library:Notify('Loaded UI!');
