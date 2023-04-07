#!/bin/bash

#####################################
# ####### BASH CONVENIENCE   ###### #
#####################################

[ -z "$PS1" ] && return
[ ! "$0" = "-bash" ] && return


bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

## into .inputrc 
#set editing-mode vi
#set -o vi
#to check mode
#bind -P

EDITOR=vim

