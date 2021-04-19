local paths = {}
	paths["PDevs"] = utils.get_appdata_path("PopstarDevs", "")
	paths["Menu"] = paths["PDevs"] .. "\\2Take1Menu"
	paths["dumps"] = paths["Menu"] .. "\\crashdump"
	paths["outfits"] = paths["Menu"] .. "\\moddedOutfits"
	paths["vehicles"] = paths["Menu"] .. "\\moddedVehicles"
	paths["scripts"] = paths["Menu"] .. "\\scripts"
	paths["autoload"] = paths["scripts"] .. "\\autoload"
	paths["2T1S"] = paths["scripts"] .. "\\2Take1Script"
	paths["Config"] = paths["2T1S"] .. "\\Config"
	paths["CustomFiles"] = paths["2T1S"] .. "\\CustomFiles"
paths["Event-Logger"] = paths["2T1S"] .. "\\Event-Logger"

local files = {
	["Auth"] = paths["PDevs"] .. "\\PopstarAuth.log",
	["Menu_log"] = paths["Menu"] .. "\\2Take1Menu.log",
	["Prep"] = paths["Menu"] .. "\\2Take1Prep.log",
	["Admin"] = paths["scripts"] .. "\\2Take1Script-Admin.lua",
	["Log_file"] = paths["2T1S"] .. "\\2Take1Script.log",
	["EXT_file"] = paths["CustomFiles"] .. "\\2Take1ScriptEXT.lua",
	["Blacklist"] = paths["CustomFiles"] .. "\\2Take1Blacklist.cfg",
	["Modders"] = paths["CustomFiles"] .. "\\2Take1Modders.cfg",
	["data"] = paths["Config"] .. "\\offsets.data",
	["Config"] = paths["Config"] .. "\\2Take1Script.ini",
	["Hotkeys"] = paths["Config"] .. "\\2Take1Hotkeys.ini",
	["Exclude"] = paths["Config"] .. "\\2Take1Exclude.ini"
}

local s = {
	o = io.open,
	no = tonumber,
	wait = system.wait,
	time = utils.time_ms,
	random = math.random,
	id = player.player_id,
	d_exists = utils.dir_exists,
	ped = player.get_player_ped,
	f_exists = utils.file_exists,
	explode = fire.add_explosion,
	valid = player.is_player_valid,
	god = entity.set_entity_god_mode,
	gcoords = entity.get_entity_coords,
	visible = entity.set_entity_visible,
	script = script.trigger_script_event,
	navigate = menu.set_menu_can_navigate,
	vehicle = ped.get_vehicle_ped_is_using,
	attach = entity.attach_entity_to_entity,
	unload = streaming.set_model_as_no_longer_needed,
	bullet = gameplay.shoot_single_bullet_between_coords
}

local u = {}
u.write = function(file, text)
	if file and text then
		io.output(file)
		io.write(text .. "\n")
		io.close(file)
	end
end
u.time_prefix = function()
	local t = os.date("*t")
	if t.month < 10 then
		t.month = "0" .. t.month
	end
	if t.day < 10 then
		t.day = "0" .. t.day
	end
	if t.hour < 10 then
		t.hour = "0" .. t.hour
	end
	if t.min < 10 then
		t.min = "0" .. t.min
	end
	if t.sec < 10 then
		t.sec = "0" .. t.sec
	end
	return "["..t.year.."-"..t.month.."-"..t.day.." "..t.hour..":"..t.min..":"..t.sec.."]"
end
u.stop = function(f)
	if f.on then
		return 0
	end
	return 1
end
u.rgbtohex = function(rgb)
	local hexadecimal = '0X'
	for key, value in pairs(rgb) do
		local hex = ''
		while value > 0 do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end
		if string.len(hex) == 0 then
			hex = '00'
		elseif string.len(hex) == 1 then
			hex = '0' .. hex
		end
		hexadecimal = hexadecimal .. hex
	end
	return hexadecimal
end

