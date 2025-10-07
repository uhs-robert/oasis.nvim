# 🏜️ Oasis.nvim

A modular desert-themed colorscheme for Neovim with warm, earthy tones and 12 unique palette styles.

Originally inspired by the classic [desert theme for vim](https://github.com/fugalh/desert.vim); Oasis modernizes it and uses the [cool/warm philosophy from melange](https://github.com/savq/melange-nvim?tab=readme-ov-file#design) (i.e., `warm colors = action/flow` and `cool colors = structure/data`).

## ✨ Features

- **12 theme styles**: A rainbow of desert-inspired options; with an emphasis on being dark.
- **Comprehensive highlighting** - LSP, Tree-sitter, and plugin support
- **Fast loading** - Direct highlight application for optimal performance
- **Zero dependencies** - Works out of the box without external plugins
- **Modular architecture** - Easy to customize and extend

<details>
<summary>💪 Supported Plugins</summary>

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

> [!NOTE]
> Use TMUX? There is a companion TMUX plugin for this **Oasis** theme suite: [tmux-oasis](https://github.com/uhs-robert/tmux-oasis)

## 🌅 Overview

Choose from 12 distinct desert-inspired styles, each with its own personality and color palette:

> [!TIP]
> Click one below to see a larger image along with code syntax preview

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

**[↓ 👀 View all styles expanded with code syntax](#view-all-theme-styles)**

## 📦 Installation

Install the theme with your preferred package manager, such as
[folke/lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "uhs-robert/oasis.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('oasis').setup({
      style = "lagoon",  -- Optional: Choose any style like `lagoon` or 'dune'.
    })
  end
}
```

## ⚙️ Configuration

The theme offers 12 different styles to choose from: `night`, `abyss`, `starlight`, `desert`, `sol`, `canyon`, `dune`, `cactus`, `mirage`, `lagoon`, `twilight`, and `rose`.

Oasis works out of the box, but you can customize it using `setup()`.

<details>
  <summary>🍦 Default Options</summary>

<!-- config:start -->

```lua
require('oasis').setup({
  style = "lagoon",            -- Choose your style (e.g., "lagoon", "desert", "dune", etc:)
  useLegacyComments = false,   -- Uses the legacy comment color in the `desert` style only (a bright sky blue)
  palette_overrides = {},      -- Override colors in specific palettes
  highlight_overrides = {},    -- Override specific highlight groups
})
```

<!-- config:end -->

</details>

## 🪓 Overriding Colors & Highlight Groups

Thirsty for total control? Oasis allows you to override whatever you like.

> Whoever drinketh of the water that I shall give him, shall never thirst...

<details>
  <summary>🎨 Changing Palette Colors for Each Style</summary>

**`palette_overrides`** - Customize colors in specific palettes. See [Color Palettes](lua/oasis/color_palettes) for palette structure:

```lua
require('oasis').setup({
  palette_overrides = {
    oasis_lagoon = {
      syntax = { func = "#E06C75", comment = "#5C6370" },
      ui = { border = "#61AFEF" }
    }
  }
})
```

</details>

<details>
  <summary>💅 Changing Colors for Highlight Groups</summary>

**`highlight_overrides`** - Override specific highlight groups (takes precedence over theme) or add new ones. See [Theme Generator](lua/oasis/theme_generator.lua) for highlight groups used:

```lua
require('oasis').setup({
  highlight_overrides = {
    Comment = { fg = "#5C6370", italic = true },
    Function = { fg = "#E06C75", bold = true },
    Identifier = "Function"  -- Link to another group
  }
})
```

</details>

## 🚀 Usage

### ⭐ Recommended: Use `setup()` to launch nvim with your desired style

```lua
-- Use default style (lagoon)
require('oasis').setup()

-- Or specify a style
require('oasis').setup({ style = "desert" })
```

### Alternative: Use `colorscheme` command to swap on the fly

```lua
vim.cmd.colorscheme("oasis")  -- default (lagoon)
vim.cmd.colorscheme("oasis-desert")  -- specific style
```

```vim
colorscheme oasis

" You may also use different styles, this method must be prefixed with `oasis-`
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
  <summary>🌵 Click here for more details</summary>

### LazyVim

To override the tokyonight default and start fresh in the oasis:

```lua
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
require('lualine').setup {
  options = {
    theme = 'oasis'  -- Automatically matches your current Oasis style
  }
}
```

### Tabby (Tab Bar)

To include tab bar theme integration:

```lua
require('tabby').setup({
  theme = 'oasis' -- Automatically matches your current Oasis style
})
```

</details>

## 🍭 Extras

Extra color configs for [Kitty](https://sw.kovidgoyal.net/kitty/conf.html) can be found in [extras](extras/). If you'd like an extra config added, raise a feature request and I'll put it together.

To use the extras, refer to their respective documentation.

There are also companion plugins for other applications:

- **TMUX**: [tmux-oasis](https://github.com/uhs-robert/tmux-oasis)

## 🎯 Vote for Your Favorite Style

Want to help shape **Oasis.nvim**?
**[👉 Join the Discussion and Vote Here](https://github.com/uhs-robert/oasis.nvim/discussions/2)**

> [!IMPORTANT]
> Click the screenshot of your favorite style in the discussion and hit 👍 on the comment.
>
> You can vote for more than one and leave feedback about contrast, accents, or plugin integration.

<a id="view-all-theme-styles"></a>

## 👀 View All Theme Styles

<details open>
  <summary><b>All styles (click to collapse)</b></summary>

### Night - Off Black

Deep desert night sky, almost black for those who prefer softer darkness

![night-dashboard](https://github.com/user-attachments/assets/f49b637f-2309-4ae2-8118-8036594eef1d)
![night-code](https://github.com/user-attachments/assets/d4e0624f-aed7-4540-9439-8ebe913178ca)

### Abyss - Black

Deep, dark style with mysterious depths

![abyss-dashboard](https://github.com/user-attachments/assets/6ec77ade-b352-4ccc-a0cf-0f1081a458b1)
![abyss-code](https://github.com/user-attachments/assets/f35a4429-ce35-49f5-80d0-e8ee9a339db0)

### Starlight - Black Vivid

Desert abyss illuminated by brilliant starlight with vivid accent colors

![starlight-dashboard](https://github.com/user-attachments/assets/2e63e83f-5a85-418b-98ab-765a6fc90d03)
![starlight-code](https://github.com/user-attachments/assets/e8ec9e0e-366a-4583-89d5-adc17082a720)

### Desert - Grey

Inspired by the classic vim desert theme, neutral sand and earth tones

![desert-dashboard](https://github.com/user-attachments/assets/b83b0bf9-3726-4bb3-81d7-b065e97b1ef9)
![desert-code](https://github.com/user-attachments/assets/0a4ab491-f117-44bc-872e-82bacc330109)

### Sol - Red

Hot, scorching desert sun with intense red tones

![sol-dashboard](https://github.com/user-attachments/assets/a1bf31d7-d2eb-487c-852f-41d2f2235c67)
![sol-code](https://github.com/user-attachments/assets/d6772e0c-0698-45e2-a2f2-b3ef07afe2e5)

### Canyon - Orange

Rich oranges of desert canyon walls

![canyon-dashboard](https://github.com/user-attachments/assets/106c43f1-b6be-4130-b094-7c86c87f64ee)
![canyon-code](https://github.com/user-attachments/assets/4167be1b-15e0-4f7f-9819-164a84b9fc1e)

### Dune - Yellow

Sandy beiges and warm yellow earth tones

![dune-dashboard](https://github.com/user-attachments/assets/1d81afdd-9825-4649-bb69-9d102cafc139)
![dune-code](https://github.com/user-attachments/assets/9a191088-f577-49dc-81a9-bd7e6af48324)

### Cactus - Green

Fresh greens of desert vegetation

![cactus-dashboard](https://github.com/user-attachments/assets/9e988d7e-03c2-42a3-8481-7e64735d0b98)
![cactus-code](https://github.com/user-attachments/assets/8ef61be0-cc82-4d5b-84b8-1898d193cc3c)

### Mirage - Teal

Cool teals of shimmering desert mirages

![mirage-dashboard](https://github.com/user-attachments/assets/0662545c-c4b8-44dc-b681-10732f90970b)
![mirage-code](https://github.com/user-attachments/assets/6814e943-5e5a-40d9-b565-44e5ed0141c2)

### Lagoon - Blue

The original Oasis theme and default style, featuring cool blues of the oasis lagoon

![lagoon-dashboard](https://github.com/user-attachments/assets/076d4097-d3a0-4051-8e2a-32962a4b2ba5)
![lagoon-code](https://github.com/user-attachments/assets/1bd9c4b6-524b-407f-97f2-a3a5d4ecb3f9)

### Twilight - Purple

Evening desert with purple and indigo hues

![twilight-dashboard](https://github.com/user-attachments/assets/ae993798-7dfd-4721-ba0f-0b695ce498c8)
![twilight-code](https://github.com/user-attachments/assets/f225f3f3-ff23-4920-93cd-7ffc108daf8e)

### Rose - Pink

Soft pinks of the warm desert rose

![rose-dashboard](https://github.com/user-attachments/assets/ff4922d2-5ae9-4445-9eb4-ba04832798dd)
![rose-code](https://github.com/user-attachments/assets/be74caed-a1e4-4219-9c49-34bad64f9cda)

</details>
