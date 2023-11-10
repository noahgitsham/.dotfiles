-- Line numbers
vim.opt.nu = true -- Line nums
vim.opt.rnu = true -- Relative line nums
vim.wo.fillchars = "eob: " -- Remove ~ for end lines

-- Indentation
local indentSize = 4
vim.opt.tabstop = indentSize
vim.opt.shiftwidth = indentSize

-- Line wrapping
vim.opt.wrap = false
vim.opt.linebreak = true

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Stop autocomment on enter

vim.opt.cino:append("(0")

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Buffers + Panes
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Statusline
vim.opt.laststatus = 3 -- Global Statusline
vim.opt.showmode = false

-- Remaps
vim.g.mapleader = "\\"
-- vim.keymap.set("n", "<leader>/", vim.cmd.noh) -- Use <C-l> instead

-- Cursor
vim.opt.cursorline = true

-- Netrw
vim.g.netrw_liststyle = 3 -- Tree
