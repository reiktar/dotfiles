#!/usr/bin/env bash
alias open=xdg-open


# use ctrl-z to toggle in and out of bg
if [[ $- == *i* ]]; then
  stty susp undef
  bind '"\C-z":" fg\015"'
fi
