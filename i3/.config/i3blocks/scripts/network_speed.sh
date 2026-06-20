#!/bin/bash

STATE="/tmp/i3blocks_net_speed"
IFACE=$(ip route | awk '/default/ {print $5}' | head -1)
[ -z "$IFACE" ] && echo "down" && exit 0

NOW=$(awk -v iface="$IFACE" '$1 == iface":" {print $2, $10}' /proc/net/dev)
[ -z "$NOW" ] && echo "down" && exit 0

read -r RX TX <<<"$NOW"

if [ -f "$STATE" ]; then
  read -r OLD_TS OLD_RX OLD_TX <"$STATE"
  DELTA=$(($(date +%s) - OLD_TS))
else
  DELTA=1
fi

if [ "$DELTA" -gt 0 ]; then
  DOWN=$(((RX - ${OLD_RX:-RX}) / DELTA))
  UP=$(((TX - ${OLD_TX:-TX}) / DELTA))
else
  DOWN=0
  UP=0
fi

format_speed() {
  local val=$1
  if [ "$val" -ge 1048576 ]; then
    awk "BEGIN { printf \"%.1fMB\", $val / 1048576 }"
  elif [ "$val" -ge 1024 ]; then
    awk "BEGIN { printf \"%.0fKB\", $val / 1024 }"
  elif [ "$val" -gt 0 ]; then
    echo "${val}B"
  else
    echo "0"
  fi
}

echo "$(date +%s) $RX $TX" >"$STATE"

echo "$(format_speed $DOWN)$(format_speed $UP)"
