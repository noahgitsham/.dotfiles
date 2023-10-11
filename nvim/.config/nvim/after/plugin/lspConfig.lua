-- Native lsp options
--vim.highlight.create("SignColumn", {ctermbg=0, guibg=NONE}, false)
vim.api.nvim_set_hl(0, "SignColumn", {guibg=NONE})

local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


require("neodev").setup {
	library = {
		enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
		-- these settings will be used for your Neovim config directory
		runtime = true, -- runtime path
		types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
		plugins = true, -- installed opt or start plugins in packpath
		-- you can also specify the list of plugins to make available as a workspace library
		-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
	},
	-- With lspconfig, Neodev will automatically setup your lua-language-server
	-- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
	-- in your lsp start options
	lspconfig = true,
	pathStrict = true,
}

-- Mason
require("mason").setup()

require("mason-lspconfig").setup {
	ensure_installed = {"bashls",
			    "clangd",
			    "cssls",
			    "html",
			    "jsonls",
			    "lua_ls",
			    "pylsp",
			    "rust_analyzer"}
}

local on_attach = function(client,bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<tab>", vim.lsp.buf.hover, bufopts)
end

require("mason-lspconfig").setup_handlers {
	function(server_name)
		require("lspconfig")[server_name].setup {
			on_attach = on_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}
	end,

	["pylsp"] = function ()
		require("lspconfig")["pylsp"].setup {
			on_attach = on_attach,
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {enabled = false},
					}
				}
			}
		}
	end
}

require("trouble").setup {
	icons = false,
	fold_open = "v", -- icon used for open folds
	fold_closed = ">", -- icon used for closed folds
	indent_lines = false, -- add an indent guide below the fold icons
	use_diagnostic_signs = false,
}

vim.keymap.set("n","<leader>er", vim.cmd.TroubleToggle)
