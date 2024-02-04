local ls = require("luasnip")
ls.filetype_extend("htmldjango", { "html" })
ls.setup()
require("luasnip.loaders.from_vscode").lazy_load()
