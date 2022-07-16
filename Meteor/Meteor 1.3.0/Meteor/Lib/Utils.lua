local text_func = require("Meteor/Lib/Text_Func")
local natives = require("Meteor/Lib/Natives")

local utilities = {}

function utilities.dec_to_ipv4(ip)
	return string.format("%i.%i.%i.%i", ip >> 24 & 255, ip >> 16 & 255, ip >> 8 & 255, ip & 255)
end

function utilities.ipv4_to_dec(ipstring)
    local fields = {}
    local pattern = string.format("([^%s]+)", ".")
    ipstring:gsub(pattern, function(c) fields[#fields + 1] = c end)
    local ip_dec = 0
    for i = 1, 4 do
        ip_dec = ip_dec + fields[i] * (256)^(3-i+1)
    end
    return ip_dec
end

function utilities.pos_to_rot(Entity, Position)
    local entity_pos = entity.get_entity_coords(Entity)
    local pos = Position
    local height = 2;

    local X = pos.x - entity_pos.x
    local Y = pos.y - entity_pos.y
    local Z = (entity_pos.z - pos.z + height) * -1

    local pointAtHeadingAngle = math.atan(X, Y) * -180 / math.pi
    local pointAtAngle = math.asin(Z / pos:magnitude(entity_pos)) / (2 * math.pi) * 360

	return v3(pointAtAngle, 0, pointAtHeadingAngle)
end

function utilities.max_vehicle(vehicle_)
    if vehicle_ then
		vehicle.set_vehicle_mod_kit_type(vehicle_, 0)
		for i = 0, 47 do
			local mod = vehicle.get_num_vehicle_mods(vehicle_, i) - 1
			vehicle.set_vehicle_mod(vehicle_, i, mod, true)
			vehicle.toggle_vehicle_mod(vehicle_, mod, true)
		end
		vehicle.set_vehicle_bulletproof_tires(vehicle_, true)
		vehicle.set_vehicle_window_tint(vehicle_, 1)
		vehicle.set_vehicle_number_plate_index(vehicle_, 1)
	end
end

function utilities.downgrade_vehicle(vehicle_)
    if vehicle_ then
		vehicle.set_vehicle_mod_kit_type(vehicle_, 0)
		for i = 0, 47 do
			vehicle.set_vehicle_mod(vehicle_, i, -1, false)
			vehicle.toggle_vehicle_mod(vehicle_, i, false)
		end
		vehicle.set_vehicle_bulletproof_tires(vehicle_, false)
		vehicle.set_vehicle_window_tint(vehicle_, 0)
		vehicle.set_vehicle_number_plate_index(vehicle_, 0)
		vehicle.set_vehicle_livery(vehicle_, 0)
		for i = 0, 3 do
			vehicle.set_vehicle_neon_lights_color(vehicle_, 0)
			vehicle.set_vehicle_neon_light_enabled(vehicle_, i, false)
		end
	end
end

function utilities.is_model_a_fighter_plane(hash)
	if hash == 3319621991 or hash == 1565978651 or hash == 1692272545 or hash == 3013282534 or hash == 1036591958 or hash == 2908775872 or hash == 1824333165 or hash == 970385471 or hash == 2594093022 or hash == 3545667823 then
		return true
	else
		return false
	end
end

function utilities.is_model_a_slow_plane(hash)
	if hash == 2621610858 or hash == 1077420264 or hash == 2176659152 or hash == 970356638 or hash == 1043222410 or hash == 2548391185 or hash == 4262088844 or hash == 3393804037 or hash == 408970549 or hash == 970385471 or hash == 3650256867 or hash == 2531412055 then
		return true
	else
		return false
	end
end

function utilities.get_distance_between(pos1, pos2)
	if math.type(pos1) == "integer" then
		pos1 = entity.get_entity_coords(pos1)
	end
	if math.type(pos2) == "integer" then 
		pos2 = entity.get_entity_coords(pos2)
	end
	return pos1:magnitude(pos2)
end

function utilities.clear_entities(table_of_entities)
	for i = 1, 2 do
		local count = 0
		local removed_entities = 0
		for i, Entity in pairs(table_of_entities) do
			if not ped.is_ped_a_player(Entity) then
				network.request_control_of_entity(Entity)
				count = count + 1
				if network.has_control_of_entity(Entity) then
					ui.remove_blip(ui.get_blip_from_entity(Entity))
					entity.set_entity_as_mission_entity(Entity, false, true)
					entity.delete_entity(Entity)
					if not entity.is_an_entity(Entity) then
						removed_entities = removed_entities + 1
						table_of_entities[i] = nil
					end
				end
				if count % 16 == 15 then
					system.yield(0)
				end
			end
		end
		if i == 1 and removed_entities ~= count then
			system.yield(0)
		end
	end
end

function utilities.get_parent_of_attachments(Entity)
	if entity.is_entity_attached(Entity) then
		return utilities.get_parent_of_attachments(entity.get_entity_attached_to(Entity))
	else
		return Entity
	end
end

function utilities.get_all_attached_entities(Entity)
	local entities = {}
	local all_entities = {}
	local peds = ped.get_all_peds()
	local vehicles = vehicle.get_all_vehicles()
	local objects = object.get_all_objects()
	local pickups = object.get_all_pickups()
	for i = 1, #peds do
		if not ped.is_ped_a_player(peds[i]) then
			table.insert(all_entities, peds[i])
		end
	end
	for i = 1, #vehicles do
		table.insert(all_entities, vehicles[i])
	end
	for i = 1, #objects do
		table.insert(all_entities, objects[i])
	end
	for i = 1, #pickups do
		table.insert(all_entities, pickups[i])
	end
	for i = 1, #all_entities do
		if entity.get_entity_attached_to(all_entities[i]) == Entity and (not entity.is_entity_a_ped(all_entities[i]) or not ped.is_ped_a_player(all_entities[i])) then
			entities[#entities + 1] = all_entities[i]
			local attached_entities = utilities.get_all_attached_entities(all_entities[i])
			table.move(attached_entities, 1, #attached_entities, #entities + 1, entities)
		end
	end
	return entities
end

function utilities.hard_remove_entity(Entity)
	if entity.is_an_entity(Entity) then
		Entity = utilities.get_parent_of_attachments(Entity)
		if entity.is_an_entity(Entity) and (not entity.is_entity_a_ped(Entity) or not ped.is_ped_a_player(Entity)) then
			utilities.clear_entities(utilities.get_all_attached_entities(Entity))
			utilities.clear_entities({Entity})
		end
	end
end

function utilities.request_model(model_hash)
	local is_hash_already_loaded = not streaming.has_model_loaded(model_hash)
	if is_hash_already_loaded then
		streaming.request_model(model_hash)
		local time = utils.time_ms() + 450
		while not streaming.has_model_loaded(model_hash) and time > utils.time_ms() do
			system.yield(0)
		end
	end
	return streaming.has_model_loaded(model_hash), is_hash_already_loaded
end

function utilities.set_entity_coords(i, p)
	network.request_control_of_entity(i)
	while not network.has_control_of_entity(i) do
		network.request_control_of_entity(i)
		system.wait(0)
	end
    entity.set_entity_velocity(i, v3())
    entity.set_entity_coords_no_offset(i, p)
end

function utilities.clear_ptfx(ptfx)
	if ptfx then
		network.request_control_of_entity(ptfx)
		entity.detach_entity(ptfx)
		entity.set_entity_as_mission_entity(ptfx, true, true)
		entity.set_entity_velocity(ptfx, v3())
		entity.set_entity_coords_no_offset(ptfx, v3(8000, 8000, -1000))
		entity.delete_entity(ptfx)
		utilities.hard_remove_entity(ptfx)
		entity.set_entity_as_no_longer_needed(ptfx)
	end
end

function utilities.get_richest_ped()
	local peds = ped.get_all_peds()
	if #peds > 1 then
		table.sort(peds, function(a, b)
			return (natives.GET_PED_MONEY(a):__tointeger() > natives.GET_PED_MONEY(b):__tointeger())
		end)
		return peds[1]
	elseif #peds == 1 then
		return peds[1]
	else
		return nil
	end
end

function utilities.spawn_object(hash, pos, networked, dynamic)
    if not hash then
        return
    end

    utilities.request_model(hash)
    pos = pos or v3()
    networked = networked or true
    dynamic = dynamic or false

    return object.create_object(hash, pos, networked, dynamic)
end

function utilities.remove_player_entities(table_of_entities)
	local new_table = {}
	for i = 1, #table_of_entities do
		if entity.is_an_entity(table_of_entities[i]) and not ped.is_ped_a_player(table_of_entities[i]) and not ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(table_of_entities[i], -1)) then
			table.insert(new_table, table_of_entities[i])
		end
	end
	return new_table
end

function utilities.request_control(Entity)
	if Entity and entity.is_an_entity(Entity) then
		if not network.has_control_of_entity(Entity) then
			network.request_control_of_entity(Entity)
			local time = utils.time_ms() + 1000
			while not network.has_control_of_entity(Entity) and time > utils.time_ms() do
				system.yield(0)
				network.request_control_of_entity(Entity)
			end
			if not network.has_control_of_entity(Entity) then
				menu.notify("Failed to request control of entity!", Meteor, 3, 211)
			end
			return network.has_control_of_entity(Entity)
		end
	end
end

function utilities.is_entity_created_any_player(Entity)
	if Entity and entity.is_an_entity(Entity) then
		if natives.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Entity) ~= 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function utilities.request_control_silent(Entity)
	if Entity and entity.is_an_entity(Entity) then
		if not network.has_control_of_entity(Entity) then
			network.request_control_of_entity(Entity)
			local time = utils.time_ms() + 1000
			while not network.has_control_of_entity(Entity) and time > utils.time_ms() do
				system.yield(0)
				network.request_control_of_entity(Entity)
			end
			return network.has_control_of_entity(Entity)
		end
	end
end

function utilities.get_v3_of_v2(PosV2)
	local pos = select(2, worldprobe.raycast(v3(PosV2.x, PosV2.y, 800), v3(PosV2.x, PosV2.y, -100), -1, player.get_player_ped(player.player_id())))
	return pos + v3(0, 0, 1)
end

function utilities.request_model(Hash)
	local time = utils.time_ms() + 500
	while not streaming.has_model_loaded(Hash) and time > utils.time_ms() do
		system.yield(0)
		streaming.request_model(Hash)
	end
end

function utilities.get_table_of_entities(entity_table, max_count, max_range, remove_players, sort_to_distance, start_pos)
	local new_entity_table = {}
	local current_count = 0
	for i = 1, #entity_table do
		if current_count < max_count then
			if utilities.get_distance_between(start_pos, entity_table[i]) < max_range then
				table.insert(new_entity_table, entity_table[i])
				current_count = current_count + 1
			end
		end
	end
	if remove_players then
		utilities.remove_player_entities(new_entity_table)
	end
	if sort_to_distance then
		table.sort(new_entity_table, function(a, b)
			return (utilities.get_distance_between(a, start_pos) < utilities.get_distance_between(b, start_pos))
		end)
	end
	return new_entity_table
end

function utilities.add_blip_for_entity(Entity, Id)
    local blip = ui.add_blip_for_entity(Entity)
    ui.set_blip_sprite(blip, Id)
end

function utilities.offset_coords_forward(pos, heading, distance)
    heading = math.rad((heading - 180) * -1)
    pos.x = pos.x + (math.sin(heading) * -distance)
    pos.y = pos.y + (math.cos(heading) * -distance)
    return pos
end

function utilities.offset_coords_back(pos, heading, distance)
    heading = math.rad((heading - 360) * -1)
    pos.x = pos.x + (math.sin(heading) * -distance)
    pos.y = pos.y + (math.cos(heading) * -distance)
    return pos
end

function utilities.offset_coords_left(pos, heading, distance)
    heading = math.rad((heading - 90) * -1)
    pos.x = pos.x + (math.sin(heading) * -distance)
    pos.y = pos.y + (math.cos(heading) * -distance)
    return pos
end

function utilities.offset_coords_right(pos, heading, distance)
    heading = math.rad((heading + 90) * -1)
    pos.x = pos.x + (math.sin(heading) * -distance)
    pos.y = pos.y + (math.cos(heading) * -distance)
    return pos
end

return utilities