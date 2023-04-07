#!/bin/bash

#####################################
# ####### TENTRR FUNCTIONS ######## #
#####################################

[ -z "$PS1" ] && return

        
if [ -d ~/Documents/Vagrants/tentrrdev/ ]; then 
    alias t='cd ~/Documents/Vagrants/tentrrdev'
elif [ -d ~/vagrants/tentrrdev/ ]; then
    alias t='cd ~/vagrants/tentrrdev'
else    
    alias t='Dont know where tentrrdev lives'
fi


alias wfclean="git status  -uno |grep web|sed -e 's/.*web/web/' |xargs git checkout -- " ## Webflow Clean ..Build process leaves alot of unwanted changes around
alias gitmod="git status -uno |grep modified | sed -e 's/.*modified:\s*//'| xargs git add -- "
