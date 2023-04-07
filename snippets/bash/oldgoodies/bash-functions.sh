#!/bin/bash

#####################################
# ###### FUNCTION COLLECTION ###### #
#####################################

[ -z "$PS1" ] && return


catlog() {
	printf '%s\n' "$1" "$1".* | natsort | tac | while read -r file; do
		case $file in
		    *.gz) zcat "$file";;
		    *)    cat "$file";;
		esac
	done
}

cat() {
	if [[ $1 == *://* ]]; then
		curl -LsfS "$1"
	else
		command cat "$@"
	fi
}

imv() {
	local old new
	if (( ! $# )); then
		echo "imv: no files" >&2
		return 1
	fi
	for old; do
		new=$old; read -p "rename to: " -e -i "$old" new
		[[ "$old" == "$new" ]] || command mv -v "$old" "$new"
	done
}

mksrcinfo() {
	if have mksrcinfo; then
		command mksrcinfo
	else
		makepkg --printsrcinfo > .SRCINFO || rm -f .SRCINFO
	fi
}

man() {
	if [[ $1 == *://* ]]; then
		curl -LsfS "$1" | command man /dev/stdin
	elif [[ $1 == *.[0-9]* && $1 != */* && ! $2 && -f $1 ]]; then
		command man "./$1"
	elif [[ $1 == annex ]]; then
		command man git-annex "${@:2}"
	else
		command man "$@"
	fi
}

alias tlsc='tlsg'

tlsg() {
	if [[ $2 == -p ]]; then
		set -- "$1" "${@:3}"
	fi
	local host=$1 port=${2:-443}
	gnutls-cli "$host" -p "$port" "${@:3}"
}

tlso() {
	if [[ $2 == -p ]]; then
		set -- "$1" "${@:3}"
	fi
	local host=$1 port=${2:-443}
	case $host in
	    *:*) local addr="[$host]";;
	    *)   local addr="$host";;
	esac
	openssl s_client -connect "$addr:$port" -servername "$host" \
		-verify_hostname "$host" -status -no_ign_eof -nocommands "${@:3}"
}

tlscert() {
	if [[ $2 == -p ]]; then
		set -- "$1" "${@:3}"
	fi
	local host=$1 port=${2:-443}
	if have gnutls-cli; then
		tlsg "$host" "$port" --insecure --print-cert
	elif have openssl; then
		tlso "$host" "$port" -showcerts
	fi < /dev/null
}

alias sslcert='tlscert'

lspkcs12() {
	if [[ $1 == -g ]]; then
		certtool --p12-info --inder "${@:2}"
	elif [[ $1 == -n ]]; then
		pk12util -l "${@:2}"
	elif [[ $1 == -o ]]; then
		openssl pkcs12 -info -nokeys -in "${@:2}"
	fi
}

x509fp() {
	local file=${1:-/dev/stdin}
	openssl x509 -in "$file" -noout -fingerprint -sha1 | sed 's/.*=//' | tr A-F a-f
}

x509subj() {
	local file=${1:-/dev/stdin}
	openssl x509 -in "$file" -noout -subject -nameopt RFC2253 | sed 's/^subject=//'
}

x509subject() {
	local file=${1:-/dev/stdin}
	openssl x509 -in "$file" -noout -subject -issuer -nameopt multiline,dn_rev
}

