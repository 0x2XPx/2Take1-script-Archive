local fpsCrashAttampt

local vehicleNearByStorage = {}

function createProtectionMenu(zModderMain,config)
  local protectionSubMenu = menu.add_feature("Protection", "parent", zModderMain.id, nil)

  fpsCrashAttampt = menu.add_feature("FPS Crash", "toggle", protectionSubMenu.id, fpsCrashCheck)
  fpsCrashAttampt.threaded = false
end

function fpsCrashCheck()
  local limit = 10  
  for i in ipairs(vehicle.get_all_vehicles())do    
    local veh = vehicle.get_all_vehicles()[i]
    if vehicleNearByStorage[entity.get_entity_model_hash(veh)] ~= nil then
      vehicleNearByStorage[entity.get_entity_model_hash(veh)] = vehicleNearByStorage[entity.get_entity_model_hash(veh)]+1
    else
      --hinzufügen mit 1
      vehicleNearByStorage[entity.get_entity_model_hash(veh)] = 1
    end    
    --check limits
    if (vehicleNearByStorage[entity.get_entity_model_hash(veh)] > limit) 
    and ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())) ~= veh then
      pos = entity.get_entity_coords(veh)
      pos.y = 20000
      network.request_control_of_entity(veh)
      entity.set_entity_coords_no_offset(veh,pos)
      entity.freeze_entity(veh,true)
      ui.notify_above_map("Removed Possible FPS Crash Vehicle " .. entity.get_entity_model_hash(veh),"ZeroMenu Protections",140)
    end
  end
  vehicleNearByStorage = {}
if fpsCrashAttampt.on then    
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end