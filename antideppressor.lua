
-- main feature
local AntiDepressorMain, deppressorCheck, distanceTP,oppressor,hydra,lazer,deluxo,speed,akula,friends,team,max_speed_grief


-- requestObject

local requestObject

local distance = 200

local newSpeed = 10000

local function AntiDepressor()
-- Main Feature
	AntiDepressorMain = menu.add_feature("Anti Depressor", "parent", 0, nil)

	deppressorCheck	= menu.add_feature("Check for Depressor", "toggle", AntiDepressorMain.id, checkForDepressor)
	deppressorCheck.threaded = true


	local settings =  menu.add_feature("Settings", "parent", AntiDepressorMain.id, nil)

	distanceTP = menu.add_feature("Distance Blocking", "autoaction_value_i", settings.id, function(f)
		if f.value_i > distance then
			distance = distance+100
		else
			distance = distance-100
		end
		
		distanceTP.value_i = distance
	end)
	
	distanceTP.max_i = 10000
	distanceTP.value_i = distance
	distanceTP.threaded = false
	
	
	speed = menu.add_feature("New Speed", "autoaction_value_i", settings.id, function(f)
		if f.value_i > newSpeed then
			newSpeed = newSpeed+100
		else
			newSpeed = newSpeed-100
		end
		
		speed.value_i = newSpeed
	end)
	
	speed.max_i = 100000
	speed.min_i = -1000
	speed.value_i = newSpeed
	speed.threaded = false
	
	oppressor	= menu.add_feature("Oppressor", "toggle", settings.id,nil)
	oppressor.threaded = false
	
	hydra	= menu.add_feature("Hydra", "toggle", settings.id,nil)
	hydra.threaded = false
	
	lazer	= menu.add_feature("Lazer", "toggle", settings.id,nil)
	lazer.threaded = false
	
	deluxo	= menu.add_feature("Deluxo", "toggle", settings.id,nil)
	deluxo.threaded = false
	
	akula = menu.add_feature("Akula", "toggle", settings.id,nil)
	akula.threaded = false
	
	team = menu.add_feature("Ignore Team", "toggle", settings.id,nil)
	team.threaded = false
	
	friends = menu.add_feature("Ignore Friends", "toggle", settings.id,nil)
	friends.threaded = false
	
	max_speed_grief = menu.add_feature("Grief Max Speed", "toggle", settings.id,nil)
	max_speed_grief.threaded = false
	
	
	requestObject = {}
end



function checkForDepressor()
	for slot = 0, 31 do		
		local oldCord = player.get_player_coords(slot)
		local newCord = getMySelfCoords()		
		local tempdistance = math.sqrt(math.pow(newCord['x'] - oldCord['x'],2) + math.pow(newCord['y'] - oldCord['y'],2) + math.pow(newCord['z'] - oldCord['z'],2))
				
		--if slot ~= player.player_id() and (not player.is_player_friend(slot) and friends.on) and (player.get_player_team(slot) == player.get_player_team(player.player_id()) and team.on) then
		if slot ~= player.player_id()  then
			if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
				if (friends.on and not player.is_player_friend(slot)) or not friends.on then
					if (player.get_player_team(slot) ~= player.get_player_team(player.player_id()) and team.on) or not team.on then
						if 	tempdistance <= distance then
							--check if oppressor
							local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(slot))
														
							local rotation = v3()
							rotation.z = 180
							rotation.y = 0
							rotation.x = 0
							
							-- Oppressor MK2
							if entity.get_entity_model_hash(veh) == 2069146067 and oppressor.on then
								if not network.has_control_of_entity(veh) then
									network.request_control_of_entity(veh)	
								end	
								entity.set_entity_max_speed(veh,10000)
								vehicle.set_vehicle_out_of_control(veh,false,false)		
								entity.set_entity_rotation(veh,rotation)
								vehicle.set_vehicle_forward_speed(veh, newSpeed)
								ui.notify_above_map("Trying to stop Oppressor with player " .. player.get_player_name(slot) ,"Anti Depressor",140)
								if max_speed_grief.on then									
									system.wait(2000)
									if not network.has_control_of_entity(veh) then
										network.request_control_of_entity(veh)	
									end	
									entity.set_entity_max_speed(veh,1)							
								end
							end	
							
							--lazer
							if entity.get_entity_model_hash(veh) == 3013282534  and lazer.on then
								if not network.has_control_of_entity(veh) then
									network.request_control_of_entity(veh)	
								end	
								entity.set_entity_max_speed(veh,100000)								
								vehicle.set_vehicle_out_of_control(veh,false,false)	
								entity.set_entity_rotation(veh,rotation)	
								vehicle.set_vehicle_forward_speed(veh, newSpeed)
								ui.notify_above_map("Trying to stop lazer with player " .. player.get_player_name(slot) ,"Anti Depressor",140)
								if max_speed_grief.on then									
									system.wait(2000)
									if not network.has_control_of_entity(veh) then
										network.request_control_of_entity(veh)	
									end	
									entity.set_entity_max_speed(veh,1)						
								end
							end	
							
							--hydra
							if entity.get_entity_model_hash(veh) == 970385471 and hydra.on then
								if not network.has_control_of_entity(veh) then
									network.request_control_of_entity(veh)	
								end		
								entity.set_entity_max_speed(veh,1)
								vehicle.set_vehicle_out_of_control(veh,false,false)		
								entity.set_entity_rotation(veh,rotation)
								vehicle.set_vehicle_forward_speed(veh, newSpeed)
								if max_speed_grief.on then									
									system.wait(2000)
									if not network.has_control_of_entity(veh) then
										network.request_control_of_entity(veh)	
									end	
									entity.set_entity_max_speed(veh,1)							
								end
							end	
							
							--deluxo
							if entity.get_entity_model_hash(veh) == 1483171323 and deluxo.on then
								if not network.has_control_of_entity(veh) then
									network.request_control_of_entity(veh)	
								end			
								entity.set_entity_max_speed(veh,100000)
								entity.set_entity_rotation(veh,rotation)
								vehicle.set_vehicle_out_of_control(veh,false,false)		
								vehicle.set_vehicle_forward_speed(veh, newSpeed)
								ui.notify_above_map("Trying to stop deluxo with player " .. player.get_player_name(slot) ,"Anti Depressor",140)
								if max_speed_grief.on then									
									system.wait(2000)
									if not network.has_control_of_entity(veh) then
										network.request_control_of_entity(veh)	
									end	
									entity.set_entity_max_speed(veh,1)				
								end
							end	
							
							--akula
							if entity.get_entity_model_hash(veh) == 1181327175 and akula.on then
								if not network.has_control_of_entity(veh) then
									network.request_control_of_entity(veh)	
								end		
								entity.set_entity_max_speed(veh,100000)
								veh.set_vehicle_out_of_control(veh,false,false)		
								entity.set_entity_rotation(veh,rotation)
								vehicle.set_vehicle_forward_speed(veh, newSpeed)								
								ui.notify_above_map("Trying to stop akula with player " .. player.get_player_name(slot) ,"Anti Depressor",140)
								if max_speed_grief.on then									
									system.wait(2000)
									if not network.has_control_of_entity(veh) then
										network.request_control_of_entity(veh)	
									end	
									entity.set_entity_max_speed(veh,1)			
								end
							end						
						end	
					else
						--print(player.get_player_name(slot) .. " is team")
					end
				else
					--print(player.get_player_name(slot) .. " is a friend")
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

function getMySelfCoords()
	return player.get_player_coords(player.player_id())
end

AntiDepressor()