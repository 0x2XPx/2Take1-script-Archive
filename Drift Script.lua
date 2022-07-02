-- Flames#6666

 menu.notify("Welcome To Drift Script V1.4.0")

if DriftMod then
	ui.notify_above_map("Drift Script already loaded", "Drift Mod", 6)
	return
end

-- Local Main
LocalMain = menu.add_feature("Drift Script V1.4.0", "parent", 0).id
-- Parent Features
local neon = menu.add_feature("Neons", "parent", LocalMain)
local misc = menu.add_feature("Miscellaneous", "parent", LocalMain)
-- Things In The Parents
local kits = menu.add_feature("Neon Kits", "parent", neon.id)
local tele = menu.add_feature("Teleports", "parent", misc.id)
local disables = menu.add_feature("Disables", "parent", misc.id)
-----------------------------------------------------------------
menu.add_feature("Disable Mini-Map", "toggle", disables.id, function(f)
	if f.on then
		ui.hide_hud_and_radar_this_frame()
	end
	return HANDLER_CONTINUE
end)

menu.add_feature("Disable Cutscenes", "toggle", disables.id, function(f)
	if f.on then
		cutscene.is_cutscene_playing(cutscene.stop_cutscene_immediately())
	end
	return HANDLER_CONTINUE
end)
----------------------------------------------------------------
menu.add_feature("Vehicle Speed Multiplier", "action", misc.id, function()
    local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    local r, s = input.get("Enter a new Speed", "", 9999999, 3)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end
      
    speed = s
    if veh ~= nil then
      if not network.has_control_of_entity(veh) then
        network.request_control_of_entity(veh)  
      end 
      entity.set_entity_max_speed(veh,speed*1000)
      vehicle.modify_vehicle_top_speed(veh,speed)
      vehicle.set_vehicle_engine_torque_multiplier_this_frame(veh,speed)
      entity.get_entity_model_hash(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
    end
end)
----------------------------------------------------------------
menu.add_feature("No Entity Collision", "toggle", misc.id, function(f)
    if f.on then
		while f.on do
			system.wait(10)
			if player.is_player_in_any_vehicle(player.player_id()) then
				local peds = ped.get_all_peds()
				for i = 1, #peds do
					entity.set_entity_no_collsion_entity(peds[i], player.get_player_vehicle(player.player_id()), true)
					entity.set_entity_no_collsion_entity(player.get_player_vehicle(player.player_id()), peds[i], true)
				end
				local vehicles = vehicle.get_all_vehicles()
				for i = 1, #vehicles do
					entity.set_entity_no_collsion_entity(vehicles[i], player.get_player_vehicle(player.player_id()), true)
					entity.set_entity_no_collsion_entity(player.get_player_vehicle(player.player_id()), vehicles[i], true)
				end
				local objects = object.get_all_objects()
				for i = 1, #objects do
					entity.set_entity_no_collsion_entity(objects[i], player.get_player_vehicle(player.player_id()), true)
					entity.set_entity_no_collsion_entity(player.get_player_vehicle(player.player_id()), objects[i], true)
				end
			else
				local peds = ped.get_all_peds()
				for i = 1, #peds do
					entity.set_entity_no_collsion_entity(peds[i], player.get_player_ped(player.player_id()), true)
					entity.set_entity_no_collsion_entity(player.get_player_ped(player.player_id()), peds[i], true)
				end
				local vehicles = vehicle.get_all_vehicles()
				for i = 1, #vehicles do
					entity.set_entity_no_collsion_entity(vehicles[i], player.get_player_ped(player.player_id()), true)
					entity.set_entity_no_collsion_entity(player.get_player_ped(player.player_id()), vehicles[i], true)
				end
				local objects = object.get_all_objects()
				for i = 1, #objects do
					entity.set_entity_no_collsion_entity(objects[i], player.get_player_ped(player.player_id()), true)
					entity.set_entity_no_collsion_entity(player.get_player_ped(player.player_id()), objects[i], true)
				end
			end
		end
    end
end)
----------------------------------------------------------------
menu.add_feature("Teleport Up", "action", tele.id, function()
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
end)

menu.add_feature("Teleport Forward", "action", tele.id, function()
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
end)
----------------------------------
local all_vip_features = {
    "local.vehicle_options.infinite_countermeasures",
    "local.weapons.weapon_loadout",
    "online.all_players.force_reveal_otr_players",
    "online.all_players.dismiss_ceo",
    "online.all_players.kill_all_passive",
    "online.all_players.crash_all",
    "online.lobby.force_script_host",
    "online.lobby.mission_launcher",
    "online.lobby.host_options.name_spoof",
    "online.lobby.host_options.name_input",
    "online.lobby.host_options.scid_spoof_randomize",
    "online.lobby.host_options.ip_spoof",
    "online.lobby.host_options.ip_input",
    "online.lobby.host_options.host_token_counter_spoof",
    "online.lobby.matchmaking_region",
    "online.lobby.mass_player_interrupt",
    "online.services.remove_oppressor_mkii_cooldown",
    "online.services.remove_suicide_cooldown",
    "online.services.remove_passive_mode_cooldown",
    "online.services.remove_ceo_ban",
    "online.services.remove_ceo_work_cooldowns",
    "online.session_browser",
    "online.sc_browser",
    "online.player_spoofer.options.spoof_host_token",
    "online.player_spoofer.options.spoof_crew_tag",
    "online.player_spoofer.options.spoof_ip",
    "online.player_spoofer.options.spoof_r__dev",
    "online.player_spoofer.options.spoof_level",
    "online.player_spoofer.options.spoof_k_d",
    "online.player_spoofer.options.spoof_total_money",
    "online.player_spoofer.options.spoof_wallet_money",
    "online.join_redirect",
    "online.net_sync_spoof.player.model",
    "online.net_sync_spoof.player.model_input",
    "online.fake_friends.options.enable_stalker",
    "online.modder_detection.detect_session_mismatch",
    "online.business",
    "online.casino",
    "online.chat_commands"
}

menu.add_feature("Downgrade To Standard", "toggle", misc.id, function(f)
	for i = 1, #all_vip_features do
		if menu.get_feature_by_hierarchy_key(all_vip_features[i]) then
			menu.get_feature_by_hierarchy_key(all_vip_features[i]).hidden = f.on
		end
	end
end)

local wptpfunc = menu.get_feature_by_hierarchy_key("local.teleport.waypoint")
menu.add_feature("Auto TP Waypoint", "toggle", misc.id, function(f)
    while f.on do
        system.yield(50)
        if ui.get_waypoint_coord().x < 16000 then
            wptpfunc:toggle()
        end
    end
end)

----------------------------------- Rainbow Neon -----------------------------------
local function RainbowRGB(speed) 
    speed = speed * 0.25
    local result = {}
    local d = utils.time_ms() / 1000
    result.r = math.floor(math.sin(d*speed+0)*127+128)
    result.g = math.floor(math.sin(d*speed+2)*127+128)
    result.b = math.floor(math.sin(d*speed+4)*127+128)
    return ((result.r&255)<<0)|((result.g&255)<<8)|((result.b&255)<<0x10)|((255&255)<<24) -- returns RGB as Int
end

local rainbowneons = menu.add_feature("Rainbow Neons               Speed:", "value_i", neon.id, function(f)
    for i=0,4 do
        vehicle.set_vehicle_neon_light_enabled(player.get_player_vehicle(player.player_id()), i, true)
    end
    while f.on do
        if player.is_player_in_any_vehicle(player.player_id()) then
            vehicle.set_vehicle_neon_lights_color(player.get_player_vehicle(player.player_id()), RainbowRGB(f.value))
        end
        system.yield(0)
    end
    if not f.on then
        for i=0,4 do
            vehicle.set_vehicle_neon_light_enabled(player.get_player_vehicle(player.player_id()), i, false)
        end
        vehicle.set_vehicle_neon_lights_color(player.get_player_vehicle(player.player_id()), 0xFF000000)
    end
end)
rainbowneons.min = 1
rainbowneons.max = 10
rainbowneons.mod = 1
rainbowneons.value = 1
----------------------
-- Colour Set Neons
menu.add_feature("White", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 123129643123123)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Blue", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1000)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Electric Blue", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1000086)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Mint Green", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1238123)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Lime Green", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 290491924)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Yellow", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 191283128941589)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Golden Shower", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 905678460323858)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Orange", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 141234123456784)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Pony Pink", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 905848505689)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Purple", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 141234124)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Blacklight", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1500)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
menu.add_feature("Remove Neons", "action", neon.id, function(f)
    if f.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)
