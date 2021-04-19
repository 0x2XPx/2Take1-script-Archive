-- Kek's menu version 0.3.8
-- FOR BEST EXPERIENCE, REVIEW CODE WITH SUBLIME TEXT 3
-- If you find any bugs, please message me on discord: Kektram#8996

-- Checks if kek is open
	if is_keks_menu_loaded then 
		ui.notify_above_map("Kek's menu is already loaded!", "Initialization cancelled.", 210) 
		return 
	end
	is_keks_menu_loaded = true
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
			"1.0.8", -- Vehicle mapper
			"1.0.6", -- Ped mapper
			"1.0.5", -- Object mapper 
			"1.1.2" -- Globals
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
				if not c:find("autoexec.lua") then
					local B, K = get_file_string(path..file_name, "*l"), file_name:lower()
					if (not name and B:find(match)) or (not not_exact and name == K) or (not_exact and K:find(name:gsub(file_extension, ""))) then
						return {c, file_name, path..file_name}
					end
				end
			end
			return {nil, nil}
		end

-- Validity check
	-- Directories & files
		for i, k in pairs({"", "kekMenuData", "profiles", "kekMenuLogs", "kekMenuLibs", "Player stats", "Player history"}) do
			if not utils.dir_exists(o.kek_menu_stuff_path..k) then
				utils.make_dir(o.kek_menu_stuff_path..k)
			end
		end

		local Temp = {"-- Lib vehicle_mapper version", "-- Lib ped_mapper version", "-- Lib object_mapper version", "-- Lib kek_globals version"}
		for i, k in pairs(Temp) do
			local v = get_file("scripts\\kek_menu_stuff\\kekMenuLibs\\", "lua", k)
			if not v[1] then
				ui.notify_above_map("You're missing a file in kek_menu_stuff\\kekMenuLibs. Please reinstall Kek's menu.", "", 6)
				return
			end
			local STR = get_file_string(v[3], "*l")
			if not STR or STR:match(": (.*)") ~= lib_versions[i] then
				ui.notify_above_map("There's a library file which is the wrong version, please reinstall kek's menu.", "", 6)
				return
			end
		end

		local Temp = {"kekMenuData\\profile names.ini", "kekMenuData\\custom_chat_judge_data.txt", "kekMenuLogs\\Modder database.log", "kekMenuData\\Kek's chat bot.txt", "kekMenuData\\Spam text.txt"}
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
			for line in str:gmatch("([^\n]*)\n?") do
				if not line:match("&|<<>.,(.*)&|<<>.,") then
					Temp()
					ui.notify_above_map("Something was wrong with the profiles names.\nNames set to default.", "", 212)
					break
				end
				e = e + 1
			end
			if e ~= 10 then
				Temp()
				ui.notify_above_map("Something was wrong with the profiles names.\nNames set to default.", "", 212)
			end
		else
			Temp()
		end

	-- Libraries
		--Load all libraries
			package.path = o.kek_menu_stuff_path.."kekMenuLibs\\?.lua"
			-- Originally made by Sai, edited by Kektram
				local globals = require(get_file("scripts\\kek_menu_stuff\\kekMenuLibs\\", "lua", "-- Lib kek_globals version")[2]:gsub(".lua", ""))

			-- Originally made by QuickNET, edited by Kektram
				local vMap = require(get_file("scripts\\kek_menu_stuff\\kekMenuLibs\\", "lua", "-- Lib vehicle_mapper version")[2]:gsub(".lua", ""))

				local pMap = require(get_file("scripts\\kek_menu_stuff\\kekMenuLibs\\", "lua", "-- Lib ped_mapper version")[2]:gsub(".lua", ""))

				local oMap = require(get_file("scripts\\kek_menu_stuff\\kekMenuLibs\\", "lua", "-- Lib object_mapper version")[2]:gsub(".lua", ""))

	-- misc vars
		o.loops_on = true
		u.searched_players_in_history = {}
		u.year_parents, u.month_parents = {}, {}
		u.hour_parents, u.day_parents = {}, {}
		u.player_properties = {}
		u.where_player_properties_are_located = {}
		local vehicle_blacklist_selected_players = {}
		local setting, setting_names = {}, {}
		u.malicious_event_count = {}
		local otr_table, people_to_echo_chat, people_stat_detected = {}, {}, {}
		for pid = 0, 31 do
			people_to_echo_chat[pid] = nil
			otr_table[pid] = 0
			people_stat_detected[pid] = nil
			u.malicious_event_count[pid] = {player.get_player_scid(pid), 0, 0}
		end
		temp.car, o.selected_players, temp.what_object = {}, {}, "?"

-- User interface(parents)
	-- Global
		u.kekMenu = menu.add_feature("Kek's menu", "parent", 0)
		u.settingsUI = menu.add_feature("General settings", "parent", u.kekMenu.id)
		u.gvehicle = menu.add_feature("Vehicle", "parent", u.kekMenu.id)
		u.vehicle_self = menu.add_feature("Self", "parent", u.gvehicle.id)
		u.vehicle_friendly = menu.add_feature("Vehicle peaceful", "parent", u.gvehicle.id)
		u.vehicle_trolling = menu.add_feature("Vehicle trolling", "parent", u.gvehicle.id)
		u.vehicleSettings = menu.add_feature("Vehicle settings", "parent", u.gvehicle.id)
		u.vehicle_blacklist = menu.add_feature("Vehicle blacklist", "parent", u.gvehicle.id)
		u.session_malicious = menu.add_feature("Session malicious", "parent", u.kekMenu.id)
		u.player_history = menu.add_feature("Player history", "parent", u.kekMenu.id)
		u.session_script_stuff = menu.add_feature("Scripts", "parent", u.session_malicious.id)
		u.session_m_settings = menu.add_feature("Settings", "parent", u.session_malicious.id)
		u.chat_stuff = menu.add_feature("Chat", "parent", u.kekMenu.id)
		u.custom_chat_judger = menu.add_feature("Custom chat judger", "parent", u.chat_stuff.id)
		u.chat_bot = menu.add_feature("Chat bot", "parent", u.chat_stuff.id)
		u.chat_spammer = menu.add_feature("Chat spamming", "parent", u.chat_stuff.id)
		u.notifSettings = menu.add_feature("Notification settings", "parent", u.settingsUI.id)
		u.hotkey_settings = menu.add_feature("Hotkey settings", "parent", u.settingsUI.id)
		u.modder_detection = menu.add_feature("Modder detection", "parent", u.kekMenu.id)
		u.blacklist = menu.add_feature("Blacklist", "parent", u.modder_detection.id)
		u.what_to_do_with_tags = menu.add_feature("What to do with modders", "parent", u.modder_detection.id)
		u.protections = menu.add_feature("Protections", "parent", u.modder_detection.id)
		u.flagsTolog = menu.add_feature("Modder logging settings", "parent", u.modder_detection.id)
		u.flagsToUnmark = menu.add_feature("Modder unmark settings", "parent", u.modder_detection.id)
		u.flagsToKick = menu.add_feature("Auto kick tag settings", "parent", u.modder_detection.id)
		u.modder_detection_settings = menu.add_feature("Which modder detections are on", "parent", u.modder_detection.id)
		u.weapons = menu.add_feature("Weapons", "parent", u.kekMenu.id)
		u.kek_utilities = menu.add_feature("Kek's utilities", "parent", u.kekMenu.id)
		u.script_loader = menu.add_feature("Script loader", "parent", u.kekMenu.id)
		u.profiles = menu.add_feature("Settings", "parent", u.kekMenu.id)

	-- Player
		u.kekMenuP = menu.add_player_feature("Kek's menu", "parent", 0).id
		u.pVehicles = menu.add_player_feature("Vehicle", "parent", u.kekMenuP).id
		u.pWeapons = menu.add_player_feature("Weapons", "parent", u.kekMenuP).id
		u.pTroll = menu.add_player_feature("Trolling", "parent", u.kekMenuP).id
		u.player_chat_features = menu.add_player_feature("Chat", "parent", u.kekMenuP).id
		u.pMalicious = menu.add_player_feature("Malicious", "parent", u.kekMenuP).id
		u.p_utilities = menu.add_player_feature("Player utilities", "parent", u.kekMenuP).id
		u.player_blacklist_features = menu.add_player_feature("Blacklist", "parent", u.kekMenuP).id
		u.script_stuff = menu.add_player_feature("Scripts", "parent", u.kekMenuP).id
		u.p_peds = menu.add_player_feature("Pedestrian", "parent", u.kekMenuP).id

