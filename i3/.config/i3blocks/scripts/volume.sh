#!/bin/bash

case "$BLOCK_BUTTON" in
  1) ~/.config/i3blocks/scripts/toggle_pavucontrol.sh ;;
  4) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
  5) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
esac

MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")
VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')

if [ "$MUTED" = "MUTED" ] || [ "$VOL" -eq 0 ]; then
  echo " MUTE"
else
  echo " $VOL%"
fi
