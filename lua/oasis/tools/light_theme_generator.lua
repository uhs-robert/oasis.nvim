-- lua/oasis/tools/light_theme_generator.lua
-- Light theme generation utilities for Oasis
-- Generates light mode color palettes from dark mode palettes

local ColorUtils = require("oasis.tools.color_utils")

local LightTheme = {}

--- Adjusts saturation and lightness for problematic hues in light backgrounds
--- @param h number Hue (0-360)
--- @param s number Saturation (0-100)
--- @param l number Lightness (0-100)
--- @return number, number Adjusted saturation and lightness
local function resolve_outliers(h, s, l)
  -- Normalize hue so negative shifts still fall inside expected ranges
  local hue = h % 360
  local new_s, new_l = s, l
  local very_light = l >= 88

  -- If the input is effectively neutral, leave it untouched to avoid tinting greys
  if s < 10 then return new_s, new_l end

  -- Yellow‑greens need aggressive desat in light mode
  if hue >= 60 and hue <= 170 then
    local sat_factor = very_light and 0.35 or 0.45
    new_s = s * sat_factor
    new_l = math.min(100, l + (very_light and 1 or 2))

  -- Warm yellows
  elseif hue >= 40 and hue < 60 then
    new_s = s * 0.50
    new_l = math.min(100, l + 1)

  -- Cyans/teals: still vivid on light bg, soften slightly
  elseif hue > 170 and hue <= 210 then
    local sat_factor = very_light and 0.55 or 0.65
    new_s = s * sat_factor
    new_l = math.min(100, l + 1)

  -- Blues: can appear inky; gentle desat and a small lift
  elseif hue > 210 and hue <= 240 then
    local sat_factor = very_light and 0.65 or 0.75
    new_s = s * sat_factor
    new_l = math.min(100, l + 1)

  -- Purples: can look inky; desaturate and lift a touch
  elseif hue > 240 and hue <= 320 then
    local sat_factor = very_light and 0.50 or 0.60
    new_s = s * sat_factor
    new_l = math.min(100, l + 1)

  -- Pinks/magentas: clip intensity to avoid neon glare
  elseif hue > 320 and hue <= 350 then
    local sat_factor = very_light and 0.45 or 0.55
    new_s = s * sat_factor
    new_l = math.min(100, l + (very_light and 1 or 2))

  -- Warm reds/oranges
  elseif (hue >= 0 and hue < 40) or (hue > 340) then
    new_s = s * 0.70
  end

  -- Extra guard: if background is already very light, cap saturation further
  if very_light and new_s > 70 then new_s = 70 + ((new_s - 70) * 0.5) end

  -- Prevent chalky glow on extremely bright backgrounds
  if l > 92 then new_s = math.min(new_s, 55) end

  return new_s, new_l
end

--- Softer hue-aware desaturation for foreground/UI accents
--- Keeps contrast targets intact while taming neon-prone hues
--- @param h number Hue (0-360)
--- @param s number Saturation (0-100)
--- @param l number Lightness (0-100)
--- @return number, number Adjusted saturation and lightness
local function soften_hue(h, s, l)
  local hue = h % 360
  local new_s, new_l = s, l
  local very_light = l >= 90

  -- Preserve neutrals
  if s < 10 then return new_s, new_l end

  -- Moderated factors (gentler than background handling)
  if hue >= 60 and hue <= 170 then -- yellow-greens
    new_s = s * (very_light and 0.55 or 0.65)
  elseif hue >= 40 and hue < 60 then -- warm yellows
    new_s = s * 0.65
  elseif hue > 170 and hue <= 210 then -- cyans/teals
    new_s = s * (very_light and 0.70 or 0.78)
  elseif hue > 210 and hue <= 240 then -- blues
    new_s = s * (very_light and 0.72 or 0.80)
  elseif hue > 240 and hue <= 320 then -- purples/indigos
    new_s = s * (very_light and 0.65 or 0.72)
  elseif hue > 320 and hue <= 350 then -- pinks/magentas
    new_s = s * (very_light and 0.60 or 0.68)
  elseif (hue >= 0 and hue < 40) or (hue > 350) then -- warm reds/oranges wrap
    new_s = s * 0.82
  end

  -- Cap saturation on extremely bright values to avoid chalky glow
  if l > 92 then new_s = math.min(new_s, 60) end

  return new_s, new_l
