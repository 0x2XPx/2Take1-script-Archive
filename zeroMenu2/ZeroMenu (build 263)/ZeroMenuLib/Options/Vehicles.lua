require("ZeroMenuLib/Util/Util")

local soundsM = require("ZeroMenuLib/enums/Sounds")

local speed = 15000
local distance = 50
local askedInput = false

local lastVehicle = 0

local vehicleToGear = {}
local gearMaxSpeed = {}
local currentGear =  1
local lastGearChange = 10
local gearToPercentSpeed = {}
gearToPercentSpeed[0] = 10
gearToPercentSpeed[1] = 31
gearToPercentSpeed[2] = 60
gearToPercentSpeed[3] = 105
gearToPercentSpeed[4] = 112
gearToPercentSpeed[5] = 150
gearToPercentSpeed[6] = 180
gearToPercentSpeed[7] = 200
local gearFeat,gearX,gearY,gearOverlay,gearOverlay_speed,gearOverlay_rpm,overlay_light,soundHorn,ropeListFeature,hornSpam,gravityForAll

local gravityValue = nil

function loadVehicleMenu(parent,config)
  

  vehiclesubmenu = menu.add_feature("Vehicle", "parent", parent.id, nil)


  slow = menu.add_feature("Slow", "action", vehiclesubmenu.id, slowVehicle)
  
  tune = menu.add_feature("Tune", "action", vehiclesubmenu.id, tuneVehicle)
  
  drift = menu.add_feature("Drift", "action", vehiclesubmenu.id, tuneDriftVehicle)

  maxSpeed = menu.add_feature("Remove Max Speed", "action", vehiclesubmenu.id, removeMaxSpeedVehicle)
  
  setMaxSpeed = menu.add_feature("Set Max Speed", "action", vehiclesubmenu.id, setMaxSpeedVehicle)

  setHeliBladeSpeed = menu.add_feature("Set Heli Blade Speed", "action", vehiclesubmenu.id, setHeliBladeSpeed)

  vehicleParachute = menu.add_feature("Open Vehicle Parachute", "action", vehiclesubmenu.id, openVehicleParachute)
  
  freezeVehicleOnExitVar = createConfigedMenuOption("Freeze Vehicle on exit","toggle",vehiclesubmenu.id,freezeVehicleOnExit,config,"freezeVehOnExit",false,nil)
  
  noClipVehicleOnExitVar = createConfigedMenuOption("NoClip Vehicle on exit (stay nearby)","toggle",vehiclesubmenu.id,NoClipVehicleOnExit,config,"noClipVehOnExit",false,nil)

  vehicleMods = menu.add_feature("Vehicle Mods", "parent", vehiclesubmenu.id, nil)
  vehicleAttach = menu.add_feature("Safety First", "action", vehicleMods.id, attachSafetyFirst)
  vehicleAttach = menu.add_feature("Add Ramp", "action", vehicleMods.id, attachRamp)
  vehicleAttachLamp = menu.add_feature("Lamp Tire", "action", vehicleMods.id, attachLampToTire)
  burning_candle_f = menu.add_feature("Candle PTFX to Tires","action",vehicleMods.id,burning_candle)
  burning_candle_t = menu.add_feature("Candle PTFX to Tires","toggle",vehicleMods.id,burning_candle2)    
  
  soundHorn = createConfigedMenuOption("Sound Horn","value_str",vehiclesubmenu.id,onSoundHorn,config,"enable_soundhorn",false,nil)
  soundHorn.set_str_data(soundHorn,soundsM.getAllSoundNames())
  
  local gear_parent = menu.add_feature("Gear Control","parent",vehiclesubmenu.id,nil)
  
  menu.add_feature("Set Max Gear","action",gear_parent.id,function()
    local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  
    if veh ~= nil then
      local r, s = input.get("Enter max Gear", vehicle.get_vehicle_max_gear(veh), 64, 3)
      if r == 1 then return HANDLER_CONTINUE end
      if r == 2 then return HANDLER_POP end
      
      vehicle.set_vehicle_max_gear(veh,s)
      menu.notify("Changed max gear to " .. s,"ZeroMenu",5,140)
    else 
      menu.notify("Please enter a Vehicle first","ZeroMenu",5,140)
    end
  end)
  
  --gearFeat = menu.add_feature("Enable","toggle",gear_parent.id,setGear)
  gearFeat =    createConfigedMenuOption("Enable","toggle",gear_parent.id,setGear,config,"enable_gearcontrol",false,nil)
  if config:isFeatureEnabled("enable_gearcontrol") then
    gearFeat.on = true
  end
  gearOverlay = createConfigedMenuOption("Enable Overlay","toggle",gear_parent.id,setGearOveraly,config,"enablegearoverlay",false,nil)
  if config:isFeatureEnabled("enable_gearoverlay") then
    gearOverlay.on = true
  end 
  
  
  --gearOverlay_speed = menu.add_feature("Enable Speed Overlay","toggle",gear_parent.id,setGearOveraly)
  --gearOverlay_rpm   = menu.add_feature("Enable RPM Overlay"  ,"toggle",gear_parent.id,setGearOveralyRpm)
  
  gearOverlay_speed = createConfigedMenuOption("Enable Speed Overlay","toggle",gear_parent.id,setGearOveralySpeed,config,"enablegearoverlayspeed",false,nil)
  
  if config:isFeatureEnabled("enablegearoverlayspeed") then
    gearOverlay_speed.on = true
  end
  gearOverlay_rpm =   createConfigedMenuOption("Enable RPM Overlay"  ,"toggle",gear_parent.id,setGearOveralyRpm,config,"enablegearoverlayrpm",false,nil)
  if config:isFeatureEnabled("enablegearoverlayrpm") then
    gearOverlay_rpm.on = true
  end
  overlay_light =   createConfigedMenuOption("Enable Light Overlay"  ,"toggle",gear_parent.id,setOveralyLight,config,"enableoverlaylight",false,nil)
  if config:isFeatureEnabled("enableoverlaylight") then
    overlay_light.on = true
  end
  
  gearX = createConfigedMenuOption("Overlay   X" ,"autoaction_value_f",gear_parent.id,nil,config,"gearcontrolx",false,nil)
  --gearX = menu.add_feature("Overlay X","autoaction_value_f",gear_parent.id,nil)
  gearX.min = 0.1
  gearX.max = 1.0
  gearX.mod = 0.05
  
  config:saveIfNotExist("gearcontrolx",0.2)
  config:saveIfNotExist("gearcontroly",0.9)
  
  gearY = createConfigedMenuOption("Overlay Y" ,"autoaction_value_f",gear_parent.id,nil,config,"gearcontroly",false,nil)
  --gearY = menu.add_feature("Overlay Y","autoaction_value_f",gear_parent.id,nil)
  gearY.min = 0.1
  gearY.max = 1.0
  gearY.mod = 0.05
  
  gearX.value = tonumber(config:getValue("gearcontrolx"))
  gearY.value = tonumber(config:getValue("gearcontroly"))
  
  menu.add_feature("Rope Entities together","action",vehiclesubmenu.id,ropeTogether)
  ropeListFeature = menu.add_feature("Rope List","parent",vehiclesubmenu.id,loadRopeList)
  
  
  hornSpam = menu.add_feature("Start Car Horn","toggle",vehiclesubmenu.id,function()
    
      local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
      local duration = 2
      if veh ~= nil then
        vehicle.start_vehicle_horn(veh,duration,0,false)
      end  
      if hornSpam.on then
        return HANDLER_CONTINUE
      end  
  end)
  
  menu.add_feature("Set Vehicle Gravity","action",vehiclesubmenu.id,function()
    local r, s = input.get("Enter new Gravity", 100, 64, 3)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end
    local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    local gravityBefore = vehicle.get_vehicle_gravity_amount(veh)
    
    menu.notify("Changed gravity from " .. gravityBefore .. " to " .. s,"ZeroMenu",5,140)  
    vehicle.set_vehicle_gravity_amount(veh,s) 
  end)
  
  
  gravityForAll = menu.add_feature("Set Vehicle Gravity for nearby Vehicles","toggle",vehiclesubmenu.id,function()    
        if gravityValue == nil  then
           local r, s = input.get("Enter new Gravity", 100, 64, 3)
            if r == 1 then return HANDLER_CONTINUE end
            if r == 2 then return HANDLER_POP end
            
            gravityValue = s
        end
        
         
        for i in ipairs(vehicle.get_all_vehicles())do
          local veh = vehicle.get_all_vehicles()[i]
          local gravityBefore = vehicle.get_vehicle_gravity_amount(veh)
          vehicle.set_vehicle_gravity_amount(veh,gravityValue) 
        end
        if gravityForAll.on then
          return HANDLER_CONTINUE
        else
          gravityValue = nil
        end  
  end)
  
