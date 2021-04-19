local rootPath = os.getenv("APPDATA") .. "\\PopstarDevs\\2Take1Menu"
local file = rootPath.."\\lualogs\\Moists_debug.log"
local beyond_limits = v3()
beyond_limits.x = -173663.281250
beyond_limits.y = 915722.000000
beyond_limits.z = 362299.750000

local boobs = {}
local boobveh = {}
local groupIDs = {}
local myplygrp
local plygrp
local drvsty = 262275
local plyveh = player.get_player_vehicle(player.player_id())
local player_seat = 0
local sel_ped
local sel_veh
local ped_count
local escort_style
local goto_pos = v3()
local offsetPos = v3()
local presets = {
	{"Chiliad", 491.176,5529.808,777.503},
	{"Lesters House", 1275.544,-1721.774,53.967},
	{"arena", -264.297,-1877.562,27.756},
	{"ElysianIslandBridge", -260.923,-2414.139,124.008},
	{"LSIAFlightTower", -983.292,-2636.995,89.524},
	{"TerminalCargoShip", 983.303,-2881.645,21.619},
	{"ElBurroHeights", 1583.022,-2243.034,93.265},
	{"CypressFlats", 552.672,-2218.876,68.981},
	{"LaMesa", 1116.815,-1539.787,52.146},
	{"SupplyStreet", 777.631,-695.813,28.763},
	{"Noose", 2438.874,-384.409,92.993},
	{"TatavianMountains", 2576.999,445.654,108.456},
	{"PowerStation", 2737.046,1526.873,57.494},
	{"WindFarm", 2099.765,1766.219,102.698},
	{"Prison", 1693.473,2652.971,61.335},
	{"SandyShoresRadioTower", 1847.034,3772.019,33.151},
	{"AlamoSea", 719.878,4100.993,39.154},
	{"RebelRadioTower", 744.500,2644.334,44.400},
	{"GreatChaparral", -291.035,2835.124,55.530},
	{"ZancudoControlTower", -2361.625,3244.962,97.876},
	{"NorthChumash(Hookies)", -2205.838,4298.805,48.270},
	{"AltruistCampRadioTower", -1036.141,4832.858,251.595},
	{"CassidyCreek", -509.942,4425.454,89.828},
	{"MountChiliad", 462.795,5602.036,781.400},
	{"PaletoBayFactory", -125.284,6204.561,40.164},
	{"GreatOceanHwyCafe", 1576.385,6440.662,24.654},
	{"MountGordoRadioTower", 2784.536,5994.213,354.275},
	{"MountGordoLighthouse", 3285.519,5153.820,18.527},
	{"GrapeSeedWaterTower", 1747.518,4814.711,41.666},
	{"TatavianMountainsDam", 1625.209,-76.936,166.651},
	{"VinewoodHillsTheater", 671.748,512.226,133.446},
	{"VinewoodSignRadioTowerTop", 751.179,1245.13,353.832},
	{"Hawik", 472.588,-96.376,123.705},
	{"PacificSrandardBank", 195.464,224.341,143.946},
	{"WestVinewoodCrane", -690.273,219.728,137.518},
	{"ArcadiasRadioTower", -170.232,-586.307,200.138},
	{"HookahPalaceSign",-1.414,-1008.324,89.189},
	{"MarinaAirportRadioTower",-697.010, -1419.530,5.001},
	{"DelperoFerrisWheel", -1644.193,-1114.271,13.029},
	{"VespucciCanalsClockTower", -1238.729,-853.861,77.758},
	{"DelPeroNrMazebankwest", -1310.777,-428.985,103.465},
	{"pacifficBluffs", -2254.199,326.088,192.606},
	{"GWC&GolfingSociety", -1292.052,286.209,69.407},
	{"Burton", -545.979,-196.251,84.733},
	{"LosSantosMedicalCenter", 431.907,-1348.709,44.673},
	{"BanhamCanyon", -3085.451,774.426,20.237},
	{"TongvaHills", -1874.280,2064.565,150.852},
	{"SanChianskiMountainRange", 2900.166,4325.987,102.101},
	{"HumaineLabs", 3537.104,3689.238,45.228},
	{"YouToolStoreSanChianski", 2761.944,3466.951,55.679},
	{"GalileoObservatory", -422.917,1133.272,325.855},
	{"GrndSeroraDesertCementwks", 1236.649,1869.214,84.824}
}

