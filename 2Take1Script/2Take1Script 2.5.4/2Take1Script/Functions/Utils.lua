local utility = {}

local function RGBToHex(rgb)
    local hexadecimal = '0X'

    for key, value in pairs(rgb) do
        local hex = ''

        while value > 0 do
            local index = math.fmod(value, 16) + 1
            value = math.floor(value / 16)
            hex = string.sub('0123456789ABCDEF', index, index) .. hex
        end

        if string.len(hex) == 0 then
            hex = '00'
        elseif string.len(hex) == 1 then
            hex = '0' .. hex
        end

        hexadecimal = hexadecimal .. hex
    end

    return hexadecimal
end

function utility.request_ctrl(Entity, Time)
    if entity.is_an_entity(Entity) then

        if not network.has_control_of_entity(Entity) then
            network.request_control_of_entity(Entity)
            Time = Time or 50
            local new_time = utils.time_ms() + Time

            while entity.is_an_entity(Entity) and not network.has_control_of_entity(Entity) do
                system.wait(0)
                network.request_control_of_entity(Entity)

                if new_time < utils.time_ms() then
                    return false
                end

            end

        end

        return network.has_control_of_entity(Entity)
    end

    return false
end

function utility.request_model(Hash)
    if Hash and not streaming.has_model_loaded(Hash) then
        streaming.request_model(Hash)
        local time = utils.time_ms() + 7500

        while not streaming.has_model_loaded(Hash) do
            system.wait(0)

            if time < utils.time_ms() then
                return false
            end
            
        end

    end

    return true
end

function utility.valid_player(PlayerID, Exclude)
    if player.is_player_valid(PlayerID) then

        if PlayerID ~= player.player_id() and player.get_player_scid(PlayerID) ~= -1 then

            if Exclude and player.is_player_friend(PlayerID) then
                return false
            else
                return true
            end
            
        end

    end

    return false
end

function utility.valid_modder(PlayerID, Exclude)
    if player.is_player_valid(PlayerID) then

        if PlayerID ~= player.player_id() and player.get_player_scid(PlayerID) ~= -1 and not player.is_player_modder(PlayerID, -1) then

            if Exclude and player.is_player_friend(PlayerID) then
                return false
            else
                return true
            end
        end

    end

    return false
end

function utility.valid_vehicle(Vehicle)
    if Vehicle and vehicle.get_ped_in_vehicle_seat(Vehicle, -1) == player.get_player_ped(player.player_id()) then
        return true
    end

    return false
end

function utility.write(File, Text)
    if File and Text then
        io.output(File)
        io.write(Text .. '\n')
        io.close(File)
    end
end

function utility.set_coords(Entity, Position)
    entity.set_entity_velocity(Entity, v3())
    entity.set_entity_coords_no_offset(Entity, Position)
end

function utility.print_table(Source, Version)
    Version = Version or 1

    if type(Source) == 'table' then
        if Version == 1 then
            local s = '\n'

            for k,v in pairs(Source) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. utility.print_table(v) .. ', '
            end

            return s
        elseif Version == 2 then
            local s = ''

            for k,v in pairs(Source) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. utility.print_table(v, 2) .. ', '
            end

            return s
        else
            local s = ''
            local cut1, cut2

            for k,v in pairs(Source) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. utility.print_table(v, 3) .. ' '

                if (string.len(s) > 200 and not cut1) then
                    s = s .. "\n"
                    cut1 = true

                elseif (string.len(s) > 400 and not cut2) then
                    s = s .. "\n"
                    cut2 = true
                end

            end
            
            return s
        end
    else
       return tostring(Source)
    end
end

