-- helper hotkey to figure out the app path and name of current focused window
-- ⌃ + ⌘ +.时会显示应用的路径等信息
hs.hotkey.bind({ 'control', 'cmd' }, ".", function()
  local focusedWindow = hs.window.focusedWindow()
  if not focusedWindow then
    hs.alert.show("无法获取焦点窗口", 1)
    return
  end
  
  local app = focusedWindow:application()
  if not app then
    hs.alert.show("无法获取应用程序信息", 1)
    return
  end
  
  -- 安全获取应用信息
  local appPath = "未知"
  local appName = "未知"
  local imSourceId = "未知"
  -- 使用pcall来安全获取应用路径
  local success, result = pcall(function() return app:path() end)
  if success and result then
    appPath = result
  end
  
  -- 使用pcall来安全获取应用名称
  success, result = pcall(function() return app:name() end)
  if success and result then
    appName = result
  end
  
  -- 获取输入法源ID
  success, result = pcall(function() return hs.keycodes.currentSourceID() end)
  if success and result then
    imSourceId = result
  end

  -- 组合信息字符串
  local info = "App Path:        " .. appPath
      .. "\n"
      .. "App Name:      " .. appName
      .. "\n"
      .. "IM Source ID:  " .. imSourceId

  -- 显示信息
  hs.alert.show(info, 2)

  -- 将信息复制到剪贴板
  hs.pasteboard.setContents(info)
end)
