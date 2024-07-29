-- Lazy Install Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Config
require("lazy").setup("plugins", {
	dev = {
		path = "~/programming/projects/plugins/nvim",
	},
	change_detection = {
		notify = false,
	},
	ui ={
		icons = {
			cmd = "",
			config = "",
			event = "",
			favorite = "",
			ft = "",
			init = "",
			import = "",
			keys = "",
			lazy = "",
			loaded = "+",
			not_loaded = "-",
			plugin = "",
			runtime = "",
			require = "",
			source = "",
			start = "",
			task = "--",
			list = { "*", "*", "*", "*", },
		}
	}
})

vim.keymap.set("n", "<leader>lz", function () vim.api.nvim_command("Lazy") end)
