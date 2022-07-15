local trolling = menu.add_player_feature("Trolling", "parent", 0)
local sound_trolling = menu.add_player_feature("Sound Trolling", "parent", trolling.id)
local NPC_trolling = menu.add_player_feature("NPC Trolling", "parent", trolling.id)

local trollmenu_local = menu.add_feature("Troll Menu", "parent", 0)

local troll_menu_ver = "Troll Menu v1.0.1"
require("this_is_needed\\npc_functions")
require("this_is_needed\\outfit_functions")
require("this_is_needed\\other_functions")

function loaded()
    menu.notify("Welcome to Troll Menu, " .. player.get_player_name(player.player_id()) .. "\nTo get started, go to the Online tab by pressing NUMPAD 7 or your preferred keybind for tab switching, then go to Online Players, <player_name>, and Script Features to use Troll Menu.", troll_menu_ver)
end
loaded()


--   _____  ____   __  __ _   __ ____     ______ ____   ____   __     __     ____ _   __ ______
--  / ___/ / __ \ / / / // | / // __ \   /_  __// __ \ / __ \ / /    / /    /  _// | / // ____/
--  \__ \ / / / // / / //  |/ // / / /    / /  / /_/ // / / // /    / /     / / /  |/ // / __  
-- ___/ // /_/ // /_/ // /|  // /_/ /    / /  / _, _// /_/ // /___ / /___ _/ / / /|  // /_/ /  
--/____/ \____/ \____//_/ |_//_____/    /_/  /_/ |_| \____//_____//_____//___//_/ |_/ \____/   

menu.add_player_feature("Baritone Saxophone", "action", sound_trolling.id, function(playerfeat, pid)
    audio.play_sound_from_entity(-1, "Horn", player.get_player_ped(pid), "DLC_Apt_Yacht_Ambient_Soundset")
end)

menu.add_player_feature("Camera Shutter", "action", sound_trolling.id, function(playerfeat, pid)
    audio.play_sound_from_entity(-1, "SHUTTER_FLASH", player.get_player_ped(pid), "CAMERA_FLASH_SOUNDSET")
end) 

menu.add_player_feature("Walkie-Talkie", "action", sound_trolling.id, function(playerfeat, pid)
    audio.play_sound_from_entity(-1, "Start_Squelch", player.get_player_ped(pid), "CB_RADIO_SFX")
end)

