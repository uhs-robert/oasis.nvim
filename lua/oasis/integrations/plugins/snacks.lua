-- lua/oasis/integrations/plugins/snacks.lua
-- Highlights for snacks.nvim plugin

return function(c, palette_name)
  return {
    -- Dashboard
    SnacksDashboardFile    = "Statement",
    SnacksDashboardSpecial = "OasisAccent",

    -- Picker
    SnacksPickerBoxTitle   = "OasisFloatSecondary",
    SnacksPickerInputTitle = "OasisFloatSecondary",
    SnacksPickerInputBorder= "OasisFloatSecondary",
    SnacksPickerPrompt     = "Identifier",
  }
end
