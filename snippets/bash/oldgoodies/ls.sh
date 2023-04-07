#!/bin/bash

#####################################
# #######   LS CONVENIENCE   ###### #
#####################################

[ -z "$PS1" ] && return

if (( UID == 0 )); then
	LS_OPTIONS="$LS_OPTIONS -a"
fi
case $OSTYPE in
	linux-gnu*|cygwin)
		LS_OPTIONS="$LS_OPTIONS --color=auto"
		LS_OPTIONS="$LS_OPTIONS -N"
		eval $(dircolors)
		alias lsd='ls $LS_OPTIONS -a --ignore="[^.]*"'
		alias ls='ls $LS_OPTIONS -lathr'
		alias ll='ls $LS_OPTIONS -lathr '
		alias lh='ls $LS_OPTIONS -lah'                # human readable (sizes) long and all ;-)
		alias lls='ls -l -h -g -F --color=auto'
		alias lc='ls -aCF'
		alias lsam='ls -am'               # List files horizontally
		alias lr='ls -lR'                 # recursive
		alias lsx='ls -ax'                # sort right to left rather then in columns
		alias lss='ls -shAxSr'            # sort by size
		alias lt='ls -lAtrh'              # sort by date and human readable
		alias lm='ls -al | less'           # pipe through 'more'
		;;
	freebsd*)
		LS_OPTIONS="$LS_OPTIONS -G"
		;;
	gnu)
		LS_OPTIONS="$LS_OPTIONS --color=auto"
		eval $(dircolors)
		alias lsd='ls -a --ignore="[^.]*"'
		;;
	netbsd|openbsd*)
		alias lsd='ls -a'
		;;
	*)
		;;
esac

