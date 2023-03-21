#! /usr/bin/fish
#    __________  _____
#   / ____/ __ \/ ___/
#  / / __/ / / /\__ \  Gabriel Dos Santos
# / /_/ / /_/ /___/ /  https://github/dssgabriel
# \____/_____//____/
#
# My fish configuration. Not much to see here, just some pretty standard stuff.

# Setting up some variables
set --universal SXHKD_SHELL sh

set --export XDG_CONFIG_HOME $HOME/.config
set --export XDG_CACHE_HOME $HOME/.cache
set --export XDG_DATA_HOME $HOME/.local/share
set --export XDG_STATE_HOME $HOME/.local/state

set --export CARGO_HOME $XDG_DATA_HOME/cargo
set --export RUSTUP_HOME $XDG_DATA_HOME/rustup
set --export GNUPGHOME $XDG_DATA_HOME/gnupg
set --export GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
set --export GOPATH $XDG_DATA_HOME/go
set --export IPYTHONDIR $XDG_CONFIG_HOME/ipython
set --export JUPYTER_CONFIG_DIR $XDG_CONFIG_HOME/jupyter
set --export PASSWORD_STORE_DIR $XDG_DATA_HOME/pass

set --export XCURSOR_PATH /usr/share/icons $XDG_DATA_HOME/icons

set fish_greeting         # Supresses fish's intro message
set TERM "xterm-256color" # Sets the terminal type
set EDITOR "hx"           # $EDITOR use Helix in terminal
set HOSTNAME "hyperion"   # $HOSTNAME
set PAGER "bat"
set PATH $PATH $CARGO_HOME/bin ~/oss/eww/target/release ~/.local/bin

export PATH

# ls to exa
alias la "exa -ah --color=always --git --group-directories-first --sort extension"
alias le "exa -ahlT --color=always --git --group-directories-first --sort extension"
alias li "exa -ahl --color=always --git --git-ignore --group-directories-first --sort extension"
alias ll "exa -ahl --color=always --git --group-directories-first --sort extension"
alias ls "exa -hl --color=always --git --group-directories-first --sort extension"
alias lt "exa -hlT --color=always --git --group-directories-first --sort extension"
# alias l. "exa -hld --color=always --git --group-directories-first --sort extension"

# Prompt before overwriting something
alias cp "cp -i"
alias mv "mv -i"
alias rm "rm -i"
alias yeet "rm -rf"

# Adding flags
alias df "df -h"
alias mpirun "mpirun --mca opal_warn_on_missing_libcuda 0"
alias make "make -j"
alias wget "wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"

# Git shortcuts
alias ga "git add"
alias gc "git commit"
alias gd "git diff"
alias gl "git log"
alias gr "git restore"
alias gs "git status"

# Switch between shells
alias tobash "sudo chsh $USER -s /bin/bash"
alias tofish "sudo chsh $USER -s /usr/bin/fish"

# Renaming stuff
alias bt "bpytop"
alias py "python"
alias tmux "tmux -2"

function watts
    upower -i (upower -e | rg bat) | rg 'energy-rate' | awk '{print "Current wattage: "$2$3;}'
end

function weather
    curl wttr.in/paris
end

# Functions needed for !! and !$
# Will only work in default (emacs) mode.
# Will NOT work in vi mode.
function __history_previous_command
    switch (commandline -t)
    case "!"
        commandline -t $history[1]; commandline -f repaint
    case "*"
        commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
    case "!"
        commandline -t ""
        commandline -f history-token-search-backward
    case "*"
        commandline -i '$'
    end
end

# The bindings for !! and !$
bind ! __history_previous_command
bind '$' __history_previous_command_arguments

# Use the starship prompt
starship init fish | source

# kitty + complete setup fish | source
. ~/oss/spack/share/spack/setup-env.fish
# fish_add_path /home/gabrl/.spicetify
