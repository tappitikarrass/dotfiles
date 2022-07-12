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
