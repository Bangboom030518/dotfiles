if not vim.g.vscode then
	return
end

local function call_vscode_cmd(cmd)
	vim.api.nvim_call_function("VSCodeNotify", { cmd })
end

local function get_vscode_cmd(cmd)
	return function()
		call_vscode_cmd(cmd)
	end
end

vim.keymap.set("n", "<leader>z", get_vscode_cmd("extension.toggleZenMode"), { desc = "[Z]en Mode" })

vim.keymap.set("n", "gd", get_vscode_cmd("editor.action.revealDefinition"), { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gr", get_vscode_cmd("editor.action.goToReferences"), { desc = "[G]oto [R]eferences" })

vim.keymap.set("n", "<leader>rn", get_vscode_cmd("editor.action.rename"), { desc = "[R]e[n]ame" })
vim.keymap.set("n", "<leader>ca", get_vscode_cmd("editor.action.refactor"), { desc = "[C]ode [A]ction" })

vim.keymap.set("n", "[d", get_vscode_cmd("editor.action.marker.next"), { desc = "Goto Next [D]iagnostic" })
vim.keymap.set("n", "]d", get_vscode_cmd("editor.action.marker.prev"), { desc = "Goto Previous [D]iagnostic" })

vim.keymap.set(
	"n",
	"<leader>ds",
	get_vscode_cmd("editor.action.accessibleViewGoToSymbol"),
	{ desc = "[D]ocument [S]ymbols" }
)
vim.keymap.set("n", "<leader>ws", get_vscode_cmd("workbench.action.showAllSymbols"), { desc = "[W]orkspace [S]ymbols" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

vim.keymap.set("n", "<leader>ft", get_vscode_cmd("workbench.view.explorer"), { desc = "[F]ile [T]ree" })

vim.keymap.set("n", "<leader>ls", get_vscode_cmd("liveshare.session.focus"), { desc = "[L]ive [S]hare" })

vim.keymap.set("n", "<leader>h", function()
	call_vscode_cmd("workbench.action.closeSidebar")
	call_vscode_cmd("workbench.action.closePanel")
end, { desc = "[H]ide Panels" })

vim.keymap.set("n", "<leader>pp", get_vscode_cmd("workbench.action.showCommands"), { desc = "Command [P]alette" })

vim.keymap.set("n", "<leader>fw", get_vscode_cmd("workbench.action.openRecent"), { desc = "[F]ind [W]orkspace" })

vim.keymap.set("n", "tn", ":tabn<CR>", { desc = "[N]ext [T]ab" })
vim.keymap.set("n", "tp", ":tabp<CR>", { desc = "[P]revious [T]ab" })

vim.api.nvim_create_user_command("Git", function()
	call_vscode_cmd("workbench.scm.focus")
end, {})
