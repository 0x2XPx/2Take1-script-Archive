require('LigtControl')

--Police loadout
menu.add_feature("Police Loadout", "action", Policeoptions, function()
  weapon.remove_all_ped_weapons(OwnPedd)
  weapon.give_delayed_weapon_to_ped(OwnPedd, 0x45CD9CF3, 2, true)--Taser
  weapon.give_delayed_weapon_to_ped(OwnPedd, 0x8BB05FD7, 2, true)--flashlight
  weapon.give_delayed_weapon_to_ped(OwnPedd, 0x3656C8C1, 2, true)--Taser 2?
  weapon.give_delayed_weapon_to_ped(OwnPedd, 0x13532244, 2, true)--micro mp
  weapon.give_delayed_weapon_to_ped(OwnPedd, 0x5A96BA4, 2, true)--shotgun
  weapon.give_delayed_weapon_to_ped(OwnPedd, 0xE284C527, 2, true)--shotgun2
  weapon.give_delayed_weapon_to_ped(OwnPedd, 0x497FACC3, 2, true)--flare
  weapon.give_delayed_weapon_to_ped(OwnPedd, 0x060EC506, 2, true)--fire ext.
end)

--Slow down Traffic
local slowdown = menu.add_feature("Slow down Traffic", "value_i", Policeoptions, function(feat)
while feat.on do
   slow_down_traffic(feat.value)
   system.wait(10)
   return HANDLER_CONTINUE
end
end)
slowdown.min = 0
slowdown.max = 50
slowdown.mod = 1
slowdown.value = 5

--License Plate
local license_plate = menu.add_feature("Police License Plate", "toggle", Policeoptions, function(feat)
  local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  local licenseplate = {" POLICE ", " ", " POLICE ", " ", " POLICE ", " ", " POLICE ", " ", "       P", "      PL", "     PLE", "    PLEA", "   PLEAS", "  PLEASE", " PLEASE ", "PLEASE F", "LEASE FO", "EASE FOL", "ASE FOLL", "SE FOLLO","E FOLLOW", " FOLLOW ", "FOLLOW  ", "OLLOW   ", "LLOW    ", "LOW     ", "OW      ", "W       ", " "}
  while feat.on do
    for i=1, 29 do      --#licenseplate is only the number of integers in the array
      vehicle.set_vehicle_number_plate_text(player_veh, licenseplate[i])
     system.wait(200)
    end
  end
end)

--Breaklights
local break_lights = menu.add_feature("Breaklights", "toggle", Lights, function(feat)
  menu.notify("Breaklights on", " ", 1, notify_color1)
  local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    while feat.on do
    vehicle.set_vehicle_brake_lights(player_veh, true)
    system.wait(200)
   end
end)

--All Traffic Stop Lights and license plate
menu.add_feature("Traffic Stop Lights ON | OFF", "action", TrafficStop, function()
  license_plate:toggle()
  break_lights:toggle()
  _light1:toggle()
end)

--Get Vehicle to stop
menu.add_feature("Get Vehicle to stop | Aim at Veh.", "action", TrafficStop, function()
  local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
  selectedentity = player.get_entity_player_is_aiming_at(player.player_id())
  VVehicle = entity.is_entity_a_vehicle(selectedentity)
  PPed = entity.is_entity_a_ped(selectedentity)
  audio.play_sound_from_entity(-1, "Change_Station_Loud" , player.get_player_ped(player.player_id()), "Radio_Soundset")
  if (VVehicle == true) then             --Entity is a Vehicle
  menu.notify("No Ped in Vehicle", selectedentity, 1, notify_color1)
  end
  if (PPed == true) then                 --Entity is a ped
  selectedveh = ped.get_vehicle_ped_is_using(selectedentity)  -- Vehicle ped is using
  menu.notify("Selected Ped", selectedentity, 1, notify_color1)
  menu.notify("Selected Vehicle", selectedveh, 1, notify_color1)
  end
end)

