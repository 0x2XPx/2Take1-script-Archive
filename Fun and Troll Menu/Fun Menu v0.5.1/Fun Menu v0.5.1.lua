local natives = require("this_is_needed\\natives")
require("this_is_needed\\npc_functions")
require("this_is_needed\\outfit_functions")
require("this_is_needed\\other_functions")
require("this_is_needed\\scaleform_lib")
require("this_is_needed\\ped_list")

local fun_menu_pages = {}
fun_menu_pages["main_menu"] = menu.add_feature("Fun Menu", "parent", 0)
fun_menu_pages["festive"] = menu.add_feature("Festive Stuff", "parent", fun_menu_pages["main_menu"].id)
fun_menu_pages["ptfx_stuff"] = menu.add_feature("PTFX Stuff", "parent", fun_menu_pages["main_menu"].id)
fun_menu_pages["alert_screens"] = menu.add_feature("Alert Screens", "parent", fun_menu_pages["main_menu"].id)
fun_menu_pages["vehicle_stuff"] = menu.add_feature("Vehicle Stuff", "parent", fun_menu_pages["main_menu"].id)
fun_menu_pages["ozark_text"] = menu.add_feature("Øzark Text", "parent", fun_menu_pages["main_menu"].id)
fun_menu_pages["self_options"] = menu.add_feature("Self Options", "parent", fun_menu_pages["main_menu"].id)
fun_menu_pages["npc_stuff"] = menu.add_feature("NPC Stuff", "parent", fun_menu_pages["main_menu"].id)
fun_menu_pages["pet_menu"] = menu.add_feature("Pets", "parent", fun_menu_pages["main_menu"].id)
fun_menu_pages["miscellaneous"] = menu.add_feature("Miscellaneous", "parent", fun_menu_pages["main_menu"].id)
fun_menu_pages["player_fun_menu"] = menu.add_player_feature("Fun Menu", "parent", 0)

local settings = {
    "wandering_pet",
    "wandering_follower",
    "walk_style",
    "uppercase_ozark_text",
    "wandering_driver",
    "team_chat?"
}

local fun_menu_threads = {
    "clumsy_thread",
    "play_dead_thread",
    "animation",
    "vehicle_launch"
}

local scaleforms = {}
local blips = {}
local entities = {}

local fun_menu_ver = "Fun Menu v0.5.1"

if (not menu.is_trusted_mode_enabled(1 << 2)) then
    menu.notify("Enable the Natives trusted mode flag before using Fun Menu.")
end

event.add_event_listener('exit', function()
    for i = 1, #blipsTable do
        ui.remove_blip(blipsTable[i])
    end

    for i = 1, #entities do
        entity.set_entity_as_mission_entity(entities[i], true, true)
        entity.delete_entity(entities[i])
    end

    menu.notify("Cleaning up spawned entities and blips... Cleanup Successful. Bye!", fun_menu_ver)
end)

--    ______ ______ _____ ______ ____ _    __ ______   _____ ______ __  __ ______ ______
--   / ____// ____// ___//_  __//  _/| |  / // ____/  / ___//_  __// / / // ____// ____/
--  / /_   / __/   \__ \  / /   / /  | | / // __/     \__ \  / /  / / / // /_   / /_    
-- / __/  / /___  ___/ / / /  _/ /   | |/ // /___    ___/ / / /  / /_/ // __/  / __/    
--/_/    /_____/ /____/ /_/  /___/   |___//_____/   /____/ /_/   \____//_/    /_/       

function spawn_firework_1(x, y, z, rot_z)
    if (settings["silent_fireworks"]) then
        gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(x, y, z), v3(-1950, -960, 2) + v3(0, 0, rot_z), 0, 0x7F7497E5, player.player_id(), false, false, 100)
    else
        gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(x, y, z), v3(-1950, -960, 2) + v3(0, 0, rot_z), 0, 0x7F7497E5, player.player_id(), true, false, 100)
    end