----------------------------------- DRIFT MOD (PS)
local gs_driftMinSpeed = 8.0
local gs_driftMaxAngle = 50.0
local gs_driftOppLock = 0.375
local ControlVehicleAccelerate = 71
local ControlVehicleBrake = 72
local ControlVehicleDuck = 73
local ControlVehicleSelectNextWeapon = 99
local ControlVehicleMoveUpOnly = 61

local function asDegrees(angle)
    return angle * (180.0 / 3.14159265357); 
end

local function wrap360(val) 
    --    return math.fmod(val + 360 + 360, 360)
    while (val < 0.0) do
        val = val + 360.0
    end
    while (val > 360.0) do
        val = val - 360.0
    end
    return val
end
local function getCurrentVehicle() 
	local player_id = player.player_id()
	local player_ped = player.get_player_ped(player_id)
    local player_vehicle = 0
    if (ped.is_ped_in_any_vehicle(player_ped)) then
        local veh = ped.get_vehicle_ped_is_using(player_ped)
        if (network.has_control_of_entity(veh)) then
            player_vehicle = veh
        end
    end
    return player_vehicle
end
local function getHeadingOfTravel(veh) 
    local velocity = entity.get_entity_velocity(veh)
    local x = velocity.x
    local y = velocity.y
    local at2 = math.atan(y, x)
    return math.fmod(270.0 + math.deg(at2), 360.0)
