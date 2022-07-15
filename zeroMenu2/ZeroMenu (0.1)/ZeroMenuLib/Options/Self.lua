local selfMain
local wander

function createSelfMenuEntry(parent,config)
  selfMain = menu.add_feature("Self", "parent", parent.id, nil)
  wander = menu.add_feature("Wander Streets (Vehicle)", "toggle", selfMain.id, wanderStreet)
  wander.threaded = false
  
  config = config
  config:saveIfNotExist("wander",false)  
  
  if config:isFeatureEnabled("wander") then
    wander.on = true
  end  
end

function wanderStreet()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  local temppedped = player.get_player_ped(player.player_id());
  if veh ~= nil then
    if not ai.is_task_active(temppedped,151)then
      ai.task_vehicle_drive_wander(temppedped,veh,200,0)
    end  
   end
   if wander.on then    
    return HANDLER_CONTINUE
   else
    ped.clear_ped_tasks_immediately(temppedped)
	  vehicle.set_vehicle_forward_speed(veh, 2)
   return HANDLER_POP
  end
end

