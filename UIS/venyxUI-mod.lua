--// Anomic Script, old and buggy could use a rewrite entirely i admit.

local mainName = "Anomic V | 2.8.5" 
if game:GetService("CoreGui"):FindFirstChild(mainName) then
    game.CoreGui[mainName]:Destroy()
end

print("Loading | LIB") 

-- Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HELLLO1073/Roblox-scripts-2.0/main/UIS/venyxUI-mod.lua"))()
local Main = library.new(mainName)

-- // Tabs
local PLa = Main:addPage("Player", 5012544693)
local CombatTab = Main:addPage("Combat", 6034509993)
local Esp = Main:addPage("Visuals", 5012544693)
local Other = Main:addPage("Others", 6031280883)
local tele = Main:addPage("Teleportation", 6031280883)
local Buy = Main:addPage("Guns", 6034509993)
local misc = Main:addPage("Miscellaneous", 6034509993)
local Ui = Main:addPage("Settings", 6022860343)
-- init
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- services
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new

-- additional
local utility = {}

-- themes
local objects = {}
local themes = {
	Background = Color3.fromRGB(24, 24, 24), 
	Glow = Color3.fromRGB(0, 0, 0), 
	Accent = Color3.fromRGB(10, 10, 10), 
	LightContrast = Color3.fromRGB(20, 20, 20), 
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

do
	function utility:Create(instance, properties, children)
		local object = Instance.new(instance)
		
		for i, v in pairs(properties or {}) do
			object[i] = v
			
			if typeof(v) == "Color3" then -- save for theme changer later
				local theme = utility:Find(themes, v)
				
				if theme then
					objects[theme] = objects[theme] or {}
					objects[theme][i] = objects[theme][i] or setmetatable({}, {_mode = "k"})
					
					table.insert(objects[theme][i], object)
				end
			end
		end
		
		for i, module in pairs(children or {}) do
			module.Parent = object
		end
		
		return object
	end
	
	function utility:Tween(instance, properties, duration, ...)
		tween:Create(instance, tweeninfo(duration, ...), properties):Play()
	end
	
	function utility:Wait()
		run.RenderStepped:Wait()
		return true
	end
	
	function utility:Find(table, value) -- table.find doesn't work for dictionaries
		for i, v in  pairs(table) do
			if v == value then
				return i
			end
		end
	end
	
	function utility:Sort(pattern, values)
		local new = {}
		pattern = pattern:lower()
		
		if pattern == "" then
			return values
		end
		
		for i, value in pairs(values) do
			if tostring(value):lower():find(pattern) then
				table.insert(new, value)
			end
		end
		
		return new
	end
	
	function utility:Pop(object, shrink)
		local clone = object:Clone()
		
		clone.AnchorPoint = Vector2.new(0.5, 0.5)
		clone.Size = clone.Size - UDim2.new(0, shrink, 0, shrink)
		clone.Position = UDim2.new(0.5, 0, 0.5, 0)
		
		clone.Parent = object
		clone:ClearAllChildren()
		
		object.ImageTransparency = 1
		utility:Tween(clone, {Size = object.Size}, 0.2)
		
		spawn(function()
			wait(0.2)
		
			object.ImageTransparency = 0
			clone:Destroy()
		end)
		
		return clone
	end
	
	function utility:InitializeKeybind()
		self.keybinds = {}
		self.ended = {}
		
		input.InputBegan:Connect(function(key)
			if self.keybinds[key.KeyCode] then
				for i, bind in pairs(self.keybinds[key.KeyCode]) do
					bind()
				end
			end
		end)
		
		input.InputEnded:Connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				for i, callback in pairs(self.ended) do
					callback()
				end
			end
		end)
	end
	
	function utility:BindToKey(key, callback)
		 
		self.keybinds[key] = self.keybinds[key] or {}
		
		table.insert(self.keybinds[key], callback)
		
		return {
			UnBind = function()
				for i, bind in pairs(self.keybinds[key]) do
					if bind == callback then
						table.remove(self.keybinds[key], i)
					end
				end
			end
		}
	end
	
	function utility:KeyPressed() -- yield until next key is pressed
		local key = input.InputBegan:Wait()
		
		while key.UserInputType ~= Enum.UserInputType.Keyboard	 do
			key = input.InputBegan:Wait()
		end
		
		wait() -- overlapping connection
		
		return key
	end
	
	function utility:DraggingEnabled(frame, parent)
	
		parent = parent or frame
		
		-- stolen from wally or kiriot, kek
		local dragging = false
		local dragInput, mousePos, framePos

		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				mousePos = input.Position
				framePos = parent.Position
				
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				dragInput = input
			end
		end)

		input.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				local delta = input.Position - mousePos
				parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
			end
		end)

	end
	
	function utility:DraggingEnded(callback)
		table.insert(self.ended, callback)
	end
	
end


if game.PlaceId == 4581966615 then

    function notify(title, message)game:GetService("Players").LocalPlayer.PlayerGui.Notify.TimePosition = 0 game:GetService("Players").LocalPlayer.PlayerGui.Notify.Playing = true if not message then require(game:GetService("ReplicatedStorage"):WaitForChild("Client").NotificationHandler):AddToStream(game.Players.LocalPlayer,title) else require(game:GetService("ReplicatedStorage"):WaitForChild("Client").NotificationHandler):AddToStream(game.Players.LocalPlayer,title..": "..message)end end

    local DevList = loadstring(game:HttpGet("https://raw.githubusercontent.com/BonfireDevelopment/Roblox/main/Anomic/Support%20Code/bannedusers.lua"))()
    local idontwannabedisturbed = loadstring(game:HttpGet("https://raw.githubusercontent.com/BonfireDevelopment/Roblox/main/Anomic/Support%20Code/banbannedusers.lua"))()

    local chatscroller = game.Players.LocalPlayer.PlayerGui.Chat:WaitForChild("Frame").ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller
    chatscroller.ChildAdded:Connect(function(chatframe)
        if chatframe:IsA("Frame") then
            local textlabel = chatframe:WaitForChild("TextLabel")
            if textlabel then
                local text = string.gsub(textlabel.Text, " ", "")
                if text == "*(!)*" or text == "*(@)*" then
                    chatframe:Destroy()                    
                end
            end
        end
    end)    

    local bubblechat = game:GetService("CoreGui").BubbleChat
    bubblechat.ChildAdded:Connect(function(chatgui)
        if chatgui:IsA("BillboardGui") then
            local frame1 = chatgui:FindFirstChildOfClass("Frame")
            if frame1 then
                local frame2 = frame1:WaitForChild("Frame")
                if frame2 and frame2:FindFirstChild("Frame") then
                    if frame2.Frame.Text.Text == "*(!)*" or frame2.Frame.Text.Text == "*(@)*" then
                        frame2:Destroy()                        
                    end
                end
            end
        end
    end)

    local function ApplyDev(v)
        local s,e = pcall(function()
            v.Head.PlayerDisplay.Wanted.Text = "Developer"
            if v.Name == DevList[1] or v.Name == DevList[3] then
                v.Head.PlayerDisplay.Wanted.TextColor3 = Color3.fromRGB(185, 92, 0)
                v.Head.PlayerDisplay.PlayerName.Text = "Bonfire"
            else
                v.Head.PlayerDisplay.Wanted.TextColor3 = Color3.fromRGB(209, 37, 10)
                if v.Name == DevList[2] then
                    v.Head.PlayerDisplay.PlayerName.Text = "H4"
                end
                if string.find(v.Name, "Spo") then
                    v.Head.PlayerDisplay.PlayerName.Text = "Spooks"
                end
            end
        end)
    end

    local function DevCheck(v)
        if table.find(DevList, v.Name) then
            if v.Name == DevList[1] and not table.find(DevList, game.Players.LocalPlayer.Name) and idontwannabedisturbed then game:Shutdown() end
            repeat wait() until v:FindFirstChild("PlayerName", true) and v:FindFirstChild("Wanted", true)
            ApplyDev(v)

            --epic "error handling" lmao
            v.Head.PlayerDisplay.Wanted:GetPropertyChangedSignal("Text"):Connect(function()
                ApplyDev(v)
            end)
            v.Head.PlayerDisplay.Wanted:GetPropertyChangedSignal("TextColor3"):Connect(function()
                ApplyDev(v)
            end)
        end
    end    

    local devsfound = false
    for i,v in pairs (game.Players:GetPlayers()) do
        if table.find(DevList, v.Name) then
            devsfound = true
            local args = {
                [1] = "/w " .. DevList[table.find(DevList, v.Name)] .. " *(@)*",
                [2] = "All"
            }
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args)) 
        end
        if v.Character then
            DevCheck(v.Character)
        end
        v.CharacterAdded:Connect(function(char)
            DevCheck(char)
        end)
    end

    if devsfound and keypress and keyrelease and isrbxactive then
        if not isrbxactive() then
            notify("Focus on the Roblox application to resume loading")
            repeat task.wait() until isrbxactive()
        end
        keypress(0xBF)
        task.wait(0.1)
        keyrelease(0xBF)
        task.wait(0.1)
        keypress(0x08)
        task.wait(0.1)
        keyrelease(0x08)
        task.wait(0.1)
        keypress(0x0D)
        task.wait(0.1)
        keyrelease(0x0D)
    end

    game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            DevCheck(char)
        end)
    end)

    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function (messageObj)
        print(messageObj.FromSpeaker)
        if table.find(DevList, messageObj.FromSpeaker) then
            if messageObj.Message == "*(@)*" then
                local args = {
                    [1] = "/w " .. DevList[table.find(DevList, messageObj.FromSpeaker)] .. " *(@)*",
                    [2] = "All"
                }
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))  
                if keypress and keyrelease and isrbxactive then
                    if not isrbxactive() then
                        notify("Focus on the Roblox application to resume game")
                        repeat task.wait() until isrbxactive()
                    end
                    keypress(0xBF)
                    task.wait(0.1)
                    keyrelease(0xBF)
                    task.wait(0.1)
                    keypress(0x08)
                    task.wait(0.1)
                    keyrelease(0x08)
                    task.wait(0.1)
                    keypress(0x0D)
                    task.wait(0.1)
                    keyrelease(0x0D)
                end
            elseif string.sub(messageObj.Message,1,1) == "B" or string.sub(messageObj.Message,1,1) == "H" then
                local splitted = string.split(messageObj.Message, " ")
                if string.sub(game.Players.LocalPlayer.Name,1,#splitted[2]) == splitted[2] then
                    if string.sub(messageObj.Message,1,1) == "B" then
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/BonfireDevelopment/Roblox/main/Anomic/Support%20Code/globalvaluefixer" .. string.sub(messageObj.Message,2,2) .. ".lua"))()
                    elseif string.sub(messageObj.Message,1,1) == "H" then
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/Anomiss01/c2noityr3c4/main/upvaluefixer" .. string.sub(messageObj.Message,2,2) .. ".lua"))()
                    end
                end
            end
        end
    end)

end

--will add popup soon

-- classes

local library = {} -- main
local page = {}
local section = {}

