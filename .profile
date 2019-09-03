
# setup ssh-agent
SHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
fi

# source the .bashrc (normally not sourced when logging in via ssh)
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
