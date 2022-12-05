do
  aurora_miz.allotter = {}

  function aurora_miz.allotter:getCampaignInitData()
    aurora_miz.network:sendData(aurora_miz.network:makeToJson("getCampaignInitData", aurora_miz.model.auroraDataTypes.notify))
  end

  aurora_miz.print("ReadDone: AuroraMizAllotter.lua")
end