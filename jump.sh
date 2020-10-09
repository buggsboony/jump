#!/bin/bash

GREEN='\033[0;32m' 
LGREEN='\033[1;32m' 
WHITE='\033[1;37m'
YELL='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
 


##version 1, iname :
#target=$(find $PWD -type d -iname "$1" | head -n 1)
##version 2, iwholname :

#target=$(find $PWD -type d -iwholename "*/$1" | head -n 1)  #ptet un probleme quand ya un dossier est symblink

cd $PWD
target=$(find . -type d -iwholename "*/$1" | head -n 1)

 

printf "Jumping to ${YELL}'${target}'${NC}\n"

cd "$target"

##source ${BASH_SOURCE[0]}
##Ceci fonctionne
#source jump ripped # pour aller jusqu'au dossier ripped
