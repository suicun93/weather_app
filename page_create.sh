#!/usr/bin/env sh
# Reset
Color_Off='\033[0m' # Text Reset

# Regular Colors
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan

color=$Green

if [ -z "$1" ]; then
  echo "${Red}Please enter the ${Yellow}'page_name'\n$Color_Off"
  echo "${Purple}Example:${Cyan}\n\t ./page_create.sh ${Yellow}page_name\n$Color_Off"
  echo "${Purple}This is shortcut to do all steps below$Color_Off"
  echo "${Cyan}\tget create page:${Yellow}page_name$Color_Off"
  echo "${Cyan}\tget create controller:${Yellow}page_name${Cyan} with examples/controller$Color_Off"
  echo "${Cyan}\tget create provider:${Yellow}page_name\n$Color_Off"
  exit 1
fi

get create page:$1
get create controller:$1 with examples/controller on $1
get create provider:$1 on $1
mv lib/app/modules/$1/controllers/$1.controller.dart lib/app/modules/$1
mv lib/app/modules/$1/providers/$1.provider.dart lib/app/modules/$1
rmdir lib/app/modules/$1/controllers
rmdir lib/app/modules/$1/providers