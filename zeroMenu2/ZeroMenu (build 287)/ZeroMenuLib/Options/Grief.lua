local parentModderValues

local display_god,display_god_vehicle,display_Speed,display_distance,setHeliBladeSpeed,display_vehicle

trackedPlayer = {}

function createGriefEntry(config)
  local parent = menu.add_player_feature("ZeroMenu Grief","parent",0,nil).id
  menu.add_player_feature("Vehicle Speed Grief","action",parent,speedVehicleGriefPlayer)
  menu.add_player_feature("Vehicle Speed Upgrade Grief","action",parent,speedVehicleUpgradeGriefPlayer)
  menu.add_player_feature("Vehicle Door Grief","action",parent,doorVehicleGriefPlayer)

  menu.add_player_feature("Push Grief","toggle",parent,pushAwayGrief)
  menu.add_player_feature("Disable Vehicle","toggle",parent,disableVehicle)
  menu.add_player_feature("Net event Log","toggle",parent,logNetEventsAndBlock)
  menu.add_player_feature("Give Armour","action",parent,bulletproofPlayer)
  parentModderValues = menu.add_player_feature("ZeroMenu Playerdata","parent",0,displayModderValues).id
  griefscream = menu.add_player_feature("Scream Grief","toggle",parent,screamGriefPlayer)
  griefcontrol = menu.add_player_feature("Control Grief","toggle",parent,controlVehicleGriefPlayer)  
  menu.add_player_feature("On-Screen Track","toggle",parentModderValues,mark_player_onscreen)
  
  menu.add_player_feature("Set Heli Blade Speed", "action", parent, setHeliBladeSpeedG)
  
  menu.add_player_feature("Attach PTFX", "action", parent, attach_ptfx_to_player)
  menu.add_player_feature("Flare and Smoke", "action", parent, flareAndSmoke)
  
  menu.add_player_feature("Send Troll SMS", "action", parent, sendTrollSms)
  menu.add_player_feature("Send Virus String SMS", "action", parent, sendVirusTestSms)
  menu.add_player_feature("Send Virus String SMS", "toggle", parent, sendVirusTestSms)
  
  menu.add_player_feature("Atomizer Grief", "toggle", parent, electroGrief)
  
  
  trackedPlayer = {}
end

