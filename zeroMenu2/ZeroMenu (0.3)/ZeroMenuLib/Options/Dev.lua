local dev

function createDevEntry(parent,config)
  dev = menu.add_feature("Dev","parent",parent.id,nil)  
  menu.add_feature("Shit Bird Attack","action",dev.id,shitAttack) 
   
  
   
end


function shitAttack()
  local PedTypes = require("ZeroMenuLib/enums/PedType")
  
--create_ped(int type, Hash model, v3 pos, float heading, bool isNetworked, bool unk1)
  if streaming.has_model_loaded(0x06A20728) then
    local pos = player.get_player_coords(player.player_id())
    pos.x = pos.x+5
    print("type = " .. PedTypes.PED_TYPE_ANIMAL)
    local bird = ped.create_ped(PedTypes.PED_TYPE_ARMY,0x06A20728,pos,0.0,true,false)
    local bird2 = ped.create_ped(PedTypes.PED_TYPE_ARMY,0xD3939DFD,pos,0.0,true,false)
    local bird3 = ped.create_ped(PedTypes.PED_TYPE_ARMY,0xAAB71F62,pos,0.0,true,false)
    
    
    ai.task_combat_ped(bird,player.get_player_ped(player.player_id()),0,16)
    ai.task_combat_ped(bird2,player.get_player_ped(player.player_id()),0,16)
    ai.task_combat_ped(bird3,player.get_player_ped(player.player_id()),0,16)
    
    ui.notify_above_map("spawned bird... at " .. pos.x .. ":" .. pos.y .. ":" .. pos.z,"ZeroMenu",140)
    
    pos = player.get_player_coords(player.player_id())
    local explosionTypes = require("ZeroMenuLib/enums/ExplosionType")
    pos.z = pos.z +5
    
    fire.add_explosion(pos,explosionTypes.EXPLOSION_BIRD_CRAP,true,false,100.0, player.get_player_from_ped(player.player_id()))
    
    return HANDLER_POP
  else
    streaming.request_model(0x06A20728)
    streaming.request_model(0xD3939DFD)
    streaming.request_model(0xAAB71F62)
    print("waiting for model to load...")
    return HANDLER_CONTINUE
  end
end

function loadMusicFile()


  
end







