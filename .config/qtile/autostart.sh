#!/bin/bash

function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}

feh --bg-scale ~/Pictures/Wallpapers/104.png &

# autostart ArcoLinux Welcome App
# run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop &

#start the conky to learn the shortcuts
# (conky -c $HOME/.config/qtile/scripts/system-overview) &

run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

run variety &
run nm-applet &
run udiskie -t &
# run pamac-tray &
run xfce4-power-manager &
numlockx on &
blueman-applet &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# compositor
picom & # --config $HOME/.config/qtile/scripts/picom.conf &
# systray battery icon
cbatticon -n -u 5 &
# systray volume
volumeicon &
discord --start-minimized &
