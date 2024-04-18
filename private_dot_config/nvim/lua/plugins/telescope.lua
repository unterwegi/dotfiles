return {
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "natecraddock/telescope-zf-native.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            local telescope = require("telescope")

            telescope.load_extension("zf-native")
            telescope.load_extension("file_browser")

            telescope.setup {
                defaults = {
                    theme = "ivy",
                    file_ignore_patterns = { "^%.git/", "%.o$", "%.gcno$", "%.gcda$", "^%.cache/clangd", "%.pyc$" }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        no_ignore_parent = true,
                    },
                    live_grep = {
                        additional_args = {
                            "-uu"
                        },
                    },
                },
            }
        end
    },
}
