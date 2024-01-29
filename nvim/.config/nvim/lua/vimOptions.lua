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
--vim.opt.cmdheight = 0

-- Remaps
vim.g.mapleader = "\\"
-- vim.keymap.set("n", "<leader>/", vim.cmd.noh) -- Use <C-l> instead

-- Cursor
vim.opt.cursorline = true

-- Netrw
vim.g.netrw_liststyle = 3 -- Tree

-- Return to last cursor position
vim.api.nvim_create_autocmd('BufRead', {
	callback = function(opts)
		vim.api.nvim_create_autocmd('BufWinEnter', {
			once = true,
			buffer = opts.buf,
			callback = function()
				local ft = vim.bo[opts.buf].filetype
				local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
				if
					not (ft:match('commit') and ft:match('rebase'))
					and last_known_line > 1
					and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
					then
						vim.api.nvim_feedkeys([[g`"]], 'nx', false)
					end
					vim.api.nvim_feedkeys("zz", "n", false)
				end,
			})
		end,
	})
