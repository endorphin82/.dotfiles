#!/bin/bash

# Захист від подвійних кліків (дебаунс)
if [ -f /tmp/blue_lock ]; then
  exit 0
fi
touch /tmp/blue_lock

# Шукаємо БУДЬ-ЯКИЙ запущений процес, який містить слово blueman-manager
if pgrep -f "blueman-manager" >/dev/null 2>&1; then
  # Якщо процес є в системі — примусово вбиваємо його
  pkill -f "blueman-manager"
else
  # Якщо процесу немає — запускаємо вікно
  blueman-manager >/dev/null 2>&1 &
fi

sleep 0.1
rm -f /tmp/blue_lock
