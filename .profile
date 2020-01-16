
# setup ssh-agent
SHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
fi

## Fix TERM variable
# When connecting from a newer OS (e.g. RHEL 7) to an ancient one (e.g. RHEL 3),
# TERM might contain a value the ancient one does not know about; in that case,
# fall back to "screen" or "xterm"
#
# On Linux, the used terminal should have an entry in /usr/share/terminfo/
if [ -d /usr/share/terminfo ]; then
    if [ ! -e /usr/share/terminfo/"${TERM:0:1}/$TERM" ]; then
        # If it's screen-foobar, just use "screen"
        if [ "${TERM:0:6}" = 'screen' ]; then
            if [ -e /usr/share/terminfo/s/screen ]; then
                TERM=screen
            else
                TERM=xterm
            fi
        # otherwise fall back to "xterm", that should work
        else
            TERM=xterm
        fi
    fi
# If there is no /usr/share/terminfo/, we are most likely on Solaris, so fall
# back to "dtterm"
else
    TERM=dtterm
fi
export TERM

# source the .bashrc (normally not sourced when logging in via ssh)
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
