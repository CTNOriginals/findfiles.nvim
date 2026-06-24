M = {}

require("findfiles.state")
local ui = require("findfiles.ui")

M.setup = function() end

vim.keymap.set("n", "<leader>f", ui.createWindow, {
	desc = "[f]ind files",
})

return M
