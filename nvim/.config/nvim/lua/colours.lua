-- Active colour scheme
local colour = "gruvbox"

vim.opt.termguicolors = true

-- Indiviual colour scheme configuration
require("ayu").setup {
	mirage = false
}

require("gruvbox").setup {
	contrast = "hard"
}

-- Set colour scheme
vim.cmd("colorscheme " .. colour)
