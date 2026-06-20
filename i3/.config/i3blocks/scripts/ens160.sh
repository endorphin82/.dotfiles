#!/usr/bin/env bash
# i3blocks: AHT21 + вологість ґрунту (JSON з ESP32)
#
# ESP32 знаходиться через mDNS (ens160.local) або задається в config через оточення:
#   command=ESP_HOST=192.168.1.50 $HOME/.config/i3blocks/scripts/ens160.sh
# або редагується тут:
ESP_HOST="${ESP_HOST:-ens160.local}"
URL="http://${ESP_HOST}/json"

json=$(curl -s --max-time 3 "$URL")
if [ -z "$json" ]; then
  echo "н/д"
  echo "н/д"
  exit 0
fi

read -r temp hum soil < <(
  echo "$json" | jq -r '[.temperature, .humidity, .soil] | @tsv'
)

tempr=$(printf '%.1f' "$temp" 2>/dev/null || echo "$temp")
humr=$(printf '%.0f' "$hum" 2>/dev/null || echo "$hum")
[ "$soil" = "null" ] && soil="--"

full="${tempr}°C ${humr}% ${soil}"
short="${tempr}° ${humr}% ${soil}"

echo "$full"
echo "$short"
