local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
    vim.notify("⚠ Treesitter not found!", vim.log.levels.WARN)
    return
end

configs.setup({
    ensure_installed = {
        "lua", "vim", "bash", "go", "python", "yaml", "json", "terraform",
        "dockerfile", "markdown", "html", "css", "javascript", "typescript",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})

-- Set colors to match Vim
vim.api.nvim_set_hl(0, "@keyword.import", { fg = "#b16286" })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#b8932e" })
vim.api.nvim_set_hl(0, "@namespace", { fg = "#b8932e" })
vim.api.nvim_set_hl(0, "@lsp.type.namespace", { fg = "#b8932e" })