end
local function randomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end
local function RGBAToInt(R, G, B, A)
	A = A or 255
	return ((tonumber(R)&0x0ff)<<0x00)|((tonumber(G)&0x0ff)<<0x08)|((tonumber(B)&0x0ff)<<0x10)|((tonumber(A)&0x0ff)<<0x18)
end
local function slamDatBitch(veh, height) 
    if (vehicle.is_vehicle_on_all_wheels(veh) and not entity.is_entity_in_air(veh)) then
        -- apply_force_to_entity(Ped ped, int forceType, float x, float y, float z, float rx, float ry, float rz, bool isRel, bool highForce)	 entity.apply_force_to_entity

        entity.apply_force_to_entity(veh, 1,    0, 0, height,    0, 0, 0,   true, true)
    end
end
local isDrifting      = 0
local wasDrifting     = 0
local isDriftFinished = 1
local prevGripState   = 0
local lastDriftAngle  = 0.0
local oldGripState    = 0
local debug_notification = 0
local function driftmod_ontick() 
    local player = player.player_id(); -- however you get the current player
    local veh = getCurrentVehicle()
    --
    -- if (not entity.does_entity_exist(veh)) then
    --    return
    -- end

    local inVehicle   = veh ~= 0
	
    local isDriving   = true

    local mps = entity.get_entity_speed(veh)
    local mph       = mps * 2.23694
    local kmh       = mps * 3.6

    -- isDrifting = false
    -- vehicle.set_vehicle_reduce_grip(veh, false)

    -- for later
    -- if (isDriving and TOGGLED("featureVehConstantBoost")) jordans_boost()

    if (inVehicle and isDriving and not isDrifting and not isDriftFinished) then
        isDriftFinished = true
    end

    if not inVehicle or not isDriving then
        return
    end

    local driftKeyPressed = (controls.is_control_pressed(-1, 1) or controls.is_disabled_control_pressed(2, 206)) and controls.is_control_pressed(2, 193) or controls.is_disabled_control_pressed(2, 193)

    if (driftKeyPressed and vehicle.get_vehicle_current_gear(veh) > 2) then
        vehicle.set_vehicle_current_gear(veh, 2)
        vehicle.set_vehicle_next_gear(veh, 2)
    end

    if (driftKeyPressed) then
        if (controls.get_control_normal(2, ControlVehicleBrake) > 0.1) then
            controls.set_control_normal(0, ControlVehicleBrake, 0)
            local neg = -0.3

            if (controls.is_control_pressed(2, ControlVehicleSelectNextWeapon)) then
                neg = 10
            end

            slamDatBitch(veh, neg * 1 * controls.get_control_normal(2, ControlVehicleBrake))
        end 

        local angleOfTravel  = getHeadingOfTravel(veh)
        local angleOfHeading = entity.get_entity_heading(veh)
        local drift          = angleOfHeading - angleOfTravel
