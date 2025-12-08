-- lua/oasis/lib/file.lua
-- File content operations

local File = {}

--- Check if a file exists
--- @param path string File path
--- @return boolean True if file exists
function File.exists(path)
	local success = os.execute(string.format("test -e '%s'", path))
	return success == 0 or success == true
end

--- Read file contents
--- @param path string File path
--- @return string|nil content File content or nil on error
function File.read(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local content = f:read("*all")
	f:close()
	return content
end

--- Write content to file
--- @param path string File path
--- @param content string Content to write
function File.write(path, content)
	local f = io.open(path, "w")
	if not f then
		error("Failed to write file: " .. path)
	end
	f:write(content)
	f:close()
end

--- Get file size in bytes
--- @param path string File path
--- @return number File size in bytes (0 if file doesn't exist)
function File.size(path)
	local f = io.popen("stat -c%s " .. path .. " 2>/dev/null")
	if not f then
		return 0
	end
	local size = f:read("*all")
	f:close()
	return tonumber(size) or 0
end

return File
