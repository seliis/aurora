do
  DCS_INSTALLED_PATH = lfs.currentdir()
  DCS_SAVEDGAME_PATH = lfs.writedir()

  package.path = string.format("%s;%s%s", package.path, DCS_INSTALLED_PATH, "/LuaSocket/?.lua")
  package.cpath = string.format("%s;%s%s", package.cpath, DCS_INSTALLED_PATH, "/LuaSocket/?.dll")

  -- have to make table structure in here or occur hooking error.
  -- do not divide below table structure to each related files.

  aurora = {}
  aurora.json = require("json")
  aurora.print = function(msg) log.write("Aurora", log.INFO, msg) end
<<<<<<< HEAD
  
  aurora.dataType = {
    event = "EVENT"
  }

  aurora.network = {
    socket = require("socket"),
    udp = nil
  }
=======
>>>>>>> f/dcs

  aurora.print("ReadDone: AuroraMain.lua")
end