require("Rimuru.tables.scriptevents") 
require("Rimuru.tables.globals") 
require("Rimuru.tables.objects") 
require("Rimuru.tables.peds") 
require("Rimuru.tables.pickups") 
require("Rimuru.tables.visions") 
require("Rimuru.libs.feats.drone") 
require("Rimuru.libs.natives")

stuff = {scroll = 1, hiddenfeats = 0, scrollHiddenOffset = 0, menuToggle = false,
 previousMenus = {}, threads = {}, headers = {}, headerNames = {}, 
 appdata = utils.get_appdata_path("PopstarDevs", "2Take1Menu"), 
 drawScroll = 0, maxDrawScroll = 0, deleteList = {}, addList = {}, playerOffset = 0,
 menuData = {x=0, y=0, width = 0.18, height = 0.2, header = "cheese_menu.png", maxOptions = 7,
 fadeColour = {r = 255, g = 0, b = 0}, mainColour = {r=0, g = 0, b = 0, a = 220},  backColour = {r = 0, g = 0, b = 0, a = 0}}} 

func = {}
playerStates = {typing = true, paused = false, vip = false}
menuSaveToggles = {embedScripts = false, controllerSupport = false}

stuff.input = require("Rimuru.libs.GetInput") 

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
    menu.notify(tostring(text), "Rimurus Menu", 4, RGBAToInt(stuff.menuData.mainColour.r, stuff.menuData.mainColour.g, stuff.menuData.mainColour.b, 255))
end

function createExplosion(type, pos)
    fire.add_explosion(pos, type, true, false, 0, player.get_player_ped(PLAYER.PLAYER_PED_ID()))
end

function ExplosionTypeGun(num)
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))

    if boolrtn then
        createExplosion(num, impact)
    end
end

function SpawnObjFromName()
    local status, inputString = input.get("Input A Object Name", "", 100, 0)    
    local iHash = gameplay.get_hash_key(inputString)

    if streaming.is_model_valid(iHash) then
        object.create_world_object(iHash, player.get_player_coords(player.player_id()), true, false)
     else 
        func.notification("invalid model was input")
    end
end

function SpawnObj(val, pid)
    pid = pid or player.player_id()
    if val ~= nil then
        return object.create_object(gameplay.get_hash_key(objects[val+1]), player.get_player_coords(pid), true, false)
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
            local p = ped.create_ped(26, hash, player.get_player_coords(pid), 0, true, false)
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
        func.notification("You are not in a vehicle")
   end
end

function RemoveGtaNeons()
    local objects = object.get_all_objects()
    for i = 1, #objects do
        entity.delete_entity(objects[i])
    end
end

function requestControl(entity_model)
    if (entity.is_an_entity(entity_model)) then
        if (not network.has_control_of_entity(entity_model)) then
            network.request_control_of_entity(entity_model)
        end
        return network.has_control_of_entity(entity_model)
    end
    return false
end

function GET_CAMERA_DIRECTION(dirX, dirY, dirZ)
    local tX, tZ, num
    local rot = CAM.GET_FINAL_RENDERED_CAM_ROT(0)

    tZ = rot.z * 0.0174532924
	tX = rot.x * 0.0174532924
    num = math.abs(math.cos(tX))

    dirX = (-math.sin(tZ)) * num
    dirY = (math.cos(tZ)) * num
    dirZ = math.sin(tX)
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
    native.call(0xE80492A9AC099A93, address, offset):__tointeger()
end

function bits.SET_BIT(add, offset)
    native.call(0x933D6A9EEC1BACD0, add, offset)
end

function setVehicleColour(colourPrim, colourSec, colourPearl, pid)
    pid = pid or player.player_id()
    local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
    vehicle.set_vehicle_custom_primary_colour(veh, RGBAToInt(colourPrim.b, colourPrim.g, colourPrim.r))--blue green red
    vehicle.set_vehicle_custom_secondary_colour(veh, RGBAToInt(colourSec.b, colourSec.g, colourSec.r))--blue green red
    vehicle.set_vehicle_custom_pearlescent_colour(veh, RGBAToInt(colourPearl.b, colourPearl.g, colourPearl.r))--blue green red
