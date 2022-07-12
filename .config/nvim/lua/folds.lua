-- fold settings
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldnestmax = 5
vim.o.foldminlines = 1

-- remember folds
local augroup = vim.api.nvim_create_augroup('RememberFolds', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', { command = 'silent! loadview', group = augroup })
vim.api.nvim_create_autocmd('BufWinLeave', { command = 'silent! mkview', group = augroup })