menu.add_player_feature("Fast Beeping", "action", sound_trolling.id, function(playerfeat, pid)
    audio.play_sound_from_entity(-1, "Beep_Red", player.get_player_ped(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS")
end)

menu.add_player_feature("Air Defenses Off", "action", sound_trolling.id, function(playerfeat, pid)
    audio.play_sound_from_entity(-1, "Air_Defenses_Disabled", player.get_player_ped(pid), "DLC_sum20_Business_Battle_AC_Sounds")
end)

menu.add_player_feature("Metal Detector Sounds", "action_value_str", sound_trolling.id, function(playerfeat_val, pid)
    if (playerfeat_val.value == 0) then
        audio.play_sound_from_entity(-1, "Metal_Detector_Small_Guns", player.get_player_ped(pid), "dlc_ch_heist_finale_security_alarms_sounds")
    elseif (playerfeat_val.value == 1) then
        audio.play_sound_from_entity(-1, "Metal_Detector_Big_Guns", player.get_player_ped(pid), "dlc_ch_heist_finale_security_alarms_sounds")
    end
end):set_str_data({"Small Weps", "Big Weps"})

menu.add_player_feature("Cicadas", "action", sound_trolling.id, function(playerfeat, pid)
    menu.notify("Prolonged usage of this sound will cause sounds to no longer work until you change sessions.", "WARNING", 10, 0x000000ff)
    for i=1,10 do
        audio.play_sound_from_entity(-1, "SHUTTER_FLASH", player.get_player_ped(pid), "CAMERA_FLASH_SOUNDSET")
        system.wait(0)
    end
end)

menu.add_player_feature("Fast Beep Loop", "toggle", sound_trolling.id, function(playerfeat_toggle, pid)
    while playerfeat_toggle.on do
        audio.play_sound_from_entity(-1, "Beep_Red", player.get_player_ped(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS")
        system.wait(0)
    end
end)

menu.add_player_feature("Bari Sax Loop", "toggle", sound_trolling.id, function(playerfeat_toggle, pid)
    while playerfeat_toggle.on do
        audio.play_sound_from_entity(-1, "Horn", player.get_player_ped(pid), "DLC_Apt_Yacht_Ambient_Soundset")
        system.wait(0)
    end
end)

--  ______ ____   ____   __     __     ____ _   __ ______
-- /_  __// __ \ / __ \ / /    / /    /  _// | / // ____/
--  / /  / /_/ // / / // /    / /     / / /  |/ // / __  
-- / /  / _, _// /_/ // /___ / /___ _/ / / /|  // /_/ /  
--/_/  /_/ |_| \____//_____//_____//___//_/ |_/ \____/   
                                                       
menu.add_player_feature("Spawn a Jet Spray", "action_value_str", trolling.id, function(playerfeat_val, pid)
    local jet_sprays = {12, 13, 11, 24}
    fire.add_explosion(player.get_player_coords(pid) - v3(0, 0, 1), jet_sprays[playerfeat_val.value+1], true, false, 0, pid)
end):set_str_data({"Fire Jet", "Water Jet", "Steam jet", "Extinguisher Jet"})

menu.add_player_feature("Firey Death Inferno", "toggle", trolling.id, function(playerfeat_toggle, pid)
    menu.notify("Blasting " .. player.get_player_name(pid) .. " around with steam", troll_menu_ver)
    while playerfeat_toggle.on do
        fire.add_explosion(player.get_player_coords(pid) - v3(0, 0, 1), 12, true, false, 0, pid)
        system.wait(0)
    end
end)

menu.add_player_feature("100-Year Flood", "toggle", trolling.id, function(playerfeat_toggle, pid)
    menu.notify("Blasting " .. player.get_player_name(pid) .. " around with steam", troll_menu_ver)
    while playerfeat_toggle.on do
        fire.add_explosion(player.get_player_coords(pid) - v3(0, 0, 1), 13, true, false, 0, pid)
        system.wait(0)
    end
end)

menu.add_player_feature("Fountain of Steam", "toggle", trolling.id, function(playerfeat_toggle, pid)
    menu.notify("Blasting " .. player.get_player_name(pid) .. " around with steam", troll_menu_ver)
    while playerfeat_toggle.on do
        fire.add_explosion(player.get_player_coords(pid) - v3(0, 0, 1), 11, true, false, 0, pid)
        system.wait(0)
    end
end)

menu.add_player_feature("Invisible Explosion", "action", trolling.id, function(playerfeat_toggle, pid)
    menu.notify("Spawned an invisible explosion on " .. player.get_player_name(pid) .. ".", troll_menu_ver)
    fire.add_explosion(player.get_player_coords(pid), 11, false, true, 0, pid)
end)

local snowball_explosion = menu.add_player_feature("Snowball Explosion", "value_i", trolling.id, function(playerfeat_toggle, pid)
    while playerfeat_toggle.on do
        fire.add_explosion(player.get_player_coords(pid), 39, true, false, 0, pid)
        system.wait(playerfeat_toggle.value)
    end
end)
snowball_explosion.min = 500
snowball_explosion.max = 1000
snowball_explosion.mod = 50
snowball_explosion.value = 750

menu.add_player_feature("Give Weird Weapons", "action", trolling.id, function(playerfeat, pid)
    menu.notify("Gave weird weapons to " .. player.get_player_name(pid) .. ".", troll_menu_ver)
    local all_weaps = weapon.get_all_weapon_hashes()
    local weird_weapons = {
        0x83839C4, -- vintage pistol
        0x97EA20B8, -- double action revolver
        0x917F6C8C, -- navy revolver
        0x57A4368C, -- perico pistol
        0xA89CB99E, -- musket
        0xA0973D5E, -- bz gas
        0x24B17070, -- molotov cocktail
        0x23C9F95C, -- baseball
        0xFDBC8A50, -- tear gas
        0x497FACC3, -- flare
        0x34A67B97, -- jerry can
        0x060EC506, -- fire extinquisher
        0xBA536372, -- hazardous jerry can
        0x184140A1, -- fertilizer can
        0x94117305, -- pool cue
        0xD8DF3C3C, -- brass knuckles
        0x8BB05FD7 -- flashlight
        }

    for i = 1, #all_weaps do
        weapon.remove_weapon_from_ped(player.get_player_ped(pid), all_weaps[i])
    end

    system.wait(2000)
    for i = 1, #weird_weapons do
        weapon.give_delayed_weapon_to_ped(player.get_player_ped(pid), weird_weapons[i], 0, 0)
        weapon.set_ped_ammo(player.get_player_ped(pid), weird_weapons[i], 9999)
    end
end)

menu.add_player_feature("Suffocate Player", "action", trolling.id, function(playerfeat, pid)
    menu.notify("Suffocating " .. player.get_player_name(pid), troll_menu_ver)
    ped.clear_ped_tasks_immediately(player.get_player_ped(pid))

    local cage = object.create_object(251770068, player.get_player_coords(pid) - v3(0, 0, 2.6), true, false)
    entity.set_entity_visible(cage, false)
    entity.set_entity_as_no_longer_needed(cage)

    for i=1, 10 do
        fire.add_explosion(player.get_player_coords(pid) + v3(0, 0, 1), 21, true, true, 0, pid)
        fire.add_explosion(player.get_player_coords(pid) + v3(0, 0, 1), 20, true, true, 0, pid)
    end
    
    system.wait(7100)
    entity.delete_entity(cage)
end)

menu.add_player_feature("Blind Player", "toggle", trolling.id, function(playerfeat_toggle, pid)
    menu.notify("Blinding " .. player.get_player_name(pid), troll_menu_ver)

    local ptfx_loaded = false
    local ptfx_executed = false
    graphics.set_next_ptfx_asset("core")
    if (ptfx_loaded == false or ptfx_executed == false) then
        ptfx_loaded = requestPTFX("core")
        ptfx_executed = true
    end

    while playerfeat_toggle.on do
        local flare_ptfx = graphics.start_networked_ptfx_looped_on_entity("exp_grd_flare", player.get_player_ped(pid), v3(0, 0.6, 0.45), v3(0, 0, 0), 2)
        system.wait(250)
        graphics.remove_particle_fx(flare_ptfx, true)
        return HANDLER_CONTINUE
    end

    if (not playerfeat_toggle.on) then
        graphics.remove_named_ptfx_asset("core")
        ptfx_loaded = false
        ptfx_executed = false
    end
end)

menu.add_player_feature("Slippery Driving", "action_value_str", trolling.id, function(playerfeat, pid)
    if (player.is_player_in_any_vehicle(pid)) then
        menu.notify("Caused " .. player.get_player_name(pid) .. "'s vehicle to slip uncontrollably", troll_menu_ver)
        if (playerfeat.value == 0) then
            fire.add_explosion(player.get_player_coords(pid), 67, true, false, 0, pid)
        elseif (playerfeat.value == 1) then
            fire.add_explosion(player.get_player_coords(pid), 67, true, false, 0, pid)
            local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
            local wheelcount = vehicle.get_vehicle_wheel_count(player_veh)
            if wheelcount ~= nil then
                for count = 0, wheelcount + 1 do
                    network.request_control_of_entity(player_veh)
                    vehicle.set_vehicle_tire_burst(player_veh, count, true, 1000)
                end
            end
        end
    else
        menu.notify(player.get_player_name(pid) .. " is not in a vehicle", troll_menu_ver)
    end
end):set_str_data({"Original", "Pro Max"})

menu.add_player_feature("Ragdoll Player", "action", trolling.id, function(playerfeat, pid)
    menu.notify("Ragdolled " .. player.get_player_name(pid) .. ".", troll_menu_ver)
    fire.add_explosion(player.get_player_coords(pid) - v3(0, 0, 3.5), 70, false, true, 0, pid)
end)

menu.add_player_feature("Rain Stuff On Player", "value_str", trolling.id, function(playerfeat_toggle_val, pid)
    menu.notify("Raining stuff on " .. player.get_player_name(pid), troll_menu_ver)

    local stuff_to_rain = {0x13579279, 0x0781FE4A, 0xFDBC8A50, 0x24B17070, 0x7F7497E5, 0xDB26713A}
    while playerfeat_toggle_val.on do
        local landing = player.get_player_coords(pid) + v3(math.random(-3, 3), math.random(-3, 3), 0)
        gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid) + v3(0, 0, 30), landing, 200, stuff_to_rain[playerfeat_toggle_val.value+1], pid, true, false, -1)
        system.wait(500)
    end
end):set_str_data({"Rockets", "Grenades", "Smoke Grenades", "Molotovs", "Fireworks", "EMP"})

menu.add_player_feature("Shake Camera", "action", trolling.id, function(playerfeat, pid)
    menu.notify("Shaking " .. player.get_player_name(pid) .. "'s camera.", troll_menu_ver)
    fire.add_explosion(player.get_player_coords(pid) + v3(0, 0, -5), 70, false, true, 100, pid)
end)

menu.add_player_feature("Crush Player", "action", trolling.id, function(playerfeat, pid)
    menu.notify("Crushing " .. player.get_player_name(pid), troll_menu_ver)
    local pos = player.get_player_coords(pid)
    pos.z = pos.z + 5
    
    requestModel(0xEDC6F847)
    local veh = vehicle.create_vehicle(0xEDC6F847, pos, pos.z, true, false)
    streaming.set_model_as_no_longer_needed(0xEDC6F847)
    network.request_control_of_entity(veh)

    entity.set_entity_visible(veh, false)
    entity.set_entity_god_mode(veh, true)
    entity.set_entity_velocity(veh, v3(0, 0, -25))

    system.wait(5000)
    entity.set_entity_as_mission_entity(veh, true, true)
    entity.delete_entity(veh)
end)

menu.add_player_feature("Stun Vehicle", "action", trolling.id, function(playerfeat, pid)
    if player.is_player_in_any_vehicle(pid) == true then
        menu.notify("Stunned " .. player.get_player_name(pid) .. "'s vehicle.", troll_menu_ver)
        fire.add_explosion(player.get_player_coords(pid), 83, true, false, 0, pid)
    else
        menu.notify(player.get_player_name(pid) .. " is not in a vehicle", troll_menu_ver)
    end
end)

menu.add_player_feature("Random Engine Shutdowns", "toggle", trolling.id, function(playerfeat_toggle, pid)
    while (playerfeat_toggle.on) do
        local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
        if (player.is_player_in_any_vehicle(pid)) then
            menu.notify("Turned the engine in " .. player.get_player_name(pid) .. "'s " .. vehicle.get_vehicle_model(player_veh) .. " off.", troll_menu_ver)
            fire.add_explosion(player.get_player_coords(pid), 83, false, true, 0, pid)
        else
            menu.notify(player.get_player_name(pid) .. " is not in a vehicle", troll_menu_ver)
        end
        system.wait(math.random(30, 60) * 1000)
    end
end)

menu.add_player_feature("Set Vehicle Ablaze", "action", trolling.id, function(playerfeat, pid)
    local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
    if (player.is_player_in_any_vehicle(pid)) then
        menu.notify("Destroyed " .. player.get_player_name(pid) .. "'s " .. vehicle.get_vehicle_model(player_veh), troll_menu_ver)
        network.request_control_of_entity(player_veh)
        vehicle.set_vehicle_engine_health(player_veh, -1)
    else
        menu.notify(player.get_player_name(pid) .. " is not in a vehicle", troll_menu_ver)
    end
end)

menu.add_player_feature("Vehicle Kick Loop", "toggle", trolling.id, function(playerfeat_toggle, pid)
    while (playerfeat_toggle.on) do
        local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
        if (player.is_player_in_any_vehicle(pid)) then
            menu.notify("Kicking " .. player.get_player_name(pid) .. " out of their " .. vehicle.get_vehicle_model(player_veh), troll_menu_ver)
            ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
        else
            menu.notify(player.get_player_name(pid) .. " is not in a vehicle", troll_menu_ver)
        end
        system.wait(5000)
    end
end)

menu.add_player_feature("Force Player To Be Christian", "toggle", trolling.id, function(playerfeat_toggle, pid)
    menu.notify(player.get_player_name(pid) .. " will be blown up as soon as they enter the Strip Club.", troll_menu_ver)
    while (playerfeat_toggle.on) do
        local player_pos = player.get_player_coords(pid)
        local world_pos1 = v3(128 + 5, -1298 + 5, 29 + 5)
        local world_pos2 = v3(128 - 5, -1298 - 5, 29 - 5)

        if (player_pos.x <= world_pos1.x) and (player_pos.y <= world_pos1.y) and (player_pos.z <= world_pos1.z) and (player_pos.x >= world_pos2.x) and (player_pos.y >= world_pos2.y) and (player_pos.z >= world_pos2.z) then
            fire.add_explosion(player_pos, 59, true, true, 0, pid)
        end
        system.wait(150)
    end
end)

menu.add_player_feature("Cages", "action_value_str", trolling.id, function(playerfeat_val, pid)
    menu.notify("Spawned a cage on " .. player.get_player_name(pid), troll_menu_ver)
    ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
    system.wait(0)
    local pos = player.get_player_coords(pid)
    if (playerfeat_val.value == 0) then
        object.create_object(gameplay.get_hash_key("as_prop_as_target_scaffold_01a"), v3(pos.x, pos.y - 0.6, pos.z - 1), true, false)
        object.create_object(gameplay.get_hash_key("as_prop_as_target_scaffold_01a"), v3(pos.x, pos.y - 0.6, pos.z + 1), true, false)
    elseif (playerfeat_val.value == 1) then
        object.create_object(-82704061, v3(pos.x, pos.y, pos.z - 0.6), true, false)
    elseif (playerfeat_val.value == 2) then
        object.create_object(251770068, v3(pos.x, pos.y, pos.z - 2.6), true, false)
    elseif (playerfeat_val.value == 3) then
        object.create_object(1708971027, v3(pos.x - 0.2, pos.y, pos.z - 0.6), true, false)
        object.create_object(1708971027, v3(pos.x - 0.2, pos.y, pos.z + 0.6), true, false)
        object.create_object(1708971027, v3(pos.x + 2, pos.y, pos.z - 0.6), true, false)
        object.create_object(1708971027, v3(pos.x + 2, pos.y, pos.z + 0.6), true, false)
    elseif (playerfeat_val.value == 4) then
        object.create_object(-733833763, v3(pos.x, pos.y, pos.z - 0.6), true, false)
        object.create_object(-733833763, v3(pos.x, pos.y + 2, pos.z - 0.6), true, false)
    elseif (playerfeat_val.value == 5) then
        object.create_object(-1576911260, v3(pos.x - 0.2, pos.y, pos.z - 0.6), true, false)
        object.create_object(-1576911260, v3(pos.x - 0.2, pos.y, pos.z + 0.6), true, false)
    elseif (playerfeat_val.value == 6) then
        object.create_object(-272361894, v3(pos.x - 0.2, pos.y, pos.z - 0.6), true, false)
    elseif (playerfeat_val.value == 7) then
        object.create_object(-206690185, v3(pos.x - 0.2, pos.y, pos.z - 0.6), true, false)
    end
end):set_str_data({"Scaffold", "Crate", "Elevator", "Sandblocks", "Cable Cars", "Animal Feeder", "Food Van", "Dumpster"})

menu.add_player_feature("Invisible Cages", "action_value_str", trolling.id, function(playerfeat_val, pid)
    menu.notify("Spawned an invisible cage on " .. player.get_player_name(pid), troll_menu_ver)
    ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
    system.wait(0)
    local pos = player.get_player_coords(pid)
    if (playerfeat_val.value == 0) then
        local one = object.create_object(gameplay.get_hash_key("as_prop_as_target_scaffold_01a"), v3(pos.x, pos.y - 0.6, pos.z - 1), true, false)
        local two = object.create_object(gameplay.get_hash_key("as_prop_as_target_scaffold_01a"), v3(pos.x, pos.y - 0.6, pos.z + 1), true, false)
        entity.set_entity_visible(one, false)
        entity.set_entity_visible(two, false)
    elseif (playerfeat_val.value == 1) then
        local cage = object.create_object(-82704061, v3(pos.x, pos.y, pos.z - 0.6), true, false)
        entity.set_entity_visible(cage, false)
    elseif (playerfeat_val.value == 2) then
        local cage = object.create_object(251770068, v3(pos.x, pos.y, pos.z - 2.6), true, false)
        entity.set_entity_visible(cage, false)
    end
end):set_str_data({"Scaffold", "Crate", "Elevator"})

menu.add_player_feature("Spawn Clone", "action", trolling.id, function(playerfeat_toggle_val, pid)
    local MP_ped
    if (player.is_player_female(pid)) then
        MP_ped = 0x9C9EFFD8
    else
        MP_ped = 0x705E61F2
    end

    requestModel(MP_ped)
    local _ped = ped.create_ped(1, MP_ped, player.get_player_coords(player.player_id()) + v3(-1, 0, 0), 0, true, false)
    streaming.set_model_as_no_longer_needed(MP_ped)
    createClone(player.get_player_ped(pid), _ped)
    entity.set_entity_as_mission_entity(_ped, true, true)
end)


--    _   __ ____   ______   ______ ____   ____   __     __     ____ _   __ ______
--   / | / // __ \ / ____/  /_  __// __ \ / __ \ / /    / /    /  _// | / // ____/
--  /  |/ // /_/ // /        / /  / /_/ // / / // /    / /     / / /  |/ // / __  
-- / /|  // ____// /___     / /  / _, _// /_/ // /___ / /___ _/ / / /|  // /_/ /  
--/_/ |_//_/     \____/    /_/  /_/ |_| \____//_____//_____//___//_/ |_/ \____/   
                                                                                
menu.add_player_feature("Turn Nearby NPCs Into...", "action_value_str", NPC_trolling.id, function(playerfeat_val, pid)
    menu.notify("Made all NPCs near " .. player.get_player_name(pid) .. " perform the selected scenario.", troll_menu_ver)
    local peds = ped.get_all_peds()
    for i = 1, #peds do
        if not ped.is_ped_a_player(peds[i]) then
            ped.clear_ped_tasks_immediately(peds[i])
            if (playerfeat_val.value == 0) then
                ai.task_start_scenario_in_place(peds[i], "WORLD_HUMAN_MUSICIAN", 0, true)
            elseif (playerfeat_val.value == 1) then
                ai.task_start_scenario_in_place(peds[i], "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", 0, true)
            elseif (playerfeat_val.value == 2) then
                ai.task_start_scenario_in_place(peds[i], "WORLD_HUMAN_HUMAN_STATUE", 0, true)
            elseif (playerfeat_val.value == 3) then
                ai.task_start_scenario_in_place(peds[i], "WORLD_HUMAN_PAPARAZZI", 0, true)
            elseif (playerfeat_val.value == 4) then
                ai.task_start_scenario_in_place(peds[i], "WORLD_HUMAN_JANITOR", 0, true)
            end
        end
    end
end):set_str_data({"Musicians", "Prostitutes", "Statues", "Paparazzos", "Janitors"})

menu.add_player_feature("Make NPCs Perform a Custom Scenario", "action", NPC_trolling.id, function(playerfeat, pid)
    local _input, k = input.get("Type in a custom NPC world scenario", "world_human_musician", 100, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        return HANDLER_POP
    end

    local peds = ped.get_all_peds()
    for i=1, #peds do
        if not ped.is_ped_a_player(peds[i]) then
            ped.clear_ped_tasks_immediately(peds[i])
            ai.task_start_scenario_in_place(peds[i], k:upper(), 0, true)
        end
    end
end)

menu.add_player_feature("Make Nearby NPCs Flop Around", "toggle", NPC_trolling.id, function(playerfeat_toggle, pid)
    local peds = ped.get_all_peds()
    while playerfeat_toggle.on do
        for i=1, #peds do
            if (not ped.is_ped_a_player(peds[i])) then
                ped.clear_ped_tasks_immediately(peds[i])
                ai.task_sky_dive(peds[i], true)
            end
        end
        system.wait(3000)
    end
end)

menu.add_player_feature("Spawn Stripper El Rubio", "action", NPC_trolling.id, function(playerfeat, pid)
    menu.notify("Spawned a pole dancing El Rubio near "..player.get_player_name(pid)..". This only works if you're in range or spectating the player.", troll_menu_ver)
    requestModel(0xD74B8139)
    requestAnimDictAndSet("mini@strip_club@pole_dance@pole_dance1", "pd_dance_01")

    local _ped = ped.create_ped(1, 0xD74B8139, player.get_player_coords(pid) + v3(math.random(-5, 5), math.random(-5, 5), 0), player.get_player_heading(pid), true, false)
    streaming.set_model_as_no_longer_needed(0xD74B8139)
    addBlip(_ped, 1)

    system.wait(450)
    network.request_control_of_entity(_ped)
    ai.task_play_anim(_ped, "mini@strip_club@pole_dance@pole_dance1", "pd_dance_01", 8.0, 0, -1, 9, 0, false, false, false)
    
    system.wait(20000)
    entity.set_entity_as_no_longer_needed(_ped)
    entity.delete_entity(_ped)
end)

local value1 = 0
local dead_anims1 = {
        "dead_a",
        "dead_b",
        "dead_c",
        "dead_d",
        "dead_e",
        "dead_f",
        "dead_g",
        "dead_h"
    }
menu.add_player_feature("Spawn Dead El Rubio", "value_str", NPC_trolling.id, function(playerfeat_toggle_val, pid)
    value1 = playerfeat_toggle_val
    menu.notify("Spawned a dead El Rubio near "..player.get_player_name(pid)..". This only works if you're in range or spectating the player.", troll_menu_ver)
    requestModel(0xD74B8139)

    local _ped = ped.create_ped(1, 0xD74B8139, player.get_player_coords(pid) + v3(math.random(-3, 3), math.random(-3, 3), 0), player.get_player_heading(pid), true, false)
    streaming.set_model_as_no_longer_needed(0xD74B8139)
    addBlip(_ped, 1)

    while (playerfeat_toggle_val.on) do
        requestAnimDictAndSet("dead", dead_anims1[value1.value+1])
        ai.task_play_anim(_ped, "dead", dead_anims1[value1.value+1], 8.0, 0, -1, 9, 0, false, false, false)
        system.wait(1000)

        if (entity.is_entity_dead(_ped)) then
            playerfeat_toggle_val.on = false
            streaming.remove_anim_dict("dead")
            streaming.remove_anim_set(dead_anims1[value1.value+1])
        end
    end
    if (not playerfeat_toggle_val.on) then
        entity.set_entity_as_no_longer_needed(_ped)
        entity.delete_entity(_ped)
        streaming.remove_anim_dict("dead")
        streaming.remove_anim_set(dead_anims1[value1.value+1])
    end
end):set_str_data(dead_anims1)

menu.add_player_feature("Barefoot Follower", "value_str", NPC_trolling.id, function(playerfeat_toggle_val, pid)
    local MP_ped
    if (player.is_player_female(pid)) then
        MP_ped = 0x9C9EFFD8
    else
        MP_ped = 0x705E61F2
    end

    local _ped
    requestModel(MP_ped)
    if (playerfeat_toggle_val.value == 0) then
        _ped = ped.create_ped(1, MP_ped, player.get_player_coords(pid) + v3(25, 0, 0), 0, true, false)
    elseif (playerfeat_toggle_val.value == 1) then
        _ped = ped.create_ped(1, MP_ped, player.get_player_coords(pid) + v3(1, 0, 0), 0, true, false)
    end
    streaming.set_model_as_no_longer_needed(MP_ped)
    createClone(player.get_player_ped(pid), _ped)
    addBlip(_ped, 1)

    if (player.is_player_female(pid)) then
        ped.set_ped_component_variation(_ped, 6, 35, 0, 0)
    else
        ped.set_ped_component_variation(_ped, 6, 34, 0, 0)
    end
    
    while playerfeat_toggle_val.on do
        if (playerfeat_toggle_val.value == 0) then
            ai.task_go_to_coord_by_any_means(_ped, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), 0), math.random(1, 2), 0, true, 1, 0.0)
            system.wait(2000)
        elseif (playerfeat_toggle_val.value == 1) then
            ai.task_go_to_coord_by_any_means(_ped, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), 0), math.random(0, 1), 0, true, 1, 0.0)
            system.wait(2000)
        end

        if (entity.is_entity_dead(_ped)) then
            playerfeat_toggle_val.on = false
            menu.notify("Copy of " .. player.get_player_name(pid) .. " died. Toggling feature off.")
        end
    end

    if (not playerfeat_toggle_val.on) then
        entity.set_entity_as_no_longer_needed(_ped)
        entity.delete_entity(_ped)
    end
