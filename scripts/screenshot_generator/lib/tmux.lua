-- scripts/screenshot_generator/lib/tmux.lua
-- Tmux configuration management for screenshot generation

local Config = require("scripts.screenshot_generator.config")
local File = require("oasis.lib.file")
local FileSystem = require("oasis.lib.filesystem")
local System = require("oasis.lib.system")

local Tmux = {}

--- Backup tmux configuration
function Tmux.backup_config()
	print("\nBacking up tmux config...")
	FileSystem.copy(Config.TMUX_CONFIG, Config.TMUX_CONFIG_BACKUP)
	print("Backup created at: " .. Config.TMUX_CONFIG_BACKUP)
end

--- Restore original tmux configuration
function Tmux.restore_config()
	print("\nRestoring original tmux config...")
	FileSystem.move(Config.TMUX_CONFIG_BACKUP, Config.TMUX_CONFIG)
	print("Config restored")
end

--- Kill tmux server
function Tmux.kill_server()
	print("  Killing tmux server...")
	System.execute("tmux kill-server 2>/dev/null || true")
	System.sleep(1)
end

--- Update @oasis_flavor in tmux config
--- @param variant string Variant name (e.g., "sol_dark")
function Tmux.update_oasis_flavor(variant)
	local content = File.read(Config.TMUX_CONFIG)
	if not content then
		error("Failed to read tmux config: " .. Config.TMUX_CONFIG)
	end

	-- Match word characters and underscores for variants (e.g., sol_dark)
	local updated = content:gsub("set %-g @oasis_flavor [\"']?[%w_]+[\"']?", 'set -g @oasis_flavor "' .. variant .. '"')

	-- Warn if unchanged
	if updated == content then
		print("  WARNING: tmux config was not modified - flavor line may not match regex")
	end

	File.write(Config.TMUX_CONFIG, updated)

	-- Verify update
	local verify = File.read(Config.TMUX_CONFIG)
	if not verify or not verify:find('@oasis_flavor "' .. variant .. '"', 1, true) then
		error("Failed to update tmux config to " .. variant)
	end

	print("  Updated tmux config to flavor: " .. variant)
end

return Tmux
