local ok, gruvbox = pcall(require, "gruvbox")
if not ok then
    vim.notify("⚠ Gruvbox plugin not found!", vim.log.levels.WARN)
    return
end

gruvbox.setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = false,
    italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,
    contrast = "",
    palette_overrides = {
        dark0_hard = "#000000",
    },
    overrides = {
        -- Basic syntax
        Keyword = { fg = "#fb4934" },
        Type = { fg = "#fb4934" },
        Function = { fg = "#b8bb26" },
        String = { fg = "#b8bb26" },
        Number = { fg = "#d3869b" },
        Constant = { fg = "#d3869b" },
        
        -- UI elements
        LineNr = { fg = "#504945", bg = "#000000" },
        CursorLine = { bg = "#111111" },
        CursorLineNr = { fg = "#fabd2f", bg = "#000000", bold = true },
        
        -- Treesitter
        ["@keyword"] = { fg = "#fb4934" },
        ["@keyword.import"] = { fg = "#d3869b" },
        ["@type"] = { fg = "#fb4934" },
        ["@type.builtin"] = { fg = "#fabd2f" },
        ["@function"] = { fg = "#b8bb26" },
        ["@string"] = { fg = "#b8bb26" },
        ["@number"] = { fg = "#d3869b" },
        ["@constant"] = { fg = "#d3869b" },
        ["@namespace"] = { fg = "#fabd2f" },
        
        -- LSP
        ["@lsp.type.namespace"] = { fg = "#fabd2f" },
        ["@lsp.type.type"] = { fg = "#fb4934" },
    },
})

vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")
