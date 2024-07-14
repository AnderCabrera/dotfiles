set fish_greeting ""

#set -gx PATH $PATH /opt/nvim/
set -x DENO_INSTALL "$HOME/.deno"
set -x PATH "$DENO_INSTALL/bin" $PATH

# Alias
alias ls="exa -l --icons"
alias lsa="exa -al --icons"
alias lst="exa -alT --icons"
alias lsg="exa -al --icons --git"
alias lsgt="exa -alT --icons --git"
alias cat="batcat"
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# if status is-interactive
#     # Commands to run in interactive sessions can go here
#     neofetch
# end
    
starship init fish | source

