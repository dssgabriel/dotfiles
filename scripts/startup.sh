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
    xrandr --output HDMI1 --mode 2560x1080 --primary --above eDP1 --pos -320x1080
fi
xrandr --output eDP1 --mode 1920x1080

# Load wallpaper
feh --bg-tile ~/pictures/wallpapers/xtile_mono.png

# Start compositor
picom --config ~/.config/picom/picom.conf &

# Start dunst
dunst &

# Start the eww daemon
eww daemon

# Start bspwm
exec bspwm
