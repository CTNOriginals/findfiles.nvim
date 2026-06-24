local buf = vim.api.nvim_create_buf(false, true)

local function updateBuffer()
	---@type string
	local lines = {}

	for _, opt in ipairs(Options) do
		lines = lines .. opt.field .. ": " .. tostring(OptionValues[opt.field]) .. "\n"
	end

	return vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
		"optioins:",
		"f) follow",
		"h) hidden",
		"i) no_ignore",
	})
end

function CreateWindow()
	local buf = createBuffer()

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 24,
		height = 4,
		row = 2,
		col = math.floor((vim.o.columns - 24) / 2),
		style = "minimal",
		border = "rounded",
		focusable = true,
	})

	vim.api.nvim_buf_set_keymap(buf, "n", "f", "", {
		noremap = true,
	})
end
