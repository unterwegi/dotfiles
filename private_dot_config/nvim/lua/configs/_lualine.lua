require("lualine").setup {
    options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "nightfox",
        section_separators = { left = "", right = ""},
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
                    modified = " ",
                    readonly = " ",
                    unnamed = " ",
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
                mode=4,
                buffers_color = {
                    active = "lualine_b_normal",
                    inactive = "lualine_c_inactive",
                },
            }
        },
    },
}
