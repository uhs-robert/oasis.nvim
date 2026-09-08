#!/usr/bin/env lua
-- scripts/generate_extras_table.lua
-- Regenerates the extras table in README.md between the extras:start/end markers

package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")
local Satellites = require("oasis.satellites")

local readme_path = "README.md"
local start_marker = "<!-- extras:start -->"
local end_marker = "<!-- extras:end -->"

-- Display-name overrides for directories where the default word-split
-- transform does not produce the desired result.
local name_overrides = {
  css = "CSS",
  fzf = "FZF",
  iterm = "iTerm",
  vscode = "VS Code",
  tmux = "TMUX",
  psreadline = "PSReadLine",
  lazygit = "LazyGit",
  wezterm = "WezTerm",
  ["gemini-cli"] = "Gemini CLI",
  ["json-theme"] = "JSON-theme",
  ["lua-theme"] = "Lua-theme",
}

--- Build the default display name from a directory name
--- @param dir string Extras directory name (e.g., "dark-reader")
--- @return string display_name Words split on "-", capitalized, space-joined
local function default_display_name(dir)
  local words = {}
  for word in dir:gmatch("[^-]+") do
    table.insert(words, Utils.capitalize(word))
  end
  return table.concat(words, " ")
end

--- Find all extras tools by discovering their generator scripts
--- @return table dirs Sorted list of extras directory names
local function find_tools()
  local files = File.find("generate_*.lua", "extras")

  local seen = {}
  local dirs = {}
  for _, path in ipairs(files) do
    local dir = path:match("extras/([^/]+)/")
    if dir and not seen[dir] then
      seen[dir] = true
      table.insert(dirs, dir)
    end
  end

  table.sort(dirs)
  return dirs
end

--- Resolve the link text and URL for a tool's row
--- @param dir string Extras directory name
--- @return string text Link text
--- @return string url Link target
local function resolve_link(dir)
  local entry = Satellites.get(dir)
  if entry then
    local repo_name = entry.page:match("([^/]+)$")
    return repo_name, entry.page
  end
  return "extras/" .. dir, "extras/" .. dir
end

local function build_rows()
  local rows = {}
  for _, dir in ipairs(find_tools()) do
    local name = name_overrides[dir] or default_display_name(dir)
    local text, url = resolve_link(dir)
    table.insert(rows, { name = name, link = string.format("[%s](%s)", text, url) })
  end
  return rows
end

--- Render a padded markdown table
--- @param rows table List of { name, link } rows
--- @return string table_markdown Padded markdown table
local function render_table(rows)
  local header_name, header_link = "Tool", "Extra"

  local name_width = #header_name
  local link_width = #header_link
  for _, row in ipairs(rows) do
    name_width = math.max(name_width, #row.name)
    link_width = math.max(link_width, #row.link)
  end

  local function pad_row(name, link)
    return string.format("| %-" .. name_width .. "s | %-" .. link_width .. "s |", name, link)
  end

  local lines = {}
  table.insert(lines, pad_row(header_name, header_link))
  table.insert(lines, "| " .. string.rep("-", name_width) .. " | " .. string.rep("-", link_width) .. " |")
  for _, row in ipairs(rows) do
    table.insert(lines, pad_row(row.name, row.link))
  end

  return table.concat(lines, "\n")
end

local content = File.read(readme_path)
if not content then error("Failed to read " .. readme_path) end

local start_pos, start_end = content:find(start_marker, 1, true)
local end_start, end_pos = content:find(end_marker, 1, true)
if not start_pos or not end_start then error("Could not find extras markers in " .. readme_path) end

local rows = build_rows()
local table_markdown = render_table(rows)

-- Replace only the table itself (not the surrounding prose/closing line)
-- within the region between the markers.
local between = content:sub(start_end + 1, end_start - 1)
local table_start = between:find("| Tool", 1, true)
if not table_start then error("Could not find existing extras table between markers") end
local table_end = between:find("\n\n", table_start)
if not table_end then error("Could not find end of existing extras table") end

local new_between = between:sub(1, table_start - 1) .. table_markdown .. between:sub(table_end)
local new_content = content:sub(1, start_end) .. new_between .. content:sub(end_start)

File.write(readme_path, new_content)

print(string.format("Wrote %d extras row(s) to %s", #rows, readme_path))
