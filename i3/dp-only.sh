#!/bin/sh
xrandr --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output eDP-1 --off --output DP-2 --off
feh --bg-scale ~/.config/i3/desktop.jpg
