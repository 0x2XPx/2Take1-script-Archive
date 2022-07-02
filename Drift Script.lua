-- Special Thanks To Proddy!

if DriftMod then
	ui.notify_above_map("Drift Lua already loaded", "Drift Mod", 6)
	return
end

LocalMain = menu.add_feature("Drift Script V1.3.1", "parent", 0).id

local controller = menu.add_feature("Controller Features", "parent", LocalMain)
local neon = menu.add_feature("Neons", "parent", LocalMain)

local kits = menu.add_feature("Neon Kits", "parent", neon.id)
----------------------------------- NEON KIT STUFF
menu.add_feature("Rainbow Neons - Fast", "toggle", neon.id, function(f) -- thanks to rimuru for the idea :D
    if f.on then
        local mvehicle =  ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
          if(ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id()))) then
         for i=1, 8 do
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1500)
            system.wait(1)
            vehicle.set_vehicle_neon_lights_color(mvehicle, 191283128941589)
            system.wait(1)
            vehicle.set_vehicle_neon_lights_color(mvehicle, 905848505689)
            system.wait(1)
            
         end
         else
             menu.notify("Get in a car for this to work :)")
        end
return HANDLER_CONTINUE
     end
     if not f.on then
           return HANDLER_POP
     end
end)

menu.add_feature("Rainbow Neons - Slow", "toggle", neon.id, function(f) -- thanks to rimuru for the idea :D
    if f.on then
        local mvehicle =  ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
          if(ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id()))) then
         for i=1, 8 do
            vehicle.set_vehicle_neon_lights_color(mvehicle, 191283128941589)
            system.wait(480)
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1500)
            system.wait(480)
            vehicle.set_vehicle_neon_lights_color(mvehicle, 905848505689)
            system.wait(480)
            
         end
         else
             menu.notify("Get in a car for this to work :)")
        end
return HANDLER_CONTINUE
     end
     if not f.on then
           return HANDLER_POP
     end
end)

menu.add_feature("White", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 123129643123123)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Blue", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1000)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Electric Blue", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1000086)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Mint Green", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1238123)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Lime Green", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 290491924)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Yellow", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 191283128941589)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Golden Shower", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 905678460323858)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Orange", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 141234123456784)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Pony Pink", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 905848505689)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Purple", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 141234124)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Blacklight", "action", kits.id, function(y)
    if y.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1500)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

menu.add_feature("Remove Neons", "action", neon.id, function(f)
    if f.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local mvehicle = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_neon_lights_color(mvehicle, 1)
            for i = 1, 8 do
                vehicle.set_vehicle_neon_light_enabled(mvehicle, i, true)
            end
        else
            menu.notify("Get in a car for this to work")
        end
    end
end)

----------------------------------- DRIFT MOD STUFF CONTROLLER
-- Configurables

local gs_driftMinSpeed = 8.0
local gs_driftMaxAngle = 50.0
local gs_driftOppLock = 0.375
local ControlVehicleAccelerate = 71
local ControlVehicleBrake = 72
local ControlVehicleDuck = 73
local ControlVehicleSelectNextWeapon = 99
local ControlVehicleMoveUpOnly = 61

local function asDegrees(angle)
    return angle * (180.0 / 3.14159265357); 
end

local function wrap360(val) 
    --    return math.fmod(val + 360 + 360, 360)
    while (val < 0.0) do
        val = val + 360.0
    end
    while (val > 360.0) do
        val = val - 360.0
    end
    return val
end

local function getCurrentVehicle() 
	local player_id = player.player_id()
	local player_ped = player.get_player_ped(player_id)
    local player_vehicle = 0
    if (ped.is_ped_in_any_vehicle(player_ped)) then
        local veh = ped.get_vehicle_ped_is_using(player_ped)
        if (network.has_control_of_entity(veh)) then
            player_vehicle = veh
        end
    end
    return player_vehicle
end


local function getHeadingOfTravel(veh) 
    local velocity = entity.get_entity_velocity(veh)
    local x = velocity.x
    local y = velocity.y
    local at2 = math.atan(y, x)
    return math.fmod(270.0 + math.deg(at2), 360.0)
end

local function randomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end

local function RGBAToInt(R, G, B, A)
	A = A or 255
	return ((tonumber(R)&0x0ff)<<0x00)|((tonumber(G)&0x0ff)<<0x08)|((tonumber(B)&0x0ff)<<0x10)|((tonumber(A)&0x0ff)<<0x18)
end

