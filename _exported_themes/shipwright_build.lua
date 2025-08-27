-- shipwright_build.lua
-- Generic template for exporting Oasis colorscheme variants using Shipwright
-- This file serves as a template and reference for manual exports
-- For automated bulk exports, use _exported_themes/export_all.lua instead

local lushwright = require("shipwright.transform.lush")

-- Configuration
local PALETTE_NAME = "oasis_midnight"  -- Change this to the desired palette
local OUTPUT_FORMAT = "lua"           -- "lua" or "vim"
local OUTPUT_FILENAME = "oasis-midnight" -- Output filename (without extension)

-- Helper function to build colorscheme with specific palette
local function build_colorscheme(palette_name)
  -- Load the palette
  local ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)
  if not ok then
    error(('Palette "%s" not found: %s'):format(palette_name, palette))
  end
  
  -- Load theme generator and build colorscheme
  local theme_generator = require("oasis.theme_generator")
  return theme_generator(palette)
end

-- Build the colorscheme
local colorscheme = build_colorscheme(PALETTE_NAME)

-- Export based on format
if OUTPUT_FORMAT == "lua" then
  -- NEOVIM LUA EXPORT
  run(
    colorscheme,
    -- generate lua code
    lushwright.to_lua,
    -- write the lua code into our destination
    { patchwrite, ("colors/%s.lua"):format(OUTPUT_FILENAME), "-- PATCH_OPEN", "-- PATCH_CLOSE" }
  )
  
elseif OUTPUT_FORMAT == "vim" then
  -- VIM SCRIPT EXPORT
  run(
    colorscheme,
    lushwright.to_vimscript,
    
    -- append housekeeping lines for vimscript colorschemes
    { append, { 
      "set background=dark", 
      ('let g:colors_name="%s"'):format(OUTPUT_FILENAME)
    }},
    
    -- write to colors directory
    { overwrite, ("colors/%s.vim"):format(OUTPUT_FILENAME) }
  )
  
else
  error(("Unsupported format: %s"):format(OUTPUT_FORMAT))
end

print(("Exported %s palette as %s to colors/%s.%s"):format(
  PALETTE_NAME, OUTPUT_FORMAT, OUTPUT_FILENAME, OUTPUT_FORMAT))
