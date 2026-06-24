---@class OptionField
---@field field string
---@field key string

---@type OptionField[]
Options = {
	{ field = "hidden", key = "h" },
	{ field = "follow", key = "f" },
	{ field = "no_ignore", key = "i" },
}

---@type {string: boolean}
OptionValues = {}

vim.defer_fn(function()
	print("here")
end, 1000)
