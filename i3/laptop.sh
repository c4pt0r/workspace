#!/bin/sh
xrandr --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --off --output eDP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off
feh --bg-scale ~/.config/i3/desktop-arch.png
