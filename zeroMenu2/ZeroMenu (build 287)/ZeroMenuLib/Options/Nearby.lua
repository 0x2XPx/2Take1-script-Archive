require("ZeroMenuLib/Util/Util")

local VehicleHash = require("ZeroMenuLib/enums/VehicleHash")


local slowMo,hyper,CoronaMainFeature, coronaCheck, distanceWarning, deppressorCheck, distanceTP,oppressor,hydra,lazer,b11,deluxo,speed,akula,friends,team,max_speed_grief,slowMo,mk1
local clearPath,noCollissionmenu,partyHardMenu,blmMenu,noCollissionObjmenu,firework,removeGunsOfPeds

local lastSlowMoRun = 0
local storage
local distance = 200
local newSpeed = 1000000000

local lastNearbyCheck = 0
local lConfig
local lastFirework = 0
local lastVehicle

function createNearbyMenu(parent,config)
  lConfig = config
  --Nearby
  nearby = menu.add_feature("Nearby", "parent", parent.id, nil)
  slowMo = createConfigedMenuOption("SlowMo","toggle",nearby.id,slowMoLobby,config,"slowmolobby",false,nil)
  hyper = createConfigedMenuOption("Hyper","toggle",nearby.id,hyperLobby,config,"hyperlobby",false,nil)
  deppressorCheck = createConfigedMenuOption("Check for depressors","toggle",nearby.id,checkForDepressor,config,"deppressorCheck",false,nil)
  coronaCheck = createConfigedMenuOption("Send China Flu Warning nearby","toggle",nearby.id,checkForPlayer,config,"coronaCheck",false,nil)
  clearPath = createConfigedMenuOption("Clearpath","toggle",nearby.id,clearPathNearby,config,"clearPath",false,nil)
  noCollissionmenu = createConfigedMenuOption("No Vehicle Colission","toggle",nearby.id,noCollision,config,"noCollission",false,nil)
  noCollissionObjmenu = createConfigedMenuOption("No Object Colission","toggle",nearby.id,noObjectCollision,config,"noObjCollission",false,nil)
  partyHardMenu = createConfigedMenuOption("Party Mode","toggle",nearby.id,dancingNpcs,config,"partyHard",false,nil)
  blmMenu = createConfigedMenuOption("BLM Demo","toggle",nearby.id,warZone,config,"blm",false,nil)
  firework = menu.add_feature("Firework around you","toggle",nearby.id,randomFireWork)
  storage = {}

  menu.add_feature("Half-Pipes Fun","action",nearby.id,spawnFunRamp)
  menu.add_feature("Half-Pipes Fun 2","action",nearby.id,spawnFunRamp2)
  
  removeGunsOfPeds = menu.add_feature("Remove Guns of shooting Peds","toggle",nearby.id,nerfEnemyPeds)
end

function spawnFunRamp()
  if(streaming.has_model_loaded(-613845235)) then
    local v3 = player.get_player_coords(player.player_id())
    v3.z = v3.z -1.5
    for i=1,10 do
      local pipe = object.create_object(-613845235,v3,true,true)
      local rot = entity.get_entity_rotation(pipe)
      rot.z = rot.z+(i*36)
      entity.set_entity_rotation(pipe,rot)
      streaming.set_model_as_no_longer_needed(-613845235)
    end
    return HANDLER_POP
  else
    streaming.request_model(-613845235)
    return HANDLER_CONTINUE
  end
end

function spawnFunRamp2()
  if(streaming.has_model_loaded(-613845235)) then
    local v3 = player.get_player_coords(player.player_id())
    v3.z = v3.z -1.5
    for i=1,13 do
      local pipe = object.create_object(-613845235,v3,true,true)
      local rot = entity.get_entity_rotation(pipe)
      rot.z = rot.z+(i*14.4)
      entity.set_entity_rotation(pipe,rot)
    end
    v3 = player.get_player_coords(player.player_id())
    v3.z = v3.z +5
    for i=1,13 do
      local pipe = object.create_object(-613845235,v3,true,true)
      local rot = entity.get_entity_rotation(pipe)
      rot.y = 180
      rot.z = rot.z+(i*14.4)
      entity.set_entity_rotation(pipe,rot)
    end
    streaming.set_model_as_no_longer_needed(-613845235)
    return HANDLER_POP
  else
    streaming.request_model(-613845235)
    return HANDLER_CONTINUE
  end