function utility.MaxVehicle(Vehicle, Version, Liveries)
    if not Vehicle then
        return
    end
    Version = Version or 1

    if Liveries then
        Liveries = 49
    end

    vehicle.set_vehicle_mod_kit_type(Vehicle, 0)
    if Version == 1 then
        for i = 0, (Liveries or 47) do
            local mod = vehicle.get_num_vehicle_mods(Vehicle, i)-1
            vehicle.set_vehicle_mod(Vehicle, i, mod, true)
            vehicle.toggle_vehicle_mod(Vehicle, mod, true)
        end
        for j = 0, 20 do
            if vehicle.does_extra_exist(Vehicle, j) then
                vehicle.set_vehicle_extra(Vehicle, j, true)
            end
        end
        vehicle.set_vehicle_bulletproof_tires(Vehicle, true)
        vehicle.set_vehicle_window_tint(Vehicle, 1)
        vehicle.set_vehicle_number_plate_index(Vehicle, 1)

    elseif Version == 2 then
        local upgrades = {11, 12, 13, 15, 16}
        for i = 1, #upgrades do
            local mod = vehicle.get_num_vehicle_mods(Vehicle, upgrades[i])-1
            vehicle.set_vehicle_mod(Vehicle, upgrades[i], mod, true)
        end
        vehicle.toggle_vehicle_mod(Vehicle, 18, true)
        vehicle.set_vehicle_bulletproof_tires(Vehicle, true)

    elseif Version == 3 then
        for i = 0, (Liveries or 47) do
            local mod = vehicle.get_num_vehicle_mods(Vehicle, i)-1

            if mod > 0 then
                mod = math.random(0, mod)
            end

            local custom
            if math.random(0, 10) > 5 then
                custom = true
            else
                custom = false
            end
            
            vehicle.set_vehicle_mod(Vehicle, i, mod, custom)
            vehicle.toggle_vehicle_mod(Vehicle, mod, true)
        end
        for j = 0, 20 do
            if vehicle.does_extra_exist(Vehicle, j) then
                vehicle.set_vehicle_extra(Vehicle, j, true)
            end
        end
        vehicle.set_vehicle_bulletproof_tires(Vehicle, true)
        vehicle.set_vehicle_window_tint(Vehicle, math.random(0, 3))
        vehicle.set_vehicle_number_plate_index(Vehicle, math.random(0, 5))
    end
end

function utility.RepairVehicle(Vehicle)
    if not Vehicle then
        return
    end

    local speed = entity.get_entity_speed(Vehicle)
    vehicle.set_vehicle_fixed(Vehicle)
    vehicle.set_vehicle_deformation_fixed(Vehicle)
    vehicle.set_vehicle_engine_health(Vehicle, 1000.0)
    vehicle.set_vehicle_undriveable(Vehicle, false)
    if entity.is_entity_on_fire(Vehicle) then
        fire.stop_entity_fire(Vehicle)
    end
    if not vehicle.is_vehicle_engine_running(Vehicle) then
        vehicle.set_vehicle_engine_on(Vehicle, true, true, false)
    end
    if speed > 75.0 then
        vehicle.set_vehicle_forward_speed(Vehicle, speed)
    end
end

