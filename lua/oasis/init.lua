-- lua/oasis/init.lua
local M = {}

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
	palette_name = palette_name or vim.g.oasis_palette or "oasis_lagoon"
	vim.g.colors_name = palette_name -- or ('oasis_' .. palette_name)

	-- Load palette
	local ok, c = pcall(require, "oasis.color_palettes." .. palette_name)
	if not ok then
		error(('Oasis: palette "%s" not found: %s'):format(palette_name, c))
	end

	-- Build and apply the colorscheme
	local build = require("oasis.theme_generator")
	build(c)

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

-- :OasisExport command to export colorschemes using Shipwright
vim.api.nvim_create_user_command("OasisExport", function(opts)
	local args = vim.split(opts.args, "%s+")
	local action = args[1] or "all"

	local exporter = require("_exported_themes.export_all")

	if action == "all" then
		-- Export all palettes in Lua format
		exporter.export_lua_all()
	elseif action == "both" then
		-- Export all palettes in both Lua and VimScript formats
		exporter.export_both_formats()
	elseif action == "list" then
		-- List available palettes
		local palettes = exporter.list_palettes()
		print("Available palettes:")
		for _, palette in ipairs(palettes) do
			print("  " .. palette)
		end
	elseif action and action ~= "" then
		-- Export specific palette
		local format = args[2] or "lua"
		exporter.export_single(action, format)
	else
		print("Usage: :OasisExport [all|both|list|<palette_name> [lua|vim]]")
		print("  all  - Export all palettes as Lua files")
		print("  both - Export all palettes as both Lua and VimScript files")
		print("  list - List available palette names")
		print("  <palette_name> [format] - Export specific palette (default: lua)")
	end
end, {
	nargs = "*",
	complete = function(arglead, cmdline, cursorpos)
		local args = vim.split(cmdline, "%s+")
		local arg_count = #args

		-- Account for incomplete arguments
		if cmdline:match("%s$") then
			arg_count = arg_count + 1
		end

		if arg_count == 2 then
			-- First argument: action or palette name
			local actions = { "all", "both", "list" }
			local exporter = require("_exported_themes.export_all")
			local palettes = exporter.list_palettes()

			local completions = {}
			for _, action in ipairs(actions) do
				if action:find("^" .. vim.pesc(arglead)) then
					table.insert(completions, action)
				end
			end
			for _, palette in ipairs(palettes) do
				if palette:find("^" .. vim.pesc(arglead)) then
					table.insert(completions, palette)
				end
			end
			return completions
		elseif arg_count == 3 then
			-- Second argument: format (only for specific palette)
			local formats = { "lua", "vim" }
			local completions = {}
			for _, format in ipairs(formats) do
				if format:find("^" .. vim.pesc(arglead)) then
					table.insert(completions, format)
				end
			end
			return completions
		end

		return {}
	end,
})

return M
