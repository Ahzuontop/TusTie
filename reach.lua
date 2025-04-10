-- reach.lua
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
local reachDistance = 20

if tool and tool:FindFirstChild("Handle") then
    local handle = tool.Handle

    local function onHeartbeat()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local targetHRP = player.Character.HumanoidRootPart
                local distance = (targetHRP.Position - handle.Position).Magnitude
                if distance <= reachDistance then
                    firetouchinterest(handle, targetHRP, 0)
                    firetouchinterest(handle, targetHRP, 1)
                end
            end
        end
    end

    game:GetService("RunService").Heartbeat:Connect(onHeartbeat)
end
