#!/bin/zsh
cd "$(dirname "$0")"
# Edited by Duke Hoang
# Colors
# Reset
Color_Off='\033[0m' # Text Reset

# Regular Colors
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan

if [ ! -z "$1" ]; then
  ENV=$1
else
  ENV="dev"
fi
color=$Green

echo "${Purple}Select device...$Yellow"
select device in "iPhone 12 Pro Max" "iPhone 14 Pro Max"; do
  if [ "$device" = "iPhone 12 Pro Max" ]; then
    id="00008101-000641EE22F1003A"
  else
    id="00008120-000669420EF8C01E"
  fi
  echo "\n${Blue}[Copyrights by Duke Hoang] ${color}Building ${Cyan}[Hoang's iPhone - ${Yellow}${device}]${color} release version on ${Purple}[$ENV]${color}...$Color_Off"
  flutter run -t lib/main.dart --release -d "$id" --flavor "$ENV"
  break
done
