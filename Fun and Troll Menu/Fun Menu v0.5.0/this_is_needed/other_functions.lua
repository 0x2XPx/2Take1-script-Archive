-- Globals for Fun Menu
blipsTable = {}

-- provided by kektram
function requestAnimSet(anim_set)
    local time <const> = utils.time_ms() + 500
    streaming.request_anim_set(anim_set)
    while time > utils.time_ms() and not streaming.has_anim_set_loaded(anim_set) do
        system.yield(0)
    end
    return streaming.has_anim_set_loaded(anim_set)
end

function requestAnimDictAndSet(anim_dict, anim_set)
    local time <const> = utils.time_ms() + 500
    streaming.request_anim_dict(anim_dict)
    streaming.request_anim_set(anim_set)
    while time > utils.time_ms() and not streaming.has_anim_set_loaded(anim_set) and not streaming.has_anim_dict_loaded(anim_dict) do
        system.yield(0)
    end
    return streaming.has_anim_dict_loaded(anim_dict), streaming.has_anim_set_loaded(anim_set)
end

function requestModel(model)
    local time <const> = utils.time_ms() + 500
    streaming.request_model(model)
    while time > utils.time_ms() and not streaming.has_model_loaded(model) do
        system.yield(0)
    end
    return streaming.has_model_loaded(model)
end

function unloadAnim(anim_dict, anim_set)
    return streaming.remove_anim_dict(anim_dict), streaming.remove_anim_set(anim_set)
end

function requestPTFX(ptfx_asset)
    local time <const> = utils.time_ms() + 500
    graphics.request_named_ptfx_asset(ptfx_asset)
    while time > utils.time_ms() and not graphics.has_named_ptfx_asset_loaded(ptfx_asset) do
        system.yield(0)
    end
    return graphics.has_named_ptfx_asset_loaded(ptfx_asset)
end

function addBlip(blipped_entity, blip_id)
    blipsTable[#blipsTable + 1] = ui.add_blip_for_entity(blipped_entity)
    ui.set_blip_sprite(blipsTable[#blipsTable], blip_id)
    return blipsTable[#blipsTable]
end

-- provided by ERR_NET_ARRAY
function customAmmoShooter(model_hash, pid)
    if ped.is_ped_shooting(player.get_player_ped(pid)) then
        local junk, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(pid))
        if (model_hash <= 72) then
            fire.add_explosion(pos, model_hash, true, false, 0, pid)
        elseif (streaming.is_model_a_ped(model_hash)) then
            requestModel(model_hash)
            local _ped = ped.create_ped(1, model_hash, pos, 0, true, false)
            streaming.set_model_as_no_longer_needed(model_hash)
        elseif (streaming.is_model_an_object(model_hash)) then
            requestModel(model_hash)
            object.create_object(model_hash, pos, true, false)
            streaming.set_model_as_no_longer_needed(model_hash)
        end
    end
end

-- From 2take1Script functions
function requestControl(entity_model, time)
    if (entity.is_an_entity(entity_model)) then
        if (not network.has_control_of_entity(entity_model)) then
            network.request_control_of_entity(entity_model)
            time = time or 50
            local new_time = utils.time_ms() + time

            while (entity.is_an_entity(entity_model) and not network.has_control_of_entity(entity_model)) do
                system.wait(0)
                network.request_control_of_entity(entity_model)

                if (new_time < utils.time_ms()) then
                    return false
                end
            end
        end
        return network.has_control_of_entity(entity_model)
    end
    return false
end

function requestControlNoDelay(entity_model, time)
    if (entity.is_an_entity(entity_model)) then
        if (not network.has_control_of_entity(entity_model)) then
            network.request_control_of_entity(entity_model)
        end
        return network.has_control_of_entity(entity_model)
    end
    return false
end

-- From gif.lua
function RGBToInt(R, G, B)
    return ((R&0x0ff)<<0x00)|((G&0x0ff)<<0x08)|((B&0x0ff)<<0x10)
end

-- Provided by Gee-Man
function _GF_raycast_vector(_ign_ent)
    _ign_ent = _ign_ent or 0
    local target = 17 -- use the website to determine different targets using bitshift
    local pos = player.get_player_coords(player.player_id())
    local my_pos = pos
    local my_rot = cam.get_gameplay_cam_rot()

    if player.is_player_in_any_vehicle(player.player_id()) then
        my_pos = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))+v3(0,0,2)
        pos = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
    end

    my_rot:transformRotToDir()
    my_rot = my_rot * 1000
    pos = pos + my_rot 
    local hit, ray_pos, ray_surf, ray_mat, ray_ent = worldprobe.raycast(my_pos ,pos, target, _ign_ent)
    local time = utils.time_ms() + 100

    while not hit and time > utils.time_ms() do
        system.yield(10)
        pos = player.get_player_coords(player.player_id())
        my_pos = pos
        if player.is_player_in_any_vehicle(player.player_id()) then
            my_pos = entity.get_entity_coords(player.get_player_vehicle(player.player_id())) + v3(0,0,2)
            pos = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
        end
        my_rot = cam.get_gameplay_cam_rot()
        my_rot:transformRotToDir()
        my_rot = my_rot * 1000
        pos = pos + my_rot 
        hit, ray_pos, ray_surf, ray_mat, ray_ent = worldprobe.raycast(my_pos, pos, target, _ign_ent)
    end
    return hit, ray_pos
end