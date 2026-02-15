local SaveManager = {}
local HttpService = game:GetService("HttpService")

local FolderName = "Bacon Hub"
local CurrentFileName = "config"
local AutoSaveEnabled = true
local AutoSaveDelay = 0.5

if not isfolder(FolderName) then
    makefolder(FolderName)
end

if not getgenv().Config then
    getgenv().Config = {}
end

local SaveScheduled = false
local IsLoading = false

local function GetFilePath(fileName)
    return FolderName .. "/" .. (fileName or CurrentFileName) .. ".json"
end

local function ScheduleSave()
    if not AutoSaveEnabled or IsLoading then return end
    if SaveScheduled then return end
    SaveScheduled = true
    task.delay(AutoSaveDelay, function()
        SaveScheduled = false
        SaveManager:SaveConfig()
    end)
end

function SaveManager:HookToggle(toggleObject, name)
    if not toggleObject or not toggleObject.SetStage then return end
    local originalSetStage = toggleObject.SetStage
    toggleObject.SetStage = function(self, value)
        originalSetStage(self, value)
        if not IsLoading then
            getgenv().Config[name] = value
            ScheduleSave()
        end
    end
end

function SaveManager:HookSlider(sliderObject, name)
    if not sliderObject or not sliderObject.SetValue then return end
    local originalSetValue = sliderObject.SetValue
    sliderObject.SetValue = function(self, value)
        originalSetValue(self, value)
        if not IsLoading then
            getgenv().Config[name] = value
            ScheduleSave()
        end
    end
end

function SaveManager:HookInput(inputObject, name)
    if not inputObject or not inputObject.SetValue then return end
    local originalSetValue = inputObject.SetValue
    inputObject.SetValue = function(self, value)
        originalSetValue(self, value)
        if not IsLoading then
            getgenv().Config[name] = value
            ScheduleSave()
        end
    end
end

function SaveManager:HookDropdown(dropdownObject, name)
    if not dropdownObject then return end
end

function SaveManager:HookKeybind(keybindObject, name)
    if not keybindObject or not keybindObject.Set then return end
    local originalSet = keybindObject.Set
    keybindObject.Set = function(self, key)
        originalSet(self, key)
        if not IsLoading then
            getgenv().Config[name] = key
            ScheduleSave()
        end
    end
end

function SaveManager:AutoHookAll()
    if not getgenv().AllControls then
        return
    end
    for _, control in pairs(getgenv().AllControls) do
        local name = control.Name
        if control.SetStage then
            self:HookToggle(control, name)
        elseif control.SetValue and control.GetValue then
            self:HookSlider(control, name)
        elseif control.Set and control.Get then
            self:HookKeybind(control, name)
        elseif control.rf then
            self:HookDropdown(control, name)
        end
    end
end

function SaveManager:SaveConfig(fileName)
    local filePath = GetFilePath(fileName)
    pcall(function()
        local jsonString = HttpService:JSONEncode(getgenv().Config)
        writefile(filePath, jsonString)
    end)
end

function SaveManager:LoadConfig(fileName)
    local filePath = GetFilePath(fileName)
    if not isfile(filePath) then
        return false
    end
    local success, result = pcall(function()
        local data = readfile(filePath)
        return HttpService:JSONDecode(data)
    end)
    if success and type(result) == "table" then
        getgenv().Config = result
        self:ApplyConfig()
        return true
    end
    return false
end

function SaveManager:ApplyConfig()
    if not getgenv().AllControls then
        return
    end
    IsLoading = true
    for _, control in pairs(getgenv().AllControls) do
        local name = control.Name
        local value = getgenv().Config[name]
        if value ~= nil then
            pcall(function()
                if control.SetStage then
                    control:SetStage(value)
                elseif control.SetValue then
                    control:SetValue(value)
                elseif control.Set then
                    control:Set(value)
                end
            end)
        end
    end
    task.delay(0.5, function()
        IsLoading = false
    end)
end

function SaveManager:SetAutoSave(enabled)
    AutoSaveEnabled = enabled
end

function SaveManager:SetFileName(fileName)
    if not fileName or fileName == "" then
        return false
    end
    CurrentFileName = fileName
    return true
end

function SaveManager:GetFileName()
    return CurrentFileName
end

function SaveManager:ListConfigs()
    local configs = {}
    if not isfolder(FolderName) then
        return configs
    end
    for _, file in ipairs(listfiles(FolderName)) do
        if file:match("%.json$") then
            local name = file:match("([^/\\]+)%.json$")
            table.insert(configs, name)
        end
    end
    return configs
end

function SaveManager:DeleteConfig(fileName)
    local filePath = GetFilePath(fileName)
    if isfile(filePath) then
        delfile(filePath)
        return true
    end
    return false
end

function SaveManager:ResetConfig()
    getgenv().Config = {}
    self:SaveConfig()
    self:ApplyConfig()
end

function SaveManager:CopyConfigString()
    local configStr = HttpService:JSONEncode(getgenv().Config)
    if setclipboard then
        setclipboard(configStr)
    end
    return configStr
end

function SaveManager:ImportConfig(configString)
    local success, result = pcall(function()
        return HttpService:JSONDecode(configString)
    end)
    if success and type(result) == "table" then
        getgenv().Config = result
        self:ApplyConfig()
        self:SaveConfig()
        return true
    end
    return false
end

function SaveManager:PrintConfig()
    for k, v in pairs(getgenv().Config) do
        print(string.format('["%s"] = %s', k, tostring(v)))
    end
end

function SaveManager:Initialize()
    self:AutoHookAll()
    if isfile(GetFilePath()) then
        self:LoadConfig()
    end
end

return SaveManager
