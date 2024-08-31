-- 设置 hs.alert 的默认样式
hs.alert.defaultStyle.strokeColor = { white = 0, alpha = 1 } -- 边框颜色
hs.alert.defaultStyle.textFont = "SF Mono"                   -- 字体
hs.alert.defaultStyle.textSize = 18                          -- 文字大小
hs.alert.defaultStyle.radius = 10                            -- 圆角大小

-- Load Spoons files
require ("Spoons.appLauncher")
-- require ("Spoons.appInfo")
require ("Spoons.autoReload")
require ("Spoons.doubleQToQuit")
require ("Spoons.inputSourceSwitcher")
-- require ("Spoons.autoQuits")
-- require ("Spoons.autoBetterDisplay")
require ("Spoons.kittyKeepCenter")

hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys({})
spoon.ShiftIt:setWindowCyclingSizes({ 50, 25, 33, 67 }, { 50 })

-- hs.loadSpoon("InputSourceSwitch")

-- spoon.InputSourceSwitch:setApplications({
--     ["WeChat"] = "Squirrel - Simplified",
--     ["Mail"] = "Squirrel - Simplified",
--     ["Calendar"] = "Squirrel - Simplified",
--     ["Reminders"] = "Squirrel - Simplified",
--     ["Pages"] = "Squirrel - Simplified",
--     ["Numbers"] = "Squirrel - Simplified",
--     ["Keynote"] = "Squirrel - Simplified",
--     ["DingTalk"] = "Squirrel - Simplified",
--     ["Telegram"] = "Squirrel - Simplified",
--     ["Slack"] = "Squirrel - Simplified",
--     ["Notion"] = "Squirrel - Simplified",
--     ["Safari"] = "Squirrel - Simplified",
--     ["Spotlight"] = "ABC",
--     ["Cursor"] = "ABC",
-- })

-- spoon.InputSourceSwitch:start()
