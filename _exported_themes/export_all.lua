-- export_all.lua
-- Automated export script to generate static colorscheme files for all Oasis palette variants

local M = {}

-- Helper function to get all available palette names
local function get_all_palettes()
  local palettes = {}
  
  -- Check if we're running in Neovim
  if vim and vim.fn then
    -- Get all palette files from the color_palettes directory using Neovim functions
    local palette_paths = vim.fn.globpath(vim.o.rtp, "lua/oasis/color_palettes/*.lua", false, true)
    
    for _, path in ipairs(palette_paths) do
      local name = path:match("[\\/]color_palettes[\\/](.+)%.lua$")
      if name and name ~= "init" then
        table.insert(palettes, name)
      end
    end
  else
    -- Fallback for testing outside Neovim - scan the local directory
    local function scan_directory(dir)
      local handle = io.popen('find "' .. dir .. '" -name "*.lua" -type f 2>/dev/null || ls "' .. dir .. '"/*.lua 2>/dev/null || echo ""')
      if not handle then return {} end
      
      local result = handle:read("*a")
      handle:close()
      
      local files = {}
      for line in result:gmatch("[^\r\n]+") do
        if line:match("%.lua$") then
          table.insert(files, line)
        end
      end
      return files
    end
    
    local palette_files = scan_directory("lua/oasis/color_palettes")
    for _, path in ipairs(palette_files) do
      local name = path:match("[\\/]color_palettes[\\/](.+)%.lua$") or path:match("([^/\\]+)%.lua$")
      if name and name ~= "init" then
        table.insert(palettes, name)
      end
    end
  end
  
  table.sort(palettes)
  return palettes
end

-- Helper function to export a single palette variant
local function export_palette(palette_name, format, output_dir)
  format = format or "lua"
  output_dir = output_dir or "colors"
  
  local lushwright = require("shipwright.transform.lush")
  
  -- Temporarily set the palette and load the theme (only in Neovim)
  local original_palette = vim and vim.g and vim.g.oasis_palette
  if vim and vim.g then
    vim.g.oasis_palette = palette_name
  end
  
  -- Load the colorscheme with the specified palette
  local ok, colorscheme_module = pcall(require, "oasis.theme_generator")
  if not ok then
    error(("Failed to load theme generator: %s"):format(colorscheme_module))
  end
  
  -- Load the palette
  local palette_ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)
  if not palette_ok then
    error(('Failed to load palette "%s": %s'):format(palette_name, palette))
  end
  
  -- Generate the colorscheme
  local colorscheme = colorscheme_module(palette)
  
  -- Determine output filename
  local filename_base = palette_name == "oasis" and "oasis" or ("oasis-" .. palette_name:gsub("^oasis_", ""))
  local output_file = ("%s/%s.%s"):format(output_dir, filename_base, format)
  
  if format == "lua" then
    -- Export as Lua
    run(
      colorscheme,
      lushwright.to_lua,
      { patchwrite, output_file, "-- PATCH_OPEN", "-- PATCH_CLOSE" }
    )
  elseif format == "vim" then
    -- Export as VimScript
    run(
      colorscheme,
      lushwright.to_vimscript,
      { append, { 
        "set background=dark", 
        ('let g:colors_name="%s"'):format(filename_base)
      }},
      { overwrite, output_file }
    )
  else
    error(("Unsupported format: %s"):format(format))
  end
  
  -- Restore original palette setting (only in Neovim)
  if vim and vim.g then
    vim.g.oasis_palette = original_palette
  end
  
  return output_file
end

-- Export all palettes in both Lua and VimScript formats
function M.export_all(formats, output_dir, verbose)
  formats = formats or {"lua"}
  output_dir = output_dir or "colors"
  verbose = verbose ~= false -- default to true
  
  local palettes = get_all_palettes()
  local exported_files = {}
  
  if verbose then
    print(("Found %d palette variants to export..."):format(#palettes))
  end
  
  for _, palette_name in ipairs(palettes) do
    if verbose then
      print(("Exporting palette: %s"):format(palette_name))
    end
    
    for _, format in ipairs(formats) do
      local success, result = pcall(export_palette, palette_name, format, output_dir)
      if success then
        table.insert(exported_files, result)
        if verbose then
          print(("  ✓ %s"):format(result))
        end
      else
        if verbose then
          print(("  ✗ Failed to export %s as %s: %s"):format(palette_name, format, result))
        end
      end
    end
  end
  
  if verbose then
    print(("Export complete! Generated %d files."):format(#exported_files))
  end
  
  return exported_files
end

-- Export a specific palette variant
function M.export_single(palette_name, format, output_dir, verbose)
  format = format or "lua"
  output_dir = output_dir or "colors"
  verbose = verbose ~= false
  
  if verbose then
    print(("Exporting single palette: %s as %s"):format(palette_name, format))
  end
  
  local success, result = pcall(export_palette, palette_name, format, output_dir)
  if success then
    if verbose then
      print(("✓ Exported: %s"):format(result))
    end
    return result
  else
    if verbose then
      print(("✗ Export failed: %s"):format(result))
    end
    error(result)
  end
end

-- Export all palettes in Lua format only (quick export)
function M.export_lua_all(output_dir, verbose)
  return M.export_all({"lua"}, output_dir, verbose)
end

-- Export all palettes in both Lua and VimScript formats
function M.export_both_formats(output_dir, verbose)
  return M.export_all({"lua", "vim"}, output_dir, verbose)
end

-- List all available palettes
function M.list_palettes()
  return get_all_palettes()
end

-- Direct execution when required
if not pcall(debug.getlocal, 4, 1) then
  -- This file was executed directly, not required
  print("Oasis Theme Exporter")
  print("Available commands:")
  print("  :lua require('_exported_themes.export_all').export_all()")
  print("  :lua require('_exported_themes.export_all').export_both_formats()")
  print("  :lua require('_exported_themes.export_all').list_palettes()")
end

return M