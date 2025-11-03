-- lua/oasis/integrations/init.lua
-- Plugin integration manager for oasis colorscheme

local M = {}

-- Registry of active integrations
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

return M
