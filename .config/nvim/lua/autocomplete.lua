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

--[[
        format on save
--]]

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
null_ls.setup {
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

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

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function(entry, vim_item)
      --  return vim_item
      -- end,
    },
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

local navic = require 'nvim-navic'
local caps = vim.lsp.protocol.make_client_capabilities()
caps = require('cmp_nvim_lsp').update_capabilities(caps)

--[[
        disable lsp formatting that overlaps with null-ls
--]]
local on_attach = function(client, bufnr)
  local function contains(table, val)
    for i = 1, #table do
      if table[i] == val then
        return true
      end
    end
    return false
  end

  local servers = { 'sumneko_lua', 'tsserver', 'clangd' }

  if contains(servers, client.name) then
    client.server_capabilities.documentFormattingProvider = false
  end
  navic.attach(client, bufnr)
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
