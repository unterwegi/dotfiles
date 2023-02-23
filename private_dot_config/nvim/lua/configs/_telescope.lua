local telescope = require("telescope")

telescope.load_extension("zf-native")
telescope.load_extension("file_browser")

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
