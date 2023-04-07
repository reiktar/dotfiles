
vagrant() {
        if [[ $1 == "ssh" ]]; then
		BOX="default"

                if [[ ! -f vagrant-ssh-config ]]; then
                    command vagrant ssh-config > vagrant-ssh-config 
		fi
                if [[ ! -z "$2" ]]; then
                        BOX=$2
		fi
		echo ssh -A -F vagrant-ssh-config $BOX 
		ssh -A -F vagrant-ssh-config $BOX 
        elif [[ $1 == "destroy" ]]; then
	        if [[ -f vagrant-ssh-config ]]; then 
		   rm -f vagrant-ssh-config
		fi
		command vagrant "$@"
        else
                command vagrant "$@"
        fi
}

alias vu='vagrant up'
alias vd='vagrant halt; vagrant destroy -f'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias v='vagrant'
