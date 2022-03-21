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
set PATH $PATH ~/.cargo/bin/ ~/zig/build/bin/ ~/eww/target/release/ ~/spack/bin/ ~/.local/bin/ ~/scilab/bin/
export PATH

# ls to exa
alias la "exa -ah --color=always --git --group-directories-first --sort extension"
alias le "exa -ahlT --color=always --git --group-directories-first --sort extension"
alias li "exa -ahl --color=always --git --git-ignore --group-directories-first --sort extension"
alias ll "exa -ahl --color=always --git --group-directories-first --sort extension"
alias ls "exa -hl --color=always --git --group-directories-first --sort extension"
alias lt "exa -hlT --color=always --git --group-directories-first --sort extension"
alias l. "exa -hld --color=always --git --group-directories-first --sort extension .*"

# Prompt before overwriting something
alias cp "cp -i"
alias mv "mv -i"
alias rm "rm -i"
alias yeet "rm -rf"

# Adding flags
alias df "df -h"
alias mpirun "mpirun --mca opal_warn_on_missing_libcuda 0"
alias make "make -j"

# Git shortcuts
alias gs "git status"
alias gl "git log"

# Switch between shells
alias tobash "sudo chsh $USER -s /bin/bash"
alias tofish "sudo chsh $USER -s /usr/bin/fish"

# Renaming stuff
alias bt "bpytop"
alias py "python"

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
. ~/spack/share/spack/setup-env.fish
