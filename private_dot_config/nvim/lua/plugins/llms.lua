return {
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