end

--- Apply light intensity transformation to a background color
--- @param base_color string Base color (typically dark mode fg.core)
--- @param intensity_level number Intensity level (1-5)
--- @return string Transformed hex color
function LightTheme.apply_intensity(base_color, intensity_level)
  if not base_color or intensity_level < 1 or intensity_level > 5 then return base_color end

  local h, original_s, _ = ColorUtils.rgb_to_hsl(base_color)

  local new_hue, new_sat, new_light

  if intensity_level == 1 then
    -- Subtle: shift hue -11°, moderate saturation, very light
    new_hue = h - 11
    new_sat = 38
    new_light = 97
  elseif intensity_level == 2 then
    -- Base: original hue, max saturation
    new_hue = h
    new_sat = 100
    new_light = 94
  elseif intensity_level == 3 then
    -- Medium: original hue, max saturation
    new_hue = h
    new_sat = 100
    new_light = 90
  elseif intensity_level == 4 then
    -- Vibrant: slight negative hue shift, max saturation
    new_hue = h - 1
    new_sat = 100
    new_light = 87
  else -- intensity_level == 5
    -- Saturated: stronger negative hue shift, max saturation
    new_hue = h - 4
    new_sat = 100
    new_light = 84
  end

  -- Achromatic seeds (grey) have no real hue — preserve neutral output
  if original_s == 0 then new_sat = 0 end

  -- Apply outlier adjustments for problematic hues
  new_sat, new_light = resolve_outliers(new_hue, new_sat, new_light)

  return ColorUtils.hsl_to_rgb(new_hue, new_sat, new_light)
end

--- Generate complete light mode background set from dark mode foreground
--- Derives all backgrounds (core, mantle, shadow, surface) from one seed color
--- @param light_bg_seed string Seed color
--- @param intensity_level number Light intensity (1-5)
--- @param opts? table Optional overrides { target_l_core = number|table, l_step = number, preserve_hsl = boolean }
--- @return table Background colors {core, mantle, shadow, surface}
function LightTheme.generate_bg(light_bg_seed, intensity_level, opts)
  local bg_core

  -- Seed encodes desired hue/saturation/lightness for intensity 3.
  if opts and opts.preserve_hsl then
    local h, s, seed_l = ColorUtils.rgb_to_hsl(light_bg_seed)
    local l = math.max(70, math.min(97, seed_l + (3 - intensity_level) * 3))
    bg_core = ColorUtils.hsl_to_rgb(h, s, l)
  else
    bg_core = LightTheme.apply_intensity(light_bg_seed, intensity_level)
  end
  local h, s, l = ColorUtils.rgb_to_hsl(bg_core)

  -- Optional lightness override
  if opts and opts.target_l_core then
    local override = opts.target_l_core
    if type(override) == "table" then override = override[intensity_level] end
    if override then l = override end
    bg_core = ColorUtils.hsl_to_rgb(h, s, l)
  end

  -- Darken in increasing step multipliers
  local step = (opts and opts.l_step) or 3
  local bg_shadow = ColorUtils.hsl_to_rgb(h, s, l - step)
  local bg_mantle = ColorUtils.hsl_to_rgb(h, s, l - (step * 1.5))
  local bg_surface = ColorUtils.hsl_to_rgb(h, s, l - (step * 4))

  return {
    shadow = bg_shadow,
    core = bg_core,
    mantle = bg_mantle,
    surface = bg_surface,
  }
end

