-- lua/oasis/types.lua
---@meta
-- Type definitions for LuaLS autocomplete support

-- Palette section types
---@class OasisPaletteBg
---@field core string
---@field mantle string
---@field crust string
---@field surface string
---@field gutter? string
---@field shadow? string

---@class OasisPaletteFg
---@field core string
---@field muted string
---@field dim string
---@field strong string

---@class OasisPaletteTheme
---@field primary string
---@field strong_primary? string
---@field light_primary? string
---@field secondary string
---@field accent string

---@class OasisPaletteSyntax
---@field parameter string
---@field identifier string
---@field type string
---@field builtinVar string
---@field string string
---@field regex string
---@field builtinConst string
---@field constant string
---@field func string
---@field builtinFunc string
---@field statement string
---@field conditional string
---@field exception string
---@field keyword string
---@field special string
---@field operator string
---@field punctuation string
---@field preproc string
---@field bracket string
---@field comment string
---@field delimiter? string

---@class OasisPaletteUiVisual
---@field bg string
---@field fg? string

---@class OasisPaletteUiSearch
---@field bg string
---@field fg? string

---@class OasisPaletteUiMatch
---@field bg string
---@field fg string

---@class OasisPaletteUiFloatBorder
---@field fg string
---@field bg string

---@class OasisPaletteUiFloat
---@field title string
---@field fg string
---@field bg string
---@field border OasisPaletteUiFloatBorder

---@class OasisPaletteUiDiagEntry
---@field fg string
---@field bg string

---@class OasisPaletteUiDiag
---@field error OasisPaletteUiDiagEntry
---@field warn OasisPaletteUiDiagEntry
---@field info OasisPaletteUiDiagEntry
---@field hint OasisPaletteUiDiagEntry
---@field ok OasisPaletteUiDiagEntry

---@class OasisPaletteUi
---@field visual OasisPaletteUiVisual
---@field search OasisPaletteUiSearch
---@field match OasisPaletteUiMatch
---@field dir string
---@field title string
---@field border string
---@field cursorLine string
---@field lineNumber string
---@field nontext string
---@field float OasisPaletteUiFloat
---@field diag OasisPaletteUiDiag

---@class OasisPaletteDiff
---@field add string
---@field change string
---@field delete string

---@class OasisPaletteTerminal
---@field color0 string
---@field color1 string
---@field color2 string
---@field color3 string
---@field color4 string
---@field color5 string
---@field color6 string
---@field color7 string
---@field color8 string
---@field color9 string
---@field color10 string
---@field color11 string
---@field color12 string
---@field color13 string
---@field color14 string
---@field color15 string

---@class OasisPalette Table for palette
---@field light_mode boolean Whether this is a light mode palette
---@field light_intensity? number Light background intensity (1-5, light mode only)
---@field bg OasisPaletteBg
---@field fg OasisPaletteFg
---@field theme OasisPaletteTheme
---@field syntax OasisPaletteSyntax
---@field ui OasisPaletteUi
---@field diff OasisPaletteDiff
---@field terminal OasisPaletteTerminal

-- Highlight types
---@class OasisHighlightAttrs Table for highlight attributes
---@field fg? string Foreground color
---@field bg? string Background color
---@field sp? string Special color (for undercurl, underline)
---@field bold? boolean Bold text
---@field italic? boolean Italic text
---@field underline? boolean Underline
---@field undercurl? boolean Undercurl (wavy underline)
---@field strikethrough? boolean Strikethrough
---@field reverse? boolean Reverse video
---@field standout? boolean Standout
---@field blend? number Blend level (0-100)
---@field link? string Link to another highlight group

---@alias OasisHighlightDefinition OasisHighlightAttrs|string

---@alias OasisHighlightGroupMap table<string, OasisHighlightDefinition>

---@class OasisHighlightPaletteOverrides Per-palette highlight overrides
---@field [string] OasisHighlightDefinition Dark mode highlight overrides
---@field light? OasisHighlightGroupMap
---@field light_1? OasisHighlightGroupMap
---@field light_2? OasisHighlightGroupMap
---@field light_3? OasisHighlightGroupMap
---@field light_4? OasisHighlightGroupMap
---@field light_5? OasisHighlightGroupMap