if (drift and lastDriftAngle) then
            local diff = drift - lastDriftAngle

            if (diff > 180.0) then
                drift = drift - 360.0
            end
            if (diff < 180.0) then
                drift = drift - 360.0
            end
        end
        drift          = wrap360(drift)
        lastDriftAngle = drift

        local td = 360 - drift
        if td > 180 then
            td = 0 - (360 - td)
        end
        local done = false
        if ((isDrifting or kmh > gs_driftMinSpeed) and (math.abs(drift - 360.0) < gs_driftMaxAngle) or (drift < gs_driftMaxAngle)) then
            isDrifting      = 1
            isDriftFinished = 1;  -- Doesn't get set to 0 until isDrifting is 0.

            if (driftKeyPressed) then
                if (driftKeyPressed ~= oldGripState) then
                    vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done and kmh < gs_driftMinSpeed then
            if (driftKeyPressed) then
                if (driftKeyPressed ~= oldGripState) then
                    vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done then
            if driftKeyPressed == oldGripState then
                vehicle.set_vehicle_reduce_grip(veh, false)
                oldGripState = 0
            end
		else 
			vehicle.set_vehicle_indicator_lights(veh, 0, false)
			vehicle.set_vehicle_indicator_lights(veh, 1, false)
        end
    end

    if (not driftKeyPressed and prevGripState) then
        isDrifting      = 0
        isDriftFinished = 0
        lastDriftAngle = 0

        if (driftKeyPressed ~= oldGripState) then
            vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
            oldGripState = driftKeyPressed
        end
    end

    prevGripState = driftKeyPressed
    if (isDrifting ~= wasDrifting) then
        wasDrifting     = isDrifting
        changedDrifting = true
    end
end

local driftmod = menu.add_feature("DriftMod - PS", "toggle", LocalMain, function(f)
	while f.on do	
        if (not player.is_player_in_any_vehicle(player.player_id())) then
            menu.notify("You need to be in a vehicle to use DriftMod")
            f.on = false
    menu.notify("Press Square On The PS Controller To Activate :)") -- i dont know what the button is on an xbox controller, if you do please dm me "Flames#6666"
        end
		driftmod_ontick()
		system.yield(0)
	end
end)
driftmod.on = false  -- enable this if you want the "DriftMod" feature on when you launch the script

DriftMod = true

----------------------------------- DRIFT MOD STUFF

----------------------------------- DRIFT MOD STUFF CONTROLLER
-- Configurables

local gs_driftMinSpeed = 8.0
local gs_driftMaxAngle = 50.0
local gs_driftOppLock = 0.375
local ControlVehicleAccelerate = 71
local ControlVehicleBrake = 72
local ControlVehicleDuck = 73
local ControlVehicleSelectNextWeapon = 99
local ControlVehicleMoveUpOnly = 61

local function asDegrees(angle)
    return angle * (180.0 / 3.14159265357); 
end

local function wrap360(val) 
    --    return math.fmod(val + 360 + 360, 360)
    while (val < 0.0) do
        val = val + 360.0
    end
    while (val > 360.0) do
        val = val - 360.0
    end
    return val
end

local function getCurrentVehicle() 
	local player_id = player.player_id()
	local player_ped = player.get_player_ped(player_id)
    local player_vehicle = 0
    if (ped.is_ped_in_any_vehicle(player_ped)) then
        local veh = ped.get_vehicle_ped_is_using(player_ped)
        if (network.has_control_of_entity(veh)) then
            player_vehicle = veh
        end
    end
    return player_vehicle
