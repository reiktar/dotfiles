#!/bin/bash

#####################################
# ######### GIT FUNCTIONS ######### #
#####################################

[ -z "$PS1" ] && return
alias good='git bisect good' 
alias bad='git bisect bad' 
 
# conditional aliases 
 
if ! have annex; then 
       alias annex='git annex' 
fi 


