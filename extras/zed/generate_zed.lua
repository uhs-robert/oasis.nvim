#!/usr/bin/env lua
-- extras/zed/generate_zed.lua
-- Generates Zed Editor themes from Oasis color palettes

local function get_palette_files()
	local handle = io.popen("ls lua/oasis/color_palettes/oasis_*.lua 2>/dev/null")
	local result = handle:read("*a")
	handle:close()

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
	package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"

	local palette_name = "oasis_" .. name
	local ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)

	if not ok then
		return nil, "Failed to load palette: " .. palette
	end

	return palette
end

local function capitalize(str)
	return str:gsub("^%l", string.upper)
end

-- Add alpha channel to hex color
local function with_alpha(color, alpha)
	if not color or color == "NONE" or color == "" then
		return "#00000000"
	end
	-- Remove any existing alpha
	local hex = color:match("^#?(%x+)")
	if not hex then
		return "#00000000"
	end
	if #hex == 8 then
		hex = hex:sub(1, 6)
	end
	return "#" .. hex .. alpha
end

-- Darken or lighten a color (simplified version)
local function adjust_brightness(color, factor)
	if not color or color == "NONE" then
		return color
	end

	local hex = color:match("^#?(%x%x)(%x%x)(%x%x)")
	if not hex then
		return color
	end

	local r, g, b = color:match("^#?(%x%x)(%x%x)(%x%x)")
	r = tonumber(r, 16)
	g = tonumber(g, 16)
	b = tonumber(b, 16)

	r = math.floor(math.min(255, math.max(0, r * factor)))
	g = math.floor(math.min(255, math.max(0, g * factor)))
	b = math.floor(math.min(255, math.max(0, b * factor)))

	return string.format("#%02x%02x%02x", r, g, b)
end

-- Escape string for JSON
local function json_escape(str)
	if type(str) ~= "string" then
		return str
	end
	return str:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("\n", "\\n"):gsub("\r", "\\r"):gsub("\t", "\\t")
end

-- Simple JSON encoder for our specific use case
local function encode_json(obj, indent)
	indent = indent or 0
	local indent_str = string.rep("  ", indent)
	local next_indent_str = string.rep("  ", indent + 1)

	if type(obj) == "string" then
		return '"' .. json_escape(obj) .. '"'
	elseif type(obj) == "number" or type(obj) == "boolean" then
		return tostring(obj)
	elseif type(obj) == "nil" then
		return "null"
	elseif type(obj) == "table" then
		-- Check if it's an array
		local is_array = false
		local max_index = 0
		for k, _ in pairs(obj) do
			if type(k) == "number" and k > 0 then
				is_array = true
				max_index = math.max(max_index, k)
			else
				is_array = false
				break
			end
		end

		if is_array and max_index == #obj then
			-- Array
			local parts = {}
			for i = 1, #obj do
				table.insert(parts, next_indent_str .. encode_json(obj[i], indent + 1))
			end
			if #parts == 0 then
				return "[]"
			end
			return "[\n" .. table.concat(parts, ",\n") .. "\n" .. indent_str .. "]"
		else
			-- Object
			local parts = {}
			local keys = {}
			for k in pairs(obj) do
				table.insert(keys, k)
			end
			table.sort(keys)

			for _, k in ipairs(keys) do
				local v = obj[k]
				local key_str = '"' .. json_escape(tostring(k)) .. '"'
				local value_str = encode_json(v, indent + 1)
				table.insert(parts, next_indent_str .. key_str .. ": " .. value_str)
			end

			if #parts == 0 then
				return "{}"
			end
			return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent_str .. "}"
		end
	end

	return "null"
end

