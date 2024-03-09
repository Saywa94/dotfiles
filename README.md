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

Then install packer and run `:PackerSync` inside neovim

### Tmux

`ln -s ~/.dotfiles/tmux/ ~/.config`


To manage sessions in tmux I use Tmuxifier: https://github.com/jimeh/tmuxifier.
Ensure that tmuxifier in in PATH and that its layout_path points to `.dotfiles/tmux/layouts`.
```bash
export PATH="$HOME/.tmuxifier/bin:$PATH"
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmux/layouts"
```
When running and older version of tmux, pass the argument: `-f ~/.config/tmux/tmux.conf`.

