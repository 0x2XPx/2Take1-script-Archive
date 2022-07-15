local VehicleHash = require("ZeroMenuLib/enums/VehicleHash")


local slowMo,hyper,CoronaMainFeature, coronaCheck, distanceWarning,AntiDepressorMain, deppressorCheck, distanceTP,oppressor,hydra,lazer,deluxo,speed,akula,friends,team,max_speed_grief,slowMo,mk1
local clearPath,noCollissionmenu,partyHardMenu,blmMenu

local lastSlowMoRun = 0
local storage 
local distance = 200
local newSpeed = 1000000000

local lastNearbyCheck = 0
local lConfig

function createNearbyMenu(parent,config)
  lConfig = config
  --Nearby
  nearby = menu.add_feature("Nearby", "parent", parent.id, nil)
  AntiDepressorMain = menu.add_feature("Anti Depressor", "parent", nearby.id, nil)
  
  slowMo  = menu.add_feature("SlowMo", "toggle", nearby.id, slowMoLobby)
  slowMo.threaded = false 
  
  if config:isFeatureEnabled("slowmolobby") then
    slowMo.on = true
  end
  
  hyper = menu.add_feature("Hyper", "toggle", nearby.id, hyperLobby)
  hyper.threaded = false
  
  if config:isFeatureEnabled("hyperlobby") then
    hyper.on = true
  end
  
  deppressorCheck = menu.add_feature("Check for Depressor", "toggle", AntiDepressorMain.id, checkForDepressor)
  deppressorCheck.threaded = true
  config:saveIfNotExist("deppressorCheck","false",configpath)
  
  if config:isFeatureEnabled("deppressorCheck") then
    deppressorCheck.on = true
  end
  
  coronaCheck = menu.add_feature("Check for encounters", "toggle", nearby.id, checkForPlayer)
  coronaCheck.threaded = false
  config:saveIfNotExist("coronaCheck","false",configpath)
  
  if config:isFeatureEnabled("coronaCheck") then
    coronaCheck.on = true
  end
  
  clearPath = menu.add_feature("Clearpath", "toggle", nearby.id, clearPathNearby)
  clearPath.threaded = false
  config:saveIfNotExist("clearPath","false",configpath)
  
  if config:isFeatureEnabled("clearPath") then
    clearPath.on = true
  end
  
  noCollissionmenu = menu.add_feature("No Colission", "toggle", nearby.id, noCollision)
  noCollissionmenu.threaded = false
  config:saveIfNotExist("noCollission","false",configpath)
  
  if config:isFeatureEnabled("noCollission") then
    noCollissionmenu.on = true
  end
  
  partyHardMenu = menu.add_feature("Party Mode", "toggle", nearby.id, dancingNpcs)
  partyHardMenu.threaded = true
  config:saveIfNotExist("partyHard","false",configpath)
  
  if config:isFeatureEnabled("partyHard") then
    partyHardMenu.on = true
  end
  
  blmMenu = menu.add_feature("BLM Demo", "toggle", nearby.id, warZone)
  blmMenu.threaded = false
  config:saveIfNotExist("blm","false",configpath)
  
  if config:isFeatureEnabled("blm") then
    blmMenu.on = true
  end
  
  storage = {}
end

function slowMoLobby()
  if slowMo.on then   
      for i in ipairs(ped.get_all_peds())do
        local tempped = ped.get_all_peds()[i]
        if not ped.is_ped_a_player(tempped) then
          if ped.is_ped_in_any_vehicle(tempped) then 
            local tempveh = ped.get_vehicle_ped_is_using(tempped)
            if not network.has_control_of_entity(tempveh) then
              network.request_control_of_entity(tempveh)  
            end 
            entity.set_entity_max_speed(tempveh,1)
          else
            if not network.has_control_of_entity(tempped) then
              network.request_control_of_entity(tempped)  
            end 
            entity.set_entity_max_speed(tempped,0)
          end
        end
    end
      lastSlowMoRun = os.time()
  end
  if slowMo.on and not lconfig:isFeatureEnabled("slowmolobby") then
    lconfig:storeValue("slowmolobby","true")
  elseif not slowMo.on and lconfig:isFeatureEnabled("slowmolobby") then
    lconfig:storeValue("slowmolobby","false")
  end
  if slowMo.on then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

