#!/bin/bash

#####################################
# ### Random Utility Functions #### #
#####################################

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}


#netinfo - shows network information for your system
netinfo ()
{
    echo "NOTE: Needs serious improvement"
    echo "--------------- Network Information ---------------"
    ifconfig | awk /'inet addr/ {print $2}'
    ifconfig | awk /'Bcast/ {print $3}'
    ifconfig | awk /'inet addr/ {print $4}'
    ifconfig | awk /'HWaddr/ {print $4,$5}'
    ip=$(myip)
    #ip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
    echo "${ip}"
    echo "---------------------------------------------------"
}
netinfo1()
{
n=1     # Placeholder

# Grab ethernet interface
for x in $(ifconfig | awk '/eth/ {print $1}')
do
    eth[n]=$x
    let "n += 1"
done

# Grab HW address
let "n = 1"
for x in $(ifconfig | awk '/eth/ {print $5}')
do
    hwAddr[n]=$x
    let "n += 1"
done

# Grab IP address
let "n = 1"
for x in $(ifconfig | awk '/inet addr/ {print $2}')
do
    y=$(echo $x | awk -F : '{print $2}')
    ipAddr[n]=$y
    let "n += 1"
done

# Grab broadcast address
let "n = 1"
for x in $(ifconfig | awk '/Bcast/ {print $3}')
do
    y=$(echo $x | awk -F : '{print $2}')
    bAddr[n]=$y
    let "n += 1"
done

# Grab mask
let "n = 1"
for x in $(ifconfig | awk '/Mask/ {print $4}')
do
    y=$(echo $x | awk -F : '{print $2}')
    mask[n]=$y
    let "n += 1"
done

echo "----------- Network Information ---------"
let "n = 1"
echo
for x in ${eth[@]}
do
    echo "Ethernet Interface: ${eth[n]}"
    echo "HW Addr:            ${hwAddr[n]}"
    echo "IP Address:         ${ipAddr[n]}"
    echo "Broadcast Address:  ${bAddr[n]}"
    echo "Mask:               ${mask[n]}"
    echo
    let "n += 1"
done
echo "-----------------------------------------"
}


dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}
#copy and go to dir
cpg (){
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

#move and go to dir
mvg (){
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}


ziprm () {
	if [ -f $1 ] ; then
		unzip $1
		rm $1
	else
		echo "Need a valid zipfile"
	fi
}
psgrep() {
	if [ ! -z $1 ] ; then
		echo "Grepping for processes matching $1..."
		ps aux | grep $1 | grep -v grep
	else
		echo "!! Need name to grep for"
	fi
}
grab() {
	sudo chown -R ${USER} ${1:-.}
}

#copy and go to dir
cpg (){
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

#move and go to dir
mvg (){
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}


s() { # do sudo, or sudo the last command if no argument given
    if [[ $# == 0 ]]; then
        sudo $(history -p '!!')
    else
        sudo "$@"
    fi
}


	
mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
mkcd() {
        if [ $# != 1 ]; then
                echo "Usage: mkcd <dir>"
        else
                mkdir -p $1 && cd $1
        fi
}

bu () { cp $1 ~/.backup/`basename $1`-`date +%Y%m%d%H%M`.backup ; }

function include_stuff {
for prog in $HOME/local/*
do
    if [ -d "$prog/bin" ]; then
        export PATH=$prog/bin:$PATH
    fi
    if [ -d "$prog/include" ]; then
        export C_INCLUDE_PATH=$prog/include:$C_INCLUDE_PATH
    fi
    if [ -d "$prog/lib" ]; then
        export LD_LIBRARY_PATH=$prog/lib:$LD_LIBRARY_PATH
        export LIBRARY_PATH=$prog/lib:$LIBRARY_PATH
    fi
    if [ -d "$prog/man" ]; then
        export MANPATH=$prog/man:$MANPATH
    fi
    if [ -d "$prog/share/man" ]; then
        export MANPATH=$prog/share/man:$MANPATH
    fi
done
}


mkpassword() {
openssl rand -base64 12
}
#Generate a random password 30 characters long
#Find random strings within /dev/urandom. Using grep filter to just Alphanumeric characters, and then print the first 30 and remove all the line feeds.
mkpassword2() {
strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n'; echo
}
epoch_base32() {
echo "$(obase=16; echo "$(date +%s)" | bc | xxd -r -p | base32)"
}
#Convert seconds to human-readable format
#This example, for example, produces the output, "Fri Feb 13 15:26:30 EST 2009"
epoch_to_human(){
date -d@$1

}

seconds_to_time() {
   echo  $(bc <<< 'obase=60;299')
}




dirtree() {
ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'
}


csv_to_json() {
FILE=$1 ## CSVFILE
python -c "import csv,json;print json.dumps(list(csv.reader(open('$FILE'))))"
}

#List processes in unkillable state D(iowait)
ps_unkillable() {
ps aux | awk '{if ($8 ~ "D") print $0}'
}

find_count() {
STARTDIR=$1 ### Dir to start int default to / ???
find $STARTDIR -type d | while read i; do ls $i | wc -l | tr -d \\n; echo " -> $i"; done | sort -n
}

myip() {
#OLD NOT WORKING
#curl ifcomfig.me/ip

#dig +short myip.opendns.com @resolver1.opendns.com
#curl ip.appspot.com
#curl -s http://checkip.dyndns.org/ | grep -o "[[:digit:].]\+"
#curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z<>/ :]//g'
#curl -s bot.whatismyipaddress.com;echo
curl -s ipecho.net/plain ; echo

}

ps_mem(){
ps aux | sort -nk +4 | tail
}

rtfm() { help $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; }
xkcd(){ wget -qO- http://xkcd.com/|tee >(feh $(grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}'))|grep -Po '(?<=(\w{3})" title=").*(?=" alt)';}

xkcd(){ wget -qO- http://xkcd.com/|tee >(feh $(grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}'))|grep -Po '(?<=(\w{3})" title=").*(?=" alt)';}


translate(){ wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'; }

#Translate a Word  - USAGE: translate house spanish  # See dictionary.com for available languages (there are many).
translate2 ()
{
    TRANSLATED=`lynx -dump "http://dictionary.reference.com/browse/${1}" | grep -i -m 1 -w "${2}:" | sed 's/^[ \t]*//;s/[ \t]*$//'`
    if [[ ${#TRANSLATED} != 0 ]] ;then
        echo "\"${1}\" in ${TRANSLATED}"
        else
        echo "Sorry, I can not translate \"${1}\" to ${2}"
    fi
}



# Define a word - USAGE: define dog
define4 () {
curl  "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 3 -w "*"  | sed 's/;/ -/g' | cut -d- -f1 > /tmp/templookup.txt
			if [[ -s  /tmp/templookup.txt ]] ;then	
				until ! read response
					do
					echo "${response}"
					done < /tmp/templookup.txt
				else
					echo "Sorry $USER, I can't find the term \"${1} \""				
			fi	
\rm -f /tmp/templookup.txt
}

function define3 {
    curl -s "http://www.google.com/dictionary?aq=f&langpair=en|en&q="$1"&hl=en" | html2text -nobs | sed '1,/^ *Dictionary\]/d' | head -n -5 | less
}
define2(){ local y="$@";curl -sA"Opera" "http://www.google.com/search?q=define:${y// /+}"|grep -Po '(?<=<li>)[^<]+'|nl|perl -MHTML::Entities -pe 'decode_entities($_)' 2>/dev/null;}



##### WORDNET 
# look in WordNet and Webster
d () { curl dict://dict.org/d:${1}:wn; }
wd () { curl dict://dict.org/d:${1}:web1913; } 

# find matches of $1, with optional strat $2 and optional db $3
ref () {
    if [[ -z $3 ]]; then
        curl dict://dict.org/m:${1}:english:${2};
    else
        curl dict://dict.org/m:${1}:${3}:${2};
    fi
}

# define $1 using optional db of $2
define-dict () { curl dict://dict.org/d:${1}:${2}; };

# local WordNet lookups
syn () { wn $1 -synsn; wn $1 -synsv; wn $1 -synsa; wn $1 -synsr; }
ant () { wn $1 -antsn; wn $1 -antsv; wn $1 -antsa; wn $1 -antsr; }




flight_status() { if [[ $# -eq 3 ]];then offset=$3; else offset=0; fi; curl "http://mobile.flightview.com/TrackByRoute.aspx?view=detail&al="$1"&fn="$2"&dpdat=$(date +%Y%m%d -d ${offset}day)" 2>/dev/null |html2text |grep ":"; }

matrix() { tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"; }


color_strip() { sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" ; }
color_gradient() { for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done; }

weather() { curl wttr.in/newyork;}
newyork() { curl wttr.in/newyork;}
stockholm() { curl wttr.in/stockholm;}
# Weather by us zip code - Can be called two ways # weather 50315 # weather "Des Moines"
zipweather ()
{
    declare -a WEATHERARRAY
    WEATHERARRAY=( `curl "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+${1}&btnG=Search" | grep -A 5 -m 1 "Weather for" | sed 's;\[26\]Add to iGoogle\[27\]IMG;;g'`)
    echo ${WEATHERARRAY[@]}
}

#check site ssl certificate dates
#remotely connects to an https site, fetches the ssl certificate and displays the valid dates for the cert
ssl_cert_date() {
    echo | openssl s_client -connect $1:443 2>/dev/null |openssl x509 -dates -noout
}


base2(){ echo "obase=2; $1" | bc -l ;}
base8(){ echo "obase=8; $1" | bc -l ;}
base10(){ echo "obase=10; $1" | bc -l ;}
base16(){ echo "obase=16; $1" | bc -l ;}
base32(){ echo "obase=32; $1" | bc -l ;}


 

##################
#users and groups#
##################

uinf(){
echo "current directory="`pwd`;
echo "you are="`whoami`
echo "groups in="`id -n -G`;
tree -L 1 -h $HOME;
echo "terminal="`tty`;
}

#system roundup
sys(){
if [ `id -u` -ne 0 ]; then echo "you are not root"&&exit;fi;
uname -a
echo "runlevel" `runlevel` 
uptime
last|head -n 5;
who;
echo "============= CPUs ============="
grep "model name" /proc/cpuinfo #show CPU(s) info
cat /proc/cpuinfo | grep 'cpu MHz'
echo ">>>>>current process"
pstree
echo "============= MEM ============="
#KiB=`grep MemTotal /proc/meminfo | tr -s ' ' | cut -d' ' -f2`
#MiB=`expr $KiB / 1024`
#note various mem not accounted for, so round to appropriate sizeround=32
#echo "`expr \( \( $MiB / $round \) + 1 \) \* $round` MiB"
free -otm;
echo "============ NETWORK ============"
ip link show
/sbin/ifconfig | awk /'inet addr/ {print $2}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'inet addr/ {print $4}'
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
echo "============= DISKS =============";
df -h;
echo "============= MISC =============="
echo "==<kernel modules>=="
lsmod|column -t|awk '{print $1}';
echo "=======<pci>========"
lspci -tv;
echo "=======<usb>======="
lsusb;
}




#Bash scripts encryption and passphrase-protection
#This function will encrypt a bash script and will only execute it after providing 
#the passphrase. Requires mcrypt to be installed on the system.
scrypt(){ [ -n "$1" ]&&{ echo '. <(echo "$(tail -n+2 $0|base64 -d|mcrypt -dq)"); exit;'>$1.scrypt;cat $1|mcrypt|base64 >>$1.scrypt;chmod +x $1.scrypt;};}
#Example: 
##cat hello
##!/bin/bash
#case "$1" in
#""|-h) echo "This is the fantastic Hello World. Try this:" $(basename $0) "[entity]" ;;
#moon) echo Good night. ;;
#sun) echo Good morning. ;;
#world) echo "Hello, world!" ;;
#*) echo Hi, $@. ;;
#esac
#scrypt hello
#Enter the passphrase (maximum of 512 characters)
#Please use a combination of upper and lower case letters and numbers.
#Enter passphrase:
#Enter passphrase:
#Stdin was encrypted.
#cat hello.scrypt
#. <(echo "$(/usr/bin/tail -n+2 $0|base64 -d|mcrypt -dq)");exit;
#AG0DQHJpam5kYWVsLTEyOAAgAGNiYwBtY3J5cHQtc2hhMQAV34412aaE8sRzQPQzi09YaNQPedBz
#aGExAARvB6A/HYValW4txoCFmrlp57lmvhKBbM4p+OUiZcCxr6Y+Mm7ogg3Y14pHi0CrfT70Tubq
#9g8/kNJrQr7W/ogHpVuOOdD0YfuRatrV7W2+OlNQ63KX780g4qTHrTqNnyLp8sF5RQ7GwxyZ0Oti
#kROtVIU4g4+QAtn/k/e7h7yt4404VF1zzCYRSw20wmJz1o/Z0XO7E/DFBr5Bau7bWjnF7CRVtims
#HGrDwv1miTtAcyB9PknymDxhSyjDUdNhqXGBIioUgqjX1CKgedtO0hQp050MiQd3I6HacpSrVUIW
#kuuS+BtMrxHDy+48Mh1hidV5JQFP7LP5k+yAVLpeHd2m2eIT1rjVE/Bp2cQVkpODzXcWQDUAswUd
#vulvj/kWDQ==
#./hello
#This is the fantastic Hello World. Try this: hello [entity]
#./hello.scrypt
#Enter passphrase:
#This is the fantastic Hello World. Try this: hello.scrypt [entity]
#./hello world
#Hello, world!
#./hello.scrypt world
#Enter passphrase:
#Hello, world!
#


##### Shot - takes a screenshot of your current window

shot ()
{
import -frame -strip -quality 75 "$HOME/$(date +%s).png"
}





