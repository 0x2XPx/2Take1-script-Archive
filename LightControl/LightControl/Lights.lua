require('LigtControl')

--Blue Light 1
_light1 = menu.add_feature("Blue Light 1", "value_i", Lights, function(feat)
if feat.on then
   menu.notify("Light on", " ", 1, notify_color1)
   player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
   hlightcolor = vehicle.get_vehicle_headlight_color(player_veh)
   while feat.on do
      Blue_Lights[1][2] = feat.value
      vehicle.toggle_vehicle_mod(player_veh, 22, true)
      vehicle.set_vehicle_headlight_color(player_veh, 1)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 0)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 1)
      system.wait(feat.value + 40)
      vehicle.set_vehicle_headlight_color(player_veh, 0)
      system.wait((feat.value + 40)*5)
	  system.wait(0)
   end
end
if not feat.on then
   vehicle.set_vehicle_headlight_color(player_veh, hlightcolor)
end
end)
_light1.min = 50
_light1.mod = 10
_light1.max = 120
--blue_light1.value = 60
_light1.value = Blue_Lights[1][2]

--Blue Light 2
_light2 = menu.add_feature("Blue Light 2", "value_i", Lights, function(feat)
if feat.on then
   menu.notify("Light on"," ", 1, notify_color1)
   player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
   hlightcolor = vehicle.get_vehicle_headlight_color(player_veh)
   vehicle.toggle_vehicle_mod(player_veh, 22, true)
   while feat.on do
      Blue_Lights[2][2] = feat.value
      vehicle.set_vehicle_headlight_color(player_veh, 1)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 0)
      system.wait(feat.value)
	  system.wait(0)
   end
end
if not feat.on then
   vehicle.set_vehicle_headlight_color(player_veh, hlightcolor)
end
end)
_light2.min = 10
_light2.mod = 10
_light2.max = 400
--blue_light2.value = 50
_light2.value = Blue_Lights[2][2]

--Blue light 3
_light3 = menu.add_feature("Blue Light 3", "value_i", Lights, function(feat)
if feat.on then
   menu.notify("Light on", " ", 1, notify_color1)
   player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
   hlightcolor = vehicle.get_vehicle_headlight_color(player_veh)
   vehicle.toggle_vehicle_mod(player_veh, 22, true)
   while feat.on do
      Blue_Lights[3][2] = feat.value
      vehicle.set_vehicle_headlight_color(player_veh, 1)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 0)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 1)
      system.wait(feat.value + 40)
      vehicle.set_vehicle_headlight_color(player_veh, 0)
      system.wait(feat.value + 240)
	  system.wait(0)
   end
end
if not feat.on then
   vehicle.set_vehicle_headlight_color(player_veh, hlightcolor)
end
end)
_light3.min = 20
_light3.mod = 5
_light3.max = 120
--blue_light3.value = 60
_light3.value = Blue_Lights[3][2]

--Blue light 4
_light4 = menu.add_feature("Blue Light 4", "value_i", Lights, function(feat)
if feat.on then
   menu.notify("Light on", " ", 1, notify_color1)
   player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
   hlightcolor = vehicle.get_vehicle_headlight_color(player_veh)
   vehicle.toggle_vehicle_mod(player_veh, 22, true)
   while feat.on do
      Blue_Lights[4][2] = feat.value
      vehicle.set_vehicle_headlight_color(player_veh, 8)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 1)
      system.wait(feat.value)
	  system.wait(0)
   end
end
if not feat.on then
   vehicle.set_vehicle_headlight_color(player_veh, hlightcolor)
end
end)
_light4.min = 70
_light4.max = 200
_light4.mod = 10
--blue_light4.value = 70
_light4.value = Blue_Lights[4][2]

--Blue light 5
_light5 = menu.add_feature("Blue Light 5", "value_i", Lights, function(feat)
if feat.on then
   menu.notify("Light on", " ", 1, notify_color1)
   player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
   hlightcolor = vehicle.get_vehicle_headlight_color(player_veh)
   vehicle.toggle_vehicle_mod(player_veh, 22, true)
   while feat.on do
      Blue_Lights[5][2] = feat.value
      vehicle.set_vehicle_headlight_color(player_veh, 8)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 7)
      system.wait(feat.value)
	  system.wait(0)
   end
