#!/bin/bash

#####################################
# ###### PACKAGE MANAGEMENT  ###### #
#####################################

[ -z "$PS1" ] && return

if have dpkg; then
        lspkgs() { dpkg -l | awk '/^i/ {print $2}'; }
        lscruft() { dpkg -l | awk '/^r/ {print $2}'; }
        lspkg() { dpkg -L "$@"; }
        _pkg_owns() { dpkg -S "$@"; }
elif have pacman; then
        lspkgs() { pacman -Qq; }
        lscruft() { find /etc -name '*.pacsave'; }
        lspkg() { pacman -Qql "$@"; }
        _pkg_owns() { pacman -Qo "$@"; }
        alias nosr='pkgfile'
elif have rpm; then
        lspkgs() { rpm -qa --qf '%{NAME}\n'; }
        lspkg() { rpm -ql "$@"; }
        _pkg_owns() { rpm -q --whatprovides "$@"; }
elif [[ $OSTYPE == FreeBSD ]] && have pkg; then
        lspkgs() { pkg info -q; }
        lspkg() { pkg query '%Fp' "$@"; }
        _pkg_owns() { pkg which "$@"; }
fi

if have lspkg; then
        lcpkg() { lspkg "$@" | xargs -d '\n' ls -d --color=always 2>&1 | pager; }
        llpkg() { lspkg "$@" | xargs -d '\n' ls -ldh --color=always 2>&1 | pager; }
fi

if have _pkg_owns; then
        owns() {
                local file=$1
                if [[ $file != */* ]] && have "$file"; then
                        file=$(which "$file")
                fi
                _pkg_owns "$(readlink -f "$file")"
        }
fi

