return {
    "mfussenegger/nvim-dap",
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            -- automatically set up DAP providers installed via mason
            automatic_setup = true,
            handlers = {},
        },
        config = true,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            local keymap = vim.keymap
            local ts_dap = require("telescope").extensions.dap

            -- I'm too lazy to define my own highlights, so I "borrow" some existing ones
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticHint", linehl = "DiagnosticVirtualTextHint", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticVirtualTextError", linehl = "DiagnosticVirtualTextError", numhl = "" })

            keymap.set("n", "<Leader>dl", require("dap.ui.widgets").hover, { desc = "Show Debug Hover" })
            keymap.set("n", "<Leader>dc", dap.continue, { desc = "Debug Continue" })
            keymap.set("n", "<Leader>dr", ts_dap.configurations, { desc = "Run Debug Config" })
            keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            keymap.set("n", "<Leader>dB", ts_dap.list_breakpoints, { desc = "List Breakpoints" })
            keymap.set("n", "<Leader>dn", dap.step_over, { desc = "Debug Step Over" })
            keymap.set("n", "<Leader>di", dap.step_into, { desc = "Debug Step Into" })
            keymap.set("n", "<Leader>do", dap.step_out, { desc = "Debug Step Out" })
            keymap.set("n", "<Leader>de", dap.terminate, { desc = "Terminat Debugger" })
            keymap.set("n", "<Leader>dC", function()
                dap.clear_breakpoints()
                require("notify")("Breakpoints cleared", "warn")
            end, { desc = "Clear all Breakpoints" })

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },
}
