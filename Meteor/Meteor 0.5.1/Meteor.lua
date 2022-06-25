if Meteor then
	menu.notify("[!] The Script is already loaded!", "Initialization cancelled.", 3, 211) 
	return
end

Meteor = "Meteor V0.5.1"

local meteor_session_timer = utils.time_ms()
local altered_sh_migration_detection_timer = utils.time_ms()
local altered_sh_migration_detection_timer_left_player = utils.time_ms()
local did_someone_type = false

local utilities = require("Meteor/Lib/Utils")
local script_func = require("Meteor/Lib/Script_Func")
local NetEventID = require("Meteor/Mapper/NetEventIDs")
local NetEventName = require("Meteor/Mapper/NetEventNames")
local ObjectModel = require("Meteor/Mapper/ObjectModels")
local PedModel = require("Meteor/Mapper/PedModels")
local VehicleModel = require("Meteor/Mapper/VehicleModels")
local settings = require("Meteor/Settings")
local feature_value_settings = require("Meteor/FeatureValueSettings")

--

local o = {}
local u = {}
local player_feat_ids = {}
local objects = {}
local ptfxs = {}
local threads = {}
local feature = {}
local localparents = {}
local playerparents = {}
local listeners = {}
local eventhooks = {}
local custommodderflags = {}

local IsPlayerDead = {}
local IsPlayerAlive = {}
local HasBeenTyping = {}
local HasNotBeenTyping = {}
local HasScriptHostMigratedTo = {}
local IsPlayerWhitelisted = {}
local FakeTypingBegin = {}
local IsInOrbitalCannonRoom = {}
local IsNotInOrbitalCannonRoom = {}
local IsCallingAnOrbitalStrike = {}
local IsNotCallingAnOrbitalStrike = {}
local IsOTRFor = {}
local SentXMessagesInTheLast5Seconds = {}

local InvalidSCIDDetectionPlayer = {}
local ModdedHealthDetectionPlayer = {}
local GodmodeDetectionPlayer = {}
local InvalidNameDetectionPlayer = {}
local InvalidIPDetectionPlayer = {}
local StandUserDetectionPlayer = {}
local MaxSpeedBypassDetectionPlayer = {}
local InvalidStatsDetectionPlayer = {}
local SessionHostCrashDetectionPlayer = {}
local BadOutfitDataDetectionPlayer = {}
local FakeTypingIndicatorDetectionPlayer = {}
local ModdedSpectateDetectionPlayer = {}
local ModdedOTRDetectionPlayer = {}

--

eventhooks["» Main Script Event Hook"] = hook.register_script_event_hook(function(source, target, params, count)
	if settings["» Notify Typing Players"] then
		if params[1] == 0x2C8A72D0 then
			menu.notify(string.format("%s", player.get_player_name(source)) .. " started typing", Meteor, 2, 0x64FA7800)
		elseif params[1] == 0xC4EF2D0B then
			menu.notify(string.format("%s", player.get_player_name(source)) .. " stopped typing", Meteor, 2, 0x64FA7800)
		end
	end
	if settings["» Guided Missile Tracker"] then
		if params[1] == 0xd621a95f then
			menu.notify(string.format("%s", player.get_player_name(source)) .. " launched a guided missile!", Meteor, 8, 0x64FA7800)
		end
	end
	if settings["» Bad Script Event Detection"] then
		if params[2] ~= source then
			if (settings["» Exclude Friends From Detections"] and player.is_player_friend(source)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[source]) then
			else
				if feature["» Bad Script Event Detection"].value == 0 then
					if pid ~= player.player_id() and player.is_player_valid(source) and not player.is_player_modder(source, custommodderflags["Bad Script Event"]) then
						menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Bad Script Event", "Modder Detection", 6, 0x00A2FF)
						player.set_player_as_modder(source, custommodderflags["Bad Script Event"])
					end
				elseif feature["» Bad Script Event Detection"].value == 1 then
					if pid ~= player.player_id() and player.is_player_valid(source) then
						menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Bad Script Event", "Modder Detection", 6, 0x00A2FF)
					end
				elseif feature["» Bad Script Event Detection"].value == 2 then
					if pid ~= player.player_id() and player.is_player_valid(source) and not player.is_player_modder(source, custommodderflags["Bad Script Event"]) then
						player.set_player_as_modder(source, custommodderflags["Bad Script Event"])
					end
				end
			end
		end
	end
	if settings["» Stand User Detection"] then
		if (params[1] == 962740265) or (params[1] == -1386010354) or (params[1] == -399817245 and params[4] > 31) or (params[1] == -569621836 and params[4] >= 30583) or (params[1] == -1782442696 and prams[3] == 420 and params[4] == 69) or (params[1] == 1228916411 and params[3] > 1000000) or (params[1] == 537760938 and params[2] == 2680059592720 and params[3] == 2680059592880 and params[4] == 539) then
			if source ~= player.player_id() and player.is_player_valid(source) and not player.is_player_modder(source, custommodderflags["Stand User"]) then
				if (settings["» Exclude Friends From Detections"] and player.is_player_friend(source)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[source]) then
				else
					if feature["» Stand User Detection"].value == 0 then
						menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Stand User", "Modder Detection", 6, 0x00A2FF)
						player.set_player_as_modder(source, custommodderflags["Stand User"])
					elseif feature["» Stand User Detection"].value == 1 then
						menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Stand User", "Modder Detection", 6, 0x00A2FF)
					elseif feature["» Stand User Detection"].value == 2 then
						player.set_player_as_modder(source, custommodderflags["Stand User"])
					end
				end
			end
		end
	end
	if settings["» Fake Typing Indicator Detection"] then
		if params[1] == 0x2C8A72D0 and FakeTypingBegin[source] and meteor_session_timer < utils.time_ms() and not entity.is_entity_dead(player.get_player_ped(source)) then
			if (settings["» Exclude Friends From Detections"] and player.is_player_friend(source)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[source]) then
			else
				if feature["» Fake Typing Indicator Detection"].value == 0 then
					if not player.is_player_modder(source, -1) then
						menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Fake Typing Indicator", "Modder Detection", 6, 0x00A2FF)
						player.set_player_as_modder(source, custommodderflags["Fake Typing Indicator"])
					end
				elseif feature["» Fake Typing Indicator Detection"].value == 1 and not FakeTypingIndicatorDetectionPlayer[pid] then
					if not player.is_player_modder(source, -1) then
						menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Fake Typing Indicator", "Modder Detection", 6, 0x00A2FF)
						FakeTypingIndicatorDetectionPlayer[pid] = true
					end
				elseif feature["» Fake Typing Indicator Detection"].value == 2 then
					if not player.is_player_modder(source, -1) then
						player.set_player_as_modder(source, custommodderflags["Fake Typing Indicator"])
					end
				end
			end
		end
	end
end)

eventhooks["» Main Net Event Hook"] = hook.register_net_event_hook(function(source, target, eventId)
	if settings["» Bad Net Event Detection"] then
		if eventId == NetEventID["GAME_CLOCK_EVENT"] or eventId == NetEventID["GAME_WEATHER_EVENT"] or eventId == NetEventID["GIVE_WEAPON_EVENT"] or eventId == NetEventID["REMOVE_WEAPON_EVENT"] or eventId == NetEventID["REMOVE_ALL_WEAPONS_EVENT"] or eventId == NetEventID["NETWORK_CLEAR_PED_TASKS_EVENT"] or eventId == NetEventID["NETWORK_START_PED_ARREST_EVENT"] or eventId == NetEventID["NETWORK_START_PED_UNCUFF_EVENT"] or eventId == NetEventID["SCRIPT_ENTITY_STATE_CHANGE_EVENT"] or eventId == NetEventID["GIVE_PICKUP_REWARDS_EVENT"] or eventId == NetEventID["NETWORK_CHECK_EXE_SIZE_EVENT"] or eventId == NetEventID["NETWORK_CHECK_CODE_CRCS_EVENT"] or eventId == NetEventID["PED_PLAY_PAIN_EVENT"] or eventId == NetEventID["REPORT_CASH_SPAWN_EVENT"] or eventId == NetEventID["NETWORK_CHECK_CATALOG_CRC"] then
			if (settings["» Exclude Friends From Detections"] and player.is_player_friend(source)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[source]) then
			else
				if feature["» Bad Net Event Detection"].value == 0 then
					if source ~= player.player_id() and player.is_player_valid(source) and not player.is_player_modder(source, custommodderflags["Bad Net Event"]) then
						menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Bad Net Event", "Modder Detection", 6, 0x00A2FF)
						player.set_player_as_modder(source, custommodderflags["Bad Net Event"])
					end
				elseif feature["» Bad Net Event Detection"].value == 1 then
					if source ~= player.player_id() and player.is_player_valid(source) then
						menu.notify("Player: " .. player.get_player_name(source) .. "\nReason: Bad Net Event", "Modder Detection", 6, 0x00A2FF)
					end
				elseif feature["» Bad Net Event Detection"].value == 2 then
					if source ~= player.player_id() and player.is_player_valid(source) and not player.is_player_modder(source, custommodderflags["Bad Net Event"]) then
						player.set_player_as_modder(source, custommodderflags["Bad Net Event"])
					end
				end
			end
		end
	end
	if target == player.player_id() then
		for i = 0, 87 do
			if settings["» Net Event Responses " .. i] and eventId == NetEventID[NetEventName[i]] then
				if source ~= player.player_id() and player.is_player_valid(source) then
					if feature["» Net Event Responses " .. i].value == 0 then
						fire.add_explosion(player.get_player_coords(source), 0, true, false, 0.1, player.get_player_ped(player.player_id()))
					elseif feature["» Net Event Responses " .. i].value == 1 then
						if network.network_is_host() then
							network.network_session_kick_player(source)
						elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
							utilities.se_kick(pid)
						else
							network.force_remove_player(source)
						end
					elseif feature["» Net Event Responses " .. i].value == 2 then
						if player.is_player_valid(source) then
							script.trigger_script_event(1445703181, source, {source, source, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), source})
						else
							menu.notify("[!] Invalid Player.", Meteor, 3, 211)
						end
					elseif feature["» Net Event Responses " .. i].value == 3 then
						utilities.send_to_brazil(source)
					end
				end
			end
		end
	end
end)

listeners["» Main Modder Event Listener"] = event.add_event_listener("modder", function(modder_player)
	if settings["» Auto Kick All Modders"] and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Any", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Manual"] and modder_player.flag == 1 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Manual", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Player Model"] and modder_player.flag == 2 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Player Model", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder SCID Spoof"] and modder_player.flag == 4 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: SCID Spoof", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Invalid Object"] and modder_player.flag == 8 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Invalid Object", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Invalid Ped Crash"] and modder_player.flag == 16 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Invalid Ped Crash", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Model Change Crash"] and modder_player.flag == 32 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Model Change Crash", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Player Model Change"] and modder_player.flag == 64 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Player Model Change", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder RAC"] and modder_player.flag == 128 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: RAC", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Money Drop"] and modder_player.flag == 256 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Money Drop", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder SEP"] and modder_player.flag == 512 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: SEP", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Attach Object"] and modder_player.flag == 1024 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Attach Object", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Attach Ped"] and modder_player.flag == 2048 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Attach Ped", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Net Array Crash"] and modder_player.flag == 4096 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Net Array Crash", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Net Sync Crash"] and modder_player.flag == 8192 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Net Sync Crash", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Net Event Crash"] and modder_player.flag == 16384 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Net Event Crash", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Altered Host Token"] and modder_player.flag == 32768 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Altered Host Token", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder SE Spam"] and modder_player.flag == 65536 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: SE Spam", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Invalid Vehicle"] and modder_player.flag == 131072 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Invalid Vehicle", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Frame Flags"] and modder_player.flag == 262144 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Frame Flags", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder IP Spoof"] and modder_player.flag == 524288 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: IP Spoof", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Karen"] and modder_player.flag == 1048576 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Karen", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Session Mismatch"] and modder_player.flag == 2097152 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Session Mismatch", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
	if settings["» Modder Sound Spam"] and modder_player.flag == 4194304 and player.is_player_valid(modder_player.player) and modder_player.player ~= player.player_id() then
		menu.notify("[!] Kicked Modder\nPlayer: " .. string.format("%s", player.get_player_name(modder_player.player)) .. "\nFlag: Sound Spam", Meteor, 6, 0x64FA7800)
		if network.network_is_host() then
			network.network_session_kick_player(modder_player.player)
		elseif player.is_player_host(modder_player.player) and player.is_player_modder(modder_player.player, -1) then
			utilities.se_kick(modder_player.player)
		else
			network.force_remove_player(modder_player.player)
		end
	end
end)

listeners["» Main Chat Event Listener"] = event.add_event_listener("chat", function(chat_message)
	if settings["» Anti Chat Spammer"] then
		SentXMessagesInTheLast5Seconds[chat_message.player] = SentXMessagesInTheLast5Seconds[chat_message.player] + 1
	end
	if settings["» Log Session Chat"] then
		local player_message_str = ""
		if chat_message.player == player.player_id() then
			player_message_str = player_message_str .. "Y"
		end
		if player.is_player_friend(chat_message.player) then
			player_message_str = player_message_str .. "F"
		end
		if player.is_player_modder(chat_message.player, -1) then
			player_message_str = player_message_str .. "M"
		end
		if utilities.is_player_rockstar_admin_scid(chat_message.player) or utilities.is_player_rockstar_admin_name(chat_message.player) or utilities.is_player_rockstar_admin_ip(chat_message.player) then
			player_message_str = player_message_str .. "A"
		end
		if player.is_player_host(0) then
			player_message_str = player_message_str .. "H"
		end
		if chat_message.player == script.get_host_of_this_script() then
			player_message_str = player_message_str .. "S"
		end
		if player.is_player_valid(chat_message.player) then
			utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\Logs\\", "") .. "\\Chat.log", "a"), "" .. os.date() .. " | " .. utilities.dec_to_ipv4(player.get_player_ip(chat_message.player)) .. " | " .. player.get_player_scid(chat_message.player) .. " | [" .. player_message_str .. "] " .. player.get_player_name(chat_message.player) .. " >> " .. chat_message.body .. "\n")
		end
	end
	if settings["» Notify Sent Messages"] then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(chat_message.player)) .. "\nMessage: " .. chat_message.body .. "", Meteor, 2, 0x64FA7800)
	end
	if settings["» Chat Spoof Notification"] then
		if did_someone_type and meteor_session_timer < utils.time_ms() and player.player_id() ~= chat_message.player and not HasBeenTyping[chat_message.player] and not entity.is_entity_dead(player.get_player_ped(chat_message.player)) and not player.is_player_modder(chat_message.player, -1) and not utilities.is_player_in_interior(chat_message.player) then
			local player_table = {}
			for pid = 0, 31 do
				if player.player_id() ~= pid and player.is_player_valid(pid) and player.get_player_modder_flags(pid) ~= 0 and player.get_player_modder_flags(pid) ~= 512 and player.get_player_modder_flags(pid) ~= custommodderflags["Godmode"] and utilities.get_distance_between(player.get_player_coords(player.player_id()), player.get_player_coords(pid)) > 500 and not utilities.is_player_typing(pid) and not utilities.is_player_in_interior(pid) then
					table.insert(player_table, player.get_player_ped(pid))
				end
			end
			if #player_table == 0 then
				for pid = 0, 31 do
					if player.player_id() ~= pid and player.is_player_valid(pid) and player.get_player_modder_flags(pid) ~= 0 and player.get_player_modder_flags(pid) ~= 512 and player.get_player_modder_flags(pid) ~= custommodderflags["Godmode"] and utilities.get_distance_between(player.get_player_coords(player.player_id()), player.get_player_coords(pid)) > 500 and not utilities.is_player_typing(pid) then
						table.insert(player_table, player.get_player_ped(pid))
					end
				end
				if #player_table == 0 then
					for pid = 0, 31 do
						if player.player_id() ~= pid and player.is_player_valid(pid) and utilities.get_distance_between(player.get_player_coords(player.player_id()), player.get_player_coords(pid)) < 100 and not utilities.is_player_typing(pid) then
							table.insert(player_table, player.get_player_ped(pid))
						end
					end
					if #player_table == 0 then
						chat_spoof_detection_possible_executor = "Unknown"
					else
						table.sort(player_table, function(a, b) 
							return (utilities.get_distance_between(a, player.get_player_coords(player.player_id())) < utilities.get_distance_between(b, player.get_player_coords(player.player_id())))
						end)
						chat_spoof_detection_possible_executor = player.get_player_from_ped(player_table[1])
					end
				else
					table.sort(player_table, function(a, b) 
						return (utilities.get_distance_between(a, player.get_player_coords(player.player_id())) < utilities.get_distance_between(b, player.get_player_coords(player.player_id())))
					end)
					chat_spoof_detection_possible_executor = player.get_player_from_ped(player_table[1])
				end
			else
				table.sort(player_table, function(a, b) 
					return (utilities.get_distance_between(a, player.get_player_coords(player.player_id())) < utilities.get_distance_between(b, player.get_player_coords(player.player_id())))
				end)
				chat_spoof_detection_possible_executor = player.get_player_from_ped(player_table[1])
			end
			if chat_spoof_detection_possible_executor == "Unknown" then
				menu.notify("[!] Spoofed Chat Message Detected!\nPossible Executor: Unknown\nVictim: " .. string.format("%s", player.get_player_name(chat_message.player)) .. "\nMessage: " .. chat_message.body, Meteor, 8, 0x00A2FF)
			else
				menu.notify("[!] Spoofed Chat Message Detected!\nPossible Executor: " .. string.format("%s", player.get_player_name(chat_spoof_detection_possible_executor)) .. "\nVictim: " .. string.format("%s", player.get_player_name(chat_message.player)) .. "\nMessage: " .. chat_message.body, Meteor, 8, 0x00A2FF)
			end
		end
	end
end)

listeners["» Main Player Leave Event Listener"] = event.add_event_listener("player_leave", function(left_player)
	altered_sh_migration_detection_timer_left_player = utils.time_ms() + 4000
	IsPlayerWhitelisted[left_player.player] = false
	local my_pid = player.player_id()
	if left_player.player == my_pid then
		meteor_session_timer = utils.time_ms() + 15000
		did_someone_type = false
		my_pid = player.player_id()
	end
	InvalidSCIDDetectionPlayer[left_player.player] = false
	ModdedHealthDetectionPlayer[left_player.player] = false
	GodmodeDetectionPlayer[left_player.player] = false
	InvalidNameDetectionPlayer[left_player.player] = false
	InvalidIPDetectionPlayer[left_player.player] = false
	StandUserDetectionPlayer[left_player.player] = false
	MaxSpeedBypassDetectionPlayer[left_player.player] = false
	InvalidStatsDetectionPlayer[left_player.player] = false
	SessionHostCrashDetectionPlayer[left_player.player] = false
	BadOutfitDataDetectionPlayer[left_player.player] = false
	FakeTypingIndicatorDetectionPlayer[left_player.player] = false
	ModdedSpectateDetectionPlayer[left_player.player] = false
	ModdedOTRDetectionPlayer[left_player.player] = false
	IsOTRFor[left_player.player] = 0
	if settings["» Log Session Change"] then
		if left_player.player == player.player_id() and player.is_player_valid(left_player.player) then
		   utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\Logs\\", "") .. "\\Chat.log", "a"), "# # # # # | You Left The Session | " .. os.date() .. " | # # # # #\n")
		end
	end
end)

listeners["» Main Player Join Event Listener"] = event.add_event_listener("player_join", function(joined_player)
	if joined_player.player == player.player_id() then
		meteor_session_timer = utils.time_ms() + 15000
		did_someone_type = false
	else
		meteor_session_timer = utils.time_ms() + 4000
		did_someone_type = false
	end
	if joined_player.player == player.player_id() then
		altered_sh_migration_detection_timer = utils.time_ms() + 8000
	end
	if settings["» Log Session Change"] then
		if joined_player.player == player.player_id() and player.is_player_valid(joined_player.player) then
			system.wait(1000)
			utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\Logs\\", "") .. "\\Chat.log", "a"), "# # # # # | You Joined A New Session | " .. os.date() .. " | # # # # #\n")
		end
	end
	if settings["» Rockstar Admin Notification"] then
		if utilities.is_player_rockstar_admin_scid(joined_player.player) or utilities.is_player_rockstar_admin_name(joined_player.player) or utilities.is_player_rockstar_admin_ip(joined_player.player) then
			if (settings["» Exclude Friends From Detections"] and player.is_player_friend(joined_player.player)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[joined_player.player]) then
			else
				menu.notify("[!] A Rockstar Admin has been detected in your session!\n\nName: " .. player.get_player_name(joined_player.player) .. "\nSCID: " .. player.get_player_scid(joined_player.player) .. "\nIP: " .. utilities.dec_to_ipv4(player.get_player_ip(joined_player.player)) .. "\nHost Token: " .. select(1, string.format("%x", player.get_player_host_token(joined_player.player))) .. "\nHost Priority: " .. player.get_player_host_priority(joined_player.player) .. "", Meteor, 8, 0x00A2FF)
			end
		end
	end
end)

--

custommodderflags["Modded Health"] = player.add_modder_flag("Modded Health")
custommodderflags["Invalid SCID"] = player.add_modder_flag("Invalid SCID")
custommodderflags["Invalid Name"] = player.add_modder_flag("Invalid Name")
custommodderflags["Godmode"] = player.add_modder_flag("Godmode")
custommodderflags["Bad Script Event"] = player.add_modder_flag("Bad Script Event")
custommodderflags["Bad Net Event"] = player.add_modder_flag("Bad Net Event")
custommodderflags["Stand User"] = player.add_modder_flag("Stand User")
custommodderflags["Invalid Stats"] = player.add_modder_flag("Invalid Stats")
custommodderflags["Max Speed Bypass"] = player.add_modder_flag("Max Speed Bypass")
custommodderflags["Invalid IP"] = player.add_modder_flag("Invalid IP")
custommodderflags["Session Host Crash"] = player.add_modder_flag("Session Host Crash")
custommodderflags["Bad Outfit Data"] = player.add_modder_flag("Bad Outfit Data")
custommodderflags["Altered SH Migration"] = player.add_modder_flag("Altered SH Migration")
custommodderflags["Fake Typing Indicator"] = player.add_modder_flag("Fake Typing Indicator")
custommodderflags["Modded Spectate"] = player.add_modder_flag("Modded Spectate")
custommodderflags["Modded OTR"] = player.add_modder_flag("Modded OTR")

--

localparents["» Meteor"] = menu.add_feature("» Meteor", "parent", 0).id

localparents["» Player Options"] = menu.add_feature("» Player Options", "parent", localparents["» Meteor"])
localparents["» Miscellaneous"] = menu.add_feature("» Miscellaneous", "parent", localparents["» Meteor"])
localparents["» Session Malicious"] = menu.add_feature("» Session Malicious", "parent", localparents["» Meteor"])
localparents["» Session Trolling"] = menu.add_feature("» Session Trolling", "parent", localparents["» Meteor"])
localparents["» Gameplay Utilities"] = menu.add_feature("» Gameplay Utilities", "parent", localparents["» Meteor"])
localparents["» Vehicle Options"] = menu.add_feature("» Vehicle Options", "parent", localparents["» Meteor"])
localparents["» Spawn Animals"] = menu.add_feature("» Spawn Animals", "parent", localparents["» Meteor"])
localparents["» Detections"] = menu.add_feature("» Detections", "parent", localparents["» Meteor"])
localparents["» Teleporter"] = menu.add_feature("» Teleporter", "parent", localparents["» Meteor"])
localparents["» Custom Scaleforms"] = menu.add_feature("» Custom Scaleforms", "parent", localparents["» Meteor"])
localparents["» Chat Logger"] = menu.add_feature("» Chat Logger", "parent", localparents["» Meteor"])
localparents["» General"] = menu.add_feature("» General", "parent", localparents["» Meteor"])


playerparents["» Meteor"] = menu.add_player_feature("» Meteor", "parent", 0).id

playerparents["» Script Events"] = menu.add_player_feature("» Script Events", "parent", playerparents["» Meteor"]).id
playerparents["» Malicious"] = menu.add_player_feature("» Malicious", "parent", playerparents["» Meteor"]).id
playerparents["» Trolling"] = menu.add_player_feature("» Trolling", "parent", playerparents["» Meteor"]).id
playerparents["» Vehicle"] = menu.add_player_feature("» Vehicle", "parent", playerparents["» Meteor"]).id
playerparents["» Spawn"] = menu.add_player_feature("» Spawn", "parent", playerparents["» Meteor"]).id
playerparents["» Sounds"] = menu.add_player_feature("» Sounds", "parent", playerparents["» Meteor"]).id
playerparents["» Crashes/Kicks"] = menu.add_player_feature("» Crashes/Kicks", "parent", playerparents["» Meteor"]).id
playerparents["» Copy Info"] = menu.add_player_feature("» Copy Info", "parent", playerparents["» Meteor"]).id
playerparents["» Modder Options"] = menu.add_player_feature("» Modder Options", "parent", playerparents["» Meteor"]).id

--

menu.add_feature("» Fill Health", "action", localparents["» Player Options"].id, function(f)
	ped.set_ped_health(player.get_player_ped(player.player_id()), ped.get_ped_max_health(player.get_player_ped(player.player_id())))
end)

menu.add_feature("» Set Health", "action", localparents["» Player Options"].id, function(f)
	local input_stat, input_val = input.get("Enter Health", "", 10, 5)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end
	ped.set_ped_health(player.get_player_ped(player.player_id()), input_val)
end)

menu.add_feature("» Ragdoll", "action", localparents["» Player Options"].id, function(f)
	ped.set_ped_to_ragdoll(player.get_player_ped(player.player_id()), 1000, 1000, 0)
end)

feature["» Dragon Breath"] = menu.add_feature("» Dragon Breath", "slider", localparents["» Player Options"].id, function(f)
	if f.on then
		settings["» Dragon Breath"] = true
		settings["» Dragon Breath Scale"] = f.value
		if ptfxs["» Dragon Breath"] == nil then
			if objects["» Dragon Breath"] == nil then
				objects["» Dragon Breath"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Dragon Breath"], false, false, false)
				entity.set_entity_visible(objects["» Dragon Breath"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
			while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
				graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
				system.wait(0)
			end
			ptfxs["» Dragon Breath"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Dragon Breath"], v3(0, 0.07, 0.625), v3(0, 0, 0), f.value)
			graphics.set_ptfx_looped_scale(ptfxs["» Dragon Breath"], f.value)

			while f.on do
				utilities.set_entity_coords(objects["» Dragon Breath"], player.get_player_coords(player.player_id()))
				entity.set_entity_rotation(objects["» Dragon Breath"], entity.get_entity_rotation(player.get_player_ped(player.player_id())))
				system.yield(0)
			end
		end
	end
	if not f.on then
		if ptfxs["» Dragon Breath"] then
			graphics.remove_particle_fx(ptfxs["» Dragon Breath"], true)
			ptfxs["» Dragon Breath"] = nil
		end
		if objects["» Dragon Breath"] then
			utilities.clear_ptfx_ptfx(objects["» Dragon Breath"])
			objects["» Dragon Breath"] = nil
		end
		graphics.remove_named_ptfx_asset("weap_xs_vehicle_weapons")
		settings["» Dragon Breath"] = false
		settings["» Dragon Breath Scale"] = f.value
	end
end)
feature["» Dragon Breath"].max = 1
feature["» Dragon Breath"].min = 0.1
feature["» Dragon Breath"].mod = 0.1
feature["» Dragon Breath"].value = settings["» Dragon Breath Scale"]
feature["» Dragon Breath"].on = settings["» Dragon Breath"]

feature["» Fire Wings"] = menu.add_feature("» Fire Wings", "slider", localparents["» Player Options"].id, function(f)
	if f.on then
		settings["» Fire Wings"] = true
		settings["» Fire Wings Scale"] = f.value
		if ptfxs["» Fire Wings 1"] == nil then
			if objects["» Fire Wings 1"] == nil then
				objects["» Fire Wings 1"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Fire Wings 1"], false, false, false)
				entity.set_entity_visible(objects["» Fire Wings 1"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
			while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
				graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
				system.wait(0)
			end
			ptfxs["» Fire Wings 1"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Fire Wings 1"], v3(0, 0, 0.1), v3(120, 0, 75), f.value)
			graphics.set_ptfx_looped_scale(ptfxs["» Fire Wings 1"], f.value)

			threads["» Fire Wings 1"] = menu.create_thread(function()
				while f.on do
					utilities.set_entity_coords(objects["» Fire Wings 1"], player.get_player_coords(player.player_id()))
					entity.set_entity_rotation(objects["» Fire Wings 1"], entity.get_entity_rotation(player.get_player_ped(player.player_id())))
					system.yield(0)
				end
			end, nil)
		end
		if ptfxs["» Fire Wings 2"] == nil then
			if objects["» Fire Wings 2"] == nil then
				objects["» Fire Wings 2"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Fire Wings 2"], false, false, false)
				entity.set_entity_visible(objects["» Fire Wings 2"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
			while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
				graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
				system.wait(0)
			end
			ptfxs["» Fire Wings 2"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Fire Wings 2"], v3(0, 0, 0.1), v3(120, 0, -75), f.value)
			graphics.set_ptfx_looped_scale(ptfxs["» Fire Wings 2"], f.value)

			threads["» Fire Wings 2"] = menu.create_thread(function()
				while f.on do
					utilities.set_entity_coords(objects["» Fire Wings 2"], player.get_player_coords(player.player_id()))
					entity.set_entity_rotation(objects["» Fire Wings 2"], entity.get_entity_rotation(player.get_player_ped(player.player_id())))
					system.yield(0)
				end
			end, nil)
		end
		if ptfxs["» Fire Wings 3"] == nil then
			if objects["» Fire Wings 3"] == nil then
				objects["» Fire Wings 3"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Fire Wings 3"], false, false, false)
				entity.set_entity_visible(objects["» Fire Wings 3"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
			while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
				graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
				system.wait(0)
			end
			ptfxs["» Fire Wings 3"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Fire Wings 3"], v3(0, 0, 0.1), v3(135, 0, 75), f.value)
			graphics.set_ptfx_looped_scale(ptfxs["» Fire Wings 3"], f.value)

			threads["» Fire Wings 3"] = menu.create_thread(function()
				while f.on do
					utilities.set_entity_coords(objects["» Fire Wings 3"], player.get_player_coords(player.player_id()))
					entity.set_entity_rotation(objects["» Fire Wings 3"], entity.get_entity_rotation(player.get_player_ped(player.player_id())))
					system.yield(0)
				end
			end, nil)
		end
		if ptfxs["» Fire Wings 4"] == nil then
			if objects["» Fire Wings 4"] == nil then
				objects["» Fire Wings 4"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Fire Wings 4"], false, false, false)
				entity.set_entity_visible(objects["» Fire Wings 4"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
			while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
				graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
				system.wait(0)
			end
			ptfxs["» Fire Wings 4"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Fire Wings 4"], v3(0, 0, 0.1), v3(135, 0, -75), f.value)
			graphics.set_ptfx_looped_scale(ptfxs["» Fire Wings 4"], f.value)

			threads["» Fire Wings 4"] = menu.create_thread(function()
				while f.on do
					utilities.set_entity_coords(objects["» Fire Wings 4"], player.get_player_coords(player.player_id()))
					entity.set_entity_rotation(objects["» Fire Wings 4"], entity.get_entity_rotation(player.get_player_ped(player.player_id())))
					system.yield(0)
				end
			end, nil)
		end
		if ptfxs["» Fire Wings 5"] == nil then
			if objects["» Fire Wings 5"] == nil then
				objects["» Fire Wings 5"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Fire Wings 5"], false, false, false)
				entity.set_entity_visible(objects["» Fire Wings 5"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
			while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
				graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
				system.wait(0)
			end
			ptfxs["» Fire Wings 5"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Fire Wings 5"], v3(0, 0, 0.1), v3(180, 0, 75), f.value)
			graphics.set_ptfx_looped_scale(ptfxs["» Fire Wings 5"], f.value)

			threads["» Fire Wings 5"] = menu.create_thread(function()
				while f.on do
					utilities.set_entity_coords(objects["» Fire Wings 5"], player.get_player_coords(player.player_id()))
					entity.set_entity_rotation(objects["» Fire Wings 5"], entity.get_entity_rotation(player.get_player_ped(player.player_id())))
					system.yield(0)
				end
			end, nil)
		end
		if ptfxs["» Fire Wings 6"] == nil then
			if objects["» Fire Wings 6"] == nil then
				objects["» Fire Wings 6"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Fire Wings 6"], false, false, false)
				entity.set_entity_visible(objects["» Fire Wings 6"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
			while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
				graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
				system.wait(0)
			end
			ptfxs["» Fire Wings 6"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Fire Wings 6"], v3(0, 0, 0.1), v3(180, 0, -75), f.value)
			graphics.set_ptfx_looped_scale(ptfxs["» Fire Wings 6"], f.value)

			threads["» Fire Wings 6"] = menu.create_thread(function()
				while f.on do
					utilities.set_entity_coords(objects["» Fire Wings 6"], player.get_player_coords(player.player_id()))
					entity.set_entity_rotation(objects["» Fire Wings 6"], entity.get_entity_rotation(player.get_player_ped(player.player_id())))
					system.yield(0)
				end
			end, nil)
		end
		if ptfxs["» Fire Wings 7"] == nil then
			if objects["» Fire Wings 7"] == nil then
				objects["» Fire Wings 7"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Fire Wings 7"], false, false, false)
				entity.set_entity_visible(objects["» Fire Wings 7"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
			while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
				graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
				system.wait(0)
			end
			ptfxs["» Fire Wings 7"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Fire Wings 7"], v3(0, 0, 0.1), v3(195, 0, 75), f.value)
			graphics.set_ptfx_looped_scale(ptfxs["» Fire Wings 7"], f.value)

			threads["» Fire Wings 7"] = menu.create_thread(function()
				while f.on do
					utilities.set_entity_coords(objects["» Fire Wings 7"], player.get_player_coords(player.player_id()))
					entity.set_entity_rotation(objects["» Fire Wings 7"], entity.get_entity_rotation(player.get_player_ped(player.player_id())))
					system.yield(0)
				end
			end, nil)
		end
		if ptfxs["» Fire Wings 8"] == nil then
			if objects["» Fire Wings 8"] == nil then
				objects["» Fire Wings 8"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Fire Wings 8"], false, false, false)
				entity.set_entity_visible(objects["» Fire Wings 8"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
			while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
				graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
				system.wait(0)
			end
			ptfxs["» Fire Wings 8"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Fire Wings 8"], v3(0, 0, 0.1), v3(195, 0, -75), f.value)
			graphics.set_ptfx_looped_scale(ptfxs["» Fire Wings 8"], f.value)

			threads["» Fire Wings 8"] = menu.create_thread(function()
				while f.on do
					utilities.set_entity_coords(objects["» Fire Wings 8"], player.get_player_coords(player.player_id()))
					entity.set_entity_rotation(objects["» Fire Wings 8"], entity.get_entity_rotation(player.get_player_ped(player.player_id())))
					system.yield(0)
				end
			end, nil)
		end
	end
	if not f.on then
		if ptfxs["» Fire Wings 1"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 1"], true)
			ptfxs["» Fire Wings 1"] = nil
			utilities.clear_ptfx(objects["» Fire Wings 1"])
			objects["» Fire Wings 1"] = nil
		end
		if ptfxs["» Fire Wings 2"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 2"], true)
			ptfxs["» Fire Wings 2"] = nil
			utilities.clear_ptfx(objects["» Fire Wings 2"])
			objects["» Fire Wings 2"] = nil
		end
		if ptfxs["» Fire Wings 3"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 3"], true)
			ptfxs["» Fire Wings 3"] = nil
			utilities.clear_ptfx(objects["» Fire Wings 3"])
			objects["» Fire Wings 3"] = nil
		end
		if ptfxs["» Fire Wings 4"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 4"], true)
			ptfxs["» Fire Wings 4"] = nil
			utilities.clear_ptfx(objects["» Fire Wings 4"])
			objects["» Fire Wings 4"] = nil
		end
		if ptfxs["» Fire Wings 5"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 5"], true)
			ptfxs["» Fire Wings 5"] = nil
			utilities.clear_ptfx(objects["» Fire Wings 5"])
			objects["» Fire Wings 5"] = nil
		end
		if ptfxs["» Fire Wings 6"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 6"], true)
			ptfxs["» Fire Wings 6"] = nil
			utilities.clear_ptfx(objects["» Fire Wings 6"])
			objects["» Fire Wings 6"] = nil
		end
		if ptfxs["» Fire Wings 7"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 7"], true)
			ptfxs["» Fire Wings 7"] = nil
			utilities.clear_ptfx(objects["» Fire Wings 7"])
			objects["» Fire Wings 7"] = nil
		end
		if ptfxs["» Fire Wings 8"] then
			graphics.remove_particle_fx(ptfxs["» Fire Wings 8"], true)
			ptfxs["» Fire Wings 8"] = nil
			utilities.clear_ptfx(objects["» Fire Wings 8"])
			objects["» Fire Wings 8"] = nil
		end
		menu.delete_thread(threads["» Fire Wings 1"])
		menu.delete_thread(threads["» Fire Wings 2"])
		menu.delete_thread(threads["» Fire Wings 3"])
		menu.delete_thread(threads["» Fire Wings 4"])
		menu.delete_thread(threads["» Fire Wings 5"])
		menu.delete_thread(threads["» Fire Wings 6"])
		menu.delete_thread(threads["» Fire Wings 7"])
		menu.delete_thread(threads["» Fire Wings 8"])
		graphics.remove_named_ptfx_asset("weap_xs_vehicle_weapons")
		settings["» Fire Wings Scale"] = f.value
		settings["» Fire Wings"] = false
	end
end)
feature["» Fire Wings"].max = 1
feature["» Fire Wings"].min = 0.1
feature["» Fire Wings"].mod = 0.1
feature["» Fire Wings"].value = settings["» Fire Wings Scale"]
feature["» Fire Wings"].on = settings["» Fire Wings"]

menu.add_feature("» Lock Outfit", "toggle", localparents["» Player Options"].id, function(f)
	if f.on then
		local outfit_component_0 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 0)
		local outfit_component_1 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 1)
		local outfit_component_2 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 2)
		local outfit_component_3 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 3)
		local outfit_component_4 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 4)
		local outfit_component_5 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 5)
		local outfit_component_6 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 6)
		local outfit_component_7 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 7)
		local outfit_component_8 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 8)
		local outfit_component_9 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 9)
		local outfit_component_10 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 10)
		local outfit_component_11 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 11)
		local outfit_texture_0 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 0)
		local outfit_texture_1 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 1)
		local outfit_texture_2 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 2)
		local outfit_texture_3 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 3)
		local outfit_texture_4 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 4)
		local outfit_texture_5 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 5)
		local outfit_texture_6 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 6)
		local outfit_texture_7 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 7)
		local outfit_texture_8 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 8)
		local outfit_texture_9 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 9)
		local outfit_texture_10 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 10)
		local outfit_texture_11 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 11)
		local outfit_prop_0 = ped.get_ped_prop_index(player.get_player_ped(player.player_id()), 0)
		local outfit_prop_1 = ped.get_ped_prop_index(player.get_player_ped(player.player_id()), 1)
		local outfit_prop_2 = ped.get_ped_prop_index(player.get_player_ped(player.player_id()), 2)
		local outfit_prop_texture_0 = ped.get_ped_prop_texture_index(player.get_player_ped(player.player_id()), 0)
		local outfit_prop_texture_1 = ped.get_ped_prop_texture_index(player.get_player_ped(player.player_id()), 1)
		local outfit_prop_texture_2 = ped.get_ped_prop_texture_index(player.get_player_ped(player.player_id()), 2)
		while f.on do
			system.yield(100)
			if ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 0) ~= outfit_component_0 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 1) ~= outfit_component_1 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 2) ~= outfit_component_2 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 3) ~= outfit_component_3 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 4) ~= outfit_component_4 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 5) ~= outfit_component_5 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 6) ~= outfit_component_6 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 7) ~= outfit_component_7 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 8) ~= outfit_component_8 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 9) ~= outfit_component_9 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 10) ~= outfit_component_10 or ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 11) ~= outfit_component_11 or ped.get_ped_prop_index(player.get_player_ped(player.player_id()), 0) ~= outfit_prop_0 or ped.get_ped_prop_index(player.get_player_ped(player.player_id()), 1) ~= outfit_prop_1 or ped.get_ped_prop_index(player.get_player_ped(player.player_id()), 2) ~= outfit_prop_2 then
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 0, outfit_component_0, outfit_texture_0, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 1, outfit_component_1, outfit_texture_1, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 2, outfit_component_2, outfit_texture_2, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 3, outfit_component_3, outfit_texture_3, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 4, outfit_component_4, outfit_texture_4, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 5, outfit_component_5, outfit_texture_5, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 6, outfit_component_6, outfit_texture_6, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 7, outfit_component_7, outfit_texture_7, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 8, outfit_component_8, outfit_texture_8, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 9, outfit_component_9, outfit_texture_9, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 10, outfit_component_10, outfit_texture_10, 0)
				ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 11, outfit_component_11, outfit_texture_11, 0)
				ped.set_ped_prop_index(player.get_player_ped(player.player_id()), 0, outfit_prop_0, outfit_prop_texture_0, 0)
				ped.set_ped_prop_index(player.get_player_ped(player.player_id()), 1, outfit_prop_1, outfit_prop_texture_1, 0)
				ped.set_ped_prop_index(player.get_player_ped(player.player_id()), 2, outfit_prop_2, outfit_prop_texture_2, 0)
			end
		end
	end
end)

localparents["» Hand Trails"] = menu.add_feature("» Hand Trails", "parent", localparents["» Player Options"].id)

feature["» Sparks"] = menu.add_feature("» Sparks", "toggle", localparents["» Hand Trails"].id, function(f)
	if f.on then
		settings["» Sparks"] = true
		if ptfxs["» Sparks 1"] == nil then
			if objects["» Sparks 1"] == nil then
				objects["» Sparks 1"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Sparks 1"], false, false, false)
				entity.set_entity_visible(objects["» Sparks 1"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("scr_reconstructionaccident")
			while not graphics.has_named_ptfx_asset_loaded("scr_reconstructionaccident") do
				graphics.request_named_ptfx_asset("scr_reconstructionaccident")
				system.wait(0)
			end
			ptfxs["» Sparks 1"] = graphics.start_networked_ptfx_looped_on_entity("scr_sparking_generator", objects["» Sparks 1"], v3(0, 0, 0), v3(120, 0, 75), 2)
			graphics.set_ptfx_looped_scale(ptfxs["» Sparks 1"], 2)
		end
		if ptfxs["» Sparks 2"] == nil then
			if objects["» Sparks 2"] == nil then
				objects["» Sparks 2"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Sparks 2"], false, false, false)
				entity.set_entity_visible(objects["» Sparks 2"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("scr_reconstructionaccident")
			while not graphics.has_named_ptfx_asset_loaded("scr_reconstructionaccident") do
				graphics.request_named_ptfx_asset("scr_reconstructionaccident")
				system.wait(0)
			end
			ptfxs["» Sparks 2"] = graphics.start_networked_ptfx_looped_on_entity("scr_sparking_generator", objects["» Sparks 2"], v3(0, 0, 0), v3(120, 0, 75), 2)
			graphics.set_ptfx_looped_scale(ptfxs["» Sparks 2"], 2)
		end
		graphics.remove_named_ptfx_asset("scr_reconstructionaccident")
		while f.on do
			system.yield(0)
			local success, pos_1 = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 26612, v3())
			while not success do
				success, pos_1 = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 26612, v3())
				system.wait(0)
			end
			utilities.set_entity_coords(objects["» Sparks 1"], pos_1)
			local success, pos_2 = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 58868, v3())
			while not success do
				success, pos_2 = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 58868, v3())
				system.wait(0)
			end
			utilities.set_entity_coords(objects["» Sparks 2"], pos_2)
		end
	end
	if not f.on then
		if ptfxs["» Sparks 1"] then
			graphics.remove_particle_fx(ptfxs["» Sparks 1"], true)
			ptfxs["» Sparks 1"] = nil
			graphics.remove_particle_fx(ptfxs["» Sparks 2"], true)
			ptfxs["» Sparks 2"] = nil
			graphics.remove_particle_fx(objects["» Sparks 1"], true)
			objects["» Sparks 1"] = nil
			utilities.clear_ptfx(objects["» Sparks 1"])
			objects["» Sparks 1"] = nil
			graphics.remove_particle_fx(objects["» Sparks 2"], true)
			objects["» Sparks 2"] = nil
			utilities.clear_ptfx(objects["» Sparks 2"])
			objects["» Sparks 2"] = nil
			graphics.remove_named_ptfx_asset("scr_reconstructionaccident")
			settings["» Sparks"] = false
		end
	end
end)
feature["» Sparks"].on = settings["» Sparks"]

feature["» Sparks Gun Effects"] = menu.add_feature("» Sparks Gun Effects", "toggle", localparents["» Hand Trails"].id, function(f)
	if f.on then
		settings["» Sparks Gun Effects"] = true
		while f.on do
			system.wait(0)
			if settings["» Sparks"] and ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
				threads["» Sparks Gun Effects"] = menu.create_thread(function()
					local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
					while not success do
						success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
						system.wait(0)
					end
					graphics.set_next_ptfx_asset("scr_trevor1")
					while not graphics.has_named_ptfx_asset_loaded("scr_trevor1") do
						graphics.request_named_ptfx_asset("scr_trevor1")
						system.wait(0)
					end
					graphics.start_networked_ptfx_non_looped_at_coord("scr_trev1_trailer_boosh", pos, v3(), 0.8, true, true, true)
					gameplay.shoot_single_bullet_between_coords(pos, pos + v3(0, 0, 0.2), 1, gameplay.get_hash_key("weapon_stungun"), player.player_id(), false, true, 2000)
				end, nil)
			end
		end
	end
	if not f.on then
		graphics.remove_named_ptfx_asset("scr_trevor1")
		if threads["» Sparks Gun Effects"] then
			menu.delete_thread(threads["» Sparks Gun Effects"])
		end
		settings["» Sparks Gun Effects"] = false
	end
end)
feature["» Sparks Gun Effects"].on = settings["» Sparks Gun Effects"]

feature["» Flames"] = menu.add_feature("» Flames", "toggle", localparents["» Hand Trails"].id, function(f)
	if f.on then
		settings["» Flames"] = true
		if ptfxs["» Flames 1"] == nil then
			if objects["» Flames 1"] == nil then
				objects["» Flames 1"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Flames 1"], false, false, false)
				entity.set_entity_visible(objects["» Flames 1"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("core")
			while not graphics.has_named_ptfx_asset_loaded("core") do
				graphics.request_named_ptfx_asset("core")
				system.wait(0)
			end
			ptfxs["» Flames 1"] = graphics.start_networked_ptfx_looped_on_entity("fire_wrecked_tank", objects["» Flames 1"], v3(0, 0, -0.1), v3(0, 0, 0), 0.2)
			graphics.set_ptfx_looped_scale(ptfxs["» Flames 1"], 0.2)
		end
		if ptfxs["» Flames 2"] == nil then
			if objects["» Flames 2"] == nil then
				objects["» Flames 2"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
				entity.set_entity_collision(objects["» Flames 2"], false, false, false)
				entity.set_entity_visible(objects["» Flames 2"], false)
				streaming.set_model_as_no_longer_needed(1803116220)
			end
			graphics.set_next_ptfx_asset("core")
			while not graphics.has_named_ptfx_asset_loaded("core") do
				graphics.request_named_ptfx_asset("core")
				system.wait(0)
			end
			ptfxs["» Flames 2"] = graphics.start_networked_ptfx_looped_on_entity("fire_wrecked_tank", objects["» Flames 2"], v3(0, 0, -0.1), v3(0, 0, 0), 0.2)
			graphics.set_ptfx_looped_scale(ptfxs["» Flames 2"], 0.2)
		end
		graphics.remove_named_ptfx_asset("core")
		while f.on do
			system.yield(0)
			local success, pos_1 = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 26612, v3())
			while not success do
				success, pos_1 = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 26612, v3())
				system.wait(0)
			end
			utilities.set_entity_coords(objects["» Flames 1"], pos_1)
			local success, pos_2 = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 58868, v3())
			while not success do
				success, pos_2 = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 58868, v3())
				system.wait(0)
			end
			utilities.set_entity_coords(objects["» Flames 2"], pos_2)
		end
	end
	if not f.on then
		if ptfxs["» Flames 1"] then
			graphics.remove_particle_fx(ptfxs["» Flames 1"], true)
			ptfxs["» Flames 1"] = nil
			graphics.remove_particle_fx(ptfxs["» Flames 2"], true)
			ptfxs["» Flames 2"] = nil
			graphics.remove_particle_fx(objects["» Flames 1"], true)
			objects["» Flames 1"] = nil
			utilities.clear_ptfx(objects["» Flames 1"])
			objects["» Flames 1"] = nil
			graphics.remove_particle_fx(objects["» Flames 2"], true)
			objects["» Flames 2"] = nil
			utilities.clear_ptfx(objects["» Flames 2"])
			objects["» Flames 2"] = nil
			graphics.remove_named_ptfx_asset("core")
			settings["» Flames"] = false
		end
	end
end)
feature["» Flames"].on = settings["» Flames"]

feature["» Flames Gun Effects"] = menu.add_feature("» Flames Gun Effects", "toggle", localparents["» Hand Trails"].id, function(f)
	if f.on then
		settings["» Flames Gun Effects"] = true
		while f.on do
			system.wait(0)
			if settings["» Flames"] and ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
				threads["» Flames Gun Effects"] = menu.create_thread(function()
					local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
					while not success do
						success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
						system.wait(0)
					end
					graphics.set_next_ptfx_asset("core")
					while not graphics.has_named_ptfx_asset_loaded("core") do
						graphics.request_named_ptfx_asset("core")
						system.wait(0)
					end
					graphics.start_networked_ptfx_non_looped_at_coord("exp_air_molotov_lod", pos, v3(), 0.5, true, true, true)
					fire.start_entity_fire(player.get_entity_player_is_aiming_at(player.player_id()))
				end, nil)
			end
		end
	end
	if not f.on then
		graphics.remove_named_ptfx_asset("core")
		if threads["» Flames Gun Effects"] then
			menu.delete_thread(threads["» Flames Gun Effects"])
		end
		settings["» Flames Gun Effects"] = false
	end
end)
feature["» Flames Gun Effects"].on = settings["» Flames Gun Effects"]

localparents["» Weapon Modifiers"] = menu.add_feature("» Weapon Modifiers", "parent", localparents["» Player Options"].id)

menu.add_feature("» Rapid Fire", "toggle", localparents["» Weapon Modifiers"].id, function(f)
    if f.on then
		settings["» Rapid Fire"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) and not player.is_player_in_any_vehicle(player.player_id()) then
				for i = 1, 25 do
					local success, v3_start = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 0x67f2, v3())
					while not success do
						success, v3_start = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 0x67f2, v3())
						system.wait(0)
					end
					local dir = cam.get_gameplay_cam_rot()
					dir:transformRotToDir()
					dir = dir * 1.5
					v3_start = v3_start + dir
					dir = nil
					local v3_end = player.get_player_coords(player.player_id())
					dir = cam.get_gameplay_cam_rot()
					dir:transformRotToDir()
					dir = dir * 1500
					v3_end = v3_end + dir
					local hash_weapon = ped.get_current_ped_weapon(player.get_player_ped(player.player_id()))
					gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, hash_weapon, player.get_player_ped(player.player_id()), true, false, 1000)
					system.wait(1)
				end
			end
		end
	end
	if not f.on then
		settings["» Rapid Fire"] = false
	end
end).on = settings["» Rapid Fire"]

feature["» Flamethrower"] = menu.add_feature("» Flamethrower", "slider", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Flamethrower"] = true
		settings["» Flamethrower Scale"] = f.value
		while f.on do
			system.yield(0)
			if player.is_player_free_aiming(player.player_id()) then
				graphics.set_next_ptfx_asset("weap_xs_vehicle_weapons")
				while not graphics.has_named_ptfx_asset_loaded("weap_xs_vehicle_weapons") do
					graphics.request_named_ptfx_asset("weap_xs_vehicle_weapons")
					system.wait(0)
				end
				if objects["» Flamethrower"] == nil then
					objects["» Flamethrower"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()))
					entity.set_entity_collision(objects["» Flamethrower"], false, false, false)
					entity.set_entity_visible(objects["» Flamethrower"], false)
					streaming.set_model_as_no_longer_needed(1803116220)
				end
				local success, pos_h = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 0xdead, v3())
				while not success do
					system.wait(0)
					success, pos_h = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 0xdead, v3())
				end
				utilities.set_entity_coords(objects["» Flamethrower"], pos_h)
				entity.set_entity_rotation(objects["» Flamethrower"], cam.get_gameplay_cam_rot())
				if ptfxs["» Flamethrower"] == nil then
					local flamethrower_scale = f.value
					ptfxs["» Flamethrower"] = graphics.start_networked_ptfx_looped_on_entity("muz_xs_turret_flamethrower_looping", objects["» Flamethrower"], v3(), v3(), flamethrower_scale)
					graphics.set_ptfx_looped_scale(ptfxs["» Flamethrower"], flamethrower_scale)
				end
			else
				if objects["» Flamethrower"] then
					graphics.remove_particle_fx(ptfxs["» Flamethrower"], true)
					ptfxs["» Flamethrower"] = nil
					utilities.clear_ptfx(objects["» Flamethrower"])
					objects["» Flamethrower"] = nil
				end
			end
		end
	end
	if not f.on then
		if ptfxs["» Flamethrower"] then
			graphics.remove_particle_fx(ptfxs["» Flamethrower"], true)
			ptfxs["» Flamethrower"] = nil
			utilities.clear_ptfx(objects["» Flamethrower"])
			objects["» Flamethrower"] = nil
		end
		graphics.remove_named_ptfx_asset("weap_xs_vehicle_weapons")
		settings["» Flamethrower Scale"] = f.value
		settings["» Flamethrower"] = false
	end
end)
feature["» Flamethrower"].max = 5
feature["» Flamethrower"].min = 0.5
feature["» Flamethrower"].mod = 0.5
feature["» Flamethrower"].value = settings["» Flamethrower Scale"]
feature["» Flamethrower"].on = settings["» Flamethrower"]

feature["» Delete Gun"] = menu.add_feature("» Delete Gun", "toggle", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Delete Gun"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
				local entity_ = player.get_entity_player_is_aiming_at(player.player_id())
				network.request_control_of_entity(entity_)
				if not network.has_control_of_entity(entity_) then
	     			network.request_control_of_entity(entity_)
				end
				entity.set_entity_collision(entity_, true, true, true)
				entity.set_entity_as_no_longer_needed(entity_)
				entity.set_entity_as_mission_entity(entity_, false, true)
				utilities.hard_remove_entity(entity_)
			end
		end
	end
	if not f.on then
		settings["» Delete Gun"] = false
	end
end)
feature["» Delete Gun"].on = settings["» Delete Gun"]

feature["» Airstrike Gun"] = menu.add_feature("» Airstrike Gun", "value_str", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Airstrike Gun"] = true
		feature_value_settings["» Airstrike Gun"] = f.value
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
				threads["» Airstrike Gun"] = menu.create_thread(function()
					local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
					while not success do
						success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
						system.wait(0)
					end
					if f.value == 0 then
						for i = 1, 20 do
							gameplay.shoot_single_bullet_between_coords(pos + v3(math.random(-10, 10), math.random(-10, 10), 60), pos + v3(math.random(-10, 10), math.random(-10, 10), 0), 1000, gameplay.get_hash_key("weapon_airstrike_rocket"), player.get_player_ped(player.player_id()), true, false, 250)
							system.wait(200)
						end
					elseif f.value == 1 then
						gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 30), pos, 1000, gameplay.get_hash_key("weapon_airstrike_rocket"), player.get_player_ped(player.player_id()), true, false, 250)
					end
				end, nil)
			end
		end
	end
	if not f.on then
		settings["» Airstrike Gun"] = false
		feature_value_settings["» Airstrike Gun"] = f.value
		if threads["» Airstrike Gun"] then
			menu.delete_thread(threads["» Airstrike Gun"])
		end
	end
end)
feature["» Airstrike Gun"]:set_str_data({"Cluster", "Single"})
feature["» Airstrike Gun"].on = settings["» Airstrike Gun"]
feature["» Airstrike Gun"].value = feature_value_settings["» Airstrike Gun"]

feature["» Smoke Bomb Gun"] = menu.add_feature("» Smoke Bomb Gun", "slider", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Airstrike Gun"] = true
		settings["» Smoke Bomb Gun Scale"] = f.value
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
				local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
				while not success do
					success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
					system.wait(0)
				end
				graphics.set_next_ptfx_asset("scr_agencyheistb")
				while not graphics.has_named_ptfx_asset_loaded("scr_agencyheistb") do
					graphics.request_named_ptfx_asset("scr_agencyheistb")
					system.wait(0)
				end
				graphics.start_networked_particle_fx_non_looped_at_coord("scr_agency3b_elec_box", pos, v3(60, 0, 0), f.value, true, true, true)
				graphics.remove_named_ptfx_asset("scr_agencyheistb")
			end
		end
	end
	if not f.on then
		settings["» Smoke Bomb Gun Scale"] = f.value
		settings["» Smoke Bomb Gun"] = false
	end
end)
feature["» Smoke Bomb Gun"].max = 20
feature["» Smoke Bomb Gun"].min = 2
feature["» Smoke Bomb Gun"].mod = 2
feature["» Smoke Bomb Gun"].value = settings["» Smoke Bomb Gun Scale"]
feature["» Smoke Bomb Gun"].on = settings["» Smoke Bomb Gun"]

feature["» Hands Up"] = menu.add_feature("» Hands Up", "value_str", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Hands Up"] = true
		feature_value_settings["» Hands Up"] = f.value
		while f.on do
			system.yield(50)
			if player.is_player_free_aiming(player.player_id()) and not player.is_player_in_any_vehicle(player.player_id()) and not ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
				local entity_ = player.get_entity_player_is_aiming_at(player.player_id())
				if entity.is_entity_a_ped(entity_) and not ped.is_ped_in_any_vehicle(entity_) and not entity.is_entity_dead(entity_) and utilities.get_distance_between(player.get_player_ped(player.player_id()), entity_) < 15 then
					if ped.get_ped_relationship_group_hash(entity_) == gameplay.get_hash_key("COP") or ped.is_ped_a_player(entity_) or entity.get_entity_model_hash(entity_) == 416176080 or entity.get_entity_model_hash(entity_) == 0xCE5FF074 or entity.get_entity_model_hash(entity_) == 0x573201B8 or entity.get_entity_model_hash(entity_) == 0xAAB71F62 or entity.get_entity_model_hash(entity_) == 0xA8683715 or entity.get_entity_model_hash(entity_) == 0x14EC17EA or entity.get_entity_model_hash(entity_) == 0x3DF40FC1 or entity.get_entity_model_hash(entity_) == 0x56E29962 or entity.get_entity_model_hash(entity_) == 0xFCFA9E1E or entity.get_entity_model_hash(entity_) == 0x644AC75E or entity.get_entity_model_hash(entity_) == 0x18012A9F or entity.get_entity_model_hash(entity_) == 0xD86B5A95 or entity.get_entity_model_hash(entity_) == 0x8BBAB455 or entity.get_entity_model_hash(entity_) == 0x2FD800B7 or entity.get_entity_model_hash(entity_) == 0x6AF51FAF or entity.get_entity_model_hash(entity_) == 0x471BE4B2 or entity.get_entity_model_hash(entity_) == 0x4E8F95A2 or entity.get_entity_model_hash(entity_) == 0x8D8AC8B9 or entity.get_entity_model_hash(entity_) == 0x1250D7BA or entity.get_entity_model_hash(entity_) == 0xE71D5E68 or entity.get_entity_model_hash(entity_) == 0xB11BAB56 or entity.get_entity_model_hash(entity_) == 0x6A20728 or entity.get_entity_model_hash(entity_) == 0x431D501C or entity.get_entity_model_hash(entity_) == 0x6D362854 or entity.get_entity_model_hash(entity_) == 0xDFB55C81 or entity.get_entity_model_hash(entity_) == 0xC3B52966 or entity.get_entity_model_hash(entity_) == 0x349F33E1 or entity.get_entity_model_hash(entity_) == 0xC2D06F53 or entity.get_entity_model_hash(entity_) == 0x9563221D or entity.get_entity_model_hash(entity_) == 0xD3939DFD or entity.get_entity_model_hash(entity_) == 0x3C831724 or entity.get_entity_model_hash(entity_) == 0x6C3F072 or entity.get_entity_model_hash(entity_) == 0x431FC24C or entity.get_entity_model_hash(entity_) == 0xA148614D or entity.get_entity_model_hash(entity_) == 0xAD7844BB or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 3125143736 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 2725352035 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 4256991824 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 2874559379 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 741814745 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 2481070269 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 883325847 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 101631238 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 615608432 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 3126027122 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 2694266206 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 3125143736 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 1233104067 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 126349499 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 600439132 or ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 406929569 or ped.get_current_ped_weapon(entity_) == 2138347493 or ped.get_current_ped_weapon(entity_) == 1119849093 or ped.get_current_ped_weapon(entity_) == 2982836145 or ped.get_current_ped_weapon(entity_) == 2726580491 or ped.get_current_ped_weapon(entity_) == 1672152130 or ped.get_current_ped_weapon(entity_) == 1834241177 or ped.get_current_ped_weapon(entity_) == 125959754 or ped.get_current_ped_weapon(entity_) == 3676729658 or ped.get_current_ped_weapon(entity_) == 3056410471 then
					else
						if f.value == 0 then
							threads["» Hands Up"] = menu.create_thread(function()
								system.yield(200)
								streaming.request_anim_dict("mp_am_hold_up")
								streaming.request_anim_set("handsup_base")
								network.request_control_of_entity(entity_)
								if streaming.has_anim_dict_loaded("mp_am_hold_up") then
									ai.task_play_anim(entity_, "mp_am_hold_up", "handsup_base", 1, 0, -1, 9, 0, false, false, false)
								end
							end, nil)
						elseif f.value == 1 then
							threads["» Hands Up"] = menu.create_thread(function()
								system.yield(200)
								streaming.request_anim_dict("random@arrests@busted")
								streaming.request_anim_set("idle_c")
								network.request_control_of_entity(entity_)
								if streaming.has_anim_dict_loaded("random@arrests@busted") then
									ai.task_play_anim(entity_, "random@arrests@busted", "idle_c", 1, 0, -1, 9, 0, false, false, false)
								end
							end, nil)
						elseif f.value == 2 then
							threads["» Hands Up"] = menu.create_thread(function()
								system.yield(200)
								streaming.request_anim_dict("random@arrests")
								streaming.request_anim_set("kneeling_arrest_idle")
								network.request_control_of_entity(entity_)
								if streaming.has_anim_dict_loaded("random@arrests") then
									ai.task_play_anim(entity_, "random@arrests", "kneeling_arrest_idle", 1, 0, -1, 9, 0, false, false, false)
								end
							end, nil)
						end
					end
					system.wait(300)
				end
			end
		end
	end
	if not f.on then
		settings["» Hands Up"] = false
		feature_value_settings["» Hands Up"] = f.value
		if threads["» Hands Up"] then
			menu.delete_thread(threads["» Hands Up"])
		end
	end
end)
feature["» Hands Up"]:set_str_data({"mp_am_hold_up", "random@arrests@busted", "kneeling_arrest_idle"})
feature["» Hands Up"].on = settings["» Hands Up"]
feature["» Hands Up"].value = feature_value_settings["» Hands Up"]

feature["» Shoot Weapon Objects"] = menu.add_feature("» Shoot Weapon Objects", "value_str", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Shoot Weapon Objects"] = true
		feature_value_settings["» Shoot Weapon Objects"] = f.value
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) and not player.is_player_in_any_vehicle(player.player_id()) then
				threads["» Shoot Weapon Objects"] = menu.create_thread(function()
					local pos = player.get_player_coords(player.player_id())
					local dir = cam.get_gameplay_cam_rot()
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = cam.get_gameplay_cam_rot()
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					if f.value == 0 then
						local object_ = object.create_object(-171327159, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 1 then
						local object_ = object.create_object(2771413813, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 2 then
						local object_ = object.create_object(626847828, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 3 then
						local object_ = object.create_object(491091384, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 4 then
						local object_ = object.create_object(3688284050, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 5 then
						local object_ = object.create_object(3688284050, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 6 then
						local object_ = object.create_object(1901887007, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 7 then
						local object_ = object.create_object(422658457, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 8 then
						local object_ = object.create_object(2418461061, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 9 then
						local object_ = object.create_object(2844908264, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 10 then
						local object_ = object.create_object(4076109223, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 11 then
						local object_ = object.create_object(4076109223, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 12 then
						local object_ = object.create_object(242383520, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 13 then
						local object_ = object.create_object(3911017173, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 14 then
						local object_ = object.create_object(1591549914, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 15 then
						local object_ = object.create_object(2730774144, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 16 then
						local object_ = object.create_object(290600267, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 17 then
						local object_ = object.create_object(3414357965, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 18 then
						local object_ = object.create_object(4121513285, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 19 then
						local object_ = object.create_object(1876445962, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 20 then
						local object_ = object.create_object(1591549914, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 21 then
						local object_ = object.create_object(1297482736, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					elseif f.value == 22 then
						local object_ = object.create_object(3184763647, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					end
				end, nil)
			end
		end
	end
	if not f.on then
		settings["» Shoot Weapon Objects"] = false
		feature_value_settings["» Shoot Weapon Objects"] = f.value
		if threads["» Shoot Weapon Objects"] then
			menu.delete_thread(threads["» Shoot Weapon Objects"])
		end
	end
end)
feature["» Shoot Weapon Objects"]:set_str_data({"Fire Extinguisher", "Compact Grenade Launcher", "Compact EMP Launcher", "Firework Launcher", "Grenade Launcher", "Tear Gas Launcher", "Homing Launcher", "Minigun", "Railgun", "Widowmaker", "RPG", "RPG2", "Can", "Ball", "BZ Gas", "Flare", "Grenade", "Molotov", "Pipe Bomb", "Proximity Mine", "Tear Gas", "Snowball", "Sticky Bomb"})
feature["» Shoot Weapon Objects"].on = settings["» Shoot Weapon Objects"]
feature["» Shoot Weapon Objects"].value = feature_value_settings["» Shoot Weapon Objects"]

feature["» Shoot Custom Objects"] = menu.add_feature("» Shoot Custom Objects", "value_str", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Shoot Custom Objects"] = true
		feature_value_settings["» Shoot Custom Objects"] = f.value
		local input_stat, input_val = input.get("Enter Hash Model", "", 10, 3)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			f.on = false
			settings["» Shoot Custom Objects"] = false
			return HANDLER_POP
		end
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) and not player.is_player_in_any_vehicle(player.player_id()) then
				threads["» Shoot Custom Objects"] = menu.create_thread(function()
					if f.value == 0 then
						local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
						while not success do
							success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
							system.wait(0)
						end
						local object_ = object.create_object(input_val, pos, true, true)
						system.wait(6000)
						entity.delete_entity(object_)
					elseif f.value == 1 then
						local pos = player.get_player_coords(player.player_id())
						local dir = cam.get_gameplay_cam_rot()
						dir:transformRotToDir()
						dir = dir * 8
						pos = pos + dir
						dir = nil
						local pos_target = player.get_player_coords(player.player_id())
						dir = cam.get_gameplay_cam_rot()
						dir:transformRotToDir()
						dir = dir * 100
						pos_target = pos_target + dir
						local vectorV3 = pos_target - pos
						local object_ = object.create_object(input_val, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(6000)
						entity.delete_entity(object_)
					end
				end, nil)
			end
		
		end
	end
	if not f.on then
		settings["» Shoot Custom Objects"] = false
		feature_value_settings["» Shoot Custom Objects"] = f.value
		if threads["» Shoot Custom Objects"] then
			menu.delete_thread(threads["» Shoot Custom Objects"])
		end
	end
end)
feature["» Shoot Custom Objects"]:set_str_data({"Last Impact", "Launch"})
feature["» Shoot Custom Objects"].on = settings["» Shoot Custom Objects"]
feature["» Shoot Custom Objects"].value = feature_value_settings["» Shoot Custom Objects"]

feature["» Shoot Fake Money Bags"] = menu.add_feature("» Shoot Fake Money Bags", "value_str", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Shoot Fake Money Bags"] = true
		feature_value_settings["» Shoot Fake Money Bags"] = f.value
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) and not player.is_player_in_any_vehicle(player.player_id()) then
				threads["» Shoot Fake Money Bags 1"] = menu.create_thread(function()
					if f.value == 0 then
						local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
						while not success do
							success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
							system.wait(0)
						end
						fake_money_bags_shoot = 1
						local object_ = object.create_object(2628187989, pos, true, true)
						local thread_ = menu.create_thread(function()
							while fake_money_bags_shoot do
								system.yield(50)
								for pid = 0, 31 do
									if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.5 then
										audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 1, false)
										network.request_control_of_entity(object_)
										while not network.has_control_of_entity(object_) do
											network.request_control_of_entity(object_)
											system.wait(0)
										end
										entity.delete_entity(object_)
										thread_ = nil
									end
								end
							end
						end, nil)
						system.wait(10000)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
						menu.delete_thread(thread_)
					elseif f.value == 1 then
						local pos = player.get_player_coords(player.player_id())
						local dir = cam.get_gameplay_cam_rot()
						dir:transformRotToDir()
						dir = dir * 8
						pos = pos + dir
						dir = nil
						local pos_target = player.get_player_coords(player.player_id())
						dir = cam.get_gameplay_cam_rot()
						dir:transformRotToDir()
						dir = dir * 100
						pos_target = pos_target + dir
						local vectorV3 = pos_target - pos
						fake_money_bags_shoot = 1
						local object_ = object.create_object(2628187989, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(500)
						local thread_ = menu.create_thread(function()
							while fake_money_bags_shoot do
								system.yield(50)
								for pid = 0, 31 do
									if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.5 then
										audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 1, false)
										network.request_control_of_entity(object_)
										while not network.has_control_of_entity(object_) do
											network.request_control_of_entity(object_)
											system.wait(0)
										end
										entity.delete_entity(object_)
										thread_ = nil
									end
								end
							end
						end, nil)
						system.wait(10000)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
						menu.delete_thread(thread_)
					end
				end, nil)
			end
		end
	end
	if not f.on then
		settings["» Shoot Fake Money Bags"] = false
		feature_value_settings["» Shoot Fake Money Bags"] = f.value
		fake_money_bags_shoot = nil
		if threads["» Shoot Fake Money Bags 1"] then
			menu.delete_thread(threads["» Shoot Fake Money Bags 1"])
		end
	end
end)
feature["» Shoot Fake Money Bags"]:set_str_data({"Last Impact", "Launch"})
feature["» Shoot Fake Money Bags"].on = settings["» Shoot Fake Money Bags"]
feature["» Shoot Fake Money Bags"].value = feature_value_settings["» Shoot Fake Money Bags"]

feature["» Shoot Stones"] = menu.add_feature("» Shoot Stones", "value_str", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Shoot Stones"] = true
		feature_value_settings["» Shoot Stones"] = f.value
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) and not player.is_player_in_any_vehicle(player.player_id()) then
				threads["» Shoot Stones"] = menu.create_thread(function()
					if f.value == 0 then
						local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
						while not success do
							success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
							system.wait(0)
						end
						local object_ = object.create_object(3175864630, pos, true, true)
						system.wait(6000)
						entity.delete_entity(object_)
					elseif f.value == 1 then
						local pos = player.get_player_coords(player.player_id())
						local dir = cam.get_gameplay_cam_rot()
						dir:transformRotToDir()
						dir = dir * 8
						pos = pos + dir
						dir = nil
						local pos_target = player.get_player_coords(player.player_id())
						dir = cam.get_gameplay_cam_rot()
						dir:transformRotToDir()
						dir = dir * 100
						pos_target = pos_target + dir
						local vectorV3 = pos_target - pos
						local object_ = object.create_object(3175864630, player.get_player_coords(player.player_id()) + v3(0, 0, -0.3), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(8000)
						entity.delete_entity(object_)
					end
				end, nil)
			end
		
		end
	end
	if not f.on then
		settings["» Shoot Stones"] = false
		feature_value_settings["» Shoot Stones"] = f.value
		if threads["» Shoot Stones"] then
			menu.delete_thread(threads["» Shoot Stones"])
		end
	end
end)
feature["» Shoot Stones"]:set_str_data({"Last Impact", "Launch"})
feature["» Shoot Stones"].on = settings["» Shoot Stones"]
feature["» Shoot Stones"].value = feature_value_settings["» Shoot Stones"]

feature["» Shoot Dogshit"] = menu.add_feature("» Shoot Dogshit", "value_str", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Shoot Dogshit"] = true
		feature_value_settings["» Shoot Dogshit"] = f.value
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) and not player.is_player_in_any_vehicle(player.player_id()) then
				threads["» Shoot Dogshit"] = menu.create_thread(function()
					if f.value == 0 then
						local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
						while not success do
							success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
							system.wait(0)
						end
						local object_ = object.create_object(2223607550, pos, true, true)
						system.wait(10000)
						entity.delete_entity(object_)
					elseif f.value == 1 then
						local pos = player.get_player_coords(player.player_id())
						local dir = cam.get_gameplay_cam_rot()
						dir:transformRotToDir()
						dir = dir * 8
						pos = pos + dir
						dir = nil
						local pos_target = player.get_player_coords(player.player_id())
						dir = cam.get_gameplay_cam_rot()
						dir:transformRotToDir()
						dir = dir * 100
						pos_target = pos_target + dir
						local vectorV3 = pos_target - pos
						local object_ = object.create_object(2223607550, player.get_player_coords(player.player_id()) + v3(0, 0, -0.1), true, true)
						entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
						system.wait(10000)
						entity.delete_entity(object_)
					end
				end, nil)
			end
		end
	end
	if not f.on then
		settings["» Shoot Dogshit"] = false
		feature_value_settings["» Shoot Dogshit"] = f.value
		if threads["» Shoot Dogshit"] then
			menu.delete_thread(threads["» Shoot Dogshit"])
		end
	end
end)
feature["» Shoot Dogshit"]:set_str_data({"Last Impact", "Launch"})
feature["» Shoot Dogshit"].on = settings["» Shoot Dogshit"]
feature["» Shoot Dogshit"].value = feature_value_settings["» Shoot Dogshit"]

feature["» Shoot Missiles"] = menu.add_feature("» Shoot Missiles", "toggle", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		settings["» Shoot Missiles"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) and not player.is_player_in_any_vehicle(player.player_id()) then
				menu.create_thread(function()
					local pos = player.get_player_coords(player.player_id())
					local dir = cam.get_gameplay_cam_rot()
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = cam.get_gameplay_cam_rot()
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					local object_ = object.create_object(gameplay.get_hash_key("W_Smug_Bomb_03"), player.get_player_coords(player.player_id()) + v3(0, 0, -0.1), true, true)
					entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
					while f.on do
						system.yield(10)
						if entity.has_entity_collided_with_anything(object_) or not f.on then
							fire.add_explosion(entity.get_entity_coords(object_), 8, true, false, 0.3, player.get_player_ped(player.player_id()))
							fire.add_explosion(entity.get_entity_coords(object_), 60, true, false, 0.3, player.get_player_ped(player.player_id()))
							entity.delete_entity(object_)
						end
						if entity.is_entity_in_water(object_) then
							fire.add_explosion(entity.get_entity_coords(object_), 52, true, false, 0.3, player.get_player_ped(player.player_id()))
							entity.delete_entity(object_)
						end
					end
				end, nil)
			end
		end
	end
	if not f.on then
		settings["» Shoot Missiles"] = false
	end
end)
feature["» Shoot Missiles"].on = settings["» Shoot Missiles"]

menu.add_feature("» Rope Gun", "toggle", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		rope.rope_load_textures()
		if not rope_gun_notify then
			menu.notify("Shoot Two Entities To Rope Them Together!", Meteor, 6, 0x64FA7800)
			rope_gun_notify = true
		end
		table_of_all_ropes = {}
		table_of_all_ropes_count = 1
		while f.on do
			system.yield(0)
			local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
			if success then
				if rope_target_1 == nil then
					if entity.is_entity_a_ped(player.get_entity_player_is_aiming_at(player.player_id())) and ped.is_ped_in_any_vehicle(player.get_entity_player_is_aiming_at(player.player_id())) then
						rope_target_1 = ped.get_vehicle_ped_is_using(player.get_entity_player_is_aiming_at(player.player_id()))
					else
						rope_target_1 = player.get_entity_player_is_aiming_at(player.player_id())
					end
					if rope_target_1 ~= nil and rope_target_1 ~= 0 then
						menu.notify("Selected Entity One (" .. string.format("%0x", rope_target_1) .. ")", Meteor, 3, 0x64FA7800)
					else
						menu.notify("Unable To Find An Entity", Meteor, 3, 211)
						rope_target_1 = nil
					end
					rope_wait_a_second = true
				end
				if rope_target_1 ~= nil and rope_target_2 == nil and not rope_wait_a_second then
					if entity.is_entity_a_ped(player.get_entity_player_is_aiming_at(player.player_id())) and ped.is_ped_in_any_vehicle(player.get_entity_player_is_aiming_at(player.player_id())) then
						rope_target_2 = ped.get_vehicle_ped_is_using(player.get_entity_player_is_aiming_at(player.player_id()))
					else
						rope_target_2 = player.get_entity_player_is_aiming_at(player.player_id())
					end
					if rope_target_2 ~= nil and rope_target_2 ~= 0 then
						menu.notify("Selected Entity Two (" .. string.format("%0x", rope_target_2) .. ")", Meteor, 3, 0x64FA7800)
					else
						menu.notify("Unable To Find An Entity", Meteor, 3, 211)
						rope_target_2 = nil
					end
				end
				if rope_target_1 ~= nil and rope_target_2 ~= nil then
					menu.notify("Creating A Rope..", Meteor, 3, 0x64FA7800)
					table_of_all_ropes[table_of_all_ropes_count] = rope.add_rope(entity.get_entity_coords(rope_target_1), v3(0, 0, 0), 1, 1, 1, 0, 10, false, false, false, 1, false)
					rope.attach_entities_to_rope(table_of_all_ropes[table_of_all_ropes_count], rope_target_1, rope_target_2, entity.get_entity_coords(rope_target_1), entity.get_entity_coords(rope_target_2), utilities.get_distance_between(rope_target_1, rope_target_2), 0, 0, "Center", "Center")
					table_of_all_ropes_count = table_of_all_ropes_count + 1
					rope_target_1 = nil
					rope_target_2 = nil
				end
				rope_wait_a_second = false
			end
		end
	end
	if not f.on then
		rope.rope_unload_textures()
		rope_target_1 = nil
		rope_target_2 = nil
		rope_wait_a_second = false
		for i = 1, #table_of_all_ropes do
			if rope.does_rope_exist(table_of_all_ropes[i]) then
				rope.delete_rope(table_of_all_ropes[i])
				table_of_all_ropes[i] = nil
			end
		end
	end
end)

feature["» 40.000 KW Basskanone"] = menu.add_feature("» 40.000 KW Basskanone", "toggle", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		sound_event_count = 0
		settings["» 40.000 KW Basskanone"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
				threads["» 40.000 KW Basskanone"] = menu.create_thread(function()
					local success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
					while not success do
						success, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
						system.wait(0)
					end
					fire.add_explosion(pos, 70, true, false, 0.2, player.get_player_ped(player.player_id()))
					fire.add_explosion(pos, 70, true, false, 0.2, player.get_player_ped(player.player_id()))
					fire.add_explosion(pos, 70, true, false, 0.2, player.get_player_ped(player.player_id()))
					fire.add_explosion(pos, 70, true, false, 0.2, player.get_player_ped(player.player_id()))
					fire.add_explosion(pos, 70, true, false, 0.2, player.get_player_ped(player.player_id()))
					fire.add_explosion(pos, 70, true, false, 0.2, player.get_player_ped(player.player_id()))
					if network.is_session_started() then
						if sound_event_count < 2 then
							sound_event_count = sound_event_count + 1
							local time = utils.time_ms() + 100
							while time > utils.time_ms() do
								for i = 1, 10 do
									audio.play_sound_from_coord(-1, "Event_Message_Purple", pos, "GTAO_FM_Events_Soundset", true, 5, false)
								end
								system.wait(0)
							end
						end
					end
					system.wait(4000)
					sound_event_count = sound_event_count - 1
				end, nil)
			end
		end
	end
	if not f.on then
		sound_event_count = 0
		if threads["» 40.000 KW Basskanone"] then
			menu.delete_thread(threads["» 40.000 KW Basskanone"])
			threads["» 40.000 KW Basskanone"] = nil
		end
		settings["» 40.000 KW Basskanone"] = false
	end
end)
feature["» 40.000 KW Basskanone"].on = settings["» 40.000 KW Basskanone"]

feature["» Call Kamikaze Attack"] = menu.add_feature("» Call Kamikaze Attack", "toggle", localparents["» Weapon Modifiers"].id, function(f)
	if f.on then
		if call_kamikaze_attack == nil then
			menu.notify("[!] Aim at a surface and press E to call an attack!", Meteor, 4, 0x64FA7800)
			call_kamikaze_attack = 1
		end
		streaming.request_model(0xE75B4B1C)
		streaming.request_model(0xC5DD6967)
	
		while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end
		while (not streaming.has_model_loaded(0xC5DD6967)) do
			system.wait(0)
		end
		settings["» Call Kamikaze Attack"] = true
		while f.on do
			system.yield(0)
			if controls.is_disabled_control_just_pressed(2, 206) then
				menu.create_thread(function()
					local vehicle_ = vehicle.create_vehicle(0xC5DD6967, utilities.get_surface_player_is_aiming_at(player.player_id()) + v3(math.random(-50, 50), math.random(-50, 50), math.random(30, 50)), 0, true, false)
					local ped_ = ped.create_ped(1, 0xE75B4B1C, utilities.get_surface_player_is_aiming_at(player.player_id()) + v3(math.random(-50, 50), math.random(-50, 50), math.random(50, 100)), 0, true, false)
					system.wait(10)
					network.request_control_of_entity(vehicle_)
					network.request_control_of_entity(ped_)
					ped.set_ped_into_vehicle(ped_, vehicle_, -1)
					vehicle.control_landing_gear(vehicle_, 3)
					utilities.rotate_to_pos(vehicle_, utilities.get_surface_player_is_aiming_at(player.player_id()))
					system.wait(10)
					vehicle.set_vehicle_forward_speed(vehicle_, 60.0)
					system.wait(5000)
					utilities.hard_remove_entity(vehicle_)
				end, nil)
			end
		end
	end
	if not f.on then
		settings["» Call Kamikaze Attack"] = false
		streaming.set_model_as_no_longer_needed(0xC5DD6967)
		streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	end
end)
feature["» Call Kamikaze Attack"].on = settings["» Call Kamikaze Attack"]

localparents["» Model Changer"] = menu.add_feature("» Model Changer", "parent", localparents["» Player Options"].id)

menu.add_feature("» Save Current Model + Outfit", "toggle", localparents["» Model Changer"].id, function(f)
	if f.on then
		saved_model_hash = player.get_player_model(player.player_id())
		saved_outfit_component_0 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 0)
		saved_outfit_component_1 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 1)
		saved_outfit_component_2 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 2)
		saved_outfit_component_3 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 3)
		saved_outfit_component_4 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 4)
		saved_outfit_component_5 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 5)
		saved_outfit_component_6 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 6)
		saved_outfit_component_7 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 7)
		saved_outfit_component_8 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 8)
		saved_outfit_component_9 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 9)
		saved_outfit_component_10 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 10)
		saved_outfit_component_11 = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 11)
		saved_outfit_texture_0 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 0)
		saved_outfit_texture_1 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 1)
		saved_outfit_texture_2 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 2)
		saved_outfit_texture_3 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 3)
		saved_outfit_texture_4 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 4)
		saved_outfit_texture_5 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 5)
		saved_outfit_texture_6 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 6)
		saved_outfit_texture_7 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 7)
		saved_outfit_texture_8 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 8)
		saved_outfit_texture_9 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 9)
		saved_outfit_texture_10 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 10)
		saved_outfit_texture_11 = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 11)
		saved_outfit_prop_0 = ped.get_ped_prop_index(player.get_player_ped(player.player_id()), 0)
		saved_outfit_prop_1 = ped.get_ped_prop_index(player.get_player_ped(player.player_id()), 1)
		saved_outfit_prop_2 = ped.get_ped_prop_index(player.get_player_ped(player.player_id()), 2)
		saved_outfit_prop_texture_0 = ped.get_ped_prop_texture_index(player.get_player_ped(player.player_id()), 0)
		saved_outfit_prop_texture_1 = ped.get_ped_prop_texture_index(player.get_player_ped(player.player_id()), 1)
		saved_outfit_prop_texture_2 = ped.get_ped_prop_texture_index(player.get_player_ped(player.player_id()), 2)
	end
	if not f.on then
		utilities.change_player_model(saved_model_hash, nil)
		system.wait(100)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 0, saved_outfit_component_0, saved_outfit_texture_0, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 1, saved_outfit_component_1, saved_outfit_texture_1, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 2, saved_outfit_component_2, saved_outfit_texture_2, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 3, saved_outfit_component_3, saved_outfit_texture_3, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 4, saved_outfit_component_4, saved_outfit_texture_4, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 5, saved_outfit_component_5, saved_outfit_texture_5, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 6, saved_outfit_component_6, saved_outfit_texture_6, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 7, saved_outfit_component_7, saved_outfit_texture_7, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 8, saved_outfit_component_8, saved_outfit_texture_8, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 9, saved_outfit_component_9, saved_outfit_texture_9, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 10, saved_outfit_component_10, saved_outfit_texture_10, 0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 11, saved_outfit_component_11, saved_outfit_texture_11, 0)
		ped.set_ped_prop_index(player.get_player_ped(player.player_id()), 0, saved_outfit_prop_0, saved_outfit_prop_texture_0, 0)
		ped.set_ped_prop_index(player.get_player_ped(player.player_id()), 1, saved_outfit_prop_1, saved_outfit_prop_texture_1, 0)
		ped.set_ped_prop_index(player.get_player_ped(player.player_id()), 2, saved_outfit_prop_2, saved_outfit_prop_texture_2, 0)
	end
end)

localparents["» Animal Models"] = menu.add_feature("» Animal Models", "parent", localparents["» Model Changer"].id)

menu.add_feature("» Bigfoot 1", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x61D4C771, nil)
end)

menu.add_feature("» Bigfoot 2", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xAD340F5A, nil)
end)

menu.add_feature("» Boar", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xCE5FF074, nil)
end)

menu.add_feature("» Cat", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x573201B8, nil)
end)

menu.add_feature("» Chickenhawk", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xAAB71F62, nil)
end)

menu.add_feature("» Chimp", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xA8683715, nil)
	pos = player.get_player_coords(player.player_id()) + v3(0, 0, 2.5)
	entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
end)

menu.add_feature("» Chop 1", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x14EC17EA, nil)
end)

menu.add_feature("» Chop 2", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x3DF40FC1, nil)
end)

menu.add_feature("» Cormorant", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x56E29962, nil)
end)

menu.add_feature("» Cow", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xFCFA9E1E, nil)
end)

menu.add_feature("» Coyote", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x644AC75E, nil)
end)

menu.add_feature("» Crow", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x18012A9F, nil)
end)

menu.add_feature("» Deer", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xD86B5A95, nil)
end)

menu.add_feature("» Dolphin", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x8BBAB455, true)
end)

menu.add_feature("» Fish", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x2FD800B7, true)
end)

menu.add_feature("» Hen", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x6AF51FAF, nil)
end)

menu.add_feature("» Humpback", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x471BE4B2, true)
end)

menu.add_feature("» Husky", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x4E8F95A2, nil)
end)

menu.add_feature("» Killer Whale", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x8D8AC8B9, true)
end)

menu.add_feature("» Mtlion", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x1250D7BA, nil)
end)

menu.add_feature("» Panther", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xE71D5E68, nil)
end)

menu.add_feature("» Pig", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xB11BAB56, nil)
end)

menu.add_feature("» Pigeon", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x6A20728, nil)
end)

menu.add_feature("» Poodle", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x431D501C, nil)
end)

menu.add_feature("» Pug", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x6D362854, nil)
end)

menu.add_feature("» Rabbit", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xDFB55C81, nil)
end)

menu.add_feature("» Rat", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xC3B52966, nil)
end)

menu.add_feature("» Retriever", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x349F33E1, nil)
end)

menu.add_feature("» Rhesus", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xC2D06F53, nil, true)
	pos = player.get_player_coords(player.player_id()) + v3(0, 0, 2.5)
	entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
end)

menu.add_feature("» Rottweiler", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x9563221D, nil)
end)

menu.add_feature("» Seagull", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xD3939DFD, nil)
end)

menu.add_feature("» Hammer Shark", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x3C831724, true)
end)

menu.add_feature("» Tiger Shark", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x6C3F072, true)
end)

menu.add_feature("» Shepherd", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0x431FC24C, nil)
end)

menu.add_feature("» Stingray", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xA148614D, true)
end)

menu.add_feature("» Westy", "action", localparents["» Animal Models"].id, function(f)
	utilities.change_player_model(0xAD7844BB, nil)
end)

localparents["» Objects"] = menu.add_feature("» Objects", "parent", localparents["» Model Changer"].id)

menu.add_feature("» Custom Object", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		model_change_input_stat, model_change_input_val = input.get("Enter Hash Model (DEC)", "", 10, 3)
		if model_change_input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if model_change_input_stat == 2 then
			f.on = false
			return HANDLER_POP
		end

		if player.is_player_valid(player.player_id()) then
			utilities.request_model(model_change_input_val)
			model_change_object_ = object.create_object(model_change_input_val, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(model_change_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(model_change_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(model_change_object_, player.get_player_coords(player.player_id()))
			end
			entity.set_entity_collision(model_change_object_, false, false, false)
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		if not model_change_input_val == nil then
			streaming.set_model_as_no_longer_needed(model_change_input_val)
		end
		entity.delete_entity(model_change_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» Custom World Object", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		world_model_change_input_stat, world_model_change_input_val = input.get("Enter Hash Model (DEC)", "", 10, 3)
		if world_model_change_input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if world_model_change_input_stat == 2 then
			f.on = false
			return HANDLER_POP
		end

		if player.is_player_valid(player.player_id()) then
			utilities.request_model(model_change_input_val)
			world_model_change_object_ = object.create_world_object(world_model_change_input_val, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(world_model_change_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(world_model_change_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(world_model_change_object_, player.get_player_coords(player.player_id()))
			end
			entity.set_entity_collision(world_model_change_object_, false, false, false)
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		if not model_change_input_val == nil then
			streaming.set_model_as_no_longer_needed(model_change_input_val)
		end
		entity.delete_entity(world_model_change_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» Freeze Position", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		freeze_position_pos = player.get_player_coords(player.player_id())
		while f.on do
			system.yield(0)
			entity.set_entity_collision(player.get_player_ped(player.player_id()), false, false, false)
			ped.clear_ped_tasks_immediately(player.get_player_ped(player.player_id()))
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), freeze_position_pos)
		end
	end
	if not f.on then
		entity.set_entity_collision(player.get_player_ped(player.player_id()), true, true, false)
		freeze_position_pos = nil
	end
end)

menu.add_feature("» prop_pizza_box_02", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(-856584171)
			prop_pizza_box_02_object_ = object.create_object(-856584171, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_pizza_box_02_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_pizza_box_02_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_pizza_box_02_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(-856584171)
		entity.delete_entity(prop_pizza_box_02_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_pineapple", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(-845035989)
			prop_pineapple_object_ = object.create_object(-845035989, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_pineapple_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_pineapple_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_pineapple_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(-845035989)
		entity.delete_entity(prop_pineapple_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_streetlight_05", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(267702115)
			prop_streetlight_05_object_ = object.create_object(267702115, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_streetlight_05_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_streetlight_05_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_streetlight_05_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(267702115)
		entity.delete_entity(prop_streetlight_05_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_traffic_01a", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(1043035044)
			prop_traffic_01a_object_ = object.create_object(1043035044, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_traffic_01a_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_traffic_01a_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_traffic_01a_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(1043035044)
		entity.delete_entity(prop_traffic_01a_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_ecola_can", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(1020618269)
			prop_ecola_can_object_ = object.create_world_object(1020618269, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_ecola_can_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_ecola_can_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_ecola_can_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(1020618269)
		entity.delete_entity(prop_ecola_can_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_bin_05a", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(1329570871)
			prop_bin_05a_object_ = object.create_object(1329570871, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_bin_05a_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_bin_05a_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_bin_05a_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(1329570871)
		entity.delete_entity(prop_bin_05a_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_money_bag_01", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(289396019)
			prop_money_bag_01_object_ = object.create_object(289396019, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_money_bag_01_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_money_bag_01_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_money_bag_01_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(289396019)
		entity.delete_entity(prop_money_bag_01_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» hei_prop_cash_crate_empty", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(-1823263496)
			hei_prop_cash_crate_empty_object_ = object.create_object(-1823263496, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(hei_prop_cash_crate_empty_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(hei_prop_cash_crate_empty_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(hei_prop_cash_crate_empty_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(-1823263496)
		entity.delete_entity(hei_prop_cash_crate_empty_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_wine_red", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(1295017223)
			prop_wine_red_object_ = object.create_world_object(1295017223, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_wine_red_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_wine_red_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_wine_red_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(1295017223)
		entity.delete_entity(prop_wine_red_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_cash_case_02", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(-1787068858)
			prop_cash_case_02_object_ = object.create_object(-1787068858, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_cash_case_02_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_cash_case_02_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_cash_case_02_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(-1787068858)
		entity.delete_entity(prop_cash_case_02_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_cash_pile_02", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(-598402940)
			prop_cash_pile_02_object_ = object.create_object(-598402940, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_cash_pile_02_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_cash_pile_02_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_cash_pile_02_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(-598402940)
		entity.delete_entity(prop_cash_pile_02_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_fire_hydrant_1", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(200846641)
			prop_fire_hydrant_1_object_ = object.create_object(200846641, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_fire_hydrant_1_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_fire_hydrant_1_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_fire_hydrant_1_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(200846641)
		entity.delete_entity(prop_fire_hydrant_1_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_large_gold", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(1483319544)
			prop_large_gold = object.create_object(1483319544, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_large_gold, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_large_gold, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_large_gold, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(1483319544)
		entity.delete_entity(prop_large_gold)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_tree_cedar_s_01", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(-1272652611)
			prop_tree_cedar_s_01_object_ = object.create_world_object(-1272652611, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_tree_cedar_s_01_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_tree_cedar_s_01_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_tree_cedar_s_01_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(-1272652611)
		entity.delete_entity(prop_tree_cedar_s_01_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_cs_burger_01", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(-2054442544)
			prop_cs_burger_01_object_ = object.create_world_object(-2054442544, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_cs_burger_01_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_cs_burger_01_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_cs_burger_01_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(-2054442544)
		entity.delete_entity(prop_cs_burger_01_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

menu.add_feature("» prop_turkey_leg_01", "toggle", localparents["» Objects"].id, function(f)
	if f.on then
		if player.is_player_valid(player.player_id()) then
			utilities.request_model(-1898057898)
			prop_turkey_leg_01_object_ = object.create_world_object(-1898057898, player.get_player_coords(player.player_id()), true, true)
			entity.set_entity_no_collsion_entity(prop_turkey_leg_01_object_, player.get_player_ped(player.player_id()), false)
			while f.on do
				system.yield(0)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
				entity.set_entity_heading(prop_turkey_leg_01_object_, player.get_player_heading(player.player_id()))
				utilities.set_entity_coords(prop_turkey_leg_01_object_, player.get_player_coords(player.player_id()))
			end
		else
			menu.notify("[!] Model Change not possible!", Meteor, 3, 211)
		end
	end
	if not f.on then
		streaming.set_model_as_no_longer_needed(-1898057898)
		entity.delete_entity(prop_turkey_leg_01_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
end)

localparents["» Standard Models"] = menu.add_feature("» Standard Models", "parent", localparents["» Model Changer"].id)

menu.add_feature("» Franklin", "action", localparents["» Standard Models"].id, function(f)
	if player.is_player_valid(player.player_id()) then
		utilities.change_player_model(0x9B22DBAF, nil)
	end
end)

menu.add_feature("» Michael", "action", localparents["» Standard Models"].id, function(f)
	if player.is_player_valid(player.player_id()) then
		utilities.change_player_model(0x0D7114C9, nil)
	end
end)

menu.add_feature("» Trevor", "action", localparents["» Standard Models"].id, function(f)
	if player.is_player_valid(player.player_id()) then
		utilities.change_player_model(0x9B810FA2, nil)
	end
end)

menu.add_feature("» MP Female", "action", localparents["» Standard Models"].id, function(f)
	if player.is_player_valid(player.player_id()) then
		utilities.change_player_model(0x9C9EFFD8, nil)
	end
end)

menu.add_feature("» MP Male", "action", localparents["» Standard Models"].id, function(f)
	if player.is_player_valid(player.player_id()) then
		utilities.change_player_model(0x705E61F2, nil)
	end
end)

menu.add_feature("» Custom Model Change", "action", localparents["» Model Changer"].id, function(f)
	local input_stat, input_val = input.get("Enter Model Hash (DEC)", "", 10, 3)
	if input_stat == 1 then
		return HANDLER_CONTINUE
	end
	if input_stat == 2 then
		return HANDLER_POP
	end
	if streaming.is_model_valid(input_val) and streaming.is_model_a_ped(input_val) then
		if player.is_player_valid(player.player_id()) then
			utilities.change_player_model(input_val, nil)
		end
	end
end)

menu.add_feature("» Fix Loading Screen", "action", localparents["» Model Changer"].id, function(f)
	if player.is_player_valid(player.player_id()) then
		utilities.change_player_model(0x9B22DBAF, nil)
		system.wait(100)
        ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
	end
end)

--

menu.add_feature("» Lazer Beam On Waypoint", "action", localparents["» Miscellaneous"].id, function(f)
	local wp = ui.get_waypoint_coord()
	if wp.x ~= 16000 then
		local maxz = player.get_player_coords(player.player_id()).z + 170
		for i = maxz, -50, -2 do
			local pos = v3(wp.x, wp.y, i)
			pos.x = math.floor(pos.x)
			pos.y = math.floor(pos.y)
			pos.z = math.floor(pos.z)
			fire.add_explosion(pos + v3(0, 0, 0), 8, true, false, 1, 0)
			fire.add_explosion(pos + v3(0, 0, 0), 59, false, false, 1, 0)
			for x = 1, 4 do
				pos.x = math.random(pos.x - 1, pos.x + 1)
				pos.y = math.random(pos.y - 1, pos.y + 1)
				fire.add_explosion(pos, 8, false, false, 1, 0)
			end
			pos.x = math.random(pos.x - 4, pos.x + 4)
			pos.y = math.random(pos.y - 4, pos.y + 4)
			fire.add_explosion(pos, 8, false, false, 1, 0)
			system.wait(0)
		end
	else
		menu.notify("[!] Waypoint not found.", Meteor, 3, 211)
	end
end)

menu.add_feature("» Real 9/11", "action", localparents["» Miscellaneous"].id, function(f)
	menu.create_thread(function()
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(165154707)
		graphics.set_next_ptfx_asset("scr_agencyheistb")

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(165154707)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(165154707, v3(-18.958541870117, -1169.6507568359, 189.24995422363), -19.9749, true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, v3(-18.958541870117, -1169.6507568359, 189.24995422363), -19.9749, true, false)

		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
		entity.set_entity_collision(vehicle_, true, true, true)
		ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
		entity.set_entity_god_mode(vehicle_, true)
    	vehicle.set_vehicle_forward_speed(vehicle_, 160.0)
		entity.set_entity_collision(vehicle_, false, false, false)
		entity.set_entity_collision(ped_, false, false, false)
		system.wait(5400)
		local wall_pos = entity.get_entity_coords(ped_)
		fire.add_explosion(wall_pos, 59, true, false, 3, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos + v3(math.random(-12, 12), math.random(-12, -8), math.random(-12, 12)), 8, true, false, 1, 0)
		fire.add_explosion(wall_pos, 8, true, false, 1, 0)
		system.wait(300)
		utilities.hard_remove_entity(vehicle_)
	end, nil)
end)

menu.add_feature("» Whitelist Everyone", "toggle", localparents["» Miscellaneous"].id, function(f, pid)
	for pid = 0, 31 do
		if f.on then
			IsPlayerWhitelisted[pid] = true
		end
		if not f.on then
			IsPlayerWhitelisted[pid] = false
		end
	end
end)

menu.add_feature("» Mark Everyone As Modder", "action_value_str", localparents["» Miscellaneous"].id, function(f, pid)
	for pid = 0, 31 do
		if f.value == 0 then
			player.set_player_as_modder(pid, -1)
		elseif f.value == 1 then
			player.set_player_as_modder(pid, 1)
		elseif f.value == 2 then
			player.set_player_as_modder(pid, 2)
		elseif f.value == 3 then
			player.set_player_as_modder(pid, 4)
		elseif f.value == 4 then
			player.set_player_as_modder(pid, 8)
		elseif f.value == 5 then
			player.set_player_as_modder(pid, 16)
		elseif f.value == 6 then
			player.set_player_as_modder(pid, 32)
		elseif f.value == 7 then
			player.set_player_as_modder(pid, 64)
		elseif f.value == 8 then
			player.set_player_as_modder(pid, 128)
		elseif f.value == 9 then
			player.set_player_as_modder(pid, 256)
		elseif f.value == 10 then
			player.set_player_as_modder(pid, 512)
		elseif f.value == 11 then
			player.set_player_as_modder(pid, 1024)
		elseif f.value == 12 then
			player.set_player_as_modder(pid, 2048)
		elseif f.value == 13 then
			player.set_player_as_modder(pid, 4096)
		elseif f.value == 14 then
			player.set_player_as_modder(pid, 8192)
		elseif f.value == 15 then
			player.set_player_as_modder(pid, 16384)
		elseif f.value == 16 then
			player.set_player_as_modder(pid, 32768)
		elseif f.value == 17 then
			player.set_player_as_modder(pid, 65536)
		elseif f.value == 18 then
			player.set_player_as_modder(pid, 131072)
		elseif f.value == 19 then
			player.set_player_as_modder(pid, 262144)
		elseif f.value == 20 then
			player.set_player_as_modder(pid, 524288)
		elseif f.value == 21 then
			player.set_player_as_modder(pid, 1048576)
		elseif f.value == 22 then
			player.set_player_as_modder(pid, 2097152)
		elseif f.value == 23 then
			player.set_player_as_modder(pid, 4194304)
		elseif f.value == 24 then
			player.set_player_as_modder(pid, custommodderflags["Modded Health"])
		elseif f.value == 25 then
			player.set_player_as_modder(pid, custommodderflags["Invalid SCID"])
		elseif f.value == 26 then
			player.set_player_as_modder(pid, custommodderflags["Invalid Name"])
		elseif f.value == 27 then
			player.set_player_as_modder(pid, custommodderflags["Godmode"])
		elseif f.value == 28 then
			player.set_player_as_modder(pid, custommodderflags["Bad Script Event"])
		elseif f.value == 29 then
			player.set_player_as_modder(pid, custommodderflags["Bad Net Event"])
		elseif f.value == 30 then
			player.set_player_as_modder(pid, custommodderflags["Stand User"])
		elseif f.value == 31 then
			player.set_player_as_modder(pid, custommodderflags["Invalid Stats"])
		elseif f.value == 32 then
			player.set_player_as_modder(pid, custommodderflags["Max Speed Bypass"])
		elseif f.value == 33 then
			player.set_player_as_modder(pid, custommodderflags["Invalid IP"])
		elseif f.value == 34 then
			player.set_player_as_modder(pid, custommodderflags["Session Host Crash"])
		elseif f.value == 35 then
			player.set_player_as_modder(pid, custommodderflags["Bad Outfit Data"])
		elseif f.value == 36 then
			player.set_player_as_modder(pid, custommodderflags["Altered SH Migration"])
		elseif f.value == 37 then
			player.set_player_as_modder(pid, custommodderflags["Fake Typing Indicator"])
		elseif f.value == 38 then
			player.set_player_as_modder(pid, custommodderflags["Modded Spectate"])
		elseif f.value == 39 then
			player.set_player_as_modder(pid, custommodderflags["Modded OTR"])
		end
	end
end):set_str_data({
	"All", "Manual", "Player Model", "SCID Spoof", "Invalid Object", "Invalid Ped Crash", "Model Change Crash", "Player Model Change", "RAC", "Money Drop", "SEP", "Attach Object", "Attach Ped", "Net Array Crash", "Net Sync Crash", "Net Event Crash", "Altered Host Token", "SE Spam", "Invalid Vehicle", "Frame Flags", "IP Spoof", "Karen", "Session Mismatch", "Sound Spam", "Modded Health", "Invalid SCID", "Invalid Name", "Godmode", "Bad Script Event", "Bad Net Event", "Stand User", "Invalid Stats", "Max Speed Bypass", "Invalid IP", "Session Host Crash", "Bad Outfit Data", "Altered SH Migration", "Fake Typing Indicator", "Modded Spectate", "Modded OTR"
})

menu.add_feature("» Unmark Everyone As Modder", "action_value_str", localparents["» Miscellaneous"].id, function(f, pid)
	for pid = 0, 31 do
		if f.value == 0 then
			player.unset_player_as_modder(pid, -1)
		elseif f.value == 1 then
			player.unset_player_as_modder(pid, 1)
		elseif f.value == 2 then
			player.unset_player_as_modder(pid, 2)
		elseif f.value == 3 then
			player.unset_player_as_modder(pid, 4)
		elseif f.value == 4 then
			player.unset_player_as_modder(pid, 8)
		elseif f.value == 5 then
			player.unset_player_as_modder(pid, 16)
		elseif f.value == 6 then
			player.unset_player_as_modder(pid, 32)
		elseif f.value == 7 then
			player.unset_player_as_modder(pid, 64)
		elseif f.value == 8 then
			player.unset_player_as_modder(pid, 128)
		elseif f.value == 9 then
			player.unset_player_as_modder(pid, 256)
		elseif f.value == 10 then
			player.unset_player_as_modder(pid, 512)
		elseif f.value == 11 then
			player.unset_player_as_modder(pid, 1024)
		elseif f.value == 12 then
			player.unset_player_as_modder(pid, 2048)
		elseif f.value == 13 then
			player.unset_player_as_modder(pid, 4096)
		elseif f.value == 14 then
			player.unset_player_as_modder(pid, 8192)
		elseif f.value == 15 then
			player.unset_player_as_modder(pid, 16384)
		elseif f.value == 16 then
			player.unset_player_as_modder(pid, 32768)
		elseif f.value == 17 then
			player.unset_player_as_modder(pid, 65536)
		elseif f.value == 18 then
			player.unset_player_as_modder(pid, 131072)
		elseif f.value == 19 then
			player.unset_player_as_modder(pid, 262144)
		elseif f.value == 20 then
			player.unset_player_as_modder(pid, 524288)
		elseif f.value == 21 then
			player.unset_player_as_modder(pid, 1048576)
		elseif f.value == 22 then
			player.unset_player_as_modder(pid, 2097152)
		elseif f.value == 23 then
			player.unset_player_as_modder(pid, 4194304)
		elseif f.value == 24 then
			player.unset_player_as_modder(pid, custommodderflags["Modded Health"])
		elseif f.value == 25 then
			player.unset_player_as_modder(pid, custommodderflags["Invalid SCID"])
		elseif f.value == 26 then
			player.unset_player_as_modder(pid, custommodderflags["Invalid Name"])
		elseif f.value == 27 then
			player.unset_player_as_modder(pid, custommodderflags["Godmode"])
		elseif f.value == 28 then
			player.unset_player_as_modder(pid, custommodderflags["Bad Script Event"])
		elseif f.value == 29 then
			player.unset_player_as_modder(pid, custommodderflags["Bad Net Event"])
		elseif f.value == 30 then
			player.unset_player_as_modder(pid, custommodderflags["Stand User"])
		elseif f.value == 31 then
			player.unset_player_as_modder(pid, custommodderflags["Invalid Stats"])
		elseif f.value == 32 then
			player.unset_player_as_modder(pid, custommodderflags["Max Speed Bypass"])
		elseif f.value == 33 then
			player.unset_player_as_modder(pid, custommodderflags["Invalid IP"])
		elseif f.value == 34 then
			player.unset_player_as_modder(pid, custommodderflags["Session Host Crash"])
		elseif f.value == 35 then
			player.unset_player_as_modder(pid, custommodderflags["Bad Outfit Data"])
		elseif f.value == 36 then
			player.unset_player_as_modder(pid, custommodderflags["Altered SH Migration"])
		elseif f.value == 37 then
			player.unset_player_as_modder(pid, custommodderflags["Fake Typing Indicator"])
		elseif f.value == 38 then
			player.unset_player_as_modder(pid, custommodderflags["Modded Spectate"])
		elseif f.value == 39 then
			player.unset_player_as_modder(pid, custommodderflags["Modded OTR"])
		end
	end
end):set_str_data({
	"All", "Manual", "Player Model", "SCID Spoof", "Invalid Object", "Invalid Ped Crash", "Model Change Crash", "Player Model Change", "RAC", "Money Drop", "SEP", "Attach Object", "Attach Ped", "Net Array Crash", "Net Sync Crash", "Net Event Crash", "Altered Host Token", "SE Spam", "Invalid Vehicle", "Frame Flags", "IP Spoof", "Karen", "Session Mismatch", "Sound Spam", "Modded Health", "Invalid SCID", "Invalid Name", "Godmode", "Bad Script Event", "Bad Net Event", "Stand User", "Invalid Stats", "Max Speed Bypass", "Invalid IP", "Session Host Crash", "Bad Outfit Data", "Altered SH Migration", "Fake Typing Indicator", "Modded Spectate", "Modded OTR"
})

feature["» Notify Session Host Migrations"] = menu.add_feature("» Notify Session Host Migrations", "toggle", localparents["» Miscellaneous"].id, function(f)
	if f.on then
		settings["» Notify Session Host Migrations"] = true
		while f.on do
			system.yield(0)
			local current_sh
			local sh_name
			if current_sh == nil then
				current_sh = player.get_host()
				sh_name = player.get_player_name(current_sh)
			end
			system.wait(2000)
			local new_sh = player.get_host()
			if current_sh ~= new_sh then
				if player.get_player_scid(new_sh) ~= -1 then
					menu.notify("[!] Session Host migrated from " .. string.format("%s", sh_name) .. " to " .. string.format("%s", player.get_player_name(new_sh)) .. ".", Meteor, 3, 0x64FA7800)
					sh_name = player.get_player_name(current_sh)
				end
			end
			system.wait(0)
		end
		system.wait(1000)
	end
	if not f.on then
		settings["» Notify Session Host Migrations"] = false
	end
end)
feature["» Notify Session Host Migrations"].on = settings["» Notify Session Host Migrations"]

feature["» Notify Script Host Migrations"] = menu.add_feature("» Notify Script Host Migrations", "toggle", localparents["» Miscellaneous"].id, function(f)
	if f.on then
		settings["» Notify Script Host Migrations"] = true
		while f.on do
			system.yield(0)
			local current_sh
			local sh_name
			if current_sh == nil then
				current_sh = script.get_host_of_this_script()
				sh_name = player.get_player_name(current_sh)
			end
			system.wait(2000)
			local new_sh = script.get_host_of_this_script()
			if current_sh ~= new_sh then
				if player.get_player_scid(new_sh) ~= -1 then
					menu.notify("[!] Script Host migrated from " .. string.format("%s", sh_name) .. " to " .. string.format("%s", player.get_player_name(new_sh)) .. ".", Meteor, 3, 0x64FA7800)
					sh_name = player.get_player_name(current_sh)
				end
			end
			system.wait(0)
		end
		system.wait(1000)
	end
	if not f.on then
		settings["» Notify Script Host Migrations"] = false
	end
end)
feature["» Notify Script Host Migrations"].on = settings["» Notify Script Host Migrations"]

feature["» Notify Typing Players"] = menu.add_feature("» Notify Typing Players", "toggle", localparents["» Miscellaneous"].id, function(f)
	if f.on then
		settings["» Notify Typing Players"] = true
	end
	if not f.on then
		settings["» Notify Typing Players"] = false
	end
end)
feature["» Notify Typing Players"].on = settings["» Notify Typing Players"]

feature["» Guided Missile Tracker"] = menu.add_feature("» Guided Missile Tracker", "toggle", localparents["» Miscellaneous"].id, function(f, pid)
	if f.on then
		settings["» Guided Missile Tracker"] = true
		while f.on do
			system.yield(1000)
			local objects = object.get_all_objects()
			for i = 1, #objects do
				if entity.get_entity_model_hash(objects[i]) == 1262355818 then
					if ui.get_blip_from_entity(objects[i]) == 0 and objects[i] ~= guided_missile_object then
						local blip_ = ui.add_blip_for_entity(objects[i])
						ui.set_blip_sprite(blip_, 548)
						ui.set_blip_colour(blip_, 1)
						menu.notify("Spotted a guided missile " .. utilities.round(utilities.get_distance_between(objects[i], player.get_player_coords(player.player_id()))) .. "m away!", Meteor, 8, 0x64FA7800)
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Guided Missile Tracker"] = false
	end
end)
feature["» Guided Missile Tracker"].on = settings["» Guided Missile Tracker"]

feature["» Kill Tracker"] = menu.add_feature("» Kill Tracker", "toggle", localparents["» Miscellaneous"].id, function(f, pid)
	if f.on then
		settings["» Kill Tracker"] = true
		while f.on do
			system.yield(100)
			for pid = 0, 31 do
				if entity.is_entity_dead(player.get_player_ped(pid)) then
					if not IsPlayerDead[pid] then
						for pid2 = 0, 31 do
							if entity.has_entity_been_damaged_by_entity(player.get_player_ped(pid), player.get_player_ped(pid2)) then
								if player.is_player_valid(pid) and player.is_player_valid(pid2) then
									if pid == pid2 then
										if player.is_player_female(pid) then
											menu.notify(string.format("%s", player.get_player_name(pid2)) .. " Killed Her Self", "Kill Tracker", 4, 0x64FA7800)
										else
											menu.notify(string.format("%s", player.get_player_name(pid2)) .. " Killed Him Self", "Kill Tracker", 4, 0x64FA7800)
										end
									elseif pid ~= pid2 then
										menu.notify("Player: " .. string.format("%s", player.get_player_name(pid2)) .. "\nKilled: " .. string.format("%s", player.get_player_name(pid)), "Kill Tracker", 4, 0x64FA7800)
									end
								end
							end
							system.wait(0)
						end
					end
					IsPlayerDead[pid] = true
					IsPlayerAlive[pid] = false
				elseif not entity.is_entity_dead(player.get_player_ped(pid)) and IsPlayerDead[pid] then
					IsPlayerDead[pid] = false
					IsPlayerAlive[pid] = true
				end
				system.wait(0)
			end
		end
	end
	if not f.on then
		settings["» Kill Tracker"] = false
	end
end)
feature["» Kill Tracker"].on = settings["» Kill Tracker"]

feature["» Anti Barcode"] = menu.add_feature("» Anti Barcode", "toggle", localparents["» Miscellaneous"].id, function(f, pid)
	if f.on then
		settings["» Anti Barcode"] = true
		while f.on do
			system.yield(2000)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if string.find(player.get_player_name(pid), "llll") or string.find(player.get_player_name(pid), "IIII") or string.find(player.get_player_name(pid), "lI") or string.find(player.get_player_name(pid), "Il") or string.find(player.get_player_name(pid), "llI") or string.find(player.get_player_name(pid), "IIl") or string.find(player.get_player_name(pid), "lII") or string.find(player.get_player_name(pid), "Ill") then
						menu.notify("[!] Kicked Barcode\n" .. string.format("%s", player.get_player_name(pid)) .. "/" .. player.get_player_scid(pid) .. "", Meteor, 8, 0x64FA7800)
						if network.network_is_host() then
							network.network_session_kick_player(pid)
						elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
							utilities.se_kick(pid)
						else
							network.force_remove_player(pid)
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Anti Barcode"] = false
	end
end)
feature["» Anti Barcode"].on = settings["» Anti Barcode"]

feature["» Anti Chat Spammer"] = menu.add_feature("» Anti Chat Spammer", "value_str", localparents["» Miscellaneous"].id, function(f, pid)
	if f.on then
		settings["» Anti Chat Spammer"] = true
		feature_value_settings["» Anti Chat Spammer"] = f.value
		for i = 0, 31 do
			SentXMessagesInTheLast5Seconds[i] = 0
		end
		while f.on do
			system.yield(5000)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if f.value == 0 then
						if SentXMessagesInTheLast5Seconds[pid] > 5 and pid ~= player.player_id() then
							menu.notify("[!] Kicked Chat Spammer\n" .. string.format("%s", player.get_player_name(pid)) .. "/" .. player.get_player_scid(pid) .. "", Meteor, 8, 0x64FA7800)
							if network.network_is_host() then
								network.network_session_kick_player(pid)
							elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
								utilities.se_kick(pid)
							else
								network.force_remove_player(pid)
							end
							SentXMessagesInTheLast5Seconds[pid] = 0
						else
							SentXMessagesInTheLast5Seconds[pid] = 0
						end
					elseif f.value == 1 then
						if SentXMessagesInTheLast5Seconds[pid] > 10 and pid ~= player.player_id() then
							menu.notify("[!] Kicked Chat Spammer\n" .. string.format("%s", player.get_player_name(pid)) .. "/" .. player.get_player_scid(pid) .. "", Meteor, 8, 0x64FA7800)
							if network.network_is_host() then
								network.network_session_kick_player(pid)
							elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
								utilities.se_kick(pid)
							else
								network.force_remove_player(pid)
							end
							SentXMessagesInTheLast5Seconds[pid] = 0
						else
							SentXMessagesInTheLast5Seconds[pid] = 0
						end
					elseif f.value == 2 then
						if SentXMessagesInTheLast5Seconds[pid] > 20 and pid ~= player.player_id() then
							menu.notify("[!] Kicked Chat Spammer\n" .. string.format("%s", player.get_player_name(pid)) .. "/" .. player.get_player_scid(pid) .. "", Meteor, 8, 0x64FA7800)
							if network.network_is_host() then
								network.network_session_kick_player(pid)
							elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
								utilities.se_kick(pid)
							else
								network.force_remove_player(pid)
							end
							SentXMessagesInTheLast5Seconds[pid] = 0
						else
							SentXMessagesInTheLast5Seconds[pid] = 0
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Anti Chat Spammer"] = false
		feature_value_settings["» Anti Chat Spammer"] = f.value
		for i = 0, 31 do
			SentXMessagesInTheLast5Seconds[i] = 0
		end
	end
end)
feature["» Anti Chat Spammer"].on = settings["» Anti Chat Spammer"]
feature["» Anti Chat Spammer"]:set_str_data({"Low", "Medium", "Severe"})
feature["» Anti Chat Spammer"].value = feature_value_settings["» Anti Chat Spammer"]

menu.add_feature("» Anti Crash Cam", "toggle", localparents["» Miscellaneous"].id, function(f)
	if f.on then
		anti_crash_cam_pos = player.get_player_coords(player.player_id())
		while f.on do
			system.yield(0)
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-8292.664, -4596.8257, 14358.0))
		end
	end
	if not f.on then
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), anti_crash_cam_pos)
	end
end)

menu.add_feature("» Ped Pickup Recovery", "toggle", localparents["» Miscellaneous"].id, function(f)
	if f.on then
		ped_pickup_recovery_previous_pos = player.get_player_coords(player.player_id())
		time.set_clock_time(12, 0, 0)
		threads["» Ped Pickup Recovery"] = menu.create_thread(function()
			while f.on do
				system.yield(0)
				local time = utils.time_ms() + 3000
				while time > utils.time_ms() do
					system.yield(0)
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(202.6890411377, 198.03338623047, 105.56772613525))
				end
				local time = utils.time_ms() + 3000
				while time > utils.time_ms() do
					system.yield(0)
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-222.50701904297, 260.52154541016, 92.078979492188))
				end
				local time = utils.time_ms() + 3000
				while time > utils.time_ms() do
					system.yield(0)
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(259.76602172852, -952.65618896484, 29.348138809204))
				end
				local time = utils.time_ms() + 3000
				while time > utils.time_ms() do
					system.yield(0)
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-1464.9326171875, -975.77996826172, 7.0034499168396))
				end
				local time = utils.time_ms() + 3000
				while time > utils.time_ms() do
					system.yield(0)
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-109.40335845947, -229.88471984863, 44.816974639893))
				end
			end
		end, nil)
		while f.on do
			system.yield(0)
			local peds = ped.get_all_peds()
			for i = 1, #peds do
				if not ped.is_ped_a_player(peds[i]) and not entity.is_entity_dead(peds[i]) and not ped.is_ped_in_any_vehicle(peds[i]) then
					ped.set_ped_max_health(peds[i], 0)
					ped.set_ped_health(peds[i], 0)
				end
			end
			local pickups = object.get_all_pickups()
			for i = 1, #pickups do
				if entity.get_entity_model_hash(pickups[i]) == 3999186071 or entity.get_entity_model_hash(pickups[i]) == 289396019 or entity.get_entity_model_hash(pickups[i]) == 2628187989 then
					network.request_control_of_entity(pickups[i])
					entity.set_entity_coords_no_offset(pickups[i], player.get_player_coords(player.player_id()))
				end
			end
		end
	end
	if not f.on then
		if threads["» Ped Pickup Recovery"] then
			menu.delete_thread(threads["» Ped Pickup Recovery"])
		end
		if ped_pickup_recovery_previous_pos then
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), ped_pickup_recovery_previous_pos)
			ped_pickup_recovery_previous_pos = nil
		end
	end
end)

localparents["» Player Info Tab"] = menu.add_feature("» Player Info Tab", "parent", localparents["» Miscellaneous"].id)

feature["» Player Info Tab"] = menu.add_feature("» Player Info Tab", "toggle", localparents["» Player Info Tab"].id, function(f, pid)
	if f.on then
		settings["» Player Info Tab"] = true
		while f.on do
			system.yield(0)
			pos_y = settings["» Tab 1 Y Position"] / 100
			for pid = 0, 15 do
				if player.is_player_valid(pid) then
					player_str = ""
					if pid == player.player_id() then
						player_str = player_str .. "Y"
					end
					if player.is_player_friend(pid) then
						player_str = player_str .. "F"
					end
					if player.is_player_modder(pid, -1) then
						player_str = player_str .. "M"
					end
					if utilities.is_player_rockstar_admin_scid(pid) or utilities.is_player_rockstar_admin_name(pid) or utilities.is_player_rockstar_admin_ip(pid) then
						player_str = player_str .. "A"
					end
					if player.is_player_host(pid) then
						player_str = player_str .. "H"
					end
					if pid == script.get_host_of_this_script() then
						player_str = player_str .. "S"
					end
					local str1 = "[" .. script_func.get_player_ceo_int(pid) .. "] [" .. player_str .. "] " .. player.get_player_name(pid) .. " {ID: " .. pid .. "} {Rank: " .. script_func.get_player_rank(pid) .. "} {" .. script_func.get_player_money_str(pid) .. "} {Priority: " .. player.get_player_host_priority(pid) .. "} {KD: " .. utilities.round_two_dc(script_func.get_player_kd(pid)) .. "}"
					ui.set_text_scale(0.24)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					if script_func.get_player_ceo_int(pid) == 10 then
						ui.set_text_color(30, 100, 152, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 9 then
						ui.set_text_color(216, 85, 117, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 8 then
						ui.set_text_color(0, 132, 114, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 7 then
						ui.set_text_color(178, 144, 132, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 6 then
						ui.set_text_color(181, 214, 234, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 5 then
						ui.set_text_color(141, 206, 167, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 4 then
						ui.set_text_color(160, 140, 193, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 3 then
						ui.set_text_color(113, 169, 175, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 2 then
						ui.set_text_color(239, 238, 151, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 1 then
						ui.set_text_color(226, 134, 187, settings["» Tab 1 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 0 then
						ui.set_text_color(247, 159, 123, settings["» Tab 1 Alpha"])
					else
						ui.set_text_color(255, 255, 255, settings["» Tab 1 Alpha"])
					end
					ui.draw_text(str1, v2(settings["» Tab 1 X Position"] / 100, pos_y))
					pos_y = pos_y + 0.017
				end
			end
			pos_y = settings["» Tab 2 Y Position"] / 100
			for pid = 16, 31 do
				if player.is_player_valid(pid) then
					player_str = ""
					if pid == player.player_id() then
						player_str = player_str .. "Y"
					end
					if player.is_player_friend(pid) then
						player_str = player_str .. "F"
					end
					if player.is_player_modder(pid, -1) then
						player_str = player_str .. "M"
					end
					if utilities.is_player_rockstar_admin_scid(pid) or utilities.is_player_rockstar_admin_name(pid) or utilities.is_player_rockstar_admin_ip(pid) then
						player_str = player_str .. "A"
					end
					if player.is_player_host(pid) then
						player_str = player_str .. "H"
					end
					if pid == script.get_host_of_this_script() then
						player_str = player_str .. "S"
					end
					local str1 = "[" .. script_func.get_player_ceo_int(pid) .. "] [" .. player_str .. "] " .. player.get_player_name(pid) .. " {ID: " .. pid .. "} {Rank: " .. script_func.get_player_rank(pid) .. "} {" .. script_func.get_player_money_str(pid) .. "} {Priority: " .. player.get_player_host_priority(pid) .. "} {KD: " .. utilities.round_two_dc(script_func.get_player_kd(pid)) .. "}"
					ui.set_text_scale(0.24)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					if script_func.get_player_ceo_int(pid) == 10 then
						ui.set_text_color(30, 100, 152, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 9 then
						ui.set_text_color(216, 85, 117, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 8 then
						ui.set_text_color(0, 132, 114, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 7 then
						ui.set_text_color(178, 144, 132, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 6 then
						ui.set_text_color(181, 214, 234, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 5 then
						ui.set_text_color(141, 206, 167, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 4 then
						ui.set_text_color(160, 140, 193, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 3 then
						ui.set_text_color(113, 169, 175, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 2 then
						ui.set_text_color(239, 238, 151, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 1 then
						ui.set_text_color(226, 134, 187, settings["» Tab 2 Alpha"])
					elseif script_func.get_player_ceo_int(pid) == 0 then
						ui.set_text_color(247, 159, 123, settings["» Tab 2 Alpha"])
					else
						ui.set_text_color(255, 255, 255, settings["» Tab 2 Alpha"])
					end
					ui.draw_text(str1, v2(settings["» Tab 2 X Position"] / 100, pos_y))
					pos_y = pos_y + 0.017
				end
			end
		end
	end
	if not f.on then
		settings["» Player Info Tab"] = false
	end
end)
feature["» Player Info Tab"].on = settings["» Player Info Tab"]

feature["» Tab 1 X Position"] = menu.add_feature("» Tab 1 X Position", "autoaction_value_i", localparents["» Player Info Tab"].id, function(f, pid)
	settings["» Tab 1 X Position"] = f.value
end)
feature["» Tab 1 X Position"].max = 100
feature["» Tab 1 X Position"].min = 0
feature["» Tab 1 X Position"].mod = 1
feature["» Tab 1 X Position"].value = settings["» Tab 1 X Position"]

feature["» Tab 2 X Position"] = menu.add_feature("» Tab 2 X Position", "autoaction_value_i", localparents["» Player Info Tab"].id, function(f, pid)
	settings["» Tab 2 X Position"] = f.value
end)
feature["» Tab 2 X Position"].max = 100
feature["» Tab 2 X Position"].min = 0
feature["» Tab 2 X Position"].mod = 1
feature["» Tab 2 X Position"].value = settings["» Tab 2 X Position"]

feature["» Tab 1 Y Position"] = menu.add_feature("» Tab 1 Y Position", "autoaction_value_i", localparents["» Player Info Tab"].id, function(f, pid)
	settings["» Tab 1 Y Position"] = f.value
end)
feature["» Tab 1 Y Position"].max = 100
feature["» Tab 1 Y Position"].min = 0
feature["» Tab 1 Y Position"].mod = 1
feature["» Tab 1 Y Position"].value = settings["» Tab 1 Y Position"]

feature["» Tab 2 Y Position"] = menu.add_feature("» Tab 2 Y Position", "autoaction_value_i", localparents["» Player Info Tab"].id, function(f, pid)
	settings["» Tab 2 Y Position"] = f.value
end)
feature["» Tab 2 Y Position"].max = 100
feature["» Tab 2 Y Position"].min = 0
feature["» Tab 2 Y Position"].mod = 1
feature["» Tab 2 Y Position"].value = settings["» Tab 2 Y Position"]

feature["» Tab 1 Alpha"] = menu.add_feature("» Tab 1 Alpha", "autoaction_value_i", localparents["» Player Info Tab"].id, function(f, pid)
	settings["» Tab 1 Alpha"] = f.value
end)
feature["» Tab 1 Alpha"].max = 255
feature["» Tab 1 Alpha"].min = 0
feature["» Tab 1 Alpha"].mod = 5
feature["» Tab 1 Alpha"].value = settings["» Tab 1 Alpha"]

feature["» Tab 2 Alpha"] = menu.add_feature("» Tab 2 Alpha", "autoaction_value_i", localparents["» Player Info Tab"].id, function(f, pid)
	settings["» Tab 2 Alpha"] = f.value
end)
feature["» Tab 2 Alpha"].max = 255
feature["» Tab 2 Alpha"].min = 0
feature["» Tab 2 Alpha"].mod = 5
feature["» Tab 2 Alpha"].value = settings["» Tab 2 Alpha"]

--

localparents["» Script Events"] = menu.add_feature("» Script Events", "parent", localparents["» Session Malicious"].id)

menu.add_feature("» Set Bounty", "action_value_str", localparents["» Script Events"].id, function(f, pid)
    local input_stat, input_val = input.get("Enter Bounty Amount (0-10000)", "", 5, 3)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if f.value == 0 then
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x4D3010A8, pid, {player.player_id(), pid, 1, input_val, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script_func.get_global_9(), script_func.get_global_10()})
			end
		end
	elseif f.value == 1 then
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x4D3010A8, pid, {player.player_id(), pid, 1, input_val, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script_func.get_global_9(), script_func.get_global_10()})
			end
		end
	end
end):set_str_data({
	"Anonymous",
	"Named"
})

menu.add_feature("» Send To Perico", "action_value_str", localparents["» Script Events"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			if f.value == 0 then
				script.trigger_script_event(-621279188, pid, {player.player_id(), 1})
			elseif f.value == 1 then
				script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
			elseif f.value == 2 then
				script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
			end
		end
	end
end):set_str_data({
	"v1",
	"v2",
	"v3"
})

menu.add_feature("» Send To Warehouse", "action", localparents["» Script Events"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			script.trigger_script_event(0xE56661F6, pid, {player.player_id(), 0, 1, math.random(1, 22)})
		end
	end
end)

menu.add_feature("» Send To Mission", "action", localparents["» Script Events"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			script.trigger_script_event(0x786FBAAE, pid, {player.player_id(), math.random(1, 7)})
		end
	end
end)

menu.add_feature("» Force Casino Cutscene", "action", localparents["» Script Events"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			script.trigger_script_event(0x3FAC59CA, pid, {player.player_id()})
		end
	end
end)

menu.add_feature("» Infinite Loading Screen", "action_value_str", localparents["» Script Events"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			if f.value == 0 then
				script.trigger_script_event(603406648, pid, {player.player_id(), 217})
			elseif f.value == 1 then
				script.trigger_script_event(962740265, pid, {player.player_id(), math.random(1, 12)})
			end
		end
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_feature("» Cash Removed Notification", "action_value_str", localparents["» Script Events"].id, function(f, pid)
	if f.value == 0 then
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 689178114, math.random(-2147483647, 2147483647)})
			end
		end
	else
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 689178114, input_val})
			end
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_feature("» Cash Stolen Notification", "action_value_str", localparents["» Script Events"].id, function(f, pid)
	if f.value == 0 then
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 2187973097, math.random(-2147483647, 2147483647)})
			end
		end
	elseif f.value == 1 then
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 2187973097, input_val})
			end
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_feature("» Cash Banked Notification", "action_value_str", localparents["» Script Events"].id, function(f, pid)
	if f.value == 0 then
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 1990572980, math.random(-2147483647, 2147483647)})
			end
		end
	else
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 1990572980, input_val})
			end
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_feature("» Insurance Notification", "action_value_str", localparents["» Script Events"].id, function(f, pid)
	if f.value == 0 then
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x2FCF970F, pid, {player.player_id(), math.random(-2147483647, 2147483647)})
			end
		end
	elseif f.value == 1 then
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x2FCF970F, pid, {player.player_id(), input_val})
			end
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_feature("» Freeze Camera", "toggle", localparents["» Script Events"].id, function(f, pid)
	while f.on do
		system.yield(0)
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(1463943751, pid, {player.player_id()})
			end
		end
	end
end)

menu.add_feature("» Camera Manipulation", "toggle", localparents["» Script Events"].id, function(f, pid)
	while f.on do
		system.yield(0)
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x2FC154DC, pid, {player.player_id(), 869796886, 0})
			end
		end
	end
end)

menu.add_feature("» Bribe Authorities", "toggle", localparents["» Script Events"].id, function(f, pid)
	while f.on do
		system.yield(0)
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x66B0F59A, pid, {player.player_id(), 0, 0, utils.time_ms(), 0, script_func.get_global_main(pid)})
				system.wait(5000)
			end
		end
	end
end)

menu.add_feature("» Off The Radar", "toggle", localparents["» Script Events"].id, function(f, pid)
	while f.on do
		system.yield(0)
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(-0x1757DB60, pid, {player.player_id(), utils.time() - 60, utils.time(), 1, 1, script_func.get_global_main(pid)})
				system.wait(5000)
			end
		end
	end
end)

menu.add_feature("» Transaction Error", "toggle", localparents["» Script Events"].id, function(f, pid)
	if f.on then
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(-0x659322C8, pid, {player.player_id(), 50000, 0, 1, script_func.get_global_main(pid), script_func.get_global_9(), script_func.get_global_10(), 1})
			end
		end
	end
	return HANDLER_CONTINUE
end)

menu.add_feature("» Block Passive Mode", "toggle", localparents["» Script Events"].id, function(f, pid)
	while f.on do
		system.yield(0)
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x4267B065, pid, {player.player_id(), 1})
				system.wait(500)
			end
		end
	end
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			script.trigger_script_event(0x4267B065, pid, {player.player_id(), 0})
		end
	end
end)

localparents["» Vehicle Related"] = menu.add_feature("» Vehicle Related", "parent", localparents["» Script Events"].id)

menu.add_feature("» Disable Ability To Drive", "action", localparents["» Vehicle Related"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			script.trigger_script_event(0x23F74138, pid, {player.player_id(), 2, 4294967295, 1, 115, 0, 0, 0})
		end
	end
end)

menu.add_feature("» Vehicle Kick", "action", localparents["» Vehicle Related"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			script.trigger_script_event(0x2280A552, pid, {player.player_id(), 4294967295, 4294967295, 4294967295})
		end
	end
end)

menu.add_feature("» Vehicle EMP", "action", localparents["» Vehicle Related"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			local pos = player.get_player_coords(pid)
			script.trigger_script_event(-0x79C49B6C, pid, {player.player_id(), utilities.to_int(pos.x), utilities.to_int(pos.y), utilities.to_int(pos.z), 0})
		end
	end
end)

menu.add_feature("» Destroy Personal Vehicle", "action", localparents["» Vehicle Related"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			script.trigger_script_event(-0x3D33889E, pid, {player.player_id(), pid})
			script.trigger_script_event(0x2280A552, pid, {player.player_id(), 4294967295, 4294967295, 4294967295})
		end
	end
end)

localparents["» Apartment Invites"] = menu.add_feature("» Apartment Invites", "parent", localparents["» Script Events"].id)

menu.add_feature("» Infinite Apartment Invite", "action", localparents["» Apartment Invites"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			script.trigger_script_event(0x23F74138, pid, {player.player_id(), pid, 4294967295, 1, 115, 0, 0, 0})
		end
	end
end)

menu.add_feature("» Random Apartment Invite", "action", localparents["» Apartment Invites"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			script.trigger_script_event(0x23F74138, pid, {player.player_id(), pid, 1, 0, math.random(1, 114), 1, 1, 1})
		end
	end
end)

menu.add_feature("» Apartment Invite Loop", "toggle", localparents["» Apartment Invites"].id, function(f, pid)
	while f.on do
		for pid = 0, 31 do
			if pid ~= player.player_id() and player.is_player_valid(pid) then
				script.trigger_script_event(0x23F74138, pid, {player.player_id(), pid, 1, 0, math.random(1, 114), 1, 1, 1})
				system.wait(5000)
			end
		end
	end
end)

feature["» Russian Roulette"] = menu.add_feature("» Russian Roulette", "action_value_str", localparents["» Session Malicious"].id, function(f, pid)
	feature_value_settings["» Russian Roulette"] = f.value
	if network.is_session_started() then
		for pid = 0, 31 do
			if pid ~= player.player_id() then
				rndint = math.random(1, 6)
				if rndint == 3 then
					if f.value == 0 then
						fire.add_explosion(player.get_player_coords(pid), 0, false, true, 0, player.get_player_ped(pid))
					elseif f.value == 1 then
						if network.network_is_host() then
							network.network_session_kick_player(pid)
						elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
							utilities.se_kick(pid)
						else
							network.force_remove_player(pid)
						end
					elseif f.value == 2 then
						if player.is_player_valid(pid) then
							script.trigger_script_event(962740265, pid, {pid, 23243, 5332, 3324, pid})
						end
					end
				end
			end
		end
	else
		menu.notify("[!] You can't use this feature in Singleplayer", Meteor, 3, 211)
	end
end)
feature["» Russian Roulette"]:set_str_data({"Kill", "Kick", "Crash"})
feature["» Russian Roulette"].value = feature_value_settings["» Russian Roulette"]

menu.add_feature("» Electrocute Session", "action", localparents["» Session Malicious"].id, function(f, pid)
	for pid = 0, 31 do
		if pid ~= player.player_id() and player.is_player_valid(pid) then
			gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid) + v3(0, 0, 2), player.get_player_coords(pid), 0, gameplay.get_hash_key("weapon_stungun"), player.get_player_ped(player.player_id()), true, false, 10000)
		end
	end
end)

menu.add_feature("» Get Session Host", "action", localparents["» Session Malicious"].id, function(f, pid)
	if network.is_session_started() then
		if network.network_is_host() then
			menu.notify("[!] You are already the session host!", Meteor, 3, 211)
		else
			if utilities.is_friend_in_queue() then
				if utilities.get_host_queue_count() == 1 then
					local input_stat, input_val = input.get("There is " .. utilities.get_host_queue_count() .. " Player before you in the Host Queue (Including Friends). Type \"Yes\" To Continue..", "", 3, 0)
					if input_stat == 1 then
						return HANDLER_CONTINUE
					end
					if input_stat == 2 then
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
						return HANDLER_POP
					end
					if input_val == "Yes" then
						for pid = 0, 31 do
							if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) then
								if player.is_player_host(pid) and player.is_player_modder(pid, -1) then
									utilities.se_kick(pid)
								else
									network.force_remove_player(pid)
								end
							end
						end
						system.wait(4000)
						if network.network_is_host() then
							menu.notify("[!] Successfully got Session Host!", Meteor)
						else
							menu.notify("[!] Failed to get Session Host!", Meteor, 3, 211)
						end
					else
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
					end
				elseif utilities.get_host_queue_count() == 0 then
					local input_stat, input_val = input.get("There are " .. utilities.get_host_queue_count() .. " Players before you in the Host Queue (Including Friends). Type \"Yes\" To Continue..", "", 3, 0)
					if input_stat == 1 then
						return HANDLER_CONTINUE
					end
					if input_stat == 2 then
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
						return HANDLER_POP
					end
					if input_val == "Yes" then
						network.force_remove_player(player.get_host())
						system.wait(4000)
						if network.network_is_host() then
							menu.notify("[!] Successfully got Session Host!", Meteor)
						else
							menu.notify("[!] Failed to get Session Host!", Meteor, 3, 211)
						end
					else
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
					end
				else
					local input_stat, input_val = input.get("There are " .. utilities.get_host_queue_count() .. " Players before you in the Host Queue (Including Friends). Type \"Yes\" To Continue..", "", 3, 0)
					if input_stat == 1 then
						return HANDLER_CONTINUE
					end
					if input_stat == 2 then
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
						return HANDLER_POP
					end
					if input_val == "Yes" then
						for pid = 0, 31 do
							if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) then
								network.force_remove_player(pid)
							end
						end
						system.wait(4000)
						if network.network_is_host() then
							menu.notify("[!] Successfully got Session Host!", Meteor)
						else
							menu.notify("[!] Failed to get Session Host!", Meteor, 3, 211)
						end
					else
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
					end
				end
			else
				if utilities.get_host_queue_count() == 1 then
					local input_stat, input_val = input.get("There is " .. utilities.get_host_queue_count() .. " Player before you in the Host Queue. Type \"Yes\" To Continue..", "", 3, 0)
					if input_stat == 1 then
						return HANDLER_CONTINUE
					end
					if input_stat == 2 then
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
						return HANDLER_POP
					end
					if input_val == "Yes" then
						for pid = 0, 31 do
							if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) then
								network.force_remove_player(pid)
							end
						end
						system.wait(4000)
						if network.network_is_host() then
							menu.notify("[!] Successfully got Session Host!", Meteor)
						else
							menu.notify("[!] Failed to get Session Host!", Meteor, 3, 211)
						end
					else
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
					end
				elseif utilities.get_host_queue_count() == 0 then
					local input_stat, input_val = input.get("There are " .. utilities.get_host_queue_count() .. " Players before you in the Host Queue. Type \"Yes\" To Continue..", "", 3, 0)
					if input_stat == 1 then
						return HANDLER_CONTINUE
					end
					if input_stat == 2 then
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
						return HANDLER_POP
					end
					if input_val == "Yes" then
						network.force_remove_player(player.get_host())
						system.wait(4000)
						if network.network_is_host() then
							menu.notify("[!] Successfully got Session Host!", Meteor)
						else
							menu.notify("[!] Failed to get Session Host!", Meteor, 3, 211)
						end
					else
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
					end
				else
					local input_stat, input_val = input.get("There are " .. utilities.get_host_queue_count() .. " Players before you in the Host Queue. Type \"Yes\" To Continue..", "", 3, 0)
					if input_stat == 1 then
						return HANDLER_CONTINUE
					end
					if input_stat == 2 then
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
						return HANDLER_POP
					end
					if input_val == "Yes" then
						for pid = 0, 31 do
							if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) then
								network.force_remove_player(pid)
							end
						end
						system.wait(4000)
						if network.network_is_host() then
							menu.notify("[!] Successfully got Session Host!", Meteor)
						else
							menu.notify("[!] Failed to get Session Host!", Meteor, 3, 211)
						end
					else
						menu.notify("[!] Cancelled!", Meteor, 3, 211)
					end
				end
			end
		end
	else
		menu.notify("[!] You can't use this feature in Singleplayer", Meteor, 3, 211)
	end
end)

feature["» Random Player"] = menu.add_feature("» Random Player", "action_value_str", localparents["» Session Malicious"].id, function(f, pid)
	feature_value_settings["» Random Player"] = f.value
	if network.is_session_started() then
		local player_id = math.random(0, 31)
		if player.is_player_valid(player_id) and player_id ~= player.player_id() and player.player_count() > 1 then
			if f.value == 0 then
				if network.network_is_host() then
					network.network_session_kick_player(player_id)
				elseif player.is_player_host(player_id) and player.is_player_modder(player_id, -1) then
					utilities.se_kick(player_id)
				else
					network.force_remove_player(player_id)
				end
			elseif f.value == 1 then
				if player.is_player_valid(player_id) then
					script.trigger_script_event(962740265, player_id, {player_id, 23243, 5332, 3324, player_id})
				end
			elseif f.value == 2 then
				fire.add_explosion(player.get_player_coords(player_id), 0, false, true, 0, player.get_player_ped(player_id))
			elseif f.value == 3 then
				gameplay.shoot_single_bullet_between_coords(player.get_player_coords(player_id) + v3(0, 0, 2), player.get_player_coords(player_id), 0, gameplay.get_hash_key("weapon_stungun"), player.get_player_ped(player.player_id()), true, false, 10000)
			end
			return HANDLER_POP
		else
			return HANDLER_CONTINUE
		end
	else
		menu.notify("[!] You can't use this feature in Singleplayer", Meteor, 3, 211)
	end
end)
feature["» Random Player"]:set_str_data({ "Kick", "Crash", "Kill", "Electrocute"})
feature["» Random Player"].value = feature_value_settings["» Random Player"]

menu.add_feature("» Crash Session Host", "action", localparents["» Session Malicious"].id, function(f, pid)
    if network.network_is_host() then
        menu.notify("You are the session host. You can't use this feature", Meteor, 3, 211)
        return
    end
    local pos = player.get_player_coords(player.player_id())
    entity.freeze_entity(player.get_player_ped(player.player_id()), true)
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-6170, 10837, 40))
    system.wait(1000)
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
    entity.freeze_entity(player.get_player_ped(player.player_id()), false)
end)

menu.add_feature("» Launch Guided Missile", "toggle", localparents["» Session Malicious"].id, function(f)
	if f.on then
		launch_guided_missile_previous_pos = player.get_player_coords(player.player_id())
		guided_missile_object = object.create_object(1262355818, player.get_player_coords(player.player_id()) + v3(0, 0, 20), true, true)
		network.request_control_of_entity(guided_missile_object)
		network.request_control_of_entity(player.get_player_ped(player.player_id()))
		entity.apply_force_to_entity(guided_missile_object, 3, 0, 0, 0, 0.0, 0.0, 0.0, false, true)
		while f.on do
			system.yield(0)
			network.request_control_of_entity(guided_missile_object)
			entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
			entity.set_entity_collision(player.get_player_ped(player.player_id()), false, false, false)
			entity.set_entity_rotation(guided_missile_object, cam.get_gameplay_cam_rot() + v3(180, 0, 0))
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), entity.get_entity_coords(guided_missile_object))
			local pos = entity.get_entity_coords(guided_missile_object)
			local dir = entity.get_entity_rotation(guided_missile_object) + v3(180, 0, 0)
			dir:transformRotToDir()
			dir = dir * 8
			pos = pos + dir
			dir = nil
			local pos_target = entity.get_entity_coords(guided_missile_object)
			dir = entity.get_entity_rotation(guided_missile_object) + v3(180, 0, 0)
			dir:transformRotToDir()
			dir = dir * 100
			pos_target = pos_target + dir
			local vectorV3 = pos_target - pos
			entity.apply_force_to_entity(guided_missile_object, 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, false, true)
			if entity.has_entity_collided_with_anything(guided_missile_object) or not f.on then
				fire.add_explosion(entity.get_entity_coords(guided_missile_object), 8, true, false, 0.3, player.get_player_ped(player.player_id()))
				fire.add_explosion(entity.get_entity_coords(guided_missile_object), 60, true, false, 0.3, player.get_player_ped(player.player_id()))
				launch_guided_missile_pos = entity.get_entity_coords(guided_missile_object)
				utilities.hard_remove_entity(guided_missile_object)
				local time = utils.time_ms() + 3000
				launch_guided_missile_pos_tp = launch_guided_missile_pos + v3(math.random(-30, 30), math.random(-30, 30), 20)
				while time > utils.time_ms() do
					system.yield(0)
					entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), launch_guided_missile_pos_tp)
				end
				entity.set_entity_collision(player.get_player_ped(player.player_id()), true, true, false)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), launch_guided_missile_previous_pos)
				f.on = false
			end
			if entity.is_entity_in_water(guided_missile_object) then
				fire.add_explosion(entity.get_entity_coords(guided_missile_object), 52, true, false, 0.3, player.get_player_ped(player.player_id()))
				launch_guided_missile_pos = entity.get_entity_coords(guided_missile_object)
				utilities.hard_remove_entity(guided_missile_object)
				local time = utils.time_ms() + 3000
				launch_guided_missile_pos_tp = launch_guided_missile_pos + v3(math.random(-30, 30), math.random(-30, 30), 20)
				while time > utils.time_ms() do
					system.yield(0)
					entity.set_entity_visible(player.get_player_ped(player.player_id()), false)
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), launch_guided_missile_pos_tp)
				end
				entity.set_entity_collision(player.get_player_ped(player.player_id()), true, true, false)
				entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), launch_guided_missile_previous_pos)
				f.on = false
			end
			launch_guided_missile_scaleform = graphics.request_scaleform_movie("SUBMARINE_MISSILES")
			graphics.begin_scaleform_movie_method(launch_guided_missile_scaleform, "GENERIC_2")
			graphics.draw_scaleform_movie_fullscreen(launch_guided_missile_scaleform, 255, 255, 255, 255, 0)
			graphics.end_scaleform_movie_method(launch_guided_missile_scaleform)

			launch_guided_missile_scaleform_2 = graphics.request_scaleform_movie("DRONE_CAM")
			graphics.begin_scaleform_movie_method(launch_guided_missile_scaleform_2, "DRONE_CAM")
			graphics.draw_scaleform_movie_fullscreen(launch_guided_missile_scaleform_2, 255, 255, 255, 255, 0)
			graphics.end_scaleform_movie_method(launch_guided_missile_scaleform_2)
		end
	end
	if not f.on then
		entity.set_entity_collision(player.get_player_ped(player.player_id()), true, true, false)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), launch_guided_missile_previous_pos)
		graphics.set_scaleform_movie_as_no_longer_needed(launch_guided_missile_scaleform)
		graphics.set_scaleform_movie_as_no_longer_needed(launch_guided_missile_scaleform_2)
		launch_guided_missile_pos_tp = nil
		launch_guided_missile_previous_pos = nil
		launch_guided_missile_pos = nil
		guided_missile_object = nil
	end
end)

feature["» Notify Orbital Cannon Room Events"] = menu.add_feature("» Notify Orbital Cannon Room Events", "toggle", localparents["» Session Malicious"].id, function(f, pid)
    if f.on then
		settings["» Notify Orbital Cannon Room Events"] = true
		for i = 0, 31 do
			IsInOrbitalCannonRoom[i] = false
			IsNotInOrbitalCannonRoom[i] = true
			IsCallingAnOrbitalStrike[i] = false
			IsNotCallingAnOrbitalStrike[i] = true
		end
		while f.on do
			system.yield(1000)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if utilities.get_distance_between(player.get_player_coords(pid), v3(329.0295715332, 4828.7514648438, -58.552848815918)) < 8 then
						if IsNotInOrbitalCannonRoom[pid] and not IsInOrbitalCannonRoom[pid] then
							menu.notify("" .. string.format("%s", player.get_player_name(pid)) .. " Entered The The Orbital Cannon Room!", Meteor, 8, 0x64FA7800)
						end
						IsInOrbitalCannonRoom[pid] = true
						IsNotInOrbitalCannonRoom[pid] = false
					else
						if IsInOrbitalCannonRoom[pid] and not IsNotInOrbitalCannonRoom[pid] then
							menu.notify("" .. string.format("%s", player.get_player_name(pid)) .. " Left The The Orbital Cannon Room!", Meteor, 8, 0x64FA7800)
						end
						IsInOrbitalCannonRoom[pid] = false
						IsNotInOrbitalCannonRoom[pid] = true
					end
					if utilities.get_distance_between(player.get_player_coords(pid), v3(329.0295715332, 4828.7514648438, -58.552848815918)) < 4 then
						if IsNotCallingAnOrbitalStrike[pid] and not IsCallingAnOrbitalStrike[pid] and not utilities.is_player_moving(pid) then
							menu.notify("" .. string.format("%s", player.get_player_name(pid)) .. " Is Calling An Orbital Strike!", Meteor, 8, 0x64FA7800)
							IsCallingAnOrbitalStrike[pid] = true
							IsNotCallingAnOrbitalStrike[pid] = false
						end
					else
						if utilities.is_player_moving(pid) and IsCallingAnOrbitalStrike[pid] and not IsNotCallingAnOrbitalStrike[pid] then
							menu.notify("" .. string.format("%s", player.get_player_name(pid)) .. " Is No Longer Calling An Orbital Strike!", Meteor, 8, 0x64FA7800)
						end
						IsCallingAnOrbitalStrike[pid] = false
						IsNotCallingAnOrbitalStrike[pid] = true
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Notify Orbital Cannon Room Events"] = false
	end
end)
feature["» Notify Orbital Cannon Room Events"].on = settings["» Notify Orbital Cannon Room Events"]

feature["» Disable Weapons"] = menu.add_feature("» Disable Weapons", "toggle", localparents["» Session Malicious"].id, function(f, pid)
    if f.on then
		settings["» Disable Weapons"] = true
		while f.on do
			system.yield(0)
			if network.is_session_started() then
				for pid = 0, 31 do
					if pid ~= player.player_id() and ai.is_task_active(player.get_player_ped(pid), 9) then
						network.request_control_of_entity(player.get_player_ped(pid))
						ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
					end
				end
			else
				menu.notify("[!] You can't use this feature in Singleplayer", Meteor, 3, 211)
				f.on = false
			end
		end
	end
	if not f.on then
		settings["» Disable Weapons"] = false
	end
end)
feature["» Disable Weapons"].on = settings["» Disable Weapons"]

feature["» For Players In Range"] = menu.add_feature("» For Players In Range", "value_str", localparents["» Session Malicious"].id, function(f, pid)
	if f.on then
		settings["» For Players In Range"] = true
		feature_value_settings["» For Players In Range"] = f.value
		threads["» For Players In Range"] = menu.create_thread(function()
			while f.on do
				graphics.draw_marker(28, player.get_player_coords(player.player_id()), v3(0, 90, 0), v3(0, 90, 0), v3(30, 30, 30), 255, 25, 25, 35, false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
				system.yield(0)
			end
		end, nil)
		while f.on do
			system.yield(0)
			for pid = 0, 31 do
				if pid ~= player.player_id() and utilities.get_distance_between(player.get_player_ped(pid), player.get_player_ped(player.player_id())) <= 30 then
					if f.value == 0 then
						fire.add_explosion(player.get_player_coords(pid), 0, true, false, 0.1, player.get_player_ped(pid))
						system.wait(100)
					elseif f.value == 1 then
						if network.network_is_host() then
							network.network_session_kick_player(pid)
						elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
							utilities.se_kick(pid)
						else
							network.force_remove_player(pid)
						end
						system.wait(500)
					elseif f.value == 2 then
						script.trigger_script_event(1445703181, pid, {pid, pid, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), pid})
						system.wait(5000)
					elseif f.value == 3 then
						if ai.is_task_active(player.get_player_ped(pid), 9) then
							ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
						end
					elseif f.value == 4 then
						gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid) + v3(0, 0, 2), player.get_player_coords(pid), 0, gameplay.get_hash_key("weapon_stungun"), player.get_player_ped(player.player_id()), true, false, 10000)
						system.wait(1000)
					end
				end
			end
		end
	end
	if not f.on then
		settings["» For Players In Range"] = false
		feature_value_settings["» For Players In Range"] = f.value
		if threads["» For Players In Range"] then
			menu.delete_thread(threads["» For Players In Range"])
		end
	end
end)
feature["» For Players In Range"]:set_str_data({"Explode", "Kick", "Crash", "Disable Weapons", "Electrocute"})
feature["» For Players In Range"].on = settings["» For Players In Range"]
feature["» For Players In Range"].value = feature_value_settings["» For Players In Range"]

menu.add_feature("» Money Yoinker 3000", "toggle", localparents["» Session Malicious"].id, function(f)
	if f.on then
    	while f.on do
    	    system.wait(0)
			local pickups = object.get_all_pickups()
			system.wait(10)
			for i = 1, #pickups do
				if entity.get_entity_model_hash(pickups[i]) == 3999186071 or entity.get_entity_model_hash(pickups[i]) == 289396019 or entity.get_entity_model_hash(pickups[i]) == 2628187989 then
					network.request_control_of_entity(pickups[i])
					entity.set_entity_coords_no_offset(pickups[i], player.get_player_coords(player.player_id()))
				end
			end
		end
	end
end)

localparents["» Net Event Responses"] = menu.add_feature("» Net Event Responses", "parent", localparents["» Session Malicious"].id)

for i = 0, 87 do
	feature["» Net Event Responses " .. i] = menu.add_feature("» " .. NetEventName[i], "value_str", localparents["» Net Event Responses"].id, function(f)
		if f.on then
			settings["» Net Event Responses " .. i] = true
			feature_value_settings["» Net Event Responses " .. i] = f.value
		end
		if not f.on then
			settings["» Net Event Responses " .. i] = false
			feature_value_settings["» Net Event Responses " .. i] = f.value
		end
	end)
	feature["» Net Event Responses " .. i].on = settings["» Net Event Responses " .. i]
	feature["» Net Event Responses " .. i]:set_str_data({"Explode", "Kick", "Crash", "Send To Brazil"})
	feature["» Net Event Responses " .. i].value = feature_value_settings["» Net Event Responses " .. i]
end

localparents["» Auto Kick Modders"] = menu.add_feature("» Auto Kick Modders", "parent", localparents["» Session Malicious"].id)

feature["» Auto Kick All Modders"] = menu.add_feature("» Auto Kick All Modders", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Auto Kick All Modders"] = true
	end
	if not f.on then
		settings["» Auto Kick All Modders"] = false
	end
end)
feature["» Auto Kick All Modders"].on = settings["» Auto Kick All Modders"]

feature["» Modder Manual"] = menu.add_feature("» Manual", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Manual"] = true
	end
	if not f.on then
		settings["» Modder Manual"] = false
	end
end)
feature["» Modder Manual"].on = settings["» Modder Manual"]

feature["» Modder Player Model"] = menu.add_feature("» Player Model", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Player Model"] = true
	end
	if not f.on then
		settings["» Modder Player Model"] = false
	end
end)
feature["» Modder Player Model"].on = settings["» Modder Player Model"]

feature["» Modder SCID Spoof"] = menu.add_feature("» SCID Spoof", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder SCID Spoof"] = true
	end
	if not f.on then
		settings["» Modder SCID Spoof"] = false
	end
end)
feature["» Modder SCID Spoof"].on = settings["» Modder SCID Spoof"]

feature["» Modder Invalid Object"] = menu.add_feature("» Invalid Object", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Invalid Object"] = true
	end
	if not f.on then
		settings["» Modder Invalid Object"] = false
	end
end)
feature["» Modder Invalid Object"].on = settings["» Modder Invalid Object"]

feature["» Modder Invalid Ped Crash"] = menu.add_feature("» Invalid Ped Crash", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Invalid Ped Crash"] = true
	end
	if not f.on then
		settings["» Modder Invalid Ped Crash"] = false
	end
end)
feature["» Modder Invalid Ped Crash"].on = settings["» Modder Invalid Ped Crash"]

feature["» Modder Model Change Crash"] = menu.add_feature("» Model Change Crash", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Model Change Crash"] = true
	end
	if not f.on then
		settings["» Modder Model Change Crash"] = false
	end
end)
feature["» Modder Model Change Crash"].on = settings["» Modder Model Change Crash"]

feature["» Modder Player Model Change"] = menu.add_feature("» Player Model Change", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Player Model Change"] = true
	end
	if not f.on then
		settings["» Modder Player Model Change"] = false
	end
end)
feature["» Modder Player Model Change"].on = settings["» Modder Player Model Change"]

feature["» Modder RAC"] = menu.add_feature("» RAC", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder RAC"] = true
	end
	if not f.on then
		settings["» Modder RAC"] = false
	end
end)
feature["» Modder RAC"].on = settings["» Modder RAC"]

feature["» Modder Money Drop"] = menu.add_feature("» Money Drop", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Money Drop"] = true
	end
	if not f.on then
		settings["» Modder Money Drop"] = false
	end
end)
feature["» Modder Money Drop"].on = settings["» Modder Money Drop"]

feature["» Modder SEP"] = menu.add_feature("» SEP", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder SEP"] = true
	end
	if not f.on then
		settings["» Modder SEP"] = false
	end
end)
feature["» Modder SEP"].on = settings["» Modder SEP"]

feature["» Modder Attach Object"] = menu.add_feature("» Attach Object", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Attach Object"] = true
	end
	if not f.on then
		settings["» Modder Attach Object"] = false
	end
end)
feature["» Modder Attach Object"].on = settings["» Modder Attach Object"]

feature["» Modder Attach Ped"] = menu.add_feature("» Attach Ped", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Attach Ped"] = true
	end
	if not f.on then
		settings["» Modder Attach Ped"] = false
	end
end)
feature["» Modder Attach Ped"].on = settings["» Modder Attach Ped"]

feature["» Modder Net Array Crash"] = menu.add_feature("» Net Array Crash", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Net Array Crash"] = true
	end
	if not f.on then
		settings["» Modder Net Array Crash"] = false
	end
end)
feature["» Modder Net Array Crash"].on = settings["» Modder Net Array Crash"]

feature["» Modder Net Sync Crash"] = menu.add_feature("» Net Sync Crash", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Net Sync Crash"] = true
	end
	if not f.on then
		settings["» Modder Net Sync Crash"] = false
	end
end)
feature["» Modder Net Sync Crash"].on = settings["» Modder Net Sync Crash"]

feature["» Modder Net Event Crash"] = menu.add_feature("» Net Event Crash", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Net Event Crash"] = true
	end
	if not f.on then
		settings["» Modder Net Event Crash"] = false
	end
end)
feature["» Modder Net Event Crash"].on = settings["» Modder Net Event Crash"]

feature["» Modder Altered Host Token"] = menu.add_feature("» Altered Host Token", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Altered Host Token"] = true
	end
	if not f.on then
		settings["» Modder Altered Host Token"] = false
	end
end)
feature["» Modder Altered Host Token"].on = settings["» Modder Altered Host Token"]

feature["» Modder SE Spam"] = menu.add_feature("» SE Spam", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder SE Spam"] = true
	end
	if not f.on then
		settings["» Modder SE Spam"] = false
	end
end)
feature["» Modder SE Spam"].on = settings["» Modder SE Spam"]

feature["» Modder Invalid Vehicle"] = menu.add_feature("» Invalid Vehicle", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Invalid Vehicle"] = true
	end
	if not f.on then
		settings["» Modder Invalid Vehicle"] = false
	end
end)
feature["» Modder Invalid Vehicle"].on = settings["» Modder Invalid Vehicle"]

feature["» Modder Frame Flags"] = menu.add_feature("» Frame Flags", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Frame Flags"] = true
	end
	if not f.on then
		settings["» Modder Frame Flags"] = false
	end
end)
feature["» Modder Frame Flags"].on = settings["» Modder Frame Flags"]

feature["» Modder IP Spoof"] = menu.add_feature("» IP Spoof", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder IP Spoof"] = true
	end
	if not f.on then
		settings["» Modder IP Spoof"] = false
	end
end)
feature["» Modder IP Spoof"].on = settings["» Modder IP Spoof"]

feature["» Modder Karen"] = menu.add_feature("» Karen", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Karen"] = true
	end
	if not f.on then
		settings["» Modder Karen"] = false
	end
end)
feature["» Modder Karen"].on = settings["» Modder Karen"]

feature["» Modder Session Mismatch"] = menu.add_feature("» Session Mismatch", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Session Mismatch"] = true
	end
	if not f.on then
		settings["» Modder Session Mismatch"] = false
	end
end)
feature["» Modder Session Mismatch"].on = settings["» Modder Session Mismatch"]

feature["» Modder Sound Spam"] = menu.add_feature("» Sound Spam", "toggle", localparents["» Auto Kick Modders"].id, function(f)
	if f.on then
		settings["» Modder Sound Spam"] = true
	end
	if not f.on then
		settings["» Modder Sound Spam"] = false
	end
end)
feature["» Modder Sound Spam"].on = settings["» Modder Sound Spam"]

localparents["» No Fly Zones"] = menu.add_feature("» No Fly Zones", "parent", localparents["» Session Malicious"].id)

localparents["» Saved Zones"] = menu.add_feature("» Saved Zones", "parent", localparents["» No Fly Zones"].id)

local zone_features = {}

local function split_zone(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

local function generate_save_line_string_zone(id, radius, name, x, y, z)
    return id .. "||" .. radius .. "||" .. name .. "||" .. x .. "," .. y .. "," .. z
end

local function rename_zone(id, radius, name, x, y, z)
    local found_index = false
    local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt", 'r')
    local file_content = {}
    local last_checked_line = 0
    for line in file:lines() do
        last_checked_line = last_checked_line + 1
        table.insert (file_content, line)

        local main_parts = split_zone(line, "||")
        local zone_id = main_parts[1]

        if zone_id == id then
            found_index = last_checked_line
        end
    end
    io.close(file)

    if found_index then
        file_content[found_index] = generate_save_line_string_zone(id, radius, name, x, y, z)

        file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt", 'w')
        for index, value in ipairs(file_content) do
            file:write(value..'\n')
        end
        io.close(file)

        zone_features[id].name = name
        zone_features[id].data.id = id
		zone_features[id].data.radius = radius
        zone_features[id].data.name = name
        zone_features[id].data.x = x
        zone_features[id].data.y = y
        zone_features[id].data.z = z

        return true
    else
        return false
    end
end

local function change_zone_radius(id, radius, name, x, y, z)
    local found_index = false
    local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt", 'r')
    local file_content = {}
    local last_checked_line = 0
    for line in file:lines() do
        last_checked_line = last_checked_line + 1
        table.insert (file_content, line)

        local main_parts = split_zone(line, "||")
        local zone_id = main_parts[1]

        if zone_id == id then
            found_index = last_checked_line
        end
    end
    io.close(file)

    if found_index then
        file_content[found_index] = generate_save_line_string_zone(id, radius, name, x, y, z)

        file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt", 'w')
        for index, value in ipairs(file_content) do
            file:write(value..'\n')
        end
        io.close(file)

        zone_features[id].name = name
        zone_features[id].data.id = id
		zone_features[id].data.radius = radius
        zone_features[id].data.name = name
        zone_features[id].data.x = x
        zone_features[id].data.y = y
        zone_features[id].data.z = z

        return true
    else
        return false
    end
end

local function delete_zone(id, radius, name, x, y, z)
    local found = false
    local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt", 'r')
    local file_content = {}
    for line in file:lines() do
        local main_parts = split_zone(line, "||")
        local zone_id = main_parts[1]

        if zone_id == id then
            found = true
        else
            table.insert (file_content, line)
        end
    end
    io.close(file)

    if found then
        file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt", 'w')
        for index, value in ipairs(file_content) do
            file:write(value..'\n')
        end
        io.close(file)
        
        return true
    else
        return false
    end
end

local function append_zone_to_list(id, radius, name, x, y, z)
    zone_features[id] = menu.add_feature("» " .. name .. "", "value_str", localparents["» Saved Zones"].id, function(option_index)
		if option_index.on then
			if option_index.value == 0 then
				menu.create_thread(function(sphere_thread)
					while option_index.on do
						graphics.draw_marker(28, v3(zone_features[id].data.x, zone_features[id].data.y, zone_features[id].data.z), v3(0, 90, 0), v3(0, 90, 0), v3(tonumber(zone_features[id].data.radius), tonumber(zone_features[id].data.radius), tonumber(zone_features[id].data.radius)), 255, 25, 25, 20, false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
						system.yield(0)
					end
				end, nil)
				while option_index.on do
					system.yield(math.random(1000, 2000))
					if settings["» Exclude Yourself From No Fly Zones"] and settings["» Exclude Friends From No Fly Zones"] then
						for pid = 0, 31 do
							if pid ~= player.player_id() and not pid == player.is_player_friend(pid) and player.get_player_coords(pid).z > 50 and player.is_player_in_any_vehicle(pid) and (streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(pid))) or streaming.is_model_a_heli(entity.get_entity_model_hash(player.get_player_vehicle(pid)))) and utilities.get_distance_between(player.get_player_ped(pid), v3(zone_features[id].data.x, zone_features[id].data.y, zone_features[id].data.z)) <= tonumber(zone_features[id].data.radius) and not entity.is_entity_dead(player.get_player_vehicle(pid)) then
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 60, true, false, 0.1, player.get_player_ped(pid))
							end
						end
					elseif settings["» Exclude Yourself From No Fly Zones"] then
						for pid = 0, 31 do
							if pid ~= player.player_id() and player.get_player_coords(pid).z > 50 and player.is_player_in_any_vehicle(pid) and (streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(pid))) or streaming.is_model_a_heli(entity.get_entity_model_hash(player.get_player_vehicle(pid)))) and utilities.get_distance_between(player.get_player_ped(pid), v3(zone_features[id].data.x, zone_features[id].data.y, zone_features[id].data.z)) <= tonumber(zone_features[id].data.radius) and not entity.is_entity_dead(player.get_player_vehicle(pid)) then
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 60, true, false, 0.1, player.get_player_ped(pid))
							end
						end
					elseif settings["» Exclude Friends From No Fly Zones"] then
						for pid = 0, 31 do
							if not pid == player.is_player_friend(pid) and player.get_player_coords(pid).z > 50 and player.is_player_in_any_vehicle(pid) and (streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(pid))) or streaming.is_model_a_heli(entity.get_entity_model_hash(player.get_player_vehicle(pid)))) and utilities.get_distance_between(player.get_player_ped(pid), v3(zone_features[id].data.x, zone_features[id].data.y, zone_features[id].data.z)) <= tonumber(zone_features[id].data.radius) and not entity.is_entity_dead(player.get_player_vehicle(pid)) then
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 60, true, false, 0.1, player.get_player_ped(pid))
							end
						end
					else
						for pid = 0, 31 do
							if player.get_player_coords(pid).z > 50 and player.is_player_in_any_vehicle(pid) and (streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(pid))) or streaming.is_model_a_heli(entity.get_entity_model_hash(player.get_player_vehicle(pid)))) and utilities.get_distance_between(player.get_player_ped(pid), v3(zone_features[id].data.x, zone_features[id].data.y, zone_features[id].data.z)) <= tonumber(zone_features[id].data.radius) and not entity.is_entity_dead(player.get_player_vehicle(pid)) then
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0.1, player.get_player_ped(pid))
								fire.add_explosion(player.get_player_coords(pid), 60, true, false, 0.1, player.get_player_ped(pid))
							end
						end
					end
				end
			elseif option_index.value == 1 then
				local input_stat, input_val = input.get("Please Provide A Radius For The Zone", "", 4, 3)

				if input_stat == 1 then
					return HANDLER_CONTINUE
				end

				if input_stat == 2 then
					option_index.on = false
					return HANDLER_POP
				end
			
				if input_stat == 2 or input_val == "" or string.find(input_val, "||") then
					menu.notify("[!] Cancelled!", Meteor, 3, 211)
					option_index.on = false
					return HANDLER_POP
				end
	
				option_index.on = false
	
				previous_radius = zone_features[id].data.radius
				local success = change_zone_radius(id, input_val, "» " .. name, x, y, z)
	
				if success then
					menu.notify("[!] Changed radius of " .. zone_features[id].name .. " from " .. previous_radius .. " to " .. input_val .. ".", Meteor)
				else
					menu.notify("[!] Cancelled!", Meteor, 3, 211)
				end
			elseif option_index.value == 2 then
				local input_stat, input_val = input.get("Please Provide A Name For The Zone", "", 12, 0)

				if input_stat == 1 then
					return HANDLER_CONTINUE
				end

				if input_stat == 2 then
					option_index.on = false
					return HANDLER_POP
				end
	
				input_val_str = "» " .. input_val .. ""
			
				if input_stat == 2 or input_val == "" or string.find(input_val, "||") then
					menu.notify("[!] Cancelled!", Meteor, 3, 211)
					option_index.on = false
					return HANDLER_POP
				end
	
				option_index.on = false
				local previous_name = zone_features[id].name
	
				local success = rename_zone(id, zone_features[id].data.radius, input_val_str, x, y, z)
	
				if success then
					menu.notify("[!] Renamed \"" .. previous_name .. "\" to \"" .. input_val_str .. "\".", Meteor)
				else
					menu.notify("[!] Cancelled!", Meteor, 3, 211)
				end
			elseif option_index.value == 3 then
				option_index.on = false
				local success = delete_zone(id)

				if success then
					menu.notify("Deleted \"" .. name .. "\" from your saved zones.", Meteor)
					menu.delete_feature(zone_features[id].id)
				else
					menu.notify("[!] An error occured.", Meteor, 3, 211)
				end
			end
		end
    end)

	zone_features[id].on = settings["» No Fly Zones"]
	zone_features[id]:set_str_data({
		"Toggle",
		"Change Radius",
		"Rename",
		"Delete"
	})

    zone_features[id].data = {}
    zone_features[id].data.id = id
	zone_features[id].data.radius = radius
    zone_features[id].data.name = name
    zone_features[id].data.x = x
    zone_features[id].data.y = y
    zone_features[id].data.z = z
end

file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt", "r")
io.input(file)
for line in io.lines(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt") do
    if string.find(line, "||") then
        local main_parts = split_zone(line, "||")
        local zone_id = main_parts[1]
        local zone_coords = split_zone(main_parts[4], ",")
        local zone_radius,zone_name,_zone_coord_x,_zone_coord_y,_zone_coord_z = main_parts[2], main_parts[3], zone_coords[1], zone_coords[2], zone_coords[3]

        append_zone_to_list(zone_id, zone_radius, zone_name, _zone_coord_x, _zone_coord_y, _zone_coord_z)
    end
end
io.close(file)

menu.add_feature("» Save Current Location", "action", localparents["» No Fly Zones"].id, function()
    local input_stat, input_val = input.get("Please Provide A Name For The Zone", "", 12, 0)

    if input_stat == 1 then
        return HANDLER_CONTINUE
    end

    if input_stat == 2 or input_val == "" or string.find(input_val, "||") then
        menu.notify("[!] Cancelled!", Meteor, 3, 211)
        return false
    end

    local zone_id = os.time().."r"..math.random(1,10000)
    local player_id = player.player_id()
    local player_ped = player.get_player_ped(player.player_id())
    local player_coords = entity.get_entity_coords(player_ped)
    
    file = io.open (utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt", "a+")
    io.output(file)
    io.write(generate_save_line_string_zone(zone_id, 200, input_val, player_coords["x"], player_coords["y"], player_coords["z"]).."\n")
    io.close(file)

    append_zone_to_list(zone_id, 200, input_val, player_coords["x"], player_coords["y"], player_coords["z"])

    menu.notify("[!] Succesfully saved location to zones.\nName: " .. input_val .. "\nPos x: " .. player.get_player_coords(player.player_id()).x .. "\nPos y: " .. player.get_player_coords(player.player_id()).y .. "\nPos z: " .. player.get_player_coords(player.player_id()).z .. "", Meteor)
end)

menu.add_feature("» Wipe No Fly Zones", "action", localparents["» No Fly Zones"].id, function(f)
	local input_stat, input_val = input.get("Are You Sure? This Process Cannot Be Undone! Type \"Yes\" To Continue..", "", 3, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
		menu.notify("[!] Cancelled!", Meteor, 3, 211)
        return HANDLER_POP
    end
	if input_val == "Yes" then
		if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt") then
			utilities.write(io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\NoFlyZones.txt", "w"), "")
			menu.notify("[!] Succesfully wiped NoFlyZones.txt", Meteor)
		else
			menu.notify("[!] File Missing!\n\\Meteor\\Data\\NoFlyZones.txt", Meteor, 3, 211)
		end
	else
		menu.notify("[!] Cancelled!", Meteor, 3, 211)
	end
end)

feature["» No Fly Zones"] = menu.add_feature("» Toggle Zones On Execute", "toggle", localparents["» No Fly Zones"].id, function(f)
	if f.on then
		settings["» No Fly Zones"] = true
	end
	if not f.on then
		settings["» No Fly Zones"] = false
	end
end)
feature["» No Fly Zones"].on = settings["» No Fly Zones"]

feature["» Exclude Yourself From No Fly Zones"] = menu.add_feature("» Exclude Yourself", "toggle", localparents["» No Fly Zones"].id, function(f)
	if f.on then
		settings["» Exclude Yourself From No Fly Zones"] = true
	end
	if not f.on then
		settings["» Exclude Yourself From No Fly Zones"] = false
	end
end)
feature["» Exclude Yourself From No Fly Zones"].on = settings["» Exclude Yourself From No Fly Zones"]

feature["» Exclude Friends From No Fly Zones"] = menu.add_feature("» Exclude Friends", "toggle", localparents["» No Fly Zones"].id, function(f)
	if f.on then
		settings["» Exclude Friends From No Fly Zones"] = true
	end
	if not f.on then
		settings["» Exclude Friends From No Fly Zones"] = false
	end
end)
feature["» Exclude Friends From No Fly Zones"].on = settings["» Exclude Friends From No Fly Zones"]

--

menu.add_feature("» Burst Vehicle Tires", "action", localparents["» Session Trolling"].id, function(f)
    local vehicles = vehicle.get_all_vehicles()
    for i = 1, #vehicles do
		local wheels = vehicle.get_vehicle_wheel_count(vehicles[i])
		if wheels ~= nil then
			for count = 0, wheels + 1 do
				network.request_control_of_entity(vehicles[i])
				vehicle.set_vehicle_tire_burst(vehicles[i], count, true, 1000)
			end
		end
	end
end)

feature["» Bouncy Vehicles"] = menu.add_feature("» Bouncy Vehicles", "toggle", localparents["» Session Trolling"].id, function(f)
	if f.on then
		settings["» Bouncy Vehicles"] = true
  		while f.on do
    	    local vehicles = vehicle.get_all_vehicles()
    	    for i = 1, #vehicles do
   	         	network.request_control_of_entity(vehicles[i])
   	         	local vehicle_velocity = entity.get_entity_velocity(vehicles[i])
   	        	entity.set_entity_velocity(vehicles[i], v3(vehicle_velocity.x, vehicle_velocity.y, vehicle_velocity.z + 2.5))
   		    end
			system.wait(500)
   		end
	end
	if not f.on then
		settings["» Bouncy Vehicles"] = false
	end
end)
feature["» Bouncy Vehicles"].on = settings["» Bouncy Vehicles"]

feature["» Zero Gravity Vehicles"] = menu.add_feature("» Zero Gravity Vehicles", "toggle", localparents["» Session Trolling"].id, function(f)
    if f.on then
		settings["» Zero Gravity Vehicles"] = true
		while f.on do
        	local vehicles = vehicle.get_all_vehicles()
       		for i = 1, #vehicles do
        	    network.request_control_of_entity(vehicles[i])
				local vehicle_velocity = entity.get_entity_velocity(vehicles[i])
				entity.set_entity_velocity(vehicles[i], v3(vehicle_velocity.x, vehicle_velocity.y, vehicle_velocity.z + 0.1))
				entity.set_entity_gravity(vehicles[i], false)
       		end
			system.wait(1000)
		end
    end
	if not f.on then
		local vehicles = vehicle.get_all_vehicles()
		for i = 1, #vehicles do
			network.request_control_of_entity(vehicles[i])
			entity.set_entity_gravity(vehicles[i], true)
		end
		settings["» Zero Gravity Vehicles"] = false
	end
end)
feature["» Zero Gravity Vehicles"].on = settings["» Zero Gravity Vehicles"]

feature["» Reduce Vehicle Grip"] = menu.add_feature("» Reduce Vehicle Grip", "toggle", localparents["» Session Trolling"].id, function(f)
	if f.on then
		settings["» Reduce Vehicle Grip"] = true
    	while f.on do
    	    local vehicles = vehicle.get_all_vehicles()
    	    for i = 1, #vehicles do
    	        network.request_control_of_entity(vehicles[i])
				vehicle.set_vehicle_reduce_grip(vehicles[i], true)
    	    end
			system.wait(1000)
		end
    end
	if not f.on then
		local vehicles = vehicle.get_all_vehicles()
		for i = 1, #vehicles do
			network.request_control_of_entity(vehicles[i])
			vehicle.set_vehicle_reduce_grip(vehicles[i], false)
		end
		settings["» Reduce Vehicle Grip"] = false
	end
end)
feature["» Reduce Vehicle Grip"].on = settings["» Reduce Vehicle Grip"]

feature["» Out Of Control"] = menu.add_feature("» Out Of Control", "action_value_str", localparents["» Session Trolling"].id, function(f)
	feature_value_settings["» Out Of Control"] = f.value
	local vehicles = vehicle.get_all_vehicles()
	for i = 1, #vehicles do
		network.request_control_of_entity(vehicles[i])
		while not network.has_control_of_entity(vehicles[i]) do
			network.request_control_of_entity(vehicles[i])
			system.wait(0)
		end
		if f.value == 0 then
			vehicle.set_vehicle_out_of_control(vehicles[i], true, false)
		elseif f.value == 1 then
			vehicle.set_vehicle_out_of_control(vehicles[i], true, true)
		end
	end
end)
feature["» Out Of Control"]:set_str_data({"Normal", "Explode On Impact"})
feature["» Out Of Control"].value = feature_value_settings["» Out Of Control"]

menu.add_feature("» Waves Intensity", "action_value_str", localparents["» Session Trolling"].id, function(f)
	if f.value == 0 then
		local input_stat, input_val = input.get("Set Waves Intensity (0 - 1000", "", 4, 3)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		if tonumber(input_val) < 0 or tonumber(input_val) > 1000 then
        	menu.notify("[!] Invalid Input!", Meteor, 3, 211)
        else
			water.set_waves_intensity(input_val)
		end
	elseif f.value == 1 then
		water.reset_waves_intensity()
	end
end):set_str_data({
	"Set",
	"Reset"
})

menu.add_feature("» WW2 Mode", "toggle", localparents["» Session Trolling"].id, function(f)
	if f.on then
		ww2_rogue = {}
		ww2_ped_pilot_rogue = {}
		ww2_nokota = {}
		ww2_ped_pilot_nokota = {}
		ww2_rhino = {}
		ww2_ped_pilot_rhino = {}
		ww2_soldier = {}
		ww2_insurgent = {}
		ww2_ped_pilot_insurgent = {}
		ww2_ped_pilot_2_insurgent = {}
		streaming.request_model(0x72C0CAD2)
		streaming.request_model(0xFE0A508C)
		streaming.request_model(0x3DC92356)
		streaming.request_model(0xC5DD6967)
		streaming.request_model(0x616C97B9)
		streaming.request_model(0x2EA68690)
		streaming.request_model(0x9114EADA)
	
		while (not streaming.has_model_loaded(0xC5DD6967)) do
			system.wait(0)
		end
		while (not streaming.has_model_loaded(0xFE0A508C)) do
			system.wait(0)
		end
		while (not streaming.has_model_loaded(0x3DC92356)) do
			system.wait(0)
		end
		while (not streaming.has_model_loaded(0x72C0CAD2)) do
			system.wait(0)
		end
		while (not streaming.has_model_loaded(0x2EA68690)) do
			system.wait(0)
		end
		while (not streaming.has_model_loaded(0x616C97B9)) do
			system.wait(0)
		end
		while (not streaming.has_model_loaded(0x9114EADA)) do
			system.wait(0)
		end
	
		for a = 1, 20 do
			ww2_rogue[a] = vehicle.create_vehicle(0xC5DD6967, player.get_player_coords(player.player_id()) + v3(math.random(-300, 300), math.random(-300, 300), math.random(200, 400)), math.random(0, 360), true, false)
			ww2_ped_pilot_rogue[a] = ped.create_ped(1, 0x72C0CAD2, player.get_player_coords(player.player_id()), math.random(0, 360), true, false)
			network.request_control_of_entity(ww2_rogue[a])
			network.request_control_of_entity(ww2_ped_pilot_rogue[a])
			ped.set_ped_into_vehicle(ww2_ped_pilot_rogue[a], ww2_rogue[a], -1)
			vehicle.set_vehicle_engine_on(ww2_rogue[a], true, true, false)
			vehicle.set_vehicle_forward_speed(ww2_rogue[a], 50.0)
			vehicle.control_landing_gear(ww2_rogue[a], 3)
			ai.task_vehicle_drive_to_coord(ww2_ped_pilot_rogue[a], ww2_rogue[a], player.get_player_coords(player.player_id()), 100, -1, 0xC5DD6967, 0, 0, 1)
			ped.set_ped_combat_attributes(ww2_ped_pilot_rogue[a], 1, true)
			ped.set_ped_combat_attributes(ww2_ped_pilot_rogue[a], 3, false)
			weapon.give_delayed_weapon_to_ped(ww2_ped_pilot_rogue[a], 0x9D1F17E6, 0, true)
			ped.set_ped_as_group_member(ww2_ped_pilot_rogue[a], 1)
			ped.set_ped_combat_ability(ww2_ped_pilot_rogue[a], 2)
			ped.set_ped_combat_attributes(ww2_ped_pilot_rogue[a], 5, true)
			ai.task_combat_ped(ww2_ped_pilot_rogue[a], player.get_player_ped(player.player_id()), 0, 16)
			ped.set_ped_relationship_group_hash(ww2_ped_pilot_rogue[a], gameplay.get_hash_key("HATES_PLAYER"))
			system.wait(0)
		end
		for b = 1, 10 do
			ww2_nokota[b] = vehicle.create_vehicle(0x3DC92356, player.get_player_coords(player.player_id()) + v3(math.random(-300, 300), math.random(-300, 300), math.random(200, 400)), math.random(0, 360), true, false)
			ww2_ped_pilot_nokota[b] = ped.create_ped(1, 0x72C0CAD2, player.get_player_coords(player.player_id()), math.random(0, 360), true, false)
			network.request_control_of_entity(ww2_nokota[b])
			network.request_control_of_entity(ww2_ped_pilot_nokota[b])
			ped.set_ped_into_vehicle(ww2_ped_pilot_nokota[b], ww2_nokota[b], -1)
			vehicle.set_vehicle_engine_on(ww2_nokota[b], true, true, false)
			vehicle.set_vehicle_forward_speed(ww2_nokota[b], 50.0)
			vehicle.control_landing_gear(ww2_nokota[b], 3)
			ai.task_vehicle_drive_to_coord(ww2_ped_pilot_nokota[b], ww2_nokota[b], player.get_player_coords(player.player_id()), 100, -1, 0x3DC92356, 0, 0, 1)
			ped.set_ped_combat_attributes(ww2_ped_pilot_nokota[b], 1, true)
			ped.set_ped_combat_attributes(ww2_ped_pilot_nokota[b], 3, false)
			weapon.give_delayed_weapon_to_ped(ww2_ped_pilot_nokota[b], 0x9D1F17E6, 0, true)
			ped.set_ped_as_group_member(ww2_ped_pilot_nokota[b], 1)
			ped.set_ped_combat_ability(ww2_ped_pilot_nokota[b], 2)
			ped.set_ped_combat_attributes(ww2_ped_pilot_nokota[b], 5, true)
			ai.task_combat_ped(ww2_ped_pilot_nokota[b], player.get_player_ped(player.player_id()), 0, 16)
			ped.set_ped_relationship_group_hash(ww2_ped_pilot_nokota[b], gameplay.get_hash_key("HATES_PLAYER"))
			system.wait(0)
		end
		for c = 1, 20 do
			local pos = player.get_player_coords(player.player_id()) + v3(math.random(-300, 300), math.random(-300, 300), 0)
			local success, float = gameplay.get_ground_z(pos)
			ww2_rhino[c] = vehicle.create_vehicle(0x2EA68690, v3(pos.x, pos.y, float), math.random(0, 360), true, false)
			ww2_ped_pilot_rhino[c] = ped.create_ped(1, 0x616C97B9, player.get_player_coords(player.player_id()), math.random(0, 360), true, false)
			network.request_control_of_entity(ww2_rhino[c])
			network.request_control_of_entity(ww2_ped_pilot_rhino[c])
			ped.set_ped_into_vehicle(ww2_ped_pilot_rhino[c], ww2_rhino[c], -1)
			vehicle.set_vehicle_engine_on(ww2_rhino[c], true, true, false)
			vehicle.set_vehicle_forward_speed(ww2_rhino[c], 5.0)
			weapon.give_delayed_weapon_to_ped(ww2_ped_pilot_rhino[c], 0x9D1F17E6, 0, true)
			ped.set_ped_as_group_member(ww2_ped_pilot_rhino[c], 1)
			ped.set_ped_combat_ability(ww2_ped_pilot_rhino[c], 2)
			ped.set_ped_combat_attributes(ww2_ped_pilot_rhino[c], 5, true)
			ped.set_ped_combat_attributes(ww2_rhino[c], 1, true)
			ped.set_ped_combat_attributes(ww2_ped_pilot_rhino[c], 3, false)
			ped.set_can_attack_friendly(ww2_ped_pilot_rhino[c], true, true)
			ped.set_ped_combat_range(ww2_ped_pilot_rhino[c], 2)
			ped.set_ped_relationship_group_hash(ww2_ped_pilot_rhino[c], gameplay.get_hash_key("WILD_ANIMAL"))
			system.wait(0)
		end
		for d = 1, 30 do
			local pos = player.get_player_coords(player.player_id()) + v3(math.random(-250, 250), math.random(-250, 250), 0)
			local success, float = gameplay.get_ground_z(pos)
			ww2_soldier[d] = ped.create_ped(1, 0x616C97B9, v3(pos.x, pos.y, float), math.random(0, 360), true, false)
			network.request_control_of_entity(ww2_soldier[d])
			ped.set_ped_can_switch_weapons(ww2_soldier[d], false)
			weapon.give_delayed_weapon_to_ped(ww2_soldier[d], 0x9D1F17E6, 0, true)
			ped.set_ped_combat_ability(ww2_soldier[d], 2)
			ped.set_ped_combat_attributes(ww2_soldier[d], 5, true)
			ped.set_ped_relationship_group_hash(ww2_soldier[d], gameplay.get_hash_key("WILD_ANIMAL"))
			system.wait(0)
		end
		for e = 1, 20 do
			local pos = player.get_player_coords(player.player_id()) + v3(math.random(-300, 300), math.random(-300, 300), 0)
			local success, float = gameplay.get_ground_z(pos)
			ww2_insurgent[e] = vehicle.create_vehicle(0x9114EADA, v3(pos.x, pos.y, float), math.random(0, 360), true, false)
			ww2_ped_pilot_insurgent[e] = ped.create_ped(1, 0x616C97B9, player.get_player_coords(player.player_id()), math.random(0, 360), true, false)
			ww2_ped_pilot_2_insurgent[e] = ped.create_ped(1, 0x616C97B9, player.get_player_coords(player.player_id()), math.random(0, 360), true, false)
			network.request_control_of_entity(ww2_insurgent[e])
			network.request_control_of_entity(ww2_ped_pilot_insurgent[e])
			network.request_control_of_entity(ww2_ped_pilot_2_insurgent[e])
			ped.set_ped_into_vehicle(ww2_ped_pilot_insurgent[e], ww2_insurgent[e], -1)
			ped.set_ped_into_vehicle(ww2_ped_pilot_2_insurgent[e], ww2_insurgent[e], 7)
			vehicle.set_vehicle_engine_on(ww2_insurgent[e], true, true, false)
			vehicle.set_vehicle_forward_speed(ww2_insurgent[e], 5.0)

			ped.set_ped_combat_attributes(ww2_insurgent[e], 1, true)
			weapon.give_delayed_weapon_to_ped(ww2_ped_pilot_insurgent[e], 0x9D1F17E6, 0, true)
			ped.set_ped_combat_ability(ww2_ped_pilot_insurgent[e], 2)
			ped.set_ped_combat_attributes(ww2_ped_pilot_insurgent[e], 5, true)
			ped.set_ped_combat_attributes(ww2_ped_pilot_insurgent[e], 3, false)
			ped.set_ped_combat_range(ww2_ped_pilot_insurgent[e], 2)
			ped.set_ped_as_group_member(ww2_ped_pilot_insurgent[e], 1)
			ped.set_ped_relationship_group_hash(ww2_ped_pilot_insurgent[e], gameplay.get_hash_key("WILD_ANIMAL"))
			weapon.give_delayed_weapon_to_ped(ww2_ped_pilot_2_insurgent[e], 0x9D1F17E6, 0, true)
			ped.set_ped_combat_ability(ww2_ped_pilot_2_insurgent[e], 2)
			ped.set_ped_combat_attributes(ww2_ped_pilot_2_insurgent[e], 5, true)
			ped.set_ped_combat_attributes(ww2_ped_pilot_2_insurgent[e], 3, false)
			ped.set_ped_combat_range(ww2_ped_pilot_2_insurgent[e], 2)
			ped.set_ped_as_group_member(ww2_ped_pilot_2_insurgent[e], 1)
			ped.set_ped_relationship_group_hash(ww2_ped_pilot_2_insurgent[e], gameplay.get_hash_key("WILD_ANIMAL"))
			system.wait(0)
		end
		while f.on do
			system.yield(0)
			audio.play_sound_from_entity(-1, "Air_Defences_Activated", player.get_player_ped(player.player_id()), "DLC_sum20_Business_Battle_AC_Sounds")
			system.yield(10000)
		end
	end
	if not f.on then
		for a = 1, 20 do
			if entity.is_an_entity(ww2_rogue[a]) then
				network.request_control_of_entity(ww2_rogue[a])
				utilities.hard_remove_entity(ww2_rogue[a])
			end
			if entity.is_an_entity(ww2_ped_pilot_rogue[a]) then
				network.request_control_of_entity(ww2_ped_pilot_rogue[a])
				utilities.hard_remove_entity(ww2_ped_pilot_rogue[a])
			end
		end
		for b = 1, 10 do
			if entity.is_an_entity(ww2_nokota[b]) then
				network.request_control_of_entity(ww2_nokota[b])
				utilities.hard_remove_entity(ww2_nokota[b])
			end
			if entity.is_an_entity(ww2_ped_pilot_nokota[b]) then
				network.request_control_of_entity(ww2_ped_pilot_nokota[b])
				utilities.hard_remove_entity(ww2_ped_pilot_nokota[b])
			end
		end
		for c = 1, 20 do
			if entity.is_an_entity(ww2_rhino[c]) then
				network.request_control_of_entity(ww2_rhino[c])
				utilities.hard_remove_entity(ww2_rhino[c])
			end
			if entity.is_an_entity(ww2_ped_pilot_rhino[c]) then
				network.request_control_of_entity(ww2_ped_pilot_rhino[c])
				utilities.hard_remove_entity(ww2_ped_pilot_rhino[c])
			end
		end
		for d = 1, 30 do
			if entity.is_an_entity(ww2_soldier[d]) then
				network.request_control_of_entity(ww2_soldier[d])
				utilities.hard_remove_entity(ww2_soldier[d])
			end
		end
		for e = 1, 20 do
			if entity.is_an_entity(ww2_insurgent[e]) then
				network.request_control_of_entity(ww2_ped_pilot_insurgent[e])
				utilities.hard_remove_entity(ww2_insurgent[e])
			end
			if entity.is_an_entity(ww2_ped_pilot_insurgent[e]) then
				network.request_control_of_entity(ww2_ped_pilot_insurgent[e])
				utilities.hard_remove_entity(ww2_ped_pilot_insurgent[e])
			end
			if entity.is_an_entity(ww2_ped_pilot_2_insurgent[e]) then
				network.request_control_of_entity(ww2_ped_pilot_2_insurgent[e])
				utilities.hard_remove_entity(ww2_ped_pilot_2_insurgent[e])
			end
		end
		ww2_rogue = nil
		ww2_ped_pilot_rogue = nil
		ww2_nokota = nil
		ww2_ped_pilot_nokota = nil
		ww2_rhino = nil
		ww2_ped_pilot_rhino = nil
		ww2_soldier = nil
		ww2_insurgent = nil
		ww2_ped_pilot_insurgent = nil
		ww2_ped_pilot_2_insurgent = nil
		streaming.set_model_as_no_longer_needed(0x72C0CAD2)
		streaming.set_model_as_no_longer_needed(0xFE0A508C)
		streaming.set_model_as_no_longer_needed(0x3DC92356)
		streaming.set_model_as_no_longer_needed(0xC5DD6967)
		streaming.set_model_as_no_longer_needed(0x616C97B9)
		streaming.set_model_as_no_longer_needed(0x2EA68690)
		streaming.set_model_as_no_longer_needed(0x9114EADA)
	end
end)

feature["» City Riot"] = menu.add_feature("» City Riot", "toggle", localparents["» Session Trolling"].id, function(f)
	if f.on then
		settings["» City Riot"] = true
		while f.on do
			system.yield(0)
			local peds = ped.get_all_peds()
    		for i = 1, #peds do
				if not ped.is_ped_a_player(peds[i]) and not entity.is_entity_dead(peds[i]) then
					network.request_control_of_entity(peds[i])
					ped.set_ped_combat_ability(peds[i], 2)
					ped.set_ped_combat_attributes(peds[i], 5, true)
					ped.set_can_attack_friendly(peds[i], true, true)
					for other_peds = 1, #peds do
						if other_peds ~= i and not ped.is_ped_a_player(peds[other_peds]) and not entity.is_entity_dead(peds[other_peds]) then
							network.request_control_of_entity(peds[other_peds])
							ai.task_combat_ped(peds[i], peds[other_peds], 0, 16)
						end
						system.wait(0)
					end
				end
				system.wait(0)
			end
			system.wait(2000)
    	end
	end
	if not f.on then
		settings["» City Riot"] = false
	end
end)
feature["» City Riot"].on = settings["» City Riot"]

feature["» Launch Random Vehicles"] = menu.add_feature("» Launch Random Vehicles", "toggle", localparents["» Session Trolling"].id, function(f)
	if f.on then
		settings["» Launch Random Vehicles"] = true
    	while f.on do
   	     	local vehicles = vehicle.get_all_vehicles()
   		    for i = 1, #vehicles do
            	network.request_control_of_entity(vehicles[i])
            	vehicle.set_vehicle_forward_speed(vehicles[i], 100.0)
            	system.wait(100)
        	end
   		end
	end
	if not f.on then
		settings["» Launch Random Vehicles"] = false
	end
end)
feature["» Launch Random Vehicles"].on = settings["» Launch Random Vehicles"]

localparents["» Sounds"] = menu.add_feature("» Sounds", "parent", localparents["» Session Trolling"].id)

menu.add_feature("» Hack Success", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Hack_Success", player.get_player_coords(player.player_id()), "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true, 9999, false)
end)

menu.add_feature("» Hack Fail", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Hack_Failed", player.get_player_coords(player.player_id()), "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true, 9999, false)
end)

menu.add_feature("» Rip Car", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "FAMILY_1_CAR_BREAKDOWN", player.get_player_coords(player.player_id()), "FAMILY1_BOAT", true, 9999, false)
end)

menu.add_feature("» Hammer Slam", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Drill_Pin_Break", player.get_player_coords(player.player_id()), "DLC_HEIST_FLEECA_SOUNDSET", true, 9999, false)
end)

menu.add_feature("» Baritone Saxophone", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Horn", player.get_player_coords(player.player_id()), "DLC_Apt_Yacht_Ambient_Soundset", true, 9999, false)
end)

menu.add_feature("» Rank Up", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "MP_RANK_UP", player.get_player_coords(player.player_id()), "HUD_FRONTEND_DEFAULT_SOUNDSET", true, 9999, false)
end)

menu.add_feature("» Cash Pickup", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", player.get_player_coords(player.player_id()), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 9999, false)
end)

menu.add_feature("» Camera Shutter", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "SHUTTER_FLASH", player.get_player_coords(player.player_id()), "CAMERA_FLASH_SOUNDSET", true, 9999, false)
end)

menu.add_feature("» Menu Accept", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Menu_Accept", player.get_player_coords(player.player_id()), "Phone_SoundSet_Default", true, 9999, false)
end)

menu.add_feature("» Alert Sound", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Out_Of_Bounds_Timer", player.get_player_coords(player.player_id()), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 9999, false)
end)

menu.add_feature("» Race Checkpoint", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "CHECKPOINT_AHEAD", player.get_player_coords(player.player_id()), "HUD_MINI_GAME_SOUNDSET", true, 9999, false)
end)

menu.add_feature("» Walkie-Talkie", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Start_Squelch", player.get_player_coords(player.player_id()), "CB_RADIO_SFX", true, 9999, false)
end)

menu.add_feature("» Pickup", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Bus_Schedule_Pickup", player.get_player_coords(player.player_id()), "DLC_PRISON_BREAK_HEIST_SOUNDS", true, 9999, false)
end)

menu.add_feature("» Fast Beeping", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Beep_Red", player.get_player_coords(player.player_id()), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 9999, false)
end)

menu.add_feature("» Notification", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "CHALLENGE_UNLOCKED", player.get_player_coords(player.player_id()), "HUD_AWARDS", true, 9999, false)
end)

menu.add_feature("» Focus In", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "FocusIn", player.get_player_coords(player.player_id()), "HintCamSounds", true, 9999, false)
end)

menu.add_feature("» Stunt Jump", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "LOSER", player.get_player_coords(player.player_id()), "HUD_AWARDS", true, 9999, false)
end)

menu.add_feature("» Air Defenses Off", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Air_Defenses_Disabled", player.get_player_coords(player.player_id()), "DLC_sum20_Business_Battle_AC_Sounds", true, 9999, false)
end)

menu.add_feature("» Air Defenses On", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "Air_Defences_Activated", player.get_player_coords(player.player_id()), "DLC_sum20_Business_Battle_AC_Sounds", true, 9999, false)
end)

menu.add_feature("» Phone Select", "action", localparents["» Sounds"].id, function(f)
	audio.play_sound_from_coord(-1, "YES", player.get_player_coords(player.player_id()), "HUD_FRONTEND_DEFAULT_SOUNDSET", true, 9999, false)
end)

menu.add_feature("» Metal Detector Sounds", "action_value_str", localparents["» Sounds"].id, function(f)
    if f.value == 0 then
		audio.play_sound_from_coord(-1, "Metal_Detector_Small_Guns", player.get_player_coords(player.player_id()), "dlc_ch_heist_finale_security_alarms_sounds", true, 9999, false)
    elseif f.value == 1 then
		audio.play_sound_from_coord(-1, "Metal_Detector_Big_Guns", player.get_player_coords(player.player_id()), "dlc_ch_heist_finale_security_alarms_sounds", true, 9999, false)
    end
end):set_str_data({
	"Small Weps",
	"Big Weps"
})

menu.add_feature("» Fast Beep Loop", "toggle", localparents["» Sounds"].id, function(f)
	while f.on do
		audio.play_sound_from_coord(-1, "Beep_Red", player.get_player_coords(player.player_id()), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 9999, false)
		system.wait(0)
	end
end)

menu.add_feature("» Click Loop", "toggle", localparents["» Sounds"].id, function(f)
	while f.on do
		audio.play_sound_from_coord(-1, "Click_Special", player.get_player_coords(player.player_id()), "WEB_NAVIGATION_SOUNDS_PHONE", true, 9999, false)
		system.wait(150)
	end
end)

menu.add_feature("» Bari Sax Loop", "toggle", localparents["» Sounds"].id, function(f)
	while f.on do
		audio.play_sound_from_coord(-1, "Horn", player.get_player_coords(player.player_id()), "DLC_Apt_Yacht_Ambient_Soundset", true, 9999, false)
		system.wait(0)
	end
end)

--

feature["» Rockstar Chat Global"] = menu.add_feature("» Rockstar Chat Global", "action_value_str", localparents["» Gameplay Utilities"].id, function(f)
	feature_value_settings["» Rockstar Chat Global"] = f.value
    local input_stat, input_val = input.get("", "", 999, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if f.value == 0 then
    	network.send_chat_message(string.format("∑ | ".." %s", input_val), false)
	end
	if f.value == 1 then
    	network.send_chat_message(string.format("¦ | ".." %s", input_val), false)
	end
	if f.value == 2 then
    	network.send_chat_message(string.format("Ω | ".." %s", input_val), false)
	end
end)
feature["» Rockstar Chat Global"]:set_str_data({"Rockstar Icon", "Rockstar Verified Icon", "Lock Icon"})
feature["» Rockstar Chat Global"].value = feature_value_settings["» Rockstar Chat Global"]

feature["» Rockstar Chat Team"] = menu.add_feature("» Rockstar Chat Team", "action_value_str", localparents["» Gameplay Utilities"].id, function(f)
	feature_value_settings["» Rockstar Chat Team"] = f.value
    local input_stat, input_val = input.get("", "", 999, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if f.value == 0 then
    	network.send_chat_message(string.format("∑ | ".." %s", input_val), true)
	end
	if f.value == 1 then
    	network.send_chat_message(string.format("¦ | ".." %s", input_val), true)
	end
	if f.value == 2 then
    	network.send_chat_message(string.format("Ω | ".." %s", input_val), true)
	end
end)
feature["» Rockstar Chat Team"]:set_str_data({"Rockstar Icon", "Rockstar Verified Icon", "Lock Icon"})
feature["» Rockstar Chat Team"].value = feature_value_settings["» Rockstar Chat Team"]

menu.add_feature("» Reload Textures", "action", localparents["» Gameplay Utilities"].id, function(f)
	menu.create_thread(function()
		local pos = player.get_player_coords(player.player_id())
		texture_reload_wait = 1
		menu.create_thread(function()
			while texture_reload_wait == 1 do
				system.yield(0)
				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos + v3(0, 0, 100000))
				vehicle.set_vehicle_density_multipliers_this_frame(0)
				ped.set_ped_density_multiplier_this_frame(0)
			end
		end, nil)
		system.wait(5950)
		texture_reload_wait = nil
		system.wait(50)
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
	end, nil)
end)

menu.add_feature("» Resurrect Nearby Peds", "action", localparents["» Gameplay Utilities"].id, function(f)
    local peds = utilities.get_table_of_entities(ped.get_all_peds(), 100, 10, true, true, player.get_player_coords(player.player_id()))
    for i = 1, #peds do
		menu.create_thread(function()
			if entity.is_entity_dead(peds[i], true) then
				graphics.set_next_ptfx_asset("scr_rcbarry1")
				while not graphics.has_named_ptfx_asset_loaded("scr_rcbarry1") do
					graphics.request_named_ptfx_asset("scr_rcbarry1")
					system.wait(0)
				end
				local pos = entity.get_entity_coords(peds[i])
				graphics.start_networked_particle_fx_non_looped_at_coord("scr_alien_teleport", pos + v3(0, 0, -2), v3(0, 0, 0), 4, true, true, true)
				system.wait(1000)
    			network.request_control_of_entity(peds[i])
        	 	if (not network.has_control_of_entity(peds[i])) then
     			   	network.request_control_of_entity(peds[i])
				end
				ped.resurrect_ped(peds[i])
				ped.clear_ped_tasks_immediately(peds[i])
				entity.set_entity_collision(peds[i], true, true, true)
				for i = 500, #peds do
					ped.clear_ped_tasks_immediately(peds[i])
				end
				system.wait(100)
				local health = ped.get_ped_max_health(peds[i])
				ped.set_ped_max_health(peds[i], health)
				system.wait(100)
				ped.set_ped_health(peds[i], health)
				ped.clear_ped_blood_damage(peds[i])
				graphics.remove_named_ptfx_asset("scr_rcbarry1")
			end
		end, nil)
    end
end)

feature["» Spawn Custom Entity (Hex)"] = menu.add_feature("» Spawn Custom Entity (Hex)", "action_value_str", localparents["» Gameplay Utilities"].id, function(f)
	feature_value_settings["» Spawn Custom Entity (Hex)"] = f.value
    local input_stat, input_val = input.get("Enter Hash Model", "", 12, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if streaming.is_model_valid(input_val) then
		if f.value == 0 then
			streaming.request_model(input_val)
			while (not streaming.has_model_loaded(input_val)) do
				system.wait(0)
			end
    		ped.create_ped(0, input_val, player.get_player_coords(player.player_id()), 0, true, false)
		end
		if f.value == 1 then
			streaming.request_model(input_val)
			while (not streaming.has_model_loaded(input_val)) do
				system.wait(0)
			end
    		vehicle.create_vehicle(input_val, player.get_player_coords(player.player_id()), 0, true, false)
		end
		if f.value == 2 then
			streaming.request_model(input_val)
			while (not streaming.has_model_loaded(input_val)) do
				system.wait(0)
			end
   		 	object.create_object(input_val, player.get_player_coords(player.player_id()), true, true)
		end
		if f.value == 3 then
			streaming.request_model(input_val)
			while (not streaming.has_model_loaded(input_val)) do
				system.wait(0)
			end
   		 	object.create_world_object(input_val, player.get_player_coords(player.player_id()), true, true)
		end
	end
end)
feature["» Spawn Custom Entity (Hex)"]:set_str_data({"Ped", "Vehicle", "Object", "World Object"})
feature["» Spawn Custom Entity (Hex)"].value = feature_value_settings["» Spawn Custom Entity (Hex)"]

feature["» Spawn Custom Entity (Dec)"] = menu.add_feature("» Spawn Custom Entity (Dec)", "action_value_str", localparents["» Gameplay Utilities"].id, function(f)
	feature_value_settings["» Spawn Custom Entity (Dec)"] = f.value
    local input_stat, input_val = input.get("Enter Hash", "", 10, 3)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if streaming.is_model_valid(input_val) then
		if f.value == 0 then
			streaming.request_model(input_val)
			while (not streaming.has_model_loaded(input_val)) do
				system.wait(0)
			end
    		ped.create_ped(0, input_val, player.get_player_coords(player.player_id()), 0, true, false)
		end
		if f.value == 1 then
			streaming.request_model(input_val)
			while (not streaming.has_model_loaded(input_val)) do
				system.wait(0)
			end
    		vehicle.create_vehicle(input_val, player.get_player_coords(player.player_id()), 0, true, false)
		end
		if f.value == 2 then
			streaming.request_model(input_val)
			while (not streaming.has_model_loaded(input_val)) do
				system.wait(0)
			end
   		 	object.create_object(input_val, player.get_player_coords(player.player_id()), true, true)
		end
		if f.value == 3 then
			streaming.request_model(input_val)
			while (not streaming.has_model_loaded(input_val)) do
				system.wait(0)
			end
   		 	object.create_world_object(input_val, player.get_player_coords(player.player_id()), true, true)
		end
	end
end)
feature["» Spawn Custom Entity (Dec)"]:set_str_data({"Ped", "Vehicle", "Object", "World Object"})
feature["» Spawn Custom Entity (Dec)"].value = feature_value_settings["» Spawn Custom Entity (Dec)"]

feature["» Spawn Custom Entity (Model)"] = menu.add_feature("» Spawn Custom Entity (Model)", "action_value_str", localparents["» Gameplay Utilities"].id, function(f)
	feature_value_settings["» Spawn Custom Entity (Model)"] = f.value
    local input_stat, input_val = input.get("Enter String Model", "", 99, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	local hash_model = gameplay.get_hash_key(tostring(input_val))
	if streaming.is_model_valid(hash_model) then
		if f.value == 0 then
			streaming.request_model(hash_model)
			while (not streaming.has_model_loaded(hash_model)) do
				system.wait(0)
			end
    		ped.create_ped(0, hash_model, player.get_player_coords(player.player_id()), 0, true, false)
		end
		if f.value == 1 then
			streaming.request_model(hash_model)
			while (not streaming.has_model_loaded(hash_model)) do
				system.wait(0)
			end
    		vehicle.create_vehicle(hash_model, player.get_player_coords(player.player_id()), 0, true, false)
		end
		if f.value == 2 then
			streaming.request_model(hash_model)
			while (not streaming.has_model_loaded(hash_model)) do
				system.wait(0)
			end
   		 	object.create_object(hash_model, player.get_player_coords(player.player_id()), true, true)
		end
		if f.value == 3 then
			streaming.request_model(hash_model)
			while (not streaming.has_model_loaded(hash_model)) do
				system.wait(0)
			end
   		 	object.create_world_object(hash_model, player.get_player_coords(player.player_id()), true, true)
		end
	end
end)
feature["» Spawn Custom Entity (Model)"]:set_str_data({"Ped", "Vehicle", "Object", "World Object"})
feature["» Spawn Custom Entity (Model)"].value = feature_value_settings["» Spawn Custom Entity (Model)"]

menu.add_feature("» Hard Remove Nearby Entities", "action", localparents["» Gameplay Utilities"].id, function(f)
	if player.is_player_valid(player.player_id()) then
		local peds = utilities.get_table_of_entities(ped.get_all_peds(), 1000, 300, true, true, player.get_player_coords(player.player_id()))
		for i = 1, #peds do
			if not ped.is_ped_a_player(peds[i]) then
				network.request_control_of_entity(peds[i])
				utilities.hard_remove_entity(peds[i])
			end
		end
		local vehicles = utilities.get_table_of_entities(vehicle.get_all_vehicles(), 1000, 300, true, true, player.get_player_coords(player.player_id()))
		for i = 1, #vehicles do
			if vehicles[i] ~= player.get_player_vehicle(player.player_id()) then
				network.request_control_of_entity(vehicles[i])
				utilities.hard_remove_entity(vehicles[i])
			end
		end
		local objects = utilities.get_table_of_entities(object.get_all_objects(), 1000, 300, true, true, player.get_player_coords(player.player_id()))
		for i = 1, #objects do
			network.request_control_of_entity(objects[i])
			utilities.hard_remove_entity(objects[i])
		end
		local pickups = utilities.get_table_of_entities(object.get_all_pickups(), 1000, 300, true, true, player.get_player_coords(player.player_id()))
		for i = 1, #pickups do
			network.request_control_of_entity(pickups[i])
			utilities.hard_remove_entity(pickups[i])
		end
	end
end)

feature["» Display OS Time"] = menu.add_feature("» Display OS Time", "toggle", localparents["» Gameplay Utilities"].id, function(f)
	if f.on then
		settings["» Display OS Time"] = true
    	while f.on do
    	    system.wait(0)
			ui.set_text_scale(0.4)
			ui.set_text_font(4)
			ui.set_text_centre(0)
			ui.set_text_outline(true)
			ui.set_text_color(255, 255, 255, 255)
			ui.draw_text(os.date(), v2(0.955, 0.001))
		end
	end
	if not f.on then
		settings["» Display OS Time"] = false
	end
end)
feature["» Display OS Time"].on = settings["» Display OS Time"]

localparents["» Entity Controls"] = menu.add_feature("» Entity Controls", "parent", localparents["» Gameplay Utilities"].id)

feature["» Quick Entity Actions"] = menu.add_feature("» Quick Entity Actions", "toggle", localparents["» Entity Controls"].id, function(f)
	if f.on then
		settings["» Quick Entity Actions"] = true
		while f.on do
			system.yield(0)
			if player.is_player_free_aiming(player.player_id()) then
				local controls_entity_aimed_at = player.get_entity_player_is_aiming_at(player.player_id())
				if entity.is_entity_a_ped(controls_entity_aimed_at) and not ped.is_ped_in_any_vehicle(controls_entity_aimed_at) and not ped.is_ped_a_player(controls_entity_aimed_at) then
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("| Ped |", v2(0.5, 0.925))
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("X - Delete | H - Resurrect | B - Copy Hash | K - Explode | N - Kill | U - Ragdoll | C - Clear Tasks", v2(0.5, 0.95))
					network.request_control_of_entity(controls_entity_aimed_at)
					if controls.is_disabled_control_just_pressed(2, 323) then
						utilities.hard_remove_entity(controls_entity_aimed_at)
					elseif controls.is_disabled_control_just_pressed(2, 304) then
						menu.create_thread(function()
							if entity.is_entity_dead(controls_entity_aimed_at, true) then
								graphics.set_next_ptfx_asset("scr_rcbarry1")
								while not graphics.has_named_ptfx_asset_loaded("scr_rcbarry1") do
									graphics.request_named_ptfx_asset("scr_rcbarry1")
									system.wait(0)
								end
								local pos = entity.get_entity_coords(controls_entity_aimed_at)
								graphics.start_networked_particle_fx_non_looped_at_coord("scr_alien_teleport", pos + v3(0, 0, -2), v3(0, 0, 0), 4, true, true, true)
								system.wait(1000)
								network.request_control_of_entity(controls_entity_aimed_at)
								 if (not network.has_control_of_entity(controls_entity_aimed_at)) then
										network.request_control_of_entity(controls_entity_aimed_at)
								end
								ped.resurrect_ped(controls_entity_aimed_at)
								ped.clear_ped_tasks_immediately(controls_entity_aimed_at)
								entity.set_entity_collision(controls_entity_aimed_at, true, true, true)
								for i = 1, 500 do
									ped.clear_ped_tasks_immediately(controls_entity_aimed_at)
								end
								system.wait(100)
								local health = ped.get_ped_max_health(controls_entity_aimed_at)
								ped.set_ped_max_health(controls_entity_aimed_at, health)
								system.wait(100)
								ped.set_ped_health(controls_entity_aimed_at, health)
								ped.clear_ped_blood_damage(controls_entity_aimed_at)
								graphics.remove_named_ptfx_asset("scr_rcbarry1")
							end
						end, nil)
					elseif controls.is_disabled_control_just_pressed(2, 29) then
						utils.to_clipboard(entity.get_entity_model_hash(controls_entity_aimed_at))
						menu.notify("[!] Copied Hash! - " .. entity.get_entity_model_hash(controls_entity_aimed_at) .. "", Meteor)
					elseif controls.is_disabled_control_just_pressed(2, 311) then
						fire.add_explosion(entity.get_entity_coords(controls_entity_aimed_at), 0, true, false, 0.1, controls_entity_aimed_at)
					elseif controls.is_disabled_control_just_pressed(2, 306) then
						ped.set_ped_max_health(controls_entity_aimed_at, 0)
						ped.set_ped_health(controls_entity_aimed_at, 0)
					elseif controls.is_disabled_control_just_pressed(2, 303) then
						ped.set_ped_to_ragdoll(controls_entity_aimed_at, 1000, 1000, 0)
					elseif controls.is_disabled_control_pressed(2, 324) then
						ped.clear_ped_tasks_immediately(controls_entity_aimed_at)
					end
				elseif entity.is_entity_a_ped(controls_entity_aimed_at) and not ped.is_ped_in_any_vehicle(controls_entity_aimed_at) and ped.is_ped_a_player(controls_entity_aimed_at) then
					local controls_entity_aimed_at = player.get_player_from_ped(controls_entity_aimed_at)
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("| Player |", v2(0.5, 0.925))
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("X - Explode | B - Kick | K - Crash | N - Taze | H - Send To Brazil | C - Freeze", v2(0.5, 0.95))
					if controls.is_disabled_control_just_pressed(2, 323) then
						fire.add_explosion(player.get_player_coords(controls_entity_aimed_at), 0, true, false, 0.1, player.get_player_ped(controls_entity_aimed_at))
					elseif controls.is_disabled_control_just_pressed(2, 29) then
						if network.network_is_host() then
							network.network_session_kick_player(controls_entity_aimed_at)
						elseif player.is_player_host(controls_entity_aimed_at) and player.is_player_modder(controls_entity_aimed_at, -1) then
							utilities.se_kick(controls_entity_aimed_at)
						else
							network.force_remove_player(controls_entity_aimed_at)
						end
					elseif controls.is_disabled_control_just_pressed(2, 311) then
						if player.is_player_valid(controls_entity_aimed_at) then
							script.trigger_script_event(962740265, controls_entity_aimed_at, {controls_entity_aimed_at, 23243, 5332, 3324, controls_entity_aimed_at})
						end
					elseif controls.is_disabled_control_just_pressed(2, 306) then
						gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(controls_entity_aimed_at) + v3(0, 0, 2), entity.get_entity_coords(controls_entity_aimed_at), 0, gameplay.get_hash_key("weapon_stungun"), player.get_player_ped(player.player_id()), true, false, 10000)
					elseif controls.is_disabled_control_just_pressed(2, 304) then
						utilities.send_to_brazil(controls_entity_aimed_at)
					elseif controls.is_disabled_control_pressed(2, 324) then
						network.request_control_of_entity(controls_entity_aimed_at)
						ped.clear_ped_tasks_immediately(controls_entity_aimed_at)
					end
				elseif entity.is_entity_a_ped(controls_entity_aimed_at) and ped.is_ped_in_any_vehicle(controls_entity_aimed_at) then
					local controls_vehicle_aimed_at = ped.get_vehicle_ped_is_using(controls_entity_aimed_at)
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("| Vehicle |", v2(0.5, 0.925))
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("X - Delete | B - Copy Hash | K - Explode | N - Engine | U - No Control | H - Enter | C - Freeze", v2(0.5, 0.95))
					network.request_control_of_entity(controls_vehicle_aimed_at)
					if controls.is_disabled_control_just_pressed(2, 323) then
						utilities.hard_remove_entity(controls_vehicle_aimed_at)
					elseif controls.is_disabled_control_just_pressed(2, 29) then
						utils.to_clipboard(entity.get_entity_model_hash(controls_vehicle_aimed_at))
						menu.notify("[!] Copied Hash! - " .. entity.get_entity_model_hash(controls_vehicle_aimed_at) .. "", Meteor)
					elseif controls.is_disabled_control_just_pressed(2, 311) then
						fire.add_explosion(entity.get_entity_coords(controls_vehicle_aimed_at), 0, true, false, 0.1, controls_vehicle_aimed_at)
					elseif controls.is_disabled_control_just_pressed(2, 306) then
						vehicle.set_vehicle_engine_health(controls_vehicle_aimed_at, -1)
					elseif controls.is_disabled_control_just_pressed(2, 303) then
						vehicle.set_vehicle_out_of_control(controls_vehicle_aimed_at, true, true)
					elseif controls.is_disabled_control_just_pressed(2, 304) then
						if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(controls_vehicle_aimed_at, -1)) then
							ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), controls_vehicle_aimed_at, -2)
						else
							network.request_control_of_entity(vehicle.get_ped_in_vehicle_seat(controls_vehicle_aimed_at, -1))
							network.request_control_of_entity(controls_vehicle_aimed_at)
							ped.set_ped_into_vehicle(vehicle.get_ped_in_vehicle_seat(controls_vehicle_aimed_at, -1), controls_vehicle_aimed_at, -2)
							ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), controls_vehicle_aimed_at, -1)
						end
					end
					if controls.is_disabled_control_pressed(2, 324) then
						entity.freeze_entity(controls_vehicle_aimed_at, true)
					else
						entity.freeze_entity(controls_vehicle_aimed_at, false)
					end
				elseif entity.is_entity_a_vehicle(controls_entity_aimed_at) then
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("| Vehicle |", v2(0.5, 0.925))
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("X - Delete | B - Copy Hash | K - Explode | N - Engine | U - No Control | H - Enter | C - Freeze", v2(0.5, 0.95))
					network.request_control_of_entity(controls_entity_aimed_at)
					if controls.is_disabled_control_just_pressed(2, 323) then
						utilities.hard_remove_entity(controls_entity_aimed_at)
					elseif controls.is_disabled_control_just_pressed(2, 29) then
						utils.to_clipboard(entity.get_entity_model_hash(controls_entity_aimed_at))
						menu.notify("[!] Copied Hash! - " .. entity.get_entity_model_hash(controls_entity_aimed_at) .. "", Meteor)
					elseif controls.is_disabled_control_just_pressed(2, 311) then
						fire.add_explosion(entity.get_entity_coords(controls_entity_aimed_at), 0, true, false, 0.1, controls_entity_aimed_at)
					elseif controls.is_disabled_control_just_pressed(2, 306) then
						vehicle.set_vehicle_engine_health(controls_entity_aimed_at, -1)
					elseif controls.is_disabled_control_just_pressed(2, 303) then
						vehicle.set_vehicle_out_of_control(controls_entity_aimed_at, true, true)
					elseif controls.is_disabled_control_just_pressed(2, 303) then
						vehicle.set_vehicle_out_of_control(controls_entity_aimed_at, true, true)
					elseif controls.is_disabled_control_just_pressed(2, 304) then
						if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(controls_entity_aimed_at, -1)) then
							ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), controls_entity_aimed_at, -2)
						else
							network.request_control_of_entity(vehicle.get_ped_in_vehicle_seat(controls_entity_aimed_at, -1))
							network.request_control_of_entity(controls_entity_aimed_at)
							ped.set_ped_into_vehicle(vehicle.get_ped_in_vehicle_seat(controls_entity_aimed_at, -1), controls_entity_aimed_at, -2)
							ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), controls_entity_aimed_at, -1)
						end
					end
					if controls.is_disabled_control_pressed(2, 324) then
						entity.freeze_entity(controls_entity_aimed_at, true)
					else
						entity.freeze_entity(controls_entity_aimed_at, false)
					end
				elseif entity.is_entity_an_object(controls_entity_aimed_at) then
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("| Object |", v2(0.5, 0.925))
					ui.set_text_scale(0.4)
					ui.set_text_font(4)
					ui.set_text_centre(0)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("X - Delete | B - Copy Hash", v2(0.5, 0.95))
					network.request_control_of_entity(controls_entity_aimed_at)
					if controls.is_disabled_control_just_pressed(2, 323) then
						utilities.hard_remove_entity(controls_entity_aimed_at)
					elseif controls.is_disabled_control_just_pressed(2, 29) then
						utils.to_clipboard(entity.get_entity_model_hash(controls_entity_aimed_at))
						menu.notify("[!] Copied Hash! - " .. entity.get_entity_model_hash(controls_entity_aimed_at) .. "", Meteor)
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Quick Entity Actions"] = false
	end
end)
feature["» Quick Entity Actions"].on = settings["» Quick Entity Actions"]

feature["» Entity Debug Info"] = menu.add_feature("» Entity Debug Info", "toggle", localparents["» Entity Controls"].id, function(f)
	if f.on then
		settings["» Entity Debug Info"] = true
		while f.on do
			system.yield(0)
			if player.is_player_free_aiming(player.player_id()) then
				local entity_debug_info_entity = player.get_entity_player_is_aiming_at(player.player_id())
				if entity.is_entity_a_ped(entity_debug_info_entity) and not ped.is_ped_in_any_vehicle(entity_debug_info_entity) and not ped.is_ped_a_player(entity_debug_info_entity) then
					ui.set_text_scale(0.6)
					ui.set_text_font(7)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Ped", v2(0.5, 0.5))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Hash: " .. entity.get_entity_model_hash(entity_debug_info_entity) .. "", v2(0.5, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Health: " .. utilities.round(ped.get_ped_health(entity_debug_info_entity)) .. "/" .. utilities.round(ped.get_ped_max_health(entity_debug_info_entity)) .. "", v2(0.5, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Dead: " .. string.format("%s", entity.is_entity_dead(entity_debug_info_entity)) .. "", v2(0.5, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("God: " .. string.format("%s", entity.get_entity_god_mode(entity_debug_info_entity)) .. "", v2(0.5, 0.59))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Visible: " .. string.format("%s", entity.is_entity_visible(entity_debug_info_entity)) .. "", v2(0.5, 0.61))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Hash Loaded: " .. string.format("%s", streaming.has_model_loaded(entity.get_entity_model_hash(entity_debug_info_entity))) .. "", v2(0.5, 0.63))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Attached: " .. string.format("%s", entity.is_entity_attached(entity_debug_info_entity)) .. "", v2(0.5, 0.65))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Dead: " .. string.format("%s", entity.is_entity_dead(entity_debug_info_entity)) .. "", v2(0.5, 0.67))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Position: " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).z) .. "", v2(0.58, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Rotation: " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).z) .. "", v2(0.58, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Heading: " .. utilities.round_two_dc(entity.get_entity_heading(entity_debug_info_entity)) .. "", v2(0.58, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Model: " .. PedModel.get_ped_model_from_hash(entity.get_entity_model_hash(entity_debug_info_entity)) .. "", v2(0.58, 0.59))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("L - Get Oufit Components", v2(0.58, 0.67))
					if controls.is_disabled_control_just_pressed(2, 182) then
						if ped.get_ped_prop_index(entity_debug_info_entity, 0) == 4294967295 or ped.get_ped_prop_index(entity_debug_info_entity, 1) == 4294967295 or ped.get_ped_prop_index(entity_debug_info_entity, 2) == 4294967295 then
							menu.notify("Index 0: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 0) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 0) .. "\nIndex 1: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 1) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 1) .. "\nIndex 2: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 2) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 2) .. "\nIndex 3: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 3) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 3) .. "\nIndex 4: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 4) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 4) .. "\nIndex 5: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 5) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 5) .. "\nIndex 6: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 6) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 6) .. "\nIndex 7: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 7) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 7) .. "\nIndex 8: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 8) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 8) .. "\nIndex 9: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 9) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 9) .. "\nIndex 10: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 10) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 10) .. "\nIndex 11: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 11) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 11) .. "\n\nIndex 0: 0 | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 0) .. "\nIndex 1: 0 | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 1) .. "\nIndex 2: 0 | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 2) .. "")
						else
							menu.notify("Index 0: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 0) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 0) .. "\nIndex 1: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 1) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 1) .. "\nIndex 2: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 2) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 2) .. "\nIndex 3: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 3) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 3) .. "\nIndex 4: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 4) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 4) .. "\nIndex 5: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 5) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 5) .. "\nIndex 6: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 6) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 6) .. "\nIndex 7: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 7) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 7) .. "\nIndex 8: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 8) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 8) .. "\nIndex 9: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 9) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 9) .. "\nIndex 10: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 10) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 10) .. "\nIndex 11: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 11) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 11) .. "\n\nIndex 0: " .. ped.get_ped_prop_index(entity_debug_info_entity, 0) .. " | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 0) .. "\nIndex 1: " .. ped.get_ped_prop_index(entity_debug_info_entity, 1) .. " | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 1) .. "\nIndex 2: " .. ped.get_ped_prop_index(entity_debug_info_entity, 2) .. " | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 2) .. "")
						end
					end
				elseif entity.is_entity_a_ped(entity_debug_info_entity) and not ped.is_ped_in_any_vehicle(entity_debug_info_entity) and ped.is_ped_a_player(entity_debug_info_entity) then
					local player_debug_info_entity = player.get_player_from_ped(entity_debug_info_entity)
					local player_flags_str = ""
					if player_debug_info_entity == player.player_id() then
						player_flags_str = player_flags_str .. "Y"
					end
					if player.is_player_friend(player_debug_info_entity) then
						player_flags_str = player_flags_str .. "F"
					end
					if player.is_player_modder(player_debug_info_entity, -1) then
						player_flags_str = player_flags_str .. "M"
					end
					if utilities.is_player_rockstar_admin_scid(player_debug_info_entity) or utilities.is_player_rockstar_admin_name(player_debug_info_entity) or utilities.is_player_rockstar_admin_ip(player_debug_info_entity) then
						player_flags_str = player_flags_str .. "A"
					end
					if player.is_player_host(player_debug_info_entity) then
						player_flags_str = player_flags_str .. "H"
					end
					if player_debug_info_entity == script.get_host_of_this_script() then
						player_flags_str = player_flags_str .. "S"
					end
					ui.set_text_scale(0.6)
					ui.set_text_font(7)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Player", v2(0.5, 0.5))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Name: [" .. player_flags_str .. "] " .. string.format("%s", player.get_player_name(player_debug_info_entity)) .. "", v2(0.5, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("ID: " .. player_debug_info_entity .. "", v2(0.5, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("SCID: " .. player.get_player_scid(player_debug_info_entity) .. "", v2(0.5, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("IP: " .. utilities.dec_to_ipv4(player.get_player_ip(player_debug_info_entity)) .. "", v2(0.5, 0.59))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Health: " .. utilities.round(player.get_player_health(player_debug_info_entity)) .. "/" .. utilities.round(player.get_player_max_health(player_debug_info_entity)) .. "", v2(0.5, 0.61))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("God: " .. string.format("%s", player.is_player_god(player_debug_info_entity)) .. "", v2(0.5, 0.63))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Position: " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).z) .. "", v2(0.58, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Rotation: " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).z) .. "", v2(0.58, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Heading: " .. utilities.round_two_dc(entity.get_entity_heading(entity_debug_info_entity)) .. "", v2(0.58, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("L - Get Oufit Components", v2(0.58, 0.63))
					if controls.is_disabled_control_just_pressed(2, 182) then
						if ped.get_ped_prop_index(entity_debug_info_entity, 0) == 4294967295 or ped.get_ped_prop_index(entity_debug_info_entity, 1) == 4294967295 or ped.get_ped_prop_index(entity_debug_info_entity, 2) == 4294967295 then
							menu.notify("Index 0: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 0) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 0) .. "\nIndex 1: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 1) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 1) .. "\nIndex 2: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 2) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 2) .. "\nIndex 3: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 3) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 3) .. "\nIndex 4: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 4) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 4) .. "\nIndex 5: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 5) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 5) .. "\nIndex 6: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 6) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 6) .. "\nIndex 7: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 7) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 7) .. "\nIndex 8: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 8) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 8) .. "\nIndex 9: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 9) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 9) .. "\nIndex 10: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 10) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 10) .. "\nIndex 11: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 11) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 11) .. "\n\nIndex 0: 0 | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 0) .. "\nIndex 1: 0 | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 1) .. "\nIndex 2: 0 | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 2) .. "")
						else
							menu.notify("Index 0: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 0) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 0) .. "\nIndex 1: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 1) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 1) .. "\nIndex 2: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 2) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 2) .. "\nIndex 3: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 3) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 3) .. "\nIndex 4: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 4) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 4) .. "\nIndex 5: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 5) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 5) .. "\nIndex 6: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 6) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 6) .. "\nIndex 7: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 7) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 7) .. "\nIndex 8: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 8) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 8) .. "\nIndex 9: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 9) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 9) .. "\nIndex 10: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 10) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 10) .. "\nIndex 11: " .. ped.get_ped_drawable_variation(entity_debug_info_entity, 11) .. " | " .. ped.get_ped_texture_variation(entity_debug_info_entity, 11) .. "\n\nIndex 0: " .. ped.get_ped_prop_index(entity_debug_info_entity, 0) .. " | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 0) .. "\nIndex 1: " .. ped.get_ped_prop_index(entity_debug_info_entity, 1) .. " | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 1) .. "\nIndex 2: " .. ped.get_ped_prop_index(entity_debug_info_entity, 2) .. " | " .. ped.get_ped_prop_texture_index(entity_debug_info_entity, 2) .. "")
						end
					end
				elseif entity.is_entity_a_ped(entity_debug_info_entity) and ped.is_ped_in_any_vehicle(entity_debug_info_entity) then
					local entity_debug_info_entity = ped.get_vehicle_ped_is_using(entity_debug_info_entity)
					ui.set_text_scale(0.6)
					ui.set_text_font(7)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Vehicle", v2(0.5, 0.5))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Hash: " .. entity.get_entity_model_hash(entity_debug_info_entity) .. "", v2(0.5, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Name: " .. vehicle.get_vehicle_model(entity_debug_info_entity) .. "", v2(0.5, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("God: " .. string.format("%s", entity.get_entity_god_mode(entity_debug_info_entity)) .. "", v2(0.5, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Visible: " .. string.format("%s", entity.is_entity_visible(entity_debug_info_entity)) .. "", v2(0.5, 0.59))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Hash Loaded: " .. string.format("%s", streaming.has_model_loaded(entity.get_entity_model_hash(entity_debug_info_entity))) .. "", v2(0.5, 0.61))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Attached: " .. string.format("%s", entity.is_entity_attached(entity_debug_info_entity)) .. "", v2(0.5, 0.63))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Dead: " .. string.format("%s", entity.is_entity_dead(entity_debug_info_entity)) .. "", v2(0.5, 0.65))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Position: " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).z) .. "", v2(0.58, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Rotation: " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).z) .. "", v2(0.58, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Heading: " .. utilities.round_two_dc(entity.get_entity_heading(entity_debug_info_entity)) .. "", v2(0.58, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Model: " .. VehicleModel.get_vehicle_model_from_hash(entity.get_entity_model_hash(entity_debug_info_entity)) .. "", v2(0.58, 0.59))
				elseif entity.is_entity_a_vehicle(entity_debug_info_entity) then
					ui.set_text_scale(0.6)
					ui.set_text_font(7)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Vehicle", v2(0.5, 0.5))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Hash: " .. entity.get_entity_model_hash(entity_debug_info_entity) .. "", v2(0.5, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Name: " .. vehicle.get_vehicle_model(entity_debug_info_entity) .. "", v2(0.5, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("God: " .. string.format("%s", entity.get_entity_god_mode(entity_debug_info_entity)) .. "", v2(0.5, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Visible: " .. string.format("%s", entity.is_entity_visible(entity_debug_info_entity)) .. "", v2(0.5, 0.59))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Hash Loaded: " .. string.format("%s", streaming.has_model_loaded(entity.get_entity_model_hash(entity_debug_info_entity))) .. "", v2(0.5, 0.61))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Attached: " .. string.format("%s", entity.is_entity_attached(entity_debug_info_entity)) .. "", v2(0.5, 0.63))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Dead: " .. string.format("%s", entity.is_entity_dead(entity_debug_info_entity)) .. "", v2(0.5, 0.65))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Position: " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).z) .. "", v2(0.58, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Rotation: " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).z) .. "", v2(0.58, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Heading: " .. utilities.round_two_dc(entity.get_entity_heading(entity_debug_info_entity)) .. "", v2(0.58, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Model: " .. VehicleModel.get_vehicle_model_from_hash(entity.get_entity_model_hash(entity_debug_info_entity)) .. "", v2(0.58, 0.59))
				elseif entity.is_entity_an_object(entity_debug_info_entity) then
					ui.set_text_scale(0.6)
					ui.set_text_font(7)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Object", v2(0.5, 0.5))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Hash: " .. entity.get_entity_model_hash(entity_debug_info_entity) .. "", v2(0.5, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("God: " .. string.format("%s", entity.get_entity_god_mode(entity_debug_info_entity)) .. "", v2(0.5, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Visible: " .. string.format("%s", entity.is_entity_visible(entity_debug_info_entity)) .. "", v2(0.5, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Hash Loaded: " .. string.format("%s", streaming.has_model_loaded(entity.get_entity_model_hash(entity_debug_info_entity))) .. "", v2(0.5, 0.59))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Attached: " .. string.format("%s", entity.is_entity_attached(entity_debug_info_entity)) .. "", v2(0.5, 0.61))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Static: " .. string.format("%s", entity.is_entity_static(entity_debug_info_entity)) .. "", v2(0.5, 0.63))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Position: " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_coords(entity_debug_info_entity).z) .. "", v2(0.58, 0.53))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Rotation: " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).x) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).y) .. ", " .. utilities.round_two_dc(entity.get_entity_rotation(entity_debug_info_entity).z) .. "", v2(0.58, 0.55))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Heading: " .. utilities.round_two_dc(entity.get_entity_heading(entity_debug_info_entity)) .. "", v2(0.58, 0.57))
					ui.set_text_scale(0.35)
					ui.set_text_font(4)
					ui.set_text_outline(true)
					ui.set_text_color(255, 255, 255, 255)
					ui.draw_text("Model: " .. ObjectModel.get_object_model_from_hash(entity.get_entity_model_hash(entity_debug_info_entity)) .. "", v2(0.58, 0.59))
				end
			end
		end
	end
	if not f.on then
		settings["» Entity Debug Info"] = false
	end
end)
feature["» Entity Debug Info"].on = settings["» Entity Debug Info"]

feature["» No Entity Collision"] = menu.add_feature("» No Entity Collision", "toggle", localparents["» Entity Controls"].id, function(f)
    if f.on then
        if player.is_player_in_any_vehicle(player.player_id()) then
            local peds = ped.get_all_peds()
            for i = 1, #peds do
                entity.set_entity_no_collsion_entity(peds[i], player.get_player_vehicle(player.player_id()), true)
                entity.set_entity_no_collsion_entity(player.get_player_vehicle(player.player_id()), peds[i], true)
            end
			local vehicles = vehicle.get_all_vehicles()
            for i = 1, #vehicles do
                entity.set_entity_no_collsion_entity(vehicles[i], player.get_player_vehicle(player.player_id()), true)
                entity.set_entity_no_collsion_entity(player.get_player_vehicle(player.player_id()), vehicles[i], true)
            end
            local objects = object.get_all_objects()
            for i = 1, #objects do
                entity.set_entity_no_collsion_entity(objects[i], player.get_player_vehicle(player.player_id()), true)
                entity.set_entity_no_collsion_entity(player.get_player_vehicle(player.player_id()), objects[i], true)
            end
		else
			local peds = ped.get_all_peds()
            for i = 1, #peds do
                entity.set_entity_no_collsion_entity(peds[i], player.get_player_ped(player.player_id()), true)
                entity.set_entity_no_collsion_entity(player.get_player_ped(player.player_id()), peds[i], true)
            end
			local vehicles = vehicle.get_all_vehicles()
            for i = 1, #vehicles do
                entity.set_entity_no_collsion_entity(vehicles[i], player.get_player_ped(player.player_id()), true)
                entity.set_entity_no_collsion_entity(player.get_player_ped(player.player_id()), vehicles[i], true)
            end
            local objects = object.get_all_objects()
            for i = 1, #objects do
                entity.set_entity_no_collsion_entity(objects[i], player.get_player_ped(player.player_id()), true)
                entity.set_entity_no_collsion_entity(player.get_player_ped(player.player_id()), objects[i], true)
            end
        end
    end
    return HANDLER_CONTINUE
end)
feature["» No Entity Collision"].on = settings["» No Entity Collision"]

feature["» Disable Vehicle Spawning"] = menu.add_feature("» Disable Vehicle Spawning", "toggle", localparents["» Entity Controls"].id, function(f)
	if f.on then
		settings["» Disable Vehicle Spawning"] = true
   		while f.on do
			vehicle.set_vehicle_density_multipliers_this_frame(0)
			system.yield(0)
    	end
	end
	if not f.on then
		settings["» Disable Vehicle Spawning"] = false
	end
end)
feature["» Disable Vehicle Spawning"].on = settings["» Disable Vehicle Spawning"]

feature["» Disable Ped Spawning"] = menu.add_feature("» Disable Ped Spawning", "toggle", localparents["» Entity Controls"].id, function(f)
	if f.on then
		settings["» Disable Ped Spawning"] = true
    	while f.on do
			ped.set_ped_density_multiplier_this_frame(0)
			system.yield(0)
    	end
	end
	if not f.on then
		settings["» Disable Ped Spawning"] = false
	end
end)
feature["» Disable Ped Spawning"].on = settings["» Disable Ped Spawning"]

feature["» Nearby Peds Godmode"] = menu.add_feature("» Nearby Peds Godmode", "toggle", localparents["» Entity Controls"].id, function(f)
	if f.on then
		settings["» Nearby Peds Godmode"] = true
    	while f.on do
			system.yield(10)
    	    local peds = ped.get_all_peds()
    	    for i = 1, #peds do
    	        network.request_control_of_entity(peds[i])
				entity.set_entity_god_mode(peds[i], true)
   		    end
    	end
	end
	if not f.on then
        local peds = ped.get_all_peds()
        for i = 1, #peds do
            network.request_control_of_entity(peds[i])
			entity.set_entity_god_mode(peds[i], false)
   	    end
		settings["» Nearby Peds Godmode"] = false
	end
end)
feature["» Nearby Peds Godmode"].on = settings["» Nearby Peds Godmode"]

feature["» Nearby Vehicles Godmode"] = menu.add_feature("» Nearby Vehicles Godmode", "toggle", localparents["» Entity Controls"].id, function(f)
	if f.on then
		settings["» Nearby Vehicles Godmode"] = true
    	while f.on do
			system.yield(10)
    	    local vehicles = vehicle.get_all_vehicles()
    	    for i = 1, #vehicles do
    	        network.request_control_of_entity(vehicles[i])
				entity.set_entity_god_mode(vehicles[i], true)
    	    end
    	end
	end
	if not f.on then
    	local vehicles = vehicle.get_all_vehicles()
    	for i = 1, #vehicles do
    	    network.request_control_of_entity(vehicles[i])
			entity.set_entity_god_mode(vehicles[i], false)
    	end
		settings["» Nearby Vehicles Godmode"] = false
	end
end)
feature["» Nearby Vehicles Godmode"].on = settings["» Nearby Vehicles Godmode"]

--

localparents["» Door Control"] = menu.add_feature("» Door Control", "parent", localparents["» Vehicle Options"].id)

feature["» Open Vehicle Door"] = menu.add_feature("» Open Vehicle Door", "action_value_i", localparents["» Door Control"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		vehicle.set_vehicle_door_open(player.get_player_vehicle(player.player_id()), f.value - 1, false, true)
	else
		menu.notify("[!] You are not in a vehicle", Meteor, 3, 211)
	end
end)
feature["» Open Vehicle Door"].max = 8
feature["» Open Vehicle Door"].min = 1
feature["» Open Vehicle Door"].mod = 1
feature["» Open Vehicle Door"].value = 0

menu.add_feature("» Open All Vehicle Doors", "action", localparents["» Door Control"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		for i = 1, 8 do
			vehicle.set_vehicle_door_open(player.get_player_vehicle(player.player_id()), i - 1, false, true)
		end
		system.wait(100)
		for i = 1, 8 do
			vehicle.set_vehicle_door_open(player.get_player_vehicle(player.player_id()), i - 1, false, true)
		end
	else
		menu.notify("[!] You are not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_feature("» Close All Vehicle Doors", "action", localparents["» Door Control"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		for i = 1, 8 do
			vehicle.set_vehicle_doors_shut(player.get_player_vehicle(player.player_id()), i - 1, false, true)
		end
	else
		menu.notify("[!] You are not in a vehicle", Meteor, 3, 211)
	end
end)

feature["» Lock All Vehicle Doors"] = menu.add_feature("» Lock All Vehicle Doors", "toggle", localparents["» Door Control"].id, function(f)
	if f.on then
		settings["» Lock All Vehicle Doors"] = true
		if player.is_player_in_any_vehicle(player.player_id()) then
			player_veh = player.get_player_vehicle(player.player_id())
			vehicle.set_vehicle_doors_locked(player_veh, 4)
		else
			menu.notify("[!] You are not in a vehicle", Meteor, 3, 211)
			settings["» Lock All Vehicle Doors"] = false
			f.on = false
		end
	end
	if not f.on then
		vehicle.set_vehicle_doors_locked(player_veh, 0)
		settings["» Lock All Vehicle Doors"] = false
	end
end)
feature["» Lock All Vehicle Doors"].on = settings["» Lock All Vehicle Doors"]

feature["» Heli Blades Speed"] = menu.add_feature("» Heli Blades Speed", "slider", localparents["» Vehicle Options"].id, function(f)
    if f.on then
		settings["» Heli Blades Speed"] = true
		while f.on do
			system.yield(0)
       	 	network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
       		vehicle.set_heli_blades_speed(player.get_player_vehicle(player.player_id()), f.value)
		end
    end
	if not f.on then
		settings["» Heli Blades Speed"] = false
	end
end)
feature["» Heli Blades Speed"].max = 1
feature["» Heli Blades Speed"].min = 0
feature["» Heli Blades Speed"].mod = 0.1
feature["» Heli Blades Speed"].value = 0
feature["» Heli Blades Speed"] = settings["» Heli Blades Speed"]

menu.add_feature("» Modify Vehicle Speed", "action", localparents["» Vehicle Options"].id, function(f)
    local player_veh = player.get_player_vehicle(player.player_id())
    if player.is_player_in_any_vehicle(player.player_id()) then
        local input_stat, input_val = input.get("Enter Modified Speed (1-10000)", "", 5, 3)

        if input_stat == 1 then
            return HANDLER_CONTINUE
        end
    
        if input_stat == 2 then
            return HANDLER_POP
        end

        if tonumber(input_val) < 1 or tonumber(input_val) > 10000 then
            menu.notify("[!] Invalid Input!", Meteor, 3, 211)
        end
        network.request_control_of_entity(player_veh)
        while not network.has_control_of_entity(player_veh) do
            network.request_control_of_entity(player_veh)
            system.wait(0)
        end
        entity.set_entity_max_speed(player_veh, input_val / 3.6)
        vehicle.modify_vehicle_top_speed(player_veh, input_val / 3.6)
		vehicle.set_vehicle_engine_torque_multiplier_this_frame(player_veh, input_val / 3.6)
    else
        menu.notify("[!] You are not in a vehicle", Meteor, 3, 211)
    end
end)

feature["» Reduce Grip"] = menu.add_feature("» Reduce Grip", "toggle", localparents["» Vehicle Options"].id, function(f)
	if f.on then
		settings["» Reduce Grip"] = true
    	while f.on do
    	    network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			while not network.has_control_of_entity(player.get_player_vehicle(player.player_id())) do
				network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
				system.wait(0)
			end
			vehicle.set_vehicle_reduce_grip(player.get_player_vehicle(player.player_id()), true)
			system.yield(1000)
		end
    end
	if not f.on then
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		while not network.has_control_of_entity(player.get_player_vehicle(player.player_id())) do
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			system.wait(0)
		end
		vehicle.set_vehicle_reduce_grip(player.get_player_vehicle(player.player_id()), false)
		settings["» Reduce Grip"] = false
	end
end)
feature["» Reduce Grip"].on = settings["» Reduce Grip"]

feature["» Bouncy Vehicle"] = menu.add_feature("» Bouncy Vehicle", "toggle", localparents["» Vehicle Options"].id, function(f)
	if f.on then
		settings["» Bouncy Vehicle"] = true
    	while f.on do
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
   	     	local vehicle_velocity = entity.get_entity_velocity(player.get_player_vehicle(player.player_id()))
   	    	entity.set_entity_velocity(player.get_player_vehicle(player.player_id()), v3(vehicle_velocity.x, vehicle_velocity.y, vehicle_velocity.z + 2.5))
			system.yield(1000)
   		end
	end
	if not f.on then
		settings["» Bouncy Vehicle"] = false
	end
end)
feature["» Bouncy Vehicle"].on = settings["» Bouncy Vehicle"]

feature["» Extra Bombs For Planes"] = menu.add_feature("» Extra Bombs For Planes", "toggle", localparents["» Vehicle Options"].id, function(f)
	if f.on then
		if bombs_to_besra == nil then
			menu.notify("[!] Press or hold H to drop bombs!", Meteor, 4, 0x64FA7800)
			bombs_to_besra = 1
		end
		settings["» Extra Bombs For Planes"] = true
		while f.on do
			system.yield(0)
			while controls.is_disabled_control_pressed(2, 304) and player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and entity.get_entity_rotation(player.get_player_vehicle(player.player_id())).x < 30 and entity.get_entity_rotation(player.get_player_vehicle(player.player_id())).x > -70 and entity.get_entity_rotation(player.get_player_vehicle(player.player_id())).y < 30 and entity.get_entity_rotation(player.get_player_vehicle(player.player_id())).y > -30 and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) do
				menu.create_thread(function()
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					local object_ = object.create_object(gameplay.get_hash_key("W_Smug_Bomb_03"), utilities.offset_coords_back(player.get_player_coords(player.player_id()), entity.get_entity_heading(player.get_player_vehicle(player.player_id())), 2) + v3(0, 0, -1), true, true)
					entity.set_entity_no_collsion_entity(object_, player.get_player_vehicle(player.player_id()), false)
					entity.apply_force_to_entity(object_, 3, vectorV3.x, vectorV3.y, vectorV3.z - 100, 0.0, 0.0, 0.0, false, true)
					local veh_rot = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) + v3(180, 0, 0)
					local veh_heading = entity.get_entity_heading(player.get_player_vehicle(player.player_id()))
					while f.on do
						system.yield(10)
						entity.set_entity_heading(object_, veh_heading)
						entity.set_entity_rotation(object_, veh_rot)
						if entity.has_entity_collided_with_anything(object_) or not f.on then
							fire.add_explosion(entity.get_entity_coords(object_), 8, true, false, 0.3, player.get_player_ped(player.player_id()))
							fire.add_explosion(entity.get_entity_coords(object_), 60, true, false, 0.3, player.get_player_ped(player.player_id()))
							entity.delete_entity(object_)
						end
						if entity.is_entity_in_water(object_) then
							fire.add_explosion(entity.get_entity_coords(object_), 52, true, false, 0.3, player.get_player_ped(player.player_id()))
							entity.delete_entity(object_)
						end
					end
				end, nil)
				system.yield(200)
			end
		end
	end
	if not f.on then
		settings["» Extra Bombs For Planes"] = false
	end
end)
feature["» Extra Bombs For Planes"].on = settings["» Extra Bombs For Planes"]

feature["» Vehicle Fly"] = menu.add_feature("» Vehicle Fly", "value_str", localparents["» Vehicle Options"].id, function(f)
	if f.on then
		settings["» Vehicle Fly"] = true
		feature_value_settings["» Vehicle Fly"] = f.value
		while f.on do
			system.yield(0)
			if player.is_player_in_any_vehicle(player.player_id()) then
				network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
				entity.set_entity_velocity(player.get_player_vehicle(player.player_id()), v3(0, 0, 0))
				entity.set_entity_rotation(player.get_player_vehicle(player.player_id()), v3(cam.get_gameplay_cam_rot().x, 0, cam.get_gameplay_cam_rot().z))
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 77) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 1, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 77) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 1, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 133) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) + v3(0, 0, 90)
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) + v3(0, 0, 90)
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 1, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 134) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) - v3(0, 0, 90)
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) - v3(0, 0, 90)
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 1, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 139) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					local pos = player.get_player_coords(player.player_id())
					local dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) + v3(0, 0, 180)
					dir:transformRotToDir()
					dir = dir * 8
					pos = pos + dir
					dir = nil
					local pos_target = player.get_player_coords(player.player_id())
					dir = entity.get_entity_rotation(player.get_player_vehicle(player.player_id())) + v3(0, 0, 180)
					dir:transformRotToDir()
					dir = dir * 100
					pos_target = pos_target + dir
					local vectorV3 = pos_target - pos
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 1, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 254) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 1, 0, 0, 180, 0.0, 0.0, 0.0, false, true)
				end
				if player.is_player_in_any_vehicle(player.player_id()) and controls.is_disabled_control_pressed(2, 326) then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					entity.apply_force_to_entity(player.get_player_vehicle(player.player_id()), 1, 0, 0, -180, 0.0, 0.0, 0.0, false, true)
				end
			end
		end
	end
	if not f.on then
		settings["» Vehicle Fly"] = false
		feature_value_settings["» Vehicle Fly"] = f.value
		if f.value == 1 then
			if player.is_player_in_any_vehicle(player.player_id()) then
				network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
				local time = utils.time_ms() + 50
				while time > utils.time_ms() do
					system.yield(0)
					entity.set_entity_velocity(player.get_player_vehicle(player.player_id()), v3(0, 0, 0))
				end
			end
		end
	end
end)
feature["» Vehicle Fly"].on = settings["» Vehicle Fly"]
feature["» Vehicle Fly"]:set_str_data({"v1", "v2"})
feature["» Vehicle Fly"].value = feature_value_settings["» Vehicle Fly"]

feature["» Demolition Boost"] = menu.add_feature("» Demolition Boost", "toggle", localparents["» Vehicle Options"].id, function(f)
	if f.on then
		settings["» Demolition Boost"] = true
		if demolition_boost_notify == nil then
			menu.notify("[!] Hold X to boost!", Meteor, 4, 0x64FA7800)
			demolition_boost_notify = 1
		end
		while f.on do
			system.yield(0)
			if controls.is_disabled_control_pressed(2, 323) then
				previous_position_of_vehicle = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
				previous_rotation_of_vehicle = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
				while controls.is_disabled_control_pressed(2, 323) do
					system.yield(0)
					if player.is_player_in_any_vehicle(player.player_id()) then
						network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
						if streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
							vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), 576 / 3.6)
						else
							vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), 540 / 3.6)
						end
					end
				end
			else
				if previous_position_of_vehicle then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), previous_position_of_vehicle)
					previous_position_of_vehicle = nil
				end
				if previous_rotation_of_vehicle then
					network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
					entity.set_entity_rotation(player.get_player_vehicle(player.player_id()), previous_rotation_of_vehicle)
					previous_rotation_of_vehicle = nil
				end
			end
		end
	end
	if not f.on then
		settings["» Demolition Boost"] = false
		if previous_position_of_vehicle then
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), previous_position_of_vehicle)
			previous_position_of_vehicle = nil
		end
	end
end)
feature["» Demolition Boost"].on = settings["» Demolition Boost"]

menu.add_feature("» B-29 Enola Gay", "toggle", localparents["» Vehicle Options"].id, function(f)
	if f.on then
		if enola_gay_notify == nil then
			menu.notify("[!] Press X to drop the bomb!", Meteor, 6, 0x64FA7800)
			enola_gay_notify = 1
		end
		enola_gay_map_blip_bomb = ui.add_blip_for_coord(v3(-2152.2436523, 3261.8103027, 32.810264587))
		ui.set_blip_sprite(enola_gay_map_blip_bomb, 368)
		enola_gay_map_blip_repair = ui.add_blip_for_coord(v3(-2141.6809082031, 3279.7778320312, 32.810272216797))
		ui.set_blip_sprite(enola_gay_map_blip_repair, 402)
		ui.set_blip_colour(enola_gay_map_blip_bomb, 3)
		ui.set_blip_colour(enola_gay_map_blip_repair, 3)
		threads["» Enola Gay"] = menu.create_thread(function()
			while f.on do
				graphics.draw_marker(1, v3(-2152.2436523, 3261.8103027, 31.5), v3(0, 0, 0), v3(0, 0, 0), v3(10, 10, 8), 25, 100, 255, 30, false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
				graphics.draw_marker(1, v3(-2141.6809082031, 3279.4778320312, 31.5), v3(0, 0, 0), v3(0, 0, 0), v3(10, 10, 8), 25, 100, 255, 30, false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
				if utilities.get_distance_between(player.get_player_coords(player.player_id()), v3(-2141.6809082031, 3279.4778320312, 31.5)) < 5 and vehicle.is_vehicle_damaged(enola_gay) and ped.is_ped_in_vehicle(player.get_player_ped(player.player_id()), enola_gay) and not entity.is_entity_dead(enola_gay) then
					network.request_control_of_entity(enola_gay)
					vehicle.set_vehicle_undriveable(enola_gay, false)
					local entity_velocity = entity.get_entity_velocity(enola_gay)
					vehicle.set_vehicle_fixed(enola_gay)
					vehicle.set_vehicle_engine_health(enola_gay, 1000)
					vehicle.set_vehicle_engine_on(enola_gay, true, true, true)
					if entity.is_entity_on_fire(enola_gay) then
						fire.stop_entity_fire(enola_gay)
					end
					entity.set_entity_velocity(enola_gay, entity_velocity)
				end
				if utilities.get_distance_between(player.get_player_coords(player.player_id()), v3(-2152.2436523, 3261.8103027, 32.810264587)) < 5 and dropped_little_boy and little_boy_exploded and ped.is_ped_in_vehicle(player.get_player_ped(player.player_id()), enola_gay) and not entity.is_entity_dead(enola_gay) then
					dropped_little_boy = false
					little_boy_2_exploded_in_water = false
					little_boy_exploded = false
					streaming.request_model(3545667823)
					streaming.request_model(1951415382)
					while not streaming.has_model_loaded(3545667823) do
						streaming.request_model(3545667823)
						system.wait(0)
					end
					while not streaming.has_model_loaded(1951415382) do
						streaming.request_model(1951415382)
						system.wait(0)
					end
					little_boy = object.create_object(1951415382, player.get_player_coords(player.player_id()), true, true)
					network.request_control_of_entity(enola_gay)
					network.request_control_of_entity(little_boy)
					entity.set_entity_no_collsion_entity(enola_gay, little_boy, false)
					entity.attach_entity_to_entity(little_boy, enola_gay, 0, v3(0, 0, -0.49), v3(0, 180, 90), false, false, false, 0, true)
				end
				system.yield(0)
			end
		end, nil)
		dropped_little_boy = false
		little_boy_2_exploded_in_water = false
		little_boy_exploded = false
		streaming.request_model(3545667823)
		streaming.request_model(1951415382)
		while not streaming.has_model_loaded(3545667823) do
			streaming.request_model(3545667823)
			system.wait(0)
		end
		while not streaming.has_model_loaded(1951415382) do
			streaming.request_model(1951415382)
			system.wait(0)
		end
		enola_gay = vehicle.create_vehicle(3545667823, player.get_player_coords(player.player_id()) + v3(0, 0, 50), player.get_player_heading(player.player_id()), true, false)
		little_boy = object.create_object(1951415382, player.get_player_coords(player.player_id()), true, true)
		network.request_control_of_entity(enola_gay)
		network.request_control_of_entity(little_boy)
		entity.set_entity_no_collsion_entity(enola_gay, little_boy, false)
		entity.attach_entity_to_entity(little_boy, enola_gay, 0, v3(0, 0, -0.49), v3(0, 180, 90), false, false, false, 0, true)
		vehicle.set_vehicle_colors(enola_gay, 9, 4)
		ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), enola_gay, -1)
		vehicle.set_vehicle_engine_on(enola_gay, true, true, false)
    	vehicle.control_landing_gear(enola_gay, 3)
    	vehicle.set_vehicle_forward_speed(enola_gay, 60)
		menu.create_thread(function()
			system.wait(2000)
			if enola_gay and not ped.is_ped_in_vehicle(player.get_player_ped(player.player_id()), enola_gay) then
				menu.notify("[!] Getting kicked out? Enable 'Despawn Bypass' and 'Bypass MP Vehicle Kick' in Spawn > Vehicles > Options", Meteor, 10, 0x64FA7800)
			end
		end, nil)
		while f.on do
			system.yield(0)
			local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
			if controls.is_disabled_control_just_pressed(2, 323) and ped.is_ped_in_vehicle(player.get_player_ped(player.player_id()), enola_gay) and not entity.is_entity_dead(enola_gay) and not dropped_little_boy and entity.get_entity_rotation(enola_gay).x < 30 and entity.get_entity_rotation(enola_gay).x > -70 and entity.get_entity_rotation(enola_gay).y < 30 and entity.get_entity_rotation(enola_gay).y > -30 and (not success or (success and utilities.get_distance_between(player.get_player_coords(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float)) > 20)) then
				dropped_little_boy = true
				entity.detach_entity(little_boy)
				little_boy_rotation = entity.get_entity_rotation(little_boy)
				little_boy_2 = object.create_object(1951415382, entity.get_entity_coords(little_boy), true, true)
				network.request_control_of_entity(little_boy_2)
				entity.set_entity_no_collsion_entity(enola_gay, little_boy_2, false)
				entity.set_entity_rotation(little_boy_2, entity.get_entity_rotation(little_boy))
				network.request_control_of_entity(little_boy)
				entity.delete_entity(little_boy)
				local pos = entity.get_entity_coords(enola_gay)
				local dir = entity.get_entity_rotation(enola_gay)
				dir:transformRotToDir()
				dir = dir * 8
				pos = pos + dir
				dir = nil
				local pos_target = entity.get_entity_coords(enola_gay)
				dir = entity.get_entity_rotation(enola_gay)
				dir:transformRotToDir()
				dir = dir * 100
				pos_target = pos_target + dir
				local vectorV3 = pos_target - pos
				entity.apply_force_to_entity(little_boy_2, 1, vectorV3.x, vectorV3.y, vectorV3.z - 80, 0.0, 0.0, 0.0, false, true)
			end
			if not little_boy_exploded and not dropped_little_boy and not entity.is_entity_in_water(enola_gay) and (entity.is_entity_on_fire(little_boy) or entity.is_entity_on_fire(enola_gay)) then
				little_boy_exploded = true
				entity.detach_entity(little_boy)
				local pos = entity.get_entity_coords(little_boy)
				fire.add_explosion(pos, 8, true, false, 1, player.get_player_ped(player.player_id()))
			end
			if dropped_little_boy and not entity.is_entity_in_water(little_boy_2) and entity.has_entity_collided_with_anything(little_boy_2) then
				little_boy_exploded = true
				local pos = entity.get_entity_coords(little_boy_2)
				local peds = ped.get_all_peds()
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos, 59, true, false, 5, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos, 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 180, 0), 4.5, true, true, true)

				fire.add_explosion(pos + v3(10, 0, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, 10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(10, 10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, 0, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, -10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, -10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(10, -10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, 10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(20, 0, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, 20, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(20, 20, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-20, 0, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, -20, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-20, -20, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(20, -20, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-20, 20, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(30, 0, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, 30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(30, 30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-30, 0, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, -30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-30, -30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(30, -30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-30, 30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(10, 30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(30, 10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-30, -10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, -30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, 30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-30, 10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(30, -10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(10, -30, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))

				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if utilities.get_distance_between(player.get_player_coords(pid), player.get_player_coords(player.player_id())) < 50 then
							fire.add_explosion(player.get_player_coords(pid), 59, true, false, 1, player.get_player_ped(player.player_id()))
						end
					end
				end

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos - v3(0, 0, 10), v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos - v3(0, 0, 10), v3(0, 180, 0), 4.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end

				fire.add_explosion(pos + v3(0, 0, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(10, 0, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, 10, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(10, 10, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, 0, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, -10, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, -10, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(10, -10, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, 10, -10), 59, true, false, 1, player.get_player_ped(player.player_id()))

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 1), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 3), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 5), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 5), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 7), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 10), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 10), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 12), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 15), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 15), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 17), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 20), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 20), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 22), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 25), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 25), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 27), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 30), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 30), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 32), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 35), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 35), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 37), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 40), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 40), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 42), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 45), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 45), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 47), v3(0, 180, 0), 1.5, true, true, true)
				
				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 50), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 50), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 52), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 55), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 55), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 57), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 57), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 59), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 61), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 63), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 57), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 65), v3(0, 180, 0), 1.5, true, true, true)

				system.wait(10)

				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				fire.add_explosion(pos + v3(0, 0, 75), 59, true, false, 1, player.get_player_ped(player.player_id()))
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 75), v3(0, 0, 0), 3.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 75), v3(0, 0, 0), 3.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 75), v3(0, 0, 0), 3.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 75), v3(0, 0, 0), 3.5, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 80), v3(0, 0, 0), 3, true, true, true)
				graphics.set_next_ptfx_asset("scr_xm_orbital")
				while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
					graphics.request_named_ptfx_asset("scr_xm_orbital")
					system.wait(0)
				end
				graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos + v3(0, 0, 80), v3(0, 0, 0), 3, true, true, true)

				fire.add_explosion(pos + v3(10, 0, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, 10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(10, 10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, 0, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(0, -10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, -10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(10, -10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos + v3(-10, 10, 0), 59, true, false, 1, player.get_player_ped(player.player_id()))
				fire.add_explosion(pos, 59, true, false, 1, player.get_player_ped(player.player_id()))

				network.request_control_of_entity(little_boy_2)
				entity.delete_entity(little_boy_2)
				for i = 1, #peds do
					if utilities.get_distance_between(peds[i], pos) < 400 and player.get_player_from_ped(peds[i]) ~= player.player_id() then
						network.request_control_of_entity(peds[i])
						ped.set_ped_to_ragdoll(peds[i], 1000, 1000, 0)
						entity.set_entity_velocity(peds[i], (entity.get_entity_coords(peds[i]) - pos) * (30 / utilities.get_distance_between(peds[i], pos)))
						if not ped.is_ped_a_player(peds[i]) then
							ped.set_ped_health(peds[i], 0)
						end
					end
				end
				local vehicles = vehicle.get_all_vehicles()
				for i = 1, #vehicles do
					if utilities.get_distance_between(vehicles[i], pos) < 800 and vehicles[i] ~= enola_gay then
						network.request_control_of_entity(vehicles[i])
						vehicle.set_vehicle_engine_health(vehicles[i], -1)
						local wheels = vehicle.get_vehicle_wheel_count(vehicles[i])
						if wheels ~= nil then
							for count = 0, wheels + 1 do
								network.request_control_of_entity(vehicles[i])
								vehicle.set_vehicle_tire_burst(vehicles[i], count, true, 1000)
							end
						end
						entity.set_entity_velocity(vehicles[i], (entity.get_entity_coords(vehicles[i]) - pos) * (30 / utilities.get_distance_between(vehicles[i], pos)))
					end
				end
			end
			if dropped_little_boy and entity.is_entity_in_water(little_boy_2) and not little_boy_2_exploded_in_water then
				little_boy_2_exploded_in_water = true
				fire.add_explosion(entity.get_entity_coords(little_boy_2), 52, true, false, 0.3, player.get_player_ped(player.player_id()))
			end
			if dropped_little_boy and not entity.is_entity_in_water(little_boy_2) then
				entity.set_entity_rotation(little_boy_2, little_boy_rotation)
			end
		end
	end
	if not f.on then
		dropped_little_boy = false
		little_boy_2_exploded_in_water = false
		little_boy_exploded = false
		little_boy_rotation = nil
		if enola_gay then
			utilities.hard_remove_entity(enola_gay)
			enola_gay = nil
		end
		if little_boy then
			utilities.hard_remove_entity(little_boy)
			little_boy = nil
		end
		if little_boy_2 then
			utilities.hard_remove_entity(little_boy_2)
			little_boy_2 = nil
		end
		streaming.set_model_as_no_longer_needed(3545667823)
		streaming.set_model_as_no_longer_needed(1951415382)
		ui.remove_blip(enola_gay_map_blip_bomb)
		ui.remove_blip(enola_gay_map_blip_repair)
		if threads["» Enola Gay"] then
			menu.delete_thread(threads["» Enola Gay"])
		end
	end
end)

menu.add_feature("» Hard Remove Vehicle", "action", localparents["» Vehicle Options"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		local entity_ = player.get_player_vehicle(player.player_id())
		network.request_control_of_entity(entity_)
		entity.set_entity_collision(entity_, true, true, true)
		entity.set_entity_as_no_longer_needed(entity_)
		entity.set_entity_as_mission_entity(entity_, false, true)
		utilities.hard_remove_entity(entity_)
	else
		menu.notify("[!] You are not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_feature("» Enter Nearest Vehicle", "action", localparents["» Vehicle Options"].id, function(f)
	local vehicles = vehicle.get_all_vehicles()
	table.sort(vehicles, function(a, b)
		return (utilities.get_distance_between(a, player.get_player_coords(player.player_id())) < utilities.get_distance_between(b, player.get_player_coords(player.player_id())))
	end)
	if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(vehicles[1], -1)) then
		ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), vehicles[1], -2)
	else
		network.request_control_of_entity(vehicle.get_ped_in_vehicle_seat(vehicles[1], -1))
		network.request_control_of_entity(vehicles[1])
		ped.set_ped_into_vehicle(vehicle.get_ped_in_vehicle_seat(vehicles[1], -1), vehicles[1], -2)
		ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), vehicles[1], -1)
    end
end)

menu.add_feature("» Force Leave Vehicle", "action", localparents["» Vehicle Options"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		ped.clear_ped_tasks_immediately(player.get_player_ped(player.player_id()))
	end
end)

localparents["» Aviation Tools"] = menu.add_feature("» Aviation Tools", "parent", localparents["» Vehicle Options"].id)

feature["» Low Pitch Warning"] = menu.add_feature("» Low Pitch Warning", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Low Pitch Warning"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
				if entity.get_entity_pitch(player.get_player_vehicle(player.player_id())) <= -45 and vehicle.get_landing_gear_state(player.get_player_vehicle(player.player_id())) == 4 then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 55, 55, 255)
						ui.draw_text("Sinkrate - Pull Up", v2(0.057, 0.77), 1)
					end
				end
			end
			system.wait(800)
		end
	end
	if not f.on then
		settings["» Low Pitch Warning"] = false
	end
end)
feature["» Low Pitch Warning"].on = settings["» Low Pitch Warning"]

feature["» High Bank Angle Warning"] = menu.add_feature("» High Bank Angle Warning", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» High Bank Angle Warning"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
				if entity.get_entity_roll(player.get_player_vehicle(player.player_id())) <= -50 or entity.get_entity_roll(player.get_player_vehicle(player.player_id())) >= 50 and not utilities.is_model_a_fighter_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 55, 55, 255)
						ui.draw_text("High Bank Angle", v2(0.135, 0.77), 1)
					end
				end
			end
			system.wait(800)
		end
	end
	if not f.on then
		settings["» High Bank Angle Warning"] = false
	end
end)
feature["» High Bank Angle Warning"].on = settings["» High Bank Angle Warning"]

feature["» Engine Warning"] = menu.add_feature("» Engine Warning", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Engine Warning"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
				local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
				if (entity.get_entity_speed(player.get_player_vehicle(player.player_id())) * 3.6) > 50 and vehicle.get_landing_gear_state(player.get_player_vehicle(player.player_id())) == 4 and not vehicle.is_vehicle_engine_running(player.get_player_vehicle(player.player_id())) then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 55, 55, 255)
						ui.draw_text("Engine Warning", v2(0.057, 0.745), 1)
					end
				end
			end
			system.wait(800)
		end
	end
	if not f.on then
		settings["» Engine Warning"] = false
	end
end)
feature["» Engine Warning"].on = settings["» Engine Warning"]

feature["» Fire Warning"] = menu.add_feature("» Fire Warning", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Fire Warning"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
				if entity.is_entity_on_fire(player.get_player_vehicle(player.player_id())) then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 55, 55, 255)
						ui.draw_text("Fire Warning", v2(0.135, 0.745), 1)
					end
					audio.play_sound_from_coord(-1, "Out_Of_Bounds_Timer", player.get_player_coords(player.player_id()), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false, 0, true)
					system.wait(400)
					audio.play_sound_from_coord(-1, "Out_Of_Bounds_Timer", player.get_player_coords(player.player_id()), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false, 0, true)
				end
			end
			system.wait(400)
		end
	end
	if not f.on then
		settings["» Fire Warning"] = false
	end
end)
feature["» Fire Warning"].on = settings["» Fire Warning"]

feature["» Stall Warning"] = menu.add_feature("» Stall Warning", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Stall Warning"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
				if utilities.round(entity.get_entity_speed(player.get_player_vehicle(player.player_id()))) ~= 0 and (entity.get_entity_speed(player.get_player_vehicle(player.player_id())) * 3.6) <= 130 and vehicle.get_landing_gear_state(player.get_player_vehicle(player.player_id())) == 4 and not utilities.is_model_a_slow_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 55, 55, 255)
						ui.draw_text("Stall", v2(0.057, 0.720), 1)
					end
					audio.play_sound_from_coord(-1, "Out_Of_Bounds_Timer", player.get_player_coords(player.player_id()), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false, 0, true)
					system.wait(400)
					audio.play_sound_from_coord(-1, "Out_Of_Bounds_Timer", player.get_player_coords(player.player_id()), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false, 0, true)
				end
			end
			system.wait(400)
		end
	end
	if not f.on then
		settings["» Stall Warning"] = false
	end
end)
feature["» Stall Warning"].on = settings["» Stall Warning"]

feature["» Terrain Warning"] = menu.add_feature("» Terrain Warning", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Terrain Warning"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
				local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
				if (entity.get_entity_speed(player.get_player_vehicle(player.player_id())) * 3.6) ~= 0 and vehicle.get_landing_gear_state(player.get_player_vehicle(player.player_id())) == 4 and success and utilities.get_distance_between(player.get_player_coords(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float)) < 50 and not utilities.is_model_a_fighter_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 55, 55, 255)
						ui.draw_text("GPWS - Terrain", v2(0.135, 0.720), 1)
					end
					audio.play_sound_from_coord(-1, "Out_Of_Bounds_Timer", player.get_player_coords(player.player_id()), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false, 0, true)
					system.wait(400)
					audio.play_sound_from_coord(-1, "Out_Of_Bounds_Timer", player.get_player_coords(player.player_id()), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false, 0, true)
				end
			end
			system.wait(400)
		end
	end
	if not f.on then
		settings["» Terrain Warning"] = false
	end
end)
feature["» Terrain Warning"].on = settings["» Terrain Warning"]

feature["» Collision Notify"] = menu.add_feature("» Collision Notify", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Collision Notify"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
				if entity.has_entity_collided_with_anything(player.get_player_vehicle(player.player_id())) and not vehicle.is_vehicle_on_all_wheels(player.get_player_vehicle(player.player_id())) then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 55, 55, 255)
						ui.draw_text("Airplane Collision", v2(0.057, 0.695), 1)
					end
				end
			end
			system.wait(800)
		end
	end
	if not f.on then
		settings["» Collision Notify"] = false
	end
end)
feature["» Collision Notify"].on = settings["» Collision Notify"]

feature["» Runway Tracker"] = menu.add_feature("» Runway Tracker", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Runway Tracker"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
				local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
				if entity.is_entity_in_zone(player.get_player_vehicle(player.player_id()), "AIRP") and entity.get_entity_heading(player.get_player_vehicle(player.player_id())) >= 50 and entity.get_entity_heading(player.get_player_vehicle(player.player_id())) <= 65 and vehicle.get_landing_gear_state(player.get_player_vehicle(player.player_id())) == 0 then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 155, 25, 255)
						ui.draw_text("\nRUNWAY 33L/R", v2(0.265, 0.913), 1)
					end
				end
				if entity.is_entity_in_zone(player.get_player_vehicle(player.player_id()), "AIRP") and entity.get_entity_heading(player.get_player_vehicle(player.player_id())) >= -130 and entity.get_entity_heading(player.get_player_vehicle(player.player_id())) <= -110 and vehicle.get_landing_gear_state(player.get_player_vehicle(player.player_id())) == 0 then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 155, 25, 255)
						ui.draw_text("RUNWAY 12L/R", v2(0.265, 0.913), 1)
					end
				end
				if entity.is_entity_in_zone(player.get_player_vehicle(player.player_id()), "AIRP") and entity.get_entity_heading(player.get_player_vehicle(player.player_id())) >= 140 and entity.get_entity_heading(player.get_player_vehicle(player.player_id())) <= 160 and vehicle.get_landing_gear_state(player.get_player_vehicle(player.player_id())) == 0 then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 155, 25, 255)
						ui.draw_text("\nRUNWAY 21", v2(0.265, 0.863), 1)
					end
				end
				if entity.is_entity_in_zone(player.get_player_vehicle(player.player_id()), "AIRP") and entity.get_entity_heading(player.get_player_vehicle(player.player_id())) >= -40 and entity.get_entity_heading(player.get_player_vehicle(player.player_id())) <= -20 and vehicle.get_landing_gear_state(player.get_player_vehicle(player.player_id())) == 0 then
					local time = utils.time_ms() + 800
					while time > utils.time_ms() do
						system.yield(0)
						ui.set_text_scale(0.4)
						ui.set_text_font(4)
						ui.set_text_centre(0)
						ui.set_text_outline(true)
						ui.set_text_color(255, 155, 25, 255)
						ui.draw_text("RUNWAY 3", v2(0.265, 0.863), 1)
					end
				end
			end
			system.wait(800)
		end
	end
	if not f.on then
		settings["» Runway Tracker"] = false
	end
end)
feature["» Runway Tracker"].on = settings["» Runway Tracker"]

feature["» Information Display"] = menu.add_feature("» Information Display", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Information Display"] = true
		while f.on do
			system.yield(0)
			if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
				ui.set_text_scale(0.4)
				ui.set_text_font(4)
				ui.set_text_centre(0)
				ui.set_text_outline(true)
				ui.set_text_color(255, 255, 255, 255)
				ui.draw_text("Speed:\n" .. utilities.round_one_dc(entity.get_entity_speed(player.get_player_vehicle(player.player_id())) * 3.6) .. "km/h", v2(0.185, 0.813), 1)
				ui.set_text_scale(0.4)
				ui.set_text_font(4)
				ui.set_text_centre(0)
				ui.set_text_outline(true)
				ui.set_text_color(255, 255, 255, 255)
				ui.draw_text("Altitude:\n" .. utilities.round_one_dc(player.get_player_coords(player.player_id()).z) .. "m", v2(0.185, 0.863), 1)
				ui.set_text_scale(0.4)
				ui.set_text_font(4)
				ui.set_text_centre(0)
				ui.set_text_outline(true)
				ui.set_text_color(255, 255, 255, 255)
				ui.draw_text("Heading:\n" .. utilities.round_one_dc(entity.get_entity_heading(player.get_player_vehicle(player.player_id()))) .. "°", v2(0.185, 0.913), 1)
				ui.set_text_scale(0.4)
				ui.set_text_font(4)
				ui.set_text_centre(0)
				ui.set_text_outline(true)
				ui.set_text_color(255, 255, 255, 255)
				ui.draw_text("V/S:\n" .. utilities.round(entity.get_entity_pitch(player.get_player_vehicle(player.player_id())) * 100) .. "", v2(0.22, 0.863), 1)
				ui.set_text_scale(0.4)
				ui.set_text_font(4)
				ui.set_text_centre(0)
				ui.set_text_outline(true)
				ui.set_text_color(255, 255, 255, 255)
				ui.draw_text("Bank:\n" .. utilities.round(entity.get_entity_roll(player.get_player_vehicle(player.player_id()))) .. "°", v2(0.22, 0.913), 1)
				ui.set_text_scale(0.4)
				ui.set_text_font(4)
				ui.set_text_centre(0)
				ui.set_text_outline(true)
				ui.set_text_color(255, 255, 255, 255)
				if settings["» Activate Autopilot"] then
					ui.draw_text("Auto Pilot:\n~g~on", v2(0.22, 0.813), 1)
				else
					ui.draw_text("Auto Pilot:\n~r~off", v2(0.22, 0.813), 1)
				end
			end
		end
	end
	if not f.on then
		settings["» Information Display"] = false
	end
end)
feature["» Information Display"].on = settings["» Information Display"]

feature["» Air Traffic"] = menu.add_feature("» Air Traffic", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Air Traffic"] = true
		while f.on do
			system.yield(0)
			if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
				local vehicles = vehicle.get_all_vehicles()
				for i = 1, #vehicles do
					if (streaming.is_model_a_plane(entity.get_entity_model_hash(vehicles[i])) or streaming.is_model_a_heli(entity.get_entity_model_hash(vehicles[i]))) and utilities.get_distance_between(entity.get_entity_coords(player.get_player_vehicle(player.player_id())), entity.get_entity_coords(vehicles[i])) < 2000 and not entity.is_entity_dead(vehicles[i]) then
						if entity.get_entity_model_hash(vehicles[i]) == 3319621991 or entity.get_entity_model_hash(vehicles[i]) == 1565978651 or entity.get_entity_model_hash(vehicles[i]) == 1692272545 or entity.get_entity_model_hash(vehicles[i]) == 2176659152 or entity.get_entity_model_hash(vehicles[i]) == 3013282534 or entity.get_entity_model_hash(vehicles[i]) == 1036591958 or entity.get_entity_model_hash(vehicles[i]) == 2908775872 or entity.get_entity_model_hash(vehicles[i]) == 408970549 or entity.get_entity_model_hash(vehicles[i]) == 970385471 or entity.get_entity_model_hash(vehicles[i]) == 2594093022 or entity.get_entity_model_hash(vehicles[i]) == 3545667823 or entity.get_entity_model_hash(vehicles[i]) == 4212341271 or entity.get_entity_model_hash(vehicles[i]) == 1593933419 or entity.get_entity_model_hash(vehicles[i]) == 788747387 or entity.get_entity_model_hash(vehicles[i]) == 1229411063 or entity.get_entity_model_hash(vehicles[i]) == 295054921 or entity.get_entity_model_hash(vehicles[i]) == 1543134283 or entity.get_entity_model_hash(vehicles[i]) == 1181327175 or entity.get_entity_model_hash(vehicles[i]) == 4252008158 or entity.get_entity_model_hash(vehicles[i]) == 2694714877 then
							ui.draw_line(entity.get_entity_coords(player.get_player_vehicle(player.player_id())), entity.get_entity_coords(vehicles[i]), 255, 25, 25, 200)
						elseif entity.get_entity_model_hash(vehicles[i]) == 3902291871 or entity.get_entity_model_hash(vehicles[i]) == 1043222410 or entity.get_entity_model_hash(vehicles[i]) == 4262088844 or entity.get_entity_model_hash(vehicles[i]) == 3929093893 or entity.get_entity_model_hash(vehicles[i]) == 447548909 or entity.get_entity_model_hash(vehicles[i]) == 3650256867 or entity.get_entity_model_hash(vehicles[i]) == 3568198617 then
							ui.draw_line(entity.get_entity_coords(player.get_player_vehicle(player.player_id())), entity.get_entity_coords(vehicles[i]), 255, 200, 25, 200)
						else
							ui.draw_line(entity.get_entity_coords(player.get_player_vehicle(player.player_id())), entity.get_entity_coords(vehicles[i]), 25, 255, 25, 200)
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Air Traffic"] = false
	end
end)
feature["» Air Traffic"].on = settings["» Air Traffic"]

menu.add_feature("» Activate Autopilot", "toggle", localparents["» Aviation Tools"].id, function(f)
	if f.on then
		settings["» Activate Autopilot"] = true
		if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
			auto_pilot_speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
			auto_pilot_rotation = entity.get_entity_rotation(player.get_player_vehicle(player.player_id()))
			while f.on do
				system.yield(0)
				if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) and not entity.is_entity_dead(player.get_player_vehicle(player.player_id())) then
					vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), auto_pilot_speed)
					entity.set_entity_rotation(player.get_player_vehicle(player.player_id()), auto_pilot_rotation)
				else
					f.on = false
				end
			end
		else
			f.on = false
		end
	end
	if not f.on then
		settings["» Activate Autopilot"] = false
		auto_pilot_speed = nil
		auto_pilot_rotation = nil
	end
end)

localparents["» Simulate Failures"] = menu.add_feature("» Simulate Failures", "parent", localparents["» Aviation Tools"].id)

menu.add_feature("» Repair Vehicle", "action", localparents["» Simulate Failures"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		vehicle.set_vehicle_undriveable(player.get_player_vehicle(player.player_id()), false)
		local entity_velocity = entity.get_entity_velocity(player.get_player_vehicle(player.player_id()))
		vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()))
		vehicle.set_vehicle_engine_health(player.get_player_vehicle(player.player_id()), 1000)
		vehicle.set_vehicle_engine_on(player.get_player_vehicle(player.player_id()), true, true, true)
		if entity.is_entity_on_fire(player.get_player_vehicle(player.player_id())) then
			fire.stop_entity_fire(player.get_player_vehicle(player.player_id()))
		end
		entity.set_entity_velocity(player.get_player_vehicle(player.player_id()), entity_velocity)
	end
end)

menu.add_feature("» Engine Failure", "action", localparents["» Simulate Failures"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		vehicle.set_vehicle_engine_on(player.get_player_vehicle(player.player_id()), false, false, false)
	end
end)

menu.add_feature("» Engine Fire", "action", localparents["» Simulate Failures"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		vehicle.set_vehicle_engine_health(player.get_player_vehicle(player.player_id()), -1)
	end
end)

menu.add_feature("» Low Airspeed (Stall)", "action", localparents["» Simulate Failures"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), 100 / 3.6)
		vehicle.set_vehicle_engine_on(player.get_player_vehicle(player.player_id()), false, true, false)
		system.wait(6000)
		vehicle.set_vehicle_engine_on(player.get_player_vehicle(player.player_id()), true, true, false)
	end
end)

menu.add_feature("» Burst Tires", "action", localparents["» Simulate Failures"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		for i = 0, 5 do
			vehicle.set_vehicle_tire_burst(player.get_player_vehicle(player.player_id()), i, true, 1000)
		end
	end
end)

menu.add_feature("» Lock Landing Gear", "toggle", localparents["» Simulate Failures"].id, function(f)
	if f.on then
		local gear_state = vehicle.get_landing_gear_state(player.get_player_vehicle(player.player_id()))
		while f.on do
			system.yield(0)
			if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
				network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
				if gear_state == 0 then
					vehicle.control_landing_gear(player.get_player_vehicle(player.player_id()), 0)
				elseif gear_state == 1 then
					vehicle.control_landing_gear(player.get_player_vehicle(player.player_id()), 1)
				elseif gear_state == 2 then
					vehicle.control_landing_gear(player.get_player_vehicle(player.player_id()), 2)
				elseif gear_state == 3 then
					vehicle.control_landing_gear(player.get_player_vehicle(player.player_id()), 3)
				elseif gear_state == 4 then
					vehicle.control_landing_gear(player.get_player_vehicle(player.player_id()), 3)
				else
					vehicle.control_landing_gear(player.get_player_vehicle(player.player_id()), 3)
				end
			end
		end
	end
end)

menu.add_feature("» Random Engine Dropouts", "toggle", localparents["» Simulate Failures"].id, function(f)
	if f.on then
		while f.on do
			system.yield(0)
			if player.is_player_in_any_vehicle(player.player_id()) and streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))) then
				network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
				system.wait(math.random(2000, 7000))
				vehicle.set_vehicle_engine_on(player.get_player_vehicle(player.player_id()), false, true, false)
				system.wait(math.random(9000, 13000))
				vehicle.set_vehicle_engine_on(player.get_player_vehicle(player.player_id()), true, true, true)
				system.wait(math.random(9000, 20000))
			end
		end
	end
end)

--

menu.add_feature("» Bigfoot 1", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(0x61D4C771)

    local ped_ = ped.create_ped(5, 0x61D4C771, utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(0x61D4C771)
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Bigfoot 2", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(0xAD340F5A)

    local ped_ = ped.create_ped(5, 0xAD340F5A, utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(0xAD340F5A)
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Boar", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_boar"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_boar"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_boar"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Cat", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_cat_01"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_cat_01"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_cat_01"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Chickenhawk", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_chickenhawk"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_chickenhawk"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_chickenhawk"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Chimp", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_chimp"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_chimp"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_chimp"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Chop", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_chop"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_chop"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_chop"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Cormant", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_cormorant"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_cormorant"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_cormorant"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Cow", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_cow"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_cow"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_cow"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Coyote", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_coyote"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_coyote"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_coyote"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Crow", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_crow"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_crow"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_crow"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Deer", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_deer"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_deer"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_deer"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Dolphin", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_dolphin"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_dolphin"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_dolphin"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Fish", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_fish"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_fish"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_fish"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Hen", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_hen"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_hen"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_hen"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Humpback", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_humpback"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_humpback"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_humpback"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Husky", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_husky"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_husky"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_husky"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Killerwhale", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_killerwhale"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_killerwhale"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_killerwhale"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Mtlion", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_mtlion"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_mtlion"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_mtlion"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Phanter", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_panther"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_panther"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_panther"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Pig", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_pig"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_pig"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_pig"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Pigeon", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_pigeon"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_pigeon"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_pigeon"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Poodle", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_poodle"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_poodle"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_poodle"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Pug", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_pug"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_pug"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_pug"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Rabbit", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_rabbit_01"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_rabbit_01"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_rabbit_01"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Rat", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_rat"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_rat"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_rat"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Retriever", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_retriever"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_retriever"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_retriever"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Rhesus", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_rhesus"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_rhesus"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_rhesus"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Rottweiler", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_rottweiler"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_rottweiler"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_rottweiler"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Seagull", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_seagull"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_seagull"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_seagull"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Sharkhammer", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_sharkhammer"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_sharkhammer"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_sharkhammer"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Sharktiger", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_sharktiger"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_sharktiger"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_sharktiger"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Shepherd", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_shepherd"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_shepherd"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_shepherd"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Stingray", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_stingray"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_stingray"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_stingray"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

menu.add_feature("» Westy", "action_value_str", localparents["» Spawn Animals"].id, function(f, pid)
    utilities.request_model(gameplay.get_hash_key("a_c_westy"))

    local ped_ = ped.create_ped(5, gameplay.get_hash_key("a_c_westy"), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5), 0, true, false)
    streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("a_c_westy"))
    utilities.add_blip_for_entity(ped_, 442)
	if f.value == 1 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(player.player_id()), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Normal",
	"Hostile",
	"Aggressive"
})

--

feature["» Invalid SCID Detection"] = menu.add_feature("» Invalid SCID", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Invalid SCID Detection"] = true
		feature_value_settings["» Invalid SCID Detection"] = f.value
		while f.on do
			system.yield(4000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.get_player_scid(pid) < 10000 or player.get_player_scid(pid) > 250000000 then
						if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
						else
							if feature["» Invalid SCID Detection"].value == 0 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid SCID"]) then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid SCID", "Modder Detection", 6, 0x00A2FF)
									player.set_player_as_modder(pid, custommodderflags["Invalid SCID"])
								end
							elseif feature["» Invalid SCID Detection"].value == 1 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not InvalidSCIDDetectionPlayer[pid] then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid SCID", "Modder Detection", 6, 0x00A2FF)
									InvalidSCIDDetectionPlayer[pid] = true
								end
							elseif feature["» Invalid SCID Detection"].value == 2 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid SCID"]) then
									player.set_player_as_modder(pid, custommodderflags["Invalid SCID"])
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Invalid SCID Detection"] = false
		feature_value_settings["» Invalid SCID Detection"] = f.value
	end
end)
feature["» Invalid SCID Detection"].on = settings["» Invalid SCID Detection"]
feature["» Invalid SCID Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Invalid SCID Detection"].value = feature_value_settings["» Invalid SCID Detection"]

feature["» Modded Health Detection"] = menu.add_feature("» Modded Health", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Modded Health Detection"] = true
		feature_value_settings["» Modded Health Detection"] = f.value
		while f.on do
			system.yield(4000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if not player.get_player_health(pid) == 2600 or not player.get_player_health(pid) == 2600 then
						if player.get_player_health(pid) < 0 or player.get_player_health(pid) > 328 or player.get_player_max_health(pid) < 0 or player.get_player_max_health(pid) > 328 or player.get_player_max_health(pid) < player.get_player_health(pid) or player.get_player_health(pid) > player.get_player_max_health(pid) then
							if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
							else
								if f.value == 0 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Modded Health"]) then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Modded Health", "Modder Detection", 6, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Modded Health"])
									end
								elseif f.value == 1 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not ModdedHealthDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Modded Health", "Modder Detection", 6, 0x00A2FF)
									end
								elseif f.value == 2 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Modded Health"]) then
										player.set_player_as_modder(pid, custommodderflags["Modded Health"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Modded Health Detection"] = false
		feature_value_settings["» Modded Health Detection"] = f.value
	end
end)
feature["» Modded Health Detection"].on = settings["» Modded Health Detection"]
feature["» Modded Health Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Modded Health Detection"].value = feature_value_settings["» Modded Health Detection"]

feature["» Godmode Detection"] = menu.add_feature("» Godmode", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Godmode Detection"] = true
		feature_value_settings["» Godmode Detection"] = f.value
		while f.on do
			system.yield(500)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_god(pid) and not utilities.is_player_in_interior(pid) then
						if ai.is_task_active(player.get_player_ped(pid), 9) then
							if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
							else
								if f.value == 0 then
									if pid ~= player.player_id() and not player.is_player_modder(pid, custommodderflags["Godmode"]) then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Godmode", "Modder Detection", 6, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Godmode"])
									end
								elseif f.value == 1 then
									if pid ~= player.player_id() and not GodmodeDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Godmode", "Modder Detection", 6, 0x00A2FF)
									end
								elseif f.value == 2 then
									if pid ~= player.player_id() and not player.is_player_modder(pid, custommodderflags["Godmode"]) then
										player.set_player_as_modder(pid, custommodderflags["Godmode"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Godmode Detection"] = false
		feature_value_settings["» Godmode Detection"] = f.value
	end
end)
feature["» Godmode Detection"].on = settings["» Godmode Detection"]
feature["» Godmode Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Godmode Detection"].value = feature_value_settings["» Godmode Detection"]

feature["» Invalid Name Detection"] = menu.add_feature("» Invalid Name", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Invalid Name Detection"] = true
		feature_value_settings["» Invalid Name Detection"] = f.value
		while f.on do
			system.yield(4000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if string.len(player.get_player_name(pid)) < 6 or string.len(player.get_player_name(pid)) > 16 or not string.find(player.get_player_name(pid), "^[%.%-%w_]+$") then
							if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
							else
								if f.value == 0 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid Name"]) then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid Name", "Modder Detection", 6, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Invalid Name"])
									end
								elseif f.value == 1 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not InvalidNameDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid Name", "Modder Detection", 6, 0x00A2FF)
										InvalidNameDetectionPlayer[pid] = true
									end
								elseif f.value == 2 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid Name"]) then
										player.set_player_as_modder(pid, custommodderflags["Invalid Name"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Invalid Name Detection"] = false
		feature_value_settings["» Invalid Name Detection"] = f.value
	end
end)
feature["» Invalid Name Detection"].on = settings["» Invalid Name Detection"]
feature["» Invalid Name Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Invalid Name Detection"].value = feature_value_settings["» Invalid Name Detection"]

feature["» Invalid IP Detection"] = menu.add_feature("» Invalid IP", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Invalid IP Detection"] = true
		feature_value_settings["» Invalid IP Detection"] = f.value
		while f.on do
			system.yield(4000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if player.get_player_ip(pid) <= 0 or player.get_player_ip(pid) > 4294967295 or player.get_player_ip(pid) == 2130706433 then
							if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
							else
								if f.value == 0 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid IP"]) then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid IP", "Modder Detection", 6, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Invalid IP"])
									end
								elseif f.value == 1 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not InvalidIPDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid IP", "Modder Detection", 6, 0x00A2FF)
									end
								elseif f.value == 2 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid IP"]) then
										player.set_player_as_modder(pid, custommodderflags["Invalid IP"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Invalid IP Detection"] = false
		feature_value_settings["» Invalid IP Detection"] = f.value
	end
end)
feature["» Invalid IP Detection"].on = settings["» Invalid IP Detection"]
feature["» Invalid IP Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Invalid IP Detection"].value = feature_value_settings["» Invalid IP Detection"]

feature["» Bad Net Event Detection"] = menu.add_feature("» Bad Net Event", "value_str", localparents["» Detections"].id, function(f)
	if f.on then
		settings["» Bad Net Event Detection"] = true
		feature_value_settings["» Bad Net Event Detection"] = f.value
	end
	if not f.on then
		settings["» Bad Net Event Detection"] = false
		feature_value_settings["» Bad Net Event Detection"] = f.value
	end
end)
feature["» Bad Net Event Detection"].on = settings["» Bad Net Event Detection"]
feature["» Bad Net Event Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Bad Net Event Detection"].value = feature_value_settings["» Bad Net Event Detection"]

feature["» Bad Script Event Detection"] = menu.add_feature("» Bad Script Event", "value_str", localparents["» Detections"].id, function(f)
	if f.on then
		settings["» Bad Script Event Detection"] = true
		feature_value_settings["» Bad Script Event Detection"] = f.value
	end
	if not f.on then
		settings["» Bad Script Event Detection"] = false
		feature_value_settings["» Bad Script Event Detection"] = f.value
	end
end)
feature["» Bad Script Event Detection"].on = settings["» Bad Script Event Detection"]
feature["» Bad Script Event Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Bad Script Event Detection"].value = feature_value_settings["» Bad Script Event Detection"]

feature["» Stand User Detection"] = menu.add_feature("» Stand User", "value_str", localparents["» Detections"].id, function(f)
	if f.on then
		settings["» Stand User Detection"] = true
		feature_value_settings["» Stand User Detection"] = f.value
		has_someone_been_marked_as_stand_user = false
		while f.on do
			system.yield(500)
			has_found_stand_user_suspect = false
			for pid = 0, 31 do
				if player.player_id() ~= pid and player.is_player_in_any_vehicle(pid) and entity.get_entity_model_hash(player.get_player_vehicle(pid)) == 941494461 and entity.get_entity_god_mode(player.get_player_vehicle(pid)) then
					local objects = utilities.get_table_of_entities(object.get_all_objects(), 1000, 1000, true, true, player.get_player_coords(player.player_id()))
					for i = 1, #objects do
						if entity.get_entity_model_hash(objects[i]) == 1913502601 and utilities.get_distance_between(objects[i], player.get_player_ped(pid)) < 20 then
							if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
							else
								if f.value == 0 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Stand User"]) then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Stand User", "Modder Detection", 6, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Stand User"])
									end
								elseif f.value == 1 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not StandUserDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Stand User", "Modder Detection", 6, 0x00A2FF)
										StandUserDetectionPlayer[pid] = true
									end
								elseif f.value == 2 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Stand User"]) then
										player.set_player_as_modder(pid, custommodderflags["Stand User"])
									end
								end
							end
						end
					end
				end
			end
			local vehicles = utilities.get_table_of_entities(vehicle.get_all_vehicles(), 1000, 1000, true, true, player.get_player_coords(player.player_id()))
			for i = 1, #vehicles do
				if entity.get_entity_model_hash(vehicles[i]) == 1349725314 and vehicle.get_num_vehicle_mods(vehicles[i], 48) ~= 0 and utilities.get_distance_between(vehicles[i], player.get_player_ped(player.player_id())) < 50 then
					for pid = 0, 31 do
						if player.is_player_valid(pid) and network.get_player_player_is_spectating(pid) == player.player_id() and not entity.is_entity_dead(pid) then
							stand_user_detection_suspect = network.get_player_player_is_spectating(pid)
							has_found_stand_user_suspect = true
						end
					end
					if not has_found_stand_user_suspect then
						if player.player_count() > 2 then
							stand_user_detection_suspect = utilities.get_closest_player_to_coords_in_range(player.get_player_coords(player.player_id()), 300)
						else
							stand_user_detection_suspect = utilities.get_closest_player_to_coords(player.get_player_coords(player.player_id()))
						end
					end
					if (settings["» Exclude Friends From Detections"] and player.is_player_friend(stand_user_detection_suspect)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[stand_user_detection_suspect]) then
					else
						if stand_user_detection_suspect ~= player.player_id() and player.is_player_valid(stand_user_detection_suspect) and not player.is_player_modder(stand_user_detection_suspect, custommodderflags["Stand User"]) then
							if not has_someone_been_marked_as_stand_user then
								has_someone_been_marked_as_stand_user = true
								if f.value == 0 or f.value == 1 then
									menu.notify("Player: " .. player.get_player_name(stand_user_detection_suspect) .. "\nReason: Stand User", "Modder Detection", 6, 0x00A2FF)
								end
								if f.value == 0 or f.value == 2 then
									player.set_player_as_modder(stand_user_detection_suspect, custommodderflags["Stand User"])
								end
								menu.create_thread(function()
									system.wait(2000)
									has_someone_been_marked_as_stand_user = false
								end, nil)
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Stand User Detection"] = false
		feature_value_settings["» Stand User Detection"] = f.value
	end
end)
feature["» Stand User Detection"].on = settings["» Stand User Detection"]
feature["» Stand User Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Stand User Detection"].value = feature_value_settings["» Stand User Detection"]

feature["» Max Speed Bypass Detection"] = menu.add_feature("» Max Speed Bypass", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Max Speed Bypass Detection"] = true
		feature_value_settings["» Max Speed Bypass Detection"] = f.value
		while f.on do
			system.yield(0)
			for pid = 0, 31 do
				if player.is_player_valid(pid) and player.is_player_in_any_vehicle(pid) then
					if streaming.is_model_a_plane(entity.get_entity_model_hash(player.get_player_vehicle(pid))) then
						if entity.get_entity_speed(player.get_player_vehicle(pid)) > 576 / 3.6 then
							if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
							else
								if f.value == 0 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Max Speed Bypass"]) then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Max Speed Bypass", "Modder Detection", 6, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Max Speed Bypass"])
									end
								elseif f.value == 1 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not MaxSpeedBypassDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Max Speed Bypass", "Modder Detection", 6, 0x00A2FF)
										MaxSpeedBypassDetectionPlayer[pid] = true
									end
								elseif f.value == 2 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Max Speed Bypass"]) then
										player.set_player_as_modder(pid, custommodderflags["Max Speed Bypass"])
									end
								end
							end
						end
					else
						if entity.get_entity_speed(player.get_player_vehicle(pid)) > 540 / 3.6 then
							if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
							else
								if f.value == 0 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Max Speed Bypass"]) then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Max Speed Bypass", "Modder Detection", 6, 0x00A2FF)
										player.set_player_as_modder(pid, custommodderflags["Max Speed Bypass"])
									end
								elseif f.value == 1 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not MaxSpeedBypassDetectionPlayer[pid] then
										menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Max Speed Bypass", "Modder Detection", 6, 0x00A2FF)
										MaxSpeedBypassDetectionPlayer[pid] = true
									end
								elseif f.value == 2 then
									if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Max Speed Bypass"]) then
										player.set_player_as_modder(pid, custommodderflags["Max Speed Bypass"])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Max Speed Bypass Detection"] = false
		feature_value_settings["» Max Speed Bypass Detection"] = f.value
	end
end)
feature["» Max Speed Bypass Detection"].on = settings["» Max Speed Bypass Detection"]
feature["» Max Speed Bypass Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Max Speed Bypass Detection"].value = feature_value_settings["» Max Speed Bypass Detection"]

feature["» Invalid Stats Detection"] = menu.add_feature("» Invalid Stats", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Invalid Stats Detection"] = true
		feature_value_settings["» Invalid Stats Detection"] = f.value
		while f.on do
			system.yield(10000)
			if network.is_session_started() then
				for pid = 0, 31 do
					if player.is_player_valid(pid) then
						if script_func.get_player_kills(pid) > 2147483647 or script_func.get_player_kills(pid) < 0 or script_func.get_player_deaths(pid) > 2147483647 or script_func.get_player_deaths(pid) < 0 or script_func.get_player_kd(pid) > 2147483647 or script_func.get_player_kd(pid) < 0 or script_func.get_player_rank(pid) > 8000 or script_func.get_player_rank(pid) < 1 then
							if did_someone_type and pid ~= player.player_id() and player.is_player_valid(pid) and utilities.is_player_moving(pid) and meteor_session_timer < utils.time_ms() then
								if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
								else
									if f.value == 0 then
										if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid Stats"]) then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid Stats", "Modder Detection", 6, 0x00A2FF)
											player.set_player_as_modder(pid, custommodderflags["Invalid Stats"])
										end
									elseif f.value == 1 then
										if pid ~= player.player_id() and player.is_player_valid(pid) and not InvalidStatsDetectionPlayer[pid] then
											menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Invalid Stats", "Modder Detection", 6, 0x00A2FF)
											InvalidStatsDetectionPlayer[pid] = true
										end
									elseif f.value == 2 then
										if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Invalid Stats"]) then
											player.set_player_as_modder(pid, custommodderflags["Invalid Stats"])
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Invalid Stats Detection"] = false
		feature_value_settings["» Invalid Stats Detection"] = f.value
	end
end)
feature["» Invalid Stats Detection"].on = settings["» Invalid Stats Detection"]
feature["» Invalid Stats Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Invalid Stats Detection"].value = feature_value_settings["» Invalid Stats Detection"]

feature["» Session Host Crash Detection"] = menu.add_feature("» Session Host Crash", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Session Host Crash Detection"] = true
		feature_value_settings["» Session Host Crash Detection"] = f.value
		while f.on do
			system.yield(500)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if did_someone_type and meteor_session_timer < utils.time_ms() and (player.get_player_coords(pid).x > 10700 or player.get_player_coords(pid).y > 10700 or player.get_player_coords(pid).x < -10700 or player.get_player_coords(pid).y < -10700) then
						if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
						else
							if f.value == 0 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Session Host Crash"]) then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Session Host Crash", "Modder Detection", 6, 0x00A2FF)
									player.set_player_as_modder(pid, custommodderflags["Session Host Crash"])
								end
							elseif f.value == 1 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not SessionHostCrashDetectionPlayer[pid] then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Session Host Crash", "Modder Detection", 6, 0x00A2FF)
									SessionHostCrashDetectionPlayer[pid] = true
								end
							elseif f.value == 2 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Session Host Crash"]) then
									player.set_player_as_modder(pid, custommodderflags["Session Host Crash"])
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Session Host Crash Detection"] = false
		feature_value_settings["» Session Host Crash Detection"] = f.value
	end
end)
feature["» Session Host Crash Detection"].on = settings["» Session Host Crash Detection"]
feature["» Session Host Crash Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Session Host Crash Detection"].value = feature_value_settings["» Session Host Crash Detection"]

feature["» Bad Outfit Data Detection"] = menu.add_feature("» Bad Outfit Data", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Bad Outfit Data Detection"] = true
		feature_value_settings["» Bad Outfit Data Detection"] = f.value
		while f.on do
			system.yield(400)
			for pid = 0, 31 do
				if player.is_player_valid(pid) and did_someone_type and meteor_session_timer < utils.time_ms() and utilities.is_player_moving(pid) and not utilities.is_player_in_interior(pid) then
					if (player.is_player_female(pid) and (ped.get_ped_drawable_variation(player.get_player_ped(pid), 3) == 415 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 8) == 234 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 6) == 106 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 4) == 151)) or (not player.is_player_female(pid) and (ped.get_ped_drawable_variation(player.get_player_ped(pid), 3) == 393 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 8) == 189 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 6) == 102 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 4) == 144)) or (ped.get_ped_drawable_variation(player.get_player_ped(pid), 0) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 0) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 1) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 1) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 2) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 2) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 3) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 4) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 5) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 5) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 6) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 6) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 7) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 7) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 8) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 8) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 9) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 9) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 10) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 10) < 0 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 11) > 500 or ped.get_ped_drawable_variation(player.get_player_ped(pid), 11) < 0) then
						if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
						else
							if f.value == 0 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Bad Outfit Data"]) then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Bad Outfit Data", "Modder Detection", 6, 0x00A2FF)
									player.set_player_as_modder(pid, custommodderflags["Bad Outfit Data"])
								end
							elseif f.value == 1 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not BadOutfitDataDetectionPlayer[pid] then
									menu.notify("Player: " .. player.get_player_name(pid) .. "\nReason: Bad Outfit Data", "Modder Detection", 6, 0x00A2FF)
									BadOutfitDataDetectionPlayer[pid] = true
								end
							elseif f.value == 2 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Bad Outfit Data"]) then
									player.set_player_as_modder(pid, custommodderflags["Bad Outfit Data"])
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Bad Outfit Data Detection"] = false
		feature_value_settings["» Bad Outfit Data Detection"] = f.value
	end
end)
feature["» Bad Outfit Data Detection"].on = settings["» Bad Outfit Data Detection"]
feature["» Bad Outfit Data Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Bad Outfit Data Detection"].value = feature_value_settings["» Bad Outfit Data Detection"]

feature["» Altered Script Host Migration Detection"] = menu.add_feature("» Altered Script Host Migration", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Altered Script Host Migration Detection"] = true
		feature_value_settings["» Altered Script Host Migration Detection"] = f.value
		for i = 0, 31 do
			HasScriptHostMigratedTo[i] = false
		end
		while f.on do
			system.yield(0)
			local current_sh
			local sh_name
			if current_sh == nil then
				current_sh = script.get_host_of_this_script()
				sh_name = player.get_player_name(current_sh)
			end
			system.wait(2000)
			local new_sh = script.get_host_of_this_script()
			if current_sh ~= new_sh then
				if player.is_player_valid(new_sh) then
					if altered_sh_migration_detection_timer_left_player < utils.time_ms() and altered_sh_migration_detection_timer < utils.time_ms() then
						if (settings["» Exclude Friends From Detections"] and player.is_player_friend(new_sh)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[new_sh]) then
						else
							if f.value == 0 then
								if new_sh ~= player.player_id() and player.is_player_valid(new_sh) and not player.is_player_modder(new_sh, custommodderflags["Altered SH Migration"]) then
									menu.notify("Player: " .. string.format("%s", player.get_player_name(new_sh)) .. "\nReason: Altered Script Host Migration", "Modder Detection", 6, 0x00A2FF)
									player.set_player_as_modder(new_sh, custommodderflags["Altered SH Migration"])
								end
							elseif f.value == 1 then
								if new_sh ~= player.player_id() and player.is_player_valid(new_sh) then
									menu.notify("Player: " .. string.format("%s", player.get_player_name(new_sh)) .. "\nReason: Altered Script Host Migration", "Modder Detection", 6, 0x00A2FF)
								end
							elseif f.value == 2 then
								if new_sh ~= player.player_id() and player.is_player_valid(new_sh) and not player.is_player_modder(new_sh, custommodderflags["Altered SH Migration"]) then
									player.set_player_as_modder(new_sh, custommodderflags["Altered SH Migration"])
								end
							end
						end
					end
					sh_name = player.get_player_name(current_sh)
				end
			end
			system.wait(0)
		end
		system.wait(1000)
	end
	if not f.on then
		settings["» Altered Script Host Migration Detection"] = false
		feature_value_settings["» Altered Script Host Migration Detection"] = f.value
	end
end)
feature["» Altered Script Host Migration Detection"].on = settings["» Altered Script Host Migration Detection"]
feature["» Altered Script Host Migration Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Altered Script Host Migration Detection"].value = feature_value_settings["» Altered Script Host Migration Detection"]

feature["» Fake Typing Indicator Detection"] = menu.add_feature("» Fake Typing Indicator", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Fake Typing Indicator Detection"] = true
		feature_value_settings["» Fake Typing Indicator Detection"] = f.value
		while f.on do
			system.yield(100)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if utilities.is_player_typing(pid) then
						FakeTypingBegin[pid] = true
					else
						FakeTypingBegin[pid] = false
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Fake Typing Indicator Detection"] = false
		feature_value_settings["» Fake Typing Indicator Detection"] = f.value
	end
end)
feature["» Fake Typing Indicator Detection"].on = settings["» Fake Typing Indicator Detection"]
feature["» Fake Typing Indicator Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Fake Typing Indicator Detection"].value = feature_value_settings["» Fake Typing Indicator Detection"]

feature["» Modded Spectate Detection"] = menu.add_feature("» Modded Spectate", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Modded Spectate Detection"] = true
		feature_value_settings["» Modded Spectate Detection"] = f.value
		while f.on do
			system.yield(800)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if player.is_player_spectating(pid) and not utilities.is_player_in_interior(pid) and not entity.is_entity_dead(player.get_player_ped(pid)) then
						if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
						else
							if f.value == 0 then
								if pid ~= player.player_id() and not player.is_player_modder(pid, custommodderflags["Modded Spectate"]) then
									menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded Spectate", "Modder Detection", 6, 0x00A2FF)
									player.set_player_as_modder(pid, custommodderflags["Modded Spectate"])
								end
							elseif f.value == 1 then
								if pid ~= player.player_id() and not ModdedSpectateDetectionPlayer[pid] then
									menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded Spectate", "Modder Detection", 6, 0x00A2FF)
									ModdedSpectateDetectionPlayer[pid] = true
								end
							elseif f.value == 2 then
								if pid ~= player.player_id() and not player.is_player_modder(pid, custommodderflags["Modded Spectate"]) then
									player.set_player_as_modder(pid, custommodderflags["Modded Spectate"])
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Modded Spectate Detection"] = false
		feature_value_settings["» Modded Spectate Detection"] = f.value
	end
end)
feature["» Modded Spectate Detection"].on = settings["» Modded Spectate Detection"]
feature["» Modded Spectate Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Modded Spectate Detection"].value = feature_value_settings["» Modded Spectate Detection"]

feature["» Modded OTR Detection"] = menu.add_feature("» Modded OTR", "value_str", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Modded OTR Detection"] = true
		feature_value_settings["» Modded OTR Detection"] = f.value
		for i = 0, 31 do
			IsOTRFor[i] = 0
		end
		while f.on do
			system.yield(1000)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if script_func.is_player_otr(pid) and not utilities.is_player_in_interior(pid) then
						IsOTRFor[pid] = IsOTRFor[pid] + 1
					else
						IsOTRFor[pid] = 0
					end
					if IsOTRFor[pid] > 181 then
						if (settings["» Exclude Friends From Detections"] and player.is_player_friend(pid)) or (settings["» Exclude Whitelisted Players From Detections"] and IsPlayerWhitelisted[pid]) then
						else
							if f.value == 0 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Modded OTR"]) then
									menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded OTR", "Modder Detection", 6, 0x00A2FF)
									player.set_player_as_modder(pid, custommodderflags["Modded OTR"])
								end
							elseif f.value == 1 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not ModdedOTRDetectionPlayer[pid] then
									menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded OTR", "Modder Detection", 6, 0x00A2FF)
									ModdedOTRDetectionPlayer[pid] = true
								end
							elseif f.value == 2 then
								if pid ~= player.player_id() and player.is_player_valid(pid) and not player.is_player_modder(pid, custommodderflags["Modded OTR"]) then
									player.set_player_as_modder(pid, custommodderflags["Modded OTR"])
								end
							end
						end
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Modded OTR Detection"] = false
		feature_value_settings["» Modded OTR Detection"] = f.value
		for i = 0, 31 do
			IsOTRFor[i] = 0
		end
	end
end)
feature["» Modded OTR Detection"].on = settings["» Modded OTR Detection"]
feature["» Modded OTR Detection"]:set_str_data({"Mark & Notify", "Notify", "Mark"})
feature["» Modded OTR Detection"].value = feature_value_settings["» Modded OTR Detection"]

feature["» Chat Spoof Notification"] = menu.add_feature("» Chat Spoof Notification", "toggle", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Chat Spoof Notification"] = true
		while f.on do
			system.yield(0)
			for pid = 0, 31 do
				if player.is_player_valid(pid) then
					if utilities.is_player_typing(pid) and not HasBeenTyping[pid] and not entity.is_entity_dead(player.get_player_ped(pid)) then
						HasBeenTyping[pid] = true
						HasNotBeenTyping[pid] = false
						did_someone_type = true
					elseif not utilities.is_player_typing(pid) and HasBeenTyping[pid] and not HasNotBeenTyping[pid] and not entity.is_entity_dead(player.get_player_ped(pid)) then
						HasNotBeenTyping[pid] = true
						menu.create_thread(function()
							local pid_id = pid
							system.wait(2000)
							HasBeenTyping[pid_id] = false
						end, nil)
					end
				end
			end
		end
	end
	if not f.on then
		settings["» Chat Spoof Notification"] = false
	end
end)
feature["» Chat Spoof Notification"].on = settings["» Chat Spoof Notification"]

feature["» Rockstar Admin Notification"] = menu.add_feature("» Rockstar Admin Notification", "toggle", localparents["» Detections"].id, function(f, pid)
	if f.on then
		settings["» Rockstar Admin Notification"] = true
	end
	if not f.on then
		settings["» Rockstar Admin Notification"] = false
	end
end)
feature["» Rockstar Admin Notification"].on = settings["» Rockstar Admin Notification"]

feature["» Exclude Friends From Detections"] = menu.add_feature("» Exclude Friends", "toggle", localparents["» Detections"].id, function(f)
	if f.on then
        settings["» Exclude Friends From Detections"] = true
    end
    if not f.on then
        settings["» Exclude Friends From Detections"] = false
    end
end)
feature["» Exclude Friends From Detections"].on = settings["» Exclude Friends From Detections"]

feature["» Exclude Whitelisted Players From Detections"] = menu.add_feature("» Exclude Whitelisted Players", "toggle", localparents["» Detections"].id, function(f)
	if f.on then
        settings["» Exclude Whitelisted Players From Detections"] = true
    end
    if not f.on then
        settings["» Exclude Whitelisted Players From Detections"] = false
    end
end)
feature["» Exclude Whitelisted Players From Detections"].on = settings["» Exclude Whitelisted Players From Detections"]

--

menu.add_feature("» Save Current Position", "toggle", localparents["» Teleporter"].id, function(f)
	if f.on then
		save_current_pos = player.get_player_coords(player.player_id())
	end
	if not f.on then
		if player.is_player_in_any_vehicle(player.player_id()) then
			entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), save_current_pos)
		else
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), save_current_pos)
		end
		save_current_pos = nil
	end
end)

feature["» Auto Waypoint Tp"] = menu.add_feature("» Auto Waypoint Tp", "toggle", localparents["» Teleporter"].id, function(f)
	if f.on then
		settings["» Auto Waypoint Tp"] = true
		while f.on do
			system.yield(50)
			if ui.get_waypoint_coord().x ~= 16000 then
				local previous_position = player.get_player_coords(player.player_id())
				local pos = v3(ui.get_waypoint_coord().x, ui.get_waypoint_coord().y, -100)
				if player.is_player_in_any_vehicle(player.player_id()) then
					entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), pos)
				else
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
				end
				system.wait(10)
				local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
				if not success then
					if player.is_player_in_any_vehicle(player.player_id()) then
						entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
					else
						entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
					end
					system.wait(10)
					local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
					if not success then
						if player.is_player_in_any_vehicle(player.player_id()) then
							entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
						else
							entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
						end
						system.wait(10)
						local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
						if not success then
							if player.is_player_in_any_vehicle(player.player_id()) then
								entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
							else
								entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
							end
							system.wait(10)
							local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
							if not success then
								if player.is_player_in_any_vehicle(player.player_id()) then
									entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
								else
									entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
								end
								system.wait(10)
								local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
								if not success then
									if player.is_player_in_any_vehicle(player.player_id()) then
										entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
									else
										entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
									end
									system.wait(10)
									local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
									if not success then
										if player.is_player_in_any_vehicle(player.player_id()) then
											entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
										else
											entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
										end
										system.wait(10)
										local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
										if not success then
											if player.is_player_in_any_vehicle(player.player_id()) then
												entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
											else
												entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
											end
											system.wait(10)
											local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
											if not success then
												if player.is_player_in_any_vehicle(player.player_id()) then
													entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
												else
													entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
												end
												system.wait(10)
												local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
												if not success then
													if player.is_player_in_any_vehicle(player.player_id()) then
														entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
													else
														entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
													end
													system.wait(10)
													local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
													if not success then
														if player.is_player_in_any_vehicle(player.player_id()) then
															entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
														else
															entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
														end
														system.wait(10)
														local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
														if not success then
															if player.is_player_in_any_vehicle(player.player_id()) then
																entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
															else
																entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
															end
															system.wait(10)
															local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
															if not success then
																if player.is_player_in_any_vehicle(player.player_id()) then
																	entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																else
																	entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																end
																system.wait(10)
																local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																if not success then
																	if player.is_player_in_any_vehicle(player.player_id()) then
																		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																	else
																		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																	end
																	system.wait(10)
																	local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																	if not success then
																		if player.is_player_in_any_vehicle(player.player_id()) then
																			entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																		else
																			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																		end
																		system.wait(10)
																		local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																		if not success then
																			if player.is_player_in_any_vehicle(player.player_id()) then
																				entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																			else
																				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																			end
																			system.wait(10)
																			local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																			if not success then
																				if player.is_player_in_any_vehicle(player.player_id()) then
																					entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																				else
																					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																				end
																				system.wait(10)
																				local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																				if not success then
																					if player.is_player_in_any_vehicle(player.player_id()) then
																						entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																					else
																						entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																					end
																					system.wait(10)
																					local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																					if not success then
																						if player.is_player_in_any_vehicle(player.player_id()) then
																							entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																						else
																							entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																						end
																						system.wait(10)
																						local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																						if not success then
																							menu.notify("Teleportation Cancelled! Failed to get ground z!", Meteor, 3, 211)
																							if player.is_player_in_any_vehicle(player.player_id()) then
																								entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), previous_position)
																							else
																								entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), previous_position)
																							end
																						else
																							if player.is_player_in_any_vehicle(player.player_id()) then
																								entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																							else
																								entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																							end
																							ui.set_waypoint_off()
																						end
																					else
																						if player.is_player_in_any_vehicle(player.player_id()) then
																							entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																						else
																							entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																						end
																						ui.set_waypoint_off()
																					end
																				else
																					if player.is_player_in_any_vehicle(player.player_id()) then
																						entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																					else
																						entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																					end
																					ui.set_waypoint_off()
																				end
																			else
																				if player.is_player_in_any_vehicle(player.player_id()) then
																					entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																				else
																					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																				end
																				ui.set_waypoint_off()
																			end
																		else
																			if player.is_player_in_any_vehicle(player.player_id()) then
																				entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																			else
																				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																			end
																			ui.set_waypoint_off()
																		end
																	else
																		if player.is_player_in_any_vehicle(player.player_id()) then
																			entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																		else
																			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																		end
																		ui.set_waypoint_off()
																	end
																else
																	if player.is_player_in_any_vehicle(player.player_id()) then
																		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																	else
																		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																	end
																	ui.set_waypoint_off()
																end
															else
																if player.is_player_in_any_vehicle(player.player_id()) then
																	entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																else
																	entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																end
																ui.set_waypoint_off()
															end
														else
															if player.is_player_in_any_vehicle(player.player_id()) then
																entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
															else
																entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
															end
															ui.set_waypoint_off()
														end
													else
														if player.is_player_in_any_vehicle(player.player_id()) then
															entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
														else
															entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
														end
														ui.set_waypoint_off()
													end
												else
													if player.is_player_in_any_vehicle(player.player_id()) then
														entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
													else
														entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
													end
													ui.set_waypoint_off()
												end
											else
												if player.is_player_in_any_vehicle(player.player_id()) then
													entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
												else
													entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
												end
												ui.set_waypoint_off()
											end
										else
											if player.is_player_in_any_vehicle(player.player_id()) then
												entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
											else
												entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
											end
											ui.set_waypoint_off()
										end
									else
										if player.is_player_in_any_vehicle(player.player_id()) then
											entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
										else
											entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
										end
										ui.set_waypoint_off()
									end
								else
									if player.is_player_in_any_vehicle(player.player_id()) then
										entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
									else
										entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
									end
									ui.set_waypoint_off()
								end
							else
								if player.is_player_in_any_vehicle(player.player_id()) then
									entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
								else
									entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
								end
								ui.set_waypoint_off()
							end
						else
							if player.is_player_in_any_vehicle(player.player_id()) then
								entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
							else
								entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
							end
							ui.set_waypoint_off()
						end
					else
						if player.is_player_in_any_vehicle(player.player_id()) then
							entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
						else
							entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
						end
						ui.set_waypoint_off()
					end
				else
					if player.is_player_in_any_vehicle(player.player_id()) then
						entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
					else
						entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
					end
					ui.set_waypoint_off()
				end
			end
		end
	end
	if not f.on then
		settings["» Auto Waypoint Tp"] = false
	end
end)
feature["» Auto Waypoint Tp"].on = settings["» Auto Waypoint Tp"]

menu.add_feature("» Teleport To Waypoint", "action", localparents["» Teleporter"].id, function(f)
	if ui.get_waypoint_coord().x ~= 16000 then
		local previous_position = player.get_player_coords(player.player_id())
		local pos = v3(ui.get_waypoint_coord().x, ui.get_waypoint_coord().y, -100)
		if player.is_player_in_any_vehicle(player.player_id()) then
			entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), pos)
		else
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
		end
		system.wait(10)
		local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
		if not success then
			if player.is_player_in_any_vehicle(player.player_id()) then
				entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
			else
				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
			end
			system.wait(10)
			local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
			if not success then
				if player.is_player_in_any_vehicle(player.player_id()) then
					entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
				else
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
				end
				system.wait(10)
				local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
				if not success then
					if player.is_player_in_any_vehicle(player.player_id()) then
						entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
					else
						entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
					end
					system.wait(10)
					local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
					if not success then
						if player.is_player_in_any_vehicle(player.player_id()) then
							entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
						else
							entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
						end
						system.wait(10)
						local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
						if not success then
							if player.is_player_in_any_vehicle(player.player_id()) then
								entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
							else
								entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
							end
							system.wait(10)
							local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
							if not success then
								if player.is_player_in_any_vehicle(player.player_id()) then
									entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
								else
									entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
								end
								system.wait(10)
								local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
								if not success then
									if player.is_player_in_any_vehicle(player.player_id()) then
										entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
									else
										entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
									end
									system.wait(10)
									local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
									if not success then
										if player.is_player_in_any_vehicle(player.player_id()) then
											entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
										else
											entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
										end
										system.wait(10)
										local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
										if not success then
											if player.is_player_in_any_vehicle(player.player_id()) then
												entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
											else
												entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
											end
											system.wait(10)
											local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
											if not success then
												if player.is_player_in_any_vehicle(player.player_id()) then
													entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
												else
													entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
												end
												system.wait(10)
												local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
												if not success then
													if player.is_player_in_any_vehicle(player.player_id()) then
														entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
													else
														entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
													end
													system.wait(10)
													local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
													if not success then
														if player.is_player_in_any_vehicle(player.player_id()) then
															entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
														else
															entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
														end
														system.wait(10)
														local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
														if not success then
															if player.is_player_in_any_vehicle(player.player_id()) then
																entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
															else
																entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
															end
															system.wait(10)
															local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
															if not success then
																if player.is_player_in_any_vehicle(player.player_id()) then
																	entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																else
																	entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																end
																system.wait(10)
																local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																if not success then
																	if player.is_player_in_any_vehicle(player.player_id()) then
																		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																	else
																		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																	end
																	system.wait(10)
																	local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																	if not success then
																		if player.is_player_in_any_vehicle(player.player_id()) then
																			entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																		else
																			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																		end
																		system.wait(10)
																		local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																		if not success then
																			if player.is_player_in_any_vehicle(player.player_id()) then
																				entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																			else
																				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																			end
																			system.wait(10)
																			local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																			if not success then
																				if player.is_player_in_any_vehicle(player.player_id()) then
																					entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																				else
																					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																				end
																				system.wait(10)
																				local success, float = gameplay.get_ground_z(player.get_player_coords(player.player_id()))
																				if not success then
																					menu.notify("Teleportation Cancelled! Failed to get ground z!", Meteor, 3, 211)
																					if player.is_player_in_any_vehicle(player.player_id()) then
																						entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), previous_position)
																					else
																						entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), previous_position)
																					end
																				else
																					if player.is_player_in_any_vehicle(player.player_id()) then
																						entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																					else
																						entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																					end
																					ui.set_waypoint_off()
																				end
																			else
																				if player.is_player_in_any_vehicle(player.player_id()) then
																					entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																				else
																					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																				end
																				ui.set_waypoint_off()
																			end
																		else
																			if player.is_player_in_any_vehicle(player.player_id()) then
																				entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																			else
																				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																			end
																			ui.set_waypoint_off()
																		end
																	else
																		if player.is_player_in_any_vehicle(player.player_id()) then
																			entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																		else
																			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																		end
																		ui.set_waypoint_off()
																	end
																else
																	if player.is_player_in_any_vehicle(player.player_id()) then
																		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																	else
																		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																	end
																	ui.set_waypoint_off()
																end
															else
																if player.is_player_in_any_vehicle(player.player_id()) then
																	entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																else
																	entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																end
																ui.set_waypoint_off()
															end
														else
															if player.is_player_in_any_vehicle(player.player_id()) then
																entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
															else
																entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
															end
															ui.set_waypoint_off()
														end
													else
														if player.is_player_in_any_vehicle(player.player_id()) then
															entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
														else
															entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
														end
														ui.set_waypoint_off()
													end
												else
													if player.is_player_in_any_vehicle(player.player_id()) then
														entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
													else
														entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
													end
													ui.set_waypoint_off()
												end
											else
												if player.is_player_in_any_vehicle(player.player_id()) then
													entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
												else
													entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
												end
												ui.set_waypoint_off()
											end
										else
											if player.is_player_in_any_vehicle(player.player_id()) then
												entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
											else
												entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
											end
											ui.set_waypoint_off()
										end
									else
										if player.is_player_in_any_vehicle(player.player_id()) then
											entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
										else
											entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
										end
										ui.set_waypoint_off()
									end
								else
									if player.is_player_in_any_vehicle(player.player_id()) then
										entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
									else
										entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
									end
									ui.set_waypoint_off()
								end
							else
								if player.is_player_in_any_vehicle(player.player_id()) then
									entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
								else
									entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
								end
								ui.set_waypoint_off()
							end
						else
							if player.is_player_in_any_vehicle(player.player_id()) then
								entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
							else
								entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
							end
							ui.set_waypoint_off()
						end
					else
						if player.is_player_in_any_vehicle(player.player_id()) then
							entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
						else
							entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
						end
						ui.set_waypoint_off()
					end
				else
					if player.is_player_in_any_vehicle(player.player_id()) then
						entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
					else
						entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
					end
					ui.set_waypoint_off()
				end
			else
				if player.is_player_in_any_vehicle(player.player_id()) then
					entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
				else
					entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
				end
				ui.set_waypoint_off()
			end
		else
			if player.is_player_in_any_vehicle(player.player_id()) then
				entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
			else
				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
			end
			ui.set_waypoint_off()
		end
	else
		menu.notify("[!] Waypoint not found.", Meteor, 3, 211)
	end
end)

localparents["» Position Offset"] = menu.add_feature("» Position Offset", "parent", localparents["» Teleporter"].id)

menu.add_feature("» Teleport Forward", "action", localparents["» Position Offset"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		while not network.has_control_of_entity(player.get_player_vehicle(player.player_id())) do
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			system.wait(0)
		end
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5))
		vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), speed)
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5))
	end
end)

menu.add_feature("» Teleport Back", "action", localparents["» Position Offset"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		while not network.has_control_of_entity(player.get_player_vehicle(player.player_id())) do
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			system.wait(0)
		end
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), utilities.offset_coords_back(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5))
		vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), speed)
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), utilities.offset_coords_back(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5))
	end
end)

menu.add_feature("» Teleport Right", "action", localparents["» Position Offset"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		while not network.has_control_of_entity(player.get_player_vehicle(player.player_id())) do
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			system.wait(0)
		end
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), utilities.offset_coords_right(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5))
		vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), speed)
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), utilities.offset_coords_right(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5))
	end
end)

menu.add_feature("» Teleport Left", "action", localparents["» Position Offset"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		while not network.has_control_of_entity(player.get_player_vehicle(player.player_id())) do
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			system.wait(0)
		end
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), utilities.offset_coords_left(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5))
		vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), speed)
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), utilities.offset_coords_left(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5))
	end
end)

menu.add_feature("» Teleport Up", "action", localparents["» Position Offset"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		while not network.has_control_of_entity(player.get_player_vehicle(player.player_id())) do
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			system.wait(0)
		end
		local pos = player.get_player_coords(player.player_id()) + v3(0, 0, 5)
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), pos)
		vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), speed)
	else
		local pos = player.get_player_coords(player.player_id()) + v3(0, 0, 5)
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
	end
end)

menu.add_feature("» Teleport Down", "action", localparents["» Position Offset"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		while not network.has_control_of_entity(player.get_player_vehicle(player.player_id())) do
			network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
			system.wait(0)
		end
		local pos = player.get_player_coords(player.player_id()) - v3(0, 0, 5)
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), pos)
		vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()), speed)
	else
		local pos = player.get_player_coords(player.player_id()) - v3(0, 0, 5)
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
	end
end)

local locations = {}

local function split_string(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

local function generate_string(id, name, x, y, z)
    return id .. "||" .. name .. "||" .. x .. "," .. y .. "," .. z
end

local function rename_teleport_location(id, name, x, y, z)
    local found_index = false
    local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\CustomLocations.txt", 'r')
    local file_content = {}
    local last_checked_line = 0
    for line in file:lines() do
        last_checked_line = last_checked_line + 1
        table.insert (file_content, line)

        local main_parts = split_string(line, "||")
        local location_id = main_parts[1]

        if location_id == id then
            found_index = last_checked_line
        end
    end
    io.close(file)

    if found_index then
        file_content[found_index] = generate_string(id, name, x, y, z)

        file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\CustomLocations.txt", 'w')
        for index, value in ipairs(file_content) do
            file:write(value..'\n')
        end
        io.close(file)

        locations[id].name = name
        locations[id].data.id = id
        locations[id].data.name = name
        locations[id].data.x = x
        locations[id].data.y = y
        locations[id].data.z = z

        return true
    else
        return false
    end
end

local function delete_location(id, name, x, y, z)
    local found = false
    local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\CustomLocations.txt", 'r')
    local file_content = {}
    for line in file:lines() do
        local main_parts = split_string(line, "||")
        local location_id = main_parts[1]

        if location_id == id then
            found = true
        else
            table.insert (file_content, line)
        end
    end
    io.close(file)

    if found then
        file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\CustomLocations.txt", 'w')
        for index, value in ipairs(file_content) do
            file:write(value..'\n')
        end
        io.close(file)
        
        return true
    else
        return false
    end
end

localparents["» Custom Locations"] = menu.add_feature("» Custom Locations", "parent", localparents["» Teleporter"].id)

localparents["» Saved Locations"] = menu.add_feature("» Saved Locations", "parent", localparents["» Custom Locations"].id)

local function append_location(id, name, x, y, z)
    locations[id] = menu.add_feature("» " .. name .. "", "action_value_str", localparents["» Saved Locations"].id, function(option_index)
        if option_index.value == 0 then
            local teleport_success = false

            if player.is_player_in_any_vehicle(player.player_id()) then
                teleport_success = entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(locations[id].data.x, locations[id].data.y, locations[id].data.z))
            else
                teleport_success = entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(locations[id].data.x, locations[id].data.y, locations[id].data.z))
            end

            if teleport_success then
                menu.notify("Teleported to \""..name.."\"!", Meteor)
            else
                menu.notify("[!] An error occured.", Meteor, 3, 211)
            end
        end

        if option_index.value == 1 then
            local input_stat, input_val = input.get("Please Provide A Name For The Location", "", 12, 0)

            if input_stat == 1 then
                return HANDLER_CONTINUE
            end

			input_val_str = "» " .. input_val .. ""
        
            if input_stat == 2 or input_val == "" or string.find(input_val, "||") then
                menu.notify("[!] Cancelled!", Meteor, 3, 211)
                return false
            end

            local previous_name = locations[id].name

            local rename_success = rename_teleport_location(id, input_val_str, x, y, z)

            if rename_success then
                menu.notify("[!] Renamed \"" .. previous_name .. "\" to \"" .. input_val_str .. "\".", Meteor)
            else
                menu.notify("[!] Cancelled!", Meteor, 3, 211)
            end
        end

        if option_index.value == 2 then
            local delete_success = delete_location(id)

            if delete_success then
                menu.notify("Deleted \"" .. name .. "\" from your saved locations.", Meteor)
                menu.delete_feature(locations[id].id)
            else
                menu.notify("[!] An error occured.", Meteor, 3, 211)
            end
        end
    end)
    
    locations[id]:set_str_data({
        "Teleport",
        "Rename",
        "Delete"
    })

    locations[id].data = {}
    locations[id].data.id = id
    locations[id].data.name = name
    locations[id].data.x = x
    locations[id].data.y = y
    locations[id].data.z = z
end

file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\CustomLocations.txt", "r")
io.input(file)
for line in io.lines(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\CustomLocations.txt") do
    if string.find(line, "||") then
        local main_parts = split_string(line, "||")
        local location_id = main_parts[1]
        local location_coords = split_string(main_parts[3], ",")
        local location_name, coord_x, coord_y, coord_z = main_parts[2], location_coords[1], location_coords[2], location_coords[3]

        append_location(location_id, location_name, coord_x, coord_y, coord_z)
    end
end
io.close(file)

menu.add_feature("» Save Current Location", "action", localparents["» Custom Locations"].id, function()
    local input_stat, input_val = input.get("Please Provide A Name For The Location", "", 12, 0)

    if input_stat == 1 then
        return HANDLER_CONTINUE
    end

    if input_stat == 2 or input_val == "" or string.find(input_val, "||") then
        menu.notify("[!] Cancelled!", Meteor, 3, 211)
        return false
    end

    local location_id = os.time().."r"..math.random(1,10000)
    local player_id = player.player_id()
    local player_ped = player.get_player_ped(player.player_id())
    local player_coords = entity.get_entity_coords(player_ped)
    
    file = io.open (utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\CustomLocations.txt", "a+")
    io.output(file)
    io.write(generate_string(location_id, input_val, player_coords["x"], player_coords["y"], player_coords["z"]).."\n")
    io.close(file)

    append_location(location_id, input_val, player_coords["x"], player_coords["y"], player_coords["z"])

    menu.notify("[!] Succesfully saved location.\nName: " .. input_val .. "\nPos x: " .. player.get_player_coords(player.player_id()).x .. "\nPos y: " .. player.get_player_coords(player.player_id()).y .. "\nPos z: " .. player.get_player_coords(player.player_id()).z .. "", Meteor)
end)

menu.add_feature("» Wipe Custom Locations", "action", localparents["» Custom Locations"].id, function(f)
	local input_stat, input_val = input.get("Are You Sure? This Process Cannot Be Undone! Type \"Yes\" To Continue..", "", 3, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
		menu.notify("[!] Cancelled!", Meteor, 3, 211)
        return HANDLER_POP
    end
	if input_val == "Yes" then
		if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\CustomLocations.txt") then
			utilities.write(io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Meteor\\Data\\CustomLocations.txt", "w"), "")
			menu.notify("[!] Succesfully wiped CustomLocations.txt", Meteor)
		else
			menu.notify("[!] File Missing!\n\\Meteor\\Data\\CustomLocations.txt", Meteor, 3, 211)
		end
	else
		menu.notify("[!] Cancelled!", Meteor, 3, 211)
	end
end)

localparents["» Stunt Jumps"] = menu.add_feature("» Stunt Jumps", "parent", localparents["» Teleporter"].id)

menu.add_feature("» Stunt Jump 1", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(46.211102, 6535.8999, 30.9198))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(46.211102, 6535.8999, 30.9198))
	end
end)

menu.add_feature("» Stunt Jump 2", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-183.87399, 6557.1401, 10.528))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-183.87399, 6557.1401, 10.528))
	end
end)

menu.add_feature("» Stunt Jump 3", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(486.98401, 4311.29, 55.3102))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(486.98401, 4311.29, 55.3102))
	end
end)

menu.add_feature("» Stunt Jump 4", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-956.85999, 4168.9502, 135.91299))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-956.85999, 4168.9502, 135.91299))
	end
end)

menu.add_feature("» Stunt Jump 5", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(1.8338799, 1705.23, 226.188))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1.8338799, 1705.23, 226.188))
	end
end)

menu.add_feature("» Stunt Jump 6", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-1447.84, 416.97101, 109.381))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-1447.84, 416.97101, 109.381))
	end
end)

menu.add_feature("» Stunt Jump 7", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-1082.89, 12.2386, 50.351002))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-1082.89, 12.2386, 50.351002))
	end
end)

menu.add_feature("» Stunt Jump 8", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-1998.66, -321.186, 47.7271))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-1998.66, -321.186, 47.7271))
	end
end)

menu.add_feature("» Stunt Jump 9", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-711.27502, -48.209202, 37.3675))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-711.27502, -48.209202, 37.3675))
	end
end)

menu.add_feature("» Stunt Jump 10", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-594.41101, -101.397, 41.9557))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-594.41101, -101.397, 41.9557))
	end
end)

menu.add_feature("» Stunt Jump 11", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-234.21899, -210.683, 48.6982))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-234.21899, -210.683, 48.6982))
	end
end)

menu.add_feature("» Stunt Jump 12", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-443.48599, -554.01801, 25.627001))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-443.48599, -554.01801, 25.627001))
	end
end)

menu.add_feature("» Stunt Jump 13", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-77.701302, -537.99402, 39.783901))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-77.701302, -537.99402, 39.783901))
	end
end)

menu.add_feature("» Stunt Jump 14", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-1587.24, -750.60602, 20.8568))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-1587.24, -750.60602, 20.8568))
	end
end)

menu.add_feature("» Stunt Jump 15", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-874.10901, -848.05798, 18.783899))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-874.10901, -848.05798, 18.783899))
	end
end)

menu.add_feature("» Stunt Jump 16", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-286.93701, -766.35199, 52.867802))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-286.93701, -766.35199, 52.867802))
	end
end)

menu.add_feature("» Stunt Jump 17", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-616.828, -1074.49, 21.9998))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-616.828, -1074.49, 21.9998))
	end
end)

menu.add_feature("» Stunt Jump 18", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-439.431, -1178.71, 52.919899))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-439.431, -1178.71, 52.919899))
	end
end)

menu.add_feature("» Stunt Jump 19", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-452.37601, -1379.3, 30.1364))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-452.37601, -1379.3, 30.1364))
	end
end)

menu.add_feature("» Stunt Jump 20", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-533.01898, -1482.13, 11.4117))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-533.01898, -1482.13, 11.4117))
	end
end)

menu.add_feature("» Stunt Jump 21", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-574.25201, -1533.3199, 0.80641103))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-574.25201, -1533.3199, 0.80641103))
	end
end)

menu.add_feature("» Stunt Jump 22", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-424.23801, -1563.8101, 25.0089))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-424.23801, -1563.8101, 25.0089))
	end
end)

menu.add_feature("» Stunt Jump 23", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-979.28601, -2490.78, 13.7658))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-979.28601, -2490.78, 13.7658))
	end
end)

menu.add_feature("» Stunt Jump 24", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-861.13098, -2570.3501, 13.6374))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-861.13098, -2570.3501, 13.6374))
	end
end)

menu.add_feature("» Stunt Jump 25", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(-958.34802, -2766.3601, 13.5655))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-958.34802, -2766.3601, 13.5655))
	end
end)

menu.add_feature("» Stunt Jump 26", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(112.505, -2835.72, 5.6208501))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(112.505, -2835.72, 5.6208501))
	end
end)

menu.add_feature("» Stunt Jump 27", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(121.199, -2934.6599, 5.6206999))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(121.199, -2934.6599, 5.6206999))
	end
end)

menu.add_feature("» Stunt Jump 28", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(108.41, -3198.23, 5.6211901))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(108.41, -3198.23, 5.6211901))
	end
end)

menu.add_feature("» Stunt Jump 29", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(167.32401, -2975.76, 5.51331))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(167.32401, -2975.76, 5.51331))
	end
end)

menu.add_feature("» Stunt Jump 30", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(165.586, -2790.3799, 5.6211901))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(165.586, -2790.3799, 5.6211901))
	end
end)

menu.add_feature("» Stunt Jump 31", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(290.285, -3026.49, 5.5140901))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(290.285, -3026.49, 5.5140901))
	end
end)

menu.add_feature("» Stunt Jump 32", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(661.23199, -3006.3201, 5.6663299))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(661.23199, -3006.3201, 5.6663299))
	end
end)

menu.add_feature("» Stunt Jump 33", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(797.10303, -2909.6799, 5.5219598))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(797.10303, -2909.6799, 5.5219598))
	end
end)

menu.add_feature("» Stunt Jump 34", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(351.54999, -2636.1101, 5.84267))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(351.54999, -2636.1101, 5.84267))
	end
end)

menu.add_feature("» Stunt Jump 35", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(357.897, -2527.0701, 5.5422001))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(357.897, -2527.0701, 5.5422001))
	end
end)

menu.add_feature("» Stunt Jump 36", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(96.472603, -2190.96, 5.6231499))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(96.472603, -2190.96, 5.6231499))
	end
end)

menu.add_feature("» Stunt Jump 37", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(1.98053, -1039.3101, 37.7728))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1.98053, -1039.3101, 37.7728))
	end
end)

menu.add_feature("» Stunt Jump 38", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(392.56299, -1664.45, 47.923199))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(392.56299, -1664.45, 47.923199))
	end
end)

menu.add_feature("» Stunt Jump 39", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(1488.09, -2210.3, 77.236298))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1488.09, -2210.3, 77.236298))
	end
end)

menu.add_feature("» Stunt Jump 40", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(442.29001, -1369.53, 43.174702))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(442.29001, -1369.53, 43.174702))
	end
end)

menu.add_feature("» Stunt Jump 41", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(381.50101, -1155.12, 28.9123))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(381.50101, -1155.12, 28.9123))
	end
end)

menu.add_feature("» Stunt Jump 42", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(42.694099, -778.81799, 43.7663))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(42.694099, -778.81799, 43.7663))
	end
end)

menu.add_feature("» Stunt Jump 43", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(303.19, -618.37402, 43.0714))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(303.19, -618.37402, 43.0714))
	end
end)

menu.add_feature("» Stunt Jump 44", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(562.64697, -583.00403, 43.9062))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(562.64697, -583.00403, 43.9062))
	end
end)

menu.add_feature("» Stunt Jump 45", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(1994.6, 1927.27, 91.719498))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1994.6, 1927.27, 91.719498))
	end
end)

menu.add_feature("» Stunt Jump 46", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(1783.12, 2057.2, 65.891502))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1783.12, 2057.2, 65.891502))
	end
end)

menu.add_feature("» Stunt Jump 47", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(1677.28, 2325.4099, 75.303299))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1677.28, 2325.4099, 75.303299))
	end
end)

menu.add_feature("» Stunt Jump 48", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(1681.84, 3144.8899, 43.474701))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1681.84, 3144.8899, 43.474701))
	end
end)

menu.add_feature("» Stunt Jump 49", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(1638.65, 3607.1101, 35.092499))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1638.65, 3607.1101, 35.092499))
	end
end)

menu.add_feature("» Stunt Jump 50", "action", localparents["» Stunt Jumps"].id, function(f)
	if player.is_player_in_any_vehicle(player.player_id()) then
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), v3(3343.3799, 5151.73, 18.405001))
	else
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(3343.3799, 5151.73, 18.405001))
	end
end)

--

menu.add_feature("» Custom Freemode Message", "toggle", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
		local input_stat, input_val = input.get("Title", "", 999, 0)
   		if input_stat == 1 then
   		    return HANDLER_CONTINUE
   		end
    	if input_stat == 2 then
        	f.on = false
        	return HANDLER_POP
    	end

    	custom_freemode_message_scaleform = graphics.request_scaleform_movie("mp_big_message_freemode")
    	while f.on do
			system.yield(0)
    		graphics.begin_scaleform_movie_method(custom_freemode_message_scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    		graphics.draw_scaleform_movie_fullscreen(custom_freemode_message_scaleform, 255, 255, 255, 255, 0)
    	 	graphics.scaleform_movie_method_add_param_texture_name_string(input_val)
    	 	graphics.end_scaleform_movie_method(custom_freemode_message_scaleform)
		end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(custom_freemode_message_scaleform)
    end
end)

menu.add_feature("» Custom Midsized Freemode Message", "toggle", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
		local input_stat, input_val = input.get("Title", "", 999, 0)
   		if input_stat == 1 then
   		    return HANDLER_CONTINUE
   		end
    	if input_stat == 2 then
        	f.on = false
        	return HANDLER_POP
    	end

    	custom_midsized_freemode_message_scaleform = graphics.request_scaleform_movie("MIDSIZED_MESSAGE")
    	while f.on do
			system.yield(0)
    		graphics.begin_scaleform_movie_method(custom_midsized_freemode_message_scaleform, "SHOW_COND_SHARD_MESSAGE")
    		graphics.draw_scaleform_movie_fullscreen(custom_midsized_freemode_message_scaleform, 255, 255, 255, 255, 0)
    	 	graphics.scaleform_movie_method_add_param_texture_name_string(input_val)
    	 	graphics.end_scaleform_movie_method(custom_midsized_freemode_message_scaleform)
		end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(custom_midsized_freemode_message_scaleform)
    end
end)

menu.add_feature("» Mission Failed", "toggle", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
		local input_stat, input_val = input.get("Text", "", 999, 0)
   		if input_stat == 1 then
   		    return HANDLER_CONTINUE
   		end
    	if input_stat == 2 then
        	f.on = false
        	return HANDLER_POP
    	end

    	mission_failed_scaleform = graphics.request_scaleform_movie("mp_big_message_freemode")
    	while f.on do
			system.yield(0)
    		graphics.begin_scaleform_movie_method(mission_failed_scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    		graphics.draw_scaleform_movie_fullscreen(mission_failed_scaleform, 255, 255, 255, 255, 0)
    	 	graphics.scaleform_movie_method_add_param_texture_name_string("~r~mission failed")
			 graphics.scaleform_movie_method_add_param_texture_name_string(input_val)
    	 	graphics.end_scaleform_movie_method(mission_failed_scaleform)
		end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(mission_failed_scaleform)
    end
end)

menu.add_feature("» Quit Mission", "toggle", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
		local input_stat, input_val = input.get("Text", "", 999, 0)
   		if input_stat == 1 then
   		    return HANDLER_CONTINUE
   		end
    	if input_stat == 2 then
        	f.on = false
        	return HANDLER_POP
    	end

    	mission_quit_scaleform = graphics.request_scaleform_movie("MISSION_QUIT")
    	while f.on do
			system.yield(0)
    		graphics.begin_scaleform_movie_method(mission_quit_scaleform, "SET_TEXT")
    		graphics.draw_scaleform_movie_fullscreen(mission_quit_scaleform, 255, 255, 255, 255, 0)
    	 	graphics.scaleform_movie_method_add_param_texture_name_string("Quit Mission")
			graphics.scaleform_movie_method_add_param_texture_name_string(input_val)
    	 	graphics.end_scaleform_movie_method(mission_quit_scaleform)
		end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(mission_quit_scaleform)
    end
end)

menu.add_feature("» Popup Warning", "value_str", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
    	popup_warning_scaleform = graphics.request_scaleform_movie("POPUP_WARNING")
    	while f.on do
			system.yield(0)
        	ui.draw_rect(0.5, 0.5, 1, 1, 0, 0, 0, 255)
        	graphics.begin_scaleform_movie_method(popup_warning_scaleform, "SHOW_POPUP_WARNING")
        	graphics.draw_scaleform_movie_fullscreen(popup_warning_scaleform, 255, 255, 255, 255, 0)
        	graphics.scaleform_movie_method_add_param_float(500.0)
        	graphics.scaleform_movie_method_add_param_texture_name_string("alert")
			if f.value == 0 then
        		graphics.scaleform_movie_method_add_param_texture_name_string("You have been banned from Grand Theft Auto Online permanently.\nReturn to Grand Theft Auto V.")
			elseif f.value == 1 then
				graphics.scaleform_movie_method_add_param_texture_name_string("You're attempting to access GTA Online servers with an altered version of the game.\nReturn to Grand Theft Auto V.")
			elseif f.value == 2 then
				graphics.scaleform_movie_method_add_param_texture_name_string("There has been an error with this session.\nReturn to Grand Theft Auto V.")
			elseif f.value == 3 then
				graphics.scaleform_movie_method_add_param_texture_name_string("You have been suspended from GTA Online until ".. os.date("%m/%d/%Y", os.time() + 2700000) ..". \nIn addition, your Grand Theft Auto Online characters(s) will be reset.\nReturn to Grand Theft Auto V.")
			end
       	 	graphics.end_scaleform_movie_method(popup_warning_scaleform)
    	end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(popup_warning_scaleform)
    end
end):set_str_data({
	"Banned",
	"Altered Game",
	"Session Error",
	"Suspended"
})

menu.add_feature("» Freemode Car Stats", "toggle", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
    	freemode_car_stats_scaleform = graphics.request_scaleform_movie("mp_car_stats_01")
    	while f.on do
			system.yield(0)
    		graphics.begin_scaleform_movie_method(freemode_car_stats_scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    		graphics.draw_scaleform_movie_fullscreen(freemode_car_stats_scaleform, 255, 255, 255, 255, 0)
			graphics.scaleform_movie_method_add_param_texture_name_string("RE-7B")
			graphics.scaleform_movie_method_add_param_texture_name_string("Tracked and Insured")
			graphics.scaleform_movie_method_add_param_texture_name_string("MPCarHUD")
			graphics.scaleform_movie_method_add_param_texture_name_string("Annis")
			graphics.scaleform_movie_method_add_param_texture_name_string("Top Speed")
			graphics.scaleform_movie_method_add_param_texture_name_string("Acceleration")
			graphics.scaleform_movie_method_add_param_texture_name_string("Braking")
			graphics.scaleform_movie_method_add_param_texture_name_string("Traction")
			graphics.scaleform_movie_method_add_param_int(68)
			graphics.scaleform_movie_method_add_param_int(60)
			graphics.scaleform_movie_method_add_param_int(40)
			graphics.scaleform_movie_method_add_param_int(70)
    	 	graphics.end_scaleform_movie_method(freemode_car_stats_scaleform)
		end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(freemode_car_stats_scaleform)
    end
end)

menu.add_feature("» Custom Stat Correction", "value_str", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
    	local input_stat, input_val = input.get("Type In Custom Integer", "", 999, 3)
    	if input_stat == 1 then
   	    	return HANDLER_CONTINUE
  		 end
    	if input_stat == 2 then
       		f.on = false
        	return HANDLER_POP
    	end

    	popup_warning_stat_correction_scaleform = graphics.request_scaleform_movie("POPUP_WARNING")
    	while f.on do
			system.yield(0)
        	ui.draw_rect(0.5, 0.5, 1, 1, 0, 0, 0, 255)
        	graphics.begin_scaleform_movie_method(popup_warning_stat_correction_scaleform, "SHOW_POPUP_WARNING")
        	graphics.draw_scaleform_movie_fullscreen(popup_warning_stat_correction_scaleform, 255, 255, 255, 255, 0)
       		graphics.scaleform_movie_method_add_param_float(500.0)
       		graphics.scaleform_movie_method_add_param_texture_name_string("alert")
			if f.value == 0 then
        		graphics.scaleform_movie_method_add_param_texture_name_string("Rockstar Game Services have corrected your GTA Dollars by $" .. input_val .. ".")
			elseif f.value == 1 then
				graphics.scaleform_movie_method_add_param_texture_name_string("Congratulations, you have been awarded $" .. input_val .. ".")
			elseif f.value == 2 then
				graphics.scaleform_movie_method_add_param_texture_name_string("Rockstar Game Services have corrected your RP levels to " .. input_val .. "RP.")
			end
        	graphics.end_scaleform_movie_method(popup_warning_stat_correction_scaleform)
   		end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(popup_warning_stat_correction_scaleform)
    end
end):set_str_data({
	"Money Correct",
	"Money Awarded",
	"RP Correct"
})

menu.add_feature("» Warehouse Select", "toggle", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
		warehouse_scaleform = graphics.request_scaleform_movie("WAREHOUSE")
    	while f.on do
        	graphics.begin_scaleform_movie_method(warehouse_scaleform, "SHOW_OVERLAY")
        	graphics.draw_scaleform_movie_fullscreen(warehouse_scaleform, 255, 255, 255, 255, 0)
			graphics.scaleform_movie_method_add_param_texture_name_string("Sex?")
			graphics.scaleform_movie_method_add_param_texture_name_string("Please choose one of the options below")
			graphics.scaleform_movie_method_add_param_texture_name_string("Yes")
			graphics.scaleform_movie_method_add_param_texture_name_string("Yes")
        	graphics.end_scaleform_movie_method(warehouse_scaleform)
        	system.wait(0)
   		end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(warehouse_scaleform)
    end
end)

menu.add_feature("» Custom Popup Warning Ban", "toggle", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
    	local input_stat, input_val = input.get("Type In Custom Ban Reason", "", 999, 0)
    	if input_stat == 1 then
        	return HANDLER_CONTINUE
    	end
    	if input_stat == 2 then
        	f.on = false
        	return HANDLER_POP
    	end

    	popup_warning_ban_reason_scaleform = graphics.request_scaleform_movie("POPUP_WARNING")
    	while f.on do
        	ui.draw_rect(0.5, 0.5, 1, 1, 0, 0, 0, 255)
        	graphics.begin_scaleform_movie_method(popup_warning_ban_reason_scaleform, "SHOW_POPUP_WARNING")
        	graphics.draw_scaleform_movie_fullscreen(popup_warning_ban_reason_scaleform, 255, 255, 255, 255, 0)
        	graphics.scaleform_movie_method_add_param_float(500.0)
        	graphics.scaleform_movie_method_add_param_texture_name_string("alert")
       		graphics.scaleform_movie_method_add_param_texture_name_string("You have been banned from Grand Theft Auto Online permanently.")
        	graphics.scaleform_movie_method_add_param_texture_name_string("Reason: " .. input_val .. "\n~w~Return to Grand Theft Auto V.")
        	graphics.end_scaleform_movie_method(popup_warning_ban_reason_scaleform)
        	system.wait(0)
   		end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(popup_warning_ban_reason_scaleform)
    end
end)

menu.add_feature("» Custom Popup Warning", "toggle", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
    	local input_stat, input_val = input.get("Type In Custom Text", "", 999, 0)
    	if input_stat == 1 then
        	return HANDLER_CONTINUE
    	end
    	if input_stat == 2 then
        	f.on = false
        	return HANDLER_POP
    	end

		popup_warning_custom_scaleform = graphics.request_scaleform_movie("POPUP_WARNING")
    	while f.on do
        	ui.draw_rect(0.5, 0.5, 1, 1, 0, 0, 0, 255)
        	graphics.begin_scaleform_movie_method(popup_warning_custom_scaleform, "SHOW_POPUP_WARNING")
        	graphics.draw_scaleform_movie_fullscreen(popup_warning_custom_scaleform, 255, 255, 255, 255, 0)
        	graphics.scaleform_movie_method_add_param_float(500.0)
        	graphics.scaleform_movie_method_add_param_texture_name_string("alert")
        	graphics.scaleform_movie_method_add_param_texture_name_string(input_val)
        	graphics.end_scaleform_movie_method(popup_warning_custom_scaleform)
        	system.wait(0)
   		end
	end
    if not f.on then
        graphics.set_scaleform_movie_as_no_longer_needed(popup_warning_custom_scaleform)
    end
end)

menu.add_feature("» Blackscreen", "toggle", localparents["» Custom Scaleforms"].id, function(f)
	if f.on then
    	while f.on do
			system.yield(0)
        	ui.draw_rect(0.5, 0.5, 1, 1, 0, 0, 0, 255)
		end
	end
end)

--

feature["» Log Session Chat"] = menu.add_feature("» Log Session Chat", "toggle", localparents["» Chat Logger"].id, function(f)
	if f.on then
        settings["» Log Session Chat"] = true
    end
    if not f.on then
		settings["» Log Session Chat"] = false
    end
end)
feature["» Log Session Chat"].on = settings["» Log Session Chat"]

feature["» Log Session Change"] = menu.add_feature("» Log Session Change", "toggle", localparents["» Chat Logger"].id, function(f)
    if f.on then
		settings["» Log Session Change"] = true
	end
	if not f.on then
		settings["» Log Session Change"] = false
    end
end)
feature["» Log Session Change"].on = settings["» Log Session Change"]

feature["» Notify Sent Messages"] = menu.add_feature("» Notify Sent Messages", "toggle", localparents["» Chat Logger"].id, function(f)
    if f.on then
		settings["» Notify Sent Messages"] = true
	end
	if not f.on then
		settings["» Notify Sent Messages"] = false
    end
end)
feature["» Notify Sent Messages"].on = settings["» Notify Sent Messages"]

menu.add_feature("» Clear Chat Log", "action", localparents["» Chat Logger"].id, function(f)
	local input_stat, input_val = input.get("Are You Sure? This Process Cannot Be Undone! Type \"Yes\" To Continue..", "", 3, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
		menu.notify("[!] Cancelled!", Meteor, 3, 211)
        return HANDLER_POP
    end
	if input_val == "Yes" then
    	if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\Logs\\", "") .. "\\Chat.log") then
    	    menu.notify("[!] Cleared Chat Log.", Meteor)
    	    utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\Logs\\", "") .. "\\Chat.log", "w"), "")
    	else
    	    menu.notify("[!] Chat log doesn't exist.")
		end
    end
end)

--

local all_settings = {
	"» Dragon Breath",
	"» Dragon Breath Scale",
	"» Fire Wings",
	"» Fire Wings Scale",
	"» Sparks",
	"» Sparks Gun Effects",
	"» Flames",
	"» Flames Gun Effects",
	"» Rapid Fire",
	"» Flamethrower",
	"» Flamethrower Scale",
	"» Delete Gun",
	"» Airstrike Gun",
	"» Smoke Bomb Gun",
	"» Smoke Bomb Gun Scale",
	"» Hands Up",
	"» Shoot Weapon Objects",
	"» Shoot Custom Objects",
	"» Shoot Fake Money Bags",
	"» Shoot Stones",
	"» 40.000 KW Basskanone",
	"» Call Kamikaze Attack",
	"» Shoot Dogshit",
	"» Shoot Missiles",
	"» Player Info Tab",
	"» Tab 1 X Position",
	"» Tab 2 X Position",
	"» Tab 1 Y Position",
	"» Tab 2 Y Position",
	"» Tab 1 Alpha",
	"» Tab 2 Alpha",
	"» Notify Session Host Migrations",
	"» Notify Script Host Migrations",
	"» Notify Typing Players",
	"» Guided Missile Tracker",
	"» Kill Tracker",
	"» Anti Barcode",
	"» Anti Chat Spammer",
	"» Notify Orbital Cannon Room Events",
	"» Disable Weapons",
	"» For Players In Range",
	"» Auto Kick All Modders",
	"» Modder Manual",
	"» Modder Player Model",
	"» Modder SCID Spoof",
	"» Modder Invalid Object",
	"» Modder Invalid Ped Crash",
	"» Modder Model Change Crash",
	"» Modder Player Model Change",
	"» Modder RAC",
	"» Modder Money Drop",
	"» Modder SEP",
	"» Modder Attach Object",
	"» Modder Attach Ped",
	"» Modder Net Array Crash",
	"» Modder Net Sync Crash",
	"» Modder Net Event Crash",
	"» Modder Altered Host Token",
	"» Modder SE Spam",
	"» Modder Invalid Vehicle",
	"» Modder Frame Flags",
	"» Modder IP Spoof",
	"» Modder Karen",
	"» Modder Session Mismatch",
	"» Modder Sound Spam",
	"» No Fly Zones",
	"» Exclude Yourself From No Fly Zones",
	"» Exclude Friends From No Fly Zones",
	"» Bouncy Vehicles",
	"» Zero Gravity Vehicles",
	"» Reduce Vehicle Grip",
	"» City Riot",
	"» Launch Random Vehicles",
	"» Display OS Time",
	"» Quick Entity Actions",
	"» Entity Debug Info",
	"» No Entity Collision",
	"» Disable Vehicle Spawning",
	"» Disable Ped Spawning",
	"» Nearby Peds Godmode",
	"» Nearby Vehicles Godmode",
	"» Lock All Vehicle Doors",
	"» Heli Blades Speed",
	"» Reduce Grip",
	"» Bouncy Vehicle",
	"» Extra Bombs For Planes",
	"» Vehicle Fly",
	"» Demolition Boost",
	"» Low Pitch Warning",
	"» High Bank Angle Warning",
	"» Engine Warning",
	"» Fire Warning",
	"» Stall Warning",
	"» Terrain Warning",
	"» Collision Notify",
	"» Runway Tracker",
	"» Information Display",
	"» Air Traffic",
	"» Invalid SCID Detection",
	"» Modded Health Detection",
	"» Godmode Detection",
	"» Invalid Name Detection",
	"» Invalid IP Detection",
	"» Bad Script Event Detection",
	"» Bad Net Event Detection",
	"» Stand User Detection",
	"» Max Speed Bypass Detection",
	"» Invalid Stats Detection",
	"» Chat Spoof Notification",
	"» Session Host Crash Detection",
	"» Bad Outfit Data Detection",
	"» Altered Script Host Migration Detection",
	"» Fake Typing Indicator Detection",
	"» Modded Spectate Detection",
	"» Modded OTR Detection",
	"» Rockstar Admin Notification",
	"» Exclude Friends From Detections",
	"» Exclude Whitelisted Players From Detections",
	"» Auto Waypoint Tp",
	"» Log Session Chat",
	"» Log Session Change",
	"» Notify Sent Messages",
	"» Display Welcome Screen"
}

local all_feature_value_settings = {
	"» Airstrike Gun",
	"» Hands Up",
	"» Shoot Weapon Objects",
	"» Shoot Custom Objects",
	"» Shoot Fake Money Bags",
	"» Shoot Stones",
	"» Shoot Dogshit",
	"» Anti Chat Spammer",
	"» Russian Roulette",
	"» Random Player",
	"» For Players In Range",
	"» Out Of Control",
	"» Rockstar Chat Global",
	"» Rockstar Chat Team",
	"» Spawn Custom Entity (Hex)",
	"» Spawn Custom Entity (Dec)",
	"» Spawn Custom Entity (Model)",
	"» Vehicle Fly",
	"» Invalid SCID Detection",
	"» Modded Health Detection",
	"» Godmode Detection",
	"» Invalid Name Detection",
	"» Invalid IP Detection",
	"» Bad Net Event Detection",
	"» Bad Script Event Detection",
	"» Stand User Detection",
	"» Max Speed Bypass Detection",
	"» Invalid Stats Detection",
	"» Session Host Crash Detection",
	"» Bad Outfit Data Detection",
	"» Altered Script Host Migration Detection",
	"» Fake Typing Indicator Detection",
	"» Modded Spectate Detection",
	"» Modded OTR Detection"
}

for i = 0, 87 do
	table.insert(all_feature_value_settings, "» Net Event Responses " .. i .. "")
	table.insert(all_settings, "» Net Event Responses " .. i .. "")
end

menu.add_feature("» Save State", "action", localparents["» General"].id, function(f)
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "w"), "")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\FeatureValueSettings.lua", "w"), "")
	system.wait(500)
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "local settings = {}\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\FeatureValueSettings.lua", "a"), "local feature_value_settings = {}\n\n")
	for i = 1, #all_settings do
		utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"" .. all_settings[i] .. "\"] = " .. string.format("%s", settings[all_settings[i]]) .. "\n\n")
		system.wait(0)
	end
	for i = 1, #all_feature_value_settings do
		utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\FeatureValueSettings.lua", "a"), "feature_value_settings[\"" .. all_feature_value_settings[i] .. "\"] = " .. string.format("%s", feature_value_settings[all_feature_value_settings[i]]) .. "\n\n")
		system.wait(0)
	end
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "return settings")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\FeatureValueSettings.lua", "a"), "return feature_value_settings")
	system.wait(100)
	menu.notify("[!] Successfully saved config to settings!", Meteor, 3, 0x00ff00)
end)

menu.add_feature("» Reset Settings", "action", localparents["» General"].id, function(f)
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "w"), "")
	system.wait(500)
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "local settings = {}\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Dragon Breath\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Dragon Breath Scale\"] = 0.3\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Fire Wings\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Fire Wings Scale\"] = 0.2\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Sparks\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Sparks Gun Effects\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Flames\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Flames Gun Effects\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Rapid Fire\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Flamethrower\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Flamethrower Scale\"] = 2.5\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Delete Gun\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Airstrike Gun\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Smoke Bomb Gun\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Smoke Bomb Gun Scale\"] = 10\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Hands Up\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Shoot Weapon Objects\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Shoot Custom Objects\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Shoot Fake Money Bags\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Shoot Stones\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» 40.000 KW Basskanone\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Call Kamikaze Attack\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Shoot Dogshit\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Shoot Missiles\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Player Info Tab\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Tab 1 X Position\"] = 35\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Tab 2 X Position\"] = 65\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Tab 1 Y Position\"] = 0\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Tab 2 Y Position\"] = 0\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Tab 1 Alpha\"] = 255\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Tab 2 Alpha\"] = 255\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Notify Session Host Migrations\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Notify Script Host Migrations\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Notify Typing Players\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Guided Missile Tracker\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Kill Tracker\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Anti Barcode\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Anti Chat Spammer\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Notify Orbital Cannon Room Events\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Disable Weapons\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» For Players In Range\"] = false\n\n")
	for i = 0, 87 do
		utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Net Event Responses " .. i .. "\"] = false\n\n")
	end
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Auto Kick All Modders\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Manual\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Player Model\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder SCID Spoof\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Invalid Object\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Invalid Ped Crash\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Model Change Crash\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Player Model Change\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder RAC\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Money Drop\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder SEP\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Attach Object\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Attach Ped\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Net Array Crash\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Net Sync Crash\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Net Event Crash\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Altered Host Token\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder SE Spam\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Invalid Vehicle\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Frame Flags\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder IP Spoof\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Karen\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Session Mismatch\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modder Sound Spam\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» No Fly Zones\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Exclude Yourself From No Fly Zones\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Exclude Friends From No Fly Zones\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Bouncy Vehicles\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Zero Gravity Vehicles\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Reduce Vehicle Grip\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» City Riot\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Launch Random Vehicles\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Display OS Time\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Quick Entity Actions\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Entity Debug Info\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» No Entity Collision\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Disable Vehicle Spawning\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Disable Ped Spawning\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Nearby Peds Godmode\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Nearby Vehicles Godmode\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Lock All Vehicle Doors\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Heli Blades Speed\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Reduce Grip\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Bouncy Vehicle\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Extra Bombs For Planes\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Vehicle Fly\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Demolition Boost\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Low Pitch Warning\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» High Bank Angle Warning\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Engine Warning\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Fire Warning\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Stall Warning\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Terrain Warning\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Collision Notify\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Runway Tracker\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Information Display\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Air Traffic\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Invalid SCID Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modded Health Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Godmode Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Invalid Name Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Invalid IP Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Bad Script Event Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Bad Net Event Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Stand User Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Max Speed Bypass Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Invalid Stats Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Chat Spoof Notification\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Session Host Crash Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Bad Outfit Data Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Altered Script Host Migration Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Fake Typing Indicator Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modded Spectate Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Modded OTR Detection\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Rockstar Admin Notification\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Exclude Friends From Detections\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Exclude Whitelisted Players From Detections\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Auto Waypoint Tp\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Log Session Chat\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Log Session Change\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Notify Sent Messages\"] = false\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "settings[\"» Display Welcome Screen\"] = true\n\n")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\Settings.lua", "a"), "return settings")
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\FeatureValueSettings.lua", "w"), "")
	system.wait(500)
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\FeatureValueSettings.lua", "a"), "local feature_value_settings = {}\n\n")
	for i = 1, #all_feature_value_settings do
		utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\FeatureValueSettings.lua", "a"), "feature_value_settings[\"" .. all_feature_value_settings[i] .. "\"] = " .. 0 .. "\n\n")
		system.wait(0)
	end
	utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Meteor\\", "") .. "\\FeatureValueSettings.lua", "a"), "return feature_value_settings")
	system.wait(100)
	menu.notify("[!] Successfully reset settings!", Meteor, 3, 0x00ff00)
end)

feature["» Display Welcome Screen"] = menu.add_feature("» Display Welcome Screen", "toggle", localparents["» General"].id, function(f)
	if f.on then
        settings["» Display Welcome Screen"] = true
    end
    if not f.on then
		settings["» Display Welcome Screen"] = false
    end
end)
feature["» Display Welcome Screen"].on = settings["» Display Welcome Screen"]

localparents["» Settings Overview"] = menu.add_feature("» Settings Overview", "parent", localparents["» General"].id)

for i = 1, #all_settings do
	menu.add_feature(all_settings[i] .. ": " .. string.format("%s", settings[all_settings[i]]), "action", localparents["» Settings Overview"].id, function(f)
	end)
end

localparents["» Changelog"] = menu.add_feature("» Changelog", "parent", localparents["» General"].id)

menu.add_feature("» V0.5.1 - 246", "action", localparents["» Changelog"].id, function(f)
	menu.notify("+ Notify Orbital Cannon Room Events\n+ Net Event Responses [Parent]\n+ Guided Missile Tracker\n+ Anti Chat Spammer\n+ Rope Gun\n+ Session Sound Trolling\n\nAdded Player Features:\n+ Fake Collectible Drops [Parent]\n+ Send Orbital Strike")
	menu.notify("~ Minor Bug Fixes\n~ Reworked Some Stuff\n~ Updated Kick Method (Against Host);\n~ Improved Save State Feature;\n~ Some Code Cleanup;\n+ Added Some Additional Options For Detections;\n\nAdded Local Features:\n+ Modded Spectate Detection\n+ Modded OTR Detection", "Changelog V0.5.1 - 246")
end)

menu.add_feature("» V0.4.9 - 245", "action", localparents["» Changelog"].id, function(f)
	menu.notify("+ Altered Script Host Migration\n+ Fake Typing Indicator Detection\n+ Exclude Whitelisted Players From Detections\n+ Auto Kick Modders [Parent]\n+ Anti Barcode\n\nAdded Player Features:\n+ Add To Whitelist\n+ Modder Flag Notify\n+ Send To Brazil")
	menu.notify("~ Reworked Stand User Detection;\n+ Added Possible Executor To Chat Spoof Notification Detection;\n~ Minor Bug Fixes;\n~ Some Performance Improvements;\n\nAdded Local Features:\n+ Session Host Crash Detection\n+ Bad Outfit Data Detection", "Changelog V0.4.9 - 245")
end)

menu.add_feature("» V0.4.8 - 244", "action", localparents["» Changelog"].id, function(f)
	menu.notify("Added Player Feature:\n+ Freeze Camera")
	menu.notify("~ Some bug fixes;\n~ Minor changes for some features;\n\nAdded Local Features:\n+ Lock Outfit\n+ City Riot\n+ Entity Debug Info\n+ Aviation Tools [Parent]\n+ Custom Model Change\n+ B-19 Enola Gay Superfortress", "Changelog V0.4.8 - 244")
end)

menu.add_feature("» V0.4.7 - 243", "action", localparents["» Changelog"].id, function(f)
	menu.notify("+ Updated for Gta 1.59;\n~ Reworked some features;\n~ Fixed some issues with Chat Spoof Notification;\nAdded Setting: Display Welcome Screen;\n\nAdded Local Feature:\n+ Auto Waypoint Tp\nAdded Player Feature:\n+ Teleport To Waypoint (Vehicle)", "Changelog V0.4.7 - 243")
end)

menu.add_feature("» V0.4.6 - 242", "action", localparents["» Changelog"].id, function(f)
	menu.notify("~ Reworked and improved even more features;\n~ Un-Shitted some code;\n\nAdded Local Features:\n+ WW2 Mode\n+ Kill Tracker\n+ Chat Spoof Notification\n+ Demolition Boost\n+ Ped Pickup Recovery\n+ Crash Session Host\n+ Reset Settings", "Changelog V0.4.6 - 242")
end)

menu.add_feature("» V0.4.5 - 241", "action", localparents["» Changelog"].id, function(f)
	menu.notify("~ Minor Bug Fixes;\n~ Reworked and Improved some features;\n\nAdded Player Features:\n+ Crash Car")
	menu.notify("Added Local Features:\n+ Call Kamikaze Attack\n+ Shoot Missiles\n+ Extra Bombs For Planes\n+ Money Yoinker 3000\n+ Max Speed Bypass\n+ Invalid IP\n+ Exclude Friends From Detections\n+ Launch Guided Missile", "Changelog V0.4.5 - 241")
end)

menu.add_feature("» V0.4.4 - 240", "action", localparents["» Changelog"].id, function(f)
	menu.notify("Crashes/Kicks:\n~ Sorted some stuff out\n+ Added 5G Tow Truck Crash\n+ Added Sound Spam Crash\n~ Fixed some args")
	menu.notify("Added Local Features:\n+ 40.000 KW Basskanone\n+ Ragdoll\n+ Vehicle Fly\n\nAdded Player Features:\n+ Send Karen\n+ Kamikaze Attack\n+ Glitch Wheels\n+ Attach Ladder\n+ Atomize\n+ Add To Spoofer Profiles", "Changelog V0.4.4 - 240")
end)

menu.add_feature("» V0.4.3 - 239", "action", localparents["» Changelog"].id, function(f)
	menu.notify("~ Reworked some features;\n~ More Bug Fixes;\n\nAdded Local Features:\n+ Changelog\n+ Get Session Host\n+ Kick Random Player\n+ Shoot Stones\n+ Invalid Stats\n+ Force Leave Vehicle\n~ Small changes for Player Info Tab", "Changelog V0.4.2 - 239")
end)

menu.add_feature("» V0.4.2 - 238", "action", localparents["» Changelog"].id, function(f)
	menu.notify("~ Minor Bug Fixes", "Changelog V0.4.2 - 238")
end)

menu.add_feature("» V0.4.2 - 237", "action", localparents["» Changelog"].id, function(f)
	menu.notify("~ Un-Shitted Player Info Tab's Code\n~ Made Player Info Tab more customizeable\n+ Added Settings Overview", "Changelog V0.4.2 - 237")
end)

menu.add_feature("» V0.4.1 - 236", "action", localparents["» Changelog"].id, function(f)
	menu.notify("+ Added Save State for custom configs\n~ Reworked some stuff\n+ Finally gave it a name", "Changelog V0.4.1 - 236")
end)

--

menu.add_player_feature("» Set Bounty", "action_value_str", playerparents["» Script Events"], function(f, pid)
    local input_stat, input_val = input.get("Enter Bounty Amount (0-10000)", "", 5, 3)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(0x4D3010A8, pid, {player.player_id(), pid, 1, input_val, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script_func.get_global_9(), script_func.get_global_10()})
		end
		if f.value == 1 then
			script.trigger_script_event(0x4D3010A8, pid, {player.player_id(), pid, 1, input_val, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script_func.get_global_9(), script_func.get_global_10()})
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"Anonymous",
	"Named"
})

menu.add_player_feature("» Send To Perico", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(-621279188, pid, {player.player_id(), 1})
		elseif f.value == 1 then
			script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		elseif f.value == 2 then
			script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3"
})

menu.add_player_feature("» Send To Brazil", "action", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		utilities.send_to_brazil(pid)
		menu.notify("Successfully Sent Player To Brazil", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Send To Warehouse", "action", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(-446275082, pid, {player.player_id(), 0, 1, math.random(1, 22)})
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Send To Mission", "action", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x786FBAAE, pid, {player.player_id(), math.random(1, 7)})
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Force Casino Cutscene", "action", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x3FAC59CA, pid, {player.player_id()})
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Infinite Loading Screen", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(603406648, pid, {player.player_id(), 217})
		elseif f.value == 1 then
			script.trigger_script_event(962740265, pid, {player.player_id(), math.random(1, 12)})
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Cash Removed Notification", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if f.value == 0 then
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 689178114, math.random(-2147483647, 2147483647)})
		else
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		end
	else
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 689178114, input_val})
		else
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_player_feature("» Cash Stolen Notification", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if f.value == 0 then
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 2187973097, math.random(-2147483647, 2147483647)})
		else
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		end
	elseif f.value == 1 then
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 2187973097, input_val})
		else
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_player_feature("» Cash Banked Notification", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if f.value == 0 then
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 1990572980, math.random(-2147483647, 2147483647)})
		else
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		end
	else
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x285DDF33, pid, {player.player_id(), 1990572980, input_val})
		else
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_player_feature("» Insurance Notification", "action_value_str", playerparents["» Script Events"], function(f, pid)
	if f.value == 0 then
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x2FCF970F, pid, {player.player_id(), math.random(-2147483647, 2147483647)})
		else
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		end
	elseif f.value == 1 then
		local input_stat, input_val = input.get("Enter The Amount Of Money (0 - 2147483647)", "", 10, 0)
		if input_stat == 1 then
			return HANDLER_CONTINUE
		end
		if input_stat == 2 then
			return HANDLER_POP
		end
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x2FCF970F, pid, {player.player_id(), input_val})
		else
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		end
	end
end):set_str_data({
	"Random",
	"Input"
})

menu.add_player_feature("» Freeze Camera", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(1463943751, pid, {player.player_id()})
		else
			f.on = false
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
			return
		end
	end
end)

menu.add_player_feature("» Camera Manipulation", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x2FC154DC, pid, {player.player_id(), 869796886, 0})
		else
			f.on = false
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
			return
		end
	end
end)

menu.add_player_feature("» Bribe Authorities", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x66B0F59A, pid, {player.player_id(), 0, 0, utils.time_ms(), 0, script_func.get_global_main(pid)})
			system.wait(5000)
		else
			f.on = false
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
			return
		end
	end
end)

menu.add_player_feature("» Off The Radar", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(-0x1757DB60, pid, {player.player_id(), utils.time() - 60, utils.time(), 1, 1, script_func.get_global_main(pid)})
			system.wait(5000)
		else
			f.on = false
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
			return
		end
	end
end)

menu.add_player_feature("» Transaction Error", "toggle", playerparents["» Script Events"], function(f, pid)
	if f.on then
		while f.on do
			system.yield(0)
			if player.is_player_valid(pid) then
				script.trigger_script_event(-0x659322C8, pid, {player.player_id(), 50000, 0, 1, script_func.get_global_main(pid), script_func.get_global_9(), script_func.get_global_10(), 1})
			else
				f.on = false
				menu.notify("[!] Invalid Player.", Meteor, 3, 211)
				return
			end
		end
	end
end)

menu.add_player_feature("» Block Passive Mode", "toggle", playerparents["» Script Events"], function(f, pid)
	while f.on do
		system.yield(0)
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x4267B065, pid, {player.player_id(), 1})
			system.wait(500)
		else
			f.on = false
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
			return
		end
	end
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x4267B065, pid, {player.player_id(), 0})
	else
		f.on = false
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		return
	end
end)

playerparents["» Vehicle Related"] = menu.add_player_feature("» Vehicle Related", "parent", playerparents["» Script Events"]).id

menu.add_player_feature("» Disable Ability To Drive", "action", playerparents["» Vehicle Related"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x23F74138, pid, {player.player_id(), 2, 4294967295, 1, 115, 0, 0, 0})
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Vehicle Kick", "action", playerparents["» Vehicle Related"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x2280A552, pid, {player.player_id(), 4294967295, 4294967295, 4294967295})
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Vehicle EMP", "action", playerparents["» Vehicle Related"], function(f, pid)
	if player.is_player_valid(pid) then
		local pos = player.get_player_coords(pid)
		script.trigger_script_event(-0x79C49B6C, pid, {player.player_id(), utilities.to_int(pos.x), utilities.to_int(pos.y), utilities.to_int(pos.z), 0})
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Destroy Personal Vehicle", "action", playerparents["» Vehicle Related"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(-0x3D33889E, pid, {player.player_id(), pid})
		script.trigger_script_event(0x2280A552, pid, {player.player_id(), 4294967295, 4294967295, 4294967295})
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

playerparents["» Apartment Invites"] = menu.add_player_feature("» Apartment Invites", "parent", playerparents["» Script Events"]).id

menu.add_player_feature("» Infinite Apartment Invite", "action", playerparents["» Apartment Invites"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x23F74138, pid, {player.player_id(), pid, 4294967295, 1, 115, 0, 0, 0})
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Random Apartment Invite", "action", playerparents["» Apartment Invites"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x23F74138, pid, {player.player_id(), pid, 1, 0, math.random(1, 114), 1, 1, 1})
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Apartment Invite Loop", "toggle", playerparents["» Apartment Invites"], function(f, pid)
	while f.on do
		if player.is_player_valid(pid) then
			script.trigger_script_event(0x23F74138, pid, {player.player_id(), pid, 1, 0, math.random(1, 114), 1, 1, 1})
			system.wait(5000)
		else
			menu.notify("[!] Invalid Player.", Meteor, 3, 211)
		end
	end
end)

--

menu.add_player_feature("» Lazer Beam On Player", "action", playerparents["» Malicious"], function(f, pid)
	local player_pos = player.get_player_coords(pid)
	local maxz = player.get_player_coords(player.player_id()).z + 120
	for i = maxz, -50, -2 do
		local pos = v3(player_pos.x, player_pos.y, i)
		pos.x = math.floor(pos.x)
		pos.y = math.floor(pos.y)
		pos.z = math.floor(pos.z)
		fire.add_explosion(pos + v3(0, 0, 0), 8, true, false, 1, 0)
		fire.add_explosion(pos + v3(0, 0, 0), 59, false, false, 1, 0)
		for x = 1, 4 do
			pos.x = math.random(pos.x - 1, pos.x + 1)
			pos.y = math.random(pos.y - 1, pos.y + 1)
			fire.add_explosion(pos, 8, false, false, 1, 0)
		end
		pos.x = math.random(pos.x - 4, pos.x + 4)
		pos.y = math.random(pos.y - 4, pos.y + 4)
		fire.add_explosion(pos, 8, false, false, 1, 0)
		system.wait(0)
	end
end)

menu.add_player_feature("» Send Orbital Strike", "action", playerparents["» Malicious"], function(f, pid)
	graphics.set_next_ptfx_asset("scr_xm_orbital")
	while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
		graphics.request_named_ptfx_asset("scr_xm_orbital")
		system.wait(0)
	end
	audio.play_sound_from_coord(1, "DLC_XM_Explosions_Orbital_Cannon", player.get_player_coords(pid), 0, true, 0, false)
	fire.add_explosion(player.get_player_coords(pid), 59, true, false, 1, player.get_player_ped(player.player_id()))
	graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", player.get_player_coords(pid), v3(0, 180, 0), 1, true, true, true)
end)

menu.add_player_feature("» Send Airstrike", "action_value_str", playerparents["» Malicious"], function(f, pid)
	menu.create_thread(function()
		local pos = player.get_player_coords(pid)
		if f.value == 0 then
			for i = 1, 20 do
				gameplay.shoot_single_bullet_between_coords(pos + v3(math.random(-10, 10), math.random(-10, 10), 60), pos + v3(math.random(-10, 10), math.random(-10, 10), 0), 1000, gameplay.get_hash_key("weapon_airstrike_rocket"), player.get_player_ped(pid), true, false, 250)
				system.wait(200)
			end
		elseif f.value == 1 then
			gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 30), pos, 1000, gameplay.get_hash_key("weapon_airstrike_rocket"), player.get_player_ped(pid), true, false, 250)
		end
	end, nil)
end):set_str_data({
	"Cluster",
	"Single"
})

feature["» Smoke Bomb Scale"] = menu.add_player_feature("» Smoke Bomb", "action_slider", playerparents["» Malicious"], function(f, pid)
	graphics.set_next_ptfx_asset("scr_agencyheistb")
	while not graphics.has_named_ptfx_asset_loaded("scr_agencyheistb") do
		graphics.request_named_ptfx_asset("scr_agencyheistb")
		system.wait(0)
	end
	local smoke_bomb_scale = f.value
   	graphics.start_networked_particle_fx_non_looped_at_coord("scr_agency3b_elec_box", player.get_player_coords(pid), v3(60, 0, 0), smoke_bomb_scale, true, true, true)

    graphics.remove_named_ptfx_asset("scr_agencyheistb")
    ptfx_loaded = false
    ptfx_executed = false
end)
feature["» Smoke Bomb Scale"].max = 40
feature["» Smoke Bomb Scale"].min = 4
feature["» Smoke Bomb Scale"].mod = 4
feature["» Smoke Bomb Scale"].value = 20

menu.add_player_feature("» Russian Roulette", "action_value_str", playerparents["» Malicious"], function(f, pid)
	rndint = math.random(1, 6)
	if rndint == 3 then
		if f.value == 0 then
			fire.add_explosion(player.get_player_coords(pid), 0, false, true, 0, player.get_player_ped(pid))
		elseif f.value == 1 then
			if network.network_is_host() then
				network.network_session_kick_player(pid)
			elseif player.is_player_host(pid) and player.is_player_modder(pid, -1) then
				utilities.se_kick(pid)
			else
				network.force_remove_player(pid)
			end
		elseif f.value == 2 then
			if player.is_player_valid(pid) then
				script.trigger_script_event(1445703181, pid, {pid, pid, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), pid})
			else
				menu.notify("[!] Invalid Player.", Meteor, 3, 211)
			end
		end
		menu.notify("[!] Yeah shit")
	else
		menu.notify("[!] He was lucky!")
	end
end):set_str_data({
	"Kill",
	"Kick",
	"Crash"
})

menu.add_player_feature("» Money Bag Rain", "toggle", playerparents["» Malicious"], function(f, pid)
	while f.on do
		system.yield(25)
		menu.create_thread(function()
			fake_money_bags_rain = 1
			local object_ = object.create_object(2628187989, player.get_player_coords(pid) + v3(math.random(-30, 30), math.random(-30, 30), math.random(30, 40)), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -10, 0.0, 0.0, 0.0, true, true)
			system.wait(8000)
			entity.delete_entity(object_)
		end, nil)
	end
end)

menu.add_player_feature("» Rain Shit", "toggle", playerparents["» Malicious"], function(f, pid)
	if f.on then
		menu.create_thread(function()
			local object_ = object.create_object(2223607550, player.get_player_coords(pid) + v3(math.random(-20, 20), math.random(-20, 20), math.random(20, 30)), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -10, 0.0, 0.0, 0.0, true, true)
			system.wait(10000)
			entity.delete_entity(object_)
		end, nil)
	end
	system.wait(15)
	return HANDLER_CONTINUE
end)

menu.add_player_feature("» Disable Weapons", "toggle", playerparents["» Malicious"], function(f, pid)
    if f.on then
		if ai.is_task_active(player.get_player_ped(pid), 9) then
			network.request_control_of_entity(player.get_player_ped(pid))
			ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
		end
	end
    return HANDLER_CONTINUE
end)

menu.add_player_feature("» Ceo Money Loop", "value_str", playerparents["» Malicious"], function(f, pid)
	if f.on then
		if f.value == 0 then
			script.trigger_script_event(0x70AB59D5, pid, {pid, 10000, -1292453789, 0, script_func.get_global_main(pid), script_func.get_global_9(), script_func.get_global_10()})
			system.wait(120100)
		elseif f.value == 1 then
			script.trigger_script_event(0x70AB59D5, pid, {pid, 10000, -1292453789, 1, script_func.get_global_main(pid), script_func.get_global_9(), script_func.get_global_10()})
			system.wait(60100)
		elseif f.value == 2 then
			script.trigger_script_event(0x70AB59D5, pid, {pid, 30000, 198210293, 1, script_func.get_global_main(pid), script_func.get_global_9(), script_func.get_global_10()})
			system.wait(120100)
		end
	end
	return HANDLER_CONTINUE
end):set_str_data({
	"10K (Every 2 Min)",
	"10K (Every 60 Sec)",
	"30K (Every 2 Min)"
})

--

menu.add_player_feature("» Healthy Diet", "action", playerparents["» Trolling"], function(f, pid)
	for i = 1, 10 do
		menu.create_thread(function()
			local object_ = object.create_object(-2054442544, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 18) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.1, 0.0, 0.0, 0.0, true, true)
			system.wait(10000)
			entity.delete_entity(object_)
		end, nil)
		menu.create_thread(function()
			local object_ = object.create_object(1020618269, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 18) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.1, 0.0, 0.0, 0.0, true, true)
			system.wait(10000)
			entity.delete_entity(object_)
		end, nil)
			menu.create_thread(function()
			local object_ = object.create_object(-22826474, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 18) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.1, 0.0, 0.0, 0.0, true, true)
			system.wait(10000)
			entity.delete_entity(object_)
		end, nil)
		menu.create_thread(function()
			local object_ = object.create_object(-856584171, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 18) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.1, 0.0, 0.0, 0.0, true, true)
			system.wait(10000)
			entity.delete_entity(object_)
		end, nil)
		menu.create_thread(function()
			local object_ = object.create_object(-1898057898, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 18) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.1, 0.0, 0.0, 0.0, true, true)
			system.wait(10000)
			entity.delete_entity(object_)
		end, nil)
	end
end)

menu.add_player_feature("» Electrocute Player", "action", playerparents["» Trolling"], function(f, pid)
	gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid) + v3(0, 0, 2), player.get_player_coords(pid), 0, gameplay.get_hash_key("weapon_stungun"), player.get_player_ped(player.player_id()), true, false, 10000)
end)

menu.add_player_feature("» Atomize", "action", playerparents["» Trolling"], function(f, pid)
	for i = 1, 30 do
		fire.add_explosion(player.get_player_coords(pid) + v3(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2)), 70, true, false, 0.2, player.get_player_ped(pid))
		system.wait(math.random(0, 1))
	end
end)

menu.add_player_feature("» Send To Gas Chamber", "action", playerparents["» Trolling"], function(f, pid)
    menu.create_thread(function()
        ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
        local object_ = object.create_object(959275690, player.get_player_coords(pid) - v3(0, 0, 0.5), true, false)
        fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
        fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
        fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
		fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
        fire.add_explosion(player.get_player_coords(pid), 21, true, false, 0, pid)
        system.wait(14000)
        entity.delete_entity(object_)
    end, nil)
end)

menu.add_player_feature("» Send Karen", "action", playerparents["» Trolling"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		streaming.request_model(0xB5CF80E4)
		while not streaming.has_model_loaded(0xB5CF80E4) do
			system.wait(0)
		end

		local player_veh = player.get_player_vehicle(pid)
		network.request_control_of_entity(player.get_player_ped(pid))
		network.request_control_of_entity(player_veh)
		while not network.has_control_of_entity(player_veh) do
			network.request_control_of_entity(player_veh)
			system.wait(0)
		end
		system.wait(50)
		ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
		local ped_ = ped.create_ped(0, 0xB5CF80E4, player.get_player_coords(pid) + v3(0, 0, 10), player.get_player_heading(pid), true, false)
		network.request_control_of_entity(ped_)
		while not network.has_control_of_entity(ped_) do
			network.request_control_of_entity(ped_)
			system.wait(0)
		end
		ped.set_ped_combat_attributes(ped_, 3, false)
		ped.set_ped_into_vehicle(ped_, player_veh, -1)
		gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(ped_), entity.get_entity_coords(ped_), 0, gameplay.get_hash_key("weapon_pistol"), player.get_player_ped(pid), false, true, 100)
	else
		menu.notify("[!] The Player has to be in a vehicle!", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Kamikaze Attack", "action", playerparents["» Trolling"], function(f, pid)
	streaming.request_model(0xE75B4B1C)
	streaming.request_model(0xC5DD6967)

	while (not streaming.has_model_loaded(0xE75B4B1C)) do
		system.wait(0)
	end

	while (not streaming.has_model_loaded(0xC5DD6967)) do
		system.wait(0)
	end

	threads["» Kamikaze Attack"] = menu.create_thread(function()
		local vehicle_ = vehicle.create_vehicle(0xC5DD6967, player.get_player_coords(pid) + v3(math.random(-50, 50), math.random(-50, 50), math.random(30, 50)), 0, true, false)
		local ped_ = ped.create_ped(1, 0xE75B4B1C, player.get_player_coords(pid) + v3(math.random(-50, 50), math.random(-50, 50), math.random(50, 100)), 0, true, false)
		system.wait(10)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
		ped.set_ped_into_vehicle(ped_, vehicle_, -1)
		vehicle.control_landing_gear(vehicle_, 3)
		utilities.rotate_to_pos(vehicle_, player.get_player_coords(pid))
		system.wait(10)
		vehicle.set_vehicle_forward_speed(vehicle_, 60.0)
		system.wait(5000)
		utilities.hard_remove_entity(vehicle_)
		streaming.set_model_as_no_longer_needed(0xC5DD6967)
		streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	end, nil)
end)

menu.add_player_feature("» Send SMS", "action", playerparents["» Trolling"], function(f, pid)
	local input_stat, input_val = input.get("Enter SMS String", "", 999, 0)
    if input_stat == 1 then
        return HANDLER_CONTINUE
    end
    if input_stat == 2 then
        return HANDLER_POP
    end

	if player.is_player_valid(pid) then
		player.send_player_sms(pid, input_val)
	end
end)

menu.add_player_feature("» Make Nearby Peds Hostile", "toggle", playerparents["» Trolling"], function(f, pid)
	if f.on then
		local peds = utilities.get_table_of_entities(ped.get_all_peds(), 25, 100, true, true, player.get_player_coords(pid))
    	for i = 1, #peds do
			ped.set_ped_combat_ability(peds[i], 2)
			ped.set_ped_combat_attributes(peds[i], 5, true)
			ai.task_combat_ped(peds[i], player.get_player_ped(pid), 0, 16)
    	end
	end
	system.wait(100)
	return HANDLER_CONTINUE
end)

menu.add_player_feature("» Attach Ladder", "toggle", playerparents["» Trolling"], function(f, pid)
	if f.on then
		if objects["» Attach Ladder"] == nil then
			objects["» Attach Ladder"] = utilities.spawn_object(1803116220, player.get_player_coords(pid))
			entity.set_entity_collision(objects["» Attach Ladder"], false, false, false)
			entity.set_entity_visible(objects["» Attach Ladder"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end

		threads["» Attach Ladder"] = menu.create_thread(function()
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(objects["» Attach Ladder"], player.get_player_coords(pid))
			end
		end, nil)

		objects["» Attach Ladder 1"] = object.create_object(1888301071, player.get_player_coords(pid), true, false)
		entity.set_entity_collision(objects["» Attach Ladder 1"], false, false, false)
		entity.attach_entity_to_entity(objects["» Attach Ladder 1"], objects["» Attach Ladder"], 0, v3(1.55, 3.35, -1), v3(0, 0, 0), true, true, false, 0, false)
		entity.set_entity_visible(objects["» Attach Ladder 1"], false)
		objects["» Attach Ladder 2"] = object.create_object(1888301071, player.get_player_coords(pid), true, false)
		entity.set_entity_collision(objects["» Attach Ladder 2"], false, false, false)
		entity.attach_entity_to_entity(objects["» Attach Ladder 2"], objects["» Attach Ladder"], 0, v3(-1.55, -3.35, -1), v3(0, 0, 180), true, true, false, 0, false)
		entity.set_entity_visible(objects["» Attach Ladder 2"], false)
		objects["» Attach Ladder 3"] = object.create_object(1888301071, player.get_player_coords(pid), true, false)
		entity.set_entity_collision(objects["» Attach Ladder 3"], false, false, false)
		entity.attach_entity_to_entity(objects["» Attach Ladder 3"], objects["» Attach Ladder"], 0, v3(3.50, -1.90, -1), v3(0, 0, 270), true, true, false, 0, false)
		entity.set_entity_visible(objects["» Attach Ladder 3"], false)
		objects["» Attach Ladder 4"] = object.create_object(1888301071, player.get_player_coords(pid), true, false)
		entity.set_entity_collision(objects["» Attach Ladder 4"], false, false, false)
		entity.attach_entity_to_entity(objects["» Attach Ladder 4"], objects["» Attach Ladder"], 0, v3(-3.50, 1.90, -1), v3(0, 0, 90), true, true, false, 0, false)
		entity.set_entity_visible(objects["» Attach Ladder 4"], false)
	end
	if not f.on then
		if objects["» Attach Ladder"] then
			entity.delete_entity(objects["» Attach Ladder"])
			objects["» Attach Ladder"] = nil
		end
		if objects["» Attach Ladder 1"] then
			entity.delete_entity(objects["» Attach Ladder 1"])
			objects["» Attach Ladder 1"] = nil
		end
		if objects["» Attach Ladder 2"] then
			entity.delete_entity(objects["» Attach Ladder 2"])
			objects["» Attach Ladder 2"] = nil
		end
		if objects["» Attach Ladder 3"] then
			entity.delete_entity(objects["» Attach Ladder 3"])
			objects["» Attach Ladder 3"] = nil
		end
		if objects["» Attach Ladder 4"] then
			entity.delete_entity(objects["» Attach Ladder 4"])
			objects["» Attach Ladder 4"] = nil
		end
		if threads["» Attach Ladder"] then
			menu.delete_thread(threads["» Attach Ladder"])
		end
	end
end)

menu.add_player_feature("» Make Area Foggy", "toggle", playerparents["» Trolling"], function(f, pid)
	if f.on then
		graphics.set_next_ptfx_asset("core")
		while not graphics.has_named_ptfx_asset_loaded("core") do
			graphics.request_named_ptfx_asset("core")
			system.wait(0)
		end
		if objects["» Make Area Foggy 1"] == nil then
			objects["» Make Area Foggy 1"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(objects["» Make Area Foggy 1"], false, false, false)
			entity.set_entity_visible(objects["» Make Area Foggy 1"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 1"] == nil then
			ptfxs["» Make Area Foggy 1"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", objects["» Make Area Foggy 1"], v3(), v3(), 10)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 1"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(objects["» Make Area Foggy 1"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if objects["» Make Area Foggy 2"] == nil then
			objects["» Make Area Foggy 2"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(objects["» Make Area Foggy 2"], false, false, false)
			entity.set_entity_visible(objects["» Make Area Foggy 2"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 2"] == nil then
			ptfxs["» Make Area Foggy 2"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", objects["» Make Area Foggy 2"], v3(), v3(), 8)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 2"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(objects["» Make Area Foggy 2"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if objects["» Make Area Foggy 3"] == nil then
			objects["» Make Area Foggy 3"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(objects["» Make Area Foggy 3"], false, false, false)
			entity.set_entity_visible(objects["» Make Area Foggy 3"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 3"] == nil then
			ptfxs["» Make Area Foggy 3"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", objects["» Make Area Foggy 3"], v3(), v3(), 6)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 3"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(objects["» Make Area Foggy 3"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if objects["» Make Area Foggy 4"] == nil then
			objects["» Make Area Foggy 4"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(objects["» Make Area Foggy 4"], false, false, false)
			entity.set_entity_visible(objects["» Make Area Foggy 4"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 4"] == nil then
			ptfxs["» Make Area Foggy 4"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", objects["» Make Area Foggy 4"], v3(), v3(), 9)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 4"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(objects["» Make Area Foggy 4"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if objects["» Make Area Foggy 5"] == nil then
			objects["» Make Area Foggy 5"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(objects["» Make Area Foggy 5"], false, false, false)
			entity.set_entity_visible(objects["» Make Area Foggy 5"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 5"] == nil then
			ptfxs["» Make Area Foggy 5"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", objects["» Make Area Foggy 5"], v3(), v3(), 7)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 5"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(objects["» Make Area Foggy 5"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
		if objects["» Make Area Foggy 6"] == nil then
			objects["» Make Area Foggy 6"] = utilities.spawn_object(1803116220, player.get_player_coords(player.player_id()) + v3(0, 0, -1))
			entity.set_entity_collision(objects["» Make Area Foggy 6"], false, false, false)
			entity.set_entity_visible(objects["» Make Area Foggy 6"], false)
			streaming.set_model_as_no_longer_needed(1803116220)
		end
		if ptfxs["» Make Area Foggy 6"] == nil then
			ptfxs["» Make Area Foggy 6"] = graphics.start_networked_ptfx_looped_on_entity("exp_grd_grenade_smoke", objects["» Make Area Foggy 6"], v3(), v3(), 5)
			graphics.set_ptfx_looped_scale(ptfxs["» Make Area Foggy 6"], 6)
			while f.on do
				system.yield(0)
				utilities.set_entity_coords(objects["» Make Area Foggy 6"], player.get_player_coords(pid) + v3(0, 0, -1))
			end
		end
	end
	if not f.on then
		if ptfxs["» Make Area Foggy 1"] then
			utilities.clear_ptfx(objects["» Make Area Foggy 1"])
			objects["» Make Area Foggy 1"] = nil
			utilities.clear_ptfx(objects["» Make Area Foggy 2"])
			objects["» Make Area Foggy 2"] = nil
			utilities.clear_ptfx(objects["» Make Area Foggy 3"])
			objects["» Make Area Foggy 3"] = nil
			utilities.clear_ptfx(objects["» Make Area Foggy 4"])
			objects["» Make Area Foggy 4"] = nil
			utilities.clear_ptfx(objects["» Make Area Foggy 5"])
			objects["» Make Area Foggy 5"] = nil
			utilities.clear_ptfx(objects["» Make Area Foggy 6"])
			objects["» Make Area Foggy 6"] = nil
			ptfxs["» Make Area Foggy 1"] = nil
			ptfxs["» Make Area Foggy 2"] = nil
			ptfxs["» Make Area Foggy 3"] = nil
			ptfxs["» Make Area Foggy 4"] = nil
			ptfxs["» Make Area Foggy 5"] = nil
			ptfxs["» Make Area Foggy 6"] = nil
			graphics.remove_named_ptfx_asset("core")
		end
	end
end)

playerparents["» Fake Collectible Drops"] = menu.add_player_feature("» Fake Collectible Drops", "parent", playerparents["» Trolling"]).id

menu.add_player_feature("» Fake Money Bag Drop", "toggle", playerparents["» Fake Collectible Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake Money Bag Drop"] = menu.create_thread(function()
			local object_ = object.create_object(2628187989, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake Money Bag Drop"] then
			menu.delete_thread(threads["» Fake Money Bag Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake Money Bag", "action", playerparents["» Fake Collectible Drops"], function(f, pid)
	threads["» Drop Fake Money Bag 1"] = menu.create_thread(function()
		local object_ = object.create_object(2628187989, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake Money Bag 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake Money Bag 2"] then
			menu.delete_thread(threads["» Drop Fake Money Bag 2"])
		end
		if threads["» Drop Fake Money Bag 1"] then
			menu.delete_thread(threads["» Drop Fake Money Bag 1"])
		end
	end
end)

menu.add_player_feature("» Fake RP Drop", "toggle", playerparents["» Fake Collectible Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake RP Drop"] = menu.create_thread(function()
			local random_hash
			local random_int = math.random(1, 8)
			if random_int == 1 then
				random_hash = 1298470051
			elseif random_int == 2 then
				random_hash = 1955543594
			elseif random_int == 3 then
				random_hash = 446117594
			elseif random_int == 4 then
				random_hash = 1025210927
			elseif random_int == 5 then
				random_hash = 437412629
			elseif random_int == 6 then
				random_hash = 3644302825
			elseif random_int == 7 then
				random_hash = 601745115
			elseif random_int == 8 then
				random_hash = 2568981558
			end
			local object_ = object.create_object(random_hash, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "Bus_Schedule_Pickup", entity.get_entity_coords(object_), "DLC_PRISON_BREAK_HEIST_SOUNDS", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake RP Drop"] then
			menu.delete_thread(threads["» Fake RP Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake RP", "action", playerparents["» Fake Collectible Drops"], function(f, pid)
	threads["» Drop Fake RP 1"] = menu.create_thread(function()
		local random_hash
		local random_int = math.random(1, 8)
		if random_int == 1 then
			random_hash = 1298470051
		elseif random_int == 2 then
			random_hash = 1955543594
		elseif random_int == 3 then
			random_hash = 446117594
		elseif random_int == 4 then
			random_hash = 1025210927
		elseif random_int == 5 then
			random_hash = 437412629
		elseif random_int == 6 then
			random_hash = 3644302825
		elseif random_int == 7 then
			random_hash = 601745115
		elseif random_int == 8 then
			random_hash = 2568981558
		end
		local object_ = object.create_object(random_hash, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake RP 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "Bus_Schedule_Pickup", entity.get_entity_coords(object_), "DLC_PRISON_BREAK_HEIST_SOUNDS", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake RP 2"] then
			menu.delete_thread(threads["» Drop Fake RP 2"])
		end
		if threads["» Drop Fake RP 1"] then
			menu.delete_thread(threads["» Drop Fake RP 1"])
		end
	end
end)

menu.add_player_feature("» Fake Health Drop", "toggle", playerparents["» Fake Collectible Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake Health Drop"] = menu.create_thread(function()
			local object_ = object.create_object(678958360, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 and player.get_player_health(pid) < player.get_player_max_health(pid) then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake Health Drop"] then
			menu.delete_thread(threads["» Fake Health Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake Health", "action", playerparents["» Fake Collectible Drops"], function(f, pid)
	threads["» Drop Fake Health 1"] = menu.create_thread(function()
		local object_ = object.create_object(678958360, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake Health 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 and player.get_player_health(pid) < player.get_player_max_health(pid) then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake Health 2"] then
			menu.delete_thread(threads["» Drop Fake Health 2"])
		end
		if threads["» Drop Fake Health 1"] then
			menu.delete_thread(threads["» Drop Fake Health 1"])
		end
	end
end)

menu.add_player_feature("» Fake Armor Drop", "toggle", playerparents["» Fake Collectible Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake Armor Drop"] = menu.create_thread(function()
			local object_ = object.create_object(701173564, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 and player.get_player_armour(pid) < 50 then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake Armor Drop"] then
			menu.delete_thread(threads["» Fake Armor Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake Armor", "action", playerparents["» Fake Collectible Drops"], function(f, pid)
	threads["» Drop Fake Armor 1"] = menu.create_thread(function()
		local object_ = object.create_object(701173564, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake Armor 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 and player.get_player_armour(pid) < 50 then
						audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", entity.get_entity_coords(object_), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake Armor 2"] then
			menu.delete_thread(threads["» Drop Fake Armor 2"])
		end
		if threads["» Drop Fake Armor 1"] then
			menu.delete_thread(threads["» Drop Fake Armor 1"])
		end
	end
end)

menu.add_player_feature("» Fake P's & Q's Drop", "toggle", playerparents["» Fake Collectible Drops"], function(f, pid)
	while f.on do
		system.yield(60)
		threads["» Fake P's & Q's Drop"] = menu.create_thread(function()
			local object_ = object.create_object(1374501775, player.get_player_coords(pid) + v3(math.random(-2, 2) / 10, math.random(-2, 2) / 10, math.random(13, 14) / 10), true, true)
			entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
			while f.on do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "PICKUP_WEAPON_SMOKEGRENADE", entity.get_entity_coords(object_), "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
			system.wait(2000)
			entity.delete_entity(object_)
		end, nil)
	end
	if not f.on then
		if threads["» Fake P's & Q's Drop"] then
			menu.delete_thread(threads["» Fake P's & Q's Drop"])
		end
	end
end)

menu.add_player_feature("» Drop Fake P's & Q's", "action", playerparents["» Fake Collectible Drops"], function(f, pid)
	threads["» Drop Fake P's & Q's 1"] = menu.create_thread(function()
		local object_ = object.create_object(1374501775, player.get_player_coords(pid) + v3(0, 0, 1.5), true, true)
		entity.apply_force_to_entity(object_, 3, 0, 0, -0.5, 0.0, 0.0, 0.0, true, true)
		threads["» Drop Fake P's & Q's 2"] = menu.create_thread(function()
			while Meteor do
				system.yield(10)
				for pid = 0, 31 do
					if utilities.get_distance_between(player.get_player_ped(pid), object_) < 1.2 then
						audio.play_sound_from_coord(-1, "PICKUP_WEAPON_SMOKEGRENADE", entity.get_entity_coords(object_), "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET", true, 2, false)
						network.request_control_of_entity(object_)
						while not network.has_control_of_entity(object_) do
							network.request_control_of_entity(object_)
							system.wait(0)
						end
						entity.delete_entity(object_)
					end
				end
			end
		end, nil)
		system.wait(10000)
		entity.delete_entity(object_)
	end, nil)
	if not f.on then
		if threads["» Drop Fake P's & Q's 2"] then
			menu.delete_thread(threads["» Drop Fake P's & Q's 2"])
		end
		if threads["» Drop Fake P's & Q's 1"] then
			menu.delete_thread(threads["» Drop Fake P's & Q's 1"])
		end
	end
end)

--

playerparents["» Door Control"] = menu.add_player_feature("» Door Control", "parent", playerparents["» Vehicle"]).id

feature["» Door Open Player Vehicle"] = menu.add_player_feature("» Open Door", "action_value_i", playerparents["» Door Control"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		vehicle.set_vehicle_door_open(player.get_player_vehicle(pid), f.value - 1, false, true)
	else
		menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
	end
end)
feature["» Door Open Player Vehicle"].max = 8
feature["» Door Open Player Vehicle"].min = 1
feature["» Door Open Player Vehicle"].mod = 1
feature["» Door Open Player Vehicle"].value = 0

menu.add_player_feature("» Open All Player Vehicle Doors", "action", playerparents["» Door Control"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		for i = 1, 8 do
			vehicle.set_vehicle_door_open(player.get_player_vehicle(pid), i - 1, false, true)
		end
		system.wait(100)
		for i = 1, 8 do
			vehicle.set_vehicle_door_open(player.get_player_vehicle(pid), i - 1, false, true)
		end
	else
		menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Close All Player Vehicle Doors", "action", playerparents["» Door Control"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		for i = 1, 8 do
			vehicle.set_vehicle_doors_shut(player.get_player_vehicle(pid), i - 1, false, true)
		end
	else
		menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Lock All Player Vehicle Doors", "toggle", playerparents["» Door Control"], function(f, pid)
	if f.on then
		if player.is_player_in_any_vehicle(pid) then
			player_veh = player.get_player_vehicle(pid)
			vehicle.set_vehicle_doors_locked(player_veh, 4)
		else
			menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
			f.on = false
		end
	elseif not f.on then
		vehicle.set_vehicle_doors_locked(player_veh, 0)
	end
end)

menu.add_player_feature("» Hard Remove Vehicle", "action", playerparents["» Vehicle"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		local entity_ = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
		network.request_control_of_entity(entity_)
		entity.set_entity_collision(entity_, true, true, true)
		entity.set_entity_as_no_longer_needed(entity_)
		entity.set_entity_as_mission_entity(entity_, false, true)
		utilities.hard_remove_entity(entity_)
	else
		menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Modify Vehicle Speed", "action", playerparents["» Vehicle"], function(f, pid)
    local player_veh = player.get_player_vehicle(pid)
    if player.is_player_in_any_vehicle(pid) then
        local input_stat, input_val = input.get("Enter Modified Speed (1-10000)", "", 5, 3)

        if input_stat == 1 then
            return HANDLER_CONTINUE
        end
    
        if input_stat == 2 then
            return HANDLER_POP
        end

        if tonumber(input_val) < 1 or tonumber(input_val) > 10000 then
            menu.notify("[!] Invalid Input!", Meteor, 3, 211)
        end
        network.request_control_of_entity(player_veh)
        while not network.has_control_of_entity(player_veh) do
            network.request_control_of_entity(player_veh)
            system.wait(0)
        end
        entity.set_entity_max_speed(player_veh, input_val / 3.6)
        vehicle.modify_vehicle_top_speed(player_veh, input_val / 3.6)
		vehicle.set_vehicle_engine_torque_multiplier_this_frame(player_veh, input_val / 3.6)
    else
        menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Teleport To", "action_value_str", playerparents["» Vehicle"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		if f.value == 0 then
			network.request_control_of_entity(player.get_player_vehicle(pid))
			while not network.has_control_of_entity(player.get_player_vehicle(pid)) do
				network.request_control_of_entity(player.get_player_vehicle(pid))
				system.wait(0)
			end
			entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), utilities.offset_coords_forward(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), 5) + v3(0, 0, 1))
		elseif f.value == 1 then
			if ui.get_waypoint_coord().x ~= 16000 then
				network.request_control_of_entity(player.get_player_vehicle(pid))
				while not network.has_control_of_entity(player.get_player_vehicle(pid)) do
					network.request_control_of_entity(player.get_player_vehicle(pid))
					system.wait(0)
				end
				local previous_position = entity.get_entity_coords(player.get_player_vehicle(pid))
				local pos = v3(ui.get_waypoint_coord().x, ui.get_waypoint_coord().y, -100)
				entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), pos)
				system.wait(10)
				local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
				if not success then
					entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
					system.wait(10)
					local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
					if not success then
						entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
						system.wait(10)
						local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
						if not success then
							entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
							system.wait(10)
							local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
							if not success then
								entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
								system.wait(10)
								local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
								if not success then
									entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
									system.wait(10)
									local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
									if not success then
										entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
										system.wait(10)
										local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
										if not success then
											entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
											system.wait(10)
											local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
											if not success then
												entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
												system.wait(10)
												local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
												if not success then
													entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
													system.wait(10)
													local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
													if not success then
														entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
														system.wait(10)
														local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
														if not success then
															entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
															system.wait(10)
															local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
															if not success then
																entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																system.wait(10)
																local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
																if not success then
																	entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																	system.wait(10)
																	local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
																	if not success then
																		entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																		system.wait(10)
																		local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
																		if not success then
																			entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																			system.wait(10)
																			local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
																			if not success then
																				entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																				system.wait(10)
																				local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
																				if not success then
																					entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																					system.wait(10)
																					local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
																					if not success then
																						entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, player.get_player_coords(player.player_id()).z + 50))
																						system.wait(10)
																						local success, float = gameplay.get_ground_z(entity.get_entity_coords(player.get_player_vehicle(pid)))
																						if not success then
																							menu.notify("Teleportation Cancelled! Failed to get ground z!", Meteor, 3, 211)
																							entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), previous_position)
																						else
																							entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																							ui.set_waypoint_off()
																						end
																					else
																						entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																						ui.set_waypoint_off()
																					end
																				else
																					entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																					ui.set_waypoint_off()
																				end
																			else
																				entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																				ui.set_waypoint_off()
																			end
																		else
																			entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																			ui.set_waypoint_off()
																		end
																	else
																		entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																		ui.set_waypoint_off()
																	end
																else
																	entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																	ui.set_waypoint_off()
																end
															else
																entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
																ui.set_waypoint_off()
															end
														else
															entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
															ui.set_waypoint_off()
														end
													else
														entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
														ui.set_waypoint_off()
													end
												else
													entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
													ui.set_waypoint_off()
												end
											else
												entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
												ui.set_waypoint_off()
											end
										else
											entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
											ui.set_waypoint_off()
										end
									else
										entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
										ui.set_waypoint_off()
									end
								else
									entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
									ui.set_waypoint_off()
								end
							else
								entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
								ui.set_waypoint_off()
							end
						else
							entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
							ui.set_waypoint_off()
						end
					else
						entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
						ui.set_waypoint_off()
					end
				else
					entity.set_entity_coords_no_offset(player.get_player_vehicle(pid), v3(player.get_player_coords(player.player_id()).x, player.get_player_coords(player.player_id()).y, float + 1))
					ui.set_waypoint_off()
				end
			else
				menu.notify("[!] Waypoint not found.", Meteor, 3, 211)
			end
		end
	else
		menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
	end
end):set_str_data({
	"Me",
	"Waypoint"
})

menu.add_player_feature("» Kill Engine", "action", playerparents["» Vehicle"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		network.request_control_of_entity(player.get_player_vehicle(pid))
		while not network.has_control_of_entity(player.get_player_vehicle(pid)) do
			network.request_control_of_entity(player.get_player_vehicle(pid))
			system.wait(0)
		end
		vehicle.set_vehicle_engine_health(player.get_player_vehicle(pid), -1)
	else
		menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Repair Vehicle", "action", playerparents["» Vehicle"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		network.request_control_of_entity(player.get_player_vehicle(pid))
		while not network.has_control_of_entity(player.get_player_vehicle(pid)) do
			network.request_control_of_entity(player.get_player_vehicle(pid))
			system.wait(0)
		end
		vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), false)
		local entity_velocity = entity.get_entity_velocity(player.get_player_vehicle(pid))
		vehicle.set_vehicle_fixed(player.get_player_vehicle(pid))
		vehicle.set_vehicle_engine_health(player.get_player_vehicle(pid), 1000)
		vehicle.set_vehicle_engine_on(player.get_player_vehicle(pid), true, true, true)
		if entity.is_entity_on_fire(player.get_player_vehicle(pid)) then
			fire.stop_entity_fire(player.get_player_vehicle(pid))
		end
		entity.set_entity_velocity(player.get_player_vehicle(pid), entity_velocity)
	else
		menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash Car", "action", playerparents["» Vehicle"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		streaming.request_model(165521376)
		while not streaming.has_model_loaded(165521376) do
			streaming.request_model(165521376)
			system.wait(0)
		end
		local object_ = object.create_object(165521376, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), true, false)
		entity.set_entity_rotation(object_, v3(0, 0, entity.get_entity_rotation(player.get_player_vehicle(pid)).z + 90))
		entity.set_entity_visible(object_, false)
		system.wait(2000)
		entity.delete_entity(object_)
	else
		menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Glitch Wheels", "action", playerparents["» Vehicle"], function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		network.request_control_of_entity(player.get_player_vehicle(pid))
		while not network.has_control_of_entity(player.get_player_vehicle(pid)) do
			network.request_control_of_entity(player.get_player_vehicle(pid))
			system.wait(0)
		end
		local veh_topspeed = vehicle.get_vehicle_estimated_max_speed(player.get_player_vehicle(pid))
		for i = 1, 6 do
			vehicle.set_vehicle_engine_health(player.get_player_vehicle(pid), -1)
			vehicle.set_vehicle_wheel_health(player.get_player_vehicle(pid), 0, -1)
			vehicle.modify_vehicle_top_speed(player.get_player_vehicle(pid), -1)
			vehicle.set_vehicle_forward_speed(player.get_player_vehicle(pid), -1)
			system.wait(25)
			vehicle.modify_vehicle_top_speed(player.get_player_vehicle(pid), 9999999999999999999999999)
			vehicle.set_vehicle_forward_speed(player.get_player_vehicle(pid), 999999999999999999999999)
			system.wait(25)
			vehicle.set_vehicle_wheel_health(player.get_player_vehicle(pid), 0, 1)
			vehicle.modify_vehicle_top_speed(player.get_player_vehicle(pid), veh_topspeed)
			vehicle.set_vehicle_forward_speed(player.get_player_vehicle(pid), 0)
		end
		system.wait(200)
		vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), false)
		local entity_velocity = entity.get_entity_velocity(player.get_player_vehicle(pid))
		vehicle.set_vehicle_fixed(player.get_player_vehicle(pid))
		vehicle.set_vehicle_engine_health(player.get_player_vehicle(pid), 1000)
		vehicle.set_vehicle_engine_on(player.get_player_vehicle(pid), true, true, true)
		if entity.is_entity_on_fire(player.get_player_vehicle(pid)) then
			fire.stop_entity_fire(player.get_player_vehicle(pid))
		end
		entity.set_entity_velocity(player.get_player_vehicle(pid), entity_velocity)
	else
		menu.notify("[!] Player is not in a vehicle", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Freeze Vehicle", "toggle", playerparents["» Vehicle"], function(f, pid)
	if f.on then
		while f.on do
			system.yield(500)
			network.request_control_of_entity(player.get_player_vehicle(pid))
			entity.freeze_entity(player.get_player_vehicle(pid), true)
		end
	end
	if not f.on then
		network.request_control_of_entity(player.get_player_vehicle(pid))
		entity.freeze_entity(player.get_player_vehicle(pid), false)
	end
end)

menu.add_player_feature("» Vehicle Godmode", "toggle", playerparents["» Vehicle"], function(f, pid)
	if f.on then
		while f.on do
			system.yield(1000)
			network.request_control_of_entity(player.get_player_vehicle(pid))
			entity.set_entity_god_mode(player.get_player_vehicle(pid), true)
		end
	end
	if not f.on then
		network.request_control_of_entity(player.get_player_vehicle(pid))
		entity.set_entity_god_mode(player.get_player_vehicle(pid), false)
	end
end)

menu.add_player_feature("» Bouncy Vehicle", "toggle", playerparents["» Vehicle"], function(f, pid)
    while f.on do
		network.request_control_of_entity(player.get_player_vehicle(pid))
        local vehicle_velocity = entity.get_entity_velocity(player.get_player_vehicle(pid))
        entity.set_entity_velocity(player.get_player_vehicle(pid), v3(vehicle_velocity.x, vehicle_velocity.y, vehicle_velocity.z + 2.5))
		system.yield(1000)
    end
end)

menu.add_player_feature("» Anti Lock-On", "toggle", playerparents["» Vehicle"], function(f, pid)
	if f.on then
		while f.on do
			system.yield(1000)
			network.request_control_of_entity(player.get_player_vehicle(pid))
			vehicle.set_vehicle_can_be_locked_on(player.get_player_vehicle(pid), false, true)
		end
	end
	if not f.on then
		network.request_control_of_entity(player.get_player_vehicle(pid))
		vehicle.set_vehicle_can_be_locked_on(player.get_player_vehicle(pid), true, true)
	end
end)

menu.add_player_feature("» Reduce Vehicle Grip", "toggle", playerparents["» Vehicle"], function(f, pid)
	if f.on then
    	while f.on do
    	    network.request_control_of_entity(player.get_player_vehicle(pid))
			while not network.has_control_of_entity(player.get_player_vehicle(pid)) do
				network.request_control_of_entity(player.get_player_vehicle(pid))
				system.wait(0)
			end
			vehicle.set_vehicle_reduce_grip(player.get_player_vehicle(pid), true)
			system.yield(1000)
		end
    end
	if not f.on then
		network.request_control_of_entity(player.get_player_vehicle(pid))
		while not network.has_control_of_entity(player.get_player_vehicle(pid)) do
			network.request_control_of_entity(player.get_player_vehicle(pid))
			system.wait(0)
		end
		vehicle.set_vehicle_reduce_grip(player.get_player_vehicle(pid), false)
	end
end)

--

playerparents["» Air Vehicles"] = menu.add_player_feature("» Air Vehicles", "parent", playerparents["» Spawn"]).id

menu.add_player_feature("» Cargoplane", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 1000
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(368211810)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(368211810)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(368211810, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
   		vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(368211810)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(368211810)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(368211810, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 20), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
   		vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(368211810)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Cargoplane Opened", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 1000
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(368211810)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(368211810)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(368211810, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
   		vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
		vehicle.set_vehicle_door_open(vehicle_, 2, false, false)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(368211810)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(368211810)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(368211810, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 20), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
   		vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
		vehicle.set_vehicle_door_open(vehicle_, 2, false, false)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(368211810)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Jet", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 1000
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(1058115860)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(1058115860)) do
			system.wait(0)
		end
    
    	local vehicle_ = vehicle.create_vehicle(1058115860, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(1058115860)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(1058115860)) do
			system.wait(0)
		end
    
    	local vehicle_ = vehicle.create_vehicle(1058115860, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(1058115860)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Titan", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 700
    	streaming.request_model(0x616C97B9)
    	streaming.request_model(0x761E2AD3)

    	while (not streaming.has_model_loaded(0x616C97B9)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(0x761E2AD3)) do
			system.wait(0)
		end
    
    	local vehicle_ = vehicle.create_vehicle(0x761E2AD3, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0x616C97B9, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	streaming.request_model(0x616C97B9)
    	streaming.request_model(0x761E2AD3)

    	while (not streaming.has_model_loaded(0x616C97B9)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(0x761E2AD3)) do
			system.wait(0)
		end
    
    	local vehicle_ = vehicle.create_vehicle(0x761E2AD3, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0x616C97B9, pos + v3(0, 0, 10), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 200.0)
	end
	streaming.set_model_as_no_longer_needed(0x616C97B9)
	streaming.set_model_as_no_longer_needed(0x761E2AD3)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Blimp", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 500
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(-150975354)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(-150975354)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(-150975354, pos + v3(math.random(-150, 150), math.random(-150, 150), 0), math.random(0, 360), true, false)
		local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-150, 150), math.random(-150, 150), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 20.0)
		local pos = entity.get_entity_coords(ped_)
		gameplay.shoot_single_bullet_between_coords(pos, pos + v3(0, 0, 0.1), 0, gameplay.get_hash_key("weapon_pistol"), player.get_player_ped(pid), false, true, 100)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(-150975354)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(-150975354)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(-150975354, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
		local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 20.0)
		local pos = entity.get_entity_coords(ped_)
		gameplay.shoot_single_bullet_between_coords(pos, pos + v3(0, 0, 0.1), 0, gameplay.get_hash_key("weapon_pistol"), player.get_player_ped(pid), false, true, 100)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(-150975354)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Miljet", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 800
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(165154707)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(165154707)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(165154707, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)

		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
		ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(165154707)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(165154707)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(165154707, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)

		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(165154707)
	streaming.set_model_as_no_longer_needed(2563194959)
	streaming.set_model_as_no_longer_needed(919005580)
	streaming.set_model_as_no_longer_needed(1446741360)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Miljet Landing", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 800
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(165154707)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(165154707)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(165154707, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)

		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_forward_speed(vehicle_, 60.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(165154707)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(165154707)) do
			system.wait(0)
		end

    	local vehicle_ = vehicle.create_vehicle(165154707, pos + v3(0, 0, 5), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)

		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_forward_speed(vehicle_, 60.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(165154707)
end):set_str_data({
	"Air",
	"Their Pos"
})

menu.add_player_feature("» Luxor", "action_value_str", playerparents["» Air Vehicles"], function(f, pid)
	if f.value == 0 then
		local pos = player.get_player_coords(pid)
		pos.z = 800
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(621481054)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(621481054)) do
			system.wait(0)
		end

		local vehicle_ = vehicle.create_vehicle(621481054, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(math.random(-100, 100), math.random(-100, 100), 0), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	elseif f.value == 1 then
		local pos = player.get_player_coords(pid)
    	streaming.request_model(0xE75B4B1C)
    	streaming.request_model(621481054)

    	while (not streaming.has_model_loaded(0xE75B4B1C)) do
			system.wait(0)
		end

    	while (not streaming.has_model_loaded(621481054)) do
			system.wait(0)
		end

		local vehicle_ = vehicle.create_vehicle(621481054, pos + v3(0, 0, 10), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
    	local ped_ = ped.create_ped(1, 0xE75B4B1C, pos + v3(0, 0, 10), 1.0, true, false)
		network.request_control_of_entity(vehicle_)
		network.request_control_of_entity(ped_)
    	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
    	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    	vehicle.control_landing_gear(vehicle_, 3)
    	vehicle.set_vehicle_forward_speed(vehicle_, 100.0)
	end
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(621481054)
end):set_str_data({
	"Air",
	"Their Pos"
})

playerparents["» Peds"] = menu.add_player_feature("» Peds", "parent", playerparents["» Spawn"]).id

menu.add_player_feature("» El Rubio", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(0xD74B8139)
	while (not streaming.has_model_loaded(0xD74B8139)) do
		system.wait(0)
	end
	
	local ped_ = ped.create_ped(1, 0xD74B8139, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
	network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
	ped.set_ped_can_switch_weapons(ped_, false)
	ped.set_ped_max_health(ped_, 600)
	ped.set_ped_health(ped_, 600)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x57A4368C, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x57A4368C, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Fat Bitches", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(0xB5CF80E4)
	while not streaming.has_model_loaded(0xB5CF80E4) do
		system.wait(0)
	end
	
	for i = 1, 5 do
		local ped_ = ped.create_ped(0, 0xB5CF80E4, player.get_player_coords(pid) + v3(math.random(-5, 5), math.random(-5, 5), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
		network.request_control_of_entity(ped_)
		while not network.has_control_of_entity(ped_) do
			network.request_control_of_entity(ped_)
			system.wait(0)
		end
		ped.set_ped_can_switch_weapons(ped_, false)
		if f.value == 1 then
			ped.set_ped_combat_ability(ped_, 2)
			ped.set_ped_combat_attributes(ped_, 5, true)
			ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
			ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
		elseif f.value == 2 then
			ped.set_ped_combat_ability(ped_, 2)
			ped.set_ped_combat_attributes(ped_, 5, true)
			ped.set_can_attack_friendly(ped_, true, true)
			ped.set_ped_combat_range(ped_, 2)
			ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
		end
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Marine Soldier", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(0x616C97B9)
	while (not streaming.has_model_loaded(0x616C97B9)) do
		system.wait(0)
	end
	
	local ped_ = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
	network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
	ped.set_ped_can_switch_weapons(ped_, false)
	ped.set_ped_max_health(ped_, 600)
	ped.set_ped_health(ped_, 600)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Cayo Perico Guard", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(0x7ED5AD78)
	while (not streaming.has_model_loaded(0x7ED5AD78)) do
		system.wait(0)
	end
	
	local ped_ = ped.create_ped(1, 0x7ED5AD78, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
	network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
	ped.set_ped_can_switch_weapons(ped_, false)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Avon Juggernaut", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(0x90EF5134)
	while (not streaming.has_model_loaded(0x90EF5134)) do
		system.wait(0)
	end
		
	local ped_ = ped.create_ped(1, 0x90EF5134, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
    network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
    ped.set_ped_can_switch_weapons(ped_, false)
    ped.set_ped_ragdoll_blocking_flags(ped_, 1)
    ped.set_ped_max_health(ped_, 2700)
    ped.set_ped_health(ped_, 2700)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x42BF8A85, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x42BF8A85, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Heavy Armoured", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(0x705E61F2)
	while (not streaming.has_model_loaded(0x705E61F2)) do
		system.wait(0)
	end

	local ped_ = ped.create_ped(1, 0x705E61F2, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
	network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
    ped.set_ped_can_switch_weapons(ped_, false)
    ped.set_ped_max_health(ped_, 1200)
    ped.set_ped_health(ped_, 1200)
	ped.set_ped_component_variation(ped_, 0, 0, 0, 0)
   	ped.set_ped_component_variation(ped_, 1, 89, 0, 0)
	ped.set_ped_component_variation(ped_, 2, 49, 0, 0)
	ped.set_ped_component_variation(ped_, 3, 174, 0, 0)
	ped.set_ped_component_variation(ped_, 4, 125, 1, 0)
	ped.set_ped_component_variation(ped_, 5, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 6, 71, 1, 0)
	ped.set_ped_component_variation(ped_, 7, 147, 0, 0)
	ped.set_ped_component_variation(ped_, 8, 170, 0, 0)
	ped.set_ped_component_variation(ped_, 9, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 10, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 11, 324, 1, 0)
	ped.set_ped_prop_index(ped_, 0, 39, 0)
	ped.set_ped_prop_index(ped_, 1, -1, 0)
	ped.set_ped_prop_index(ped_, 2, -1, 0)
	ped.set_ped_head_blend_data(ped_, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0xDBBD7280, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0xDBBD7280, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Nightfall Sniper", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(0x705E61F2)
	while (not streaming.has_model_loaded(0x705E61F2)) do
		system.wait(0)
	end

	local ped_ = ped.create_ped(1, 0x705E61F2, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
	network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
    ped.set_ped_can_switch_weapons(ped_, false)
    ped.set_ped_max_health(ped_, 800)
    ped.set_ped_health(ped_, 800)
	ped.set_ped_combat_ability(ped_, 2)
	ped.set_ped_combat_attributes(ped_, 5, true)
	ped.set_ped_component_variation(ped_, 0, 0, 0, 0)
    ped.set_ped_component_variation(ped_, 1, 132, 0, 0)
	ped.set_ped_component_variation(ped_, 2, 49, 0, 0)
	ped.set_ped_component_variation(ped_, 3, 174, 0, 0)
	ped.set_ped_component_variation(ped_, 4, 33, 0, 0)
	ped.set_ped_component_variation(ped_, 5, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 6, 25, 0, 0)
	ped.set_ped_component_variation(ped_, 7, 147, 0, 0)
	ped.set_ped_component_variation(ped_, 8, 164, 0, 0)
	ped.set_ped_component_variation(ped_, 9, 5, 1, 0)
	ped.set_ped_component_variation(ped_, 10, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 11, 49, 0, 0)
	ped.set_ped_prop_index(ped_, 0, 39, 0)
	ped.set_ped_prop_index(ped_, 1, -1, 0)
	ped.set_ped_prop_index(ped_, 2, -1, 0)
	ped.set_ped_head_blend_data(ped_, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0xA914799, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0xA914799, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Forest Force", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(0x705E61F2)
	while (not streaming.has_model_loaded(0x705E61F2)) do
		system.wait(0)
	end

	local ped_ = ped.create_ped(1, 0x705E61F2, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
	network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
    ped.set_ped_can_switch_weapons(ped_, false)
    ped.set_ped_max_health(ped_, 800)
     ped.set_ped_health(ped_, 800)
	ped.set_ped_combat_ability(ped_, 2)
	ped.set_ped_combat_attributes(ped_, 5, true)
	ped.set_ped_component_variation(ped_, 0, 0, 0, 0)
    ped.set_ped_component_variation(ped_, 1, 185, 0, 0)
	ped.set_ped_component_variation(ped_, 2, 53, 0, 0)
	ped.set_ped_component_variation(ped_, 3, 4, 0, 0)
	ped.set_ped_component_variation(ped_, 4, 9, 0, 0)
	ped.set_ped_component_variation(ped_, 5, 66, 4, 0)
	ped.set_ped_component_variation(ped_, 6, 25, 0, 0)
	ped.set_ped_component_variation(ped_, 7, 146, 2, 0)
	ped.set_ped_component_variation(ped_, 8, 154, 0, 0)
	ped.set_ped_component_variation(ped_, 9, 16, 2, 0)
	ped.set_ped_component_variation(ped_, 10, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 11, 50, 4, 0)
	ped.set_ped_prop_index(ped_, 0, 117, 15)
	ped.set_ped_prop_index(ped_, 1, 25, 15)
	ped.set_ped_prop_index(ped_, 2, -1, 15)
	ped.set_ped_head_blend_data(ped_, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, -1660422300, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, -1660422300, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Armed Robber", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(0x705E61F2)
	while (not streaming.has_model_loaded(0x705E61F2)) do
		system.wait(0)
	end

	local ped_ = ped.create_ped(1, 0x705E61F2, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
	network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
    ped.set_ped_can_switch_weapons(ped_, false)
    ped.set_ped_max_health(ped_, 600)
    ped.set_ped_health(ped_, 600)
	ped.set_ped_combat_ability(ped_, 2)
	ped.set_ped_combat_attributes(ped_, 5, true)
	ped.set_ped_component_variation(ped_, 0, 0, 0, 0)
    ped.set_ped_component_variation(ped_, 1, 54, 0, 0)
	ped.set_ped_component_variation(ped_, 2, 49, 0, 0)
	ped.set_ped_component_variation(ped_, 3, 174, 0, 0)
	ped.set_ped_component_variation(ped_, 4, 33, 0, 0)
	ped.set_ped_component_variation(ped_, 5, 82, 0, 0)
	ped.set_ped_component_variation(ped_, 6, 25, 0, 0)
	ped.set_ped_component_variation(ped_, 7, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 8, 15, 0, 0)
	ped.set_ped_component_variation(ped_, 9, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 10, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 11, 328, 0, 0)
	ped.set_ped_prop_index(ped_, 0, -1, -1)
	ped.set_ped_prop_index(ped_, 1, -1, -1)
	ped.set_ped_prop_index(ped_, 2, -1, -1)
	ped.set_ped_head_blend_data(ped_, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Glitched", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(193469166)
	while (not streaming.has_model_loaded(193469166)) do
		system.wait(0)
	end
		
	local ped_ = ped.create_ped(7, 193469166, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
	network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
	ped.set_ped_can_switch_weapons(ped_, false)
	ped.set_ped_component_variation(ped_, 0, 0, 8, 0)
	ped.set_ped_component_variation(ped_, 0, 0, 9, 0)
	ped.set_ped_component_variation(ped_, 1, 0, 7, 0)
	ped.set_ped_component_variation(ped_, -1, -0, -7, 102)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x687652CE, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x687652CE, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Naked Woman", "action_value_str", playerparents["» Peds"], function(f, pid)
	streaming.request_model(2633130371)
	while (not streaming.has_model_loaded(2633130371)) do
		system.wait(0)
	end
		
	local ped_ = ped.create_ped(7, 2633130371, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
	network.request_control_of_entity(ped_)
	while not network.has_control_of_entity(ped_) do
		network.request_control_of_entity(ped_)
		system.wait(0)
	end
	ped.set_ped_can_switch_weapons(ped_, false)
	ped.set_ped_component_variation(ped_, 0, 1, 0, 0)
	ped.set_ped_component_variation(ped_, 1, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 2, 2, 1, 0)
	ped.set_ped_component_variation(ped_, 3, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 4, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 5, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 6, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 7, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 8, 1, 0, 0)
	ped.set_ped_component_variation(ped_, 9, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 10, 0, 0, 0)
	ped.set_ped_component_variation(ped_, 11, 0, 0, 0)
	ped.set_ped_prop_index(ped_, 0, -1, 0)
	ped.set_ped_prop_index(ped_, 1, -1, 0)
	ped.set_ped_prop_index(ped_, 2, -1, 0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x687652CE, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x687652CE, 0, true)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

playerparents["» Military"] = menu.add_player_feature("» Military", "parent", playerparents["» Spawn"]).id

menu.add_player_feature("» Lazer", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x72C0CAD2)
    streaming.request_model(0xB39B0AE6)

    while (not streaming.has_model_loaded(0xB39B0AE6)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x72C0CAD2)) do
		system.wait(0)
	end

    local vehicle_ = vehicle.create_vehicle(0xB39B0AE6, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), math.random(50, 60)), math.random(0, 360), true, false)
    local ped_ = ped.create_ped(1, 0x72C0CAD2, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), 0), math.random(0, 360), true, false)
	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 50.0)
	vehicle.control_landing_gear(vehicle_, 3)
	ai.task_vehicle_drive_to_coord(ped_, vehicle_, player.get_player_coords(player.player_id()), 100, -1, 0xB39B0AE6, 0, 0, 1)
	ped.set_ped_combat_attributes(ped_, 1, true)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
    end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Strikeforce", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x72C0CAD2)
    streaming.request_model(0x64DE07A1)

    while (not streaming.has_model_loaded(0x64DE07A1)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x72C0CAD2)) do
		system.wait(0)
	end

    local vehicle_ = vehicle.create_vehicle(0x64DE07A1, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), math.random(50, 60)), math.random(0, 360), true, false)
    local ped_ = ped.create_ped(1, 0x72C0CAD2, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), 0), math.random(0, 360), true, false)
	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 50.0)
	vehicle.control_landing_gear(vehicle_, 3)
	ai.task_vehicle_drive_to_coord(ped_, vehicle_, player.get_player_coords(player.player_id()), 100, -1, 0x64DE07A1, 0, 0, 1)
	ped.set_ped_combat_attributes(ped_, 1, true)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
    end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Titan", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x72C0CAD2)
    streaming.request_model(0x761E2AD3)

    while (not streaming.has_model_loaded(0x761E2AD3)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x72C0CAD2)) do
		system.wait(0)
	end

    local vehicle_ = vehicle.create_vehicle(0x761E2AD3, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), math.random(100, 160)), math.random(0, 360), true, false)
    local ped_ = ped.create_ped(1, 0x72C0CAD2, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), 0), math.random(0, 360), true, false)
	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 50.0)
	vehicle.control_landing_gear(vehicle_, 3)
	ai.task_vehicle_drive_to_coord(ped_, vehicle_, player.get_player_coords(player.player_id()), 100, -1, 0x761E2AD3, 0, 0, 1)
	ped.set_ped_combat_attributes(ped_, 1, true)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
    end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Bombushka", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x72C0CAD2)
    streaming.request_model(0xFE0A508C)

    while (not streaming.has_model_loaded(0xFE0A508C)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x72C0CAD2)) do
		system.wait(0)
	end

    local vehicle_ = vehicle.create_vehicle(0xFE0A508C, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), math.random(100, 160)), math.random(0, 360), true, false)
    local ped_ = ped.create_ped(1, 0x72C0CAD2, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), 0), math.random(0, 360), true, false)
	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 50.0)
	vehicle.control_landing_gear(vehicle_, 3)
	ai.task_vehicle_drive_to_coord(ped_, vehicle_, player.get_player_coords(player.player_id()), 100, -1, 0xFE0A508C, 0, 0, 1)
	ped.set_ped_combat_attributes(ped_, 1, true)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
    end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Besra", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x72C0CAD2)
    streaming.request_model(0x6CBD1D6D)

    while (not streaming.has_model_loaded(0x6CBD1D6D)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x72C0CAD2)) do
		system.wait(0)
	end

    local vehicle_ = vehicle.create_vehicle(0x6CBD1D6D, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), math.random(50, 60)), math.random(0, 360), true, false)
    local ped_ = ped.create_ped(1, 0x72C0CAD2, player.get_player_coords(pid) + v3(math.random(-100, 100), math.random(-100, 100), 0), math.random(0, 360), true, false)
	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 50.0)
	vehicle.control_landing_gear(vehicle_, 3)
	ai.task_vehicle_drive_to_coord(ped_, vehicle_, player.get_player_coords(player.player_id()), 100, -1, 0x6CBD1D6D, 0, 0, 1)
	ped.set_ped_combat_attributes(ped_, 1, true)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
    end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Rhino Tank", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x616C97B9)
    streaming.request_model(0x2EA68690)

    while (not streaming.has_model_loaded(0x2EA68690)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x616C97B9)) do
		system.wait(0)
	end

	local vehicle_ = vehicle.create_vehicle(0x2EA68690, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	local ped_ = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	ped.set_ped_into_vehicle(ped_, vehicle_, -1)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 5.0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		ai.task_combat_ped(ped_, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_, 1)
		ped.set_ped_combat_ability(ped_, 2)
		ped.set_ped_combat_attributes(ped_, 5, true)
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		ped.set_can_attack_friendly(ped_, true, true)
		ped.set_ped_combat_range(ped_, 2)
		ped.set_ped_relationship_group_hash(ped_, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Insurgent", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x616C97B9)
    streaming.request_model(0x9114EADA)

    while (not streaming.has_model_loaded(0x9114EADA)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x616C97B9)) do
		system.wait(0)
	end

	local vehicle_ = vehicle.create_vehicle(0x9114EADA, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	local ped_1 = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	local ped_2 = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	ped.set_ped_into_vehicle(ped_1, vehicle_, -1)
	ped.set_ped_into_vehicle(ped_2, vehicle_, 7)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 5.0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		ai.task_combat_ped(ped_1, player.get_player_ped(pid), 0, 16)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("HATES_PLAYER"))
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ai.task_combat_ped(ped_2, player.get_player_ped(pid), 0, 16)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		weapon.give_delayed_weapon_to_ped(ped_1, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_attributes(ped_1, 3, false)
		ped.set_ped_combat_range(ped_1, 2)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("WILD_ANIMAL"))
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ped.set_ped_combat_attributes(ped_2, 3, false)
		ped.set_ped_combat_range(ped_2, 2)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Barracks", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x616C97B9)
    streaming.request_model(0xCEEA3F4B)

    while (not streaming.has_model_loaded(0xCEEA3F4B)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x616C97B9)) do
		system.wait(0)
	end

	local vehicle_ = vehicle.create_vehicle(0xCEEA3F4B, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	local ped_1 = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	local ped_2 = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	ped.set_ped_into_vehicle(ped_1, vehicle_, -1)
	ped.set_ped_into_vehicle(ped_2, vehicle_, 0)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 5.0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		ai.task_combat_ped(ped_1, player.get_player_ped(pid), 0, 16)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("HATES_PLAYER"))
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ai.task_combat_ped(ped_2, player.get_player_ped(pid), 0, 16)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		ped.set_ped_combat_attributes(ped_1, 3, false)
		ped.set_ped_combat_range(ped_1, 2)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("WILD_ANIMAL"))
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ped.set_ped_combat_attributes(ped_2, 3, false)
		ped.set_ped_combat_range(ped_2, 2)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Crusader", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x616C97B9)
    streaming.request_model(0x132D5A1A)

    while (not streaming.has_model_loaded(0x132D5A1A)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x616C97B9)) do
		system.wait(0)
	end

	local vehicle_ = vehicle.create_vehicle(0x132D5A1A, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	local ped_1 = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	local ped_2 = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	ped.set_ped_into_vehicle(ped_1, vehicle_, -1)
	ped.set_ped_into_vehicle(ped_2, vehicle_, 0)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 5.0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		ai.task_combat_ped(ped_1, player.get_player_ped(pid), 0, 16)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("HATES_PLAYER"))
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ai.task_combat_ped(ped_2, player.get_player_ped(pid), 0, 16)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		ped.set_ped_combat_attributes(ped_1, 3, false)
		ped.set_ped_combat_range(ped_1, 2)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("WILD_ANIMAL"))
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ped.set_ped_combat_attributes(ped_2, 3, false)
		ped.set_ped_combat_range(ped_2, 2)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Chernobog", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x616C97B9)
    streaming.request_model(0xD6BC7523)

    while (not streaming.has_model_loaded(0xD6BC7523)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x616C97B9)) do
		system.wait(0)
	end

	local vehicle_ = vehicle.create_vehicle(0xD6BC7523, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	local ped_1 = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	local ped_2 = ped.create_ped(1, 0x616C97B9, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 20), 0, true, false)
	ped.set_ped_into_vehicle(ped_1, vehicle_, -1)
	ped.set_ped_into_vehicle(ped_2, vehicle_, 0)
	vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
	vehicle.set_vehicle_forward_speed(vehicle_, 5.0)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		ai.task_combat_ped(ped_1, player.get_player_ped(pid), 0, 16)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("HATES_PLAYER"))
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ai.task_combat_ped(ped_2, player.get_player_ped(pid), 0, 16)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_attributes(vehicle_, 1, true)
		ped.set_ped_combat_attributes(ped_1, 3, false)
		ped.set_ped_combat_range(ped_1, 2)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("WILD_ANIMAL"))
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ped.set_ped_combat_attributes(ped_2, 3, false)
		ped.set_ped_combat_range(ped_2, 2)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» Buzzard", "action_value_str", playerparents["» Military"], function(f, pid)
    streaming.request_model(0x616C97B9)
	streaming.request_model(0x2F03547B)

    while (not streaming.has_model_loaded(0x616C97B9)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x2F03547B)) do
		system.wait(0)
	end

    local vehicle_ = vehicle.create_vehicle(0x2F03547B, player.get_player_coords(pid) + v3(math.random(-30, 30), math.random(-30, 30), math.random(10, 40)), math.random(0, 0), true, false)
    local ped_1 = ped.create_ped(1, 0x616C97B9, player.get_player_coords(pid) + v3(math.random(-30, 30), math.random(-30, 30), 0), 1.0, true, false)
    local ped_2 = ped.create_ped(1, 0x616C97B9, player.get_player_coords(pid) + v3(math.random(-30, 30), math.random(-30, 30), 0), 1.0, true, false)
    local ped_3 = ped.create_ped(1, 0x616C97B9, player.get_player_coords(pid) + v3(math.random(-30, 30), math.random(-30, 30), 0), 1.0, true, false)
    ped.set_ped_can_switch_weapons(ped_1, false)
    ped.set_ped_can_switch_weapons(ped_2, false)
    ped.set_ped_can_switch_weapons(ped_3, false)
    ped.set_ped_into_vehicle(ped_1, vehicle_, -1)
    ped.set_ped_max_health(ped_1, 500)
    ped.set_ped_health(ped_1, 500)
    vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    vehicle.control_landing_gear(vehicle_, 3)
    vehicle.set_vehicle_forward_speed(vehicle_, 10.0)
    ped.set_ped_combat_attributes(vehicle_, 1, true)
    ped.set_ped_into_vehicle(ped_2, vehicle_, 1)
    ped.set_ped_into_vehicle(ped_3, vehicle_, 2)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x57A4368C, 0, true)
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		weapon.give_delayed_weapon_to_ped(ped_3, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_as_group_member(ped_3, 1)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ped.set_ped_combat_ability(ped_3, 2)
		ped.set_ped_combat_attributes(ped_3, 5, true)
		ai.task_combat_ped(ped_1, player.get_player_ped(pid), 0, 16)
		ai.task_combat_ped(ped_2, player.get_player_ped(pid), 0, 16)
		ai.task_combat_ped(ped_3, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("HATES_PLAYER"))
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("HATES_PLAYER"))
		ped.set_ped_relationship_group_hash(ped_3, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x57A4368C, 0, true)
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		weapon.give_delayed_weapon_to_ped(ped_3, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_as_group_member(ped_3, 1)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ped.set_ped_combat_ability(ped_3, 2)
		ped.set_ped_combat_attributes(ped_3, 5, true)
		ped.set_can_attack_friendly(ped_1, true, true)
		ped.set_can_attack_friendly(ped_2, true, true)
		ped.set_can_attack_friendly(ped_3, true, true)
		ped.set_ped_combat_range(ped_1, 2)
		ped.set_ped_combat_range(ped_2, 2)
		ped.set_ped_combat_range(ped_3, 2)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("WILD_ANIMAL"))
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("WILD_ANIMAL"))
		ped.set_ped_relationship_group_hash(ped_3, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

menu.add_player_feature("» El Rubio Helicopter", "action_value_str", playerparents["» Military"], function(f, pid)
	local pos = player.get_player_coords(pid)
    streaming.request_model(0xD74B8139)
    streaming.request_model(0xA09E15FD)
    streaming.request_model(0x7ED5AD78)

    while (not streaming.has_model_loaded(0xD74B8139)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0xA09E15FD)) do
		system.wait(0)
	end

    while (not streaming.has_model_loaded(0x7ED5AD78)) do
		system.wait(0)
	end

    local vehicle_ = vehicle.create_vehicle(0xA09E15FD, pos + v3(math.random(-30, 30), math.random(-30, 30), math.random(10, 40)), math.random(0, 0), true, false)
    local ped_1 = ped.create_ped(1, 0xD74B8139, pos + v3(math.random(-30, 30), math.random(-30, 30), 0), 1.0, true, false)
    local ped_2 = ped.create_ped(1, 0x7ED5AD78, pos + v3(math.random(-30, 30), math.random(-30, 30), 0), 1.0, true, false)
    local ped_3 = ped.create_ped(1, 0x7ED5AD78, pos + v3(math.random(-30, 30), math.random(-30, 30), 0), 1.0, true, false)
    ped.set_ped_can_switch_weapons(ped_1, false)
    ped.set_ped_can_switch_weapons(ped_2, false)
    ped.set_ped_can_switch_weapons(ped_3, false)
    ped.set_ped_into_vehicle(ped_1, vehicle_, -1)
    ped.set_ped_max_health(ped_1, 500)
    ped.set_ped_health(ped_1, 500)
    vehicle.set_vehicle_engine_on(vehicle_, true, true, false)
    vehicle.control_landing_gear(vehicle_, 3)
    vehicle.set_vehicle_forward_speed(vehicle_, 10.0)
    ped.set_ped_combat_attributes(vehicle_, 1, true)
    ped.set_ped_into_vehicle(ped_2, vehicle_, 1)
    ped.set_ped_into_vehicle(ped_3, vehicle_, 2)
	if f.value == 1 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x57A4368C, 0, true)
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		weapon.give_delayed_weapon_to_ped(ped_3, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_as_group_member(ped_3, 1)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ped.set_ped_combat_ability(ped_3, 2)
		ped.set_ped_combat_attributes(ped_3, 5, true)
		ai.task_combat_ped(ped_1, player.get_player_ped(pid), 0, 16)
		ai.task_combat_ped(ped_2, player.get_player_ped(pid), 0, 16)
		ai.task_combat_ped(ped_3, player.get_player_ped(pid), 0, 16)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("HATES_PLAYER"))
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("HATES_PLAYER"))
		ped.set_ped_relationship_group_hash(ped_3, gameplay.get_hash_key("HATES_PLAYER"))
	elseif f.value == 2 then
		weapon.give_delayed_weapon_to_ped(ped_1, 0x57A4368C, 0, true)
		weapon.give_delayed_weapon_to_ped(ped_2, 0x9D1F17E6, 0, true)
		weapon.give_delayed_weapon_to_ped(ped_3, 0x9D1F17E6, 0, true)
		ped.set_ped_as_group_member(ped_1, 1)
		ped.set_ped_as_group_member(ped_2, 1)
		ped.set_ped_as_group_member(ped_3, 1)
		ped.set_ped_combat_ability(ped_1, 2)
		ped.set_ped_combat_attributes(ped_1, 5, true)
		ped.set_ped_combat_ability(ped_2, 2)
		ped.set_ped_combat_attributes(ped_2, 5, true)
		ped.set_ped_combat_ability(ped_3, 2)
		ped.set_ped_combat_attributes(ped_3, 5, true)
		ped.set_can_attack_friendly(ped_1, true, true)
		ped.set_can_attack_friendly(ped_2, true, true)
		ped.set_can_attack_friendly(ped_3, true, true)
		ped.set_ped_combat_range(ped_1, 2)
		ped.set_ped_combat_range(ped_2, 2)
		ped.set_ped_combat_range(ped_3, 2)
		ped.set_ped_relationship_group_hash(ped_1, gameplay.get_hash_key("WILD_ANIMAL"))
		ped.set_ped_relationship_group_hash(ped_2, gameplay.get_hash_key("WILD_ANIMAL"))
		ped.set_ped_relationship_group_hash(ped_3, gameplay.get_hash_key("WILD_ANIMAL"))
	end
end):set_str_data({
	"Ped",
	"Hostile",
	"Aggressive"
})

--

menu.add_player_feature("» Hack Success", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Hack_Success", player.get_player_coords(pid), "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Hack Fail", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Hack_Failed", player.get_player_coords(pid), "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Rip Car", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "FAMILY_1_CAR_BREAKDOWN", player.get_player_coords(pid), "FAMILY1_BOAT", true, 2, false)
end)

menu.add_player_feature("» Hammer Slam", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Drill_Pin_Break", player.get_player_coords(pid), "DLC_HEIST_FLEECA_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Baritone Saxophone", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Horn", player.get_player_coords(pid), "DLC_Apt_Yacht_Ambient_Soundset", true, 2, false)
end)

menu.add_player_feature("» Rank Up", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "MP_RANK_UP", player.get_player_coords(pid), "HUD_FRONTEND_DEFAULT_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Cash Pickup", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", player.get_player_coords(pid), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Camera Shutter", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "SHUTTER_FLASH", player.get_player_coords(pid), "CAMERA_FLASH_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Menu Accept", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Menu_Accept", player.get_player_coords(pid), "Phone_SoundSet_Default", true, 2, false)
end)

menu.add_player_feature("» Alert Sound", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Out_Of_Bounds_Timer", player.get_player_coords(pid), "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Race Checkpoint", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "CHECKPOINT_AHEAD", player.get_player_coords(pid), "HUD_MINI_GAME_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Walkie-Talkie", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Start_Squelch", player.get_player_coords(pid), "CB_RADIO_SFX", true, 2, false)
end)

menu.add_player_feature("» Pickup", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Bus_Schedule_Pickup", player.get_player_coords(pid), "DLC_PRISON_BREAK_HEIST_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Fast Beeping", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Beep_Red", player.get_player_coords(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 2, false)
end)

menu.add_player_feature("» Notification", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "CHALLENGE_UNLOCKED", player.get_player_coords(pid), "HUD_AWARDS", true, 2, false)
end)

menu.add_player_feature("» Focus In", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "FocusIn", player.get_player_coords(pid), "HintCamSounds", true, 2, false)
end)

menu.add_player_feature("» Stunt Jump", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "LOSER", player.get_player_coords(pid), "HUD_AWARDS", true, 2, false)
end)

menu.add_player_feature("» Air Defenses Off", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Air_Defenses_Disabled", player.get_player_coords(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, 2, false)
end)

menu.add_player_feature("» Air Defenses On", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "Air_Defences_Activated", player.get_player_coords(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, 2, false)
end)

menu.add_player_feature("» Phone Select", "action", playerparents["» Sounds"], function(f, pid)
	audio.play_sound_from_coord(-1, "YES", player.get_player_coords(pid), "HUD_FRONTEND_DEFAULT_SOUNDSET", true, 2, false)
end)

menu.add_player_feature("» Metal Detector Sounds", "action_value_str", playerparents["» Sounds"], function(f, pid)
    if f.value == 0 then
		audio.play_sound_from_coord(-1, "Metal_Detector_Small_Guns", player.get_player_coords(pid), "dlc_ch_heist_finale_security_alarms_sounds", true, 2, false)
    elseif f.value == 1 then
		audio.play_sound_from_coord(-1, "Metal_Detector_Big_Guns", player.get_player_coords(pid), "dlc_ch_heist_finale_security_alarms_sounds", true, 2, false)
    end
end):set_str_data({
	"Small Weps",
	"Big Weps"
})

menu.add_player_feature("» Fast Beep Loop", "toggle", playerparents["» Sounds"], function(f, pid)
	while f.on do
		audio.play_sound_from_coord(-1, "Beep_Red", player.get_player_coords(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 2, false)
		system.wait(0)
	end
end)

menu.add_player_feature("» Click Loop", "toggle", playerparents["» Sounds"], function(f, pid)
	while f.on do
		audio.play_sound_from_coord(-1, "Click_Special", player.get_player_coords(pid), "WEB_NAVIGATION_SOUNDS_PHONE", true, 2, false)
		system.wait(150)
	end
end)

menu.add_player_feature("» Bari Sax Loop", "toggle", playerparents["» Sounds"], function(f, pid)
	while f.on do
		audio.play_sound_from_coord(-1, "Horn", player.get_player_coords(pid), "DLC_Apt_Yacht_Ambient_Soundset", true, 2, false)
		system.wait(0)
	end
end)

--

playerparents["» Menu Crashes/Kicks"] = menu.add_player_feature("» Menu Crashes/Kicks", "parent", playerparents["» Crashes/Kicks"]).id

menu.add_player_feature("» Crash - Midnight Brute", "action_value_str", playerparents["» Menu Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(-1386010354, pid, {pid, 2147483647, 2147483647, -788905164})
			menu.notify("[!] Midnight Brute Crash v1 executed successfully.", Meteor)
		elseif f.value == 1 then
			script.trigger_script_event(962740265, pid, {pid, 4294894682, -4294904289, -788905164})
			menu.notify("[!] Midnight Brute Crash v2 executed successfully.", Meteor)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Crash - Stand Elegant", "action_value_str", playerparents["» Menu Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(962740265, pid, {-72614, 63007, 59027, -12012, -26996, 33398, pid})
			menu.notify("[!] Stand Elegant Crash v1 executed successfully.", Meteor)
		elseif f.value == 1 then
			script.trigger_script_event(-1386010354, pid, {pid, 2147483647, 2147483647, -72614, 63007, 59027, -12012, -26996, 33398, pid})
			menu.notify("[!] Stand Elegant Crash v2 executed successfully.", Meteor)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Crash - Stand Next Gen", "action", playerparents["» Menu Crashes/Kicks"], function(f, pid)
    if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			streaming.request_model(1349725314)
			while not streaming.has_model_loaded(1349725314) do
				system.wait(0)
			end
			local vehicle_ = vehicle.create_vehicle(1349725314, utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), player.get_player_coords(pid).z, true, false)
			network.request_control_of_entity(vehicle_)
			vehicle.set_vehicle_mod_kit_type(vehicle_, 0)
			vehicle.set_vehicle_mod(vehicle_, 48, vehicle.get_num_vehicle_mods(vehicle_, 48) -1, true)
			system.wait(5000)
			network.request_control_of_entity(vehicle_)
			utilities.hard_remove_entity(vehicle_)
			menu.notify("[!] Stand Next Gen Crash executed successfully.", Meteor)
		else
			menu.notify("[!] You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
    else
        menu.notify("[!] Invalid Player.", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Crash - Cherax", "action_value_str", playerparents["» Menu Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(-1386010354, pid, {pid, 2147483647, 2147483647, 23243, 5332, 3324, pid})
			menu.notify("[!] Cherax Crash v1 executed successfully.", Meteor)
		elseif f.value == 1 then
			script.trigger_script_event(962740265, pid, {pid, 23243, 5332, 3324, pid})
			menu.notify("[!] Cherax Crash v2 executed successfully.", Meteor)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Crash - 0xCheats", "action_value_str", playerparents["» Menu Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(962740265, pid, {pid, pid, 30583, pid, pid, pid, pid, -328966, 10128444})
			menu.notify("[!] 0xCheats Crash v1 executed successfully.", Meteor)
		elseif f.value == 1 then
			script.trigger_script_event(-1386010354, pid, {pid, 2147483647, 2147483647, pid, 30583, pid, pid, pid, pid, -328966, 10128444})
			menu.notify("[!] 0xCheats Crash v2 executed successfully.", Meteor)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Crash - xForce Basic", "action_value_str", playerparents["» Menu Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(962740265, pid, {pid, 95398, 98426, -24591, 47901, -64814})
			menu.notify("[!] xForce Basic Crash v1 executed successfully.", Meteor)
		elseif f.value == 1 then
			script.trigger_script_event(962740265, pid, {pid, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
			menu.notify("[!] xForce Basic Crash v2 executed successfully.", Meteor)
		elseif f.value == 2 then
			script.trigger_script_event(-1386010354, pid, {pid, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647})
			menu.notify("[!] xForce Basic Crash v3 executed successfully.", Meteor)
		elseif f.value == 3 then
			script.trigger_script_event(677240627, pid, {pid, -1774405356})
			menu.notify("[!] xForce Basic Crash v4 executed successfully.", Meteor)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3",
	"v4"
})

menu.add_player_feature("» Kick - Stand Smart", "action_value_str", playerparents["» Menu Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(1228916411, pid, {pid, script_func.get_global_main(pid)})
			menu.notify("[!] Stand Smart Kick v1 executed successfully.", Meteor)
		elseif f.value == 1 then
			script.trigger_script_event(0x493fc6bb, pid, {pid, script_func.get_global_main(pid)})
			menu.notify("[!] Stand Smart Kick v2 executed successfully.", Meteor)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Kick - Phantom X", "action", playerparents["» Menu Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(1189947075, pid, {pid, 1204112514})
		menu.notify("[!] Phantom X Kick executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Invalid Ped", "action_value_str", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
   		 	local ped_ = ped.create_ped(0, 1057201338, player.get_player_coords(pid), 0, true, false)
			system.wait(100)
   		 	entity.delete_entity(ped_)
			menu.notify("[!] Invalid Ped Crash v1 executed successfully.", Meteor)
		elseif f.value == 1 then
			local ped_ = ped.create_ped(0, -2056455422, player.get_player_coords(pid), 0, true, false)
			system.wait(100)
    		entity.delete_entity(ped_)
			menu.notify("[!] Invalid Ped Crash v2 executed successfully.", Meteor)
		elseif f.value == 2 then
			local ped_ = ped.create_ped(0, 762327283, player.get_player_coords(pid), 0, true, false)
			system.wait(100)
   		 	entity.delete_entity(ped_)
			menu.notify("[!] Invalid Ped Crash v3 executed successfully.", Meteor)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3"
})

menu.add_player_feature("» Crash - Improved Yo Momma", "action", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		streaming.request_model(0xB5CF80E4)
		while not streaming.has_model_loaded(0xB5CF80E4) do
    		system.wait(0)
		end
		for i = 1, 12 do
			menu.create_thread(function()
				local ped_1 = ped.create_ped(0, 0xB5CF80E4, player.get_player_coords(pid) + v3(math.random(-1, 1), math.random(-1, 1), 0), entity.get_entity_heading(player.get_player_ped(pid)), true, false)
				system.wait(400)
				entity.delete_entity(ped_1)
			end, nil)
		end
		system.wait(100)
		local ped_2 = ped.create_ped(0, 0x3F039CBA, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), math.random(-1, 3)), 0, true, false)
		local ped_3 = ped.create_ped(0, 0x856CFB02, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), math.random(-1, 3)), 0, true, false)
		local ped_4 = ped.create_ped(0, 0x2D7030F3, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), math.random(-1, 3)), 0, true, false)
		local ped_5 = ped.create_ped(0, 0x3F039CBA, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), math.random(-1, 3)), 0, true, false)
		local ped_6 = ped.create_ped(0, 0x856CFB02, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), math.random(-1, 3)), 0, true, false)
		local ped_7 = ped.create_ped(0, 0x2D7030F3, player.get_player_coords(pid) + v3(math.random(-4, 4), math.random(-4, 4), math.random(-1, 3)), 0, true, false)
		system.wait(800)
		entity.delete_entity(ped_2)
		entity.delete_entity(ped_3)
		entity.delete_entity(ped_4)
		entity.delete_entity(ped_5)
		entity.delete_entity(ped_6)
		entity.delete_entity(ped_7)
		if player.is_player_valid(pid) then
			script.trigger_script_event(962740265, pid, {pid, 23243, 5332, 3324, pid})
		end
		menu.notify("[!] Improved Yo Momma Crash executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Script Event", "action_value_str", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(962740265, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 1 then
			script.trigger_script_event(962740265, pid, {pid, pid, 1001, pid})
		elseif f.value == 2 then
			script.trigger_script_event(-1386010354, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 3 then
			script.trigger_script_event(-1386010354, pid, {pid, 2147483647, 2147483647, 232342, 112, 238452, 2832})
		elseif f.value == 4 then
			script.trigger_script_event(2112408256, pid, {pid, math.random(-1986324736, 1747413822), math.random(-1986324736, 1777712108), math.random(-1673857408, 1780088064), math.random(-2588888790, 2100146067)})
		elseif f.value == 5 then
			script.trigger_script_event(998716537, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 6 then
			script.trigger_script_event(998716537, pid, {pid, pid, 1001, pid})
		elseif f.value == 7 then
			script.trigger_script_event(163598572, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 8 then
			script.trigger_script_event(-1056683619, pid, {pid, pid, 1001, pid})
		elseif f.value == 9 then
			script.trigger_script_event(436475575, pid, {pid, 20})
		elseif f.value == 10 then
			script.trigger_script_event(1757755807, pid, {pid, 62, 2})
		elseif f.value == 11 then
			script.trigger_script_event(-1767058336, pid, {pid, 3})
		elseif f.value == 12 then
			script.trigger_script_event(-1013679841, pid, {pid, pid, 111})
		elseif f.value == 13 then
			script.trigger_script_event(-1501164935, pid, {pid, 0})
		elseif f.value == 14 then
			script.trigger_script_event(998716537, pid, {pid, 0})
		elseif f.value == 15 then
			script.trigger_script_event(163598572, pid, {pid, 0})
		elseif f.value == 16 then
			script.trigger_script_event(924535804, pid, {pid, 0})
		elseif f.value == 17 then
			script.trigger_script_event(69874647, pid, {pid, 0})
		elseif f.value == 18 then
			script.trigger_script_event(-1782442696, pid, {pid, 420, 69})
		elseif f.value == 19 then
			script.trigger_script_event(1445703181, pid, {pid, 28, 4294967295, 4294967295})
		elseif f.value == 20 then
			script.trigger_script_event(-1386010354, pid, {pid, 4294894682, -4294904289, -4294908269, 4294955284, 4294940300, -4294933898})
		elseif f.value == 21 then
			script.trigger_script_event(962740265, pid, {pid, 4294894682, -4294904289, -4294908269, 4294955284, 4294940300, -4294933898})
		elseif f.value == 22 then
			script.trigger_script_event(-1501164935, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 23 then
			script.trigger_script_event(-1501164935, pid, {pid, pid, 1001, pid})
		elseif f.value == 24 then
			script.trigger_script_event(-0x529CD6F2, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 25 then
			script.trigger_script_event(-0x756DBC8A, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 26 then
			script.trigger_script_event(-0x69532BA0, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 27 then
			script.trigger_script_event(0x68C5399F, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 28 then
			script.trigger_script_event(-0x177132B8, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 29 then
			script.trigger_script_event(962740265, pid, {pid, pid, 1001, pid})
		elseif f.value == 30 then
			script.trigger_script_event(-0x177132B8, pid, {pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 31 then
			script.trigger_script_event(436475575, pid, {pid, 4113865})
		elseif f.value == 32 then
			script.trigger_script_event(-1767058336, pid, {pid, 20923579})
		elseif f.value == 33 then
			script.trigger_script_event(2112408256, pid, {77777778})
		elseif f.value == 34 then
			script.trigger_script_event(924535804, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 35 then
			script.trigger_script_event(1445703181, pid, {pid, pid, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), pid})
		end
		menu.notify("[!] Script Event Crash executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3",
	"v4",
	"v5",
	"v6",
	"v7",
	"v8",
	"v9",
	"v10",
	"v11",
	"v12",
	"v13",
	"v14",
	"v15",
	"v16",
	"v17",
	"v18",
	"v19",
	"v20",
	"v21",
	"v22",
	"v23",
	"v24",
	"v25",
	"v26",
	"v27",
	"v28",
	"v29",
	"v30",
	"v31",
	"v32",
	"v33",
	"v34",
	"v35",
	"v36"
})

menu.add_player_feature("» Crash - Invalid Vehicle", "action", playerparents["» Crashes/Kicks"], function(f, pid)
    if player.is_player_valid(pid) then
        local vehicle_ = {}
        local hashes = {956849991, 1133471123, 2803699023, 386089410, 1549009676}
        for i = 1, #hashes do
            streaming.request_model(hashes[i])
            while not streaming.has_model_loaded(hashes[i]) do
                system.wait(0)
            end
            vehicle_[i] = vehicle.create_vehicle(hashes[i], utilities.offset_coords_forward(player.get_player_coords(pid), player.get_player_heading(pid), 5), 0, true, false)
            network.request_control_of_entity(vehicle_[i])
        end
        system.wait(2000)
        for i = 1, #vehicle_ do
            network.request_control_of_entity(vehicle_[i])
            utilities.hard_remove_entity(vehicle_[i])
        end
        menu.notify("[!] Invalid Vehicle Crash executed successfully.", Meteor)
    else
        menu.notify("[!] Invalid Player.", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Crash - Bad Outfit Component", "action", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			streaming.request_model(0x705E61F2)
			while (not streaming.has_model_loaded(0x705E61F2)) do
				system.wait(0)
			end

			local ped_ = ped.create_ped(1, 0x705E61F2, player.get_player_coords(pid), 0, true, false)
			network.request_control_of_entity(ped_)
			ped.set_ped_component_variation(ped_, 0, 45, 0, 0)
			ped.set_ped_component_variation(ped_, 1, 197, 0, 0)
			ped.set_ped_component_variation(ped_, 2, 76, 0, 0)
			ped.set_ped_component_variation(ped_, 3, 196, 0, 0)
			ped.set_ped_component_variation(ped_, 4, 144, 0, 0)
			ped.set_ped_component_variation(ped_, 5, 99, 0, 0)
			ped.set_ped_component_variation(ped_, 6, 102, 0, 0)
			ped.set_ped_component_variation(ped_, 7, 151, 0, 0)
			ped.set_ped_component_variation(ped_, 8, 189, 0, 0)
			ped.set_ped_component_variation(ped_, 9, 56, 0, 0)
			ped.set_ped_component_variation(ped_, 10, 132, 0, 0)
			ped.set_ped_component_variation(ped_, 11, 393, 0, 0)
			system.wait(2000)
			network.request_control_of_entity(ped_)
			utilities.hard_remove_entity(ped_)
			menu.notify("[!] Bad Outfit Component Crash executed successfully.", Meteor)
		else
			menu.notify("[!] You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Crash - Sound Spam", "action_value_str", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		local time = utils.time_ms() + 100
		while time > utils.time_ms() do
			for i = 1, 10 do
				if f.value == 0 then
					audio.play_sound_from_coord(-1, "Object_Dropped_Remote", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 1 then
					audio.play_sound_from_coord(-1, "Event_Message_Purple", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 2 then
					audio.play_sound_from_coord(-1, "Checkpoint_Cash_Hit", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 3 then
					audio.play_sound_from_coord(-1, "Event_Start_Text", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 4 then
					audio.play_sound_from_coord(-1, "Checkpoint_Hit", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 5 then
					audio.play_sound_from_coord(-1, "Return_To_Vehicle_Timer", player.get_player_coords(pid), "GTAO_FM_Events_Soundset", true, 1, false)
				elseif f.value == 6 then
					audio.play_sound_from_coord(-1, "5s", player.get_player_coords(pid), "MP_MISSION_COUNTDOWN_SOUNDSET", true, 1, false)
				elseif f.value == 7 then
					audio.play_sound_from_coord(-1, "10s", player.get_player_coords(pid), "MP_MISSION_COUNTDOWN_SOUNDSET", true, 1, false)
				end
			end
			system.wait(0)
		end
		menu.notify("[!] Sound Spam Crash executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"1 v1",
	"1 v2",
	"1 v3",
	"1 v4",
	"1 v5",
	"1 v6",
	"2 v1",
	"2 v2"
})

menu.add_player_feature("» Crash - Bad Net Vehicle", "action", playerparents["» Crashes/Kicks"], function(f, pid)
    if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			streaming.request_model(1492612435)
			while not streaming.has_model_loaded(1492612435) do
				system.wait(0)
			end
			streaming.request_model(3517794615)
			while not streaming.has_model_loaded(3517794615) do
				system.wait(0)
			end
			streaming.request_model(3889340782)
			while not streaming.has_model_loaded(3889340782) do
				system.wait(0)
			end
			streaming.request_model(3253274834)
			while not streaming.has_model_loaded(3253274834) do
				system.wait(0)
			end

			local vehicle_1 = vehicle.create_vehicle(1492612435, player.get_player_coords(pid), math.random(0, 360), true, false)

			local vehicle_2 = vehicle.create_vehicle(3517794615, player.get_player_coords(pid), math.random(0, 360), true, false)

			local vehicle_3 = vehicle.create_vehicle(3889340782, player.get_player_coords(pid), math.random(0, 360), true, false)

			local vehicle_4 = vehicle.create_vehicle(3253274834, player.get_player_coords(pid), math.random(0, 360), true, false)

			network.request_control_of_entity(vehicle_1)
			network.request_control_of_entity(vehicle_2)
			network.request_control_of_entity(vehicle_3)
			network.request_control_of_entity(vehicle_4)

			vehicle.set_vehicle_mod_kit_type(vehicle_1, 0)
			vehicle.set_vehicle_mod_kit_type(vehicle_2, 0)
			vehicle.set_vehicle_mod_kit_type(vehicle_3, 0)
			vehicle.set_vehicle_mod_kit_type(vehicle_4, 0)
			for i = 0, 49 do
				local mod = vehicle.get_num_vehicle_mods(vehicle_1, i) - 1
				vehicle.set_vehicle_mod(vehicle_1, i, mod, true)
				vehicle.toggle_vehicle_mod(vehicle_1, mod, true)

				local mod = vehicle.get_num_vehicle_mods(vehicle_2, i) - 1
				vehicle.set_vehicle_mod(vehicle_2, i, mod, true)
				vehicle.toggle_vehicle_mod(vehicle_2, mod, true)

				local mod = vehicle.get_num_vehicle_mods(vehicle_3, i) - 1
				vehicle.set_vehicle_mod(vehicle_3, i, mod, true)
				vehicle.toggle_vehicle_mod(vehicle_3, mod, true)

				local mod = vehicle.get_num_vehicle_mods(vehicle_4, i) - 1
				vehicle.set_vehicle_mod(vehicle_4, i, mod, true)
				vehicle.toggle_vehicle_mod(vehicle_4, mod, true)
			end
			for j = 0, 20 do
				if vehicle.does_extra_exist(vehicle_1, j) then
					vehicle.set_vehicle_extra(vehicle_1, j, true)
				end
				if vehicle.does_extra_exist(vehicle_2, j) then
					vehicle.set_vehicle_extra(vehicle_2, j, true)
				end
				if vehicle.does_extra_exist(vehicle_3, j) then
					vehicle.set_vehicle_extra(vehicle_3, j, true)
				end
				if vehicle.does_extra_exist(vehicle_4, j) then
					vehicle.set_vehicle_extra(vehicle_4, j, true)
				end
			end
			vehicle.set_vehicle_bulletproof_tires(vehicle_1, true)
			vehicle.set_vehicle_bulletproof_tires(vehicle_2, true)
			vehicle.set_vehicle_bulletproof_tires(vehicle_3, true)
			vehicle.set_vehicle_bulletproof_tires(vehicle_4, true)
			vehicle.set_vehicle_window_tint(vehicle_1, 1)
			vehicle.set_vehicle_window_tint(vehicle_2, 1)
			vehicle.set_vehicle_window_tint(vehicle_3, 1)
			vehicle.set_vehicle_window_tint(vehicle_4, 1)
			vehicle.set_vehicle_number_plate_index(vehicle_1, 1)
			vehicle.set_vehicle_number_plate_index(vehicle_2, 1)
			vehicle.set_vehicle_number_plate_index(vehicle_3, 1)
			vehicle.set_vehicle_number_plate_index(vehicle_4, 1)
			vehicle.set_vehicle_number_plate_text(vehicle_1, " ")
			vehicle.set_vehicle_number_plate_text(vehicle_2, " ")
			vehicle.set_vehicle_number_plate_text(vehicle_3, " ")
			vehicle.set_vehicle_number_plate_text(vehicle_4, " ")
			local time = utils.time_ms() + 500
			while time > utils.time_ms() do
				system.yield(0)
				network.request_control_of_entity(vehicle_1)
				network.request_control_of_entity(vehicle_2)
				network.request_control_of_entity(vehicle_3)
				network.request_control_of_entity(vehicle_4)
				entity.set_entity_coords_no_offset(vehicle_1, player.get_player_coords(pid))
				entity.set_entity_coords_no_offset(vehicle_2, player.get_player_coords(pid))
				entity.set_entity_coords_no_offset(vehicle_3, player.get_player_coords(pid))
				entity.set_entity_coords_no_offset(vehicle_4, player.get_player_coords(pid))
			end
			system.wait(4000)
			network.request_control_of_entity(vehicle_1)
			network.request_control_of_entity(vehicle_2)
			network.request_control_of_entity(vehicle_3)
			network.request_control_of_entity(vehicle_4)
			utilities.hard_remove_entity(vehicle_1)
			utilities.hard_remove_entity(vehicle_2)
			utilities.hard_remove_entity(vehicle_3)
			utilities.hard_remove_entity(vehicle_4)
			menu.notify("[!] Sync Type Mismatch Crash executed successfully.", Meteor)
		else
			menu.notify("[!] You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
    else
        menu.notify("[!] Invalid Player.", Meteor, 3, 211)
    end
end)

menu.add_player_feature("» Crash - 5G Tow Truck", "action_value_str", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			local vehicles = utilities.get_table_of_entities(vehicle.get_all_vehicles(), 1000, 5000, true, true, player.get_player_coords(pid))

			for i = 1, #vehicles do
				network.request_control_of_entity(vehicles[i])
			end

			if #vehicles > 30 then
				menu.notify("[!] 5G Crash: " .. #vehicles .. " valid subjects found! Executing Crash...", Meteor, 4, 0x64FA7800)
				system.wait(1000)

				if f.value == 0 then
					streaming.request_model(2971866336)
					while not streaming.has_model_loaded(2971866336) do
						streaming.request_model(2971866336)
						system.wait(0)
					end
					tow_truck_5g_vehicle = vehicle.create_vehicle(2971866336, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
				elseif f.value == 1 then
					streaming.request_model(3852654278)
					while not streaming.has_model_loaded(3852654278) do
						streaming.request_model(3852654278)
						system.wait(0)
					end
					tow_truck_5g_vehicle = vehicle.create_vehicle(3852654278, utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10), 0, true, false)
				end
				entity.set_entity_god_mode(tow_truck_5g_vehicle, true)
				entity.set_entity_visible(tow_truck_5g_vehicle, false)

				for i = 1, #vehicles do
					network.request_control_of_entity(vehicles[i])
					entity.set_entity_god_mode(vehicles[i], true)
					entity.set_entity_visible(vehicles[i], false)
				end
				for i = 1, #vehicles do
					network.request_control_of_entity(vehicles[i])
					entity.attach_entity_to_entity(vehicles[i], tow_truck_5g_vehicle, 0, v3(), v3(), true, true, false, 0, false)
					system.wait(1)
				end

				local time = utils.time_ms() + 2000
				while time > utils.time_ms() do
					system.yield(0)
					network.request_control_of_entity(player.get_player_ped(pid))
					ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
					for i = 1, #vehicles do
						network.request_control_of_entity(vehicles[i])
						entity.set_entity_coords_no_offset(vehicles[i], utilities.offset_coords_forward(player.get_player_coords(pid) + v3(0, 0, 5), player.get_player_heading(pid), 10))
					end
				end

				utilities.hard_remove_entity(tow_truck_5g_vehicle)

				for i = 1, #vehicles do
					network.request_control_of_entity(vehicles[i])
					utilities.hard_remove_entity(vehicles[i])
				end

				menu.notify("[!] 5G Tow Truck Crash executed successfully.", Meteor)
			else
				menu.notify("[!] 5G Crash: Not enough valid subjects found!", Meteor, 4, 211)
			end
		else
			menu.notify("[!] You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Crash - World Object", "action", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		local object_ = object.create_world_object(3613262246, player.get_player_coords(pid), true, false)
		system.wait(500)
    	entity.delete_entity(object_)
		menu.notify("[!] World Object Crash executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Kick - Ped Component 2 Desync", "action", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if network.get_player_player_is_spectating(player.player_id()) == pid or utilities.get_distance_between(player.get_player_ped(player.player_id()), player.get_player_ped(pid)) < 100 then
			streaming.request_model(0x705E61F2)
			while (not streaming.has_model_loaded(0x705E61F2)) do
				system.wait(0)
			end

			local ped_ = ped.create_ped(1, 0x705E61F2, player.get_player_coords(pid), 0, true, false)
			network.request_control_of_entity(ped_)
			ped.set_ped_ragdoll_blocking_flags(ped_, 1)
			ped.set_ped_combat_ability(ped_, 2)
			ped.set_ped_combat_attributes(ped_, 5, true)
			ped.set_ped_component_variation(ped_, 0, 0, 0, 39, 0)
			ped.set_ped_component_variation(ped_, 1, 104, 25, -1, 0)
			ped.set_ped_component_variation(ped_, 2, 49, 0, -1, 0)
			ped.set_ped_component_variation(ped_, 3, 33, 0, 0)
			ped.set_ped_component_variation(ped_, 4, 84, 0, 0)
			ped.set_ped_component_variation(ped_, 5, 82, 0, 0)
			ped.set_ped_component_variation(ped_, 6, 33, 0, 0)
			ped.set_ped_component_variation(ped_, 7, 0, 0, 0)
			ped.set_ped_component_variation(ped_, 8, 97, 0, 0)
			ped.set_ped_component_variation(ped_, 9, 0, 0, 0)
			ped.set_ped_component_variation(ped_, 10, 0, 0, 0)
			ped.set_ped_component_variation(ped_, 11, 186, 0, 0)
			ped.set_ped_prop_index(ped_, 0, 39, 0)
			ped.set_ped_prop_index(ped_, 1, -1, 0)
			ped.set_ped_prop_index(ped_, 2, -1, 0)
			ped.set_ped_head_blend_data(ped_, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			system.wait(3000)
			script.trigger_script_event(-227800145, pid, {pid, math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
			entity.delete_entity(ped_)
			menu.notify("[!] Ped Component 2 Desync executed successfully.", Meteor)
		else
			menu.notify("[!] You have to spectate the target or be near them in order for this feature to work.", Meteor, 5, 211)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end)

menu.add_player_feature("» Kick - Network Bail", "action_value_str", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(1228916411, pid, {pid, script_func.get_global_main(pid)})
		elseif f.value == 1 then
			script.trigger_script_event(0x493fc6bb, pid, {pid, script_func.get_global_main(pid)})
		elseif f.value == 2 then
			script.trigger_script_event(163598572, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 3 then
			script.trigger_script_event(0x09c050ec, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		end
		menu.notify("[!] Network Bail Kick executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3",
	"v4"
})

menu.add_player_feature("» Kick - Invalid Apartment Invite", "action_value_str", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(0x23F74138, pid, {pid, math.random(32, 2147483647), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 1 then
			script.trigger_script_event(0x23F74138, pid, {pid, math.random(-2147483647, -1), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		end
		menu.notify("[!] Invalid Apartment Invite Kick executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Kick - Script Event", "action_value_str", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(0x493FC6BB, pid, {pid, script_func.get_global_main(pid), pid})
		elseif f.value == 1 then
			script.trigger_script_event(0x37437C28, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 2 then
			script.trigger_script_event(-1308840134, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 3 then
			script.trigger_script_event(0x4E0350C6, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 4 then
			script.trigger_script_event(-0x15F5B1D4, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 5 then
			script.trigger_script_event(-0x249FE11B, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 6 then
			script.trigger_script_event(-0x76B11968, pid, {math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 7 then
			script.trigger_script_event(0x493FC6BB, pid, {pid, script_func.get_global_main(pid)})
		elseif f.value == 8 then
			script.trigger_script_event(0x23F74138, pid, {pid, math.random(32, 2147483647), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		elseif f.value == 9 then
			script.trigger_script_event(1757755807, pid, {pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 10 then
			script.trigger_script_event(-1991317864, pid, {pid, -1, -1, -1, -1})
		elseif f.value == 11 then
			local parameters = {
				pid
			}
			for i = 2, 23 do
				parameters[#parameters + 1] = math.random(-2147483647, -10)
			end
			script.trigger_script_event(-614457627, pid, parameters)
		elseif f.value == 12 then
			script.trigger_script_event(-569621836, pid, {pid, 13644241, 505873})
		elseif f.value == 13 then
			script.trigger_script_event(-227800145, pid, {pid, pid, math.random(-2147483647, 2147483647), 2361235669, math.random(-2147483647, 2147483647), 263261, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), 215132521, 5262462321, math.random(-2147483647, 2147483647), pid})
		end
		menu.notify("[!] Script Event Kick executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3",
	"v4",
	"v5",
	"v6",
	"v7",
	"v8",
	"v9",
	"v10",
	"v11",
	"v12"
})

menu.add_player_feature("» Kick - Jumper", "action_value_str", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(-227800145, pid, {pid, math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		elseif f.value == 1 then
			script.trigger_script_event(69874647, pid, {pid, math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		end
		menu.notify("[!] Jumper Kick executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2"
})

menu.add_player_feature("» Kick - Freemode Death", "action_value_str", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if f.value == 0 then
			script.trigger_script_event(911179316, pid, {pid, pid, pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 1 then
			script.trigger_script_event(-65587051, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 2 then
			script.trigger_script_event(-65587051, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 3 then
			script.trigger_script_event(1116398805, pid, {pid, pid, math.random(-2147483647, 2147483647), pid})
		elseif f.value == 4 then
			script.trigger_script_event(-1846290480, pid, {pid, pid, 25, 0, 1242, pid})
		end
		menu.notify("[!] Freemode Death Kick executed successfully.", Meteor)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end):set_str_data({
	"v1",
	"v2",
	"v3",
	"v4",
	"v5"
})

menu.add_player_feature("» Kick - Host Kick", "action", playerparents["» Crashes/Kicks"], function(f, pid)
	if player.is_player_valid(pid) then
		if network.network_is_host() then
			network.network_session_kick_player(pid)
			menu.notify("[!] Host Kick executed successfully.", Meteor)
		else
			menu.notify("[!] You have to be Host in order to use this feature.", Meteor, 3, 211)
		end
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end	
end)

if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorDev\\MeteorDev.lua") then
	meteordevplayercrashes = menu.add_player_feature("» Dev Crashes/Kicks", "parent", playerparents["» Crashes/Kicks"]).id
end

--

menu.add_player_feature("» Copy ScId", "action", playerparents["» Copy Info"], function(f, pid)
	utils.to_clipboard(tostring(player.get_player_scid(pid)))
end)

menu.add_player_feature("» Copy IP", "action", playerparents["» Copy Info"], function(f, pid)
	utils.to_clipboard(utilities.dec_to_ipv4(player.get_player_ip(pid)))
end)

menu.add_player_feature("» Copy Position", "action", playerparents["» Copy Info"], function(f, pid)
	local string = tostring(player.get_player_coords(pid)):match("v3%(([%d%-%.%,%s]+)%)")
	utils.to_clipboard(string)
end)

menu.add_player_feature("» Copy Money", "action", playerparents["» Copy Info"], function(f, pid)
	utils.to_clipboard(tostring(script_func.get_player_money(pid)))
end)

menu.add_player_feature("» Copy Position Without Dec", "action", playerparents["» Copy Info"], function(f, pid)
	local pos = player.get_player_coords(pid)
	utils.to_clipboard(tostring(utilities.round(pos.x)..", "..utilities.round(pos.y)..", "..utilities.round(pos.z)))
end)

menu.add_player_feature("» Copy Host Token", "action", playerparents["» Copy Info"], function(f, pid)
	utils.to_clipboard(select(1, string.format("%x", player.get_player_host_token(pid))))
end)

menu.add_player_feature("» Copy Level", "action", playerparents["» Copy Info"], function(f, pid)
	utils.to_clipboard(tostring(script_func.get_player_rank(pid)))
end)

menu.add_player_feature("» Copy Vehicle Hash", "action", playerparents["» Copy Info"], function(f, pid)
	utils.to_clipboard(tostring(entity.get_entity_model_hash(player.get_player_vehicle(pid))))
end)

menu.add_player_feature("» Copy Vehicle", "action", playerparents["» Copy Info"], function(f, pid)
	local brand = vehicle.get_vehicle_brand(player.get_player_vehicle(pid)) or ""
	if brand ~= "" then
		brand = brand.." "
	end
	utils.to_clipboard(brand..tostring(vehicle.get_vehicle_model(player.get_player_vehicle(pid))))
end)

menu.add_player_feature("» Copy Ped Hash", "action", playerparents["» Copy Info"], function(f, pid)
	utils.to_clipboard(tostring(entity.get_entity_model_hash(player.get_player_ped(pid))))
end)

--

menu.add_player_feature("» Whitelist", "toggle", playerparents["» Modder Options"], function(f, pid)
	if f.on then
		IsPlayerWhitelisted[pid] = true
	end
	if not f.on then
		IsPlayerWhitelisted[pid] = false
	end
end)

menu.add_player_feature("» Mark Player As Modder", "action_value_str", playerparents["» Modder Options"], function(f, pid)
	if f.value == 0 then
		player.set_player_as_modder(pid, -1)
	elseif f.value == 1 then
		player.set_player_as_modder(pid, 1)
	elseif f.value == 2 then
		player.set_player_as_modder(pid, 2)
	elseif f.value == 3 then
		player.set_player_as_modder(pid, 4)
	elseif f.value == 4 then
		player.set_player_as_modder(pid, 8)
	elseif f.value == 5 then
		player.set_player_as_modder(pid, 16)
	elseif f.value == 6 then
		player.set_player_as_modder(pid, 32)
	elseif f.value == 7 then
		player.set_player_as_modder(pid, 64)
	elseif f.value == 8 then
		player.set_player_as_modder(pid, 128)
	elseif f.value == 9 then
		player.set_player_as_modder(pid, 256)
	elseif f.value == 10 then
		player.set_player_as_modder(pid, 512)
	elseif f.value == 11 then
		player.set_player_as_modder(pid, 1024)
	elseif f.value == 12 then
		player.set_player_as_modder(pid, 2048)
	elseif f.value == 13 then
		player.set_player_as_modder(pid, 4096)
	elseif f.value == 14 then
		player.set_player_as_modder(pid, 8192)
	elseif f.value == 15 then
		player.set_player_as_modder(pid, 16384)
	elseif f.value == 16 then
		player.set_player_as_modder(pid, 32768)
	elseif f.value == 17 then
		player.set_player_as_modder(pid, 65536)
	elseif f.value == 18 then
		player.set_player_as_modder(pid, 131072)
	elseif f.value == 19 then
		player.set_player_as_modder(pid, 262144)
	elseif f.value == 20 then
		player.set_player_as_modder(pid, 524288)
	elseif f.value == 21 then
		player.set_player_as_modder(pid, 1048576)
	elseif f.value == 22 then
		player.set_player_as_modder(pid, 2097152)
	elseif f.value == 23 then
		player.set_player_as_modder(pid, 4194304)
	elseif f.value == 24 then
		player.set_player_as_modder(pid, custommodderflags["Modded Health"])
	elseif f.value == 25 then
		player.set_player_as_modder(pid, custommodderflags["Invalid SCID"])
	elseif f.value == 26 then
		player.set_player_as_modder(pid, custommodderflags["Invalid Name"])
	elseif f.value == 27 then
		player.set_player_as_modder(pid, custommodderflags["Godmode"])
	elseif f.value == 28 then
		player.set_player_as_modder(pid, custommodderflags["Bad Script Event"])
	elseif f.value == 29 then
		player.set_player_as_modder(pid, custommodderflags["Bad Net Event"])
	elseif f.value == 30 then
		player.set_player_as_modder(pid, custommodderflags["Stand User"])
	elseif f.value == 31 then
		player.set_player_as_modder(pid, custommodderflags["Invalid Stats"])
	elseif f.value == 32 then
		player.set_player_as_modder(pid, custommodderflags["Max Speed Bypass"])
	elseif f.value == 33 then
		player.set_player_as_modder(pid, custommodderflags["Invalid IP"])
	elseif f.value == 34 then
		player.set_player_as_modder(pid, custommodderflags["Session Host Crash"])
	elseif f.value == 35 then
		player.set_player_as_modder(pid, custommodderflags["Bad Outfit Data"])
	elseif f.value == 36 then
		player.set_player_as_modder(pid, custommodderflags["Altered SH Migration"])
	elseif f.value == 37 then
		player.set_player_as_modder(pid, custommodderflags["Fake Typing Indicator"])
	elseif f.value == 38 then
		player.set_player_as_modder(pid, custommodderflags["Modded Spectate"])
	elseif f.value == 39 then
		player.set_player_as_modder(pid, custommodderflags["Modded OTR"])
	end
end):set_str_data({
	"All", "Manual", "Player Model", "SCID Spoof", "Invalid Object", "Invalid Ped Crash", "Model Change Crash", "Player Model Change", "RAC", "Money Drop", "SEP", "Attach Object", "Attach Ped", "Net Array Crash", "Net Sync Crash", "Net Event Crash", "Altered Host Token", "SE Spam", "Invalid Vehicle", "Frame Flags", "IP Spoof", "Karen", "Session Mismatch", "Sound Spam", "Modded Health", "Invalid SCID", "Invalid Name", "Godmode", "Bad Script Event", "Bad Net Event", "Stand User", "Invalid Stats", "Max Speed Bypass", "Invalid IP", "Session Host Crash", "Bad Outfit Data", "Altered SH Migration", "Fake Typing Indicator", "Modded Spectate", "Modded OTR"
})

menu.add_player_feature("» UnMark Player As Modder", "action_value_str", playerparents["» Modder Options"], function(f, pid)
	if f.value == 0 then
		player.unset_player_as_modder(pid, -1)
	elseif f.value == 1 then
		player.unset_player_as_modder(pid, 1)
	elseif f.value == 2 then
		player.unset_player_as_modder(pid, 2)
	elseif f.value == 3 then
		player.unset_player_as_modder(pid, 4)
	elseif f.value == 4 then
		player.unset_player_as_modder(pid, 8)
	elseif f.value == 5 then
		player.unset_player_as_modder(pid, 16)
	elseif f.value == 6 then
		player.unset_player_as_modder(pid, 32)
	elseif f.value == 7 then
		player.unset_player_as_modder(pid, 64)
	elseif f.value == 8 then
		player.unset_player_as_modder(pid, 128)
	elseif f.value == 9 then
		player.unset_player_as_modder(pid, 256)
	elseif f.value == 10 then
		player.unset_player_as_modder(pid, 512)
	elseif f.value == 11 then
		player.unset_player_as_modder(pid, 1024)
	elseif f.value == 12 then
		player.unset_player_as_modder(pid, 2048)
	elseif f.value == 13 then
		player.unset_player_as_modder(pid, 4096)
	elseif f.value == 14 then
		player.unset_player_as_modder(pid, 8192)
	elseif f.value == 15 then
		player.unset_player_as_modder(pid, 16384)
	elseif f.value == 16 then
		player.unset_player_as_modder(pid, 32768)
	elseif f.value == 17 then
		player.unset_player_as_modder(pid, 65536)
	elseif f.value == 18 then
		player.unset_player_as_modder(pid, 131072)
	elseif f.value == 19 then
		player.unset_player_as_modder(pid, 262144)
	elseif f.value == 20 then
		player.unset_player_as_modder(pid, 524288)
	elseif f.value == 21 then
		player.unset_player_as_modder(pid, 1048576)
	elseif f.value == 22 then
		player.unset_player_as_modder(pid, 2097152)
	elseif f.value == 23 then
		player.unset_player_as_modder(pid, 4194304)
	elseif f.value == 24 then
		player.unset_player_as_modder(pid, custommodderflags["Modded Health"])
	elseif f.value == 25 then
		player.unset_player_as_modder(pid, custommodderflags["Invalid SCID"])
	elseif f.value == 26 then
		player.unset_player_as_modder(pid, custommodderflags["Invalid Name"])
	elseif f.value == 27 then
		player.unset_player_as_modder(pid, custommodderflags["Godmode"])
	elseif f.value == 28 then
		player.unset_player_as_modder(pid, custommodderflags["Bad Script Event"])
	elseif f.value == 29 then
		player.unset_player_as_modder(pid, custommodderflags["Bad Net Event"])
	elseif f.value == 30 then
		player.unset_player_as_modder(pid, custommodderflags["Stand User"])
	elseif f.value == 31 then
		player.unset_player_as_modder(pid, custommodderflags["Invalid Stats"])
	elseif f.value == 32 then
		player.unset_player_as_modder(pid, custommodderflags["Max Speed Bypass"])
	elseif f.value == 33 then
		player.unset_player_as_modder(pid, custommodderflags["Invalid IP"])
	elseif f.value == 34 then
		player.unset_player_as_modder(pid, custommodderflags["Session Host Crash"])
	elseif f.value == 35 then
		player.unset_player_as_modder(pid, custommodderflags["Bad Outfit Data"])
	elseif f.value == 36 then
		player.unset_player_as_modder(pid, custommodderflags["Altered SH Migration"])
	elseif f.value == 37 then
		player.unset_player_as_modder(pid, custommodderflags["Fake Typing Indicator"])
	elseif f.value == 38 then
		player.unset_player_as_modder(pid, custommodderflags["Modded Spectate"])
	elseif f.value == 39 then
		player.unset_player_as_modder(pid, custommodderflags["Modded OTR"])
	end
end):set_str_data({
	"All", "Manual", "Player Model", "SCID Spoof", "Invalid Object", "Invalid Ped Crash", "Model Change Crash", "Player Model Change", "RAC", "Money Drop", "SEP", "Attach Object", "Attach Ped", "Net Array Crash", "Net Sync Crash", "Net Event Crash", "Altered Host Token", "SE Spam", "Invalid Vehicle", "Frame Flags", "IP Spoof", "Karen", "Session Mismatch", "Sound Spam", "Modded Health", "Invalid SCID", "Invalid Name", "Godmode", "Bad Script Event", "Bad Net Event", "Stand User", "Invalid Stats", "Max Speed Bypass", "Invalid IP", "Session Host Crash", "Bad Outfit Data", "Altered SH Migration", "Fake Typing Indicator", "Modded Spectate", "Modded OTR"
})

menu.add_player_feature("» Modder Flag Notify", "action_value_str", playerparents["» Modder Options"], function(f, pid)
	if f.value == 0 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Manual", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Player Model", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: SCID Spoof", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Object", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Ped Crash", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Model Change Crash", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Player Model Change", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: RAC", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Money Drop", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Attach Object", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Attach Ped", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Net Array Crash", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Net Sync Crash | Invalid Data 1", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Net Event Crash", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Altered Host Token | Low Host Token", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: SE Spam", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Vehicle", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Frame Flags", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: IP Spoof", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Karen", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Session Mismatch", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Sound Spam", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded Health", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid SCID", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Name", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Godmode", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Bad Script Event", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Bad Net Event", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Stand User", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Stats", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Max Speed Bypass", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid IP", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Session Host Crash", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Bad Outfit Data", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Altered SH Migration", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Fake Typing Indicator Detection", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded Spectate", "Modder Detection", 12, 0x00A2FF)
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded OTR", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 1 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Manual", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 2 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Player Model", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 3 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: SCID Spoof", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 4 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Object", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 5 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Ped Crash", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 6 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Model Change Crash", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 7 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Player Model Change", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 8 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: RAC", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 9 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Money Drop", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 10 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: SEP", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 11 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Attach Object", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 12 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Attach Ped", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 13 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Net Array Crash", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 14 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Net Sync Crash | Invalid Data 1", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 15 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Net Event Crash", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 16 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Altered Host Token | Low Host Token", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 17 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: SE Spam", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 18 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Vehicle", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 19 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Frame Flags", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 20 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: IP Spoof", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 21 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Karen", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 22 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Session Mismatch", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 23 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Sound Spam", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 24 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded Health", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 25 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid SCID", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 26 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Name", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 27 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Godmode", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 28 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Bad Script Event", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 29 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Bad Net Event", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 30 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Stand User", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 31 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid Stats", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 32 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Max Speed Bypass", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 33 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Invalid IP", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 34 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Session Host Crash", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 35 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Bad Outfit Data", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 36 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Altered SH Migration", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 37 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Fake Typing Indicator", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 38 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded Spectate", "Modder Detection", 12, 0x00A2FF)
	elseif f.value == 39 then
		menu.notify("Player: " .. string.format("%s", player.get_player_name(pid)) .. "\nReason: Modded OTR", "Modder Detection", 12, 0x00A2FF)
	end
end):set_str_data({
	"All", "Manual", "Player Model", "SCID Spoof", "Invalid Object", "Invalid Ped Crash", "Model Change Crash", "Player Model Change", "RAC", "Money Drop", "SEP", "Attach Object", "Attach Ped", "Net Array Crash", "Net Sync Crash", "Net Event Crash", "Altered Host Token", "SE Spam", "Invalid Vehicle", "Frame Flags", "IP Spoof", "Karen", "Session Mismatch", "Sound Spam", "Modded Health", "Invalid SCID", "Invalid Name", "Godmode", "Bad Script Event", "Bad Net Event", "Stand User", "Invalid Stats", "Max Speed Bypass", "Invalid IP", "Session Host Crash", "Bad Outfit Data", "Altered SH Migration", "Fake Typing Indicator", "Modded Spectate", "Modded OTR"
})

menu.add_player_feature("» Add To Spoofer Profiles", "action", playerparents["» Meteor"], function(f, pid)
	if player.is_player_valid(pid) then
		local random_id = math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9)
		if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\spoofer", "") .. "\\" .. random_id .. ".ini") then
			menu.notify("[!] Failed to add player to spoofer profiles, please try again.", Meteor, 3, 211)
		else
			utilities.write(io.open(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\spoofer", "") .. "\\" .. random_id .. ".ini", "w"), "[Profile]\nname=" .. string.format("%s", player.get_player_name(pid)) .. "\nscid=" .. player.get_player_scid(pid) .. "\nhost_token=" .. player.get_player_host_token(pid) .. "\nlevel=" .. script_func.get_player_rank(pid) .. "\nmoney_wallet=" .. script_func.get_player_wallet(pid) .. "\ndev=0\nip=" .. player.get_player_ip(pid) .. "\nmoney_total=" .. script_func.get_player_money(pid) .. "\nkd=" .. script_func.get_player_kd(pid) .. "")
		end
		system.wait(100)
		if utils.file_exists(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\spoofer", "") .. "\\" .. random_id .. ".ini") then
			menu.notify("[!] Successfully added player to spoofer profiles!", Meteor, 3, 0x00ff00)
		else
			menu.notify("[!] Failed to add player to spoofer profiles, please try again.", Meteor, 3, 211)
		end
	end
end)

--

do
	if  settings["» Display Welcome Screen"] then
		menu.create_thread(function()
			script_execute_scaleform = graphics.request_scaleform_movie("mp_big_message_freemode")
			local time = utils.time_ms() + 4000
			audio.play_sound_from_coord(-1, "LOSER", player.get_player_coords(player.player_id()), "HUD_AWARDS", false, 0, true)
			threads["» Script Execute"] = menu.create_thread(function()
				while time > utils.time_ms() do
					system.yield(0)
					graphics.begin_scaleform_movie_method(script_execute_scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
					graphics.draw_scaleform_movie_fullscreen(script_execute_scaleform, 255, 255, 255, 255, 0)
					graphics.scaleform_movie_method_add_param_texture_name_string("Welcome")
					if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorDev\\MeteorDev.lua") then
						graphics.scaleform_movie_method_add_param_texture_name_string("Meteor V0.5.1 - 246 [Dev]")
					else
						graphics.scaleform_movie_method_add_param_texture_name_string("Meteor V0.5.1 - 246")
					end
					graphics.end_scaleform_movie_method(script_execute_scaleform)
				end
			end, nil)
			system.wait(4000)
			audio.play_sound_from_coord(-1, "CHECKPOINT_AHEAD", player.get_player_coords(player.player_id()), "HUD_MINI_GAME_SOUNDSET", false, 0, true)
			graphics.set_scaleform_movie_as_no_longer_needed(script_execute_scaleform)
			menu.delete_thread(threads["» Script Execute"])
		end, nil)
	end
end

if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorDev\\MeteorDev.lua") then
	menu.notify("[!] Loaded Script Successfully!\n\n[!] Dev Build 0.5.1 - 246", Meteor, 5, 0x00ff00)
else
	menu.notify("[!] Loaded Script Successfully!\n\n[!] Build 0.5.1 - 246", Meteor, 5, 0x00ff00)
end

--

listeners["Menu Unload"] = event.add_event_listener("exit", function()
	if ptfxs["» Dragon Breath"] then
		graphics.remove_particle_fx(ptfxs["» Dragon Breath"], true)
		ptfxs["» Dragon Breath"] = nil
	end
	if objects["» Dragon Breath"] then
		utilities.clear_ptfx(objects["» Dragon Breath"])
		objects["» Dragon Breath"] = nil
	end
	graphics.remove_named_ptfx_asset("weap_xs_vehicle_weapons")
	if ptfxs["» Fire Wings 1"] then
		graphics.remove_particle_fx(ptfxs["» Fire Wings 1"], true)
		ptfxs["» Fire Wings 1"] = nil
		utilities.clear_ptfx(objects["» Fire Wings 1"])
		objects["» Fire Wings 1"] = nil
	end
	if ptfxs["» Fire Wings 2"] then
		graphics.remove_particle_fx(ptfxs["» Fire Wings 2"], true)
		ptfxs["» Fire Wings 2"] = nil
		utilities.clear_ptfx(objects["» Fire Wings 2"])
		objects["» Fire Wings 2"] = nil
	end
	if ptfxs["» Fire Wings 3"] then
		graphics.remove_particle_fx(ptfxs["» Fire Wings 3"], true)
		ptfxs["» Fire Wings 3"] = nil
		utilities.clear_ptfx(objects["» Fire Wings 3"])
		objects["» Fire Wings 3"] = nil
	end
	if ptfxs["» Fire Wings 4"] then
		graphics.remove_particle_fx(ptfxs["» Fire Wings 4"], true)
		ptfxs["» Fire Wings 4"] = nil
		utilities.clear_ptfx(objects["» Fire Wings 4"])
		objects["» Fire Wings 4"] = nil
	end
	if ptfxs["» Fire Wings 5"] then
		graphics.remove_particle_fx(ptfxs["» Fire Wings 5"], true)
		ptfxs["» Fire Wings 5"] = nil
		utilities.clear_ptfx(objects["» Fire Wings 5"])
		objects["» Fire Wings 5"] = nil
	end
	if ptfxs["» Fire Wings 6"] then
		graphics.remove_particle_fx(ptfxs["» Fire Wings 6"], true)
		ptfxs["» Fire Wings 6"] = nil
		utilities.clear_ptfx(objects["» Fire Wings 6"])
		objects["» Fire Wings 6"] = nil
	end
	if ptfxs["» Fire Wings 7"] then
		graphics.remove_particle_fx(ptfxs["» Fire Wings 7"], true)
		ptfxs["» Fire Wings 7"] = nil
		utilities.clear_ptfx(objects["» Fire Wings 7"])
		objects["» Fire Wings 7"] = nil
	end
	if ptfxs["» Fire Wings 8"] then
		graphics.remove_particle_fx(ptfxs["» Fire Wings 8"], true)
		ptfxs["» Fire Wings 8"] = nil
		utilities.clear_ptfx(objects["» Fire Wings 8"])
		objects["» Fire Wings 8"] = nil
	end
	if objects["» Attach Ladder"] then
		entity.delete_entity(objects["» Attach Ladder"])
		objects["» Attach Ladder"] = nil
	end
	if objects["» Attach Ladder 1"] then
		entity.delete_entity(objects["» Attach Ladder 1"])
		objects["» Attach Ladder 1"] = nil
	end
	if objects["» Attach Ladder 2"] then
		entity.delete_entity(objects["» Attach Ladder 2"])
		objects["» Attach Ladder 2"] = nil
	end
	if objects["» Attach Ladder 3"] then
		entity.delete_entity(objects["» Attach Ladder 3"])
		objects["» Attach Ladder 3"] = nil
	end
	if objects["» Attach Ladder 4"] then
		entity.delete_entity(objects["» Attach Ladder 4"])
		objects["» Attach Ladder 4"] = nil
	end
	if threads["» Attach Ladder"] then
		menu.delete_thread(threads["» Attach Ladder"])
	end
	if threads["» Fire Wings 1"] then
		menu.delete_thread(threads["» Fire Wings 1"])
	end
	if threads["» Fire Wings 2"] then
		menu.delete_thread(threads["» Fire Wings 2"])
	end
	if threads["» Fire Wings 3"] then
		menu.delete_thread(threads["» Fire Wings 3"])
	end
	if threads["» Fire Wings 4"] then
		menu.delete_thread(threads["» Fire Wings 4"])
	end
	if threads["» Fire Wings 5"] then
		menu.delete_thread(threads["» Fire Wings 5"])
	end
	if threads["» Fire Wings 6"] then
		menu.delete_thread(threads["» Fire Wings 6"])
	end
	if threads["» Fire Wings 7"] then
		menu.delete_thread(threads["» Fire Wings 7"])
	end
	if threads["» Fire Wings 8"] then
		menu.delete_thread(threads["» Fire Wings 8"])
	end
	graphics.remove_named_ptfx_asset("weap_xs_vehicle_weapons")
	if ptfxs["» Sparks 1"] then
		graphics.remove_particle_fx(ptfxs["» Sparks 1"], true)
		ptfxs["» Sparks 1"] = nil
		utilities.clear_ptfx(ptfxs["» Sparks 1"])
		ptfxs["» Sparks 1"] = nil
		graphics.remove_particle_fx(ptfxs["» Sparks 2"], true)
		ptfxs["» Sparks 2"] = nil
		utilities.clear_ptfx(ptfxs["» Sparks 2"])
		ptfxs["» Sparks 2"] = nil
		graphics.remove_particle_fx(objects["» Sparks 1"], true)
		objects["» Sparks 1"] = nil
		utilities.clear_ptfx(objects["» Sparks 1"])
		objects["» Sparks 1"] = nil
		graphics.remove_particle_fx(objects["» Sparks 2"], true)
		objects["» Sparks 2"] = nil
		utilities.clear_ptfx(objects["» Sparks 2"])
		objects["» Sparks 2"] = nil
		graphics.remove_named_ptfx_asset("scr_reconstructionaccident")
		settings["Sparks Hand Trails"] = false
	end
	if ptfxs["» Flames 1"] then
		graphics.remove_particle_fx(ptfxs["» Flames 1"], true)
		ptfxs["» Flames 1"] = nil
		utilities.clear_ptfx(ptfxs["» Flames 1"])
		ptfxs["» Flames 1"] = nil
		graphics.remove_particle_fx(ptfxs["» Flames 2"], true)
		ptfxs["» Flames 2"] = nil
		utilities.clear_ptfx(ptfxs["» Flames 2"])
		ptfxs["» Flames 2"] = nil
		graphics.remove_particle_fx(objects["» Flames 1"], true)
		objects["» Flames 1"] = nil
		utilities.clear_ptfx(objects["» Flames 1"])
		objects["» Flames 1"] = nil
		graphics.remove_particle_fx(objects["» Flames 2"], true)
		objects["» Flames 2"] = nil
		utilities.clear_ptfx(objects["» Flames 2"])
		objects["» Flames 2"] = nil
		graphics.remove_named_ptfx_asset("core")
		settings["Flame Hand Trails"] = false
	end
	if ptfxs["» Flamethrower"] then
		graphics.remove_particle_fx(ptfxs["» Flamethrower"], true)
		ptfxs["» Flamethrower"] = nil
		utilities.clear_ptfx(objects["» Flamethrower"])
		objects["» Flamethrower"] = nil
	end
	if objects["» Flamethrower"] then
		graphics.remove_particle_fx(ptfxs["» Flamethrower"], true)
		ptfxs["» Flamethrower"] = nil
		utilities.clear_ptfx(objects["» Flamethrower"])
		objects["» Flamethrower"] = nil
	end
	if eventhooks["» Main Script Event Hook"] then
		hook.remove_script_event_hook(eventhooks["» Main Script Event Hook"])
		eventhooks["» Main Script Event Hook"] = nil
	end
	if eventhooks["» Main Net Event Hook"] then
		hook.remove_net_event_hook(eventhooks["» Main Net Event Hook"])
		eventhooks["» Main Net Event Hook"] = nil
	end
	if listeners["» Main Modder Event Listener"] then
		event.remove_event_listener("modder", listeners["» Main Modder Event Listener"])
		listeners["» Main Modder Event Listener"] = nil
	end
	if listeners["» Main Chat Event Listener"] then
		event.remove_event_listener("chat", listeners["» Main Chat Event Listener"])
		listeners["» Main Chat Event Listener"] = nil
	end
	if listeners["» Main Player Leave Event Listener"] then
		event.remove_event_listener("player_leave", listeners["» Main Player Leave Event Listener"])
		listeners["» Main Player Leave Event Listener"] = nil
	end
	if listeners["» Main Player Join Event Listener"] then
		event.remove_event_listener("player_join", listeners["» Main Player Join Event Listener"])
		listeners["» Main Player Join Event Listener"] = nil
	end
	streaming.remove_anim_dict("mp_am_hold_up")
	streaming.remove_anim_set("handsup_base")
	streaming.remove_anim_dict("random@arrests@busted")
	streaming.remove_anim_set("idle_c")
	streaming.remove_anim_dict("random@arrests")
	streaming.remove_anim_set("kneeling_arrest_idle")
	graphics.remove_named_ptfx_asset("weap_xs_vehicle_weapons")
	graphics.remove_named_ptfx_asset("scr_reconstructionaccident")
	graphics.remove_named_ptfx_asset("scr_trevor1")
	graphics.remove_named_ptfx_asset("core")
	graphics.remove_named_ptfx_asset("scr_agencyheistb")
	graphics.remove_named_ptfx_asset("scr_rcbarry1")
	graphics.remove_named_ptfx_asset("scr_recartheft")
	streaming.set_model_as_no_longer_needed(0xE75B4B1C)
	streaming.set_model_as_no_longer_needed(165154707)
	streaming.set_model_as_no_longer_needed(970598228)
	streaming.set_model_as_no_longer_needed(368211810)
	streaming.set_model_as_no_longer_needed(0x616C97B9)
	streaming.set_model_as_no_longer_needed(1058115860)
	streaming.set_model_as_no_longer_needed(0x761E2AD3)
	streaming.set_model_as_no_longer_needed(-150975354)
	streaming.set_model_as_no_longer_needed(621481054)
	streaming.set_model_as_no_longer_needed(0xD74B8139)
	streaming.set_model_as_no_longer_needed(0x2EA68690)
	streaming.set_model_as_no_longer_needed(0xA09E15FD)
	streaming.set_model_as_no_longer_needed(0x7ED5AD78)
	streaming.set_model_as_no_longer_needed(0xB5CF80E4)
	streaming.set_model_as_no_longer_needed(0x90EF5134)
	streaming.set_model_as_no_longer_needed(0x705E61F2)
	streaming.set_model_as_no_longer_needed(193469166)
	streaming.set_model_as_no_longer_needed(0x3F039CBA)
	streaming.set_model_as_no_longer_needed(0x856CFB02)
	streaming.set_model_as_no_longer_needed(0x2D7030F3)
	streaming.set_model_as_no_longer_needed(0xE5A2D6C6)
	streaming.set_model_as_no_longer_needed(0x82CAC433)
	streaming.set_model_as_no_longer_needed(0xB12314E0)
	streaming.set_model_as_no_longer_needed(0xAF10BD56)
	streaming.set_model_as_no_longer_needed(0x9B810FA2)
	streaming.set_model_as_no_longer_needed(0x72C0CAD2)
	streaming.set_model_as_no_longer_needed(0xFE0A508C)
	streaming.set_model_as_no_longer_needed(0x3DC92356)
	streaming.set_model_as_no_longer_needed(0xC5DD6967)
	streaming.set_model_as_no_longer_needed(3545667823)
	streaming.set_model_as_no_longer_needed(1951415382)
	if threads["» Shoot Fake Money Bags 1"] then
		menu.delete_thread(threads["» Shoot Fake Money Bags 1"])
	end
	if threads["» Shoot Stones"] then
		menu.delete_thread(threads["» Shoot Stones"])
		threads["» Shoot Stones"] = nil
	end
	if threads["» Shoot Dogshit"] then
		menu.delete_thread(threads["» Shoot Dogshit"])
		threads["» Shoot Dogshit"] = nil
	end
	if threads["» Fake Money Bag Drop"] then
		menu.delete_thread(threads["» Fake Money Bag Drop"])
	end
	if threads["» Drop Fake Money Bag 2"] then
		menu.delete_thread(threads["» Drop Fake Money Bag 2"])
	end
	if threads["» Drop Fake Money Bag 1"] then
		menu.delete_thread(threads["» Drop Fake Money Bag 1"])
	end
	if threads["» Fake RP Drop"] then
		menu.delete_thread(threads["» Fake RP Drop"])
	end
	if threads["» Drop Fake RP 2"] then
		menu.delete_thread(threads["» Drop Fake RP 2"])
	end
	if threads["» Drop Fake RP 1"] then
		menu.delete_thread(threads["» Drop Fake RP 1"])
	end
	if threads["» Fake Health Drop"] then
		menu.delete_thread(threads["» Fake Health Drop"])
	end
	if threads["» Drop Fake Health 2"] then
		menu.delete_thread(threads["» Drop Fake Health 2"])
	end
	if threads["» Drop Fake Health 1"] then
		menu.delete_thread(threads["» Drop Fake Health 1"])
	end
	if threads["» Fake Armor Drop"] then
		menu.delete_thread(threads["» Fake Armor Drop"])
	end
	if threads["» Drop Fake Armor 2"] then
		menu.delete_thread(threads["» Drop Fake Armor 2"])
	end
	if threads["» Drop Fake Armor 1"] then
		menu.delete_thread(threads["» Drop Fake Armor 1"])
	end
	if threads["» Fake P's & Q's Drop"] then
		menu.delete_thread(threads["» Fake P's & Q's Drop"])
	end
	if threads["» Drop Fake P's & Q's 2"] then
		menu.delete_thread(threads["» Drop Fake P's & Q's 2"])
	end
	if threads["» Drop Fake P's & Q's 1"] then
		menu.delete_thread(threads["» Drop Fake P's & Q's 1"])
	end
	if threads["» Ped Pickup Recovery"] then
		menu.delete_thread(threads["» Ped Pickup Recovery"])
	end
	entity.set_entity_collision(player.get_player_ped(player.player_id()), true, true, false)
	entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	if launch_guided_missile_previous_pos then
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), launch_guided_missile_previous_pos)
	end
	if launch_guided_missile_scaleform then
		graphics.set_scaleform_movie_as_no_longer_needed(launch_guided_missile_scaleform)
	end
	if launch_guided_missile_scaleform_2 then
		graphics.set_scaleform_movie_as_no_longer_needed(launch_guided_missile_scaleform_2)
	end
	launch_guided_missile_pos_tp = nil
	launch_guided_missile_pos = nil
	if guided_missile_object then
		utilities.hard_remove_entity(guided_missile_object)
		guided_missile_object = nil
	end
	if ped_pickup_recovery_previous_pos then
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), ped_pickup_recovery_previous_pos)
		ped_pickup_recovery_previous_pos = nil
	end
	if save_current_pos then
		save_current_pos = nil
	end
	if model_change_object_ then
		entity.delete_entity(model_change_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if world_model_change_object_ then
		entity.delete_entity(world_model_change_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_pizza_box_02_object_ then
		entity.delete_entity(prop_pizza_box_02_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_pineapple_object_ then
		entity.delete_entity(prop_pineapple_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_streetlight_05_object_ then
		entity.delete_entity(prop_streetlight_05_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_traffic_01a_object_ then
		entity.delete_entity(prop_traffic_01a_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_ecola_can_object_ then
		entity.delete_entity(prop_ecola_can_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_bin_05a_object_ then
		entity.delete_entity(prop_bin_05a_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_money_bag_01_object_ then
		entity.delete_entity(prop_money_bag_01_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if hei_prop_cash_crate_empty_object_ then
		entity.delete_entity(hei_prop_cash_crate_empty_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_wine_red_object_ then
		entity.delete_entity(prop_wine_red_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_cash_case_02_object_ then
		entity.delete_entity(prop_cash_case_02_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_cash_pile_02_object_ then
		entity.delete_entity(prop_cash_pile_02_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_fire_hydrant_1_object_ then
		entity.delete_entity(prop_fire_hydrant_1_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_streetlight_05_object_ then
		entity.delete_entity(prop_streetlight_05_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_tree_cedar_s_01_object_ then
		entity.delete_entity(prop_tree_cedar_s_01_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_cs_burger_01_object_ then
		entity.delete_entity(prop_cs_burger_01_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if prop_turkey_leg_01_object_ then
		entity.delete_entity(prop_turkey_leg_01_object_)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
	end
	if freeze_position_pos then
		entity.set_entity_collision(player.get_player_ped(player.player_id()), true, true, false)
		freeze_position_pos = nil
	end
	call_kamikaze_attack = nil
	bombs_to_besra = nil
	if launch_guided_missile_previous_pos then
		entity.set_entity_collision(player.get_player_ped(player.player_id()), true, true, false)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), launch_guided_missile_previous_pos)
		launch_guided_missile_previous_pos = nil
	end
	if previous_position_of_vehicle then
		network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
		entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()), previous_position_of_vehicle)
		previous_position_of_vehicle = nil
	end
	if ww2_rogue then
		for a = 1, 20 do
			if entity.is_an_entity(ww2_rogue[a]) then
				utilities.hard_remove_entity(ww2_rogue[a])
			end
			if entity.is_an_entity(ww2_ped_pilot_rogue[a]) then
				utilities.hard_remove_entity(ww2_ped_pilot_rogue[a])
			end
		end
	end
	if ww2_nokota then
		for b = 1, 10 do
			if entity.is_an_entity(ww2_nokota[b]) then
				utilities.hard_remove_entity(ww2_nokota[b])
			end
			if entity.is_an_entity(ww2_ped_pilot_nokota[b]) then
				utilities.hard_remove_entity(ww2_ped_pilot_nokota[b])
			end
		end
	end
	if ww2_rhino then
		for c = 1, 20 do
			if entity.is_an_entity(ww2_rhino[c]) then
				utilities.hard_remove_entity(ww2_rhino[c])
			end
			if entity.is_an_entity(ww2_ped_pilot_rhino[c]) then
				utilities.hard_remove_entity(ww2_ped_pilot_rhino[c])
			end
		end
	end
	if ww2_soldier then
		for d = 1, 30 do
			if entity.is_an_entity(ww2_soldier[d]) then
				utilities.hard_remove_entity(ww2_soldier[d])
			end
		end
	end
	if ww2_insurgent then
		for e = 1, 20 do
			if entity.is_an_entity(ww2_insurgent[e]) then
				utilities.hard_remove_entity(ww2_insurgent[e])
			end
			if entity.is_an_entity(ww2_ped_pilot_insurgent[e]) then
				utilities.hard_remove_entity(ww2_ped_pilot_insurgent[e])
			end
			if entity.is_an_entity(ww2_ped_pilot_2_insurgent[e]) then
				utilities.hard_remove_entity(ww2_ped_pilot_2_insurgent[e])
			end
		end
	end
	if enola_gay then
		utilities.hard_remove_entity(enola_gay)
		enola_gay = nil
	end
	if little_boy then
		utilities.hard_remove_entity(little_boy)
		little_boy = nil
	end
	if little_boy_2 then
		utilities.hard_remove_entity(little_boy_2)
		little_boy_2 = nil
	end
	dropped_little_boy = false
	little_boy_2_exploded_in_water = false
	little_boy_exploded = false
	little_boy_rotation = nil
	if enola_gay_map_blip_bomb then
		ui.remove_blip(enola_gay_map_blip_bomb)
	end
	if enola_gay_map_blip_repair then
		ui.remove_blip(enola_gay_map_blip_repair)
	end
	if threads["» Enola Gay"] then
		menu.delete_thread(threads["» Enola Gay"])
	end
	rope.rope_unload_textures()
	rope_target_1 = nil
	rope_target_2 = nil
	rope_wait_a_second = false
	if table_of_all_ropes then
		for i = 1, #table_of_all_ropes do
			if rope.does_rope_exist(table_of_all_ropes[i]) then
				rope.delete_rope(table_of_all_ropes[i])
				table_of_all_ropes[i] = nil
			end
		end
	end
	ww2_rogue = nil
	ww2_ped_pilot_rogue = nil
	ww2_nokota = nil
	ww2_ped_pilot_nokota = nil
	ww2_rhino = nil
	ww2_ped_pilot_rhino = nil
	ww2_soldier = nil
	ww2_insurgent = nil
	ww2_ped_pilot_insurgent = nil
	ww2_ped_pilot_2_insurgent = nil
	launch_guided_missile_pos_tp = nil
	launch_guided_missile_pos = nil
	demolition_boost_notify = nil
	auto_pilot_speed = nil
	auto_pilot_rotation = nil
	enola_gay_notify = nil
	rope_gun_notify = nil
	menu.notify("[!] Unloaded Menu! Cleanup Successful!", Meteor, 3, 0x00ff00)
	Meteor = nil
	event.remove_event_listener("exit", listeners["Menu Unload"])
end)

if utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorDev\\MeteorDev.lua") then
	meteordevlocalparent = menu.add_feature("» Dev Features", "parent", localparents["» Meteor"])
	meteordevplayerparent = menu.add_player_feature("» Dev Features", "parent", playerparents["» Meteor"]).id
	local dev = loadfile(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\MeteorDev\\MeteorDev.lua")
	dev()
end



--	░█████╗░██████╗░███████╗██████╗░██╗████████╗░██████╗  ░█████╗░███╗░░██╗██████╗░  ██████╗░██╗░██████╗░  ████████╗██╗░░██╗░█████╗░███╗░░██╗██╗░░██╗░██████╗  ████████╗░█████╗░  ██╗
--	██╔══██╗██╔══██╗██╔════╝██╔══██╗██║╚══██╔══╝██╔════╝  ██╔══██╗████╗░██║██╔══██╗  ██╔══██╗██║██╔════╝░  ╚══██╔══╝██║░░██║██╔══██╗████╗░██║██║░██╔╝██╔════╝  ╚══██╔══╝██╔══██╗  ╚═╝
--	██║░░╚═╝██████╔╝█████╗░░██║░░██║██║░░░██║░░░╚█████╗░  ███████║██╔██╗██║██║░░██║  ██████╦╝██║██║░░██╗░  ░░░██║░░░███████║███████║██╔██╗██║█████═╝░╚█████╗░  ░░░██║░░░██║░░██║  ░░░
--	██║░░██╗██╔══██╗██╔══╝░░██║░░██║██║░░░██║░░░░╚═══██╗  ██╔══██║██║╚████║██║░░██║  ██╔══██╗██║██║░░╚██╗  ░░░██║░░░██╔══██║██╔══██║██║╚████║██╔═██╗░░╚═══██╗  ░░░██║░░░██║░░██║  ░░░
--	╚█████╔╝██║░░██║███████╗██████╔╝██║░░░██║░░░██████╔╝  ██║░░██║██║░╚███║██████╔╝  ██████╦╝██║╚██████╔╝  ░░░██║░░░██║░░██║██║░░██║██║░╚███║██║░╚██╗██████╔╝  ░░░██║░░░╚█████╔╝  ██╗
--	░╚════╝░╚═╝░░╚═╝╚══════╝╚═════╝░╚═╝░░░╚═╝░░░╚═════╝░  ╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░  ╚═════╝░╚═╝░╚═════╝░  ░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝╚═════╝░  ░░░╚═╝░░░░╚════╝░  ╚═╝



--	██╗░░██╗███████╗██╗░░██╗████████╗██████╗░░█████╗░███╗░░░███╗
--	██║░██╔╝██╔════╝██║░██╔╝╚══██╔══╝██╔══██╗██╔══██╗████╗░████║
--	█████═╝░█████╗░░█████═╝░░░░██║░░░██████╔╝███████║██╔████╔██║
--	██╔═██╗░██╔══╝░░██╔═██╗░░░░██║░░░██╔══██╗██╔══██║██║╚██╔╝██║
--	██║░╚██╗███████╗██║░╚██╗░░░██║░░░██║░░██║██║░░██║██║░╚═╝░██║
--	╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝

--	███████╗██████╗░██████╗░          ███╗░░██╗███████╗████████╗		  ░█████╗░██████╗░██████╗░░█████╗░██╗░░░██╗
--	██╔════╝██╔══██╗██╔══██╗          ████╗░██║██╔════╝╚══██╔══╝		  ██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗░██╔╝
--	█████╗░░██████╔╝██████╔╝          ██╔██╗██║█████╗░░░░░██║░░░		  ███████║██████╔╝██████╔╝███████║░╚████╔╝░
--	██╔══╝░░██╔══██╗██╔══██╗		  ██║╚████║██╔══╝░░░░░██║░░░		  ██╔══██║██╔══██╗██╔══██╗██╔══██║░░╚██╔╝░░
--	███████╗██║░░██║██║░░██║ ███████╗ ██║░╚███║███████╗░░░██║░░░ ███████╗ ██║░░██║██║░░██║██║░░██║██║░░██║░░░██║░░░
--	╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝ ╚══════╝ ╚═╝░░╚══╝╚══════╝░░░╚═╝░░░ ╚══════╝ ╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░

--	██████╗░██╗░░░██╗███████╗██████╗░░█████╗░░█████╗░██╗░█████╗░
--	██╔══██╗██║░░░██║██╔════╝██╔══██╗██╔══██╗██╔══██╗██║██╔══██╗
--	██║░░██║██║░░░██║█████╗░░██████╔╝██║░░╚═╝██║░░╚═╝██║██║░░██║
--	██║░░██║██║░░░██║██╔══╝░░██╔══██╗██║░░██╗██║░░██╗██║██║░░██║
--	██████╔╝╚██████╔╝███████╗██║░░██║╚█████╔╝╚█████╔╝██║╚█████╔╝
--	╚═════╝░░╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░░╚════╝░╚═╝░╚════╝░

--	███████╗██████╗░██████╗░██╗░██████╗███╗░░░███╗
--	╚════██║██╔══██╗██╔══██╗██║██╔════╝████╗░████║
--	░░███╔═╝██████╔╝██████╔╝██║╚█████╗░██╔████╔██║
--	██╔══╝░░██╔═══╝░██╔══██╗██║░╚═══██╗██║╚██╔╝██║
--	███████╗██║░░░░░██║░░██║██║██████╔╝██║░╚═╝░██║
--	╚══════╝╚═╝░░░░░╚═╝░░╚═╝╚═╝╚═════╝░╚═╝░░░░░╚═╝

--	██╗░░██╗██╗██╗░░░██╗░█████╗░
--	██║░██╔╝██║╚██╗░██╔╝██╔══██╗
--	█████═╝░██║░╚████╔╝░███████║
--	██╔═██╗░██║░░╚██╔╝░░██╔══██║
--	██║░╚██╗██║░░░██║░░░██║░░██║
--	╚═╝░░╚═╝╚═╝░░░╚═╝░░░╚═╝░░╚═╝

--	██████╗░██╗███╗░░░███╗██╗░░░██╗██████╗░██╗░░░██╗
--	██╔══██╗██║████╗░████║██║░░░██║██╔══██╗██║░░░██║
--	██████╔╝██║██╔████╔██║██║░░░██║██████╔╝██║░░░██║
--	██╔══██╗██║██║╚██╔╝██║██║░░░██║██╔══██╗██║░░░██║
--	██║░░██║██║██║░╚═╝░██║╚██████╔╝██║░░██║╚██████╔╝
--	╚═╝░░╚═╝╚═╝╚═╝░░░░░╚═╝░╚═════╝░╚═╝░░╚═╝░╚═════╝░

--	░░███╗░░██████╗░██████╗░███████╗███████╗███████╗██████╗░░█████╗░
--	░████║░░╚════██╗╚════██╗╚════██║╚════██║██╔════╝██╔══██╗██╔══██╗
--	██╔██║░░░█████╔╝░█████╔╝░░░░██╔╝░░███╔═╝█████╗░░██████╔╝██║░░██║
--	╚═╝██║░░░╚═══██╗░╚═══██╗░░░██╔╝░██╔══╝░░██╔══╝░░██╔══██╗██║░░██║
--	███████╗██████╔╝██████╔╝░░██╔╝░░███████╗███████╗██║░░██║╚█████╔╝
--	╚══════╝╚═════╝░╚═════╝░░░╚═╝░░░╚══════╝╚══════╝╚═╝░░╚═╝░╚════╝░

--	░██████╗░███████╗███████╗░░░░░░███╗░░░███╗░█████╗░███╗░░██╗███████╗██████╗░░░███╗░░
--	██╔════╝░██╔════╝██╔════╝░░░░░░████╗░████║██╔══██╗████╗░██║██╔════╝╚════██╗░████║░░
--	██║░░██╗░█████╗░░█████╗░░█████╗██╔████╔██║███████║██╔██╗██║██████╗░░░███╔═╝██╔██║░░
--	██║░░╚██╗██╔══╝░░██╔══╝░░╚════╝██║╚██╔╝██║██╔══██║██║╚████║╚════██╗██╔══╝░░╚═╝██║░░
--	╚██████╔╝███████╗███████╗░░░░░░██║░╚═╝░██║██║░░██║██║░╚███║██████╔╝███████╗███████╗
--	░╚═════╝░╚══════╝╚══════╝░░░░░░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚══════╝╚══════╝

--	██╗░░██╗░█████╗░███████╗██╗░░██╗██╗░░██╗███████╗███████╗██████╗░
--	██║░░██║██╔══██╗██╔════╝██║░██╔╝██║░██╔╝╚════██║██╔════╝██╔══██╗
--	███████║███████║█████╗░░█████═╝░█████═╝░░░███╔═╝█████╗░░██████╔╝
--	██╔══██║██╔══██║██╔══╝░░██╔═██╗░██╔═██╗░██╔══╝░░██╔══╝░░██╔══██╗
--	██║░░██║██║░░██║███████╗██║░╚██╗██║░╚██╗███████╗███████╗██║░░██║
--	╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░╚═╝

--	██╗░░██╗██╗██████╗░██╗██╗░░██╗░█████╗░
--	██║░██╔╝██║██╔══██╗██║██║░██╔╝██╔══██╗
--	█████═╝░██║██████╔╝██║█████═╝░███████║
--	██╔═██╗░██║██╔══██╗██║██╔═██╗░██╔══██║
--	██║░╚██╗██║██║░░██║██║██║░╚██╗██║░░██║
--	╚═╝░░╚═╝╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚═╝╚═╝░░╚═╝

--	██████╗░██████╗░░█████╗░██████╗░██████╗░██╗░░░██╗
--	██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗░██╔╝
--	██████╔╝██████╔╝██║░░██║██║░░██║██║░░██║░╚████╔╝░
--	██╔═══╝░██╔══██╗██║░░██║██║░░██║██║░░██║░░╚██╔╝░░
--	██║░░░░░██║░░██║╚█████╔╝██████╔╝██████╔╝░░░██║░░░
--	╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═════╝░╚═════╝░░░░╚═╝░░░

--	░██████╗░██╗░░██╗░█████╗░░██████╗████████╗░█████╗░███╗░░██╗███████╗
--	██╔════╝░██║░░██║██╔══██╗██╔════╝╚══██╔══╝██╔══██╗████╗░██║██╔════╝
--	██║░░██╗░███████║██║░░██║╚█████╗░░░░██║░░░██║░░██║██╔██╗██║█████╗░░
--	██║░░╚██╗██╔══██║██║░░██║░╚═══██╗░░░██║░░░██║░░██║██║╚████║██╔══╝░░
--	╚██████╔╝██║░░██║╚█████╔╝██████╔╝░░░██║░░░╚█████╔╝██║░╚███║███████╗
--	░╚═════╝░╚═╝░░╚═╝░╚════╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚══╝╚══════╝

--	██╗░░██╗██╗██████╗░██████╗░██╗░█████╗░███╗░░██╗
--	██║░██╔╝██║██╔══██╗██╔══██╗██║██╔══██╗████╗░██║
--	█████═╝░██║██║░░██║██║░░██║██║██║░░██║██╔██╗██║
--	██╔═██╗░██║██║░░██║██║░░██║██║██║░░██║██║╚████║
--	██║░╚██╗██║██████╔╝██████╔╝██║╚█████╔╝██║░╚███║
--	╚═╝░░╚═╝╚═╝╚═════╝░╚═════╝░╚═╝░╚════╝░╚═╝░░╚══╝



--	░█████╗░███╗░░██╗██████╗░  ████████╗██╗░░██╗███████╗  ██████╗░████████╗░█████╗░██╗░░██╗███████╗░░███╗░░
--	██╔══██╗████╗░██║██╔══██╗  ╚══██╔══╝██║░░██║██╔════╝  ╚════██╗╚══██╔══╝██╔══██╗██║░██╔╝██╔════╝░████║░░
--	███████║██╔██╗██║██║░░██║  ░░░██║░░░███████║█████╗░░  ░░███╔═╝░░░██║░░░███████║█████═╝░█████╗░░██╔██║░░
--	██╔══██║██║╚████║██║░░██║  ░░░██║░░░██╔══██║██╔══╝░░  ██╔══╝░░░░░██║░░░██╔══██║██╔═██╗░██╔══╝░░╚═╝██║░░
--	██║░░██║██║░╚███║██████╔╝  ░░░██║░░░██║░░██║███████╗  ███████╗░░░██║░░░██║░░██║██║░╚██╗███████╗███████╗
--	╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝  ╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚══════╝

--	██████╗░███████╗██╗░░░██╗  ████████╗███████╗░█████╗░███╗░░░███╗
--	██╔══██╗██╔════╝██║░░░██║  ╚══██╔══╝██╔════╝██╔══██╗████╗░████║
--	██║░░██║█████╗░░╚██╗░██╔╝  ░░░██║░░░█████╗░░███████║██╔████╔██║
--	██║░░██║██╔══╝░░░╚████╔╝░  ░░░██║░░░██╔══╝░░██╔══██║██║╚██╔╝██║
--	██████╔╝███████╗░░╚██╔╝░░  ░░░██║░░░███████╗██║░░██║██║░╚═╝░██║
--	╚═════╝░╚══════╝░░░╚═╝░░░  ░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░░░░╚═╝



--	░░██╗██████╗░
--	░██╔╝╚════██╗
--	██╔╝░░█████╔╝
--	╚██╗░░╚═══██╗
--	░╚██╗██████╔╝
--	░░╚═╝╚═════╝░