local HttpService = game:GetService("HttpService")
local UniverseID = HttpService:JSONDecode(
    game:HttpGet("https://apis.roblox.com/universes/v1/places/" .. game.PlaceId .. "/universe")
).universeId

if game.PlaceId == 7671049560 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Theforge.lua"))()

elseif game.PlaceId == 6701277882 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Fishit.lua"))()

elseif game.PlaceId == 7449423635
    or game.PlaceId == 2753915549
    or game.PlaceId == 4442272183
    or game.PlaceId == 122478697296975
    or UniverseID == 994732206 then

    loadstring(game:HttpGet("https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Bloxfruits.lua"))()
end
