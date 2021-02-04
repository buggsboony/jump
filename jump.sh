#!/bin/bash

GREEN='\033[0;32m' 
LGREEN='\033[1;32m' 
WHITE='\033[1;37m'
YELL='\033[1;33m'
RED='\033[0;31m'
LRED='\033[1;31m'
MAG='\033[0;35m'
LMAG='\033[1;35m'
CYAN='\033[0;36m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

mustexit=0

cachedir=$HOME/.cache/jumps
if [ ! -d $cachedir ];
then
    mkdir -p $cachedir       
    if [ ! -d $cachedir ];
    then 
        printf "Cache directory ${LRED}'$cachedir'${NC} does not exist.${NC}\n";
    else
        printf "Cache directory ${LGREEN}'$cachedir'${NC} created.\n";
    fi
fi



##### Nouvelles options  -d pour supprimer un fichier cache


arg="$1"
if [ -z "$1" ]; then
  printf "${YELL}USAGE :${NC}\n";
  printf "jump folder_name\n";
  printf "jump --list\n";
  return;
else 
   
    if [[ "$arg" == "--list" || "$arg" == "-l" || "$arg" == "-list" ]]; 
    then        
         printf "${YELL}Cache directory content :${NC}\n";
         ls -rt $cachedir    
         return;
         #Terminates script without closing terminal #exit script without closing shell         
    fi

    if [[ "$arg" == "--remove" || "$arg" == "-r" || "$arg" == "-rm" ]]; 
    then        
        target="${@:2}"
         printf "${MAG}Removing '$target' from cache directory :${NC}\n";
         cached="$cachedir/$target"
         echo "Content:"
         cat "$cached"
         echo "Action :"
         rm -i "$cached"
         return;
         #Terminates script without closing terminal #exit script without closing shell         
    fi
fi

readcache()
{
     jumpname="$1"
     path="$PWD/$2"   
     #echo $jumpname;     
     #echo $path;
     if [ "$path" == "" ]; then
        printf "";#Not found
     else
        cachefile="$cachedir/$jumpname"
        if [ -f "$cachefile" ]; then
            #get to content             
            target=$(cat "$cachefile")
        else
            target="";
        fi     
     fi
     echo $target
}

writecache()
{    
    if [[ "$target" == "" ]] ;then   
        printf "";
    else
            jumpname="$1" 
            path="$PWD/$2"               
            # echo JUMPNAME $jumpname;     
            # echo PATH $path;
            # echo CURRENT $PWD;
            if [ "$path" == "" ]; then
                printf "will not create an empty file"; #Not found
            else                                 
                cachefile="$cachedir/$jumpname"
                if [ -f "$cachefile" ]; then
                    #jump to content             
                    echo "jump to content";
                else
                    # Create content
                    #ask before continue (save and actually jump)
                    printf "Attempting to create cache file ${YELL}'$jumpname'${NC} path : \n ${WHITE}'$path'${NC} \n";                      
                    read -r -p "Continue ? " response
              
                    case "$response" in
                            [yY][eE][sS]|[yY]|[oO] )
                       
                         echo "$path">"$cachefile";                                        
                         printf "Cache file ${LGREEN}'$jumpname'${NC} created.\n";  
                        ;;
                        *)        
                        mustexit=1   
                        printf "Cache file ${WHITE}'$jumpname'${NC} not saved.\n";  
                    
                        ;;
                    esac                  
                fi     
            fi
     fi
}


##version 1, iname :
#target=$(find $PWD -type d -iname "$1" | head -n 1)
##version 2, iwholname :

#target=$(find $PWD -type d -iwholename "*/$1" | head -n 1)  #ptet un probleme quand ya un dossier est symblink

#cd $PWD


target=$(readcache "$1")


if [[ "$target" == "" ]];then   
    target=$(find . -type d -iwholename "*/$1" | head -n 1)     
        
    writecache "$1" "$target"

    if [[ "$mustexit" == "1" ]];then
       printf "${WHITE}OK, goodbye...${NC}\n"
        return;    
    fi

fi

#

#Read cache
#writecache "$1" "$target"


if [ "$target" == "" ];then  
   printf "Oups, nothing found...\n";
else
   printf "Jumping to ${YELL}'${target}'${NC}\n"
   cd "$target"
fi


##source ${BASH_SOURCE[0]}
##Ceci fonctionne
#source jump ripped # pour aller jusqu'au dossier ripped