function electroGrief(feat,slot)
  if(feat.on) then
    --2461879995  - Eletric Fence
    --0x3656C8C1 - stungun
    --local bullet = 0x7F7497E5
    local bullet = 0xAF3696A1
    --bullet = 0x3656C8C1
    --bullet = 0xAF3696A1
    --bullet = 0x3656C8C1 -- stungun not working ?
    
    --bullet = 0x4DD2DC56 -- smoke launcher
    --bullet = 0xAF3696A1 -- atomizer
    
    local pos = player.get_player_coords(slot)
    gameplay.shoot_single_bullet_between_coords(pos,pos,1,bullet,slot,true,true,10)
    --gameplay.shoot_single_bullet_between_coords(start,endvalue,damage,weapon,owner,audible,invaluevisible,speed)
    --menu.notify("Atomizer Grief","ZeroMenu",5,140)
    system.wait(1000)
  end
  
  if(feat.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function mark_player_onscreen(feat,slot)
  if(feat.on) then
    trackedPlayer[player.get_player_name(slot)] = 1
  else
    trackedPlayer[player.get_player_name(slot)] = 0
  end
  
end

function displayModderValues(feat,slot)
  if(playerList ~= nil) then
    if(playerList[player.get_player_name(slot)] ~= nil) then
      if(playerList[player.get_player_name(slot)]['godTime'] ~= nil) then
        
        if(display_god == nil) then
          display_god = menu.add_player_feature("God: " .. playerList[player.get_player_name(slot)]['godTime'],"action",parentModderValues,nil).id
        end
        menu.get_player_feature(display_god).feats[slot+1].name = "God: " .. playerList[player.get_player_name(slot)]['godTime']  
      end
      
      if(playerList[player.get_player_name(slot)]['godvehicle'] ~= nil) then
        if(display_god_vehicle == nil) then
          display_god_vehicle = menu.add_player_feature("God Vehicle: " .. playerList[player.get_player_name(slot)]['godvehicle'],"action",parentModderValues,nil).id
        end
        menu.get_player_feature(display_god_vehicle).feats[slot+1].name = "God Vehicle: " .. playerList[player.get_player_name(slot)]['godvehicle']
        
      end
      if(playerList[player.get_player_name(slot)]['lastSecondDistanceMoved'] ~= nil) then
        if(display_Speed == nil) then
          local ms = round(playerList[player.get_player_name(slot)]['lastSecondDistanceMoved'],0)
          display_Speed = menu.add_player_feature("Speed: " .. ms .. " (" .. (ms*3.6) .. " km/h)","action",parentModderValues,nil).id
        end
        local ms = round(playerList[player.get_player_name(slot)]['lastSecondDistanceMoved'],0)
        menu.get_player_feature(display_Speed).feats[slot+1].name = "Speed: " .. ms .. " (" .. (ms*3.6) .. " km/h)"
      end
      if(playerList[player.get_player_name(slot)]['distanceMoved'] ~= nil) then        
        if(display_distance == nil) then
          display_distance = menu.add_player_feature("Distance Moved: " .. playerList[player.get_player_name(slot)]['distanceMoved'],"action",parentModderValues,nil).id
        end
        menu.get_player_feature(display_distance).feats[slot+1].name = "Distance Moved: " .. playerList[player.get_player_name(slot)]['distanceMoved']
      end
      if(ped.is_ped_in_any_vehicle(player.get_player_ped(slot))) then
        local vm = require("ZeroMenuLib/enums/VehicleMapper")
        local hash = entity.get_entity_model_hash(ped.get_vehicle_ped_is_using(player.get_player_ped(slot)))
        local vehicleName = vm.GetNameFromHash(hash)
        if(vehicleName == nil) then vehicleName = "Unknown Vehicle" end
        if(display_vehicle == nil) then
          display_vehicle = menu.add_player_feature("Vehicle: " .. vehicleName,"action",parentModderValues,nil).id
        end
        menu.get_player_feature(display_vehicle).feats[slot+1].name = "Vehicle: " .. vehicleName        
      else
        if(display_vehicle == nil) then
          display_vehicle = menu.add_player_feature("Vehicle: None","action",parentModderValues,nil).id
        end
        menu.get_player_feature(display_vehicle).feats[slot+1].name = "Vehicle: None"
      end
     
      
    end
  end  
end

function bulletproofPlayer(feat, slot)

  local target = player.get_player_ped(slot)
   
  local boneIndex_arm = entity.get_entity_bone_index_by_name(target,"RB_L_ArmRoll")
  local boneIndex_head = entity.get_entity_bone_index_by_name(target,"IK_Head")
  
  
  if(streaming.has_model_loaded(1141389967)) then  
    --Back
    local subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    local offset = v3(0,0.25,0)
    local rot = v3(0,0,180)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    local offset = v3(0,0.25,-0.5)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    local offset = v3(0,0.25,0.35)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
        
    --back
    offset = v3(0,-0.25,0)
    rot = v3(0,45,0)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    offset = v3(0,-0.25,-0.5)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)    
    offset = v3(0,-0.25,0.35)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    
    --back
    offset = v3(0,-0.25,0)
    rot = v3(0,-45,0)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    offset = v3(0,-0.25,-0.5)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)    
    offset = v3(0,-0.25,0.35)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    
    offset = v3(0.25,0,0)
    rot = v3(0,0,90)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    offset = v3(0.25,0,-0.5)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)    
    offset = v3(0.25,0,0.35)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    
    offset = v3(-0.25,0,0)
    rot = v3(0,0,-90)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    offset = v3(-0.25,0,-0.5)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)    
    offset = v3(-0.25,0,0.35)
    subject = object.create_object(1141389967,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
    
    offset = v3(0,0,0.5)
    rot = v3(90,180,270)
    subject = object.create_object(-992802541,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(subject,target,boneIndex_arm,offset,rot,false,true,false,0,true)
  else
    streaming.request_model(1141389967)
    return HANDLER_CONTINUE
  end
  return HANDLER_POP
end
function speedVehicleGriefPlayer(feat, slot)
  if slot ~= player.player_id()  then
    if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
      local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(slot))
      if veh ~= nil then
        if not network.has_control_of_entity(veh) then
          network.request_control_of_entity(veh)
        end
        entity.set_entity_max_speed(veh,1)
        vehicle.modify_vehicle_top_speed(veh,1)
        vehicle.set_vehicle_engine_torque_multiplier_this_frame(veh,1)
        menu.notify("Set Max Speed to 1 for slot " .. slot ,"ZeroMenu",5,140)
      else
        menu.notify("Target isn't inside a Vehicle","ZeroMenu",5,140)
      end
    else
      menu.notify("Invalid Player","ZeroMenu",5,140)
    end
  else
    menu.notify("I wouldn't grief yourself!","ZeroMenu",5,140)
  end
end


local logThisPlayer = {}

function logNetEventsAndBlock(feat,slot)

  if(feat.on) then
    logThisPlayer[player.get_player_name(slot)] = 1
  else
    logThisPlayer[player.get_player_name(slot)] = 0
  end
 hook.register_net_event_hook(netEventCallBack)
 hook.register_script_event_hook(scriptEventCallBack)

end

function netEventCallBack(slot,target,eventID)
  if target == player.player_id() then
    if (logThisPlayer[player.get_player_name(slot)] ~= nil and logThisPlayer[player.get_player_name(slot)]  == 1) then
      local eventToInt = require("ZeroMenuLib/enums/EventToInt")
      local eventname = eventToInt[eventID]
      if eventname ~= nil then
        menu.notify("blocked event " .. eventname .. " from " .. player.get_player_name(slot),"ZeroMenu",5,140)
        logEvent("blocked event " .. eventname .. " from " .. player.get_player_name(slot))
      else
        menu.notify("blocked event " .. eventID .. " from " .. player.get_player_name(slot),"ZeroMenu",5,140)
        logEvent("blocked event " .. eventID .. " from " .. player.get_player_name(slot))
      end

      return false
    end
  end
end

function scriptEventCallBack(slot, target, params, count)
  if target == player.player_id() then
    if (logThisPlayer[player.get_player_name(slot)] ~= nil and logThisPlayer[player.get_player_name(slot)]  == 1) then
        menu.notify("blocked script event " .. count .. " from " .. player.get_player_name(slot),"ZeroMenu",5,140)
      logEvent("blocked script event (size: " .. count .. ") from " .. player.get_player_name(slot))
      local cnt = 0
      for k in pairs(params) do
        menu.notify("paramteter " .. cnt .. " = " .. k,"ZeroMenu",5,140)
        logEvent("paramteter " .. cnt .. " = " .. k)
        cnt = cnt+1
      end
      return false
    end
  end
end
local chatEventPath =os.getenv('APPDATA') .. "\\PopstarDevs\\2Take1Menu\\scripts\\ZeroMenuLib\\data\\event.log"

function logEvent(message)
  if not utils.file_exists(chatEventPath) then
   -- utils.make_dir(chatEventPath)
    file = io.open(chatEventPath, "w")
    file:write("#Created using 1337Zeros ZeroMenu\n")
    file:close()
  end

  file = io.open(chatEventPath, "a")
  file:write(os.date("[%d/%m/%Y %H:%M:%S]") .. " " .. message ..  "\n")
  file:close()
end

function disableVehicle(feat,slot)
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(slot))
  if veh ~= nil then
    if not network.has_control_of_entity(veh) then
      network.request_control_of_entity(veh)
    end
    vehicle.set_vehicle_out_of_control(veh,false,false)
    entity.set_entity_max_speed(veh,1)
    vehicle.modify_vehicle_top_speed(veh,1)
    vehicle.set_vehicle_engine_torque_multiplier_this_frame(veh,1)
    vehicle.set_vehicle_engine_on(veh,false,true,true)
  end
  if feat.on then
      return HANDLER_CONTINUE
    else
      return HANDLER_POP
    end
