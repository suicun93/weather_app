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
  echo "${Red}Please enter the ${Yellow}'view_name'\n$Color_Off"
  echo "${Purple}Example:${Cyan}\n\t ./view_create.sh ${Yellow}view_name ${Green}page_name\n$Color_Off"
  echo "${Purple}This is shortcut to do all steps below$Color_Off"
  echo "${Cyan}\tget create view:${Yellow}view_name$Cyan on ${Green}page_name$Color_Off"
  echo "${Cyan}\tget create controller:${Yellow}view_name$Cyan with examples/controller on ${Green}page_name$Color_Off"
  echo "${Cyan}\tget create provider:${Yellow}view_name$Cyan on ${Green}page_name\n$Color_Off"
  exit 1
fi
if [ -z "$2" ]; then
  echo "${Red}Please enter the ${Green}'page_name'\n$Color_Off"
  echo "${Purple}Example:${Cyan}\n\t ./view_create.sh ${Yellow}view_name ${Green}page_name\n$Color_Off"
  echo "${Purple}This is shortcut to do all steps below$Color_Off"
  echo "${Cyan}\tget create view:${Yellow}view_name$Cyan on ${Green}page_name$Color_Off"
  echo "${Cyan}\tget create controller:${Yellow}view_name$Cyan with examples/controller on ${Green}page_name$Color_Off"
  echo "${Cyan}\tget create provider:${Yellow}view_name$Cyan on ${Green}page_name\n$Color_Off"
  exit 1
fi
get create view:$2_$1 on $2
get create controller:$2_$1 with examples/controller on $2
get create provider:$2_$1 on $2
