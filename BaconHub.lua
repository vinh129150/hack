local Games = {
    [7671049560] = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Theforge.lua",
    [6701277882] = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Fishit.lua",
}

local URL = Games[game.GameId] -- UniverseId

if URL then
    loadstring(game:HttpGet(URL))()
end
