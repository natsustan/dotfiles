-- Function to center a window
local function centerWindow(window)
  local screen = window:screen()
  local screenFrame = screen:frame()
  local windowFrame = window:frame()
  
  windowFrame.x = screenFrame.x + (screenFrame.w - windowFrame.w) / 2
  windowFrame.y = screenFrame.y + (screenFrame.h - windowFrame.h) / 2
  
  window:setFrame(windowFrame)
end

-- Watch for Kitty window creation
local kittyWatcher = hs.window.filter.new('kitty')
kittyWatcher:subscribe(hs.window.filter.windowCreated, function(window)
  -- Use a slight delay to ensure the window has fully loaded
  hs.timer.doAfter(0.1, function()
    centerWindow(window)
  end)
end)
