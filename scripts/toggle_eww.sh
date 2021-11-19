#!/bin/sh

if xrandr -q | rg "HDMI1 connected"; then
    eww open --toggle dock_main
else
    eww open --toggle dock_laptop
fi
