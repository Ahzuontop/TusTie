-- Script Roblox có tích hợp bảng nhập key + gửi log về webhook qua proxy
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Config
local CORRECT_KEY = "DracoUsinghb"
local WEBHOOK_PROXY = "https://WebhookProxy.trananhyus.repl.co/send"

-- Gửi log về Discord qua webhook proxy
local function sendLog(keyUsed)
    local data = {
        username = player.Name,
        userid = player.UserId,
        key = keyUsed,
        executor = identifyexecutor and identifyexecutor() or "Unknown"
    }

    pcall(function()
        HttpService:PostAsync(WEBHOOK_PROXY, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
end

-- Bảng nhập key
local function createKeyUI()
    local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.Name = "KeyUI"

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0

    local textbox = Instance.new("TextBox", frame)
    textbox.Size = UDim2.new(1, -20, 0, 40)
    textbox.Position = UDim2.new(0, 10, 0, 10)
    textbox.PlaceholderText = "Nhập key tại đây..."
    textbox.Text = ""
    textbox.TextSize = 18
    textbox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    textbox.TextColor3 = Color3.fromRGB(255, 255, 255)

    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, 60)
    button.Text = "Xác minh"
    button.TextSize = 18
    button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    local status = Instance.new("TextLabel", frame)
    status.Size = UDim2.new(1, -20, 0, 30)
    status.Position = UDim2.new(0, 10, 0, 110)
    status.BackgroundTransparency = 1
    status.TextColor3 = Color3.fromRGB(255, 255, 255)
    status.Text = ""
    status.TextSize = 16

    button.MouseButton1Click:Connect(function()
        local inputKey = textbox.Text
        sendLog(inputKey)
        if inputKey == CORRECT_KEY then
            screenGui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Ahzuontop/TusTie/main/script.lua"))()
        else
            status.Text = "Sai key!"
            task.wait(1)
            player:Kick("Dumb Kid Draco Using Hitbox")
        end
    end)
end

createKeyUI()
