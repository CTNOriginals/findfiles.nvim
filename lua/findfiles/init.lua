M = {}

require("findfiles.state")
local ui = require("findfiles.ui")

-- M.setup = function() end

vim.keymap.set("n", "<leader>F", ui.createWindow, {
	desc = "[F]ind files",
})

return M
