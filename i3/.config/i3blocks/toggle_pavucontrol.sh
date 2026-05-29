#!/bin/bash

# Шукаємо реальний процес pavucontrol
if pgrep -x "pavucontrol" >/dev/null; then
  pkill -x "pavucontrol"
else
  # Перенаправлення виводу обов'язкове, щоб i3blocks не зникав!
  pavucontrol >/dev/null 2>&1 &
fi
