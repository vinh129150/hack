loadstring(game:HttpGet("https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/Obfuscated.lua"))()

local place = tostring(game.PlaceId)
local scripts = {
    ["121864768012064"] = "https://pandadevelopment.net/virtual/file/4cf20b45b08a2560",
    ["79546208627805"]  = "https://pandadevelopment.net/virtual/file/5b3610a67b9c4313",
    ["126509999114328"] = "https://pandadevelopment.net/virtual/file/5b3610a67b9c4313",
    ["127742093697776"] = "https://pandadevelopment.net/virtual/file/c65ad726b975c46d",
    ["122826953758426"] = "https://pandadevelopment.net/virtual/file/1976a3c45688896b",
}
local url = scripts[place]
if not url then return end
pcall(function()
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if not ok or not body then return end
    local func, loadErr = loadstring(body)
    if not func then return end
    pcall(func)
end)
