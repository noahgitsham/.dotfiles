-- Native lsp options

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
	setup_jsonls = true,
	-- With lspconfig, Neodev will automatically setup your lua-language-server
	-- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
	-- in your lsp start options
	lspconfig = true,
	pathStrict = true,
}

-- Mason
require("mason").setup()

vim.keymap.set("n", "<leader>ms", function () vim.api.nvim_command("Mason") end)

require("mason-lspconfig").setup()

local default_on_attach = function(client,bufnr)
	-- Mappings.
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ef", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<tab>", vim.lsp.buf.hover, bufopts)
	client.server_capabilities.semanticTokensProvider = nil
end

local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers {
	function(server_name)
		lspconfig[server_name].setup {
			on_attach = default_on_attach,
			capabilities = default_capabilities,
		}
	end,

	["pylsp"] = function ()
		lspconfig["pylsp"].setup {
			on_attach = default_on_attach,
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {enabled = false},
					},
				},
			},
			capabilities = default_capabilities,
		}
		vim.g.python_recommended_style = 0
	end,

	["clangd"] = function ()
		lspconfig["clangd"].setup {
			on_attach = default_on_attach,
			cmd = {"clangd", "--offset-encoding=utf-16"},
			capabilities = default_capabilities,
		}
	end,

	["lua_ls"] = function ()
		lspconfig["lua_ls"].setup {
			on_attach = default_on_attach,
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
				},
			},
			capabilities = default_capabilities,
		}
	end,

	["jdtls"] = function () end
}

-- Trouble
require("trouble").setup {
	icons = {
		indent = {
			fold_open = "v",
			fold_closed = ">",
		},
	},
	indent_lines = false, -- add an indent guide below the fold icons
	use_diagnostic_signs = true,
	warn_no_results = false
	
}

vim.keymap.set("n","<leader>er", ":Trouble diagnostics toggle<CR>")

-- Vimtex
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_syntax_enabled = 0


-- Fidget
require("fidget").setup {
	text = {
		done = "DONE:"
	}
}
