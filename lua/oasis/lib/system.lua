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
