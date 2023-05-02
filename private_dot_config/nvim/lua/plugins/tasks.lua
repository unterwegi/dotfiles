return {
    {
        "Shatur/neovim-tasks",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "nvim-lua/plenary.nvim",
        },
        opts = {
            default_params = {
                cmake = {
                    dap_name = "cppdbg",
                    args = {
                        configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', }
                    }
                }
            },
            -- nvim-dap-ui handles debugging startup
            dap_open_command = false,
        },
    },
}
