#!/usr/bin/env lua
-- scripts/screenshot_generator/generate_screenshots.lua
-- Main entry point for automated screenshot generation

-- Check if we're running under the wrapper (via --wrapped flag)
local is_wrapped = false
for i = 1, #arg do
	if arg[i] == "--wrapped" then
		is_wrapped = true
		break
	end
end

-- If not wrapped, call the bash wrapper and exit (for graceful cleanup incase we need to stop the script)
if not is_wrapped then
	local script_dir = debug.getinfo(1, "S").source:match("@?(.*/)") or "./"
	local wrapper_path = script_dir .. "run_with_cleanup.sh"

	os.exit(os.execute(wrapper_path))
end

-- Add current directory to package path so we can require our modules
local SCRIPT_DIR = debug.getinfo(1, "S").source:match("@?(.*/)") or "./"
package.path = SCRIPT_DIR .. "?.lua;" .. SCRIPT_DIR .. "?/init.lua;" .. package.path

local ScreenshotGenerator = require("scripts.screenshot_generator.lib.screenshot_generator")

--- Main entry point
local function main()
	local generator = ScreenshotGenerator.new()

	local success, err = pcall(function()
		generator:run()
	end)

	-- Ensure cleanup on unexpected errors
	if not success then
		print("\nError occurred: " .. tostring(err))
		generator:cleanup()
		os.exit(1)
	end
end

main()
