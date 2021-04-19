    -- Made by GhostOne
    -- Special thanks to Kektram

-- Check if LUA has already been has already been loaded 
  if GhostOneSpawnerLoadedAlready then
    ui.notify_above_map("Cancelling", "Rain LUA Already Loaded", math.random(1, 223))
    return HANDLER_POP
  end

-- Locals    
    local gottenModel_NameP
    local syswait = system.yield
    local rand = math.random
    local spawnAmountV = 20
    local spawnAmountP = 10
    local vradiusNUM = 5
    local vheightNUM = 5
    local pradiusNUM = 5
    local pheightNUM = 5
    local vdelayNUM  = 150
    local pdelayNUM  = 150
    local tableOfEntities = {}
    local cooldown
    local Vehicles = {}
    local vehAmountTCF = 1
    local VehHash = {}
    local deleteDelay = 15000
    local hdAD

-- Functions
    local function request_table_model(tablee)
      for i, VehHash1 in pairs(tablee) do
        if streaming.is_model_valid(VehHash1) then
          streaming.request_model(VehHash1)
          while not streaming.has_model_loaded(VehHash1) do
            system.yield(0)
          end
        else
          return HANDLER_POP
        end
      end
      return true
    end


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

    local function request_control(tableOfEntities)
      for i, Entity in pairs(tableOfEntities) do
        if not network.has_control_of_entity(Entity) then
          network.request_control_of_entity(Entity)
          local time = utils.time_ms() + 500
          while not network.has_control_of_entity(Entity) and time > utils.time_ms() do
            syswait(0)
          end
        else
          return true
        end
        return true
      end
    end


    local function remove_entities(pid, tableOfEntities)
      request_control(tableOfEntities)
      if request_control(tableOfEntities) then
        for i, Entity in pairs(tableOfEntities) do
          entity.set_entity_coords_no_offset(Entity, v3(16000, 16000, -2000))
          syswait(10)
        end
      end
    end

    local function checkModelType(Hash)
      if streaming.is_model_valid(Hash) then
        if streaming.is_model_a_ped(Hash) then
          return "PED"
        elseif streaming.is_model_a_vehicle(Hash) then
          return "VEHICLE"
        elseif streaming.is_model_an_object(Hash) then
          return "OBJECT"
        else
          return "not"
        end
      else
        return false
      end
    end

    local function spawn_vehicle(pid)
      if next(Vehicles) == nil then
        ui.notify_above_map("Set the model name / names", "~h~Error", 6)
      else
        for i, Vehicle in pairs(Vehicles) do
          VehHash[#VehHash + 1] = gameplay.get_hash_key(Vehicle)
        end
        for i, vehHash5 in pairs(VehHash) do
          if checkModelType(vehHash5) == "VEHICLE" then
            syswait(0)
          elseif checkModelType(vehHash5) == "PED" then
            ui.notify_above_map("One or more of the set models is a ped not a vehicle", "~h~Error", 6)
            Vehicles = {}
            VehHash = {}
            return HANDLER_POP
          elseif checkModelType(vehHash5) == "OBJECT" then
            ui.notify_above_map("One or more of the set models is an object not a vehicle", "~h~Error", 6)
            Vehicles = {}
            VehHash = {}
            return HANDLER_POP
          end
        end
        if not spawnAmountV then
          spawnAmountV = 5
          ui.notify_above_map("~h~Invaild Spawn Amount\nsetting to 5", "~h~Error", 6)
        end
        if request_table_model(VehHash) == true then
        for i = 1, spawnAmountV do
          local car = vehicle.create_vehicle(VehHash[rand(1, #VehHash)], player.get_player_coords(pid) + v3(rand(-vradiusNUM, vradiusNUM), rand(-vradiusNUM, vradiusNUM), vheightNUM), rand(1, 360), true, false)
          entity.set_entity_as_no_longer_needed(car)
          syswait(vdelayNUM)
        end
        for i, Hash in pairs(VehHash) do
          streaming.set_model_as_no_longer_needed(Hash)
        end
        VehHash = {}
        ui.notify_above_map("Successfully Rained For " ..player.get_player_name(pid), "Vehicle Spawner", 210)
        else
          VehHash = {}
          ui.notify_above_map("One or more of the model names was wrong", "~h~Error", 6)
        end
      end
    end

    --lil special feature
    local function lmao(f)
      if spawnAmountP == 35 and gottenModel_NameP == "69" and pradiusNUM == 20 and pheightNUM == 20 and pdelayNUM == 420 and deleteDelay == 420 then
        local e = menu.add_player_feature("Hidden feature", "action", pedSpwn, function(f)
          ui.notify_above_map("lmao this isnt gonna do anything", "Crashing "..player.get_player_name(player.player_id()), rand(1, 223))
        end)
        hdAD = true
      end
    end

    local function spawn_ped(pid, model_name)
      if not cooldown then
        local spectating = network.get_player_player_is_spectating(player.player_id())
        if spectating == pid or pid == player.player_id() then
          if not model_name then
            ui.notify_above_map("Set a model name", "~h~Error", 6)
            return HANDLER_POP
          end
          local Ped_Hash = gameplay.get_hash_key(model_name)
          if not spawnAmountP then
            spawnAmountP = 5
            ui.notify_above_map("~h~Invaild Spawn Amount\nsetting to 5", "~h~Error", 6)
          end
          if request_model(model_name) == true then
            if streaming.is_model_a_ped(Ped_Hash) then
              cooldown = true
              for i = 1, spawnAmountP do
                tableOfEntities[#tableOfEntities + 1] = ped.create_ped(4, Ped_Hash, player.get_player_coords(pid) + v3(rand(-pradiusNUM, pradiusNUM), rand(-pradiusNUM, pradiusNUM), pheightNUM), 0, true, false)
                network.request_control_of_entity(tableOfEntities[#tableOfEntities])
                syswait(pdelayNUM)
              end
              streaming.set_model_as_no_longer_needed(Ped_Hash)
              ui.notify_above_map("Successfully Rained " ..model_name.. " For " ..player.get_player_name(pid), "Ped Spawner", 210)
              ui.notify_above_map("Clearing peds in approximately "..deleteDelay + 2500 .." milliseconds, there will be a cooldown", "Ped Spawner", 210)
              syswait(deleteDelay)
              for i = 1, 15 do
                for i, entity in pairs(tableOfEntities) do
                  network.request_control_of_entity(entity)
                end
                request_control(tableOfEntities)
                remove_entities(pid, tableOfEntities)
              end
              for i, Entity in pairs(tableOfEntities) do
                entity.set_entity_as_no_longer_needed(Entity)
              end
              for i, Entity in pairs(tableOfEntities) do
                entity.set_entity_coords_no_offset(Entity, v3(16000, 16000, -2000))
              end
              ui.notify_above_map("Done deleting", "Ped Spawner", 210)
              tableOfEntities = {}
              cooldown = false
            else
              ui.notify_above_map("Model has to be a ped", "~h~Error", 6)
            end
          else
            ui.notify_above_map("Invalid model name", "~h~Error", 6)
          end
        else
          ui.notify_above_map("You have to spectate.", "Ped Spawner", 151)
        end
      end
    end

--Player Features
    RainParent = menu.add_player_feature("Ghost's Rain Spawner", "parent", 0).id
    pedSpwn = menu.add_player_feature("Ped Spawner", "parent", RainParent).id
    pedSettings = menu.add_player_feature("Settings", "parent", pedSpwn).id
    vehSpwn = menu.add_player_feature("Vehicle Spawner", "parent", RainParent).id
    vehSettings = menu.add_player_feature("Settings", "parent", vehSpwn).id

    menu.add_player_feature("Set Vehicle", "action", vehSettings, function() 
      Vehicles = {}
      for i = 1, vehAmountTCF do
        DefinedInput, Vehicles[#Vehicles + 1] = input.get("Set Model Name To Rain", "", 128, 0)
        while DefinedInput == 1 do
          DefinedInput, Vehicles[#Vehicles] = input.get("Set Model Name To Rain", "", 128, 0)
          syswait(0)
        end
      end
    end)

    menu.add_player_feature("Set Ped", "action", pedSettings, function() 
      DefinedInput3, gottenModel_NameP = input.get("Set Model Name To Rain", "", 128, 0)
      while DefinedInput3 == 1 do
        DefinedInput3, gottenModel_NameP = input.get("Set Model Name To Rain", "", 128, 0)
        syswait(0)
      end
    end)

    menu.add_player_feature("Set The Vehicle Spawn Amount", "action", vehSettings, function() 
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

    menu.add_player_feature("Set The Ped Spawn Amount", "action", pedSettings, function() 
      DefinedInput2, spawnAmountP = input.get("Amount of peds to rain on player (35 ped limit)", "", 2, 3)
      while DefinedInput2 == 1 do
        DefinedInput2, spawnAmountP = input.get("Amount of peds to rain on player (35 ped limit)", "", 2, 3)
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

    menu.add_player_feature("Set The Delete Delay", "action", pedSettings, function() 
      DefinedInput2, deleteDelay = input.get("Time delay of deleting the peds in ms (100-30000 limit)", "", 5, 3)
      while DefinedInput2 == 1 do
        DefinedInput2, deleteDelay = input.get("Time delay of deleting the peds in ms (100-30000 limit)", "", 5, 3)
        syswait(0)
      end
      deleteDelay = tonumber(deleteDelay)
      if not deleteDelay then
        return HANDLER_POP
      end
      if deleteDelay > 30000 then
        deleteDelay = 30000
      elseif deleteDelay < 100 then
        deleteDelay = 100
      elseif deleteDelay == nil then
        deleteDelay = 15000
      end
    end)


    menu.add_player_feature("Set Vehicle Radius", "autoaction_value_i", vehSettings, function(f)
      f.min_i = 0
      f.max_i = 20
      f.mod_i = 1
      vradiusNUM = f.value_i
    end)

    menu.add_player_feature("Set Vehicle Height", "autoaction_value_i", vehSettings, function(f)
      f.min_i = 0
      f.max_i = 20
      f.mod_i = 1
      vheightNUM = f.value_i
    end)

    menu.add_player_feature("Set Delay Between Spawns", "autoaction_value_i", vehSettings, function(f)
      f.min_i = 50
      f.max_i = 1000
      f.mod_i = 10
      vdelayNUM = f.value_i
    end)

    menu.add_player_feature("Amount of Vehicles To Choose From", "autoaction_value_i", vehSettings, function(f)
      f.min_i = 1
      f.max_i = 20
      f.mod_i = 1
      vehAmountTCF = f.value_i
      if vehAmountTCF > #Vehicles or vehAmountTCF < #Vehicles then
        Vehicles = {}
      end
    end)

    menu.add_player_feature("Set Ped Radius", "autoaction_value_i", pedSettings, function(f)
      f.min_i = 0
      f.max_i = 20
      f.mod_i = 1
      pradiusNUM = f.value_i
    end)

    menu.add_player_feature("Set Ped Height", "autoaction_value_i", pedSettings, function(f)
      f.min_i = 0
      f.max_i = 20
      f.mod_i = 1
      pheightNUM = f.value_i
    end)

    menu.add_player_feature("Set Delay Between Spawns", "autoaction_value_i", pedSettings, function(f)
      f.min_i = 50
      f.max_i = 1000
      f.mod_i = 10
      pdelayNUM = f.value_i
      if not hdAD then 
        lmao()
      end
    end)

    menu.add_player_feature("Rain Set Vehicle", "action", vehSpwn, function(f, pid)
      spawn_vehicle(pid)
    end)

    menu.add_player_feature("Rain Set Ped", "action", pedSpwn, function(f, pid)
      spawn_ped(pid, gottenModel_NameP)
    end)

    menu.add_player_feature("Rain Lester", "action", pedSpwn, function(f, pid)
      spawn_ped(pid, "cs_lestercrest")
    end)

--Setting menu to loaded already
GhostOneSpawnerLoadedAlready = true

ui.notify_above_map("Loaded Successfully", "~h~Rain LUA", 167)