end

local hit_ent1,hit_ent2
local hit_pos_1,hit_pos_2
local ropeTogetherannounced = false
local ropeList = {}

function loadRopeList()
  menu.notify("displaying " .. #ropeList .. " ropes","ZeroMenu",5,140)
  for i=1,#ropeList do
    if(ropeList[i]["feature"] == nil) then
      local tmpfeat = menu.add_feature("Rope"..i,"action_value_str",ropeListFeature.id,selectedRopeFeature)
      tmpfeat.str_data  = {"Delete","start winding","stop winding","start unwinding","stop unwinding","set gravity"}  
      tmpfeat.data = {ropeObject = ropeList[i]}
      ropeList[i]["feature"] = 1
    end    
  end
end

function selectedRopeFeature(feat,data)  
  local featValue = feat.value  
  if(featValue == 0) then
    rope.delete_rope(data.ropeObject['rope'])
    menu.notify("Deleted rope " .. data.ropeObject['rope'],"ZeroMenu",5,140)
    menu.delete_feature(feat.id)
  elseif(featValue == 1) then
    rope.start_rope_winding(data.ropeObject['rope'])
    menu.notify("Started winding of Rope","ZeroMenu",5,140)
  elseif(featValue == 2) then
    rope.stop_rope_winding(data.ropeObject['rope'])
    menu.notify("Stopped winding of Rope","ZeroMenu",5,140)
  elseif(featValue == 3) then
    rope.start_rope_unwinding_front(data.ropeObject['rope'])
    menu.notify("Started unwinding of Rope","ZeroMenu",5,140)
  elseif(featValue == 4) then
    rope.stop_rope_unwinding_front(data.ropeObject['rope'])
    menu.notify("Stopped unwinding of Rope","ZeroMenu",5,140)
  elseif(featValue == 5) then
    local r, s = input.get("Enter new Torque", 100, 64, 3)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end
    local gravityBefore = vehicle.get_vehicle_gravity_amount(data.ropeObject['ent_2'])
    menu.notify("Changed gravity from " .. gravityBefore .. " to " .. s,"ZeroMenu",5,140)  
    vehicle.set_vehicle_gravity_amount(data.ropeObject['ent_2'],s)
  else
    menu.notify("called workWithRopeFunction " .. featValue,"ZeroMenu",5,140)
  end  
end

function ropeTogether()
  if(ropeTogetherannounced == false) then
    menu.notify("Please shoot an Entity to rope them together!","ZeroMenu",5,140)
    ropeTogetherannounced = true
  end

  local a,b = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id())) 
  if(a == true) then
    if(hit_ent1 == nil) then
      --select ent1
      hit_ent1 = player.get_entity_player_is_aiming_at(player.player_id())
      hit_pos_1 = b
      if(hit_ent1 ~= nil and hit_ent1 ~= 0) then        
        menu.notify("Selected Entity with id: " .. hit_ent1,"ZeroMenu",5,140)
        if(entity.is_entity_a_ped(hit_ent1)) then          
          if(ped.is_ped_in_any_vehicle(hit_ent1)) then
            hit_ent1 = ped.get_vehicle_ped_is_using(hit_ent1)
          end        
        end
      else
        menu.notify("Couldn't find any entity!","ZeroMenu",5,140)
        hit_ent1 = nil
        ropeTogetherannounced = false
      end
    else
      --select ent2
      hit_ent2 = player.get_entity_player_is_aiming_at(player.player_id())
      hit_pos_2 = b
      if(hit_ent2 ~= nil and hit_ent2 ~= 0) then        
        menu.notify("Selected second Entity with id: " .. hit_ent2,"ZeroMenu",5,140)        
        if(entity.is_entity_a_ped(hit_ent2)) then          
          if(ped.is_ped_in_any_vehicle(hit_ent2)) then
            hit_ent2 = ped.get_vehicle_ped_is_using(hit_ent2)
            hit_pos_2 = b
          end        
        end        
      else
        menu.notify("Couldn't find any entity!","ZeroMenu",5,140)
        hit_ent2 = nil
        ropeTogetherannounced = false
      end
    end
   -- while(not rope.rope_are_textures_loaded()) do
   --   rope.rope_load_textures()
   --   system.wait(100)
    --end
    
    if(hit_ent1 ~= nil and hit_ent2 ~= nil) then
      
      local length = calculateDistanceMovedBetweenCoords(entity.get_entity_coords(hit_ent1),entity.get_entity_coords(hit_ent2))
      
      local ropePos = entity.get_entity_coords(hit_ent1)
      local newRope = rope.add_rope(ropePos,v3(0,0,0),1,1,10,10,10,true,true,true,1.0,false)
      local ropeObject = {}
      ropeObject['rope'] = newRope
      ropeObject['ent_1'] = hit_ent1
      ropeObject['ent_2'] = hit_ent2
      
      ropeList[#ropeList+1] = ropeObject
      rope.attach_entities_to_rope(newRope,hit_ent1,hit_ent2,hit_pos_1,hit_pos_2,length ,0,0,"Center","Center")

      hit_pos_2 = nil
      hit_pos_1 = nil

      hit_ent1 = nil
      hit_ent2 = nil
      ropeTogetherannounced = false
      return HANDLER_POP       
    else
      return HANDLER_CONTINUE
    end
  end
  return HANDLER_CONTINUE
end


function attachLampToTire()
 local lentity = player.get_player_vehicle(player.player_id())
 local candle = -647884455
  if(streaming.has_model_loaded(candle)) then  
    local objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    local offset = v3(0,0,0)
    local rot = v3(0,0,0)

            --attach_entity_to_entity(subject,target, int boneIndex, v3 offset, v3 rot, bool softPinning, bool collision, bool isPed, int vertexIndex, bool fixedRot)
    entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lf"),offset,rot,false,true,false,0,true)
    objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_rf"),offset,rot,false,true,false,0,true)
    objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lm1"),offset,rot,false,true,false,0,true)
    objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_rm1"),offset,rot,false,true,false,0,true)
    objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lm2"),offset,rot,false,true,false,0,true)
    objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_rm2"),offset,rot,false,true,false,0,true)
    objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lm3"),offset,rot,false,true,false,0,true)
    objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lr"),offset,rot,false,true,false,0,true)
    objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_rr"),offset,rot,false,true,false,0,true)
    
    
    streaming.set_model_as_no_longer_needed(candle) 
    return HANDLER_POP
  else
    streaming.request_model(candle)
    return HANDLER_CONTINUE
  end
end
function attachRamp()
  local candle = 1290523964
  local lentity = player.get_player_vehicle(player.player_id())
  if(streaming.has_model_loaded(candle)) then  
    local objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    local offset = v3(0,5,0)
    local rot = v3(0,0,180)        
        

    print(entity.get_entity_bone_index_by_name(lentity,"bonnet"))
            --attach_entity_to_entity(subject,target, int boneIndex, v3 offset, v3 rot, bool softPinning, bool collision, bool isPed, int vertexIndex, bool fixedRot)
    --entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"bonnet"),offset,rot,false,true,false,0,true)
    entity.attach_entity_to_entity(objectCandle,lentity,-1,offset,rot,false,true,false,0,true)
    streaming.set_model_as_no_longer_needed(candle) 
    return HANDLER_POP
  else
    streaming.request_model(candle)
    return HANDLER_CONTINUE
  end


