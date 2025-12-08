#!/usr/bin/env lua
-- scripts/screenshot_generator/generate_screenshots.lua
-- Main entry point for automated screenshot generation

-- Add current directory to package path so we can require our modules
local SCRIPT_DIR = debug.getinfo(1, "S").source:match("@?(.*/)") or "./"
package.path = SCRIPT_DIR .. "?.lua;" .. SCRIPT_DIR .. "?/init.lua;" .. package.path

local ScreenshotGenerator = require("scripts.screenshot_generator.lib.screenshot_generator")

--- Main entry point
local function main()
	local generator = ScreenshotGenerator.new()
	generator:run()
end

main()