---@class OasisHighlightOverrides : OasisHighlightGroupMap
---@field light? OasisHighlightGroupMap Global light mode overrides (all themes, all intensities)
---@field light_1? OasisHighlightGroupMap Global light intensity 1 overrides (all themes)
---@field light_2? OasisHighlightGroupMap Global light intensity 2 overrides (all themes)
---@field light_3? OasisHighlightGroupMap Global light intensity 3 overrides (all themes)
---@field light_4? OasisHighlightGroupMap Global light intensity 4 overrides (all themes)
---@field light_5? OasisHighlightGroupMap Global light intensity 5 overrides (all themes)
---@field lagoon? OasisHighlightPaletteOverrides Lagoon palette-specific overrides
---@field night? OasisHighlightPaletteOverrides Night palette-specific overrides
---@field midnight? OasisHighlightPaletteOverrides Midnight palette-specific overrides
---@field abyss? OasisHighlightPaletteOverrides Abyss palette-specific overrides
---@field starlight? OasisHighlightPaletteOverrides Starlight palette-specific overrides
---@field desert? OasisHighlightPaletteOverrides Desert palette-specific overrides
---@field sol? OasisHighlightPaletteOverrides Sol palette-specific overrides
---@field canyon? OasisHighlightPaletteOverrides Canyon palette-specific overrides
---@field dune? OasisHighlightPaletteOverrides Dune palette-specific overrides
---@field cactus? OasisHighlightPaletteOverrides Cactus palette-specific overrides
---@field mirage? OasisHighlightPaletteOverrides Mirage palette-specific overrides
---@field twilight? OasisHighlightPaletteOverrides Twilight palette-specific overrides
---@field rose? OasisHighlightPaletteOverrides Rose palette-specific overrides

-- Config option types
---@class OasisStyleConfig Table for text styles
---@field bold? boolean Enable/disable bold text
---@field italic? boolean Enable/disable italic text
---@field underline? boolean Enable/disable underline
---@field undercurl? boolean Enable/disable undercurl
---@field strikethrough? boolean Enable/disable strikethrough

---@class OasisContrastConfig Table of contrast settings
---@field min_ratio? number Minimum WCAG contrast ratio (4.5-7.0)
---@field force_aaa? boolean Force AAA compliance (7.0:1)

-- Base color scales
---@class OasisColorScale Tailwind-style numeric color scale
---@field [50] string Lightest shade
---@field [100] string Light shade
---@field [200] string Light-medium shade
---@field [300] string Medium-light shade
---@field [400] string Medium shade
---@field [500] string Base color
---@field [600] string Medium-dark shade
---@field [700] string Dark shade
---@field [800] string Darker shade
---@field [900] string Darkest shade

---@class OasisBaseColors Base color palette from palette.lua
---@field terminal table Terminal colors (black, red, green, yellow, blue, magenta, cyan, white, bright_*)
---@field light_terminal table Light mode terminal colors
---@field visual table Visual selection backgrounds (red, stone, orange, yellow, green, teal, blue, indigo, violet, pink, grey, light_*)
---@field diag table Diagnostic colors (error, warn, info, hint, ok with fg/bg)
---@field theme table Theme-specific bg/fg values per palette variant
---@field grey OasisColorScale Grey color scale (50-900)
---@field slate OasisColorScale Slate color scale (50-900)
---@field stone OasisColorScale Stone color scale (50-900)
---@field red OasisColorScale Red color scale (50-900)
---@field coral OasisColorScale Coral color scale (50-900)
---@field peach OasisColorScale Peach color scale (50-900)
---@field rose OasisColorScale Rose/pink color scale (50-900)
---@field sundown OasisColorScale Peachy coral orange scale (50-900)
---@field sunrise OasisColorScale Red-orange scale (50-900)
---@field sunshine OasisColorScale Golden orange scale (50-900)
---@field sunset OasisColorScale Peachy evening orange scale (50-900)
---@field gold OasisColorScale Metallic yellow scale (50-900)
---@field khaki OasisColorScale Muted earth yellow scale (50-900)
---@field dune OasisColorScale Sandy yellow scale (50-900)
---@field sand OasisColorScale Pale sandy beige scale (50-900)
---@field soil OasisColorScale Earthy brown scale (50-900)
---@field palm OasisColorScale Vibrant plant green scale (50-900)
---@field moss OasisColorScale Yellow-green scale (50-900)
---@field aloe OasisColorScale Pale sage green scale (50-900)
---@field cactus OasisColorScale Green-cyan desert succulent scale (50-900)
---@field teal OasisColorScale Teal scale (50-900)
---@field cyan OasisColorScale Cyan scale (50-900)
---@field sky OasisColorScale Sky blue scale (50-900)
---@field horizon OasisColorScale Bright cyan-blue scale (50-900)
---@field lagoon OasisColorScale Aqua blue scale (50-900)
---@field sapphire OasisColorScale Deep blue scale (50-900)
---@field lavender OasisColorScale Purple scale (50-900)

