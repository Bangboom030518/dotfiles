if vim.g.vscode then
	return
end

local null_ls = require("null-ls")

vim.opt.spelllang = "en_gb"
vim.opt.wrap = false

vim.api.nvim_create_user_command("WritingOn", function()
	vim.opt.spell = true
	vim.opt.linebreak = true
	vim.opt.wrap = true
	vim.g.writing_mode = true
	vim.notify("Writing Mode Enabled")
end, {})

vim.api.nvim_create_user_command("WritingOff", function()
	vim.opt.spell = false
	vim.opt.linebreak = false
	vim.opt.wrap = false
	vim.g.writing_mode = false
	vim.notify("Writing Mode Disabled")
end, {})
