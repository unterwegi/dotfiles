return {
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            -- configure default handlers
            handlers = {},
        },
        config = true,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "lewis6991/gitsigns.nvim",
            "nvim-neotest/nvim-nio",
            { "igorlfs/nvim-dap-view", opts = {} },
        },
        config = function()
            local dap, dv, gs = require("dap"), require("dap-view"), require("gitsigns")
            local telescope = require("telescope")
            local keymap = vim.keymap

            telescope.load_extension("dap")
            local ts_dap = telescope.extensions.dap

            -- I am too lazy to define my own highlights, so I "borrow" some existing ones
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition",
                { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped",
                { text = "", texthl = "DiagnosticHint", linehl = "DiagnosticVirtualTextHint", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected",
                { text = "", texthl = "DiagnosticVirtualTextError", linehl = "DiagnosticVirtualTextError", numhl = "" })

            keymap.set("n", "<Leader>dc", function()
                -- load a .vscode/launch.json beforehand to see if we have project specific debugger setups
                require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
                dap.continue()
            end, { desc = "Debug Continue" })
            keymap.set("n", "<Leader>dr", ts_dap.configurations, { desc = "Run Debug Config" })
            keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            keymap.set("n", "<Leader>dB", ts_dap.list_breakpoints, { desc = "List Breakpoints" })
            keymap.set("n", "<Leader>l", dap.step_over, { desc = "Debug Step Over" })
            keymap.set("n", "<Leader>j", dap.step_into, { desc = "Debug Step Into" })
            keymap.set("n", "<Leader>k", dap.step_out, { desc = "Debug Step Out" })
            keymap.set("n", "<Leader>de", dap.terminate, { desc = "Terminate Debugger" })
            keymap.set("n", "<Leader>dC", function()
                dap.clear_breakpoints()
                require("notify")("Breakpoints cleared", "warn")
            end, { desc = "Clear all Breakpoints" })
            keymap.set({ "n", "v" }, "<Leader>dw", function()
                dv.add_expr()
            end, { desc = "Watch Current Expression" })

            dap.listeners.before.attach["dap-view-config"] = function()
                gs.toggle_current_line_blame(false)
                dv.open()
            end
            dap.listeners.before.launch["dap-view-config"] = function()
                gs.toggle_current_line_blame(false)
                dv.open()
            end
            dap.listeners.before.event_terminated["dap-view-config"] = function()
                gs.toggle_current_line_blame(true)
                dv.close()
            end
            dap.listeners.before.event_exited["dap-view-config"] = function()
                gs.toggle_current_line_blame(true)
                dv.close()
            end
        end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            highlight_new_as_changed = true,
            only_first_definition = false,
            all_references = true,
        },
    },
}
