-- Treesitter
require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"html"
	},
	highlight = {
		enable = true
	},
	auto_install = true,
	textobjects = {
		lsp_interop = {
			enable = true,
			border = 'none',
			floating_preview_opts = {},
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		}
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_anonymous_nodes = 'a',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<cr>',
			show_help = '?',
		},
	},
}

require('nvim-ts-autotag').setup {
	opts = {
		-- Defaults
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs of tags
		enable_close_on_slash = true -- Auto close on trailing </
	},
}

-- Treesitter Folding
--vim.o.foldmethod = "expr"
--vim.o.foldexpr = "nvim_treesitter#foldexpr()"
--
---- Automatic find fold level
--vim.api.nvim_create_autocmd("BufEnter", {
--	callback = function()
--		local maxfold = 0
--		for line=1,vim.fn.line("$") do
--			local linelevel = vim.fn.foldlevel(line)
--			if linelevel > maxfold then
--				maxfold = linelevel
--			end
--		end
--		vim.o.foldlevel = maxfold
--	end
--})