end):set_str_data({"Outside", "Inside"})

-- Spawn a dead copy of player
local value2 = 0
local dead_anims2 = {
        "dead_a",
        "dead_b",
        "dead_c",
        "dead_d",
        "dead_e",
        "dead_f",
        "dead_g",
        "dead_h"
    }

menu.add_player_feature("Spawn Dead Player", "value_str", NPC_trolling.id, function(playerfeat_toggle_val, pid)
    menu.notify("Spawned a dead copy of " .. player.get_player_name(pid) .. ". This only works if you're in range or spectating the player.", troll_menu_ver)
    value2 = playerfeat_toggle_val
    local MP_ped
    if (player.is_player_female(pid)) then
        MP_ped = 0x9C9EFFD8
    else
        MP_ped = 0x705E61F2
    end

    requestModel(MP_ped)
    local _ped = ped.create_ped(1, MP_ped, player.get_player_coords(pid) + v3(-1, 0, 0), 0, true, false)
    streaming.set_model_as_no_longer_needed(MP_ped)
    createClone(player.get_player_ped(pid), _ped)
    addBlip(_ped, 1)

    while (playerfeat_toggle_val.on) do
        requestAnimDictAndSet("dead", dead_anims1[value1.value+1])
        ai.task_play_anim(_ped, "dead", dead_anims2[value2.value+1], 8.0, 0, -1, 9, 0, false, false, false)
        system.wait(1000)

        if (entity.is_entity_dead(_ped)) then
            playerfeat_toggle_val.on = false
            menu.notify("Copy of " .. player.get_player_name(pid) .. " died. Toggling feature off.")
            streaming.remove_anim_dict("dead")
            streaming.remove_anim_set(dead_anims1[value1.value+1])
        end
    end
    if (not playerfeat_toggle_val.on) then
        entity.set_entity_as_no_longer_needed(_ped)
        entity.delete_entity(_ped)
        streaming.remove_anim_dict("dead")
        streaming.remove_anim_set(dead_anims1[value1.value+1])
    end
end):set_str_data(dead_anims2)

