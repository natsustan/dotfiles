#!/bin/bash

echo "重启Hammerspoon...

# 关闭Hammerspoon
osascript -e quit app Hammerspoon"'

# 等待一下确保完全关闭
sleep 2

# 重新启动Hammerspoon
open -a Hammerspoon

echoHammerspoon已重启，请检查菜单栏图标是否出现echo如果出现，说明配置已重新加载 