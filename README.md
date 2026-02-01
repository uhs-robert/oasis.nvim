<p align="center">
  <img
    src="./assets/logo.png"
    width="auto" height="128" alt="logo" />
</p>
<hr/>
<p align="center">
  <a href="https://github.com/uhs-robert/oasis.nvim/stargazers"><img src="https://img.shields.io/github/stars/uhs-robert/oasis.nvim?colorA=192330&colorB=khaki&style=for-the-badge&cacheSeconds=4300" alt="Stargazers"></a>
  <a href="https://github.com/uhs-robert/oasis.nvim/issues"><img src="https://img.shields.io/github/issues/uhs-robert/oasis.nvim?colorA=192330&colorB=skyblue&style=for-the-badge&cacheSeconds=4300" alt="Issues"></a>
  <a href="https://github.com/uhs-robert/oasis.nvim/contributors"><img src="https://img.shields.io/github/contributors/uhs-robert/oasis.nvim?colorA=192330&colorB=8FD1C7&style=for-the-badge&cacheSeconds=4300" alt="Contributors"></a>
  <a href="https://github.com/uhs-robert/oasis.nvim/network/members"><img src="https://img.shields.io/github/forks/uhs-robert/oasis.nvim?colorA=192330&colorB=C799FF&style=for-the-badge&cacheSeconds=4300" alt="Forks"></a>
</p>

## 🌅 Overview

