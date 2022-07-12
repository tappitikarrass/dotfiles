local lspconfig = require 'lspconfig'
local null_ls = require 'null-ls'
local cmp = require 'cmp'
local lspkind = require 'lspkind'

--[[
        null-ls
--]]
local sources = {
  -- lua
  null_ls.builtins.formatting.stylua,
  -- json
  null_ls.builtins.formatting.jq,
  -- js, html, css
  null_ls.builtins.code_actions.eslint_d,
  null_ls.builtins.diagnostics.eslint_d,
  null_ls.builtins.formatting.prettierd,
  -- shell
  null_ls.builtins.diagnostics.zsh,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.formatting.shfmt,
  -- python
  null_ls.builtins.formatting.black,
  -- nginx
  null_ls.builtins.formatting.nginx_beautifier,
  -- docker
  null_ls.builtins.diagnostics.hadolint,
  -- c++
  -- null_ls.builtins.formatting.clang_format.with {
  --   disabled_filetypes = { 'cs' },
  -- },
}

null_ls.setup { sources = sources }

--[[
        nvim-cmp
--]]
cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'emoji' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol_text',
      maxwidth = 50,
    },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
}

local caps = vim.lsp.protocol.make_client_capabilities()
caps = require('cmp_nvim_lsp').update_capabilities(caps)

--[[
        null-ls format on save & override format
--]]
local function contains(table, val)
  for i = 1, #table do
    if table[i] == val then
      return true
    end
  end
  return false
end

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      local servers = { 'sumneko_lua', 'tsserver', 'clangd' }
      if contains(servers, client.name) then
        return false
      end
      return true
    end,
    bufnr = bufnr,
  }
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local navic = require 'nvim-navic'
local on_attach = function(client, bufnr)
  if client.supports_method 'textDocument/formatting' then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end

  -- do not load nvim-navic if unsupported by server
  local servers = { 'bashls' }
  if not contains(servers, client.name) then
    navic.attach(client, bufnr)
  end
end

--[[
        servers declaration
--]]

-- c++
lspconfig.clangd.setup {
  capabilities = caps,
  on_attach = on_attach,
}

-- python
lspconfig.pyright.setup {
  capabilities = caps,
  on_attach = on_attach,
}

-- css
lspconfig.cssls.setup {
  capabilities = caps,
  on_attach = on_attach,
}

-- c#
local pid = vim.fn.getpid()
local omnisharp_bin = '~/.local/share/nvim/lsp_servers/omnisharp/omnisharp/Omnisharp_bin'
lspconfig.omnisharp.setup {
  capabilities = caps,
  on_attach = on_attach,
  cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
}

-- bash
lspconfig.bashls.setup {
  capabilities = caps,
  on_attach = on_attach,
}

-- js
lspconfig.tsserver.setup {
  capabilities = caps,
  on_attach = on_attach,
}

-- sumneko_lua
local runtime_path = vim.split(package.path, ';')
lspconfig.sumneko_lua.setup {
  capabilities = caps,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
