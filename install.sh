#!/bin/bash

#install stuff
what=${PWD##*/}   
extension=.sh
#peut être extension vide
chmod +x $what$extension

echo "Adding alias in .bashrc"
echo  "" >> $HOME/.bashrc
echo  "### Jump alias generated code at $(date +"%Y-%m-%d %H:%I:%S" )" >> $HOME/.bashrc
echo  "jump( ) { source $PWD/$what.sh \$*; }" >> $HOME/.bashrc
echo  "### /Jump alias generated code " >> $HOME/.bashrc


echo "done."
