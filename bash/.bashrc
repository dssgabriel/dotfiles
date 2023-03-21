#    __________  _____
#   / ____/ __ \/ ___/
#  / / __/ / / /\__ \  Gabriel Dos Santos
# / /_/ / /_/ /___/ /  https://github/dssgabriel
# \____/_____//____/
#
# My bash configuration. Not much to see here, just some pretty standard stuff.

[[ $- == *i* ]] && source $HOME/.local/share/blesh/ble.sh --noattach

### EXPORTS ###
export PATH=$PATH:$XDG_DATA_HOME/cargo/bin
export HISTFILE=$XDG_STATE_HOME/bash/history
source "$XDG_DATA_HOME/cargo/env"
. ~/oss/spack/share/spack/setup-env.sh

### ARCHIVE EXTRACTION
# usage: ex file
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### Aliases ###
# Root privileges
alias sudo="doas"

# ls
alias ls="exa -ls extension --color=always --group-directories-first --git --git-ignore"
alias la="exa -as extension --color=always --group-directories-first"
alias ll="exa -las extension --color=always --group-directories-first"
alias lt="exa -lTs extension --color=always --group-directories-first"
alias le="exa -laTs extension --color=always --group-directories-first"
alias li="exa -lTs extension --color=always --group-directories-first --git --git-ignore"
alias l.="exa -las extension --color=always --group-directories-first | egrep '^\.'"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# Ask to confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Shutdown or reboot
alias off="doas shutdown now"

# Others
alias yeet="rm -Rf"
alias df="df -h"
alias zat="zathura"
alias doom="~/.emacs.d/bin/doom"
alias make="make -j"
alias py="python"
alias setintel="source /opt/intel/oneapi/setvars.sh"

### Shell prompt ###
PS1='\[\033[01;31m\]\h\[\033[01;33m\]:\[\033[01;34m\]\W \[\033[01;33m\]|\[\033[0m\] '

if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

[[ ${BLE_VERSION-} ]] && ble-attach
