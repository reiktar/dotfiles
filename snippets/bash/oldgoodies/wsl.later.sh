#!/bin/sh


if ! is_wsl; then return;fi


alias weasel=$WINHOME/weasel/weasel-pageant
weaselstart() {
    if [ ! -f $WINHOME/weasel/weasel-pageant ]; then
        e_error "Weasel not instaled or available" 
        return 1
    fi
    e_note "Starting weasel"
    eval $(weasel)
}

if [ "$SHLVL" -eq "1" ] ; then
   if [ -z $SSH_PAGEANT_PID ]; then
       weaselstart
       ssh-add -l

   fi
fi 

