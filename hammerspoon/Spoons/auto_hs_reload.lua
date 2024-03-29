local function reload(files)
    local doReload = false

    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end

    if doReload then
        hs.console.clearConsole()
        hs.reload()
    end
end

configWatcher = hs.pathwatcher.new(hs.configdir, reload)

configWatcher:start()

hs.alert.defaultStyle.strokeColor = {white = 0, alpha = 1} -- 边框颜色
hs.alert.defaultStyle.textFont = "Menlo" -- 字体
hs.alert.defaultStyle.textSize = 16 -- 文字大小
hs.alert.defaultStyle.radius = 10 -- 圆角大小
hs.alert.show("🔨 Hammerspoon Config Reloaded",1)