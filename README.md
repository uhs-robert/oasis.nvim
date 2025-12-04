<p align="center">
  <img
    src="https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/1f3dd.svg"
    width="128" height="128" alt="Oasis emoji" />
</p>
<h1 align="center">Oasis.nvim</h1>

<p align="center">
  <a href="https://github.com/uhs-robert/oasis.nvim/stargazers"><img src="https://img.shields.io/github/stars/uhs-robert/oasis.nvim?colorA=192330&colorB=skyblue&style=for-the-badge&cacheSeconds=4300"></a>
  <a href="https://github.com/uhs-robert/oasis.nvim/issues"><img src="https://img.shields.io/github/issues/uhs-robert/oasis.nvim?colorA=192330&colorB=khaki&style=for-the-badge&cacheSeconds=4300"></a>
  <a href="https://github.com/uhs-robert/oasis.nvim/contributors"><img src="https://img.shields.io/github/contributors/uhs-robert/oasis.nvim?colorA=192330&colorB=8FD1C7&style=for-the-badge&cacheSeconds=4300"></a>
  <a href="https://github.com/uhs-robert/oasis.nvim/network/members"><img src="https://img.shields.io/github/forks/uhs-robert/oasis.nvim?colorA=192330&colorB=C799FF&style=for-the-badge&cacheSeconds=4300"></a>
</p>

<p align="center">
A collection of <strong>13</strong> desert-inspired Neovim colorschemes; warm, readable, and highly configurable.
</p>

## 🌅 Overview

