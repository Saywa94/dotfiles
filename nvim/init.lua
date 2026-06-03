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
require("config.lazy")
require("keys") -- Keymaps

vim.api.nvim_set_hl(0, "@lsp.mod.readonly.typescript", { link = "Constant" })
vim.api.nvim_set_hl(0, "@lsp.mod.readonly.javascript", { link = "Constant" })


vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

-- Bugfix for eslint: root_dir gave a table instead of string
vim.lsp.config("eslint", {
    root_dir = require("lspconfig.util").root_pattern(".eslintrc", ".eslintrc.js", "package.json"),
})

-- Show diagnostic on the same line
vim.diagnostic.config({
    virtual_text = true,
})

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

-- Force Treesitter Highlighting to turn on for every file
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = "*",
    callback = function()
        -- Safely try starting treesitter; ignore if the filetype lacks a compiled parser
        pcall(vim.treesitter.start)
    end,
})
