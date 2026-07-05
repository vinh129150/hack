local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local HttpService = game:GetService("HttpService")

local data = {
    ["embeds"] = {{
        ["title"] = "Bacon Hub",
        ["description"] = "**HWID:** `" .. HWID .. "`",
        ["color"] = 3447003,
        ["footer"] = {
            ["text"] = "Bacon Hub"
        },
        ["timestamp"] = DateTime.now():ToIsoDate()
    }}
}

request({
    Url = "https://xhider.xyz/webhook/proxy/tolaexecutor",
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = HttpService:JSONEncode(data)
})
