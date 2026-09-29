#!/bin/sh
# usage: ./install.sh nvim qtile rofi ...
for name in "$@"; do
  case "$name" in
    tmux) ln -sv ~/dotfiles/.tmux.conf ~/.tmux.conf ;;
    scripts) ln -sv ~/dotfiles/.local/scripts ~/.local/scripts ;;
    *) ln -sv ~/dotfiles/.config/"$name" ~/.config/"$name" ;;
  esac
done
