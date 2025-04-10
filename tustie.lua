
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local plr = Players.LocalPlayer

local KEY = "DracoUsinghb"
local WEBHOOK = "https://WebhookProxy.trananhyus.repl.co/forward"

-- GUI nhập key
local function createKeyGui()
    local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
    gui.Name = "KeyInputGui"

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 300, 0, 140)
    frame.Position = UDim2.new(0.5, -150, 0.5, -70)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0

    local textBox = Instance.new("TextBox", frame)
    textBox.Size = UDim2.new(0.8, 0, 0.3, 0)
    textBox.Position = UDim2.new(0.1, 0, 0.15, 0)
    textBox.PlaceholderText = "Enter Key..."
    textBox.Text = ""
    textBox.ClearTextOnFocus = false
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

    local submit = Instance.new("TextButton", frame)
    submit.Size = UDim2.new(0.5, 0, 0.3, 0)
    submit.Position = UDim2.new(0.25, 0, 0.6, 0)
    submit.Text = "Submit"
    submit.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    submit.TextColor3 = Color3.new(1, 1, 1)

    submit.MouseButton1Click:Connect(function()
        local inputKey = textBox.Text
        -- Gửi webhook qua proxy
        pcall(function()
            HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode({
                content = "**UserId:** " .. plr.UserId .. " | **Key:** " .. inputKey
            }))
        end)
        -- Kiểm tra key
        if inputKey == KEY then
            gui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Ahzuontop/TusTie/main/reach.lua"))()
        else
            plr:Kick("Dumb Kid Draco Using Hitbox")
        end
    end)
end

createKeyGui()

