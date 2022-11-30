do
  local function requestToMission(funcName, jsonString)
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

  function aurora.network.onSimulationStart()
    aurora.network.udp = aurora.network.socket.udp(); if aurora.network.udp == nil then
      aurora.print("Can't Get Unconnected UDP Object")
    else
      aurora.network.udp:settimeout(0)
      aurora.network.udp:setsockname("*", 0)
      aurora.network.udp:setpeername("127.0.0.1", 3000)
    end

    aurora.print("UDP Connected")
    aurora.network.udp:send("ping")
  end

  function aurora.network.onSimulationFrame()
    if aurora.network.udp then
      local data, err = aurora.network.udp:receive(); if err then
        return
      end

      aurora.print(data)

      local testTable = {
        key = "value"
      }

      if data == "pong" then
        local testJson = aurora.json:encode(testTable)
        requestToMission("sendData", testJson)
        aurora.network.udp:send("I'm Aurora")
      end
    end
  end

  function aurora.network.onSimulationStop()
    if aurora.network.udp then
      aurora.network.udp:send("disconnect")
      requestToMission("quitConnection")
      aurora.network.udp:close()
      aurora.network.udp = nil
      aurora.print("UDP Disconnected")
    end
  end

  DCS.setUserCallbacks(aurora.network)
  aurora.print("ReadDone: AuroraNetwork.lua")
end