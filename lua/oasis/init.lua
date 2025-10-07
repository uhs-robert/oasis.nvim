-- lua/oasis/init.lua
local M = {}
local config = require('oasis.config')

--- Setup Oasis with user configuration and apply the theme
--- Examples:
---   require('oasis').setup({
---     style = "lagoon",  -- Shorthand for "oasis_lagoon"
---     useLegacyComments = true,
---     palette_overrides = { oasis_desert = { syntax = { comment = "#87CEEB" } } },
---     highlight_overrides = { Comment = { fg = "#AABBCC" } }
---   })
---@param user_config table|nil User configuration
function M.setup(user_config)
	config.setup(user_config)
	M.apply()
end

--- Apply Oasis using a palette module name (no prefix).
--- Examples:
---   require('oasis').apply('oasis_midnight')
---   require('oasis').apply('oasis')         -- default
---@param palette_name string|nil
function M.apply(palette_name)
	-- Reset
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.opt.background = "dark"
	palette_name = palette_name or config.get_palette_name() or vim.g.oasis_palette or "oasis_lagoon"
	vim.g.colors_name = palette_name:gsub("_", "-") -- Convert to hyphen format to match colorscheme files

	-- Load palette
	local ok, c = pcall(require, "oasis.color_palettes." .. palette_name)
	if not ok then
		error(('Oasis: palette "%s" not found: %s'):format(palette_name, c))
	end

	-- Apply palette overrides from config
	c = config.apply_palette_overrides(c, palette_name)

	-- Build and apply the colorscheme
	local build = require("oasis.theme_generator")
	build(c, palette_name)

	-- Load and refresh plugin integrations
	pcall(require, 'oasis.integrations.lualine')
	pcall(require, 'oasis.integrations.tabby')
	require('oasis.integrations').refresh_all()
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
