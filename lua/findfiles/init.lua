require("findfiles.state")
local ui = require("findfiles.ui")

vim.keymap.set("n", "<leader>f", ui.createWindow, {
	desc = "[f]ind files",
})
