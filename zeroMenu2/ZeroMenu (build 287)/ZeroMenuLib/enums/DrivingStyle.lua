local driveStyle = {
  {id = "0", Name="angry"}, -- stop for vehicles
  {id = "1", Name="stop for vehicles"}, -- stop for vehicles
  {id = "2", Name="stop for peds"}, -- stop for peds
  {id = "4", Name="avoid vehicles"}, -- avoid vehicles
  {id = "8", Name="avoid empty vehicles"}, -- avoid empty vehicles
  {id = "16", Name="avoid peds"}, -- avoid peds
  {id = "32", Name="avoid objects"}, -- avoid objects  
  {id = "64", Name="unknown(64)"}, -- ?
  {id = "128", Name="stop at traffic lights"}, -- stop at traffic lights
  {id = "256", Name="use turn signals"}, -- use turn signals 
  {id = "512", Name="allow wrong way"}, -- allow going wrong way (only does it if the correct lane is full, will try to reach the correct lane again as soon as possible)
  {id = "1024", Name="reverse"}, -- drive in reverse (AI is not very good at it though, and will give up after a while)
  {id = "2048", Name="unknown(2048)"},-- ? 
  {id = "4096", Name="unknown(4096)"}, -- ? 
  {id = "8192", Name="unknown(8192)"}, -- ? 
  {id = "16384", Name="unknown(16384)"}, -- ? 
  {id = "32768", Name="unknown(32768)"}, -- ? 
  {id = "65536", Name="unknown(65536)"},-- ? 
  {id = "131072", Name="unknown(131072)"},-- ? 
  {id = "262144", Name="shortest path"}, -- Take shortest path (Removes most pathing limits, the driver even goes on dirtroads)
  {id = "262144", Name="avoid offroad"}, -- Probably avoid offroad?
  {id = "1048576", Name="unknown(1048576)"}, -- ? 
  {id = "2097152", Name="unknown(2097152)"}, -- ? 
  {id = "4194304", Name="Ignore roads"}, -- Ignore roads (Uses local pathing, only works within 200~ meters around the player)
  {id = "8388608", Name="unknown(8388608)"},-- ? 
  {id = "16777216", Name="Ignore all pathing"}, -- Ignore all pathing (Goes straight to destination)
  {id = "33554432", Name="unknown(33554432)"}, -- ? 
  {id = "67108864", Name="unknown(67108864)"}, -- ? 
  {id = "134217728", Name="unknown(134217728)"}, -- ? 
  {id = "268435456", Name="unknown(268435456)"},-- ? 
  {id = "536870912", Name="avoid highways"},"", -- avoid highways when possible (will use the highway if there is no other way to get to the destination)
  {id = "1073741824", Name="unknown(1073741824)"}-- ? "
}
function driveStyle.getDriveStyleList()
  local styles = {}
  for i=1,#driveStyle do
    local style = driveStyle[i]
    styles[i] = style.Name
  end
  return styles
end

return driveStyle