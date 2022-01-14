#!/bin/sh
xrandr --output HDMI-2 --off --output HDMI-1 --off --output eDP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output DP-3 --mode 1024x768 --pos 872x2160 --rotate normal --output DP-2 --off
feh --bg-scale ~/.config/i3/desktop.jpg
