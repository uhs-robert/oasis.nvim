-- lua/oasis/init.lua
local M = {}

--- Apply Oasis using a palette module name (no prefix).
--- Examples:
---   require('oasis').apply('oasis_midnight')
---   require('oasis').apply('oasis')         -- default
---@param palette_name string|nil
function M.apply(palette_name)
	palette_name = palette_name or vim.g.oasis_palette or "oasis"

	-- Load palette
	local ok, c = pcall(require, "oasis.color_palettes." .. palette_name)
	if not ok then
		error(('Oasis: palette "%s" not found: %s'):format(palette_name, c))
	end

	-- Build the colorscheme
	local build = require("oasis.theme_generator")
	local spec = build(c)
	require("lush")(spec)

	-- You can set a stable name ('oasis') or ecode the variant; both work.
	vim.g.colors_name = "oasis" -- or ('oasis-' .. palette_name)
end

-- :Oasis <palette> command with completion from lua/oasis/color_palettes/*.lua
vim.api.nvim_create_user_command("Oasis", function(opts)
	M.apply(opts.args ~= "" and opts.args or nil)
end, {
	nargs = "?",
	complete = function()
		-- Glob all palette files on runtimepath
		local paths = vim.fn.globpath(vim.o.rtp, "lua/oasis/color_palettes/*.lua", false, true)
		local out = {}
		for _, p in ipairs(paths) do
			-- handle / or \ separators; capture the basename
			local name = p:match("[\\/]color_palettes[\\/](.+)%.lua$")
			if name and name ~= "init" then
				table.insert(out, name)
			end
		end
		table.sort(out)
		return out
	end,
})

return M
