-- lua/oasis/integrations/plugins/snacks.lua
-- Highlights for snacks.nvim plugin

return function(_, hl)
  -- Dashboard
  hl.SnacksDashboardHeader = "OasisStrongPrimary"
  hl.SnacksDashboardFile = "OasisLightPrimary"
  hl.SnacksDashboardSpecial = "OasisAccent"
  hl.SnacksDashboardDesc = "OasisSecondary"

  -- Picker
  hl.SnacksPickerBoxTitle = "OasisFloatSecondary"
  hl.SnacksPickerInputTitle = "OasisFloatSecondary"
  hl.SnacksPickerInputBorder = "OasisFloatSecondary"
  hl.SnacksPickerPrompt = "Identifier"
end
