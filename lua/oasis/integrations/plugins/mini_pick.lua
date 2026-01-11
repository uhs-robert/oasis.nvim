-- lua/oasis/integrations/plugins/mini_pick.lua
-- Highlights for mini.pick plugin

return function(c)
  return {
    MiniPickBorderBusy = { fg = c.ui.diag.warn.fg, bg = c.ui.float.bg },
    MiniPickMatchCurrent = "PmenuSel",
    MiniPickMatchMarked = "Search",
    MiniPickMatchRanges = "PmenuMatch",
    MiniPickPreviewLine = { bg = c.ui.visual.bg },
    MiniPickPrompt = { fg = c.ui.float.fg, bg = c.ui.float.bg, bold = true },
    MiniPickPromptPrefix = { fg = c.ui.float.title, bg = c.ui.float.bg, bold = true },
  }
end
