return {
    -- Look and Feel
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nightfox").setup({
                options = {
                    styles = {
                        comments = "italic",
                        keywords = "bold",
                        types = "italic,bold",
                    }
                }
            })

            vim.cmd([[colorscheme nightfox]])
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        opts = {
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = "nightfox",
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    {
                        "diff",
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                    },
                    {
                        "diagnostics",
                        sources = {
                            "nvim_diagnostic"
                        }
                    },
                    {
                        "filename",
                        path = 1,
                        shorting_target = 30,
                        symbols = {
                            modified = " 󰎜",
                            readonly = " 󰈡",
                            unnamed = " 󰎞",
                        }
                    }
                },
                lualine_x = {
                    { "filetype" },
                    {
                        function()
                            local status = require("ollama").status()

                            if status == "IDLE" then
                                return "󱙺" -- nf-md-robot-outline
                            elseif status == "WORKING" then
                                return "󰚩 " .. status -- nf-md-robot
                            end
                        end,
                        cond = function()
                            return package.loaded["ollama"] and require("ollama").status() ~= nil
                        end,
                    },
                },
                lualine_y = { "progress" },
                lualine_z = { "location" }
            },
        },
    },
    {
        "folke/trouble.nvim",
        config = true,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
    {
        "max397574/better-escape.nvim",
        config = true,
    },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    {
        "kylechui/nvim-surround",
        config = true,
    },
    {
        "declancm/maximize.nvim",
        config = true,
    },
    {
        "rcarriga/nvim-notify",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local notify = require("notify")
            local telescope = require("telescope")

            notify.setup({
                timeout = 4000,
                fps = 60,
                top_down = false,
            })
            vim.notify = notify
            telescope.load_extension("notify")
        end
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end,
    },
    {
        "stevearc/dressing.nvim",
        opts = {
            input = {
                override = function(conf)
                    conf.col = -1
                    conf.row = 0
                    return conf
                end,
            },
        }
    },
    "lukas-reineke/indent-blankline.nvim",
    "davidgranstrom/nvim-markdown-preview",
}
