#!/bin/bash

#####################################
# ###### PYTHON CONVENIENCE  ###### #
#####################################

[ -z "$PS1" ] && return


if ! have python ; then 
    if have python3; then
        alias python=python3
    fi
    if have python2.7; then
	alias python=python2.7
    fi
fi