-- Spawn a clone follower of player
menu.add_player_feature("Spawn Clone Follower", "value_str", NPC_trolling.id, function(playerfeat_toggle_val, pid)
    local MP_ped
    if (player.is_player_female(pid)) then
        MP_ped = 0x9C9EFFD8
    else
        MP_ped = 0x705E61F2
    end

    requestModel(MP_ped)
    local _ped
    if (playerfeat_toggle_val.value == 0) then
        _ped = ped.create_ped(1, MP_ped, player.get_player_coords(pid) + v3(25, 0, 0), 0, true, false)
    elseif (playerfeat_toggle_val.value == 1) then
        _ped = ped.create_ped(1, MP_ped, player.get_player_coords(pid) + v3(1, 0, 0), 0, true, false)
    end
    streaming.set_model_as_no_longer_needed(MP_ped)
    createClone(player.get_player_ped(pid), _ped)
    addBlip(_ped, 1)

    while playerfeat_toggle_val.on do
        if (playerfeat_toggle_val.value == 0) then
            ai.task_go_to_coord_by_any_means(_ped, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), 0), math.random(1, 2), 0, true, 1, 0.0)
            system.wait(2000)
        elseif (playerfeat_toggle_val.value == 1) then
            ai.task_go_to_coord_by_any_means(_ped, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), 0), math.random(0, 1), 0, true, 1, 0.0)
            system.wait(2000)
        end

        if (entity.is_entity_dead(_ped)) then
            playerfeat_toggle_val.on = false
            menu.notify("Copy of " .. player.get_player_name(pid) .. " died. Toggling feature off.")
        end
    end

    if (not playerfeat_toggle_val.on) then
        entity.set_entity_as_no_longer_needed(_ped)
        entity.delete_entity(_ped)
    end
