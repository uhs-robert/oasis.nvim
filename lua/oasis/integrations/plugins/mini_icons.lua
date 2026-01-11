-- lua/oasis/integrations/plugins/mini_icons.lua
-- Highlights for mini.icons plugin

return function(c)
  return {
    MiniIconsAzure = { fg = c.terminal.blue },
    MiniIconsBlue = { fg = c.terminal.bright_blue },
    MiniIconsCyan = { fg = c.terminal.cyan },
    MiniIconsGreen = { fg = c.terminal.green },
    MiniIconsGrey = { fg = c.terminal.white },
    MiniIconsOrange = { fg = c.terminal.bright_yellow },
    MiniIconsPurple = { fg = c.terminal.magenta },
    MiniIconsRed = { fg = c.terminal.red },
    MiniIconsYellow = { fg = c.terminal.yellow },
  }
end
