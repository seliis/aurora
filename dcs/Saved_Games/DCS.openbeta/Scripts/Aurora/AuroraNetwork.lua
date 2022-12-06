do
  aurora.network = {
    socket = require("socket"),
    udp = nil
  }
  
  local function runMizFunc(funcName, jsonString)
    local funcString; if jsonString then
      -- CAUTION: NEED TO WRAP %s WITH SINGLE QUOTES OR OCCUR TYPE ERROR (JSON STRING READ AS TABLE OBJECT IN RECEIVER)
      funcString = string.format("%s('%s')", funcName, jsonString)
    else
      funcString = string.format("%s()", funcName)
    end
    -- CAUTION: NEED TO WRAP %s WITH BRACKET OR JSON STRING WILL NOT BE SENT (QUOTES OVERLAPPING PROBLEM)
    local codeString = string.format("return a_do_script([[%s]])", funcString)
    net.dostring_in("mission", codeString)
  end

  local function decodeDatagramData(datagramData)
    aurora.print(datagramData)
    if datagramData.dataType == "AuroraDataTypes.REQUEST" then
      runMizFunc(string.format("aurora_miz.allotter:%s", datagramData.dataBody.targetFunction))
    end
  end

  local function makeToJson(dataType, dataBody)
    aurora.model.auroraData.dataType = dataType
    aurora.model.auroraData.dataBody = dataBody

    -- Is need to make code for error exception?
    return aurora.json:encode(aurora.model.auroraData)
  end

  local function sendData(jsonString)
    if aurora.network.udp then
      aurora.network.udp:send(jsonString)
    else
      aurora.print("Can't Find UDP Object (function: sendData)")
    end
  end

  function aurora.network.onSimulationStart()
    aurora.network.udp = aurora.network.socket.udp(); if aurora.network.udp == nil then
      aurora.print("Can't Get Unconnected UDP Object")
    else
      aurora.network.udp:settimeout(0)
      aurora.network.udp:setsockname("*", 0)
      aurora.network.udp:setpeername("127.0.0.1", 3000)
    end

    aurora.print("UDP Connected")
    sendData(makeToJson(aurora.model.auroraDataTypes.event, {eventName = "onSimulationStart"}))
  end

  function aurora.network.onSimulationFrame()
    if aurora.network.udp then
      local data, err = aurora.network.udp:receive(); if err then
        return
      end

      aurora.print(data)
      aurora.print(aurora.json:decode(data))
      decodeDatagramData(aurora.json:decode(data))
    end
  end

  function aurora.network.onSimulationStop()
    if aurora.network.udp then
      sendData(makeToJson(aurora.model.auroraDataTypes.event, {eventName = "onSimulationStop"}))
      runMizFunc("aurora_miz.network:quitConnection")
      aurora.network.udp:close()
      aurora.network.udp = nil
      aurora.print("UDP Disconnected")
    end
  end

  DCS.setUserCallbacks(aurora.network)
  aurora.print("ReadDone: AuroraNetwork.lua")
end