end


local function getHeadingOfTravel(veh) 
    local velocity = entity.get_entity_velocity(veh)
    local x = velocity.x
    local y = velocity.y
    local at2 = math.atan(y, x)
    return math.fmod(270.0 + math.deg(at2), 360.0)
end

local function randomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end

local function RGBAToInt(R, G, B, A)
	A = A or 255
	return ((tonumber(R)&0x0ff)<<0x00)|((tonumber(G)&0x0ff)<<0x08)|((tonumber(B)&0x0ff)<<0x10)|((tonumber(A)&0x0ff)<<0x18)
end

local function slamDatBitch(veh, height) 
    if (vehicle.is_vehicle_on_all_wheels(veh) and not entity.is_entity_in_air(veh)) then
        -- apply_force_to_entity(Ped ped, int forceType, float x, float y, float z, float rx, float ry, float rz, bool isRel, bool highForce)	 entity.apply_force_to_entity

        entity.apply_force_to_entity(veh, 1,    0, 0, height,    0, 0, 0,   true, true)
    end
end

local isDrifting      = 0
local wasDrifting     = 0
local isDriftFinished = 1
local prevGripState   = 0
local lastDriftAngle  = 0.0
local oldGripState    = 0
local debug_notification = 0

local function driftmod_ontick() 
    local player = player.player_id(); -- however you get the current player
    local veh = getCurrentVehicle()
    --
    -- if (not entity.does_entity_exist(veh)) then
    --    return
    -- end

    local inVehicle   = veh ~= 0
	
    local isDriving   = true

    local mps = entity.get_entity_speed(veh)
    local mph       = mps * 2.23694
    local kmh       = mps * 3.6

    -- isDrifting = false
    -- vehicle.set_vehicle_reduce_grip(veh, false)

    -- for later
    -- if (isDriving and TOGGLED("featureVehConstantBoost")) jordans_boost()

    if (inVehicle and isDriving and not isDrifting and not isDriftFinished) then
        isDriftFinished = true
    end

    if not inVehicle or not isDriving then
        return
    end

    -- if (isDrifting)
        -- drawText("Drifting")
    -- if (vehicle.is_vehicle_in_burnout(veh)) (2, 206)
        -- drawRect("Burnout")

        local driftKeyPressed = controls.is_control_pressed(3, ControlVehicleDuck) or controls.is_disabled_control_pressed(2, ControlVehicleDuck) or controls.is_control_pressed(0, ControlVehicleMoveUpOnly) or controls.is_disabled_control_pressed(0, ControlVehicleMoveUpOnly)

    -- if (not driftKeyPressed and controls.is_control_pressed(0, ControlVehicleMoveUpOnly) and vehicle.is_vehicle_on_all_wheels(veh)) then
    --     driftKeyPressed = true 
    -- end

    if (driftKeyPressed and vehicle.get_vehicle_current_gear(veh) > 2) then
        vehicle.set_vehicle_current_gear(veh, 2)
        vehicle.set_vehicle_next_gear(veh, 2)
    end

    if (driftKeyPressed) then
        if (controls.get_control_normal(2, ControlVehicleBrake) > 0.1) then
            controls.set_control_normal(0, ControlVehicleBrake, 0)
            local neg = -0.3

            if (controls.is_control_pressed(2, ControlVehicleSelectNextWeapon)) then
                neg = 10
            end

            slamDatBitch(veh, neg * 1 * controls.get_control_normal(2, ControlVehicleBrake))
        end 

        local angleOfTravel  = getHeadingOfTravel(veh)
        local angleOfHeading = entity.get_entity_heading(veh)
        local drift          = angleOfHeading - angleOfTravel

        if (drift and lastDriftAngle) then
            local diff = drift - lastDriftAngle

            if (diff > 180.0) then
                drift = drift - 360.0
            end
            if (diff < 180.0) then
                drift = drift - 360.0
            end
        end

        -- drift = math.fmod(drift, 360)
        drift          = wrap360(drift)
        lastDriftAngle = drift

        local td = 360 - drift
        if td > 180 then
            td = 0 - (360 - td)
        end
        --ui.draw_text(td, v2(0.5, 0.2))

        local done = false
        if ((isDrifting or kmh > gs_driftMinSpeed) and (math.abs(drift - 360.0) < gs_driftMaxAngle) or (drift < gs_driftMaxAngle)) then
            isDrifting      = 1
            isDriftFinished = 1;  -- Doesn't get set to 0 until isDrifting is 0.

            if (driftKeyPressed) then
                if (driftKeyPressed ~= oldGripState) then
                    vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done and kmh < gs_driftMinSpeed then
            if (driftKeyPressed) then
                if (driftKeyPressed ~= oldGripState) then
                    vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done then
            if driftKeyPressed == oldGripState then
                vehicle.set_vehicle_reduce_grip(veh, false)
                oldGripState = 0
            end
		else 
			vehicle.set_vehicle_indicator_lights(veh, 0, false)
			vehicle.set_vehicle_indicator_lights(veh, 1, false)
        end
    end

    if (not driftKeyPressed and prevGripState) then
        isDrifting      = 0
        isDriftFinished = 0
        lastDriftAngle = 0

        if (driftKeyPressed ~= oldGripState) then
            vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
            oldGripState = driftKeyPressed
        end
    end

    prevGripState = driftKeyPressed
    if (isDrifting ~= wasDrifting) then
        wasDrifting     = isDrifting
        changedDrifting = true
    end
