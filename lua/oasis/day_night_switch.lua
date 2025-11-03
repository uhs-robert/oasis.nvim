-- lua/oasis/day_night_switch.lua
-- Handles automatic theme switching based on vim background setting (day/night mode)

local M = {}
local initialized = false

--- Set up auto-switching autocmds (safe to call multiple times)
function M.setup()
	if initialized then
		return
	end
	initialized = true

	local augroup = vim.api.nvim_create_augroup("OasisAutoSwitch", { clear = true })

	-- Track when non-Oasis colorschemes are loaded
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = augroup,
		callback = function(ev)
			local colorscheme = ev.match
			if colorscheme and not colorscheme:match("^oasis") then
				vim.g.is_oasis_active = false
			end
		end,
	})

	-- Auto-switch when background changes
	vim.api.nvim_create_autocmd("OptionSet", {
		group = augroup,
		pattern = "background",
		callback = function()
			-- Only switch if Oasis is currently loaded
			if not vim.g.is_oasis_active then
				return
			end

			local config = require("oasis.config")
			local cfg = config.get()
			local new_bg = vim.v.option_new
			local target_style = new_bg == "light" and cfg.light_style or cfg.dark_style

			-- Construct full palette name
			local target_palette = "oasis_" .. target_style

			-- Apply the target palette
			require("oasis").apply(target_palette)
		end,
	})
end

return M
