require("gitsigns").setup {
	on_attach = function()
		vim.keymap.set({"n", "v"}, "<leader>gs", function() vim.cmd("Gitsigns stage_hunk") end)
		vim.keymap.set("n", "<leader>gd", function() vim.cmd("Gitsigns diffthis") end)
		vim.keymap.set("n", "<leader>gp", function() vim.cmd("Gitsigns preview_hunk_inline") end)
		vim.keymap.set("n", "<leader>gu", function() vim.cmd("Gitsigns undo_stage_hunk") end)
	end
}

