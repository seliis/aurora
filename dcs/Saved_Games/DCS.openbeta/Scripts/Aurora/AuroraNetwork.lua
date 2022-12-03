do
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

  local function decodeReceivedData(receivedData)
    if receivedData == "getPlayerCoordinate" then
      runMizFunc("getPlayerCoordinate")
    end
  end

  local function makeToJson(data, dataType)
    local jsonData = {
      dataFrom = "DCS_GUI_ENV",
      dataType = dataType,
      dataBody = nil
    }
    
    if dataType == aurora.dataType.event then
      jsonData.dataBody = data
    end

    -- Is need to make code for error exception?
    return aurora.json:encode(jsonData)
  end

  local function sendData(data)
    if aurora.network.udp then
      aurora.network.udp:send(data)
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
    sendData(makeToJson("onSimulationStart", aurora.dataType.event))
  end

  function aurora.network.onSimulationFrame()
    if aurora.network.udp then
      local data, err = aurora.network.udp:receive(); if err then
        return
      end

      decodeReceivedData(data)
      aurora.print(data)
    end
  end

  function aurora.network.onSimulationStop()
    if aurora.network.udp then
      aurora.network.udp:send("disconnect")
      runMizFunc("quitConnection")
      aurora.network.udp:close()
      aurora.network.udp = nil
      aurora.print("UDP Disconnected")
    end
  end

  DCS.setUserCallbacks(aurora.network)
  aurora.print("ReadDone: AuroraNetwork.lua")
end