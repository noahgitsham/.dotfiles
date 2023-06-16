-- Line numbers
vim.opt.nu = true -- Line nums
vim.opt.rnu = true -- Relative line nums

-- Indentation
local indentSize = 8
vim.opt.tabstop = indentSize
vim.opt.shiftwidth = indentSize

-- Line wrapping
vim.opt.wrap = false
vim.opt.linebreak = true

-- Scroll
vim.opt.scrolloff = 8

-- Stop autocomment on enter
-- vim.opt.formatoptions:remove("cro")

-- Search
vim.opt.hlsearch = true

-- Buffers + Panes
vim.opt.splitbelow = true
vim.opt.splitright = true

