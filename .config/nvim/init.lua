----- NEOVIM CONFIGURATION -----

-- Settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editing
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- UI
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>x", ":q!<CR>")

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>o", ":NvimTreeFindFile<CR>")

vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>bn", ":BufferLineMoveNext<CR>")
vim.keymap.set("n", "<leader>bp", ":BufferLineMovePrev<CR>")
vim.keymap.set("n", "<leader>bd", ":bd<CR>")

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, function()
    require("bufferline").go_to(i, true)
  end)
end

----- PLUGINS -----

-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lualine/lualine.nvim",
  { "nvim-tree/nvim-tree.lua", version = "*", dependencies = {
    "nvim-tree/nvim-web-devicons",
  }},
  { "akinsho/bufferline.nvim", version = "*", dependencies = {
    "nvim-tree/nvim-web-devicons",
  }},
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})

-- lualine
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})

-- nvim-tree
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  view = { width = 30, side = "left" },
  renderer = {
    group_empty = true,
    highlight_git = true,
  },
  filters = {
    dotfiles = false,
    custom = { "^.git$" },
  },
  actions = {
    open_file = { quit_on_open = false },
  },
})

-- bufferline
require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    separator_style = "thin",
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
        separator = true,
      },
    },
  },
})

-- nvim-treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "python",
    "bash",
    "json",
    "yaml",
    "markdown",
    -- base parsers
    "lua",
    "vim",
    "vimdoc",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})
