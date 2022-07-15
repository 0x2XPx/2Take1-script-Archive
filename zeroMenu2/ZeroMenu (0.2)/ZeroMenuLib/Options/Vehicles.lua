require("ZeroMenuLib/Util/Util")

local speed = 15000
local distance = 50
local askedInput = false

local lastVehicle = 0

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
  
  setMaxSpeed = menu.add_feature("Set Max Speed", "action", vehiclesubmenu.id, setMaxSpeedVehicle)
  setMaxSpeed.threaded = false

  setHeliBladeSpeed = menu.add_feature("Set Heli Blade Speed", "action", vehiclesubmenu.id, setHeliBladeSpeed)
  setHeliBladeSpeed.threaded = false

  vehicleParachute = menu.add_feature("Open Vehicle Parachute", "action", vehiclesubmenu.id, openVehicleParachute)
  vehicleParachute.threaded = false
  
  freezeVehicleOnExitVar = createConfigedMenuOption("Freeze Vehicle on exit","toggle",vehiclesubmenu.id,freezeVehicleOnExit,config,"freezeVehOnExit",false,nil)
  --freezeVehicleOnExitVar = menu.add_feature("Freeze Vehicle on exit", "toggle", vehiclesubmenu.id, freezeVehicleOnExit)
  freezeVehicleOnExitVar.threaded = false
  
  noClipVehicleOnExitVar = createConfigedMenuOption("NoClip Vehicle on exit (stay nearby)","toggle",vehiclesubmenu.id,NoClipVehicleOnExit,config,"noClipVehOnExit",false,nil)
  --noClipVehicleOnExitVar = menu.add_feature("NoClip Vehicle on exit", "toggle", vehiclesubmenu.id, NoClipVehicleOnExit)
  noClipVehicleOnExitVar.threaded = false

  
end

function tuneVehicle()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  local r, s = input.get("Enter new Torque", 100, 64, 0)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end
    
  speed = s
  if veh ~= nil then
    if not network.has_control_of_entity(veh) then
      network.request_control_of_entity(veh)  
    end 
    entity.set_entity_max_speed(veh,speed*1000)
    vehicle.modify_vehicle_top_speed(veh,speed)
    vehicle.set_vehicle_engine_torque_multiplier_this_frame(veh,speed)
    entity.get_entity_model_hash(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
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

function setMaxSpeedVehicle()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

  local r, s = input.get("Enter new Torque", 540, 64, 0)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end

  if veh ~= nil then
    if not network.has_control_of_entity(veh) then
      network.request_control_of_entity(veh)  
    end 
    entity.set_entity_max_speed(veh,s)
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

function openVehicleParachute()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

  if veh ~= nil then
    vehicle.set_vehicle_parachute_active(veh,true)
    ui.notify_above_map("opening parachute...","ZeroMenu",140)
  end
end

function setHeliBladeSpeed()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  local r, s = input.get("Enter new Torque", 0, 64, 0)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end
  
  if veh ~= nil then
    vehicle.set_heli_blades_speed(veh,s)
    ui.notify_above_map("Set Blade Speed to " .. s ,"ZeroMenu",140)
  end
end



function freezeVehicleOnExit()

  if lastVehicle == 0 then
    lastVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  elseif lastVehicle ~= 0 and ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())) == 0 then
    entity.freeze_entity(lastVehicle,true)
  elseif lastVehicle == ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())) then
    lastVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    entity.freeze_entity(lastVehicle,false)
  end  
  if freezeVehicleOnExitVar.on then    
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function NoClipVehicleOnExit()
if lastVehicle == 0 then
    lastVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  elseif lastVehicle ~= 0 and ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())) == 0 then
    entity.freeze_entity(lastVehicle,true)
  elseif lastVehicle == ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())) then
    lastVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    entity.freeze_entity(lastVehicle,false)
  end  

    for i in ipairs(vehicle.get_all_vehicles())do
      local tempveh = vehicle.get_all_vehicles()[i]
      
      if not network.has_control_of_entity(tempveh) then
        network.request_control_of_entity(tempveh)  
      end 
      entity.set_entity_no_collsion_entity(tempveh,lastVehicle,false)
    end      
  
  if noClipVehicleOnExitVar.on then    
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end
