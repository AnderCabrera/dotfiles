set fish_greeting 
set -gx PATH /usr/local/bin /opt/homebrew/bin $PATH
set PATH /opt/homebrew/opt/openjdk@17/bin $PATH
set CPPFLAGS "-I/opt/homebrew/opt/openjdk@17/include"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

set ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set PATH $PATH $ANDROID_SDK_ROOT/emulator
set PATH $PATH $ANDROID_SDK_ROOT/platform-tools
set -x PATH $HOME/Downloads/flutter/bin $PATH
set PATH "$PATH":"$HOME/.local/scripts/"

bind \cf "tmux-sessionizer"

alias ls eza
alias lb="ls -l --bytes"
alias di="rm *.jpeg"

starship init fish | source
