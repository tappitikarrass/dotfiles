require('telescope').setup {
  defaults = {
    border = true,
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  },
  pickers = {
    buffers = {
      theme = 'dropdown',
      previewer = false,
      borderchars = {
        { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
        results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
        preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      },
      prompt_title = false,
    },
  },
}

require('notify').setup {
  background_colour = '#002b36',
  stages = 'slide',
  fps = 60,
}
vim.notify = require 'notify'

require('dressing').setup {
  input = {
    backend = { 'builtin' },
  },
  select = {
    backend = { 'telescope' },
  },
}
