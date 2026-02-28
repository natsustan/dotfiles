#!/bin/bash

# 确定 session 名称：参数 > 当前目录名
BASE_NAME="${1:-$(basename "$PWD")}"

# 重名处理：自动追加数字后缀
SESSION_NAME="$BASE_NAME"
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  i=2
  while tmux has-session -t "${BASE_NAME}-${i}" 2>/dev/null; do
    ((i++))
  done
  SESSION_NAME="${BASE_NAME}-${i}"
fi

# 创建新 session
tmux new-session -d -s "$SESSION_NAME"

# 左右分割，左侧 60%（即右侧 40%）
tmux split-window -h -t "${SESSION_NAME}:1.1" -l 40%

# 右侧 pane 上下分割为 3 个
tmux split-window -v -t "${SESSION_NAME}:1.2" -l 66%
tmux split-window -v -t "${SESSION_NAME}:1.3" -l 50%

# 右上 pane(2) 运行 lazygit
tmux send-keys -t "${SESSION_NAME}:1.2" "lazygit" C-m

# 右中 pane(3) 运行 yazi
tmux send-keys -t "${SESSION_NAME}:1.3" "yazi" C-m

# 选回左侧主 pane
tmux select-pane -t "${SESSION_NAME}:1.1"

# 附加到 session
tmux attach-session -t "$SESSION_NAME"
