local main_menu = menu.add_feature("Fun Menu", "parent", 0)
local festive = menu.add_feature("Festive Stuff", "parent", main_menu.id)
local ptfx_stuff = menu.add_feature("PTFX Stuff", "parent", main_menu.id)
local alert_screens = menu.add_feature("Alert Screens", "parent", main_menu.id)
local vehicle_stuff = menu.add_feature("Vehicle Stuff", "parent", main_menu.id)
local ozark_text = menu.add_feature("Øzark Text", "parent", main_menu.id)
local character_looks = menu.add_feature("Character Looks", "parent", main_menu.id)
local npc_stuff = menu.add_feature("NPC Stuff", "parent", main_menu.id, function(feat)
    menu.notify("Avoid using these features in small interior spaces or the NPCs will bug out.", fun_menu_ver)
end)
local pet_menu = menu.add_feature("Pets", "parent", main_menu.id)
local miscellaneous = menu.add_feature("Miscellaneous", "parent", main_menu.id)

local fun_menu_ver = "Fun Menu v0.4.7"
local warning_color = 0x0000ff
require("this_is_needed\\npc_functions")
require("this_is_needed\\outfit_functions")
require("this_is_needed\\other_functions")


local settings = {
    "wandering_pet",
    "wandering_follower",
    "walk_style",
    "uppercase_ozark_text",
    "silent_fireworks",
    "wandering_driver",
    "team_chat?"
}

--    ______ ______ _____ ______ ____ _    __ ______   _____ ______ __  __ ______ ______
--   / ____// ____// ___//_  __//  _/| |  / // ____/  / ___//_  __// / / // ____// ____/
--  / /_   / __/   \__ \  / /   / /  | | / // __/     \__ \  / /  / / / // /_   / /_    
-- / __/  / /___  ___/ / / /  _/ /   | |/ // /___    ___/ / / /  / /_/ // __/  / __/    
--/_/    /_____/ /____/ /_/  /___/   |___//_____/   /____/ /_/   \____//_/    /_/       
                                                                                      
local silent_fireworks = menu.add_feature("Silent Fireworks?", "toggle", festive.id, function(feat_toggle)
    settings["silent_fireworks"] = feat_toggle.on
end)
silent_fireworks.on = settings["silent_fireworks"]

