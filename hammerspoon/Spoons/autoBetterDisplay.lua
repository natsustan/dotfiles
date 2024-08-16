-- 监听系统屏幕配置变更事件
local screenWatcher = nil
local betterdisplayAppName = "BetterDisplay"
local betterdisplayAppPath = "/Applications/BetterDisplay.app"

local previousScreenCount = #hs.screen.allScreens()

local function screenChangedCallback()
  local currentScreenCount = #hs.screen.allScreens()
  
  if currentScreenCount > 1 and previousScreenCount <= 1 then
    -- 打开 BetterDisplay 应用
    hs.application.launchOrFocus(betterdisplayAppName)
  elseif currentScreenCount == 1 and previousScreenCount > 1 then
    -- 关闭 BetterDisplay 应用
    local app = hs.application.find(betterdisplayAppName)
    if app then
      app:kill()
    end
  end
  
  previousScreenCount = currentScreenCount
end

-- 初始化屏幕监视器
screenWatcher = hs.screen.watcher.new(screenChangedCallback)

-- 启动屏幕监视器
screenWatcher:start()

-- 在 Hammerspoon 重新载入配置时停止屏幕监视器
hs.shutdownCallback = function()
  if screenWatcher then
    screenWatcher:stop()
    screenWatcher = nil
  end
end

-- 保持脚本运行
return screenWatcher
