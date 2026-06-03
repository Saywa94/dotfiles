return {
    -- Autocompletion Engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
                dependencies = { "rafamadriz/friendly-snippets" }
            },
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "luasnip",  max_item_count = 5 },
                    { name = "nvim_lsp", max_item_count = 5 },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end
    },

    -- LSP config
    {
        "neovim/nvim-lspconfig",
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "cssls", "eslint", "lua_ls", "phpactor", "pyright", "ruff", "gopls" },
            automatic_enable = true,
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },

    -- TypeScript Tools
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {}
    },

    -- Codeium AI
    {
        "Exafunction/windsurf.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            -- Manually call the correct setup module
            require("codeium").setup({
                enable_cmp_source = false,
                virtual_text = {
                    enabled = true,
                    key_bindings = {
                        accept_word = "<S-Right>",
                        next = "<S-Tab>",
                    }
                }
            })
        end,
    },
}
