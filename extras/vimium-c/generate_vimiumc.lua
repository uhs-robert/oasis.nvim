#!/usr/bin/env lua
-- extras/vimium-c/generate_vimiumc.lua
-- Generates Vimium-C browser extension themes from Oasis color palettes

local function get_palette_files()
	local handle = io.popen("ls ../../lua/oasis/color_palettes/oasis_*.lua 2>/dev/null")
	if not handle then
		return nil, "Failed to execute ls command to find palettes."
	end
	local result = handle:read("*a")
	handle:close()

	if not result or result == "" then
		return nil, "No palette files found."
	end

	local files = {}
	for file in result:gmatch("[^\n]+") do
		local name = file:match("oasis_(%w+)%.lua")
		if name then
			table.insert(files, name)
		end
	end

	table.sort(files)
	return files
end

local function load_palette(name)
	-- Add project root to package path
	package.path = package.path .. ";../../lua/?.lua;../../lua/?/init.lua"

	local palette_name = "oasis_" .. name
	local ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)

	if not ok then
		return nil, "Failed to load palette: " .. palette
	end

	return palette
end

local function get_display_name(name)
	-- Capitalize first letter
	return name:gsub("^%l", string.upper)
end

local function extract_vimiumc_colors(palette)
	-- Map palette structure to Vimium-C color scheme
	return {
		bg_core = palette.bg.core,
		bg_mantle = palette.bg.mantle,
		bg_surface = palette.bg.surface,
		fg = palette.fg.core,
		fg_dim = palette.fg.dim,
		link = palette.fg.dim, -- Use dim foreground for links
		border = palette.bg.mantle, -- Use mantle for borders
		primary = palette.theme.primary,
		light_primary = palette.theme.light_primary,
		secondary = palette.theme.secondary,
		title_match = palette.syntax.string, -- Use string color for matches
		link_match = palette.theme.secondary, -- Use secondary for link matches
	}
end

local function list_palettes()
	local palette_names, err = get_palette_files()
	if not palette_names then
		return nil, nil, err
	end

	local light_themes = {}
	local dark_themes = {}

	for _, name in ipairs(palette_names) do
		local palette = load_palette(name)
		if palette then
			local display_name = get_display_name(name)
			if palette.light_mode then
				table.insert(light_themes, { name = name, display = display_name })
			else
				table.insert(dark_themes, { name = name, display = display_name })
			end
		end
	end

	return light_themes, dark_themes
end

