--[[ keys.lua]]
local map = vim.api.nvim_set_keymap

-- Save file
map("n", "<C-s>", ":w<cr>", {})

-- use U for redo
map("n", "U", "<C-r>", {})

-- Select all
map("n", "<C-a>", "ggVG", {})

-- Insert empty line without entering insert mode
map("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', {})
map("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', {})

-- Jump to previous instance of text, oposite of '*'
map("n", "µ", "#", {})

-- Toggle nvim-tree
map("n", "<leader>n", [[:NvimTreeToggle<cr>]], {})

--- Change windows
map("n", "<leader>h", "<C-w>h", {})
map("n", "<leader>l", "<C-w>l", {})
map("n", "<leader>k", "<C-w>k", {})
map("n", "<leader>j", "<C-w>j", {})

--- Telescope fuzzy finder
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>gt", builtin.git_status, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>pws", function()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end)
vim.keymap.set("n", "<leader>pWs", function()
	local word = vim.fn.expand("<cWORD>")
	builtin.grep_string({ search = word })
end)
vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})

--- Pages navigation
map("n", "<leader>bb", ":bprev<cr>", {})
map("n", "<leader>bn", ":bnext<cr>", {})

--- Theprimgean shortucts
map("v", "<A-j>", ":m '>+1<CR>gv=gv", {})
map("v", "<A-k>", ":m '<-2<CR>gv=gv", {})

map("n", "<C-d>", "<C-d>zz", {})
map("n", "<C-u>", "<C-u>zz", {})

--- Yank to global clipboard
map("n", "<leader>y", [["+y]], {})
map("v", "<leader>y", [["+y]], {})
map("n", "<leader>Y", [["+Y]], {})

------------------ Harpoon Shortcuts ---------------
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>e", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- append current buffer to harpoon
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():append()
end)
vim.keymap.set("n", "<leader>r", function()
	harpoon:list():remove()
end)
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-h>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<C-l>", function()
	harpoon:list():next()
end)

vim.keymap.set("n", "<leader>&", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>é", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", '<leader>"', function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>'", function()
	harpoon:list():select(4)
end)

vim.keymap.set("n", "<leader>r&", function()
	harpoon:list():removeAt(1)
end)
vim.keymap.set("n", "<leader>ré", function()
	harpoon:list():removeAt(2)
end)
vim.keymap.set("n", '<leader>r"', function()
	harpoon:list():removeAt(3)
end)
vim.keymap.set("n", "<leader>r'", function()
	harpoon:list():removeAt(4)
end)

-- Telescope integration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

vim.keymap.set("n", "<leader>pp", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

-- LSP keybindings
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(_, bufnr)
	require("luasnip.loaders.from_vscode").lazy_load()
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })
end)

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		-- Select next/previous item
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		-- `Enter` key to confirm completion
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		-- Ctrl+Space to trigger completion menu
		["<C-c>"] = cmp.mapping.complete(),

		-- Scroll up and down in the completion documentation
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
})

-- [[ Trouble diagnostics ]]
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
