#!/usr/bin/env bash

AXIAL_REPO="${HOME}/axial"
VELOCITY_DIR="${AXIAL_REPO}/k8s/velocity"

declare -A AXIAL_SERVICES
AXIAL_SERVICES=(
    ["account-service"]="${AXIAL_REPO}/src/services/account-service.git/"
    ["admin-app"]="${AXIAL_REPO}/src/services/admin-app.git/"
    ["authorization-service"]="${AXIAL_REPO}/src/services/authorization-service.git/"
    # ["axm"]="${AXIAL_REPO}/src/services/axm.git/"
    ["celery-scheduler"]="${AXIAL_REPO}/src/services/celery-scheduler.git/"
    ["deal-management-service"]="${AXIAL_REPO}/src/services/deal-management-service.git/"
    ["deals-lite-app"]="${AXIAL_REPO}/src/services/deals-lite-app.git/"
    ["document-service"]="${AXIAL_REPO}/src/services/document-service.git/"
    ["fe-app"]="${AXIAL_REPO}/src/services/fe-app.git/"
    ["feedback-service"]="${AXIAL_REPO}/src/services/feedback-service.git/"
    ["messaging-analytics"]="${AXIAL_REPO}/src/services/messaging/messaging-analytics.git/"
    ["messaging-client"]="${AXIAL_REPO}/src/services/messaging/messaging-client.git/"
    ["messaging-lambdas"]="${AXIAL_REPO}/src/services/messaging/messaging-lambdas.git/"
    ["messaging-open-email-handler"]="${AXIAL_REPO}/src/services/messaging/messaging-open-email-handler.git/"
    ["messaging-processor"]="${AXIAL_REPO}/src/services/messaging/messaging-processor.git/"
    ["messaging-template-manager"]="${AXIAL_REPO}/src/services/messaging/messaging-template-manager.git/"
    ["messaging-thread-manager"]="${AXIAL_REPO}/src/services/messaging/messaging-thread-manager.git/"
    ["messaging-virus-scanner"]="${AXIAL_REPO}/src/services/messaging/messaging-virus-scanner.git/"
    ["messaging-service"]="${AXIAL_REPO}/src/services/messaging-service.git/"
    ["search-service"]="${AXIAL_REPO}/src/services/search-service.git/"
    ["task-service"]="${AXIAL_REPO}/src/services/task-service.git/"
    ["transaction-service"]="${AXIAL_REPO}/src/services/transaction-service.git/"
    ["workflow-service"]="${AXIAL_REPO}/src/services/workflow-service.git/"
)

declare -A AXIAL_SERVICES_DIR
AXIAL_SERVICES_DIR=(
    ["account-service"]="${AXIAL_REPO}/src/services/account-service.git/"
    ["admin-app"]="${AXIAL_REPO}/src/services/admin-app.git/"
    ["authorization-service"]="${AXIAL_REPO}/src/services/authorization-service.git/"
    # ["axm"]="${AXIAL_REPO}/src/services/axm.git/"
    ["celery-scheduler"]="${AXIAL_REPO}/src/services/celery-scheduler.git/"
    ["deal-management-service"]="${AXIAL_REPO}/src/services/deal-management-service.git/"
    ["deals-lite-app"]="${AXIAL_REPO}/src/services/deals-lite-app.git/"
    ["document-service"]="${AXIAL_REPO}/src/services/document-service.git/"
    ["fe-app"]="${AXIAL_REPO}/src/services/fe-app.git/"
    ["feedback-service"]="${AXIAL_REPO}/src/services/feedback-service.git/"
    ["messaging-analytics"]="${AXIAL_REPO}/src/services/messaging/messaging-analytics.git/"
    ["messaging-client"]="${AXIAL_REPO}/src/services/messaging/messaging-client.git/"
    ["messaging-lambdas"]="${AXIAL_REPO}/src/services/messaging/messaging-lambdas.git/"
    ["messaging-open-email-handler"]="${AXIAL_REPO}/src/services/messaging/messaging-open-email-handler.git/"
    ["messaging-processor"]="${AXIAL_REPO}/src/services/messaging/messaging-processor.git/"
    ["messaging-template-manager"]="${AXIAL_REPO}/src/services/messaging/messaging-template-manager.git/"
    ["messaging-thread-manager"]="${AXIAL_REPO}/src/services/messaging/messaging-thread-manager.git/"
    ["messaging-virus-scanner"]="${AXIAL_REPO}/src/services/messaging/messaging-virus-scanner.git/"
    ["messaging-service"]="${AXIAL_REPO}/src/services/messaging-service.git/"
    ["search-service"]="${AXIAL_REPO}/src/services/search-service.git/"
    ["task-service"]="${AXIAL_REPO}/src/services/task-service.git/"
    ["transaction-service"]="${AXIAL_REPO}/src/services/transaction-service.git/"
    ["workflow-service"]="${AXIAL_REPO}/src/services/workflow-service.git/"
)

