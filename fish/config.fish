#! /usr/bin/fish
#    __________  _____
#   / ____/ __ \/ ___/
#  / / __/ / / /\__ \  Gabriel Dos Santos
# / /_/ / /_/ /___/ /  https://github/dssgabriel
# \____/_____//____/
#
# My fish configuration. Not much to see here, just some pretty standard stuff.

# Setting up some variables
set PATH $PATH ~/jdk-11.0.8+10/bin
set fish_greeting                       # Supresses fish's intro message
set TERM "xterm-256color"               # Sets the terminal type
set EDITOR "nvim"                       # $EDITOR use Neovim in terminal
set VISUAL "emacsclient -c -a emacs"    # $VISUAL use Emacs in GUI mode
set LOCALHOST "gnix"

# Prompt before overwriting something
alias cp "cp -i"
alias mv "mv -i"
alias rm "rm -i"

# Adding flags
alias df "df -h"                          # human-readable sizes
alias doom "~/.emacs.d/bin/doom"

# Switch between shells
alias tobash "sudo chsh $USER -s /bin/bash"
alias tofish "sudo chsh $USER -s /usr/bin/fish"

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
#starship init fish | source