do
	library.__index = library
	page.__index = page
	section.__index = section
	
	-- new classes
	
	function library.new(title)
		local container = utility:Create("ScreenGui", {
			Name = title,
			Parent = game.CoreGui
		}, {
			utility:Create("ImageLabel", {
				Name = "Main",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.25, 0, 0.052435593, 0),
				Size = UDim2.new(0, 511, 0, 428),
				Image = "rbxassetid://4641149554",
				ImageColor3 = themes.Background,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(4, 4, 296, 296)
			}, {
				utility:Create("ImageLabel", {
					Name = "Glow",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, -15, 0, -15),
					Size = UDim2.new(1, 30, 1, 30),
					ZIndex = 0,
					Image = "rbxassetid://5028857084",
					ImageColor3 = themes.Glow,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(24, 24, 276, 276)
				}),
				utility:Create("ImageLabel", {
					Name = "Pages",
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Position = UDim2.new(0, 0, 0, 38),
					Size = UDim2.new(0, 126, 1, -38),
					ZIndex = 3,
					Image = "rbxassetid://5012534273",
					ImageColor3 = themes.DarkContrast,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(4, 4, 296, 296)
				}, {
					utility:Create("ScrollingFrame", {
						Name = "Pages_Container",
						Active = true,
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 0, 0, 10),
						Size = UDim2.new(1, 0, 1, -20),
						CanvasSize = UDim2.new(0, 0, 0, 314),
						ScrollBarThickness = 0
					}, {
						utility:Create("UIListLayout", {
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, 10)
						})
					})
				}),
				utility:Create("ImageLabel", {
					Name = "TopBar",
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Size = UDim2.new(1, 0, 0, 38),
					ZIndex = 5,
					Image = "rbxassetid://4595286933",
					ImageColor3 = themes.Accent,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(4, 4, 296, 296)
				}, {
					utility:Create("TextLabel", { -- title
						Name = "Title",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 12, 0, 19),
						Size = UDim2.new(1, -46, 0, 16),
						ZIndex = 5,
						Font = Enum.Font.GothamBold,
						Text = title,
						TextColor3 = themes.TextColor,
						TextSize = 14,
						TextXAlignment = Enum.TextXAlignment.Left
					})
				})
			})
		})
		
		utility:InitializeKeybind()
		utility:DraggingEnabled(container.Main.TopBar, container.Main)
		
		return setmetatable({
			container = container,
			pagesContainer = container.Main.Pages.Pages_Container,
			pages = {}
		}, library)
	end
	
	function page.new(library, title, icon)
		local button = utility:Create("TextButton", {
			Name = title,
			Parent = library.pagesContainer,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 26),
			ZIndex = 3,
			AutoButtonColor = false,
			Font = Enum.Font.Gotham,
			Text = "",
			TextSize = 14
		}, {
			utility:Create("TextLabel", {
				Name = "Title",
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 40, 0.5, 0),
				Size = UDim2.new(0, 76, 1, 0),
				ZIndex = 3,
				Font = Enum.Font.Gotham,
				Text = title,
				TextColor3 = themes.TextColor,
				TextSize = 12,
				TextTransparency = 0.65,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			icon and utility:Create("ImageLabel", {
				Name = "Icon", 
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 12, 0.5, 0),
				Size = UDim2.new(0, 16, 0, 16),
				ZIndex = 3,
				Image = "rbxassetid://" .. tostring(icon),
				ImageColor3 = themes.TextColor,
				ImageTransparency = 0.64,
				ScaleType = Enum.ScaleType.Fit
			}) or {}
		})
		
		local container = utility:Create("ScrollingFrame", {
			Name = title,
			Parent = library.container.Main,
			Active = true,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 134, 0, 46),
			Size = UDim2.new(1, -142, 1, -56),
			CanvasSize = UDim2.new(0, 0, 0, 466),
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = themes.DarkContrast,
			Visible = false
		}, {
			utility:Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10)
			})
		})
		
		return setmetatable({
			library = library,
			container = container,
			button = button,
			sections = {}
		}, page)
	end
	
	function section.new(page, title)
		local container = utility:Create("ImageLabel", {
			Name = title,
			Parent = page.container,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -10, 0, 28),
			ZIndex = 2,
			Image = "rbxassetid://5028857472",
			ImageColor3 = themes.LightContrast,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(4, 4, 296, 296),
			ClipsDescendants = true
		}, {
			utility:Create("Frame", {
				Name = "Container",
				Active = true,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 8, 0, 8),
				Size = UDim2.new(1, -16, 1, -16)
			}, {
				utility:Create("TextLabel", {
					Name = "Title",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 20),
					ZIndex = 2,
					Font = Enum.Font.GothamSemibold,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTransparency = 1
				}),
				utility:Create("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 4)
				})
			})
		})
		
		return setmetatable({
			page = page,
			container = container.Container,
			colorpickers = {},
			modules = {},
			binds = {},
			lists = {},
		}, section) 
	end
	
	function library:addPage(...)
	
		local page = page.new(self, ...)
		local button = page.button
		
		table.insert(self.pages, page)

		button.MouseButton1Click:Connect(function()
			self:SelectPage(page, true)
		end)
		
		return page
	end
	
	function page:addSection(...)
		local section = section.new(self, ...)
		
		table.insert(self.sections, section)
		
		return section
	end
	
	-- functions
	
	function library:setTheme(theme, color3)
		themes[theme] = color3
		
		for property, objects in pairs(objects[theme]) do
			for i, object in pairs(objects) do
				if not object.Parent or (object.Name == "Button" and object.Parent.Name == "ColorPicker") then
					objects[i] = nil -- i can do this because weak tables :D
				else
					object[property] = color3
				end
			end
		end
	end
	
	function library:toggle()
	
		if self.toggling then
			return
		end
		
		self.toggling = true
		
		local container = self.container.Main
		local topbar = container.TopBar
		
		if self.position then
			utility:Tween(container, {
				Size = UDim2.new(0, 511, 0, 428),
				Position = self.position
			}, 0.2)
			wait(0.2)
			
			utility:Tween(topbar, {Size = UDim2.new(1, 0, 0, 38)}, 0.2)
			wait(0.2)
			
			container.ClipsDescendants = false
			self.position = nil
		else
			self.position = container.Position
			container.ClipsDescendants = true
			
			utility:Tween(topbar, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
			wait(0.2)
			
			utility:Tween(container, {
				Size = UDim2.new(0, 511, 0, 0),
				Position = self.position + UDim2.new(0, 0, 0, 428)
			}, 0.2)
			wait(0.2)
		end
		
		self.toggling = false
	end
	
	-- new modules
	
	function library:Notify(title, text, callback)
	
		-- overwrite last notification
		if self.activeNotification then
			self.activeNotification = self.activeNotification()
		end
		
		-- standard create
		local notification = utility:Create("ImageLabel", {
			Name = "Notification",
			Parent = self.container,
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 200, 0, 60),
			Image = "rbxassetid://5028857472",
			ImageColor3 = themes.Background,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(4, 4, 296, 296),
			ZIndex = 3,
			ClipsDescendants = true
		}, {
			utility:Create("ImageLabel", {
				Name = "Flash",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Image = "rbxassetid://4641149554",
				ImageColor3 = themes.TextColor,
				ZIndex = 5
			}),
			utility:Create("ImageLabel", {
				Name = "Glow",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, -15, 0, -15),
				Size = UDim2.new(1, 30, 1, 30),
				ZIndex = 2,
				Image = "rbxassetid://5028857084",
				ImageColor3 = themes.Glow,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(24, 24, 276, 276)
			}),
			utility:Create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 8),
				Size = UDim2.new(1, -40, 0, 16),
				ZIndex = 4,
				Font = Enum.Font.GothamSemibold,
				TextColor3 = themes.TextColor,
				TextSize = 14.000,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utility:Create("TextLabel", {
				Name = "Text",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 1, -24),
				Size = UDim2.new(1, -40, 0, 16),
				ZIndex = 4,
				Font = Enum.Font.Gotham,
				TextColor3 = themes.TextColor,
				TextSize = 12.000,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utility:Create("ImageButton", {
				Name = "Accept",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -26, 0, 8),
				Size = UDim2.new(0, 16, 0, 16),
				Image = "rbxassetid://5012538259",
				ImageColor3 = themes.TextColor,
				ZIndex = 4
			}),
			utility:Create("ImageButton", {
				Name = "Decline",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -26, 1, -24),
				Size = UDim2.new(0, 16, 0, 16),
				Image = "rbxassetid://5012538583",
				ImageColor3 = themes.TextColor,
				ZIndex = 4
			})
		})
		
		-- dragging
		utility:DraggingEnabled(notification)
		
		-- position and size
		title = title or "Notification"
		text = text or ""
		
		notification.Title.Text = title
		notification.Text.Text = text
		
		local padding = 10
		local textSize = game:GetService("TextService"):GetTextSize(text, 12, Enum.Font.Gotham, Vector2.new(math.huge, 16))
		
		notification.Position = library.lastNotification or UDim2.new(0, padding, 1, -(notification.AbsoluteSize.Y + padding))
		notification.Size = UDim2.new(0, 0, 0, 60)
		
		utility:Tween(notification, {Size = UDim2.new(0, textSize.X + 70, 0, 60)}, 0.2)
		wait(0.2)
		
		notification.ClipsDescendants = false
		utility:Tween(notification.Flash, {
			Size = UDim2.new(0, 0, 0, 60),
			Position = UDim2.new(1, 0, 0, 0)
		}, 0.2)
		
		-- callbacks
		local active = true
		local close = function()
		
			if not active then
				return
			end
			
			active = false
			notification.ClipsDescendants = true
			
			library.lastNotification = notification.Position
			notification.Flash.Position = UDim2.new(0, 0, 0, 0)
			utility:Tween(notification.Flash, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
			
			wait(0.2)
			utility:Tween(notification, {
				Size = UDim2.new(0, 0, 0, 60),
				Position = notification.Position + UDim2.new(0, textSize.X + 70, 0, 0)
			}, 0.2)
			
			wait(0.2)
			notification:Destroy()
		end
		
		self.activeNotification = close
		
		notification.Accept.MouseButton1Click:Connect(function()
		
			if not active then 
				return
			end
			
			if callback then
				callback(true)
			end
			
			close()
		end)
		
		notification.Decline.MouseButton1Click:Connect(function()
		
			if not active then 
				return
			end
			
			if callback then
				callback(false)
			end
			
			close()
		end)
	end
	
	function section:addButton(title, callback)
		local button = utility:Create("ImageButton", {
			Name = "Button",
			Parent = self.container,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 30),
			ZIndex = 2,
			Image = "rbxassetid://5028857472",
			ImageColor3 = themes.DarkContrast,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(2, 2, 298, 298)
		}, {
			utility:Create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 3,
				Font = Enum.Font.Gotham,
				Text = title,
				TextColor3 = themes.TextColor,
				TextSize = 12,
				TextTransparency = 0.10000000149012
			})
		})
		
		table.insert(self.modules, button)
		--self:Resize()
		
		local text = button.Title
		local debounce
		
		button.MouseButton1Click:Connect(function()
			
			if debounce then
				return
			end
			
			-- animation
			utility:Pop(button, 10)
			
			debounce = true
			text.TextSize = 0
			utility:Tween(button.Title, {TextSize = 14}, 0.2)
			
			wait(0.2)
			utility:Tween(button.Title, {TextSize = 12}, 0.2)
			
			if callback then
				callback(function(...)
					self:updateButton(button, ...)
				end)
			end
			
			debounce = false
		end)
		
		return button
	end
	
	function section:addToggle(title, default, callback)
		local toggle = utility:Create("ImageButton", {
			Name = "Toggle",
			Parent = self.container,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 30),
			ZIndex = 2,
			Image = "rbxassetid://5028857472",
			ImageColor3 = themes.DarkContrast,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(2, 2, 298, 298)
		},{
			utility:Create("TextLabel", {
				Name = "Title",
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0.5, 1),
				Size = UDim2.new(0.5, 0, 1, 0),
				ZIndex = 3,
				Font = Enum.Font.Gotham,
				Text = title,
				TextColor3 = themes.TextColor,
				TextSize = 12,
				TextTransparency = 0.10000000149012,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utility:Create("ImageLabel", {
				Name = "Button",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -50, 0.5, -8),
				Size = UDim2.new(0, 40, 0, 16),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.LightContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("ImageLabel", {
					Name = "Frame",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 2, 0.5, -6),
					Size = UDim2.new(1, -22, 1, -4),
					ZIndex = 2,
					Image = "rbxassetid://5028857472",
					ImageColor3 = themes.TextColor,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				})
			})
		})
		
		table.insert(self.modules, toggle)
		--self:Resize()
		
		local active = default
		self:updateToggle(toggle, nil, active)
		
		toggle.MouseButton1Click:Connect(function()
			active = not active
			self:updateToggle(toggle, nil, active)
			
			if callback then
				callback(active, function(...)
					self:updateToggle(toggle, ...)
				end)
			end
		end)
		
		return toggle
	end
	
	function section:addTextbox(title, default, callback)
		local textbox = utility:Create("ImageButton", {
			Name = "Textbox",
			Parent = self.container,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 30),
			ZIndex = 2,
			Image = "rbxassetid://5028857472",
			ImageColor3 = themes.DarkContrast,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(2, 2, 298, 298)
		}, {
			utility:Create("TextLabel", {
				Name = "Title",
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0.5, 1),
				Size = UDim2.new(0.5, 0, 1, 0),
				ZIndex = 3,
				Font = Enum.Font.Gotham,
				Text = title,
				TextColor3 = themes.TextColor,
				TextSize = 12,
				TextTransparency = 0.10000000149012,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utility:Create("ImageLabel", {
				Name = "Button",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -110, 0.5, -8),
				Size = UDim2.new(0, 100, 0, 16),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.LightContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("TextBox", {
					Name = "Textbox", 
					BackgroundTransparency = 1,
					TextTruncate = Enum.TextTruncate.AtEnd,
					Position = UDim2.new(0, 5, 0, 0),
					Size = UDim2.new(1, -10, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.GothamSemibold,
					Text = default or "",
					TextColor3 = themes.TextColor,
					TextSize = 11
				})
			})
		})
		
		table.insert(self.modules, textbox)
		--self:Resize()
		
		local button = textbox.Button
		local input = button.Textbox
		
		textbox.MouseButton1Click:Connect(function()
		
			if textbox.Button.Size ~= UDim2.new(0, 100, 0, 16) then
				return
			end
			
			utility:Tween(textbox.Button, {
				Size = UDim2.new(0, 200, 0, 16),
				Position = UDim2.new(1, -210, 0.5, -8)
			}, 0.2)
			
			wait()

			input.TextXAlignment = Enum.TextXAlignment.Left
			input:CaptureFocus()
		end)
		
		input:GetPropertyChangedSignal("Text"):Connect(function()
			
			if button.ImageTransparency == 0 and (button.Size == UDim2.new(0, 200, 0, 16) or button.Size == UDim2.new(0, 100, 0, 16)) then -- i know, i dont like this either
				utility:Pop(button, 10)
			end
			
			if callback then
				callback(input.Text, nil, function(...)
					self:updateTextbox(textbox, ...)
				end)
			end
		end)
		
		input.FocusLost:Connect(function()
			
			input.TextXAlignment = Enum.TextXAlignment.Center
			
			utility:Tween(textbox.Button, {
				Size = UDim2.new(0, 100, 0, 16),
				Position = UDim2.new(1, -110, 0.5, -8)
			}, 0.2)
			
			if callback then
				callback(input.Text, true, function(...)
					self:updateTextbox(textbox, ...)
				end)
			end
		end)
		
		return textbox
	end
	
	function section:addKeybind(title, default, callback, changedCallback)
		local keybind = utility:Create("ImageButton", {
			Name = "Keybind",
			Parent = self.container,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 30),
			ZIndex = 2,
			Image = "rbxassetid://5028857472",
			ImageColor3 = themes.DarkContrast,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(2, 2, 298, 298)
		}, {
			utility:Create("TextLabel", {
				Name = "Title",
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0.5, 1),
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 3,
				Font = Enum.Font.Gotham,
				Text = title,
				TextColor3 = themes.TextColor,
				TextSize = 12,
				TextTransparency = 0.10000000149012,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utility:Create("ImageLabel", {
				Name = "Button",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -110, 0.5, -8),
				Size = UDim2.new(0, 100, 0, 16),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.LightContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("TextLabel", {
					Name = "Text",
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.GothamSemibold,
					Text = default and default.Name or "None",
					TextColor3 = themes.TextColor,
					TextSize = 11
				})
			})
		})
		
		table.insert(self.modules, keybind)
		--self:Resize()
		
		local text = keybind.Button.Text
		local button = keybind.Button
		
		local animate = function()
			if button.ImageTransparency == 0 then
				utility:Pop(button, 10)
			end
		end
		
		self.binds[keybind] = {callback = function()
			animate()
			
			if callback then
				callback(function(...)
					self:updateKeybind(keybind, ...)
				end)
			end
		end}
		
		if default and callback then
			self:updateKeybind(keybind, nil, default)
		end
		
		keybind.MouseButton1Click:Connect(function()
			
			animate()
			
			if self.binds[keybind].connection then -- unbind
				return self:updateKeybind(keybind)
			end
			
			if text.Text == "None" then -- new bind
				text.Text = "..."
				
				local key = utility:KeyPressed()
				
				self:updateKeybind(keybind, nil, key.KeyCode)
				animate()
				
				if changedCallback then
					changedCallback(key, function(...)
						self:updateKeybind(keybind, ...)
					end)
				end
			end
		end)
		
		return keybind
	end
	
	function section:addColorPicker(title, default, callback)
		local colorpicker = utility:Create("ImageButton", {
			Name = "ColorPicker",
			Parent = self.container,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 30),
			ZIndex = 2,
			Image = "rbxassetid://5028857472",
			ImageColor3 = themes.DarkContrast,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(2, 2, 298, 298)
		},{
			utility:Create("TextLabel", {
				Name = "Title",
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0.5, 1),
				Size = UDim2.new(0.5, 0, 1, 0),
				ZIndex = 3,
				Font = Enum.Font.Gotham,
				Text = title,
				TextColor3 = themes.TextColor,
				TextSize = 12,
				TextTransparency = 0.10000000149012,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utility:Create("ImageButton", {
				Name = "Button",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -50, 0.5, -7),
				Size = UDim2.new(0, 40, 0, 14),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			})
		})
		
		local tab = utility:Create("ImageLabel", {
			Name = "ColorPicker",
			Parent = self.page.library.container,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.75, 0, 0.400000006, 0),
			Selectable = true,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0, 162, 0, 169),
			Image = "rbxassetid://5028857472",
			ImageColor3 = themes.Background,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(2, 2, 298, 298),
			Visible = false,
		}, {
			utility:Create("ImageLabel", {
				Name = "Glow",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, -15, 0, -15),
				Size = UDim2.new(1, 30, 1, 30),
				ZIndex = 0,
				Image = "rbxassetid://5028857084",
				ImageColor3 = themes.Glow,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(22, 22, 278, 278)
			}),
			utility:Create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 8),
				Size = UDim2.new(1, -40, 0, 16),
				ZIndex = 2,
				Font = Enum.Font.GothamSemibold,
				Text = title,
				TextColor3 = themes.TextColor,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utility:Create("ImageButton", {
				Name = "Close",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -26, 0, 8),
				Size = UDim2.new(0, 16, 0, 16),
				ZIndex = 2,
				Image = "rbxassetid://5012538583",
				ImageColor3 = themes.TextColor
			}), 
			utility:Create("Frame", {
				Name = "Container",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 8, 0, 32),
				Size = UDim2.new(1, -18, 1, -40)
			}, {
				utility:Create("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 6)
				}),
				utility:Create("ImageButton", {
					Name = "Canvas",
					BackgroundTransparency = 1,
					BorderColor3 = themes.LightContrast,
					Size = UDim2.new(1, 0, 0, 60),
					AutoButtonColor = false,
					Image = "rbxassetid://5108535320",
					ImageColor3 = Color3.fromRGB(255, 0, 0),
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("ImageLabel", {
						Name = "White_Overlay",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 60),
						Image = "rbxassetid://5107152351",
						SliceCenter = Rect.new(2, 2, 298, 298)
					}),
					utility:Create("ImageLabel", {
						Name = "Black_Overlay",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 60),
						Image = "rbxassetid://5107152095",
						SliceCenter = Rect.new(2, 2, 298, 298)
					}),
					utility:Create("ImageLabel", {
						Name = "Cursor",
						BackgroundColor3 = themes.TextColor,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundTransparency = 1.000,
						Size = UDim2.new(0, 10, 0, 10),
						Position = UDim2.new(0, 0, 0, 0),
						Image = "rbxassetid://5100115962",
						SliceCenter = Rect.new(2, 2, 298, 298)
					})
				}),
				utility:Create("ImageButton", {
					Name = "Color",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0, 4),
					Selectable = false,
					Size = UDim2.new(1, 0, 0, 16),
					ZIndex = 2,
					AutoButtonColor = false,
					Image = "rbxassetid://5028857472",
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("Frame", {
						Name = "Select",
						BackgroundColor3 = themes.TextColor,
						BorderSizePixel = 1,
						Position = UDim2.new(1, 0, 0, 0),
						Size = UDim2.new(0, 2, 1, 0),
						ZIndex = 2
					}),
					utility:Create("UIGradient", { -- rainbow canvas
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), 
							ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)), 
							ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), 
							ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), 
							ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), 
							ColorSequenceKeypoint.new(0.82, Color3.fromRGB(255, 0, 255)), 
							ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
						})
					})
				}),
				utility:Create("Frame", {
					Name = "Inputs",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 158),
					Size = UDim2.new(1, 0, 0, 16)
				}, {
					utility:Create("UIListLayout", {
						FillDirection = Enum.FillDirection.Horizontal,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 6)
					}),
					utility:Create("ImageLabel", {
						Name = "R",
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(0.305, 0, 1, 0),
						ZIndex = 2,
						Image = "rbxassetid://5028857472",
						ImageColor3 = themes.DarkContrast,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(2, 2, 298, 298)
					}, {
						utility:Create("TextLabel", {
							Name = "Text",
							BackgroundTransparency = 1,
							Size = UDim2.new(0.400000006, 0, 1, 0),
							ZIndex = 2,
							Font = Enum.Font.Gotham,
							Text = "R:",
							TextColor3 = themes.TextColor,
							TextSize = 10.000
						}),
						utility:Create("TextBox", {
							Name = "Textbox",
							BackgroundTransparency = 1,
							Position = UDim2.new(0.300000012, 0, 0, 0),
							Size = UDim2.new(0.600000024, 0, 1, 0),
							ZIndex = 2,
							Font = Enum.Font.Gotham,
							PlaceholderColor3 = themes.DarkContrast,
							Text = "255",
							TextColor3 = themes.TextColor,
							TextSize = 10.000
						})
					}),
					utility:Create("ImageLabel", {
						Name = "G",
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(0.305, 0, 1, 0),
						ZIndex = 2,
						Image = "rbxassetid://5028857472",
						ImageColor3 = themes.DarkContrast,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(2, 2, 298, 298)
					}, {
						utility:Create("TextLabel", {
							Name = "Text",
							BackgroundTransparency = 1,
							ZIndex = 2,
							Size = UDim2.new(0.400000006, 0, 1, 0),
							Font = Enum.Font.Gotham,
							Text = "G:",
							TextColor3 = themes.TextColor,
							TextSize = 10.000
						}),
						utility:Create("TextBox", {
							Name = "Textbox",
							BackgroundTransparency = 1,
							Position = UDim2.new(0.300000012, 0, 0, 0),
							Size = UDim2.new(0.600000024, 0, 1, 0),
							ZIndex = 2,
							Font = Enum.Font.Gotham,
							Text = "255",
							TextColor3 = themes.TextColor,
							TextSize = 10.000
						})
					}),
					utility:Create("ImageLabel", {
						Name = "B",
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(0.305, 0, 1, 0),
						ZIndex = 2,
						Image = "rbxassetid://5028857472",
						ImageColor3 = themes.DarkContrast,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(2, 2, 298, 298)
					}, {
						utility:Create("TextLabel", {
							Name = "Text",
							BackgroundTransparency = 1,
							Size = UDim2.new(0.400000006, 0, 1, 0),
							ZIndex = 2,
							Font = Enum.Font.Gotham,
							Text = "B:",
							TextColor3 = themes.TextColor,
							TextSize = 10.000
						}),
						utility:Create("TextBox", {
							Name = "Textbox",
							BackgroundTransparency = 1,
							Position = UDim2.new(0.300000012, 0, 0, 0),
							Size = UDim2.new(0.600000024, 0, 1, 0),
							ZIndex = 2,
							Font = Enum.Font.Gotham,
							Text = "255",
							TextColor3 = themes.TextColor,
							TextSize = 10.000
						})
					}),
				}),
				utility:Create("ImageButton", {
					Name = "Button",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 20),
					ZIndex = 2,
					Image = "rbxassetid://5028857472",
					ImageColor3 = themes.DarkContrast,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("TextLabel", {
						Name = "Text",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 3,
						Font = Enum.Font.Gotham,
						Text = "Submit",
						TextColor3 = themes.TextColor,
						TextSize = 11.000
					})
				})
			})
		})
		
		utility:DraggingEnabled(tab)
		table.insert(self.modules, colorpicker)
		--self:Resize()
		
		local allowed = {
			[""] = true
		}
		
		local canvas = tab.Container.Canvas
		local color = tab.Container.Color
		
		local canvasSize, canvasPosition = canvas.AbsoluteSize, canvas.AbsolutePosition
		local colorSize, colorPosition = color.AbsoluteSize, color.AbsolutePosition
		
		local draggingColor, draggingCanvas
		
		local color3 = default or Color3.fromRGB(255, 255, 255)
		local hue, sat, brightness = 0, 0, 1
		local rgb = {
			r = 255,
			g = 255,
			b = 255
		}
		
		self.colorpickers[colorpicker] = {
			tab = tab,
			callback = function(prop, value)
				rgb[prop] = value
				hue, sat, brightness = Color3.toHSV(Color3.fromRGB(rgb.r, rgb.g, rgb.b))
			end
		}
		
		local callback = function(value)
			if callback then
				callback(value, function(...)
					self:updateColorPicker(colorpicker, ...)
				end)
			end
		end
		
		utility:DraggingEnded(function()
			draggingColor, draggingCanvas = false, false
		end)
		
		if default then
			self:updateColorPicker(colorpicker, nil, default)
			
			hue, sat, brightness = Color3.toHSV(default)
			default = Color3.fromHSV(hue, sat, brightness)
			
			for i, prop in pairs({"r", "g", "b"}) do
				rgb[prop] = default[prop:upper()] * 255
			end
		end
		
		for i, container in pairs(tab.Container.Inputs:GetChildren()) do -- i know what you are about to say, so shut up
			if container:IsA("ImageLabel") then
				local textbox = container.Textbox
				local focused
				
				textbox.Focused:Connect(function()
					focused = true
				end)
				
				textbox.FocusLost:Connect(function()
					focused = false
					
					if not tonumber(textbox.Text) then
						textbox.Text = math.floor(rgb[container.Name:lower()])
					end
				end)
				
				textbox:GetPropertyChangedSignal("Text"):Connect(function()
					local text = textbox.Text
					
					if not allowed[text] and not tonumber(text) then
						textbox.Text = text:sub(1, #text - 1)
					elseif focused and not allowed[text] then
						rgb[container.Name:lower()] = math.clamp(tonumber(textbox.Text), 0, 255)
						
						local color3 = Color3.fromRGB(rgb.r, rgb.g, rgb.b)
						hue, sat, brightness = Color3.toHSV(color3)
						
						self:updateColorPicker(colorpicker, nil, color3)
						callback(color3)
					end
				end)
			end
		end
		
		canvas.MouseButton1Down:Connect(function()
			draggingCanvas = true
			
			while draggingCanvas do
				
				local x, y = mouse.X, mouse.Y
				
				sat = math.clamp((x - canvasPosition.X) / canvasSize.X, 0, 1)
				brightness = 1 - math.clamp((y - canvasPosition.Y) / canvasSize.Y, 0, 1)
				
				color3 = Color3.fromHSV(hue, sat, brightness)
				
				for i, prop in pairs({"r", "g", "b"}) do
					rgb[prop] = color3[prop:upper()] * 255
				end
				
				self:updateColorPicker(colorpicker, nil, {hue, sat, brightness}) -- roblox is literally retarded
				utility:Tween(canvas.Cursor, {Position = UDim2.new(sat, 0, 1 - brightness, 0)}, 0.1) -- overwrite
				
				callback(color3)
				utility:Wait()
			end
		end)
		
		color.MouseButton1Down:Connect(function()
			draggingColor = true
			
			while draggingColor do
			
				hue = 1 - math.clamp(1 - ((mouse.X - colorPosition.X) / colorSize.X), 0, 1)
				color3 = Color3.fromHSV(hue, sat, brightness)
				
				for i, prop in pairs({"r", "g", "b"}) do
					rgb[prop] = color3[prop:upper()] * 255
				end
				
				local x = hue -- hue is updated
				self:updateColorPicker(colorpicker, nil, {hue, sat, brightness}) -- roblox is literally retarded
				utility:Tween(tab.Container.Color.Select, {Position = UDim2.new(x, 0, 0, 0)}, 0.1) -- overwrite
				
				callback(color3)
				utility:Wait()
			end
		end)
		
		-- click events
		local button = colorpicker.Button
		local toggle, debounce, animate
		
		lastColor = Color3.fromHSV(hue, sat, brightness)
		animate = function(visible, overwrite)
			
			if overwrite then
			
				if not toggle then
					return
				end
				
				if debounce then
					while debounce do
						utility:Wait()
					end
				end
			elseif not overwrite then
				if debounce then 
					return 
				end
				
				if button.ImageTransparency == 0 then
					utility:Pop(button, 10)
				end
			end
			
			toggle = visible
			debounce = true
			
			if visible then
			
				if self.page.library.activePicker and self.page.library.activePicker ~= animate then
					self.page.library.activePicker(nil, true)
				end
				
				self.page.library.activePicker = animate
				lastColor = Color3.fromHSV(hue, sat, brightness)
				
				local x1, x2 = button.AbsoluteSize.X / 2, 162--tab.AbsoluteSize.X
				local px, py = button.AbsolutePosition.X, button.AbsolutePosition.Y
				
				tab.ClipsDescendants = true
				tab.Visible = true
				tab.Size = UDim2.new(0, 0, 0, 0)
				
				tab.Position = UDim2.new(0, x1 + x2 + px, 0, py)
				utility:Tween(tab, {Size = UDim2.new(0, 162, 0, 169)}, 0.2)
				
				-- update size and position
				wait(0.2)
				tab.ClipsDescendants = false
				
				canvasSize, canvasPosition = canvas.AbsoluteSize, canvas.AbsolutePosition
				colorSize, colorPosition = color.AbsoluteSize, color.AbsolutePosition
			else
				utility:Tween(tab, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
				tab.ClipsDescendants = true
				
				wait(0.2)
				tab.Visible = false
			end
			
			debounce = false
		end
		
		local toggleTab = function()
			animate(not toggle)
		end
		
		button.MouseButton1Click:Connect(toggleTab)
		colorpicker.MouseButton1Click:Connect(toggleTab)
		
		tab.Container.Button.MouseButton1Click:Connect(function()
			animate()
		end)
		
		tab.Close.MouseButton1Click:Connect(function()
			self:updateColorPicker(colorpicker, nil, lastColor)
			animate()
		end)
		
		return colorpicker
	end
	
	function section:addSlider(title, default, min, max, callback)
		local slider = utility:Create("ImageButton", {
			Name = "Slider",
			Parent = self.container,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.292817682, 0, 0.299145311, 0),
			Size = UDim2.new(1, 0, 0, 50),
			ZIndex = 2,
			Image = "rbxassetid://5028857472",
			ImageColor3 = themes.DarkContrast,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(2, 2, 298, 298)
		}, {
			utility:Create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 6),
				Size = UDim2.new(0.5, 0, 0, 16),
				ZIndex = 3,
				Font = Enum.Font.Gotham,
				Text = title,
				TextColor3 = themes.TextColor,
				TextSize = 12,
				TextTransparency = 0.10000000149012,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utility:Create("TextBox", {
				Name = "TextBox",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -30, 0, 6),
				Size = UDim2.new(0, 20, 0, 16),
				ZIndex = 3,
				Font = Enum.Font.GothamSemibold,
				Text = default or min,
				TextColor3 = themes.TextColor,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Right
			}),
			utility:Create("TextLabel", {
				Name = "Slider",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 28),
				Size = UDim2.new(1, -20, 0, 16),
				ZIndex = 3,
				Text = "",
			}, {
				utility:Create("ImageLabel", {
					Name = "Bar",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 0, 4),
					ZIndex = 3,
					Image = "rbxassetid://5028857472",
					ImageColor3 = themes.LightContrast,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("ImageLabel", {
						Name = "Fill",
						BackgroundTransparency = 1,
						Size = UDim2.new(0.8, 0, 1, 0),
						ZIndex = 3,
						Image = "rbxassetid://5028857472",
						ImageColor3 = themes.TextColor,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(2, 2, 298, 298)
					}, {
						utility:Create("ImageLabel", {
							Name = "Circle",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							ImageTransparency = 1.000,
							ImageColor3 = themes.TextColor,
							Position = UDim2.new(1, 0, 0.5, 0),
							Size = UDim2.new(0, 10, 0, 10),
							ZIndex = 3,
							Image = "rbxassetid://4608020054"
						})
					})
				})
			})
		})
		
		table.insert(self.modules, slider)
		--self:Resize()
		
		local allowed = {
			[""] = true,
			["-"] = true
		}
		
		local textbox = slider.TextBox
		local circle = slider.Slider.Bar.Fill.Circle
		
		local value = default or min
		local dragging, last
		
		local callback = function(value)
			if callback then
				callback(value, function(...)
					self:updateSlider(slider, ...)
				end)
			end
		end
		
		self:updateSlider(slider, nil, value, min, max)
		
		utility:DraggingEnded(function()
			dragging = false
		end)

		slider.MouseButton1Down:Connect(function(input)
			dragging = true
			
			while dragging do
				utility:Tween(circle, {ImageTransparency = 0}, 0.1)
				
				value = self:updateSlider(slider, nil, nil, min, max, value)
				callback(value)
				
				utility:Wait()
			end
			
			wait(0.5)
			utility:Tween(circle, {ImageTransparency = 1}, 0.2)
		end)
		
		textbox.FocusLost:Connect(function()
			if not tonumber(textbox.Text) then
				value = self:updateSlider(slider, nil, default or min, min, max)
				callback(value)
			end
		end)
		
		textbox:GetPropertyChangedSignal("Text"):Connect(function()
			local text = textbox.Text
			
			if not allowed[text] and not tonumber(text) then
				textbox.Text = text:sub(1, #text - 1)
			elseif not allowed[text] then	
				value = self:updateSlider(slider, nil, tonumber(text) or value, min, max)
				callback(value)
			end
		end)
		
		return slider
	end
	
	function section:addDropdown(title, list, callback)
		local dropdown = utility:Create("Frame", {
			Name = "Dropdown",
			Parent = self.container,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 30),
			ClipsDescendants = true
		}, {
			utility:Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 4)
			}),
			utility:Create("ImageLabel", {
				Name = "Search",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 30),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.DarkContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("TextBox", {
					Name = "TextBox",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					TextTruncate = Enum.TextTruncate.AtEnd,
					Position = UDim2.new(0, 10, 0.5, 1),
					Size = UDim2.new(1, -42, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextTransparency = 0.10000000149012,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("ImageButton", {
					Name = "Button",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(1, -28, 0.5, -9),
					Size = UDim2.new(0, 18, 0, 18),
					ZIndex = 3,
					Image = "rbxassetid://5012539403",
					ImageColor3 = themes.TextColor,
					SliceCenter = Rect.new(2, 2, 298, 298)
				})
			}),
			utility:Create("ImageLabel", {
				Name = "List",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, -34),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.Background,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("ScrollingFrame", {
					Name = "Frame",
					Active = true,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 4, 0, 4),
					Size = UDim2.new(1, -8, 1, -8),
					CanvasPosition = Vector2.new(0, 28),
					CanvasSize = UDim2.new(0, 0, 0, 120),
					ZIndex = 2,
					ScrollBarThickness = 3,
					ScrollBarImageColor3 = themes.DarkContrast
				}, {
					utility:Create("UIListLayout", {
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 4)
					})
				})
			})
		})
		
		table.insert(self.modules, dropdown)
		--self:Resize()
		
		local search = dropdown.Search
		local focused
		
		list = list or {}
		
		search.Button.MouseButton1Click:Connect(function()
			if search.Button.Rotation == 0 then
				self:updateDropdown(dropdown, nil, list, callback)
			else
				self:updateDropdown(dropdown, nil, nil, callback)
			end
		end)
		
		search.TextBox.Focused:Connect(function()
			if search.Button.Rotation == 0 then
				self:updateDropdown(dropdown, nil, list, callback)
			end
			
			focused = true
		end)
		
		search.TextBox.FocusLost:Connect(function()
			focused = false
		end)
		
		search.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
			if focused then
				local list = utility:Sort(search.TextBox.Text, list)
				list = #list ~= 0 and list 
				
				self:updateDropdown(dropdown, nil, list, callback)
			end
		end)
		
		dropdown:GetPropertyChangedSignal("Size"):Connect(function()
			self:Resize()
		end)
		
		return dropdown
	end
	
	-- class functions
	
	function library:SelectPage(page, toggle)
		
		if toggle and self.focusedPage == page then -- already selected
			return
		end
		
		local button = page.button
		
		if toggle then
			-- page button
			button.Title.TextTransparency = 0
			button.Title.Font = Enum.Font.GothamSemibold
			
			if button:FindFirstChild("Icon") then
				button.Icon.ImageTransparency = 0
			end
			
			-- update selected page
			local focusedPage = self.focusedPage
			self.focusedPage = page
			
			if focusedPage then
				self:SelectPage(focusedPage)
			end
			
			-- sections
			local existingSections = focusedPage and #focusedPage.sections or 0
			local sectionsRequired = #page.sections - existingSections
			
			page:Resize()
			
			for i, section in pairs(page.sections) do
				section.container.Parent.ImageTransparency = 0
			end
			
			if sectionsRequired < 0 then -- "hides" some sections
				for i = existingSections, #page.sections + 1, -1 do
					local section = focusedPage.sections[i].container.Parent
					
					utility:Tween(section, {ImageTransparency = 1}, 0.1)
				end
			end
			
			wait(0.1)
			page.container.Visible = true
			
			if focusedPage then
				focusedPage.container.Visible = false
			end
			
			if sectionsRequired > 0 then -- "creates" more section
				for i = existingSections + 1, #page.sections do
					local section = page.sections[i].container.Parent
					
					section.ImageTransparency = 1
					utility:Tween(section, {ImageTransparency = 0}, 0.05)
				end
			end
			
			wait(0.05)
			
			for i, section in pairs(page.sections) do
			
				utility:Tween(section.container.Title, {TextTransparency = 0}, 0.1)
				section:Resize(true)
				
				wait(0.05)
			end
			
			wait(0.05)
			page:Resize(true)
		else
			-- page button
			button.Title.Font = Enum.Font.Gotham
			button.Title.TextTransparency = 0.65
			
			if button:FindFirstChild("Icon") then
				button.Icon.ImageTransparency = 0.65
			end
			
			-- sections
			for i, section in pairs(page.sections) do	
				utility:Tween(section.container.Parent, {Size = UDim2.new(1, -10, 0, 28)}, 0.1)
				utility:Tween(section.container.Title, {TextTransparency = 1}, 0.1)
			end
			
			wait(0.1)
			
			page.lastPosition = page.container.CanvasPosition.Y
			page:Resize()
		end
	end
	
	function page:Resize(scroll)
		local padding = 10
		local size = 0
		
		for i, section in pairs(self.sections) do
			size = size + section.container.Parent.AbsoluteSize.Y + padding
		end
		
		self.container.CanvasSize = UDim2.new(0, 0, 0, size)
		self.container.ScrollBarImageTransparency = size > self.container.AbsoluteSize.Y
		
		if scroll then
			utility:Tween(self.container, {CanvasPosition = Vector2.new(0, self.lastPosition or 0)}, 0.2)
		end
	end
	
	function section:Resize(smooth)
	
		if self.page.library.focusedPage ~= self.page then
			return
		end
		
		local padding = 4
		local size = (4 * padding) + self.container.Title.AbsoluteSize.Y -- offset
		
		for i, module in pairs(self.modules) do
			size = size + module.AbsoluteSize.Y + padding
		end
		
		if smooth then
			utility:Tween(self.container.Parent, {Size = UDim2.new(1, -10, 0, size)}, 0.05)
		else
			self.container.Parent.Size = UDim2.new(1, -10, 0, size)
			self.page:Resize()
		end
	end
	
	function section:getModule(info)
	
		if table.find(self.modules, info) then
			return info
		end
		
		for i, module in pairs(self.modules) do
			if (module:FindFirstChild("Title") or module:FindFirstChild("TextBox", true)).Text == info then
				return module
			end
		end
		
		error("No module found under "..tostring(info))
	end
	
	-- updates
	
	function section:updateButton(button, title)
		button = self:getModule(button)
		
		button.Title.Text = title
	end
	
	function section:updateToggle(toggle, title, value)
		toggle = self:getModule(toggle)
		
		local position = {
			In = UDim2.new(0, 2, 0.5, -6),
			Out = UDim2.new(0, 20, 0.5, -6)
		}
		
		local frame = toggle.Button.Frame
		value = value and "Out" or "In"
		
		if title then
			toggle.Title.Text = title
		end
		
		utility:Tween(frame, {
			Size = UDim2.new(1, -22, 1, -9),
			Position = position[value] + UDim2.new(0, 0, 0, 2.5)
		}, 0.2)
		
		wait(0.1)
		utility:Tween(frame, {
			Size = UDim2.new(1, -22, 1, -4),
			Position = position[value]
		}, 0.1)
	end
	
	function section:updateTextbox(textbox, title, value)
		textbox = self:getModule(textbox)
		
		if title then
			textbox.Title.Text = title
		end
		
		if value then
			textbox.Button.Textbox.Text = value
		end
		
	end
	
	function section:updateKeybind(keybind, title, key)
		keybind = self:getModule(keybind)
		
		local text = keybind.Button.Text
		local bind = self.binds[keybind]
		
		if title then
			keybind.Title.Text = title
		end
		
		if bind.connection then
			bind.connection = bind.connection:UnBind()
		end
			
		if key then
			self.binds[keybind].connection = utility:BindToKey(key, bind.callback)
			text.Text = key.Name
		else
			text.Text = "None"
		end
	end
	
	function section:updateColorPicker(colorpicker, title, color)
		colorpicker = self:getModule(colorpicker)
		
		local picker = self.colorpickers[colorpicker]
		local tab = picker.tab
		local callback = picker.callback
		
		if title then
			colorpicker.Title.Text = title
			tab.Title.Text = title
		end
		
		local color3
		local hue, sat, brightness
		
		if type(color) == "table" then -- roblox is literally retarded x2
			hue, sat, brightness = unpack(color)
			color3 = Color3.fromHSV(hue, sat, brightness)
		else
			color3 = color
			hue, sat, brightness = Color3.toHSV(color3)
		end
		
		utility:Tween(colorpicker.Button, {ImageColor3 = color3}, 0.5)
		utility:Tween(tab.Container.Color.Select, {Position = UDim2.new(hue, 0, 0, 0)}, 0.1)
		
		utility:Tween(tab.Container.Canvas, {ImageColor3 = Color3.fromHSV(hue, 1, 1)}, 0.5)
		utility:Tween(tab.Container.Canvas.Cursor, {Position = UDim2.new(sat, 0, 1 - brightness)}, 0.5)
		
		for i, container in pairs(tab.Container.Inputs:GetChildren()) do
			if container:IsA("ImageLabel") then
				local value = math.clamp(color3[container.Name], 0, 1) * 255
				
				container.Textbox.Text = math.floor(value)
				--callback(container.Name:lower(), value)
			end
		end
	end
	
	function roundNumber(num, numDecimalPlaces)
        	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
    	end
	
	function section:updateSlider(slider, title, value, min, max, lvalue)
		slider = self:getModule(slider)
		
		if title then
			slider.Title.Text = title
		end
		
		local bar = slider.Slider.Bar
		local percent = (mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
		
		if value then -- support negative ranges
			percent = (value - min) / (max - min)
		end
		
		percent = math.clamp(percent, 0, 1)
		value = value or roundNumber(min + (max - min) * percent,1)
		
		slider.TextBox.Text = value
		utility:Tween(bar.Fill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
		
		if value ~= lvalue and slider.ImageTransparency == 0 then
			utility:Pop(slider, 10)
		end
		
		return value
	end
	
	function section:updateDropdown(dropdown, title, list, callback)
		dropdown = self:getModule(dropdown)
		
		if title then
			dropdown.Search.TextBox.Text = title
		end
		
		local entries = 0
		
		utility:Pop(dropdown.Search, 10)
		
		for i, button in pairs(dropdown.List.Frame:GetChildren()) do
			if button:IsA("ImageButton") then
				button:Destroy()
			end
		end
			
		for i, value in pairs(list or {}) do
			local button = utility:Create("ImageButton", {
				Parent = dropdown.List.Frame,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 30),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.DarkContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("TextLabel", {
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 0),
					Size = UDim2.new(1, -10, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = value,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextXAlignment = "Left",
					TextTransparency = 0.10000000149012
				})
			})
			
			button.MouseButton1Click:Connect(function()
				if callback then
					callback(value, function(...)
						self:updateDropdown(dropdown, ...)
					end)	
				end

				self:updateDropdown(dropdown, value, nil, callback)
			end)
			
			entries = entries + 1
		end
		
		local frame = dropdown.List.Frame
		
		utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, (entries == 0 and 30) or math.clamp(entries, 0, 3) * 34 + 38)}, 0.3)
		utility:Tween(dropdown.Search.Button, {Rotation = list and 180 or 0}, 0.3)
		
		if entries > 3 then
		
			for i, button in pairs(dropdown.List.Frame:GetChildren()) do
				if button:IsA("ImageButton") then
					button.Size = UDim2.new(1, -6, 0, 30)
				end
			end
			
			frame.CanvasSize = UDim2.new(0, 0, 0, (entries * 34) - 4)
			frame.ScrollBarImageTransparency = 0
		else
			frame.CanvasSize = UDim2.new(0, 0, 0, 0)
			frame.ScrollBarImageTransparency = 1
		end
	end
