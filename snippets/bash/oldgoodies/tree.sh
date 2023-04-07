#!/bin/bash

#####################################
# ####### BASH CONVENIENCE   ###### #
#####################################

[ -z "$PS1" ] && return

if (( UID == 0 )); then
	treeopt="$treeopt -a"
fi

case $OSTYPE in
        linux-gnu*|cygwin)
                ;;
        freebsd*)
                ;;
        gnu)
                ;;
        netbsd|openbsd*)
                ;;
        *)
                ;;
esac
alias tree="tree $treeopt"
unset treeopt


