#!/usr/bin/env lua
-- scripts/analyze_color_usage.lua
-- Script to analyze which colors from palette.lua are actively being used in palette files

local function read_file(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end
	local content = file:read("*all")
	file:close()
	return content
end

local function get_palette_files()
	local files = {}
	local handle = io.popen("ls lua/oasis/color_palettes/oasis_*.lua 2>/dev/null")
	if handle then
		for file in handle:lines() do
			table.insert(files, file)
		end
		handle:close()
	end
	return files
end

-- Extract all color references like p.red.example
local function extract_colors(content)
	local colors = {}
	-- Match p.color.variant but exclude p.theme, p.visual, p.diag, p.terminal, p.light_terminal
	for color, variant in content:gmatch("p%.([a-z]+)%.([a-zA-Z0-9_]+)") do
		if color ~= "theme" and color ~= "visual" and color ~= "diag" and color ~= "terminal" then
			colors[color] = colors[color] or {}
			colors[color][variant] = (colors[color][variant] or 0) + 1
		end
	end
	return colors
end

-- Main analysis
local all_colors = {}
local palette_files = get_palette_files()

print("=== Analyzing Color Usage ===\n")

-- Scan all palette files
for _, file in ipairs(palette_files) do
	local content = read_file(file)
	if content then
		local colors = extract_colors(content)
		for color, variants in pairs(colors) do
			all_colors[color] = all_colors[color] or {}
			for variant, count in pairs(variants) do
				all_colors[color][variant] = (all_colors[color][variant] or 0) + count
			end
		end
	end
end

-- Load actual palette.lua to see what's defined
local palette_content = read_file("lua/oasis/palette.lua")
local defined_colors = {}

if palette_content then
	-- Extract defined colors (very simplified, assumes pattern like: variantname = "#...")
	for color_section in palette_content:gmatch("([a-z]+)%s*=%s*{([^}]+)}") do
		local color, variants_block = color_section:match("^([^{]+){(.+)$")
		if color and variants_block then
			color = color:match("^%s*(.-)%s*$") -- trim
			defined_colors[color] = {}
			for variant in variants_block:gmatch('([a-zA-Z0-9_]+)%s*=%s*"#') do
				defined_colors[color][variant] = true
			end
		end
	end
end

-- Sort colors alphabetically
local sorted_colors = {}
for color in pairs(all_colors) do
	table.insert(sorted_colors, color)
end
table.sort(sorted_colors)

-- Print usage report
for _, color in ipairs(sorted_colors) do
	print(string.format("\n## %s", color:upper()))
	local variants = all_colors[color]
	local sorted_variants = {}
	for variant in pairs(variants) do
		table.insert(sorted_variants, variant)
	end
	table.sort(sorted_variants, function(a, b)
		return variants[b] < variants[a] or (variants[b] == variants[a] and a < b)
	end)

	for _, variant in ipairs(sorted_variants) do
		print(string.format("  ✓ %-30s (used %2d times)", variant, variants[variant]))
	end
end

-- Now find unused colors from palette.lua by actually parsing it
print("\n\n=== POTENTIALLY UNUSED COLORS ===\n")

-- Parse palette.lua to extract defined colors dynamically
local palette_lua_colors = {}
palette_content = read_file("lua/oasis/palette.lua")

if palette_content then
	-- Extract color families and their variants
	-- Looking for pattern inside "local colors = { ... }"
	local inside_colors_table = false
	local current_color = nil
	local brace_depth = 0

	for line in palette_content:gmatch("[^\r\n]+") do
		-- Check if we're entering the main colors table
		if line:match("^local%s+colors%s*=%s*{") then
			inside_colors_table = true
			brace_depth = 1
		elseif inside_colors_table then
			-- At colors table level, look for color family start
			local color_family = line:match("^%s*([a-z]+)%s*=%s*{")
			if
				color_family
				and color_family ~= "terminal"
				and color_family ~= "light_terminal"
				and color_family ~= "visual"
				and color_family ~= "diag"
				and color_family ~= "theme"
			then
				current_color = color_family
				palette_lua_colors[current_color] = {}
			end

			-- Inside a color family, look for variants
			if current_color then
				local variant = line:match('^%s+([a-zA-Z0-9_]+)%s*=%s*"#[%x]+"')
				if variant then
					table.insert(palette_lua_colors[current_color], variant)
				end
			end

			-- Track brace depth to know when to stop
			local open_braces = select(2, line:gsub("{", ""))
			local close_braces = select(2, line:gsub("}", ""))
			brace_depth = brace_depth + open_braces - close_braces

			-- Check if we're closing a color family
			if line:match("^%s*}") and current_color then
				current_color = nil
			end

			if brace_depth == 0 then
				inside_colors_table = false
			end
		end
	end
end

for color, variants in pairs(palette_lua_colors) do
	local unused = {}
	for _, variant in ipairs(variants) do
		if not all_colors[color] or not all_colors[color][variant] then
			table.insert(unused, variant)
		end
	end

	if #unused > 0 then
		print(string.format("\n## %s (%d unused)", color:upper(), #unused))
		for _, variant in ipairs(unused) do
			print(string.format("  ❌ %s", variant))
		end
	end
end

print("\n\n=== SUMMARY ===")
local total_used = 0
local total_defined = 0
for color, variants in pairs(palette_lua_colors) do
	total_defined = total_defined + #variants
	if all_colors[color] then
		for variant in pairs(all_colors[color]) do
			total_used = total_used + 1
		end
	end
end
print(string.format("Total colors defined: %d", total_defined))
print(string.format("Total colors used: %d", total_used))
print(string.format("Total colors unused: %d", total_defined - total_used))
