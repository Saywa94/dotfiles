--[[ keys.lua]]
local map = vim.api.nvim_set_keymap

-- Save file
map("n", "<C-s>", ":w<cr>", {})
-- Copy current file path to system clipboard
map("n", "<leader>cp", ":let @+ = expand('%')<cr>", { desc = "Copy current relative file path" })

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

-- remove highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

--- Telescope fuzzy finder
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>pp", builtin.resume, { desc = "Resume telescope search" })
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
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sf", function()
    builtin.lsp_document_symbols({ symbols = { "class", "function", "method" } })
end, { desc = "[S]earch [F]unctions" })

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
    harpoon:list():add()
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

-- Global LSP Attach mappings (Put this in keys.lua)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local opts = { buffer = event.buf, silent = true }

        -- Your custom overrides
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction" })

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

        -- Your beloved CursorHold element highlighting!
        if client and client.server_capabilities.documentHighlightProvider then
            local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = highlight_group,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = highlight_group,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

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
vim.keymap.set(
    "n",
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    { desc = "Toggle Trouble workspace diagnostics" }
)
vim.keymap.set(
    "n",
    "<leader>xd",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "Toggle Document Diagnostics" }
)
vim.keymap.set(
    "n",
    "<leader>xr",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "Trouble LSP Definitions / references" }
)
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Toggle Quickfix" })