end

local lastSpeed = 0

function pushAwayGrief(feat,slot)
  local rotation = v3()
    rotation.z = 180
    rotation.y = 0
    rotation.x = 0
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(slot))
  if veh ~= nil then
    if not network.has_control_of_entity(veh) then
      network.request_control_of_entity(veh)
    end
  if lastSpeed == 0 then
    local r, s = input.get("Enter new Torque", 10000, 64, 3)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end
    lastSpeed = s
  end
    entity.set_entity_max_speed(veh,10000)
    vehicle.set_vehicle_out_of_control(veh,false,false)
    entity.set_entity_rotation(veh,rotation)
    vehicle.set_vehicle_forward_speed(veh, lastSpeed)
    if feat.on then
      return HANDLER_CONTINUE
    else
      return HANDLER_POP
    end
  end
end

function controlVehicleGriefPlayer(feat, slot)
  if slot ~= player.player_id()  then
    if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
      local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(slot))
      if veh ~= nil then
        if not network.has_control_of_entity(veh) then
          network.request_control_of_entity(veh)
        end
        entity.set_entity_max_speed(veh,1)
        vehicle.set_vehicle_out_of_control(veh,false,false)
        menu.notify("Set out of control for slot " .. player.get_player_name(slot) ,"ZeroMenu",5,140)        
      else
        menu.notify("Target isn't inside a Vehicle" ,"ZeroMenu",5,140)     
      end
    else
        menu.notify("Invalid Player" ,"ZeroMenu",5,140)     
    end
  else
        menu.notify("I wouldn't grief yourself!","ZeroMenu",5,140)     
  end

  if feat.on then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end
