-- lua/oasis/integrations/plugins/mini_icons.lua
-- Highlights for mini.icons plugin

return function(c, hl)
	hl.MiniIconsAzure = { fg = c.terminal.blue }
	hl.MiniIconsBlue = { fg = c.terminal.bright_blue }
	hl.MiniIconsCyan = { fg = c.terminal.cyan }
	hl.MiniIconsGreen = { fg = c.terminal.green }
	hl.MiniIconsGrey = { fg = c.terminal.white }
	hl.MiniIconsOrange = { fg = c.terminal.bright_yellow }
	hl.MiniIconsPurple = { fg = c.terminal.magenta }
	hl.MiniIconsRed = { fg = c.terminal.red }
	hl.MiniIconsYellow = { fg = c.terminal.yellow }
end
