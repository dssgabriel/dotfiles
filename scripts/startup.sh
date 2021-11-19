#! /bin/sh
#    __________  _____
#   / ____/ __ \/ ___/
#  / / __/ / / /\__ \  Gabriel Dos Santos
# / /_/ / /_/ /___/ /  https://github/dssgabriel
# \____/_____//____/
#
# My startup script.

# Set HDMI1 when connected
if xrandr -q | rg "HDMI1 connected"; then
    xrandr --output HDMI1 --primary --above eDP1 --pos -320x1080
fi

# Load wallpaper
feh --bg-tile ~/pictures/wallpapers/xtile_mono.png

# Start polybar
polybar -q ~/.config/polybar/launch.sh &

# Start dunst
dunst &

# Start the eww daemon
eww daemon

# Start bspwm
exec bspwm
