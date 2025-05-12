return require("packer").startup({
	function(use)
		-- [[ Plugins Go Here ]]
		use("wbthomason/packer.nvim")

		-- Fuzzy finder
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.7",
			-- or                            , branch = '0.1.x',
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "BurntSushi/ripgrep" },
			},
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		-- filesystem navigation + icons
		use("nvim-tree/nvim-web-devicons")
		use({
			"nvim-tree/nvim-tree.lua",
			requires = "nvim-tree/nvim-web-devicons",
		})

		-- [[ Theme ]]
		use({ "mhinz/vim-startify" }) -- start screen
		use({ "DanilaMihailov/beacon.nvim" }) -- cursor jump
		use({
			"nvim-lualine/lualine.nvim", -- statusline
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		-- [[ Colorscheme ]]
		use({ "Mofiqul/dracula.nvim" })
		use("folke/tokyonight.nvim", { lazy = false, priority = 1000, ops = {} })

		-- [[ Dev ]]
		use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
		use({ "lewis6991/gitsigns.nvim" }) -- Useful: diffthis, next/prev hunk, reset_hunk, reset_buffer
		use({ "folke/trouble.nvim" }) -- Diagnostics

		-- The Primgean Harpoon 2
		use({
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			requires = { { "nvim-lua/plenary.nvim" } },
		})

		-- Autocompletion
		use({ "hrsh7th/cmp-nvim-lsp" })
		use({ "hrsh7th/cmp-buffer" })
		use({ "hrsh7th/cmp-path" })
		use({ "hrsh7th/cmp-cmdline" })
		use({ "hrsh7th/nvim-cmp" })

		-- LSP zero
		use({
			"L3MON4D3/LuaSnip",
			tag = "v2.*",
			after = "nvim-cmp",
			run = "make install_jsregexp",
			requires = {
				{ "rafamadriz/friendly-snippets" },
			},
		})
		use({ "saadparwaiz1/cmp_luasnip" })

		use({
			"VonHeikemen/lsp-zero.nvim",
			branch = "v3.x",
			requires = {
				--- manage the language servers from neovim
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },

				-- LSP Support
				{ "neovim/nvim-lspconfig" },
				-- Notifications
				{ "j-hui/fidget.nvim" },
			},
		})

		-- CODEIUM Autocompletion AI
		use({
			"Exafunction/codeium.vim",
			config = function()
				vim.keymap.set("i", "<S-Tab>", function()
					return vim.fn["codeium#CycleCompletions"](1)
				end, { expr = true })
			end,
		})
		-- Linter / Formatter
		use({ "stevearc/conform.nvim" })

		-- Comments
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
		-- Todo highlight
		use({ "folke/todo-comments.nvim" })

		-- Css colors highlight
		use({ "norcalli/nvim-colorizer.lua" })

		-- Typescript tools
		use({
			"pmizio/typescript-tools.nvim",
			requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			config = function()
				require("typescript-tools").setup({})
			end,
		})
	end,
	config = {
		package_root = vim.fn.stdpath("config") .. "/site/pack",
	},
})
