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
        -- 使用pcall安全地获取窗口信息
        local success, windows = pcall(function() return app:allWindows() end)
        if success and windows and #windows == 0 then
            -- 使用pcall安全地退出应用
            local quitSuccess, quitResult = pcall(function() app:kill() end)
            if not quitSuccess then
                print(string.format("退出应用 %s 失败: %s", appName, quitResult))
            end
        end
    end
end

-- 启动监控
function obj:start()
    -- 监控窗口关闭事件
    self.windowFilter:subscribe(hs.window.filter.windowDestroyed, function(window)
        if window then
            -- 使用pcall安全地获取应用信息
            local success, app = pcall(function() return window:application() end)
            if success and app then
                local appNameSuccess, appName = pcall(function() return app:name() end)
                if appNameSuccess and appName then
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