--- Generate light mode foreground colors from dark mode
--- @param dark_fg table Dark mode fg colors {core, strong, muted, dim, comment}
--- @param light_bg_core string Light mode background core color
--- @param intensity_level number Intensity level (1-5) for subtle variations
--- @param contrast_targets? table Optional contrast ratio targets per element {strong=7.0, core=7.0, muted=4.5, dim=3.0, comment=4.5}
--- @return table Light mode foreground colors
function LightTheme.generate_fg(dark_fg, light_bg_core, intensity_level, contrast_targets)
  -- Default contrast targets (can be overridden)
  local default_targets = {
    core = 16.0, -- AAA
    strong = 9.0, -- AAA
    muted = 4.5, -- AA
    comment = 4.0, -- AA (muted, blends with background)
    dim = 3.0, -- Minimal
  }
  contrast_targets = contrast_targets or default_targets

  -- Base lightness values adjusted by intensity
  -- Intensity 1=subtle (lighter), 5=maximum (darker)
  local intensity_factor = (intensity_level - 1) * 0.05 -- 0 to 0.2 adjustment

  local base_lightness = {
    strong = 18 - (intensity_factor * 10), -- 18% to 16%
    core = 24 - (intensity_factor * 8), -- 24% to 20.4%
    muted = 42 - (intensity_factor * 12), -- 42% to 37.6%
    dim = 58 - (intensity_factor * 10), -- 58% to 54%
    comment = 38 - (intensity_factor * 8), -- 38% to 34.4%
  }

  local result = {}

  -- Generate each foreground color with appropriate lightness
  for key, target_l in pairs(base_lightness) do
    local source_color = dark_fg[key]
    if source_color then
      local h, s, _ = ColorUtils.rgb_to_hsl(source_color)
      -- Reduce saturation for subtlety (50% of original)
      local new_s = s * 0.5
      new_s, target_l = soften_hue(h, new_s, target_l)
      result[key] = ColorUtils.hsl_to_rgb(h, new_s, target_l)

      -- Apply contrast target if specified
      local target_ratio = contrast_targets[key] or default_targets[key]
      if target_ratio then result[key] = ColorUtils.darken_to_contrast(result[key], light_bg_core, target_ratio) end
    end
  end

  return result
end

