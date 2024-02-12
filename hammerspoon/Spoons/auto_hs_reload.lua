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

hs.alert.show("🔨 Hammerspoon Config Reloaded",1)