local lastPartyCheck = 0;

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

warPeds = {}

function warZone()

  size = tablelength(ped.get_all_peds())

 for i in ipairs(ped.get_all_peds())do
  local tempped = ped.get_all_peds()[i]
  local randomPed = ped.get_all_peds()[math.random(size)]    
     if not ped.is_ped_a_player(tempped) then     
       if not ped.is_ped_a_player(randomPed) then     
        if warPeds[randomPed] == nil then
            ran = math.random(4)
  
            if ran == 1 then
              weapon.give_delayed_weapon_to_ped(tempped, 0x476BF155 ,10000,1)
            elseif ran == 2 then
              weapon.give_delayed_weapon_to_ped(tempped, 0x42BF8A85 ,10000,1)
            elseif ran == 3 then
              weapon.give_delayed_weapon_to_ped(tempped, 0xB1CA77B1 ,10000,1)
            else
              weapon.give_delayed_weapon_to_ped(tempped, 0xA284510B ,10000,1)
            end
            
            ran = math.random(4)
            
            if ran == 1 then
              weapon.give_delayed_weapon_to_ped(randomPed, 0x476BF155 ,10000,1)
            elseif ran == 2 then
              weapon.give_delayed_weapon_to_ped(randomPed, 0x42BF8A85 ,10000,1)
            elseif ran == 3 then
              weapon.give_delayed_weapon_to_ped(randomPed, 0xB1CA77B1 ,10000,1)
            else
              weapon.give_delayed_weapon_to_ped(randomPed, 0xA284510B ,10000,1)
            end                 
            warPeds[tempped] = 1
            warPeds[randomPed] = 1
        end  
        ai.task_combat_ped(tempped,randomPed,0,16)
        ai.task_combat_ped(randomPed,tempped,0,16)
        entity.set_entity_god_mode(tempped,true)
        entity.set_entity_god_mode(randomPed,true)               
       end     
    end
    
 end
  if blmMenu.on then
      return HANDLER_CONTINUE
    else
      return HANDLER_POP
    end
 end

partyPeds = {}

