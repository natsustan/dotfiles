-- 自动切换输入法
local function English()
    -- ABC
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

local function Chinese()
    -- 简体拼音
    -- hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
    hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Hans")
end


-- app to expected ime config
-- app和对应的输入法
local app2Ime = {
-- System
    {'/System/Library/CoreServices/Spotlight.app', 'English'},
    {'/System/Library/CoreServices/Finder.app', 'Chinese'},
    {'/System/Applications/Notes.app', 'Chinese'},
    {'/System/Applications/Calendar.app', 'Chinese'},
    {'/System/Applications/Reminders.app', 'Chinese'},
    {'/Applications/Pages.app', 'Chinese'},
    {'/Applications/Numbers.app', 'Chinese'},
    {'/Applications/Keynote.app', 'Chinese'},
-- IM
    {'/Applications/DingTalk.app', 'Chinese'},
    {'/Applications/Telegram.app', 'Chinese'},
    {'/Applications/WeChat.app', 'Chinese'},
    {'/Applications/Slack.app', 'Chinese'},
-- Note-taking
    {'/Applications/Notion.app', 'Chinese'},
    {'/Applications/Logseq.app', 'Chinese'},
    {'/Applications/Craft.app', 'Chinese'},
    {'/Applications/Things3.app', 'Chinese'},
    {'/Applications/MindNode.app', 'Chinese'},
    {'/Applications/Obsidian.app', 'Chinese'},
    {'/Applications/Heptabase.app', 'Chinese'},
-- Tool
    {'/Users/spkz/Applications/ChatGPT.app', 'Chinese'},
    {'/Users/spkz/Applications/Notion.app', 'Chinese'},
    {'/Users/spkz/Applications/Twitter.app', 'Chinese'},
    {'/Applications/Microsoft Powerpoint.app', 'Chinese'},
    {'/Applications/Microsoft Excel.app', 'Chinese'},
    {'/Applications/Microsoft Word.app', 'Chinese'},
    {'/Applications/Visual Studio Code.app', 'English'},
    {'/Applications/Figma.app', 'Chinese'},
    {'/Applications/MindNode.app', 'Chinese'},
    {'/Applications/Bear.app', 'Chinese'},
    {'/Applications/Craft.app', 'Chinese'},
    {'/Applications/OpenCat.app', 'Chinese'},
    {'/Applications/ServerCat.app', 'English'},
}

function updateFocusAppInputMethod()
    local ime = 'English'
    local focusAppPath = hs.window.frontmostWindow():application():path()
    for index, app in pairs(app2Ime) do
        local appPath = app[1]
        local expectedIme = app[2]

        if focusAppPath == appPath then
            ime = expectedIme
            break
        end
    end

    if ime == 'English' then
        English()
    else
        Chinese()
    end
end

-- helper hotkey to figure out the app path and name of current focused window
-- ⌃ + ⌘ +.时会显示应用的路径等信息
hs.hotkey.bind({'control', 'cmd'}, ".", function()
    hs.alert.show("App Path:        "
    ..hs.window.focusedWindow():application():path()
    .."\n"
    .."App Name:      "
    ..hs.window.focusedWindow():application():name()
    .."\n"
    .."IM Source ID:  "
    ..hs.keycodes.currentSourceID(),{textSize=20},3)
end)

-- Handle cursor focus and application's screen manage.
-- 窗口激活时自动切换输入法
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated or eventType == hs.application.watcher.launched) then
        updateFocusAppInputMethod()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
