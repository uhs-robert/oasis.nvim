#!/usr/bin/env lua
-- extras/run_all_generators.lua
-- Orchestrates running all Oasis theme generators
-- Automatically discovers generators and skips those requiring manual input

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")
local System = require("oasis.lib.system")

-- Generators to skip (require interactive input or special handling)
local skip_list = {
  -- ["generate_vimiumc.lua"] = true,
}

local function find_generators()
  local files = File.find("generate_*.lua", "extras")

  local generators = {}
  for _, path in ipairs(files) do
    local filename = path:match("([^/]+)$")
    if not skip_list[filename] then
      -- Extract generator name from path (e.g., extras/zed/generate_zed.lua -> Zed)
      local dir = path:match("extras/([^/]+)/")
      if dir then
        table.insert(generators, {
          name = Utils.capitalize(dir),
          script = path,
          dir = dir,
        })
      end
    end
  end

  return generators
end

-- Warn about generated non-text files that are not git-ignored, scoped to
-- themes/ and src/ so tracked binary assets (e.g. icon PNGs) don't trip it.
local function find_binary_warnings(dir)
  local warnings = {}

  local git_ok = System.execute("git rev-parse --is-inside-work-tree >/dev/null 2>&1")
  local file_ok = System.execute("which file >/dev/null 2>&1")
  if not (git_ok and file_ok) then return warnings end

  local text_mimes = {
    ["application/json"] = true,
    ["application/xml"] = true,
    ["inode/x-empty"] = true,
  }

  for _, scan_dir in ipairs({ "extras/" .. dir .. "/themes", "extras/" .. dir .. "/src" }) do
    local files = File.find("*", scan_dir)
    if #files > 0 then
      local list_path = os.tmpname()
      File.write(list_path, table.concat(files, "\n") .. "\n")

      local ignored = {}
      local ignored_output = System.capture(string.format("git check-ignore --stdin < '%s'", list_path))
      for path in ignored_output:gmatch("[^\n]+") do
        ignored[path] = true
      end

      local mime_output = System.capture(string.format("file --mime-type --brief -f '%s'", list_path))
      local index = 0
      for mime in mime_output:gmatch("[^\n]+") do
        index = index + 1
        local path = files[index]
        if path and not ignored[path] and not mime:match("^text/") and not text_mimes[mime] then
          table.insert(warnings, path)
        end
      end

      os.remove(list_path)
    end
  end

  return warnings
end

print("=== Oasis Generator Orchestrator ===\n")

local generators = find_generators()

if #generators == 0 then
  print("Error: No generators found in extras/ directory")
  return
end

print(string.format("Found %d generator(s) to run\n", #generators))

local total_success = 0
local total_errors = 0
local total_binary_warnings = 0
local results = {}

for _, gen in ipairs(generators) do
  print(string.format("Running %s generator...", gen.name))
  local output = System.capture("lua " .. gen.script)

  -- Extract success/error counts from output
  local success_count = output:match("Success: (%d+)")
  local error_count = output:match("Errors: (%d+)")

  if success_count and error_count then
    success_count = tonumber(success_count)
    error_count = tonumber(error_count)
    total_success = total_success + success_count
    total_errors = total_errors + error_count

    local binary_warnings = find_binary_warnings(gen.dir)
    total_binary_warnings = total_binary_warnings + #binary_warnings

    results[#results + 1] = {
      name = gen.name,
      success = success_count,
      errors = error_count,
      binary_warnings = #binary_warnings,
    }

    print(string.format("  ✓ %s: %d themes generated, %d errors", gen.name, success_count, error_count))
    for _, path in ipairs(binary_warnings) do
      print(string.format("  ! Warning: %s is non-text and not git-ignored", path))
    end
  else
    print(string.format("  ✗ %s: Failed to parse output", gen.name))
    total_errors = total_errors + 1
  end
  print()
end

print("=== Summary ===")
for _, result in ipairs(results) do
  print(
    string.format(
      "%-11s  Success: %2d  Errors: %d  Binary warnings: %d",
      result.name,
      result.success,
      result.errors,
      result.binary_warnings
    )
  )
end
print()
print(
  string.format(
    "Total: %d themes generated, %d errors, %d binary warnings",
    total_success,
    total_errors,
    total_binary_warnings
  )
)

-- Show skipped generators
if next(skip_list) then
  print("\nSkipped generators (require manual input):")
  for filename, _ in pairs(skip_list) do
    print(string.format("  - %s", filename))
  end
end
print()

local table_output, table_ok = System.capture("lua scripts/generate_extras_table.lua")
if table_ok then
  print("README extras table: " .. table_output:gsub("%s+$", ""))
else
  print("README extras table: failed to regenerate\n" .. table_output)
end
