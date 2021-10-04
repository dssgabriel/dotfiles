-- Default lua configuration of Neovim

local M = {}
M.options, M.ui, M.keymaps, M.plugins = {}, {}, {}, {}

-- Default options, no plugin required
M.options = {
    -- Vim/Neovim options
    mapleader = " ",
    mouse = "a",
    clipboard = "unnamedplus",
    cmdheight = 1,
    ruler = false,
    hidden = true,
    smartcase = true,
    number = true,
    relativenumber = true,
    numberwidth = 2,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    smartindent = true,
}

-- Default UI configuration
M.ui = {
    italic_comments = true,
    transparency = false,
    -- TODO: add color scheme here later
}

-- Default plugins configuration
M.plugins = {
}

-- Default keymappings
M.keymaps = {
    close_buffer = "<leader>x",
    new_buffer = "<leader>t",
    save_file = "<leader>w",
}
