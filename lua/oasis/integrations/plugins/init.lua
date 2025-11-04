-- lua/oasis/integrations/plugins/init.lua
-- Lazy-loaded plugin highlights loader

local M = {}

-- Map of plugin detection name to highlight module path
local PLUGIN_MODULES = {
  ["lazy"]      = "oasis.integrations.plugins.lazy",
  ["which-key"] = "oasis.integrations.plugins.which_key",
  ["snacks"]    = "oasis.integrations.plugins.snacks",
  ["fzf-lua"]   = "oasis.integrations.plugins.fzf_lua",
  ["gitsigns"]  = "oasis.integrations.plugins.gitsigns",
}

-- Check if a plugin is loaded (without triggering side effects)
local function is_plugin_loaded(plugin_name)
  -- Only check if plugin is already loaded in package.loaded
  -- Don't try to require it to avoid side effects during initialization
  return package.loaded[plugin_name] ~= nil
end

-- Load highlights for all detected plugins
function M.get_highlights(c, palette_name)
  local highlights = {}

  for plugin_name, module_path in pairs(PLUGIN_MODULES) do
    if is_plugin_loaded(plugin_name) then
      local ok, plugin_highlights_fn = pcall(require, module_path)
      if ok and type(plugin_highlights_fn) == "function" then
        local plugin_highlights = plugin_highlights_fn(c, palette_name)
        -- Merge plugin highlights into main table
        for name, attrs in pairs(plugin_highlights) do
          highlights[name] = attrs
        end
      end
    end
  end

  return highlights
end

return M
