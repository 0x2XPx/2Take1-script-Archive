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
    feature.max_i = tonumber(config:getValue(configValueName.."_max"))
    feature.value_i = tonumber(config:getValue(configValueName))
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