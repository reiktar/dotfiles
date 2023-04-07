#!/bin/bash

#####################################
# ##### BASH WELCOME SCRIPT   ##### #
#####################################

#clear
e_header "WELCOME"
e_note "User  :  $USER "
e_note "Date  :  $(date)"
e_note "Uptime: $(uptime)"
e_note "Uname:   $(uname -a) "

if [ -f /etc/lsb-release ]; then 
    (. /etc/lsb-release && 
         e_note "LSB: $(uname -r) - $DISTRIB_ID $DISTRIB_RELEASE $DISTRIB_CODENAME"
    )
fi

