-- scripts/screenshot_generator/lib/screenshot_workflow.lua
-- Variant screenshot workflow manager

local Config = require("scripts.screenshot_generator.config")
local KittyController = require("scripts.screenshot_generator.lib.kitty_controller")
local System = require("oasis.lib.system")

local ScreenshotWorkflow = {}
ScreenshotWorkflow.__index = ScreenshotWorkflow

--- Create a new ScreenshotWorkflow instance
--- @param variant string Variant name (e.g., "sol_dark", "lagoon_light_3")
--- @param screenshot_capture table ScreenshotCapture instance
--- @return table ScreenshotWorkflow instance
function ScreenshotWorkflow.new(variant, screenshot_capture)
	local self = setmetatable({}, ScreenshotWorkflow)
	self.variant = variant
	self.instance_name = "oasis-screenshot-" .. variant
	self.kitty = KittyController.new(self.instance_name)
	self.screenshot_capture = screenshot_capture

	-- Parse variant to extract base name, mode, and optional light intensity
	self.base_name, self.mode, self.intensity = self:parse_variant(variant)

	return self
end

--- Parse variant name into components
--- @param variant string Variant name
--- @return string base_name Base palette name
--- @return string|nil mode "dark" or "light" or nil
--- @return number|nil intensity Light intensity (1-5) or nil
function ScreenshotWorkflow:parse_variant(variant)
	-- e.g., "sol_dark" -> base="sol", mode="dark", intensity=nil
	--       "lagoon_light_3" -> base="lagoon", mode="light", intensity=3
	--       "dawn" -> base="dawn", mode=nil, intensity=nil
	local base, mode, intensity = variant:match("^(.+)_(dark)$")
	if base then
		return base, mode, nil
	end

	base, mode, intensity = variant:match("^(.+)_(light)_(%d)$")
	if base then
		return base, mode, tonumber(intensity)
	end

	-- No mode suffix
	return variant, nil, nil
end

--- Run the full screenshot workflow for this variant
function ScreenshotWorkflow:run()
	self:launch_terminal()
	self:capture_dashboard()
	self:capture_code_view()
	self:close_terminal()
end

--- Launch Kitty terminal
function ScreenshotWorkflow:launch_terminal()
	print("  Launching Kitty terminal...")
	self.kitty:launch()
end

--- Capture dashboard screenshot
function ScreenshotWorkflow:capture_dashboard()
	print("  Opening Neovim dashboard...")
	self.kitty:send_keys("cd " .. Config.PROJECT_ROOT)
	self.kitty:send_keys("nvim")
	System.sleep(1)

	-- Run lua first, can't chain the pipe | with lua
	if self.intensity then
		self.kitty:send_keys(
			string.format(":lua local cfg=require('oasis.config').get(); cfg.light_intensity=%d", self.intensity)
		)
	end

	local command_chain = { "set termguicolors" }
	if self.mode then
		table.insert(command_chain, "set background=" .. self.mode)
	end
	table.insert(command_chain, "colorscheme oasis-" .. self.base_name)

	self.kitty:send_keys(":" .. table.concat(command_chain, " | "))
	self.screenshot_capture:capture(self.instance_name, self.variant, "dashboard")
end

--- Capture code view screenshot
function ScreenshotWorkflow:capture_code_view()
	print("  Opening code file...")
	self.kitty:send_keys(":e assets/example-scripts/index.js")
	System.sleep(0.5)
	self.kitty:send_keys("", true) -- Send Enter
	self.kitty:send_keys("\x1b", false) -- Send Escape
	self.kitty:send_keys("19G")
	self.kitty:send_keys("$")
	self.screenshot_capture:capture(self.instance_name, self.variant, "code")
end

--- Close Kitty terminal
function ScreenshotWorkflow:close_terminal()
	print("  Closing Kitty...")
	self.kitty:close()
end

return ScreenshotWorkflow
