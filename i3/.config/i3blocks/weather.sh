#!/bin/bash
#
## Обробка кліку: при натисканні відкриваємо повний прогноз у браузері
#if [ "$BLOCK_BUTTON" -eq 1 ]; then
#  xdg-open "https://wttr.in" &
#fi
#
## Отримуємо погоду в один рядок (Температура + смайлик стану)
## %c - емодзі погоди, %t - температура (наприклад, ⛅️+15°C)
#WEATHER=$(curl -s "wttr.in/?format=%c%t" | xargs)
#
## Якщо сервіс недоступний, виводимо помилку, щоб бар не завис
#if [ -z "$WEATHER" ] || [[ "$WEATHER" == *"Unknown"* ]]; then
#  echo "Немає зв'язку"
#  echo "Немає зв'язку"
#  echo "#E74C3C" # Червоний колір помилки
#else
#  echo "$WEATHER" # Повний текст
#  echo "$WEATHER" # Короткий текст
#  echo "#3498DB"  # Гарний блакитний колір для погоди
#fi
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
