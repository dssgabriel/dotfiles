#    __________  _____
#   / ____/ __ \/ ___/
#  / / __/ / / /\__ \  Gabriel Dos Santos
# / /_/ / /_/ /___/ /  University of Versailles Saint-Quentin-en-Yvelines
# \____/_____//____/
#
# My bash configuration for remote servers.


# SETUP
# ------------------------------------------------------------------------------
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Exports
export GREP_OPTIONS='-R --color=always'
export EDITOR=vim


# ALIASES
# ------------------------------------------------------------------------------
# Listing
alias ls='ls -lhL --color=always --group-directories-first -X'
alias la='ls -ahL --color=always --group-directories-first -X'
alias ll='ls -lahL --color=always --group-directories-first -X'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Ask to confirm before overwriting something
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Git
alias gs='git status'
alias gl='git log'
alias gb='git blame'
alias gd='git diff'
alias gr='git restore'
alias ga='git add'

# Others
alias yeet='rm -Rf'
alias df='df -h'
alias py='python'
alias so='source ~/.bashrc'


# SHELL PROMPT
# ------------------------------------------------------------------------------
PS1='\[\033[1;31m\]\h\[\033[1;33m\]:\[\033[1;34m\]\W \[\033[1;33m\]|\[\033[0m\] '


# COMPLETIONS
# ------------------------------------------------------------------------------
# Source global completions
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

# Easy search in history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Auto-complete Makefile commands
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make
