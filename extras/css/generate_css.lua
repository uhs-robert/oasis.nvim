#!/usr/bin/env lua
-- extras/css/generate_css.lua
-- Generates CSS custom property themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

-- Convert a key into kebab-case for CSS custom properties
local function to_kebab(key)
	local str_key = tostring(key)
	return str_key:gsub("_", "-")
end

-- Stable sort for mixed string/number keys
local function sorted_keys(tbl)
	local keys = {}
	for k, _ in pairs(tbl) do
		keys[#keys + 1] = k
	end

	table.sort(keys, function(a, b)
		local ta, tb = type(a), type(b)
		if ta == tb then
			if ta == "number" then
				return a < b
			end
			return tostring(a) < tostring(b)
		end
		if ta == "number" then
			return true
		end
		if tb == "number" then
			return false
		end
		return tostring(a) < tostring(b)
	end)

	return keys
end

-- Recursively flatten palette tables into CSS custom properties
local function append_properties(lines, prefix, value)
	if type(value) == "table" then
		for _, key in ipairs(sorted_keys(value)) do
			append_properties(lines, prefix .. "-" .. to_kebab(key), value[key])
		end
		return
	end

	if type(value) == "string" then
		lines[#lines + 1] = string.format("\t--%s: %s;", prefix, value)
	end
end

local function build_selectors(variant_name)
	return table.concat({
		":root",
		"[data-oasis-theme=\"" .. variant_name .. "\"]",
		".oasis-" .. variant_name,
	}, ",\n")
end

local function generate_css_theme(variant_name, palette, mode, intensity, output_path)
	local display_name = utils.format_display_name(variant_name)
	local selectors = build_selectors(variant_name)

	local lines = {}
	local function add(line)
		if line ~= nil then
			lines[#lines + 1] = line
		end
	end

	add("/* " .. (output_path or ("extras/css/themes/oasis_" .. variant_name .. ".css")))
	add(" * name: " .. display_name)
	add(" * author: uhs-robert")
	add(mode and (" * mode: " .. mode) or nil)
	add(intensity and (" * light intensity: " .. intensity) or nil)
	add(" */")
	add("")
	add(selectors .. " {")
	add(string.format("\t--oasis-name: \"%s\";", display_name))
	add(mode and string.format("\t--oasis-mode: \"%s\";", mode) or nil)
	add(intensity and string.format("\t--oasis-light-intensity: %d;", intensity) or nil)

	append_properties(lines, "oasis", palette)
	add("}")

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis CSS Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = utils.for_each_palette_variant(function(name, palette, mode, intensity)
		local output_path, variant_name = utils.build_variant_path("extras/css", "css", name, mode, intensity)

		local css = generate_css_theme(variant_name, palette, mode, intensity, output_path)
		utils.write_file(output_path, css)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

main()