-- Palette override types
---@class OasisPaletteBgOverrides
---@field core? string
---@field mantle? string
---@field crust? string
---@field surface? string
---@field gutter? string
---@field shadow? string

---@class OasisPaletteFgOverrides
---@field core? string
---@field muted? string
---@field dim? string
---@field strong? string

---@class OasisPaletteThemeOverrides
---@field primary? string
---@field secondary? string
---@field accent? string
---@field strong_primary? string
---@field light_primary? string

---@class OasisPaletteSyntaxOverrides
---@field parameter? string
---@field identifier? string
---@field type? string
---@field builtinVar? string
---@field string? string
---@field regex? string
---@field builtinConst? string
---@field constant? string
---@field func? string
---@field builtinFunc? string
---@field statement? string
---@field conditional? string
---@field exception? string
---@field keyword? string
---@field special? string
---@field operator? string
---@field punctuation? string
---@field preproc? string
---@field bracket? string
---@field comment? string
---@field delimiter? string

---@class OasisPaletteUiVisualOverrides
---@field bg? string
---@field fg? string

---@class OasisPaletteUiSearchOverrides
---@field bg? string
---@field fg? string

---@class OasisPaletteUiMatchOverrides
---@field bg? string
---@field fg? string

---@class OasisPaletteUiFloatBorderOverrides
---@field fg? string
---@field bg? string

---@class OasisPaletteUiFloatOverrides
---@field title? string
---@field fg? string
---@field bg? string
---@field border? OasisPaletteUiFloatBorderOverrides

---@class OasisPaletteUiDiagEntryOverrides
---@field fg? string
---@field bg? string

---@class OasisPaletteUiDiagOverrides
---@field error? OasisPaletteUiDiagEntryOverrides
---@field warn? OasisPaletteUiDiagEntryOverrides
---@field info? OasisPaletteUiDiagEntryOverrides
---@field hint? OasisPaletteUiDiagEntryOverrides
---@field ok? OasisPaletteUiDiagEntryOverrides

---@class OasisPaletteUiOverrides
---@field visual? OasisPaletteUiVisualOverrides
---@field search? OasisPaletteUiSearchOverrides
---@field match? OasisPaletteUiMatchOverrides
---@field dir? string
---@field title? string
---@field border? string
---@field cursorLine? string
---@field lineNumber? string
---@field nontext? string
---@field float? OasisPaletteUiFloatOverrides
---@field diag? OasisPaletteUiDiagOverrides

---@class OasisPaletteDiffOverrides
---@field add? string
---@field change? string
---@field delete? string

---@class OasisPaletteTerminalOverrides
---@field color0? string
---@field color1? string
---@field color2? string
---@field color3? string
---@field color4? string
---@field color5? string
---@field color6? string
---@field color7? string
---@field color8? string
---@field color9? string
---@field color10? string
---@field color11? string
---@field color12? string
---@field color13? string
---@field color14? string
---@field color15? string

