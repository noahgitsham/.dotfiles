local reading = false
function ToggleReadingMode()
	if reading then -- Code mode
		vim.opt.scrolloff = false
		vim.opt.linebreak = false
		reading = false
	else -- Reading mode
		vim.opt.scrolloff = true
		vim.opt.linebreak = true
		reading = true
	end
end

vim.api.nvim_create_user_command("LineToggle", "lua ToggleReadingMode()", {})
