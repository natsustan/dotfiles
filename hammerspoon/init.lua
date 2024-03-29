-- Load other files
require ("Spoons.inputMethodSwitcher")
-- require ("Spoons.appIconSwitcher")
-- require ("Spoons.autoBetterDisplay")
require ("Spoons.openInEditorLiteIconSwitcher")
require ("Spoons.auto_hs_reload")
require ("Spoons.double_cmd_q")
require ("Spoons.kittyHoldCenter")

-- 设置 hs.alert 的默认样式
hs.alert.defaultStyle.strokeColor = {white = 0, alpha = 1} -- 边框颜色
-- hs.alert.defaultStyle.fillColor = {white = 0, alpha = 0.75} -- 背景颜色
-- hs.alert.defaultStyle.textColor = {white = 1, alpha = 1} -- 文字颜色
hs.alert.defaultStyle.textFont = "Menlo" -- 字体
hs.alert.defaultStyle.textSize = 16 -- 文字大小
hs.alert.defaultStyle.radius = 10 -- 圆角大小
-- hs.alert.defaultStyle.fadeInDuration = 0.15 -- 渐现时间
-- hs.alert.defaultStyle.fadeOutDuration = 0.15 -- 渐隐时间
-- hs.alert.defaultStyle.atScreenEdge = 2 -- 位置（2为居中）