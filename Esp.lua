local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Function to create the ESP box
local function createESP(player)
    local character = player.Character
    if not character then return end

    local highlight = Instance.new("BoxHandleAdornment")
    highlight.Name = "ESPBox"
    highlight.Adornee = character
    highlight.AlwaysOnTop = true
    highlight.ZIndex = 10
    highlight.Size = character:GetExtentsSize()
    highlight.Color3 = Color3.new(1, 0, 0) -- Red color
    highlight.Transparency = 0.5
    highlight.Parent = character
end

-- Function to remove the ESP box
local function removeESP(player)
    local character = player.Character
    if not character then return end

    local highlight = character:FindFirstChild("ESPBox")
    if highlight then
        highlight:Destroy()
    end
end

-- Function to add ESP to all players
local function addESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createESP(player)
        end
    end
end

-- Connect to events
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if player ~= LocalPlayer then
            createESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

-- Initial ESP for existing players
addESP()

-- Refresh ESP periodically
RunService.RenderStepped:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            removeESP(player)
            createESP(player)
        end
    end
end)
