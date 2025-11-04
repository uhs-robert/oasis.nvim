-- lua/oasis/integrations/init.lua
-- Plugin integration manager for oasis colorscheme

local M = {}

-- Registry of active integrations (lualine, tabby, etc.)
M._integrations = {}

--- Register an integration
---@param name string Integration name
---@param integration table Integration object with refresh() method
function M.register(name, integration)
	M._integrations[name] = integration
end

--- Refresh all registered integrations
function M.refresh_all()
	for name, integration in pairs(M._integrations) do
		if integration.refresh then
			local ok, err = pcall(integration.refresh)
			if not ok then
				vim.notify(("Oasis integration '%s' refresh failed: %s"):format(name, err), vim.log.levels.WARN)
			end
		end
	end
end

--- Refresh a specific integration
---@param name string Integration name
function M.refresh(name)
	local integration = M._integrations[name]
	if integration and integration.refresh then
		local ok, err = pcall(integration.refresh)
		if not ok then
			vim.notify(("Oasis integration '%s' refresh failed: %s"):format(name, err), vim.log.levels.WARN)
		end
	end
end

--- List all registered integrations
---@return string[] List of integration names
function M.list()
	local names = {}
	for name, _ in pairs(M._integrations) do
		table.insert(names, name)
	end
	return names
end

-------------------------------------------------------
-- Plugin Highlight Loading (for lazy-loaded plugins)
-------------------------------------------------------

-- Map of plugin detection name to highlight module path
local PLUGIN_MODULES = {
	["lazy"] = "oasis.integrations.plugins.lazy",
	["which-key"] = "oasis.integrations.plugins.which_key",
	["snacks"] = "oasis.integrations.plugins.snacks",
	["fzf-lua"] = "oasis.integrations.plugins.fzf_lua",
	["gitsigns"] = "oasis.integrations.plugins.gitsigns",
}

-- Check if a plugin is loaded in package.loaded
local function is_plugin_loaded(plugin_name)
	return package.loaded[plugin_name] ~= nil
end

--- Load highlights for all detected plugins
---@param c table Color palette
---@return table highlights Plugin highlight groups
function M.get_plugin_highlights(c)
	local highlights = {}

	for plugin_name, module_path in pairs(PLUGIN_MODULES) do
		if is_plugin_loaded(plugin_name) then
			local ok, apply_plugin_highlights = pcall(require, module_path)
			if ok and type(apply_plugin_highlights) == "function" then
				local plugin_highlights = apply_plugin_highlights(c)
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
