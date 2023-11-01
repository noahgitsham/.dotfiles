-- DAP
local dap = require("dap")

-- Mason DAP
require("mason-nvim-dap").setup {
	ensure_installed = {"python", "cppdbg", "codelldb"},
	automatic_installation = true,
	handlers = {
		function(config)
			require('mason-nvim-dap').default_setup(config)
		end
	}
}

-- Language Setups
local function getPackagePath(package)
	--return registry.get_package(package):get_install_path()
	return "~/.local/share/nvim/mason/packages/" .. package
end

require("dap-python").setup(getPackagePath("debugpy") .. "/venv/bin/python")
vim.g.python_recommended_style = 0

-- DAP UI
local dapui = require("dapui")
dapui.setup {
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.4 },
				{ id = "breakpoints", size = 0.3 },
				{ id = "watches", size = 0.3 }
			},
			position = "left",
			size = 40
		},
		{
			elements = {
				{ id = "repl", size = 1 },
			},
			position = "bottom",
			size = 15
		}
	},
	controls = {
		element = "repl",
		enabled = false,
	},
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

vim.keymap.set("n", "<F10>", function() dap.step_over() end)
vim.keymap.set("n", "<F11>", function() dap.step_into() end)
vim.keymap.set("n", "<F12>", function() dap.step_out() end)

vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>B", function() dap.clear_breakpoints() end)

vim.keymap.set("n", "<leader>db", function() dapui.toggle() end)
