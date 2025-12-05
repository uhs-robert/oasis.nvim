#!/usr/bin/env lua
-- extras/json-theme/generate_jsontheme.lua
-- Generates flat JSON palette files from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local terminal_semantic_keys = {
	"black",
	"red",
	"green",
	"yellow",
	"blue",
	"magenta",
	"cyan",
	"white",
	"bright_black",
	"bright_red",
	"bright_green",
	"bright_yellow",
	"bright_blue",
	"bright_magenta",
	"bright_cyan",
	"bright_white",
}

local terminal_numeric_keys = (function()
	local keys = {}
	for i = 0, 15 do
		keys[#keys + 1] = "color" .. i
	end
	return keys
end)()

local diag_key_map = {
	{ palette = "error", output = "error" },
	{ palette = "warn", output = "warning" },
	{ palette = "info", output = "info" },
	{ palette = "hint", output = "hint" },
	{ palette = "ok", output = "ok" },
}

local function get_diag_fg(diag, key)
	local target = diag[key]
	if not target then
		return ""
	end
	return target.fg or target.fg_light or ""
end

local function generate_json_palette(name, palette)
	local diag = (palette.ui and palette.ui.diag) or {}

	local kv = {}

	-- Backgrounds
	kv[#kv + 1] = { "bg_core", palette.bg.core }
	kv[#kv + 1] = { "bg_mantle", palette.bg.mantle }
	kv[#kv + 1] = { "bg_shadow", palette.bg.shadow }
	kv[#kv + 1] = { "bg_surface", palette.bg.surface }

	-- Foregrounds
	kv[#kv + 1] = { "fg_core", palette.fg.core }
	kv[#kv + 1] = { "fg_strong", palette.fg.strong }
	kv[#kv + 1] = { "fg_muted", palette.fg.muted }
	kv[#kv + 1] = { "fg_dim", palette.fg.dim }

	-- Accents
	kv[#kv + 1] = { "theme_primary", palette.theme.primary }
	kv[#kv + 1] = { "theme_secondary", palette.theme.secondary }
	kv[#kv + 1] = { "theme_accent", palette.theme.accent }

	-- Status
	for _, mapping in ipairs(diag_key_map) do
		kv[#kv + 1] = { mapping.output, get_diag_fg(diag, mapping.palette) }
	end

	-- ANSI Semantic Colors
	for _, key in ipairs(terminal_semantic_keys) do
		kv[#kv + 1] = { key, palette.terminal[key] }
	end

	-- ANSI Terminal Colors
	for _, key in ipairs(terminal_numeric_keys) do
		kv[#kv + 1] = { key, palette.terminal[key] }
	end

	-- Build JSON string manually to keep ordering predictable
	local lines = {
		"{",
	}

	for i, pair in ipairs(kv) do
		local key, value = pair[1], pair[2]
		local comma = (i == #kv) and "" or ","
		lines[#lines + 1] = string.format('  "%s": "%s"%s', key, value, comma)
	end

	lines[#lines + 1] = "}"

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis JSON Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = utils.for_each_palette_variant(function(name, palette, mode, intensity)
		local output_path, variant_name = utils.build_variant_path("extras/json-theme", "json", name, mode, intensity)
		local content = generate_json_palette(variant_name, palette)
		utils.write_file(output_path, content)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print("\n=== Summary ===")
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

main()
