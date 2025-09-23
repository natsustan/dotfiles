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

-- Load Spoons files

-- AutoReloadConfiguration Spoon
hs.loadSpoon("AutoReloadConfiguration")
spoon.AutoReloadConfiguration:start()

-- AppInfo Spoon
hs.loadSpoon("AppInfo")
spoon.AppInfo:start()

-- DoubleQToQuit Spoon
hs.loadSpoon("DoubleQToQuit")
spoon.DoubleQToQuit:start()

-- Vifari
hs.loadSpoon("Vifari")
spoon.Vifari:start() -- this will add hooks. `:stop()` to remove hooks

-- or if you want to customize it
spoon.Vifari:start({
    -- example your local config here
    scrollStep = 100,  -- Change scroll step
    showMenuBarIcon = false,
    mapping = {
        -- ["k"] = "cmdScrollUp",
        -- ["j"] = "cmdScrollDownFast",  -- Change existing mapping
        -- ["n"] = { "cmd", "n" },       -- Add new mapping
        -- Disable a mapping
        ["\x7f"] = false,             -- Disable a mapping
        ["x"] = false,                -- Disable a mapping
        -- 覆盖默认的历史导航映射
        ["["] = { "shift", "[" },              -- history back
        ["]"] = { "shift", "]" },              -- history forward
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
        "PictureView",
        "Surge Dashboard",
        "Journal",
        "Fork",
        "Activity Monitor",
        "Shortcuts",
        "1Password"
    })
    :start()
