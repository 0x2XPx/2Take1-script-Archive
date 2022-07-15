local eModderDetectionFlags = require("ZeroMenuLib/enums/ModderDetectionFlag")

function createConfigedMenuOption(name,type,parent,script_function,config,configValueName,defaultValue,defaultValueMax)
  local feature = menu.add_feature(name,type,parent,script_function)    
  config:saveIfNotExist(configValueName,defaultValue)
  config:registerConfigedFunction(configValueName,feature,type)
  if type == "toggle" then
    if config:isFeatureEnabled(configValueName) then
      feature.on = true
    end
  elseif type == "autoaction_value_i" then
    config:saveIfNotExist(configValueName.."_max",defaultValue)  
    feature.max = tonumber(config:getValue(configValueName.."_max"))
    feature.value = tonumber(config:getValue(configValueName))
  end
  return feature;
end


function isPlayerModder(slot)
  return player.get_player_modder_flags(slot) ~= 0
end

function starts_with(str, start)
   return str:sub(1, #start) == start
end

function getSlotFromName(name)
  for slot = 0, 31 do
    if player.is_player_valid(slot) then
      local tempName = player.get_player_name(slot)
      if starts_with(tempName,name) then
        return slot
      end
    end
  end
  return nil
end

function dirVector(p45, h45, d)
  h45 = math.rad((h45 - 180) * -1)
  p45.x = p45.x + (math.sin(h45) * -d)
  p45.y = p45.y + (math.cos(h45) * -d)
  return p45
end

function formatIP(ip)
  return string.format("%i.%i.%i.%i", (ip >> 24) & 0xff, ((ip >> 16) & 0xff), ((ip >> 8) & 0xff), ip & 0xff)
end

function calculateDistanceMovedBetweenCoords(oldCord,newCord)

  local difX = (newCord['x'] - oldCord['x'])^2
  local difY = (newCord['y'] - oldCord['y'])^2
  local difZ = (newCord['z'] - oldCord['z'])^2
  local distance = math.sqrt(difX + difY + difZ)  
  return distance
end