--- Generate light mode syntax colors from dark mode
--- @param dark_syntax table Dark mode syntax colors
--- @param light_bg_core string Light mode background core color
--- @param intensity_level number Intensity level (1-5)
--- @param contrast_targets? table Optional contrast ratio targets per syntax element
--- @return table Light mode syntax colors
function LightTheme.generate_syntax(dark_syntax, light_bg_core, intensity_level, contrast_targets, opts)
  -- Contrast floor control
  opts = opts or {}
  local min_ratio = math.min(7.0, math.max(5.8, opts.min_ratio or 7.0))
  local force_aaa = opts.force_aaa or false

  -- Default contrast targets for syntax elements (base values)
  local default_targets = {
    -- High contrast (AAA+)
    func = min_ratio + 1.2,
    bracket = min_ratio + 1.5,
    string = min_ratio + 1.2,

    -- Standard AAA
    conditional = min_ratio,
    builtinFunc = min_ratio,
    builtinVar = min_ratio,
    exception = min_ratio,
    special = min_ratio,
    operator = min_ratio,
    punctuation = min_ratio + 1.2,
    preproc = min_ratio,

    -- Sub AAA
    statement = min_ratio - 1,
    regex = min_ratio - 1.2,
    builtinConst = min_ratio - 1,
    constant = min_ratio - 1,
    parameter = min_ratio - 0.5,
    type = min_ratio - 0.5,
    identifier = min_ratio - 0.5,

    -- Muted (AA) - blend with background
    comment = 4.5,
    delimiter = 4.5,

    -- Dim (A) - Faded into background
  }
  contrast_targets = contrast_targets or default_targets

  local result = {}

  -- Intensity affects base lightness (1=lighter/subtle, 5=darker/vibrant)
  local base_lightness = 28 - ((intensity_level - 1) * 2) -- 28% to 20%

  -- Color category adjustments for better semantic grouping
  local category_adjustments = {
    -- Cold colors (data): slightly lighter, more readable
    cold = { l_offset = 4, s_factor = 0.75 },
    -- Warm colors (control): slightly darker, more prominent
    warm = { l_offset = -2, s_factor = 0.80 },
    -- Outlier colors: for emphasis, darkest
    emphasis = { l_offset = 0, s_factor = 0.85 },
    -- Neutral colors: medium
    neutral = { l_offset = 0, s_factor = 0.65 },
  }

  -- Give emphasis tokens extra pop when their hue is unusually warm or cold for the theme.
  local function emphasize_outlier(h, target_l, new_s)
    local warm = (h < 60) or (h > 300) -- reds/oranges/yellows
    local cold = (h >= 180 and h <= 260) -- cyans/blue-purples
    if warm then
      -- Warm hues can look blown-out in light mode: darken and enrich
      return target_l - 3, math.min(1, new_s * 1.15)
    elseif cold then
      -- Cool hues tend to sink: lift lightness slightly and add a touch of saturation
      return target_l + 3, math.min(1, new_s * 1.08)
    end
    return target_l, new_s
  end

  -- Classify syntax elements by category
  local categories = {
    cold = { "identifier", "type", "typedef", "builtinConst", "parameter", "builtinVar" },
    warm = {
      "string",
      "regex",
      "statement",
      "exception",
      "conditional",
      "special",
      "operator",
      "punctuation",
      "preproc",
      "macro",
      "constant",
    },
    emphasis = {},
    neutral = { "bracket", "comment", "delimiter", "builtinFunc", "func" },
  }

  -- Generate colors for each category
  for category, keys in pairs(categories) do
    local adj = category_adjustments[category]

    for _, key in ipairs(keys) do
      local source_color = dark_syntax[key]
      if source_color then
        local h, s, _ = ColorUtils.rgb_to_hsl(source_color)

        -- Apply category-specific adjustments
        local target_l = base_lightness + adj.l_offset
        local new_s = s * adj.s_factor

        -- Emphasis tokens get extra contrast
        if category == "emphasis" then
          target_l, new_s = emphasize_outlier(h, target_l, new_s)
        end

        -- Allow slight hue shifts for better light-mode appearance
        -- Shift blues/purples slightly warmer, oranges/reds slightly cooler
        local hue_shift = 0
        if h >= 200 and h <= 280 then
          -- Blues/purples: shift 3° warmer
          hue_shift = 3
        elseif h >= 0 and h <= 60 then
          -- Reds/oranges: shift 2° cooler
          hue_shift = -2
        end

        local new_h = (h + hue_shift) % 360
        result[key] = ColorUtils.hsl_to_rgb(new_h, new_s, target_l)

        -- Apply contrast target
        local base_target = contrast_targets[key] or default_targets[key] or 7.0
        local target_ratio
        if force_aaa then
          target_ratio = math.max(7.0, base_target)
        else
          target_ratio = base_target
        end

        result[key] = ColorUtils.darken_to_contrast(result[key], light_bg_core, target_ratio)
      end
    end
  end

  return result
end

