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
  "nvim-lua/plenary.nvim",
  {
    "dim13/smyck.vim",
    config = function()
      vim.cmd("colorscheme smyck")
    end
  },
  "christoomey/vim-tmux-navigator",
  "nvim-lualine/lualine.nvim",
  "preservim/nerdtree",

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
})
