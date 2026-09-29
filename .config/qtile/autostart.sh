#!/bin/sh

setxkbmap latam &
# xrandr --output HDMI-0 --mode 1920x1080 --rate 239.76 &
picom &
feh --bg-scale ~/Pictures/Wallpapers/31.jpg &
nm-applet &
udiskie -t &
# Required for volctl, which now uses SNI instead of XEmbed.
# snixembed &
volctl &
blueman-applet &
greenclip daemon &