end

local callStack = 0
function attachCandles()
  local lentity = player.get_player_vehicle(player.player_id())
  local candle = -1915729838
  if(streaming.has_model_loaded(candle)) then  
    local objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
    local offset = v3(0,0,0)
    local rot = v3(0,0,0)
    if(graphics.has_named_ptfx_asset_loaded("core")) then
      print("core loaded")
      graphics.set_next_ptfx_asset("core")
      graphics.start_ptfx_looped_on_entity("scr_clown_appears",player.get_player_ped(player.player_id()),offset,rot,10.0)
      callStack = 0
      streaming.set_model_as_no_longer_needed(candle) 
      return HANDLER_POP
    else
      graphics.request_named_ptfx_asset("core")
      print("request scr_rcbarry2 ")
      if(callStack > 50)then
        print("fast out " .. callStack .. " > 10")
        return HANDLER_POP
      else
        callStack = callStack+1
      end
      return HANDLER_CONTINUE
    end
  else
    streaming.request_model(candle)
    return HANDLER_CONTINUE
  end
end
function attachSafetyFirst()
  local lentity = player.get_player_vehicle(player.player_id())
  --2041509221 - safety first
  local candle = 2041509221
  if(streaming.has_model_loaded(candle)) then  
    local offset = v3(0,0,0)
    local rot = v3(0,0,0)
      local objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
      entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lf"),offset,rot,false,true,false,0,true)
    
      objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
      entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_rf"),offset,rot,false,true,false,0,true)
      
      objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
      entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lm1"),offset,rot,false,true,false,0,true)
      
      objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
      entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_rm1"),offset,rot,false,true,false,0,true)
      
      objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
      entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lm2"),offset,rot,false,true,false,0,true)
      
      objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
      entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_rm2"),offset,rot,false,true,false,0,true)
      
      objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
      entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lm3"),offset,rot,false,true,false,0,true)
      
      objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
      entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_lr"),offset,rot,false,true,false,0,true)
      
      objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
      entity.attach_entity_to_entity(objectCandle,lentity,entity.get_entity_bone_index_by_name(lentity,"wheel_rr"),offset,rot,false,true,false,0,true)
    
      streaming.set_model_as_no_longer_needed(candle) 
    return HANDLER_POP
  else
    if(callStack > 50)then
      return HANDLER_POP
    else
      callStack = callStack+1
    end
    streaming.request_model(candle)
    return HANDLER_CONTINUE
  end
