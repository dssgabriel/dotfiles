#!/bin/sh
#    __________  _____
#   / ____/ __ \/ ___/
#  / / __/ / / /\__ \  Gabriel Dos Santos
# / /_/ / /_/ /___/ /  https://github/dssgabriel
# \____/_____//____/
#
# My polybar script.

# Terminate running instances
killall -q polybar

# Launch main bar
echo "---" | tee -a /tmp/polybar_main.log
polybar main 2>&1 | tee -a /tmp/polybar_main.log & disown
