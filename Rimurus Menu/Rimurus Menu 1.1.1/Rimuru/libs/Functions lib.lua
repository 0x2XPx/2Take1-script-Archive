require("Rimuru\\tables\\objects") 
require("Rimuru\\tables\\peds") 
require("Rimuru\\tables\\vehicles") 
require("Rimuru\\libs\\drone") 

stuff = {scroll = 1, hiddenfeats = 0, scrollHiddenOffset = 0, menuToggle = false,
 previousMenus = {}, threads = {}, headers = {}, headerNames = {}, 
 appdata = utils.get_appdata_path("PopstarDevs", "2Take1Menu"), 
 drawScroll = 0, maxDrawScroll = 0, deleteList = {}, addList = {}, playerOffset = 0,
 menuData = {x = 0.5, y = 0.568, width = 0.2, height = 0.305, header = "cheese_menu.png", color = {r = 0, g = 0, b = 0, a = 125}}}

func = {}
playerStates = {typing = true, paused = false, vip = true}

stuff.input = require("Rimuru\\libs\\Get Input") 

function input.get(title, default, len, Type)
	local originalmenuToggle = stuff.menuToggle
	stuff.menuToggle = false
	local status, gottenInput = stuff.input.getInput(title, default, len, Type)
	while func.isKeyDown(0x0D) do
		system.wait(0)
	end
	stuff.menuToggle = originalmenuToggle
	return status, gottenInput
end

function ObjectGun()
    local val = math.random(0, #objects)
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))

    if boolrtn then
        object.create_world_object(gameplay.get_hash_key(objects[val]), impact, true, false)
    end
end

function ExplosionTypeGun(num)
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))

    if boolrtn then
        fire.add_explosion(impact, num, true, false, 0, player.player_id())
    end
end

function DeleteGun()
  local ent = player.get_entity_player_is_aiming_at(player.player_id())
  entity.delete_entity(ent)
end

function GrappleGun()
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()), v3())
    local loc = player.get_player_coords(player.player_id())
    impact.x = impact.x - loc.x
    impact.y = impact.y - loc.y
    impact.z = impact.z - loc.z + 25
    
    if boolrtn then       
        entity.set_entity_velocity(player.get_player_ped(player.player_id()), impact)
        ai.task_sky_dive(player.get_player_ped(player.player_id()), true)
    end
end

