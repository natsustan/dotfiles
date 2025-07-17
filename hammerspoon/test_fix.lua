-- 测试错误处理修复
print(=== 测试Hammerspoon错误处理修复 ===)

-- 测试安全的应用程序操作
local function testSafeAppOperation()
    print(测试安全的应用程序操作...")
    
    -- 测试获取不存在的应用程序
    local nonExistentApp = hs.application.get(NonExistentApp12345    if nonExistentApp then
        print("警告: 获取到了不存在的应用程序")
    else
        print("✓ 正确处理了不存在的应用程序")
    end
    
    -- 测试获取系统进程
    local systemApp = hs.application.get(SystemUIServer")
    if systemApp then
        print("✓ 成功获取系统应用程序)
        -- 测试安全地获取应用名称
        local success, appName = pcall(function() return systemApp:name() end)
        if success then
            print("✓ 成功获取应用名称: " .. appName)
        else
            print("✗ 获取应用名称失败: " .. appName)
        end
    else
        print("✗ 无法获取系统应用程序)
    end
end

-- 测试窗口操作
local function testWindowOperation()
    print("\n测试窗口操作...")
    
    local focusedWindow = hs.window.focusedWindow()
    if focusedWindow then
        print("✓ 成功获取焦点窗口")
        
        -- 测试安全地获取应用
        local success, app = pcall(function() return focusedWindow:application() end)
        if success and app then
            print("✓ 成功获取窗口对应的应用程序")
            
            -- 测试安全地获取应用名称
            local nameSuccess, appName = pcall(function() return app:name() end)
            if nameSuccess then
                print("✓ 成功获取应用名称: " .. appName)
            else
                print("✗ 获取应用名称失败: " .. appName)
            end
        else
            print("✗ 获取窗口对应的应用程序失败)      end
    else
        print("✗ 无法获取焦点窗口)
    end
end

-- 运行测试
testSafeAppOperation()
testWindowOperation()

print(n=== 测试完成 ===")
print("如果看到 ✓ 标记，说明错误处理正常工作")
print("如果看到 ✗ 标记，说明仍有问题需要解决") 