end):set_str_data({"Outside", "Inside"})


                            --/// SESSION TROLLING ///--
menu.add_feature("Force Session To Be Christian", "toggle", trollmenu_local.id, function(feat_toggle)
    menu.notify("Anyone will be blown up as soon as they enter the Strip Club.", troll_menu_ver)
    while (feat_toggle.on) do
        for i = 1, 31 do
            local player_pos = player.get_player_coords(i)
            local world_pos1 = v3(128 + 5, -1298 + 5, 29 + 5)
            local world_pos2 = v3(128 - 5, -1298 - 5, 29 - 5)

            
            if (player_pos.x <= world_pos1.x) and (player_pos.y <= world_pos1.y) and (player_pos.z <= world_pos1.z) and (player_pos.x >= world_pos2.x) and (player_pos.y >= world_pos2.y) and (player_pos.z >= world_pos2.z) then
                fire.add_explosion(player_pos, 59, true, true, 0, i)
            end
            system.wait(150)
        end
    end
end)

menu.add_feature("Font Color Spam", "toggle", trollmenu_local.id, function(feat_toggle)
    while (feat_toggle.on) do
        local font_colors = {
            "~r~", "~o~", "~y~", "~g~", "~b~", "~p~", "~q~", "~w~", "~s~", "~c~", "~t~", "~m~", "~u~", '~l~'
        }
        network.send_chat_message(font_colors[math.random(1, 14)]..font_colors[math.random(1, 14)]..font_colors[math.random(1, 14)], false)
        system.wait(50)
    end
end)

                            --/// MISCELLANEOUS ///--
