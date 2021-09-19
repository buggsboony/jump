#!/bin/bash

#install stuff
what=${PWD##*/}   
extension=.sh
#peut être extension vide
chmod +x $what$extension

echo "Adding alias in .bashrc"
echo  "" >> $HOME/.bashrc
echo  "### Jump alias generated code at $(date +"%Y-%m-%d %H:%I:%S" )" >> $HOME/.bashrc
echo  "jump() { source $PWD/$what.sh \$*; }" >> $HOME/.bashrc
 
#######################################################   completion parameters #########################
#enable autocompletion for jump parameter
 echo '_jump ()
{   
       #opts="help verbose version"
       opts="$(ls $HOME/.cache/jumps)"
     COMPREPLY=($(compgen -W "${opts}" \
       -- "${COMP_WORDS[COMP_CWORD]}")) 
   local IFS=$'\n'
   local LASTCHAR=' ' 
   if [ ${#COMPREPLY[@]} = 1 ]; then
       [ -d "$COMPREPLY" ] && LASTCHAR=/
       COMPREPLY=$(printf %q%s "$COMPREPLY" "$LASTCHAR")
   else
       for ((i=0; i < ${#COMPREPLY[@]}; i++)); do
           [ -d "${COMPREPLY[$i]}" ] && COMPREPLY[$i]=${COMPREPLY[$i]}/
       done
   fi
   return 0
} 
complete -o nospace -F _jump jump' >> $HOME/.bashrc
#######################################################   /completion parameters #########################

echo  "### /Jump alias generated code " >> $HOME/.bashrc


echo "done."
