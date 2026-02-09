local M = {}
local Menu = require("nui.menu")

M.delete = function(state)
	local node = state.tree and state.tree:get_node()
	if not node then
		vim.notify("No node under cursor", vim.log.levels.WARN)
		return
	end

	local path = node:get_id()
	local prompt = " Trash " .. node.name .. " "
	local width = math.max(20, #prompt + 4)

	local function refresh_and_notify(msg, level)
		vim.schedule(function()
			pcall(function()
				require("neo-tree.command").execute({ action = "refresh" })
			end)
			if msg then
				vim.notify(msg, level or vim.log.levels.INFO)
			end
		end)
	end

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

			local method = node.type == "directory" and "DeleteDirectory" or "DeleteFile"
			local powershell_cmd = string.format(
				'powershell.exe -NoProfile -Command "Add-Type -AssemblyName Microsoft.VisualBasic; '
					.. "[Microsoft.VisualBasic.FileIO.FileSystem]::%s('%s', 'OnlyErrorDialogs', 'SendToRecycleBin')\"",
				method,
				path
			)

			local error_output = {}
			vim.fn.jobstart(powershell_cmd, {
				on_stderr = function(_, data)
					for _, line in ipairs(data) do
						if line ~= "" then
							table.insert(error_output, line)
						end
					end
				end,
				on_exit = function(_, code)
					if code == 0 then
						refresh_and_notify("Trashed: " .. node.name)
					else
						-- Simplified error matching
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

						refresh_and_notify("Failed: " .. msg, vim.log.levels.ERROR)
					end
				end,
			})
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
