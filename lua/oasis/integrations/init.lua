-- lua/oasis/integrations/init.lua
-- Plugin integration manager for oasis colorscheme

local Plugin = {}

-- Registry of active integrations (lualine, tabby, etc.)
Plugin._integrations = {}

--- Register an integration
---@param name string Integration name
---@param integration table Integration object with refresh() method
function Plugin.register(name, integration)
  Plugin._integrations[name] = integration
end

--- Refresh all registered integrations
function Plugin.refresh_all()
  for name, integration in pairs(Plugin._integrations) do
    if integration.refresh then
      local ok, err = pcall(integration.refresh)
      if not ok then
        vim.notify(("Oasis integration '%s' refresh failed: %s"):format(name, err), vim.log.levels.WARN)
      end
    end
  end
end

-------------------------------------------------------
-- Plugin Highlight Loading (for lazy-loaded plugins)
-------------------------------------------------------

-- Map of plugin detection name to highlight module path
local PLUGIN_MODULES = {
  ["fzf-lua"] = "oasis.integrations.plugins.fzf_lua",
  ["gitsigns"] = "oasis.integrations.plugins.gitsigns",
  ["lazy"] = "oasis.integrations.plugins.lazy",
  ["mini.clue"] = "oasis.integrations.plugins.mini_clue",
  ["mini.cmdline"] = "oasis.integrations.plugins.mini_cmdline",
  ["mini.completion"] = "oasis.integrations.plugins.mini_completion",
  ["mini.diff"] = "oasis.integrations.plugins.mini_diff",
  ["mini.files"] = "oasis.integrations.plugins.mini_files",
  ["mini.icons"] = "oasis.integrations.plugins.mini_icons",
  ["mini.jump"] = "oasis.integrations.plugins.mini_jump",
  ["mini.map"] = "oasis.integrations.plugins.mini_map",
  ["mini.pick"] = "oasis.integrations.plugins.mini_pick",
  ["mini.starter"] = "oasis.integrations.plugins.mini_starter",
  ["mini.statusline"] = "oasis.integrations.plugins.mini_statusline",
  ["mini.tabline"] = "oasis.integrations.plugins.mini_tabline",
  ["mini.trailspace"] = "oasis.integrations.plugins.mini_trailspace",
  ["snacks"] = "oasis.integrations.plugins.snacks",
  ["which-key"] = "oasis.integrations.plugins.which_key",
}

-- TODO: Maybe make each plugin an opt-in from config?
-- Check if a plugin is loaded in package.loaded
-- local function is_plugin_loaded(plugin_name)
-- 	return package.loaded[plugin_name] ~= nil
-- end
--
--- Load highlights for all detected plugins
---@param c table Color palette
---@return table highlights Plugin highlight groups
function Plugin.get_plugin_highlights(c)
  local highlights = {}

  for plugin_name, module_path in pairs(PLUGIN_MODULES) do
    -- if is_plugin_loaded(plugin_name) then
    local ok, apply_plugin_highlights = pcall(require, module_path)
    if ok and type(apply_plugin_highlights) == "function" then
      local plugin_highlights = apply_plugin_highlights(c)
      -- Merge plugin highlights into main table
      for name, attrs in pairs(plugin_highlights) do
        highlights[name] = attrs
      end
    end
    -- end
  end

  return highlights
end

return Plugin
