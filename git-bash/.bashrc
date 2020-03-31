# Path is: %home%

# Username
export USER=dany74q

# SSH configuration
eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")

if [ -z "$(ps aux | grep ssh-agent)" ]; then
	rm -rf /tmp/ssh-*
		eval $(ssh-agent -s) > /dev/null
else
	export SSH_AGENT_PID=$(ps aux | grep -m 1 tmux | awk '{print $1}')
	export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name agent.*)

	ssh-add ~/.ssh/*
fi

# Attach / create a tmux session
tmux a || tmux new