local function select_theme(label, themes)
	print(string.format("\n%s:", label))
	for i, theme in ipairs(themes) do
		print(string.format("  %d. %s", i, theme.display))
	end

	local alternate_label = label:match("light") and "dark" or "light"
	print(string.format("  %d. Use a %s theme instead", #themes + 1, alternate_label))

	io.write(string.format("\nSelect %s (1-%d): ", label, #themes + 1))
	local choice = tonumber(io.read())

	if not choice or choice < 1 or choice > #themes + 1 then
		return nil, "Invalid selection"
	end

	if choice > #themes then
		return "SWITCH_THEME_TYPE"
	end

	return themes[choice].name
end

local function read_template_file(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end
	local content = file:read("*a")
	file:close()
	return content
end

local function generate_vimiumc_css(day_name, night_name, day_palette, night_palette)
	local day_colors = extract_vimiumc_colors(day_palette)
	local night_colors = extract_vimiumc_colors(night_palette)

	-- Read the CSS template
	local template = read_template_file("./vimium-c.css.erb")
	if not template then
		return nil, "Failed to read CSS template file."
	end
	local replacements = {
		["{{day_name}}"] = get_display_name(day_name),
		["{{night_name}}"] = get_display_name(night_name),
		["{{day_bg_core}}"] = day_colors.bg_core,
		["{{day_bg_mantle}}"] = day_colors.bg_mantle,
		["{{day_bg_surface}}"] = day_colors.bg_surface,
		["{{day_fg}}"] = day_colors.fg,
		["{{day_fg_dim}}"] = day_colors.fg_dim,
		["{{day_link}}"] = day_colors.link,
		["{{day_border}}"] = day_colors.border,
		["{{day_primary}}"] = day_colors.primary,
		["{{day_light_primary}}"] = day_colors.light_primary,
		["{{day_secondary}}"] = day_colors.secondary,
		["{{day_title_match}}"] = day_colors.title_match,
		["{{day_link_match}}"] = day_colors.link_match,
		["{{night_bg_core}}"] = night_colors.bg_core,
		["{{night_bg_mantle}}"] = night_colors.bg_mantle,
		["{{night_bg_surface}}"] = night_colors.bg_surface,
		["{{night_fg}}"] = night_colors.fg,
		["{{night_link}}"] = night_colors.link,
		["{{night_border}}"] = night_colors.border,
		["{{night_primary}}"] = night_colors.primary,
		["{{night_light_primary}}"] = night_colors.light_primary,
		["{{night_secondary}}"] = night_colors.secondary,
		["{{night_title_match}}"] = night_colors.title_match,
		["{{night_link_match}}"] = night_colors.link_match,
	}

	local css = template
	for pattern, value in pairs(replacements) do
		css = css:gsub(pattern, value)
	end

	return css
end

local function write_file(path, content)
	local file = io.open(path, "w")
	if not file then
		return false, "Could not open file for writing: " .. path
	end

	file:write(content)
	file:close()
	return true
end

local function main(args)
	if args[1] == "--list" or args[1] == "-l" then
		local light_themes, dark_themes, err = list_palettes()
		if err then
			print("Error: " .. err)
			return
		end
		print("\n=== Oasis Vimium-C Themes ===")
		print("\nLight Themes:")
		for i, theme in ipairs(light_themes) do
			print(string.format("  %d. %s", i, theme.display))
		end
		print("\nDark Themes:")
		for i, theme in ipairs(dark_themes) do
			print(string.format("  %d. %s", i, theme.display))
		end
		print()
		return
	end

	if args[1] == "--help" or args[1] == "-h" then
		print([[
Oasis Vimium-C Theme Generator

Usage:
  lua .dev/generate_vimiumc.lua [options]

Options:
  -d, --day THEME     Specify day theme (light mode)
  -n, --night THEME   Specify night theme (dark mode)
  -l, --list          List all available themes
  -h, --help          Show this help

Interactive Mode:
  Running without arguments starts interactive mode where you can
  select day and night themes from a menu.

Examples:
  lua .dev/generate_vimiumc.lua                    # Interactive mode
  lua .dev/generate_vimiumc.lua -d day -n lagoon   # CLI mode
  lua .dev/generate_vimiumc.lua --list             # List themes
]])
		return
	end

	print("\n=== Oasis Vimium-C Theme Generator ===")

	local day_name, night_name

	-- Check for CLI arguments
	local i = 1
	while i <= #args do
		if args[i] == "-d" or args[i] == "--day" then
			day_name = args[i + 1]
			i = i + 2
		elseif args[i] == "-n" or args[i] == "--night" then
			night_name = args[i + 1]
			i = i + 2
		else
			i = i + 1
		end
	end

	-- Interactive mode if not specified via CLI
	if not day_name or not night_name then
		local light_themes, dark_themes, err = list_palettes()
		if err then
			print("Error: " .. err)
			return
		end

		if not day_name then
			local name
			local err
			local is_light = true
			while not day_name do
				local themes = is_light and light_themes or dark_themes
				local label = is_light and "Day theme (light mode)" or "Day theme (dark mode)"
				name, err = select_theme(label, themes)
				if not name then
					print("Error: " .. err)
					return
				end

				if name == "SWITCH_THEME_TYPE" then
					is_light = not is_light
				else
					day_name = name
				end
			end
		end

		if not night_name then
			local name
			local err
			local is_dark = true
			while not night_name do
				local themes = is_dark and dark_themes or light_themes
				local label = is_dark and "Night theme (dark mode)" or "Night theme (light mode)"
				name, err = select_theme(label, themes)
				if not name then
					print("Error: " .. err)
					return
				end

				if name == "SWITCH_THEME_TYPE" then
					is_dark = not is_dark
				else
					night_name = name
				end
			end
		end
	end

	-- Load palettes
	local day_palette, day_err = load_palette(day_name)
	if not day_palette then
		print("Error loading day palette: " .. day_err)
		return
	end

	local night_palette, night_err = load_palette(night_name)
	if not night_palette then
		print("Error loading night palette: " .. night_err)
		return
	end

	-- Generate CSS
	local css = generate_vimiumc_css(day_name, night_name, day_palette, night_palette)

	-- Write to file
	local output_path = string.format("./output/vimiumc-%s-%s.css", night_name, day_name)
	local ok, err = write_file(output_path, css)

	if ok then
		print(string.format("\n✓ Generated: %s", output_path))
		print(string.format("  Day theme: Oasis %s", get_display_name(day_name)))
		print(string.format("  Night theme: Oasis %s\n", get_display_name(night_name)))
	else
		print(string.format("\n✗ Failed: %s\n", err))
	end
end

-- Run the generator
main(arg)