local pedweapon = {
	{"WEAPON_UNARMED", 0xA2719263},
	{"bat", 0x958A4A8F},
	{"WEAPON_HANDCUFFS", 0xD04C944D},
	{"WEAPON_RAILGUN", 0x6D544C99},
	{"WEAPON_MACHINEPISTOL", 0xDB1AA450},
	{"WEAPON_KNIFE", 0x99B507EA},
}

local escort_mode = {
{"behind", -1},
{"ahead", 0},
{"left", 1},
{"right", 2},
{"back left", 3},
{"back right", 4},
}
local selected_weapon
local driving_style = {0,1,4,16,131,139,1076,7785,7791,262144,262208,262275,525116,524348,786468,786469,786475,786484,786485,786491,786597,786599,786603,786613,786619,786859,786981,790699,794660,2883621,2883755,17039360,17563684,34340900,537657381,537657515,1074272427,1074528293,1076369579,1076631588,1090781748,8388614}

local peds_2spawn = {"a_f_y_topless_01","ig_lestercrest_2","ig_trafficwarden","mp_f_deadhooker","s_m_m_pilot_01","s_m_m_pilot_02","s_m_y_pilot_01","s_m_y_robber_01","u_m_m_jewelthief","u_m_y_fibmugger_01","a_f_y_juggalo_01","mp_g_m_pros_01",}
local veh_2spawn = {"boxville5","limo2","insurgent","scramjet","Oppressor","monster5","phantom2","mower","tampa3","ruiner2","ruiner3","caddy","caddy2","caddy3","bus","apc","buzzard"}




local parent = menu.add_feature("Moists Escort Service", "parent", 0, function(feat)
	-- players_pos()
end)

local escortserv = menu.add_feature("Select Your Escort", "parent", parent.id, cb)
local escortwith = menu.add_feature("Select Escort Vehicle", "parent", parent.id, cb)
local sel_mode = menu.add_feature("Style/Position", "parent", parent.id, cb)

local driver = menu.add_feature("Escort as Driver", "parent", parent.id)
local player_pos = menu.add_feature("set POS to Player ID:", "action_value_i", driver.id, goto_player)
player_pos.threaded = false
 player_pos.max_i = 32
 player_pos.min_i = -1
 player_pos.value_i = -1


local drive2 = menu.add_feature("Location Presets", "parent", driver.id)
local pedwep = menu.add_feature("Select Escorts Weapon", "parent", parent.id)


local set_drstyle = menu.add_feature("set driving style", "action_value_i", driver.id, function(feat)
	drvsty = tonumber(style_driver(feat.value_i))
end)
set_drstyle.max_i = #driving_style
set_drstyle.min_i = 1
set_drstyle.value_i = 36

local boobped = menu.add_feature("Create Escort Ped", "action", parent.id, function(feat)
	escort_ped()
end)

local vehiclepedescort = menu.add_feature("Create Veh set Escort(s) inside", "action", parent.id, function(feat)
	veh_escort()
end)

local vehiclepedescort = menu.add_feature("task escort to follow", "action", parent.id, function(feat)
	local plyveh = player.get_player_vehicle(player.player_id())
	local i = #boobveh
	local y = #boobs
	ai.task_vehicle_follow(boobs[y],boobveh[i], plyveh, 250.00, 262275, 150)
end)


local ply_seat = menu.add_feature("Set your seat (default front)", "action_value_i", driver.id, function(feat)
	if player.is_player_in_any_vehicle(player.player_id()) then
		local pped = player.get_player_ped(player.player_id())
		local i = #boobveh
		ped.set_ped_into_vehicle(pped, boobveh[i], feat.value_i)
		player_seat = feat.value_i
	end
end)
ply_seat.max_i = 14
ply_seat.min_i = -1
ply_seat.value_i = 0

local setwanderdrive = menu.add_feature("Task Escort Drive around(Wander randomly)", "action", driver.id, function(feat)
	set_wander()
end)


local setdrivepos = menu.add_feature("Set/Update Task Drive to POS", "action", driver.id, function(feat)
	set_drive_2pos()
end)

