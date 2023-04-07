# bashrc -- aliases and functions

#do:() { (PS4=$'\e[32m+\e[m '; set -x; "$@") }
#
#editor() { command ${EDITOR:-vi} "$@"; }
#browser() { command ${BROWSER:-lynx} "$@"; }
#pager() { command ${PAGER:-more} "$@"; }
#
#alias bat='acpi -i'
#alias cal='cal -m' # LC_TIME=en_DK.UTF-8
#catsexp() { cat "$@" | sexp-conv -w $((COLUMNS-1)); }
#alias cindex='env TMPDIR=/var/tmp cindex'
#alias cpans='PERL_MM_OPT= PERL_MB_OPT= cpanm --sudo'
#count() { sort "$@" | uniq -c | sort -n -r | pager; }
#alias demo='PS1="\\n\\$ "'
#dist/pull() { ~/code/dist/pull "$@" && SILENT=1 . ~/.profile; }
#alias dnstrace='dnstracer -s .'
#alias easy-rsa='easyrsa'
#alias ed='ed -p:'
#entity() { printf '&%s;<br>' "$@" | w3m -dump -T text/html; }
#alias ccard-tool='pkcs11-tool --module libccpkip11.so'
#alias etoken-tool='pkcs11-tool --module libeTPkcs11.so'
#alias gemalto-tool='pkcs11-tool --module /usr/lib/pkcs11/libgclib.so'
#alias ykcs11-tool='pkcs11-tool --module libykcs11.so'
#cymruname() { arpaname "$1" | sed 's/\.in-addr\.arpa/.origin/i;
#                                   s/\.ip6\.arpa/.origin6/i;
#                                   s/$/.asn.cymru.com./'; }
#cymrudig() { local n=$(cymruname "$1") && [[ $n ]] && dig +short "$n" TXT; }
#alias cymruwhois='whois -h whois.radb.net'
#alias facl='getfacl -pt'
#fc-fontformat() {
#	fc-list -f "%10{fontformat}: %{family}\n" \
#	| sed 's/,.*//' | sort -t: -k2 -u
#}
#fc-file() { fc-query -f "%{file}: %{family} (%{fontversion}, %{fontformat})\n" "$@"; }
#gerp() { egrep $grepopt -r -I -D skip --exclude-dir={.bzr,.git,.hg,.svn} -H -n "$@"; }
#gpgfp() { gpg --with-colons --fingerprint "$1" | awk -F: '/^fpr:/ {print $10}'; }
#alias hd='hexdump -C'
#alias hex='xxd -p'
#alias unhex='xxd -p -r'
#hostname.bind() { do: dig +short "${@:2}" "@$1" "$FUNCNAME." TXT CH; }
#version.bind() { do: dig +short "${@:2}" "@$1" "$FUNCNAME." TXT CH; }
#alias hup='pkill -HUP -x'
#alias init='telinit' # for systemd
#iwstat() {
#	local dev=${1:-wlan0}
#	iw $dev info && echo &&
#	iw $dev link && echo &&
#	iw $dev station dump
#}
#kernels() {
#	cat https://www.kernel.org/finger_banner \
#	| sed -r 's/^The latest (.+) version.*:/\1/' \
#	| column -t
#}
#alias kssh='ssh \
#	-o PreferredAuthentications=gssapi-keyex,gssapi-with-mic \
#	-o GSSAPIAuthentication=yes \
#	-o GSSAPIDelegateCredentials=yes'
#alias l='~/code/thirdparty/l'
#alias ll='ls -l'
#alias logoff='logout'
#if [[ $DESKTOP_SESSION ]]; then
#	alias logout='env logout'
#fi
#f() { find . \( -name .git -prune \) , \( -iname "*$1*" "${@:2}" \); }
#ff() { find "$PWD" \( -name .git -prune \) , \( -iname "*$1*" "${@:2}" \) \
#	| treeify "$PWD"; }
#alias lchown='chown -h'
#vildap() { ldapvi -s base -b "$@" '(objectclass=*)' '*' '+'; }
#ldapls() {
#	ldapsearch -LLL "$@" 1.1 | ldifunwrap | grep ^dn: \
#	| perl -MMIME::Base64 -pe 's/^(.+?):: (.+)$/"$1: ".decode_base64($2)/e'
#}
#ldapshow() { ldapsearch -b "$1" -s base -LLL "${@:2}"; }
#ldapstat() { ldapsearch -b "" -s base -x -LLL "$@" \* +; }
#alias ldapvi='ldapvi --bind sasl'
#alias lp='sudo netstat -lptu --numeric-hosts'
#alias lpt='sudo netstat -lpt --numeric-hosts'
#alias lpu='sudo netstat -lpu --numeric-hosts'
#alias lsd='ls -d .*'
#lsftp() { lftp "sftp://$1"; }
#alias lspart='lsblk -o name,partlabel,size,fstype,label,mountpoint'
#alias mkcert='mkcsr -x509 -days 3650'
#alias mkcsr='openssl req -new -sha256'
#mkmaildir() { mkdir -p "${@/%//cur}" "${@/%//new}" "${@/%//tmp}"; }
#mtr() { settitle "$HOSTNAME: mtr $*"; command mtr --show-ips "$@"; }
#alias mtrr='mtr --report-wide --report-cycles 3 --show-ips --aslookup --mpls'
#alias mutagen='mid3v2'
#mvln() { mv "$1" "$2" && sym -v "$2" "$1"; }
#alias nmap='nmap --reason'
#alias nm-con='nmcli -f name,type,autoconnect,state,device con'
#prime() { DRI_PRIME=1 "$@"; }
#alias py='python'
#alias py2='python2'
#alias py3='python3'
#alias qrdecode='zbarimg --quiet --raw'
#alias rd='rmdir'
#alias rdu='du -hsc */ | awk "\$1 !~ /K/" | sort -h' # TODO: args
#alias re='hash -r && SILENT=1 . ~/.bashrc && echo reloaded .bashrc && :'
#alias ere='set -a && . ~/.profile && set +a && echo reloaded .profile && :'
#ressh() { ssh -v \
#	-o ControlPersist=no \
#	-o ControlMaster=no \
#	-o ControlPath=none \
#	"$@" ":"; }
#alias rawhois='do: whois -h whois.ra.net --'
#alias riswhois='do: whois -h riswhois.ripe.net --'
#alias rot13='tr N-ZA-Mn-za-m A-Za-z'
#rpw() { tr -dc "A-Za-z0-9" < /dev/urandom | head -c "${1:-16}"; echo; }
#alias run='spawn -c'
#alias rsync='rsync -s'
#sp() { printf '%s' "$@"; printf '\n'; }
#splitext() { split -dC "${2-32K}" "$1" "${1%.*}-" --additional-suffix=".${1##*.}"; }
#alias srs='rsync -vshzaHAX'
#alias sudo='sudo ' # for alias expansion in sudo args
#alias telnets='telnet-ssl -z ssl'
#_thiscommand() { history 1 | sed "s/^\s*[0-9]\+\s\+([^)]\+)\s\+$1\s\+//"; }
#alias tidiff='infocmp -Ld'
#alias todo:='todo "$(_thiscommand todo:)" #'
#alias traceroute='traceroute --extensions'
#alias tracert='traceroute --icmp'
#alias treedu='tree --du -h'
#alias try-openconnect='openconnect --verbose --authenticate'
#alias try-openvpn='openvpn --verb 3 --dev null --{ifconfig,route}-noexec --client'
#up() { local p i=${1-1}; while ((i--)); do p+=../; done; cd "$p$2" && pwd; }
#vercmp() {
#	case $(command vercmp "$@") in
#	-1) echo "$1 < $2";;
#	 0) echo "$1 = $2";;
#	 1) echo "$1 > $2";;
#	esac
#}
#vimpaste() { vim <(getpaste "$1"); }
#alias vinft='sudo -E sh -c "vim /etc/nftables.conf && nft -f /etc/nftables.conf"'
#virdf() { vim -c "setf n3" <(rapper -q -o turtle "$@"); }
#visexp() { (echo "; vim: ft=sexp"; echo "; file: $1"; sexp-conv < "$1") \
#	| vipe | sexp-conv -s canonical | sponge "$1"; }
#alias w3m='w3m -title'
#wim() { local file=$(which "$1") && [[ $file ]] && editor "$file" "${@:2}"; }
#alias unwine='printf "\e[?1l \e>"'
#xar() { xargs -r -d '\n' "$@"; }
#alias xf='ps xf -O ppid'
#alias xx='chmod a+rx'
#alias zt1='zerotier-cli'
#alias '~'='egrep'
#alias '~~'='egrep -i'
#-() { cd -; }
#
## dates
#
#alias ssdate='date "+%Y%m%d"'
#alias sdate='date "+%Y-%m-%d"'
#alias mmdate='date "+%Y-%m-%d %H:%M"'
#alias mdate='date "+%Y-%m-%d %H:%M:%S %z"'
#alias ldate='date "+%A, %B %-d, %Y %H:%M"'
#alias mboxdate='date "+%a %b %_d %H:%M:%S %Y"'
#alias mimedate='date "+%a, %d %b %Y %H:%M:%S %z"' # RFC 2822
#alias isodate='date "+%Y-%m-%dT%H:%M:%S%z"' # ISO 8601
#
