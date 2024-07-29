vim.opt.termguicolors = true

-- Set colour scheme
local function setColors(termColo, ttyColo)
	if os.getenv("DISPLAY") then
		vim.cmd.colorscheme(termColo)
	elseif ttyColo then
		vim.cmd.colorscheme(ttyColo)
	end
	-- Else default colorscheme
end

setColors("Tomorrow", "default")
