require 'packer_bootstrap'

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
  use 'SmiteshP/nvim-gps'
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
  use 'RRethy/nvim-base16'
  use 'nvim-lualine/lualine.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use { 'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()' }
  use 'dhruvasagar/vim-table-mode'
end)

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

require('luasnip.loaders.from_vscode').load()

require('lspkind').init {
  symbol_map = {
    Text = ' ',
    Method = ' ',
    Function = ' ',
    Constructor = ' ',
    Field = ' ',
    Variable = ' ',
    Class = ' ',
    Interface = ' ',
    Module = ' ',
    Property = ' ',
    Unit = ' ',
    Value = ' ',
    Enum = ' ',
    Keyword = '  ',
    Snippet = ' ',
    Color = ' ',
    File = ' ',
    Reference = ' ',
    Folder = ' ',
    EnumMember = ' ',
    Constant = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' ',
  },
}
require('nvim-gps').setup {
  icons = {
    ['class-name'] = '  ', -- Classes and class-like objects
    ['function-name'] = '  ', -- Functions
    ['method-name'] = '  ', -- Methods (functions inside class-like objects)
    ['container-name'] = '  ', -- Containers (example: lua tables)
    ['tag-name'] = '  ', -- Tags (example: html tags)
  },
}

require('Comment').setup()
require('nvim-tree').setup()
require('colorizer').setup()
require('telescope').setup()
require('numb').setup()
require('stabilize').setup()

require 'statusline'