local anti_tryhard = menu.add_player_feature("Anti-Tryhard Measures", "parent", 0)
menu.add_player_feature("Gimp player's Heavy Sniper Mk2", "action", anti_tryhard.id, function(playerfeat, pid)
    menu.notify("Removed explosive rounds from " .. player.get_player_name(pid) .. "'s Sniper Rifle Mk2.", troll_menu_ver)
    weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0xA914799) -- Heavy Sniper mk2
    system.wait(50)
    weapon.give_delayed_weapon_to_ped(player.get_player_ped(pid), 0xA914799, 0, 0) -- Heavy Sniper mk2
end)

menu.add_player_feature("Remove Common EWO Explosives", "toggle", anti_tryhard.id, function(playerfeat_toggle, pid)
    while (playerfeat_toggle.on) do
        weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0xB1CA77B1) --RPG
        weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0x63AB0442) --Homing Launcher
        weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0x2C3731D9) --Sticky Bomb
        system.wait(500)
    end
end)
    
menu.add_player_feature("Remove All Explosives", "action", anti_tryhard.id, function(playerfeat, pid)
    menu.notify("Removed all explosives from " .. player.get_player_name(pid), troll_menu_ver)
    weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0xB1CA77B1) --RPG
    weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0x63AB0442) --Homing Launcher
    weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0xA284510B) --Grenade Launcher
    weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0x0781FE4A) --Compact Grenade Launcher
    weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0x93E220BD) --Grenade
    weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0x2C3731D9) --Sticky Bomb
    weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0xAB564B93) --Proximity Mine
    weapon.remove_weapon_from_ped(player.get_player_ped(pid), 0xBA45E8B8) --Pipebomb
