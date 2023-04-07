#!/bin/bash

#####################################
# ###### SERVICE MANAGEMENT ####### #
#####################################

[ -z "$PS1" ] && return

# service management

if have systemctl && [[ -d /run/systemd/system ]]; then
        start()   { sudo systemctl start "$@";   _status "$@"; }
        stop()    { sudo systemctl stop "$@";    _status "$@"; }
        restart() { sudo systemctl restart "$@"; _status "$@"; }
        reload()  { sudo systemctl reload "$@";  _status "$@"; }
        status()  { SYSTEMD_PAGER='cat' systemctl status -a "$@"; }
        _status() { sudo SYSTEMD_PAGER='cat' systemctl status -a -n0 "$@"; }
        alias enable='sudo systemctl enable'
        alias disable='sudo systemctl disable'
        alias list='systemctl list-units -t path,service,socket --no-legend'
        alias userctl='systemctl --user'
        alias u='systemctl --user'
        alias y='systemctl'
        ustart()   { userctl start "$@";   userctl status -a "$@"; }
        ustop()    { userctl stop "$@";    userctl status -a "$@"; }
        urestart() { userctl restart "$@"; userctl status -a "$@"; }
        ureload()  { userctl reload "$@";  userctl status -a "$@"; }
        alias ulist='userctl list-units -t path,service,socket --no-legend'
        alias lcstatus='loginctl session-status $XDG_SESSION_ID'
        alias tsd='tree /etc/systemd/system'
        cgls() { SYSTEMD_PAGER='cat' systemd-cgls "$@"; }
        usls() { cgls "/user.slice/user-$UID.slice/$*"; }
elif have service; then
        # Debian, other LSB
        start()   { for _s; do sudo service "$_s" start; done; }
        stop()    { for _s; do sudo service "$_s" stop; done; }
        restart() { for _s; do sudo service "$_s" restart; done; }
        status()  { for _s; do sudo service "$_s" status; done; }
        svc_enable()  { for _s; do sudo update-rc.d "$_s" enable; done; }
        svc_disable() { for _s; do sudo update-rc.d "$_s" disable; done; }
	alias enable=svc_enable
	alias disable=svc_disable
fi

