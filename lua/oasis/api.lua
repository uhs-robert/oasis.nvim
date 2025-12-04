-- lua/oasis/api.lua
-- User command definitions for Oasis colorscheme

local M = {}

--- Return sorted palette names on runtimepath, optionally filtered
---@param filter? fun(name: string): boolean
---@return string[]
local function list_palettes(filter)
	local paths = vim.fn.globpath(vim.o.rtp, "lua/oasis/color_palettes/*.lua", false, true)
	local out = {}

	for _, p in ipairs(paths) do
		local name = p:match("[\\/]color_palettes[\\/](.+)%.lua$")
		if name and name ~= "init" and (not filter or filter(name)) then
			table.insert(out, name)
		end
	end

	table.sort(out)
	return out
end

--- Create :Oasis command with palette completion
---@param oasis_module table
---@param utils table
---@return nil
local function create_oasis_command(oasis_module, utils)
	vim.api.nvim_create_user_command("Oasis", function(opts)
		oasis_module.apply(opts.args ~= "" and opts.args or nil)
	end, {
		nargs = "?",
		complete = function()
			local bg = vim.o.background
			return list_palettes(function(name)
				local mode = utils.get_palette_mode(name)
				return mode == "dual" or mode == bg
			end)
		end,
		desc = "Apply Oasis palette variant",
	})
end

--- Create :OasisWCAG command to run contrast checks
---@return nil
local function create_wcag_command()
	vim.api.nvim_create_user_command("OasisWCAG", function(opts)
		local wcag = require("oasis.tools.wcag_checker")
		if opts.args ~= "" then
			wcag.check_palette(opts.args)
		else
			wcag.check_all()
		end
	end, {
		nargs = "?",
		complete = function()
			return list_palettes()
		end,
		desc = "Check WCAG contrast compliance for Oasis palettes",
	})
end

--- Create :OasisTransparency toggle command
---@param oasis_module table
---@return nil
local function create_transparency_command(oasis_module)
	vim.api.nvim_create_user_command("OasisTransparency", function()
		oasis_module.toggle_transparency()
	end, {
		desc = "Toggle transparency for Oasis theme",
	})
end

--- Create :OasisThemedSyntax toggle command
---@param oasis_module table
---@return nil
local function create_themed_syntax_command(oasis_module)
	vim.api.nvim_create_user_command("OasisThemedSyntax", function()
		oasis_module.toggle_themed_syntax()
	end, {
		desc = "Toggle themed syntax using primary color for statements/conditionals (dark themes only)",
	})
end

--- Create :OasisIntensity cycling command
---@param oasis_module table
---@return nil
local function create_intensity_command(oasis_module)
	vim.api.nvim_create_user_command("OasisIntensity", function()
		oasis_module.cycle_intensity()
	end, {
		desc = "Show UI picker for light background intensity (1-5)",
	})
end

--- Setup all user commands
---@param oasis_module table The oasis module with apply, toggle_transparency, etc. functions
---@return nil
function M.setup(oasis_module)
	local utils = require("oasis.utils")

	create_oasis_command(oasis_module, utils)
	create_wcag_command()
	create_transparency_command(oasis_module)
	create_themed_syntax_command(oasis_module)
	create_intensity_command(oasis_module)
end

return M
