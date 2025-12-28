local ok, jaq = pcall(require, "jaq-nvim")
if not ok then
    vim.notify("⚠ Jaq not found!", vim.log.levels.WARN)
    return
end

jaq.setup({
    -- Commands to run
    cmds = {
        -- Default
        default = "float",
        
        -- Uses internal terminal
        internal = {
            lua = "luafile %",
            vim = "source %",
        },
        
        -- Uses external terminal
        external = {
            python = "python3 %",
            go = "go run %",
            sh = "bash %",
            bash = "bash %",
            rust = "cargo run",
            javascript = "node %",
            typescript = "ts-node %",
            markdown = "glow %",
        },
    },
    
    -- UI settings
    ui = {
        float = {
            -- Floating window settings
            border = "rounded",
            winblend = 0,
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5,
        },
        
        terminal = {
            -- Terminal settings
            position = "bot",
            size = 10,
            line_no = false,
        },
        
        -- Quickfix settings
        quickfix = {
            position = "bot",
            size = 10,
        },
    },
    
    -- Keybindings
    behavior = {
        -- Default type (float, terminal, quickfix, etc.)
        default = "float",
        
        -- Start in insert mode
        startinsert = false,
        
        -- Switch back to current file after running
        wincmd = false,
        
        -- Auto-save before running
        autosave = true,
    },
})

-- ==============================================================================
--                            Keybindings
-- ==============================================================================
vim.keymap.set("n", "<leader>r", ":Jaq<CR>", { desc = "Quick run file", silent = true })
vim.keymap.set("n", "<leader>rr", ":Jaq<CR>", { desc = "Quick run file", silent = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "jaq",
    callback = function()
        vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true })
    end,
})
-- ==============================================================================
--                            Theme Integration (Black Background)
-- ==============================================================================
local function set_jaq_highlights()
    -- Floating window
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3c3836", bg = "#000000" })
    
    -- Terminal
    vim.api.nvim_set_hl(0, "Terminal", { bg = "#000000" })
end

-- Apply highlights
set_jaq_highlights()

-- Reapply after colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_jaq_highlights,
})
