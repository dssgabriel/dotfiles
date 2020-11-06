#    __________  _____
#   / ____/ __ \/ ___/
#  / / __/ / / /\__ \  Gabriel Dos Santos
# / /_/ / /_/ /___/ /  https://github/dssgabriel
# \____/_____//____/                
# 
# My aliases for bash.


# Root privileges
alias pls="sudo !!"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# Text editors
alias vi="nvim"
alias em="emacs -nw"

# System maintenance
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias install="sudo apt install"
alias search="sudo apt search"

# Changig 'ls' to 'exa'
alias ls="exa -ls extension --color=always --group-directories-first"  # Standard outpout
alias la="exa -as extension --color=always --group-directories-first"  # All files and dirs
alias ll="exa -las extension --color=always --group-directories-first" # Long full format
alias lt="exa -aTs extension --color=always --group-directories-first" # Tree listing
alias le="exa -laT --sort extension --level 2 --color=always --group-directories-first"
alias l.="exa -las extension --color=always | egrep '^\.'" 			# Only dotfiles

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Ask to confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias status='git status'
alias tag='git tag'
alias newtag='git tag -a'

# Shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# Others
alias yeet="rm -rf"
alias df="df -h"
alias zat="zathura"
alias doom="~/.emacs.d/bin/doom"
alias updot="~/scripts/updot.sh"
