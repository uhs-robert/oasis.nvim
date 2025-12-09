#!/usr/bin/env lua
-- extras/run_all_generators.lua
-- Orchestrates running all Oasis theme generators
-- Automatically discovers generators and skips those requiring manual input

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")
local File = require("oasis.lib.file")
local System = require("oasis.lib.system")

-- Generators to skip (require interactive input or special handling)
local skip_list = {
	["generate_vimiumc.lua"] = true,
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
					name = utils.capitalize(dir),
					script = path,
				})
			end
		end
	end

	return generators
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

		results[#results + 1] = {
			name = gen.name,
			success = success_count,
			errors = error_count,
		}

		print(string.format("  ✓ %s: %d themes generated, %d errors", gen.name, success_count, error_count))
	else
		print(string.format("  ✗ %s: Failed to parse output", gen.name))
		total_errors = total_errors + 1
	end
	print()
end

print("=== Summary ===")
for _, result in ipairs(results) do
	print(string.format("%-10s  Success: %2d  Errors: %d", result.name, result.success, result.errors))
end
print()
print(string.format("Total: %d themes generated, %d errors", total_success, total_errors))

-- Show skipped generators
if next(skip_list) then
	print("\nSkipped generators (require manual input):")
	for filename, _ in pairs(skip_list) do
		print(string.format("  - %s", filename))
	end
end
print()
