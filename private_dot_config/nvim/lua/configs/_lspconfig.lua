-- Diagnostic looks
vim.diagnostic.config {
    virtual_text = false,
    update_in_insert = true,
    float = {
        source = "if_many"
    }
}

-- Signcolumn symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Show diagnostics on hover
vim.o.updatetime = 150
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])

-- LSP Server Setup Goes Below
require("mason").setup()
require("mason-lspconfig").setup {
    automatic_installation = true,
}
require("mason-tool-installer").setup {
    ensure_installed = {
        -- formatting
        "prettierd",
        "shfmt",

        -- diagnostics
        "ansible-lint",
        "markdownlint",
        "json-lsp",
        "shellcheck",
        "write-good",
        "yamllint",

        -- languages
        "python-lsp-server",
    },
    auto_update = true,
    run_on_start = false
}

vim.api.nvim_create_autocmd("User", {
    pattern = "MasonToolsUpdateCompleted",
    callback = function()
        -- install python-lsp-server plugins for black, isort and mypy
        local is_headless = #vim.api.nvim_list_uis() == 0
        local pylsp_packages = "python-lsp-black pyls-isort pylsp-mypy"
        if is_headless then
            -- we are running synchronous inside headless mode, so no async please
            local pylsp_path = require("mason-core.path").package_prefix("python-lsp-server")
            local pylsp_pip = pylsp_path .. "/venv/bin/pip"
            vim.cmd(":! " .. pylsp_pip .. " install -U --disable-pip-version-check " .. pylsp_packages)
        else
            -- we are running interactively
            -- use normal mason PylspInstall command that does the installation asynchronously
            vim.schedule(function()
                vim.cmd(":PylspInstall " .. pylsp_packages)
            end)
        end
    end,
})

local function get_client_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }

    return capabilities
end

-- Workaround for hover not working when there is diagnostic float
-- https://www.reddit.com/r/neovim/comments/pg1o6k/neovim_lsp_hover_window_is_hidden_behind_line
local function fix_buf_hover()
  vim.o.eventignore = 'CursorHold'
  vim.lsp.buf.hover()
  vim.cmd([[autocmd CursorMoved <buffer> ++once set eventignore=""]])
end

local lspconfig = require("lspconfig")
local capabilities = get_client_capabilities()
local on_attach = function(_, bufnr)
    require "lsp_signature".on_attach()
    local keymap = vim.keymap
    local opts = { buffer = bufnr }
    local ts = require "telescope.builtin"

    keymap.set("n", "rn", vim.lsp.buf.rename, { unpack(opts), desc = "Do LSP rename action" })
    keymap.set("n", "gd", ts.lsp_definitions, { unpack(opts), desc = "Do LSP get definitions action" })
    keymap.set("n", "gD", vim.lsp.buf.declaration, { unpack(opts), desc = "Do LSP get declaration action" })
    keymap.set("n", "gh", fix_buf_hover, { unpack(opts), desc = "Do LSP hover action" })
    keymap.set("n", "gr", ts.lsp_references, { unpack(opts), desc = "Do LSP get references action" })
    keymap.set("n", "gi", ts.lsp_implementations, { unpack(opts), desc = "Do LSP get implementations action" })
end

-- ansiblels
lspconfig.ansiblels.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- bashls
lspconfig.bashls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- dockerls
lspconfig.dockerls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- jsonls
lspconfig.jsonls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
        }
    }
}

-- python
lspconfig.pylsp.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pylsp = {
            configurationSources = { "flake8" },
            plugins = {
                black = {
                    enabled = true,
                    line_length = 120
                },
                flake8 = {
                    enabled = true,
                    maxLineLength = 120
                },
                autopep8 = {
                    enabled = false,
                },
                mccabe = {
                    enabled = false
                },
                pycodestyle = {
                    enabled = false
                },
                pyflakes = {
                    enabled = false
                },
                yapf = {
                    enabled = false
                },
            }
        }
    }
}

-- lua_ls
lspconfig.lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                preloadFileSize = 200,
            },
            telemetry = {
                enable = false,
            },
        }
    }
}

-- yamlls
lspconfig.yamlls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        yaml = {
            customTags = {
                "!include_dir_list",
                "!include_dir_named",
                "!include_dir_merge_list",
                "!include_dir_merge_named",
                "!secret",
                "!env_var",
            },
            schemas = {
                kubernetes = {
                    "01-namespace.yaml",
                    "deployment.yaml",
                    "daemonset.yaml",
                    "statefulset.yaml",
                    "service.yaml",
                    "pv.yaml",
                    "pvc.yaml",
                    "configmap.yaml",
                    "secret.yaml",
                    "rbac.yaml",
                    "crd.yaml",
                    "storageclass.yaml",
                    "cronjob.yaml"
                },
                ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = {
                    "docker-compose.yml",
                    "docker-compose.yaml"
                },
                ["https://json.schemastore.org/github-workflow"] = {
                    ".github/workflows/**.yml",
                    ".github/workflows/**.yaml"
                },
                ["https://json.schemastore.org/github-actions"] = {
                    "action.yml",
                    "action.yaml"
                },
                ["https://json.schemastore.org/gitlab-ci"] = ".gitlab-ci.yml",
                ["https://json.schemastore.org/kustomization"] = {
                    "kustomization.yml",
                    "kustomization.yaml"
                },
                ["https://json.schemastore.org/pre-commit-config"] = {
                    ".pre-commit-config.yml",
                    ".pre-commit-config.yaml",
                },
                ["https://raw.githubusercontent.com/JJGadgets/flux2-schemas/main/helmrelease-helm-v2beta1.json"] = {
                    "helmrelease.yaml",
                    "helm-release.yaml"
                }
            }
        }
    }
}

-- null-ls
local null_ls = require("null-ls")

null_ls.setup {
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.shfmt.with {
            extra_args = { "-i", "2", "-ci" }
        },
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace,
        null_ls.builtins.diagnostics.ansiblelint.with {
            filetypes = { "yaml.ansible" }
        },
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.code_actions.shellcheck,
    },
    diagnostics_format = "[#{c}] #{m} (#{s})"
}
