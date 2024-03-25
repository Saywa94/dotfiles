-- [[ init.lua ]]

-- Disable netrw for better nvim-tree integration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.localleader = "\\"

-- IMPORTS
require("vars") -- Variables
require("opts") -- Options
require("keys") -- Keymaps
require("plug") -- Plugins

-- PLUGINS: Add this section
require("nvim-tree").setup({
	git = {
		ignore = false,
	},
})
require("lualine").setup({
	options = {
		theme = "dracula-nvim",
	},
	sections = {
		lualine_c = {
			{
				"filename",
				path = 1,
				symbols = {
					modified = " ", -- Text to show when the file is modified
					readonly = " ", -- Text to show when the file is non-modifiable or readonly
					unnamed = "[No Name]", -- Text to show for unnamed buffers
					newfile = "[New]", -- Text to show for newly created file before first write
				},
			},
			{ "codeium#GetStatusString", color = { fg = "#FFEB3B" } },
		},
	},
})

require("nvim-autopairs").setup({})

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"markdown",
		"javascript",
		"typescript",
		"python",
		"php",
		"go",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"bash",
		"comment",
		"dockerfile",
		"tsx",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = { "php" },
	},
})

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "<leader>gj", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "<leader>gk", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map("n", "<leader>gp", gs.preview_hunk)
		map("n", "<leader>gsb", gs.stage_buffer)
		map("n", "<leader>gu", gs.undo_stage_hunk)
		map("n", "<leader>gd", gs.diffthis)
		map("n", "<leader>gb", function()
			gs.blame_line({ full = true })
		end)
	end,
})

local harpoon = require("harpoon")
harpoon:setup({})

-- LSP
local lsp_zero = require("lsp-zero")

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"cssls",
		"eslint",
		"lua_ls",
		"phpactor",
		"pyright",
		"tsserver",
		"gopls",
	},
	handlers = {
		lsp_zero.default_setup,
	},
})

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
lspconfig.phpactor.setup({})

local slow_format_filetypes = {}
-- Formatter
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		php = { "pint" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
	},
	format_on_save = function(bufnr)
		if slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		local function on_format(err)
			if err and err:match("timeout$") then
				slow_format_filetypes[vim.bo[bufnr].filetype] = true
			end
		end

		return { timeout_ms = 200, lsp_fallback = true }, on_format
	end,

	format_after_save = function(bufnr)
		if not slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		return { lsp_fallback = true }
	end,

	-- log_level = vim.log.levels.DEBUG,
})

require("fidget").setup({})
-- status bar for codeium
vim.api.nvim_call_function("codeium#GetStatusString", {})

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	sources = cmp.config.sources({
		{ name = "luasnip", max_item_count = 5 }, -- For luasnip users.
		{ name = "nvim_lsp", max_item_count = 5 },
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- Set colorscheme at the end to ensure transparency, after set line number colors
require("tokyonight").setup({
	style = "storm",
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
	hide_inactive_statusline = true,
})
vim.api.nvim_command("colorscheme tokyonight")
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#7E8082" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#ece17f" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#7E8082" })

-- Comments
require("Comment").setup()
-- Todo highlight
require("todo-comments").setup()
