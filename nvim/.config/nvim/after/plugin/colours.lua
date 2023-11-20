-- Indiviual colour scheme configuration
require("ayu").setup {
	mirage = false
}

require("gruvbox").setup {
	contrast = "hard",
	invert_selection = true,
	inverse_signs = true,
	bold = false,
	overrides = {
		SignColumn = { bg = "None" },
		CursorLineSign = { link = "CursorLine" },
		Visual = {  }
	},
}
