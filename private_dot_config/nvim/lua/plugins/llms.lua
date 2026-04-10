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
                    inline = {
                        adapter = "copilot",
                    },
                    chat = {
                        adapter = "opencode",
                        opts = {
                            completion_provider = "cmp",
                        }
                    },
                    cli = {
                        agent = "opencode",
                        agents = {
                            opencode = {
                                cmd = "opencode",
                                args = {},
                                description = "OpenCode CLI",
                                provider = "terminal",
                            },
                        },
                        opts = {
                            auto_insert = true,
                        }
                    },
                },
            })
            vim.g.copilot_enabled = false
        end,
    },
}
