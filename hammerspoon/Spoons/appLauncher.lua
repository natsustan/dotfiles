launcherHotkey = {'option'}

applist = {
    {shortcut = 'F', appname = 'Finder'},
    {shortcut = 'L', appname = 'Logseq'},
    {shortcut = 'W', appname = 'WeChat'},
    {shortcut = 'N', appname = 'Notes'},
    {shortcut = 'E', appname = 'Eagle'},
    {shortcut = 'I', appname = 'iPhone Mirroring'},
}

hs.fnutils.each(applist, function(entry)
    hs.hotkey.bind(launcherHotkey, entry.shortcut, function()
        local app = hs.application.find(entry.appname)
        if app and app:isFrontmost() then
            app:hide()
        else
            hs.application.launchOrFocus(entry.appname)
        end
    end)
end)
