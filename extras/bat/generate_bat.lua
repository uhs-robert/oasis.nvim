#!/usr/bin/env lua
-- extras/bat/generate_bat.lua
-- Generates bat (syntect) .tmTheme files from Oasis palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

-- XML escape helper
local function xml_escape(str)
	if not str then
		return ""
	end
	str = str:gsub("&", "&amp;")
	str = str:gsub("<", "&lt;")
	str = str:gsub(">", "&gt;")
	str = str:gsub('"', "&quot;")
	str = str:gsub("'", "&apos;")
	return str
end

-- Generate a tmTheme color scheme for bat
local function generate_bat_theme(display_name, palette)
	local lines = {
		'<?xml version="1.0" encoding="UTF-8"?>',
		'<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
		'<plist version="1.0">',
		"<dict>",
		"\t<key>name</key>",
		"\t<string>" .. xml_escape(display_name) .. "</string>",
		"\t<key>author</key>",
		"\t<string>uhs-robert</string>",
		"\t<key>settings</key>",
		"\t<array>",
		"\t\t<!-- Global Settings -->",
		"\t\t<dict>",
		"\t\t\t<key>settings</key>",
		"\t\t\t<dict>",
		"\t\t\t\t<key>background</key>",
		"\t\t\t\t<string>" .. palette.bg.core .. "</string>",
		"\t\t\t\t<key>foreground</key>",
		"\t\t\t\t<string>" .. palette.fg.core .. "</string>",
		"\t\t\t\t<key>caret</key>",
		"\t\t\t\t<string>" .. palette.theme.primary .. "</string>",
		"\t\t\t\t<key>lineHighlight</key>",
		"\t\t\t\t<string>" .. (palette.ui.cursorLine or palette.bg.surface) .. "</string>",
		"\t\t\t\t<key>selection</key>",
		"\t\t\t\t<string>" .. palette.ui.visual.bg .. "</string>",
		"\t\t\t\t<key>selectionForeground</key>",
		"\t\t\t\t<string>" .. palette.fg.core .. "</string>",
		"\t\t\t\t<key>findHighlight</key>",
		"\t\t\t\t<string>" .. palette.ui.curSearch.bg .. "</string>",
		"\t\t\t\t<key>findHighlightForeground</key>",
		"\t\t\t\t<string>" .. palette.bg.core .. "</string>",
		"\t\t\t</dict>",
		"\t\t</dict>",
	}

	-- Helper function to add a scope rule
	local function add_scope(name, scope, fg, font_style)
		if not fg and not font_style then
			return
		end

		lines[#lines + 1] = "\t\t<dict>"
		lines[#lines + 1] = "\t\t\t<key>name</key>"
		lines[#lines + 1] = "\t\t\t<string>" .. xml_escape(name) .. "</string>"
		lines[#lines + 1] = "\t\t\t<key>scope</key>"
		lines[#lines + 1] = "\t\t\t<string>" .. xml_escape(scope) .. "</string>"
		lines[#lines + 1] = "\t\t\t<key>settings</key>"
		lines[#lines + 1] = "\t\t\t<dict>"
		if fg then
			lines[#lines + 1] = "\t\t\t\t<key>foreground</key>"
			lines[#lines + 1] = "\t\t\t\t<string>" .. fg .. "</string>"
		end
		if font_style ~= nil then
			lines[#lines + 1] = "\t\t\t\t<key>fontStyle</key>"
			if font_style == "" then
				lines[#lines + 1] = "\t\t\t\t<string/>"
			else
				lines[#lines + 1] = "\t\t\t\t<string>" .. font_style .. "</string>"
			end
		end
		lines[#lines + 1] = "\t\t\t</dict>"
		lines[#lines + 1] = "\t\t</dict>"
	end

	-- Mappings based on lua/oasis/theme_generator.lua
	lines[#lines + 1] = "\t\t<!-- Base Syntax -->"

	add_scope(
		"Comment",
		"comment, punctuation.definition.comment, comment.line, comment.block",
		palette.syntax.comment,
		"italic"
	)
	add_scope("String", "string, string.quoted, string.unquoted", palette.syntax.string)
	add_scope(
		"String quotes",
		"punctuation.definition.string.begin, punctuation.definition.string.end, string.quoted.single punctuation, string.quoted.double punctuation",
		palette.syntax.punctuation
	)
	add_scope(
		"Constants, booleans, numbers",
		"constant.numeric, variable.other.constant, entity.name.constant, constant.language.boolean, constant.language.false, constant.language.true, keyword.other.unit.user-defined, keyword.other.unit.suffix.floating-point",
		palette.syntax.constant
	)
	add_scope("Variable", "variable, variable.other, variable.other.readwrite, variable.other.object", palette.fg.core)
	add_scope("Parameter", "variable.parameter, meta.parameter, meta.parameters variable", palette.syntax.parameter)
	add_scope(
		"Built-in constant",
		"constant.language, support.constant, support.function.builtin, constant.other.caps",
		palette.syntax.builtinConst,
		"italic"
	)
	add_scope(
		"Built-in variable",
		"variable.language, variable.language.this, variable.language.self, variable.language.super",
		palette.syntax.builtinVar
	)
	add_scope(
		"Built-in types",
		"constant.language.null.js, constant.language.null.ts, constant.language.undefined.js, constant.language.undefined.ts, support.type.builtin.ts",
		palette.syntax.type
	)
	add_scope("Built-in function", "support.function.builtin, support.function.magic", palette.syntax.builtinFunc)
	add_scope(
		"Character, escape",
		"constant.character, constant.character.escape, constant.other.placeholder",
		palette.syntax.exception
	)
	add_scope("Entity name", "entity.name, entity.other.inherited-class", palette.syntax.identifier)
	add_scope(
		"Function",
		"entity.name.function, entity.name.method, support.function, meta.function-call, meta.function-call.generic, meta.method-call, meta.method.declaration",
		palette.syntax.func
	)
	add_scope(
		"Variable member",
		"variable.other.member, variable.other.property, variable.member",
		palette.syntax.identifier
	)
	add_scope(
		"Keyword, storage",
		"keyword, storage, storage.type.function.arrow, keyword.declaration, keyword.other",
		palette.syntax.statement
	)
	add_scope(
		"Control flow",
		"keyword.control.conditional, keyword.control.repeat, keyword.control.loop, keyword.control.flow, keyword.control.switch, storage.modifier.conditional, keyword.control.if, keyword.control.else, keyword.control.for, keyword.control.while",
		palette.syntax.conditional
	)
	add_scope(
		"Exception, return",
		"keyword.control.exception, keyword.control.return, keyword.control.yield, keyword.control.trycatch, keyword.control.throw",
		palette.syntax.exception,
		"italic"
	)
	add_scope(
		"Operator",
		"keyword.operator, keyword.operator.arithmetic, keyword.operator.logical, keyword.operator.assignment, keyword.operator.bitwise, keyword.operator.comparison, keyword.operator.relational, keyword.operator.word, punctuation.accessor, punctuation.accessor.dot, punctuation.accessor.arrow, punctuation.separator.pointer-access, punctuation.definition.tag",
		palette.syntax.operator
	)
	add_scope(
		"Punctuation",
		"punctuation.separator, punctuation.terminator, punctuation.delimiter, punctuation.separator.comma, punctuation.separator.period, punctuation.separator.semicolon",
		palette.syntax.punctuation
	)
	add_scope(
		"Bracket",
		"punctuation.section, punctuation.bracket, meta.brace, punctuation.section.block, punctuation.section.parens, punctuation.section.brackets, punctuation.definition.parameters, punctuation.definition.arguments",
		palette.syntax.bracket
	)
	add_scope(
		"Preprocessor, import",
		"meta.preprocessor, keyword.control.import, keyword.control.directive, keyword.control.at-rule, meta.import, keyword.control.include",
		palette.syntax.preproc
	)
	add_scope(
		"Type",
		"entity.name.type, entity.name.class, entity.name.interface, entity.name.enum, storage.type, storage.type.class, storage.type.interface, storage.type.enum, support.type, support.class",
		palette.syntax.type
	)
	add_scope(
		"Storage modifier",
		"storage.modifier, storage.modifier.static, storage.modifier.const, storage.modifier.async, storage.modifier.reference, storage.modifier.pointer",
		palette.syntax.type
	)
	add_scope(
		"Structure",
		"entity.name.struct, storage.type.struct, storage.type.union, keyword.declaration.struct, entity.name.union",
		palette.ui.diag.info.fg
	)
	add_scope(
		"Special",
		"constant.other.symbol, keyword.other.special, support.constant, support.variable.magic",
		palette.syntax.special
	)
	add_scope(
		"Regex",
		"string.regexp, string.regexp.ts, constant.other.character-class.regexp, constant.other.character-class.set.regexp",
		palette.syntax.regex
	)
	add_scope(
		"Regex escape",
		"constant.character.escape.regexp, keyword.operator.or.regexp",
		palette.syntax.regex,
		"bold"
	)
	add_scope("Entity Name Tag", "entity.name.tag, meta.tag", palette.syntax.special)
	add_scope("Meta Tag", "meta.tag", palette.syntax.exception)
	add_scope("Tag attribute", "entity.other.attribute-name, meta.attribute", palette.syntax.parameter)
	add_scope("Invalid", "invalid, invalid.illegal, invalid.broken", palette.ui.diag.error.fg)
	add_scope("Deprecated", "invalid.deprecated", palette.ui.diag.warn.fg)

	-- Language-specific
	lines[#lines + 1] = "\t\t<!-- Regular Expressions -->"
	add_scope(
		"Regex string begin/end",
		"string.regexp punctuation.definition.string.begin, string.regexp punctuation.definition.string.end",
		palette.syntax.punctuation
	)
	add_scope("Regex anchors", "keyword.control.anchor.regexp", palette.syntax.conditional)
	add_scope(
		"Regex group, backreference",
		"punctuation.definition.group.regexp, keyword.other.back-reference.regexp",
		palette.syntax.regex
	)
	add_scope(
		"Regex character class",
		"punctuation.definition.character-class.regexp, constant.other.character-class.regexp",
		palette.syntax.regex
	)
	add_scope("Regex range", "constant.other.character-class.range.regexp", palette.fg.muted)
	add_scope("Regex quantifier", "keyword.operator.quantifier.regexp", palette.syntax.operator)
	add_scope(
		"Regex lookaheads",
		"punctuation.definition.group.no-capture.regexp, meta.assertion.look-ahead.regexp, meta.assertion.negative-look-ahead.regexp",
		palette.syntax.conditional
	)

	lines[#lines + 1] = "\t\t<!-- Python -->"
	add_scope("Python type hints", "meta.function.parameters.python", palette.fg.core)

	lines[#lines + 1] = "\t\t<!-- Rust -->"
	add_scope(
		"Rust attribute",
		"meta.attribute.rust, punctuation.definition.attribute.rust",
		palette.syntax.constant,
		"italic"
	)
	add_scope("Rust attribute strings", "meta.attribute.rust string", nil, "")
	add_scope(
		"Rust keyword",
		"entity.name.function.macro.rules.rust, storage.type.module.rust, storage.type.struct.rust, storage.type.enum.rust, storage.type.trait.rust, storage.type.union.rust, storage.type.impl.rust, storage.type.function.rust",
		palette.syntax.statement
	)
	add_scope("Rust numeric types", "entity.name.type.numeric.rust", palette.syntax.statement)
	add_scope("Rust generic", "meta.generic.rust", palette.syntax.constant)
	add_scope("Rust impl", "entity.name.impl.rust", palette.syntax.type, "italic")
	add_scope("Rust module", "entity.name.module.rust", palette.syntax.constant)
	add_scope("Rust trait", "entity.name.trait.rust", palette.syntax.type, "italic")
	add_scope("Rust struct", "storage.type.source.rust", palette.syntax.type)
	add_scope("Rust union", "entity.name.union.rust", palette.syntax.type)
	add_scope("Rust enum member", "meta.enum.rust storage.type.source.rust", palette.theme.secondary)
	add_scope(
		"Rust macro",
		"support.macro.rust, meta.macro.rust support.function.rust, entity.name.function.macro.rust",
		palette.syntax.func,
		"italic"
	)
	add_scope(
		"Rust lifetime",
		"storage.modifier.lifetime.rust, entity.name.type.lifetime",
		palette.syntax.func,
		"italic"
	)
	add_scope(
		"Rust string formatting",
		"string.quoted.double.rust constant.other.placeholder.rust",
		palette.syntax.special
	)
	add_scope(
		"Rust return type generic",
		"meta.function.return-type.rust meta.generic.rust storage.type.rust",
		palette.fg.core
	)
	add_scope("Rust functions", "meta.function.call.rust", palette.syntax.func)
	add_scope("Rust angle brackets", "punctuation.brackets.angle.rust", palette.syntax.bracket)
	add_scope("Rust constants", "constant.other.caps.rust", palette.syntax.constant)
	add_scope("Rust function parameters", "meta.function.definition.rust variable.other.rust", palette.syntax.parameter)
	add_scope("Rust closure variables", "meta.function.call.rust variable.other.rust", palette.fg.core)
	add_scope("Rust self", "variable.language.self.rust", palette.syntax.builtinVar)
	add_scope(
		"Rust metavariable",
		"variable.other.metavariable.name.rust, meta.macro.metavariable.rust keyword.operator.macro.dollar.rust",
		palette.syntax.special
	)

	lines[#lines + 1] = "\t\t<!-- Shell -->"
	add_scope(
		"Shell shebang",
		"comment.line.shebang, punctuation.definition.comment.shebang.shell, meta.shebang.shell",
		palette.syntax.special,
		"italic"
	)
	add_scope("Shell shebang command", "comment.line.shebang constant.language", palette.theme.secondary, "italic")
	add_scope(
		"Shell interpolated command",
		"meta.function-call.arguments.shell punctuation.definition.variable.shell, meta.function-call.arguments.shell punctuation.section.interpolation",
		palette.syntax.exception
	)
	add_scope(
		"Shell interpolated variable",
		"meta.string meta.interpolation.parameter.shell variable.other.readwrite",
		palette.syntax.constant,
		"italic"
	)
	add_scope(
		"Shell interpolation",
		"source.shell punctuation.section.interpolation, punctuation.definition.evaluation.backticks.shell",
		palette.theme.secondary
	)
	add_scope("Shell heredoc", "entity.name.tag.heredoc.shell", palette.syntax.conditional)
	add_scope("Shell quoted variable", "string.quoted.double.shell variable.other.normal.shell", palette.fg.core)

	lines[#lines + 1] = "\t\t<!-- JSON -->"
	add_scope("JSON keys", "source.json meta.mapping.key string", palette.syntax.func)
	add_scope(
		"JSON key quotes",
		"source.json meta.mapping.key punctuation.definition.string.begin, source.json meta.mapping.key punctuation.definition.string.end",
		palette.fg.muted
	)

	lines[#lines + 1] = "\t\t<!-- Man Pages -->"
	add_scope(
		"Man page headings",
		"markup.heading.synopsis.man, markup.heading.title.man, markup.heading.other.man, markup.heading.env.man",
		palette.syntax.conditional
	)
	add_scope("Man page commands", "markup.heading.commands.man", palette.syntax.func)
	add_scope("Man page env", "markup.heading.env.man", palette.syntax.special)
	add_scope("Man page options", "entity.name", palette.theme.secondary)

	lines[#lines + 1] = "\t\t<!-- Markdown -->"
	add_scope("Markdown heading 1", "markup.heading.1.markdown", palette.syntax.exception, "bold")
	add_scope("Markdown heading 2", "markup.heading.2.markdown", palette.syntax.constant, "bold")
	add_scope("Markdown heading", "markup.heading.markdown", palette.theme.primary, "bold")
	add_scope("Markdown bold", "markup.bold", palette.fg.strong, "bold")
	add_scope("Markdown italic", "markup.italic", palette.fg.core, "italic")
	add_scope("Markdown link", "markup.underline.link", palette.theme.secondary)
	add_scope("Markdown code", "markup.inline.raw, markup.fenced_code", palette.syntax.string)
	add_scope("Markdown quote", "markup.quote", palette.syntax.comment, "italic")
	add_scope("Markdown list", "markup.list", palette.fg.core)

	lines[#lines + 1] = "\t\t<!-- Typst -->"
	add_scope("Typst heading", "markup.heading.typst", palette.syntax.exception)

	lines[#lines + 1] = "\t\t<!-- Diff -->"
	add_scope("Diff inserted", "markup.inserted, meta.diff.header.to-file", palette.diff.add)
	add_scope("Diff deleted", "markup.deleted, meta.diff.header.from-file", palette.diff.delete)
	add_scope("Diff changed", "markup.changed", palette.diff.change)
	add_scope("Diff header", "meta.diff.header", palette.fg.muted, "italic")

	lines[#lines + 1] = "\t</array>"
	lines[#lines + 1] = "</dict>"
	lines[#lines + 1] = "</plist>"

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Bat Theme Generator ===\n")

	local palette_names = Utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
		local output_path, variant_name = Utils.build_variant_path("extras/bat", "tmTheme", name, mode, intensity)
		local display_name = Utils.format_display_name(variant_name)

		local theme = generate_bat_theme(display_name, palette)
		File.write(output_path, theme)

		-- Write to Yazi theme as well
    -- stylua: ignore start
		File.write(
			"extras/yazi/themes/" .. mode .. "/"
				.. (mode == "dark" and "flavors/" or (intensity .. "/flavors/"))
				.. "oasis-" .. name .. (mode == "dark" and "-dark" or ("-light-" .. intensity)) .. ".yazi/"
				.. "tmtheme.xml",
			theme
		)
		-- stylua: ignore end

		print(string.format(" Generated: %s", output_path))
	end)

	print("\n=== Summary ===")
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

main()
