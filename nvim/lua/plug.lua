return require('packer').startup({
    function(use)
        -- [[ Plugins Go Here ]]
        use 'wbthomason/packer.nvim'

        -- Fuzzy finder 
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.5',
            -- or                            , branch = '0.1.x',
            requires = { {'nvim-lua/plenary.nvim'} },
            requires = { {'BurntSushi/ripgrep'} }
        }
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        -- filesystem navigation + icons
        use 'nvim-tree/nvim-web-devicons'
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons'
        }

        -- [[ Theme ]]
        use { 'mhinz/vim-startify' }                       -- start screen
        use { 'DanilaMihailov/beacon.nvim' }               -- cursor jump
        use {
            'nvim-lualine/lualine.nvim',                     -- statusline
            requires = {'kyazdani42/nvim-web-devicons',
            opt = true}
        }
        use { 'Mofiqul/dracula.nvim' }                     -- colorscheme
        use ( 'folke/tokyonight.nvim', { lazy = false, priority = 1000, ops = {} } )

        -- [[ Dev ]]
        use { 'windwp/nvim-autopairs' }
        use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
        use { 'lewis6991/gitsigns.nvim' }       -- Useful: diffthis, next/prev hunk, reset_hunk, reset_buffer
        use { "folke/trouble.nvim" }        -- Diagnostics

        -- The Primgean Harpoon 2
        use {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            requires = { {"nvim-lua/plenary.nvim"} }
        }
        -- LSP zero
        use { 
            "L3MON4D3/LuaSnip", 
            tag = "v2.*", 
            run = "make install_jsregexp",
            requires = {
                {'rafamadriz/friendly-snippets'},
            }
        }
        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            requires = {
                --- manage the language servers from neovim
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},

                -- LSP Support
                {'neovim/nvim-lspconfig'},
                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-nvim-lsp'},
            }
        }

    end,
    config = {
        package_root = vim.fn.stdpath('config') .. '/site/pack'
    }
})
