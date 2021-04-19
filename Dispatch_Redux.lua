local x = {} --  feature table
local q = {} --  shortcut table
-- CodeNames
local Feds = {}
local FedCar = {}
local Cop = {}
local Cop2 = {}
local Copcar = {}
local Copbike = {}
local NooseRiot = {}
local NooseAPCCar = {}
local Lamar = {}
local Lamarcar = {}
local Lazer = {}
local Lazerplane = {}
local DemiHydra = {}
local Hydra = {}
local Nooseteam = {}
local NooseAPC = {}
local Coast = {}
local CoastBoat = {}
local Feds2 = {}
local FIBHeliGuy = {}
local FIBBuzzard = {}
local Hunter = {}
local HunterHeli = {}
local Mod = {}
local Modheli = {}
local Mod2 = {}
local carvesh = {}
local c = {
    id = player.player_id,
}


    -- Shortcuts
        q.set_mod = vehicle.set_vehicle_mod
        q.get_p_car = ped.get_vehicle_ped_is_using
        q.is_in_vehicle = player.is_player_in_any_vehicle
        q.eGod = entity.set_entity_god_mode
        q.eIsGod = entity.get_entity_god_mode
        q.pC = ped.create_ped
        q.vehT = vehicle.set_vehicle_mod_kit_type
        q.eS = entity.get_entity_speed
        q.pCoords = player.get_player_coords
        q.ms = utils.time_ms


--player
    x.Dispatchx = menu.add_player_feature("Dispatch's menu", "parent", 0).id
    x.Cops = menu.add_player_feature("Cop's menu", "parent", x.Dispatchx).id
    x.Noose = menu.add_player_feature("Noose's menu", "parent", x.Dispatchx).id
    x.Army = menu.add_player_feature("Army's menu", "parent", x.Dispatchx).id
    x.FIB = menu.add_player_feature("FIB's menu", "parent", x.Dispatchx).id
    x.Coast = menu.add_player_feature("Coast's menu", "parent", x.Dispatchx).id
    x.Funny = menu.add_player_feature("Funny/Modder's menu", "parent", x.Dispatchx).id

    local function get_distance_between(entity_or_position_1, entity_or_position_2, is_looking_for_distance_between_coords)
            if is_looking_for_distance_between_coords then
                local distance_between = entity_or_position_1 - entity_or_position_2
                return math.abs(distance_between.x) + math.abs(distance_between.y)
            else
                local distance_between = entity.get_entity_coords(entity_or_position_1) - entity.get_entity_coords(entity_or_position_2)
                return math.abs(distance_between.x) + math.abs(distance_between.y)
            end
        end




