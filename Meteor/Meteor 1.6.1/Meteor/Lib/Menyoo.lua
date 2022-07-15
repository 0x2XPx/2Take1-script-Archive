local utilities = require("Meteor/Lib/Utils")
local natives = require("Meteor/Lib/Natives")
local text_func = require("Meteor/Lib/Text_Func")

local xml_handler = {}

local function tobool(Any)
    if Any == "true" then
        return true
    else
        return false
    end
end

local function revbool(Boolean)
    local real = tostring(Boolean)
    if real == "true" then
        return false
    else
        return true
    end
end

local function toint(Any)
    local str = tostring(Any)
    local integer, null = str:find("%.")
    if integer then
        return tonumber(str:sub(1, integer - 1))
    else
        return Any
    end
end

function xml_handler.spawn_vehicle(string_path, v3_pos, float_heading)
    if (not utils.file_exists(string_path)) or (utils.file_exists(string_path) and not text_func.string_ends_with(string_path, ".xml")) then
        menu.notify("Xml file not found or invalid", Meteor, 4, 211)
        return
    end

    local is_main_vehicle = true

    local all_entities = {}

    local xml_version = ""
    local xml_encoding = ""
    local menyoo_ver = ""

    local last_ent_hash = 0
    local last_ent_handle = 0

    local main_ent = nil

    local all_entity_handles = {}

    local apply_props = false
    local last_ent_mod = nil

    local color_prim = nil
    local color_sec = nil
    local wheel_smoke_r = nil
    local wheel_smoke_g = nil
    local wheel_smoke_b = nil

    local neon_light_r = nil
    local neon_light_g = nil
    local neon_light_b = nil

    local bullet_proof = false
    local collision_proof = false
    local explosion_proof = false
    local fire_proof = false
    local melee_proof = false
    
    local attach_handler = nil
    local attach_bone = 0
    local attach_x = 0.0
    local attach_y = 0.0
    local attach_z = 0.0
    local attach_rot_p = 0.0
    local attach_rot_r = 0.0
    local attach_rot_y = 0.0

    local task_dur = nil
    local task_keep_running = nil
    local task_looped = nil
    local task_dict = nil
    local task_name = nil
    local task_speed = nil
    local task_speed_mult = nil
    local task_flag = nil
    local task_lock_pos = nil
    local task_override_dur = nil

    local attach_x_index = false
    local attach_y_index = false
    local attach_z_index = false
    local attach_rot_p_index = false
    local attach_rot_r_index = false
    local attach_rot_y_index = false

    local new_ent_attachment = false
    local new_sub_ent_attachment = false

    local last_ent_type = nil

    local last_ent_spawn_info_1 = false
    local last_ent_spawn_info_2 = false
    local last_ent_spawn_info_3 = false
    local last_ent_spawn_info_4 = false
    local last_ent_spawn_info_5 = false

    local file = io.open(string_path)
    for line in file:lines() do
        if string.find(line, "<?xml version=") and string.find(line, " encoding=") and string.find(line, "?>") then
            xml_version = text_func.string_cut(line, "version=", " encoding=")
            xml_encoding = text_func.string_cut(line, "encoding=", "?>")
        end
        if string.find(line, "<Vehicle menyoo_ver=") then
            menyoo_ver = text_func.string_cut(line, "menyoo_ver=", ">")
        end
        if is_main_vehicle then
            if string.find(line, "<ModelHash>") then
                local model_hash = text_func.string_cut(line, "<ModelHash>", "</ModelHash>")
                if streaming.is_model_valid(model_hash) then
                    last_ent_hash = model_hash
                else
                    return
                end
            end
            if string.find(line, "<InitialHandle>") then
                local ent_handle = text_func.string_cut(line, "<InitialHandle>", "</InitialHandle>")
                last_ent_handle = ent_handle
                all_entity_handles[#all_entity_handles + 1] = ent_handle
            end
            if string.find(line, "<VehicleProperties>") then
                apply_props = true
                utilities.request_model(last_ent_hash)
                main_ent = vehicle.create_vehicle(last_ent_hash, v3_pos, float_heading, true, false)
                all_entities["" .. last_ent_handle .. ""] = main_ent
                attach_handler = main_ent
                network.request_control_of_entity(main_ent)
            end
            if apply_props then
                if string.find(line, "<Colours>") then
                    last_ent_mod = "<Colours>"
                end
                if last_ent_mod == "<Colours>" then
                    if string.find(line, "<Primary>") then
                        color_prim = toint(text_func.string_cut(line, "<Primary>", "</Primary>"))
                    end
                    if string.find(line, "<Secondary>") then
                        color_sec = toint(text_func.string_cut(line, "<Secondary>", "</Secondary>"))
                    end
                    if color_prim ~= nil and color_sec ~= nil then
                        vehicle.set_vehicle_colors(main_ent, color_prim, color_sec)
                    end
                    if string.find(line, "<Pearl>") then
                        vehicle.set_vehicle_custom_pearlescent_colour(main_ent, toint(text_func.string_cut(line, "<Pearl>", "</Pearl>")))
                    end
                    if string.find(line, "<tyreSmoke_R>") then
                        wheel_smoke_r = toint(text_func.string_cut(line, "<tyreSmoke_R>", "</tyreSmoke_R>"))
                    end
                    if string.find(line, "<tyreSmoke_G>") then
                        wheel_smoke_g = toint(text_func.string_cut(line, "<tyreSmoke_G>", "</tyreSmoke_G>"))
                    end
                    if string.find(line, "<tyreSmoke_B>") then
                        wheel_smoke_b = toint(text_func.string_cut(line, "<tyreSmoke_B>", "</tyreSmoke_B>"))
                    end
                    if wheel_smoke_r ~= nil and wheel_smoke_g ~= nil and wheel_smoke_b ~= nil then
                        vehicle.set_vehicle_tire_smoke_color(main_ent, wheel_smoke_r, wheel_smoke_g, wheel_smoke_b)
                    end
                    if string.find(line, "<LrInterior>") then
                        natives.SET_VEHICLE_INTERIOR_COLOR(main_ent, toint(text_func.string_cut(line, "<LrInterior>", "</LrInterior>")))
                    end
                    if string.find(line, "<LrDashboard>") then
                        natives.SET_VEHICLE_DASHBOARD_COLOR(main_ent, toint(text_func.string_cut(line, "<LrDashboard>", "</LrDashboard>")))
                    end
                end
                if string.find(line, "<Livery>") then
                    natives.SET_VEHICLE_LIVERY(main_ent, toint(text_func.string_cut(line, "<Livery>", "</Livery>")))
                end
                if string.find(line, "<NumberPlateText>") then
                    vehicle.set_vehicle_number_plate_text(main_ent, text_func.string_cut(line, "<NumberPlateText>", "</NumberPlateText>"))
                end
                if string.find(line, "<NumberPlateIndex>") then
                    vehicle.set_vehicle_number_plate_index(main_ent, toint(text_func.string_cut(line, "<NumberPlateIndex>", "</NumberPlateIndex>")))
                end
                if string.find(line, "<WheelType>") then
                    vehicle.set_vehicle_wheel_type(main_ent, toint(text_func.string_cut(line, "<WheelType>", "</WheelType>")))
                end
                if string.find(line, "<WindowTint>") then
                    vehicle.set_vehicle_window_tint(main_ent, toint(text_func.string_cut(line, "<WindowTint>", "</WindowTint>")))
                end
                if string.find(line, "<BulletProofTyres>") then
                    vehicle.set_vehicle_bulletproof_tires(main_ent, tobool(text_func.string_cut(line, "<BulletProofTyres>", "</BulletProofTyres>")))
                end
                if string.find(line, "<DirtLevel>") then
                    natives.SET_VEHICLE_DIRT_LEVEL(main_ent, tonumber(text_func.string_cut(line, "<DirtLevel>", "</DirtLevel>")))
                end
                if string.find(line, "<RoofState>") then
                    if toint(text_func.string_cut(line, "<RoofState>", "</RoofState>")) == 1 then
                        natives.RAISE_CONVERTIBLE_ROOF(main_ent, true)
                    end
                end
                if string.find(line, "<SirenActive>") then
                    natives.SET_SIREN_WITH_NO_DRIVER(main_ent, tobool(text_func.string_cut(line, "<SirenActive>", "</SirenActive>")))
                    natives.SET_SIREN_KEEP_ON(main_ent, tobool(text_func.string_cut(line, "<SirenActive>", "</SirenActive>")))
                    natives.SET_VEHICLE_SIREN(main_ent, tobool(text_func.string_cut(line, "<SirenActive>", "</SirenActive>")))
                end
                if string.find(line, "<EngineOn>") then
                    vehicle.set_vehicle_engine_on(main_ent, tobool(text_func.string_cut(line, "<EngineOn>", "</EngineOn>")), true, false)
                end
                if string.find(line, "<EngineHealth>") then
                    vehicle.set_vehicle_engine_health(main_ent, tonumber(text_func.string_cut(line, "<EngineHealth>", "</EngineHealth>")))
                end
                if string.find(line, "<IsRadioLoud>") then
                    natives.SET_VEHICLE_RADIO_LOUD(main_ent, tobool(text_func.string_cut(line, "<IsRadioLoud>", "</IsRadioLoud>")))
                end
                if string.find(line, "<LockStatus>") then
                    vehicle.set_vehicle_doors_locked(main_ent, toint(text_func.string_cut(line, "<LockStatus>", "</LockStatus>")))
                end
                if string.find(line, "<Neons>") then
                    last_ent_mod = "<Neons>"
                end
                if last_ent_mod == "<Neons>" then
                    if string.find(line, "<Left>") then
                        vehicle.set_vehicle_neon_light_enabled(main_ent, 0, tobool(text_func.string_cut(line, "<Left>", "</Left>")))
                    end
                    if string.find(line, "<Right>") then
                        vehicle.set_vehicle_neon_light_enabled(main_ent, 1, tobool(text_func.string_cut(line, "<Right>", "</Right>")))
                    end
                    if string.find(line, "<Front>") then
                        vehicle.set_vehicle_neon_light_enabled(main_ent, 2, tobool(text_func.string_cut(line, "<Front>", "</Front>")))
                    end
                    if string.find(line, "<Back>") then
                        vehicle.set_vehicle_neon_light_enabled(main_ent, 3, tobool(text_func.string_cut(line, "<Back>", "</Back>")))
                    end
                    if string.find(line, "<R>") then
                        neon_light_r = toint(text_func.string_cut(line, "<R>", "</R>"))
                    end
                    if string.find(line, "<G>") then
                        neon_light_r = toint(text_func.string_cut(line, "<G>", "</G>"))
                    end
                    if string.find(line, "<B>") then
                        neon_light_r = toint(text_func.string_cut(line, "<B>", "</B>"))
                    end
                    if neon_light_r ~= nil and neon_light_g ~= nil and neon_light_b ~= nil then
                       natives.SET_VEHICLE_NEON_LIGHTS_COLOUR(main_ent, neon_light_r, neon_light_g, neon_light_b)
                    end
                end
                if string.find(line, "<ModExtras>") then
                    last_ent_mod = "<ModExtras>"
                end
                if last_ent_mod == "<ModExtras>" then
                    for i = 0, 20 do
                        if string.find(line, "<_" .. i .. ">") then
                            vehicle.set_vehicle_extra(main_ent, i, revbool(tobool(text_func.string_cut(line, "<_" .. i .. ">", "</_" .. i .. ">"))))
                        end
                    end
                end
                if string.find(line, "<Mods>") then
                    last_ent_mod = "<Mods>"
                end
                if last_ent_mod == "<Mods>" then
                    vehicle.set_vehicle_mod_kit_type(main_ent, 0)
                    for i = 0, 48 do
                        if string.find(line, "<_" .. i .. ">") then
                            if not math.type(text_func.string_cut(line, "<_" .. i .. ">", "</_" .. i .. ">")) == "boolean" then
                                vehicle.set_vehicle_mod(main_ent, i, toint(text_func.string_replace(text_func.string_cut(line, "<_" .. i .. ">", "</_" .. i .. ">"), ",", ".")), false)
                            end
                        end
                    end
                end
                if string.find(line, "<DoorsOpen>") then
                    last_ent_mod = "<DoorsOpen>"
                end
                if last_ent_mod == "<DoorsOpen>" then
                    if string.find(line, "<BackLeftDoor>") then
                        if tobool(text_func.string_cut(line, "<BackLeftDoor>", "</BackLeftDoor>")) then
                            vehicle.set_vehicle_door_open(main_ent, 0, false, true)
                        end
                    end
                    if string.find(line, "<BackRightDoor>") then
                        if tobool(text_func.string_cut(line, "<BackRightDoor>", "</BackRightDoor>")) then
                            vehicle.set_vehicle_door_open(main_ent, 1, false, true)
                        end
                    end
                    if string.find(line, "<FrontLeftDoor>") then
                        if tobool(text_func.string_cut(line, "<FrontLeftDoor>", "</FrontLeftDoor>")) then
                            vehicle.set_vehicle_door_open(main_ent, 2, false, true)
                        end
                    end
                    if string.find(line, "<FrontRightDoor>") then
                        if tobool(text_func.string_cut(line, "<FrontRightDoor>", "</FrontRightDoor>")) then
                            vehicle.set_vehicle_door_open(main_ent, 3, false, true)
                        end
                    end
                    if string.find(line, "<Hood>") then
                        if tobool(text_func.string_cut(line, "<Hood>", "</Hood>")) then
                            vehicle.set_vehicle_door_open(main_ent, 4, false, true)
                        end
                    end
                    if string.find(line, "<Trunk>") then
                        if tobool(text_func.string_cut(line, "<Trunk>", "</Trunk>")) then
                            vehicle.set_vehicle_door_open(main_ent, 5, false, true)
                        end
                    end
                    if string.find(line, "<Trunk2>") then
                        if tobool(text_func.string_cut(line, "<Trunk2>", "</Trunk2>")) then
                            vehicle.set_vehicle_door_open(main_ent, 6, false, true)
                        end
                    end
                end
                if string.find(line, "<DoorsBroken>") then
                    last_ent_mod = "<DoorsBroken>"
                end
                if last_ent_mod == "<DoorsBroken>" then
                    if string.find(line, "<BackLeftDoor>") then
                        if tobool(text_func.string_cut(line, "<BackLeftDoor>", "</BackLeftDoor>")) then
                            natives.SET_VEHICLE_DOOR_BROKEN(main_ent, 0, true)
                        end
                    end
                    if string.find(line, "<BackRightDoor>") then
                        if tobool(text_func.string_cut(line, "<BackRightDoor>", "</BackRightDoor>")) then
                            natives.SET_VEHICLE_DOOR_BROKEN(main_ent, 1, true)
                        end
                    end
                    if string.find(line, "<FrontLeftDoor>") then
                        if tobool(text_func.string_cut(line, "<FrontLeftDoor>", "</FrontLeftDoor>")) then
                            natives.SET_VEHICLE_DOOR_BROKEN(main_ent, 2, true)
                        end
                    end
                    if string.find(line, "<FrontRightDoor>") then
                        if tobool(text_func.string_cut(line, "<FrontRightDoor>", "</FrontRightDoor>")) then
                            natives.SET_VEHICLE_DOOR_BROKEN(main_ent, 3, true)
                        end
                    end
                    if string.find(line, "<Hood>") then
                        if tobool(text_func.string_cut(line, "<Hood>", "</Hood>")) then
                            natives.SET_VEHICLE_DOOR_BROKEN(main_ent, 4, true)
                        end
                    end
                    if string.find(line, "<Trunk>") then
                        if tobool(text_func.string_cut(line, "<Trunk>", "</Trunk>")) then
                            natives.SET_VEHICLE_DOOR_BROKEN(main_ent, 5, true)
                        end
                    end
                    if string.find(line, "<Trunk2>") then
                        if tobool(text_func.string_cut(line, "<Trunk2>", "</Trunk2>")) then
                            natives.SET_VEHICLE_DOOR_BROKEN(main_ent, 6, true)
                        end
                    end
                end
                if string.find(line, "<TyresBursted>") then
                    last_ent_mod = "<TyresBursted>"
                end
                if last_ent_mod == "<TyresBursted>" then
                    if string.find(line, "<FrontLeft>") then
                        if tobool(text_func.string_cut(line, "<FrontLeft>", "</FrontLeft>")) then
                            vehicle.set_vehicle_tire_burst(main_ent, 0, true, 1000)
                        end
                    end
                    if string.find(line, "<FrontRight>") then
                        if tobool(text_func.string_cut(line, "<FrontRight>", "</FrontRight>")) then
                            vehicle.set_vehicle_tire_burst(main_ent, 1, true, 1000)
                        end
                    end
                    if string.find(line, "<_2>") then
                        if tobool(text_func.string_cut(line, "<_2>", "</_2>")) then
                            vehicle.set_vehicle_tire_burst(main_ent, 2, true, 1000)
                        end
                    end
                    if string.find(line, "<_3>") then
                        if tobool(text_func.string_cut(line, "<_3>", "</_3>")) then
                            vehicle.set_vehicle_tire_burst(main_ent, 3, true, 1000)
                        end
                    end
                    if string.find(line, "<BackLeft>") then
                        if tobool(text_func.string_cut(line, "<BackLeft>", "</BackLeft>")) then
                            vehicle.set_vehicle_tire_burst(main_ent, 4, true, 1000)
                        end
                    end
                    if string.find(line, "<BackRight>") then
                        if tobool(text_func.string_cut(line, "<BackRight>", "</BackRight>")) then
                            vehicle.set_vehicle_tire_burst(main_ent, 5, true, 1000)
                        end
                    end
                    if string.find(line, "<_6>") then
                        if tobool(text_func.string_cut(line, "<_6>", "</_6>")) then
                            vehicle.set_vehicle_tire_burst(main_ent, 6, true, 1000)
                        end
                    end
                    if string.find(line, "<_7>") then
                        if tobool(text_func.string_cut(line, "<_7>", "</_7>")) then
                            vehicle.set_vehicle_tire_burst(main_ent, 7, true, 1000)
                        end
                    end
                    if string.find(line, "<_8>") then
                        if tobool(text_func.string_cut(line, "<_8>", "</_8>")) then
                            vehicle.set_vehicle_tire_burst(main_ent, 8, true, 1000)
                        end
                    end
                end
                if string.find(line, "<RpmMultiplier>") then
                    if tonumber(text_func.string_cut(line, "<RpmMultiplier>", "</RpmMultiplier>")) ~= 1.0 and tonumber(text_func.string_cut(line, "<RpmMultiplier>", "</RpmMultiplier>")) ~= 1 then
                        vehicle.modify_vehicle_top_speed(main_ent, tonumber(text_func.string_cut(line, "<RpmMultiplier>", "</RpmMultiplier>")) * 100)
                        entity.set_entity_max_speed(main_ent, 540 * tonumber(text_func.string_cut(line, "<RpmMultiplier>", "</RpmMultiplier>")))
                    end
                end
                if string.find(line, "<TorqueMultiplier>") then
                    if tonumber(text_func.string_cut(line, "<TorqueMultiplier>", "</TorqueMultiplier>")) ~= 1.0 and tonumber(text_func.string_cut(line, "<TorqueMultiplier>", "</TorqueMultiplier>")) ~= 1 then
                        local real_thread = menu.create_thread(function()
                            local torque = tonumber(text_func.string_cut(line, "<TorqueMultiplier>", "</TorqueMultiplier>"))
                            while entity.is_an_entity(main_ent) and player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(main_ent, -1)) == player.player_id() and not entity.is_entity_dead(main_ent) do
                                vehicle.set_vehicle_engine_torque_multiplier_this_frame(main_ent, torque)
                                system.yield(0)
                            end
                        end, nil)
                    end
                end
                if string.find(line, "<MaxSpeed>") then
                    entity.set_entity_max_speed(main_ent, tonumber(text_func.string_cut(line, "<MaxSpeed>", "</MaxSpeed>")))
                end
                if string.find(line, "<OpacityLevel>") then
                    entity.set_entity_alpha(main_ent, toint(text_func.string_cut(line, "<OpacityLevel>", "</OpacityLevel>")), true)
                end
                if string.find(line, "<LodDistance>") then
                    natives.SET_ENTITY_LOD_DIST(main_ent, toint(text_func.string_cut(line, "<LodDistance>", "</LodDistance>")))
                end
                if string.find(line, "<IsVisible>") then
                    entity.set_entity_visible(main_ent, tobool(text_func.string_cut(line, "<IsVisible>", "</IsVisible>")))
                end
                if string.find(line, "<MaxHealth>") then
                    natives.SET_ENTITY_MAX_HEALTH(main_ent, toint(text_func.string_cut(line, "<MaxHealth>", "</MaxHealth>")))
                end
                if string.find(line, "<Health>") then
                    natives.SET_ENTITY_HEALTH(main_ent, toint(text_func.string_cut(line, "<Health>", "</Health>")), 2)
                end
                if string.find(line, "<HasGravity>") then
                    natives.SET_ENTITY_HAS_GRAVITY(main_ent, tobool(text_func.string_cut(line, "<HasGravity>", "</HasGravity>")))
                end
                if string.find(line, "<IsOnFire>") then
                    if tobool(text_func.string_cut(line, "<IsOnFire>", "</IsOnFire>")) then
                        natives.START_ENTITY_FIRE(main_ent)
                    end
                end
                if string.find(line, "<IsInvincible>") then
                    entity.set_entity_god_mode(main_ent, tobool(text_func.string_cut(line, "<IsInvincible>", "</IsInvincible>")))
                    natives.SET_ENTITY_INVINCIBLE(main_ent, tobool(text_func.string_cut(line, "<IsInvincible>", "</IsInvincible>")))
                end
                if string.find(line, "<IsBulletProof>") then
                    bullet_proof = tobool(text_func.string_cut(line, "<IsBulletProof>", "</IsBulletProof>"))
                end
                if string.find(line, "<IsCollisionProof>") then
                    collision_proof = tobool(text_func.string_cut(line, "<IsCollisionProof>", "</IsCollisionProof>"))
                end
                if string.find(line, "<IsExplosionProof>") then
                    explosion_proof = tobool(text_func.string_cut(line, "<IsExplosionProof>", "</IsExplosionProof>"))
                end
                if string.find(line, "<IsFireProof>") then
                    fire_proof = tobool(text_func.string_cut(line, "<IsFireProof>", "</IsFireProof>"))
                end
                if string.find(line, "<IsMeleeProof>") then
                    melee_proof = tobool(text_func.string_cut(line, "<IsMeleeProof>", "</IsMeleeProof>"))
                end
                natives.SET_ENTITY_PROOFS(main_ent, bullet_proof, fire_proof, explosion_proof, collision_proof, melee_proof, true, 1, false)
                if string.find(line, "<IsOnlyDamagedByPlayer>") then
                    natives.SET_ENTITY_ONLY_DAMAGED_BY_PLAYER(main_ent, tobool(text_func.string_cut(line, "<IsOnlyDamagedByPlayer>", "</IsOnlyDamagedByPlayer>")))
                end
            end
            if string.find(line, "<SpoonerAttachments") then
                apply_props = false
                is_main_vehicle = false
            end
        end
        if not is_main_vehicle then
            if string.find(line, "<Attachment>") then
                new_ent_attachment = true
                new_sub_ent_attachment = false
            end
            if new_ent_attachment then
                if string.find(line, "<ModelHash>") then
                    local model_hash = text_func.string_cut(line, "<ModelHash>", "</ModelHash>")
                    if streaming.is_model_valid(model_hash) then
                        last_ent_hash = model_hash
                    else
                        return
                    end
                end
                if string.find(line, "<Type>") then
                    last_ent_type = toint(text_func.string_cut(line, "<Type>", "</Type>"))
                end
                if (last_ent_type == 1 or last_ent_type == "1") and (streaming.is_model_a_ped(last_ent_hash)) then
                    if string.find(line, "<FrozenPos>") then
                        last_ent_spawn_info_2 = tobool(text_func.string_cut(line, "<FrozenPos>", "</FrozenPos>"))
                    end
                    if string.find(line, "<InitialHandle>") then
                        local ent_handle = text_func.string_cut(line, "<InitialHandle>", "</InitialHandle>")
                        last_ent_handle = ent_handle
                        all_entity_handles[#all_entity_handles + 1] = ent_handle
                        utilities.request_model(last_ent_hash)
                        all_entities["" .. last_ent_handle .. ""] = ped.create_ped(0, last_ent_hash, v3_pos, 0, true, false)
                        network.request_control_of_entity(all_entities["" .. last_ent_handle .. ""])
                    end
                    entity.freeze_entity(all_entities["" .. last_ent_handle .. ""], last_ent_spawn_info_2)
                    if string.find(line, "<TaskSequence>") then
                        last_ent_mod = "<TaskSequence>"
                    end
                    if last_ent_mod == "<TaskSequence>" then
                        if string.find(line, "<Duration>") then
                            task_dur = toint(text_func.string_cut(line, "<Duration>", "</Duration>"))
                        end
                        if string.find(line, "<KeepTaskRunningAfterTime>") then
                            task_keep_running = tobool(text_func.string_cut(line, "<KeepTaskRunningAfterTime>", "</KeepTaskRunningAfterTime>"))
                        end
                        if string.find(line, "<IsLoopedTask>") then
                            task_looped = tobool(text_func.string_cut(line, "<IsLoopedTask>", "</IsLoopedTask>"))
                        end
                        if string.find(line, "<AnimDict>") then
                            task_dict = text_func.string_cut(line, "<AnimDict>", "</AnimDict>")
                        end
                        if string.find(line, "<AnimName>") then
                            task_name = toint(text_func.string_cut(line, "<AnimName>", "</AnimName>"))
                        end
                        if string.find(line, "<Speed>") then
                            task_speed = tonumber(text_func.string_cut(line, "<Speed>", "</Speed>"))
                        end
                        if string.find(line, "<SpeedMultiplier>") then
                            task_speed_mult = tonumber(text_func.string_cut(line, "<SpeedMultiplier>", "</SpeedMultiplier>"))
                        end
                        if string.find(line, "<Flag>") then
                            task_flag = toint(text_func.string_cut(line, "<Flag>", "</Flag>"))
                        end
                        if string.find(line, "<LockPos>") then
                            task_lock_pos = tobool(text_func.string_cut(line, "<LockPos>", "</LockPos>"))
                        end
                        if string.find(line, "<OverrideDurationToNormalSpeedAnimDuration>") then
                            task_override_dur = tobool(text_func.string_cut(line, "<OverrideDurationToNormalSpeedAnimDuration>", "</OverrideDurationToNormalSpeedAnimDuration>"))
                        end
                        if task_dur ~= nil and task_keep_running ~= nil and task_looped ~= nil and task_dict ~= nil and task_name ~= nil and task_speed ~= nil and task_speed_mult ~= nil and task_flag ~= nil and task_lock_pos ~= nil and task_override_dur then
                            streaming.request_anim_dict(task_dict)
                            streaming.request_anim_set(task_name)
                            while not streaming.has_anim_dict_loaded(task_dict) do
                                system.yield(0)
                                streaming.request_anim_dict(task_dict)
                                streaming.request_anim_set(task_name)
                            end
                            ai.task_play_anim(all_entities["" .. last_ent_handle .. ""], task_dict, task_name, task_speed, task_speed_mult, task_dur, task_flag, 0.0, task_lock_pos, task_lock_pos, task_lock_pos)
                        end
                    end
                    if string.find(line, "<IsStill>") then
                        if tobool(text_func.string_cut(line, "<IsStill>", "</IsStill>")) then
                            natives.TASK_STAND_STILL(all_entities["" .. last_ent_handle .. ""], 2147483647)
                        end
                    end
                    if string.find(line, "<CanRagdoll>") then
                        ped.set_ped_can_ragdoll(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<CanRagdoll>", "</CanRagdoll>")))
                    end
                    if string.find(line, "<CurrentWeapon>") then
                        weapon.give_delayed_weapon_to_ped(all_entities["" .. last_ent_handle .. ""], text_func.string_cut(line, "<CurrentWeapon>", "</CurrentWeapon>"), 0, true)
                    end
                    if string.find(line, "<PedProps>") then
                        last_ent_mod = "<PedProps>"
                    end
                    if last_ent_mod == "<PedProps>" then
                        for i = 0, 9 do
                            if string.find(line, "<_" .. i .. ">") then
                                local parts = text_func.split_string(text_func.string_cut(line, "<_" .. i .. ">", "</_" .. i .. ">"), ",")
                                ped.set_ped_prop_index(all_entities["" .. last_ent_handle .. ""], i, toint(parts[1]), toint(parts[2]), 0)
                            end
                        end
                    end
                    if string.find(line, "<PedComps>") then
                        last_ent_mod = "<PedComps>"
                    end
                    if last_ent_mod == "<PedComps>" then
                        for i = 0, 11 do
                            if string.find(line, "<_" .. i .. ">") then
                                local parts = text_func.split_string(text_func.string_cut(line, "<_" .. i .. ">", "</_" .. i .. ">"), ",")
                                ped.set_ped_component_variation(all_entities["" .. last_ent_handle .. ""], i, toint(parts[1]), toint(parts[2]), 0)
                            end
                        end
                    end
                    if string.find(line, "<RelationshipGroup>") then
                        ped.set_ped_relationship_group_hash(all_entities["" .. last_ent_handle .. ""], text_func.string_cut(line, "<RelationshipGroup>", "</RelationshipGroup>"))
                    end
                    if string.find(line, "<OpacityLevel>") then
                        entity.set_entity_alpha(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<OpacityLevel>", "</OpacityLevel>")), true)
                    end
                    if string.find(line, "<LodDistance>") then
                        natives.SET_ENTITY_LOD_DIST(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<LodDistance>", "</LodDistance>")))
                    end
                    if string.find(line, "<IsVisible>") then
                        entity.set_entity_visible(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsVisible>", "</IsVisible>")))
                    end
                    if string.find(line, "<MaxHealth>") then
                        natives.SET_ENTITY_MAX_HEALTH(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<MaxHealth>", "</MaxHealth>")))
                    end
                    if string.find(line, "<Health>") then
                        natives.SET_ENTITY_HEALTH(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<Health>", "</Health>")), 2)
                    end
                    if string.find(line, "<HasGravity>") then
                        natives.SET_ENTITY_HAS_GRAVITY(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<HasGravity>", "</HasGravity>")))
                    end
                    if string.find(line, "<IsOnFire>") then
                        if tobool(text_func.string_cut(line, "<IsOnFire>", "</IsOnFire>")) then
                            natives.START_ENTITY_FIRE(all_entities["" .. last_ent_handle .. ""])
                        end
                    end
                    if string.find(line, "<IsInvincible>") then
                        entity.set_entity_god_mode(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsInvincible>", "</IsInvincible>")))
                        natives.SET_ENTITY_INVINCIBLE(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsInvincible>", "</IsInvincible>")))
                    end
                    if string.find(line, "<IsBulletProof>") then
                        bullet_proof = tobool(text_func.string_cut(line, "<IsBulletProof>", "</IsBulletProof>"))
                    end
                    if string.find(line, "<IsCollisionProof>") then
                        collision_proof = tobool(text_func.string_cut(line, "<IsCollisionProof>", "</IsCollisionProof>"))
                    end
                    if string.find(line, "<IsExplosionProof>") then
                        explosion_proof = tobool(text_func.string_cut(line, "<IsExplosionProof>", "</IsExplosionProof>"))
                    end
                    if string.find(line, "<IsFireProof>") then
                        fire_proof = tobool(text_func.string_cut(line, "<IsFireProof>", "</IsFireProof>"))
                    end
                    if string.find(line, "<IsMeleeProof>") then
                        melee_proof = tobool(text_func.string_cut(line, "<IsMeleeProof>", "</IsMeleeProof>"))
                    end
                    natives.SET_ENTITY_PROOFS(all_entities["" .. last_ent_handle .. ""], bullet_proof, fire_proof, explosion_proof, collision_proof, melee_proof, true, 1, false)
                    if string.find(line, "<IsOnlyDamagedByPlayer>") then
                        natives.SET_ENTITY_ONLY_DAMAGED_BY_PLAYER(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsOnlyDamagedByPlayer>", "</IsOnlyDamagedByPlayer>")))
                    end
                    if string.find(line, "<Attachment isAttached=") then
                        new_sub_ent_attachment = true
                    end
                    if new_sub_ent_attachment then
                        if string.find(line, "<AttachedTo>") then
                            attach_handler = toint(text_func.string_cut(line, "<AttachedTo>", "</AttachedTo>"))
                        end
                        if string.find(line, "<BoneIndex>") then
                            attach_bone = toint(text_func.string_cut(line, "<BoneIndex>", "</BoneIndex>"))
                        end
                        if string.find(line, "<X>") then
                            if not attach_x_index then
                                attach_x = tonumber(text_func.string_cut(line, "<X>", "</X>"))
                                attach_x_index = true
                            end
                        end
                        if string.find(line, "<Y>") then
                            if not attach_y_index then
                                attach_y = tonumber(text_func.string_cut(line, "<Y>", "</Y>"))
                                attach_y_index = true
                            end
                        end
                        if string.find(line, "<Z>") then
                            if not attach_z_index then
                                attach_z = tonumber(text_func.string_cut(line, "<Z>", "</Z>"))
                                attach_z_index = true
                            end
                        end
                        if string.find(line, "<Pitch>") then
                            if not attach_rot_p_index then
                                attach_rot_p = tonumber(text_func.string_cut(line, "<Pitch>", "</Pitch>"))
                                attach_rot_p_index = true
                            end
                        end
                        if string.find(line, "<Roll>") then
                            if not attach_rot_r_index then
                                attach_rot_r = tonumber(text_func.string_cut(line, "<Roll>", "</Roll>"))
                                attach_rot_r_index = true
                            end
                        end
                        if string.find(line, "<Yaw>") then
                            if not attach_rot_y_index then
                                attach_rot_y = tonumber(text_func.string_cut(line, "<Yaw>", "</Yaw>"))
                                attach_rot_y_index = true
                            end
                        end
                        if attach_x_index and attach_y_index and attach_z_index and attach_rot_p_index and attach_rot_r_index and attach_rot_y_index then
                            if all_entities["" .. attach_handler .. ""] == nil then
                                entity.attach_entity_to_entity(all_entities["" .. last_ent_handle .. ""], main_ent, attach_bone, v3(attach_x, attach_y, attach_z), v3(attach_rot_p, attach_rot_r, attach_rot_y), false, true, entity.is_entity_a_ped(main_ent), 2, true)
                                natives.PROCESS_ENTITY_ATTACHMENTS(main_ent)
                            else
                                entity.attach_entity_to_entity(all_entities["" .. last_ent_handle .. ""], all_entities["" .. attach_handler .. ""], attach_bone, v3(attach_x, attach_y, attach_z), v3(attach_rot_p, attach_rot_r, attach_rot_y), false, true, entity.is_entity_a_ped(all_entities["" .. attach_handler .. ""]), 2, true)
                                natives.PROCESS_ENTITY_ATTACHMENTS(all_entities["" .. attach_handler .. ""])
                            end
                            attach_x_index = false
                            attach_y_index = false
                            attach_z_index = false
                            attach_rot_p_index = false
                            attach_rot_r_index = false
                            attach_rot_y_index = false
                            new_sub_ent_attachment = false
                        end
                        if string.find(line, "</Attachment>") then
                            attach_x_index = false
                            attach_y_index = false
                            attach_z_index = false
                            attach_rot_p_index = false
                            attach_rot_r_index = false
                            attach_rot_y_index = false
                            new_sub_ent_attachment = false
                        end
                    end
                elseif (last_ent_type == 2 or last_ent_type == "2") and streaming.is_model_a_vehicle(last_ent_hash) then
                    if string.find(line, "<Dynamic>") then
                        last_ent_spawn_info_1 = tobool(text_func.string_cut(line, "<Dynamic>", "</Dynamic>"))
                    end
                    if string.find(line, "<InitialHandle>") then
                        local ent_handle = text_func.string_cut(line, "<InitialHandle>", "</InitialHandle>")
                        last_ent_handle = ent_handle
                        all_entity_handles[#all_entity_handles + 1] = ent_handle
                        utilities.request_model(last_ent_hash)
                        all_entities["" .. last_ent_handle .. ""] = vehicle.create_vehicle(last_ent_hash, v3_pos, 0, true, false)
                        network.request_control_of_entity(all_entities["" .. last_ent_handle .. ""])
                    end
                    entity.freeze_entity(all_entities["" .. last_ent_handle .. ""], last_ent_spawn_info_1)
                    if string.find(line, "<Colours>") then
                        last_ent_mod = "<Colours>"
                    end
                    if last_ent_mod == "<Colours>" then
                        if string.find(line, "<Primary>") then
                            color_prim = toint(text_func.string_cut(line, "<Primary>", "</Primary>"))
                        end
                        if string.find(line, "<Secondary>") then
                            color_sec = toint(text_func.string_cut(line, "<Secondary>", "</Secondary>"))
                        end
                        if color_prim ~= nil and color_sec ~= nil then
                            vehicle.set_vehicle_colors(all_entities["" .. last_ent_handle .. ""], color_prim, color_sec)
                        end
                        if string.find(line, "<Pearl>") then
                            vehicle.set_vehicle_custom_pearlescent_colour(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<Pearl>", "</Pearl>")))
                        end
                        if string.find(line, "<tyreSmoke_R>") then
                            wheel_smoke_r = toint(text_func.string_cut(line, "<tyreSmoke_R>", "</tyreSmoke_R>"))
                        end
                        if string.find(line, "<tyreSmoke_G>") then
                            wheel_smoke_g = toint(text_func.string_cut(line, "<tyreSmoke_G>", "</tyreSmoke_G>"))
                        end
                        if string.find(line, "<tyreSmoke_B>") then
                            wheel_smoke_b = toint(text_func.string_cut(line, "<tyreSmoke_B>", "</tyreSmoke_B>"))
                        end
                        if wheel_smoke_r ~= nil and wheel_smoke_g ~= nil and wheel_smoke_b ~= nil then
                            vehicle.set_vehicle_tire_smoke_color(all_entities["" .. last_ent_handle .. ""], wheel_smoke_r, wheel_smoke_g, wheel_smoke_b)
                        end
                        if string.find(line, "<LrInterior>") then
                            natives.SET_VEHICLE_INTERIOR_COLOR(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<LrInterior>", "</LrInterior>")))
                        end
                        if string.find(line, "<LrDashboard>") then
                            natives.SET_VEHICLE_DASHBOARD_COLOR(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<LrDashboard>", "</LrDashboard>")))
                        end
                    end
                    if string.find(line, "<Livery>") then
                        natives.SET_VEHICLE_LIVERY(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<Livery>", "</Livery>")))
                    end
                    if string.find(line, "<NumberPlateText>") then
                        vehicle.set_vehicle_number_plate_text(all_entities["" .. last_ent_handle .. ""], text_func.string_cut(line, "<NumberPlateText>", "</NumberPlateText>"))
                    end
                    if string.find(line, "<NumberPlateIndex>") then
                        vehicle.set_vehicle_number_plate_index(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<NumberPlateIndex>", "</NumberPlateIndex>")))
                    end
                    if string.find(line, "<WheelType>") then
                        vehicle.set_vehicle_wheel_type(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<WheelType>", "</WheelType>")))
                    end
                    if string.find(line, "<WindowTint>") then
                        vehicle.set_vehicle_window_tint(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<WindowTint>", "</WindowTint>")))
                    end
                    if string.find(line, "<BulletProofTyres>") then
                        vehicle.set_vehicle_bulletproof_tires(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<BulletProofTyres>", "</BulletProofTyres>")))
                    end
                    if string.find(line, "<DirtLevel>") then
                        natives.SET_VEHICLE_DIRT_LEVEL(all_entities["" .. last_ent_handle .. ""], tonumber(text_func.string_cut(line, "<DirtLevel>", "</DirtLevel>")))
                    end
                    if string.find(line, "<RoofState>") then
                        if toint(text_func.string_cut(line, "<RoofState>", "</RoofState>")) == 1 then
                            natives.RAISE_CONVERTIBLE_ROOF(all_entities["" .. last_ent_handle .. ""], true)
                        end
                    end
                    if string.find(line, "<SirenActive>") then
                        natives.SET_SIREN_WITH_NO_DRIVER(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<SirenActive>", "</SirenActive>")))
                        natives.SET_SIREN_KEEP_ON(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<SirenActive>", "</SirenActive>")))
                        natives.SET_VEHICLE_SIREN(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<SirenActive>", "</SirenActive>")))
                    end
                    if string.find(line, "<EngineOn>") then
                        vehicle.set_vehicle_engine_on(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<EngineOn>", "</EngineOn>")), true, false)
                    end
                    if string.find(line, "<EngineHealth>") then
                        vehicle.set_vehicle_engine_health(all_entities["" .. last_ent_handle .. ""], tonumber(text_func.string_cut(line, "<EngineHealth>", "</EngineHealth>")))
                    end
                    if string.find(line, "<IsRadioLoud>") then
                        natives.SET_VEHICLE_RADIO_LOUD(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsRadioLoud>", "</IsRadioLoud>")))
                    end
                    if string.find(line, "<LockStatus>") then
                        vehicle.set_vehicle_doors_locked(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<LockStatus>", "</LockStatus>")))
                    end
                    if string.find(line, "<Neons>") then
                        last_ent_mod = "<Neons>"
                    end
                    if last_ent_mod == "<Neons>" then
                        if string.find(line, "<Left>") then
                            vehicle.set_vehicle_neon_light_enabled(all_entities["" .. last_ent_handle .. ""], 0, tobool(text_func.string_cut(line, "<Left>", "</Left>")))
                        end
                        if string.find(line, "<Right>") then
                            vehicle.set_vehicle_neon_light_enabled(all_entities["" .. last_ent_handle .. ""], 1, tobool(text_func.string_cut(line, "<Right>", "</Right>")))
                        end
                        if string.find(line, "<Front>") then
                            vehicle.set_vehicle_neon_light_enabled(all_entities["" .. last_ent_handle .. ""], 2, tobool(text_func.string_cut(line, "<Front>", "</Front>")))
                        end
                        if string.find(line, "<Back>") then
                            vehicle.set_vehicle_neon_light_enabled(all_entities["" .. last_ent_handle .. ""], 3, tobool(text_func.string_cut(line, "<Back>", "</Back>")))
                        end
                        if string.find(line, "<R>") then
                            neon_light_r = toint(text_func.string_cut(line, "<R>", "</R>"))
                        end
                        if string.find(line, "<G>") then
                            neon_light_r = toint(text_func.string_cut(line, "<G>", "</G>"))
                        end
                        if string.find(line, "<B>") then
                            neon_light_r = toint(text_func.string_cut(line, "<B>", "</B>"))
                        end
                        if neon_light_r ~= nil and neon_light_g ~= nil and neon_light_b ~= nil then
                           natives.SET_VEHICLE_NEON_LIGHTS_COLOUR(all_entities["" .. last_ent_handle .. ""], neon_light_r, neon_light_g, neon_light_b)
                        end
                    end
                    if string.find(line, "<ModExtras>") then
                        last_ent_mod = "<ModExtras>"
                    end
                    if last_ent_mod == "<ModExtras>" then
                        for i = 0, 20 do
                            if string.find(line, "<_" .. i .. ">") then
                                vehicle.set_vehicle_extra(all_entities["" .. last_ent_handle .. ""], i, revbool(tobool(text_func.string_cut(line, "<_" .. i .. ">", "</_" .. i .. ">"))))
                            end
                        end
                    end
                    if string.find(line, "<Mods>") then
                        last_ent_mod = "<Mods>"
                    end
                    if last_ent_mod == "<Mods>" then
                        vehicle.set_vehicle_mod_kit_type(all_entities["" .. last_ent_handle .. ""], 0)
                        for i = 0, 48 do
                            if string.find(line, "<_" .. i .. ">") then
                                if not math.type(text_func.string_cut(line, "<_" .. i .. ">", "</_" .. i .. ">")) == "boolean" then
                                    vehicle.set_vehicle_mod(all_entities["" .. last_ent_handle .. ""], i, toint(text_func.string_replace(text_func.string_cut(line, "<_" .. i .. ">", "</_" .. i .. ">"), ",", ".")), false)
                                end
                            end
                        end
                    end
                    if string.find(line, "<DoorsOpen>") then
                        last_ent_mod = "<DoorsOpen>"
                    end
                    if last_ent_mod == "<DoorsOpen>" then
                        if string.find(line, "<BackLeftDoor>") then
                            if tobool(text_func.string_cut(line, "<BackLeftDoor>", "</BackLeftDoor>")) then
                                vehicle.set_vehicle_door_open(all_entities["" .. last_ent_handle .. ""], 0, false, true)
                            end
                        end
                        if string.find(line, "<BackRightDoor>") then
                            if tobool(text_func.string_cut(line, "<BackRightDoor>", "</BackRightDoor>")) then
                                vehicle.set_vehicle_door_open(all_entities["" .. last_ent_handle .. ""], 1, false, true)
                            end
                        end
                        if string.find(line, "<FrontLeftDoor>") then
                            if tobool(text_func.string_cut(line, "<FrontLeftDoor>", "</FrontLeftDoor>")) then
                                vehicle.set_vehicle_door_open(all_entities["" .. last_ent_handle .. ""], 2, false, true)
                            end
                        end
                        if string.find(line, "<FrontRightDoor>") then
                            if tobool(text_func.string_cut(line, "<FrontRightDoor>", "</FrontRightDoor>")) then
                                vehicle.set_vehicle_door_open(all_entities["" .. last_ent_handle .. ""], 3, false, true)
                            end
                        end
                        if string.find(line, "<Hood>") then
                            if tobool(text_func.string_cut(line, "<Hood>", "</Hood>")) then
                                vehicle.set_vehicle_door_open(all_entities["" .. last_ent_handle .. ""], 4, false, true)
                            end
                        end
                        if string.find(line, "<Trunk>") then
                            if tobool(text_func.string_cut(line, "<Trunk>", "</Trunk>")) then
                                vehicle.set_vehicle_door_open(all_entities["" .. last_ent_handle .. ""], 5, false, true)
                            end
                        end
                        if string.find(line, "<Trunk2>") then
                            if tobool(text_func.string_cut(line, "<Trunk2>", "</Trunk2>")) then
                                vehicle.set_vehicle_door_open(all_entities["" .. last_ent_handle .. ""], 6, false, true)
                            end
                        end
                    end
                    if string.find(line, "<DoorsBroken>") then
                        last_ent_mod = "<DoorsBroken>"
                    end
                    if last_ent_mod == "<DoorsBroken>" then
                        if string.find(line, "<BackLeftDoor>") then
                            if tobool(text_func.string_cut(line, "<BackLeftDoor>", "</BackLeftDoor>")) then
                                natives.SET_VEHICLE_DOOR_BROKEN(all_entities["" .. last_ent_handle .. ""], 0, true)
                            end
                        end
                        if string.find(line, "<BackRightDoor>") then
                            if tobool(text_func.string_cut(line, "<BackRightDoor>", "</BackRightDoor>")) then
                                natives.SET_VEHICLE_DOOR_BROKEN(all_entities["" .. last_ent_handle .. ""], 1, true)
                            end
                        end
                        if string.find(line, "<FrontLeftDoor>") then
                            if tobool(text_func.string_cut(line, "<FrontLeftDoor>", "</FrontLeftDoor>")) then
                                natives.SET_VEHICLE_DOOR_BROKEN(all_entities["" .. last_ent_handle .. ""], 2, true)
                            end
                        end
                        if string.find(line, "<FrontRightDoor>") then
                            if tobool(text_func.string_cut(line, "<FrontRightDoor>", "</FrontRightDoor>")) then
                                natives.SET_VEHICLE_DOOR_BROKEN(all_entities["" .. last_ent_handle .. ""], 3, true)
                            end
                        end
                        if string.find(line, "<Hood>") then
                            if tobool(text_func.string_cut(line, "<Hood>", "</Hood>")) then
                                natives.SET_VEHICLE_DOOR_BROKEN(all_entities["" .. last_ent_handle .. ""], 4, true)
                            end
                        end
                        if string.find(line, "<Trunk>") then
                            if tobool(text_func.string_cut(line, "<Trunk>", "</Trunk>")) then
                                natives.SET_VEHICLE_DOOR_BROKEN(all_entities["" .. last_ent_handle .. ""], 5, true)
                            end
                        end
                        if string.find(line, "<Trunk2>") then
                            if tobool(text_func.string_cut(line, "<Trunk2>", "</Trunk2>")) then
                                natives.SET_VEHICLE_DOOR_BROKEN(all_entities["" .. last_ent_handle .. ""], 6, true)
                            end
                        end
                    end
                    if string.find(line, "<TyresBursted>") then
                        last_ent_mod = "<TyresBursted>"
                    end
                    if last_ent_mod == "<TyresBursted>" then
                        if string.find(line, "<FrontLeft>") then
                            if tobool(text_func.string_cut(line, "<FrontLeft>", "</FrontLeft>")) then
                                vehicle.set_vehicle_tire_burst(all_entities["" .. last_ent_handle .. ""], 0, true, 1000)
                            end
                        end
                        if string.find(line, "<FrontRight>") then
                            if tobool(text_func.string_cut(line, "<FrontRight>", "</FrontRight>")) then
                                vehicle.set_vehicle_tire_burst(all_entities["" .. last_ent_handle .. ""], 1, true, 1000)
                            end
                        end
                        if string.find(line, "<_2>") then
                            if tobool(text_func.string_cut(line, "<_2>", "</_2>")) then
                                vehicle.set_vehicle_tire_burst(all_entities["" .. last_ent_handle .. ""], 2, true, 1000)
                            end
                        end
                        if string.find(line, "<_3>") then
                            if tobool(text_func.string_cut(line, "<_3>", "</_3>")) then
                                vehicle.set_vehicle_tire_burst(all_entities["" .. last_ent_handle .. ""], 3, true, 1000)
                            end
                        end
                        if string.find(line, "<BackLeft>") then
                            if tobool(text_func.string_cut(line, "<BackLeft>", "</BackLeft>")) then
                                vehicle.set_vehicle_tire_burst(all_entities["" .. last_ent_handle .. ""], 4, true, 1000)
                            end
                        end
                        if string.find(line, "<BackRight>") then
                            if tobool(text_func.string_cut(line, "<BackRight>", "</BackRight>")) then
                                vehicle.set_vehicle_tire_burst(all_entities["" .. last_ent_handle .. ""], 5, true, 1000)
                            end
                        end
                        if string.find(line, "<_6>") then
                            if tobool(text_func.string_cut(line, "<_6>", "</_6>")) then
                                vehicle.set_vehicle_tire_burst(all_entities["" .. last_ent_handle .. ""], 6, true, 1000)
                            end
                        end
                        if string.find(line, "<_7>") then
                            if tobool(text_func.string_cut(line, "<_7>", "</_7>")) then
                                vehicle.set_vehicle_tire_burst(all_entities["" .. last_ent_handle .. ""], 7, true, 1000)
                            end
                        end
                        if string.find(line, "<_8>") then
                            if tobool(text_func.string_cut(line, "<_8>", "</_8>")) then
                                vehicle.set_vehicle_tire_burst(all_entities["" .. last_ent_handle .. ""], 8, true, 1000)
                            end
                        end
                    end
                    if string.find(line, "<RpmMultiplier>") then
                        if tonumber(text_func.string_cut(line, "<RpmMultiplier>", "</RpmMultiplier>")) ~= 1.0 and tonumber(text_func.string_cut(line, "<RpmMultiplier>", "</RpmMultiplier>")) ~= 1 then
                            vehicle.modify_vehicle_top_speed(all_entities["" .. last_ent_handle .. ""], tonumber(text_func.string_cut(line, "<RpmMultiplier>", "</RpmMultiplier>")) * 100)
                            entity.set_entity_max_speed(all_entities["" .. last_ent_handle .. ""], 540 * tonumber(text_func.string_cut(line, "<RpmMultiplier>", "</RpmMultiplier>")))
                        end
                    end
                    if string.find(line, "<TorqueMultiplier>") then
                        if tonumber(text_func.string_cut(line, "<TorqueMultiplier>", "</TorqueMultiplier>")) ~= 1.0 and tonumber(text_func.string_cut(line, "<TorqueMultiplier>", "</TorqueMultiplier>")) ~= 1 then
                            local real_thread = menu.create_thread(function()
                                local torque = tonumber(text_func.string_cut(line, "<TorqueMultiplier>", "</TorqueMultiplier>"))
                                while entity.is_an_entity(all_entities["" .. last_ent_handle .. ""]) and player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(all_entities["" .. last_ent_handle .. ""], -1)) == player.player_id() and not entity.is_entity_dead(all_entities["" .. last_ent_handle .. ""]) do
                                    vehicle.set_vehicle_engine_torque_multiplier_this_frame(all_entities["" .. last_ent_handle .. ""], torque)
                                    system.yield(0)
                                end
                            end, nil)
                        end
                    end
                    if string.find(line, "<MaxSpeed>") then
                        entity.set_entity_max_speed(all_entities["" .. last_ent_handle .. ""], tonumber(text_func.string_cut(line, "<MaxSpeed>", "</MaxSpeed>")))
                    end
                    if string.find(line, "<OpacityLevel>") then
                        entity.set_entity_alpha(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<OpacityLevel>", "</OpacityLevel>")), true)
                    end
                    if string.find(line, "<LodDistance>") then
                        natives.SET_ENTITY_LOD_DIST(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<LodDistance>", "</LodDistance>")))
                    end
                    if string.find(line, "<IsVisible>") then
                        entity.set_entity_visible(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsVisible>", "</IsVisible>")))
                    end
                    if string.find(line, "<MaxHealth>") then
                        natives.SET_ENTITY_MAX_HEALTH(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<MaxHealth>", "</MaxHealth>")))
                    end
                    if string.find(line, "<Health>") then
                        natives.SET_ENTITY_HEALTH(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<Health>", "</Health>")), 2)
                    end
                    if string.find(line, "<HasGravity>") then
                        natives.SET_ENTITY_HAS_GRAVITY(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<HasGravity>", "</HasGravity>")))
                    end
                    if string.find(line, "<IsOnFire>") then
                        if tobool(text_func.string_cut(line, "<IsOnFire>", "</IsOnFire>")) then
                            natives.START_ENTITY_FIRE(all_entities["" .. last_ent_handle .. ""])
                        end
                    end
                    if string.find(line, "<IsInvincible>") then
                        entity.set_entity_god_mode(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsInvincible>", "</IsInvincible>")))
                        natives.SET_ENTITY_INVINCIBLE(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsInvincible>", "</IsInvincible>")))
                    end
                    if string.find(line, "<IsBulletProof>") then
                        bullet_proof = tobool(text_func.string_cut(line, "<IsBulletProof>", "</IsBulletProof>"))
                    end
                    if string.find(line, "<IsCollisionProof>") then
                        collision_proof = tobool(text_func.string_cut(line, "<IsCollisionProof>", "</IsCollisionProof>"))
                    end
                    if string.find(line, "<IsExplosionProof>") then
                        explosion_proof = tobool(text_func.string_cut(line, "<IsExplosionProof>", "</IsExplosionProof>"))
                    end
                    if string.find(line, "<IsFireProof>") then
                        fire_proof = tobool(text_func.string_cut(line, "<IsFireProof>", "</IsFireProof>"))
                    end
                    if string.find(line, "<IsMeleeProof>") then
                        melee_proof = tobool(text_func.string_cut(line, "<IsMeleeProof>", "</IsMeleeProof>"))
                    end
                    natives.SET_ENTITY_PROOFS(all_entities["" .. last_ent_handle .. ""], bullet_proof, fire_proof, explosion_proof, collision_proof, melee_proof, true, 1, false)
                    if string.find(line, "<IsOnlyDamagedByPlayer>") then
                        natives.SET_ENTITY_ONLY_DAMAGED_BY_PLAYER(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsOnlyDamagedByPlayer>", "</IsOnlyDamagedByPlayer>")))
                    end
                    if string.find(line, "<Attachment isAttached=") then
                        new_sub_ent_attachment = true
                    end
                    if new_sub_ent_attachment then
                        if string.find(line, "<AttachedTo>") then
                            attach_handler = toint(text_func.string_cut(line, "<AttachedTo>", "</AttachedTo>"))
                        end
                        if string.find(line, "<BoneIndex>") then
                            attach_bone = toint(text_func.string_cut(line, "<BoneIndex>", "</BoneIndex>"))
                        end
                        if string.find(line, "<X>") then
                            if not attach_x_index then
                                attach_x = tonumber(text_func.string_cut(line, "<X>", "</X>"))
                                attach_x_index = true
                            end
                        end
                        if string.find(line, "<Y>") then
                            if not attach_y_index then
                                attach_y = tonumber(text_func.string_cut(line, "<Y>", "</Y>"))
                                attach_y_index = true
                            end
                        end
                        if string.find(line, "<Z>") then
                            if not attach_z_index then
                                attach_z = tonumber(text_func.string_cut(line, "<Z>", "</Z>"))
                                attach_z_index = true
                            end
                        end
                        if string.find(line, "<Pitch>") then
                            if not attach_rot_p_index then
                                attach_rot_p = tonumber(text_func.string_cut(line, "<Pitch>", "</Pitch>"))
                                attach_rot_p_index = true
                            end
                        end
                        if string.find(line, "<Roll>") then
                            if not attach_rot_r_index then
                                attach_rot_r = tonumber(text_func.string_cut(line, "<Roll>", "</Roll>"))
                                attach_rot_r_index = true
                            end
                        end
                        if string.find(line, "<Yaw>") then
                            if not attach_rot_y_index then
                                attach_rot_y = tonumber(text_func.string_cut(line, "<Yaw>", "</Yaw>"))
                                attach_rot_y_index = true
                            end
                        end
                        if attach_x_index and attach_y_index and attach_z_index and attach_rot_p_index and attach_rot_r_index and attach_rot_y_index then
                            if all_entities["" .. attach_handler .. ""] == nil then
                                entity.attach_entity_to_entity(all_entities["" .. last_ent_handle .. ""], main_ent, attach_bone, v3(attach_x, attach_y, attach_z), v3(attach_rot_p, attach_rot_r, attach_rot_y), false, true, entity.is_entity_a_ped(main_ent), 2, true)
                                natives.PROCESS_ENTITY_ATTACHMENTS(main_ent)
                            else
                                entity.attach_entity_to_entity(all_entities["" .. last_ent_handle .. ""], all_entities["" .. attach_handler .. ""], attach_bone, v3(attach_x, attach_y, attach_z), v3(attach_rot_p, attach_rot_r, attach_rot_y), false, true, entity.is_entity_a_ped(all_entities["" .. attach_handler .. ""]), 2, true)
                                natives.PROCESS_ENTITY_ATTACHMENTS(all_entities["" .. attach_handler .. ""])
                            end
                            attach_x_index = false
                            attach_y_index = false
                            attach_z_index = false
                            attach_rot_p_index = false
                            attach_rot_r_index = false
                            attach_rot_y_index = false
                            new_sub_ent_attachment = false
                        end
                        if string.find(line, "</Attachment>") then
                            attach_x_index = false
                            attach_y_index = false
                            attach_z_index = false
                            attach_rot_p_index = false
                            attach_rot_r_index = false
                            attach_rot_y_index = false
                            new_sub_ent_attachment = false
                        end
                    end
                elseif (last_ent_type == 3 or last_ent_type == "3") and (streaming.is_model_an_object(last_ent_hash) or streaming.is_model_a_world_object(last_ent_hash)) then
                    if string.find(line, "<Dynamic>") then
                        last_ent_spawn_info_1 = tobool(text_func.string_cut(line, "<Dynamic>", "</Dynamic>"))
                    end
                    if string.find(line, "<FrozenPos>") then
                        last_ent_spawn_info_2 = tobool(text_func.string_cut(line, "<FrozenPos>", "</FrozenPos>"))
                    end
                    if string.find(line, "<InitialHandle>") then
                        local ent_handle = text_func.string_cut(line, "<InitialHandle>", "</InitialHandle>")
                        last_ent_handle = ent_handle
                        all_entity_handles[#all_entity_handles + 1] = ent_handle
                        utilities.request_model(last_ent_hash)
                        all_entities["" .. last_ent_handle .. ""] = object.create_world_object(last_ent_hash, v3_pos, true, last_ent_spawn_info_1)
                        network.request_control_of_entity(all_entities["" .. last_ent_handle .. ""])
                    end
                    entity.freeze_entity(all_entities["" .. last_ent_handle .. ""], last_ent_spawn_info_2)
                    if string.find(line, "<OpacityLevel>") then
                        entity.set_entity_alpha(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<OpacityLevel>", "</OpacityLevel>")), true)
                    end
                    if string.find(line, "<LodDistance>") then
                        natives.SET_ENTITY_LOD_DIST(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<LodDistance>", "</LodDistance>")))
                    end
                    if string.find(line, "<IsVisible>") then
                        entity.set_entity_visible(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsVisible>", "</IsVisible>")))
                    end
                    if string.find(line, "<MaxHealth>") then
                        natives.SET_ENTITY_MAX_HEALTH(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<MaxHealth>", "</MaxHealth>")))
                    end
                    if string.find(line, "<Health>") then
                        natives.SET_ENTITY_HEALTH(all_entities["" .. last_ent_handle .. ""], toint(text_func.string_cut(line, "<Health>", "</Health>")), 2)
                    end
                    if string.find(line, "<HasGravity>") then
                        natives.SET_ENTITY_HAS_GRAVITY(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<HasGravity>", "</HasGravity>")))
                    end
                    if string.find(line, "<IsOnFire>") then
                        if tobool(text_func.string_cut(line, "<IsOnFire>", "</IsOnFire>")) then
                            natives.START_ENTITY_FIRE(all_entities["" .. last_ent_handle .. ""])
                        end
                    end
                    if string.find(line, "<IsInvincible>") then
                        entity.set_entity_god_mode(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsInvincible>", "</IsInvincible>")))
                        natives.SET_ENTITY_INVINCIBLE(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsInvincible>", "</IsInvincible>")))
                    end
                    if string.find(line, "<IsBulletProof>") then
                        bullet_proof = tobool(text_func.string_cut(line, "<IsBulletProof>", "</IsBulletProof>"))
                    end
                    if string.find(line, "<IsCollisionProof>") then
                        collision_proof = tobool(text_func.string_cut(line, "<IsCollisionProof>", "</IsCollisionProof>"))
                    end
                    if string.find(line, "<IsExplosionProof>") then
                        explosion_proof = tobool(text_func.string_cut(line, "<IsExplosionProof>", "</IsExplosionProof>"))
                    end
                    if string.find(line, "<IsFireProof>") then
                        fire_proof = tobool(text_func.string_cut(line, "<IsFireProof>", "</IsFireProof>"))
                    end
                    if string.find(line, "<IsMeleeProof>") then
                        melee_proof = tobool(text_func.string_cut(line, "<IsMeleeProof>", "</IsMeleeProof>"))
                    end
                    natives.SET_ENTITY_PROOFS(all_entities["" .. last_ent_handle .. ""], bullet_proof, fire_proof, explosion_proof, collision_proof, melee_proof, true, 1, false)
                    if string.find(line, "<IsOnlyDamagedByPlayer>") then
                        natives.SET_ENTITY_ONLY_DAMAGED_BY_PLAYER(all_entities["" .. last_ent_handle .. ""], tobool(text_func.string_cut(line, "<IsOnlyDamagedByPlayer>", "</IsOnlyDamagedByPlayer>")))
                    end
                    if string.find(line, "<Attachment isAttached=") then
                        new_sub_ent_attachment = true
                    end
                    if new_sub_ent_attachment then
                        if string.find(line, "<AttachedTo>") then
                            attach_handler = toint(text_func.string_cut(line, "<AttachedTo>", "</AttachedTo>"))
                        end
                        if string.find(line, "<BoneIndex>") then
                            attach_bone = toint(text_func.string_cut(line, "<BoneIndex>", "</BoneIndex>"))
                        end
                        if string.find(line, "<X>") then
                            if not attach_x_index then
                                attach_x = tonumber(text_func.string_cut(line, "<X>", "</X>"))
                                attach_x_index = true
                            end
                        end
                        if string.find(line, "<Y>") then
                            if not attach_y_index then
                                attach_y = tonumber(text_func.string_cut(line, "<Y>", "</Y>"))
                                attach_y_index = true
                            end
                        end
                        if string.find(line, "<Z>") then
                            if not attach_z_index then
                                attach_z = tonumber(text_func.string_cut(line, "<Z>", "</Z>"))
                                attach_z_index = true
                            end
                        end
                        if string.find(line, "<Pitch>") then
                            if not attach_rot_p_index then
                                attach_rot_p = tonumber(text_func.string_cut(line, "<Pitch>", "</Pitch>"))
                                attach_rot_p_index = true
                            end
                        end
                        if string.find(line, "<Roll>") then
                            if not attach_rot_r_index then
                                attach_rot_r = tonumber(text_func.string_cut(line, "<Roll>", "</Roll>"))
                                attach_rot_r_index = true
                            end
                        end
                        if string.find(line, "<Yaw>") then
                            if not attach_rot_y_index then
                                attach_rot_y = tonumber(text_func.string_cut(line, "<Yaw>", "</Yaw>"))
                                attach_rot_y_index = true
                            end
                        end
                        if attach_x_index and attach_y_index and attach_z_index and attach_rot_p_index and attach_rot_r_index and attach_rot_y_index then
                            if all_entities["" .. attach_handler .. ""] == nil then
                                entity.attach_entity_to_entity(all_entities["" .. last_ent_handle .. ""], main_ent, attach_bone, v3(attach_x, attach_y, attach_z), v3(attach_rot_p, attach_rot_r, attach_rot_y), false, true, entity.is_entity_a_ped(main_ent), 2, true)
                                natives.PROCESS_ENTITY_ATTACHMENTS(main_ent)
                            else
                                entity.attach_entity_to_entity(all_entities["" .. last_ent_handle .. ""], all_entities["" .. attach_handler .. ""], attach_bone, v3(attach_x, attach_y, attach_z), v3(attach_rot_p, attach_rot_r, attach_rot_y), false, true, entity.is_entity_a_ped(all_entities["" .. attach_handler .. ""]), 2, true)
                                natives.PROCESS_ENTITY_ATTACHMENTS(all_entities["" .. attach_handler .. ""])
                            end
                            attach_x_index = false
                            attach_y_index = false
                            attach_z_index = false
                            attach_rot_p_index = false
                            attach_rot_r_index = false
                            attach_rot_y_index = false
                            new_sub_ent_attachment = false
                        end
                        if string.find(line, "</Attachment>") then
                            attach_x_index = false
                            attach_y_index = false
                            attach_z_index = false
                            attach_rot_p_index = false
                            attach_rot_r_index = false
                            attach_rot_y_index = false
                            new_sub_ent_attachment = false
                        end
                    end
                end
                if string.find(line, "</Attachment>") and not new_sub_ent_attachment then
                    attach_x_index = false
                    attach_y_index = false
                    attach_z_index = false
                    attach_rot_p_index = false
                    attach_rot_r_index = false
                    attach_rot_y_index = false
                    new_ent_attachment = false
                    new_sub_ent_attachment = false
                end
            end
        end
    end
    return main_ent
end

return xml_handler