function dancingNpcs()
  if partyHardMenu.on then   
  local pedList = {}
    if (os.time() - lastPartyCheck > 10) then
      lastPartyCheck = os.time()
    for i in ipairs(ped.get_all_peds())do
    local tempped = ped.get_all_peds()[i]
      if partyPeds[tempped] == nil then          
          if tempped ~= nil then
            if not ped.is_ped_a_player(tempped) then
            if not ped.is_ped_in_any_vehicle(tempped) then 
            
              if not network.has_control_of_entity(tempped) then
                network.request_control_of_entity(tempped)  
              end 
              
              --print("move")
              ped.clear_ped_tasks_immediately(tempped)
             -- print("player_id " .. player.player_id() .. "\n")
              --print("player ped " .. player.get_player_ped(player.player_id()) .. "\n")
              --print("ped " .. tempped .. "\n")
              --ai.task_goto_entity(tempped, player.get_player_ped(player.player_id()),10,10, 100)
             --task_go_to_coord_by_any_means(Ped ped, v3 coords, float speed, Any p4, bool p5, int walkStyle, float a7)
             ai.task_go_to_coord_by_any_means(tempped,entity.get_entity_coords(player.get_player_ped(player.player_id())),200,0,true,0,1)
              
            system.wait(10)
            --  random = math.random (5)
              random = 6
              print("doing animation " .. random) 
             -- ped.clear_ped_tasks_immediately(tempped)
              
              if not streaming.has_anim_dict_loaded("mini@strip_club@private_dance@part2")then
                streaming.request_anim_dict("mini@strip_club@private_dance@part2")
              end
              
              if not streaming.has_anim_set_loaded("priv_dance_p2")then
                streaming.request_anim_set("priv_dance_p2")
              end
              pos =  entity.get_entity_coords(player.get_player_ped(player.player_id()))
              
              
              local oldCord = pos
              local newCord = entity.get_entity_coords(tempped)
              local tempdistance = math.sqrt(math.pow(newCord['x'] - oldCord['x'],2) + math.pow(newCord['y'] - oldCord['y'],2) + math.pow(newCord['z'] - oldCord['z'],2))
               
              
              if tempdistance < 10 then
              
                --pi = math.pi
              --rand = math.random(1)
              
              --local a = rand * 2 * math.pi
              --local r = 200 * math.sqrt(rand)
              
             -- pos.x = pos.x + r * math.cos(a)
              --pos.z = pos.z + r * math.cos(a)
              local radius = 5
              
              if math.random(1) == 0 then
                -- +
                offset = math.random(radius)        
              else
                -- -
                offset = math.random(radius)*-1
              end        
                pos.x = pos.x + offset
                if math.random(1) == 0 then
                -- +
                offset = math.random(radius)        
              else
                -- -
                offset = math.random(radius)*-1
              end      
                pos.y = pos.y + offset
              
              print("from x " .. entity.get_entity_coords(player.get_player_ped(player.player_id())).x .. " to " .. pos.x)
              print("from y " .. entity.get_entity_coords(player.get_player_ped(player.player_id())).y .. " to " .. pos.y)
              print("from z " .. entity.get_entity_coords(player.get_player_ped(player.player_id())).z .. " to " .. pos.z)
             
              
              --pos.x = pos.x + math.random(10)
              --pos.y = pos.y + math.random(10)+5
              
              
             -- ai.play_anim_on_running_scenario(tempped,"mini@strip_club@private_dance@part2" ,"priv_dance_p2")      
              --ai.task_start_scenario_in_place(tempped,"WORLD_HUMAN_PARTYING",0,true)
              --task_start_scenario_at_position(Ped ped, string name, v3 coord, float heading, int duration, bool sittingScenario, bool teleport)
              local ran = math.random(10)
              
              if pedList[i] == nil then
            -- pedList[i] = tempped
                pos1 = entity.get_entity_coords(tempped)
                teleport = true
                if ran == 1 then
                  ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_PARTYING",pos1,1,1000000,false,teleport)  
                elseif ran == 2  then    
                 ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_MUSICIAN",pos1,1,1000000,false,teleport) 
                 elseif ran == 3 then
                 ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_PROSTITUTE_HIGH_CLASS",pos1,1,1000000,false,teleport) 
                 elseif ran == 4      then
                 ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_PROSTITUTE_LOW_CLASS",pos1,1,1000000,false,teleport) 
                 elseif ran == 5    then  
                 ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_PROSTITUTE_LOW_CLASS",pos1,1,1000000,false,teleport) 
                 elseif ran == 6     then 
                 ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_PAPARAZZI",pos1,1,1000000,false,teleport) 
                 elseif ran == 7      then
                 ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_MUSCLE_FLEX",pos1,1,1000000,false,teleport) 
                 elseif ran == 8   then   
                 ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_HUMAN_STATUE",pos1,1,1000000,false,teleport) 
                 elseif ran == 9  then   
                 ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_DRUG_DEALER_HARD",pos1,1,1000000,false,teleport) 
                 elseif ran == 10  then    
                 ai.task_start_scenario_at_position(tempped,"WORLD_HUMAN_DRINKING",pos1,1,1000000,false,teleport) 
                end
                partyPeds[tempped] = 1
              end
              
              end
              
              
              else
                
                --task_go_to_coord_by_any_means(Ped ped, v3 coords, float speed, Any p4, bool p5, int walkStyle, float a7)
                ai.task_go_to_coord_by_any_means(tempped, entity.get_entity_coords(player.get_player_ped(player.player_id())),10,0,true,0,1)
              end
              end
            end
          end
        end
    end        
    end
    if partyHardMenu.on then
      return HANDLER_CONTINUE
    else
      return HANDLER_POP
    end