local function slamDatBitch(veh, height) 
    if (vehicle.is_vehicle_on_all_wheels(veh) and not entity.is_entity_in_air(veh)) then
        -- apply_force_to_entity(Ped ped, int forceType, float x, float y, float z, float rx, float ry, float rz, bool isRel, bool highForce)	 entity.apply_force_to_entity

        entity.apply_force_to_entity(veh, 1,    0, 0, height,    0, 0, 0,   true, true)
    end
end

local isDrifting      = 0
local wasDrifting     = 0
local isDriftFinished = 1
local prevGripState   = 0
local lastDriftAngle  = 0.0
local oldGripState    = 0
local debug_notification = 0

local function driftmod_ontick() 
    local player = player.player_id(); -- however you get the current player
    local veh = getCurrentVehicle()
    --
    -- if (not entity.does_entity_exist(veh)) then
    --    return
    -- end

    local inVehicle   = veh ~= 0
	
    local isDriving   = true

    local mps = entity.get_entity_speed(veh)
    local mph       = mps * 2.23694
    local kmh       = mps * 3.6

    -- isDrifting = false
    -- vehicle.set_vehicle_reduce_grip(veh, false)

    -- for later
    -- if (isDriving and TOGGLED("featureVehConstantBoost")) jordans_boost()

    if (inVehicle and isDriving and not isDrifting and not isDriftFinished) then
        isDriftFinished = true
    end

    if not inVehicle or not isDriving then
        return
    end

    -- if (isDrifting)
        -- drawText("Drifting")
    -- if (vehicle.is_vehicle_in_burnout(veh)) (2, 206)
        -- drawRect("Burnout")

    local driftKeyPressed = (controls.is_control_pressed(-1, 1) or controls.is_disabled_control_pressed(2, 206)) and controls.is_control_pressed(2, 193) or controls.is_disabled_control_pressed(2, 193)

    -- if (not driftKeyPressed and controls.is_control_pressed(0, ControlVehicleMoveUpOnly) and vehicle.is_vehicle_on_all_wheels(veh)) then
    --     driftKeyPressed = true 
    -- end

    if (driftKeyPressed and vehicle.get_vehicle_current_gear(veh) > 2) then
        vehicle.set_vehicle_current_gear(veh, 2)
        vehicle.set_vehicle_next_gear(veh, 2)
    end

    if (driftKeyPressed) then
        if (controls.get_control_normal(2, ControlVehicleBrake) > 0.1) then
            controls.set_control_normal(0, ControlVehicleBrake, 0)
            local neg = -0.3

            if (controls.is_control_pressed(2, ControlVehicleSelectNextWeapon)) then
                neg = 10
            end

            slamDatBitch(veh, neg * 1 * controls.get_control_normal(2, ControlVehicleBrake))
        end 

        local angleOfTravel  = getHeadingOfTravel(veh)
        local angleOfHeading = entity.get_entity_heading(veh)
        local drift          = angleOfHeading - angleOfTravel

        if (drift and lastDriftAngle) then
            local diff = drift - lastDriftAngle

            if (diff > 180.0) then
                drift = drift - 360.0
            end
            if (diff < 180.0) then
                drift = drift - 360.0
            end
        end

        -- drift = math.fmod(drift, 360)
        drift          = wrap360(drift)
        lastDriftAngle = drift

        local td = 360 - drift
        if td > 180 then
            td = 0 - (360 - td)
        end
        --ui.draw_text(td, v2(0.5, 0.2))

        local done = false
        if ((isDrifting or kmh > gs_driftMinSpeed) and (math.abs(drift - 360.0) < gs_driftMaxAngle) or (drift < gs_driftMaxAngle)) then
            isDrifting      = 1
            isDriftFinished = 1;  -- Doesn't get set to 0 until isDrifting is 0.

            if (driftKeyPressed) then
                if (driftKeyPressed ~= oldGripState) then
                    vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done and kmh < gs_driftMinSpeed then
            if (driftKeyPressed) then
                if (driftKeyPressed ~= oldGripState) then
                    vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done then
            if driftKeyPressed == oldGripState then
                vehicle.set_vehicle_reduce_grip(veh, false)
                oldGripState = 0
            end
		else 
			vehicle.set_vehicle_indicator_lights(veh, 0, false)
			vehicle.set_vehicle_indicator_lights(veh, 1, false)
        end
    end

    if (not driftKeyPressed and prevGripState) then
        isDrifting      = 0
        isDriftFinished = 0
        lastDriftAngle = 0

        if (driftKeyPressed ~= oldGripState) then
            vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
            oldGripState = driftKeyPressed
        end
    end

    prevGripState = driftKeyPressed
    if (isDrifting ~= wasDrifting) then
        wasDrifting     = isDrifting
        changedDrifting = true
    end
