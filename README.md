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

## Selective install

To symlink only specific configs instead of everything, use `install.sh`:

```sh
./install.sh nvim qtile rofi
```

Supported names: `nvim`, `qtile`, `rofi`, `alacritty`, `fish`, `starship` (all under `.config`), plus `tmux` and `scripts` as special cases. It won't overwrite an existing file/symlink at the target.
