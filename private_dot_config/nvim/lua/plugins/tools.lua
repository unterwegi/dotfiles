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
                    "buf",

                    -- file specific language servers
                    "ansible-language-server",
                    "bash-language-server",
                    "dockerfile-language-server",
                    "gopls",
                    "lua-language-server",
                    "json-lsp",
                    "yaml-language-server",
                    "protols",

                    -- main language servers
                    "efm",
                    "ty",
                    "clangd",

                    -- debug servers
                    "debugpy",
                    "cpptools",
                    "delve",
                },
                auto_update = true,
                run_on_start = false,
            }
        end
    },
}
