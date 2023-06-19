return {
    {
        "ggandor/flit.nvim",
        dependencies = {
            {
                "ggandor/leap.nvim",
                config = function()
                    require("leap").set_default_keymaps()
                end
            },
        },
        config = true,
    }
}
