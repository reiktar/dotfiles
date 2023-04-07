#!/bin/bash

#####################################
# ####### GREP CONVENIENCE   ###### #
#####################################

[ -z "$PS1" ] && return

grepopt="--color=auto"
alias grep='grep $grepopt'
alias egrep='egrep $grepopt'
alias fgrep='fgrep $grepopt'


