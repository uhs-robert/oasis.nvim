-- scripts/screenshot_generator/lib/dependency_checker.lua
-- Dependency verification for screenshot generation

local Config = require("scripts.screenshot_generator.config")
local File = require("oasis.lib.file")
local System = require("oasis.lib.system")

local DependencyChecker = {}

--- Check all dependencies
function DependencyChecker.check_all()
	print("Checking dependencies...")
	DependencyChecker.check_required_commands()
	DependencyChecker.check_kitty_remote_control()
	DependencyChecker.check_tmux_config()
	print("All dependencies found")
end

--- Check for required commands (hyprshot, kitty, tmux)
function DependencyChecker.check_required_commands()
	local required_commands = { "hyprshot", "kitty", "tmux" }
	local missing = {}

	for _, cmd in ipairs(required_commands) do
		if not System.execute("which " .. cmd .. " > /dev/null 2>&1") then
			table.insert(missing, cmd)
		end
	end

	if #missing > 0 then
		print("Missing required commands: " .. table.concat(missing, ", "))
		print("  Install with:")
		print("  - hyprshot: https://github.com/Gustash/Hyprshot")
		print("  - kitty: your package manager")
		print("  - tmux: your package manager")
		os.exit(1)
	end
end

--- Check if kitty remote control is enabled
function DependencyChecker.check_kitty_remote_control()
	local kitty_conf = System.get_home_dir() .. "/.config/kitty/kitty.conf"

	if File.exists(kitty_conf) then
		DependencyChecker.verify_kitty_config(kitty_conf)
	else
		DependencyChecker.warn_missing_kitty_config()
	end
end

--- Verify kitty config has remote control enabled
--- @param kitty_conf string Path to kitty.conf
function DependencyChecker.verify_kitty_config(kitty_conf)
	local content = File.read(kitty_conf)
	if not content then
		return
	end

	-- Check for either "yes" or "socket-only" (Lua patterns don't support | for alternation)
	if content:match("allow_remote_control%s+yes") or content:match("allow_remote_control%s+socket%-only") then
		return
	end

	print("Kitty remote control not enabled")
	print("  Add to ~/.config/kitty/kitty.conf:")
	print("    allow_remote_control yes")
	print("  or:")
	print("    allow_remote_control socket-only")
	os.exit(1)
end

--- Warn about missing kitty config
function DependencyChecker.warn_missing_kitty_config()
	print("Warning: Could not find kitty.conf to verify remote control is enabled")
	print('  Make sure you have "allow_remote_control yes" in your kitty config')
end

--- Check if tmux config exists
function DependencyChecker.check_tmux_config()
	if not File.exists(Config.TMUX_CONFIG) then
		print("tmux config not found at: " .. Config.TMUX_CONFIG)
		os.exit(1)
	end
end

return DependencyChecker
