-- lua/oasis/integrations/plugins/mini_diff.lua
-- Highlights for mini.diff plugin

return function(c)
  return {
    MiniDiffSignAdd = { fg = c.git.add },
    MiniDiffSignChange = { fg = c.git.change },
    MiniDiffSignDelete = { fg = c.git.delete },
  }
end
