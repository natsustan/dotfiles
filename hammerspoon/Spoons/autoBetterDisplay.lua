-- 监听系统屏幕配置变更事件
local screenWatcher = nil
local betterdisplayAppName = "BetterDisplay"
local betterdisplayAppPath = "/Applications/BetterDisplay.app"

-- 当屏幕配置变更时触发的函数
local function screenChangedCallback()
    local screens = hs.screen.allScreens()
    if #screens > 1 then  -- 如果连接了扩展屏幕(屏幕数量大于1)
        -- 打开betterdisplay应用
        hs.application.launchOrFocus(betterdisplayAppName)
    else  -- 如果没有连接扩展屏幕(屏幕数量等于1)
        -- 关闭betterdisplay应用
        local app = hs.application.find(betterdisplayAppName)
        if app then
            app:kill()
        end
    end
end

-- 初始化屏幕监视器
screenWatcher = hs.screen.watcher.new(screenChangedCallback)

-- 启动屏幕监视器
screenWatcher:start()

-- 在Hammerspoon重新载入配置时停止屏幕监视器
hs.shutdownCallback = function()
    if screenWatcher then
        screenWatcher:stop()
        screenWatcher = nil
    end
end

-- 保持脚本运行
return screenWatcher