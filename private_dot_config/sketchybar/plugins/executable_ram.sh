#!/bin/bash

# Get used memory in percentage
USED=$(memory_pressure | awk '/System-wide memory free percentage/ {printf("%d", 100-$5)}')

# Or alternatively:
# USED=$(vm_stat | awk '/Pages active/ {active=$3} /Pages wired down/ {wired=$3} /Pages speculative/ {spec=$3} END {printf "%.0f", (active+wired+spec)*4096/1024/1024/$(sysctl -n hw.memsize)*100}')

sketchybar --set $NAME label="${USED}%"