--- Generate light mode UI colors from dark mode
--- @param dark_ui table Dark mode UI colors
--- @param light_bg table Light mode background colors {core, mantle, shadow, surface}
--- @param intensity_level number Intensity level (1-5)
--- @param contrast_targets? table Optional contrast ratio targets per UI element
--- @param opts? table Optional { min_ratio = number, force_aaa = boolean }
--- @return table Light mode UI colors
function LightTheme.generate_ui(dark_ui, light_bg, intensity_level, contrast_targets, opts)
  -- Contrast floor control
  opts = opts or {}
  local min_ratio = math.min(7.0, math.max(3.0, opts.min_ratio or 7.0))
  local aa_compliant = math.min(4.5, min_ratio)
  local force_aaa = opts.force_aaa or false

  -- Default contrast targets for UI elements
  local default_targets = {
    lineNumber = min_ratio - 2.5,
    dir = aa_compliant + 2.0,
    title = aa_compliant + 1.0,
    border = aa_compliant + 1.0,
    diag = aa_compliant + 1.0,
    nontext = 3.5,
  }
  contrast_targets = contrast_targets or default_targets

  -- Override with force AAA if specified
  if force_aaa then
    for key, _ in pairs(default_targets) do
      if key ~= "nontext" and key ~= "title" and key ~= "border" then
        local base_target = contrast_targets[key] or default_targets[key]
        contrast_targets[key] = math.max(7.0, base_target)
      end
    end
  end

  local function soften_ui_color(source, ratio)
    if type(source) ~= "string" then return light_bg.core end
    local h, s, _ = ColorUtils.rgb_to_hsl(source)
    local new_s, base_l = soften_hue(h, s * 0.75, 30 - ((intensity_level - 1) * 2))
    return ColorUtils.darken_to_contrast(ColorUtils.hsl_to_rgb(h, new_s, base_l), light_bg.core, ratio or min_ratio)
  end

  local result = {}

  local complex_keys = {
    visual = true,
    search = true,
    match = true,
    matchParen = true,
    float = true,
    picker = true,
    diag = true,
    cursorLine = true,
  }

  for key, value in pairs(dark_ui) do
    if not complex_keys[key] and type(value) == "string" then
      local h, s, _ = ColorUtils.rgb_to_hsl(value)
      local base_l = 30 - ((intensity_level - 1) * 2)
      local new_s = s * 0.75
      new_s, base_l = soften_hue(h, new_s, base_l)
      result[key] = ColorUtils.hsl_to_rgb(h, new_s, base_l)

      local target_ratio = contrast_targets[key] or default_targets[key] or 7.0
      result[key] = ColorUtils.darken_to_contrast(result[key], light_bg.core, target_ratio)
    end
  end

  -- CursorLine uses background variant
  result.cursorLine = light_bg.mantle

  -- Visual selection (bg = surface for subtle highlight)
  if dark_ui.visual then result.visual = { bg = light_bg.surface, fg = "none" } end

  -- Search colors
  if dark_ui.search then
    local h, _, _ = ColorUtils.rgb_to_hsl(dark_ui.search.bg or "#000000")
    local s1, l1 = soften_hue(h, 65, 75)
    local s2, l2 = soften_hue(h, 85, 18)
    result.search = {
      bg = ColorUtils.hsl_to_rgb(h, s1, l1),
      fg = ColorUtils.hsl_to_rgb(h, s2, l2),
    }
  end

  -- Current search (more prominent)
  if dark_ui.match then
    local h, _, _ = ColorUtils.rgb_to_hsl(dark_ui.match.bg or "#000000")
    local s1, l1 = soften_hue(h, 75, 65)
    local s2, l2 = soften_hue(h, 90, 12)
    result.match = {
      bg = ColorUtils.hsl_to_rgb(h, s1, l1),
      fg = ColorUtils.hsl_to_rgb(h, s2, l2),
    }
  end

  -- Match paren (subtle highlight with readable fg)
  if dark_ui.matchParen then
    local fg_h, fg_s, _ = ColorUtils.rgb_to_hsl(dark_ui.matchParen.fg or "#000000")
    local adj_s, adj_l = soften_hue(fg_h, fg_s * 0.75, 30)
    local light_fg = ColorUtils.hsl_to_rgb(fg_h, adj_s, adj_l)
    light_fg = ColorUtils.darken_to_contrast(light_fg, light_bg.core, aa_compliant)
    result.matchParen = {
      bg = light_bg.surface,
      fg = light_fg,
    }
  end

  if dark_ui.float then
    local float_title = soften_ui_color(dark_ui.float.title, 8.0)
    local float_border = soften_ui_color(dark_ui.float.border and dark_ui.float.border.fg, aa_compliant + 1.0)
    result.float = {
      title = float_title,
      fg = float_title,
      bg = light_bg.mantle,
      border = { fg = float_border, bg = light_bg.mantle },
    }
  end

  if dark_ui.picker then
    local picker_title = soften_ui_color(dark_ui.picker.title, 7.0)
    local picker_border = soften_ui_color(dark_ui.picker.border and dark_ui.picker.border.fg, aa_compliant + 1.0)
    result.picker = {
      title = picker_title,
      fg = picker_title,
      bg = light_bg.mantle,
      border = { fg = picker_border, bg = light_bg.mantle },
    }
  end

  -- Diagnostics (vibrant backgrounds that pop)
  if dark_ui.diag then
    result.diag = {}
    for level, colors in pairs(dark_ui.diag) do
      if type(colors) == "table" and colors.fg then
        local h, _, _ = ColorUtils.rgb_to_hsl(colors.fg)
        local adj_s, adj_l = soften_hue(h, 55, 70)
        local diag_bg = ColorUtils.hsl_to_rgb(h, adj_s, adj_l)
        local diag_fg = ColorUtils.hsl_to_rgb(h, 65, 45)
        diag_fg = ColorUtils.darken_to_contrast(diag_fg, diag_bg, 4.5)

        result.diag[level] = {
          fg = diag_fg,
          bg = diag_bg,
        }
      end
    end
  end

  -- Generic fallback: any unknown table with bg/fg string fields gets a
  -- standard light-mode bg (high-lightness tint) + contrast-checked fg.
  for key, value in pairs(dark_ui) do
    if not complex_keys[key] and not result[key] and type(value) == "table" then
      local out = {}
      if type(value.bg) == "string" then
        local h, _, _ = ColorUtils.rgb_to_hsl(value.bg)
        local adj_s, adj_l = soften_hue(h, 65, 82)
        out.bg = ColorUtils.hsl_to_rgb(h, adj_s, adj_l)
      end
      if type(value.fg) == "string" then
        local h, s, _ = ColorUtils.rgb_to_hsl(value.fg)
        local adj_s, adj_l = soften_hue(h, s * 0.75, 25)
        local fg = ColorUtils.hsl_to_rgb(h, adj_s, adj_l)
        local bg_ref = out.bg or light_bg.core
        out.fg = ColorUtils.darken_to_contrast(fg, bg_ref, min_ratio)
      end
      if next(out) then result[key] = out end
    end
  end

  return result