--Stop Selected vehicle
menu.add_feature("Stop selected vehicle WIP", "toggle", TrafficStop, function(feat)
if feat.on then
_stopevent = math.random(1,4)
menu.notify("Stop Event", _stopevent, 1, notify_color1)
end
while feat.on do
if (PPed == true) then
   if (_stopevent == 1) then --normal Stop
      network.request_control_of_entity(selectedentity)
      network.request_control_of_entity(selectedveh)
      vehicle.set_vehicle_engine_on(selectedveh, false, true, true)
      _Marker = ui.add_blip_for_entity(selectedveh)
      ui.set_blip_sprite(_Marker, 225)
      ui.set_blip_colour(_Marker, 60)
   end

   if (_stopevent == 2) then --Entity stops and gets out of vehicle
      network.request_control_of_entity(selectedentity)
      network.request_control_of_entity(selectedveh)
      vehicle.set_vehicle_indicator_lights(selectedveh, 2, true)
      system.wait(5000)
      ai.task_leave_vehicle(selectedentity, selectedveh, 1)
      ai.task_turn_ped_to_face_entity(selectedentity, OwnPedd, 20000)
      _Marker = ui.add_blip_for_entity(selectedveh)
      ui.set_blip_sprite(_Marker, 225)
      ui.set_blip_colour(_Marker, 60)
   end

   if (_stopevent == 3) then     --Entity start Pursuit WIP
      local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
      network.request_control_of_entity(selectedentity)
      network.request_control_of_entity(selectedveh)
      ai.task_vehicle_chase(selectedentity, OwnPedd)
      --ai.task_vehicle_chase(selectedentity, player_veh)
      ped.set_ped_combat_attributes(selectedentity, 3, false)--cant leave veh
      ped.set_ped_combat_attributes(selectedentity, 52, true)
      ped.set_ped_combat_ability(selectedentity, 2)
      ai.task_vehicle_drive_to_coord_longrange(selectedentity, selectedveh, v3(math.random(0, 1000), math.random(0, 1000), math.random(0, 1000)), 100, 52, 0)
      _Marker = ui.add_blip_for_entity(selectedveh)
      ui.set_blip_sprite(_Marker, 225)
      ui.set_blip_colour(_Marker, 59)
   end

   if (_stopevent == 4) then     --Entity attacks you
      network.request_control_of_entity(selectedentity)
      network.request_control_of_entity(selectedveh)
      ped.set_ped_combat_range(selectedentity, 1)
      ped.set_ped_combat_movement(selectedentity, 2)
      ped.set_ped_combat_attributes(selectedentity, 1, true)---use veh
      ped.set_ped_combat_attributes(selectedentity, 2, true)--driveby
      ped.set_ped_combat_attributes(selectedentity, 4, true)
      ped.set_ped_combat_ability(selectedentity, 2)
      ped.set_ped_health(selectedentity, 300)
      weapon.give_delayed_weapon_to_ped(selectedentity, 0x1B06D571, 1, 1)
      weapon.give_delayed_weapon_to_ped(selectedentity, 0x1D073A89, 1, 1)
      ai.task_combat_ped(selectedentity, OwnPedd, 0, 16)
      _Marker = ui.add_blip_for_entity(selectedveh)
      ui.set_blip_sprite(_Marker, 229)
      ui.set_blip_colour(_Marker, 59)
   end
end
system.wait(100)
end
if (not feat.on )then--WIP
ui.remove_blip(_Marker)
if (_stopevent == 1) then
   vehicle.set_vehicle_engine_on(selectedveh, true, true, false)
end
end
end)

--Traffis Stop -> selected vehicle follows you
menu.add_feature("Traffic stop selected vehicle follow", "toggle", TrafficStop, function(feat)
local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
while feat.on do
if (PPed == true) then    --Entity is a Ped , selectedveh = vehicle ped is using
   network.request_control_of_entity(selectedentity)
   network.request_control_of_entity(selectedveh)
   ped.clear_ped_tasks_immediately(selectedentity)
   ai.task_vehicle_follow(selectedentity, selectedveh, player_veh, 50, 2883621, 1)
end
system.wait(100)
end
end)

--Spawn Helicopter follow target
local value = menu.add_feature("spawn Helicopter Backup", "toggle", TrafficStop, function(feat)
if feat.on then
local pos = player.get_player_coords(player.player_id())
while not streaming.has_model_loaded(0xAB300C07) do  --ped Pilot
   streaming.request_model(0xAB300C07)
   system.wait(10)
end
while not streaming.has_model_loaded(710198397) do  --Helicopter
   streaming.request_model(710198397)
   system.wait(10)
end

_Helicopter2 = vehicle.create_vehicle(710198397, pos + 100, pos.x, true, false)
entity.set_entity_god_mode(_Helicopter2, true)
_SpawnedPilot2 = ped.create_ped(6, 0xAB300C07, pos, pos.x, true, false)
ped.set_ped_combat_attributes(_SpawnedPilot2, 3, false)  -- Ped cant leave car
ped.set_ped_into_vehicle(_SpawnedPilot2, _Helicopter2, -1)
vehicle.set_vehicle_colors(_Helicopter2, 63, 1)
while feat.on do
   ai.task_vehicle_follow(_SpawnedPilot2, _Helicopter2, selectedentity, 60, 2883621, 150)
   system.wait(100)
end
end
if not feat.on then
network.request_control_of_entity(_SpawnedPilot2)
entity.set_entity_as_no_longer_needed(_SpawnedPilot2)
entity.delete_entity(_SpawnedPilot2)
network.request_control_of_entity(_Helicopter2)
entity.set_entity_as_no_longer_needed(_Helicopter2)
entity.delete_entity(_Helicopter2)
end
end)