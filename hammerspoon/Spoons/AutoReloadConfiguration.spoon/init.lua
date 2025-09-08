--- === AutoReloadConfiguration ===
---
--- Automatically reload Hammerspoon configuration when Lua files change
---
--- Download: [https://github.com/Hammerspoon/Spoons](https://github.com/Hammerspoon/Spoons)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "AutoReloadConfiguration"
obj.version = "1.0"
obj.author = "Edward"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.logger = hs.logger.new('AutoReloadConfiguration')

--- AutoReloadConfiguration.logLevel
--- Variable
--- Log level for the AutoReloadConfiguration spoon. Can be set to 'nothing', 'error', 'warning', 'info', 'debug', or 'verbose' for increasing verbosity.
obj.logLevel = 'info'

--- AutoReloadConfiguration.watchPath
--- Variable
--- Path to watch for configuration changes. Defaults to hs.configdir
obj.watchPath = hs.configdir

--- AutoReloadConfiguration.showAlert
--- Variable
--- Whether to show an alert when configuration is reloaded. Defaults to true
obj.showAlert = true

--- AutoReloadConfiguration:init()
--- Method
--- Initialize the AutoReloadConfiguration spoon
---
--- Parameters:
---  * None
---
--- Returns:
---  * The AutoReloadConfiguration object
function obj:init()
    self.logger.setLogLevel(self.logLevel)
    return self
end

--- AutoReloadConfiguration:start()
--- Method
--- Start watching for configuration changes
---
--- Parameters:
---  * None
---
--- Returns:
---  * The AutoReloadConfiguration object
function obj:start()
    self.logger.i("Starting AutoReloadConfiguration")
    
    if self.watcher then
        self.logger.w("AutoReloadConfiguration is already running")
        return self
    end
    
    self.watcher = hs.pathwatcher.new(self.watchPath, function(files)
        self:reload(files)
    end)
    
    self.watcher:start()
    self.logger.i("AutoReloadConfiguration started, watching: " .. self.watchPath)
    
    return self
end

--- AutoReloadConfiguration:stop()
--- Method
--- Stop watching for configuration changes
---
--- Parameters:
---  * None
---
--- Returns:
---  * The AutoReloadConfiguration object
function obj:stop()
    self.logger.i("Stopping AutoReloadConfiguration")
    
    if self.watcher then
        self.watcher:stop()
        self.watcher = nil
        self.logger.i("AutoReloadConfiguration stopped")
    else
        self.logger.w("AutoReloadConfiguration is not running")
    end
    
    return self
end

--- AutoReloadConfiguration:reload(files)
--- Method
--- Handle file changes and reload configuration if needed
---
--- Parameters:
---  * files - Table of changed file paths
---
--- Returns:
---  * None
function obj:reload(files)
    self.logger.d("Configuration change detected")
    local doReload = false

    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
            self.logger.i("Detected .lua file change: " .. file)
        end
    end

    if doReload then
        self.logger.i("Reloading Hammerspoon configuration")
        hs.console.clearConsole()
        
        if self.showAlert then
            hs.alert.show("🔨 Hammerspoon Config Reloaded", 1)
        end
        
        hs.reload()
    end
end

--- AutoReloadConfiguration:setWatchPath(path)
--- Method
--- Set the path to watch for configuration changes
---
--- Parameters:
---  * path - String path to watch
---
--- Returns:
---  * The AutoReloadConfiguration object
function obj:setWatchPath(path)
    self.watchPath = path
    self.logger.i("Watch path set to: " .. path)
    
    -- Restart watcher if currently running
    if self.watcher then
        self:stop()
        self:start()
    end
    
    return self
end

--- AutoReloadConfiguration:setShowAlert(show)
--- Method
--- Set whether to show alert when configuration is reloaded
---
--- Parameters:
---  * show - Boolean, true to show alert, false to hide
---
--- Returns:
---  * The AutoReloadConfiguration object
function obj:setShowAlert(show)
    self.showAlert = show
    self.logger.i("Show alert set to: " .. tostring(show))
    return self
end

return obj
