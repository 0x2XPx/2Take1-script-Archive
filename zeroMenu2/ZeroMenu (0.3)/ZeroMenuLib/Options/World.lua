require("ZeroMenuLib/Util/Util")

function createWorldMenu(zModderMain,config)

  local worldSubMenu = menu.add_feature("World", "parent", zModderMain.id, nil)

  resetWaves = menu.add_feature("Reset Wave Intensity", "action", worldSubMenu.id, resetWaveIntensity)
  resetWaves.threaded = false
  
  setWaves = menu.add_feature("Set Wave Intensity", "action", worldSubMenu.id, setWaveIntensity)
  setWaves.threaded = false
    
  setWaves = menu.add_feature("Clear Objects", "action", worldSubMenu.id, clearObjects)
  setWaves.threaded = false
  
  setWaves = menu.add_feature("Clear Vehicles", "action", worldSubMenu.id, clearVehicles)
  setWaves.threaded = false
  
  setWaves = menu.add_feature("Clear Peds", "action", worldSubMenu.id, clearPeds)
  setWaves.threaded = false
  
  setWaves = menu.add_feature("Clear Cops", "action", worldSubMenu.id, clear_area_of_cops)
  setWaves.threaded = false

end

function setWaveIntensity()

  local r, s = input.get("Enter wave intensity", water.get_waves_intensity(), 64, 3)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end

  water.set_waves_intensity(s)

end

function resetWaveIntensity()
  water.reset_waves_intensity()
  ui.notify_above_map("wave intensity reseted","ZeroMenu",140)
end


function clearObjects()
  local r, s = input.get("Enter clear distance", 20, 64, 3)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end
  gameplay.clear_area_of_objects(entity.get_entity_coords(player.get_player_ped(player.player_id())),s,0)
  gameplay.clear_area_of_objects(entity.get_entity_coords(player.get_player_ped(player.player_id())),s,2)
  gameplay.clear_area_of_objects(entity.get_entity_coords(player.get_player_ped(player.player_id())),s,6)
  gameplay.clear_area_of_objects(entity.get_entity_coords(player.get_player_ped(player.player_id())),s,16)
  gameplay.clear_area_of_objects(entity.get_entity_coords(player.get_player_ped(player.player_id())),s,17)
  ui.notify_above_map("Cleared area of " .. s .. " from Objects","ZeroMenu",140) 
end

function clearVehicles()
  local r, s = input.get("Enter clear distance", 20, 64, 3)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end
  gameplay.clear_area_of_vehicles(entity.get_entity_coords(player.get_player_ped(player.player_id())),s,false,false,false,false,false)
  ui.notify_above_map("Cleared area of " .. s .. " from Vehicles","ZeroMenu",140) 
end

function clearPeds()
  local r, s = input.get("Enter clear distance", 20, 64, 3)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end
  gameplay.clear_area_of_peds(entity.get_entity_coords(player.get_player_ped(player.player_id())),s,true)

  ui.notify_above_map("Cleared area of " .. s .. " from Peds","ZeroMenu",140) 
end

function clear_area_of_cops()
  local r, s = input.get("Enter clear distance", 20, 64, 3)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end
   gameplay.clear_area_of_cops(
    entity.get_entity_coords(
      player.get_player_ped(
        player.player_id()
      )
    ),
    s,
    true)
  ui.notify_above_map("Cleared area of " .. s .. " from objects","ZeroMenu",140)
end