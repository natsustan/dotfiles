-- 配置Hammerspoon日志级别，减少不必要的警告
hs.console.clearConsole()
hs.console.outputBackgroundColor = { white = 0, alpha = 0.8 }
hs.console.outputFont = { name = Menlo, size = 12 }

-- 设置 hs.alert 的默认样式
hs.alert.defaultStyle.strokeColor = { white = 0, alpha = 1 } -- 边框颜色
hs.alert.defaultStyle.textSize = 18                          -- 文字大小
hs.alert.defaultStyle.radius = 10                            -- 圆角大小

-- 全局错误处理函数
local function safeAppOperation(operation, appName)
    local success, result = pcall(operation)
    if not success then
        print(string.format("操作失败 [%s]: %s", appName or "未知", result))
        return nil
    end
    return result
end

-- 安全的应用程序获取函数
local function getSafeApplication(appName)
    return safeAppOperation(function() return hs.application.get(appName) end, appName)
end

-- 安全的窗口获取函数
local function getSafeFocusedWindow()
    return safeAppOperation(function() return hs.window.focusedWindow() end, "焦点窗口")
end

-- Load Spoons files
require ("Spoons.appLauncher")
require ("Spoons.appInfo")
require ("Spoons.autoReload")
require ("Spoons.doubleQToQuit")
require ("Spoons.inputSourceSwitcher")
require ("Spoons.autoBetterDisplay")
require ("Spoons.autoProNotes")
-- require ("Spoons.kittyKeepCenter")

-- disable ShiftIt
-- hs.loadSpoon("ShiftIt")
-- spoon.ShiftIt:bindHotkeys({})
-- spoon.ShiftIt:setWindowCyclingSizes({ 50, 25, 33, 67 }, { 50 })

-- Vifari
hs.loadSpoon("Vifari")
spoon.Vifari:start() -- this will add hooks. `:stop()` to remove hooks

-- or if you want to customize it
spoon.Vifari:start({
    -- example your local config here
    scrollStep = 150,  -- Change scroll step
    showMenuBarIcon = false,
    mapping = {
        -- ["k"] = "cmdScrollUp",
        -- ["j"] = "cmdScrollDownFast",  -- Change existing mapping
        -- ["n"] = { "cmd", "n" },       -- Add new mapping
        ["x"] = false,                -- Disable a mapping
    }
})

-- AppAutoQuits
hs.loadSpoon("AppAutoQuits")
spoon.AppAutoQuits
    :setApps({
        "Preview",
        "Shortcuts",
        "QuickTime Player",
        "Calendar",
        "TextEdit",
        "Microsoft Word",
        "Microsoft Excel",
        "Microsoft PowerPoint",
        "Messages",
        "Passwords",
        "Numbers",
        "Keynote",
        "Pages",
        "PictureView"
    })
    :start()
 