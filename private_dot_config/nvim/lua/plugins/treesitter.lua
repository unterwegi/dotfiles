return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                'bash',
                'comment',
                'cmake',
                'cpp',
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
                'ninja',
                'puppet',
                'python',
                'regex',
                'sql',
                'toml',
                'typescript',
                'vim',
                'vimdoc',
                'yaml'
            })

            -- Enable treesitter for all file types that have a parser installed
            local parsersInstalled = require("nvim-treesitter").get_installed('parsers')
            for _, parser in pairs(parsersInstalled) do
                local filetypes = vim.treesitter.language.get_filetypes(parser)
                vim.api.nvim_create_autocmd({ "FileType" }, {
                    pattern = filetypes,
                    callback = function()
                        vim.treesitter.start()
                    end,
                })
            end
        end,
    },
}
