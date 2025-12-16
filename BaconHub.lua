local Games = {
    ["76558904092080"] = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Theforge.lua",
    ["121864768012064"] = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Fishit.lua",
}

local gameId = tostring(game.PlaceId)

if Games[gameId] then
    pcall(function()
        loadstring(game:HttpGet(Games[gameId]))()
    end)
end
