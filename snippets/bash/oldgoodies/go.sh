#!/bin/bash

#####################################
# ########## GO FUNCTIONS ######### #
#####################################

[ -z "$PS1" ] && return

export GOPATH=~/go/
PATH=$PATH:${GOPATH//://bin:}/bin

