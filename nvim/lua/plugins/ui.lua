return {
    -- Themes
    { "Mofiqul/dracula.nvim" },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
                hide_inactive_statusline = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
            })

            vim.cmd("colorscheme tokyonight")

            -- Custom Line Number Highlights
            vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#7E8082" })
            vim.api.nvim_set_hl(0, "LineNr", { fg = "#ece17f" })
            vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#7E8082" })
        end
    },

    -- Simple plugins
    { "mhinz/vim-startify" },         -- start screen
    { "DanilaMihailov/beacon.nvim" }, -- cursor jump
    { "folke/todo-comments.nvim",  dependencies = { "nvim-lua/plenary.nvim" },            opts = {} },
    { "rcarriga/nvim-notify",      config = function() vim.notify = require("notify") end },

    -- Hardtime
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = { disable_mouse = false }
    },

    -- CSS Colorizer
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                "css", "scss", "html", "tsx"
            }, { names = false })
        end
    },

    -- Lualine status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "dracula-nvim",
                refresh = {
                    statusline = 200,
                },
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
                    {
                        function()
                            return require("codeium.virtual_text").status_string()
                        end,
                        color = { fg = "#FFEB3B" }
                    },
                },
            },
        },
    },

}
