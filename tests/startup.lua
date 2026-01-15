-- tests/startup.lua
--- Startup performance test for oasis.nvim
---
--- Measures and reports timing statistics for the oasis.nvim colorscheme
--- initialization phases: require, setup, palette loading, and apply.
---
--- @usage nvim -l tests/startup.lua
--- @usage RUNS=100 nvim -l tests/startup.lua
--- @env RUNS Number of iterations (default: 100)

--- Number of test iterations
--- @type integer
local RUNS = tonumber(vim.env.RUNS) or 100

-------------------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------------------

--- Measure execution time of a function
--- @param fn fun(): any Function to measure
--- @return any result Return value of the function
--- @return number elapsed Elapsed time in milliseconds
local function measure(fn)
  local t0 = vim.uv.hrtime()
  local result = fn()
  local elapsed = (vim.uv.hrtime() - t0) / 1e6
  return result, elapsed
end

--- Calculate statistical summary of timing values
--- @param values number[] Array of numeric values
--- @return number mean Arithmetic mean
--- @return number median Median value
--- @return number stddev Sample standard deviation
local function stats(values)
  table.sort(values)
  local count = #values
  local sum = 0
  for _, v in ipairs(values) do
    sum = sum + v
  end
  local mean = count > 0 and (sum / count) or 0
  local median = count % 2 == 1 and values[(count + 1) / 2] or ((values[count / 2] + values[count / 2 + 1]) / 2)
  local variance = 0
  for _, v in ipairs(values) do
    local diff = v - mean
    variance = variance + diff * diff
  end
  local stddev = count > 1 and math.sqrt(variance / (count - 1)) or 0
  return mean, median, stddev
end

--- Print formatted statistics for a timing category
--- @param label string Name of the measurement category
--- @param values number[] Array of timing values in milliseconds
local function print_stats(label, values)
  local mean, median, stddev = stats(values)
  print(string.format("  %-30s %6.2fms (median %.2fms, σ %.2fms)", label, mean, median, stddev))
end

-------------------------------------------------------------------------------
-- Benchmark Functions
-------------------------------------------------------------------------------

--- Add plugin to runtimepath
local function setup_runtimepath()
  local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h")
  vim.opt.rtp:prepend(root)
end

--- Clear all oasis modules from package.loaded cache
--- Ensures fresh require() calls for accurate timing measurements
local function clear_oasis_cache()
  for name, _ in pairs(package.loaded) do
    if name == "oasis" or name:match("^oasis%.") then package.loaded[name] = nil end
  end
end

--- @class BenchmarkTimes
--- @field require_time number Time to require oasis module (ms)
--- @field setup_time number Time to run setup() (ms)
--- @field palette_time number Time to load palette module (ms)
--- @field apply_time number Time to run apply() (ms)
--- @field total_time number Total time for all operations (ms)

--- Run a single benchmark iteration
--- @return BenchmarkTimes times Timing data for this iteration
local function run_single_iteration()
  clear_oasis_cache()
  vim.g.oasis_profile = true

  local total_t0 = vim.uv.hrtime()

  local _, require_time = measure(function()
    require("oasis")
  end)

  local _, setup_time = measure(function()
    require("oasis").setup()
  end)

  local _, palette_time = measure(function()
    local Config = require("oasis.config")
    local palette_name = Config.get_palette_name() or "oasis_lagoon"
    local module_name = "oasis.color_palettes." .. palette_name

    package.loaded[module_name] = nil
    local ok, palette = pcall(require, module_name)
    if not ok then return end

    if palette.dark then
      local mode = vim.o.background == "light" and "light" or "dark"
      palette = palette[mode]
    end

    Config.apply_palette_overrides(palette, palette_name)
  end)

  local _, apply_time = measure(function()
    require("oasis").apply(nil)
  end)

  local total_time = (vim.uv.hrtime() - total_t0) / 1e6

  return {
    require_time = require_time,
    setup_time = setup_time,
    palette_time = palette_time,
    apply_time = apply_time,
    total_time = total_time,
  }
end

--- @class BenchmarkResults
--- @field require number[] Timing data for require("oasis")
--- @field setup number[] Timing data for setup()
--- @field palette number[] Timing data for palette loading
--- @field apply number[] Timing data for apply()
--- @field total number[] Timing data for total execution

--- Run all benchmark iterations
--- @param runs integer Number of iterations to run
--- @return BenchmarkResults results Aggregated timing data
local function run_benchmarks(runs)
  local results = {
    require = {},
    setup = {},
    palette = {},
    apply = {},
    total = {},
  }

  for _ = 1, runs do
    local times = run_single_iteration()
    table.insert(results.require, times.require_time)
    table.insert(results.setup, times.setup_time)
    table.insert(results.palette, times.palette_time)
    table.insert(results.apply, times.apply_time)
    table.insert(results.total, times.total_time)
  end

  return results
end

--- Print benchmark results to stdout
--- @param results BenchmarkResults Aggregated timing data
--- @param runs integer Number of iterations that were run
local function print_results(results, runs)
  print("Oasis startup breakdown (mean over " .. runs .. " runs):")
  print(string.rep("-", 67))
  print_stats("require oasis", results.require)
  print_stats("setup()", results.setup)
  print_stats("load_palette_module", results.palette)
  print_stats("apply()", results.apply)
  print_stats("TOTAL", results.total)
end

-------------------------------------------------------------------------------
-- Main
-------------------------------------------------------------------------------

--- Main orchestrator
local function main()
  setup_runtimepath()
  local results = run_benchmarks(RUNS)
  print_results(results, RUNS)
end

main()
