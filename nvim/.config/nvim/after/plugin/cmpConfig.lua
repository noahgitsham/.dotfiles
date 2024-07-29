local cmp = require("cmp")
local luasnip = require("luasnip")

-- Customisable globals
local maxEntryWidth = 30

luasnip.config.setup()

local cmp_kinds = {
	Function = "func",
	Field = "field",
	Text = "text",
	Enum = "enum",
	EnumMember = "enumm",
	Variable = "var",
	Struct = "strct",
	Snippet = "snip",
	Keyword = "kwd",
	Constant = "const",
	Class = "class",
	Module = "mod",
	File = "file",
	Folder = "fldr",
	Interface = "intfc",
	Reference = "ref",
}

cmp.setup {
	formatting = {
		format = function(entry, vim_item)
			-- Format Kinds
			vim_item.kind = cmp_kinds[vim_item.kind] or vim_item.kind
			vim_item.kind = "[" .. string.upper(vim_item.kind) .. "]"

			-- Format main text
			if string.len(vim_item.abbr) > maxEntryWidth then
				vim_item.abbr = string.sub(vim_item.abbr, 1, maxEntryWidth - 3) .. "..."
			end

			return vim_item
		end,
	},
	view = {
		entries = {name = "custom", selection_order = "near_cursor"}
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<Tab>'] = cmp.mapping(function(fallback)
			--if vim.g.copilot_enabled 
			--local copilot_keys = vim.fn['copilot#Accept']()
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			--elseif vim.g.copilot_enabled and vim.fn['copilot#GetDisplayedSuggestion']().text ~= '' and copilot_keys ~= "" and type(copilot_keys) == 'string' then
			--	vim.api.nvim_feedkeys(copilot_keys, 'i', true)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	preselect = cmp.PreselectMode.None,
	sources = {
		{name = "nvim_lsp"},
		{name = "luasnip"},
		--{name = "nvim_lsp_signature_help"},
		{name = "path"},
		{name = "buffer", keyword_length = 5},
	},
	sorting = {
		comparators = {
			cmp.config.compare.exact,
			cmp.config.compare.offset,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.kind,
			cmp.config.compare.locality,
		},
	},
}

require("lsp_signature").setup {
	bind = true,
	handler_opts = {
		border = "none"
	},
	hint_enable = false,
}
