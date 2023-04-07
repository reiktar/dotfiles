#!/usr/bin/env bash
#PYENV 
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(pip completion --bash)"
eval "$(pip3 completion --bash)"
