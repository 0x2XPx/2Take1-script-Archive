require('LigtControl')

--Light Settings for all Escorts
Feature10 = menu.add_feature("Enable Emergency Lights", "toggle", Escortoptions, function(feat)
if feat.on then
   _Light = true
   menu.notify("Dont Shoot near Convoy while Feature is on !!", " ", 3, notify_color2)
end
if not feat.on then
   _Light = false
end
end)

--Autorepair Settings for all Escorts
Feature11 = menu.add_feature("Enable Auto Repair on Escort WIP", "toggle", Escortoptions, function(feat)
if feat.on then
   _Autorepair = true
end
if not feat.on then
   _Autorepair = false
end
end)

--Escort follow you
Feature12 = menu.add_feature("Set yourself Leading Vehicle", "toggle", Escortoptions, function(feat)
if feat.on then
   Leadingveh = true
end
if not feat.on then
   Leadingveh = false
end
end)

--Enable Marker
Feature13 = menu.add_feature("Mark Vehicles", "toggle", Escortoptions, function(feat)
if feat.on then
   _Marker = true
end
if not feat.on then
   _Marker = false
end
end)

--Enable Auto clear Way
Feature14 = menu.add_feature("Auto clear Way", "toggle", Escortoptions, function(feat)
if feat.on then
   _Autoclear = true
end
if not feat.on then
   _Autoclear = false
end
end)

--Enable Flags
Feature15 = menu.add_feature("Enable Flags", "toggle", Escortoptions, function(feat)
if feat.on then
   _Flags = true
end
if not feat.on then
   _Flags = false
end
end)

--Military Convoy Color
menu.add_feature("Military Convoy Color", "autoaction_value_str", Escortoptions, function(feat)
if (feat.value == 0) then
   _ColorID = 110
elseif (feat.value == 1) then
   _ColorID = 100
elseif (feat.value == 2) then
   _ColorID = 133
elseif (feat.value == 3) then
   _ColorID = 52
elseif (feat.value == 4) then
   _ColorID = 106
elseif (feat.value == 5) then
   _ColorID = 58
elseif (feat.value == 6) then
   _ColorID = 16
elseif (feat.value == 7) then
   _ColorID = 4
elseif (feat.value == 8) then
   _ColorID = 28
end
end):set_str_data({"Util Light Brown", "Metallic Moss Brown", "Worn Olive Army Green", "Metallic Olive Green", "Metallic Sun Bleeched Sand", "Worn Dark Green", "Util Black Poly", "Metallic Silver", "Metallic Torino Red"})

