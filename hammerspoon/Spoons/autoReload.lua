local function reload(files)
  hs.console.printStyledtext("配置文件变更检测触发")
  local doReload = false

  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
      hs.console.printStyledtext("检测到.lua文件变更: " .. file)
    end
  end

  if doReload then
    hs.console.clearConsole()
    hs.reload()
  end
end

configWatcher = hs.pathwatcher.new(hs.configdir, reload)
configWatcher:start()

hs.alert.show("🔨 Hammerspoon Config Reloaded", 2)
