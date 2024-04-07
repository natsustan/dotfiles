-- 监听应用程序启动事件
hs.application.watcher.new(function(appName, eventType, appObject)
  -- 检查是否是 Kitty 应用程序启动了
  if (eventType == hs.application.watcher.launched) and (appName == "kitty") then
    -- 获取屏幕尺寸和中心点
    local screenFrame = hs.screen.mainScreen():frame()
    local screenCenter = hs.geometry.rectMidPoint(screenFrame)

    -- 设置 Kitty 窗口的尺寸
    local kittyWindowSize = hs.geometry.size(800, 600)     -- 根据需要调整这个尺寸

    -- 计算 Kitty 窗口的新位置，使其居中
    local kittyWindowFrame = hs.geometry.rect(
      screenCenter.x - kittyWindowSize.w / 2,
      screenCenter.y - kittyWindowSize.h / 2,
      kittyWindowSize.w,
      kittyWindowSize.h
    )

    -- 获取 Kitty 窗口并移动到新位置
    local kittyWindow = appObject:mainWindow()
    if kittyWindow then
      kittyWindow:setFrame(kittyWindowFrame)
    end
  end
end):start()
