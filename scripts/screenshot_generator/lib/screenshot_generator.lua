-- scripts/screenshot_generator/lib/screenshot_generator.lua
-- Automated screenshot generator orchestrator for Oasis.nvim colorscheme variants.
-- Generates dashboard and code screenshots for all theme variants using
-- Kitty terminal, tmux, and Neovim. Requires Hyprland window manager with
-- hyprshot for screenshot capture.

local Config = require("scripts.screenshot_generator.config")
local Tmux = require("scripts.screenshot_generator.lib.tmux")
local DependencyChecker = require("scripts.screenshot_generator.lib.dependency_checker")
local ScreenshotCapture = require("scripts.screenshot_generator.lib.screenshot_capture")
local ScreenshotWorkflow = require("scripts.screenshot_generator.lib.screenshot_workflow")
local File = require("oasis.lib.file")
local Directory = require("oasis.lib.directory")

local ScreenshotGenerator = {}
ScreenshotGenerator.__index = ScreenshotGenerator

--- Create a new ScreenshotGenerator instance
--- @return table ScreenshotGenerator instance
function ScreenshotGenerator.new()
	local self = setmetatable({}, ScreenshotGenerator)
	self.errors = {}
	self.screenshot_capture = ScreenshotCapture.new(Config.TEMP_DIR, Config.OUTPUT_DIR)
	return self
end

--- Run the full screenshot generation process
function ScreenshotGenerator:run()
	DependencyChecker.check_all()
	Directory.create(Config.TEMP_DIR)
	Tmux.backup_config()
	self:generate_all_screenshots()
	Tmux.restore_config()
	if File.exists(Config.TEMP_DIR) then
		Directory.remove(Config.TEMP_DIR)
	end
	self:report_results()
end

--- Generate screenshots for all variants
function ScreenshotGenerator:generate_all_screenshots()
	print(string.format("\nGenerating screenshots for %d variants...", #Config.VARIANTS))
	print(string.rep("=", 60))

	for index, variant in ipairs(Config.VARIANTS) do
		print(string.format("\n[%d/%d] Processing: %s", index, #Config.VARIANTS, variant))
		self:process_variant(variant)
	end
end

--- Process a single variant
--- @param variant string Variant name to process
function ScreenshotGenerator:process_variant(variant)
	local success, err = pcall(function()
		Tmux.kill_server()
		Tmux.update_oasis_flavor(variant)
		ScreenshotWorkflow.new(variant, self.screenshot_capture):run()
		print(variant .. " complete")
	end)

	if not success then
		local error_msg = string.format("Failed to process %s: %s", variant, err)
		table.insert(self.errors, error_msg)
		print(error_msg)
	end
end

--- Report final results
function ScreenshotGenerator:report_results()
	print("\n" .. string.rep("=", 60))

	if #self.errors == 0 then
		local total_screenshots = #Config.VARIANTS * 2 -- 2 screenshots per variant
		print(string.format("SUCCESS! All %d screenshots generated (%d variants)", total_screenshots, #Config.VARIANTS))
		print("Output directory: " .. Config.OUTPUT_DIR)
	else
		print(string.format("Completed with %d error(s):", #self.errors))
		for _, err in ipairs(self.errors) do
			print("   - " .. err)
		end
	end
end

return ScreenshotGenerator