end
if not feat.on then
   vehicle.set_vehicle_headlight_color(player_veh, hlightcolor)
end
end)
_light5.min = 100
_light5.max = 300
_light5.mod = 10
--blue_light5.value = 120
_light5.value = Blue_Lights[5][2]


--Blue_Lights = {{blue_light1, 60}, {blue_light2, 50}, {blue_light3, 60}, {blue_light4, 70}, {blue_light5, 120}} 

--Warning Lights
local warning_lights = menu.add_feature("Warning Lights", "toggle", Lights, function(feat)
if feat.on then
   menu.notify("Warning Lights on"," ", 1, notify_color1)
   player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
   hlightcolor = vehicle.get_vehicle_headlight_color(player_veh)
   vehicle.toggle_vehicle_mod(player_veh, 22, true)
   while feat.on do
      vehicle.set_vehicle_headlight_color(player_veh, 7)
      -- vehicle.set_vehicle_brake_lights(player_veh, true)
      system.wait(450)
      vehicle.set_vehicle_headlight_color(player_veh, 0)
      -- vehicle.set_vehicle_brake_lights(player_veh, true)
      system.wait(450)
   end
end
if not feat.on then
   vehicle.set_vehicle_headlight_color(player_veh, hlightcolor)
end
end)

--Light Flashes
menu.add_feature("Headlight Flash", "action", Lights, function()
local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
local hlightcolor = vehicle.get_vehicle_headlight_color(player_veh)
vehicle.toggle_vehicle_mod(player_veh, 22, true)
vehicle.set_vehicle_headlight_color(player_veh, 2)
system.wait(100)
vehicle.set_vehicle_headlight_color(player_veh, 0)
system.wait(100)
vehicle.set_vehicle_headlight_color(player_veh, 2)
system.wait(100)

vehicle.set_vehicle_headlight_color(player_veh, hlightcolor)
end)

-- Rainbow Headlight
_light6 = menu.add_feature("Rainbow Lights", "value_i", Lights, function(feat)
if feat.on then
   menu.notify("Rainbow Lights on", " ", 1, notify_color1)
   player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
   hlightcolor = vehicle.get_vehicle_headlight_color(player_veh)

   while feat.on do
      Blue_Lights[6][2] = feat.value
      vehicle.toggle_vehicle_mod(player_veh, 22, true)
      vehicle.set_vehicle_headlight_color(player_veh, 10)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 9)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 11)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 12)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 1)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 2)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 3)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 4)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 6)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 5)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 7)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 8)
      system.wait(feat.value)
      vehicle.set_vehicle_headlight_color(player_veh, 0)
      system.wait(feat.value)
   end
end
if not feat.on then
   vehicle.set_vehicle_headlight_color(player_veh, hlightcolor)
end
end)
_light6.min = 10
_light6.mod = 10
_light6.max = 2000
_light6.value = Blue_Lights[6][2]

--Police light with horn
Feature9 = menu.add_feature("Press Horn | Police Lights", "value_i", Lights, function(feat)
if feat.on then
   Features[9][3] = feat.value
   local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
   local i = 1
   
   while feat.on do
      if (controls.is_control_just_pressed(0, 86) and ped.is_ped_in_vehicle(OwnPedd, player_veh)) then
         if (feat.value == 1) then
            _light1:toggle()
         elseif (feat.value == 2) then
            _light2:toggle()
         elseif (feat.value == 3) then
            _light3:toggle()
         elseif (feat.value == 4) then
            _light4:toggle()
         elseif (feat.value == 5) then
            _light5:toggle()
         end
         i = i + 1
         if (i%2 == 0) then          -- i is even
            menu.notify("Light on", " ", 1, notify_color1)
         else                        -- i is odd
            menu.notify("Light off", " ", 1, notify_color1)
         end
      end
      system.wait(0)
   end
end
end)
Feature9.min = 1
Feature9.mod = 1
Feature9.max = 5
Feature9.value = Features[9][3]