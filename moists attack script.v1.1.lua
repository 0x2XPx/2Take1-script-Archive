local lester = {}
local boobs = {}
local animal = {}
local lesveh = {}
local vehtype = {"Oppressor","Oppressor2"}
local wpn = {0x958A4A8F, 0x6D544C99}
local wpnsel
local runs = 0
local pid
local pname
local myplygrp
local animal_model

function playersid(feat)
    pid = feat.value_i
    wpnsel = wpn[2]
	animal_model = 0xA8683715
    if player.get_player_scid(pid) ~= 4294967295 then
	pname = tostring("PID Target Not Valid or Selected")
    else
        plygrp = player.get_player_group(pid)
        myplygrp = player.get_player_group(player.player_id())
        pname = tostring(player.get_player_name(pid))
        ui.notify_above_map("Session Player ID set to: " .. pid .. "\n" .. pname .. "\nTarget Player Group ID: " .. plygrp.."\nMy Player Group ID: "..myplygrp.."\nChimp Set as Default Animal Attacker\nRailgun set as Default Attacker Weapon", "Player ID Selection", 212)
		
    end
    return HANDLER_POP

end


op_lester = function(attack, t, mod_id, posz)
	local modd = tonumber(mod_id)
    local pedp = player.get_player_ped(pid)
    local pos = player.get_player_coords(pid)
    pos.x = pos.x + 5
    pos.y = pos.y + 5

	pos.z = pos.z + posz

    local model = gameplay.get_hash_key("ig_lestercrest_2")
    streaming.request_model(model)

    while (not streaming.has_model_loaded(model)) do
        return HANDLER_CONTINUE
    end

    local i = #lester + 1
    lester[i] = ped.create_ped(29, model, pos, pos.z, true, false)

    streaming.set_model_as_no_longer_needed(model)

    local vehhash = gameplay.get_hash_key(vehtype[t])

    streaming.request_model(vehhash)
    while (not streaming.has_model_loaded(vehhash)) do
        return HANDLER_CONTINUE
    end

    local y = #lesveh + 1
    lesveh[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
	vehicle.set_vehicle_mod_kit_type(lesveh[y], 0)
	vehicle.get_vehicle_mod(lesveh[y], 10)
	vehicle.set_vehicle_mod(lesveh[y], 10, modd, false)
	ui.add_blip_for_entity(lesveh[y])
    vehicle.set_vehicle_on_ground_properly(lesveh[y])
    entity.set_entity_god_mode(lesveh[y], true)
    vehicle.set_vehicle_doors_locked(lesveh[y], 5)

    network.request_control_of_entity(lesveh[y])

    ped.set_ped_combat_attributes(lester[i], 46, true)

    ped.set_ped_combat_attributes(lester[i], 52, true)

    ped.set_ped_combat_attributes(lester[i], 1, true)

    ped.set_ped_combat_attributes(lester[i], 2, true)

    ped.set_ped_combat_range(lester[i], 2)

    ped.set_ped_combat_ability(lester[i], 2)

    ped.set_ped_combat_movement(lester[i], 2)
    ped.set_ped_into_vehicle(lester[i], lesveh[y], -1)
    if ai.task_vehicle_drive_wander(lester[i], lesveh[y], 180, 262144) then
        return HANDLER_CONTINUE
    end

    vehicle.set_vehicle_doors_locked(lesveh[y], 6)

    vehicle.set_vehicle_on_ground_properly(lesveh[y])
    vehicle.set_vehicle_doors_locked(lesveh[y], 2)
    entity.set_entity_coords_no_offset(lesveh[y], pos)

    vehicle.set_vehicle_on_ground_properly(lesveh[y])

    if attack == true then
	ai.task_combat_ped(lester[i], pedp, 0, 16)
    end
	vehicle.set_vehicle_on_ground_properly(lesveh[y])

    streaming.set_model_as_no_longer_needed(vehhash)

end

apc_lester = function(attack)
    local pedp = player.get_player_ped(pid)
    local pos = player.get_player_coords(pid)
    pos.x = pos.x + 5
    pos.y = pos.y + 5

    local model = gameplay.get_hash_key("ig_lestercrest_2")
    local vehhash = gameplay.get_hash_key("apc")
    streaming.request_model(model)

    while (not streaming.has_model_loaded(model)) do
        return HANDLER_CONTINUE
    end

    local i = #lester + 1
    lester[i] = ped.create_ped(29, model, pos, pos.z, true, false)



    streaming.request_model(vehhash)
    while (not streaming.has_model_loaded(vehhash)) do
        return HANDLER_CONTINUE
    end

    local y = #lesveh + 1
    lesveh[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
	ui.add_blip_for_entity(lesveh[y])
    ped.set_ped_into_vehicle(lester[i], lesveh[y], -1)	
    vehicle.set_vehicle_on_ground_properly(lesveh[y])
    entity.set_entity_god_mode(lesveh[y], true)
    vehicle.set_vehicle_doors_locked(lesveh[y], 5)
	
    vehicle.get_vehicle_mod(lesveh[y], 10)
    vehicle.set_vehicle_mod(lesveh[y], 10, 0, false)
    network.request_control_of_entity(lesveh[y])

    ped.set_ped_combat_attributes(lester[i], 46, true)

    ped.set_ped_combat_attributes(lester[i], 52, true)

    ped.set_ped_combat_attributes(lester[i], 1, true)

    ped.set_ped_combat_attributes(lester[i], 2, true)

    ped.set_ped_combat_range(lester[i], 2)

    ped.set_ped_combat_ability(lester[i], 2)

    ped.set_ped_combat_movement(lester[i], 2)

    if ai.task_vehicle_drive_wander(lester[i], lesveh[y], 180, 262144) then
        return HANDLER_CONTINUE
    end
    local i = #lester + 1
	
    lester[i] = ped.create_ped(29, model, pos, pos.z, true, false)

    ped.set_ped_combat_attributes(lester[i], 52, true)
    ped.set_ped_combat_attributes(lester[i], 1, true)
    ped.set_ped_combat_attributes(lester[i], 46, true)
    ped.set_ped_combat_attributes(lester[i], 2, true)
    ped.set_ped_combat_range(lester[i], 2)
    ped.set_ped_combat_ability(lester[i], 2)
    ped.set_ped_combat_movement(lester[i], 2)

    ped.set_ped_into_vehicle(lester[i], lesveh[y], 0)

    vehicle.set_vehicle_doors_locked(lesveh[y], 6)

    pos = player.get_player_coords(pid)

    pos.x = pos.x + 8
    pos.y = pos.y + 8
    vehicle.set_vehicle_on_ground_properly(lesveh[y])
    vehicle.set_vehicle_doors_locked(lesveh[y], 2)
    entity.set_entity_coords_no_offset(lesveh[y], pos)
    vehicle.set_vehicle_on_ground_properly(lesveh[y])
	
	if attack == true then
    ai.task_combat_ped(lester[i], pedp, 0, 16)
	end

 
    streaming.set_model_as_no_longer_needed(vehhash)
    streaming.set_model_as_no_longer_needed(model)
end


send_boobs_para = function(feat)
    local pedp = player.get_player_ped(pid)
    local model = 2633130371
    local parachute = 0xfbab5776
    local pos = player.get_player_coords(pid)
    local offset = v3()
    offset.z = 40
    pos.x = pos.x + 5
    pos.y = pos.y + 15

    streaming.request_model(model)

    while not streaming.has_model_loaded(model) do
        system.wait(0)
    end
    local i = #boobs + 1
    boobs[i] = ped.create_ped(5, model, pos + offset, 0, true, false)
    ped.set_ped_can_switch_weapons(boobs[i], true)
    ped.set_ped_combat_attributes(boobs[i], 46, true)
    ped.set_ped_combat_attributes(boobs[i], 52, true)
    ped.set_ped_combat_attributes(boobs[i], 1, true)
    ped.set_ped_combat_attributes(boobs[i], 2, true)
    ped.set_ped_combat_range(boobs[i], 2)
    ped.set_ped_combat_ability(boobs[i], 2)
    ped.set_ped_combat_movement(boobs[i], 2)

    ui.add_blip_for_entity(boobs[i])
    entity.set_entity_god_mode(boobs[i], true)
    weapon.give_delayed_weapon_to_ped(boobs[i], parachute, 1, 0)
    system.wait(0)

    ai.task_parachute_to_target(boobs[i], pos)
    system.wait(10000)
    weapon.give_delayed_weapon_to_ped(boobs[i], wpnsel, 1, 1)

    streaming.set_model_as_no_longer_needed(model)

    system.wait(1000)

    ai.task_combat_ped(boobs[i], pedp, 0, 16)
end

send_lester_para = function(feat)
    local pedp = player.get_player_ped(pid)
    local model = gameplay.get_hash_key("ig_lestercrest_2")
    local parachute = 0xfbab5776
    local pos = player.get_player_coords(pid)
    local offset = v3()
    offset.z = 40
    pos.x = pos.x + 5
    pos.y = pos.y + 15

    streaming.request_model(model)

    while not streaming.has_model_loaded(model) do
        system.wait(0)
    end
    local i = #lester + 1
    lester[i] = ped.create_ped(5, model, pos + offset, 0, true, false)
	ui.add_blip_for_entity(lester[i])
    entity.set_entity_god_mode(lester[i], true)
    ped.set_ped_can_switch_weapons(lester[i], true)
    ped.set_ped_combat_attributes(lester[i], 46, true)
    ped.set_ped_combat_attributes(lester[i], 52, true)
    ped.set_ped_combat_attributes(lester[i], 1, true)
    ped.set_ped_combat_attributes(lester[i], 2, true)
    ped.set_ped_combat_range(lester[i], 2)
    ped.set_ped_combat_ability(lester[i], 2)
    ped.set_ped_combat_movement(lester[i], 2)
    weapon.give_delayed_weapon_to_ped(lester[i], parachute, 1, 0)
    system.wait(0)
	ai.task_parachute_to_target(lester[i], pos)
    system.wait(10000)
    weapon.give_delayed_weapon_to_ped(lester[i], 0x6D544C99, 1, 1)

    streaming.set_model_as_no_longer_needed(model)

    system.wait(1000)

    ai.task_combat_ped(lester[i], pedp, 0, 16)
end

set_boobs_weapon = function(feat)
    local y = tonumber(feat.value_i)
    wpnsel = wpn[y]
end

send_lester = function(feat)
    local amount = tonumber(feat.value_i)
    for i = 1, amount do
        lesterspawn(i)
    end
end

send_boobs = function(feat)
    local amount = tonumber(feat.value_i)
    for i = 1, amount do
        boobsspawn(i)
    end
end

boobsspawn = function()
    local pedp = player.get_player_ped(pid)
    local model = 2633130371
    local parachute = 0xfbab5776
    local pos = player.get_player_coords(pid)
    local offset = v3()
	local rot = v3()
	local hed = player.get_player_heading(pid)
    local offset_z = math.random(40, 200)
    local headtype = math.random(0, 3)
    offset.z = offset_z
    pos.x = pos.x + 10
    pos.y = pos.y + 20

    streaming.request_model(model)

    while not streaming.has_model_loaded(model) do
        return HANDLER_CONTINUE
        --  system.wait(0)
    end
    local i = #boobs + 1
	rot = entity.get_entity_rotation(player.get_player_ped(pedp))
    boobs[i] = ped.create_ped(5, model, pos + offset, 0, true, false)
	entity.set_entity_god_mode(boobs[i], true)
	ui.add_blip_for_entity(boobs[i])
	ped.set_ped_component_variation(boobs[i], 0, headtype, 0, 0)
    ped.set_ped_component_variation(boobs[i], 2, 0, 0, 0)
    ped.set_ped_component_variation(boobs[i], 3, 1, 0, 0)
    ped.set_ped_component_variation(boobs[i], 4, 1, 0, 0)
    ped.set_ped_component_variation(boobs[i], 8, 1, 0, 0)

    ped.set_ped_can_switch_weapons(boobs[i], true)
    ped.set_ped_combat_attributes(boobs[i], 46, true)
    ped.set_ped_combat_attributes(boobs[i], 52, true)
    ped.set_ped_combat_attributes(boobs[i], 1, true)
    ped.set_ped_combat_attributes(boobs[i], 2, true)
    ped.set_ped_combat_range(boobs[i], 2)
    ped.set_ped_combat_ability(boobs[i], 2)
    ped.set_ped_combat_movement(boobs[i], 2)
	weapon.give_delayed_weapon_to_ped(boobs[i], parachute, 1, 0)
 
 
	pos = entity.get_entity_coords(player.get_player_ped(pid))
    ai.task_parachute_to_target(boobs[i], pos)
	


	streaming.set_model_as_no_longer_needed(model)
end

boobs_task = function(feat)
    local pedp = player.get_player_ped(pid)
    for i = 1, #boobs do
        -- ped.set_ped_as_group_member(boobs[i], myplygrp)
        -- ped.set_ped_relationship_group_hash(boobs[i], 4208871491)
        weapon.give_delayed_weapon_to_ped(boobs[i], wpnsel, 1, 1)
        ai.task_combat_ped(boobs[i], pedp, 0, 16)
    end
    --return HANDLER_CONTINUE
end

del_boobs = function(feat)
    for i = 1, #boobs do
        entity.set_entity_as_no_longer_needed(boobs[i])
        entity.delete_entity(boobs[i])
    end
end

send_boobs = function(feat)
    local amount = tonumber(feat.value_i)
    for i = 1, amount do
        boobsspawn(i)
    end
end

--killerwhale   local hash = 0x8D8AC8B9

atkgodped = function(feat)

	local pedd = player.get_player_ped(pid)
	local pos = v3()
	local rot = v3()
	local offset = v3()



rot, pos = ped.get_ped_bone_coords(pedd, 63931, offset)
ground, pos.z = gameplay.get_ground_z(pos)
	pos.x = pos.x + 5.0
	pos.y = pos.y + 5.0
	pos.z = pos.z + 1.2


	streaming.request_model(animal_model)

	if not streaming.has_model_loaded(animal_model) then
	return HANDLER_CONTINUE
	end

	local i = #animal + 1

	animal[i]= ped.create_ped(28, animal_model, pos, 0, true, false)
	entity.set_entity_god_mode(animal[i], true)
    ped.set_ped_can_switch_weapons(animal[i], true)	
	ui.add_blip_for_entity(animal[i])
    ped.set_ped_combat_attributes(animal[i], 46, true)
    ped.set_ped_combat_attributes(animal[i], 52, true)
    ped.set_ped_combat_attributes(animal[i], 1, true)
    ped.set_ped_combat_attributes(animal[i], 2, true)
    ped.set_ped_combat_range(animal[i], 2)
    ped.set_ped_combat_ability(animal[i], 2)
    ped.set_ped_combat_movement(animal[i], 2)
	weapon.give_delayed_weapon_to_ped(animal[i], wpnsel, 1, 1)
	ai.task_combat_ped(animal[i], pedd, 0, 16)

streaming.set_model_as_no_longer_needed(animal_model)	
end

attgodped = function(feat)
	
	local pedd = player.get_player_ped(pid)
	local pos = v3()
	local rot = v3()
	local offset = v3()
	
	offset.x = 0.0
	offset.y = 7.5
	offset.z = 0.0

	rot = entity.get_entity_rotation(pedd)
	
	for i = 1, #animal do
	network.request_control_of_entity(animal[i])
       entity.attach_entity_to_entity(animal[i], pedd, 1356, offset, rot, true, true, true, 0, false)
	   ai.task_combat_ped(animal[i], pedd, 0, 16)
	   end
end

del_animals = function(feat)
	local pedd = player.get_player_ped(pid)
    for i = 1, #animal do
	
	 entity.detach_entity(animal[i])
	 system.wait(10)
        entity.set_entity_as_no_longer_needed(animal[i])
        entity.delete_entity(animal[i])
    end
end

lesterspawn = function()
    local pedp = player.get_player_ped(pid)
    local model = gameplay.get_hash_key("ig_lestercrest_2")
    local parachute = 0xfbab5776
    local pos = player.get_player_coords(pid)
    local offset = v3()
    local offset_z = math.random(40, 200)
    offset.z = offset_z
    pos.x = pos.x + 10
    pos.y = pos.y + 20

    streaming.request_model(model)

    while not streaming.has_model_loaded(model) do
        return HANDLER_CONTINUE
        --  system.wait(0)
    end
    local i = #lester + 1
    lester[i] = ped.create_ped(5, model, pos + offset, 0, true, false)
    entity.set_entity_god_mode(lester[i], true)
	ui.add_blip_for_entity(lester[i])
    ped.set_ped_can_switch_weapons(lester[i], true)
    ped.set_ped_combat_attributes(lester[i], 46, true)
    ped.set_ped_combat_attributes(lester[i], 52, true)
    ped.set_ped_combat_attributes(lester[i], 1, true)
    ped.set_ped_combat_attributes(lester[i], 2, true)
    ped.set_ped_combat_range(lester[i], 2)
    ped.set_ped_combat_movement(lester[i], 2)
	    ped.set_ped_combat_ability(lester[i], 2)
	weapon.give_delayed_weapon_to_ped(lester[i], parachute, 1, 0)

    --   system.wait(0)

    ai.task_parachute_to_target(lester[i], pos)
end

lester_task = function(feat)
    local pedp = player.get_player_ped(pid)
    for i = 1, #lester do
        -- ped.set_ped_as_group_member(lester[i], myplygrp)
        -- ped.set_ped_relationship_group_hash(lester[i], 4208871491)
        weapon.give_delayed_weapon_to_ped(lester[i], 0x6D544C99, 1, 1)
        ai.task_combat_ped(lester[i], pedp, 0, 16)
    end
    --return HANDLER_CONTINUE
end

att_lester_attk1 = function(feat)
	if feat.on then
	
	local pedd = player.get_player_ped(pid)
	local pos = v3()
	local rot = v3()
	local offset = v3()
	offset.x = 0.0
	offset.y = 0.0
	offset.z = 0.0

	rot = entity.get_entity_rotation(pedd)
	
	for i = 1, #lester do
	network.request_control_of_entity(lester[i])
       entity.attach_entity_to_entity(lester[i], pedd, 1356, offset, rot, true, true, true, 0, false)
	   ai.task_combat_ped(lester[i], pedd, 0, 16)
	   end
return HANDLER_CONTINUE
end
if feat.on == false
then
	for i = 1, #lester do
	entity.detach_entity(lester[i])

end
return HANDLER_CONTINUE

end
end
	
att_lesveh_attk1 = function(feat)
	  if feat.on  then
	local pedd = player.get_player_ped(pid)
	local pos = v3()
	local rot = v3()
	local offset = v3()

	
	offset.x = 0.0
	offset.y = 0.0
	offset.z = 0.0

	rot = entity.get_entity_rotation(pedd)
	
	for i = 1, #lesveh do
	network.request_control_of_entity(lesveh[i])
       entity.attach_entity_to_entity(lesveh[i], pedd, 1356, offset, rot, true, true, true, 0, false)
	   end
	   if feat.on then
	   	for i = 1, #lester do
	   ai.task_combat_ped(lester[i], pedd, 0, 16)
	   end
	end	   

	   return HANDLER_CONTINUE
end
	  if feat.on == false
	  then
	for i = 1, #lesveh do
 
 entity.detach_entity(lesveh[i])	


end
return HANDLER_CONTINUE

end
end

att_boobs_attk = function(feat)
	
	local pedd = player.get_player_ped(pid)
	local pos = v3()
	local rot = v3()
	local offset = v3()
	
	offset.x = 0.0
	offset.y = 7.5
	offset.z = 0.0

	rot = entity.get_entity_rotation(pedd)
	
	for i = 1, #boobs do
	network.request_control_of_entity(boobs[i])
       entity.attach_entity_to_entity(boobs[i], pedd, 1356, offset, rot, true, true, true, 0, false)
	   ai.task_combat_ped(boobs[i], pedd, 0, 16)
	   if feat.on then
	   ai.task_combat_ped(boobs[i], pedd, 0, 16)
	   end
	   return HANDLER_CONTINUE
	   end
end


del_lester = function(feat)
    for i = 1, #lester do
		ped.clear_ped_tasks_immediately(lester[i])
		entity.detach_entity(lester[i])
				
        entity.set_entity_as_no_longer_needed(lester[i])
        entity.delete_entity(lester[i])
		end
		for i = 1, #lesveh do
		entity.detach_entity(lesveh[i])
		entity.set_entity_as_no_longer_needed(lesveh[i])
        entity.delete_entity(lesveh[i])
    end
end

changemodel = function(hash)

animal_model = hash
end

function main()

    local moist = menu.add_feature("Moists Attack Script", "parent", 0)

    local playerseid = menu.add_feature("Select Player ID:", "action_value_i", moist.id, playersid)
    playerseid.threaded = false
    playerseid.max_i = 32
    playerseid.min_i = -1
    playerseid.value_i = -1

    local lesatk = menu.add_feature("Lester Attacker", "parent", moist.id, cb)
	--local animalattk = menu.add_feature("Send Animal Attacker", "parent", moist.id, cb)
    local boob = menu.add_feature("Boobs Attacker", "parent", moist.id, cb)
	local apcv = menu.add_feature("Send in Vehicle", "parent", lesatk.id, cb)
	--local Animal_Sel = menu.add_feature("Select Animal to Send", "parent", animalattk.id)		
	local apcatk = menu.add_feature("Send 2x Lester in APC Attack", "action", apcv.id, function(feat)
		apc_lester(true)
	end)
	apcatk.threaded = false
	
--	local animatk = menu.add_feature("Send Animal Attacker", "action", animalattk.id, atkgodped)
--	animatk.threaded = false
--		local animatk = menu.add_feature("Send Animal Attacker", "action", Animal_Sel.id, atkgodped)
--	animatk.threaded = false
	
--	local killer_att = menu.add_feature("Attach all Spawned Animals to Player", "action", animalattk.id, attgodped)
--	killer_att.threaded = false
	
--	local killer_del = menu.add_feature("Delete Sent Animal Attackers", "action", animalattk.id, del_animals)
--	killer_del.threaded = true
	
	local attlesatkk = menu.add_feature("Attach all Lesters offset2 Player", "toggle", lesatk.id, att_lester_attk)
	attlesatkk.threaded = true
	
	local attvehatkk = menu.add_feature("Attach Vehicle Attackers offset2 Player", "toggle", apcv.id, att_lesveh_attk)
	attvehatkk.threaded = true
	
	local attlesatkk = menu.add_feature("Attach Lesters inside Player", "toggle", lesatk.id, att_lester_attk1)
	attlesatkk.threaded = true
	
	local attvehatkk = menu.add_feature("Attach VehicleAttackers insidePlayer", "toggle", apcv.id, att_lesveh_attk1)
	attvehatkk.threaded = true

	local apcwan = menu.add_feature("Send 2x Lester in APC Wander Streets", "action", apcv.id, function(feat)
		apc_lester(false)
	end)
	apcwan.threaded = false

	
	local op2atk = menu.add_feature("Send Lester on Oppressor MK2 Attack", "action", apcv.id, function(feat)
		op_lester(true, 2, 1, 10)
	end)
	op2atk.threaded = false
	
	local opatk = menu.add_feature("Send Lester on Oppressor Attack", "action", apcv.id, function(feat)
		op_lester(true, 1, 0, 0)
	end)
	opatk.threaded = false

	local opwan = menu.add_feature("Send Lester on Oppressor Wander Streets", "action", apcv.id, function(feat)
		op_lester(false,  1, 0, 0)
	end)
	opwan.threaded = false

    local boobswpnset = menu.add_feature("set Weapon 1:Bat 2:Railgun", "action_value_i", moist.id, set_boobs_weapon)
    boobswpnset.max_i = 2
    boobswpnset.min_i = 1
    boobswpnset.value_i = 1

    local boobs_para = menu.add_feature("Send boobs Parachuting tasked", "action", boob.id, send_boobs_para)

    local boobretask = menu.add_feature("task boobs to Attack", "action", boob.id, boobs_task)
    boobretask.threaded = false

    local boobs_para01 = menu.add_feature("Send 1-20x boobs(s) no task", "action_value_i", boob.id, send_boobs)
    boobs_para01.threaded = false
    boobs_para01.min_i = 1
    boobs_para01.max_i = 20
    boobs_para01.value_i = 1

    local delete = menu.add_feature("delete Spawned boobss", "action", boob.id, del_boobs)
    delete.threaded = false

    local lester_para = menu.add_feature("Send Lester Parachuting tasked", "action", lesatk.id, send_lester_para)

    local retask = menu.add_feature("task Lester to Attack", "action", lesatk.id, lester_task)
    retask.threaded = false

    local lester_para01 = menu.add_feature("Send 1-20x Lesters no task", "action_value_i", lesatk.id, send_lester)
    lester_para01.threaded = false
    lester_para01.min_i = 1
    lester_para01.max_i = 20
    lester_para01.value_i = 1

    local delete = menu.add_feature("delete Spawned Lesters + Vehicles", "action", lesatk.id, del_lester)
    delete.threaded = false
	

			-- An_Sel_Ground = menu.add_feature("Ground Animals", "parent", Animal_Sel.id)
			-- menu.add_feature("Bigfoot", "action", An_Sel_Ground.id, function () changemodel(0x61D4C771) end)
			-- menu.add_feature("Bigfoot 2", "action", An_Sel_Ground.id, function () changemodel(0xAD340F5A) end)
			-- menu.add_feature("Boar", "action", An_Sel_Ground.id, function () changemodel(0xCE5FF074) end)
			-- menu.add_feature("Cat", "action", An_Sel_Ground.id, function () changemodel(0x573201B8) end)
			-- menu.add_feature("Chimp", "action", An_Sel_Ground.id, function () changemodel(0xA8683715) end)
			-- menu.add_feature("Chop", "action", An_Sel_Ground.id, function () changemodel(0x14EC17EA) end)
			-- menu.add_feature("Cow", "action", An_Sel_Ground.id, function () changemodel(0xFCFA9E1E) end)
			-- menu.add_feature("Coyote", "action", An_Sel_Ground.id, function () changemodel(0x644AC75E) end)
			-- menu.add_feature("Deer", "action", An_Sel_Ground.id, function () changemodel(0xD86B5A95) end)
			-- menu.add_feature("German Shepherd", "action", An_Sel_Ground.id, function () changemodel(0x431FC24C) end)
			-- menu.add_feature("Hen", "action", An_Sel_Ground.id, function () changemodel(0x6AF51FAF) end)
			-- menu.add_feature("Husky", "action", An_Sel_Ground.id, function () changemodel(0x4E8F95A2) end)
			-- menu.add_feature("Mountain Lion", "action", An_Sel_Ground.id, function () changemodel(0x1250D7BA) end)
			-- menu.add_feature("Pig", "action", An_Sel_Ground.id, function () changemodel(0xB11BAB56) end)
			-- menu.add_feature("Poodle", "action", An_Sel_Ground.id, function () changemodel(0x431D501C) end)
			-- menu.add_feature("Pug", "action", An_Sel_Ground.id, function () changemodel(0x6D362854) end)
			-- menu.add_feature("Rabbit", "action", An_Sel_Ground.id, function () changemodel(0xDFB55C81) end)
			-- menu.add_feature("Rat", "action", An_Sel_Ground.id, function () changemodel(0xC3B52966) end)
			-- menu.add_feature("Golden Retriever", "action", An_Sel_Ground.id, function () changemodel(0x349F33E1) end)
			-- menu.add_feature("Rhesus", "action", An_Sel_Ground.id, function () changemodel(0xC2D06F53) end)
			-- menu.add_feature("Rottweiler", "action", An_Sel_Ground.id, function () changemodel(0x9563221D) end)
			-- menu.add_feature("Westy", "action", An_Sel_Ground.id, function () changemodel(0xAD7844BB) end)
		-- An_Sel_Water = menu.add_feature("Water Animals", "parent", Animal_Sel.id, function () end)
			-- menu.add_feature("Dolphin", "action", An_Sel_Water.id, function () changemodel(0x8BBAB455) end)
			-- menu.add_feature("Fish", "action", An_Sel_Water.id, function () changemodel(0x2FD800B7) end)
			-- menu.add_feature("Hammershark",	"action", An_Sel_Water.id, function () changemodel(0x3C831724) end)
			-- menu.add_feature("Humpback", "action", An_Sel_Water.id, function () changemodel(0x471BE4B2) end)
			-- menu.add_feature("Killerwhale",	"action", An_Sel_Water.id, function () changemodel(0x8D8AC8B9) end)
			-- menu.add_feature("Shark", "action", An_Sel_Water.id, function () changemodel(0x06C3F072) end)
			-- menu.add_feature("Stingray", "action", An_Sel_Water.id, function () changemodel(0xA148614D) end)
		-- An_Sel_Fly = menu.add_feature("Flying Animals", "parent", Animal_Sel.id)
			-- menu.add_feature("Cormorant", "action", An_Sel_Fly.id, function () changemodel(0x56E29962) end)
			-- menu.add_feature("Chickenhawk", "action", An_Sel_Fly.id, function () changemodel(0xAAB71F62) end)
			-- menu.add_feature("Crow", "action", An_Sel_Fly.id, function () changemodel(0x18012A9F) end)
			-- menu.add_feature("Pigeon", "action", An_Sel_Fly.id, function () changemodel(0x06A20728) end)
			-- menu.add_feature("Seagull", "action", An_Sel_Fly.id, function () changemodel(0xD3939DFD) end)
end
main()