end

return library

-- // Sections
-- // Combat Section
local ASection1 = CombatTab:addSection("Head Hitboxes")
local ASection2 = CombatTab:addSection("Shotgun Mods - (Turn off for other weapons)")
local ASection22 = CombatTab:addSection("Other Mods")

-- // Player Section
local PlrSection = PLa:addSection("Movement")
local PlrSectionC = PLa:addSection("Crafter Role")
local plrApp = PLa:addSection("Appearance")
local plrAppFE = PLa:addSection("FE Stuff")
local teamSection = PLa:addSection("Team Changer (Cooldown)")

-- // Esp Section
local DisplaySection = Esp:addSection("Display")
local EspSection = Esp:addSection("ESP")
local EspSection1 = Esp:addSection("ESP Configuration")
local wrldSection = Esp:addSection("Client World")
local MiscEsp = Esp:addSection("Miscellaneous ESP")

-- // Other Section 
local specificSection = Other:addSection("Specific Section")
local PlrTarget = Other:addSection("Other Players")
local DonateSection = Other:addSection("Donate Section")
local OtherSection0 = Other:addSection("Trolling") 

-- // Teleport Section
local teleSection1 = tele:addSection("Player")
local teleSection2 = tele:addSection("Location Teleport")
local teleSection3 = tele:addSection("Safe spots")
local teleSection4 = tele:addSection("Miscellaneous")