---@class OasisPaletteColorOverrides Dark mode palette color overrides
---@field bg? OasisPaletteBgOverrides
---@field fg? OasisPaletteFgOverrides
---@field theme? OasisPaletteThemeOverrides
---@field syntax? OasisPaletteSyntaxOverrides
---@field ui? OasisPaletteUiOverrides
---@field diff? OasisPaletteDiffOverrides
---@field terminal? OasisPaletteTerminalOverrides
---@field light? OasisPaletteColorOverrides Light mode overrides (all intensities)
---@field light_1? OasisPaletteColorOverrides Light intensity 1 overrides
---@field light_2? OasisPaletteColorOverrides Light intensity 2 overrides
---@field light_3? OasisPaletteColorOverrides Light intensity 3 overrides
---@field light_4? OasisPaletteColorOverrides Light intensity 4 overrides
---@field light_5? OasisPaletteColorOverrides Light intensity 5 overrides

---@alias OasisPaletteOverrideMap table<string, OasisPaletteColorOverrides>

---@class OasisPaletteOverrides : OasisPaletteOverrideMap
---@field light? OasisPaletteColorOverrides Global light mode overrides (all themes, all intensities)
---@field light_1? OasisPaletteColorOverrides Global light intensity 1 overrides (all themes)
---@field light_2? OasisPaletteColorOverrides Global light intensity 2 overrides (all themes)
---@field light_3? OasisPaletteColorOverrides Global light intensity 3 overrides (all themes)
---@field light_4? OasisPaletteColorOverrides Global light intensity 4 overrides (all themes)
---@field light_5? OasisPaletteColorOverrides Global light intensity 5 overrides (all themes)
---@field lagoon? OasisPaletteColorOverrides Lagoon palette-specific overrides
---@field night? OasisPaletteColorOverrides Night palette-specific overrides
---@field midnight? OasisPaletteColorOverrides Midnight palette-specific overrides
---@field abyss? OasisPaletteColorOverrides Abyss palette-specific overrides
---@field starlight? OasisPaletteColorOverrides Starlight palette-specific overrides
---@field desert? OasisPaletteColorOverrides Desert palette-specific overrides
---@field sol? OasisPaletteColorOverrides Sol palette-specific overrides
---@field canyon? OasisPaletteColorOverrides Canyon palette-specific overrides
---@field dune? OasisPaletteColorOverrides Dune palette-specific overrides
---@field cactus? OasisPaletteColorOverrides Cactus palette-specific overrides
---@field mirage? OasisPaletteColorOverrides Mirage palette-specific overrides
---@field twilight? OasisPaletteColorOverrides Twilight palette-specific overrides
---@field rose? OasisPaletteColorOverrides Rose palette-specific overrides

---@alias OasisPaletteOverridesFunction fun(c: OasisPalette, colors: OasisBaseColors): OasisPaletteOverrides
---@alias OasisHighlightOverridesFunction fun(c: OasisPalette, colors: OasisBaseColors): OasisHighlightOverrides

---@class OasisConfig Table for main configuration
---@field style? string Palette variant shorthand (e.g., "lagoon", "desert")
---@field dark_style? string Dark mode palette ("auto" or shorthand variant name)
---@field light_style? string Light mode palette ("auto" or shorthand variant name)
---@field use_legacy_comments? boolean Use classic vim desert comments (desert only)
---@field themed_syntax? boolean Use theme primary color for statements
---@field light_intensity? number Light background intensity (1-5)
---@field palette_overrides? OasisPaletteOverrides|OasisPaletteOverridesFunction Table of per-palette color overrides or function returning overrides
---@field highlight_overrides? OasisHighlightOverrides|OasisHighlightOverridesFunction Table of highlight group overrides or function returning overrides
---@field contrast? OasisContrastConfig Table of contrast settings (min_ratio, force_aaa)
---@field styles? OasisStyleConfig Table of text styling toggles (bold, italic, underline, undercurl, strikethrough)
---@field terminal_colors? boolean Apply colors to built-in terminal
---@field transparent? boolean Make backgrounds transparent

return {}
