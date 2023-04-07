#!/bin/sh 

#set -e
#### COLORS and STYLE DEFS
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)
purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)


## COlor alternative to above
if tput setaf 1 > /dev/null 2>&1; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      MAGENTA=$(tput setaf 9)
      ORANGE=$(tput setaf 172)
      GREEN=$(tput setaf 190)
      PURPLE=$(tput setaf 141)
      WHITE=$(tput setaf 256)
    else
      MAGENTA=$(tput setaf 5)
      ORANGE=$(tput setaf 4)
      GREEN=$(tput setaf 2)
      PURPLE=$(tput setaf 1)
      WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    BLUE="\033[1;34m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi





have() { command -v "$1" > /dev/null 2>&1; }

is_sysv() { return $(ps -hp 1|grep -qE init >/dev/null 2>&1) ;};
is_systemd() { return $(ps -hp 1|grep -qE systemd > /dev/null 2>&1) ;};
	
is_mingw(){
## MINGW64_NT-10.0 PREFECT 2.6.1(0.306/5/3) 2017-01-20 15:23 x86_64 Msys
## MINGW64_NT-10.0 version 2.6.1(0.306/5/3) (Virtual Box@DESKTOP-A887SOO) (gcc version 5.3.0 (GCC) ) 2017-01-20 15:23
    [ -e /proc/version ] || return 1
    grep -qE '(MINGW64_NT)' /proc/version > /dev/null 2>&1
    [ $? -eq 0 ]
}

is_msys() {
## MSYS_NT-10.0 version 2.6.1(0.306/5/3) (Virtual Box@DESKTOP-A887SOO) (gcc version 5.3.0 (GCC) ) 2017-01-20 15:23
    [ -e /proc/version ] || return 1
    grep -qE '(MYS_NT)' /proc/version > /dev/null 2>&1
    [ $? -eq 0 ]
}

is_wsl(){
    [ -e /proc/version ] || return 1
    grep -qE '(Microsoft|WSL)' /proc/version > /dev/null 2>&1
    [ $? -eq 0 ]
}

is_cygwin(){
    [ -e /proc/version ] || return 1
    grep -qE '(CYGWIN_NT)' /proc/version > /dev/null 2>&1
    [ $? -eq 0 ]
}

is_ubuntu(){
    [ -e /proc/version ] || return 1
    grep -qE '(Ubuntu)' /proc/version > /dev/null 2>&1
    [ $? -eq 0 ]
}

is_centos(){
    [ -e /proc/version ] || return 1
    grep -qE '(Centos)' /proc/version > /dev/null 2>&1
    [ $? -eq 0 ]
}

is_redhat(){
    [ -e /proc/version ] || return 1
    grep -qE '(Redhat)' /proc/version > /dev/null 2>&1
    [ $? -eq 0 ]
}
is_linux(){
    [ -e /proc/version ] || return 1
    grep -qE "Linux" /proc/version > /dev/null 2>&1
    [ $? -eq 0 ]
}

is_root_user(){
 [ $(id -u) -eq 0 ]
}
is_root(){
    if [ "$EUID" -ne 0 ]; then 
	return 1
    fi
    return 0
}

confirm_is_root(){
    if ! is_root; then
        echo "Please run as root"
        exit
    fi
}


require_command() {
   if ! command -v $1 >/dev/null 2>&1 ; then
       echo  "Requiring command '$1' but it is not installed. Aborting"
       exit
   fi
}


check_sudo() {
#markus@WINDOWS-F2GJSK1:~/dotfiles$ sudo -n -- echo yay
#yay
#markus@WINDOWS-F2GJSK1:~/dotfiles$ sudo -n -- echo yay
#sudo: a password is required
    res=$(sudo -n -- echo sudo: access success 2>&1)
    if [ "$res" == "sudo: access success" ]; then
        return 0
    fi 
    return 1
}
do_sudo() {
    sudo $@
}


do_die() {
    [ -n "$BASH_VERSION" ] && echo >&2 -e "${red}$@${reset}" && exit 1
    echo "${red}$@${reset}"
    exit 1
}

do_init() {
  set -o nounset
  set -o errexit
}

check_mount() {
    if mount |grep -qs $1 > /dev/null; then
        return 0
    fi
    return 1
}
do_bind_mount() {
    if check_mount $2 ; then
        return 0 #already mounted
    fi
    if [ ! -d $2 ]; then
        mkdir -p $2
    fi
    if check_sudo;then
        sudo mount -o bind $1 $2
    fi
}

expand_path() {
   echo $(stat -c "%N" $1)
}

