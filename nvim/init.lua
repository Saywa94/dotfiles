--[[ init.lua ]]

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
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps
require('plug')      -- Plugins

-- PLUGINS: Add this section
require('nvim-tree').setup {
    git = {
        ignore = false
    }
}
require('lualine').setup {
    options = {
        theme = 'dracula-nvim'
    },
    sections = {
        lualine_c = {
            {'filename'},
            { 'codeium#GetStatusString', color = { fg = '#FFEB3B' } }
        }
    }
}
require('nvim-autopairs').setup{}

require'nvim-treesitter.configs'.setup {
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
        "tsx"
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
}

require('gitsigns').setup{
    on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '<leader>gj', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '<leader>gk', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>gp', gs.preview_hunk)
    map('n', '<leader>hs', gs.stage_buffer)
    map('n', '<leader>gu', gs.undo_stage_hunk)
    map('n', '<leader>gd', gs.diffthis)
    --map('n', '<leader>gD', function() gs.diffthis('~') end)
    map('n', '<leader>gb', function() gs.blame_line{full=true} end)

  end
}
require('tokyonight').setup{
    transparent = true
}

local harpoon = require('harpoon')
harpoon:setup({})

local lsp_zero = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'tsserver', 'intelephense', 'eslint', 'pyright', 'cssls'},
    handlers = {
        lsp_zero.default_setup
    },
})

require('lspconfig').intelephense.setup({
    settings = {
        intelephense = {
            files = {
                maxSize = 5000000,
                exclude = {
                    'node_modules',
                    'vendor',
                }
            }
        }
    }
})

-- status bar for codeium
vim.api.nvim_call_function("codeium#GetStatusString", {})

local cmp = require('cmp')
cmp.setup({
    completion = {
        autocomplete = false
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    sources = cmp.config.sources({
        { name = 'luasnip', max_item_count = 5 }, -- For luasnip users.
        { name = 'nvim_lsp', max_item_count = 5 },
        { name = 'buffer' },
        { name = 'path' },
    })

})

-- Set colorscheme at the end to ensure transparency, after set line number colors
vim.api.nvim_command('colorscheme tokyonight')
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#7E8082' })
vim.api.nvim_set_hl(0, 'LineNr', { fg='#ece17f' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#7E8082' })

-- Ale Linter config
vim.g.ale_echo_msg_error_str = ''
vim.g.ale_echo_msg_warning_str = ''
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
vim.g.ale_linters_explicit = 1
vim.g.on_text_changed = 'never'
vim.g.on_insert_leave = 0
vim.g.on_insert_enter = 0
vim.g.ale_completion_enabled = 0
vim.g.ale_completion_autoimport = 0
vim.g.ale_go_to_definition = 0
vim.g.ale_find_references = 0
vim.g.ale_hover = 0
vim.g.ale_hover_cursor = 0
vim.g.ale_fix_on_save = 1
vim.g.ale_lint_on_save = 1
vim.g.linter_aliases = { ['tsx'] =  'typescript' }
vim.g.ale_fixers = {
    [ 'javascript' ] = 'prettier',
    [ 'typescript' ] = 'prettier',
    [ 'typescriptreact' ] = 'prettier',
    [ 'tsx' ] = 'prettier',
    [ 'css' ] = 'prettier',
}
vim.g.ale_linters = {
    [ 'javascript' ] =  'eslint',
    [ 'typescript' ] =  'eslint',
    [ 'typescriptreact' ] = 'eslint',
    [ 'tsx' ] =  'eslint',
}
