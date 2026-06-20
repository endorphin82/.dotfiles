#!/bin/bash

# 1. Захист від подвійних блукаючих кліків i3blocks
if [ -f /tmp/taskmgr_lock ]; then
  exit 0
fi
touch /tmp/taskmgr_lock

# 2. Перевірка процесу за розширеним прапорцем -f
if pgrep -f "xfce4-taskmanager" >/dev/null; then
  pkill -f "xfce4-taskmanager"
else
  # Перенаправляємо виводи, щоб i3blocks не ховав блок
  xfce4-taskmanager >/dev/null 2>&1 &
fi

# 3. Звільняємо замок через 0.1 секунди
sleep 0.1
rm -f /tmp/taskmgr_lock