-- Useful functions
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
		local function find_and_toggle_on_or_off_toggle(text, toggle_off)
			if not setting[text] then
				for i, k in pairs(toggle) do
					if k[1] == text then
						if toggle_off then 
							k[2].on = false
						else
							k[2].on = true
						end
						break
					end
				end
			end
		end

	-- Random wait for intense loops
		local function random_wait(t)
			local t = math.round(t)
			if t < 1 then
				t = 1
			end
			if math.random(1, t) == 1 then
				system.yield(0)
			end
			return HANDLER_CONTINUE
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
		local function do_key(k, t)
			local key, time = MenuKey(), utils.time_ms() + t
			key:push_str(k)
			while key:is_down() and time > utils.time_ms() do
				system.yield(0)
			end
		end

	-- Messager function
		local function msg(text, color, notifyOn)
			if notifyOn then
				ui.notify_above_map("~h~"..text, "Kek's menu "..setting["Version"].." ~p~¦", color)
			end
		end

	-- Input function
		local function get_input(title, default, len, type, default_return)
			do_key("RETURN", 5000)
			local input_status, text = 1
			while input_status == 1 do
				system.yield(0)
				input_status, text = input.get(title, default, len, type)
			end
			do_key("RETURN", 5000)
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
			if value_i_int < feature.min_i then
				feature.value_i = feature.min_i
			elseif feature.max_i >= value_i_int then
				feature.value_i = value_i_int
			else
				feature.value_i = feature.max_i
			end
		end

	-- Get IP
		local function get_ip_in_ipv4(pid)
			local ip = player.get_player_ip(pid)
			return string.format("%i.%i.%i.%i", ip >> 24 & 0xff, ip >> 16 & 0xff, ip >> 8 & 0xff, ip & 0xff)
		end

	-- Ipv4 to dec
		local function ipv4_to_dec(ip)
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

	-- Search for match in file
		local function search_for_match_and_get_line(file_name, text_to_search_for_match_for, match_has_to_be_exact, dont_need_to_find_line)
			local str = get_file_string(file_name, "*a")
			if not match_has_to_be_exact then
				for i, text in pairs(text_to_search_for_match_for) do
					if string.replace_special_characters(str):find(string.replace_special_characters(text)) then
						if dont_need_to_find_line then
							return true
						else
							break
						end
					end
					if i == #text_to_search_for_match_for then
						return
					end
				end
			end
			for line in str:gmatch("([^\n]*)\n?") do
				for i, k in pairs(text_to_search_for_match_for) do
					local V = string.replace_special_characters(tostring(k))
					if (not match_has_to_be_exact and string.replace_special_characters(line):find(V)) or (match_has_to_be_exact and V == string.replace_special_characters(line)) then
						return line
					end
				end
			end
		end

	-- Log / check if already in file
		local function log(file_name, text_to_log, text_to_search_for_match_for, match_has_to_be_exact)
			if text_to_search_for_match_for then
				local line_from_text_file = search_for_match_and_get_line(file_name, text_to_search_for_match_for, match_has_to_be_exact)
				if line_from_text_file then
					return line_from_text_file
				end
			end
    		local file = io.open(o.home..file_name, "a+")
    		file:write(text_to_log.."\n")
    		file:flush()
    		file:close()
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
		function table.merge(parent_table, child_table)
			for i = 1, #child_table do
				parent_table[#parent_table + 1] = child_table[i]
			end
			return parent_table
		end

	-- Remove / replace a value from file
		local function modify_entry(file_name, text_to_remove_or_modify, match_has_to_be_exact, replace_text, duplicate_protection)
			if utils.file_exists(o.home..file_name) then
				if search_for_match_and_get_line(file_name, text_to_remove_or_modify, match_has_to_be_exact) then
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
							line_without_special_chars = string.replace_special_characters(tostring(line))
							if not replace_text and ((not match_has_to_be_exact and line_without_special_chars:find(text)) or (match_has_to_be_exact and line_without_special_chars == text)) then
								break
							elseif ((match_has_to_be_exact and line_without_special_chars == text_to_remove_or_modify[1]) or (not match_has_to_be_exact and replace_text and line_without_special_chars:find(text_to_remove_or_modify[1]))) and replace_text and math.floor(i / 2) ~= i / 2 then
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
				1922258436,
				1101235920,
				-1054826273,
				1620254541,
				1401831542,
				2099816323,
				-1491386500
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
				{nil, "Modded-Name"}
			}
		o.modder_flag_setting_properties = 
			{
				{"Log people with ", "log: ", u.flagsTolog}, 
				{"Kick people with ", "kick: ", u.flagsToKick}, 
				{"Unmark people with ", "Unmark: ", u.flagsToUnmark}
			}

		local modIdStuff = {}
			for i, custom_modder_flag in pairs(keks_custom_modder_flags) do
				for p = 17, 62 do
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
		    for int_modder_flag = 0, 16  do
				modIdStuff[#modIdStuff + 1] = 1 << int_modder_flag
			end

	-- General settings
		local general_settings = 
			{
				{"Version", "0.3.8"},
				{"Force host", false}, 
				{"Automatically check player stats", true}, 
				{"Auto kicker", false}, 
				{"Log modders", true}, 
				{"Blacklist", true},
				{"Spawn #vehicle# maxed", true}, 
				{"Delete old #vehicle#", true}, 
				{"Custom chat judger", false}, 
				{"Judge selected only", false},
				{"Chat judge reaction", 2}, 
				{"Default vehicle", "krieger"},
				{"Exclude friends from attacks #malicious#", true}, 
				{"Spawn inside of spawned #vehicle#", true}, 
				{"Always f1 wheels on #vehicle#", false}, 
				{"Ram speed", 150}, 
				{"hotkeys", true}, 
				{"Auto kicker #notifications#", true}, 
				{"Chat judge #notifications#", true},
				{"Guide text #notifications#", true}, 
				{"Always ask what #vehicle#", false}, 
				{"Air #vehicle# spawn mid-air", true}, 
				{"Hotkeys #notifications#", true}, 
				{"Auto unmark", false}, 
				{"Auto tag modders after sending kick #malicious#", true},   
				{"Plate vehicle text", "Kektram"}, 
				{"Modded stats severity", 3}, 
				{"Vehicle fly speed", 150}, 
				{"Spawn #vehicle# in godmode", false}, 
				{"OTR detection", true},
				{"Vehicle blacklist", false},
				{"Vehicle blacklist #notifications#", true},
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
				{"Ignore players while clearing entities", true},
				{"Player history", true},
				{"History limit", 1500},
				{"Default pedestrian", "a_f_y_topless_01"},
				{"Modded net event detection", false},
				{"Entity crash protection", false},
				{"Vehicle blacklist apply only on specific players", false},
				{"Modded scid detection", true},
				{"Modded name detection", true}
			}

-- Entity functions
	-- Distance between 2 entities
		local function get_distance_between(entity_or_position_1, entity_or_position_2, is_looking_for_distance_between_coords)
			if is_looking_for_distance_between_coords then
				local distance_between = entity_or_position_1 - entity_or_position_2
				return math.abs(distance_between.x) + math.abs(distance_between.y)
			else
				local distance_between = entity.get_entity_coords(entity_or_position_1) - entity.get_entity_coords(entity_or_position_2)
				return math.abs(distance_between.x) + math.abs(distance_between.y)
			end
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
				return table.merge(vehicle.get_all_vehicles(), ped.get_all_peds())
			elseif type == 6 then
				return table.merge(table.merge(vehicle.get_all_vehicles(), ped.get_all_peds()), table.merge(object.get_all_pickups(), object.get_all_objects()))
			end
		end

	-- Request control
		local function get_control_of_entity(entity_to_get_control_of)
			if entity.is_an_entity(entity_to_get_control_of) then
				if not network.has_control_of_entity(entity_to_get_control_of) then
	   				network.request_control_of_entity(entity_to_get_control_of)
	    			local time = utils.time_ms() + 500
	    			while entity.is_an_entity(entity_to_get_control_of) and not network.has_control_of_entity(entity_to_get_control_of) and time > utils.time_ms() do
	       				system.yield(0)
	    			end
				else
					return true
				end
			end
			return network.has_control_of_entity(entity_to_get_control_of)
		end

	-- Give entity godmode
		local function modify_entity_godmode(target_entity, toggle_on_god)
			if get_control_of_entity(target_entity) and entity.get_entity_god_mode(target_entity) ~= toggle_on_god then
				entity.set_entity_god_mode(target_entity, toggle_on_god)
			end
		end

	-- Max vehicle
		local function max_car(car)
			if entity.is_entity_dead(car) or not get_control_of_entity(car) then 
				return
			end
			local e = {}
			for i = 1, 7 do
				local num = math.round(math.maxinteger / math.random(1000000, 2000000000))
				e[i] = math.random(num - 4000000000, num)
			end
			vehicle.set_vehicle_mod_kit_type(car, 0)
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
			vehicle.set_vehicle_bulletproof_tires(car, true)
			vehicle.set_vehicle_mod(car, 11, 3)
			vehicle.set_vehicle_mod(car, 12, 2)
			vehicle.set_vehicle_mod(car, 16, 4)
			vehicle.set_vehicle_mod(car, 18, 0)
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
			return HANDLER_CONTINUE
		end

	-- Request model
		local function request_model(model_hash)
			if streaming.is_model_valid(model_hash) then 
				if not streaming.has_model_loaded(model_hash) then
	   				streaming.request_model(model_hash)
	    			local time = utils.time_ms() + 500
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

	-- World vector
		local function get_vector_relative_to_player(player_coords, direction_player_is_facing, distance_from_player)
			local direction_player_is_facing = math.rad((direction_player_is_facing - 180) * -1)
			player_coords.x = player_coords.x + (math.sin(direction_player_is_facing) * -distance_from_player)
			player_coords.y = player_coords.y + (math.cos(direction_player_is_facing) * -distance_from_player)
			return player_coords
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

	-- Spawn a vehicle
		local function spawn_vehicle(hash, coords, direction_vehicle_will_face, fully_pimp_vehicle_after_spawned, give_godmode)
			if request_model(hash) then
				local car
				if fully_pimp_vehicle_after_spawned then
					car = vehicle.create_vehicle(hash, player.get_player_coords(player.player_id()) + v3(0, 0, 45), 0, true, false)
					max_car(car)
					entity.set_entity_coords_no_offset(car, coords)
				else
					car = vehicle.create_vehicle(hash, coords, direction_vehicle_will_face, true, false)
				end
				if give_godmode then
					modify_entity_godmode(car, true)
				end
				entity.set_entity_heading(car, direction_vehicle_will_face)
				streaming.set_model_as_no_longer_needed(hash)
				return car
			end
			return HANDLER_CONTINUE
		end

	-- Spawn a pedestrian
		local function spawn_pedestrian(type, hash, coords, direction_ped_will_face)
			if request_model(hash) then
				local ped = ped.create_ped(type, hash, coords, direction_ped_will_face, true, false)
				streaming.set_model_as_no_longer_needed(hash)
				return ped
			end
		end

	-- Spawn an object
		local function spawn_object(hash, coords)
			if request_model(hash) then
				local object = object.create_object(hash, coords, true, true)
				streaming.set_model_as_no_longer_needed(hash)
				return object
			end
		end

	-- Remove players from entity table
		local function remove_player_entities(table_of_entities)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if player.is_player_in_any_vehicle(pid) then
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

	-- Clear entities
		local function clear_entities(table_of_entities, avoid_players)
			local me = player.player_id()
			local my_ped = player.get_player_ped(me)
			if avoid_players and setting["Ignore players while clearing entities"] then
				remove_player_entities(table_of_entities)
			elseif avoid_players then
				local index_of_my_vehicle = table.get_index_of_value(table_of_entities, player.get_player_vehicle(me))
				if index_of_my_vehicle then
					table.remove(table_of_entities, index_of_my_vehicle)
				end
				local index_of_my_ped = table.get_index_of_value(table_of_entities, my_ped)
				if index_of_my_ped then
					table.remove(table_of_entities, index_of_my_ped)
				end
			end
			table.sort(table_of_entities, function(a, b) return (get_distance_between(a, my_ped) < get_distance_between(b, my_ped)) end)
			local min, ceil = math.min, math.ceil
			local delete, teleport_entity = entity.delete_entity, teleport
			local co_routines, pos = {}, v3(16000, 16000, -1500)
			local no_longer_need = entity.set_entity_as_no_longer_needed
			for i = 1, #table_of_entities do
				co_routines[#co_routines + 1] = coroutine.create(function()
					if entity.is_an_entity(table_of_entities[i]) and (not avoid_players or table_of_entities[i] ~= player.get_player_vehicle(me)) then
						entity.set_entity_as_mission_entity(table_of_entities[i], true, false)
						if teleport_entity(table_of_entities[i], pos) then
							delete(table_of_entities[i])
						end
						no_longer_need(table_of_entities[i])
					end
				end)
				coroutine.resume(co_routines[#co_routines])
				random_wait(7)
			end
		end

	-- Ram function
		local function spawn_and_push_a_vehicle_in_direction(pid, clear_vehicle_after_ram, distance_from_target, hash)
			if not entity.is_entity_dead(player.get_player_ped(pid)) and player.get_player_coords(pid).z > -20 then
				local me, v = player.player_id(), v3()
				local direction_player_is_facing = player.get_player_heading(pid)
				if player.is_player_in_any_vehicle(pid) then
					local their_car = player.get_player_vehicle(pid)
					network.request_control_of_entity(their_car)
					v = entity.get_entity_velocity(their_car) / setting["Ram speed"]
				end
				local car = spawn_vehicle(hash, get_vector_relative_to_player(player.get_player_coords(pid) + v, direction_player_is_facing, distance_from_target), direction_player_is_facing)
				vehicle.set_vehicle_forward_speed(car, setting["Ram speed"])
				if clear_vehicle_after_ram then
					system.yield(250)
					clear_entities({car})
				end
				entity.set_entity_as_no_longer_needed(player.get_player_vehicle(pid))
				return car
			else
				return HANDLER_CONTINUE
			end
		end

	-- Max ped's combat attributes
		local function set_combat_attributes(Ped, Weapon, god, noblip, custom, use_vehicle, driveby, cover, leave_vehicle, unarmed_fight_armed, taunt_in_vehicle, always_fight, ignore_traffic, use_fireing_weapons)
			modify_entity_godmode(Ped, god)
			local attributes = 
				{
					{0, cover}, {1, use_vehicle}, {2, driveby}, {3, leave_vehicle}, {5, unarmed_fight_armed}, {20, taunt_in_vehicle},
					{46, always_fight}, {52, ignore_traffic}, {1424, use_fireing_weapons} 
				}
			for i, attribute in pairs(attributes) do
				if not attribute[2] and custom then
					ped.set_ped_combat_attributes(Ped, attribute[1], false)
				else
					ped.set_ped_combat_attributes(Ped, attribute[1], true)
				end
			end
			weapon.give_delayed_weapon_to_ped(Ped, Weapon, 0, 1)
			ped.set_ped_combat_ability(Ped, 2)
			ped.set_ped_combat_range(Ped, 2)
			ped.set_ped_combat_movement(Ped, 3)
			if not noblip then
				local blip = ui.add_blip_for_entity(Ped)
				ui.set_blip_sprite(blip, 310)
				ui.set_blip_colour(blip, 29)
			end
		end

	-- Spawn self car
		local function spawn_car()
			if setting["Always ask what #vehicle#"] then
				txt.kekText2 = get_input("Type in what car to use", "", 128, 0, setting["Default vehicle"])
			end
			local me, hash = player.player_id(), vMap.GetHashFromModel(txt.kekText2)
			local dir = player.get_player_heading(me)
			temp.car[#temp.car + 1] = player.get_player_vehicle(me)
			if request_model(hash) then
				local car = vehicle.create_vehicle(hash, get_vector_relative_to_player(player.get_player_coords(me), dir, 5), dir, true, false)
				local co = coroutine.create(function()
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
					if setting["Spawn #vehicle# maxed"] then
						max_car(car)
					elseif setting["Always f1 wheels on #vehicle#"] then
						vehicle.set_vehicle_wheel_type(car, 10)
					end
					if setting["Spawn #vehicle# in godmode"] then
						modify_entity_godmode(car, true)
					end
				end)
				coroutine.resume(co)
				if setting["Delete old #vehicle#"] then
					clear_entities(temp.car)
					temp.car = {}
				end
				temp.car[#temp.car + 1] = car
			end
		end

	-- Check if target is valid for remote vehicle stuff
		local function is_target_viable(pid, number_of_tp, doesnt_matter_if_god)
			local me, pos = player.player_id(), player.get_player_coords(pid) + v3(0, 0, 20)
			if not player.is_player_valid(pid) or (not doesnt_matter_if_god and player.is_player_god(pid)) or player.is_player_modder(pid, -1) then
				return
			end
			if player.get_player_coords(pid).z > -20 and not player.is_player_in_any_vehicle(pid) then
				return
			end
			if player.is_player_in_any_vehicle(pid) then
				return player.is_player_in_any_vehicle(pid), player.get_player_vehicle(pid)
			end
			local e
			if player.is_player_in_any_vehicle(me) then
				e = player.get_player_vehicle(me)
			else
				e = player.get_player_ped(me)
			end
			local dist = get_distance_between(e, player.get_player_ped(pid))
			for i = 1, number_of_tp + math.round((dist / 550)) do
				if player.is_player_in_any_vehicle(pid) then
					break
				else
					local pos = player.get_player_coords(pid)
					pos.z = math.abs(pos.z) + 40
					entity.set_entity_coords_no_offset(e, pos)
					system.yield(100)
				end
			end
			return player.is_player_in_any_vehicle(pid), player.get_player_vehicle(pid)
		end

-- Settings stuff
	-- What flags function
		local function get_all_modder_flags(pid, type)
			local flags = {}
			for i, k in pairs(modIdStuff) do
				if player.is_player_modder(pid, k) and setting[type..player.get_modder_flag_text(k)] then
					flags[#flags + 1] = player.get_modder_flag_text(k)
				end
			end
			return {table.concat(flags, ", "), #flags}
		end

	-- Kek's script loader
		local function Temp()
			local e
			if utils.file_exists(o.home.."scripts\\autoexec.lua") then
				e = get_file_string("scripts\\autoexec.lua", "*a")
			else
				local file = io.open(o.home.."scripts\\autoexec.lua", "w+")
				file:close()
			end
			if not e or not e:find("sjhvncuugfjkhdjkhUSx") then
				local file = io.open(o.home.."scripts\\autoexec.lua", "w+")
				file:write("\nlocal sjhvncuugfjkhdjkhUSx = menu.add_feature(\"\", \"toggle\", 0, function(f)\n")
				file:write("	local appdata_path = utils.get_appdata_path(\"PopstarDevs\", \"\")..\"\\\\2Take1Menu\\\\\"\n")
				file:write("	local scripts = {}\n")
				file:write("	system.yield(300)\n")
				file:write("	for i, k in pairs(scripts) do\n")
				file:write("		if utils.file_exists(appdata_path..\"scripts\\\\\"..k) then\n")
				file:write("			dofile(appdata_path..\"scripts\\\\\"..k)\n")
				file:write("		end\n")
				file:write("	end\n")			
				file:write("	f.on = false\n")
				file:write("	menu.delete_feature(f.id)\n")
				file:write("	return HANDLER_CONTINUE\n")
				file:write("end)\n")
				file:write("sjhvncuugfjkhdjkhUSx.hidden = true\n")
				file:write("sjhvncuugfjkhdjkhUSx.on = true")
				file:flush()
				file:close()
			end
		end

		menu.add_feature("Toggle on / off script loader", "action", u.script_loader.id, function()
			Temp()
			local str = get_file_string("scripts\\autoexec.lua", "*a")
			if str and str:sub(1, 6) ~= "return" then
				local file = io.open(o.home.."scripts\\autoexec.lua", "w+")
				file:write("return"..str)
				file:flush()
				file:close()
				msg("Turned off script loader!", 212, true)
			else
				modify_entry("scripts\\autoexec.lua", {"return", ""}, true, true)
				msg("Turned on script loader!", 212, true)
			end
		end)

		menu.add_feature("Empty script loader file", "action", u.script_loader.id, function()
			local file = io.open(o.home.."scripts\\autoexec.lua", "w+")
			file:close()
			msg("Emptied script loader file.", 212, true)
		end)

		menu.add_feature("Add script to auto loader", "action", u.script_loader.id, function()
			Temp()
			local str = get_input("Type in name of the lua script to add.", "", 128, 0):lower():gsub(".lua", "")
			local c = get_file("scripts\\", "lua", "", str..".lua", true)
			if not utils.file_exists(o.home.."scripts\\autoexec.lua") then
				local file = io.open(o.home.."scripts\\autoexec.lua", "w+")
				file:close()
			end
			if c[1] then 
				if not search_for_match_and_get_line("scripts\\autoexec.lua", {c[2]}) then
					local str = get_file_string("scripts\\autoexec.lua", "*a")
					modify_entry("scripts\\autoexec.lua", {"	local scripts = {}", "	local scripts = {}\n	scripts[#scripts + 1] = \""..c[2].."\""}, true, true)
					msg("Added "..c[1]:match(o.home.."scripts\\(.*)").." to script loader.", 212, true)
				else
					msg(c[1]:match(o.home.."scripts\\(.*)").." is already in the script loader!", 210, true)
				end
			else
				msg("Couldn't find the requested lua file.", 6, true)
			end
		end)

		menu.add_feature("Remove script from auto loader", "action", u.script_loader.id, function()
			Temp()
			local str = get_input("Type in name of the lua script you want to remove.", "", 128, 0):lower():gsub(".lua", "")
			local c = get_file("scripts\\", "lua", "", str..".lua", true)
			local result = modify_entry("scripts\\autoexec.lua", {"	scripts[#scripts + 1] = \""..c[2].."\""}, true)
			if result == 1 then
				msg("Removed "..c[1]:match(o.home.."scripts\\(.*)").." from script loader.", 140, true)
			elseif result == 2 then
				msg("Couldn't find requested file.", 6, true)
			else
				msg("Autoexec doesn't exist.", 6, true)
			end
		end)

	-- Mod tag related settings
		temp.flags_to_turn_off = 
			{
				{keks_custom_modder_flags[1][1], keks_custom_modder_flags[2][1], keks_custom_modder_flags[3][1], keks_custom_modder_flags[5][1], keks_custom_modder_flags[6][1], 1, 65536}, -- Modder logging tags
				{keks_custom_modder_flags[1][1], keks_custom_modder_flags[2][1], keks_custom_modder_flags[5][1], keks_custom_modder_flags[6][1], 1, 65536}, -- Auto kicker tags 
				{} -- Auto unmark tags
			}
		for index_of_setting_properties, setting_property in pairs(o.modder_flag_setting_properties) do
			local number_of_settings_before_current_loop = #setting_names
			local number_of_toggle_settings_before_current_loop = #toggle
			menu.add_feature("Invert all switches", "action", setting_property[3].id, function()
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
				toggle[#toggle + 1] = {setting_property[1]..modder_flag_text, menu.add_feature(setting_property[2]..modder_flag_text, "toggle", setting_property[3].id, function(f) 
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

-- Malicious player functions
	-- Send script event
		local function send_script_event(hash, target, args, friend_condition)
			if player.is_player_valid(target) and target ~= player.player_id() and (not friend_condition or (not setting["Exclude friends from attacks #malicious#"]) or not network.is_scid_friend(player.get_player_scid(target))) then
				script.trigger_script_event(hash, target, args)
			end
		end

	-- Get arg table
		local function get_full_arg_table()
			local m = math.random
			local a, b = -2147483647, 2147483647
			return { m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b),
			m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), 
			m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b),
			m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b), m(a, b)}
		end

	-- kick
		local function kick(pid)
			if player.is_player_valid(pid) and not network.network_is_host() then
				if not player.is_player_modder(pid, -1) then
					send_script_event(-435067392, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
					for i = 1, 10 do
						if not player.is_player_valid(pid) then
							return
						end
						system.yield(40)
					end
				end
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
						send_script_event(k, pid, get_full_arg_table())
					end
				end
			else
				network.network_session_kick_player(pid)
			end
		end

	-- Script event crash
		local function script_event_crash(pid)
			if script.get_host_of_this_script() == pid then
				for i = 0, 14 do
					send_script_event(-2122716210, pid, {0, i})
				end
				for i = 1, 20 do
					system.yield(0)
					local parameters = {}
					for I = 1, 120 do
						for i = 1, 26 do
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

	-- Give bounty 
		local function set_bounty(script_target, friend_condition)
			local me = player.player_id()
			if me == script.get_host_of_this_script() or script_target == me then
				return
			end
			decorator.decor_set_int(player.get_player_ped(script_target), "MPBitset", 0)
			for pid = 0, 31 do
				send_script_event(-116602735, script_target, {-1, pid, 1, 10000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)}, friend_condition)
			end
			return HANDLER_CONTINUE
		end

		local function disable_vehicle(pid, friend_condition)
			local pos = player.get_player_coords(pid)
			send_script_event(-152440739, pid, {pid, math.round(pos.x), math.round(pos.y), math.round(pos.z), 0}, friend_condition)
			send_script_event(-1662268941, pid, {pid, pid}, friend_condition)
			send_script_event(-1333236192, pid, {pid, 0, 0, 0, 0, 1, pid, gameplay.get_frame_count()}, friend_condition)
		end

	-- Chat judge reactions
		local function reactions(pid, type)
			if type == 1 then 
				set_bounty(pid)
				msg("Chat judge:\nBounty set on "..player.get_player_name(pid)..".", 140, setting["Chat judge #notifications#"])
			elseif type == 2 then
				local time = utils.time_ms() + 5000
				msg("Chat judge:\nRamming "..player.get_player_name(pid).." with explosive tankers", 140, setting["Chat judge #notifications#"])
				local Ped = player.get_player_ped(pid)
				while time > utils.time_ms() do
					spawn_and_push_a_vehicle_in_direction(pid, true, -8, 3564062519)
					system.yield(0)
				end
			elseif type == 3 then
				disable_vehicle(pid)
				msg("Chat judge:\nKicking player out of their vehicle.", 140, setting["Chat judge #notifications#"])
			elseif type == 4 then
				msg("Chat judge:\nKicking "..player.get_player_name(pid), 140, setting["Chat judge #notifications#"])
				kick(pid)
			elseif type == 5 then
				msg("Chat judge:\nCrashing "..player.get_player_name(pid), 140, setting["Chat judge #notifications#"])
				script_event_crash(pid)
			end
		end

-- Modder detection
	-- Init nethook
		temp.net_hook = hook.register_net_event_hook(function(pid, me, event)
			if not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"] then
				if setting["Kick any vote kickers"] and event == 64 then
					msg(player.get_player_name(pid).." sent vote kick.\nKicking them...", 6, true)
					if not network.network_is_host() then
						send_script_event(-435067392, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
						send_script_event(1070934291, pid, {pid, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10})
					else
						network.network_session_kick_player(pid)
					end
				end

				if setting["Modded net event detection"] and table.get_index_of_value({13, 14, 78, 43, 83, 74}, event) then
					player.set_player_as_modder(pid, keks_custom_modder_flags[6][1])
				end
				if setting["Entity crash protection"] then
					if u.malicious_event_count[pid][1] ~= player.get_player_scid(pid) then
						u.malicious_event_count[pid][1] = player.get_player_scid(pid)
						u.malicious_event_count[pid][2] = 0
					end
					if event == 5 and u.malicious_event_count[pid][3] == 0 then
						u.malicious_event_count[pid][3] = utils.time_ms() + 5200
					end
					if event == 5 then
						u.malicious_event_count[pid][2] = u.malicious_event_count[pid][2] + 1
					end
					if u.malicious_event_count[pid][3] ~= 0 and utils.time_ms() > u.malicious_event_count[pid][3] then
						u.malicious_event_count[pid][1] = player.get_player_scid(pid)
						u.malicious_event_count[pid][2] = 0
						u.malicious_event_count[pid][3] = 0
					end
					if u.malicious_event_count[pid][2] > 25 and utils.time_ms() > u.malicious_event_count[pid][3] then
						player.set_player_as_modder(pid, 16)
						msg(player.get_player_name(pid).." tried to crash you.", 6, true)
						u.malicious_event_count[pid][1] = player.get_player_scid(pid)
						u.malicious_event_count[pid][2] = 0
						u.malicious_event_count[pid][3] = 0
					end
				end
			end
		end)

	-- Stat detect function
		valuei["Severity"] = {"Modded stats severity", menu.add_feature("Modded stats, severity, click me", "autoaction_value_i", u.modder_detection_settings.id, function(f)
			setting["Modded stats severity"] = f.value_i
			local key = MenuKey()
			key:push_str("RETURN")
			if key:is_down() then
				msg("How many modded stat detections are needed to tag them as modder.", 140, true)
				msg("Minor detections are 1 in severity, severe ones like modded name, are 3.", 140, true)
			end
		end)}
		valuei["Severity"][2].min_i, valuei["Severity"][2].max_i, valuei["Severity"][2].mod_i = 1, 4, 1

		local function suspicious_stats(pid)
			local how_much_money_they_have, their_rank = globals.get_player_money(pid), globals.get_player_rank(pid)
			local their_kd, me, RID = globals.get_player_kd(pid), player.player_id(), player.get_player_scid(pid)
			if player.is_player_valid(pid) and their_rank ~= 0 and people_stat_detected[pid] ~= RID and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and j ~= me and (how_much_money_they_have ~= globals.get_player_money(me) or their_rank ~= globals.get_player_rank(me) or their_kd ~= globals.get_player_kd(me)) then
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
					what_flags_they_have_text = what_flags_they_have_text.."A lot of money & low rank.".."\n"
				elseif how_much_money_they_have > ((their_rank / 200) * 1000000) * their_rank + 5000000 then
					severity = severity + 1
					what_flags_they_have_text = what_flags_they_have_text.."Too much money for the rank.".."\n"
				elseif how_much_money_they_have > 120000000 or 0 > how_much_money_they_have then
					severity = severity + 1
					what_flags_they_have_text = what_flags_they_have_text.."Has a lot of money.".."\n"
				end
				if their_rank < 0 or their_kd < 0 then
					severity = severity + 3
					if their_rank < 0 then
						what_flags_they_have_text = what_flags_they_have_text.."Negative lvl".."\n"
					end
					if their_kd < 0 then
						what_flags_they_have_text = what_flags_they_have_text.."Negative k/d".."\n"
					end
				end
				system.yield(10)
				if their_rank > 1000 then
					severity = severity + 1
					what_flags_they_have_text = what_flags_they_have_text.."High rank.".."\n"
				end
				if their_kd > 8 then
					severity = severity + 1
					what_flags_they_have_text = what_flags_they_have_text.."High k/d.".."\n"
				end
				if player.get_player_armour(pid) > 50 then
					severity = severity + 3
					what_flags_they_have_text = what_flags_they_have_text.."Has modded armor.".."\n"
				end
				for i, stat_int in pairs(misc_stats) do
					system.yield(0)
					if stat_int > math.max(math.min(their_rank * 3.5 + 200, 1100), 53) then
						severity = severity + 1
						what_flags_they_have_text = what_flags_they_have_text.."Too many wins.".."\n"
						break
					end
				end
				if severity >= setting["Modded stats severity"] then
					player.set_player_as_modder(pid, keks_custom_modder_flags[1][1])
					people_stat_detected[pid] = RID
					msg(player.get_player_name(pid).." has:".."\n"..what_flags_they_have_text.."Severity: "..severity, 6, true)
				end
			end
		end

	-- Modded scid detection
		toggle[#toggle + 1] = {"Modded scid detection", menu.add_feature("Modded scid detection", "toggle", u.modder_detection_settings.id, function(f)
			setting["Modded scid detection"] = true 
			while f.on do
				system.yield(500)
				for pid = 0, 31 do
					if player.player_id() ~= pid and player.is_player_valid(pid) and not player.is_player_modder(pid, 8) then
						local RID = player.get_player_scid(pid)
						if RID > 2147483647 or 100000 > RID then
							msg(player.get_player_name(pid).." has a modded scid.", 6, true)
							player.set_player_as_modder(pid, 8)
						end 
					end
					system.yield(0)
				end
			end
			setting["Modded scid detection"] = false
		end)}

	-- Modded name detection
		toggle[#toggle + 1] = {"Modded name detection", menu.add_feature("Modded name detection", "toggle", u.modder_detection_settings.id, function(f)
			setting["Modded name detection"] = true 
			while f.on do
				system.yield(500)
				for pid = 0, 31 do
					if player.player_id() ~= pid and player.is_player_valid(pid) and not player.is_player_modder(pid, keks_custom_modder_flags[7][1]) then
						local name = player.get_player_name(pid)
						local str = name:gsub("%.", "")
						local str = str:gsub("%-", "")
						local str = str:gsub("%_", "")
						if #name <= 5 or #name > 16 or str:find("%p") or name:match("(.*) (.*)") then
							msg(player.get_player_name(pid).." has a modded name.", 6, true)
							player.set_player_as_modder(pid, keks_custom_modder_flags[7][1])
						end 
					end
					system.yield(0)
				end
			end
			setting["Modded name detection"] = false
		end)}

	-- Entity crash protection
		toggle[#toggle + 1] = {"Entity crash protection", menu.add_feature("Entity crash protection", "toggle", u.protections.id, function(f)
			if f.on then
				setting["Entity crash protection"] = true
			else
				setting["Entity crash protection"] = false
			end
		end)}	

	-- Modded net-event protection
		toggle[#toggle + 1] = {"Modded net event detection", menu.add_feature("Modded net event detection", "toggle", u.modder_detection_settings.id, function(f)
			if f.on then
				setting["Modded net event detection"] = true
			else
				setting["Modded net event detection"] = false
			end
		end)}

	-- Recognize modders
		toggle[#toggle + 1] = {"Blacklist", menu.add_feature("Blacklist", "toggle", u.modder_detection_settings.id, function(f)
			if f.on then
				setting["Blacklist"] = true
				u.check_if_player_is_in_blacklist = event.add_event_listener("player_join", function(p)
					if player.player_id() == p.player then
						return
					end
					local e = {player.get_player_scid(p.player), player.get_player_name(p.player), player.get_player_ip(p.player)}
					if #tostring(e[1]) < 5 then
						e[1] = math.random(-math.pow(2, 61), math.pow(2, 62))
					end
					if #e[2] < 6 then
						e[2] = math.random(-math.pow(2, 61), math.pow(2, 62))
					end
					if not network.is_scid_friend(e[1]) or not setting["Exclude friends from attacks #malicious#"] then 
						local tags = search_for_match_and_get_line("scripts\\kek_menu_stuff\\kekMenuLogs\\Modder database.log", {"|"..e[1].."|", "|"..e[3].."|", "|"..e[2].."|"})
						if tags then
							msg("Recognized "..e[2]..", tags:\n"..tags:match(": (.*)"), 6, true)
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
		toggle[#toggle + 1] = {"Automatically check player stats", menu.add_feature("Check people's stats automatically", "toggle", u.modder_detection_settings.id, function(f)
			setting["Automatically check player stats"] = true
			while f.on do
				for pid = 0, 31 do
					if player.is_player_valid(pid) and player.player_id() ~= pid and not player.is_player_modder(pid, keks_custom_modder_flags[1][1]) then
						suspicious_stats(pid)
					end
					system.yield(0)
				end
				for i = 1, 30 do
					system.yield(2000)
					if not f.on then
						break
					end
				end
			end
			setting["Automatically check player stats"] = false
		end)}
		toggle[#toggle][2].threaded = true

	-- Check session's stats
		menu.add_feature("Check everyone's stats", "action", u.modder_detection.id, function()
			local me, mod = player.player_id(), keks_custom_modder_flags[1][1]
			for pid = 0, 31 do
				if player.is_player_valid(pid) and me ~= pid and not player.is_player_modder(pid, mod) then
					suspicious_stats(pid)
				end
			end
			msg("Checked lobby for modded stats.", 212, true)
		end)

	-- Check session if anyone's from the blacklist
		menu.add_feature("Check if anyone is in the blacklist", "action", u.modder_detection.id, function()
			local me, mod = player.player_id(), keks_custom_modder_flags[3][1]
			for pid = 0, 31 do
				if player.is_player_valid(pid) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and not player.is_player_modder(pid, mod) and pid ~= me then
					local e = {player.get_player_scid(pid), player.get_player_name(pid), player.get_player_ip(pid)}
					if #tostring(e[1]) < 5 then
						e[1] = math.random(-math.pow(2, 61), math.pow(2, 62))
					end
					if #e[2] < 6 then
						e[2] = math.random(-math.pow(2, 61), math.pow(2, 62))
					end
					local tags = search_for_match_and_get_line("scripts\\kek_menu_stuff\\kekMenuLogs\\Modder database.log", {"|"..e[1].."|", "|"..e[2].."|", "|"..e[3].."|"})
					if tags then
						msg("Recognized "..e[2]..", tags:\n"..tags:match(": (.*)"), 6, true)
						player.set_player_as_modder(pid, mod)
					end
				end
			end
			msg("Checked blacklist.", 212, true)
		end)

	-- Spectate detection
		toggle[#toggle + 1] = {"Modded spectate detection", menu.add_feature("Detect any modded spectate", "toggle", u.modder_detection_settings.id, function(f)
			setting["Modded spectate detection"] = true
			while f.on do
				local me = player.player_id()
				for pid = 0, 31 do
					local spectate_target = network.get_player_player_is_spectating(pid)
					if player.is_player_valid(pid) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and me ~= pid and pid ~= spectate_target and spectate_target and not entity.is_entity_dead(player.get_player_ped(pid)) then
						msg(player.get_player_name(pid).." is spectating "..player.get_player_name(spectate_target)..".", 6, true)
						player.set_player_as_modder(pid, keks_custom_modder_flags[5][1])
					end
					system.yield(0)
				end
				system.yield(2000)
			end					
			setting["Modded spectate detection"] = false
		end)}
		toggle[#toggle][2].threaded = true

	-- Off the radar detection
		toggle[#toggle + 1] = {"OTR detection", menu.add_feature("Detect too long off the radar", "toggle", u.modder_detection_settings.id, function(f)
			setting["OTR detection"] = true
			local players = {}
			for pid = 0, 31 do
				players[pid] = {pid, 0}
			end
			while f.on do
				system.yield(3000)
				local me = player.player_id()
				for pid = 0, 31 do
					if player.is_player_valid(pid) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) then
						if not globals.is_player_otr(pid) then
							otr_table[pid] = 0
							players[pid] = {pid, 0}
						end
						local count = 0
						for pid2 = 0, 31 do
							if globals.is_player_otr(pid2) then
								count = count + 1
							end
							system.yield(0)
						end
						if count > math.max(math.round(player.player_count() / 2.5), 3) then
							for pid2 = 0, 31 do
								otr_table[pid2] = utils.time_ms() + 1600000000
								system.yield(0)
							end
						end
						if globals.is_player_otr(pid) and players[pid][2] == 0 then
							players[pid] = {player.get_player_scid(pid), utils.time_ms() + 210000}
						elseif player.is_player_modder(pid, keks_custom_modder_flags[4][1]) or otr_table[pid] > utils.time_ms() then
							players[pid] = {pid, 0}
						end
						if players[pid][2] ~= 0 and globals.is_player_otr(pid) and pid ~= me and utils.time_ms() > players[pid][2] and players[pid][1] == player.get_player_scid(pid) and otr_table[pid] < utils.time_ms() then
							msg(player.get_player_name(pid).." was off the radar for too long.", 6, true)
							player.set_player_as_modder(pid, keks_custom_modder_flags[4][1])
						end
					else
						players[pid] = {pid, 0}
					end
					system.yield(0)
				end
			end
			setting["OTR detection"] = false
		end)}
		toggle[#toggle][2].threaded = true

	-- Vote kick protection
		toggle[#toggle + 1] = {"Kick any vote kickers", menu.add_feature("Kick any vote kickers", "toggle", u.protections.id, function(f)
			if f.on then
				setting["Kick any vote kickers"] = true	
			else
				setting["Kick any vote kickers"] = false
			end
		end)}

	-- Blacklist
		-- Add to blacklist function
			local function add_to_blacklist(name, ip, rid, reason, text)
				local e = {name, ip, rid, reason}
				if #e[1] < 6 then
					e[1] = math.random(-math.pow(2, 61), math.pow(2, 62))
				end
				if #tostring(e[2]) < 5 then
					e[2] = math.random(-math.pow(2, 61), math.pow(2, 62))
				end
				if #tostring(e[3]) < 5 then
					e[3] = math.random(-math.pow(2, 61), math.pow(2, 62))
				end
				if #reason == 0 then
					e[4] = "Manually added"
				end
				local B = log("scripts\\kek_menu_stuff\\kekMenuLogs\\Modder database.log", "|"..e[1].."|"..e[3].."| IP|"..e[2].."| tags: "..e[4], {"|"..e[3].."|", "|"..e[2].."|", "|"..e[1].."|"})
				if B then
					local A = B:match("(.*) tags:").." tags: "..e[4]
					modify_entry("scripts\\kek_menu_stuff\\kekMenuLogs\\Modder database.log", {B, A}, true, true)
					msg("Changed the reason this person was added to the blacklist.", 212, text)
					return 1
				else
					msg("Added to blacklist.", 210, text)
				end
			end

		-- Remove from blacklist function
			local function remove_from_blacklist(name, ip, rid, text)
				local e = {name, ip, rid}
				if #e[1] < 6 then
					e[1] = math.random(-math.pow(2, 61), math.pow(2, 62))
				end
				if #tostring(e[2]) < 5 then
					e[2] = math.random(-math.pow(2, 61), math.pow(2, 62))
				end
				if #tostring(e[3]) < 5 then
					e[3] = math.random(-math.pow(2, 61), math.pow(2, 62))
				end
				local result = modify_entry("scripts\\kek_menu_stuff\\kekMenuLogs\\Modder database.log", {"|"..e[3].."|", "|"..e[2].."|", "|"..e[1].."|"})
				if result == 1 then
					msg("Removed rid.", 210, text)
				elseif result == 2 then 
					msg("Couldn't find the RID.", 6, text)
				elseif result == 3 then
					msg("Blacklist file doesn't exist.", 6, text)
				end
			end

		-- Add to blacklist
			menu.add_player_feature("Add player / modify reason they were added", "action", u.player_blacklist_features, function(f, pid)
				if pid == player.player_id() then
					msg("You can't add yourself to the blacklist...", 212, true)
					return
				end
				local reason = get_input("Type in the why you're adding this person. Typing in nothing makes the reason: \"Manually added\".", "", 128, 0)
				add_to_blacklist(player.get_player_name(pid), player.get_player_ip(pid), player.get_player_scid(pid), reason, true)
				player.set_player_as_modder(pid, keks_custom_modder_flags[3][1])
			end)

		-- Add to blacklist by RID
			menu.add_feature("Add player / modify reason they were added", "action", u.blacklist.id, function()
				local scid = get_input("Type in social club ID, also known as: rid / scid.", "", 16, 3)
				if #tostring(scid) <= 4 or scid < 0 then
					msg("Rid is too short / invalid.", 6, true)
					return
				end
				local ip = ipv4_to_dec(get_input("Type in ip.", "", 128, 0))
				local reason = get_input("Type in the why you're adding this person. Typing in nothing makes the reason: \"Manually added\".", "", 128, 0)
				local name = get_input("Type in their name.", "", 128, 0)
				add_to_blacklist(name, ip, scid, reason, true)
				for pid = 0, 31 do
					if player.get_player_scid(pid) == scid then
						player.set_player_as_modder(pid, keks_custom_modder_flags[3][1])
					end
				end
			end)

		-- Remove RID from blacklist
			menu.add_feature("Remove player from blacklist", "action", u.blacklist.id, function()
				local scid = get_input("Type in social club ID, also known as: rid / scid.", "", 16, 3, "", true)
				remove_from_blacklist("", "", scid, true)
			end)

		-- Add session to blacklist
			menu.add_feature("Add session to blacklist", "action", u.blacklist.id, function()
				if player.player_count() == 1 then
					msg("Session is empty...", 6, true)
					return
				end
				local reason = get_input("Type in the why you're adding everyone. Typing in nothing makes the reason: \"Manually added\".", "", 128, 0, "Manually added")
				local me, count = player.player_id(), {0, 0}
				for pid = 0, 31 do
					if player.is_player_valid(pid) and pid ~= me then
						if add_to_blacklist(player.get_player_name(pid), player.get_player_ip(pid), player.get_player_scid(pid), reason) then
							count[2] = count[2] + 1
						else
							count[1] = count[1] + 1
						end
					end
				end
				msg("Added "..count[1].." players to the blacklist.\nChanged reasons for "..count[2].." people already in the blacklist.", 212, true)
			end)

		-- Remove session from blacklist
			menu.add_feature("Remove session from blacklist", "action", u.blacklist.id, function()
				local me = player.player_id()
				for pid = 0, 31 do
					if player.is_player_valid(pid) and me ~= pid then
						remove_from_blacklist(player.get_player_name(pid), player.get_player_ip(pid), player.get_player_scid(pid))
					end
				end
				msg("Removed session from the blacklist.", 212, true)
			end)

		-- Remove player from blacklist
			menu.add_player_feature("Remove player from blacklist", "action", u.player_blacklist_features, function(f, pid)
				remove_from_blacklist(player.get_player_name(pid), player.get_player_ip(pid), player.get_player_scid(pid), true)
			end)

-- Settings
	-- Init malicious basic toggles
		for i, k in pairs(general_settings) do
			if k[1]:find("#malicious") then
				toggle[#toggle + 1] = {k[1], menu.add_feature(k[1]:gsub("#malicious#", ""), "toggle", u.session_m_settings.id, function(f)
					if f.on then
						setting[k[1]] = true
					else
						setting[k[1]] = false
					end
				end)}
			end
		end

	-- Auto force host
		toggle[#toggle + 1] = {"Force host", menu.add_feature("Get host automatically", "toggle", u.session_m_settings.id, function(f)
			setting["Force host"] = true
			while f.on do
				temp.count = 1
				system.yield(0)
				while temp.count < 4 and player.get_host() and not network.network_is_host() and (not network.is_scid_friend(player.get_player_scid(player.get_host())) or not setting["Exclude friends from attacks #malicious#"]) and f.on do
					local pid = player.get_host()
					local RID = player.get_player_scid(pid)
					while player.get_player_scid(player.get_host()) == RID and f.on do
						kick(pid)
						system.yield(0)
						if player.is_player_valid(pid) and setting["Auto tag modders after sending kick #malicious#"] then
							player.set_player_as_modder(pid, keks_custom_modder_flags[2][1])
						end
						temp.count = temp.count + 1
						if temp.count == 4 and pid == player.get_host() and not network.network_is_host() then
							while RID == player.get_player_scid(player.get_host()) and f.on and player.is_player_valid(pid) do
								system.yield(2300)
							end
							break
						end
					end
					if network.network_is_host() then
						msg("Successfully obtained host.", 210, true)
						break
					end
					system.yield(0)
				end
				if not network.network_is_host() and (network.is_scid_friend(player.get_player_scid(player.get_host())) and setting["Exclude friends from attacks #malicious#"]) then
					msg("Force host:\nHost is your friend!, cancelled host attempt.", 212, true)
				elseif not player.get_host() then
					msg("Force host:\nHost is invalid, pausing host attempt until valid target.", 212, true)
				end
				while (network.network_is_host() or (network.is_scid_friend(player.get_player_scid(player.get_host())) and setting["Exclude friends from attacks #malicious#"])) and f.on do
					system.yield(2300)
				end
			end
			setting["Force host"] = false
		end)}
		toggle[#toggle][2].threaded = true

	-- Log modders
		toggle[#toggle + 1] = {"Log modders", menu.add_feature("Log modders with selected tags to blacklist", "toggle", u.what_to_do_with_tags.id, function(f)
			setting["Log modders"] = true
			while f.on do
				for pid = 0, 31 do
					system.yield(10)
					if player.is_player_valid(pid) and player.is_player_modder(pid, -1) and not player.is_player_modder(pid, keks_custom_modder_flags[3][1]) and player.get_player_modder_flags(pid) ~= keks_custom_modder_flags[2][1] and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) then
						local e = {player.get_player_scid(pid), player.get_player_ip(pid), player.get_player_name(pid)}
						if #tostring(e[1]) < 5 then
							e[1] = math.random(-math.pow(2, 61), math.pow(2, 62))
						end
						if #e[3] < 6 then
							e[3] = math.random(-math.pow(2, 61), math.pow(2, 62))
						end
						local flags = get_all_modder_flags(pid, o.modder_flag_setting_properties[1][1])
						if flags[2] > 0 then
							log("scripts\\kek_menu_stuff\\kekMenuLogs\\Modder database.log", "|"..e[3].."|"..e[1].."| IP|"..e[2].."| tags: "..flags[1], {"|"..e[3].."|", "|"..e[2].."|", "|"..e[1].."|"})
						end
					end
				end
				system.yield(600)
			end
		setting["Log modders"] = false
		end)}
		toggle[#toggle][2].threaded = true

	-- Auto kicker
		toggle[#toggle + 1] = {"Auto kicker", menu.add_feature("Auto Kick modders with selected tags", "toggle", u.what_to_do_with_tags.id, function(f)
			setting["Auto kicker"] = true
			while f.on do
				local me = player.player_id()
				for pid = 0, 31 do
					system.yield(10)
					if player.is_player_modder(pid, -1) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and pid ~= me then
						local flags, n = get_all_modder_flags(pid, o.modder_flag_setting_properties[2][1]), player.get_player_name(pid)
						if flags[2] > 0 and n then
							if setting["Log modders"] then
								system.yield(2200)
							end
							if player.is_player_modder(pid, -1) then
								msg("Kicking "..n..", flags:\n"..flags[1]:gsub(", ", "\n"), 212, setting["Auto kicker #notifications#"])
								kick(pid)
							end
						end
					end
				end
				system.yield(1200)
			end
			setting["Auto kicker"] = false
		end)}
		toggle[#toggle][2].threaded = true

	-- Auto unmark
		toggle[#toggle + 1] = {"Auto unmark", menu.add_feature("Auto unmark modders with selected tags", "toggle", u.what_to_do_with_tags.id, function(f)
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
		toggle[#toggle][2].threaded = true

-- Vehicle stuff
	-- Vehicle ram speed
		menu.add_feature("Ram vehicle speed", "action", u.vehicle_trolling.id, function() 
			setting["Ram speed"] = get_input("Type in ram speed", "", 4, 3, 120) 
		end)
		menu.add_player_feature("Ram vehicle speed", "action", u.pTroll, function() 
			setting["Ram speed"] = get_input("Type in ram speed", "", 4, 3, 120) 
		end)

	-- Ram everyone
		u.ram_e = menu.add_feature("Ram everyone", "action", u.vehicle_trolling.id, function()
			local me = player.player_id()
			local e = {}
			for pid = 0, 31 do
				if player.is_player_valid(pid) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and not player.is_player_god(pid) and me ~= pid then
					e[#e + 1] = spawn_and_push_a_vehicle_in_direction(pid, false, -8, vMap.GetHashFromModel(txt.kekText2))
				end
			end
			system.yield(350)
			clear_entities(e)
		end)
		u.ram_e.threaded = true

	-- Give nearby vehicles an effect
		u.nearby_type = menu.add_feature("Effect type, click me", "action_value_i", u.vehicle_friendly.id, function()
			msg("1: Max cars\n2: Give godmode\n3: Repair cars\n4: Godmode & max\n5: Chaos mode", 140, true)
		end)
		u.nearby_type.min_i, u.nearby_type.max_i, u.nearby_type.value_i, u.nearby_type.mod_i = 1, 5, 1, 1

		u.apply_effect = menu.add_feature("Apply effect to nearby vehicles", "toggle", u.vehicle_friendly.id, function(f)
			local F = 
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
			function(car, Ped, cars)
				if math.random(1, 250) == 1 then
					for i = 1, 20 do
						fire.add_explosion(entity.get_entity_coords(cars[math.random(1, #cars)]), 29, true, false, 0, vehicle.get_ped_in_vehicle_seat(car, -1))
					end
				end
				if math.random(1, 10) == 1 then
					for i = 1, 20 do
						fire.add_explosion(entity.get_entity_coords(car) + v3(math.random(-120, 120), math.random(-120, 120), 0), math.random(0, 73), true, false, 0, vehicle.get_ped_in_vehicle_seat(car, -1))
					end
				end
				if math.random(1, 800) == 1 then
					for i, k in pairs(cars) do
						max_car(k)
					end
				end
				if math.random(1, 20) == 1 then
					local PEd = vehicle.get_ped_in_vehicle_seat(car, -1)
					if get_control_of_entity(PEd) then
						set_combat_attributes(PEd, 584646201, true, true, false, false)
						local c = spawn_vehicle(vMap.GetHashFromModel("?"), entity.get_entity_coords(car), 0)
						modify_entity_godmode(c, true)
						ped.set_ped_into_vehicle(PEd, c, -1)
						clear_entities({car}, true)
						ai.task_vehicle_follow(PEd, car, Ped, 120, 262144, 0)
						gameplay.shoot_single_bullet_between_coords(player.get_player_coords(player.player_id()), entity.get_entity_coords(PEd), 1, 3220176749, Ped, false, true, 1000)
						return
					end
				end
				if math.random(1, 4) == 1 then
					if get_control_of_entity(car) then
						vehicle.set_vehicle_forward_speed(car, math.random(25, 200))
					end
				end
				if math.random(1, 4) == 1 then
					if get_control_of_entity(car) then
						for i = 1, math.random(5, 20) do
							local a = cars[math.random(1, #cars)]
							local pos = entity.get_entity_coords(a) + v3(math.random(-30, 30), math.random(-30, 30), math.random(-6, 18))
							entity.apply_force_to_entity(a, 3, pos.x, pos.y, pos.z, math.random(-50, 50), math.random(-50, 50), math.random(-12, 25), true, true)
						end
					end
				end
			end}
			local Ped = player.get_player_ped(player.player_id())
			local PID
			while f.on do
				local spectate = network.get_player_player_is_spectating(player.player_id())
				if spectate then
					PID = spectate
				else
					PID = player.player_id()
				end
				local cars = vehicle.get_all_vehicles()
				for i = 1, #cars do
					if get_distance_between(cars[i], player.get_player_ped(PID)) > 300 then
						cars[i] = nil
					end
				end
				local temp_cars = {}
				for i = 1, #cars do
					if cars[i] then
						temp_cars[#temp_cars + 1] = cars[i]
					end
				end
				local cars = temp_cars
				for i, k in pairs(cars) do
					if not entity.is_entity_dead(k) then
						F[u.nearby_type.value_i](k, Ped, cars)
						system.yield(math.random(30, 120))
					else
						clear_entities({k}, true)
					end
				end
				system.yield(10)
				if not f.on then
					clear_entities(cars, true)
				end
			end
			for pid = 0, 31 do
				modify_entity_godmode(player.get_player_vehicle(pid), false)
			end
		end)
		u.apply_effect.threaded = true

	-- Vehicle fly nearby cars
		u.vehicle_fly_nearby = menu.add_feature("Vehicle fly nearby vehicles", "toggle", u.vehicle_friendly.id, function(f)
			while f.on do
				local my_ped = player.get_player_ped(player.player_id())
				local keys = {"W", "S"}
				local speed = {setting["Vehicle fly speed"], -setting["Vehicle fly speed"]}
				local function get_vehicles()
					local cars = get_table_of_close_entity_type(1)
					local my_car = table.get_index_of_value(cars, player.get_player_vehicle(player.player_id()))
					if my_car then
						table.remove(cars, my_car)
					end
					table.sort(cars, function(a, b) return (get_distance_between(a, my_ped) < get_distance_between(b, my_ped)) end)
					local temp = {}
					for i = 1, 45 do
						if #cars >= i then
							temp[i] = cars[i]
						else
							break
						end
					end
					return temp
				end
				while f.on do
					cars = get_vehicles()
					for i = 1, #keys do
						local key = MenuKey()
						key:push_str(keys[i])
						for car_i = 1, #cars do
							local co = coroutine.create(function()
								network.request_control_of_entity(cars[car_i])
								entity.set_entity_max_speed(cars[car_i], 45000)
								vehicle.set_vehicle_forward_speed(cars[car_i], speed[i])
								entity.set_entity_rotation(cars[car_i], cam.get_gameplay_cam_rot())
							end)
							local key = MenuKey()
							key:push_str(keys[i])
							if key:is_down() then
								coroutine.resume(co)
							else
								entity.set_entity_velocity(cars[car_i], v3())
								entity.set_entity_rotation(cars[car_i], cam.get_gameplay_cam_rot())
							end	
						end	
						system.yield(0)
					end
					system.yield(0)
				end
				system.yield(0)
			end
		end)
		u.vehicle_fly_nearby.threaded = true

	-- Ram everyone loop
		u.ram_e_loop = menu.add_feature("Ram everyone", "toggle", u.vehicle_trolling.id, function(f)
			while f.on do
				local e, me = {}, player.player_id()
				local hash = vMap.GetHashFromModel(txt.kekText2)
				for pid = 0, 31 do
					if hash and player.is_player_valid(pid) and (not network.is_scid_friend(player.get_player_scid(pid)) or not setting["Exclude friends from attacks #malicious#"]) and not player.is_player_god(pid) and pid ~= me then
						e[#e + 1] = spawn_and_push_a_vehicle_in_direction(pid, false, -8, hash)
					end
					system.yield(0)
				end
				system.yield(350)
				clear_entities(e)
			end
		end)
		u.ram_e_loop.threaded = true

		u.vehicle_storm = menu.add_feature("Vehicle storm", "toggle", u.vehicle_trolling.id, function(f)
			local random = math.random
			while f.on do
				local cars = get_table_of_close_entity_type(1)
				local my_car = table.get_index_of_value(cars, player.get_player_vehicle(player.player_id()))
				if my_car then
					table.remove(cars, my_car)
				end
				if #cars > 40 then
					for i = 40, #cars do
						table.remove(cars, 1)
					end
				end
				for i =  1, #cars do
					network.request_control_of_entity(cars[i])
					entity.set_entity_max_speed(cars[i], 45000)
					entity.set_entity_rotation(cars[i], v3(random(0, 360), random(0, 360), random(0, 360)))
					vehicle.set_vehicle_forward_speed(cars[i], math.random(-1000, 1000))
					entity.apply_force_to_entity(cars[i], 3, random(-4, 4), random(-4, 4),random(-1, 5), 0, 0, 0, true, true)
					entity.set_entity_as_no_longer_needed(cars[i])
				end
				system.yield(0)
			end
		end)
		u.vehicle_storm.threaded = true

-- Initialize player history
	-- Functions for player history
		local function add_player_history_features(parent, rid, ip, name, date)
			menu.add_feature ("Copy rid to clipboard", "action", parent.id, function()
				utils.to_clipboard(rid)
				msg("Copied rid to clipboard.", 212, true)
			end)

			menu.add_feature ("Copy ip to clipboard", "action", parent.id, function()
				utils.to_clipboard(ip)
				msg("Copied ip to clipboard.", 212, true)
			end)

			menu.add_feature ("Add player / modify reason to blacklist", "action", parent.id, function()
				local reason = get_input("Type in the why you're adding this person. Typing in nothing makes the reason: \"Manually added\".", "", 128, 0)
				add_to_blacklist(name, ipv4_to_dec(ip), rid, reason, true)
				for pid = 0, 31 do
					if rid == player.get_player_scid(pid) then
						player.set_player_as_modder(pid, keks_custom_modder_flags[3][1])
						break
					end
				end
			end)

			menu.add_feature ("Remove player from blacklist", "action", parent.id, function()
				remove_from_blacklist(name, ipv4_to_dec(ip), rid, true)
			end)
		end

		local function get_date()
			local day_num = os.date("%d")
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
			return month, day, year, time
		end

		function temp.load_player_history()
			local month, day, year, time, type = get_date()
			for year_index, year in pairs(table.sort_numbers(utils.get_all_sub_directories_in_directory(o.kek_menu_stuff_path.."\\Player history"))) do
				u.year_parents[#u.year_parents + 1] = menu.add_feature(year, "parent", u.player_history.id)
				for month_index, month in pairs(table.sort_numbers(utils.get_all_sub_directories_in_directory(o.kek_menu_stuff_path.."\\Player history\\"..year))) do
					u.month_parents[#u.month_parents + 1] = menu.add_feature(month:gsub("_", " "), "parent", u.year_parents[#u.year_parents].id)
					for day_index, day in pairs(table.sort_numbers(utils.get_all_sub_directories_in_directory(o.kek_menu_stuff_path.."\\Player history\\"..year.."\\"..month))) do
						u.day_parents[#u.day_parents + 1] = menu.add_feature(day, "parent", u.month_parents[#u.month_parents].id)
						for file_index, current_file in pairs(table.sort_numbers(utils.get_all_files_in_directory(o.kek_menu_stuff_path.."\\Player history\\"..year.."\\"..month.."\\"..day, "log"))) do
							u.hour_parents[year..month..day..current_file:gsub(".log", "")] = menu.add_feature(current_file:gsub(".log", ""), "parent", u.day_parents[#u.day_parents].id)
							for line in string.get_lines_reversed("scripts\\kek_menu_stuff\\Player history\\"..year.."\\"..month.."\\"..day.."\\"..current_file):gmatch("([^\n]*)\n?") do
								random_wait(25)
								local name, rid, ip, date = line:match("|(.*)| "), line:match(" &(.*)&"), line:match(" ^(.*)^"), line:match(" !(.*)!")
								if name and rid and ip and date then
									u.player_properties[#u.player_properties + 1] = menu.add_feature(name.." ["..date.."]", "parent", u.hour_parents[year..month..day..current_file:gsub(".log", "")].id, function(f)
										local key = MenuKey()
										key:push_str("RSHIFT")
										if key:is_down() then
											do_key("RSHIFT", 100000)
											f.on = false
											modify_entry("scripts\\kek_menu_stuff\\Player history\\"..year.."\\"..month.."\\"..day.."\\"..current_file, {rid, ip})
											msg("Deleted player from history.", 212, true)
										end
									end)
									u.where_player_properties_are_located[#u.where_player_properties_are_located + 1] = "Player history\\"..year.."\\"..month.."\\"..day.."\\"..current_file
									add_player_history_features(u.player_properties[#u.player_properties], rid, ip, name, date)
									if #u.player_properties >= valuei["History limit"][2].value_i then
										kek_parent_index = #u.player_properties
										return
									end
								end
							end
						end
					end
				end
			end
			kek_parent_index = #u.player_properties
		end

	-- Player history
		menu.add_feature("Please click me for info", "action", u.player_history.id, function()
			msg("\"Num of people, click to type\", means how many people are shown in the player history.", 6, true)
			msg("The higher it is, the longer the freeze when reseting lua state becomes. Default value is safe.", 6, true)
		end)

		valuei["History limit"] = {"History limit", menu.add_feature("Num of people, click to type", "autoaction_value_i", u.player_history.id, function(f)
			local key = MenuKey()
			key:push_str("RETURN")
			if key:is_down() then
				local v = get_input("Type in history limit.", "", 7, 0, setting["History limit"])
				value_i_setup(f, v)
			end
			setting["History limit"] = f.value_i
		end)}
		valuei["History limit"][2].max_i, valuei["History limit"][2].min_i, valuei["History limit"][2].mod_i = 10000, 1, 1

		toggle[#toggle + 1] = {"Player history", menu.add_feature("Player history", "toggle", u.player_history.id, function(f)
			setting["Player history"] = true
			while not loaded_player_history do
				system.yield(100)
			end
			while f.on do
				local month, day, year, time = get_date()
				local date = os.date("%X")
				local file_path = o.kek_menu_stuff_path.."\\Player history\\"..year.."\\"..month.."\\"..day.."\\"..time..".log"
				if not utils.dir_exists(o.kek_menu_stuff_path.."Player history\\"..year) then
					utils.make_dir(o.kek_menu_stuff_path.."Player history\\"..year)
					u.year_parents[#u.year_parents + 1] = menu.add_feature(year, "parent", u.player_history.id)
				end
				if not utils.dir_exists(o.kek_menu_stuff_path.."Player history\\"..year.."\\"..month) then
					utils.make_dir(o.kek_menu_stuff_path.."Player history\\"..year.."\\"..month)
					u.month_parents[#u.month_parents + 1] = menu.add_feature(month:gsub("_", " "), "parent", u.year_parents[#u.year_parents].id)
				end
				if not utils.dir_exists(o.kek_menu_stuff_path.."Player history\\"..year.."\\"..month.."\\"..day) then
					utils.make_dir(o.kek_menu_stuff_path.."Player history\\"..year.."\\"..month.."\\"..day)
					u.day_parents[#u.day_parents + 1] = menu.add_feature(day, "parent", u.month_parents[#u.month_parents].id)
				end
				if not u.hour_parents[year..month..day..time] then
					u.hour_parents[year..month..day..time] = menu.add_feature(time, "parent", u.day_parents[#u.day_parents].id)
				end
				if not utils.file_exists(file_path) then
					local file = io.open(file_path, "w+")
					file:close()
				end
				for pid = 0, 31 do
					if player.is_player_valid(pid) and pid ~= player.player_id() then
						system.yield(0)
						local name, rid, ip = player.get_player_name(pid), player.get_player_scid(pid), get_ip_in_ipv4(pid)
						if name and rid and ip then
							local player_info = name.." ["..date.."]"
							local info_to_log = "|"..name.."| &"..rid.."& ^"..ip.."^".." !"..date.."!"
							local path = "scripts\\kek_menu_stuff\\Player history\\"..year.."\\"..month.."\\"..day
							local log_path = file_path:gsub(o.home, "")
							local no_duplicates_found = true
							for hour_index, hour in pairs(table.sort_numbers(utils.get_all_files_in_directory(o.home..path, "log"))) do
								if search_for_match_and_get_line(path.."\\"..hour, {ip, rid}, false, true) then
									no_duplicates_found = false
									break
								end
								system.yield(100)
							end
							if no_duplicates_found then
								system.yield(200)
								log(log_path, info_to_log)
								u.player_properties[#u.player_properties + 1] = menu.add_feature(player_info, "parent", u.hour_parents[year..month..day..time].id, function(f)
									local key = MenuKey()
									key:push_str("RSHIFT")
									if key:is_down() then
										do_key("RSHIFT", 100000)
										f.on = false
										modify_entry("scripts\\kek_menu_stuff\\Player history\\"..year.."\\"..month.."\\"..day.."\\"..time..".log", {rid, ip})
										msg("Deleted player from history.", 212, true)
									end
								end)
								u.where_player_properties_are_located[#u.where_player_properties_are_located + 1] = "Player history\\"..year.."\\"..month.."\\"..day.."\\"..time..".log"
								system.yield(0)
								add_player_history_features(u.player_properties[#u.player_properties], rid, ip, name, date)
							end
						end
					end
				end
				system.yield(2000)
			end
			setting["Player history"] = false
		end)}
		toggle[#toggle][2].threaded = true

	-- Clear searched players
		menu.add_feature("Clear searched player list", "action", u.player_history.id, function()
			for i, k in pairs(u.searched_players_in_history) do
				k.hidden = true
			end
		end)

	-- Search in player history
		menu.add_feature("Search", "action", u.player_history.id, function()
			local input = get_input("Type in what player you wanna search for.", "", 128, 0):lower()
			if #input > 0 then
				for i, k in pairs(u.player_properties) do
					if k.name:lower():find(input) then
						for line in string.get_lines_reversed("scripts\\kek_menu_stuff\\"..u.where_player_properties_are_located[i]):gmatch("([^\n]*)\n?") do
							if line:find(k.name:match("(.*) %[")) then
								local name, rid, ip, date = line:match("|(.*)| "), line:match(" &(.*)&"), line:match(" ^(.*)^"), line:match(" !(.*)!")
								u.searched_players_in_history[#u.searched_players_in_history + 1] = menu.add_feature(name.." ["..date.."]", "parent", u.player_history.id, function(f)
									local key = MenuKey()
									key:push_str("RSHIFT")
									if key:is_down() then
										do_key("RSHIFT", 100000)
										f.on = false
										modify_entry("scripts\\kek_menu_stuff\\Player history\\"..year.."\\"..month.."\\"..day.."\\"..current_file, {rid, ip})
										msg("Deleted player from history.", 212, true)
									end
								end)
								add_player_history_features(u.searched_players_in_history[#u.searched_players_in_history], rid, ip, name, date)
								return
							end
						end
					end
				end
				msg("Couldn't find player.", 6, true)
			else
				msg("Input too short.", 6, true)
			end			
		end)

-- Player malicious
	-- Script event crash
		menu.add_player_feature("Script event crash", "action", u.pMalicious, function(f, pid)
			script_event_crash(pid) 
			if setting["Auto tag modders after sending kick #malicious#"] then
				system.yield(500)
				player.set_player_as_modder(pid, keks_custom_modder_flags[2][1])
			end
		end)

	-- Brute force crash
		menu.add_player_feature("Brute force crash", "toggle", u.pMalicious, function(f, pid)
			if player.player_id() == pid then 
				f.on = false
				return
			end
			while f.on do
				system.yield(0)
				for i = 1, 100 * #kick_script_events / #crash_script_events do
					send_script_event(crash_script_events[math.random(1, #crash_script_events)], pid, get_full_arg_table())
					system.yield(0)
					if not f.on then
						break
					end
				end
				for i = 1, 100 do
					send_script_event(kick_script_events[math.random(1, #kick_script_events)], pid, get_full_arg_table())
					system.yield(0)
					if not f.on then
						break
					end
				end
			end
		end)

	-- Kick
		menu.add_player_feature("Kick", "action", u.pMalicious, function(f, pid) 
			kick(pid) 
			if player.is_player_valid(pid) and setting["Auto tag modders after sending kick #malicious#"] then
				system.yield(500)
				player.set_player_as_modder(pid, keks_custom_modder_flags[2][1])
			end
		end)

-- Session
	-- Vehicle blacklist
		menu.add_feature("Add entry", "action", u.vehicle_blacklist.id, function()
			local text = get_input("Type in what to add.", "", 128, 0)
			if #text == 0 then
				msg("Entry is too short.", 6, true)
				return
			end
			local hash, valid = vMap.GetHashFromModel(text)
			if valid then
				text = vMap.GetModelFromHash(hash)
				if not log("scripts\\kek_menu_stuff\\kekMenuData\\vehicle_blacklist.txt", "|"..hash.."| &"..text.."&", {hash}) then
					msg("Added "..text, 212, true)
					temp.update_vehicle_blacklist = true
				else
					msg("Entry is already in there!", 210, true)
				end
			else
				msg("Invalid entry.", 6, true)
			end
		end)

		menu.add_feature("Remove entry", "action", u.vehicle_blacklist.id, function()
			local text = get_input("Type in what to add.", "", 128, 0)
			if #text == 0 then
				msg("Entry is too short.", 6, true)
				return
			end
			local hash = vMap.GetHashFromModel(text)
			text = vMap.GetModelFromHash(hash)
			if modify_entry("scripts\\kek_menu_stuff\\kekMenuData\\vehicle_blacklist.txt", {text}) == 1 then
				msg("Removed "..text, 212, true)
				temp.update_vehicle_blacklist = true
			else 
				msg("Couldn't find entry.", 6, true)
			end
		end)

		menu.add_feature("Empty vehicle blacklist", "action", u.vehicle_blacklist.id, function()
			local file = io.open(o.kek_menu_stuff_path.."kekMenuData\\vehicle_blacklist.txt", "w+")
			file:close()
			msg("Emptied vehicle blacklist.", 140, true)
			temp.update_vehicle_blacklist = true
		end)

		toggle[#toggle + 1] = {"Vehicle blacklist apply only on specific players", menu.add_feature("Only on selected players", "toggle", u.vehicle_blacklist.id, function(f)
			if f.on then
				find_and_toggle_on_or_off_toggle("Vehicle blacklist")
				setting["Vehicle blacklist apply only on specific players"] = true
			else
				setting["Vehicle blacklist apply only on specific players"] = false
			end
		end)}

		toggle[#toggle + 1] = {"Vehicle blacklist", menu.add_feature("Vehicle blacklist", "toggle", u.vehicle_blacklist.id, function(f)
			setting["Vehicle blacklist"] = true
			local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\vehicle_blacklist.txt", "*a")
			while f.on do
				local me = player.player_id()
				if temp.update_vehicle_blacklist then
					str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\vehicle_blacklist.txt", "*a")
					temp.update_vehicle_blacklist = false
				end
				for pid =  0, 31 do
					system.yield(0)
					if me ~= pid and player.is_player_in_any_vehicle(pid) and (not setting["Vehicle blacklist apply only on specific players"] or table.get_index_of_value(vehicle_blacklist_selected_players, player.get_player_scid(pid))) then
						for line in str:gmatch("([^\n]*)\n?") do
							local their_car = player.get_player_vehicle(pid)
							local hash = entity.get_entity_model_hash(their_car)
							if line:match("|(.*)|") == tostring(hash) and their_car ~= player.get_player_vehicle(me) then
								disable_vehicle(pid)
								msg("Vehicle blacklist:\nKicked "..player.get_player_name(pid).." out of their "..vMap.GetNameFromHash(hash)..".", 140, setting["Vehicle blacklist #notifications#"])
								break
							end
							system.yield(0)
						end
					end
				end
				system.yield(500)
			end
			setting["Vehicle blacklist"] = false
		end)}
		toggle[#toggle][2].threaded = true

		menu.add_player_feature("Vehicle blacklist on this player", "toggle", u.pVehicles, function(f, pid)
			if f.on then
				vehicle_blacklist_selected_players[#vehicle_blacklist_selected_players + 1] = player.get_player_scid(pid)
				find_and_toggle_on_or_off_toggle("Vehicle blacklist")
				find_and_toggle_on_or_off_toggle("Vehicle blacklist apply only on specific players")
			else
				local is_in_table = table.get_index_of_value(vehicle_blacklist_selected_players, player.get_player_scid(pid))
				if is_in_table then
					table.remove(vehicle_blacklist_selected_players, is_in_table)
				end
			end
		end)

		menu.add_player_feature("Get model name of their car to clipboard", "action", u.pVehicles, function(f, pid)
			if player.is_player_in_any_vehicle(pid) then
				local model_name = vMap.GetModelFromHash(entity.get_entity_model_hash(player.get_player_vehicle(pid)))
				utils.to_clipboard(model_name)
				msg("Copied "..model_name.." to clipboard.", 212, true)
			else
				msg("Player isn't in a vehicle.", 6, true)
			end
		end)

	-- Spawn a vehicle for everyone
		menu.add_feature("What to ram people with", "action", u.vehicle_trolling.id, function()
			txt.kekText2 = get_input("Type in which car to spawn", "", 128, 0, setting["Default vehicle"]):lower() 
		end)

		u.spawn_everyone = menu.add_feature("Spawn vehicle for everyone", "action", u.vehicle_friendly.id, function()
			local me = player.player_id()
			local hash = vMap.GetHashFromModel(get_input("Type in which car to spawn", "", 128, 0, setting["Default vehicle"]):lower())
			for pid = 0, 31 do
				local p_pos = player.get_player_coords(pid)
				if player.is_player_valid(pid) and not player.is_player_in_any_vehicle(pid) and not player.is_player_god(pid) and pid ~= me and p_pos.z > -20 then
					local dir = player.get_player_heading(pid)
					local car = spawn_vehicle(hash, get_vector_relative_to_player(p_pos, dir, 5), dir, setting["Spawn #vehicle# maxed"], setting["Spawn #vehicle# in godmode"])
					decorator.decor_set_int(car, "MPBitset", 1 << 10)
				end
			end
			msg("Cars spawned.", 140, true)
		end)
		u.spawn_everyone.threaded = true

	-- Max everyone's car
		u.max_session_cars = menu.add_feature("Max everyone's vehicle", "action", u.vehicle_friendly.id, function()
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			for pid = 0, 31 do
				if is_target_viable(pid, 1) then
					system.yield(100)
					local car = player.get_player_vehicle(pid)
					for i = 1, 10 do
						max_car(car)
					end
				end
			end
			if player.is_player_in_any_vehicle(me) then
				entity.set_entity_coords_no_offset(player.get_player_vehicle(me), pos)
			else
				entity.set_entity_coords_no_offset(player.get_player_ped(me), pos)
			end
			msg("Maxed everyone's cars.", 212, true)
		end)	
		u.max_session_cars.threaded = true

	-- teleport session
		u.tp_session = menu.add_feature("Teleport session to current position", "toggle", u.session_malicious.id, function(f)
			if u.tp_wp_session.on then
				u.tp_wp_session.on = false
				system.yield(5000)
			end
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			local Ped = player.get_player_ped(me)
			while f.on do
				local pids = {}
				for pid = 0, 31 do
					pids[#pids + 1] = pid
				end
				for pid = 0, 31 do
					table.sort(pids, function(a, b) return (get_distance_between(player.get_player_ped(a), Ped) < get_distance_between(player.get_player_ped(b), Ped)) end)
					if f.on and me ~= pids[1] and (not network.is_scid_friend(player.get_player_scid(pids[1])) or not setting["Exclude friends from attacks #malicious#"]) and is_target_viable(pids[1], 13) then
						local time = utils.time_ms() + 1000
						local car = player.get_player_vehicle(pids[1])
						for i = 1, 8000 do
							teleport(car, pos + v3(0, 0, 3))
							if utils.time_ms() > time then
								break 
							end
							entity.set_entity_velocity(Ped, v3())
							system.yield(0)
						end
					end
					table.remove(pids, 1)
					system.yield(0)
				end
				system.yield(0)
			end
			if get_distance_between(player.get_player_coords(player.player_id()), pos, true) > 150 then
				if player.is_player_in_any_vehicle(me) then
					teleport(player.get_player_vehicle(me), pos)
				else
					teleport(Ped, pos) 
				end
			end
		end)
		u.tp_session.threaded = true

	-- teleport session to waypoint
		u.tp_wp_session = menu.add_feature("Teleport session to waypoint", "toggle", u.session_malicious.id, function(f)
			if ui.get_waypoint_coord().x > 14000 then
				msg("Please set a waypoint.", 6, true)
				f.on = false
				return
			end
			if u.tp_session.on then
				u.tp_session.on = false
				system.yield(5000)
			end
			u.disable_vehicles.on = false
			local me = player.player_id()
			local initial_pos = player.get_player_coords(me)
			local pos = ui.get_waypoint_coord()
			local pos = v3(pos.x, pos.y, 1000)
			local Ped = player.get_player_ped(me)
			while f.on do
				local pids = {}
				for pid = 0, 31 do
					pids[#pids + 1] = pid
				end
				for pid = 0, 31 do
					table.sort(pids, function(a, b) return (get_distance_between(player.get_player_ped(a), Ped) < get_distance_between(player.get_player_ped(b), Ped)) end)
					if f.on and me ~= pids[1] and (not network.is_scid_friend(player.get_player_scid(pids[1])) or not setting["Exclude friends from attacks #malicious#"]) and is_target_viable(pids[1], 13) then
						local time = utils.time_ms() + 1000
						local car = player.get_player_vehicle(pids[1])
						for i = 1, 8000 do
							teleport(car, pos + v3(0, 0, 3))
							local pos2 = player.get_player_coords(pids[1])
							temp.nothing, pos.z = gameplay.get_ground_z(pos2)
							if utils.time_ms() > time then
								break 
							end
							entity.set_entity_velocity(Ped, v3())
							system.yield(0)
						end
					end
					table.remove(pids, 1)
					system.yield(0)
				end
				system.yield(0)
			end
			if get_distance_between(player.get_player_coords(player.player_id()), initial_pos, true) > 150 then
				if player.is_player_in_any_vehicle(me) then
					teleport(player.get_player_vehicle(me), initial_pos)
				else
					teleport(Ped, initial_pos) 
				end
			end
		end)
		u.tp_wp_session.threaded = true

	-- Force host
		u.force_host = menu.add_feature("Get host", "toggle", u.session_malicious.id, function(f)
			if network.network_is_host() then 
				msg("You're already host!", 210, true)
				f.on = false
				return
			end
			local me = player.player_id()
			while f.on and not network.network_is_host() and (not network.is_scid_friend(player.get_player_scid(player.get_host())) or not setting["Exclude friends from attacks #malicious#"]) do
				local pid = player.get_host()
				kick(pid)
				if player.is_player_valid(pid) and setting["Auto tag modders after sending kick #malicious#"] then
					player.set_player_as_modder(pid, keks_custom_modder_flags[2][1])
				end
				if me ~= player.player_id() then
					f.on = false
					return
				end
				system.yield(0)
			end
			if (network.is_scid_friend(player.get_player_scid(player.get_host())) and setting["Exclude friends from attacks #malicious#"]) then
				msg("Cancelled host attempt, host is your friend!", 212, true)
			end
			if network.network_is_host() then
				msg("Obtained host.", 210, true)
			end
			f.on = false
		end)	
		u.force_host.threaded = true

	-- Kick session
		u.kick_session = menu.add_feature("Kick session", "action", u.session_malicious.id, function()
			local me = player.player_id()
			local pid = script.get_host_of_this_script()
			send_script_event(-922075519, pid, {pid, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1})
			local pos = player.get_player_coords(pid)
			send_script_event(-1975590661, pid, {pid, math.round(pos.x), math.round(pos.y), math.round(pos.z), 0, 0, 1000, 1})
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
		u.kick_session.threaded = true

		u.crash_session = menu.add_feature("Crash session", "action", u.session_malicious.id, function()
			local pid = script.get_host_of_this_script()
			local pos = player.get_player_coords(pid)
			send_script_event(-1975590661, pid, {pid, math.round(pos.x), math.round(pos.y), math.round(pos.z), 0, 0, 2147483647, 1})
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					script_event_crash(pid)
					if u.brute_force_crash.feats[pid] then
						u.brute_force_crash.feats[pid].on = true
					end
				end
				system.yield(0)
			end
		end)
		u.crash_session.threaded = true

	-- Session scripts
		menu.add_feature("Give session bounty", "action", u.session_script_stuff.id, function()
			for pid = 0, 31 do
				set_bounty(pid, true)
				system.yield(0)
			end
		end)

		toggle[#toggle + 1] = {"Never wanted", menu.add_feature("Never wanted", "toggle", u.session_script_stuff.id, function(f)
			setting["Never wanted"] = true
			while f.on do
				for pid = 0, 31 do
					if player.get_player_wanted_level(pid) > 0 then
						send_script_event(393068387, pid, {pid, script.get_global_i(1630317 + (1 + (595 * pid)) + 506)})
					end
					system.yield(0)
				end
				system.yield(1000)
			end
			setting["Never wanted"] = false
		end)}
		toggle[#toggle][2].threaded = true

		toggle[#toggle + 1] = {"Off-the-radar", menu.add_feature("Off-the-radar", "toggle", u.session_script_stuff.id, function(f)
			setting["Off-the-radar"] = true
			for pid = 0, 31 do
				otr_table[pid] = utils.time_ms() + 1547483647
			end
			while f.on do
				for pid = 0, 31 do
					if not globals.is_player_otr(pid) then
						send_script_event(575518757, pid, {pid, utils.time() - 60, utils.time(), 1, 1, script.get_global_i(1630317 + (1 + (595 * pid)) + 506)})
					end
					system.yield(0)
				end
				system.yield(200)
			end
			setting["Off-the-radar"] = false
		end)}
		toggle[#toggle][2].threaded = true

		toggle[#toggle + 1] = {"Reapply bounty automatically", menu.add_feature("Reapply bounty automatically", "toggle", u.session_script_stuff.id, function(f)
			setting["Reapply bounty automatically"] = true
			while f.on do
				for pid = 0, 31 do
					local Ped = player.get_player_ped(pid)
					if entity.is_entity_dead(Ped) then
						set_bounty(pid, true)
					end
					system.yield(0)
				end
				system.yield(1000)
			end
			setting["Reapply bounty automatically"] = false
		end)}
		toggle[#toggle][2].threaded = true

		toggle[#toggle + 1] = {"10k CEO loop", menu.add_feature("Give 10k CEO money to everyone in your CEO", "toggle", u.session_script_stuff.id, function(f)
			setting["10k CEO loop"] = true
			while f.on do
				for pid = 0, 31 do
					send_script_event(-2029779863, pid, {pid, 10000, -1292453789, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
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
		toggle[#toggle][2].threaded = true

		toggle[#toggle + 1] = {"Block passive", menu.add_feature("Block passive mode", "toggle", u.session_script_stuff.id, function(f, pid)
			setting["Block passive"] = true
			while f.on do
				for pid = 0, 31 do
					send_script_event(-909357184, pid, {pid, 1}, true)
					system.yield(0)
				end
				system.yield(4000)
			end
			for pid = 0, 31 do
				send_script_event(-909357184, pid, {pid, 0}, true)
			end
			setting["Block passive"] = false
		end)}
		toggle[#toggle][2].threaded = true

		u.disable_vehicles = menu.add_feature("Disable vehicles", "toggle", u.session_script_stuff.id, function(f)
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
		u.disable_vehicles.threaded = true

		menu.add_feature("Send to random mission", "action", u.session_script_stuff.id, function(f)
			for pid = 0, 31 do
				if math.random(1, 8) == 1 then
					send_script_event(-545396442, pid, {0}, true)
				else
					send_script_event(-545396442, pid, {0, math.random(1, 7)}, true)
				end
			end
		end)

		menu.add_feature("Perico island", "toggle", u.session_script_stuff.id, function(f)
			if f.on then
				for pid = 0, 31 do
					send_script_event(1300962917, pid, {pid, 1300962917, 0, 0}, true)
				end
			else
				for pid = 0, 31 do
					send_script_event(-171207973, pid, {pid, pid, 1, 0, 1, 1, 1, 1}, true)
				end
			end
		end)

		menu.add_feature("Apartment invites", "toggle", u.session_script_stuff.id, function(f)
			while f.on do
				for pid = 0, 31 do
					send_script_event(-171207973, pid, {pid, pid, 1, 0, math.random(0, 114), 1, 1, 1}, true)
					system.yield(0)
				end
				system.yield(5000)
			end
		end)

		menu.add_feature("Ban CEO", "action", u.session_script_stuff.id, function()
			for pid = 0, 31 do
				send_script_event(-738295409, pid, {0, 1, 5, 0}, true)
			end
		end)

		menu.add_feature("Dismiss CEO", "action", u.session_script_stuff.id, function()
			for pid = 0, 31 do
				send_script_event(-1648921703, pid, {0, 1, 5}, true)
			end
		end)

		menu.add_feature("Terminate CEO", "action", u.session_script_stuff.id, function()
			for pid = 0, 31 do
				send_script_event(-1648921703, pid, {1, 1, 6}, true)
			end
		end)

		u.error_session_loop = menu.add_feature("Transaction error", "toggle", u.session_script_stuff.id, function(f)
			while f.on do
				for pid = 0, 31 do
					send_script_event(1302185744, pid, {pid, 2147483647, 1, 1, script.get_global_i(1630317 + (1 + (pid * 595) + 506)), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10), 1}, true)
					system.yield(0)
				end
				system.yield(1000)
			end
		end)
		u.error_session_loop.threaded = true

	-- Custom chat judger
		-- Chat judge settings
			menu.add_player_feature("Chat judge this player", "toggle", u.player_chat_features, function(f, pid)
				find_and_toggle_on_or_off_toggle("Custom chat judger")
				find_and_toggle_on_or_off_toggle("Judge selected only")
				if f.on then
					o.selected_players[pid] = player.get_player_scid(pid)
				else
					o.selected_players[pid] = nil
				end
			end)

			menu.add_feature("Add entry", "action", u.custom_chat_judger.id, function()
				local text = get_input("Type in what to add.", "", 128, 0)
				if #text == 0 then
					msg("Entry is too short.", 6, true)
					return
				end
				if not log("scripts\\kek_menu_stuff\\kekMenuData\\custom_chat_judge_data.txt", text, {text}, true) then
					msg("Added "..text, 212, true)
					temp.update_chat_judge = true
				else
					msg("Entry is already in there!", 210, true)
				end
			end)

			menu.add_feature("Remove entry", "action", u.custom_chat_judger.id, function()
				local text = get_input("Type in what to remove.", "", 128, 0)
				if #text == 0 then
					msg("Entry is too short.", 6, true)
					return
				end
				if modify_entry("scripts\\kek_menu_stuff\\kekMenuData\\custom_chat_judge_data.txt", {text}, true) == 1 then
					msg("Removed "..text, 212, true)
					temp.update_chat_judge = true
				else 
					msg("Couldn't find entry.", 6, true)
				end
			end)

			menu.add_feature("Empty chat judge file", "action", u.custom_chat_judger.id, function()
				local file = io.open(o.kek_menu_stuff_path.."kekMenuData\\custom_chat_judge_data.txt", "w+")
				file:close()
				msg("Emptied.", 140, true)
				temp.update_chat_judge = true
			end)

			valuei["Chat judge reaction"] = {"Chat judge reaction", menu.add_feature("What reaction, click me", "autoaction_value_i", u.custom_chat_judger.id, function(f)
				setting["Chat judge reaction"] = f.value_i
				local key = MenuKey()
				key:push_str("RETURN")
				if key:is_down() then
					msg("0 = random(not kick / crash)\n1 = Set bounty\n2 = Ram player\n3 = Kick from vehicle", 140, true)
					msg("4 = Kick player\n5 = Crash player", 140, true)
				end
			end)}
			valuei["Chat judge reaction"][2].min_i, valuei["Chat judge reaction"][2].max_i, valuei["Chat judge reaction"][2].mod_i = 0, 5, 1

		-- Chat judge
			toggle[#toggle + 1] = {"Custom chat judger", menu.add_feature("Custom chat judge", "toggle", u.custom_chat_judger.id, function(f)
				if f.on then
					setting["Custom chat judger"] = true
					local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\custom_chat_judge_data.txt", "*a")
					u.chat_judge_listener = event.add_event_listener("chat", function(p)
						if p.player == player.player_id() or (network.is_scid_friend(player.get_player_scid(p.player)) and setting["Exclude friends from attacks #malicious#"]) or (setting["Judge selected only"] and o.selected_players[p.player] ~= player.get_player_scid(p.player)) then
							return 
						end
						if temp.update_chat_judge then
							str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\custom_chat_judge_data.txt", "*a")
							temp.update_chat_judge = false
						end
						for line in str:gmatch("([^\n]*)\n?") do
							if p.body:lower():find(line:lower()) then
								local chat_type = valuei["Chat judge reaction"][2].value_i
								if chat_type == 0 then
									chat_type = math.random(1, 3)
								end
								reactions(p.player, chat_type)
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

			toggle[#toggle + 1] = {"Judge selected only", menu.add_feature("Judge selected players only", "toggle", u.custom_chat_judger.id, function(f)
				find_and_toggle_on_or_off_toggle("Custom chat judger")
				if f.on then
					setting["Judge selected only"] = true
				else
					setting["Judge selected only"] = false
				end
			end)}

	-- Chat spammer
		valuei["Spam speed"] = {"Spam speed", menu.add_feature("Spam speed, click to type", "autoaction_value_i", u.chat_spammer.id, function(f)
			local key = MenuKey()
			key:push_str("RETURN")
			if key:is_down() then
				local v = get_input("Type in spam speed.", "", 7, 0, setting["Spam speed"])
				value_i_setup(f, v)
			end
			setting["Spam speed"] = f.value_i
		end)}
		valuei["Spam speed"][2].max_i, valuei["Spam speed"][2].min_i, valuei["Spam speed"][2].mod_i = 1000000, 30, 20

		u.text_spam_size = menu.add_feature("Text to spam, type it in", "action_value_i", u.chat_spammer.id, function(f)
			local text = {""}
			for i = 1, f.value_i do
				local a, b, c = get_input("Type in part "..i.." of the text. All of these will be merged into one text.", "", 128, 0)
				text[1] = text[1].." "..a
				if c == 2 then
					msg("Cancelled.", 212, true)
					return
				end
			end
			setting["Spam text"] = text[1]
		end)
		u.text_spam_size.max_i, u.text_spam_size.min_i, u.text_spam_size.value_i, u.text_spam_size.mod_i = 30, 1, 1, 1

		u.from_clipboard = menu.add_feature("Grab text from clipboard (what u copied)", "toggle", u.chat_spammer.id, function(f)
			if f.on then
				u.text_from_file.on = false
				u.from_clipboard_and_line.on = false
				u.random_text_from_file.on = false
			end
		end)

		u.from_clipboard_and_line = menu.add_feature("Grab text from clipboard and send each line", "toggle", u.chat_spammer.id, function(f)
			if f.on then
				u.text_from_file.on = false
				u.from_clipboard.on = false
				u.random_text_from_file.on = false
			end
		end)

		u.text_from_file = menu.add_feature("Grab text from text file", "toggle", u.chat_spammer.id, function(f)
			if f.on then
				u.from_clipboard.on = false
				u.from_clipboard_and_line.on = false
			else
				u.random_text_from_file.on = false
			end
		end)

		u.random_text_from_file = menu.add_feature("Random text from file", "toggle", u.chat_spammer.id, function(f)
			if f.on then
				u.text_from_file.on = true
				u.from_clipboard.on = false
				u.from_clipboard_and_line.on = false
			end
		end)

		u.f_chat_spammer = menu.add_feature("Chat spammer", "toggle", u.chat_spammer.id, function(f)
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
			local count = {1, 1}
			local nums = {1, 1}
			for line in str:gmatch("([^\n]*)\n?") do
				count[1] = count[1] + 1
				random_wait(75)
			end
			while f.on do
				if u.text_from_file.on then
					count[2] = 1
					nums[1] = math.random(1, count[1])
					for line in str:gmatch("([^\n]*)\n?") do
						if not f.on or not u.text_from_file.on then
							break
						end
						if u.random_text_from_file.on then
							if nums[1] == count[2] then
								network.send_chat_message(line, false)
								WAIT()
								break
							end
							nums[2] = nums[2] + 1
						else 
							network.send_chat_message(line, false)
							WAIT()
						end
						random_wait(25)
						count[2] = count[2] + 1
					end
				else
					if u.from_clipboard.on and utils.from_clipboard() then
						setting["Spam text"] = utils.from_clipboard()
					end
					if u.from_clipboard_and_line.on then
						local str = utils.from_clipboard() 
						for line in str:gmatch("([^\n]*)\n?") do
							network.send_chat_message(line, false)
							WAIT()
							if not f.on or not u.from_clipboard_and_line.on then
								break
							end
						end
					else
						network.send_chat_message(setting["Spam text"], false)
						WAIT()
					end
				end
				system.yield(0)
			end
		end)
		u.f_chat_spammer.threaded = true

	-- Echo chat
		valuei["Echo delay"] = {"Echo delay", menu.add_feature("Echo delay, click to type", "autoaction_value_i", u.chat_spammer.id, function(f)
			local key = MenuKey()
			key:push_str("RETURN")
			if key:is_down() then
				local v = get_input("Type in echo delay.", "", 7, 0, setting["Echo delay"])
				value_i_setup(f, v)
			end
			setting["Echo delay"] = f.value_i	
		end)}
		valuei["Echo delay"][2].max_i, valuei["Echo delay"][2].min_i, valuei["Echo delay"][2].mod_i = 1000000, 0, 25

		toggle[#toggle + 1] = {"Echo chat", menu.add_feature("Echo chat", "toggle", u.chat_spammer.id, function(f)
			if f.on then
				setting["Echo chat"] = true
				u.echo_chat = event.add_event_listener("chat", function(chat)
					local rid = player.get_player_scid(chat.player)
					if player.player_id() ~= chat.player and (not setting["Individual echo"] or (setting["Individual echo"] and people_to_echo_chat[chat.player] == rid)) and (not setting["Exclude friends from attacks #malicious#"] or not network.is_scid_friend(rid)) then
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

		toggle[#toggle + 1] = {"Individual echo", menu.add_feature("Echo selected players only", "toggle", u.chat_spammer.id, function(f)
			find_and_toggle_on_or_off_toggle("Echo chat")
			if f.on then
				setting["Individual echo"] = true
			else
				setting["Individual echo"] = false
			end
		end)}

		menu.add_player_feature("Echo this player", "toggle", u.player_chat_features, function(f, pid)
			find_and_toggle_on_or_off_toggle("Echo chat")
			find_and_toggle_on_or_off_toggle("Individual echo")
			if f.on then
				people_to_echo_chat[pid] = player.get_player_scid(pid)
			else
				people_to_echo_chat[pid] = nil
			end
		end)

	-- Chat bot
		menu.add_feature("Add entry to chat bot", "action", u.chat_bot.id, function()
			local what_to_react_to = get_input("Type in what the bot will react to.", "", 128, 0)
			local reaction = get_input("Type in what the bot will say to what you previously typed in.", "", 128, 0)
			if #reaction > 0 and #what_to_react_to > 0 then
				if not log("\\scripts\\kek_menu_stuff\\kekMenuData\\Kek's chat bot.txt", "|"..what_to_react_to.."|&"..reaction.."&", {"|"..what_to_react_to.."|"}) then
					msg("Successfully added entry.", 210, true)
					temp.update_chat_bot = true
				else
					msg("Entry was already added.", 212, true)
				end
			else
				msg("Input too short.", 6, true)
			end
		end)

		menu.add_feature("Remove entry from chat bot", "action", u.chat_bot.id, function()
			local what_to_remove = get_input("Type in what the text the bot reacts to in the entry you wish to remove.", "", 128, 0)
			if modify_entry("scripts\\kek_menu_stuff\\kekMenuData\\Kek's chat bot.txt", {"|"..what_to_remove.."|"}) == 1 then
				msg("Removed entry.", 212, true)
				temp.update_chat_bot = true
			else 
				msg("Couldn't find entry.", 6, true)
			end
		end)

		menu.add_feature("Remove all entries", "action", u.chat_bot.id, function()
			local file = io.open(o.kek_menu_stuff_path.."kekMenuData\\Kek's chat bot.txt", "w+")
			file:flush()
			file:close()
			msg("Removed all entries.", 212, true)
			temp.update_chat_bot = true
		end)

		valuei["chat bot delay"] = {"chat bot delay", menu.add_feature("Answer delay, click to type in", "autoaction_value_i", u.chat_bot.id, function(f)
			local key = MenuKey()
			key:push_str("RETURN")
			if key:is_down() then
				local v = get_input("Type in answer delay.", "", 7, 0, setting["chat bot delay"])
				value_i_setup(f, v)
			end
			setting["chat bot delay"] = f.value_i
		end)}
		valuei["chat bot delay"][2].max_i, valuei["chat bot delay"][2].min_i, valuei["chat bot delay"][2].mod_i = 1000000, 0, 20

		toggle[#toggle + 1] = {"chat bot", menu.add_feature("Chat bot", "toggle", u.chat_bot.id, function(f)
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
						for line in str:gmatch("([^\n]*)\n?") do
							if info.body == line:match("|(.*)|") then
								network.send_chat_message(line:match("&(.*)&"), false)
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
		u.disconnect = menu.add_feature("Disconnect from session", "action", u.session_malicious.id, function()
			if network.network_is_host() then
				network.network_session_kick_player(player.player_id())
				return
			end
			local str = ""
			for i = 1, 1000 do
				str = str.."\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\nLMAO\n"
				random_wait(250)
			end
			local time = utils.time_ms() + 6000
			while time > utils.time_ms() do
				network.send_chat_message(str, false)
				if player.player_count() == 0 then
					break
				end
				system.yield(0)
			end
			system.yield(2000)
			if player.player_count() > 0 then
				msg("Disconnect attempt failed. Attempting method 2...", 6, true)
				msg("The game will freeze, just wait 10 seconds.", 212, true)
				system.yield(2000)
				local time = utils.time_ms() + 8000
				while time > utils.time_ms() do
					local a = math.random()
				end
			end
		end)

-- Player peaceful
	-- Spawn a ped
		menu.add_player_feature("Type in ped model", "action", u.p_peds, function()
			txt.ped_text = get_input("Type in name of the ped you want to spawn.", "", 128, 0, setting["Default pedestrian"])
		end)

		menu.add_player_feature("Spawn a ped", "action", u.p_peds, function(f, pid)
			local ped = spawn_pedestrian(27, pMap.get_animal_or_ped(txt.ped_text), get_vector_relative_to_player(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0)
		end)

	-- Max my car
		u.max_my_car = menu.add_feature("Max car", "action", u.vehicle_self.id, function()
			local me = player.player_id()
			if player.is_player_in_any_vehicle(me) then
				local car = ped.get_vehicle_ped_is_using(player.get_player_ped(me))
				max_car(car)
			end
		end)
		u.max_my_car.threaded = true

	-- Max my car loop
		u.max_loop = menu.add_feature("Max car loop", "toggle", u.vehicle_self.id, function(f)
			while f.on and player.is_player_in_any_vehicle(player.player_id()) do
				max_car(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
				system.yield(500)
			end
			f.on = false
		end)
		u.max_loop.threaded = true

	-- Give car godmode
		u.give_car_god = menu.add_player_feature("Car godmode", "toggle", u.pVehicles, function(f, pid)
			local me = player.player_id()
			local Ped, myPed = player.get_player_ped(pid), player.get_player_ped(me)
			if player.is_player_in_any_vehicle(pid) and (get_distance_between(myPed, Ped) < 1000 or network.get_entity_player_is_spectating(me) == Ped) then
				local car = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
				while player.is_player_in_any_vehicle(pid) and (get_distance_between(myPed, Ped) < 1000 or network.get_entity_player_is_spectating(me) == Ped) and f.on do
					modify_entity_godmode(car, true)
					system.yield(0)
				end
				modify_entity_godmode(car, false)
			elseif not player.is_player_in_any_vehicle(pid) then
				msg(player.get_player_name(pid).." is not in a vehicle.", 6, true)
			elseif get_distance_between(myPed, Ped) > 1000 then
				msg(player.get_player_name(pid).." is too far away.", 6, true)
			end
			f.on = false
		end)
		u.give_car_god.threaded = true

	-- Copy their car 
		menu.add_player_feature("Copy player's car", "action", u.pVehicles, function(f, pid)
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			if player.get_player_vehicle(pid) == 0 and not is_target_viable(pid, 10, true) then
				msg("No vehicle to copy.", 6, true)
				if player.is_player_in_any_vehicle(me) then
					entity.set_entity_coords_no_offset(player.get_player_vehicle(me), pos)
				else
					entity.set_entity_coords_no_offset(player.get_player_ped(me), pos)
				end
				return
			end
			if player.is_player_in_any_vehicle(me) then
				temp.car2 = player.get_player_vehicle(me)
			end
			local mods, veh, dir = {}, player.get_player_vehicle(pid), player.get_player_heading(me)
			local hash = entity.get_entity_model_hash(veh)
			local car = spawn_vehicle(hash, get_vector_relative_to_player(player.get_player_coords(me), dir, 5), dir)
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
			local e = vehicle.get_vehicle_neon_lights_color(veh)
			vehicle.set_convertible_roof(car, vehicle.get_convertible_roof_state(veh))
			vehicle.set_vehicle_neon_light_enabled(car, e, vehicle.is_vehicle_neon_light_enabled(veh, e, true))
			vehicle.set_vehicle_neon_lights_color(car, e)
			local e = vehicle.get_vehicle_livery(veh)
			vehicle.set_vehicle_livery(car, e)
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
				ped.set_ped_into_vehicle(player.get_player_ped(me), car, -1)
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
			if setting["Delete old #vehicle#"] then
				if temp.car2 then
					clear_entities({temp.car2})
				end
			end
		end)

	-- Max their car
		u.max_p_car = menu.add_player_feature("Max car", "action", u.pVehicles, function(f, pid)
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			local a, b, c
			if player.get_player_vehicle(pid) == 0 then
				a, b = is_target_viable(pid, 10, true)
				c = true
			else
				a = true
				b = player.get_player_vehicle(pid)
			end
			if a then
				if max_car(b) then
					msg("Maxed "..player.get_player_name(pid).."'s vehicle.", 212, true)
				else
					msg("Failed to get control of their car.", 6, true)
				end
			else
				if player.is_player_in_any_vehicle(me) then
					entity.set_entity_coords_no_offset(player.get_player_vehicle(me), pos)
				else
					entity.set_entity_coords_no_offset(player.get_player_ped(me), pos)
				end
				msg(player.get_player_name(pid).." is not in a vehicle.", 6, true)
				return
			end
			if c then
				if player.is_player_in_any_vehicle(me) then
					entity.set_entity_coords_no_offset(player.get_player_vehicle(me), pos)
				else
					entity.set_entity_coords_no_offset(player.get_player_ped(me), pos)
				end
			end
		end)	
		u.max_p_car.threaded = true

	-- Vehicle fly their car
		u.control_their_car = menu.add_player_feature("Vehicle fly player", "toggle", u.pVehicles, function(f, pid)
			local get, control = player.get_player_vehicle, get_control_of_entity
			local get_key, set_speed = MenuKey, vehicle.set_vehicle_forward_speed
			local set_rot, cam_rot = entity.set_entity_rotation, cam.get_gameplay_cam_rot
			local request = network.request_control_of_entity
			local car
			while f.on do
				local car = get(pid)
				local keys = {"W", "S"}
				for i = 1, #keys do
					request(car)
					entity.set_entity_max_speed(car, 45000)
					local key = get_key()
					key:push_str(keys[i])
					while key:is_down() do
						local speed = {setting["Vehicle fly speed"], -setting["Vehicle fly speed"]}
						request(car)
						set_speed(car, speed[i])
						set_rot(car, cam_rot())
						system.yield(0)
					end
				end
				if f.on then
					entity.set_entity_velocity(car, v3())
					set_rot(car, cam_rot())
				end
				system.yield(0)
			end
		end)
		u.control_their_car.threaded = true

		u.spastic_car = menu.add_player_feature("Spastic car", "toggle", u.pVehicles, function(f, pid)
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
		u.spastic_car.threaded = true

	-- Max their car loop
		u.max_p_car_loop = menu.add_player_feature("Max car loop", "toggle", u.pVehicles, function(f, pid)
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			Ped, my_ped = player.get_player_ped(pid), player.get_player_ped(player.player_id()) 
			while f.on do
				max_car(player.get_player_vehicle(pid))
				system.yield(500)
			end
			f.on = false
		end)	
		u.max_p_car_loop.threaded = true

	-- Repair their car loop
		u.repair_p_car_loop = menu.add_player_feature("Repair car loop", "toggle", u.pVehicles, function(f, pid)
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
		u.repair_p_car_loop.threaded = true

	-- Spawn a car
		menu.add_player_feature("What vehicle to spawn", "action", u.pVehicles, function()
			txt.kekText2 = get_input("Type in which car to spawn", "", 128, 0, setting["Default vehicle"]):lower() 
			end)

		menu.add_player_feature("Spawn vehicle", "action", u.pVehicles, function(f, pid)
			local dir = player.get_player_heading(pid)
			local car = spawn_vehicle(vMap.GetHashFromModel(txt.kekText2), get_vector_relative_to_player(player.get_player_coords(pid), dir, 5), dir, setting["Spawn #vehicle# maxed"], setting["Spawn #vehicle# in godmode"])
			decorator.decor_set_int(car, "MPBitset", 1 << 10)
		end)

		for i, k in pairs(general_settings) do
			if k[1]:find("#vehicle#") then
				toggle[#toggle + 1] = {k[1], menu.add_feature(k[1]:gsub("#", ""), "toggle", u.vehicleSettings.id, function(f)
					if f.on then
						setting[k[1]] = true
					else
						setting[k[1]] = false
					end
				end)}
			end
		end

		menu.add_feature("Change default vehicle", "action", u.vehicleSettings.id, function(f)
			local e = setting["Default vehicle"]
			setting["Default vehicle"] = get_input("Type in the vehicle you want to be default.", "", 128, 0, e)
			temp.nothing, temp.is_valid = vMap.GetHashFromModel(setting["Default vehicle"])
			if temp.is_valid then
				msg("Changed default vehicle.", 212, true)
				txt.kekText2 = setting["Default vehicle"]
			else
				setting["Default vehicle"] = e
				msg("Invalid input. Default value remains the same.", 6, true)
			end
		end)
		txt.kekText2 = setting["Default vehicle"]

		menu.add_feature("Change backplate text", "action", u.vehicleSettings.id, function(f)
			local e = setting["Plate vehicle text"]
			setting["Plate vehicle text"], temp.is_valid = get_input("Type in the text you want displayed on the backplate of your cars after maxing them.", "", 128, 0, setting["Plate vehicle text"])
			if not temp.is_valid then
				setting["Plate vehicle text"] = e
				msg("Invalid input. Plate text remains the same.", 6, true)
			else
				msg("Changed default plate text.", 212, true)
			end
		end)

		menu.add_feature("What vehicle to spawn", "action", u.vehicle_self.id, function()
			txt.kekText2 = get_input("Type in which car to spawn", "", 128, 0, setting["Default vehicle"]):lower() 
			end)

		menu.add_feature("Spawn vehicle", "action", u.vehicle_self.id, function()
			spawn_car()
		end)	

	-- Vehicle fly
		valuei["Vehicle fly speed"] = {"Vehicle fly speed", menu.add_feature("Vehicle fly speed, click to type", "autoaction_value_i", u.vehicle_self.id, function(f)
			local key = MenuKey()
			key:push_str("RETURN")
			if key:is_down() then
				local v = get_input("Type in vehicle speed.", "", 5, 0, setting["Vehicle fly speed"])
				value_i_setup(f, v)
			end
			setting["Vehicle fly speed"] = f.value_i
		end)}
		valuei["Vehicle fly speed"][2].min_i, valuei["Vehicle fly speed"][2].max_i, valuei["Vehicle fly speed"][2].mod_i = 0, 45000, 20

		u.vehicle_fly = menu.add_feature("Vehicle fly", "toggle", u.vehicle_self.id, function(f)
			while f.on do
				local me = player.player_id()
				local binds = {"W", "S"}
				local car = player.get_player_vehicle(me)
				if player.is_player_in_any_vehicle(me) then
					entity.set_entity_max_speed(car, 45000)
					for i = 1, 2 do
						local key = MenuKey()
						key:push_str(binds[i])
						while key:is_down() and f.on do
							get_control_of_entity(entity.get_entity_entity_has_collided_with(car))
							local speed = {setting["Vehicle fly speed"], -setting["Vehicle fly speed"]}
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
					system.yield(400)
				end
				system.yield(0)
			end
		end)
		u.vehicle_fly.threaded = true

	-- Teleport player & vehicle
		u.tp_wp = menu.add_player_feature("Teleport player & vehicle to waypoint", "action", u.pVehicles, function(f, pid)
			if ui.get_waypoint_coord().x > 14000 then
				msg("Please set a waypoint.", 6, true)
				return
			end
			local me = player.player_id()
			local initial_pos = player.get_player_coords(me)
			local pos = ui.get_waypoint_coord()
			local pos = v3(pos.x, pos.y, 1000)
			local Ped = player.get_player_ped(me)
			if is_target_viable(pid, 13, true) then
				local time = utils.time_ms() + 1250
				local car = player.get_player_vehicle(pid)
				for i = 1, 12000 do
					teleport(car, pos + v3(0, 0, 3))
					temp.nothing, pos.z = gameplay.get_ground_z(player.get_player_coords(pid))
					if utils.time_ms() > time then
						break 
					end
					system.yield(0)
				end
			else
				msg(player.get_player_name(pid).." is not in a vehicle.", 6, true)
			end
			if get_distance_between(player.get_player_coords(player.player_id()), initial_pos, true) > 150 then
				if player.is_player_in_any_vehicle(me) and pid ~= me then
					teleport(player.get_player_vehicle(me), initial_pos)
				elseif pid ~= me then
					teleport(Ped, initial_pos) 
				end
			end
		end)
		u.tp_wp.threaded = true

	-- Teleport to me
		u.tp_me = menu.add_player_feature("Teleport player & vehicle to you", "action", u.pVehicles, function(f, pid)
			if player.player_id() == pid then
				msg("No need to teleport yourself to yourself.", 6, true)
				return
			end
			local me = player.player_id()
			local pos = player.get_player_coords(me)
			local Ped = player.get_player_ped(me)
			if is_target_viable(pid, 13, true) then
				local time = utils.time_ms() + 1250
				local car = player.get_player_vehicle(pid)
				for i = 1, 12000 do
					teleport(car, pos + v3(0, 3, 1))
					if utils.time_ms() > time then
						break 
					end
					system.yield(0)
				end
			else
				msg(player.get_player_name(pid).." is not in a vehicle.", 6, true)
			end
			if get_distance_between(player.get_player_coords(player.player_id()), pos, true) > 150 then
				if player.is_player_in_any_vehicle(me) then
					teleport(player.get_player_vehicle(me), pos)
				else
					teleport(Ped, pos) 
				end
			end
		end)
		u.tp_me.threaded = true

-- Player scripts
	u.disable_vehicles_player = menu.add_player_feature("Disable vehicles", "toggle", u.script_stuff, function(f, pid)
		while f.on do
			disable_vehicle(pid)
			system.yield(2000)
		end
	end)
	u.disable_vehicles_player.threaded = true

	u.player_OTR = menu.add_player_feature("Off-the-radar", "toggle", u.script_stuff, function(f, pid)
		otr_table[pid] = utils.time_ms() + 1547483647
		while f.on do
			if not globals.is_player_otr(pid) then
				send_script_event(575518757, pid, {pid, utils.time() - 60, utils.time(), 1, 1, script.get_global_i(1630317 + (1 + (595 * pid)) + 506)})
			end
			system.yield(100)
		end
	end)
	u.player_OTR.threaded = true

	menu.add_player_feature("Give 10k CEO loop", "toggle", u.script_stuff, function(f, pid)
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

	menu.add_player_feature("Block passive mode", "toggle", u.script_stuff, function(f, pid)
		while f.on do
			send_script_event(-909357184, pid, {pid, 1})
			system.yield(2000)
		end
		send_script_event(-909357184, pid, {pid, 0})
	end)

	menu.add_player_feature("Apply bounty", "action", u.script_stuff, function(f, pid)
		set_bounty(pid)
	end)

	u.p_reapply_death = menu.add_player_feature("Reapply bounty after death", "toggle", u.script_stuff, function(f, pid)
		local Ped = player.get_player_ped(pid)
		if player.player_id() == script.get_host_of_this_script() then
			msg("Modded bounties does not work while you're script host.", 6, true)
			f.on = false
			return
		end
		while f.on and me ~= script.get_host_of_this_script() and not setting["Reapply bounty automatically"] do
			if entity.is_entity_dead(Ped) then
				set_bounty(pid)
			end
			system.yield(1000)
		end
		f.on = false
	end)
	u.p_reapply_death.threaded = true

	menu.add_player_feature("Perico island", "toggle", u.script_stuff, function(f, pid)
		if f.on then
			send_script_event(1300962917, pid, {pid, 1300962917, 0, 0})
		else
			send_script_event(-171207973, pid, {pid, pid, 1, 0, math.random(0, 114), 1, 1, 1})
			msg("Sending lad to Los Santos Airport.", 210, true)
		end
	end)

	menu.add_player_feature("Apartment invites", "toggle", u.script_stuff, function(f, pid)
		while f.on do
			send_script_event(-171207973, pid, {pid, pid, 1, 0, math.random(0, 114), 1, 1, 1})
			system.yield(5000)
		end
	end)

	menu.add_player_feature("Send to random mission", "action", u.script_stuff, function(f, pid)
		if math.random(1, 8) == 1 then
			send_script_event(-545396442, pid, {0})
		else
			send_script_event(-545396442, pid, {0, math.random(1, 7)})
		end
	end)

	menu.add_player_feature("Terminate CEO", "action", u.script_stuff, function(f, pid)
		send_script_event(-1648921703, pid, {1, 1, 6})
	end)

	menu.add_player_feature("Transaction error", "toggle", u.script_stuff, function(f, pid)
		while f.on do
			send_script_event(1302185744, pid, {pid, 2147483647, 1, 1, script.get_global_i(1630317 + (1 + (pid * 595) + 506)), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10), 1})
			system.yield(1000)
		end
	end)

-- Player trolling
	-- Ram vehicle
		menu.add_player_feature("Which vehicle, \"?\" is random.", "action", u.pTroll, function()
			txt.kekText2 = get_input("Type in which car to ram with", "", 128, 0, setting["Default vehicle"]):lower()  
		end)

		menu.add_player_feature("Ram player with vehicle", "action", u.pTroll, function(f, pid)
			spawn_and_push_a_vehicle_in_direction(pid, true, -8, vMap.GetHashFromModel(txt.kekText2))
		end)

		u.ram_loop = menu.add_player_feature("Ram loop", "toggle", u.pTroll, function(f, pid)
			local Ped = player.get_player_ped(pid)
			while f.on do
				spawn_and_push_a_vehicle_in_direction(pid, true, -8, vMap.GetHashFromModel(txt.kekText2), Ped)
				system.yield(0)
			end
		end)
		u.ram_loop.threaded = true

	-- Spawn a Kek-copter
		u.kek_chopper = menu.add_player_feature("Spawn kek's chopper", "toggle", u.pTroll, function(f, pid)
			local Ped = player.get_player_ped(pid)
			local dead = entity.is_entity_dead
			while f.on do
				if player.get_player_coords(pid).z > -20 then
					local pos = player.get_player_coords(pid) + v3(0, 0, 20)
					local chopper = spawn_vehicle(2310691317, pos, 0)
					max_car(chopper)
					modify_entity_godmode(chopper, true)
					local pilot = spawn_pedestrian(27, 0x8D8F1B10, pos + v3(5, 6, 100), 0)
					modify_entity_godmode(pilot, true)
					ped.set_ped_into_vehicle(pilot, chopper, -1)
					vehicle.set_heli_blades_speed(chopper, 5000)
					ai.task_vehicle_follow(pilot, chopper, Ped, 100, 262144, 30)
					system.yield(2000)
					teleport(chopper, player.get_player_coords(pid) + v3(math.random(-30, 30), math.random(-30, 30), 17))
					while f.on and not dead(chopper) and not dead(pilot) do
						if not ped.is_ped_in_vehicle(pilot, chopper) then
							get_control_of_entity(pilot)
							ped.set_ped_into_vehicle(pilot, chopper, -1)
							vehicle.set_heli_blades_speed(chopper, 5000)
							ai.task_vehicle_follow(pilot, chopper, Ped, 100, 262144, 30)
						end
						system.yield(0)
						vehicle.set_vehicle_deformation_fixed(chopper)
						vehicle.set_vehicle_fixed(chopper) 
						local pos = player.get_player_coords(pid) + v3(0, 0, 20)
						local distance_between_chopper_and_player = get_distance_between(Ped, chopper)
						if distance_between_chopper_and_player > 375 or vehicle.is_vehicle_stopped(chopper) then
							teleport(chopper, player.get_player_coords(pid) + v3(math.random(-30, 30), math.random(-30, 30), 17))
							ai.task_vehicle_follow(pilot, chopper, Ped, 100, 262144, 30)
						end
						if distance_between_chopper_and_player < 240 then
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
									temp[i] = spawn_vehicle(3564062519, entity.get_entity_coords(chopper) + v3(0, 0, 50), 0)
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
								if distance_between_chopper_and_player > 25 then
									teleport(car, get_vector_relative_to_player(entity.get_entity_coords(chopper), entity.get_entity_heading(chopper), 9) - v3(0, 0, math.random(math.min(math.round(z_lowest / 6), z_lowest), z_lowest)))
									entity.set_entity_rotation(car, entity.get_entity_rotation(chopper))
								else
									local dir = player.get_player_heading(pid)
									teleport(car, get_vector_relative_to_player(player.get_player_coords(pid), dir, -8))
									entity.set_entity_heading(car, dir)
								end
								vehicle.set_vehicle_forward_speed(car, 150)
								entity.set_entity_as_no_longer_needed(car)
								system.yield(0)
							end
							if spawned_food_self then
								system.yield(3000)
								clear_entities(temp)
							else
								system.yield(2000)
							end
						else
							system.yield(2000)
						end
						system.yield(0)
					end
					local count = 0
					while entity.is_an_entity(chopper) and entity.is_an_entity(pilot) and count < 20 do
						clear_entities({chopper, pilot})
						count = count + 1
						system.yield(0)
					end
				end
				system.yield(100)
			end
		end)
		u.kek_chopper.threaded = true

	-- Vehicle hurricane
		u.vehicle_hurricane = menu.add_player_feature("Vehicle hurricane", "toggle", u.pTroll, function(f, pid)
			if u.clear_entities.on then
				msg("Please turn off \"Clear entity type\", to use this.", 6, true)
				f.on = false
				return
			end
			local coord, mod = player.get_player_coords, player.is_player_modder
			local id, entity_type, spectating = player.player_id, get_table_of_close_entity_type, network.get_player_player_is_spectating
			local max, random, is_entity = math.max, math.random, entity.is_an_entity
			local dont_need, tp = entity.set_entity_as_no_longer_needed, teleport
			local pos = coord(pid)
			if pos.z == -50 or pos.z == -180 or pos.z == 190 then
				msg("Their position is unknown (invalid Z coordinate). Please get closer to them.", 212, true)
			end
			while f.on do
				local pos = coord(pid)
				if not entity.is_entity_dead(player.get_player_ped(pid)) and pos.z > -20 then
					if mod(pid, -1) then
						f.on = false
						return
					end
					local me = id()
					local PEd, co, Ped = player.get_player_ped(pid), {}, {}
					local e = entity_type(1)
					if spectating(me) == pid then
						Ped = PEd
					else
						Ped = player.get_player_ped(me)
					end
					remove_player_entities(e)
					table.sort(e, function(a, b) return (get_distance_between(a, PEd) < get_distance_between(b, PEd)) end)
					for i = 21, #e do
						table.remove(e, #e)
					end
					local their_vehicle = player.get_player_vehicle(pid)
					if their_vehicle ~= 0 then
						network.request_control_of_entity(their_vehicle)
						vehicle.set_vehicle_forward_speed(their_vehicle, math.random(-150, 150))
					end
					for i = 1, #e do
						co[#co + 1] = coroutine.create(function()
							if e[i] and is_entity(e[i]) then
								entity.set_entity_coords_no_offset(e[i], coord(pid) + v3(random(-2, 2), random(-2, 2), random(-2, 2)))
								dont_need(e[i])
							end
						end)
						coroutine.resume(co[#co])
						system.yield(0)
					end
				end
				system.yield(0)
			end
		end)
		u.vehicle_hurricane.threaded = true

-- Weapon stuff
	-- Give someone vehicle gun
		u.player_vehicle_gun = menu.add_player_feature("Vehicle gun", "toggle", u.pWeapons, function(f, pid)
			local Me = player.player_id()
			local me = player.get_player_ped(Me)
			local Ped = player.get_player_ped(pid)
			local e = {}
			while f.on and (network.get_entity_player_is_spectating(Me) == Ped or get_distance_between(Ped, me) < 1000) do
				if f.on and ped.is_ped_shooting(Ped) then
					local hash = vMap.GetHashFromModel(txt.kekText2, 697)
					e[#e + 1] = spawn_and_push_a_vehicle_in_direction(pid, false, 8, hash)
					if #e > 20 then
						clear_entities({e[1]})
						table.remove(e, 1)
					end
				end
				system.yield(0)
			end
			clear_entities(e)
			f.on = false
		end)
		u.player_vehicle_gun.threaded = true

	-- Player guns
		u.delete_gun = menu.add_player_feature("Delete gun", "toggle", u.pWeapons, function(f, pid)
			local me = player.player_id()
			local Ped, my_ped = player.get_player_ped(pid), player.get_player_ped(me)
			while f.on and (network.get_entity_player_is_spectating(me) == Ped or get_distance_between(Ped, my_ped) < 1000) do
				local e = player.get_entity_player_is_aiming_at(pid)
				system.yield(0)
				if ped.is_ped_shooting(Ped) and entity.is_an_entity(e) then
					clear_entities({e})
				end
			end
		end)
		u.delete_gun.threaded = true

		u.explosion_gun = menu.add_player_feature("Explosion gun", "toggle", u.pWeapons, function(f, pid)
			local me = player.player_id()
			local Ped, my_ped = player.get_player_ped(pid), player.get_player_ped(me)
			while f.on and (network.get_entity_player_is_spectating(me) == Ped or get_distance_between(Ped, my_ped) < 1000) do
				if ped.is_ped_shooting(Ped) then
					local t, pos = ped.get_ped_last_weapon_impact(Ped)
					fire.add_explosion(pos, math.random(0, 73), true, false, 0, Ped)
				end
				system.yield(0)
			end
		end)
		u.explosion_gun.threaded = true

	-- Object gun
		menu.add_feature("Type in what object \"?\" is random object", "action", u.weapons.id, function()
			temp.what_object = get_input("Type in what object to use.", "", 128, 0, "?"):lower()
			local a, b = oMap.GetHashFromModel(temp.what_object)
			if not b then
				msg("Invalid object", 6, true)
			end
		end)

		u.object_gun = menu.add_feature("Object gun", "toggle", u.weapons.id, function(f)
			local e, Ped = {}, player.get_player_ped(player.player_id())
			while f.on do
				local me = player.player_id()
				if ped.is_ped_shooting(Ped) then
					e[#e + 1] = spawn_object(oMap.GetHashFromModel(temp.what_object), get_vector_relative_to_player(player.get_player_coords(me), player.get_player_heading(me), 15))
					local pos = get_collision_vector(me, Ped)
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
		u.object_gun.threaded = true

	-- Airstrike gun
		u.airstrike_gun = menu.add_feature("Airstrike gun", "toggle", u.weapons.id, function(f)
			local we, Ped, P = gameplay.get_hash_key("weapon_airstrike_rocket"), player.get_player_ped(player.player_id()), v3(0, 0, 15)
			while f.on do
				local m = player.player_id()
				if f.on and ped.is_ped_shooting(Ped) then
					local Pos, d = get_collision_vector(m, Ped)
			        if d > 3 then
			    	    gameplay.shoot_single_bullet_between_coords(Pos + P, Pos, 1000, we, Ped, true, false, 250)
			    	end
			    end
				system.yield(0)
			end
		end)
		u.airstrike_gun.threaded = true

	-- Vehicle gun
		menu.add_feature("What vehicle, \"?\" is random.", "action", u.weapons.id, function()
			txt.kekText2 = get_input("Type in which car use.", "", 128, 0, setting["Default vehicle"]):lower()  
		end)

		u.self_vehicle_gun = menu.add_feature("Vehicle gun", "toggle", u.weapons.id, function(f)
			local my_ped = player.get_player_ped(player.player_id())
			local e = {}; local s
			while f.on do
				if f.on and ped.is_ped_shooting(my_ped) then
					if txt.kekText2 == "?" then
						s = 22
					else
						s = 8
					end
					local hash = vMap.GetHashFromModel(txt.kekText2, 695)
					local dir = player.get_player_heading(player.player_id())
					e[#e + 1] = spawn_vehicle(hash, get_vector_relative_to_player(cam.get_gameplay_cam_pos(), dir, s), dir)
					entity.set_entity_rotation(e[#e], cam.get_gameplay_cam_rot())
					vehicle.set_vehicle_forward_speed(e[#e], 120)
					if #e > 20 then
						clear_entities({e[1]})
						table.remove(e, 1)
					end
				end
				system.yield(0)
			end
			clear_entities(e)
			f.on = false
		end)
		u.self_vehicle_gun.threaded = true

-- Kek's utilities
	-- Clear entity type
		valuei["Entity type"] = {"Entity type", menu.add_feature("Entity type, click me for info", "autoaction_value_i", u.kek_utilities.id, function(f)
			local key = MenuKey()
			key:push_str("RETURN")
			if key:is_down() then
				msg("1: Vehicles\n2: Peds\n3: Objects\n4: Pickups\n5: Peds & Vehicles\n6: All", 140, true)
			end
			setting["Entity type"] = f.value_i
		end)}
		valuei["Entity type"][2].max_i, valuei["Entity type"][2].min_i, valuei["Entity type"][2].mod_i = 6, 1, 1

		toggle[#toggle + 1] = {"Ignore players while clearing entities", menu.add_feature("Ignore other players", "toggle", u.kek_utilities.id, function(f)
			if f.on then
				setting["Ignore players while clearing entities"] = true
			else
				setting["Ignore players while clearing entities"] = false
			end
		end)}

		u.clear_entities = menu.add_feature("Clear entity type", "toggle", u.kek_utilities.id, function(f)
			while f.on do
				clear_entities(get_table_of_close_entity_type(valuei["Entity type"][2].value_i), true)
				system.yield(0)
			end
		end)
		u.clear_entities.threaded = true

	-- Find model name
		menu.add_feature("Shoot entity: get model name of entity", "toggle", u.kek_utilities.id, function(f)
			local Ped, hash = player.get_player_ped(player.player_id())
			while f.on do
				if ped.is_ped_shooting(Ped) then
					local e = entity.get_entity_model_hash(player.get_entity_player_is_aiming_at(player.player_id()))
					if streaming.is_model_an_object(e) then
						hash = oMap.GetModelFromHash(e)
					elseif streaming.is_model_a_ped(e) then
						hash = pMap.GetModelFromHash(e)
					else
						hash = vMap.GetModelFromHash(e)
					end
				end
				if hash and hash ~= 0 then
					msg("This model is called: "..hash, 140, true)
					hash = 0
					system.yield(250)
				end
				system.yield(0)
			end
		end)

	-- Copy rid to clipboard
		menu.add_player_feature("Copy rid to clipboard", "action", u.p_utilities, function(f, pid)
			utils.to_clipboard(tostring(player.get_player_scid(pid)))
			msg("Copied rid to clipboard.", 212, setting["Guide text #notifications#"])
		end)

	-- Copy position to clipboard
		menu.add_player_feature("Copy position with decimals to clipboard", "action", u.p_utilities, function(f, pid)
			utils.to_clipboard(string.gsub(string.gsub(tostring(player.get_player_coords(pid)), "v3%(", ""), "%)", ""))
			msg("Copied position with decimals to clipboard.", 212, setting["Guide text #notifications#"])
		end)

		menu.add_player_feature("Copy position without decimals to clipboard", "action", u.p_utilities, function(f, pid)
			local pos = player.get_player_coords(pid)
			utils.to_clipboard(tostring(math.floor(pos.x)..", "..math.floor(pos.y)..", "..math.floor(pos.z)))
			msg("Copied position without decimals to clipboard.", 212, setting["Guide text #notifications#"])
		end)

	-- Copy ip to clipboard
		menu.add_player_feature("Copy ip to clipboard", "action", u.p_utilities, function(f, pid)
			utils.to_clipboard(get_ip_in_ipv4(pid))
			msg("Copied ip to clipboard!", 212, true)
		end)

	-- Save all player stats to file
		menu.add_player_feature("Save all their stats to file", "action", u.p_utilities, function(f, pid)
			local stats = globals.get_all_stats(pid)
			local file = io.open(o.kek_menu_stuff_path.."Player stats\\"..player.get_player_name(pid)..".log", "w+")
			for i, k in pairs(stats) do
				file:write(k.."\n")
			end
			file:flush()
			file:close()
			msg("Saved their stats to a file.", 210, true)
			msg("kek_menu_stuff\\Player stats\\"..player.get_player_name(pid)..".log", 212, true)
		end)

-- Keybindings
	local function switch(v, t)
		if not v.on then
			v.on = true
			msg("Hotkey:\nTurned on "..t, 140, setting["Hotkeys #notifications#"]) 
		else
			v.on = false
			msg("Hotkey:\nTurned off "..t, 140, setting["Hotkeys #notifications#"]) 
		end
	end
	local Temp = #general_settings
	table.merge
	(
		general_settings,
		{
			{
				"Max vehicle #keybinding#", 
				"nil", 
				function() 
					max_car(player.get_player_vehicle(player.player_id()))
					msg("Hotkey:\nMaxed vehicle.", 140, setting["Hotkeys #notifications#"])
				end
			},
			{
				"Spawn vehicle #keybinding#", 
				"nil",
				function() 
					spawn_car()
					msg("Hotkey:\nSpawned vehicle.", 140, setting["Hotkeys #notifications#"]) 
				end
			},
			{
				"Repair vehicle #keybinding#", 
				"nil",
				function() 
					vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()))
					msg("Hotkey:\nRepaired vehicle.", 140, setting["Hotkeys #notifications#"])
				end
			}, 
			{
				"Vehicle fly #keybinding#", 
				"nil",
				function()
					switch(u.vehicle_fly, "vehicle fly.")
				end
			},
			{
				"Vehicle gun #keybinding#", 
				"nil",
				function()
					switch(u.self_vehicle_gun, "vehicle gun.")
				end
			},
			{
				"Airstrike gun #keybinding#", 
				"nil",
				function()
					switch(u.airstrike_gun, "airstrike gun.")
				end
			},
			{
				"Change vehicle used for vehicle stuff #keybinding#", 
				"nil",
				function()
					txt.kekText2 = get_input("Type in which car to use for vehicle stuff.", "", 128, 0, setting["Default vehicle"]):lower() 
				end
			},
			{
				"Tag / untag session #keybinding#", 
				"nil",
				function() 
					for pid = 0, 31 do
						if player.is_player_valid(pid) and not player.is_player_modder(pid, -1) then
							player.set_player_as_modder(pid, 1)
						elseif player.is_player_valid(pid) and player.get_player_modder_flags(pid) == 1 then
							player.unset_player_as_modder(pid, 1)
						end
					end
					msg("Hotkey:\nTagged non modders & untagged modders with manual tag.", 140, setting["Hotkeys #notifications#"])
				end
			},
			{
				"Disconnect from session #keybinding#", 
				"nil",
				function()
					msg("Hotkey:\nDisconnected you from session.", 140, setting["Hotkeys #notifications#"])
					u.disconnect.on = true
				end
			},
			{
				"Clear entity type #keybinding#", 
				"nil",
				function()
					switch(u.clear_entities, "Clear entity type.")
				end
			},
			{
				"Increase vehicle fly speed #keybinding#", 
				"nil",
				function()
					valuei["Vehicle fly speed"][2].value_i = valuei["Vehicle fly speed"][2].value_i + valuei["Vehicle fly speed"][2].mod_i
					setting["Vehicle fly speed"] = valuei["Vehicle fly speed"][2].value_i
					msg("Hotkey:\nIncreased vehicle fly speed", 140, setting["Hotkeys #notifications#"])
				end
			},
			{
				"Decrease vehicle fly speed #keybinding#", 
				"nil",
				function()
					valuei["Vehicle fly speed"][2].value_i = valuei["Vehicle fly speed"][2].value_i - valuei["Vehicle fly speed"][2].mod_i
					setting["Vehicle fly speed"] = valuei["Vehicle fly speed"][2].value_i
					msg("Hotkey:\nDecreased vehicle fly speed", 140, setting["Hotkeys #notifications#"])
				end
			}
		}
	)

	for i = Temp + 1, #general_settings do
		setting_names[#setting_names + 1] = general_settings[i][1]
		setting[setting_names[#setting_names]] = general_settings[i][2]
	end

	toggle[#toggle + 1] = {"hotkeys", menu.add_feature("Enable hotkeys", "toggle", u.hotkey_settings.id, function(f)
		setting["hotkeys"] = true
		while f.on do
			if not gameplay.is_onscreen_keyboard_active() then
				local hotkeys = {}
				for i = 1, #general_settings do
					if general_settings[i][1]:find("#keybinding#") then
						hotkeys[#hotkeys + 1] = general_settings[i]
					end
				end
				for i = 1, #hotkeys do
					local key = MenuKey()
					key:push_str(setting[hotkeys[i][1]])
					if key:is_down() then
						hotkeys[i][3]()
						do_key(setting[hotkeys[i][1]], 550)
						while key:is_down() do
							hotkeys[i][3]()
							system.yield(80)
						end
					end
				end
			end
			system.yield(30)
		end
		setting["hotkeys"] = false
	end)}
	toggle[#toggle][2].threaded = true

	local bindings = {"LSHIFT", "LCONTROL", "RCONTROL", "RSHIFT", "SPACE", "TAB", "LALT", "RALT", "PAGEUP", "PAGEDOWN", "LEFT", "RIGHT", "DOWN", "UP", "BACKSPACE", "RETURN", "CAPSLOCK", "SCROLLLOCK", "f1", "f2", 
	"f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "num0", "num1", "num2", "num3", "num4", "num5", "num6", "num7", "num8", "num9", "num-", "num+", "NUM/", "NUMDEL", "NUM*", "INSERT", "SPACE", 
	"NUMLOCK", "HOME", "ESCAPE", "PAUSE", "END", "nil"}
	for i, setting_name in pairs(general_settings) do
		if setting_name[1]:find("#keybinding#") then
			menu.add_feature(setting_name[1]:gsub("#keybinding#", ""), "action", u.hotkey_settings.id, function(f)
				local pre_get_input_text = setting[setting_name[1]]
				setting[setting_name[1]] = get_input("Type in what you want the keybinding to be.", "", 128, 0, setting[setting_name[1]])
				if setting[setting_name[1]] and setting[setting_name[1]] ~= pre_get_input_text and (setting[setting_name[1]]:match("(.?)") == setting[setting_name[1]] or table.get_index_of_value(bindings, setting[setting_name[1]])) then
					if setting[setting_name[1]] ~= "nil" then
						msg("Successfully changed keybinding.\nType \"nil\" to turn it off.", 212, true)
					else
						msg("Turned off the keybinding:\n\""..setting_name[1]:gsub("keybinding", "").."\".", 210, true)
					end
				elseif setting[setting_name[1]] == pre_get_input_text then
					msg("Keybinding not changed. Empty input or input is the same as existing keybinding.", 210, true)
				else
					setting[setting_name[1]] = pre_get_input_text
					msg("Invalid keybinding.\nIt's case sensitive, get it right.", 6, true)
					msg("Most of the keys like, \"left shift\", are written in all caps. Example: \"LSHIFT\".", 212, setting["Guide text #notifications#"])
				end
			end)
		end
	end

-- Initialize settings
	local function setting_file_valid_test(file_name, text)
		if utils.file_exists(o.kek_menu_stuff_path..file_name) then
			for i, setting_name in pairs(setting_names) do
				log("scripts\\kek_menu_stuff\\"..file_name, setting_name.."="..tostring(setting[setting_name]), {setting_name})	
			end
		else
			local file = io.open(o.kek_menu_stuff_path..file_name, "w+")
			for i, setting_name in pairs(setting_names) do
				file:write(setting_name..tostring(setting[setting_name]))
			end
			file:flush()
			file:close()
		end
		modify_entry("scripts\\kek_menu_stuff\\"..file_name, {general_settings[1][1].."=", general_settings[1][1].."="..general_settings[1][2]}, false, true)
	end
	setting_file_valid_test("keksettings.ini", true)
	for i, setting_name in pairs(general_settings) do
		if setting_name[1]:find("#notifications#") then
			toggle[#toggle + 1] = {setting_name[1], menu.add_feature(setting_name[1]:gsub("#notifications#", ""), "toggle", u.notifSettings.id, function(f)
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
			elseif setting_in_file == "true" then
				setting_in_file = true
			elseif setting_in_file == "false" then
				setting_in_file = false
			elseif not setting_in_file or #setting_in_file == 0 then
				setting_in_file = setting[name]
			end
			if search_for_match_and_get_line(file_path, {name}, false, true) then
				if type(setting_in_file) ~= type(setting[name]) then
					setting_in_file = setting[name]
					print("INVALID SETTING, "..name.." IS SET TO DEFAULT.")
				end
				setting[name] = setting_in_file
		    else
		    	print("COULD NOT FIND SETTING.")
		    end
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
	initialize_settings("scripts\\kek_menu_stuff\\keksettings.ini")

-- Settings files
	local function save_settings(file_name)
		o.loops_on = false
		system.yield(2200)
		local file = io.open(o.kek_menu_stuff_path..file_name, "w+")
		for i, setting_name in pairs(setting_names) do
			file:write(setting_name.."="..tostring(setting[setting_name]).."\n")
		end
		file:flush()
		file:close()
		o.loops_on = true
	end

	local profile_names = {}
	local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\profile names.ini", "*a")
	for line in str:gmatch("([^\n]*)\n?") do
		profile_names[#profile_names + 1] = line
	end
	local profiles = {}
	menu.add_feature("Save settings to default", "action", u.profiles.id, function()
		save_settings("keksettings.ini")
		msg("Settings saved!", 210, true)
	end)	
	menu.add_feature("1 = Load profile", "action", u.profiles.id)
	menu.add_feature("2 = Overwrite/save profile", "action", u.profiles.id)
	menu.add_feature("3 = Change profile name", "action", u.profiles.id)
	for i = 1, 10 do
		profiles[i] = menu.add_feature(profile_names[i]:match("&|<<>.,(.*)&|<<>.,"), "action_value_i", u.profiles.id, function(f)
			if f.value_i == 1 then
				local s = o.kek_menu_stuff_path.."profiles\\profile "..i..".ini"
				if utils.file_exists(s) then
					setting_file_valid_test("profiles\\profile "..i..".ini", true)
					initialize_settings("scripts\\kek_menu_stuff\\profiles\\profile "..i..".ini")
					msg("Successfully loaded "..profile_names[i]:match("&|<<>.,(.*)&|<<>.,")..".", 210, true)
				else
					msg("The setting file doesn't exist.\nPlease save to this slot in order to use it.", 6, true)
				end
			elseif f.value_i == 2 then
				save_settings("profiles\\profile "..i..".ini")
				msg("Saved "..profile_names[i]:match("&|<<>.,(.*)&|<<>.,")..".", 212, true)
			elseif f.value_i == 3 then
				local Name = get_input("Type in the name of the profile.", "", 128, 0) 
				if #Name == 0 then
					msg("Invalid name.", 6, true)
					return
				end
				if modify_entry("scripts\\kek_menu_stuff\\kekMenuData\\profile names.ini", {profile_names[i], Name}, true, true, true) == 1 then
					f.name = Name
					msg("Saved profile name.", 212, true)
					profile_names = {}
					local str = get_file_string("scripts\\kek_menu_stuff\\kekMenuData\\profile names.ini", "*a")
					for line in str:gmatch("([^\n]*)\n?") do
						profile_names[#profile_names + 1] = line
					end
				else
					msg("Failed to save profile name.", 6, true)
				end
			end
		end)
		profiles[i].max_i, profiles[i].min_i, profiles[i].value_i, profiles[i].mod_i = 3, 1, 1, 1
		profiles[i].threaded = true
	end

	temp.load_history = menu.add_feature("", "toggle", 0, function(f)
		f.hidden = true
		temp.load_player_history()
		loaded_player_history = true
		f.on = false
		menu.delete_feature(f.id)
	end)
	temp.load_history.on = true

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
	end) 

-- After successful load
	msg("Successfully loaded Kek's menu.\nMake sure to save your settings with \"Save settings to default\".", math.random(1, 140), true)