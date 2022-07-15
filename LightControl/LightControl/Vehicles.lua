require('LigtControl')

--Gets Current Vehicle
local Update_Vehicle = menu.add_feature("OwnVehh | AlwaysOn", "toggle", _Settings, function(feat)
while feat.on do
   if (ped.is_ped_in_any_vehicle(OwnPedd)) then
      OwnVehh = ped.get_vehicle_ped_is_using(OwnPedd)
   end
   system.wait(100)
end
end) Update_Vehicle:toggle()


tankvolume = 65
tank = math.random(15, 50)
tank_damaged = false
fuel_can_level = 20
fuel_blips = {{}, {}}

function isplane(OwnVehh)
  local hash = entity.get_entity_model_hash(OwnVehh)
  if (contains2(Planes, hash, 1)) then
    return true
  end
  return false
end

ground_blips = false
aviation_blips = false

function draw_suitable_blips()
--draw/remove blips
if not(isplane(OwnVehh) and ped.is_ped_in_any_vehicle(OwnPedd)) then
  if (ground_blips ~= true) then
     for b=1, #fuel_stations.ground do
          fuel_blips[1][b] = ui.add_blip_for_coord(v3(fuel_stations.ground[b][1].x, fuel_stations.ground[b][1].y, 0))
          ui.set_blip_sprite(fuel_blips[1][b], 361)
          ui.set_blip_colour(fuel_blips[1][b], 17)
     end
	 if (aviation_blips == true) then
	      for b=1, #fuel_blips[2] do
          ui.remove_blip(fuel_blips[2][b])
          end
	 end 
	 ground_blips = true
	 aviation_blips = false
   end 
elseif (isplane(OwnVehh)) then
  if (aviation_blips ~= true) then
     for b=1, #fuel_stations.aviation do
          fuel_blips[2][b] = ui.add_blip_for_coord(v3(fuel_stations.aviation[b][1].x, fuel_stations.aviation[b][1].y, 0))
          ui.set_blip_sprite(fuel_blips[2][b], 361)
          ui.set_blip_colour(fuel_blips[2][b], 53)
     end
	 if (ground_blips == true) then
	      for b=1, #fuel_blips[1] do
          ui.remove_blip(fuel_blips[1][b])
          end
	 end
	 aviation_blips = true
	 ground_blips = false
  end
end