local function generate_zed_theme(name, palette)
	local display_name = capitalize(name)
	local is_light = palette.light_mode or false
	local term = palette.terminal -- Each Oasis palette defines its own terminal table

	-- Calculate adjusted colors for UI states
	local hover_bg = is_light and adjust_brightness(palette.bg.mantle, 0.95)
		or adjust_brightness(palette.bg.surface, 1.1)
	local active_bg = is_light and adjust_brightness(palette.bg.mantle, 0.9)
		or adjust_brightness(palette.bg.surface, 1.2)

	-- Generate player colors from theme accents
	local player_colors = {
		{
			cursor = palette.theme.primary,
			background = palette.theme.primary,
			selection = with_alpha(palette.theme.primary, "3d"),
		},
		{
			cursor = palette.theme.secondary,
			background = palette.theme.secondary,
			selection = with_alpha(palette.theme.secondary, "3d"),
		},
		{
			cursor = palette.theme.accent,
			background = palette.theme.accent,
			selection = with_alpha(palette.theme.accent, "3d"),
		},
		{
			cursor = palette.syntax.func,
			background = palette.syntax.func,
			selection = with_alpha(palette.syntax.func, "3d"),
		},
		{
			cursor = palette.syntax.string,
			background = palette.syntax.string,
			selection = with_alpha(palette.syntax.string, "3d"),
		},
		{
			cursor = palette.syntax.type,
			background = palette.syntax.type,
			selection = with_alpha(palette.syntax.type, "3d"),
		},
		{
			cursor = palette.syntax.constant,
			background = palette.syntax.constant,
			selection = with_alpha(palette.syntax.constant, "3d"),
		},
		{
			cursor = palette.syntax.keyword,
			background = palette.syntax.keyword,
			selection = with_alpha(palette.syntax.keyword, "3d"),
		},
	}

	local theme = {
		["$schema"] = "https://zed.dev/schema/themes/v0.2.0.json",
		name = "Oasis " .. display_name,
		author = "sjoeboo",
		themes = {
			{
				name = "Oasis " .. display_name,
				appearance = is_light and "light" or "dark",
				style = {
					-- Border colors
					border = palette.fg.dim, -- Subtle borders between panels
					["border.variant"] = palette.bg.surface, -- Even more subtle dividers
					["border.focused"] = palette.theme.primary, -- Bright accent for focused
					["border.selected"] = palette.theme.primary,
					["border.transparent"] = "#00000000",
					["border.disabled"] = palette.bg.shadow,

					-- Surface colors
					["elevated_surface.background"] = palette.bg.surface,
					["surface.background"] = palette.bg.mantle,
					background = palette.bg.core,

					-- Element states
					["element.background"] = palette.bg.mantle,
					["element.hover"] = hover_bg,
					["element.active"] = active_bg,
					["element.selected"] = active_bg,
					["element.disabled"] = palette.bg.shadow,

					-- Drop target
					["drop_target.background"] = with_alpha(palette.theme.primary, "40"),

					-- Ghost elements
					["ghost_element.background"] = "#00000000",
					["ghost_element.hover"] = palette.bg.mantle,
					["ghost_element.active"] = palette.bg.surface,
					["ghost_element.selected"] = palette.bg.surface,
					["ghost_element.disabled"] = palette.bg.shadow,

					-- Text colors
					text = palette.fg.core,
					["text.muted"] = palette.fg.muted,
					["text.placeholder"] = palette.fg.dim,
					["text.disabled"] = palette.fg.dim,
					["text.accent"] = palette.theme.primary,

					-- Icon colors
					icon = palette.fg.core,
					["icon.muted"] = palette.fg.muted,
					["icon.disabled"] = palette.fg.dim,
					["icon.placeholder"] = palette.fg.dim,
					["icon.accent"] = palette.theme.primary,

					-- Status bar
					["status_bar.background"] = palette.bg.surface,

					-- Title bar
					["title_bar.background"] = palette.bg.mantle,
					["title_bar.inactive_background"] = palette.bg.shadow,

					-- Toolbar
					["toolbar.background"] = palette.bg.core,

					-- Tabs
					["tab_bar.background"] = palette.bg.mantle,
					["tab.inactive_background"] = palette.bg.mantle,
					["tab.active_background"] = palette.bg.core,

					-- Search
					["search.match_background"] = with_alpha(palette.ui.search.bg, "66"),

					-- Panel
					["panel.background"] = palette.bg.mantle,
					["panel.focused_border"] = nil,

					-- Pane
					["pane.focused_border"] = nil,

					-- Scrollbar
					["scrollbar.thumb.background"] = with_alpha(palette.fg.dim, "4c"),
					["scrollbar.thumb.hover_background"] = palette.bg.surface,
					["scrollbar.thumb.border"] = palette.bg.surface,
					["scrollbar.track.background"] = "#00000000",
					["scrollbar.track.border"] = palette.bg.shadow,

					-- Editor
					["editor.foreground"] = palette.fg.core,
					["editor.background"] = palette.bg.core,
					["editor.gutter.background"] = palette.bg.core,
					["editor.subheader.background"] = palette.bg.mantle,
					["editor.active_line.background"] = with_alpha(palette.ui.cursorLine, "bf"),
					["editor.highlighted_line.background"] = palette.ui.cursorLine,
					["editor.line_number"] = palette.fg.muted,
					["editor.active_line_number"] = palette.ui.lineNumber,
					["editor.invisible"] = palette.ui.nontext or palette.fg.dim,
					["editor.wrap_guide"] = with_alpha(palette.fg.dim, "0d"),
					["editor.active_wrap_guide"] = with_alpha(palette.fg.dim, "1a"),
					["editor.document_highlight.read_background"] = with_alpha(palette.theme.primary, "1a"),
					["editor.document_highlight.write_background"] = with_alpha(palette.fg.muted, "33"),

					-- Terminal
					["terminal.background"] = palette.bg.core,
					["terminal.foreground"] = palette.fg.core,
					["terminal.bright_foreground"] = palette.fg.strong,
					["terminal.dim_foreground"] = palette.fg.dim,
					["terminal.ansi.black"] = term.color0,
					["terminal.ansi.bright_black"] = term.color8,
					["terminal.ansi.dim_black"] = palette.fg.dim,
					["terminal.ansi.red"] = term.color1,
					["terminal.ansi.bright_red"] = term.color9,
					["terminal.ansi.dim_red"] = adjust_brightness(term.color1, 0.7),
					["terminal.ansi.green"] = term.color2,
					["terminal.ansi.bright_green"] = term.color10,
					["terminal.ansi.dim_green"] = adjust_brightness(term.color2, 0.7),
					["terminal.ansi.yellow"] = term.color3,
					["terminal.ansi.bright_yellow"] = term.color11,
					["terminal.ansi.dim_yellow"] = adjust_brightness(term.color3, 0.7),
					["terminal.ansi.blue"] = term.color4,
					["terminal.ansi.bright_blue"] = term.color12,
					["terminal.ansi.dim_blue"] = adjust_brightness(term.color4, 0.7),
					["terminal.ansi.magenta"] = term.color5,
					["terminal.ansi.bright_magenta"] = term.color13,
					["terminal.ansi.dim_magenta"] = adjust_brightness(term.color5, 0.7),
					["terminal.ansi.cyan"] = term.color6,
					["terminal.ansi.bright_cyan"] = term.color14,
					["terminal.ansi.dim_cyan"] = adjust_brightness(term.color6, 0.7),
					["terminal.ansi.white"] = term.color7,
					["terminal.ansi.bright_white"] = term.color15,
					["terminal.ansi.dim_white"] = adjust_brightness(term.color7, 0.7),

					-- Link
					["link_text.hover"] = palette.theme.primary,

					-- Version control
					["version_control.added"] = palette.diff.add,
					["version_control.modified"] = palette.diff.change,
					["version_control.deleted"] = palette.diff.delete,

					-- Conflict
					conflict = palette.ui.diag.error.fg,
					["conflict.background"] = with_alpha(palette.ui.diag.error.bg, "1a"),
					["conflict.border"] = palette.ui.diag.error.fg,

					-- Created
					created = palette.diff.add,
					["created.background"] = with_alpha(palette.diff.add, "1a"),
					["created.border"] = palette.diff.add,

					-- Deleted
					deleted = palette.diff.delete,
					["deleted.background"] = with_alpha(palette.diff.delete, "1a"),
					["deleted.border"] = palette.diff.delete,

					-- Error
					error = palette.ui.diag.error.fg,
					["error.background"] = with_alpha(palette.ui.diag.error.bg, "1a"),
					["error.border"] = palette.ui.diag.error.fg,

					-- Hidden
					hidden = palette.fg.dim,
					["hidden.background"] = with_alpha(palette.fg.dim, "1a"),
					["hidden.border"] = palette.fg.dim,

					-- Hint
					hint = palette.ui.diag.hint.fg,
					["hint.background"] = with_alpha(palette.ui.diag.hint.bg, "1a"),
					["hint.border"] = palette.ui.diag.hint.fg,

					-- Ignored
					ignored = palette.fg.dim,
					["ignored.background"] = with_alpha(palette.fg.dim, "1a"),
					["ignored.border"] = palette.fg.muted,

					-- Info
					info = palette.ui.diag.info.fg,
					["info.background"] = with_alpha(palette.ui.diag.info.bg, "1a"),
					["info.border"] = palette.ui.diag.info.fg,

					-- Modified
					modified = palette.diff.change,
					["modified.background"] = with_alpha(palette.diff.change, "1a"),
					["modified.border"] = palette.diff.change,

					-- Predictive
					predictive = palette.fg.dim,
					["predictive.background"] = with_alpha(palette.bg.shadow, "1a"),
					["predictive.border"] = palette.fg.dim,

					-- Renamed
					renamed = palette.ui.diag.info.fg,
					["renamed.background"] = with_alpha(palette.ui.diag.info.bg, "1a"),
					["renamed.border"] = palette.ui.diag.info.fg,

					-- Success
					success = palette.ui.diag.ok.fg,
					["success.background"] = with_alpha(palette.ui.diag.ok.bg, "1a"),
					["success.border"] = palette.ui.diag.ok.fg,

					-- Unreachable
					unreachable = palette.fg.muted,
					["unreachable.background"] = with_alpha(palette.fg.muted, "1a"),
					["unreachable.border"] = palette.fg.muted,

					-- Warning
					warning = palette.ui.diag.warn.fg,
					["warning.background"] = with_alpha(palette.ui.diag.warn.bg, "1a"),
					["warning.border"] = palette.ui.diag.warn.fg,

					-- Players (multiplayer cursors)
					players = player_colors,

					-- Syntax highlighting
					syntax = {
						-- Attributes (decorators, annotations)
						attribute = {
							color = palette.syntax.special,
							font_style = nil,
							font_weight = nil,
						},

						-- Boolean
						boolean = {
							color = palette.syntax.constant,
							font_style = nil,
							font_weight = 700,
						},

						-- Comments
						comment = {
							color = palette.syntax.comment,
							font_style = "italic",
							font_weight = nil,
						},
						["comment.doc"] = {
							color = palette.syntax.comment,
							font_style = "italic",
							font_weight = nil,
						},

						-- Constants
						constant = {
							color = palette.syntax.constant,
							font_style = nil,
							font_weight = nil,
						},

						-- Constructor
						constructor = {
							color = palette.syntax.keyword,
							font_style = nil,
							font_weight = nil,
						},

						-- Embedded code
						embedded = {
							color = palette.fg.core,
							font_style = nil,
							font_weight = nil,
						},

						-- Emphasis (markdown)
						emphasis = {
							color = palette.theme.primary,
							font_style = "italic",
							font_weight = nil,
						},
						["emphasis.strong"] = {
							color = palette.syntax.keyword,
							font_style = nil,
							font_weight = 700,
						},

						-- Enum
						enum = {
							color = palette.syntax.type,
							font_style = nil,
							font_weight = nil,
						},

						-- Functions
						["function"] = {
							color = palette.syntax.func,
							font_style = nil,
							font_weight = nil,
						},

						-- Hint
						hint = {
							color = palette.ui.diag.hint.fg,
							font_style = nil,
							font_weight = nil,
						},

						-- Keywords
						keyword = {
							color = palette.syntax.keyword,
							font_style = nil,
							font_weight = nil,
						},

						-- Labels
						label = {
							color = palette.syntax.keyword,
							font_style = nil,
							font_weight = nil,
						},

						-- Links
						link_text = {
							color = palette.syntax.special,
							font_style = "underline",
							font_weight = nil,
						},
						link_uri = {
							color = palette.syntax.type,
							font_style = nil,
							font_weight = nil,
						},

						-- Number
						number = {
							color = palette.syntax.constant,
							font_style = nil,
							font_weight = nil,
						},

						-- Operator
						operator = {
							color = palette.syntax.operator,
							font_style = nil,
							font_weight = nil,
						},

						-- Predictive
						predictive = {
							color = palette.fg.dim,
							font_style = "italic",
							font_weight = nil,
						},

						-- Preprocessor
						preproc = {
							color = palette.syntax.preproc,
							font_style = nil,
							font_weight = nil,
						},

						-- Primary
						primary = {
							color = palette.fg.core,
							font_style = nil,
							font_weight = nil,
						},

						-- Property
						property = {
							color = palette.syntax.identifier,
							font_style = nil,
							font_weight = nil,
						},

						-- Punctuation
						punctuation = {
							color = palette.syntax.punctuation,
							font_style = nil,
							font_weight = nil,
						},
						["punctuation.bracket"] = {
							color = palette.syntax.bracket,
							font_style = nil,
							font_weight = nil,
						},
						["punctuation.delimiter"] = {
							color = palette.syntax.delimiter,
							font_style = nil,
							font_weight = nil,
						},
						["punctuation.list_marker"] = {
							color = palette.syntax.operator,
							font_style = nil,
							font_weight = nil,
						},
						["punctuation.special"] = {
							color = palette.syntax.operator,
							font_style = nil,
							font_weight = nil,
						},

						-- String
						string = {
							color = palette.syntax.string,
							font_style = nil,
							font_weight = nil,
						},
						["string.escape"] = {
							color = palette.syntax.regex,
							font_style = nil,
							font_weight = 700,
						},
						["string.regex"] = {
							color = palette.syntax.regex,
							font_style = nil,
							font_weight = nil,
						},
						["string.special"] = {
							color = palette.syntax.special,
							font_style = nil,
							font_weight = nil,
						},
						["string.special.symbol"] = {
							color = palette.syntax.identifier,
							font_style = nil,
							font_weight = nil,
						},

						-- Tag (HTML/XML)
						tag = {
							color = palette.syntax.type,
							font_style = nil,
							font_weight = nil,
						},

						-- Text literal
						["text.literal"] = {
							color = palette.syntax.string,
							font_style = nil,
							font_weight = nil,
						},

						-- Title
						title = {
							color = palette.syntax.func,
							font_style = nil,
							font_weight = 700,
						},

						-- Type
						type = {
							color = palette.syntax.type,
							font_style = nil,
							font_weight = nil,
						},

						-- Variable
						variable = {
							color = palette.fg.core,
							font_style = nil,
							font_weight = nil,
						},
						["variable.special"] = {
							color = palette.syntax.builtinVar,
							font_style = nil,
							font_weight = nil,
						},

						-- Variant
						variant = {
							color = palette.syntax.type,
							font_style = nil,
							font_weight = nil,
						},
					},
				},
			},
		},
	}

	return theme
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

local function main()
	print("\n=== Oasis Zed Theme Generator ===\n")

	local palette_names = get_palette_files()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count = 0
	local error_count = 0

	for _, name in ipairs(palette_names) do
		local palette, err = load_palette(name)

		if not palette then
			print(string.format("✗ Failed to load %s: %s", name, err))
			error_count = error_count + 1
		else
			local theme = generate_zed_theme(name, palette)
			local json = encode_json(theme, 0)
			local zed_path = string.format("extras/zed/oasis_%s.json", name)
			local ok, write_err = write_file(zed_path, json)

			if ok then
				print(string.format("✓ Generated: %s", zed_path))
				success_count = success_count + 1
			else
				print(string.format("✗ Failed to write: %s", write_err))
				error_count = error_count + 1
			end
		end
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