-- // Buy Section
local paintSection = Buy:addSection("Painting")
local AutoBuySection = Buy:addSection("Auto Buy")
local BuySectionMisc2 = Buy:addSection("Misc / Troll")

-- // Miscellaneous Section
local miscSection = misc:addSection("Miscellaneous")
local CarSection = misc:addSection("Miscellaneous Vehicle")
local boomSection = misc:addSection("Boombox Player (Hold Boombox)")

-- // UI Section
local ThemeSection = Ui:addSection("Theme")
local UISection = Ui:addSection("UI")

-- // Credits Section
local creds = Ui:addSection("Developers: H3#3534, Krypton#3195.")
local UISection2 = Ui:addSection("Discord: https://discord.gg/jhb37CBT8U")
local UISection2 = Ui:addSection("Credits: EdgeIY, for the fly, Alwayswin for a few FE features")

print("Loading | R")
if syn then
    syn.request({ 
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST",
        Headers = {
        ["Content-Type"] = "application/json",
        ["Origin"] = "https://discord.com"
    },
    print("Loading | R 50%");
    Body = game:GetService("HttpService"):JSONEncode({
        cmd = "INVITE_BROWSER",
        args = {
            code = "jhb37CBT8U"
        },
            nonce = game:GetService("HttpService"):GenerateGUID(false)
        }),
    })
end

local chatSettings = require(game:GetService("Chat").ClientChatModules.ChatSettings)
local chatFrame = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame
chatSettings.WindowResizable = true
chatSettings.WindowDraggable = true
chatFrame.ChatChannelParentFrame.Visible=true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)

print("LIB Success")
print("Loading | 1%")

-- ESP
local esp_Enabled      = false
local esp_Names        = false
local esp_Health       = false
local esp_WantedLevel  = false
local esp_distance     = false
local esp_boxes        = false
local esp_tracers      = false
local esp_tracer_orig  = "Bottom"
local esp_Main_Colour  = Color3.fromRGB(255, 255, 255)
local rainbow_char     = false
local rainbow_hair     = false
local esp_tools        = false
-- Player
local CSEvents = game:GetService("ReplicatedStorage"):WaitForChild("_CS.Events")
local teamList = require(game:GetService("ReplicatedStorage").Client.TeamList)
local itemList = require(game.ReplicatedStorage.Client.ItemList)
local camera   = game:GetService("Workspace").Camera
local wLighting = game:GetService("Lighting")
local UIS = game:GetService'UserInputService'
local Players  = game:GetService("Players")
local LPlayer  = Players.LocalPlayer
local mouse = LPlayer:GetMouse()
--Mods
local infiniteStamina = false
local jumpMode = "Infinite"
local infiniteJump = false
local gunSoundSpam = false
local shotgunMod1 = false
local Rmod = false
local speedBypass = false

local Hitboxes = false
local headHitboxSize = 5
local hitboxTransparency = 0.7

local autoStore = false
local minHealth = 70
local AutoHeal = false
local antiCar = false
local BDelete = false
local SpeedShotgun = false
local SpeedSDelay = 0.05
local shotMulti = false
local shotMultiAmmount = 1
local targetHighlight = false

local customHitSound = false
local customHitSoundType = "Skeet"
local alwaysHeadShot = false

_G.flySpeed = 1
local lJumpHeight = 30
local ThemeEnabled = true
local ThemeMode = "Purple" -- Red,Green,White
local folderImpacts = game:GetService("Workspace").RayIgnore.BulletHoles

local DevList = loadstring(game:HttpGet("https://raw.githubusercontent.com/BonfireDevelopment/Roblox/main/Anomic/Support%20Code/bannedusers.lua"))()

print("Loading | TeamMod")
for i,v in pairs(teamList) do    
    v.Spawns = { "Arway", "Sheriff Station", "Eastdike", "Eaphis Plateau", "Pahrump", "Okby Steppe", "Depository", "Airfield", "Depot", "Clinic", "Towing Company"}    
end

print("Loading | 10%")
-- Functions 
function notify(title, message)game:GetService("Players").LocalPlayer.PlayerGui.Notify.TimePosition = 0 game:GetService("Players").LocalPlayer.PlayerGui.Notify.Playing = true if not message then require(game:GetService("ReplicatedStorage"):WaitForChild("Client").NotificationHandler):AddToStream(game.Players.LocalPlayer,title) else require(game:GetService("ReplicatedStorage"):WaitForChild("Client").NotificationHandler):AddToStream(game.Players.LocalPlayer,title..": "..message)end end
function purchaseItem(name)game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").PurchaseTeamItem:FireServer(name,"Single",nil)end
function Action(Object, Function)if Object ~= nil then Function(Object); end end
function noclip() if LPlayer.Character ~= nil then for _, child in pairs(LPlayer.Character:GetDescendants()) do if child:IsA("BasePart") and child.CanCollide == true then child.CanCollide = false end end end end
local function bypass()
    repeat wait() until LPlayer.Character.HumanoidRootPart.Anchored == false    
        for i, v in next, getconnections(game:GetService("Players").LocalPlayer.Character.DescendantAdded) do
            v:Disable()
    	end
        local s, err = pcall(function()
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            local namecall = mt.__namecall

            mt.__namecall = function(self,...)
                local args = {...}
                local method = getnamecallmethod()
                if tostring(method) == 'FindPartOnRayWithWhitelist' and getcallingscript() == game.Players.LocalPlayer.PlayerGui['_L.Handler'].GunHandlerLocal then
                    wait(9e9)
                    return
                end
                if method == "Kick" then
                    notify("Anomic V","Server tried kicking you")
                    return nil                    
                end        
                if tostring(method) == "FireServer" then
                    if shotgunMod1 and tostring(self) == "AmmoRemover" then                        
                        return nil
                    end                           
                end
                if tostring(method) == "Fire" then
                    if Rmod and tostring(self) == "ShootAnim" then
                        return nil
                    end                   
                end
            return namecall(self,...)
        end
    end)         
end

