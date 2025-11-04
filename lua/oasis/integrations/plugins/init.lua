-- lua/oasis/integrations/plugins/init.lua
-- Lazy-loaded plugin highlights loader

local M = {}

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

-- Load highlights for all detected plugins
function M.get_highlights(c)
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
