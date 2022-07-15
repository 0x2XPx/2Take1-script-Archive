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

-- provided by ERR_NET_ARRAY
function customAmmoShooter(model_hash, pid)
    if ped.is_ped_shooting(player.get_player_ped(pid)) then
        local junk, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(pid))
        if (model_hash <= 72) then
            fire.add_explosion(pos, model_hash, true, false, 0, pid)
        else
            requestModel(model_hash)
            local entity1 = ped.create_ped(1, model_hash, pos, 0, true, false)
            entity.set_entity_god_mode(entity1, true)
        end
    end
end