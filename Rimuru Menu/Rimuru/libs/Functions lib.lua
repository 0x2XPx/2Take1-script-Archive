require("Rimuru\\tables\\scriptevents") 
require("Rimuru\\tables\\globals") 
require("Rimuru\\tables\\objects") 
require("Rimuru\\tables\\peds") 
require("Rimuru\\tables\\pickups") 
require("Rimuru\\libs\\feats\\drone") 
require("Rimuru.libs.natives")

stuff = {scroll = 1, hiddenfeats = 0, scrollHiddenOffset = 0, menuToggle = false,
 previousMenus = {}, threads = {}, headers = {}, headerNames = {}, 
 appdata = utils.get_appdata_path("PopstarDevs", "2Take1Menu"), 
 drawScroll = 0, maxDrawScroll = 0, deleteList = {}, addList = {}, playerOffset = 0,
 menuData = {x=0, y=0, width = 0.2, height = 0.2, header = "cheese_menu.png",
 color = {r = 144, g = 99, b = 245, a = 220}}} 

func = {}
playerStates = {typing = true, paused = false, vip = false}
menuSaveToggles = {embedScripts = false}

stuff.input = require("Rimuru\\libs\\Get Input") 

stuff.Keys = {}
function func.get_key(...)
    local args = {...}
    assert(#args > 0, "must give at least one key")
    local ID = table.concat(args, "|")
    if not stuff.Keys[ID] then
        local key = MenuKey()
        for i=1,#args do
           key:push_vk(args[i])
        end
        stuff.Keys[ID] = key
    end
    
    return stuff.Keys[ID]
end

function func.do_key(time, key, doLoopedFunction, functionToDo)
	if func.get_key(key):is_down() then
		functionToDo()
		local timer = utils.time_ms() + time
		while timer > utils.time_ms() and func.get_key(key):is_down() do
			system.wait(0)
		end
		while timer < utils.time_ms() and func.get_key(key):is_down() do
			if doLoopedFunction then
				functionToDo()
			end
			local timer = utils.time_ms() + 50
			while timer > utils.time_ms() do
				system.wait(0)
			end
		end
	end
end

if stuff.input then
	function input.get(title, default, len, Type)
		local originalmenuToggle = stuff.menuData.menuToggle
		stuff.menuData.menuToggle = false
		local status, gottenInput = stuff.input.getInput(title, default, len, Type)
		while func.get_key(0x0D):is_down() do
			system.wait(0)
		end
		stuff.menuData.menuToggle = originalmenuToggle
		return status, gottenInput
	end
end

function func.notification(text)
    menu.notify(text, "Rimurus Menu", 4, RGBAToInt(stuff.menuData.color.r, stuff.menuData.color.g, stuff.menuData.color.b, 255))
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
    for i=1, 8 do
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

Slots={}
function getVehicleSlots()
    local max_slots = script.get_global_i(globals.pv.maxSlots.hash)
    for i=1,max_slots do
        local hash = script.get_global_i(globals.pv.maxSlots.hash+1+(i*142)+66)
        local name = streaming.get_vehicle_model_name(hash)
        if name then
            table.insert(Slots, {i, name, hash})
        end
    end
end
getVehicleSlots()

function getCurrentPersonalVehicle()
    return script.get_global_i(globals.pv.getCurrent.hash)
end


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

            
            if playerStates.vip then
                if (params[1] == scriptEvents.PlayerStateEvents.vip.hash) then
                    func.notification(name_source .. " is now a VIP")
                end
                if (params[1] == scriptEvents.PlayerStateEvents.exitedVip.hash) then
                    func.notification(name_source .. " is nolonger a VIP")
                end
            end
          
            if playerStates.typing then
                if (params[1] == scriptEvents.PlayerStateEvents.typing.hash) then
                    func.notification(name_source .. " is typing...")
                end                    
                if (params[1] == scriptEvents.PlayerStateEvents.noLongerTyping.hash) then
                    func.notification(name_source .. " closed the chat box")
                end
            end
            
            if playerStates.paused then
                if (params[1] == scriptEvents.PlayerStateEvents.paused.hash) then
                    func.notification(name_source .. " is paused")
                end
                if (params[1] == scriptEvents.PlayerStateEvents.noLongerPaused.hash) then
                    func.notification(name_source .. " is nolonger paused")
                end
            end
        end)
    else
        menu.notify("You must be online to use this!")
    end
end
startListeners()


function requestPTFX(ptfx_asset) --skidded from fun menu
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

bits = {}
function bits.IS_BIT_SET(value, offset)
    return (value & (1 << offset)) ~= 0
end

function bits.CLEAR_BIT(address, offset)
    return native.call(0xE80492A9AC099A93, address, offset):__tointeger()
end

function bits.SET_BIT(value, offset)
    return value | (1 << offset)
end

function setVehicleColour(colourPrim, colourSec, colourPearl, pid)
    pid = pid or player.player_id()
    local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
    vehicle.set_vehicle_custom_primary_colour(veh, RGBAToInt(colourPrim.b, colourPrim.g, colourPrim.r))--blue green red
    vehicle.set_vehicle_custom_secondary_colour(veh, RGBAToInt(colourSec.b, colourSec.g, colourSec.r))--blue green red
    vehicle.set_vehicle_custom_pearlescent_colour(veh, RGBAToInt(colourPearl.b, colourPearl.g, colourPearl.r))--blue green red
end

function createExplosion(type, pid)
    if player.is_player_valid(pid) then
        local pos = player.get_player_coords(pid)
        pos.z = pos.z - 1
        fire.add_explosion(pos, type, true, false, 0, player.get_player_ped(pid))
    end
end

function get_closest_train()
	local vehicles = vehicle.get_all_vehicles()

	for i=1, #vehicles do
		if entity.get_entity_model_hash(vehicles[i]) == 1030400667 then
			network.request_control_of_entity(vehicles[i])
			return vehicles[i]
		end
	end
	menu.notify("Could not find any train nearby")
	return 0
end