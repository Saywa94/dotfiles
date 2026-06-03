return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {

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
    }
}
