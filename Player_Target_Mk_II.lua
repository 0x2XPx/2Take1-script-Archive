menu.add_feature("Player Target Mk II", "toggle", 0, function(f)
	menu.notify("git gud")
	local pedTable = {}
	streaming.request_model(gameplay.get_hash_key("s_m_y_cop_01"))
	local timer = utils.time_ms() + 1000
	while not streaming.has_model_loaded(gameplay.get_hash_key("s_m_y_cop_01")) and timer > utils.time_ms() do
		system.wait(0)
	end
	if timer < utils.time_ms()+900 and not streaming.has_model_loaded(gameplay.get_hash_key("s_m_y_cop_01")) then
		f.on = false
	end
	while f.on do
		if vehicle.get_vehicle_model(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))) == "Oppressor Mk II" then
			if not pedTable then
				pedTable = {}
			end
			for pid = 0, 31 do
				if player.is_player_valid(pid) and pid ~= player.player_id() and not pedTable[pid] and not entity.is_entity_dead(player.get_player_ped(pid)) then
					pedTable[pid] = ped.create_ped(4, gameplay.get_hash_key("s_m_y_cop_01"), player.get_player_coords(pid), 0, false, true)
					entity.set_entity_as_mission_entity(pedTable[pid], true, true)
					entity.attach_entity_to_entity(pedTable[pid], player.get_player_ped(pid), 0, v3(0, 0, 0), v3(0, 0, 0), true, false, false, 0, false)
				elseif not player.is_player_valid(pid) or entity.is_entity_dead(player.get_player_ped(pid)) then
					pedTable[pid] = nil
				end
			end
		elseif pedTable then
			for k, v in pairs(pedTable) do
				entity.detach_entity(v)
				entity.set_entity_as_no_longer_needed(v)
				entity.set_entity_coords_no_offset(v, v3(16000, 16000, -2000))
			end
			pedTable = nil
		end
		system.wait(0)
	end
	streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("s_m_y_cop_01"))
	if pedTable then
		for k, v in pairs(pedTable) do
			entity.detach_entity(v)
			entity.set_entity_as_no_longer_needed(v)
			entity.set_entity_coords_no_offset(v, v3(16000, 16000, -2000))
		end
		pedTable = nil
	end
end)