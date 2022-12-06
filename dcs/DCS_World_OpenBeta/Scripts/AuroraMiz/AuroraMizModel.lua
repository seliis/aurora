do
  aurora_miz.model = {}

  aurora_miz.model.auroraData = {
    dataFrom = "DCS_MIZ_ENV",
    dataType = nil,
    dataBody = nil
  }

  aurora_miz.model.auroraDataTypes = {
    coordinate = "COORDINATE",
    notify = "NOTIFY",
    zone = "ZONE"
  }

  aurora_miz.model.zoneData = {
    name = nil,
    radius = nil,
    latitude = nil,
    longitude = nil
  }

  aurora_miz.print("ReadDone: AuroraMizModel.lua")
end