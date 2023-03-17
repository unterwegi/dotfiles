return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                'bash',
                'comment',
                'dockerfile',
                'diff',
                'fish',
                'gitcommit',
                'gitignore',
                'git_rebase',
                'go',
                'html',
                'json',
                'jsonc',
                'lua',
                'make',
                'markdown',
                'markdown_inline',
                'python',
                'regex',
                'sql',
                'toml',
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
