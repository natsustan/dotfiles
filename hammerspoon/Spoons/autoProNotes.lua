local notesWatcher = nil
local notesAppName = "Notes"
local pronotesAppName = "ProNotes"

local function notesChangedCallback(name, event, app)
    if name == notesAppName then
        if event == hs.application.watcher.launched then
            hs.application.launchOrFocus(pronotesAppName)
        elseif event == hs.application.watcher.terminated then
            local pronotes = hs.application.get(pronotesAppName)
            if pronotes then
                pronotes:kill()
            end
        end
    end
end

notesWatcher = hs.application.watcher.new(notesChangedCallback)
notesWatcher:start()

hs.shutdownCallback = function()
    if notesWatcher then
        notesWatcher:stop()
        notesWatcher = nil
    end
end

return notesWatcher 