local Clipboard_POS =  menu.add_feature("Task Drive To Clipboard POS (0,0,0)", "action", driver.id, function(feat)
	
	local pos = v3()
	
	local pos_data = utils.from_clipboard()
	
	local x, y, z = string.match(pos_data, "([+-]?%d+.%d*), ([+-]?%d+.%d*), ([+-]?%d+.%d*)")
	pos.x = tonumber(x)
	pos.y = tonumber(y)
	pos.z = tonumber(z)
	goto_pos.x = pos.x
	goto_pos.y = pos.y
	goto_pos.z = pos.z
	
end)


local setescortloop = menu.add_feature("Loop Ped Grouping", "toggle", parent.id, function(feat)
	if feat.on then
		ped_escort_loop()
		return HANDLER_CONTINUE
	end
	return HANDLER_POP
end)
setescortloop.on = false


local del_spawns = menu.add_feature("Delete Escorts & Vehicles", "action", parent.id, function(feat)
	delete_escorts()
	system.wait(10)
	delete_vehicles()
end)

function debug_out(text)
	local dateout = os.date()
	local file = io.open(rootPath.."\\lualogs\\Moists_debug.log", "a")
	io.output(file)
	io.write("\n["..dateout.."]\n"..text)
    io.close()
	
end


for i = 1, #escort_mode do
	menu.add_feature("Position: " .. escort_mode[i][1], "action", sel_mode.id, function(feat)
			mode = escort_mode[i][2]
	end)
end

for i = 1, #presets do
	menu.add_feature("Preset: " .. presets[i][1], "action", drive2.id, function(feat)
		goto_pos.x = presets[i][2]
		goto_pos.y = presets[i][3]
		goto_pos.z = presets[i][4]
		print(presets[i][2])
		print(presets[i][3])
		print(presets[i][4])
		
	end)
end

for i = 1, #pedweapon do
	menu.add_feature("Weapon: " .. pedweapon[i][1], "action", pedwep.id, function(feat)
		selected_weapon = gameplay.get_hash_key(pedweapon[i][1])	
	end)
end


for i = 1, #peds_2spawn do
	menu.add_feature("Ped: " .. peds_2spawn[i], "action", escortserv.id, function(feat)
		sel_ped = gameplay.get_hash_key(peds_2spawn[i])	
	end)
end

for i = 1, #veh_2spawn do
	menu.add_feature("Veh: " .. veh_2spawn[i], "action", escortwith.id, function(feat)
		ped_count = 1
		sel_veh = gameplay.get_hash_key(veh_2spawn[i])
			if sel_veh == gameplay.get_hash_key("apc") then
				ped_count = 2
				secped_seat = 0
			end
			
			if sel_veh == gameplay.get_hash_key("boxville5") or gameplay.get_hash_key("limo2") or gameplay.get_hash_key("insurgent") then
				ped_count = 2
				secped_seat = 7
			end
	end)
end

function playersid()
	escort_style = driving_style[36]
	selected_weapon = gameplay.get_hash_key(pedweapon[1][1])	
	sel_ped = gameplay.get_hash_key("a_f_y_topless_01")
	sel_veh = gameplay.get_hash_key("tampa3")
	ped_count = 1
	secped_seat = 0
	player_seat = 0
	myplygrp =  player.get_player_group(player.player_id())
	ui.notify_above_map("Moists Escort Service initialized:\nDeaults Set: Escort: a_f_y_topless_01\nVehicle: tampa3", "Moists Escort Service", 212)	
	local i = #groupIDs + 1
	groupIDs[i] = ped.create_group()
	
	local y = #groupIDs + 1	
	groupIDs[y] = ped.create_group()	
	ped.set_relationship_between_groups(0, groupIDs[i], groupIDs[y])
	ped.set_relationship_between_groups(0, groupIDs[y], groupIDs[i])
	
	for x = 1, #groupIDs do
		myplygrp = player.get_player_group(player.player_id())
		ped.set_relationship_between_groups(1, groupIDs[x], myplygrp)
		ped.set_relationship_between_groups(1, myplygrp, groupIDs[x])
	end
	local me
	me = player.player_id()
	for z = 0, 32 do
		if z ~= me then
		end
		local player_groups = player.get_player_group(z)	
		local y = #groupIDs
		
		
		for i = 1, #boobs do
			ped.set_ped_as_group_member(boobs[i], groupIDs[y])
			ped.set_ped_never_leaves_group(boobs[i], true)
			ped.set_relationship_between_groups(1, groupIDs[y], myplygrp)
			ped.set_relationship_between_groups(5, player_groups, myplygrp)
			ped.set_relationship_between_groups(1, myplygrp, groupIDs[y])
			ped.set_relationship_between_groups(5, myplygrp, player_groups)
		end
	end
	return HANDLER_POP
	
