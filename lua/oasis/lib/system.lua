-- lua/oasis/lib/system.lua
-- System and shell operations

local System = {}

--- Execute a shell command
--- @param cmd string Command to execute
--- @return boolean success True if command succeeded (exit code 0)
function System.execute(cmd)
  local success = os.execute(cmd)
  return success == 0 or success == true
end

--- Execute a shell command and capture combined stdout/stderr
--- @param cmd string Command to run
--- @return string output Command output
--- @return boolean success True when exit code is zero
function System.capture(cmd)
  local handle = io.popen(cmd .. " 2>&1")
  if not handle then return "", false end
  local output = handle:read("*a")
  local ok = handle:close()
  return output, ok == true
end

--- Sleep for specified seconds
--- @param seconds number Number of seconds to sleep (can be fractional)
function System.sleep(seconds)
  os.execute("sleep " .. tostring(seconds))
end

--- Get user's home directory
--- @return string? Home directory path (nil if HOME not set)
function System.get_home_dir()
  return os.getenv("HOME")
end

return System
