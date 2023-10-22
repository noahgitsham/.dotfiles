return {
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
		"nvim-telescope/telescope.nvim", tag = "0.1.1",
		dependencies = "nvim-lua/plenary.nvim"
	},

	-- LSP
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"folke/trouble.nvim",

	-- CMP
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"ray-x/lsp_signature.nvim",

	-- Snippets
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",

	-- DAP
	"mfussenegger/nvim-dap",
	"jay-babu/mason-nvim-dap.nvim",
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap-python",

	-- Languages
	"windwp/nvim-ts-autotag",
	"folke/neodev.nvim",

	-- Misc
	"NvChad/nvim-colorizer.lua",
	"windwp/nvim-autopairs",
	"lukas-reineke/indent-blankline.nvim",
	"Aasim-A/scrollEOF.nvim",
	"folke/zen-mode.nvim",
	"folke/twilight.nvim",
	"ThePrimeagen/vim-be-good",
	"turbio/bracey.vim",
	"github/copilot.vim",
	"smjonas/live-command.nvim",

	-- Colours
	"Shatur/neovim-ayu",
	"arturgoms/moonbow.nvim",
	"ellisonleao/gruvbox.nvim",
	"rebelot/kanagawa.nvim",
	"loctvl842/monokai-pro.nvim",
	"sainnhe/gruvbox-material",

	-- Local Plugins
	{"/home/noah/programming/nvimPlugins/html-live.nvim", dev = true}
}
