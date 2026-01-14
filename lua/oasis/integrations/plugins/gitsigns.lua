-- lua/oasis/integrations/plugins/gitsigns.lua
-- Highlights for gitsigns.nvim plugin

return function(c, hl)
	local LIGHT_MODE = c.light_mode or false

	hl.GitSignsAdd = { fg = c.git.add }
	hl.GitSignsChange = { fg = c.git.change }
	hl.GitSignsDelete = { fg = c.git.delete }

	if LIGHT_MODE then
		hl.GitSignsAdd = { fg = c.git.add, bg = c.bg.core }
		hl.GitSignsChange = { fg = c.git.change, bg = c.bg.core }
		hl.GitSignsDelete = { fg = c.git.delete, bg = c.bg.core }
	end
end
