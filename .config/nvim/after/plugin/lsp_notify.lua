if vim.g.vscode then
	return
end

---@class LspNotification
---@field title string
---@field message string
---@field notification notify.Notification
---@field spinner integer|nil

---@class LspNotifications
---@field lsp_name string
---@field messages { [lsp.ProgressToken]: LspNotification }

---@type { [integer]: LspNotifications }
local lsp_notifications = {}

local spinner_frames = {
	"⠋",
	"⠙",
	"⠹",
	"⠸",
	"⠼",
	"⠴",
	"⠦",
	"⠧",
	"⠇",
	"⠏",
}

local notify = require("notify")

---@param notification LspNotification
local function update_spinner(notification)
	if notification.spinner then
		notification.spinner = (notification.spinner + 1) % #spinner_frames

		notification.notification =
			notify(nil, nil, { replace = notification.notification, icon = spinner_frames[notification.spinner] })

		vim.defer_fn(function()
			update_spinner(notification)
		end, 100)
	end
end

local function format_message(message, percentage)
	return (percentage and percentage .. "%\t" or "") .. (message or "")
end

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local client_id = ctx.client_id

	local val = result.value

	if not val.kind then
		return
	end

	if not lsp_notifications[client_id] then
		local name = vim.lsp.get_client_by_id(client_id).name

		if not name then
			return
		end

		lsp_notifications[client_id] = {
			lsp_name = name,
			messages = {},
			notification = nil,
		}
	end

	if not lsp_notifications[client_id].messages[result.token] then
		-- expect val.kind == "begin"
		local title = lsp_notifications[client_id].lsp_name .. ": " .. val.title
		local message = format_message(val.message, val.percentage)
		local spinner_frame = 1
		local notification = {
			title = title,
			message = message,
			spinner = spinner_frame,
		}

		notification.notification = notify(message, vim.log.levels.INFO, {
			icon = spinner_frames[spinner_frame],
			title = title,
			timeout = false,
		})

		lsp_notifications[client_id].messages[result.token] = notification
		update_spinner(lsp_notifications[client_id].messages[result.token])
	end

	local notification = lsp_notifications[client_id].messages[result.token]

	if val.kind == "report" then
		notification.message = format_message(val.message, val.percentage)
		notification.notification =
			notify(notification.message, vim.log.levels.INFO, { replace = notification.notification })
	elseif val.kind == "end" then
		lsp_notifications[client_id].messages[result.token].spinner = nil
		lsp_notifications[client_id].messages[result.token] = nil
		notify("Complete", vim.log.levels.INFO, { replace = notification.notification, timeout = 1000, icon = "✓" })
	end
end

local severity = {
	vim.log.levels.ERROR,
	vim.log.levels.WARN,
	vim.log.levels.INFO,
	vim.log.levels.INFO,
}

vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
	notify(method.message, severity[params.type])
end