function utility.GetVehicleMods(Vehicle)
    local VehicleData = {}

    VehicleData.primary = vehicle.get_vehicle_primary_color(Vehicle)
    VehicleData.secondary = vehicle.get_vehicle_secondary_color(Vehicle)
    VehicleData.pearl = vehicle.get_vehicle_pearlecent_color(Vehicle)
    VehicleData.wheel = vehicle.get_vehicle_wheel_color(Vehicle)
    VehicleData.window = vehicle.get_vehicle_window_tint(Vehicle)
    VehicleData.lights = vehicle.get_vehicle_headlight_color(Vehicle)
    VehicleData.neoncolor = vehicle.get_vehicle_neon_lights_color(Vehicle)

    VehicleData.neon = {}
    for i = 0, 3 do
        if vehicle.is_vehicle_neon_light_enabled(Vehicle, i) then
            VehicleData.neon[#VehicleData.neon + 1] = true
        end
    end

    VehicleData.mods = {}
    for i = 0, 49 do
        if vehicle.is_toggle_mod_on(Vehicle, i) then
            VehicleData.mods[i] = i
        else
            VehicleData.mods[i] = vehicle.get_vehicle_mod(Vehicle, i)
        end
    end

    return VehicleData
end

function utility.SetVehicleMods(Vehicle, VehicleData, Extra)
    vehicle.set_vehicle_mod_kit_type(Vehicle, 0)

    for i = 0, 49 do
        if VehicleData.mods[i] then
            vehicle.set_vehicle_mod(Vehicle, i, VehicleData.mods[i], false)
            vehicle.toggle_vehicle_mod(Vehicle, i, true)
        end
    end

    for i = 1, #VehicleData.neon do
        vehicle.set_vehicle_neon_light_enabled(Vehicle, i, true)
    end

    vehicle.set_vehicle_neon_lights_color(Vehicle, VehicleData.neoncolor)
    vehicle.set_vehicle_colors(Vehicle, VehicleData.primary, VehicleData.secondary)
    vehicle.set_vehicle_extra_colors(Vehicle, VehicleData.pearl, VehicleData.wheel)
    vehicle.set_vehicle_headlight_color(Vehicle, VehicleData.lights)
    vehicle.set_vehicle_window_tint(Vehicle, VehicleData.window)

    vehicle.set_vehicle_number_plate_text(Vehicle, ' ')

    if Extra then
        vehicle.set_vehicle_bulletproof_tires(Vehicle, true)
        vehicle.set_vehicle_number_plate_index(Vehicle, 1)
        vehicle.set_vehicle_number_plate_text(Vehicle, '2Take1')
    end
end

function utility.OffsetCoords(Position, Heading, Distance)
    Heading = math.rad((Heading - 180) * -1)
    Position.x = Position.x + (math.sin(Heading) * -Distance)
    Position.y = Position.y + (math.cos(Heading) * -Distance)
    return Position
end

function utility.id_from_name(Player)
    Player = string.lower(Player)
    local name
    for id = 0, 31 do
        if player.get_player_scid(id) ~= -1 then
            name = string.lower(player.get_player_name(id))
            if name == Player then
                return id
            end
        end
    end
    return -1
end

function utility.tp(Entity, Offset, Heading)
    local me, pos, veh, target_veh = player.get_player_ped(player.player_id())
    if type(Entity) == 'number' then
        target_veh = ped.get_vehicle_ped_is_using(Entity)
        if target_veh ~= 0 then
            if ped.is_ped_in_any_vehicle(me) then
                ped.clear_ped_tasks_immediately(me)
                system.wait(10)
            end
        end
    end
    veh = ped.get_vehicle_ped_is_using(me)
    if veh ~= 0 then
        utility.request_ctrl(veh)
        entity.set_entity_velocity(veh, v3())
        me = veh
    end
    if type(Entity) == 'number' then
        pos = entity.get_entity_coords(Entity)
    else
        pos = Entity
    end
    if Offset then
        pos.z = pos.z + Offset
    end
    utility.set_coords(me, pos)
    if Heading then
        entity.set_entity_heading(me, Heading)
    end
    if target_veh then
        system.wait(1500)
        ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), target_veh, vehicle.get_free_seat(target_veh))
    end
end

