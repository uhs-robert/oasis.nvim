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

  local h, _, _ = ColorUtils.rgb_to_hsl(base_color)

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

  -- Apply outlier adjustments for problematic hues
  new_sat, new_light = resolve_outliers(new_hue, new_sat, new_light)

  return ColorUtils.hsl_to_rgb(new_hue, new_sat, new_light)
end

--- Generate complete light mode background set from dark mode foreground
--- Derives all backgrounds (core, mantle, shadow, surface) from dark fg.core
--- @param dark_fg_core string Dark mode fg.core color (source of truth)
--- @param intensity_level number Light intensity (1-5)
--- @param opts? table Optional overrides { target_l_core = number|table, l_step = number }
--- @return table Background colors {core, mantle, shadow, surface}
function LightTheme.generate_bg(dark_fg_core, intensity_level, opts)
  -- Generate base bg.core using intensity formula
  local core = LightTheme.apply_intensity(dark_fg_core, intensity_level)

  -- Get HSL of core to derive related backgrounds
  local h, s, l = ColorUtils.rgb_to_hsl(core)

  -- Optional lightness override for palettes that want a specific band
  if opts and opts.target_l_core then
    local override = opts.target_l_core
    if type(override) == "table" then override = override[intensity_level] end
    if override then l = override end
    core = ColorUtils.hsl_to_rgb(h, s, l)
  end

  -- Progressive darkening: core (lightest) → mantle → shadow → surface (darkest)
  -- Each step is 3% darker in lightness by default
  local step = (opts and opts.l_step) or 3
  local mantle = ColorUtils.hsl_to_rgb(h, s, l - step)
  local shadow = ColorUtils.hsl_to_rgb(h, s, l - (step * 2))
  local surface = ColorUtils.hsl_to_rgb(h, s, l - (step * 3))

  return {
    core = core,
    mantle = mantle,
    shadow = shadow,
    surface = surface,
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
    strong = 7.0, -- AAA
    core = 7.0, -- AAA
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
  local min_ratio = math.min(7.0, math.max(4.5, opts.min_ratio or 7.0))
  local force_aaa = opts.force_aaa or false

  -- Default contrast targets for syntax elements (base values)
  local default_targets = {
    -- Highest Contract (AAA++)
    constant = min_ratio + 3.0,
    parameter = min_ratio + 1.5,

    -- High contrast (AAA+)
    type = min_ratio + 0.5,
    string = min_ratio + 0.5,
    func = min_ratio + 0.5,
    conditional = min_ratio + 0.5,

    -- Standard AAA
    identifier = min_ratio,
    builtinVar = min_ratio,
    regex = min_ratio,
    builtinConst = min_ratio,
    builtinFunc = min_ratio,
    statement = min_ratio,
    exception = min_ratio,
    special = min_ratio,
    operator = min_ratio,
    punctuation = min_ratio,
    preproc = min_ratio,
    delimiter = min_ratio,

    -- Muted (AA) - blend with background
    bracket = 4.5,
    comment = 4.5,

    -- Dim (A) - Faded into background
    nontext = 3.0,
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
    -- Outlier colors: for emphasis, most prominent
    emphasis = { l_offset = 0, s_factor = 1.00 },
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
    cold = { "identifier", "type", "string", "regex", "builtinConst" },
    warm = {
      "func",
      "builtinFunc",
      "statement",
      "exception",
      "conditional",
      "special",
      "operator",
      "punctuation",
      "preproc",
    },
    emphasis = { "constant", "builtinVar", "parameter" },
    neutral = { "bracket", "comment", "delimiter" },
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
  local aa_compliant = math.max(4.5, min_ratio)
  local force_aaa = opts.force_aaa or false

  -- Default contrast targets for UI elements
  local default_targets = {
    lineNumber = min_ratio,
    dir = min_ratio,
    title = aa_compliant,
    border = aa_compliant,
    nontext = 3.0,
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

  local result = {}

  -- Simple elements
  local simple_elements = {
    "lineNumber",
    "dir",
    "title",
    "border",
    "nontext",
  }

  for _, key in ipairs(simple_elements) do
    if dark_ui[key] and type(dark_ui[key]) == "string" then
      local h, s, _ = ColorUtils.rgb_to_hsl(dark_ui[key])
      local base_l = 30 - ((intensity_level - 1) * 2)
      local new_s = s * 0.75
      new_s, base_l = soften_hue(h, new_s, base_l)
      result[key] = ColorUtils.hsl_to_rgb(h, new_s, base_l)

      -- Apply contrast target
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
  if dark_ui.curSearch then
    local h, _, _ = ColorUtils.rgb_to_hsl(dark_ui.curSearch.bg or "#000000")
    local s1, l1 = soften_hue(h, 75, 65)
    local s2, l2 = soften_hue(h, 90, 12)
    result.curSearch = {
      bg = ColorUtils.hsl_to_rgb(h, s1, l1),
      fg = ColorUtils.hsl_to_rgb(h, s2, l2),
    }
  end

  -- Float window
  if dark_ui.float then
    result.float = {
      title = result.title or light_bg.core,
      fg = result.title or light_bg.core,
      bg = light_bg.surface,
      border = {
        fg = result.border or light_bg.core,
        bg = light_bg.mantle,
      },
    }
  end

  -- Diagnostics (vibrant backgrounds that pop)
  if dark_ui.diag then
    result.diag = {}
    for level, colors in pairs(dark_ui.diag) do
      if type(colors) == "table" and colors.fg then
        local h, _, _ = ColorUtils.rgb_to_hsl(colors.fg)
        -- Create vibrant, darker background (higher saturation, lower lightness)
        local adj_s, adj_l = soften_hue(h, 55, 70)
        local diag_bg = ColorUtils.hsl_to_rgb(h, adj_s, adj_l)
        -- Generate dark foreground from the same hue for AAA contrast
        local diag_fg = ColorUtils.hsl_to_rgb(h, 80, 15)
        -- Ensure AAA contrast (7.0:1) against the background
        diag_fg = ColorUtils.darken_to_contrast(diag_fg, diag_bg, 7.0)

        result.diag[level] = {
          fg = diag_fg,
          bg = diag_bg,
        }
      end
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
  local default_chroma_target = 5.8
  local default_neutral_target = 7.0
  local chroma_target = opts.chroma_target or default_chroma_target
  local neutral_target = opts.neutral_target or default_neutral_target
  local min_ratio = math.min(7.0, math.max(4.5, opts.min_ratio or chroma_target))
  chroma_target = math.max(chroma_target, min_ratio)
  if opts.force_aaa then
    chroma_target = 7.0
    neutral_target = 7.0
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
--- @param dark_theme table Dark mode theme colors {strong_primary, primary, light_primary, secondary, accent}
--- @param intensity_level number Intensity level (1-5)
--- @return table Light mode theme colors (vibrant)
function LightTheme.generate_theme(dark_theme, intensity_level)
  local result = {}

  -- Theme colors should maintain vibrancy like dark mode
  -- Intensity affects saturation and lightness
  local sat_factor = 0.9 + (intensity_level * 0.02) -- 0.92 to 1.0
  local light_base = 35 - (intensity_level * 2) -- 33% to 25%

  -- Strong primary (for large text only)
  if dark_theme.strong_primary then
    local h, s, _ = ColorUtils.rgb_to_hsl(dark_theme.strong_primary)
    result.strong_primary = ColorUtils.hsl_to_rgb(h, s * sat_factor, light_base + 5)
  end

  -- Primary color (base primary color)
  if dark_theme.primary then
    local h, s, _ = ColorUtils.rgb_to_hsl(dark_theme.primary)
    result.primary = ColorUtils.hsl_to_rgb(h, s * sat_factor, light_base)
  end

  -- Light primary (lighter variant)
  if dark_theme.light_primary then
    local h, s, _ = ColorUtils.rgb_to_hsl(dark_theme.light_primary)
    result.light_primary = ColorUtils.hsl_to_rgb(h, s * sat_factor, light_base - 5)
  end

  -- Secondary color
  if dark_theme.secondary then
    local h, s, _ = ColorUtils.rgb_to_hsl(dark_theme.secondary)
    result.secondary = ColorUtils.hsl_to_rgb(h, s * sat_factor, light_base + 2)
  end

  -- Accent color
  if dark_theme.accent then
    local h, s, _ = ColorUtils.rgb_to_hsl(dark_theme.accent)
    result.accent = ColorUtils.hsl_to_rgb(h, s * sat_factor, light_base + 2)
  end

  -- Copy palette if it exists
  if dark_theme.palette then result.palette = dark_theme.palette end

  return result
end

--- Apply contrast adjustment to all string values in a table
--- @param dark_table table Table with color values
--- @param light_bg_core string Light mode background core color
--- @param target_contrast? number Target contrast ratio (default 7.0)
--- @return table Table with adjusted colors
function LightTheme.apply_contrast(dark_table, light_bg_core, target_contrast)
  target_contrast = target_contrast or 7.0
  local result = {}

  for key, value in pairs(dark_table) do
    if type(value) == "string" then
      result[key] = ColorUtils.darken_to_contrast(value, light_bg_core, target_contrast)
    else
      result[key] = value -- Preserve non-string values
    end
  end

  return result
end

return LightTheme
