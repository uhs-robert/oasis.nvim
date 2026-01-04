-- lua/oasis/integrations/plugins/snacks.lua
-- Highlights for snacks.nvim plugin

return function(c)
  return {
    -- stylua: ignore start
    -- Dashboard
    SnacksDashboardHeader = "OasisStrongPrimary",
    SnacksDashboardFile    = "OasisLightPrimary",
    SnacksDashboardSpecial = "OasisAccent",
    SnacksDashboardDesc    = "OasisSecondary",

    -- Picker
    SnacksPickerBoxTitle   = "OasisFloatSecondary",
    SnacksPickerInputTitle = "OasisFloatSecondary",
    SnacksPickerInputBorder= "OasisFloatSecondary",
    SnacksPickerPrompt     = "Identifier",
    -- stylua: ignore end
  }
end
