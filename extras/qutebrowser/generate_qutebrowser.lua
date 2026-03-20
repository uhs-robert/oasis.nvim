#!/usr/bin/env lua
-- extras/qutebrowser/generate_qutebrowser.lua
-- Generates qutebrowser Python theme files from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_qutebrowser_theme(variant_name, palette)
  local t = palette.terminal
  local bg = palette.bg
  local fg = palette.fg
  local theme = palette.theme
  local ui = palette.ui

  local display_name = Utils.format_display_name(variant_name)

  -- Map palette fields to qutebrowser named colors
  local colors = {
    { key = "magenta", value = t.color5 },
    { key = "red", value = t.red },
    { key = "bright_red", value = t.bright_red },
    { key = "yellow", value = t.yellow },
    { key = "bright_yellow", value = t.bright_yellow },
    { key = "green", value = t.green },
    { key = "bright_green", value = t.bright_green },
    { key = "teal", value = t.cyan },
    { key = "blue", value = t.blue },
    { key = "bright_blue", value = t.bright_blue },
    { key = "search", value = ui.matchParen.bg },
    { key = "core", value = bg.core },
    { key = "mantle", value = bg.mantle },
    { key = "shadow", value = bg.shadow },
    { key = "surface", value = bg.surface },
    { key = "fg_core", value = fg.core },
    { key = "fg_dim", value = fg.dim },
    { key = "fg_muted", value = fg.muted },
    { key = "light_primary", value = theme.light_primary },
    { key = "primary", value = theme.primary },
    { key = "strong_primary", value = theme.strong_primary },
    { key = "secondary", value = theme.secondary },
    { key = "accent", value = theme.accent },
    { key = "match", value = ui.match.bg },
  }

  local lines = {
    "# qutebrowser/.config/qutebrowser/oasis_" .. variant_name .. ".py",
    "# " .. display_name,
    "# Author: uhs-robert",
    "# vim:fileencoding=utf-8:foldmethod=marker",
    "",
    "",
    "def setup(c, samecolorrows=True):",
    "    palette = {}",
    "",
    "    # flavours {{{",
    "    palette = {",
  }

  -- Calculate padding for alignment
  local max_key_len = 0
  for _, entry in ipairs(colors) do
    if #entry.key > max_key_len then max_key_len = #entry.key end
  end

  for _, entry in ipairs(colors) do
    local padding = string.rep(" ", max_key_len - #entry.key)
    lines[#lines + 1] = string.format('        "%s":%s "%s",', entry.key, padding, entry.value)
  end

  lines[#lines + 1] = "    }"
  lines[#lines + 1] = "    # }}}"
  lines[#lines + 1] = ""
  lines[#lines + 1] = '    c.colors.webpage.bg = palette["core"]'
  lines[#lines + 1] = ""

  -- completion {{{
  local completion = {
    "    # completion {{{",
    '    c.colors.completion.category.bg = palette["mantle"]',
    '    c.colors.completion.category.border.bottom = palette["core"]',
    '    c.colors.completion.category.border.top = palette["strong_primary"]',
    '    c.colors.completion.category.fg = palette["primary"]',
    "    if samecolorrows:",
    '        c.colors.completion.even.bg = palette["core"]',
    '        c.colors.completion.odd.bg = palette["core"]',
    "    else:",
    '        c.colors.completion.even.bg = palette["core"]',
    '        c.colors.completion.odd.bg = palette["shadow"]',
    '    c.colors.completion.fg = palette["fg_core"]',
    "",
    "    ## Selected completion items",
    '    c.colors.completion.item.selected.bg = palette["surface"]',
    '    c.colors.completion.item.selected.border.bottom = palette["surface"]',
    '    c.colors.completion.item.selected.border.top = palette["surface"]',
    '    c.colors.completion.item.selected.fg = palette["fg_core"]',
    '    c.colors.completion.item.selected.match.fg = palette["secondary"]',
    '    c.colors.completion.match.fg = palette["match"]',
    "",
    "    ## Color of the scrollbar in completion view",
    '    c.colors.completion.scrollbar.bg = palette["mantle"]',
    '    c.colors.completion.scrollbar.fg = palette["strong_primary"]',
    "    # }}}",
    "",
  }
  for _, line in ipairs(completion) do
    lines[#lines + 1] = line
  end

  -- downloads {{{
  local downloads = {
    "    # downloads {{{",
    '    c.colors.downloads.bar.bg = palette["surface"]',
    '    c.colors.downloads.error.bg = palette["surface"]',
    '    c.colors.downloads.start.bg = palette["surface"]',
    '    c.colors.downloads.stop.bg = palette["surface"]',
    "",
    '    c.colors.downloads.error.fg = palette["red"]',
    '    c.colors.downloads.start.fg = palette["yellow"]',
    '    c.colors.downloads.stop.fg = palette["green"]',
    '    c.colors.downloads.system.fg = "none"',
    '    c.colors.downloads.system.bg = "none"',
    "    # }}}",
    "",
  }
  for _, line in ipairs(downloads) do
    lines[#lines + 1] = line
  end

  -- hints {{{
  local hints = {
    "    # hints {{{",
    '    c.colors.hints.bg = palette["primary"]',
    '    c.colors.hints.fg = palette["core"]',
    '    c.hints.border = "1px solid " + palette["core"]',
    '    c.colors.hints.match.fg = palette["fg_muted"]',
    "    # }}}",
    "",
  }
  for _, line in ipairs(hints) do
    lines[#lines + 1] = line
  end

  -- keyhints {{{
  local keyhints = {
    "    # keyhints {{{",
    '    c.colors.keyhint.bg = palette["mantle"]',
    '    c.colors.keyhint.fg = palette["fg_core"]',
    '    c.colors.keyhint.suffix.fg = palette["match"]',
    "    # }}}",
    "",
  }
  for _, line in ipairs(keyhints) do
    lines[#lines + 1] = line
  end

  -- messages {{{
  local messages = {
    "    # messages {{{",
    '    c.colors.messages.error.bg = palette["mantle"]',
    '    c.colors.messages.error.fg = palette["red"]',
    '    c.colors.messages.error.border = palette["mantle"]',
    "",
    '    c.colors.messages.warning.bg = palette["mantle"]',
    '    c.colors.messages.warning.fg = palette["yellow"]',
    '    c.colors.messages.warning.border = palette["mantle"]',
    "",
    '    c.colors.messages.info.bg = palette["mantle"]',
    '    c.colors.messages.info.fg = palette["teal"]',
    '    c.colors.messages.info.border = palette["mantle"]',
    "    # }}}",
    "",
  }
  for _, line in ipairs(messages) do
    lines[#lines + 1] = line
  end

  -- prompts {{{
  local prompts = {
    "    # prompts {{{",
    '    c.colors.prompts.bg = palette["mantle"]',
    '    c.colors.prompts.border = "1px solid " + palette["mantle"]',
    '    c.colors.prompts.fg = palette["fg_core"]',
    '    c.colors.prompts.selected.bg = palette["search"]',
    '    c.colors.prompts.selected.fg = palette["accent"]',
    "    # }}}",
    "",
  }
  for _, line in ipairs(prompts) do
    lines[#lines + 1] = line
  end

  -- statusbar {{{
  local statusbar = {
    "    # statusbar {{{",
    "    ## Background color of the statusbar.",
    '    c.colors.statusbar.normal.bg = palette["mantle"]',
    '    c.colors.statusbar.insert.bg = palette["mantle"]',
    '    c.colors.statusbar.command.bg = palette["mantle"]',
    '    c.colors.statusbar.caret.bg = palette["mantle"]',
    '    c.colors.statusbar.caret.selection.bg = palette["mantle"]',
    "",
    "    ## Background color of the progress bar.",
    '    c.colors.statusbar.progress.bg = palette["surface"]',
    '    c.colors.statusbar.passthrough.bg = palette["surface"]',
    "",
    "    ## Foreground color of the statusbar.",
    '    c.colors.statusbar.normal.fg = palette["fg_core"]',
    '    c.colors.statusbar.insert.fg = palette["green"]',
    '    c.colors.statusbar.command.fg = palette["light_primary"]',
    '    c.colors.statusbar.passthrough.fg = palette["bright_yellow"]',
    '    c.colors.statusbar.caret.fg = palette["bright_yellow"]',
    '    c.colors.statusbar.caret.selection.fg = palette["bright_yellow"]',
    "",
    "    ## Foreground color of the URL in the statusbar on error.",
    '    c.colors.statusbar.url.error.fg = palette["red"]',
    "",
    "    ## Default foreground color of the URL in the statusbar.",
    '    c.colors.statusbar.url.fg = palette["fg_core"]',
    "",
    "    ## Foreground color of the URL in the statusbar for hovered links.",
    '    c.colors.statusbar.url.hover.fg = palette["bright_blue"]',
    "",
    "    ## Foreground color of the URL in the statusbar on successful load",
    '    c.colors.statusbar.url.success.http.fg = palette["teal"]',
    '    c.colors.statusbar.url.success.https.fg = palette["green"]',
    "",
    "    ## Foreground color of the URL in the statusbar when there's a warning.",
    '    c.colors.statusbar.url.warn.fg = palette["yellow"]',
    "",
    "    ## PRIVATE MODE COLORS",
    "    ## Background color of the statusbar in private browsing mode.",
    '    c.colors.statusbar.private.bg = palette["surface"]',
    '    c.colors.statusbar.private.fg = palette["fg_dim"]',
    '    c.colors.statusbar.command.private.bg = palette["surface"]',
    '    c.colors.statusbar.command.private.fg = palette["accent"]',
    "",
    "    # }}}",
    "",
  }
  for _, line in ipairs(statusbar) do
    lines[#lines + 1] = line
  end

  -- tabs {{{
  local tabs = {
    "    # tabs {{{",
    '    c.colors.tabs.bar.bg = palette["core"]',
    '    c.colors.tabs.even.bg = palette["mantle"]',
    '    c.colors.tabs.even.fg = palette["primary"]',
    '    c.colors.tabs.odd.bg = palette["mantle"]',
    '    c.colors.tabs.odd.fg = palette["primary"]',
    "",
    "    ## Color for the tab indicator on errors.",
    '    c.colors.tabs.indicator.error = palette["red"]',
    "",
    "    ## Color gradient interpolation system for the tab indicator.",
    "    ## Valid values:",
    "    ## - rgb: Interpolate in the RGB color system.",
    "    ## - hsv: Interpolate in the HSV color system.",
    "    ## - hsl: Interpolate in the HSL color system.",
    "    ## - none: Don't show a gradient.",
    '    c.colors.tabs.indicator.system = "none"',
    "",
    "    # ## Background color of selected tabs.",
    '    c.colors.tabs.selected.even.bg = palette["primary"]',
    '    c.colors.tabs.selected.even.fg = palette["core"]',
    '    c.colors.tabs.selected.odd.bg = palette["strong_primary"]',
    '    c.colors.tabs.selected.odd.fg = palette["core"]',
    "    # }}}",
    "",
  }
  for _, line in ipairs(tabs) do
    lines[#lines + 1] = line
  end

  -- pinned tabs {{{
  local pinned_tabs = {
    "    # pinned tabs {{{",
    '    c.colors.tabs.pinned.even.bg = palette["mantle"]',
    '    c.colors.tabs.pinned.even.fg = palette["secondary"]',
    '    c.colors.tabs.pinned.odd.bg = palette["mantle"]',
    '    c.colors.tabs.pinned.odd.fg = palette["secondary"]',
    '    c.colors.tabs.pinned.selected.even.bg = palette["primary"]',
    '    c.colors.tabs.pinned.selected.even.fg = palette["core"]',
    '    c.colors.tabs.pinned.selected.odd.bg = palette["strong_primary"]',
    '    c.colors.tabs.pinned.selected.odd.fg = palette["core"]',
    "    # }}}",
    "",
  }
  for _, line in ipairs(pinned_tabs) do
    lines[#lines + 1] = line
  end

  -- context menus {{{
  local context_menus = {
    "    # context menus {{{",
    '    c.colors.contextmenu.menu.bg = palette["surface"]',
    '    c.colors.contextmenu.menu.fg = palette["fg_core"]',
    "",
    '    c.colors.contextmenu.disabled.bg = palette["mantle"]',
    '    c.colors.contextmenu.disabled.fg = palette["fg_core"]',
    "",
    '    c.colors.contextmenu.selected.bg = palette["fg_core"]',
    '    c.colors.contextmenu.selected.fg = palette["core"]',
    "    # }}}",
    "",
  }
  for _, line in ipairs(context_menus) do
    lines[#lines + 1] = line
  end

  -- tooltips {{{
  local tooltips = {
    "    # tooltips {{{",
    '    c.colors.tooltip.bg = palette["surface"]',
    '    c.colors.tooltip.fg = palette["fg_core"]',
    "    # }}}",
  }
  for _, line in ipairs(tooltips) do
    lines[#lines + 1] = line
  end

  return table.concat(lines, "\n") .. "\n"
end

local function main()
  print("\n=== Oasis Qutebrowser Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, variant_name = Utils.build_variant_path("extras/qutebrowser", "py", name, mode, intensity)

    local theme = generate_qutebrowser_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
