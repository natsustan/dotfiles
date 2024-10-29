--- === AppAutoQuits ===
---
--- 自动退出没有窗口的应用
---
--- 下载: [https://github.com/your_username/AppAutoQuits.spoon](https://github.com/your_username/AppAutoQuits.spoon)

local obj = {}
obj.__index = obj

-- 插件元数据
obj.name = "AppAutoQuits"
obj.version = "1.0"
obj.author = "YourName"
obj.homepage = "https://github.com/your_username/AppAutoQuits.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- 存储需要监控的应用列表
obj.apps = {}

-- 初始化函数
function obj:init()
    obj.windowFilter = hs.window.filter.new()
    return self
end

-- 设置需要监控的应用
function obj:setApps(appNames)
    self.apps = appNames
    return self
end

-- 检查应用是否应该退出
function obj:checkAndQuitApp(appName)
    local app = hs.application.get(appName)
    if app then
        local windows = app:allWindows()
        if #windows == 0 then
            app:kill()
        end
    end
end

-- 启动监控
function obj:start()
    -- 监控窗口关闭事件
    self.windowFilter:subscribe(hs.window.filter.windowDestroyed, function(window)
        local app = window:application()
        if app then
            local appName = app:name()
            -- 检查是否在监控列表中
            for _, targetApp in ipairs(self.apps) do
                if appName == targetApp then
                    -- 延迟检查，确保窗口确实已关闭
                    hs.timer.doAfter(0.5, function()
                        self:checkAndQuitApp(appName)
                    end)
                    break
                end
            end
        end
    end)
    
    return self
end

-- 停止监控
function obj:stop()
    self.windowFilter:unsubscribeAll()
    return self
end

return obj