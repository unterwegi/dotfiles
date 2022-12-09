local packer = require("packer")

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end
    }
})

packer.startup({
    function(use)
        use "wbthomason/packer.nvim"

        -- Look and Feel
        use "EdenEast/nightfox.nvim"
        use "stevearc/dressing.nvim"
        use {
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = function()
                require("configs._lualine")
            end
        }
        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("indent_blankline").setup()
            end
        }

        -- Telescope
        use "natecraddock/telescope-zf-native.nvim"
        use {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("telescope").load_extension("zf-native")
            end
        }

        -- LSP
        use {
            "neovim/nvim-lspconfig",
            requires = {
                "b0o/schemastore.nvim",
                "ray-x/lsp_signature.nvim",
                "lewis6991/gitsigns.nvim",
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig",
                "jose-elias-alvarez/null-ls.nvim",
                "nvim-lua/plenary.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
            },
            config = function()
                require("configs._lspconfig")
            end
        }
        use {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            requires = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig",
            },
            run = ":MasonToolsUpdate",
        }
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("configs._treesitter")
            end
        }
        use {
            "folke/trouble.nvim",
            opt = true,
            event = "BufReadPost",
            config = function()
                require("trouble").setup()
            end
        }

        -- Lifehacks
        use {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("configs._gitsigns")
            end
        }
        use {
            "max397574/better-escape.nvim",
            config = function()
                require("better_escape").setup { mapping = { "jj" } }
            end
        }
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }
        use {
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup()
            end
        }
        use {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup()
            end
        }
    end
})

-- Call PackerSync whenever plugins.lua has been written
vim.cmd [[
  augroup PackerSync
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]]
