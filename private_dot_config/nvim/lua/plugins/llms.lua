return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
            preview = {
                filetypes = { "markdown", "codecompanion" },
                ignore_buftypes = {},
            },
        },
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "github/copilot.vim",
        },
        config = function()
            require("codecompanion").setup({
                interactions = {
                    chat = {
                        adapter = "opencode",
                    },
                },
            })
            vim.g.copilot_enabled = false
        end,
    },
}
