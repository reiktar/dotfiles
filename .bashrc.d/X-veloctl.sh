source <(veloctl completion bash)

__velocity_prompt () {
	if [ -n $VELOCITY_ENVIRONMENT ]; then
		echo "($VELOCITY_ENVIRONMENT) "
	fi
}
PS1="\$(__velocity_prompt)${PS1}"
