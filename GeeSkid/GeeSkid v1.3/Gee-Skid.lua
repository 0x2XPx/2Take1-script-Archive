-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------GGGGGGG----------EEEEEEEEE-------EEEEEEEEE-----------------------SSSSSSS-------KK------KK-------III-------DDDDDDD--------------------
-------------------GGG-------GGG-------EE--------------EE---------------------------ssss-------------KK-----KK--------III-------DD----DD-------------------
------------------GG-------------------EE--------------EE--------------------------sss---------------KK----KK---------III-------DD-----DD------------------
-----------------GG--------------------EE--------------EE--------------------------ss----------------KK---KK----------III-------DD------DD-----------------
-----------------GG--------------------EE--------------EE---------------------------ss---------------KK--KK-----------III-------DD------DD-----------------
-----------------GG-------GGGG---------EEEEEEEE--------EEEEEEEE-------=======--------sssssss---------KKKKK------------III-------DD------DD-----------------
-----------------GG----------GG--------EE--------------EE----------------------------------ss--------KK--KK-----------III-------DD------DD-----------------
-----------------GG-----------GG-------EE--------------EE-----------------------------------ss-------KK---KK----------III-------DD------DD-----------------
------------------GG----------GG-------EE--------------EE----------------------------------sss-------KK----KK---------III-------DD-----DD------------------
-------------------GG-------GG---------EE--------------EE--------------------------------ssss--------KK-----KK--------III-------DD----DD-------------------
--------------------GGGGGGGGG----------EEEEEEEEE-------EEEEEEEEE--------------------SSSSSSS----------KK------KK-------III-------DDDDDDD--------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------



require("GeeSkid/_G_funcs")
require("GeeSkid/_G_funcs_TP")
require("GeeSkid/_G_plyr_info")
require("GeeSkid/_G_interiors")
require("GeeSkid/_G_TP_pos_list")
require("GeeSkid/_G_Save")
require("GeeSkid/_G_plyrs_local")
require("GeeSkid/_G_plyrs_online")
require("GeeSkid/_G_veh_tables")
require("GeeSkid/_G_input_num_name")
require("GeeSkid/_G_utils")

if _G_GS_has_started then
	menu.notify("Gee-Skid loading cancelled.\nAlready loaded.",_G_GeeVer,10)
	return
elseif not menu.is_trusted_mode_enabled(1 << 2) then
	menu.notify("Gee-Skid loading cancelled.\nTrusted mode for natives required.",_G_GeeVer,10)
	return
end
_G_GeeVer = "GeeSkid v1.03"
_G_Ver = "v1.03"
_G_GS_has_started=true
_G_GS_has_loaded=false
_G_GS_type_input=false
_G_load_time = utils.time_ms()
local _G_load_time_temp = _G_load_time
print("--- ".._G_GeeVer..os.date("   %Y-%m-%d %H%M-%S ---"))

_G_GeeSkid = menu.add_feature("GeeSkid", "parent", 0)
_G_Self = menu.add_feature("Self", "parent", _G_GeeSkid.id)
	_G_TeleportSelf = menu.add_feature("Teleports", "parent", _G_Self.id)
		_G_TeleportSelfSeat = menu.add_feature("Auto-TP to seat in my veh", "parent", _G_TeleportSelf.id)
		_G_hold_key_tp_out = menu.add_feature("TP out of vehicle", "parent", _G_TeleportSelf.id)
		_G_hold_key_tp_in = menu.add_feature("TP into vehicle", "parent", _G_TeleportSelf.id)
		_G_auto_enter_veh = menu.add_feature("Instant-enter vehicles", "parent", _G_TeleportSelf.id)
	_G_Weapons = menu.add_feature("Weapons", "parent", _G_Self.id)
		_G_GeeEye = menu.add_feature("Gee-Eye", "parent", _G_Weapons.id, function()
			_G_GE_main.aim.frwd_foot_offst.hidden=_G_GE_main.aim.fire_pos.value==1
			_G_GE_main.aim.frwd_cam_offst.hidden=_G_GE_main.aim.fire_pos.value==0
		end)
		_G_GeeFlare = menu.add_feature("Gee-Flare", "parent", _G_GeeEye.id)
	_G_MyVehStuff = menu.add_feature("Vehicle", "parent", _G_Self.id)
		_G_PersonalVehicle = menu.add_feature("Personal Vehicle", "parent", _G_MyVehStuff.id)
		_G_LastVehicle = menu.add_feature("Last Vehicle", "parent", _G_MyVehStuff.id)
		_G_CurrentVehicle = menu.add_feature("Current Vehicle", "parent", _G_MyVehStuff.id)
			_G_VehAutoStuff = menu.add_feature("Automatic", "parent", _G_CurrentVehicle.id)
			_G_VehUpgrades = menu.add_feature("Upgrades", "parent", _G_CurrentVehicle.id)
				_G_VehPaintjob = menu.add_feature("Paintjob", "parent", _G_VehUpgrades.id)
					_G_VehPaintjobCustom = menu.add_feature("Custom RGB", "parent", _G_VehPaintjob.id)
				_G_VehHeadlights = menu.add_feature("Headlights", "parent", _G_VehUpgrades.id)
				_G_VehNeons = menu.add_feature("Neon Lights", "parent", _G_VehUpgrades.id)
			_G_GeeDriveStuff = menu.add_feature("Gee-Drive", "parent", _G_CurrentVehicle.id)
			_G_DriftMod = menu.add_feature("Driftmod v1.1", "parent", _G_CurrentVehicle.id)
				_G_Drift_O = menu.add_feature("DriftMod v1.1 Options", "parent", _G_DriftMod.id)
			_G_Disp_Veh_Info = menu.add_feature("Display vehicle info", "parent", _G_CurrentVehicle.id)
			_G_Disp_Cust_Plate = menu.add_feature("Custom plate", "parent", _G_CurrentVehicle.id)
	_G_SelfPed = menu.add_feature("Ped", "parent", _G_Self.id)		
_G_SessionStuff = menu.add_feature("Session", "parent", _G_GeeSkid.id)
	_G_Peds = menu.add_feature("Peds", "parent", _G_SessionStuff.id)
	_G_Players = menu.add_feature("Players/Vehicles", "parent", _G_SessionStuff.id)
	_G_Plyr_Kicks = menu.add_feature("Kicks", "parent", _G_SessionStuff.id)
_G_SpawnMyVehicle = menu.add_feature("Spawn Vehicle", "parent", _G_GeeSkid.id)
_G_Utilities = menu.add_feature("Utilities", "parent", _G_GeeSkid.id)
	_G_Information = menu.add_feature("Information", "parent", _G_Utilities.id)
		_G_Player_Overlay = menu.add_feature("Player Overlay", "parent", _G_Information.id)
		_G_GTA_map_parent = menu.add_feature("GTA Map","parent",_G_Information.id)
		_G_veh_esp_option = menu.add_feature("Vehicle ESP","parent",_G_Information.id)
		_G_AimProtex = menu.add_feature("Aim Display", "parent", _G_Information.id)
		_G_Leaderboard = menu.add_feature("Leaderboard", "parent", _G_Information.id)
		_G_LOS_parent = menu.add_feature("Players facing me", "parent", _G_Information.id)
		_G_Way_Point = menu.add_feature("Waypoint","parent",_G_Information.id)
		_G_2T1_radar = menu.add_feature("2T1 Radar v2.0","parent",_G_Information.id)
	_G_Traffic_Stuff = menu.add_feature("Traffic", "parent", _G_Utilities.id)
	_G_MainProtex = menu.add_feature("Protex", "parent", _G_Utilities.id)
		_G_VehGriefProtex = menu.add_feature("Vehicle Grief", "parent", _G_MainProtex.id)
		_G_SelfProtex = menu.add_feature("Aim Protex", "parent", _G_MainProtex.id)
		_G_Modder_Detex = menu.add_feature("Modder Detection", "parent", _G_MainProtex.id)
	_G_reticle=menu.add_feature("Custom reticle", "parent",_G_Utilities.id)
	_G_ClearArea = menu.add_feature("Clear area", "parent", _G_Utilities.id)
_G_Options = menu.add_feature("Options", "parent", _G_GeeSkid.id)
	_G_Watch_Boost_Options = menu.add_feature("Gee-Watch/Boost Options", "parent", _G_Options.id)
		_G_Watch_Boost_Display = menu.add_feature("Display Options", "parent", _G_Watch_Boost_Options.id)
		_G_Watch_hot_keys = menu.add_feature("Gee-Watch Hotkeys", "parent", _G_Watch_Boost_Options.id, function()
			_GF_G_W_keys_names_do()
		end)
	_G_veh_rpr_plate = menu.add_feature("Repair/Upgrade plate","parent",_G_Options.id, function()
		menu.notify("When repairing or upgrading a vehicle the plate will change to what you select here.",_G_GeeVer,7)
	end)

_G_GeeSkidP = menu.add_player_feature(_G_GeeVer, "parent", 0)
print("Main parents loaded       - "..(utils.time_ms()-_G_load_time_temp).."ms - Line: "..debug.getinfo(1).currentline)
_G_load_time_temp = utils.time_ms()
-----------------------------------------------------------------------------------------GEE-SKID
---------------------------------------------------------------------------------------------SELF
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------


_GT_rtcl={}
_GT_rtcl.sprt={}
_GT_rtcl.directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\reticle\\"
_GT_rtcl.files = utils.get_all_files_in_directory(_GT_rtcl.directory,"png")
_GT_rtcl.ent_bool=nil
for i=1,#_GT_rtcl.files do
	_GT_rtcl.sprt[i] = scriptdraw.register_sprite(_GT_rtcl.directory..i..".png")
end


_GT_rtcl.feat = menu.add_feature("Show reticle", "toggle", _G_reticle.id, function(f)
	local g_time,s_time,size = utils.time_ms(),utils.time_ms(),1
	while f.on do
		system.yield(5)
		if _GT_rtcl.shld_show() then
			if _GT_rtcl.rtcl_react.on then
				if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
					g_time = utils.time_ms()+125
					s_time = utils.time_ms()
					size=1
				end
				if g_time > utils.time_ms() or s_time > utils.time_ms() then
					if g_time > utils.time_ms() then size = size *1.01
					else size = size *.99
					end
				else size=1
				end
				if size >= 1.25 then
					s_time = utils.time_ms()+125
					g_time = utils.time_ms()
				end
			else
				size=1
			end
			if _GT_rtcl.ent_bool then 
				scriptdraw.draw_sprite(_GT_rtcl.sprt[_GT_rtcl.slct.value],v2(0,0),_GT_rtcl.size.value*size,0,_GF_RGBAToInt(_GT_rtcl.ent_r.value,_GT_rtcl.ent_g.value,_GT_rtcl.ent_b.value,_GT_rtcl.ent_a.value))
			else
				scriptdraw.draw_sprite(_GT_rtcl.sprt[_GT_rtcl.slct.value],v2(0,0),_GT_rtcl.size.value*size,0,_GF_RGBAToInt(_GT_rtcl.no_ent_r.value,_GT_rtcl.no_ent_g.value,_GT_rtcl.no_ent_b.value,_GT_rtcl.no_ent_a.value))
			end
		end
		_GT_rtcl.ent_bool=nil------future reference for gee-watch
	end
end)

function _GT_rtcl.shld_show()
	if _GT_rtcl.rtcl_slct.value==2 then
		_GT_rtcl.ent_bool=_GT_rtcl.is_ent()
		return true
	elseif player.is_player_free_aiming(player.player_id()) then
		if _GT_rtcl.rtcl_slct.value==1 then
			_GT_rtcl.ent_bool=_GT_rtcl.is_ent()
			return true
		end
		_GT_rtcl.ent_bool=_GT_rtcl.is_ent()
		return _GT_rtcl.ent_bool
	end
	return false
end

function _GT_rtcl.is_ent()
	local aim = player.get_entity_player_is_aiming_at(player.player_id())
	return (_GF_is_ent(aim) and entity.is_entity_a_ped(aim))
end

_GT_rtcl.splash=false
_GT_rtcl.slct = menu.add_feature("Select reticle", "autoaction_value_i", _G_reticle.id, function(f)
	if _G_GS_has_loaded then
		_GT_rtcl.splash=true
		_GT_rtcl.splash_feat.on=true
	end
end)_GF_set_feat_i_f(_GT_rtcl.slct,1,#_GT_rtcl.files,1,1)

_GT_rtcl.splash_feat=menu.add_feature("Show  reticles HIDDEN", "toggle", _G_reticle.id,function(f)
	local function get_int(_num)
		if _GT_rtcl.sprt[_GT_rtcl.slct.value+_num] ~= nil then
			return _GT_rtcl.sprt[_GT_rtcl.slct.value+_num]
		elseif _GT_rtcl.slct.value+_num > #_GT_rtcl.files then
			return _GT_rtcl.sprt[_GT_rtcl.slct.value+_num-#_GT_rtcl.files]
		end
		return _GT_rtcl.sprt[#_GT_rtcl.files+_GT_rtcl.slct.value+_num]
	end
	local time,alpha_t,x_pos,y_pos,alpha = utils.time_ms() + 4000,utils.time_ms() + 1000
	while time > utils.time_ms() do
		if _GT_rtcl.splash then
			_GT_rtcl.splash=false
			time = utils.time_ms() + 4000
			alpha_t = utils.time_ms() + 1000
		end
		if alpha_t > utils.time_ms() then
			alpha = 255
		else
			alpha = math.floor((time-utils.time_ms()) /1000/3*255)
		end
		x_pos=graphics.get_screen_width()/69000*_GT_rtcl.size.value
		y_pos=graphics.get_screen_height()/40000*_GT_rtcl.size.value
		for i=-3,3 do
			scriptdraw.draw_sprite(get_int(i),v2(0+(x_pos*i),0),_GT_rtcl.size.value,0,_GF_RGBAToInt(_GT_rtcl.no_ent_r.value,_GT_rtcl.no_ent_g.value,_GT_rtcl.no_ent_b.value,alpha))
		end
		scriptdraw.draw_line(v2(x_pos*-.5,y_pos),v2(x_pos*.5,y_pos), 1, _GF_RGBAToInt(255,0,0,alpha))
		scriptdraw.draw_line(v2(x_pos*.5,y_pos),v2(x_pos*.5,y_pos*-1), 1, _GF_RGBAToInt(255,0,0,alpha))
		scriptdraw.draw_line(v2(x_pos*.5,y_pos*-1),v2(x_pos*-.5,y_pos*-1), 1, _GF_RGBAToInt(255,0,0,alpha))
		scriptdraw.draw_line(v2(x_pos*-.5,y_pos*-1),v2(x_pos*-.5,y_pos), 1, _GF_RGBAToInt(255,0,0,alpha))
		if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then time = utils.time_ms() end
		system.yield(5)
	end
	f.on=false
end)_GT_rtcl.splash_feat.hidden=true

_GT_rtcl.size = menu.add_feature("Reticle size", "action_value_f", _G_reticle.id)
_GF_set_feat_i_f(_GT_rtcl.size,0.01,2,0.01,1)

_GT_rtcl.rtcl_slct=menu.add_feature("Conditions:", "action_value_str",_G_reticle.id)
_GT_rtcl.rtcl_slct:set_str_data({"Aiming at ped","If aiming","Always"})

_GT_rtcl.rtcl_react=menu.add_feature("Reactive", "toggle",_G_reticle.id)

_GT_rtcl.no_ent_r = menu.add_feature("R", "action_value_i",_G_reticle.id)
_GF_set_feat_i_f(_GT_rtcl.no_ent_r,0,255,5,255)

_GT_rtcl.no_ent_g = menu.add_feature("G", "action_value_i",_G_reticle.id)
_GF_set_feat_i_f(_GT_rtcl.no_ent_g,0,255,5,255)

_GT_rtcl.no_ent_b = menu.add_feature("B", "action_value_i",_G_reticle.id)
_GF_set_feat_i_f(_GT_rtcl.no_ent_b,0,255,5,255)

_GT_rtcl.no_ent_a = menu.add_feature("A", "action_value_i",_G_reticle.id)
_GF_set_feat_i_f(_GT_rtcl.no_ent_a,0,255,5,255)

_GT_rtcl.ent_prnt=menu.add_feature("Color while aiming at ped", "parent",_G_reticle.id)

_GT_rtcl.ent_r = menu.add_feature("R", "action_value_i",_GT_rtcl.ent_prnt.id)
_GF_set_feat_i_f(_GT_rtcl.ent_r,0,255,5,255)

_GT_rtcl.ent_g = menu.add_feature("G", "action_value_i",_GT_rtcl.ent_prnt.id)
_GF_set_feat_i_f(_GT_rtcl.ent_g,0,255,5,255)

_GT_rtcl.ent_b = menu.add_feature("B", "action_value_i",_GT_rtcl.ent_prnt.id)
_GF_set_feat_i_f(_GT_rtcl.ent_b,0,255,5,255)

_GT_rtcl.ent_a = menu.add_feature("A", "action_value_i",_GT_rtcl.ent_prnt.id)
_GF_set_feat_i_f(_GT_rtcl.ent_a,0,255,5,255)

_GT_spwn_veh = {}
_GT_spwn_veh.history = {}
_GT_spwn_veh.qck_srch_table = {}
_GT_spwn_veh.feat_srch_table = {}
_GT_spwn_veh.old_veh=nil

function _GT_spwn_veh.spwn_plate_write(_text,_file)
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	local file = io.open(directory.._file..".txt", "w")
	file:write(_text)
	file:close()
end

function _GT_spwn_veh.spwn_plate_get(_file)
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	local file = io.open(directory.._file..".txt", "r")
	local text = nil
	for line in file:lines() do
		if line ~= nil and string.len(tostring(line)) > 0 and string.len(tostring(line)) < 9 then
			text = tostring(line)
			break
		end
	end
	file:close()
	return text
end

function _GT_spwn_veh.spwn_plate_check(_file)
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	if not utils.dir_exists(directory) then
		utils.make_dir(directory)
	end
	if not utils.file_exists(directory.._file..".txt") then
		_GT_spwn_veh.spwn_plate_write("GeeSpawn",_file)
	end
	local text = _GT_spwn_veh.spwn_plate_get(_file)
	if text == nil then
		_GT_spwn_veh.spwn_plate_write("GeeSpawn",_file)
	end
end
_GT_spwn_veh.spwn_plate_check("spwn_self")
_GT_spwn_veh.spwn_plate_txt = _GT_spwn_veh.spwn_plate_get("spwn_self")

function _GT_spwn_veh.quick_spawn_write(_text)
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\quick_spawn\\"
	local file = io.open(directory.."spawn_list.txt", "w")
	file:write(_text)
	file:close()
end

function _GT_spwn_veh.quick_spawn_get()
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\quick_spawn\\"
	local file = io.open(directory.."spawn_list.txt", "r")
	local list = {}
	for line in file:lines() do
		if streaming.is_model_valid(gameplay.get_hash_key(line)) then
			list[#list+1] = line
		end
	end
	file:close()
	return list
end

function _GT_spwn_veh.quick_spawn_check()
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\quick_spawn\\"
	if not utils.dir_exists(directory) then
		utils.make_dir(directory)
	end
	if not utils.file_exists(directory.."spawn_list.txt") then
		_GT_spwn_veh.quick_spawn_write(_GT_spwn_veh.quick_spawn_default)
	end
	local list = _GT_spwn_veh.quick_spawn_get()
	if #list == 0 then
		_GT_spwn_veh.quick_spawn_write(_GT_spwn_veh.quick_spawn_default)
	end
end

_GT_spwn_veh.quick_spawn_default = ""

_GT_spwn_veh.quick_spawn_default_table={
"oppressor",
"oppressor2",
"deluxo",
"toreador",
"rhino",
"khanjali",
"menacer",
"nightshark",
"insurgent3",
"phantom2",
"dune4",
"buzzard",
"savage",
"akula",
"hunter",
"nokota",
"seabreeze",
"rogue",
"molotok",
"strikeforce",
"hydra",
"lazer",
}

for i=1,#_GT_spwn_veh.quick_spawn_default_table do
	_GT_spwn_veh.quick_spawn_default=_GT_spwn_veh.quick_spawn_default.._GT_spwn_veh.quick_spawn_default_table[i].."\n"
end

_GT_spwn_veh.quick_spawn_check()
_GT_spwn_veh.quick_spawn_list = _GT_spwn_veh.quick_spawn_get() --had plans to make this update-able in game

function _GT_spwn_veh.apply_upgrades(_veh)
	if _GF_is_ent(_veh) then
		_GF_ask_cntrl(_veh)
		vehicle.set_vehicle_mod_kit_type(_veh, 0)
		if _GT_spwn_veh.spwn_god.on then
			entity.set_entity_god_mode(_veh,true)
		end
		if _GT_spwn_veh.spwn_upg.on then
			if _GT_spwn_veh.spwn_upg.value == 0 then
				_GF_veh_upgr_basic(_veh)
				_GF_veh_upgr_perf(_veh)
				_GF_veh_upgr_wheels(_veh)			
				_GF_veh_upgr_lights(_veh,"random")
				_GF_veh_upgr_neons(_veh,"random")
				_GF_veh_upgr_paint(_veh,"random")
				_GF_veh_upgr_livery(_veh)
				_GF_veh_best_weap(_veh)
				_GF_veh_upgrades_kek_bombs_simple(_veh)
				_GF_veh_upgrades_kek_countrm_simple(_veh)
			else
				_GF_veh_upgr_perf(_veh)
			end
		end
		if _GT_spwn_veh.spwn_f1.on then
			_GF_veh_upgr_wheels(_veh,"f1")	
		end
		entity.set_entity_max_speed(_veh, 45000)
		vehicle.modify_vehicle_top_speed(_veh, (_GT_spwn_veh.spwn_spd_tq.value/100 - 1) * 100)
		if _GT_spwn_veh.spwn_rand_paint.on then
			if _GT_spwn_veh.spwn_rand_paint.value == 0 then
				_GF_veh_upgr_paint(_veh,"random")
			elseif _GT_spwn_veh.spwn_rand_paint.value == 1 then
				_GF_veh_upgr_paint(_veh,"random_solid")
			elseif _GT_spwn_veh.spwn_rand_paint.value == 2 then
				_GF_veh_upgr_paint(_veh,_GF_rand_paint_shade("Dark")) 
			else
				_GF_veh_upgr_paint(_veh,_GF_rand_paint_shade("Bright")) 
			end
		elseif _GT_spwn_veh.spwn_cust_paint.value == 0 then
			_GF_veh_upgr_paint(_veh,(_GT_spwn_veh.spwn_cust_paint_r.value * 65536 + _GT_spwn_veh.spwn_cust_paint_g.value * 256 + _GT_spwn_veh.spwn_cust_paint_b.value)) 
		else
			_GF_veh_upgr_paint(_veh,_GT_spwn_veh.paint_list_slct)
		end
		if _GT_spwn_veh.neon.choose.value == 0 then
			_GF_veh_upgr_neons(_veh,"random")
		else
			_GF_veh_upgr_neons(_veh,_GT_spwn_veh.neon_slct)
		end
		if _GT_spwn_veh.h_light.choose.value == 0 then
			_GF_veh_upgr_lights(_veh,"random")
		else
			_GF_veh_upgr_lights(_veh,_GT_spwn_veh.h_light_slct)
		end
		if _GT_spwn_veh.spwn_max_tint.on then
			vehicle.set_vehicle_window_tint(_veh,1)
		end
		if _GT_spwn_veh.spwn_invcn_wind.on then
			_GF_set_invncbl_wndws(_veh,true)
		end
		if _GT_spwn_veh.spwn_in_veh.on then
			ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()),_veh,-1)
		end
		if _GT_spwn_veh.spwn_plate_i.on then
			vehicle.set_vehicle_number_plate_index(_veh, _GT_spwn_veh.spwn_plate_i.value)
		end
		if _GT_spwn_veh.spwn_plate.on then
			vehicle.set_vehicle_number_plate_text(_veh, _GT_spwn_veh.spwn_plate_txt )
		end
		system.yield(0)
		if _GT_spwn_veh.remove_old.on and _GF_is_ent(_GT_spwn_veh.old_veh) then
			_GF_kick_all_from_veh(_GT_spwn_veh.old_veh,false)
			_GF_remove_ent(_GT_spwn_veh.old_veh,1000)
		end
		_GT_spwn_veh.old_veh=_veh
		_GT_spwn_veh.history[#_GT_spwn_veh.history+1]=_veh
	end
end

_GT_spwn_veh.optns_prnt=menu.add_feature("Options", "parent", _G_SpawnMyVehicle.id)
	
_GT_spwn_veh.mk_mdl_clss_prnt=menu.add_feature("All vehicles by type", "parent", _G_SpawnMyVehicle.id)
_GT_spwn_veh.temp_list_sort = {}
for i=1,#_GT_class_str_list do
	_GT_spwn_veh.temp_list_sort[i]={}
	for ii=1,#_GT_all_veh_info do
		if _GT_all_veh_info[ii][6] == _GT_class_str_list[i] then
			_GT_spwn_veh.temp_list_sort[i][#_GT_spwn_veh.temp_list_sort[i]+1]=_GT_all_veh_info[ii]
		end
	end
	table.sort(_GT_spwn_veh.temp_list_sort[i], function(a, b) return a[1]:lower() <  b[1]:lower() end)
end
for i=1,#_GT_class_str_list do
	_GT_spwn_veh.feat_srch_table[#_GT_spwn_veh.feat_srch_table+1] = menu.add_feature(_GT_class_str_list[i], "parent",_GT_spwn_veh.mk_mdl_clss_prnt.id)
	for ii=1,#_GT_spwn_veh.temp_list_sort[i] do
		_GT_spwn_veh.temp_list_name = ""
		if _GT_spwn_veh.temp_list_sort[i][ii][2] == "" then
			_GT_spwn_veh.temp_list_name = _GT_spwn_veh.temp_list_sort[i][ii][1]
		else
			_GT_spwn_veh.temp_list_name = _GT_spwn_veh.temp_list_sort[i][ii][1].." - ".._GT_spwn_veh.temp_list_sort[i][ii][2]
		end
		menu.add_feature(_GT_spwn_veh.temp_list_name, "action", _GT_spwn_veh.feat_srch_table[i].id,function()
			if _GT_spwn_veh.remove_old.on and _GF_request_ctrl(_GT_spwn_veh.old_veh,250) then
				entity.set_entity_as_no_longer_needed(_GT_spwn_veh.old_veh)
				entity.delete_entity(_GT_spwn_veh.old_veh)
			end
			_GF_req_stream_hash(_GT_spwn_veh.temp_list_sort[i][ii][5])
			local veh = _GF_spawn_veh_at_pid_frnt(player.player_id(),_GT_spwn_veh.temp_list_sort[i][ii][5],false,_GT_spwn_veh.spwn_front.value==0)
			_GT_spwn_veh.apply_upgrades(veh)
		end)
	end
end
_GT_spwn_veh.mk_mdl_srch_prnt=menu.add_feature("Make/Model search list", "parent", _G_SpawnMyVehicle.id)

_GT_spwn_veh.quick_spwn_prnt=menu.add_feature("Quick spawn list", "parent", _G_SpawnMyVehicle.id)

_GT_spwn_veh.quick_spawn_feats = {}
for i=1, #_GT_spwn_veh.quick_spawn_list do
	for ii=1, #_GT_all_veh_info do
		if _GT_all_veh_info[ii][5] == gameplay.get_hash_key(_GT_spwn_veh.quick_spawn_list[i]) then
			_GT_spwn_veh.quick_spawn_feats[i]=menu.add_feature(_GT_all_veh_info[ii][1], "action", _GT_spwn_veh.quick_spwn_prnt.id,function()
				if _GT_spwn_veh.remove_old.on and _GF_request_ctrl(_GT_spwn_veh.old_veh,250) then
					entity.set_entity_as_no_longer_needed(_GT_spwn_veh.old_veh)
					entity.delete_entity(_GT_spwn_veh.old_veh)
				end
				_GF_req_stream_hash(_GT_all_veh_info[ii][5])
				local veh = _GF_spawn_veh_at_pid_frnt(player.player_id(),_GT_all_veh_info[ii][5],false,_GT_spwn_veh.spwn_front.value==0)
				_GT_spwn_veh.apply_upgrades(veh)
			end)
			break
		end
	end
end

menu.add_feature("Quick search on-screen", "action", _G_SpawnMyVehicle.id, function(f)
	_GT_spwn_veh.quick_start(_GT_spwn_veh.qck_srch_table,"Vehicle Spawn - Self",false)
end)
	
_GT_spwn_veh.mk_mdl_search_feat = {}
_GT_spwn_veh.mk_mdl_search_temp = {}
_G_spawn_veh_search_do=menu.add_feature("Search for vehicles", "action_value_str", _GT_spwn_veh.mk_mdl_srch_prnt.id, function(f)
	local status,str,veh = 1
	status,str = _GF_text_input_get("Vehicle Make/Model","",25,0)
	if status == 0 then
		_GT_spwn_veh.mk_mdl_search_temp = {}
		_GT_spwn_veh.ovrly_srch_do(str,f.value,_GT_spwn_veh.mk_mdl_search_temp)
		if #_GT_spwn_veh.mk_mdl_search_temp > 0 then
			for i=1,#_GT_spwn_veh.mk_mdl_search_feat do
				system.yield(0)
				if _GT_spwn_veh.mk_mdl_search_feat[i] ~= nil then menu.delete_feature(_GT_spwn_veh.mk_mdl_search_feat[i].id) end
			end
			_GT_spwn_veh.mk_mdl_search_feat = {}
			for i=1,#_GT_spwn_veh.mk_mdl_search_temp do
				if f.value == 0 then
					_GT_spwn_veh.mk_mdl_search_feat[#_GT_spwn_veh.mk_mdl_search_feat+1]=menu.add_feature(_GT_spwn_veh.mk_mdl_search_temp[i][1], "action", _GT_spwn_veh.mk_mdl_srch_prnt.id,function()
						if _GT_spwn_veh.remove_old.on and _GF_request_ctrl(_GT_spwn_veh.old_veh,250) then
							entity.set_entity_as_no_longer_needed(_GT_spwn_veh.old_veh)
							entity.delete_entity(_GT_spwn_veh.old_veh)
						end
						_GF_req_stream_hash(_GT_spwn_veh.mk_mdl_search_temp[i][5])
						local veh = _GF_spawn_veh_at_pid_frnt(player.player_id(),_GT_spwn_veh.mk_mdl_search_temp[i][5],false,_GT_spwn_veh.spwn_front.value==0)
						_GT_spwn_veh.apply_upgrades(veh)
					end)
				else
					_GT_spwn_veh.mk_mdl_search_feat[#_GT_spwn_veh.mk_mdl_search_feat+1]=menu.add_feature(_GT_spwn_veh.mk_mdl_search_temp[i][3], "action", _GT_spwn_veh.mk_mdl_srch_prnt.id,function()
						if _GT_spwn_veh.remove_old.on and _GF_request_ctrl(_GT_spwn_veh.old_veh,250) then
							entity.set_entity_as_no_longer_needed(_GT_spwn_veh.old_veh)
							entity.delete_entity(_GT_spwn_veh.old_veh)
						end
						_GF_req_stream_hash(_GT_spwn_veh.mk_mdl_search_temp[i][5])
						local veh = _GF_spawn_veh_at_pid_frnt(player.player_id(),_GT_spwn_veh.mk_mdl_search_temp[i][5],false,_GT_spwn_veh.spwn_front.value==0)
						_GT_spwn_veh.apply_upgrades(veh)
					end)
				end
			end
		end
	end
end)_G_spawn_veh_search_do.set_str_data(_G_spawn_veh_search_do,{"Model", "Make","Make or Model"})

_GT_spwn_veh.qck_srch_optns = menu.add_feature("Quick Search Options", "parent", _GT_spwn_veh.optns_prnt.id)
menu.add_feature("Display 'quick search' test", "action", _GT_spwn_veh.qck_srch_optns.id, function()
	local time = utils.time_ms() + 10000
	local _table = {}
	for i=1,7 do
		_table[i] = _GT_all_veh_info[math.random(1,#_GT_all_veh_info)]
	end
	while time > utils.time_ms() do
		system.yield(0)
		_GT_spwn_veh.ovrly_srch_show(_table, "Vehicle test - Self ".._GF_round_num((time - utils.time_ms())/1000),0,_GF_veh_spawn_quick_x.value/300, _GF_veh_spawn_quick_y.value/300,false)
	end
end)
_GF_veh_spawn_quick_x = menu.add_feature("Quick search X Pos", "action_slider", _GT_spwn_veh.qck_srch_optns.id, function()
end)_GF_set_feat_i_f(_GF_veh_spawn_quick_x,0,300,1,150)

_GF_veh_spawn_quick_y = menu.add_feature("Quick search Y Pos", "action_slider", _GT_spwn_veh.qck_srch_optns.id, function()
end)_GF_set_feat_i_f(_GF_veh_spawn_quick_y,0,300,1,135)

_GT_spwn_veh.spwn_in_veh = menu.add_feature("Spawn in vehicle", "toggle", _GT_spwn_veh.optns_prnt.id)
_GT_spwn_veh.spwn_upg = menu.add_feature("Upgrades", "value_str", _GT_spwn_veh.optns_prnt.id)
_GT_spwn_veh.spwn_upg:set_str_data({"All","Only performance"})
_GT_spwn_veh.spwn_upg.on=true
_GT_spwn_veh.spwn_f1 = menu.add_feature("Always F1 Wheels", "toggle", _GT_spwn_veh.optns_prnt.id)
_GT_spwn_veh.spwn_god = menu.add_feature("God-Mode", "toggle", _GT_spwn_veh.optns_prnt.id)
_GT_spwn_veh.spwn_max_tint = menu.add_feature("Max tint", "toggle", _GT_spwn_veh.optns_prnt.id)
_GT_spwn_veh.spwn_invcn_wind = menu.add_feature("Invincible windows", "toggle", _GT_spwn_veh.optns_prnt.id)

_GT_spwn_veh.spwn_plate_i=menu.add_feature("Plate color", "value_str", _GT_spwn_veh.optns_prnt.id)
_GT_spwn_veh.spwn_plate_i:set_str_data({"Blue/White","Yellow/black","Yellow/Blue","Blue/White2","Blue/White3","Yankton"})
_GT_spwn_veh.spwn_plate_i.value=1
_GT_spwn_veh.spwn_plate_i.on=true

_GT_spwn_veh.spwn_plate = menu.add_feature("Plate text - ".._GT_spwn_veh.spwn_plate_txt, "toggle", _GT_spwn_veh.optns_prnt.id,function(f)
	if f.on and _G_GS_has_loaded then
		local status,str = 1,""
		status,str = _GF_text_input_get("Non alpha-numeric characters act as blank space",_GT_spwn_veh.spwn_plate_txt,8,0)
		if status == 0 then
			_GT_spwn_veh.spwn_plate_check("spwn_self")
			_GT_spwn_veh.spwn_plate_write(str,"spwn_self")
			_GT_spwn_veh.spwn_plate_txt=str
			f.name="Plate text - ".._GT_spwn_veh.spwn_plate_txt
		else
			f.on=false
		end
	end
end)
_GT_spwn_veh.spwn_plate.on=true

_GT_spwn_veh.remove_old = menu.add_feature("Remove previous vehicle", "toggle", _GT_spwn_veh.optns_prnt.id)
_GT_spwn_veh.spwn_front=menu.add_feature("Spawn using heading of my: ", "action_value_str", _GT_spwn_veh.optns_prnt.id)
_GT_spwn_veh.spwn_front:set_str_data({"Cam","Ped"})

_GT_spwn_veh.spwn_spd_tq=menu.add_feature("Vehicle max speed/torque %","action_value_i", _GT_spwn_veh.optns_prnt.id,function()
end)_GF_set_feat_i_f(_GT_spwn_veh.spwn_spd_tq,0,700,5,100)	

_GT_spwn_veh.paint_prnt = menu.add_feature("Paint", "parent", _GT_spwn_veh.optns_prnt.id, function ()
	_GT_spwn_veh.hide_paint(true)
end)

function _GT_spwn_veh.hide_paint(_bool)
	system.yield(0)
	if _bool then
		for _,feat in pairs(_GT_spwn_veh.paint_list) do
			feat.hidden=(not _GT_spwn_veh.spwn_cust_paint.on or _GT_spwn_veh.spwn_cust_paint.value==0)
		end
		_GT_spwn_veh.spwn_cust_paint_r.hidden=(not _GT_spwn_veh.spwn_cust_paint.on or _GT_spwn_veh.spwn_cust_paint.value==1)
		_GT_spwn_veh.spwn_cust_paint_g.hidden=(not _GT_spwn_veh.spwn_cust_paint.on or _GT_spwn_veh.spwn_cust_paint.value==1)
		_GT_spwn_veh.spwn_cust_paint_b.hidden=(not _GT_spwn_veh.spwn_cust_paint.on or _GT_spwn_veh.spwn_cust_paint.value==1)
	end
end

_GT_spwn_veh.spwn_rand_paint = menu.add_feature("Random paint", "value_str", _GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.spwn_cust_paint.on=not f.on
	_GT_spwn_veh.hide_paint(f.on)
end)_GT_spwn_veh.spwn_rand_paint:set_str_data({"Non-matching", "Matching","Dark","Bright"})
_GT_spwn_veh.spwn_rand_paint.on=true

_GT_spwn_veh.spwn_cust_paint = menu.add_feature("Custom paint", "value_str", _GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.spwn_rand_paint.on=not f.on
	_GT_spwn_veh.hide_paint(f.on)
end)_GT_spwn_veh.spwn_cust_paint:set_str_data({"RGB","List"})

_GT_spwn_veh.spwn_cust_paint_r=menu.add_feature("Custom Red","autoaction_value_i",_GT_spwn_veh.paint_prnt.id)
_GF_set_feat_i_f(_GT_spwn_veh.spwn_cust_paint_r,0,255,1,0)

_GT_spwn_veh.spwn_cust_paint_g=menu.add_feature("Custom Green","autoaction_value_i",_GT_spwn_veh.paint_prnt.id)
_GF_set_feat_i_f(_GT_spwn_veh.spwn_cust_paint_g,0,255,1,0)

_GT_spwn_veh.spwn_cust_paint_b=menu.add_feature("Custom Blue","autoaction_value_i",_GT_spwn_veh.paint_prnt.id)
_GF_set_feat_i_f(_GT_spwn_veh.spwn_cust_paint_b,0,255,1,0)

function _GT_spwn_veh.paint_tog_do(_bool,_feat,_paint)
	if _bool then
		_GT_spwn_veh.paint_list_slct=_paint
		for _, feat in pairs(_GT_spwn_veh.paint_list) do
			if feat ~=_feat then
				feat.on = false
			end
		end
	end
end

_GT_spwn_veh.paint_list_slct = nil
_GT_spwn_veh.paint_list={}

_GT_spwn_veh.paint_list.pnt_Purewhite=menu.add_feature("Pure white","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Purewhite,16777215)
end)
_GT_spwn_veh.paint_list.pnt_White=menu.add_feature("White","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_White,13487565)
end)
_GT_spwn_veh.paint_list.pnt_Cream=menu.add_feature("Cream","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Cream,10197915)
end)
_GT_spwn_veh.paint_list.pnt_Grey=menu.add_feature("Grey","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Grey,5066061)
end)
_GT_spwn_veh.paint_list.pnt_Black=menu.add_feature("Black","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Black,0)
end)
_GT_spwn_veh.paint_list.pnt_PastelPink=menu.add_feature("Pastel Pink","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_PastelPink,15767961)
end)
_GT_spwn_veh.paint_list.pnt_Pink=menu.add_feature("Pink","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Pink,13317780)
end)
_GT_spwn_veh.paint_list.pnt_PinkRed=menu.add_feature("Pink/Red","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_PinkRed,14692914)
end)
_GT_spwn_veh.paint_list.pnt_WineRed=menu.add_feature("Wine Red","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_WineRed,3014656)
end)
_GT_spwn_veh.paint_list.pnt_Red=menu.add_feature("Red","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Red,7346457)
end)
_GT_spwn_veh.paint_list.pnt_BrightRed=menu.add_feature("Bright Red","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_BrightRed,16711680)
end)
_GT_spwn_veh.paint_list.pnt_Salmon=menu.add_feature("Salmon","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Salmon,16761514)
end)
_GT_spwn_veh.paint_list.pnt_BrightBlue=menu.add_feature("Bright Blue","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_BrightBlue,56306)
end)
_GT_spwn_veh.paint_list.pnt_LightBlue=menu.add_feature("Light Blue","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_LightBlue,6141669)
end)
_GT_spwn_veh.paint_list.pnt_Teal=menu.add_feature("Teal","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Teal,3103859)
end)
_GT_spwn_veh.paint_list.pnt_RoyalBlue=menu.add_feature("Royal Blue","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_RoyalBlue,18309)
end)
_GT_spwn_veh.paint_list.pnt_CreamYellow=menu.add_feature("Cream Yellow","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_CreamYellow,16706473)
end)
_GT_spwn_veh.paint_list.pnt_Yellow=menu.add_feature("Yellow","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Yellow,15779920)
end)
_GT_spwn_veh.paint_list.pnt_Mustard=menu.add_feature("Mustard","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Mustard,8284969)
end)
_GT_spwn_veh.paint_list.pnt_Brightyellow=menu.add_feature("Bright yellow","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Brightyellow,16757504)
end)
_GT_spwn_veh.paint_list.pnt_Schoolbus=menu.add_feature("Schoolbus","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_Schoolbus,16750350)
end)
_GT_spwn_veh.paint_list.pnt_DarkOrange=menu.add_feature("Dark Orange","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_DarkOrange,8340010)
end)
_GT_spwn_veh.paint_list.pnt_CreamGreen=menu.add_feature("Cream Green","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_CreamGreen,12183225)
end)
_GT_spwn_veh.paint_list.pnt_LightGreen=menu.add_feature("Light Green","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_LightGreen,7523442)
end)
_GT_spwn_veh.paint_list.pnt_BrightGreen=menu.add_feature("Bright Green","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_BrightGreen,2803792)
end)
_GT_spwn_veh.paint_list.pnt_DarkGreen=menu.add_feature("Dark Green","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_DarkGreen,3761721)
end)
_GT_spwn_veh.paint_list.pnt_CreamPurple=menu.add_feature("Cream Purple","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_CreamPurple,12628975)
end)
_GT_spwn_veh.paint_list.pnt_BrightPurple=menu.add_feature("Bright Purple","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_BrightPurple,8677090)
end)
_GT_spwn_veh.paint_list.pnt_DarkPurple=menu.add_feature("Dark Purple","toggle",_GT_spwn_veh.paint_prnt.id,function(f)
	_GT_spwn_veh.paint_tog_do(f.on,_GT_spwn_veh.paint_list.pnt_DarkPurple,4405615)
end)
_GT_spwn_veh.paint_list.pnt_DarkGreen.on=true

_GT_spwn_veh.neon = {}
_GT_spwn_veh.neon.list={}
_GT_spwn_veh.neon_slct=nil 
function _GT_spwn_veh.neon_tog_do(_bool,_feat,_neon)
	if _bool then
		_GT_spwn_veh.neon_slct=_neon
		for _, feat in pairs(_GT_spwn_veh.neon.list) do
			if feat ~=_feat then
				feat.on = false
			end
		end
	end
end

function _GT_spwn_veh.hide_neon(_bool)
	system.yield(0)
	if _bool then
		for _, feat in pairs (_GT_spwn_veh.neon.list) do
			feat.hidden=(_GT_spwn_veh.neon.choose.value==0)
		end
	end
end

_GT_spwn_veh.neon.prnt = menu.add_feature("Neon lights", "parent", _GT_spwn_veh.optns_prnt.id, function (f)
	_GT_spwn_veh.hide_neon(_GT_spwn_veh.neon.choose.value==0)
end)


_GT_spwn_veh.neon.choose=menu.add_feature("Neon color","autoaction_value_str",_GT_spwn_veh.neon.prnt.id,function(f)
	_GT_spwn_veh.hide_neon(true)
end)_GT_spwn_veh.neon.choose:set_str_data({"Random","List"})

_GT_spwn_veh.neon.list.White=menu.add_feature("White", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.White,4292796159)
end)
_GT_spwn_veh.neon.list.Blue=menu.add_feature("Blue", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.Blue,4278326783)
end)
_GT_spwn_veh.neon.list.ElectricBlue=menu.add_feature("Electric Blue", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.ElectricBlue,4278408191)
end)
_GT_spwn_veh.neon.list.MintGreen=menu.add_feature("Mint Green", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.MintGreen,4278255500)
end)
_GT_spwn_veh.neon.list.LimeGreen=menu.add_feature("Lime Green", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.LimeGreen,4284415745)
end)
_GT_spwn_veh.neon.list.Yellow=menu.add_feature("Yellow", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.Yellow,4294967040)
end)
_GT_spwn_veh.neon.list.GoldenShower=menu.add_feature("Golden Shower", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.GoldenShower,4294940165)
end)
_GT_spwn_veh.neon.list.Orange=menu.add_feature("Orange", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.Orange,4294917632)
end)
_GT_spwn_veh.neon.list.Red=menu.add_feature("Red", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.Red,4294902017)
end)
_GT_spwn_veh.neon.list.PonyPink=menu.add_feature("Pony Pink", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.PonyPink,4294914660)
end)
_GT_spwn_veh.neon.list.HotPink=menu.add_feature("Hot Pink", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.HotPink,4294903230)
end)
_GT_spwn_veh.neon.list.Purple=menu.add_feature("Purple", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.Purple,4280484351)
end)
_GT_spwn_veh.neon.list.BlackLight=menu.add_feature("Black Light", "toggle", _GT_spwn_veh.neon.prnt.id, function (f)
	_GT_spwn_veh.neon_tog_do(f.on,_GT_spwn_veh.neon.list.BlackLight,4279174143)
end)
_GT_spwn_veh.neon.list.MintGreen.on=true

_GT_spwn_veh.h_light={}
_GT_spwn_veh.h_light.list={}
_GT_spwn_veh.h_light_slct=nil 

function _GT_spwn_veh.h_light_tog_do(_bool,_feat,_h_light)
	if _bool then
		_GT_spwn_veh.h_light_slct=_h_light
		for _, feat in pairs(_GT_spwn_veh.h_light.list) do
			if feat ~=_feat then
				feat.on = false
			end
		end
	end
end

function _GT_spwn_veh.hide_h_light(_bool)
	system.yield(0)
	if _bool then
		for _, feat in pairs (_GT_spwn_veh.h_light.list) do
			feat.hidden=(_GT_spwn_veh.h_light.choose.value==0)
		end
	end
end

_GT_spwn_veh.h_light.prnt = menu.add_feature("Headlights", "parent", _GT_spwn_veh.optns_prnt.id, function (f)
	_GT_spwn_veh.hide_h_light(_GT_spwn_veh.h_light.choose.value==0)
end)


_GT_spwn_veh.h_light.choose=menu.add_feature("Headlight color","autoaction_value_str",_GT_spwn_veh.h_light.prnt.id,function(f)
	_GT_spwn_veh.hide_h_light(true)
end)_GT_spwn_veh.h_light.choose:set_str_data({"Random","List"})

_GT_spwn_veh.h_light.list.White=menu.add_feature("White", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.White,0)
end)
_GT_spwn_veh.h_light.list.Blue=menu.add_feature("Blue", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.Blue,1)
end)
_GT_spwn_veh.h_light.list.ElectricBlue=menu.add_feature("Electric Blue", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.ElectricBlue,2)
end)
_GT_spwn_veh.h_light.list.MintGreen=menu.add_feature("Mint Green", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.MintGreen,3)
end)
_GT_spwn_veh.h_light.list.LimeGreen=menu.add_feature("Lime Green", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.LimeGreen,4)
end)
_GT_spwn_veh.h_light.list.Yellow=menu.add_feature("Yellow", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.Yellow,5)
end)
_GT_spwn_veh.h_light.list.GoldenShower=menu.add_feature("Golden Shower", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.GoldenShower,6)
end)
_GT_spwn_veh.h_light.list.Orange=menu.add_feature("Orange", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.Orange,7)
end)
_GT_spwn_veh.h_light.list.Red=menu.add_feature("Red", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.Red,8)
end)
_GT_spwn_veh.h_light.list.PonyPink=menu.add_feature("Pony Pink", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.PonyPink,9)
end)
_GT_spwn_veh.h_light.list.HotPink=menu.add_feature("Hot Pink", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.HotPink,10)
end)
_GT_spwn_veh.h_light.list.Purple=menu.add_feature("Purple", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.Purple,11)
end)
_GT_spwn_veh.h_light.list.BlackLight=menu.add_feature("Black Light", "toggle", _GT_spwn_veh.h_light.prnt.id, function (f)
	_GT_spwn_veh.h_light_tog_do(f.on,_GT_spwn_veh.h_light.list.BlackLight,12)
end)
_GT_spwn_veh.h_light.list.MintGreen.on=true

function _GT_spwn_veh.ovrly_srch_do(_str,_type,_table)
	for i=1,#_GT_all_veh_info do
		if #_table < 50 then
			if _type == 0 then
				if string.match(string.lower(_GT_all_veh_info[i][1]), string.lower(_str)) ~= nil then
					_table[#_table+1]= _GT_all_veh_info[i]
				end
			elseif _type == 1 then
				if string.match(string.lower(_GT_all_veh_info[i][2]), string.lower(_str)) ~= nil then
					_table[#_table+1]= _GT_all_veh_info[i]
				end
			elseif string.match(string.lower(_GT_all_veh_info[i][3]), string.lower(_str)) ~= nil then
				_table[#_table+1]= _GT_all_veh_info[i]
			end
		end
	end
	if #_table > 1 then
		if _type == 0 then
			table.sort(_table, function(a, b) return a[1]:lower() <  b[1]:lower() end)
		else
			table.sort(_table, function(a, b) return a[3]:lower() <  b[3]:lower() end)
		end
	end
end

function _GT_spwn_veh.ovrly_srch_show(_table,_title,selection,x_val_box,y_val,_session)
	ui.draw_rect(x_val_box, y_val+0.0072, 0.1,0.0175, 0, 0, 0, 155)
	_GF_overlay(_title,75,150,75,255,.2,0,x_val_box,y_val)
	y_val=y_val+0.0171
	if _session then
		ui.draw_rect(x_val_box, y_val+0.0072, 0.1,0.0175, 0, 0, 0, 155)
		_GF_overlay(_GF_session_plyr_count_str(),75,150,75,255,.2,0,0.5,y_val)
		y_val=y_val+0.0171
	end
	for i=1, #_table do
		if i < 8 then
			ui.draw_rect(x_val_box, y_val+0.0072, 0.1,0.0175, 0, 0, 0, 155)
			if i == selection then
				ui.draw_rect(x_val_box, y_val+0.0072, 0.1,0.017, 155, 155, 155, 155)
			end
			_GF_overlay_left(i.."  ".._table[i][1],255,255,255,255,.2,0,x_val_box-0.045,y_val)
			y_val=y_val+0.0171
		end
	end
end

function _GT_spwn_veh.quick_start(_table,_title,_session)
	local status,num_name,str,y_val,x_val_box,selection,name,veh = 1,"",""
	local search,key_time=true,utils.time_ms()
	_table = {}
	status, str = _GF_text_input_get(_title,"",25,0)
	local function key_press(_key)
		if utils.time_ms() > key_time and _GF_vk_key_down(_key) then
			key_time = utils.time_ms() + 100
			return true
		end
		return false
	end
	if status == 0 then
		_GT_spwn_veh.ovrly_srch_do(str,0,_table)
		if #_table > 0 then
			for i=1, #_table do
				if i > 7 then _table[i]=nil end
			end
			selection = 1
			if _session then
				y_val = _GT_sssn_stf.new.quick_y.value/300
				x_val_box = _GT_sssn_stf.new.quick_x.value/300
			else
				y_val = _GF_veh_spawn_quick_y.value/300
				x_val_box = _GF_veh_spawn_quick_x.value/300
			end
			while search do
				system.yield(0)
				 _GT_spwn_veh.ovrly_srch_show(_table,_title,selection,x_val_box,y_val,_session)
				if _GF_key_active(14,1) or controls.is_control_just_pressed(1, 187) or key_press("S") then
					if _table[selection+1] ~= nil then selection = selection+1
					else selection = 1
					end
				elseif _GF_key_active(15,1) or controls.is_control_just_pressed(1, 188) or key_press("W") then
					if _table[selection-1] ~= nil then selection = selection-1
					else selection = #_table
					end
				end
				for i=1,#_GT_vk_spawn_1_7 do
					if _GF_vk_key_down(_GT_vk_spawn_1_7[i]) and _table[i] ~= nil then
						if _session then
							_GF_session_veh_spawn_do(_table[i][5])
						else
							if _GT_spwn_veh.remove_old.on and _GF_request_ctrl(_GT_spwn_veh.old_veh,250) then
								entity.set_entity_as_no_longer_needed(_GT_spwn_veh.old_veh)
								entity.delete_entity(_GT_spwn_veh.old_veh)
							end
							_GF_req_stream_hash(_table[i][5])
							veh = _GF_spawn_veh_at_pid_frnt(player.player_id(),_table[i][5],false,_GT_spwn_veh.spwn_front.value==0)
							_GT_spwn_veh.apply_upgrades(veh)
						end
						search = false
						break
					end
				end
				if _GF_vk_key_down("RETURN") then
					if _session then
						_GF_session_veh_spawn_do(_table[selection][5])
					else
						if _GT_spwn_veh.remove_old.on and _GF_request_ctrl(_GT_spwn_veh.old_veh,250) then
							entity.set_entity_as_no_longer_needed(_GT_spwn_veh.old_veh)
							entity.delete_entity(_GT_spwn_veh.old_veh)
						end
						_GF_req_stream_hash(_table[selection][5])
						veh = _GF_spawn_veh_at_pid_frnt(player.player_id(),_table[selection][5],false,_GT_spwn_veh.spwn_front.value==0)
						_GT_spwn_veh.apply_upgrades(veh)
					end
					search = false
				elseif _GF_vk_key_down("ESCAPE") then
					search = false
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------


_GT_plate_anim={}
_GT_plate_anim.list_feat = {}
_GT_plate_anim.index=nil
_GT_plate_anim.plate=nil
_GT_plate_anim.my_veh=nil
_GT_plate_anim.plyr_delay=false
_GT_plate_anim.plate_delay=false
_GT_plate_anim.list_optns = menu.add_feature("String list options", "parent", _G_Disp_Cust_Plate.id)
_GT_plate_anim.list_prnt=menu.add_feature("String list", "parent", _GT_plate_anim.list_optns.id)

_GT_plate_anim.str_scrl={}
_GT_plate_anim.str_scrl.new_dly=false
_GT_plate_anim.str_scrl.new_txt=false
_GT_plate_anim.str_scrl.optns = menu.add_feature("String scroll options", "parent", _G_Disp_Cust_Plate.id, function()
	_GT_plate_anim.str_scrl.updt_name()
end)

function _GT_plate_anim.str_scrl.updt_name()
	_GT_plate_anim.str_scrl.check()
	local text,name = _GT_plate_anim.str_scrl.text(),"Update text"
	for i=1,31 do
		if i == 31 then
			name = string.sub(text,1,30)
		elseif string.len(text) == i then
			name = string.sub(text,1,i)
			break
		end
	end
	if string.len(name) >= 30 then
		name=name.."..."
	end
	_GT_plate_anim.str_scrl.update.name = name
end

_GT_plate_anim.spdo={}
_G_Disp_Cust_Plate_Speedo = menu.add_feature("Speedometer options", "parent", _G_Disp_Cust_Plate.id, function()
	_GT_plate_anim.spdo.dick_lngth.hidden=(_GT_plate_anim.spdo.type.value~=2)
end)

_GT_plate_anim.plyr={}
_GT_plate_anim.plyr.name=""
_GT_plate_anim.plyr.dist=10000
_G_Disp_Cust_Plate_Plyr = menu.add_feature("Closest player options", "parent", _G_Disp_Cust_Plate.id, function()
	_GT_plate_anim.plyr.dist_type.hidden=(not _GT_plate_anim.plyr.show_dist.on)
end)

_GT_plate_anim.wp={}
_GT_plate_anim.wp.blink=false
_GT_plate_anim.wp.blnk_new=false
_GT_plate_anim.wp.const=false
_GT_plate_anim.wp.dist=0
_GT_plate_anim.wp.prnt=menu.add_feature("Waypoint option", "parent", _G_Disp_Cust_Plate.id)




function _GT_plate_anim.file_check()
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	if not utils.dir_exists(directory) then
		utils.make_dir(directory)
	end
	if not utils.file_exists(directory.."anim.txt") then
		_GT_plate_anim.file_write(directory)
	end
end

function _GT_plate_anim.file_write(directory)
	local file = io.open(directory.."anim.txt", "w")
	file:write("g       \nge      \ngee     \ngeee    \ngeeee   \ngeeeee  \ngeeeeee \ngeeeeeee\n\nskid    \n    skid\nskid    \n    skid\n\ngee-skid\n\ngee-skid\n")
	file:close()
end

function _GT_plate_anim.file_get()
	_GT_plate_anim.file_check()
	::start::
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	local file = io.open(directory.."anim.txt", "r")
	local strings = {}
	for line in file:lines() do
		if line ~= nil and string.len(tostring(line)) < 9 then
			strings[#strings+1] = tostring(line)
		end
	end
	file:close()
	if # strings == 0 then
		_GT_plate_anim.file_write(directory)
		goto start
	end
	return strings
end

_GT_plate_anim.plate_refresh=false
function _GT_plate_anim.do_text(val,last,first,index,add)
	local status,str,continue = 1,"",false
	if val == 0 or add then
		status,str = _GF_text_input_get("Non alpha-numeric characters act as blank space","",8,0)
	end
	if add then
		if status == 0 then
			continue = true
		end
	elseif val ~= 0 or status == 0 then
		continue=true
	end
	if continue then
		local _table={}
		if add then
			if val == 4 then
				for i=1,#_GT_plate_anim.strings do
					if i < index then
						_table[#_table+1]=_GT_plate_anim.strings[i]
					elseif i == index then
						_table[#_table+1]=str
						_table[#_table+1]=_GT_plate_anim.strings[i]
					else
						_table[#_table+1]=_GT_plate_anim.strings[i]
					end
				end
			else
				if val == 0 then
					_table[#_table+1]=str
				end
				for i=1,#_GT_plate_anim.strings do
					_table[#_table+1]=_GT_plate_anim.strings[i]
				end
				if val == 1 then
					_table[#_table+1]=str
				end
			end
		elseif val == 0 or val == 1 then
			for i=1,#_GT_plate_anim.strings do
				if val == 0 then
					if i == index then
						_table[#_table+1]=str
					else
						_table[#_table+1]=_GT_plate_anim.strings[i]
					end
				else
					if i ~= index then
						_table[#_table+1]=_GT_plate_anim.strings[i]
					end
				end
			end
		else
			if val == 3 and last then
				_table[#_table+1]=_GT_plate_anim.strings[index]
			end
			for i=1,#_GT_plate_anim.strings do
				if val == 2 then
					if first then
						if i ~= index then
							_table[#_table+1]=_GT_plate_anim.strings[i]
						end
					elseif i < index-1 then
						_table[#_table+1]=_GT_plate_anim.strings[i]
					elseif i == index-1 then
						if _GT_plate_anim.strings[index] ~= nil then
							_table[#_table+1]=_GT_plate_anim.strings[index]
						end
						if _GT_plate_anim.strings[index-1] ~= nil then
							_table[#_table+1]=_GT_plate_anim.strings[index-1]
						end
					elseif i > index then
						_table[#_table+1]=_GT_plate_anim.strings[i]
					end
				else
					if last then
						if i ~= index then
							_table[#_table+1]=_GT_plate_anim.strings[i]
						end
					elseif i < index then
						_table[#_table+1]=_GT_plate_anim.strings[i]
					elseif i == index then
						if _GT_plate_anim.strings[index+1] ~= nil then
							_table[#_table+1]=_GT_plate_anim.strings[index+1]
						end
						if _GT_plate_anim.strings[index] ~= nil then
							_table[#_table+1]=_GT_plate_anim.strings[index]
						end
					elseif i > index+1 then
						_table[#_table+1]=_GT_plate_anim.strings[i]
					end
				end
			end
			if val == 2 and first then
				_table[#_table+1]=_GT_plate_anim.strings[index]
			end
		end
		_GT_plate.file_check()
		local contents = ""
		for i=1,#_table do
			contents = contents.._table[i]
			if _table[i+1] ~= nil then
				contents = contents.."\n"
			end
		end
		local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
		local file = io.open(directory.."anim.txt", "w")
		file:write(contents)
		file:close()
		_GT_plate_anim.list_delete()
		_GT_plate_anim.list_add()
		_GT_plate_anim.plate_refresh=true
	end
end
	
function _GT_plate_anim.list_delete()
	for i=1,#_GT_plate_anim.list_feat do
		menu.delete_feature(_GT_plate_anim.list_feat[i].id)
		if #_GT_plate_anim.list_feat % 100 == 0 then
			system.wait(0)
		end
	end
	menu.delete_feature(_GT_plate_anim.add_str_bttm_feat.id)
	_GT_plate_anim.list_feat={}
end

_GT_plate_anim.add_str_top_feat=menu.add_feature("Add entry to top", "action", _GT_plate_anim.list_prnt.id, function(f)
	_GT_plate_anim.do_text(0,nil,nil,nil,true)
end)
		
function _GT_plate_anim.list_add()
	_GT_plate_anim.strings=_GT_plate_anim.file_get()
	for i=1,#_GT_plate_anim.strings do
		local _last = (i==#_GT_plate_anim.strings)
		local _first = (i==1)
		_GT_plate_anim.list_feat[i]=menu.add_feature(_GT_plate_anim.strings[i], "action_value_str", _GT_plate_anim.list_prnt.id, function(f)
			local last,first,index=_last,_first,i
			_GT_plate_anim.do_text(f.value,last,first,index,f.value==4)
		end)
		if 1 == #_GT_plate_anim.strings then
			_GT_plate_anim.list_feat[i]:set_str_data({"Replace"})
		else
			_GT_plate_anim.list_feat[i]:set_str_data({"Replace","Remove","Move up","Move down","Insert new"})
		end
	end
	_GT_plate_anim.add_str_bttm_feat=menu.add_feature("Add entry to bottom", "action", _GT_plate_anim.list_prnt.id, function(f)
		_GT_plate_anim.do_text(1,nil,nil,nil,true)
	end)
end
_GT_plate_anim.list_add()

function _GT_plate_anim.reset_plate()
	if _GF_valid_veh(_GT_plate_anim.my_veh) then
		if _GT_plate_anim.index ~= nil then
			vehicle.set_vehicle_number_plate_index(_GT_plate_anim.my_veh, _GT_plate_anim.index)
		end
		if _GT_plate_anim.plate ~= nil then
			vehicle.set_vehicle_number_plate_text(_GT_plate_anim.my_veh, _GT_plate_anim.plate)
		end
	end
	_GT_plate_anim.index=nil
	_GT_plate_anim.plate=nil
	_GT_plate_anim.my_veh=nil
end

function _GT_plate_anim.record_plate()
	if _GT_plate_anim.index == nil then
		_GT_plate_anim.index = vehicle.get_vehicle_number_plate_index(_GT_plate_anim.my_veh)
	end
	if _GT_plate_anim.plate == nil then
		_GT_plate_anim.plate = native.call(0x7CE1CCB9B293020E,_GT_plate_anim.my_veh):__tostring(true) -- get_vehicle_number_plate_text because the menu's version doesnt work
	end
end
function _GT_plate_anim.index_do()
	if _GT_plate_anim.style_tog.on then
		vehicle.set_vehicle_number_plate_index(_GT_plate_anim.my_veh, _GT_plate_anim.style_tog.value)
	elseif _GT_plate_anim.index ~= nil and vehicle.get_vehicle_number_plate_index(_GT_plate_anim.my_veh) ~= _GT_plate_anim.index then
		vehicle.set_vehicle_number_plate_index(_GT_plate_anim.my_veh, _GT_plate_anim.index)
	end
end

_GT_plate_anim.tog=menu.add_feature("Custom license plate", "value_str", _G_Disp_Cust_Plate.id, function(f)
	local _table,do_once,f_value,time = {},false
	local function set_bools_false()
		_GT_plate_anim.str_scrl.new_txt=false
		_GT_plate_anim.str_scrl.new_dly=false
		_GT_plate_anim.plate_refresh=false
		_GT_plate_anim.plyr_delay=false
		_GT_plate_anim.plate_delay=false
	end
	local function reset_plate()
		_GT_plate_anim.reset_plate()
		set_bools_false()
		do_once=false
	end
	local function wp_show_const()
		_GT_plate_anim.wp.tog.on=(_GT_plate_anim.wp.select.value~=0)
		return (_GT_plate_anim.wp.select.value == 1 and _GT_plate_anim.wp.const and _GT_plate_anim.wp.dist ~= 0)
	end
	local function wp_show_blink()
		_GT_plate_anim.wp.tog.on=(_GT_plate_anim.wp.select.value~=0)
		return (_GT_plate_anim.wp.select.value == 2 and _GT_plate_anim.wp.blink and _GT_plate_anim.wp.dist ~= 0)
	end
	local function wp_show_any()
		_GT_plate_anim.wp.tog.on=(_GT_plate_anim.wp.select.value~=0)
		return (wp_show_const() or wp_show_blink())
	end
	local function wp_do_blink()
		while wp_show_any() and _GF_me_in_any_veh() and f.on and not _GT_plate_anim.wp.blnk_new do
			vehicle.set_vehicle_number_plate_text(_GT_plate_anim.my_veh, _GT_plate_anim.dist_str(_GT_plate_anim.wp.dist_mtrc.value,_GT_plate_anim.wp.dist))
			system.yield(0)		
		end
		_GT_plate_anim.wp.blnk_new=false
	end
	while f.on do
		f_value = f.value
		_GT_plate_anim.plyr.hddn.on=(f.value==2)
		_GT_plate_anim.wp.tog.on=(_GT_plate_anim.wp.select.value~=0)
		if _GT_plate_anim.my_veh ~= nil and player.get_player_vehicle(player.player_id()) ~= _GT_plate_anim.my_veh then
			reset_plate()
			system.yield(250)
		elseif _GF_me_in_any_veh() then
			_GT_plate_anim.my_veh=player.get_player_vehicle(player.player_id())
			if not do_once then
				system.yield(250)
				_GT_plate_anim.record_plate()
				do_once=true
			end
			_GT_plate_anim.index_do()
			if wp_show_const() then
				vehicle.set_vehicle_number_plate_text(_GT_plate_anim.my_veh, _GT_plate_anim.dist_str(_GT_plate_anim.wp.dist_mtrc.value,_GT_plate_anim.wp.dist))
				system.yield(100)
			elseif f.value == 0 then
				system.yield(5)
				_table = _GT_plate_anim.strings
				for i=1,#_table do
					if not _GF_me_in_any_veh() or not f.on or _GT_plate_anim.plate_refresh or (f_value ~= f.value) or wp_show_const() then
						break
					else
						_GT_plate_anim.index_do()
						vehicle.set_vehicle_number_plate_text(_GT_plate_anim.my_veh, _table[i])
						time = utils.time_ms() + _GT_plate_anim.delay.value*1000
						while time > utils.time_ms() and not _GT_plate_anim.plate_refresh and not _GT_plate_anim.plate_delay and (f_value == f.value) and not wp_show_any() do
							system.yield(5)
						end
						_GT_plate_anim.plate_delay=false
						wp_do_blink()
					end
				end
			elseif f.value == 1 then
				system.yield(50)
				vehicle.set_vehicle_number_plate_text(_GT_plate_anim.my_veh, _GT_plate_anim.spdo.math())
				wp_do_blink()
			elseif f.value == 2 then
				system.yield(0)
				_table=_GT_plate_anim.plyr.scroll()
				for i=1,#_table do
					if not _GF_me_in_any_veh() or not f.on or (f_value ~= f.value) or wp_show_const() then
						break
					else
						vehicle.set_vehicle_number_plate_text(_GT_plate_anim.my_veh, _table[i])
						time = utils.time_ms() + _GT_plate_anim.plyr.delay.value*1000
						while time > utils.time_ms() and not _GT_plate_anim.plyr_delay and (f_value == f.value) and not wp_show_any() do
							system.yield(5)
						end
						wp_do_blink()
					end
					_GT_plate_anim.plyr_delay=false
				end
			else
				_table=_GT_plate_anim.str_scrl.get()
				for i=1,#_table do
					if not _GF_me_in_any_veh() or not f.on or (f_value ~= f.value) or wp_show_const() or _GT_plate_anim.str_scrl.new_txt then
						break
					else
						vehicle.set_vehicle_number_plate_text(_GT_plate_anim.my_veh, _table[i])
						time = utils.time_ms() + _GT_plate_anim.str_scrl.spd.value*1000
						while time > utils.time_ms() and not _GT_plate_anim.str_scrl.new_dly and not _GT_plate_anim.str_scrl.new_txt and (f_value == f.value) and not wp_show_any() do
							system.yield(5)
						end
						wp_do_blink()
					end
					_GT_plate_anim.str_scrl.new_dly=false
				end
			end
			set_bools_false()
		else
			reset_plate()
			system.yield(250)
		end
	end
	reset_plate()
end)_GT_plate_anim.tog:set_str_data({"String list","Speedometer","Closest player","String scroll"})

function _GT_plate_anim.dist_str(_type,_dist)
	if _type==0 then
		if _dist >= 10000 then
			return tostring(_GF_round_num(_dist/1000).."km")
		end
		return tostring(_GF_round_num(_dist).."m")
	end
	if _dist*3.28084 >= 999999 then
		return tostring(_GF_round_num(_dist*3.28084/5280).."mls")
	end
	return tostring(_GF_round_num(_dist*3.28084).."ft")
end

function _GT_plate_anim.plyr.scroll()
	local _table,_table2 = {},{}
	local function max_num(_max,_num)
		if _num > _max then
			return _num-_max
		end
		return _num
	end
	if _GT_plate_anim.plyr.blank.on then
		for i=1,string.len(_GT_plate_anim.plyr.name) do
			_table[#_table+1]=string.sub(_GT_plate_anim.plyr.name,i,i)
		end
	else
		for char in _GT_plate_anim.plyr.name:gmatch("([a-zA-Z0-9])") do
			_table[#_table + 1] = char
		end
	end
	for i=1,_GT_plate_anim.plyr.space.value do
		_table[#_table+1]=" "
	end
	if _GT_plate_anim.plyr.show_dist.on then
		local text = _GT_plate_anim.dist_str(_GT_plate_anim.plyr.dist_type.value,_GT_plate_anim.plyr.dist)
		for i=1,string.len(text) do
			_table[#_table+1]=string.sub(text,i,i)
		end
		for i=1,_GT_plate_anim.plyr.space.value do
			_table[#_table+1]=" "
		end
	end
	if #_table< 9 then
		local limit = 9-#_table
		for i=1,limit do
			_table[#_table+1]=" "
		end
	end
	for i=1,#_table do
		local text=""
		for t=0,7 do
			if _table[max_num(#_table,i+t)] ~= nil then
				text=text.._table[max_num(#_table,i+t)]
			end
		end
		_table2[#_table2+1]=text
	end
	return _table2
end

_GT_plate_anim.plyr.hddn=menu.add_feature("Closest player HIDDEN", "toggle", _G_Disp_Cust_Plate_Plyr.id, function(f)
	local _table,_bool,name,dist
	while f.on do
		if _GT_plate_anim.tog.value == 2 then
			_table = _G_plyrs_overlay_main.dist_table
			table.sort(_table, function(a, b) return (a[1])<(b[1]) end)
			_bool = false
			for i=1,32 do
				if player.is_player_valid(_table[i][3]) and _table[i][3] ~= player.player_id() then
					name=_GF_plyr_name(_table[i][3])
					dist=_GF_dist_me_pid(_table[i][3])
					_bool = true
					break
				end
			end
			if _bool then
				_GT_plate_anim.plyr.name=name
				_GT_plate_anim.plyr.dist=dist
				_bool = false
			else
				_GT_plate_anim.plyr.name=_GF_plyr_name(player.player_id())
				_GT_plate_anim.plyr.dist=0
			end
		end
		system.yield(100)
		f.on = (_GT_plate_anim.tog.on and _GT_plate_anim.tog.value == 2)
	end
end)_GT_plate_anim.plyr.hddn.hidden=true

_GT_plate_anim.plyr.show_dist=menu.add_feature("Show distance", "toggle", _G_Disp_Cust_Plate_Plyr.id, function(f)
	_GT_plate_anim.plyr.dist_type.hidden=(not f.on)
end)

_GT_plate_anim.plyr.dist_type=menu.add_feature("Distance metric", "action_value_str", _G_Disp_Cust_Plate_Plyr.id)
_GT_plate_anim.plyr.dist_type:set_str_data({"Meters/KM","Feet"})

_GT_plate_anim.plyr.space=menu.add_feature("Extra spaces between info", "action_value_i", _G_Disp_Cust_Plate_Plyr.id)
_GF_set_feat_i_f(_GT_plate_anim.plyr.space,2,8,1,4)


_GT_plate_anim.plyr.delay=menu.add_feature("Scroll speed", "autoaction_value_f", _G_Disp_Cust_Plate_Plyr.id, function(f)
	_GT_plate_anim.plyr_delay=true
end)
_GF_set_feat_i_f(_GT_plate_anim.plyr.delay,0.01,1,0.05,.25)

_GT_plate_anim.plyr.blank=menu.add_feature("Make special characters blank spaces", "toggle", _G_Disp_Cust_Plate_Plyr.id)

_GT_plate_anim.delay=menu.add_feature("Animation delay (seconds)", "autoaction_value_f", _GT_plate_anim.list_optns.id, function(f)
	_GT_plate_anim.plate_delay=true
end)
_GF_set_feat_i_f(_GT_plate_anim.delay,0.01,30,0.05,.25)

_GT_plate_anim.style_tog=menu.add_feature("Include plate color", "value_str", _G_Disp_Cust_Plate.id)
_GT_plate_anim.style_tog:set_str_data({"Blue/White","Yellow/black","Yellow/Blue","Blue/White2","Blue/White3","Yankton"})
_GT_plate_anim.style_tog.value=1



function _GT_plate_anim.spdo.math()
	if _GT_plate_anim.spdo.type.value==0 then
		return tostring(_GF_round_num(entity.get_entity_speed(player.get_player_vehicle(player.player_id()))*2.23694)).." MPH"
	elseif _GT_plate_anim.spdo.type.value==1 then
		return tostring(_GF_round_num(entity.get_entity_speed(player.get_player_vehicle(player.player_id()))*3.6)).." KPH" 
	else
		local fps = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))*11811.02
		if _GT_plate_anim.spdo.dick_lngth.value == 0 then
			if fps*(12/5) > 999 then
				return tostring(_GF_round_num(fps*(12/5)/1000).."k DPH")
			end
			return tostring(_GF_round_num(fps*(12/5)).." DPH")
		elseif _GT_plate_anim.spdo.dick_lngth.value == 1 then
			if fps*(12/7) > 999 then
				return tostring(_GF_round_num(fps*(12/7)/1000).."k DPH")
			end
			return tostring(_GF_round_num(fps*(12/7)).." DPH")
		end
		if fps*(12/10) > 999 then
			return tostring(_GF_round_num(fps*(12/10)/1000).."k DPH")
		end
		return tostring(_GF_round_num(fps*(12/10)).." DPH")
	end
end

_GT_plate_anim.spdo.type=menu.add_feature("Speed metric", "autoaction_value_str", _G_Disp_Cust_Plate_Speedo.id, function(f)
	_GT_plate_anim.spdo.dick_lngth.hidden=(f.value~=2)
end)_GT_plate_anim.spdo.type:set_str_data({"MPH","KPH","Dicks per hour"})

_GT_plate_anim.spdo.dick_lngth=menu.add_feature("Dick length", "autoaction_value_str", _G_Disp_Cust_Plate_Speedo.id)
_GT_plate_anim.spdo.dick_lngth:set_str_data({"Asian","Average","BBC"})

_GT_plate_anim.wp.select=menu.add_feature("Waypoint distance", "action_value_str", _GT_plate_anim.wp.prnt.id)
_GT_plate_anim.wp.select:set_str_data({"Not shown","Always","Blink"})

_GT_plate_anim.wp.dist_mtrc=menu.add_feature("Distance metric", "action_value_str", _GT_plate_anim.wp.prnt.id)
_GT_plate_anim.wp.dist_mtrc:set_str_data({"Meters/KM","Feet"})

_GT_plate_anim.wp.blnk_spd=menu.add_feature("Blink time (seconds)", "autoaction_value_f", _GT_plate_anim.wp.prnt.id, function()
	_GT_plate_anim.wp.blnk_new=true
end)
_GF_set_feat_i_f(_GT_plate_anim.wp.blnk_spd,.5,5,.25,1)

_GT_plate_anim.wp.tog=menu.add_feature("Show waypoint distance HIDDEN", "toggle", _GT_plate_anim.wp.prnt.id, function(f)
	local wp_pos,blink_time,dist_time
	local function wp_reset()
		_GT_plate_anim.wp.blink=false
		_GT_plate_anim.wp.const=false
	end
	while f.on do
		if _GT_plate_anim.wp.select.value ~= 0 and _GF_me_in_any_veh() and ui.get_waypoint_coord().x < 16000 and _GF_WP_coords_get("anywhere") then
			wp_pos = ui.get_waypoint_coord()
			blink_time,dist_time = utils.time_ms(),utils.time_ms()
			while wp_pos == ui.get_waypoint_coord() and f.on and _GT_plate_anim.wp.select.value ~= 0 do
				system.yield(50)
				if dist_time < utils.time_ms() then
					_GT_plate_anim.wp.dist = _GF_dist_pos_pos(player.get_player_coords(player.player_id()),_G_WP_OBJ_pos)
					if math.floor(_GT_plate_anim.wp.blnk_spd.value*1000*.15)<100 then
						dist_time = utils.time_ms()+100
					else
						dist_time = math.floor(_GT_plate_anim.wp.blnk_spd.value*1000*.15)
					end
				end
				if _GT_plate_anim.wp.select.value == 1 then
					_GT_plate_anim.wp.const=true
					_GT_plate_anim.wp.blink=false
				else
					_GT_plate_anim.wp.const=false
					if blink_time < utils.time_ms() then
						_GT_plate_anim.wp.blink=_GF_opp_bool(_GT_plate_anim.wp.blink)
						blink_time = utils.time_ms()+_GT_plate_anim.wp.blnk_spd.value*1000
					end
				end
			end
		end
		wp_reset()
		f.on=(_GT_plate_anim.wp.select.value ~= 0 and _GT_plate_anim.tog.on)
		system.yield(500)
	end
	wp_reset()
end)_GT_plate_anim.wp.tog.hidden=true

function _GT_plate_anim.str_scrl.write(_text)
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	local file = io.open(directory.."string.txt", "w")
	file:write(_text)
	file:close()
end

function _GT_plate_anim.str_scrl.check()
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	if not utils.dir_exists(directory) then
		utils.make_dir(directory)
	end
	if not utils.file_exists(directory.."string.txt") then
		_GT_plate_anim.str_scrl.write("OMG GeeSkid is the best")
	end
	local file = io.open(directory.."string.txt", "r")
	local text = nil
	for line in file:lines() do
		if line ~= nil and string.len(tostring(line)) > 0 then
			text = tostring(line)
			break
		end
	end
	file:close()
	if text == nil then
		_GT_plate_anim.str_scrl.write("OMG GeeSkid is the best")
	end
end

function _GT_plate_anim.str_scrl.text()
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	local file = io.open(directory.."string.txt", "r")
	local text = nil
	for line in file:lines() do
		if line ~= nil and string.len(tostring(line)) > 0 then
			text = tostring(line)
			break
		end
	end
	file:close()
	return text
end

function _GT_plate_anim.str_scrl.get()
	local _table,_table2 = {},{}
	local function max_num(_max,_num)
		if _num > _max then
			return _num-_max
		end
		return _num
	end
	_GT_plate_anim.str_scrl.check()
	local text = _GT_plate_anim.str_scrl.text()
	for char in text:gmatch("([a-zA-Z0-9 ])") do
		_table[#_table + 1] = char
	end
	for i=1,_GT_plate_anim.str_scrl.space.value do
		_table[#_table+1]=" "
	end
	if #_table< 9 then
		local limit = 9-#_table
		for i=1,limit do
			_table[#_table+1]=" "
		end
	end
	for i=1,#_table do
		text=""
		for t=0,7 do
			if _table[max_num(#_table,i+t)] ~= nil then
				text=text.._table[max_num(#_table,i+t)]
			end
		end
		_table2[#_table2+1]=text
	end
	return _table2
end

_GT_plate_anim.str_scrl.spd = menu.add_feature("Scroll speed", "autoaction_value_f", _GT_plate_anim.str_scrl.optns.id, function()
	_GT_plate_anim.str_scrl.new_dly=true
end)_GF_set_feat_i_f(_GT_plate_anim.str_scrl.spd,.01,1,.01,.2)

_GT_plate_anim.str_scrl.space=menu.add_feature("Extra spaces added at the end", "action_value_i", _GT_plate_anim.str_scrl.optns.id)
_GF_set_feat_i_f(_GT_plate_anim.str_scrl.space,0,8,1,4)

_GT_plate_anim.str_scrl.update = menu.add_feature("Update text", "action_value_str", _GT_plate_anim.str_scrl.optns.id, function(f)
	_GT_plate_anim.str_scrl.check()
	local continue,text = true,""
	if f.value == 1 then
		text = _GT_plate_anim.str_scrl.text()
		if string.len(text) > 128 then
			continue=false
			menu.notify("The string is too long to edit",_G_GeeVer,4)
		end
	end
	if continue then
		local status,str = 1,""
		status,str = _GF_text_input_get("Non alpha-numeric characters act as blank space",text,128,0)
		if status == 0 then
			_GT_plate_anim.str_scrl.write(str)
			_GT_plate_anim.str_scrl.new_txt=true
			_GT_plate_anim.str_scrl.updt_name()
		end
	end
end)_GT_plate_anim.str_scrl.update:set_str_data({"Replace","Edit"})


---------------------------------------------------------------------------------------------------------------------------------------------------
_G_punish_veh={}
_G_punish_veh.veh_list={}

function _G_punish_veh.func(_veh)
	if _G_punish_veh.veh_list[_veh+1] == nil then _G_punish_veh.veh_list[_veh+1]={false,0,v3(0,0,0)} end
	if _G_punish_veh.feat.value == 0 then
		_GF_remove_ent(_veh,50)
	elseif _G_punish_veh.feat.value == 1 then
		entity.set_entity_god_mode(_veh, false)
		_GF_tire_pop_simple(_veh,true)
		vehicle.set_vehicle_engine_health(_veh, -4000)
		vehicle.set_vehicle_number_plate_index(_veh, 1)
		vehicle.set_vehicle_number_plate_text(_veh,"G-Damage")
		local vlcty = entity.get_entity_velocity(_veh)
		entity.set_entity_velocity(_veh,v3(vlcty.x*.5,vlcty.y*.5,vlcty.z*.5))
		_GF_set_invncbl_wndws(_veh,false)
		_GF_brk_wndws(_veh)
		_G_punish_veh.veh_list[_veh+1][2] = utils.time_ms() + math.random(4500,5500)
	elseif _G_punish_veh.feat.value == 2 then
		entity.set_entity_velocity(_veh,v3(math.random(-30,30),math.random(-30,30),100))	
	elseif _G_punish_veh.feat.value == 3 then
		entity.set_entity_god_mode(_veh, false)
		fire.add_explosion(entity.get_entity_coords(_veh), 65, true, false, 0, 10000)
		vehicle.set_vehicle_forward_speed(_veh,0)
		_G_punish_veh.veh_list[_veh+1][2] = utils.time_ms() + math.random(4500,5500)
	else
		entity.set_entity_velocity(_veh,_G_punish_veh.veh_list[_veh+1][3])
	end
end

function _G_punish_veh.plyr_check(_veh)
	if _veh == _GT_plyr_info.veh[player.player_id()+1] or _veh == player.get_personal_vehicle() then
		return false
	elseif not _G_punish_veh.plyrs.on then
		return (not vehicle.get_vehicle_has_been_owned_by_player(_veh))
	else
		for i = 1,_GF_veh_seats(_veh) do
			if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) then
				if not _G_punish_veh.frnds.on and player.is_player_friend(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, i-2))) then
					return false
				end
				if not _G_punish_veh.orgmc.on and _GF_same_orgmc(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, i-2)),player.player_id()) then
					return false
				end					
				if not _G_punish_veh.mddrs.on and _GT_plyr_info.modder[(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, i-2)))+1] then
					return false
				end
			end
		end
		return true
	end
end

_G_punish_veh.feat=menu.add_feature("Punish vehicles in my bubble", "value_str", _G_Traffic_Stuff.id, function(f)
    local all_veh,veh,dist,my_ent={}
	local function in_range()
		if f.value == 3 then
			return (dist > _G_punish_veh.safe.value and dist < _G_punish_veh.bubl.value)
		end
		return (dist < _G_punish_veh.bubl.value)
	end
	_G_punish_veh.record.on = f.on
	_G_punish_veh.hit_me.on = f.on
    while f.on do
		system.yield(100)
		if not _G_punish_veh.cllsn.on then
			all_veh = vehicle.get_all_vehicles()
			for i=1,#all_veh do
				veh = all_veh[i]
				if _G_punish_veh.veh_list[veh+1] == nil then _G_punish_veh.veh_list[veh+1]={false,0,v3(0,0,0)} end
				if _G_punish_veh.veh_list[veh+1] ~= nil and _G_punish_veh.veh_list[veh+1][1] and _G_punish_veh.veh_list[veh+1][2] < utils.time_ms() then
					dist = _GF_dist_me_ent(veh)
					if in_range() and _GF_request_ctrl(veh,25) then
						_G_punish_veh.func(veh)
					end
				end
			end
		end
    end
end)_G_punish_veh.feat:set_str_data({"TP away","Damage","Launch","EMP","Push away"})

_G_punish_veh.hit_me=menu.add_feature("Punish vehicles that hit me HIDDEN", "toggle", _G_Traffic_Stuff.id, function(f)
	local all_veh,veh
    while f.on do
		system.yield(0)
		if _GF_me_in_any_veh() then
			if entity.has_entity_collided_with_anything(player.get_player_vehicle(player.player_id())) then
				veh = entity.get_entity_entity_has_collided_with(player.get_player_vehicle(player.player_id()))
				if _GF_valid_veh(veh) and _G_punish_veh.plyr_check(veh) and _GF_request_ctrl(veh,1000) then
					_G_punish_veh.func(veh)
				end
			end
		else
			all_veh=vehicle.get_all_vehicles()
			for i=1,#all_veh do
				if _GF_ents_touch(player.get_player_ped(player.player_id()),all_veh[i]) and _G_punish_veh.plyr_check(all_veh[i]) and _GF_request_ctrl(all_veh[i],1000) then
					_G_punish_veh.func(all_veh[i])
				end
			end
		end
		f.on = _G_punish_veh.feat.on
	end
end)
_G_punish_veh.hit_me.hidden=true

_G_punish_veh.record=menu.add_feature("Punish vehicles in my bubble HIDDEN", "toggle", _G_Traffic_Stuff.id, function(f)
    local all_veh,veh,my_pos,close_enough,good_veh,time,vector
	local function in_grid(my_pos,ent_pos,_max)
		if math.abs(my_pos.x - ent_pos.x) > _max or math.abs(my_pos.y - ent_pos.y) > _max or math.abs(my_pos.z - ent_pos.z) > _max then
			return false
		end
		return true
	end
	local function record_time()
		if _G_punish_veh.veh_list[veh+1][2] < utils.time_ms() then
			return 0
		end
		return _G_punish_veh.veh_list[veh+1][2]
	end
    while f.on do
        system.yield(250)
        all_veh = vehicle.get_all_vehicles()
		my_pos = player.get_player_coords(player.player_id())
        for i=1,#all_veh do
			veh = all_veh[i]
			vector = v3(0,0,0)
			if _G_punish_veh.veh_list[veh+1] == nil then _G_punish_veh.veh_list[veh+1]={false,0,vector} end
			close_enough = in_grid(my_pos,entity.get_entity_coords(veh),_G_punish_veh.bubl.value*1.5)
			if not close_enough then
				good_veh = false
				time = 0
			else
				good_veh = _G_punish_veh.plyr_check(veh)
				time = record_time()
			end
			if _G_punish_veh.feat.value==4 then
				vector = _GF_flight_calc( -- need to upgrade this to 3d
				_GF_vector_to_pos_head(entity.get_entity_coords(veh),player.get_player_ped(player.player_id())),
				(_GT_plyr_info.plyr_speed_pos_mps[player.player_id()+1]+10)*1.1,
				0,
				false,
				false,
				false,
				false
				)
			end
			_G_punish_veh.veh_list[veh+1]={(close_enough and good_veh),time,vector+v3(0,0,.5)}
		end
		f.on = _G_punish_veh.feat.on
	end
end)_G_punish_veh.record.hidden=true

function _G_punish_veh.hide(_bool)
	_G_punish_veh.frnds.hidden=_bool
	_G_punish_veh.orgmc.hidden=_bool
	_G_punish_veh.mddrs.hidden=_bool 
end

_G_punish_veh.cllsn=menu.add_feature("Only punish vehicles that touch me", "toggle", _G_Traffic_Stuff.id)

_G_punish_veh.plyrs=menu.add_feature("Include player vehicles", "toggle", _G_Traffic_Stuff.id,function(f)
	_G_punish_veh.hide(not f.on)
end)
_G_punish_veh.frnds=menu.add_feature("Include friends", "toggle", _G_Traffic_Stuff.id)
_G_punish_veh.orgmc=menu.add_feature("Include my org/mc", "toggle", _G_Traffic_Stuff.id)
_G_punish_veh.mddrs=menu.add_feature("Include modders", "toggle", _G_Traffic_Stuff.id)

_G_punish_veh.show_bubl=false
_G_punish_veh.bubl=menu.add_feature("Bubble size", "autoaction_value_i", _G_Traffic_Stuff.id,function(f)
	_G_punish_veh.show_debug.on=true
	_G_punish_veh.show_bubl=true
end)_GF_set_feat_i_f(_G_punish_veh.bubl,5,250,5,15)

_G_punish_veh.show_safe=false
_G_punish_veh.safe=menu.add_feature("Safe zone for EMP", "autoaction_value_i", _G_Traffic_Stuff.id,function(f)
	_G_punish_veh.show_debug.on=true
	_G_punish_veh.show_safe=true
end)_GF_set_feat_i_f(_G_punish_veh.safe,5,25,1,7)

_G_punish_veh.show_debug=menu.add_feature("Show  debugs HIDDEN", "toggle", _G_Traffic_Stuff.id,function(f)
	local time,red_time,green_time = utils.time_ms() + 5000,utils.time_ms(),utils.time_ms()
	while time > utils.time_ms() do
		system.yield(5)
		if _G_punish_veh.show_bubl then
			red_time = utils.time_ms()+5000
			time = utils.time_ms() + 5000
			_G_punish_veh.show_bubl=false
		end
		if red_time > utils.time_ms() then 
			graphics.draw_marker(28, player.get_player_coords(player.player_id()), v3(0, 90, 0), v3(0, 90, 0), v3(_G_punish_veh.bubl.value, _G_punish_veh.bubl.value, _G_punish_veh.bubl.value), 255, 0, 0, math.floor((red_time-utils.time_ms()) /1000/5*100), false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
		end
		if _G_punish_veh.show_safe then
			green_time = utils.time_ms()+5000
			time = utils.time_ms() + 5000
			_G_punish_veh.show_safe=false
		end
		if green_time > utils.time_ms() then 
			graphics.draw_marker(28, player.get_player_coords(player.player_id()), v3(0, 90, 0), v3(0, 90, 0), v3(_G_punish_veh.safe.value, _G_punish_veh.safe.value, _G_punish_veh.safe.value), 0, 255, 0, math.floor((green_time-utils.time_ms()) /1000/5*100), false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
		end
	end
	f.on=false
end)_G_punish_veh.show_debug.hidden=true
_G_punish_veh.hide(true)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_GT_veh_esp_table = {}
_GT_veh_esp_table.png_true = {}
_GT_veh_esp_table.png_int = {}
_GT_veh_esp_table.png_rot_true = {}
_GT_veh_esp_table.veh_table = {}

function _GT_veh_esp_table.veh_table_default(i)
	_GT_veh_esp_table.veh_table[i] = {
	10000, 	--1 dist m
	10000, 	--2 dist choice
	false, 	--3 specific
	false, 	--4 generic
	0, 		--5 r 
	0,		--6 g
	0, 		--7 b
	-1,		--8 name
	0,		--9 blip
	false,	--10 do_rot
	false,	--11 spin
	false,	--12 personal
	false,	--13 in_veh
	0,		--14 passenger count
	false,	--15 veh_god
	false,	--16 friend
	false,	--17 me
	0,		--18 ped pssngrs
	}
end

_GT_veh_esp_table.file_root = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
_GT_veh_esp_table.file_paths = {"\\scripts\\GeeSkid\\radar_blips\\veh_rotate","\\scripts\\GeeSkid\\radar_blips\\veh_rotate\\generic","\\scripts\\GeeSkid\\radar_blips\\veh_no_rotate","\\scripts\\GeeSkid\\radar_blips\\veh_no_rotate\\generic"}

function _GT_veh_esp_table.register()
	local sprite_files, _start,_end,hash_string,sprite = {}
	for p=1,4 do
		sprite_files = utils.get_all_files_in_directory(_GT_veh_esp_table.file_root.._GT_veh_esp_table.file_paths[p],"png")
		for i=1,#sprite_files do
			sprite = scriptdraw.register_sprite(_GT_veh_esp_table.file_root.._GT_veh_esp_table.file_paths[p].."\\"..sprite_files[i])
			if sprite ~= nil then
				_start,_end = string.find(sprite_files[i], "png")
				hash_string = string.sub(sprite_files[i],1,_end-4)
				if p == 1 then
					_GT_veh_esp_table.png_true[gameplay.get_hash_key(hash_string)] = true
					_GT_veh_esp_table.png_int[gameplay.get_hash_key(hash_string)] = sprite
					_GT_veh_esp_table.png_rot_true[gameplay.get_hash_key(hash_string)] = true
				elseif p == 2 then
					_GT_veh_esp_table.png_true[hash_string] = true
					_GT_veh_esp_table.png_int[hash_string] = sprite
					_GT_veh_esp_table.png_rot_true[hash_string] = true
				elseif p == 3 then
					_GT_veh_esp_table.png_true[gameplay.get_hash_key(hash_string)] = true
					_GT_veh_esp_table.png_int[gameplay.get_hash_key(hash_string)] = sprite
					_GT_veh_esp_table.png_rot_true[gameplay.get_hash_key(hash_string)] = false
				else
					_GT_veh_esp_table.png_true[hash_string] = true
					_GT_veh_esp_table.png_int[hash_string] = sprite
					_GT_veh_esp_table.png_rot_true[hash_string] = false
				end
			end
		end		
	end
end
_GT_veh_esp_table.register()

function _GT_veh_esp_table.check_for_plyr(_veh,_bool)
	local _pidT,count =nil,0
	local r,g,b
	local function non_plyr_count()
		local ped_count = 0
		for s = 1, _GF_veh_seats(_veh) do
			if entity.is_entity_a_ped(vehicle.get_ped_in_vehicle_seat(_veh, s-2)) and not ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, s-2)) then
				ped_count=ped_count+1
			end
		end
		return ped_count
	end
	for s = 1, _GF_veh_seats(_veh) do
		if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, s-2)) then
			if _bool and _pidT == nil then 
				_pidT = player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, s-2))+1
				r,g,b = _G_plyrs_overlay_main.plyr_rgb(_pidT,nil)
			end
			count=count+1
		end
	end
	if _bool then
		if _pidT ~= nil then 
			return r,g,b,(_pidT-1),true,count,_GT_plyr_info.is_frnd[_pidT],(_pidT-1 == player.player_id()),non_plyr_count()
		end
	elseif count > 0 then
		return true
	end
	for i=1,#_GT_plyr_info.veh do
		if (_GT_plyr_info.veh[i] == _veh) then
			if _bool then
				r,g,b = _G_plyrs_overlay_main.plyr_rgb(i,nil)
				return r,g,b,(i-1),false,0,_GT_plyr_info.is_frnd[i],(i-1 == player.player_id()),non_plyr_count()
			end
			return true
		end
	end
	if _bool and _GT_veh_esp_table.veh_table[_veh+1][12] ~= false then
		_pidT = _GT_veh_esp_table.veh_table[_veh+1][12]+1
		r,g,b = _G_plyrs_overlay_main.plyr_rgb(_pidT,nil)
		return r,g,b,(_pidT-1),false,count,_GT_plyr_info.is_frnd[_pidT],(_pidT-1 == player.player_id()),non_plyr_count()
	end
	if _bool then
		return 255,255,255, -1,false,0,false,false,non_plyr_count()
	end
	return (_GT_veh_esp_table.veh_table[_veh+1][12]~=false)
end

function _GT_veh_esp_table.line_color_get(is_me,frnd,dist)
	if is_me then
		return _GT_veh_esp_table.line_self_r.value,_GT_veh_esp_table.line_self_g.value,_GT_veh_esp_table.line_self_b.value,_GT_veh_esp_table.line_self_a.value
	elseif frnd then
		return _GT_veh_esp_table.line_frnd_r.value,_GT_veh_esp_table.line_frnd_g.value,_GT_veh_esp_table.line_frnd_b.value,_GT_veh_esp_table.line_frnd_a.value
	elseif dist < _GT_veh_esp_table.line_near_dist.value then
		return _GT_veh_esp_table.line_near_r.value,_GT_veh_esp_table.line_near_g.value,_GT_veh_esp_table.line_near_b.value,_GT_veh_esp_table.line_near_a.value
	end
	return _GT_veh_esp_table.line_far_r.value,_GT_veh_esp_table.line_far_g.value,_GT_veh_esp_table.line_far_b.value,_GT_veh_esp_table.line_far_a.value
end

function _GT_veh_esp_table.good_esp_veh(_veh)
	local function in_my_grid(my_pos,_pos,_max)
		if math.abs((_pos.x - my_pos.x)*_GT_veh_esp_table.math[_GT_veh_esp_table.dist_type.value+1]) > _max or
			math.abs((_pos.y - my_pos.y)*_GT_veh_esp_table.math[_GT_veh_esp_table.dist_type.value+1]) > _max or
			math.abs((_pos.z - my_pos.z)*_GT_veh_esp_table.math[_GT_veh_esp_table.dist_type.value+1]) > _max then
			return false
		end
		return true
	end
	if _GT_veh_esp_table.feat.on and entity.is_an_entity(_veh) and not entity.is_entity_dead(_veh) and in_my_grid(player.get_player_coords(player.player_id()),entity.get_entity_coords(_veh),_GT_veh_esp_table.dist.value) then
		return true
	end
	return false
end

_GT_veh_esp_table.feat=menu.add_feature("Vehicle ESP 2.0", "toggle", _G_veh_esp_option.id, function(f)
	_GF_yield_while_true(not _G_GS_has_loaded,1000)
	local dist,spin_z,bool,screen_x,screen_y,screen_pos,size,blip,r,g,b,all_veh,veh,name,rot,name_pos_y,name_pos_y_G,name_pos_y_temp,text_size,text_x,text_y,text_x_offst,text_y_offst,_flags,show_name,show_veh,show_health,show_pssngr,show_dist,my_bool,_my_screen_pos,my_screen_x,my_screen_y = 0,0
	local do_g_blink_now,blink_time,all_veh_time,veh_name,plyr_name,pssngr_count,show_p,tr,tg,tb,lr,lg,lb,la,show_g,do_g_blink = false,utils.time_ms()+669,utils.time_ms()-2000
	local function get_veh_rgb()
		if do_g_blink and do_g_blink_now then
			return 255,0,0
		end
		return _GT_veh_esp_table.veh_table[veh+1][5],_GT_veh_esp_table.veh_table[veh+1][6],_GT_veh_esp_table.veh_table[veh+1][7]
	end
	local function show_line()
		if _GT_veh_esp_table.line_show_for.value == 2 then
			return true
		elseif _GT_veh_esp_table.line_show_for.value == 1 then
			return (_GT_veh_esp_table.veh_table[veh+1][14]==0)
		end
		return (_GT_veh_esp_table.veh_table[veh+1][14]>0)
	end
	local function x_pos_do(_pos)
		if _GT_veh_esp_table.text_jstfctn.value == 1 then
			_flags=_flags+(1<<0)
			return _pos*(2/3)
		elseif _GT_veh_esp_table.text_jstfctn.value == 2 then
			_flags=_flags+(1<<4)
		end
		return _pos
	end
	local function get_text_sort(_valt,_vals)
		if _GT_veh_esp_table.text_from_top.value == 0 then
			return _valt,_vals
		elseif _GT_veh_esp_table.text_from_top.value ==1 then
			local _table = {show_name,show_veh,show_pssngr,show_dist}
			local count = 0
			for i=1, #_table do
				if _table[i] then
					count=count+1
				end
			end
			return _valt,(_vals+(_valt *count*.5))
		else
			return _valt*-1,_vals
		end
	end
	local script_size = _GF_script_draw_size(f.on)
	while f.on do
		_GT_veh_esp_table.feat_record.on = f.on
		_GT_veh_esp_table.feat_record_prsnl.on = f.on
		system.yield(5)
		if all_veh_time+2000 < utils.time_ms() then
			all_veh_time = utils.time_ms()
			all_veh=vehicle.get_all_vehicles()
		end
		if blink_time < utils.time_ms() then
			do_g_blink_now=_GF_opp_bool(do_g_blink_now)
			if do_g_blink_now then blink_time = utils.time_ms()+250 else blink_time = utils.time_ms()+750 end
		end
		if spin_z >= 360 then spin_z = 0 else spin_z = spin_z + 1.875 end
		my_bool,_my_screen_pos = graphics.project_3d_coord(player.get_player_coords(player.player_id()))
		for i=1,#all_veh do
			veh = all_veh[i]
			if _GT_veh_esp_table.veh_table[veh+1] ~= nil and entity.is_an_entity(veh) and _GT_veh_esp_table.veh_table[veh+1][2] < _GT_veh_esp_table.dist.value and (_GT_veh_esp_table.veh_table[veh+1][3] or _GT_veh_esp_table.veh_table[veh+1][4]) then
				bool,screen_pos = graphics.project_3d_coord(entity.get_entity_coords(veh))
				if bool then
					if _GT_veh_esp_table.veh_table[veh+1][11] then
						rot = _GT_gta_map.sprt_rot_calc(spin_z)
					elseif _GT_veh_esp_table.veh_table[veh+1][10] then
						rot = _GT_gta_map.sprt_rot_calc(entity.get_entity_rotation(veh).z-_GF_vector_to_pos_head(v3(0,100000,0),veh).z+(cam.get_gameplay_cam_rot().z*-1))
					else
						rot = 0
					end
					show_g,do_g_blink=false,false
					if _GT_veh_esp_table.show_veh_god.on and _GT_veh_esp_table.veh_table[veh+1][15] then
						if _GT_veh_esp_table.show_veh_god.value == 2 then show_g = true do_g_blink = true elseif  _GT_veh_esp_table.show_veh_god.value == 0 then show_g = true else do_g_blink = true end
					end
					show_p = false
					dist = _GT_veh_esp_table.veh_table[veh+1][2]
					r,g,b = get_veh_rgb()
					name,blip = _GT_veh_esp_table.veh_table[veh+1][8],_GT_veh_esp_table.veh_table[veh+1][9]
					tr,tg,tb = _GT_veh_esp_table.text_r.value,_GT_veh_esp_table.text_g.value,_GT_veh_esp_table.text_b.value
					screen_x = screen_pos.x/graphics.get_screen_width()/.5-1
					screen_y = (screen_pos.y/graphics.get_screen_height()/.5-1)*-1
					size = (((_GT_veh_esp_table.dist.max-dist)/_GT_veh_esp_table.dist.max*3)+1.25)*.3*_GT_veh_esp_table.blip_size.value
					for i=1, math.floor(dist/(_GT_veh_esp_table.dist.max*0.0125)) do
						if i > _GT_veh_esp_table.blip_size_dist.value then break else size=size*.95	end
					end
					name_pos_y = (0.01169*size*_GT_veh_esp_table.text_size.value*_GT_veh_esp_table.text_space.value)*1.05
					
					name_pos_y_G = (0.01169*size*_GT_veh_esp_table.text_size.value*_GT_veh_esp_table.text_space.value)*1.05*1.5
					show_name = (_GT_veh_esp_table.show_plyr_name.on and name ~= -1 and dist < _GT_veh_esp_table.show_plyr_name.value)
					show_veh = (_GT_veh_esp_table.show_veh_name.on and dist < _GT_veh_esp_table.show_veh_name.value)
					show_health = (_GT_veh_esp_table.show_veh_health.on and dist < _GT_veh_esp_table.show_veh_health.value)
					show_pssngr = (_GT_veh_esp_table.show_veh_pssngr.on and dist < _GT_veh_esp_table.show_veh_pssngr.value)
					show_dist = (_GT_veh_esp_table.show_veh_dist.on and dist < _GT_veh_esp_table.show_veh_dist.value)
					name_pos_y,text_y = get_text_sort(name_pos_y,screen_y)
					text_size = .1*(size*1.1)*_GT_veh_esp_table.text_size.value
					name_pos_y_temp=name_pos_y
					if _GT_veh_esp_table.line_feat.on and show_line() then
						lr,lg,lb,la = _GT_veh_esp_table.line_color_get(_GT_veh_esp_table.veh_table[veh+1][17],_GT_veh_esp_table.veh_table[veh+1][16],dist)
						if _GT_veh_esp_table.line_feat.value == 0 and my_bool then
							my_screen_x = _my_screen_pos.x/graphics.get_screen_width()/.5-1
							my_screen_y = (_my_screen_pos.y/graphics.get_screen_height()/.5-1)*-1
							scriptdraw.draw_line(v2(my_screen_x,my_screen_y),v2(screen_x,screen_y), math.floor(size), _GF_RGBAToInt(lr,lg,lb,la))
						elseif _GT_veh_esp_table.line_feat.value == 1 then
							ui.draw_line(player.get_player_coords(player.player_id()), entity.get_entity_coords(veh), lr,lg,lb,la)
						end
					end
					if text_size < 0.09 then text_size = 0.09 end
					text_size=text_size*script_size
					_flags=(1<<1)--shadow
					text_x = x_pos_do(screen_x)
					text_x_offst = _GT_veh_esp_table.text_x.value*.01
					text_y_offst = _GT_veh_esp_table.text_y.value*.01
					if show_name then
						if _GT_veh_esp_table.show_veh_prsnl.on and (_GT_veh_esp_table.veh_table[veh+1][12] == _GT_veh_esp_table.veh_table[veh+1][8]) and (_GT_veh_esp_table.veh_table[veh+1][13] or _GT_veh_esp_table.veh_table[veh+1][14]==0) then
							plyr_name = "*P* "
							show_p=true
						else
							plyr_name = ""
						end
						plyr_name = plyr_name.._GF_plyr_name(name)
						scriptdraw.draw_text(plyr_name,v2(text_x+text_x_offst,text_y-name_pos_y_temp+text_y_offst),v2(text_x,screen_y),text_size*6,_GF_RGBAToInt(tr,tg,tb,math.floor(255*_GT_veh_esp_table.text_vis.value)),_flags,nil)
						name_pos_y_temp = name_pos_y_temp + (name_pos_y)
					end
					if show_veh then
						if not show_p and _GT_veh_esp_table.show_veh_prsnl.on and (_GT_veh_esp_table.veh_table[veh+1][12] ~= false) then
							veh_name = "*P* "
						else
							veh_name = ""
						end
						veh_name = veh_name.._GF_model_name(veh)
						scriptdraw.draw_text(veh_name,v2(text_x+text_x_offst,text_y-name_pos_y_temp+text_y_offst),v2(text_x,screen_y),text_size*6,_GF_RGBAToInt(tr,tg,tb,math.floor(255*_GT_veh_esp_table.text_vis.value)),_flags,nil)
						name_pos_y_temp = name_pos_y_temp + (name_pos_y)
					end
					if show_health then
						if _GT_veh_esp_table.show_veh_health_type.value == 0 then
							scriptdraw.draw_text("Engine: ".._GF_1_decimal(_GF_get_veh_engn_hlth(veh,true)).."%",v2(text_x+text_x_offst,text_y-name_pos_y_temp+text_y_offst),v2(text_x,screen_y),text_size*6,_GF_RGBAToInt(tr,tg,tb,math.floor(255*_GT_veh_esp_table.text_vis.value)),_flags,nil)
						elseif _GT_veh_esp_table.show_veh_health_type.value == 1 then
							scriptdraw.draw_text("Body: ".._GF_1_decimal(_GF_get_veh_bdy_hlth(veh,true)).."%",v2(text_x+text_x_offst,text_y-name_pos_y_temp+text_y_offst),v2(text_x,screen_y),text_size*6,_GF_RGBAToInt(tr,tg,tb,math.floor(255*_GT_veh_esp_table.text_vis.value)),_flags,nil)
						else
							scriptdraw.draw_text("Health: ".._GF_1_decimal(_GF_get_veh_cmbnd_hlth_prcnt(veh,true)).."%",v2(text_x+text_x_offst,text_y-name_pos_y_temp+text_y_offst),v2(text_x,screen_y),text_size*6,_GF_RGBAToInt(tr,tg,tb,math.floor(255*_GT_veh_esp_table.text_vis.value)),_flags,nil)
						end
						name_pos_y_temp = name_pos_y_temp + (name_pos_y)
					end
					if show_pssngr then
						if _GT_veh_esp_table.veh_table[veh+1][14] == 0 and _GT_veh_esp_table.veh_table[veh+1][18] == 0 then
							pssngr_count="<Empty>"
						elseif _GT_veh_esp_table.veh_table[veh+1][14] == 1 then
							pssngr_count="<1 player>"
						elseif _GT_veh_esp_table.veh_table[veh+1][14] > 1 then
							pssngr_count="<".._GT_veh_esp_table.veh_table[veh+1][14].." players>"
						elseif _GT_veh_esp_table.veh_table[veh+1][18] == 1 then
							pssngr_count="<1 ped>"
						else
							pssngr_count="<".._GT_veh_esp_table.veh_table[veh+1][18].." peds>"
						end
						scriptdraw.draw_text(pssngr_count,v2(text_x+text_x_offst,text_y-name_pos_y_temp+text_y_offst),v2(text_x,screen_y),text_size*6,_GF_RGBAToInt(tr,tg,tb,math.floor(255*_GT_veh_esp_table.text_vis.value)),_flags,nil)
						name_pos_y_temp = name_pos_y_temp + (name_pos_y)
					end
					if show_dist then
						scriptdraw.draw_text(_GF_ent_dist_str(_GT_veh_esp_table.veh_table[veh+1][1],_GT_dist_type_str[_GT_veh_esp_table.dist_type.value]),v2(text_x+text_x_offst,text_y-name_pos_y_temp+text_y_offst),v2(text_x,screen_y),text_size*6,_GF_RGBAToInt(tr,tg,tb,math.floor(255*_GT_veh_esp_table.text_vis.value)),_flags,nil)
					end
					scriptdraw.draw_sprite(blip,v2(screen_x,screen_y),size,rot,_GF_RGBAToInt(r,g,b,math.floor(255*_GT_veh_esp_table.vis.value)))
					if show_g then
						scriptdraw.draw_text("G",v2(screen_x*(2/3)+(_GT_veh_esp_table.god_x.value*0.01),screen_y*2+(name_pos_y_G)+(_GT_veh_esp_table.god_y.value*0.01)),v2(screen_x*(2/3),screen_y*2),size,_GF_RGBAToInt(255,0,0,math.floor(255*_GT_veh_esp_table.text_vis.value)),((1<<0)+(1<<2)+(1<<1)),nil)
					end
					
					
				end
			end
		end
	end
end)
_GT_veh_esp_table.feat.on=true

_GT_veh_esp_table.feat_record=menu.add_feature("Vehicle ESP record hidden", "toggle", _G_veh_esp_option.id, function(f)
	local all_veh,veh,r,g,b,pid,class,hash,prsnl,in_veh,pssngrs,frnd,is_me,ped_count
	local function show_my_veh()
		if _GT_veh_esp_table.show_veh_crrnt.on then
			return true
		elseif player.is_player_in_any_vehicle(player.player_id()) and player.get_player_vehicle(player.player_id()) == veh then
			return false
		end
		return true
	end
	local function record_veh()
		system.yield(5)
		r,g,b,pid,in_veh,pssngrs,frnd,is_me,ped_count = _GT_veh_esp_table.check_for_plyr(veh,true)
		_GT_veh_esp_table.veh_table[veh+1][1] = _GF_dist_me_ent(veh)
		_GT_veh_esp_table.veh_table[veh+1][2] = _GT_veh_esp_table.veh_table[veh+1][1]*_GT_veh_esp_table.math[_GT_veh_esp_table.dist_type.value+1]
		_GT_veh_esp_table.veh_table[veh+1][5] = r
		_GT_veh_esp_table.veh_table[veh+1][6] = g
		_GT_veh_esp_table.veh_table[veh+1][7] = b
		_GT_veh_esp_table.veh_table[veh+1][8] = pid
		--_GT_veh_esp_table.veh_table[veh+1][12] = prsnl
		_GT_veh_esp_table.veh_table[veh+1][13] = in_veh
		_GT_veh_esp_table.veh_table[veh+1][14] = pssngrs
		_GT_veh_esp_table.veh_table[veh+1][15] = entity.get_entity_god_mode(veh)
		_GT_veh_esp_table.veh_table[veh+1][16] = frnd
		_GT_veh_esp_table.veh_table[veh+1][17] = is_me
		_GT_veh_esp_table.veh_table[veh+1][18] = ped_count
	end
	local function show_non_plyr(_veh)
		if vehicle.get_vehicle_has_been_owned_by_player(_veh) then
			return true
		elseif _GT_veh_esp_table.show_veh_non_plyr.on then
			if _GT_veh_esp_table.show_veh_non_plyr.value == 1 then
				return _GF_does_veh_have_weap(_veh)
			else
				return true
			end
		end
		return false
	end
	local function show_ped_veh(_veh)
		return (_GF_does_veh_have_weap(_veh) and _GF_any_ped_in_veh(_veh))
	end
	while f.on do
		system.yield(25)
		all_veh=vehicle.get_all_vehicles()
		for i=1,#all_veh do
			veh = all_veh[i]
			system.yield(0)
			if _GT_veh_esp_table.veh_table[veh+1] == nil then
				_GT_veh_esp_table.veh_table_default(veh+1)
			end
			if _GT_veh_esp_table.good_esp_veh(veh) and show_my_veh() then
				class = vehicle.get_vehicle_class_name(veh)
				hash = entity.get_entity_model_hash(veh)
				if _GT_veh_esp_table.png_true[hash] then
					if show_non_plyr(veh) then -- if i have an image for that vehicle
						record_veh()
						_GT_veh_esp_table.veh_table[veh+1][3] = true
						_GT_veh_esp_table.veh_table[veh+1][4] = false
						_GT_veh_esp_table.veh_table[veh+1][9] = _GT_veh_esp_table.png_int[hash]
						_GT_veh_esp_table.veh_table[veh+1][10] = _GT_veh_esp_table.png_rot_true[hash]
						_GT_veh_esp_table.veh_table[veh+1][11] = (_GF_model_name(veh) == "Buzzard Attack Chopper" and (_GT_veh_esp_table.veh_table[veh+1][13] or _GF_any_ped_in_veh(veh)))
					else
						_GT_veh_esp_table.veh_table_default(veh+1)
					end
				elseif _GT_veh_esp_table.png_true[class] and (show_ped_veh(veh) or _GT_veh_esp_table.check_for_plyr(veh,false)) then
					record_veh()
					_GT_veh_esp_table.veh_table[veh+1][3] = false
					_GT_veh_esp_table.veh_table[veh+1][4] = true
					_GT_veh_esp_table.veh_table[veh+1][9] = _GT_veh_esp_table.png_int[class]
					_GT_veh_esp_table.veh_table[veh+1][10] = _GT_veh_esp_table.png_rot_true[class]
					_GT_veh_esp_table.veh_table[veh+1][11] = (class == "Helicopters" and (_GT_veh_esp_table.veh_table[veh+1][13] or _GF_any_ped_in_veh(veh)))
				else
					_GT_veh_esp_table.veh_table_default(veh+1)
				end
			else
				_GT_veh_esp_table.veh_table_default(veh+1)
			end
		end
		f.on = _GT_veh_esp_table.feat.on
	end
end)
_GT_veh_esp_table.feat_record.hidden=true

_GT_veh_esp_table.feat_record_prsnl=menu.add_feature("Vehicle ESP record prsnl hidden", "toggle", _G_veh_esp_option.id, function(f)
	local all_veh,veh,_prsnl
	local function is_prsnl_veh(_pid)
		return ((_GF_prsnl_veh(_pid) == veh) or (decorator.decor_get_int(veh, "Player_Vehicle") == network.network_hash_from_player(_pid)))
	end
	while f.on do
		system.yield(5)
		all_veh=vehicle.get_all_vehicles()
		for i=1,#all_veh do
			veh = all_veh[i]
			if _GT_veh_esp_table.veh_table[veh+1] == nil then
				_GT_veh_esp_table.veh_table_default(veh+1)
			end
			_prsnl=false
			for pid = 0,31 do
				if _GF_valid_pid(pid) and is_prsnl_veh(pid) then
					_prsnl =  pid
					break
				end
			end
			system.yield(5)
			_GT_veh_esp_table.veh_table[veh+1][12] = _prsnl
		end
		f.on = _GT_veh_esp_table.feat.on
	end
end)
_GT_veh_esp_table.feat_record_prsnl.hidden=true

function _GT_veh_esp_table.math_do()
	local function get_and_set_val(_feat)
		local _max = (_GT_veh_esp_table.math_max[_GT_veh_esp_table.dist_type.value+1])
		local _min = (_max*0.05)
		local _mod = (_max*0.05)
		local _val = (_max*(_feat.value/_feat.max))
		_GF_set_feat_i_f(_feat,_min,_max,_mod,_val)
	end
	get_and_set_val(_GT_veh_esp_table.dist)
	get_and_set_val(_GT_veh_esp_table.show_plyr_name)
	get_and_set_val(_GT_veh_esp_table.show_veh_name)
	get_and_set_val(_GT_veh_esp_table.show_veh_pssngr)
	get_and_set_val(_GT_veh_esp_table.show_veh_dist)
	get_and_set_val(_GT_veh_esp_table.line_near_dist)
	get_and_set_val(_GT_veh_esp_table.show_veh_health)
end

_GT_veh_esp_table.math = {
1, 				-- meter
0.001,			-- km
3.28084,		-- ft
1.09361,		-- yard
0.003645367,	-- footbal field
0.000621371,	-- mile
7.874016,		-- asian dick
3.937008		-- bbc
}

_GT_veh_esp_table.math_max ={}
for i=1,8 do
	_GT_veh_esp_table.math_max[i] = _GT_veh_esp_table.math[i]*2000
end

_GT_veh_esp_table.dist_type=menu.add_feature("Distance measurement","autoaction_value_str", _G_veh_esp_option.id, function(f)
	_GT_veh_esp_table.math_do()
end)_GT_veh_esp_table.dist_type:set_str_data({"Meters","Kilometers","Feet","Yards","Football fields","Miles","Tiny dick","BBC"})

_GT_veh_esp_table.vis = menu.add_feature("Blip visibility","autoaction_value_f",_G_veh_esp_option.id)
_GF_set_feat_i_f(_GT_veh_esp_table.vis,.1,1,.05,1)

_GT_veh_esp_table.dist = menu.add_feature("Blip max distance","autoaction_value_f",_G_veh_esp_option.id)
_GF_set_feat_i_f(_GT_veh_esp_table.dist,0.0001,100000,0.0001,1000)

_GT_veh_esp_table.blip_size = menu.add_feature("Blip size","autoaction_value_f",_G_veh_esp_option.id)
_GF_set_feat_i_f(_GT_veh_esp_table.blip_size,.25,2,.05,1)

_GT_veh_esp_table.blip_size_dist = menu.add_feature("Blip size/distance impact","autoaction_value_i",_G_veh_esp_option.id)
_GF_set_feat_i_f(_GT_veh_esp_table.blip_size_dist,1,10,1,1)

_GT_veh_esp_table.show_plyr_name = menu.add_feature("Show player name|Max dist:","value_f",_G_veh_esp_option.id)
_GF_set_feat_i_f(_GT_veh_esp_table.show_plyr_name,0.0001,100000,0.0001,2000)
_GT_veh_esp_table.show_plyr_name.on=true

_GT_veh_esp_table.show_veh_name = menu.add_feature("Show vehicle name|Max dist:","value_f",_G_veh_esp_option.id)
_GF_set_feat_i_f(_GT_veh_esp_table.show_veh_name,0.0001,100000,0.0001,700)
_GT_veh_esp_table.show_veh_name.on=true

_GT_veh_esp_table.show_veh_health = menu.add_feature("Show health|Max dist:","value_f",_G_veh_esp_option.id)
_GF_set_feat_i_f(_GT_veh_esp_table.show_veh_health,0.0001,100000,0.0001,700)
_GT_veh_esp_table.show_veh_health.on=true

_GT_veh_esp_table.show_veh_health_type=menu.add_feature("Vehicle health","action_value_str", _G_veh_esp_option.id)
_GT_veh_esp_table.show_veh_health_type:set_str_data({"Engine","Body","Enhanced total"})
_GT_veh_esp_table.show_veh_health_type.value=2

_GT_veh_esp_table.show_veh_pssngr = menu.add_feature("Show passenger count|Max dist:","value_f",_G_veh_esp_option.id)
_GF_set_feat_i_f(_GT_veh_esp_table.show_veh_pssngr,0.0001,100000,0.0001,700)
_GT_veh_esp_table.show_veh_pssngr.on=true

_GT_veh_esp_table.show_veh_dist = menu.add_feature("Show distance|Max dist:","value_f",_G_veh_esp_option.id)
_GF_set_feat_i_f(_GT_veh_esp_table.show_veh_dist,0.0001,100000,0.0001,700)
_GT_veh_esp_table.show_veh_dist.on=true

_GT_veh_esp_table.show_veh_prsnl = menu.add_feature("Show if personal vehicle (*P*)","toggle",_G_veh_esp_option.id)
_GT_veh_esp_table.show_veh_prsnl.on=true

_GT_veh_esp_table.show_veh_crrnt = menu.add_feature("Show current vehicle","toggle",_G_veh_esp_option.id)
_GT_veh_esp_table.show_veh_crrnt.on=true

_GT_veh_esp_table.show_veh_non_plyr = menu.add_feature("Show non-player vehicles","value_str",_G_veh_esp_option.id)
_GT_veh_esp_table.show_veh_non_plyr:set_str_data({"Always","If has weapons"})
_GT_veh_esp_table.show_veh_non_plyr.on=true
_GT_veh_esp_table.show_veh_non_plyr.value=1
-------------------------------------------------------------------------------------------------------------------------------
_GT_veh_esp_table.god_parent = menu.add_feature("Vehicle god","parent",_G_veh_esp_option.id)
_GT_veh_esp_table.show_veh_god = menu.add_feature("Show vehicle god","value_str",_GT_veh_esp_table.god_parent.id)
_GT_veh_esp_table.show_veh_god:set_str_data({"Red 'G'","Blink red","Both"})
_GT_veh_esp_table.show_veh_god.on=true

_GT_veh_esp_table.god_x = menu.add_feature("X Pos Offset", "action_value_f",_GT_veh_esp_table.god_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.god_x,-10,10,0.1,0)
_GT_veh_esp_table.god_y = menu.add_feature("Y Pos Offset", "action_value_f",_GT_veh_esp_table.god_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.god_y,-10,10,0.1,0)
-------------------------------------------------------------------------------------------------------------------------------
_GT_veh_esp_table.text_parent = menu.add_feature("ESP Text","parent",_G_veh_esp_option.id)

_GT_veh_esp_table.text_vis = menu.add_feature("Visibility","autoaction_value_f",_GT_veh_esp_table.text_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.text_vis,.1,1,.05,1)

_GT_veh_esp_table.text_size = menu.add_feature("Size","autoaction_value_f",_GT_veh_esp_table.text_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.text_size,.1,2,.05,1)

_GT_veh_esp_table.text_space = menu.add_feature("Spacing","action_value_f",_GT_veh_esp_table.text_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.text_space,.1,10,.05,1)

_GT_veh_esp_table.text_jstfctn = menu.add_feature("Justification", "action_value_str",_GT_veh_esp_table.text_parent.id) 
_GT_veh_esp_table.text_jstfctn.set_str_data(_GT_veh_esp_table.text_jstfctn,({"Left","Center","Right"}))
_GT_veh_esp_table.text_jstfctn.value=1

_GT_veh_esp_table.text_from_top = menu.add_feature("Display info stack","action_value_str",_GT_veh_esp_table.text_parent.id)
_GT_veh_esp_table.text_from_top.set_str_data(_GT_veh_esp_table.text_from_top,({"From top","Center","From bottom"}))

_GT_veh_esp_table.text_x = menu.add_feature("X Pos Offset", "action_value_f",_GT_veh_esp_table.text_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.text_x,-10,10,0.1,0)
_GT_veh_esp_table.text_y = menu.add_feature("Y Pos Offset", "action_value_f",_GT_veh_esp_table.text_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.text_y,-10,10,0.1,0)

_GT_veh_esp_table.text_r = menu.add_feature("Text R", "action_value_i",_GT_veh_esp_table.text_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.text_r,0,255,5,255)
_GT_veh_esp_table.text_g = menu.add_feature("Text G", "action_value_i",_GT_veh_esp_table.text_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.text_g,0,255,5,255)
_GT_veh_esp_table.text_b = menu.add_feature("Text B", "action_value_i",_GT_veh_esp_table.text_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.text_b,0,255,5,255)
-------------------------------------------------------------------------------------------------------------------------------
_GT_veh_esp_table.line_parent = menu.add_feature("ESP Lines","parent",_G_veh_esp_option.id)

_GT_veh_esp_table.line_feat=menu.add_feature("Show ESP Lines","value_str", _GT_veh_esp_table.line_parent.id)
_GT_veh_esp_table.line_feat:set_str_data({"Type 1","Type 2"})
_GT_veh_esp_table.line_feat.on=true

_GT_veh_esp_table.line_show_for=menu.add_feature("Vehicle selection","action_value_str", _GT_veh_esp_table.line_parent.id)
_GT_veh_esp_table.line_show_for:set_str_data({"Has player","No player","Both"})

_GT_veh_esp_table.line_near_dist = menu.add_feature("'Near' distance", "action_value_f",_GT_veh_esp_table.line_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_near_dist,0.0001,100000,0.0001,300)

_GT_veh_esp_table.line_near_parent = menu.add_feature("Near color","parent",_GT_veh_esp_table.line_parent.id)
_GT_veh_esp_table.line_far_parent = menu.add_feature("Far color","parent",_GT_veh_esp_table.line_parent.id)
_GT_veh_esp_table.line_friend_parent = menu.add_feature("Friend color","parent",_GT_veh_esp_table.line_parent.id)
_GT_veh_esp_table.line_self_parent = menu.add_feature("Self color","parent",_GT_veh_esp_table.line_parent.id)
-------------------------------------------------------------------------------------------------------------------------------
_GT_veh_esp_table.line_near_r = menu.add_feature("Line R", "action_value_i",_GT_veh_esp_table.line_near_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_near_r,0,255,5,255)
_GT_veh_esp_table.line_near_g = menu.add_feature("Line G", "action_value_i",_GT_veh_esp_table.line_near_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_near_g,0,255,5,0)
_GT_veh_esp_table.line_near_b = menu.add_feature("Line B", "action_value_i",_GT_veh_esp_table.line_near_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_near_b,0,255,5,0)
_GT_veh_esp_table.line_near_a = menu.add_feature("Line A", "action_value_i",_GT_veh_esp_table.line_near_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_near_a,0,255,5,255)
-------------------------------------------------------------------------------------------------------------------------------
_GT_veh_esp_table.line_far_r = menu.add_feature("Line R", "action_value_i",_GT_veh_esp_table.line_far_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_far_r,0,255,5,255)
_GT_veh_esp_table.line_far_g = menu.add_feature("Line G", "action_value_i",_GT_veh_esp_table.line_far_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_far_g,0,255,5,160)
_GT_veh_esp_table.line_far_b = menu.add_feature("Line B", "action_value_i",_GT_veh_esp_table.line_far_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_far_b,0,255,5,0)
_GT_veh_esp_table.line_far_a = menu.add_feature("Line A", "action_value_i",_GT_veh_esp_table.line_far_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_far_a,0,255,5,150)
-------------------------------------------------------------------------------------------------------------------------------
_GT_veh_esp_table.line_frnd_r = menu.add_feature("Line R", "action_value_i",_GT_veh_esp_table.line_friend_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_frnd_r,0,255,5,93)
_GT_veh_esp_table.line_frnd_g = menu.add_feature("Line G", "action_value_i",_GT_veh_esp_table.line_friend_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_frnd_g,0,255,5,182)
_GT_veh_esp_table.line_frnd_b = menu.add_feature("Line B", "action_value_i",_GT_veh_esp_table.line_friend_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_frnd_b,0,255,5,229)
_GT_veh_esp_table.line_frnd_a = menu.add_feature("Line A", "action_value_i",_GT_veh_esp_table.line_friend_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_frnd_a,0,255,5,150)
-------------------------------------------------------------------------------------------------------------------------------
_GT_veh_esp_table.line_self_r = menu.add_feature("Line R", "action_value_i",_GT_veh_esp_table.line_self_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_self_r,0,255,5,0)
_GT_veh_esp_table.line_self_g = menu.add_feature("Line G", "action_value_i",_GT_veh_esp_table.line_self_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_self_g,0,255,5,255)
_GT_veh_esp_table.line_self_b = menu.add_feature("Line B", "action_value_i",_GT_veh_esp_table.line_self_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_self_b,0,255,5,0)
_GT_veh_esp_table.line_self_a = menu.add_feature("Line A", "action_value_i",_GT_veh_esp_table.line_self_parent.id)
_GF_set_feat_i_f(_GT_veh_esp_table.line_self_a,0,255,5,150)

print("Vehicle ESP loaded        - "..(utils.time_ms()-_G_load_time_temp).."ms - Line: "..debug.getinfo(1).currentline)
_G_load_time_temp = utils.time_ms()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_GT_plate={}
_GT_plate.text="Gee-Skid"

function _GT_plate.file_check()
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	if not utils.dir_exists(directory) then
		utils.make_dir(directory)
	end
	if not utils.file_exists(directory.."repair.txt") then
		local file = io.open(directory.."repair.txt", "a")
		file:write("Gee-Skid")
		file:close()
	end
end

function _GT_plate.file_get()
	_GT_plate.file_check()
	local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
	local file = io.open(directory.."repair.txt", "r")
	local plate = "Gee-Skid"
	for line in file:lines() do
		if line ~= nil and string.len(tostring(line)) < 9 then
			plate = tostring(line)
			break
		end
	end
	file:close()
	return plate
end

_GT_plate.tog=menu.add_feature("Use custom text", "toggle", _G_veh_rpr_plate.id, function(f)
	if f.on then
		local plate = _GT_plate.file_get()
		f.name = "Use custom text: "..plate
		_GT_plate.text=plate
	end
end)
_GT_plate.tog.on=true

_GT_plate.set=menu.add_feature("Set custom license plate", "action_value_str", _G_veh_rpr_plate.id, function(f)
	if f.value == 0 then
		_GT_plate.tog.name="Use custom text: Gee-Skid"
		_GT_plate.text="Gee-Skid"
	else
		local status,str = 1
		status,str = _GF_text_input_get("Non alpha-numeric characters act as blank space","Gee-Skid",8,0)
		if status == 0 then
			_GT_plate.file_check()
			local directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\plate\\"
			local file = io.open(directory.."repair.txt", "w")
			file:write(str)
			file:close()
			_GT_plate.tog.name="Use custom text: "..str
			_GT_plate.text=str
		end
	end
end)_GT_plate.set:set_str_data({"Gee-Skid","Custom"})

_GT_plate.style_tog=menu.add_feature("Use plate style", "value_str", _G_veh_rpr_plate.id)
_GT_plate.style_tog:set_str_data({"Blue/White","Yellow/black","Yellow/Blue","Blue/White2","Blue/White3","Yankton"})
_GT_plate.style_tog.value=1
_GT_plate.style_tog.on=true
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

_G_plyr_JL_notif=menu.add_feature("Show player info notification", "value_str", _G_Options.id, function(f)
end)_G_plyr_JL_notif:set_str_data({"Joining/Leaving","Joining","Leaving"})

_G_ff_auto_kick=menu.add_feature("Auto-Kick fake friends with join timeout enabled", "toggle", _G_Options.id, function(f)
	local directory,file_path,file,contents,_start,_end,_last,scid_table,pid_table,_scid,_pid,_ff_sett,_ff_name
	while f.on do
		scid_table,pid_table = _GF_scid_pid_tables()
		directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\cfg\\"
		if not utils.dir_exists(directory) then
			utils.make_dir(directory)
		end
		file_path = "scid"
		if not utils.file_exists(directory..file_path..".cfg") then
			file = io.open(directory..file_path..".cfg", "a")
			file:write("[SCID]")
			file:close()
		end
		file = io.open(directory..file_path..".cfg", "r")
		for line in file:lines() do
			if line == nil then
				break
			else
				_start,_end = string.find(line, ":")
				if _start ~= nil and _end ~= nil then
					--print(string.sub(line,1,_end-1))
					_ff_name = string.sub(line,1,_end-1)
					_last = _end+1
					_start,_end = string.find(line, ":",_last) 
					if _start ~= nil and _end ~= nil then
						--print(string.sub(line,_last,_end-1))
						if scid_table[tonumber(string.sub(line,_last,_end-1),16)] then
							_scid = tonumber(string.sub(line,_last,_end-1),16)
							_pid = pid_table[_scid]
							print("Match found "..string.sub(line,_last,_end-1).." ".._scid.." name ".._GF_plyr_name(_pid).." PID ".._pid)
						else
							_scid = -1
							_pid = -1
						end
						if _scid ~= -1 then
							_last = _end+1
							if string.sub(line,_last,string.len(line)) ~= nil then
								--print(string.sub(line,_last,string.len(line)))
								_ff_sett = string.sub(line,_last,string.len(line))
								if _GT_fake_friend_timeout[_ff_sett] then
									print("Join timeout enabled "..string.sub(line,_last,_end-1).." ".._scid.." FF name ".._ff_name.." name ".._GF_plyr_name(_pid).." PID ".._pid)
									_GF_plyr_kick(_pid,true,"Fake friend",_ff_name)
									system.yield(250)
								end
							end
						end
					end
				end
			end
			system.yield(0)
		end
		io.close(file)
		system.yield(1000)
	end
end)

_G_auto_re_kick=menu.add_feature("Auto-Re-Kick", "value_str", _G_Options.id, function(f)
	local scid_table,pid_table,directory,file_path,file,_start,_end,_last,_scid,_pid,_prev_name,plyr_leave
	if f.on then
        plyr_leave = event.add_event_listener("player_leave", function(listener) --rulypancake 2t1scriptadditions thanks
            if listener.player == player.player_id() and f.value == 0 then
       			_GT_kicked_table_mem={}
				menu.notify("Kicked table reset",_G_GeeVer,10)
            end
        end)
	end
	while f.on do
		system.yield(1000)
		scid_table,pid_table = _GF_scid_pid_tables()
		if f.value ~= 2 then
			for i=1, #_GT_kicked_table_mem do
				if scid_table[_GT_kicked_table_mem[i]] then
					_GF_plyr_kick(pid_table[_GT_kicked_table_mem[i]])
					system.yield(250)
					break
				end
			end
		else
			directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\Logs\\kicked\\"
			if utils.dir_exists(directory) then
				file_path = "players_kicked"
				if utils.file_exists(directory..file_path..".csv") then
					file = io.open(directory..file_path..".csv", "r")
					for line in file:lines() do
						if line == nil then
							break
						else
							_start,_end = string.find(line, ",")
							if _start ~= nil and _end ~= nil then
								_date = string.sub(line,1,_end-1)
								_last = _end+1
								--menu.notify("First set "..tostring(string.sub(line,1,_end-1)).."",_G_GeeVer,10)
								_start,_end = string.find(line, ",",_last) 
								if _start ~= nil and _end ~= nil then
									if scid_table[tonumber(string.sub(line,_last,_end-1))] then
										_scid = tonumber(string.sub(line,_last,_end-1))
										_pid = pid_table[_scid]
										--menu.notify("Second set "..tostring(string.sub(line,_last,_end-1)).."",_G_GeeVer,10)
										--print("Match found ".._scid.." name ".._GF_plyr_name(_pid).." PID ".._pid)
									else
										_scid = -1
										_pid = -1
									end
									if _scid ~= -1 then
										_last = _end+1
										_prev_name = "Unknown"
										if string.sub(line,_last,string.len(line)) ~= nil then
											_prev_name = string.sub(line,_last,string.len(line))
										end
										print("Previously kicked player "..string.sub(line,_last,_end-1).." ".._scid.." Previous name ".._prev_name.." Current name ".._GF_plyr_name(_pid).." PID ".._pid)
										_GF_plyr_kick(_pid,true,"Previously kicked",_prev_name)
										system.yield(250)
										break
									end
								end
							end
						end
						system.yield(0)
					end
					io.close(file)
				end
			end
		end
	end
	event.remove_event_listener("player_leave", plyr_leave)
end)_G_auto_re_kick.set_str_data(_G_auto_re_kick,{"This session", "Until Lua reset","All kick history"})
_G_auto_re_kick.value=1

function _GF_scid_pid_tables()
	local scid_table = {}
	local pid_table = {}
	for i=0,31 do
		if _GF_valid_pid(i) and i ~= player.player_id() and not player.is_player_friend(i) then
			scid_table[player.get_player_scid(i)] = true
			pid_table[player.get_player_scid(i)] = i
		end
	end
	return scid_table,pid_table
end

_GT_fake_friend_timeout = {
["4"] = true, -- 	timeout
["14"] = true, -- 	timeout	friend
["1c"] = true, -- 	timeout	friend	hide 
["1d"] = true, -- 	timeout	friend	hide	stalk 
["d"] = true,  -- 	timeout			hide	stalk 
["15"] = true,  -- 	timeout	friend			stalk 
["c"] = true,  --	timeout			hide
["5"] = true, --    timeout					stalk
}
print("Auto kicks loaded         - "..(utils.time_ms()-_G_load_time_temp).."ms - Line: "..debug.getinfo(1).currentline)
_G_load_time_temp = utils.time_ms()

_GF_set_wnt_self=menu.add_feature("Set wanted level", "value_i", _G_Self.id, function(f)
	while f.on do
		_GF_yield_while_true(f.on,750)
		_GF_set_wnt_all_psngrs(player.player_id(),f.value)
	end
end)_GF_set_feat_i_f(_GF_set_wnt_self,0,5,1,0)

menu.add_feature("Fake passive", "toggle", _G_Self.id, function(f)
	local my_veh,all_veh,all_peds,time
	while f.on do
		entity.set_entity_alpha(player.get_player_ped(player.player_id()), 153, false)
		if _GF_me_in_any_veh() then
			my_veh = player.get_player_vehicle(player.player_id())
			entity.set_entity_alpha(player.get_player_vehicle(player.player_id()), 153, false)
			all_veh = vehicle.get_all_vehicles()
			for i=1, #all_veh do
				if _GF_player_driving(all_veh[i]) then
					entity.set_entity_no_collision_entity(all_veh[i],player.get_player_vehicle(player.player_id()), true)
					entity.set_entity_no_collision_entity(player.get_player_vehicle(player.player_id()),all_veh[i], true)
				end
			end
			all_peds = ped.get_all_peds()
			for i=1,#all_peds do	
				if ped.is_ped_a_player(all_peds[i]) then
					entity.set_entity_no_collision_entity(all_peds[i], player.get_player_vehicle(player.player_id()), true)
					entity.set_entity_no_collision_entity(player.get_player_vehicle(player.player_id()), all_peds[i], true)
				end
			end
		elseif _GF_valid_veh(my_veh) then
			entity.set_entity_collision(my_veh,true,true)
			entity.set_entity_alpha(my_veh, 255, true)
			my_veh = -1
		else
			my_veh = -1
			all_veh = vehicle.get_all_vehicles()
			for i =1, #all_veh do
				if _GF_player_driving(all_veh[i]) then
					entity.set_entity_no_collision_entity(all_veh[i], player.get_player_ped(player.player_id()), true)
					entity.set_entity_no_collision_entity(player.get_player_ped(player.player_id()), all_veh[i], true)
				end
			end
			all_peds = ped.get_all_peds()
			for i=1,#all_peds do	
				if ped.is_ped_a_player(all_peds[i]) then
					entity.set_entity_no_collision_entity(all_peds[i], player.get_player_ped(player.player_id()), true)
					entity.set_entity_no_collision_entity(player.get_player_ped(player.player_id()), all_peds[i], true)
				end
			end
		end
		system.yield(0)
	end
	entity.set_entity_collision(player.get_player_ped(player.player_id()),true,true)
	entity.set_entity_alpha(player.get_player_ped(player.player_id()), 255, true)
	if _GF_me_in_any_veh() then
		entity.set_entity_collision(player.get_player_vehicle(player.player_id()),true,true)
		entity.set_entity_alpha(player.get_player_vehicle(player.player_id()), 255, true)
	elseif _GF_valid_veh(my_veh) then
		entity.set_entity_collision(my_veh,true,true)
		entity.set_entity_alpha(my_veh, 255, true)
		my_veh = -1
	end
end)

-----------------------------------------------------------------------------------------------------------------------------
	
_G_never_ped_fire=menu.add_feature("Never on fire","toggle",_G_SelfPed.id,function(f)
	while f.on do
		system.yield(0)
		_GF_rpr_fire(player.get_player_ped(player.player_id()))
	end
end)

_G_GeeLook=menu.add_feature("Lock body/cam on foot", "value_str", _G_SelfPed.id, function(f)
	local time,my_ped,my_rot,rot=utils.time_ms()
    while f.on do
		system.yield(0)
		if not _GF_me_in_any_veh() then
			my_ped = player.get_player_ped(player.player_id())
			if not ped.is_ped_swimming(my_ped) and not ped.is_ped_ragdoll(my_ped) and not entity.is_entity_in_air(my_ped) then
				if _GF_key_active(32,1) then
					time=utils.time_ms()+3000
				end
				my_rot = entity.get_entity_rotation(my_ped)
				rot = cam.get_gameplay_cam_rot()
				my_rot.z = rot.z
				if f.value == 0 and _GF_key_active(32,1) and _GF_key_active(21,0) then --While Walking
					if _GF_key_active(34,1) and _GF_key_active(35,0) then
						my_rot.z=my_rot.z+50
					elseif _GF_key_active(35,1) and _GF_key_active(34,0) then
						my_rot.z=my_rot.z-50
					end
					entity.set_entity_rotation(my_ped,my_rot)
				elseif f.value == 1 and _GF_key_active(32,1) and _GF_key_active(21,1) then --While Running
					if _GF_key_active(34,1) and _GF_key_active(35,0) then
						my_rot.z=my_rot.z+50
					elseif _GF_key_active(35,1) and _GF_key_active(34,0) then
						my_rot.z=my_rot.z-50
					end
					entity.set_entity_rotation(my_ped,my_rot)
				elseif f.value == 2 and _GF_key_active(32,1) then --Walking & Running
					if _GF_key_active(34,1) and _GF_key_active(35,0) then
						my_rot.z=my_rot.z+50
					elseif _GF_key_active(35,1) and _GF_key_active(34,0) then
						my_rot.z=my_rot.z-50
					end
					entity.set_entity_rotation(my_ped,my_rot)
				elseif f.value == 3 and _GF_key_active(33,0) then --While on foot
					if time > utils.time_ms() then
						if _GF_key_active(34,1) and _GF_key_active(35,0) then
							my_rot.z=my_rot.z+50
						elseif _GF_key_active(35,1) and _GF_key_active(34,0) then
							my_rot.z=my_rot.z-50
						end
						entity.set_entity_rotation(my_ped,my_rot)
					end
				elseif f.value == 4 and _GF_key_active(32,0) and _GF_key_active(21,0) and _GF_key_active(33,0) and _GF_key_active(34,0) and _GF_key_active(35,0) then --Not running/walking
					if time > utils.time_ms() then
						entity.set_entity_rotation(my_ped,my_rot)
					end
				end
			end
		end
	end
end)_G_GeeLook:set_str_data({"While Walking", "While Running","Walking & Running","While on foot","Not running/walking"})

_G_GeeSwim=menu.add_feature("Lock body/cam in water", "value_str", _G_SelfPed.id, function(f)
    local my_ped,my_rot,rot
	while f.on do
		system.yield(0)
		if not _GF_me_in_any_veh() then
			my_ped = player.get_player_ped(player.player_id())
			if ped.is_ped_swimming(my_ped) and not ped.is_ped_ragdoll(my_ped) then
				my_rot = entity.get_entity_rotation(my_ped)
				rot = cam.get_gameplay_cam_rot()
				my_rot.z = rot.z
				if f.value == 0 and ped.is_ped_swimming_underwater(my_ped) then
					entity.set_entity_rotation(my_ped,my_rot)
				elseif f.value == 1 and not ped.is_ped_swimming_underwater(my_ped) then
					entity.set_entity_rotation(my_ped,my_rot)
				elseif f.value == 2 then
					entity.set_entity_rotation(my_ped,my_rot)
				elseif f.value == 3 and _GF_key_active(21,1) then
					entity.set_entity_rotation(my_ped,my_rot)
				elseif f.value == 4 then
					if not ped.is_ped_swimming_underwater(my_ped) then
						if _GF_key_active(21,0) and _GF_key_active(32,0) then
							entity.set_entity_rotation(my_ped,my_rot)
						end
					elseif _GF_key_active(21,0) then
						entity.set_entity_rotation(my_ped,my_rot)
					end
				end
			end
		end
	end
end)_G_GeeSwim:set_str_data({"While underwater", "While above water","While in water", "While swimming","Not swimming"})

_G_GeeLookFall=menu.add_feature("Lock body/cam in air (not parachute)", "toggle", _G_SelfPed.id, function(f)
    local my_ped,my_rot,rot
    while f.on do
		system.yield(0)
		if not _GF_me_in_any_veh() then
			my_ped = player.get_player_ped(player.player_id())
			if not ped.is_ped_swimming(my_ped) and not ped.is_ped_ragdoll(my_ped) and entity.is_entity_in_air(my_ped) then
				my_rot = entity.get_entity_rotation(my_ped)
				rot = cam.get_gameplay_cam_rot()
				my_rot.z = rot.z
				entity.set_entity_rotation(my_ped,my_rot)
			end
		end
	end
end)

_G_GeeParaAuto=menu.add_feature("Auto-get parachute", "toggle", _G_SelfPed.id, function(f)
    while f.on do
		if not weapon.has_ped_got_weapon(player.get_player_ped(player.player_id()), gameplay.get_hash_key("gadget_parachute")) then
			weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), gameplay.get_hash_key("gadget_parachute"), 100, true)
		end
		system.yield(500)
	end
end)

_G_GeeSlowFall=menu.add_feature("Limit speed while free-falling", "value_i", _G_SelfPed.id, function(f)
	local my_ped,velocity,fall_speed,val
    while f.on do
		system.yield(0)
		if not _GF_me_in_any_veh() then
			my_ped = player.get_player_ped(player.player_id())
			if entity.is_entity_in_air(my_ped) and _GF_key_active(32,0) then 
				velocity = entity.get_entity_velocity(my_ped)
				fall_speed = velocity.z
				fall_speed = fall_speed * 2.236936
				val = f.value*-1
				if val > fall_speed then
					velocity.z=val
					entity.set_entity_velocity(my_ped,velocity)
				end
			end
		end
	end
end)_G_GeeSlowFall.max,_G_GeeSlowFall.min,_G_GeeSlowFall.mod=70,0,5		
_G_GeeSlowFall.value=40

----------------------------------------------------------------------------------------Gee-Watch
----------------------------------------------------------------------------AKA-Universe Watchdog
-------------------------------------several improvements and corrections - so much fuckin better

_GT_GW_ntr={}

_G_GW_aim_ent=nil
_G_watch_dog=menu.add_feature("Gee-Watch mode", "toggle", _G_Self.id, function(f)
	local plyr_name_count=0
	local vk_xpld,vk_dmg,vk_brd,vk_accl,vk_rvrs,vk_rpr,vk_ele,vk_de_ele_rag,vk_upgr,vk_brn,vk_kck,vk_god,vk_ntr
	local aim_ent,aim_veh,force,hit, ray_pos, ray_ent,veh_peds,good,target_pos
	if f.on and _GF_GS_is_loaded() then
		menu.notify("Gee-Watch Enabled\nRight click to use",_G_GeeVer,10)
	end
	while f.on do
		system.yield(0)
		vk_xpld=_GT_keys_vk_name[_G_GeeWatchExplode_key.value+1]
		vk_dmg=_GT_keys_vk_name[_G_GeeWatchDamDes_key.value+1]
		vk_brd=_GT_keys_vk_name[_G_GeeWatchBoard_key.value+1]
		vk_accl=_GT_keys_vk_name[_G_GeeWatchAccel_key.value+1]
		vk_rvrs=_GT_keys_vk_name[_G_GeeWatchRvrs_key.value+1]
		vk_rpr=_GT_keys_vk_name[_G_GeeWatchRepair_key.value+1]
		vk_ele=_GT_keys_vk_name[_G_GeeWatchElev_key.value+1]
		vk_de_ele_rag=_GT_keys_vk_name[_G_GeeWatchDeEleRag_key.value+1]
		vk_upgr=_GT_keys_vk_name[_G_GeeWatchUpgrade_key.value+1]
		vk_brn=_GT_keys_vk_name[_G_GeeWatchBurn_key.value+1]
		vk_kck=_GT_keys_vk_name[_G_GeeWatchKick_key.value+1]
		vk_god=_GT_keys_vk_name[_G_GeeWatchGod_key.value+1]
		vk_ntr=_GT_keys_vk_name[_G_GeeWatchNtr_key.value+1]
		while ( _GF_key_active(114,1) or player.is_player_free_aiming(player.player_id())) and _GT_plyr_info.typing[player.player_id()+1]==false do
			system.yield(50)
			if _GF_is_ent(player.get_entity_player_is_aiming_at(player.player_id())) then
				aim_ent=player.get_entity_player_is_aiming_at(player.player_id())
			else		
				aim_ent = _GF_raycast_vector(nil,true)
			end
			_G_GW_aim_ent=aim_ent
			if _GF_is_ent(aim_ent) then
				_G_watch_dog_overlay.on=true
--for all ped/veh/player
				if _GF_GW_vk_key_down(vk_xpld) and (entity.is_entity_a_ped(aim_ent) or entity.is_entity_a_vehicle(aim_ent)) then ----------------------X:explode
					if not entity.is_entity_dead(aim_ent) and _GF_GW_GE_no_interfere(_G_GeeWatchExplode_key) then
						fire.add_explosion(entity.get_entity_coords(aim_ent),0, true, false, 0,aim_ent)
					end
				end
--for ped cars
				if entity.is_entity_a_ped(aim_ent) and not ped.is_ped_a_player(aim_ent) then
					if ped.is_ped_in_any_vehicle(aim_ent) then
						aim_veh = ped.get_vehicle_ped_is_using(aim_ent)
						if _GF_GW_vk_key_down(vk_brd) and _GF_GW_GE_no_interfere(_G_GeeWatchBoard_key) then  ------------------------------------------F:boarding
							_GF_GW_board(vk_brd,aim_veh)
						elseif _GF_GW_vk_key_down(vk_dmg) and not  _GF_is_dead(aim_veh) and _GF_GW_GE_no_interfere(_G_GeeWatchDamDes_key) then --~:damage/destroy
							_GF_veh_damage_or_destroy(aim_veh,1000, _GF_veh_ped_name(aim_veh,"first_plyr"), _GF_model_name(aim_veh))
						elseif _GF_GW_vk_key_down(vk_accl) and _GF_GW_GE_no_interfere(_G_GeeWatchAccel_key) then ----------------------------------- E:accelerate
							_GF_veh_accel(aim_veh,1000)
						elseif  _GF_GW_vk_key_down(vk_rvrs) and _GF_GW_GE_no_interfere(_G_GeeWatchRvrs_key) then -------------------------------------C:Reversing
							_GF_veh_revers(aim_veh,1000)
						elseif  _GF_GW_vk_key_down(vk_rpr) and _GF_GW_GE_no_interfere(_G_GeeWatchRepair_key) then ---------------------------------------R:Repair
							_GF_veh_repair_basic(aim_veh, 1000)
						elseif  _GF_GW_vk_key_down(vk_ele) and _GF_GW_GE_no_interfere(_G_GeeWatchElev_key) then ------------------------------------Q for elevate
							_GF_elevate(aim_veh,1000)
						elseif  _GF_GW_vk_key_down(vk_upgr) and _GF_GW_GE_no_interfere(_G_GeeWatchUpgrade_key) then --------------------------------U for upgrade
							_GF_veh_upgr_all_kek(aim_veh, 1000, false)
							veh_peds = _GF_all_peds_in_veh(aim_veh,false,nil)
							for i=1, #veh_peds do
								_GF_ped_combat_attrib(veh_peds[i],true,100,true)
								_GF_set_ped_health(veh_peds[i],2500,100)
								_GF_give_ped_weap(veh_peds[i],"weapon_machinepistol")
								_GF_give_ped_weap(veh_peds[i],"weapon_combatmg_mk2")
							end
						elseif  _GF_GW_vk_key_down(vk_de_ele_rag) and _GF_GW_GE_no_interfere(_G_GeeWatchDeEleRag_key) then  ---------------------z for de-elevate
							_G_W_de_elevate(aim_veh,1000)
						elseif  _GF_GW_vk_key_down(vk_brn) and _GF_GW_GE_no_interfere(_G_GeeWatchBurn_key) then -------------------------------------------V:burn	
							if not _GF_is_dead(aim_veh) then
								_GF_fire_expl_ent_pid(aim_veh, 0, 180, math.random(0,7), 3, 0)
								_GF_fire_expl_ent_pid(aim_veh, 0, 180, math.random(0,2), 3, 0)
								fire.start_entity_fire(aim_veh)
							end
							veh_peds = _GF_all_peds_in_veh(aim_veh,nil,false)
							for i=1, #veh_peds do
								_GF_fire_expl_ent_pid(veh_peds[i], 0, 180, math.random(0,1), 3, 0)
								fire.start_entity_fire(veh_peds[i])
							end
						elseif  _GF_GW_vk_key_down(vk_god) and _GF_GW_GE_no_interfere(_G_GeeWatchGod_key) then -------------------------------------H: God toggle
							_GF_ent_god_toggle(aim_veh,1000,nil)
							veh_peds = _GF_all_peds_in_veh(aim_veh,false,false)
							for i=1, #veh_peds do
								_GF_ent_god_toggle(veh_peds[i],100,entity.get_entity_god_mode(aim_veh))
							end
							system.yield(50)
						elseif  _GF_GW_vk_key_down(vk_ntr) and _GF_GW_GE_no_interfere(_G_GeeWatchNtr_key) then -------------------------------------N: Neuter
							_GF_GW_neuter(aim_veh,1000)
							veh_peds = _GF_all_peds_in_veh(aim_veh,false,false)
							for i=1, #veh_peds do
								_GF_GW_neuter(veh_peds[i],250)
							end
							system.yield(50)
						end
--for peds
					elseif  _GF_GW_vk_key_down(vk_dmg) and _GF_GW_GE_no_interfere(_G_GeeWatchDamDes_key) then -------------------------------------- ~:delete ped
						if _GF_request_ctrl(aim_ent,100) then 
							entity.delete_entity(aim_ent,1000)
						end
					elseif  _GF_GW_vk_key_down(vk_brn) and not _GF_is_dead(aim_ent) and _GF_GW_GE_no_interfere(_G_GeeWatchBurn_key) then ------------------V:burn
						_GF_fire_expl_ent_pid(aim_ent, 0, 180, math.random(0,1), 3, 0)
						fire.start_entity_fire(aim_ent)
					elseif  _GF_GW_vk_key_down(vk_accl) and _GF_GW_GE_no_interfere(_G_GeeWatchAccel_key) then -------------------------------------- E:accelerate
						_GF_ped_force(aim_ent, 100,"forward")
					elseif  _GF_GW_vk_key_down(vk_ele) and _GF_GW_GE_no_interfere(_G_GeeWatchElev_key) then-----------------------------------------Q for elevate
						_GF_ped_force(aim_ent, 100,"up")
					elseif _GF_GW_vk_key_down(vk_de_ele_rag) and _GF_GW_GE_no_interfere(_G_GeeWatchDeEleRag_key) then  -----------------------------z for ragdoll
						if _GF_ped_ragdoll(aim_ent,true,100) then
							ped.set_ped_to_ragdoll(aim_ent,1000,1000,0)
						end
					elseif  _GF_GW_vk_key_down(vk_upgr) and _GF_GW_GE_no_interfere(_G_GeeWatchUpgrade_key) then ------------------------------------U for upgrade
						_GF_ped_combat_attrib(aim_ent,true,100,true)
						_GF_set_ped_health(aim_ent,2500,100)
						_GF_give_ped_weap(aim_ent,"weapon_machinepistol")
						_GF_give_ped_weap(aim_ent,"weapon_combatmg_mk2")
					elseif  _GF_GW_vk_key_down(vk_god) and _GF_GW_GE_no_interfere(_G_GeeWatchGod_key) then -----------------------------------------H: God toggle
						_GF_ent_god_toggle(aim_ent,100,nil)
						system.yield(50)
					elseif  _GF_GW_vk_key_down(vk_ntr) and _GF_GW_GE_no_interfere(_G_GeeWatchNtr_key) then -----------------------------------------N: Neuter
						_GF_GW_neuter(aim_ent,1000)
						system.yield(50)
					end
					-- if plyr_name_count ==0 and entity.get_entity_model_hash(aim_ent) == 0x15F8700D then --just to help remove unwanted tp pos from tptable
						-- local pos = entity.get_entity_coords(aim_ent)
						-- local x = _GF_2_decimals(pos.x)
						-- local y = _GF_2_decimals(pos.y)
						-- local z = _GF_2_decimals(pos.z)
						-- menu.notify("police ped v3("..x..","..y..","..z..")" , _G_GeeVer, 4, 2)
						-- plyr_name_count=1
						-- local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\need_to_delete.cfg","a")
						-- local blip = ui.add_blip_for_coord(pos)
						-- ui.set_blip_colour(blip,1)
						-- local record = ''
						-- record=record..'\nv3('..x..','..y..','..z..'),'
						-- local _G_write_msg=""
						-- _G_write_msg=_G_write_msg..record
						-- file:write(_G_write_msg)
						-- file:close()
					-- end
		--for vehicles
				elseif entity.is_entity_a_vehicle(aim_ent) then
					if  _GF_GW_vk_key_down(vk_brd)  and _GF_GW_GE_no_interfere(_G_GeeWatchBoard_key) then --------------------------------------------F:boarding
						_GF_GW_board(vk_brd,aim_ent)
					elseif  _GF_GW_vk_key_down(vk_dmg) and not _GF_is_dead(aim_ent)  and _GF_GW_GE_no_interfere(_G_GeeWatchDamDes_key) then ----~:damage/destroy
						_GF_veh_damage_or_destroy(aim_ent, 1000, _GF_veh_ped_name(aim_ent,"first_plyr"), _GF_model_name(aim_ent))
					elseif  _GF_GW_vk_key_down(vk_brn) and not _GF_is_dead(aim_ent) and _GF_GW_GE_no_interfere(_G_GeeWatchBurn_key) then -----------------V:burn
						fire.start_entity_fire(aim_ent)
						_GF_fire_expl_ent_pid(aim_ent, 0, 180, math.random(0,1), 3, 0)
						_GF_fire_expl_ent_pid(aim_ent, 0, 180, math.random(1,2), 3, 0)
					elseif  _GF_GW_vk_key_down(vk_accl) and _GF_GW_GE_no_interfere(_G_GeeWatchAccel_key) then ------------------------------------- E:accelerate
						_GF_veh_accel(aim_ent,1000)
					elseif _GF_GW_vk_key_down(vk_rvrs) and _GF_GW_GE_no_interfere(_G_GeeWatchRvrs_key) then -----------------------------------------C:Reversing
						_GF_veh_revers(aim_ent,1000)
					elseif _GF_GW_vk_key_down(vk_rpr)  and _GF_GW_GE_no_interfere(_G_GeeWatchRepair_key) then ------------------------------------------R:Repair
						_GF_veh_repair_basic(aim_ent, 1000)
					elseif _GF_GW_vk_key_down(vk_ele) and _GF_GW_GE_no_interfere(_G_GeeWatchElev_key) then ----------------------------------------Q for elevate
						_GF_elevate(aim_ent,1000)
					elseif  _GF_GW_vk_key_down(vk_upgr) and _GF_GW_GE_no_interfere(_G_GeeWatchUpgrade_key) then -----------------------------------U for upgrade
						_GF_veh_upgr_all_kek(aim_ent, 1000, false)
					elseif _GF_GW_vk_key_down(vk_de_ele_rag) and _GF_GW_GE_no_interfere(_G_GeeWatchDeEleRag_key) then  -------------------------z for de-elevate
						_G_W_de_elevate(aim_ent,1000)
					elseif  _GF_GW_vk_key_down(vk_god) and _GF_GW_GE_no_interfere(_G_GeeWatchGod_key) then ----------------------------------------H: God toggle
						_GF_ent_god_toggle(aim_ent,100,nil)
						system.yield(50)
					elseif  _GF_GW_vk_key_down(vk_ntr) and _GF_GW_GE_no_interfere(_G_GeeWatchNtr_key) then -----------------------------------------N: Neuter
						_GF_GW_neuter(aim_ent,1000)
						system.yield(50)
					end
		--for players
				elseif entity.is_entity_a_ped(aim_ent) and ped.is_ped_a_player(aim_ent) then
					if _G_gee_watch_player_info.on and plyr_name_count==0 and _GF_GW_plyr_info(player.get_player_from_ped(aim_ent)) then
						plyr_name_count=1
					end
					if not ped.is_ped_in_any_vehicle(aim_ent) then
						if _GF_GW_vk_key_down(vk_brn) and not _GF_is_dead(aim_ent) and _GF_GW_GE_no_interfere(_G_GeeWatchBurn_key) then -------------V:Kill/burn
							fire.start_entity_fire(aim_ent)
							_GF_fire_expl_ent_pid(aim_ent, 0, 180, math.random(1,2), 3, 0)
							_GF_fire_expl_ent_pid(aim_ent, 0, 180, math.random(0,1), 3, 0)
						elseif _GF_GW_vk_key_down(vk_kck) and _GF_GW_GE_no_interfere(_G_GeeWatchKick_key) then	------------------------------------------K: Kick
							_GF_plyr_kick(player.get_player_from_ped(aim_ent))
						elseif  _GF_GW_vk_key_down(vk_ntr) and _GF_GW_GE_no_interfere(_G_GeeWatchNtr_key) then -----------------------------------------N: Neuter
							_GF_GW_neuter(aim_ent,50)
							system.yield(50)
						end
		--for players in vehicles PID_VEH
					else
						aim_veh = ped.get_vehicle_ped_is_using(aim_ent)
						if _GF_GW_vk_key_down(vk_brd) and _GF_GW_GE_no_interfere(_G_GeeWatchBoard_key) then ---------------------------------F:boarding (hijack)
							_GF_GW_board(vk_brd,aim_veh)
						elseif _GF_GW_vk_key_down(vk_dmg) and not _GF_is_dead(aim_veh) then --------------------------------------------------- ~:damage/destroy
							_GF_veh_damage_or_destroy(aim_veh,1000, _GF_veh_ped_name(aim_veh,"first_plyr"), _GF_model_name(aim_veh))
						elseif _GF_GW_vk_key_down(vk_brn) and _GF_GW_GE_no_interfere(_G_GeeWatchBurn_key) then --------------------------------------V:Kill/burn
							if not  _GF_is_dead(aim_veh) then
								fire.start_entity_fire(aim_veh)
								_GF_fire_expl_ent_pid(aim_veh, 0, 180, math.random(0,7), 3, 0)
								_GF_fire_expl_ent_pid(aim_veh, 0, 180, math.random(0,2), 3, 0)
							end
							veh_peds = _GF_all_peds_in_veh(aim_veh,nil,false)
							for i=1, #veh_peds do
								_GF_fire_expl_ent_pid(veh_peds[i], 0, 180, math.random(0,1), 3, 0)
								fire.start_entity_fire(veh_peds[i])
							end
						elseif _GF_GW_vk_key_down(vk_accl) and _GF_GW_GE_no_interfere(_G_GeeWatchAccel_key) then------------------------------------E:accelerate
							_GF_veh_accel(aim_veh,1000)
						elseif _GF_GW_vk_key_down(vk_rvrs) and _GF_GW_GE_no_interfere(_G_GeeWatchRvrs_key) then ------------------------------------ C:Reversing
							_GF_veh_revers(aim_veh,1000)
						elseif _GF_GW_vk_key_down(vk_rpr)  and _GF_GW_GE_no_interfere(_G_GeeWatchRepair_key) then --------------------------------------R:Repair
							_GF_veh_repair_basic(aim_veh, 1000)
						elseif _GF_GW_vk_key_down(vk_ele) and _GF_GW_GE_no_interfere(_G_GeeWatchElev_key) then ------------------------------------Q for elevate
							_GF_elevate(aim_veh,1000)
						elseif  _GF_GW_vk_key_down(vk_upgr) and _GF_GW_GE_no_interfere(_G_GeeWatchUpgrade_key) then -------------------------------U for upgrade
							_GF_veh_upgr_all_kek(aim_veh, 1000, false)
						elseif _GF_GW_vk_key_down(vk_de_ele_rag) and _GF_GW_GE_no_interfere(_G_GeeWatchDeEleRag_key) then ----------------------z for de-elevate
							_G_W_de_elevate(aim_veh,1000)
						elseif  _GF_GW_vk_key_down(vk_god) and _GF_GW_GE_no_interfere(_G_GeeWatchGod_key) then ------------------------------------H: God toggle
							_GF_ent_god_toggle(aim_veh,1000)
							system.yield(50)
						elseif _GF_GW_vk_key_down(vk_kck) and _GF_GW_GE_no_interfere(_G_GeeWatchKick_key) then	------------------------------------------K: Kick
							_GF_kick_their_veh(player.get_player_from_ped(aim_ent))
						elseif  _GF_GW_vk_key_down(vk_ntr) and _GF_GW_GE_no_interfere(_G_GeeWatchNtr_key) then -----------------------------------------N: Neuter
							_GF_GW_neuter(aim_veh,50)
							system.yield(50)
						end
					end
				end
			else
				_G_watch_dog_overlay.on=false
				_G_GW_aim_ent=nil
			end
		end
		_G_GW_aim_ent=nil
		plyr_name_count=0
	end
	_G_watch_dog_overlay.on=false
	_G_GW_aim_ent=nil
end)

local _G_GW_vk_key = MenuKey()
function _GF_GW_vk_key_down(_key_name)
	_G_GW_vk_key = MenuKey()
	_G_GW_vk_key:push_str(_key_name)
    if _G_GW_vk_key:is_down_stepped() then
		-- while _G_GW_vk_key:is_down_stepped() do
			-- system.yield(0)
			-- controls.disable_control_action(0,_GT_vk_to_input_num[_key_name], true)
		-- end
		return true
	end
	return false
end

_G_watch_dog_overlay=menu.add_feature("GW overlay to allow yield in main function", "toggle", _G_SelfPed.id, function(f)
	while f.on do
		system.yield(5)
		if _GF_key_active(114,1) then
			controls.disable_control_action(0,44, true)
			controls.disable_control_action(1,44, true)
			controls.disable_control_action(2,44, true)
		end
		if _GF_is_ent(_G_GW_aim_ent) then
			_GF_gee_watch_overlays(_G_GW_aim_ent)
		end
		if not _G_watch_dog.on then
			f.on = false
		end
	end
end)
_G_watch_dog_overlay.hidden=true

menu.add_feature("Apply recommended hotkeys?","action",_G_Watch_hot_keys.id,function()
_GF_G_W_keys_recc_do()
end)

_G_GeeWatchExplode_key=menu.add_feature("Key1 for GW vk_xpld","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchExplode_key.set_str_data(_G_GeeWatchExplode_key,_GT_keys_vk_name)
_G_GeeWatchExplode_key.hidden=true

_G_GeeWatchExplode_set=menu.add_feature("Set key for Explode","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Explode",_G_GeeWatchExplode_key)
	f.name = "Set key for Explode (".._GT_keys_vk_name[_G_GeeWatchExplode_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchDamDes_key=menu.add_feature("Key1 for GW vk_dmg","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchDamDes_key.set_str_data(_G_GeeWatchDamDes_key,_GT_keys_vk_name)
_G_GeeWatchDamDes_key.hidden=true

_G_GeeWatchDamDes_set=menu.add_feature("Set key for Damage/Destroy/Delete","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Damage/Destroy/Delete",_G_GeeWatchDamDes_key)
	f.name = "Set key for Damage/Destroy/Delete (".._GT_keys_vk_name[_G_GeeWatchDamDes_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchBoard_key=menu.add_feature("Key1 for GW vk_brd","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchBoard_key.set_str_data(_G_GeeWatchBoard_key,_GT_keys_vk_name)
_G_GeeWatchBoard_key.hidden=true

_G_GeeWatchBoard_set=menu.add_feature("Set key for Boarding","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Boarding",_G_GeeWatchBoard_key)
	f.name = "Set key for Boarding (".._GT_keys_vk_name[_G_GeeWatchBoard_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchAccel_key=menu.add_feature("Key1 for GW vk_accl","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchAccel_key.set_str_data(_G_GeeWatchAccel_key,_GT_keys_vk_name)
_G_GeeWatchAccel_key.hidden=true

_G_GeeWatchAccel_set=menu.add_feature("Set key for Accel","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Accel",_G_GeeWatchAccel_key)
	f.name = "Set key for Accel (".._GT_keys_vk_name[_G_GeeWatchAccel_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchRvrs_key=menu.add_feature("Key1 for GW vk_rvrs","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchRvrs_key.set_str_data(_G_GeeWatchRvrs_key,_GT_keys_vk_name)
_G_GeeWatchRvrs_key.hidden=true

_G_GeeWatchRvrs_set=menu.add_feature("Set key for Stop/Reverse","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Stop/Reverse",_G_GeeWatchRvrs_key)
	f.name = "Set key for Stop/Reverse (".._GT_keys_vk_name[_G_GeeWatchRvrs_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchRepair_key=menu.add_feature("Key1 for GW vk_rpr","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchRepair_key.set_str_data(_G_GeeWatchRepair_key,_GT_keys_vk_name)
_G_GeeWatchRepair_key.hidden=true

_G_GeeWatchRepair_set=menu.add_feature("Set key for Repair","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Repair",_G_GeeWatchRepair_key)
	f.name = "Set key for Repair (".._GT_keys_vk_name[_G_GeeWatchRepair_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchElev_key=menu.add_feature("Key1 for GW vk_ele","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchElev_key.set_str_data(_G_GeeWatchElev_key,_GT_keys_vk_name)
_G_GeeWatchElev_key.hidden=true

_G_GeeWatchElev_set=menu.add_feature("Set key for Elevate/Up","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Elevate/Up",_G_GeeWatchElev_key)
	f.name = "Set key for Elevate/Up (".._GT_keys_vk_name[_G_GeeWatchElev_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchDeEleRag_key=menu.add_feature("Key1 for GW vk_de_ele_rag","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchDeEleRag_key.set_str_data(_G_GeeWatchDeEleRag_key,_GT_keys_vk_name)
_G_GeeWatchDeEleRag_key.hidden=true

_G_GeeWatchDeEleRag_set=menu.add_feature("Set key for De-Elevate/Down/Ragdoll","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch De-Elevate/Down/Ragdoll",_G_GeeWatchDeEleRag_key)
	f.name = "Set key for De-Elevate/Down/Ragdoll (".._GT_keys_vk_name[_G_GeeWatchDeEleRag_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchUpgrade_key=menu.add_feature("Key1 for GW vk_upgr","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchUpgrade_key.set_str_data(_G_GeeWatchUpgrade_key,_GT_keys_vk_name)
_G_GeeWatchUpgrade_key.hidden=true

_G_GeeWatchUpgrade_set=menu.add_feature("Set key for Upgrade","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Upgrade",_G_GeeWatchUpgrade_key)
	f.name = "Set key for Upgrade (".._GT_keys_vk_name[_G_GeeWatchUpgrade_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchBurn_key=menu.add_feature("Key1 for GW vk_brn","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchBurn_key.set_str_data(_G_GeeWatchBurn_key,_GT_keys_vk_name)
_G_GeeWatchBurn_key.hidden=true

_G_GeeWatchBurn_set=menu.add_feature("Set key for Burn","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Burn",_G_GeeWatchBurn_key)
	f.name = "Set key for Burn (".._GT_keys_vk_name[_G_GeeWatchBurn_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchKick_key=menu.add_feature("Key1 for GW vk_kck","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchKick_key.set_str_data(_G_GeeWatchKick_key,_GT_keys_vk_name)
_G_GeeWatchKick_key.hidden=true

_G_GeeWatchKick_set=menu.add_feature("Set key for Kick","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Kick",_G_GeeWatchKick_key)
	f.name = "Set key for Kick (".._GT_keys_vk_name[_G_GeeWatchKick_key.value+1]..")"
end)
-------------------------------------------------------------------------------------------------------------
_G_GeeWatchGod_key=menu.add_feature("Key1 for GW vk_god","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchGod_key.set_str_data(_G_GeeWatchGod_key,_GT_keys_vk_name)
_G_GeeWatchGod_key.hidden=true

_G_GeeWatchGod_set=menu.add_feature("Set key for God-Toggle","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch God-Toggle",_G_GeeWatchGod_key)
	f.name = "Set key for God-Toggle (".._GT_keys_vk_name[_G_GeeWatchGod_key.value+1]..")"
end)

-------------------------------------------------------------------------------------------------------------
_G_GeeWatchNtr_key=menu.add_feature("Key1 for GW vk_ntr","autoaction_value_str",_G_Watch_hot_keys.id,function(f)
end)_G_GeeWatchNtr_key.set_str_data(_G_GeeWatchNtr_key,_GT_keys_vk_name)
_G_GeeWatchNtr_key.hidden=true

_G_GeeWatchNtr_set=menu.add_feature("Set key for Neuter","action",_G_Watch_hot_keys.id,function(f)
	_GF_set_keybinds(1,"Gee-Watch Neuter",_G_GeeWatchNtr_key)
	f.name = "Set key for Neuter (".._GT_keys_vk_name[_G_GeeWatchNtr_key.value+1]..")"
end)

function _GF_G_W_keys_recc_do()
_G_GeeWatchExplode_key.value=23
_G_GeeWatchDamDes_key.value=63
_G_GeeWatchBoard_key.value=5
_G_GeeWatchAccel_key.value=4
_G_GeeWatchRvrs_key.value=2
_G_GeeWatchRepair_key.value=17
_G_GeeWatchElev_key.value=16
_G_GeeWatchDeEleRag_key.value=25
_G_GeeWatchUpgrade_key.value=20
_G_GeeWatchBurn_key.value=21
_G_GeeWatchKick_key.value=10
_G_GeeWatchGod_key.value=7
_G_GeeWatchNtr_key.value=13
_GF_G_W_keys_names_do()
end

function _GF_G_W_keys_names_do()
_G_GeeWatchExplode_set.name = "Set key for Explode (".._GT_keys_vk_name[_G_GeeWatchExplode_key.value+1]..")"
_G_GeeWatchDamDes_set.name = "Set key for Damage/Destroy/Delete (".._GT_keys_vk_name[_G_GeeWatchDamDes_key.value+1]..")"
_G_GeeWatchBoard_set.name = "Set key for Boarding (".._GT_keys_vk_name[_G_GeeWatchBoard_key.value+1]..")"
_G_GeeWatchAccel_set.name = "Set key for Accel (".._GT_keys_vk_name[_G_GeeWatchAccel_key.value+1]..")"
_G_GeeWatchRvrs_set.name = "Set key for Stop/Reverse (".._GT_keys_vk_name[_G_GeeWatchRvrs_key.value+1]..")"
_G_GeeWatchRepair_set.name = "Set key for Repair (".._GT_keys_vk_name[_G_GeeWatchRepair_key.value+1]..")"
_G_GeeWatchElev_set.name = "Set key for Elevate/Up (".._GT_keys_vk_name[_G_GeeWatchElev_key.value+1]..")"
_G_GeeWatchDeEleRag_set.name = "Set key for De-Elevate/Down/Ragdoll (".._GT_keys_vk_name[_G_GeeWatchDeEleRag_key.value+1]..")"
_G_GeeWatchUpgrade_set.name = "Set key for Upgrade (".._GT_keys_vk_name[_G_GeeWatchUpgrade_key.value+1]..")"
_G_GeeWatchBurn_set.name = "Set key for Burn (".._GT_keys_vk_name[_G_GeeWatchBurn_key.value+1]..")"
_G_GeeWatchKick_set.name = "Set key for Kick (".._GT_keys_vk_name[_G_GeeWatchKick_key.value+1]..")"
_G_GeeWatchGod_set.name = "Set key for God-Toggle (".._GT_keys_vk_name[_G_GeeWatchGod_key.value+1]..")"
_G_GeeWatchNtr_set.name = "Set key for Neuter (".._GT_keys_vk_name[_G_GeeWatchNtr_key.value+1]..")"
end
_GF_G_W_keys_recc_do()



_GT_gw_ntr={}
_GT_gw_ntr.prnt = menu.add_feature("Gee-Watch Neuter", "parent", _G_Watch_Boost_Options.id)

_GT_gw_ntr.veh_hlth=menu.add_feature("Set vehicle engine health","value_f",_GT_gw_ntr.prnt.id)
_GF_set_feat_i_f(_GT_gw_ntr.veh_hlth,0,1000,50,500)
_GT_gw_ntr.veh_hlth.on=true

_GT_gw_ntr.veh_speed=menu.add_feature("Set vehicle speed","value_f",_GT_gw_ntr.prnt.id)
_GF_set_feat_i_f(_GT_gw_ntr.veh_speed,0,50,0.5,5)
_GT_gw_ntr.veh_speed.on=true

_GT_gw_ntr.veh_weap=menu.add_feature("Remove vehicle weapon (Irreversible)","toggle",_GT_gw_ntr.prnt.id)
_GT_gw_ntr.veh_weap.on=true

_GT_gw_ntr.ped_hlth=menu.add_feature("Set ped health","value_f",_GT_gw_ntr.prnt.id)
_GF_set_feat_i_f(_GT_gw_ntr.ped_hlth,100,500,10,120)
_GT_gw_ntr.ped_hlth.on=true

_GT_gw_ntr.ped_speed=menu.add_feature("Set ped speed","value_f",_GT_gw_ntr.prnt.id)
_GF_set_feat_i_f(_GT_gw_ntr.ped_speed,0,5,.5,2)
_GT_gw_ntr.ped_speed.on=true

_GT_gw_ntr.ped_weap=menu.add_feature("Remove ped/player current weapon","toggle",_GT_gw_ntr.prnt.id)
_GT_gw_ntr.ped_weap.on=true

------------------------------------------------------------------------------------------GeeSkid 
---------------------------------------------------------------------------------------------Self
-------------------------------------------------------------------------------------TeleportSelf
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

_G_self_veh_auto_tp=menu.add_feature("Best free seat", "value_str", _G_TeleportSelfSeat.id, function(f)--will TP you to the driver seat or closest to it
	_G_self_veh_auto_hijack.on=false
	if not _GF_me_in_any_veh() and _GF_GS_is_loaded() and f.on then
		menu.notify("You are not in a vehicle.\nWaiting to Auto-TP...",_G_GeeVer,4,2)
	end	
	local my_veh,my_seat,free_seat,npc_or_dead_fail,time
	while f.on do
		system.yield(250)
		if _GF_me_in_any_veh() and not _GF_me_driving(player.get_player_vehicle(player.player_id())) then
			my_veh=player.get_player_vehicle(player.player_id())
			my_seat = _GF_what_seat_plyr_in(my_veh,player.player_id())
			free_seat,npc_or_dead_fail = _GF_first_free_seat(my_veh,true)
			if free_seat > -2 and my_seat > free_seat then
				for i = 0,_GF_veh_seats(my_veh) do
					if my_seat > i-1 then
						if _GF_no_one_in_seat(my_veh, i-1) then
							ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()),my_veh,i-1)	
							break
						elseif f.value == 0 and _GF_is_ent(my_veh) and not ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(my_veh, i-1)) then
							ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(my_veh, i-1))
							time = utils.time_ms() + 500
							while time > utils.time_ms() and _GF_is_ent(my_veh) and _GF_is_ent(vehicle.get_ped_in_vehicle_seat(my_veh, i-1)) do
								system.yield(0)
							end
							if _GF_no_one_in_seat(my_veh, i-1) then
								ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()),my_veh,i-1)	
								break
							else
								npc_or_dead_fail=true
							end
						end
					end
				end
			end
			if npc_or_dead_fail then
				system.yield(5000) -- prevents it from tying to kick out or delete dead peds repeatedly
			end
		end
	end
end)_G_self_veh_auto_tp:set_str_data({"Take NPC Seat","Only empty seat"})

_G_self_veh_auto_hijack=menu.add_feature("Hijack", "value_str", _G_TeleportSelfSeat.id, function(f)
	_G_self_veh_auto_tp.on=false
	if not _GF_me_in_any_veh() and _GF_GS_is_loaded() and f.on then
		menu.notify("You are not in a vehicle.\nWaiting to Auto-Hijack...",_G_GeeVer,4,2)
	end	
	local me,friend,same_orgmc,continue,my_ped,name
	while f.on do
		system.yield(250)
		me=player.player_id()
		friend,same_orgmc,continue = false,false,false
		if _GF_me_in_any_veh() and not _GF_me_driving(player.get_player_vehicle(me)) then
			my_ped=player.get_player_ped(me) 
			if _GF_no_one_in_seat(player.get_player_vehicle(me),-1) then
				ped.set_ped_into_vehicle(my_ped,player.get_player_vehicle(me),-1)	
			else
				if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(me), -1)) then
					if player.is_player_friend(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(me), -1))) then
						friend = true
					end
					if _GF_same_orgmc(me,player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(me), -1))) then
						same_orgmc = true
					end
				end
				if f.value == 3 or (not friend and not same_orgmc) then
					continue = true
				elseif f.value == 1 and not friend then
					continue = true
				elseif f.value == 2 and not same_orgmc then
					continue=true
				end
				if continue then
					name = _GF_plyr_name(vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(me), -1))
					if _GF_veh_hijack(player.get_player_vehicle(me),true) then
						menu.notify(""..name.." - Kicked out :)",_G_GeeVer,4,2)
					else
						menu.notify(""..name.." - FAILED to Kick out :)",_G_GeeVer,4,2)
						system.yield(5000)
					end
				end
			end
		end
	end
end)_G_self_veh_auto_hijack:set_str_data({"Not friends/org/mc","Not friends","Not org/mc","Anyone"})

menu.add_feature("Free seat in current vehicle", "action", _G_TeleportSelf.id, function(f)
	if not _GF_me_in_any_veh() then
		menu.notify("You are not in a vehicle...",_G_GeeVer,4,2)
	else
		local me=player.player_id()
		local my_ped=player.get_player_ped(me)
		local my_veh=player.get_player_vehicle(me)
		local seat_count = _GF_veh_seats(my_veh)
		if _GF_no_one_in_seat(my_veh,-1) then
			ped.set_ped_into_vehicle(my_ped,my_veh,-1)
		elseif vehicle.is_vehicle_full(my_veh) then
			for i=1,seat_count-1 do
				local random_seat = math.random(0,seat_count-2)
				if _GF_no_one_in_seat(my_veh,random_seat) then
					ped.set_ped_into_vehicle(my_ped,my_veh,random_seat)
					break
				end
			end
		else
			menu.notify("Vehicle is full.",_G_GeeVer,4,2)
		end
	end
end)

menu.add_feature("Hijack driver seat in current vehicle", "action", _G_TeleportSelf.id, function()
	if not _GF_me_in_any_veh() then
		menu.notify("You are not in a vehicle...",_G_GeeVer,4,2)
	else
		local me=player.player_id()
		if _GF_me_driving(player.get_player_vehicle(me)) then
			menu.notify("You are already driving!",_G_GeeVer,4,2)
		elseif _GF_no_one_in_seat(player.get_player_vehicle(me),-1) then
			ped.set_ped_into_vehicle(player.get_player_ped(me),player.get_player_vehicle(me),-1)
		else
			local name = _GF_plyr_name(vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(me), -1))
			if _GF_veh_hijack(player.get_player_vehicle(me),true) then
				menu.notify(""..name.." - Kicked out :)",_G_GeeVer,4,2)
			else
				menu.notify(""..name.." - FAILED to Kick out :)",_G_GeeVer,4,2)
			end
		end
	end
end)

_G_rand_pid_last = 32
_G_self_veh_plyr_veh=menu.add_feature("Into random player vehicle", "action_value_str", _G_TeleportSelf.id, function(f,pid)
	local plyr_count = player.player_count()
	plyr_count=plyr_count-1
	if plyr_count == 0 or plyr_count == -1 then --  -1 for SP
		menu.notify("You are the only player in session.",_G_GeeVer,7,2)
	else
		local pid_table = _GF_rand_pid_table()
		for i=1, 32 do
			if pid_table[i] ~= nil then
				if not _GF_valid_pid(pid_table[i]) or _GF_me_in_that_veh(player.get_player_vehicle(pid_table[i])) or (pid_table[i] == _GT_rand_pid_last) then
					pid_table[i] = nil
				end
			end
		end
		_GF_plyr_veh_tp_into(pid_table,f.value,true,true)
		pid_table = {}
	end
end)_G_self_veh_plyr_veh:set_str_data({"Free Seat","Their Seat","Hijack"})

_G_self_veh_plyr=menu.add_feature("Near random player", "action_value_str", _G_TeleportSelf.id, function(f,pid)
	if (player.player_count()-1) < 1 then --  -1 for SP
		menu.notify("You are the only player in session.",_G_GeeVer,7,2)
	else
		local _water = "no_water"
		local plyr_pos = v3(0,0,0)
		local plyr=nil
		if f.value == 1 then
			_water = "water"
		end
		local pid_table = _GF_rand_pid_table()
		for i=1,#pid_table do
			if _GF_valid_pid(pid_table[i]) and (pid_table[i] ~= player.player_id()) then
				 if not _GF_is_pid_intrr(pid_table[i]) and not _GF_me_in_that_veh(player.get_player_vehicle(pid_table[i])) then
					if (player.get_player_coords(pid_table[i]) ~= plyr_pos) and (pid_table[i] ~= _G_rand_pid_last) then
						plyr_pos = _GF_pos_nearby(_GF_pos_offst_pid(pid_table[i],10,"behind",0),"single_50_dist",100,_water,"xy")
						plyr=pid_table[i] 
						break
					end
				end
			end
		end
		if plyr_pos == v3(0,0,0) then
			if _GF_valid_pid(_G_rand_pid_last) then
				plyr_pos =  _GF_pos_nearby(_GF_pos_offst_pid(_G_rand_pid_last,10,"behind",0),"single_50_dist",100,_water,"xy")
			else
				menu.notify("No player available.",_G_GeeVer,4,2)
			end
		end
		if plyr_pos == v3(0,0,0) then
			menu.notify("No player available.",_G_GeeVer,4,2)
		elseif _GF_me_in_any_veh() then
			if not _GF_ent_tp(_GT_plyr_info.veh[player.player_id()+1],plyr_pos, 0 ,false) then
				menu.notify("".._GF_plyr_name(player.player_id()).."  -  ".._GF_model_name(_GT_plyr_info.veh[player.player_id()+1]).."\nFailed to get control of vehicle :(", _G_GeeVer, 4, 2)
			else
				_G_rand_pid_last=plyr
			end
		else
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),plyr_pos)
			_G_rand_pid_last=plyr
		end
		pid_table = nil
	end
end)_G_self_veh_plyr:set_str_data({"Ignore water","Anywhere"})

function _GF_rand_pid_table()
	local rand_pid
	local pid_table = {}
	repeat
		rand_pid = math.random(0,31)
		if not _GF_table_has(pid_table,rand_pid) then
			pid_table[#pid_table+1]=rand_pid
		end
	until #pid_table == 32
	return pid_table
end
---------------------------------------------------------------------------------------------------------------------------------
_G_self_veh_tp_out_f=menu.add_feature("TP out of my vehicle", "value_str", _G_hold_key_tp_out.id, function(f)
	while f.on do
		f.name = "Hold (".._GT_keys_vk_name[_G_self_veh_tp_out_f_key.value+1]..") - TP out of my veh"
		system.yield(50)
		if not _GF_me_in_any_veh() then
			_GF_vk_key_down_with_delay(_GT_keys_vk_name[_G_self_veh_tp_out_f_key.value+1])
		elseif _GF_vk_key_down(_GT_keys_vk_name[_G_self_veh_tp_out_f_key.value+1]) then
			_GF_tp_in_out_closest_veh(nil,f.value,_GT_keys_vk_name[_G_self_veh_tp_out_f_key.value+1],_G_self_veh_tp_out_f_delay.value)
		end
	end
	f.name = "TP out of vehicle"
end)_G_self_veh_tp_out_f:set_str_data({"No speed","Some speed","All speed"})
_G_self_veh_tp_out_f.value=1

_G_self_veh_tp_out_f_delay = menu.add_feature("TP out - Hold Delay (ms)", "autoaction_value_i", _G_hold_key_tp_out.id, function()
end) _G_self_veh_tp_out_f_delay.max,_G_self_veh_tp_out_f_delay.min,_G_self_veh_tp_out_f_delay.mod=1000,100,25
_G_self_veh_tp_out_f_delay.value=700

_G_self_veh_tp_out_f_key=menu.add_feature("Key1 for (F) TP out - hidden","autoaction_value_str",_G_hold_key_tp_out.id,function(f)
end)_G_self_veh_tp_out_f_key.set_str_data(_G_self_veh_tp_out_f_key,_GT_keys_vk_name)
_G_self_veh_tp_out_f_key.hidden=true
_G_self_veh_tp_out_f_key.value=5

_G_self_veh_tp_out_f_set=menu.add_feature("TP out - Set key","action",_G_hold_key_tp_out.id,function(f)
	_GF_set_keybinds(1,"TP out of vehicle",_G_self_veh_tp_out_f_key)
	f.name = "TP out - Set key (".._GT_keys_vk_name[_G_self_veh_tp_out_f_key.value+1]..")"
end)
---------------------------------------------------------------------------------------------------------------------------------
_G_self_veh_tp_into_f=menu.add_feature("TP into closest vehicle", "value_str", _G_hold_key_tp_in.id, function(f)
	while f.on do
		f.name = "Hold (".._GT_keys_vk_name[_G_self_veh_tp_into_f_key.value+1]..") - TP into closest veh"
		system.yield(50)
		if _GF_me_in_any_veh() then
			_GF_vk_key_down_with_delay(_GT_keys_vk_name[_G_self_veh_tp_into_f_key.value+1])
		elseif _GF_vk_key_down(_GT_keys_vk_name[_G_self_veh_tp_into_f_key.value+1]) then
			_GF_tp_in_out_closest_veh(f.value,nil,_GT_keys_vk_name[_G_self_veh_tp_into_f_key.value+1],_G_self_veh_tp_into_f_delay.value)
		end
	end
	f.name = "TP into vehicle"
end)_G_self_veh_tp_into_f:set_str_data({"Free Seat","Hijack","Prefer Free Seat"})

_G_self_veh_tp_into_f_delay = menu.add_feature("TP into - Delay (ms)", "autoaction_value_i", _G_hold_key_tp_in.id, function()
end) _G_self_veh_tp_into_f_delay.max,_G_self_veh_tp_into_f_delay.min,_G_self_veh_tp_into_f_delay.mod=1000,100,25
_G_self_veh_tp_into_f_delay.value=700

_G_self_veh_tp_into_f_key=menu.add_feature("Key1 for (F) TP into - hidden","autoaction_value_str",_G_hold_key_tp_in.id,function(f)
end)_G_self_veh_tp_into_f_key.set_str_data(_G_self_veh_tp_into_f_key,_GT_keys_vk_name)
_G_self_veh_tp_into_f_key.hidden=true
_G_self_veh_tp_into_f_key.value=5

_G_self_veh_tp_into_f_set=menu.add_feature("TP into - Set key","action",_G_hold_key_tp_in.id,function(f)
	_GF_set_keybinds(1,"TP into vehicle",_G_self_veh_tp_into_f_key)
	f.name = "TP into - Set key (".._GT_keys_vk_name[_G_self_veh_tp_into_f_key.value+1]..")"
end)
---------------------------------------------------------------------------------------------------------------------------------
_GT_auto_enter = {}
_GT_auto_enter.feat=menu.add_feature("Enable","toggle",_G_auto_enter_veh.id,function(f)
	local veh
	while f.on do
		if _GF_me_in_any_veh() then
			system.yield(500)
		else
			system.yield(100)
			veh = native.call(0x814FA8BE5449445D,player.get_player_ped(player.player_id())):__tointeger()--GetVehiclePedIsTryingToEnter
			if _GF_valid_veh(veh) then
				_GT_auto_enter.do_it(veh)
				system.yield(100)
			end
		end
	end
end)

function _GT_auto_enter.do_it(_veh)
	for i=1,_GF_veh_seats(_veh) do
		if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh,i-2)) then
			if _GT_auto_enter.plyr.value == 0 or _GT_auto_enter.plyr.value == 1 then
				if not _GF_tp_into_free_seat(_veh) and _GT_auto_enter.plyr.value == 1 then
					_GF_veh_hijack(_veh,true)
				end
			else
				_GF_veh_hijack(_veh,true)
			end
			return
		end
	end
	if _GT_auto_enter.npc.value == 0 or _GT_auto_enter.npc.value == 1 then
		if not _GF_tp_into_free_seat(_veh) and _GT_auto_enter.npc.value == 1 then
			_GF_veh_hijack(_veh,false)
		end
	else
		_GF_veh_hijack(_veh,false)
	end
	return
end

_GT_auto_enter.plyr = menu.add_feature("Entering player vehicle", "action_value_str", _G_auto_enter_veh.id)
_GT_auto_enter.plyr:set_str_data({"Only empty seat","Prefer empty seat","Always hijack"})
_GT_auto_enter.plyr.value=1

_GT_auto_enter.npc = menu.add_feature("Entering NPC vehicle", "action_value_str", _G_auto_enter_veh.id)
_GT_auto_enter.npc:set_str_data({"Only empty seat","Prefer empty seat","Always hijack"})
_GT_auto_enter.npc.value=1



---------------------------------------------------------------------------------------------------------------------------------
_G_tp_frnds_to_me=menu.add_feature("TP my friends to me", "action_value_str", _G_TeleportSelf.id, function(f)
	if f.value == 0 then
		_GF_tp_frnds_or_orgmc_2_me("friends","front")
	else
		_GF_tp_frnds_or_orgmc_2_me("friends","nearby")
	end
end)_G_tp_frnds_to_me:set_str_data({"In front","Nearby"})

_G_tp_orgmc_to_me=menu.add_feature("TP my Org/Mc to me", "action_value_str", _G_TeleportSelf.id, function(f)
	if f.value == 0 then
		_GF_tp_frnds_or_orgmc_2_me("same_orgmc","front")
	else
		_GF_tp_frnds_or_orgmc_2_me("same_orgmc","nearby")
	end
end)_G_tp_orgmc_to_me:set_str_data({"In front","Nearby"})

function _GF_tp_frnds_or_orgmc_2_me(_type,_where)
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	local my_orig_pos = player.get_player_coords(me)
	local heading = player.get_player_heading(me)
	local i_hovered,success,bad,do_once = false,false,false,false
	local _pid
	_GF_hover_back_record()
	local tp_table = {}
	for i=0,32 do
		if _GF_valid_pid(i) and i ~= me and _GF_dist_me_pid(i) > 50 and not _GF_is_pid_intrr(i) then
			if _type == "friends" and player.is_player_friend(i) then
				tp_table[#tp_table+1]=i
			elseif _type == "same_orgmc" and _GF_same_orgmc(me,i) then
				tp_table[#tp_table+1]=i
			end
		end
	end
	if #tp_table == 0 then
		menu.notify("No available players.", _G_GeeVer, 4, 2)
	else
		table.sort(tp_table, function(a, b) return _GF_dist_xy_pospos(player.get_player_coords(a),my_orig_pos) < _GF_dist_xy_pospos(player.get_player_coords(b),my_orig_pos) end)
		for i=1,#tp_table do
			_pid = tp_table[i]
			if _GF_valid_pid(_pid) then
				if _GF_dist_me_pid(_pid) < 250 and not i_hovered then
					if player.is_player_in_any_vehicle(_pid) then
						if not _GF_ent_tp(_GT_plyr_info.veh[_pid+1],plyr_pos, 0 ,false) then
							menu.notify("".._GF_plyr_name(_pid).."  -  ".._GF_model_name(_GT_plyr_info.veh[_pid+1]).."\nFailed to get control of vehicle :(", _G_GeeVer, 4, 2)
						end
					else
						menu.notify("".._GF_plyr_name(_pid).."\nHas no vehicle :(", _G_GeeVer, 4, 2)
					end
				else
					local plyr_veh=0
					local target_pos = v3()
					i_hovered = true
					success,bad,do_once=false,false,false
					local time = utils.time_ms() + 3000
					while _GF_valid_pid(_pid) and (utils.time_ms() < time) and not success and not bad do
						system.yield(0)
						_GF_hover_above_player(_pid)
						if player.is_player_in_any_vehicle(_pid) then
							plyr_veh = player.get_player_vehicle(_pid)
						end
						if not do_once then 
							if _where == "front" then
								target_pos = _GF_front_of_pos(my_orig_pos, heading, math.random(10,20), math.random(170,190), math.random(2,5))
							elseif _where == "nearby" then
								target_pos =  _GF_pos_nearby(my_orig_pos,"single_50_dist",100,_water,"xy")
							end
							do_once=true
						end
						if plyr_veh ~= 0 then
							if entity.is_an_entity(plyr_veh) then
								if not network.has_control_of_entity(plyr_veh) then
									network.request_control_of_entity(plyr_veh)
								else
									entity.set_entity_coords_no_offset(plyr_veh,target_pos)
									success=true
								end
							else
								bad=true
							end
						elseif utils.time_ms() > time - 1250 then
							bad=true
						end
					end
					if not success then
						if plyr_veh ==0 then
							menu.notify("".._GF_plyr_name(_pid).."\nHas no vehicle :(", _G_GeeVer, 4, 2)
						else
							menu.notify("".._GF_plyr_name(_pid).."  -  ".._GF_model_name(_GT_plyr_info.veh[_pid+1]).."\nFailed to get control of vehicle :(", _G_GeeVer, 4, 2)
						end
					end
				end
			end
		end
		if i_hovered then
			_GF_hover_back_to_pos()
		end
	end
	tp_table = {}
	_GF_H_var_default()
end

menu.add_feature("TP forward", "action", _G_TeleportSelf.id, function()
	local found, pos_forward = _GF_tp_forward(player.get_player_coords(player.player_id()),player.get_player_heading(player.player_id()))
	if found then
		if _GF_me_in_any_veh() then
			if not _GF_ent_tp(_GT_plyr_info.veh[player.player_id()+1],pos_forward, 0 ,false) then
				menu.notify("".._GF_plyr_name(player.player_id()).."  -  ".._GF_model_name(_GT_plyr_info.veh[player.player_id()+1]).."\nFailed to get control of vehicle :(", _G_GeeVer, 4, 2)
			end
		else
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),pos_forward)
		end
	else
		menu.notify("No saved TP location found :(", _G_GeeVer, 4, 2)
	end
end)

_G_tp_rec_main = {}
_G_tp_rec_main.history = {}
--_G_tp_rec_main.slot = 1

_G_tp_rec_main.record_feat=menu.add_feature("TP back in time record hidden", "toggle", _G_TeleportSelf.id, function(f)
	local my_pos=player.get_player_coords(player.player_id())
	local continue,count,dist
	_G_tp_rec_main.history[1] = my_pos
	local function in_my_grid(old_pos,new_pos,_max)
		if math.abs(new_pos.x - old_pos.x) > _max or math.abs(new_pos.y - old_pos.y) > _max or math.abs(new_pos.z - old_pos.z) > _max then
			return false
		end
		return true
	end
	while f.on do
		system.yield(500)
		dist = 10
		if _GT_plyr_info.interior[player.player_id()+1] then
			dist = 2
		end
		if not in_my_grid(my_pos,player.get_player_coords(player.player_id()),dist) then
			count = 0
			continue = true
			for i=0,#_G_tp_rec_main.history do
				if count > 5 then
					break
				else
					count = count + 1
					if _G_tp_rec_main.history[#_G_tp_rec_main.history-i] ~= nil and in_my_grid(_G_tp_rec_main.history[#_G_tp_rec_main.history-i],player.get_player_coords(player.player_id()),dist) then
						continue = false
						break
					end
				end
			end
			my_pos = player.get_player_coords(player.player_id()) 
			if continue then
				_G_tp_rec_main.history[#_G_tp_rec_main.history+1] = my_pos
			end
		end
	end
end)
_G_tp_rec_main.record_feat.on = true
_G_tp_rec_main.record_feat.hidden = true

_G_tp_rec_main.back_feat=menu.add_feature("TP back in time", "action", _G_TeleportSelf.id, function()
	if _G_tp_rec_main.history[#_G_tp_rec_main.history-1] ~= nil then
		if _GF_me_in_any_veh() then
			if not _GF_ent_tp(_GT_plyr_info.veh[player.player_id()+1],_G_tp_rec_main.history[#_G_tp_rec_main.history-1], 0 ,false) then
				menu.notify("".._GF_veh_ped_name(_GT_plyr_info.veh[player.player_id()+1],"first_plyr").."  -  ".._GF_model_name(_GT_plyr_info.veh[player.player_id()+1]).."\nFailed to get control of vehicle :(", _G_GeeVer, 4, 2)
			else
				table.remove(_G_tp_rec_main.history,#_G_tp_rec_main.history)
			end
		else
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),_G_tp_rec_main.history[#_G_tp_rec_main.history-1])
			table.remove(_G_tp_rec_main.history,#_G_tp_rec_main.history)
		end
	end
end)

_G_cam_aim_tp=menu.add_feature("Camera aim TP", "action_value_i", _G_TeleportSelf.id, function()
	if _GF_me_in_any_veh() then
		if not _GF_ent_tp(_GT_plyr_info.veh[player.player_id()+1],_GF_aim_coords_get(_G_cam_aim_tp.value), 0 ,false) then
			menu.notify("".._GF_veh_ped_name(_GT_plyr_info.veh[player.player_id()+1],"first_plyr").."  -  ".._GF_model_name(_GT_plyr_info.veh[player.player_id()+1]).."\nFailed to get control of vehicle :(", _G_GeeVer, 4, 2)
		end
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),_GF_aim_coords_get(_G_cam_aim_tp.value))
	end
end)_G_cam_aim_tp.max,_G_cam_aim_tp.min,_G_cam_aim_tp.mod=500,5,5

function _GF_aim_coords_get(_d)
	local z_ele = cam.get_gameplay_cam_rot().x/180*(_d*1.5)
	local dist = (_d*1.5) - math.abs(z_ele)
	return _GF_front_of_pos(player.get_player_coords(player.player_id()), cam.get_gameplay_cam_rot().z, dist, 180, z_ele)
end


_G_tp_self_or_veh_v2=menu.add_feature("Waypoint/objective v2", "action_value_str", _G_TeleportSelf.id, function(f)
	local me = player.player_id()
	local my_ped = player.get_player_ped(me)
	local continue = false
	if f.value == 0 and	_GF_WP_coords_get("anywhere") then
		continue=true
	elseif f.value == 1 and _GF_WP_coords_get("no_water") then
		continue=true
	elseif _GF_OBJ_coords_get() then
		continue=true
	end
	if continue then
		if _GF_me_in_any_veh() then
			if not _GF_ent_tp(player.get_player_vehicle(me),_G_WP_OBJ_pos, 0 ,false) then
				menu.notify("".._GF_veh_ped_name(player.get_player_vehicle(me),"first_plyr").." - ".._GF_model_name(player.get_player_vehicle(me)).."\n FAILED to receive control.",_G_GeeVer,4,2)
			else
				
			end
		else
			entity.set_entity_coords_no_offset(my_ped,_G_WP_OBJ_pos)	
		end
	elseif _G_OBJ_coords_BAD then
		menu.notify("The menu won't let me find the objective coords.",_G_GeeVer,4,2)
	else
		menu.notify("No waypoint/objective.",_G_GeeVer,4,2)
	end
end)_G_tp_self_or_veh_v2.set_str_data(_G_tp_self_or_veh_v2,{"Anywhere","Ignore water"})

menu.add_feature("TP-Self to personal vehicle", "action", _G_PersonalVehicle.id, function()
	_GF_tp_personal_veh("self_2_veh")
end)

menu.add_feature("TP-Self to personal vehicle and drive", "action", _G_PersonalVehicle.id, function()
	_GF_tp_personal_veh("self_2_veh_drive")
end)

menu.add_feature("TP-Personal-Vehicle to me", "action", _G_PersonalVehicle.id, function()
	_GF_tp_personal_veh("veh_2_me")
end)

menu.add_feature("TP-Personal-Vehicle to me and drive", "action", _G_PersonalVehicle.id, function()
	_GF_tp_personal_veh("veh_2_me_drive")
end)

-- menu.add_feature("Request delivery of vehicle", "toggle", _G_PersonalVehicle.id, function(f) -- needs work to be perfect and the menu has personal vehicle stuff now anyways
	-- local veh = player.get_personal_vehicle()
	-- local me = player.player_id()
	-- local my_veh = -1
	-- if _GF_me_in_any_veh() then
		-- my_veh = player.get_player_vehicle(me)
	-- end
	-- local ped_model = gameplay.get_hash_key("u_m_m_jesus_01")
	-- local jesus = 0
	-- local time = utils.time_ms()+10000
	-- local pos_check = utils.time_ms()+5000
	-- if veh ~= 0 and veh ~= my_veh and _GF_valid_veh(veh) then
		-- local veh_pos = entity.get_entity_coords(veh)
		-- while f.on do
			-- system.yield(0)
			-- if entity.get_entity_model_hash(vehicle.get_ped_in_vehicle_seat(veh,-1)) ~= ped_model then
				-- if not _GF_no_one_in_seat(veh,-1) then
					-- ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(veh,-1))
					-- system.yield(200)
					-- if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(veh,-1)) then
						-- _GF_veh_kick_script(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(veh,-1)))
						-- system.yield(200)
					-- end
				-- else
					-- _GF_req_stream_hash(ped_model)
					-- jesus = ped.create_ped(6, ped_model,entity.get_entity_coords(veh)+v3(0,0,100), 0, true, false)
					-- --ped.set_ped_combat_attributes(jesus, 1, true) -- can use vehicles
					-- --ped.set_ped_combat_attributes(jesus, 2, true) -- can do drivebys 
					-- --ped.set_ped_combat_attributes(jesus, 3, true) -- can leave vehicle
					-- --ped.set_ped_combat_attributes(jesus, 52, true) --ignore traffic
					-- local my_group =  player.get_player_group(me)
					-- local heaven = ped.get_ped_group(jesus)
					-- ped.set_relationship_between_groups(0, my_group, heaven)
					-- ped.set_relationship_between_groups(0, heaven, my_group)
					-- _GF_set_ped_health(jesus,2500,50)
					-- _GF_ped_ragdoll(jesus,false,50)
					-- entity.set_entity_rotation(veh,v3(0,0,_GF_vector_to_pos(player.get_player_coords(me),veh).z))
					-- entity.set_entity_coords_no_offset(veh,entity.get_entity_coords(veh))
					-- ped.set_ped_into_vehicle(jesus, veh, -1)
					-- system.yield(50)
					-- --ai.task_vehicle_drive_to_coord_longrange(jesus, veh, player.get_player_coords(me), 100, 786956, 10)
					-- ai.task_vehicle_follow(jesus, veh, player.get_player_ped(me), 100, 786956, 5)
				-- end
			-- elseif jesus == 0 then
				-- jesus = vehicle.get_ped_in_vehicle_seat(veh,-1)
			-- elseif _GF_dist_me_ent(veh) < 15 then
				-- entity.set_entity_rotation(veh,v3(0,0,entity.get_entity_rotation(veh).z))
				-- entity.set_entity_velocity(veh,v3(0,0,0))
				-- entity.delete_entity(jesus)
				-- f.on=false
			-- elseif _GF_dist_me_ent(veh) > 150 or vehicle.is_vehicle_stuck_on_roof(veh) or pos_check < utils.time_ms() then
				-- if _GF_dist_pos_pos(veh_pos,entity.get_entity_coords(veh)) < 20 or _GF_dist_me_ent(veh) > 150 or vehicle.is_vehicle_stuck_on_roof(veh) then
					-- if _GF_request_ctrl(veh,1000) then
						-- entity.set_entity_coords_no_offset(veh,_GF_pos_nearby(_GF_front_of_pos(player.get_player_coords(me), _GF_vector_to_pos(entity.get_entity_coords(veh),player.get_player_ped(me)).z+math.random(-90,90), _GF_dist_me_ent(veh)/2, 180, 0),"single_closest",10,"no_water","xyz"))
						-- entity.set_entity_rotation(veh,v3(0,0,_GF_vector_to_pos(player.get_player_coords(me),veh).z))
						-- entity.set_entity_coords_no_offset(veh,entity.get_entity_coords(veh))
					-- end
				-- end
				-- veh_pos = entity.get_entity_coords(veh)
				-- pos_check = utils.time_ms()+5000
			-- elseif time < utils.time_ms() and entity.is_an_entity(jesus) then
				-- --ai.task_vehicle_drive_to_coord_longrange(jesus, veh, player.get_player_coords(me), 100, 786956, 10)
				-- ai.task_vehicle_follow(jesus, veh, player.get_player_ped(me), 100, 786956, 5)
				-- time = utils.time_ms()+10000
			-- end
		-- end
	-- elseif veh == my_veh and _GF_me_in_any_veh() then
		-- menu.notify("You're already in your personal vehicle...",_G_GeeVer,4,2)
		-- f.on=false
	-- else
		-- menu.notify("No personal vehicle found...",_G_GeeVer,4,2)
		-- f.on=false
	-- end
-- end)

_G_personal_veh_action_list=menu.add_feature("Personal vehicle", "action_value_str", _G_PersonalVehicle.id, function(f)
	local veh = player.get_personal_vehicle()
	if veh ~= 0 and _GF_valid_veh(veh) then
		if f.value == 0 then
			_GF_veh_repair_basic(veh, 1000)
		elseif f.value == 1 then
			_GF_veh_destroyed(veh, 1000)
		elseif f.value == 2 then
			_GF_veh_upgr_all_kek(veh, 1000, true)
		elseif f.value == 3 then
			if _GF_no_one_in_veh(veh) then
				menu.notify("No one in the vehicle",_G_GeeVer,4,2)
			else
				_GF_kick_all_from_veh(veh)
			end
		end
	else
		menu.notify("No personal vehicle found...",_G_GeeVer,4,2)
	end
end)_G_personal_veh_action_list:set_str_data({"Repair", "Destroy","Upgrade","Kick from vehicle"})

_G_personal_veh_info_show=menu.add_feature("Show personal vehicle info", "action_value_str", _G_PersonalVehicle.id, function(f)
	local veh = player.get_personal_vehicle()
	if veh ~= 0 and _GF_valid_veh(veh) then
		if f.value == 0 then
			_GF_display_veh_info(veh,false,false,false,false,false,true,true,false,false,false,false,false,false)
		elseif f.value == 1 then
			_GF_display_veh_info(veh,false,false,false,false,true,true,true,true,false,false,false,false,true)
		else
			_GF_display_veh_info(veh,true,true,true,true,true,true,true,true,true,true,true,true,true)
		end
	else
		menu.notify("Personal vehicle not found",_G_GeeVer,4,2)
	end
end)_G_personal_veh_info_show:set_str_data({"Minimal", "Most","All"})

menu.add_feature("TP-Self to last vehicle", "action", _G_LastVehicle.id, function()
	_GF_tp_last_veh("self_2_veh")
end)

menu.add_feature("TP-Self to last vehicle and drive", "action", _G_LastVehicle.id, function()
	_GF_tp_last_veh("self_2_veh_drive")
end)

menu.add_feature("TP-Last-Vehicle to me", "action", _G_LastVehicle.id, function()
	_GF_tp_last_veh("veh_2_me")
end)

menu.add_feature("TP-Last-Vehicle to me and drive", "action", _G_LastVehicle.id, function()
	_GF_tp_last_veh("veh_2_me_drive")
end)

_G_last_veh_action_list=menu.add_feature("Last vehicle", "action_value_str", _G_LastVehicle.id, function(f)
	local _veh
	if _GF_me_in_any_veh() then	_veh = _GT_my_veh_hist[#_GT_my_veh_hist-1] else _veh = _GT_my_veh_hist[#_GT_my_veh_hist] end
	if not _GF_valid_veh(_veh) then
		menu.notify("Last vehicle not found",_G_GeeVer,4,2)
	elseif _GF_dist_pos_pos(entity.get_entity_coords(_veh),v3(0.0,0.0,0.0)) < 10 then --sometimes gta reports its pos as 0,0,0 when it cant find it
		menu.notify("Last vehicle not found",_G_GeeVer,4,2)
	elseif f.value == 0 then
		_GF_veh_repair_basic(_veh, 1000)
	elseif f.value == 1 then
		_GF_veh_destroyed(_veh, 2500)
	elseif f.value == 2 then
		_GF_veh_upgr_all_kek(_veh, 1000, true)
	elseif f.value == 3 then
		if _GF_no_one_in_veh(_veh) then
			menu.notify("No one in the vehicle",_G_GeeVer,4,2)
		else
			_GF_kick_all_from_veh(_veh)
		end
	end
end)_G_last_veh_action_list:set_str_data({"Repair", "Destroy","Upgrade","Kick from vehicle"})

_G_last_veh_info_show=menu.add_feature("Show last vehicle info", "action_value_str", _G_LastVehicle.id, function(f)
	local _veh
	if _GF_me_in_any_veh() then	_veh = _GT_my_veh_hist[#_GT_my_veh_hist-1] else _veh = _GT_my_veh_hist[#_GT_my_veh_hist] end
	if not _GF_valid_veh(_veh) then
		menu.notify("Last vehicle not found",_G_GeeVer,4,2)
	elseif _GF_dist_pos_pos(entity.get_entity_coords(_veh),v3(0.0,0.0,0.0)) < 10 then --sometimes gta reports its pos as 0,0,0 when it cant find it
		menu.notify("Last vehicle not found",_G_GeeVer,4,2)
	elseif f.value == 0 then
		_GF_display_veh_info(_veh,false,false,false,false,false,true,true,false,false,false,false,false,false)
	elseif f.value == 1 then
		_GF_display_veh_info(_veh,false,false,false,false,true,true,true,true,false,false,false,false,true)
	else
		_GF_display_veh_info(_veh,true,true,true,true,true,true,true,true,true,true,true,true,true)
	end
end)_G_last_veh_info_show:set_str_data({"Minimal", "Most","All"})

------------------------------------------------------------------------------------------GeeSkid
---------------------------------------------------------------------------------------------Self
------------------------------------------------------------------------------------------Weapons
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

--------------------------------------------------Extracted from Universe. Modified significantly
_G_GE_main = {}
_G_GE_main.aim={}
_G_GE_main.trcr={}
_G_GE_main.trcr.table={}

_G_GE_main.feat=menu.add_feature("Gee-Eye","value_str",_G_GeeEye.id,function(f)
	if _GF_GS_is_loaded() and f.on then
		menu.notify("Press ".._GT_keys_vk_name[_G_GE_main.slct_key1.value+1].." to fire Gee-Eye",_G_GeeVer,10,7)
	end
	local blame,notif_shoot,notif_mk2
	local v3_start,v3_end = v3(),v3()
	while f.on do
		system.yield(0)
		notif_shoot=false
		f.name="Gee-Eye (".._GT_keys_vk_name[_G_GE_main.slct_key1.value+1]..")"
		while _GF_vk_key_down(_GT_keys_vk_name[_G_GE_main.slct_key1.value+1]) and _GT_plyr_info.typing[player.player_id()+1]==false do
			system.yield(0)
			if _G_GE_main.blame.value == 1 then blame = 100000 else blame=player.get_player_ped(player.player_id())	end
			weapon.give_weapon_component_to_ped(blame,_GT_geeeye_weap[f.value+1],_GT_geeeye_comp[f.value+1]) -- i cant be sure if this is needed. Maybe for players that dont have the weapon already
			v3_start,v3_end = _GF_geeyee_calc(false)
			_G_GE_main.trcr.table[#_G_GE_main.trcr.table+1]={v3_start,v3_end,utils.time_ms(),_G_GE_main.trcr.fade.value*1000}
			gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, _GT_geeeye_weap[f.value+1], blame, _GF_01_to_bool(_G_GE_main.aud.value),  _GF_01_to_bool(_G_GE_main.vis.value,true), 1000)
			if _G_GE_main.spread.value > 25 then
				_GF_delay_(math.floor(_G_GE_main.delay.value/8))
				for i=1,7 do
					if _GF_vk_key_down(_GT_keys_vk_name[_G_GE_main.slct_key1.value+1]) then
						v3_start,v3_end = _GF_geeyee_calc(true)
						_G_GE_main.trcr.table[#_G_GE_main.trcr.table+1]={v3_start,v3_end,utils.time_ms(),_G_GE_main.trcr.fade.value*1000}
						gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, _GT_geeeye_weap[f.value+1], blame, _GF_01_to_bool(_G_GE_main.aud.value), _GF_01_to_bool(_G_GE_main.vis.value,true), 1000)
						_GF_delay_(math.floor(_G_GE_main.delay.value/8))
					end
				end
			else
				_GF_delay_(_G_GE_main.delay.value)
			end
			if not notif_shoot then
				menu.notify("".._GT_geeeye_notif[_G_GE_main.feat.value+1].."",_G_GeeVer,4,2,7)
				notif_shoot = true
			end
		end
		if _G_GE_main.feat.value == 0 and _G_GE_main.blame.value == 1 and _GF_GS_is_loaded() then
			if not notif_mk2 then
				menu.notify("Blaming no-one with Mk2 Sniper results in zero damage to players. I also couldn't figure out why it removes the explosive rounds :(", _G_GeeVer, 7, 2)
				notif_mk2=true
			end
		else
			notif_mk2=false
		end
	end
	f.name = "Gee-Eye"
end)_G_GE_main.feat:set_str_data({"Mk2 Sniper","Railgun","RPG","EMP Launcher","Firework Launcher","Grenade Launcher","Greanade Launcher Smoke","Up-N-Atomizer"})

_G_GE_main.trcr.prnt=menu.add_feature("Tracers","parent",_G_GeeEye.id)

_G_GE_main.trcr.feat=menu.add_feature("Add tracer effect", "toggle", _G_GE_main.trcr.prnt.id, function(f)
	while f.on do
		system.yield(5)
		for i=1,#_G_GE_main.trcr.table do
			if _G_GE_main.trcr.table[i] ~= nil then
				if (_G_GE_main.trcr.table[i][3]+_G_GE_main.trcr.table[i][4])>utils.time_ms() then
					ui.draw_line(
					_G_GE_main.trcr.table[i][1],
					_G_GE_main.trcr.table[i][2],
					_G_GE_main.trcr.r.value,
					_G_GE_main.trcr.g.value,
					_G_GE_main.trcr.b.value,
					math.floor((_G_GE_main.trcr.table[i][3]+_G_GE_main.trcr.table[i][4]-utils.time_ms())/_G_GE_main.trcr.table[i][4]*_G_GE_main.trcr.a.value)
					)
				else
					_G_GE_main.trcr.table[i] = nil
				end
			end
		end
	end
end)

_G_GE_main.trcr.fade = menu.add_feature("Fade time (seconds)", "action_value_f",_G_GE_main.trcr.prnt.id)
_GF_set_feat_i_f(_G_GE_main.trcr.fade,.125,5,.125,1)

_G_GE_main.trcr.r = menu.add_feature("R", "action_value_i",_G_GE_main.trcr.prnt.id)
_GF_set_feat_i_f(_G_GE_main.trcr.r,0,255,5,255)

_G_GE_main.trcr.g = menu.add_feature("G", "action_value_i",_G_GE_main.trcr.prnt.id)
_GF_set_feat_i_f(_G_GE_main.trcr.g,0,255,5,0)

_G_GE_main.trcr.b = menu.add_feature("B", "action_value_i",_G_GE_main.trcr.prnt.id)
_GF_set_feat_i_f(_G_GE_main.trcr.b,0,255,5,0)

_G_GE_main.trcr.a = menu.add_feature("A", "action_value_i",_G_GE_main.trcr.prnt.id)
_GF_set_feat_i_f(_G_GE_main.trcr.a,0,255,5,200)

_G_GE_main.aim.prnt=menu.add_feature("Aim options","parent",_G_GeeEye.id, function()
	_G_GE_main.aim.veh_prnt.hidden=_G_GE_main.aim.veh_pos.value ~= 0
	_G_GE_main.aim.frwd_foot_offst.hidden=_G_GE_main.aim.fire_pos.value==1 and _G_GE_main.aim.veh_pos.value~=1 
	_G_GE_main.aim.frwd_cam_offst.hidden=_G_GE_main.aim.fire_pos.value==0 and _G_GE_main.aim.veh_pos.value~=2
end)

_G_GE_main.aim.temp_bool=false
_G_GE_main.aim.temp_feat=menu.add_feature("test object HIDDEN", "toggle", _G_GE_main.aim.prnt.id, function(f)
	local time,obj,dir,pos,rot = utils.time_ms()+7000
	while f.on and time > utils.time_ms() do
		system.yield(5)
		if _G_GE_main.aim.temp_bool then
			_G_GE_main.aim.temp_bool=false
			time = utils.time_ms()+7000
		end
		if not _GF_is_ent(obj) then
			_GF_remove_ent(obj,100)
			_GF_req_stream_hash(-1707997257)
			obj = object.create_object(-1707997257,_GF_geeeye_start(), false,false)
			entity.freeze_entity(obj,true)
			entity.set_entity_collision(obj,false,false)
		else
			entity.set_entity_alpha(obj, math.floor((time-utils.time_ms())/7000*255), false)
			entity.set_entity_coords_no_offset(obj,_GF_geeeye_start())
			entity.set_entity_rotation(obj,cam.get_gameplay_cam_rot())
		end
	end
	_GF_remove_ent(obj,100)
	f.on=false
end)_G_GE_main.aim.temp_feat.hidden=true

function _G_GE_main.aim.temp_start(_bool)
	_G_GE_main.aim.temp_bool=_bool
	_G_GE_main.aim.temp_feat.on=_bool
end
	
_G_GE_main.aim.fire_pos=menu.add_feature("Firing point","autoaction_value_str",_G_GE_main.aim.prnt.id,function(f)
	_G_GE_main.aim.temp_start(true)
	_G_GE_main.aim.frwd_foot_offst.hidden=f.value==1 and _G_GE_main.aim.veh_pos.value~=1
	_G_GE_main.aim.frwd_cam_offst.hidden=f.value==0 and _G_GE_main.aim.veh_pos.value~=2
end)_G_GE_main.aim.fire_pos.set_str_data(_G_GE_main.aim.fire_pos,{"My ped", "Cam"})
_G_GE_main.aim.fire_pos.value=1

_G_GE_main.aim.frwd_foot_offst=menu.add_feature("Forward offset for ped","autoaction_value_f",_G_GE_main.aim.prnt.id,function(f)
	_G_GE_main.aim.temp_start(not _GF_me_in_any_veh())
end)_GF_set_feat_i_f(_G_GE_main.aim.frwd_foot_offst,0,10,.5,2)

_G_GE_main.aim.frwd_cam_offst=menu.add_feature("Forward offset for cam","autoaction_value_f",_G_GE_main.aim.prnt.id,function(f)
	_G_GE_main.aim.temp_start(not _GF_me_in_any_veh())
end)_GF_set_feat_i_f(_G_GE_main.aim.frwd_cam_offst,0,10,.5,6)

_G_GE_main.aim.veh_pos=menu.add_feature("Firing point in vehicle","autoaction_value_str",_G_GE_main.aim.prnt.id,function(f)
	_G_GE_main.aim.temp_start(f.value ~= 0 or (f.value == 0 and _GF_me_in_any_veh()))
	_G_GE_main.aim.veh_prnt.hidden=f.value ~= 0
	_G_GE_main.aim.frwd_foot_offst.hidden=f.value~=1 and _G_GE_main.aim.fire_pos.value~=0
	_G_GE_main.aim.frwd_cam_offst.hidden=f.value==0 and _G_GE_main.aim.fire_pos.value~=1
end)_G_GE_main.aim.veh_pos.set_str_data(_G_GE_main.aim.veh_pos,{"Vehicle","My ped","Cam"})

_G_GE_main.aim.veh_prnt=menu.add_feature("Vehicle offsets","parent",_G_GE_main.aim.prnt.id,function(f)
	_G_GE_main.aim.smrt_veh_offst.hidden=_G_GE_main.aim.vert_veh_offst.value ~= 0
	_G_GE_main.aim.mnl_veh_offst.hidden=_G_GE_main.aim.vert_veh_offst.value ~= 1
	_G_GE_main.aim.frwd_veh_smrt.hidden=_G_GE_main.aim.frwd_veh_offst_type.value ~= 0
	_G_GE_main.aim.frwd_veh_offst.hidden=_G_GE_main.aim.frwd_veh_offst_type.value ~= 1
end)

_G_GE_main.aim.frwd_veh_offst_type=menu.add_feature("Forward Offset type","autoaction_value_str",_G_GE_main.aim.veh_prnt.id,function(f)
	_G_GE_main.aim.temp_start(_GF_me_in_any_veh())
	_G_GE_main.aim.frwd_veh_smrt.hidden=f.value ~= 0
	_G_GE_main.aim.frwd_veh_offst.hidden=f.value ~= 1
end)_G_GE_main.aim.frwd_veh_offst_type.set_str_data(_G_GE_main.aim.frwd_veh_offst_type,{"Smart", "Manual","None"})

_G_GE_main.aim.frwd_veh_smrt=menu.add_feature("Forward smart offset (multiplier)","autoaction_value_f",_G_GE_main.aim.veh_prnt.id,function(f)
	_G_GE_main.aim.temp_start(_GF_me_in_any_veh())
end)_GF_set_feat_i_f(_G_GE_main.aim.frwd_veh_smrt,0,3,.05,1)

_G_GE_main.aim.frwd_veh_offst=menu.add_feature("Forward manual offset (meters)","autoaction_value_f",_G_GE_main.aim.veh_prnt.id,function(f)
	_G_GE_main.aim.temp_start(_GF_me_in_any_veh())
end)_GF_set_feat_i_f(_G_GE_main.aim.frwd_veh_offst,0,25,.1,2)

_G_GE_main.aim.vert_veh_offst=menu.add_feature("Vertical offset type","autoaction_value_str",_G_GE_main.aim.veh_prnt.id,function(f)
	_G_GE_main.aim.temp_start(_GF_me_in_any_veh())
	_G_GE_main.aim.smrt_veh_offst.hidden=f.value ~= 0
	_G_GE_main.aim.mnl_veh_offst.hidden=f.value ~= 1
end)_G_GE_main.aim.vert_veh_offst.set_str_data(_G_GE_main.aim.vert_veh_offst,{"Smart", "Manual","None"})

_G_GE_main.aim.smrt_veh_offst=menu.add_feature("Vertical smart offset (multiplier)","autoaction_value_f",_G_GE_main.aim.veh_prnt.id,function(f)
	_G_GE_main.aim.temp_start(_G_GE_main.aim.vert_veh_offst.value == 0 and _GF_me_in_any_veh())
end)_GF_set_feat_i_f(_G_GE_main.aim.smrt_veh_offst,0,3,.05,1)

_G_GE_main.aim.mnl_veh_offst=menu.add_feature("Vertical manual offset (meters)","autoaction_value_f",_G_GE_main.aim.veh_prnt.id,function(f)
	_G_GE_main.aim.temp_start(_G_GE_main.aim.vert_veh_offst.value == 1 and _GF_me_in_any_veh())
end)_GF_set_feat_i_f(_G_GE_main.aim.mnl_veh_offst,0,25,.1,2)

_G_GE_main.delay=menu.add_feature("Gee-Eye fire-rate delay (ms)","autoaction_value_i",_G_GeeEye.id)
_G_GE_main.delay.max,_G_GE_main.delay.min,_G_GE_main.delay.mod=500,25,25

_G_GE_main.spread=menu.add_feature("Gee-Eye spread","autoaction_slider",_G_GeeEye.id)
_G_GE_main.spread.max,_G_GE_main.spread.min,_G_GE_main.spread.mod=1000,25,25

_G_GE_main.spread_type=menu.add_feature("Gee-Eye spread type","autoaction_value_str",_G_GeeEye.id)
_G_GE_main.spread_type.set_str_data(_G_GE_main.spread_type,{"Circular", "Horizontal", "Vertical"})

_G_GE_main.blame=menu.add_feature("Gee-Eye blame","autoaction_value_str",_G_GeeEye.id)
_G_GE_main.blame.set_str_data(_G_GE_main.blame,{"Me", "No-One"})

_G_GE_main.vis=menu.add_feature("Gee-Eye visible?","autoaction_value_str",_G_GeeEye.id)
_G_GE_main.vis.set_str_data(_G_GE_main.vis,{"False", "True"})

_G_GE_main.aud=menu.add_feature("Gee-Eye audible?","autoaction_value_str",_G_GeeEye.id)
_G_GE_main.aud.set_str_data(_G_GE_main.aud,{"False", "True"})

_G_GE_main.slct_key1=menu.add_feature("Key1 for Gee-Eye HIDDEN","autoaction_value_str",_G_GeeEye.id)
_G_GE_main.slct_key1.set_str_data(_G_GE_main.slct_key1,_GT_keys_vk_name)
_G_GE_main.slct_key1.hidden=true
_G_GE_main.slct_key1.value=23

menu.add_feature("Set key for Gee-Eye","action",_G_GeeEye.id,function()
	_GF_set_keybinds(1,"Gee-Eye",_G_GE_main.slct_key1)
end)


_G_GE_main.flare_feat=menu.add_feature("Gee-Flare","slider",_G_GeeFlare.id,function(f) --GTA will only display 5 flares you shoot. I tried making flares anonymous but this bypasses the 5 flare limit and can cause you to crash
	if _GF_GS_is_loaded() and f.on then
		menu.notify("Press ".._GT_keys_vk_name[_G_GE_main.flare_key_slct.value+1].." to shoot Gee-Flare",_G_GeeVer,4,7)
	end
	local delay_table={750,650,550,450,350,250}
	local v3_start,v3_end = v3(),v3()
	while f.on do
		system.yield(0)
		f.name="Gee-Flare (".._GT_keys_vk_name[_G_GE_main.flare_key_slct.value+1]..")"
		while _GF_vk_key_down(_GT_keys_vk_name[_G_GE_main.flare_key_slct.value+1]) and _GT_plyr_info.typing[player.player_id()+1]==false do
			system.yield(0)
			weapon.give_weapon_component_to_ped(player.get_player_ped(player.player_id()),1198879012, 1000)
			v3_start,v3_end = _GF_geeyee_calc(false)
			if controls.get_control_normal(0,114)==0.0 then
				gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, 1198879012, player.get_player_ped(player.player_id()), true, false, 1000)
				_GF_delay_(delay_table[f.value])
			end
		end
	end
	f.name="Gee-Flare"
end)_G_GE_main.flare_feat.max,_G_GE_main.flare_feat.min,_G_GE_main.flare_feat.mod=6,1,1

_G_GE_main.flare_key_slct=menu.add_feature("Key1 for Gee-Flare HIDDEN","autoaction_value_str",_G_GeeFlare.id,function(f)
end)_G_GE_main.flare_key_slct.set_str_data(_G_GE_main.flare_key_slct,_GT_keys_vk_name)
_G_GE_main.flare_key_slct.hidden=true
_G_GE_main.flare_key_slct.value=63

menu.add_feature("Set key for Gee-Flare","action",_G_GeeFlare.id,function()
	_GF_set_keybinds(1,"Gee-Flare",_G_GE_main.flare_key_slct)
end)

_G_veh_gun_main={}
_G_veh_gun_main.parent=menu.add_feature("Vehicle gun", "parent", _G_Weapons.id)
_G_veh_gun_main.feat=menu.add_feature("Weaponize nearby vehicles", "value_str", _G_veh_gun_main.parent.id, function(f)
	if f.on and _GF_GS_is_loaded() then
		menu.notify("When shooting, nearby vehicles will launch at the target", _G_GeeVer, 4, 2)
	end
	local continue,pos,all_veh,count,aim_ent,bypass,veh
	local function _ign_ent()
		if _GF_me_in_any_veh() then
			return player.get_player_vehicle(player.player_id())
		end
		return player.get_player_ped(player.player_id())
	end
	local function in_grid(my_pos,ent_pos,_max)
		if math.abs(my_pos.x - ent_pos.x) > _max or math.abs(my_pos.y - ent_pos.y) > _max or math.abs(my_pos.z - ent_pos.z) > _max then
			return false
		end
		return true
	end
	local function good_ent(_ent)
		if _GF_is_ent(_ent) and _ent ~= _ign_ent() and not in_grid(player.get_player_coords(player.player_id()),entity.get_entity_coords(_ent),10) then
			if f.value == 2 then
				if entity.is_entity_a_ped(_ent) and ped.is_ped_in_any_vehicle(_ent) then return true, ped.get_vehicle_ped_is_using(_ent)
				elseif entity.is_entity_a_vehicle(_ent) then return true, _ent end
				return true, nil
			elseif entity.is_entity_a_ped(_ent) then
				if f.value == 1 then
					if ped.is_ped_in_any_vehicle(_ent) then return ped.is_ped_a_player(_ent), ped.get_vehicle_ped_is_using(_ent) end
					return ped.is_ped_a_player(_ent), nil
				end
				if ped.is_ped_in_any_vehicle(_ent) then return true, ped.get_vehicle_ped_is_using(_ent)	end
				return true, nil
			end
		end
		return false, nil
	end
	local function get_pos_ent()
		local good,ent,skip,target_pos
		ent=player.get_entity_player_is_aiming_at(player.player_id()) 
		good, skip = good_ent(ent)
		if good then return true, entity.get_entity_coords(ent), skip, ent end
		if f.value == 2 then
			good,target_pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
			if good and not in_grid(player.get_player_coords(player.player_id()),target_pos,10) then return true, target_pos, nil, nil end
		end
		good,target_pos,ent = _GF_raycast_vector()
		if good then
			good, skip = good_ent(ent)
			if good then return true, entity.get_entity_coords(ent), skip, ent end
			if f.value == 2 and not in_grid(player.get_player_coords(player.player_id()),target_pos,10) then return true, target_pos,nil, nil end
		end
		return false,nil,nil, nil
	end
	local function good_veh(_veh)
		if _veh ~= bypass and not vehicle.get_vehicle_has_been_owned_by_player(_veh) then
			if _G_veh_gun_main.type.value == 3 and _veh == veh then
				return false
			end
			return true
		end
		return false
	end
	while f.on do
		system.yield(0)
		if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
			continue,pos,bypass,aim_ent = get_pos_ent()
			if continue then
				all_veh = vehicle.get_all_vehicles()
				if _G_veh_gun_main.select.value == 0 then
					_GF_sort_xyz_ent(all_veh,pos)
				else
					_GF_sort_xyz_ent(all_veh,player.get_player_coords(player.player_id()))
				end
				count =0
				for i=1,#all_veh do
					if count == 5 then
						break
					elseif good_veh(all_veh[i]) and _GF_request_ctrl(all_veh[i],25) then
						veh = all_veh[i]
						count=count+1
						if _GF_is_ent(aim_ent) then pos = entity.get_entity_coords(aim_ent) end
						if _G_veh_gun_main.type.value == 0 then
							entity.set_entity_coords_no_offset(all_veh[i],pos+v3(math.random(-_G_veh_gun_main.spwn_rng.value*.5,_G_veh_gun_main.spwn_rng.value*.5),math.random(-_G_veh_gun_main.spwn_rng.value*.5,_G_veh_gun_main.spwn_rng.value*.5),_G_veh_gun_main.spwn_rng.value))
						elseif _G_veh_gun_main.type.value == 1 then
							entity.set_entity_coords_no_offset(all_veh[i],pos+v3(math.random(-_G_veh_gun_main.spwn_rng.value,_G_veh_gun_main.spwn_rng.value),math.random(-_G_veh_gun_main.spwn_rng.value,_G_veh_gun_main.spwn_rng.value),math.random(0,_G_veh_gun_main.spwn_rng.value*.5)))
						elseif _G_veh_gun_main.type.value == 3 then
							entity.set_entity_coords_no_offset(all_veh[i],_GF_front_of_pos(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5+(_G_veh_gun_main.safe_zone.value*.5), 180, 0))
						end
						vehicle.set_vehicle_out_of_control(all_veh[i], true, true)
						entity.set_entity_rotation(all_veh[i], _GF_vector_to_pos(pos,all_veh[i]))
						entity.set_entity_coords_no_offset(all_veh[i],entity.get_entity_coords(all_veh[i]))
						vehicle.set_vehicle_forward_speed(all_veh[i],_G_veh_gun_main.veh_speed.value)
						if _G_veh_gun_main.type.value == 3 then
							_GF_delay_(math.floor(_G_veh_gun_main.delay.value/2))
							count=5
						else
							_GF_delay_(math.floor(_G_veh_gun_main.delay.value/10))
						end
					end
				end
				_GF_delay_(_G_veh_gun_main.delay.value)
			end
		end
	end
end)_G_veh_gun_main.feat:set_str_data({"Shooting any ped", "Shooting a player","Shooting anything"})

_G_veh_gun_main.type=menu.add_feature("Select type", "action_value_str", _G_veh_gun_main.parent.id)
_G_veh_gun_main.type:set_str_data({"Spawn on top", "Spawn all around","Fly in","Bullets"})

_G_veh_gun_main.spwn_rng=menu.add_feature("Spawn range", "action_value_i", _G_veh_gun_main.parent.id)
_GF_set_feat_i_f(_G_veh_gun_main.spwn_rng,5,25,1,10)

_G_veh_gun_main.safe_zone=menu.add_feature("Safe zone size", "action_value_i", _G_veh_gun_main.parent.id)
_GF_set_feat_i_f(_G_veh_gun_main.safe_zone,5,50,1,10)

_G_veh_gun_main.delay=menu.add_feature("Artificial delay (ms)", "action_value_i", _G_veh_gun_main.parent.id)
_GF_set_feat_i_f(_G_veh_gun_main.delay,50,250,25,125)

_G_veh_gun_main.select=menu.add_feature("Use vehicles", "action_value_str", _G_veh_gun_main.parent.id)
_G_veh_gun_main.select:set_str_data({"Closest to target", "Closest to me"})

_G_veh_gun_main.veh_speed=menu.add_feature("Vehicle speed", "action_value_i", _G_veh_gun_main.parent.id)
_GF_set_feat_i_f(_G_veh_gun_main.veh_speed,25,500,25,100)

_GT_sniper_has_true = {}
_GT_sniper_has_true[gameplay.get_hash_key("weapon_sniperrifle")] = true
_GT_sniper_has_true[gameplay.get_hash_key("weapon_heavysniper")] = true
_GT_sniper_has_true[gameplay.get_hash_key("weapon_heavysniper_mk2")] = true
_GT_sniper_has_true[gameplay.get_hash_key("weapon_marksmanrifle")] = true
_GT_sniper_has_true[gameplay.get_hash_key("weapon_marksmanrifle_mk2")] = true

_G_GeeSniperStrafe=menu.add_feature("Enhanced sniper strafe speed", "value_i", _G_Weapons.id, function(f) -- i made this before i knew about the rad/deg math
	local me_id,my_ped,pos,heading,left,right,decimals,north,north_head,count,south_head,west,west_head,east,east_head,force_mod,x_force,y_force
    while f.on do
		system.yield(0)
		me_id=player.player_id()
		my_ped = player.get_player_ped(me_id)
		if _GF_key_active(114,1) and not _GF_me_in_any_veh() and _GT_sniper_has_true[ped.get_current_ped_weapon(my_ped)] then
			pos=player.get_player_coords(player.player_id())
			heading=player.get_player_heading(me_id)
			left,right=false,false
			if _GF_key_active(34,1) then
				heading=heading+95
				if heading > 180 then
					heading = heading - 360
				end
				left=true
			elseif _GF_key_active(35,1) then
				right=true
				heading=heading-95
				if heading < -180 then
					heading = heading + 360
				end
			end
			if left or right then
				north=0
				if (heading >= -90) and (heading <= 90) then
					north_head=math.abs(heading)
					decimals=north_head-math.floor(north_head)
					north_head=math.floor(north_head)
					count=90
					for i=1, north_head do
						if 	north_head == i then
							north=count/90
							north=north+decimals
						else
							count=count-1
						end
					end
				end
				south=0
				if (heading <= -90) or (heading >= 90) then
					south_head=math.abs(heading)
					south_head=south_head-90
					south=south_head/90
				end
				west=0
				if (heading >= 0) and (heading <= 180) then
					if heading >=90 then
						decimals=heading-math.floor(heading)
						west_head=math.floor(heading)
						count=90
						for i=90, west_head do
							if 	west_head == i then
								west=count/90
								west=west+decimals
							else
								count=count-1
							end
						end
					else
						west=heading/90
					end
				end
				east=0
				if (heading <= 0) and (heading >= -180) then
					east_head=math.abs(heading)
					if east_head >=90 then
						decimals=east_head-math.floor(east_head)
						east_head=math.floor(east_head)
						count=90
						for i=90, east_head do
							if 	east_head == i then
								east=count/90
								east=east+decimals
							else
								count=count-1
							end
						end
					else
						east=east_head/90
					end
				end
				south=south*-1
				west=west*-1
				force_mod=f.value+3
				force_mod=force_mod*.069 --nice
				x_force=west+east
				x_force=x_force*force_mod
				y_force=north+south
				y_force=y_force*force_mod
				if left then
					while _GF_key_active(34,1) do
						system.yield(0)
						entity.apply_force_to_entity(my_ped, 1, x_force,y_force,0.001, 0,0,0, false, true)
					end
				elseif right then
					while _GF_key_active(35,1) do
						system.yield(0)
						entity.apply_force_to_entity(my_ped, 1, x_force,y_force,0.001, 0,0,0, false, true)
					end
				end
				system.yield(100)
			end
		end
	end
end)_G_GeeSniperStrafe.max,_G_GeeSniperStrafe.min,_G_GeeSniperStrafe.mod=15,1,1	

_G_GeeSniperZoom=menu.add_feature("Auto sniper zoom %", "value_i", _G_Weapons.id, function(f)
	local time = utils.time_ms()
    while f.on do
		system.yield(0)
		time = utils.time_ms()
		while _GF_key_active(114,1) and not _GF_me_in_any_veh() and _GT_sniper_has_true[ped.get_current_ped_weapon(player.get_player_ped(player.player_id()))] do
			system.yield(0)
			if utils.time_ms() - time <= f.value/100*2000 then
				controls.set_control_normal(0,40, 1.0)
				controls.set_control_normal(0,42, 1.0)
				controls.set_control_normal(0,274, 1.0)
				controls.set_control_normal(0,276, 1.0)
			end
		end
	end
end)_G_GeeSniperZoom.max,_G_GeeSniperZoom.min,_G_GeeSniperZoom.mod=100,10,10
_G_GeeSniperZoom.value=100

_G_vehicle_driver_weapon2=menu.add_feature("Hijack driver bullets", "toggle", _G_Weapons.id, function(f)
	while f.on do
		system.yield(0)
		_GF_bullets_do("hijack")
	end
end)

function _GF_bullets_do(_action,_val)
	if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
		local aim_ent=player.get_entity_player_is_aiming_at(player.player_id())
		if _GF_valid_veh(aim_ent) then
			if _action == "fuck" then
				_GF_veh_is_fucked(aim_ent, 1000)
			elseif  _action == "hijack" then
				_GF_veh_hijack(aim_ent,false)
			end
		elseif entity.is_entity_a_ped(aim_ent) and ped.is_ped_in_any_vehicle(aim_ent) then
			if _GF_valid_veh(ped.get_vehicle_ped_is_using(aim_ent)) then
				if _action == "fuck" then
					_GF_veh_is_fucked(ped.get_vehicle_ped_is_using(aim_ent), 1000)
				elseif  _action == "hijack" then
					_GF_veh_hijack(ped.get_vehicle_ped_is_using(aim_ent),true)
				elseif  _action == "veh_kick" then
					_GF_kick_all_from_veh(ped.get_vehicle_ped_is_using(aim_ent),_val)
				end
			end
		end
		if entity.is_entity_a_ped(aim_ent) and ped.is_ped_a_player(aim_ent) then
			if _action == "cayo" then
				_GF_send_to_cayo(player.get_player_from_ped(aim_ent))
				system.yield(500)
			elseif _action == "bounty" then
				_GF_give_bounty(player.get_player_from_ped(aim_ent),_val)
				system.yield(500)
			elseif _action == "wanted" then
				_GF_set_wnt_all_psngrs(player.get_player_from_ped(aim_ent),_val)
				system.yield(500)
			end
		end
	end
end

menu.add_feature("Fuck vehicle bullets", "toggle", _G_Weapons.id, function(f)
	while f.on do
		system.yield(0)
		_GF_bullets_do("fuck")
	end
end)

menu.add_feature("Cayo Perico bullets", "toggle", _G_Weapons.id, function(f)--------------
	while f.on do
		system.yield(0)
		_GF_bullets_do("cayo")
	end
end)

_G_bounty_bullets=menu.add_feature("Bounty bullets (anonymous)", "value_str", _G_Weapons.id, function(f)--------------
	while f.on do
		system.yield(0)
		local bounty = 0
		if f.value == 0 then bounty = 10000
		elseif f.value == 1 then bounty = 9000
		elseif f.value == 2 then bounty = 8000
		elseif f.value == 3 then bounty = 7000
		elseif f.value == 4 then bounty = 6000
		elseif f.value == 5 then bounty = 5000
		elseif f.value == 6 then bounty = 4000
		elseif f.value == 7 then bounty = 3000
		elseif f.value == 8 then bounty = 2000
		elseif f.value == 9 then bounty = 1000
		elseif f.value == 10 then bounty = 666
		elseif f.value == 11 then bounty = 420
		elseif f.value == 12 then bounty = 69
		elseif f.value == 13 then bounty = 1
		end
		_GF_bullets_do("bounty",bounty)
	end
end)_G_bounty_bullets:set_str_data({"$10,000", "$9,000","$8,000","$7,000","$6,000","$5,000","$4,000","$3,000","$2,000","$1,000", "$666", "$420","$69","$1",})
	
_G_veh_kick_all_bullets=menu.add_feature("Vehicle kick bullets", "value_str", _G_Weapons.id, function(f)
	while f.on do
		system.yield(0)
		_GF_bullets_do("veh_kick",f.value==1)
	end
end)_G_veh_kick_all_bullets:set_str_data({"Everyone", "Exclude Friends"})

_G_plyr_wntd_bllts=menu.add_feature("Wanted level bullets", "value_i", _G_Weapons.id, function(f)--------------
	while f.on do
		system.yield(0)
		_GF_bullets_do("wanted",f.value)
	end
end)_GF_set_feat_i_f(_G_plyr_wntd_bllts,0,5,1,5)
-----------------------------------------------------------------------------------------GEE-SKID
---------------------------------------------------------------------------------------------SELF
-----------------------------------------------------------------------------------CurrentVehicle
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------


_G_mk2_invrtd = {}

_G_mk2_invrtd_parent=menu.add_feature("Mk2 inverted flight","parent",_G_CurrentVehicle.id)

_G_mk2_invrtd.feat=menu.add_feature("Inverted flight","value_str",_G_mk2_invrtd_parent.id,function(f)
	local _shift,_ctrl,_a,_d
	local pitch,roll,yaw = 0,0,0
	local pitch_spd,roll_spd,yaw_spd = 1,1,1
	local pitch_max,roll_max,yaw_max = 25,25,25
	local Table_spd = {}
	local table_int,speed_do = 0,false
	local time = utils.time_ms()
	for i=1,3 do
		Table_spd[i]={0,0}
	end
	local do_once=false
	local function range_of_1_to_3(_int,_offset)
		if _int - _offset < 1 then
			return _int - _offset + 3
		end
		return _int - _offset
	end
	local function math_neg(_val,_max,_spd)
		if _val > -_max then
			if _val >= 0 then return (_val - (.269*2*_spd))*.99
			else return (_val - (.269*2*_spd))*1.01
			end
		else return -_max
		end
	end
	local function math_pos(_val,_max,_spd)
		if _val < _max then
			if _val >= 0 then return (_val + (.269*2*_spd))*1.01
			else return (_val + (.269*2*_spd))*.99
			end
		else return _max
		end
	end
	local function to_zero(_val,_spd)
		if _val > 0 then return (_val - (.269*2*_spd))*.99
		else return (_val + (.269*2*_spd))*.99
		end
	end
	local function maths(_val,_input1,_input2,_max,_spd)
		if (_GF_key_active(_input1,0) or _GF_key_active(_input2,0)) and (_GF_key_active(_input1,1) or _GF_key_active(_input2,1)) then
			if _GF_key_active(_input1,1) then return math_neg(_val,_max,_spd)
			else return math_pos(_val,_max,_spd)
			end
		else return to_zero(_val,_spd)
		end
	end
	while f.on do
		system.yield(250)
		time = utils.time_ms()
		do_once=false -- plans for safe-enable so you dont decapitate yourself
		if _GF_me_in_any_veh() and _GF_is_this_veh(player.get_player_vehicle(player.player_id()),"oppressor2") and not _GF_is_dead(player.get_player_vehicle(player.player_id())) then
			_GF_ent_tp(player.get_player_vehicle(player.player_id()),player.get_player_coords(player.player_id()), 2.5 ,false)
			while f.on and _GF_me_in_any_veh() and not _GF_is_dead(player.get_player_vehicle(player.player_id())) do
				system.yield(0)
				if time+200 < utils.time_ms() then
					if table_int == 3 then
						table_int = 1
					else
						table_int = table_int + 1
					end
					Table_spd[table_int][1] = entity.get_entity_speed(player.get_player_vehicle(player.player_id())) 
					Table_spd[table_int][2] = _GF_1_decimal(Table_spd[range_of_1_to_3(table_int,1)][1] - Table_spd[table_int][1])
					time = utils.time_ms()
				end
				_shift,_ctrl,_a,_d = 88,87,63,64
				if f.value == 0 then
					_shift,_ctrl,_a,_d = 87,88,64,63
				end
				pitch_max,roll_max,yaw_max = _G_mk2_invrtd.pitch.value,_G_mk2_invrtd.roll.value,_G_mk2_invrtd.yaw.value
				pitch_spd,roll_spd,yaw_spd = _G_mk2_invrtd.pitch_speed.value,_G_mk2_invrtd.roll_speed.value,_G_mk2_invrtd.yaw_speed.value
				yaw = maths(yaw,_a,_d,yaw_max,yaw_spd)
				pitch = maths(pitch,_shift,_ctrl,pitch_max,pitch_spd)
				if (_GF_key_active(_a,0) or _GF_key_active(_d,0)) and (_GF_key_active(_a,1) or _GF_key_active(_d,1)) then
					if (_GF_key_active(_shift,0) or _GF_key_active(_ctrl,0)) and (_GF_key_active(_shift,1) or _GF_key_active(_ctrl,1)) then
						if _GF_key_active(_shift,1) then
							if _GF_key_active(_a,1) then
								roll = math_pos(roll,roll_max,roll_spd)
							else
								roll = math_neg(roll,roll_max,roll_spd)
							end
						elseif _GF_key_active(_a,1) then
							roll = math_neg(roll,roll_max,roll_spd)
						else
							roll = math_pos(roll,roll_max,roll_spd)
						end
					elseif _GF_key_active(_a,1) then
						roll = math_pos(roll,roll_max,roll_spd)
					else
						roll = math_neg(roll,roll_max,roll_spd)
					end
				else
					roll = to_zero(roll,roll_spd)
				end
				if _G_mk2_invrtd.boost.on then
					if Table_spd[1][2] > 0 and Table_spd[2][2] > 0 and Table_spd[3][2] > 0 and _GF_key_active(71,1) and _GF_key_active(72,0) then
						vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()),entity.get_entity_speed(player.get_player_vehicle(player.player_id()))*1.01)
					end
				end
				if 	_GF_key_active(_a,1) or _GF_key_active(_d,1) or _GF_num_in_range(yaw,-(yaw_max*1.25),-2) or _GF_num_in_range(yaw,2,(yaw_max*1.25)) or 
					_GF_key_active(_shift,1) or _GF_key_active(_ctrl,1) or _GF_num_in_range(pitch,-(pitch_max*1.25),-2) or _GF_num_in_range(pitch,2,(pitch_max*1.25)) or
					_GF_num_in_range(roll,-(roll_max*1.25),-2) or _GF_num_in_range(roll,2,(roll_max*1.25)) then
					entity.set_entity_rotation(player.get_player_vehicle(player.player_id()),v3(cam.get_gameplay_cam_rot().x*-1+pitch,180+roll,cam.get_gameplay_cam_rot().z+yaw))
				else
					entity.set_entity_rotation(player.get_player_vehicle(player.player_id()),v3(cam.get_gameplay_cam_rot().x*-1,180,cam.get_gameplay_cam_rot().z))
					pitch,yaw,roll = 0,0,0
					if _GF_key_active(71,0) and _GF_key_active(72,0) then
						if _G_mk2_invrtd.brakes.on then
							entity.set_entity_velocity(player.get_player_vehicle(player.player_id()),v3(
							entity.get_entity_velocity(player.get_player_vehicle(player.player_id())).x*.99,
							entity.get_entity_velocity(player.get_player_vehicle(player.player_id())).y*.99,
							entity.get_entity_velocity(player.get_player_vehicle(player.player_id())).z*.4))
						else
							entity.set_entity_velocity(player.get_player_vehicle(player.player_id()),v3(
							entity.get_entity_velocity(player.get_player_vehicle(player.player_id())).x,
							entity.get_entity_velocity(player.get_player_vehicle(player.player_id())).y,
							entity.get_entity_velocity(player.get_player_vehicle(player.player_id())).z*.4)) --retarded glitch makes it go up in the air sometimes
						end
					end
				end
			end
		end
	end
end)_G_mk2_invrtd.feat:set_str_data({"Inverted controls", "Normal controls"})

_G_mk2_invrtd.brakes=menu.add_feature("Auto brakes","toggle",_G_mk2_invrtd_parent.id)

_G_mk2_invrtd.boost=menu.add_feature("Smart torque boost","toggle",_G_mk2_invrtd_parent.id)

_G_mk2_invrtd.pitch=menu.add_feature("Pitch max","action_value_i",_G_mk2_invrtd_parent.id)
_G_mk2_invrtd.pitch.max,_G_mk2_invrtd.pitch.min,_G_mk2_invrtd.pitch.mod=50,5,1	
_G_mk2_invrtd.pitch.value=25	

_G_mk2_invrtd.roll=menu.add_feature("Roll max","action_value_i",_G_mk2_invrtd_parent.id)
_G_mk2_invrtd.roll.max,_G_mk2_invrtd.roll.min,_G_mk2_invrtd.roll.mod=50,5,1	
_G_mk2_invrtd.roll.value=25

_G_mk2_invrtd.yaw=menu.add_feature("Yaw max","action_value_i",_G_mk2_invrtd_parent.id)
_G_mk2_invrtd.yaw.max,_G_mk2_invrtd.yaw.min,_G_mk2_invrtd.yaw.mod=50,5,1
_G_mk2_invrtd.yaw.value=25

_G_mk2_invrtd.pitch_speed=menu.add_feature("Pitch speed","action_value_f",_G_mk2_invrtd_parent.id)
_G_mk2_invrtd.pitch_speed.max,_G_mk2_invrtd.pitch_speed.min,_G_mk2_invrtd.pitch_speed.mod=3,.05,.05	
_G_mk2_invrtd.pitch_speed.value=1	

_G_mk2_invrtd.roll_speed=menu.add_feature("Roll speed","action_value_f",_G_mk2_invrtd_parent.id)
_G_mk2_invrtd.roll_speed.max,_G_mk2_invrtd.roll_speed.min,_G_mk2_invrtd.roll_speed.mod=3,.05,.05	
_G_mk2_invrtd.roll_speed.value=1

_G_mk2_invrtd.yaw_speed=menu.add_feature("Yaw speed","action_value_f",_G_mk2_invrtd_parent.id)
_G_mk2_invrtd.yaw_speed.max,_G_mk2_invrtd.yaw_speed.min,_G_mk2_invrtd.yaw_speed.mod=3,.05,.05	
_G_mk2_invrtd.yaw_speed.value=1


-------------------------------------------------------------------------------GeeSkid Gee-flight 
_G_vehicle_flier=menu.add_feature("Gee-Flight", "value_i", _G_CurrentVehicle.id, function(f)
	local my_veh,speed,_up,_down
	while f.on do
		system.yield(0)
		if _GF_me_driving(player.get_player_vehicle(player.player_id())) then
			my_veh=player.get_player_vehicle(player.player_id())
			entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot())
			if not _GF_key_active(143,1) and not _GF_key_active(21,1) and not _GF_key_active(32,1) and not _GF_key_active(33,1) and not _GF_key_active(34,1) and not _GF_key_active(35,1) then
				--vehicle.set_vehicle_forward_speed(my_veh,-0)
				entity.set_entity_max_speed(my_veh,0)
			else
				entity.set_entity_max_speed(my_veh, 45000)
				speed = _G_vehicle_flier.value/2.231
				_up,_down=false,false
				if _GF_key_active(143,1) then -- pressing space
					_up=true
				elseif _GF_key_active(21,1) then -- pressing left shit	
					_down=true
				end
				if _GF_key_active(32,1) then --Pressing W
					if not _GF_key_active(33,1) then -- not Pressing S
						if _GF_key_active(34,1) and _GF_key_active(35,1) then -- If pressing AD Vehicle moves forward
							entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,0,_up,_down,true))
						elseif _GF_key_active(34,1) then -- pressing A vehicle moves forward/left
							entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,45,_up,_down,false))
						elseif _GF_key_active(35,1) then -- pressing D vehicle moves forward/right
							entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,-45,_up,_down,false)) -- Then vehicle moves forward/right
						else
							if not _up and not _down then
								vehicle.set_vehicle_forward_speed(my_veh,speed)
							else
								entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,0,_up,_down,true))
							end
						end
					else
						vehicle.set_vehicle_forward_speed(my_veh,0) -- Then vehicle is stationary					
					end
				elseif _GF_key_active(33,1) then -- Pressing S
					if _GF_key_active(35,1) and _GF_key_active(34,1) then 
						entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,180,_up,_down,true,true)) -- Vehicle moves backwards
					elseif _GF_key_active(35,1) then 	
						entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,-135,_up,_down,false,true)) -- Then vehicle moves backward/right
					elseif _GF_key_active(34,1) then 
						entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,135,_up,_down,false,true)) -- Then vehicle moves backward/left
					else
						entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,180,_up,_down,true,true)) -- Vehicle moves backwards
					end		
				elseif _GF_key_active(34,1) then --Pressing A
					entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,90,_up,_down,false)) -- Vehicle moves left
				elseif _GF_key_active(35,1) then --Pressing D
					entity.set_entity_velocity(my_veh,_GF_flight_calc(cam.get_gameplay_cam_rot(),speed,-90,_up,_down,false)) -- Vehicle moves right			
				elseif _up then -- pressing space
					entity.set_entity_velocity(my_veh,v3(0,0,speed)) -- Vehicle moves up
				elseif _down then -- pressing left shit	
					entity.set_entity_velocity(my_veh,v3(0,0,speed*-1)) -- Vehicle moves down
				end
			end
		end
	end
	if _GF_valid_veh(my_veh) then
		entity.set_entity_max_speed(my_veh, 45000)
		--speed = entity.get_entity_velocity(my_veh)coords
		--vehicle.set_vehicle_on_ground_properly(my_veh)
		system.yield(20)
		_GF_ent_tp(my_veh,entity.get_entity_coords(my_veh), 0 ,true)
		--entity.set_entity_velocity(my_veh,speed)
	end
end)_G_vehicle_flier.max,_G_vehicle_flier.min,_G_vehicle_flier.mod=5000,50,50

-- A LEFT STICK 34
-- S LEFT STICK 33
-- W LEFT STICK 32
-- D LEFT STICK 35
-- LEFT SHIFT A 21
-- SPACEBAR X   143
-- LEFT CTRL A  132

_G_veh_rapid_fire=menu.add_feature("Vehicle Rapid Fire","slider",_G_CurrentVehicle.id,function(feat)
_G_veh_rapid_fire_khan.on=false
	if feat.on then
		if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) then
			vehicle.set_vehicle_fixed(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
			if feat.value == 500 then system.wait(75)
			elseif feat.value == 400 then system.wait(150)
			elseif feat.value == 300 then system.wait(225)
			elseif feat.value == 200 then system.wait(300)
			elseif feat.value == 100 then system.wait(375)
			elseif feat.value == 0 then system.wait(425)
			end		
		end
	return HANDLER_CONTINUE
	end
	return HANDLER_POP
end)_G_veh_rapid_fire.max,_G_veh_rapid_fire.min,_G_veh_rapid_fire.mod=500,0,100

_G_veh_rapid_fire_khan=menu.add_feature("Vehicle Rapid Fire (Tanks/APC)","toggle",_G_CurrentVehicle.id,function(feat)
_G_veh_rapid_fire.on=false
	if feat.on then
		if _GF_me_in_any_veh() then
			if _GF_is_this_veh(player.get_player_vehicle(player.player_id()),"khanjali") or _GF_is_this_veh(player.get_player_vehicle(player.player_id()),"rhino") or (_GF_is_this_veh(player.get_player_vehicle(player.player_id()),"apc") and _GF_me_in_seat(player.get_player_vehicle(player.player_id()),0)) then
				if ped.is_ped_shooting(player.get_player_ped(player.player_id()))  then
					if _GF_is_this_veh(player.get_player_vehicle(player.player_id()),"rhino") then
						vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()))
						system.wait(50)
					elseif _GF_is_this_veh(player.get_player_vehicle(player.player_id()),"apc") then
						if _GF_request_ctrl(player.get_player_vehicle(player.player_id()),50) then
							vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()))
						end
					else
						vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()))
						system.wait(100)
					end
				end
			end
		end	
	return HANDLER_CONTINUE
	end
	return HANDLER_POP
end)

_G_veh_xtra_jmp=menu.add_feature("Vehicle extra jump height","toggle",_G_CurrentVehicle.id,function(f)
	while f.on do
		if player.is_player_in_any_vehicle(player.player_id()) and _GF_can_vehicle_jump(player.get_player_vehicle(player.player_id())) then
			native.call(0xF06A16CA55D138D8,player.get_player_vehicle(player.player_id()),1)
		end
		_GF_yield_while_true(f.on,1000)
	end
	if player.is_player_in_any_vehicle(player.player_id()) and _GF_can_vehicle_jump(player.get_player_vehicle(player.player_id())) then
		native.call(0xF06A16CA55D138D8,player.get_player_vehicle(player.player_id()),0)
	end
end)

_G_rmv_trblnc = menu.add_feature("Remove turbulence", "toggle", _G_CurrentVehicle.id, function(f)
	local function do_native(_val)
		if _GF_me_in_any_veh() and vehicle.get_vehicle_class_name(player.get_player_vehicle(player.player_id())) == "Planes" then
			native.call(0xAD2D28A1AFDFF131,player.get_player_vehicle(player.player_id()),_val)
		end
	end
	while f.on do
		do_native(0.0)
		system.yield(500)
	end
	do_native(1.0)
end)

_G_max_tint = menu.add_feature("Always max tint", "toggle", _G_CurrentVehicle.id, function(f)
	local my_tint = nil
	while f.on do
		if _GF_me_in_any_veh() then
			if vehicle.get_vehicle_window_tint(player.get_player_vehicle(player.player_id())) ~= 1 then
				my_tint = vehicle.get_vehicle_window_tint(player.get_player_vehicle(player.player_id()))
				vehicle.set_vehicle_mod_kit_type(player.get_player_vehicle(player.player_id()), 0)
				vehicle.set_vehicle_window_tint(player.get_player_vehicle(player.player_id()),1)
			end
			system.yield(250)
		end
		system.yield(250)
	end
	if _GF_valid_veh(player.get_player_vehicle(player.player_id())) and my_tint ~= nil then
		vehicle.set_vehicle_window_tint(player.get_player_vehicle(player.player_id()),my_tint)
	end
end)

_G_invncbl_wndows = menu.add_feature("Invincible windows", "toggle", _G_CurrentVehicle.id, function(f)
	_GF_set_invncbl_wndws(player.get_player_vehicle(player.player_id()),true)
	while f.on do
		if _GF_me_in_any_veh() then
			if not _GF_are_wndws_good(player.get_player_vehicle(player.player_id())) and _GF_request_ctrl(player.get_player_vehicle(player.player_id()),1000) then
				vehicle.set_vehicle_mod_kit_type(player.get_player_vehicle(player.player_id()), 0)
				_GF_fx_wndws(player.get_player_vehicle(player.player_id()))
				_GF_set_invncbl_wndws(player.get_player_vehicle(player.player_id()),true)
			end
		end
		_GF_yield_while_true(f.on,1000)
	end
	if _GF_valid_veh(player.get_player_vehicle(player.player_id())) and _GF_request_ctrl(player.get_player_vehicle(player.player_id()),1000) then
		_GF_set_invncbl_wndws(player.get_player_vehicle(player.player_id()),false)
	end
end)

_G_smsh_rpr_wndows=menu.add_feature("Windows", "action_value_str", _G_CurrentVehicle.id, function(f)
	if _GF_me_in_any_veh() and _GF_request_ctrl(player.get_player_vehicle(player.player_id()),1000) then
		if f.value == 0 then
			_GF_brk_wndws(player.get_player_vehicle(player.player_id()))
		else
			_GF_fx_wndws(player.get_player_vehicle(player.player_id()))
		end
	end
end)_G_smsh_rpr_wndows:set_str_data({"Smash", "Repair"})

_G_auto_flip_veh = menu.add_feature("Auto-Flip vehicle if needed", "toggle", _G_VehAutoStuff.id, function(f)
	local in_veh=false
	while f.on do
		system.yield(50)
		if _GF_me_in_any_veh() and (_G_self_veh_auto_setting.value == 0 and _GF_me_driving(player.get_player_vehicle(player.player_id()))) or _G_self_veh_auto_setting.value == 1 then
			if not in_veh then
				_GF_veh_flip(player.get_player_vehicle(player.player_id()),"if_needed",1000) --flip vehicle upon entry
			end
			in_veh=true
			if _GF_veh_upside_down(player.get_player_vehicle(player.player_id())) then
				system.yield(777) --because i like 7
				if _GF_veh_upside_down(player.get_player_vehicle(player.player_id())) then
					system.yield(777)
					if _GF_veh_upside_down(player.get_player_vehicle(player.player_id())) then
						system.yield(777)
						_GF_veh_flip(player.get_player_vehicle(player.player_id()),"if_needed",1000)
						_GF_ent_tp(player.get_player_vehicle(player.player_id()),entity.get_entity_coords(player.get_player_vehicle(player.player_id())), 0 ,true)
					end
				end
			end
		else
			in_veh=false
		end
	end
end)


function _GF_veh_flip(_veh,_type,_time)
	if _GF_valid_veh(_veh) then
		local flip_y=0
		local flip=false
		if _type == "if_needed" then
			if _GF_veh_upside_down(_veh) then
				flip=true
			end
		elseif _type == "flip_right" then
			flip=true
		elseif _type == "flip_wrong" then
			flip=true
			flip_y=180
		end
		if flip then
			if _GF_request_ctrl(_veh,_time) then
				local rot = cam.get_gameplay_cam_rot()
				local speed = entity.get_entity_velocity(_veh)
				local _veh_rot=entity.get_entity_rotation(_veh)
				_veh_rot.z=rot.z
				entity.set_entity_rotation(_veh,v3(0,flip_y,_veh_rot.z))
				if _type == "if_needed" or _type == "flip_right" then
					vehicle.set_vehicle_on_ground_properly(_veh)
					system.yield(20)
				end
				entity.set_entity_velocity(_veh,speed)
				return true
			end
		end
	end
end

function _GF_veh_upside_down(_my_veh)
	if _GF_valid_veh(_my_veh) then
		if entity.is_entity_upside_down(_my_veh) then
			local class = vehicle.get_vehicle_class(_my_veh)
			if (class == 16) or (class == 15) or _GF_is_this_veh(_my_veh,"oppressor2") or _GF_is_this_veh(_my_veh,"oppressor") then 
				if not entity.is_entity_in_air(_my_veh) then -- wont flip planes/helos mk1 884483972 or mk2 884483972 if in the air
					return true
				end
			else
				return true
			end
		end
	end
end
				
_G_self_veh_auto_upgrade=menu.add_feature("Auto-upgrade performance mods", "toggle", _G_VehAutoStuff.id, function()
end)

_G_self_veh_auto_force=menu.add_feature("Auto-upgrade speed/torque %","value_i",_G_VehAutoStuff.id,function()
end)_G_self_veh_auto_force.max,_G_self_veh_auto_force.min,_G_self_veh_auto_force.mod=200,105,5		
_G_self_veh_auto_force.value=120

_G_self_veh_auto_repair=menu.add_feature("Auto-repair", "value_str", _G_VehAutoStuff.id, function()
end)_G_self_veh_auto_repair:set_str_data({"Entry", "Exit", "Both"})

_G_self_veh_auto_god=menu.add_feature("Auto-god", "value_str", _G_VehAutoStuff.id, function(f)
	if not f.on and _GF_me_in_any_veh() then
		if (_G_self_veh_auto_setting.value == 0 and _G_My_Veh_Driver) or _G_self_veh_auto_setting.value == 1 then
			if _GF_valid_veh(player.get_player_vehicle(player.player_id())) and entity.get_entity_god_mode(player.get_player_vehicle(player.player_id())) then
				if _GF_request_ctrl(player.get_player_vehicle(player.player_id()),1000) then
					entity.set_entity_god_mode(player.get_player_vehicle(player.player_id()), false)
				end
			end
		end
	end
end)_G_self_veh_auto_god:set_str_data({"Give", "Remove on exit", "Both"})

_G_self_veh_auto_kick=menu.add_feature("Auto-kick others from vehicle", "value_str", _G_VehAutoStuff.id, function()
end)_G_self_veh_auto_kick:set_str_data({"Everyone", "Exclude Friends"})

_G_self_veh_auto_setting=menu.add_feature("--> Only applies when in", "autoaction_value_str", _G_VehAutoStuff.id, function()
end)_G_self_veh_auto_setting:set_str_data({"Driver seat", "Any Seat"})

_G_My_Veh_Driver=false
_GT_my_veh_hist = {}
_G_self_veh_auto_hidden=menu.add_feature("Auto-self veh do hidden", "toggle", _G_VehAutoStuff.id, function(f)
	local last_do_once=false
	local current_do_once=false
	while f.on do
		system.yield(50)
		if _GF_me_in_any_veh() then
			if #_GT_my_veh_hist == 0 then
				_GT_my_veh_hist[#_GT_my_veh_hist+1]=player.get_player_vehicle(player.player_id())
			elseif _GT_my_veh_hist[#_GT_my_veh_hist] ~= player.get_player_vehicle(player.player_id()) then
				_GT_my_veh_hist[#_GT_my_veh_hist+1]=player.get_player_vehicle(player.player_id())
			end
			last_do_once=false
			system.yield(50)
			_G_My_Veh_Driver = _GF_me_driving(player.get_player_vehicle(player.player_id()))
			if not current_do_once and _GF_self_veh_auto_do(_GT_my_veh_hist[#_GT_my_veh_hist]) then
				current_do_once=true
			end
		else	
			system.yield(50)
			current_do_once=false
			if not last_do_once then
				_GF_self_veh_last_do(_GT_my_veh_hist[#_GT_my_veh_hist])
				last_do_once=true
			end
		end
	end
end)
_G_self_veh_auto_hidden.on=true
_G_self_veh_auto_hidden.hidden=true

function _GF_self_veh_last_do(_veh)
	if _GF_valid_veh(_veh) then
		if _G_self_veh_auto_god.on then
			if (_G_self_veh_auto_god.value == 1 and _G_My_Veh_Driver) or _G_self_veh_auto_god.value == 2 then
				if entity.get_entity_god_mode(_veh) and _GF_request_ctrl(_veh,1000) then
					entity.set_entity_god_mode(_veh, false)
				end
			end
		end
	end
	if _G_self_veh_auto_repair.on and _G_self_veh_auto_repair.value ~= 0 then
		_GF_veh_repair_basic(_veh, 1000)
	end
end

function _GF_self_veh_auto_do(_veh)
	if (_G_self_veh_auto_setting.value == 0 and _G_My_Veh_Driver) or _G_self_veh_auto_setting.value == 1 then
		if _G_self_veh_auto_kick.on and _GF_valid_veh(_veh) then
			_GF_kick_all_from_veh(_veh, (_G_self_veh_auto_kick.value ~= 0))
			system.yield(125)
		end
		if _G_self_veh_auto_god.on and _GF_valid_veh(_veh) then
			if (_G_self_veh_auto_god.value == 0 or _G_self_veh_auto_god.value == 2) and not entity.get_entity_god_mode(_veh) then
				if _GF_request_ctrl(_veh,1000) then
					entity.set_entity_god_mode(_veh, true)
					system.yield(125)
				end
			end
		end		
		if _G_self_veh_auto_repair.on and _GF_valid_veh(_veh) then
			if _G_self_veh_auto_repair.value == 0 or _G_self_veh_auto_repair.value == 2 then
				_GF_veh_repair_basic(_veh, 1000)
				system.yield(125)
			end
		end
		if _G_self_veh_auto_upgrade.on and _GF_valid_veh(_veh) then
			_GF_veh_upgr_one_kek(_veh, 1000, "perf", true)
			system.yield(125)
		end
		if _G_self_veh_auto_force.on and _GF_valid_veh(_veh) then
			_GF_veh_speed(_veh, 1000, _GF_veh_ped_name(_veh,"first_plyr"), _GF_model_name(_veh), true, _G_self_veh_auto_force.value/100)
			system.yield(125)
		end
		return true
	end
	return false
end

menu.add_feature("Repair current vehicle", "action", _G_CurrentVehicle.id, function()
	_GF_self_veh_current_do("repair")
end)

_G_auto_veh_rpr=menu.add_feature("Auto-repair if less than %", "value_i", _G_CurrentVehicle.id, function(f)
	while f.on do
		system.yield(100)
		if _GF_me_driving(player.get_player_vehicle(player.player_id())) and _GF_get_veh_cmbnd_hlth_prcnt(player.get_player_vehicle(player.player_id()),true) < f.value then
			_GF_rpr_request(player.get_player_vehicle(player.player_id()),250)
		end
	end
end)_GF_set_feat_i_f(_G_auto_veh_rpr,50,100,5,75)

_G_missile_no_lock=menu.add_feature("Vehicle missile anti-lock","action_value_str",_G_CurrentVehicle.id,function(f, pid)
	local me = player.player_id()
	if not _GF_me_in_any_veh() then
		menu.notify("You are not in a vehicle." , _G_GeeVer, 4, 2)
	elseif _GF_request_ctrl(_GT_plyr_info.veh[me+1],2500) then
		if f.value == 0 then 
			vehicle.set_vehicle_can_be_locked_on(_GT_plyr_info.veh[me+1], false, true)
		else
			vehicle.set_vehicle_can_be_locked_on(_GT_plyr_info.veh[me+1], true, true)
		end
	else
		menu.notify("Failed to receive control." , _G_GeeVer, 4, 2)
	end
end)
_G_missile_no_lock:set_str_data({
"Give",
"Remove"})
	
-- _G_plate_text_val = "Gee-Skid"
-- menu.add_feature("save string test", "action", _G_CurrentVehicle.id, function()
	-- while true do 
        -- system.yield(0)
		-- local status, input = input.get("Plate text", _G_plate_text_val, 8, 0)
		-- if status == 2 then
			-- menu.notify("Plate change cancelled" , _G_GeeVer, 4, 2)
			-- break
		-- elseif status == 0 then
			-- local old = _G_plate_text_val
			-- _G_plate_text_val = input
			-- menu.notify("Plate changed from "..old.." to ".._G_plate_text_val.."", _G_GeeVer, 4, 2)
			-- break
		-- end
	-- end	
-- end)

-- menu.add_feature("save string test", "action", _G_CurrentVehicle.id, function()
	-- menu.notify("Plate ".._G_plate_text_val.."", _G_GeeVer, 4, 2)
-- end)
-- _G_self_veh_convertible=menu.add_feature("Convertible", "action_value_str", _G_CurrentVehicle.id, function(f)
	-- local me = player.player_id()
	-- if _GF_me_in_any_veh() then
		-- local time = utils.time_ms() + 5000
		-- while time > utils.time_ms() do
		-- system.yield(0)
		-- if f.value==0 then
			-- vehicle.set_convertible_roof(player.get_player_vehicle(me),true)
		-- else
			-- vehicle.set_convertible_roof(player.get_player_vehicle(me),false)
		-- end
		-- end
	-- end
-- end)_G_self_veh_convertible:set_str_data({"true", "false"})

_G_self_veh_upgrades_action2=menu.add_feature("Vehicle Upgrades","action_value_str",_G_VehUpgrades.id,function(f)
	if f.value == 0 then
		_GF_self_veh_current_do("upgrades")
	elseif f.value == 1 then
		_GF_self_veh_current_do("upgrade_single","perf")
	elseif f.value == 2 then
		_GF_self_veh_current_do("upgrade_single","wheels")
	elseif f.value == 3 then
		_GF_self_veh_current_do("upgrade_single","f1")
	elseif f.value == 4 then
		_GF_self_veh_current_do("upgrade_single","livery")
	elseif f.value == 5 then
		_GF_self_veh_current_do("upgrade_single","weapons")
	end
end)_G_self_veh_upgrades_action2:set_str_data({"Everything", "Performance mods","Wheels/Tires","Give F1 Wheels","Livery","Weapons"})

_G_self_veh_paintjob=menu.add_feature("Random paintjob","action_value_str",_G_VehPaintjob.id,function(f)
	if f.value == 0 then
		_GF_self_veh_current_do("paintjob","random")
	elseif f.value == 1 then
		_GF_self_veh_current_do("paintjob","random_solid")
	elseif f.value == 2 then
		_GF_self_veh_current_do("paintjob",_GF_rand_paint_shade("Dark")) 
	else
		_GF_self_veh_current_do("paintjob",_GF_rand_paint_shade("Bright")) 
	end
end)_G_self_veh_paintjob:set_str_data({"Non-matching", "Matching","Dark","Bright"})

menu.add_feature("Apply custom paintjob","action",_G_VehPaintjobCustom.id,function()
	local paint = _G_veh_custom_paint_r.value * 65536 + _G_veh_custom_paint_g.value * 256 + _G_veh_custom_paint_b.value 
	_GF_self_veh_current_do("paintjob",paint)
end)

function _GF_rand_paint_shade(_type)
	local r,g,b
	if _type == "Dark" then
		r,g,b = _GF_rgb_rand(0,25)
	else
		r,g,b = _GF_rgb_rand(100,150)
	end
	return (r * 65536 +   g  * 256 +  b)
end

function _GF_rgb_rand(_min,_max)
	local rand = math.random(1,6)
	local r,g,b
	if rand == 1 then
		r = math.floor(255 * (math.random(_min,_max)*.01))
		g = math.floor((255 - r) * (math.random(_min,_max)*.01))
		b = math.floor((255 - g) * (math.random(_min,_max)*.01))
	elseif rand == 2 then
		b = math.floor(255 * (math.random(_min,_max)*.01))
		r = math.floor((255 - b) * (math.random(_min,_max)*.01))
		g = math.floor((255 - r) * (math.random(_min,_max)*.01))
	elseif rand == 3 then
		g = math.floor(255 * (math.random(_min,_max)*.01))
		b = math.floor((255 - g) * (math.random(_min,_max)*.01))
		r = math.floor((255 - b) * (math.random(_min,_max)*.01))
	elseif rand == 4 then
		g = math.floor(255 * (math.random(_min,_max)*.01))
		r = math.floor((255 - g) * (math.random(_min,_max)*.01))
		b = math.floor((255 - r) * (math.random(_min,_max)*.01))
	elseif rand == 5 then
		b = math.floor(255 * (math.random(_min,_max)*.01))
		g = math.floor((255 - b) * (math.random(_min,_max)*.01))
		r = math.floor((255 - g) * (math.random(_min,_max)*.01))
	elseif rand == 6 then
		r = math.floor(255 * (math.random(_min,_max)*.01))
		b = math.floor((255 - r) * (math.random(_min,_max)*.01))
		g = math.floor((255 - b) * (math.random(_min,_max)*.01))
	end
	return r,g,b
end

_G_veh_custom_paint_r=menu.add_feature("Custom Red","autoaction_value_i",_G_VehPaintjobCustom.id,function()
end)_G_veh_custom_paint_r.max,_G_veh_custom_paint_r.min,_G_veh_custom_paint_r.mod=255,0,5		

_G_veh_custom_paint_g=menu.add_feature("Custom Green","autoaction_value_i",_G_VehPaintjobCustom.id,function()
end)_G_veh_custom_paint_g.max,_G_veh_custom_paint_g.min,_G_veh_custom_paint_g.mod=255,0,5		

_G_veh_custom_paint_b=menu.add_feature("Custom Blue","autoaction_value_i",_G_VehPaintjobCustom.id,function()
end)_G_veh_custom_paint_b.max,_G_veh_custom_paint_b.min,_G_veh_custom_paint_b.mod=255,0,5		


for i=1,#_GT_paint_list_name do
	menu.add_feature(_GT_paint_list_name[i],"action",_G_VehPaintjob.id,function()
		_GF_self_veh_current_do("paintjob",_GT_paint_list_int[i])
	end)
end



_G_self_veh_neons=menu.add_feature("Random neon color","action",_G_VehNeons.id,function(f)
	_GF_self_veh_current_do("neons","random")
end)

for i=1,#_GT_neon_list_name do
	menu.add_feature(_GT_neon_list_name[i],"action",_G_VehNeons.id,function()
		_GF_self_veh_current_do("neons",_GT_neon_list_int[i])
	end)
end

_G_self_veh_headlights=menu.add_feature("Random headlight color","action",_G_VehHeadlights.id,function(f)
	_GF_self_veh_current_do("headlights","random")
end)

for i=1,#_GT_neon_list_name do
	menu.add_feature(_GT_neon_list_name[i],"action",_G_VehHeadlights.id,function()
		_GF_self_veh_current_do("headlights",i-1)
	end)
end

_G_self_veh_force2=menu.add_feature("Vehicle max speed/torque %","action_value_i",_G_VehUpgrades.id,function()
	_GF_self_veh_current_do("speed_torque")
end)_G_self_veh_force2.max,_G_self_veh_force2.min,_G_self_veh_force2.mod=700,0,5		
_G_self_veh_force2.value=100

_G_self_veh_accel_fuck=menu.add_feature("Vehicle acceleration is","action_value_str",_G_CurrentVehicle.id,function(f)
	if f.value == 0 then _GF_self_veh_current_do("drive_reverse") else _GF_self_veh_current_do("no_drive_reverse") end
end)_G_self_veh_accel_fuck.set_str_data(_G_self_veh_accel_fuck,{"Fucked", "Normal"})

menu.add_feature("Fuck vehicle", "action", _G_CurrentVehicle.id, function()
	_GF_self_veh_current_do("fuck_vehicle")
end)

menu.add_feature("Remove helicopter rotors", "action", _G_CurrentVehicle.id, function()
	_GF_self_veh_current_do("remove_rotor")
end)

menu.add_feature("Flip vehicle upside down", "action", _G_CurrentVehicle.id, function()
	_GF_self_veh_current_do("upside_down")
end)

menu.add_feature("Put vehicle on wheels", "action", _G_CurrentVehicle.id, function()
	_GF_self_veh_current_do("put_on_wheels")
end)

_G_veh_self_rand_force=menu.add_feature("Random force", "action_slider", _G_CurrentVehicle.id, function()
	 _GF_self_veh_current_do("random_force")
end) _G_veh_self_rand_force.max,_G_veh_self_rand_force.min,_G_veh_self_rand_force.mod=150,15,15
_G_veh_self_rand_force.value=50

function _GF_self_veh_current_do(_action,_val)
	if not _GF_me_in_any_veh() then
		menu.notify("You are not in a vehicle",_G_GeeVer,4,2)
	else
		local me=player.player_id()
		local my_veh=player.get_player_vehicle(me)
		if _action == "remove_rotor" and not _GF_valid_helo(my_veh) then
			menu.notify("You are not in a helo.", _G_GeeVer, 4, 2)
		elseif _GF_request_ctrl(my_veh,1000) then
			if _action == "repair" then
				_GF_veh_repair_basic(my_veh, 500)
			elseif _action == "random_force" then
				if entity.is_entity_in_air(my_veh) then
					entity.set_entity_velocity(my_veh,v3(math.random(-_G_veh_self_rand_force.value,_G_veh_self_rand_force.value),math.random(-_G_veh_self_rand_force.value,_G_veh_self_rand_force.value),math.random(-(_G_veh_self_rand_force.value/2.5),-(_G_veh_self_rand_force.value/5))))
				else
					entity.set_entity_velocity(my_veh,v3(math.random(-_G_veh_self_rand_force.value,_G_veh_self_rand_force.value),math.random(-_G_veh_self_rand_force.value,_G_veh_self_rand_force.value),math.random((_G_veh_self_rand_force.value/5),(_G_veh_self_rand_force.value/2.5))))
				end
			elseif _action == "put_on_wheels" then
				vehicle.set_vehicle_on_ground_properly(my_veh)
			elseif _action == "upside_down" then
				entity.set_entity_rotation(my_veh,v3(180,entity.get_entity_rotation(my_veh).y,entity.get_entity_rotation(my_veh).z))
			elseif _action == "remove_rotor" then
				vehicle.set_vehicle_extra(my_veh, 1, 0)
				vehicle.set_vehicle_extra(my_veh, 2, 0)
				vehicle.set_vehicle_extra(my_veh, 7, 0)
			elseif _action == "fuck_vehicle" then
				_GF_veh_is_fucked(my_veh, 1000)
			elseif _action == "drive_reverse" then
				_GF_veh_speed(my_veh, 1000, nil, nil, false, -10)
			elseif _action == "no_drive_reverse" then
				_GF_veh_speed(my_veh, 1000, nil, nil, false, 1)
			elseif _action == "speed_torque" then	
				_GF_veh_speed(my_veh, 1000, nil, nil, false, _G_self_veh_force2.value/100)
			elseif _action == "upgrades" then		
				_GF_veh_upgr_all_kek(my_veh, 1000,false)
			elseif _action == "upgrade_single" then
				_GF_veh_upgr_one_kek(my_veh, 1000,_val,false)
			elseif _action == "paintjob" then
				_GF_veh_upgr_paint(my_veh,_val)
			elseif _action == "neons" then
				_GF_veh_upgr_neons(my_veh,_val)
			elseif _action == "headlights" then
				_GF_veh_upgr_lights(my_veh,_val)
			elseif _action == "gravity" then
				vehicle.set_vehicle_gravity_amount(my_veh, _val)
			end
		else
			menu.notify("Failed to receive control.", _G_GeeVer, 4, 2)
		end
	end

end

function _GF_text_input_get(_title,_default,_max,_type)
	local status,str=1
	_G_GS_type_input=true
	while status == 1 do 
		system.yield(0)
		status, str = input.get(_title, _default, _max, _type)
	end
	_G_GS_type_input=false
	_GF_vk_key_down_with_delay("RETURN")
	if str == "" or str == " " then
		return 2,str
	end
	return status,str
end
	
-----------------------------------------------------------------------------------------GEE-SKID
---------------------------------------------------------------------------------------------SELF
-----------------------------------------------------------------------------------CurrentVehicle
------------------------------------------------------------------------------------GeeDriveStuff
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

_G_GeeBoost=menu.add_feature("Gee-Boost", "toggle", _G_GeeDriveStuff.id, function(f)
	if _GF_GS_is_loaded() and f.on then
		if _G_geeboost_set_keys.value == 0 then
			menu.notify("Gee-Boost Enabled\nWhile in any vehicle hold ".._GT_keys_vk_name[_G_GeeBoostSelect1.value+1].." to boost.", _G_GeeVer, 7, 7)
		elseif _G_geeboost_set_keys.value == 1 then
			menu.notify("Gee-Boost Enabled\nWhile in any vehicle hold ".._GT_keys_vk_name[_G_GeeBoostSelect1.value+1].." and ".._GT_keys_vk_name[_G_GeeBoostSelect2.value+1].." to boost.", _G_GeeVer, 7, 7)
		else
			menu.notify("Gee-Boost Enabled\nWhile in any vehicle hold ".._GT_keys_vk_name[_G_GeeBoostSelect1.value+1].." and ".._GT_keys_vk_name[_G_GeeBoostSelect2.value+1].." and ".._GT_keys_vk_name[_G_GeeBoostSelect3.value+1].." to boost.", _G_GeeVer, 7, 7)
		end
	end
    while f.on do
		system.yield(0)
		if _G_geeboost_set_keys.value == 0 then
			f.name="Gee-Boost: ".._GT_keys_vk_name[_G_GeeBoostSelect1.value+1]
		elseif _G_geeboost_set_keys.value == 1 then
			f.name="Gee-Boost: ".._GT_keys_vk_name[_G_GeeBoostSelect1.value+1].." ".._GT_keys_vk_name[_G_GeeBoostSelect2.value+1]
		else
			f.name="Gee-Boost: ".._GT_keys_vk_name[_G_GeeBoostSelect1.value+1].." ".._GT_keys_vk_name[_G_GeeBoostSelect2.value+1].." ".._GT_keys_vk_name[_G_GeeBoostSelect3.value+1]
		end
		if _GF_me_in_any_veh() then
			local me_id=player.player_id()
			local my_veh=player.get_player_vehicle(me_id)
			if _GF_feature_keys_down(_G_geeboost_set_keys,_G_GeeBoostSelect1,_G_GeeBoostSelect2,_G_GeeBoostSelect3) then
				_GF_veh_boost(my_veh)
			end
		end
	end
	f.name="Gee-Boost"
end)

_G_GeeBoostSelect1=menu.add_feature("Key1 for Gee-Boost","autoaction_value_str",_G_GeeDriveStuff.id,function(f)
end)_G_GeeBoostSelect1.set_str_data(_G_GeeBoostSelect1,_GT_keys_vk_name)
_G_GeeBoostSelect1.hidden=true
_G_GeeBoostSelect1.value=16

_G_GeeBoostSelect2=menu.add_feature("Key2 for Gee-Boost","autoaction_value_str",_G_GeeDriveStuff.id,function(f)
end)_G_GeeBoostSelect2.set_str_data(_G_GeeBoostSelect2,_GT_keys_vk_name)
_G_GeeBoostSelect2.hidden=true
_G_GeeBoostSelect2.value=4

_G_GeeBoostSelect3=menu.add_feature("Key3 for Gee-Boost","autoaction_value_str",_G_GeeDriveStuff.id,function(f)
end)_G_GeeBoostSelect3.set_str_data(_G_GeeBoostSelect3,_GT_keys_vk_name)
_G_GeeBoostSelect3.hidden=true
_G_GeeBoostSelect3.value=53

_G_geeboost_set_keys=menu.add_feature("Set key(s) for Gee-Boost","action_value_str",_G_GeeDriveStuff.id,function(f)
	_GF_set_keybinds(f.value+1,"Gee-Boost",_G_GeeBoostSelect1,_G_GeeBoostSelect2,_G_GeeBoostSelect3)
end)_G_geeboost_set_keys.set_str_data(_G_geeboost_set_keys,{"One", "Two","Three"})
_G_geeboost_set_keys.value=1
	
_G_GeeStopRvrs=menu.add_feature("Gee-Stop/Reverse", "toggle", _G_GeeDriveStuff.id, function(f)
	if _GF_GS_is_loaded() and f.on then
		if _G_geestop_set_keys.value == 0 then
			menu.notify("Gee-Stop/Reverse Enabled\nWhile in any vehicle hold ".._GT_keys_vk_name[_G_GeeStopSelect1.value+1].." to stop/reverse.", _G_GeeVer, 7, 7)
		elseif _G_geestop_set_keys.value == 1 then
			menu.notify("Gee-Stop/Reverse Enabled\nWhile in any vehicle hold ".._GT_keys_vk_name[_G_GeeStopSelect1.value+1].." and ".._GT_keys_vk_name[_G_GeeStopSelect2.value+1].." to stop/reverse.", _G_GeeVer, 7, 7)
		else
			menu.notify("Gee-Stop/Reverse Enabled\nWhile in any vehicle hold ".._GT_keys_vk_name[_G_GeeStopSelect1.value+1].." and ".._GT_keys_vk_name[_G_GeeStopSelect2.value+1].." and ".._GT_keys_vk_name[_G_GeeStopSelect3.value+1].." to stop/reverse.", _G_GeeVer, 7, 7)
		end
	end
	local ground=true
    while f.on do
		system.yield(0)
		if _G_geestop_set_keys.value == 0 then
			f.name="Gee-Stop/Reverse: ".._GT_keys_vk_name[_G_GeeStopSelect1.value+1]
		elseif _G_geestop_set_keys.value == 1 then
			f.name="Gee-Stop/Reverse: ".._GT_keys_vk_name[_G_GeeStopSelect1.value+1].." ".._GT_keys_vk_name[_G_GeeStopSelect2.value+1]
		else
			f.name="Gee-Stop/Reverse: ".._GT_keys_vk_name[_G_GeeStopSelect1.value+1].." ".._GT_keys_vk_name[_G_GeeStopSelect2.value+1].." ".._GT_keys_vk_name[_G_GeeStopSelect3.value+1]
		end
		if _GF_me_in_any_veh() then
			local me_id=player.player_id()
			local my_veh=player.get_player_vehicle(me_id)
			if _GF_feature_keys_down(_G_geestop_set_keys,_G_GeeStopSelect1,_G_GeeStopSelect2,_G_GeeStopSelect3) then
				_GF_veh_stop(my_veh,ground)
				if _G_self_veh_revers.value == 0 and ground then
					ground=false
				end
			else
				ground=true
			end
		end
	end
	f.name="Gee-Stop/Reverse"
end)

_G_GeeStopSelect1=menu.add_feature("Key1 for Gee-Stop","autoaction_value_str",_G_GeeDriveStuff.id,function(f)
end)_G_GeeStopSelect1.set_str_data(_G_GeeStopSelect1,_GT_keys_vk_name)
_G_GeeStopSelect1.hidden=true
_G_GeeStopSelect1.value=2

_G_GeeStopSelect2=menu.add_feature("Key2 for Gee-Stop","autoaction_value_str",_G_GeeDriveStuff.id,function(f)
end)_G_GeeStopSelect2.set_str_data(_G_GeeStopSelect2,_GT_keys_vk_name)
_G_GeeStopSelect2.hidden=true
_G_GeeStopSelect2.value=2

_G_GeeStopSelect3=menu.add_feature("Key3 for Gee-Stop","autoaction_value_str",_G_GeeDriveStuff.id,function(f)
end)_G_GeeStopSelect3.set_str_data(_G_GeeStopSelect3,_GT_keys_vk_name)
_G_GeeStopSelect3.hidden=true
_G_GeeStopSelect3.value=2

_G_geestop_set_keys=menu.add_feature("Set key(s) for Gee-Stop/Reverse","action_value_str",_G_GeeDriveStuff.id,function(f)
	_GF_set_keybinds(f.value+1,"Gee-Stop/Reverse",_G_GeeStopSelect1,_G_GeeStopSelect2,_G_GeeStopSelect3)
end)_G_geestop_set_keys.set_str_data(_G_geestop_set_keys,{"One", "Two","Three"})

_G_GeeSteer_custom=menu.add_feature("Gee-Steer", "value_str", _G_GeeDriveStuff.id, function(f)
	_GF_GeeSteer_notif()
	while f.on do
		system.yield(50)
		_GF_feat_keys_name("Gee-Steer: ",_G_GeeSteer_custom,_G_geesteer_set_keys,_G_GeeSteerSelect1,_G_GeeSteerSelect2,_G_GeeSteerSelect3)
		if _GF_me_in_any_veh() then
			if _GF_feature_keys_down(_G_geesteer_set_keys,_G_GeeSteerSelect1,_G_GeeSteerSelect2,_G_GeeSteerSelect3) then
				while _GF_feature_keys_down(_G_geesteer_set_keys,_G_GeeSteerSelect1,_G_GeeSteerSelect2,_G_GeeSteerSelect3) and _GF_me_in_any_veh() do
					system.yield(0)
					_GF_gee_steer_do(f.value)
				end
				_GF_ent_tp(player.get_player_vehicle(player.player_id()),entity.get_entity_coords(player.get_player_vehicle(player.player_id())), 0 ,true)
			end
		end
	end
	f.name="Gee-Steer"
end)_G_GeeSteer_custom.set_str_data(_G_GeeSteer_custom,{"Partial", "Full"})

_G_GeeSteerSelect1=menu.add_feature("Key1 for Gee-Steer","autoaction_value_str",_G_GeeDriveStuff.id,function(f)
end)_G_GeeSteerSelect1.set_str_data(_G_GeeSteerSelect1,_GT_keys_vk_name)
_G_GeeSteerSelect1.hidden=true
_G_GeeSteerSelect1.value=0

_G_GeeSteerSelect2=menu.add_feature("Key2 for Gee-Steer","autoaction_value_str",_G_GeeDriveStuff.id,function(f)
end)_G_GeeSteerSelect2.set_str_data(_G_GeeSteerSelect2,_GT_keys_vk_name)
_G_GeeSteerSelect2.hidden=true
_G_GeeSteerSelect2.value=22

_G_GeeSteerSelect3=menu.add_feature("Key3 for Gee-Steer","autoaction_value_str",_G_GeeDriveStuff.id,function(f)
end)_G_GeeSteerSelect3.set_str_data(_G_GeeSteerSelect3,_GT_keys_vk_name)
_G_GeeSteerSelect3.hidden=true
_G_GeeSteerSelect3.value=3

_G_geesteer_set_keys=menu.add_feature("Set key(s) for Gee-Steer","action_value_str",_G_GeeDriveStuff.id,function(f)
	_GF_set_keybinds(f.value+1,"Gee-Steer",_G_GeeSteerSelect1,_G_GeeSteerSelect2,_G_GeeSteerSelect3)
end)_G_geesteer_set_keys.set_str_data(_G_geesteer_set_keys,{"One", "Two","Three"})
_G_geesteer_set_keys.value=2

_G_GeeSteer_LC=menu.add_feature("Gee-Steer with Left-Click", "value_str", _G_GeeDriveStuff.id, function(f)
	_GF_GeeSteer_notif()
	while f.on do
		system.yield(50)
		if _GF_me_in_any_veh() and _GF_key_active(114,0) and _GF_gee_steer_LC_check() then
			while _GF_key_active(223,1) and _GF_me_in_any_veh() do
				system.yield(0)
				_GF_gee_steer_do(f.value)
			end
			_GF_ent_tp(player.get_player_vehicle(player.player_id()),entity.get_entity_coords(player.get_player_vehicle(player.player_id())), 0 ,true)
		end
	end
end)_G_GeeSteer_LC.set_str_data(_G_GeeSteer_LC,{"Partial", "Full"})

function _GF_gee_steer_LC_check()
	if _GF_key_active(223,1) then --left click
		if 	vehicle.get_vehicle_class(player.get_player_vehicle(player.player_id())) == 15 or
			vehicle.get_vehicle_class(player.get_player_vehicle(player.player_id())) == 16 or
			_GF_is_this_veh(player.get_player_vehicle(player.player_id()),"oppressor2") or
			_GF_is_this_veh(player.get_player_vehicle(player.player_id()),"oppressor") then
			return true
		end
		if _GF_is_this_veh(player.get_player_vehicle(player.player_id()),"rhino") then
			if _GF_me_in_seat(player.get_player_vehicle(player.player_id()),-1) then
				return false
			end
			return true
		elseif _GF_is_this_veh(player.get_player_vehicle(player.player_id()),"khanjali") then
			return false
		elseif _GF_is_this_veh(player.get_player_vehicle(player.player_id()),"apc") then
			if _GF_me_in_seat(player.get_player_vehicle(player.player_id()),0) then
				return false
			end
			return true
		else
			return true
		end
	end
end

function _GF_gee_steer_do(_val)
	local my_rot = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
	local rot = cam.get_gameplay_cam_rot()
	my_rot.z = rot.z
	if _GF_ask_cntrl(player.get_player_vehicle(player.player_id())) then
		if _val == 0 then entity.set_entity_rotation(player.get_player_vehicle(player.player_id()),my_rot)
		else entity.set_entity_rotation(player.get_player_vehicle(player.player_id()),cam.get_gameplay_cam_rot())
		end
	end
end


_G_GeeSteer_LC_notif=false
function _GF_GeeSteer_notif()
	if _GF_GS_is_loaded() then
		local buttons=""
		local custom=_GT_keys_vk_name[_G_GeeSteerSelect1.value+1]
		if _G_geesteer_set_keys.value > 0 then
			custom=custom.." ".._GT_keys_vk_name[_G_GeeSteerSelect2.value+1]
		end
		if _G_geesteer_set_keys.value == 2 then
			custom=custom.." ".._GT_keys_vk_name[_G_GeeSteerSelect3.value+1]
		end
		if _G_GeeSteer_LC.on and _G_GeeSteer_custom.on then
			buttons=buttons.."Left-Click or "..custom
		elseif _G_GeeSteer_custom.on then
			buttons=buttons..custom
		else
			buttons=buttons.."Left-Click"
		end
		menu.notify("Gee-Steer Enabled\nWhile in any vehicle hold "..buttons.." to 'steer.'", _G_GeeVer, 7, 7)
		if _G_GeeSteer_LC.on and _G_GeeSteer_LC_notif == false then
			menu.notify("Gee-Steer with Left-Click may require adjusting your GTA settings to work properly. It also functions differently depending on the vehicle.", _G_GeeVer, 7, 7)
			_G_GeeSteer_LC_notif=true
		end
	end
end

_G_GeeDrive_insta=menu.add_feature("Insta-Drive-Stop", "value_str", _G_GeeDriveStuff.id, function(f)
	if _GF_GS_is_loaded()  and f.on then
		menu.notify("Insta-Drive-Stop enabled\nWhile driving your vehicle can instantly start moving, have increased acceleration, or instantly stop.", _G_GeeVer, 7, 7)
	end
	local do_once=true
	local time = utils.time_ms() +250
    while f.on do
		system.yield(0)
		if _GF_me_in_any_veh() then
			local me_id=player.player_id()
			local my_veh=player.get_player_vehicle(me_id)
			local class = vehicle.get_vehicle_class(my_veh)
			if class ~= 15 and class ~= 16 then
				if _GF_me_driving(my_veh) then
					if _GF_key_active(32,1) then
						if do_once then
							if f.value ~= 4 and f.value ~= 5 then
								vehicle.set_vehicle_forward_speed(my_veh,15)
							end
						end
						if f.value == 0 or f.value == 2 or f.value == 4 then
							if time < utils.time_ms() then
								vehicle.set_vehicle_forward_speed(my_veh,(entity.get_entity_speed(my_veh)+1))
								time = utils.time_ms() +250
							end
						else
							time = utils.time_ms() +250
						end
						do_once = false
					elseif not do_once then
						if f.value == 0 or f.value == 1 or f.value == 5 then
							entity.set_entity_velocity(my_veh,v3(0,0,0))
							vehicle.set_vehicle_on_ground_properly(my_veh)
						end
						do_once = true
					end
				end
			end
		end
	end
end)_G_GeeDrive_insta:set_str_data({"Start-Accel-Stop","Start-Stop","Start-Accel", "Only Start","Only Accel","Only Stop"})

_G_GeeDrive_boost_tog=menu.add_feature("Boost toggle", "toggle", _G_GeeDriveStuff.id, function(f)
	if _GF_GS_is_loaded()  and f.on then
		menu.notify("Boost toggle enabled\nPress the brakes to stop boosting.", _G_GeeVer, 7, 7)
	end
	local active=false
	local my_veh=0
    while f.on do
		system.yield(0)
		if _GF_me_driving(player.get_player_vehicle(player.player_id())) then
			my_veh=player.get_player_vehicle(player.player_id()) 
			if vehicle.is_vehicle_rocket_boost_active(my_veh) then
				active=true
				vehicle.set_vehicle_rocket_boost_percentage(my_veh,999999.0)
				if _GF_key_active(33,1) then --oppressor2 wouldnt respond by using boost key to stop
					vehicle.set_vehicle_rocket_boost_percentage(my_veh,100.0)
					vehicle.set_vehicle_rocket_boost_active(my_veh,false)
				end
			else
				active=false
			end 
		elseif active then
			if _GF_valid_veh(my_veh) then
				vehicle.set_vehicle_rocket_boost_percentage(my_veh,100.0)
				vehicle.set_vehicle_rocket_boost_active(my_veh,false)
			end
			active=false
		end	
	end
end)

_G_boost_notif_enforce=menu.add_feature("hidden setting to send the correct values to _GF_BoostNotif", "toggle", _G_GeeDriveStuff.id, function(f)
	while f.on do 
		system.yield(0)
		if _G_Boost_display.on then
			if player.is_player_in_any_vehicle(player.player_id()) then
				if _G_watch_dog.on then
					if controls.get_control_normal(0,114)==0.0 then
						if _G_GeeBoost.on or _G_GeeStopRvrs.on then
						_GF_BoostNotif()
						end
					end
				elseif _G_GeeBoost.on or _G_GeeStopRvrs.on then
						_GF_BoostNotif()
				end
			end
		end
	end
end)
_G_boost_notif_enforce.on=true
_G_boost_notif_enforce.hidden=true

_G_self_veh_accel = menu.add_feature("Boost vehicle forward", "action_slider", _G_GeeDriveStuff.id, function()
	if not _GF_me_in_any_veh() then
		menu.notify("You are not in a vehicle",_G_GeeVer,4,2)
	else
		_GF_veh_boost(player.get_player_vehicle(player.player_id()),10)
	end
end) _GF_set_feat_i_f(_G_self_veh_accel,1,50,1,5)

_G_self_veh_revers = menu.add_feature("Stop/Reverse vehicle", "action_slider", _G_GeeDriveStuff.id, function()
	if not _GF_me_in_any_veh() then
		menu.notify("You are not in a vehicle",_G_GeeVer,4,2)
	else
		_GF_veh_stop(player.get_player_vehicle(player.player_id()))
	end
end)_GF_set_feat_i_f(_G_self_veh_revers,0,50,1,0)

_G_self_veh_up = menu.add_feature("Jump up", "action_slider", _G_GeeDriveStuff.id, function()
	if not _GF_me_in_any_veh() then
		menu.notify("You are not in a vehicle",_G_GeeVer,4,2)
	else
		_GF_apply_force_up(player.get_player_vehicle(player.player_id()))
	end
end)_GF_set_feat_i_f(_G_self_veh_up,1,100,1,25)

_G_self_veh_down = menu.add_feature("Boost down", "action_slider", _G_GeeDriveStuff.id, function()
	if not _GF_me_in_any_veh() then
		menu.notify("You are not in a vehicle",_G_GeeVer,4,2)
	else
		_GF_apply_force_down(player.get_player_vehicle(player.player_id()))
	end
end) _GF_set_feat_i_f(_G_self_veh_down,1,100,1,25)

-----------------------------------------------------------------------------------------GEE-SKID
---------------------------------------------------------------------------------------------Peds
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------


-------------------Thanks to jhowkNx for including ped weapon options in version 2.17 of 
-------------------heist control. Original code included and expanded upon significantly. 


local ped_weap_noti = true
_G_ped_weap_toggle=menu.add_feature("Change ped weapons to:","value_str",_G_Peds.id,function(f)
	local notifname = {}
	local all_peds,time,ped_weap_do_noti,attrib
	notifname = _G_ped_weap_toggle:get_str_data()
	while f.on do	
		system.yield(0)
		if ped_weap_noti then
			menu.notify("Weapon changes are applied every 5 seconds. You will be notified only if it's needed.", _G_GeeVer, 5, 2)
			ped_weap_noti = false
		end
		all_peds = ped.get_all_peds()
		ped_weap_do_noti=true
		for i=1,#all_peds do
			attrib=false
			system.yield(0)
			if _GF_good_ped(all_peds[i],false,false,nil) and _GF_request_ctrl(all_peds[i],50) then
				if f.value == 0 then
					weapon.remove_all_ped_weapons(all_peds[i])
					attrib=true
				--elseif	ped.get_current_ped_weapon(all_peds[i]) ~= _GT_chng_ped_weap[f.value+1] then -- crash :(
				elseif not weapon.has_ped_got_weapon(all_peds[i], _GT_chng_ped_weap[f.value+1]) then
					weapon.remove_all_ped_weapons(all_peds[i])
					if _GF_give_ped_weap(all_peds[i],_GT_chng_ped_weap[f.value+1]) then
						attrib=true
					end
				end
				if attrib then
					_GF_ped_combat_attrib(all_peds[i])
					if ped_weap_do_noti then
						menu.notify("Altering ped weapons to "..notifname[f.value+1].."", _G_GeeVer, 3, 2)
						ped_weap_do_noti=false
					end
				end
			end
		end
		time = utils.time() + 5
		while f.on and time > utils.time() do
			system.yield(0)
		end
	end
end)
_G_ped_weap_toggle:set_str_data({
"Fists",
"Kuckle Dusters",
"Knife",
"Battle Axe",
"Stungun",
"heavy revolver mk2",
"Machine-Pistol",
"Up-N-Atomizer",
"Unholy Hellbringer",
"Combat MG Mk2",
"Sniper Rifle",
"Widowmaker",
"EMP Launcher",
"Firework Launcher",
"RPG",
"Railgun"})
		
_G_peds_shooting_do=menu.add_feature("If peds are shooting:","value_str",_G_Peds.id,function(f)
	local all_peds,ped_veh
	while f.on do
		system.yield(0)
		all_peds=ped.get_all_peds()
		for i=1,#all_peds do
			ped_veh = ped.get_vehicle_ped_is_using(all_peds[i])
			if _GF_good_ped(all_peds[i],false,false,nil) and ped.is_ped_shooting(all_peds[i]) then
				if f.value < 3 and _GF_request_ctrl(all_peds[i],50) then
					if f.value == 0 then
						if _GF_good_ped(all_peds[i],false,false,true) then
							if _GF_request_ctrl(ped_veh,100) then
								vehicle.set_vehicle_engine_on(ped_veh, false, false, true)
								vehicle.set_vehicle_tire_burst(ped_veh, math.random(0,1), false, 1000.0)
								vehicle.set_vehicle_tire_burst(ped_veh, math.random(2,4), false, 1000.0)
								vehicle.set_vehicle_engine_health(ped_veh, -1)
								vehicle.set_vehicle_number_plate_text(ped_veh,"Mean-Ped")
							end
							ai.task_leave_vehicle(all_peds[i], ped_veh, 4160)
							menu.notify("Ped shooting from vehicle.\nEjecting.", _G_GeeVer, 3, 2)
						else
							ped.set_ped_accuracy(all_peds[i], 100)
							menu.notify("Jamming ped's gun.", _G_GeeVer, 3, 2)
						end
					elseif f.value == 1 then
						if _GF_good_ped(all_peds[i],false,false,true) then
							if _GF_request_ctrl(ped_veh,100) then
								vehicle.set_vehicle_engine_on(ped_veh, false, false, true)
								vehicle.set_vehicle_tire_burst(ped_veh, math.random(0,1), false, 1000.0)
								vehicle.set_vehicle_tire_burst(ped_veh, math.random(2,4), false, 1000.0)
								vehicle.set_vehicle_engine_health(ped_veh, 1)
								vehicle.set_vehicle_number_plate_text(ped_veh,"Mean-Ped")
							end
							ai.task_leave_vehicle(all_peds[i], ped_veh, 4160)
							menu.notify("Ped shooting from vehicle.\nEjecting.", _G_GeeVer, 3, 2)
						elseif math.random(0,4) == 0 then
							entity.apply_force_to_entity(all_peds[i], 1, math.random(-50,50), math.random(-50,50), 50, 0, 0, 0,   false, true)
						elseif math.random(0,4) == 1 then 					
							fire.add_explosion(entity.get_entity_coords(all_peds[i])+v3(0,0,-1.5), 24, true, false, 0, all_peds[i])
							fire.add_explosion(entity.get_entity_coords(all_peds[i])+v3(0,0,-1.5), 24, true, false, 0, all_peds[i])
							fire.add_explosion(entity.get_entity_coords(all_peds[i])+v3(0,0,-1.5), 24, true, false, 0, all_peds[i])
						elseif math.random(0,4) == 2 then 
							fire.add_explosion(entity.get_entity_coords(all_peds[i])+v3(0,0,-1.5), 13, true, false, 0, all_peds[i])
						elseif math.random(0,4) == 3 then 
							fire.add_explosion(entity.get_entity_coords(all_peds[i])+v3(0,0,-1.5), 11, true, false, 0, all_peds[i])
						else 
							fire.add_explosion(entity.get_entity_coords(all_peds[i])+v3(0,0,-1.5), 21, true, false, 0, all_peds[i])
						end
						ped.set_ped_to_ragdoll(all_peds[i],1000,1000,0)
						menu.notify("Trolling ped.", _G_GeeVer, 3, 2)
					else
						_GF_set_ped_health(all_peds[i],101,50)
						fire.add_explosion(entity.get_entity_coords(all_peds[i])+v3(0,0,-1.5), 14, true, false, 0, all_peds[i])
						fire.start_entity_fire(all_peds[i])
						menu.notify("Killing ped.", _G_GeeVer, 3, 2)
					end
				elseif _GF_good_ped(all_peds[i],false,false,true) and _GF_request_ctrl(ped_veh,100) then 
					if f.value == 3 then
						entity.set_entity_coords_no_offset(ped_veh, v3(math.random(-81,-69),math.random(-826,-813), math.random(327,357)))
						menu.notify("Ped teleported to Maze Bank.", _G_GeeVer, 3, 2)		
					else
						entity.set_entity_coords_no_offset(ped_veh, entity.get_entity_coords(ped_veh)+v3(0,0,200))
						menu.notify("Ped teleported high in the air.", _G_GeeVer, 3, 2)
					end
				elseif _GF_request_ctrl(all_peds[i],50) then
					if f.value == 3 then
						entity.set_entity_coords_no_offset(all_peds[i], v3(math.random(-81,-69),math.random(-826,-813), math.random(327,357)))
						menu.notify("Ped teleported to Maze Bank.", _G_GeeVer, 3, 2)		
					else
						entity.set_entity_coords_no_offset(all_peds[i], entity.get_entity_coords(all_peds[i])+v3(0,0,200))
						menu.notify("Ped teleported high in the air.", _G_GeeVer, 3, 2)				
					end
				end
			end
		end
	end
end)_G_peds_shooting_do:set_str_data({"Jam their gun","Troll","Kill","TP to Maze Bank Top","TP High in air"})


--------------------------------------------need to figure out how to assign ped groups
-- ped_fight_int=0
-- peds_fight=menu.add_feature("Nearby peds fight themselves","toggle", _G_Peds.id,function(a)
	-- while a.on and ped_fight_int < 100 do
		-- system.yield(25)
		-- local all_peds=ped.get_all_peds()
		-- for i=1,#all_peds do
			-- if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then
				-- if ped.is_ped_in_any_vehicle(all_peds[i]) then
				-- local ped_veh = ped.get_vehicle_ped_is_using(all_peds[i])
				-- vehicle.set_vehicle_forward_speed(ped_veh,0)
				-- ai.task_leave_vehicle(all_peds[i], ped_veh, 4160)
				-- ai.task_combat_ped(all_peds[i], all_peds[i], 0, 16)
				-- else
				-- ai.task_combat_ped(all_peds[i], all_peds[i], 0, 16)
				-- end
			-- end
		-- end
		-- ped_fight_int=ped_fight_int+1
		-- if ped_fight_int == 99 then
		-- ped_fight_int = 0
		-- peds_fight.on=false
		-- end
	-- end
-- end)
_G_all_peds_gods=menu.add_feature("Peds GOD","value_str", _G_Peds.id,function(f)
	while f.on do
		system.yield(5)
		local all_peds=ped.get_all_peds()
		for i=1,#all_peds do
			if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then
				if f.value == 0 then
					if not entity.get_entity_god_mode(all_peds[i]) then
						entity.set_entity_god_mode(all_peds[i], true)
					end
				elseif f.value == 1 then
					if entity.get_entity_god_mode(all_peds[i]) then
						entity.set_entity_god_mode(all_peds[i], false)
					end
				end
			end
		end
	end
end)
_G_all_peds_gods:set_str_data({
"Give",
"Remove"})

_G_all_peds_freeze=menu.add_feature("Peds freeze","value_str", _G_Peds.id,function(f)
	while f.on do
		local all_peds=ped.get_all_peds()
		for i=1,#all_peds do
			if not ped.is_ped_a_player(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then	
				_GF_ask_cntrl(all_peds[i])
				if f.value == 0 then
					entity.set_entity_max_speed(all_peds[i], 0)
				elseif f.value == 1 then
					entity.set_entity_max_speed(all_peds[i], 45000)
				end
			end
		end
		_GF_yield_while_true(f.on,1000)
	end
end)
_G_all_peds_freeze:set_str_data({
"True",
"False"})

_G_all_peds_die=menu.add_feature("Peds health","value_str", _G_Peds.id,function(f)
	while f.on do
		system.yield(25)
		local all_peds=ped.get_all_peds()
		for i=1,#all_peds do
			if not ped.is_ped_a_player(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then
				if f.value == 0 then
					_GF_set_ped_health(all_peds[i],101,25)
				elseif f.value == 1 then
					fire.start_entity_fire(all_peds[i])
					fire.add_explosion(entity.get_entity_coords(all_peds[i]),3, true, false, 0,all_peds[i])
				elseif f.value == 2 then
					_GF_set_ped_health(all_peds[i],0,25)
				elseif f.value == 3 then
					fire.add_explosion(entity.get_entity_coords(all_peds[i]),0, true, false, 0,all_peds[i])
				end
			end
		end
	end
end)
_G_all_peds_die:set_str_data({
"Almost dead",
"Burn to death",
"Dead",
"Explode"})


_G_peds_up=menu.add_feature("Peds go up","value_str",_G_Peds.id,function(a)
	while a.on do
		system.yield(0)
		local all_peds=ped.get_all_peds()
		for i=1,#all_peds do
			if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and ped.is_ped_in_any_vehicle(all_peds[i]) then
				local ped_veh = ped.get_vehicle_ped_is_using(all_peds[i])
				_GF_request_ctrl(ped_veh,50)
				ai.task_leave_vehicle(all_peds[i], ped_veh, 4160)
				system.yield(100)
			end
			if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and not ped.is_ped_in_any_vehicle(all_peds[i]) then
				if a.value == 0 then
					entity.set_entity_velocity(all_peds[i],v3(0,0,1))
				elseif a.value == 1 then
					entity.set_entity_velocity(all_peds[i],v3(0,0,100))
				end
			end
		end
	end
end)
_G_peds_up:set_str_data({
"Slowly",
"Rapture"})

_G_peds_down=menu.add_feature("Peds come down","value_str",_G_Peds.id,function(a)
	while a.on do
		system.yield(0)
		local all_peds=ped.get_all_peds()
		for i=1,#all_peds do
			if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and entity.is_entity_in_air(all_peds[i]) then
				entity.set_entity_gravity(all_peds[i], true)
				if a.value == 0 then
				entity.set_entity_velocity(all_peds[i],v3(0,0,-5))
				elseif a.value == 1 then
				entity.set_entity_velocity(all_peds[i],v3(0,0,-100))
				end
			end
		end
	end
end)			
_G_peds_down:set_str_data({
"Gently",
"YEET"})

menu.add_feature("Peds bail out","toggle",_G_Peds.id,function(a)
	local ped_bail_count = 0
	while a.on do
		ped_bail_count=ped_bail_count+1
		system.yield(0)
		local all_peds=ped.get_all_peds()
		for i=1,#all_peds do
			if ped_bail_count < 100 then
			system.yield(0)
				if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and ped.is_ped_in_any_vehicle(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then
					ai.task_leave_vehicle(all_peds[i], ped.get_vehicle_ped_is_using(all_peds[i]), 4160)
				end
			end
		end
		if ped_bail_count > 300 then
			ped_bail_count = 0
		end
	end
end)

menu.add_feature("Random force","toggle",_G_Peds.id,function(f)
	while f.on do
		local all_peds=ped.get_all_peds()
		for i=1,#all_peds do
			if not ped.is_ped_a_player(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then
				if ped.is_ped_in_any_vehicle(all_peds[i]) then
					if not _GF_any_plyr_in_veh(ped.get_vehicle_ped_is_using(all_peds[i])) then
						_GF_ask_cntrl(ped.get_vehicle_ped_is_using(all_peds[i]))
						_GF_ask_cntrl(all_peds[i])
						ai.task_leave_vehicle(all_peds[i], ped.get_vehicle_ped_is_using(all_peds[i]), 4160)
					end
				elseif entity.is_entity_in_air(all_peds[i]) then
					_GF_ask_cntrl(all_peds[i])
					entity.set_entity_velocity(all_peds[i],v3(math.random(-50,50),math.random(-50,50),math.random(-25,-15)))
				else
					_GF_ask_cntrl(all_peds[i])
					entity.set_entity_velocity(all_peds[i],v3(math.random(-50,50),math.random(-50,50),math.random(10,20)))
				end
			end
		end
		_GF_yield_while_true(f.on,1000)
	end
end)

_G_shoot_peds_toggle=menu.add_feature("Gee-Shoot all peds","toggle", _G_Peds.id,function(f,pid)
_G_shoot_peds_timer.on = true
_G_shoot_peds_cleanup.on = true
	while f.on do
		system.yield(0)
		local me=player.player_id()
		local my_ped=player.get_player_ped(me)
		local all_peds=ped.get_all_peds()
		for i=1,#all_peds do
			if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) then
				if not entity.is_entity_dead(all_peds[i]) then
					if _G_shoot_peds_weap.value == 0 then
						weapon.give_weapon_component_to_ped(my_ped,100416529,1000, true)
						gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(all_peds[i])+v3(0,0,0.5), entity.get_entity_coords(all_peds[i])-v3(0,0,0.5), 1000, 100416529, my_ped, true, false, 1000)
						system.wait(5)
					elseif _G_shoot_peds_weap.value == 1 then
						weapon.give_weapon_component_to_ped(my_ped,1834241177,1000, true)
						gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(all_peds[i])+v3(0,0,0.5), entity.get_entity_coords(all_peds[i])-v3(0,0,0.5), 1, 1834241177, my_ped, true, false, 1000)
						system.wait(5)
					end
				end
			end
		end			
	end
end)

_G_shoot_peds_timer=menu.add_feature("Gee-Shoot all peds timer hidden","toggle", _G_Peds.id,function(f)
	while f.on do
	system.yield(0)
		if _G_shoot_peds_time.value == 0 then
		_GF_delay_(2000)
		_G_shoot_peds_toggle.on = false
		_G_shoot_peds_timer.on = false
		elseif _G_shoot_peds_time.value == 1 then
		_GF_delay_(5000)
		_G_shoot_peds_toggle.on = false
		_G_shoot_peds_timer.on = false
		elseif _G_shoot_peds_time.value == 2 then
		_GF_delay_(10000)
		_G_shoot_peds_toggle.on = false
		_G_shoot_peds_timer.on = false
		elseif _G_shoot_peds_time.value == 3 then
		_GF_delay_(20000)
		_G_shoot_peds_toggle.on = false
		_G_shoot_peds_timer.on = false
		end
	end
end)
_G_shoot_peds_timer.hidden = true

_G_shoot_peds_cleanup=menu.add_feature("Gee-Shoot all peds cleanup","toggle", _G_Peds.id,function(f)
while f.on do
system.yield(0)
	if not _G_shoot_peds_toggle.on then
	system.wait(0)
	_G_shoot_peds_timer.on = false
	_G_shoot_peds_cleanup.on = false
	end
end
end)
_G_shoot_peds_cleanup.hidden = true

_G_shoot_peds_time=menu.add_feature("Shoot all peds for:","autoaction_value_str",_G_Peds.id,function()
end) _G_shoot_peds_time.set_str_data(_G_shoot_peds_time,{"2 seconds", "5 seconds","10 seconds","20 seconds","Until I turn it off"})

_G_shoot_peds_weap=menu.add_feature("Shoot all peds with:","autoaction_value_str",_G_Peds.id,function(a)
end) _G_shoot_peds_weap.set_str_data(_G_shoot_peds_weap,{"Sniper bullets", "Railgun"})


-----------------------------------------------------------------------------------------GEE-SKID
------------------------------------------------------------------------------------------Options
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

menu.add_feature("Set waypoint at this location","toggle", _G_Utilities.id, function(f)
	local me=player.player_id()
	local my_pos = player.get_player_coords(me)
	while f.on do
		if (ui.get_waypoint_coord().x ~= my_pos.x) and (ui.get_waypoint_coord().y ~= my_pos.y) then
			ui.set_new_waypoint(v2(my_pos.x,my_pos.y))
			system.yield(1000)
		end
		system.yield(1000)
	end
end)	

_GT_dist_type_str = {
[0] = "m",
[1] = "km",
[2] = "ft",
[3] = "yard",
[4] = "field",
[5] = "mile",
[6] = "asiandick",
[7] = "bbc"
}

_G_waypoint_esp=menu.add_feature("Waypoint ESP","value_str", _G_Way_Point.id, function(f)
	local me=player.player_id()
	local my_pos = player.get_player_coords(me)
	local pos,mult,flip,dist_type
	local wp_blip =  scriptdraw.register_sprite(_GT_veh_esp_table.file_root.."\\scripts\\GeeSkid\\radar_blips\\waypoint.png")
	local script_size = _GF_script_draw_size(f.on)
	while f.on do
		mult = 1
		flip = true
		if ui.get_waypoint_coord().x < 16000 then
			if _GF_WP_coords_get("anywhere") then
				pos = ui.get_waypoint_coord()
				while pos == ui.get_waypoint_coord() and f.on do
					system.yield(5)
					if _G_waypoint_esp_dist.on then
						dist_type = _GT_dist_type_str[_G_waypoint_esp_dist.value]
					else dist_type ="none"
					end
					if flip then
						mult = mult * .995
						if mult < 1 then flip = false end
					else 
						mult = mult * 1.005
						if mult > 2 then flip = true end
					end
					_GF_waypoint_esp(wp_blip,mult,dist_type,script_size)
				end
			end
		end
		system.yield(1000)
	end
end)_G_waypoint_esp:set_str_data({"Small","Medium","Large","Bounce"})
_G_waypoint_esp.on=true
_G_waypoint_esp.value=3

_G_waypoint_esp_dist=menu.add_feature("Show waypoint ESP distance","value_str", _G_Way_Point.id, function(f)
end)_G_waypoint_esp_dist:set_str_data({"Meters","Kilometers","Feet","Yards","Football fields","Miles","Tiny dick","BBC"})
_G_waypoint_esp_dist.on=true

function _GF_waypoint_esp(_blip,mult,dist_type,script_size)
	local bool,screen_pos,dist,r,g,b,screen_x,screen_y,size
	bool,screen_pos = graphics.project_3d_coord(_G_WP_OBJ_pos)
	if _G_waypoint_esp.value == 3 then
		size = mult
	else
		size = (_G_waypoint_esp.value+1) *.69
	end
	if bool then
		dist = _GF_dist_pos_pos(player.get_player_coords(player.player_id()),_G_WP_OBJ_pos)
		if _GF_mission_active(player.player_id()) and _GT_plyr_info.color[player.player_id()+1] > -1 then
			r = _G_plyrs_overlay_main.team_rgb[_GT_plyr_info.color[player.player_id()+1]+2][1]
			g = _G_plyrs_overlay_main.team_rgb[_GT_plyr_info.color[player.player_id()+1]+2][2]
			b = _G_plyrs_overlay_main.team_rgb[_GT_plyr_info.color[player.player_id()+1]+2][3]
		else
			r,g,b = 164, 76, 242
		end
		screen_x = screen_pos.x/graphics.get_screen_width()/.5-1
		screen_y = (screen_pos.y/graphics.get_screen_height()/.5-1)*-1
		scriptdraw.draw_sprite(_blip,v2(screen_x,screen_y),1*size,0,_GF_RGBAToInt(r,g,b,200))
		if dist_type ~= "none" then
			scriptdraw.draw_text(_GF_ent_dist_str(dist,dist_type),v2(screen_x+(0.01*size),screen_y), v2(screen_x,screen_y), .5*size*script_size, _GF_RGBAToInt(r,g,b,200),1 << 1, 0)
		end
	end
end
			
_G_rand_wp_set=menu.add_feature("Set random waypoint","action_value_str", _G_Utilities.id, function(f)
	local pos
	if f.value == 0 then
		pos = _GF_random_pos("land")
	elseif f.value == 1 then
		pos = _GF_random_pos("water")
	else
		pos = _GF_random_pos("anywhere")
	end
	ui.set_new_waypoint(v2(pos.x,pos.y))
end)_G_rand_wp_set.set_str_data(_G_rand_wp_set,{"Land","Water","Anywhere"})

_G_show_otr_blips=menu.add_feature("Show off-the-radar blips","toggle", _G_Information.id, function(f)
	if not f.on then
		for i=1,#_GT_plyr_info.otr_blip do
			if _GT_plyr_info.otr_blip[i] ~= v3(0,0,0) then -- remove any green otr blips 
				ui.remove_blip(_GT_plyr_info.otr_blip[i])
				_GT_plyr_info.otr_blip[i] = v3(0,0,0)
			end	
		end
	end
end)
_G_show_otr_blips.on=true

_G_show_undead_blips=menu.add_feature("Show un-dead blips","toggle", _G_Information.id, function(f)
	if not f.on then
		for i=1,#_GT_plyr_info.undead_blip do
			if _GT_plyr_info.undead_blip[i] ~= v3(0,0,0) then -- remove any black undead blips 
				ui.remove_blip(_GT_plyr_info.undead_blip[i])
				_GT_plyr_info.undead_blip[i] = v3(0,0,0)
			end	
		end
	end
end)
_G_show_undead_blips.on=true

menu.add_feature("Show all modder info", "action", _G_Information.id, function(f)
	local name,count = ""
	for i=0,32 do
		if _GF_valid_pid(i) and player.is_player_modder(i,-1) then
			name = name .. _GF_plyr_name(i)..": "
			count = 0
			for m=1,#_GT_mod_info.int_str do
				if player.is_player_modder(i,_GT_mod_info.int_str[m][1]) then
					count=count+1
					if count > 1 then
						name=name..","
					end
					name=name.." ".._GT_mod_info.int_str[m][2]
				end
			end
			name=name.."\n"
		end
	end
	if name ~= "" then
		menu.notify(""..name.."",_G_GeeVer,10,2)
	else
		menu.notify("No modders in session.",_G_GeeVer,4,2)
	end
end)

_G_silent_start=menu.add_feature("Silent start","toggle", _G_Options.id)
_G_silent_start.on=true

_GT_veh_info_entry = {}
_GT_veh_info_entry.feat=menu.add_feature("Display vehicle info upon entry", "toggle", _G_Disp_Veh_Info.id, function(f)
	local my_veh
	while f.on do
		system.yield(100)
		if _GF_me_in_any_veh() then
			if my_veh ~= player.get_player_vehicle(player.player_id()) then
				system.yield(125)
				my_veh=player.get_player_vehicle(player.player_id())
				_GF_display_veh_info(
				my_veh,
				_GT_veh_info_entry.speed.on,
				_GT_veh_info_entry.speed.value==0,
				_GT_veh_info_entry.dmnsns.on,
				_GT_veh_info_entry.dmnsns.value==0,
				_GT_veh_info_entry.god.on,
				_GT_veh_info_entry.hlth.on,
				_GT_veh_info_entry.hlth.value==0,
				_GT_veh_info_entry.weap.on,
				_GT_veh_info_entry.hash.on,
				_GT_veh_info_entry.gtaid.on,
				false,
				false,
				_GT_veh_info_entry.occpnts.on
				)
			end
		end
	end
end)

_GT_veh_info_entry.speed=menu.add_feature("Show max speed", "value_str", _G_Disp_Veh_Info.id)
_GT_veh_info_entry.speed:set_str_data({"MPH","KPH"})

_GT_veh_info_entry.dmnsns=menu.add_feature("Show dimensions", "value_str", _G_Disp_Veh_Info.id)
_GT_veh_info_entry.dmnsns:set_str_data({"Meters","Feet"})

_GT_veh_info_entry.god=menu.add_feature("Show god", "toggle", _G_Disp_Veh_Info.id)

_GT_veh_info_entry.weap=menu.add_feature("Show weapons", "toggle", _G_Disp_Veh_Info.id)

_GT_veh_info_entry.hlth=menu.add_feature("Show health", "value_str", _G_Disp_Veh_Info.id)
_GT_veh_info_entry.hlth:set_str_data({"Total health","Engine and body"})

_GT_veh_info_entry.hash=menu.add_feature("Show hash", "toggle", _G_Disp_Veh_Info.id)

_GT_veh_info_entry.gtaid=menu.add_feature("Show vehicle ID#", "toggle", _G_Disp_Veh_Info.id)

_GT_veh_info_entry.occpnts=menu.add_feature("Show occupants", "toggle", _G_Disp_Veh_Info.id)

_GT_veh_info_entry.scnds=menu.add_feature("Notification seconds", "action_value_i", _G_Disp_Veh_Info.id)
_GF_set_feat_i_f(_GT_veh_info_entry.scnds,1,15,1,10)

function _GF_display_veh_info(_veh,_speed,_speed_type,_size,_size_type,_god,_health,_health_cmbnd,_weap,_hash,_gtaid,_dist,_dist_type,_occpnts)

	local msg=""
	if vehicle.get_vehicle_brand(_veh) == nil then
		msg=msg.._GF_model_name(_veh)
	else
		msg=msg..vehicle.get_vehicle_brand(_veh).."   " .. _GF_model_name(_veh)
	end
	msg=msg.."\n"..vehicle.get_vehicle_class_name(_veh).."  "..vehicle.get_vehicle_wheel_count(_veh).."-Wheels  ".._GF_veh_seats(_veh).."-Seats"
	local owner = decorator.decor_get_int(_veh, "Player_Vehicle")
	if owner > 0 then
		for i=1,32 do
			if _GT_plyr_info.net_hash[i]==owner then
				if _GF_valid_pid(i-1) then
					msg=msg.."\nOwner: ".._GF_plyr_name(i-1)
				else
					msg=msg.."\nUnknown personal vehicle"
				end
				break
			end
		end
	end
	if _speed then
		if _speed_type then
			msg=msg.."\nEstimated max-speed: "..tostring(_GF_1_decimal(vehicle.get_vehicle_estimated_max_speed(_veh)*2.65).." mph") --idk why gta reports the values different
		else
			msg=msg.."\nEstimated max-speed: "..tostring(_GF_1_decimal(vehicle.get_vehicle_estimated_max_speed(_veh)*4.2647).." kph") -- but max speed requires different math than entity speed
		end
	end
	if _size then
		local _min,_max = entity.get_entity_model_dimensions(_veh)
		if _min ~= nil and _max ~= nil then
			if _size_type then
				msg=msg.."\nL:".._GF_ent_dist_str(_max.y+math.abs(_min.y),"m").."   W:".._GF_ent_dist_str(_max.x+math.abs(_min.x),"m").."   H:".._GF_ent_dist_str(_max.z+math.abs(_min.z),"m")
			else
				msg=msg.."\nL:".._GF_ent_dist_str(_max.y+math.abs(_min.y),"ft").."   W:".._GF_ent_dist_str(_max.x+math.abs(_min.x),"ft").."   H:".._GF_ent_dist_str(_max.z+math.abs(_min.z),"ft")
			end
		end
	end
	if _god or _weap then
		msg=msg.."\n"
		if _god then
			msg=msg.."God: "..string.upper(tostring(entity.get_entity_god_mode(_veh)))
		end
		if _weap then
			if _god then
				msg=msg.."  "
			end
			msg=msg.."Weapons: "..string.upper(tostring(_GF_does_veh_have_weap(_veh)))
		end
	end
	if _health then
		if _health_cmbnd then
			msg=msg.."\nVehicle health: ".._GF_1_decimal(_GF_get_veh_cmbnd_hlth_prcnt(_veh,true)).."%"
		else
			msg=msg.."\nEngine: ".._GF_1_decimal(_GF_get_veh_engn_hlth(_veh,true)).."%".."  Body: ".._GF_1_decimal(_GF_get_veh_bdy_hlth(_veh,true)).."%"
		end
	end
	if _hash or _gtaid then
		msg=msg.."\n"
		if _hash then
			msg=msg.."Hash: "..entity.get_entity_model_hash(_veh)
		end
		if _gtaid then
			if _hash then
				msg=msg.."  "
			end
			msg=msg.."Veh# ".._veh
		end
	end
	if _dist and not _GF_me_in_that_veh(_veh) then
		if _dist_type then
			msg=msg.."\nDistance: ".._GF_ent_dist_str(_GF_dist_me_ent(_veh),"m")
		else
			msg=msg.."\nDistance: ".._GF_ent_dist_str(_GF_dist_me_ent(_veh),"ft")
		end
	end
	if _occpnts then
		local plyrs,plyr_count="",0
		local ped_count=0
		for s = 1, _GF_veh_seats(_veh) do
			if _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, s-2)) then
				if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, s-2)) then
					plyr_count=plyr_count+1
					plyrs=plyrs.._GF_plyr_name(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, s-2))).." "
				else
					ped_count=ped_count+1
				end
			end
		end	
		if plyr_count > 0 or ped_count > 0 then	
			msg=msg.."\n"
			if ped_count > 0 then
				msg=msg.."Peds: "..ped_count.."  "
			end
			if plyr_count > 0 then
				msg=msg.."Players: "..plyrs
			end
		end
	end
	menu.notify(msg, _G_GeeVer, _GT_veh_info_entry.scnds.value, 2)
end

function _GF_ent_dist_str(_dist,_type)
	local meters = _dist
	local feet = meters * 3.28084
	local yards = meters * 1.09361
	local mile,miles = false, false
	local feet_miles=""
	if _type == "m" then
		return tostring(_GF_1_decimal(meters)).." m"
	elseif _type == "km" then
		return tostring(_GF_2_decimals(meters/1000)).." Km"
	elseif _type == "yard" then
		return tostring(_GF_1_decimal(yards)).." Yards"
	elseif _type == "field" then
		return tostring(_GF_2_decimals(yards/100)).." Fields"
	elseif _type == "asiandick" then
		return tostring(math.floor(feet*2.4)).." Asian dicks"
	elseif _type == "bbc" then
		return tostring(math.floor(feet*1.2)).." BBCs"
	end
	-- meters = math.floor(meters)
	-- feet = math.floor(feet)
	if _type == "ft" then
		return tostring(_GF_1_decimal(feet)).." ft."
	elseif _type == "mile" then
		return tostring(_GF_2_decimals(feet/5280)).." Miles"
	end
	if meters > 1000 then
		meters = tostring(_GF_2_decimals(meters/1000).." KMs")
	else
		meters = tostring(_GF_1_decimal(meters).." Meters")
	end
	if feet >= 660 and feet < 990 then
		feet_miles = "1/8"
		mile = true
	elseif feet >= 990 and feet < 1650 then
		feet_miles = "1/4"
		mile = true
	elseif feet >= 1650 and feet < 2310 then
		feet_miles = "3/8"
		mile = true
	elseif feet >= 2310 and feet < 2970 then
		feet_miles = "Half"
		mile = true
	elseif feet >= 2970 and feet < 3630 then
		feet_miles = "5/8"
		mile = true
	elseif feet >= 3630 and feet < 4290 then
		feet_miles = "3/4"
		mile = true
	elseif feet >= 4290 and feet < 4950 then
		feet_miles = "7/8"
		mile = true
	elseif feet >= 4950 then
		feet_miles=tostring(_GF_2_decimals(feet/5280))
		miles = true
	end
	if mile then
		feet_miles=feet_miles.." Mile"
	elseif miles then
		feet_miles=feet_miles.." Miles"
	end
	local dist = ""
	if feet >=660 then
		dist=dist..meters.." or "..feet_miles.." ("..feet.." ft.)"
	else
		dist=dist..meters.." or ("..feet.." ft.)"
	end
	return dist
end

-----------------------------Driftmod---------------Idk who made this but its one of my favorites -- it was sfinktah and proddy
-----------------------------------------------------------I didnt change a thing on how it works
------------------------------------------------------------------------i just added some options
_GT_drift_main = {}

_GT_drift_main.feat = menu.add_feature("Driftmod v1.1", "toggle", _G_DriftMod.id, function(f)
	if _GF_GS_is_loaded() and f.on then
		menu.notify("Driftmod\nCredit to sfinktah and proddy. I just added some options.\nHold shift/duck to drift", _G_GeeVer, 7, 2)
	end
	local gs_driftMinSpeed,gs_driftMaxAngle = 8.0,50.0
	local ControlVehicleBrake,ControlVehicleSelectNextWeapon = 72,99
	local isDrifting,prevGripState,oldGripState = 0,0,0
	local isDriftFinished,lastDriftAngle = 1,0.0
	local veh,driftKeyPressed,driftAngle,zeroBasedDriftAngle,style
	local function get_driftAngle()
		driftAngle = entity.get_entity_heading(veh) - math.fmod(270.0 + math.deg(math.atan(entity.get_entity_velocity(veh).y, entity.get_entity_velocity(veh).x)), 360.0)
		if driftAngle and lastDriftAngle and driftAngle - lastDriftAngle ~= 180.0 then -- this doesnt seem necessary and works without it
			driftAngle = driftAngle - 360.0
		end
		while (driftAngle < 0.0) do
			driftAngle = driftAngle + 360.0
		end
		while (driftAngle > 360.0) do
			driftAngle = driftAngle - 360.0
		end
	end
	local function get_zeroBasedDriftAngle()
		zeroBasedDriftAngle = 360 - driftAngle
		if zeroBasedDriftAngle > 180 then
			zeroBasedDriftAngle = 0 - (360 - zeroBasedDriftAngle)
		end
	end
	local function driftmod_ontick() 
		local kmh = entity.get_entity_speed(veh) * 3.6
		gs_driftMaxAngle = _GT_drift_main.angle_feat.value
		style = _GT_drift_main.style_feat.value
		if style == 2 then
			vehicle.set_vehicle_reduce_grip(veh, false)
		end
		if not isDrifting and not isDriftFinished then
			isDriftFinished = true
		end
		driftKeyPressed = _GT_drift_main.key_pressed()
		if driftKeyPressed then
			if vehicle.get_vehicle_current_gear(veh) > 2 then -- this doesnt seem to change anything but i guess i'll keep it
				vehicle.set_vehicle_current_gear(veh, 2)
				vehicle.set_vehicle_next_gear(veh, 2)
			end
			if (controls.get_control_normal(2, ControlVehicleBrake) > 0.1) then
				controls.set_control_normal(0, ControlVehicleBrake, 0)
				local neg = -0.3
				if (controls.is_control_pressed(2, ControlVehicleSelectNextWeapon)) then
					neg = 10
				end
				if (vehicle.is_vehicle_on_all_wheels(veh) and not entity.is_entity_in_air(veh)) then
					entity.apply_force_to_entity(veh,1,0,0,(neg * 1 * controls.get_control_normal(2, ControlVehicleBrake)),0,0,0,true,true)
				end
			end 
			get_driftAngle()	
			lastDriftAngle = driftAngle
			get_zeroBasedDriftAngle()
			local done = false
			if ((isDrifting or kmh > gs_driftMinSpeed) and (math.abs(driftAngle - 360.0) < gs_driftMaxAngle) or (driftAngle < gs_driftMaxAngle)) then
				isDrifting,isDriftFinished = 1,1
				if style ~= 2 and driftKeyPressed and driftKeyPressed ~= oldGripState then
					vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
					oldGripState = driftKeyPressed
				end
				done = true
			end
			if not done and kmh < gs_driftMinSpeed then
				if style ~= 2 and driftKeyPressed and driftKeyPressed ~= oldGripState then
					vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
					oldGripState = driftKeyPressed
				end
				done = true
			end
			if not done then
				if style ~= 2 and driftKeyPressed == oldGripState then
					vehicle.set_vehicle_reduce_grip(veh, false)
					oldGripState = 0
				end
				if _GT_drift_main.style_feat.value ~= 1 and  math.abs(zeroBasedDriftAngle) > gs_driftMaxAngle then
					vehicle.set_vehicle_steer_bias(veh, math.rad(zeroBasedDriftAngle * 0.69))
					if zeroBasedDriftAngle > 0 then
						if _GT_drift_main.cntr_notif_feat.on then
							menu.notify("Driftmod v1.1 Counter-steering left", _G_GeeVer, 1, 0x00FF00)
						end
						if _GT_drift_main.blnkrs_feat.on then
							vehicle.set_vehicle_indicator_lights(veh, 0, true)
							vehicle.set_vehicle_indicator_lights(veh, 1, false)
						end
					else
						if _GT_drift_main.blnkrs_feat.on then
							vehicle.set_vehicle_indicator_lights(veh, 1, true)
							vehicle.set_vehicle_indicator_lights(veh, 0, false)
						end
						if _GT_drift_main.cntr_notif_feat.on then
							menu.notify("Driftmod v1.1 Counter-steering right", _G_GeeVer, 1, 0x00FF00)
						end
					end
				end
			else 
				vehicle.set_vehicle_indicator_lights(veh, 0, false)
				vehicle.set_vehicle_indicator_lights(veh, 1, false)
			end
		end
		if not driftKeyPressed and prevGripState then
			isDrifting,isDriftFinished,lastDriftAngle = 0,0,0
			if style ~= 2 and driftKeyPressed ~= oldGripState then
				vehicle.set_vehicle_reduce_grip(veh, driftKeyPressed)
				oldGripState = driftKeyPressed
			end
		end
		prevGripState = driftKeyPressed
	end
	while f.on do
		system.yield(100)
		if _GT_drift_main.key_pressed() and _GT_drift_main.good_veh() then
			while f.on and _GT_drift_main.key_pressed() and _GF_me_driving(player.get_player_vehicle(player.player_id())) and _GF_have_cntrl(player.get_player_vehicle(player.player_id())) do
				system.yield(0)
				veh = player.get_player_vehicle(player.player_id())
				driftmod_ontick()
			end
		elseif _GF_valid_veh(veh) then
			vehicle.set_vehicle_indicator_lights(veh, 0, false)
			vehicle.set_vehicle_indicator_lights(veh, 1, false)
			vehicle.set_vehicle_reduce_grip(veh, false)
			veh = nil
		end
	end
end)

-----------------------------------------------------------------------------------------GEE-SKID
------------------------------------------------------------------------------------------Options
------------------------------------------------------------------------------------------Drift_O
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
_GT_drift_main.test_bool=false

function _GT_drift_main.good_veh()
	
	if _GF_me_driving(player.get_player_vehicle(player.player_id())) and not entity.is_entity_in_air(player.get_player_vehicle(player.player_id())) then
		local class = vehicle.get_vehicle_class(player.get_player_vehicle(player.player_id()))
		if class ~= 8 and class ~= 14 and class ~= 15 and class ~= 16 and class ~= 21 then --bikes,motorcycles,planes,helos,trains
			return true
		end
	end
	return false
end

function _GT_drift_main.key_pressed()
	local ControlVehicleDuck,L_shift,ControlVehicleBrake = 73,209,72
	if _GT_drift_main.rvrs_feat.on and (controls.is_control_pressed(2, ControlVehicleBrake) or controls.is_disabled_control_pressed(2, ControlVehicleBrake)) then
		return false
	elseif _GT_drift_main.key_feat.value == 0 then
		return (controls.is_control_pressed(2, ControlVehicleDuck) or controls.is_disabled_control_pressed(2, ControlVehicleDuck) or controls.is_control_pressed(0, L_shift) or controls.is_disabled_control_pressed(0, L_shift))
	elseif _GT_drift_main.key_feat.value == 1 then
		return (controls.is_control_pressed(0, L_shift) or controls.is_disabled_control_pressed(0, L_shift))
	end
	return (controls.is_control_pressed(2, ControlVehicleDuck) or controls.is_disabled_control_pressed(2, ControlVehicleDuck))
end

_GT_drift_main.rec_feat = menu.add_feature("Apply recommended settings?", "action", _G_Drift_O.id, function()
_GT_drift_main.rec_do()
end)

_GT_drift_main.style_feat = menu.add_feature("Drift style", "autoaction_value_str", _G_Drift_O.id, function(f)
	if f.value == 1 then
		_GT_drift_main.cntr_notif_test_feat.hidden=true
		_GT_drift_main.cntr_notif_feat.hidden=true
		_GT_drift_main.blnkrs_feat.hidden=true
	else
		_GT_drift_main.cntr_notif_test_feat.hidden=false
		_GT_drift_main.cntr_notif_feat.hidden=false
		_GT_drift_main.blnkrs_feat.hidden=false
	end
end)_GT_drift_main.style_feat:set_str_data({"Both", "Reduced grip","Counter-steer"})

_GT_drift_main.angle_feat = menu.add_feature("Drift angle", "action_value_i", _G_Drift_O.id, function()
end) _GT_drift_main.angle_feat.max,_GT_drift_main.angle_feat.min,_GT_drift_main.angle_feat.mod=70,40,1


_GT_drift_main.key_feat = menu.add_feature("Drift key", "action_value_str", _G_Drift_O.id)
_GT_drift_main.key_feat:set_str_data({"Both", "Left shift","Duck"})

_GT_drift_main.rvrs_feat = menu.add_feature("Ignore reverse/brakes", "toggle", _G_Drift_O.id)

_GT_drift_main.blnkrs_feat = menu.add_feature("Counter-steer indicator lights", "toggle", _G_Drift_O.id)

_GT_drift_main.cntr_notif_feat = menu.add_feature("Counter-steer notifications", "toggle", _G_Drift_O.id)


_GT_drift_main.cntr_notif_test_feat = menu.add_feature("Display counter-steer test notification?", "action", _G_Drift_O.id, function()
	menu.notify("DriftMod counter-steer test notification", _G_GeeVer, 1, 0x00FF00)
end)

_GT_drift_main.overlays_feat = menu.add_feature("Ready/Active overlay", "value_str", _G_Drift_O.id, function(f)
	_GT_drift_main.sett_hide(false)
	local alpha,switch,less,more = _GT_drift_main.ovrly_ca.value,false
	local function rand_rgb(_val,_ofst,_bool)
		local _less,_more
		if _val-_ofst < 0 then
			_less = 0
			_more = 0+(2*_ofst)
		elseif _val+_ofst > 255 then
			_less = 255-(2*_ofst)
			_more = 255
		else
			_less = _val-_ofst
			_more = _val +_ofst
		end
		if _bool then
			return math.random(_less,_more)
		end
		return _less,_more
	end
	while f.on do
		system.yield(100)
		while f.on and _GT_drift_main.feat.on and _GT_drift_main.good_veh() and not _GT_drift_main.test_bool do
			system.yield(0)
			if _GT_drift_main.key_pressed() and f.value ~= 1 then
				_GF_overlay("DRIFT ACTIVE",rand_rgb(_GT_drift_main.ovrly_cr.value,50,true),rand_rgb(_GT_drift_main.ovrly_cg.value,50,true),rand_rgb(_GT_drift_main.ovrly_cb.value,50,true),_GT_drift_main.ovrly_ca.value,(_GT_drift_main.ovrly_s.value/300*0.99),_GT_drift_main.ovrly_f.value,_GT_drift_main.ovrly_x.value/math.random(297,303),_GT_drift_main.ovrly_y.value/300)	
			elseif f.value ~= 2 then
				less,more = rand_rgb(_GT_drift_main.ovrly_ca.value,25,false)
				if switch then
					alpha = alpha -.25
					if alpha < less then
						switch = false
					end
				else
					alpha = alpha +.25
					if alpha > more then
						switch = true
					end
				end
				_GF_overlay("DriftMod Ready",_GT_drift_main.ovrly_cr.value,_GT_drift_main.ovrly_cg.value,_GT_drift_main.ovrly_cb.value,math.floor(alpha),_GT_drift_main.ovrly_s.value/300,_GT_drift_main.ovrly_f.value,_GT_drift_main.ovrly_x.value/300,_GT_drift_main.ovrly_y.value/300)
			end
		end
	end
	_GT_drift_main.sett_hide(true)
end)_GT_drift_main.overlays_feat:set_str_data({"Both", "Driftmod ready","Driftmod active"})

_GT_drift_main.ovrly_test_feat = menu.add_feature("Display test overlay?", "action", _G_Drift_O.id, function(f)
	f.hidden=true
	_GT_drift_main.test_bool=true
	menu.notify("DriftMod test overlay will display for 15 seconds", _G_GeeVer, 3, 0x00FF00)
	local time = utils.time_ms() + 15000
	while time > utils.time_ms() do
		_GF_overlay("DRIFT DRIFT DRIFT",_GT_drift_main.ovrly_cr.value,_GT_drift_main.ovrly_cg.value,_GT_drift_main.ovrly_cb.value,_GT_drift_main.ovrly_ca.value,_GT_drift_main.ovrly_s.value/300,_GT_drift_main.ovrly_f.value,_GT_drift_main.ovrly_x.value/300,_GT_drift_main.ovrly_y.value/300)
		system.yield(0)
	end
	menu.notify("DriftMod test overlay is finished", _G_GeeVer, 3, 0x00FF00)
	_GT_drift_main.test_bool=false
	f.hidden=false
end)

_GT_drift_main.ovrly_x = menu.add_feature("X Pos", "action_slider", _G_Drift_O.id, function()
end) _GT_drift_main.ovrly_x.max,_GT_drift_main.ovrly_x.min,_GT_drift_main.ovrly_x.mod,_GT_drift_main.ovrly_x.value=300,0,1,1

_GT_drift_main.ovrly_y = menu.add_feature("Y Pos", "action_slider", _G_Drift_O.id, function()
end) _GT_drift_main.ovrly_y.max,_GT_drift_main.ovrly_y.min,_GT_drift_main.ovrly_y.mod=300,0,1

_GT_drift_main.ovrly_s = menu.add_feature("Scale", "action_slider", _G_Drift_O.id, function()
end) _GT_drift_main.ovrly_s.max,_GT_drift_main.ovrly_s.min,_GT_drift_main.ovrly_s.mod=300,75,1

_GT_drift_main.ovrly_f = menu.add_feature("Font", "action_slider", _G_Drift_O.id, function()
end) _GT_drift_main.ovrly_f.max,_GT_drift_main.ovrly_f.min,_GT_drift_main.ovrly_f.mod=9,0,1

_GT_drift_main.ovrly_cr = menu.add_feature("Red", "action_slider", _G_Drift_O.id, function()
end) _GT_drift_main.ovrly_cr.max,_GT_drift_main.ovrly_cr.min,_GT_drift_main.ovrly_cr.mod=255,0,15

_GT_drift_main.ovrly_cg = menu.add_feature("Green", "action_slider", _G_Drift_O.id, function()
end) _GT_drift_main.ovrly_cg.max,_GT_drift_main.ovrly_cg.min,_GT_drift_main.ovrly_cg.mod=255,0,15

_GT_drift_main.ovrly_cb = menu.add_feature("Blue", "action_slider", _G_Drift_O.id, function()
end) _GT_drift_main.ovrly_cb.max,_GT_drift_main.ovrly_cb.min,_GT_drift_main.ovrly_cb.mod=255,0,15

_GT_drift_main.ovrly_ca = menu.add_feature("Alpha", "action_slider", _G_Drift_O.id, function()
end) _GT_drift_main.ovrly_ca.max,_GT_drift_main.ovrly_ca.min,_GT_drift_main.ovrly_ca.mod=255,30,15

function _GT_drift_main.rec_do()
	_GT_drift_main.overlays_feat.on=true
	_GT_drift_main.overlays_feat.value=0
	_GT_drift_main.cntr_notif_feat.on=true
	_GT_drift_main.blnkrs_feat.on=true
	_GT_drift_main.rvrs_feat.on=true
	_GT_drift_main.style_feat.value=0
	_GT_drift_main.angle_feat.value=50
	_GT_drift_main.ovrly_x.value=26.0
	_GT_drift_main.ovrly_y.value=293.0
	_GT_drift_main.ovrly_s.value=120.0
	_GT_drift_main.ovrly_f.value=0.0
	_GT_drift_main.ovrly_cr.value=0.0
	_GT_drift_main.ovrly_cg.value=255.0
	_GT_drift_main.ovrly_cb.value=0.0
	_GT_drift_main.ovrly_ca.value=105.0
end
_GT_drift_main.rec_do()

function _GT_drift_main.sett_hide(_bool)
	_GT_drift_main.ovrly_test_feat.hidden=_bool
	_GT_drift_main.ovrly_x.hidden=_bool
	_GT_drift_main.ovrly_y.hidden=_bool
	_GT_drift_main.ovrly_s.hidden=_bool
	_GT_drift_main.ovrly_f.hidden=_bool
	_GT_drift_main.ovrly_cr.hidden=_bool
	_GT_drift_main.ovrly_cg.hidden=_bool
	_GT_drift_main.ovrly_cb.hidden=_bool
	_GT_drift_main.ovrly_ca.hidden=_bool
end
-----------------------------------------------------------------------------------------GEE-SKID
------------------------------------------------------------------------------------------Options
------------------------------------------------------------------------------Watch_Boost_Options
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

_G_ped_veh_accel = menu.add_feature("Vehicle Accel", "action_slider", _G_Watch_Boost_Options.id, function()
end) _G_ped_veh_accel.max,_G_ped_veh_accel.min,_G_ped_veh_accel.mod=200,10,10

_G_ped_veh_revers = menu.add_feature("Vehicle Reverse", "action_slider", _G_Watch_Boost_Options.id, function()
end) _G_ped_veh_revers.max,_G_ped_veh_revers.min,_G_ped_veh_revers.mod=200,0,10

_G_ped_veh_up = menu.add_feature("Vehicle/Ped Go Up", "action_slider", _G_Watch_Boost_Options.id, function()
end) _G_ped_veh_up.max,_G_ped_veh_up.min,_G_ped_veh_up.mod=200,0,10

_G_ped_veh_down = menu.add_feature("Vehicle/Ped Go Down", "action_slider", _G_Watch_Boost_Options.id, function()
end) _G_ped_veh_down.max,_G_ped_veh_down.min,_G_ped_veh_down.mod=200,0,10

_G_gee_eye_bypass = menu.add_feature("Prevent firing Gee-Eye with Gee-Watch", "toggle", _G_Watch_Boost_Options.id, function(f)
	if f.on and _GF_GS_is_loaded() then
		if not _GF_GW_GE_no_interfere(_G_GeeWatchExplode_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchExplode_key.value+1]..") Explode will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchDamDes_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchDamDes_key.value+1]..") Damage/Destroy/Delete will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchKick_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchKick_key.value+1]..") Kick will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchBurn_key)  then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchBurn_key.value+1]..") Burn will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchBoard_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchBoard_key.value+1]..") Board will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchAccel_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchAccel_key.value+1]..") Accel will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchRvrs_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchRvrs_key.value+1]..") Stop/Reverse will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchRepair_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchRepair_key.value+1]..") Repair will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchUpgrade_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchUpgrade_key.value+1]..") Upgrade will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchElev_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchElev_key.value+1]..") Elevate/Up will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		elseif not _GF_GW_GE_no_interfere(_G_GeeWatchDeEleRag_key) then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchDeEleRag_key.value+1]..") Down/Ragdoll will be disabled while Gee-Eye is enabled.", _G_GeeVer, 4, 2)
		else menu.notify("Gee-Eye and Gee-Watch currently don't have conflicting keys.", _G_GeeVer, 4, 2)
		end
	end	
end) 

_G_gee_watch_destroy = menu.add_feature("Upgrade Damage to Destroy?", "toggle", _G_Watch_Boost_Options.id, function(f)
	if _GF_GS_is_loaded() then
		if f.on then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchDamDes_key.value+1]..") set to Destroy.", _G_GeeVer, 4, 2)
		else menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchDamDes_key.value+1]..") set to Damage.", _G_GeeVer, 4, 2)
		end
	end	
end)

_G_gee_watch_passenger = menu.add_feature("Boarding player vehicle", "action_value_str", _G_Watch_Boost_Options.id, function(f)
	if _GF_GS_is_loaded() then
		if f.on then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchBoard_key.value+1]..") boarding will only hijack if there is no free seat.", _G_GeeVer, 4, 2)
		else menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchBoard_key.value+1]..") boarding will always take driver seat.", _G_GeeVer, 4, 2)
		end
	end
end)_G_gee_watch_passenger:set_str_data({"Only empty seat","Prefer empty seat","Always hijack"})
_G_gee_watch_passenger.value=1

_G_gee_watch_passenger_npc = menu.add_feature("Boarding NPC vehicle", "action_value_str", _G_Watch_Boost_Options.id, function(f)
	if _GF_GS_is_loaded() then
		if f.on then menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchBoard_key.value+1]..") boarding will only hijack if there is no free seat.", _G_GeeVer, 4, 2)
		else menu.notify("Gee-Watch (".._GT_keys_vk_name[_G_GeeWatchBoard_key.value+1]..") boarding will always take driver seat.", _G_GeeVer, 4, 2)
		end
	end
end)_G_gee_watch_passenger_npc:set_str_data({"Only empty seat","Prefer empty seat","Always hijack"})
_G_gee_watch_passenger_npc.value=2

_G_gee_watch_player_info = menu.add_feature("Display player info notification?", "toggle", _G_Watch_Boost_Options.id, function(f)
	if f.on and _GF_GS_is_loaded() then
		menu.notify("Gee-Watch will display player info when aiming at them.", _G_GeeVer, 4, 2)
	end
end) 

_G_Boost_display = menu.add_feature("Gee-Boost display overlay for self", "toggle", _G_Watch_Boost_Options.id, function(f)
	if f.on then
		_G_W_B_settings_hide(false)
		if _GF_GS_is_loaded() then
			menu.notify("Gee-Boost will display overlay when in a vehicle.", _G_GeeVer, 4, 2)
		end
	elseif not _G_Watch_display.on then
		_G_W_B_settings_hide(true)
	end
end)

-----------------------------------------------------------------------------------------GEE-SKID
------------------------------------------------------------------------------------------Options
------------------------------------------------------------------------------Watch_Boost_Options
------------------------------------------------------------------------------Watch_Boost_Display
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

_G_Watch_display = menu.add_feature("Gee-Watch display overlay", "toggle", _G_Watch_Boost_Display.id,function(f)
	if f.on then
		_G_W_B_settings_hide(false)
		if _GF_GS_is_loaded() then
			menu.notify("Gee-Watch overlay will display when aiming at an entity.", _G_GeeVer, 4, 0x00FF00)
		end
	elseif not _G_Boost_display.on then
		_G_W_B_settings_hide(true)
	end
end)

_G_test_w_display_action = menu.add_feature("Display test overlay?", "action", _G_Watch_Boost_Display.id, function()
	_G_test_w_display_action.hidden=true
	menu.notify("Gee-Watch test overlay will display for 10 seconds", _G_GeeVer, 3, 0x00FF00)
	local time = utils.time_ms() +10000
	while time > utils.time_ms() do
		system.yield(0)
		_GF_TestNotif()
		_G_show_god()
	end
	menu.notify("Gee-Watch test overlay is finished", _G_GeeVer, 3, 0x00FF00)
	_G_test_w_display_action.hidden=false
end)


_G_W_B__display_rec = menu.add_feature("Apply recommended settings?", "action", _G_Watch_Boost_Display.id, function(f)
_GF_G_W_recc_do(true)
end)

_G_W_B_x = menu.add_feature("X Pos", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_x.max,_G_W_B_x.min,_G_W_B_x.mod=300,0,1

_G_W_B_y = menu.add_feature("Y Pos", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_y.max,_G_W_B_y.min,_G_W_B_y.mod=300,0,1

_G_W_B_s = menu.add_feature("Scale", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_s.max,_G_W_B_s.min,_G_W_B_s.mod=300,75,1

_G_W_B_f = menu.add_feature("Font", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_f.max,_G_W_B_f.min,_G_W_B_f.mod=9,0,1

_G_W_B_cr = menu.add_feature("Red", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_cr.max,_G_W_B_cr.min,_G_W_B_cr.mod=255,0,15

_G_W_B_cg = menu.add_feature("Green", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_cg.max,_G_W_B_cg.min,_G_W_B_cg.mod=255,0,15

_G_W_B_cb = menu.add_feature("Blue", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_cb.max,_G_W_B_cb.min,_G_W_B_cb.mod=255,0,15

_G_W_B_a = menu.add_feature("Alpha", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_a.max,_G_W_B_a.min,_G_W_B_a.mod=255,30,15

_G_W_B_god_x = menu.add_feature("God detected X pos", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_god_x.max,_G_W_B_god_x.min,_G_W_B_god_x.mod=300,0,1

_G_W_B_god_y = menu.add_feature("God detected Y pos", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_god_y.max,_G_W_B_god_y.min,_G_W_B_god_y.mod=300,0,1

_G_W_B_god_s = menu.add_feature("God detected scale", "action_slider", _G_Watch_Boost_Display.id, function()
end) _G_W_B_god_s.max,_G_W_B_god_s.min,_G_W_B_god_s.mod=300,75,1

function _G_W_B_settings_hide(_bool)
	_G_W_B_x.hidden=_bool
	_G_W_B_y.hidden=_bool
	_G_W_B_s.hidden=_bool
	_G_W_B_f.hidden=_bool
	_G_W_B_cr.hidden=_bool
	_G_W_B_cg.hidden=_bool
	_G_W_B_cb.hidden=_bool
	_G_W_B_a.hidden=_bool
	_G_W_B_god_x.hidden=_bool
	_G_W_B_god_y.hidden=_bool
	_G_test_w_display_action.hidden=_bool
	_G_W_B_god_s.hidden=_bool
end

function _GF_G_W_recc_do(_all)
	_G_ped_veh_accel.value=120.0
	_G_ped_veh_revers.value=0.0
	_G_ped_veh_up.value=200.0
	_G_ped_veh_down.value=90.0
	_G_W_B_x.value=150.0
	_G_W_B_y.value=289.0
	_G_W_B_s.value=170.0
	_G_W_B_f.value=6.0
	_G_W_B_cr.value=0.0
	_G_W_B_cg.value=255.0
	_G_W_B_cb.value=0.0
	_G_W_B_a.value=105.0
	_G_W_B_god_x.value=150.0
	_G_W_B_god_y.value=142.0
	_G_W_B_god_s.value=213.0
	if _all then
		_G_Watch_display.on=true
		_G_Boost_display.on=true
		_G_gee_eye_bypass.on=true
	end
end
_GF_G_W_recc_do(false)

_G_mods_detex_otr_tog=menu.add_feature("Off-the-radar > 3 Min","toggle",_G_Modder_Detex.id)
_G_mods_detex_otr_tog.on=true

_G_mods_detex_kd_tog=menu.add_feature("K/D above:","value_f", _G_Modder_Detex.id, function()
end) _G_mods_detex_kd_tog.max,_G_mods_detex_kd_tog.min,_G_mods_detex_kd_tog.mod=10.0,3.0,0.1
_G_mods_detex_kd_tog.value=5.0
_G_mods_detex_kd_tog.on=true

_G_mods_detex_kd_neg_tog=menu.add_feature("Negative K/D","toggle",_G_Modder_Detex.id)
_G_mods_detex_kd_neg_tog.on=true

_G_mods_detex_money_tog=menu.add_feature("Money above:","value_str", _G_Modder_Detex.id, function()
end) _G_mods_detex_money_tog:set_str_data({"500 Million","750 million","1 Billion","1.25 Billion","1.5 Billion","1.75 Billion","2 Billion"})
_G_mods_detex_money_tog.value=2
_G_mods_detex_money_tog.on=true

_G_mods_detex_rank_tog=menu.add_feature("Rank above:","value_i", _G_Modder_Detex.id, function()
end) _G_mods_detex_rank_tog.max,_G_mods_detex_rank_tog.min,_G_mods_detex_rank_tog.mod=7000,500,50
_G_mods_detex_rank_tog.value=1000
_G_mods_detex_rank_tog.on=true

_G_mods_detex_god_shoot_tog=menu.add_feature("God-mode","toggle",_G_Modder_Detex.id, function(f)
	while not _G_GS_has_loaded do
		system.yield(500)
	end
	while f.on do
		system.yield(25)
		for i=0,31 do
			if _GF_valid_pid(i) and player.can_player_be_modder(i) and not player.is_player_modder(i,_GT_mod_info.int_str[32][1]) then
				if _GF_plyr_god_check(i) then
					player.set_player_as_modder(i, _GT_mod_info.int_str[32][1])
					menu.notify("".._GF_plyr_name(i).."\nGod-mode.\n --Marking as Modder--",_G_GeeVer,7,2)
				end
				system.yield(25)
			end
		end
	end
end)
_G_mods_detex_god_shoot_tog.on=true

function _GF_plyr_god_check(_pid)
	if _GT_plyr_info.plyr_god[_pid+1] and not _GT_plyr_info.loading[_pid+1] and not _GT_plyr_info.interior[_pid+1] and (entity.get_entity_speed(player.get_player_ped(_pid)) > 3 or _GT_plyr_info.plyr_moving[_pid+1]) then
		if _GF_plyr_god_check_params(_pid) then
			return true
		end
	end
	return false
end

function _GF_plyr_god_check_params(_pid)
	local function veh_dist_check(_pid)
		if not _GT_plyr_info.in_veh[_pid+1] and _G_plyrs_overlay_main.dist_table[_pid+1][1] > 250 then
			return false
		elseif _GT_plyr_info.in_veh[_pid+1] and (_GF_is_this_veh(_GT_plyr_info.veh[_pid+1],"minitank") or _GF_is_this_veh(_GT_plyr_info.veh[_pid+1],"rcbandito")) then
			return false
		end
		return true
	end
	local function god(_pid)
		if _GT_plyr_info.plyr_god[_pid+1] and not _GT_plyr_info.loading[_pid+1] and not _GT_plyr_info.interior[_pid+1] then
			return true
		end
		return false
	end
	local function moving(_pid)
		if (entity.get_entity_speed(player.get_player_ped(_pid)) > 3 or _GT_plyr_info.plyr_moving[_pid+1]) then
			return true
		end
		return false
	end
	system.yield(1000)
	for i=1,50 do
		system.yield(100)
		if not _GF_valid_pid(_pid) or not god(_pid) or not veh_dist_check(_pid) or not moving(_pid) then
			return false
		elseif ped.is_ped_shooting(player.get_player_ped(_pid)) then
			return true
		end
	end
	return (_GF_valid_pid(_pid) and god(_pid))
end

_G_mods_detex_undead_tog=menu.add_feature("Un-Dead","toggle",_G_Modder_Detex.id)
_G_mods_detex_undead_tog.on=true

_G_VehProtexFeat=menu.add_feature("Vehicle grief", "value_str", _G_VehGriefProtex.id, function(f,pid)
	local continue,success = false,false
	local _pid,name,model
	local _GT_veh_grief_plyr_list = {}
	for i=1, 32 do
		_GT_veh_grief_plyr_list[i] = {i-1, utils.time_ms(),0}
	end
	while f.on do
		system.yield(3000)
		for i=1,#_GT_veh_grief_plyr_list do
			_pid = _GT_veh_grief_plyr_list[i][1]
			if _GF_valid_pid(_pid) and player.player_id() ~= _pid and player.is_player_in_any_vehicle(_pid) and not _GF_is_dead(player.get_player_vehicle(_pid)) then
				if _GF_not_frnd_org(_pid,f.value) then
					if not _GF_veh_grief_check_do(entity.get_entity_model_hash(player.get_player_vehicle(_pid))) then
						_GT_veh_grief_plyr_list[i][2] = utils.time_ms()
						_GT_veh_grief_plyr_list[i][3] = 0
					elseif utils.time_ms() > _GT_veh_grief_plyr_list[i][2] and  _GT_veh_grief_plyr_list[i][3] < 4 then
						success = false
						name = _GF_veh_ped_name(player.get_player_vehicle(_pid),"first_plyr")
						model = _GF_model_name(player.get_player_vehicle(_pid))
						for g=1,#_GT_veh_grief_hash_list do
							if _GT_veh_grief_hash_list[g][2] == true and entity.get_entity_model_hash(player.get_player_vehicle(_pid)) == _GT_veh_grief_hash_list[g][1] then
								if f.value == 0 then
									if _GF_plyr_veh_kick(_pid, true) then
										success=true
									end
								elseif f.value == 1 then
									if _GF_request_ctrl(player.get_player_vehicle(_pid),2000) then
										_GF_veh_destroyed_do(player.get_player_vehicle(_pid), _pid)
										menu.notify(""..name.. " - " ..model.. " \nVehicle destroyed :)" , _G_GeeVer, 4, 2)
										success=true
									end
								elseif f.value == 2 then
									if _GF_request_ctrl(player.get_player_vehicle(_pid),2000) then
										entity.set_entity_max_speed(player.get_player_vehicle(_pid), 0)
										menu.notify(""..name.. " - " ..model.. " \nVehicle frozen :)" , _G_GeeVer, 4, 2)
										success=true
									end
								elseif f.value == 3 then
									if _GF_dist_me_ent(player.get_player_vehicle(_pid)) > 500 then
										success=true
									elseif _GF_ent_tp(player.get_player_vehicle(_pid),v3(math.random(-2000,2000),math.random(-2000,5000),500), 0 ,true) then
										menu.notify(""..name.. " - " ..model.. " \nVehicle teleported away :)" , _G_GeeVer, 4, 2)
										success=true
									end
								elseif f.value == 4 then
									if _GF_veh_is_fucked(player.get_player_vehicle(_pid), 2000,true,false,nil) then
										success=true
									end
								end
								break
							end
						end
						if success then
							_GT_veh_grief_plyr_list[i][2] = utils.time_ms()+20000
							_GT_veh_grief_plyr_list[i][3] = 0
						else
							_GT_veh_grief_plyr_list[i][2] = utils.time_ms()+30000
							_GT_veh_grief_plyr_list[i][3] = _GT_veh_grief_plyr_list[i][3]+1
						end
					end
				end
			else
				_GT_veh_grief_plyr_list[i][2] = utils.time_ms()
				_GT_veh_grief_plyr_list[i][3] = 0
			end
		end
	end
end)_G_VehProtexFeat.set_str_data(_G_VehProtexFeat,{"Kick from veh","Destroy","Freeze","TP away","Fuck their veh"})

function _GF_veh_grief_check_do(_hash)
	for i=1,#_GT_veh_grief_hash_list do
		if _GT_veh_grief_hash_list[i][1] == _hash and _GT_veh_grief_hash_list[i][2] == true then
			return true
		end
	end	
	return false
end

_G_VehProtexPlyrs=menu.add_feature("Players for grief", "action_value_str", _G_VehGriefProtex.id, function(f,pid)
end)_G_VehProtexPlyrs.set_str_data(_G_VehProtexPlyrs,{"Not Friends/Org/MC","Not Friends","Anyone"})

menu.add_feature("Toggle all", "toggle", _G_VehGriefProtex.id,function(f)
	if f.on then _GF_veh_grief_toggle(true)
	else _GF_veh_grief_toggle(false)
	end
end)

function _GF_veh_grief_toggle(_bool)
	for i=1,#_GT_veh_grief_feat_list do
		_GT_veh_grief_feat_list[i].on=_bool
	end
	_G_VehProtexRamp.on=_bool
	_G_VehProtexAvng.on=_bool
end

_G_VehProtexAvng=menu.add_feature("Avenger", "toggle", _G_VehGriefProtex.id,function(f)
	if f.on then 
		_GT_veh_grief_hash_list[1][2] = true
		_GT_veh_grief_hash_list[2][2] = true
	else
		_GT_veh_grief_hash_list[1][2] = false
		_GT_veh_grief_hash_list[2][2] = false
	end
end)

_GT_veh_grief_feat_list={}
for i=1,#_GT_veh_grief_hash_list-2 do
	if i ~= 1 and i ~= 2 then
		_GT_veh_grief_feat_list[#_GT_veh_grief_feat_list+1]=menu.add_feature(_GT_veh_grief_hash_list[i][3], "toggle", _G_VehGriefProtex.id,function(f) 
			if f.on then _GT_veh_grief_hash_list[i][2] = true
			else _GT_veh_grief_hash_list[i][2] = false
			end
		end)
	end
end

_G_VehProtexRamp=menu.add_feature("Ramp Buggy", "toggle", _G_VehGriefProtex.id,function(f)
	if f.on then 
		_GT_veh_grief_hash_list[#_GT_veh_grief_hash_list-1][2] = true
		_GT_veh_grief_hash_list[#_GT_veh_grief_hash_list][2] = true
	else
		_GT_veh_grief_hash_list[#_GT_veh_grief_hash_list-1][2] = false
		_GT_veh_grief_hash_list[#_GT_veh_grief_hash_list][2] = false
	end
end)


_G_AimGriefPlyrs=menu.add_feature("Players for aim protex", "action_value_str", _G_SelfProtex.id, function(f,pid)
end)_G_AimGriefPlyrs.set_str_data(_G_AimGriefPlyrs,{"Not Friends/Org/MC","Not Friends","Anyone"})

function _GF_not_frnd_org(_pid,_type)
	if _type == 0 then
		if not player.is_player_friend(_pid) and not _GF_same_orgmc(_pid,player.player_id()) then
			return true
		end
	elseif _type == 1 then
		if not player.is_player_friend(_pid) then
			return true
		end
	else
		return true
	end
	return false
end

_G_AimGriefExplode=menu.add_feature("Explode player","toggle",_G_SelfProtex.id, function(f)
	local distance,head,pos
	while f.on do
		system.yield(0)
		for i = 1,#_GT_aiming_at_me do
			if _GF_valid_pid(_GT_aiming_at_me[i]) then
				distance,head,pos = _GF_plyr_moving_pos(_GT_aiming_at_me[i])
				fire.add_explosion(_GF_front_of_pos(pos,head,distance,180,0.25), 2, true, false, 0, _GT_aiming_at_me[i])
				fire.add_explosion(_GF_front_of_pos(pos,head,distance,180,0.25), 2, true, false, 0, _GT_aiming_at_me[i])
			end
		end
	end
end)

_G_AimGriefburn=menu.add_feature("Burn player","toggle",_G_SelfProtex.id, function(f)
	local distance,head,pos
	while f.on do
		system.yield(0)
		for i = 1,#_GT_aiming_at_me do
			if _GF_valid_pid(_GT_aiming_at_me[i]) then
				distance,head,pos = _GF_plyr_moving_pos(_GT_aiming_at_me[i])
				fire.add_explosion(_GF_front_of_pos(pos,head,distance,180,0.25), 3, true, false, 0, _GT_aiming_at_me[i])
				fire.add_explosion(_GF_front_of_pos(pos,head,distance,180,0.25), 3, true, false, 0, _GT_aiming_at_me[i])
				fire.start_entity_fire(player.get_player_ped(_GT_aiming_at_me[i])) --not sure if this works on a player
			end
		end
	end
end)

_G_AimGriefSparrow=menu.add_feature("Drop sparrow on player","toggle",_G_SelfProtex.id, function(f)
	local distance,head,veh,pos
	while f.on do
		system.yield(0)
		for i = 1,#_GT_aiming_at_me do
			if _GF_valid_pid(_GT_aiming_at_me[i]) then
				_GF_req_stream_hash(1229411063)
				distance,head,pos = _GF_plyr_moving_pos(_GT_aiming_at_me[i])
				veh = vehicle.create_vehicle(1229411063, _GF_front_of_pos(pos, head, distance, 180, 20), math.random(0,359), true, false)
				entity.set_entity_velocity(veh, v3(0,0,-150))
			end
		end
	end
end)

_G_AimGriefFatBitch=menu.add_feature("Spawn angry fat bitch on player","toggle",_G_SelfProtex.id, function(f)
	local distance,head,bitch,pos
	while f.on do
		system.yield(0)
		for i = 1,#_GT_aiming_at_me do
			if _GF_valid_pid(_GT_aiming_at_me[i]) then
				_GF_req_stream_hash(gameplay.get_hash_key("a_f_m_fatcult_01"))
				distance,head,pos = _GF_plyr_moving_pos(_GT_aiming_at_me[i])
				bitch =_GF_spawn_angry_ped_at_pos(_GF_front_of_pos(pos, math.random(0,359), 7, 0, .5),gameplay.get_hash_key("a_f_m_fatcult_01"),gameplay.get_hash_key("weapon_machinepistol"),gameplay.get_hash_key("weapon_gusenberg"),_GT_aiming_at_me[i])
				system.yield(1000)
			end
		end
	end
end)

_G_AimGriefWeap=menu.add_feature("Remove weapons","value_str",_G_SelfProtex.id, function(f)
	while f.on do
		system.yield(0)
		for i = 1,#_GT_aiming_at_me do
			if _GF_valid_pid(_GT_aiming_at_me[i]) then
				if f.value == 0 then
					weapon.remove_weapon_from_ped(player.get_player_ped(_GT_aiming_at_me[i]), ped.get_current_ped_weapon(player.get_player_ped(_GT_aiming_at_me[i])))
				else
					weapon.remove_all_ped_weapons(player.get_player_ped(_GT_aiming_at_me[i]))
				end
				system.yield(1000)
			end
		end
	end
end)_G_AimGriefWeap.set_str_data(_G_AimGriefWeap,{"Current weapon", "All weapons"})
	
_G_AimGriefKick=menu.add_feature("Kick player","toggle",_G_SelfProtex.id, function(f)
	while f.on do
		system.yield(0)
		for i = 1,#_GT_aiming_at_me do
			if _GF_valid_pid(_GT_aiming_at_me[i]) then
				_GF_plyr_kick(_GT_aiming_at_me[i])	
			end
		end
	end
end)

_GT_aiming_at_me = {}
_G_AimDetexToggle=menu.add_feature("Hidden aim check","toggle",_G_SelfProtex.id, function(f)
	while f.on do
		system.yield(25)
		for i=0, 32 do
			if i ~= player.player_id() and _GF_not_frnd_org(i,_G_AimGriefPlyrs.value) and _GF_aim_at_me(i) then
				if not _GF_table_has(_GT_aiming_at_me,i) then
					_GT_aiming_at_me[#_GT_aiming_at_me+1]=i
				end
			elseif _GF_table_has(_GT_aiming_at_me,i) then
				_GF_table_remove(_GT_aiming_at_me,i)
			end
		end
	end
end)
_G_AimDetexToggle.on=true
_G_AimDetexToggle.hidden=true

_G_utils_do()
print("Main file contents loaded - "..(utils.time_ms()-_G_load_time_temp).."ms - Line: "..debug.getinfo(1).currentline)
_G_load_time_temp = utils.time_ms()
_G_plyrs_info_do(_G_Options)
print("Player info loaded        - "..(utils.time_ms()-_G_load_time_temp).."ms - Line: "..debug.getinfo(1).currentline)

_G_load_time_temp = utils.time_ms()
_G_plyrs_online_do(_G_GeeSkidP)
print("Players online loaded     - "..(utils.time_ms()-_G_load_time_temp).."ms - Line: "..debug.getinfo(1).currentline)
_G_load_time_temp = utils.time_ms()
_G_plyrs_local_do(_G_Players)
print("Players local loaded      - "..(utils.time_ms()-_G_load_time_temp).."ms - Line: "..debug.getinfo(1).currentline)
_G_load_time_temp = utils.time_ms()
_G_save_do(_G_Options)

print("Save loaded               - "..(utils.time_ms()-_G_load_time_temp).."ms - Line: "..debug.getinfo(1).currentline)
_G_load_time_temp = utils.time_ms()

for i=1,#_GT_all_veh_info do
	_GT_veh_hash_true_name[_GT_all_veh_info[i][4]]=_GT_all_veh_info[i][3]
end

menu.add_feature("Kick everyone","action",_G_Plyr_Kicks.id, function()
_GF_session_kicks_do("kick")
end)

menu.add_feature("Show list of players to kick","action",_G_Plyr_Kicks.id, function()
_GF_session_kicks_do("list")
end)

_G_kick_plyr_same_orgmc=menu.add_feature("Except my org/mc","toggle",_G_Plyr_Kicks.id, function()
end)

_G_kick_plyr_my_friend=menu.add_feature("Except my friends","toggle",_G_Plyr_Kicks.id, function()
end)

_G_kick_plyr_dist=menu.add_feature("Only within distance","value_i",_G_Plyr_Kicks.id, function()
end)_G_kick_plyr_dist.max,_G_kick_plyr_dist.min,_G_kick_plyr_dist.mod=300,15,15	

function _GF_session_kicks_do(_type)
	local me=player.player_id()
	local kick_table = {}
	for pid in _GF_all_players_but_me() do
		local continue=true
		if _G_kick_plyr_dist.on then
			if _GF_dist_me_pid(pid) > _G_kick_plyr_dist.value then
				continue=false
			end
		end
		if continue and _G_kick_plyr_same_orgmc.on then
			if _GF_same_orgmc(me,pid) then
				continue=false
			end
		end
		if continue and _G_kick_plyr_my_friend.on then
			if player.is_player_friend(pid) then
				continue=false
			end
		end
		if continue then
			kick_table[#kick_table+1]=pid
		end
	end
	if #kick_table == 0 then
		menu.notify("No available players to kick.",_G_GeeVer,4,2)
	elseif _type == "list" then
		local message = #kick_table.." player(s) to kick: "
		for i=1,#kick_table do
			message=message.._GF_plyr_name(kick_table[i]).."  "
		end
		menu.notify(""..message.."", _G_GeeVer, 7, 2)
	elseif _type == "kick" then 
		for i=1,#kick_table do
			_GF_plyr_kick(kick_table[i])
		end
	end
end

-------------------------------------------------------------------------------------------------Start Screen
-------------------------------------------------------------------------------------------------Below


_G_on_start_splash=menu.add_feature("_G_on_start_splash","toggle",_G_Options.id, function(f)
	_GF_yield_while_true(_GT_gta_map.loaded==false,5000)
	local alpha = 255
	local rot = 0
	local rot_mult = 0.0005
	local logo_size = 2
	local logo_alpha = 255
	local int = 1
	local root = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
	local splash_table = {}
	for i=1,47 do
		splash_table[i] = scriptdraw.register_sprite(root.."\\scripts\\GeeSkid\\gta_map\\not_part_of_map\\Geeskid_Splash"..i..".png")
	end
	local gee_skid_l = scriptdraw.register_sprite(root.."\\scripts\\GeeSkid\\gta_map\\not_part_of_map\\geeskid_logo_01.png")
	local time = utils.time_ms()+8000
	local start_rot = utils.time_ms()+3000
	local initial_splash = utils.time_ms()+1000
	while time > utils.time_ms() do
		system.yield(5)
		if initial_splash > utils.time_ms() then
			scriptdraw.draw_sprite(splash_table[1],v2(0,0),2,0, _GF_RGBAToInt(255,255,255,255))
		elseif math.floor(int) < 48 then
			scriptdraw.draw_sprite(splash_table[math.floor(int)],v2(0,0),2,0, _GF_RGBAToInt(255,255,255,math.floor(alpha)))
			int=int+0.25
		end
		if start_rot < utils.time_ms() then
			if rot+rot_mult > 6.25 then
				rot=0
			else
				rot=rot+rot_mult
			end
			rot_mult=rot_mult+0.0005
			logo_size=logo_size*.99
		end
		scriptdraw.draw_sprite(gee_skid_l,v2(0,0),logo_size,rot, _GF_RGBAToInt(0,200,0,math.floor(255-alpha)))
		alpha = alpha * .997
	end
	f.on=false
end)
_G_on_start_splash.hidden=true

ui.notify_above_map("Welcome to ~g~".._G_GeeVer.."\n~w~"..os.getenv("USERNAME").."", 10, 7)
print("--- ".._G_GeeVer.." - Loaded in "..(utils.time_ms()-_G_load_time).."ms ---")