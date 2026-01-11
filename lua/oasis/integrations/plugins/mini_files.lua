-- lua/oasis/integrations/plugins/mini_files.lua
-- Highlights for mini.files plugin

return function(c)
  return {
    MiniFilesCursorLine = "PmenuSel",
    MiniFilesBorderModified = { fg = c.ui.diag.warn.fg, bg = c.ui.float.bg },
    MiniFilesTitleFocused = { fg = c.theme.secondary, bg = c.ui.float.bg, bold = true },
  }
end
