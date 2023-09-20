return {
    "mfussenegger/nvim-dap",
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
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "lewis6991/gitsigns.nvim",
        },
        config = function()
            local dap, dapui, gs = require("dap"), require("dapui"), require("gitsigns")
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
            keymap.set({"n", "v"}, "<Leader>dw", function()
                dapui.elements.watches.add()
            end, { desc = "Watch Current Expression" })
            keymap.set({"n", "v"}, "<Leader>dd", dapui.eval, { desc = "Evaluate Current Expression" })

            dapui.setup({
                layouts = { {
                    -- deviation from default UI: no scopes window as this info is shown as virtual text
                    elements = { {
                        id = "breakpoints",
                        size = 0.15
                    }, {
                        id = "stacks",
                        size = 0.35
                    }, {
                        id = "watches",
                        size = 0.5
                    } },
                    position = "left",
                    size = 80
                }, {
                    elements = { {
                        id = "repl",
                        size = 0.5
                    }, {
                        id = "console",
                        size = 0.5
                    } },
                    position = "bottom",
                    size = 12
                } },
            })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                gs.toggle_current_line_blame()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                gs.toggle_current_line_blame()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                gs.toggle_current_line_blame()
                dapui.close()
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
