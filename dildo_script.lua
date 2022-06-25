function RequestModel(Hash, Timeout)
    if streaming.has_model_loaded(Hash) then
      return true
    end
    Timeout = (Timeout or 1800) + utils.time_ms()
    streaming.request_model(Hash)
    while utils.time_ms() < Timeout do
        if streaming.has_model_loaded(Hash) then
            return true
        end
        system.wait(0)
    end
    return streaming.has_model_loaded(Hash)
end

function attachPTFX(entity,dict,ptfx,scale,offset,rot)
  graphics.set_next_ptfx_asset(dict)
  while not graphics.has_named_ptfx_asset_loaded(dict) do
    graphics.request_named_ptfx_asset(dict)
    system.wait(0)
    return HANDLER_CONTINUE 
  end
  graphics.start_networked_ptfx_looped_on_entity(ptfx,entity,offset,rot,scale)
end

menu.add_feature("Attach Dildo", "action", 0, function(feat, pid)
    local pped = player.get_player_ped(player.player_id())
    local dildo = 0xe6cb661e
    local rot = v3(270, 0, 0)
    local offset = v3(0, 0.15, -0.2)
    local gotModel = RequestModel(dildo, 1800)
    
    local objectdildo = object.create_object(dildo, player.get_player_coords(player.player_id()), true, true)
    
    local SmokeOffset = v3(0,0,0.1)
    local SmokeRot = v3(0,90,0)
    attachPTFX(objectdildo,"core","ent_amb_candle_flame",1.0,SmokeOffset,SmokeRot)
    entity.attach_entity_to_entity(objectdildo, pped, 0, offset, rot, false, true, false, 0, true)
    
    --balls
    --w_ex_snowball:1297482736
    --prop_pool_ball_01:473985065
    local snowball = 1297482736
    
    RequestModel(snowball, 1800)
    rot = v3(0, 0, 0)
    offset = v3(0.05, 0.10, -0.2)
    
    local Ball1 = object.create_object(snowball, player.get_player_coords(player.player_id()), true, true)
    entity.attach_entity_to_entity(Ball1, pped, 0, offset, rot, false, true, false, 0, true)
  
    rot = v3(0, 0, 0)
    offset = v3(-0.05, 0.10, -0.2)
    
    local Ball2 = object.create_object(snowball, player.get_player_coords(player.player_id()), true, true)
    entity.attach_entity_to_entity(Ball2, pped, 0, offset, rot, false, true, false, 0, true)
end)











