-------------------------------
-- MISC PLUGIN CONFIGURATION --
-------------------------------

-- Colorizer
require("colorizer").setup {
	filetypes = { "*" },
	user_default_options = {
		RGB = false, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		names = false, -- "Name" codes like Blue or blue
		RRGGBBAA = true, -- #RRGGBBAA hex codes
		AARRGGBB = false, -- 0xAARRGGBB hex codes
		rgb_fn = true, -- CSS rgb() and rgba() functions
		hsl_fn = false, -- CSS hsl() and hsla() functions
		css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes for `mode`: foreground, background,  virtualtext
		mode = "background", -- Set the display mode.
		virtualtext = "■",
		-- update color values even if buffer is not focused
		-- example use: cmp_menu, cmp_docs
		always_update = false
	},
	-- all the sub-options of filetypes apply to buftypes
	buftypes = {},
}

require("ibl").setup {
	scope = {
		enabled = false,
		show_end = false,
		show_start = false,
	},
	indent = {
		char = "│"
	}
}

require("scrollEOF").setup()

require("twilight").setup {
	treesitter = true,
	context = 16,
	expand = {
		"method_definition",
		"function",
		"table_constructor",
		"table",
		"method",
		"if_statement"
	},
}

--vim.api.nvim_set_keymap("i", "<C-J", 'copilot#Accept("<CR>")', {silent = true, expr = true})
--vim.g.copilot_no_tab_map = true
--vim.g.copilot_assume_mapped = true
--vim.g.copilot_enabled = false
--vim.g.copilot_tab_fallback = ""

--vim.keymap.set("i", "<C-x>", function ()
--	vim.print(vim.g.copilot_enabled and vim.fn['copilot#GetDisplayedSuggestion']().text ~= '' and vim.fn['copilot#Accept']() ~= "" and type(vim.fn['copilot#Accept']()) == 'string')
--end)

require("live-command").setup {
	commands = {
		Norm = {cmd = "norm"}
	}
}

require("unfocused-cursor").setup()
