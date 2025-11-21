# Scripts

Development utilities for maintaining the Oasis colorscheme. Subfolders contain specific scripts for maintenance. This one contains...

## analyze_color_usage.lua

Analyzes which colors from `lua/oasis/palette.lua` are actively used across all palette variants.

**Usage:**

```bash
lua scripts/analyze_color_usage.lua
```

**Output:**

- Color usage statistics grouped by color family (sorted alphabetically)
- Potentially unused colors from palette.lua
- Summary totals (defined vs. used colors)

Useful for identifying:

- Which color variants are most frequently used
- Unused colors that can be removed or repurposed
- Color coverage across all 18 palette variants
