-- Line numbers
vim.opt.nu = true -- Line nums
vim.opt.rnu = true -- Relative line nums
vim.wo.fillchars = "eob: "

-- Indentation
IndentSize = 8
vim.opt.tabstop = IndentSize
vim.opt.shiftwidth = IndentSize

-- Line wrapping
vim.opt.wrap = false
vim.opt.linebreak = true

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Stop autocomment on enter
vim.opt_local.formatoptions:remove({"r", "o"})

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Buffers + Panes
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- Statusline
vim.opt.laststatus = 3 -- Global Statusline

-- Remaps
vim.g.mapleader = "\\"
vim.keymap.set("n", "<leader>/", vim.cmd.noh)
