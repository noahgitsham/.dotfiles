local autopairs = require("nvim-autopairs")
autopairs.setup {
	-- disable_filetypes = { "TelescopePrompt" },
	ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
	enable_check_bracket_line = false,
	check_ts = true,
}


-- <CR> in brackets
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
require("cmp").event:on('confirm_done', cmp_autopairs.on_confirm_done())


