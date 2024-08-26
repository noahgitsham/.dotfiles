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
	{"rcarriga/nvim-dap-ui",
		dependencies = {"nvim-neotest/nvim-nio"}
	},
	"mfussenegger/nvim-dap-python",
	"theHamsta/nvim-dap-virtual-text",

	-- Languages
	"Zeioth/compiler.nvim",
	"folke/neodev.nvim",
	"windwp/nvim-ts-autotag",
	"lervag/vimtex",
	"mfussenegger/nvim-jdtls",
	"hitsmaxft/vim-nix",

	-- Git
	"lewis6991/gitsigns.nvim",

	-- UI
	"nvim-lualine/lualine.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"Aasim-A/scrollEOF.nvim",
	"NvChad/nvim-colorizer.lua",
	"folke/zen-mode.nvim",
	"folke/twilight.nvim",
	"amarakon/nvim-unfocused-cursor",

	-- Colours
	"Shatur/neovim-ayu",
	"arturgoms/moonbow.nvim",
	"ellisonleao/gruvbox.nvim",
	"rebelot/kanagawa.nvim",
	"loctvl842/monokai-pro.nvim",
	"sainnhe/gruvbox-material",
	"savq/melange-nvim",
	"jaredgorski/fogbell.vim",
	"mcchrish/zenbones.nvim",
	"chriskempson/vim-tomorrow-theme",
	"sjl/badwolf",
	"sam4llis/nvim-tundra",
	"rktjmp/lush.nvim",

	-- Misc
	"ThePrimeagen/vim-be-good",
	--"github/copilot.vim",
	"smjonas/live-command.nvim",
	{
		"turbio/bracey.vim",
		build = "npm install --prefix server"
	},
	"luckasRanarison/nvim-devdocs",
	--{
	--	"glacambre/firenvim",
	--	-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
	--	lazy = not vim.g.started_by_firenvim,
	--	build = function()
	--		vim.fn["firenvim#install"](0)
	--	end,
	--	init = function ()
	--		vim.o.laststatus = 2
	--		vim.g.firenvim_config = {
	--			globalSettings = {
	--				takeover = "never",
	--				cmdline = "neovim",
	--			},
	--		}
	--	end
	--},

	-- Local Plugins
	{"pluginbynoah/inbar.nvim", dev = true },
}
