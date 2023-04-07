#!/bin/bash

#####################################
# ####### BASH CONVENIENCE   ###### #
#####################################

[ -z "$PS1" ] && return


cat_devnull(){ cat $@ >/dev/null;}
alias cad="cat_devnull "
alias f="find . |grep "
alias ls="ls -hog"


# screenshots
alias screenshot='import -window root ~/Desktop/`date +%Y%m%d%H%M`.png'

# System info
alias cpuu="ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'"
alias memu='ps -e -o rss=,args= | sort -b -k1,1n | pr -TW$COLUMNS'
alias pg='ps aux | grep'  #requires an argument


# network
alias net1='watch --interval=2 "sudo netstat -apn -l -A inet"'
alias net2='watch --interval=2 "sudo netstat -anp --inet --inet6"'  
alias net3='sudo lsof -i'
alias net4='watch --interval=2 "sudo netstat -p -e --inet --numeric-hosts"'
alias net5='watch --interval=2 "sudo netstat -tulpan"'
alias net6='sudo netstat -tulpan'
alias net7='watch --interval=2 "sudo netstat -utapen"'
alias net8='watch --interval=2 "sudo netstat -ano -l -A inet"'
alias netl='sudo nmap -sT -O localhost' # more here http://www.redhat.com/docs/manuals/linux/RHL-9-Manual/security-guide/s1-server-ports.html
alias ping='ping -c 10'
#alias currports='wine /home/iceni60/Desktop/Desktop_Folder/Network_Tools/currports/cports.exe'
#alias winwhois='wine /home/iceni60/Desktop/Desktop_Folder/Network_Tools/win32whois_0_9_13/win32whois.exe'
#alias xnews='wine /home/iceni60/Desktop/Desktop_Folder/Network_Tools/XNews/XNEWS.EXE'

alias whois='whois -H'
alias who='who -HT'

#################
### FUNCTIONS ###
#################
## Really smart aliases
function    ff               { find . -name $@ -print; }
function    rmd              { rm -fr $@; }
function    osr              { shutdown -r now; }
function    osh              { shutdown -h now; }
function    mfloppy          { mount /dev/fd0 /mnt/floppy; }
function    umfloppy         { umount /mnt/floppy; }
function    mdvd             { mount -t iso9660 -o ro /dev/dvd /mnt/dvd; }
function    umdvd            { umount /mnt/dvd; }
function    mcdrom           { mount -t iso9660 -o ro /dev/cdrom /mnt/cdrom; }
function    umcdrom          { umount /mnt/cdrom; }
function    psa              { ps aux $@; }
function    psu              { ps  ux $@; }
function    dub              { du -sclb $@; }
function    duk              { du -sclk $@; }
function    dum              { du -sclm $@; }
function    dfk              { df -PTak $@; }
function    dfm              { df -PTam $@; }
function    dfh              { df -PTah $@; }
function    dfi              { df -PTai $@; }






###ssh user@host "tar -zcf - /path/to/dir" > dir.tar.gz
ssh-backup-dir() { ssh $1 "tar -zcf - $2" > $3 ; } 


## easily find megabyte eating files or directories
## sorts the files by integer megabytes, which should be enough to 
## (interactively) find the space wasters. Now you can
## Example:  dush
## for only the 3 biggest files and so on. It's always a good idea to have this line in your .profile or .bashrc
## Example: dush -n 3 
alias dush="du -sm *|sort -n|tail"



alias busy='my_file=$(find /usr/include -type f | sort -R | head -n 1); my_len=$(wc -l $my_file | awk "{print $1}"); let "r = $RANDOM % $my_len" 2>/dev/null; vim +$r $my_file'



## Alias HEAD for automatic smart output
## Run the alias command, then issue
## ps aux | head
## and resize your terminal window (putty/console/hyperterm/xterm/etc) then issue the same command and you'll understand.
## ${LINES:-`tput lines 2>/dev/null||echo -n 12`}
## Insructs the shell that if LINES is not set or null to use the output from `tput lines` ( ncurses based terminal access ) to get the number of lines in your terminal. But furthermore, in case that doesn't work either, it will default to using the deafault of 12 (-2 = 10).
## The default for HEAD is to output the first 10 lines, this alias changes the default to output the first x lines instead, where x is the number of lines currently displayed on your terminal - 2. The -2 is there so that the top line displayed is the command you ran that used HEAD, ie the prompt.
## Depending on whether your PS1 and/or PROMPT_COMMAND output more than 1 line (mine is 3) you will want to increase from -2. So with my prompt being the following, I need -7, or - 5 if I only want to display the commandline at the top. ( http://www.askapache.com/linux-unix/bash-power-prompt.html )
## 275MB/748MB
## [7995:7993 - 0:186] 06:26:49 Thu Apr 08 [askapache@n1-backbone5:/dev/pts/0 +1] ~
##In most shells the LINES variable is created automatically at login and updated when the terminal is resized (28 linux, 23/20 others for SIGWINCH) to contain the number of vertical lines that can fit in your terminal window. Because the alias doesn't hard-code the current LINES but relys on the $LINES variable, this is a dynamic alias that will always work on a tty device.

## EXPERIMENTAL
#alias head='head -n $((${LINES:-`tput lines 2>/dev/null||echo -n 12`} - 2))'
