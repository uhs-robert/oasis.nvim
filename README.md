# 🏜️ Oasis.nvim

A modular desert-themed colorscheme for Neovim with warm, earthy tones and multiple palette variants. Originally inspired by the classic `desert` theme for vim, also uses the cool/warm philosophy from `melange` (i.e., `warm colors = action/flow` and `cool colors = structure/data`).

## Features

- **10+ palette variants** - From cool lagoons to warm desert sands
- **Zero dependencies** - Works out of the box without external plugins
- **Fast loading** - Direct highlight application for optimal performance
- **Modular architecture** - Easy to customize and extend
- **Export system** - Generate static colorschemes for distribution (requires Shipwright)
- **Comprehensive highlighting** - LSP, Tree-sitter, and plugin support

## Installation

### Using lazy.nvim

```lua
{
  "uhs-robert/oasis.nvim",
  config = function()
    vim.cmd.colorscheme("oasis") -- or a variant like (oasis_desert)
  end
}
```

### Using packer.nvim

```lua
use {
  "uhs-robert/oasis.nvim",
  config = function()
    vim.cmd.colorscheme("oasis") -- or a variant like (oasis_desert)
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

-- Or set default palette and use base command
vim.g.oasis_palette = "oasis_desert"
vim.cmd.colorscheme("oasis")

-- Or use the Lua API directly
require('oasis').apply('oasis_desert')
```

### Available Palettes

- `oasis_lagoon` (default) - The heart of the oasis is a `blue` lagoon
- `oasis_desert` - Inspired by `vim's classic desert` theme
- `oasis_mirage` - The `green` agave can't be real, it must be a mirage
- `oasis_night` - The chill of the night, a cool `dark grey`
- `oasis_twilight` - The evening twilight's `purple` horizon
- `oasis_abyss` - Darker than night, the `black` abyss
- `oasis_canyon` - The warm `red/orange` rock canyon
- `oasis_dune` - The dunes are an endless `brown sand`
- `oasis_sol` - The unforgiving `red` hot sun
- `oasis_starlight` - Guided by the moon/stars during the `vivid black` night

### Commands

```vim
:Oasis oasis_desert    " Switch to desert palette
:OasisExport all       " Export all palettes as static files (requires Shipwright)
:OasisExport list      " List available palettes
```

## Architecture

The colorscheme uses a modular architecture with:

- **Direct highlight application** - Uses `vim.api.nvim_set_hl()` for optimal performance
- **Palette-based system** - Colors organized by semantic meaning (warm/cool/neutral)
- **Zero external dependencies** - Self-contained implementation
- **Export compatibility** - Can generate static files for distribution