#
# Headers and  Logging
#
e_header() { printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@";}
e_arrow() { printf "➜ $@\n";}
e_success() { printf "${green}✔ %s${reset}\n" "$@";}
e_error() { printf "${red}✖ %s${reset}\n" "$@";}
e_warning() { printf "${tan}➜ %s${reset}\n" "$@";}
e_underline() { printf "${underline}${bold}%s${reset}\n" "$@";}
e_bold() { printf "${bold}%s${reset}\n" "$@";}
e_note() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@";}
e_debug() { [ $DEBUG ] && printf "${ORANGE}Debug:${reset}  ${white}%s${reset}\n" "$@"; return 0; }

test_color(){
    e_header "I am a sample script"
    e_success "I am a success message"
    e_error "I am an error message"
    e_warning "I am a warning message"
    e_underline "I am underlined text"
    e_bold "I am bold text"
    e_note "I am a note"
    e_debug "Debug message"
}


#### CONFIRMATION 
seek_confirmation() {
  printf "\n${bold}$@${reset}"
  read -p " (y/n) " -n 1
  printf "\n"
}
# Test whether the result of an 'ask' is a confirmation
is_confirmed() {
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        return 0
    fi
    return 1
}

test_confirmation(){
    e_header "I am a sample script"
    seek_confirmation "Do you want to print a success message?"
    if is_confirmed; then
        e_success "Here is a success message"
    else
        e_error "You did not ask for a success message"
    fi
}

### TYPE exists
type_exists() {
    if [ $(type -P $1) ]; then
        return 0
    fi
    return 1
}

is_os() {
    if [[ "${OSTYPE}" == $1* ]]; then
        return 0
    fi
    return 1
}

test_type(){
    e_header "I am a sample script"

    # Check for Git
    if type_exists 'git'; then
        e_success "Git good to go"
    else
        e_error "Git should be installed. It isn't. Aborting."
        return 1
    fi

    if is_os "darwin"; then
        e_success "You are on a mac"
    else
        e_error "You are not on a mac"
        return 1
    fi
}

ubuntu_check_ppa(){
    if grep -qrE "^deb .*$1" /etc/apt/sources.list /etc/apt/sources.list.d/ ; then 
        return 0
    fi
    return 1
}

is_sourced ()
{
  sourced=0
  if [ -n "$ZSH_EVAL_CONTEXT" ]; then 
    case $ZSH_EVAL_CONTEXT in *:file) sourced=1 ;; esac
  elif [ -n "$KSH_VERSION" ]; then
    [ "$(cd $(dirname -- $0) && pwd -P)/$(basename -- $0)" != "$(cd $(dirname -- ${.sh.file}) && pwd -P)/$(basename -- ${.sh.file})" ] && echo "KSH_ZOURCE2" && sourced=1
  elif [ -n "$BASH_VERSION" ]; then
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && sourced=1
    #(return 0 2>/dev/null) && sourced=1 
  else # All other shells: examine $0 for known shell binary filenames
    # Detects `sh` and `dash`; add additional shell filenames as needed.
    case ${0##*/} in sh|dash) sourced=1;; esac
  fi
  [ $sourced -eq 1 ] 
}


gen_variable_name () {
    VAR=$(
   	echo $file |  
		LC_ALL=C tr '\0-\10\13\14\16-\37' '[ *]' | 
		tr -c '[:alnum:]' '_' | 
		tr '[:lower:]' '[:upper:]'
    )
    echo $VAR
    true
}
is_loaded () {
    VAR=$(gen_variable_name $@)
    VAL=$(eval echo \$$VAR)
    [ -z $VAL ] && return 1
    return 0
}
mark_loaded () {
    VAR=$(gen_variable_name $@)
    eval $VAR=0
}
source_d ()
{
  fp=$@
  local file=
  for file in $(export LC_COLLATE=C; echo $fp); do
    is_loaded "SOURCE" $file && e_debug "Already loaded $file" && continue
    [ -e "${file}" ] && e_debug "Sourcing ${file}" && . "${file}"
    mark_loaded "SOURCE" $file
  done
}
load_d () { source_d $@ ;}

# exec alot
exec_d ()
{
  fp=$@
  local file=
  for file in $(export LC_COLLATE=C; echo $fp); do
    [ -e "${file}" ] && e_debug "Esecuting $file" && "${file}"
  done
}

func_d(){
  local fun=$1;shift
  local file=
  for file in $(export LC_COLLATE=C; echo $@); do
	  [ -e "${file}" ] && e_debug "Executing $function with file $file" && $fun "${file}"
  done
}

true
