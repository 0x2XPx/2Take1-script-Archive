local utility = require('2Take1Script.Functions.Utils')
local Math = require('2Take1Script.Functions.Math')
local scriptevent = require('2Take1Script.Data.ScriptEvents')

local Threads = {}

function Threads.Killaura(Data)
    local Ped = Data[1]
    local Range = Data[2]
    local Option = Data[3]

    local Position = entity.get_entity_coords(Ped)
    local OwnPosition = player.get_player_coords(player.player_id())
    local Magnitude = OwnPosition:magnitude(Position)

    if Magnitude < Range then
        if Option == 0 and not entity.is_entity_dead(Ped) then
            if ped.get_vehicle_ped_is_using(Ped) ~= 0 then
                ped.clear_ped_tasks_immediately(Ped)
            end

            local Position = entity.get_entity_coords(Ped)
            gameplay.shoot_single_bullet_between_coords(Position + v3(0, 0, 1), Position, 1000, 0xC472FE2, player.get_player_ped(player.player_id()), false, true, 1000)
            
        elseif Option == 1 and not entity.is_entity_dead(Ped) then
            fire.add_explosion(Position, 5, true, false, 0, 0)

        end
                
    end
end

function Threads.Forcefield(Data)
    local Vehicle = Data[1]
    local Range = Data[2]
    local Strenth = Data[3]

    local Position = entity.get_entity_coords(Vehicle)
    local OwnPosition = player.get_player_coords(player.player_id())
    local Magnitude = OwnPosition:magnitude(Position)

    if Magnitude < Range then
        local Velocity = (Position - OwnPosition) * (Strenth / Magnitude)
        utility.request_ctrl(Vehicle, 100)

        entity.set_entity_velocity(Vehicle, Velocity)
    end
end

function Threads.Assassins(Data)
    local Entity = Data[1]
    local Player = Data[2]

    while entity.is_an_entity(Entity) and player.is_player_valid(Player) do
        local PlayerPed = player.get_player_ped(Player)

        ai.task_combat_ped(Entity, PlayerPed, 0, 16)

        local shot, coords = ped.get_ped_last_weapon_impact(Entity)

        if shot and coords:magnitude(player.get_player_coords(Player)) > 2 then
            ped.clear_ped_tasks_immediately(Entity)
            ai.task_combat_ped(Entity, PlayerPed, 0, 16)
        end

        coroutine.yield(1000)
    end
end

function Threads.Clearpeds(Data)
    for i = 1, #Data do
        if not ped.is_ped_a_player(Data[i]) and entity.get_entity_coords(Data[i]):magnitude(player.get_player_coords(player.player_id())) < 1000 then
            utility.clear(Data[i])
        end

    end
end

function Threads.Clearvehicles(Data)
    local PersonalVehicles = {}

    for i = 0, 31 do
        local PV = scriptevent.GetPersonalVehicle(i)
        
        if PV ~= 0 then
            PersonalVehicles[#PersonalVehicles + 1] = PV
        end
    end

    for i = 1, #Data do
        local isPV

        for j = 1, #PersonalVehicles do
            if Data[i] == PersonalVehicles[j] then
                isPV = true
            end
        end
    
        if not isPV and not ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(Data[i], -1)) and entity.get_entity_coords(Data[i]):magnitude(player.get_player_coords(player.player_id())) < 1000 then
            utility.clear(Data[i])
        end

    end
end

function Threads.Clearobjects(Data)
    for i = 1, #Data do
        if entity.get_entity_coords(Data[i]):magnitude(player.get_player_coords(player.player_id())) < 1000 then
            utility.clear(Data[i])
        end
        
    end
end

function Threads.Vehiclecollision(Data)
    local Vehicles = Data[1]
    local Entity = Data[2]

    for i = 1, #Vehicles do
        entity.set_entity_no_collsion_entity(Vehicles[i], Entity, true)
        entity.set_entity_no_collsion_entity(Entity, Vehicles[i], true)
    end
end

function Threads.Objectcollision(Data)
    local Objects = Data[1]
    local Entity = Data[2]

    for i = 1, #Objects do
        entity.set_entity_no_collsion_entity(Objects[i], Entity, true)
        entity.set_entity_no_collsion_entity(Entity, Objects[i], true)
    end
end

function Threads.Upgradevehicles(Vehicle)
    local speed = entity.get_entity_speed(Vehicle)

    utility.request_ctrl(Vehicle)
    entity.freeze_entity(Vehicle, true)

    utility.MaxVehicle(Vehicle)
    entity.freeze_entity(Vehicle, false)

    vehicle.set_vehicle_forward_speed(Vehicle, speed)
end

return Threads