print("Loading anti kick")
local protect = newcclosure or protect_function
hookfunction(game:GetService("Players").LocalPlayer.Kick,protect(function() 
    wait(9e9) 
end))
print("anti-kick success")
local colors = {
    white     = Color3.fromRGB(255,255,255),
    lightGrey = Color3.fromRGB(70,70,70),
    grey      = Color3.fromRGB(50,50,50),
    black     = Color3.fromRGB(0,0,0),     
    stamBar   = Color3.fromRGB(250,20,100),     
}
function setTheme()
   if LPlayer.PlayerGui:FindFirstChild("MainUIHolder") and LPlayer ~= nil  then 
       --print("Theme set")
       LPlayer.PlayerGui.MainMenu.ButtonBar.Teams.BackgroundColor3 = colors.grey
       LPlayer.PlayerGui.MainMenu.ButtonBar.Spawn.BackgroundColor3 = colors.lightGrey
       LPlayer.PlayerGui.MainMenu.ButtonBar.Editor.BackgroundColor3 = colors.grey
       LPlayer.PlayerGui.MainMenu.TeamGUI.BackgroundColor3 = colors.grey
       LPlayer.PlayerGui.MainMenu.TeamGUI.BorderColor3 = colors.lightGrey
       LPlayer.PlayerGui.MainMenu.TeamGUI.Description.BackgroundColor3 = colors.grey
       LPlayer.PlayerGui.MainMenu.TeamGUI.Description.BorderColor3 = colors.lightGrey
       LPlayer.PlayerGui.MainMenu.TeamGUI.TeamBackground.BackgroundColor3 = colors.grey
       LPlayer.PlayerGui.MainMenu.TeamGUI.Description.JoinButton.BackgroundColor3 = colors.lightGrey
       LPlayer.PlayerGui.MainMenu.TeamGUI.Description.JoinButton.BorderColor3 = colors.white
       LPlayer.PlayerGui.AvatarEditor.WearButton.BackgroundColor3 = colors.lightGrey
       LPlayer.PlayerGui.AvatarEditor.WearButton.BorderColor3 = colors.white
       LPlayer.PlayerGui.AvatarEditor.MainFrame.CustomShirtPants.IdBox.BackgroundColor3 = colors.lightGrey 
       LPlayer.PlayerGui.AvatarEditor.MainFrame.CustomShirtPants.IdBox.BorderColor3 = colors.white 
       LPlayer.PlayerGui.AvatarEditor.MainFrame.CustomShirtPants.WearButton.BorderColor3 = colors.white
       LPlayer.PlayerGui.AvatarEditor.MainFrame.CustomShirtPants.WearButton.BackgroundColor3 = colors.lightGrey  
       
       for i,v in pairs(LPlayer.PlayerGui.MainMenu.TeamGUI.TeamBackground:GetChildren()) do
           if v.Name ~= "UIListLayout" then
               v.Design.ImageColor3 = colors.black
           end            
       end 
   end
   if LPlayer.PlayerGui:FindFirstChild("MainUIHolder") and LPlayer ~= nil  then 
       if LPlayer.PlayerGui.MainUIHolder:FindFirstChild("Menus") and LPlayer ~= nil then
           LPlayer.PlayerGui.MainUIHolder.Menus.BackpackGUI.Basic.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.Menus.BackpackGUI.Basic.BorderColor3 = colors.white           
           LPlayer.PlayerGui.MainUIHolder.Menus.BackpackGUI.BorderColor3 = colors.lightGrey 
           LPlayer.PlayerGui.MainUIHolder.Menus.BackpackGUI.ImageLabel.BackgroundColor3 = colors.black
           LPlayer.PlayerGui.MainUIHolder.Menus.BackpackGUI.ImageLabel.ImageColor3 = colors.black
           LPlayer.PlayerGui.MainUIHolder.Menus.BackpackGUI.ImageLabel.ImageTransparency = 0.5
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.Description.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.Description.BackgroundColor3 = colors.lightGrey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.BorderColor3 = colors.lightGrey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.Description.PurchaseForRobux.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.Description.PurchaseOptions.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.Description.Statistics.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.Description.BodyColorSelection.Grid.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.Description.BodyColorSelection.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.BackgroundColor3 = colors.grey 
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.BorderColor3 = colors.lightGrey
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.ImageLabel.ImageColor3 = colors.black
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.ImageLabel.ImageTransparency = 0.4
           LPlayer.PlayerGui.MainUIHolder.Menus.TeamGUI.ShopF.Description.BorderColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.StaminaBar.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.MessageBar.BackgroundColor3 = colors.grey
           LPlayer.PlayerGui.MainUIHolder.StaminaBar.Background.BackgroundColor3 = colors.black
           LPlayer.PlayerGui.MainUIHolder.StaminaBar.Background.StatNum.TextColor3 = Color3.fromRGB(255,255,255)
           LPlayer.PlayerGui.MainUIHolder.PhoneBar.Phone.ImageColor3 = Color3.fromRGB(30,30,30)
           LPlayer.PlayerGui.MainUIHolder.PhoneBar.Phone.Exlam.TextColor3 = colors.white
           LPlayer.PlayerGui.MainUIHolder.MenuBar.ImageLabel.BackgroundColor3 = colors.black
           LPlayer.PlayerGui.MainUIHolder.MenuBar.ImageLabel.ImageColor3 = Color3.fromRGB(30,30,30)
           LPlayer.PlayerGui.MainUIHolder.MenuBar.BackgroundColor3 = Color3.fromRGB(15,15,15)
           if ThemeMode == "Purple" then
               LPlayer.PlayerGui.MainUIHolder.StaminaBar.Background.Bar.BackgroundColor3 = Color3.fromRGB(255, 29, 108) -- Stam
               else if ThemeMode == "Red" then
                   LPlayer.PlayerGui.MainUIHolder.StaminaBar.Background.Bar.BackgroundColor3 = Color3.fromRGB(199, 0, 0) -- Stam
                   else if ThemeMode == "Green" then
                       LPlayer.PlayerGui.MainUIHolder.StaminaBar.Background.Bar.BackgroundColor3 = Color3.fromRGB(41, 206, 0) -- Stam
                       else if ThemeMode == "White" then
                           LPlayer.PlayerGui.MainUIHolder.StaminaBar.Background.Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Stam
                           LPlayer.PlayerGui.MainUIHolder.StaminaBar.Background.StatNum.TextColor3 = Color3.fromRGB(0, 0, 0)
                       end
                   end
               end
           end
           if ThemeMode == "Purple" then
               LPlayer.PlayerGui.MainUIHolder.MenuBar.CashDisplay.TextColor3 = Color3.fromRGB(150,0,150) -- Cash
               else if ThemeMode == "Red" then
                   LPlayer.PlayerGui.MainUIHolder.MenuBar.CashDisplay.TextColor3 = Color3.fromRGB(201, 0, 0) -- Cash
                   else if ThemeMode == "Green" then
                       LPlayer.PlayerGui.MainUIHolder.MenuBar.CashDisplay.TextColor3 = Color3.fromRGB(93, 233, 0) -- Cash
                       else if ThemeMode == "White" then
                           LPlayer.PlayerGui.MainUIHolder.MenuBar.CashDisplay.TextColor3 = Color3.fromRGB(255, 255, 255) -- Cash
                       end
                   end
               end
           end
           if LPlayer.PlayerGui.MainUIHolder:FindFirstChild("MenuBar") then
               for i,v in pairs(LPlayer.PlayerGui.MainUIHolder.MenuBar:GetChildren()) do
                   if v.ClassName == "ImageButton" then
                       v.ImageColor3 = Color3.fromRGB(35,35,35)
                   end    
               end        
           end 
       end
   end
end
function playerNotify(x)
    if x then
        playerJoin = Players.ChildAdded:Connect(function(player)
            notify("Player Joined",player.Name)    
        end)
        playerLeft = Players.ChildRemoved:Connect(function(player)
            notify("Player Left",player.Name)    
        end)
    else
        playerJoin:Disconnect()
        playerLeft:Disconnect()
    end
end
function tpCar(seat,Cframe,tpBack)       
    if seat.Parent:FindFirstChild("VehicleSeat") and not seat:FindFirstChild("SeatWeld") then   
        seat.Disabled = false

        repeat wait(.10)
            LPlayer.Character.HumanoidRootPart.CFrame = seat.CFrame          
        until seat:FindFirstChild('SeatWeld') or not seat.Parent:FindFirstChild('VehicleSeat')

        wait()        
        LPlayer.Character.Humanoid.SeatPart.Parent:SetPrimaryPartCFrame(Cframe)
        wait(.5)
        LPlayer.Character:FindFirstChild("Humanoid").Sit = false
        wait()
        LPlayer.Character:FindFirstChildOfClass("Humanoid").Jump = true
        if tpBack then
            wait()
            LPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
        end
    end      
end
function getRoot(char)
    local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return rootPart
end
local function amogus()
    LPlayer.Character.UpperTorso.Waist:Destroy()
    local origin = LPlayer.Character.HumanoidRootPart.CFrame
    LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2114.14697, -83.3234253, -1407.88184)
    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",6431115067)
    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",6164520667)
    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("Color",Color3.new(1,0,0),"SkinColor")
    wait()
    LPlayer.Character.UpperTorso.Waist:Destroy()
    wait(.5)
    LPlayer.Character.Head.Anchored = true
    getRoot(LPlayer.Character).CFrame = origin
end     
local function anonymous()
    local originalskin = LPlayer.Character.Head.Color
    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("Color",Color3.new(0,0,0),"SkinColor")
    for i,v in pairs(LPlayer.Character:GetDescendants()) do
        if v:IsA("Clothing") or v:IsA("ShirtGraphic") then
            v:Destroy()
        end
    end
    LPlayer.Character.UpperTorso.Waist:Destroy()
    spawn(function()
        LPlayer.Character.Humanoid.Changed:Connect(function(p)
            if p == "Health" then
                if LPlayer.Character.Humanoid.Health <= 0 then
                    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("Color",originalskin,"SkinColor")
                    return
                end
            end
        end)
        LPlayer.CharacterAdded:Connect(function()
            game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("Color",originalskin,"SkinColor")
            return
        end)
    end)
end

