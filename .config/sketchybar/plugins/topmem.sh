#!/usr/bin/env bash

TOPMEM=$(ps axo "rss,ucomm" | sort -nr | tail +1 | head -n1 | awk '{printf "%.0fMB %s\n", $1 / 1024, $2}' | sed -e 's/com.apple.//g')
MEM=$(echo $TOPMEM | sed -nr 's/([^MB]+).*/\1/p')

if [ $MEM -gt 32768 ]; then
  sketchybar -m set topmem label " $TOPMEM"
  sketchybar -m set topmem icon 
else
  sketchybar -m set topmem label ""
  sketchybar -m set topmem icon
fi
