-- ==============================================================================
--                              Core Setup
-- ==============================================================================
vim.opt.runtimepath:prepend(vim.env.HOME .. '/.vim')
vim.opt.runtimepath:append(vim.env.HOME .. '/.vim/after')
vim.opt.packpath = vim.opt.runtimepath:get()

vim.cmd('source ~/.vimrc')
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.local/share/nvim-undo')

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = 'unnamedplus'

-- ==============================================================================
--                                Packer
-- ==============================================================================
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd('packadd packer.nvim')
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  -- Core package manager
  use('wbthomason/packer.nvim')

  -- ========================================================================
  --                            Plugins
  -- ========================================================================
  -- LSP + Completion
  use('neovim/nvim-lspconfig')
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')

  -- Syntax Highlighting
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
   use({'ellisonleao/gruvbox.nvim'})

  -- Fuzzy Finder
  use('nvim-telescope/telescope.nvim')
  use('nvim-lua/plenary.nvim')
  use('nvim-tree/nvim-web-devicons')
  use "nvim-lua/plenary.nvim" 
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  }
  -- Quick Run
  use('is0n/jaq-nvim')

  -- Debugging
  use('mfussenegger/nvim-dap')
  use('nvim-neotest/nvim-nio')
  use('rcarriga/nvim-dap-ui')
  use('theHamsta/nvim-dap-virtual-text')
  use('leoluz/nvim-dap-go')
  use('mfussenegger/nvim-dap-python')

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- ==============================================================================
--                           After/Plugin Configs
-- ==============================================================================

local function safe_require(module)
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify('Error loading ' .. module .. ': ' .. err, vim.log.levels.WARN)
  end
end

safe_require('after.theme')
safe_require('after.lsp')
safe_require('after.telescope')
safe_require('after.runner')
safe_require('after.dap')
safe_require('after.treesitter')
safe_require('after.jaq')

-- ==============================================================================
--                              UI Enhancements
-- ==============================================================================
vim.opt.rulerformat = "%30(%=%.50F [%{strlen(&ft)?&ft:'none'}] %l:%c %p%%%)"
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#000000", bold = false })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#666666", bg = "#000000", bold = false })

-- Cursor style for each mode
vim.opt.guicursor = table.concat({
  "n-v-c:ver25",
  "i-ci-ve:ver25",
  "r-cr:ver25",
  "o:ver25",
  "sm:block",
}, ",")