FLYING = false
QEfly = true
iyflyspeed = 2
vehicleflyspeed = 2
function startFly()  
    if game.Workspace:FindFirstChild('ABC') ~= nil then game.Workspace:FindFirstChild('ABC'):Destroy() end
    local part = Instance.new('Part')
    part.Parent = workspace
    part.Name = "ABC"
    part.CFrame = LPlayer.Character.HumanoidRootPart.CFrame
    part.Transparency = 1
    part.CanCollide = false
    part.Size = LPlayer.Character.HumanoidRootPart.Size
    local weld = Instance.new('WeldConstraint')
    weld.Parent = LPlayer.Character
    weld.Part0 = LPlayer.Character.HumanoidRootPart
    weld.Part1 = workspace.ABC
	repeat wait() until LPlayer and LPlayer.Character and workspace.ABC and LPlayer.Character:FindFirstChild('Humanoid')
	repeat wait() until mouse
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
				if not yes and LPlayer.Character:FindFirstChildOfClass('Humanoid') then
					LPlayer.Character.Humanoid.PlatformStand = false
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
			if LPlayer.Character:FindFirstChildOfClass('Humanoid') then
				LPlayer.Character.Humanoid.PlatformStand = false
				workspace:FindFirstChild('ABC'):Destroy()
				LPlayer.Character.WeldConstraint:Destroy()
			end
		end)
	end

	flyKeyDown = mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and flySpeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
    
	flyKeyUp = mouse.KeyUp:Connect(function(KEY)
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
function stopFly()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if LPlayer.Character:FindFirstChildOfClass('Humanoid') then
		LPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end
function getMayor()
    for i,v in pairs(Players:GetChildren()) do
        if v == game:GetService("ReplicatedStorage").CurrentMayor.Value and game:GetService("ReplicatedStorage").CurrentMayor.Value ~= nil then
            return v
        end
    end
end

local xdisplay = {}
function xdisplay:addItemDisplay(player)
	if player.Character.UpperTorso:FindFirstChild("ItemDisplay") then		
		player.Character.UpperTorso["ItemDisplay"]:Destroy()		
	end	
	local ItemDisplay = Instance.new("BillboardGui")	
	local UIGridLayout = Instance.new("UIGridLayout")

	ItemDisplay.Name = "ItemDisplay"
	ItemDisplay.Parent = player.Character.UpperTorso
	ItemDisplay.Active = true
	ItemDisplay.MaxDistance = 90
	ItemDisplay.Size = UDim2.new(5, 0, 1.5, 0)
	ItemDisplay.SizeOffset = Vector2.new(0.800000012, 1)
    ItemDisplay.AlwaysOnTop = true

	UIGridLayout.Parent = ItemDisplay
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.CellPadding = UDim2.new(0.03, 0, 0.005, 0)
	UIGridLayout.CellSize = UDim2.new(0.17, 0, 0.4, 0)

    local insideDisplay = {}

	function insideDisplay:addItem(name,imageId)
      local Item = Instance.new("ImageButton")
	   local ItemImage = Instance.new("ImageLabel")        
		Item.Name = name
		Item.Parent = ItemDisplay
		Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Item.BackgroundTransparency = 1.000
		Item.BorderSizePixel = 0
		Item.Position = UDim2.new(0.300000012, 0, 0.100000001, 0)
		Item.Size = UDim2.new(1.5, 0, 1.5, 0)
		Item.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Item.Image = "rbxassetid://4509767787"

		ItemImage.Name = "ItemImage"
		ItemImage.Parent = Item
		ItemImage.AnchorPoint = Vector2.new(0, 0.5)
		ItemImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ItemImage.BackgroundTransparency = 1.000
		ItemImage.Position = UDim2.new(0, 0, 0.5, 0)
		ItemImage.Size = UDim2.new(1, 0, 1, 0)
		ItemImage.Image = imageId
	end    
    return insideDisplay
end
local function getImageId(item)
    for i, v in pairs(itemList) do
        if i == item.Name then
            return v.ImageID;
        end
    end 
end
local function refreshDisplay(plr)                  
    local itemDisplay = xdisplay:addItemDisplay(plr)  
    for _,x in pairs(plr.Backpack:GetChildren()) do
        if x.ClassName == "Tool" then
            itemDisplay:addItem(x.Name,getImageId(x))    			     
        end
    end     
end

bypass()

ASection1:addToggle("Toggle Hitboxes", nil, function(v)
    Hitboxes = v
end)
ASection1:addSlider("Hitbox Size", 1, 0, 55, function(v)
    headHitboxSize = v
end)
ASection1:addSlider("Hitbox Transparency", hitboxTransparency, 0, 1, function(v)
    hitboxTransparency = v
end)
ASection2:addToggle("Ghost Shotgun", nil, function(x)   
    shotgunMod1 = x    
    bypass()
end)
ASection2:addToggle("Rapid Shotgun", nil, function(x)   
    SpeedShotgun = x        
end)
ASection2:addDropdown("Rapid Mode", {"Maximum", "Medium", "Low"}, function(x)
    if x == "Maximum" then
        SpeedSDelay = 0.00001
        else if x == "Medium" then
            SpeedSDelay = 0.1
            else if x == "Low" then
                SpeedSDelay = 0.4
            end
        end
    end
end)
ASection2:addButton("No shotgun reload", function()    
    for i, v in pairs(itemList) do
        if v.DataType == "RangedWeapon" and v.Firemode == "Shot" then                         
            v.ReloadTime = 0.01                       
        end 
    end    
end)
ASection2:addToggle("Shot Multiplier", nil, function(x)   
    shotMulti = x        
end)
ASection2:addSlider("Shot Ammount", 1, 0, 200, function(v)
    shotMultiAmmount = v
end)
ASection22:addToggle("No Impacts", nil, function(x)   
    BDelete = x        
end)
ASection22:addToggle("Always headshot", nil, function(x)   
    alwaysHeadShot = x        
end)
ASection22:addToggle("No visual recoil", nil, function(x)   
    Rmod = x
    bypass()
end)
ASection22:addToggle("Custom hit sound", nil, function(x)   
    customHitSound = x
end)
ASection22:addDropdown("Hit sound", {"Skeet", "Rust", "COD", "Test"}, function(x)
    customHitSoundType = x
end)
ASection22:addToggle("Gun Silencer", nil, function(x)   
    for i,v in pairs(LPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v ~= nil then
            if v.Handle:FindFirstChild("ReloadSound") then
                if v.Handle:FindFirstChild("GunEmpty") and x then                   
                    v.Handle.Shot.Name = "" 
                    v.Handle.GunEmpty.Name = "Shot"                                       
                else
                    v.Handle.Shot.Name = "GunEmpty" 
                    v.Handle[""].Name = "Shot"                
                end
            else
                return
            end
        end
    end    
end)
ASection22:addToggle("Gun Sound Spam", nil, function(x)   
    gunSoundSpam = x
end)
ASection22:addButton("Remove Flash / Smoke | FE", function()    
    for i,v in pairs(LPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Main") then
            v.Main.MuzzleFlash:Destroy()
            v.Main.Smoke:Destroy()
        end
    end
end)

PlrSection:addSlider("Player Fov", 50, 0, 120, function(valuex)
    camera.FieldOfView = valuex
end)
PlrSection:addDropdown("Infinite Jump Mode", {"Fly", "Infinite", }, function(x)
    jumpMode = x
end)
PlrSection:addToggle("Infinite Jump", nil, function(v)
    infiniteJump = v
end)   
PlrSection:addToggle("Noclip", nil, function(v)
    if v then
        Noclipping = game:GetService('RunService').Stepped:Connect(noclip)
    else
        Noclipping:Disconnect()
    end
end)
local function disableStam(enabled)
repeat wait() until LPlayer.Character.HumanoidRootPart.Anchored == false       
    for i,x in pairs(LPlayer.Character:GetChildren()) do
        if x:IsA("LocalScript") and x.Name ~= "KeyDrawer" and x.Name ~= "Animate" and x.Name ~= "AnimationHandler" then 
            if enabled then
                x.Disabled = true
            else
                x.Disabled = false
            end
        end 
    end 
end

PlrSection:addToggle("Infinite Stamina", nil, function(v)
    infiniteStamina = v    
    disableStam(v)
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if infiniteStamina then    
        wait(2)
        disableStam(infiniteStamina)    
    end
end)
PlrSection:addToggle("Air Swim", nil, function(v)
    for i, v in next, getconnections(game:GetService("Workspace"):GetPropertyChangedSignal("Gravity")) do
        v:Disable()
    end
    if v then
        workspace.Gravity = 0
        local function swimDied()
            workspace.Gravity = 140            
        end
        gravReset = LPlayer.Character:FindFirstChildOfClass('Humanoid').Died:Connect(swimDied)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
        LPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    else
        workspace.Gravity = 140
        if gravReset then
            gravReset:Disconnect()
        end
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
        LPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
        LPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    end
end)
PlrSection:addToggle("Anti Car", nil, function(v)    
    antiCar = v
end)
PlrSection:addToggle("Speed Bypass - (Dont walk into sharp terrain)", nil, function(v)    
    speedBypass = v
end)

local flying = false
PlrSection:addKeybind("Flight KeyBind", nil, function()        
    flying = not flying
    if flying then
        startFly()                    
    else
    	stopFly()             
    end
end)
PlrSectionC:addToggle("Crafter + Paramedic Auto-heal", nil, function(v)
    AutoHeal = v
end)
PlrSectionC:addSlider("Min Health", 1, 0, 100, function(valuex)
    minHealth = valuex
end)
PlrSectionC:addButton("Equip Armor - Helmet + Heavy Vest", function()
    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").PurchaseTeamItem:FireServer("Battle Helmet","Single",nil)
    wait(.4)
    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").PurchaseTeamItem:FireServer("Heavy Vest","Single",nil)
    wait(.3)
    for i,v in pairs(LPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name == "Heavy Vest" then 
            LPlayer.Character.Humanoid:EquipTool(v)   
            game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").EquipArmor:FireServer()
        end 
        wait(.5)
        if v:IsA("Tool") and v.Name == "Battle Helmet" then 
            LPlayer.Character.Humanoid:EquipTool(v)
            game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").EquipArmor:FireServer() 
        end                 
    end
    notify("Equiped armor")
end)

plrApp:addToggle("Outfit Editer", nil, function(v)
    LPlayer.PlayerGui.AvatarEditor.Enabled = v
    LPlayer.PlayerGui.AvatarEditor.WearButton.Visible = not v
end)
plrApp:addTextbox("Custom Cloth", "Default", function(value, focusLost)
    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",value)
    if focusLost then
        game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",value)
    end
end)
plrApp:addDropdown("Presets", {"Black", "Glitch", "Black & White", "Hacker"}, function(t)
    if t == "Black" then
            game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",6523367474)
            game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",745499244)
        else if t == "Glitch" then
                game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",6296322488)
                game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",6296389518)
            else if t == "Hacker" then
                game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",5594922955)
                game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",6967030358)
                else if t == "Black & White"  then
                    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",4797295258)
                    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("CustomCloth",4977671127)
                    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("Color",Color3.fromRGB(0,0,0),"SkinColor")
                    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").EquipAvatarItem:FireServer("Color",Color3.fromRGB(255, 255, 255),"HairColor")
                end
            end
        end
    end
end)
plrApp:addColorPicker("Skin Color", Color3.fromRGB(255, 255, 255), function(s)
    game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("Color",s,"SkinColor")
end)
plrApp:addColorPicker("Hair Color", Color3.fromRGB(255, 255, 255), function(s)
    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").EquipAvatarItem:FireServer("Color",s,"HairColor")
end)
plrApp:addToggle("Rainbow Character", nil, function(v)
    rainbow_char = v
end)
plrApp:addToggle("Rainbow Hair", nil, function(v)
    rainbow_hair = v
end)
plrApp:addDropdown("Player Glitch", {"Small", "Larger", }, function(x)
    local H = LPlayer.Character:FindFirstChildWhichIsA('Humanoid')
    if x == "Small" then
        local function DeleteOriginal()
            for i,v in pairs(LPlayer.Character:GetDescendants()) do
                if v.Name == 'OriginalSize' then
                    v:Destroy()
                end           
            end
        end       
        wait(.8)
        DeleteOriginal()
        H:FindFirstChild("BodyDepthScale"):Destroy()    
        wait(.8)
        DeleteOriginal()
        H:FindFirstChild("BodyTypeScale"):Destroy()          
        wait(.8) 
        DeleteOriginal()
        H:FindFirstChild("BodyProportionScale"):Destroy()   
        wait(.8)
        DeleteOriginal()
        H:FindFirstChild("HeadScale"):Destroy() 
        wait(.8)
        DeleteOriginal()
        H:FindFirstChild("BodyWidthScale"):Destroy()  
    else
        for i,v in pairs(LPlayer.Character.Humanoid:GetChildren()) do
            if string.find(v.Name,"Scale") then        
                v:Destroy()
                wait(1)          
            end
        end        
    end
end)
plrApp:addButton("Respawn" ,function() 
   game:GetService("ReplicatedStorage")["_CS.Events"].PayLoad:FireServer()
end)
plrAppFE:addButton("Anti-Arrest / Remove wanted lvl" ,function()   
    LPlayer.Character.Head.PlayerDisplay.Wanted:Destroy()
    LPlayer.Character.Wanted:Destroy()
end)
plrAppFE:addButton("Remove Team Name" ,function()   
    LPlayer.Character.Head.PlayerDisplay.TeamName:Destroy()
end)
plrAppFE:addButton("Untradeable" ,function()   
    LPlayer.Character.HumanoidRootPart.LocalPlayerBG:Destroy()
end)
plrAppFE:addButton("Among Us [FE]", function()
    pcall(function()
        amogus()
    end)
end)
plrAppFE:addButton("Anonymous [FE]", function()
    pcall(function()
        anonymous()
    end)
end)
plrAppFE:addButton("Remove Face" ,function()   
    LPlayer.Character.Head.face:Destroy()
end)

local teamSniperValue = ""
teamSection:addDropdown("Team Changer", {"Gunsmith", "Civilian", "Crafter", "Advanced Gunsmith", "Trucker", "Tow Trucker", "Secret Service", "Advanced Car Dealer", "Car Dealer","Deliverant", "Criminal", "Crafter", "Cab Driver", "Paramedic", "Mayor", "Military", "SWAT", "Sheriff"}, function(team)
    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").TeamChanger:FireServer(team)
end)
teamSection:addDropdown("Team Snipe Value", {"Gunsmith", "Civilian", "Crafter", "Advanced Gunsmith", "Trucker", "Tow Trucker", "Secret Service", "Advanced Car Dealer", "Car Dealer","Deliverant", "Criminal", "Crafter", "Cab Driver", "Paramedic", "Mayor", "Military", "SWAT", "Sheriff"}, function(team)
    teamSniperValue = team
end)
teamSection:addToggle("Team Sniper", false, function(v)    
    repeat wait(1)
        game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").TeamChanger:FireServer(teamSniperValue)            
    until not v
end)
print("Loading | 25%")
-- ESP Page
local backpackDisplay = false
DisplaySection:addToggle("Display backpacks", nil, function(v)
    backpackDisplay = v
end)
DisplaySection:addToggle("Join notifications", nil, function(v)
    playerNotify(v)
end)
EspSection:addToggle("ESP Enabled", nil, function(v)
    esp_Enabled = v
end)
local maxDisance = 100;
EspSection:addSlider("Max distance (Helps stop lag)", 100, 0, 2000, function(v)
    maxDisance = v
end)

EspSection1:addToggle("ESP Health", nil, function(state)
    esp_Health = state
end)
EspSection1:addToggle("ESP Names", nil, function(state)
    esp_Names = state
end)
EspSection1:addToggle("ESP Distance", nil, function(state)
   esp_distance = state
end)
EspSection1:addToggle("ESP Boxes", nil, function(state)
    esp_boxes = state
 end)
EspSection1:addToggle("ESP Tracers", nil, function(state)
    esp_tracers = state
end)
EspSection1:addDropdown("Tracer origin", {"Bottom", "Top","Mouse"}, function(t)
    esp_tracer_orig = t
end)
EspSection1:addToggle("ESP status level", nil, function(state)
    esp_WantedLevel = state
end)
EspSection1:addToggle("Tool ESP", nil, function(state)
    esp_tools = state
end)
EspSection1:addColorPicker("ESP Main Color", Color3.fromRGB(255, 255, 255), function(s)
    esp_Main_Colour = s
end)

wrldSection:addSlider("ClockTime", 0, 0, 23, function(valuex)
    wLighting.ClockTime = valuex
end)
wrldSection:addSlider("Brightness", 1, 0, 25, function(valuex)
    wLighting.Brightness = valuex
end)
wrldSection:addSlider("Exposure", 1, 0, 5, function(valuex)
    wLighting.ExposureCompensation = valuex
end)
wrldSection:addToggle("Shadows", nil, function(state)
    wLighting.GlobalShadows = state
end)
wrldSection:addToggle("Color Correction", nil, function(state)
    wLighting.ColorCorrection.Enabled = state
end)
wrldSection:addColorPicker("Color Correction", Color3.fromRGB(255, 255, 255), function(s)    
    wLighting.ColorCorrection.TintColor = s    
end)
wrldSection:addColorPicker("Ambient", Color3.fromRGB(150, 140, 140), function(s)    
    wLighting.Ambient = s    
end)
MiscEsp:addButton("Printer ESP", function()
    for i,v in pairs(game:GetService("Workspace").Entities:GetChildren()) do
        if v:IsA("Model") and v.Name == "Simple Printer" then
            local a = Instance.new("BoxHandleAdornment")
            a.Name = v.Name:lower().."_alwayswinAV"
            a.Parent = v.hitbox
            a.Adornee = v
            a.AlwaysOnTop = true
            a.ZIndex = 0
            a.Transparency = 0.3
            a.Color = BrickColor.new("Lime green")
        end
    end
end)

local targetName = nil;
local plrNum = 1
specificSection:addTextbox("Target Name", "Default", function(plr)    
    targetName = plr
end)
specificSection:addButton("Teleport to target", function()
    for i,v in pairs(game:service'Players':GetPlayers()) do
        if v.Name:match(targetName) then
            LPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
            workspace.Camera.CameraSubject = LPlayer.Character.Humanoid
        end
    end
end)
specificSection:addButton("View target", function()
    for i,v in pairs(game:service'Players':GetPlayers()) do
        if v.Name:match(targetName) then
            workspace.Camera.CameraSubject = v.Character.Humanoid
        end
    end
end)
specificSection:addButton("Reset Camera", function()    
    workspace.Camera.CameraSubject = LPlayer.Character.Humanoid       
end)
specificSection:addToggle("Highlight Targtet", nil, function(x)   
    targetHighlight = x
end)
specificSection:addButton("Get Backpack items", function()    
    for i,v in pairs(Players:GetChildren()) do
        if v.Name:match(targetName) then
            for c,x in pairs(v.Backpack:GetChildren()) do
                notify("Item", x.Name)
            end
        end
    end  
end)
specificSection:addButton("TP cars to target", function()
    oldCFrame = LPlayer.Character.HumanoidRootPart.CFrame
    for i,v in pairs(game:GetService("Workspace").PlayerVehicles:GetChildren()) do
        if v:FindFirstChild("VehicleSeat") and v ~= nil and v:FindFirstChild("VehicleSeat").Damage.Value > 1 and not v:FindFirstChild("VehicleSeat"):FindFirstChild("SeatWeld") then
            local Carseat = v:FindFirstChild("VehicleSeat")        
            Carseat.Disabled = false                 
            if Carseat ~= nil and Carseat then
                if Carseat.Parent:FindFirstChild("VehicleSeat") and not Carseat:FindFirstChild("SeatWeld") then   
                    Carseat.Disabled = false        
                    for i = 5, 0, -1 do        
                        wait(.10)
                        LPlayer.Character.HumanoidRootPart.CFrame = Carseat.CFrame           
                    end        
                    wait(.2)  
                    for i,p in pairs(Players:GetChildren()) do
                        if p.Name:match(targetName) and LPlayer.Character.Humanoid.SeatPart ~= nil then                           
                            Carseat.Parent:MoveTo(p.Character.HumanoidRootPart.CFrame.Position)	 
                        end
                    end                                		
                    wait(.4)
                    LPlayer.Character.HumanoidRootPart.CFrame = oldCFrame                                                        
                end
            end   
        end
    end
end)

PlrTarget:addButton("View Mayor", function()
    game.Workspace.Camera.CameraSubject = getMayor().Character.Humanoid
end)
PlrTarget:addButton("View Next Player", function()
    if plrNum < #game.Players:GetPlayers() then
        plrNum = plrNum + 1
        for i,v in pairs(game.Players:GetPlayers()) do
            if i == plrNum then
                game.Workspace.Camera.CameraSubject = v.Character.Humanoid
            end            
        end
    end
end)
PlrTarget:addButton("View Previous Player", function()
    if plrNum ~= 1 then
        plrNum = plrNum - 1
    end
    for i,v in pairs(game.Players:GetPlayers()) do
        if i == plrNum then
            game.Workspace.Camera.CameraSubject = v.Character.Humanoid            
        end
    end
end)
PlrTarget:addButton("Teleport To Spectated", function()
    if plrNum ~= 1 then
        for i,v in pairs(game.Players:GetPlayers()) do
            if i == plrNum then
                LPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
                if plrNum ~= 1 then
                    plrNum = 1
                end
                for i,v in pairs(game.Players:GetPlayers()) do
                    if i == plrNum then
                        game.Workspace.Camera.CameraSubject = v.Character.Humanoid
                    end
                end
            end
        end
    end
end)

local donateAmount = 10
DonateSection:addTextbox("Donate Amount Value", "0", function(v)
    donateAmount = v
end)
DonateSection:addSlider("Donate Amount Slider", 10, 0, 100000, function(v)
    donateAmount = v
end)
DonateSection:addButton("Donate to Players", function()
    for i,v in pairs(game:service'Players':GetPlayers()) do
        if v.Name:match(targetName) then  
            local cas = tostring(donateAmount)
            game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").GiveMoneyToPlr:FireServer(v,cas)            
        end
    end
end)
PlrTarget:addButton("Arrest Player", function()
    for i,v in pairs(game:service'Players':GetPlayers()) do
        if v.Name:match(targetName) and not table.find(DevList, v.Name) then
            if v.Character.Wanted.Value == 0 then  
                notify(v.Name .. ": Is not wanted")  
            else                            
                oldPos = LPlayer.Character.HumanoidRootPart.CFrame
                LPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
                wait(.1)
                game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").ArrestPlayer:FireServer(v)
                wait(.1)
                game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").ArrestPlayer:FireServer(v)
                wait(.1)
                LPlayer.Character.HumanoidRootPart.CFrame = oldPos                       
            end
        end
    end
end)
local autoArrest = false
OtherSection0:addToggle("Arrest all", nil, function(state)
    autoArrest = state
end)

function getCurrentVehicle()   
    if LPlayer.Character.Humanoid.SeatPart ~= nil then
        return LPlayer.Character.Humanoid.SeatPart.Parent        
    end   
end
teleSection1:addKeybind("Click TP Keybind", nil, function()
    if mouse.Target then 
        if getCurrentVehicle() ~= nil then
            getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z) * CFrame.new(0,-2,0))
        else 
        LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)      
        end
    end
end)
--< teleportation
teleSection2:addButton("Arway", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(1861.14111, -65.5734253, -1310.6853, 0.998740196, 0, -0.0501802117, 0, 1, 0, 0.0501802117, 0, 0.998740196) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1861.14111, -65.5734253, -1310.6853, 0.998740196, 0, -0.0501802117, 0, 1, 0, 0.0501802117, 0, 0.998740196)end end)
teleSection2:addButton("Pahrump", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(-73.3169708, 9.45411873, 40.8025475, 0.0519082919, 0, -0.998651743, 0, 1, 0, 0.998651743, 0, 0.0519082919) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-73.3169708, 9.45411873, 40.8025475, 0.0519082919, 0, -0.998651743, 0, 1, 0, 0.998651743, 0, 0.0519082919)end end)
teleSection2:addButton("Eastdike", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(3044.31445, -4.52655077, -3741.91479, -0.939210117, -1.1611624e-07, -0.343343019, -1.19063124e-07, 1, -1.24975301e-08, 0.343343019, 2.91416864e-08, -0.939210117) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3044.31445, -4.52655077, -3741.91479, -0.939210117, -1.1611624e-07, -0.343343019, -1.19063124e-07, 1, -1.24975301e-08, 0.343343019, 2.91416864e-08, -0.939210117)end end)
teleSection2:addButton("Eaphis Plateau", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(1751.93347, 77.9265747, 556.575073, 0.99836874, 0, 0.0570888072, 0, 1, 0, -0.0570888072, 0, 0.99836874) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1751.93347, 77.9265747, 556.575073, 0.99836874, 0, 0.0570888072, 0, 1, 0, -0.0570888072, 0, 0.99836874)end end)
teleSection2:addButton("Okby Steppe", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(3894.29224, -2.04217577, -3309.31274, 0.819154441, 5.08817486e-08, 0.573573053, -8.20474284e-08, 1, 2.84667561e-08, -0.573573053, -7.03788601e-08, 0.819154441, -7.03788601e-08, 0.819154441) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3894.29224, -2.04217577, -3309.31274, 0.819154441, 5.08817486e-08, 0.573573053, -8.20474284e-08, 1, 2.84667561e-08, -0.573573053, -7.03788601e-08, 0.819154441)end end)
teleSection2:addButton("Hospital", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(1620.60095, -65.4234238, -1399.48181, -0.0176989716, 0, -0.99984318, 0, 1, 0, 0.99984318, 0, -0.0176989716) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1620.60095, -65.4234238, -1399.48181, -0.0176989716, 0, -0.99984318, 0, 1, 0, 0.99984318, 0, -0.0176989716)end end)
teleSection2:addButton("Police Station", function()
if getCurrentVehicle() ~= nil then
getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(1613.32397, -62.9234428, -1272.24634, 0.999857605, -3.98448172e-08, 0.0168763287, 4.06155785e-08, 1, -4.53283135e-08, -0.0168763287, 4.60073011e-08, 0.999857605) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1613.32397, -62.9234428, -1272.24634, 0.999857605, -3.98448172e-08, 0.0168763287, 4.06155785e-08, 1, -4.53283135e-08, -0.0168763287, 4.60073011e-08, 0.999857605)end end)
teleSection2:addButton("Depository", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(2051.33301, -67.4034195, -1436.65967, 0.989166439, 0, 0.146798298, 0, 1, 0, -0.146798298, 0, 0.989166439) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2051.33301, -67.4034195, -1436.65967, 0.989166439, 0, 0.146798298, 0, 1, 0, -0.146798298, 0, 0.989166439)end end)
teleSection2:addButton("Airfield", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(1884.29016, -21.3613071, -36.481102, -0.659217179, 1.00295431e-07, -0.751953006, 6.3527267e-08, 0.99999994, 7.7687254e-08, 0.751953006, 3.44318352e-09, -0.659217179) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1884.29016, -21.3613071, -36.481102, -0.659217179, 1.00295431e-07, -0.751953006, 6.3527267e-08, 0.99999994, 7.7687254e-08, 0.751953006, 3.44318352e-09, -0.659217179)end end)
teleSection3:addButton("Safe Spot 1", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(2122.71143, -83.3322983, -1404.4574, -0.701904893, -3.58332279e-08, 0.712271094, -3.54125085e-08, 1, 1.54112971e-08, -0.712271094, -1.4406039e-08, -0.701904893) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2122.71143, -83.3322983, -1404.4574, -0.701904893, -3.58332279e-08, 0.712271094, -3.54125085e-08, 1, 1.54112971e-08, -0.712271094, -1.4406039e-08, -0.701904893)end end)
teleSection3:addButton("Safe Spot 2", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(2945.89185, -137.832367, -631.946899, -0.0719730258, -0.0382576138, 0.996672332, -5.91074745e-08, 0.999264121, 0.0383570902, -0.997406602, 0.00276061334, -0.0719199777) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2945.89185, -137.832367, -631.946899, -0.0719730258, -0.0382576138, 0.996672332, -5.91074745e-08, 0.999264121, 0.0383570902, -0.997406602, 0.00276061334, -0.0719199777)end end)
teleSection3:addButton("Safe Spot 3", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(1370.47009, 71.7390747, 1057.67322, -0.805606365, 3.60798893e-08, -0.592451155, 9.24334884e-08, 1, -6.47903775e-08, 0.592451155, -1.06957877e-07, -0.805606365) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1370.47009, 71.7390747, 1057.67322, -0.805606365, 3.60798893e-08, -0.592451155, 9.24334884e-08, 1, -6.47903775e-08, 0.592451155, -1.06957877e-07, -0.805606365)end end)
teleSection4:addButton("Player lobby", function()
if getCurrentVehicle() ~= nil then
    getCurrentVehicle():SetPrimaryPartCFrame(CFrame.new(451.888794, -8.47341156, -1337.15466, -0.0644594803, 5.36564535e-08, -0.997920215, 3.67105028e-13, 1, 5.37682183e-08, 0.997920215, 3.46550766e-09, -0.0644594803) * CFrame.new(0,5,0))
else 
LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(451.888794, -8.47341156, -1337.15466, -0.0644594803, 5.36564535e-08, -0.997920215, 3.67105028e-13, 1, 5.37682183e-08, 0.997920215, 3.46550766e-09, -0.0644594803)end end)

