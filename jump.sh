#!/bin/bash

GREEN='\033[0;32m' 
LGREEN='\033[1;32m' 
WHITE='\033[1;37m'
YELL='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
 


target=$(find $PWD -type d -iname "$1")
 
printf "Jumping to ${YELL}'${target}'${NC}\nn"

cd $target

##source ${BASH_SOURCE[0]}
##Ceci fonctionne
#source jump ripped # pour aller jusqu'au dossier ripped
