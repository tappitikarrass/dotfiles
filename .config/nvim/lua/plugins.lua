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

vim.cmd [[packadd packer.nvim]] -- packadd packer module

require('packer').init {
  max_jobs = 4,
  auto_clean = true,
  autoremove = true,
}

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  -- features
  use 'luukvbaal/stabilize.nvim'
  use 'numToStr/Comment.nvim'
  use 'nacro90/numb.nvim'
  -- lspconfig
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'onsails/lspkind.nvim'
  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  -- autocomplete
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
  -- ui
  use 'numToStr/FTerm.nvim'
  use 'RRethy/nvim-base16'
  use 'nvim-lualine/lualine.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use { 'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()' }
  use 'dhruvasagar/vim-table-mode'
  use 'SmiteshP/nvim-navic'
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- require('FTerm').setup()

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

require('FTerm').setup {
  border = 'none',
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
}

vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })

require('luasnip.loaders.from_vscode').load()

require('lspkind').init {
  preset = 'codicons',
}

require('nvim-navic').setup {
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' ',
  },
}

require('Comment').setup()
require('colorizer').setup()
require('telescope').setup()
require('numb').setup()
require('stabilize').setup()

require 'statusline'

require('nvim-tree').setup {
  open_on_setup = false,
  open_on_setup_file = false,
  sort_by = 'extension',
  hijack_cursor = true,
  filesystem_watchers = {
    enable = true,
  },
  view = {
    adaptive_size = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  git = {
    enable = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = 'signcolumn',
      show = {
        folder = false,
      },
    },
  },
}

vim.cmd 'colorscheme base16-classic-dark'
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]

-- fold settings
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldnestmax = 5
vim.o.foldminlines = 1

-- remember folds
local group = vim.api.nvim_create_augroup('RememberFolds', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', { command = 'silent! loadview', group = group })
vim.api.nvim_create_autocmd('BufWinLeave', { command = 'mkview', group = group })
