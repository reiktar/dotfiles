# 1password
source <(op completion bash)

if [ -S ~/.1password/agent.sock ]; then
	export SSH_AUTH_SOCK=~/.1password/agent.sock
fi

if [ -f ~/.config/op/plugins.sh ]; then
	source ~/.config/op/plugins.sh
fi
