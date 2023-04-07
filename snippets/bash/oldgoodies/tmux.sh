#!/bin/bash

#####################################
# ######### TMUX FUNCTIONS ######### #
#####################################

[ -z "$PS1" ] && return

alias fixssh='export $(tmux showenv SSH_AUTH_SOCK)'
