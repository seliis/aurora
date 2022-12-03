do
  dofile("Scripts/ScriptingSystem.lua")

  DCS_INSTALLED_PATH = lfs.currentdir()
  DCS_SAVEDGAME_PATH = lfs.writedir()

  package.path = string.format("%s;%s%s", package.path, DCS_INSTALLED_PATH, "/LuaSocket/?.lua")
  package.cpath = string.format("%s;%s%s", package.cpath, DCS_INSTALLED_PATH, "/LuaSocket/?.dll")

  aurora_miz = {}
  aurora_miz.json = loadfile("Scripts/JSON.lua")()
  aurora_miz.print = function(msg) env.info(string.format("AuroraMiz: %s", msg)) end

  aurora_miz.network = {
    socket = require("socket"),
    udp = nil
  }

  aurora_miz.network.udp = aurora_miz.network.socket.udp(); if aurora_miz.network.udp == nil then
    aurora_miz.print("Can't Get Unconnected UDP Object")
  else
    aurora_miz.network.udp:settimeout(0)
    aurora_miz.network.udp:setsockname("*", 0)
    aurora_miz.network.udp:setpeername("127.0.0.1", 3000)
    aurora_miz.print("UDP Connected")
  end

  function sendData(jsonData)
    if aurora_miz.network.udp then
      aurora_miz.network.udp:send(string.format("AuroraMiz: %s", jsonData))
    else
      aurora_miz.print("Can't Find UDP Object (function: sendData)")
    end
  end

  function makeToJson(data, dataType)
    if dataType == nil then dataType = "common" end; return aurora_miz.json:encode({
      header = dataType, body = data
    })
  end

  function getPlayerCoordinate()
    local coord = Unit.getByName("UNIT_TEST"):getPoint()
    sendData(makeToJson(coord, "point"))
  end

  function quitConnection()
    if aurora_miz.network.udp then
      aurora_miz.network.udp:send("disconnect")
      aurora_miz.network.udp:close()
      aurora_miz.network.udp = nil
      aurora_miz.print("UDP Disconnected")
    else
      aurora_miz.print("Can't Find UDP Object (function: quitConnection)")
    end
  end

  aurora_miz.print("ReadDone: MissionScripting.lua")
end