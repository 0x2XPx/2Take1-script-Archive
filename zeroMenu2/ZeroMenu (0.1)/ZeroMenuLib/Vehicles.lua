
--local speed = 5000000
local speed = 15000
local distance = 50

function loadVehicleMenu(parent,config)
  
  

  vehiclesubmenu = menu.add_feature("Vehicle", "parent", parent.id, nil)
  vehiclesubmenu.threaded = false


  slow = menu.add_feature("Slow", "action", vehiclesubmenu.id, slowVehicle)
  slow.threaded = false 
  
  tune = menu.add_feature("Tune", "action", vehiclesubmenu.id, tuneVehicle)
  tune.threaded = false
  
  drift = menu.add_feature("Drift", "action", vehiclesubmenu.id, tuneDriftVehicle)
  drift.threaded = false

  maxSpeed = menu.add_feature("Remove Max Speed", "action", vehiclesubmenu.id, removeMaxSpeedVehicle)
  maxSpeed.threaded = false

end

function tuneVehicle()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

  if veh ~= nil then
    if not network.has_control_of_entity(veh) then
      network.request_control_of_entity(veh)  
    end 
    entity.set_entity_max_speed(veh,speed)
    vehicle.modify_vehicle_top_speed(veh,speed)
    vehicle.set_vehicle_engine_torque_multiplier_this_frame(veh,speed)
    
  end
end

function removeMaxSpeedVehicle()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

  if veh ~= nil then
    if not network.has_control_of_entity(veh) then
      network.request_control_of_entity(veh)  
    end 
    entity.set_entity_max_speed(veh,speed)
    
  end
end

function tuneDriftVehicle()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

  if veh ~= nil then
    if not network.has_control_of_entity(veh) then
      network.request_control_of_entity(veh)  
    end 
    entity.set_entity_max_speed(veh,30)
    vehicle.modify_vehicle_top_speed(veh,200)
    
  end
end
function slowVehicle()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

  if veh ~= nil then
    if not network.has_control_of_entity(veh) then
      network.request_control_of_entity(veh)  
    end 
    entity.set_entity_max_speed(veh,1)
    vehicle.modify_vehicle_top_speed(veh,1)
    
  end
end

function loadVehicleSetting(parent,config)  
  vesettings = menu.add_feature("Vehicle Settings", "parent", parent.id, nil)
  --Speedsettings
  torgue = menu.add_feature("New Torque", "autoaction_value_i", vesettings.id, function(f)
    if f.value_i > speed then
      speed = speed+1000
    else
      speed = speed-1000
    end   
    torgue.value_i = speed
  end)
  torgue.max_i = 10000000000
  torgue.value_i = speed
  torgue.threaded = false
  
  config:saveIfNotExist("vehicletorguemax",10000000000)
  config:saveIfNotExist("vehicletorgue",speed)
  
  --distanceTP.max_i = 10000
  --distanceTP.value_i = distance
  torgue.max_i = tonumber(config:getValue("vehicletorguemax"))
  torgue.value_i = tonumber(config:getValue("vehicletorgue"))
  torgue.threaded = false
  
  
  ignoreplayers = menu.add_feature("Ignore Players", "toggle", vesettings.id, nil)
  ignoreplayers.threaded = false
  
  config:saveIfNotExist("vehicleignoreplayers",false)
  ignoreplayers.on = config:isFeatureEnabled("vehicleignoreplayers")  
end