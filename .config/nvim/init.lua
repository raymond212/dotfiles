-- Neovim configuration

-- Line numbers
vim.opt.number = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Better UI
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Save and quit shortcuts
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>x", ":q!<CR>")
