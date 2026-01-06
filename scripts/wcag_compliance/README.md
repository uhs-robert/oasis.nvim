# WCAG AAA Compliance Guide

This guide documents the process for achieving AAA WCAG compliance in Oasis theme palettes.

## Development Tools

**Required:** Neovim with Oasis installed (uses `lua/oasis/tools/wcag_checker.lua`)
**Optional:** Lua for the color calculator script (`scripts/wcag_compliance/wcag_calculator.lua`)

This directory contains development tools for creating accessible color palettes. End users don't need these tools - they're only for theme maintainers and contributors.

## Compliance Target

**Goal**: All elements should be AAA compliant globally except for 4.

- **AAA Standard**: 7.0:1 contrast for normal text, 4.5:1 for large text (18pt+/14pt+ bold)
- **AA Standard**: 4.5:1 contrast for normal text, 3.0:1 for large text
- **Light Theme Specific**: 4 elements at AA level (not AAA) by design:
  1. Muted Text (`fg.muted`) - **AA required** (≥4.5:1)
  2. Dim Text (`fg.dim`) - **AA required** (≥4.5:1)
  3. Comments (`fg.comment`) - **AA required** (≥4.5:1)
  4. Nontext (`ui.nontext`) - **AA required** (≥4.5:1)

**Expected Result**: 35/39 AAA (90%), 4/39 AA (10%), 0 Failed

## Process Overview

### Phase 1: Initial Assessment

1. Run WCAG checker on the palette:

   ```lua
   :lua require('oasis.tools.wcag_checker').check_palette('oasis_<variant>')
   ```

2. Identify all colors failing AAA (contrast < 7.0:1 for normal, < 4.5:1 for large)
3. Group failures by priority:
   - **Critical** (< 3.0:1): Immediate fix needed
   - **High** (3.0-4.0:1): High priority
   - **Medium** (4.0-4.49:1): Minor adjustments

### Phase 2: Calculate AAA-Compliant Colors

For each failing color, calculate the darkened value needed to achieve 7.0:1 contrast while maintaining hue/saturation.

### Using the Lua Color Calculator

The Lua script can calculate AAA-compliant colors while preserving hue and saturation:

**Single color calculation:**

```bash
lua scripts/wcag_compliance/wcag_calculator.lua '#EFE5B6' '#D26600' 7.0
# Output:
# Current contrast: 3.86:1
# ✗ Below target of 7.00:1

# Recommended color: #B35100
# New contrast: 7.01:1

# Change: #D26600 → #B35100
```

**Theme-based calculation (actual colors):**

```bash
lua scripts/wcag_compliance/wcag_calculator.lua actual dawn
# Calculates actual theme colors for 'dawn' and suggests compliant versions.
```

**Preset-based calculation (template reference colors):**

```bash
lua scripts/wcag_compliance/wcag_calculator.lua presets dawn
# Calculates reference 'BASE_COLORS' against the 'dawn' theme's background.
```

**Check actual and presets simultaneously:**

```bash
lua scripts/wcag_compliance/wcag_calculator.lua both dawn
# Calculates both actual and preset colors for 'dawn' theme simultaneously.
```

**Check all themes:**

```bash
lua scripts/wcag_compliance/wcag_calculator.lua actual all
lua scripts/wcag_compliance/wcag_calculator.lua presets all
```

The script can analyze actual theme colors or a set of preset reference colors against the theme's background. It shows before/after contrast ratios and recommended adjusted colors.

The logic has been tuned a bit with some AAA exceptions for artistic flair (i.e., comments, inlay hints, line numbers) but a human-eye is always needed to make it look _just right_ for each color theme.

#### Tips

- You can update the presets, `BASE_COLORS`, in [WCAG Color Calculator](../../lua/oasis/tools/wcag_color_calculator.lua) as well as set custom `LIGHT_TARGETS` and `DARK_TARGETS` for _any_ palette color.
  - The targets are in reference to light/dark themes. This lets you make choices like: "I want comments to have a contrast ratio of 3.5 for dark themes and 4.5 for light".
- Play around with the `single color calculation` and adjust the target till you get it _just right_.
- If none of this works, it's time to get really creative and make something new. Take a deep breath. Remember the core philosophy of the theme. Now, [use an external color picker tool with WCAG AA and AAA constrast checker like this](https://webaim.org/resources/contrastchecker/) and play with the colors till you find the one that is _just right_!

### Phase 3: Apply Updates

Update the palette file `lua/oasis/color_palettes/oasis_<variant>.lua` with calculated values.

### Phase 4: Verification

1. **Apply the theme**:

   ```lua
   :lua require('oasis').apply('oasis_<variant>')
   ```

2. **Run WCAG checker**:

   ```lua
   :lua require('oasis.tools.wcag_checker').check_palette('oasis_<variant>')
   ```

3. **Verify results**:
   - Should show: `AAA Target: 35/35 ✓ (Acceptable Fails: 4)`
   - Should show: `Summary: 35/39 AAA (90%), 4/39 AA (10%), 0 Failed`
   - The 4 AA elements should be: Muted Text (≥4.5:1), Dim Text (≥4.5:1), Comments (≥4.5:1), Nontext (≥4.5:1)
   - **No failures allowed** - all elements must meet at least AA standards

4. **Visual testing**:
   - Open code files to verify syntax highlighting
   - Test search with `/` to verify search highlights
   - Check diagnostics if LSP is available
   - Just because it passes doesn't mean the colors pop and look good, remember the core philosophy and create distinct colors!

5. **Compare with other themes**:

   ```lua
   :lua require('oasis.tools.wcag_checker').check_all()
   ```

## Tools and Resources

### Oasis Tools

- **WCAG Checker (Lua)**: `lua/oasis/tools/wcag_checker.lua` - Runtime palette compliance checking within Neovim
- **Color Calculator (Lua)**: `scripts/wcag_compliance/wcag_calculator.lua` - Development tool for calculating AAA-compliant colors

### External Resources

- **WCAG Standard**: <https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html>
- **Contrast Calculator**: <https://contrast-ratio.com/>
- **Color Space Converter**: <https://www.nixsensor.com/free-color-converter/>