Born from the classic [desert.vim](https://github.com/fugalh/desert.vim), transformed and modernized into something new entirely.

Oasis follows a warm/cool color split philosophy (**warm = action/flow**, **cool = structure/data**).

**All themes meet AAA WCAG compliance standards**. Light themes allow contrast ratio to be customized.

<details>
<summary>✨ What's New / 🚨 Breaking Changes</summary>
<br/>
<!-- whats-new:start -->

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
    <strong>Deprecated themes will be completely removed around January 1st of 2026.</strong>
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
    <td align="center"><a href="#lagoon-dark"><img src="assets/screenshots/lagoon-dark-dashboard.png" alt="Lagoon (dark)" width="auto"></a><br><strong>Lagoon (Default Dark)</strong><br><em>Blue</em></td>
    <td align="center"><a href="#twilight-dark"><img src="assets/screenshots/twilight-dark-dashboard.png" alt="Twilight (dark)" width="auto"></a><br><strong>Twilight</strong><br><em>Purple</em></td>
  </tr>
  <tr>
    <td align="center"><a href="#rose-dark"><img src="assets/screenshots/rose-dark-dashboard.png" alt="Rose (dark)" width="auto"></a><br><strong>Rose</strong><br><em>Pink</em></td>
  </tr>
</table>

## ☀️ Light Styles

All light styles use a saturation intensity scale from 1-5: set from `config` or via `:OasisIntensity`.

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

| Plugin                                                      |
| ----------------------------------------------------------- |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua)              |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) |
| [snacks.nvim](https://github.com/folke/snacks.nvim)         |
| [which-key.nvim](https://github.com/folke/which-key.nvim)   |

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
| Btop        | [extras/btop](extras/btop)                             |
| Dark Reader | [extras/dark-reader](/extras/dark-reader)              |
| Firefox     | [extras/firefox](extras/firefox)                       |
| Foot        | [extras/foot](extras/foot)                             |
| FZF         | [extras/fzf](extras/fzf)                               |
| Gemini CLI  | [extras/gemini-cli](extras/gemini-cli)                 |
| Ghostty     | [extras/ghostty](extras/ghostty)                       |
| iTerm       | [extras/iterm](extras/iterm)                           |
| Kitty       | [extras/kitty](extras/kitty)                           |
| Konsole     | [extras/konsole](extras/konsole)                       |
| LazyGit     | [extras/lazygit](extras/lazygit)                       |
| Slack       | [extras/slack](extras/slack)                           |
| Termux      | [extras/termux](extras/termux)                         |
| Thunderbird | [extras/thunderbird](extras/thunderbird)               |
| TMUX        | [tmux-oasis](https://github.com/uhs-robert/tmux-oasis) |
| Vimium C    | [extras/vimium-c](extras/vimium-c)                     |
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

With so many options to choose from why settle for just one? Use the right theme for the right occasion to differentiate between your environments. Here are some examples:

- A custom theme for when **root** and/or **sudoedit**
- A custom theme for when **remote**
- A custom theme for **any combination**

Use this example config to have a custom theme for each situation above:

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
    "uhs-robert/oasis.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("oasis").setup()
      vim.cmd.colorscheme(pick_colorscheme())
    end
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
-- No need to apply vim.cmd.colorscheme(), just use this instead.
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
require('oasis').toggle_transparency()

-- Example: bind to a keymap
vim.keymap.set('n', '<leader>tt', require('oasis').toggle_transparency, { desc = 'Toggle transparency' })
```

### Toggle Themed Syntax

Toggle the `themed_syntax` option on-the-fly to switch between themed and classic syntax highlighting (dark themes only):

```vim
:OasisThemedSyntax
```

```lua
-- Or use the Lua API
require('oasis').toggle_themed_syntax()

-- Example: bind to a keymap
vim.keymap.set('n', '<leader>ts', require('oasis').toggle_themed_syntax, { desc = 'Toggle themed syntax' })
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
  style = "lagoon",                     -- Primary style, default used when colorscheme is set to "oasis"
  dark_style = "auto",                  -- Applies to your primary style only: "auto" uses `style`. Or override with another dark theme (e.g., "abyss")
  light_style = "auto",                 -- Applies to your primary style only: "auto" uses `style`. Or override with another light theme (e.g., "dune")
  light_intensity = 3,                  -- Light background intensity (1-5): 1=subtle, 5=saturated
  use_legacy_comments = false,          -- Uses the legacy comment color from desert.vim for the "desert" style only (a bright sky blue)
  themed_syntax = true,                 -- Use theme primary color for statements/keywords - set to false for classic yellow syntax

  -- Text styling - disable individual styles if you like
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
    -- Note: Light themes obey the targets below. All dark themes target 7.0 by default with very few exceptions.
    min_ratio = 5.8,                    -- Clamp 4.5–7.0; target contrast for syntax/terminal colors. Increase for more contrast, decrease for more pop.
    force_aaa = false,                  -- When true, forces AAA (7.0) wherever possible; as a result some colors may appear muddy.
  },

  palette_overrides = {},               -- Override colors in specific palettes
  highlight_overrides = {},             -- Override specific highlight groups
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

**`palette_overrides`** - Customize colors in palettes (See [Color Palettes](lua/oasis/color_palettes) for palette structure)

```lua
require("oasis").setup({
  palette_overrides = {
    oasis_lagoon = {
      syntax = { func = "#E06C75", comment = "#5C6370" },
      ui = { border = "#61AFEF" }
    }
  }
})
```

<!-- palette-overrides:end-->
</details>

<details>
  <summary>💅 Changing Colors for Highlight Groups</summary>
  <br>
<!-- highlight-overrides:start -->

**`highlight_overrides`** - Override or add highlight groups (See [Theme Generator](lua/oasis/theme_generator.lua) for highlight groups):

```lua
require("oasis").setup({
  highlight_overrides = {
    Comment = { fg = "#5C6370", italic = true },
    Function = { fg = "#E06C75", bold = true },
    Identifier = "Function"  -- Link to another group
  }
})
```

<!-- highlight-overrides:end -->
</details>

## 👀 View All Theme Styles

<a id="view-all-theme-styles"></a>

<details open>
  <summary><b>All styles (click to collapse)</b></summary>
  <!-- all-styles:start -->

### Dark previews

<a id="night-dark"></a>
**Night (Dark · Night Sky)**

![night-dark-dashboard](./assets/screenshots/night-dark-dashboard.png)
![night-dark-code](./assets/screenshots/night-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="midnight-dark"></a>
**Midnight (Dark · Off Black)**

![midnight-dark-dashboard](./assets/screenshots/midnight-dark-dashboard.png)
![midnight-dark-code](./assets/screenshots/midnight-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="abyss-dark"></a>
**Abyss (Dark · Black)**

![abyss-dark-dashboard](./assets/screenshots/abyss-dark-dashboard.png)
![abyss-dark-code](./assets/screenshots/abyss-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="starlight-dark"></a>
**Starlight (Dark · Black Vivid)**

![starlight-dark-dashboard](./assets/screenshots/starlight-dark-dashboard.png)
![starlight-dark-code](./assets/screenshots/starlight-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="desert-dark"></a>
**Desert (Dark · Grey)**

![desert-dark-dashboard](./assets/screenshots/desert-dark-dashboard.png)
![desert-dark-code](./assets/screenshots/desert-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="sol-dark"></a>
**Sol (Dark · Red)**

![sol-dark-dashboard](./assets/screenshots/sol-dark-dashboard.png)
![sol-dark-code](./assets/screenshots/sol-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="canyon-dark"></a>
**Canyon (Dark · Orange)**

![canyon-dark-dashboard](./assets/screenshots/canyon-dark-dashboard.png)
![canyon-dark-code](./assets/screenshots/canyon-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="dune-dark"></a>
**Dune (Dark · Yellow)**

![dune-dark-dashboard](./assets/screenshots/dune-dark-dashboard.png)
![dune-dark-code](./assets/screenshots/dune-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="cactus-dark"></a>
**Cactus (Dark · Green)**

![cactus-dark-dashboard](./assets/screenshots/cactus-dark-dashboard.png)
![cactus-dark-code](./assets/screenshots/cactus-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="mirage-dark"></a>
**Mirage (Dark · Teal)**

![mirage-dark-dashboard](./assets/screenshots/mirage-dark-dashboard.png)
![mirage-dark-code](./assets/screenshots/mirage-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="lagoon-dark"></a>
**Lagoon (Dark · Default)**

![lagoon-dark-dashboard](./assets/screenshots/lagoon-dark-dashboard.png)
![lagoon-dark-code](./assets/screenshots/lagoon-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="twilight-dark"></a>
**Twilight (Dark · Purple)**

![twilight-dark-dashboard](./assets/screenshots/twilight-dark-dashboard.png)
![twilight-dark-code](./assets/screenshots/twilight-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

<a id="rose-dark"></a>
**Rose (Dark · Pink)**

![rose-dark-dashboard](./assets/screenshots/rose-dark-dashboard.png)
![rose-dark-code](./assets/screenshots/rose-dark-code.png)

<p align="center">
  <a href="#dark-previews">↑ Back to Dark Styles</a>
</p>

### Light previews

<a id="night-light"></a>
**Night (Light)**

![night-light-3-dashboard](./assets/screenshots/night-light-3-dashboard.png)
![night-light-3-code](./assets/screenshots/night-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="midnight-light"></a>
**Midnight (Light)**

![midnight-light-3-dashboard](./assets/screenshots/midnight-light-3-dashboard.png)
![midnight-light-3-code](./assets/screenshots/midnight-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="abyss-light"></a>
**Abyss (Light)**

![abyss-light-3-dashboard](./assets/screenshots/abyss-light-3-dashboard.png)
![abyss-light-3-code](./assets/screenshots/abyss-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="starlight-3-light"></a>
**Starlight (Light)**

![starlight-light-3-dashboard](./assets/screenshots/starlight-light-3-dashboard.png)
![starlight-light-3-code](./assets/screenshots/starlight-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="desert-light"></a>
**Desert (Light)**

![desert-light-3-dashboard](./assets/screenshots/desert-light-3-dashboard.png)
![desert-light-3-code](./assets/screenshots/desert-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="sol-light"></a>
**Sol (Light)**

![sol-light-3-dashboard](./assets/screenshots/sol-light-3-dashboard.png)
![sol-light-3-code](./assets/screenshots/sol-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="canyon-light"></a>
**Canyon (Light)**

![canyon-light-3-dashboard](./assets/screenshots/canyon-light-3-dashboard.png)
![canyon-light-3-code](./assets/screenshots/canyon-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="dune-light"></a>
**Dune (Light)**

![dune-light-3-dashboard](./assets/screenshots/dune-light-3-dashboard.png)
![dune-light-3-code](./assets/screenshots/dune-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="cactus-light"></a>
**Cactus (Light)**

![cactus-light-3-dashboard](./assets/screenshots/cactus-light-3-dashboard.png)
![cactus-light-3-code](./assets/screenshots/cactus-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="mirage-light"></a>
**Mirage (Light)**

![mirage-light-3-dashboard](./assets/screenshots/mirage-light-3-dashboard.png)
![mirage-light-3-code](./assets/screenshots/mirage-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="lagoon-light"></a>
**Lagoon (Light)**

![lagoon-light-3-dashboard](./assets/screenshots/lagoon-light-3-dashboard.png)
![lagoon-light-3-code](./assets/screenshots/lagoon-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="twilight-3-light"></a>
**Twilight (Light)**

![twilight-light-3-dashboard](./assets/screenshots/twilight-light-3-dashboard.png)
![twilight-light-3-code](./assets/screenshots/twilight-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

<a id="rose-light"></a>
**Rose (Light)**

![rose-light-3-dashboard](./assets/screenshots/rose-light-3-dashboard.png)
![rose-light-3-code](./assets/screenshots/rose-light-3-code.png)

<p align="center">
  <a href="#light-previews">↑ Back to Light Styles</a>
</p>

  <!-- all-styles:end -->
</details>
