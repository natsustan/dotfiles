--- === DoubleQToQuit ===
---
--- Press Cmd+Q twice to quit applications safely
---
--- Download: [https://github.com/Hammerspoon/Spoons](https://github.com/Hammerspoon/Spoons)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "DoubleQToQuit"
obj.version = "1.0"
obj.author = "Edward"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.logger = hs.logger.new('DoubleQToQuit')

--- DoubleQToQuit.logLevel
--- Variable
--- Log level for the DoubleQToQuit spoon. Can be set to 'nothing', 'error', 'warning', 'info', 'debug', or 'verbose' for increasing verbosity.
obj.logLevel = 'info'

--- DoubleQToQuit.timeout
--- Variable
--- Timeout in seconds for the modal to automatically exit. Defaults to 1 second.
obj.timeout = 1

--- DoubleQToQuit.alertDuration
--- Variable
--- Duration in seconds to show the alert message. Defaults to 1.5 seconds.
obj.alertDuration = 1.5

--- DoubleQToQuit.excludedApps
--- Variable
--- Table of application names that should not be quit. Defaults to {"SystemUIServer"}.
obj.excludedApps = {"SystemUIServer"}

--- DoubleQToQuit:init()
--- Method
--- Initialize the DoubleQToQuit spoon
---
--- Parameters:
---  * None
---
--- Returns:
---  * The DoubleQToQuit object
function obj:init()
    self.logger.setLogLevel(self.logLevel)
    return self
end

--- DoubleQToQuit:start()
--- Method
--- Start the double Q to quit functionality
---
--- Parameters:
---  * None
---
--- Returns:
---  * The DoubleQToQuit object
function obj:start()
    self.logger.i("Starting DoubleQToQuit")
    
    if self.quitModal then
        self.logger.w("DoubleQToQuit is already running")
        return self
    end
    
    -- Create the modal for double Q to quit
    self.quitModal = hs.hotkey.modal.new('cmd', 'q')
    
    -- Define the entered function
    function self.quitModal:entered()
        hs.alert.show("Press ⌘Q Again to Quit", obj.alertDuration)
        hs.timer.doAfter(obj.timeout, function() 
            self:exit() 
        end)
    end
    
    -- Define the quit function
    local function doQuit()
        local app = hs.application.frontmostApplication()
        if app then
            -- 添加安全检查
            local appName = app:name()
            if appName and not obj:isAppExcluded(appName) then
                obj.logger.i("Quitting application: " .. appName)
                app:kill()
            else
                hs.alert.show("无法获取应用程序信息或应用程序被排除", 1)
                obj.logger.w("Cannot quit app: " .. (appName or "unknown"))
            end
        else
            hs.alert.show("无法获取前台应用程序", 1)
            obj.logger.w("Cannot get frontmost application")
        end
    end
    
    -- Bind the quit function to cmd+q
    self.quitModal:bind('cmd', 'q', doQuit)
    
    -- Bind escape to exit the modal
    self.quitModal:bind('', 'escape', function() 
        self.quitModal:exit() 
    end)
    
    self.logger.i("DoubleQToQuit started successfully")
    return self
end

--- DoubleQToQuit:stop()
--- Method
--- Stop the double Q to quit functionality
---
--- Parameters:
---  * None
---
--- Returns:
---  * The DoubleQToQuit object
function obj:stop()
    self.logger.i("Stopping DoubleQToQuit")
    
    if self.quitModal then
        self.quitModal:exit()
        self.quitModal = nil
        self.logger.i("DoubleQToQuit stopped successfully")
    else
        self.logger.w("DoubleQToQuit is not running")
    end
    
    return self
end

--- DoubleQToQuit:isAppExcluded(appName)
--- Method
--- Check if an application is in the excluded list
---
--- Parameters:
---  * appName - String name of the application to check
---
--- Returns:
---  * Boolean, true if the app is excluded, false otherwise
function obj:isAppExcluded(appName)
    for _, excludedApp in ipairs(self.excludedApps) do
        if appName == excludedApp then
            return true
        end
    end
    return false
end

--- DoubleQToQuit:addExcludedApp(appName)
--- Method
--- Add an application to the excluded list
---
--- Parameters:
---  * appName - String name of the application to exclude
---
--- Returns:
---  * The DoubleQToQuit object
function obj:addExcludedApp(appName)
    if not self:isAppExcluded(appName) then
        table.insert(self.excludedApps, appName)
        self.logger.i("Added excluded app: " .. appName)
    else
        self.logger.w("App already excluded: " .. appName)
    end
    return self
end

--- DoubleQToQuit:removeExcludedApp(appName)
--- Method
--- Remove an application from the excluded list
---
--- Parameters:
---  * appName - String name of the application to remove from exclusion
---
--- Returns:
---  * The DoubleQToQuit object
function obj:removeExcludedApp(appName)
    for i, excludedApp in ipairs(self.excludedApps) do
        if excludedApp == appName then
            table.remove(self.excludedApps, i)
            self.logger.i("Removed excluded app: " .. appName)
            return self
        end
    end
    self.logger.w("App not found in excluded list: " .. appName)
    return self
end

--- DoubleQToQuit:setTimeout(seconds)
--- Method
--- Set the timeout for the modal to automatically exit
---
--- Parameters:
---  * seconds - Number of seconds for the timeout
---
--- Returns:
---  * The DoubleQToQuit object
function obj:setTimeout(seconds)
    self.timeout = seconds
    self.logger.i("Timeout set to: " .. seconds .. " seconds")
    return self
end

--- DoubleQToQuit:setAlertDuration(seconds)
--- Method
--- Set the duration for the alert message
---
--- Parameters:
---  * seconds - Number of seconds to show the alert
---
--- Returns:
---  * The DoubleQToQuit object
function obj:setAlertDuration(seconds)
    self.alertDuration = seconds
    self.logger.i("Alert duration set to: " .. seconds .. " seconds")
    return self
end

return obj
