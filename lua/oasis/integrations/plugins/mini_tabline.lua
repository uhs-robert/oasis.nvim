-- lua/oasis/integrations/plugins/mini_tabline.lua
-- Highlights for mini.tabline plugin

return function(c)
  return {
    MiniTablineCurrent = { fg = c.theme.secondary, bg = c.bg.surface, bold = true },
    MiniTablineFill = "TabLineFill",
    MiniTablineHidden = "TabLine",
    MiniTablineModifiedCurrent = { fg = c.bg.core, bg = c.theme.secondary, bold = true },
    MiniTablineModifiedHidden = { fg = c.bg.core, bg = c.ui.border },
    MiniTablineModifiedVisible = { fg = c.bg.core, bg = c.ui.border, bold = true },
    MiniTablineTabpagesection = { fg = c.bg.core, bg = c.theme.accent },
    MiniTablineVisible = { fg = c.ui.border, bg = c.bg.surface, bold = true },
  }
end
