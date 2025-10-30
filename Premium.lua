local scripts = {
    Darkbread = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/darkbread.lua",
    Doughking = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/doughking.lua",
    Rip_indra = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/rip_indra.lua",
    Tyrant = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/tyrantoftheskies.lua",
    Cursed_captian = "https://raw.githubusercontent.com/vinh129150/hack/refs/heads/main/cursedcaptian.lua"
}

if getgenv().name ~= "" and scripts[getgenv().name] then
    loadstring(game:HttpGet(scripts[getgenv().name]))()
    warn("Đã load script boss: " .. getgenv().name)
else
    warn("Không có boss hoặc để trống name")
end
