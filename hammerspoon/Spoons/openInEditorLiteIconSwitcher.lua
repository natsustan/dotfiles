local function setOpenInEditorLiteIcon(dark)
    -- 如果安装到其他路径，请替换下面的路径
    local appPath = "/Applications/OpenInEditor-Lite.app"
    -- 根据你想使用的图标(editor, atom, sublime, vscode)来更改下面的类型
    local iconType = "vscode"
    local iconsFolder = hs.fs.currentDir() .. "/Icons/OpenInTerminal-Lite-Icons"
    local theme = dark and "dark" or "light"
    hs.execute('fileicon set "' .. appPath .. '" "' .. iconsFolder .. "/icon_" .. iconType .. "_" .. theme .. '.icns"', true)
  end
  
  local function setOpenInTerminalLiteIcon(dark)
    -- 如果安装到其他路径，请替换下面的路径
    local appPath = "/Applications/OpenInTerminal-Lite.app"
    -- 根据你想使用的图标(terminal, iterm, hyper)来更改下面的类型
    local iconType = "terminal"
    local iconsFolder = hs.fs.currentDir() .. "/Icons/OpenInTerminal-Lite-Icons"
    local theme = dark and "dark" or "light"
    hs.execute('fileicon set "' .. appPath .. '" "' .. iconsFolder .. "/icon_" .. iconType .. "_" .. theme .. '.icns"', true)
  end

  local function updateIcons()
    darkMode = (hs.settings.get("AppleInterfaceStyle") == "Dark")
    setOpenInEditorLiteIcon(darkMode)
    setOpenInTerminalLiteIcon(darkMode)
  end
  
  updateIcons()
  hs.settings.watchKey("dark_mode", "AppleInterfaceStyle", function()
    updateIcons()
  end)
