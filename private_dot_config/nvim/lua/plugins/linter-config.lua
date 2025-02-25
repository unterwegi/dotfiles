return {
    {
        "mfussenegger/nvim-lint",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                markdown = { "markdownlint", "vale" },
                rst = { "vale", },
                text = { "vale", },
                yaml = { "yamllint", },
                go = { "golangcilint", },
                proto = { "buf_lint", },
            }

            local markdownlint = lint.linters.markdownlint
            markdownlint.args = {
                "--stdin",
            }
            markdownlint.stdin = true

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end
    },
}