function RopeGun()
    local hit_ent1,hit_ent2
    local hit_pos_1,hit_pos_2
    local ropeTogetherannounced = false
    local ropeList = {}
    
    if(ropeTogetherannounced == false) then
        menu.notify("Please shoot an Entity to rope them together!","Rimurus Menu",5, RGBAToInt(144, 151, 245))
        ropeTogetherannounced = true
      end
    
      local a,b = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id())) 
      if(a == true) then
        if(hit_ent1 == nil) then
          --select ent1
          hit_ent1 = player.get_entity_player_is_aiming_at(player.player_id())
          hit_pos_1 = b
          if(hit_ent1 ~= nil and hit_ent1 ~= 0) then        
            menu.notify("Selected Entity with id: " .. hit_ent1,"Rimurus Menu",5, RGBAToInt(144, 151, 245))
            if(entity.is_entity_a_ped(hit_ent1)) then          
              if(ped.is_ped_in_any_vehicle(hit_ent1)) then
                hit_ent1 = ped.get_vehicle_ped_is_using(hit_ent1)
              end        
            end
          else
            menu.notify("Couldn't find any entity!","Rimurus Menu",5,RGBAToInt(144, 151, 245))
            hit_ent1 = nil
            ropeTogetherannounced = false
          end
        else
          --select ent2
          hit_ent2 = player.get_entity_player_is_aiming_at(player.player_id())
          hit_pos_2 = b
          if(hit_ent2 ~= nil and hit_ent2 ~= 0) then        
            menu.notify("Selected second Entity with id: " .. hit_ent2,"Rimurus Menu",5, RGBAToInt(144, 151, 245))        
            if(entity.is_entity_a_ped(hit_ent2)) then          
              if(ped.is_ped_in_any_vehicle(hit_ent2)) then
                hit_ent2 = ped.get_vehicle_ped_is_using(hit_ent2)
                hit_pos_2 = b
              end        
            end        
          else
            menu.notify("Couldn't find any entity!","Rimurus Menu",5,RGBAToInt(144, 151, 245))
            hit_ent2 = nil
            ropeTogetherannounced = false
          end
        end
        
        if(hit_ent1 ~= nil and hit_ent2 ~= nil) then
          
          local length = Get_Distance_Between_Coords(entity.get_entity_coords(hit_ent1), entity.get_entity_coords(hit_ent2))
          
          local ropePos = entity.get_entity_coords(hit_ent1)
          local newRope = rope.add_rope(ropePos,v3(0,0,0),1,1,10,10,10,true,true,true,1.0,false)
          local ropeObject = {}
          ropeObject['rope'] = newRope
          ropeObject['ent_1'] = hit_ent1
          ropeObject['ent_2'] = hit_ent2
          
          ropeList[#ropeList+1] = ropeObject
          rope.attach_entities_to_rope(newRope,hit_ent1,hit_ent2,hit_pos_1,hit_pos_2,length ,0,0,"Center","Center")
    
          hit_pos_2 = nil
          hit_pos_1 = nil
    
          hit_ent1 = nil
          hit_ent2 = nil
          ropeTogetherannounced = false
          return HANDLER_POP       
        else
          return HANDLER_CONTINUE
        end
      end
      return HANDLER_CONTINUE
end

function SpawnFlippedMap()
    local pos = player.get_player_coords(player.player_id())
    pos.z = pos.z + 500

    local e = object.create_world_object(gameplay.get_hash_key("ch2_lod3_slod3"), pos, true, false)
    local roat = v3()
    roat.x = 0
    roat.y = -200
    roat.z = 5

    entity.set_entity_rotation(e, roat)
end

function SpawnObjFromName()
    local status, inputString = input.get("Input A Object Name", "", 100, 0)    
    local iHash = gameplay.get_hash_key(inputString)

    if streaming.is_model_valid(iHash) then
        object.create_world_object(iHash, player.get_player_coords(player.player_id()), true, false)
     else --#### void           notify(string message, string|nil title, uint32_t|nil seconds, uint32_t|nil color)

        menu.notify("invalid model was input", "", 3, RGBAToInt(144, 151,245, 255))
    end
end

function SpawnObj(val, pid)
    pid = pid or player.player_id()
    if val ~= nil then
        object.create_object(gameplay.get_hash_key(objects[val+1]), player.get_player_coords(pid), true, false)
    end
end

function SpawnWrld(val, pid)
    pid = pid or player.player_id()
    if val ~= nil then
        local wrld = object.create_world_object(gameplay.get_hash_key(objects[val+1]), player.get_player_coords(pid), true, false)
        entity.freeze_entity(wrld, true)
    end
end

function SpawnProp(val)
    if val ~= nil then
        object.create_world_object(gameplay.get_hash_key(objects[val+1]), player.get_player_coords(player.player_id()), true, false)
    end 
end

function SpawnPed(val, health, pid)
    health = health or 100
    pid = pid or player.player_id()

    if val ~= nil then
        local hash = gameplay.get_hash_key(pedList[val+1])

        streaming.request_model(hash)
    
        while(not streaming.has_model_loaded(hash) and utils.time_ms() + 450 > utils.time_ms()) do
            system.wait(0)
        end

        if(streaming.is_model_valid(hash)) then
            local p = ped.create_ped(26, hash, player.get_player_coords(player.player_id()), 0, true, false)
            ped.set_ped_health(p, tonumber(health))
        end

        streaming.set_model_as_no_longer_needed(hash) 
    end
end

function SpawnAnimal(val, health, pid)
    health = health or 100
    pid = pid or player.player_id()

    if val ~= nil then
        local hash = gameplay.get_hash_key(animalsPeds[val+1])

        streaming.request_model(hash)
    
        while(not streaming.has_model_loaded(hash) and utils.time_ms() + 450 > utils.time_ms()) do
            system.wait(0)
        end

        if(streaming.is_model_valid(hash)) then
            local p = ped.create_ped(28, hash, player.get_player_coords(player.player_id()), 0, true, false)
            ped.set_ped_health(p, tonumber(health))
        end

        streaming.set_model_as_no_longer_needed(hash) 
    end
end

function SpawnPedFromName()
    local input, i = input.get("Input A Ped Name", "", 100, 0)

    if input == 1 then
       return HANDLER_CONTINUE
   end
   if input == 2 then
       return HANDLER_POP
   end
 
    local hash = gameplay.get_hash_key(i)
 
    streaming.request_model(hash)
    while(not streaming.has_model_loaded(hash) and utils.time_ms() + 450 > utils.time_ms()) do
       system.wait(0)
    end
 
    ped.create_ped(2, hash, player.get_player_coords(player.player_id()), 0, true, false)
end

function Gta4Neons()
   local mvehicle =  ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  
   if(ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id()))) then
    for i=1, 7 do
       local obj = object.create_object(gameplay.get_hash_key("vw_prop_casino_phone_01b"), player.get_player_coords(player.player_id()), true, false)

       network.request_control_of_entity(mvehicle)
       if(not network.has_control_of_entity(mvehicle) and utils.time_ms() + 450 > utils.time_ms()) then
          system.wait(0)
       end
       vehicle.set_vehicle_neon_light_enabled(mvehicle, 255, true)
       entity.attach_entity_to_entity(obj, mvehicle, 0, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
    end
    else
        menu.notify("You are not in a vehicle")
   end
end

function RemoveGtaNeons()
    local objects = object.get_all_objects()
    for i = 1, #objects do
        entity.delete_entity(objects[i])
    end
end

function BlackParade()
    local scaleForm = graphics.request_scaleform_movie("POPUP_WARNING")
    if(not graphics.has_scaleform_movie_loaded(scaleForm)) then
    else
        ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
        graphics.begin_scaleform_movie_method(scaleForm, "SHOW_POPUP_WARNING")
        graphics.draw_scaleform_movie_fullscreen(scaleForm, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_float(500.0)
        graphics.scaleform_movie_method_add_param_texture_name_string("alert")
        graphics.scaleform_movie_method_add_param_texture_name_string("When I was a young boy, my father\nTook me into the city to see a marching band\nHe said, Son, when you grow up would you be\nThe savior of the broken, the beaten and the damned?\nHe said, Will you defeat them? Your demons\nAnd all the non-believers, the plans that they have made?\nBecause one day, Ill leave you a phantom\nTo lead you in the summer to join the black parade\n")
        graphics.end_scaleform_movie_method(scaleForm)
    end
end

function tpVehicle()
    local vehicle = player.get_personal_vehicle()

    while(not network.request_control_of_entity(vehicle) and utils.time_ms() + 450 > utils.time_ms() and streaming.is_model_valid(vehicle)) do
        system.wait(0)
  end
   entity.set_entity_coords_no_offset(vehicle, player.get_player_coords(player.player_id()))
end

function Get_Distance_Between_Coords(first, second)
    local x = second.x - first.x
    local y = second.y - first.y
    local z = second.z - first.z
    return math.sqrt(x * x + y * y + z * z)
end

function vehicleBypass()
    if network.is_session_started then
       local player_id = player.player_id()
       local player_ped = player.get_player_ped(player_id)
       local old_veh = ped.get_vehicle_ped_is_using(player_ped)
       local model = 970598228
       streaming.request_model(model)
       if (streaming.has_model_loaded(model)) then
           entity.set_entity_visible(old_veh, false)
           entity.set_entity_collision(old_veh, false, false, false)
           local vehicle = vehicle.create_vehicle(model, player.get_player_coords(player_id), 0.0, true, false)
           ped.set_ped_into_vehicle(player_ped, vehicle, -1)

           system.yield(3000)

           ped.set_ped_into_vehicle(player_ped, old_veh, -1)
           entity.set_entity_collision(old_veh, true, true, true)
           entity.delete_entity(model)
       end
       entity.set_entity_as_no_longer_needed(model)
   end
end

function FindVehicleName(Hash)
    if Hash or Hash ~= 0 then 
        for k,v in pairs(vehicleList) do
            if tonumber(Hash) == tonumber(v[2]) then 
                return v[1] 
            end
        end
        return false
    end
end

Slots={}
function GetVehicleSlots()
    local max_slots = script.get_global_i(1585853)
    for i=1,max_slots do
        local hash = script.get_global_i(1585853+1+(i*142)+66)
        local name = FindVehicleName(hash)
        if name then
            table.insert(Slots, {i, name, hash})
        end
    end
end
GetVehicleSlots()

function startListeners()
    if network.is_session_started then
        local script_event = hook.register_script_event_hook(function(source, target, params, count)
           -- local scid_source = scid(source)
            local name_source = player.get_player_name(source)

            local se_counter = 0;
            local se_event = '';

            for i = 1, #params do
                se_event = se_event .. params[i]
                if i ~= #params then
                    se_event = se_event .. ', '
                end
                se_counter = se_counter + 1;
            end

                if (params[1] == 948476291) then
                   -- menu.notify(name_source .. " is now a VIP", "", 6, RGBAToInt(144, 151, 245, 255))
                end
                if (params[1] == 3557108651)then
                 --   menu.notify(name_source .. " is nolonger a VIP", "", 6, RGBAToInt(144, 151, 245, 255))
                end

                if playerStates.typing then
                    if (params[1] == 747270864) then
                        menu.notify(name_source .. " is typing...", "", 6, RGBAToInt(144, 151, 245, 255))
                    end                    
                    if (params[1] == 3304008971) then
                        menu.notify(name_source .. " closed the chat box", "", 6, RGBAToInt(144, 151, 245, 255))
                    end
                end
                
                if playerStates.paused then
                    if (params[1] == 959741220) then
                        menu.notify(name_source .. " is paused", "", 6, RGBAToInt(144, 151, 245, 255))
                    end
                    if (params[1] == 1456985457) then
                        menu.notify(name_source .. " is nolonger paused", "", 6, RGBAToInt(144, 151, 245, 255))
                    end
                end
        end)
    else
        menu.notify("You must be online to use this!")
    end
end
startListeners()

IniVehicle = {}
function GetIniVehicles()
    local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
    IniVehicle = utils.get_all_files_in_directory(appdata.."scripts\\Rimuru\\IniVehicles", "ini")
end
GetIniVehicles()

function CreateModdedVehicle(hash, primary, secondary, pearl, tireColour, numPlate, objHash, objPos, objRot)
    primary = primary or 0
    secondary = secondary or 0
    pearl = pearl or 0
    tireColour = tireColour or 0
    numPlate = numPlate or ""

    objHash = objHash or ""
    objPos.x = objPos.x or 0
    objPos.y = objPos.y or 0
    objPos.z = objPos.z or 0

    objRot.x = objRot.x or 0
    objRot.y = objRot.y or 0
    objRot.z = objRot.z or 0

    local mVeh
    local vHash = hash
    local mPos = player.get_player_coords(player.player_id())
    mPos.x = mPos.x - 4
    
    streaming.request_model(vHash)
    if (streaming.has_model_loaded(vHash)) then
        mVeh = vehicle.create_vehicle(hash, mPos, 1.0, true, false)
        vehicle.set_vehicle_color(mVeh, primary, secondary, pearl, tireColour)
        vehicle.set_vehicle_number_plate_text(mVeh, numPlate)
    end

    if objHash ~= 0 or objHash ~= "" then
        streaming.request_model(objHash)
        if (streaming.has_model_loaded(objHash)) then
            local obj = object.create_world_object(objHash, objPos, true, false)
            entity.attach_entity_to_entity(obj, mVeh, 1, objPos, objRot, true, true, false, 1, true)
        end
    end
end

function ParseIniVehicle()
    local ini = require("Rimuru\\Dependancies\\ini_parser")
    local cfg = ini.parse("Rimuru\\IniVehicles\\"..IniVehicle[LuaUI.Options.scroll+1])

    local rotPos = v3()

    if(cfg["0"]["RotX"] and cfg["0"]["RotY"] or cfg["0"]["RotZ"]) then
        rotPos.x = cfg["0"]["RotX"]
        rotPos.y = cfg["0"]["RotY"]
        rotPos.z = cfg["0"]["RotZ"]
    else 
        rotPos.x = 0
        rotPos.y = 0
        rotPos.z = 0
    end

    local objPos = v3()
    if(cfg["0"]["x"] or cfg["0"]["y"] or cfg["0"]["z"]) then
        objPos.x = cfg["0"]["x"]
        objPos.y = cfg["0"]["y"]
        objPos.z = cfg["0"]["z"]
    else if (cfg["0"]["X"] or cfg["0"]["Y"] or cfg["0"]["Z"]) then
        objPos.x = cfg["0"]["X"]
        objPos.y = cfg["0"]["Y"]
        objPos.z = cfg["0"]["Z"]
    else
        objPos.x = 0
        objPos.y = 0
        objPos.z = 0
        end
    end

   local modelHash 
   if(cfg["0"]["model"]) then
       modelHash = cfg["0"]["model"]
   else if(cfg["0"]["Model"]) then
        modelHash = cfg["0"]["Model"]
    else
        modelHash = 0
        end
   end

    CreateModdedVehicle(cfg.Vehicle.Model, cfg.Vehicle.PrimaryPaint, 
    cfg.Vehicle.SecondaryPaint, cfg.Vehicle.Pearlescent,
    cfg.Vehicle.WheelsColor, cfg.Vehicle.PlateText, modelHash, 
    objPos, rotPos)
end

function requestPTFX(ptfx_asset)
    local time <const> = utils.time_ms() + 500
    graphics.request_named_ptfx_asset(ptfx_asset)
    while time > utils.time_ms() and not graphics.has_named_ptfx_asset_loaded(ptfx_asset) do
        system.yield(0)
    end
    return graphics.has_named_ptfx_asset_loaded(ptfx_asset)
end

local ptfx_loaded = false
local ptfx_executed = false --skidded from fun menu
function doPTFX()
    graphics.set_next_ptfx_asset("scr_powerplay")

    if (ptfx_loaded == false or ptfx_executed == false) then
        ptfx_loaded = requestPTFX("scr_powerplay")
        ptfx_executed = true
    end 

    local trail = graphics.start_networked_ptfx_non_looped_on_entity("sp_powerplay_beast_appear_trails", player.get_player_ped(player.player_id()), v3(0, 0.07, 0), v3(-90, 0, 0), 1.5)
end

function RGBAToInt(Red, Green, Blue, Alpha)
    Alpha = Alpha or 255
    return ((Red & 0x0ff) << 0x00) | ((Green & 0x0ff) << 0x08) |
               ((Blue & 0x0ff) << 0x10) | ((Alpha & 0x0ff) << 0x18)
end

function setVehicleColour(colour)
    local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    vehicle.set_vehicle_custom_primary_colour(veh, RGBAToInt(colour.b, colour.g, colour.r))--blue green red
    vehicle.set_vehicle_custom_secondary_colour(veh, RGBAToInt(colour.b, colour.g, colour.r))--blue green red
    vehicle.set_vehicle_custom_pearlescent_colour(veh, RGBAToInt(255, 255, 255, 255))--blue green red
end

local function createObject(name, pos)
    return object.create_object(gameplay.get_hash_key(name), pos, true, false)
end


function createObjectFollower(name, pid)
        local pos = player.get_player_coords(pid)    
        local dif = Get_Distance_Between_Coords(player.get_player_coords(pid), pos)
        streaming.request_model(gameplay.get_hash_key("A_F_M_BevHills_02"))
        
        if streaming.has_model_loaded(gameplay.get_hash_key("A_F_M_BevHills_02")) then
            local cPed = ped.create_ped(26, gameplay.get_hash_key("A_F_M_BevHills_02"), pos, 165, false, false)
            local obj = createObject(name, pos)
            system.wait(10)
            --entity.set_entity_visible(cPed, false)
            entity.attach_entity_to_entity(cPed, obj, 0, v3(0,1,0), v3(0,0,0), false, false, false, 0, true)
        end
end

