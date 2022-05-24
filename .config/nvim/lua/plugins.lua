-- bootstrap
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


vim.cmd([[
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
]])

-- plugins
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
    use {'onsails/lspkind.nvim'}
    -- fmt
    use 'sbdchd/neoformat'
    -- use 'lukas-reineke/lsp-format.nvim'
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
    -- Markdown
    use 'ellisonleao/glow.nvim'
    use {'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()'}
    use 'dhruvasagar/vim-table-mode'
    if Packer_bootstrap then require("packer").sync() end
end)

-- init
require('lspkind').init({
    symbol_map = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = " ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = "  ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " "
    },
})
require("nvim-gps").setup({
	icons = {
		["class-name"] = '  ',      -- Classes and class-like objects
		["function-name"] = '  ',   -- Functions
		["method-name"] = '  ',     -- Methods (functions inside class-like objects)
		["container-name"] = '  ',  -- Containers (example: lua tables)
		["tag-name"] = '  '         -- Tags (example: html tags)
	},
})
require("Comment").setup()
require("nvim-tree").setup()
require("colorizer").setup()
require("telescope").setup()
require("luasnip.loaders.from_vscode").load()
require("numb").setup()
require("stabilize").setup()
-- require("lsp-format").setup()

vim.g.mkdp_auto_close = 0