end

function nerfEnemyPeds()
  local peds = ped.get_all_peds()
  for i in ipairs(peds)do
    local tempped = ped.get_all_peds()[i]
    if(tempped ~= nil) then
      if(not ped.is_ped_a_player(tempped) and ped.is_ped_shooting(tempped)) then
        weapon.remove_all_ped_weapons(tempped)    
        ped.clear_ped_tasks_immediately(tempped)
        ped.remove_ped_from_group(tempped)
        ped.set_ped_combat_ability(tempped,0)
        ped.set_ped_combat_movement(tempped,0)
        ped.set_ped_combat_range(tempped,0)
        
      end      
    end    
  end
  if(removeGunsOfPeds.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function randomFireWork()
  if((os.clock() - lastFirework) > 1)then
    local pos = player.get_player_coords(player.player_id())
    pos.z = pos.z+math.random(50)+50
    if(math.random(2) == 1) then
      if(math.random(2) == 1) then
        pos.x = pos.x+math.random(100)
      else
        pos.x = pos.x+(math.random(100)*-1)
      end
    else
      if(math.random(2) == 1) then
        pos.y = pos.y+math.random(100)
      else
        pos.y = pos.y+(math.random(100)*-1)
      end

    end
    gameplay.shoot_single_bullet_between_coords(pos,pos,0,0x7F7497E5,player.player_id(),false,false,1)
    lastFirework = os.clock()
  end
  if(firework.on) then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
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
  if slowMo.on and not lConfig:isFeatureEnabled("slowmolobby") then
    lConfig:storeValue("slowmolobby","true")
  elseif not slowMo.on and lConfig:isFeatureEnabled("slowmolobby") then
    lConfig:storeValue("slowmolobby","false")
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
                ped.clear_ped_tasks_immediately(tempped)
                ai.task_go_to_coord_by_any_means(tempped,entity.get_entity_coords(player.get_player_ped(player.player_id())),200,0,true,0,1)

                system.wait(10)

                if not streaming.has_anim_dict_loaded("mini@strip_club@private_dance@part2")then
                  streaming.request_anim_dict("mini@strip_club@private_dance@part2")
                  print("request mini@strip_club@private_dance@part2")
                  return HANDLER_CONTINUE
                end
                if not streaming.has_anim_dict_loaded("anim@amb@nightclub@lazlow@hi_podium@")then
                  streaming.request_anim_dict("anim@amb@nightclub@lazlow@hi_podium@")
                  print("request anim@amb@nightclub@lazlow@hi_podium@")
                  return HANDLER_CONTINUE
                end
                if not streaming.has_anim_dict_loaded("anim@amb@nightclub@lazlow@hi_railing@")then
                  streaming.request_anim_dict("anim@amb@nightclub@lazlow@hi_railing@")
                  print("request anim@amb@nightclub@lazlow@hi_railing@")
                  return HANDLER_CONTINUE
                end
                if not streaming.has_anim_dict_loaded("anim@amb@nightclub@mini@dance@dance_solo@female@var_a@")then
                  streaming.request_anim_dict("anim@amb@nightclub@mini@dance@dance_solo@female@var_a@")
                  print("request anim@amb@nightclub@mini@dance@dance_solo@female@var_b@")
                  return HANDLER_CONTINUE
                end
                if not streaming.has_anim_dict_loaded("anim@amb@nightclub@mini@dance@dance_solo@female@var_b@")then
                  streaming.request_anim_dict("anim@amb@nightclub@mini@dance@dance_solo@female@var_b@")
                  print("request anim@amb@nightclub@mini@dance@dance_solo@female@var_b@")
                  return HANDLER_CONTINUE
                end
                --if not streaming.has_anim_set_loaded("priv_dance_p2")then
                --  streaming.request_anim_set("priv_dance_p2")
                --  print("request priv_dance_p2")
                --  return HANDLER_CONTINUE
                --end

                pos =  entity.get_entity_coords(player.get_player_ped(player.player_id()))
                local oldCord = pos
                local newCord = entity.get_entity_coords(tempped)
                local tempdistance = math.sqrt((newCord['x'] - oldCord['x'])^2 + (newCord['y'] - oldCord['y'])^2 + (newCord['z'] - oldCord['z'])^2)

                if tempdistance < 10 then
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
                  local ran = math.random(30)
                  if pedList[i] == nil then
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
                    elseif ran == 11  then
                      ai.task_play_anim(tempped,"amb@code_human_on_bike_idles@police@front@idle_a","idle_a",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 12  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_13_crotchgrab_laz",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 13  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_11_turnaround_laz",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 14  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_17_smackthat_laz",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 15  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_17_spiderman_laz",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 16  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@lazlow@hi_railing@","ambclub_09_mi_hi_bellydancer_laz",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 17  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","high_left_up",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 18  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","high_center",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 19  then
                      ai.task_play_anim(tempped,"@amb@nightclub@mini@dance@dance_solo@female@var_b@","high_center",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 20  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@","med_center",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 21  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@","med_center_down",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 22  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","med_center",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 23  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","low_center",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 24  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","low_center_down",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 25  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","low_center_up",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 26  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","high_center_up",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 27  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","high_center_down",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 28  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@","high_center",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 29  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@","high_center",8.0,8.0,-1,1,0,true,true,true)
                    elseif ran == 30  then
                      ai.task_play_anim(tempped,"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@","high_center",8.0,8.0,-1,1,0,true,true,true)
                    else
                      print(ran .. " is an unknown scenario")
                    end
                    partyPeds[tempped] = 1
                  end
                end
              else
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
    -- Checks for new player vehicle
    if lastVehicle ~= ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())) then
      noCollisionList = {}
      lastVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    end
    for i in ipairs(vehicle.get_all_vehicles())do
      local tempveh = vehicle.get_all_vehicles()[i]
      if slot ~= player.player_id() then
        if(noCollisionList == nil) then noCollisionList = {} end
        if noCollisionList[tempveh] == nil then

          --if not ped.is_ped_a_player(tempped) then
          -- if ped.is_ped_in_any_vehicle(tempped) then
          local playerPed = player.get_player_ped(player.player_id())
          if(playerPed ~= nil) then
            local myveh = ped.get_vehicle_ped_is_using(playerPed)
            if myveh ~= nil then
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
    end
  end
  if noCollissionmenu.on then
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end


