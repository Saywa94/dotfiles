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

		-- The Primgean Harpoon 2
		use({
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			requires = { { "nvim-lua/plenary.nvim" } },
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

		-- Hardtime to nag me on bad habits
		use({
			"m4xshen/hardtime.nvim",
			requires = { "MunifTanjim/nui.nvim" },
		})
		-- Nvim notifications
		use("rcarriga/nvim-notify")
	end,
	config = {
		package_root = vim.fn.stdpath("config") .. "/site/pack",
	},
})
