return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"microsoft/vscode-js-debug",
        "mxsdev/nvim-dap-vscode-js",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")
		ui.setup()
		require("nvim-dap-virtual-text").setup()
		require("dap-vscode-js").setup({
            debugger_path = "/home/rst/.local/share/nvim/lazy/vscode-js-debug",
			adapters = { "pwa-node" },
		})

		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Debug Jest Tests",
				runtimeExecutable = "node",
				runtimeArgs = {
					"${workspaceFolder}/node_modules/.bin/jest",
					"${file}",
					"--runInBand",
				},
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				internalConsoleOptions = "neverOpen",
			},
		}

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F6>", dap.restart)

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