local noCollisionObjList = {}

function noObjectCollision()
  if noCollissionObjmenu.on then
    local playerPed = player.get_player_ped(player.player_id())
    if(playerPed ~= nil) then
      local myveh = ped.get_vehicle_ped_is_using(playerPed)
      local newCord = entity.get_entity_coords(myveh)
      for i in ipairs(object.get_all_objects())do
        local tempObj = object.get_all_objects()[i]
        if slot ~= player.player_id() then
          local oldCord = entity.get_entity_coords(tempObj)
          local tempdistance = math.sqrt((newCord['x'] - oldCord['x'])^2 + (newCord['y'] - oldCord['y'])^2 + (newCord['z'] - oldCord['z'])^2)
          if tempdistance <= 10 then
            if noCollisionObjList[tempObj] == nil then
              if myveh ~= nil then
                if not network.has_control_of_entity(tempObj) then
                  network.request_control_of_entity(tempObj)
                end
                entity.set_entity_no_collsion_entity(tempObj,myveh,false)
                noCollisionObjList[tempObj] = true
              end
            end
          end
        end
      end
    end
  end
  if noCollissionObjmenu.on then
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
    local tempdistance = math.sqrt((newCord['x'] - oldCord['x'])^2 + (newCord['y'] - oldCord['y'])^2 + (newCord['z'] - oldCord['z'])^2)

    if player.is_player_valid(slot) and slot ~= player.player_id() and storage[player.get_player_name(slot)] == nil then
      if tempdistance <= distance then
        -- send corona warning
        menu.notify("Send " .. player.get_player_name(slot) .. " a Corona Warning","ZeroMenu",5,140)
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
    if f.value > distance then
      distance = distance+100
    else
      distance = distance-100
    end

    distanceWarning.value = distance
  end)
  config:saveIfNotExist("cfdistance",tonumber(distance))
  config:saveIfNotExist("cfdistancemax",10000)


  distanceWarning.max = tonumber(config:getValue("cfdistancemax"))
  distanceWarning.value = tonumber(config:getValue("cfdistance"))

  adsettings = menu.add_feature("Anti Depressor", "parent", parent.id, nil)


  distanceTP = menu.add_feature("Distance Blocking", "autoaction_value_i", adsettings.id, function(f)
    if f.value > distance then
      distance = distance+100
    else
      distance = distance-100
    end

    distanceTP.value = distance
  end)

  config:saveIfNotExist("addistance",distance)
  config:saveIfNotExist("addistancemax",10000)

  distanceTP.max = tonumber(config:getValue("addistancemax"))
  distanceTP.value = tonumber(config:getValue("addistance"))

  speed = menu.add_feature("New Speed", "autoaction_value_i", adsettings.id, function(f)
    if f.value > newSpeed then
      newSpeed = newSpeed+100
    else
      newSpeed = newSpeed-100
    end

    speed.value = newSpeed
  end)

  config:saveIfNotExist("adspeed",newSpeed)
  config:saveIfNotExist("adspeedmax",10000)
  config:saveIfNotExist("adspeedmin",-1000)

  speed.max = tonumber(config:getValue("adspeedmax"))
  speed.min = tonumber(config:getValue("adspeedmin"))
  speed.value = tonumber(config:getValue("adspeed"))



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
  oppressor.on = config:isFeatureEnabled("blockomk2")


  mk1 = menu.add_feature("Oppressor", "toggle", adsettings.id,nil)
  mk1.on = config:isFeatureEnabled("blockomk1")


  b11 = menu.add_feature("B-11", "toggle", adsettings.id,nil)
  b11.on = config:isFeatureEnabled("blockb11")

  hydra = menu.add_feature("Hydra", "toggle", adsettings.id,nil)
  hydra.on = config:isFeatureEnabled("blockhydra")

  lazer = menu.add_feature("Lazer", "toggle", adsettings.id,nil)
  lazer.on = config:isFeatureEnabled("blocklazer")

  deluxo  = menu.add_feature("Deluxo", "toggle", adsettings.id,nil)
  deluxo.on = config:isFeatureEnabled("blockdeluxo")

  akula = menu.add_feature("Akula", "toggle", adsettings.id,nil)
  akula.on = config:isFeatureEnabled("blockakula")

  team = menu.add_feature("Ignore Team", "toggle", adsettings.id,nil)
  team.on = config:isFeatureEnabled("blockignoreteam")

  friends = menu.add_feature("Ignore Friends", "toggle", adsettings.id,nil)
  friends.on = config:isFeatureEnabled("blockignorefrieds")

  max_speed_grief = menu.add_feature("Grief Max Speed", "toggle", adsettings.id,nil)
  max_speed_grief.on = config:isFeatureEnabled("blockgriefspeed")

end

function checkForDepressor()
  for slot = 0, 31 do
    local oldCord = player.get_player_coords(slot)
    local newCord = getMySelfCoords()
    local tempdistance = math.sqrt((newCord['x'] - oldCord['x'])^2 + (newCord['y'] - oldCord['y'])^2 + (newCord['z'] - oldCord['z'])^2)

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
                menu.notify("Trying to stop " .. vehicleHashToName(entity.get_entity_model_hash(veh)) .. " with player " .. player.get_player_name(slot),"ZeroMenu",5,140)
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
  if (hash == VehicleHash.B11 and b11.on) or
    (hash == VehicleHash.MK1 and mk1.on) or
    (hash == VehicleHash.AKULA and akula.on) or
    (hash == VehicleHash.DELUXO and deluxo.on) or
    (hash == VehicleHash.HYDRA and hydra.on) or
    (hash == VehicleHash.LAZER  and lazer.on) or
    (hash == VehicleHash.MK2 and oppressor.on)
  then
    return true
  end
  return false
end
