#!/bin/bash

#####################################
# ######### X11 FUNCTIONS ######### #
#####################################

[ -z "$PS1" ] && return

if have xdg-open; then
       alias open='xdg-open'
fi


if have xclip; then
       alias psel='xclip -out -selection primary'
       alias gsel='xclip -in -selection primary'
       alias pclip='xclip -out -selection clipboard'
       alias gclip='xclip -in -selection clipboard'
       alias lssel='psel -target TARGETS'
       alias lsclip='pclip -target TARGETS'
elif have xsel; then
       alias psel='xsel -o -p -l /dev/null'
       alias gsel='xsel -i -p -l /dev/null'
       alias pclip='xsel -o -b -l /dev/null'
       alias gclip='xsel -i -b -l /dev/null'
fi

clip() {
       if (( $# )); then
               echo -n "$*" | gclip
       elif [[ ! -t 0 ]]; then
               gclip
       else
               pclip
       fi
}

sel() {
       if (( $# )); then
               echo -n "$*" | gsel
       elif [[ ! -t 0 ]]; then
               gsel
       else
               psel
       fi
}


