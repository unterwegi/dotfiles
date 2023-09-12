return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "sindrets/diffview.nvim",
            "ibhagwan/fzf-lua",
        },
        config = true
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signcolumn = true,
            numhl = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
                ignore_whitespace = false
            },
        }
    },
}
