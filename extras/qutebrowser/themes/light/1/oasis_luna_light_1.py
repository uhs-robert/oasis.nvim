# qutebrowser/.config/qutebrowser/oasis_luna_light_1.py
# Oasis Luna Light 1
# Author: uhs-robert
# vim:fileencoding=utf-8:foldmethod=marker


def setup(c, samecolorrows=True):
    palette = {}

    # flavours {{{
    palette = {
        "magenta":        "#7723d9",
        "red":            "#b31212",
        "bright_red":     "#b41212",
        "yellow":         "#615b20",
        "bright_yellow":  "#844c14",
        "green":          "#386335",
        "bright_green":   "#35642f",
        "teal":           "#32625c",
        "blue":           "#145aa2",
        "bright_blue":    "#23607a",
        "search":         "#cecede",
        "core":           "#eaeaf1",
        "mantle":         "#e0e0eb",
        "shadow":         "#d7d7e4",
        "surface":        "#cecede",
        "fg_core":        "#514486",
        "fg_dim":         "#888596",
        "fg_muted":       "#6b687b",
        "light_primary":  "#7a7014",
        "primary":        "#908419",
        "strong_primary": "#837e3f",
        "secondary":      "#5307ab",
        "accent":         "#1b7b98",
        "match":          "#d1be7a",
    }
    # }}}

    c.colors.webpage.bg = palette["core"]

    # completion {{{
    c.colors.completion.category.bg = palette["mantle"]
    c.colors.completion.category.border.bottom = palette["core"]
    c.colors.completion.category.border.top = palette["strong_primary"]
    c.colors.completion.category.fg = palette["primary"]
    if samecolorrows:
        c.colors.completion.even.bg = palette["core"]
        c.colors.completion.odd.bg = palette["core"]
    else:
        c.colors.completion.even.bg = palette["core"]
        c.colors.completion.odd.bg = palette["shadow"]
    c.colors.completion.fg = palette["fg_core"]

    ## Selected completion items
    c.colors.completion.item.selected.bg = palette["surface"]
    c.colors.completion.item.selected.border.bottom = palette["surface"]
    c.colors.completion.item.selected.border.top = palette["surface"]
    c.colors.completion.item.selected.fg = palette["fg_core"]
    c.colors.completion.item.selected.match.fg = palette["secondary"]
    c.colors.completion.match.fg = palette["match"]

    ## Color of the scrollbar in completion view
    c.colors.completion.scrollbar.bg = palette["mantle"]
    c.colors.completion.scrollbar.fg = palette["strong_primary"]
    # }}}

    # downloads {{{
    c.colors.downloads.bar.bg = palette["surface"]
    c.colors.downloads.error.bg = palette["surface"]
    c.colors.downloads.start.bg = palette["surface"]
    c.colors.downloads.stop.bg = palette["surface"]

    c.colors.downloads.error.fg = palette["red"]
    c.colors.downloads.start.fg = palette["yellow"]
    c.colors.downloads.stop.fg = palette["green"]
    c.colors.downloads.system.fg = "none"
    c.colors.downloads.system.bg = "none"
    # }}}

    # hints {{{
    c.colors.hints.bg = palette["primary"]
    c.colors.hints.fg = palette["core"]
    c.hints.border = "1px solid " + palette["core"]
    c.colors.hints.match.fg = palette["fg_muted"]
    # }}}

    # keyhints {{{
    c.colors.keyhint.bg = palette["mantle"]
    c.colors.keyhint.fg = palette["fg_core"]
    c.colors.keyhint.suffix.fg = palette["match"]
    # }}}

    # messages {{{
    c.colors.messages.error.bg = palette["mantle"]
    c.colors.messages.error.fg = palette["red"]
    c.colors.messages.error.border = palette["mantle"]

    c.colors.messages.warning.bg = palette["mantle"]
    c.colors.messages.warning.fg = palette["yellow"]
    c.colors.messages.warning.border = palette["mantle"]

    c.colors.messages.info.bg = palette["mantle"]
    c.colors.messages.info.fg = palette["teal"]
    c.colors.messages.info.border = palette["mantle"]
    # }}}

    # prompts {{{
    c.colors.prompts.bg = palette["mantle"]
    c.colors.prompts.border = "1px solid " + palette["mantle"]
    c.colors.prompts.fg = palette["fg_core"]
    c.colors.prompts.selected.bg = palette["search"]
    c.colors.prompts.selected.fg = palette["accent"]
    # }}}

    # statusbar {{{
    ## Background color of the statusbar.
    c.colors.statusbar.normal.bg = palette["mantle"]
    c.colors.statusbar.insert.bg = palette["mantle"]
    c.colors.statusbar.command.bg = palette["mantle"]
    c.colors.statusbar.caret.bg = palette["mantle"]
    c.colors.statusbar.caret.selection.bg = palette["mantle"]

    ## Background color of the progress bar.
    c.colors.statusbar.progress.bg = palette["surface"]
    c.colors.statusbar.passthrough.bg = palette["surface"]

    ## Foreground color of the statusbar.
    c.colors.statusbar.normal.fg = palette["fg_core"]
    c.colors.statusbar.insert.fg = palette["green"]
    c.colors.statusbar.command.fg = palette["light_primary"]
    c.colors.statusbar.passthrough.fg = palette["bright_yellow"]
    c.colors.statusbar.caret.fg = palette["bright_yellow"]
    c.colors.statusbar.caret.selection.fg = palette["bright_yellow"]

    ## Foreground color of the URL in the statusbar on error.
    c.colors.statusbar.url.error.fg = palette["red"]

    ## Default foreground color of the URL in the statusbar.
    c.colors.statusbar.url.fg = palette["fg_core"]

    ## Foreground color of the URL in the statusbar for hovered links.
    c.colors.statusbar.url.hover.fg = palette["bright_blue"]

    ## Foreground color of the URL in the statusbar on successful load
    c.colors.statusbar.url.success.http.fg = palette["teal"]
    c.colors.statusbar.url.success.https.fg = palette["green"]

    ## Foreground color of the URL in the statusbar when there's a warning.
    c.colors.statusbar.url.warn.fg = palette["yellow"]

    ## PRIVATE MODE COLORS
    ## Background color of the statusbar in private browsing mode.
    c.colors.statusbar.private.bg = palette["surface"]
    c.colors.statusbar.private.fg = palette["fg_dim"]
    c.colors.statusbar.command.private.bg = palette["surface"]
    c.colors.statusbar.command.private.fg = palette["accent"]

    # }}}

    # tabs {{{
    c.colors.tabs.bar.bg = palette["core"]
    c.colors.tabs.even.bg = palette["mantle"]
    c.colors.tabs.even.fg = palette["primary"]
    c.colors.tabs.odd.bg = palette["mantle"]
    c.colors.tabs.odd.fg = palette["primary"]

    ## Color for the tab indicator on errors.
    c.colors.tabs.indicator.error = palette["red"]

    ## Color gradient interpolation system for the tab indicator.
    ## Valid values:
    ## - rgb: Interpolate in the RGB color system.
    ## - hsv: Interpolate in the HSV color system.
    ## - hsl: Interpolate in the HSL color system.
    ## - none: Don't show a gradient.
    c.colors.tabs.indicator.system = "none"

    # ## Background color of selected tabs.
    c.colors.tabs.selected.even.bg = palette["primary"]
    c.colors.tabs.selected.even.fg = palette["core"]
    c.colors.tabs.selected.odd.bg = palette["strong_primary"]
    c.colors.tabs.selected.odd.fg = palette["core"]
    # }}}

    # pinned tabs {{{
    c.colors.tabs.pinned.even.bg = palette["mantle"]
    c.colors.tabs.pinned.even.fg = palette["secondary"]
    c.colors.tabs.pinned.odd.bg = palette["mantle"]
    c.colors.tabs.pinned.odd.fg = palette["secondary"]
    c.colors.tabs.pinned.selected.even.bg = palette["primary"]
    c.colors.tabs.pinned.selected.even.fg = palette["core"]
    c.colors.tabs.pinned.selected.odd.bg = palette["strong_primary"]
    c.colors.tabs.pinned.selected.odd.fg = palette["core"]
    # }}}

    # context menus {{{
    c.colors.contextmenu.menu.bg = palette["surface"]
    c.colors.contextmenu.menu.fg = palette["fg_core"]

    c.colors.contextmenu.disabled.bg = palette["mantle"]
    c.colors.contextmenu.disabled.fg = palette["fg_core"]

    c.colors.contextmenu.selected.bg = palette["fg_core"]
    c.colors.contextmenu.selected.fg = palette["core"]
    # }}}

    # tooltips {{{
    c.colors.tooltip.bg = palette["surface"]
    c.colors.tooltip.fg = palette["fg_core"]
    # }}}
