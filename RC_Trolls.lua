Objs = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10"
}

function seater(count, id, hash)
	for u=1, count do
		local pos = player.get_player_coords(id)
		streaming.request_model(gameplay.get_hash_key(hash))
		cars[u] = vehicle.create_vehicle(gameplay.get_hash_key(hash), v3(pos.x + math.random(0, 15), pos.y + math.random(0, 15), pos.z), pos.z, true, false)
		streaming.request_model(0x92991B72)
		drivers[u] = ped.create_ped(26, 0x92991B72, v3(pos.x + 7, pos.y, pos.z), pos.z, true, false)
		ped.set_ped_into_vehicle(drivers[u], cars[u], -1)
		menu.notify("RC Toy Spawned", "Stand", 5, 2)
		ai.task_vehicle_chase(drivers[u], player.get_player_ped(id))
		ai.task_vehicle_follow(drivers[u], cars[u], player.get_player_ped(id), 50.0, 0, 1)
		menu.notify("RC Toy Chasing", "Stand", 5, 2)
		system.wait(500)
	end
	return cars, drivers
end


menu.add_player_feature("Send RC Tanks: ", "action_value_str", 0, function(val, pid)
	local num = Objs[val.value+1]
	cars = {}
	drivers = {}
	seater(num, pid, "minitank")	
	for i = 1, #cars do
		while ped.get_ped_health(player.get_player_ped(pid)) > 0 do
			system.wait(500)
			local pos1 = player.get_player_coords(pid)
			local poss = v3(pos1.x + 20, pos1.y + 20, pos1.z + 50)
			local bpos = entity.get_entity_coords(cars[i])
			if (bpos.x <= poss.x) and (bpos.y <= poss.y) and (bpos.z <= poss.z)  or (bpos.x >= poss.x) and (bpos.y >= poss.y) and (bpos.z >= poss.z)then
				ai.task_vehicle_shoot_at_ped(drivers[i], player.get_player_ped(pid), 100.0)

			end
		end
		system.wait(1000)
		entity.delete_entity(drivers[i])
		entity.delete_entity(cars[i])
	end
end):set_str_data(Objs)

blamed = player.player_id()

menu.add_player_feature("Send RC Banditos: ", "action_value_str", 0, function(val, pid)
	local num = Objs[val.value+1]
	local boomed = 0
	cars = {}
	drivers = {}
	seater(num, pid, "rcbandito")	
	while boomed < #cars do
		for i = 1, #cars do
			system.wait(500)
			local pos1 = player.get_player_coords(pid)
			local poss = v3(pos1.x + 3, pos1.y + 3, pos1.z + 5)
			local bpos = entity.get_entity_coords(cars[i])
			if (bpos.x <= poss.x) and (bpos.y <= poss.y) and (bpos.z <= poss.z)  or (bpos.x >= poss.x) and (bpos.y >= poss.y) and (bpos.z >= poss.z)then
				fire.add_explosion(bpos, 0, true, false, 2.0, player.get_player_ped(pid))
				menu.notify("Bandito Exploding", "Stand", 5, 2)
				entity.delete_entity(drivers[i])
				entity.delete_entity(cars[i])
				boomed = boomed + 1
			end
		end
	end
end):set_str_data(Objs)

menu.add_player_feature("Send RC Banditos Blamed: ", "action_value_str", 0, function(val, pid)
	local num = Objs[val.value+1]
	local boomed = 0
	cars = {}
	drivers = {}
	seater(num, pid, "rcbandito")	
	while boomed < #cars do
		for i = 1, #cars do
			system.wait(500)
			local pos1 = player.get_player_coords(pid)
			local poss = v3(pos1.x + 3, pos1.y + 3, pos1.z + 5)
			local bpos = entity.get_entity_coords(cars[i])
			if (bpos.x <= poss.x) and (bpos.y <= poss.y) and (bpos.z <= poss.z)  or (bpos.x >= poss.x) and (bpos.y >= poss.y) and (bpos.z >= poss.z)then
				fire.add_explosion(bpos, 0, true, false, 2.0, player.get_player_ped(blamed))
				menu.notify("Bandito Exploding", "Stand", 5, 2)
				entity.delete_entity(drivers[i])
				entity.delete_entity(cars[i])
				boomed = boomed + 1
			end
		end
	end
end):set_str_data(Objs)