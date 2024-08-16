local function setIcon(appName)
    -- 如果安装到其他路径，请替换下面的路径
    local appPath = "/Applications/" .. appName .. ".app"
    -- 修改图标的路径
    local iconsFolder = os.getenv("HOME") .. "/dotfiles/macOSicons"
    local iconPath = iconsFolder .. "/" .. appName .. ".icns"
    hs.execute('fileicon set "' .. appPath .. '" "' .. iconPath .. '"', true)
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
local apps = {"Figma","Logseq","kitty","GitHub Desktop","Handbrake"}


for _, appName in ipairs(apps) do
    updateIcon(appName)
end

appWatcher:start()
