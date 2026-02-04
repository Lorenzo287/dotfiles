local M = {}

M.delete = function(state)
	local node = state.tree and state.tree:get_node()
	if not node then
		vim.notify("No node under cursor", vim.log.levels.WARN)
		return
	end

	local path = node:get_id()
	local prompt = "Delete " .. node.name .. "?"

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

	local function exists(p)
		return vim.loop.fs_stat(p) ~= nil
	end

	vim.ui.select({ "Yes", "No" }, { prompt = prompt }, function(choice)
		if choice ~= "Yes" then
			return
		end

		if vim.fn.executable("recycle-bin") == 1 then
			local cmd = { "recycle-bin", path }
			vim.fn.jobstart(cmd, {
				on_exit = function(_, exit_code, _)
					if exit_code == 0 then
						refresh_and_notify("Moved to Recycle Bin: " .. path, vim.log.levels.INFO)
					else
						refresh_and_notify(
							"Failed to move to recycle-bin (exit " .. tostring(exit_code) .. ")",
							vim.log.levels.ERROR
						)
					end
				end,
			})
			return
		end

		-- Fallback to vim.fn.delete (scheduled so we don't block UI work)
		vim.schedule(function()
			local ok
			if node.type == "directory" then
				ok = pcall(vim.fn.delete, path, "rf")
			else
				ok = pcall(vim.fn.delete, path)
			end

			if not ok then
				vim.notify("Error deleting " .. path, vim.log.levels.ERROR)
				return
			end

			if exists(path) then
				vim.notify("Failed to delete " .. path, vim.log.levels.ERROR)
			else
				refresh_and_notify("Deleted: " .. path, vim.log.levels.INFO)
			end
		end)
	end)
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
