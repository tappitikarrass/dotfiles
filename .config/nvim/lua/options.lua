vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.clipboard = "unnamedplus"
vim.o.filetype = true

vim.o.number = true
-- vim.o.cmdheight = 0
vim.o.completeopt = 'menuone,noselect'

-- colorcheme
vim.o.termguicolors = true
vim.cmd [[colorscheme base16-default-dark]]
vim.o.fcs = 'eob: '
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
