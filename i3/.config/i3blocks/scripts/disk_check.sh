#!/bin/bash

if [ "${BLOCK_BUTTON:-0}" -eq 1 ]; then
  baobab / &
fi

FREE=$(df -h / | awk 'NR==2 {print $4}')
FREE_MB=$(df -m / | awk 'NR==2 {print $4}')

echo " $FREE"
echo " $FREE"

if [ "$FREE_MB" -lt 25600 ]; then
  echo "#f38ba8"
else
  echo "#a6e3a1"
fi
