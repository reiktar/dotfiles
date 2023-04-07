#!/bin/bash

#source ${XDG_CONFIG_HOME}/bash/functions/util.sh
#. functions/plugin.sh
WINHOME='/mnt/c/Users/Markus'

install() {
    if ! is_wsl; then exit;fi
    echo "Installing - sudo required"
    confirm_is_root
    echo "Continuing"
    sleep 10
}

uninstall() {
    if ! is_wsl; then exit;fi
    echo "Uninstalling"
}


if ! is_wsl; then return;fi
#install

#if [ -z SSH_AUTH_SOCK ]; then 
#    e_note "Starting agent forwarder"
#    while true; do socat UNIX-LISTEN:/tmp/wsl-ssh-pageant.socket,unlink-close,unlink-early TCP4:127.0.0.1:13000; done &
#    export SSH_AUTH_SOCK=/tmp/wsl-ssh-paegant.socket
#fi 

### MobaXterm causes two problems
# Problem 1: $SHLVL starts as value 3 no good
# Problem 2: MobaXterm binaries are accessible via the PATH. this really confuses wsl 
# Solution: Discover if MobaXterm is in the path and then set SHLVL to 1 and then remove from path
if echo $PATH|grep -qs "MobaXterm" ; then
    SHLVL=1
    PATH=$(echo "$PATH" | sed -e 's#:[^:]*MobaXterm[^:]*:#:#g')
fi


if check_sudo; then
    do_bind_mount $WINHOME/Dropbox ~/Dropbox
    do_bind_mount $WINHOME/Documents ~/Documents
    do_bind_mount $WINHOME/Dropbox/Home/.ssh ~/.ssh2
    do_bind_mount $WINHOME/Dropbox/Home/.aws ~/.aws
else 
    e_warning "No Sudo Access cannot mount directories"
fi

export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"

umask 0022
