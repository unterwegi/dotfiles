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
                lualine_x = { "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" }
            },
            tabline = {
                lualine_b = {
                    {
                        "buffers",
                        mode = 4,
                        section_separators = { left = "", right = "" },
                        buffers_color = {
                            active = "lualine_b_normal",
                            inactive = "lualine_c_inactive",
                        },
                    }
                },
            },
        },
    },
    {
        "folke/trouble.nvim",
        event = "BufReadPost",
        opts = {
            height = 20,
        }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add          = { hl = "GitSignsAdd", text = "󰐕", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change       = {
                    hl = "GitSignsChange",
                    text = "󰐕",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn"
                },
                delete       = {
                    hl = "GitSignsDelete",
                    text = "_",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn"
                },
                topdelete    = {
                    hl = "GitSignsDelete",
                    text = "‾",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn"
                },
                changedelete = {
                    hl = "GitSignsChange",
                    text = "~",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn"
                },
            },
            signcolumn = true,
            numhl = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
                ignore_whitespace = false
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                -- Navigation
                map("n", "<C-n>", function()
                    if vim.wo.diff then return "<C-n>" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "<C-p>", function()
                    if vim.wo.diff then return "<C-p>" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true })

                -- Actions
                map({ "n", "v" }, "<leader>ga", ":Gitsigns stage_hunk<CR>", { desc = "Git stage hunk" })
                map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Git reset hunk" })
                map("n", "<leader>gaa", gs.stage_buffer, { desc = "Git stage buffer" })
                map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo git stage" })
                map("n", "<leader>gra", gs.reset_buffer, { desc = "Reset git actions in buffer" })
                map("n", "<leader>gh", gs.preview_hunk, { desc = "Preview git actions in hunk" })
                map("n", "<leader>gd", gs.diffthis, { desc = "Git diff this hunk" })
                map("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Git diff this commit" })
            end
        }
    },
    {
        "max397574/better-escape.nvim",
        opts = { mapping = { "kj" } }
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
        config = function()
            local notify = require("notify")
            notify.setup({
                timeout = 4000,
                fps = 60,
                top_down = false,
            })
            vim.notify = notify
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
}