end)

menu.add_player_feature("Disable Opp Mk2 Usage", "value_str", anti_tryhard.id, function(playerfeat_toggle_val, pid)
    while (playerfeat_toggle_val.on) do
        local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
        if (playerfeat_toggle_val.value == 0) then
            if (player.is_player_in_any_vehicle(pid) and vehicle.is_vehicle_model(player_veh, 0x7B54A9D3)) then
                menu.notify("Kicked " .. player.get_player_name(pid) .. " off their " .. vehicle.get_vehicle_model(player_veh), "")
                ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
            end
        elseif (playerfeat_toggle_val.value == 1) then
            if (player.is_player_in_any_vehicle(pid) and vehicle.is_vehicle_model(player_veh, 0x7B54A9D3)) then
                menu.notify("Destroyed " .. player.get_player_name(pid) .. "'s " .. vehicle.get_vehicle_model(player_veh), anti_tryhard_menu_ver)
                network.request_control_of_entity(player_veh)
                vehicle.set_vehicle_engine_health(player_veh, -1)
            end
        end
    system.wait(5000)
    end
end):set_str_data({"Obvious", "Stealthy"})

menu.add_player_feature("Fake Money Drop", "toggle", trolling.id, function(feat_toggle, pid)
    local money_thread
    if feat_toggle.on then
        money_thread = menu.create_thread(function()
            local money = object.create_object(2628187989, player.get_player_coords(pid) + v3(0, 0, 2), true, true)
            entity.apply_force_to_entity(money, 3, 0, 0, -0.5, 0, 0, 0, true, true)
            system.wait(1000)
            streaming.set_model_as_no_longer_needed(money)
            entity.delete_entity(money)
        end, nil)
    end

    system.wait(100)

    if (not feat_toggle.on and menu.has_thread_finished(money_thread)) then
        menu.delete_thread(money_thread)
        menu.notify(money_thread .. " has finished.")
    end
    return HANDLER_CONTINUE
end)

