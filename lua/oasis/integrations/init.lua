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

--- Load highlights for all detected plugins
---@param c table Color palette
---@return table highlights Plugin highlight groups
function Plugin.get_plugin_highlights(c)
  local Config = require("oasis.config")
  local integrations = (Config.get().integrations or {})
  local default_enabled = integrations.default_enabled ~= false
  local plugin_config = integrations.plugins or {}
  local user_plugins = Config.get_user_plugins()
  local highlights = {}

  for plugin_name, _ in pairs(plugin_config) do
    local enabled

    if default_enabled then
      enabled = plugin_config[plugin_name] ~= false
    else
      enabled = user_plugins[plugin_name] == true
    end

    if enabled then
      local module_path = "oasis.integrations.plugins." .. plugin_name
      local ok, apply_plugin_highlights = pcall(require, module_path)
      if ok and type(apply_plugin_highlights) == "function" then apply_plugin_highlights(c, highlights) end
    end
  end

  return highlights
end

return Plugin
