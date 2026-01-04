-- lua/oasis/lib/filesystem.lua
-- File system operations (copy, move, remove)

local FileSystem = {}

--- Copy file from source to destination
--- @param src string Source file path
--- @param dst string Destination file path
function FileSystem.copy(src, dst)
  os.execute("cp " .. src .. " " .. dst)
end

--- Move file from source to destination
--- @param src string Source file path
--- @param dst string Destination file path
function FileSystem.move(src, dst)
  os.execute("mv " .. src .. " " .. dst)
end

--- Remove file
--- @param path string File path
function FileSystem.remove(path)
  os.execute("rm -f " .. path)
end

return FileSystem
