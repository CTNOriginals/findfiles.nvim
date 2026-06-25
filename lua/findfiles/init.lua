---@class ff
local M = {}

require("findfiles.state")
local ui = require("findfiles.ui")
local config = require("findfiles.config")

M.opts = config.defaults

local isSetup = false

---@param opts ff.opts|nil
M.setup = function(opts)
	if opts then
		for key, val in pairs(opts) do
			M.opts[key] = val
		end
	end

	vim.keymap.set("n", M.opts.key, ui.createWindow, {
		desc = "find files",
	})

	isSetup = true
end

-- Make calling setup() optional
vim.defer_fn(function()
	if not isSetup then
		M.setup()
	end
end, 1000)

-- --Test ui on statup
-- vim.defer_fn(function()
-- 	local ui = require("findfiles.ui")
-- 	local win = ui.createWindow()
-- end, 100)

return M
