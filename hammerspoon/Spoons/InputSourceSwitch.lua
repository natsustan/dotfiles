-- Automatically switch the input source when switching applications.

-- 自动切换输入法
local function English()
  -- ABC
  hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

local function Chinese()
  -- hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
  hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Hans")
end


-- app to expected ime config
-- app和对应的输入法
local app2Ime = {
  -- System
  { 'Spotlight', 'English' },
  { 'Safari', 'Chinese' },
  { 'Finder', 'Chinese' },
  { 'Notes', 'Chinese' },
  { 'Calendar', 'Chinese' },
  { 'Reminders', 'Chinese' },
  { 'Pages', 'Chinese' },
  { 'Numbers', 'Chinese' },
  { 'Keynote', 'Chinese' },
  -- IM
  { 'DingTalk', 'Chinese' },
  { 'Telegram', 'Chinese' },
  { 'WeChat', 'Chinese' },
  { 'Slack', 'Chinese' },
  -- Note-taking
  { 'Notion', 'Chinese' },
  { 'Drafts', 'Chinese' },
  { 'Logseq', 'Chinese' },
  { 'Craft', 'Chinese' },
  { 'Things3', 'Chinese' },
  { 'MindNode', 'Chinese' },
  { 'Obsidian', 'Chinese' },
  { 'Heptabase', 'Chinese' },
  { 'Tana', 'Chinese' },
  -- Tool
  { 'Raycast', 'English' },
  { 'ChatGPT', 'Chinese' },
  { 'Twitter', 'Chinese' },
  { 'Microsoft PowerPoint', 'Chinese' },
  { 'Microsoft Excel', 'Chinese' },
  { 'Microsoft Word', 'Chinese' },
  { 'Visual Studio Code', 'English' },
  { 'Figma', 'Chinese' },
  { 'Bear', 'Chinese' },
  { 'OpenCat', 'Chinese' },
  { 'ServerCat', 'English' },
  { 'Arc', 'Chinese' },
  { 'Alfred 5', 'English' },
}

function updateFocusAppInputMethod()
  local ime = 'English'
  local focusApp = hs.window.frontmostWindow():application()
  local focusAppName = focusApp:name()
  
  for _, app in ipairs(app2Ime) do
    local appName = app[1]
    local expectedIme = app[2]

    if focusAppName == appName then
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

-- Handle cursor focus and application's screen manage.
-- 窗口激活时自动切换输入法
function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated or eventType == hs.application.watcher.launched) then
    updateFocusAppInputMethod()
  end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
