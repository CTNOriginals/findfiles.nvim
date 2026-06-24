M = {}

---@class OptionField
---@field field string
---@field key string

---@type OptionField[]
M.Options = {
	{ field = "hidden", key = "h" },
	{ field = "follow", key = "f" },
	{ field = "no_ignore", key = "i" },
	{ field = "no_ignore_parent", key = "p" },
}

---@type {string: boolean}
M.OptionValues = {}

local telescope = require("telescope.builtin")
function M.DoFindFiles(win)
	vim.api.nvim_win_close(win, true)
	telescope.find_files(M.OptionValues)
end

-- vim.defer_fn(function()
-- 	local ui = require("findfiles.ui")
-- 	local win = ui.createWindow()
-- end, 100)

return M
