return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make'
        },
    },
    opts = {
        defaults = {
            file_ignore_patterns = {
                "node_modules",
                "vendor",
                "target",
                "build",
                "tmp",
                "src/bundle",
            },
        }
    },
}
