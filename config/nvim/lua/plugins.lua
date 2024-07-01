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
--
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  eslint = {},
  graphql = {},
  html = {},
  cssls = {},

  lua_ls = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false }
    },
  },
}


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
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers)
        -- automatic_installation = true, -- Automatically install language servers
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end,
      })

      lspconfig.gdscript.setup{
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end
  },

  {
    -- lazydev.nvim is a plugin that properly configures LuaLS for
    -- editing your Neovim config by lazily updating your workspace
    -- ibraries.
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    -- opts = {
    --   library = {
    --     -- See the configuration section for more details
    --     -- Load luvit types when the `vim.uv` word is found
    --     { path = "luvit-meta/library", words = { "vim%.uv" } },
    --   },
    -- },
  },

  {
    -- A completion engine plugin for neovim written in Lua. Completion
    -- sources are installed from external repositories and "sourced".
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },

})
