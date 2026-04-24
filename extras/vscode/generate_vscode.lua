#!/usr/bin/env lua
-- extras/vscode/generate_vscode.lua
-- Generates VS Code themes from Oasis color palettes

package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")
local ColorUtils = require("oasis.tools.color_utils")

local function generate_vscode_theme(name, palette)
  local display_name = Utils.format_display_name(name)
  local is_light = palette.light_mode or false
  local appearance = is_light and "light" or "dark"

  local is_desert = name:match("desert")
  local primary = is_desert and palette.theme.secondary or palette.theme.primary
  local cursor_color = palette.theme.cursor or primary

  local active_bg = is_light
    and ColorUtils.adjust_brightness(palette.bg.mantle, 0.9)
    or ColorUtils.adjust_brightness(palette.bg.surface, 1.2)

  local matchparen_bg = palette.ui.matchParen and palette.ui.matchParen.bg or palette.bg.surface
  local dir_color = palette.ui.dir or primary

  local theme = {
    ["$schema"] = "vscode://schemas/color-theme",
    name = display_name,
    type = appearance,
    semanticHighlighting = true,

    colors = {
      -- Focus / base
      focusBorder = primary,
      ["contrastBorder"] = "#00000000",
      ["widget.shadow"] = ColorUtils.with_alpha(palette.bg.shadow, "80"),
      ["selection.background"] = ColorUtils.with_alpha(primary, "33"),

      -- Editor
      ["editor.background"] = palette.bg.core,
      ["editor.foreground"] = palette.fg.core,
      ["editorLineNumber.foreground"] = palette.fg.muted,
      ["editorLineNumber.activeForeground"] = palette.ui.lineNumber,
      ["editor.selectionBackground"] = ColorUtils.with_alpha(palette.ui.visual.bg, "b3"),
      ["editor.selectionHighlightBackground"] = ColorUtils.with_alpha(palette.ui.visual.bg, "66"),
      ["editor.wordHighlightBackground"] = ColorUtils.with_alpha(primary, "1a"),
      ["editor.wordHighlightStrongBackground"] = ColorUtils.with_alpha(palette.fg.muted, "33"),
      ["editor.findMatchBackground"] = ColorUtils.with_alpha(palette.ui.match.bg, "cc"),
      ["editor.findMatchHighlightBackground"] = ColorUtils.with_alpha(palette.ui.search.bg, "66"),
      ["editor.lineHighlightBackground"] = palette.ui.cursorLine,
      ["editor.lineHighlightBorder"] = "#00000000",
      ["editorCursor.foreground"] = cursor_color,
      ["editorWhitespace.foreground"] = ColorUtils.with_alpha(palette.ui.nontext or palette.fg.dim, "66"),
      ["editorIndentGuide.background1"] = ColorUtils.with_alpha(palette.fg.dim, "40"),
      ["editorIndentGuide.activeBackground1"] = palette.fg.muted,
      ["editorRuler.foreground"] = ColorUtils.with_alpha(palette.fg.dim, "40"),
      ["editorBracketMatch.background"] = ColorUtils.with_alpha(matchparen_bg, "66"),
      ["editorBracketMatch.border"] = matchparen_bg,
      ["editorGutter.background"] = palette.bg.core,
      ["editorGutter.addedBackground"] = palette.git.add,
      ["editorGutter.modifiedBackground"] = palette.git.change,
      ["editorGutter.deletedBackground"] = palette.git.delete,
      ["editorBracketHighlight.foreground1"] = palette.syntax.bracket,
      ["editorBracketHighlight.foreground2"] = palette.syntax.bracket,
      ["editorBracketHighlight.foreground3"] = palette.syntax.bracket,
      ["editorBracketHighlight.foreground4"] = palette.syntax.bracket,
      ["editorBracketHighlight.foreground5"] = palette.syntax.bracket,
      ["editorBracketHighlight.foreground6"] = palette.syntax.bracket,
      ["editorBracketHighlight.unexpectedBracket.foreground"] = palette.ui.diag.error.fg,
      ["editorCodeLens.foreground"] = palette.fg.muted,
      ["editorLightBulb.foreground"] = palette.terminal.yellow,

      -- Editor groups / panes
      ["editorGroupHeader.tabsBackground"] = palette.bg.mantle,
      ["editorGroupHeader.noTabsBackground"] = palette.bg.mantle,
      ["editorGroup.border"] = palette.bg.surface,

      -- Tabs
      ["tab.activeBackground"] = palette.bg.core,
      ["tab.activeForeground"] = palette.fg.core,
      ["tab.inactiveBackground"] = palette.bg.mantle,
      ["tab.inactiveForeground"] = palette.fg.muted,
      ["tab.border"] = "#00000000",
      ["tab.activeBorder"] = "#00000000",
      ["tab.activeBorderTop"] = primary,
      ["tab.unfocusedActiveForeground"] = palette.fg.muted,
      ["tab.unfocusedActiveBorderTop"] = ColorUtils.with_alpha(primary, "66"),

      -- Status bar
      ["statusBar.background"] = palette.bg.surface,
      ["statusBar.foreground"] = palette.fg.core,
      ["statusBar.border"] = "#00000000",
      ["statusBar.noFolderBackground"] = palette.bg.surface,
      ["statusBar.debuggingBackground"] = palette.ui.diag.error.bg,
      ["statusBar.debuggingForeground"] = palette.ui.diag.error.fg,

      -- Title bar
      ["titleBar.activeBackground"] = palette.bg.mantle,
      ["titleBar.activeForeground"] = palette.fg.core,
      ["titleBar.inactiveBackground"] = palette.bg.shadow,
      ["titleBar.inactiveForeground"] = palette.fg.muted,
      ["titleBar.border"] = "#00000000",

      -- Activity bar
      ["activityBar.background"] = palette.bg.mantle,
      ["activityBar.foreground"] = palette.fg.core,
      ["activityBar.inactiveForeground"] = palette.fg.muted,
      ["activityBar.border"] = "#00000000",
      ["activityBarBadge.background"] = primary,
      ["activityBarBadge.foreground"] = palette.bg.core,

      -- Side bar
      ["sideBar.background"] = palette.bg.mantle,
      ["sideBar.foreground"] = palette.fg.core,
      ["sideBar.border"] = "#00000000",
      ["sideBarTitle.foreground"] = palette.fg.muted,
      ["sideBarSectionHeader.background"] = palette.bg.surface,
      ["sideBarSectionHeader.foreground"] = palette.fg.core,
      ["sideBarSectionHeader.border"] = "#00000000",

      -- Lists
      ["list.activeSelectionBackground"] = ColorUtils.with_alpha(primary, "33"),
      ["list.activeSelectionForeground"] = palette.fg.core,
      ["list.hoverBackground"] = ColorUtils.with_alpha(palette.bg.surface, "99"),
      ["list.hoverForeground"] = palette.fg.core,
      ["list.inactiveSelectionBackground"] = ColorUtils.with_alpha(palette.bg.surface, "66"),
      ["list.inactiveSelectionForeground"] = palette.fg.core,
      ["list.focusBackground"] = ColorUtils.with_alpha(primary, "33"),
      ["list.focusForeground"] = palette.fg.core,
      ["list.highlightForeground"] = primary,
      ["list.dropBackground"] = ColorUtils.with_alpha(primary, "33"),
      ["listFilterWidget.background"] = palette.bg.mantle,
      ["listFilterWidget.outline"] = primary,
      ["listFilterWidget.noMatchesOutline"] = palette.ui.diag.error.fg,

      -- Input
      ["input.background"] = palette.bg.mantle,
      ["input.foreground"] = palette.fg.core,
      ["input.border"] = palette.bg.surface,
      ["input.placeholderForeground"] = palette.fg.muted,
      ["inputOption.activeBackground"] = ColorUtils.with_alpha(primary, "33"),
      ["inputOption.activeBorder"] = primary,
      ["inputOption.activeForeground"] = palette.fg.core,
      ["inputValidation.errorBackground"] = ColorUtils.with_alpha(palette.ui.diag.error.bg, "cc"),
      ["inputValidation.errorBorder"] = palette.ui.diag.error.fg,
      ["inputValidation.warningBackground"] = ColorUtils.with_alpha(palette.ui.diag.warn.bg, "cc"),
      ["inputValidation.warningBorder"] = palette.ui.diag.warn.fg,
      ["inputValidation.infoBackground"] = ColorUtils.with_alpha(palette.ui.diag.info.bg, "cc"),
      ["inputValidation.infoBorder"] = palette.ui.diag.info.fg,

      -- Buttons
      ["button.background"] = primary,
      ["button.foreground"] = palette.bg.core,
      ["button.hoverBackground"] = ColorUtils.adjust_brightness(primary, is_light and 0.85 or 1.15),
      ["button.secondaryBackground"] = palette.bg.surface,
      ["button.secondaryForeground"] = palette.fg.core,
      ["button.secondaryHoverBackground"] = active_bg,

      -- Dropdown
      ["dropdown.background"] = palette.bg.mantle,
      ["dropdown.border"] = palette.bg.surface,
      ["dropdown.foreground"] = palette.fg.core,

      -- Panels
      ["panel.background"] = palette.bg.mantle,
      ["panel.border"] = palette.bg.surface,
      ["panelTitle.activeBorder"] = primary,
      ["panelTitle.activeForeground"] = palette.fg.core,
      ["panelTitle.inactiveForeground"] = palette.fg.muted,
      ["panelInput.border"] = palette.bg.surface,

      -- Terminal
      ["terminal.background"] = palette.bg.core,
      ["terminal.foreground"] = palette.fg.core,
      ["terminal.selectionBackground"] = ColorUtils.with_alpha(palette.ui.visual.bg, "99"),
      ["terminal.ansiBlack"] = palette.terminal.black,
      ["terminal.ansiRed"] = palette.terminal.red,
      ["terminal.ansiGreen"] = palette.terminal.green,
      ["terminal.ansiYellow"] = palette.terminal.yellow,
      ["terminal.ansiBlue"] = palette.terminal.blue,
      ["terminal.ansiMagenta"] = palette.terminal.magenta,
      ["terminal.ansiCyan"] = palette.terminal.cyan,
      ["terminal.ansiWhite"] = palette.terminal.white,
      ["terminal.ansiBrightBlack"] = palette.terminal.bright_black,
      ["terminal.ansiBrightRed"] = palette.terminal.bright_red,
      ["terminal.ansiBrightGreen"] = palette.terminal.bright_green,
      ["terminal.ansiBrightYellow"] = palette.terminal.bright_yellow,
      ["terminal.ansiBrightBlue"] = palette.terminal.bright_blue,
      ["terminal.ansiBrightMagenta"] = palette.terminal.bright_magenta,
      ["terminal.ansiBrightCyan"] = palette.terminal.bright_cyan,
      ["terminal.ansiBrightWhite"] = palette.terminal.bright_white,

      -- Git decorations (file tree)
      ["gitDecoration.addedResourceForeground"] = palette.git.add,
      ["gitDecoration.modifiedResourceForeground"] = palette.git.change,
      ["gitDecoration.deletedResourceForeground"] = palette.git.delete,
      ["gitDecoration.untrackedResourceForeground"] = palette.terminal.bright_green,
      ["gitDecoration.ignoredResourceForeground"] = palette.fg.dim,
      ["gitDecoration.conflictingResourceForeground"] = palette.terminal.magenta,
      ["gitDecoration.renamedResourceForeground"] = palette.terminal.cyan,
      ["gitDecoration.stageModifiedResourceForeground"] = palette.git.change,
      ["gitDecoration.stageDeletedResourceForeground"] = palette.git.delete,

      -- Diff editor
      ["diffEditor.insertedTextBackground"] = ColorUtils.with_alpha(palette.diff.add, "33"),
      ["diffEditor.removedTextBackground"] = ColorUtils.with_alpha(palette.diff.delete, "33"),
      ["diffEditor.insertedLineBackground"] = ColorUtils.with_alpha(palette.diff.add, "1a"),
      ["diffEditor.removedLineBackground"] = ColorUtils.with_alpha(palette.diff.delete, "1a"),
      ["diffEditor.border"] = palette.bg.surface,

      -- Notifications
      ["notifications.background"] = palette.bg.mantle,
      ["notifications.border"] = palette.bg.surface,
      ["notifications.foreground"] = palette.fg.core,
      ["notificationsErrorIcon.foreground"] = palette.ui.diag.error.fg,
      ["notificationsWarningIcon.foreground"] = palette.ui.diag.warn.fg,
      ["notificationsInfoIcon.foreground"] = palette.ui.diag.info.fg,

      -- Badge / progress
      ["badge.background"] = primary,
      ["badge.foreground"] = palette.bg.core,
      ["progressBar.background"] = primary,

      -- Quick pick
      ["quickInput.background"] = palette.bg.mantle,
      ["quickInput.foreground"] = palette.fg.core,
      ["quickInputHighlight.foreground"] = primary,
      ["quickInputList.focusBackground"] = ColorUtils.with_alpha(primary, "33"),
      ["quickPickerGroup.background"] = palette.bg.surface,
      ["quickPickerGroup.border"] = primary,

      -- Scrollbar
      ["scrollbar.shadow"] = ColorUtils.with_alpha(palette.bg.shadow, "80"),
      ["scrollbarSlider.background"] = ColorUtils.with_alpha(palette.fg.dim, "40"),
      ["scrollbarSlider.hoverBackground"] = ColorUtils.with_alpha(palette.fg.dim, "60"),
      ["scrollbarSlider.activeBackground"] = ColorUtils.with_alpha(palette.fg.dim, "80"),

      -- Diagnostics
      ["editorError.foreground"] = palette.ui.diag.error.fg,
      ["editorWarning.foreground"] = palette.ui.diag.warn.fg,
      ["editorInfo.foreground"] = palette.ui.diag.info.fg,
      ["editorHint.foreground"] = palette.ui.diag.hint.fg,
      ["editorError.background"] = ColorUtils.with_alpha(palette.ui.diag.error.bg, "1a"),
      ["editorWarning.background"] = ColorUtils.with_alpha(palette.ui.diag.warn.bg, "1a"),
      ["editorInfo.background"] = ColorUtils.with_alpha(palette.ui.diag.info.bg, "1a"),
      ["editorError.border"] = "#00000000",
      ["editorWarning.border"] = "#00000000",
      ["editorInfo.border"] = "#00000000",
      ["problemsErrorIcon.foreground"] = palette.ui.diag.error.fg,
      ["problemsWarningIcon.foreground"] = palette.ui.diag.warn.fg,
      ["problemsInfoIcon.foreground"] = palette.ui.diag.info.fg,

      -- Peek view
      ["peekView.border"] = primary,
      ["peekViewEditor.background"] = palette.bg.mantle,
      ["peekViewEditorGutter.background"] = palette.bg.mantle,
      ["peekViewResult.background"] = palette.bg.mantle,
      ["peekViewResult.fileForeground"] = palette.fg.core,
      ["peekViewResult.lineForeground"] = palette.fg.muted,
      ["peekViewResult.matchHighlightBackground"] = ColorUtils.with_alpha(palette.ui.search.bg, "66"),
      ["peekViewResult.selectionBackground"] = ColorUtils.with_alpha(primary, "33"),
      ["peekViewResult.selectionForeground"] = palette.fg.core,
      ["peekViewTitle.background"] = palette.bg.surface,
      ["peekViewTitleDescription.foreground"] = palette.fg.muted,
      ["peekViewTitleLabel.foreground"] = palette.fg.core,
      ["peekViewEditor.matchHighlightBackground"] = ColorUtils.with_alpha(palette.ui.search.bg, "66"),

      -- Symbol icons
      ["symbolIcon.classForeground"] = palette.syntax.type,
      ["symbolIcon.constantForeground"] = palette.syntax.constant,
      ["symbolIcon.constructorForeground"] = palette.syntax.type,
      ["symbolIcon.enumeratorForeground"] = palette.syntax.type,
      ["symbolIcon.enumeratorMemberForeground"] = palette.syntax.constant,
      ["symbolIcon.eventForeground"] = palette.syntax.special,
      ["symbolIcon.fieldForeground"] = palette.syntax.identifier,
      ["symbolIcon.fileForeground"] = dir_color,
      ["symbolIcon.folderForeground"] = dir_color,
      ["symbolIcon.functionForeground"] = palette.syntax.func,
      ["symbolIcon.interfaceForeground"] = palette.syntax.type,
      ["symbolIcon.keyForeground"] = palette.syntax.identifier,
      ["symbolIcon.keywordForeground"] = palette.syntax.statement,
      ["symbolIcon.methodForeground"] = palette.syntax.func,
      ["symbolIcon.moduleForeground"] = palette.syntax.preproc,
      ["symbolIcon.namespaceForeground"] = palette.syntax.preproc,
      ["symbolIcon.nullForeground"] = palette.syntax.builtinConst,
      ["symbolIcon.numberForeground"] = palette.syntax.constant,
      ["symbolIcon.operatorForeground"] = palette.syntax.operator,
      ["symbolIcon.packageForeground"] = palette.syntax.preproc,
      ["symbolIcon.propertyForeground"] = palette.syntax.identifier,
      ["symbolIcon.stringForeground"] = palette.syntax.string,
      ["symbolIcon.structForeground"] = palette.syntax.type,
      ["symbolIcon.typeParameterForeground"] = palette.syntax.type,
      ["symbolIcon.variableForeground"] = palette.fg.core,

      -- Breadcrumbs
      ["breadcrumb.foreground"] = palette.fg.muted,
      ["breadcrumb.background"] = palette.bg.core,
      ["breadcrumb.focusForeground"] = palette.fg.core,
      ["breadcrumb.activeSelectionForeground"] = primary,
      ["breadcrumbPicker.background"] = palette.bg.mantle,

      -- Menu
      ["menu.background"] = palette.bg.mantle,
      ["menu.foreground"] = palette.fg.core,
      ["menu.selectionBackground"] = ColorUtils.with_alpha(primary, "33"),
      ["menu.selectionForeground"] = palette.fg.core,
      ["menu.selectionBorder"] = "#00000000",
      ["menu.separatorBackground"] = palette.bg.surface,
      ["menu.border"] = palette.bg.surface,
      ["menubar.selectionBackground"] = ColorUtils.with_alpha(primary, "33"),
      ["menubar.selectionForeground"] = palette.fg.core,
      ["menubar.selectionBorder"] = "#00000000",
    },

    tokenColors = {
      -- Comments
      {
        scope = { "comment", "comment.line", "comment.block", "comment.line.double-slash", "comment.block.documentation" },
        settings = { foreground = palette.syntax.comment, fontStyle = "italic" },
      },

      -- Strings
      {
        scope = { "string", "string.quoted", "string.quoted.single", "string.quoted.double", "string.quoted.triple", "string.template" },
        settings = { foreground = palette.syntax.string },
      },

      -- Regex
      {
        scope = { "string.regexp" },
        settings = { foreground = palette.syntax.regex },
      },

      -- Escape sequences
      {
        scope = { "constant.character.escape", "string.escape" },
        settings = { foreground = palette.syntax.regex, fontStyle = "bold" },
      },

      -- Numbers
      {
        scope = { "constant.numeric" },
        settings = { foreground = palette.syntax.constant },
      },

      -- Language constants (true, false, null, undefined)
      {
        scope = { "constant.language", "constant.language.null", "constant.language.undefined", "constant.language.boolean" },
        settings = { foreground = palette.syntax.builtinConst, fontStyle = "bold" },
      },

      -- Named constants (SCREAMING_SNAKE, etc.)
      {
        scope = { "variable.other.constant", "entity.name.constant" },
        settings = { foreground = palette.syntax.constant },
      },

      -- Keywords (var, let, const, if, for, class, etc.)
      {
        scope = { "keyword", "keyword.control", "keyword.other", "storage.type", "storage.modifier" },
        settings = { foreground = palette.syntax.statement },
      },

      -- Control flow (try, catch, return, throw)
      {
        scope = { "keyword.control.exception", "keyword.control.flow", "keyword.control.return" },
        settings = { foreground = palette.syntax.exception },
      },

      -- Imports / exports
      {
        scope = { "keyword.control.import", "keyword.control.export", "keyword.other.import", "keyword.other.using", "meta.import keyword.other" },
        settings = { foreground = palette.syntax.preproc },
      },

      -- Operators
      {
        scope = { "keyword.operator", "keyword.operator.assignment", "keyword.operator.comparison", "keyword.operator.logical" },
        settings = { foreground = palette.syntax.operator },
      },

      -- Punctuation / delimiters
      {
        scope = { "punctuation.separator", "punctuation.terminator", "meta.delimiter" },
        settings = { foreground = palette.syntax.punctuation },
      },

      -- Brackets
      {
        scope = { "punctuation.definition.bracket", "meta.brace", "punctuation.section" },
        settings = { foreground = palette.syntax.bracket },
      },

      -- Function definitions
      {
        scope = { "entity.name.function", "meta.function entity.name.function" },
        settings = { foreground = palette.syntax.func },
      },

      -- Function calls
      {
        scope = { "meta.function-call entity.name.function", "meta.function-call.generic" },
        settings = { foreground = palette.syntax.func },
      },

      -- Built-in functions
      {
        scope = { "support.function", "support.function.builtin", "support.function.console" },
        settings = { foreground = palette.syntax.builtinFunc },
      },

      -- Types / classes / enums
      {
        scope = { "entity.name.type", "entity.name.class", "entity.name.enum", "support.type", "support.class" },
        settings = { foreground = palette.syntax.type },
      },

      -- Inherited types
      {
        scope = { "entity.other.inherited-class", "meta.type.annotation" },
        settings = { foreground = palette.syntax.typedef or palette.syntax.type },
      },

      -- Function parameters
      {
        scope = { "variable.parameter", "meta.function.parameter variable.other" },
        settings = { foreground = palette.syntax.parameter },
      },

      -- Language variables (this, self, super)
      {
        scope = { "variable.language", "variable.language.this", "variable.language.self", "variable.language.super" },
        settings = { foreground = palette.syntax.builtinVar },
      },

      -- Built-in constants (undefined, null, Infinity, NaN)
      {
        scope = { "support.constant", "support.constant.builtin" },
        settings = { foreground = palette.syntax.builtinConst },
      },

      -- Properties / member identifiers
      {
        scope = { "variable.other.property", "support.variable.property", "entity.name.variable" },
        settings = { foreground = palette.syntax.identifier },
      },

      -- Preprocessor / macros
      {
        scope = { "keyword.control.preprocessor", "meta.preprocessor", "entity.name.function.preprocessor" },
        settings = { foreground = palette.syntax.preproc },
      },

      -- HTML/JSX/XML tags
      {
        scope = { "entity.name.tag", "meta.tag entity.name.tag" },
        settings = { foreground = palette.syntax.type },
      },

      -- HTML/JSX attributes
      {
        scope = { "entity.other.attribute-name", "meta.tag entity.other.attribute-name" },
        settings = { foreground = palette.syntax.identifier },
      },

      -- Decorators / annotations
      {
        scope = { "meta.decorator", "punctuation.decorator", "storage.type.annotation" },
        settings = { foreground = palette.syntax.special },
      },

      -- Markdown headings
      {
        scope = { "markup.heading", "entity.name.section.markdown", "heading.1", "heading.2", "heading.3" },
        settings = { foreground = palette.syntax.func, fontStyle = "bold" },
      },

      -- Markdown italic
      {
        scope = { "markup.italic" },
        settings = { foreground = palette.syntax.special, fontStyle = "italic" },
      },

      -- Markdown bold
      {
        scope = { "markup.bold" },
        settings = { foreground = palette.syntax.conditional or palette.syntax.statement, fontStyle = "bold" },
      },

      -- Markdown links
      {
        scope = { "markup.underline.link", "string.other.link" },
        settings = { foreground = palette.syntax.type, fontStyle = "underline" },
      },

      -- Markdown code blocks
      {
        scope = { "markup.inline.raw", "markup.fenced_code.block", "markup.raw.block" },
        settings = { foreground = palette.syntax.string },
      },

      -- Markdown list markers
      {
        scope = { "punctuation.definition.list.begin.markdown", "beginning.punctuation.definition.list" },
        settings = { foreground = palette.syntax.operator },
      },

      -- CSS property names
      {
        scope = { "support.type.property-name.css", "entity.other.attribute-name.class.css" },
        settings = { foreground = palette.syntax.identifier },
      },

      -- CSS values
      {
        scope = { "support.constant.property-value.css", "constant.other.color.rgb-value.css" },
        settings = { foreground = palette.syntax.constant },
      },

      -- JSON object keys
      {
        scope = { "support.type.property-name.json" },
        settings = { foreground = palette.syntax.identifier },
      },
    },

    semanticTokenColors = {
      variable = palette.fg.core,
      ["variable.readonly"] = palette.syntax.type,
      ["variable.readonly.defaultLibrary"] = palette.syntax.builtinConst,
      parameter = palette.syntax.parameter,
      ["function"] = palette.syntax.func,
      method = palette.syntax.func,
      ["function.declaration"] = palette.syntax.func,
      ["method.declaration"] = palette.syntax.func,
      class = palette.syntax.type,
      ["class.declaration"] = palette.syntax.type,
      type = palette.syntax.type,
      interface = palette.syntax.type,
      ["interface.declaration"] = palette.syntax.type,
      enum = palette.syntax.type,
      enumMember = palette.syntax.constant,
      namespace = palette.syntax.preproc,
      property = palette.syntax.identifier,
      keyword = palette.syntax.statement,
      string = palette.syntax.string,
      number = palette.syntax.constant,
      regexp = palette.syntax.regex,
      comment = { foreground = palette.syntax.comment, italic = true },
      operator = palette.syntax.operator,
      decorator = palette.syntax.special,
      typeParameter = palette.syntax.type,
      macro = palette.syntax.macro or palette.syntax.preproc,
    },
  }

  return theme
