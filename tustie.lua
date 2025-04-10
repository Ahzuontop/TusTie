-- tustie.lua
local allowed = {
    [123456789] = true, -- Thay bằng UserId của bạn hoặc những người được phép dùng
    [987654321] = true, -- Có thể thêm nhiều dòng nếu muốn
}

if allowed[game.Players.LocalPlayer.UserId] then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Ahzuontop/TusTie/main/reach.lua"))()
else
    game.Players.LocalPlayer:Kick("Unauthorized access.")
end

