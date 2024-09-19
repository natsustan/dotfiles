-- 定义需要自动退出的应用程序列表
local appsToAutoQuit = {
    "Preview",
    "Mail",
    "Reminders",
    "Messages",
    "Shortcuts",
    "Calendar"
}

-- 设置无活动时间阈值（以秒为单位）
local inactivityThreshold = 60 -- 5分钟

-- 创建一个表来存储每个应用程序的最后活动时间
local lastActivityTime = {}

-- 创建一个函数来更新应用程序的最后活动时间
local function updateLastActivityTime(app)
    lastActivityTime[app:name()] = os.time()
end

-- 创建一个函数来检查并退出不活跃的应用程序
local function checkAndQuitInactiveApps()
    local currentTime = os.time()
    for _, appName in ipairs(appsToAutoQuit) do
        local app = hs.application.get(appName)
        if app then
            local lastActive = lastActivityTime[appName] or 0
            print(string.format("检查应用: %s, 最后活动时间: %s, 当前时间: %s", appName, os.date("%Y-%m-%d %H:%M:%S", lastActive), os.date("%Y-%m-%d %H:%M:%S", currentTime)))
            if currentTime - lastActive > inactivityThreshold then
                print(string.format("退出应用: %s", appName))
                app:kill()
                hs.alert.show(appName .. " Auto Quit")
            end
        end
    end
end

-- 创建一个应用程序观察器来监控应用程序活动
local appWatcher = hs.application.watcher.new(function(appName, eventType, app)
    if eventType == hs.application.watcher.activated then
        updateLastActivityTime(app)
    end
end)

-- 创建一个定时器来定期检查不活跃的应用程序
local autoQuitTimer = hs.timer.new(60, checkAndQuitInactiveApps)

-- 启动应用程序观察器和定时器
appWatcher:start()
autoQuitTimer:start()

-- 打印提示信息
print("Auto Quit Started")
print(string.format("定时器状态: %s", autoQuitTimer:running() and "运行中" or "未运行"))

-- 添加一个手动触发检查的函数
function manualCheckAndQuit()
    print("手动触发检查")
    checkAndQuitInactiveApps()
end