list_services () {
  (
    for service in ${!AXIAL_SERVICES_DIR[@]}
    do
 	printf "%s\n" $service
    done
  )|sort
}
get_service_dir () {
    [[ ! -v AXIAL_SERVICES_DIR["${service}"] ]] && echo "${service} is not a recognized service" 1>&2 && exit 1
    echo "${AXIAL_SERVICES_DIR[${service}]}"
}

forservice () {
  (   
    for service in ${!AXIAL_SERVICES_DIR[@]}
    do
      [ $# -eq 0 ] && echo "${AXIAL_SERVICES_DIR[${service}]}" && continue
      [ -z "$QUIET" ] && echo -e "\n\e[32m$service\e[0m  -- ${AXIAL_SERVICES_DIR[${service}]}"
      ( export SERVICE_NAME=$service ; cd "${AXIAL_SERVICES_DIR[${service}]}"; "${@}" )
    done
  )
}

alias vs=velocity-stack

prlist () {
 BRANCH=${BRANCH:-$(git rev-parse --abbrev-ref HEAD)}
 echo -e "\n\e[32m$service\e[0m -- $BRANCH -- $(pwd)"
 gh pr list -B $BRANCH --json url -t '{{range .}}  - {{.url}}{{"\n"}}{{end}}'
}

prs () { 
   (export QUIET=1; export BRANCH=${1:-$BRANCH}; cd ~/axial/ ; prlist ; forservice prlist)
}

pr_url() {
   gh pr view --json url -q .url
}
repo_url () {
	#gh repo view -b $(git rev-parse --abbrev-ref --symbolic-full-name @{u}|sed -e 's/origin.//') --json url -q .url
   echo $(gh repo view --json url -q .url)/tree/$(git rev-parse --abbrev-ref --symbolic-full-name @{u}|sed -e 's/origin.//')
}

repo_compare() {
   echo $(gh repo view --json url -q .url)/compare/$(git rev-parse --abbrev-ref --symbolic-full-name @{u}|sed -e 's/origin.//')...integration
   echo $(gh repo view --json url -q .url)/compare/integration...$(git rev-parse --abbrev-ref --symbolic-full-name @{u}|sed -e 's/origin.//')

}

vstatus () { 
	declare -A STATUS_COLOR
	STATUS_COLOR=(
	    ["InProgress"]="\e[33m"
	    ["Ready"]="\e[32m"
	    ["Pending"]="\e[90m"
	    ["Failed"]="\e[31m"
	)

	veloctl env status  --no-watch -o json | 
	  jq -r '.services[]| "\(.name) \(.status)"' |
	  ( 
	    while read name status; do
		COLOR=${STATUS_COLOR[$status]}	
		echo -e "$COLOR $name \e[0m"
	    done
	  ) | column
}
alias wvstatus='watch -c -x bash -c "source /vagrant/axial_common.sh; vstatus"'
alias st='local_stack'

vault_refresh () {
    VAULT_USER=markus
    export VAULT_ADDR='https://vault-kube.axialmarket.com' ;
    TOKEN=$(
      export VAULT_TOKEN=$(op item get 'Axial - Master Vault' --fields password);
      VAULT_POLICY=$(vault kv get -field='policy' secret/user/$VAULT_USER)
      vault token create -ttl 24h -policy $VAULT_POLICY -field=token
    )
    export VAULT_TOKEN=$TOKEN
    (op item edit 'Axial - Vault' "password=$TOKEN") 2>&1 >/dev/null
}

