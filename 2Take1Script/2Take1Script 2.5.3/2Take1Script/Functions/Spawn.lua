local Spawn = {}

local function request_model(Hash)
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

function Spawn.Ped(Hash, Position, PedType, Heading, Networked, unk1)
    if not Hash or not streaming.is_model_a_ped(Hash) then
        return
    end

    request_model(Hash)
    PedType = PedType or 26
    Position = Position or player.get_player_coords(player.player_id())
    Heading = Heading or 0.0
    Networked = Networked or true
    unk1 = unk1 or false

    local Ped = ped.create_ped(PedType, Hash, Position, Heading, Networked, unk1)
    streaming.set_model_as_no_longer_needed(Hash)

    return Ped
end

function Spawn.Vehicle(Hash, Position, Heading, Networked, unk1)
    if not Hash or not streaming.is_model_a_vehicle(Hash) then
        return
    end

    request_model(Hash)
    Position = Position or v3()
    Heading = Heading or 0.0
    Networked = Networked or true
    unk1 = unk1 or false

    local Vehicle = vehicle.create_vehicle(Hash, Position, Heading, Networked, unk1)
    streaming.set_model_as_no_longer_needed(Hash)

    return Vehicle
end

function Spawn.Object(Hash, Position, Networked, Dynamic)
    if not Hash or not streaming.is_model_an_object(Hash) then
        return
    end

    request_model(Hash)
    Position = Position or v3()
    Networked = Networked or true
    Dynamic = Dynamic or false

    local Object = object.create_object(Hash, Position, Networked, Dynamic)
    streaming.set_model_as_no_longer_needed(Hash)

    return Object
end

function Spawn.Worldobject(Hash, Position, Networked, Dynamic)
    if not Hash or not streaming.is_model_a_world_object(Hash) then
        return
    end

    request_model(Hash)
    Position = Position or v3()
    Networked = Networked or true
    Dynamic = Dynamic or false

    local Worldobject = object.create_world_object(Hash, Position, Networked, Dynamic)
    streaming.set_model_as_no_longer_needed(Hash)

    return Worldobject
end

return Spawn