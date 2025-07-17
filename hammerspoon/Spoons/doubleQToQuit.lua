-- Press Cmd+Q twice to quit

local quitModal = hs.hotkey.modal.new('cmd', 'q')

function quitModal:entered()
  hs.alert.show("Press ⌘+Q Again to Quit", 1)
  hs.timer.doAfter(1, function() quitModal:exit() end)
end

local function doQuit()
  local app = hs.application.frontmostApplication()
  if app then
    -- 添加安全检查
    local appName = app:name()
    if appName and appName ~= "SystemUIServer" then
      app:kill()
    else
      hs.alert.show("无法获取应用程序信息", 1)
    end
  else
    hs.alert.show("无法获取前台应用程序", 1)
  end
end

quitModal:bind('cmd', 'q', doQuit)

quitModal:bind('', 'escape', function() quitModal:exit() end)
