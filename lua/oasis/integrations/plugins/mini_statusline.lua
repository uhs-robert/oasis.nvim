-- lua/oasis/integrations/plugins/mini_statusline.lua
-- Highlights for mini.statusline plugin

return function(c)
  return {
    MiniStatuslineModeNormal = { bg = c.syntax.statement, fg = c.bg.core },
    MiniStatuslineModeInsert = { bg = c.syntax.string, fg = c.bg.core },
    MiniStatuslineModeCommand = { bg = c.syntax.parameter, fg = c.bg.core },
    MiniStatuslineModeVisual = { bg = c.syntax.special, fg = c.bg.core },
    MiniStatuslineModeReplace = { bg = c.syntax.operator, fg = c.bg.core },
    MiniStatuslineModeOther = { bg = c.syntax.type, fg = c.bg.core },
    MiniStatuslineDevInfo = { fg = c.syntax.statement, bg = c.bg.surface },
    MiniStatuslineFileInfo = { fg = c.syntax.statement, bg = c.bg.surface },
    MiniStatuslineFilename = { fg = c.theme.light_primary, bg = c.bg.mantle },
    MiniStatuslineInactive = { fg = c.fg.comment, bg = c.bg.surface },
  }
end
