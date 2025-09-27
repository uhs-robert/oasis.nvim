# 🏜️ Oasis.nvim

A modular desert-themed colorscheme for Neovim with warm, earthy tones and multiple palette variants (12 Total Themes). Originally inspired by the classic `desert` theme for vim, also uses the cool/warm philosophy from `melange` (i.e., `warm colors = action/flow` and `cool colors = structure/data`).

> [!TIP]
> Use TMUX? There is a companion TMUX plugin for this **Oasis** theme suite: [tmux-oasis](https://github.com/uhs-robert/tmux-oasis)

## Features

- **12 theme variants**: Covers the entire rainbow of options with an emphasis on being dark. Variants are all desert-inspired.
- **Comprehensive highlighting** - LSP, Tree-sitter, and plugin support
- **Fast loading** - Direct highlight application for optimal performance
- **Zero dependencies** - Works out of the box without external plugins
- **Modular architecture** - Easy to customize and extend

## Screenshots

If you want the top status line from the dashboard screenshots too, that's from TMUX. You can install the [Oasis TMUX companion plugin here](https://github.com/uhs-robert/tmux-oasis).

### Classic Desert Themes

<table>
  <tr>
    <td align="center">Lagoon</td>
    <td align="center">Desert</td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/lagoon-dashboard.webp" alt="Lagoon" width="320"></td>
    <td><img src="assets/screenshots/desert-dashboard.webp" alt="Desert" width="320"></td>
  </tr>
  <tr>
    <td align="center">Abyss</td>
    <td align="center">Twilight</td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/abyss-dashboard.webp" alt="Abyss" width="320"></td>
    <td><img src="assets/screenshots/twilight-dashboard.webp" alt="Twilight" width="320"></td>
  </tr>
</table>

### Full Color Spectrum (12 Themes Total)

<table>
  <tr>
    <td align="center">Sol</td>
    <td align="center">Canyon</td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/sol-dashboard.webp" alt="Sol" width="320"></td>
    <td><img src="assets/screenshots/canyon-dashboard.webp" alt="Canyon" width="320"></td>
  </tr>
  <tr>
    <td align="center">Mirage</td>
    <td align="center">Cactus</td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/mirage-dashboard.webp" alt="Mirage" width="320"></td>
    <td><img src="assets/screenshots/cactus-dashboard.webp" alt="Cactus" width="320"></td>
  </tr>

</table>

> [!NOTE]
> This is just a small sample. There are many more below.

## View All Theme Variants

<details>
  <summary><b>All variants (click to expand)</b></summary>

### Sol - Red

Hot, scorching desert sun with intense red tones

<img src="assets/screenshots/sol-dashboard.webp" alt="Sol" width="800">

### Canyon - Orange

Rich oranges of desert canyon walls

<img src="assets/screenshots/canyon-dashboard.webp" alt="Canyon" width="800">

### Dune - Yellow

Sandy beiges and warm yellow earth tones

<img src="assets/screenshots/dune-dashboard.webp" alt="Dune" width="800">

### Cactus - Green

Fresh greens of desert vegetation

<img src="assets/screenshots/cactus-dashboard.webp" alt="Cactus" width="800">

### Mirage - Teal

Cool teals of shimmering desert mirages

<img src="assets/screenshots/mirage-dashboard.webp" alt="Mirage" width="800">

### Lagoon - Blue

The original Oasis theme, cool blues of the oasis lagoon

<img src="assets/screenshots/lagoon-dashboard.webp" alt="Lagoon" width="800">

### Rose - Pink

Soft pinks of the warm desert rose

<img src="assets/screenshots/rose-dashboard.webp" alt="Rose" width="800">

### Twilight - Purple

Evening desert with purple and indigo hues

<img src="assets/screenshots/twilight-dashboard.webp" alt="Twilight" width="800">

### Desert - Grey

Inspired by the classic vim desert theme, neutral sand and earth tones

<img src="assets/screenshots/desert-dashboard.webp" alt="Desert" width="800">

### Night - Off Black

Deep desert night sky, almost black for those who prefer softer darkness

<img src="assets/screenshots/night-dashboard.webp" alt="Night" width="800">

### Abyss - Black

Deep, dark variant with mysterious depths

<img src="assets/screenshots/abyss-dashboard.webp" alt="Abyss" width="800">

### Starlight - Black Vivid

Desert abyss illuminated by brilliant starlight with vivid accent colors

<img src="assets/screenshots/starlight-dashboard.webp" alt="Starlight" width="800">

</details>

## Installation

### Using lazy.nvim

```lua
{
  "uhs-robert/oasis.nvim",
  config = function()
    vim.cmd.colorscheme("oasis") -- or use a variant like ("oasis_desert")
  end
}
```

### Using packer.nvim

```lua
use {
  "uhs-robert/oasis.nvim",
  config = function()
    vim.cmd.colorscheme("oasis")-- or use a variant like ("oasis_desert")
  end
}
```

### Manual Installation

```bash
git clone https://github.com/uhs-robert/oasis.nvim ~/.config/nvim/pack/plugins/start/oasis.nvim
```

## Usage

### Basic Usage

```lua
-- Set colorscheme directly with a specific palette
vim.cmd.colorscheme("oasis_desert")

-- Or use the Lua API directly
require('oasis').apply('oasis_desert')
```

### Available Theme Variants

#### By Dominant Color

- `sol` - **Red** - Hot, scorching desert sun with intense red tones
- `canyon` - **Orange** - Rich oranges of desert canyon walls
- `dune` - **Yellow** - Sandy beiges and warm yellow earth tones
- `cactus` - **Green** - Fresh greens of desert vegetation
- `mirage` - **Teal** - Cool teals of shimmering desert mirages
- `lagoon` (default) - **Blue** - The original Oasis theme, cool blues of the oasis lagoon
- `twilight` - **Purple** - Evening desert with purple and indigo hues
- `rose` - **Pink** - Soft pinks of the warm desert rose
- `desert` - **Grey** - Inspired by the classic vim desert theme, neutral sand and earth tones
- `night` - **Off Black** - Deep desert night sky, almost black for those who prefer softer darkness
- `abyss` - **Black** - Deep, dark variant with mysterious depths
- `starlight` - **Black Vivid** - Desert abyss illuminated by brilliant starlight with vivid accent colors

### Commands

```vim
:Oasis oasis_desert    " Switch to another palette (i.e., oasis_desert, oasis_lagoon, oasis_starlight etc:)
:OasisExport list      " List available palettes
```

## Architecture

The colorscheme uses a modular architecture with:

- **Direct highlight application** - Uses `vim.api.nvim_set_hl()` for optimal performance
- **Palette-based system** - Colors organized by semantic meaning (warm/cool/neutral)
- **Zero external dependencies** - Self-contained implementation
