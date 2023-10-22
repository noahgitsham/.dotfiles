------------------------------------------
-- PACKER SETUP AND PLUGIN INSTALLATION --
------------------------------------------

-- Plugin installation
require("packer").startup(function(use)
	use "wbthomason/packer.nvim"

	-- Local plugins
	--use "/home/noah/programming/nvimPlugins/html-live.nvim"

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate"
	}
	use {
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		requires = "nvim-treesitter/nvim-treesitter",
	}
	use "nvim-treesitter/playground"
	use "windwp/nvim-ts-autotag"

	-- Telescope
	use {
		"nvim-telescope/telescope.nvim", tag = "0.1.1",
		requires = { {"nvim-lua/plenary.nvim"} }
	}

	-- Misc
	use "NvChad/nvim-colorizer.lua"
	use "windwp/nvim-autopairs"
	use "lukas-reineke/indent-blankline.nvim"
	use "Aasim-A/scrollEOF.nvim"
	use { "folke/zen-mode.nvim", "folke/twilight.nvim" }
	use "ThePrimeagen/vim-be-good"
	use "turbio/bracey.vim"
	use "github/copilot.vim"
	use "smjonas/live-command.nvim"

	---------
	-- LSP --
	---------

	-- Mason + lspconfig
	use "neovim/nvim-lspconfig"
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	}

	-- Cmp
	use {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp-signature-help",
	}
	use "ray-x/lsp_signature.nvim"

	-- Plugin lsp help
	use "folke/neodev.nvim"

	-- LuaSnip
	use "L3MON4D3/LuaSnip"
	use "saadparwaiz1/cmp_luasnip"
	use "rafamadriz/friendly-snippets"

	-- Trouble
	use "folke/trouble.nvim"

	-- DAP
	use {
		"mfussenegger/nvim-dap",
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
	}
	use "mfussenegger/nvim-dap-python"


	-- Colour Themes
	use "Shatur/neovim-ayu"
	use "arturgoms/moonbow.nvim"
	use "ellisonleao/gruvbox.nvim"
	use "rebelot/kanagawa.nvim"
	use "loctvl842/monokai-pro.nvim"
	use "sainnhe/gruvbox-material"
end)

-------------------------------
-- MISC PLUGIN CONFIGURATION --
-------------------------------

-- Colorizer
require("colorizer").setup {
	filetypes = { "*" },
	user_default_options = {
		RGB = true, -- #RGB hex codes
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
	--show_trailing_blankline_indent = false,
	scope = {
		enabled = false,
		show_end = false,
		show_start = false,
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
vim.g.copilot_assume_mapped = true
vim.g.copilot_enabled = false
--vim.g.copilot_tab_fallback = ""

vim.keymap.set("i", "<C-x>", function ()
	vim.print(vim.g.copilot_enabled and vim.fn['copilot#GetDisplayedSuggestion']().text ~= '' and vim.fn['copilot#Accept']() ~= "" and type(vim.fn['copilot#Accept']()) == 'string')
end)

require("live-command").setup {
	commands = {
		Norm = {cmd = "norm"}
	}
}

