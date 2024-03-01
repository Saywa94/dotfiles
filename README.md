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
