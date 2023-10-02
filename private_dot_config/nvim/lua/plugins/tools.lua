return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },
    {
        "williamboman/mason-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = true,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig",
        },
        build = ":MasonToolsUpdate",
        config = function()
            require("mason-tool-installer").setup {
                ensure_installed = {
                    -- formatters (called through efm)
                    "gofumpt",
                    "prettierd",
                    "shfmt",

                    -- linters
                    "golangci-lint",
                    "markdownlint",
                    "shellcheck", -- implicitly used by bash-language-server
                    "vale",
                    "yamllint",

                    -- file specific language servers
                    "ansible-language-server",
                    "bash-language-server",
                    "dockerfile-language-server",
                    "gopls",
                    "lua-language-server",
                    "json-lsp",
                    "yaml-language-server",

                    -- main language servers
                    "efm",
                    "python-lsp-server",
                    "clangd",

                    -- debug servers
                    "debugpy",
                    "cpptools",
                },
                auto_update = true,
                run_on_start = false,
            }

            vim.api.nvim_create_autocmd("User", {
                pattern = "MasonToolsUpdateCompleted",
                callback = function()
                    -- install/update python-lsp-server plugins
                    local pylsp_packages = { "python-lsp-black", "pyls-isort", "pylsp-mypy" }
                    local pylsp_path = require("mason-core.path").package_prefix("python-lsp-server")
                    local pylsp_pip = pylsp_path .. "/venv/bin/python -m pip"

                    local function post_mason_setup()
                        -- Install python-lsp plugins
                        for _, package in ipairs(pylsp_packages) do
                            vim.cmd(":! " .. pylsp_pip .. " install -U --disable-pip-version-check " .. package)
                        end

                        -- Ensure vale is correctly set up
                        vim.cmd(":!vale sync")
                    end

                    local is_headless = #vim.api.nvim_list_uis() == 0
                    if is_headless then
                        -- we are running synchronous inside headless mode, so no async please
                        post_mason_setup()
                    else
                        -- we are running interactively so run in background
                        vim.schedule(function()
                            post_mason_setup()
                        end)
                    end
                end,
            })
        end
    },
}
