-- Automatically switch the input source when switching applications.

-- 启用 Spotlight 支持，以检查应用程序的替代名称
hs.application.enableSpotlightForNameSearches(true)

-- 自动切换输入法
local function English()
  -- ABC
  hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

local function Chinese()
  hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
  -- hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Hans")
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
  -- Note-taking
  { 'Notion', 'Chinese' },
  { 'Bear', 'Chinese' },
  { 'Logseq', 'Chinese' },
  { 'Craft', 'Chinese' },
  { 'MindNode', 'Chinese' },
  { 'Obsidian', 'Chinese' },
  { 'Ia Writer', 'Chinese' },
  -- Tool
  { 'Microsoft PowerPoint', 'Chinese' },
  { 'Microsoft Excel', 'Chinese' },
  { 'Microsoft Word', 'Chinese' },
  { 'Visual Studio Code', 'English' },
  { 'Cursor', 'English' },
  { 'Brave Browser', 'Chinese' },
  { 'Zed', 'English' },
  { 'Figma', 'Chinese' },
  { 'ServerCat', 'English' },
  { 'Arc', 'Chinese' },
  { 'Ghostty', 'English' },
  { '浙政钉', 'Chinese' },
  { '钉钉', 'Chinese' },
  { 'Pitch', 'Chinese' },
  { 'FireFox', 'Chinese' },
  { 'Delta', 'English' },
  { 'ProNotes', 'English' },
  { 'ChatWise', 'Chinese' },
}

function updateFocusAppInputMethod()
  local ime = 'English'
  local frontWindow = hs.window.frontmostWindow()
  if not frontWindow then return end

  local focusApp = frontWindow:application()
  if not focusApp then return end

  local focusAppName = focusApp:name()
  
  for _, app in ipairs(app2Ime) do
    local appName = app[1]
    local expectedIme = app[2]

    if focusAppName == appName or bundleID == appName then
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
