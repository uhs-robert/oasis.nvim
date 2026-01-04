-- lua/oasis/integrations/plugins/lazy.lua
-- Highlights for lazy.nvim plugin manager

return function(c)
  return {
    LazyH1 = { fg = c.theme.primary, bold = true },
    LazyH2 = { fg = c.theme.light_primary, bold = true },
    lazyActiveBorder = "Identifier",
  }
end
