launcherHotkey = {'option'}

applist = {
    {shortcut = 'F', appname = 'Finder'},
    {shortcut = 'A', appname = 'OpenCat'},
    {shortcut = 'B', appname = 'Bear'},
    {shortcut = 'L', appname = 'Logseq'},
    {shortcut = 'C', appname = 'Visual Studio Code'},
    {shortcut = 'W', appname = 'WeChat'},
    {shortcut = 'N', appname = 'Notion'},
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