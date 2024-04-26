# Colored prompt with git status
PS1='\[\033[01;32m\]@\u:\[\e[38;5;99m\]\w\n\[\e[38;5;221m\]\\$\[\e[0m\]\[\e[38;5;79m\]$(__git_ps1 "(%s)")\[\e[0m\] '

# Set neovim as default editor
export EDITOR=nvim

# Go path
export PATH=$PATH:/usr/local/go/bin

# Tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmux/layouts"

# Git integration
source ~/.git-prompt.sh

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