menu.add_feature("Vespucci Beach Firework Show", "toggle", festive.id, function(feat_toggle)
    local num_table = {100, 100, 200, 200, 300, 300}
    while feat_toggle.on do
        if (settings["silent_fireworks"]) then
            gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(math.random(-10, 10), math.random(-10, 10), 0), v3(-1950, -960, 2) + v3(0, 0, 20), 0, 0x7F7497E5, player.player_id(), false, false, num_table[math.random(1, #num_table)])
        else
            gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(math.random(-10, 10), math.random(-10, 10), 0), v3(-1950, -960, 2) + v3(0, 0, 20), 0, 0x7F7497E5, player.player_id(), true, false, num_table[math.random(1, #num_table)])
        end

        function spawn_firework_1(x, y, z, rot_z)
            if (settings["silent_fireworks"]) then
                gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(x, y, z), v3(-1950, -960, 2) + v3(0, 0, rot_z), 0, 0x7F7497E5, player.player_id(), false, false, 100)
            else
                gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(x, y, z), v3(-1950, -960, 2) + v3(0, 0, rot_z), 0, 0x7F7497E5, player.player_id(), true, false, 100)
            end
        end
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

menu.add_feature("Horsetrack Firework Show", "toggle", festive.id, function(feat_toggle)
    local num_table = {100, 100, 200, 200, 300, 300}
    while feat_toggle.on do
        if (settings["silent_fireworks"]) then
            gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(math.random(-10, 10), math.random(-10, 10), 0), v3(-1950, -960, 2) + v3(0, 0, 20), 0, 0x7F7497E5, player.player_id(), false, false, num_table[math.random(1, #num_table)])
        else
            gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(math.random(-10, 10), math.random(-10, 10), 0), v3(-1950, -960, 2) + v3(0, 0, 20), 0, 0x7F7497E5, player.player_id(), false, false, num_table[math.random(1, #num_table)])
        end

        function spawn_firework_1(x, y, z, rot_z)
            if (settings["silent_fireworks"]) then
                gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(x, y, z), v3(-1950, -960, 2) + v3(0, 0, rot_z), 0, 0x7F7497E5, player.player_id(), false, false, 100)
            else
                gameplay.shoot_single_bullet_between_coords(v3(-1950, -960, 2) + v3(x, y, z), v3(-1950, -960, 2) + v3(0, 0, rot_z), 0, 0x7F7497E5, player.player_id(), true, false, 100)
            end
        end
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

menu.add_feature("Give Firework Launchers to Everyone", "action", festive.id, function(feat_toggle)
    menu.notify("Gave everyone in current session a firework launcher.", fun_menu_ver)
    for i = 0, 31 do
        weapon.give_delayed_weapon_to_ped(player.get_player_ped(i), 0x7F7497E5, 0, true) -- Gives a firework launcher in 10ms and equips it right away
        weapon.set_ped_ammo(player.get_player_ped(i), 0x7F7497E5, 20)
        system.wait(150)
    end
end)

menu.add_feature("Give Snowballs to Everyone", "action", festive.id, function(feat_toggle)
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

menu.add_feature("PTFX Color", "action", ptfx_stuff.id, function(feat)
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

menu.add_feature("Cosmetic Bleed Out", "toggle", ptfx_stuff.id, function(feat_toggle)
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

menu.add_feature("Bloody Mess", "toggle", ptfx_stuff.id, function(feat_toggle)
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

menu.add_feature("Dragon Breath", "value_str", ptfx_stuff.id, function(feat_toggle_val)
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

menu.add_feature("Trails", "toggle", ptfx_stuff.id, function(feat_toggle)
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
                                                                                        
menu.add_feature("Alert Screen", 'value_str', alert_screens.id, function(feat_toggle_val)
    local screens = {
        "You have been banned from Grand Theft Auto Online permanently.\nReturn to Grand Theft Auto V.",
        "You're attempting to access GTA Online servers with an altered version of the game.\nReturn to Grand Theft Auto V.",
        "There has been an error with this session.\nReturn to Grand Theft Auto V.",
        "You have been suspended from GTA Online until ".. os.date("%m/%d/%Y", os.time() + 2700000) ..". \nIn addition, your Grand Theft Auto Online characters(s) will be reset.\nReturn to Grand Theft Auto V."
    }

    local alert_screen = graphics.request_scaleform_movie("POPUP_WARNING")
    while feat_toggle_val.on do
        ui.hide_hud_and_radar_this_frame()

        ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
        graphics.begin_scaleform_movie_method(alert_screen, "SHOW_POPUP_WARNING")
        graphics.draw_scaleform_movie_fullscreen(alert_screen, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_float(500.0)
        graphics.scaleform_movie_method_add_param_texture_name_string("alert")
        graphics.scaleform_movie_method_add_param_texture_name_string(screens[feat_toggle_val.value+1])
        graphics.end_scaleform_movie_method(alert_screen)
        system.wait(0)
    end

    if (not feat_toggle_val.on) then
        graphics.set_scaleform_movie_as_no_longer_needed(alert_screen)
    end
end):set_str_data({"Banned", "Altered Game", "Session Error", "Suspended"})

menu.add_feature("Set # Value for Alert", 'value_str', alert_screens.id, function(feat_toggle_val)
    local _input, k = input.get("Type in custom number value for use in some alert screens.", "-9999", 999, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        feat_toggle_val.on = false
        return HANDLER_POP
    end

    local numerical_screens = {
        "Rockstar Game Services have corrected your GTA Dollars by $".. k:sub(0, 1) .. tonumber(k:sub(2, 15)) .. ".",
        "Congratulations, you have been awarded $ " .. k .. ".",
        "Rockstar Game Services have corrected your RP levels to " .. k .. "RP.",
    }

    local alert_screen = graphics.request_scaleform_movie("POPUP_WARNING")
    while feat_toggle_val.on do
        ui.hide_hud_and_radar_this_frame()

        ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
        graphics.begin_scaleform_movie_method(alert_screen, "SHOW_POPUP_WARNING")
        graphics.draw_scaleform_movie_fullscreen(alert_screen, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_float(500.0)
        graphics.scaleform_movie_method_add_param_texture_name_string("alert")
        graphics.scaleform_movie_method_add_param_texture_name_string(numerical_screens[feat_toggle_val.value+1])
        graphics.end_scaleform_movie_method(alert_screen)
        system.wait(0)
    end

    if (not feat_toggle_val.on) then
        graphics.set_scaleform_movie_as_no_longer_needed(alert_screen)
    end
end):set_str_data({"Money Correct", "Money Awarded", "RP Correct"})

menu.add_feature("Custom Alert Screen", 'toggle', alert_screens.id, function(feat_toggle)
    local _input, k = input.get("Type in alert screen text", "", 999, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        feat_toggle.on = false
        return HANDLER_POP
    end

    local alert_screen = graphics.request_scaleform_movie("POPUP_WARNING")
    while feat_toggle.on do
        ui.hide_hud_and_radar_this_frame()

        ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
        graphics.begin_scaleform_movie_method(alert_screen, "SHOW_POPUP_WARNING")
        graphics.draw_scaleform_movie_fullscreen(alert_screen, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_float(500.0)
        graphics.scaleform_movie_method_add_param_texture_name_string("alert")
        graphics.scaleform_movie_method_add_param_texture_name_string(k)
        graphics.end_scaleform_movie_method(alert_screen)
        system.wait(0)
    end

    if (not feat_toggle.on) then
        graphics.set_scaleform_movie_as_no_longer_needed(alert_screen)
    end
end)

menu.add_feature("Ban Screen with Custom Reason", 'toggle', alert_screens.id, function(feat_toggle)
    local _input, k = input.get("Type in ban reason text", "", 999, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        feat_toggle.on = false
        return HANDLER_POP
    end

    local alert_screen = graphics.request_scaleform_movie("POPUP_WARNING")
    while feat_toggle.on do
        ui.hide_hud_and_radar_this_frame()

        ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
        graphics.begin_scaleform_movie_method(alert_screen, "SHOW_POPUP_WARNING")
        graphics.draw_scaleform_movie_fullscreen(alert_screen, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_float(500.0)
        graphics.scaleform_movie_method_add_param_texture_name_string("alert")
        graphics.scaleform_movie_method_add_param_texture_name_string("You have been banned from Grand Theft Auto Online permanently.")
        graphics.scaleform_movie_method_add_param_texture_name_string("Reason: " .. k .. "\n~w~Return to Grand Theft Auto V.")
        graphics.end_scaleform_movie_method(alert_screen)
        system.wait(0)
    end

    if (not feat_toggle.on) then
        graphics.set_scaleform_movie_as_no_longer_needed(alert_screen)
    end
end)

menu.add_feature("Get Color Codes", "action", alert_screens.id, function(feat)
    menu.notify("~r~ = Red\n~o~ = Orange\n~y~ = Yellow\n~g~ = Green\n~b~ = Blue\n~p~ = Purple\n~q~ = Pink\n~w~ or ~s~ = White\n~c~ or ~t~ = Gray\n~m~ = Dark Gray\n~u~ or ~l~ = Black\n\n\z
    Type the color codes into the input boxes for the alert screens and you will get colored text.", fun_menu_ver.. " | Color Codes")
end)

-- _    __ ______ __  __ ____ ______ __     ______   _____ ______ __  __ ______ ______
--| |  / // ____// / / //  _// ____// /    / ____/  / ___//_  __// / / // ____// ____/
--| | / // __/  / /_/ / / / / /    / /    / __/     \__ \  / /  / / / // /_   / /_    
--| |/ // /___ / __  /_/ / / /___ / /___ / /___    ___/ / / /  / /_/ // __/  / __/    
--|___//_____//_/ /_//___/ \____//_____//_____/   /____/ /_/   \____//_/    /_/       

local angry_planes_stuff = menu.add_feature("Angry Planes", "parent", vehicle_stuff.id)
local ai_flying_stuff = menu.add_feature("Airplane Chauffer", "parent", vehicle_stuff.id)
local ai_driving_stuff = menu.add_feature("Limo Chauffer", "parent", vehicle_stuff.id)
local personal_vehicle_stuff = menu.add_feature("Player Vehicle Mods", "parent", vehicle_stuff.id)

-- /// ANGRY PLANES /// --
local planes = {
    0xA52F6866, -- alpha z1
    0x6CBD1D6D, -- besra
    0xD9927FE3, -- cuban 800
    0xCA495705, -- dodo
    0x39D6779E, -- duster
    0x97E55D11, -- mammatus
    0x5D56F01B, -- molotok
    0x3DC92356, -- nokota
    0xAD6065C0, -- pyro
    0xC3F25753, -- howard
    0x39D6E83F, -- hydra
    0xB39B0AE6, -- lazer
    0x97E55D11, -- mammatus
    0x39D6779E, -- duster
    0xB2CF7250, -- nimbus
    0xEA313705, -- alkonost
    0xB79C1BF5, -- shamal
    0x761E2AD3, -- titan
    0x1AAD0DED, -- volatol
    0xC3F25753, -- howard
    0x39D6E83F, -- hydra
    0xB39B0AE6, -- lazer
    0x97E55D11, -- mammatus
    0x5D56F01B, -- molotok
    0x3DC92356, -- nokota
    0xAD6065C0, -- pyro
    0xC5DD6967, -- rogue
    0xE8983F9F, -- seabreeze
    0xC5DD6967, -- rogue
    0x81794C70, -- stuntplane
    0x5D56F01B, -- molotok
    0x3DC92356, -- nokota
    0xAD6065C0, -- pyro
    0xC5DD6967, -- rogue
    0xE8983F9F, -- seabreeze
    0xC5DD6967, -- rogue
    0x81794C70, -- stuntplane
    0x9C429B6A, -- velum
    0xA52F6866, -- alpha z1
    0x39D6779E, -- duster
    0xC3F25753, -- howard
    0x39D6E83F, -- hydra
    0xB39B0AE6, -- lazer
    0xC5DD6967, -- rogue
    0xE8983F9F, -- seabreeze
    0xC5DD6967, -- rogue
    0x81794C70, -- stuntplane
    0xFE0A508C, -- bombushka
    0x250B0C5E, -- luxor
    0xB79F589E, -- golden luxor
    0xEA313705, -- alkonost
}

local angry_plane_count = menu.add_feature("Angry Plane Count", 'autoaction_value_i', angry_planes_stuff.id)
angry_plane_count.min = 1
angry_plane_count.max = 50
angry_plane_count.mod = 1
angry_plane_count.value = 10

local spawned_planes = {}
menu.add_feature("Repair Angry Planes?", "toggle", angry_planes_stuff.id, function(feat_toggle)
    menu.notify("Angry planes are being repaired periodically.", fun_menu_ver)
    while (feat_toggle.on) do
        for k, plane in pairs(spawned_planes) do
            vehicle.set_vehicle_fixed(plane.plane)
            vehicle.set_vehicle_engine_health(plane.plane, 1000.0)
        end
        system.wait(0)
    end
end)

menu.add_feature("Teleport to a Random Angry Plane", "action", angry_planes_stuff.id, function(feat)
    menu.notify("Teleported to an angry plane.", fun_menu_ver)
    for k, plane in pairs(spawned_planes) do
        ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), plane.plane, 0)
    end
end)

menu.add_feature("Spawn Angry Planes", "toggle", angry_planes_stuff.id, function(feat_toggle)
    while (feat_toggle.on) do
        local pos = player.get_player_coords(player.player_id())
        local randAngle = (math.random() + math.random(0, 1)) * math.pi
        local radius = math.random(25, 100)

        pos.x = pos.x + radius * math.cos(randAngle)
        pos.y = pos.y + radius * math.sin(randAngle)
        pos.z = pos.z + 200
        requestModel(gameplay.get_hash_key("s_m_y_blackops_01"))
        for i = 1, #planes do
            requestModel(planes[i])
        end

        local plane
        local pilot
        for i = 1, #planes do
            if #spawned_planes < angry_plane_count.value then
                --local random_plane = math.random(1, #planes)
                plane = vehicle.create_vehicle(planes[i], pos + v3(math.random(-100, 100), math.random(-100, 100), math.random(0, 50)), math.random(0, 360), true, false)
                pilot = ped.create_ped(5, gameplay.get_hash_key("s_m_y_blackops_01"), pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 165, true, false)

                table.insert(spawned_planes, {["plane"] = plane, ["pilot"] = pilot})
                ped.set_ped_into_vehicle(pilot, plane, -1)
                vehicle.set_vehicle_engine_on(plane, true, true, false)
                vehicle.set_vehicle_forward_speed(plane, 50.0)
                vehicle.control_landing_gear(plane, 3)
                ai.task_vehicle_drive_to_coord(pilot, plane, player.get_player_coords(player.player_id()) + v3(0, 0, math.random(0, 50)), 100.0, -1, planes[i], 0, 0.0, 1.0)
                ped.set_ped_combat_attributes(pilot, 1, true)
                system.wait(1000)
            end
        end

        while (feat_toggle.on) do
            if (not network.has_control_of_entity(plane) and network.has_control_of_entity(pilot)) then
                network.request_control_of_entity(plane)
                network.request_control_of_entity(pilot)
            end
            system.wait(100)
        end

        for k, plane in pairs(spawned_planes) do
            if entity.is_entity_dead(plane.plane) then
                entity.set_entity_as_no_longer_needed(plane.plane)
                entity.delete_entity(plane.plane)
                entity.set_entity_as_no_longer_needed(plane.pilot)
                entity.delete_entity(plane.pilot)
                spawned_planes[k] = nil
            end
        end
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("s_m_y_blackops_01"))
        for i = 1, #planes do
            streaming.set_model_as_no_longer_needed(planes[i])
        end
        system.wait(1000)
    end

    if (not feat_toggle.on) then
        for k, plane in pairs(spawned_planes) do
            entity.set_entity_as_no_longer_needed(plane.plane)
            entity.delete_entity(plane.plane)
            entity.set_entity_as_no_longer_needed(plane.pilot)
            entity.delete_entity(plane.pilot)
            spawned_planes[k] = nil
        end
    end
end)

local player_plane = player.get_player_vehicle(player.player_id())
local waypoint
local pilot1
local pilot2
local coords

menu.add_feature("Repair Current Plane", "toggle", ai_flying_stuff.id, function(feat_toggle)
    vehicle.set_vehicle_fixed(player_plane)
    vehicle.set_vehicle_engine_health(player_plane, 1000.0)
    system.wait(10000)
end)

menu.add_feature("Auto Reroute to Current Waypoint", "toggle", ai_flying_stuff.id, function(feat_toggle)
    while (feat_toggle.on) do
        waypoint = ui.get_waypoint_coord()

        menu.notify("Rerouting to...\nX = " .. waypoint.x .. "\nY = " .. waypoint.y, fun_menu_ver)
        coords = v3(waypoint.x, waypoint.y, 100)
        system.wait(10000)
    end
end)

menu.add_feature("Manually Reroute to Current Waypoint", "action", ai_flying_stuff.id, function(feat)
    if (not player.is_player_in_any_vehicle(player.player_id()) and not vehicle.is_vehicle_model(player_plane, 0xB2CF7250)) then -- nimbus
        menu.notify("Wrong vehicle type.", fun_menu_ver)
    else
        waypoint = ui.get_waypoint_coord()
        
        menu.notify("Rerouting to...\nX = " .. waypoint.x .. "\nY = " .. waypoint.y, fun_menu_ver)
        coords = v3(waypoint.x, waypoint.y, 100)
    end
end)

local height_above_waypoint = menu.add_feature("Flying Height", 'autoaction_value_i', ai_flying_stuff.id)
height_above_waypoint.min = 100
height_above_waypoint.max = 300
height_above_waypoint.mod = 10
height_above_waypoint.value = 200

local destinations = menu.add_feature("Destinations", 'parent', ai_flying_stuff.id)
menu.add_feature("Diamond Casino & Resort", "action", destinations.id, function(feat)
    waypoint = ui.set_new_waypoint(v2(1038.944, 64.978))
    menu.notify("Destination: Diamond Casino & Resort", fun_menu_ver)
end)
menu.add_feature("Los Santos International Airport", "action", destinations.id, function(feat)
    waypoint = ui.set_new_waypoint(v2(-1187.151, -3039.150))
    menu.notify("Destination: Los Santos International Airport", fun_menu_ver)
end)

menu.add_feature("Start Flying", "toggle", ai_flying_stuff.id, function(feat_toggle)
    waypoint = ui.get_waypoint_coord()
    player_plane = player.get_player_vehicle(player.player_id())
    coords = v3(waypoint.x, waypoint.y, 100)

    if (not vehicle.is_vehicle_model(player_plane, 0xB2CF7250)) then -- nimbus
        menu.notify("Wrong vehicle type.", fun_menu_ver)
        feat_toggle.on = false
    elseif (vehicle.is_vehicle_model(player_plane, 0xB2CF7250)) then
        network.request_control_of_entity(player_plane)
        ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), player_plane, math.random(1, 6))

        requestModel(gameplay.get_hash_key("s_m_y_blackops_01"))
        pilot1 = ped.create_ped(5, gameplay.get_hash_key("s_m_y_blackops_01"), player.get_player_coords(player.player_id()), 165, true, false)
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("s_m_y_blackops_01"))
        network.request_control_of_entity(pilot1)
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

menu.add_feature("Auto Reroute to Current Waypoint", "toggle", ai_driving_stuff.id, function(feat_toggle)
    while (feat_toggle.on) do
        waypoint = ui.get_waypoint_coord()

        menu.notify("Rerouting to...\nX = " .. waypoint.x .. "\nY = " .. waypoint.y, fun_menu_ver)
        coords2 = v3(waypoint.x, waypoint.y, 100)
        system.wait(10000)
    end
end)

menu.add_feature("Manually Reroute to Current Waypoint", "action", ai_driving_stuff.id, function(feat)
    if (not player.is_player_in_any_vehicle(player.player_id()) and not vehicle.is_vehicle_model(player_vehicle, 0xE6E967F8)) then -- nimbus
        menu.notify("Wrong vehicle type.", fun_menu_ver)
    else
        waypoint = ui.get_waypoint_coord()
        
        menu.notify("Rerouting to...\nX = " .. waypoint.x .. "\nY = " .. waypoint.y, fun_menu_ver)
        coords2 = v3(waypoint.x, waypoint.y, 100)
    end
end)

menu.add_feature("Wandering Driver", "toggle", ai_driving_stuff.id, function(feat_toggle)
    settings["wandering_driver"] = feat_toggle.on
end)

menu.add_feature("Start Driving", "toggle", ai_driving_stuff.id, function(feat_toggle)
    waypoint = ui.get_waypoint_coord()
    player_vehicle = player.get_player_vehicle(player.player_id())
    coords2 = v3(waypoint.x, waypoint.y, 100)

    if (not vehicle.is_vehicle_model(player_vehicle, 0xE6E967F8)) then -- nimbus
        menu.notify("Wrong vehicle type.", fun_menu_ver)
        feat_toggle.on = false
    elseif (vehicle.is_vehicle_model(player_vehicle, 0xE6E967F8)) then
        network.request_control_of_entity(player_vehicle)
        ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), player_vehicle, math.random(1, 4))

        requestModel(gameplay.get_hash_key("s_m_y_blackops_01"))
        driver = ped.create_ped(5, gameplay.get_hash_key("s_m_y_blackops_01"), player.get_player_coords(player.player_id()), 165, true, false)
        streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("s_m_y_blackops_01"))
        network.request_control_of_entity(driver)
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

menu.add_feature("No Traction", "toggle", personal_vehicle_stuff.id, function(feat_toggle)
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

menu.add_feature("Custom Vehicle Color", "action", personal_vehicle_stuff.id, function(feat)
    local _input, k = input.get("Type in a hex color code.", "ffffff", 6, 0)
    if _input == 1 then
        return HANDLER_CONTINUE
    end
    if _input == 2 then
        return HANDLER_POP
    end

    local player_veh = player.get_player_vehicle(player.player_id())
    network.request_control_of_entity(player_veh)

    menu.notify("Vehicle color set to " .. k:sub(1, 6), fun_menu_ver, 10, "0x"..k:sub(5, 6)..k:sub(3, 4)..k:sub(1, 2))
    vehicle.set_vehicle_custom_primary_colour(player_veh, tonumber("0x" .. k))
    vehicle.set_vehicle_custom_secondary_colour(player_veh, tonumber("0x" .. k))
    --vehicle.set_vehicle_custom_pearlescent_colour(vehicles[i], RGBToInt(255, 70, 160))
    --vehicle.set_vehicle_custom_wheel_colour(Vehicle veh, uint32_t color)
end)

--[[menu.add_feature("Get Vehicle Colors", "action", personal_vehicle_stuff.id, function(feat)
    local player_veh = player.get_player_vehicle(player.player_id())
    local veh_colors = {
        color_primary = vehicle.get_vehicle_primary_color(player_veh)
        color_secondary = vehicle.get_vehicle_secondary_color(player_veh)
        color_pearl = vehicle.get_vehicle_pearlecent_color(player_veh)
        color_wheel = vehicle.get_vehicle_wheel_color(player_veh)
    }
    menu.notify("Primary: " .. tostring(veh_colors["color_primary"]) .. "\nSecondary: " .. tostring(veh_colors["color_secondary"]) .. "\nPearlescent: " .. tostring(veh_colors["color_pearl"]) .. "\nWheel: " .. tostring(veh_colors["color_wheel"]))
end)]]--

menu.add_feature("Modded Chrome Color", "action", personal_vehicle_stuff.id, function(feat)
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

menu.add_feature("Unchrome Vehicle", "action", personal_vehicle_stuff.id, function(feat)
    local player_veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_colors(player_veh, 0, 0)
    vehicle.set_vehicle_extra_colors(player_veh, 0, 0)
end)

menu.add_feature("Jump", "action_value_str", personal_vehicle_stuff.id, function(feat_val)
    local jump_heights = {3, 6, 10}
    local player_veh = player.get_player_vehicle(player.player_id())
    
    network.request_control_of_entity(player_veh)
    local existing_velocity = entity.get_entity_velocity(player_veh)
    entity.set_entity_velocity(player_veh, v3(existing_velocity.x, existing_velocity.y, jump_heights[feat_val.value+1]))
end):set_str_data({"Low Jump", "Medium Jump", "High Jump"})

menu.add_feature("Spin", "toggle", personal_vehicle_stuff.id, function(feat_toggle)
    local player_veh = player.get_player_vehicle(player.player_id())
    
    network.request_control_of_entity(player_veh)
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

seat_swapping = menu.add_feature("Change Vehicle Seat", "autoaction_value_i", personal_vehicle_stuff.id, function(feat)
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



menu.add_feature("Every Vehicle has No Traction", "toggle", vehicle_stuff.id, function(feat_toggle)
    local vehicles
    while (feat_toggle.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            network.request_control_of_entity(vehicles[i])
            vehicle.set_vehicle_reduce_grip(vehicles[i], true)
            system.wait(0)
        end
    end

    for i = 1, #vehicles do
        if (not feat_toggle.on) then
            entity.set_entity_as_mission_entity(vehicles[i], true, true)
        end
    end
end)

function RGBToInt(R, G, B) --Borrowed from gif.lua
    return ((R&0x0ff)<<0x00)|((G&0x0ff)<<0x08)|((B&0x0ff)<<0x10)
end

menu.add_feature("Change Traffic Color", "value_str", vehicle_stuff.id, function(feat_toggle_val)
    local vehicles
    while (feat_toggle_val.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            network.request_control_of_entity(vehicles[i])
            if (feat_toggle_val.value == 0) then
                vehicle.set_vehicle_custom_primary_colour(vehicles[i], RGBToInt(255, 70, 160))
                vehicle.set_vehicle_custom_secondary_colour(vehicles[i], RGBToInt(255, 70, 160))
                vehicle.set_vehicle_custom_pearlescent_colour(vehicles[i], RGBToInt(255, 70, 160))
            elseif (feat_toggle_val.value == 1) then
                vehicle.set_vehicle_custom_primary_colour(vehicles[i], RGBToInt(0, 0, 0))
                vehicle.set_vehicle_custom_secondary_colour(vehicles[i], RGBToInt(0, 0, 0))
                vehicle.set_vehicle_custom_pearlescent_colour(vehicles[i], RGBToInt(0, 0, 0)) 
            end
            system.wait(0)
        end
    end

    for i = 1, #vehicles do
        if (not feat_toggle_val.on) then
            entity.set_entity_as_mission_entity(vehicles[i], true, true)
        end
    end
end):set_str_data({"AHAIRDRESSERSCAR", "IWANTITPAINTEDBLACK"})

menu.add_feature("Custom Traffic Color", "toggle", vehicle_stuff.id, function(feat_toggle)
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
        for i = 1, #vehicles do
            network.request_control_of_entity(vehicles[i])
            vehicle.set_vehicle_custom_primary_colour(vehicles[i], tonumber("0x" .. k))
            vehicle.set_vehicle_custom_secondary_colour(vehicles[i], tonumber("0x" .. k))
            system.wait(0)
        end
    end

    for i = 1, #vehicles do
        if (not feat_toggle.on) then
            entity.set_entity_as_mission_entity(vehicles[i], true, true)
        end
    end
end)

menu.add_feature("Crazy Vehicles", "value_str", vehicle_stuff.id, function(feat_toggle_val)
    local vehicles
    while (feat_toggle_val.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            network.request_control_of_entity(vehicles[i])
            if (feat_toggle_val.value == 0) then
                vehicle.set_vehicle_engine_torque_multiplier_this_frame(vehicles[i], math.random(1.0, 10.0))
                system.wait(0)
            elseif (feat_toggle_val.value == 1) then
                vehicle.set_vehicle_reduce_grip(vehicles[i], true)
                vehicle.set_vehicle_engine_torque_multiplier_this_frame(vehicles[i], math.random(50.0, 100.0))
                system.wait(0)
            elseif (feat_toggle_val.value == 2) then
                local wheelcount = vehicle.get_vehicle_wheel_count(vehicles[i])
                if wheelcount ~= nil then
                    for count = 0, wheelcount + 1 do
                        network.request_control_of_entity(vehicles[i])
                        vehicle.set_vehicle_tire_burst(vehicles[i], count, true, 1000)
                    end
                end
                vehicle.set_vehicle_reduce_grip(vehicles[i], true)
                vehicle.set_vehicle_engine_torque_multiplier_this_frame(vehicles[i], math.random(50.0, 100.0))
                system.wait(0)
            end
        end
    end

    for i = 1, #vehicles do
        if (not feat_toggle_val.on) then
            entity.set_entity_as_mission_entity(vehicles[i], true, true)
        end
    end
end):set_str_data({"Normal Mode", "Crazy Mode", "Ultra Crazy Mode"})

menu.add_feature("Vehicles Leak Oil", "toggle", vehicle_stuff.id, function(feat_toggle_val)
    local vehicles
    while (feat_toggle_val.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            network.request_control_of_entity(vehicles[i])
            vehicle.set_vehicle_engine_torque_multiplier_this_frame(vehicles[i], math.random(1.0, 10.0))
            fire.add_explosion(entity.get_entity_coords(vehicles[i]), 67, false, false, 0, player.player_id())
            vehicle.set_vehicle_forward_speed(vehicles[i], 5.0)
            system.wait(10)
        end
    end

    for i = 1, #vehicles do
        if (not feat_toggle_val.on) then
            entity.set_entity_as_mission_entity(vehicles[i], true, true)
        end
    end
end)

menu.add_feature("Launch Random Vehicles", "toggle", vehicle_stuff.id, function(feat_toggle)
    local vehicles
    while (feat_toggle.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            network.request_control_of_entity(vehicles[i])
            vehicle.set_vehicle_forward_speed(vehicles[i], 100.0)
            system.wait(0)
        end
    end

    for i = 1, #vehicles do
        if (not feat_toggle.on) then
            entity.set_entity_as_mission_entity(vehicles[i], true, true)
        end
    end
end)

menu.add_feature("Anti-Gravity Vehicles", "toggle", vehicle_stuff.id, function(feat_toggle)
    local vehicles
    while (feat_toggle.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            network.request_control_of_entity(vehicles[i])
            if (not network.has_control_of_entity(vehicles[i])) then
                network.request_control_of_entity(vehicles[i])
            end

            entity.set_entity_gravity(vehicles[i], false)
            local existing_velocity = entity.get_entity_velocity(vehicles[i])
            entity.set_entity_velocity(vehicles[i], v3(0, 0, 1))
            system.wait(0)
        end
    end

    for i = 1, #vehicles do
        if (not feat_toggle.on) then
            entity.set_entity_as_mission_entity(vehicles[i], true, true)
        end
    end
end)

menu.add_feature("Bouncing Vehicles", "value_str", vehicle_stuff.id, function(feat_toggle_val)
    local jump_heights = {3, 6, 10}
    local vehicles
    while (feat_toggle_val.on) do
        vehicles = vehicle.get_all_vehicles()
        for i = 1, #vehicles do
            network.request_control_of_entity(vehicles[i])
            local existing_velocity = entity.get_entity_velocity(vehicles[i])
            entity.set_entity_velocity(vehicles[i], v3(existing_velocity.x, existing_velocity.y, jump_heights[feat_toggle_val.value+1]))
            system.wait(25)
        end
    end

    for i = 1, #vehicles do
        if (not feat_toggle_val.on) then
            entity.set_entity_as_mission_entity(vehicles[i], true, true)
        end
    end
end):set_str_data({"Low Jump", "Medium Jump", "High Jump"})

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

menu.add_feature("Øzark Text Color", "action", ozark_text.id, function(feat)
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

menu.add_feature("Øzark F4 Text Color", "action", ozark_text.id, function(feat)
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
    "We totally got a CnD from TakeTwo lmaoooooo",
    "fun menu?",
    "Yes this is Fun Menu"
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

local uppercase_ozark_text = menu.add_feature("UPPERCASE TEXT?", "toggle", ozark_text.id, function(feat_toggle)
    settings["uppercase_ozark_text"] = feat_toggle.on
end)
uppercase_ozark_text.on = settings["uppercase_ozark_text"]

menu.add_feature("Random Øzark F4 Text", 'value_str', ozark_text.id, function(feat_toggle_val)
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

menu.add_feature("Put Me in Coach Text", 'value_str', ozark_text.id, function(feat_toggle_val)
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
                                                                                                    

local random_outfits = menu.add_feature("Random Outfits", "parent", character_looks.id)
menu.add_feature("Random Tux Outfit", "action", random_outfits.id, function(feat)
    wipeOutfitsClean(player.get_player_ped(player.player_id()))
    randomTuxedoOutfit(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Random Tropical Outfit", "action", random_outfits.id, function(feat)
    wipeOutfitsClean(player.get_player_ped(player.player_id()))
    randomTropicalOutfit(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Random Beach Outfit", "action", random_outfits.id, function(feat)
    wipeOutfitsClean(player.get_player_ped(player.player_id()))
    randomBeachOutfit(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Random Golf Outfit", "action", random_outfits.id, function(feat)
    wipeOutfitsClean(player.get_player_ped(player.player_id()))
    randomGolferOutfit(player.get_player_ped(player.player_id()))
end)

menu.add_feature("Make Self an Old Codger", "action", character_looks.id, function(feat)
    local codger_colors = {
        hair_color = select(math.random(1, 3), 26, 27, 28),
        hair_highlight_color = select(math.random(1, 3), 26, 27, 28)
    }
    ped.set_ped_head_overlay(player.get_player_ped(player.player_id()), 3, 14, 1.0)
    ped.set_ped_hair_colors(player.get_player_ped(player.player_id()), codger_colors["hair_color"], codger_colors["hair_highlight_color"]) -- hair colors
    ped.set_ped_head_overlay_color(player.get_player_ped(player.player_id()), 1, 1, codger_colors["hair_color"], codger_colors["hair_highlight_color"]) -- facial hair colors
end)

menu.add_feature("Random Headblend", "action_value_str", character_looks.id, function(feat_val)
    if (feat_val.value == 0) then
        randomizeHeadBlend(player.get_player_ped(player.player_id()))
    elseif (feat_val.value == 1) then
        extraFaceFeatures(player.get_player_ped(player.player_id()))
    elseif (feat_val.value == 2) then
        extraFaceFeatures(player.get_player_ped(player.player_id()))
        evenMoreExtraFeatures(player.get_player_ped(player.player_id()))
    end
end):set_str_data({"Base Face Shape", "w/ Face Features", "w/ More Face Features"})

menu.add_feature("Random Face Features", "action_value_str", character_looks.id, function(feat_val)
    if (feat_val.value == 0) then
        extraFaceFeatures(player.get_player_ped(player.player_id()))
    elseif (feat_val.value == 1) then
        extraFaceFeatures(player.get_player_ped(player.player_id()))
        evenMoreExtraFeatures(player.get_player_ped(player.player_id()))
    end
end):set_str_data({"Base Face Features", "Extra Face Features"})

menu.add_feature("Random Funky Hair Color", "action", character_looks.id, function(feat_val)
    local funky_hair = math.random(30, 54)
    ped.set_ped_hair_colors(player.get_player_ped(player.player_id()), funky_hair, funky_hair) -- hair colors
    ped.set_ped_head_overlay_color(player.get_player_ped(player.player_id()), 1, 1, funky_hair, funky_hair) -- facial hair colors
end)

menu.add_feature("Make Self Barefoot", "action", character_looks.id, function(feat)
    if (player.is_player_female(player.player_id())) then
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 6, 35, 0, 0) -- feet
    else
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 6, 34, 0, 0) -- feet
    end
end)

menu.add_feature("Make Self Shirtless", "action", character_looks.id, function(feat)
    ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 3, 15, 0, 0)
    ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 11, 15, 0, 0)
    ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 8, 15, 0, 0)
    ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 7, 0, 0, 0)
end)

--    _   __ ____   ______   _____ ______ __  __ ______ ______
--   / | / // __ \ / ____/  / ___//_  __// / / // ____// ____/
--  /  |/ // /_/ // /       \__ \  / /  / / / // /_   / /_    
-- / /|  // ____// /___    ___/ / / /  / /_/ // __/  / __/    
--/_/ |_//_/     \____/   /____/ /_/   \____//_/    /_/       
                                                            
local _peds = {}

----### Configure follower attributes. ###----
local outfits_value = 0
local follower_outfits = menu.add_feature("Follower(s)' Outfits", "autoaction_value_str", npc_stuff.id, function(val)
    outfits_value = val
    menu.notify("Follower outfit set!", fun_menu_ver)
end):set_str_data({"Tuxedo", "Tropical", "Own Outfit"})

menu.add_feature("Can Followers Enter Vehicle?", "action_value_str", npc_stuff.id, function(val)
    local player_veh = player.get_player_vehicle(player.player_id())

    if (val.value == 0) then
        for i = 1, #_peds do
            if (player.is_player_in_any_vehicle(player.player_id())) then
                ped.set_ped_into_vehicle(_peds[i], player_veh, vehicle.get_free_seat(player_veh))
            else
                ai.task_leave_vehicle(_peds[i], player_veh, 1)
            end
        end
    else
        for i = 1, #_peds do
            ai.task_leave_vehicle(_peds[i], player_veh, 1)
        end
    end
end):set_str_data({"Yes", "No"})

menu.add_feature("Alter Follower(s)' Outfits", "action_value_str", npc_stuff.id, function(feat_val)
    for i = 1, #_peds do
        network.request_control_of_entity(_peds[i])

        if (feat_val.value == 0) then
            wipeOutfitsClean(_peds[i])
            randomTuxedoOutfit(_peds[i])
        elseif (feat_val.value == 1) then
            wipeOutfitsClean(_peds[i])
            randomTropicalOutfit(_peds[i])
        elseif (feat_val.value == 2) then
            wipeOutfitsClean(_peds[i])
            copyPlayerOutfitToClone(player.get_player_ped(player.player_id()), _peds[i])
        end
    end
end):set_str_data({"Tuxedo", "Tropical", "Copy Own Outfit"})

local follower_count = menu.add_feature("Follower Count", "autoaction_value_i", npc_stuff.id)
follower_count.min = 1
follower_count.max = 5
follower_count.mod = 1
follower_count.value = 1

local follower_range = menu.add_feature("Follower Wander Range", "autoaction_value_i", npc_stuff.id)
follower_range.min = 5
follower_range.max = 30
follower_range.mod = 1
follower_range.value = 2

local follower_wander = menu.add_feature("Wandering Follower(s)?", "toggle", npc_stuff.id, function(feat_toggle)
    settings["wandering_follower"] = feat_toggle.on
end)
follower_wander.on = settings["wandering_follower"]

----### Spawn in some clones to follow your around. ###----
menu.add_feature("Spawn Clone Follower(s)", "toggle", npc_stuff.id, function(feat_toggle)
    local MP_ped
    if (player.is_player_female(player.player_id())) then
        MP_ped = 0x9C9EFFD8
    else
        MP_ped = 0x705E61F2
    end

    for i = 1, follower_count.value do
        _peds[i] = ped.create_ped(1, MP_ped, player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), math.random(0, 360), true, false)
        createClone(player.get_player_ped(player.player_id()), _peds[i])

        if (outfits_value.value == 0) then
            wipeOutfitsClean(_peds[i])
            randomTuxedoOutfit(_peds[i])
        elseif (outfits_value.value == 1) then
            wipeOutfitsClean(_peds[i])
            randomTropicalOutfit(_peds[i])
        elseif (outfits_value.value == 2) then
            wipeOutfitsClean(_peds[i])
            copyPlayerOutfitToClone(player.get_player_ped(player.player_id()), _peds[i])
        end
        system.wait(100)
        addBlip(_peds[i], 280)
    end

    while feat_toggle.on do
        for i = 1, follower_count.value do
            local entity_pos = entity.get_entity_coords(_peds[i])
            local player_pos1 = player.get_player_coords(player.player_id()) + v3(follower_range.value, follower_range.value, follower_range.value)
            local player_pos2 = player.get_player_coords(player.player_id()) + v3(-follower_range.value, -follower_range.value, -follower_range.value)

            network.request_control_of_entity(_peds[i])
            while not network.has_control_of_entity(_peds[i]) do
                network.request_control_of_entity(_peds[i])
                system.wait(50)
            end

            if (entity_pos.x <= player_pos1.x) and (entity_pos.y <= player_pos1.y) and (entity_pos.z <= player_pos1.z) and (entity_pos.x >= player_pos2.x) and (entity_pos.y >= player_pos2.y) and (entity_pos.z >= player_pos2.z) then
                if (settings["wandering_follower"]) then
                    ai.task_go_to_coord_by_any_means(_peds[i], player.get_player_coords(player.player_id()) + v3(math.random(-follower_range.value, follower_range.value), math.random(-follower_range.value, follower_range.value), 0), 1, 0, true, 1, 0.0)
                end
            else
                ai.task_goto_entity(_peds[i], player.get_player_ped(player.player_id()), -1, -1, 25.0)
            end

            if (entity.is_entity_dead(_peds[i])) then
                feat_toggle.on = false
            end
        end
        system.wait(5000)
    end

    for i = 1, follower_count.value do
        if (not feat_toggle.on) then
            entity.set_entity_as_mission_entity(_peds[i], true, true)
            entity.delete_entity(_peds[i])
            system.wait(250)
            follower_wander.on = false
            settings["wandering_follower"] = false
        end
    end
end)

----### Spawn in some random generated gtao characters to follow your around. ###----
menu.add_feature("Spawn Follower(s)", "value_str", npc_stuff.id, function(feat_toggle_val)
    local MP_ped
    local zero_or_one

    for i = 1, follower_count.value do
        zero_or_one = math.random(0, 1)

        if (zero_or_one == 1) then
            MP_ped = 0x9C9EFFD8
        else
            MP_ped = 0x705E61F2
        end

        _peds[i] = ped.create_ped(1, MP_ped, player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), math.random(0, 360), true, false)
        if (feat_toggle_val.value == 0) then
            removeExtraFaceFeatures(_peds[i])
            randomizeHeadBlend(_peds[i])
        elseif (feat_toggle_val.value == 1) then
            randomizeHeadBlend(_peds[i])
            extraFaceFeatures(_peds[i])
        elseif (feat_toggle_val.value == 2) then
            randomizeHeadBlend(_peds[i])
            extraFaceFeatures(_peds[i])
            evenMoreExtraFeatures(_peds[i])
        end

        if (outfits_value.value == 0) then
            wipeOutfitsClean(_peds[i])
            randomTuxedoOutfit(_peds[i])
        elseif (outfits_value.value == 1) then
            wipeOutfitsClean(_peds[i])
            randomTropicalOutfit(_peds[i])
        end
        system.wait(100)
        addBlip(_peds[i], 280)
    end

    while feat_toggle_val.on do
        for i = 1, follower_count.value do
            local entity_pos = entity.get_entity_coords(_peds[i])
            local player_pos1 = player.get_player_coords(player.player_id()) + v3(follower_range.value, follower_range.value, follower_range.value)
            local player_pos2 = player.get_player_coords(player.player_id()) + v3(-follower_range.value, -follower_range.value, -follower_range.value)

            network.request_control_of_entity(_peds[i])
            while not network.has_control_of_entity(_peds[i]) do
                network.request_control_of_entity(_peds[i])
                system.wait(50)
            end

            if (entity_pos.x <= player_pos1.x) and (entity_pos.y <= player_pos1.y) and (entity_pos.z <= player_pos1.z) and (entity_pos.x >= player_pos2.x) and (entity_pos.y >= player_pos2.y) and (entity_pos.z >= player_pos2.z) then
                if (settings["wandering_follower"]) then
                    ai.task_go_to_coord_by_any_means(_peds[i], player.get_player_coords(player.player_id()) + v3(math.random(-follower_range.value, follower_range.value), math.random(-follower_range.value, follower_range.value), 0), 1, 0, true, 1, 0.0)
                end
            else
                ai.task_goto_entity(_peds[i], player.get_player_ped(player.player_id()), -1, -1, 25.0)
            end

            if (entity.is_entity_dead(_peds[i])) then
                feat_toggle_val.on = false
            end
        end
        system.wait(5000)
    end

    for i = 1, follower_count.value do
        if (not feat_toggle_val.on) then
            entity.set_entity_as_mission_entity(_peds[i], true, true)
            entity.delete_entity(_peds[i])
            system.wait(250)
            follower_wander.on = false
            settings["wandering_follower"] = false
        end
    end
end):set_str_data({"Base Face Shape", "w/ Face Features", "w/ More Face Features"})


--    ____   ______ ______ _____
--   / __ \ / ____//_  __// ___/
--  / /_/ // __/    / /   \__ \ 
-- / ____// /___   / /   ___/ / 
--/_/    /_____/  /_/   /____/  
                              
local wander = menu.add_feature("Wandering Pet(s)?", "toggle", pet_menu.id, function(feat_toggle)
    settings["wandering_pet"] = feat_toggle.on
end)
wander.on = settings["wandering_pet"]

menu.add_feature("Get a Cat", "toggle", pet_menu.id, function(feat_toggle)
    requestAnimDictAndSet("creatures@cat@amb@world_cat_sleeping_ground@base", "base")
    requestModel(gameplay.get_hash_key("A_C_Cat_01"))

    local _cat = ped.create_ped(5, gameplay.get_hash_key("A_C_Cat_01"), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), 0, true, false)
    entity.set_entity_god_mode(_cat, true)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("A_C_Cat_01"))
    addBlip(_cat, 442)

    while feat_toggle.on do
        animalAI(_cat, player.player_id(), "creatures@cat@amb@world_cat_sleeping_ground@base", "base", wander.on)
        system.wait(5000)
    end

    if (not feat_toggle.on) then
        entity.set_entity_as_mission_entity(_cat, true, true)
        entity.delete_entity(_cat)
        unloadAnim("creatures@cat@amb@world_cat_sleeping_ground@base", "base")
    end
end)

menu.add_feature("Get a Retriever", "toggle", pet_menu.id, function(feat_toggle)
    requestAnimDictAndSet("creatures@retriever@amb@world_dog_sitting@base", "base")
    requestModel(gameplay.get_hash_key("A_C_Retriever"))

    local _retriever = ped.create_ped(5, gameplay.get_hash_key("A_C_Retriever"), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), 0, true, false)
    entity.set_entity_god_mode(_retriever, true)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("A_C_Retriever"))
    addBlip(_retriever, 442)

    while feat_toggle.on do
        animalAI(_retriever, player.player_id(), "creatures@retriever@amb@world_dog_sitting@base", "base", wander.on)
        system.wait(5000)
    end

    if (not feat_toggle.on) then
        entity.set_entity_as_mission_entity(_retriever, true, true)
        entity.delete_entity(_retriever)
        unloadAnim("creatures@retriever@amb@world_dog_sitting@base", "base")
    end
end)

menu.add_feature("Get a Pug", "toggle", pet_menu.id, function(feat_toggle)
    requestAnimDictAndSet("creatures@pug@amb@world_dog_sitting@base", "base")
    requestModel(gameplay.get_hash_key("A_C_Pug"))

    local _pug = ped.create_ped(5, gameplay.get_hash_key("A_C_Pug"), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), 0, true, false)
    entity.set_entity_god_mode(_pug, true)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("A_C_Pug"))
    addBlip(_pug, 442)

    while feat_toggle.on do
        animalAI(_pug, player.player_id(), "creatures@pug@amb@world_dog_sitting@base", "base", wander.on)
        system.wait(5000)
    end

    if (not feat_toggle.on) then
        entity.set_entity_as_mission_entity(_pug, true, true)
        entity.delete_entity(_pug)
        unloadAnim("creatures@pug@amb@world_dog_sitting@base", "base")
    end
end)

menu.add_feature("Get a Rottweiler", "toggle", pet_menu.id, function(feat_toggle)
    requestAnimDictAndSet("creatures@rottweiler@amb@world_dog_sitting@base", "base")
    requestModel(gameplay.get_hash_key("A_C_Rottweiler"))

    local _rottweiler = ped.create_ped(5, gameplay.get_hash_key("A_C_Rottweiler"), player.get_player_coords(player.player_id()) + v3(math.random(-2, 2), math.random(-2, 2), 0), 0, true, false)
    entity.set_entity_god_mode(_rottweiler, true)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("A_C_Rottweiler"))
    addBlip(_rottweiler, 442)

    while feat_toggle.on do
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
                                                                                             
local time_in_ms = menu.add_feature("Snowball Explosion (ms)", "value_i", miscellaneous.id, function(feat_toggle)
    while feat_toggle.on do
        fire.add_explosion(player.get_player_coords(player.player_id()), 39, true, false, 0, player.player_id())
        system.wait(feat_toggle.value)
    end
end)
time_in_ms.min = 500
time_in_ms.max = 1000
time_in_ms.mod = 50
time_in_ms.value = 750

menu.add_feature("Clumsiness", "value_str", miscellaneous.id, function(feat_toggle_val)
    while (feat_toggle_val.on) do
        if (feat_toggle_val.value == 0) then
            if (math.random(1, 16) == 4) then
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 1300, 2400, -6)
            elseif (math.random(1, 16) == 7) then
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 0, 350, 0)
            end
        elseif (feat_toggle_val.value == 1) then
            if (math.random(1, 16) == 4) then
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 1300, 2400, -6)
            elseif (math.random(1, 16) == 7) then
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 0, 350, 0)
            elseif (math.random(1, 16) == 13) then
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 200, 1000, 2)
            end
        elseif (feat_toggle_val.value == 2) then
            if (math.random(1, 12) == 4) then
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 1300, 2400, -6)
            elseif (math.random(1, 16) == 7) then
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 0, 350, 0)
            elseif (math.random(1, 16) == 12) then
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 200, 1000, 2)
            elseif (math.random(1, 16) == 16) then
                ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 300, 1400, 11)
            end
        end
        system.wait(1000)
    end
end):set_str_data({"Clumsy", "Really Clumsy", "Extremely Clumsy"})

menu.add_feature("Trip on Something", "action_value_str", miscellaneous.id, function(feat_val)
    if (feat_val.value == 0) then
        ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 1300, 2400, -6)
    elseif (feat_val.value == 1) then
        ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 0, 350, 0)
    elseif (feat_val.value == 2) then
        ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 200, 1000, 2)
    end
end):set_str_data({"1", "2", "3"})

menu.add_feature("Get Waypoint Coords", "action", miscellaneous.id, function(feat)
    local waypoint = ui.get_waypoint_coord()
    menu.notify("Waypoint Coords:\nX = " .. waypoint.x .. "\nY = " .. waypoint.y, fun_menu_ver)
end)

local rockstar_chat
menu.add_feature("Rockstar Chat", "action_value_str", miscellaneous.id, function(feat_val)
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


menu.add_feature("Asteroid Shower", "toggle", miscellaneous.id, function(feat_toggle)
    local spawned_asteroids = {}
    requestModel(3751297495) --asteroid

    --gameplay.set_override_weather(7)
    while (feat_toggle.on) do
        if (#spawned_asteroids < 50) then
            local pos = player.get_player_coords(player.player_id())
            pos.x = math.random(math.floor(pos.x - 250), math.floor(pos.x + 250))
            pos.y = math.random(math.floor(pos.y - 250), math.floor(pos.y + 250))
            pos.z = pos.z + math.random(120, 240)
            local asteroid = object.create_object(3751297495, pos, true, true)
            streaming.set_model_as_no_longer_needed(3751297495)
            table.insert(spawned_asteroids, {["asteroid"] = asteroid})

            entity.apply_force_to_entity(asteroid, select(math.random(1, 2), 1, 3), 0, 0, -125, 0, 0, 0, true, true)
        else
            system.wait(15500)
            for k, asteroid in pairs(spawned_asteroids) do
                entity.set_entity_as_no_longer_needed(asteroid.asteroid)
                entity.delete_entity(asteroid.asteroid)
                spawned_asteroids[k] = nil
            end
        end
        system.wait(500)
    end

    if (not feat_toggle.on) then
        --gameplay.clear_override_weather()
        for k, asteroid in pairs(spawned_asteroids) do
            entity.set_entity_as_no_longer_needed(asteroid.asteroid)
            entity.delete_entity(asteroid.asteroid)
            spawned_asteroids[k] = nil
        end
    end
end)


menu.add_player_feature("Floppa Gun", "toggle", 0, function(player_feat, pid)
    if player_feat.on then
        customAmmoShooter(307287994, pid)
    end
    return HANDLER_CONTINUE
end)

menu.add_player_feature("Orbital Gun", "toggle", 0, function(player_feat, pid)
    if player_feat.on then
        customAmmoShooter(72, pid)
    end
    return HANDLER_CONTINUE
end)

menu.add_player_feature("Custom Explosion Gun", "toggle", 0, function(player_feat_toggle, pid)
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

menu.add_player_feature("Custom Entity Gun", "toggle", 0, function(player_feat_toggle, pid)
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