end

local function generate_package_json(theme_entries)
  return {
    name = "oasis-nvim",
    displayName = "Oasis",
    description = "Desert-themed colorscheme for VS Code",
    version = "4.0.0",
    publisher = "uhs-robert",
    engines = { vscode = "^1.60.0" },
    categories = { "Themes" },
    keywords = { "theme", "dark", "light", "desert", "color" },
    repository = {
      type = "git",
      url = "https://github.com/uhs-robert/oasis.nvim",
    },
    contributes = { themes = theme_entries },
  }
end

local function main()
  print("\n=== Oasis VS Code Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local theme_entries = {}

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, variant_name = Utils.build_variant_path("extras/vscode", "json", name, mode, intensity)
    local display_name = Utils.format_display_name(variant_name)

    local theme = generate_vscode_theme(variant_name, palette)
    local json = ColorUtils.encode_json(theme, 0)
    File.write(output_path, json)
    print(string.format("✓ Generated: %s", output_path))

    local ui_theme = (palette.light_mode or false) and "vs" or "vs-dark"
    table.insert(theme_entries, {
      label = display_name,
      uiTheme = ui_theme,
      path = output_path:gsub("^extras/vscode/", "./"),
    })
  end)

  -- Generate extension package.json
  local pkg = generate_package_json(theme_entries)
  local pkg_json = ColorUtils.encode_json(pkg, 0)
  File.write("extras/vscode/package.json", pkg_json)
  print("✓ Generated: extras/vscode/package.json")

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

main()
