local keymap = vim.api.nvim_set_keymap
local options = { silent = true, noremap = true }

-- telescope
keymap('n', 'tm', "<cmd>lua require('telescope.builtin').man_pages() <CR>", options)
keymap('n', 'tb', "<cmd>lua require('telescope.builtin').buffers() <CR>", options)
keymap('n', 'tf', "<cmd>lua require('telescope.builtin').find_files() <CR>", options)
-- telescope-git
keymap('n', 'tgf', "<cmd>lua require('telescope.builtin').git_files() <CR>", options)
keymap('n', 'tgc', "<cmd>lua require('telescope.builtin').git_commits() <CR>", options)
keymap('n', 'tgs', "<cmd>lua require('telescope.builtin').git_status() <CR>", options)
keymap('n', 'tgb', "<cmd>lua require('telescope.builtin').git_branches() <CR>", options)
-- telescope-lsp
keymap('n', 'tla', "<cmd>lua require('telescope.builtin').diagnostics() <CR>", options)
keymap('n', 'tlr', "<cmd>lua require('telescope.builtin').lsp_references() <CR>", options)
keymap('n', 'tld', "<cmd>lua require('telescope.builtin').lsp_definitions() <CR>", options)
keymap('n', 'tli', "<cmd>lua require('telescope.builtin').lsp_implementations() <CR>", options)
