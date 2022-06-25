local shit = menu.add_feature("Disable features", "parent", 0).id

menu.add_feature("Disable SharkCards/Stunt jumps ", "toggle", shit, function(f)
if f.on then
    native.call(0xD79185689F8FD5DF, false)
    native.call(0x9641A9FF718E9C5E, false)
else
    native.call(0xD79185689F8FD5DF, true)
    native.call(0x9641A9FF718E9C5E, true)
end
end)

menu.add_feature("Disable Game Recording", "toggle", shit, function(f)
    while f.on do
        native.call(0xEB2D525B57F42B40)
        system.wait()
    end
end).on = true

menu.add_feature("Disable Cutscenes", "toggle", shit, function(f)
    while f.on do
        if cutscene.is_cutscene_playing() then
            cutscene.stop_cutscene_immediately()
        end
        system.wait(1000)
    end
end).on = true

local rmv_nrby_veh=menu.add_feature("Remove nearby cars", "value_i", shit, function(f)
    local all_veh,all_veh2
    local function distance(_ent)
        return math.abs(player.get_player_coords(player.player_id()):magnitude(entity.get_entity_coords(_ent)))
    end
    local function have_control(_ent)
        if not network.has_control_of_entity(_ent) then
            network.request_control_of_entity(_ent)
        end
        return network.has_control_of_entity(_ent)
    end
    local function has_player(_veh)
        return vehicle.get_vehicle_has_been_owned_by_player(_veh) 
    end
    while f.on do
        system.yield(25)
        all_veh = vehicle.get_all_vehicles()
        all_veh2 = {0,0}
        for i=1,#all_veh do
            all_veh2[i]={all_veh[i],distance(all_veh[i])}
        end
        table.sort(all_veh2, function(a, b) return (a)[2] < (b)[2] end)
        for i=1,#all_veh2 do
            if all_veh2[i][2] > f.value then
                break
            elseif not has_player(all_veh2[i][1]) and have_control(all_veh2[i][1]) then
                entity.set_entity_coords_no_offset(all_veh2[i][1], v3(math.random(8000,9000),math.random(8000,9000),math.random(8000,9000)))
                entity.set_entity_as_no_longer_needed(all_veh2[i][1])
            end
        end
    end
end)
rmv_nrby_veh.max,rmv_nrby_veh.min,rmv_nrby_veh.mod=200,5,5