local settings = {}
settings[0] = {}

	settings[0][#settings[0]+1] = "section_1"
	settings["section_1"] = "[Main-Settings]"

	settings[0][#settings[0]+1] = "version"
	settings["version"] = 19

	settings[0][#settings[0]+1] = "2t1s_parent"
	settings["2t1s_parent"] = true

	settings[0][#settings[0]+1] = "exclude_friends"
	settings["exclude_friends"] = true

	settings[0][#settings[0]+1] = "logger"
	settings["logger"] = true
	
	settings[0][#settings[0]+1] = "load_admin"
	settings["load_admin"] = true


	settings[0][#settings[0]+1] = "section_2"
	settings["section_2"] = "[Blacklist]"

	settings[0][#settings[0]+1] = "bl_hidden"
	settings["bl_hidden"] = false

	settings[0][#settings[0]+1] = "blacklist_enabled"
	settings["blacklist_enabled"] = false

	settings[0][#settings[0]+1] = "auto_kick"
	settings["auto_kick"] = false

	settings[0][#settings[0]+1] = "mark_modder"
	settings["mark_modder"] = false

	settings[0][#settings[0]+1] = "admin_enabled"
	settings["admin_enabled"] = false

	settings[0][#settings[0]+1] = "kick_joining"
	settings["kick_joining"] = false
	

	settings[0][#settings[0]+1] = "section_3"
	settings["section_3"] = "[Modders]"

	settings[0][#settings[0]+1] = "modder_hidden"
	settings["modder_hidden"] = false

	settings[0][#settings[0]+1] = "remember_modder"
	settings["remember_modder"] = false

	settings[0][#settings[0]+1] = "karma_modder_scripts"
	settings["karma_modder_scripts"] = false

	settings[0][#settings[0]+1] = "unmark_friends"
	settings["unmark_friends"] = false

	settings[0][#settings[0]+1] = "speed_bypass"
	settings["speed_bypass"] = false

	settings[0][#settings[0]+1] = "name_bypass"
	settings["name_bypass"] = false

	settings[0][#settings[0]+1] = "modded_scid"
	settings["modded_scid"] = false

	settings[0][#settings[0]+1] = "modded_net_events"
	settings["modded_net_events"] = false

	settings[0][#settings[0]+1] = "blame_killing"
	settings["blame_killing"] = false

	settings[0][#settings[0]+1] = "modded_script_event"
	settings["modded_script_event"] = false


	settings[0][#settings[0]+1] = "section_4"
	settings["section_4"] = "[Lobby]"
	
	settings[0][#settings[0]+1] = "lobby_hidden"
	settings["lobby_hidden"] = false

	settings[0][#settings[0]+1] = "teleport_to_block"
	settings["teleport_to_block"] = false

	settings[0][#settings[0]+1] = "explode_lobby"
	settings["explode_lobby"] = false

	settings[0][#settings[0]+1] = "explode_lobby_value"
	settings["explode_lobby_value"] = 8

	settings[0][#settings[0]+1] = "explode_lobby_shake"
	settings["explode_lobby_shake"] = false

	settings[0][#settings[0]+1] = "sound_rape"
	settings["sound_rape"] = false

	settings[0][#settings[0]+1] = "kill_all_peds"
	settings["kill_all_peds"] = false

	settings[0][#settings[0]+1] = "disablecontrol"
	settings["disablecontrol"] = false

	settings[0][#settings[0]+1] = "bounty_after_death"
	settings["bounty_after_death"] = false

	settings[0][#settings[0]+1] = "bounty_after_death_value"
	settings["bounty_after_death_value"] = 0

	settings[0][#settings[0]+1] = "anonymous_bounty"
	settings["anonymous_bounty"] = false

	settings[0][#settings[0]+1] = "sms_spam"
	settings["sms_spam"] = false

	settings[0][#settings[0]+1] = "sms_spam_value"
	settings["sms_spam_value"] = 25

	settings[0][#settings[0]+1] = "karma_se"
	settings["karma_se"] = false

	settings[0][#settings[0]+1] = "punish_aliens"
	settings["punish_aliens"] = false

	settings[0][#settings[0]+1] = "force_host"
	settings["force_host"] = false

	settings[0][#settings[0]+1] = "modify_veh_speed"
	settings["modify_veh_speed"] = 0

	settings[0][#settings[0]+1] = "modify_veh_speed_include"
	settings["modify_veh_speed_include"] = false

	settings[0][#settings[0]+1] = "modify_veh_speed_overwrite"
	settings["modify_veh_speed_overwrite"] = false


	settings[0][#settings[0]+1] = "section_5"
	settings["section_5"] = "[Vehicle-Blacklist]"

	settings[0][#settings[0]+1] = "veh_blacklist"
	settings["veh_blacklist"] = false

	settings[0][#settings[0]+1] = "Oppressor"
	settings["Oppressor"] = false

	settings[0][#settings[0]+1] = "MK2_Oppressor"
	settings["MK2_Oppressor"] = false

	settings[0][#settings[0]+1] = "Lazer"
	settings["Lazer"] = false

	settings[0][#settings[0]+1] = "Hydra"
	settings["Hydra"] = false

	settings[0][#settings[0]+1] = "Deluxo"
	settings["Deluxo"] = false

	settings[0][#settings[0]+1] = "Akula"
	settings["Akula"] = false

	settings[0][#settings[0]+1] = "B_11_Strikforce"
	settings["B_11_Strikforce"] = false

	settings[0][#settings[0]+1] = "Tank"
	settings["Tank"] = false

	settings[0][#settings[0]+1] = "Khanjali"
	settings["Khanjali"] = false

	settings[0][#settings[0]+1] = "Stromberg"
	settings["Stromberg"] = false

	settings[0][#settings[0]+1] = "Buzzard"
	settings["Buzzard"] = false

	settings[0][#settings[0]+1] = "Hunter"
	settings["Hunter"] = false

	settings[0][#settings[0]+1] = "Avenger"
	settings["Avenger"] = false

	settings[0][#settings[0]+1] = "Insurgent_Pickup"
	settings["Insurgent_Pickup"] = false

	settings[0][#settings[0]+1] = "Insurgent_Pickup_Custom"
	settings["Insurgent_Pickup_Custom"] = false

	settings[0][#settings[0]+1] = "Halftrack"
	settings["Halftrack"] = false


	settings[0][#settings[0]+1] = "section_6"
	settings["section_6"] = "[Chat]"

	settings[0][#settings[0]+1] = "chat_hidden"
	settings["chat_hidden"] = false

	settings[0][#settings[0]+1] = "chat_cmd_friends"
	settings["chat_cmd_friends"] = true

	settings[0][#settings[0]+1] = "chat_cmd_all"
	settings["chat_cmd_all"] = false

	settings[0][#settings[0]+1] = "chat_log"
	settings["chat_log"] = false

	settings[0][#settings[0]+1] = "echo_chat"
	settings["echo_chat"] = false

	settings[0][#settings[0]+1] = "echo_chat_value"
	settings["echo_chat_value"] = 1

	settings[0][#settings[0]+1] = "chat_russki"
	settings["chat_russki"] = false

	settings[0][#settings[0]+1] = "chat_begger"
	settings["chat_begger"] = false


	settings[0][#settings[0]+1] = "section_7"
	settings["section_7"] = "[Chat-Commands]"

	settings[0][#settings[0]+1] = "chat_cmd"
	settings["chat_cmd"] = false

	settings[0][#settings[0]+1] = "cmd_explode"
	settings["cmd_explode"] = false

	settings[0][#settings[0]+1] = "cmd_explode_all"
	settings["cmd_explode_all"] = false

	settings[0][#settings[0]+1] = "cmd_kick"
	settings["cmd_kick"] = false

	settings[0][#settings[0]+1] = "cmd_kick_all"
	settings["cmd_kick_all"] = false

	settings[0][#settings[0]+1] = "cmd_lag"
	settings["cmd_lag"] = false

	settings[0][#settings[0]+1] = "cmd_trap"
	settings["cmd_trap"] = false

	settings[0][#settings[0]+1] = "cmd_tp"
	settings["cmd_tp"] = false

	settings[0][#settings[0]+1] = "cmd_clearwanted"
	settings["cmd_clearwanted"] = false

	settings[0][#settings[0]+1] = "cmd_vehicle"
	settings["cmd_vehicle"] = false

	settings[0][#settings[0]+1] = "cmd_bigpp"
	settings["cmd_bigpp"] = false

	settings[0][#settings[0]+1] = "cmd_bigppall"
	settings["cmd_bigppall"] = false

	settings[0][#settings[0]+1] = "cmd_vehiclegod"
	settings["cmd_vehiclegod"] = false

	settings[0][#settings[0]+1] = "cmd_weaponsall"
	settings["cmd_weaponsall"] = false


	settings[0][#settings[0]+1] = "section_8"
	settings["section_8"] = "[Custom-Vehicles]"

	settings[0][#settings[0]+1] = "custom_vehicles_hidden"
	settings["custom_vehicles_hidden"] = false

	settings[0][#settings[0]+1] = "spawn_in_vehicle"
	settings["spawn_in_vehicle"] = true

	settings[0][#settings[0]+1] = "use_own_veh"
	settings["use_own_veh"] = true

	settings[0][#settings[0]+1] = "set_godmode"
	settings["set_godmode"] = false

	settings[0][#settings[0]+1] = "controllable_blasts"
	settings["controllable_blasts"] = false

	settings[0][#settings[0]+1] = "moveable_legs"
	settings["moveable_legs"] = false

	settings[0][#settings[0]+1] = "robot_collision"
	settings["robot_collision"] = false

	settings[0][#settings[0]+1] = "rocket_propulsion"
	settings["rocket_propulsion"] = false

	settings[0][#settings[0]+1] = "equip_weapons"
	settings["equip_weapons"] = false

	settings[0][#settings[0]+1] = "disable_tampa_notify"
	settings["disable_tampa_notify"] = false


	settings[0][#settings[0]+1] = "section_9"
	settings["section_9"] = "[Explosive-Beam]"

	settings[0][#settings[0]+1] = "explosive_beam_hidden"
	settings["explosive_beam_hidden"] = false

	settings[0][#settings[0]+1] = "exp_beam"
	settings["exp_beam"] = false

	settings[0][#settings[0]+1] = "exp_beam_type"
	settings["exp_beam_type"] = 59

	settings[0][#settings[0]+1] = "exp_beam_type_2"
	settings["exp_beam_type_2"] = 8

	settings[0][#settings[0]+1] = "exp_beam_radius"
	settings["exp_beam_radius"] = 10

	settings[0][#settings[0]+1] = "exp_beam_min"
	settings["exp_beam_min"] = 75

	settings[0][#settings[0]+1] = "exp_beam_max"
	settings["exp_beam_max"] = 225


	settings[0][#settings[0]+1] = "section_10"
	settings["section_10"] = "[Better-Animal-Changer]"
	
	settings[0][#settings[0]+1] = "animal_changer_hidden"
	settings["animal_changer_hidden"] = false

	settings[0][#settings[0]+1] = "bl_mdl_change"
	settings["bl_mdl_change"] = true

	settings[0][#settings[0]+1] = "revert_outfit"
	settings["revert_outfit"] = true


	settings[0][#settings[0]+1] = "section_11"
	settings["section_11"] = "[PTFX]"
	
	settings[0][#settings[0]+1] = "ptfx_hidden"
	settings["ptfx_hidden"] = false

	settings[0][#settings[0]+1] = "sparkling_ass"
	settings["sparkling_ass"] = false

	settings[0][#settings[0]+1] = "sparkling_tires"
	settings["sparkling_tires"] = false

	settings[0][#settings[0]+1] = "smoke_area"
	settings["smoke_area"] = false

	settings[0][#settings[0]+1] = "fire_circle"
	settings["fire_circle"] = false

	settings[0][#settings[0]+1] = "fire_fart"
	settings["fire_fart"] = 8

	settings[0][#settings[0]+1] = "fire_ass"
	settings["fire_ass"] = false


	settings[0][#settings[0]+1] = "section_12"
	settings["section_12"] = "[Miscellaneous]"

	settings[0][#settings[0]+1] = "misc_hidden"
	settings["misc_hidden"] = false

	settings[0][#settings[0]+1] = "drive_on_ocean"
	settings["drive_on_ocean"] = false

	settings[0][#settings[0]+1] = "drive_this_height"
	settings["drive_this_height"] = false

	settings[0][#settings[0]+1] = "weird_ent"
	settings["weird_ent"] = false

	settings[0][#settings[0]+1] = "real_time"
	settings["real_time"] = false

	settings[0][#settings[0]+1] = "clear_area"
	settings["clear_area"] = false

	settings[0][#settings[0]+1] = "clear_area_2"
	settings["clear_area_2"] = false

	settings[0][#settings[0]+1] = "auto_tp_wp"
	settings["auto_tp_wp"] = false

	settings[0][#settings[0]+1] = "remove_orb_cannon_cd"
	settings["remove_orb_cannon_cd"] = false

	settings[0][#settings[0]+1] = "auto_load"
	settings["auto_load"] = false

	settings[0][#settings[0]+1] = "log_modder_flags"
	settings["log_modder_flags"] = false


	settings[0][#settings[0]+1] = "section_13"
	settings["section_13"] = "[Weapons-Features]"

	settings[0][#settings[0]+1] = "load_weapons"
	settings["load_weapons"] = false

	settings[0][#settings[0]+1] = "flamethrower_scale"
	settings["flamethrower_scale"] = 1

	settings[0][#settings[0]+1] = "flamethrower"
	settings["flamethrower"] = false

	settings[0][#settings[0]+1] = "flamethrower_green"
	settings["flamethrower_green"] = false

	settings[0][#settings[0]+1] = "shoot_entitys"
	settings["shoot_entitys"] = false

	settings[0][#settings[0]+1] = "Boat"
	settings["Boat"] = false

	settings[0][#settings[0]+1] = "Bumper_Car"
	settings["Bumper_Car"] = false

	settings[0][#settings[0]+1] = "XMAS_Tree"
	settings["XMAS_Tree"] = false

	settings[0][#settings[0]+1] = "Orange_Ball"
	settings["Orange_Ball"] = false

	settings[0][#settings[0]+1] = "Stone"
	settings["Stone"] = false

	settings[0][#settings[0]+1] = "Money_Bag"
	settings["Money_Bag"] = false

	settings[0][#settings[0]+1] = "Cash_Pile"
	settings["Cash_Pile"] = false

	settings[0][#settings[0]+1] = "Trash"
	settings["Trash"] = false

	settings[0][#settings[0]+1] = "Roller_Car"
	settings["Roller_Car"] = false

	settings[0][#settings[0]+1] = "Cable_Car"
	settings["Cable_Car"] = false

	settings[0][#settings[0]+1] = "Big_Dildo"
	settings["Big_Dildo"] = false

	settings[0][#settings[0]+1] = "delete_gun"
	settings["delete_gun"] = false

	settings[0][#settings[0]+1] = "kick_gun"
	settings["kick_gun"] = false

	settings[0][#settings[0]+1] = "demigod_gun"
	settings["demigod_gun"] = false

	settings[0][#settings[0]+1] = "model_gun"
	settings["model_gun"] = false

	settings[0][#settings[0]+1] = "model_gun_ext"
	settings["model_gun_ext"] = false

	settings[0][#settings[0]+1] = "rapid_fire"
	settings["rapid_fire"] = false


	settings[0][#settings[0]+1] = "section_14"
	settings["section_14"] = "[Vehicle]"

	settings[0][#settings[0]+1] = "always_apply_mods"
	settings["always_apply_mods"] = false

	settings[0][#settings[0]+1] = "heli"
	settings["heli"] = false

	settings[0][#settings[0]+1] = "heli_i"
	settings["heli_i"] = 100

	settings[0][#settings[0]+1] = "sel_boost_speed"
	settings["sel_boost_speed"] = false

	settings[0][#settings[0]+1] = "sel_boost_speed_speed"
	settings["sel_boost_speed_speed"] = 100

	settings[0][#settings[0]+1] = "speedometer"
	settings["speedometer"] = false

	settings[0][#settings[0]+1] = "speedometer_type"
	settings["speedometer_type"] = 1

	settings[0][#settings[0]+1] = "veh_no_colision"
	settings["veh_no_colision"] = false

	settings[0][#settings[0]+1] = "auto_repair"
	settings["auto_repair"] = false

	settings[0][#settings[0]+1] = "section_15"
	settings["section_15"] = "[Vehicle-Colors]"

	settings[0][#settings[0]+1] = "veh_lights_speed"
	settings["veh_lights_speed"] = 125

	settings[0][#settings[0]+1] = "random_primary"
	settings["random_primary"] = false

	settings[0][#settings[0]+1] = "random_secondary"
	settings["random_secondary"] = false

	settings[0][#settings[0]+1] = "random_pearlescent"
	settings["random_pearlescent"] = false

	settings[0][#settings[0]+1] = "random_neon"
	settings["random_neon"] = false

	settings[0][#settings[0]+1] = "random_smoke"
	settings["random_smoke"] = false

	settings[0][#settings[0]+1] = "random_xenon"
	settings["random_xenon"] = false

	settings[0][#settings[0]+1] = "rainbow_primary"
	settings["rainbow_primary"] = false

	settings[0][#settings[0]+1] = "rainbow_secondary"
	settings["rainbow_secondary"] = false

	settings[0][#settings[0]+1] = "rainbow_pearlescent"
	settings["rainbow_pearlescent"] = false

	settings[0][#settings[0]+1] = "rainbow_neon"
	settings["rainbow_neon"] = false

	settings[0][#settings[0]+1] = "rainbow_smoke"
	settings["rainbow_smoke"] = false

	settings[0][#settings[0]+1] = "rainbow_xenon"
	settings["rainbow_xenon"] = false

	settings[0][#settings[0]+1] = "synced_random"
	settings["synced_random"] = false

	settings[0][#settings[0]+1] = "synced_rainbow"
	settings["synced_rainbow"] = false

	settings[0][#settings[0]+1] = "synced_rainbow_smooth"
	settings["synced_rainbow_smooth"] = false

	settings[0][#settings[0]+1] = "black_100"
	settings["black_100"] = false

	settings[0][#settings[0]+1] = "fade_black_red"
	settings["fade_black_red"] = false


	settings[0][#settings[0]+1] = "section_17"
	settings["section_17"] = "[Self]"

	settings[0][#settings[0]+1] = "self_hidden"
	settings["self_hidden"] = false

	settings[0][#settings[0]+1] = "random_clothes"
	settings["random_clothes"] = false

	settings[0][#settings[0]+1] = "police_outfit"
	settings["police_outfit"] = false

	settings[0][#settings[0]+1] = "random_clothes_value"
	settings["random_clothes_value"] = 5

	settings[0][#settings[0]+1] = "undead_otr"
	settings["undead_otr"] = false

	settings[0][#settings[0]+1] = "quick_regen"
	settings["quick_regen"] = false

	settings[0][#settings[0]+1] = "unlimited_regen"
	settings["unlimited_regen"] = false

	settings[0][#settings[0]+1] = "revert_health"
	settings["revert_health"] = false

	settings[0][#settings[0]+1] = "ragdoll"
	settings["ragdoll"] = false

	settings[0][#settings[0]+1] = "section_18"
	settings["section_18"] = "[Aim-Protection]"

	settings[0][#settings[0]+1] = "enable_aim_prot"
	settings["enable_aim_prot"] = false

	settings[0][#settings[0]+1] = "anonymous_punishment"
	settings["anonymous_punishment"] = true

	settings[0][#settings[0]+1] = "aim_prot_ragdoll"
	settings["aim_prot_ragdoll"] = false

	settings[0][#settings[0]+1] = "aim_prot_fire"
	settings["aim_prot_fire"] = false

	settings[0][#settings[0]+1] = "aim_prot_kill"
	settings["aim_prot_kill"] = false

	settings[0][#settings[0]+1] = "aim_prot_remove_weapon"
	settings["aim_prot_remove_weapon"] = false

	settings[0][#settings[0]+1] = "aim_prot_kick"
	settings["aim_prot_kick"] = false

	settings[0][#settings[0]+1] = "electrocute_player"
	settings["electrocute_player"] = false


	settings[0][#settings[0]+1] = "section_16"
	settings["section_16"] = "[Bodyguards]"

	settings[0][#settings[0]+1] = "bodyguards_hidden"
	settings["bodyguards_hidden"] = false

	settings[0][#settings[0]+1] = "bodyguards_god"
	settings["bodyguards_god"] = false

	settings[0][#settings[0]+1] = "bodyguards_health"
	settings["bodyguards_health"] = 5000

	settings[0][#settings[0]+1] = "bodyguards_equip_weapon"
	settings["bodyguards_equip_weapon"] = false

	settings[0][#settings[0]+1] = "bodyguards_formation_type"
	settings["bodyguards_formation_type"] = 0


	settings[0][#settings[0]+1] = "section_19"
	settings["section_19"] = "[Options]"

	settings[0][#settings[0]+1] = "options_hidden"
	settings["options_hidden"] = false

	settings[0][#settings[0]+1] = "attach_no_colision"
	settings["attach_no_colision"] = false

	settings[0][#settings[0]+1] = "continuously_assassins"
	settings["continuously_assassins"] = false

	settings[0][#settings[0]+1] = "override_notify_color"
	settings["override_notify_color"] = false

	settings[0][#settings[0]+1] = "notify_color"
	settings["notify_color"] = 0

	settings[0][#settings[0]+1] = "enable_hotkeys"
	settings["enable_hotkeys"] = false

	settings[0][#settings[0]+1] = "hotkey_notification"
	settings["hotkey_notification"] = false

	settings[0][#settings[0]+1] = "disable_history"
	settings["disable_history"] = false

	settings[0][#settings[0]+1] = "history_show_uuid"
	settings["history_show_uuid"] = false

	settings[0][#settings[0]+1] = "mwh_notify"
	settings["mwh_notify"] = false

	settings[0][#settings[0]+1] = "mwh_exclude_navigation"
	settings["mwh_exclude_navigation"] = true

	settings[0][#settings[0]+1] = "mwh_exclude_noclip"
	settings["mwh_exclude_noclip"] = true

	settings[0][#settings[0]+1] = "mwh_exclude_editorrot"
	settings["mwh_exclude_editorrot"] = true

settings[0][#settings[0]+1] = "mwh_exclude_file"
settings["mwh_exclude_file"] = false

local hotkeys = {}
hotkeys[0] = {}

	hotkeys[0][#hotkeys[0]+1] = "leave_session"
	hotkeys["leave_session"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "undead_otr"
	hotkeys["undead_otr"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "do_ragdoll"
	hotkeys["do_ragdoll"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "print_info_from_entity"
	hotkeys["print_info_from_entity"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "drive_this_height"
	hotkeys["drive_this_height"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "auto_tp_wp"
	hotkeys["auto_tp_wp"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "force_host"
	hotkeys["force_host"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "synced_rainbow"
	hotkeys["synced_rainbow"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "veh_blacklist"
	hotkeys["veh_blacklist"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "laser_beam_explode_waypoint"
	hotkeys["laser_beam_explode_waypoint"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "blacklist_enabled"
	hotkeys["blacklist_enabled"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "kick_joining"
	hotkeys["kick_joining"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "remember_modder"
	hotkeys["remember_modder"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "exclude_friends"
	hotkeys["exclude_friends"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "chat_cmd"
	hotkeys["chat_cmd"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "send_msg_to_script_users"
	hotkeys["send_msg_to_script_users"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "teleport_high_in_air"
	hotkeys["teleport_high_in_air"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "tp_own_veh_to_me"
	hotkeys["tp_own_veh_to_me"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "tp_own_veh_to_me_drive"
	hotkeys["tp_own_veh_to_me_drive"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "drive_own_veh"
	hotkeys["drive_own_veh"] = "none"

	hotkeys[0][#hotkeys[0]+1] = "tp_to_own_veh"
	hotkeys["tp_to_own_veh"] = "none"

hotkeys[0][#hotkeys[0]+1] = "save_config"
hotkeys["save_config"] = "none"

local modder_flags = {}
modder_flags[0] = {}

	modder_flags[0][#modder_flags[0] + 1] = "maxspeed"
	modder_flags["maxspeed"] = {"Max-Speed-Bypass", nil}

	modder_flags[0][#modder_flags[0] + 1] = "illegalname"
	modder_flags["illegalname"] = {"Illegal-Name", nil}

	modder_flags[0][#modder_flags[0] + 1] = "moddedscid"
	modder_flags["moddedscid"] = {"Modded-SCID", nil}

	modder_flags[0][#modder_flags[0] + 1] = "moddednetevent"
	modder_flags["moddednetevent"] = {"Modded-Net-Event", nil}

	modder_flags[0][#modder_flags[0] + 1] = "blame_killing"
	modder_flags["blame_killing"] = {"Blame-Killing", nil}

	modder_flags[0][#modder_flags[0] + 1] = "remembered"
	modder_flags["remembered"] = {"Remembered", nil}

	modder_flags[0][#modder_flags[0] + 1] = "blacklist"
	modder_flags["blacklist"] = {"Blacklist", nil}

modder_flags[0][#modder_flags[0] + 1] = "script"
modder_flags["script"] = {"Modded-Script-Event", nil}

local function n(text, color, header)
	if not text then
		return
	end
	color = color or 140
	header = header or "~h~2Take1Script~h~&#166"
	if settings["override_notify_color"] then
		color = settings["notify_color"]
	end
	ui.notify_above_map(text, header, color)
end

local function l(text, custom_prefix)
	if settings["logger"] then
		if not text then
			return
		end
		local prefix = u.time_prefix() .. " [2Take1Script] "
		if custom_prefix then
			prefix = prefix .. custom_prefix .. " "
		end
		text = prefix .. text
		u.write(s.o(files["Log_file"], "a"), text)
	end
end

local flags_int = {
	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304,
	8388608, 16777216, 33554432, 67108864, 134217728, 268435456, 536870912, 1073741824, 2147483648, 4294967296, 8589934592, 17179869184,
	34359738368, 68719476736, 137438953472, 274877906944, 549755813888, 1099511627776, 2199023255552, 4398046511104, 8796093022208,
	17592186044416, 35184372088832, 70368744177664, 140737488355328, 281474976710656, 562949953421312, 1125899906842624, 2251799813685248,
	4503599627370496, 9007199254740992, 18014398509481984, 36028797018963968, 72057594037927936, 144115188075855872, 288230376151711744,
	576460752303423488, 1152921504606846976, 2305843009213693952, 4611686018427387904
}

local kick_events = {}
local ext_data = {}
local mapper = {}

local g = {}
g.name = function(i)
	if s.valid(i) then
		return player.get_player_name(i)
	end
	return "Invalid Player"
end
g.scid = function(i)
	if s.valid(i) then
		local s = player.get_player_scid(i)
		if s ~= 4294967295 then
			return s
		end
	end
	return -1
end
g.ip = function(i)
	if s.valid(i) then
		local playerip = player.get_player_ip(i)
		return string.format(
			"%i.%i.%i.%i", (playerip >> 24) & 0xff, ((playerip >> 16) & 0xff), ((playerip >> 8) & 0xff), playerip & 0xff
		)
	end
	return -1
end
g.input = function(title, lenght, i_type, pre_name)
	if not title then
		return nil
	end
	pre_name = pre_name or ""
	lenght = lenght or 64
	i_type = i_type or 0
	local err, i = input.get(title, pre_name, lenght, i_type)
	while err == 1 do
		s.wait(0)
		err, i = input.get(title, pre_name, lenght, i_type)
	end
	if err == 2 then
		return nil
	end
	return i
end

local setup = {}
setup.main = function()
	l("Loading Settings...")
	math.randomseed(s.time())
	if _2t1s then
		n("2Take1Script already loaded, stopping.", 208)
		return
	end
	if not s.d_exists(paths["2T1S"]) then
		n("2Take1Script folder not found...", 208)
		n("Redownload the script and make sure you got all files!", 208)
		return
	else
		if s.f_exists(files["EXT_file"]) then
			_2t1sEXT = true
			local extension_file, error = loadfile(files["EXT_file"])
			if extension_file then
				local e
				e,
				ext_data.custom_se,
				ext_data.ped_assassins,
				ext_data.russki_chars,
				ext_data.begger_texts,
				ext_data.speedometer_units,
				ext_data.block_custom,
				ext_data.custom_attachments,
				ext_data.custom_vehicles,
				ext_data.vehicle_lag_area,
				ext_data.bounty_amount,
				ext_data.sms_texts,
				ext_data.weapons,
				ext_data.enable_admin
				= xpcall(extension_file, debug.traceback)
				l("2Take1ScriptEXT successfully loaded.")
			else
				_2t1sEXT = false
				n("ERROR Loading Script EXT, returning!", 208)
				return
			end
		else
			n("2Take1ScriptEXT.lua not found!\nMake sure you have all important files!", 208)
			return
		end
		if not s.d_exists(paths["Config"]) then
			n("2Take1Script/Config folder not found...", 208)
			n("Redownload the script and make sure you got all files!", 208)
			return
		end
		if not s.d_exists(paths["CustomFiles"]) then
			n("2Take1Script/CustomFiles folder not found...", 208)
			n("Redownload the script and make sure you got all files!", 208)
			return
		end
	end
	local _file = s.o(files["Config"], "r")
	if _file then
		for value in io.lines(files["Config"]) do
			if not string.find(value, "]", 1) and not string.find(value, "version", 1) then
				local index = ""
				while string.find(value, "=", 1) do
					index = index .. string.sub(value, 1, 1)
					value = string.sub(value, 2)
				end
				index = string.sub(index, 1, #index - 1)
				if settings[index] ~= nil then
					if value == "true" then
						settings[index] = true
					elseif value == "false" then
						settings[index] = false
					elseif type(value) == "number" then
						settings[index] = s.no(value)
					else
						settings[index] = value
					end
				else
					n("I found an outdated settings entry and cant read it, save settings to overwrite it.")
					n("Setting: '" .. index .. "' is invalid. Delete this entry or save settings.")
				end
			end
		end
		io.close(_file)
	end
	_file = nil
	_file = s.o(files["data"], "r")
	if _file then
		for kick in io.lines(files["data"]) do
			kick_events[#kick_events + 1] = kick
		end
		io.close(_file)
	else
		n("ERROR Loading Script, returning!", 208)
		n("Missing files! Redownload the .zip folder and make sure you have all included files!!!")
		return
	end
	if s.f_exists(files["Admin"]) then
		if not l_a and settings["load_admin"] then
			local admin_file, error = loadfile(files["Admin"])
			if admin_file then
				xpcall(admin_file, debug.traceback)
				l("2Take1Script-Admin successfully loaded.")
			else
				n("ERROR Loading Script Admin!", 208)
			end
		end
	end
	mapper.veh = require("VehicleMapper")
	mapper.ped = require("PedMapper")
	mapper.obj = require("ObjectMapper")
	mapper.net = require("NetEventMapper")
	return true
end
setup.modder_flags = function()
	l("Loading Modder-Flags...")
	for i = 18, #flags_int do
		if player.get_modder_flag_text(flags_int[i]) == "" then
			break
		end
		for y = 1, #modder_flags[0] do
			if player.get_modder_flag_text(flags_int[i]) == modder_flags[modder_flags[0][y]][1] then
				modder_flags[modder_flags[0][y]][2] = flags_int[i]
			end
		end
	end
	for i = 1, #modder_flags[0] do
		if not modder_flags[modder_flags[0][i]][2] then
			modder_flags[modder_flags[0][i]][2] = player.add_modder_flag(modder_flags[modder_flags[0][i]][1])
		end
	end
end
setup.hotkeys = function()
	l("Reading Hotkeys.")
	local sf = s.o(files["Hotkeys"], "r")
	if sf then
		for key in io.lines(files["Hotkeys"]) do
			if string.find(key, "version", 1) then
				local version = string.gsub(key, "version=", "")
				version = s.no(version)
				if version ~= settings["version"] then
					n("Old Hotkeys-File detected. Delete the file or use the overwrite in the Hotkey-Options!", 86)
				end
			end
			if not string.find(key, "#", 1) and not string.find(key, "version", 1) then
				local index = ""
				while string.find(key, "=", 1) do
					index = index .. string.sub(key, 1, 1)
					key = string.sub(key, 2)
				end
				index = string.sub(index, 1, #index - 1)
				if key ~= "none" and key ~= "nil" then
					if hotkeys[index] then
						hotkeys[index] = key
					else
						n("Outdated Hotkeys entry found. Delete the file or use the overwrite in the Hotkey-Options!", 86)
						n("Hotkey: '" .. key .. "' with action: '" .. index .. "' is invalid. Delete this entry.", 86)
					end
				end
			end
		end
		io.close(sf)
	end
end
setup.overwrite_hotkeys = function()
	local hk = s.o(files["Hotkeys"], "w")
	io.output(hk)
	io.write("version=" .. settings["version"] .. "\n")
	for i = 1, #hotkeys[0] do
		io.write(hotkeys[0][i] .. "=" .. tostring(hotkeys[hotkeys[0][i]]) .. "\n")
	end
	io.write("################################\n")
	io.write("#There are more valid Keys, but i wont list them. Currently its not supported to push 2 Keys for 1 Hotkey.\n")
	io.write("#Example valid Hotkeys:\n")
	io.write("#F1-F12\n")
	io.write("#A-Z\n")
	io.write("#LCONTROL\n")
	io.write("#RSHIFT\n")
	io.write("#Insert\n")
	io.write("#Down\n")
	io.write("#PageDown\n")
	io.close(hk)
	n("Created 2Take1Hotkeys.ini file in folder '2Take1Script/Config'. Edit Hotkeys and reload Hotkeys.ini file.", 86)
end

if not setup.main() then
	return
end
setup.hotkeys()
setup.modder_flags()

local req = {}
req.ctrl = function(e, t)
	if entity.is_an_entity(e) then
		if not network.has_control_of_entity(e) then
			network.request_control_of_entity(e)
			t = t or 25
			local time = s.time() + t
			while entity.is_an_entity(e) and not network.has_control_of_entity(e) do
				s.wait(0)
				network.request_control_of_entity(e)
				if time < s.time() then
					return false
				end
			end
		end
		return network.has_control_of_entity(e)
	end
	return false
end
req.model = function(h)
	if h and not streaming.has_model_loaded(h) then
		streaming.request_model(h)
		local time = s.time() + 7500
		while not streaming.has_model_loaded(h) do
			s.wait(0)
			if time < s.time() then
				return false
			end
		end
	end
	return true
end

local o = {}
o.ped = function() return s.ped(s.id()) end
o.heading = function() return player.get_player_heading(s.id()) end
o.coords = function() return s.gcoords(o.ped()) end

local m = {}
m.p = {
	["parent"] = 0,
	["opl_parent"] = 0
}
m.t = {}
m.o = {}
m.add = {}
m.add.p = function (name, place, callback) return menu.add_feature(name, "parent", place, callback) end
m.add.t = function (name, place, callback) return menu.add_feature(name, "toggle", place, callback) end
m.add.a = function (name, place, callback) return menu.add_feature(name, "action", place, callback) end
m.add.u = function (name, f_type, place, callback) return menu.add_feature(name, f_type, place, callback) end
m.add.pp = function (name, place, callback) return menu.add_player_feature(name, "parent", place, callback) end
m.add.pt = function (name, place, callback) return menu.add_player_feature(name, "toggle", place, callback) end
m.add.pa = function (name, place, callback) return menu.add_player_feature(name, "action", place, callback) end
m.add.pu = function (name, f_type, place, callback) return menu.add_player_feature(name, f_type, place, callback) end

local valid = {}
valid.i = function(i, include)
	include = include or false
	if s.valid(i) then
		if (include or i ~= s.id()) and g.scid(i) ~= -1 then
			if include or (settings["exclude_friends"] and not player.is_player_friend(i) or not settings["exclude_friends"]) then
				return true
			end
		end
	end
	return false
end
valid.modder = function(i)
	if s.valid(i) then
		if g.scid(i) ~= -1 and i ~= s.id() and not player.is_player_modder(i, -1) then
			if (settings["exclude_friends"] and not player.is_player_friend(i)) or not settings["exclude_friends"] then
				return true
			end
		end
	end
	return false
end
valid.vehicle = function(veh)
	if not veh then
		return
	end
	if veh ~= 0 and (vehicle.get_ped_in_vehicle_seat(veh, -1) == o.ped() or m.t["always_apply_mods"].on) then
		return true
	end
	return
end

local modder_player = {}
modder_player[1] = true

local history = {}
history.add_loop = 1
history.start_loop = 1
history.parents = {}
history.players = {}
history.event = nil
history.lobby = nil
history.tags = function(feat)
	for i = 2, #feat.children do
		local cur_name = feat.children[i].name
		local org_name = string.sub(feat.children[i].children[2].name, 7)
		if cur_name ~= org_name then
			feat.children[i].name = org_name
		end
		local scid = s.no(string.sub(feat.children[i].children[3].name, 7))
		local host = player.get_host()
		local shost = script.get_host_of_this_script()
		for y = 0, 31 do
			if g.scid(y) == scid then
				local tag = ""
				if y == s.id() then
					tag = tag .. "Y"
				end
				if player.is_player_friend(y) then
					tag = tag .. "F"
				end
				if y == host then
					tag = tag .. "H"
				end
				if y == shost then
					tag = tag .. "S"
				end
				if player.is_player_modder(y, -1) then
					tag = tag .. "M"
				end
				if tag ~= "" then
					org_name = org_name .. " [" .. tag .. "]"
					feat.children[i].name = org_name
				end
			end
		end
	end
end
history.add_players = function()
	if not settings["disable_history"] then
		for i = history.add_loop, #history.players do
			local uuid = history.players[i]["uuid"]
			local bool1 = history.players[i]["added"] == false
			local lobbyname = s.no(string.sub(history.lobby.name, 7, 8))
			local lobbyhistory = s.no(string.sub(uuid, #uuid - 1, #uuid))
			if not lobbyhistory then
				lobbyhistory = s.no(string.sub(uuid, #uuid, #uuid))
			end
			local bool2 = lobbyname == lobbyhistory
			if bool1 and bool2 then
				history.add_loop = history.add_loop + 1
				history.players[i]["added"] = true
				local scid = history.players[i]["scid"]
				local name = history.players[i]["name"]
				local history_parent = m.add.p(name, history.lobby.id).id
				m.add.a("UUID: " .. history.players[i]["uuid"], history_parent).hidden = not settings["history_show_uuid"]
				m.add.a("NAME: "..name, history_parent, function ()
					utils.to_clipboard(name)
					n("Copied NAME to clipboard!", 21)
					end)
				m.add.a("SCID: "..scid, history_parent, function ()
					utils.to_clipboard(scid)
					n("Copied SCID to clipboard!", 21)
					end)
				m.add.a("IP: "..history.players[i]["ip"], history_parent, function ()
					utils.to_clipboard(history.players[i]["ip"])
					n("Copied IP to clipboard!", 21)
					end)
				m.add.a("PlayerID: "..history.players[i]["player_id"], history_parent)
				m.add.a("First seen: "..history.players[i]["first_seen"], history_parent)
				m.add.a("Add Player to Blacklist", history_parent, function ()
					if scid == g.scid(s.id()) or scid == -1 then
						n("Choose valid Player.")
					else
						u.write(s.o(files["Blacklist"], "a"), scid .. " " .. name)
						n("Player "..name.." added to Blocklist.", 48)
						l("Player "..name.." with SCID: "..scid.." added to Blacklist.")
					end
					end)
				m.add.a("Add Player to Remember-Modder", history_parent, function ()
					if scid == g.scid(s.id()) or scid == -1 then
						n("Choose valid Player.")
					else
						u.write(s.o(files["Modders"], "a"), scid .. " " .. name)
						n("Modder "..name.." added to Remember-List.", 130)
						l("Modder '"..name.."' added to Remember-List.")
					end
					end)
				m.add.a("Copy Outfit", history_parent, function ()
					local female = player.is_player_female(s.id())
					if female == history.players[i]["is_female"] then
						local h_clothes = history.players[i]["h_clothes"]
						local h_textures = history.players[i]["h_textures"]
						for y = 1, 11 do
							ped.set_ped_component_variation(o.ped(), y, h_clothes[y], h_textures[y], 2)
						end
						local loop = {0, 1, 2, 6, 7}
						local h_prop_ind = history.players[i]["h_prop_ind"]
						local h_prop_text = history.players[i]["h_prop_text"]
						for z = 1, #loop do
							ped.set_ped_prop_index(o.ped(), loop[z], h_prop_ind[z], h_prop_text[z], 0)
						end
					else
						n("Unluckily, you have the wrong gender!", 21)
					end
					end)
				m.add.a("Is "..name.." in the current lobby?", history_parent, function ()
					for y = 0, 31 do
						if g.scid(y) == scid then
							n(name.." is in your lobby!", 18)
							return HANDLER_POP
						end
					end
					n(name.." is ~h~NOT~h~ in your lobby!", 28)
					end)
				m.add.a("Was he a modder?", history_parent, function()
					local scid = history.players[i]["scid"]
					if not m.t["log_modder_flags"].on then
						n("Enabel 'Log Modder Flags' in Misc -> Dev Tools", 39)
					elseif not modder_player[scid] then
						n("He was not flagged with any Modder-Flags", 21)
					else
						for y = 1, #flags_int do
							if modder_player[scid][flags_int[y]] then
								local int = flags_int[y]
								local text = player.get_modder_flag_text(int)
								n(name.." had '"..text.."' as a Flag!", 21)
							end
						end
					end
					end)
			end
		end
	end
end
history.new_lobby = function(lobby_no)
	local lenght = #history.parents + 1
	history.parents[lenght] = m.add.p("Lobby " .. lobby_no, m.p["player_history"], function()
		history.add_players()
		history.tags(history.parents[lenght])
		end)
	local prev = #history.parents - 1
	local lobby = history.parents[prev].children
	m.add.p("Lobby Information", history.parents[lenght].id).hidden = true
	history.lobby = history.parents[lenght]
	lobby[1].hidden = false
	m.add.a("Logged " .. (#lobby - 1) .. " Players in this Lobby!", lobby[1].id)
	m.add.a("Hide this lobby from History", lobby[1].id, function()
		history.parents[lenght - 1].hidden = true
		end)
end

local spawn = {}
spawn.ped = function(hash, pos, ped_type, heading, isNetworked, unk1)
	if not hash then
		return
	end
	ped_type = ped_type or 6
	pos = pos or o.coords()
	heading = heading or 0.0
	isNetworked = isNetworked or true
	unk1 = unk1 or false
	return ped.create_ped(ped_type, hash, pos, heading, isNetworked, unk1)
end
spawn.object = function(hash, pos, networked, dynamic)
	if not hash then
		return
	end
	pos = pos or v3()
	networked = networked or true
	dynamic = dynamic or false
	return object.create_object(hash, pos, networked, dynamic)
end
spawn.vehicle = function(hash, pos, heading, networked, unk1)
	if not hash then
		return
	end
	pos = pos or v3()
	heading = heading or 0.0
	networked = networked or true
	unk1 = unk1 or false
	return vehicle.create_vehicle(hash, pos, heading, networked, unk1)
end

local send_2_mission = {
	{"Severe Weather", {0}},
	{"Half Track", {0, 1}},
	{"Night Shark AAT", {0, 2}},
	{"APC Mission", {0, 3}},
	{"MOC Mission", {0, 4}},
	{"Tampa Mission", {0, 5}},
	{"Opressor Mission 1", {0, 6}},
	{"Opressor Mission 2", {0, 7}}
}
local se_ceo = {
	{"Ban", -738295409, {0, 1, 5, 0}, 1648921703, {0, 1, 5, 0}},
	{"Dismiss", -1648921703, {0, 1, 5}, 1648921703, {0, 1, 5}},
	{"Terminate", -1648921703, {1, 1, 6}, 1648921703, {0, 1, 6, 0}}
}
local shoot_entitys = {
	{"Boat", -1685705098, false},
	{"Bumper_Car", -77393630, false},
	{"XMAS_Tree", 238789712, false},
	{"Orange_Ball", 148511758, false},
	{"Stone", 2042668880, false},
	{"Money_Bag", 289396019, false},
	{"Cash_Pile", -295781225, false},
	{"Trash", 1919238784, false},
	{"Roller_Car", 1543894721, false},
	{"Cable_Car", -733833763, false},
	{"Big_Dildo", 1333481871, false}
}
local neon_lights_rgb = {
	{222, 222, 255},
	{2, 21, 255},
	{3, 83, 255},
	{0, 255, 140},
	{94, 255, 1},
	{255, 255, 0},
	{255, 150, 5},
	{255, 62, 0},
	{255, 1, 1},
	{255, 50, 100},
	{255, 5, 190},
	{35, 1, 255},
	{15, 3, 255}
}
local bl_veh = {
	{"Oppressor", 0x34B82784},
	{"MK2_Oppressor", 0x7B54A9D3},
	{"Lazer", 0xB39B0AE6},
	{"Hydra", 0x39D6E83F},
	{"Deluxo", 0x586765FB},
	{"Akula", 0x46699F47},
	{"B_11_Strikforce", 0x64DE07A1},
	{"Tank", 0x2EA68690},
	{"Khanjali", 0xAA6F980A},
	{"Stromberg", 0x34DBA661},
	{"Buzzard", 0x2F03547B},
	{"Hunter", 0xFD707EDE},
	{"Avenger", 0x81BD2ED0},
	{"Insurgent_Pickup", 0x9114EADA},
	{"Insurgent_Pickup_Custom", 0x8D4B7A8A},
	{"Halftrack", 0xFE141DA6}
}
local cmds = {
	{"cmd_explode", "!explode <playername>"},
	{"cmd_explode_all", "!explodeall	[SU]"},
	{"cmd_kick", "!kick <playername>"},
	{"cmd_kick_all", "!kickall	[SU]"},
	{"cmd_lag", "!lag <playername>"},
	{"cmd_trap", "!trap <playername>"},
	{"cmd_tp", "!tp <playername>	[SU]"},
	{"cmd_clearwanted", "!clearwanted	[NOT SU]"},
	{"cmd_vehicle", "!vehicle <NAME>"},
	{"cmd_bigpp", "!bigpp <playername>"},
	{"cmd_bigppall", "!bigppall	[SU]"},
	{"cmd_vehiclegod", "!vehiclegod <on/off>"},
	{"cmd_weaponsall", "!weaponsall"}
}
local block_locations = {
	["lscs"] = {
		{"Main LSC", {
			{3291218330, {-357.45132446289, -134.30920410156, 38.53914642334}, {0, 0, -20}, true, true}, 
			{false, {-370.4, -104.72, 47}, -110.83449554443},
			}, },
		{"La Mesa LSC", {
			{3291218330, {722.9853515625, -1089.2061767578, 23.043445587158}, {0, 0, 0}, true, true}, 
			{false, {700, -1085, 24}, -100},
			}, },
		{"LSIA LSC", {
			{3291218330, {-1145.7882080078, -1991.130859375, 13.163989067078}, {0, 0, 45}, true, true},
			{false, {-1117.1, -1983.3, 23}, 104.5},
			}, },
		{"Desert LSC", {
			{3291218330, {1178.552734375, 2646.4377441406, 37.874099731445}, {0, 0, 90}, true, true},
			{false, {1182, 2673.2, 39}, 163.3},
			}, },
		{"Paleto Bay LSC", {
			{3291218330, {112.54597473145, 6619.6850585938, 31.604303359985}, {0, 0, -45}, true, true},
			{false, {140.8, 6601.9, 32}, 57},
			}, },
		{"Bennys LSC", {
			{3291218330, {-208.5591583252, -1308.7404785156, 31.718006134033}, {0, 0, 90}, true, true},
			{false, {-184.2, -1292.5, 34}, 124.3},
			}, }
	},
	["casino"] = {
		{"Entrance", {
			{3291218330, {924.69201660156, 62.243091583252, 81.21053314209}, {0, 0, 80}, true, true}, 
			{3291218330, {910.31787109375, 36.022556304932, 80.59684753418}, {0, 0, 25}, true, true}, 
			{false, {920.8, 80.5, 80}, -177},
			}, },
		{"Garage", {
			{3291218330, {932.78601074219, -2.0857257843018, 80.166107177734}, {0, 0, 60}, true, true},
			{false, {940, -21, 80}, 4.9},
			}, },
		{"Roof", {
			{3291218330, {964.02569580078, 58.947933197021, 113.34354400635}, {0, 0, -30}, true, true},
			{false, {954.8, 63.34, 114}, -124.2},
			}, }
	},
	["mazebank"] = {
		{"Entrance", {
			{3291218330, {-81.541351318359, -792.25347900391, 44.622947692871}, {0, 0, 100}, true, true}, 
			{3291218330, {-70.231819152832, -802.17694091797, 44.230716705322}, {0, 0, 0}, true, true}, 
			{false, {-55.1, -776.5, 46}, 125.4},
			}, },
		{"Garage", {
			{3291218330, {-83.269706726074, -773.02490234375, 39.806701660156}, {0, -35, 105}, true, true},
			{false, {-86.2, -762.2, 44}, -165.7},
			}, },
		{"Roof", {
			{3291218330, {-66.390617370605, -813.32702636719, 320.40509033203}, {0, 0, 60}, true, true},
			{3291218330, {-66.451454162598, -822.87298583984, 321.19717407227}, {0, 0, 100}, true, true},
			{3291218330, {-68.104598999023, -818.67510986328, 323.35980224609}, {0, 90, 0}, true, true},
			{false, {-76.6, -817.6, 328}},
			}, },
		{"Arena War", {
			{3291218330, {-371.32809448242, -1859.2064208984, 21.246929168701}, {0, 15, -75}, true, true},
			{3291218330, {-396.87942504883, -1869.1518554688, 22.718107223511}, {0, 15, -60}, true, true},
			{false, {-379.6, -1850, 23}, -166.6},
			}, }
	},
	["custom"] = ext_data.block_custom
}
local crash_peds = {
	1057201338, 2238511874, 762327283
}
local admins = {
	62409944, 64074298, 155527062, 153219155, 131037988, 141884823, 104432921, 147111499, 9284553, 114982881, 137663665, 63457, 137601710, 138075198, 123017343, 130291511,
	137851207, 137714280, 127448079, 137579070, 134412628, 133709045, 64234321, 131973478, 103019313, 103054099, 104041189, 110470958, 119266383, 119958356, 121397532, 
	121698158, 123849404, 121943600, 129159629, 18965281, 216820, 56778561, 99453545, 99453882, 88435916, 174875493
}
local entitys = {
	["bl_objects"] = {},
	["peds"] = {},
	["attach_obj"] = {},
	["asteroids"] = {},
	["lag_area"] = {},
	["custom_veh"] = {},
	["preview_veh"] = {},
	["temp_veh"] = {},
	["shooting"] = {},
	["chat_veh"] = {},
	["bodyguards"] = {},
	["bodyguards_veh"] = {},
	["robot_weapon_left"] = {},
	["robot_weapon_right"] = {},
	["vehicle_builder"] = {},
}
local outfits = {
	["police_outfit"] = {
		["female"] = {
			["clothes"] = {
				{0, 0},
				{0, 6},
				{0, 14},
				{0, 34},
				{0, 0},
				{0, 25},
				{0, 0},
				{0, 35},
				{0, 0},
				{0, 0},
				{0, 48},
			},
			["props"] = {
				{0, 45, 0},
				{1, 11, 0},
				{2, 4294967295, 0},
				{6, 4294967295, -1},
				{7, 4294967295, -1},
			}
		},
		["male"] = {
			["clothes"] = {
				{0, 0},
				{0, 0},
				{0, 0},
				{0, 35},
				{0, 0},
				{0, 25},
				{0, 0},
				{0, 58},
				{0, 0},
				{0, 0},
				{0, 55},
			},
			["props"] = {
				{0, 46, 0},
				{1, 13, 0},
				{2, 4294967295, 0},
				{6, 4294967295, -1},
				{7, 4294967295, -1},
			}
		}
	},
	["bac_outfit"] = {
		["textures"] = {},
		["clothes"] = {},
		["prop_text"] = {},
		["prop_ind"] = {},
		["gender"] = nil
	},
	["session_crash"] = {
		["textures"] = {},
		["clothes"] = {},
		["prop_text"] = {},
		["prop_ind"] = {}
	}
}
local stat = {}
stat.hashes = {
	["orbital_cannon_cd"] = {
		"ORBITAL_CANNON_COOLDOWN", 0
	},
	["snacks_and_armor"] = {
		{"NO_BOUGHT_YUM_SNACKS", 30},
		{"NO_BOUGHT_HEALTH_SNACKS", 15},
		{"NO_BOUGHT_EPIC_SNACKS", 5},
		{"NUMBER_OF_ORANGE_BOUGHT", 10},
		{"NUMBER_OF_BOURGE_BOUGHT", 10},
		{"NUMBER_OF_CHAMP_BOUGHT", 5},
		{"CIGARETTES_BOUGHT", 20},
		{"MP_CHAR_ARMOUR_1_COUNT", 10},
		{"MP_CHAR_ARMOUR_2_COUNT", 10},
		{"MP_CHAR_ARMOUR_3_COUNT", 10},
		{"MP_CHAR_ARMOUR_4_COUNT", 10},
		{"MP_CHAR_ARMOUR_5_COUNT", 10}
	},
	["kills_deaths"] = {
		"MPPLY_KILLS_PLAYERS", "MPPLY_DEATHS_PLAYER"
	},
	["fast_run"] = {
		"CHAR_FM_ABILITY_1_UNLCK", "CHAR_FM_ABILITY_2_UNLCK", "CHAR_FM_ABILITY_3_UNLCK",
		"CHAR_ABILITY_1_UNLCK", "CHAR_ABILITY_2_UNLCK", "CHAR_ABILITY_3_UNLCK"
	},
	["chc"] = {
		["misc"] = {
			{"Remove Repeat Cooldown (-1)", "H3_COMPLETEDPOSIX", 0, -1},
			{"Last Approach Completed (1 2 3)", "H3_LAST_APPROACH", 0, -1, 3},
			{"Confirm First Board", "H3OPT_BITSET1", 0, -1},
			{"Confirm Second Board", "H3OPT_BITSET0", 0, -1}
		},
		["board1"] = {
			{"1:Silent, 2:BigCon, 3:Aggressive", "H3OPT_APPROACH", 0, 1, 3, 1},
			{"1:Hard, 2:Difficulty, 3:Approach", "H3_HARD_APPROACH", 0, 1, 3, 1},
			{"0:Money, 1:Gold, 2:Art, 3:Diamond", "H3OPT_TARGET", 0, 0, 3, 3},
			{"Unlock Points of Interests", "H3OPT_POI", 0, 1023},
			{"Unlock Access Points", "H3OPT_ACCESSPOINTS", 0, 2047}
		},
		["board2"] = {
			{"1:5%, 2:9%, 3:7%, 4:10%, 5:10%", "H3OPT_CREWWEAP", 0, 1, 5, 1},
			{"1:5%, 2:7%, 3:9%, 4:6%, 5:10%", "H3OPT_CREWDRIVER", 0, 1, 5, 1},
			{"1:3%, 2:7%, 3:5%, 4:10%, 5:9%", "H3OPT_CREWHACKER", 0, 1, 5, 1},
			{"Weapon Variation (0 1)", "H3OPT_WEAPS", 0, 0, 1},
			{"Vehicle Variation (0 1 2 3)", "H3OPT_VEHS", 0, 0, 3},
			{"Remove Duggan Heavy Guards", "H3OPT_DISRUPTSHIP", 0, 3},
			{"Equip Heavy Armor", "H3OPT_BODYARMORLVL", 0, 3},
			{"Scan Card Level", "H3OPT_KEYLEVELS", 0, 2},
			{"Mask Variation (0 till 12)", "H3OPT_MASKS", 0, 0, 12}
		}
	},
	["cph"] = {
		["main"] = {
			{"Target 0-5", "H4CNF_TARGET", 5},
			{"Unlock PoI -1", "H4CNF_BS_GEN", -1},
			{"Unlock Entrances", "H4CNF_BS_ENTR", 63},
			{"Unlock Support Team", "H4CNF_BS_ABIL", 63},
			{"Weapon Variation", "H4CNF_WEAPONS", 5},
			{"Disruption 1 - Guards get weak", "H4CNF_WEP_DISRP", 3},
			{"Disruption 2 - Guards get weak", "H4CNF_ARM_DISRP", 3},
			{"Disruption 3 - Guards get weak", "H4CNF_HEL_DISRP", 3},
			{"Grappel Item", "H4CNF_GRAPPEL", -1},
			{"Uniform Item", "H4CNF_UNIFORM", -1},
			{"Boltcut Item", "H4CNF_BOLTCUT", -1},
			{"Set Preps as Completed", "H4CNF_APPROACH", -1},
			{"Set Mission as Completed", "H4_MISSIONS", -1},
			{"Cooldown NORMAL", "H4_COOLDOWN", -1},
			{"Cooldown HARD", "H4_COOLDOWN_HARD", -1},
		},
		["loot"] = {
			{"Cash", "H4LOOT_CASH_V", 21000},
			{"Weed", "H4LOOT_WEED_V", 21000},
			{"Coke", "H4LOOT_COKE_V", 21000},
			{"Gold", "H4LOOT_GOLD_V", 21000},
			{"Paint", "H4LOOT_PAINT_V", 21000}
		},
		["scope"] = {
			{"Cash Outside", "H4LOOT_CASH_I_SCOPED", -99},
			{"Cash Outside", "H4LOOT_CASH_C_SCOPED", -99},
			{"Cash Outside", "H4LOOT_WEED_I_SCOPED", -99},
			{"Cash Outside", "H4LOOT_WEED_C_SCOPED", -99},
			{"Cash Outside", "H4LOOT_COKE_I_SCOPED", -99},
			{"Cash Outside", "H4LOOT_COKE_C_SCOPED", -99},
			{"Cash Outside", "H4LOOT_GOLD_I_SCOPED", -99},
			{"Cash Outside", "H4LOOT_GOLD_C_SCOPED", -99},
			{"Cash Outside", "H4LOOT_PAINT_SCOPED", -99},
		}
	}
}
stat.set = function(hash, prefix, value, save)
	save = save or true
	local hash0, hash1 = hash
	if prefix then
		hash0 = "MP0_" .. hash
		hash1 = "MP1_" .. hash
		hash1 = gameplay.get_hash_key(hash1)
	end
	hash0 = gameplay.get_hash_key(hash0)
	local value0, e = stats.stat_get_int(hash0, -1)
	if value0 ~= value then
		stats.stat_set_int(hash0, value, save)
	end
	if prefix then
		local value1, e = stats.stat_get_int(hash1, -1)
		if value1 ~= value then
			stats.stat_set_int(hash1, value, save)
		end
	end
end

local blacklist = {}
blacklist.scids = {}
blacklist.names = {}
blacklist.update_ids = function ()
	local newIds, newNames = {}, {}
	local x
	if s.f_exists(files["Blacklist"]) then
		local sf = s.o(files["Blacklist"], "r")
		if sf then
			for line in io.lines(files["Blacklist"]) do
				x = 1
				for token in string.gmatch(line, "[^%s]+") do
					if x == 1 then
						table.insert(newIds, token)
					else
						if type(token) == "string" then
							table.insert(newNames, token)
						else
							table.insert(newNames, "NoNameFound")
						end
					end
					x = x + 1
				end
			end
		end
		io.close(sf)
		blacklist.scids = newIds
		blacklist.names = newNames
	end
end
blacklist.remove_scid = function(scid)
	local sf = s.o(files["Blacklist"], "w")
	io.close(sf)
	for i = 1, #blacklist.scids do
		local name = blacklist.names[i] or "NoNameFound"
		if s.no(blacklist.scids[i]) ~= s.no(scid) then
			u.write(s.o(files["Blacklist"], "a"), blacklist.scids[i] .. " " .. name)
		else
			n("Removed SCID: '" .. scid .. "' with Name: '" .. name .. "' from Blacklist.", 48)
		end
	end
	blacklist.update_ids()
end
blacklist.add = function(scid, name, id)
	id = id or -1
	if id ~= s.id() and scid ~= -1 and scid ~= g.scid(s.id()) and name ~= "" then
		local found = false
		for i = 1, #blacklist.scids do
			if s.no(blacklist.scids[i]) == s.no(scid) then
				found = true
			end
		end
		if not found then
			u.write(s.o(files["Blacklist"], "a"), scid .. " " .. name)
			n("Player " .. name .. " added to Blocklist.", 48)
			l("Player " .. name .. " with SCID: " .. scid .. " added to Blacklist.")
		else
			n("SCID already in the Database.")
		end
	else
		n("Choose valid Player / enter valid SCID and NAME.")
	end
end

local random_colors = {"random_primary", "random_secondary", "random_pearlescent", "random_neon", "random_smoke", "random_xenon"}
local rainbow_colors = {"rainbow_primary", "rainbow_secondary", "rainbow_pearlescent", "rainbow_neon", "rainbow_smoke", "rainbow_xenon"}
local synced_colors = {"synced_rainbow", "synced_random", "synced_rainbow_smooth"}
local health_boosts = {
	{"Max Online Health: 328", 328},
	{"Health: 100", 100},
	{"Health: 500", 500},
	{"Freemode Beast: 2500", 2500},
	{"Health: 10000", 10000},
	{"Health: 25000", 25000},
	{"Health: 50000", 50000},
	{"Health: 100000", 100000},
	{"Health: 5000000", 5000000}
}
local offset_height, config_preview, offset_distance = 0, false, 0
local rot_veh = v3()
local hash_c, crashed_session = nil, false
local modder_scids = {}
local chat_events = {}
local spm_1, spm_2
local current_sh
local remote_veh
local remote_veh_target = nil
local assassins_target
local robot_objects = {}
local gr_water, gr_height, fixed_height
local balll
local lastwaypoint
local model_gun, apply_invisible
local kick_join = {}
local kick_attempts = {}
local player_script_hooks = {}
local player_net_hooks = {}
local new_blame_kill_detection
local karma_modder_scripts
local bad_event_hook
local net_hook
local bad_net_events = {12, 13, 14, 43, 74, 78}
local weather_idiot
local weather_time
local karma_hook = nil
local ptfxs = {
	["flamethrower"] = nil,
	["flamethrower_green"] = nil,
	["alien"] = nil,
	["fire_circle"] = {},
	["fire_balls"] = {},
	["fire_ass"] = nil,
	["fire_ass_ball"] = nil,
}

local function s_coords(i, p)
	req.ctrl(i)
	entity.set_entity_velocity(i, v3())
	entity.set_entity_coords_no_offset(i, p)
end

local function clear(d, time)
	if d and type(d) == "table" then
		time = time or 50
		for i = 1, #d do
			if d[i] ~= o.ped() and d[i] ~= s.vehicle(o.ped()) then
				req.ctrl(d[i], time)
				entity.detach_entity(d[i])
				entity.set_entity_velocity(d[i], v3())
				entity.set_entity_as_no_longer_needed(d[i])
				s_coords(d[i], v3(8000, 8000, -1000))
				entity.delete_entity(d[i])
			end
		end
	end
end

local function explode_all(data, exclude)
	for i = 1, #data do
		if entity.is_an_entity(data[i]) and data[i] ~= exclude then
			local pos = s.gcoords(data[i])
			s.explode(pos, 8, true, false, 0.5, 0)
			s.explode(pos, 59, false, true, 0, 0)
			s.wait(25)
		end
	end
end

event.add_event_listener("exit", function()
	l("")
	l("2Take1Script got unloaded.")
	l("Cleaning up...")
	n("2Take1Script got unloaded.\nUnloading Script.. :(", 200)
	for i in pairs(robot_objects) do
		clear({robot_objects[i]})
	end
	for i in pairs(entitys) do
		clear(entitys[i])
	end
	clear({model_gun})
	clear({balll})
	if ptfxs["flamethrower"] then
		graphics.remove_particle_fx(ptfxs["flamethrower"], true)
	end
	if ptfxs["flamethrower_green"] then
		graphics.remove_particle_fx(ptfxs["flamethrower_green"], true)
	end
	if ptfxs["fire_circle"][1] then
		for i = 1, #ptfxs["fire_circle"] do
			graphics.remove_particle_fx(ptfxs["fire_circle"][i], true)
		end
		clear(ptfxs["fire_balls"])
	end
	if ptfxs["fire_ass"] then
		graphics.remove_particle_fx(ptfxs["fire_ass"], true)
	end
	clear({ptfxs["fire_ass_ball"]})
	for i = 1, 32 do
		if player_script_hooks[i] then
			hook.remove_script_event_hook(player_script_hooks[i])
		end
	end
	for i = 1, 32 do
		if player_net_hooks[i] then
			hook.remove_net_event_hook(player_net_hooks[i])
		end
	end
	l("Going to remove Chat-Listeners...")
	for i in pairs(chat_events) do
		event.remove_event_listener("chat", chat_events[i])
	end
	if history.event then
		event.remove_event_listener("player_join", history.event)
	end
	l("Done.")
	_2t1s = false
	_2t1sEXT = false
end)

local function tp(t, offset, h)
	l("Teleporting to Target.")
	local me, pos, veh, target_veh = o.ped()
	if type(t) == "number" then
		target_veh = s.vehicle(t)
		if target_veh ~= 0 then
			if ped.is_ped_in_any_vehicle(me) then
				ped.clear_ped_tasks_immediately(me)
				s.wait(10)
			end
		end
	end
	veh = s.vehicle(me)
	if veh ~= 0 then
		req.ctrl(veh)
		entity.set_entity_velocity(veh, v3())
		me = veh
	end
	if type(t) == "number" then pos = s.gcoords(t) else pos = t end
	if offset then pos.z = pos.z + offset end
	s_coords(me, pos)
	if h then entity.set_entity_heading(me, h) end
	if target_veh then
		s.wait(1500)
		ped.set_ped_into_vehicle(o.ped(), target_veh, vehicle.get_free_seat(target_veh))
	end
	l("Done.")
end

local function c_model(h, water, isinvisible, isdown, f_change)
	if not m.t["bl_mdl_change"].on or f_change or (m.t["bl_mdl_change"].on and not ped.is_ped_in_any_vehicle(o.ped()) and (water and entity.is_entity_in_water(o.ped()) or (not water and not entity.is_entity_in_water(o.ped())))) then
		if isdown then tp(o.coords(), 1.5) end
		req.model(h)
		player.set_player_model(h)
		s.unload(h)
		if isinvisible then
			s.wait(0)
			ped.set_ped_component_variation(o.ped(), 4, 0, 0, 2)
		end
		if m.t["revert_outfit"].on then
			if h == 0x9C9EFFD8 or h == 0x705E61F2 then
				local g = "male"
				if player.is_player_female(s.id()) then
					g = "female"
				end
				if outfits["bac_outfit"]["gender"] == g then
					local h_clothes =  outfits["bac_outfit"]["clothes"]
					local h_textures =  outfits["bac_outfit"]["textures"]
					for y = 1, 11 do
						ped.set_ped_component_variation(o.ped(), y, h_clothes[y], h_textures[y], 2)
					end
					local loop = {0, 1, 2, 6, 7}
					local h_prop_ind =  outfits["bac_outfit"]["prop_ind"]
					local h_prop_text =  outfits["bac_outfit"]["prop_text"]
					for z = 1, #loop do
						ped.set_ped_prop_index(o.ped(), loop[z], h_prop_ind[z], h_prop_text[z], 0)
					end
				end
			end
		end
	else
		n("Model Change not possible!", 125)
	end
end

local function kick_pl(lobby, id)
	local i = 0
	if lobby then l("Lobby Kick!") end
	while i < 32 do
		if lobby then id = i
		else i = 99 end
		if valid.i(id) then
			n("Attempting to Kick Player: "..g.name(id), 65)
			l("Attempting to Kick Player.")
			l(g.name(id)..":"..g.scid(id))
			if network.network_is_host() then
				l("Haha, got a hostkick.")
				network.network_session_kick_player(id)
			end
			for i = 1, #kick_events do
				s.script(kick_events[i], id, {})
			end
		end
		i = i + 1
	end
end

local function attach_entity(data, id, no_spawn)
	for i = 1, #data do
		local pos1 = v3(data[i][3][1], data[i][3][2], data[i][3][3])
		local pos2 = v3(data[i][4][1], data[i][4][2], data[i][4][3])
		local temp
		local is_ped = false
		if no_spawn then
			temp = data[i][1]
		else
			req.model(data[i][1])
			if streaming.is_model_an_object(data[i][1]) then
				temp = spawn.object(data[i][1], pos1)
			else
				is_ped = true
				temp = spawn.ped(data[i][1], pos1)
				s.wait(0)
				ped.set_ped_can_ragdoll(temp, false)
				s.god(temp, true)
			end
			s.unload(data[i][1])
		end
		entitys["attach_obj"][#entitys["attach_obj"] + 1] = temp
		if m.t["attach_no_colision"].on then
			entity.set_entity_collision(temp, false, false, false)
		end
		if data[i][5] then
			s.visible(temp, false)
		end
		s.attach(temp, s.ped(id), data[i][2], pos1, pos2, true, true, is_ped, 0, true)
	end
end

local function lag_area(id, h)
	l("Lagging Area @Player.")
	local pos = s.gcoords(s.ped(id))
	req.model(h)
	pos.z = pos.z + 5
	for i = 1, 50 do
		entitys["lag_area"][#entitys["lag_area"] + 1] = spawn.vehicle(h, pos)
	end
	s.unload(h)
	l("Done.")
end

local function upgrade_veh(veh)
	local modindex = {11, 12, 13, 16, 18}
	local modtype =  { 3,  2,  2,  4,  1}
	for i = 1, #modindex do
		if vehicle.get_vehicle_mod(veh, modindex[i]) ~= modtype[i] then
			req.ctrl(veh)
			vehicle.set_vehicle_mod(veh, modindex[i], modtype[i])
		end
	end
	vehicle.set_vehicle_bulletproof_tires(veh, true)
end

local function OffsetCoords(pos, heading, distance)
	heading = math.rad((heading - 180) * -1)
	pos.x = pos.x + (math.sin(heading) * -distance)
	pos.y = pos.y + (math.cos(heading) * -distance)
	return pos
end

local function id_from_name(id)
	id = string.lower(id)
	local name
	for i = 0, 31 do
		if g.scid(i) ~= -1 then
			name = string.lower(g.name(i))
			if name == id then
				return i
			end
		end 
	end
	return -1
end

local function toggle_off(str_feat)
	for i = 1, #str_feat do
		if m.t[str_feat[i]].on then
			m.t[str_feat[i]].on = false
		end
	end
end

local function color_veh(veh, c, i, x)
	req.ctrl(veh)
	s.wait(0)
	vehicle.set_vehicle_tire_smoke_color(veh, c[1], c[2], c[3])
	vehicle.set_vehicle_custom_primary_colour(veh, u.rgbtohex({c[1], c[2], c[3]}))
	vehicle.set_vehicle_custom_secondary_colour(veh, u.rgbtohex({c[1], c[2], c[3]}))
	vehicle.set_vehicle_custom_pearlescent_colour(veh, u.rgbtohex({c[1], c[2], c[3]}))
	vehicle.set_vehicle_neon_lights_color(veh, u.rgbtohex({c[1], c[2], c[3]}))
	if not i then i = 0 end
	if c[1] > 200 and c[1] < 256 and c[2] > 200 and c[2] < 256 and c[3] > 220 and c[3] < 256 then i = 0 end
	if c[1] >= 0 and c[1] < 30 and c[2] >= 0 and c[2] < 50 and c[3] > 220 and c[3] < 256 then i = 1 end
	if c[1] >= 0 and c[1] < 30 and c[2] >= 50 and c[2] < 110 and c[3] > 220 and c[3] < 256 then i = 2 end
	if c[1] >= 0 and c[1] < 30 and c[2] >= 110 and c[2] < 256 and c[3] > 100 and c[3] <= 220  then i = 3 end
	if c[1] >= 30 and c[1] < 120 and c[2] >= 110 and c[2] < 256 and c[3] >= 0 and c[3] <= 100 then i = 4 end
	if c[1] >= 120 and c[1] < 256 and c[2] >= 110 and c[2] < 256 and c[3] >= 0 and c[3] < 100 then i = 5 end
	if c[1] >= 120 and c[1] < 256 and c[2] >= 110 and c[2] < 200 and c[3] >= 0 and c[3] < 100 then i = 6 end
	if c[1] >= 120 and c[1] < 256 and c[2] > 45 and c[2] < 109 and c[3] >= 0 and c[3] < 100 then i = 7 end
	if c[1] >= 120 and c[1] < 256 and c[2] >= 0 and c[2] <= 45 and c[3] >= 0 and c[3] < 100 then i = 8 end
	if c[1] >= 120 and c[1] < 256 and c[2] > 45 and c[2] < 100 and c[3] >= 50 and c[3] < 150 then i = 9 end
	if c[1] >= 120 and c[1] < 256 and c[2] >= 0 and c[2] <= 45 and c[3] >= 150 and c[3] < 256 then i = 10 end
	if c[1] >= 0 and c[1] < 120 and c[2] >= 0 and c[2] <= 45 and c[3] >= 150 and c[3] < 256 then i = 11 end
	if c[1] >= 0 and c[1] < 30 and c[2] >= 0 and c[2] <= 45 and c[3] >= 150 and c[3] < 256 then i = 12 end
	if x then i = x end
	vehicle.set_vehicle_headlight_color(veh, i)
end

local function is_entitled(id, target, cmd)
	l("Detected Chat-Command!")
	l(g.name(id)..":"..g.scid(id))
	l("Is trying to perform "..cmd.." as a Chat-Command!")
	if m.t["chat_cmd_friends"] and player.is_player_friend(id) or id == s.id() or m.t["chat_cmd_all"] then
		local pl_id
		if target then
			pl_id = id_from_name(target)
		else
			l("User is entitled to perfrom Command! Executing...")
			n("Performing ".. cmd .. " Command for Player: "..g.name(id).." on: "..g.name(id))
			return true, plid
		end
		if pl_id ~= -1 then
			if pl_id == s.id() or (player.is_player_friend(pl_id) and m.t["exclude_friends"].on and pl_id ~= s.id()) then
				n(g.name(id).." tried to perform a Command on you or a friend!")
				l("Blocked from Performing Command!")
				return false
			else
				l("User is entitled to perfrom Command! Executing...")
				n("Performing ".. cmd .. " Command for Player: "..g.name(id).." on: "..g.name(pl_id))
				return true, pl_id
			end
		end
	end
	l("Command / format / player not found / entitled. Breaking up on performing it.")
	return false
end

local function block_area(data)
	l("Blocking Area.")
	for i = 1, #data do
		if data[i][1] ~= false then
			req.model(data[i][1])
			entitys["bl_objects"][#entitys["bl_objects"] + 1] = spawn.object(data[i][1])
			s.unload(data[i][1])
			local pos
			if not data[i][2][1] then
				pos = v3(s.random(data[i][2][2], data[i][2][3]), s.random(data[i][2][4], data[i][2][5]), s.random(data[i][2][6], data[i][2][7]))
			else
				pos = v3(data[i][2][1], data[i][2][2], data[i][2][3])
			end
			s_coords(entitys["bl_objects"][#entitys["bl_objects"]], pos)
			entity.set_entity_rotation(entitys["bl_objects"][#entitys["bl_objects"]], v3(data[i][3][1], data[i][3][2], data[i][3][3]))
			if data[i][4] then entity.freeze_entity(entitys["bl_objects"][#entitys["bl_objects"]], true) end
			if data[i][5] then s.visible(entitys["bl_objects"][#entitys["bl_objects"]], false) end
		else
			if data[i] then
				if m.t["teleport_to_block"].on then
					tp(v3(data[i][2][1], data[i][2][2], data[i][2][3]), nil, data[i][3])
				end
			end
		end
	end
	l("Blocking Done.")
end

local function send_se(lobby, se1, param1, se2, param2, id)
	l("Sending Script Events to Player.")
	local i = 0
	while i < 32 do
		if lobby then id = i else i = 99 end
		if valid.i(id) then
			if se1 ~= 0 and se1 then
				s.script(se1, id, param1)
				l("SE 1 : "..se1)
				l("Sent to Player: "..g.name(id))
			end
			if se2 ~= 0 and se2 then
				s.script(se2, id, param2)
				l("SE 2 : "..se2)
				l("Sent to Player: "..g.name(id))
			end
		end
		i = i + 1
	end
	l("Done.")
end

local function fix_screen_after_crash()
	if crashed_session then
		c_model(hash_c, nil, nil, nil, true)
		s.wait(250)
		ped.set_ped_health(o.ped(), 0)
		s.wait(3500)
		local clothes = outfits["session_crash"]["clothes"]
		local textures = outfits["session_crash"]["textures"]
		for i = 1, 11 do
			ped.set_ped_component_variation(o.ped(), i, clothes[i], textures[i], 2)
		end
		local loop = {0, 1, 2, 6, 7}
		local h_prop_ind = outfits["session_crash"]["prop_ind"]
		local h_prop_text = outfits["session_crash"]["prop_text"]
		for z = 1, #loop do
			ped.set_ped_prop_index(o.ped(), loop[z], h_prop_ind[z], h_prop_text[z], 0)
		end
	else
		n("First Crash Session.")
	end
end

local function clear_legs_movement()
	local left = robot_objects["llbone"]
	local right = robot_objects["rlbone"]
	local main = robot_objects["tampa"]
	local offsetL = v3(-4.25, 0, 12.5)
	local offsetR = v3(4.25, 0, 12.5)
	if left and right and main then
		if entity.is_an_entity(left) and entity.is_an_entity(right) and entity.is_an_entity(main) then
			req.ctrl(left)
			req.ctrl(right)
			req.ctrl(main)
			s.attach(left, main, 0, offsetL, v3(), true, settings["robot_collision"], false, 2, true)
			s.attach(right, main, 0, offsetR, v3(), true, settings["robot_collision"], false, 2, true)
		end
	end
end

local function spawn_custom_vehicle(data, place)
	l("Attempt to spawn Custom Vehicle.")
	s.navigate(false)
	temp_veh = {}
	local pos = v3()
	local rot = v3()
	local BONE_ID = 0
	local attach_to = 0
	local heading = 0
	local skip_upg = false
	local cur_veh = s.vehicle(o.ped())
	if m.t["spawn_preview"].on and entitys["preview_veh"][1] then
		clear(entitys["preview_veh"])
		entitys["preview_veh"] = {}
		config_preview = false
		s.wait(250)
	end
	for i = 1, #data[1] do
		req.model(data[1][i], 7500)
	end
	for i = 2, #data do
		pos = o.coords()
		if data[i][6] and i == 2 then pos.z = pos.z + data[i][6] end
		if i > 2 then pos.z = pos.z + 25 end
		if m.t["use_own_veh"].on and i == 2 and entity.get_entity_model_hash(cur_veh) == data[i][1] or data[2][1] == 0 and i == 2 and m.t["use_own_veh"].on and cur_veh ~= 0 then
			l("Detected Own Vehicle, using it.")
			temp_veh[i-1] = cur_veh
			skip_upg = true
		elseif data[2][1] == 0 and not m.t["use_own_veh"].on then
			l("Failed at spawning Custom Vehicle.")
			n("No Vehicle found, get in a valid Vehicle")
			s.navigate(true)
			return
		else
			if streaming.is_model_a_vehicle(data[i][1]) then
				if i == 2 then
					heading = o.heading()
					if data[i][11] then offset_distance = data[i][11] else offset_distance = 5 end
					if data[i][12] then offset_height = data[i][12] else offset_height = 1 end
					pos = OffsetCoords(pos, heading, offset_distance)
				end
				temp_veh[i-1] = spawn.vehicle(data[i][1], pos, heading)
				decorator.decor_set_int(temp_veh[i-1], "MPBitset", 1 << 10)
				local color = s.random(0, 16777215)
				if data[i][4] then color = data[i][4][1] end
				vehicle.set_vehicle_custom_primary_colour(temp_veh[i-1], color)
				if data[i][4] then color = data[i][4][2] end
				vehicle.set_vehicle_custom_secondary_colour(temp_veh[i-1], color)
				if data[i][4] then color = data[i][4][3] end
				vehicle.set_vehicle_custom_pearlescent_colour(temp_veh[i-1], color)
				if data[i][4] then color = data[i][4][4] end
				vehicle.set_vehicle_custom_wheel_colour(temp_veh[i-1], color)
				color = s.random(0, 4)
				if data[i][4] then color = data[i][4][5] end
				vehicle.set_vehicle_window_tint(temp_veh[i-1], color)
				if streaming.is_model_a_plane(data[i][1]) and i > 2 then
					vehicle.control_landing_gear(temp_veh[i-1], 3)
				end
			else
				temp_veh[i-1] = spawn.object(data[i][1], pos)
			end
		end
		if i > 2 then pos.z = pos.z - 25 end
		if m.t["set_godmode"].on then s.god(temp_veh[i-1], true) end
		if data[i][5] then s.visible(temp_veh[i-1], false) end
		if data[i][13] then entity.set_entity_alpha(temp_veh[i-1], data[i][13], false) end
		if i > 2 then
			BONE_ID = 0
			if data[i][7] then BONE_ID = data[i][7] end
			attach_to = temp_veh[1]
			if data[i][8] then attach_to = temp_veh[data[i][8]] end
			local set_collision = data[i][10]
			if set_collision == true then entity.set_entity_collision(temp_veh[i-1], false, false, false) else set_collision = false end
			pos = v3()
			if data[i][2] then pos = v3(data[i][2][1], data[i][2][2], data[i][2][3]) end
			rot = v3()
			if data[i][3] then rot = v3(data[i][3][1], data[i][3][2], data[i][3][3]) end
			if data[i][1] ~= 0 then
				s.attach(temp_veh[i-1], attach_to, BONE_ID, pos, rot, false, not set_collision, false, 2, true)
			end
			if data[i][9] then
				local spawned_ped
				req.model(data[i][9])
				pos = o.coords()
				spawned_ped = spawn.ped(data[i][9], pos)
				s.wait(0)
				if m.t["set_godmode"].on then
					ped.set_ped_max_health(spawned_ped, 25000000.0)
					ped.set_ped_health(spawned_ped, 25000000.0)
					ped.set_ped_can_ragdoll(spawned_ped, false)
					s.god(spawned_ped, true)
				end
				s.unload(data[i][9])
				if data[i][1] ~= 0 then
					ped.set_ped_into_vehicle(spawned_ped, temp_veh[i-1], -1)
					vehicle.set_vehicle_doors_locked(temp_veh[i-1], 2)
				else
					pos = v3()
					if data[i][2] then pos = v3(data[i][2][1], data[i][2][2], data[i][2][3]) end
					rot = v3()
					if data[i][3] then rot = v3(data[i][3][1], data[i][3][2], data[i][3][3]) end
					s.attach(spawned_ped, attach_to, BONE_ID, pos, rot, false, not set_collision, true, 2, true)
				end
				
			end
		end
		if m.t["spawn_preview"].on then
			entitys["preview_veh"][#entitys["preview_veh"] + 1] = temp_veh[i-1]
		elseif place then
			entitys[place][#entitys[place] + 1] = temp_veh[i-1]
		else
			entitys["custom_veh"][#entitys["custom_veh"] + 1] = temp_veh[i-1]
		end
	end
	if not m.t["spawn_preview"].on then
		if m.t["auto_get_in"].on then
			ped.set_ped_into_vehicle(o.ped(), temp_veh[1], -1)
			vehicle.set_vehicle_engine_on(temp_veh[1], true, true, false)
		end
	end
	if not skip_upg then
		upgrade_veh(temp_veh[1])
	end
	for i = 1, #data[1] do
		s.unload(data[1][i])
	end
	s.navigate(true)
	l("Spawn Custom Vehicle Done.")
end

local function _2t1sf()
	l("Loading Features...")
	if settings["2t1s_parent"] then m.p["parent"] = m.add.p("2Take1Script", 0).id end
	m.p["bl"] = m.add.p("Blacklist", m.p["parent"])
		m.p["bl"].hidden = settings["bl_hidden"]
		m.p["bl"] = m.p["bl"].id
		m.t["blacklist_enabled"] = m.add.t("Enable Blacklist", m.p["bl"], function (f)
			settings["blacklist_enabled"] = f.on
			if f.on then
				s.wait(1000)
				blacklist.update_ids()
				for i = 0, 31 do
					if valid.i(i) then
						for entry = 1, #blacklist.scids do
							if tostring(g.scid(i)) == blacklist.scids[entry] then
								local name = g.name(i)
								n("Blocked player detected.", 27)
								n("Current name: "..name.."\nReal name: "..blacklist.names[entry], 27)
								l("")
								l("Blocked Player detected.")
								l(name..":"..blacklist.scids[entry])
								l("Real name:"..blacklist.names[entry])
								if m.t["mark_modder"].on then
									player.set_player_as_modder(i, modder_flags["blacklist"][2])
								end
								if m.t["auto_kick"].on then
									kick_pl(false, i)
									s.wait(1000)
								end
							end
						end
					end
				end
			end
			return u.stop(f)
			end)
			m.t["blacklist_enabled"].on = settings["blacklist_enabled"]
		m.t["auto_kick"] = m.add.t("Enable Auto-Kick", m.p["bl"], function (f)
			settings["auto_kick"] = f.on
			end)
			m.t["auto_kick"].on = settings["auto_kick"]
		m.t["mark_modder"] = m.add.t("Mark as Modder", m.p["bl"], function (f)
			settings["mark_modder"] = f.on
			end)
			m.t["mark_modder"].on = settings["mark_modder"]
		m.add.a("Add player by SCID", m.p["bl"], function ()
			local scid = g.input("Enter SCID", 12, 3)
			local name = g.input("Enter Name")
			if not scid or not name then
				return HANDLER_POP
			end
			blacklist.add(scid, name)
			end)
		m.add.a("Remove SCID", m.p["bl"], function()
			local scid = g.input("Enter SCID", 12, 3)
			if not scid then
				return HANDLER_POP
			end
			blacklist.remove_scid(scid)
			end)
		m.add.a("Count Currently Blocked Players", m.p["bl"], function ()
			blacklist.update_ids()
			if blacklist.scids then
				n("Currently blocking "..#blacklist.scids.." Players.", 48)
			end
			end)
		m.t["enable_admin"] = m.add.t("Notify on Rockstar Admin SCID", m.p["bl"], function (f)
			if f.on then
				s.wait(1000)
				for i = 0, 31 do
					if valid.i(i) then
						for entry = 1, #admins do
							if tostring(g.scid(i)) == admins[entry] then
								local name = g.name(i)
								n("Rockstar Admin by SCID detected!\nName: "..name, 27)
								l("Rockstar Admin detected.")
								l(name..":"..g.scid(i))
								if m.t["kick_admin"].on then
									kick_pl(false, i)
								end
							end
						end
					end
				end
			end
			settings["admin_enabled"] = f.on
			return u.stop(f)
			end)
			m.t["enable_admin"].on = settings["admin_enabled"]
		m.t["kick_admin"] = m.add.t("Enable Auto-Kick Rockstar Admin", m.p["bl"], function ()
			n("Thats the stupidest idea you ever had! Dont enable it, disable it!\nThis will get u banned for like 99%!", 27)
			end)
		m.t["kick_admin"].hidden = not ext_data.enable_admin
		m.t["kick_joining"] = m.add.t("Kick new joining Players", m.p["bl"], function (f)
			if f.on then
				local time = s.time() + 2500
				while time > s.time() do
					s.wait(250)
					settings["kick_joining"] = f.on
				end
				if kick_join[1] == nil then
					for i = 0, 31 do
						kick_join[i+1] = g.scid(i)
						kick_attempts[g.scid(i)] = 0
					end
				end
				for i = 0, 31 do
					if valid.i(i) then
						local kick = true
						for y = 1, #kick_join do
							if kick_join[y] == g.scid(i) then
								kick = false
							end
						end
						if kick then
							if kick_attempts[kick_join[i+1]] <= 3 then
								n(g.name(i).." is new here, sending greetings..!", 65)
								l(g.name(i).." is new here, sending greetings..!")
								kick_pl(false, i)
								kick_attempts[kick_join[i+1]] = kick_attempts[kick_join[i+1]] + 1
							else
								kick_attempts[kick_join[i+1]] = kick_attempts[kick_join[i+1]] + 1
								if kick_attempts[kick_join[i+1]] >= 17 then
									kick_attempts[kick_join[i+1]] = 0
								end
							end
						end
					end
				end
			end
			if not f.on then
				kick_attempts = {}
				for i = 0, 31 do
					kick_join[i+1] = nil
				end
			end
			settings["kick_joining"] = f.on
			return u.stop(f)
			end)
			m.t["kick_joining"].on = settings["kick_joining"]
	m.p["modder"] = m.add.p("Modders", m.p["parent"])
		m.p["modder"].hidden = settings["modder_hidden"]
		m.p["modder"] = m.p["modder"].id
		m.t["remember_modder"] = m.add.t("Remember every Modder", m.p["modder"], function (f)
			if f.on then
				if s.f_exists(files["Modders"]) then
					local sf = s.o(files["Modders"], "r")
					if sf then
						local temp = {}
						modder_scids = {}
						for r in io.lines(files["Modders"]) do
							while string.find(r, " ", 1) do
								r = r:gsub("(.*)%s.*$","%1")
							end
							temp[#temp + 1] = r
						end
						modder_scids = temp
						io.close(sf)
					end
				end
				for i = 0, 31 do
					if valid.i(i) then
						local scid = g.scid(i)
						local listed = false
						if modder_scids[1] then
							for ii = 1, #modder_scids do
								if tostring(scid) == modder_scids[ii] then
									listed = true
									if not player.is_player_modder(i, -1) then
										n("Remembered "..g.name(i).." as a Modder, remarking...", 130)
										l("Remembered '"..g.name(i).."' as a Modder, remarking...")
										player.set_player_as_modder(i, modder_flags["remembered"][2])
									end
								end
							end
						end
						if player.is_player_modder(i, -1) and not listed then
							u.write(s.o(files["Modders"], "a"), scid.." "..g.name(i))
							n("Modder "..g.name(i).." added to Remember-List.", 130)
							l("Modder '"..g.name(i).."' added to Remember-List.")
						end
					end
				end
			end
			settings["remember_modder"] = f.on
			return u.stop(f)
			end)
			m.t["remember_modder"].on = settings["remember_modder"]
		m.p["karma_modder_scripts"] = m.add.t("Karma Scripts from Modders", m.p["modder"], function (f)
			if f.on and karma_modder_scripts == nil then
				karma_modder_scripts = hook.register_script_event_hook(function (source, target, params, count)
					if player.is_player_modder(source, -1) then
						local cse = params[1]
						table.remove(params, 1)
						s.script(cse, source, params)
						l("Karma'd Script Event from: " .. g.name(source) .. ".")
					end
					end)
			end
			if not f.on and karma_modder_scripts then
				hook.remove_script_event_hook(karma_modder_scripts)
				karma_modder_scripts = nil
			end
			settings["karma_modder_scripts"] = f.on
			end)
			m.p["karma_modder_scripts"].on = settings["karma_modder_scripts"]
		m.p["unmark_friends"] = m.add.t("Unmark Friends", m.p["modder"], function (f)
			settings["unmark_friends"] = f.on
			if f.on then
				for i = 0, 31 do
					if s.valid(i) and player.is_player_friend(i) and player.is_player_modder(i, -1) then
						player.unset_player_as_modder(i, -1)
					end
				end
				s.wait(250)
			end
			return u.stop(f)
			end)
			m.p["unmark_friends"].on = settings["unmark_friends"]
		m.add.a("Mark all as Modders", m.p["modder"], function()
			for i = 0, 31 do
				if valid.i(i) then
					player.set_player_as_modder(i, 1)
				end
			end
			end)
		m.add.a("UN-Mark all as Modders", m.p["modder"], function()
			for i = 0, 31 do
				if valid.i(i, true) then
					player.unset_player_as_modder(i, -1)
				end
			end
			end)
		m.add.a("Modder-Detection:", m.p["modder"])
		m.t["speed_bypass"] = m.add.t("Max-Speed-Bypass", m.p["modder"], function (f)
			if f.on then
				for i = 0, 31 do
					local scid = g.scid(i)
					if valid.modder(i) and player.get_player_health(i) ~= 0 and interior.get_interior_from_entity(s.ped(i)) == 0 then
						local maxspeed = 45
						local id = s.ped(i)
						if ai.is_task_active(id, 403) or ai.is_task_active(id, 408) or ai.is_task_active(id, 335) or ai.is_task_active(id, 2) or ai.is_task_active(id, 422) then
							maxspeed = 95
						end
						if ai.is_task_active(id, 97) or ai.is_task_active(id, 38) or ai.is_task_active(id, 160) then
							maxspeed = 60
						end
						if ai.is_task_active(id, 50) or ai.is_task_active(id, 1) then
							maxspeed = 100
						end
						local veh = s.vehicle(id)
						if veh ~= 0 then
							if id == vehicle.get_ped_in_vehicle_seat(veh, -1) then
								id = veh
								local hash = entity.get_entity_model_hash(veh)
								if streaming.is_model_a_plane(hash) then
									maxspeed = 170
								else
									maxspeed = 100
								end
							end
						end
						local speed = entity.get_entity_speed(id)
						speed = math.floor(speed)
						if speed > maxspeed then
							n(g.name(i).." bypassed Max-Speed-Limit of: "..maxspeed.." with a speed of: "..speed.."\nMarking him as a Modder...", 130)
							l(g.name(i).." bypassed Max-Speed-Limit of: "..maxspeed.." with a speed of: "..speed)
							l("Marking him as a Modder...")
							for ii = 0, 600 do
								if ai.is_task_active(s.ped(i), ii) then l("Current active Task: "..ii) end
							end
							player.set_player_as_modder(i, modder_flags["maxspeed"][2])
						end
					end
				end
			end
			settings["speed_bypass"] = f.on
			return u.stop(f)
			end)
			m.t["speed_bypass"].on = settings["speed_bypass"]
		m.t["name_bypass"] = m.add.t("Illegal Name", m.p["modder"], function (f)
			s.wait(500)
			if f.on then
				for i = 0, 31 do
					local scid = g.scid(i)
					if valid.modder(i) then
						local name = g.name(i)
						if string.len(name) < 6 or string.len(name) > 16 or not string.find(name, "^[%.%-%w_]+$") then
							n(name.." has an illegal name!\nMarking him as a Modder...", 130)
							l(name.." has an illegal name!")
							l("Marking him as a Modder...")
							player.set_player_as_modder(i, modder_flags["illegalname"][2])
						end
					end
				end
			end
			settings["name_bypass"] = f.on
			return u.stop(f)
			end)
			m.t["name_bypass"].on = settings["name_bypass"]
		m.t["modded_scid"] = m.add.t("Modded SCID", m.p["modder"], function (f)
			if f.on then
				for i = 0, 31 do
					system.wait(25)
					if valid.modder(i) then
						local scid = g.scid(i)
						if scid < 10000 or scid > 222222222 then
							local name = g.name(i)
							n(name.." has a modded SCID!\nMarking him as a Modder...", 130)
							l(name.." has a modded SCID!")
							l("Marking him as a Modder...")
							player.set_player_as_modder(i, modder_flags["moddedscid"][2])
						end
					end
				end
			end
			settings["modded_scid"] = f.on
			return u.stop(f)
			end)
			m.t["modded_scid"].on = settings["modded_scid"]
		m.t["modded_net_events"] = m.add.t("Modded Net-Events", m.p["modder"], function ()
			if net_hook == nil then
				net_hook = hook.register_net_event_hook(function (source, target, eventId)
					if valid.modder(source) and target == s.id() then
						local guilty = false
						for i = 1, #bad_net_events do
							if eventId == bad_net_events[i] then
								guilty = true
							end
						end
						if eventId == 9 and not player.is_player_host(source) then
							guilty = true
						end
						if eventId == 10 and weather_idiot == nil then
							weather_idiot = source
							weather_time = s.time()
							guilty = true
						end
						if weather_time then
							if weather_time + 30000 < s.time() then
								weather_time = nil
								weather_idiot = nil
							end
						end
						if guilty then
							n(g.name(source).." sent a Bad Net-Event: "..mapper.net.GetEventName(eventId), 130)
							n("Marking him as a Modder!", 130)
							l(g.name(source).." sent a Bad Net-Event: "..mapper.net.GetEventName(eventId))
							player.set_player_as_modder(source, modder_flags["moddednetevent"][2])
							return true
						end
					end
					end)
			else
				hook.remove_net_event_hook(net_hook)
				net_hook = nil
			end
			settings["modded_net_events"] = m.t["modded_net_events"].on
			end)
			m.t["modded_net_events"].on = settings["modded_net_events"]
		m.t["blame_killing"] = m.add.t("Explosion based blame killing (WIP)", m.p["modder"], function(f)
			if not new_blame_kill_detection then
				new_blame_kill_detection = hook.register_net_event_hook(function(source, target, eventId)
					if eventId == 17 and valid.modder(source) and target == s.id() then
						local players_dead = {}
						for i = 0, 31 do
							if valid.i(i, true) then
								if entity.is_entity_dead(s.ped(i)) or player.get_player_health(i) == 0 then
									players_dead[#players_dead + 1] = i
								end
							end
						end
						local guilty = {}
						if #players_dead > 5 then
							for i = 1, #players_dead do
								if s.gcoords(s.ped(players_dead[i])):magnitude(s.gcoords(s.ped(source))) > 100 then
									guilty[#guilty + 1] = true
								end
							end
						end
						if #guilty > 3 then
							n("Detected '" .. g.name(source) .. "' blame killing other people!", 130)
							l("Detected '" .. g.name(source) .. "' blame killing other people!")
							player.set_player_as_modder(source, modder_flags["blame_killing"][2])
						end
					end
					players_dead = {}
					end)
			else
				hook.remove_net_event_hook(new_blame_kill_detection)
				new_blame_kill_detection = nil
			end
			settings["blame_killing"] = f.on
			end)
			m.t["blame_killing"].on = settings["blame_killing"]
		m.t["modded_script_event"] = m.add.t("Modded Script Event", m.p["modder"], function(f)
			settings["modded_script_event"] = f.on
			if bad_event_hook == nil then
				bad_event_hook = hook.register_script_event_hook(function(source, target, params, count)
					local guilty = false
					if #params > 1 then
						if source ~= params[2] then
							guilty = true
						end
					else
						guilty = true
					end
					if guilty then
						n("Detected '" .. g.name(source) .. "' sending a modded Script Event!", 130)
						l("Detected '" .. g.name(source) .. "' sending a modded Script Event!")
						local se = params[1] .. ", {"
						for i = 2, #params do
							se = se .. params[i]
							if i ~= #params then
								se = se .. ", "
							end
						end
						se = se .. "}"
						l(se)
						player.set_player_as_modder(source, modder_flags["script"][2])
					end
				end)
			else
				hook.remove_script_event_hook(bad_event_hook)
				bad_event_hook = nil
			end
			end)
			m.t["modded_script_event"].on = settings["modded_script_event"]
	m.p["lobby"] = m.add.p("Lobby", m.p["parent"])
		m.p["lobby"].hidden = settings["lobby_hidden"]
		m.p["lobby"] = m.p["lobby"].id
		m.p["bl_veh"] = m.add.p("Block Vehicles in Session", m.p["lobby"]).id
			m.t["veh_blacklist"] = m.add.t("Activate Block Vehicles", m.p["bl_veh"], function (f)
				settings["veh_blacklist"] = f.on
				if f.on then
					local time = s.time() + 2000
					while time > s.time() do
						s.wait(200)
						settings["veh_blacklist"] = f.on
					end
					for i = 0, 31 do
						if valid.i(i) then
							local veh = s.vehicle(s.ped(i))
							if veh ~= 0 then
								veh = entity.get_entity_model_hash(veh)
								for x = 1, #bl_veh do
									if m.t[bl_veh[x][1]].on and veh == bl_veh[x][2] then
										l("Detected Blacklisted Vehicle "..bl_veh[x][1].." in Session!")
										veh = s.vehicle(s.ped(i))
										req.ctrl(veh, 100)
										if entity.get_entity_god_mode(veh) then
											req.ctrl(veh)
											s.god(veh, false)
										end
										if not entity.get_entity_god_mode(veh) then
											l("Exploding User: "..g.name(i))
											n("Detected Blacklisted Vehicle "..bl_veh[x][1].." from user: "..g.name(i)..", exploding it!", 28)
											entity.set_entity_velocity(veh, v3())
											vehicle.set_vehicle_forward_speed(veh, 0)
											vehicle.set_vehicle_out_of_control(veh, false, true)
											s.explode(s.gcoords(s.ped(i)), 59, false, true, 1, s.ped(i))
										end
									end
								end
							end
						end
					end
				end
				return u.stop(f)
				end)
				m.t["veh_blacklist"].on = settings["veh_blacklist"]
			for i = 1, #bl_veh do
				m.t[bl_veh[i][1]] = m.add.t("Block: "..bl_veh[i][1], m.p["bl_veh"], function (f) settings[bl_veh[i][1]] = f.on end)
					m.t[bl_veh[i][1]].on = settings[bl_veh[i][1]]
			end
		m.p["bl_area"] = m.add.p("Block Areas", m.p["lobby"]).id
			m.t["teleport_to_block"] = m.add.t("Teleport to Block", m.p["bl_area"], function (f) settings["teleport_to_block"] = f.on end)
				m.t["teleport_to_block"].on = settings["teleport_to_block"]
			m.add.a("Clear blocking Objects", m.p["bl_area"], function ()
				clear(entitys["bl_objects"])
				entitys["bl_objects"] = {}
				end)
			m.p["bl_area_lsc"] = m.add.p("Block LSCs", m.p["bl_area"]).id
				for i = 1, #block_locations["lscs"] do
					m.add.a(block_locations["lscs"][i][1], m.p["bl_area_lsc"], function ()
						block_area(block_locations["lscs"][i][2])
					end)
				end
			m.p["bl_area_casino"] = m.add.p("Block Casino", m.p["bl_area"]).id
				for i = 1, #block_locations["casino"] do
					m.add.a(block_locations["casino"][i][1], m.p["bl_area_casino"], function ()
						block_area(block_locations["casino"][i][2])
					end)
				end
			m.p["bl_area_mazebank"] = m.add.p("Block Maze Bank", m.p["bl_area"]).id
				for i = 1, #block_locations["mazebank"] do
					m.add.a(block_locations["mazebank"][i][1], m.p["bl_area_mazebank"], function ()
						block_area(block_locations["mazebank"][i][2])
					end)
				end
			m.p["bl_area_custom"] = m.add.p("Custom Areas", m.p["bl_area"]).id
				for i = 1, #block_locations["custom"] do
					m.add.a(block_locations["custom"][i][1], m.p["bl_area_custom"], function ()
						block_area(block_locations["custom"][i][2])
					end)
				end	
		m.p["explode"] = m.add.p("Explosion-Features", m.p["lobby"]).id
			m.t["laser_beam_explode_waypoint"] = m.add.a("Laser Beam Explode Waypoint", m.p["explode"], function ()
				local wp = ui.get_waypoint_coord()
				if wp.x ~= 16000 then
					local maxz = s.gcoords(o.ped()).z + 175
					for i = maxz, -50, -2 do
						local pos = v3(wp.x, wp.y, i)
						pos.x = math.floor(pos.x)
						pos.y = math.floor(pos.y)
						s.explode(pos, 59, true, false, 0, 0)
						for x = 1, 2 do
							pos.x = s.random(pos.x - 3, pos.x + 3)
							pos.y = s.random(pos.y - 3, pos.y + 3)
							s.explode(pos, 59, true, false, 0, 0)
						end
						pos.x = s.random(pos.x - 6, pos.x + 6)
						pos.y = s.random(pos.y - 6, pos.y + 6)
						s.explode(pos, 8, true, false, 0, 0)
						s.wait(0)
					end
				else
					n("No Waypoint found, set a waypoint first!")
				end
				end)
			m.t["explode_lobby"] = m.add.u("Random Explosions", "value_i", m.p["explode"], function (f)
				if f.on then
					for i = 1, 5 do
						s.explode(v3(s.random(-2700, 2700), s.random(-3300, 7500), s.random(30, 90)), f.value_i, true, false, 0, 0)
					end
				end
				settings["explode_lobby_value"] = f.value_i
				settings["explode_lobby"] = f.on
				return u.stop(f)
				end)
				m.t["explode_lobby"].max_i   = 74
				m.t["explode_lobby"].min_i   = 0
       			m.t["explode_lobby"].value_i = settings["explode_lobby_value"]
       			m.t["explode_lobby"].on = settings["explode_lobby"]
			m.t["explode_lobby_shake"] = m.add.t("Shake Cam", m.p["explode"], function (f)
				if f.on then
					local pos = v3()
					for i = 1, 10 do
						pos.x = s.random(-2700, 2700)
						pos.y = s.random(-3300, 7500)
						pos.z = s.random(30, 90)
						s.explode(pos, 8, false, true, 20, 0)
					end
				end
				settings["explode_lobby_shake"] = f.on
				return u.stop(f)
				end)
				m.t["explode_lobby_shake"].on = settings["explode_lobby_shake"]
		m.p["sound"] = m.add.p("Sound-Features", m.p["lobby"]).id
			m.t["sound_rape"] = m.add.t("Sound Rape", m.p["sound"], function (f)
				if f.on then	
					for i = 0, 31 do
						if valid.i(i) then
							audio.play_sound_from_entity(2, "Wasted", s.ped(i), "DLC_IE_VV_General_Sounds")
						end
					end
				end
				settings["sound_rape"] = f.on
				return u.stop(f)
				end)
				m.t["sound_rape"].on = settings["sound_rape"]
			m.add.a("Garage-Door Sound - Infinite Time", m.p["sound"], function ()
				for i = 0, 31 do
					if valid.i(i) then
						audio.play_sound_from_entity(2, "Garage_Door", s.ped(i), "DLC_HEISTS_GENERIC_SOUNDS")
					end
				end
				end)
		m.t["kill_all_peds"] = m.add.t("Kill all PEDs", m.p["lobby"], function (f)
			if f.on then
				local kills = ped.get_all_peds()
				for i = 1, #kills do
					if not ped.is_ped_a_player(kills[i]) then
						ped.set_ped_health(kills[i], 0)
					end
				end
			end
			settings["kill_all_peds"] = f.on
			return u.stop(f)
			end)
			m.t["kill_all_peds"].on = settings["kill_all_peds"]
		m.p["lobby_vehicle"] = m.add.p("Vehicles", m.p["lobby"]).id
			m.t["disablecontrol"] = m.add.t("Disable Control from near Vehicles", m.p["lobby_vehicle"], function (f)
				if f.on then
					for i = 0, 31 do
						if valid.i(i) then
							local veh = s.vehicle(s.ped(i))
							if veh ~= 0 then			
								req.ctrl(veh)
								vehicle.set_vehicle_forward_speed(veh, 25)													
								vehicle.set_vehicle_out_of_control(veh, false, true)
							end
						end
					end
				end
				settings["disablecontrol"] = f.on
				return u.stop(f)
				end)
				m.t["disablecontrol"].on = settings["disablecontrol"]
			m.t["modify_veh_speed"] = m.add.u("Modify Vehicle Speeds", "autoaction_value_i", m.p["lobby_vehicle"], function (f)
				settings["modify_veh_speed"] = f.value_i
				local maxspeed = 540
				if settings["modify_veh_speed_override"] then
					maxspeed = f.value_i
				end
				for i = 0, 31 do
					if valid.i(i, settings["modify_veh_speed_include"]) then
						local veh = s.vehicle(s.ped(i))
						if veh ~= 0 then
							req.ctrl(veh)
							entity.set_entity_max_speed(veh, maxspeed)
							vehicle.modify_vehicle_top_speed(veh, f.value_i)
						end
					end
				end
				end)
				m.t["modify_veh_speed"].min_i = -500
				m.t["modify_veh_speed"].max_i = 1000
				m.t["modify_veh_speed"].mod_i = 25
				m.t["modify_veh_speed"].value_i = settings["modify_veh_speed"]
			m.add.a("Reset Modifies", m.p["lobby_vehicle"], function ()
				local maxspeed = 540
				for i = 0, 31 do
					if s.valid(i) then
						local veh = s.vehicle(s.ped(i))
						if veh ~= 0 then
							req.ctrl(veh)
							entity.set_entity_max_speed(veh, maxspeed)
							vehicle.modify_vehicle_top_speed(veh, 0)
						end
					end
				end
				end)
			m.t["modify_veh_speed_include"] = m.add.t("Include Self & Friends", m.p["lobby_vehicle"], function (f)
				settings["modify_veh_speed_include"] = f.on
				end)
				m.t["modify_veh_speed_include"].on = settings["modify_veh_speed_include"]
			m.t["modify_veh_speed_overwrite"] = m.add.t("Overwrite default Speedlimit", m.p["lobby_vehicle"], function (f)
				settings["modify_veh_speed_overwrite"] = f.on
				end)
				m.t["modify_veh_speed_overwrite"].on = settings["modify_veh_speed_overwrite"]
		m.p["lobby_bounty"] = m.add.p("Bounty", m.p["lobby"]).id
			m.t["bounty_after_death"] = m.add.u("Set Bounty after Death", "value_i", m.p["lobby_bounty"], function (f)
				settings["bounty_after_death"] = f.on
				settings["bounty_after_death_value"] = f.value_i
				if f.on then
					local anonymous = 0
					if m.t["anonymous_bounty"].on then
						anonymous = 1
					end
					for i = 0, 31 do
						if valid.i(i) then
							if player.get_player_health(i) == 0 then
								n(g.name(i).." is dead!\nSetting bounty...", 33)
								l(g.name(i).." is dead!")
								l("Setting bounty...")
								for ii = 0, 31 do
									if g.scid(ii) ~= -1 then
										s.script(-116602735, ii, {69, i, 1, m.t["bounty_after_death"].value_i, 0, anonymous, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
									end
								end
								s.wait(1500)
							end
						end
					end
				end
				return u.stop(f)
				end)
				m.t["bounty_after_death"].min_i = 0
				m.t["bounty_after_death"].max_i = 10000
				m.t["bounty_after_death"].value_i = settings["bounty_after_death_value"]
				m.t["bounty_after_death"].on = settings["bounty_after_death"]
			m.t["anonymous_bounty"] = m.add.t("Anonymous Bounty", m.p["lobby_bounty"], function (f)
				settings["anonymous_bounty"] = f.on
				end)
				m.t["anonymous_bounty"].on = settings["anonymous_bounty"]
			for i = 1, #ext_data.bounty_amount do
				m.add.a(ext_data.bounty_amount[i].."$", m.p["lobby_bounty"], function ()
					local anonymous = 0
					if m.t["anonymous_bounty"].on then
						anonymous = 1
					end
					for ii = 0, 31 do
						if g.scid(ii) ~= -1 then
							for iii = 0, 31 do
								if g.scid(iii) ~= -1 then 
									s.script(-116602735, iii, {69, ii, 1, ext_data.bounty_amount[i], 0, anonymous, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
								end
							end
						end
					end
					end)
			end
		m.p["lobby_se"] = m.add.p("Script Events", m.p["lobby"]).id
			m.p["lobby_se_custom"] = m.add.p("Custom Script Events", m.p["lobby_se"]).id
				m.add.a("Enter Custom Script Event with Parameters", m.p["lobby_se_custom"], function ()
					local se_p = {}
					local se_c_p
					local se_c = g.input("Enter Custom SE (DEC)", 32, 3)
					if not se_c then
						n("Aborted sending Custom Event...", 100)
						return HANDLER_POP
					end
					while se_c_p ~= "#" do
						se_c_p = g.input("Enter Parameter (DEC), to EXIT and send, enter #", 32, 0)
						if not se_c_p then
							n("Aborted sending Custom Event...", 100)
							return HANDLER_POP
						end
						if se_c_p == "#" then
							break
						end
						se_c_p = s.no(se_c_p)
						if type(se_c_p) == "number" then
							se_p[#se_p + 1] = se_c_p
						else
							n("Aborted sending Custom Event...", 100)
							return HANDLER_POP
						end
					end
					for i = 0, 31 do
						if valid.i(i) then
							s.script(se_c, i, se_p)
						end
					end
					n("Sent Custom Script Event with Parameters to Players.", 100)
					end)
				for i = 1, #ext_data.custom_se do
					m.add.a(ext_data.custom_se[i][1], m.p["lobby_se_custom"], function ()
						n("Sent Custom Script Event to Players.", 100)
						for y = 0, 31 do
							if valid.i(y) then
								for x = 1, #ext_data.custom_se[i][2] do
									s.script(ext_data.custom_se[i][2][x][1], y, ext_data.custom_se[i][2][x][2])
								end
							end
						end
						end)
				end
			m.add.a("Send all to Island", m.p["lobby_se"], function()
				send_se(true, 0x4d8b1e65, {1300962917})
				end)
			m.p["lobby_send_2_mission"] = m.add.p("Send all to Mission", m.p["lobby_se"]).id
				for i = 1, #send_2_mission do
					m.add.a("Send to "..send_2_mission[i][1], m.p["lobby_send_2_mission"], function ()
						send_se(true, -545396442, send_2_mission[i][2])
						n("Sent Session to Mission")
						end)
				end
			m.p["lobby_ceo"] = m.add.p("CEO all Player", m.p["lobby_se"]).id
				for i = 1, 3 do
					m.add.a(se_ceo[i][1], m.p["lobby_ceo"], function ()
						send_se(true, se_ceo[i][2], se_ceo[i][3], se_ceo[i][4], se_ceo[i][5])
						n("Modified Players CEO")
						end)
				end
			m.add.a("Block - Passive", m.p["lobby_se"], function ()
				send_se(true, -909357184, {1, 1})
				n("Blocked all Players from activating Passive.")
				end)
			m.add.a("UN-Block - Passive", m.p["lobby_se"], function ()
				send_se(true, -909357184, {1, 0})
				n("UN-Blocked all Players from Passive.")
				end)
			m.add.a("Fuck ALL Script-Hosts", m.p["lobby_se"], function()
				local id = script.get_host_of_this_script()
				if valid.i(id) then
					s.script(-1975590661, id, {84857178, 61749268, -80053711, -78045655, 56341553, -78686524, -46044922, -22412109, 29388428, -56335450})
				end
				end)
			m.add.a("Fuck them even harder", m.p["lobby_se"], function()
				local id = script.get_host_of_this_script()
				if valid.i(id) then
					s.script(-922075519, id, {-17645264, -26800537, -66094971, -45281983, -24450684, -13000488, 59643555, 34295654, 91870118, -3283691})
				end
			end)
		m.p["lobby_sms"] = m.add.p("Send SMSs to Lobby", m.p["lobby"], function ()
			n("Players must have Voice-Chat enabled to recive SMS.")
			if m.t["sms_spam"] then
				m.t["sms_spam"].value_i = settings["sms_spam_value"]
				m.t["sms_spam"].on = settings["sms_spam"]
			end
			end).id
			m.t["sms_spam"] = m.add.u("Spam SMS X times", "value_i", m.p["lobby_sms"], function (f)
				settings["sms_spam_value"] = f.value_i
				settings["sms_spam"] = f.on
				end)
				m.t["sms_spam"].min_i = 25
				m.t["sms_spam"].max_i = 5000
				m.t["sms_spam"].mod_i = 25
				m.t["sms_spam"].value_i = settings["sms_spam_value"]
				m.t["sms_spam"].on = settings["sms_spam"]
			m.add.a("Custom SMS input", m.p["lobby_sms"], function ()
				local sms = g.input("Enter Custom SMS", 128, 0)
				if not sms then
					return HANDLER_POP
				end
				for i = 0, 31 do
					if valid.i(i) then
						local value = 1
						if m.t["sms_spam"].on then
							value = m.t["sms_spam"].value_i
						end
						for y = 1, value do
							player.send_player_sms(i, sms)
							s.wait(10)
						end
						if value > 1 then
							n("Spamming SMS done.")
						end
					end
				end
				end)
			m.add.a("Send SCID & IP", m.p["lobby_sms"], function ()
				for i = 0, 31 do
					if valid.i(i) then
						local scid = tostring(g.scid(i))
						local ip = g.ip(i)
						local value = 1
						if m.t["sms_spam"].on then
							value = m.t["sms_spam"].value_i
						end
						for z = 1, value do
							player.send_player_sms(i, "R*SCID: "..scid.."~n~IP: "..ip)
						end
						if value > 1 then
							n("Spamming SMS done.")
						end
					end
				end
				end)
			for i = 1, #ext_data.sms_texts do
				m.add.a(ext_data.sms_texts[i], m.p["lobby_sms"], function ()
					for y = 0, 31 do
						if valid.i(y) then
							local value = 1
							if m.t["sms_spam"].on then
								value = m.t["sms_spam"].value_i
							end
							for z = 1, value do
								player.send_player_sms(y, ext_data.sms_texts[i])
								s.wait(20)
							end
							if value > 1 then
								n("Spamming SMS done.")
							end
						end
					end
					end)
			end
		m.p["lobby_malicious"] = m.add.p("Malicious", m.p["lobby"]).id
			m.t["karma_se"] = m.add.t("Karma every Script Event", m.p["lobby_malicious"], function (f)
				if karma_hook == nil then
					karma_hook = hook.register_script_event_hook(
						function (source, target, params, count)
							local cse = params[1]
							table.remove(params, 1)
							s.script(cse, source, params)
						end
					)
				else
					hook.remove_script_event_hook(karma_hook)
				end
				settings["karma_se"] = f.on
				end)
				m.t["karma_se"].on = settings["karma_se"]
			m.t["punish_aliens"] = m.add.t("Punish Aliens in Lobby", m.p["lobby_malicious"], function (f)
				settings["punish_aliens"] = f.on
				if f.on then
					local time = s.time() + 15000
					while time > s.time() do
						settings["punish_aliens"] = f.on
						s.wait(150)
					end
					for i = 0, 31 do
						if valid.i(i) then
							local guilty = 0
							if player.is_player_female(i) then
								if ped.get_ped_drawable_variation(s.ped(i), 1) == 134 and (ped.get_ped_texture_variation(s.ped(i), 1) == 8 or ped.get_ped_texture_variation(s.ped(i), 1) == 9) then guilty = guilty + 1 end
								if ped.get_ped_drawable_variation(s.ped(i), 4) == 113 and (ped.get_ped_texture_variation(s.ped(i), 4) == 8 or ped.get_ped_texture_variation(s.ped(i), 4) == 9) then guilty = guilty + 1 end
								if ped.get_ped_drawable_variation(s.ped(i), 6) == 87 and (ped.get_ped_texture_variation(s.ped(i), 6) == 8 or ped.get_ped_texture_variation(s.ped(i), 6) == 9) then guilty = guilty + 1 end
								if ped.get_ped_drawable_variation(s.ped(i), 11) == 287 and (ped.get_ped_texture_variation(s.ped(i), 11) == 8 or ped.get_ped_texture_variation(s.ped(i), 11) == 9) then guilty = guilty + 1 end
							else
								if ped.get_ped_drawable_variation(s.ped(i), 1) == 134 and (ped.get_ped_texture_variation(s.ped(i), 1) == 8 or ped.get_ped_texture_variation(s.ped(i), 1) == 9) then guilty = guilty + 1 end
								if ped.get_ped_drawable_variation(s.ped(i), 4) == 106 and (ped.get_ped_texture_variation(s.ped(i), 4) == 8 or ped.get_ped_texture_variation(s.ped(i), 4) == 9) then guilty = guilty + 1 end
								if ped.get_ped_drawable_variation(s.ped(i), 6) == 83 and (ped.get_ped_texture_variation(s.ped(i), 6) == 8 or ped.get_ped_texture_variation(s.ped(i), 6) == 9) then guilty = guilty + 1 end
								if ped.get_ped_drawable_variation(s.ped(i), 11) == 274 and (ped.get_ped_texture_variation(s.ped(i), 11) == 8 or ped.get_ped_texture_variation(s.ped(i), 11) == 9) then guilty = guilty + 1 end
							end
							if guilty > 1 then
								l(g.name(i).." is a useless alien!")
								l("Guilty Level: "..guilty)
								n(g.name(i).." is a useless alien! Punishing him!", 23)
								player.send_player_sms(i, "Delete your stupid alien Outfit!")
								attach_entity(ext_data.custom_attachments[5][2], i)
								attach_entity(ext_data.custom_attachments[8][2], i)
								s.explode(s.gcoords(s.ped(i)), 59, false, true, 1, s.ped(i))
								s.explode(s.gcoords(s.ped(i)), 8, true, false, 1, s.ped(i))
								s.explode(s.gcoords(s.ped(i)), 60, true, false, 1, s.ped(i))
								s.explode(s.gcoords(s.ped(i)), 8, true, false, 1, s.ped(i))
							end
						end
					end
				end
				return u.stop(f)
				end)
				m.t["punish_aliens"].on = settings["punish_aliens"]
			m.add.a("Kick all Players", m.p["lobby_malicious"], function ()
				kick_pl(true)
				end)
			m.add.a("Host Kick All", m.p["lobby_malicious"], function ()
				if network.network_is_host() then
					for i = 0, 31 do
						if valid.i(i) then
							network.network_session_kick_player(i)
						end
					end
				else
					n("You are not Session-Host!")
				end
				end)
			m.t["force_host"] = m.add.t("Kick Hosts until You become Host", m.p["lobby_malicious"], function (f)
				if f.on then
					local time = s.time() + 7500
					while time > s.time() do
						s.wait(250)
						settings["force_host"] = f.on
					end
					local host = player.get_host()
					if host ~= s.id() and g.scid(host) ~= -1 then
						l("You are not Host!")
						l(g.name(host)..":"..g.scid(host).." is Host!")
						n(g.name(host).." is Host!")
						kick_pl(false, host)
					end
				end
				settings["force_host"] = f.on
				return u.stop(f)
				end)
				m.t["force_host"].on = settings["force_host"]
			m.add.a("Crash Session", m.p["lobby_malicious"], function ()
				l("Crashing Session...")
				s.navigate(false)
				hash_c = entity.get_entity_model_hash(o.ped())
				for i = 1, 11 do
					outfits["session_crash"]["textures"][i] = ped.get_ped_texture_variation(o.ped(), i)
					outfits["session_crash"]["clothes"][i] = ped.get_ped_drawable_variation(o.ped(), i)
				end
				local loop = {0, 1, 2, 6, 7}
				for z = 1, #loop do
					outfits["session_crash"]["prop_ind"][z] = ped.get_ped_prop_index(o.ped(), loop[z])
					outfits["session_crash"]["prop_text"][z] = ped.get_ped_prop_texture_index(o.ped(), loop[z])
				end
				c_model(0x471BE4B2, nil, nil, nil, true)
				crashed_session = true
				s.wait(5000)
				fix_screen_after_crash()
				s.navigate(true)
				l("Done.")
				end)
			m.add.a("Fix loading screen after Crash", m.p["lobby_malicious"], fix_screen_after_crash)
	if settings["2t1s_parent"] then m.p["opl_parent"] = m.add.pp("2Take1Script", 0).id end
		m.add.pt("Unmark Modder", m.p["opl_parent"], function (f, id)
			if f.on then
				if player.is_player_modder(id, -1) then
					player.unset_player_as_modder(id, -1)
				end
			end
			return u.stop(f)
			end)
		m.add.pt("Remote Control Vehicle", m.p["opl_parent"], function (f, pid)
			local pf = menu.get_player_feature(f.id)
			if pid == s.id() then
				f.on = false
				n("Don't.\nJust don't on yourself.")
				return HANDLER_POP
			end
			if f.on then
				if remote_veh_target ~= pid then
					remote_veh_target = pid
					for i = 1, #pf.feats do
						if i - 1 ~= pid and pf.feats[i].on then
							pf.feats[i].on = false
						end
					end
				end
				local veh = s.vehicle(s.ped(pid))
				if veh ~= 0 then
					if remote_veh == nil then
						local hash = entity.get_entity_model_hash(veh)
						remote_veh = spawn.vehicle(hash, o.coords())
						ped.set_ped_into_vehicle(o.ped(), remote_veh, -1)
						s.wait(50)
					end
					s.visible(remote_veh, false)
					if entity.get_entity_attached_to(veh) ~= remote_veh then
						req.ctrl(remote_veh)
						entity.set_entity_velocity(remote_veh, v3())
						s_coords(remote_veh, s.gcoords(veh))
						s.wait(0)
						entity.set_entity_rotation(remote_veh, entity.get_entity_rotation(veh))
						req.ctrl(veh)
						entity.set_entity_velocity(veh, v3())
						entity.set_entity_max_speed(veh, 0)
						vehicle.set_vehicle_out_of_control(veh, false, false)
						s.attach(veh, remote_veh, 0, v3(), v3(), true, false, false, 0, true)
					end
					return HANDLER_CONTINUE
				else
					for i = 1, #pf.feats do
						if pf.feats[i].on then
							pf.feats[i].on = false
						end
					end
					n("Target is not in a Vehicle!")
					return HANDLER_POP
				end
			end
			if remote_veh then
				ped.clear_ped_tasks_immediately(o.ped())
				clear({remote_veh})
				remote_veh = nil
			end
			return HANDLER_POP
			end)
		m.add.pa("Repair Vehicle", m.p["opl_parent"], function (f, pid)
			local veh = s.vehicle(s.ped(pid))
			if veh ~= 0 then
				req.ctrl(veh)
				vehicle.set_vehicle_fixed(veh)
				vehicle.set_vehicle_deformation_fixed(veh)
				vehicle.set_vehicle_can_be_visibly_damaged(veh, false)
				l("Repaired Vehicle.")
			end
			end)
		m.add.pt("Waypoint Player", m.p["opl_parent"], function (f, pid)
			local pf = menu.get_player_feature(f.id)
			if f.on then
				if lastwaypoint ~= pid then
					lastwaypoint = pid
					for i = 1, #pf.feats do
						if i - 1 ~= pid and pf.feats[i].on then
							pf.feats[i].on = false
						end
					end
				end
				local pos = s.gcoords(s.ped(pid))
				ui.set_new_waypoint(v2(pos.x, pos.y))
				s.wait(500)
				return HANDLER_CONTINUE
			end
			s.wait(10)
			ui.set_waypoint_off()
			s.wait(10)
			return HANDLER_POP
			end)
		m.add.pa("Modify Speed (0-500)", m.p["opl_parent"], function (f, pid)
			local veh = s.vehicle(s.ped(pid))
			if veh ~= 0 then
				local speed = g.input("Enter modified Speed (0-500)", 10, 3)
				if not speed then
					return HANDLER_POP
				end
				speed = s.no(speed)
				if speed < 0 or speed > 500 then
					n("Invalid Speed.")
					return HANDLER_POP
				end
				n("Setting modified Speed.")
				req.ctrl(veh)
				entity.set_entity_max_speed(veh, speed)
				vehicle.modify_vehicle_top_speed(veh, speed)
			end
			end)
		m.add.pa("Electrocute Player", m.p["opl_parent"], function(f, pid)
			local pos = s.gcoords(s.ped(pid))
			s.bullet(pos + v3(0, 0, 2), pos, 0, 0x3656C8C1, 0, true, false, 10000)
			end)
		m.add.pt("Electrocute Player", m.p["opl_parent"], function(f, pid)
			if f.on then
				local pos = s.gcoords(s.ped(pid))
				s.bullet(pos + v3(0, 0, 2), pos, 0, 0x3656C8C1, 0, true, false, 10000)
				s.wait(1000)
			end
			return u.stop(f)
			end)
		m.p["attach"] = m.add.pp("Attach Objects", m.p["opl_parent"]).id
			m.add.pa("Attach Entity from Aim",  m.p["attach"], function (f, id)
				local aimentity = player.get_entity_player_is_aiming_at(s.id())
				if aimentity ~= 0 then
					attach_entity({{aimentity, 0, {0, 0, 0}, {0, 0, 0}},}, id, true)
				else
					n("No Entity found. Aim @Entity to attach it to Player.")
				end
				end)
			m.add.pa("Clear Entitys", m.p["attach"], function ()
				l("Clearing Attachments.")
				clear(entitys["attach_obj"])
				entitys["attach_obj"] = {}
				n("Cleared all Attachment Entitys.")
				end)
			for i = 1, #ext_data.custom_attachments do
				m.add.pa(ext_data.custom_attachments[i][1], m.p["attach"], function (f, id) attach_entity(ext_data.custom_attachments[i][2], id) end)
			end
		m.p["opl_event_logger"] = m.add.pp("Log Events", m.p["opl_parent"]).id
			m.add.pt("Log Script Events", m.p["opl_event_logger"], function(f, id)
				if f.on then
					if player_script_hooks[id] == nil then
						player_script_hooks[id] = hook.register_script_event_hook(function(source, target, params, count)
							if source == id then
								local scid = g.scid(id)
								local name = g.name(id)
								local uuid = tostring(scid) .. "-" .. name
								local file = paths["Event-Logger"] .. "\\" .. uuid .. "\\" .. "Script-Events.log"
								local prefix = u.time_prefix() .. " [Script-Event-Logger]"
								local text = prefix
								if not s.d_exists(paths["Event-Logger"]) then
									utils.make_dir(paths["Event-Logger"])
								end
								if not s.d_exists(paths["Event-Logger"] .. "\\" .. uuid) then
									utils.make_dir(paths["Event-Logger"] .. "\\" .. uuid)
								end
								if not s.f_exists(file) then
									n("Logging to folder '2Take1Script/Event-Logger/" .. uuid, 14)
									text = "Starting to log Script-Events from Player: " .. 
									name .. ":" .. scid .. "\n" .. prefix
								end
								text = text .. "\n" .. params[1] .. ", {"
								for i = 2, #params do
									text = text .. params[i]
									if i ~= #params then
										text = text .. ", "
									end
								end
								text = text .. "}\n"
								text = text .. "Parameter count: " .. count - 1 .. "\n"
								u.write(s.o(file, "a"), text)
							end
							end)
					end
					return HANDLER_CONTINUE
				end
				if not f.on and player_script_hooks[id] then
					hook.remove_script_event_hook(player_script_hooks[id])
					player_script_hooks[id] = nil
				end
				end)
			m.add.pa("Reset Script Event Log", m.p["opl_event_logger"], function(f, id)
				local scid = g.scid(id)
				local name = g.name(id)
				local uuid = tostring(scid) .. "-" .. name
				local file = paths["Event-Logger"] .. "\\" .. uuid .. "\\" .. "Script-Events.log"
				if s.f_exists(file) then
					io.remove(file)
				else
					n("There was no log to reset.", 14)
				end
				end)
			m.add.pt("Log Net Events", m.p["opl_event_logger"], function(f, id)
				if f.on then
					if player_net_hooks[id] == nil then
						player_net_hooks[id] = hook.register_net_event_hook(function(source, target, eventId)
							if source == id then
								local scid = g.scid(id)
								local name = g.name(id)
								local uuid = tostring(scid) .. "-" .. name
								local file = paths["Event-Logger"] .. "\\" .. uuid .. "\\" .. "Net-Events.log"
								local prefix = u.time_prefix() .. " [Net-Event-Logger]"
								local text = prefix
								if not s.d_exists(paths["Event-Logger"]) then
									utils.make_dir(paths["Event-Logger"])
								end
								if not s.d_exists(paths["Event-Logger"] .. "\\" .. uuid) then
									utils.make_dir(paths["Event-Logger"] .. "\\" .. uuid)
								end
								if not s.f_exists(file) then
									n("Logging to folder '2Take1Script/Event-Logger/" .. uuid, 14)
									text = "Starting to log Net-Events from Player: " .. 
									name .. ":" .. scid .. "\n" .. text
								end
								local event_name = mapper.net.GetEventName(eventId)
								text = text .. "\nEvent: " .. event_name .. "\nEvent ID: " .. eventId .. "\n"
								u.write(s.o(file, "a"), text)
							end
							end)
					end
					return HANDLER_CONTINUE
				end
				if not f.on and player_net_hooks[id] then
					hook.remove_net_event_hook(player_net_hooks[id])
					player_net_hooks[id] = nil
				end
				end)
			m.add.pa("Reset Net Event Log", m.p["opl_event_logger"], function(f, id)
				local scid = g.scid(id)
				local name = g.name(id)
				local uuid = tostring(scid) .. "-" .. name
				local file = paths["Event-Logger"] .. "\\" .. uuid .. "\\" .. "Net-Events.log"
				if s.f_exists(file) then
					io.remove(file)
				else
					n("There was no log to reset.", 14)
				end
				end)
		m.p["opl_se"] = m.add.pp("Script-Events", m.p["opl_parent"]).id
			m.p["opl_se_custom"] = m.add.pp("Custom Script Events", m.p["opl_se"]).id
				m.add.pa("Enter Custom Script Event with Parameters", m.p["opl_se_custom"], function (f, id)
					local se_c_p
					local se_p = {}
					local se_c = g.input("Enter Custom SE (DEC)", 32, 3)
					if not se_c then
						n("Aborted sending Custom Event...", 93)
						return HANDLER_POP
					end
					while se_c_p ~= "#" do
						se_c_p = g.input("Enter Parameter (DEC), to EXIT and send, enter #", 32)
						if not se_c_p then
							n("Aborted sending Custom Event...", 93)
							return HANDLER_POP
						end
						if se_c_p == "#" then
							break
						end
						se_c_p = s.no(se_c_p)
						if type(se_c_p) == "number" then
							se_p[#se_p + 1] = se_c_p
						else
							n("Aborted sending Custom Event...", 93)
							return HANDLER_POP
						end
					end
					s.script(se_c, id, se_p)
					n("Sent Custom Script Event with Parameters to Player.", 93)
					end)
				for i = 1, #ext_data.custom_se do
					m.add.pa(ext_data.custom_se[i][1], m.p["opl_se_custom"], function (f, id)
						n("Sent Custom Script Event to Player.", 93)
						for x = 1, #ext_data.custom_se[i][2] do
							s.script(ext_data.custom_se[i][2][x][1], id, ext_data.custom_se[i][2][x][2])
						end
						end)
				end
			m.add.pa("Send Player to Island", m.p["opl_se"], function(f, id)
				send_se(false, 0x4d8b1e65, {1300962917}, nil, nil, id)
				end)
			m.add.pa("Block - Passive", m.p["opl_se"], function (f, id)
				send_se(false, 0x54BAD868, {1, 1}, nil, nil, id)
				n("Blocked Player from activating Passive.")
				end)
			m.add.pa("UN-Block - Passive", m.p["opl_se"], function (f, id)
				send_se(false, 0x54BAD868, {2, 0}, nil, nil, id)
				n("UN-Blocked Player from Passive.")
				end)
			m.p["opl_send_2_mission"] = m.add.pp("Send Player to Mission", m.p["opl_se"]).id
				for i = 1, #send_2_mission do
					m.add.pa("Send to "..send_2_mission[i][1], m.p["opl_send_2_mission"], function (f, id)
						send_se(false, -545396442, send_2_mission[i][2], nil, nil, id)
						n("Sent Player to Mission")
						end)
				end
			m.p["opl_ceo"] = m.add.pp("CEO", m.p["opl_se"]).id
				for i = 1, 3 do
					m.add.pa(se_ceo[i][1], m.p["opl_ceo"], function (f, id)
						send_se(false, se_ceo[i][2], se_ceo[i][3], se_ceo[i][4], se_ceo[i][5], id)
						n("Modified Players CEO")
						end)
				end
		m.p["opl_assassins_peds"] = m.add.pp("Send PEDs (Assassins)", m.p["opl_parent"]).id
			m.add.pa("Clear PEDs", m.p["opl_assassins_peds"], function ()
				clear(entitys["peds"])
				entitys["peds"] = {}
				end)
			for i = 1, #ext_data.ped_assassins do
				m.add.pa("Spawn " .. ext_data.ped_assassins[i][1] .. " (3x)", m.p["opl_assassins_peds"], function (f, id)
					l("Spawning PEDs.")
					assassins_target = id
					local hash = ext_data.ped_assassins[i][2]
					local ped_type = ext_data.ped_assassins[i][3]
					local pos = v3()
					req.model(hash)
					for i = 1, 3 do
						pos = s.gcoords(s.ped(id))
						pos.x = pos.x + s.random(-10, 10)
						pos.y = pos.y + s.random(-10, 10)
						entitys["peds"][#entitys["peds"] + 1] = spawn.ped(hash, pos, ped_type)
						if ped_type ~= 28 then weapon.give_delayed_weapon_to_ped(entitys["peds"][#entitys["peds"]], 0xDBBD7280, 0, 0) end
						ped.set_ped_max_health(entitys["peds"][#entitys["peds"]], 25000000.0)
						ped.set_ped_health(entitys["peds"][#entitys["peds"]], 25000000.0)
						ped.set_ped_combat_attributes(entitys["peds"][#entitys["peds"]], 46, true)
						ped.set_ped_combat_ability(entitys["peds"][#entitys["peds"]], 2)
						ped.set_ped_config_flag(entitys["peds"][#entitys["peds"]], 187, 0)
						ped.set_ped_can_ragdoll(entitys["peds"][#entitys["peds"]], false)
						for ii = 1, 26 do ped.set_ped_ragdoll_blocking_flags(entitys["peds"][#entitys["peds"]], ii) end
						ai.task_combat_ped(entitys["peds"][#entitys["peds"]], s.ped(id), 0, 16)
					end
					s.unload(hash)
					l("Done.")
					end)
			end
		m.add.pa("TP to Player", m.p["opl_parent"], function (f, id) tp(s.gcoords(s.ped(id)), 3) end)
		m.add.pa("TP Players Vehicle to me", m.p["opl_parent"], function (f, id) 
			local veh = s.vehicle(s.ped(id))
			req.ctrl(veh)
			entity.set_entity_velocity(veh, v3())
			s_coords(veh, o.coords())
			end)
		m.add.pa("Add Player to Blacklist", m.p["opl_parent"], function (f, id)
			blacklist.add(g.scid(id), g.name(id), id)
			end)
		m.add.pa("Remove from Blacklist", m.p["opl_parent"], function(f, id)
			blacklist.remove_scid(g.scid(id))
			end)
		m.p["opl_misc"] = m.add.pp("Miscellaneous", m.p["opl_parent"]).id
			m.p["opl_sms"] = m.add.pp("Send SMSs to Player", m.p["opl_misc"], function ()
				n("Player must have Voice-Chat enabled to recive SMS.")
				end).id
				m.add.pa("Custom SMS input", m.p["opl_sms"], function (f, id)
					local sms = g.input("Enter Custom SMS", 128)
					if not sms then
						return HANDLER_POP
					end
					player.send_player_sms(id, sms)
					end)
				m.add.pa("Send his SCID & IP", m.p["opl_sms"], function (f, id)
					local scid = tostring(g.scid(id))
					local ip = g.ip(id)
					local value = 1
					player.send_player_sms(id, "R*SCID: "..scid.."~n~IP: "..ip)
					end)
				for i = 1, #ext_data.sms_texts do
					m.add.pa(ext_data.sms_texts[i], m.p["opl_sms"], function (f, id)
						player.send_player_sms(id, ext_data.sms_texts[i])
						end)
				end
			m.add.pa("Falling Asteroids", m.p["opl_misc"], function (f, id) 
				s.navigate(false)
				local pos = v3()
				local force
				req.model(3751297495)
				for i = 1, 25 do
					pos = s.gcoords(s.ped(id))
					pos.x = s.random(math.floor(pos.x - 80), math.floor(pos.x + 80))
					pos.y = s.random(math.floor(pos.y - 80), math.floor(pos.y + 80))
					pos.z = pos.z + s.random(45, 90)
					force = s.random(-125, 25)
					entitys["asteroids"][#entitys["asteroids"] + 1] = spawn.object(3751297495, pos, true, true)
					entity.apply_force_to_entity(entitys["asteroids"][#entitys["asteroids"]], 3, 0, 0, force, 0, 0, 0, true, true)
				end
				s.unload(3751297495)
				for i = 1, 5 do
					for i = 1, 25 do
						pos = s.gcoords(entitys["asteroids"][(#entitys["asteroids"] - 25 + i)])
						s.explode(pos, 8, true, false, 0, 0)
						s.wait(50)
					end
				end
				s.navigate(true)
				end)
			m.add.pa("Delete Asteroids", m.p["opl_misc"], function ()
				l("Clearing Asteroids.")
				clear(entitys["asteroids"])
				entitys["asteroids"] = {}
				n("Cleared all Asteroids.")
				end)
			m.add.pa("Apply random Force to Player", m.p["opl_misc"], function (f, id)
				local ped_id = s.ped(id)
				if ped.is_ped_in_any_vehicle(ped_id) then ped_id = s.vehicle(ped_id)
				else n("It works better, if target is in a Vehicle.") end
				req.ctrl(ped_id)
				local velocity = entity.get_entity_velocity(ped_id)
				for i = 1, 5 do
					velocity.x = s.random(math.floor(velocity.x - 50), math.floor(velocity.x + 50))
					velocity.y = s.random(math.floor(velocity.y - 50), math.floor(velocity.y + 50))
					velocity.z = s.random(math.floor(velocity.z - 50), math.floor(velocity.z + 50))
					entity.set_entity_velocity(ped_id, velocity)
					s.wait(10)
				end
				end)
			m.add.pa("Trap in Stunt Tube", m.p["opl_misc"], function (f, id)
				local pos = s.gcoords(s.ped(id))
				pos.z = pos.z - 5
				entity.set_entity_rotation(spawn.object(1125864094, pos), v3(0, 90, 0))
				end)
			m.add.pa("Trap in invisible Cage", m.p["opl_misc"], function (f, id)
				local pos = s.gcoords(s.ped(id))
				pos.x = pos.x + 1.24
				pos.y = pos.y + 0.24
				req.model(401136338)
				local cage = spawn.object(401136338, pos)
				s.visible(cage, false)
				entity.set_entity_rotation(cage, v3(0, -90, 0))
				entity.freeze_entity(cage, true)
				pos = s.gcoords(s.ped(id))
				pos.x = pos.x + 0.02
				pos.y = pos.y + 0.82
				cage = spawn.object(401136338, pos)
				s.visible(cage, false)
				entity.set_entity_rotation(cage, v3(90, -90, 0))
				entity.freeze_entity(cage, true)
				s.unload(401136338)
				end)		
		m.p["opl_bounty"] = m.add.pp("Bounty", m.p["opl_parent"]).id
			for i = 1, #ext_data.bounty_amount do
				m.add.pa(ext_data.bounty_amount[i].."$", m.p["opl_bounty"], function (f, id)
					local anonymous = 0
					if m.t["anonymous_bounty"].on then anonymous = 1 end
					for ii = 0, 31 do
						if g.scid(ii) ~= -1 then
							s.script(-116602735, ii, {69, id, 1, ext_data.bounty_amount[i], 0, anonymous, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
						end
					end
					end)
			end
		m.p["opl_lag_area"] = m.add.pp("Lag Area with Vehicles", m.p["opl_parent"], function () n("DANGEROUS! ONLY USE WITH CAUTION!", 208) end).id
			for i = 1, #ext_data.vehicle_lag_area do
				m.add.pa("Lag / Rain Area with "..ext_data.vehicle_lag_area[i][1], m.p["opl_lag_area"], function (f, id) lag_area(id, ext_data.vehicle_lag_area[i][2]) end)
			end
			m.add.pa("Delete Vehicles", m.p["opl_lag_area"], function ()
				l("Clearing Vehicles.")
				clear(entitys["lag_area"])
				entitys["lag_area"] = {}
				n("Cleared Vehicles.")
				end)
		m.add.pa("Kick Player", m.p["opl_parent"], function (f, id) kick_pl(false, id) end)
	m.p["chat"] = m.add.p("Chat-Features", m.p["parent"])
		m.p["chat"].hidden = settings["chat_hidden"]
		m.p["chat"] = m.p["chat"].id
		m.t["echo_chat"] = m.add.u("Echo Chat X times", "value_i", m.p["chat"], function(f)
			if f.on and not chat_events["echo_chat"] then
				chat_events["echo_chat"] = event.add_event_listener("chat", function(e)
					if f.on and e.player ~= s.id() then
						for i = 1, f.value_i do
							network.send_chat_message(e.body, false)
						end
					end
					end)
			end
			if not f.on and chat_events["echo_chat"] then
				event.remove_event_listener("chat", chat_events["echo_chat"])
				chat_events["echo_chat"] = nil
			end
			settings["echo_chat_value"] = f.value_i
			settings["echo_chat"] = f.on
			end)
			m.t["echo_chat"].min_i = 1
			m.t["echo_chat"].max_i = 10
			m.t["echo_chat"].value_i = settings["echo_chat_value"]
			m.t["echo_chat"].on = settings["echo_chat"]
		local spam_msg
		m.t["ultra_spammer"] = m.add.u("Ultra Spammer", "value_i", m.p["chat"], function(f)
			if f.on then
				if not spam_msg then
					local msg = g.input("Enter message to spam")
					if msg then
						spam_msg = msg
					else
						return HANDLER_POP
					end
				end
				if spam_msg then
					network.send_chat_message(spam_msg, false)
					s.wait(f.value_i)
				end
			end
			if not f.on then
				spam_msg = nil
			end
			return u.stop(f)
			end)
			m.t["ultra_spammer"].max_i = 100
			m.t["ultra_spammer"].mod_i = 5
		m.t["chat_log"] = m.add.t("Chat-Log", m.p["chat"], function (f)
			if f.on and not chat_events["chat_log"] then
				chat_events["chat_log"] = event.add_event_listener("chat", function(e)
					l("[" .. g.scid(e.player) .. ":" .. g.name(e.player) .. "] '" .. e.body .. "'", "[CHAT]")
					end)
			end
			if not f.on and chat_events["chat_log"] then
				event.remove_event_listener("chat", chat_events["chat_log"])
				chat_events["chat_log"] = nil
			end
			settings["chat_log"] = f.on
			end)
			m.t["chat_log"].on = settings["chat_log"]
		m.t["chat_russki"] = m.add.t("Kick if Russki Char is typed", m.p["chat"], function (f)
			if f.on and not chat_events["chat_russki"] then
				chat_events["chat_russki"] = event.add_event_listener("chat", function(e)
					local id = e.player
					if valid.i(id) then
						local text = e.body
						for i = 1, #ext_data.russki_chars do
							if string.find(text, ext_data.russki_chars[i], 1) then
								l("Detected '"..ext_data.russki_chars[i].."' as a Russki Char!")
								l("Preparing to Kick "..g.name(id)..".")
								n("Detected "..g.name(id).." typing forbidden Russki! Kicking Player...", 115)
								kick_pl(false, id)
								text = ""
							end
						end
					end
					end)
			end
			if not f.on and chat_events["chat_russki"] then
				event.remove_event_listener("chat", chat_events["chat_russki"])
				chat_events["chat_russki"] = nil
			end
			settings["chat_russki"] = f.on
			end)
			m.t["chat_russki"].on = settings["chat_russki"]
		m.t["chat_begger"] = m.add.t("Punish Money Beggers", m.p["chat"], function (f)
			if f.on and not chat_events["chat_begger"] then
				chat_events["chat_begger"] = event.add_event_listener("chat", function(e)
					local id = e.player
					if valid.i(id) then
						local text = e.body
						for i = 1, #ext_data.begger_texts do
							if string.find(text, ext_data.begger_texts[i], 1) then
								l("Detected "..g.name(id).." begging for Money! Punishing Player...")
								n("Detected "..g.name(id).." begging for Money! Punishing Player...", 115)
								attach_entity(ext_data.custom_attachments[5][2], id)
								attach_entity(ext_data.custom_attachments[8][2], id)
								local pos = s.gcoords(s.ped(id))
								local owner = s.ped(id)
								s.explode(pos, 59, false, true, 1, owner)
								s.explode(pos, 8, false, true, 1, owner)
								s.explode(pos, 59, false, true, 1, owner)
							end
						end
					end
					end)
			end
			if not f.on and chat_events["chat_begger"] then
				event.remove_event_listener("chat", chat_events["chat_begger"])
				chat_events["chat_begger"] = nil
			end
			settings["chat_begger"] = f.on
			end)
			m.t["chat_begger"].on = settings["chat_begger"]
		m.t["send_msg_to_script_users"] = m.add.a("Send Message to 2Take1Script-Users", m.p["chat"], function ()
			local msg = g.input("Enter Message", 128)
			if not msg then
				return HANDLER_POP
			end
			if msg ~= "" then
				local params = {}
				params[1] = 6666
				for p,c in utf8.codes(msg) do
					params[#params + 1] = c
				end
				for i = 0, 31 do
					if s.valid(i) then
						if i ~= s.id() and g.scid(i) ~= -1 then
							s.script(0x76fe5334, i, params)
						end
					end
				end
			end
			end)
		m.t["chat_cmd"] = m.add.t("Enable Chat-Commands", m.p["chat"], function (f)
			if f.on and not chat_events["chat_cmd"] then
				chat_events["chat_cmd"] = event.add_event_listener("chat", function(h)
					local id = h.player
					local text = h.body
					if m.t["cmd_explode"] and string.find(text, "!explode ", 1) then
						text = string.gsub(text, "!explode ", "")
						local entitled, pl_id = is_entitled(id, text, "Explode")
						if entitled then
							local pos = s.gcoords(s.ped(pl_id))
							local owner = s.ped(id)
							s.explode(pos, 59, false, true, 1, owner)
							s.explode(pos, 8, false, true, 1, owner)
							s.explode(pos, 59, false, true, 1, owner)
						end
					end
					if m.t["cmd_explode_all"] and string.find(text, "!explodeall", 1) and id == s.id() then
						l("Detected !explodeall Command! Script-User is entitled, performing...")
						for i = 0, 31 do
							if valid.i(i) then
								s.explode(s.gcoords(s.ped(i)), 59, true, false, 1, s.ped(s.id()))
							end
						end
					end
					if m.t["cmd_kick"] and string.find(text, "!kick ", 1) then
						text = string.gsub(text, "!kick ", "")
						local entitled, pl_id = is_entitled(id, text, "Kick")
						if entitled then
							kick_pl(false, pl_id)
						end
					end
					if m.t["cmd_kick_all"] and string.find(text, "!kickall", 1) and id == s.id() then
						l("Detected !kickall Command! Script-User is entitled, performing...")
						kick_pl(true)
					end
					if m.t["cmd_lag"] and string.find(text, "!lag ", 1) then
						text = string.gsub(text, "!lag ", "")
						local entitled, pl_id = is_entitled(id, text, "Lag")
						if entitled and #entitys["lag_area"] < 101 then
							lag_area(pl_id, 0x15F27762)
						end
					end
					if m.t["cmd_trap"] and string.find(text, "!trap ", 1) then
						text = string.gsub(text, "!trap ", "")
						local entitled, pl_id = is_entitled(id, text, "Trap")
						if entitled then
							local pos = s.gcoords(s.ped(pl_id))
							entity.set_entity_rotation(spawn.object(1125864094, v3(pos.x, pos.y, pos.z - 5)), v3(0, 90, 0))
						end
					end
					if m.t["cmd_tp"] and string.find(text, "!tp ", 1) and id == s.id() then
						l("Detected !tp Command! Script-User is entitled, performing...")
						text = string.gsub(text, "!tp ", "")
						local target = id_from_name(text)
						if target ~= -1 then
							local offset = 10
							local pos = s.gcoords(s.ped(target))
							if pos.z < -50 then offset = 150 end
							tp(s.ped(target), offset)
						end
					end
					if m.t["cmd_clearwanted"] and string.find(text, "!clearwanted", 1) then
						local entitled, pl_id = is_entitled(id, nil, "Clearwanted")
						if entitled then
							s.script(0xf63f672f, id, {id, script.get_global_i(1628955 + (1 + (id * 614)) + 532)})
						end
					end
					if m.t["cmd_vehicle"] and string.find(text, "!vehicle ", 1) then
						text = string.gsub(text, "!vehicle ", "")
						local entitled, pl_id = is_entitled(id, nil, "Vehicle")
						if entitled then
							local hash = gameplay.get_hash_key(text)
							if streaming.is_model_a_vehicle(hash) then
								req.model(hash)
								local heading = player.get_player_heading(id)
								local spawned_veh = spawn.vehicle(hash, OffsetCoords(s.gcoords(s.ped(id)), heading, 10), heading)
								req.ctrl(spawned_veh)
								s.unload(hash)
								vehicle.set_vehicle_custom_primary_colour(spawned_veh, 0)
								vehicle.set_vehicle_custom_secondary_colour(spawned_veh, 0)
								vehicle.set_vehicle_custom_pearlescent_colour(spawned_veh, 0)
								vehicle.set_vehicle_custom_wheel_colour(spawned_veh, 0)
								vehicle.set_vehicle_window_tint(spawned_veh, 1)
								decorator.decor_set_int(spawned_veh, "MPBitset", 1 << 10)
								upgrade_veh(spawned_veh)
								ped.set_ped_into_vehicle(s.ped(id), spawned_veh, -1)
							end
						end
					end
					if m.t["cmd_bigpp"] and string.find(text, "!bigpp ", 1) then
						text = string.gsub(text, "!bigpp ", "")
						local entitled, pl_id = is_entitled(id, text, "Bigpp")
						if entitled then
							attach_entity(ext_data.custom_attachments[5][2], pl_id)
						end
					end
					if m.t["cmd_bigppall"] and string.find(text, "!bigppall", 1) and id == s.id() then
						l("Detected !bigppall Command! Script-User is entitled, performing...")
						for i = 0, 31 do
							if valid.i(i) then
								attach_entity(ext_data.custom_attachments[5][2], id)
							end
						end
					end
					if m.t["cmd_vehiclegod"] and string.find(text, "!vehiclegod ", 1) then
						local entitled, pl_id = is_entitled(id, nil, "VehicleGod")
						if entitled then
							local veh = s.vehicle(s.ped(id))
							if veh ~= 0 then
								text = string.gsub(text, "!vehiclegod ", "")
								local toggle
								if text == "off" then
									toggle = false
								end
								if text == "on" then
									toggle = true
								end
								if not req.ctrl(veh, 5000) then
									n("Couldn't get control over vehicle, possibility that command did not worked.")
								end
								if toggle ~= nil then
									s.god(veh, toggle)
								end
							end
						end
					end
					if m.t["cmd_weaponsall"] and string.find(text, "!weaponsall", 1) then
						local entitled, pl_id = is_entitled(id, nil, "WeaponsAll")
						if entitled then
							local all_weapons = weapon.get_all_weapon_hashes()
							for i = 1, #all_weapons do
								if not weapon.has_ped_got_weapon(s.ped(id), all_weapons[i]) then
									weapon.give_delayed_weapon_to_ped(s.ped(id), all_weapons[i], 0, 0);
								end
							end
						end
					end
					end)
			end
			if not f.on and chat_events["chat_cmd"] then
				event.remove_event_listener("chat", chat_events["chat_cmd"])
				chat_events["chat_cmd"] = nil
			end
			settings["chat_cmd"] = f.on
			end)
			m.t["chat_cmd"].on = settings["chat_cmd"]
		m.p["chat_cmd"] = m.add.p("Chat-Commands", m.p["chat"]).id
			for i = 1, #cmds do
				m.t[cmds[i][1]] = m.add.t(cmds[i][2], m.p["chat_cmd"], function (f) settings[cmds[i][1]] = f.on end)
					m.t[cmds[i][1]].on = settings[cmds[i][1]]
			end
			m.add.a("[SU] = Script-User", m.p["chat_cmd"])
		m.add.a("Delete Vehicles from !lag", m.p["chat"], function () clear(entitys["lag_area"]) entitys["lag_area"] = {} end)
		m.t["chat_cmd_friends"] = m.add.t("Chat Commands for Friends", m.p["chat"], function (f) settings["chat_cmd_friends"] = f.on end)
			m.t["chat_cmd_friends"].on = settings["chat_cmd_friends"]
		m.t["chat_cmd_all"] = m.add.t("Chat Commands Everyone", m.p["chat"], function (f) settings["chat_cmd_all"] = f.on end)
			m.t["chat_cmd_all"].on = settings["chat_cmd_all"]
	m.p["custom_veh"] = m.add.p("Custom Vehicles", m.p["parent"])
		m.p["custom_veh"].hidden = settings["custom_vehicles_hidden"]
		m.p["custom_veh"] = m.p["custom_veh"].id
		m.p["moveablerobot"] = m.add.p("Moveable Robot", m.p["custom_veh"]).id
			m.t["moveablerobot"] = m.add.t("Enable Robot", m.p["moveablerobot"], function (f) 
				if f.on then				
					if robot_objects["tampa"] == nil then
						s.navigate(false)
						local spawn_it = true
						local veh = s.vehicle(o.ped())
						if veh ~= 0 then
							if 3084515313 == entity.get_entity_model_hash(veh) then
								robot_objects["tampa"] = veh
								spawn_it = false
							end
						end
						if spawn_it then
							req.model(3084515313) --TAMPA
							robot_objects["tampa"] = spawn.vehicle(3084515313, o.coords(), o.heading())
							decorator.decor_set_int(robot_objects["tampa"], "MPBitset", 1 << 10)
							s.god(robot_objects["tampa"], true)
							upgrade_veh(veh)
							if m.t["auto_get_in"].on then
								ped.set_ped_into_vehicle(o.ped(), robot_objects["tampa"], -1)
							end							
							if not settings["disable_tampa_notify"] then
								n("To get the best experience, upgrade the Tampa to use the Double Controllable Minigun!", 11)
								n("You can disable this message in Options.", 11)
							end
						end
					end
					if robot_objects["ppdump"] == nil then
						req.model(0x810369E2) --DUMP
						robot_objects["ppdump"] = spawn.vehicle(0x810369E2)
						s.god(robot_objects["ppdump"], true)
						s.attach(
							robot_objects["ppdump"], robot_objects["tampa"], 0, v3(0, 0, 12.5), v3(), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["llbone"] == nil then
						req.model(1803116220) -- ALIEN EGG
						robot_objects["llbone"] = spawn.object(1803116220)
						s.attach(
							robot_objects["llbone"], robot_objects["tampa"], 0, v3(-4.25, 0, 12.5), v3(), true, settings["robot_collision"], false, 2, true
						)					
					end
					if robot_objects["rlbone"] == nil then
						req.model(1803116220) -- ALIEN EGG
						robot_objects["rlbone"] = spawn.object(1803116220)
						s.attach(
							robot_objects["rlbone"], robot_objects["tampa"], 0, v3(4.25, 0, 12.5), v3(), true, settings["robot_collision"], false, 2, true
						)					
					end
					if robot_objects["lltrain"] == nil then
						req.model(1030400667) -- TRAIN
						robot_objects["lltrain"] = spawn.vehicle(1030400667)
						s.god(robot_objects["lltrain"], true)
						s.attach(
							robot_objects["lltrain"], robot_objects["llbone"], 0, v3(0, 0, -5), v3(90), true, settings["robot_collision"], false, 2, true
						)					
					end
					if robot_objects["lfoot"] == nil then
						req.model(782665360) --TANK
						robot_objects["lfoot"] = spawn.vehicle(782665360)
						s.god(robot_objects["lfoot"], true)
						s.attach(
							robot_objects["lfoot"], robot_objects["llbone"], 0, v3(0, 2, -12.5), v3(), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["rltrain"] == nil then
						req.model(1030400667) -- TRAIN
						robot_objects["rltrain"] = spawn.vehicle(1030400667)
						s.god(robot_objects["rltrain"], true)
						s.attach(
							robot_objects["rltrain"], robot_objects["rlbone"], 0, v3(0, 0, -5), v3(90), true, settings["robot_collision"], false, 2, true
						)					
					end
					if robot_objects["rfoot"] == nil then
						req.model(782665360) --TANK
						robot_objects["rfoot"] = spawn.vehicle(782665360)
						s.god(robot_objects["rfoot"], true)
						s.attach(
							robot_objects["rfoot"], robot_objects["rlbone"], 0, v3(0, 2, -12.5), v3(), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["body"] == nil then
						req.model(1030400667) -- TRAIN
						robot_objects["body"] = spawn.vehicle(1030400667)
						s.god(robot_objects["body"], true)
						s.attach(
							robot_objects["body"], robot_objects["tampa"], 0, v3(0, 0, 22.5), v3(90), true, settings["robot_collision"], false, 2, true
						)					
					end
					if robot_objects["shoulder"] == nil then
						req.model(0x810369E2) --DUMP
						robot_objects["shoulder"] = spawn.vehicle(0x810369E2)
						s.god(robot_objects["shoulder"], true)
						s.attach(
							robot_objects["shoulder"], robot_objects["tampa"], 0, v3(0, 0, 27.5), v3(), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["lheadbone"] == nil then
						req.model(1803116220) -- ALIEN EGG
						robot_objects["lheadbone"] = spawn.object(1803116220)
						s.attach(
							robot_objects["lheadbone"], robot_objects["tampa"], 0, v3(-3.25, 0, 27.5), v3(), true, settings["robot_collision"], false, 2, true
						)					
					end
					if robot_objects["rheadbone"] == nil then
						req.model(1803116220) -- ALIEN EGG
						robot_objects["rheadbone"] = spawn.object(1803116220)
						s.attach(
							robot_objects["rheadbone"], robot_objects["tampa"], 0, v3(3.25, 0, 27.5), v3(), true, settings["robot_collision"], false, 2, true
						)					
					end
					if robot_objects["lheadtrain"] == nil then
						req.model(1030400667) -- TRAIN
						robot_objects["lheadtrain"] = spawn.vehicle(1030400667)
						s.god(robot_objects["lheadtrain"], true)
						s.attach(
							robot_objects["lheadtrain"], robot_objects["lheadbone"], 0, v3(-3, 4, -5), v3(325, 0, 45), true, settings["robot_collision"], false, 2, true
						)					
					end				
					if robot_objects["lhand"] == nil then
						req.model(782665360) --TANK
						robot_objects["lhand"] = spawn.vehicle(782665360)
						s.god(robot_objects["lhand"], true)
						s.attach(
							robot_objects["lhand"], robot_objects["lheadtrain"], 0, v3(0, 7.5, 0), v3(), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["rheadtrain"] == nil then
						req.model(1030400667) -- TRAIN
						robot_objects["rheadtrain"] = spawn.vehicle(1030400667)
						s.god(robot_objects["rheadtrain"], true)
						s.attach(
							robot_objects["rheadtrain"], robot_objects["rheadbone"], 0, v3(3, 4, -5), v3(325, 0, 315), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["rhand"] == nil then
						req.model(782665360) --TANK
						robot_objects["rhand"] = spawn.vehicle(782665360)
						s.god(robot_objects["rhand"], true)
						s.attach(
							robot_objects["rhand"], robot_objects["rheadtrain"], 0, v3(0, 7.5, 0), v3(), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["head"] == nil then
						req.model(-543669801) --UFO
						robot_objects["head"] = spawn.object(-543669801)
						s.attach(
							robot_objects["head"], robot_objects["tampa"], 0, v3(0, 0, 35), v3(), true, settings["robot_collision"], false, 2, true
						)
					end
					s.navigate(true)
					return HANDLER_CONTINUE
				end
				if not f.on then
					for i in pairs(robot_objects) do
						clear({robot_objects[i]})
						robot_objects[i] = nil
					end
					if #entitys["robot_weapon_left"] ~= 0 then
						clear(entitys["robot_weapon_left"])
						entitys["robot_weapon_left"] = {}
					end
					if #entitys["robot_weapon_right"] ~= 0 then
						clear(entitys["robot_weapon_right"])
						entitys["robot_weapon_right"] = {}
					end
				end
				end)
			m.t["robot_shoot"] = m.add.t("Controllable Blasts", m.p["moveablerobot"], function (f)
				if f.on then
					if not m.t["moveablerobot"].on then
						s.wait(2500)
					end
					local whash = gameplay.get_hash_key("weapon_airstrike_rocket")
					local pos = o.coords()
					local dir = cam.get_gameplay_cam_rot()
					dir:transformRotToDir()
					dir = dir * 1000
					pos = pos + dir
					local hit, hitpos, hitsurf, hash, ent = worldprobe.raycast((OffsetCoords(o.coords(), o.heading(), 2) + v3(0, 0, 4)), pos, -1, 0)
					while not hit do
						pos = o.coords()
						dir = cam.get_gameplay_cam_rot()
						dir:transformRotToDir()
						dir = dir * 1000
						pos = pos + dir
						hit, hitpos, hitsurf, hash, ent = worldprobe.raycast((OffsetCoords(o.coords(), o.heading(), 2) + v3(0, 0, 4)), pos, -1, 0)
						s.wait(0)
					end				
					if ped.is_ped_shooting(o.ped()) and s.vehicle(o.ped()) == robot_objects["tampa"] then
						if m.t["equip_weapons"].on then							
							local lobj = entitys["robot_weapon_left"][1]
							local lheading = entity.get_entity_heading(lobj)							
							local lpos = OffsetCoords(s.gcoords(lobj), lheading, 12) + v3(0, 0, 3)
							s.bullet(lpos, hitpos, 1000, whash, o.ped(), true, false, 50000)
							s.wait(100)
							local robj = entitys["robot_weapon_right"][1]							
							local rheading = entity.get_entity_heading(robj)
							local rpos = OffsetCoords(s.gcoords(robj), rheading, 12) + v3(0, 0, 3)
							s.bullet(rpos, hitpos, 1000, whash, o.ped(), true, false, 50000)
						else
							local start = OffsetCoords(o.coords(), o.heading(), 8) + v3(0, 0, 15)
							s.bullet(start, hitpos, 1000, whash, o.ped(), true, false, 10000)
						end
					end
				end
				settings["controllable_blasts"] = f.on
				return u.stop(f)
				end)
				m.t["robot_shoot"].on = settings["controllable_blasts"]
			m.t["moveablelegs"] = m.add.t("Moveable Legs", m.p["moveablerobot"], function (f) 
				settings["moveable_legs"] = f.on
				if f.on then
					if robot_objects["llbone"] and robot_objects["rlbone"] and robot_objects["tampa"] then
						local speed
						local left = robot_objects["llbone"]
						local right = robot_objects["rlbone"]
						local main = robot_objects["tampa"]
						local offsetL = v3(-4.25, 0, 12.5)
						local offsetR = v3(4.25, 0, 12.5)
						for i = 0, 50 do
							if robot_objects["tampa"] then
								speed = entity.get_entity_speed(robot_objects["tampa"])
								if not f.on or  speed < 2.5 then clear_legs_movement() return HANDLER_CONTINUE end
								req.ctrl(left)
								req.ctrl(right)
								req.ctrl(main)
								s.attach(left, main, 0, offsetL, v3(i, 0, 0), true, settings["robot_collision"], false, 2, true)
								s.attach(right, main, 0, offsetR, v3(360-i, 0, 0), true, settings["robot_collision"], false, 2, true)
								local wait = math.floor(51 - (speed / 1))
								if wait < 1 then
									wait = 0
								end
								s.wait(wait)
							end
						end
						for i = 50, -50, -1 do
							if robot_objects["tampa"] then
								speed = entity.get_entity_speed(robot_objects["tampa"])
								if not f.on or  speed < 2.5 then clear_legs_movement() return HANDLER_CONTINUE end
								req.ctrl(left)
								req.ctrl(right)
								req.ctrl(main)
								s.attach(left, main, 0, offsetL, v3(i, 0, 0), true, settings["robot_collision"], false, 2, true)
								s.attach(right, main, 0, offsetR, v3(360-i, 0, 0), true, settings["robot_collision"], false, 2, true)
								local wait = math.floor(51 - (speed / 1))
								if wait < 1 then
									wait = 0
								end
								s.wait(wait)
							end
						end
						for i = -50, 0 do
							if robot_objects["tampa"] then
								speed = entity.get_entity_speed(robot_objects["tampa"])
								if not f.on or  speed < 2.5 then clear_legs_movement() return HANDLER_CONTINUE end
								req.ctrl(left)
								req.ctrl(right)
								req.ctrl(main)
								s.attach(left, main, 0, offsetL, v3(i, 0, 0), true, settings["robot_collision"], false, 2, true)
								s.attach(right, main, 0, offsetR, v3(360-i, 0, 0), true, settings["robot_collision"], false, 2, true)
								local wait = math.floor(51 - (speed / 1))
								if wait < 1 then
									wait = 0
								end
								s.wait(wait)
							end
						end
					end
					return HANDLER_CONTINUE
				end
				if not f.on then
					clear_legs_movement()
				end
				end)
				m.t["moveablelegs"].on = settings["moveable_legs"]
			m.t["robot_collision"] = m.add.t("Collision", m.p["moveablerobot"], function(f)
				settings["robot_collision"] = f.on
				if s.vehicle(o.ped()) == robot_objects["tampa"] then
					n("Re-enable Robot to take effect of collision!", 11)
				end
				end)
				m.t["robot_collision"].on = settings["robot_collision"]
			m.t["rocket_propulsion"] = m.add.t("Rocket Propulsion (Visual)", m.p["moveablerobot"], function (f)
				if f.on and robot_objects["body"] then
					if robot_objects["spinning_1"] == nil then
						req.model(0xFB133A17) -- SAVAGE
						robot_objects["spinning_1"] = spawn.vehicle(0xFB133A17, o.coords())
						s.god(robot_objects["spinning_1"], true)
						s.visible(robot_objects["spinning_1"], false)
						s.attach(
							robot_objects["spinning_1"], robot_objects["body"], 0, v3(0, -5, 0), v3(-180, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
					vehicle.set_heli_blades_speed(robot_objects["spinning_1"], 100)
					if robot_objects["spinning_middle"] == nil then
						req.model(94602826)
						robot_objects["spinning_middle"] = spawn.object(94602826)
						s.god(robot_objects["spinning_middle"], true)
						s.attach(
							robot_objects["spinning_middle"], robot_objects["spinning_1"], 0, v3(0, 0, 0), v3(0, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["spinning_middle2"] == nil then
						req.model(94602826)
						robot_objects["spinning_middle2"] = spawn.object(94602826)
						s.god(robot_objects["spinning_middle2"], true)
						s.attach(
							robot_objects["spinning_middle2"], robot_objects["spinning_1"], 0, v3(0, 0, 1.5), v3(0, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["spinning_middle3"] == nil then
						req.model(94602826)
						robot_objects["spinning_middle3"] = spawn.object(94602826)
						s.god(robot_objects["spinning_middle3"], true)
						s.attach(
							robot_objects["spinning_middle3"], robot_objects["spinning_1"], 0, v3(0, 0, 3), v3(0, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
					local index = entity.get_entity_bone_index_by_name(robot_objects["spinning_1"], "rotor_main")
					if robot_objects["glow_1"] == nil then
						req.model(2655881418) -- SAVAGE
						robot_objects["glow_1"] = spawn.object(2655881418)
						s.god(robot_objects["glow_1"], true)
						s.attach(
							robot_objects["glow_1"], robot_objects["spinning_1"], index, v3(2, 3, 3), v3(0, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["glow_2"] == nil then
						req.model(2655881418) -- SAVAGE
						robot_objects["glow_2"] = spawn.object(2655881418)
						s.god(robot_objects["glow_2"], true)
						s.attach(
							robot_objects["glow_2"], robot_objects["spinning_1"], index, v3(2, -3, 3), v3(0, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["glow_3"] == nil then
						req.model(2655881418) -- SAVAGE
						robot_objects["glow_3"] = spawn.object(2655881418)
						s.god(robot_objects["glow_3"], true)
						s.attach(
							robot_objects["glow_3"], robot_objects["spinning_1"], index, v3(4, 0, 3), v3(0, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["glow_4"] == nil then
						req.model(2655881418) -- SAVAGE
						robot_objects["glow_4"] = spawn.object(2655881418)
						s.god(robot_objects["glow_4"], true)
						s.attach(
							robot_objects["glow_4"], robot_objects["spinning_1"], index, v3(-2, 3, 3), v3(0, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["glow_5"] == nil then
						req.model(2655881418) -- SAVAGE
						robot_objects["glow_5"] = spawn.object(2655881418)
						s.god(robot_objects["glow_5"], true)
						s.attach(
							robot_objects["glow_5"], robot_objects["spinning_1"], index, v3(-2, -3, 3), v3(0, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
					if robot_objects["glow_6"] == nil then
						req.model(2655881418) -- SAVAGE
						robot_objects["glow_6"] = spawn.object(2655881418)
						s.god(robot_objects["glow_6"], true)
						s.attach(
							robot_objects["glow_6"], robot_objects["spinning_1"], index, v3(-4, 0, 3), v3(0, 0, 0), true, settings["robot_collision"], false, 2, true
						)
					end
				end
				if not f.on then
					local delete_propulsion = {
						"spinning_1", "glow_1", "glow_2", "glow_3", "glow_4", "glow_5", "glow_6",
						"spinning_middle", "spinning_middle2", "spinning_middle3"
					}
					for i = 1, #delete_propulsion do
						if robot_objects[delete_propulsion[i]] then
							clear({robot_objects[delete_propulsion[i]]})
							robot_objects[delete_propulsion[i]] = nil
						end
					end
					return HANDLER_POP
				end
				settings["rocket_propulsion"] = f.on
				return HANDLER_CONTINUE
				end)
				m.t["rocket_propulsion"].on = settings["rocket_propulsion"]
			m.t["equip_weapons"] = m.add.t("Equip Miniguns on hands", m.p["moveablerobot"], function (f)
				settings["equip_weapons"] = f.on
				if f.on and robot_objects["lheadtrain"] and robot_objects["rheadtrain"] then
					if #entitys["robot_weapon_left"] == 0 and #entitys["robot_weapon_right"] == 0 then
						local toggle_preview = false
						if m.t["spawn_preview"].on then
							toggle_preview = true
							m.t["spawn_preview"].on = false
						end
						local toggle_spawn_in = false
						if m.t["auto_get_in"].on then
							toggle_spawn_in = true
							m.t["auto_get_in"].on = false
						end
						local data = ext_data.custom_vehicles[1][2]
						spawn_custom_vehicle(data, "robot_weapon_left")
						spawn_custom_vehicle(data, "robot_weapon_right")
						local w1 = entitys["robot_weapon_left"][1]
						local w2 = entitys["robot_weapon_right"][1]
						local a1 = robot_objects["lheadtrain"]
						local a2 = robot_objects["rheadtrain"]
						req.ctrl(w1)
						req.ctrl(w2)
						req.ctrl(a1)
						req.ctrl(a2)
						s.attach(w1, a1, 0, v3(0, 5, 0), v3(), true, settings["robot_collision"], false, 2, true)
						s.attach(w2, a2, 0, v3(0, 5, 0), v3(), true, settings["robot_collision"], false, 2, true)
						if toggle_preview then
							m.t["spawn_preview"].on = true
						end
						if toggle_spawn_in then
							m.t["auto_get_in"].on = true
						end
					end
				end
				if not f.on then
					if #entitys["robot_weapon_left"] ~= 0 then
						clear(entitys["robot_weapon_left"])
						entitys["robot_weapon_left"] = {}
					end
					if #entitys["robot_weapon_right"] ~= 0 then
						clear(entitys["robot_weapon_right"])
						entitys["robot_weapon_right"] = {}
					end
					return HANDLER_POP
				end
				return HANDLER_CONTINUE
				end)
				m.t["equip_weapons"].on = settings["equip_weapons"]
			m.add.a("Drive Robot", m.p["moveablerobot"], function()
				if robot_objects["tampa"] then
					ped.set_ped_into_vehicle(o.ped(), robot_objects["tampa"], -1)
				end
				end)
			m.add.a("Self Destruction", m.p["moveablerobot"], function()
				if robot_objects["tampa"] then
					for i = 1, #entitys["robot_weapon_left"] do
						entity.detach_entity(entitys["robot_weapon_left"][i])
						entity.freeze_entity(entitys["robot_weapon_left"][i], false)
						s.god(entitys["robot_weapon_left"][i], false)
					end
					for i = 1, #entitys["robot_weapon_right"] do
						entity.detach_entity(entitys["robot_weapon_right"][i])
						entity.freeze_entity(entitys["robot_weapon_right"][i], false)
						s.god(entitys["robot_weapon_right"][i], false)
					end
					for i in pairs(robot_objects) do
						entity.detach_entity(robot_objects[i])
						entity.freeze_entity(robot_objects[i], false)
						s.god(robot_objects[i], false)
					end
					for i = 1, #entitys["robot_weapon_left"] do
						s.explode(s.gcoords(entitys["robot_weapon_left"][i]), 8, true, false, 0, 0)
						s.wait(33)
					end
					for i = 1, #entitys["robot_weapon_right"] do
						s.explode(s.gcoords(entitys["robot_weapon_right"][i]), 8, true, false, 0, 0)
						s.wait(33)
					end
					for i in pairs(robot_objects) do
						s.explode(s.gcoords(robot_objects[i]), 8, true, false, 0, 0)
						s.wait(33)
					end
					entitys["robot_weapon_left"] = {}
					entitys["robot_weapon_right"] = {}
					robot_objects = {}
					m.t["moveablerobot"].on = false
				end
				end)
		m.p["custom_spawner"] = m.add.p("Custom Vehicles", m.p["custom_veh"]).id
			m.t["spawn_preview"] = m.add.t("Preview Custom Vehicles", m.p["custom_spawner"], function (f)
				if #entitys["preview_veh"] > 0 and f.on then
					if ped.is_ped_in_any_vehicle(o.ped()) then ped.clear_ped_tasks_immediately(o.ped()) end
					local pos = o.coords()
					if not config_preview then
						for i = 1, #entitys["preview_veh"] do entity.set_entity_no_collsion_entity(entitys["preview_veh"][i], o.ped(), true) end
						config_preview = true
					end
					pos.z = pos.z + offset_height
					local heading = o.heading()
					pos = OffsetCoords(pos, heading, offset_distance)
					s_coords(entitys["preview_veh"][1], pos)
					entity.set_entity_rotation(entitys["preview_veh"][1], rot_veh)
					rot_veh.z = rot_veh.z + 1
					if rot_veh.z > 360 then rot_veh.z = 0 end
				end
				if not f.on then
					clear(entitys["preview_veh"])
					entitys["preview_veh"] = {}
					config_preview = false
					return HANDLER_POP
				end
				return u.stop(f)
				end)
			m.add.a("Delete Custom Vehicles", m.p["custom_spawner"], function ()
				l("Clearing Custom Vehicles.")
				clear(entitys["custom_veh"])
				entitys["custom_veh"] = {} 
				clear(entitys["preview_veh"])
				entitys["preview_veh"] = {}
				config_preview = false
				n("Cleared Custom Vehicles.")
				end)
			for i = 1, #ext_data.custom_vehicles do
				m.add.a(ext_data.custom_vehicles[i][1], m.p["custom_spawner"], function ()
					local data = ext_data.custom_vehicles[i][2]
					spawn_custom_vehicle(data)
					end)
			end
		m.p["custom_veh_opt"] = m.add.p("Options", m.p["custom_veh"]).id
			m.t["auto_get_in"] = m.add.t("Spawn in Custom Vehicle", m.p["custom_veh_opt"], function (f)
				settings["spawn_in_vehicle"] = f.on
				end)
				m.t["auto_get_in"].on = settings["spawn_in_vehicle"]
			m.t["use_own_veh"] = m.add.t("Use Own Vehicle for Custom ones", m.p["custom_veh_opt"], function (f)
				settings["use_own_veh"] = f.on
				end)
				m.t["use_own_veh"].on = settings["use_own_veh"]
			m.t["set_godmode"] = m.add.t("Godmode on Custom Vehicles", m.p["custom_veh_opt"], function (f)
				settings["set_godmode"] = f.on
				end)
				m.t["set_godmode"].on = settings["set_godmode"]
			m.t["disable_tampa_notify"] = m.add.t("Disable Moveable Robot Tampa Notify", m.p["custom_veh_opt"], function (f)
				settings["disable_tampa_notify"] = f.on
				end)
				m.t["disable_tampa_notify"].on = settings["disable_tampa_notify"]
		--[[m.p["custom_veh_builder"] = m.add.p("Custom Vehicle Creator", m.p["custom_veh"])
			m.p["custom_veh_builder"].hidden = true
			-- 1. hash
			-- 2. {pos x, y, z}
			-- 3. {rot x, y, z}
			-- 4. {primary, sec, pearl, wheel, window}
			-- 5. bool_Invisible
			-- 6. int spawnheight
			-- 7. intboneindex
			-- 8. attachtoentity
			-- 9. ped hash
			-- 10. bool nocollision
			-- 11. int offset
			-- 12. offset z
			-- 13. int alpha
			local new_vehicles = {
				{"WarMachine", {
					{0x9dae1398, 1030400667, 0x2F03547B, 2971578861, 3871829598, 3229200997, 0x187D938D, 782665360},
					{0x9dae1398, nil, nil, {0, 0, 0, 0, 1}, nil, nil, nil, nil, nil, nil, 15},
					{1030400667, {0, -4, 0}, nil, {0, 0, 0, 0, 1}},
					{0x2F03547B, {0, -8, 4}, {-90, 0, 0}, {0, 0, 0, 0, 1}, false, nil, nil, nil, 0x97F5FE8D, true},
					{2971578861, {-0.3, -0.6, 9.8}, {-90, 0, 0}, nil, nil, nil, 16, 3},
					{3229200997, {0, 0, 9.8}, {-90, 0, 0}, nil, nil, nil, 16, 3},
					{0x187D938D, {0, -8.25, 5.3}, nil, {0, 0, 0, 0, 1}},
					{782665360, {0, -8, 3.1}, nil, {0, 0, 0, 0, 1}},
					}, },
				{"Deer Rider", {
					{0xE5BA6858},
					{0xE5BA6858, nil, nil, {0, 0, 0, 0, 1}, true, nil, nil, nil, nil, nil, 3},
					{0, {0, -0.225, 0.225}, nil, nil, nil, nil, nil, nil, 0xD86B5A95},
					}, },
				{"Attach Tree", {
					{3015194288},
					{0},
					{3015194288, {0, 0, -0.3}},
					}, },				
				{"XXL Plane 2", {
					{0x39D6E83F, 0xFB133A17, 0x3D6AAA9B, 0x810369E2, 0xD577C962},
					{0x39D6E83F, nil, nil, {0, 0, 0, 0, 1}}, -- hydra

					{0xFB133A17, {13, 0, 0}, {90, 0, 180}, {0, 0, 0, 0, 1}, false, nil, nil, nil, 0x97F5FE8D, true}, -- savage	2
					{0xFB133A17, {35, 0, 0}, {90, 0, 180}, {0, 0, 0, 0, 1}, false, nil, nil, nil, 0x97F5FE8D, true},
					{0xFB133A17, {-13, 0, 0}, {90, 0, 180}, {0, 0, 0, 0, 1}, false, nil, nil, nil, 0x97F5FE8D, true},
					{0xFB133A17, {-35, 0, 0}, {90, 0, 180}, {0, 0, 0, 0, 1}, false, nil, nil, nil, 0x97F5FE8D, true},

					{0x3D6AAA9B, {-13, -3.5, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}}, -- train	6
					{0x3D6AAA9B, {-35, -3.5, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}},
					{0x3D6AAA9B, {13, -3.5, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}},
					{0x3D6AAA9B, {35, -3.5, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}},

					{0x3D6AAA9B, {27.5, -0.5, 0}, {0, -90, -90}, {0, 0, 0, 0, 1}}, -- train	10
					{0x3D6AAA9B, {27.5, -2.8, 0}, {0, 90, -90}, {0, 0, 0, 0, 1}},
					{0x3D6AAA9B, {12.4, -0.5, 0}, {0, 90, 90}, {0, 0, 0, 0, 1}},
					{0x3D6AAA9B, {12.4, -2.8, 0}, {0, -90, 90}, {0, 0, 0, 0, 1}},
					{0x3D6AAA9B, {-27.5, -0.5, 0}, {0, 90, 90}, {0, 0, 0, 0, 1}},
					{0x3D6AAA9B, {-27.5, -2.8, 0}, {0, -90, 90}, {0, 0, 0, 0, 1}},
					{0x3D6AAA9B, {-12.4, -0.5, 0}, {0, -90, -90}, {0, 0, 0, 0, 1}},
					{0x3D6AAA9B, {-12.4, -2.8, 0}, {0, 90, -90}, {0, 0, 0, 0, 1}},

					{0x810369E2, {0, 2, -1}, {0, 0, 0}, {0, 0, 0, 0, 1}}, -- dump / head	18

					{0xD577C962, {3.5, -4, -0.5}, {0, 0, 0}, {0, 0, 0, 0, 1}}, -- bus	19
					{0xD577C962, {-3.5, -4, -0.5}, {0, 0, 0}, {0, 0, 0, 0, 1}},
					{0xD577C962, {0, 0, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}},
					{0xD577C962, {0, 0, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}},
					{0xD577C962, {0, 0, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}},
					{0xD577C962, {0, 0, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}},
					{0xD577C962, {0, 0, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}},
					{0xD577C962, {0, 0, 0}, {0, 0, 0}, {0, 0, 0, 0, 1}},
					}, },
			}
			m.add.a("Delete Custom Vehicles", m.p["custom_veh_builder"].id, function ()
				l("Clearing Custom Vehicles.")
				clear(entitys["vehicle_builder"])
				entitys["vehicle_builder"] = {}
				n("Cleared Custom Vehicles.")
				end)
			for i = 1, #new_vehicles do
				m.add.a(new_vehicles[i][1], m.p["custom_veh_builder"].id, function ()
					local data = new_vehicles[i][2]
					spawn_custom_vehicle(data, "vehicle_builder")
					end)
			end
			local active_vehicle, boneid, offsetX, offsetY, offsetZ, rotationX, rotationY, rotationZ
			active_vehicle = m.add.u("Select Vehicle", "autoaction_value_i", m.p["custom_veh_builder"].id, function()
				offsetX.value_i = 0
				offsetY.value_i = 0
				offsetZ.value_i = 0
				rotationX.value_i = 0
				rotationY.value_i = 0
				rotationZ.value_i = 0
				end)
				active_vehicle.min_i = 2
				active_vehicle.max_i = 250
			boneid = m.add.u("Attach To BoneID", "autoaction_value_i", m.p["custom_veh_builder"].id, function(f)
				local offset = v3((offsetX.value_i / 10), (offsetY.value_i / 10), (offsetZ.value_i / 10))
				local rotation = v3(rotationX.value_i, rotationY.value_i, rotationZ.value_i)
				local main = entitys["vehicle_builder"][1]
				local move = entitys["vehicle_builder"][active_vehicle.value_i]
				if main and move then
					req.ctrl(main)
					req.ctrl(move)
					s.attach(move, main, boneid.value_i, offset, rotation, false, false, false, 2, true)
				end
				end)
				boneid.min_i = 0
				boneid.max_i = 100
			offsetX = m.add.u("Offset X", "autoaction_value_i", m.p["custom_veh_builder"].id, function (f)
				local offset = v3((f.value_i / 10), (offsetY.value_i / 10), (offsetZ.value_i / 10))
				local rotation = v3(rotationX.value_i, rotationY.value_i, rotationZ.value_i)
				local main = entitys["vehicle_builder"][1]
				local move = entitys["vehicle_builder"][active_vehicle.value_i]
				if main and move then
					req.ctrl(main)
					req.ctrl(move)
					s.attach(move, main, boneid.value_i, offset, rotation, false, false, false, 2, true)
				end
				end)
				offsetX.min_i = -500
				offsetX.max_i = 500
			offsetY = m.add.u("Offset Y", "autoaction_value_i", m.p["custom_veh_builder"].id, function (f)
				local offset = v3((offsetX.value_i / 10), (f.value_i / 10), (offsetZ.value_i / 10))
				local rotation = v3(rotationX.value_i, rotationY.value_i, rotationZ.value_i)
				local main = entitys["vehicle_builder"][1]
				local move = entitys["vehicle_builder"][active_vehicle.value_i]
				if main and move then
					req.ctrl(main)
					req.ctrl(move)
					s.attach(move, main, boneid.value_i, offset, rotation, false, false, false, 2, true)
				end
				end)
				offsetY.min_i = -500
				offsetY.max_i = 500
			offsetZ = m.add.u("Offset Z", "autoaction_value_i", m.p["custom_veh_builder"].id, function (f)
				local offset = v3((offsetX.value_i / 10), (offsetY.value_i / 10), (f.value_i / 10))
				local rotation = v3(rotationX.value_i, rotationY.value_i, rotationZ.value_i)
				local main = entitys["vehicle_builder"][1]
				local move = entitys["vehicle_builder"][active_vehicle.value_i]
				if main and move then
					req.ctrl(main)
					req.ctrl(move)
					s.attach(move, main, boneid.value_i, offset, rotation, false, false, false, 2, true)
				end
				end)
				offsetZ.min_i = -500
				offsetZ.max_i = 500
			rotationX = m.add.u("Rotation X", "autoaction_value_i", m.p["custom_veh_builder"].id, function (f)
				local offset = v3((offsetX.value_i / 10), (offsetY.value_i / 10), (offsetZ.value_i / 10))
				local rotation = v3(f.value_i, rotationY.value_i, rotationZ.value_i)
				local main = entitys["vehicle_builder"][1]
				local move = entitys["vehicle_builder"][active_vehicle.value_i]
				if main and move then
					req.ctrl(main)
					req.ctrl(move)
					s.attach(move, main, boneid.value_i, offset, rotation, false, false, false, 2, true)
				end
				end)
				rotationX.min_i = -360
				rotationX.max_i = 360
			rotationY = m.add.u("Rotation Y", "autoaction_value_i", m.p["custom_veh_builder"].id, function (f)
				local offset = v3((offsetX.value_i / 10), (offsetY.value_i / 10), (offsetZ.value_i / 10))
				local rotation = v3(rotationX.value_i, f.value_i, rotationZ.value_i)
				local main = entitys["vehicle_builder"][1]
				local move = entitys["vehicle_builder"][active_vehicle.value_i]
				if main and move then
					req.ctrl(main)
					req.ctrl(move)
					s.attach(move, main, boneid.value_i, offset, rotation, false, false, false, 2, true)
				end
				end)
				rotationY.min_i = -360
				rotationY.max_i = 360
			rotationZ = m.add.u("Rotation Z", "autoaction_value_i", m.p["custom_veh_builder"].id, function (f)
				local offset = v3((offsetX.value_i / 10), (offsetY.value_i / 10), (offsetZ.value_i / 10))
				local rotation = v3(rotationX.value_i, rotationY.value_i, f.value_i)
				local main = entitys["vehicle_builder"][1]
				local move = entitys["vehicle_builder"][active_vehicle.value_i]
				if main and move and main ~= move then
					req.ctrl(main)
					req.ctrl(move)
					s.attach(move, main, boneid.value_i, offset, rotation, false, false, false, 2, true)
				end
				end)
				rotationZ.min_i = -360
				rotationZ.max_i = 360]]
	m.p["exp_beam"] = m.add.p("Explosive Beam on Horn", m.p["parent"])
		m.p["exp_beam"].hidden = settings["explosive_beam_hidden"]
		m.p["exp_beam"] = m.p["exp_beam"].id
		m.t["exp_beam"] = m.add.t("Enable Beam on Horn", m.p["exp_beam"], function (f)
			settings["exp_beam"] = f.on
			if f.on then
				local user = s.id()
				if g.scid(m.t["exp_beam_other"].value_i) ~= -1 then user = m.t["exp_beam_other"].value_i end
				local ped_id = s.ped(user)
				local veh, pos, pos2, einheitsvektor, modifikator
				local vectorV3 = v3()
				local pxmin, pxmax, pymin, pymax, pzmin, pzmax
				if player.is_player_pressing_horn(user) then
					veh = s.vehicle(ped_id)
					for i = 0, 5 do
						pos = s.gcoords(veh)
						s.wait(5)
						if i > 0 then
							pos2 = s.gcoords(veh)
							vectorV3.x = pos2.x - pos.x
							vectorV3.y = pos2.y - pos.y
							vectorV3.z = pos2.z - pos.z
							if vectorV3.x ~= 0 and vectorV3.y ~= 0 and vectorV3.z ~= 0 then
								einheitsvektor = 1/(((vectorV3.x*vectorV3.x)+(vectorV3.y*vectorV3.y)+(vectorV3.z*vectorV3.z))^0.5)
								modifikator = s.random(settings["exp_beam_min"], settings["exp_beam_max"])
								pos2.x = pos2.x + (modifikator * einheitsvektor * vectorV3.x)
								pos2.y = pos2.y + (modifikator * einheitsvektor * vectorV3.y)
								pos2.z = pos2.z + (modifikator * einheitsvektor * vectorV3.z)
								pxmin = math.floor(pos2.x - settings["exp_beam_radius"])
								pxmax = math.floor(pos2.x + settings["exp_beam_radius"])
								pymin = math.floor(pos2.y - settings["exp_beam_radius"])
								pymax = math.floor(pos2.y + settings["exp_beam_radius"])
								pzmin = math.floor(pos2.z - settings["exp_beam_radius"])
								pzmax = math.floor(pos2.z + settings["exp_beam_radius"])
								pos2.x = s.random(pxmin, pxmax)
								pos2.y = s.random(pymin, pymax)
								pos2.z = s.random(pzmin, pzmax)
								s.explode(pos2, settings["exp_beam_type"], true, false, 0.1, ped_id)
								pos2.x = s.random(pxmin, pxmax)
								pos2.y = s.random(pymin, pymax)
								pos2.z = s.random(pzmin, pzmax)
								s.explode(pos2, settings["exp_beam_type_2"], true, false, 0.1, ped_id)
							end
						end
					end
				end
			end
			return u.stop(f)
			end)
			m.t["exp_beam"].on = settings["exp_beam"]
		m.t["exp_beam_type"] = m.add.u("Select Explosion", "action_value_i", m.p["exp_beam"], function () settings["exp_beam_type"] = m.t["exp_beam_type"].value_i n("Beam Explosion Type 1: "..settings["exp_beam_type"]) end)
       		m.t["exp_beam_type"].max_i   = 74
			m.t["exp_beam_type"].min_i   = 0
	        m.t["exp_beam_type"].value_i = settings["exp_beam_type"]
		m.t["exp_beam_type_2"] = m.add.u("Select Explosion 2", "action_value_i", m.p["exp_beam"], function () settings["exp_beam_type_2"] = m.t["exp_beam_type_2"].value_i n("Beam Explosion Type 2: "..settings["exp_beam_type_2"]) end)
	        m.t["exp_beam_type_2"].max_i   = 74
			m.t["exp_beam_type_2"].min_i   = 0
	        m.t["exp_beam_type_2"].value_i = settings["exp_beam_type_2"]
		m.t["exp_beam_radius"] = m.add.u("Select Scattering", "action_value_i", m.p["exp_beam"], function () settings["exp_beam_radius"] = m.t["exp_beam_radius"].value_i n("Beam Radius: "..settings["exp_beam_radius"]) end)
	        m.t["exp_beam_radius"].max_i   = 10
			m.t["exp_beam_radius"].min_i   = 1
	        m.t["exp_beam_radius"].value_i = settings["exp_beam_radius"]
		m.t["exp_beam_min"] = m.add.u("Select Min Range", "action_value_i", m.p["exp_beam"], function () settings["exp_beam_min"] = m.t["exp_beam_min"].value_i n("Beam Min Range: "..settings["exp_beam_min"]) end)
	        m.t["exp_beam_min"].max_i   = 100
			m.t["exp_beam_min"].min_i   = 10
	        m.t["exp_beam_min"].value_i = settings["exp_beam_min"]
	        m.t["exp_beam_min"].mod_i = 5
		m.t["exp_beam_max"] = m.add.u("Select Max Range", "action_value_i", m.p["exp_beam"], function () settings["exp_beam_max"] = m.t["exp_beam_max"].value_i n("Beam Max Range: "..settings["exp_beam_max"]) end)
	        m.t["exp_beam_max"].max_i   = 300
			m.t["exp_beam_max"].min_i   = 100
	        m.t["exp_beam_max"].value_i = settings["exp_beam_max"]
	        m.t["exp_beam_max"].mod_i = 5
		m.t["exp_beam_other"] = m.add.u("Enable Horn for Player", "action_value_i", m.p["exp_beam"], function ()
				if g.scid(m.t["exp_beam_other"].value_i) ~= -1 then
					n("Selected Player: "..g.name(m.t["exp_beam_other"].value_i))
				else n("Not a valid Player.")
				end
			end)
	        m.t["exp_beam_other"].max_i   = 31
			m.t["exp_beam_other"].min_i   = -1
	        m.t["exp_beam_other"].value_i = -1
	m.p["bac"] = m.add.p("Better Animal Changer", m.p["parent"], function ()
		if m.t["revert_outfit"].on then
			if #outfits["bac_outfit"]["clothes"] < 1 then
				if player.get_player_model(s.id()) == 0x9C9EFFD8 or player.get_player_model(s.id()) == 0x705E61F2 then
					for i = 1, 11 do
						outfits["bac_outfit"]["textures"][i] = ped.get_ped_texture_variation(o.ped(), i)
						outfits["bac_outfit"]["clothes"][i] = ped.get_ped_drawable_variation(o.ped(), i)
					end
					local loop = {0, 1, 2, 6, 7}
					for z = 1, #loop do
						outfits["bac_outfit"]["prop_ind"][z] = ped.get_ped_prop_index(o.ped(), loop[z])
						outfits["bac_outfit"]["prop_text"][z] = ped.get_ped_prop_texture_index(o.ped(), loop[z])
					end
					local g = "male"
					if player.is_player_female(s.id()) then
						g = "female"
					end
					outfits["bac_outfit"]["gender"] = g
				end
			end
		end
		end)
		m.p["bac"].hidden = settings["animal_changer_hidden"]
		m.p["bac"] = m.p["bac"].id
		m.p["bac_ga"] = m.add.p("Ground Animals", m.p["bac"]).id
			m.add.a("Bigfoot", m.p["bac_ga"], function () c_model(0x61D4C771, nil, true, nil, true) end)
			m.add.a("Bigfoot 2", m.p["bac_ga"], function () c_model(0xAD340F5A, nil, true, nil, true) end)
			m.add.a("Boar", m.p["bac_ga"], function () c_model(0xCE5FF074) end)
			m.add.a("Cat", m.p["bac_ga"], function () c_model(0x573201B8) end)
			m.add.a("Chimp", m.p["bac_ga"], function () c_model(0xA8683715, nil, nil, true) end)
			m.add.a("Chop", m.p["bac_ga"], function () c_model(0x14EC17EA, nil, true) end)
			m.add.a("Cow", m.p["bac_ga"], function () c_model(0xFCFA9E1E) end)
			m.add.a("Coyote", m.p["bac_ga"], function () c_model(0x644AC75E) end)
			m.add.a("Deer", m.p["bac_ga"], function () c_model(0xD86B5A95) end)
			m.add.a("German Shepherd", m.p["bac_ga"], function () c_model(0x431FC24C, nil, true) end)
			m.add.a("Hen", m.p["bac_ga"], function () c_model(0x6AF51FAF) end)
			m.add.a("Husky", m.p["bac_ga"], function () c_model(0x4E8F95A2, nil, true) end)
			m.add.a("Mountain Lion", m.p["bac_ga"], function () c_model(0x1250D7BA, nil, true) end)
			m.add.a("Panther", m.p["bac_ga"], function () c_model(0xE71D5E68, nil, true) end)
			m.add.a("Pig", m.p["bac_ga"], function () c_model(0xB11BAB56) end)
			m.add.a("Poodle", m.p["bac_ga"], function () c_model(0x431D501C) end)
			m.add.a("Pug", m.p["bac_ga"], function () c_model(0x6D362854) end)
			m.add.a("Rabbit", m.p["bac_ga"], function () c_model(0xDFB55C81) end)
			m.add.a("Rat", m.p["bac_ga"], function () c_model(0xC3B52966) end)
			m.add.a("Golden Retriever", m.p["bac_ga"], function () c_model(0x349F33E1, nil, true) end)
			m.add.a("Rhesus", m.p["bac_ga"], function () c_model(0xC2D06F53, nil, nil, true) end)
			m.add.a("Rottweiler", m.p["bac_ga"], function () c_model(0x9563221D, nil, true) end)
			m.add.a("Westy", m.p["bac_ga"], function () c_model(0xAD7844BB) end)
		m.p["bac_wa"] = m.add.p("Water Animals", m.p["bac"], function () n("Note that these Models will only work in Water!", 48) end).id
			m.add.a("Dolphin", m.p["bac_wa"], function () c_model(0x8BBAB455, true) end)
			m.add.a("Fish", m.p["bac_wa"], function () c_model(0x2FD800B7, true) end)
			m.add.a("Hammershark", m.p["bac_wa"], function () c_model(0x3C831724, true) end)
			m.add.a("Humpback", m.p["bac_wa"], function () c_model(0x471BE4B2, true) end)
			m.add.a("Killerwhale", m.p["bac_wa"], function () c_model(0x8D8AC8B9, true) end)
			m.add.a("Shark", m.p["bac_wa"], function () c_model(0x06C3F072, true, true) end)
			m.add.a("Stingray", m.p["bac_wa"], function () c_model(0xA148614D, true) end)
		m.p["bac_fa"] = m.add.p("Flying Animals", m.p["bac"]).id
			m.add.a("Cormorant", m.p["bac_fa"], function () c_model(0x56E29962) end)
			m.add.a("Chickenhawk", m.p["bac_fa"], function () c_model(0xAAB71F62) end)
			m.add.a("Crow", m.p["bac_fa"], function () c_model(0x18012A9F) end)
			m.add.a("Pigeon", m.p["bac_fa"], function () c_model(0x06A20728) end)
			m.add.a("Seagull", m.p["bac_fa"], function () c_model(0xD3939DFD) end)
		m.p["bac_sm"] = m.add.p("Standard Models", m.p["bac"]).id
			m.add.a("Franklin", m.p["bac_sm"], function () c_model(0x9B22DBAF, nil, nil, nil, true) end)
			m.add.a("Michael", m.p["bac_sm"], function () c_model(0x0D7114C9, nil, nil, nil, true) end)
			m.add.a("Trevor", m.p["bac_sm"], function () c_model(0x9B810FA2, nil, nil, nil, true) end)
			m.add.a("MP Female", m.p["bac_sm"], function () c_model(0x9C9EFFD8, nil, true, nil, true) end)
			m.add.a("MP Male", m.p["bac_sm"], function () c_model(0x705E61F2, nil, true, nil, true) end)
		m.t["bl_mdl_change"] = m.add.t("Safe Model Change", m.p["bac"], function (f) settings["bl_mdl_change"] = f.on end)
			m.t["bl_mdl_change"].on = settings["bl_mdl_change"]
		m.t["revert_outfit"] = m.add.t("Revert back Outfit", m.p["bac"], function (f)
			settings["revert_outfit"] = f.on
			end)
			m.t["revert_outfit"].on = settings["revert_outfit"]
		m.add.a("Fix endless loading Screen", m.p["bac"], function ()
			c_model(0x9B22DBAF, nil, nil, nil, true)
			s.wait(100)
			ped.set_ped_health(o.ped(), 0)
			end)
	m.p["ptfx"] = m.add.p("PTFX", m.p["parent"])
		m.p["ptfx"].hidden = settings["ptfx_hidden"]
		m.p["ptfx"] = m.p["ptfx"].id
		m.p["new_years_eve"] = m.add.u("New years eve", "value_i", m.p["ptfx"], function(f)
			if f.on then
				local pos = o.coords() + v3(0, 0, 5)
				s.bullet(pos, pos + v3(s.random(-25, 25), s.random(-25, 25), s.random(50, 75)), 0, 0x7F7497E5, o.ped(), true, false, 125)
				s.wait(f.value_i)
			end
			return u.stop(f)
			end)
			m.p["new_years_eve"].max_i = 500
			m.p["new_years_eve"].mod_i = 25
			m.p["new_years_eve"].value_i = 100
		m.t["sparkling_ass"] = m.add.t("Sparkling Ass", m.p["ptfx"], function (f)
			if f.on then
				graphics.set_next_ptfx_asset("scr_indep_fireworks")
				while not graphics.has_named_ptfx_asset_loaded("scr_indep_fireworks") do
					graphics.request_named_ptfx_asset("scr_indep_fireworks")
					s.wait(0)
				end
				graphics.start_networked_particle_fx_non_looped_at_coord("scr_indep_firework_trail_spawn", o.coords(), v3(60, 0, 0), 0.33, true, true, true)
				s.wait(25)
			end
			settings["sparkling_ass"] = f.on
			return u.stop(f)
			end)
			m.t["sparkling_ass"].on = settings["sparkling_ass"]
		m.t["sparkling_tires"] = m.add.t("Sparkling Tires", m.p["ptfx"], function (f)
			if f.on then
				local veh = s.vehicle(o.ped())
				if veh ~= 0 then
					local wheel_index = {"wheel_lf", "wheel_rf", "wheel_lr", "wheel_rr"}
					for i = 1, #wheel_index do
						req.model(1803116220)
						local pos_obj = spawn.object(1803116220, o.coords())
						entity.set_entity_collision(pos_obj, false, false, false)
						s.visible(pos_obj, false)
						local index = entity.get_entity_bone_index_by_name(veh, wheel_index[i])
						s.attach(pos_obj, veh, index, v3(), v3(), true, true, false, 0, true)
						graphics.set_next_ptfx_asset("scr_indep_fireworks")
						while not graphics.has_named_ptfx_asset_loaded("scr_indep_fireworks") do
							graphics.request_named_ptfx_asset("scr_indep_fireworks")
							s.wait(0)
						end
						graphics.start_networked_particle_fx_non_looped_at_coord("scr_indep_firework_trail_spawn", s.gcoords(pos_obj), v3(60, 0, 0), 0.5, true, true, true)
						req.ctrl(pos_obj, 5)
						entity.detach_entity(pos_obj)
						entity.set_entity_velocity(pos_obj, v3())
						s_coords(pos_obj, v3(8000, 8000, -1000))
						entity.delete_entity(pos_obj)
					end
					s.unload(1803116220)
					s.wait(25)
				end
			end
			settings["sparkling_tires"] = f.on
			return u.stop(f)
			end)
			m.t["sparkling_tires"].on = settings["sparkling_tires"]
		m.t["smoke_area"] = m.add.t("Smoke Area", m.p["ptfx"], function (f)
			if f.on then
				for i = 1, 16 do
					local pos = o.coords()
					local rad = 2 * math.pi
					rad = rad / 16
					rad = rad * i
					pos.x = pos.x + (18 * math.cos(rad))
					pos.y = pos.y + (18 * math.sin(rad))
					pos.z = pos.z - 2.5
					graphics.set_next_ptfx_asset("scr_recartheft")
					while not graphics.has_named_ptfx_asset_loaded("scr_recartheft") do
						graphics.request_named_ptfx_asset("scr_recartheft")
						s.wait(0)
					end
					graphics.start_networked_particle_fx_non_looped_at_coord("scr_wheel_burnout", pos, v3(), 2.5, true, true, true)
					s.wait(40)
				end
			end
			settings["smoke_area"] = f.on
			return u.stop(f)
			end)
			m.t["smoke_area"].on = settings["smoke_area"]
		m.t["fire_circle"] = m.add.t("Fire Circle", m.p["ptfx"], function (f)
			if f.on then
				if ptfxs["fire_balls"][1] == nil then
					for i = 1, 48 do
						req.model(1803116220)
						ptfxs["fire_balls"][i] = spawn.object(1803116220, o.coords())
						entity.set_entity_collision(ptfxs["fire_balls"][i], false, false, false)
						s.visible(ptfxs["fire_balls"][i], false)
					end
					s.unload(1803116220)
				end
				for i = 1, 48 do
					local pos = o.coords()
					local rad = 2 * math.pi
					rad = rad / 48
					rad = rad * s.random(1, 48)
					pos.x = pos.x + (10 * math.cos(rad))
					pos.y = pos.y + (10 * math.sin(rad))
					pos.z = pos.z - 1.5
					s_coords(ptfxs["fire_balls"][i], pos)
				end
				s.wait(10)
				if ptfxs["fire_circle"][1] == nil then
					for i = 1, 48 do
						graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
						while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
							graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
							s.wait(0)
						end
						ptfxs["fire_circle"][i] = graphics.start_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", ptfxs["fire_balls"][i], v3(), v3(90, 0, 0), 1)
					end
				end
			end
			if not f.on then
				clear(ptfxs["fire_balls"])
				ptfxs["fire_balls"] = {}
				if ptfxs["fire_circle"][1] then
					for i = 1, #ptfxs["fire_circle"] do
						graphics.remove_particle_fx(ptfxs["fire_circle"][i], true)
					end
					ptfxs["fire_circle"] = {}
				end
			end
			return u.stop(f)
			end)
			m.t["fire_circle"].on = settings["fire_circle"]
		m.t["fire_fart"] = m.add.u("Fire Fart", "action_value_i", m.p["ptfx"], function (f)
			settings["fire_fart"] = m.t["fire_fart"].value_i
			local veh = s.vehicle(o.ped())
			if veh ~= 0 then
				n("Fire Fart in a vehicle is too dangerous, get out!", 162)
			else
				local hash = 0x187D938D
				local dict = "weap_xs_vehicle_weapons"
				local anim = "muz_xs_turret_flamethrower_looping"
				req.model(hash)
				local heading = o.heading()
				local spawned_veh = spawn.vehicle(hash, o.coords(), heading)
				req.ctrl(spawned_veh)
				s.visible(spawned_veh, false)
				s.unload(hash)
				decorator.decor_set_int(spawned_veh, "MPBitset", 1 << 10)
				ped.set_ped_into_vehicle(o.ped(), spawned_veh, -1)
				s.wait(500)
				graphics.set_next_ptfx_asset(dict)
				while not graphics.has_named_ptfx_asset_loaded(dict) do
					graphics.request_named_ptfx_asset(dict)
					s.wait(0)
				end
				local mult = f.value_i
				local fire = graphics.start_ptfx_looped_on_entity(anim, o.ped(), v3(), v3(180, 0, 0), mult * 0.1)
				local pos = s.gcoords(spawned_veh)
				local rot = entity.get_entity_rotation(spawned_veh)
				local dir = rot
				dir:transformRotToDir()
				dir = dir * (1 * mult)
				dir.z = pos.z + 0.6666666 * mult
				local vec = dir
				entity.set_entity_velocity(spawned_veh, vec)
				s.wait(250 * mult)
				graphics.remove_particle_fx(fire, true)
				while ped.is_ped_in_any_vehicle(o.ped()) do
					ai.task_leave_vehicle(o.ped(), spawned_veh, 16)
					s.wait(25)
				end
				clear({spawned_veh})
			end
			end)
			m.t["fire_fart"].max_i = 16
			m.t["fire_fart"].min_i = 4
			m.t["fire_fart"].value_i = settings["fire_fart"]
		m.t["fire_ass"] = m.add.t("Fire Ass", m.p["ptfx"], function (f)
			settings["fire_ass"] = f.on
			if f.on then
				if ptfxs["fire_ass_ball"] == nil then
					req.model(1803116220)
					ptfxs["fire_ass_ball"] = spawn.object(1803116220, o.coords())
					entity.set_entity_collision(ptfxs["fire_ass_ball"], false, false, false)
					s.visible(ptfxs["fire_ass_ball"], false)
					s.unload(1803116220)
				end	
				if ptfxs["fire_ass"] == nil then
					local dict = "weap_xs_vehicle_weapons"
					local anim = "muz_xs_turret_flamethrower_looping"
					graphics.set_next_ptfx_asset(dict)
					while not graphics.has_named_ptfx_asset_loaded(dict) do
						graphics.request_named_ptfx_asset(dict)
						s.wait(0)
					end
					ptfxs["fire_ass"] = graphics.start_ptfx_looped_on_entity(anim, o.ped(), v3(), v3(180, 0, 0), 0.333)
				end
				local pos = o.coords()
				s_coords(ptfxs["fire_ass_ball"], o.coords())
			end
			if not f.on then
				if ptfxs["fire_ass"] then
					graphics.remove_particle_fx(ptfxs["fire_ass"], true)
					ptfxs["fire_ass"] = nil
				end
				clear({ptfxs["fire_ass_ball"]})
				ptfxs["fire_ass_ball"] = nil
			end
			return u.stop(f)
			end)
			m.t["fire_ass"].on = settings["fire_ass"]
	m.p["misc"] = m.add.p("Miscellaneous", m.p["parent"])
		m.p["misc"].hidden = settings["misc_hidden"]
		m.p["misc"] = m.p["misc"].id
		m.p["weapon"] = m.add.p("Weapon-Features", m.p["misc"]).id
			m.t["load_weapons"] = m.add.t("Load Weapons", m.p["weapon"], function (f)
				if f.on then
					local time = s.time() + 500
					while f.on do
						s.wait(0)
						if time < s.time() then
							break
						end
					end
					local all_weapons = weapon.get_all_weapon_hashes()
					for i = 1, #all_weapons do
						if weapon.has_ped_got_weapon(o.ped(), all_weapons[i]) then
							local allowed = false
							for y = 1, #ext_data.weapons do
								if all_weapons[i] == ext_data.weapons[y][1] then
									allowed = true
								end
							end
							if not allowed then
								weapon.remove_weapon_from_ped(o.ped(), all_weapons[i])
							end
						end
					end
					for i = 1, #ext_data.weapons do
						if not weapon.has_ped_got_weapon(o.ped(), ext_data.weapons[i][1]) then
							weapon.give_delayed_weapon_to_ped(o.ped(), ext_data.weapons[i][1], 0, 0);
						end
					end
					for i = 1, #ext_data.weapons do
						for ii = 2, #ext_data.weapons[i] do
							if not weapon.has_ped_got_weapon_component(o.ped(), ext_data.weapons[i][1], ext_data.weapons[i][ii]) then
								for iii = 2, #ext_data.weapons[i] do weapon.give_weapon_component_to_ped(o.ped(), ext_data.weapons[i][1], ext_data.weapons[i][iii]) end
								weapon.set_ped_ammo(o.ped(), ext_data.weapons[i][1], 9999)
							end
						end
					end
				end
				settings["load_weapons"] = f.on
				return u.stop(f)
				end)
				m.t["load_weapons"].on = settings["load_weapons"]
			m.p["flamethrower"] = m.add.p("Flamethrower", m.p["weapon"]).id
				m.t["flamethrower_scale"] = m.add.u("Scale", "autoaction_value_i", m.p["flamethrower"], function ()
					settings["flamethrower_scale"] = m.t["flamethrower_scale"].value_i
					end)
					m.t["flamethrower_scale"].min_i = 1
					m.t["flamethrower_scale"].max_i = 25
					m.t["flamethrower_scale"].value_i = settings["flamethrower_scale"]
				m.t["flamethrower"] = m.add.t("Flamethrower", m.p["flamethrower"], function (f)
					if f.on then
						if player.is_player_free_aiming(s.id()) then
							graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
							while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
								graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
								s.wait(0)
							end
							if ptfxs["alien"] == nil then
								req.model(1803116220)
								ptfxs["alien"] = spawn.object(1803116220, o.coords())
								entity.set_entity_collision(ptfxs["alien"], false, false, false)
								s.visible(ptfxs["alien"], false)
								s.unload(1803116220)
							end
							local success, pos_h = ped.get_ped_bone_coords(o.ped(), 0xdead, v3())
							while not success do
								s.wait(0)
								success, pos_h = ped.get_ped_bone_coords(o.ped(), 0xdead, v3())
							end
							s_coords(ptfxs["alien"], pos_h)
							entity.set_entity_rotation(ptfxs["alien"], cam.get_gameplay_cam_rot())
							if ptfxs["flamethrower"] == nil then
								ptfxs["flamethrower"] = graphics.start_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", ptfxs["alien"], v3(), v3(), settings["flamethrower_scale"])
								graphics.set_particle_fx_looped_scale(ptfxs["flamethrower"], settings["flamethrower_scale"])
							end
						else
							if ptfxs["flamethrower"] then
								graphics.remove_particle_fx(ptfxs["flamethrower"], true)
								ptfxs["flamethrower"] = nil
								clear({ptfxs["alien"]})
								ptfxs["alien"] = nil
							end
						end
					end
					if not f.on then
						if ptfxs["flamethrower"] then
							graphics.remove_particle_fx(ptfxs["flamethrower"], true)
							ptfxs["flamethrower"] = nil
							clear({ptfxs["alien"]})
							ptfxs["alien"] = nil
						end
					end
					settings["flamethrower"] = f.on
					return u.stop(f)
					end)
					m.t["flamethrower"].on = settings["flamethrower"]
				m.t["flamethrower_green"] = m.add.t("Flamethrower - Green", m.p["flamethrower"], function (f)
					if f.on then
						if player.is_player_free_aiming(s.id()) then
							graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
							while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
								graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
								s.wait(0)
							end
							if ptfxs["alien"] == nil then
								req.model(1803116220)
								ptfxs["alien"] = spawn.object(1803116220, o.coords())
								entity.set_entity_collision(ptfxs["alien"], false, false, false)
								s.visible(ptfxs["alien"], false)
								s.unload(1803116220)
							end
							local success, pos_h = ped.get_ped_bone_coords(o.ped(), 0xdead, v3())
							while not success do
								s.wait(0)
								success, pos_h = ped.get_ped_bone_coords(o.ped(), 0xdead, v3())
							end
							s_coords(ptfxs["alien"], pos_h)
							entity.set_entity_rotation(ptfxs["alien"], cam.get_gameplay_cam_rot())
							if ptfxs["flamethrower_green"] == nil then
								ptfxs["flamethrower_green"] = graphics.start_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping_sf", ptfxs["alien"], v3(), v3(), settings["flamethrower_scale"])
							end
						else
							if ptfxs["flamethrower_green"] then
								graphics.remove_particle_fx(ptfxs["flamethrower_green"], true)
								ptfxs["flamethrower_green"] = nil
								clear({ptfxs["alien"]})
								ptfxs["alien"] = nil
							end
						end
					end
					if not f.on then
						if ptfxs["flamethrower_green"] then
							graphics.remove_particle_fx(ptfxs["flamethrower_green"], true)
							ptfxs["flamethrower_green"] = nil
							clear({ptfxs["alien"]})
							ptfxs["alien"] = nil
						end
					end
					settings["flamethrower_green"] = f.on
					return u.stop(f)
					end)
					m.t["flamethrower_green"].on = settings["flamethrower_green"]
			m.p["shoot"] = m.add.p("Shoot Objects", m.p["weapon"]).id
				m.t["shoot"] = m.add.t("Enable Object Shoot", m.p["shoot"], function (f)
					if f.on then
						for i = 1, #shoot_entitys do
							if settings[shoot_entitys[i][1]] and ped.is_ped_shooting(o.ped()) then
								if #entitys["shooting"] > 128 then
									clear(entitys["shooting"])
									entitys["shooting"] = {}
								end
								req.model(shoot_entitys[i][2])
								local pos = o.coords()
								local dir = cam.get_gameplay_cam_rot()
								dir:transformRotToDir()
								dir = dir * 8
								pos = pos + dir
								if streaming.is_model_an_object(shoot_entitys[i][2]) then
									entitys["shooting"][#entitys["shooting"] + 1] = spawn.object(shoot_entitys[i][2], pos)
								end
								dir = nil
								local pos_target = o.coords()
								dir = cam.get_gameplay_cam_rot()
								dir:transformRotToDir()
								dir = dir * 100
								pos_target = pos_target + dir
								local vectorV3 = pos_target - pos
								entity.apply_force_to_entity(entitys["shooting"][#entitys["shooting"]], 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
							end
						end
					end
					if not f.on then
						clear(entitys["shooting"])
						entitys["shooting"] = {}
					end
					settings["shoot_entitys"] = f.on
					return u.stop(f)
					end)
					m.t["shoot"].on = settings["shoot_entitys"]
				m.add.a("Delete Objects", m.p["shoot"], function ()
					clear(entitys["shooting"])
					entitys["shooting"] = {}
					end)
				for i = 1, #shoot_entitys do
					m.t[shoot_entitys[i][1]] = m.add.t("Shoot "..shoot_entitys[i][1], m.p["shoot"], function (f)
						shoot_entitys[i][3] = f.on
						settings[shoot_entitys[i][1]] = f.on
						end)
						m.t[shoot_entitys[i][1]].on = settings[shoot_entitys[i][1]]
				end
			m.t["delete_gun"] = m.add.t("Delete Gun", m.p["weapon"], function (f)
				if f.on then
					if ped.is_ped_shooting(o.ped()) then
						local delete = player.get_entity_player_is_aiming_at(s.id())
						if delete then
							clear({delete})
						end
					end
				end
				settings["delete_gun"] = f.on
				return u.stop(f)
				end)
				m.t["delete_gun"].on = settings["delete_gun"]
			m.t["kick_gun"] = m.add.t("Kick Gun", m.p["weapon"], function (f)
				if f.on then
					if ped.is_ped_shooting(o.ped()) then
						local pl = player.get_entity_player_is_aiming_at(s.id())
						if ped.is_ped_a_player(pl) then
							n("Kick-Gun hit: " .. g.name(pl))
							kick_pl(false, player.get_player_from_ped(pl))
						end
					end
				end
				settings["kick_gun"] = f.on
				return u.stop(f)
				end)
				m.t["kick_gun"].on = settings["kick_gun"]
			m.t["demigod_gun"] = m.add.t("Give Demi-God for Player", m.p["weapon"], function (f)
				if f.on then
					if ped.is_ped_shooting(o.ped()) then
						local pl = player.get_entity_player_is_aiming_at(s.id())
						if ped.is_ped_a_player(pl) then
							n("Attached Demi-God on Player: " .. g.name(pl))
							attach_entity(ext_data.custom_attachments[1][2], player.get_player_from_ped(pl))
						end
					end
				end
				settings["demigod_gun"] = f.on
				return u.stop(f)
				end)
				m.t["demigod_gun"].on = settings["demigod_gun"]
			m.p["model_gun"] = m.add.p("Model Gun", m.p["weapon"]).id
				m.t["model_gun"] = m.add.t("Standard Model Gun (PEDs)", m.p["model_gun"], function (f)
					if f.on then
						if apply_invisible then
							s.visible(o.ped(), false)
							if model_gun then
								s.visible(model_gun, true)
							end
						else
							s.visible(o.ped(), true)
						end
						if player.is_player_free_aiming(s.id()) then
							local new_model = player.get_entity_player_is_aiming_at(s.id())
							if new_model ~= 0 then
								new_model = entity.get_entity_model_hash(new_model)
								if streaming.is_model_a_ped(new_model) then
									if model_gun then
										clear({model_gun})
										model_gun = nil
									end
									local pl_model = entity.get_entity_model_hash(o.ped())
									if new_model ~= pl_model then
										apply_invisible = false
										s.wait(50)
										local c_weapon = ped.get_current_ped_weapon(o.ped())
										c_model(new_model, nil, nil, nil, true)
										s.wait(25)
										weapon.give_delayed_weapon_to_ped(o.ped(), c_weapon, 0, 1);
									end
								elseif streaming.is_model_a_vehicle(new_model) and m.t["model_gun_ext"].on then
									clear({model_gun})
									model_gun = nil
									apply_invisible = true
									model_gun = spawn.vehicle(new_model, o.coords())
									s.attach(model_gun, o.ped(), 0, v3(), v3(), true, true, false, 0, true)
								elseif streaming.is_model_an_object(new_model) and m.t["model_gun_ext"].on then
									clear({model_gun})
									model_gun = nil
									req.model(new_model)
									model_gun = spawn.object(new_model, o.coords())
									s.unload(new_model)
									apply_invisible = true
									s.attach(model_gun, o.ped(), 0, v3(), v3(), true, true, false, 0, true)
								end
							end
						end
					end
					if not f.on then
						clear({model_gun})
						model_gun = nil
						s.visible(o.ped(), true)
					end
					settings["model_gun"] = f.on
					return u.stop(f)
					end)
					m.t["model_gun"].on = settings["model_gun"]
				m.t["model_gun_ext"] = m.add.t("Add Objects and Vehicles to Model Gun", m.p["model_gun"], function (f) settings["model_gun_ext"] = f.on end)
					m.t["model_gun_ext"].on = settings["model_gun_ext"]
			m.t["rapid_fire"] = m.add.t("Rapid Fire", m.p["weapon"], function (f)
				if f.on then
					if player.is_player_free_aiming(s.id()) then
						if ped.is_ped_shooting(o.ped()) then
							for i = 1, 20 do
								local success, v3_start = ped.get_ped_bone_coords(o.ped(), 0x67f2, v3())
								while not success do
									success, v3_start = ped.get_ped_bone_coords(o.ped(), 0x67f2, v3())
									s.wait(0)
								end
								local dir = cam.get_gameplay_cam_rot()
								dir:transformRotToDir()
								dir = dir * 1.5
								v3_start = v3_start + dir
								dir = nil
								local v3_end = o.coords()
								dir = cam.get_gameplay_cam_rot()
								dir:transformRotToDir()
								dir = dir * 1500
								v3_end = v3_end + dir
								local hash_weapon = ped.get_current_ped_weapon(o.ped())
								s.bullet(v3_start, v3_end, 1, hash_weapon, o.ped(), true, false, 1000)
								s.wait(25)	
							end
						end
					end
				end
				settings["rapid_fire"] = f.on
				return u.stop(f)
				end)
				m.t["rapid_fire"].on = settings["rapid_fire"]
		m.t["teleport_high_in_air"] = m.add.a("Teleport High in Air", m.p["misc"], function ()
			local pos = o.coords()
			while pos.z < 25000 do
				pos.z = pos.z + 500
				tp(pos)
				s.wait(50)
			end
			end)
		m.p["vehicle"] = m.add.p("Vehicle", m.p["misc"]).id
			m.t["tp_own_veh_to_me"] = m.add.a("Teleport Own Vehicle to me", m.p["vehicle"], function ()
				local veh = player.get_personal_vehicle()
				local veh2 = s.vehicle(o.ped())
				if veh ~= 0 and veh2 ~= veh then
					s_coords(veh, OffsetCoords(o.coords(), o.heading(), 5))
					entity.set_entity_heading(veh, o.heading())
				end
				end)
			m.t["tp_own_veh_to_me_drive"] = m.add.a("Teleport Own Vehicle to me and drive", m.p["vehicle"], function ()
				local veh = player.get_personal_vehicle()
				local veh2 = s.vehicle(o.ped())
				if veh ~= 0 and veh2 ~= veh then
					s_coords(veh, o.coords())
					entity.set_entity_heading(veh, o.heading())
					ped.set_ped_into_vehicle(o.ped(), veh, -1)
				end
				end)
			m.t["drive_own_veh"] = m.add.a("Drive Own Vehicle", m.p["vehicle"], function ()
				local veh = player.get_personal_vehicle()
				local veh2 = s.vehicle(o.ped())
				if veh ~= 0 and veh2 ~= veh then
					ped.set_ped_into_vehicle(o.ped(), veh, -1)
				end
				end)
			m.t["tp_to_own_veh"] = m.add.a("Teleport to Own Vehicle", m.p["vehicle"], function ()
				local veh = player.get_personal_vehicle()
				local veh2 = s.vehicle(o.ped())
				l(veh)
				l(veh2)
				if veh ~= 0 and veh2 ~= veh then
					tp(OffsetCoords(s.gcoords(veh), entity.get_entity_heading(veh), -5), 0, entity.get_entity_heading(veh))
				end
				end)
			m.t["always_apply_mods"] = m.add.t("Always apply Vehicle Mods", m.p["vehicle"], function(f)
				settings["always_apply_mods"] = f.on
				end)
				m.t["always_apply_mods"].on = settings["always_apply_mods"]
			m.p["vehicle_colors"] = m.add.p("Vehicle Colors", m.p["vehicle"]).id
				m.t["light_speed"] = m.add.u("Set Speed in Milliseconds", "autoaction_value_i", m.p["vehicle_colors"], function (f) settings["veh_lights_speed"] = f.value_i end)
					m.t["light_speed"].min_i = 25
					m.t["light_speed"].max_i = 2500
					m.t["light_speed"].mod_i = 25
					m.t["light_speed"].value_i = settings["veh_lights_speed"]
				m.p["random_col"] = m.add.p("Random Colors", m.p["vehicle_colors"]).id
					m.t["random_primary"] = m.add.t("Random Primary", m.p["random_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"rainbow_primary"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								vehicle.set_vehicle_custom_primary_colour(veh, s.random(0, 0xffffff))
								s.wait(m.t["light_speed"].value_i)
							end
						end
						settings["random_primary"] = f.on
						return u.stop(f)
						end)
						m.t["random_primary"].on = settings["random_primary"]
					m.t["random_secondary"] = m.add.t("Random Secondary", m.p["random_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"rainbow_secondary"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								vehicle.set_vehicle_custom_secondary_colour(veh, s.random(0, 0xffffff))
								s.wait(m.t["light_speed"].value_i)
							end
						end
						settings["random_secondary"] = f.on
						return u.stop(f)
						end)
						m.t["random_secondary"].on = settings["random_secondary"]
					m.t["random_pearlescent"] = m.add.t("Random Pearlescent", m.p["random_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"rainbow_pearlescent"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								vehicle.set_vehicle_custom_pearlescent_colour(veh, s.random(0, 0xffffff))
								s.wait(m.t["light_speed"].value_i)
							end
						end
						settings["random_pearlescent"] = f.on
						return u.stop(f)
						end)
						m.t["random_pearlescent"].on = settings["random_pearlescent"]
					m.t["random_neon"] = m.add.t("Random Neon Lights", m.p["random_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"rainbow_neon"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								local color = s.random(0, 0xffffff)
								vehicle.set_vehicle_neon_lights_color(veh, color)
								s.wait(m.t["light_speed"].value_i)
							end
						end
						settings["random_neon"] = f.on
						return u.stop(f)
						end)
						m.t["random_neon"].on = settings["random_neon"]
					m.t["random_smoke"] = m.add.t("Random Smoke", m.p["random_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"rainbow_smoke"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								local colorR = s.random(0, 255)
								local colorG = s.random(0, 255)
								local colorB = s.random(0, 255)
								vehicle.set_vehicle_tire_smoke_color(veh, colorR, colorG, colorB)
								s.wait(m.t["light_speed"].value_i)
							end
						end
						settings["random_smoke"] = f.on
						return u.stop(f)
						end)
						m.t["random_smoke"].on = settings["random_smoke"]
					m.t["random_xenon"] = m.add.t("Random Xenon", m.p["random_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"rainbow_xenon"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								vehicle.set_vehicle_headlight_color(veh, s.random(0, 12))
								s.wait(m.t["light_speed"].value_i)
							end
						end
						settings["random_xenon"] = f.on
						return u.stop(f)
						end)
						m.t["random_xenon"].on = settings["random_xenon"]
				m.p["rainbow_col"] = m.add.p("Rainbow Colors", m.p["vehicle_colors"]).id		
					m.t["rainbow_primary"] = m.add.t("Rainbow Primary", m.p["rainbow_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"random_primary"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								for i = 1, #neon_lights_rgb do
									vehicle.set_vehicle_custom_primary_colour(veh, u.rgbtohex({neon_lights_rgb[i][1], neon_lights_rgb[i][2], neon_lights_rgb[i][3]}))
									s.wait(m.t["light_speed"].value_i)
								end
							end
						end
						settings["rainbow_primary"] = f.on
						return u.stop(f)
						end)
						m.t["rainbow_primary"].on = settings["rainbow_primary"]
					m.t["rainbow_secondary"] = m.add.t("Rainbow Secondary", m.p["rainbow_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"random_secondary"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								for i = 1, #neon_lights_rgb do
									vehicle.set_vehicle_custom_secondary_colour(veh, u.rgbtohex({neon_lights_rgb[i][1], neon_lights_rgb[i][2], neon_lights_rgb[i][3]}))
									s.wait(m.t["light_speed"].value_i)
								end
							end
						end
						settings["rainbow_secondary"] = f.on
						return u.stop(f)
						end)
						m.t["rainbow_secondary"].on = settings["rainbow_secondary"]
					m.t["rainbow_pearlescent"] = m.add.t("Rainbow Pearlescent", m.p["rainbow_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"random_pearlescent"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								for i = 1, #neon_lights_rgb do
									vehicle.set_vehicle_custom_pearlescent_colour(veh, u.rgbtohex({neon_lights_rgb[i][1], neon_lights_rgb[i][2], neon_lights_rgb[i][3]}))
									s.wait(m.t["light_speed"].value_i)
								end
							end
						end
						settings["rainbow_pearlescent"] = f.on
						return u.stop(f)
						end)
						m.t["rainbow_pearlescent"].on = settings["rainbow_pearlescent"]
					m.t["rainbow_neon"] = m.add.t("Rainbow Neon Lights", m.p["rainbow_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"random_neon"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								for i = 1, #neon_lights_rgb do
									vehicle.set_vehicle_neon_lights_color(veh, u.rgbtohex({neon_lights_rgb[i][1], neon_lights_rgb[i][2], neon_lights_rgb[i][3]}))
									s.wait(m.t["light_speed"].value_i)
								end
							end
						end
						settings["rainbow_neon"] = f.on
						return u.stop(f)
						end)
						m.t["rainbow_neon"].on = settings["rainbow_neon"]
					m.t["rainbow_smoke"] = m.add.t("Rainbow Smoke", m.p["rainbow_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"random_smoke"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								for i = 1, #neon_lights_rgb do
									local c = neon_lights_rgb[i]
									vehicle.set_vehicle_tire_smoke_color(veh, c[1], c[2], c[3])
									s.wait(m.t["light_speed"].value_i)
								end
							end
						end
						settings["rainbow_smoke"] = f.on
						return u.stop(f)
						end)
						m.t["rainbow_smoke"].on = settings["rainbow_smoke"]
					m.t["rainbow_xenon"] = m.add.t("Rainbow Xenon", m.p["rainbow_col"], function (f)
						if f.on then
							toggle_off(synced_colors)
							toggle_off({"random_xenon"})
							local veh = s.vehicle(o.ped())
							if valid.vehicle(veh) then
								req.ctrl(veh)
								for i = 0, 12 do
									vehicle.set_vehicle_headlight_color(veh, i)
									s.wait(m.t["light_speed"].value_i)
								end
							end
						end
						settings["rainbow_xenon"] = f.on
						return u.stop(f)
						end)
						m.t["rainbow_xenon"].on = settings["rainbow_xenon"]
				m.t["synced_random"] = m.add.t("Synced Random Colors", m.p["vehicle_colors"], function (f)
					if f.on then
						toggle_off(rainbow_colors)
						toggle_off(random_colors)
						toggle_off({"synced_rainbow_smooth", "synced_rainbow"})
						local veh = s.vehicle(o.ped())
						if valid.vehicle(veh) then
							color_veh(veh, {s.random(0, 255), s.random(0, 255), s.random(0, 255)})
							s.wait(m.t["light_speed"].value_i)
						end
					end
					settings["synced_random"] = f.on
					return u.stop(f)
					end)
					m.t["synced_random"].on = settings["synced_random"]
				m.t["synced_rainbow"] = m.add.t("Synced Rainbow Colors", m.p["vehicle_colors"], function (f)
					if f.on then
						toggle_off(rainbow_colors)
						toggle_off(random_colors)
						toggle_off({"synced_random", "synced_rainbow_smooth"})
						local veh = s.vehicle(o.ped())
						if valid.vehicle(veh) then
							for i = 1, #neon_lights_rgb do
								local c = neon_lights_rgb[i]
								color_veh(veh, {c[1], c[2], c[3]}, i)
								s.wait(m.t["light_speed"].value_i)
							end
						end
					end
					settings["synced_rainbow"] = f.on
					return u.stop(f)
					end)
					m.t["synced_rainbow"].on = settings["synced_rainbow"]
				m.t["synced_rainbow_smooth"] = m.add.t("Synced Smooth Rainbow", m.p["vehicle_colors"], function (f)
					if f.on then
						toggle_off(rainbow_colors)
						toggle_off(random_colors)
						toggle_off({"synced_random", "synced_rainbow"})
						local veh = s.vehicle(o.ped())
						if valid.vehicle(veh) then
							local step
							step = math.floor((101 - (m.t["light_speed"].value_i / 25)) / 2)
							if step < 1 then
								step = 1
							end
							for i = 0, 255, step do
								color_veh(veh, {255, i, 0})
							end
							step = math.floor((101 - (m.t["light_speed"].value_i / 25)) / 2)
							if step < 1 then
								step = 1
							end
							for i = 255, 0, -step do
								color_veh(veh, {i, 255, 0})
							end
							step = math.floor((101 - (m.t["light_speed"].value_i / 25)) / 2)
							if step < 1 then
								step = 1
							end
							for i = 0, 255, step do
								color_veh(veh, {0, 255, i})
							end
							step = math.floor((101 - (m.t["light_speed"].value_i / 25)) / 2)
							if step < 1 then
								step = 1
							end
							for i = 255, 0, -step do
								color_veh(veh, {0, i, 255})
							end
							step = math.floor((101 - (m.t["light_speed"].value_i / 25)) / 2)
							if step < 1 then
								step = 1
							end
							for i = 0, 255,  step do
								color_veh(veh, {i, 0, 255})
							end
							step = math.floor((101 - (m.t["light_speed"].value_i / 25)) / 2)
							if step < 1 then
								step = 1
							end
							for i = 255, 0, -step do
								color_veh(veh, {255, 0, i})
							end				
						end
					end
					settings["synced_rainbow_smooth"] = f.on
					return u.stop(f)
					end)
					m.t["synced_rainbow_smooth"].on = settings["synced_rainbow_smooth"]
				m.add.a("100% Black", m.p["vehicle_colors"], function ()
					local veh = s.vehicle(o.ped())
					if valid.vehicle(veh) then
						color_veh(veh, {0, 0, 0}, 0)
					else
						n("Get in a valid Vehicle!", 173)
					end
					end)
				m.t["black_100"] = m.add.t("100% Black", m.p["vehicle_colors"], function (f)
					if f.on then
						toggle_off(rainbow_colors)
						toggle_off(random_colors)
						toggle_off(synced_colors)
						toggle_off({"fade_black_red"})
						local veh = s.vehicle(o.ped())
						if valid.vehicle(veh) then
							color_veh(veh, {0, 0, 0}, 0)
						end
					end
					settings["black_100"] = f.on
					return u.stop(f)
					end)
					m.t["black_100"].on = settings["black_100"]
				m.t["fade_black_red"] = m.add.t("Fade Black-Red", m.p["vehicle_colors"], function (f)
					if f.on then
						toggle_off(rainbow_colors)
						toggle_off(random_colors)
						toggle_off(synced_colors)
						toggle_off({"black_100"})
						local veh = s.vehicle(o.ped())
						if valid.vehicle(veh) then
							local step
							step = math.floor((101 - (m.t["light_speed"].value_i / 25)) / 2)
							if step < 1 then
								step = 1
							end
							for i = 0, 255, step do
								color_veh(veh, {i, 0, 0}, 0, 8)
							end
							step = math.floor((101 - (m.t["light_speed"].value_i / 25)) / 2)	
							if step < 1 then
								step = 1
							end
							for i = 255, 0, -step do
								color_veh(veh, {i, 0, 0}, 0, 8)
							end
						end
					end
					settings["fade_black_red"] = f.on
					return u.stop(f)
					end)
					m.t["fade_black_red"].on = settings["fade_black_red"]
			m.t["heli"] = m.add.u("Heli Blades Speed 0-100%", "value_i", m.p["vehicle"], function (f)
				settings["heli"] = f.on
				settings["heli_i"] = f.value_i
				local veh = s.vehicle(o.ped())
				if f.on then
					if valid.vehicle(veh) then
						req.ctrl(veh)
						local speed = f.value_i / 100
						vehicle.set_heli_blades_speed(veh, speed)
					end
				end
				return u.stop(f)
				end)
				m.t["heli"].max_i = 100
				m.t["heli"].min_i = 0
				m.t["heli"].mod_i = 5
				m.t["heli"].value_i = settings["heli_i"]
				m.t["heli"].on = settings["heli"]
			m.t["sel_boost_speed"] = m.add.u("Boost Vehicle", "value_i", m.p["vehicle"], function (f)
				settings["sel_boost_speed"] = f.on
				settings["sel_boost_speed_speed"] = f.value_i
				local veh = s.vehicle(o.ped())
				if f.on then
					if valid.vehicle(veh) then
						req.ctrl(veh)
						entity.set_entity_max_speed(veh, f.value_i)
						vehicle.set_vehicle_forward_speed(veh, f.value_i)
					end
				end
				if not f.on then
					entity.set_entity_max_speed(veh, 540)
				end
				return u.stop(f)
				end)
				m.t["sel_boost_speed"].max_i   = 50000
				m.t["sel_boost_speed"].min_i   = 0
				m.t["sel_boost_speed"].mod_i   = 50
				m.t["sel_boost_speed"].value_i = settings["sel_boost_speed_speed"]
				m.t["sel_boost_speed"].on = settings["sel_boost_speed"]
			m.t["speedometer"] = m.add.u("License Plate Speedometer", "value_i", m.p["vehicle"], function (f)
				settings["speedometer"] = f.on
				settings["speedometer_type"] = f.value_i
				spm_1 = f.value_i
				if f.on then
					local veh = s.vehicle(o.ped())
					if valid.vehicle(veh) then
						if spm_1 ~= spm_2 then
							n("Displaying Speed now with Unit:\n"..ext_data.speedometer_units[f.value_i][3], 96)
						end
						local sp = entity.get_entity_speed(veh) * ext_data.speedometer_units[f.value_i][2]
						if sp < 10 and sp > 0.01 then
							sp = string.format("%.2f", sp)
						elseif sp >= 10 and sp < 100 then
							sp = string.format("%.1f", sp)
						elseif sp < 0.01 and f.value_i == 7 then
							sp = string.format("%.5f", sp)
						else
							sp = math.floor(sp)
						end
						req.ctrl(veh)
						vehicle.set_vehicle_number_plate_text(veh, tostring(sp)..ext_data.speedometer_units[f.value_i][1])
					end
				end
				spm_2 = f.value_i
				return u.stop(f)
				end)
				m.t["speedometer"].max_i = #ext_data.speedometer_units
				m.t["speedometer"].min_i = 1
				m.t["speedometer"].value_i = settings["speedometer_type"]
				m.t["speedometer"].on = settings["speedometer"]
			m.t["veh_no_colision"] = m.add.t("No collision", m.p["vehicle"], function (f)
				if f.on then
					local veh = s.vehicle(o.ped())
					if valid.vehicle(veh) then
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
				settings["veh_no_colision"] = f.on
				return u.stop(f)
				end)
				m.t["veh_no_colision"].on = settings["veh_no_colision"]
			m.t["auto_repair"] = m.add.t("Auto Repair Vehicle", m.p["vehicle"], function (f)
				if f.on then
					local veh = s.vehicle(o.ped())
					if valid.vehicle(veh) then
						if vehicle.is_vehicle_damaged(veh) then
							req.ctrl(veh)
							vehicle.set_vehicle_fixed(veh)
							vehicle.set_vehicle_deformation_fixed(veh)
							vehicle.set_vehicle_engine_health(veh, 1000)
							vehicle.set_vehicle_can_be_visibly_damaged(veh, false)
						end						
					end
				end
				settings["auto_repair"] = f.on
				return u.stop(f)
				end)
				m.t["auto_repair"].on = settings["auto_repair"]
		m.t["drive_on_ocean"] = m.add.t("Drive / Walk on the Ocean", m.p["misc"], function (f)
			if f.on then
				local pos = o.coords()
				if gr_water == nil then
					req.model(1822550295)
					gr_water = spawn.object(1822550295, v3(pos.x, pos.y, -4))
					s.visible(gr_water, false)
				end
				water.set_waves_intensity(-100000000)
				pos.z = -4
				s_coords(gr_water, pos)
			end
			settings["drive_on_ocean"] = f.on
			if not f.on and gr_water then
				water.reset_waves_intensity()
				clear({gr_water})
				gr_water = nil
			end
			return u.stop(f)
			end)
			m.t["drive_on_ocean"].on = settings["drive_on_ocean"]
		m.t["drive_this_height"] = m.add.t("Drive / Walk this Height", m.p["misc"], function (f)
			if f.on then
				local pos, offset
				if ped.is_ped_in_any_vehicle(o.ped()) then
					local veh = s.vehicle(o.ped())
					pos = s.gcoords(veh)
					offset = 5.25
				else
					pos = o.coords()
					offset = 5.85
				end
				if gr_height == nil then
					req.model(1822550295)
					fixed_height = pos.z - offset
					gr_height = spawn.object(1822550295, v3(pos.x, pos.y, fixed_height))
					s.visible(gr_height, false)
				end
				water.set_waves_intensity(-100000000)
				pos.z = fixed_height
				s_coords(gr_height, pos)
			end
			settings["drive_this_height"] = f.on
			if not f.on and gr_height then
				water.reset_waves_intensity()
				clear({gr_height})
				gr_height = nil
				fixed_height = nil
			end
			return u.stop(f)
			end)
			m.t["drive_this_height"].on = settings["drive_this_height"]
		m.t["weird_ent"] = m.add.t("Weird Entity", m.p["misc"], function (f)
			local veh = s.vehicle(o.ped())
			local ent = o.ped()
			if f.on then
				if veh ~= 0 and balll == nil then
					local hash = entity.get_entity_model_hash(veh)
					balll = spawn.vehicle(hash, o.coords())
					ent = veh
				elseif balll == nil then
					balll = ped.clone_ped(o.ped())
				end
				s.visible(ent, false)
				entity.set_entity_collision(balll, false, false, false)
				entity.set_entity_rotation(balll, v3(s.random(-180, 180), s.random(-180, 180), s.random(-180, 180)))
				s_coords(balll, o.coords())
			end
			if not f.on then
				clear({balll})
				balll = nil
				s.visible(ent, true)
			end
			settings["weird_ent"] = f.on
			return u.stop(f)
			end)
			m.t["weird_ent"].on = settings["weird_ent"]
		m.t["real_time"] = m.add.t("Real Time (Clientside)", m.p["misc"], function (f)
			if f.on then
				local t = os.date("*t")
				time.set_clock_time(t.hour, t.min, t.sec)
				gameplay.clear_cloud_hat()
			end
			settings["real_time"] = f.on
			return u.stop(f)
			end)
			m.t["real_time"].on = settings["real_time"]
		m.t["clear_area"] = m.add.t("Gameplay Clear Area", m.p["misc"], function (f)
			if f.on then
				local pos = o.coords()
				gameplay.clear_area_of_cops(pos, 10000, true)
				gameplay.clear_area_of_peds(pos, 10000, true)
				gameplay.clear_area_of_vehicles(pos, 10000, false, false, false, false, false)
				gameplay.clear_area_of_objects(pos, 10000, 0)
				gameplay.clear_area_of_objects(pos, 10000, 1)
				gameplay.clear_area_of_objects(pos, 10000, 2)
				gameplay.clear_area_of_objects(pos, 10000, 6)
				gameplay.clear_area_of_objects(pos, 10000, 16)
				gameplay.clear_area_of_objects(pos, 10000, 17)
			end
			settings["clear_area"] = f.on
			return u.stop(f)
			end)
			m.t["clear_area"].on = settings["clear_area"]
		m.t["clear_area_2"] = m.add.t("Clear Area", m.p["misc"], function (f)
			if f.on then
				local remove = ped.get_all_peds()
				for i = 1, #remove do
					local X = remove[i]
					if not ped.is_ped_a_player(X) and f.on then
						req.ctrl(X, 250)
						entity.set_entity_velocity(X, v3())
						s_coords(X, v3(8000, 8000, -1000))
						entity.delete_entity(X)
					end
				end
				remove = object.get_all_objects()
				for i = 1, #remove do
					local X = remove[i]
					if f.on then
						req.ctrl(X, 250)
						entity.set_entity_velocity(X, v3())
						s_coords(X, v3(8000, 8000, -1000))
						entity.delete_entity(X)
						s.wait(0)
					end
				end
				remove = vehicle.get_all_vehicles()
				local dont = {}
				for y = 0, 31 do
					if g.scid(y) ~= -1 then
						local veh = s.vehicle(s.ped(y))
						if valid.vehicle(veh) then
							dont[#dont+1] = veh
						end
					end
				end
				for i = 1, #remove do
					local X = remove[i]
					if f.on then
						local delete = true
						for z = 1, #dont do
							if X == dont[z] then
								delete = false
							end
						end
						if delete then
							req.ctrl(X, 250)
							entity.set_entity_velocity(X, v3())
							s_coords(X, v3(8000, 8000, -1000))
							entity.delete_entity(X)
						end
					end
				end
			end
			settings["clear_area_2"] = f.on
			return u.stop(f)
			end)
			m.t["clear_area_2"].on = settings["clear_area_2"]
		m.t["auto_tp_wp"] = m.add.t("Auto Teleport to Waypoint", m.p["misc"], function (f)
			if f.on then
				local wp = ui.get_waypoint_coord()
				if wp.x ~= 16000 then
					local pos = o.coords()
					local v2pos = v2()
					v2pos.x = pos.x
					v2pos.y = pos.y
					if wp:magnitude(v2pos) > 35 then
						n("Detected Waypoint, teleporting...", 172)
						local m = o.ped()
						local v = s.vehicle(m)
						if v ~= 0 then m = v end
						local zheight = 850
						local success, gr = gameplay.get_ground_z(v3(wp.x, wp.y, zheight))
						while not success do
							zheight = zheight - 5
							success, gr = gameplay.get_ground_z(v3(wp.x, wp.y, zheight))
							if zheight < -200 then
								zheight = -200
								success = true
							end
						end
						tp(v3(wp.x, wp.y, gr))
					end
				end
			end
			settings["auto_tp_wp"] = f.on
			return u.stop(f)
			end)
			m.t["auto_tp_wp"].on = settings["auto_tp_wp"]
		m.t["ban_screen"] = m.add.t("You've Been Banned", m.p["misc"], function (f)
			if f.on then
				local pos = v2()
				local pos2 = v2()
				local pos3 = v2()
				pos.x = 0.5
				pos.y = 0.325
				pos2.x = 0.5
				pos2.y = 0.5
				pos3.x = 0.5
				pos3.y = 0.54
				ui.set_text_scale(3.0)
				ui.set_text_font(7)
				ui.set_text_centre(0)
				ui.set_text_color(255, 206, 67, 255)
				ui.set_text_outline(true)
				ui.draw_text("alert", pos)
				ui.set_text_scale(0.5)
				ui.set_text_centre(0)
				ui.set_text_color(255, 255, 255, 255)
				ui.draw_text("You have been banned from Grand Theft Auto Online permanently", pos2)
				ui.set_text_scale(0.5)
				ui.set_text_centre(0)
				ui.draw_text("Return to Grand Theft Auto V", pos3)
				ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
				ui.draw_rect(.5, .492, .52, .0019, 255, 255, 255, 255)
				ui.draw_rect(.5, .585, .52, .0019, 255, 255, 255, 255)
			end
			return u.stop(f)
			end)
		m.t["swap_seats"] = m.add.u("Swap Vehicle Seat", "autoaction_value_i", m.p["misc"], function ()
			local v = s.vehicle(o.ped())
			if v ~= 0 then
				ped.set_ped_into_vehicle(o.ped(), v, m.t["swap_seats"].value_i)
			end
			end)
			m.t["swap_seats"].min_i = -1
			m.t["swap_seats"].value_i = -1
			m.t["swap_seats"].max_i = 15
		m.p["stats"] = m.add.p("Stats", m.p["misc"]).id
			m.add.a("Reset Orbital-Cannon Cooldown", m.p["stats"], function()
				local hashes = stat.hashes["orbital_cannon_cd"]
				stat.set(hashes[1], true, hashes[2])
				end)
			m.t["remove_orb_cannon_cd"] = m.add.t("Remove Orbital-Cannon Cooldown", m.p["stats"], function(f)
				if f.on then
					local t = s.time() + 2000
					while t > s.time() do
						settings["remove_orb_cannon_cd"] = f.on
						s.wait(250)
					end
					local hashes = stat.hashes["orbital_cannon_cd"]
					stat.set(hashes[1], true, hashes[2])
				end
				settings["remove_orb_cannon_cd"] = f.on
				return u.stop(f)
				end)
				m.t["remove_orb_cannon_cd"].on = settings["remove_orb_cannon_cd"]
			m.add.a("Fill Snacks and Armor", m.p["stats"], function()
				local hashes = stat.hashes["snacks_and_armor"]
				for i = 1, #hashes do
					stat.set(hashes[i][1], true, hashes[i][2])
				end
				n("Filled Inventory with Snacks and Armor!", 39)
				l("Filled Inventory with Snacks and Armor!")
				end)
			m.add.a("Set KD (Kills / Death)", m.p["stats"], function()
				local kd = g.input("Enter KD (Kills / Death)", 10, 5)
				if not kd then
					return HANDLER_POP
				end
				kd = s.no(kd)
				local hashes = stat.hashes["kills_deaths"]
				local mult = s.random(1000, 2000)
				local kills = math.floor(kd * mult)
				local deaths = math.floor(kills / kd)
				l("Setting Stat " .. hashes[1] .. " to: " .. kills)
				l("Setting Stat " .. hashes[2] .. " to: " .. deaths)
				stat.set(hashes[1], false, kills)
				stat.set(hashes[2], false, deaths)
				n("New KD set, to update the KD, earn a legit kill or death!", 39)
				end)
			m.add.a("Unlock Fast-Run Ability", m.p["stats"], function()
				local hashes = stat.hashes["fast_run"]
				for i = 1, #hashes do
					stat.set(hashes[i], true, -1)
				end
				n("New Ability set, change lobby to show effect!", 39)
				end)
			m.p["chc"] = m.add.p("Casino Heist", m.p["stats"]).id
				m.add.a("Teleport to Boards", m.p["chc"], function()
					tp(v3(2712.885, -369.604, -54.781), 1, -173.626159)
					end)
				local board1 = stat.hashes["chc"]["board1"]
				local board2 = stat.hashes["chc"]["board2"]
				local misc = stat.hashes["chc"]["misc"]
				m.add.a("Reset Heist", m.p["chc"], function ()					
					local hashes = board2
					for i = 1, #hashes do
						stat.set(hashes[i][2], true, hashes[i][3])
					end
					hashes = board1
					for i = 1, #hashes do
						stat.set(hashes[i][2], true, hashes[i][3])
					end
					hashes = misc
					for i = 1, #hashes do
						stat.set(hashes[i][2], true, hashes[i][3])
					end
					n("Resettet Casino Heist!", 39)
					end)
				m.add.a("Quick start, random", m.p["chc"], function ()
					local hashes = misc
					stat.set(hashes[1][2], true, hashes[1][4])
					stat.set(hashes[2][2], true, hashes[2][4])
					hashes = board1
					for i = 1, #hashes do
						local value = hashes[i][4]
						if hashes[i][5] then
							value = s.random(hashes[i][4], hashes[i][5])
						end
						stat.set(hashes[i][2], true, value)
					end
					hashes = misc
					stat.set(hashes[3][2], true, hashes[3][4])
					hashes = board2
					for i = 1, #hashes do
						local value = hashes[i][4]
						if hashes[i][5] then
							value = s.random(hashes[i][4], hashes[i][5])
						end
						stat.set(hashes[i][2], true, value)
					end
					hashes = misc
					stat.set(hashes[4][2], true, hashes[4][4])
					n("Setted up Casino Heist with random execution. If you dont like it, Reset Heist and try again!", 39)
					end)
				m.add.a("Highest Payout (worst crew-members)", m.p["chc"], function ()
					local hashes = misc
					stat.set(hashes[1][2], true, hashes[1][4])
					stat.set(hashes[2][2], true, hashes[2][4])
					hashes = board1
					for i = 1, #hashes do
						local value = hashes[i][6] or hashes[i][4]
						stat.set(hashes[i][2], true, value)
					end
					hashes = misc
					stat.set(hashes[3][2], true, hashes[3][4])
					hashes = board2
					for i = 1, #hashes do
						local value = hashes[i][6] or hashes[i][4]
						if #hashes[i] == 5 then
							value = s.random(hashes[i][4], hashes[i][5])
						end
						stat.set(hashes[i][2], true, hashes[i][4])
					end
					hashes = misc
					stat.set(hashes[4][2], true, hashes[4][4])
					n("Setted up Casino Heist with highest Payout. If you dont like it, Reset Heist and try again!", 39)
					end)
				m.p["chc_manual"] = m.add.p("Manual Mode", m.p["chc"]).id
					m.add.a("Reset last Approach", m.p["chc_manual"], function ()
						local hashes = misc
						stat.set(hashes[1][2], true, hashes[1][4])
						stat.set(hashes[2][2], true, hashes[2][4])
						end)
					m.o["chc_approach"] = m.add.u(board1[1][1], "action_value_i", m.p["chc_manual"], function (f)
						local hashes = board1
						local value = f.value_i
						stat.set(hashes[1][2], true, value)
						end)
						m.o["chc_approach"].min_i = 1
						m.o["chc_approach"].max_i = 3
						m.o["chc_approach"].value_i = 1
					m.o["chc_hard"] = m.add.u(board1[2][1], "action_value_i", m.p["chc_manual"], function (f)
						local hashes = board1
						local value = f.value_i
						stat.set(hashes[2][2], true, value)
						end)
						m.o["chc_hard"].min_i = 1
						m.o["chc_hard"].max_i = 3
						m.o["chc_hard"].value_i = 1
					m.o["chc_content"] = m.add.u(board1[3][1], "action_value_i", m.p["chc_manual"], function (f)
						stat.set(board1[3][2], true, f.value_i)
						end)
						m.o["chc_content"].min_i = 0
						m.o["chc_content"].max_i = 3
					m.add.a(board1[4][1], m.p["chc_manual"], function ()
						local hashes = board1
						stat.set(hashes[4][2], true, hashes[4][4])
						end)
					m.add.a(board1[5][1], m.p["chc_manual"], function ()
						local hashes = board1
						stat.set(hashes[5][2], true, hashes[5][4])
						end)
					m.add.a(misc[3][1], m.p["chc_manual"], function ()
						local hashes = misc
						stat.set(hashes[3][2], true, hashes[3][4])
						end)
					m.add.a("Crew-Member-Weapon, Payout:", m.p["chc_manual"])
					m.o["chc_content_2"] = m.add.u(board2[1][1], "action_value_i", m.p["chc_manual"], function (f)
						local hashes = board2
						stat.set(hashes[1][2], true, f.value_i)
						end)
						m.o["chc_content_2"].min_i = 0
						m.o["chc_content_2"].max_i = 5
						m.o["chc_content_2"].value_i = 1
					m.add.a("Crew-Member-Driver, Payout:", m.p["chc_manual"])
					m.o["chc_content_3"] = m.add.u(board2[2][1], "action_value_i", m.p["chc_manual"], function (f)
						local hashes = board2
						stat.set(hashes[2][2], true, f.value_i)
						end)
						m.o["chc_content_3"].min_i = 0
						m.o["chc_content_3"].max_i = 5
						m.o["chc_content_3"].value_i = 1
					m.add.a("Crew-Member-Hacker, Payout:", m.p["chc_manual"])
					m.o["chc_content_4"] = m.add.u(board2[3][1], "action_value_i", m.p["chc_manual"], function (f)
						local hashes = board2
						stat.set(hashes[3][2], true, f.value_i)
						end)
						m.o["chc_content_4"].min_i = 0
						m.o["chc_content_4"].max_i = 5
						m.o["chc_content_4"].value_i = 1
					m.o["chc_content_5"] = m.add.u(board2[4][1], "action_value_i", m.p["chc_manual"], function (f)
						local hashes = board2
						stat.set(hashes[4][2], true, f.value_i)
						end)
						m.o["chc_content_5"].min_i = 0
						m.o["chc_content_5"].max_i = 1
					m.o["chc_content_6"] = m.add.u(board2[5][1], "action_value_i", m.p["chc_manual"], function (f)
						local hashes = board2
						stat.set(hashes[5][2], true, f.value_i)
						end)
						m.o["chc_content_6"].min_i = 0
						m.o["chc_content_6"].max_i = 3
					m.add.a(board2[6][1], m.p["chc_manual"], function ()
						local hashes = board2
						stat.set(hashes[6][2], true, hashes[6][4])
						end)
					m.add.a(board2[7][1], m.p["chc_manual"], function ()
						local hashes = board2
						stat.set(hashes[7][2], true, hashes[7][4])
						end)
					m.add.a(board2[8][1], m.p["chc_manual"], function ()
						local hashes = board2
						stat.set(hashes[8][2], true, hashes[8][4])
						end)
					m.o["chc_content_7"] = m.add.u(board2[9][1], "action_value_i", m.p["chc_manual"], function (f)
						local hashes = board2
						stat.set(hashes[9][2], true, f.value_i)
						end)
						m.o["chc_content_7"].min_i = 0
						m.o["chc_content_7"].max_i = 12
					m.add.a(misc[4][1], m.p["chc_manual"], function ()
						local hashes = misc
						stat.set(hashes[4][2], true, hashes[4][4])
						end)
			m.p["cph"] = m.add.p("Cayo Perico Heist", m.p["stats"]).id
				m.add.a("Teleport ontop of Submarine (WIP)", m.p["cph"], function()
					local all_vehicles = vehicle.get_all_vehicles()
					for i = 1, #all_vehicles do
						local veh = all_vehicles[i]
						local val = decorator.decor_get_int(veh, "Player_Submarine")
						if val ~= 0 then
							local pos = s.gcoords(veh)
							pos.z = 2
							local heading = entity.get_entity_heading(veh)
							tp(OffsetCoords(pos, heading, 40), 3, heading - 180)
						end
					end
				end)
				m.add.a("Teleport to Heist-Table", m.p["cph"], function()
					tp(v3(1561.042, 385.902, -49.685), 1, -178.7576)
					end)
				local bhash = stat.hashes["cph"]
				local main = bhash["main"]
				local loot = bhash["loot"]
				local scope = bhash["scope"]
				m.add.t("Remove Enemys", m.p["cph"], function(f)
					if f.on then
						local all_peds = ped.get_all_peds()
						for i = 1, #all_peds do
							s.wait(5)
							local ent = all_peds[i]
							local hash = entity.get_entity_model_hash(ent)
							if hash == 2127932792 or hash == 1821116645 or hash == 193469166 then
								req.ctrl(ent, 500)
								entity.set_entity_velocity(ent, v3())
								s.wait(5)
								ped.set_ped_health(ent, 0)
							end
							if entity.is_entity_dead(ent) then
								clear({ent})
							end
						end
						s.wait(500)
					end
					return u.stop(f)
					end)
				m.add.t("Kill Enemys", m.p["cph"], function(f)
					if f.on then
						local all_peds = ped.get_all_peds()
						for i = 1, #all_peds do
							s.wait(5)
							local ent = all_peds[i]
							local hash = entity.get_entity_model_hash(ent)
							if hash == 2127932792 or hash == 1821116645 or hash == 193469166 then
								local pos = s.gcoords(ent)
								s.bullet(pos + v3(0, 0, 2), pos, 1000, 0xA914799, o.ped(), false, true, 1000)
								s.wait(5)
							end
							if entity.is_entity_dead(ent) then
								clear({ent})
							end
						end
						s.wait(500)
					end
					return u.stop(f)
					end)
				m.add.a("Teleport all Pickup infront of me", m.p["cph"], function()
					local pickups = object.get_all_pickups()
						for i = 1, #pickups do
							local pick = pickups[i]
							req.ctrl(pick, 500)
							s_coords(pick, OffsetCoords(o.coords(), o.heading(), 4))
						end
					end)
				m.add.t("Remove Cams", m.p["cph"], function(f)
					if f.on then
						local all_cams = object.get_all_objects()
						for i = 1, #all_cams do
							s.wait(5)
							local ent = all_cams[i]
							local hash = entity.get_entity_model_hash(ent)
							if hash == 4121760380 or hash == 3061645218 or hash == 548760764 or hash == 2135655372 then
								clear({all_cams[i]})
							end
						end
						s.wait(500)
					end
					return u.stop(f)
					end)
				m.add.a("Quick start, best Payout", m.p["cph"], function()
					for i = 1, #loot do
						stat.set(loot[i][2], true, loot[i][3])
					end
					for i = 1, #scope do
						stat.set(scope[i][2], true, scope[i][3])
					end
					for i = 1, #main do
						stat.set(main[i][2], true, main[i][3])
					end
					end)
				m.add.a("TP to Entrance (Fingerprint)", m.p["cph"], function()
					tp(v3(5009.8017578125, -5750.55859375, 28.845287322998), 1, -38.5843)
					end)
		m.p["player_history"] = m.add.p("Player History", m.p["misc"]).id
			m.t["detect_lobby_change_for_history"] = m.add.t("Detect lobby change", m.p["player_history"], function(f)
				if f.on and not settings["disable_history"] then
					if history.lobby == nil and history.event == nil then
						history.parents[1] = m.add.p("Lobby 1 (1-50 Players)", m.p["player_history"], function()
							history.add_players()
							history.tags(history.parents[1])
							end)
						m.add.p("Lobby Information", history.parents[1].id).hidden = true
						history.lobby = history.parents[1]
						history.event = event.add_event_listener("player_join", function(e)
							if e.player == s.id() and not settings["disable_history"] then
								history.new_lobby(s.no(string.sub(history.lobby.name, 7, 8)) + 1 .. " (1-50 Players)")
								history.start_loop = #history.players - 1
							end
						end)
					end
					s.wait(100)
					local count = 0
					for i = 1, #history.parents do
						if s.no(string.sub(history.lobby.name, 7, 8)) == s.no(string.sub(history.parents[i].name, 7, 7)) then
							count = count + 1
						end
					end
					if #history.lobby.children >= 51 then
						local lobby_no = s.no(string.sub(history.lobby.name, 7, 8))
						lobby_no = lobby_no .. " (" .. count * 50 + 1 .. "-" .. count * 50 + 50 .. " Players)"
						history.new_lobby(lobby_no)
					end
				end
				s.wait(250)
				return u.stop(f)
			end)
			m.t["detect_lobby_change_for_history"].on = true
			m.t["detect_lobby_change_for_history"].hidden = true
			m.t["get_players_for_history"] = m.add.t("Get Players", m.p["player_history"], function(f)
				if f.on and not settings["disable_history"] then
					history.add_players()
					s.wait(2500)
					for i = 0, 31 do
						if s.valid(i) then
							local scid = g.scid(i)
							local name = g.name(i)
							local add = true
							local uuid = scid .. ":" .. name .. ":" .. i .. ":" .. string.sub(history.lobby.name, 7, 8)
							for y = history.start_loop, #history.players do
								if not history.players[y] then
									add = true
								elseif uuid == history.players[y]["uuid"] then
									add = false
								end
							end
							if add then
								local h_textures = {}
								local h_clothes = {}
								for z = 1, 11 do
									h_textures[z] = ped.get_ped_texture_variation(s.ped(i), z)
									h_clothes[z] = ped.get_ped_drawable_variation(s.ped(i), z)
								end
								local h_prop_ind = {}
								local h_prop_text = {}
								local loop = {0, 1, 2, 6, 7}
								for z = 1, #loop do
									h_prop_ind[z] = ped.get_ped_prop_index(s.ped(i), loop[z])
									h_prop_text[z] = ped.get_ped_prop_texture_index(s.ped(i), loop[z])
								end
								history.players[#history.players + 1] = {
									["scid"] = scid,
									["name"] = name,
									["ip"] = g.ip(i),
									["first_seen"] = u.time_prefix(),
									["is_female"] = player.is_player_female(i),
									["h_textures"] = h_textures,
									["h_clothes"] = h_clothes,
									["h_prop_ind"] = h_prop_ind,
									["h_prop_text"] = h_prop_text,
									["uuid"] = uuid,
									["player_id"] = i,
									["added"] = false
								}
							end
						end
					end
				end
				return u.stop(f)
			end)
			m.t["get_players_for_history"].on = true
			m.t["get_players_for_history"].hidden = true
		m.p["utils"] = m.add.p("Utils", m.p["misc"]).id
			m.p["outfits"] = m.add.p("Delete Custom Outfits", m.p["utils"], function ()
				n("Attention!\nDeleting cant be reverted!", 208)
				local outfits = utils.get_all_files_in_directory(paths["outfits"] .. "\\", "ini")
				local entries = m.p["outfits"].children
				for i = 1, #outfits do
					local add = true
					for y = 1, #entries do
						if entries[y].name == outfits[i] then
							add = false
						end
					end
					if add then
						m.add.a(outfits[i], m.p["outfits"].id, function(f)
							if s.f_exists(paths["outfits"] .. "\\" .. outfits[i]) then
								if io.remove(paths["outfits"] .. "\\" .. outfits[i]) == true then
									l("Deleted Outfit: " .. outfits[i])
									return HANDLER_CONTINUE
								end
								n("ERROR deleting the file, try again!")
								return HANDLER_POP
							end
							menu.delete_feature(f.id)
							end)
					end
				end
				end)
			m.p["vehicles"] = m.add.p("Delete Custom Vehicles", m.p["utils"], function ()
				n("Attention!\nDeleting cant be reverted!", 208)
				local vehicles = utils.get_all_files_in_directory(paths["vehicles"] .. "\\", "ini")
				local entries = m.p["vehicles"].children
				for i = 1, #vehicles do
					local add = true
					for y = 1, #entries do
						if entries[y].name == vehicles[i] then
							add = false
						end
					end
					if add then
						m.add.a(vehicles[i], m.p["vehicles"].id, function(f)
							if s.f_exists(paths["vehicles"] .. "\\" .. vehicles[i]) then
								if io.remove(paths["vehicles"] .. "\\" .. vehicles[i]) then
									l("Deleted Vehicle: " .. vehicles[i])
									return HANDLER_CONTINUE
								end
								n("ERROR deleting the file, try again!")
								return HANDLER_POP
							end
							menu.delete_feature(f.id)
							end)
					end
				end
				end)
			m.t["auto_load"] = m.add.t("autoexec Scripts from folder 'autoload'", m.p["utils"], function (f)
				settings["auto_load"] = f.on
				if f.on then
					if s.d_exists(paths["autoload"]) then
						local files = utils.get_all_files_in_directory(paths["autoload"], "lua")
						if files then
							l("Found Scripts for autoexecuting!")
							for i = 1, #files do
								l(files[i])
								local file_name = string.sub(files[i], 1, -5)
								local file_path = paths["autoload"] .. "\\" .. files[i]
								s.wait(5000)
								if s.f_exists(file_path) then
									local data, error = loadfile(file_path)
									if not error then
										data()
										n("Loaded Script "..files[i].." succesfully!", 166)
										l("Loaded Script "..files[i].." succesfully!")
									else
										n("ERROR Loading Script "..files[i].."!", 208)
										print(error)
										l(error)
									end
								end					
							end
						end
					else
						n("No folder 'autoload' found, create a folder and place any script inside!", 174)
					end
				end
				end)
				m.t["auto_load"].on = settings["auto_load"]
			m.t["leave_session"] = m.add.a("Leave-Session", m.p["utils"], function ()
				local time = s.time() + 8500
				while time > s.time() do end
				end)
			m.add.t("Auto-Hostkick-Yourself", m.p["utils"], function (f)
				if f.on then
					if network.network_is_host() then
						n("Hostkicking-Yourself!")
						l("Hostkicking-Yourself!")
						network.network_session_kick_player(s.id())
					end
				end
				return u.stop(f)
				end)
		m.p["debug"] = m.add.p("Dev Tools", m.p["misc"]).id
			m.add.a("Delete Entity from Aim", m.p["debug"], function () clear({player.get_entity_player_is_aiming_at(s.id())}) end)
			m.add.a("Get input Hash Key", m.p["debug"], function ()
				local _input = g.input("Enter Name(PED, OBJECT, etc)")
				if not _input then
					return HANDLER_POP
				end
				l("")
				l("******************************")
				l("String: ".._input)
				local hash = tostring(gameplay.get_hash_key(_input))
				l("Hash: "..hash)
				n(string.format("%s %s", _input, hash))
				end)
			m.add.a("Notify & Print String from file", m.p["debug"], function()
				local shash = "slod_small_quadped"
				local nhash = gameplay.get_hash_key(shash)
				l("")
				l("******************************")
				l("String: "..shash)
				l("Hash: "..nhash)
				n("String: "..shash)
				n("Hash: "..nhash)
				end)
			m.t["print_info_from_entity"] = m.add.a("Print Info from Entity @Aim to file", m.p["debug"], function ()
				local aimentity = player.get_entity_player_is_aiming_at(s.id())
				local getentity, pos, rot
				if aimentity ~= 0 then
					while aimentity ~= 0 do
						getentity = entity.get_entity_model_hash(aimentity)
						pos = entity.get_entity_coords(aimentity)
						rot = entity.get_entity_rotation(aimentity)
						l("")
						l("Printing infos about Entity:")
						l("******************************")
						if entity.is_entity_a_vehicle(aimentity) then
							l("Entity is a Vehicle.")
							l("Model: " .. mapper.veh.GetModelFromHash(getentity) or "NoModelDataFound")
							if streaming.is_model_a_bike(getentity) then
								l("Model is a Bike.")
							end
							if streaming.is_model_a_car(getentity) then
								l("Model is a Car.")
							end
							if streaming.is_model_a_bicycle(getentity) then
								l("Model is a Bicycle.")
							end
							if streaming.is_model_a_quad(getentity) then
								l("Model is a Quad.")
							end
							if streaming.is_model_a_boat(getentity) then
								l("Model is a Boat.")
							end
							if streaming.is_model_a_train(getentity) then
								l("Model is a Train.")
							end
							if streaming.is_model_a_heli(getentity) then
								l("Model is a Heli.")
							end
							if streaming.is_model_a_plane(getentity) then
								l("Model is a Plane.")
							end
							l("Name: " .. mapper.veh.GetNameFromHash(getentity) or "NoNameDataFound")
						end
						if entity.is_entity_a_ped(aimentity) then
							l("Entity is a Ped.")
							l("Model: " .. mapper.ped.GetModelFromHash(getentity) or "NoModelDataFound")
							l("Name: " .. mapper.ped.GetNameFromHash(getentity) or "NoNameDataFound")
						end
						if entity.is_entity_an_object(aimentity) then
							l("Entity is a Object.")
							l("Model: " .. mapper.obj.GetModelFromHash(getentity) or "NoModelDataFound")
							l("Category: " .. mapper.obj.GetCategoryFromHash(getentity) or "NoCategoryDataFound")
						end
						l("Hash: " .. getentity)
						l("Entity Type: "..entity.get_entity_type(aimentity))
						l("Entity: "..aimentity)
						l("Coords X: "..pos.x)
						l("Coords Y: "..pos.y)
						l("Coords Z: "..pos.z)
						l("Rot X: "..rot.x)
						l("Rot Y: "..rot.y)
						l("Rot Z: "..rot.z)
						l("Heading: ".. entity.get_entity_heading(aimentity))
						l("Entity population_type: "..entity.get_entity_population_type(aimentity))
						if entity.is_entity_static(aimentity) then
							l("Entity is static.")
						end
						if entity.does_entity_have_drawable(aimentity) then
							l("Entity has a drawable.")
						end
						if entity.is_entity_in_water(aimentity) then
							l("Entity is in water.")
						end
						if entity.is_entity_dead(aimentity) then
							l("Entity is dead.")
						end
						if entity.is_entity_on_fire(aimentity) then
							l("Entity is on fire.")
						end
						if entity.is_entity_visible(aimentity) then
							l("Entity is visible.")
						else
							l("Entity is in-visible.")
						end
						if entity.is_entity_attached(aimentity) then
							aimentity = entity.get_entity_attached_to(aimentity)
							l("")
							l("Attached Entity found. Continue printing infos of Entity.")
							l("Attached Entity Info:")
						else
							aimentity = 0
							l("")
							l("")
							l("")
						end
					end
					n("Printed Info about Entity to file.")
				else
					n("Nothing found for Info-Printing.")
				end
				end)
			m.add.a("Clear 2Take1Script.log", m.p["debug"], function ()
				u.write(s.o(files["Log_file"], "w"), "Cleared 2Take1Script.log")
				n("Cleared 2Take1Script.log", 204)
				end)
			m.add.a("Clear Menu Log-Files", m.p["debug"], function ()
				u.write(s.o(files["Auth"], "w"), "PopstarAuth.log cleared by 2Take1Script")
				n("Cleared PopstarAuth.log", 204)
				l("Cleared PopstarAuth.log")
				u.write(s.o(files["Menu_log"], "w"), "2Take1Menu.log cleared by 2Take1Script")
				n("Cleared 2Take1Menu.log", 204)
				l("Cleared 2Take1Menu.log")
				u.write(s.o(files["Prep"], "w"), "2Take1Prep.log cleared by 2Take1Script")
				n("Cleared 2Take1Prep.log", 204)
				l("Cleared 2Take1Prep.log")
				end)
			m.add.a("Clear crashdumps", m.p["debug"], function ()
				local dumps = utils.get_all_files_in_directory(paths["dumps"], "dump")
				if dumps[1] then
					n("Found dumps, deleting...", 204)
					for i = 1, #dumps do
						io.remove(paths["dumps"] .. "\\" .. dumps[i])
					end
					n("Cleared crashdumps.", 204)
					l("Cleared crashdumps.")
				else
					n("No dumps found.", 204)
				end
				end)
			m.t["log_modder_flags"] = m.add.t("Log Modder Flags", m.p["debug"], function(f)
				if f.on then
					local time = s.time() + 2500
					while time > s.time() do
						s.wait(250)
						settings["log_modder_flags"] = f.on
					end
					for i = 0, 31 do
						if s.valid(i) then
							for y = 1, #flags_int do
								if player.is_player_modder(i, flags_int[y]) then
									local int = flags_int[y]
									local text = player.get_modder_flag_text(int)
									if modder_player[g.scid(i)] then
										if not modder_player[g.scid(i)][int] then
											modder_player[g.scid(i)][int] = true
											l(g.scid(i) .. ":" .. g.name(i) .. " is a Modder with Tag: " .. text)
										end
									else
										modder_player[g.scid(i)] = {}
									end
								end
							end
						end
					end
				end
				settings["log_modder_flags"] = f.on
				return u.stop(f)
				end)
				m.t["log_modder_flags"].on = settings["log_modder_flags"]
			m.t["logger"] = m.add.t("Enable Log from this Lua-Script", m.p["debug"], function (f)
				settings["logger"] = f.on
				end)
				m.t["logger"].on = settings["logger"]
	m.p["self"] = m.add.p("Self", m.p["parent"])
		m.p["self"].hidden = settings["self_hidden"]
		m.p["self"] = m.p["self"].id
		m.t["random_clothes"] = m.add.u("Random Clothes", "value_i", m.p["self"], function(f)
			if f.on then
				s.wait(math.floor(1000 / f.value_i))
				ped.set_ped_random_component_variation(o.ped())		
			end
			settings["random_clothes"] = f.on
			return u.stop(f)
			end)
			m.t["random_clothes"].min_i = 1
			m.t["random_clothes"].max_i = 25
			m.t["random_clothes"].value_i = settings["random_clothes_value"]
			m.t["random_clothes"].on = settings["random_clothes"]
		m.t["police_outfit"] = m.add.t("Force Police Outfit", m.p["self"], function (f)
			if f.on then
				local g = "male"
				if player.is_player_female(s.id()) then
					g = "female"
				end
				local outfit = outfits["police_outfit"][g]
				for i = 1, #outfit["clothes"] do
					ped.set_ped_component_variation(o.ped(), i, outfit["clothes"][i][2], outfit["clothes"][i][1], 2)
				end
				for i = 1, #outfit["props"] do
					ped.set_ped_prop_index(o.ped(), outfit["props"][i][1], outfit["props"][i][2], outfit["props"][i][3], 0)
				end
				s.wait(250)
			end
			settings["police_outfit"] = f.on
			return u.stop(f)
			end)
			m.t["police_outfit"].on = settings["police_outfit"]
		m.p["health"] = m.add.p("Health", m.p["self"]).id
			m.add.a("Fill Health", m.p["health"], function ()
				local max = player.get_player_max_health(s.id())
				local current = player.get_player_health(s.id())
				if max ~= current then
					ped.set_ped_health(o.ped(), max)
					n("Filled health!")
				end
				end)
			m.t["undead_otr"] = m.add.t("Undead OTR", m.p["health"], function(f)
				if f.on then
					local max = player.get_player_max_health(s.id())
					if max ~= 0 then
						ped.set_ped_max_health(o.ped(), 0)
					end
				end
				if not f.on then
					ped.set_ped_max_health(o.ped(), 328)
				end
				settings["undead_otr"] = f.on
				return u.stop(f)
				end)
				m.t["undead_otr"].on = settings["undead_otr"]
			m.t["quick_regen"] = m.add.t("Quick regen", m.p["health"], function(f)
				if f.on then
					local max = player.get_player_max_health(s.id())
					local current = player.get_player_health(s.id())
					if max > current then
						ped.set_ped_health(o.ped(), current + 1)
					end
				end
				settings["quick_regen"] = f.on
				return u.stop(f)
				end)
				m.t["quick_regen"].on = settings["quick_regen"]
			m.t["unlimited_regen"] = m.add.t("Unlimited health-regen!", m.p["health"], function(f)
				if f.on then
					local current = player.get_player_health(s.id())
					local new_health = current + current * 0.005
					if new_health < 500000000 then
						ped.set_ped_health(o.ped(), new_health)
						ped.set_ped_max_health(o.ped(), new_health)
					end
				end
				if not f.on and settings["revert_health"] then
					ped.set_ped_max_health(o.ped(), 328)
					ped.set_ped_health(o.ped(), 328)
				end
				settings["unlimited_regen"] = f.on
				return u.stop(f)
				end)
				m.t["unlimited_regen"].on = settings["unlimited_regen"]
			m.t["revert_health"] = m.add.t("Revert health after disabling Unlimited-regen", m.p["health"], function (f)
				settings["revert_health"] = f.on
				end)
				m.t["revert_health"].on = settings["revert_health"]
			m.p["more_health"] = m.add.p("Health Boosts", m.p["health"]).id
				for i = 1, #health_boosts do
					m.add.a(health_boosts[i][1], m.p["more_health"], function()
						ped.set_ped_health(o.ped(), health_boosts[i][2])
						ped.set_ped_max_health(o.ped(), health_boosts[i][2])
						n("Health set to:\n" .. health_boosts[i][2])
						end)
				end
		m.t["do_ragdoll"] = m.add.a("Ragdoll", m.p["self"], function()
			ped.set_ped_to_ragdoll(o.ped(), 2500, 0, 0)
			end)
		m.t["ragdoll"] = m.add.t("Ragdoll", m.p["self"], function(f)
			if f.on then
				ped.set_ped_to_ragdoll(o.ped(), 2500, 0, 0)
			end
			settings["ragdoll"] = f.on
			return u.stop(f)
			end)
			m.t["ragdoll"].on = settings["ragdoll"]
		m.p["aim_protection"] = m.add.p("Aim Protection", m.p["self"]).id
			m.t["enable_aim_prot"] = m.add.t("Enable Aim Protection", m.p["aim_protection"], function (f)
				if f.on then
					for i = 0, 31 do
						if valid.i(i) then
							local target = player.get_entity_player_is_aiming_at(i)
							if target ~= 0 then
								if target == o.ped() then
									n(g.name(i).." is aiming at you!", 173)
									local owner = o.ped()
									if settings["anonymous_punishment"] then
										owner = s.ped(i)
									end
									if settings["aim_prot_ragdoll"] then
										n("Ragdolling "..g.name(i).."!", 173)
										l("Ragdolling "..g.name(i).."!")
										s.explode(s.gcoords(s.ped(i)), 70, true, false, 1, owner)
										s.wait(75)
									end
									if settings["aim_prot_fire"] then
										n("Setting "..g.name(i).." on fire!", 173)
										l("Setting "..g.name(i).." on fire!")
										s.explode(s.gcoords(s.ped(i)), 3, true, false, 0, owner)
										s.wait(75)
									end
									if settings["aim_prot_kill"] then
										n("Killing "..g.name(i).."!", 173)
										l("Killing "..g.name(i).."!")
										s.explode(s.gcoords(s.ped(i)), 8, false, true, 0, owner)
										s.wait(75)
									end
									if settings["aim_prot_remove_weapon"] then
										n("Removing Weapon from "..g.name(i).."!", 173)
										l("Removing Weapon from "..g.name(i).."!")
										ped.set_ped_can_switch_weapons(s.ped(i), false)
										weapon.remove_weapon_from_ped(s.ped(i), ped.get_current_ped_weapon(s.ped(i)))
										ped.set_ped_can_switch_weapons(s.ped(i), false)
										s.wait(75)
									end
									if settings["aim_prot_kick"] then
										kick_pl(false, i)
									end
									if settings["electrocute_player"] then
										n("Electrocuting Player " .. g.name(i) .. "!", 173)
										l("Electrocuting Player " .. g.name(i) .. "!")
										local pos = s.gcoords(s.ped(i))
										s.bullet(pos + v3(0, 0, 2), pos, 0, 0x3656C8C1, o.ped(), true, false, 10000)
										s.wait(75)
									end
								end
							end
						end
					end
				end
				settings["enable_aim_prot"] = f.on
				return u.stop(f)
				end)
				m.t["enable_aim_prot"].on = settings["enable_aim_prot"]
			m.t["anonymous_punishment"] = m.add.t("Anonymous Punishment", m.p["aim_protection"], function (f)
				settings["anonymous_punishment"] = f.on
				end)
				m.t["anonymous_punishment"].on = settings["anonymous_punishment"]
			m.t["aim_prot_ragdoll"] = m.add.t("Ragdoll Player", m.p["aim_protection"], function (f)
				settings["aim_prot_ragdoll"] = f.on
				end)
				m.t["aim_prot_ragdoll"].on = settings["aim_prot_ragdoll"]
			m.t["aim_prot_fire"] = m.add.t("Set on Fire", m.p["aim_protection"], function (f)
				settings["aim_prot_fire"] = f.on
				end)
				m.t["aim_prot_fire"].on = settings["aim_prot_fire"]
			m.t["aim_prot_kill"] = m.add.t("Kill Player", m.p["aim_protection"], function (f)
				settings["aim_prot_kill"] = f.on
				end)
				m.t["aim_prot_kill"].on = settings["aim_prot_kill"]
			m.t["aim_prot_remove_weapon"] = m.add.t("Remove Current Weapon", m.p["aim_protection"], function (f)
				settings["aim_prot_remove_weapon"] = f.on
				end)
				m.t["aim_prot_remove_weapon"].on = settings["aim_prot_remove_weapon"]	
			m.t["aim_prot_kick"] = m.add.t("Kick Player", m.p["aim_protection"], function (f)
				settings["aim_prot_kick"] = f.on
				end)
				m.t["aim_prot_kick"].on = settings["aim_prot_kick"]
			m.t["electrocute_player"] = m.add.t("Electrocute Player", m.p["aim_protection"], function(f)
				settings["electrocute_player"] = f.on
				end)
				m.t["electrocute_player"].on = settings["electrocute_player"]
		m.p["bodyguards"] = m.add.p("Bodyguards", m.p["self"])
			m.p["bodyguards"].hidden = settings["bodyguards_hidden"]
			m.p["bodyguards"] = m.p["bodyguards"].id
			m.t["bodyguards_god"] = m.add.t("Godmode for Bodyguards", m.p["bodyguards"], function (f)
				settings["bodyguards_god"] = f.on
				end)
				m.t["bodyguards_god"].on = settings["bodyguards_god"]
			m.t["bodyguards_health"] = m.add.u("Set Health of Bodyguards", "autoaction_value_i", m.p["bodyguards"], function (f)
				n("Bodyguards Health set to: "..f.value_i)
				settings["bodyguards_health"] = f.value_i
				end)
				m.t["bodyguards_health"].min_i = 5000
				m.t["bodyguards_health"].max_i = 50000
				m.t["bodyguards_health"].mod_i = 5000
				m.t["bodyguards_health"].value_i = settings["bodyguards_health"]
			m.t["bodyguards_equip_weapon"] = m.add.t("Equip Bodyguards with MG", m.p["bodyguards"], function (f)
				settings["bodyguards_equip_weapon"] = f.on
				end)
				m.t["bodyguards_equip_weapon"].on = settings["bodyguards_equip_weapon"]
			m.t["bodyguards_formation"] = m.add.u("Set Formation", "autoaction_value_i", m.p["bodyguards"], function (f)
				settings["bodyguards_formation_type"] = f.value_i
				end)
				m.t["bodyguards_formation"].min_i = 0
				m.t["bodyguards_formation"].max_i = 3
				m.t["bodyguards_formation"].value_i = settings["bodyguards_formation_type"]
			m.t["bodyguards"] = m.add.t("Enable Bodyguards", m.p["bodyguards"], function (f)
				if f.on then
					local ped_group = player.get_player_group(s.id())
					local hash = 0x613E626C
					for i = 1, 7 do
						if not entitys["bodyguards"][i] or entity.is_entity_dead(entitys["bodyguards"][i]) then
							if entitys["bodyguards"][i] and entity.is_entity_dead(entitys["bodyguards"][i]) then
								clear({entitys["bodyguards"][i]})
							end
							req.model(hash)
							entitys["bodyguards"][i] = spawn.ped(hash, OffsetCoords(o.coords(), o.heading(), 4), 29)
							s.unload(hash)
							if m.t["bodyguards_god"].on then
								s.god(entitys["bodyguards"][i], true)
							else
								ped.set_ped_max_health(entitys["bodyguards"][i], m.t["bodyguards_health"].value_i)
								ped.set_ped_health(entitys["bodyguards"][i], m.t["bodyguards_health"].value_i)
							end
							local blip = ui.add_blip_for_entity(entitys["bodyguards"][i])
							ui.set_blip_sprite(blip, 310)
							ui.set_blip_colour(blip, 80)
							if m.t["bodyguards_equip_weapon"].on then
								weapon.give_delayed_weapon_to_ped(entitys["bodyguards"][i], 0x22D8FE39, 0, 1)
								weapon.give_delayed_weapon_to_ped(entitys["bodyguards"][i], 0xDBBD7280, 0, 1)
							end
							ped.set_ped_combat_ability(entitys["bodyguards"][i], 100)
							ped.set_ped_as_group_member(entitys["bodyguards"][i], ped_group)
							entity.set_entity_as_mission_entity(entitys["bodyguards"][i], 1, 1)
						end
						-- AI
						if not entity.is_entity_dead(entitys["bodyguards"][i]) then
							req.ctrl(entitys["bodyguards"][i])
							ped.set_group_formation(ped_group, m.t["bodyguards_formation"].value_i)
							-- Shoot at Coord / Entity from Player Aim
							if player.is_player_free_aiming(s.id()) then
								local target = player.get_entity_player_is_aiming_at(s.id())
								if target ~= 0 then
									ai.task_shoot_at_entity(entitys["bodyguards"][i], target, 100, 0xC6EE6B4C)
								else
									local pos = o.coords()
									local dir = cam.get_gameplay_cam_rot()
									dir:transformRotToDir()
									dir = dir * s.random(1, 50)
									pos = pos + dir
									ai.task_shoot_gun_at_coord(entitys["bodyguards"][i], pos, 100, 0xC6EE6B4C)
								end
							end
							-- TP Bodyguards back to Player
							if o.coords():magnitude(s.gcoords(entitys["bodyguards"][i])) > 50 then
								s_coords(entitys["bodyguards"][i], OffsetCoords(o.coords(), o.heading(), -5))
							end
						end
					end
				end
				if not f.on then
					clear(entitys["bodyguards"])
					entitys["bodyguards"] = {}
				end
				return u.stop(f)
				end)	
	m.p["opt"] = m.add.p("Options", m.p["parent"])
		m.p["opt"].hidden = settings["options_hidden"]
		m.p["opt"] = m.p["opt"].id
		m.p["hotkeys"] = m.add.p("Hotkey Settings", m.p["opt"]).id
			m.t["enable_hotkeys"] = m.add.t("Enable Hotkeys", m.p["hotkeys"], function (f)
				settings["enable_hotkeys"] = f.on
				if f.on then
					s.wait(50)
					if not s.f_exists(files["Hotkeys"]) then
						setup.overwrite_hotkeys()
					end
					for i = 1, #hotkeys[0] do
						local i_name = hotkeys[0][i]
						local hk_key = hotkeys[i_name]
						if hk_key ~= "none" then
							local key = MenuKey()
							key:push_str(hk_key)
							if key:is_down() then
								local feature = m.t[i_name]
								local feat_name = feature.name
								l(hk_key..":'"..feat_name.."' got pressed.")
								if settings["hotkey_notification"] then
									n(hk_key..":'"..feat_name.."' got pressed.", 86)
								end
								if feature.type == 512 then
									feature.on = true
									s.wait(100)
									feature.on = false
								else
									if feature.on then
										feature.on = false
									else
										feature.on = true
									end
								end
								s.wait(250)
							end
						end
					end
				end
				return u.stop(f)
				end)
				m.t["enable_hotkeys"].on = settings["enable_hotkeys"]
			m.add.a("Reload 2Take1Hotkeys.ini", m.p["hotkeys"], function() setup.hotkeys() n("Reloaded Hotkeys.ini", 86) end)
			m.t["hotkey_notification"] = m.add.t("Hotkey Notifications", m.p["hotkeys"], function (f) settings["hotkey_notification"] = f.on end)
				m.t["hotkey_notification"].on = settings["hotkey_notification"]
			m.add.a("Print active Hotkeys", m.p["hotkeys"], function ()
				for i = 1, #hotkeys[0] do
					local key = hotkeys[0][i]
					if hotkeys[key] ~= "none" then
						n(hotkeys[key]..": \""..m.t[key].name.."\"", 86)
					end
				end
				end)
			m.add.a("Overwrite / Update File - Hotkeys.ini", m.p["hotkeys"], setup.overwrite_hotkeys)
		m.p["mwh"] = m.add.p("Menu-Wide-Hotkeys", m.p["opt"]).id
			local mwh_key = {}
			local mwh_name = {}
			local mwh_exclude = {}
			local __file = s.o(files["Exclude"], "r")
			if __file then
				for li in io.lines(files["Exclude"]) do
					if not string.find(li, ";", 1) then
						mwh_exclude[#mwh_exclude+1] = li
					end
				end
				io.close(__file)
			end
			m.t["mwh_notify"] = m.add.t("Menu-Wide Hotkey Notifications", m.p["mwh"], function (f)
				if f.on then
					s.wait(50)
					if #mwh_key == 0 then
						local sf = s.o(paths["Menu"] .. "\\2Take1Menu.ini", "r")
						if sf then
							local i = 1
							for li in io.lines(paths["Menu"] .. "\\2Take1Menu.ini") do
								if i > 1 and i < 50 then
									local index = ""
									while string.find(li, "=", 1) do
										index = index .. string.sub(li, 1, 1)
										li = string.sub(li, 2)
									end
									index = string.sub(index, 1, #index - 1)
									if string.find(li, "NOMOD+", 1) then
										li = string.gsub(li, "NOMOD*+", "")
									end
									mwh_key[i-1] = li
									mwh_name[i-1] = index
								end
								i = i + 1
							end
							io.close(sf)
						end
					end
					for i = 1, #mwh_key do
						local hk_key = mwh_key[i]
						local hk_name = mwh_name[i]
						local bool1 = hk_key ~= "none"
						local bool2 = true
						if settings["mwh_exclude_navigation"] then
							if string.find(hk_name, "Menu", 1) then
								bool2 = false
							end
						end
						if settings["mwh_exclude_noclip"] then
							if string.find(hk_name, "NoClip", 1) then
								bool2 = false
							end
						end
						if settings["mwh_exclude_editorrot"] then
							if string.find(hk_name, "EditorRot", 1) then
								bool2 = false
							end
						end
						if settings["mwh_exclude_file"] then
							for y = 1, #mwh_exclude do
								if string.find(hk_name, mwh_exclude[y], 1) then
									bool2 = false
								end
							end
						end
						if bool1 and bool2 then
							local key = MenuKey()
							key:push_str(hk_key)
							if key:is_down() then
								n(hk_key..":'"..hk_name.."' got pressed.", 86)		
								s.wait(250)
							end
						end
					end
				end
				settings["mwh_notify"] = f.on
				return u.stop(f)
				end)
				m.t["mwh_notify"].on = settings["mwh_notify"]
			m.t["mwh_exclude_navigation"] = m.add.t("Exclude Navigation Keys", m.p["mwh"], function (f)
				settings["mwh_exclude_navigation"] = f.on
				end)
				m.t["mwh_exclude_navigation"].on = settings["mwh_exclude_navigation"]
			m.t["mwh_exclude_noclip"] = m.add.t("Exclude NoClip Keys", m.p["mwh"], function (f)
				settings["mwh_exclude_noclip"] = f.on
				end)
				m.t["mwh_exclude_noclip"].on = settings["mwh_exclude_noclip"]
			m.t["mwh_exclude_editorrot"] = m.add.t("Exclude EditorRotation Keys", m.p["mwh"], function (f)
				settings["mwh_exclude_editorrot"] = f.on
				end)
				m.t["mwh_exclude_editorrot"].on = settings["mwh_exclude_editorrot"]
			m.t["mwh_exclude_file"] = m.add.t("Exclude Keys from File", m.p["mwh"], function (f)
				if not s.f_exists(files["Exclude"]) then
					local lf = s.o(files["Exclude"], "a")
					io.output(lf)
					io.write(";Write down each Hotkey from 2Take1Menu.ini file which should not get a notify.\n")
					io.write(";Example, the \"Exit\" Hotkey should not get a notify, then just add it here.\n")
					io.write(";Each excluded hotkey gets a single line:\n")
					io.write("Exit")
					io.close(lf)
					n("Edit '2Take1Exclude.ini' to exclude specific hotkeys. The file is found in '2Take1Script/Config'", 86)
				end
				settings["mwh_exclude_file"] = f.on
				end)
				m.t["mwh_exclude_file"].on = settings["mwh_exclude_file"]
			m.add.a("Reload 2Take1Exclude.ini", m.p["mwh"], function()
				local __file = s.o(files["Exclude"], "r")
				if __file then
					mwh_exclude = {}
					for li in io.lines(files["Exclude"]) do
						if not string.find(li, ";", 1) then
							mwh_exclude[#mwh_exclude+1] = li
						end
					end
					io.close(__file)
					n("Reloaded Exclude Hotkeys.", 86)
				end
				end)
		m.t["exclude_friends"] = m.add.t("Exclude Friends from Harmful Lobby Events", m.p["opt"], function (f)
			settings["exclude_friends"] = f.on
			end)
			m.t["exclude_friends"].on = settings["exclude_friends"]
		m.t["attach_no_colision"] = m.add.t("Attached Entitys No Collision", m.p["opt"], function (f) settings["attach_no_colision"] = f.on end)
			m.t["attach_no_colision"].on = settings["attach_no_colision"]
		m.t["continuously_assassins"] = m.add.t("Continuously Assassin Peds", m.p["opt"], function (f)
			settings["continuously_assassins"] = f.on
			if f.on and #entitys["peds"] > 0 then
				if g.scid(assassins_target) ~= -1 then
					local target = s.ped(assassins_target)
					for i = 1, #entitys["peds"] do
						ai.task_goto_entity(entitys["peds"][i], target, 10, 500, 500)
						ai.task_combat_ped(entitys["peds"][i], target, 0, 16)
					end
				end
			else
				s.wait(500)
			end
			return u.stop(f)
			end)
			m.t["continuously_assassins"].on = settings["continuously_assassins"]
		m.t["disable_history"] = m.add.t("Disable Player-History", m.p["opt"], function (f)
			settings["disable_history"] = f.on
			end)
		m.t["override_notify_color"] = m.add.u("Force Notification Color", "value_i", m.p["opt"], function (f)
			settings["override_notify_color"] = f.on
			settings["notify_color"] = f.value_i
			end)
			m.t["override_notify_color"].max_i = 223
			m.t["override_notify_color"].on = settings["override_notify_color"]
			m.t["override_notify_color"].value_i = settings["notify_color"]
		m.add.a("Show Notification Color", m.p["opt"], function ()
			n("Example Text\nNotification color: "..settings["notify_color"])
			end)
		m.t["2t1s_parent"] = m.add.t("2Take1Script Parent", m.p["opt"], function (f)
			settings["2t1s_parent"] = f.on
			end)
			m.t["2t1s_parent"].on = settings["2t1s_parent"]
		m.t["save_config"] = m.add.a("Save Configuration", m.p["opt"], function ()
			local sf = s.o(files["Config"], "w+")
			io.output(sf)
			for i = 1, #settings[0] do
				local index = settings[0][i]
				if not string.find(index, "section", 1) then
					io.write(index .. "=" .. tostring(settings[index]) .. "\n")
				else
					io.write(tostring(settings[index]) .. "\n")
				end
			end
			io.close(sf)
			l("Saved Configuration to file.")
			n("Saved Configuration to file.", 25)
			end)
	--[[m.p["testing_area"] = m.add.p("Testing Area", 0)
		m.p["testing_area"].hidden = false
		m.p["testing_area"] = m.p["testing_area"].id

		local uwu = m.p["testing_area"]
		m.add.a("Print Valids", uwu, function()
			print("\n\n\n")
			for i = 0, 31 do
				local aA = tostring(s.valid(i))
				local aB = g.scid(i)
				local aC = g.name(i)
				if aA == "true" and aB ~= -1 and aC ~= "Invalid Player" then
					print("id: " .. i)
					print("Valid: " .. aA)
					print("scid: " .. aB)
					print("name: " .. aC .. "\n")
				end
			end
		end)

		m.p["entity_pools_mgr"] = m.add.p("Entity Pools Mgr", m.p["testing_area"]).id
			m.p["all_vehicles"] = m.add.p("All Vehicles", m.p["entity_pools_mgr"], function(f)
				
				end).id
				m.add.a("Explode all Vehicles", m.p["all_vehicles"], function() explode_all(vehicle.get_all_vehicles(), s.vehicle(o.ped())) end)
				m.add.a("Delete all Vehicles", m.p["all_vehicles"], function() clear(vehicle.get_all_vehicles()) end)
				m.add.a("Teleport all Vehicles to me", m.p["all_vehicles"], function()
					local vehicles = vehicle.get_all_vehicles()
					for i = 1, #vehicles  do
						if vehicles[i] ~= s.vehicle(o.ped()) then
							s_coords(vehicles[i], OffsetCoords(o.coords(), o.heading(), 25))
						end
					end
					end)
				m.p["all_vehicles_single"] = m.add.p("Vehicles", m.p["all_vehicles"], function(f)
					while #f.children ~= 0 do
						s.navigate(false)
						while #f.children[1].children ~= 0 do
							menu.delete_feature(f.children[1].children[1].id)
						end
						menu.delete_feature(f.children[1].id)
						s.wait(0)
					end
					local vehicles = vehicle.get_all_vehicles()
					for i = 1, #vehicles do
						local veh = vehicles[i]
						if entity.is_an_entity(veh) then
							local veh_hash = entity.get_entity_model_hash(veh)
							local name = mapper.veh.GetNameFromHash(veh_hash) or "NoVehicleDataFound"
							if veh == s.vehicle(o.ped()) then
								name = name .. " [SELF]"
							end
							local driver = vehicle.get_ped_in_vehicle_seat(veh, -1)
							if driver and ped.is_ped_a_player(driver) then
								local id = player.get_player_from_ped(driver)
								if id ~= s.id() then
									name = name .. " [" .. g.name(id) .. "]"
								end
							end
							local sub_parent = m.add.p(name, m.p["all_vehicles_single"]).id
							m.add.a("Teleport into Vehicle", sub_parent, function()
								if entity.is_an_entity(veh) then
									local seat = vehicle.get_free_seat(veh)
									ped.set_ped_into_vehicle(o.ped(), veh, seat)
								end
								end)
							m.add.a("Teleport Vehicle to me", sub_parent, function()
								if entity.is_an_entity(veh) then
									if s.vehicle(o.ped()) ~= veh then
										s_coords(veh, OffsetCoords(o.coords(), o.heading(), 5))
									end
								end
								end)
							local notified
							m.add.t("Line ESP", sub_parent, function(f)
								if not notified then
									notified = true
									n("Leaving this Feature will disable the ESP")
								end
								if f.on and entity.is_an_entity(veh) then
									ui.draw_line(o.coords(), s.gcoords(veh), 255, 0, 0, 255)
								end
								return u.stop(f)
								end)
						end
						s.wait(0)
					end
					s.navigate(true)
					end).id
			m.p["all_peds"] = m.add.p("All Peds", m.p["entity_pools_mgr"]).id
				m.add.a("Explode all Peds", m.p["all_peds"], function() explode_all(ped.get_all_peds(), o.ped()) end)
				m.add.a("Delete all Peds", m.p["all_peds"], function() clear(ped.get_all_peds()) end)
			m.p["all_objects"] = m.add.p("All Objects", m.p["entity_pools_mgr"]).id
				m.add.a("Explode all Objects", m.p["all_objects"], function() explode_all(object.get_all_objects()) end)
				m.add.a("Delete all Objects", m.p["all_objects"], function() clear(object.get_all_objects()) end)
			m.add.a("Explode ALL",  m.p["entity_pools_mgr"], function()
				explode_all(vehicle.get_all_vehicles(), s.vehicle(o.ped()))
				explode_all(ped.get_all_peds(), o.ped())
				explode_all(object.get_all_objects())
				end)
			m.add.a("Delete ALL", m.p["entity_pools_mgr"], function()
				clear(vehicle.get_all_vehicles())
				clear(ped.get_all_peds())
				clear(object.get_all_objects())
				end)]]
	l("")
	l("")
	l("Loaded 2Take1Script successfully. :)")
	l("")
	n("2Take1Script successfully loaded. :)", 210)
	_2t1s = true
end

_2t1sf()

--[[
-## Changelog

- Custom Vehicle, Engine will start on spawn
- Removed everything crash related
- Moved "Host Kick" into normal kick, when you are host, it will auto use it as a kick
- Re-Added RCE

]]
--[[
# TODO:
	copy join logger from main log into own log.
	 -> option to remove from main log


	auto kick modder
	auto kick own modder  flags
	casino heist control, manual mode reset prev
	same for modder remember 
	global ped / vehicle mgr like wolfry, just better :trollmove:

	return false
		->
	return

	if var == nil then
		->
	if not var then

	remove modder from db
	advanced drone / like robot
	teleport sub-menu, save current pos
	force gun
	attach objects on hand -> punsh with dildos etc.
	custom script event sender, improvements: toggle / send more events / random args
	kick chinese chars
	kick spammer
	deadline in freemode
	reload script
	super script adviser


	MPPLY_CASINO_CHIPS_WONTIM -> int -> stat -> 100% rig slot shit
]]
