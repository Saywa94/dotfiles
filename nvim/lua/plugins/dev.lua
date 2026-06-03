return {
    -- Modern Treesitter configuration
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- CRITICAL: Modern versions require configuring through .configs
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "markdown", "markdown_inline", "javascript", "typescript",
                    "python", "php", "go", "lua", "vim", "vimdoc", "query",
                    "bash", "comment", "dockerfile", "tsx"
                },
                sync_install = true,  -- Force synchronous compilation on startup
                auto_install = false, -- Turn off to stop looking for the missing CLI tool
                highlight = {
                    enable = true,    -- Ensure treesitter highlighting engine is explicitly on
                    additional_vim_regex_highlighting = false,
                },
            })
        end
    },

    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "<leader>gj", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "<leader>gk", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true })

                -- Actions
                map("n", "<leader>gp", gs.preview_hunk)
                map("n", "<leader>gsb", gs.stage_buffer)
                map("n", "<leader>gu", gs.undo_stage_hunk)
                map("n", "<leader>gd", gs.diffthis)
                map("n", "<leader>gb", function() gs.blame_line({ full = true }) end)
            end,
        }
    },

    -- Harpoon 2
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Conform Formatter
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                php = { "pint" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                sql = { "sql_formatter" },
                python = { "ruff_fix", "ruff_format" },
            },
            format_on_save = { timeout_ms = 200, lsp_fallback = true },
            format_after_save = { lsp_fallback = true }
        }
    },

    -- Trouble Diagnostics
    {
        "folke/trouble.nvim",
        opts = {
            auto_close = true,
            auto_preview = true,
            preview = {
                type = "main",
                scratch = true,
                border = "none",
            },
        }
    },

    -- Comments
    {
        "numToStr/Comment.nvim",
        opts = {}
    }
}
