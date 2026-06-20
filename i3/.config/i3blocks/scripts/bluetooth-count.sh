#!/bin/bash

# Get list of all paired Bluetooth device MAC addresses
DEVICES=$(bluetoothctl devices Paired | cut -f2 -d' ')

# Count active connections
COUNT=0
for dev in $DEVICES; do
  if bluetoothctl info "$dev" | grep -q "Connected: yes"; then
    COUNT=$((COUNT + 1))
  fi
done

# Output the format for i3blocks
if [ "$COUNT" -gt 0 ]; then
  echo " $COUNT"
  echo " $COUNT"
  echo "#89b4fa" # Color when devices are connected
else
  echo " 0"
  echo " 0"
  echo "#585b70" # Color when no devices are connected
fi
