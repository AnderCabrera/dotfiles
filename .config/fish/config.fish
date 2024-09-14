set fish_greeting ""

# Alias
alias ls="exa -l --icons"
alias lsa="exa -al --icons"
alias lst="exa -alT --icons"
alias lsg="exa -al --icons --git"
alias lsgt="exa -alT --icons --git"
alias cat="bat"
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

starship init fish | source

#fastfetch
#alsi
#screenfetch
#paleofetch
#fetch
#hfetch
#sfetch
#ufetch
#ufetch-arco
#pfetch
#sysinfo
#sysinfo-retro
#cpufetch
#hyfetch
#colorscript random
