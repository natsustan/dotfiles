-- helper hotkey to figure out the app path and name of current focused window
-- ⌃ + ⌘ +.时会显示应用的路径等信息
hs.hotkey.bind({ 'control', 'cmd' }, ".", function()
  local appPath = hs.window.focusedWindow():application():path()
  local appName = hs.window.focusedWindow():application():name()
  local imSourceId = hs.keycodes.currentSourceID()

  -- 组合信息字符串
  local info = "App Path:        " .. appPath
      .. "\n"
      .. "App Name:      " .. appName
      .. "\n"
      .. "IM Source ID:  " .. imSourceId

  -- 显示信息
  hs.alert.show(info, 3)

  -- 将信息复制到剪贴板
  hs.pasteboard.setContents(info)
end)
