local HttpService = game:GetService("HttpService")

local data = {
    content = "**Đã có người dùng key!**";
    username = "Webhook Logger",
    embeds = {{
        title = "Thông tin người dùng",
        description = "Người dùng vừa nhập key!",
        fields = {
            {name = "UserId", value = tostring(game.Players.LocalPlayer.UserId), inline = true},
            {name = "DisplayName", value = game.Players.LocalPlayer.DisplayName, inline = true},
        },
        color = 65280
    }}
}

local jsonData = HttpService:JSONEncode(data)

HttpService:PostAsync("https://WebhookProxy.trananhyus.repl.co", jsonData)
