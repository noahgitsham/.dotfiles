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

vim.g.tundra_biome = "jungle"
require("nvim-tundra").setup {
	plugins = {
		lsp = true,
		semantic_tokens = true,
		treesitter = true,
		telescope = true,
		cmp = true,
		gitsigns = true,
		neogit = true,
		textfsm = true,
	},
}