end
local num_table = {100, 100, 200, 200, 300, 300}
menu.add_feature("Vespucci Beach Firework Show", "toggle", fun_menu_pages["festive"].id, function(feat_toggle)
    while feat_toggle.on do
        gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(math.random(-10, 10), math.random(-10, 10), 0), v3(-1950, -960, 2) + v3(0, 0, 20), 0, 0x7F7497E5, player.player_id(), true, false, num_table[math.random(1, #num_table)])

        if (math.random(1, 100) == 56) then
            spawn_firework_1(8, 8, 0, 300)
            spawn_firework_1(-8, 8, 0, 300)
            spawn_firework_1(8, -8, 0, 300)
            spawn_firework_1(-8, -8, 0, 300)
        end
        if (math.random(1, 100) == 39) then
            for i = 1, 4 do
                system.wait(100)
                spawn_firework_1(8, i + 8, 0, 300)
                spawn_firework_1(8, -i - 8, 0, 300)

            end
        end
        system.wait(math.random(2, 8) * 100)
    end
end)

menu.add_feature("Horsetrack Firework Show", "toggle", fun_menu_pages["festive"].id, function(feat_toggle)
    while feat_toggle.on do
        gameplay.shoot_single_bullet_between_coords(v3(1139, 130, 80) + v3(math.random(-10, 10), math.random(-10, 10), 0), v3(1139, 130, 80) + v3(0, 0, 20), 0, 0x7F7497E5, player.player_id(), true, false, num_table[math.random(1, #num_table)])

        if (math.random(1, 50) == 27) then
            spawn_firework_1(8, 8, 0, 300)
            spawn_firework_1(-8, 8, 0, 300)
            spawn_firework_1(8, -8, 0, 300)
            spawn_firework_1(-8, -8, 0, 300)
        end
        if (math.random(1, 150) == 67) then
            for i = 1, 4 do
                system.wait(100)
                spawn_firework_1(8, i + 8, 0, 300)
                spawn_firework_1(8, -i - 8, 0, 300)

            end
        end
        system.wait(math.random(2, 8) * 100)
    end
end)

menu.add_feature("Create a Firework Show", "toggle", fun_menu_pages["festive"].id, function(feat_toggle)
    local firework_coords = player.get_player_coords(player.player_id())
    while feat_toggle.on do
        gameplay.shoot_single_bullet_between_coords(firework_coords + v3(math.random(-10, 10), math.random(-10, 10), 0), firework_coords + v3(0, 0, 20), 0, 0x7F7497E5, player.player_id(), true, false, num_table[math.random(1, #num_table)])

        if (math.random(1, 50) == 27) then
            spawn_firework_1(8, 8, 0, 300)
            spawn_firework_1(-8, 8, 0, 300)
            spawn_firework_1(8, -8, 0, 300)
            spawn_firework_1(-8, -8, 0, 300)
        end
        if (math.random(1, 150) == 67) then
            for i = 1, 4 do
                system.wait(100)
                spawn_firework_1(8, i + 8, 0, 300)
                spawn_firework_1(8, -i - 8, 0, 300)

            end
        end
        system.wait(math.random(2, 8) * 100)
    end
end)

menu.add_feature("Give Firework Launchers to Everyone", "action", fun_menu_pages["festive"].id, function(feat_toggle)
    menu.notify("Gave everyone in current session a firework launcher.", fun_menu_ver)
    for i = 0, 31 do
        weapon.give_delayed_weapon_to_ped(player.get_player_ped(i), 0x7F7497E5, 0, true) -- Gives a firework launcher in 10ms and equips it right away
        weapon.set_ped_ammo(player.get_player_ped(i), 0x7F7497E5, 20)
        system.wait(150)
    end
end)

menu.add_feature("Give Snowballs to Everyone", "action", fun_menu_pages["festive"].id, function(feat_toggle)
    menu.notify("Gave everyone in current session snowballs.", fun_menu_ver)
    for i = 0, 31 do
        weapon.give_delayed_weapon_to_ped(player.get_player_ped(i), 0x787F0BB, 0, true) -- Gives snowballs in 10ms and equips it right away
        weapon.set_ped_ammo(player.get_player_ped(i), 0x787F0BB, 20)
        system.wait(150)
    end
end)

--    ____  ______ ______ _  __    _____ ______ __  __ ______ ______
--   / __ \/_  __// ____/| |/ /   / ___//_  __// / / // ____// ____/
--  / /_/ / / /  / /_    |   /    \__ \  / /  / / / // /_   / /_    
-- / ____/ / /  / __/   /   |    ___/ / / /  / /_/ // __/  / __/    
--/_/     /_/  /_/     /_/|_|   /____/ /_/   \____//_/    /_/       
                                                                  

--[[local ptfx_color = {
    R = 255,
    G = 100,
    B = 100
}

function hex2RGB(hex)
    hex = hex:gsub("#","")

    ptfx_color = {
        R = tonumber("0x"..hex:sub(1, 2)..".0"),
        G = tonumber("0x"..hex:sub(3, 4)..".0"),
        B = tonumber("0x"..hex:sub(5, 6)..".0"),
    }
end

menu.add_feature("PTFX Color", "action", fun_menu_pages["ptfx_stuff"].id, function(feat)
    local _input, k = input.get("Type in a hex color code.", "ffffff", 6, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        return HANDLER_POP
    end

    menu.notify("PTFX color set to " .. k, fun_menu_ver)
    hex2RGB(k)zt
end)]]--

local ptfx_loaded = false
local ptfx_executed = false

menu.add_feature("Cosmetic Bleed Out", "toggle", fun_menu_pages["ptfx_stuff"].id, function(feat_toggle)
    while (feat_toggle.on) do
        graphics.set_next_ptfx_asset("core")

        if (ptfx_loaded == false or ptfx_executed == false) then
            ptfx_loaded = requestPTFX("core")
            ptfx_executed = true
        end

        graphics.start_networked_ptfx_non_looped_on_entity("blood_stab", player.get_player_ped(player.player_id()), v3(0, 0.07, 0.3), v3(-50, 0, 0), 2)
        fire.add_explosion(player.get_player_coords(player.player_id()), 39, false, true, 0, player.player_id())
        system.wait(1000)
    end

    if (not feat_toggle.on) then
        graphics.remove_named_ptfx_asset("core")
        ptfx_loaded = false
        ptfx_executed = false
    end
end)

menu.add_feature("Bloody Mess", "toggle", fun_menu_pages["ptfx_stuff"].id, function(feat_toggle)
    while (feat_toggle.on) do
        graphics.set_next_ptfx_asset("scr_solomon3")

        if (ptfx_loaded == false or ptfx_executed == false) then
            ptfx_loaded = requestPTFX("scr_solomon3")
            ptfx_executed = true
        end
        graphics.start_networked_ptfx_non_looped_on_entity("scr_trev4_747_blood_impact", player.get_player_ped(player.player_id()), v3(0, 0, 1), v3(-90, 0, 0), 1)
        system.wait(1000)
    end

    if (not feat_toggle.on) then
        graphics.remove_named_ptfx_asset("scr_solomon3")
        ptfx_loaded = false
        ptfx_executed = false
    end
end)

menu.add_feature("Dragon Breath", "value_str", fun_menu_pages["ptfx_stuff"].id, function(feat_toggle_val)
    menu.notify("You will probably want to use godmode for this PTFX.", fun_menu_ver)
    local breath_scale = 0
    if (feat_toggle_val.value == 0) then
        breath_scale = 0.5
    elseif (feat_toggle_val.value == 1) then
        breath_scale = 2
    end

    while (feat_toggle_val.on) do
        graphics.set_next_ptfx_asset("core")

        if (ptfx_loaded == false or ptfx_executed == false) then
            ptfx_loaded = requestPTFX("core")
            ptfx_executed = true;
        end
        graphics.start_networked_ptfx_non_looped_on_entity("ent_sht_flame", player.get_player_ped(player.player_id()), v3(0, 0.07, 0.625), v3(-90, 0, 0), breath_scale)
        system.wait(7700)
    end

    if (not feat_toggle_val.on) then
        graphics.remove_named_ptfx_asset("core")
        ptfx_loaded = false
        ptfx_executed = false
    end
end):set_str_data({"Little Breath", "Big Breath"})

menu.add_feature("Trails", "toggle", fun_menu_pages["ptfx_stuff"].id, function(feat_toggle)
    while (feat_toggle.on) do
        local success, head_pos = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 31086, v3())
        while not success do
            success, head_pos = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 31086, v3())
            system.wait(10)
        end

        graphics.set_next_ptfx_asset("scr_powerplay")

        if (ptfx_loaded == false or ptfx_executed == false) then
            ptfx_loaded = requestPTFX("scr_powerplay")
            ptfx_executed = true
        end --v3(0, 0.07, 0.625)
        graphics.start_networked_ptfx_non_looped_on_entity("sp_powerplay_beast_appear_trails", player.get_player_ped(player.player_id()), v3(0, 0.07, 0.625), v3(-90, 0, 0), 1.5)
        --graphics.start_networked_ptfx_non_looped_at_coord("sp_powerplay_beast_appear_trails", head_pos, v3(), 1.5, false, false, false)
        system.wait(500)
    end

    if (not feat_toggle.on) then
        graphics.remove_named_ptfx_asset("scr_powerplay")
        ptfx_loaded = false
        ptfx_executed = false
    end
end)

--    ___     __     ______ ____  ______   _____  ______ ____   ______ ______ _   __ _____
--   /   |   / /    / ____// __ \/_  __/  / ___/ / ____// __ \ / ____// ____// | / // ___/
--  / /| |  / /    / __/  / /_/ / / /     \__ \ / /    / /_/ // __/  / __/  /  |/ / \__ \ 
-- / ___ | / /___ / /___ / _, _/ / /     ___/ // /___ / _, _// /___ / /___ / /|  / ___/ / 
--/_/  |_|/_____//_____//_/ |_| /_/     /____/ \____//_/ |_|/_____//_____//_/ |_/ /____/  
                                                                                        
menu.add_feature("Alert Screen", 'value_str', fun_menu_pages["alert_screens"].id, function(feat_toggle_val)
    local screens = {
        "You have been banned from Grand Theft Auto Online permanently.",
        "You're attempting to access GTA Online servers with an altered version of the game.",
        "There has been an error with this session.",
        "You have been suspended from Grand Theft Auto Online Online until ".. os.date("%m/%d/%Y", os.time() + 2700000) ..". \nIn addition, your Grand Theft Auto Online characters(s) will be reset."
    }

    scaleforms["alert_screen"] = graphics.request_scaleform_movie("POPUP_WARNING")
    while feat_toggle_val.on do
        show_alert_screen(scaleforms["alert_screen"], 500.0, "alert", screens[feat_toggle_val.value+1], "Return to Grand Theft Auto V.", true, 0, "")
        graphics.draw_scaleform_movie_fullscreen(scaleforms["alert_screen"], 255, 255, 255, 255, 0)
        system.wait(0)
    end

    if (not feat_toggle_val.on) then
        graphics.set_scaleform_movie_as_no_longer_needed(scaleforms["alert_screen"])
    end
end):set_str_data({"Banned", "Altered Game", "Session Error", "Suspended"})

menu.add_feature("Set # Value for Alert", 'value_str', fun_menu_pages["alert_screens"].id, function(feat_toggle_val)
    local _input, k = input.get("Type in custom number value for use in some alert screens.", "-9999", 999, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        feat_toggle_val.on = false
        return HANDLER_POP
    end

    local numerical_screens = {
        "Rockstar Game Services have corrected your GTA Dollars by $".. k .. ".",
        "Congratulations, you have been awarded $ " .. k .. ".",
        "Rockstar Game Services have corrected your RP levels to " .. k .. "RP.",
    }

    scaleforms["alert_screen"] = graphics.request_scaleform_movie("POPUP_WARNING")
    while feat_toggle_val.on do
        show_alert_screen(scaleforms["alert_screen"], 500.0, "alert", numerical_screens[feat_toggle_val.value+1], "", true, 0, "")
        graphics.draw_scaleform_movie_fullscreen(scaleforms["alert_screen"], 255, 255, 255, 255, 0)
        system.wait(0)
    end

    if (not feat_toggle_val.on) then
        graphics.set_scaleform_movie_as_no_longer_needed(scaleforms["alert_screen"])
    end
end):set_str_data({"Money Correct", "Money Awarded", "RP Correct"})

menu.add_feature("Custom Alert Screen", 'toggle', fun_menu_pages["alert_screens"].id, function(feat_toggle)
    local _input, k = input.get("Type in alert screen text", "", 999, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        feat_toggle.on = false
        return HANDLER_POP
    end

    scaleforms["alert_screen"] = graphics.request_scaleform_movie("POPUP_WARNING")
    while feat_toggle.on do
        show_alert_screen(scaleforms["alert_screen"], 500.0, "alert", k, "", true, 0, "")
        graphics.draw_scaleform_movie_fullscreen(scaleforms["alert_screen"], 255, 255, 255, 255, 0)
        system.wait(0)
    end

    if (not feat_toggle.on) then
        graphics.set_scaleform_movie_as_no_longer_needed(scaleforms["alert_screen"])
    end
end)

menu.add_feature("Ban Screen with Custom Reason", 'toggle', fun_menu_pages["alert_screens"].id, function(feat_toggle)
    local _input, k = input.get("Type in ban reason text", "", 999, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        feat_toggle.on = false
        return HANDLER_POP
    end

    scaleforms["alert_screen"] = graphics.request_scaleform_movie("POPUP_WARNING")
    while feat_toggle.on do
        show_alert_screen(scaleforms["alert_screen"], 500.0, "alert", "You have been banned from Grand Theft Auto Online permanently.", "Reason: " .. k .. "\nReturn to Grand Theft Auto V.", true, 0, "")
        graphics.draw_scaleform_movie_fullscreen(scaleforms["alert_screen"], 255, 255, 255, 255, 0)
        system.wait(0)
    end

    if (not feat_toggle.on) then
        graphics.set_scaleform_movie_as_no_longer_needed(scaleforms["alert_screen"])
    end
end)

menu.add_feature("Get Color Codes", "action", fun_menu_pages["alert_screens"].id, function(feat)
    menu.notify("~r~ = Red\n~o~ = Orange\n~y~ = Yellow\n~g~ = Green\n~b~ = Blue\n~p~ = Purple\n~q~ = Pink\n~w~ or ~s~ = White\n~c~ or ~t~ = Gray\n~m~ = Dark Gray\n~u~ or ~l~ = Black\n\n\z
    Type the color codes into the input boxes for the alert screens and you will get colored text.", fun_menu_ver.. " | Color Codes")
end)

-- _    __ ______ __  __ ____ ______ __     ______   _____ ______ __  __ ______ ______
--| |  / // ____// / / //  _// ____// /    / ____/  / ___//_  __// / / // ____// ____/
--| | / // __/  / /_/ / / / / /    / /    / __/     \__ \  / /  / / / // /_   / /_    
--| |/ // /___ / __  /_/ / / /___ / /___ / /___    ___/ / / /  / /_/ // __/  / __/    
--|___//_____//_/ /_//___/ \____//_____//_____/   /____/ /_/   \____//_/    /_/       

fun_menu_pages["angry_vehicles_stuff"] = menu.add_feature("Angry Vehicles", "parent", fun_menu_pages["vehicle_stuff"].id)
fun_menu_pages["ai_flying_stuff"] = menu.add_feature("Airplane Chauffer", "parent", fun_menu_pages["vehicle_stuff"].id)
fun_menu_pages["ai_driving_stuff"] = menu.add_feature("Limo Chauffer", "parent", fun_menu_pages["vehicle_stuff"].id)
fun_menu_pages["personal_vehicle_stuff"] = menu.add_feature("Player Vehicle Mods", "parent", fun_menu_pages["vehicle_stuff"].id)

-- /// ANGRY PLANES /// --
local planes = {}

local angry_vehicles_count = menu.add_feature("Angry Vehicle Count", 'autoaction_value_i', fun_menu_pages["angry_vehicles_stuff"].id)
angry_vehicles_count.min = 1
angry_vehicles_count.max = 50
angry_vehicles_count.mod = 1
angry_vehicles_count.value = 10

menu.add_feature("Angry Planes", "toggle", fun_menu_pages["angry_vehicles_stuff"].id, function(feat_toggle)
    local spawned_planes = {}
    local spawned_pilots = {}
    local player_coords
    local plane
    local pilot

    local planes = {
        "alphaz1", "howard", "molotok", "starling", "velum2", "vestra", "velum", "tula", "stunt", "strikeforce",
        "seabreeze", "rogue", "pyro", "nokota", "mammatus", "duster", "dodo", "cuban800", "besra"
    }
    
    for i = 1, #planes do
        requestModel(gameplay.get_hash_key(planes[i]))
    end
    requestModel(gameplay.get_hash_key("s_m_y_blackops_01"))

    if (feat_toggle.on) then
        local pos = player.get_player_coords(player.player_id()) + v3(math.random(-100, 100), math.random(-100, 100), 150 + math.random(0, 20))
        fun_menu_threads["update_coords"] = menu.create_thread(function()
            while (feat_toggle.on) do
                player_coords = player.get_player_coords(player.player_id())
                system.wait(100)
            end
        end, nil)

        for i = 1, angry_vehicles_count.value do
            if (#spawned_planes < angry_vehicles_count.value) then
                random_plane = math.random(1, #planes)
                system.wait(500)

                plane = vehicle.create_vehicle(gameplay.get_hash_key(planes[random_plane]), pos, math.random(-180, 180), true, false)
                pilot = ped.create_ped(5, gameplay.get_hash_key("s_m_y_blackops_01"), pos, 165, true, false)
                streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(planes[random_plane]))

                spawned_planes[#spawned_planes + 1] = plane
                spawned_pilots[#spawned_pilots + 1] = pilot
                entities[#entities + 1] = spawned_planes[i]
                entities[#entities + 1] = spawned_pilots[i]
                
                ped.set_ped_into_vehicle(pilot, plane, -1)
                vehicle.set_vehicle_engine_on(plane, true, true, false)
                vehicle.set_vehicle_forward_speed(plane, 50.0)
                vehicle.control_landing_gear(plane, 3)
                ped.set_ped_combat_attributes(pilot, 1, true)
                ai.task_vehicle_drive_to_coord(pilot, plane, player_coords + v3(0, 0, math.random(0, 50)), 100.0, -1, gameplay.get_hash_key(planes[random_plane]), 0, 0.0, 1.0)
                --ai.task_vehicle_follow(pilot, plane, player.get_player_ped(player.player_id()), 30, 786859, 30)
            end
        end
    end

    if (not feat_toggle.on) then
        for i = 1, #spawned_planes do
            requestControl(spawned_planes[i])
            entity.delete_entity(spawned_planes[i])
        end
        for i = 1, #spawned_pilots do
            requestControl(spawned_pilots[i])
            entity.delete_entity(spawned_pilots[i])
        end

        for i = 1, #planes do
            streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(planes[i]))
        end
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("s_m_y_blackops_01"))
        menu.delete_thread(fun_menu_threads["update_coords"])

        spawned_planes = {}
        spawned_pilots = {}
    end
end)

menu.add_feature("Helicopter Madness", "toggle", fun_menu_pages["angry_vehicles_stuff"].id, function(feat_toggle)
    local spawned_helicopters = {}
    local spawned_pilots = {}
    local helicopter
    local pilot

    local helicopters = {
        "seasparrow2", "supervolito", "volatus", "annihilator2", "swift2", "swift", "supervolito2", "frogger", "havok", "hunter",
        "maverick", "savage", "akula", "buzzard", "annihilator"
    }
    
    for i = 1, #helicopters do
        requestModel(gameplay.get_hash_key(helicopters[i]))
    end
    requestModel(gameplay.get_hash_key("s_m_y_blackops_01"))

    if (feat_toggle.on) then
        local pos = player.get_player_coords(player.player_id()) + v3(math.random(-100, 100), math.random(-100, 100), 150 + math.random(0, 20))
        for i = 1, angry_vehicles_count.value do
            if (#spawned_helicopters < angry_vehicles_count.value) then
                random_helicopter = math.random(1, #helicopters)
                system.wait(500)

                helicopter = vehicle.create_vehicle(gameplay.get_hash_key(helicopters[random_helicopter]), pos, math.random(-180, 180), true, false)
                entity.set_entity_god_mode(helicopter, true)
                pilot = ped.create_ped(5, gameplay.get_hash_key("s_m_y_blackops_01"), pos, 165, true, false)
                streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(helicopters[random_helicopter]))

                spawned_helicopters[#spawned_helicopters + 1] = helicopter
                spawned_pilots[#spawned_pilots + 1] = pilot
                
                ped.set_ped_into_vehicle(pilot, helicopter, -1)
                vehicle.set_vehicle_engine_on(helicopter, true, true, false)
                vehicle.set_vehicle_forward_speed(helicopter, 50.0)
                vehicle.control_landing_gear(helicopter, 3)
                ped.set_ped_combat_attributes(pilot, 1, true)
                --ai.task_vehicle_drive_to_coord(pilot, helicopter, player.get_player_coords(player.player_id()) + v3(0, 0, math.random(0, 50)), 100.0, -1, gameplay.get_hash_key(helicopters[random_helicopter]), 0, 0.0, 1.0)
                ai.task_vehicle_follow(pilot, helicopter, player.get_player_ped(player.player_id()), 30, 786859, 30)

                entities[#entities + 1] = spawned_helicopters[i]
                entities[#entities + 1] = spawned_pilots[i]
            end
        end
    end

    if (not feat_toggle.on) then
        for i = 1, #spawned_helicopters do
            requestControl(spawned_helicopters[i])
            entity.delete_entity(spawned_helicopters[i])
        end
        for i = 1, #spawned_pilots do
            requestControl(spawned_pilots[i])
            entity.delete_entity(spawned_pilots[i])
        end

        for i = 1, #helicopters do
            streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(helicopters[i]))
        end
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("s_m_y_blackops_01"))

        spawned_helicopters = {}
        spawned_pilots = {}
    end
end)

local player_plane = player.get_player_vehicle(player.player_id())
local waypoint
local pilot1
local pilot2
local coords

menu.add_feature("Repair Current Plane", "toggle", fun_menu_pages["ai_flying_stuff"].id, function(feat_toggle)
    vehicle.set_vehicle_fixed(player_plane)
    vehicle.set_vehicle_engine_health(player_plane, 1000.0)
    system.wait(10000)
end)

menu.add_feature("Auto Reroute to Current Waypoint", "toggle", fun_menu_pages["ai_flying_stuff"].id, function(feat_toggle)
    while (feat_toggle.on) do
        waypoint = ui.get_waypoint_coord()

        menu.notify("Rerouting to...\nX = " .. waypoint.x .. "\nY = " .. waypoint.y, fun_menu_ver)
        coords = v3(waypoint.x, waypoint.y, 100)
        system.wait(10000)
    end
end)

menu.add_feature("Manually Reroute to Current Waypoint", "action", fun_menu_pages["ai_flying_stuff"].id, function(feat)
    if (not player.is_player_in_any_vehicle(player.player_id()) and not vehicle.is_vehicle_model(player_plane, 0xB2CF7250)) then -- nimbus
        menu.notify("Wrong vehicle type.", fun_menu_ver)
    else
        waypoint = ui.get_waypoint_coord()
        
        menu.notify("Rerouting to...\nX = " .. waypoint.x .. "\nY = " .. waypoint.y, fun_menu_ver)
        coords = v3(waypoint.x, waypoint.y, 100)
    end
end)

local height_above_waypoint = menu.add_feature("Flying Height", 'autoaction_value_i', fun_menu_pages["ai_flying_stuff"].id)
height_above_waypoint.min = 100
height_above_waypoint.max = 300
height_above_waypoint.mod = 10
height_above_waypoint.value = 200

local destinations = menu.add_feature("Destinations", 'parent', fun_menu_pages["ai_flying_stuff"].id)
menu.add_feature("Diamond Casino & Resort", "action", destinations.id, function(feat)
    waypoint = ui.set_new_waypoint(v2(1038.944, 64.978))
    menu.notify("Destination: Diamond Casino & Resort", fun_menu_ver)
end)
menu.add_feature("Los Santos International Airport", "action", destinations.id, function(feat)
    waypoint = ui.set_new_waypoint(v2(-1187.151, -3039.150))
    menu.notify("Destination: Los Santos International Airport", fun_menu_ver)
end)

menu.add_feature("Start Flying", "toggle", fun_menu_pages["ai_flying_stuff"].id, function(feat_toggle)
    waypoint = ui.get_waypoint_coord()
    player_plane = player.get_player_vehicle(player.player_id())
    coords = v3(waypoint.x, waypoint.y, 100)

    if (not vehicle.is_vehicle_model(player_plane, 0xB2CF7250)) then -- nimbus
        menu.notify("Wrong vehicle type.", fun_menu_ver)
        feat_toggle.on = false
    elseif (vehicle.is_vehicle_model(player_plane, 0xB2CF7250)) then
        requestControl(player_plane)
        ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), player_plane, math.random(1, 6))

        requestModel(gameplay.get_hash_key("s_m_y_blackops_01"))
        pilot1 = ped.create_ped(5, gameplay.get_hash_key("s_m_y_blackops_01"), player.get_player_coords(player.player_id()), 165, true, false)
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("s_m_y_blackops_01"))
        requestControl(pilot1)
        ped.set_ped_into_vehicle(pilot1, player_plane, -1)
        pilot2 = ped.create_ped(5, gameplay.get_hash_key("s_m_y_blackops_01"), player.get_player_coords(player.player_id()), 165, true, false)
        ped.set_ped_into_vehicle(pilot2, player_plane, 0)

        entity.set_entity_coords_no_offset(player_plane, player.get_player_coords(player.player_id()) + v3(0, 0, 200))
        vehicle.set_vehicle_engine_on(player_plane, true, true, false)
        vehicle.set_vehicle_forward_speed(player_plane, 50.0)
        vehicle.control_landing_gear(player_plane, 3)

        while(feat_toggle.on) do
            ai.task_vehicle_drive_to_coord(pilot1, player_plane, coords + v3(0, 0, height_above_waypoint.value or 200), 35.0, -1, player_plane, 0, 0.0, 1.0)
            system.wait(500)
        end
    end

    if (not feat_toggle.on) then
        if (not vehicle.is_vehicle_model(player_plane, 0xB2CF7250)) then -- nimbus
            menu.notify("Wrong vehicle type.", fun_menu_ver)
        elseif (vehicle.is_vehicle_model(player_plane, 0xB2CF7250)) then
            entity.set_entity_as_mission_entity(pilot1, true, true)
            entity.delete_entity(pilot1)
            entity.set_entity_as_mission_entity(pilot2, true, true)
            entity.delete_entity(pilot2)
            ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), player_plane, -1)
        end
    end
end)

local player_vehicle
local driver
local coords2

menu.add_feature("Auto Reroute to Current Waypoint", "toggle", fun_menu_pages["ai_driving_stuff"].id, function(feat_toggle)
    while (feat_toggle.on) do
        waypoint = ui.get_waypoint_coord()

        menu.notify("Rerouting to...\nX = " .. waypoint.x .. "\nY = " .. waypoint.y, fun_menu_ver)
        coords2 = v3(waypoint.x, waypoint.y, 100)
        system.wait(10000)
    end
end)

menu.add_feature("Manually Reroute to Current Waypoint", "action", fun_menu_pages["ai_driving_stuff"].id, function(feat)
    if (not player.is_player_in_any_vehicle(player.player_id()) and not vehicle.is_vehicle_model(player_vehicle, 0xE6E967F8)) then -- nimbus
        menu.notify("Wrong vehicle type.", fun_menu_ver)
    else
        waypoint = ui.get_waypoint_coord()
        
        menu.notify("Rerouting to...\nX = " .. waypoint.x .. "\nY = " .. waypoint.y, fun_menu_ver)
        coords2 = v3(waypoint.x, waypoint.y, 100)
    end
end)

menu.add_feature("Wandering Driver", "toggle", fun_menu_pages["ai_driving_stuff"].id, function(feat_toggle)
    settings["wandering_driver"] = feat_toggle.on
end)

menu.add_feature("Start Driving", "toggle", fun_menu_pages["ai_driving_stuff"].id, function(feat_toggle)
    waypoint = ui.get_waypoint_coord()
    player_vehicle = player.get_player_vehicle(player.player_id())
    coords2 = v3(waypoint.x, waypoint.y, 100)

    if (not vehicle.is_vehicle_model(player_vehicle, 0xE6E967F8)) then -- nimbus
        menu.notify("Wrong vehicle type.", fun_menu_ver)
        feat_toggle.on = false
    elseif (vehicle.is_vehicle_model(player_vehicle, 0xE6E967F8)) then
        requestControl(player_vehicle)
        ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), player_vehicle, math.random(1, 4))

        requestModel(gameplay.get_hash_key("s_m_y_blackops_01"))
        driver = ped.create_ped(5, gameplay.get_hash_key("s_m_y_blackops_01"), player.get_player_coords(player.player_id()), 165, true, false)
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("s_m_y_blackops_01"))
        requestControl(driver)
        ped.set_ped_into_vehicle(driver, player_vehicle, -1)

        vehicle.set_vehicle_engine_on(player_vehicle, true, true, false)

        while(feat_toggle.on) do
            if (settings["wandering_driver"]) then
                ai.task_vehicle_drive_wander(driver, player_vehicle, 25.0, 786859)
            else
                ai.task_vehicle_drive_to_coord(driver, player_vehicle, coords2, 25.0, -1, player_vehicle, 786859, 1, 1.0)
            end
            system.wait(500)
        end
    end

    if (not feat_toggle.on) then
        if (not vehicle.is_vehicle_model(player_vehicle, 0xE6E967F8)) then -- nimbus
            menu.notify("Wrong vehicle type.", fun_menu_ver)
        elseif (vehicle.is_vehicle_model(player_vehicle, 0xE6E967F8)) then
            entity.set_entity_as_mission_entity(driver, true, true)
            entity.delete_entity(driver)
            ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), player_vehicle, -1)
        end
    end
end)

menu.add_feature("No Traction", "toggle", fun_menu_pages["personal_vehicle_stuff"].id, function(feat_toggle)
    local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

    while (feat_toggle.on) do
        if (not player.is_player_in_any_vehicle(player.player_id())) then
            menu.notify("You need to be in a vehicle to use \"No Traction\".", fun_menu_ver)
            feat_toggle.on = false
        end
        vehicle.set_vehicle_reduce_grip(player_veh, true)
        system.wait(1000)
    end

    if (not feat_toggle.on) then
        vehicle.set_vehicle_reduce_grip(player_veh, false)
    end
end)

menu.add_feature("Custom Vehicle Color", "action", fun_menu_pages["personal_vehicle_stuff"].id, function(feat)
    local _input, k = input.get("Type in a hex color code.", "ffffff", 6, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        return HANDLER_POP
    end

    local player_veh = player.get_player_vehicle(player.player_id())
    requestControl(player_veh)

    menu.notify("Vehicle color set to " .. k:sub(1, 6), fun_menu_ver, 10, "0x"..k:sub(5, 6)..k:sub(3, 4)..k:sub(1, 2))
    vehicle.set_vehicle_custom_primary_colour(player_veh, tonumber("0x" .. k))
    vehicle.set_vehicle_custom_secondary_colour(player_veh, tonumber("0x" .. k))
    --vehicle.set_vehicle_custom_pearlescent_colour(vehicles[i], RGBToInt(255, 70, 160))
    --vehicle.set_vehicle_custom_wheel_colour(Vehicle veh, uint32_t color)
end)

--[[menu.add_feature("Get Vehicle Colors", "action", fun_menu_pages["personal_vehicle_stuff"].id, function(feat)
    local player_veh = player.get_player_vehicle(player.player_id())
    local veh_colors = {
        color_primary = vehicle.get_vehicle_primary_color(player_veh)
        color_secondary = vehicle.get_vehicle_secondary_color(player_veh)
        color_pearl = vehicle.get_vehicle_pearlecent_color(player_veh)
        color_wheel = vehicle.get_vehicle_wheel_color(player_veh)
    }
    menu.notify("Primary: " .. tostring(veh_colors["color_primary"]) .. "\nSecondary: " .. tostring(veh_colors["color_secondary"]) .. "\nPearlescent: " .. tostring(veh_colors["color_pearl"]) .. "\nWheel: " .. tostring(veh_colors["color_wheel"]))
end)]]--

menu.add_feature("Modded Chrome Color", "action", fun_menu_pages["personal_vehicle_stuff"].id, function(feat)
    local player_veh = player.get_player_vehicle(player.player_id())
    local _input, k = input.get("Type in a hex color code.", "ffffff", 6, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        return HANDLER_POP
    end
    vehicle.set_vehicle_colors(player_veh, 120, 120)
    vehicle.set_vehicle_extra_colors(player_veh, 120, 120)
    system.wait(200)

    menu.notify("Vehicle color set to " .. k:sub(1, 6), fun_menu_ver, 10, "0x"..k:sub(5, 6)..k:sub(3, 4)..k:sub(1, 2))

    vehicle.set_vehicle_custom_primary_colour(player_veh, tonumber("0x" .. k))
    vehicle.set_vehicle_custom_secondary_colour(player_veh, tonumber("0x" .. k))
    vehicle.set_vehicle_custom_pearlescent_colour(player_veh, tonumber("0x" .. k))
    vehicle.set_vehicle_custom_wheel_colour(player_veh, tonumber("0x" .. k))
end)

menu.add_feature("Unchrome Vehicle", "action", fun_menu_pages["personal_vehicle_stuff"].id, function(feat)
    local player_veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_colors(player_veh, 0, 0)
    vehicle.set_vehicle_extra_colors(player_veh, 0, 0)
end)

menu.add_feature("Fast Rainbow", "toggle", fun_menu_pages["personal_vehicle_stuff"].id, function(feat_toggle)
    local player_veh = player.get_player_vehicle(player.player_id())
    while feat_toggle.on do
        local speed = math.floor(entity.get_entity_speed(player_veh)) * 2.23694
        ui.draw_text(speed, v2(0.2, 0.2))
        local r, g, b = rainbowRGB(speed / 10)
        vehicle.set_vehicle_custom_primary_colour(player_veh, RGBToInt(r, g, b))
        system.wait()
    end
end)

menu.add_feature("Jump", "action_value_str", fun_menu_pages["personal_vehicle_stuff"].id, function(feat_val)
    local jump_heights = {3, 6, 10}
    local player_veh = player.get_player_vehicle(player.player_id())
    
    requestControl(player_veh)
    local existing_velocity = entity.get_entity_velocity(player_veh)
    entity.set_entity_velocity(player_veh, v3(existing_velocity.x, existing_velocity.y, jump_heights[feat_val.value+1]))
end):set_str_data({"Low Jump", "Medium Jump", "High Jump"})

menu.add_feature("Spin", "toggle", fun_menu_pages["personal_vehicle_stuff"].id, function(feat_toggle)
    local player_veh = player.get_player_vehicle(player.player_id())
    
    requestControl(player_veh)
    while (feat_toggle.on) do
        if (not player.is_player_in_any_vehicle(player.player_id())) then
            menu.notify("You need to be in a vehicle to use \"Spin\".", fun_menu_ver)
            feat_toggle.on = false
        end

        for i = -180, 180 do
            entity.set_entity_heading(player_veh, i)
            system.wait(0)
        end
    end
end)

seat_swapping = menu.add_feature("Change Vehicle Seat", "autoaction_value_i", fun_menu_pages["personal_vehicle_stuff"].id, function(feat)
    if (player.is_player_in_any_vehicle(player.player_id())) then
        ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), player.get_player_vehicle(player.player_id()), feat.value)
        seat_swapping.max = vehicle.get_vehicle_model_number_of_seats(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) - 2
    else
        menu.notify("You're not in a vehicle!", "")
    end
end)
seat_swapping.max = -1
seat_swapping.min = -1
seat_swapping.value = -1

menu.add_feature("Alter Traffic Color", "value_str", fun_menu_pages["vehicle_stuff"].id, function(feat_toggle_val)
    local vehicles
    while (feat_toggle_val.on) do
        vehicles = vehicle.get_all_vehicles()
        fun_menu_threads["alter_traffic_color"] = menu.create_thread(function()
            while (feat_toggle_val.on) do
                for i = 1, #vehicles do
                    requestControl(vehicles[i])
                    if (feat_toggle_val.value == 0) then
                        vehicle.set_vehicle_custom_primary_colour(vehicles[i], RGBToInt(255, 70, 160))
                        vehicle.set_vehicle_custom_secondary_colour(vehicles[i], RGBToInt(255, 70, 160))
                        vehicle.set_vehicle_custom_pearlescent_colour(vehicles[i], RGBToInt(255, 70, 160))
                    elseif (feat_toggle_val.value == 1) then
                        vehicle.set_vehicle_custom_primary_colour(vehicles[i], RGBToInt(0, 0, 0))
                        vehicle.set_vehicle_custom_secondary_colour(vehicles[i], RGBToInt(0, 0, 0))
                        vehicle.set_vehicle_custom_pearlescent_colour(vehicles[i], RGBToInt(0, 0, 0)) 
                    end
                end
                system.wait(500)
            end
        end, nil)
        system.wait(500)
        menu.delete_thread(fun_menu_threads["alter_traffic_color"])
    end

    if (not feat_toggle_val.on) then
		if fun_menu_threads["alter_traffic_color"] then
			menu.delete_thread(fun_menu_threads["alter_traffic_color"])
		end
	end
end):set_str_data({"AHAIRDRESSERSCAR", "IWANTITPAINTEDBLACK"})

menu.add_feature("Custom Traffic Color", "toggle", fun_menu_pages["vehicle_stuff"].id, function(feat_toggle)
    local vehicles
    local _input, k = input.get("Type in a hex color code.", "ffffff", 6, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        feat_toggle.on = false
        return HANDLER_POP
    end

    while (feat_toggle.on) do
        vehicles = vehicle.get_all_vehicles()
        fun_menu_threads["custom_traffic_color"] = menu.create_thread(function()
            while (feat_toggle.on) do
                for i = 1, #vehicles do
                    requestControl(vehicles[i])
                    vehicle.set_vehicle_custom_primary_colour(vehicles[i], tonumber("0x" .. k))
                    vehicle.set_vehicle_custom_secondary_colour(vehicles[i], tonumber("0x" .. k))
                end
                system.wait(500)
            end
        end, nil)
        system.wait(500)
        menu.delete_thread(fun_menu_threads["custom_traffic_color"])
    end

    if (not feat_toggle.on) then
		if fun_menu_threads["custom_traffic_color"] then
			menu.delete_thread(fun_menu_threads["custom_traffic_color"])
		end
	end
end)

menu.add_feature("Crazy Vehicles", "value_str", fun_menu_pages["vehicle_stuff"].id, function(feat_toggle_val)
    local vehicles
    while (feat_toggle_val.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            if (vehicles[i] ~= ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))) then
                requestControl(vehicles[i])
                local driver = vehicle.get_ped_in_vehicle_seat(vehicles[i], -1)
                requestControl(driver)
                
                if (feat_toggle_val.value == 0) then
                    ai.task_vehicle_drive_wander(driver, vehicles[i], 50.0, 1024)
                elseif (feat_toggle_val.value == 1) then
                    vehicle.set_vehicle_reduce_grip(vehicles[i], true)
                    ai.task_vehicle_drive_wander(driver, vehicles[i], 100.0, 4981308)
                end
            end
        end
        system.wait(10)
    end

    if (not feat_toggle_val.on) then
        for i = 1, #vehicles do
            vehicle.set_vehicle_reduce_grip(vehicles[i], false)
        end
    end
        
end):set_str_data({"v1", "v2"})

menu.add_feature("Vehicles Leak Oil", "toggle", fun_menu_pages["vehicle_stuff"].id, function(feat_toggle_val)
    local vehicles
    while (feat_toggle_val.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            requestControl(vehicles[i])
            vehicle.set_vehicle_engine_torque_multiplier_this_frame(vehicles[i], math.random(1.0, 10.0))
            fire.add_explosion(entity.get_entity_coords(vehicles[i]), 67, false, false, 0, player.player_id())
            system.wait(10)
        end
    end
end)

menu.add_feature("Launch Random Vehicles", "toggle", fun_menu_pages["vehicle_stuff"].id, function(feat_toggle)
    local vehicles
    while (feat_toggle.on) do
        vehicles = vehicle.get_all_vehicles()
        fun_menu_threads["launch_random_vehicles_req_control"] = menu.create_thread(function()
            while (feat_toggle.on) do
                for i = 1, #vehicles do
                    requestControl(vehicles[i])
                    entity.set_entity_velocity(vehicles[i], v3(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180)))
                end
                system.wait(500)
            end
        end, nil)
        system.wait(500)
        menu.delete_thread(fun_menu_threads["launch_random_vehicles_req_control"])
    end

    if (not feat_toggle.on) then
        if fun_menu_threads["launch_random_vehicles_req_control"] then
            menu.delete_thread(fun_menu_threads["launch_random_vehicles_req_control"])
        end
    end
end)

menu.add_feature("Anti-Gravity Vehicles", "toggle", fun_menu_pages["vehicle_stuff"].id, function(feat_toggle)
    local vehicles
    while (feat_toggle.on) do
        vehicles = vehicle.get_all_vehicles()
        fun_menu_threads["anti_gravity_vehicles"] = menu.create_thread(function()
            while (feat_toggle.on) do
                for i = 1, #vehicles do
                    requestControl(vehicles[i])
                    vehicle.set_vehicle_gravity_amount(vehicles[i], 0.0)
                    entity.set_entity_velocity(vehicles[i], v3(0, 0, 1))
                end
                system.wait(500)
            end
        end, nil)
        system.wait(500)
        menu.delete_thread(fun_menu_threads["anti_gravity_vehicles"])
    end

    if (not feat_toggle.on) then
		if fun_menu_threads["anti_gravity_vehicles"] then
			menu.delete_thread(fun_menu_threads["anti_gravity_vehicles"])
		end
	end
end)

menu.add_feature("Bouncing Vehicles", "value_str", fun_menu_pages["vehicle_stuff"].id, function(feat_toggle_val)
    local jump_heights = {3, 6, 10}
    local vehicles
    while (feat_toggle_val.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            requestControl(vehicles[i])
            local existing_velocity = entity.get_entity_velocity(vehicles[i])
            entity.set_entity_velocity(vehicles[i], v3(existing_velocity.x, existing_velocity.y, jump_heights[feat_toggle_val.value+1]))
            system.wait(25)
        end
    end
end):set_str_data({"Low Jump", "Medium Jump", "High Jump"})

-- Thanks Proddy
menu.add_feature("Vehicle Magnet Gun", "toggle", fun_menu_pages["vehicle_stuff"].id, function(feat_toggle)
	while feat_toggle.on do
		if player.is_player_free_aiming(player.player_id()) then
			local offset = getOffsetFromCam(30)
			local vehicles = getAllVehiclesInPlayerRange(player.player_id(), 140)
			local r, g, b = rainbowRGB(10)
			graphics.draw_marker(28, offset, v3(0, 90, 0), v3(0, 90, 0), v3(0.5, 0.5, 0.5), r, g, b, 35, false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
			local myVeh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
			for i = 1, #vehicles do
				local veh = vehicles[i]
				if veh ~= myVeh and requestControl(veh) then
					local vehPos = entity.get_entity_coords(veh)
					local vect = v3(offset.x, offset.y, offset.z)
					vect = vect - vehPos
                    vect = vect * 1
                    entity.apply_force_to_entity(veh, 1, vect.x, vect.y, vect.z, 0, 0, 0.5, false, true)
				end
			end
		end
		system.wait()
	end
end)

--   ____  _____    ___     ____   __ __    ______ ______ _  __ ______
--  / __ \/__  /   /   |   / __ \ / //_/   /_  __// ____/| |/ //_  __/
-- / / / /  / /   / /| |  / /_/ // ,<       / /  / __/   |   /  / /   
--/ /_/ /  / /__ / ___ | / _, _// /| |     / /  / /___  /   |  / /    
--\____/  /____//_/  |_|/_/ |_|/_/ |_|    /_/  /_____/ /_/|_| /_/     
                                                                    
local oz_txt_color = {
    R1 = 255,
    G1 = 100,
    B1 = 100,
    A1 = 255
}
local oz_txt_color_F4 = {
    R2 = 255,
    G2 = 255,
    B2 = 255,
    A2 = 175
}

function ozarkTextRGB(hex)
    hex = hex:gsub("#","")

    oz_txt_color = {
        R1 = tonumber("0x"..hex:sub(1, 2)),
        G1 = tonumber("0x"..hex:sub(3, 4)),
        B1 = tonumber("0x"..hex:sub(5, 6)),
        A1 = hex:sub(8, 10)
    }
end
function ozarkTextRGB_F4(hex)
    hex = hex:gsub("#","")
    oz_txt_color_F4 = {
        R2 = tonumber("0x"..hex:sub(1, 2)),
        G2 = tonumber("0x"..hex:sub(3, 4)),
        B2 = tonumber("0x"..hex:sub(5, 6)),
        A2 = hex:sub(8, 10)
    }
end

menu.add_feature("Øzark Text Color", "action", fun_menu_pages["ozark_text"].id, function(feat)
    local _input, k = input.get("Type in a hex color code.", "ffffff 175", 10, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        return HANDLER_POP
    end

    menu.notify("Color set to " .. k:sub(1, 6) .. " with alpha value of " .. k:sub(8, 10), fun_menu_ver, 10, "0x"..k:sub(5, 6)..k:sub(3, 4)..k:sub(1, 2))
    ozarkTextRGB_F4(k)
end)

menu.add_feature("Øzark F4 Text Color", "action", fun_menu_pages["ozark_text"].id, function(feat)
    local _input, k = input.get("Type in a hex color code.", "ff6464 255", 10, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        return HANDLER_POP
    end

    menu.notify("Color set to " .. k:sub(1, 6) .. " with alpha value of " .. k:sub(8, 10), fun_menu_ver, 10, "0x"..k:sub(5, 6)..k:sub(3, 4)..k:sub(1, 2))
    ozarkTextRGB(k)
end)

local ozark_texts = {
    "Hello we did an exit scam lol",
    "Put me in coach.",
    "We partnered with other cheat providers after we exit scammed for more monies.",
    "BTC miner activated!",
    "Øzark v27 is out now!",
    "Dear beloved Øzark users, READ THIS MESSAGE IN ITS ENTIRETY.",
    "ØzArK oN tOp!!!!!!1111!one!!111",
    "2take1 on top!!!!!",
    "blah blah blah we exit scammed you suckers!!!!!11!!!one111!!",
    "We aRe BetTer ThAn 2TaKE1!!!!111!!one!!!1111!!",
    "We took months to do a menu UI rewrite when it should have taken 1 month at the most lmao",
    "We added a money drop option after the patch just so you can get banned faster.",
    "Øzark exit scam lmao",
    "exit scammed ya suckers",
    "Øzark on bottom lol",
    "We totally got a CnD from TakeTwo lmaoooooo"
}

function displayOzarkText(R1, G1, B1, A1, R2, G2, B2, A2, value)
    ui.set_text_scale(0.4)
    ui.set_text_font(0)
    ui.set_text_centre(0)
    ui.set_text_color(R1, G1, B1, A1)
    if (value == 0) then
        ui.draw_text('F4', v2(0.5, 0.1))
    elseif (value == 1) then
        ui.draw_text('NUMPAD -', v2(0.5, 0.1))
    end

    ui.set_text_scale(0.4)
    ui.set_text_font(0)
    ui.set_text_centre(0)
    ui.set_text_color(R2, G2, B2, A2)
end

local uppercase_ozark_text = menu.add_feature("Use UPPERCASE TEXT", "toggle", fun_menu_pages["ozark_text"].id, function(feat_toggle)
    settings["uppercase_ozark_text"] = feat_toggle.on
end)
uppercase_ozark_text.on = settings["uppercase_ozark_text"]

menu.add_feature("Random Øzark F4 Text", 'value_str', fun_menu_pages["ozark_text"].id, function(feat_toggle_val)
    local x = math.random(1, #ozark_texts)
    while (feat_toggle_val.on) do
        system.wait(0)
        displayOzarkText(oz_txt_color["R1"], oz_txt_color["G1"], oz_txt_color["B1"], oz_txt_color["A1"], oz_txt_color_F4["R2"], oz_txt_color_F4["G2"], oz_txt_color_F4["B2"], oz_txt_color_F4["A2"], feat_toggle_val.value)
        if (settings["uppercase_ozark_text"]) then
            ui.draw_text(ozark_texts[x]:upper(), v2(0.5, 0.075))
        elseif (not settings["uppercase_ozark_text"]) then
            ui.draw_text(ozark_texts[x], v2(0.5, 0.075))
        end
    end
end):set_str_data({"F4", "NUMPAD minus"})

menu.add_feature("Put Me in Coach Text", 'value_str', fun_menu_pages["ozark_text"].id, function(feat_toggle_val)
    while (feat_toggle_val.on) do
        system.wait(0)
        if (oz_txt_color["R1"] and oz_txt_color["G1"] and oz_txt_color["B1"] and oz_txt_color["A1"] and oz_txt_color_F4["R2"] and oz_txt_color_F4["G2"] and oz_txt_color_F4["B2"] and oz_txt_color_F4["A2"] ~= nil) then
            displayOzarkText(oz_txt_color["R1"], oz_txt_color["G1"], oz_txt_color["B1"], oz_txt_color["A1"], oz_txt_color_F4["R2"], oz_txt_color_F4["G2"], oz_txt_color_F4["B2"], oz_txt_color_F4["A2"], feat_toggle_val.value)
            if (settings["uppercase_ozark_text"]) then
                ui.draw_text("PUT ME IN COACH", v2(0.5, 0.075))
            elseif (not settings["uppercase_ozark_text"]) then
                ui.draw_text("Put Me in Coach", v2(0.5, 0.075))
            end
        else
            feat_toggle_val.on = false
            menu.notify("Your forgot to set \"Øzark Text Color\" and \"Øzark F4 Text Color\"", fun_menu_ver)
        end
    end
end):set_str_data({"F4", "NUMPAD minus"})

--   ______ __  __ ___     ____   ___    ______ ______ ______ ____     __    ____   ____   __ __ _____
--  / ____// / / //   |   / __ \ /   |  / ____//_  __// ____// __ \   / /   / __ \ / __ \ / //_// ___/
-- / /    / /_/ // /| |  / /_/ // /| | / /      / /  / __/  / /_/ /  / /   / / / // / / // ,<   \__ \ 
--/ /___ / __  // ___ | / _, _// ___ |/ /___   / /  / /___ / _, _/  / /___/ /_/ // /_/ // /| | ___/ / 
--\____//_/ /_//_/  |_|/_/ |_|/_/  |_|\____/  /_/  /_____//_/ |_|  /_____/\____/ \____//_/ |_|/____/  
                                                                                                    

fun_menu_pages["random_outfits"] = menu.add_feature("Random Outfits", "parent", fun_menu_pages["self_options"].id)
menu.add_feature("Random Tux Outfit", "action", fun_menu_pages["random_outfits"].id, function(feat)
    wipeOutfitsClean(player.get_player_ped(player.player_id()))
    randomTuxedoOutfit(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Random Tropical Outfit", "action", fun_menu_pages["random_outfits"].id, function(feat)
    wipeOutfitsClean(player.get_player_ped(player.player_id()))
    randomTropicalOutfit(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Random Beach Outfit", "action", fun_menu_pages["random_outfits"].id, function(feat)
    wipeOutfitsClean(player.get_player_ped(player.player_id()))
    randomBeachOutfit(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Random Golf Outfit", "action", fun_menu_pages["random_outfits"].id, function(feat)
    wipeOutfitsClean(player.get_player_ped(player.player_id()))
    randomGolferOutfit(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Make Self Barefoot", "action", fun_menu_pages["self_options"].id, function(feat)
    if (player.is_player_female(player.player_id())) then
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 6, 35, 0, 0) -- feet
    else
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 6, 34, 0, 0) -- feet
    end
end)

menu.add_feature("Make Self Shirtless", "action", fun_menu_pages["self_options"].id, function(feat)
    ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 3, 15, 0, 0)
    ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 11, 15, 0, 0)
    ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 8, 15, 0, 0)
    ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 7, 0, 0, 0)
end)

menu.add_feature("Make Self an Old Codger", "action", fun_menu_pages["self_options"].id, function(feat)
    local codger_colors = {
        hair_color = select(math.random(1, 3), 26, 27, 28),
        hair_highlight_color = select(math.random(1, 3), 26, 27, 28)
    }
    ped.set_ped_head_overlay(player.get_player_ped(player.player_id()), 3, 14, 1.0)
    ped.set_ped_hair_colors(player.get_player_ped(player.player_id()), codger_colors["hair_color"], codger_colors["hair_highlight_color"]) -- hair colors
    ped.set_ped_head_overlay_color(player.get_player_ped(player.player_id()), 1, 1, codger_colors["hair_color"], codger_colors["hair_highlight_color"]) -- facial hair colors
end)

menu.add_feature("Random Face Features", "action_value_str", fun_menu_pages["self_options"].id, function(feat_val)
    if (feat_val.value == 0) then
        extraFaceFeatures(player.get_player_ped(player.player_id()))
    elseif (feat_val.value == 1) then
        extraFaceFeatures(player.get_player_ped(player.player_id()))
        evenMoreExtraFeatures(player.get_player_ped(player.player_id()))
    end
end):set_str_data({"Base Face Features", "Extra Face Features"})

menu.add_feature("Random Headblend", "action_value_str", fun_menu_pages["self_options"].id, function(feat_val)
    wipeHeadBlend(player.get_player_ped(player.player_id()))
    if (feat_val.value == 0) then
        randomizeHeadBlend(player.get_player_ped(player.player_id()))
    elseif (feat_val.value == 1) then
        randomizeHeadBlend(player.get_player_ped(player.player_id()))
        extraFaceFeatures(player.get_player_ped(player.player_id()))
    elseif (feat_val.value == 2) then
        randomizeHeadBlend(player.get_player_ped(player.player_id()))
        extraFaceFeatures(player.get_player_ped(player.player_id()))
        evenMoreExtraFeatures(player.get_player_ped(player.player_id()))
    end
end):set_str_data({"Base Face Shape", "w/ Face Features", "w/ More Face Features"})

menu.add_feature("Random Skin Tone", "action", fun_menu_pages["self_options"].id, function(feat)
    randomizeSkinTone(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Wipe Headblend", "action", fun_menu_pages["self_options"].id, function(feat)
    wipeHeadBlend(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Random Funky Hair Color", "action", fun_menu_pages["self_options"].id, function(feat_val)
    local funky_hair = math.random(30, 54)
    ped.set_ped_hair_colors(player.get_player_ped(player.player_id()), funky_hair, funky_hair) -- hair colors
    ped.set_ped_head_overlay_color(player.get_player_ped(player.player_id()), 1, 1, funky_hair, funky_hair) -- facial hair colors
end)

menu.add_feature("Hairy Disco", "toggle", fun_menu_pages["self_options"].id, function(feat_toggle)
    while (feat_toggle.on) do
        ped.set_ped_hair_colors(player.get_player_ped(player.player_id()), math.random(30, 54), math.random(30, 54)) -- hair colors
        ped.set_ped_head_overlay_color(player.get_player_ped(player.player_id()), 1, 1, math.random(30, 54), math.random(30, 54)) -- facial hair colors
        system.wait(50)
    end
end)

local wetness = menu.add_feature("Wetness", "slider", fun_menu_pages["self_options"].id, function(feat_slider)
    if (feat_slider.on) then
        natives.SET_PED_WETNESS_HEIGHT(player.get_player_ped(player.player_id()), feat_slider.value)
    else
        natives.CLEAR_PED_WETNESS(player.get_player_ped(player.player_id()))
    end
end)
wetness.max = 1.0
wetness.min = -1.0
wetness.mod = 0.05
wetness.value = -1.0

local KeyW = MenuKey()
KeyW:push_vk(0x57)
menu.add_feature("Spin", "toggle", fun_menu_pages["self_options"].id, function(feat_toggle)
    while (feat_toggle.on) do
        if (not KeyW:is_down()) then
            entity.set_entity_heading(player.get_player_ped(player.player_id()), math.random(-180, 180))
        end
        system.wait()
    end
end)

menu.add_feature("Spin 360", "toggle", fun_menu_pages["self_options"].id, function(feat_toggle)
    while (feat_toggle.on) do
        if (not KeyW:is_down()) then
            entity.set_entity_rotation(player.get_player_ped(player.player_id()), v3(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180)))
        end
        system.wait()
    end
end)

menu.add_feature("Play Dead", "value_str", fun_menu_pages["self_options"].id, function(feat_toggle_val)
    local random_choice = math.random(1, 2)
    if (random_choice == 1) then
        requestAnimDictAndSet("facials@gen_male@base", "dead_1")
    else
        requestAnimDictAndSet("facials@gen_male@base", "dead_2")
    end

    scaleforms["wasted"] = graphics.request_scaleform_movie("MP_BIG_MESSAGE_FREEMODE")

    if (not ped.can_ped_ragdoll(player.get_player_ped(player.player_id()))) then
        ped.set_ped_can_ragdoll(player.get_player_ped(player.player_id()), true)
    end

    if (feat_toggle_val.on) then
        fun_menu_threads["play_dead_thread"] = menu.create_thread(function()
            while (feat_toggle_val.on) do
                natives.PLAY_FACIAL_ANIM(player.get_player_ped(player.player_id()), "dead_"..tostring(random_choice), "facials@gen_male@base")
                if (feat_toggle_val.value == 0) then
                    ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 1500, 0, 0)
                elseif (feat_toggle_val.value == 1) then
                    show_wasted_screen(scaleforms["wasted"], "WASTED", "You just played dead.", 0, false, false)
                    ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 1500, 0, 0)
                end
                system.wait(0)
            end
        end, nil)
    end

    if (not feat_toggle_val.on) then
        menu.delete_thread(fun_menu_threads["play_dead_thread"])
    end
end):set_str_data({"v1", "v2"})

menu.add_feature("Clumsiness", "value_str", fun_menu_pages["self_options"].id, function(feat_toggle_val)
    if feat_toggle_val.on then
        local time_start, time_end

        if (feat_toggle_val.value == 0) then
            time_start, time_end = 10, 30
        elseif (feat_toggle_val.value == 1) then
            time_start, time_end = 5, 15
        elseif (feat_toggle_val.value == 2) then
            time_start, time_end = 1, 5
        end

        fun_menu_threads["clumsy_thread"] = menu.create_thread(function()
            while (feat_toggle_val.on) do
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), math.random(1, 25) * 100, math.random(1, 25) * 100, math.random(-25, 25))
                system.wait(math.random(time_start, time_end) * 1000)
            end
        end, nil)

        if (feat_toggle_val.value == 1 or feat_toggle_val.value == 2) then
            while (feat_toggle_val.on) do
                if ped.is_ped_ragdoll(player.get_player_ped(player.player_id())) then
                    natives.SET_PED_RAGDOLL_ON_COLLISION(player.get_player_ped(player.player_id()), false)
                else
                    natives.SET_PED_RAGDOLL_ON_COLLISION(player.get_player_ped(player.player_id()), true)
                end
                system.wait(1000)
            end
        end
    end
    
    if (not feat_toggle_val.on) then
        natives.SET_PED_RAGDOLL_ON_COLLISION(player.get_player_ped(player.player_id()), false)
        if fun_menu_threads["clumsy_thread"] then
            menu.delete_thread(fun_menu_threads["clumsy_thread"])
        end
    end
end):set_str_data({"Clumsy", "Really Clumsy", "Extremely Clumsy"})

menu.add_feature("Trip on Something", "action", fun_menu_pages["self_options"].id, function(feat)
    ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), math.random(1, 25) * 100, math.random(1, 25) * 100, math.random(-25, 25))
end)

--    _   __ ____   ______   _____ ______ __  __ ______ ______
--   / | / // __ \ / ____/  / ___//_  __// / / // ____// ____/
--  /  |/ // /_/ // /       \__ \  / /  / / / // /_   / /_    
-- / /|  // ____// /___    ___/ / / /  / /_/ // __/  / __/    
--/_/ |_//_/     \____/   /____/ /_/   \____//_/    /_/       
                                                            
fun_menu_pages["follower_menu"] = menu.add_feature("Followers", "parent", fun_menu_pages["npc_stuff"].id, function(feat)
    menu.notify("Avoid using these features in small interior spaces or the NPCs will bug out.", fun_menu_ver)
end)

----### Configure follower attributes. ###----
local follower_peds = {}
local outfits_value

local follower_outfits = menu.add_feature("Follower(s)' Outfits", "autoaction_value_str", fun_menu_pages["follower_menu"].id, function(val)
    outfits_value = val
    menu.notify("Follower outfit set!", fun_menu_ver)
end):set_str_data({"Tuxedo", "Tropical", "Own Outfit"})

menu.add_feature("Can Followers Enter Vehicle?", "action_value_str", fun_menu_pages["follower_menu"].id, function(val)
    local player_veh = player.get_player_vehicle(player.player_id())

    if (val.value == 0) then
        for i = 1, #follower_peds do
            if (player.is_player_in_any_vehicle(player.player_id())) then
                ped.set_ped_into_vehicle(follower_peds[i], player_veh, vehicle.get_free_seat(player_veh))
            else
                ai.task_leave_vehicle(follower_peds[i], player_veh, 1)
            end
        end
    else
        for i = 1, #follower_peds do
            ai.task_leave_vehicle(follower_peds[i], player_veh, 1)
        end
    end
end):set_str_data({"Yes", "No"})

menu.add_feature("Alter Follower(s)' Outfits", "action_value_str", fun_menu_pages["follower_menu"].id, function(feat_val)
    for i = 1, #follower_peds do
        requestControl(follower_peds[i])

        if (feat_val.value == 0) then
            wipeOutfitsClean(follower_peds[i])
            randomTuxedoOutfit(follower_peds[i])
            if (math.random(0, 10) == 4) then
                if (entity.get_entity_model_hash(follower_peds[i]) == 2627665880) then
                    ped.set_ped_component_variation(follower_peds[i], 6, 35, 0, 0)
                else
                    ped.set_ped_component_variation(follower_peds[i], 6, 34, 0, 0)
                end
            end
        elseif (feat_val.value == 1) then
            wipeOutfitsClean(follower_peds[i])
            randomTropicalOutfit(follower_peds[i])
        elseif (feat_val.value == 2) then
            wipeOutfitsClean(follower_peds[i])
            copyPlayerOutfitToClone(player.get_player_ped(player.player_id()), follower_peds[i])
        end
    end
end):set_str_data({"Tuxedo", "Tropical", "Copy Own Outfit"})

local follower_count = menu.add_feature("Follower Count", "autoaction_value_i", fun_menu_pages["follower_menu"].id)
follower_count.min = 1
follower_count.max = 5
follower_count.mod = 1
follower_count.value = 1

local follower_range = menu.add_feature("Follower Wander Range", "autoaction_value_i", fun_menu_pages["follower_menu"].id)
follower_range.min = 5
follower_range.max = 30
follower_range.mod = 1
follower_range.value = 2

local follower_wander = menu.add_feature("Wandering Follower(s)?", "toggle", fun_menu_pages["follower_menu"].id, function(feat_toggle)
    settings["wandering_follower"] = feat_toggle.on
end)
follower_wander.on = settings["wandering_follower"]

----### Spawn in some clones to follow your around. ###----
menu.add_feature("Spawn Clone Follower(s)", "toggle", fun_menu_pages["follower_menu"].id, function(feat_toggle)
    local MP_ped
    if (player.is_player_female(player.player_id())) then
        MP_ped = 0x9C9EFFD8
    else
        MP_ped = 0x705E61F2
    end

    for i = 1, follower_count.value do
        follower_peds[i] = ped.create_ped(1, MP_ped, player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), math.random(0, 359), true, false)
        createClone(player.get_player_ped(player.player_id()), follower_peds[i])

        if (outfits_value == nil) then
            wipeOutfitsClean(follower_peds[i])
            randomTuxedoOutfit(follower_peds[i])
        elseif (outfits_value.value == 0) then
            wipeOutfitsClean(follower_peds[i])
            randomTuxedoOutfit(follower_peds[i])
        elseif (outfits_value.value == 1) then
            wipeOutfitsClean(follower_peds[i])
            randomTropicalOutfit(follower_peds[i])
        elseif (outfits_value.value == 2) then
            wipeOutfitsClean(follower_peds[i])
            copyPlayerOutfitToClone(player.get_player_ped(player.player_id()), follower_peds[i])
        end
        system.wait(100)
        entities[#entities + 1] = follower_peds[i]
        addBlip(follower_peds[i], 280)
    end

    while feat_toggle.on do
        for i = 1, follower_count.value do
            requestControl(follower_peds[i])

            if (getDistanceBetweenCoords(player.get_player_coords(player.player_id()), entity.get_entity_coords(follower_peds[i])) <= follower_range.value + 1) then
                if (settings["wandering_follower"]) then
                    ai.task_go_to_coord_by_any_means(follower_peds[i], player.get_player_coords(player.player_id()) + v3(math.random(-follower_range.value, follower_range.value), math.random(-follower_range.value, follower_range.value), 0), 1, 0, true, 1, 0.0)
                end
            else
                ai.task_goto_entity(follower_peds[i], player.get_player_ped(player.player_id()), -1, -1, 25.0)
            end

            if (entity.is_entity_dead(follower_peds[i])) then
                feat_toggle.on = false
            end
        end
        system.wait(5000)
    end

    for i = 1, follower_count.value do
        if (not feat_toggle.on) then
            entity.set_entity_as_mission_entity(follower_peds[i], true, true)
            entity.delete_entity(follower_peds[i])
            system.wait(250)
            follower_wander.on = false
            settings["wandering_follower"] = false
        end
    end
end)

----### Spawn in some random generated gtao characters to follow your around. ###----
menu.add_feature("Spawn Follower(s)", "value_str", fun_menu_pages["follower_menu"].id, function(feat_toggle_val)
    local MP_ped
    local zero_or_one

    for i = 1, follower_count.value do
        zero_or_one = math.random(0, 1)

        if (zero_or_one == 1) then
            MP_ped = 0x9C9EFFD8
        else
            MP_ped = 0x705E61F2
        end

        requestModel(MP_ped)

        follower_peds[i] = ped.create_ped(1, MP_ped, player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), math.random(0, 359), true, false)
        if (feat_toggle_val.value == 0) then
            removeExtraFaceFeatures(follower_peds[i])
            randomizeHeadBlend(follower_peds[i])
        elseif (feat_toggle_val.value == 1) then
            randomizeHeadBlend(follower_peds[i])
            extraFaceFeatures(follower_peds[i])
        elseif (feat_toggle_val.value == 2) then
            randomizeHeadBlend(follower_peds[i])
            extraFaceFeatures(follower_peds[i])
            evenMoreExtraFeatures(follower_peds[i])
        end

        if (outfits_value == nil) then
            wipeOutfitsClean(follower_peds[i])
            randomTuxedoOutfit(follower_peds[i])
        elseif (outfits_value.value == 0) then
            wipeOutfitsClean(follower_peds[i])
            randomTuxedoOutfit(follower_peds[i])
        elseif (outfits_value.value == 1) then
            wipeOutfitsClean(follower_peds[i])
            randomTropicalOutfit(follower_peds[i])
        end
        system.wait(100)
        entities[#entities + 1] = follower_peds[i]
        addBlip(follower_peds[i], 280)
    end

    while feat_toggle_val.on do
        for i = 1, follower_count.value do
            requestControl(follower_peds[i])

            if (getDistanceBetweenCoords(player.get_player_coords(player.player_id()), entity.get_entity_coords(follower_peds[i])) <= follower_range.value + 1) then
                if (settings["wandering_follower"]) then
                    ai.task_go_to_coord_by_any_means(follower_peds[i], player.get_player_coords(player.player_id()) + v3(math.random(-follower_range.value, follower_range.value), math.random(-follower_range.value, follower_range.value), 0), 1, 0, true, 1, 0.0)
                end
            else
                ai.task_goto_entity(follower_peds[i], player.get_player_ped(player.player_id()), -1, -1, 25.0)
            end

            if (entity.is_entity_dead(follower_peds[i])) then
                feat_toggle_val.on = false
            end
        end
        system.wait(5000)
    end
    
    if (not feat_toggle_val.on) then
        for i = 1, follower_count.value do
            entity.set_entity_as_mission_entity(follower_peds[i], true, true)
            entity.delete_entity(follower_peds[i])
            system.wait(250)
        end

        follower_wander.on = false
        settings["wandering_follower"] = false
    end
end):set_str_data({"Base Face Shape", "w/ Face Features", "w/ More Face Features"})

menu.add_feature("Make Follower(s) Old Codgers", "action", fun_menu_pages["follower_menu"].id, function(feat)
    local codger_colors = {
        hair_color = select(math.random(1, 3), 26, 27, 28),
        hair_highlight_color = select(math.random(1, 3), 26, 27, 28)
    }

    for i = 1, follower_count.value do
        ped.set_ped_head_overlay(follower_peds[i], 3, 14, 1.0)
        ped.set_ped_hair_colors(follower_peds[i], codger_colors["hair_color"], codger_colors["hair_highlight_color"]) -- hair colors
        ped.set_ped_head_overlay_color(follower_peds[i], 1, 1, codger_colors["hair_color"], codger_colors["hair_highlight_color"]) -- facial hair colors
    end
end)

menu.add_feature("Reroll Followers' Hairstyle", "action", fun_menu_pages["follower_menu"].id, function(feat)
    for i = 1, follower_count.value do
        randomizeHairStyles(follower_peds[i])
    end
end)

menu.add_feature("Spawn Bird:", "action_value_str", fun_menu_pages["npc_stuff"].id, function(feat_value)
    requestModel(gameplay.get_hash_key(BirdModels[feat_value.value + 1]))
    local bird = ped.create_ped(5, gameplay.get_hash_key(BirdModels[feat_value.value + 1]), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), math.random(0, 359), true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(BirdModels[feat_value.value + 1]))
    ai.task_wander_standard(bird, 0.0, true)
    entities[#entities + 1] = bird
end):set_str_data(BirdNames)

menu.add_feature("Spawn Wild Animal:", "action_value_str", fun_menu_pages["npc_stuff"].id, function(feat_value)
    requestModel(gameplay.get_hash_key(WildAnimalModels[feat_value.value + 1]))
    local wild_animal = ped.create_ped(5, gameplay.get_hash_key(WildAnimalModels[feat_value.value + 1]), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), math.random(0, 359), true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(WildAnimalModels[feat_value.value + 1]))
    ai.task_wander_standard(wild_animal, 1.0, false)
    entities[#entities + 1] = wild_animal
end):set_str_data(WildAnimalNames) 


--    ____   ______ ______ _____
--   / __ \ / ____//_  __// ___/
--  / /_/ // __/    / /   \__ \ 
-- / ____// /___   / /   ___/ / 
--/_/    /_____/  /_/   /____/  
   
local _pets = {}

function drawPetName(pets, name)         
    local retrn, screen = graphics.project_3d_coord(entity.get_entity_coords(pets))
    
    if retrn then
        local screen2 = v2(screen.x/graphics.get_screen_width(), (screen.y/graphics.get_screen_height()))
        
        ui.set_text_scale(0.2)
        ui.set_text_font(0)
        ui.set_text_centre(0)
        ui.set_text_color(144, 151, 245, 255)
        ui.set_text_outline(true)
        
        local head_pos = screen2.y-0.2
        ui.draw_text(name, screen2) 
    end
end

local wander = menu.add_feature("Wandering Pet(s)", "toggle", fun_menu_pages["pet_menu"].id, function(feat_toggle)
    settings["wandering_pet"] = feat_toggle.on
end)
wander.on = settings["wandering_pet"]

--[[menu.add_feature("Draw Pet Names", "toggle", fun_menu_pages["pet_menu"].id, function(feat_toggle)
    while (feat_toggle.on) do
        for i = 1, #_pets do
            drawPetName(i, "Cat")
        end
        system.wait()


        for pet, name in pairs(_pets) do
            drawPetName(pet, name)
        end
    end
end)]]

--[[menu.add_feature("Clear Pets List", "action", fun_menu_pages["pet_menu"].id, function(feat_toggle)
    _pets = {}
    menu.notify("Pets list cleared.")
end)]]

menu.add_feature("Get a Cat", "toggle", fun_menu_pages["pet_menu"].id, function(feat_toggle)
    --[[local _input, k = input.get("Type pet name.", "Cat", -1, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        feat_toggle.on = false
        return HANDLER_POP
    end]]

    requestAnimDictAndSet("creatures@cat@amb@world_cat_sleeping_ground@base", "base")
    requestModel(gameplay.get_hash_key("A_C_Cat_01"))

    local _cat = ped.create_ped(5, gameplay.get_hash_key("A_C_Cat_01"), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), 0, true, false)
    entity.set_entity_god_mode(_cat, true)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("A_C_Cat_01"))
    --table.insert(_pets, {k, _cat})
    --_pets[#_pets + 1] = _cat
    entities[#entities + 1] = _cat
    addBlip(_cat, 442)

    while feat_toggle.on do
        requestControl(_cat)
        animalAI(_cat, player.player_id(), "creatures@cat@amb@world_cat_sleeping_ground@base", "base", wander.on)
        system.wait(5000)
    end

    if (not feat_toggle.on) then
        entity.set_entity_as_mission_entity(_cat, true, true)
        entity.delete_entity(_cat)
        unloadAnim("creatures@cat@amb@world_cat_sleeping_ground@base", "base")
    end
end)

menu.add_feature("Get a Retriever", "toggle", fun_menu_pages["pet_menu"].id, function(feat_toggle)
    requestAnimDictAndSet("creatures@retriever@amb@world_dog_sitting@base", "base")
    requestModel(gameplay.get_hash_key("A_C_Retriever"))

    local _retriever = ped.create_ped(5, gameplay.get_hash_key("A_C_Retriever"), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), 0, true, false)
    entity.set_entity_god_mode(_retriever, true)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("A_C_Retriever"))
    entities[#entities + 1] = _retriever
    addBlip(_retriever, 442)

    while feat_toggle.on do
        requestControl(_retriever)
        animalAI(_retriever, player.player_id(), "creatures@retriever@amb@world_dog_sitting@base", "base", wander.on)
        system.wait(5000)
    end

    if (not feat_toggle.on) then
        entity.set_entity_as_mission_entity(_retriever, true, true)
        entity.delete_entity(_retriever)
        unloadAnim("creatures@retriever@amb@world_dog_sitting@base", "base")
    end
end)

menu.add_feature("Get a Pug", "toggle", fun_menu_pages["pet_menu"].id, function(feat_toggle)
    requestAnimDictAndSet("creatures@pug@amb@world_dog_sitting@base", "base")
    requestModel(gameplay.get_hash_key("A_C_Pug"))

    local _pug = ped.create_ped(5, gameplay.get_hash_key("A_C_Pug"), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), 0, true, false)
    entity.set_entity_god_mode(_pug, true)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("A_C_Pug"))
    entities[#entities + 1] = _pug
    addBlip(_pug, 442)

    while feat_toggle.on do
        requestControl(_pug)
        animalAI(_pug, player.player_id(), "creatures@pug@amb@world_dog_sitting@base", "base", wander.on)
        system.wait(5000)
    end

    if (not feat_toggle.on) then
        entity.set_entity_as_mission_entity(_pug, true, true)
        entity.delete_entity(_pug)
        unloadAnim("creatures@pug@amb@world_dog_sitting@base", "base")
    end
end)

menu.add_feature("Get a Rottweiler", "toggle", fun_menu_pages["pet_menu"].id, function(feat_toggle)
    requestAnimDictAndSet("creatures@rottweiler@amb@world_dog_sitting@base", "base")
    requestModel(gameplay.get_hash_key("A_C_Rottweiler"))

    local _rottweiler = ped.create_ped(5, gameplay.get_hash_key("A_C_Rottweiler"), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), 0, true, false)
    entity.set_entity_god_mode(_rottweiler, true)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("A_C_Rottweiler"))
    entities[#entities + 1] = _rottweiler
    addBlip(_rottweiler, 442)

    while feat_toggle.on do
        requestControl(_rottweiler)
        animalAI(_rottweiler, player.player_id(), "creatures@rottweiler@amb@world_dog_sitting@base", "base", wander.on)
        system.wait(5000)
    end

    if (not feat_toggle.on) then
        entity.set_entity_as_mission_entity(_rottweiler, true, true)
        entity.delete_entity(_rottweiler)
        unloadAnim("creatures@rottweiler@amb@world_dog_sitting@base", "base")
    end
end)

--    __  ___ ____ _____  ______ ______ __     __     ___     _   __ ______ ____   __  __ _____
--   /  |/  //  _// ___/ / ____// ____// /    / /    /   |   / | / // ____// __ \ / / / // ___/
--  / /|_/ / / /  \__ \ / /    / __/  / /    / /    / /| |  /  |/ // __/  / / / // / / / \__ \ 
-- / /  / /_/ /  ___/ // /___ / /___ / /___ / /___ / ___ | / /|  // /___ / /_/ // /_/ / ___/ / 
--/_/  /_//___/ /____/ \____//_____//_____//_____//_/  |_|/_/ |_//_____/ \____/ \____/ /____/  
                                                                                             

fun_menu_pages["animations"] = menu.add_feature("Animations", "parent", fun_menu_pages["miscellaneous"].id)
local time_in_ms = menu.add_feature("Snowball Explosion (ms)", "value_i", fun_menu_pages["miscellaneous"].id, function(feat_toggle)
    while feat_toggle.on do
        fire.add_explosion(player.get_player_coords(player.player_id()) - v3(0, 0, 0.5), 39, true, false, 0, player.player_id())
        system.wait(feat_toggle.value)
    end
end)
time_in_ms.min = 500
time_in_ms.max = 1000
time_in_ms.mod = 50
time_in_ms.value = 750

menu.add_feature("Rockstar Chat", "action_value_str", fun_menu_pages["miscellaneous"].id, function(feat_val)
    local _input, k = input.get("Type to chat.", "test", -1, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        return HANDLER_POP
    end

    local special_icons = {
        "¦",
        "∑",
        "Ω"
    }

    network.send_chat_message(string.format(special_icons[feat_val.value+1].." %s", k), false)
end):set_str_data({"R* Verified Icon", "R* Icon", "Lock Icon"})


menu.add_feature("Asteroid Shower", "toggle", fun_menu_pages["miscellaneous"].id, function(feat_toggle)
    local spawned_asteroids = {}
    requestModel(3751297495)

    while (feat_toggle.on) do
        local asteroid = object.create_object(3751297495, player.get_player_coords(player.player_id()) + v3(math.random(-250, 250), math.random(-250, 250), math.random(120, 240)), true, true)
        requestControl(asteroid)
        streaming.set_model_as_no_longer_needed(3751297495)
        entity.apply_force_to_entity(asteroid, 3, math.random(-50, 50), math.random(-50, 50), -5000, 0, 0, 0, false, true)

        spawned_asteroids[#spawned_asteroids + 1] = asteroid
        entities[#entities + 1] = asteroid

        fun_menu_threads["asteroid_downforce"] = menu.create_thread(function()
            while feat_toggle.on do
                for i = 1, #spawned_asteroids do
                    entity.apply_force_to_entity(spawned_asteroids[i], 3, math.random(-50, 50), math.random(-50, 50), -5000, 0, 0, 0, false, true)
                    system.wait()
                end
            end
        end, nil)

        for i = 1, #spawned_asteroids do
            if natives.GET_ENTITY_HEIGHT_ABOVE_GROUND(spawned_asteroids[i]):__tonumber() < 25 then
                requestControl(spawned_asteroids[i])
                graphics.set_next_ptfx_asset("scr_xm_orbital")
                requestPTFX("scr_xm_orbital")
                fire.add_explosion(entity.get_entity_coords(spawned_asteroids[i]) - v3(0, 0, 10), 8, true, false, 1, 0)
                fire.add_explosion(entity.get_entity_coords(spawned_asteroids[i]) - v3(0, 0, 10), 59, true, false, 1, 0)
                graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", entity.get_entity_coords(spawned_asteroids[i]) - v3(0, 0, 10), v3(0, 180, 0), 10.0, true, true, true)
                entity.set_entity_as_no_longer_needed(spawned_asteroids[i])
                entity.delete_entity(spawned_asteroids[i])
            end
        end
        system.wait(1000)
        menu.delete_thread(fun_menu_threads["asteroid_downforce"])
    end

    if (not feat_toggle.on) then
        for i = 1, #spawned_asteroids do
            requestControl(spawned_asteroids[i])
            entity.set_entity_as_no_longer_needed(spawned_asteroids[i])
            entity.delete_entity(spawned_asteroids[i])
        end
        menu.delete_thread(fun_menu_threads["asteroid_downforce"])
        spawned_asteroids = {}
    end
end)

-- thanks Gee-Man
local minecraft = menu.add_feature("Minecraft Gun", "value_str", fun_menu_pages["miscellaneous"].id, function(feat_toggle_val)
    local junk, pos,temp_block,time
    local spawned_blocks = {}
    local sandblocks = {
        "prop_mb_sandblock_01",
        "prop_mb_sandblock_02",
        "prop_mb_sandblock_03_cr",
        "prop_mb_sandblock_04",
        "prop_mb_sandblock_05_cr"
    }
    local block = gameplay.get_hash_key(sandblocks[feat_toggle_val.value + 1])
    local function ask_control(_ent)
        for i=1, 50 do
            if not entity.is_an_entity(_ent) then
                return false
            elseif network.has_control_of_entity(_ent) then
                return true
            else
                network.request_control_of_entity(_ent)
                system.wait(1)
            end
        end
        if entity.is_an_entity(_ent) then
            return network.has_control_of_entity(_ent)
        end
        return false
    end

    local function remove_temp()
        if temp_block ~= nil then
            ask_control(temp_block)
            entity.set_entity_as_no_longer_needed(temp_block)
            entity.delete_entity(temp_block)
            temp_block = nil
        end
    end

    while (feat_toggle_val.on) do
        while (feat_toggle_val.on) and player.is_player_free_aiming(player.player_id()) do    
            system.wait()
            if block ~= gameplay.get_hash_key(sandblocks[feat_toggle_val.value + 1]) then -- silly, but it allows changing the block while aiming
                remove_temp()
                block = gameplay.get_hash_key(sandblocks[feat_toggle_val.value + 1])
            end
            junk, pos = _GF_raycast_vector(temp_block)
            if junk then
                if temp_block == nil then
                    requestModel(block)
                    temp_block = object.create_object(block, pos, true, false)
                    
                    --entity.set_entity_collision(temp_block,false,false) -- just an option
                    
                    streaming.set_model_as_no_longer_needed(block)
                elseif ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
                    time = utils.time_ms() + 169 
                    while player.is_player_free_aiming(player.player_id()) and time > utils.time_ms() do --to prevent multiple spawns with fast firing weapon
                        system.wait()
                    end
                    
                    --ask_control(temp_block) -- just an option
                    --entity.set_entity_collision(temp_block,true,true)  -- just an option
                    
                    spawned_blocks[#spawned_blocks + 1] = temp_block
                    temp_block = nil
                elseif ask_control(temp_block) then
                    entity.set_entity_coords_no_offset(temp_block, pos)
                end
            end
        end
        remove_temp()
        system.wait()
    end
    if (not feat_toggle_val.on) then
        for i = 1, #spawned_blocks do
            if ask_control(spawned_blocks[i]) then
                entity.set_entity_as_no_longer_needed(spawned_blocks[i])
                entity.delete_entity(spawned_blocks[i])        
            end
        end
        spawned_blocks = {} -- i dont think this is necessary
    end
end)minecraft:set_str_data({"Singlular", "Row of 3", "Stacked Row of 3", "Corner", "Dead-end"})

-- thanks Gee-Man
local sphere = menu.add_feature("Fire Aura", "value_i", fun_menu_pages["miscellaneous"].id, function(feat_toggle)
    local nearby_peds
    local actually_nearby_peds = {}
    local already_burned = {}
    local time = utils.time_ms() - 1
    while (feat_toggle.on) do
        if time < utils.time_ms() then
            nearby_peds = ped.get_all_peds()
            actually_nearby_peds = {}
            already_burned = {}
            for i = 1, #nearby_peds do
                if not ped.is_ped_a_player(nearby_peds[i]) and player.get_player_coords(player.player_id()):magnitude(entity.get_entity_coords(nearby_peds[i])) <= feat_toggle.value then
                    actually_nearby_peds[#actually_nearby_peds+1] = nearby_peds[i]
                end
            end
            time = utils.time_ms() + 500
        end
        for i = 1, #actually_nearby_peds do
            if (entity.is_an_entity(actually_nearby_peds[i])) then
                if not entity.is_entity_on_fire(actually_nearby_peds[i]) and not entity.is_entity_dead(actually_nearby_peds[i]) and not already_burned[actually_nearby_peds[i]] and not ped.is_ped_in_any_vehicle(actually_nearby_peds[i]) then
                    fire.add_explosion(entity.get_entity_coords(actually_nearby_peds[i]), 3, false, false, 0.0, actually_nearby_peds[i])
                    already_burned[actually_nearby_peds[i]] = true
                end
            end
        end
        graphics.draw_marker(28, player.get_player_coords(player.player_id()), v3(0, 90, 0), v3(0, 90, 0), v3(feat_toggle.value, feat_toggle.value, feat_toggle.value), 0, 255, 0, 35, false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
        system.wait()
    end
    --draw_marker(Any type, v3 pos, v3 dir, v3 rot, v3 scale, int red, int green, int blue, int alpha, bool bobUpAndDown, bool faceCam, int a12, bool rotate, string|nil textureDict, string|nil textureName, bool drawOntEnts)
end)
sphere.max = 100
sphere.min = 5
sphere.mod = 5
sphere.value = 15

local sphere2 = menu.add_feature("EMP Aura", "value_i", fun_menu_pages["miscellaneous"].id, function(feat_toggle)
    local nearby_peds
    local actually_nearby_peds = {}
    local already_burned = {}
    local time = utils.time_ms() - 1
    while (feat_toggle.on) do
        if time < utils.time_ms() then
            nearby_peds = ped.get_all_peds()
            actually_nearby_peds = {}
            already_burned = {}
            for i = 1, #nearby_peds do
                if not ped.is_ped_a_player(nearby_peds[i]) and player.get_player_coords(player.player_id()):magnitude(entity.get_entity_coords(nearby_peds[i])) <= feat_toggle.value then
                    actually_nearby_peds[#actually_nearby_peds+1] = nearby_peds[i]
                end
            end
            time = utils.time_ms() + 500
        end
        for i = 1, #actually_nearby_peds do
            if (entity.is_an_entity(actually_nearby_peds[i])) then
                if not entity.is_entity_on_fire(actually_nearby_peds[i]) and not entity.is_entity_dead(actually_nearby_peds[i]) and not already_burned[actually_nearby_peds[i]] and ped.is_ped_in_any_vehicle(actually_nearby_peds[i]) then
                    fire.add_explosion(entity.get_entity_coords(actually_nearby_peds[i]), 65, false, false, 0.0, actually_nearby_peds[i])
                    already_burned[actually_nearby_peds[i]] = true
                end
            end
        end
        graphics.draw_marker(28, player.get_player_coords(player.player_id()), v3(0, 90, 0), v3(0, 90, 0), v3(feat_toggle.value, feat_toggle.value, feat_toggle.value), 0, 255, 0, 35, false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
        system.wait()
    end
    --draw_marker(Any type, v3 pos, v3 dir, v3 rot, v3 scale, int red, int green, int blue, int alpha, bool bobUpAndDown, bool faceCam, int a12, bool rotate, string|nil textureDict, string|nil textureName, bool drawOntEnts)
end)
sphere2.max = 100
sphere2.min = 5
sphere2.mod = 5
sphere2.value = 15

menu.add_feature("News", "toggle", fun_menu_pages["miscellaneous"].id, function(feat_toggle)
    local news = graphics.request_scaleform_movie("BREAKING_NEWS")

    while not graphics.has_scaleform_movie_loaded(news) do
        system.yield(0)
    end

    graphics.begin_scaleform_movie_method(news, "SET_TEXT")
    graphics.scaleform_movie_method_add_param_texture_name_string("fewqfwqefqewqweffewqfeqw")
    graphics.scaleform_movie_method_add_param_texture_name_string("You have been banned from Grand Theft Auto Online permanently.")
    graphics.end_scaleform_movie_method(news)
    while (feat_toggle.on) do
        graphics.draw_scaleform_movie_fullscreen(news, 255, 255, 255, 255, 0)
        system.yield(0)
    end
    graphics.set_scaleform_movie_as_no_longer_needed(news)
end)

menu.add_feature("Become the Black Hole", "toggle", fun_menu_pages["miscellaneous"].id, function(feat_toggle)
	while feat_toggle.on do
        if menu.get_feature_by_hierarchy_key("local.player_options.god") ~= nil then
            menu.get_feature_by_hierarchy_key("local.player_options.god").on = true
        end
        
        local offset = player.get_player_coords(player.player_id())
        local vehicles = getAllVehiclesInPlayerRange(player.player_id(), 140)
        local myVeh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
        graphics.draw_marker(28, offset, v3(0, 90, 0), v3(0, 90, 0), v3(1.5, 1.5, 1.5), 0, 0, 0, 255, false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
        for i = 1, #vehicles do
            local veh = vehicles[i]
            if veh ~= myVeh and requestControl(veh) then
                local vehPos = entity.get_entity_coords(veh)
                local vect = v3(offset.x, offset.y, offset.z)
                vect = vect - vehPos
                vect = vect * 0.5
                entity.apply_force_to_entity(veh, 1, vect.x, vect.y, vect.z, 0, 0, 0.5, false, true)
            end
        end
        system.wait()
	end

    if (not feat_toggle.on) then
        menu.get_feature_by_hierarchy_key("local.player_options.god").on = false
    end
end)

--[[**Fun Menu v0.5.1 & Troll Menu v1.0.1**
Festive Stuff
  + Added "Create a Firework Show"
  * Updated "Horsetrack Firework Show"
Vehicle Stuff
  + Added "Vehicle Magnet Gun" - thanks Proddy
Character Looks
  * Renamed to "Self Options"
NPC Stuff
  Followers
    * Updates spawn followers to not have to set an outfit value before spawning.
Miscellaneous
  + Added "Become the Black Hole"
  * Moved "Play Dead" to "Self Options"
Player Features
  + Added "Autopilot to Player"]]

menu.add_feature("Hands Up Animation", "toggle", fun_menu_pages["animations"].id, function(feat_toggle)
    requestAnimDictAndSet("missminuteman_1ig_2", "handsup_base")
    local anim_duration = natives.GET_ANIM_DURATION("missminuteman_1ig_2", "handsup_base"):__tonumber()


    while (feat_toggle.on) do
        ai.task_play_anim(player.get_player_ped(player.player_id()), "missminuteman_1ig_2", "handsup_base", 2.0, 2.0, math.floor(anim_duration * 1000), 01, 0, false, false, false)
        system.wait(math.floor(anim_duration * 1000))
    end

    if (not feat_toggle.on) then
        natives.CLEAR_PED_TASKS(player.get_player_ped(player.player_id()))
        unloadAnim("missminuteman_1ig_2", "handsup_base")
    end
end)

local facial_dicts = {
	"facials@gen_male@base"
}

local facial_animations = {
	["facials@gen_male@base"] = {
        "burning_1", "coughing_1", "dead_1", "dead_2", "die_1", "die_2", "drinking_1", "eating_1", "effort_1", "effort_2", "effort_3", "electrocuted_1", 
        "high_transition_01", "high_transition_02", "melee_effort_1", "melee_effort_2", "melee_effort_3", "mood_aiming_1", "mood_angry_1", 
        "mood_dancing_high_1", "mood_dancing_high_2", "mood_dancing_low_1", "mood_dancing_low_2", "mood_dancing_low_3", "mood_dancing_medium_1",
        "mood_dancing_medium_2", "mood_dancing_medium_3", "mood_drivefast_1", "mood_drunk_1", "mood_happy_1", "mood_injured_1", "mood_knockout_1", 
        "mood_normal_1", "mood_skydive_1", "mood_sleeping_1", "mood_smug_1", "mood_stressed_1", "mood_sulk_1", "pain_1", "pain_2", "pain_3", "pain_4", 
        "pain_5", "pain_6", "pose_aiming_1", "pose_angry_1", "pose_happy_1", "pose_injured_1", "pose_normal_1", "pose_smug_1", "pose_stressed_1", 
        "pose_sulk_1", "shocked_1", "shocked_2", "smoking_exhale_1", "smoking_hold_1", "smoking_inhale_1"
	}
}

local features = {facial_animation_feature = nil, facial_dict_feature = nil}

features.facial_dict_feature = menu.add_feature("face dict", "autoaction_value_str", fun_menu_pages["animations"].id, function(feat)
    features.facial_animation_feature:set_str_data(facial_animations[feat.str_data[feat.value + 1]])
end)
features.facial_dict_feature:set_str_data(facial_dicts)

features.facial_animation_feature = menu.add_feature("face anim", "value_str", fun_menu_pages["animations"].id, function(feat_toggle)
    requestAnimDictAndSet(features.facial_dict_feature.str_data[features.facial_dict_feature.value + 1], feat_toggle.str_data[feat_toggle.value + 1])
    local anim_duration = natives.GET_ANIM_DURATION(features.facial_dict_feature.str_data[features.facial_dict_feature.value + 1], feat_toggle.str_data[feat_toggle.value + 1]):__tonumber()


    while (feat_toggle.on) do
        natives.PLAY_FACIAL_ANIM(player.get_player_ped(player.player_id()), feat_toggle.str_data[feat_toggle.value + 1], features.facial_dict_feature.str_data[features.facial_dict_feature.value + 1])
        system.wait(math.floor(anim_duration * 1000))
    end

    if (not feat_toggle.on) then
        natives.CLEAR_PED_TASKS(player.get_player_ped(player.player_id()))
        unloadAnim(features.facial_dict_feature.str_data[features.facial_dict_feature.value + 1], feat_toggle.str_data[feat_toggle.value + 1])
    end
end)

local sitting_animation_dicts = {
    "missfbi2@leadinout",
    "amb@world_human_picnic@female@base",
    "amb@world_human_picnic@male@base"
}

local sitting_animations = {
    ["missfbi2@leadinout"] = {
        ["Sit 1"] = "fbi_2_int_leadin_action_andreas", 
        ["Sit 2"] = "fbi_2_int_leadin_action_daven", 
        ["Sit 3"] = "fbi_2_int_leadinout_loop_andreas", 
        ["Sit 4"] = "fbi_2_int_leadinout_loop_daven", 
        ["Sit 5"] = "fbi_2_int_leadinout_loop_steve", 
        ["Sit 6"] = "fbi_2_int_leadout_action_andreas", 
        ["Sit 7"] = "fbi_2_int_leadout_action_steve"
    },
    ["amb@world_human_picnic@female@base"] = {
        ["Sit On Ground 1"] = "base"
    },
    ["amb@world_human_picnic@male@base"] = {
        ["Sit On Ground 2"] = "base"
    }
}

local named_animations = {
    ["missfbi2@leadinout"] = {
        "Sit 1", 
        "Sit 2", 
        "Sit 3", 
        "Sit 4", 
        "Sit 5", 
        "Sit 6", 
        "Sit 7"
    },
    ["amb@world_human_picnic@female@base"] = {
        "Sit On Ground 1"
    },
    ["amb@world_human_picnic@male@base"] = {
        "Sit On Ground 2"
    }
}

local features2 = {sitting_animations = nil, sitting_animation_dicts = nil}

features2.sitting_animation_dicts = menu.add_feature("sit dict", "autoaction_value_str", fun_menu_pages["animations"].id, function(feat)
    --features2.sitting_animations:set_str_data(sitting_animations[feat.str_data[feat.value + 1]])
    features2.sitting_animations:set_str_data(named_animations[feat.str_data[feat.value + 1]])
end)
features2.sitting_animation_dicts:set_str_data(sitting_animation_dicts)

features2.sitting_animations = menu.add_feature("sit anim", "value_str", fun_menu_pages["animations"].id, function(feat_toggle)
    local anim_dict = features2.sitting_animation_dicts.str_data[features2.sitting_animation_dicts.value + 1]
    local anim_name = sitting_animations[features2.sitting_animation_dicts.str_data[features2.sitting_animation_dicts.value + 1]][feat_toggle.str_data[feat_toggle.value + 1]]

    requestAnimDictAndSet(anim_dict, anim_name)
    local anim_duration = natives.GET_ANIM_DURATION(anim_dict, anim_name):__tonumber()


    while (feat_toggle.on) do
        ai.task_play_anim(player.get_player_ped(player.player_id()), anim_dict, anim_name, 2.0, 2.0, math.floor(anim_duration * 1000), 01, 0, false, false, false)
        system.wait(math.floor(anim_duration * 1000))
    end

    if (not feat_toggle.on) then
        natives.CLEAR_PED_TASKS(player.get_player_ped(player.player_id()))
        unloadAnim(anim_dict, anim_name)
    end
end)
features2.sitting_animations:set_str_data(named_animations[features2.sitting_animation_dicts.str_data[features2.sitting_animation_dicts.value + 1]])

--    ____   __     ___ __  __ ______ ____     ______ ______ ___   ______ __  __ ____   ______ _____
--   / __ \ / /    /   |\ \/ // ____// __ \   / ____// ____//   | /_  __// / / // __ \ / ____// ___/
--  / /_/ // /    / /| | \  // __/  / /_/ /  / /_   / __/  / /| |  / /  / / / // /_/ // __/   \__ \ 
-- / ____// /___ / ___ | / // /___ / _, _/  / __/  / /___ / ___ | / /  / /_/ // _, _// /___  ___/ / 
--/_/    /_____//_/  |_|/_//_____//_/ |_|  /_/    /_____//_/  |_|/_/   \____//_/ |_|/_____/ /____/  

menu.add_player_feature("Autopilot to Player", "toggle", fun_menu_pages["player_fun_menu"].id, function(feat_toggle, pid)
    while feat_toggle.on do
        ai.task_vehicle_drive_to_coord(player.get_player_ped(player.player_id()), ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())), player.get_player_coords(pid), 50.0, -1, ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())), 786859, 1, 1.0)
        system.wait(2000)
    end
end)

menu.add_player_feature("Copy Player Outfit", "action", fun_menu_pages["player_fun_menu"].id, function(player_feat, pid)
    copyOutfit(player.get_player_ped(pid), player.get_player_ped(player.player_id()))
end)

menu.add_player_feature("Floppa Gun", "toggle", fun_menu_pages["player_fun_menu"].id, function(player_feat, pid)
    if player_feat.on then
        customAmmoShooter(307287994, pid)
    end
    return HANDLER_CONTINUE
end)

menu.add_player_feature("Orbital Gun", "toggle", fun_menu_pages["player_fun_menu"].id, function(player_feat, pid)
    if player_feat.on then
        customAmmoShooter(72, pid)
    end
    return HANDLER_CONTINUE
end)

menu.add_player_feature("Custom Explosion Gun", "toggle", fun_menu_pages["player_fun_menu"].id, function(player_feat_toggle, pid)
    local _input, k = input.get("Type in an explosion ID.", "12", 2, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        player_feat_toggle.on = false
        return HANDLER_POP
    end

    while player_feat_toggle.on do
        customAmmoShooter(tonumber(k), pid)
        system.wait(0)
    end
end)

menu.add_player_feature("Custom Entity Gun", "toggle", fun_menu_pages["player_fun_menu"].id, function(player_feat_toggle, pid)
    local _input, k = input.get("Type in an entity hash.", "307287994", 20, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        player_feat_toggle.on = false
        return HANDLER_POP
    end

    while player_feat_toggle.on do
        customAmmoShooter(tonumber(k), pid)
        system.wait(0)
    end
end)
