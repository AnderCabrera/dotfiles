# dotfiles

Configs managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

- nvim
- qtile
- rofi
- alacritty
- fish
- starship
- tmux
- .local/scripts

## Usage

```sh
git clone git@github.com:AnderCabrera/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -t ~ .
```

If a file already exists on the machine (and isn't a symlink), Stow won't overwrite it: it aborts and reports the conflict. Move/remove it by hand (or use `stow --adopt -t ~ .` to pull it into the repo and review with `git diff`) before running `stow -t ~ .` again.

To undo: `stow -D -t ~ .`