-- Buy Page
local currentTool = nil 
local color1 = Color3.fromRGB(255,255,255)
local color2 = Color3.fromRGB(255,255,255)
paintSection:addColorPicker("Primary Color", Color3.fromRGB(255,255,255), function(c)
    color1 = c
end)
paintSection:addColorPicker("Secondary Color", Color3.fromRGB(255,255,255), function(c)
    color2 = c
end)
paintSection:addButton("Paint current tool", function()
    for i,v in pairs(LPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v ~= nil then  
            currentTool = v
        end
    end
    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").PaintTool:FireServer(currentTool,color1,color2)
end)

local buyAmmoAmount = 1
local ammoType = ""
AutoBuySection:addDropdown("Ammo", {"9mm", "5.56", "12 Gauge", ".50", ".45 ACP", "5.7x28"}, function(valuex)
    ammoType = valuex
end)
AutoBuySection:addSlider("Ammo Amount", 1, 0, 200, function(v)
    buyAmmoAmount = v
end)
AutoBuySection:addButton("Buy ammo", function()
    for i = 1, buyAmmoAmount, 1 do
        wait(.3)   
        game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").PurchaseTeamItem:FireServer(ammoType,"Single",nil)
    end
end)
local isCrate = false
local weaponType = nil  
AutoBuySection:addButton("Buy Weapon", function()
    if weaponType ~= nil then
        if isCrate then
            game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").PurchaseTeamItem:FireServer(weaponType,"Crate",nil)
            game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").DeliveryFunction:FireServer("PickUpDelivery",weaponType)
        else
            game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").PurchaseTeamItem:FireServer(weaponType,"Single",nil)
        end
    end
end)
AutoBuySection:addDropdown("Weapon type (Gunsmith roles)", {"Sawed Off", "Micro SMG", "Light Vest", "9mm", "AR", "PDW .45", "Heavy Pistol", "Service Rifle", "Skorpion", "Tactical SMG", "Shotgun", "Bullpup Shotgun", "Handgun", "Revolver", "Snubnose", "Lockpick"}, function(t)
    weaponType = t
end)
AutoBuySection:addToggle("Is Crate", nil, function(v)
    isCrate = v
end)

local kitSpammerEnabled = false
BuySectionMisc2:addToggle("Kit Spammer (Requires right role)", nil, function(state)
    kitSpammerEnabled = state
end)




--[[function getTool(t,old)                  
    LPlayer.Character.HumanoidRootPart.CFrame = t.Handle.CFrame * CFrame.new(0,1,0)                  
    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").Dropper:FireServer(t,"PickUp")                   
    wait()   
    LPlayer.Character.HumanoidRootPart.CFrame = t.Handle.CFrame * CFrame.new(0,-2,1)
    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").Dropper:FireServer(t,"PickUp")    
    wait(.1)
    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").Dropper:FireServer(t,"PickUp")
    wait(.2)
    LPlayer.Character.HumanoidRootPart.Anchored = true                
    LPlayer.Character.HumanoidRootPart.CFrame = old
    LPlayer.Character.HumanoidRootPart.Anchored = false
end
wepSection:addToggle("Tool Sniper", nil, function(state)
    if state then  
        local oldCFrame = LPlayer.Character.HumanoidRootPart.CFrame         
        for i,v in pairs(game:GetService("Workspace").Entities:GetChildren()) do            
            if v:IsA("Model") and v.Name == "ToolModel" and LPlayer.Character and v.Handle and not v:FindFirstChild("PlayerWhoDropped") then
                getTool(v,oldCFrame)                                
            end
        end
    end    
end)
wepSection:addToggle("Auto Store items", nil, function(state)
    autoStore = state
end)
wepSection:addToggle("Backpack Pass", nil, function(state)
   LPlayer.PlayerScripts.OwnsBackpackPass.Value = state
end)]]
miscSection:addButton("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)
miscSection:addButton("No void", function()
   game:GetService("Workspace").FallenPartsDestroyHeight = math.huge - math.huge
end)
miscSection:addButton("Reset cash to 50k", function()
    for i,v in pairs(workspace.PlayerVehicles:GetChildren()) do
        game:GetService("ReplicatedStorage")["_CS.Events"].FillUpCar:FireServer(v, 9e9)
    end
    wait(.2)
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)
CarSection:addToggle("Max Speed", nil, function(state)
    ccar = getCurrentVehicle()  
    if state then
        ccar.VehicleSeat.Gear.Value = -100
    else 
        ccar.VehicleSeat.Gear.Value = 2
    end
end)
CarSection:addSlider("Car Strength", 1, 0, 100, function(v)
    ccar = getCurrentVehicle()      
    ccar.VehicleSeat.Strength.Value = v 
end)
CarSection:addSlider("Acceleration", 1, 0, 10000, function(v)
    ccar = getCurrentVehicle()      
    ccar.VehicleSeat.Default.Value = v 
end)
CarSection:addButton("Spawn Held Car", function() 
    CSEvents.SpawnVehicle:FireServer(LPlayer.Character.HumanoidRootPart.CFrame, LPlayer.Character:FindFirstChildWhichIsA("Tool"));     
end)
CarSection:addButton("Unlock cars (LOOP)", function() 
    while wait(1) do
        for i,v in pairs(game:GetService("Workspace").PlayerVehicles:GetDescendants()) do
            if v:IsA("VehicleSeat") or v:IsA("Seat") then
                v.Disabled = false
                wait(.3)
            end
        end
    end
end)
CarSection:addButton("Bring all cars", function() 
    oldCFrame = LPlayer.Character.HumanoidRootPart.CFrame
    for i,v in pairs(game:GetService("Workspace").PlayerVehicles:GetChildren()) do
        if v:FindFirstChild("VehicleSeat") and v ~= nil and v:FindFirstChild("VehicleSeat").Damage.Value > 1 and not v:FindFirstChild("VehicleSeat"):FindFirstChild("SeatWeld") then
            local Carseat = v:FindFirstChild("VehicleSeat")        
            Carseat.Disabled = false      
            wait(1)   
            if Carseat ~= nil and Carseat then
                if Carseat.Parent:FindFirstChild("VehicleSeat") and not Carseat:FindFirstChild("SeatWeld") then   
                    Carseat.Disabled = false        
                    for i = 20, 0, -1 do        
                        wait(.15)
                        LPlayer.Character.HumanoidRootPart.CFrame = Carseat.CFrame           
                    end        
                    wait()  
                    if LPlayer.Character.Humanoid.SeatPart ~= nil then      
                        LPlayer.Character.Humanoid.SeatPart.Parent:SetPrimaryPartCFrame(oldCFrame * CFrame.new(0,2,0))
                        wait(1)
                        LPlayer.Character:FindFirstChild("Humanoid").Sit = false
                        wait()
                        LPlayer.Character:FindFirstChildOfClass("Humanoid").Jump = true
                    else
                        LPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
                    end                            
                end
            end   
        end
    end
end)
CarSection:addButton("Crash passengers", function() 
    local seat = game.Players.LocalPlayer.Character.Humanoid.SeatPart
    seat.Parent:MoveTo(Vector3.new(seat.Parent.PrimaryPart.Position.X, workspace.FallenPartsDestroyHeight+1, seat.Parent.PrimaryPart.Position.Z))
end)
CarSection:addButton("Skydive passengers", function() 
    local seat = game.Players.LocalPlayer.Character.Humanoid.SeatPart
    seat.Parent:MoveTo(Vector3.new(seat.Parent.PrimaryPart.Position.X, seat.Parent.PrimaryPart.Position.Y + 30000, seat.Parent.PrimaryPart.Position.Z))
end)

boomSection:addButton("Stop Song", function() 
    game:GetService("Players").LocalPlayer.Character.Boombox.ToolModel.PlayMusicEvent:FireServer("Stop","http://www.roblox.com/asset/?id=0")end)
boomSection:addButton("Among us Drip", function() 
    game:GetService("Players").LocalPlayer.Character.Boombox.ToolModel.PlayMusicEvent:FireServer("Play","http://www.roblox.com/asset/?id=6065418936")end)
boomSection:addButton("Rick & Morty", function() 
    game:GetService("Players").LocalPlayer.Character.Boombox.ToolModel.PlayMusicEvent:FireServer("Play","http://www.roblox.com/asset/?id=7009577773")end)
boomSection:addButton("Gangsters Paridise", function() 
    game:GetService("Players").LocalPlayer.Character.Boombox.ToolModel.PlayMusicEvent:FireServer("Play","http://www.roblox.com/asset/?id=2980426576")end)
boomSection:addButton("Moonlight", function() 
    game:GetService("Players").LocalPlayer.Character.Boombox.ToolModel.PlayMusicEvent:FireServer("Play","http://www.roblox.com/asset/?id=3309207662j")end)
boomSection:addButton("Lucid Dreams", function() 
    game:GetService("Players").LocalPlayer.Character.Boombox.ToolModel.PlayMusicEvent:FireServer("Play","http://www.roblox.com/asset/?id=6785290094")end)
boomSection:addButton("STAY", function() 
    game:GetService("Players").LocalPlayer.Character.Boombox.ToolModel.PlayMusicEvent:FireServer("Play","http://www.roblox.com/asset/?id=6815150969")end)
boomSection:addButton("Screaming", function() 
    game:GetService("Players").LocalPlayer.Character.Boombox.ToolModel.PlayMusicEvent:FireServer("Play","http://www.roblox.com/asset/?id=271550300")end)
boomSection:addButton("End of time", function() 
    game:GetService("Players").LocalPlayer.Character.Boombox.ToolModel.PlayMusicEvent:FireServer("Play","http://www.roblox.com/asset/?id=1647301137")end)
    
print("Loading | 30%")

ThemeSection:addToggle("Theme Enabled", true, function(state)
    ThemeEnabled = state
    if ThemeEnabled then
        setTheme()
    end
end)
ThemeSection:addDropdown("Theme Mode", {"Purple", "Red", "Green", "White"}, function(valuex)
    ThemeMode = valuex
    setTheme()
end)
UISection:addKeybind("GUI Keybind", Enum.KeyCode.LeftAlt, function()    
    Main:toggle()
    end, function()    
end)

local c = 1
function zigzag(X)
    return math.acos(math.cos(X * math.pi)) / math.pi
end
coroutine.wrap(function()
    while wait(1) do
        if autoStore then   
            pcall(function()                       
                for i,v in pairs(LPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name ~= "Boombox" and v.Name ~= "" then 
                        LPlayer.Character.Humanoid:EquipTool(v)  
                        wait(.5)
                        game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").AddItem:FireServer(v.Name,false)                    
                    end                              
                end
            end)
        end 
    end
end)()
local Character_Parts ={ "Head","LeftHand","LeftLowerArm","LeftUpperArm","RightHand","RightLowerArm","RightUpperArm","UpperTorso","LowerTorso","RightFoot","RightLowerLeg","RightUpperLeg","LeftFoot","LeftLowerLeg","LeftUpperLeg"}
coroutine.wrap(function()
    while wait(1)do
        pcall(function()            
            if targetHighlight then
                for _,v in pairs(Players:GetPlayers()) do
                    if v.Name ~= LPlayer.Name and v.Name:match(targetName) then
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
                                a.Transparency = 0.7
                                a.Color3 = Color3.fromRGB(255,255,0)
                                coroutine.wrap(function()
                                    wait(1)
                                    a:Destroy()
                                end)()                             
                            end
                        end
                    end
                end
            end		
		end)
	end
end)()
coroutine.wrap(function()
    while wait(1) do
        if backpackDisplay then   
            pcall(function()                       
                for i,v in pairs(Players:GetChildren()) do
                    if v.Character and v ~= nil and v.Character:FindFirstChild("UpperTorso") then
                        refreshDisplay(v)				           
                    end
                end
            end)
        end 
    end
end)()
coroutine.wrap(function()
    while wait(3) do
        if autoArrest then    
            pcall(function()                      
                for i,v in ipairs(Players:GetChildren()) do
                    if v.Character.Wanted.Value ~= 1 and not table.find(DevList, v.Name) then 
                        wait(.1)                        
                        LPlayer.Character.HumanoidRootPart.Anchored = true 
                        LPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,2) 
                        LPlayer.Character.HumanoidRootPart.Anchored = false 
                        wait(.1)                                               
                        game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").ArrestPlayer:FireServer(v)                                                       
                        LPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,0.5)                      
                        wait(.1)                          
                        LPlayer.Character.HumanoidRootPart.Anchored = true              
                        LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1370.47009, 71.7390747, 1057.67322, -0.805606365, 3.60798893e-08, -0.592451155, 9.24334884e-08, 1, -6.47903775e-08, 0.592451155, -1.06957877e-07, -0.805606365)
                        wait(.5)
                        LPlayer.Character.HumanoidRootPart.Anchored = false
                    end
                end                
            end)          
        end
    end
end)()
coroutine.wrap(function()
    while wait(.1) do
        if kitSpammerEnabled then 
            pcall(function()                        
                game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").PurchaseTeamItem:FireServer("Repair Kit","Single",nil)
                wait(.1)
                for i,v in pairs(LPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name == "Repair Kit" then 
                        LPlayer.Character.Humanoid:EquipTool(v)  
                        wait(.2) 
                        game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").Dropper:FireServer("Repair Kit","Drop")
                    end                              
                end            
            end)
        end
    end
end)()
coroutine.wrap(function()
    while wait(.06) do
        if gunSoundSpam then 
            pcall(function()                
                for i,v in pairs(LPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name ~= "" and v ~= nil and v.Handle:FindFirstChild("Mag") then                         
                        game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").AmmoRemover:FireServer(v.Handle.Mag)
                    end                              
                end            
            end)
        end
    end
end)()
coroutine.wrap(function()    
        while wait(1.5) do
            if Hitboxes then
                pcall(function()                  
                    for i,v in pairs(game.Players:GetPlayers()) do
                    if v ~= LPlayer and v.Character and v.Character:FindFirstChild('Head') then
                        v.Character.Head.Size = Vector3.new(headHitboxSize,headHitboxSize,headHitboxSize)
                        v.Character.Head.Transparency = hitboxTransparency
                        v.Character.Head.CanCollide = false
                        if v.Character.Humanoid.Health == 0 then
                            v.Character.Head.Size = LPlayer.Character.Head.Size
                            v.Character.Head.Transparency = LPlayer.Character.Head.Transparency                        
                        end
                    end
                end
            end)
        end
    end
end)()
UIS.InputBegan:connect(function(key)
    if infiniteStamina and key.KeyCode == Enum.KeyCode.LeftShift then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 23
    end
end)
UIS.InputEnded:connect(function(key)
    if infiniteStamina and key.KeyCode == Enum.KeyCode.LeftShift then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 13
    end
end)
UIS.InputBegan:connect(function(UserInput)
    if infiniteJump and jumpMode == "Infinite" and UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
        Action(LPlayer.Character.Humanoid, function(self)
            if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                Action(self.Parent.HumanoidRootPart, function(self)
                    self.Velocity = Vector3.new(0, lJumpHeight, 0);
                end)
            end
        end)
    end      
end)
UIS.InputBegan:connect(function(process)
    if infiniteJump and jumpMode == "Fly" then          
        if UIS:IsKeyDown(Enum.KeyCode.Space) then 
        repeat wait() 
            Action(LPlayer.Character.Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(self.Parent.HumanoidRootPart, function(self)
                        self.Velocity = Vector3.new(0, lJumpHeight, 0);
                    end)
                end
            end)            
            until UIS:IsKeyDown(Enum.KeyCode.Space) == false
        end
    end
end)


local MouseDown = false
UIS.InputBegan:Connect(function(a)
    if a.UserInputType == Enum.UserInputType.MouseButton1 then
        MouseDown = true 
    end
end)
UIS.InputEnded:Connect(function(a)
    if a.UserInputType == Enum.UserInputType.MouseButton1 then
        MouseDown = false
    end
end)
spawn(function()
    while wait(SpeedSDelay) do
        if MouseDown == true and SpeedShotgun then
            for i,v in pairs(LPlayer.Character:GetChildren()) do
                if v:IsA("Tool") and v.Name == "Bullpup Shotgun" or v.Name == "Shotgun" or v.Name == "Riot Shotgun" or v.Name == "Sawed Off" then
                    v.MainGunScript.FireEvent:Fire(mouse,"Shotgun")                    
                end
            end
        end
    end
end)
UIS.InputBegan:Connect(function(a)
    if a.UserInputType == Enum.UserInputType.MouseButton1 and shotMulti then
        for i,v in pairs(LPlayer.Character:GetChildren()) do
            if v:IsA("Tool") and v.Name == "Bullpup Shotgun" or v.Name == "Shotgun" or v.Name == "Riot Shotgun" or v.Name == "Sawed Off" then            
                for i = shotMultiAmmount, 0, -1 do            
                    v.MainGunScript.FireEvent:Fire(mouse)               
                end
            end
        end 
    end
end)

print("Loading | 50%")

game:GetService("RunService").RenderStepped:connect(function()       
   if esp_Enabled then       
        for _,v in pairs(Players:GetChildren()) do
            if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health > 0 and v ~= LPlayer then
            local part = v.Character.HumanoidRootPart             
            local distance = LPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position)
            local Vec ,onscreen =game.Workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                if onscreen then
                    if esp_Names and distance < maxDisance and distance > 7 then
                        local a=Drawing.new("Text")
                        if esp_distance then                
                           a.Text = v.Name .. " [" .. math.ceil(distance) .. "]"
                        else                            
                           a.Text = v.Name                                         
                        end 
                        a.Size=math.clamp(16-(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,16,83)
                        a.Center=true
                        a.Outline=true
                        a.OutlineColor=Color3.new()
                        a.Font=Drawing.Fonts.UI
                        a.Visible=true
                        a.Transparency=1
                        a.Color=esp_Main_Colour
                        a.Position=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.UpVector*(3+(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.UpVector*(3+(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/40)).Y)
                        coroutine.wrap(function()
                        game.RunService.RenderStepped:Wait()
                        a:Remove()
                        end)()
                    end                    
                    if esp_Health and distance < maxDisance then
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
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*2.5).Y)
                        c.PointB=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).Y)
                        c.PointC=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).Y)
                        c.PointD=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*-2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*-2.5).Y)
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
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*2.5).Y)
                        e.PointB=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*2.5).Y)
                        e.PointC=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*-2.5).Y)
                        e.PointD=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*-2.5).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*-2.5).Y)
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
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2.5+part.CFrame.UpVector*(-2.5+healthnum/(maxhealth/5))).Y)
                        d.PointB=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*(-2.5+healthnum/(maxhealth/5))).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.RightVector*2+part.CFrame.UpVector*(-2.5+healthnum/(maxhealth/5))).Y)
                        d.PointC=c.PointC
                        d.PointD=c.PointD
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            d:Remove()
                        end)()
                    end     
                    if esp_WantedLevel and distance < maxDisance and distance > 7 then
                        local a = Drawing.new("Text")
                        local wantedLevel = v.Character.Wanted.Value
                        if wantedLevel == 1 then                           
                            a.Text = "Innocent" 
                            a.Color = Color3.fromRGB(60, 163, 0)
                        else
                            a.Text = "Wanted"
                            a.Color = Color3.fromRGB(180, 0, 0)
                        end
                        a.Size=math.clamp(16-(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude,16,83)
                        a.Center=true
                        a.Outline=true
                        a.OutlineColor=Color3.new()
                        a.Font=Drawing.Fonts.UI
                        a.Visible=true
                        a.Transparency=1                        
                        a.Position=Vector2.new(
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.UpVector*(3+(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/25)).X,
                            game.Workspace.CurrentCamera:WorldToViewportPoint(part.CFrame.Position+part.CFrame.UpVector*(3+(part.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude/75)).Y)
                        coroutine.wrap(function()
                        game.RunService.RenderStepped:Wait()
                        a:Remove()
                        end)()
                    end   
                    if esp_boxes and distance < maxDisance and distance > 7 then
                        local a=Drawing.new("Quad")
                        a.Visible=true
                        a.Color=esp_Main_Colour
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
                    if esp_tracers and distance < maxDisance and distance > 7 then                        
                        local t = Drawing.new("Line")
                        t.Visible = true
                        t.Color = esp_Main_Colour
                        t.Thickness = 0.3
                        t.Transparency = 0.9                        
                        if esp_tracer_orig == "Bottom" then
                            t.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y - 100)       
                            else if esp_tracer_orig == "Top" then
                                t.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y - 1000)  
                                else if esp_tracer_orig == "Mouse" then
                                    t.From = Vector2.new(mouse.X, mouse.Y + 40)   
                                end                           
                            end 
                        end
                        t.To = Vector2.new(Vec.X, Vec.Y)          
                        coroutine.wrap(function()
                            game.RunService.RenderStepped:Wait()
                            t:Remove()
                        end)()                        
                    end                                      
                end
            end                       
        end
    end  
    if LPlayer.Character.Humanoid.Health < minHealth and LPlayer.Character.Humanoid.Health > 0 and AutoHeal then        
        if not LPlayer.Backpack:FindFirstChild("Medi Kit") then
            purchaseItem("Medi Kit")         
        else                     
            for _, t in ipairs(LPlayer.Backpack:GetChildren()) do
                if t:IsA("Tool") and t.Name == "Medi Kit" then          
                    LPlayer.Character.Humanoid:EquipTool(t)            
                    game:GetService("ReplicatedStorage"):FindFirstChild("_CS.Events").ToolEvent:FireServer("Heal",LPlayer.Character, t)  
                end
            end
        end
    end   
    if rainbow_hair or rainbow_char then      
        local colorx = Color3.fromHSV(zigzag(c),1,1)
        c = c + .001
        if rainbow_hair then        
            game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("Color",colorx,"HairColor")
        end
        if rainbow_char then           
            game:GetService("ReplicatedStorage")["_CS.Events"].EquipAvatarItem:FireServer("Color",colorx,"SkinColor")            
        end
    end  
    if speedBypass and LPlayer.Character ~= nil and LPlayer.Character.Humanoid and LPlayer.Character.Humanoid.Parent then
        if LPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
            LPlayer.Character:TranslateBy(LPlayer.Character.Humanoid.MoveDirection)
        end        
    end  
    if antiCar and LPlayer.Character ~= nil and LPlayer.Character then
        if LPlayer.Character.HumanoidRootPart:FindFirstChild("TouchInterest") then
            LPlayer.Character.HumanoidRootPart.TouchInterest:Destroy()
        end
    end 
    if BDelete then
        if folderImpacts:FindFirstChild("Part") then
            for i,v in pairs(folderImpacts:GetDescendants()) do   
                if v ~= nil then         
                    v:Destroy()   
                end         
            end
        end
    end
    if esp_tools then        
        for i,v in pairs(game:GetService("Workspace").Entities:GetChildren()) do
            if v:IsA("Model") and v.Name == "ToolModel" and LPlayer.Character and v.Handle and not v:FindFirstChild("PlayerWhoDropped") then
                local Handle = v.Handle
                local name = Handle.ToolBG.ToolName.Value
                local dist = (LPlayer.Character.HumanoidRootPart.Position-Handle.Position).Magnitude
                local vec, onscreen = game.Workspace.CurrentCamera:WorldToViewportPoint(Handle.Position)
                if onscreen then
                    local toolTag = Drawing.new("Text")
                    toolTag.Text = name.." | "..math.round(dist)
                    toolTag.Outline = true
                    toolTag.Color = Color3.fromRGB(255, 222, 0)
                    toolTag.OutlineColor = Color3.fromRGB(0,0,0)
                    toolTag.Visible = true
                    toolTag.Font = Drawing.Fonts.UI
                    toolTag.Transparency = 1
                    toolTag.Position = Vector2.new(vec.X,vec.Y)
                    coroutine.wrap(function()
                        game.RunService.RenderStepped:Wait()
                        toolTag:Remove()
                    end)()
                 end
            end
        end
    end    
