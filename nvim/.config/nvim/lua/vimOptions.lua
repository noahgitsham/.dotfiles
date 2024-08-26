-- Line numbers
vim.opt.nu = true -- Line nums
vim.opt.rnu = true -- Relative line nums
vim.opt.fillchars:append("eob: ") -- Remove ~ for end lines

-- Hide window borders
--vim.opt.fillchars:append("horiz: ")
--vim.opt.fillchars:append("horizup: ")
--vim.opt.fillchars:append("horizdown: ")
--vim.opt.fillchars:append("vert: ")
--vim.opt.fillchars:append("vertleft: ")
--vim.opt.fillchars:append("vertright: ")
--vim.opt.fillchars:append("verthoriz: ")

-- Indentation
local indentSize = 4
vim.opt.tabstop = indentSize
vim.opt.shiftwidth = indentSize

-- Align parameters
--vim.opt.cino:append("(0")

-- Line wrapping
vim.opt.wrap = false
vim.opt.linebreak = true

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function (_) 
		vim.opt_local.scrolloff = 0
		vim.opt_local.sidescrolloff = 0
		vim.cmd("startinsert")
	end,
})

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
--vim.opt.cmdheight = 0 -- TODO show macro recording

-- Leader
vim.g.mapleader = "\\"
vim.opt.ttimeout = false
vim.opt.timeout = false

-- Cursor
vim.opt.cursorline = true

-- Netrw
vim.g.netrw_liststyle = 1 -- Tree
vim.g.netrw_fastbrowse = 0

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position",
  pattern = '*',
  command = 'silent! normal! g`"zv'
})

-- Spellcheck
vim.opt.spelllang = "en_gb"

-- Mouse
vim.opt.mouse = ""
