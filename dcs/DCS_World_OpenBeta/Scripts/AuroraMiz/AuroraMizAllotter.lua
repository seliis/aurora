do
  aurora_miz.allotter = {}

  function aurora_miz.allotter:getCampaignInitData()
    for _, zoneData in ipairs(mist.DBs.zonesByNum) do
      local latitude, longitude, altitude = coord.LOtoLL(zoneData.point)
      
      aurora_miz.model.zoneData.name = zoneData.name
      aurora_miz.model.zoneData.radius = zoneData.radius
      aurora_miz.model.zoneData.latitude = latitude
      aurora_miz.model.zoneData.longitude = longitude

      aurora_miz.network:sendData(aurora_miz.network:makeToJson(aurora_miz.model.auroraDataTypes.zone, aurora_miz.model.zoneData))
    end
  end

  aurora_miz.print("ReadDone: AuroraMizAllotter.lua")
end