end


function tuneVehicle()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  local r, s = input.get("Enter new Torque", 100, 64, 3)
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
    entity.set_entity_max_speed(veh,150000)    
  end
end

function setMaxSpeedVehicle()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

  local r, s = input.get("Enter new Torque", 540, 64, 3)
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
    if f.value > speed then
      speed = speed+1000
    else
      speed = speed-1000
    end   
    torgue.value = speed
  end)
  torgue.max = 10000000000
  torgue.value = speed
  
  config:saveIfNotExist("vehicletorguemax",10000000000)
  config:saveIfNotExist("vehicletorgue",speed)
  
  torgue.max = tonumber(config:getValue("vehicletorguemax"))
  torgue.value = tonumber(config:getValue("vehicletorgue"))
  
  
  ignoreplayers = menu.add_feature("Ignore Players", "toggle", vesettings.id, nil)
  
  config:saveIfNotExist("vehicleignoreplayers",false)
  ignoreplayers.on = config:isFeatureEnabled("vehicleignoreplayers")  
end

function openVehicleParachute()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

  if veh ~= nil then
    vehicle.set_vehicle_parachute_active(veh,true)
    menu.notify("opening parachute...","ZeroMenu",5,140)    
  end
end

function setHeliBladeSpeed()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  local r, s = input.get("Enter new Torque", 0, 64, 3)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end
  
  if veh ~= nil then
    vehicle.set_heli_blades_speed(veh,s)
    menu.notify("Set Blade Speed to " .. s,"ZeroMenu",5,140)    
  end