end

function get_closest_train()
	local vehicles = vehicle.get_all_vehicles()

	for i=1, #vehicles do
		if entity.get_entity_model_hash(vehicles[i]) == 1030400667 then
			network.request_control_of_entity(vehicles[i])
			return vehicles[i]
		end
	end
	return 0
end

function getClosestVehicle(pos)
    local vehs = vehicle.get_all_vehicles()
    
    if vehs ~= nil then
        for i=1, #vehs do
            if Get_Distance_Between_Coords(entity.get_entity_coords(vehs[i]), pos) < 4 then
                return vehs[i]
            end
        end
    end
    return 0
end

function AllowVehicleToBePlacedInGarage(pid, veh)
    decorator.decor_set_int(veh, "MPBitset", 0);
    local networkId = NETWORK.VEH_TO_NET(veh);
    if (NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(veh)) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true);
        VEHICLE.SET_VEHICLE_IS_STOLEN(veh, false);
    end
end

function loadSettings()
	local ini = require("Rimuru\\libs\\ini_parser")
    local cfg = ini.parse "Rimuru\\menuSettings.ini"

	if cfg then
		stuff.menuData.x = cfg.Position.xPosition
		stuff.menuData.y = cfg.Position.yPosition
		stuff.menuData.maxOptions = cfg.Position.maxOptions

		playerStates.paused = cfg.states.paused
		playerStates.vip = cfg.states.vip
		playerStates.typing = cfg.states.typing

        stuff.menuData.mainColour.r = cfg.mainColour.Red
        stuff.menuData.mainColour.g = cfg.mainColour.Green
        stuff.menuData.mainColour.b = cfg.mainColour.Blue

        stuff.menuData.backColour.r = cfg.backColour.Red
        stuff.menuData.backColour.g = cfg.backColour.Green
        stuff.menuData.backColour.b = cfg.backColour.Blue
        stuff.menuData.backColour.a = cfg.backColour.Alpha

		menuSaveToggles.embedScripts = cfg.toggledOptions.embedScripts
		menuSaveToggles.controllerSupport = cfg.toggledOptions.controllerSupport
		cfg.save()
	else
		func.notification("Could not find the menuSettings.ini")
	end
end loadSettings()

MenuThemes = {}
local function ParseThemes()
	local ini = require("Rimuru\\libs\\ini_parser") 
	local cfg = ini.parse("Rimuru\\UI\\"..MenuThemes[stuff.scroll])

    if cfg.mainColour.red ~= nil and cfg.backColour.red ~= nil then
        --scroller n shit
        stuff.menuData.mainColour.r = cfg.mainColour.red
        stuff.menuData.mainColour.g = cfg.mainColour.green
        stuff.menuData.mainColour.b = cfg.mainColour.blue

        --background
        stuff.menuData.backColour.r = cfg.backColour.red
        stuff.menuData.backColour.g = cfg.backColour.green
        stuff.menuData.backColour.b = cfg.backColour.blue
        
        if cfg.backColour.alpha ~= nil then
            stuff.menuData.backColour.a = cfg.backColour.alpha
        end 
    end        
end

function loadThemes(id)    
    local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
	MenuThemes = utils.get_all_files_in_directory(appdata.."scripts\\Rimuru\\UI", "ini")

    for i=1, #MenuThemes do
        func.add_feature(MenuThemes[i], "action", id, function()
            ParseThemes()
        end)
    end

end

local function startExit()
    event.add_event_listener("exit", function(event)
        for i=1, #stuff.threads do
            menu.delete_thread(stuff.threads[i])
        end
        
        func.notification("Cleaned up threads")
    end)
end
startExit()