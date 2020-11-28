#!/bin/bash

#install stuff
what=${PWD##*/}   
extension=.sh
#peut être extension vide 
 
echo "killing running instances"
killall $what

echo "remove symbolic link from usr bin"
sudo rm /usr/bin/$what

echo "Please, manually remove $what alias in $HOME/.bashrc"

read -p "Open $HOME/.bashrc file ? (yes/no) :" yn
 case $yn in
        [Yy]* ) kate "$HOME/.bashrc"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac

echo "You may also want to remove cache folder ~/.cache/jumps";
echo "done."


