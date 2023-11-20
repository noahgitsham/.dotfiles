return {
	"https://github.com/L3afMe/rose-pine-sepia-nvim",
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	"nvim-treesitter/playground",

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-lua/plenary.nvim"
	},

	-- LSP
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"folke/trouble.nvim",
	{"j-hui/fidget.nvim", event = "LspAttach", tag = "legacy"},

	-- Autocomplete
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	{ "ray-x/lsp_signature.nvim", event = "VeryLazy" },
	"windwp/nvim-autopairs",

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets"
	},
	"saadparwaiz1/cmp_luasnip",

	-- DAP
	"mfussenegger/nvim-dap",
	"jay-babu/mason-nvim-dap.nvim",
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap-python",
	"theHamsta/nvim-dap-virtual-text",

	-- Languages
	"windwp/nvim-ts-autotag",
	"folke/neodev.nvim",
	"lervag/vimtex",

	-- Git
	"lewis6991/gitsigns.nvim",

	-- Misc
	"lukas-reineke/indent-blankline.nvim",
	"ThePrimeagen/vim-be-good",
	"github/copilot.vim",
	"smjonas/live-command.nvim",
	{
		"turbio/bracey.vim",
		build = "npm install --prefix server"
	},
	{
		'glacambre/firenvim',
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end
	},

	-- Visuals
	"Aasim-A/scrollEOF.nvim",
	"NvChad/nvim-colorizer.lua",
	"folke/zen-mode.nvim",
	"folke/twilight.nvim",

	-- Colours
	"Shatur/neovim-ayu",
	"arturgoms/moonbow.nvim",
	"ellisonleao/gruvbox.nvim",
	"rebelot/kanagawa.nvim",
	"loctvl842/monokai-pro.nvim",
	"sainnhe/gruvbox-material",
	"cocopon/iceberg.vim",

	-- Local Plugins
	{"noahgitsham/inbar.nvim", dev = true }
}
