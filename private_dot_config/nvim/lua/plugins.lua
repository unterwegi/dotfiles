local fn = vim.fn
local cmd = vim.cmd

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  _G.packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

local packer = require("packer")

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end
  },
  profile = {
    enable = true,
    threshold = 1,
  }
})

packer.startup({
    function(use)
        use "wbthomason/packer.nvim"

        -- Theme: colour scheme
        use "EdenEast/nightfox.nvim"
        use {
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = function()
                require("configs._lualine")
            end
        }

        -- Automatically set up your configuration after cloning packer.nvim
        if packer_bootstrap then
            require("packer").sync()
        end
    end
})

cmd [[
  augroup PackerSync
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]]
