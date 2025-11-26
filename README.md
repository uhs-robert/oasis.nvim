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
A collection of <strong>18</strong> desert-inspired Neovim colorschemes; warm, readable, and configurable.
</p>

## 🌅 Overview

Born from the classic [desert.vim](https://github.com/fugalh/desert.vim), transformed and modernized into something new entirely.

Oasis follows Melange's warm/cool split philosophy (**warm = action/flow**, **cool = structure/data**).

**All themes are fully AAA WCAG compliant**. Light themes use warm beige-to-peachy tones to minimize blue light exposure and support eye health during extended coding sessions.

<table>
  <tr>
    <td align="center">
      <a href="#night-purple-night-sky"><img src="assets/screenshots/night-dashboard.png" alt="Night" width="180"></a><br>
      <strong>Night</strong><br><em>Purple Night Sky</em>
    </td>
    <td align="center">
      <a href="#midnight-off-black"><img src="assets/screenshots/midnight-dashboard.png" alt="Midnight" width="180"></a><br>
      <strong>Midnight</strong><br><em>Off Black</em>
    </td>
    <td align="center">
      <a href="#abyss-black"><img src="assets/screenshots/abyss-dashboard.png" alt="Abyss" width="180"></a><br>
      <strong>Abyss</strong><br><em>Black</em>
    </td>
    <td align="center">
      <a href="#starlight-black-vivid"><img src="assets/screenshots/starlight-dashboard.png" alt="Starlight" width="180"></a><br>
      <strong>Starlight</strong><br><em>Black Vivid</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="#desert-grey"><img src="assets/screenshots/desert-dashboard.png" alt="Desert" width="180"></a><br>
      <strong>Desert</strong><br><em>Grey</em>
    </td>
    <td align="center">
      <a href="#sol-red"><img src="assets/screenshots/sol-dashboard.png" alt="Sol" width="180"></a><br>
      <strong>Sol</strong><br><em>Red</em>
    </td>
    <td align="center">
      <a href="#canyon-orange"><img src="assets/screenshots/canyon-dashboard.png" alt="Canyon" width="180"></a><br>
      <strong>Canyon</strong><br><em>Orange</em>
    </td>
    <td align="center">
      <a href="#dune-yellow"><img src="assets/screenshots/dune-dashboard.png" alt="Dune" width="180"></a><br>
      <strong>Dune</strong><br><em>Yellow</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="#cactus-green"><img src="assets/screenshots/cactus-dashboard.png" alt="Cactus" width="180"></a><br>
      <strong>Cactus</strong><br><em>Green</em>
    </td>
    <td align="center">
      <a href="#mirage-teal"><img src="assets/screenshots/mirage-dashboard.png" alt="Mirage" width="180"></a><br>
      <strong>Mirage</strong><br><em>Teal</em>
    </td>
    <td align="center">
      <a href="#lagoon-blue"><img src="assets/screenshots/lagoon-dashboard.png" alt="Lagoon" width="180"></a><br>
      <strong>Lagoon (Default Dark)</strong><br><em>Blue</em>
    </td>
    <td align="center">
      <a href="#twilight-purple"><img src="assets/screenshots/twilight-dashboard.png" alt="Twilight" width="180"></a><br>
      <strong>Twilight</strong><br><em>Purple</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="#rose-pink"><img src="assets/screenshots/rose-dashboard.png" alt="Rose" width="180"></a><br>
      <strong>Rose</strong><br><em>Pink</em>
    </td>
    <td align="center">
      <a href="#dawn-beige"><img src="assets/screenshots/dawn-dashboard.png" alt="Dawn" width="180"></a><br>
      <strong>Dawn (Default Light)</strong><br><em>Beige</em>
    </td>
    <td align="center">
      <a href="#dawnlight-golden-beige"><img src="assets/screenshots/dawnlight-dashboard.png" alt="Dawnlight" width="180"></a><br>
      <strong>Dawnlight</strong><br><em>Golden Beige</em>
    </td>
    <td align="center">
      <a href="#day-gold"><img src="assets/screenshots/day-dashboard.png" alt="Day" width="180"></a><br>
      <strong>Day</strong><br><em>Gold</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="#dusk-peach-gold"><img src="assets/screenshots/dusk-dashboard.png" alt="Dusk" width="180"></a><br>
      <strong>Dusk</strong><br><em>Peach Gold</em>
    </td>
    <td align="center">
      <a href="#dust-golden-sand"><img src="assets/screenshots/dust-dashboard.png" alt="Dust" width="180"></a><br>
      <strong>Dust</strong><br><em>Golden Sand</em>
    </td>
  </tr>
</table>

> [!TIP]
> Click any card above to view the full preview and syntax sample.
>
> [↓ Click here to view all full previews](#view-all-theme-styles)

## ✨ Features

- **18 theme styles**: A rainbow of desert-inspired options; with an emphasis on warmth and readability.
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

<details>
<summary>🍭 Extras</summary>
<br>

[All extra configs](extras/) for other software, terminal applications, or vim related tools.

To use the extras, refer to their respective documentation.

<!-- extras:start -->

| Tool        | Extra                                                  |
| ----------- | ------------------------------------------------------ |
| Alacritty   | [extras/alacritty](extras/alacritty)                   |
| Btop        | [extras/btop](extras/btop)                             |
| Dark Reader | [extras/dark-reader](/extras/dark-reader)              |
| Foot        | [extras/foot](extras/foot)                             |
| Gemini CLI  | [extras/gemini-cli](extras/gemini-cli)                 |
| Ghostty     | [extras/ghostty](extras/ghostty)                       |
| Kitty       | [extras/kitty](extras/kitty)                           |
| Konsole     | [extras/konsole](extras/konsole)                       |
| Termux      | [extras/termux](extras/termux)                         |
| TMUX        | [tmux-oasis](https://github.com/uhs-robert/tmux-oasis) |
| Vimium C    | [extras/vimium-c](extras/vimium-c)                     |
| WezTerm     | [extras/wezterm](extras/wezterm)                       |
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
    vim.cmd.colorscheme("oasis")  -- After setup, apply theme (or a any style like "oasis-night")
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
colorscheme oasis-dawn
colorscheme oasis-dawnlight
colorscheme oasis-day
colorscheme oasis-dusk
colorscheme oasis-dust
```

<!-- colorscheme-commands:end -->
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
-- Styles: "night", "midnight", "abyss", "starlight", "desert", "sol", "canyon", "dune", "cactus", "mirage", "lagoon", "twilight", "rose", "dawn", "dawnlight", "day", "dusk", "dust"
require("oasis").setup({
  dark_style = "lagoon",         -- Style to use when vim.o.background is "dark"
  light_style = "dawn",          -- Style to use when vim.o.background is "light"
  style = nil,                   -- Optional: Set a single style to disable auto-switching (e.g., "lagoon", "desert")
  use_legacy_comments = false,   -- Uses the legacy comment color from desert.vim for the "desert" style only (a bright sky blue)

  -- Text styling - disable individual styles if you like
  styles = {
    bold = true,                 -- Enable bold text (keywords, functions, etc.)
    italic = true,               -- Enable italics (comments, certain keywords)
    underline = true,            -- Enable underlined text (matching words)
    undercurl = true,            -- Enable undercurl for diagnostics/spelling
    strikethrough = true,        -- Enable strikethrough text (deprecations)
  },

  -- Display options
  transparent = false,           -- Set to true for transparent backgrounds (bye bye theme backgrounds)
  terminal_colors = true,        -- Apply Oasis colors to Neovim's built-in terminal

  palette_overrides = {},        -- Override colors in specific palettes
  highlight_overrides = {},      -- Override specific highlight groups
})
```

<!-- config:end -->
</details>

## 🌗 Automatic Light/Dark Mode Switching

Oasis automatically switches between your config's `light_style` and `dark_style` based on `vim.o.background`.

<details>
  <summary>☀️ Configure Light / Dark Styles</summary>
  <br>
<!-- light-dark:start -->

```lua
require("oasis").setup({
  dark_style = "lagoon",      -- Style when background is dark
  light_style = "dawn"        -- Style when background is light
})
vim.cmd.colorscheme("oasis")  -- Apply the theme
```

<!-- light-dark:end -->
</details>

> [!TIP]
> You may use _any_ style for light or dark mode. No restrictions apply. (e.g. use 'desert' in light_style)

### 🕶️ Choosing a Light Theme

Light styles vary in brightness to adapt to your workspace lighting. The right lightness keeps your eyes comfortable, reduces strain and headaches, and helps maintain focus throughout the day.

- Dawn (91%) - brightest for well-lit spaces
- Dawnlight (88%) - a tad softer with golden tones
- Day (85%) - balanced for everyday use
- Dusk (77%) - warmer for extended sessions
- Dust (70%) - warmest for dim lighting

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

## 🗳️ Vote for Your Favorite Style

Want to help shape **Oasis.nvim**?
**[👉 Join the Discussion and Vote Here](https://github.com/uhs-robert/oasis.nvim/discussions/2)**

## 👀 View All Theme Styles

<a id="view-all-theme-styles"></a>

<details open>
  <summary><b>All styles (click to collapse)</b></summary>
  <!-- all-styles:start -->

### Night (Purple Night Sky)

Deep desert night sky with purple-indigo undertones, a deeper purple than twilight for those who prefer soft darkness

![night-dashboard](./assets/screenshots/night-dashboard.png)
![night-code](./assets/screenshots/night-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Midnight (Off Black)

Deep slate and navy tones of the desert at midnight, a tinted-black lighter than abyss

![midnight-dashboard](./assets/screenshots/midnight-dashboard.png)
![midnight-code](./assets/screenshots/midnight-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Abyss (Black)

Deep, dark style with mysterious depths

![abyss-dashboard](./assets/screenshots/abyss-dashboard.png)
![abyss-code](./assets/screenshots/abyss-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Starlight (Black Vivid)

Desert abyss illuminated by brilliant starlight with vivid high-contrast colors and excellent WCAG compliance.

![starlight-dashboard](./assets/screenshots/starlight-dashboard.png)
![starlight-code](./assets/screenshots/starlight-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Desert (Grey)

The original inspiration, the classic vim desert theme reborn with neutral sand and earth tones

![desert-dashboard](./assets/screenshots/desert-dashboard.png)
![desert-code](./assets/screenshots/desert-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Sol (Red)

Hot, scorching desert sun with intense red tones

![sol-dashboard](./assets/screenshots/sol-dashboard.png)
![sol-code](./assets/screenshots/sol-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Canyon (Orange)

Rich oranges of desert canyon walls

![canyon-dashboard](./assets/screenshots/canyon-dashboard.png)
![canyon-code](./assets/screenshots/canyon-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Dune (Yellow)

Sandy beiges and warm yellow earth tones

![dune-dashboard](./assets/screenshots/dune-dashboard.png)
![dune-code](./assets/screenshots/dune-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Cactus (Green)

Fresh greens of desert vegetation

![cactus-dashboard](./assets/screenshots/cactus-dashboard.png)
![cactus-code](./assets/screenshots/cactus-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Mirage (Teal)

Cool teals of shimmering desert mirages

![mirage-dashboard](./assets/screenshots/mirage-dashboard.png)
![mirage-code](./assets/screenshots/mirage-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Lagoon (Blue)

The original Oasis theme and default dark style, featuring cool blues of the oasis lagoon

![lagoon-dashboard](./assets/screenshots/lagoon-dashboard.png)
![lagoon-code](./assets/screenshots/lagoon-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Twilight (Purple)

Evening desert with purple and indigo hues

![twilight-dashboard](./assets/screenshots/twilight-dashboard.png)
![twilight-code](./assets/screenshots/twilight-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Rose (Pink)

Soft pinks of the warm desert rose

![rose-dashboard](./assets/screenshots/rose-dashboard.png)
![rose-code](./assets/screenshots/rose-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Dawn (Beige)

The default light style - bright morning sun with excellent WCAG compliance (`Lightness = 91`)

![dawn-dashboard](./assets/screenshots/dawn-dashboard.png)
![dawn-code](./assets/screenshots/dawn-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Dawnlight (Golden Beige)

Slightly warmer than dawn, a golden morning glow (`Lightness = 88`)

![dawnlight-dashboard](./assets/screenshots/dawnlight-dashboard.png)
![dawnlight-code](./assets/screenshots/dawnlight-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Day (Gold)

Full daylight warmth with rich golden saturation (`Lightness = 85`)

![day-dashboard](./assets/screenshots/day-dashboard.png)
![day-code](./assets/screenshots/day-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Dusk (Peach Gold)

Warm sky at sunset, peachy-golden tones for extended coding sessions (`Lightness = 77`)

![dusk-dashboard](./assets/screenshots/dusk-dashboard.png)
![dusk-code](./assets/screenshots/dusk-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

### Dust (Golden Sand)

Warm peachy-golden tones for extended coding sessions (`Lightness = 70`)

![dust-dashboard](./assets/screenshots/dust-dashboard.png)
![dust-code](./assets/screenshots/dust-code.png)

<p align="center">
  <a href="#-overview">↑ Back to Overview</a>
</p>

  <!-- all-styles:end -->
</details>
