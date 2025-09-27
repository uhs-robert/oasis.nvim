# 🏜️ Oasis.nvim

A modular desert-themed colorscheme for Neovim with warm, earthy tones and multiple palette variants (12 Total Themes). Originally inspired by the classic `desert` theme for vim, also uses the cool/warm philosophy from `melange` (i.e., `warm colors = action/flow` and `cool colors = structure/data`).

> [!NOTE]
> Use TMUX? There is a companion TMUX plugin for this **Oasis** theme suite: [tmux-oasis](https://github.com/uhs-robert/tmux-oasis)

## ✨ Features

- **12 theme variants**: Covers the entire rainbow of options with an emphasis on being dark. Variants are all desert-inspired.
- **Comprehensive highlighting** - LSP, Tree-sitter, and plugin support
- **Fast loading** - Direct highlight application for optimal performance
- **Zero dependencies** - Works out of the box without external plugins
- **Modular architecture** - Easy to customize and extend

<details>
<summary>🎨 Supported Plugins</summary>

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

<!-- extras:start -->

| Tool  | Extra                                                  |
| ----- | ------------------------------------------------------ |
| Kitty | [extras/kitty](extras/kitty)                           |
| TMUX  | [tmux-oasis](https://github.com/uhs-robert/tmux-oasis) |

<!-- extras:end -->
</details>

## 🌅 Overview

Choose from 12 distinct desert-inspired variants, each with its own personality and color palette:

> [!TIP]
> Click one below to see a larger image along with code syntax preview
>
> **[Vote for your favorite variant →](https://github.com/uhs-robert/oasis.nvim/discussions/2)**

<table>
  <tr>
    <td align="center">
      <a href="#night---off-black"><img src="assets/screenshots/night-dashboard.webp" alt="Night" width="180"></a><br>
      <strong>Night</strong><br><em>Off Black</em>
    </td>
    <td align="center">
      <a href="#abyss---black"><img src="assets/screenshots/abyss-dashboard.webp" alt="Abyss" width="180"></a><br>
      <strong>Abyss</strong><br><em>Black</em>
    </td>
    <td align="center">
      <a href="#starlight---black-vivid"><img src="assets/screenshots/starlight-dashboard.webp" alt="Starlight" width="180"></a><br>
      <strong>Starlight</strong><br><em>Black Vivid</em>
    </td>
    <td align="center">
      <a href="#desert---grey"><img src="assets/screenshots/desert-dashboard.webp" alt="Desert" width="180"></a><br>
      <strong>Desert</strong><br><em>Grey</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="#sol---red"><img src="assets/screenshots/sol-dashboard.webp" alt="Sol" width="180"></a><br>
      <strong>Sol</strong><br><em>Red</em>
    </td>
    <td align="center">
      <a href="#canyon---orange"><img src="assets/screenshots/canyon-dashboard.webp" alt="Canyon" width="180"></a><br>
      <strong>Canyon</strong><br><em>Orange</em>
    </td>
    <td align="center">
      <a href="#dune---yellow"><img src="assets/screenshots/dune-dashboard.webp" alt="Dune" width="180"></a><br>
      <strong>Dune</strong><br><em>Yellow</em>
    </td>
    <td align="center">
      <a href="#cactus---green"><img src="assets/screenshots/cactus-dashboard.webp" alt="Cactus" width="180"></a><br>
      <strong>Cactus</strong><br><em>Green</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="#mirage---teal"><img src="assets/screenshots/mirage-dashboard.webp" alt="Mirage" width="180"></a><br>
      <strong>Mirage</strong><br><em>Teal</em>
    </td>
    <td align="center">
      <a href="#lagoon---blue"><img src="assets/screenshots/lagoon-dashboard.webp" alt="Lagoon" width="180"></a><br>
      <strong>Lagoon (Default)</strong><br><em>Blue</em>
    </td>
    <td align="center">
      <a href="#twilight---purple"><img src="assets/screenshots/twilight-dashboard.webp" alt="Twilight" width="180"></a><br>
      <strong>Twilight</strong><br><em>Purple</em>
    </td>
    <td align="center">
      <a href="#rose---pink"><img src="assets/screenshots/rose-dashboard.webp" alt="Rose" width="180"></a><br>
      <strong>Rose</strong><br><em>Pink</em>
    </td>
  </tr>
</table>

**[↓ 👀 View all variants expanded with code syntax](#view-all-theme-variants)**

## 📦 Installation

Install the theme with your preferred package manager, such as
[folke/lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "uhs-robert/oasis.nvim",
  config = function()
    vim.cmd.colorscheme("oasis") -- or use a variant like ("oasis_desert")
  end
}
```

## 🚀 Usage

```lua
-- Use default theme (lagoon variant)
vim.cmd.colorscheme("oasis")
```

```vim
colorscheme oasis

" You may also use different variants
colorscheme oasis-abyss
colorscheme oasis-cactus
colorscheme oasis-canyon
colorscheme oasis-desert
colorscheme oasis-dune
colorscheme oasis-lagoon
colorscheme oasis-mirage
colorscheme oasis-night
colorscheme oasis-rose
colorscheme oasis-sol
colorscheme oasis-starlight
colorscheme oasis-twilight
```

Some plugins need extra configuration to work with **Oasis**.

<details>
  <summary>Click here for more details</summary>

### Lualine

Oasis includes automatic Lualine theme integration that matches your current palette:

```lua
require('lualine').setup {
  options = {
    theme = 'oasis'  -- Automatically matches your current Oasis palette
  }
}
```

### Tabby (Tab Bar)

For enhanced tab bar styling that matches your Oasis theme:

```lua
require('tabby').setup({
  theme = 'oasis'  -- Uses current Oasis palette for tab styling
})
```

</details>

## 🍭 Extras

Extra color configs for [Kitty](https://sw.kovidgoyal.net/kitty/conf.html) can be found in [extras](extras/). If you'd like an extra config added, raise a feature request and I'll put it together.

To use the extras, refer to their respective documentation.

There are also companion plugins for other applications:

- **TMUX**: [tmux-oasis](https://github.com/uhs-robert/tmux-oasis)

## 🎯 Vote for Your Favorite Variant

Want to help shape **Oasis.nvim**?
**[👉 Join the Discussion and Vote Here](https://github.com/uhs-robert/oasis.nvim/discussions/2)**

> [!IMPORTANT]
> Click the screenshot of your favorite variant in the discussion and hit 👍 on the comment.
>
> You can vote for more than one and leave feedback about contrast, accents, or plugin integration.

<a id="view-all-theme-variants"></a>

## 👀 View All Theme Variants

<details open>
  <summary><b>All variants (click to collapse)</b></summary>

### Night - Off Black

Deep desert night sky, almost black for those who prefer softer darkness

<img src="assets/screenshots/night-dashboard.webp" alt="Night Dashboard" width="800">

<img src="assets/screenshots/night-code.webp" alt="Night Code" width="800">

### Abyss - Black

Deep, dark variant with mysterious depths

<img src="assets/screenshots/abyss-dashboard.webp" alt="Abyss Dashboard" width="800">

<img src="assets/screenshots/abyss-code.webp" alt="Abyss Code" width="800">

### Starlight - Black Vivid

Desert abyss illuminated by brilliant starlight with vivid accent colors

<img src="assets/screenshots/starlight-dashboard.webp" alt="Starlight Dashboard" width="800">

<img src="assets/screenshots/starlight-code.webp" alt="Starlight Code" width="800">

### Desert - Grey

Inspired by the classic vim desert theme, neutral sand and earth tones

<img src="assets/screenshots/desert-dashboard.webp" alt="Desert Dashboard" width="800">

<img src="assets/screenshots/desert-code.webp" alt="Desert Code" width="800">

### Sol - Red

Hot, scorching desert sun with intense red tones

<img src="assets/screenshots/sol-dashboard.webp" alt="Sol Dashboard" width="800">

<img src="assets/screenshots/sol-code.webp" alt="Sol Code" width="800">

### Canyon - Orange

Rich oranges of desert canyon walls

<img src="assets/screenshots/canyon-dashboard.webp" alt="Canyon Dashboard" width="800">

<img src="assets/screenshots/canyon-code.webp" alt="Canyon Code" width="800">

### Dune - Yellow

Sandy beiges and warm yellow earth tones

<img src="assets/screenshots/dune-dashboard.webp" alt="Dune Dashboard" width="800">

<img src="assets/screenshots/dune-code.webp" alt="Dune Code" width="800">

### Cactus - Green

Fresh greens of desert vegetation

<img src="assets/screenshots/cactus-dashboard.webp" alt="Cactus Dashboard" width="800">

<img src="assets/screenshots/cactus-code.webp" alt="Cactus Code" width="800">

### Mirage - Teal

Cool teals of shimmering desert mirages

<img src="assets/screenshots/mirage-dashboard.webp" alt="Mirage Dashboard" width="800">

<img src="assets/screenshots/mirage-code.webp" alt="Mirage Code" width="800">

### Lagoon - Blue

The original Oasis theme and default variant, featuring cool blues of the oasis lagoon

<img src="assets/screenshots/lagoon-dashboard.webp" alt="Lagoon Dashboard" width="800">

<img src="assets/screenshots/lagoon-code.webp" alt="Lagoon Code" width="800">

### Twilight - Purple

Evening desert with purple and indigo hues

<img src="assets/screenshots/twilight-dashboard.webp" alt="Twilight Dashboard" width="800">

<img src="assets/screenshots/twilight-code.webp" alt="Twilight Code" width="800">

### Rose - Pink

Soft pinks of the warm desert rose

<img src="assets/screenshots/rose-dashboard.webp" alt="Rose Dashboard" width="800">

<img src="assets/screenshots/rose-code.webp" alt="Rose Code" width="800">

</details>
