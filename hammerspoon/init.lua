-- 设置 hs.alert 的默认样式
hs.alert.defaultStyle.strokeColor = { white = 0, alpha = 1 } -- 边框颜色
hs.alert.defaultStyle.textSize = 18                          -- 文字大小
hs.alert.defaultStyle.radius = 10                            -- 圆角大小

-- Load Spoons files
require ("Spoons.appLauncher")
require ("Spoons.appInfo")
require ("Spoons.autoReload")
require ("Spoons.doubleQToQuit")
require ("Spoons.inputSourceSwitcher")
require ("Spoons.autoBetterDisplay")
require ("Spoons.autoProNotes")
-- require ("Spoons.kittyKeepCenter")

-- hs.loadSpoon("ShiftIt")
-- spoon.ShiftIt:bindHotkeys({})
-- spoon.ShiftIt:setWindowCyclingSizes({ 50, 25, 33, 67 }, { 50 })


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
 