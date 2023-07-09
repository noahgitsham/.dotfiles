------------------------------------------
-- PACKER SETUP AND PLUGIN INSTALLATION --
------------------------------------------

-- Plugin installation
require("packer").startup(function(use)
	use "wbthomason/packer.nvim"

	use "/home/noah/programming/nvimPlugins/html-live.nvim"

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


	---------
	-- LSP --
	---------

	-- Mason + lspconfig
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}

	-- Cmp
	use {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp-signature-help",
	}

	-- Plugin lsp help
	use "folke/neodev.nvim"

	-- LuaSnip
	use "L3MON4D3/LuaSnip"
	use "saadparwaiz1/cmp_luasnip"
	use "rafamadriz/friendly-snippets"

	-- Trouble
	use "folke/trouble.nvim"

	-- DAP


	-- Colour Themes
	use "Shatur/neovim-ayu"
	use "arturgoms/moonbow.nvim"
	use "sainnhe/gruvbox-material"
	use "ellisonleao/gruvbox.nvim"
	use "rebelot/kanagawa.nvim"
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
		-- Available methods are false / true / "normal" / "lsp" / "both"
		-- True is same as normal
		tailwind = false, -- Enable tailwind colors
		-- parsers can contain values used in |user_default_options|
		sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
		virtualtext = "■",
		-- update color values even if buffer is not focused
		-- example use: cmp_menu, cmp_docs
		always_update = false
	},
	-- all the sub-options of filetypes apply to buftypes
	buftypes = {},
}

require("indent_blankline").setup {
	show_trailing_blankline_indent = false
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

