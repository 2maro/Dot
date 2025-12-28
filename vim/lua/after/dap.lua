local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

require("dap-go").setup()
require("dap-python").setup("python")
require("nvim-dap-virtual-text").setup()

vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>dc", function() dap.continue() end)
vim.keymap.set("n", "<leader>di", function() dap.step_into() end)
vim.keymap.set("n", "<leader>do", function() dap.step_over() end)
vim.keymap.set("n", "<leader>dO", function() dap.step_out() end)
vim.keymap.set("n", "<leader>dt", function() dap.terminate() end)
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end)
