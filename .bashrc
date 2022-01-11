#!/bin/bash

# path
export PATH="$PATH:$HOME/bin"

# my aliases
alias ls="ls --color"
alias ll="ls -la"

# git aliases
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gc="git commit"
alias ga="git add"
alias gl="git log"
alias gpl="git pull"
alias gps="git push"

# use vim as default editor
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR

if bash --version | head -n 1 | egrep -v '(version 2|version 3)' > /dev/null 2>&1; then
    # trueline based prompt only works when at least bash v4 is available
    export TRUELINE_USER_ALWAYS_SHOW_HOSTNAME=true
    export TRUELINE_USER_SHORTEN_HOSTNAME=true
    declare -a TRUELINE_SEGMENTS=(
        'user,black,light_blue,normal'
        'aws_profile,black,purple,normal'
        'venv,black,green,normal'
        'conda_env,black,green,normal'
        'git,grey,special_grey,normal'
        'working_dir,mono,cursor_grey,normal'
        'read_only,black,orange,bold'
        # 'bg_jobs,black,orange,bold'
        'exit_status,black,red,bold'
        'newline,black,green,bold'
    )
    source ~/.trueline.sh
fi

test -f ~/.bashrc_work && source ~/.bashrc_work || true
test -f ~/.bashrc_home && source ~/.bashrc_home || true
