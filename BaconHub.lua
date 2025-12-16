local HttpService = game:GetService("HttpService")
local UniverseID = HttpService:JSONDecode(
    game:HttpGet("https://apis.roblox.com/universes/v1/places/" .. game.PlaceId .. "/universe")
).universeId

if game.PlaceId == 6701277882 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Fishit.lua"))()
elseif UniverseID == 7671049560 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Theforge.lua"))()
end
