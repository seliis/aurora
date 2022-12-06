do
  aurora_miz.allotter = {}

  function aurora_miz.allotter:getCampaignInitData()
    for _, zoneData in pairs(mist.DBs.zonesByNum) do
      local latitude, longitude, altitude = coord.LOtoLL({zoneData.x, zoneData.y, 0})
      
      aurora_miz.model.zoneData.name = zoneData.name
      aurora_miz.model.zoneData.radius = zoneData.radius
      aurora_miz.model.zoneData.latitude = latitude
      aurora_miz.model.zoneData.longitude = longitude

      aurora_miz.network:sendData(aurora_miz.network:makeToJson(aurora_miz.model.auroraDataTypes.zone, aurora_miz.model.zoneData))
      -- table.insert(zoneDatas, mist.utils.deepCopy(aurora_miz.model.zoneData))
    end

    -- table.sort(zoneDatas, function(a, b) return a.name < b.name end)
  end

  aurora_miz.print("ReadDone: AuroraMizAllotter.lua")
end