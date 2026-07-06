local M = {}
local Menu = require("nui.menu")
local env = require("utils.env")

local function refresh_and_notify(node_name, msg, level)
	vim.schedule(function()
		pcall(function()
			require("neo-tree.command").execute({ action = "refresh" })
		end)
		vim.notify(msg, level or vim.log.levels.INFO)
	end)
end

local function trash_path(path, node, on_done)
	if env.is_windows and env.executable("powershell.exe") then
		local method = node.type == "directory" and "DeleteDirectory" or "DeleteFile"
		local escaped_path = path:gsub("'", "''")
		local command = string.format(
			"Add-Type -AssemblyName Microsoft.VisualBasic; "
				.. "[Microsoft.VisualBasic.FileIO.FileSystem]::%s('%s', 'OnlyErrorDialogs', 'SendToRecycleBin')",
			method,
			escaped_path
		)

		local error_output = {}
		vim.fn.jobstart({ "powershell.exe", "-NoProfile", "-Command", command }, {
			on_stderr = function(_, data)
				for _, line in ipairs(data or {}) do
					if line ~= "" then
						table.insert(error_output, line)
					end
				end
			end,
			on_exit = function(_, code)
				if code == 0 then
					on_done(true, "Trashed: " .. node.name)
				else
					local err = table.concat(error_output, " ")
					local map = {
						["used by another process"] = "File in use",
						["Access denied"] = "Access denied",
						["UnauthorizedAccess"] = "Access denied",
						["cannot find"] = "Not found",
					}

					local msg = "Unknown error"
					for pattern, simple_msg in pairs(map) do
						if err:find(pattern) then
							msg = simple_msg
							break
						end
					end
					on_done(false, "Failed: " .. msg)
				end
			end,
		})
		return
	end

	if env.executable("gio") then
		vim.fn.jobstart({ "gio", "trash", path }, {
			on_exit = function(_, code)
				on_done(code == 0, code == 0 and "Trashed: " .. node.name or "Failed: gio trash failed")
			end,
		})
		return
	end

	if env.executable("trash-put") then
		vim.fn.jobstart({ "trash-put", path }, {
			on_exit = function(_, code)
				on_done(code == 0, code == 0 and "Trashed: " .. node.name or "Failed: trash-put failed")
			end,
		})
		return
	end

	on_done(false, "Trash unavailable: install gio or trash-cli")
end

M.delete = function(state)
	local node = state.tree and state.tree:get_node()
	if not node then
		vim.notify("No node under cursor", vim.log.levels.WARN)
		return
	end

	local path = node:get_id()
	local prompt = " Trash " .. node.name .. " "
	local width = math.max(20, #prompt + 4)

	local menu
	menu = Menu({
		relative = "cursor",
		position = { row = 1, col = 0 },
		size = { width = width, height = 2 },
		border = {
			style = BORDER,
			text = { top = prompt, top_align = "center" },
		},
	}, {
		lines = { Menu.item(" Yes"), Menu.item(" No") },
		keymap = {
			focus_next = { "j", "<Down>" },
			focus_prev = { "k", "<Up>" },
			close = { "<Esc>", "<C-c>", "q" },
			submit = { "<CR>" },
		},
		on_submit = function(item)
			menu:unmount()
			if item.text:find("No") then
				return
			end

			trash_path(path, node, function(ok, msg)
				refresh_and_notify(node.name, msg, ok and vim.log.levels.INFO or vim.log.levels.ERROR)
			end)
		end,
	})
	menu:mount()
end

M.delete_old = function(state)
	local node = state.tree:get_node()
	local path = node:get_id()

	local confirmed = vim.fn.confirm("Delete " .. node.name .. "?", "&Yes\n&No", 2)
	if confirmed ~= 1 then
		return
	end

	-- Use recycle-bin utility to move the file to the Recycle Bin
	vim.fn.system({ "recycle-bin", path })
	require("neo-tree.ui.renderer").redraw(state)
end

return M
