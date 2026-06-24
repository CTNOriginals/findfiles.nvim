local buf = vim.api.nvim_create_buf(false, true)

---@return string[]
local function updateBuffer()
	local lines = {
		"options:",
	}

	for _, opt in ipairs(Options) do
		local line = ""
		line = line .. opt.key .. ") "
		line = line .. opt.field .. ": "
		line = line .. tostring(OptionValues[opt.field] or false)

		table.insert(lines, line)
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	return lines
end

local function createWindow()
	local lines = updateBuffer()
	-- vim.o.linespace

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 24,
		height = #lines,
		row = math.floor(vim.o.winwidth),
		col = math.floor((vim.o.columns - 24) / 2),
		style = "minimal",
		border = "single",
		focusable = true,
	})

	return win
end

for _, opt in ipairs(Options) do
	vim.api.nvim_buf_set_keymap(buf, "n", opt.key, "", {
		noremap = true,
		callback = function()
			OptionValues[opt.field] = not OptionValues[opt.field] or false
			updateBuffer()
		end,
	})
end

return {
	updateBuffer = updateBuffer,
	createWindow = createWindow,
}
