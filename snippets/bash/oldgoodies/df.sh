#!/bin/bash

#####################################
# #######   DF CONVENIENCE   ###### #
#####################################

[ -z "$PS1" ] && return

case $OSTYPE in
        linux-gnu*|cygwin)
                alias df='df -Th'
                alias dff='df -xtmpfs -xdevtmpfs -xrootfs -xecryptfs'
                ;;
        freebsd*)
                alias df='df -h'
                ;;
        gnu)
                ;;
        netbsd|openbsd*)
                alias df='df -h'
                ;;
        *)
                alias df='df -h'
                ;;
esac

