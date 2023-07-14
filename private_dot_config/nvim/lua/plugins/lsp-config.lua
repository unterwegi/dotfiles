return {
    -- LSP
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "b0o/schemastore.nvim",
            "ray-x/lsp_signature.nvim",
            "lewis6991/gitsigns.nvim",
            "williamboman/mason-lspconfig",
            "nvim-lua/plenary.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "smjonas/inc-rename.nvim",
        },
        config = function()
            -- Diagnostic looks
            vim.diagnostic.config {
                virtual_text = false,
                update_in_insert = true,
                float = {
                    source = "if_many"
                }
            }

            -- Configure inc-rename
            require("inc_rename").setup {
                input_buffer_type = "dressing",
            }

            -- Signcolumn symbols
            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- Show diagnostics on hover
            vim.o.updatetime = 150
            vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])

            local function get_client_capabilities()
                local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

                keymap.set("n", "rn", ":IncRename ", { unpack(opts), desc = "Do LSP rename action" })
                keymap.set("n", "gd", ts.lsp_definitions, { unpack(opts), desc = "Do LSP get definitions action" })
                keymap.set("n", "gD", vim.lsp.buf.declaration, { unpack(opts), desc = "Do LSP get declaration action" })
                keymap.set("n", "gh", fix_buf_hover, { unpack(opts), desc = "Do LSP hover action" })
                keymap.set("n", "gr", ts.lsp_references, { unpack(opts), desc = "Do LSP get references action" })
                keymap.set("n", "gi", ts.lsp_implementations,
                { unpack(opts), desc = "Do LSP get implementations action" })
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

            -- clangd
            -- manually need to set offsetEncoding to "utf-8"
            -- see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
            local clangd_capabilities = get_client_capabilities()
            clangd_capabilities.offsetEncoding = "utf-8"
            lspconfig.clangd.setup {
                capabilities = clangd_capabilities,
                on_attach = on_attach,
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
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        opts = function()
            local null_ls = require("null-ls")

            return {
                sources = {
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.shfmt.with {
                        extra_args = { "-i", "2", "-ci" }
                    },
                    null_ls.builtins.formatting.trim_newlines,
                    null_ls.builtins.formatting.trim_whitespace,
                    null_ls.builtins.formatting.clang_format.with {
                        extra_args = { "--style=file" }
                    },
                },
                diagnostics_format = "[#{c}] #{m} (#{s})",
            }
        end
    },
}
