local opt = vim.opt
local g = vim.g

-- Default UX configuration
opt.title = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.cul = false
opt.ruler = false
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.scrolloff = 8
opt.encoding = "utf-8"

-- Indentation
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.expandtab = true

-- Search
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.gdefault = true

-- Misc
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.undofile = true

g.mapleader = " "