end
playersid()


function ped_escort_loop()
	if feat.on then
		local me
		me = player.player_id()
		for x = 0, 32 do
			if x ~= me then
			end
			
			local y = #groupIDs
			
			
			for i = 1, #boobs do
				ped.set_ped_as_group_member(boobs[i], groupIDs[y])
				ped.set_ped_never_leaves_group(boobs[i], true)
				ped.set_relationship_between_groups(1, groupIDs[y], myplygrp)
				ped.set_relationship_between_groups(5, player.get_player_group(i), myplygrp)
				ped.set_relationship_between_groups(1, myplygrp, groupIDs[y])
				ped.set_relationship_between_groups(5, myplygrp, player.get_player_group(x))
			end
		end
		return HANDLER_CONTINUE
	end
end

function ped_escort(feat)
	local mode = feat.value_i
	local i = #boobs
	local y = #boobveh
	if #boobveh == nil then
		ui.notify_above_map("Escort Vehicle:\nMust Be Selected\n Then Spawned Before Task can be set!!!", "Moists Escort Service", 212)
		end
	if plyveh == nil then ui.notify_above_map("Your Vehicle:\nYou need to be in a vehicle\nBefore Task can be set!!!", 212) end
	ai.task_vehicle_escort(boobs[i], boobveh[y], plyveh, mode, 2200.00, 262144, 2.0, -1, 5.0)
	for i = 1, #boobs do
		ped.set_ped_as_group_member(boobs[i], myplygrp)
		pedgroup = ped.get_ped_group(boobs[i])
		ped.set_ped_never_leaves_group(boobs[i], true)
	end
end

function escort_ped()
	
	--if feat.on then
	local pedp = player.get_player_ped(player.player_id())
    local model = sel_ped
    local pos = player.get_player_coords(player.player_id())
    local offset = v3()
	local rot = v3()
	local hed = player.get_player_heading(player.player_id())
    local headtype = math.random(0, 2)
    pos.x = pos.x + 10
    pos.y = pos.y + 10
	get_offset()
    streaming.request_model(model)
	
    while not streaming.has_model_loaded(model) do
		
		system.wait(0)
	end
    local i = #boobs + 1
	rot = entity.get_entity_rotation(player.get_player_ped(pedp))
    boobs[i] = ped.create_ped(26, model, pos + offset, 0, true, false)
	print(boobs[i])		
	entity.set_entity_god_mode(boobs[i], true)
	ui.add_blip_for_entity(boobs[i])
	ped.set_ped_component_variation(boobs[i], 0, 1, 0, 0)
    ped.set_ped_component_variation(boobs[i], 2, 0, 0, 0)
    ped.set_ped_component_variation(boobs[i], 3, 1, 0, 0)
    ped.set_ped_component_variation(boobs[i], 4, 1, 0, 0)
    ped.set_ped_component_variation(boobs[i], 0, 2, 2, 0)
	ped.set_ped_component_variation(boobs[i], 8, 1, 0, 0)
	
    ped.set_ped_can_switch_weapons(boobs[i], true)
    ped.set_ped_combat_attributes(boobs[i], 46, true)
    ped.set_ped_combat_attributes(boobs[i], 52, true)
    ped.set_ped_combat_attributes(boobs[i], 1, true)
    ped.set_ped_combat_attributes(boobs[i], 2, true)
    ped.set_ped_combat_range(boobs[i], 2)
    ped.set_ped_combat_ability(boobs[i], 2)
    ped.set_ped_combat_movement(boobs[i], 2)
	weapon.give_delayed_weapon_to_ped(boobs[i], selected_weapon, 0, 1)
	ped.set_ped_can_switch_weapons(boobs[i], true)
	
	local y = #groupIDs
	pedgroup = ped.get_ped_group(boobs[i])
	ui.notify_above_map("Ped Created spawned Group: "..pedgroup.."\nPlayer Group ID: "..myplygrp, "Ped Grouping", 212) 
	ped.set_ped_as_group_member(boobs[i], myplygrp)
	pedgroup = ped.get_ped_group(boobs[i])
	ped.set_ped_never_leaves_group(boobs[i], true)
	ui.notify_above_map("Ped Spawned Now Set into Group "..pedgroup.."\nPlayer Group ID: "..myplygrp, "Ped Grouping", 212)
