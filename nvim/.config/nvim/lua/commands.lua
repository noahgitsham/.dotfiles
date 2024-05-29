-- Line wrap toggle
local reading = false
function ToggleReadingMode()
	if reading then -- Code mode
		vim.opt_local.linebreak = false
		vim.opt_local.wrap = false
	else -- Reading mode
		vim.opt_local.linebreak = true
		vim.opt_local.wrap = true
	end
	reading = not reading
end

vim.api.nvim_create_user_command("WrapToggle", "lua ToggleReadingMode()", {})

-- Plugin development
vim.api.nvim_create_user_command("P", function (table)
	local lua = vim.fn.luaeval(table.args)
	vim.print(lua)
end, {nargs = "*"})

function YesNoDialog(message, default, yesFunc, noFunc)
	vim.validate {
		message = {message, "string"},
		age = {default, "string"},
		yesFunc = {yesFunc, {"function", "nil"}},
		noFunc = {noFunc, {"function", "nil"}},
	}

	local yn
	if default == "y" then
		yn = "(Y/n)"
	elseif default == "n" then
		yn = "(y/N)"
	elseif default == "" then
		yn = "(y/n)"
	else
		error "default must take value of \"y\", \"n\", or \"\" "
	end

	vim.ui.input({ prompt = message.. " " .. yn .. ": " },
		function (choice)
			if choice == "" then
				choice = default
			end
			choice = string.lower(choice)
			print(choice)
			if yesFunc and choice == "y" then
				yesFunc()
			elseif noFunc and choice == "n" then
				print("Here")
				noFunc()
			end
		end
	)
end

vim.api.nvim_create_user_command("E", function () vim.cmd("Explore") end, {})
vim.api.nvim_create_user_command("V", function () vim.cmd("Vexplore") end, {})
