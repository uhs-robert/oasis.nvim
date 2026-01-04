-- scripts/screenshot_generator/lib/kitty_controller.lua
-- Kitty terminal controller for screenshot generation

local Config = require("scripts.screenshot_generator.config")
local File = require("oasis.lib.file")
local FileSystem = require("oasis.lib.filesystem")
local System = require("oasis.lib.system")

local KittyController = {}
KittyController.__index = KittyController

--- Shell escape function
--- @param str string String to escape
--- @return string Escaped string safe for shell
local function shell_escape(str)
  return "'" .. str:gsub("'", "'\\''") .. "'" -- wrap in single quotes and escape any single quotes inside
end

--- Create a new KittyController instance
--- @param instance_name string Unique name for this kitty instance
--- @return table KittyController instance
function KittyController.new(instance_name)
  local self = setmetatable({}, KittyController)
  self.instance_name = instance_name
  self.socket_path = "/tmp/kitty-" .. instance_name
  return self
end

--- Launch kitty terminal instance
function KittyController:launch()
  if File.exists(self.socket_path) then FileSystem.remove(self.socket_path) end

  self:spawn_instance()
  local attempts = self:wait_for_socket()
  local comm_attempts = self:wait_for_communication()

  print(string.format("  Kitty socket ready after %.1fs", (attempts * 0.5) + (comm_attempts * 0.5)))
end

--- Spawn kitty instance with tmux
function KittyController:spawn_instance()
  -- Build command with proper quoting (Ruby's spawn doesn't need this, but shell does)
  local cmd = string.format(
    "kitty --title '%s' --name '%s' "
      .. "-o allow_remote_control=yes --listen-on 'unix:%s' "
      .. "tmux -2 -f '%s' new-session > /dev/null 2>&1 &",
    self.instance_name,
    self.instance_name,
    self.socket_path,
    Config.TMUX_CONFIG
  )
  System.execute(cmd)
end

--- Wait for kitty socket to be created
--- @param max_attempts number|nil Maximum attempts (default: 20)
--- @return number Number of attempts used
function KittyController:wait_for_socket(max_attempts)
  max_attempts = max_attempts or 20
  local attempts = 0

  while not File.exists(self.socket_path) and attempts < max_attempts do
    System.sleep(0.5)
    attempts = attempts + 1
  end

  if not File.exists(self.socket_path) then
    error(string.format("Kitty socket not created after %.1fs: %s", max_attempts * 0.5, self.socket_path))
  end

  return attempts
end

--- Wait for kitty to respond on socket
--- @param max_attempts number|nil Maximum attempts (default: 10)
--- @return number Number of attempts used
function KittyController:wait_for_communication(max_attempts)
  max_attempts = max_attempts or 10
  local attempts = 0

  while attempts < max_attempts do
    if System.execute(string.format("kitten @ --to unix:%s ls > /dev/null 2>&1", self.socket_path)) then
      return attempts
    end

    System.sleep(0.5)
    attempts = attempts + 1
  end

  error(string.format("Kitty not responding on socket after %.1fs: %s", max_attempts * 0.5, self.socket_path))
end

--- Send keys to kitty terminal
--- @param text string Text to send
--- @param enter boolean|nil Whether to press Enter after text (default: true)
function KittyController:send_keys(text, enter)
  if enter == nil then enter = true end

  local payload = enter and (text .. "\n") or text
  local cmd = string.format("kitten @ --to unix:%s send-text %s", self.socket_path, shell_escape(payload))
  System.execute(cmd)
  System.sleep(0.5)
end

--- Close kitty instance
function KittyController:close()
  System.execute(string.format("kitten @ --to unix:%s close-window --self", self.socket_path))
  System.sleep(0.5)

  if File.exists(self.socket_path) then FileSystem.remove(self.socket_path) end
  System.sleep(0.5)
end

return KittyController
