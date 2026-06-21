#!/bin/bash

get_state() {
    xset q | grep -A4 "Screen Saver" | grep "timeout:" | awk '{print $2}'
}

STATE=$(get_state)

if [ "${BLOCK_BUTTON:-0}" -eq 1 ]; then
    if [ "$STATE" -gt 0 ]; then
        xset s off
        STATE=0
    else
        xset s on
        STATE=600
    fi
elif [ "${BLOCK_BUTTON:-0}" -eq 3 ]; then
    if [ "$STATE" -gt 0 ]; then
        notify-send "Screensaver" "Увімкнено"
    else
        notify-send "Screensaver" "Вимкнено"
    fi
fi

if [ "$STATE" -gt 0 ]; then
    echo ""
    echo ""
    echo "#f38ba8"
else
    echo ""
    echo ""
    echo "#585b70"
fi
