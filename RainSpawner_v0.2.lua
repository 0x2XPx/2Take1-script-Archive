    -- Made by GhostOne
    -- Special thanks to Kektram

-- Locals    
    local gottenModel_NameV
    local gottenModel_NameP
    local syswait = system.yield
    local rand = math.random
    local spawnAmountV = 20
    local spawnAmountP = 10
    local vradiusNUM = 5
    local vheightNUM = 5
    local pradiusNUM = 5
    local pheightNUM = 5
    local tableOfEntities = {}
    local cooldown

-- Functions
    local function request_model(model_name)
      local Hash = gameplay.get_hash_key(model_name)
      if streaming.is_model_valid(Hash) then
        streaming.request_model(Hash)
        while not streaming.has_model_loaded(Hash) do
            system.yield(0)
        end
        return true
      end
    end

    local function request_control(tableOfEntities1)
      for i, Entity in pairs(tableOfEntities1) do
        if not network.has_control_of_entity(Entity) then
          network.request_control_of_entity(Entity)
          local time = utils.time_ms() + 500
          while not network.has_control_of_entity(Entity) and time > utils.time_ms() do
            syswait(0)
          end
        end
        return true
      end
    end


    local function remove_entities(pid, tableOfEntities2)
      request_control(tableOfEntities2)
      while not request_control(tableOfEntities2) do
        syswait(0)
      end
      for i, Entity in pairs(tableOfEntities2) do
        entity.set_entity_coords_no_offset(Entity, v3(16000, 16000, -2000))
        syswait(10)
        entity.delete_entity(Entity)
      end
    end


    local function spawn_vehicle(pid, model_name)
      if not model_name then
        ui.notify_above_map("You Almost Broke The Function!\nGo set a model name", "~h~~r~C~y~o~o~n~g~g~b~r~r~a~y~t~o~s~g~!", 151)
        return HANDLER_POP
      end
      local Veh_Hash = gameplay.get_hash_key(model_name)
      if not spawnAmountV then
        spawnAmountV = 5
        ui.notify_above_map("~h~Invaild Spawn Amount\nsetting to 5", "~h~Error", 6)
      end
      if request_model(model_name) == true then
        if streaming.is_model_a_vehicle(Veh_Hash) then
          for i = 1, spawnAmountV do
              local car = vehicle.create_vehicle(Veh_Hash, player.get_player_coords(pid) + v3(rand(-vradiusNUM, vradiusNUM), rand(-vradiusNUM, vradiusNUM), vheightNUM), 0, true, false)
              entity.set_entity_as_no_longer_needed(car)
              syswait(10)
          end
            streaming.set_model_as_no_longer_needed(Veh_Hash)
            ui.notify_above_map("Successfully Rained " ..model_name.. " For " ..player.get_player_name(pid), "Vehicle Spawner", 210)
          else
            ui.notify_above_map("~h~Model has to be a car", "~h~Error", 6)
        end
      end
    end

    local function spawn_ped(pid, model_name)
      if not cooldown then
        local spectating = network.get_player_player_is_spectating(player.player_id())
        if spectating == pid or pid == player.player_id() then
          if not model_name then
            ui.notify_above_map("You Almost Broke The Function!\nGo set a model name", "~h~~r~C~y~o~o~n~g~g~b~r~r~a~y~t~o~s~g~!", 151)
            return HANDLER_POP
          end
          local Ped_Hash = gameplay.get_hash_key(model_name)
          if not spawnAmountP then
            spawnAmountP = 5
            ui.notify_above_map("~h~Invaild Spawn Amount\nsetting to 5", "~h~Error", 6)
          end
          if request_model(model_name) == true then
            if streaming.is_model_a_ped(Ped_Hash) then
              for i = 1, spawnAmountP do
                tableOfEntities[#tableOfEntities + 1] = ped.create_ped(4, Ped_Hash, player.get_player_coords(pid) + v3(rand(-pradiusNUM, pradiusNUM), rand(-pradiusNUM, pradiusNUM), pheightNUM), 0, true, false)
                syswait(150)
              end
              streaming.set_model_as_no_longer_needed(Ped_Hash)
              ui.notify_above_map("Successfully Rained " ..model_name.. " For " ..player.get_player_name(pid), "Ped Spawner", 210)
              ui.notify_above_map("Clearing peds in 15 seconds, there will be a cooldown", "Ped Spawner", 210)
              cooldown = true
              syswait(15000)
              cooldown = false
              for i, Entity in pairs(tableOfEntities) do
                entity.set_entity_as_no_longer_needed(Entity)
              end
              remove_entities(pid, tableOfEntities)
              for i, Entity in pairs(tableOfEntities) do
                entity.set_entity_coords_no_offset(Entity, v3(16000, 16000, -2000))
                entity.delete_entity(Entity)
              end
              ui.notify_above_map("Done deleting", "Ped Spawner", 210)
              tableOfEntities = {}
            else
              ui.notify_above_map("~h~Model has to be a ped", "~h~Error", 6)
            end
          else
            ui.notify_above_map("~h~Invalid model_name", "~h~Error", 6)
          end
        else
          ui.notify_above_map("You have to spectate.", "Ped Spawner", 151)
        end
      end
    end

--Player Features
    RainParent = menu.add_player_feature("Ghost's Rain Spawner", "parent", 0).id
    pedSpwn = menu.add_player_feature("Ped Spawner", "parent", RainParent).id
    vehSpwn = menu.add_player_feature("Vehicle Spawner", "parent", RainParent).id

    menu.add_player_feature("Set Vehicle", "action", vehSpwn, function() 
      DefinedInput, gottenModel_NameV = input.get("Set Model Name To Rain", "", 128, 0)
      while DefinedInput == 1 do
        DefinedInput, gottenModel_NameV = input.get("Set Model Name To Rain", "", 128, 0)
        syswait(0)
      end
    end)

    menu.add_player_feature("Set Ped", "action", pedSpwn, function() 
      DefinedInput3, gottenModel_NameP = input.get("Set Model Name To Rain", "", 128, 0)
      while DefinedInput3 == 1 do
        DefinedInput3, gottenModel_NameP = input.get("Set Model Name To Rain", "", 128, 0)
        syswait(0)
      end
    end)

    menu.add_player_feature("Set The Vehicle Spawn Amount", "action", vehSpwn, function() 
      DefinedInput1, spawnAmountV = input.get("Amount of vehicles to rain on player (100 vehicle limit)", "", 3, 3)
      while DefinedInput1 == 1 do
        DefinedInput1, spawnAmountV = input.get("Amount of vehicles to rain on player (100 vehicle limit)", "", 3, 3)
        syswait(0)
      end
      spawnAmountV = tonumber(spawnAmountV)
      if not spawnAmountV then
        return HANDLER_POP
      end
      if spawnAmountV > 100 then
        spawnAmountV = 100
      elseif spawnAmountV < 1 then
        spawnAmountV = 1
      elseif spawnAmountV == nil then
        spawnAmountV = 5
      end
    end)

    menu.add_player_feature("Set The Ped Spawn Amount", "action", pedSpwn, function() 
      DefinedInput2, spawnAmountP = input.get("Amount of peds to rain on player (35 ped limit)", "", 3, 3)
      while DefinedInput2 == 1 do
        DefinedInput2, spawnAmountP = input.get("Amount of peds to rain on player (35 ped limit)", "", 3, 3)
        syswait(0)
      end
      spawnAmountP = tonumber(spawnAmountP)
      if not spawnAmountP then
        return HANDLER_POP
      end
      if spawnAmountP > 35 then
        spawnAmountP = 35
      elseif spawnAmountP < 1 then
        spawnAmountP = 1
      elseif spawnAmountP == nil then
        spawnAmountP = 5
      end
    end)

    menu.add_player_feature("Set Vehicle Radius", "autoaction_value_i", vehSpwn, function(f)
      f.min_i = 0
      f.max_i = 20
      f.mod_i = 1
      vradiusNUM = f.value_i
    end)

    menu.add_player_feature("Set Vehicle Height", "autoaction_value_i", vehSpwn, function(f)
      f.min_i = 0
      f.max_i = 20
      f.mod_i = 1
      vheightNUM = f.value_i
    end)

    menu.add_player_feature("Set Ped Radius", "autoaction_value_i", pedSpwn, function(f)
      f.min_i = 0
      f.max_i = 20
      f.mod_i = 1
      pradiusNUM = f.value_i
    end)

    menu.add_player_feature("Set Ped Height", "autoaction_value_i", pedSpwn, function(f)
      f.min_i = 0
      f.max_i = 20
      f.mod_i = 1
      pheightNUM = f.value_i
    end)

    menu.add_player_feature("Rain Set Vehicle", "action", vehSpwn, function(f, pid) 
      spawn_vehicle(pid, gottenModel_NameV)
    end)

    menu.add_player_feature("Rain Set Ped", "action", pedSpwn, function(f, pid) 
      spawn_ped(pid, gottenModel_NameP)
    end)

    menu.add_player_feature("Rain Lester", "action", pedSpwn, function(f, pid) 
      spawn_ped(pid, "cs_lestercrest")
    end)