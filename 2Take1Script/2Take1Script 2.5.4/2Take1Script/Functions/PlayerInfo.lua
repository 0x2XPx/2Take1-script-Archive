local get = {}

function get.Name(ID)
    if player.is_player_valid(ID) then
        return player.get_player_name(ID)
    else
        return 'Invalid Player'
    end
end

function get.SCID(ID)
    return player.get_player_scid(ID)
end

function get.IP(ID)
    if player.is_player_valid(ID) then
        local playerip = player.get_player_ip(ID)
        return string.format('%i.%i.%i.%i', (playerip >> 24) & 0xff, ((playerip >> 16) & 0xff), ((playerip >> 8) & 0xff), playerip & 0xff)
    else
        return -1
    end
end

function get.HostToken(ID)
    if player.is_player_valid(ID) then  
        return player.get_player_host_token(ID)
    else
        return -1
    end
end

function get.HostPriority(ID)
    if player.is_player_valid(ID) then
        return player.get_player_host_priority(ID)
    else
        return 31
    end
end

function get.Input(Title, Lenght, Type, Name)
    if not Title then
        return nil
    end

    Name = Name or ''
    Lenght = Lenght or 64
    Type = Type or 0
    local err, i = input.get(Title, Name, Lenght, Type)

    while err == 1 do
        system.wait(0)
        err, i = input.get(Title, Name, Lenght, Type)
    end

    if err == 2 then
        return nil
    end

    return i
end

function get.GodmodeState(ID, Position)
    if not player.is_player_god(ID) then
        return false
    end

    local Ped = player.get_player_ped(ID)
    if interior.get_interior_from_entity(Ped) ~= 0 then
        return false
    end

    Position = Position or player.get_player_coords(ID)
    if not (Position.z > 0 or Position.z == -50) then
        return false
    end

    local Vehicle = ped.get_vehicle_ped_is_using(Ped)
    if Vehicle ~= 0 then
        local hash = entity.get_entity_model_hash(Vehicle)

        if hash == 3040635986 or hash == 4008920556 then
            return false
        end
    end

    return true
end

function get.VehicleGodmodeState(ID, Position)
    if not player.is_player_vehicle_god(ID) then
        return false
    end

    local Ped = player.get_player_ped(ID)
    if interior.get_interior_from_entity(Ped) ~= 0 then
        return false
    end

    Position = Position or player.get_player_coords(ID)
    if not (Position.z > 0 or Position.z == -50) then
        return false
    end

    return true
end

function get.PlayerPed(ID)
    return player.get_player_ped(ID)
end

function get.PlayerVehicle(ID)
    return ped.get_vehicle_ped_is_using(player.get_player_ped(ID))
end

function get.PlayerHeading(ID)
    return player.get_player_heading(ID)
end

function get.PlayerCoords(ID)
    return player.get_player_coords(ID)
end


function get.OwnPed()
    return player.get_player_ped(player.player_id())
end

function get.OwnVehicle()
    return ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
end

function get.OwnHeading()
    return player.get_player_heading(player.player_id())
end

function get.OwnCoords()
    return player.get_player_coords(player.player_id())
end

return get