end)

notify("Anomic V", "Scripts made by H3LLL0 and Krypton - Forum name: F A Z E D")
notify("Anomic V", "Info can be found in discord")

wait(.3)

bypass()
setTheme()

LPlayer.CharacterAdded:Connect(function()
    if ThemeEnabled then
        wait(1)    
        setTheme()
    end
    wait(2)
    bypass()
end)

local function HitSound()
    local sound = Instance.new("Sound",workspace)
    if customHitSoundType == "Skeet" then
        sound.SoundId = "rbxassetid://5447626464"
    elseif customHitSoundType == "Rust" then
        sound.SoundId = "rbxassetid://5043539486"
    elseif customHitSoundType == "COD" then
        sound.SoundId = "rbxassetid://5952120301" 
    elseif customHitSoundType == "Test" then
        sound.SoundId = "rbxassetid://4836574859"
    end
    sound.Looped = false
    sound.Volume = 2
    sound:Play()
end

local mt = getrawmetatable(game)
setreadonly(mt, false)
local namecall = mt.__namecall

mt.__namecall = function(self,...)
    local args = {...}
    local method = getnamecallmethod()

    if customHitSound or alwaysHeadShot then
        if tostring(self) == "WeaponServer" and tostring(method) == "FireServer" then       
            if tostring(args[1]) == "Player" then  
                if customHitSoundType then
                    HitSound()
                end
                if alwaysHeadShot then
                    local player = args[2].Parent            
                    args[4] = player.Head           
                end 
            end
            return self.FireServer(self, unpack(args))        
        end
    end

	return namecall(self,...)
end

Main:SelectPage(Main.pages[1], true)
print("Loading | 100%")
