require("ZeroMenuLib/Util/Util")
local selfMain,wander,startScenarioFeat,modelchangemain
local vs = require("ZeroMenuLib/enums/Scenarios")
local ds = require("ZeroMenuLib/enums/DrivingStyle")
local pm = require("ZeroMenuLib/enums/PedMapper")

function createSelfMenuEntry(parent,config)
  selfMain = menu.add_feature("Self", "parent", parent.id, nil)
  
  wander = createConfigedMenuOption("Wander Streets (Vehicle)","action_value_str",selfMain.id,wanderStreet,config,"wander",false,nil)
  wander.set_str_data(wander,ds.getDriveStyleList())
  
  startScenarioFeat = menu.add_feature("Start Scenario","action_value_str",selfMain.id,startScenario)
  startScenarioFeat.set_str_data(startScenarioFeat,vs)
  
  menu.add_feature("Start Dance","action",selfMain.id,dance) 
  menu.add_feature("Stop Scenario","action",selfMain.id,stopScenario)
  
  modelchangemain = menu.add_feature("Model Change","parent",selfMain.id,loadModelList)  
end

function loadModelList()
  local Peds = pm.GetAllHash()
  local idx = 0
  
  while idx < #Peds do
    idx = idx + 1
    local entry = Peds[idx]
    menu.add_feature(entry['name'],"action",modelchangemain.id,function()
      local pedHash = entry['hash']
      while not streaming.has_model_loaded(pedHash) do
        streaming.request_model(pedHash )
        system.wait(0)
      end
      player.set_player_model(pedHash)
      menu.notify("Changed to " .. entry['name'],"ZeroMenu",5,140)
    end)    
  end

end

function wanderStreet()
  local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  local temppedped = player.get_player_ped(player.player_id());
  if veh ~= nil then
    if not ai.is_task_active(temppedped,151)then
    local style = nil
      print(wander.value)
      print(#ds)
      if(wander.value+1 == (#ds-1)) then
        print("reading value " .. wander.value)
         style = ds[wander.value].id
      else
        style = ds[wander.value+1].id
      end
      
      ai.task_vehicle_drive_wander(temppedped,veh,200,style)
    end  
   end
   if wander.on then    
   else
    ped.clear_ped_tasks_immediately(temppedped)
	  vehicle.set_vehicle_forward_speed(veh, 2)
  end
end

function startScenario()
  local playerPed = player.get_player_ped(player.player_id())
  local pos = player.get_player_coords(player.player_id())
  ai.task_start_scenario_at_position(playerPed,vs[startScenarioFeat.value+1],pos,1,1000000,false,false) 
end

function stopScenario()
  local playerPed = player.get_player_ped(player.player_id())
  ped.clear_ped_tasks_immediately(playerPed)  
end

function dance()
  if not streaming.has_anim_dict_loaded("mini@strip_club@private_dance@part2")then
    streaming.request_anim_dict("mini@strip_club@private_dance@part2")
    return HANDLER_CONTINUE
  end
  if not streaming.has_anim_dict_loaded("anim@amb@nightclub@lazlow@hi_podium@")then
    streaming.request_anim_dict("anim@amb@nightclub@lazlow@hi_podium@")
    return HANDLER_CONTINUE
  end              
  if not streaming.has_anim_dict_loaded("anim@amb@nightclub@lazlow@hi_railing@")then
    streaming.request_anim_dict("anim@amb@nightclub@lazlow@hi_railing@")
    return HANDLER_CONTINUE
  end
  if not streaming.has_anim_dict_loaded("anim@amb@nightclub@mini@dance@dance_solo@female@var_a@")then
    streaming.request_anim_dict("anim@amb@nightclub@mini@dance@dance_solo@female@var_a@")
    return HANDLER_CONTINUE
  end
  if not streaming.has_anim_dict_loaded("anim@amb@nightclub@mini@dance@dance_solo@female@var_b@")then
    streaming.request_anim_dict("anim@amb@nightclub@mini@dance@dance_solo@female@var_b@")
    return HANDLER_CONTINUE
  end  
  if not streaming.has_anim_dict_loaded("amb@code_human_on_bike_idles@police@front@idle_a")then
    streaming.request_anim_dict("amb@code_human_on_bike_idles@police@front@idle_a")
    return HANDLER_CONTINUE
  end  
  local ran = math.random(30)
  local tempped = player.get_player_ped(player.player_id())
  local pos1 = player.get_player_coords(player.player_id())
  local teleport = false
  menu.notify("Starting dance with ran = " .. ran,"ZeroMenu",5,140) 
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
  end
end