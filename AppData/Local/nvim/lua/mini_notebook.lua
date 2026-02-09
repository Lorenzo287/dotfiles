-- Minimal notebook integration for mini.ai and mini.hipatterns
-- Extracted from NotebookNavigator.nvim

local M = {}

-- ===== Utils =====
local function get_cell_marker(bufnr, cell_markers)
	local ft = vim.bo[bufnr].filetype

	if ft == nil or ft == "" then
		print("[mini_notebook] Empty filetype")
	end

	local user_opt_cell_marker = cell_markers[ft]
	if user_opt_cell_marker then
		return user_opt_cell_marker
	end

	-- use double percent markers as default for cell markers
	if not vim.bo.commentstring then
		error("There's no cell marker and no commentstring defined for filetype " .. ft)
	end
	local cstring = string.gsub(vim.bo.commentstring, "^%%", "%%%%")
	local double_percent_cell_marker = cstring:format("%%")
	return double_percent_cell_marker
end

-- ===== Mini.ai spec =====
M.miniai_spec = function(opts, cell_markers)
	local cell_marker = get_cell_marker(0, cell_markers)

	local start_line = vim.fn.search("^" .. cell_marker, "bcnW")

	-- Just in case the notebook is malformed and doesn't have a cell marker at the start.
	if start_line == 0 then
		start_line = 1
	else
		if opts == "i" then
			start_line = start_line + 1
		end
	end

	local end_line = vim.fn.search("^" .. cell_marker, "nW") - 1
	if end_line == -1 then
		end_line = vim.fn.line("$")
	end

	local last_col = math.max(vim.fn.getline(end_line):len(), 1)

	local from = { line = start_line, col = 1 }
	local to = { line = end_line, col = last_col }

	return { from = from, to = to }
end

-- ===== Mini.hipatterns spec =====
M.minihipatterns_spec = function(cell_markers, hl_group)
	local notebook_cells = {
		pattern = function(buf_id)
			local cell_marker = get_cell_marker(buf_id, cell_markers)
			if cell_marker then
				local regex_cell_marker = string.gsub("^" .. cell_marker, "%%", "%%%%")
				return regex_cell_marker
			else
				return nil
			end
		end,
		group = "",
		extmark_opts = {
			virt_text = {
				{
					"───────────────────────────────────────────────────────────────",
					hl_group,
				},
			},
			line_hl_group = hl_group,
			hl_eol = true,
		},
	}
	return notebook_cells
end

return M