end

local noCollisionList = {}

function noCollision() 
  if noCollissionmenu.on then   
    for i in ipairs(vehicle.get_all_vehicles())do
      local tempveh = vehicle.get_all_vehicles()[i]
      if slot ~= player.player_id() then      
      if noCollisionList[tempveh] == nil then
	  
         --if not ped.is_ped_a_player(tempped) then            
         -- if ped.is_ped_in_any_vehicle(tempped) then 
			local myveh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
            
			  if not network.has_control_of_entity(tempveh) then
				network.request_control_of_entity(tempveh)  
			  end 
			entity.set_entity_no_collsion_entity(tempveh,myveh,false)
         --end  
        --end   
      noCollisionList[tempveh] = true
      end
     
      end
    end
  end
  if noCollissionmenu.on then   
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function clearPathNearby()
  if clearPath.on then   
    if (os.time() - lastNearbyCheck) > 1 then    
      lastNearbyCheck = os.time()
      for i in ipairs(ped.get_all_peds())do
        local tempped = ped.get_all_peds()[i]
        if slot ~= player.player_id() then
			   if not ped.is_ped_a_player(tempped) then
          if ped.is_ped_in_any_vehicle(tempped) then 
				    local tempveh = ped.get_vehicle_ped_is_using(tempped)
				    --ai.task_vehicle_drive_wander(tempped,tempveh,10000,1)
				    local myveh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
				    if not network.has_control_of_entity(tempped) then
					   network.request_control_of_entity(tempped)  
				    end 
				    if not network.has_control_of_entity(tempveh) then
					   network.request_control_of_entity(tempveh)  
				    end 
				    ai.task_vehicle_escort(tempped,tempveh,myveh,0,800,0,10,0,10)
          end
			  end
      end
       lastNearbyCheck = os.time()
      end
    end
  end
  if clearPath.on then   
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function hyperLobby()
  if hyper.on then  
      for i in ipairs(ped.get_all_peds())do
        local tempped = ped.get_all_peds()[i]
        if not ped.is_ped_a_player(tempped) then
          if ped.is_ped_in_any_vehicle(tempped) then 
            local tempveh = ped.get_vehicle_ped_is_using(tempped)
            if not network.has_control_of_entity(tempveh) then
              network.request_control_of_entity(tempveh)  
            end 
            entity.set_entity_max_speed(tempveh,newSpeed)
            vehicle.modify_vehicle_top_speed(tempveh,newSpeed)            
            ai.task_vehicle_drive_wander(tempped,tempveh,500,2)
          else
            if not network.has_control_of_entity(tempped) then
              network.request_control_of_entity(tempped)  
            end 
          end
        end
      lastSlowMoRun = os.time()
    end
  end
  if slowMo.on then   
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function checkForPlayer()
  for slot = 0, 31 do   
    local oldCord = player.get_player_coords(slot)
    local newCord = getMySelfCoords()   
    local tempdistance = math.sqrt(math.pow(newCord['x'] - oldCord['x'],2) + math.pow(newCord['y'] - oldCord['y'],2) + math.pow(newCord['z'] - oldCord['z'],2))
        
    if slot ~= player.player_id() and storage[player.get_player_name(slot)] == nil then
      if  tempdistance <= distance then
        --check if oppressor
        ui.notify_above_map("Send " .. player.get_player_name(slot) .. " a Corona Warning","Anti Depressor",140)
        player.send_player_sms(slot, "Corona Warning, don't get closer!") 
        storage[player.get_player_name(slot)] = {}
      end 
    end   
  end
  if coronaCheck.on then    
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function getMySelfCoords()
  return player.get_player_coords(player.player_id())
end

