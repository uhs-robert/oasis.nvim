-- lua/oasis/lib/directory.lua
-- Directory operations

local Directory = {}

--- Create directory (recursive, like mkdir -p)
--- @param path string Directory path
function Directory.create(path)
  os.execute("mkdir -p " .. path)
end

--- Remove directory (recursive, like rm -rf)
--- @param path string Directory path
function Directory.remove(path)
  os.execute("rm -rf " .. path)
end

return Directory
