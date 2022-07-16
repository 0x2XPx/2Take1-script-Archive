local utilities = require("Meteor/Lib/Utils")
local text_func = require("Meteor/Lib/Text_Func")
local DataMain = require("Meteor/Data/DataMain")
local natives = require("Meteor/Lib/Natives")

local player_func = {}

function player_func.is_player_rockstar_admin_scid(pid)
	local is_player_rockstar_admin = false
	for i = 1, #DataMain.all_admin_scids do
		if player.get_player_scid(pid) == DataMain.all_admin_scids[i] then
			is_player_rockstar_admin = true
		end
	end
	return is_player_rockstar_admin
end

function player_func.is_player_rockstar_admin_name(pid)
	local is_player_rockstar_admin = false
	for i = 1, #DataMain.all_admin_names do
		if player.get_player_name(pid) == DataMain.all_admin_names[i] then
			is_player_rockstar_admin = true
		end
	end
	return is_player_rockstar_admin
end

function player_func.is_player_rockstar_admin_ip(pid)
	local is_player_rockstar_admin = false
	for i = 1, #DataMain.all_admin_ips do
		if utilities.dec_to_ipv4(player.get_player_ip(pid)) == DataMain.all_admin_ips[i] then
			is_player_rockstar_admin = true
		end
	end
	return is_player_rockstar_admin
end

function player_func.is_player_driver(pid)
	return player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(pid), -1)) == pid
end

function player_func.get_player_name(pid, mode)
	local Name = "**Invalid**"
	if player.is_player_valid(pid) then
		if mode == 1 then
			Name = player.get_player_name(pid)
		elseif mode == 2 then
			Name = natives.GET_PLAYER_NAME(pid):__tostring(true)
		elseif mode == 3 then
			Name = natives.NETWORK_PLAYER_GET_NAME(pid):__tostring(true)
		else
			local Buffer = native.ByteBuffer8()
			natives.NETWORK_HANDLE_FROM_PLAYER(pid, Buffer, 13)
			local Start = natives.NETWORK_GAMERTAG_FROM_HANDLE_START(Buffer):__tointeger()
			if Start == 1 then
				local GetName = natives.NETWORK_GET_GAMERTAG_FROM_HANDLE(Buffer):__tostring(true)
				local End = natives.NETWORK_GAMERTAG_FROM_HANDLE_SUCCEEDED():__tointeger()
				if End == 1 then
					Name = GetName
				end
			end
		end
	end
	return Name
end

function player_func.is_player_typing(pid)
	if script.get_global_i(1644218 + 2 + 241 + 136 + pid) & 1 << 16 == 0 then
		return false
	else
		return true
	end
end

function player_func.is_player_rockstar_dev(pid)
	return natives.NETWORK_PLAYER_IS_ROCKSTAR_DEV(pid):__tointeger() == 1
end

function player_func.is_player_cheater(pid)
	return natives.NETWORK_PLAYER_INDEX_IS_CHEATER(pid):__tointeger() == 1
end

function player_func.get_accurate_non_interior_bool(pid)
	local is_in_interior = true
	for i = 1, #DataMain.non_interior_flags do
		if interior.get_interior_from_entity(player.get_player_ped(pid)) == DataMain.non_interior_flags[i] then
			is_in_interior = false
		end
	end
	return is_in_interior
end

function player_func.is_player_driving_train(pid)
	if player.is_player_in_any_vehicle(pid) and entity.get_entity_model_hash(player.get_player_vehicle(pid)) == 1030400667 then
		return true
	else
		return false
	end
end

function player_func.get_player_flag_string(pid)
	if pid then
		if player.is_player_valid(pid) then
			local player_flag_string = "["
			if pid == player.player_id() then
				player_flag_string = player_flag_string .. "Y"
			end
			if not player.is_player_playing(pid) then
				player_flag_string = player_flag_string .. "I"
			end
			if player.is_player_friend(pid) then
				player_flag_string = player_flag_string .. "F"
			end
			if player_func.is_player_rockstar_dev(pid) then
				player_flag_string = player_flag_string .. "D"
			end
			if player_func.is_player_cheater(pid) then
				player_flag_string = player_flag_string .. "C"
			end
			if player.is_player_modder(pid, -1) then
				player_flag_string = player_flag_string .. "M"
			end
			if player_func.is_player_rockstar_admin_scid(pid) or player_func.is_player_rockstar_admin_name(pid) or player_func.is_player_rockstar_admin_ip(pid) then
				player_flag_string = player_flag_string .. "A"
			end
			if player.is_player_host(pid) then
				player_flag_string = player_flag_string .. "H"
			end
			if pid == script.get_host_of_this_script() then
				player_flag_string = player_flag_string .. "S"
			end
			player_flag_string = player_flag_string .. "]"
			return player_flag_string
		end
	end
end

function player_func.is_player_moving_slow(pid)
	if player.is_player_valid(pid) then
		local pos = player.get_player_coords(pid)
		system.wait(0)
		if pos.x ~= player.get_player_coords(pid).x or pos.y ~= player.get_player_coords(pid).y then
			return true
		else
			return false
		end
	else
		return false
	end
