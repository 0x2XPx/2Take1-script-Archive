




ui.notify_above_map("Loading the At0m1c B0mb", "At0m1c", 215)
ui.notify_above_map("Ready To Launch", "At0m1c", 210)

local MyId = player.player_id
local getPed = player.get_player_ped
local function own_ped()
    return getPed(MyId())
end

local cages =  menu.add_player_feature("At0m1c", "parent", 0, function(feat, pid)
end).id

local Cage = menu.add_player_feature("Loops", "parent", cages).id

menu.add_player_feature("Ceo Ban Loop ", "toggle", Cage, function(feat, pid)
    if feat.on then
    system.wait(2)
        script.trigger_script_event(-327286343, pid, {-1, 0})
        script.trigger_script_event(-738295409, pid, {-1, 0})
        script.trigger_script_event(-738295409, pid, {0, 1, 5, 0})
    end
    return HANDLER_CONTINUE
    end)

menu.add_player_feature("Ceo Kick Loop", "toggle", Cage, function(feat, pid)
        if feat.on then
        system.wait(2)
            script.trigger_script_event(-701823896, pid, {-1, 0})
            script.trigger_script_event(-1648921703, pid, {-1, 0})
            script.trigger_script_event(-1648921703, pid, {1, 1, 6})
            script.trigger_script_event(-1648921703, pid, {0, 1, 5})
        end
        return HANDLER_CONTINUE
        end)

menu.add_player_feature("Vehicle Kick Loop", "toggle", Cage, function(feat, pid)
        if feat.on then
        system.wait(2)
            script.trigger_script_event(-1333236192, pid, {-1, 0})
            script.trigger_script_event(-1089379066, pid, {-1, 0})
        end
        return HANDLER_CONTINUE
        end)

menu.add_player_feature("Apartment Invite Loop", "toggle", Cage, function(feat, pid)
        if feat.on then
        system.wait(2)
        script.trigger_script_event(-171207973, pid, {-1, 0})
        script.trigger_script_event(1114696351, pid, {-1, 0})
        script.trigger_script_event(2027212960, pid, {-1, 0})
        script.trigger_script_event(0xf5cb92db, pid, {-1, 0})
        script.trigger_script_event(0x4270ea9f, pid, {-1, 0})
        script.trigger_script_event(0x78d4d0a0, pid, {-1, 0})
        script.trigger_script_event(0xf5cb92db, pid, {-171207973})
        script.trigger_script_event(0x4270ea9f, pid, {1114696351})
        script.trigger_script_event(0x78d4d0a0, pid, {2027212960})
         end
         return HANDLER_CONTINUE
         end)

menu.add_player_feature("Send To Island Loop", "toggle", Cage, function(feat, pid)
        if feat.on then
        system.wait(2)
        script.trigger_script_event(0x4d8b1e65, pid, {-1, 0})
        script.trigger_script_event(1300962917, pid, {-1, 0})
         end
         return HANDLER_CONTINUE
         end)

menu.add_player_feature("Destroy Personal Vehicle Loop", "toggle", Cage, function(feat, pid)
        if feat.on then
        system.wait(2)
        script.trigger_script_event(-1662268941, pid, {-1, 0})
         end
         return HANDLER_CONTINUE
         end)

local Cage = menu.add_player_feature("Trolls", "parent", cages).id

menu.add_player_feature("LOL Their Car", "action", Cage, function(playerfeat, pid)
                    local pos1 = player.get_player_coords(pid)
                    pos1.z = pos1.z + 0.10                                     
                    local cageobjecthash = gameplay.get_hash_key("prop_beach_fire") 
                    local cageobject = object.create_object(cageobjecthash, pos1, true, false)
                    entity.set_entity_visible(cageobject, false)

                    local playerped3 = player.get_player_ped(pid)
                    local pos = v3()
                    attach_object1132 = object.create_object(-1065766299, pos, true, false)
                    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)
                    entity.set_entity_visible(attach_object1132, false)
                    
                    end)
              
          
                
                menu.add_player_feature("Burn The Target", "action", Cage, function(playerfeat, pid)

                    local playerped3 = player.get_player_ped(pid)
                    local pos = v3()
                    attach_object1132 = object.create_object(-1065766299, pos, true, false)
                    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)
                    end)

