-- scripts/screenshot_generator/lib/tmux.lua
-- Tmux configuration management for screenshot generation

local Config = require("scripts.screenshot_generator.config")
local File = require("oasis.lib.file")
local System = require("oasis.lib.system")

local Tmux = {}

--- Extract current @oasis_flavor value from tmux config
--- @return string|nil Current flavor value or nil if not found
function Tmux.get_current_flavor()
  local content = File.read(Config.TMUX_CONFIG)
  if not content then return nil end

  -- Match the flavor value (with or without quotes)
  local flavor = content:match("set %-g @oasis_flavor [\"']?([%w_]+)[\"']?")
  return flavor
end

--- Save current tmux flavor to file for bash cleanup
--- The bash wrapper (run_with_cleanup.sh) reads this file and restores the flavor on exit
function Tmux.backup_config()
  print("\nSaving current tmux flavor...")
  local original_flavor = Tmux.get_current_flavor()
  if original_flavor then
    File.write(Config.TMUX_BACKUP_FLAVOR, original_flavor)
    print("Original flavor saved: " .. original_flavor)
  else
    print("WARNING: Could not detect current flavor in tmux config")
  end
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
  if not content then error("Failed to read tmux config: " .. Config.TMUX_CONFIG) end

  -- Match word characters and underscores for variants (e.g., sol_dark)
  local updated = content:gsub("set %-g @oasis_flavor [\"']?[%w_]+[\"']?", 'set -g @oasis_flavor "' .. variant .. '"')

  -- Warn if unchanged
  if updated == content then print("  WARNING: tmux config was not modified - flavor line may not match regex") end

  File.write(Config.TMUX_CONFIG, updated)

  -- Verify update
  local verify = File.read(Config.TMUX_CONFIG)
  if not verify or not verify:find('@oasis_flavor "' .. variant .. '"', 1, true) then
    error("Failed to update tmux config to " .. variant)
  end

  print("  Updated tmux config to flavor: " .. variant)
end

return Tmux
