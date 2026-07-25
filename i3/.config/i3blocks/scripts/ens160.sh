#!/usr/bin/env bash
# i3blocks: AHT21 + вологість ґрунту (JSON з ESP32)
#
# ESP32 знаходиться через mDNS (ens160.local) або задається в config через оточення:
#   command=ESP_HOST=192.168.1.50 TEMP_OFFSET=-2 HUM_OFFSET=5 $HOME/.config/i3blocks/scripts/ens160.sh
# або редагується тут:
ESP_HOST="${ESP_HOST:-ens160.local}"
TEMP_OFFSET="${TEMP_OFFSET:-0}"
HUM_OFFSET="${HUM_OFFSET:-0}"
URL="http://${ESP_HOST}/json"
CSV_FILE="${CSV_FILE:-$HOME/.cache/ens160.csv}"
GRAPH_SCRIPT="$HOME/.config/i3blocks/scripts/ens160-graphs.py"
PYTHON="/home/air/.platformio/penv/bin/python"
PID_FILE="/tmp/ens160-graphs.pid"

case "${BLOCK_BUTTON:-0}" in
1)
  if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    pkill -f "ens160-graphs" 2>/dev/null
    rm -f "$PID_FILE"
  else
    nohup "$PYTHON" "$GRAPH_SCRIPT" >/dev/null 2>&1 &
    echo $! > "$PID_FILE"
  fi
  ;;
esac

json=$(curl -s --max-time 3 "$URL")
if [ -z "$json" ]; then
  echo "н/д"
  echo "н/д"
  exit 0
fi

read -r temp hum soil soil2 < <(
  echo "$json" | jq -r '[.temperature, .humidity, .soil, .soil2] | @tsv'
)

temp=$(awk "BEGIN {print $temp + $TEMP_OFFSET}")
hum=$(awk "BEGIN {print $hum + $HUM_OFFSET}")

tempr=$(printf '%.1f' "$temp" 2>/dev/null || echo "$temp")
humr=$(printf '%.0f' "$hum" 2>/dev/null || echo "$hum")
[ "$soil" = "null" ] && soil="--"
[ "$soil2" = "null" ] && soil2="--"

echo "$(date +%s),$tempr,$humr,$soil,$soil2" >> "$CSV_FILE"

full="${tempr}°C ${humr}% ${soil}/${soil2}"
short="${tempr}° ${humr}% ${soil}/${soil2}"

echo "$full"
echo "$short"