menu.add_player_feature("Conehead", "action", Cage, function(playerfeat, pid)

                    local playerped3 = player.get_player_ped(pid)                                    
                    local pos = v3()
                    pos.z = pos.z + 0.50
                    attach_object1132 = object.create_object(-1059647297, pos, true, false)
                    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)
                    end)


menu.add_player_feature("Burning Conehead", "action", Cage, function(playerfeat, pid)

                    local playerped3 = player.get_player_ped(pid)
                    local pos = v3()
                    attach_object1132 = object.create_object(-1065766299, pos, true, false)
                    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)

                     local playerped3 = player.get_player_ped(pid)
                    local pos = v3()
                    attach_object1132 = object.create_object(546252211, pos, true, false)
                    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)
                    end)

menu.add_player_feature("Trashman", "action", Cage, function(playerfeat, pid)
                    

                    local playerped3 = player.get_player_ped(pid)
                    local pos = v3()
                    pos.z = pos.z + 0.10
                    attach_object1132 = object.create_object(-93819890, pos, true, false)
                    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)

                    local pos1 = player.get_player_coords(pid)
                    pos1.z = pos1.z + 0.10                                     
                    local cageobjecthash = gameplay.get_hash_key("prop_ld_rub_binbag_01") 
                    local cageobject = object.create_object(cageobjecthash, pos1, true, false)
                    end)


menu.add_player_feature("Cactus Jack", "action", Cage, function(playerfeat, pid)
local playerped3 = player.get_player_ped(pid)
                    local pos = v3()
                    pos.z = pos.z -0.10
                    attach_object1132 = object.create_object(-194496699, pos, true, false)
                    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)
                     end)

menu.add_player_feature("Soccer Boy", "action", Cage, function(playerfeat, pid)
  
                    local pos1 = player.get_player_coords(pid)
                    pos1.z = pos1.z + 0.10                                     
                    local cageobjecthash = gameplay.get_hash_key("p_ld_soc_ball_01") 
                    local cageobject = object.create_object(cageobjecthash, pos1, true, false)
                end)


menu.add_player_feature("Football Boy", "action", Cage, function(playerfeat, pid)
  
                    local pos1 = player.get_player_coords(pid)
                    pos1.z = pos1.z + 0.10                                     
                    local cageobjecthash = gameplay.get_hash_key("p_ld_am_ball_01") 
                    local cageobject = object.create_object(cageobjecthash, pos1, true, false)
                end)


menu.add_player_feature("Basketball Boy", "action", Cage, function(playerfeat, pid)
  
                    local pos1 = player.get_player_coords(pid)
                    pos1.z = pos1.z + 0.10                                     
                    local cageobjecthash = gameplay.get_hash_key("prop_bskball_01") 
                    local cageobject = object.create_object(cageobjecthash, pos1, true, false)
                end)

local Cage = menu.add_player_feature("Tools", "parent", cages).id

local rpg = menu.add_feature("Rapid RPG Switch", "toggle", 0, function(feat)

        if feat.on then
            
            pped = player.get_player_ped(player.player_id())

            if ped.is_ped_shooting(pped) then
                if ped.get_current_ped_weapon(pped) == 2982836145 then

                    weapon.remove_weapon_from_ped(pped, 2982836145)
                    -- system.wait(0)
                    weapon.give_delayed_weapon_to_ped(pped, 2982836145, 0, 1)

                end
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
end)
rpg.on = true

local grenade = menu.add_feature("Rapid Grenade Launcher Switch", "toggle", 0, function(feat)

        if feat.on then
            
            pped = player.get_player_ped(player.player_id())

            if ped.is_ped_shooting(pped) then
                if ped.get_current_ped_weapon(pped) == 2726580491 then

                    weapon.remove_weapon_from_ped(pped, 2726580491)
                    -- system.wait(0)
                    weapon.give_delayed_weapon_to_ped(pped, 2726580491, 0, 1)

                end
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
end)
grenade.on = true

    












                  









