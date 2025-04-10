if game:GetService("Players").LocalPlayer.UserId == 123456789 then -- thay UserId đúng nếu cần
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Ahzuontop/TusTie/main/reach.lua"))()
else
    game.Players.LocalPlayer:Kick("Unauthorized access.")
end
