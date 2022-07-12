-- bootstrap
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

-- packadd packer after bootstrap
vim.cmd [[ packadd packer.nvim ]]

local packer = require 'packer'
packer.init {
  auto_clean = true,
  autoremove = true,
}

-- plugins
packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  -- features
  use 'luukvbaal/stabilize.nvim'
  use 'numToStr/Comment.nvim'
  use 'nacro90/numb.nvim'
  use 'dhruvasagar/vim-table-mode' -- vimscript junk
  -- use { 'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()' } -- annoying but gets work done
  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'onsails/lspkind.nvim'
  use 'williamboman/nvim-lsp-installer'
  use 'SmiteshP/nvim-navic'
  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  -- autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'saadparwaiz1/cmp_luasnip',
    },
  }
  -- colorscheme
  use 'ishan9299/nvim-solarized-lua'
  -- ui
  use 'stevearc/dressing.nvim'
  use 'MunifTanjim/nui.nvim'
  use 'rcarriga/nvim-notify'

  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'

  use 'kyazdani42/nvim-web-devicons'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'norcalli/nvim-colorizer.lua'

  -- sync after bootstrap
  if packer_bootstrap then
    packer.sync()
  end
end)

-- colorscheme
vim.o.bg = 'dark'
vim.cmd 'colorscheme solarized'

-- neovide config
vim.cmd [[
    if exists("g:neovide")
        set guifont=JetBrainsMono\ Nerd\ Font:h9
        let g:neovide_transparency=0.8
    else
        hi Normal guibg=NONE ctermbg=NONE
    endif
]]

-- plugins config
require('colorizer').setup()
require('numb').setup()
require('stabilize').setup()

require('Comment').setup()
require('luasnip.loaders.from_vscode').load()

require('lspkind').init()
require('nvim-navic').setup()

require('nvim-lsp-installer').setup {
  automatic_installation = true,
}

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

-- external plugins config
require 'plugin_config.nvimtree_config'
require 'plugin_config.ui_config'
require 'plugin_config.lualine_config'
