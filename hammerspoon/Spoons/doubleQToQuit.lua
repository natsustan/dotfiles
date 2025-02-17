-- Press Cmd+Q twice to quit

local quitModal = hs.hotkey.modal.new('cmd', 'q')

function quitModal:entered()
  hs.alert.show("Press ⌘+Q Again to Quit", 1)
  hs.timer.doAfter(1, function() quitModal:exit() end)
end

local function doQuit()
  local app = hs.application.frontmostApplication()
  app:kill()
end

quitModal:bind('cmd', 'q', doQuit)

quitModal:bind('', 'escape', function() quitModal:exit() end)
