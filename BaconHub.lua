local place = tostring(game.PlaceId)
local scripts = {
    ["121864768012064"] = "https://pandadevelopment.net/virtual/file/bace1afeed77bc02",
    ["79546208627805"]  = "https://pandadevelopment.net/virtual/file/b14fea7e78cf5fdc",
    ["126509999114328"] = "https://pandadevelopment.net/virtual/file/b14fea7e78cf5fdc",
    ["127742093697776"] = "https://pandadevelopment.net/virtual/file/c65ad726b975c46d",
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
