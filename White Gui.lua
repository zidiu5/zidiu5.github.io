local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local WhiteLib = {}

function WhiteLib:CreateWindow(titleText)
    -- Toggle GUI Button
    local WhiteToggleGui = Instance.new("ScreenGui")
    WhiteToggleGui.Name = "WhiteToggle"
    WhiteToggleGui.ResetOnSpawn = false
    WhiteToggleGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local OpenButton = Instance.new("TextButton")
    OpenButton.Size = UDim2.new(0, 80, 0, 30)
    OpenButton.Position = UDim2.new(0, 10, 0.5, -15)
    OpenButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.Text = "White"
    OpenButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    OpenButton.Font = Enum.Font.SourceSansBold
    OpenButton.TextSize = 18
    OpenButton.Parent = WhiteToggleGui
    OpenButton.Active = true
    OpenButton.Draggable = true

    -- Main GUI
    local WhiteGui = Instance.new("ScreenGui")
    WhiteGui.Name = "White"
    WhiteGui.ResetOnSpawn = false
    WhiteGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    WhiteGui.Enabled = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = WhiteGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Title.Text = titleText or "White GUI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18
    Title.Parent = MainFrame

    -- Tabs
    local TabsFrame = Instance.new("Frame")
    TabsFrame.Size = UDim2.new(0, 100, 1, -30)
    TabsFrame.Position = UDim2.new(0, 0, 0, 30)
    TabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabsFrame.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabsFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -100, 1, -30)
    ContentFrame.Position = UDim2.new(0, 100, 0, 30)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ContentFrame.Parent = MainFrame

    -- Open/Close
    OpenButton.MouseButton1Click:Connect(function()
        WhiteGui.Enabled = not WhiteGui.Enabled
    end)

    -- API
    local Window = {}
    function Window:CreateTab(tabName)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        btn.Text = tabName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 16
        btn.Parent = TabsFrame

        local tabFrame = Instance.new("ScrollingFrame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.CanvasSize = UDim2.new(0,0,0,0)
        tabFrame.ScrollBarThickness = 4
        tabFrame.Parent = ContentFrame

        local UIList = Instance.new("UIListLayout")
        UIList.Parent = tabFrame
        UIList.SortOrder = Enum.SortOrder.LayoutOrder
        UIList.Padding = UDim.new(0,5)

        -- **Fix für gleichmäßige Abstände**
        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0,10)
        UIPadding.PaddingRight = UDim.new(0,10)
        UIPadding.Parent = tabFrame

        local function updateCanvas()
            tabFrame.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
        end

        UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
        updateCanvas()
        
        btn.MouseButton1Click:Connect(function()
            for _, f in ipairs(ContentFrame:GetChildren()) do
                if f:IsA("ScrollingFrame") then f.Visible = false end
            end
            tabFrame.Visible = true
        end)
        
        local Tab = {}
        function Tab:CreateSection(secName)
            local SecFrame = Instance.new("Frame")
            SecFrame.Size = UDim2.new(1, 0, 0, 0)
            SecFrame.BackgroundTransparency = 1
            SecFrame.AutomaticSize = Enum.AutomaticSize.Y
            SecFrame.Parent = tabFrame

            local SecLabel = Instance.new("TextLabel")
            SecLabel.Size = UDim2.new(1, 0, 0, 20)
            SecLabel.Text = secName
            SecLabel.TextColor3 = Color3.fromRGB(200,200,200)
            SecLabel.Font = Enum.Font.SourceSansBold
            SecLabel.TextSize = 14
            SecLabel.TextXAlignment = Enum.TextXAlignment.Left
            SecLabel.BackgroundTransparency = 1
            SecLabel.Parent = SecFrame

            local UIListSection = Instance.new("UIListLayout")
            UIListSection.Parent = SecFrame
            UIListSection.SortOrder = Enum.SortOrder.LayoutOrder
            UIListSection.Padding = UDim.new(0,5)

            local Section = {}

            -- Label
            function Section:CreateLabel(text)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1,0,0,25)
                lbl.BackgroundTransparency = 1
                lbl.Text = text
                lbl.TextColor3 = Color3.fromRGB(255,255,255)
                lbl.Font = Enum.Font.SourceSans
                lbl.TextSize = 16
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Parent = SecFrame
            end

            -- Button
            function Section:CreateButton(text, callback)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1,0,0,30)
                btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
                btn.Text = text
                btn.TextColor3 = Color3.fromRGB(255,255,255)
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 16
                btn.Parent = SecFrame
                btn.MouseButton1Click:Connect(function()
                    if callback then callback() end
                end)
            end

            -- Toggle
            function Section:CreateToggle(text, default, callback)
                local state = default
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1,0,0,30)
                btn.BackgroundColor3 = state and Color3.fromRGB(50,180,50) or Color3.fromRGB(180,50,50)
                btn.Text = text.." ["..(state and "ON" or "OFF").."]"
                btn.TextColor3 = Color3.fromRGB(255,255,255)
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 16
                btn.Parent = SecFrame
                btn.MouseButton1Click:Connect(function()
                    state = not state
                    btn.BackgroundColor3 = state and Color3.fromRGB(50,180,50) or Color3.fromRGB(180,50,50)
                    btn.Text = text.." ["..(state and "ON" or "OFF").."]"
                    if callback then callback(state) end
                end)
            end

            -- Textbox
            function Section:CreateTextbox(text, placeholder, callback)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1,0,0,25)
                lbl.Text = text
                lbl.TextColor3 = Color3.fromRGB(200,200,200)
                lbl.Font = Enum.Font.SourceSans
                lbl.TextSize = 14
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.BackgroundTransparency = 1
                lbl.Parent = SecFrame

                local box = Instance.new("TextBox")
                box.Size = UDim2.new(1,0,0,30)
                box.BackgroundColor3 = Color3.fromRGB(80,80,80)
                box.PlaceholderText = placeholder or ""
                box.TextColor3 = Color3.fromRGB(255,255,255)
                box.Font = Enum.Font.SourceSans
                box.TextSize = 16
                box.ClearTextOnFocus = false
                box.Parent = SecFrame

                box.FocusLost:Connect(function(enter)
                    if enter and callback then callback(box.Text) end
                end)
            end

            -- Dropdown
            function Section:CreateDropdown(text, options, callback)
                local DropBtn = Instance.new("TextButton")
                DropBtn.Size = UDim2.new(1,0,0,30)
                DropBtn.BackgroundColor3 = Color3.fromRGB(80,80,120)
                DropBtn.Text = text.." ▼"
                DropBtn.TextColor3 = Color3.fromRGB(255,255,255)
                DropBtn.Font = Enum.Font.SourceSans
                DropBtn.TextSize = 16
                DropBtn.Parent = SecFrame

                local DropFrame = Instance.new("Frame")
                DropFrame.Size = UDim2.new(1,0,0,#options*25)
                DropFrame.BackgroundColor3 = Color3.fromRGB(60,60,80)
                DropFrame.Visible = false
                DropFrame.ClipsDescendants = false
                DropFrame.ZIndex = 10
                DropFrame.Parent = SecFrame

                local UIList = Instance.new("UIListLayout")
                UIList.Parent = DropFrame
                UIList.SortOrder = Enum.SortOrder.LayoutOrder
                UIList.Padding = UDim.new(0,2)

                for _, opt in ipairs(options) do
                    local OptBtn = Instance.new("TextButton")
                    OptBtn.Size = UDim2.new(1,0,0,25)
                    OptBtn.BackgroundColor3 = Color3.fromRGB(90,90,130)
                    OptBtn.Text = opt
                    OptBtn.TextColor3 = Color3.fromRGB(255,255,255)
                    OptBtn.Font = Enum.Font.SourceSans
                    OptBtn.TextSize = 14
                    OptBtn.ZIndex = 11
                    OptBtn.Parent = DropFrame

                    OptBtn.MouseButton1Click:Connect(function()
                        DropBtn.Text = text..": "..opt
                        DropFrame.Visible = false
                        if callback then callback(opt) end
                    end)
                end

                DropBtn.MouseButton1Click:Connect(function()
                    DropFrame.Visible = not DropFrame.Visible
                end)
            end

            -- Keybind
            function Section:CreateKeybind(text, defaultKey, callback)
                local KeyBtn = Instance.new("TextButton")
                KeyBtn.Size = UDim2.new(1,0,0,30)
                KeyBtn.BackgroundColor3 = Color3.fromRGB(100,80,80)
                KeyBtn.Text = text..": ["..(defaultKey.Name or "None").."]"
                KeyBtn.TextColor3 = Color3.fromRGB(255,255,255)
                KeyBtn.Font = Enum.Font.SourceSans
                KeyBtn.TextSize = 16
                KeyBtn.Parent = SecFrame

                local currentKey = defaultKey or Enum.KeyCode.None

                KeyBtn.MouseButton1Click:Connect(function()
                    KeyBtn.Text = text..": [Press a Key]"
                    local conn
                    conn = UserInputService.InputBegan:Connect(function(input, gp)
                        if not gp and input.UserInputType == Enum.UserInputType.Keyboard then
                            currentKey = input.KeyCode
                            KeyBtn.Text = text..": ["..currentKey.Name.."]"
                            conn:Disconnect()
                        end
                    end)
                end)

                UserInputService.InputBegan:Connect(function(input, gp)
                    if not gp and input.KeyCode == currentKey then
                        if callback then callback() end
                    end
                end)
            end

            return Section
        end

        return Tab
    end

    return Window
end

return WhiteLib
