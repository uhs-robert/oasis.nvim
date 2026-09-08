-- lua/oasis/satellites.lua
-- Registry of satellite repos that receive generated theme output

local Satellites = {}

Satellites.registry = {
  tmux = {
    url = "git@github.com:uhs-robert/tmux-oasis.git",
    page = "https://github.com/uhs-robert/tmux-oasis",
    dir = "../tmux-oasis",
    dest = "",
  },
}

--- Get a satellite registry entry
--- @param tool string Tool name (e.g., "tmux")
--- @return table|nil entry Registry entry or nil if unknown
function Satellites.get(tool)
  return Satellites.registry[tool]
end

--- Get the sibling checkout path for a satellite tool
--- @param tool string Tool name
--- @return string|nil dir Checkout path or nil if unknown
function Satellites.checkout_path(tool)
  local entry = Satellites.get(tool)
  return entry and entry.dir or nil
end

--- Resolve the output root for a generator, redirecting into a satellite checkout when active
--- @param tool string Tool name
--- @param default_base string Default output base directory (e.g., "extras/tmux")
--- @return string output_root Directory generators should write into
function Satellites.output_root(tool, default_base)
  local entry = Satellites.get(tool)
  if entry and os.getenv("OASIS_SYNC_TARGET") == tool then
    if entry.dest ~= nil and entry.dest ~= "" then
      return entry.dir .. "/" .. entry.dest
    else
      return entry.dir
    end
  end
  return default_base
end

return Satellites
