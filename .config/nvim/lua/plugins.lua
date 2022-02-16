-- Packer bootstrap
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Packer plugins
require("packer").startup(function(use)
    use 'wbthomason/packer.nvim'
    use "nathom/filetype.nvim"
    -- Features
    use 'luukvbaal/stabilize.nvim'
    use 'numToStr/Comment.nvim'
    use "nacro90/numb.nvim"
    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', requires = {"SmiteshP/nvim-gps"}}
    -- LSP and autocomplete
    use 'neovim/nvim-lspconfig'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-nvim-lua', 'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip', 'lukas-reineke/cmp-under-comparator'
        }
    }
    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    -- UI
    use "RRethy/nvim-base16"
    use 'nvim-lualine/lualine.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use 'kyazdani42/nvim-tree.lua'
    -- Discord
    use 'andweeb/presence.nvim'

    if Packer_bootstrap then require("packer").sync() end
end)

-- Setup plugins
require("Comment").setup()
require("nvim-tree").setup()
require("colorizer").setup()
require("telescope").setup()
require("nvim-gps").setup()
require("luasnip.loaders.from_vscode").load()
require("numb").setup()
require("stabilize").setup()