end


local function OffsetCoords(pos, heading, distance)
    heading = math.rad((heading - 180) * -1)
    return v3(pos.x + (math.sin(heading) * -distance), pos.y + (math.cos(heading) * -distance), pos.z)
end

function get_offset()
	local pos = player.get_player_coords(player.player_id())
	print(string.format("%s, %s, %s", pos.x, pos.y, pos.z))
	offsetPos = OffsetCoords(pos, player.get_player_heading(player.player_id()), 10)
	print(string.format("%s, %s, %s", offsetPos.x, offsetPos.y, offsetPos.z))
end

function veh_escort()
	
    local vehhash = sel_veh
    local pos = player.get_player_coords(player.player_id())
	pos.x = pos.x + 10
	pos.y = pos.y + 10
    streaming.request_model(vehhash)
    while (not streaming.has_model_loaded(vehhash)) do
        return HANDLER_CONTINUE
	end
	get_offset()
    local y = #boobveh + 1
    boobveh[y] = vehicle.create_vehicle(vehhash, offsetPos, player.get_player_heading(player.player_id()), true, false)
	print(boobveh[y])
	vehicle.set_vehicle_mod_kit_type(boobveh[y], 0)
	vehicle.get_vehicle_mod(boobveh[y], 10)
	vehicle.set_vehicle_mod(boobveh[y], 10, 0, false)
	ui.add_blip_for_entity(boobveh[y])
    vehicle.set_vehicle_on_ground_properly(boobveh[y])
    entity.set_entity_god_mode(boobveh[y], true)
    vehicle.set_vehicle_doors_locked(boobveh[y], 5)
	
    network.request_control_of_entity(boobveh[y])
	local i = #boobs
    ped.set_ped_into_vehicle(boobs[i], boobveh[y], -1)
	
end


function goto_player(pid)
	goto_pos = player.get_player_coords(pid)
	
end

function coord_pos()
	goto_pos.x = -1236.220
	goto_pos.y = -2985.805
	goto_pos.z = -41.269
end

function set_drive_2pos()
	local i = #boobveh
	local ped_driver
	local y = #boobs
    ped.set_ped_into_vehicle(boobs[y], boobveh[i], -1)
	local pedp = player.get_player_ped(player.player_id())
    ped.set_ped_into_vehicle(pedp, boobveh[i], player_seat)		
	ai.task_vehicle_drive_to_coord(boobs[y], boobveh[i], goto_pos, 200.0, 1, sel_veh, drvsty, 10, -1)
	
end

function set_wander()
	local i = #boobveh
	
	local y = #boobs
    ped.set_ped_into_vehicle(boobs[y], boobveh[i], -1)
	local pedp = player.get_player_ped(player.player_id())
    ped.set_ped_into_vehicle(pedp, boobveh[i], player_seat)	
	ai.task_vehicle_drive_wander(boobs[y], boobveh[i], 180, escort_style)
end

function style_driver(id)
	escort_style = driving_style[id]
end

function delete_escorts()
	if #boobs > 0 then
		
		for i = 1, #boobs do
			network.request_control_of_entity(boobs[i])
			entity.set_entity_coords_no_offset(boobs[i], beyond_limits)
			ped.clear_ped_tasks_immediately(boobs[i])
			entity.detach_entity(boobs[i])
			entity.set_entity_as_no_longer_needed(boobs[i])
			entity.delete_entity(boobs[i])
		end
		else
	return end
	
	
	
end

function delete_vehicles()
	if #boobveh > 0 then
		
		for i = 1, #boobveh do
			if player.is_player_in_any_vehicle(player.player_id()) then
				if player.get_player_vehicle(player.player_id()) == boobveh[i] then
					ped.clear_ped_tasks_immediately(player.get_player_ped(player.player_id()))
					system.yield(25)
				end end
				network.request_control_of_entity(boobveh[i])
				entity.set_entity_coords_no_offset(boobveh[i], beyond_limits)
				entity.detach_entity(boobveh[i])
				entity.set_entity_as_no_longer_needed(boobveh[i])
				entity.delete_entity(boobveh[i])
				
		end
		else	
	return end 
end

