local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--   use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
--   use 'nvim-telescope/telescope.nvim'

require("lazy").setup({
  {
    "dim13/smyck.vim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme smyck]])
    end,
  },
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  "nvim-lualine/lualine.nvim",
  "preservim/nerdtree",
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },
})

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  eslint = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false }
    },
  },
}

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers)
}

require('lspconfig').tsserver.setup{}
require('lspconfig').eslint.setup{}
require('lspconfig').lua_ls.setup{}

require('lspconfig').gdscript.setup{
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