end

--- Generate light-mode ANSI terminal palette from dark terminal colors
--- Applies hue-aware softening and enforces minimum contrast on light backgrounds
--- @param dark_terminal table Dark mode terminal colors (ansi keys and color0..15)
--- @param light_bg_core string Light background core color
--- @param intensity_level number Intensity level (1-5)
--- @param opts? table Optional { force_aaa = boolean, chroma_target = number, neutral_target = number, min_ratio = number }
--- @return table Light mode terminal colors
function LightTheme.generate_terminal(dark_terminal, light_bg_core, intensity_level, opts)
  if not dark_terminal or not light_bg_core then return {} end

  opts = opts or {}
  intensity_level = math.max(1, math.min(5, intensity_level or 3))

  -- Contrast targets
  local default_chroma_target = 5.5
  local default_neutral_target = 8.2
  local chroma_target = opts.chroma_target or default_chroma_target
  local neutral_target = opts.neutral_target or default_neutral_target
  local min_ratio = math.min(7.0, math.max(4.5, opts.min_ratio or chroma_target))
  chroma_target = math.max(chroma_target, min_ratio)
  if opts.force_aaa then
    chroma_target = 7.0
    neutral_target = 8.5
  end

  -- Neutrals vs chromatics
  local neutral_keys = {
    black = true,
    bright_black = true,
    white = true,
    bright_white = true,
    color0 = true,
    color8 = true,
    color7 = true,
    color15 = true,
  }

  local result = {}

  for key, value in pairs(dark_terminal) do
    if type(value) == "string" then
      local h, s, l = ColorUtils.rgb_to_hsl(value)

      -- Base lightness: pull colors darker for light bg; small bias by intensity
      local base_l = (l * 0.55)
      base_l = base_l - ((3 - intensity_level) * 2) -- lighter intensities → darker terminal text
      base_l = math.max(16, math.min(55, base_l))

      -- Hue-aware softening to avoid neon spikes
      local new_s = s
      new_s, _ = soften_hue(h, new_s, base_l)

      local color = ColorUtils.hsl_to_rgb(h, new_s, base_l)

      -- Choose contrast target by slot type
      local target = neutral_keys[key] and neutral_target or chroma_target
      color = ColorUtils.darken_to_contrast(color, light_bg_core, target)

      result[key] = color
    else
      result[key] = value
    end
  end

  return result
