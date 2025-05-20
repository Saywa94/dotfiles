# My dotfiles

Configurations files for:

### Neovim

To replace an already existing neovim configuration:
```bash
ln -s ~/.dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -s ~/.dotfiles/nvim/lua/ ~/.config/nvim/
```
For a new neovim installation:
`ln -s ~/.dotfiles/nvim/ ~/.config/`

Then install packer and run `:PackerSync` inside neovim (ensure that lines requiring vars, opts and keys are commented. Uncomment them after PackerSync).
Some plugins require the `make`, `ripgrep` and `unzip` linux packages to be installed.
PHP lsp + fixer require php composer, `php-mbstring` and `php-xml` extension to be installed.
Golsp requires go to be installed.
Mason requires npm/node to be installed.
Ensure that Mason installs: pint, prettier, stylua, sql-formatter for formating.

### Tmux

`ln -s ~/.dotfiles/tmux/ ~/.config`


To manage sessions in tmux I use Tmuxifier: https://github.com/jimeh/tmuxifier.
Ensure that tmuxifier in in PATH and that its layout_path points to `.dotfiles/tmux/layouts`.
```bash
export PATH="$HOME/.tmuxifier/bin:$PATH"
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmux/layouts"
```
When running and older version of tmux, pass the argument: `-f ~/.config/tmux/tmux.conf`.

### Alacritty

Make symbolic link: `ln -s ~/.dotfiles/alacritty/ ~/.config`

### Key remap

I use [Keyd](https://github.com/rvaiya/keyd) to remap CapsLock to esc on press and ctrl on hold.
Make symbolic link: `sudo ln -s ~/.dotfiles/keyd/default.conf /etc/keyd/default.conf`
