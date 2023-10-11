vim.opt.termguicolors = true

-- Indiviual colour scheme configuration
require("ayu").setup {
	mirage = false
}

require("gruvbox").setup {
	contrast = "hard",
	invert_selection = true,
}

-- Set colour scheme
vim.cmd.colorscheme("gruvbox")