function loadNearbySettings(parent,config)
  cfsettings = menu.add_feature("China Flu Settings", "parent", parent.id, nil)

 --  local settings =  menu.add_feature("Settings", "parent", CoronaMainFeature.id, nil)

  distanceWarning = menu.add_feature("Warning Distance", "autoaction_value_i", cfsettings.id, function(f)
    if f.value_i > distance then
      distance = distance+100
    else
      distance = distance-100
    end
    
    distanceWarning.value_i = distance
  end)
  
  config:saveIfNotExist("cfdistance",distance)
  config:saveIfNotExist("cfdistancemax",10000)
  
  
  --distanceWarning.max_i = 10000  
  --distanceWarning.value_i = distance
  distanceWarning.threaded = false  
    
  distanceWarning.max_i = tonumber(config:getValue("cfdistancemax"))
  distanceWarning.value_i = tonumber(config:getValue("cfdistance"))
  
  adsettings = menu.add_feature("Anti Depressor", "parent", parent.id, nil)
  

  distanceTP = menu.add_feature("Distance Blocking", "autoaction_value_i", adsettings.id, function(f)
    if f.value_i > distance then
      distance = distance+100
    else
      distance = distance-100
    end
    
    distanceTP.value_i = distance
  end)
  
  config:saveIfNotExist("addistance",distance)
  config:saveIfNotExist("addistancemax",10000)
  
  --distanceTP.max_i = 10000
  --distanceTP.value_i = distance
  distanceTP.max_i = tonumber(config:getValue("addistancemax"))
  distanceTP.value_i = tonumber(config:getValue("addistance"))
  distanceTP.threaded = false
  
  
  speed = menu.add_feature("New Speed", "autoaction_value_i", adsettings.id, function(f)
    if f.value_i > newSpeed then
      newSpeed = newSpeed+100
    else
      newSpeed = newSpeed-100
    end
    
    speed.value_i = newSpeed
  end)
  
  --speed.max_i = 100000
  --speed.min_i = -1000
  --speed.value_i = newSpeed
  --speed.threaded = false
  config:saveIfNotExist("adspeed",newSpeed)
  config:saveIfNotExist("adspeedmax",10000)
  config:saveIfNotExist("adspeedmin",-1000)
  
  speed.max_i = tonumber(config:getValue("adspeedmax"))
  speed.min_i = tonumber(config:getValue("adspeedmin"))
  speed.value_i = tonumber(config:getValue("adspeed"))

  speed.threaded = false
  
  
  config:saveIfNotExist("blockomk2",false)
  config:saveIfNotExist("blockomk1",false)
  config:saveIfNotExist("blockhydra",false)
  config:saveIfNotExist("blockb11",false)
  config:saveIfNotExist("blocklazer",false)
  config:saveIfNotExist("blockakula",false)
  config:saveIfNotExist("blockdeluxo",false)
  config:saveIfNotExist("blockignoreteam",false)
  config:saveIfNotExist("blockignorefrieds",false)
  config:saveIfNotExist("blockgriefspeed",false)  
  
  oppressor = menu.add_feature("Oppressor MK2", "toggle", adsettings.id,nil)
  oppressor.threaded = false
  oppressor.on = config:isFeatureEnabled("blockomk2")
  
  
  mk1 = menu.add_feature("Oppressor", "toggle", adsettings.id,nil)
  mk1.threaded = false
  mk1.on = config:isFeatureEnabled("blockomk1")
  
  
  b11 = menu.add_feature("B-11", "toggle", adsettings.id,nil)
  b11.threaded = false
  b11.on = config:isFeatureEnabled("blockb11")
  
  hydra = menu.add_feature("Hydra", "toggle", adsettings.id,nil)
  hydra.threaded = false
  hydra.on = config:isFeatureEnabled("blockhydra")
  
  lazer = menu.add_feature("Lazer", "toggle", adsettings.id,nil)
  lazer.threaded = false
  lazer.on = config:isFeatureEnabled("blocklazer")
  
  deluxo  = menu.add_feature("Deluxo", "toggle", adsettings.id,nil)
  deluxo.threaded = false
  deluxo.on = config:isFeatureEnabled("blockdeluxo")
  
  akula = menu.add_feature("Akula", "toggle", adsettings.id,nil)
  akula.threaded = false
  akula.on = config:isFeatureEnabled("blockakula")
  
  team = menu.add_feature("Ignore Team", "toggle", adsettings.id,nil)
  team.threaded = false
  team.on = config:isFeatureEnabled("blockignoreteam")
  
  friends = menu.add_feature("Ignore Friends", "toggle", adsettings.id,nil)
  friends.threaded = false
  friends.on = config:isFeatureEnabled("blockignorefrieds")
  
  max_speed_grief = menu.add_feature("Grief Max Speed", "toggle", adsettings.id,nil)
  max_speed_grief.threaded = false
  max_speed_grief.on = config:isFeatureEnabled("blockgriefspeed")
  