end



function freezeVehicleOnExit()
  if(lastVehicle ~= ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))) then
    if(lastVehicle ~= 0) then
      entity.freeze_entity(lastVehicle,true)
      menu.notify("Freezed Last Vehicle","ZeroMenu",5,140)    
    end
    lastVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    if(lastVehicle ~= 0) then
      entity.freeze_entity(lastVehicle,false)
      menu.notify("Unfrozen current Vehicle","ZeroMenu",5,140)    
    end
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

function burning_candle()
  --local candle = -1915729838
  local candle = -769292007
  if(streaming.has_model_loaded(candle)) then
    if(player.is_player_in_any_vehicle(player.player_id())) then
      local wheels = {"wheel_lf","wheel_rf","wheel_lm1","wheel_rm1","wheel_lm2","wheel_rm2","wheel_lm3","wheel_rm3","wheel_lr","wheel_rr"}
      local parent = player.get_player_vehicle(player.player_id())
      local offset = v3(0,0,0)
      for i,s in ipairs(wheels)do
        local boneIndex = entity.get_entity_bone_index_by_name(parent,s)
        if(boneIndex > -1) then
            local rot = v3(0,0,0)
            local objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
            attachPTFX(objectCandle,"core","ent_amb_candle_flame",1.0)
            attachPTFX(objectCandle,"scr_bike_adversary","scr_adversary_slipstream_formation",5.0)
            entity.attach_entity_to_entity(objectCandle,parent,boneIndex,offset,rot,false,true,false,0,true)
        end
      end
      menu.notify("Added Candle PTFX To Tires","ZeroMenu",5,140)    
    else  
      menu.notify("Please enter a vehicle!","ZeroMenu",5,140)    
    end
  else
    streaming.request_model(candle)
    return HANDLER_CONTINUE
  end
