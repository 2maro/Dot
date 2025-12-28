-- =============================================================================
--  LSP (ALE-Compatible, Modern, Black-Background Theme)
-- =============================================================================
-- Safe Mason setup
local ok_mason, mason = pcall(require, "mason")
local ok_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if not (ok_mason and ok_mason_lsp) then return end

mason.setup()
mason_lsp.setup({
    ensure_installed = { "gopls", "pyright", "bashls", "terraformls", "yamlls", "lua_ls" },
    automatic_installation = true,
})

-- Capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Universal on_attach that disables diagnostics & formatting (ALE handles both)
local function on_attach(client, bufnr)
    -- Disable ALL LSP features that conflict with ALE
    if client.server_capabilities then
        client.server_capabilities.diagnosticProvider = false
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
end

-- Disable global diagnostics completely (no deprecation warning)
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
    update_in_insert = false,
    severity_sort = false,
})

-- Register servers using new vim.lsp.config API
local servers = { "gopls", "pyright", "bashls", "terraformls", "yamlls", "lua_ls" }
for _, server in ipairs(servers) do
    vim.lsp.config[server] = {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    vim.lsp.enable(server)
end

-- =============================================================================
--  ALE Signs with Black Backgrounds (emojis defined in .vimrc)
-- =============================================================================

-- Set the SignColumn to black
vim.api.nvim_set_hl(0, "SignColumn", { fg = "NONE", bg = "#000000" })

-- Set ALE sign highlight groups with Gruvbox colors and black backgrounds
vim.api.nvim_set_hl(0, "ALEErrorSign", { fg = "#fb4934", bg = "#000000" })
vim.api.nvim_set_hl(0, "ALEWarningSign", { fg = "#fabd2f", bg = "#000000" })
vim.api.nvim_set_hl(0, "ALEInfoSign", { fg = "#83a598", bg = "#000000" })
vim.api.nvim_set_hl(0, "ALEStyleErrorSign", { fg = "#fb4934", bg = "#000000" })
vim.api.nvim_set_hl(0, "ALEStyleWarningSign", { fg = "#fabd2f", bg = "#000000" })

-- Enforce black background after any colorscheme reload
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "SignColumn", { fg = "NONE", bg = "#000000" })
        vim.api.nvim_set_hl(0, "ALEErrorSign", { fg = "#fb4934", bg = "#000000" })
        vim.api.nvim_set_hl(0, "ALEWarningSign", { fg = "#fabd2f", bg = "#000000" })
        vim.api.nvim_set_hl(0, "ALEInfoSign", { fg = "#83a598", bg = "#000000" })
        vim.api.nvim_set_hl(0, "ALEStyleErrorSign", { fg = "#fb4934", bg = "#000000" })
        vim.api.nvim_set_hl(0, "ALEStyleWarningSign", { fg = "#fabd2f", bg = "#000000" })
    end,
})
