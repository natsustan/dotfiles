-- 设置 hs.alert 的默认样式
hs.alert.defaultStyle.strokeColor = { white = 0, alpha = 1 } -- 边框颜色
hs.alert.defaultStyle.textFont = "FiraCode Nerd Font Mono"   -- 字体
hs.alert.defaultStyle.textSize = 18                          -- 文字大小
hs.alert.defaultStyle.radius = 10                            -- 圆角大小

-- Load Spoons files
require ("Spoons.appLauncher")
require ("Spoons.appInfo")
require ("Spoons.spoonAutoReload")
require ("Spoons.doubleQToQuit")
require ("Spoons.input_auto_switcher")
require ("Spoons.iconChanger")
require ("Spoons.autoQuits")
require ("Spoons.autoBetterDisplay")