end

local driftmod = menu.add_feature("DriftMod ", "toggle", controller.id, function(f)
    menu.notify("Press Square On The PS Controller To Activate :):)")	-- i dont know what the button is on an xbox controller, if you do please dm me "Flames#6666"
	while f.on do	
		driftmod_ontick()
		system.yield(0)
	end
end)
driftmod.on = false  -- enable this if you want the "DriftMod" feature on when you launch the script

DriftMod = true

----------------------------------- DRIFT MOD STUFF

----------------------------------- DRIFT MOD STUFF CONTROLLER
-- Configurables

local gs_driftMinSpeed = 8.0
local gs_driftMaxAngle = 50.0
local gs_driftOppLock = 0.375
local ControlVehicleAccelerate = 71
local ControlVehicleBrake = 72
local ControlVehicleDuck = 73
local ControlVehicleSelectNextWeapon = 99
local ControlVehicleMoveUpOnly = 61

local function asDegrees(angle)
    return angle * (180.0 / 3.14159265357); 
end

local function wrap360(val) 
    --    return math.fmod(val + 360 + 360, 360)
    while (val < 0.0) do
        val = val + 360.0
    end
    while (val > 360.0) do
        val = val - 360.0
    end
    return val
end

local function getCurrentVehicle() 
	local player_id = player.player_id()
	local player_ped = player.get_player_ped(player_id)
    local player_vehicle = 0
    if (ped.is_ped_in_any_vehicle(player_ped)) then
        local veh = ped.get_vehicle_ped_is_using(player_ped)
        if (network.has_control_of_entity(veh)) then
            player_vehicle = veh
        end
    end
    return player_vehicle
end


local function getHeadingOfTravel(veh) 
    local velocity = entity.get_entity_velocity(veh)
    local x = velocity.x
    local y = velocity.y
    local at2 = math.atan(y, x)
    return math.fmod(270.0 + math.deg(at2), 360.0)
end

local function randomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end

local function RGBAToInt(R, G, B, A)
	A = A or 255
	return ((tonumber(R)&0x0ff)<<0x00)|((tonumber(G)&0x0ff)<<0x08)|((tonumber(B)&0x0ff)<<0x10)|((tonumber(A)&0x0ff)<<0x18)
end

local function slamDatBitch(veh, height) 
    if (vehicle.is_vehicle_on_all_wheels(veh) and not entity.is_entity_in_air(veh)) then
        -- apply_force_to_entity(Ped ped, int forceType, float x, float y, float z, float rx, float ry, float rz, bool isRel, bool highForce)	 entity.apply_force_to_entity

        entity.apply_force_to_entity(veh, 1,    0, 0, height,    0, 0, 0,   true, true)
    end
end

local isDrifting      = 0
local wasDrifting     = 0
local isDriftFinished = 1
local prevGripState   = 0
local lastDriftAngle  = 0.0
local oldGripState    = 0
local debug_notification = 0

