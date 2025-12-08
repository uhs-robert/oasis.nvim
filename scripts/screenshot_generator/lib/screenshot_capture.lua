-- scripts/screenshot_generator/lib/screenshot_capture.lua
-- Screenshot capture handler

local File = require("oasis.lib.file")
local FileSystem = require("oasis.lib.filesystem")
local System = require("oasis.lib.system")

local ScreenshotCapture = {}
ScreenshotCapture.__index = ScreenshotCapture

--- Create a new ScreenshotCapture instance
--- @param temp_dir string Temporary directory for screenshots
--- @param output_dir string Final output directory
--- @return table ScreenshotCapture instance
function ScreenshotCapture.new(temp_dir, output_dir)
	local self = setmetatable({}, ScreenshotCapture)
	self.temp_dir = temp_dir
	self.output_dir = output_dir
	return self
end

--- Capture a screenshot for a variant
--- @param instance_name string Kitty instance name (for window focusing)
--- @param variant string Variant name (e.g., "sol_dark")
--- @param type string Screenshot type ("dashboard" or "code")
function ScreenshotCapture:capture(instance_name, variant, type)
	-- Convert underscore to hyphen for filename (e.g., sol_dark -> sol-dark)
	local filename_variant = variant:gsub("_", "-")
	local temp_file = self.temp_dir .. "/" .. filename_variant .. "-" .. type .. ".png"
	local final_file = self.output_dir .. "/" .. filename_variant .. "-" .. type .. ".png"

	print("  Capturing " .. type .. " screenshot...")
	self:focus_window(instance_name)
	self:take_screenshot(filename_variant, type, temp_file)
	self:move_to_final_location(temp_file, final_file)

	print("  Saved: " .. final_file)
end

--- Focus window using Hyprland
--- @param instance_name string Window title to focus
function ScreenshotCapture:focus_window(instance_name)
	System.execute("hyprctl dispatch focuswindow title:" .. instance_name)
	System.sleep(0.5)
end

--- Take screenshot using hyprshot
--- @param variant string Variant name for filename
--- @param type string Screenshot type
--- @param temp_file string Expected output file path
function ScreenshotCapture:take_screenshot(variant, type, temp_file)
	System.execute(
		string.format(
			"hyprshot -m window -m active -o %s -f %s-%s.png --silent 2>/dev/null",
			self.temp_dir,
			variant,
			type
		)
	)

	if not File.exists(temp_file) or File.size(temp_file) == 0 then
		error(string.format("hyprshot failed to capture %s %s - file not created or empty", variant, type))
	end
end

--- Move screenshot to final output location
--- @param temp_file string Temporary file path
--- @param final_file string Final destination path
function ScreenshotCapture:move_to_final_location(temp_file, final_file)
	if File.exists(final_file) then
		FileSystem.remove(final_file)
	end
	FileSystem.move(temp_file, final_file)
end

return ScreenshotCapture
