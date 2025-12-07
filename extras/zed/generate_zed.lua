#!/usr/bin/env lua
-- extras/zed/generate_zed.lua
-- Generates Zed Editor themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")
local color_utils = require("oasis.tools.color_utils")

local function generate_zed_theme(name, palette)
  local display_name = utils.format_display_name(name)
  local is_light = palette.light_mode or false

  -- Calculate adjusted colors for UI states
  local hover_bg = is_light and color_utils.adjust_brightness(palette.bg.mantle, 0.95)
      or color_utils.adjust_brightness(palette.bg.surface, 1.1)
  local active_bg = is_light and color_utils.adjust_brightness(palette.bg.mantle, 0.9)
      or color_utils.adjust_brightness(palette.bg.surface, 1.2)

  -- Generate player colors from theme accents
  local player_colors = {
    {
      cursor = palette.theme.primary,
      background = palette.theme.primary,
      selection = color_utils.with_alpha(palette.theme.primary, "3d"),
    },
    {
      cursor = palette.theme.secondary,
      background = palette.theme.secondary,
      selection = color_utils.with_alpha(palette.theme.secondary, "3d"),
    },
    {
      cursor = palette.theme.accent,
      background = palette.theme.accent,
      selection = color_utils.with_alpha(palette.theme.accent, "3d"),
    },
    {
      cursor = palette.syntax.func,
      background = palette.syntax.func,
      selection = color_utils.with_alpha(palette.syntax.func, "3d"),
    },
    {
      cursor = palette.syntax.string,
      background = palette.syntax.string,
      selection = color_utils.with_alpha(palette.syntax.string, "3d"),
    },
    {
      cursor = palette.syntax.type,
      background = palette.syntax.type,
      selection = color_utils.with_alpha(palette.syntax.type, "3d"),
    },
    {
      cursor = palette.syntax.constant,
      background = palette.syntax.constant,
      selection = color_utils.with_alpha(palette.syntax.constant, "3d"),
    },
    {
      cursor = palette.syntax.conditional,
      background = palette.syntax.conditional,
      selection = color_utils.with_alpha(palette.syntax.conditional, "3d"),
    },
  }

  local theme = {
    ["$schema"] = "https://zed.dev/schema/themes/v0.2.0.json",
    name = display_name,
    author = "sjoeboo",
    coauthor = "uhs-robert",
    themes = {
      {
        name = display_name,
        appearance = is_light and "light" or "dark",
        style = {
          -- Border colors
          border = palette.bg.surface,                -- Subtle borders between panels using brightest bg
          ["border.variant"] = palette.bg.mantle,     -- Even more subtle dividers
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
          ["drop_target.background"] = color_utils.with_alpha(palette.theme.primary, "40"),

          -- Ghost elements
          ["ghost_element.background"] = "#00000000",
          ["ghost_element.hover"] = palette.bg.mantle,
          ["ghost_element.active"] = palette.bg.surface,
          ["ghost_element.selected"] = palette.bg.surface,
          ["ghost_element.disabled"] = palette.bg.shadow,

          -- Text colors
          text = palette.fg.core,
          ["text.muted"] = palette.fg.core, -- Improved readability in sidebars
          ["text.placeholder"] = palette.fg.muted,
          ["text.disabled"] = palette.fg.dim,
          ["text.accent"] = palette.theme.primary,

          -- Icon colors
          icon = palette.fg.core,
          ["icon.muted"] = palette.fg.core, -- Improved visibility in file browser/git panels
          ["icon.disabled"] = palette.fg.dim,
          ["icon.placeholder"] = palette.fg.muted,
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
          ["search.match_background"] = color_utils.with_alpha(palette.ui.search.bg, "66"),

          -- Panel
          ["panel.background"] = palette.bg.mantle,
          ["panel.focused_border"] = nil,

          -- Pane
          ["pane.focused_border"] = nil,

          -- Scrollbar
          ["scrollbar.thumb.background"] = color_utils.with_alpha(palette.fg.dim, "4c"),
          ["scrollbar.thumb.hover_background"] = palette.bg.surface,
          ["scrollbar.thumb.border"] = palette.bg.surface,
          ["scrollbar.track.background"] = "#00000000",
          ["scrollbar.track.border"] = palette.bg.shadow,

          -- Editor
          ["editor.foreground"] = palette.fg.core,
          ["editor.background"] = palette.bg.core,
          ["editor.gutter.background"] = palette.bg.core,
          ["editor.subheader.background"] = palette.bg.mantle,
          ["editor.active_line.background"] = color_utils.with_alpha(palette.ui.cursorLine, "bf"),
          ["editor.highlighted_line.background"] = palette.ui.cursorLine,
          ["editor.line_number"] = palette.fg.muted,
          ["editor.active_line_number"] = palette.ui.lineNumber,
          ["editor.invisible"] = palette.ui.nontext or palette.fg.dim,
          ["editor.wrap_guide"] = color_utils.with_alpha(palette.fg.dim, "0d"),
          ["editor.active_wrap_guide"] = color_utils.with_alpha(palette.fg.dim, "1a"),
          ["editor.document_highlight.read_background"] = color_utils.with_alpha(palette.theme.primary, "1a"),
          ["editor.document_highlight.write_background"] = color_utils.with_alpha(palette.fg.muted, "33"),

          -- Terminal
          ["terminal.background"] = palette.bg.core,
          ["terminal.foreground"] = palette.fg.core,
          ["terminal.bright_foreground"] = palette.fg.strong,
          ["terminal.dim_foreground"] = palette.fg.dim,
          ["terminal.ansi.black"] = palette.terminal.black,
          ["terminal.ansi.bright_black"] = palette.terminal.bright_black,
          ["terminal.ansi.dim_black"] = palette.fg.dim,
          ["terminal.ansi.red"] = palette.terminal.red,
          ["terminal.ansi.bright_red"] = palette.terminal.bright_red,
          ["terminal.ansi.dim_red"] = color_utils.adjust_brightness(palette.terminal.red, 0.7),
          ["terminal.ansi.green"] = palette.terminal.green,
          ["terminal.ansi.bright_green"] = palette.terminal.bright_green,
          ["terminal.ansi.dim_green"] = color_utils.adjust_brightness(palette.terminal.green, 0.7),
          ["terminal.ansi.yellow"] = palette.terminal.yellow,
          ["terminal.ansi.bright_yellow"] = palette.terminal.bright_yellow,
          ["terminal.ansi.dim_yellow"] = color_utils.adjust_brightness(palette.terminal.yellow, 0.7),
          ["terminal.ansi.blue"] = palette.terminal.blue,
          ["terminal.ansi.bright_blue"] = palette.terminal.bright_blue,
          ["terminal.ansi.dim_blue"] = color_utils.adjust_brightness(palette.terminal.blue, 0.7),
          ["terminal.ansi.magenta"] = palette.terminal.magenta,
          ["terminal.ansi.bright_magenta"] = palette.terminal.bright_magenta,
          ["terminal.ansi.dim_magenta"] = color_utils.adjust_brightness(palette.terminal.magenta, 0.7),
          ["terminal.ansi.cyan"] = palette.terminal.cyan,
          ["terminal.ansi.bright_cyan"] = palette.terminal.bright_cyan,
          ["terminal.ansi.dim_cyan"] = color_utils.adjust_brightness(palette.terminal.cyan, 0.7),
          ["terminal.ansi.white"] = palette.terminal.white,
          ["terminal.ansi.bright_white"] = palette.terminal.bright_white,
          ["terminal.ansi.dim_white"] = color_utils.adjust_brightness(palette.terminal.white, 0.7),

          -- Link
          ["link_text.hover"] = palette.theme.primary,

          -- Version control
          ["version_control.added"] = palette.diff.add,
          ["version_control.modified"] = palette.diff.change,
          ["version_control.deleted"] = palette.diff.delete,

          -- Conflict
          conflict = palette.ui.diag.error.fg,
          ["conflict.background"] = color_utils.with_alpha(palette.ui.diag.error.bg, "1a"),
          ["conflict.border"] = palette.ui.diag.error.fg,

          -- Created
          created = palette.diff.add,
          ["created.background"] = color_utils.with_alpha(palette.diff.add, "1a"),
          ["created.border"] = palette.diff.add,

          -- Deleted
          deleted = palette.diff.delete,
          ["deleted.background"] = color_utils.with_alpha(palette.diff.delete, "1a"),
          ["deleted.border"] = palette.diff.delete,

          -- Error
          error = palette.ui.diag.error.fg,
          ["error.background"] = color_utils.with_alpha(palette.ui.diag.error.bg, "1a"),
          ["error.border"] = palette.ui.diag.error.fg,

          -- Hidden
          hidden = palette.fg.dim,
          ["hidden.background"] = color_utils.with_alpha(palette.fg.dim, "1a"),
          ["hidden.border"] = palette.fg.dim,

          -- Hint
          hint = palette.ui.diag.hint.fg,
          ["hint.background"] = color_utils.with_alpha(palette.ui.diag.hint.bg, "1a"),
          ["hint.border"] = palette.ui.diag.hint.fg,

          -- Ignored
          ignored = palette.fg.dim,
          ["ignored.background"] = color_utils.with_alpha(palette.fg.dim, "1a"),
          ["ignored.border"] = palette.fg.muted,

          -- Info
          info = palette.ui.diag.info.fg,
          ["info.background"] = color_utils.with_alpha(palette.ui.diag.info.bg, "1a"),
          ["info.border"] = palette.ui.diag.info.fg,

          -- Modified
          modified = palette.diff.change,
          ["modified.background"] = color_utils.with_alpha(palette.diff.change, "1a"),
          ["modified.border"] = palette.diff.change,

          -- Predictive
          predictive = palette.fg.dim,
          ["predictive.background"] = color_utils.with_alpha(palette.bg.shadow, "1a"),
          ["predictive.border"] = palette.fg.dim,

          -- Renamed
          renamed = palette.ui.diag.info.fg,
          ["renamed.background"] = color_utils.with_alpha(palette.ui.diag.info.bg, "1a"),
          ["renamed.border"] = palette.ui.diag.info.fg,

          -- Success
          success = palette.ui.diag.ok.fg,
          ["success.background"] = color_utils.with_alpha(palette.ui.diag.ok.bg, "1a"),
          ["success.border"] = palette.ui.diag.ok.fg,

          -- Unreachable
          unreachable = palette.fg.muted,
          ["unreachable.background"] = color_utils.with_alpha(palette.fg.muted, "1a"),
          ["unreachable.border"] = palette.fg.muted,

          -- Warning
          warning = palette.ui.diag.warn.fg,
          ["warning.background"] = color_utils.with_alpha(palette.ui.diag.warn.bg, "1a"),
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
              color = palette.syntax.conditional,
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
              color = palette.syntax.conditional,
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
              color = palette.syntax.statement,
              font_style = nil,
              font_weight = nil,
            },

            -- Labels
            label = {
              color = palette.syntax.statement,
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

local function main()
  print("\n=== Oasis Zed Theme Generator ===\n")

  local palette_names = utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = utils.for_each_palette_variant(function(name, palette, mode, intensity)
    -- Build output path using shared utility
    local output_path, variant_name = utils.build_variant_path("extras/zed", "json", name, mode, intensity)

    -- Generate and write theme
    local theme = generate_zed_theme(variant_name, palette)
    local json = color_utils.encode_json(theme, 0)
    utils.write_file(output_path, json)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
