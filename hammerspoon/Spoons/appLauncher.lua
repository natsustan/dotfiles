launcherHotkey = {'option'}

applist = {
    {shortcut = 'F', appname = 'Finder'},
    -- {shortcut = 'L', appname = 'Logseq'},
    {shortcut = 'W', appname = 'WeChat'},
    -- {shortcut = 'N', appname = 'Notes'},
    -- {shortcut = 'E', appname = 'Eagle'},
    -- {shortcut = 'I', appname = 'iPhone Mirroring'},
    -- {shortcut = 'D', appname = 'DingTalk'},
    -- {shortcut = 'S', appname = 'Safari'},
    -- {shortcut = 'Y', appname = '阴阳师'},
    -- {shortcut = 'B', appname = 'BoltAI'},
    -- {shortcut = 'P', appname = 'Passwords'},
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
