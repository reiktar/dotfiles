
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## CTO.ai - OPS
## Workaround for Docker Desktop not creating docker.sock in /var/run/ directory 
## This is needed for the OPS command to find the Docker socket
if  [ -S /.docker/desktop/docker.sock ]; then
	export DOCKER_SOCKET=~/.docker/desktop/docker.sock
fi

##GCALCLIi
alias next='gcalcli --calendar markus.jonsson@axial.net next --details=all'

## PIVOTAL
export PIVOTAL_TOKEN=ed0ac5dbc3468007e28690d42c673c30

## Axial
alias dms='cd ~/axial/src/services/deal-management-service.git/deal_management_service'
alias axm='cd ~/axial/src/services/axm.git/lib/python2.7/site-packages'
export EDITOR=vim

## NVM 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#DIRENV
eval "$(direnv hook bash)"

## INOTIFYWATCH
iwatch () { 
    #inotifywait -m --exclude "[^j].$|[^s]$" $1 -e create -e moved_to |
    #inotifywait -r -m --exclude "[^j].$|[^s]$" $1 |
    inotifywait -r -e close_write -m . |
    while read dir action file; do
	  #if [[ "$file" =~ .*go$ ]] ; then
	      echo "The file '$file' appeared in directory '$dir' via '$action'"
		    pwd
        ./$1
	  #fi
    done
}