-- Spawn a cop car
    x.Cop_car = menu.add_player_feature("Spawn Cop car", "toggle", x.Cops, function(x, pid)
        local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 15
            pos.y = pos.y + 0
            pos.z = pos.z - 0
            system.wait(100)
        local model = gameplay.get_hash_key("s_f_y_cop_01")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #Cop + 1
            Cop[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Cop >= 8 then
                    end
                    q.eGod(Cop[i], false)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0x79FBB0C5

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #Copcar + 1
                    Copcar[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(Copcar[y])
                    local blipid = ui.get_blip_from_entity(Copcar[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(Copcar[y], false)
                    ped.set_ped_combat_attributes(Cop[i], 46, false)
                    weapon.give_delayed_weapon_to_ped(Cop[i], 0xBFE256D4, 1, 1)
                    ped.set_ped_combat_attributes(Cop[i], 1, true)
                    ped.set_ped_combat_attributes(Cop[i], 3, true)
                    ped.set_ped_combat_attributes(Cop[i], 2, true)
                    ped.set_ped_combat_attributes(Cop[i], 4, true)
                    ped.set_ped_combat_range(Cop[i], 1)
                    ped.set_ped_combat_ability(Cop[i], 2)
                    if entity.is_entity_dead(Cop[i]) then return HANDLER_CONTINUE end
                    ped.set_ped_combat_movement(Cop[i], 2)
                    ped.set_ped_into_vehicle(Cop[i], Copcar[y], -1)

                     local i = #Cop + 1
            Cop[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Cop >= 8 then
                    end
                    q.eGod(Cop[i], false)
                    streaming.set_model_as_no_longer_needed(model)
                    ui.add_blip_for_entity(Cop[i])
                    local blipid = ui.get_blip_from_entity(Cop[i])
                    ui.set_blip_sprite(blipid, 188)

                    ped.set_ped_combat_attributes(Cop[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Cop[i], 0x555AF99A, 1, 1)
                    ped.set_ped_combat_attributes(Cop[i], 1, true)
                    ped.set_ped_combat_attributes(Cop[i], 3, true)
                    ped.set_ped_combat_attributes(Cop[i], 2, true)
                    ped.set_ped_combat_attributes(Cop[i], 52, false)
                    ped.set_ped_combat_attributes(Cop[i], 4, true)
                    ped.set_ped_combat_range(Cop[i], 1)
                    ped.set_ped_combat_ability(Cop[i], 2)
                    ped.set_ped_combat_movement(Cop[i], 2)
                    ped.set_ped_into_vehicle(Cop[i], Copcar[y], 0)
                        while x.on do
                        ai.task_combat_ped(Cop[i], pedp, 0, 16)
                        system.wait(25)
                           if entity.is_entity_dead(Cop[i]) then
                            entity.delete_entity(Cop[i])
                            entity.delete_entity(Copcar[y])
                            return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #Cop do
                                system.wait(25)
                        if get_distance_between(pedp, Cop[i]) > 400 then
                            network.request_control_of_entity(Cop[i])
                         entity.set_entity_as_no_longer_needed(Cop[i])
                         network.request_control_of_entity(Copcar[y])
                        entity.set_entity_as_no_longer_needed(Copcar[y])
                    end
                end
                end
                    while x.off do return HANDLER_POP
                    end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #Cop do
                    ped.get_all_peds(Cop[i])
        system.wait(25)
        network.request_control_of_entity(Cop[i])
                entity.set_entity_coords_no_offset(Cop[i], pos)
                entity.set_entity_as_no_longer_needed(Cop[i])
                entity.delete_entity(Cop[i])
                    end
                    for y = 1, #Copcar do
                    vehicle.get_all_vehicles(Copcar[y])
        system.wait(25)
        network.request_control_of_entity(Copcar[y])
                entity.set_entity_coords_no_offset(Copcar[y], pos)
                entity.set_entity_as_no_longer_needed(Copcar[y])
                entity.delete_entity(Copcar[y])
                end
            end)

-- Spawn a cop car
    x.Cop_car = menu.add_player_feature("Spawn Cop bike", "toggle", x.Cops, function(x, pid)
        local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 20
            pos.y = pos.y + 0
            pos.z = pos.z - 0
            system.wait(100)
        local model = gameplay.get_hash_key("s_m_y_hwaycop_01")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #Cop2 + 1
            Cop2[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Cop2 >= 8 then
                    end
                    q.eGod(Cop2[i], false)
                    streaming.set_model_as_no_longer_needed(model)
                     local vehhash = 0xFDEFAEC3
                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #Copbike + 1
                    Copbike[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(Copbike[y])
                    local blipid = ui.get_blip_from_entity(Copbike[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(Copbike[y], false)
                    ped.set_ped_combat_attributes(Cop2[i], 46, false)
                    weapon.give_delayed_weapon_to_ped(Cop2[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Cop2[i], 1, true)
                    ped.set_ped_combat_attributes(Cop2[i], 3, true)
                    ped.set_ped_combat_attributes(Cop2[i], 2, true)
                    ped.set_ped_combat_attributes(Cop2[i], 4, true)
                    ped.set_ped_combat_range(Cop2[i], 1)
                    ped.set_ped_combat_ability(Cop2[i], 2)
                    ped.set_ped_combat_movement(Cop2[i], 2)
                    ped.set_ped_into_vehicle(Cop2[i], Copbike[y], -1)

                    while x.on do
                        ai.task_combat_ped(Cop2[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(Cop2[i]) then
                            entity.delete_entity(Cop2[i])
                            entity.delete_entity(Copbike[y])
                            return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #Cop2 do
                                system.wait(25)
                        if get_distance_between(pedp, Cop2[i]) > 300 then
                            network.request_control_of_entity(Cop2[i])
                         entity.set_entity_as_no_longer_needed(Cop2[i])
                         network.request_control_of_entity(Copbike[y])
                        entity.set_entity_as_no_longer_needed(Copbike[y])
                    end
                end
                end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #Cop2 do
                    ped.get_all_peds(Cop[i])
        system.wait(25)
        network.request_control_of_entity(Cop2[i])
                entity.set_entity_coords_no_offset(Cop2[i], pos)
                entity.set_entity_as_no_longer_needed(Cop2[i])
                entity.delete_entity(Cop2[i])
                    end
                    for y = 1, #Copbike do
                    vehicle.get_all_vehicles(Copbike[y])
        system.wait(25)
        network.request_control_of_entity(Copbike[y])
                entity.set_entity_coords_no_offset(Copbike[y], pos)
                entity.set_entity_as_no_longer_needed(Copbike[y])
                entity.delete_entity(Copbike[y])
                end
            end)

     -- Spawn a Noose Team
    x.Noose_Team = menu.add_player_feature("Spawn Noose Team", "toggle", x.Noose, function(x, pid)
        local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 20
            pos.y = pos.y + 0
            pos.z = pos.z - 0
            system.wait(100)
        local model = gameplay.get_hash_key("s_m_y_swat_01")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #Nooseteam + 1
            Nooseteam[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Nooseteam >= 8 then
                    end
                    q.eGod(Nooseteam[i], false)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0xB822A1AA

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #NooseRiot + 1
                    NooseRiot[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(NooseRiot[y])
                    local blipid = ui.get_blip_from_entity(NooseRiot[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(NooseRiot[y], true)
                    ped.set_ped_combat_attributes(Nooseteam[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Nooseteam[i], 0x83BF0278, 1, 1)
                    ped.set_ped_combat_attributes(Nooseteam[i], 1, true)
                    ped.set_ped_combat_attributes(Nooseteam[i], 3, true)
                    ped.set_ped_prop_index(Nooseteam[i], 0, 0, 0, 0)
                    ped.set_ped_combat_attributes(Nooseteam[i], 2, true)
                    ped.set_ped_combat_attributes(Nooseteam[i], 52, false)
                    ped.set_ped_combat_attributes(Nooseteam[i], 4, true)
                    ped.set_ped_combat_range(Nooseteam[i], 1)
                    ped.set_ped_combat_ability(Nooseteam[i], 2)
                    ped.set_ped_combat_movement(Nooseteam[i], 2)
                    ped.set_ped_into_vehicle(Nooseteam[i], NooseRiot[y], -1)


            local i = #Nooseteam + 1
            Nooseteam[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Nooseteam >= 8 then
                    end
                    q.eGod(Nooseteam[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Nooseteam[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Nooseteam[i], 0x83BF0278, 1, 1)
                    ped.set_ped_combat_attributes(Nooseteam[i], 1, true)
                    ped.set_ped_combat_attributes(Nooseteam[i], 3, true)
                    ped.set_ped_prop_index(Nooseteam[i], 0, 0, 0, 0)
                    ped.set_ped_combat_attributes(Nooseteam[i], 2, true)
                    ped.set_ped_combat_attributes(Nooseteam[i], 52, false)
                    ped.set_ped_combat_attributes(Nooseteam[i], 4, true)
                    ped.set_ped_combat_range(Nooseteam[i], 1)
                    ped.set_ped_combat_ability(Nooseteam[i], 2)
                    ped.set_ped_combat_movement(Nooseteam[i], 2)
                    ped.set_ped_into_vehicle(Nooseteam[i], NooseRiot[y], 0)

                     local i = #Nooseteam + 1
            Nooseteam[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Nooseteam >= 8 then
                    end
                    q.eGod(Nooseteam[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Nooseteam[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Nooseteam[i], 0x83BF0278, 1, 1)
                    ped.set_ped_combat_attributes(Nooseteam[i], 1, true)
                    ped.set_ped_combat_attributes(Nooseteam[i], 3, true)
                    ped.set_ped_prop_index(Nooseteam[i], 0, 0, 0, 0)
                    ped.set_ped_combat_attributes(Nooseteam[i], 2, true)
                    ped.set_ped_combat_attributes(Nooseteam[i], 52, false)
                    ped.set_ped_combat_attributes(Nooseteam[i], 4, true)
                    ped.set_ped_combat_range(Nooseteam[i], 1)
                    ped.set_ped_combat_ability(Nooseteam[i], 2)
                    ped.set_ped_combat_movement(Nooseteam[i], 2)
                    ped.set_ped_into_vehicle(Nooseteam[i], NooseRiot[y], 1)


                     local i = #Nooseteam + 1
            Nooseteam[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Nooseteam >= 8 then
                    end
                    q.eGod(Nooseteam[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Nooseteam[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Nooseteam[i], 0x83BF0278, 1, 1)
                    ped.set_ped_combat_attributes(Nooseteam[i], 1, true)
                    ped.set_ped_combat_attributes(Nooseteam[i], 3, true)
                    ped.set_ped_prop_index(Nooseteam[i], 0, 0, 0, 0)
                    ped.set_ped_combat_attributes(Nooseteam[i], 2, true)
                    ped.set_ped_combat_attributes(Nooseteam[i], 52, false)
                    ped.set_ped_combat_attributes(Nooseteam[i], 4, true)
                    ped.set_ped_combat_range(Nooseteam[i], 1)
                    ped.set_ped_combat_ability(Nooseteam[i], 2)
                    ped.set_ped_combat_movement(Nooseteam[i], 2)
                    ped.set_ped_into_vehicle(Nooseteam[i], NooseRiot[y], 2)
                   while x.on do
                        ai.task_combat_ped(Nooseteam[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(Nooseteam[i])  then
                            entity.delete_entity(Nooseteam[i])
                            entity.delete_entity(NooseRiot[y]) return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #Nooseteam do
                                system.wait(25)
                                ai.task_combat_ped(Nooseteam[i], pedp, 0, 16)
                        if get_distance_between(pedp, Nooseteam[i]) > 300 then
                            network.request_control_of_entity(Nooseteam[i])
                         entity.set_entity_as_no_longer_needed(Nooseteam[i])
                         network.request_control_of_entity(NooseRiot[y])
                        entity.set_entity_as_no_longer_needed(NooseRiot[y])
                    end
                end
                end
                while x.off do return HANDLER_POP
                end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #Nooseteam do
                    ped.get_all_peds(Nooseteam[i])
        system.wait(25)
        network.request_control_of_entity(Nooseteam[i])
                entity.set_entity_coords_no_offset(Nooseteam[i], pos)
                entity.set_entity_as_no_longer_needed(Nooseteam[i])
                entity.delete_entity(Nooseteam[i])
                    end
                    for y = 1, #NooseRiot do
                    vehicle.get_all_vehicles(NooseRiot[y])
        system.wait(25)
        network.request_control_of_entity(NooseRiot[y])
                entity.set_entity_coords_no_offset(NooseRiot[y], pos)
                entity.set_entity_as_no_longer_needed(NooseRiot[y])
                entity.delete_entity(NooseRiot[y])
                end
            end)


-- Spawn a Noose APC
x.Noose_APC = menu.add_player_feature("Spawn Noose APC", "toggle", x.Noose, function(x, pid)

     local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 10
            pos.y = pos.y + 0
            pos.z = pos.z - 0
            system.wait(100)
        local model = gameplay.get_hash_key("s_m_y_swat_01")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #NooseAPC + 1
            NooseAPC[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #NooseAPC >= 8 then
                    end
                    q.eGod(NooseAPC[i], false)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0x2189D250

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #NooseAPCCar + 1
                    NooseAPCCar[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(NooseAPCCar[y])
                    local blipid = ui.get_blip_from_entity(NooseAPCCar[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(NooseAPCCar[y], false)
                    vehicle.set_vehicle_mod_kit_type(NooseAPCCar[y], 0)
                    vehicle.get_vehicle_mod(NooseAPCCar[y], 10)
                    vehicle.set_vehicle_mod(NooseAPCCar[y], 10, 0, false)
                    ped.set_ped_combat_attributes(NooseAPC[i], 46, false)
                    weapon.give_delayed_weapon_to_ped(NooseAPC[i], 0x5A96BA4, 1, 1)
                    ped.set_ped_combat_attributes(NooseAPC[i], 1, true)
                    ped.set_ped_combat_attributes(NooseAPC[i], 3, true)
                    ped.set_ped_combat_attributes(NooseAPC[i], 52, true)
                    ped.set_ped_combat_attributes(NooseAPC[i], 2, true)
                    ped.set_ped_combat_attributes(NooseAPC[i], 4, true)
                    ped.set_ped_combat_range(NooseAPC[i], 1)
                    ped.set_ped_combat_ability(NooseAPC[i], 2)
                    ped.set_ped_combat_movement(NooseAPC[i], 2)
                    ped.set_ped_into_vehicle(NooseAPC[i], NooseAPCCar[y], -1)


                    local i = #NooseAPC + 1
            NooseAPC[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Feds >= 8 then
                    end
                    q.eGod(NooseAPC[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(NooseAPC[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(NooseAPC[i], 0x99AEEB3B, 1, 1)
                    ped.set_ped_combat_attributes(NooseAPC[i], 1, true)
                    ped.set_ped_combat_attributes(NooseAPC[i], 3, true)
                    ped.set_ped_combat_attributes(NooseAPC[i], 2, true)
                    ped.set_ped_combat_attributes(NooseAPC[i], 52, true)
                    ped.set_ped_combat_attributes(NooseAPC[i], 4, true)
                    ped.set_ped_combat_range(NooseAPC[i], 1)
                    ped.set_ped_combat_ability(NooseAPC[i], 2)
                    ped.set_ped_combat_movement(NooseAPC[i], 2)
                    ped.set_ped_into_vehicle(NooseAPC[i], NooseAPCCar[y], 0)
while x.on do
                        ai.task_combat_ped(NooseAPC[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(NooseAPC[i])  then
                            entity.delete_entity(NooseAPC[i])
                            entity.delete_entity(NooseAPCCar[y]) return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #NooseAPC do
                                system.wait(25)
                                ai.task_combat_ped(NooseAPC[i], pedp, 0, 16)
                        if get_distance_between(pedp, NooseAPC[i]) > 300 then
                            network.request_control_of_entity(NooseAPC[i])
                         entity.set_entity_as_no_longer_needed(NooseAPC[i])
                         network.request_control_of_entity(NooseAPCCar[y])
                        entity.set_entity_as_no_longer_needed(NooseAPCCar[y])
                    end
                end
                end
while x.off do return HANDLER_POP
end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #NooseAPC do
                    ped.get_all_peds(NooseAPC[i])
        system.wait(25)
        network.request_control_of_entity(NooseAPC[i])
                entity.set_entity_coords_no_offset(NooseAPC[i], pos)
                entity.set_entity_as_no_longer_needed(NooseAPC[i])
                entity.delete_entity(NooseAPC[i])
                    end
                    for y = 1, #NooseAPCCar do
                    vehicle.get_all_vehicles(NooseAPCCar[y])
        system.wait(25)
        network.request_control_of_entity(NooseAPCCar[y])
                entity.set_entity_coords_no_offset(NooseAPCCar[y], pos)
                entity.set_entity_as_no_longer_needed(NooseAPCCar[y])
                entity.delete_entity(NooseAPCCar[y])
                end
            end)

-- Spawn a hunter
    x.Army_hunter = menu.add_player_feature("Spawn hunter", "toggle", x.Army, function(x, pid)
        local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 50
            pos.y = pos.y + 0
            pos.z = pos.z + 150
            system.wait(100)
        local model = gameplay.get_hash_key("csb_ramp_marine")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #Hunter + 1
            Hunter[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Hunter >= 8 then
                    end
                    q.eGod(Hunter[i], false)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0xFD707EDE

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #HunterHeli + 1
                    HunterHeli[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(HunterHeli[y])
                    local blipid = ui.get_blip_from_entity(HunterHeli[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(HunterHeli[y], false)
                    ped.set_ped_combat_attributes(Hunter[i], 46, false)
                    weapon.give_delayed_weapon_to_ped(Hunter[i], 0x99AEEB3B, 1, 1)
                    ped.set_ped_combat_attributes(Hunter[i], 1, true)
                    ped.set_ped_combat_attributes(Hunter[i], 3, false)
                    ped.set_ped_combat_attributes(Hunter[i], 2, true)
                    ped.set_ped_combat_attributes(Hunter[i], 52, false)
                    ped.set_ped_combat_attributes(Hunter[i], 4, true)
                    ped.set_ped_combat_range(Hunter[i], 1)
                    ped.set_ped_combat_ability(Hunter[i], 2)
                    ped.set_ped_combat_movement(Hunter[i], 2)
                    ped.set_ped_into_vehicle(Hunter[i], HunterHeli[y], -1)

                     local i = #Hunter + 1
            Hunter[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Hunter >= 8 then
                    end
                    q.eGod(Hunter[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Hunter[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Hunter[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Hunter[i], 1, true)
                    ped.set_ped_combat_attributes(Hunter[i], 3, false)
                    ped.set_ped_combat_attributes(Hunter[i], 2, true)
                    ped.set_ped_combat_attributes(Hunter[i], 52, false)
                    ped.set_ped_combat_attributes(Hunter[i], 4, true)
                    ped.set_ped_combat_range(Hunter[i], 1)
                    ped.set_ped_combat_ability(Hunter[i], 2)
                    ped.set_ped_combat_movement(Hunter[i], 2)
                    ped.set_ped_into_vehicle(Hunter[i], HunterHeli[y], 0)
                    while x.on do
                        ai.task_combat_ped(Hunter[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(Hunter[i])  then
                            entity.delete_entity(Hunter[i])
                            entity.delete_entity(HunterHeli[y])
                             return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #Hunter do
                                system.wait(25)
                                ai.task_combat_ped(Hunter[i], pedp, 0, 16)
                        if get_distance_between(pedp, Hunter[i]) > 1200 then
                            network.request_control_of_entity(Hunter[i])
                         entity.set_entity_as_no_longer_needed(Hunter[i])
                         network.request_control_of_entity(HunterHeli[y])
                        entity.set_entity_as_no_longer_needed(HunterHeli[y])
                    end
                end
                end
while x.off do return HANDLER_POP
end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #Hunter do
        ped.get_all_peds(Hunter[i])
        system.wait(25)
        network.request_control_of_entity(Hunter[i])
                entity.set_entity_coords_no_offset(Hunter[i], pos)
                entity.set_entity_as_no_longer_needed(Hunter[i])
                entity.delete_entity(Hunter[i])
                    end
                    for y = 1, #HunterHeli do
                    vehicle.get_all_vehicles(HunterHeli[y])
        system.wait(25)
        network.request_control_of_entity(HunterHeli[y])
                entity.set_entity_coords_no_offset(HunterHeli[y], pos)
                entity.set_entity_as_no_longer_needed(HunterHeli[y])
                entity.delete_entity(HunterHeli[y])
                end
            end)

    -- Spawn a hunter
    x.Army_hunter = menu.add_player_feature("Spawn Lazer", "toggle", x.Army, function(x, pid)
        local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 50
            pos.y = pos.y + 0
            pos.z = pos.z + 150
            system.wait(100)
        local model = gameplay.get_hash_key("csb_ramp_marine")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #Lazer + 1
            Lazer[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Hunter >= 8 then
                    end
                    q.eGod(Lazer[i], false)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0xB39B0AE6

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #Lazerplane + 1
                    Lazerplane[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(Lazerplane[y])
                    local blipid = ui.get_blip_from_entity(Lazerplane[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(Lazerplane[y], false)
                    ped.set_ped_combat_attributes(Lazer[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Lazer[i], 0x99AEEB3B, 1, 1)
                    ped.set_ped_combat_attributes(Lazer[i], 1, true)
                    ped.set_ped_combat_attributes(Lazer[i], 3, false)
                    ped.set_ped_combat_attributes(Lazer[i], 2, true)
                    ped.set_ped_combat_attributes(Lazer[i], 52, true)
                    ped.set_ped_combat_attributes(Lazer[i], 4, true)
                    vehicle.control_landing_gear(Lazerplane[y], 3)
                    vehicle.get_landing_gear_state(Lazerplane[y])
                    ped.set_ped_combat_range(Lazer[i], 1)
                    ped.set_ped_combat_ability(Lazer[i], 2)
                    ped.set_ped_combat_movement(Lazer[i], 2)
                    ped.set_ped_into_vehicle(Lazer[i], Lazerplane[y], -1)
                    while x.on do
                        ai.task_combat_ped(Lazer[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(Lazer[i])  then
                            entity.delete_entity(Lazer[i])
                            entity.delete_entity(Lazerplane[y])
                             return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #Lazer do
                                system.wait(25)
                                ai.task_combat_ped(Lazer[i], pedp, 0, 16)
                        if get_distance_between(pedp, Lazer[i]) > 1200 then
                            network.request_control_of_entity(Lazer[i])
                         entity.set_entity_as_no_longer_needed(Lazer[i])
                         network.request_control_of_entity(Lazerplane[y])
                        entity.set_entity_as_no_longer_needed(Lazerplane[y])
                    end
                end
                end
while x.off do return HANDLER_POP
end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #Lazer do
        ped.get_all_peds(Lazer[i])
        system.wait(25)
        network.request_control_of_entity(Lazer[i])
                entity.set_entity_coords_no_offset(Lazer[i], pos)
                entity.set_entity_as_no_longer_needed(Lazer[i])
                entity.delete_entity(Lazer[i])
                    end
                    for y = 1, #Lazerplane do
                    vehicle.get_all_vehicles(Lazerplane[y])
        system.wait(25)
        network.request_control_of_entity(Lazerplane[y])
                entity.set_entity_coords_no_offset(Lazerplane[y], pos)
                entity.set_entity_as_no_longer_needed(Lazerplane[y])
                entity.delete_entity(Lazerplane[y])
                end
            end)



-- Spawn a FIB team
    x.FIB_Team = menu.add_player_feature("Spawn FIB Team", "toggle", x.FIB, function(x, pid)
        local pos = v3()
        local eS = player.get_player_group(c.id())
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 50
            pos.y = pos.y + 0
            pos.z = pos.z - 0
            system.wait(100)
        local model = gameplay.get_hash_key("s_m_m_fibsec_01")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #Feds + 1
            Feds[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Feds >= 8 then
                    end
                    q.eGod(Feds[i], false)
                    streaming.set_model_as_no_longer_needed(model)
                    local vehhash = 0x432EA949

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #FedCar + 1
                    FedCar[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(FedCar[y])
                    local blipid = ui.get_blip_from_entity(FedCar[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(FedCar[y], true)
                    ped.set_ped_combat_attributes(Feds[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Feds[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Feds[i], 1, true)
                    ped.set_ped_combat_attributes(Feds[i], 3, true)
                    ped.set_ped_combat_attributes(Feds[i], 2, true)
                    ped.set_ped_combat_attributes(Feds[i], 52, false)
                    ped.set_ped_combat_attributes(Feds[i], 4, true)
                    ped.set_ped_combat_range(Feds[i], 1)
                    ped.set_ped_combat_ability(Feds[i], 2)
                    ped.set_ped_combat_movement(Feds[i], 2)
                    ped.set_ped_into_vehicle(Feds[i], FedCar[y], -1)


            local i = #Feds + 1
            Feds[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Feds >= 8 then
                    end
                    q.eGod(Feds[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Feds[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Feds[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Feds[i], 1, true)
                    ped.set_ped_combat_attributes(Feds[i], 3, true)
                    ped.set_ped_combat_attributes(Feds[i], 2, true)
                    ped.set_ped_combat_attributes(Feds[i], 52, false)
                    ped.set_ped_combat_attributes(Feds[i], 4, true)
                    ped.set_ped_combat_range(Feds[i], 1)
                    ped.set_ped_combat_ability(Feds[i], 2)
                    ped.set_ped_combat_movement(Feds[i], 2)
                    ped.set_ped_into_vehicle(Feds[i], FedCar[y], 0)

                     local i = #Feds + 1
            Feds[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Feds >= 8 then
                    end
                    q.eGod(Feds[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Feds[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Feds[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Feds[i], 1, true)
                    ped.set_ped_combat_attributes(Feds[i], 3, true)
                    ped.set_ped_combat_attributes(Feds[i], 2, true)
                    ped.set_ped_combat_attributes(Feds[i], 52, false)
                    ped.set_ped_combat_attributes(Feds[i], 4, true)
                    ped.set_ped_combat_range(Feds[i], 1)
                    ped.set_ped_combat_ability(Feds[i], 2)
                    ped.set_ped_combat_movement(Feds[i], 2)
                    ped.set_ped_into_vehicle(Feds[i], FedCar[y], 1)


                     local i = #Feds + 1
            Feds[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Feds >= 8 then
                    end
                    q.eGod(Feds[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Feds[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Feds[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Feds[i], 1, true)
                    ped.set_ped_combat_attributes(Feds[i], 3, true)
                    ped.set_ped_combat_attributes(Feds[i], 2, true)
                    ped.set_ped_combat_attributes(Feds[i], 52, false)
                    ped.set_ped_combat_attributes(Feds[i], 4, true)
                    ped.set_ped_combat_range(Feds[i], 1)
                    ped.set_ped_combat_ability(Feds[i], 2)
                    ped.set_ped_combat_movement(Feds[i], 2)
                    ped.set_ped_into_vehicle(Feds[i], FedCar[y], 2)
                    while x.on do
                        ai.task_combat_ped(Feds[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(Feds[i])  then
                            entity.delete_entity(Feds[i])
                            entity.delete_entity(FedCar[y])
                             return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #Feds do
                                system.wait(25)
                                ai.task_combat_ped(Feds[i], pedp, 0, 16)
                        if get_distance_between(pedp, Feds[i]) > 600 then
                            network.request_control_of_entity(Feds[i])
                         entity.set_entity_as_no_longer_needed(Feds[i])
                         network.request_control_of_entity(FedCar[y])
                        entity.set_entity_as_no_longer_needed(FedCar[y])
                    end
                end
                end
                while x.off do return HANDLER_POP
                end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #Feds do
                    ped.get_all_peds(Feds[i])
        system.wait(25)
        network.request_control_of_entity(Feds[i])
                entity.set_entity_coords_no_offset(Feds[i], pos)
                entity.set_entity_as_no_longer_needed(Feds[i])
                entity.delete_entity(Feds[i])
                    end
                    for y = 1, #FedCar do
                    vehicle.get_all_vehicles(FedCar[y])
        system.wait(25)
        network.request_control_of_entity(FedCar[y])
                entity.set_entity_coords_no_offset(FedCar[y], pos)
                entity.set_entity_as_no_longer_needed(FedCar[y])
                entity.delete_entity(FedCar[y])
                end
            end)
-- Spawn a FIB Buzzard
    x.FIB_Buzzard = menu.add_player_feature("Spawn FIB Buzzard", "toggle", x.FIB, function(x, pid)
        local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 50
            pos.y = pos.y + 0
            pos.z = pos.z + 150
            system.wait(100)
        local model = gameplay.get_hash_key("s_m_m_fibsec_01")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #FIBHeliGuy + 1
            FIBHeliGuy[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #FIBHeliGuy >= 8 then
                    end
                    q.eGod(FIBHeliGuy[i], false)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0x2F03547B

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #FIBBuzzard + 1
                    FIBBuzzard[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(FIBBuzzard[y])
                    local blipid = ui.get_blip_from_entity(FIBBuzzard[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(FIBBuzzard[y], false)
                    ped.set_ped_combat_attributes(FIBHeliGuy[i], 46, false)
                    weapon.give_delayed_weapon_to_ped(FIBHeliGuy[i], 0x99AEEB3B, 1, 1)
                    ped.set_ped_combat_attributes(FIBHeliGuy[i], 1, true)
                    ped.set_ped_combat_attributes(FIBHeliGuy[i], 3, false)
                    ped.set_ped_combat_attributes(FIBHeliGuy[i], 2, true)
                    ped.set_ped_combat_attributes(FIBHeliGuy[i], 52, true)
                    ped.set_ped_combat_attributes(FIBHeliGuy[i], 4, true)
                    ped.set_ped_combat_range(FIBHeliGuy[i], 1)
                    ped.set_ped_combat_ability(FIBHeliGuy[i], 2)
                    ped.set_ped_combat_movement(FIBHeliGuy[i], 2)
                    ped.set_ped_into_vehicle(FIBHeliGuy[i], FIBBuzzard[y], -1)
                    while x.on do
                        ai.task_combat_ped(FIBHeliGuy[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(FIBHeliGuy[i])  then
                            entity.delete_entity(FIBHeliGuy[i])
                            entity.delete_entity(FIBBuzzard[y]) return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #FIBHeliGuy do
                                system.wait(25)
                                ai.task_combat_ped(FIBHeliGuy[i], pedp, 0, 16)
                        if get_distance_between(pedp, FIBHeliGuy[i]) > 800 then
                            network.request_control_of_entity(FIBHeliGuy[i])
                         entity.set_entity_as_no_longer_needed(FIBHeliGuy[i])
                         network.request_control_of_entity(FIBBuzzard[y])
                        entity.set_entity_as_no_longer_needed(FIBBuzzard[y])
                    end
                end
                end
while x.off do return HANDLER_POP
end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #FIBHeliGuy do
        ped.get_all_peds(FIBHeliGuy[i])
        system.wait(25)
        network.request_control_of_entity(FIBBuzzard[i])
                entity.set_entity_coords_no_offset(FIBHeliGuy[i], pos)
                entity.set_entity_as_no_longer_needed(FIBHeliGuy[i])
                entity.delete_entity(FIBHeliGuy[i])
                    end
                    for y = 1, #FIBBuzzard do
                    vehicle.get_all_vehicles(FIBBuzzard[y])
        system.wait(25)
        network.request_control_of_entity(FIBBuzzard[y])
                entity.set_entity_coords_no_offset(FIBBuzzard[y], pos)
                entity.set_entity_as_no_longer_needed(FIBBuzzard[y])
                entity.delete_entity(FIBBuzzard[y])
                end
            end)

    -- Spawn a Coast
    x.Coast_Team = menu.add_player_feature("Spawn Coast Team", "toggle", x.Coast, function(x, pid)
        local pos = v3()
        local eS = player.get_player_group(c.id())
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 50
            pos.y = pos.y + 0
            pos.z = pos.z - 0
            system.wait(100)
        local model = gameplay.get_hash_key("s_m_y_uscg_01")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #Coast + 1
            Coast[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Coast >= 8 then
                    end
                    q.eGod(Coast[i], false)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0xE2E7D4AB

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #CoastBoat + 1
                    CoastBoat[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(CoastBoat[y])
                    local blipid = ui.get_blip_from_entity(CoastBoat[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(CoastBoat[y], true)
                    ped.set_ped_combat_attributes(Coast[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Coast[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Coast[i], 1, true)
                    ped.set_ped_combat_attributes(Coast[i], 3, true)
                    ped.set_ped_combat_attributes(Coast[i], 2, true)
                    ped.set_ped_combat_attributes(Coast[i], 52, false)
                    ped.set_ped_combat_attributes(Coast[i], 4, true)
                    ped.set_ped_combat_range(Coast[i], 1)
                    ped.set_ped_combat_ability(Coast[i], 2)
                    ped.set_ped_combat_movement(Coast[i], 2)
                    ped.set_ped_into_vehicle(Coast[i], CoastBoat[y], -1)


            local i = #Coast + 1
            Coast[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Coast >= 8 then
                    end
                    q.eGod(Coast[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Coast[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Coast[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Coast[i], 1, true)
                    ped.set_ped_combat_attributes(Coast[i], 3, true)
                    ped.set_ped_combat_attributes(Coast[i], 2, true)
                    ped.set_ped_combat_attributes(Coast[i], 52, false)
                    ped.set_ped_combat_attributes(Coast[i], 4, true)
                    ped.set_ped_combat_range(Coast[i], 1)
                    ped.set_ped_combat_ability(Coast[i], 2)
                    ped.set_ped_combat_movement(Coast[i], 2)
                    ped.set_ped_into_vehicle(Coast[i], CoastBoat[y], 0)

                     local i = #Coast + 1
            Coast[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Coast >= 8 then
                    end
                    q.eGod(Coast[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Coast[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Coast[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Coast[i], 1, true)
                    ped.set_ped_combat_attributes(Coast[i], 3, true)
                    ped.set_ped_combat_attributes(Coast[i], 2, true)
                    ped.set_ped_combat_attributes(Coast[i], 52, false)
                    ped.set_ped_combat_attributes(Coast[i], 4, true)
                    ped.set_ped_combat_range(Coast[i], 1)
                    ped.set_ped_combat_ability(Coast[i], 2)
                    ped.set_ped_combat_movement(Coast[i], 2)
                    ped.set_ped_into_vehicle(Coast[i], CoastBoat[y], 1)


                     local i = #Coast + 1
            Coast[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Coast >= 8 then
                    end
                    q.eGod(Coast[i], false)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Coast[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Coast[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Coast[i], 1, true)
                    ped.set_ped_combat_attributes(Coast[i], 3, true)
                    ped.set_ped_combat_attributes(Coast[i], 2, true)
                    ped.set_ped_combat_attributes(Coast[i], 52, false)
                    ped.set_ped_combat_attributes(Coast[i], 4, true)
                    ped.set_ped_combat_range(Coast[i], 1)
                    ped.set_ped_combat_ability(Coast[i], 2)
                    ped.set_ped_combat_movement(Coast[i], 2)
                    ped.set_ped_into_vehicle(Coast[i], CoastBoat[y], 2)
                   while x.on do
                        ai.task_combat_ped(Coast[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(Coast[i])  then
                                entity.delete_entity(Coast[i])
                                entity.delete_entity(CoastBoat[y])
                             return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #Coast do
                                system.wait(25)
                                ai.task_combat_ped(Coast[i], pedp, 0, 16)
                        if get_distance_between(pedp, Coast[i]) > 500 then
                            network.request_control_of_entity(Coast[i])
                         entity.set_entity_as_no_longer_needed(Coast[i])
                         network.request_control_of_entity(CoastBoat[y])
                        entity.set_entity_as_no_longer_needed(CoastBoat[y])
                    end
                end
                end
                while x.off do return HANDLER_POP
                end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #Coast do
                    ped.get_all_peds(Coast[i])
        system.wait(25)
        network.request_control_of_entity(Coast[i])
                entity.set_entity_coords_no_offset(Coast[i], pos)
                entity.set_entity_as_no_longer_needed(Coast[i])
                entity.delete_entity(Coast[i])
                    end
                    for y = 1, #CoastBoat do
                    vehicle.get_all_vehicles(CoastBoat[y])
        system.wait(25)
        network.request_control_of_entity(CoastBoat[y])
                entity.set_entity_coords_no_offset(CoastBoat[y], pos)
                entity.set_entity_as_no_longer_needed(CoastBoat[y])
                entity.delete_entity(CoastBoat[y])
                end
            end)

    -- Spawn a Annoying Modder
    x.Annoying_Modder = menu.add_player_feature("Spawn Annoying Modder", "toggle", x.Funny, function(x, pid)
        local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 50
            pos.y = pos.y + 0
            pos.z = pos.z + 150
            system.wait(100)
        local model = gameplay.get_hash_key("s_m_m_marine_01")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #Mod + 1
            Mod[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Mod >= 8 then
                    end
                    q.eGod(Mod[i], true)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0xA09E15FD

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #Modheli + 1
                    Modheli[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(Modheli[y])
                    local blipid = ui.get_blip_from_entity(Modheli[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(Modheli[y], true)
                    ped.set_ped_combat_attributes(Mod[i], 46, false)
                    weapon.give_delayed_weapon_to_ped(Mod[i], 0x99AEEB3B, 1, 1)
                    ped.set_ped_combat_attributes(Mod[i], 1, true)
                    ped.set_ped_combat_attributes(Mod[i], 3, false)
                    ped.set_ped_combat_attributes(Mod[i], 2, true)
                    ped.set_ped_combat_attributes(Mod[i], 52, true)
                    ped.set_ped_combat_attributes(Mod[i], 4, true)
                    ped.set_ped_combat_range(Mod[i], 1)
                    ped.set_ped_combat_ability(Mod[i], 2)
                    ped.set_ped_combat_movement(Mod[i], 2)
                    ped.set_ped_into_vehicle(Mod[i], Modheli[y], -1)

                     local i = #Mod + 1
            Mod[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Feds >= 8 then
                    end
                    q.eGod(Mod[i], true)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Mod[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Mod[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Mod[i], 1, true)
                    ped.set_ped_combat_attributes(Mod[i], 3, false)
                    ped.set_ped_combat_attributes(Mod[i], 2, true)
                    ped.set_ped_combat_attributes(Mod[i], 52, true)
                    ped.set_ped_combat_attributes(Mod[i], 4, true)
                    ped.set_ped_combat_range(Mod[i], 1)
                    ped.set_ped_combat_ability(Mod[i], 2)
                    ped.set_ped_combat_movement(Mod[i], 2)
                    ped.set_ped_into_vehicle(Mod[i], Modheli[y], 0)

                     local i = #Mod + 1
            Mod[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Feds >= 8 then
                    end
                    q.eGod(Mod[i], true)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Mod[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Mod[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Mod[i], 1, true)
                    ped.set_ped_combat_attributes(Mod[i], 3, false)
                    ped.set_ped_combat_attributes(Mod[i], 2, true)
                    ped.set_ped_combat_attributes(Mod[i], 52, true)
                    ped.set_ped_combat_attributes(Mod[i], 4, true)
                    ped.set_ped_combat_range(Mod[i], 1)
                    ped.set_ped_combat_ability(Mod[i], 2)
                    ped.set_ped_combat_movement(Mod[i], 2)
                    ped.set_ped_into_vehicle(Mod[i], Modheli[y], 1)

                     local i = #Mod + 1
            Mod[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Feds >= 8 then
                    end
                    q.eGod(Mod[i], true)
                    streaming.set_model_as_no_longer_needed(model)


                    ped.set_ped_combat_attributes(Mod[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Mod[i], 0x22D8FE39, 1, 1)
                    ped.set_ped_combat_attributes(Mod[i], 1, true)
                    ped.set_ped_combat_attributes(Mod[i], 3, false)
                    ped.set_ped_combat_attributes(Mod[i], 2, true)
                    ped.set_ped_combat_attributes(Mod[i], 52, true)
                    ped.set_ped_combat_attributes(Mod[i], 4, true)
                    ped.set_ped_combat_range(Mod[i], 1)
                    ped.set_ped_combat_ability(Mod[i], 2)
                    ped.set_ped_combat_movement(Mod[i], 2)
                    ped.set_ped_into_vehicle(Mod[i], Modheli[y], 2)
                    while x.on do
                        ai.task_combat_ped(Mod[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(Mod[i]) then
                            entity.delete_entity(Mod[i])
                            entity.delete_entity(Modheli[y])
                             return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #Mod do
                                system.wait(25)
                                ai.task_combat_ped(Mod[i], pedp, 0, 16)
                        if get_distance_between(pedp, Mod[i]) > 800 then
                            network.request_control_of_entity(Mod[i])
                         entity.set_entity_as_no_longer_needed(Mod[i])
                         network.request_control_of_entity(Modheli[y])
                        entity.set_entity_as_no_longer_needed(Modheli[y])
                    end
                end
                end
while x.off do return HANDLER_POP
end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #Mod do
        ped.get_all_peds(Mod[i])
        system.wait(25)
        network.request_control_of_entity(Mod[i])
                entity.set_entity_coords_no_offset(Mod[i], pos)
                entity.set_entity_as_no_longer_needed(Mod[i])
                entity.delete_entity(Mod[i])
                    end
                    for y = 1, #Modheli do
                    vehicle.get_all_vehicles(Modheli[y])
        system.wait(25)
        network.request_control_of_entity(Modheli[y])
                entity.set_entity_coords_no_offset(Modheli[y], pos)
                entity.set_entity_as_no_longer_needed(Modheli[y])
                entity.delete_entity(Modheli[y])
                end
            end)

-- Spawn a DemiHydra
    x.Demi_Hydra = menu.add_player_feature("Spawn Demi Hydra", "toggle", x.Funny, function(x, pid)
        local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 50
            pos.y = pos.y + 700
            pos.z = pos.z + 700
            system.wait(100)
        local model = gameplay.get_hash_key("csb_ramp_marine")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #DemiHydra + 1
            DemiHydra[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #DemiHydra >= 8 then
                    end
                    q.eGod(DemiHydra[i], false)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0x39D6E83F

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #Hydra + 1
                    Hydra[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(Hydra[y])
                    local blipid = ui.get_blip_from_entity(Hydra[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(Hydra[y], true)
                    ped.set_ped_combat_attributes(DemiHydra[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(DemiHydra[i], 0x99AEEB3B, 1, 1)
                    ped.set_ped_combat_attributes(DemiHydra[i], 1, true)
                    ped.set_ped_combat_attributes(DemiHydra[i], 3, false)
                    ped.set_ped_combat_attributes(DemiHydra[i], 2, true)
                    ped.set_ped_combat_attributes(DemiHydra[i], 52, true)
                    ped.set_ped_combat_attributes(DemiHydra[i], 4, true)
                    vehicle.control_landing_gear(Hydra[y], 3)
                    vehicle.get_landing_gear_state(Hydra[y])
                    ped.set_ped_combat_range(DemiHydra[i], 1)
                    ped.set_ped_combat_ability(DemiHydra[i], 2)
                    ped.set_ped_combat_movement(DemiHydra[i], 2)
                    ped.set_ped_into_vehicle(DemiHydra[i], Hydra[y], -1)
                    while x.on do
                        ai.task_combat_ped(DemiHydra[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(DemiHydra[i])  then
                            entity.delete_entity(DemiHydra[i])
                            entity.delete_entity(Hydra[y])
                             return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #DemiHydra do
                                system.wait(25)
                                ai.task_combat_ped(DemiHydra[i], pedp, 0, 16)
                        if get_distance_between(pedp, DemiHydra[i]) > 8000 then
                            network.request_control_of_entity(DemiHydra[i])
                         entity.set_entity_as_no_longer_needed(DemiHydra[i])
                         network.request_control_of_entity(Hydra[y])
                        entity.set_entity_as_no_longer_needed(Hydra[y])
                    end
                end
                end
while x.off do return HANDLER_POP
end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #DemiHydra do
        ped.get_all_peds(DemiHydra[i])
        system.wait(25)
        network.request_control_of_entity(DemiHydra[i])
                entity.set_entity_coords_no_offset(DemiHydra[i], pos)
                entity.set_entity_as_no_longer_needed(DemiHydra[i])
                entity.delete_entity(DemiHydra[i])
                    end
                    for y = 1, #Hydra do
                    vehicle.get_all_vehicles(Hydra[y])
        system.wait(25)
        network.request_control_of_entity(Hydra[y])
                entity.set_entity_coords_no_offset(Hydra[y], pos)
                entity.set_entity_as_no_longer_needed(Hydra[y])
                entity.delete_entity(Hydra[y])
                end
            end)

    -- Spawn a hunter
    x.Army_hunter = menu.add_player_feature("Spawn yee yee ass Haircut", "toggle", x.Funny, function(x, pid)
        local pos = v3()
        local pedp = player.get_player_ped(pid)
            pos = player.get_player_coords(pid)
            pos.x = pos.x + 0
            pos.y = pos.y + 4
            pos.z = pos.z + 0
            system.wait(100)
        local model = gameplay.get_hash_key("ig_lamardavis")
                    streaming.request_model(model)

                    while (not streaming.has_model_loaded(model)) do
                        system.wait(10)
                    end
        local i = #Lamar + 1
            Lamar[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                    if #Lamar >= 8 then
                    end
                    q.eGod(Lamar[i], true)
                    streaming.set_model_as_no_longer_needed(model)

                    local vehhash = 0xD9F0503D

                    streaming.request_model(vehhash)
                    while (not streaming.has_model_loaded(vehhash)) do
                        system.wait(10)
                    end

                    local y = #Lamarcar + 1
                    Lamarcar[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                    ui.add_blip_for_entity(Lamarcar[y])
                    local blipid = ui.get_blip_from_entity(Lamarcar[y])
                    ui.set_blip_sprite(blipid, 188)
                    entity.set_entity_god_mode(Lamarcar[y], true)
                    ped.set_ped_combat_attributes(Lamar[i], 46, true)
                    weapon.give_delayed_weapon_to_ped(Lamar[i], 0x13532244, 1, 1)
                    ped.set_ped_combat_attributes(Lamar[i], 1, true)
                    ped.set_ped_combat_attributes(Lamar[i], 3, true)
                    ped.set_ped_combat_attributes(Lamar[i], 2, true)
                    ped.set_ped_combat_attributes(Lamar[i], 52, true)
                    ped.set_ped_combat_attributes(Lamar[i], 4, true)
                    ped.set_ped_combat_range(Lamar[i], 1)
                    ped.set_ped_combat_ability(Lamar[i], 2)
                    ped.set_ped_combat_movement(Lamar[i], 2)
                    ped.set_ped_into_vehicle(Lamar[i], Lamarcar[y], -1)
                   while x.on do
                        ai.task_combat_ped(Lamar[i], pedp, 0, 16)
                        system.wait(25)
                            if entity.is_entity_dead(Lamar[i])  then return HANDLER_CONTINUE end
                            system.wait(25)
                            for i = 1, #Lamar do
                                system.wait(25)
                                ai.task_combat_ped(Lamar[i], pedp, 0, 16)
                        if get_distance_between(pedp, Lamar[i]) > 200 then
                            network.request_control_of_entity(Lamar[i])
                         entity.set_entity_as_no_longer_needed(Lamar[i])
                         network.request_control_of_entity(Lamarcar[y])
                        entity.set_entity_as_no_longer_needed(Lamarcar[y])
                    end
                end
                end
while x.off do return HANDLER_POP
end
local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
                    for i = 1, #Lamar do
        ped.get_all_peds(Lamar[i])
        system.wait(25)
        network.request_control_of_entity(Lamar[i])
                entity.set_entity_coords_no_offset(Lamar[i], pos)
                entity.set_entity_as_no_longer_needed(Lamar[i])
                entity.delete_entity(Lamar[i])
                    end
                    for y = 1, #Lamarcar do
                    vehicle.get_all_vehicles(Lamarcar[y])
        system.wait(25)
        network.request_control_of_entity(Lamarcar[y])
                entity.set_entity_coords_no_offset(Lamarcar[y], pos)
                entity.set_entity_as_no_longer_needed(Lamarcar[y])
                entity.delete_entity(Lamarcar[y])
                end
            end)
