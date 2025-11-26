#!/usr/bin/env lua
-- extras/fzf/generate_fzf.lua
-- Generates FZF shell scripts from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_fzf_theme(name, palette)
	local display_name = utils.capitalize(name)

	-- FZF color mappings:
	-- bg+: current line background
	-- bg: background
	-- spinner: loading spinner
	-- hl: highlighted substrings
	-- fg: foreground
	-- header: header text
	-- info: info line
	-- pointer: pointer to current line
	-- marker: multi-select marker
	-- fg+: current line foreground
	-- prompt: prompt
	-- hl+: highlighted substrings on current line
	-- selected-bg: selected line background
	-- border: border color
	-- label: label color

	local lines = {
		"#!/bin/bash",
		"# extras/fzf/oasis_" .. name .. ".sh",
		"# Oasis " .. display_name .. " theme for FZF",
		"# Author: uhs-robert",
		"",
		'export FZF_DEFAULT_OPTS=" \\',
		string.format(
			"--color=bg+:%s,bg:%s,spinner:%s,hl:%s \\",
			palette.ui.cursorLine, -- bg+: Current line background
			palette.bg.core, -- bg: Background
			palette.theme.accent, -- spinner: Loading spinner
			palette.theme.primary -- hl: Highlighted substrings
		),
		string.format(
			"--color=fg:%s,header:%s,info:%s,pointer:%s \\",
			palette.fg.core, -- fg: Foreground
			palette.syntax.exception, -- header: Header text
			palette.theme.primary, -- info: Info line
			palette.theme.accent -- pointer: Current line pointer
		),
		string.format(
			"--color=marker:%s,fg+:%s,prompt:%s,hl+:%s \\",
			palette.theme.secondary, -- marker: Multi-select marker
			palette.fg.core, -- fg+: Current line foreground
			palette.theme.primary, -- prompt: Prompt
			palette.ui.match.bg -- hl+: Highlighted substrings on current line
		),
		string.format("--color=selected-bg:%s \\", palette.ui.visual.bg), -- selected-bg: Selected line background
		string.format(
			'--color=border:%s,label:%s"',
			palette.ui.border, -- border: Border color
			palette.fg.core -- label: Label color
		),
	}

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis FZF Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count = 0
	local error_count = 0

	for _, name in ipairs(palette_names) do
		local palette = utils.load_palette(name)
		local theme = generate_fzf_theme(name, palette)
		local fzf_path = string.format("extras/fzf/oasis_%s.sh", name)
		utils.write_file(fzf_path, theme)
		print(string.format("✓ Generated: %s", fzf_path))
		success_count = success_count + 1
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
