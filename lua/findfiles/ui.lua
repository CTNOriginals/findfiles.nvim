local buf = vim.api.nvim_create_buf(false, true)
local win = 0

local state = require("findfiles.state")
local icons = require("findfiles.icons")

---@return string[]
local function updateBuffer()
	local lines = {
		"options:",
	}
	local footer = {
		"",
		icons.keys.NL .. ") submit",
		icons.keys.Esc .. ") cancel",
	}

	for _, opt in ipairs(state.Options) do
		local line = ""
		line = line .. opt.key .. ") "
		line = line .. opt.field .. ": "
		line = line .. tostring(state.OptionValues[opt.field] or false)

		table.insert(lines, line)
	end

	for _, line in ipairs(footer) do
		table.insert(lines, line)
	end

	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	return lines
end

local function createWindow()
	local lines = updateBuffer()

	win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 32,
		height = #lines,
		row = math.floor((vim.o.lines - #lines) / 3),
		col = math.floor((vim.o.columns - 24) / 2),
		style = "minimal",
		-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		border = "rounded",
		title = " Find Files ",
		title_pos = "center",
		focusable = true,
	})

	vim.wo[win].cursorline = false
	vim.wo[win].cursorcolumn = false
	vim.wo[win].number = false
	vim.wo[win].signcolumn = "no"
	vim.bo[buf].modifiable = false
	vim.wo[win].winblend = 10
	vim.wo[win].winhl = "Normal:NormalFloat,FloatBorder:FloatBorder,Cursor:NormalFloat"

	return win
end

for _, opt in ipairs(state.Options) do
	vim.api.nvim_buf_set_keymap(buf, "n", opt.key, "", {
		noremap = true,
		callback = function()
			state.OptionValues[opt.field] = not state.OptionValues[opt.field] or false
			updateBuffer()
		end,
	})
end

vim.api.nvim_buf_set_keymap(buf, "n", "<cr>", "", {
	noremap = true,
	callback = function()
		state.DoFindFiles(win)
	end,
})
vim.api.nvim_buf_set_keymap(buf, "n", "<space>", "", {
	noremap = true,
	callback = function()
		state.DoFindFiles(win)
	end,
})

vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", "", {
	noremap = true,
	callback = function()
		vim.api.nvim_win_close(win, true)
	end,
})

return {
	updateBuffer = updateBuffer,
	createWindow = createWindow,
}