function utility.color_veh(Vehicle, c, i, x)
    utility.request_ctrl(Vehicle)
    system.wait(0)
    vehicle.set_vehicle_tire_smoke_color(Vehicle, c[1], c[2], c[3])
    vehicle.set_vehicle_custom_primary_colour(Vehicle, RGBToHex({c[1], c[2], c[3]}))
    vehicle.set_vehicle_custom_secondary_colour(Vehicle, RGBToHex({c[1], c[2], c[3]}))
    vehicle.set_vehicle_custom_pearlescent_colour(Vehicle, RGBToHex({c[1], c[2], c[3]}))
    vehicle.set_vehicle_neon_lights_color(Vehicle, RGBToHex({c[1], c[2], c[3]}))
    vehicle.set_vehicle_custom_wheel_colour(Vehicle, RGBToHex({c[1], c[2], c[3]}))
    if not i then
        i = 0
    end
    if c[1] > 200 and c[1] < 256 and c[2] > 200 and c[2] < 256 and c[3] > 220 and c[3] < 256 then
        i = 0
    end
    if c[1] >= 0 and c[1] < 30 and c[2] >= 0 and c[2] < 50 and c[3] > 220 and c[3] < 256 then
        i = 1
    end
    if c[1] >= 0 and c[1] < 30 and c[2] >= 50 and c[2] < 110 and c[3] > 220 and c[3] < 256 then
        i = 2
    end
    if c[1] >= 0 and c[1] < 30 and c[2] >= 110 and c[2] < 256 and c[3] > 100 and c[3] <= 220 then
        i = 3
    end
    if c[1] >= 30 and c[1] < 120 and c[2] >= 110 and c[2] < 256 and c[3] >= 0 and c[3] <= 100 then
        i = 4
    end
    if c[1] >= 120 and c[1] < 256 and c[2] >= 110 and c[2] < 256 and c[3] >= 0 and c[3] < 100 then
        i = 5
    end
    if c[1] >= 120 and c[1] < 256 and c[2] >= 110 and c[2] < 200 and c[3] >= 0 and c[3] < 100 then
        i = 6
    end
    if c[1] >= 120 and c[1] < 256 and c[2] > 45 and c[2] < 109 and c[3] >= 0 and c[3] < 100 then
        i = 7
    end
    if c[1] >= 120 and c[1] < 256 and c[2] >= 0 and c[2] <= 45 and c[3] >= 0 and c[3] < 100 then
        i = 8
    end
    if c[1] >= 120 and c[1] < 256 and c[2] > 45 and c[2] < 100 and c[3] >= 50 and c[3] < 150 then
        i = 9
    end
    if c[1] >= 120 and c[1] < 256 and c[2] >= 0 and c[2] <= 45 and c[3] >= 150 and c[3] < 256 then
        i = 10
    end
    if c[1] >= 0 and c[1] < 120 and c[2] >= 0 and c[2] <= 45 and c[3] >= 150 and c[3] < 256 then
        i = 11
    end
    if c[1] >= 0 and c[1] < 30 and c[2] >= 0 and c[2] <= 45 and c[3] >= 150 and c[3] < 256 then
        i = 12
    end
    if x then
        i = x
    end
    vehicle.set_vehicle_headlight_color(Vehicle, i)
end

function utility.random_outfit(Ped, Component)
    if not Ped or not Component then
        return
    end

    local drawable = math.random(0, ped.get_number_of_ped_drawable_variations(Ped, Component))
    local texture = math.random(0, ped.get_number_of_ped_texture_variations(Ped, Component, drawable))
    return ped.set_ped_component_variation(Ped, Component, drawable, texture, math.random(0, 3))

end

function utility.random_property(Ped, Component, Attached)
    if not Ped or not Component then
        return
    end

    Attached = Attached or false

    local drawable = math.random(0, ped.get_number_of_ped_drawable_variations(Ped, Component))
    local texture = math.random(0, ped.get_number_of_ped_texture_variations(Ped, Component, drawable))
    
    return ped.set_ped_prop_index(Ped, Component, drawable, texture, Attached)

end

function utility.clear(Data, Time)
    if Data and type(Data) == 'table' then
        Time = Time or 50
        for i = 1, #Data do
            if Data[i] ~= player.get_player_ped(player.player_id()) and Data[i] ~= ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())) then
                utility.request_ctrl(Data[i], Time)
                entity.detach_entity(Data[i])
                entity.set_entity_as_mission_entity(Data[i], true, true)
                entity.set_entity_as_no_longer_needed(Data[i])
                entity.set_entity_velocity(Data[i], v3())
                entity.set_entity_coords_no_offset(Data[i], v3(8000, 8000, -1000))
                entity.delete_entity(Data[i])
            end
        end
    else
        utility.request_ctrl(Data, Time)
        entity.detach_entity(Data)
        entity.set_entity_as_mission_entity(Data, true, true)
        entity.set_entity_as_no_longer_needed(Data)
        entity.set_entity_velocity(Data, v3())
        entity.set_entity_coords_no_offset(Data, v3(8000, 8000, -1000))
        entity.delete_entity(Data)
    end
end

return utility