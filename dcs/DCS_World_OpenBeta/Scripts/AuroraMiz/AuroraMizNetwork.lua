do
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

  function aurora_miz.network:makeToJson(dataType, dataBody)
    aurora_miz.model.auroraData.dataType = dataType
    aurora_miz.model.auroraData.dataBody = dataBody

    return aurora_miz.json:encode(aurora_miz.model.auroraData)
  end

  function aurora_miz.network:sendData(jsonString)
    if aurora_miz.network.udp then
      aurora_miz.network.udp:send(jsonString)
    else
      aurora_miz.print("Can't Find UDP Object (function: sendData)")
    end
  end

  function aurora_miz.network:quitConnection()
    if aurora_miz.network.udp then
      self:sendData(self:makeToJson(aurora_miz.model.auroraDataTypes.notify, {content = "quitConnection"}))
      aurora_miz.network.udp:close()
      aurora_miz.network.udp = nil
      aurora_miz.print("UDP Disconnected")
    else
      aurora_miz.print("Can't Find UDP Object (function: quitConnection)")
    end
  end

  aurora_miz.print("ReadDone: AuroraMizNetwork.lua")
end