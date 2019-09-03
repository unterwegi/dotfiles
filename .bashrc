#!/bin/bash

# path
export PATH="$PATH:~/bin"

# my aliases
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

# prompt
function prompt_command {
    local RETURN_CODE="$?"
    local ASCII_RESET="\[\e[0m\]"
    local ASCII_BOLD="\[\e[1;37m\]"
    local USER_COLOR="\[\e[0;34m\]"
    local PROMPT_COLOR="\[\e[0;37m\]"
    local HOST_COLOR="\[\e[1;37m\]"
    local PWD_COLOR="\[\e[0;31m\]"
    local TIME_COLOR="\[\e[1;32m\]"
    local TIME_STRING="\$(date +%H:%M:%S)"
    local RED_COLOR="\[\e[1;31m\]"
    local VENV_COLOR="\[\e[1;35m\]"

    local PROMPT_PREFIX=""
    if [ ! -z "$VIRTUAL_ENV" ]; then
        # include virtualenv
        PROMPT_PREFIX="$VENV_COLOR$(basename $VIRTUAL_ENV)$ASCII_RESET "
    fi
    if `type __git_ps1 > /dev/null 2>&1` && `type git > /dev/null 2>&1`; then
        # include git branch if we are inside a git repo
        local GIT_BRANCH="$(__git_ps1 "(%s)")"
        if [ ! -z "$GIT_BRANCH" ]; then
            PROMPT_PREFIX="$PROMPT_PREFIX$USER_COLOR$GIT_BRANCH$ASCII_RESET "
        fi
    fi
    if [[ $RETURN_CODE != 0 ]] ; then
        # include last return code
        PROMPT_PREFIX="$PROMPT_PREFIX$RED_COLOR$RETURN_CODE$ASCII_RESET "
    fi

    PS1="$ASCII_BOLD[$USER_COLOR\u$ASCII_RESET$ASCII_BOLD@$HOST_COLOR\h $TIME_COLOR$TIME_STRING $PROMPT_PREFIX$PWD_COLOR\W$ASCII_RESET$ASCII_BOLD]$ASCII_RESET$PROMPT_COLOR\\\$$ASCII_RESET "
}

export PROMPT_COMMAND=prompt_command

test -f .bashrc_work && source .bashrc_work
test -f .bashrc_home && source .bashrc_home
