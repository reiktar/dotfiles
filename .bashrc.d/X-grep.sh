## MARKUS HACK for grep 

export GREP_OPT_EXCLUDEN=${GREP_OPT_EXCLUDE:-''}
export GREP_OPT_EXCLUDE_DIR=${GREP_OPT_EXCLUDE_DIR:-''}
export GREP_OPT_COLOR=${GREP_OPT_COLOR:-'auto'}

__grep_opt () {
  grep_opt=""
  [ -z $GREP_OPT_EXCLUDE ] || grep_opt=" $grep_opt --exclude={$GREP_OPT_EXCLUDE}"
  [ -z $GREP_OPT_EXCLUDE_DIR] || grep_opt=" $grep_opt --exclude={$GREP_OPT_EXCLUDE_DIR}"
  [ -z $GREP_OPT_COLOR ] || grep_opt=" $grep_opt --color=$GREP_OPT_COLOR"
  echo $grep_opt
}
__vim_grep_pipe () {
  grep $(GREP_OPT_COLOR=never __grep_opt) -l "$@" | vim -
}

__editor_grep () {
  $EDITOR $(grep $(GREP_OPT_COLOR=never __grep_opt) -l "$@")
}

alias fgrep='fgrep $(__grep_opt)'
alias egrep='egrep $(__grep_opt)'
alias grep='grep $(__grep_opt)'
alias grepc='grep $(GREP_OPT_COLOR=always __grep_opt)'
alias grepo='__editor_grep'
alias grepv='__vim_grep_pipe'
