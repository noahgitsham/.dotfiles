local ls = require("luasnip")
ls.setup()
require("luasnip.loaders.from_vscode").lazy_load()

ls.snippets = {
	latex = {
		ls.parser.parse_snippet("a4", "\\documentclass[a4paper]{article}\n\n\\begin{document}\n$1\n\\end{document}")
	}
}
