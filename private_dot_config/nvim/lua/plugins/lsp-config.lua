return {
    -- LSP
    {
        "neovim/nvim-lspconfig",
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
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                        [vim.diagnostic.severity.INFO] = " ",
                    }
                },
            })

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

            local capabilities = get_client_capabilities()
            local on_attach = function(_, bufnr)
                require "lsp_signature".on_attach()
                local keymap = vim.keymap
                local opts = { buffer = bufnr }
                local ts = require "telescope.builtin"

                keymap.set("n", "rn", ":IncRename ", { unpack(opts), desc = "Do LSP rename action" })
                keymap.set("n", "ra", vim.lsp.buf.code_action, { unpack(opts), desc = "Trigger LSP code action" })
                keymap.set("n", "gd", ts.lsp_definitions, { unpack(opts), desc = "Do LSP get definitions action" })
                keymap.set("n", "gD", vim.lsp.buf.declaration, { unpack(opts), desc = "Do LSP get declaration action" })
                keymap.set("n", "gh", fix_buf_hover, { unpack(opts), desc = "Do LSP hover action" })
                keymap.set("n", "gr", ts.lsp_references, { unpack(opts), desc = "Do LSP get references action" })
                keymap.set("n", "gi", ts.lsp_implementations,
                    { unpack(opts), desc = "Do LSP get implementations action" })
            end

            -- ansiblels
            vim.lsp.config.ansiblels = {
                capabilities = capabilities,
                on_attach = on_attach,
            }
            vim.lsp.enable("ansiblels")

            -- bashls
            vim.lsp.config.bashls = {
                capabilities = capabilities,
                on_attach = on_attach,
            }
            vim.lsp.enable("bashls")

            -- dockerls
            vim.lsp.config.dockerls = {
                capabilities = capabilities,
                on_attach = on_attach,
            }
            vim.lsp.enable("dockerls")

            -- gopls
            vim.lsp.config.gopls = {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    gopls = {
                        gofumpt = true
                    }
                }
            }
            vim.lsp.enable("gopls")

            -- protols
            vim.lsp.config.protols = {
                capabilities = capabilities,
                on_attach = on_attach,
            }
            vim.lsp.enable("protols")

            -- jsonls
            vim.lsp.config.jsonls = {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    }
                }
            }
            vim.lsp.enable("jsonls")

            -- clangd
            -- manually need to set offsetEncoding to "utf-8"
            -- see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
            local clangd_capabilities = get_client_capabilities()
            clangd_capabilities.offsetEncoding = "utf-8"
            vim.lsp.config.clangd = {
                capabilities = clangd_capabilities,
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "h", "hpp" },
                on_attach = on_attach,
            }
            vim.lsp.enable("clangd")

            -- efm (general purpose LSP to integrate some formatters)
            local prettierd = { formatCommand = 'prettierd "${INPUT}"', formatStdin = true }
            local shfmt = { formatCommand = "shfmt -i 2 -ci", formatStdin = true }
            -- TODO does a generic post save autocmd make more sense here for trailing whitespace removal?
            local trailing_whitespace = { formatCommand = "sed -E -e 's/[[:space:]]*$//'", formatStdin = true }
            vim.lsp.config.efm = {
                init_options = { documentFormatting = true },
                filetypes = { "cpp", "html", "json", "less", "lua", "markdown", "python", "sh", "text", "yaml" },
                settings = {
                    languages = {
                        html = { prettierd },
                        json = { prettierd },
                        less = { prettierd },
                        markdown = { prettierd },
                        sh = { shfmt },
                        yaml = { prettierd },
                        ["="] = { trailing_whitespace },
                    }
                }
            }
            vim.lsp.enable("efm")

            -- python
            vim.lsp.config.pylsp = {
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
                            pylsp_mypy = {
                                overrides = { "--ignore-missing-imports", true },
                            },
                            yapf = {
                                enabled = false
                            },
                        }
                    }
                }
            }
            vim.lsp.enable("pylsp")

            -- lua_ls
            vim.lsp.config.lua_ls = {
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
            vim.lsp.enable("lua_ls")

            -- yamlls
            vim.lsp.config.yamlls = {
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
                            "!reference sequence",
                        },
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = require('schemastore').yaml.schemas({
                            extra = {
                                {
                                    name = "kubernetes.yaml",
                                    description = "Kubernetes resource schema specs",
                                    fileMatch = {
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
                                    url =
                                    "https://github.com/yannh/kubernetes-json-schema/raw/refs/heads/master/master-standalone-strict/all.json",
                                },
                            },
                        }),
                    }
                }
            }
            vim.lsp.enable("yamlls")
        end
    },
}
