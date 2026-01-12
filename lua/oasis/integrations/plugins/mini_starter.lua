-- lua/oasis/integrations/plugins/mini_starter.lua
-- Highlights for mini.starter plugin

return function(c)
  return {
    MiniStarterFooter = "Comment",
    MiniStarterInactive = { fg = c.fg.muted },
    MiniStarterSection = "OasisSecondary",
    MiniStarterItemPrefix = { fg = c.theme.strong_primary, bold = true },
    MiniStarterQuery = { fg = c.theme.accent, bold = true },
  }
end
