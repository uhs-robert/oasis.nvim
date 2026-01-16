-- lua/oasis/integrations/init.lua
-- Plugin integration manager for oasis colorscheme

local Plugin = {}

-- Registry of active integrations (lualine, tabby, etc.)
Plugin._integrations = {}

--- Register a special edgecase integration (i.e, lualine/tabby)
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

return Plugin
