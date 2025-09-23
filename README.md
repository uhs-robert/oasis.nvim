# 🏜️ Oasis.nvim

A modular desert-themed colorscheme for Neovim with warm, earthy tones and multiple palette variants. Originally inspired by the classic `desert` theme for vim, also uses the cool/warm philosophy from `melange` (i.e., `warm colors = action/flow` and `cool colors = structure/data`). 

## Features

- **10+ palette variants** - From cool lagoons to warm desert sands
- **Modular architecture** - Easy to customize and extend
- **Dual modes** - Works with or without Lush dependency
- **Live editing** - Real-time theme development with Lush
- **Export system** - Generate static colorschemes for distribution
- **Comprehensive highlighting** - LSP, Tree-sitter, and plugin support

## Installation

### Using lazy.nvim

```lua
{
  "uhs-robert/oasis.nvim",
  dependencies = { "rktjmp/lush.nvim" }, -- Optional for live editing
  config = function()
    vim.cmd.colorscheme("oasis") -- or a variant like (oasis_desert)
  end
}
```

### Using packer.nvim

```lua
use {
  "uhs-robert/oasis.nvim",
  requires = { "rktjmp/lush.nvim" }, -- Optional for live editing
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
-- Set colorscheme directly
vim.cmd.colorscheme("oasis_desert")

-- Or set/use a specific palette
vim.g.oasis_palette = "oasis_desert"
vim.cmd.colorscheme("oasis")
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

### Commands (with Lush)

```vim
:Oasis oasis_desert    " Switch to desert palette
:OasisExport all       " Export all palettes as static files
:OasisExport list      " List available palettes
```

## Two Usage Modes

### Dynamic Mode (with Lush)

- Live palette switching with `:Oasis` command
- Real-time theme editing and development
- Access to all advanced features

### Static Mode (without Lush)

- Zero dependencies, works out of the box
- Use pre-exported colorschemes: `:colorscheme oasis-desert`
- Slightly faster loading times
