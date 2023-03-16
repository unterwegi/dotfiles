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
                    -- null-ls formatting
                    "prettierd",
                    "shfmt",

                    -- null-ls linters
                    "ansible-lint",
                    "markdownlint",
                    "shellcheck",
                    "write-good",
                    "yamllint",

                    -- file specific language servers
                    "ansible-language-server",
                    "bash-language-server",
                    "dockerfile-language-server",
                    "lua-language-server",
                    "json-lsp",
                    "yaml-language-server",

                    -- main language servers
                    "python-lsp-server",
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
                    local pylsp_pip = pylsp_path .. "/venv/bin/pip"

                    local function install_pylsp_packages()
                        for _, package in ipairs(pylsp_packages) do
                            vim.cmd(":! " .. pylsp_pip .. " install -U --disable-pip-version-check " .. package)
                        end
                    end

                    local is_headless = #vim.api.nvim_list_uis() == 0
                    if is_headless then
                        -- we are running synchronous inside headless mode, so no async please
                        install_pylsp_packages()
                    else
                        -- we are running interactively so run in background
                        vim.schedule(function()
                            install_pylsp_packages()
                        end)
                    end
                end,
            })
        end
    },
}
