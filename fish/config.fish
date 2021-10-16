#! /usr/bin/fish
#    __________  _____
#   / ____/ __ \/ ___/
#  / / __/ / / /\__ \  Gabriel Dos Santos
# / /_/ / /_/ /___/ /  https://github/dssgabriel
# \____/_____//____/
#
# My fish configuration. Not much to see here, just some pretty standard stuff.

# Setting up some variables
set fish_greeting                       # Supresses fish's intro message
set TERM "xterm-256color"               # Sets the terminal type
set EDITOR "kak"                        # $EDITOR use Neovim in terminal
set HOSTNAME "arch"                     # $HOSTNAME
set PATH $PATH ~/.cargo/bin/ ~/maqao.intel64.2.13.2/ ~/zig/build/bin/ ~/eww/target/release/
export PATH

# Directories shortcuts
alias m1 "cd ~/university/m1/s1/"
alias rs "cd ~/dev/rust/projects/"
alias zig "cd ~/dev/zig/"

# ls to exa
alias la "exa -ah --color=always --git --group-directories-first --sort extension"
alias le "exa -ahlT --color=always --git --group-directories-first --sort extension"
alias li "exa -ahl --color=always --git-ignore --group-directories-first --sort extension"
alias ll "exa -ahl --color=always --git --group-directories-first --sort extension"
alias ls "exa -hl --color=always --git --group-directories-first --sort extension"
alias lt "exa -hlT --color=always --git --group-directories-first --sort extension"
alias l. "exa -hld --color=always --git --group-directories-first --sort extension .*"

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

kitty + complete setup fish | source
