local ok, telescope = pcall(require, "telescope")
if not ok then
  vim.notify("⚠ Telescope not found!", vim.log.levels.WARN)
  return
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

-- Keymaps
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>f", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Interactive grep" })

-- Telescope setup
telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    path_display = { "smart" },
    layout_config = { horizontal = { preview_width = 0.55 } },
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    winblend = 0,
    border = true,
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
    find_files = { hidden = true, previewer = false },
    live_grep = { only_sort_text = true },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- Match Gruvbox Material dark palette
local hl = vim.api.nvim_set_hl
hl(0, "TelescopeNormal",       { bg = "#000000", fg = "#d4be98" })
hl(0, "TelescopeBorder",       { bg = "#000000", fg = "#3c3836" })
hl(0, "TelescopePromptBorder", { bg = "#000000", fg = "#3c3836" })
hl(0, "TelescopePromptNormal", { bg = "#000000", fg = "#ebdbb2" })
hl(0, "TelescopePromptPrefix", { fg = "#d79921", bg = "#000000" })
hl(0, "TelescopePreviewTitle", { fg = "#000000", bg = "#b8bb26", bold = true })
hl(0, "TelescopeResultsTitle", { fg = "#000000", bg = "#fe8019", bold = true })
hl(0, "TelescopeSelection",    { bg = "#111111", fg = "#fabd2f", bold = true })
hl(0, "TelescopeSelectionCaret", { fg = "#fabd2f", bg = "#111111" })