function speedVehicleUpgradeGriefPlayer(feat, slot)
  if slot ~= player.player_id()  then
    if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
      local r, s = input.get("Enter new Torque", 1000000, 64, 3)
      if r == 1 then return HANDLER_CONTINUE end
      if r == 2 then return HANDLER_POP end

      local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(slot))
      if veh ~= nil then
        if not network.has_control_of_entity(veh) then
          network.request_control_of_entity(veh)
        end
        entity.set_entity_max_speed(veh,s)
        vehicle.modify_vehicle_top_speed(veh,1000000)
        vehicle.set_vehicle_engine_torque_multiplier_this_frame(veh,s)
        menu.notify("Set Max Speed to " .. s,"ZeroMenu",5,140)  
      else
        menu.notify("Target isn't inside a Vehicle","ZeroMenu",5,140)  
      end
    else
        menu.notify("Invalid Player","ZeroMenu",5,140)  
    end
  else
        menu.notify("I wouldn't grief yourself!","ZeroMenu",5,140)  
  end
 --if grief_upgrade.on then
  --  return HANDLER_CONTINUE
  --else
  --  return HANDLER_POP
  --end
end

function doorVehicleGriefPlayer(feat, slot)
  if slot ~= player.player_id()  then
    if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
      local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(slot))
      if veh ~= nil then
        if not network.has_control_of_entity(veh) then
          network.request_control_of_entity(veh)
        end
        vehicle.set_vehicle_doors_locked(veh,4)
        menu.notify("Locked doors of vehicle","ZeroMenu",5,140)  
      else
        menu.notify("Target isn't inside a Vehicle","ZeroMenu",5,140)  
      end
    else
        menu.notify("Invalid Player","ZeroMenu",5,140)  
    end
  else
        menu.notify("I wouldn't grief yourself!","ZeroMenu",5,140)  
  end
 --if grief_door.on then
  --  return HANDLER_CONTINUE
  --else
  --  return HANDLER_POP
  --end
end

function screamGriefPlayer(feat, slot)
  if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
    -- AUDIO::PLAY_SOUND_FROM_COORD(-1, "Horn", sub_f5aa(), "DLC_Apt_Yacht_Ambient_Soundset", 0, 500, 0);
    audio.play_sound_from_coord(-1,"Prison_Finale_Buzzard_Rocket_Player", entity.get_entity_coords(player.get_player_ped(slot)), "DLC_HEISTS_GENERIC_SOUNDS", true, 5, true)
    audio.play_sound_from_coord(-1,"CREAK_01", entity.get_entity_coords(player.get_player_ped(slot)), "DOCKS_HEIST_SETUP_SOUNDS", true, 5, true)

    audio.play_sound_from_coord(-1,"Horn", entity.get_entity_coords(player.get_player_ped(slot)), "DLC_Apt_Yacht_Ambient_Soundset", true, 5, false)
    audio.play_sound_from_coord(-1,"SHUTTER_FLASH", entity.get_entity_coords(player.get_player_ped(slot)), "CAMERA_FLASH_SOUNDSET", true, 5, false)

    menu.notify("Horned him","ZeroMenu",5,140)  
  else
    menu.notify("Invalid Player","ZeroMenu",5,140)  
  end
  if feat.on then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function chaseVehicle(feat, slot)

  if ped.get_vehicle_ped_is_using(player.get_player_ped(slot)) ~= nil then

    local r, s = input.get("Chase distance",100, 64, 3)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end

    ai.set_task_vehicle_chase_ideal_persuit_distance(player.get_player_ped(player.get_player_ped(player.player_id()),s))
    ai.task_vehicle_chase(player.get_player_ped(player.get_player_ped(player.player_id())),slot)
  end
end

function setHeliBladeSpeedG(feat, slot)
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(slot))
  local r, s = input.get("Enter new Blade Speed", 0, 64, 3)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end

  if veh ~= nil and streaming.is_model_a_heli(entity.get_entity_model_hash(veh)) then
    vehicle.set_heli_blades_speed(veh,s)
  end
    return HANDLER_POP
end


