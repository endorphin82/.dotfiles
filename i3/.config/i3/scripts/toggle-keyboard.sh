#!/bin/sh
if setxkbmap -query | grep -q us; then
  setxkbmap ua
else
  setxkbmap us
fi
pkill -RTMIN+12 i3blocks
