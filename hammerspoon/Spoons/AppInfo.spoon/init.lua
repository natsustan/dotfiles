--- === AppInfo ===
---
--- Helper hotkey to figure out the app path and name of current focused window
---
--- Download: [https://github.com/Hammerspoon/Spoons](https://github.com/Hammerspoon/Spoons)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "AppInfo"
obj.version = "1.0"
obj.author = "Edward"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.logger = hs.logger.new('AppInfo')

--- AppInfo.logLevel
--- Variable
--- Log level for the AppInfo spoon. Can be set to 'nothing', 'error', 'warning', 'info', 'debug', or 'verbose' for increasing verbosity.
obj.logLevel = 'info'

--- AppInfo:init()
--- Method
--- Initialize the AppInfo spoon
---
--- Parameters:
---  * None
---
--- Returns:
---  * The AppInfo object
function obj:init()
    self.logger.setLogLevel(self.logLevel)
    return self
end

--- AppInfo:start()
--- Method
--- Start the AppInfo spoon
---
--- Parameters:
---  * None
---
--- Returns:
---  * The AppInfo object
function obj:start()
    self.logger.i("Starting AppInfo")
    
    -- helper hotkey to figure out the app path and name of current focused window
    -- ⌃ + ⌘ +.时会显示应用的路径等信息
    self.hotkey = hs.hotkey.bind({ 'control', 'cmd' }, ".", function()
        self:showAppInfo()
    end)
    
    return self
end

--- AppInfo:stop()
--- Method
--- Stop the AppInfo spoon
---
--- Parameters:
---  * None
---
--- Returns:
---  * The AppInfo object
function obj:stop()
    self.logger.i("Stopping AppInfo")
    
    if self.hotkey then
        self.hotkey:delete()
        self.hotkey = nil
    end
    
    return self
end

--- AppInfo:showAppInfo()
--- Method
--- Show information about the currently focused application
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:showAppInfo()
    local focusedWindow = hs.window.focusedWindow()
    if not focusedWindow then
        hs.alert.show("无法获取焦点窗口", 1)
        return
    end
    
    local app = focusedWindow:application()
    if not app then
        hs.alert.show("无法获取应用程序信息", 1)
        return
    end
    
    -- 安全获取应用信息
    local appPath = "未知"
    local appName = "未知"
    local imSourceId = "未知"
    
    -- 使用pcall来安全获取应用路径
    local success, result = pcall(function() return app:path() end)
    if success and result then
        appPath = result
    end
    
    -- 使用pcall来安全获取应用名称
    success, result = pcall(function() return app:name() end)
    if success and result then
        appName = result
    end
    
    -- 获取输入法源ID
    success, result = pcall(function() return hs.keycodes.currentSourceID() end)
    if success and result then
        imSourceId = result
    end

    -- 组合信息字符串
    local info = "App Path:        " .. appPath
        .. "\n"
        .. "App Name:      " .. appName
        .. "\n"
        .. "IM Source ID:  " .. imSourceId

    -- 显示信息
    hs.alert.show(info, 2)

    -- 将信息复制到剪贴板
    hs.pasteboard.setContents(info)
    
    self.logger.d("App info displayed: " .. appName)
end

return obj