end

function player_func.is_player_moving(pid)
	if player.is_player_valid(pid) then
		local pos = v3(text_func.round_two_dc(player.get_player_coords(pid).x), text_func.round_two_dc(player.get_player_coords(pid).y), text_func.round_two_dc(player.get_player_coords(pid).z))
		system.wait(0)
		if pos.x ~= text_func.round_two_dc(player.get_player_coords(pid).x) or pos.y ~= text_func.round_two_dc(player.get_player_coords(pid).y) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function player_func.is_player_moving_fast(pid)
	if player.is_player_valid(pid) then
		local is_moving = false
		local pos_x = player.get_player_coords(pid).x
		local pos_y = player.get_player_coords(pid).y
		system.wait(0)
		if text_func.round_one_dc(pos_x) ~= text_func.round_one_dc(player.get_player_coords(pid).x) or text_func.round_one_dc(pos_y) ~= text_func.round_one_dc(player.get_player_coords(pid).y) then
			is_moving = true
		end
		return is_moving
	else
		return false
	end
end

function player_func.get_surface_player_is_aiming_at(pid)
	local rot = cam.get_gameplay_cam_rot()
	rot:transformRotToDir()
	local pos = select(2, worldprobe.raycast(player.get_player_coords(pid), rot * 1000 + cam.get_gameplay_cam_pos(), -1, player.get_player_ped(pid)))
	return pos
end

function player_func.is_friend_in_host_queue()
	local is_friend_in_queue = false
	for pid = 0, 31 do
		if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) and player.is_player_friend(pid) then
			is_friend_in_queue = true
		end
	end
	return is_friend_in_queue
end

function player_func.is_anyone_in_vehicle_except_you(Vehicle)
	local is_anyone_in_vehicle = false
	for pid = 0, 31 do
		if player.is_player_valid(pid) and player.player_id() ~= pid and ped.is_ped_in_vehicle(player.get_player_ped(pid), Vehicle) then
			is_anyone_in_vehicle = true
		end
	end
	return is_anyone_in_vehicle
end

function player_func.get_id_from_name(string_name)
	if string_name == "" or math.type(tonumber(string_name)) == "integer" then
		return nil
	else
		local is_checking_names = true
		local first_match = nil
		for pid = 0, 31 do
			if player.is_player_valid(pid) then
				if is_checking_names then
					if string.find(player.get_player_name(pid):lower(), string_name:lower()) then
						first_match = pid
						is_checking_names = false
					end
				end
			end
		end
		return first_match
	end
end

function player_func.get_host_queue_count()
	host_queue_count = 0
	for pid = 0, 31 do
		if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) then
			host_queue_count = host_queue_count + 1
		end
	end
	return host_queue_count
end

function player_func.is_player_in_interior(pid)
	if player.is_player_valid(pid) then
		if interior.get_interior_from_entity(player.get_player_ped(pid)) ~= 0 or player.get_player_coords(pid).z < 0 or player.get_player_coords(pid).z > 800 or player.get_player_coords(pid).x > 10700 or player.get_player_coords(pid).y > 10700 or player.get_player_coords(pid).x < -10700 or player.get_player_coords(pid).y < -10700 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function player_func.change_player_model(hash, isWaterAnimal)
	if player.is_player_valid(player.player_id()) and not player.is_player_in_any_vehicle(player.player_id()) and (isWaterAnimal and entity.is_entity_in_water(player.get_player_ped(player.player_id())) or (not isWaterAnimal and not entity.is_entity_in_water(player.get_player_ped(player.player_id()))) or (not isWaterAnimal and entity.is_entity_in_water(player.get_player_ped(player.player_id())))) then
    	utilities.request_model(hash)
   		player.set_player_model(hash)
    	streaming.set_model_as_no_longer_needed(hash)
		system.wait(0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 4, 0, 0, 2)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
    else
        menu.notify("Model Change not possible!", Meteor, 3, 211)
	end
end

function player_func.get_closest_player_to_coords(coords)
	local player_table = {}
	for pid = 0, 31 do
		if player.player_id() ~= pid and player.is_player_valid(pid) then
			table.insert(player_table, player.get_player_ped(pid))
		end
	end
	table.sort(player_table, function(a, b)
		return (utilities.get_distance_between(a, coords) < utilities.get_distance_between(b, coords))
	end)
	if #player_table == 0 then
		return player.player_id()
	else
		return player.get_player_from_ped(player_table[1])
	end
end

function player_func.get_closest_player_to_coords_in_range(coords, range)
	local player_table = {}
	for pid = 0, 31 do
		if player.player_id() ~= pid and player.is_player_valid(pid) and utilities.get_distance_between(coords, player.get_player_coords(pid)) < range then
			table.insert(player_table, player.get_player_ped(pid))
		end
	end
	table.sort(player_table, function(a, b)
		return (utilities.get_distance_between(a, coords) < utilities.get_distance_between(b, coords))
	end)
	if #player_table == 0 then
		return player.player_id()
	else
		return player.get_player_from_ped(player_table[1])
	end
end

return player_func