end

function checkForDepressor()
  for slot = 0, 31 do   
    local oldCord = player.get_player_coords(slot)
    local newCord = getMySelfCoords()   
    local tempdistance = math.sqrt(math.pow(newCord['x'] - oldCord['x'],2) + math.pow(newCord['y'] - oldCord['y'],2) + math.pow(newCord['z'] - oldCord['z'],2))
    
    local ignoreSelf = slot ~= player.player_id()
    --local ignoreSelf = true
    if ignoreSelf then
      if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
        if (friends.on and not player.is_player_friend(slot)) or not friends.on then
          if (player.get_player_team(slot) ~= player.get_player_team(player.player_id()) and team.on) or not team.on then
            if  tempdistance <= distance then
              local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(slot))
              local rotation = v3()
              rotation.z = 180
              rotation.y = 0
              rotation.x = 0              
              if isBlockedHash(entity.get_entity_model_hash(veh)) then
                if not network.has_control_of_entity(veh) then
                  network.request_control_of_entity(veh)  
                end 
                entity.set_entity_max_speed(veh,10000)
                vehicle.set_vehicle_out_of_control(veh,false,false)   
                entity.set_entity_rotation(veh,rotation)
                vehicle.set_vehicle_forward_speed(veh, newSpeed)
                ui.notify_above_map("Trying to stop " .. vehicleHashToName(entity.get_entity_model_hash(veh)) .. " with player " .. player.get_player_name(slot) ,"Anti Depressor",140)
                if max_speed_grief.on then
                  system.wait(2000)
                  if not network.has_control_of_entity(veh) then
                    network.request_control_of_entity(veh)  
                  end 
                  entity.set_entity_max_speed(veh,1)              
                end
              end
            end
          end
        end     
      end       
    end 
  end
  if deppressorCheck.on then    
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function vehicleHashToName(hash)
  if (hash == VehicleHash.B11) then
    return "B-11 Strikeforce"
  elseif (hash == VehicleHash.MK1) then
    return "Oppressor MK1"  
  elseif (hash == VehicleHash.AKULA) then
    return "Akula"
  elseif (hash == VehicleHash.DELUXO) then
    return "Deluxo"
  elseif (hash == VehicleHash.HYDRA) then
    return "Hydra"
  elseif (hash == VehicleHash.LAZER) then
    return "P-996 Lazer"
  elseif (hash == VehicleHash.MK2) then
    return "Oppressor MK2"  
  end
  return "No Name Found for " .. hash
end


function isBlockedHash(hash)
  if (entity.get_entity_model_hash(veh) == VehicleHash.B11 and b11.on) or
     (entity.get_entity_model_hash(veh) == VehicleHash.MK1 and mk1.on) or
     (entity.get_entity_model_hash(veh) == VehicleHash.AKULA and akula.on) or
     (entity.get_entity_model_hash(veh) == VehicleHash.DELUXO and deluxo.on) or
     (entity.get_entity_model_hash(veh) == VehicleHash.HYDRA and hydra.on) or
     (entity.get_entity_model_hash(veh) == VehicleHash.LAZER  and lazer.on) or
     (entity.get_entity_model_hash(veh) == VehicleHash.MK2 and oppressor.on)
   then
    return true
  end
  return false
end
