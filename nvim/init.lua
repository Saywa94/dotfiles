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

-- window boredrs
vim.o.winborder = "rounded"
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
	view = {
		side = "right",
		width = 40,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
	},
	renderer = {
		group_empty = true,
		highlight_diagnostics = true,
	},
	update_focused_file = {
		enable = true,
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

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "src/bundle" },
	},
})

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
		additional_vim_regex_highlighting = { "php" },
	},

	-- Disable for large files
	disable = function(_, buf)
		local max_filesize = 200 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return true
		end
	end,
})
vim.api.nvim_set_hl(0, "@lsp.mod.readonly.typescript", { link = "Constant" })
vim.api.nvim_set_hl(0, "@lsp.mod.readonly.javascript", { link = "Constant" })

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
		"ruff",
		"gopls",
	},
	handlers = {
		lsp_zero.default_setup,
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Show diagnostic on the same line
vim.diagnostic.config({
	virtual_text = true,
})

local slow_format_filetypes = {}
-- Formatter
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		php = { "pint" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		sql = { "sql_formatter" },
		python = { "ruff_fix", "ruff_format" },
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

-- Completly close nvim when nvimtree is still open
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
			and layout[3] == nil
		then
			vim.cmd("confirm quit")
		end
	end,
})

-- Trouble diagnostics
require("trouble").setup()

-- Css colorizer
require("colorizer").setup({
	"css",
	"scss",
	"html",
	"tsx",
}, { names = false })

-- Hardtime
require("hardtime").setup({
	disable_mouse = false,
})

-- Nvim notify
vim.notify = require("notify")
