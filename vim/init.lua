-- Extend runtime to support .vimrc and plug.vim
vim.opt.runtimepath:prepend(vim.env.HOME .. '/.vim')
vim.opt.runtimepath:append(vim.env.HOME .. '/.vim/after')
vim.opt.packpath = vim.opt.runtimepath:get()
vim.cmd('source ~/.vimrc')

-- Set statusline colors and ruler
vim.opt.rulerformat = "%30(%=%.50F [%{strlen(&ft)?&ft:'none'}] %l:%c %p%%%)"
vim.cmd([[
  highlight StatusLine   guifg=#ffffff guibg=#000000 gui=none
  highlight StatusLineNC guifg=#666666 guibg=#000000 gui=none
]])
vim.api.nvim_set_hl(0, "Normal",        { bg = "#000000" })
vim.api.nvim_set_hl(0, "StatusLine",    { fg = "#ffffff", bg = "#000000", bold = false })
vim.api.nvim_set_hl(0, "StatusLineNC",  { fg = "#666666", bg = "#000000", bold = false })

-- Set cursor shapes for each mode
vim.opt.guicursor = table.concat({
  "n-v-c:ver25",
  "i-ci-ve:ver25",
  "r-cr:ver25",
  "o:ver25",
  "sm:block",
}, ",")

vim.opt.undodir     = vim.fn.expand("~/.local/share/undo")
vim.opt.undofile    = true
vim.opt.undoreload  = 0

vim.opt.number         = true
vim.opt.relativenumber = true

-- Disable Neovim’s built-in diagnostics (ALE will be used instead)
vim.diagnostic.config({
  underline         = false,
  virtual_text      = false,
  signs             = false,
  update_in_insert  = false,
  severity_sort     = true,
})

-- Set up Mason and install LSP servers
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "gopls", "pyright", "bashls",
    "terraformls", "yamlls", "lua_ls",
  },
  automatic_installation = true,
})

-- Warn if LSP binaries are missing from $PATH
local function check_lsp(name, cmd)
  if vim.fn.executable(cmd) == 0 then
    vim.notify("LSP '" .. name .. "' not found in $PATH", vim.log.levels.WARN)
  end
end

check_lsp("gopls",        "gopls")
check_lsp("pyright",      "pyright-langserver")
check_lsp("bashls",       "bash-language-server")
check_lsp("terraformls",  "terraform-ls")
check_lsp("yamlls",       "yaml-language-server")

local lspconfig = require("lspconfig")
local cmp       = require("cmp")
local luasnip   = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

-- Configure completion UI and behavior
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>']     = cmp.mapping.select_next_item(),
    ['<S-Tab>']   = cmp.mapping.select_prev_item(),
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip'  },
  }, {
    { name = 'buffer'   },
  }),
  window = {
    completion    = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- Add LSP capabilities to enable enhanced completions
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set up each LSP server
local servers = { "gopls", "pyright", "bashls", "terraformls", "yamlls", "lua_ls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end
