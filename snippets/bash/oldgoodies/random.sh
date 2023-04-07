#!/bin/bash

#####################################
# ############# ALIASES ########### #
#####################################

# ignore case, long prompt, exit if it fits on one screen, allow colors for ls and grep colors
export LESS="-iMFXR"

# must press ctrl-D 2+1 times to exit shell
export IGNOREEOF="2"

# allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

#export GREP_OPTIONS='--color=auto'

alias webs='python -m SimpleHTTPServer'
alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
