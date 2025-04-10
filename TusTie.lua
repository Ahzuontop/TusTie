local plr = game.Players.LocalPlayer
local reach = 6
local enabled = true
local label = nil
local guiTimer = 0

local function createGui()
    local screenGui = plr.PlayerGui:FindFirstChild("ReachDisplay")
    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "ReachDisplay"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = plr:WaitForChild("PlayerGui")
    end

    if not label then
        label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 200, 0, 40)
        label.Position = UDim2.new(0, 10, 0, 10)
        label.BackgroundTransparency = 0.4
        label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.Parent = screenGui
    end
end

local function showGui()
    createGui()
    if label then
        label.Text = "Reach: " .. reach .. " (Anh Tú)"
        label.Visible = true
        guiTimer = tick()
    end
end

local function getHandle()
    if plr.Character then
        local tool = plr.Character:FindFirstChildOfClass("Tool")
        if tool then
            return tool:FindFirstChild("Handle"), tool
        end
    end
    return nil, nil
end

local function tryHit()
    if not enabled then return end
    local handle = getHandle()
    if not handle then return end

    local origin = handle.Position
    local direction = handle.CFrame.LookVector * reach
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {plr.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, raycastParams)
    if result and result.Instance then
        local part = result.Instance
        local humanoid = part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Parent ~= plr.Character then
            firetouchinterest(part, handle, 0)
            firetouchinterest(part, handle, 1)
        end
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.End then
        reach = reach + 0.5
        showGui()
    elseif input.KeyCode == Enum.KeyCode.Delete then
        reach = math.max(1, reach - 0.5)
        showGui()
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(tryHit)
    if label and label.Visible and tick() - guiTimer > 2 then
        label.Visible = false
    end
end)
