#!/bin/sh

# wallpaper
feh --bg-scale ~/Imágenes/Wallpapers/portal &
# compositor
picom &
# systray battery icon
cbatticon -u 5 &
# systray volume
volumeicon &
