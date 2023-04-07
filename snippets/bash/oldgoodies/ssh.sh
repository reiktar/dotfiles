#!/bin/bash

#####################################
# ######### GIT FUNCTIONS ######### #
#####################################

[ -z "$PS1" ] && return

alias ka="ssh-add ~/.ssh/markus.key;ssh-add ~/.ssh/tentrr.dev.key; ssh-add ~/.ssh/tentrr.key ; ssh-add -L"
alias kl="ssh-add -L"


