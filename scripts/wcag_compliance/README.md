# WCAG AAA Compliance Guide

This guide documents the process for achieving AAA WCAG compliance in Oasis theme palettes.

## Development Tools

**Required:** Neovim with Oasis installed (uses `lua/oasis/wcag_checker.lua`)
**Optional:** Ruby 2.7+ (no gems needed) for the color calculator script

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
   :lua require('oasis.wcag_checker').check_palette('oasis_<variant>')
   ```

2. Identify all colors failing AAA (contrast < 7.0:1 for normal, < 4.5:1 for large)
3. Group failures by priority:
   - **Critical** (< 3.0:1): Immediate fix needed
   - **High** (3.0-4.0:1): High priority
   - **Medium** (4.0-4.49:1): Minor adjustments

### Phase 2: Calculate AAA-Compliant Colors

For each failing color, calculate the darkened value needed to achieve 7.0:1 contrast while maintaining hue/saturation.

### Using the Ruby Color Calculator

The Ruby script can calculate AAA-compliant colors while preserving hue and saturation:

**Single color calculation:**

```bash
ruby scripts/wcag_color_calculator.rb '#EFE5B6' '#D26600' 7.05
# Output: #D26600 → #763900 (7.05:1)
```

**Batch process entire theme:**

```bash
ruby scripts/wcag_color_calculator.rb batch dawn
# Calculates all typical syntax/UI colors for dawn theme
```

**Batch process other light themes:**

```bash
ruby scripts/wcag_color_calculator.rb batch dawnlight
ruby scripts/wcag_color_calculator.rb batch day
ruby scripts/wcag_color_calculator.rb batch dusk
ruby scripts/wcag_color_calculator.rb batch dust
```

The batch mode processes all typical colors and shows before/after contrast ratios.

### Phase 3: Apply Updates

Update the palette file `lua/oasis/color_palettes/oasis_<variant>.lua` with calculated values.

**Template structure**:

```lua
-- General colors
theme = {
    primary = "#XXXXXX", -- 7.XX:1 (was #YYYYYY)
    -- ...
},

-- Syntax
syntax = {
    -- Cold: (Data)
    parameter = "#XXXXXX", -- 7.XX:1
    identifier = "#XXXXXX", -- 7.XX:1
    type = "#XXXXXX", -- 7.XX:1
    builtinVar = "#XXXXXX", -- 7.XX:1
    string = "#XXXXXX", -- 7.XX:1
    regex = "#XXXXXX", -- 7.XX:1
    builtinConst = "#XXXXXX", -- 7.XX:1
    constant = "#XXXXXX", -- 7.XX:1

    -- Warm: (Control / Flow)
    func = "#XXXXXX", -- 7.XX:1
    builtinFunc = "#XXXXXX", -- 7.XX:1
    statement = "#XXXXXX", -- 7.XX:1
    exception = "#XXXXXX", -- 7.XX:1
    keyword = "#XXXXXX", -- 7.XX:1
    special = "#XXXXXX", -- 7.XX:1
    operator = "#XXXXXX", -- 7.XX:1
    punctuation = "#XXXXXX", -- 7.XX:1
    preproc = "#XXXXXX", -- 7.XX:1

    -- Neutral
    bracket = "#XXXXXX", -- 7.XX:1
    comment = "#XXXXXX", -- 4.51:1 AA (or 7.XX:1 AAA)
},

-- Diff
diff = {
    change = "#XXXXXX", -- 7.XX:1
    delete = "#XXXXXX", -- 7.XX:1
},

-- UI
ui = {
    match = "#XXXXXX", -- 7.XX:1
    search = { bg = "#FFD87C", fg = "#XXXXXX" }, -- 9.XX:1
    curSearch = { bg = p.orange.deepsun, fg = "#XXXXXX" }, -- 7.XX:1
    dir = "#XXXXXX", -- 7.XX:1

    diag = {
        error = { fg = "#XXXXXX", bg = ui.bg.core }, -- 7.XX:1
        warn = { fg = "#XXXXXX", bg = ui.bg.core },  -- 7.XX:1
        info = { fg = "#XXXXXX", bg = ui.bg.core },  -- 7.XX:1
        hint = { fg = "#XXXXXX", bg = ui.bg.core },  -- 7.XX:1
    },
},
```

### Phase 4: Verification

1. **Apply the theme**:

   ```lua
   :lua require('oasis').apply('oasis_<variant>')
   ```

2. **Run WCAG checker**:

   ```lua
   :lua require('oasis.wcag_checker').check_palette('oasis_<variant>')
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
   :lua require('oasis.wcag_checker').check_all()
   ```

## Tools and Resources

### Oasis Tools
- **WCAG Checker (Lua)**: `lua/oasis/wcag_checker.lua` - Runtime palette compliance checking within Neovim
- **Color Calculator (Ruby)**: `scripts/wcag_color_calculator.rb` - Development tool for calculating AAA-compliant colors

### External Resources
- **WCAG Standard**: <https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html>
- **Contrast Calculator**: <https://contrast-ratio.com/>
- **Color Space Converter**: <https://www.nixsensor.com/free-color-converter/>
