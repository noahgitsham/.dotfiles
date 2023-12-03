local command = require("commands")
local function getPackagePath(package)
	--return require("mason-registry").get_package(package):get_install_path()
	return "~/.local/share/nvim/mason/packages/" .. package
end

-- DAP
local dap = require("dap")

-- Mason DAP
--require("mason-nvim-dap").setup {
--	ensure_installed = {"python", "cppdbg", "codelldb"},
--	automatic_installation = true,
--	handlers = {
--		function(config)
--			require('mason-nvim-dap').default_setup(config)
--		end,
--		python = function (config)
--			config.adapters = {
--				console = "integratedTerminal"
--			}
--		end,
--	}
--}

-- Language Setups

require("dap-python").setup(getPackagePath("debugpy") .. "/venv/bin/python")

-- DAP UI
local dapui = require("dapui")
dapui.setup {
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.4 },
				{ id = "stacks", size = 0.2 },
				{ id = "watches", size = 0.2 },
				{ id = "breakpoints", size = 0.2 },
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{ id = "console", size = 0.7 },
				{ id = "repl", size = 0.3 },
			},
			position = "bottom",
			size = 15,
		},
	},
	controls = {
		element = "repl",
		enabled = false,
	},
}

-- DAP Virtual Text
require("nvim-dap-virtual-text").setup {
	
}

-- Keymaps
vim.keymap.set("n", "<F5>", function() -- Start debugging
	dap.continue()
	dapui.open()
end)
vim.keymap.set("n", "<F6>", function() -- Stop Debugging
	dap.terminate()
	dapui.close()
end)

vim.keymap.set("n", "<F9>", function() dap.step_into() end)
vim.keymap.set("n", "<F10>", function() dap.step_over() end)
vim.keymap.set("n", "<F11>", function() dap.step_out() end)

vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>B", function()
	vim.ui.input({ prompt = "Breakpoint condition: " },
		function (choice)
			dap.set_breakpoint(choice)
		end)
end)
vim.keymap.set("n", "<leader>cb", function()
	vim.ui.input({ prompt = "Clear all breakpoints? (Y/n): " },
		function (choice)
			choice = string.lower(choice)
			if choice == "y" or choice == "" then
				dap.clear_breakpoints()
			end
		end
	)
	--yesNoDialog("Clean all breakpoints", "y", dap.clear_breakpoints())
end)

vim.keymap.set("n", "<leader>db", function() dapui.toggle() end)
