local reading = false
function ToggleReadingMode()
	if reading then -- Code mode
		vim.opt.linebreak = false
		vim.opt.wrap = false
	else -- Reading mode
		vim.opt.linebreak = true
		vim.opt.wrap = true
	end
	reading = not reading
end

vim.api.nvim_create_user_command("LineToggle", "lua ToggleReadingMode()", {})