end

--- Generate light mode theme colors from dark mode (vibrant, decorative)
--- Note: These colors are decorative and intentionally may not meet WCAG compliance
--- These colors can fail WCAG compliance as they're decorative only
--- @param dark_theme table Dark mode theme colors {strong_primary, primary, light_primary, secondary, secondary_strong, secondary_light, label, accent}
--- @param intensity_level number Intensity level (1-5)
--- @return table Light mode theme colors (vibrant)
function LightTheme.generate_theme(dark_theme, intensity_level)
  local result = {}

  local sat_factor = 0.9 + (intensity_level * 0.02) -- 0.92 to 1.0
  local light_base = 35 - (intensity_level * 2) -- 33% to 25%

  -- Per-key lightness offsets; keys not listed get offset 0
  local l_offsets = {
    strong_primary = 7.5,
    primary = -5.5,
    light_primary = -7.5,
    secondary = -5.5,
    secondary_strong = 7.5,
    secondary_light = -7.5,
    label = 3,
    accent = 2,
    status = 2,
    cursor = 0,
  }

  for key, value in pairs(dark_theme) do
    if key == "palette" then
      result.palette = value
    elseif type(value) == "string" then
      local h, s, _ = ColorUtils.rgb_to_hsl(value)
      local offset = l_offsets[key] or 0
      result[key] = ColorUtils.hsl_to_rgb(h, s * sat_factor, light_base + offset)
    end
  end

  return result
end

--- Generate light-mode git colors, using light terminal bright_yellow for change
--- @param dark_git table Dark mode git colors
--- @param light_terminal table Already-computed light terminal colors
--- @param light_bg_core string Light background core color
--- @param opts? table Optional { target_contrast = number, min_ratio = number, force_aaa = boolean }
--- @return table Light mode git colors
function LightTheme.generate_git(dark_git, light_terminal, light_bg_core, opts)
  local result = LightTheme.apply_contrast(dark_git, light_bg_core, opts)
  if light_terminal and light_terminal.bright_yellow then result.change = light_terminal.bright_yellow end
  return result
end

--- Apply contrast adjustment to all string values in a table
--- @param dark_table table Table with color values
--- @param light_bg_core string Light mode background core color
--- @param opts? table Optional { target_contrast = number, min_ratio = number, force_aaa = boolean }
--- @return table Table with adjusted colors
function LightTheme.apply_contrast(dark_table, light_bg_core, opts)
  opts = opts or {}
  local target = opts.target_contrast or 5.5
  local min_ratio = math.min(7.0, math.max(4.5, opts.min_ratio or target))
  target = math.max(target, min_ratio)
  if opts.force_aaa then target = 7.0 end
  local result = {}

  for key, value in pairs(dark_table) do
    if type(value) == "string" then
      result[key] = ColorUtils.darken_to_contrast(value, light_bg_core, target)
    else
      result[key] = value
    end
  end

  return result
end

return LightTheme
