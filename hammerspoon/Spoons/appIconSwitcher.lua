local function setIcon(appName)
    -- 如果安装到其他路径，请替换下面的路径
    local appPath = "/Applications/" .. appName .. ".app"
    -- 你想使用的图标的路径
    local iconType = appName
    local iconsFolder = hs.fs.currentDir() .. "/icons/appIcons"
    hs.execute('fileicon set "' .. appPath .. '" "' .. iconsFolder .. "/" .. iconType .. '.icns"', true)
end

local function updateIcon(appName)
    -- 根据 appName 设置相应的图标
    setIcon(appName)
end

local appWatcher = hs.application.watcher.new(function(appName, eventType)
    if eventType == hs.application.watcher.launched then
        updateIcon(appName)
    end
end)

-- 初始化所有图标并启动应用程序观察器
local apps = {"Figma","Logseq","Reeder"}


for _, appName in ipairs(apps) do
    updateIcon(appName)
end

appWatcher:start()
