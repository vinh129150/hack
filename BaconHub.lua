local Games = {
    ["7671049560"] = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Theforge.lua",
    ["6701277882"] = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Fishit.lua",
}


local gameId = tostring(game.PlaceId)

if Games[gameId] then
    pcall(function()
        loadstring(game:HttpGet(Games[gameId]))()
    end)
end
