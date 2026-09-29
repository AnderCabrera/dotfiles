set fish_greeting 
set -Ux SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set -gx PATH /usr/local/bin /opt/homebrew/bin $PATH
set PATH /opt/homebrew/opt/openjdk@17/bin $PATH
set CPPFLAGS "-I/opt/homebrew/opt/openjdk@17/include"
set PATH $PATH $HOME/.local/bin
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

set ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set PATH $PATH $ANDROID_SDK_ROOT/emulator
set PATH $PATH $ANDROID_SDK_ROOT/platform-tools
set -x PATH $HOME/Downloads/flutter/bin $PATH
set PATH "$PATH":"$HOME/.local/scripts/"

bind \cf "tmux-sessionizer"

alias ls eza
alias cat bat

starship init fish | source

# opencode
fish_add_path $HOME/.opencode/bin
