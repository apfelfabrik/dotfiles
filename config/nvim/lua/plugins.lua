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
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = false,
      })
    end
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("null-ls").setup()
    end,
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
          lspconfig[server_name].setup(servers[server_name])
        end,
      })

      lspconfig.gdscript.setup{
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }

      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Execute Code Action"})
    end
  },

  {
    -- lazydev.nvim is a plugin that properly configures LuaLS for
    -- editing your Neovim config by lazily updating your workspace
    -- ibraries.
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
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

  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
      local telescope = require("telescope")
      vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true, desc = "Find Files" })

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = { }
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown { }
          }
        },
      })

      require("telescope").load_extension("ui-select")
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          'javascript', 'lua', 'luadoc', 'markdown', 'typescript', 'vim', 'vimdoc',
        }
      }
    end
  },

  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "llama3:70b-instruct",
      host = "localhost",
      port = "11434",
    },
    config = function()
      vim.keymap.set({ 'n', 'v' }, '<leader>g', ':Gen<CR>')
    end
  },
})