end

local driftmod = menu.add_feature("DriftMod - PC", "toggle", LocalMain, function(f)
    menu.notify("Press Shift To Activate :)") -- :)
	while f.on do	
        if (not player.is_player_in_any_vehicle(player.player_id())) then
            menu.notify("You need to be in a vehicle to use DriftMod")
            f.on = false
        end
		driftmod_ontick()
		system.yield(0)
	end
end)
driftmod.on = false  -- enable "true" this if you want the "DriftMod" feature on when you launch the script

DriftMod = true

----------------------------------- DRIFT MOD STUFF

----------------------------------- NO TRACTION STUFF

menu.add_feature("No Traction", "toggle", LocalMain, function(j)
    local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  while (j.on) do
        if (not player.is_player_in_any_vehicle(player.player_id())) then
            menu.notify("You need to be in a vehicle to use No Traction")
            j.on = false
        end
        vehicle.set_vehicle_reduce_grip(player_veh, true)
        system.wait(1000)
    end
    if (not j.on) then
        vehicle.set_vehicle_reduce_grip(player_veh, false)
    end
end)

--------------------------------------

menu.add_feature("No Collision With Vehicles", "toggle", LocalMain, function(f)
    if f.on then
        if (not player.is_player_in_any_vehicle(player.player_id())) then
            menu.notify("You need to be in a vehicle to use No Collision")
            f.on = false
        end
        local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
        if veh and vehicle.get_ped_in_vehicle_seat(veh, -1) == player.get_player_ped(player.player_id()) then
            local collision = ped.get_all_peds()
            for i = 1, #collision do
                entity.set_entity_no_collsion_entity(collision[i], veh, true)
                entity.set_entity_no_collsion_entity(veh, collision[i], true)
            end
            collision = object.get_all_objects()
            for i = 1, #collision do
                entity.set_entity_no_collsion_entity(collision[i], veh, true)
                entity.set_entity_no_collsion_entity(veh, collision[i], true)
            end
            collision = vehicle.get_all_vehicles()
            for i = 1, #collision do
                entity.set_entity_no_collsion_entity(collision[i], veh, true)
                entity.set_entity_no_collsion_entity(veh, collision[i], true)
            end
        end
    end
    return HANDLER_CONTINUE
end)
---------------------------------------------------

-- Special Thanks To Proddy For The DriftMod
-- Special Thanks To jhowkNx For The Vehicle Speed Multiplier
-- Special Thanks To noob For The Rainbow Neons
-- Special Thanks To RulyPancake the 5th For The Downgrade To Standard