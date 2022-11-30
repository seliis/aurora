do
  local dir = string.format("%s%s", lfs.writedir(), "Scripts/Aurora/")
  
  dofile(dir .. "AuroraMain.lua")
  dofile(dir .. "AuroraNetwork.lua")
end