end
local ptfxTireList = {}
function burning_candle2()
  --local candle = -1915729838
  local candle = -769292007
  if(streaming.has_model_loaded(candle) ) then
    if(player.is_player_in_any_vehicle(player.player_id())) then
      local parent = player.get_player_vehicle(player.player_id())
      if(ptfxTireList[parent] == nil) then
        local wheels = {"wheel_lf","wheel_rf","wheel_lm1","wheel_rm1","wheel_lm2","wheel_rm2","wheel_lm3","wheel_rm3","wheel_lr","wheel_rr"}
        
        local offset = v3(0,0,0)
        for i,s in ipairs(wheels)do
          local boneIndex = entity.get_entity_bone_index_by_name(parent,s)
          if(boneIndex > -1) then
              local rot = v3(0,0,0)
              local objectCandle = object.create_object(candle,player.get_player_coords(player.player_id()),true,true)
              attachPTFX(objectCandle,"core","ent_amb_candle_flame",1.0)
              attachPTFX(objectCandle,"scr_bike_adversary","scr_adversary_slipstream_formation",5.0)
              entity.attach_entity_to_entity(objectCandle,parent,boneIndex,offset,rot,false,true,false,0,true)
          end
        end
        menu.notify("Added Candle PTFX To Tires","ZeroMenu",5,140)  
        ptfxTireList[parent] = "1"
      end 
    end
  else
    streaming.request_model(candle)
    return HANDLER_CONTINUE
  end
  if(burning_candle_t.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function attachPTFX(entity,dict,ptfx,scale)
  graphics.set_next_ptfx_asset(dict)
  while not graphics.has_named_ptfx_asset_loaded(dict) do
    graphics.request_named_ptfx_asset(dict)
    system.wait(0)
    return HANDLER_CONTINUE 
  end
  local offset = v3(0,0,0)
  local rot = v3(0,90,0)
  graphics.start_networked_ptfx_looped_on_entity(ptfx,entity,offset,rot,scale)
end

function setGear()
  if(player.is_player_in_any_vehicle(player.player_id())) then
    local playerVehicle = player.get_player_vehicle(player.player_id())     
    if(gearFeat.on and streaming.is_model_a_vehicle(entity.get_entity_model_hash(playerVehicle))) then      
      if(currentGear < vehicle.get_vehicle_current_gear(playerVehicle)) then     
        gearMaxSpeed[currentGear] =  entity.get_entity_speed(playerVehicle)
        local percentToMaxSpeed = (gearMaxSpeed[currentGear]/vehicle.get_vehicle_estimated_max_speed(playerVehicle))*100
        --print("Gear:" .. currentGear .. ";speed: " .. gearMaxSpeed[currentGear] .. ";max speed = " ..  vehicle.get_vehicle_estimated_max_speed(playerVehicle) .. " ;percent: " .. percentToMaxSpeed ..  ";max-gear-speed:  " .. getMaxSpeedForGear(gear,maxspeed))
        currentGear = vehicle.get_vehicle_current_gear(playerVehicle)
      end 
      if(vehicleToGear[playerVehicle] ==  nil) then
        vehicleToGear[playerVehicle] = {}
      end
      if(vehicleToGear[playerVehicle]['gear'] ==  nil) then
        vehicleToGear[playerVehicle]['gear']  = vehicle.get_vehicle_current_gear(playerVehicle)
      end
      
      if(vehicleToGear[playerVehicle]['maxgear'] == nil) then
        vehicleToGear[playerVehicle]['maxgear'] = vehicle.get_vehicle_max_gear(playerVehicle)
        if(vehicleToGear[playerVehicle]['maxgear'] == 1) then vehicleToGear[playerVehicle]['maxgear'] = 10 end
      end      
      --local gear_ratio = vehicle.get_vehicle_gear_ratio(playerVehicle,vehicle.get_vehicle_current_gear(playerVehicle))
      --if(gear_ratio ~= nil) then
      --  ui.draw_text("Gearratio: " .. gear_ratio,v2(gearX,gearY))
      --end      
      -- menu.notify("Gear: " .. vehicle.get_vehicle_current_gear(playerVehicle) .. "/" .. vehicle.get_vehicle_max_gear(playerVehicle),"ZeroMenu",5,140)
      local changegear = false
      if((os.clock() - lastGearChange) > 0.5) then
        changegear = true   
      end    
               
      if(controls.is_control_pressed(2,36) and changegear) then
        vehicleToGear[playerVehicle]['gear'] = vehicleToGear[playerVehicle]['gear']+1
        if(vehicleToGear[playerVehicle]['gear'] >  vehicleToGear[playerVehicle]['maxgear']) then 
          vehicleToGear[playerVehicle]['gear'] = vehicleToGear[playerVehicle]['maxgear'] 
        end
        --menu.notify("Shift up to " .. vehicleToGear[playerVehicle]['gear'],"ZeroMenu",5,140)
        lastGearChange = os.clock()
      elseif(controls.is_control_pressed(2,19) and changegear) then 
        vehicleToGear[playerVehicle]['gear'] = vehicleToGear[playerVehicle]['gear']-1
        if(vehicleToGear[playerVehicle]['gear'] <=  0) then vehicleToGear[playerVehicle]['gear'] = 1 end
         --menu.notify("Shift down to " .. vehicleToGear[playerVehicle]['gear'],"ZeroMenu",5,140)
        lastGearChange = os.clock()
      end 
         
      --Absaufen?
      if(vehicle.get_vehicle_current_gear(playerVehicle) == 1 or vehicle.get_vehicle_current_gear(playerVehicle) == 0) then
        if(vehicleToGear[playerVehicle]['gear'] > 2 and entity.get_entity_speed(playerVehicle) < 10 and entity.get_entity_speed(playerVehicle) > 0) then
          vehicle.set_vehicle_engine_on(playerVehicle,false,true,false)
          menu.notify("Engine died, because of bad gear switching","ZeroMenu",5,140)
          vehicleToGear[playerVehicle]['gear'] = 1
        end
      end
      
      vehicle.set_vehicle_current_gear(playerVehicle,vehicleToGear[playerVehicle]['gear'] )
      vehicle.set_vehicle_max_gear(playerVehicle,vehicleToGear[playerVehicle]['gear'] )
      if(vehicleToGear[playerVehicle]['gear'] > 5)  then
         vehicle.set_vehicle_gear_ratio(playerVehicle,vehicleToGear[playerVehicle]['gear'],1.0)
      end
      local maxGearSpeed = getMaxSpeedForGear(vehicleToGear[playerVehicle]['gear'],vehicle.get_vehicle_estimated_max_speed(playerVehicle))
      if(entity.get_entity_speed(playerVehicle) > maxGearSpeed) then
       --if(not controls.is_control_pressed(2,8)) then
       if(vehicle.get_vehicle_current_gear(playerVehicle) ~= 0) then
          vehicle.set_vehicle_forward_speed(playerVehicle,maxGearSpeed)
        end        
      end          
    end           
  end
  
  if(gearFeat.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function setGearOveraly()
  if(player.is_player_in_any_vehicle(player.player_id())) then
    local playerVehicle = player.get_player_vehicle(player.player_id())  
    if(gearOverlay.on) then
      ui.set_text_scale(0.5)
      --ui.draw_text("Gear: " .. vehicle.get_vehicle_current_gear(playerVehicle) .. "/" .. vehicle.get_vehicle_max_gear(playerVehicle),v2(gearX.value,gearY.value))
      local maxgear = vehicle.get_vehicle_max_gear(playerVehicle)
      local currgear = vehicle.get_vehicle_current_gear(playerVehicle)
      if(maxgear ~= nil) then
        ui.draw_text("Gear: " .. currgear .. "/" .. maxgear,v2(gearX.value,gearY.value))
      end
    end   
  end  
  if(gearOverlay.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function getMaxSpeedForGear(gear,maxspeed)
  if(gear == nil) then return percentToMaxSpeed end
  if(gear < 5) then
    percentToMaxSpeed = gearToPercentSpeed[gear]
  end  
  if(percentToMaxSpeed  == nil) then
    percentToMaxSpeed = 200
  end
  return (maxspeed*(percentToMaxSpeed/100)*1.4)
end

--gearOverlay_speed,gearOverlay_rpm
function setGearOveralySpeed() 
  if(player.is_player_in_any_vehicle(player.player_id())) then
    local veh = player.get_player_vehicle(player.player_id())  
    if(gearOverlay_speed.on) then
      local maxSpeed = vehicle.get_vehicle_estimated_max_speed(veh)
      local currentSpeed = entity.get_entity_speed(veh)
      
      local percentSpeed = (currentSpeed/maxSpeed)*10
     -- ui.draw_text("currentSpeed: " .. currentSpeed,v2(0.1,0.6))
      --menu.notify(percentSpeed .. "% max mp/h reached","",5,140)
      
      if(percentSpeed > 10) then percentSpeed = 10 end
      --||||||||||
      ui.set_text_scale(0.5)
      ui.draw_text("Speed: ",v2(gearX.value,gearY.value+0.03))
      for i=1,percentSpeed do
        if(i > 3 and i < 7) then
          ui.set_text_color(255,255,0,255)
        elseif(i > 5) then        
          ui.set_text_color(255,0,0,255)
        end
        ui.set_text_scale(0.5)
        ui.draw_text("|",v2(gearX.value+(0.005*i)+0.09,gearY.value+0.03))
      end
    end
  end
  if(gearOverlay_speed.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function setGearOveralyRpm() 
  if(player.is_player_in_any_vehicle(player.player_id())) then
    local veh = player.get_player_vehicle(player.player_id())  
    if(gearOverlay_rpm.on) then
      local maxRpm = 1.0
      local currentRpm = vehicle.get_vehicle_rpm(veh)
      if(currentRpm == nil) then currentRpm = 0.0  end
      --error
      local percentRpm = (currentRpm/maxRpm)*10
      
      --menu.notify(percentRpm .. "% max RPM reached","",5,140)
     -- ui.draw_text("currentRpm: " .. currentRpm,v2(0.1,0.7))
      
      if(percentRpm > 10) then percentRpm = 10 end
      --||||||||||
      ui.set_text_scale(0.5)
      ui.draw_text("RPM: ",v2(gearX.value,gearY.value+0.06))
      for i=1,percentRpm do
        if(i > 3 and i < 7) then
          ui.set_text_color(255,255,0,255)
        elseif(i > 6) then        
          ui.set_text_color(255,0,0,255)
        end        
        ui.set_text_scale(0.5)
        ui.draw_text("|",v2(gearX.value+(0.005*i) + 0.09,gearY.value+0.06))
      end
    end
  end
  if(gearOverlay_rpm.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function setOveralyLight()
  if(player.is_player_in_any_vehicle(player.player_id())) then
    local playerVehicle = player.get_player_vehicle(player.player_id())  
    if(vehicleToGear[playerVehicle] ==  nil) then
      vehicleToGear[playerVehicle] = {}
    end
    if(controls.is_control_pressed(2,157)) then
      if(vehicleToGear[playerVehicle]['li'] == nil) then  vehicleToGear[playerVehicle]['li'] = false end
      if(vehicleToGear[playerVehicle]['li'] == false) then vehicleToGear[playerVehicle]['li'] = true else vehicleToGear[playerVehicle]['li'] = false end
      vehicle.set_vehicle_indicator_lights(playerVehicle,1,vehicleToGear[playerVehicle]['li'])   
    elseif(controls.is_control_pressed(2,158)) then
      if(vehicleToGear[playerVehicle]['ri'] == nil) then  vehicleToGear[playerVehicle]['ri'] = false end
      if(vehicleToGear[playerVehicle]['ri'] == false) then vehicleToGear[playerVehicle]['ri'] = true else vehicleToGear[playerVehicle]['ri'] = false end
      vehicle.set_vehicle_indicator_lights(playerVehicle,0, vehicleToGear[playerVehicle]['ri'])
    end   
    if(vehicleToGear[playerVehicle]['li'] == true) then
      ui.set_text_scale(0.5)
      ui.set_text_color(0,255,0,255)
      ui.draw_text("<-",v2(gearX.value,gearY.value+0.09))
    end
    if(vehicleToGear[playerVehicle]['ri'] == true) then
      ui.set_text_scale(0.5)
      ui.set_text_color(0,255,0,255)
      ui.draw_text("->",v2(gearX.value+0.02,gearY.value+0.09))
    end    
  end
  if(overlay_light.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function onSoundHorn(feat,data)   
  local selectedSound = soundsM.getAllSoundNames()[feat.value+1]
  if(selectedSound ~= nil) then
    local selectedRef = soundsM.getRefBySoundName(selectedSound)
    if player.is_player_pressing_horn(player.player_id()) then
       audio.play_sound_from_coord(-1,selectedSound, entity.get_entity_coords(player.get_player_ped(player.player_id())), selectedRef, true, 50, true)
    system.wait(0)
    audio.stop_sound(-1)
    end
  end    
  if(soundHorn.on) then
    return HANDLER_CONTINUE
  else
    
    return HANDLER_POP
  end
end


