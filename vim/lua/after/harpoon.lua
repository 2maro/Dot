local ok, harpoon = pcall(require, "harpoon")
if not ok then
  vim.notify("⚠ Harpoon not found!", vim.log.levels.WARN)
  return
end

harpoon:setup({
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
  },
})

local list = harpoon:list()

-- ==============================================================================
--                            Keybindings
-- ==============================================================================
vim.keymap.set("n", "<leader>ha", function() list:add() end, { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(list) end, { desc = "Harpoon menu" })

vim.keymap.set("n", "<leader>1", function() list:select(1) end, { desc = "Harpoon file 1" })
vim.keymap.set("n", "<leader>2", function() list:select(2) end, { desc = "Harpoon file 2" })
vim.keymap.set("n", "<leader>3", function() list:select(3) end, { desc = "Harpoon file 3" })
vim.keymap.set("n", "<leader>4", function() list:select(4) end, { desc = "Harpoon file 4" })
