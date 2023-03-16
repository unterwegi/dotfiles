return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                'bash',
                'comment',
                'dockerfile',
                'fish',
                'go',
                'html',
                'json',
                'jsonc',
                'lua',
                'markdown',
                'markdown_inline',
                'python',
                'regex',
                'typescript',
                'vim',
                'yaml'
            },
            sync_install = true,
            highlight = {
                enable = true
            },
            autotag = {
                enable = true,
            }
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
