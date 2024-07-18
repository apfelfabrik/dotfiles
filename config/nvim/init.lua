require("plugins")

local opt = vim.opt
local keymap = vim.keymap

vim.g.mapleader = "\\"

-- Lines & Columns
opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.linebreak = true -- wrap at word
opt.signcolumn = "auto"
opt.scrolloff = 2

-- Tabs & Whitespace
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.formatprg= "par"

opt.listchars:append({ trail = "·" })
opt.listchars:append({ tab = "▸ " })
opt.listchars:append({ eol = "¬" })

opt.list = false
keymap.set("n", "<leader>l", ":set list!<CR>")

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Colors

opt.termguicolors = true
opt.background = "dark"

opt.backspace = "indent,eol,start"

-- Copy & Paste

opt.clipboard:append("unnamedplus")
keymap.set("n", "<leader>p", ":set paste!<CR>")

-- Panes
opt.splitright = true
opt.splitbelow = true

-- Timesavers
keymap.set("n", ";", ":")

-- From vimrc, figure out where this goes in neovim:

-- From vimrc, let's try neovim w/o these for a while:
-- opt.smartindent = true
-- opt.foldmethod = "indent"
-- opt.foldlevel = 30
-- map <S-Enter> O<ESC>
-- map <Enter> o<ESC>
--
-- Recommended stuff I don't think I want:
-- opt.cursorline = true
-- opt.iskeyword:append("-")

