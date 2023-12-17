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
echo "\n${Blue}[Copyrights by DukeHoang] ${color}Building ${Cyan}[APK]${color} release version on ${Purple}[$ENV]${color}...$Color_Off"
flutter build apk -t lib/main.dart --release --flavor "$ENV"
open build/app/outputs/flutter-apk