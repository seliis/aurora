do
  dofile("Scripts/ScriptingSystem.lua")

  DCS_INSTALLED_PATH = lfs.currentdir()
  DCS_SAVEDGAME_PATH = lfs.writedir()

  package.path = string.format("%s;%s%s", package.path, DCS_INSTALLED_PATH, "/LuaSocket/?.lua")
  package.cpath = string.format("%s;%s%s", package.cpath, DCS_INSTALLED_PATH, "/LuaSocket/?.dll")

  aurora_miz = {}
  aurora_miz.json = loadfile("Scripts/JSON.lua")()
  aurora_miz.print = function(msg) env.info(string.format("AuroraMiz: %s", msg)) end

  dofile("Scripts/AuroraMiz/AuroraMizModel.lua")
  dofile("Scripts/AuroraMiz/AuroraMizNetwork.lua")
  dofile("Scripts/AuroraMiz/AuroraMizAllotter.lua")

  aurora_miz.print("ReadDone: MissionScripting.lua")
end