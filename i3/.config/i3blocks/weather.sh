#!/bin/bash

# При кліку відкриваємо детальний прогноз для Харкова в браузері
if [ "$BLOCK_BUTTON" -eq 1 ]; then
  xdg-open "https://uk.wttr.in/Kharkiv?" &
fi

# Запит погоди для Харкова українською мовою (%c - емодзі, %t - температура)
WEATHER=$(curl -s -H "Accept-Language: uk" "wttr.in/Kharkiv?format=%c%t" | xargs)

# Перевірка на помилку мережі або блокування
if [ -z "$WEATHER" ] || [[ "$WEATHER" == *"Unknown"* ]] || [[ "$WEATHER" == *"502"* ]]; then
  echo "Харків: помилка"
  echo "Харків: помилка"
  echo "#E74C3C"
else
  echo "🏙️ Харків: $WEATHER"
  echo "$WEATHER"
  echo "#3498DB"
fi