end
 
 
Feature16 = menu.add_feature("Fuel Consumption | Gas Stations | fuel can", "toggle", fuel_consumption, function(feat)
if feat.on then
     if (isplane(OwnVehh)) then
	     local hash = entity.get_entity_model_hash(OwnVehh)
         tankvolume = Planes[contains_return_index2(Planes, hash, 1)][2]
		 used_tankvolumina = {tankvolume}
		 tank = math.random(0.2*tankvolume, 0.7*tankvolume)
		 used_vehicles = {ped.get_vehicle_ped_is_using(OwnPedd)}
		 used_tanks = {tank}
     else
         used_vehicles = {ped.get_vehicle_ped_is_using(OwnPedd)}
         used_tanks = {tank}
         used_tankvolumina = {tankvolume}
	 end
     actual_veh_index = 1	 
	 draw_suitable_blips()
end

while feat.on do
     draw_suitable_blips()
	 
	 if (isplane(OwnVehh)) then
	    plane = true
	 else
	    plane = false
	 end
	 
	 hash = entity.get_entity_model_hash(OwnVehh)
     if not(contains(used_vehicles, OwnVehh, #used_vehicles)) then
          used_vehicles[#used_vehicles + 1] = OwnVehh		  
		  if (plane == true) then
		      tankvolume = Planes[contains_return_index2(Planes, hash, 1)][2]
              used_tankvolumina[#used_tankvolumina + 1] = tankvolume
		      tank = math.random(0.2*tankvolume, 0.7*tankvolume)
		  else
              tank = math.random(3, 50)
              tankvolume = math.random(40, 90)
		  end		  
          used_tanks[#used_tanks + 1] = tank
          used_tankvolumina[#used_tankvolumina + 1] = tankvolume
     elseif (contains(used_vehicles, OwnVehh, #used_vehicles)) then
          if (actual_veh_index ~= contains_return_index(used_vehicles, OwnVehh)) then
               tank = used_tanks[ contains_return_index(used_vehicles, OwnVehh) ] --only if changed cars
               tankvolume = used_tankvolumina[ contains_return_index(used_vehicles, OwnVehh) ]
          end
          used_tanks[ contains_return_index(used_vehicles, OwnVehh) ] = tank
          used_tankvolumina[ contains_return_index(used_vehicles, OwnVehh) ] = tankvolume
     end
     actual_veh_index = contains_return_index(used_vehicles, OwnVehh)


     if (ped.is_ped_in_any_vehicle(OwnPedd)) then
          current_speed = entity.get_entity_speed(OwnVehh) * 2 -- in km/h
          if (current_speed >= 20) then
		        if (plane == true) then
				    fuel_consumption = Planes[contains_return_index2(Planes, hash, 1)][3] * math.exp(6*10^(-3)*current_speed)/10000
				else
                    fuel_consumption = 3.24 * math.exp(6*10^(-3)*current_speed)/10000
			    end
          elseif (current_speed < 20 and current_speed >= 1) then
		       if (plane == true) then
			       fuel_consumption = Planes[contains_return_index2(Planes, hash, 1)][3] * math.exp(-0.09*current_speed)/10000
			   else
                   fuel_consumption = 18 * math.exp(-0.09*current_speed)/10000
			   end
          elseif (current_speed < 1) then
		       if (plane == true) then
			       fuel_consumption = 0.1/1000
			   else
                   fuel_consumption = 0.1/10000
			   end
          end

          local pos_start = entity.get_entity_coords(OwnVehh)
          if not (tank <= 0) then system.wait(1000) end
          local pos_end = entity.get_entity_coords(OwnVehh)
          local s = vector_amount(v3(pos_start.x-pos_end.x , pos_start.y-pos_end.y , pos_start.z-pos_end.z)) -- vermutlich meter
          local consumed = fuel_consumption*s
          if not(tank <= 0) then
               tank = tank - consumed -- in liter
          end
          if (tank <= 0) then
               vehicle.set_vehicle_engine_on(OwnVehh, false, true, true)
          end

          if (tank_damaged ~= true and vehicle.is_vehicle_damaged(OwnVehh)) then
               if (math.random(1, 1000) > 990) then
                    tank_damaged = true -- low % of event
                    menu.notify("tank damaged", math.ceil(tank) .. "  l  /  "..tankvolume .."  l", 2, notify_color2)
               else
                    tank_damaged = false
               end
          end
     end

     if (tank_damaged == true and tank > 0) then
	    if (plane == true) then
          tank = tank - 0.001*tankvolume
		else
		  tank = tank - 0.01
		end
          system.wait(300)
     end

     --Refueling Process
     if (current_speed ~= nil and current_speed < 10 and ped.get_current_ped_weapon(OwnPedd) ~= 883325847) then
          local pos = entity.get_entity_coords(OwnVehh)
          local start_tank_volume = tank
		  if (plane == true) then
		     table_to_loop = fuel_stations.aviation
		  else
		     table_to_loop = fuel_stations.ground
		  end
		  
		  
          for i=1, #table_to_loop do
			   if (Distance2(table_to_loop[i][1], OwnVehh) <= table_to_loop[i][2] and tank < tankvolume) then
                    menu.notify("Refuel / stop", "hold E", 1, notify_color3)
                    if (isKeyDown(0x45)) then
                         for a=math.ceil(tank) , tankvolume do
                              if (entity.get_entity_speed(OwnVehh) < 1) then
							       if (plane == true) then
								       if (tank + 10 <= tankvolume) then
                                           tank = tank + 10
									   else
									       tank = tankvolume
									   end
								   else
								       if (tank + 1 <= tankvolume) then
                                           tank = tank + 1
									   else
									       tank = tankvolume
									   end
								   end
                                   menu.notify(math.ceil(tank) .. "  l  /  "..tankvolume .."  l", "", 1, notify_color3)
                                   system.wait(1000)
                              end
                              if (isKeyDown(0x45))then
                                   menu.notify("tanked: ".. math.abs(math.ceil(start_tank_volume)-tank) .."  l", math.ceil(tank) .. "  l  /  "..tankvolume .."  l", 4, notify_color3)
                                   audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
                                   system.wait(4000)
                                   break
                              end
                              if (tank >= tankvolume) then
                                   menu.notify("tanked: ".. math.abs(math.ceil(start_tank_volume)-tank) .."  l","full "..math.ceil(tank) .. "  l  /  "..tankvolume .."  l", 4, notify_color3)
                                   audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
                                   system.wait(4000)
                                   break
                              end
                         end
                    end

                    if(tank_damaged == true) then
                         menu.notify("repair fuel tank", "hold Y", 1, notify_color2)
                         if (isKeyDown(0x59)) then
                              tank_damaged = false
                              vehicle.set_vehicle_fixed(OwnVehh)
                              audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
                              tank = 0
                              menu.notify("fuel tank repaired", math.ceil(tank) .. "  l  /  "..tankvolume .."  l", 4, notify_color3)
                              audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
                              system.wait(4000)
                         end
                    end
               end
          end
     end

     --refuel with fuel can
     if (ped.get_current_ped_weapon(OwnPedd) == 883325847 and ped.is_ped_in_any_vehicle(OwnPedd) == false and Distance(OwnVehh, OwnPedd) < 5) then
          menu.notify("Refuel", "hold E", 1, notify_color3)
          if (isKeyDown(0x45)) then
               local start_fuel_can_level = fuel_can_level
               for i=1 , fuel_can_level do
                    if (ped.is_ped_in_any_vehicle(OwnPedd)) then
                         menu.notify("finished","tanked: "..start_fuel_can_level - fuel_can_level.."  l ", 4, notify_color3)
                         break
                    end
                    if (tank < tankvolume and fuel_can_level >= 1) then
                         tank = tank + 1
                         fuel_can_level = fuel_can_level - 1
                         menu.notify("refueling", math.ceil(tank) .. "  l  /  "..tankvolume .."  l", 1, notify_color3)
                         system.wait(1000)
                    end
                    if (tank >= tankvolume) then
                         menu.notify("finished","tanked: "..start_fuel_can_level - fuel_can_level.."  l ", 4, notify_color3)
                         audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
                         system.wait(4000)
                         break
                    end
                    if isKeyDown(0x45) then
                         menu.notify("finished","tanked: "..start_fuel_can_level - fuel_can_level.."  l ", 4, notify_color3)
                         audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
                         system.wait(4000)
                         break
                    end
                    if (fuel_can_level <= 0) then
                         weapon.remove_weapon_from_ped(OwnPedd, 883325847)
                         audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
                         menu.notify("fuel can clear","tanked: "..start_fuel_can_level - fuel_can_level.."  l ", 4, notify_color3)
                         break
                    end
               end
          end
     end
    
	if (tank <= 0.02 * tankvolume and tank >= 0) then
	   audio.play_sound_from_entity(-1, "TIMER_STOP" , OwnVehh, "HUD_MINI_GAME_SOUNDSET")
       system.wait(400)
	end
    system.wait(0)
end

if not feat.on then
   if (ground_blips == true) then
     for b=1, #fuel_blips[1] do
          ui.remove_blip(fuel_blips[1][b])
     end
   end
   if (aviation_blips == true) then
	 for b=1, #fuel_blips[2] do
          ui.remove_blip(fuel_blips[2][b])
     end
   end
   ground_blips = false
   aviation_blips = false
end
end)

--removes blips when script is unloaded
event.add_event_listener("exit", function()
    if (fuel_blips) then
       if (ground_blips == true) then
          for b=1, #fuel_blips[1] do
          ui.remove_blip(fuel_blips[1][b])
          end
       end
       if (aviation_blips == true) then
	      for b=1, #fuel_blips[2] do
          ui.remove_blip(fuel_blips[2][b])
          end
       end
	end
end)


menu.add_feature("find closest fuel station", "action", fuel_consumption, function()
local returnindex = 1
   local distance = {}
   local lowestdistance = Distance2(fuel_stations.ground[1][1], OwnVehh)
   
   if (isplane(OwnVehh)) then
   table_to_loop2 = fuel_stations.aviation
   else
   table_to_loop2 = fuel_stations.ground
   end
   
   for i=1, #table_to_loop2 do
   distance[i] = Distance2(table_to_loop2[i][1], OwnVehh)
      if (i > 1 and distance[i] < lowestdistance) then
	        lowestdistance = distance[i]
	        returnindex = i
      end
   end  
   if (returnindex) then menu.notify("fuel station "..returnindex, "new waypoint", 2, notify_color3) end
   ui.set_waypoint_off()
   ui.set_new_waypoint(table_to_loop2[returnindex][1])
end)


menu.add_feature("show tank", "action", fuel_consumption, function()
if (tank <= 8 and tank > 0) then
   menu.notify("low tank", round(tank, 2).."  L / "..tankvolume.."  L", 2, notify_color2)
elseif (tank <= 0) then
   menu.notify("out of fuel", round(tank, 2).."  L / "..tankvolume.."  L", 2, 255)
   audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
elseif (tank > 8) then
   menu.notify("tank", round(tank, 2).."  L / "..tankvolume.."  L", 2, notify_color3)
end
end)

local customs = menu.add_feature("custom tank", "action_value_str", fuel_consumption, function(feat)
local response, value = input.get("set tank", "set tank", 5, 5)
    if (response == 1) then
      return HANDLER_CONTINUE
    end
    if (response == 2) then
      return HANDLER_POP
    end
	
	if (feat.value == 0) then
       if (tonumber(value) > tankvolume) then
         tank = tankvolume
       else
         tank = tonumber(value)
         used_tanks[ contains_return_index(used_vehicles, OwnVehh) ] = tank
       end
	end
	if (feat.value == 1) then
	tankvolume = tonumber(value)
	used_tankvolumina[ contains_return_index(used_vehicles, OwnVehh) ] = tankvolume
	end
--
end)
customs:set_str_data({"tank", "tankvolume"})


Feature17 = menu.add_feature("License plate", "value_str", fuel_consumption, function(feat)
while feat.on do
   if (feat.value == 0) then
      vehicle.set_vehicle_number_plate_text(OwnVehh, tostring(round(tank, 3)).. " l")
   elseif (feat.value == 1) then
      vehicle.set_vehicle_number_plate_text(OwnVehh, tostring(round(fuel_consumption*10000, 4).." L"))
   elseif (feat.value == 2) then
      vehicle.set_vehicle_number_plate_text(OwnVehh, tostring(round(fuel_consumption, 4).." L"))
   elseif (feat.value == 3) then
      vehicle.set_vehicle_number_plate_text(OwnVehh, tostring(round(current_speed, 2)).. "kmh")
   end
   system.wait(500)
end
end)
Feature17:set_str_data({"tank", "consumption", "- fuel", "speed"})


--Stop and Go
Feature5 = menu.add_feature("Auto Start and Stop Engine", "toggle", Vehicles, function(feat)
_Engine = 0
if feat.on then
   if (ped.is_ped_in_any_vehicle(OwnPedd)) then
   menu.notify("klick 'w' to turn the engine on again"," ", 4, notify_color1)
   end
end
while feat.on do
   if (entity.get_entity_speed(OwnVehh) == 0 and _Engine == 0 and ped.is_ped_in_vehicle(OwnPedd, OwnVehh)) then
      vehicle.set_vehicle_engine_on(OwnVehh, false, true, true)
      _Engine = 1
   end
   if (controls.is_control_just_pressed(0, 71)and _Engine == 1 and ped.is_ped_in_vehicle(OwnPedd, OwnVehh)) then
      vehicle.set_vehicle_engine_on(OwnVehh, true, false, false)
      system.wait(400)
      _Engine = 0
   end
   system.wait(10)
end
end)

--Auto warning Lights
Feature6 = menu.add_feature("Auto Warning Lights", "value_str", Vehicles, function(feat)
while feat.on do
   if((feat.value == 0 and vehicle.is_vehicle_damaged(OwnVehh)))
   --[[or (feat.value == 1 and (vehicle.get_vehicle_wheel_health(OwnVehh, 1) ~= nil and vehicle.get_vehicle_wheel_health(OwnVehh, 1) <= 900))--]] then
   vehicle.toggle_vehicle_mod(OwnVehh, 22, true)
   vehicle.set_vehicle_headlight_color(OwnVehh, 7)
   system.wait(450)
   vehicle.set_vehicle_headlight_color(OwnVehh, 0)
   system.wait(450)
end
if (ped.is_ped_in_vehicle(OwnPedd, OwnVehh) == false and vehicle.is_vehicle_damaged(OwnVehh)) then
   vehicle.set_vehicle_engine_on(OwnVehh, true, true, false)
end
system.wait(100)
end
end)
Feature6:set_str_data({"Sensitive"--[[, "Not so Sensitive"--]]})

--Auto Parking Sounds
Feature7 = menu.add_feature("Auto Parking sounds", "value_str", Vehicles, function(feat)
if feat.on then
AttatchObjecttoVehBone("headlight_l", OwnVehh, 1803116220, v3(0,0,0), false)
local Headlight_Left = _Object
AttatchObjecttoVehBone("headlight_r", OwnVehh, 1803116220, v3(0,0,0), false)
local Headlight_Right = _Object
AttatchObjecttoVehBone("taillight_l", OwnVehh, 1803116220, v3(0,0,0), false)
local Taillight_left = _Object
AttatchObjecttoVehBone("taillight_r", OwnVehh, 1803116220, v3(0,0,0), false)
local Taillight_Right = _Object
AttatchObjecttoVehBone("handle_dside_f", OwnVehh, 1803116220, v3(0,0,0), false)
local handle_dside_f = _Object
AttatchObjecttoVehBone("handle_pside_f", OwnVehh, 1803116220, v3(0,0,0), false)
local handle_pside_f = _Object

while feat.on do
   local allveh = vehicle.get_all_vehicles()
   for i=1, #allveh do
      if (ped.is_ped_in_vehicle(OwnPedd, OwnVehh) and allveh[i] ~= OwnVehh) then
         if (Distance(allveh[i], Headlight_Left) <=4
         or Distance(allveh[i], Headlight_Right) <=4
         or Distance(allveh[i], Taillight_left) <=4
         or Distance(allveh[i], Taillight_Right) <=4
         or Distance(allveh[i], handle_dside_f) <=4
         or Distance(allveh[i], handle_pside_f) <=4)
         then
            if (feat.value == 1) then
               audio.play_sound_from_entity(-1, "5_SEC_WARNING" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
               -- audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
               system.wait(math.ceil(100*math.log(Distance(allveh[i], OwnVehh))+0.1))
            end
            if (feat.value == 0 and entity.get_entity_speed(OwnVehh) ~= 0 and entity.get_entity_speed(OwnVehh) <=15) then
               audio.play_sound_from_entity(-1, "5_SEC_WARNING" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
               -- audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
               system.wait(math.ceil(100*math.log(Distance(allveh[i], OwnVehh))+0.1))
            end
         end
      end
   end
   if (feat.value == 2) then
      local allpeds = ped.get_all_peds()
      for i=1, #allpeds do
         if (ped.is_ped_in_vehicle(OwnPedd, OwnVehh) and allpeds[i] ~= OwnPedd and entity.get_entity_speed(OwnVehh) ~= 0 and entity.get_entity_speed(OwnVehh) <=15) then
            if (Distance(allpeds[i], Headlight_Left) <=4
            or Distance(allpeds[i], Headlight_Right) <=4
            or Distance(allpeds[i], Taillight_left) <=4
            or Distance(allpeds[i], Taillight_Right) <=4
            or Distance(allpeds[i], handle_dside_f) <=4
            or Distance(allpeds[i], handle_pside_f) <=4)
            then
               audio.play_sound_from_entity(-1, "CONFIRM_BEEP" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
               system.wait(math.ceil(100*math.log(Distance(allveh[i], OwnVehh))+0.1))
            end
         end
      end
   end
   system.wait(10)
end
end
end)
Feature7:set_str_data({"Auto Sound", "Always Beep", "Auto + Peds"})


function get_front_vehicle()
   local allveh = vehicle.get_all_vehicles()
   local OwnVehh_forward_vector = entity.get_entity_forward_vector(OwnVehh)
   local OwnVehh_Pos = entity.get_entity_coords(OwnVehh)

   for i=1, #allveh do
      local allveh_forward_vector = entity.get_entity_forward_vector(allveh[i])
      local allveh_Pos = entity.get_entity_coords(allveh[i])

      --Winkel zwischen forward Vektoren von allveh und Ownvehh
      local angle = vector_angle(OwnVehh_forward_vector, allveh_forward_vector)
      --Vektor zwischen allveh und Ownvehh
      local Vector_Ownvehh_Allveh = v3(allveh_Pos.x-OwnVehh_Pos.x, allveh_Pos.y-OwnVehh_Pos.y, allveh_Pos.z-OwnVehh_Pos.z)
      local angle2 = vector_angle(OwnVehh_forward_vector, Vector_Ownvehh_Allveh)

      if (angle <=20 and angle2 <=40 and Distance(OwnVehh, allveh[i]) <=30 and allveh[i] ~= OwnVehh and entity.get_entity_speed(allveh[i])~= 0) then
         frontvehicle = allveh[i]
         return frontvehicle
      end
   end
end

--[[
function get_front_vehicle()
   local allveh = vehicle.get_all_vehicles()
   local OwnVehh_forward_vector = entity.get_entity_forward_vector(OwnVehh)
   local OwnVehh_Pos = entity.get_entity_coords(OwnVehh)
   local dist = {}
   for i=1, #allveh do
      local allveh_forward_vector = entity.get_entity_forward_vector(allveh[i])
      local allveh_Pos = entity.get_entity_coords(allveh[i])
      --Winkel zwischen forward Vektoren von allveh und Ownvehh
      local angle = vector_angle(OwnVehh_forward_vector, allveh_forward_vector)
      --Vektor zwischen allveh und Ownvehh
      local Vector_Ownvehh_Allveh = v3(allveh_Pos.x-OwnVehh_Pos.x, allveh_Pos.y-OwnVehh_Pos.y, allveh_Pos.z-OwnVehh_Pos.z)
      local angle2 = vector_angle(OwnVehh_forward_vector, Vector_Ownvehh_Allveh)
	  
      dist[i] = Distance(OwnVehh, allveh[i])
      if i > 1 then
        if (dist[i] < dist[i-1] and dist[i] <= 50 and angle <= 20 and angle2 <= 40 and allveh[i] ~= OwnVehh and entity.get_entity_speed(allveh[i]) ~= 0) then
		frontvehicle = allveh[i]
		end
	  end
	  if (i == #allveh) then     
         return frontvehicle
	  end
   end
end
--]]

--[[
menu.add_feature("TEST frontveh", "action", Vehicles, function()
local frontveh = get_front_vehicle()
entity.delete_entity(frontveh)
end)
--]]

local distance = menu.add_feature("hold distance to frontveh", "value_i", Vehicles, function(feat)
if feat.on then
   get_front_vehicle()
end
while feat.on do
   get_front_vehicle()
   if ( frontvehicle and vehicle.is_vehicle_on_all_wheels(OwnVehh)) then  --if distance > or < Sollwert feat.value then Korrigiere Abstand mittels geschwindi+gkeit
      if not (isKeyDown(0x57) or isKeyDown(0x53)) then
         local Followspeed = entity.get_entity_speed(frontvehicle)
         local distance = Distance(OwnVehh, frontvehicle)
         if (distance >= feat.value-5 and distance <= feat.value+5 and Followspeed ~= 0) then
            vehicle.set_vehicle_forward_speed(OwnVehh, Followspeed)
         elseif (distance > feat.value+5 and Followspeed ~= 0) then
            vehicle.set_vehicle_forward_speed(OwnVehh, Followspeed+2)
           -- menu.notify("Ausgleich", "schneller", 1, _NotificationColor)
         elseif (distance < feat.value-5 and Followspeed > 2) then
            vehicle.set_vehicle_forward_speed(OwnVehh, Followspeed-2)
         end
		 
		--[[ if (distance > 0.9*feat.value and distance < 1.1*feat.value and Followspeed ~= 0) then
		 vehicle.set_vehicle_forward_speed(OwnVehh, Followspeed+0.2*distance)
		 end
		 if (distance >= 1.1*feat.value and Followspeed ~= 0) then
		 vehicle.set_vehicle_forward_speed(OwnVehh, Followspeed+0.2*distance)
		 end
		 if (distance <= 0.9*feat.value and distance >= 8 and Followspeed >= Followspeed-0.2*distance) then
		 vehicle.set_vehicle_forward_speed(OwnVehh, Followspeed-0.2*distance)
		 end
		 if (distance < 8 ) then
		 vehicle.set_vehicle_forward_speed(OwnVehh, 0)
		 end--]]
		 
      end
   end
   system.wait(500)
end
end)
distance.min = 10
distance.mod = 5
distance.max = 60
distance.value = 15

Feature1 = menu.add_feature("cruise control", "value_str", Vehicles, function(feat)
if feat.on then
   wantedvelocity = entity.get_entity_speed(OwnVehh)
end
while feat.on do
   if (ped.is_ped_in_any_vehicle(OwnPedd)) then
      if not (isKeyDown(0x57) or isKeyDown(0x53) or isKeyDown(0x41) or isKeyDown(0x44) or vehicle.is_vehicle_on_all_wheels(OwnVehh) == false) then
         if not (vehicle.is_vehicle_damaged(OwnVehh)) then
            vehicle.set_vehicle_forward_speed(OwnVehh, wantedvelocity)
         end
      end
      if isKeyDown(0x57) then
         wantedvelocity = entity.get_entity_speed(OwnVehh)
         menu.notify(" ", "+", 1, notify_color1)
      end
      if (isKeyDown(0x53) and entity.get_entity_speed(OwnVehh)~= 0) then
         wantedvelocity = entity.get_entity_speed(OwnVehh)
         menu.notify(" ", "-", 1, notify_color1)
      end
      system.wait(200)
   end
end
end)
Feature1:set_str_data({"Auto Mode"--[[, "Disable after Crash"--]]})


--Stancing Vehicle
menu.add_feature("Stance Max", "action", Vehicles, function()
entity.set_entity_god_mode(OwnVehh, true)
vehicle.set_vehicle_bulletproof_tires(OwnVehh, false)
vehicle.set_vehicle_wheel_health(OwnVehh, 1, 1)
vehicle.set_vehicle_wheel_health(OwnVehh, 3, 1)
vehicle.set_vehicle_wheel_health(OwnVehh, 2, 1)
vehicle.set_vehicle_wheel_health(OwnVehh, 4, 1)
vehicle.set_vehicle_forward_speed(OwnVehh, 0.1) --WIP only if entity velocity == 0
menu.notify("stancing completed", " ", 1, notify_color1)
end)

--Stancing Vehicle with value
Feature2 = menu.add_feature("Stance | Unstance", "value_f", Vehicles, function(feat)
if feat.on then
   entity.set_entity_god_mode(OwnVehh, true)
   vehicle.set_vehicle_bulletproof_tires(OwnVehh, false)
   vehicle.set_vehicle_wheel_health(OwnVehh, 1, feat.value)
   vehicle.set_vehicle_wheel_health(OwnVehh, 4, feat.value)
   vehicle.set_vehicle_wheel_health(OwnVehh, 3, feat.value)
   vehicle.set_vehicle_wheel_health(OwnVehh, 2, feat.value)
   vehicle.set_vehicle_forward_speed(OwnVehh, 0.1)
   menu.notify("stancing completed", feat.value, 1, notify_color1)
   Features[2][3] = feat.value
end
end)
Feature2.min = 0
Feature2.max = 1000
Feature2.mod = 200
Feature2.value = Features[2][3]

--Vehicle suspension spam
menu.add_feature("suspension spam", "toggle", Vehicles, function(feat)
vehicle.set_vehicle_bulletproof_tires(OwnVehh, false)
while feat.on do
   vehicle.set_vehicle_wheel_health(OwnVehh, 1, 0)
   vehicle.set_vehicle_wheel_health(OwnVehh, 3, 0)
   vehicle.set_vehicle_wheel_health(OwnVehh, 2, 0)
   vehicle.set_vehicle_wheel_health(OwnVehh, 4, 0)
   system.wait(200)
   vehicle.set_vehicle_wheel_health(OwnVehh, 1, 1000)
   vehicle.set_vehicle_wheel_health(OwnVehh, 3, 1000)
   vehicle.set_vehicle_wheel_health(OwnVehh, 2, 1000)
   vehicle.set_vehicle_wheel_health(OwnVehh, 4, 1000)
   system.wait(200)
end
end)

--Radius of Removing Area
local radius = menu.add_feature("Set Remove Radius", "autoaction_value_i", Vehicles, function(feat)
Remove_Radius = feat.value
end)
radius.min = 10
radius.mod = 10
radius.max = 800
radius.value = 200

--Remove Entities
Feature3 = menu.add_feature("Remove Entities", "value_str", Vehicles, function(feat)
while feat.on do
   local allveh = vehicle.get_all_vehicles()
   if (feat.value == 1 or feat.value == 0) then
      for i = 1, #allveh do
         if (Distance(allveh[i], OwnPedd) <= Remove_Radius and allveh[i] ~= OwnVehh) then
            network.request_control_of_entity(allveh[i])
            entity.delete_entity(allveh[i])
         end
      end
   end
   if (feat.value == 2 or feat.value == 0) then
      local allped = ped.get_all_peds()
      for i = 1, #allped do
         if (Distance(allped[i], OwnPedd) <= Remove_Radius and allped[i] ~= OwnPedd) then
            network.request_control_of_entity(allped[i])
            entity.delete_entity(allped[i])
         end
      end
   end
   if (feat.value == 3 or feat.value == 0) then
      local allobj = object.get_all_objects()
      for i = 1, #allobj do
         if (Distance(allobj[i], OwnPedd) <= Remove_Radius) then
            network.request_control_of_entity(allobj[i])
            entity.delete_entity(allobj[i])
         end
      end
   end
   system.wait(20)
end
end)
Feature3:set_str_data({"All Entities", "Only Vehicles", "Only Peds", "Only Objects"})

--Set torque  /  Drehmoment
Feature4 = menu.add_feature("Change Torque", "value_f", Vehicles, function(feat)
if feat.on then
   vehicle.set_vehicle_engine_torque_multiplier_this_frame(OwnVehh, feat.value)
   Features[4][3] = feat.value
end
return HANDLER_CONTINUE
end)
Feature4.min = 0
Feature4.max = 100
Feature4.mod = 1
Feature4.value = Features[4][3]

--[[
--Auto stance WIP
menu.add_feature("Auto entry assistance WIP", "toggle", Vehicles, function(feat)
if feat.on then
menu.notify("Activate in Vehicle !!", " ", 1, 1)
local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
local entitypos = entity.get_entity_coords(player_veh)
local stance = 0

while feat.on do
   local playerpos = player.get_player_coords(player.player_id())
   local _Distance = math.sqrt((entitypos.x - playerpos.x)^2+(entitypos.y - playerpos.y)^2+(entitypos.z - playerpos.z)^2)
   if (_Distance < 5 and ped.is_ped_in_vehicle(OwnPedd, player_veh) == false and stance == 0) then
      vehicle.set_vehicle_wheel_health(player_veh, 1, 1)
      vehicle.set_vehicle_wheel_health(player_veh, 3, 1)
      vehicle.set_vehicle_wheel_health(player_veh, 2, 1)
      vehicle.set_vehicle_wheel_health(player_veh, 4, 1)
      vehicle.set_vehicle_forward_speed(player_veh, 0.01)
      stance = 1
   end
   if (_Distance >= 5 and ped.is_ped_in_vehicle(OwnPedd, player_veh) == false and stance == 1) then
      vehicle.set_vehicle_wheel_health(player_veh, 1, 1000)
      vehicle.set_vehicle_wheel_health(player_veh, 3, 1000)
      vehicle.set_vehicle_wheel_health(player_veh, 2, 1000)
      vehicle.set_vehicle_wheel_health(player_veh, 4, 1000)
      vehicle.set_vehicle_forward_speed(player_veh, 0.01)
      stance = 0
   end
   if (ped.is_ped_in_vehicle(OwnPedd, player_veh) == true and stance == 1) then
      vehicle.set_vehicle_wheel_health(player_veh, 1, 1000)
      vehicle.set_vehicle_wheel_health(player_veh, 3, 1000)
      vehicle.set_vehicle_wheel_health(player_veh, 2, 1000)
      vehicle.set_vehicle_wheel_health(player_veh, 4, 1000)
      vehicle.set_vehicle_forward_speed(player_veh, 0.01)
      stance = 0
   end
   system.wait(100)
end
end
end)--]]

-- Select the Animation
menu.add_feature("Select Smoke PTFX", "autoaction_value_str", PTFXoptions, function(feat)
selectedPTFX = Smokes[feat.value+1]
end):set_str_data({"ent_anim_dusty_hands", "bul_rubber_dust", "bul_gravel", "bul_gravel_heli", "exp_grd_plane_post", "bul_hay", "ent_anim_cig_exhale_mth_car"})
-- Select the Animation
menu.add_feature("Select Other PTFX", "autoaction_value_str", PTFXoptions, function(feat)
selectedPTFX = PTFXs[feat.value]
end):set_str_data({"muz_alternate_star_fp","ent_amb_sprinkler_golf","exp_grd_molotov_lod","muz_assault_rifle","ent_brk_sparking_wires","bul_stungun_metal","veh_backfire", "ent_sht_flame","exp_grd_grenade_lod","ent_dst_gen_gobstop","bul_concrete","ent_dst_elec_fire_sp","eject_auto","fire_petroltank_car_bullet","ent_ray_train_water_wash",})

--Time of Animation
local waittime = menu.add_feature("Set PTFX Wait Time", "value_f", PTFXoptions, function(feat)
PTFXWait = feat.value
end)
waittime.min = 20
waittime.value = 30
waittime.max = 2000
waittime.mod = 10

--Select Location of PTFX
menu.add_feature("Select VehicleBone", "autoaction_value_str", PTFXoptions, function(feat)
if (feat.value == 0) then
bone_index = {"exhaust", "exhaust_1", "exhaust_2", "exhaust_3", "exhaust_4", "exhaust_5"}
end
if (feat.value == 1) then
bone_index = {"wheel_rr", "wheel_rf", "wheel_lr", "wheel_lf"}
end
if (feat.value == 2) then
bone_index = {"engine"}
end

end):set_str_data({"Exhaust", "Tires", "Engine"})

--Attatch PTFX
Feature8 = menu.add_feature("Attatch ptfx", "value_f", PTFXoptions, function(feat)
if feat.on then
local veh = ped.get_vehicle_ped_is_using(OwnPedd)

for i = 1, #bone_index do
   if (vehicle.is_vehicle_engine_running(veh)) then
      while not streaming.has_model_loaded(1803116220) do
         streaming.request_model(1803116220)
         system.wait(10)
      end
      local pos = entity.get_entity_coords(veh)
      local boneindex = entity.get_entity_bone_index_by_name(veh, bone_index[i])
      local object = object.create_object(1803116220, pos, true, true)
      entity.set_entity_collision(object, false, false, false)
      entity.attach_entity_to_entity(object, veh, boneindex, v3(0, 0, 0), v3(0, 0, 0), true, false, false, 0, true)
      local Position = entity.get_entity_coords(object)

      graphics.set_next_ptfx_asset("core")
      while not graphics.has_named_ptfx_asset_loaded("core") do
         graphics.request_named_ptfx_asset("core")
         system.wait(20)
      end
      graphics.start_networked_particle_fx_non_looped_at_coord(selectedPTFX, Position, v3(0, 0, 0), feat.value, true, true, true)

      network.request_control_of_entity(object)
      entity.detach_entity(object)
      entity.delete_entity(object)
      system.wait(20)
   end
end

streaming.set_model_as_no_longer_needed(1803116220)
system.wait(PTFXWait)
Features[8][3] = feat.value
end
return HANDLER_CONTINUE
end)
Feature8.min = 0.5
Feature8.max = 8
Feature8.mod = 0.5
Feature8.value = Features[8][3]

--Horn Spam
menu.add_feature("Horn Spam", "toggle", Vehicles, function(feat)
if feat.on then
player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
end
while feat.on do
vehicle.start_vehicle_horn(player_veh, 1000, 0, false)--WIP TEST
system.wait(300)
end
end)

--Set Bulletproof Tires
menu.add_feature("Bulletproof Tires", "action", Vehicles, function()
local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
vehicle.set_vehicle_bulletproof_tires(player_veh, true)
end)

--Remove Godmode
menu.add_feature("Remove Godmode from aimed Entity", "action", Vehicles, function()
local selectedentity = player.get_entity_player_is_aiming_at(player.player_id())
entity.set_entity_god_mode(selectedentity, false)
menu.notify("Godmode Removed"," ", 1, notify_color1)
end)