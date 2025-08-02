-- 自动打开 BetterDisplay 应用
-- 当屏幕数量大于 1 时，自动打开 BetterDisplay 应用
-- 当屏幕数量等于 1 时，且屏幕为非MacBook built in屏幕时，打开BetterDisplay
-- 当屏幕数量等于 1 时，且屏幕为built in屏幕时，关闭BetterDisplay应用

-- 监听系统屏幕配置变更事件
local screenWatcher = nil
local betterdisplayAppName = "BetterDisplay"
local betterdisplayAppPath = "/Applications/BetterDisplay.app"

local previousScreenCount = #hs.screen.allScreens()

-- 检测是否为内置屏幕
local function isBuiltInScreen(screen)
  if not screen then
    return false
  end
  
  -- 获取屏幕的UUID
  local screenUUID = screen:getUUID()
  
  -- 内置屏幕通常包含 "BuiltIn" 或 "Display" 在UUID中
  -- 或者检查屏幕名称是否包含 "Built-in" 或 "内建"
  local screenName = screen:name()
  
  return string.find(screenUUID, "BuiltIn") ~= nil or 
         string.find(screenName, "Built%-in") ~= nil or
         string.find(screenName, "内建") ~= nil or
         string.find(screenName, "BuiltIn") ~= nil
end

local function screenChangedCallback()
  local currentScreenCount = #hs.screen.allScreens()
  
  if currentScreenCount > 1 then
    -- 多屏幕时，打开 BetterDisplay 应用
    hs.application.launchOrFocus(betterdisplayAppName)
  elseif currentScreenCount == 1 then
    -- 单屏幕时，检查是否为内置屏幕
    local mainScreen = hs.screen.mainScreen()
    local isBuiltIn = isBuiltInScreen(mainScreen)
    
    if isBuiltIn then
      -- 内置屏幕时，关闭 BetterDisplay 应用
      local app = hs.application.find(betterdisplayAppName)
      if app then
        app:kill()
      end
    else
      -- 非内置屏幕时，打开 BetterDisplay 应用
      hs.application.launchOrFocus(betterdisplayAppName)
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