--    ______                     __    _    __         
--   / ____/   _____  ___   ____/ /   (_)  / /_   _____
--  / /       / ___/ / _ \ / __  /   / /  / __/  / ___/
-- / /___    / /    /  __// /_/ /   / /  / /_   (__  ) 
-- \____/   /_/     \___/ \__,_/   /_/   \__/  /____/  
local main = menu.add_feature("Troll Menu Credits", "parent", trollmenu_local.id)
menu.add_feature("human", "action", main.id, function(feat)
    menu.notify("Trolling Menu Developer", "human")
end)
menu.add_feature("duerccio", "action", main.id, function(feat)
    menu.notify("Trolling Menu Developer", "duerccio")
end)
menu.add_feature("ChaosOfThe4", "action", main.id, function(feat)
    menu.notify("Helped with bugs and other issues; found a cage model for \"Expanded and enhanced caging\"", "ChaosOfThe4")
end)
menu.add_feature("Puchi", "action", main.id, function(feat)
    menu.notify("Explained some lua concepts and helped with some issues encountered", "Puchi")
end)
menu.add_feature("GhostOne", "action", main.id, function(feat)
    menu.notify("Providing advice on notification colors", "GhostOne")
end)
menu.add_feature("UnknownModder", "action", main.id, function(feat)
    menu.notify("Helped with some issues encountered", "UnknownModder")
end)
menu.add_feature("Rimuru", "action", main.id, function(feat)
    menu.notify("Helped fix some features in the Troll Menu as well as helped with some other lua stuff", "Rimuru")
end)
menu.add_feature("MasterShifu", "action", main.id, function(feat)
    menu.notify("Features contributed to: Rain Stuff on Player, Stun Vehicle, Shake Camera", "MasterShifu")
end)
menu.add_feature("Bruno Mars", "action", main.id, function(feat)
    menu.notify("Gave permission to use some code from uptown lua for use in \"Set Vehicle Ablaze\" and \"Pop Tires\"", "Bruno Mars")
end)
menu.add_feature("RulyPancake the nth", "action", main.id, function(feat)
    menu.notify("Helped with general lua stuff.")
end)
menu.add_feature(player.get_player_name(player.player_id()), "action", main.id, function(feat)
    menu.notify("For using Troll Menu", player.get_player_name(player.player_id()))
end)