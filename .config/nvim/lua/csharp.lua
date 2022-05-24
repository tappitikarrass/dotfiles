local pid = vim.fn.getpid()
local omnisharp_bin = "/usr/bin/omnisharp"
require('lspconfig')['omnisharp'].setup {
    capabilities = capabilities,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid)}
}