local dict = nil
local flame = nil
local scale = nil

function attach_ptfx_to_player(feat,slot)  
  local entity = player.get_player_ped(slot)

  
  if(dict == nil) then
    local r, s = input.get("Enter Dictonary", "core", 64, 0)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end    
    dict = s  
  end
    
  if(flame == nil) then
    local r, s = input.get("Enter PTFX", "ent_amb_candle_flame", 64, 0)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end      
    flame = s
  end
  if(scale == nil) then
    local r, s = input.get("Enter Scale Value for PTFX", 5.0, 64, 5)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end      
    scale = s
  end
  attachPTFXToEntity(entity,dict,flame,scale)    
  flame = nil
  dict = nil
  scale = nil
  return HANDLER_POP 
end

function attachPTFXToEntity(entity,dict,ptfx,scale)
  graphics.set_next_ptfx_asset(dict)
  while not graphics.has_named_ptfx_asset_loaded(dict) do
    graphics.request_named_ptfx_asset(dict)
    system.wait(0)
    return HANDLER_CONTINUE 
  end
  local offset = v3(0,0,0)
  local rot = v3(0,0,0)
  graphics.start_networked_ptfx_looped_on_entity(ptfx,entity,offset,rot,scale)
end

function flareAndSmoke(feat,slot)
  local entity = player.get_player_ped(slot)
  --proj_flare_trail
  --exp_grd_grenade_smoke
  attachPTFXToEntity(entity,"core","proj_flare_trail",5.0)  
    attachPTFXToEntity(entity,"core","exp_grd_grenade_smoke",1.0)  
    attachPTFXToEntity(entity,"core","exp_grd_grenade_smoke",2.0) 
    attachPTFXToEntity(entity,"core","exp_grd_grenade_smoke",3.0)  
    attachPTFXToEntity(entity,"core","exp_grd_grenade_smoke",4.0)  
    attachPTFXToEntity(entity,"core","exp_grd_grenade_smoke",5.0)  
    menu.notify("Attached PTFX to " .. player.get_player_name(slot),"ZeroMenu",5,140)
end

function sendTrollSms(feat,slot)
player.send_player_sms(slot,"test\ntest<br>\test")
  player.send_player_sms(slot,
  "░░░░░▄▄▄▄▀▀▀▀▀▀▀▀▄▄▄▄▄▄░░░░░░░"..
  "░░░░░█░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░▀▀▄░░░░"..
  "░░░░█░░░▒▒▒▒▒▒░░░░░░░░▒▒▒░░█░░░"..
  "░░░█░░░░░░▄██▀▄▄░░░░░▄▄▄░░░░█░░"..
  "░▄▀▒▄▄▄▒░█▀▀▀▀▄▄█░░░██▄▄█░░░░█░"..
  "█░▒█▒▄░▀▄▄▄▀░░░░░░░░█░░░▒▒▒▒▒░█"..
  "█░▒█░█▀▄▄░░░░░█▀░░░░▀▄░░▄▀▀▀▄▒█"..
  "░█░▀▄░█▄░█▀▄▄░▀░▀▀░▄▄▀░░░░█░░█░"..
  "░░█░░░▀▄▀█▄▄░█▀▀▀▄▄▄▄▀▀█▀██░█░░"..
  "░░░█░░░░██░░▀█▄▄▄█▄▄█▄████░█░░░"..
  "░░░░█░░░░▀▀▄░█░░░█░█▀██████░█░░"..
  "░░░░░▀▄░░░░░▀▀▄▄▄█▄█▄█▄█▄▀░░█░░"..
  "░░░░░░░▀▄▄░▒▒▒▒░░░░░░░░░░▒░░░█░"..
  "░░░░░░░░░░▀▀▄▄░▒▒▒▒▒▒▒▒▒▒░░░░█░"..
  "░░░░░░░░░░░░░░▀▄▄▄▄▄░░░░░░░░█░░")
  menu.notify("Send Trollface SMS to" ..  player.get_player_name(slot),"ZeroMenu",5,140)
end

function sendVirusTestSms(feat,slot)
  player.send_player_sms(slot,"X5O!P%@AP[4\\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*")
  menu.notify("Send Trollface SMS to" ..  player.get_player_name(slot),"ZeroMenu",5,140)
end

function sendVirusTestSms(feat,slot)
  player.send_player_sms(slot,"X5O!P%@AP[4\\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*")
  menu.notify("Send Trollface SMS to" ..  player.get_player_name(slot),"ZeroMenu",5,140)
  if(feat.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end