local function driftmod_ontick() 
    local player = player.player_id(); -- however you get the current player
    local veh = getCurrentVehicle()
    --
    -- if (not entity.does_entity_exist(veh)) then
    --    return
    -- end

    local inVehicle   = veh ~= 0
	
    local isDriving   = true

    local mps = entity.get_entity_speed(veh)
    local mph       = mps * 2.23694
    local kmh       = mps * 3.6

    -- isDrifting = false
    -- vehicle.set_vehicle_reduce_grip(veh, false)

    -- for later
    -- if (isDriving and TOGGLED("featureVehConstantBoost")) jordans_boost()

    if (inVehicle and isDriving and not isDrifting and not isDriftFinished) then
        isDriftFinished = true
    end

    if not inVehicle or not isDriving then
        return
    end

    -- if (isDrifting)
        -- drawText("Drifting")
    -- if (vehicle.is_vehicle_in_burnout(veh)) (2, 206)
        -- drawRect("Burnout")

        local driftKeyPressed = controls.is_control_pressed(3, ControlVehicleDuck) or controls.is_disabled_control_pressed(2, ControlVehicleDuck) or controls.is_control_pressed(0, ControlVehicleMoveUpOnly) or controls.is_disabled_control_pressed(0, ControlVehicleMoveUpOnly)

    -- if (not driftKeyPressed and controls.is_control_pressed(0, ControlVehicleMoveUpOnly) and vehicle.is_vehicle_on_all_wheels(veh)) then
    --     driftKeyPressed = true 
    -- end

    if (driftKeyPressed and vehicle.get_vehicle_current_gear(veh) > 2) then
        vehicle.set_vehicle_current_gear(veh, 2)
        vehicle.set_vehicle_next_gear(veh, 2)
    end

    if (driftKeyPressed) then
        if (controls.get_control_normal(2, ControlVehicleBrake) > 0.1) then
            controls.set_control_normal(0, ControlVehicleBrake, 0)
            local neg = -0.3

            if (controls.is_control_pressed(2, ControlVehicleSelectNextWeapon)) then
                neg = 10
            end

            slamDatBitch(veh, neg * 1 * controls.get_control_normal(2, ControlVehicleBrake))
        end 

        local angleOfTravel  = getHeadingOfTravel(veh)
        local angleOfHeading = entity.get_entity_heading(veh)
        local drift          = angleOfHeading - angleOfTravel

        if (drift and lastDriftAngle) then
            local diff = drift - lastDriftAngle

            if (diff > 180.0) then
                drift = drift - 360.0
            end
            if (diff < 180.0) then
                drift = drift - 360.0
            end
        end

        -- drift = math.fmod(drift, 360)
        drift          = wrap360(drift)
        lastDriftAngle = drift

        local td = 360 - drift
        if td > 180 then
            td = 0 - (360 - td)
        end
        --ui.draw_text(td, v2(0.5, 0.2))

        local done = false
        if ((isDrifting or kmh > gs_driftMinSpeed) and (math.abs(drift - 360.0) < gs_driftMaxAngle) or (drift < gs_driftMaxAngle)) then
            isDrifting      = 1
            isDriftFinished = 1;  -- Doesn't get set to 0 until isDrifting is 0.

            if (driftKeyPressed) then
                if (driftKeyPressed ~= oldGripState) then
                    vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done and kmh < gs_driftMinSpeed then
            if (driftKeyPressed) then
                if (driftKeyPressed ~= oldGripState) then
                    vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done then
            if driftKeyPressed == oldGripState then
                vehicle.set_vehicle_reduce_grip(veh, false)
                oldGripState = 0
            end
		else 
			vehicle.set_vehicle_indicator_lights(veh, 0, false)
			vehicle.set_vehicle_indicator_lights(veh, 1, false)
        end
    end

    if (not driftKeyPressed and prevGripState) then
        isDrifting      = 0
        isDriftFinished = 0
        lastDriftAngle = 0

        if (driftKeyPressed ~= oldGripState) then
            vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
            oldGripState = driftKeyPressed
        end
    end

    prevGripState = driftKeyPressed
    if (isDrifting ~= wasDrifting) then
        wasDrifting     = isDrifting
        changedDrifting = true
    end
end

local driftmod = menu.add_feature("DriftMod", "toggle", LocalMain, function(f)
    menu.notify("Press Shift To Activate :)") -- :)
	while f.on do	
		driftmod_ontick()
		system.yield(0)
	end
end)
driftmod.on = false  -- enable "true" this if you want the "DriftMod" feature on when you launch the script

DriftMod = true

----------------------------------- DRIFT MOD STUFF

----------------------------------- NO TRACTION STUFF

menu.add_feature("No Traction", "toggle", LocalMain, function(j) -- skidded with love from fun menu :D
    local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  while (j.on) do
        if (not player.is_player_in_any_vehicle(player.player_id())) then
            menu.notify("You need to be in a vehicle to use No Traction")
            j.on = false
        end
        vehicle.set_vehicle_reduce_grip(player_veh, true)
        system.wait(1000)
    end
    if (not j.on) then
        vehicle.set_vehicle_reduce_grip(player_veh, false)
    end
end)

--------------------------------------

menu.add_feature("No Collision", "toggle", LocalMain, function(f)
    if f.on then
        local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
        if veh and vehicle.get_ped_in_vehicle_seat(veh, -1) == player.get_player_ped(player.player_id()) then
            local collision = ped.get_all_peds()
            for i = 1, #collision do
                entity.set_entity_no_collsion_entity(collision[i], veh, true)
                entity.set_entity_no_collsion_entity(veh, collision[i], true)
            end
            collision = object.get_all_objects()
            for i = 1, #collision do
                entity.set_entity_no_collsion_entity(collision[i], veh, true)
                entity.set_entity_no_collsion_entity(veh, collision[i], true)
            end
            collision = vehicle.get_all_vehicles()
            for i = 1, #collision do
                entity.set_entity_no_collsion_entity(collision[i], veh, true)
                entity.set_entity_no_collsion_entity(veh, collision[i], true)
            end
        end
    end
    return HANDLER_CONTINUE
end)

---------------------------------------------------