Born from the classic [desert.vim](https://github.com/fugalh/desert.vim), transformed and modernized into something new entirely.

Oasis follows a warm/cool color split philosophy (**warm = action/flow**, **cool = structure/data**).

**All themes meet AAA WCAG compliance standards**. Light themes allow contrast ratio to be customized.

<p align="center">
  <img src="./assets/socials/Oasis Logo Social - 3 Fit.png"
  width="auto" height="auto" alt="preview" />
</p>

<details>
<summary>✨ What's New / 🚨 Breaking Changes</summary>
<br/>
<!-- whats-new:start -->

  <details>
    <summary>🚨 v4.1: Legacy Light Themes Removed</summary>
    <!-- v4.1:start -->
    <h3>🚨 BREAKING CHANGE: Legacy Light Themes Removed</h3>
    The standalone light themes <strong>Dawn, Dawnlight, Day, Dusk, and Dust</strong> have been removed in v4.1 (deprecated in v4.0).
    <ul>
      <li>Use the dual-mode system with <code>light_style</code> + <code>light_intensity</code> instead.</li>
      <li>Closest matches: <code>night</code> with <code>light_intensity = 1..5</code> (1=brightest, 5=darkest).</li>
    </ul>
    <h3>✨ New Features</h3>
    <ul>
      <li>Configurable plugin integration system.</li>
      <li>Expanded highlight coverage (additional Treesitter + LSP groups + mini ecosystem).</li>
      <li>Palette/highlight override system and LuaLS type definitions.</li>
      <li>New theme generators/formats: CSS, JSON, and Lua themes.</li>
      <li>New/expanded extras: bat themes, Warp, WezTerm/kitty updates, Yazi enhancements, tmux visual selection.</li>
    </ul>
    <!-- v4.1:end -->
  </details>

  <details>
    <summary>🚨 v4.0: Dual Style Themes / Deprecated Themes</summary>
    <!-- v4:start -->
    <h3>✨ Dual Style Themes</h3>
    Each style now has <strong>5 light theme variants</strong>.
    <ul>
      <li>Check out the <a href="#%EF%B8%8F-light-styles">new light theme screenshots</a>.</li>
      <li><a href="#%EF%B8%8F-configuration">Config options have been updated</a> with new <code>contrast</code> and <code>light_intensity</code> settings and <code>light/dark_style</code> updates.</li>
      <li><a href="#-usage">New API command :OasisIntensity under usage</a> to cycle intensity. Also available via lua for keymap.</li>
    </ul>
    <h3>🚨 BREAKING CHANGE: Deprecated Light Theme Migration</h3>
    The following standalone <strong>light themes have been deprecated</strong> in favor of the dual-mode system:
    <table>
      <tr>
        <td>Dawn</td>
        <td>Replaced with <code>light_intensity = 1</code></td>
      </tr>
      <tr>
        <td>Dawnlight</td>
        <td>Replaced with <code>light_intensity = 2</code></td>
      </tr>
      <tr>
        <td>Day</td>
        <td>Replaced with <code>light_intensity = 3</code></td>
      </tr>
      <tr>
        <td>Dusk</td>
        <td>Replaced with <code>light_intensity = 4</code></td>
      </tr>
      <tr>
        <td>Dust</td>
        <td>Replaced with <code>light_intensity = 5</code></td>
      </tr>
    </table>
    > The best match for the old light themes is <code>night</code> which also resolves accessibility issues.
    <br/>
    <strong>Deprecated themes will be completely removed on January 15th of 2026.</strong>
    <!-- v4:end -->
  </details>

  <details>
    <summary>🚨 v3.0: Themed Syntax</summary>
    <!-- v3:start -->
    <h3>✨ Dual style themes</h3>
    Each style now uses its signature color for statements and keywords.
    <br>
    Prefer the classic yellow syntax? <a href="#-usage">See how to opt-out under API Commands ↓</a>
    <!-- v3:end -->
  </details>
<!-- whats-new:end -->
</details>

## 🌙 Dark Styles

Click any card below to view the full preview and syntax sample. [↓ Or click here to view all full previews](#view-all-theme-styles)

### Dark Previews

<table>
  <tr>
    <td align="center"><a href="#night-dark"><img src="assets/screenshots/night-dark-dashboard.png" alt="Night (dark)" width="auto"></a><br><strong>Night</strong><br><em>Night Sky</em></td>
    <td align="center"><a href="#midnight-dark"><img src="assets/screenshots/midnight-dark-dashboard.png" alt="Midnight (dark)" width="auto"></a><br><strong>Midnight</strong><br><em>Off Black</em></td>
    <td align="center"><a href="#abyss-dark"><img src="assets/screenshots/abyss-dark-dashboard.png" alt="Abyss (dark)" width="auto"></a><br><strong>Abyss</strong><br><em>Black</em></td>
    <td align="center"><a href="#starlight-dark"><img src="assets/screenshots/starlight-dark-dashboard.png" alt="Starlight (dark)" width="auto"></a><br><strong>Starlight</strong><br><em>Black Vivid</em></td>
  </tr>
  <tr>
    <td align="center"><a href="#desert-dark"><img src="assets/screenshots/desert-dark-dashboard.png" alt="Desert (dark)" width="auto"></a><br><strong>Desert</strong><br><em>Grey</em></td>
    <td align="center"><a href="#sol-dark"><img src="assets/screenshots/sol-dark-dashboard.png" alt="Sol (dark)" width="auto"></a><br><strong>Sol</strong><br><em>Red</em></td>
    <td align="center"><a href="#canyon-dark"><img src="assets/screenshots/canyon-dark-dashboard.png" alt="Canyon (dark)" width="auto"></a><br><strong>Canyon</strong><br><em>Orange</em></td>
    <td align="center"><a href="#dune-dark"><img src="assets/screenshots/dune-dark-dashboard.png" alt="Dune (dark)" width="auto"></a><br><strong>Dune</strong><br><em>Yellow</em></td>
  </tr>
  <tr>
    <td align="center"><a href="#cactus-dark"><img src="assets/screenshots/cactus-dark-dashboard.png" alt="Cactus (dark)" width="auto"></a><br><strong>Cactus</strong><br><em>Green</em></td>
    <td align="center"><a href="#mirage-dark"><img src="assets/screenshots/mirage-dark-dashboard.png" alt="Mirage (dark)" width="auto"></a><br><strong>Mirage</strong><br><em>Teal</em></td>
    <td align="center"><a href="#lagoon-dark"><img src="assets/screenshots/lagoon-dark-dashboard.png" alt="Lagoon (dark)" width="auto"></a><br><strong>Lagoon (Default)</strong><br><em>Blue</em></td>
    <td align="center"><a href="#twilight-dark"><img src="assets/screenshots/twilight-dark-dashboard.png" alt="Twilight (dark)" width="auto"></a><br><strong>Twilight</strong><br><em>Purple</em></td>
  </tr>
  <tr>
    <td align="center"><a href="#rose-dark"><img src="assets/screenshots/rose-dark-dashboard.png" alt="Rose (dark)" width="auto"></a><br><strong>Rose</strong><br><em>Pink</em></td>
  </tr>
</table>

## ☀️ Light Styles

Light styles use a saturation intensity scale from 1-5: set from `config` or via `:OasisIntensity`.

### Light theme intensity scale (Lagoon example)

<table>
  <tr>
    <td align="center"><img src="assets/screenshots/lagoon-light-1-dashboard.png" alt="Lagoon light intensity 1" width="auto"><br><strong>1</strong></td>
    <td align="center"><img src="assets/screenshots/lagoon-light-2-dashboard.png" alt="Lagoon light intensity 2" width="auto"><br><strong>2</strong></td>
    <td align="center"><img src="assets/screenshots/lagoon-light-3-dashboard.png" alt="Lagoon light intensity 3" width="auto"><br><strong>3</strong></td>
    <td align="center"><img src="assets/screenshots/lagoon-light-4-dashboard.png" alt="Lagoon light intensity 4" width="auto"><br><strong>4</strong></td>
    <td align="center"><img src="assets/screenshots/lagoon-light-5-dashboard.png" alt="Lagoon light intensity 5" width="auto"><br><strong>5</strong></td>
  </tr>
</table>

<p align="center"><small>Use <code>:OasisIntensity</code> to step through intensity levels 1 → 5 in light mode.</small></p>

> [!NOTE]
> The **Night** style uses the darkest light backgrounds (lightness 78-84%) compared to the rest.
>
> This provides a middle ground between traditional light and dark modes.

### Light Previews

The examples below use the default intensity of level 3.

<table>
  <tr>
    <td align="center"><a href="#night-light"><img src="assets/screenshots/night-light-3-dashboard.png" alt="Night (light)" width="auto"></a><br><strong>Night</strong></td>
    <td align="center"><a href="#midnight-light"><img src="assets/screenshots/midnight-light-3-dashboard.png" alt="Midnight (light)" width="auto"></a><br><strong>Midnight</strong></td>
    <td align="center"><a href="#abyss-light"><img src="assets/screenshots/abyss-light-3-dashboard.png" alt="Abyss (light)" width="auto"></a><br><strong>Abyss</strong></td>
    <td align="center"><a href="#starlight-light"><img src="assets/screenshots/starlight-light-3-dashboard.png" alt="Starlight (light)" width="auto"></a><br><strong>Starlight</strong></td>
  </tr>
  <tr>
    <td align="center"><a href="#desert-light"><img src="assets/screenshots/desert-light-3-dashboard.png" alt="Desert (light)" width="auto"></a><br><strong>Desert</strong></td>
    <td align="center"><a href="#sol-light"><img src="assets/screenshots/sol-light-3-dashboard.png" alt="Sol (light)" width="auto"></a><br><strong>Sol</strong></td>
    <td align="center"><a href="#canyon-light"><img src="assets/screenshots/canyon-light-3-dashboard.png" alt="Canyon (light)" width="auto"></a><br><strong>Canyon</strong></td>
    <td align="center"><a href="#dune-light"><img src="assets/screenshots/dune-light-3-dashboard.png" alt="Dune (light)" width="auto"></a><br><strong>Dune</strong></td>
  </tr>
  <tr>
    <td align="center"><a href="#cactus-light"><img src="assets/screenshots/cactus-light-3-dashboard.png" alt="Cactus (light)" width="auto"></a><br><strong>Cactus</strong></td>
    <td align="center"><a href="#mirage-light"><img src="assets/screenshots/mirage-light-3-dashboard.png" alt="Mirage (light)" width="auto"></a><br><strong>Mirage</strong></td>
    <td align="center"><a href="#lagoon-light"><img src="assets/screenshots/lagoon-light-3-dashboard.png" alt="Lagoon (light)" width="auto"></a><br><strong>Lagoon</strong></td>
    <td align="center"><a href="#twilight-light"><img src="assets/screenshots/twilight-light-3-dashboard.png" alt="Twilight (light)" width="auto"></a><br><strong>Twilight</strong></td>
  </tr>
  <tr>
    <td align="center"><a href="#rose-light"><img src="assets/screenshots/rose-light-3-dashboard.png" alt="Rose (light)" width="auto"></a><br><strong>Rose</strong></td>
  </tr>
</table>

## ✨ Features

- **13 theme styles with dual modes**: Each theme offers both dark and light variants with 5 adjustable intensity levels.
- **Dark/Light Modes**: Automatic switching based on your system theme or `vim.o.background`.
- **Comprehensive highlighting** - LSP, Tree-sitter, and plugin support
- **Fast loading** - Direct highlight application for optimal performance based on the plugins in your config
- **Zero dependencies** - Works out of the box without external plugins
- **Modular architecture** - Easy to customize and extend

<details>
<summary>💪 Supported Plugins</summary>
<br>
<!-- plugins:start -->

| Plugin                                                                               |
| ------------------------------------------------------------------------------------ |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua)                                       |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                          |
| [mini.nvim](https://nvim-mini.org/mini.nvim/)                                        |
| [lazy.nvim](https://github.com/folke/lazy.nvim)                                      |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) |
| [snacks.nvim](https://github.com/folke/snacks.nvim)                                  |
| [which-key.nvim](https://github.com/folke/which-key.nvim)                            |

<!-- plugins:end -->
</details>

> [!NOTE]
> Oasis goes beyond Neovim with themes for **web browsers**, **terminals**, **development tools**, and **more**. Don't miss the Extras!

<details>
<summary>🍭 Extras</summary>
<br>

[All extra configs](extras/) for other applications.

To use the extras, refer to their respective documentation.

<!-- extras:start -->

| Tool        | Extra                                                  |
| ----------- | ------------------------------------------------------ |
| Alacritty   | [extras/alacritty](extras/alacritty)                   |
| Bat         | [extras/bat](extras/bat)                               |
| Btop        | [extras/btop](extras/btop)                             |
| Dark Reader | [extras/dark-reader](/extras/dark-reader)              |
| Firefox     | [extras/firefox](extras/firefox)                       |
| Foot        | [extras/foot](extras/foot)                             |
| FZF         | [extras/fzf](extras/fzf)                               |
| Gemini CLI  | [extras/gemini-cli](extras/gemini-cli)                 |
| Ghostty     | [extras/ghostty](extras/ghostty)                       |
| iTerm       | [extras/iterm](extras/iterm)                           |
| JSON-theme  | [extras/json-theme](/extras/json-theme)                |
| Kitty       | [extras/kitty](extras/kitty)                           |
| Konsole     | [extras/konsole](extras/konsole)                       |
| LazyGit     | [extras/lazygit](extras/lazygit)                       |
| Lua-theme   | [extras/lua-theme](/extras/lua-theme)                  |
| Slack       | [extras/slack](extras/slack)                           |
| Termux      | [extras/termux](extras/termux)                         |
| Thunderbird | [extras/thunderbird](extras/thunderbird)               |
| TMUX        | [tmux-oasis](https://github.com/uhs-robert/tmux-oasis) |
| Vimium      | [extras/vimium](extras/vimium)                         |
| Vimium C    | [extras/vimium-c](extras/vimium-c)                     |
| Warp        | [extras/warp](extras/warp)                             |
| WezTerm     | [extras/wezterm](extras/wezterm)                       |
| Yazi        | [extras/yazi](extras/yazi)                             |
| Zed         | [extras/zed](extras/zed)                               |

If you'd like an extra config added, raise a feature request and I'll put it together.

<!-- extras:end -->
</details>

## 📦 Installation

Install the theme with your preferred package manager, such as
[folke/lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "uhs-robert/oasis.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("oasis").setup()      -- (see Configuration below for all customization options)
    vim.cmd.colorscheme("oasis")  -- After setup, apply theme (or any style like "oasis-night")
  end
}
```

## 🚀 Usage

After calling `setup()`, use `:colorscheme` to apply or swap styles:

```lua
vim.cmd.colorscheme("oasis")         -- Use your config settings
vim.cmd.colorscheme("oasis-desert")  -- Or load any specific style
```

<details>
<summary>🖌️ All colorscheme commands</summary>
<br>
<!-- colorscheme-commands:start -->

```vim
" Uses your config settings
colorscheme oasis

" Or load a specific style - must be prefixed with `oasis-`
colorscheme oasis-night
colorscheme oasis-midnight
colorscheme oasis-abyss
colorscheme oasis-starlight
colorscheme oasis-desert
colorscheme oasis-sol
colorscheme oasis-canyon
colorscheme oasis-dune
colorscheme oasis-cactus
colorscheme oasis-mirage
colorscheme oasis-lagoon
colorscheme oasis-twilight
colorscheme oasis-rose
```

<!-- colorscheme-commands:end -->
</details>

<details>
<summary>🕵️‍♂️ Different Themes for Different Environments</summary>
<br>
<!-- user-themes:start -->

Don't just pick a favorite. Assign themes based on variables like `sudo` to easily differentiate between your NeoVim environments. For example:

- Use `sol` when **root** and/or doing a **sudoedit**
- Use `mirage` when **remote**
- And/or use **any theme** for **any combination above**, the only limit is your imagination

```lua
local uid = (vim.uv or vim.loop).getuid()
local is_root = uid == 0
local is_remote = vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_TTY ~= nil
local is_sudoedit = (not is_root) and vim.env.SUDOEDIT == "1" -- This requires your shell's config to export a flag like: SUDO_EDITOR="env SUDOEDIT=1 /usr/bin/nvim"

local function pick_colorscheme()
  local is_elevated = is_root or is_sudoedit
  if is_remote then
    return is_elevated and "oasis-abyss" or "oasis-mirage"
  else
    return is_elevated and "oasis-sol" or "oasis"
  end
end

return {
  {
    "uhs-robert/oasis.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("oasis").setup()
      vim.cmd.colorscheme(pick_colorscheme())
    end
  }
}
```

<!-- user-themes:end-->
</details>

<details>
  <summary>🌵 Some plugins may need extra configuration to work</summary>
  <!-- more-details:start -->

### LazyVim

To override the tokyonight default and start fresh in the oasis:

```lua
-- No need to apply vim.cmd.colorscheme(), just use this instead! Also works with the different themes for different environments example above.
  {
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "oasis",
  },
},
```

### Lualine

To include automatic Lualine theme integration:

```lua
require("lualine").setup {
  options = {
    theme = "oasis"  -- Automatically matches your current Oasis style
  }
}
```

### Tabby (Tab Bar)

To include tab bar theme integration:

```lua
require("tabby").setup({
  theme = "oasis" -- Automatically matches your current Oasis style
})
```

  <!-- more-details:end -->
</details>

<details>
<summary>⚡ API Commands</summary>
<!-- api:start -->

### Toggle Transparency

Toggle transparency on-the-fly without restarting:

```vim
:OasisTransparency
```

```lua
-- Or use the Lua API
require("oasis").toggle_transparency()

-- Example: bind to a keymap
vim.keymap.set("n", "<leader>tt", require("oasis").toggle_transparency, { desc = "Toggle transparency" })
```

### Toggle Themed Syntax

Toggle the `themed_syntax` option on-the-fly to switch between themed and classic syntax highlighting (dark themes only):

```vim
:OasisThemedSyntax
```

```lua
-- Or use the Lua API
require("oasis").toggle_themed_syntax()

-- Example: bind to a keymap
vim.keymap.set("n", "<leader>ts", require("oasis").toggle_themed_syntax, { desc = "Toggle themed syntax" })
```

> **⚠️ v3.0 Breaking Change**: Themed syntax is now enabled by default. To restore classic syntax highlighting, disable it:
>
> ```lua
> require("oasis").setup({
>   themed_syntax = false,  -- Use traditional yellow/khaki for all styles
> })
> ```

This option controls how statement/keyword colors are rendered:

- **Enabled** (default): Statements and keywords use the theme's primary color (e.g., blue in lagoon, teal in mirage, orange in canyon)
- **Disabled**: Statements and keywords use traditional yellow/khaki tones across all styles

### Cycle Light Intensity

Cycle the light background intensity (1–5) without reloading to test the waters:

```vim
:OasisIntensity
```

```lua
-- Or use the Lua API
require("oasis").cycle_intensity()

-- Example: bind to a keymap
vim.keymap.set("n", "<leader>uB", function()
  require("oasis").cycle_intensity() -- nil|true shows ui picker, false will cycle
end, { desc = "Select light mode intensity" })
```

- Applies to light palettes only (dark palettes ignore intensity).
- Default intensity is configurable via `light_intensity` in `setup()`.

### WCAG Accessibility Checker

Check WCAG 2.1 contrast compliance for palettes:

```vim
" Check all palettes
:OasisWCAG

" Check specific palette
:OasisWCAG oasis_lagoon
```

```lua
-- Lua API
local wcag = require("oasis.tools.wcag_checker")

-- Analyze all palettes
local all_results = wcag.analyze_all()
wcag.print_comparison_table(all_results)

-- Analyze specific palette
local results = wcag.analyze_palette("oasis_lagoon")
wcag.print_palette_results(results)

-- Calculate contrast ratio between two colors
local ratio = wcag.get_contrast_ratio("#e0def4", "#191724")  -- Returns: 12.44

-- Get compliance level
local level = wcag.get_compliance_level(ratio, false)  -- Returns: "AAA"
```

**WCAG Standards:**

- **AAA (7.0:1)**: Enhanced contrast for normal text
- **AA (4.5:1)**: Minimum contrast for normal text
- **AA Large (3.0:1)**: Minimum for large text (18pt+ or 14pt+ bold)

Reference: [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html)

> [!NOTE]
> Light themes can appear muddy and make syntax hard to distinguish when everything is AAA.
>
> If you need AAA compliance then set `force_aaa = true` otherwise tune the `min_ratio` to meet your needs.

<!-- api:end -->
</details>

## ⚙️ Configuration

Oasis offers _many_ different styles to choose from. Have fun customizing with `setup()`!

<details>
  <summary>🍦 Default Options</summary>
  <br>
<!-- config:start -->

```lua
-- Oasis.nvim
-- Styles: "night", "midnight", "abyss", "starlight", "desert", "sol", "canyon", "dune", "cactus", "mirage", "lagoon", "twilight", "rose"
require("oasis").setup({
  style = "lagoon",                     -- Primary style, the default used when colorscheme is set to "oasis"
  dark_style = nil,                     -- Applies to primary style only: Overrides dark mode with another theme (e.g., "abyss")
  light_style = nil,                    -- Applies to primary style only: Overrides light mode with another theme (e.g., "dune")
  light_intensity = 3,                  -- Light background intensity (1-5): 1=subtle, 5=saturated
  use_legacy_comments = false,          -- For "desert" style only, uses the loud skyblue comment color from desert.vim for a more retro experience
  themed_syntax = true,                 -- Uses the theme's primary color for statements/keywords. Set to false for the classic yellow syntax from desert.vim for a more retro experience

  -- Text styling - toggle individual styles
  styles = {
    bold = true,                        -- Enable bold text (keywords, functions, etc.)
    italic = true,                      -- Enable italics (comments, certain keywords)
    underline = true,                   -- Enable underlined text (matching words)
    undercurl = true,                   -- Enable undercurl for diagnostics/spelling
    strikethrough = true,               -- Enable strikethrough text (deprecations)
  },

  -- Display options
  transparent = false,                  -- Set to true for transparent backgrounds (bye-bye theme backgrounds)
  terminal_colors = true,               -- Apply Oasis colors to Neovim's built-in terminal

  -- Contrast controls (WCAG: AA = 4.5, AAA = 7.0)
  contrast = {
    -- Note: Light themes obey the targets below. All dark themes target 7.0 by default with only a couple of exceptions that dip to 6.5.
    min_ratio = 5.8,                    -- Clamp 4.5–7.0; target contrast for syntax/terminal colors. Increase for more contrast, decrease for more pop.
    force_aaa = false,                  -- When true, forces AAA (7.0) wherever possible; as a result some colors will appear muddy (bye bye non-primary colors).
  },

  palette_overrides = {},               -- Override colors in specific palettes
  highlight_overrides = {},             -- Override specific highlight groups

  -- Plugin integrations
  integrations = {
    default_enabled = true,             -- Default behavior: true = enable all, false = disable all
    -- For each plugin: nil = use default_enabled, true = enable, false = disable
    plugins = {
      fzf_lua = nil,
      gitsigns = nil,
      lazy = nil,
      mini = nil,
      render_markdown = nil,
      snacks = nil,
      which_key = nil,
    },
  },
})
```

<!-- config:end -->
</details>

## 🪓 Overriding Colors & Highlight Groups

Thirsty for total control? You can override whatever you like.

> _Whoever drinketh of the water that I shall give him, shall never thirst..._

<details>
  <summary>🎨 Changing Palette Colors for Each Style</summary>
  <br>
<!-- palette-overrides:start -->

**`palette_overrides`** - Customize colors in palettes. Supports two methods for updating:

### Palette Overrides: Static Table

```lua
require("oasis").setup({
  palette_overrides = {
    -- Global light overrides (applies to ALL themes)
    light = {
      bg = { core = "#FFF8F0" }
    },

    -- Global light intensity 3 (applies to ALL themes)
    light_3 = {
      bg = { core = "#FFEFE0" }
    },

    -- Per-theme overrides (use shorthand names: desert, lagoon, etc.)
    lagoon = {
      syntax = { string = "#FFA0A0", punctuation = "#F89D82", comment = "#665D55" },
      ui = { border = "#FFA247" },

      -- Light mode for this theme
      light = {
        syntax = { comment = "#404040" }
      },

      -- Specific intensity for this theme
      light_5 = {
        bg = { core = "#FFE8D0" }
      }
    }
  }
})
```

### Palette Overrides: Function

```lua
require("oasis").setup({
  palette_overrides = function(c, colors)
    ---@type OasisPaletteOverrides
    return {
      -- c = current palette
      -- colors = base palette from palette.lua (Tailwind-style colors and access to all palettes)

      -- Global light overrides (applies to ALL themes)
      light = {
        syntax = {
          comment = c.fg.dim,          -- Reference current palette
          string = colors.rose[500]    -- Reference global colors
        }
      },

      -- Global light intensity 3 (applies to ALL themes)
      light_3 = {
        bg = { core = "#FFEFE0" }
      },

      -- Global palette overrides
      syntax = {
        comment = c.fg.dim,
        statement = colors.khaki[500],
      },

      -- Per-theme overrides (use shorthand names: desert, lagoon, etc.)
      lagoon = {
        syntax = {
          string = colors.rose[500],
          punctuation = colors.peach[500],
          comment = c.fg.dim
        },

        -- Light mode for this theme
        light = {
          syntax = { string = colors.red[800] }
        },

        -- Specific intensity for this theme
        light = {
          syntax = { string = colors.red[800] }
        }
      }
    }
  end
})
```

**Precedence:** Global → Global light → Global light_N → Theme → Theme light → Theme light_N

> See [Color Palettes](lua/oasis/color_palettes) for each theme's palette structure and [Palette](./lua/oasis/palette.lua) for all base colors.

<!-- palette-overrides:end-->
</details>

<details>
  <summary>💅 Changing Colors for Highlight Groups</summary>
  <br>
<!-- highlight-overrides:start -->

**`highlight_overrides`** - Override or add highlight groups. Supports two methods for updating:

### Highlight Overrides: Static Table

```lua
require("oasis").setup({
  highlight_overrides = {
    -- Global (applies to all themes, all modes)
    Comment = { fg = "#808080", italic = true },
    Function = { fg = "#E06C75", bold = true },
    Identifier = "Function",  -- Link to another group

    -- Global light mode (all themes, all intensities)
    light = {
      Comment = { fg = "#606060" },
      Normal = { bg = "#000000" },
    },

    -- Global light intensity 3 (all themes)
    light_3 = {
      Normal = { bg = "#FFF8F0" }
    },

    -- Per-theme overrides (use shorthand names: desert, lagoon, etc.)
    desert = {
      String = { fg = "#FFA0A0" },

      -- Desert light mode
      light = {
        String = { fg = "#6BA5C8" }
      },

      -- Desert light intensity 3
      light_3 = {
        Normal = { bg = "#FFF0E0" }
      }
    }
  }
})
```

### Highlight Overrides: Function

```lua
require("oasis").setup({
  highlight_overrides = function(c, colors)
    ---@type OasisHighlightOverrides
    return {
      -- c = current palette
      -- colors = base palette from palette.lua (Tailwind-style colors)

      Comment = { fg = c.fg.dim, italic = true },
      String = { fg = colors.red[500] },
      Function = { fg = c.theme.primary },

      -- Global light overrides
      light = {
        Comment = { fg = c.fg.muted }
      },

      -- Per-theme with palette access
      desert = {
        String = { fg = colors.sky[500] },
        light = {
          String = { fg = colors.sky[700] }
        }
      }
    }
  end
})
```

**Precedence:** Global → Global light → Global light_N → Theme → Theme light → Theme light_N

> See [Theme Generator](lua/oasis/theme_generator.lua) for all highlight groups.
>
> See [Color Palettes](lua/oasis/color_palettes) for each theme's palette structure and [Palette](./lua/oasis/palette.lua) for all base colors.

<!-- highlight-overrides:end -->
</details>

# 👀 View All Theme Styles

<a id="view-all-theme-styles"></a>

<details open>
  <summary><b>All styles (click to collapse)</b></summary>
  <br/>
  <!-- all-styles:start -->
  <a id="dark-previews"></a>
  <details open>
    <summary><b>🌕️ Dark Previews</b></summary>
    <!-- dark-styles:start -->
    <a id="night-dark"></a>
    <h3>Night (Dark · Night Sky)</h3>
    <img src="./assets/screenshots/night-dark-dashboard.png" alt="Night dark mode dashboard"></img>
    <img src="./assets/screenshots/night-dark-code.png" alt="Night dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="midnight-dark"></a>
    <h3>Midnight (Dark · Off Black)</h3>
    <img src="./assets/screenshots/midnight-dark-dashboard.png" alt="Midnight dark mode dashboard"></img>
    <img src="./assets/screenshots/midnight-dark-code.png" alt="Midnight dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="abyss-dark"></a>
    <h3>Abyss (Dark · Black)</h3>
    <img src="./assets/screenshots/abyss-dark-dashboard.png" alt="Abyss dark mode dashboard"></img>
    <img src="./assets/screenshots/abyss-dark-code.png" alt="Abyss dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="starlight-dark"></a>
    <h3>Starlight (Dark · Black Vivid)</h3>
    <img src="./assets/screenshots/starlight-dark-dashboard.png" alt="Starlight dark mode dashboard"></img>
    <img src="./assets/screenshots/starlight-dark-code.png" alt="Starlight dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="desert-dark"></a>
    <h3>Desert (Dark · Grey)</h3>
    <img src="./assets/screenshots/desert-dark-dashboard.png" alt="Desert dark mode dashboard"></img>
    <img src="./assets/screenshots/desert-dark-code.png" alt="Desert dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="sol-dark"></a>
    <h3>Sol (Dark · Red)</h3>
    <img src="./assets/screenshots/sol-dark-dashboard.png" alt="Sol dark mode dashboard"></img>
    <img src="./assets/screenshots/sol-dark-code.png" alt="Sol dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="canyon-dark"></a>
    <h3>Canyon (Dark · Orange)</h3>
    <img src="./assets/screenshots/canyon-dark-dashboard.png" alt="Canyon dark mode dashboard"></img>
    <img src="./assets/screenshots/canyon-dark-code.png" alt="Canyon dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="dune-dark"></a>
    <h3>Dune (Dark · Yellow)</h3>
    <img src="./assets/screenshots/dune-dark-dashboard.png" alt="Dune dark mode dashboard"></img>
    <img src="./assets/screenshots/dune-dark-code.png" alt="Dune dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="cactus-dark"></a>
    <h3>Cactus (Dark · Green)</h3>
    <img src="./assets/screenshots/cactus-dark-dashboard.png" alt="Cactus dark mode dashboard"></img>
    <img src="./assets/screenshots/cactus-dark-code.png" alt="Cactus dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="mirage-dark"></a>
    <h3>Mirage (Dark · Teal)</h3>
    <img src="./assets/screenshots/mirage-dark-dashboard.png" alt="Mirage dark mode dashboard"></img>
    <img src="./assets/screenshots/mirage-dark-code.png" alt="Mirage dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="lagoon-dark"></a>
    <h3>Lagoon (Dark · Default)</h3>
    <img src="./assets/screenshots/lagoon-dark-dashboard.png" alt="Lagoon dark mode dashboard"></img>
    <img src="./assets/screenshots/lagoon-dark-code.png" alt="Lagoon dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="twilight-dark"></a>
    <h3>Twilight (Dark · Purple)</h3>
    <img src="./assets/screenshots/twilight-dark-dashboard.png" alt="Twilight dark mode dashboard"></img>
    <img src="./assets/screenshots/twilight-dark-code.png" alt="Twilight dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <a id="rose-dark"></a>
    <h3>Rose (Dark · Pink)</h3>
    <img src="./assets/screenshots/rose-dark-dashboard.png" alt="Rose dark mode dashboard"></img>
    <img src="./assets/screenshots/rose-dark-code.png" alt="Rose dark mode code sample"></img>
    <p align="center">
      <a href="#dark-previews">↑ Back to Dark Styles</a>
    </p>
    <!-- dark-styles:end -->
</details>
  <details open>
  <summary><b>🌞 Light Previews</b></summary>
  <!-- light-styles:start -->
  <a id="light-previews"></a>
    <a id="night-light"></a>
    <h3>Night (Light)</h3>
    <img src="./assets/screenshots/night-light-3-dashboard.png" alt="Night light mode dashboard"></img>
    <img src="./assets/screenshots/night-light-3-code.png" alt="Night light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="midnight-light"></a>
    <h3>Midnight (Light)</h3>
    <img src="./assets/screenshots/midnight-light-3-dashboard.png" alt="Midnight light mode dashboard"></img>
    <img src="./assets/screenshots/midnight-light-3-code.png" alt="Midnight light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="abyss-light"></a>
    <h3>Abyss (Light)</h3>
    <img src="./assets/screenshots/abyss-light-3-dashboard.png" alt="Abyss light mode dashboard"></img>
    <img src="./assets/screenshots/abyss-light-3-code.png" alt="Abyss light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="starlight-light"></a>
    <h3>Starlight (Light)</h3>
    <img src="./assets/screenshots/starlight-light-3-dashboard.png" alt="Starlight light mode dashboard"></img>
    <img src="./assets/screenshots/starlight-light-3-code.png" alt="Starlight light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="desert-light"></a>
    <h3>Desert (Light)</h3>
    <img src="./assets/screenshots/desert-light-3-dashboard.png" alt="Desert light mode dashboard"></img>
    <img src="./assets/screenshots/desert-light-3-code.png" alt="Desert light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="sol-light"></a>
    <h3>Sol (Light)</h3>
    <img src="./assets/screenshots/sol-light-3-dashboard.png" alt="Sol light mode dashboard"></img>
    <img src="./assets/screenshots/sol-light-3-code.png" alt="Sol light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="canyon-light"></a>
    <h3>Canyon (Light)</h3>
    <img src="./assets/screenshots/canyon-light-3-dashboard.png" alt="Canyon light mode dashboard"></img>
    <img src="./assets/screenshots/canyon-light-3-code.png" alt="Canyon light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="dune-light"></a>
    <h3>Dune (Light)</h3>
    <img src="./assets/screenshots/dune-light-3-dashboard.png" alt="Dune light mode dashboard"></img>
    <img src="./assets/screenshots/dune-light-3-code.png" alt="Dune light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="cactus-light"></a>
    <h3>Cactus (Light)</h3>
    <img src="./assets/screenshots/cactus-light-3-dashboard.png" alt="Cactus light mode dashboard"></img>
    <img src="./assets/screenshots/cactus-light-3-code.png" alt="Cactus light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="mirage-light"></a>
    <h3>Mirage (Light)</h3>
    <img src="./assets/screenshots/mirage-light-3-dashboard.png" alt="Mirage light mode dashboard"></img>
    <img src="./assets/screenshots/mirage-light-3-code.png" alt="Mirage light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="lagoon-light"></a>
    <h3>Lagoon (Light)</h3>
    <img src="./assets/screenshots/lagoon-light-3-dashboard.png" alt="Lagoon light mode dashboard"></img>
    <img src="./assets/screenshots/lagoon-light-3-code.png" alt="Lagoon light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="twilight-light"></a>
    <h3>Twilight (Light)</h3>
    <img src="./assets/screenshots/twilight-light-3-dashboard.png" alt="Twilight light mode dashboard"></img>
    <img src="./assets/screenshots/twilight-light-3-code.png" alt="Twilight light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
    <a id="rose-light"></a>
    <h3>Rose (Light)</h3>
    <img src="./assets/screenshots/rose-light-3-dashboard.png" alt="Rose light mode dashboard"></img>
    <img src="./assets/screenshots/rose-light-3-code.png" alt="Rose light mode code sample"></img>
    <p align="center">
      <a href="#light-previews">↑ Back to Light Styles</a>
    </p>
  <!-- light-styles:end -->
  </details>
  <!-- all-styles:end -->
</details>
