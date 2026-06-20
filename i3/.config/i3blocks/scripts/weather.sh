#!/bin/bash

if [ "$BLOCK_BUTTON" -eq 1 ]; then
  xdg-open "https://uk.wttr.in/Kharkiv?" &
fi

WEATHER=$(curl -s -H "Accept-Language: uk" "wttr.in/Kharkiv?format=%c%t" | xargs)

if [ -z "$WEATHER" ] || [[ "$WEATHER" == *"Unknown"* ]] || [[ "$WEATHER" == *"502"* ]]; then
  echo "Харків: помилка"
  echo "Харків: помилка"
  echo "#f38ba8"
else
  echo " Харків: $WEATHER"
  echo "$WEATHER"
  echo "#89b4fa"
fi
