if modLoaded then
	ui.notify_above_map("Teleport is already loaded.", "Teleport", 140)
	return
end
modLoaded = true

function tpUp()
	local ent
	local player = player.get_player_ped(player.player_id())
    if ped.is_ped_in_any_vehicle(player) then
        ent = ped.get_vehicle_ped_is_using(player, false)
    else
        ent = player
    end
    
    local position = entity.get_entity_coords(ent) + v3(0.0, 0.0, 5.0)
    entity.set_entity_coords_no_offset(ent, position)

	return HANDLER_POP
end

function tpForward()
	local ent
	local player = player.get_player_ped(player.player_id())
    if ped.is_ped_in_any_vehicle(player) then
        ent = ped.get_vehicle_ped_is_using(player, false)
    else
        ent = player
    end

    local dir = entity.get_entity_rotation(ent)
    dir:transformRotToDir()
    local position = entity.get_entity_coords(ent) + (v3(5.0, 5.0, 0.0) * dir)
    entity.set_entity_coords_no_offset(ent, position)

	return HANDLER_POP
end

function main()
    top = menu.add_feature("Teleport", "parent", 0)
    menu.add_feature("Teleport Up", "action", top.id, tpUp)
    menu.add_feature("Teleport Forward", "action", top.id, tpForward)
end

main()