--Send Military Convoy to Waypoint
_Convoy = menu.add_feature("Military Convoy to Waypoint", "value_i", Escorts, function(feat)
if feat.on then
   local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
   local heading = entity.get_entity_heading(player_veh)
   local pos = player.get_player_coords(player.player_id())
   local V2Waypoint = ui.get_waypoint_coord()
   local waypoint = v3(V2Waypoint.x, V2Waypoint.y, 0)
   if ((V2Waypoint.x == 16000 and Leadingveh == false) or ped.is_ped_in_vehicle(OwnPedd, player_veh) == false ) then
      _Convoy:toggle()
      menu.notify("Get in a Vehicle & set a Waypoint", " ", 3, notify_color2)
   else
      getvehvector()
      freeze = false
      slowspeed = false
      MilConvoyVeh = {}   -- vehicle array with spawned cars
      Militarydrivers = {}     --Ped array with spawned peds
      Entitypos = {}
      ConvoyPassengers = {}
      for i = 1, #Militarypedhashs do
         while not streaming.has_model_loaded(Militarypedhashs[i]) do
            streaming.request_model(Militarypedhashs[i])
            system.wait(10)
         end
      end
      for i = 1, #PoliceOfficerhashs do
         while not streaming.has_model_loaded(PoliceOfficerhashs[i]) do
            streaming.request_model(PoliceOfficerhashs[i])
            system.wait(10)
         end
      end
      for i = 1, #Policecarhashs do
         while not streaming.has_model_loaded(Policecarhashs[i]) do
            streaming.request_model(Policecarhashs[i])
            system.wait(10)
         end
      end
      for i = 1, #Militarycars do
         while not streaming.has_model_loaded(Militarycars[i]) do
            streaming.request_model(Militarycars[i])
            system.wait(10)
         end
      end

      for i = 1, feat.value do
         local vehiclehash = Militarycars[math.random(1, #Militarycars)]
         local randompedhash = Militarypedhashs[math.random(1, #Militarypedhashs)]

         if (i ~= 1 and i ~= feat.value) then --Military cars
            MilConvoyVeh[i] = vehicle.create_vehicle(vehiclehash, v3(pos2.x +5*i*(pos2.x-pos1.x), pos2.y +5*i*(pos2.y-pos1.y), pos.z+2), heading, true, false)
            Militarydrivers[i] = ped.create_ped(6, randompedhash, pos, pos.x, true, false)
            vehicle.set_vehicle_fullbeam(MilConvoyVeh[i], true)
            vehicle.set_vehicle_colors(MilConvoyVeh[i], _ColorID, _ColorID)
            vehicle.set_vehicle_extra_colors(MilConvoyVeh[i], 1, 1)
            --Passengers
            _seats = vehicle.get_vehicle_model_number_of_seats(vehiclehash)
            for a = 0, math.random(1, _seats-1) do
               ConvoyPassengers[a] = ped.create_ped(6, Militarypedhashs[math.random(1, #Militarypedhashs)], pos, pos.x, true, false) -- Passenger
               ped.set_ped_into_vehicle(ConvoyPassengers[a], MilConvoyVeh[i], a)
               ped.set_ped_combat_attributes(ConvoyPassengers[a], 3, false)--Passengers cant leave car
               entity.freeze_entity(ConvoyPassengers[a], true)
               if not(ped.is_ped_in_vehicle(ConvoyPassengers[a], MilConvoyVeh[i])) then
                  network.request_control_of_entity(ConvoyPassengers[a])
                  entity.delete_entity(ConvoyPassengers[a])
               end
            end
         elseif (i == 1) then -- Front
            MilConvoyVeh[i] = vehicle.create_vehicle(Policecarhashs[math.random(1, #Policecarhashs)], v3(pos2.x +5*i*(pos2.x-pos1.x), pos2.y +5*i*(pos2.y-pos1.y), pos.z+2), heading, true, false) --Police car
            Militarydrivers[i] = ped.create_ped(6, PoliceOfficerhashs[math.random(1, #PoliceOfficerhashs)], pos, pos.x, true, false) -- Officer
         else  --Last
            MilConvoyVeh[i] = vehicle.create_vehicle(Policecarhashs[math.random(1, #Policecarhashs)], v3(pos2.x +4, pos2.y +4, pos.z+2), heading, true, false) --Police car
            Militarydrivers[i] = ped.create_ped(6, PoliceOfficerhashs[math.random(1, #PoliceOfficerhashs)], pos, pos.x, true, false) -- Officer
         end
         entity.set_entity_god_mode(MilConvoyVeh[i], true)
         entity.set_entity_god_mode(Militarydrivers[i], true)
         ped.set_ped_combat_attributes(Militarydrivers[i], 3, false) -- Peds cant leave car
         ped.set_ped_into_vehicle(Militarydrivers[i], MilConvoyVeh[i], -1)
         vehicle.set_vehicle_wheel_brake_pressure(MilConvoyVeh[i], 1, 100)
         vehicle.set_vehicle_wheel_brake_pressure(MilConvoyVeh[i], 2, 100)
         vehicle.set_vehicle_wheel_brake_pressure(MilConvoyVeh[i], 3, 100)
         vehicle.set_vehicle_wheel_brake_pressure(MilConvoyVeh[i], 4, 100)
         vehicle.start_vehicle_horn(MilConvoyVeh[i], 2000, 1, true)--WIP TEST NOT WORKING

         if (i == feat.value and _Light == true) then
            local helperped1 = ped.create_ped(6, 0x616C97B9, entity.get_entity_coords(MilConvoyVeh[1]), heading, true, false)
            entity.set_entity_visible(helperped1, false)
            weapon.give_delayed_weapon_to_ped(helperped1, 3231910285, 0, true)
            ped.set_ped_combat_range(helperped1, 2)
            ai.task_combat_ped(helperped1, OwnPedd, 0, 0)
            system.wait(2000)
            network.request_control_of_entity(helperped1)
            entity.delete_entity(helperped1)
         end

         if (i == 1) then --LEADING VEHICLE
            if (Leadingveh == true) then  --you are leading vehicle
               ai.task_vehicle_follow(Militarydrivers[i], MilConvoyVeh[i], player_veh, 30, 525064, 11)
            else
               ai.task_vehicle_drive_to_coord_longrange(Militarydrivers[i], MilConvoyVeh[i], waypoint, 15, 1, 1)
            end
         elseif (i == feat.value) then --Last Vehicle
            ai.task_vehicle_follow(Militarydrivers[i], MilConvoyVeh[i], MilConvoyVeh[i - 1], 30, 525064, 11)
         else
            ai.task_vehicle_follow(Militarydrivers[i], MilConvoyVeh[i], MilConvoyVeh[i - 1], 30, 525064, 11)
         end
         if (_Marker == true) then
            if (i~= 1 and i~= feat.value) then
               _blipcolor = 39
               _blipsymbol = 818
            else -- Police cars
               _blipcolor = 68
               _blipsymbol = 56
            end
            local Marker = ui.add_blip_for_entity(MilConvoyVeh[i])
            ui.set_blip_sprite(Marker, _blipsymbol)
            ui.set_blip_colour(Marker, _blipcolor)
         end
      end

      while feat.on do
         --New Waypoint Destination
         if (V2Waypoint ~= ui.get_waypoint_coord()) then
            V2Waypoint = ui.get_waypoint_coord()
            waypoint = v3(V2Waypoint.x, V2Waypoint.y, 0)
            ai.task_vehicle_drive_to_coord_longrange(Militarydrivers[1], MilConvoyVeh[1], waypoint, 15, 1, 1)
            menu.notify("New Waypoint", " ", 1, notify_color1)
         end

         for i = 1, feat.value do
            setVehicleonGround(MilConvoyVeh[i])    --new WIP
            if (_Autorepair == true) then
               if(vehicle.is_vehicle_damaged(MilConvoyVeh[i])) then
                  vehicle.set_vehicle_fixed(MilConvoyVeh[i])
               end
            end
            --end
            if (_Autoclear == true) then
               local allveh = vehicle.get_all_vehicles()
               allvehcoords = {}
               for i = 1, #allveh do
                  if (Distance(allveh[i], MilConvoyVeh[1]) <= 100) then
                     if (contains(MilConvoyVeh, allveh[i], #MilConvoyVeh) == false and allveh[i] ~= player_veh) then
                        network.request_control_of_entity(allveh[i])
                        entity.delete_entity(allveh[i])
                     end
                  end
               end
            end


            if (i ~= feat.value) then
               Distance(MilConvoyVeh[i], MilConvoyVeh[i+1])--function returns _Distance
               if (_Distance >= 50 and _Distance <= 100 and slowspeed == false) then
                  for a=1, i do
                     entity.set_entity_max_speed(MilConvoyVeh[a], 2)
                     slowspeed = true
                     freeze = false
                  end
               elseif (_Distance < 50) then
                  for a = i, feat.value do
                     entity.set_entity_max_speed(MilConvoyVeh[i], 20)
                     slowspeed = false
                     freeze = false
                  end
               end
               if (_Distance >= 101 and freeze == false) then
                  for a=1, i do
                     entity.set_entity_max_speed(MilConvoyVeh[a], 0)
                     freeze = true
                  end
               end
            end
         end

         system.wait(100)
      end
   end-- from waypoint if
end

if not feat.on then
   if (Militarydrivers ~= nil or MilConvoyVeh ~= nil) then
      for i = 1, feat.value do
         network.request_control_of_entity(Militarydrivers[i])
         entity.set_entity_as_no_longer_needed(Militarydrivers[i])
         entity.delete_entity(Militarydrivers[i])
         network.request_control_of_entity(MilConvoyVeh[i])
         entity.set_entity_as_no_longer_needed(MilConvoyVeh[i])
         entity.delete_entity(MilConvoyVeh[i])
      end
   end

   local peds = ped.get_all_peds()
   for i = 1, #peds do
      local hash = entity.get_entity_model_hash(peds[i])
      if (contains(Militarypedhashs, hash, #Militarypedhashs)) then
         network.request_control_of_entity(peds[i])
         entity.delete_entity(peds[i])
      end
   end
end
end)
_Convoy.min = 3
_Convoy.max = 30
_Convoy.mod = 1



--Freedom Convoy
_FreedomConvoy = menu.add_feature("Freedom Convoy", "value_i", Escorts, function(feat)
if feat.on then
   local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
   local heading = entity.get_entity_heading(player_veh)
   local pos = player.get_player_coords(player.player_id())
   local V2Waypoint = ui.get_waypoint_coord()
   local waypoint = v3(V2Waypoint.x, V2Waypoint.y, 0)
   if ((V2Waypoint.x == 16000 and Leadingveh == false) or ped.is_ped_in_vehicle(OwnPedd, player_veh) == false or V2Waypoint == nil) then
      _FreedomConvoy:toggle()
      menu.notify("Get in a Vehicle & set a Waypoint", " ", 3, notify_color2)
   else
      getvehvector()
      freeze = false
      slowspeed = false
      FreedomConvoyVeh = {}   -- vehicle array with spawned cars
      FreedomConvoydrivers = {}     --Ped array with spawned peds
      Entitypos2 = {}
      FreedomConvoyPassengers = {}
      for i = 1, #Truckerpedhashs do
         while not streaming.has_model_loaded(Truckerpedhashs[i]) do
            streaming.request_model(Truckerpedhashs[i])
            system.wait(10)
         end
      end
      for i = 1, #Truckhashs do
         while not streaming.has_model_loaded(Truckhashs[i]) do
            streaming.request_model(Truckhashs[i])
            system.wait(10)
         end
      end

      for i = 1, feat.value do
         local vehiclehash = Truckhashs[math.random(1, #Truckhashs)]
         local randompedhash = Truckerpedhashs[math.random(1, #Truckerpedhashs)]
         local color = TruckColorIDs[math.random(1, #TruckColorIDs)]
         FreedomConvoyVeh[i] = vehicle.create_vehicle(vehiclehash, v3(pos2.x +5*i*(pos2.x-pos1.x), pos2.y +5*i*(pos2.y-pos1.y), pos.z+2), heading, true, false)
         FreedomConvoydrivers[i] = ped.create_ped(6, randompedhash, pos, pos.x, true, false)
         vehicle.set_vehicle_colors(FreedomConvoyVeh[i], color, color)
         vehicle.set_vehicle_extra_colors(FreedomConvoyVeh[i], 1, 1)
         --Passengers
         local _seats = vehicle.get_vehicle_model_number_of_seats(vehiclehash)
         for a = 1, math.random(1, _seats-1) do
            FreedomConvoyPassengers[a] = ped.create_ped(6, Truckerpedhashs[math.random(1, #Truckerpedhashs)], pos, pos.x, true, false) -- Passenger
            ped.set_ped_into_vehicle(FreedomConvoyPassengers[a], FreedomConvoyVeh[i], a)
            ped.set_ped_combat_attributes(FreedomConvoyPassengers[a], 3, false)--Passengers cant leave car
            entity.freeze_entity(FreedomConvoyPassengers[a], true)
            if not(ped.is_ped_in_vehicle(FreedomConvoyPassengers[a], FreedomConvoyVeh[i])) then
               network.request_control_of_entity(FreedomConvoyPassengers[a])
               entity.delete_entity(FreedomConvoyPassengers[a])
            end
         end
         entity.set_entity_god_mode(FreedomConvoyVeh[i], true)
         entity.set_entity_god_mode(FreedomConvoydrivers[i], true)
         ped.set_ped_combat_attributes(FreedomConvoydrivers[i], 3, false) -- Peds cant leave car
         ped.set_ped_into_vehicle(FreedomConvoydrivers[i], FreedomConvoyVeh[i], -1)
         vehicle.set_vehicle_wheel_brake_pressure(FreedomConvoyVeh[i], 1, 200)
         vehicle.set_vehicle_wheel_brake_pressure(FreedomConvoyVeh[i], 2, 200)
         vehicle.set_vehicle_wheel_brake_pressure(FreedomConvoyVeh[i], 3, 200)
         vehicle.set_vehicle_wheel_brake_pressure(FreedomConvoyVeh[i], 4, 200)
         if (i == 1) then --LEADING VEHICLE
            if (Leadingveh == true) then  --you are leading vehicle
               ai.task_vehicle_follow(FreedomConvoydrivers[i], FreedomConvoyVeh[i], player_veh, 20, 525192, 17)
            else
               ai.task_vehicle_drive_to_coord_longrange(FreedomConvoydrivers[i], FreedomConvoyVeh[i], waypoint, 15, 525192, 1)
            end
         else
            ai.task_vehicle_follow(FreedomConvoydrivers[i], FreedomConvoyVeh[i], FreedomConvoyVeh[i - 1], 15, 776, 17)
         end

         if (_Marker == true) then
            local Marker = ui.add_blip_for_entity(FreedomConvoyVeh[i])
            ui.set_blip_sprite(Marker, 477)
            ui.set_blip_colour(Marker, 39)
         end

         if (_Flags == true) then
            if (contains(Truckhashs, vehiclehash, EndOfTrucks)) then    --Big Trucks
               AttatchObjecttoVehBone("Exhaust", FreedomConvoyVeh[i], Flaghashs[math.random(1, #Flaghashs)], v3(0,0,0.8), true)
            else   --all other smaller veh
               AttatchObjecttoVehBone("door_dside_f", FreedomConvoyVeh[i], Flaghashs[math.random(1, #Flaghashs)], v3(0,0,0), true)
               AttatchObjecttoVehBone("door_pside_f", FreedomConvoyVeh[i], Flaghashs[math.random(1, #Flaghashs)], v3(0,0,0), true)
            end
            entity.set_entity_rotation(_Object, v3(1, -1, 0))
         end
      end

      while feat.on do
         for i = 1, feat.value do
            --Horn Spam
            for a=1, math.random(1, feat.value) do
               vehicle.start_vehicle_horn(FreedomConvoyVeh[a], 1000, 0, false)--WIP TEST
               system.wait(math.random(0, 200))
            end
            --Light Spam
            for a=1, math.random(1, feat.value) do
               local fullbeamstate = {true, false}
               vehicle.set_vehicle_fullbeam(FreedomConvoyVeh[i], fullbeamstate[math.random(1, 2)])
               system.wait(math.random(0, 300))
            end
            if (_Autorepair == true) then
               if(vehicle.is_vehicle_damaged(FreedomConvoyVeh[i])) then
                  vehicle.set_vehicle_fixed(FreedomConvoyVeh[i])
               end
            end
            if (i ~= feat.value) then
               Distance(FreedomConvoyVeh[i], FreedomConvoyVeh[i+1])  --function returns _Distance
               if (_Distance >= 50 and _Distance <= 100 and slowspeed == false) then
                  for a=1, i do
                     entity.set_entity_max_speed(FreedomConvoyVeh[a], 2)
                     slowspeed = true
                     freeze = false
                  end
               elseif (_Distance < 50) then
                  for a = i, feat.value do
                     entity.set_entity_max_speed(FreedomConvoyVeh[i], 16)
                     slowspeed = false
                     freeze = false
                  end
               end
               if (_Distance >= 101 and freeze == false) then
                  for a=1, i do
                     entity.set_entity_max_speed(FreedomConvoyVeh[a], 0)
                     freeze = true
                  end
               end
            end
         end
         --New Waypoint Destination
         if (V2Waypoint ~= ui.get_waypoint_coord()) then
            V2Waypoint = ui.get_waypoint_coord()
            waypoint = v3(V2Waypoint.x, V2Waypoint.y, 0)
            ai.task_vehicle_drive_to_coord_longrange(FreedomConvoydrivers[1], FreedomConvoyVeh[1], waypoint, 15, 525192, 1)
            menu.notify("New Waypoint", " ", 1, notify_color1)
         end
         if (_Autoclear == true and allvehcoords ~= nil) then
            local allveh = vehicle.get_all_vehicles()
            allvehcoords = {}
            for i = 1, #allveh do
               if (Distance(allveh[i], FreedomConvoyVeh[1]) <= 100) then
                  if (contains(FreedomConvoyVeh, allveh[i], #FreedomConvoyVeh) == false and allveh[i] ~= player_veh) then
                     network.request_control_of_entity(allveh[i])
                     entity.delete_entity(allveh[i])
                  end
               end
            end
         end
         system.wait(10)
      end
   end-- from waypoint if
end

if not feat.on then
   if (FreedomConvoydrivers ~= nil or FreedomConvoyVeh ~= nil) then
      for i = 1, feat.value do
         network.request_control_of_entity(FreedomConvoydrivers[i])
         entity.set_entity_as_no_longer_needed(FreedomConvoydrivers[i])
         entity.delete_entity(FreedomConvoydrivers[i])
         network.request_control_of_entity(FreedomConvoyVeh[i])
         entity.set_entity_as_no_longer_needed(FreedomConvoyVeh[i])
         entity.delete_entity(FreedomConvoyVeh[i])
      end
   end
   if (_Flags == true) then
      local objects = object.get_all_objects()
      for i = 1, #objects do
         local hash = entity.get_entity_model_hash(objects[i])
         if (contains(Flaghashs, hash, #Flaghashs)) then
            network.request_control_of_entity(objects[i])
            entity.delete_entity(objects[i])
         end
      end
   end
   local peds = ped.get_all_peds()
   for i = 1, #peds do
      local hash = entity.get_entity_model_hash(peds[i])
      if (contains(Truckerpedhashs, hash, #Truckerpedhashs)) then
         network.request_control_of_entity(peds[i])
         entity.delete_entity(peds[i])
      end
   end
end
end)
_FreedomConvoy.min = 3
_FreedomConvoy.max = 30
_FreedomConvoy.mod = 1


--Single escort
menu.add_feature("Unmarked Escort | single", "toggle", Escorts, function(feat)
if feat.on then
   local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
   local pos = player.get_player_coords(player.player_id())
   pos.x = pos.x +4

   while not streaming.has_model_loaded(0x585C0B52) do  --ped Hash fib suit
      streaming.request_model(0x585C0B52)
      system.wait(10)
   end
   unmarkedcars = {0x506434F6, 0xE18195B2, 0xA774B5A6, 0xF06C29C7}
   for i = 1, #unmarkedcars do
      while not streaming.has_model_loaded(unmarkedcars[i]) do
         streaming.request_model(unmarkedcars[i])
         system.wait(10)
      end
   end
   local vehhash = unmarkedcars[math.random(1, #unmarkedcars)]
   spawnedcar = vehicle.create_vehicle(vehhash, pos, pos.x, true, false)
   entity.set_entity_god_mode(spawnedcar, true)
   vehicle.set_vehicle_colors(spawnedcar, 1, 1)
   vehicle.set_vehicle_extra_colors(spawnedcar, 1, 1)
   vehicle.set_vehicle_fullbeam(spawnedcar, true)
   spawnedped = ped.create_ped(6, 0x585C0B52, pos, pos.x, true, false)
   ped.set_ped_into_vehicle(spawnedped, spawnedcar, -1)
   ped.set_ped_combat_attributes(spawnedped, 3, false)  -- Ped cant leave car
   ai.task_vehicle_follow(spawnedped, spawnedcar, player_veh, 60, 2883621, 8)
   if (_Marker == true) then
      local Marker = ui.add_blip_for_entity(spawnedcar)
      ui.set_blip_sprite(Marker, 821)
      ui.set_blip_colour(Marker, 68)
   end

   while feat.on do
      if (_Light == true) then
         vehicle.toggle_vehicle_mod(spawnedcar, 22, true)
         vehicle.set_vehicle_headlight_color(spawnedcar, 1)
         system.wait(60)
         vehicle.set_vehicle_headlight_color(spawnedcar, 0)
         system.wait(60)
         vehicle.set_vehicle_headlight_color(spawnedcar, 1)
         system.wait(100)
         vehicle.set_vehicle_headlight_color(spawnedcar, 0)
         system.wait(500)
      end
      if (_Autorepair == true) then
         --Repair Vehicle if damaged
         if(entity.has_entity_collided_with_anything(spawnedcar)) then
            vehicle.set_vehicle_fixed(spawnedcar)
         end
      end
      system.wait(10)
   end
end
if not feat.on then
   network.request_control_of_entity(spawnedped)
   entity.set_entity_as_no_longer_needed(spawnedped)
   entity.delete_entity(spawnedped)
   network.request_control_of_entity(spawnedcar)
   entity.set_entity_as_no_longer_needed(spawnedcar)
   entity.delete_entity(spawnedcar)
end
end)

--Unmarked escort
local value = menu.add_feature("Unmarked Escort SUV´s", "value_i", Escorts, function(feat)
if feat.on then
   local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
   local pos = player.get_player_coords(player.player_id())
   getvehvector()
   while not streaming.has_model_loaded(0x5E3DA4A4) do  --ped Hash Bike officer
      streaming.request_model(0x5E3DA4A4)
      system.wait(10)
   end
   while not streaming.has_model_loaded(0xF06C29C7) do  --SUV 1
      streaming.request_model(0xF06C29C7)
      system.wait(10)
   end

   unmarkedcars = {}    -- vehicle array
   unmarkedpeds = {}     --Ped array
   for i=1, feat.value do
      unmarkedcars[i] = vehicle.create_vehicle(0xF06C29C7, v3(pos2.x +5*i*(pos2.x-pos1.x), pos2.y +5*i*(pos2.y-pos1.y), pos.z+4), pos.x, true, false)
      entity.set_entity_god_mode(unmarkedcars[i], true)
      vehicle.set_vehicle_colors(unmarkedcars[i], 1, 1)
      vehicle.set_vehicle_extra_colors(unmarkedcars[i], 1, 1)
      vehicle.set_vehicle_fullbeam(unmarkedcars[i], true)
      vehicle.set_vehicle_wheel_brake_pressure(unmarkedcars[i], 1, 100)
      vehicle.set_vehicle_wheel_brake_pressure(unmarkedcars[i], 2, 100)
      vehicle.set_vehicle_wheel_brake_pressure(unmarkedcars[i], 3, 100)
      vehicle.set_vehicle_wheel_brake_pressure(unmarkedcars[i], 4, 100)
      vehicle.toggle_vehicle_mod(unmarkedcars[i], 22, true) --Xenon Lights
      vehicle.toggle_vehicle_mod(unmarkedcars[i], 55, true)  --Window Tint
      vehicle.set_vehicle_window_tint(unmarkedcars[i], 1)


      unmarkedpeds[i] = ped.create_ped(6, 0x5E3DA4A4, pos, pos.x, true, false)
      entity.set_entity_god_mode(unmarkedpeds[i], true)
      ped.set_ped_combat_attributes(unmarkedpeds[i], 3, false)  -- Ped cant leave car
      ped.set_ped_into_vehicle(unmarkedpeds[i], unmarkedcars[i], -1)

      if (i == 1) then
         ai.task_vehicle_follow(unmarkedpeds[i], unmarkedcars[i], player_veh, 30, 2883621, 9)
      else
         ai.task_vehicle_follow(unmarkedpeds[i], unmarkedcars[i], unmarkedcars[i-1], 30, 2883621, 9)
      end

      if (_Marker == true) then
         local Marker = ui.add_blip_for_entity(unmarkedcars[i])
         ui.set_blip_sprite(Marker, 821)
         ui.set_blip_colour(Marker, 68)
      end
   end
end

while feat.on do
   if (_Light == true and time.get_clock_hours() <= 7 or time.get_clock_hours() >= 19) then
      for i = 1, feat.value do
         vehicle.set_vehicle_headlight_color(unmarkedcars[i], 8)
         if (i == 1 or i == 2 or i == 3 or i ==4) then
            system.wait(200/feat.value)
         else
            system.wait(100/feat.value)
         end
      end
      for i = 1, feat.value do
         vehicle.set_vehicle_headlight_color(unmarkedcars[i], 1)
         if (i == 1 or i == 2 or i == 3 or i ==4) then
            system.wait(200)
         else
            system.wait(100/feat.value)
         end
      end
   end

   if (_Autorepair == true) then
      --  Repair Vehicle if damaged
      for i = 1, feat.value do
         if(vehicle.is_vehicle_damaged(unmarkedcars[i])) then
            vehicle.set_vehicle_fixed(unmarkedcars[i])
         end
         system.wait(10)
      end
   end
   system.wait(10)
end
--end

if not feat.on then
   for i=1, feat.value do
      network.request_control_of_entity(unmarkedpeds[i])
      entity.set_entity_as_no_longer_needed(unmarkedpeds[i])
      entity.delete_entity(unmarkedpeds[i])
      network.request_control_of_entity(unmarkedcars[i])
      entity.set_entity_as_no_longer_needed(unmarkedcars[i])
      entity.delete_entity(unmarkedcars[i])
   end
end
end)
value.min = 1
value.mod = 1
value.max = 20

--Policecar escort
local value = menu.add_feature("Police escort", "value_i", Escorts, function(feat)
if feat.on then
   local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
   local pos = player.get_player_coords(player.player_id())

   while not streaming.has_model_loaded(0x5E3DA4A4) do  --ped Hash officer
      streaming.request_model(0x5E3DA4A4)
      system.wait(10)
   end
   getvehvector()
   policecars = {}    -- vehicle array
   spawnedped = {}     --Ped array
   helperped = {}

   for i=1, feat.value do
      local randomcar = math.random(1, 5)
      if (randomcar == 1) then
         vehiclehash = 0x79FBB0C5
         while not streaming.has_model_loaded(vehiclehash) do
            streaming.request_model(vehiclehash)
            system.wait(10)
         end
      end
      if (randomcar == 2) then
         vehiclehash = 0x9F05F101
         while not streaming.has_model_loaded(vehiclehash) do
            streaming.request_model(vehiclehash)
            system.wait(10)
         end
      end
      if (randomcar == 3) then
         vehiclehash = 0x71FA16EA
         while not streaming.has_model_loaded(vehiclehash) do
            streaming.request_model(vehiclehash)
            system.wait(10)
         end
      end
      if (randomcar == 4) then
         vehiclehash = 0x1B38E955
         while not streaming.has_model_loaded(vehiclehash) do
            streaming.request_model(vehiclehash)
            system.wait(10)
         end
      end
      if (randomcar == 5) then
         vehiclehash = 1922257928
         while not streaming.has_model_loaded(vehiclehash) do
            streaming.request_model(vehiclehash)
            system.wait(10)
         end
      end
      policecars[i] = vehicle.create_vehicle(vehiclehash, v3(pos2.x +5*i*(pos2.x-pos1.x), pos2.y +5*i*(pos2.y-pos1.y), pos.z+4), pos.x, true, false)
      entity.set_entity_god_mode(policecars[i], true)
      spawnedped[i] = ped.create_ped(6, 0x5E3DA4A4, pos, pos.x, true, false)
      entity.set_entity_god_mode(spawnedped[i], true)
      ped.set_ped_combat_attributes(spawnedped[i], 3, false)  -- Ped cant leave car
      ped.set_ped_into_vehicle(spawnedped[i], policecars[i], -1)
      vehicle.set_vehicle_wheel_brake_pressure(policecars[i], 1, 100)
      vehicle.set_vehicle_wheel_brake_pressure(policecars[i], 2, 100)
      vehicle.set_vehicle_wheel_brake_pressure(policecars[i], 3, 100)
      vehicle.set_vehicle_wheel_brake_pressure(policecars[i], 4, 100)


      if (i == feat.value) then
         if (_Light == true) then
            helperped = ped.create_ped(6, 0x5E3DA4A4, pos, pos.x, true, false)
            entity.set_entity_visible(helperped, false)
            weapon.give_delayed_weapon_to_ped(helperped,  0x5E3DA4A4, 0, true)
            ai.task_combat_ped(helperped, OwnPedd, 0, 0)
            system.wait(1000)
            network.request_control_of_entity(helperped)
            entity.delete_entity(helperped)
         end

         for i=1, feat.value do
            if (i == 1) then
               ai.task_vehicle_follow(spawnedped[i], policecars[i], player_veh, 30, 525064, 9)
            else
               ai.task_vehicle_follow(spawnedped[i], policecars[i], policecars[i-1], 30, 525064, 9)
            end
         end
      end

      if (_Marker == true) then  --WIP
         Marker = ui.add_blip_for_entity(policecars[i])
         ui.set_blip_sprite(Marker, 56)
         ui.set_blip_colour(Marker, 68)
      end

   end

end
if not feat.on then
   for i=1, feat.value do
      network.request_control_of_entity(spawnedped[i])
      entity.set_entity_as_no_longer_needed(spawnedped[i])
      entity.delete_entity(spawnedped[i])
      network.request_control_of_entity(policecars[i])
      entity.set_entity_as_no_longer_needed(policecars[i])
      entity.delete_entity(policecars[i])
   end
end
end)
value.min = 1
value.mod = 1
value.value = 1
value.max = 20

--Helicopter escort
local value = menu.add_feature("Helicopter Escort", "value_i", Escorts, function(feat)
if feat.on then
   local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
   local pos = player.get_player_coords(player.player_id())

   while not streaming.has_model_loaded(0xAB300C07) do  --ped Pilot
      streaming.request_model(0xAB300C07)
      system.wait(10)
   end
   Helicopters = {}    -- vehicle array
   spawnedpilots = {}     --Ped array

   for i=1, feat.value do
      local randomcar = math.random(1, 4)
      if (randomcar == 1) then
         vehiclehash = 0x46699F47 --Akula
         while not streaming.has_model_loaded(vehiclehash) do
            streaming.request_model(vehiclehash)
            system.wait(10)
         end
      end
      if (randomcar == 2) then
         vehiclehash = 0xFD707EDE --Hunter
         while not streaming.has_model_loaded(vehiclehash) do
            streaming.request_model(vehiclehash)
            system.wait(10)
         end
      end
      if (randomcar == 3) then
         vehiclehash = 0xA09E15FD --Valkyrie
         while not streaming.has_model_loaded(vehiclehash) do
            streaming.request_model(vehiclehash)
            system.wait(10)
         end
      end
      if (randomcar == 4) then
         vehiclehash = 0x11962E49 --Annihilator Stealth
         while not streaming.has_model_loaded(vehiclehash) do
            streaming.request_model(vehiclehash)
            system.wait(10)
         end
      end
      Helicopters[i] = vehicle.create_vehicle(vehiclehash, pos+i*10, pos.x, true, false)
      entity.set_entity_god_mode(Helicopters[i], true)
      vehicle.set_vehicle_fullbeam(Helicopters[i], true)
      spawnedpilots[i] = ped.create_ped(6, 0xAB300C07, pos, pos.x, true, false)
      vehicle.set_vehicle_colors(Helicopters[i], 3, 3)
      ped.set_ped_combat_attributes(spawnedpilots[i], 3, false)  -- Ped cant leave car
      ped.set_ped_into_vehicle(spawnedpilots[i], Helicopters[i], -1)
      if (i == 1) then
         ai.task_vehicle_follow(spawnedpilots[i], Helicopters[i], player_veh, 150, 2883621, 5)
      else
         ai.task_vehicle_follow(spawnedpilots[i], Helicopters[i],Helicopters[i-1], 150, 2883621, 5)
      end



      if (_Marker == true) then
         local Marker = ui.add_blip_for_entity(Helicopters[i])
         ui.set_blip_sprite(Marker, 576)
         ui.set_blip_colour(Marker, 40)
      end
      if (_Autorepair == true) then
         --  Repair Vehicle if damaged
         for i = 1, feat.value do
            if(vehicle.is_vehicle_damaged(Helicopters[i])) then
               vehicle.set_vehicle_fixed(Helicopters[i])
            end
            system.wait(10)
         end
      end

   end

end
if not feat.on then
   for i=1, feat.value do
      network.request_control_of_entity(spawnedpilots[i])
      entity.set_entity_as_no_longer_needed(spawnedpilots[i])
      entity.delete_entity(spawnedpilots[i])
      network.request_control_of_entity(Helicopters[i])
      entity.set_entity_as_no_longer_needed(Helicopters[i])
      entity.delete_entity(Helicopters[i])
   end
end
end)
value.min = 1
value.mod = 1
value.value = 1
value.max = 20

--Spawn Helicopter above
local value = menu.add_feature("spawn Helicopter in Air", "toggle", Escorts, function(feat)
if feat.on then
   local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
   local pos = player.get_player_coords(player.player_id())

   while not streaming.has_model_loaded(0xAB300C07) do  --ped Pilot
      streaming.request_model(0xAB300C07)
      system.wait(10)
   end
   while not streaming.has_model_loaded(710198397) do  --Helicopter
      streaming.request_model(710198397)
      system.wait(10)
   end
   _Helicopter = vehicle.create_vehicle(710198397, pos + 100, pos.x, true, false)
   entity.set_entity_god_mode(_Helicopter, true)
   _SpawnedPilot = ped.create_ped(6, 0xAB300C07, pos, pos.x, true, false)
   ped.set_ped_combat_attributes(_SpawnedPilot, 3, false)  -- Ped cant leave car
   ped.set_ped_into_vehicle(_SpawnedPilot, _Helicopter, -1)
   vehicle.set_vehicle_colors(_Helicopter, 39, 39)
   ai.task_vehicle_follow(_SpawnedPilot, _Helicopter, player_veh, 60, 2883621, 150)
   if (_Marker == true) then
      local Marker = ui.add_blip_for_entity(_Helicopter)
      ui.set_blip_sprite(Marker, 602)
      ui.set_blip_colour(Marker, 68)
   end
end
if not feat.on then
   network.request_control_of_entity(_SpawnedPilot)
   entity.set_entity_as_no_longer_needed(_SpawnedPilot)
   entity.delete_entity(_SpawnedPilot)
   network.request_control_of_entity(_Helicopter)
   entity.set_entity_as_no_longer_needed(_Helicopter)
   entity.delete_entity(_Helicopter)
end
end)

--Send Police to Waypoint
menu.add_feature("send Police to Waypoint", "action", Escorts, function(feat)
local pos = player.get_player_coords(player.player_id())
V2Waypoint = ui.get_waypoint_coord()
local waypoint = v3(V2Waypoint.x, V2Waypoint.y, 0)

while not streaming.has_model_loaded(1581098148) do  --ped Hash officer
   streaming.request_model(1581098148)
   system.wait(10)
end
local randomcar = math.random(1, 4)
if (randomcar == 1) then
   while not streaming.has_model_loaded(0x79FBB0C5) do
      streaming.request_model(0x79FBB0C5)
      system.wait(10)
   end
   spawnedpolicecar = vehicle.create_vehicle(0x79FBB0C5, pos+4, pos.x, true, false)
end
if (randomcar == 2) then
   while not streaming.has_model_loaded(0x9F05F101) do
      streaming.request_model(0x9F05F101)
      system.wait(10)
   end
   spawnedpolicecar = vehicle.create_vehicle(0x9F05F101, pos+4, pos.x, true, false)
end
if (randomcar == 3) then
   while not streaming.has_model_loaded(0x71FA16EA) do
      streaming.request_model(0x71FA16EA)
      system.wait(10)
   end
   spawnedpolicecar = vehicle.create_vehicle(0x71FA16EA, pos+4, pos.x, true, false)
end
if (randomcar == 4) then
   while not streaming.has_model_loaded(0x1B38E955) do
      streaming.request_model(0x1B38E955)
      system.wait(10)
   end
   spawnedpolicecar = vehicle.create_vehicle(0x1B38E955, pos+4, pos.x, true, false)

end
entity.set_entity_god_mode(spawnedpolicecar, true)
local spawnedpoliceped = ped.create_ped(6, 1581098148, pos, pos.x, true, false)
ped.set_ped_into_vehicle(spawnedpoliceped, spawnedpolicecar, -1)

if (_Light == true) then
   local helperped = ped.create_ped(6, 0x5E3DA4A4, pos + 2, pos.x, true, false)
   entity.set_entity_visible(helperped, false)
   weapon.give_delayed_weapon_to_ped(helperped,  0x5E3DA4A4, 0, true)
   ai.task_combat_ped(helperped, OwnPedd, 0, 0)
   system.wait(1000)
   network.request_control_of_entity(helperped)
   entity.delete_entity(helperped)
end

ai.task_vehicle_drive_to_coord_longrange(spawnedpoliceped, spawnedpolicecar, waypoint, 50, 1, 5)
end)

--Send Firetrucks to Waypoint
menu.add_feature("send Firetrucks to Waypoint", "action", Escorts, function(feat)
local pos = player.get_player_coords(player.player_id())
V2Waypoint = ui.get_waypoint_coord()
local waypoint = v3(V2Waypoint.x, V2Waypoint.y, 0)

while not streaming.has_model_loaded(0xB6B1EDA8) do  --ped Hash Fireman
   streaming.request_model(0xB6B1EDA8)
   system.wait(10)
end
local randomcar = math.random(1, 5)
if (randomcar == 1 or randomcar == 2 or randomcar == 3) then
   while not streaming.has_model_loaded(1938952078) do
      streaming.request_model(1938952078)
      system.wait(10)
   end
   spawnedfiretruck = vehicle.create_vehicle(1938952078, pos+4, pos.x, true, false)--Firetruck
end
if (randomcar == 4) then
   while not streaming.has_model_loaded(1171614426) do
      streaming.request_model(1171614426)
      system.wait(10)
   end
   spawnedfiretruck = vehicle.create_vehicle(1171614426, pos+4, pos.x, true, false)--Ambulance
end
if (randomcar == 5) then
   while not streaming.has_model_loaded(2132890591) do
      streaming.request_model(2132890591)
      system.wait(10)
   end
   spawnedfiretruck = vehicle.create_vehicle(2132890591, pos+4, pos.x, true, false)  --Truck
   vehicle.set_vehicle_colors(spawnedfiretruck, 150, 150)
   --vehicle.set_vehicle_extra_colors(spawnedfiretruck, 150, 150)
end
entity.set_entity_god_mode(spawnedfiretruck, true)
local spawnedfiretruckped = ped.create_ped(6, 0xB6B1EDA8, pos, pos.x, true, false)--Fireman
local spawnedfiretruckped2 = ped.create_ped(6, 0xB6B1EDA8, pos, pos.x, true, false)--Fireman
ped.set_ped_into_vehicle(spawnedfiretruckped, spawnedfiretruck, -1)--Driver
ped.set_ped_into_vehicle(spawnedfiretruckped2, spawnedfiretruck, 0)
vehicle.toggle_vehicle_mod(spawnedfiretruck, 22, true) --Xenon Lights
ai.task_vehicle_drive_to_coord_longrange(spawnedfiretruckped, spawnedfiretruck, waypoint, 30, 1, 5)
end)

--WIP
--if vehicle upside down then
--set_vehicle_on_ground_properly(Vehicle veh)
