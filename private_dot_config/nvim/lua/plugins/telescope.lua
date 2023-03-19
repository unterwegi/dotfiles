return {
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "natecraddock/telescope-zf-native.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            local telescope = require("telescope")

            telescope.load_extension("zf-native")
            telescope.load_extension("file_browser")
            telescope.load_extension("dap")
            telescope.load_extension("notify")

            telescope.setup {
                defaults = {
                    theme = "ivy",
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        no_ignore_parent = true,
                    }
                },
            }
        end
    },
}
