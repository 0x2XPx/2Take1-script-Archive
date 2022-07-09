-- GeeSkid v1.02
_GT_mod_info = {}

_GT_mod_info.otr_flag = player.add_modder_flag("OTR > 3 Min")
_GT_mod_info.high_kd_flag = player.add_modder_flag("High K/D")
_GT_mod_info.neg_kd_flag = player.add_modder_flag("Negative K/D")
_GT_mod_info.high_money_flag = player.add_modder_flag("High $")
_GT_mod_info.high_rank_flag = player.add_modder_flag("High rank")
_GT_mod_info.god_flag = player.add_modder_flag("God-Mode")
_GT_mod_info.undead_flag = player.add_modder_flag("Un-Dead")

_GT_mod_info.int_str = {
{1, "Manual"}, 					--1
{2, "Player Model"},			--2
{4, "SCID Spoof"},				--3
{8, "Invalid Object"},			--4
{16, "Invalid Ped Crash"},		--5
{32, "Model Change Crash"},		--6
{64, "Player Model Change"},	--7
{128, "RAC"}, 					--8
{256, "Money Drop"},			--9
{512, "SEP"},					--10
{1024, "Attach Object"},		--11
{2048, "Attach Ped"},			--12
{4096, "Net Array Crash"},		--13
{8192, "Sync Crash"}, 			--14
{16384, "Net Event Crash"},		--15
{32768, "Host Token"}, 			--16
{65536, "SE Spam"},				--17
{131072, "Invalid Vehicle"},	--18
{262144, "Frame Flags"},		--19
{524288, "IP Spoof"},	 		--20
{1048576, "Karen"},				--21
{2097152, "Session Mismatch"},	--22
{4194304, "Sound Spam"},		--23
{_GT_mod_info.otr_flag, "OTR > 3 Min"},--24
{_GT_mod_info.high_kd_flag,"High K/D"}, --25
{_GT_mod_info.neg_kd_flag,"Negative K/D"},	--26
{_GT_mod_info.high_money_flag,"High $"},	--27
{_GT_mod_info.high_rank_flag,"High rank"},	--28
{_GT_mod_info.god_flag,"God-Mode"},	--29
{_GT_mod_info.undead_flag,"Un-Dead"}, 	 	--30
}

_GT_mod_info.int_str = {
{1 << 0x00, "Manual"}, 					--1
{1 << 0x01, "Player Model"},			--2
{1 << 0x02, "SCID Spoof"},				--3
{1 << 0x03, "Invalid Object"},			--4
{1 << 0x04, "Invalid Ped Crash"},		--5
{1 << 0x05, "Model Change Crash"},		--6
{1 << 0x06, "Player Model Change"},	--7
{1 << 0x07, "RAC"}, 					--8
{1 << 0x08, "Money Drop"},			--9
{1 << 0x09, "SEP"},					--10
{1 << 0x0A, "Attach Object"},		--11
{1 << 0x0B, "Attach Ped"},			--12
{1 << 0x0C, "Net Array Crash"},		--13
{1 << 0x0D, "Sync Crash"}, 			--14
{1 << 0x0E, "Net Event Crash"},		--15
{1 << 0x0F, "Host Token"}, 			--16
{1 << 0x10, "SE Spam"},				--17
{1 << 0x11, "Invalid Vehicle"},		--18
{1 << 0x12, "Frame Flags"},			--19
{1 << 0x13, "IP Spoof"},	 		--20
{1 << 0x14, "Karen"},				--21
{1 << 0x15, "Session Mismatch"},	--22
{1 << 0x16, "Sound Spam"},			--23
{1 << 0x17, "SEP INT"},				--24
{1 << 0x18, "Suspicious activity"},	--25
{1 << 0x19, "Chat spoof"},			--26
{_GT_mod_info.otr_flag, "OTR > 3 Min"},		--27
{_GT_mod_info.high_kd_flag,"High K/D"}, 	--28
{_GT_mod_info.neg_kd_flag,"Negative K/D"},	--29
{_GT_mod_info.high_money_flag,"High $"},	--30
{_GT_mod_info.high_rank_flag,"High rank"},	--31
{_GT_mod_info.god_flag,"God-Mode"},			--32
{_GT_mod_info.undead_flag,"Un-Dead"}, 	 	--33
}
	
_GT_mod_info.str = {
"Manual", 				-- 1, --1
"Player Model", 		-- 2, --2
"SCID Spoof", 			-- 4, --3
"Invalid Object", 		-- 8, --4 
"Invalid Ped Crash", 	-- 16, --5 
"Model Change Crash", 	-- 32, --6 
"Player Model Change",	-- 64, --7
"RAC", 					-- 128, --8
"Money Drop", 			-- 256, --9
"SEP", 					-- 512, --10
"Attach Object", 		-- 1024, --11
"Attach Ped", 			-- 2048, --12
"Net Array Crash", 		-- 4096, --13
"Sync Crash", 			-- 8192, --14
"Net Event Crash", 		-- 16384, --15
"Host Token", 			-- 32768, --16
"SE Spam", 				-- 65536, --17
"Invalid Vehicle", 		-- 131072, --18
"Frame Flags", 			-- 262144, --19
"IP Spoof", 			-- 524288, --20
"Karen",				-- 1048576, --21
"Session Mismatch",		-- 2097152, --22
"Sound Spam",			-- 4194304, --23
"SEP INT",				--
"Suspicious activity",	--
"Chat spoof",			--
"OTR > 3 Min", 			--
"High K/D", 			--
"Negative K/D",			--
"High $",				--
"High rank",			--
"God-Mode",				--
"Un-Dead", 	 			--
}

function _GF_ents_touch(_ent1,_ent2)
	return native.call(0x17FFC1B2BA35A494,_ent1,_ent2):__tointeger()==1
end

function _GF_brk_wndws(_veh)
	for i=0,7 do
		native.call(0x9E5B5E4D2CCD2259,_veh,i)
	end
end

function _GF_fx_wndws(_veh)
	for i=0,7 do
		native.call(0x772282EBEB95E682,_veh,i)
	end
end

function _GF_set_invncbl_wndws(_veh,_bool)
	native.call(0x1087BC8EC540DAEB,_veh,_GF_bool_to_01(_bool,false))
end

function _GF_are_wndws_good(_veh)
	return native.call(0x11D862A3E977A9EF,_veh):__tointeger(true) == 1
end

function _GF_set_wnt_all_psngrs(_pid,_val)
	if player.is_player_in_any_vehicle(_pid) then
		for i=1, _GF_veh_seats(player.get_player_vehicle(_pid)) do
			if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(_pid), i-2)) and
				player.get_player_wanted_level(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(_pid), i-2))) ~= _val then
				_GF_set_wnt_lvl(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(_pid), i-2)),_val)	
			end
		end
	elseif player.get_player_wanted_level(_pid) ~= _val then
		_GF_set_wnt_lvl(_pid,_val)	
	end
end

function _GF_set_wnt_lvl(_pid,_val)
	if _val == 0 then
		script.trigger_script_event(801199324, _pid, {_pid, -1685043744})
	else
		native.call(0x39FF19C64EF7DA5B,_pid,_val,0)	
		native.call(0xE0A7D1E497FFCD6F,_pid,0)	
	end
end

function _GF_is_wntd_lvl_over(_pid,_num)
	return native.call(0x238DB2A2C23EE9EF,_pid,_num):__tointeger(true)==1
end

function _GF_get_tire_health(_veh,_indx)
	return native.call(0x55EAB010FAEE9380,_veh,_indx):__tonumber(true)
end

function _GF_get_veh_engn_hlth(_veh,_prcnt)
	local hlth = native.call(0xC45D23BAF168AAB8,_veh):__tonumber(true)
	if _prcnt then
		if hlth >= 0 then
			return hlth/10
		end
		return hlth/40
	end
	return hlth
end

function _GF_get_veh_bdy_hlth(_veh,_prcnt)
	if _prcnt then
		return (native.call(0xF271147EB7B40F12,_veh):__tonumber(true))/10
	end
	return native.call(0xF271147EB7B40F12,_veh):__tonumber(true)
end

function _GF_get_veh_cmbnd_hlth_prcnt(_veh,_crv)
	local engine,body = _GF_get_veh_engn_hlth(_veh,true)
	if engine <0 then
		return engine
	end
	body = _GF_get_veh_bdy_hlth(_veh,true)
	if _crv then
		if engine < 60 then
			engine = engine * (engine/60)
		end
		if body < 60 then
			body = body * (body/60)
		end
	end
	return (engine+body)/2
end

function _GF_does_veh_have_weap(_veh)
	return native.call(0x25ECB9F8017D98E0,_veh):__tointeger(true)==1
end

function _GF_rmv_veh_weap(_veh)
	for i=0,2 do
		native.call(0x44CD1F493DB2A0A6,_veh,i,0)
	end
end

function _GF_is_veh_alarm_on(_veh)
	return native.call(0x4319E335B71FFF34,_veh):__tointeger(true) == 1
end

function _GF_is_veh_horn_on(_veh)
	return native.call(0x9D6BFC12B05C6121,_veh):__tointeger(true) == 1
end

function _GF_can_vehicle_jump(_veh)
	return native.call(0x9078C0C5EF8C19E9,_veh):__tointeger(true) == 1
end

function _GF_what_ent_killed_ped(_ped)
	return native.call(0x93C8B64DEB84728C,_ped):__tointeger(true)
end

function _GF_plyr_kd(_pid)
	if script.get_global_f(1853131  + (1 + (_pid * 888)) + 205 + 26) == nil then
		return 0 
	end
	return _GF_2_decimals(script.get_global_f(1853131  + (1 + (_pid * 888)) + 205 + 26))
end

function _GF_plyr_money(_pid)
	if script.get_global_i(1853131  + (1 + (_pid * 888)) + 205 + 56) == nil then
		return 0
	end
	return math.abs(script.get_global_i(1853131  + (1 + (_pid * 888)) + 205 + 56)) --gta reports a lot of money as a negative
end

function _GF_prsnl_veh(_pid)
	return script.get_global_i(2703660  + 1 + 173 + (_pid * 1))
end

function _GF_veh_kick_script(_pid)
	script.trigger_script_event(578856274, _pid, {0, 4294967295, 4294967295, 4294967295})
end

function _GF_send_to_cayo(_pid)
	script.trigger_script_event(-621279188, _pid, {1, 1})
end

function _GF_give_bounty(_pid,_val)
	for i = 0, 31 do
		script.trigger_script_event(1294995624, i, {69, _pid, 1, _val, 0, 1,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1921039 + 9), script.get_global_i(1921039 + 10)})
	end
end

function _GF_my_score(_pid)
	local num = script.get_global_i(2863967 + 386 + 1 + _pid)
	if num == nil then
		return 0
	end
	return num
end

function _GF_plyr_score(_pid)
	local num = script.get_global_i(2863967 + 353 + 1 + _pid)
	if num == nil then
		return 0
	end
	return num
end

function _GF_plyr_money_str(_pid)
	if _GT_plyr_info.money[_pid+1] >= 1000000000 then
		return "$ ".._GF_2_decimals(_GT_plyr_info.money[_pid+1]/1000000000).." B"
	elseif _GT_plyr_info.money[_pid+1] >= 1000000 then
		return "$ ".._GF_2_decimals(_GT_plyr_info.money[_pid+1]/1000000).." M"
	elseif _GT_plyr_info.money[_pid+1] >= 1000 then
		return "$ ".._GF_2_decimals(_GT_plyr_info.money[_pid+1]/1000).." K"
	end
	return "$ ".._GT_plyr_info.money[_pid+1]
end

function _GF_plyr_lvl(_pid)
	if script.get_global_i(1853131  + (1 + (_pid * 888)) + 205 + 6) == nil then
		return 0
	end
	return script.get_global_i(1853131  + (1 + (_pid * 888)) + 205 + 6)
end

function _GF_same_orgmc(_pid1,_pid2)
	if _GF_org_color_int(_pid1)>-1 and _GF_org_color_int(_pid2)>-1 then
		if _GF_org_color_int(_pid1) == _GF_org_color_int(_pid2) then
			return true
		end
	end
	return false
end

function _GF_org_color_int(_pid)
	--local associate_id = script.get_global_i(1893551 + 1 + 10 + 2 + (_pid*599)) -- could be used to determine actual ceo/mc, but i cant figure out how to determine if its mc or ceo
	-- script.get_global_i(1893551 + 1 + 10 + (_pid*599)) --returns the current tally of ceos or mcs that have been in session when that ceo/mc was made
	if script.get_global_i(1893551 + 1 + 10 + (_pid*599)) > -1 then
		return script.get_global_i(1893551 + 1 + 10 + 104 + (_pid*599)) --sometimes a player has a org color of -1 (white) even when in a org (briefly)
	end
	return -1
end

function _GF_mission_active(_pid)
	return (script.get_global_i(1893551 + 1 + 10 + 103 + (_pid*599)) == 8)
end

function _GF_num_in_range(_num,_min,_max)
	if _num >= _min and _num <= _max then
		return true
	end
	return false
end

function _GF_pos_xy_in_range(_pos,x_min,x_max,y_min,y_max)
	if _GF_num_in_range(_pos.x,x_min,x_max) and _GF_num_in_range(_pos.y,y_min,y_max) then
		return true
	end
	return false
end

function _GF_pos_xyz_in_range(_pos,x_min,x_max,y_min,y_max,z_min,z_max)
	if _GF_num_in_range(_pos.x,x_min,x_max) and _GF_num_in_range(_pos.y,y_min,y_max) and _GF_num_in_range(_pos.z,z_min,z_max) then
		return true
	end
	return false
end

function _GF_pid_loading(_pid,time)
	if player.get_player_coords(_pid) ~= v3(0,0,0) and (time - _GT_plyr_info.join_time[_pid+1]) > 60 then
		return false
	elseif entity.get_entity_speed(player.get_player_ped(_pid)) < 1 then
		if player.get_player_coords(_pid) == v3(0,0,0) or _GF_plyr_lvl(_pid) == 0 then
			return true
		elseif _GF_plyr_kd(_pid) +  _GF_plyr_money(_pid) == 0 then
			return true
		elseif _GF_plyr_otr(_pid) and (_GF_plyr_kd(_pid) == 0 or _GF_plyr_money(_pid) == 0) then
			return true
		end
	end
	return false
end

function _GF_plyr_invis(_pid)
	if not _G_GS_has_loaded then -- ensures dist_table is loaded
		return false
	elseif _GT_plyr_info.visible[_pid+1] or _GT_plyr_info.interior[_pid+1] or _GT_plyr_info.loading[_pid+1] or _G_plyrs_overlay_main.dist_table[_pid+1][1] > 250 then
		return false
	elseif not _GT_plyr_info.plyr_play[_pid+1] and not _GT_plyr_info.plyr_moving[_pid+1] and _GT_plyr_info.plyr_god[_pid+1] then -- entering interior possibly
		return false
	end
	return true
	--_GT_plyr_info.plyr_moving[_pid+1]
	--_GT_plyr_info.plyr_god[_pid+1]
end


function _GF_plyr_otr(_pid)
	return (script.get_global_i(2689224 + 1 + 207 + (_pid*451)) == 1)
end

function _GF_time_M_S_str(_pid_time)
	local timer = utils.time()-_pid_time
	local minutes = timer/60
	local seconds = _GF_round_num((60*(minutes-math.floor(minutes))))
	if seconds > 59 then
		seconds = math.floor(seconds/60)
	end
	if seconds < 10 then
		return math.floor(timer/60)..":".."0"..tostring(seconds)
	else
		return math.floor(timer/60)..":"..seconds
	end
end

function _GF_plyr_ip(_pid)
	local ip = "IP"
	if _GF_is_a_num(player.get_player_ip(_pid)) then
		ip = player.get_player_ip(_pid)
		ip = string.format("%i.%i.%i.%i", ip >> 24 & 255, ip >> 16 & 255, ip >> 8 & 255, ip & 255)
	end
	return ip
end

function _GF_GW_plyr_info(_pid) 
	if _GF_valid_pid(_pid) then
		local plyr_name=""
		if player.is_player_host(_pid) or (script.get_host_of_this_script()==_pid) or player.is_player_modder(_pid,-1) or player.is_player_friend(_pid) then
			if player.is_player_host(_pid) then plyr_name=plyr_name.."[H]" end
			if script.get_host_of_this_script()==_pid then plyr_name=plyr_name.."[S]" end
			if player.is_player_modder(_pid,-1) then	plyr_name=plyr_name.."[M]" end
			if player.is_player_friend(_pid) then plyr_name=plyr_name.."[F]"	end
			plyr_name = plyr_name.." "
		end
		plyr_name = plyr_name.._GF_plyr_name(_pid).."\nPID:".._pid.."   Host Priority:".._GT_plyr_info.host_priority_str[_pid+1]
		if player.is_player_in_any_vehicle(_pid) then
			plyr_name = plyr_name.."\n".._GF_model_name(player.get_player_vehicle(_pid)).."   ".."Seats:".._GF_num_free_seats(player.get_player_vehicle(_pid)).."/".._GF_veh_seats(player.get_player_vehicle(_pid))
			if player.is_player_god(_pid) and player.is_player_vehicle_god(_pid) then	plyr_name = plyr_name.."\nPlayer-GOD & Vehicle-GOD"
			elseif player.is_player_vehicle_god(_pid) then plyr_name = plyr_name.."\nVehicle-GOD"
			end
		elseif player.is_player_god(_pid) then plyr_name=plyr_name.."\nPlayer-GOD"
		end
		plyr_name=plyr_name.."\nRank:".._GF_plyr_lvl(_pid).."   K/D: ".._GF_plyr_kd(_pid) --i just split these up so they fit on the screen
		plyr_name=plyr_name.."\nMoney: $".._GF_add_commas_to_int(_GF_plyr_money(_pid))
		plyr_name=plyr_name.."\nHealth: "..math.floor(player.get_player_health(_pid)).."/"..math.floor(player.get_player_max_health(_pid)).."   Armor:"..math.floor(player.get_player_armour(_pid)).."/50"
		plyr_name=plyr_name.."\nWanted: "..player.get_player_wanted_level(_pid).."/5"
		menu.notify(""..plyr_name.."", _G_GeeVer, 14, 2)
		return true
	end
	return false
end

function _GF_join_info(_pid)
	local JL_msg = ""
	local mod_flags = ""
	if _GF_is_not_not(_GF_plyr_name(_pid),"Player","Ped","Entity") then
		JL_msg = _GF_plyr_name(_pid).."  SCID: "..player.get_player_scid(_pid)
		JL_msg = JL_msg .."\nPID:".._pid
		JL_msg = JL_msg.."   Host Priority:"..tostring(player.get_player_host_priority(_pid)).."/"..tostring(player.player_count())
		if _GF_plyr_ip(_pid) ~= "IP" then
			JL_msg = JL_msg .."\n".._GF_plyr_ip(_pid)
		end
		if _GF_plyr_lvl(_pid) ~= 0 or _GF_plyr_kd(_pid) ~= 0 then
			JL_msg = JL_msg .."\n"
			if _GF_plyr_lvl(_pid) ~= 0 then
				JL_msg = JL_msg .."Rank: ".._GF_plyr_lvl(_pid)
			end
			if _GF_plyr_kd(_pid) ~= 0 then
				if _GF_plyr_lvl(_pid) ~= 0 then
					JL_msg = JL_msg .."   "
				end
				JL_msg = JL_msg .."K/D: ".._GF_plyr_kd(_pid)
			end
		end
		if _GF_plyr_money(_pid) > 0 then
			JL_msg = JL_msg .."\nMoney: $".._GF_add_commas_to_int(_GF_plyr_money(_pid))
		end
		mod_flags = ""
		for m=1,#_GT_mod_info.int_str do
			if player.is_player_modder(_pid,_GT_mod_info.int_str[m][1]) then
				mod_flags=mod_flags.._GT_mod_info.int_str[m][2].." "
			end
		end
		if mod_flags ~= "" then
			JL_msg = JL_msg .."\nMod Flags: "..mod_flags
		end
	end
	return JL_msg
end

function _GF_check_for_mods(i,_pid,time)
	if player.can_player_be_modder(_pid) and _GT_plyr_info.join_time[i]+20 < time then
		if _G_mods_detex_kd_tog.on and _GF_plyr_kd(_pid) > _G_mods_detex_kd_tog.value and not player.is_player_modder(_pid,_GT_mod_info.int_str[28][1]) then 
			player.set_player_as_modder(_pid, _GT_mod_info.int_str[28][1])
			menu.notify("".._GT_plyr_info.name[_pid+1].."\nHas a high K/D.\n --Marking as Modder--",_G_GeeVer,7,2)
		end
		if _G_mods_detex_kd_neg_tog.on and _GF_plyr_kd(_pid) < 0 and not player.is_player_modder(_pid,_GT_mod_info.int_str[29][1]) then 
			player.set_player_as_modder(_pid, _GT_mod_info.int_str[29][1])
			menu.notify("".._GT_plyr_info.name[_pid+1].."\nHas a negative K/D.\n --Marking as Modder--",_G_GeeVer,7,2)
		end
		if _G_mods_detex_money_tog.on and _GF_plyr_money(_pid) > ((250*_G_mods_detex_money_tog.value+500)*1000000) and not player.is_player_modder(_pid,_GT_mod_info.int_str[30][1]) then 
			player.set_player_as_modder(_pid, _GT_mod_info.int_str[30][1])
			menu.notify("".._GT_plyr_info.name[_pid+1].."\nHas a lot of money.\n --Marking as Modder--",_G_GeeVer,7,2)
		end
		if _G_mods_detex_rank_tog.on and _GF_plyr_lvl(_pid) > _G_mods_detex_rank_tog.value and not player.is_player_modder(_pid,_GT_mod_info.int_str[31][1]) then 
			player.set_player_as_modder(_pid, _GT_mod_info.int_str[31][1])
			menu.notify("".._GT_plyr_info.name[_pid+1].."\nHas a high rank.\n --Marking as Modder--",_G_GeeVer,7,2)
		end
		if _G_mods_detex_undead_tog.on and _GT_plyr_info.undead_blip[i] ~= v3(0,0,0) and not player.is_player_modder(_pid,_GT_mod_info.int_str[33][1]) then 
			player.set_player_as_modder(_pid, _GT_mod_info.int_str[33][1])
			menu.notify("".._GT_plyr_info.name[_pid+1].."\nPlayer is un-dead.\n --Marking as Modder--",_G_GeeVer,7,2)
		end
	end
end

function _GF_plyr_mod_flags_str(i,_pid)
	_GT_plyr_info.mod_flags_str[i]=""
	for m=1,#_GT_mod_info.int_str do
		if player.is_player_modder(_pid,_GT_mod_info.int_str[m][1]) then
			_GT_plyr_info.mod_flags_str[i]=_GT_plyr_info.mod_flags_str[i].._GT_mod_info.int_str[m][2].." "
		end
	end
end

function _GF_plyr_typing_check(i)
	if _GT_plyr_info.typing[i]==true then
		if _GT_plyr_info.typing_stop[i]==true and (_GT_plyr_info.typing_stop_time[i]+3 < utils.time()) then
			_GF_default_typing(i)
		elseif (_GT_plyr_info.typing_start_time[i]+30 < utils.time())  then
			_GF_default_typing(i)
		end
	else
		_GF_default_typing(i)
	end
end

function _GF_plyr_pause_check(i)
	if _GT_plyr_info.pause[i]==true then
		if _GT_plyr_info.pause_stop[i]==true then
			_GF_default_pause(i)
		elseif (_GT_plyr_info.pause_start_time[i]+60 < utils.time())  then
			_GF_default_pause(i)
		end
	else
		_GF_default_pause(i)
	end
end

function _GF_plyr_stat_record(i,_pid,pos,time)
	_GT_plyr_info.host_priority_str[i] = tostring(player.get_player_host_priority(_pid)).." / "..tostring(player.player_count())
	_GT_plyr_info.ip[i] = _GF_plyr_ip(_pid)
	_GT_plyr_info.scid[i] = player.get_player_scid(_pid)
	_GT_plyr_info.name[i] = player.get_player_name(_pid)
	_GT_plyr_info.kd[i] = _GF_plyr_kd(_pid)
	_GT_plyr_info.money[i] = _GF_plyr_money(_pid)
	_GT_plyr_info.rank[i] = _GF_plyr_lvl(_pid)
	_GT_plyr_info.modder[i] = player.is_player_modder(_pid,-1)
	_GT_plyr_info.plyr_god[i] = player.is_player_god(_pid)
	_GT_plyr_info.visible[i] = entity.is_entity_visible(player.get_player_ped(_pid))
	_GT_plyr_info.color[i] = _GF_org_color_int(_pid)
	_GT_plyr_info.dead[i] = entity.is_entity_dead(player.get_player_ped(_pid))
	_GT_plyr_info.is_frnd[i] = player.is_player_friend(_pid)
	_GT_plyr_info.net_hash[i] = network.network_hash_from_player(_pid)
	if _GF_pid_loading(_pid,time) then
		_GT_plyr_info.plyr_play[i] = false
		_GT_plyr_info.loading[i] = true
	else
		_GT_plyr_info.loading[i] = false
		if not player.is_player_playing(_pid) then
			if _GT_plyr_info.dead[i] == true then
				_GT_plyr_info.plyr_play[i] = true
			else
				_GT_plyr_info.plyr_play[i] = false
				--_GT_plyr_info.pos_v2[i] = v2(pos.x,pos.y)
				--_GT_plyr_info.pos_time[i] = time
			end
		end
	end
	_GT_plyr_info.invisible[i] = _GF_plyr_invis(_pid)
end

function _GF_plyr_undead_check(i,_pid,pos)
	if (_GT_plyr_info.dead[i] == true or player.get_player_max_health(_pid) == 0.0) and not _GT_plyr_info.loading[i] then
		if _G_show_undead_blips.on and pos ~= v3(0.0,0.0,0.0) and player.get_player_max_health(_pid) == 0.0 then
			if _GT_plyr_info.undead_blip[i] == v3(0,0,0) then
				if _GT_plyr_info.otr_blip[i] ~= v3(0,0,0) then
					ui.remove_blip(_GT_plyr_info.otr_blip[i])
					_GT_plyr_info.otr_blip[i] = v3(0,0,0)
				end
				_GT_plyr_info.undead_blip[i] = ui.add_blip_for_coord(pos)
				ui.set_blip_colour(_GT_plyr_info.undead_blip[i],72)
			else
				ui.set_blip_coord(_GT_plyr_info.undead_blip[i],pos)
			end
		elseif _GT_plyr_info.undead_blip[i] ~= v3(0,0,0) then
			ui.remove_blip(_GT_plyr_info.undead_blip[i])
			_GT_plyr_info.undead_blip[i] = v3(0,0,0)
		end 
	elseif _GT_plyr_info.undead_blip[i] ~= v3(0,0,0) then
		ui.remove_blip(_GT_plyr_info.undead_blip[i])
		_GT_plyr_info.undead_blip[i] = v3(0,0,0)
	end 
end
				
function _GF_plyr_otr_check(i,_pid,time,pos)
	if not _GT_plyr_info.loading[i] then _GT_plyr_info.otr[i] = _GF_plyr_otr(_pid) else _GT_plyr_info.otr[i] = false end
	if _GT_plyr_info.otr[i] == false then
		_GT_plyr_info.otr_time[i] = -1
		_GT_plyr_info.otr_1_min[i] = false
		_GT_plyr_info.otr_3_min[i] = false
		_GT_plyr_info.otr_many_min[i] = -1
		if _GT_plyr_info.otr_blip[i] ~= v3(0,0,0) then
			ui.remove_blip(_GT_plyr_info.otr_blip[i])
		end
		_GT_plyr_info.otr_blip[i] = v3(0,0,0)
	elseif _GT_plyr_info.otr[i] == true then
		if _GT_plyr_info.otr_time[i] == -1 then
			_GT_plyr_info.otr_time[i] = time -- start otr time count
		elseif _pid ~= player.player_id() then
			if _G_show_otr_blips.on and _GT_plyr_info.undead_blip[i] == v3(0,0,0) then
				if _GT_plyr_info.otr_blip[i] == v3(0,0,0) then
					_GT_plyr_info.otr_blip[i] = ui.add_blip_for_coord(pos)
					ui.set_blip_colour(_GT_plyr_info.otr_blip[i],2)
				else
					ui.set_blip_coord(_GT_plyr_info.otr_blip[i],pos)
				end
			end
			if _GT_plyr_info.otr_time[i]+61 < time and _GT_plyr_info.otr_1_min[i] == false then
				menu.notify("".._GT_plyr_info.name[i].."\nOff-the-radar for more than one minute",_G_GeeVer,7,2) -- i was going to use the one minute mark as mod detection but plyrs often are otr >1min for gta reasons
				_GT_plyr_info.otr_1_min[i] = true
			elseif _GT_plyr_info.otr_time[i]+181 < time and _GT_plyr_info.otr_3_min[i] == false then
				if _G_mods_detex_otr_tog.on and player.can_player_be_modder(_pid) and not player.is_player_modder(_pid,_GT_mod_info.int_str[27][1]) then
					player.set_player_as_modder(_pid, _GT_mod_info.int_str[27][1])
					menu.notify("".._GT_plyr_info.name[i].."\nOff-the-radar for more than three minutes.\n --Marking as Modder--",_G_GeeVer,7,2)
				else
					menu.notify("".._GT_plyr_info.name[i].."\nOff-the-radar for more than three minutes",_G_GeeVer,7,2)
				end
				_GT_plyr_info.otr_3_min[i] = true
			elseif _GT_plyr_info.otr_1_min[i] == true and _GT_plyr_info.otr_3_min[i] == true then
				if _GT_plyr_info.otr_many_min[i] == -1 then
					_GT_plyr_info.otr_many_min[i] = time + 300
				elseif _GT_plyr_info.otr_many_min[i] < time then
					menu.notify("".._GT_plyr_info.name[i].."\nOff-the-radar for more than "..math.floor((_GT_plyr_info.otr_many_min[i]-_GT_plyr_info.otr_time[i])/60).." minutes",_G_GeeVer,7,2)
					_GT_plyr_info.otr_many_min[i] = -1
				end
			end
			if _G_mods_detex_otr_tog.on and _GT_plyr_info.otr_time[i]+181 < time and player.can_player_be_modder(_pid) and not player.is_player_modder(_pid,_GT_mod_info.int_str[27][1]) then -- if the feature is toggled on after theyve been otr > 3 min
				player.set_player_as_modder(_pid, _GT_mod_info.int_str[27][1])
				menu.notify("".._GT_plyr_info.name[i].."\nOff-the-radar for more than three minutes.\n --Marking as Modder--",_G_GeeVer,7,2)
			end
		end							
	end
end

-- function _GF_plyr_tp_check(i,_pid,pos,time,_check_time)
	-- if utils.time() > _check_time then --this prevents the whole lobby from notifying when you start the script
		-- if  _GF_pid_loading(_pid) then --if newly recorded player record their pos and time recorded
			-- _GT_plyr_info.pos_v2[i] = v2(pos.x,pos.y)
			-- _GT_plyr_info.pos_time[i] = time
		-- elseif _GT_plyr_info.pos_time[i]+10 < time then
			-- if _GF_dist_pos_pos(_GT_plyr_info.pos_v2[i],v2(pos.x,pos.y)) > 1000 and _pid ~= player.player_id() then
				-- menu.notify("".._GT_plyr_info.name[i].."\nPossible TP - Moving very fast",_G_GeeVer,4,2)	
			-- end
			-- _GT_plyr_info.pos_v2[i] = v2(pos.x,pos.y)
			-- _GT_plyr_info.pos_time[i] = time
		-- end
	-- else
		-- _GT_plyr_info.pos_v2[i] = v2(pos.x,pos.y)
		-- _GT_plyr_info.pos_time[i] = time
	-- end
-- end

function _GF_plyr_veh_check(i,_pid,time)
	if player.is_player_in_any_vehicle(_pid) and _GF_valid_veh(player.get_player_vehicle(_pid)) then --actions will continue to work on vehicle even after they get out
		_GT_plyr_info.veh_erase_time[i] = -1
		_GT_plyr_info.veh[i] = player.get_player_vehicle(_pid)
		_GT_plyr_info.in_veh[i] = true
		_GT_plyr_info.veh_god[i] = player.is_player_vehicle_god(_pid)
		if entity.get_entity_speed(_GT_plyr_info.veh[i]) ~= nil then
			if entity.get_entity_speed(_GT_plyr_info.veh[i]) > 0 then
				_GT_plyr_info.mph[i] = _GF_1_decimal(entity.get_entity_speed(_GT_plyr_info.veh[i]) * 2.23694)
				_GT_plyr_info.kph[i] = _GF_1_decimal(entity.get_entity_speed(_GT_plyr_info.veh[i]) * 3.6) 
			elseif _GT_plyr_info.mph[i] > 0 and _GT_plyr_info.kph[i] > 0 then
				if _GT_plyr_info.speed_erase_time[i] == -1 then 
					_GT_plyr_info.speed_erase_time[i] = time + 3-- gta cant tell their speed half the time and this prevents flicker. If no speed reported it will display last speed for 3 seconds
				elseif _GT_plyr_info.speed_erase_time[i] < time then  
					_GT_plyr_info.mph[i] = -1
					_GT_plyr_info.kph[i] = -1
					_GT_plyr_info.speed_erase_time[i] = -1
				end
			end
		else
			_GT_plyr_info.mph[i] = 0
			_GT_plyr_info.kph[i] = 0
		end
	else
		_GT_plyr_info.in_veh[i] = false
		_GT_plyr_info.veh_god[i] = false
		_GT_plyr_info.mph[i] = -1
		_GT_plyr_info.kph[i] = -1
		if _GT_plyr_info.veh[i] ~= -1 and _GT_plyr_info.veh_erase_time[i] == -1 then  -- if they were in a vehicle and no timer set
			_GT_plyr_info.veh_erase_time[i] = time + 120
		elseif _GT_plyr_info.veh_erase_time[i] < time then -- will remove vehicle from table if 2 minutes have passed
			_GT_plyr_info.veh[i] = -1
			_GT_plyr_info.veh_erase_time[i] = -1
		end
	end
end

function _GF_all_plyr_info_do(i,_pid,time,_check_time)
	_GF_plyr_typing_check(i)
	_GF_plyr_pause_check(i)
	_GF_plyr_stat_record(i,_pid,player.get_player_coords(_pid),time)
	_GF_plyr_undead_check(i,_pid,player.get_player_coords(_pid))
	_GF_plyr_otr_check(i,_pid,time,player.get_player_coords(_pid))
	--_GF_plyr_tp_check(i,_pid,player.get_player_coords(_pid),time,_check_time) -- i think this is causing performance issues
	_GF_plyr_veh_check(i,_pid,time)
	_GF_check_for_mods(i,_pid,time)
	_GF_plyr_mod_flags_str(i,_pid)
	_GT_plyr_info.join_leave_str[i] = _GF_join_info(_pid)
	_GT_plyr_info.join_leave_table[i][3]=_GF_join_leave_log(i,_pid)
end

function _G_plyrs_info_do(parent)
	_GT_plyr_info = {}

	_GT_plyr_info.veh = {}
	_GT_plyr_info.in_veh = {}
	_GT_plyr_info.veh_erase_time = {}
	_GT_plyr_info.veh_god = {}
	_GT_plyr_info.scid = {}
	_GT_plyr_info.name = {}
	_GT_plyr_info.tp_sett = {}
	_GT_plyr_info.kd = {}
	_GT_plyr_info.rank = {}
	_GT_plyr_info.money = {}
	_GT_plyr_info.mph = {}
	_GT_plyr_info.kph = {}
	_GT_plyr_info.speed_erase_time = {}
	_GT_plyr_info.otr = {}
	_GT_plyr_info.otr_time = {}
	_GT_plyr_info.otr_1_min = {}
	_GT_plyr_info.otr_3_min = {}
	_GT_plyr_info.otr_many_min = {}
	_GT_plyr_info.otr_blip = {}
	_GT_plyr_info.undead_blip = {}
	_GT_plyr_info.plyr_god = {}
	_GT_plyr_info.visible = {}
	_GT_plyr_info.invisible = {}
	_GT_plyr_info.modder = {}
	_GT_plyr_info.interior = {}
	_GT_plyr_info.interior_str = {}
	_GT_plyr_info.interior_time = {}
	_GT_plyr_info.pos_v2 = {}
	_GT_plyr_info.pos_time = {}
	_GT_plyr_info.dead = {}
	_GT_plyr_info.plyr_play = {}
	_GT_plyr_info.color = {}
	_GT_plyr_info.typing = {}
	_GT_plyr_info.typing_start_time = {}
	_GT_plyr_info.typing_stop = {}
	_GT_plyr_info.typing_stop_time = {}
	_GT_plyr_info.ip = {}
	_GT_plyr_info.mod_flags_str = {}
	_GT_plyr_info.host_priority_str = {}
	_GT_plyr_info.join_leave_str = {}
	_GT_plyr_info.join_time = {}
	_GT_plyr_info.join_time_str = {}
	_GT_plyr_info.pause = {}
	_GT_plyr_info.pause_start_time = {}
	_GT_plyr_info.pause_stop = {}
	_GT_plyr_info.pause_stop_time = {}
	_GT_plyr_info.ff_jt = {}
	_GT_plyr_info.ff_stlk = {}
	_GT_plyr_info.ff_hide = {}
	_GT_plyr_info.ff_frnd = {}
	_GT_plyr_info.plyr_speed_pos_mps = {}
	_GT_plyr_info.plyr_speed_pos_time = {}
	_GT_plyr_info.plyr_speed_pos_mph = {}
	_GT_plyr_info.plyr_speed_pos_kph = {}
	_GT_plyr_info.plyr_speed_pos = {}
	_GT_plyr_info.loading = {}
	_GT_plyr_info.plyr_moving = {}
	_GT_plyr_info.is_frnd = {}
	_GT_plyr_info.net_hash = {}
	function _GF_plyr_info_start()
		for i = 1, 32 do
			_GT_plyr_info.veh[#_GT_plyr_info.veh+1]=-1
			_GT_plyr_info.in_veh[#_GT_plyr_info.in_veh+1]=false
			_GT_plyr_info.veh_erase_time[#_GT_plyr_info.veh_erase_time+1]=-1
			_GT_plyr_info.veh_god[#_GT_plyr_info.veh_god+1]=false
			_GT_plyr_info.scid[#_GT_plyr_info.scid+1]=-1
			_GT_plyr_info.name[#_GT_plyr_info.name+1]="Player"
			_GT_plyr_info.tp_sett[#_GT_plyr_info.tp_sett+1]=false --setting for online tab
			_GT_plyr_info.kd[#_GT_plyr_info.kd+1]=-1
			_GT_plyr_info.rank[#_GT_plyr_info.rank+1]=-1
			_GT_plyr_info.money[#_GT_plyr_info.money+1]=-1
			_GT_plyr_info.mph[#_GT_plyr_info.mph+1]=-1
			_GT_plyr_info.kph[#_GT_plyr_info.kph+1]=-1
			_GT_plyr_info.speed_erase_time[#_GT_plyr_info.speed_erase_time+1]=-1
			_GT_plyr_info.otr[#_GT_plyr_info.otr+1]=false
			_GT_plyr_info.otr_time[#_GT_plyr_info.otr_time+1]=-1
			_GT_plyr_info.otr_1_min[#_GT_plyr_info.otr_1_min+1]=false
			_GT_plyr_info.otr_3_min[#_GT_plyr_info.otr_3_min+1]=false
			_GT_plyr_info.otr_many_min[#_GT_plyr_info.otr_many_min+1]=-1
			_GT_plyr_info.otr_blip[#_GT_plyr_info.otr_blip+1]=v3(0,0,0)
			_GT_plyr_info.undead_blip[#_GT_plyr_info.undead_blip+1]=v3(0,0,0)
			_GT_plyr_info.plyr_god[#_GT_plyr_info.plyr_god+1]=false
			_GT_plyr_info.visible[#_GT_plyr_info.visible+1]=false
			_GT_plyr_info.invisible[#_GT_plyr_info.visible+1]=false
			_GT_plyr_info.modder[#_GT_plyr_info.modder+1]=false
			_GT_plyr_info.interior[#_GT_plyr_info.interior+1]=false
			_GT_plyr_info.interior_str[#_GT_plyr_info.interior_str+1]=""
			_GT_plyr_info.interior_time[#_GT_plyr_info.interior_time+1]=utils.time_ms()
			_GT_plyr_info.pos_v2[#_GT_plyr_info.pos_v2+1]=v2(0,0)
			_GT_plyr_info.pos_time[#_GT_plyr_info.pos_time+1]=-1
			_GT_plyr_info.dead[#_GT_plyr_info.dead+1]=false
			_GT_plyr_info.plyr_play[#_GT_plyr_info.plyr_play+1]=false
			_GT_plyr_info.color[#_GT_plyr_info.color+1]=-1
			_GT_plyr_info.typing[#_GT_plyr_info.typing+1]=false
			_GT_plyr_info.typing_start_time[#_GT_plyr_info.typing_start_time+1]=-1
			_GT_plyr_info.typing_stop[#_GT_plyr_info.typing_stop+1]=false
			_GT_plyr_info.typing_stop_time[#_GT_plyr_info.typing_stop_time+1]=-1
			_GT_plyr_info.ip[#_GT_plyr_info.ip+1]="IP"
			_GT_plyr_info.mod_flags_str[#_GT_plyr_info.mod_flags_str+1]=""
			_GT_plyr_info.host_priority_str[#_GT_plyr_info.host_priority_str+1]="0 / 0"
			_GT_plyr_info.join_leave_str[#_GT_plyr_info.join_leave_str+1]=""
			_GT_plyr_info.join_time[#_GT_plyr_info.join_time+1]=-1
			_GT_plyr_info.join_time_str[#_GT_plyr_info.join_time_str+1]=""
			_GT_plyr_info.pause[#_GT_plyr_info.pause+1]=false
			_GT_plyr_info.pause_start_time[#_GT_plyr_info.pause_start_time+1]=-1
			_GT_plyr_info.pause_stop[#_GT_plyr_info.pause_stop+1]=false
			_GT_plyr_info.pause_stop_time[#_GT_plyr_info.pause_stop_time+1]=-1
			_GT_plyr_info.ff_jt[#_GT_plyr_info.ff_jt+1]=0
			_GT_plyr_info.ff_stlk[#_GT_plyr_info.ff_stlk+1]=0
			_GT_plyr_info.ff_hide[#_GT_plyr_info.ff_hide+1]=0
			_GT_plyr_info.ff_frnd[#_GT_plyr_info.ff_frnd+1]=0
			_GT_plyr_info.plyr_speed_pos_mps[#_GT_plyr_info.plyr_speed_pos_mps+1]=0
			_GT_plyr_info.plyr_speed_pos_time[#_GT_plyr_info.plyr_speed_pos_time+1]=0
			_GT_plyr_info.plyr_speed_pos_mph[#_GT_plyr_info.plyr_speed_pos_mph+1]=0
			_GT_plyr_info.plyr_speed_pos_kph[#_GT_plyr_info.plyr_speed_pos_kph+1]=0
			_GT_plyr_info.plyr_speed_pos[#_GT_plyr_info.plyr_speed_pos+1]=v3(0,0,0)
			_GT_plyr_info.plyr_moving[#_GT_plyr_info.plyr_moving+1]=false
			_GT_plyr_info.loading[#_GT_plyr_info.loading+1]=false
			_GT_plyr_info.is_frnd[#_GT_plyr_info.is_frnd+1]=false
			_GT_plyr_info.net_hash[#_GT_plyr_info.net_hash+1]=-1
		end
		-- for i=1,32 do
			-- for ii=1,32 do
				-- _GT_plyr_info.plyr_moving[i][#_GT_plyr_info.plyr_moving[ii]+1]={}
			-- end
		-- end
	end
	_GF_plyr_info_start()

	_GT_plyr_info.typing_hook=hook.register_script_event_hook(function(pid,target,prmtr)
		--if prmtr[1] == 0x2c8a72d0 then
		if prmtr[1] == 747270864 then
			--print("PID: ".._GF_plyr_name(pid).."  typing start: "..prmtr[1])
			_GT_plyr_info.typing[pid+1]=true
			_GT_plyr_info.typing_start_time[pid+1]=utils.time()
			_GT_plyr_info.typing_stop[pid+1]=false
			_GT_plyr_info.typing_stop_time[pid+1] = -1
		elseif  prmtr[1] == 3304008971 then
			--print("PID: ".._GF_plyr_name(pid).."  typing stop: "..prmtr[1])
			_GT_plyr_info.typing_stop[pid+1]=true
			if _GT_plyr_info.typing_stop_time[pid+1] == -1 then
				_GT_plyr_info.typing_stop_time[pid+1]=utils.time()
			end
		end 
		if prmtr[1] == 959741220 then
			--print("PID: ".._GF_plyr_name(pid).."  pause start: "..prmtr[1])
			_GT_plyr_info.pause[pid+1]=true
			_GT_plyr_info.pause_start_time[pid+1]=utils.time()
			_GT_plyr_info.pause_stop[pid+1]=false
			_GT_plyr_info.pause_stop_time[pid+1] = -1
		elseif  prmtr[1] == 1456985457 then
			--print("PID: ".._GF_plyr_name(pid).."  pause stop: "..prmtr[1])
			_GT_plyr_info.pause_stop[pid+1]=true
			if _GT_plyr_info.pause_stop_time[pid+1] == -1 then
				_GT_plyr_info.pause_stop_time[pid+1]=utils.time()
			end
		end 
			-- if target == player.player_id() or pid == player.player_id() then
				-- print("SCRIPT PID: ".._GF_plyr_name(pid).."  Target: ".._GF_plyr_name(target).." Prmtr: "..prmtr[1])
			-- end
		--print("PID: ".._GF_plyr_name(pid).."  Target: ".._GF_plyr_name(target).." Prmtr 1: "..prmtr[1])
		-- if pid == player.player_id() then
			-- if prmtr[1] ~= nil then
				-- print("PID: ".._GF_plyr_name(pid).."  Target: ".._GF_plyr_name(target).." Prmtr 1: "..prmtr[1])
			-- end
		-- end
	end)
	
	-- _G_net_test_hook=hook.register_net_event_hook(function(pid,target,prmtr)
		-- if pid == player.player_id() then
			-- if prmtr ~= nil then
				-- print("NETWORK PID: ".._GF_plyr_name(pid).."  Target: ".._GF_plyr_name(target).." Prmtr: "..prmtr)
			-- end
		-- end
	-- end)
	
	_GT_plyr_info.record_feat=menu.add_feature("hidden setting to record player info", "toggle", parent.id, function(f,pid)
		local pos_check_time = utils.time() + 3
		local _pid,time
		while f.on do
			for i = 1, 32 do
				_pid = i-1
				time = utils.time()
				if not _GF_valid_pid(_pid)  then
					if _GT_plyr_info.scid[i] ~= -1 then
						_GT_plyr_info.join_leave_table[i][2]=true
						if utils.time() > pos_check_time and _G_plyr_JL_notif.on and _G_plyr_JL_notif.value ~= 1 then
							menu.notify("Player leaving\n"..tostring(_GT_plyr_info.join_leave_str[i]).."", _G_GeeVer, 7, 2)
						end
					end
					_GF_plyr_info_default(i) -- all settings back to default
				elseif _GF_plyr_name(_pid) ~= "Player" then
					if _GT_plyr_info.scid[i] == -1 then
						_GT_plyr_info.join_time_str[i] = os.date("%Y-%m-%d %H%M-%S")
						_GT_plyr_info.join_time[i] = utils.time()
						_GT_plyr_info.join_leave_table[i][1]=true
						_GF_all_plyr_info_do(i,_pid,time,pos_check_time) -- this is a pretty big function functions
						if utils.time() > pos_check_time and _GT_plyr_info.join_leave_str[i] ~= "" then
							if _G_plyr_JL_notif.on and _G_plyr_JL_notif.value ~= 2 then
								menu.notify("Player joining\n"..tostring(_GT_plyr_info.join_leave_str[i]).."", _G_GeeVer, 7, 2)
							end
						end
					else
						_GF_all_plyr_info_do(i,_pid,time,pos_check_time)
					end
				else
					_GF_plyr_info_default(i)
				end
			end
			system.yield(100)
		end
	end)
	_GT_plyr_info.record_feat.on = true
	_GT_plyr_info.record_feat.hidden = true
	
	_GT_plyr_info.record_interior_feat=menu.add_feature("hidden setting to record player interior info", "toggle", parent.id, function(f,pid) -- proved to resource hungry
		while f.on do
			for i = 0, 31 do
				if _GF_valid_pid(i) then
					if i == player.player_id() or _GT_plyr_info.interior_time[i+1] + math.random(669,996) < utils.time_ms() then --random seems dumb but it prevents every player detected as interior when loading from checking simultaneously
						if _GT_plyr_info.interior[i+1] then
							if _GF_is_pid_intrr(i) then
								_GT_plyr_info.interior_str[i+1]=_GF_intrr_str(i)
							else
								_GT_plyr_info.interior[i+1] = false
								_GT_plyr_info.interior_str[i+1]=""
							end
						elseif _GF_is_pid_intrr(i) then
							_GT_plyr_info.interior[i+1]=true
							_GT_plyr_info.interior_str[i+1]=_GF_intrr_str(i)
						else
							_GT_plyr_info.interior[i+1] = false
							_GT_plyr_info.interior_str[i+1]=""
						end
						_GT_plyr_info.interior_time[i+1]=utils.time_ms()
					end
					system.yield(7) -- more players more yield
				else
					_GT_plyr_info.interior[i+1] = false
					_GT_plyr_info.interior_str[i+1]=""
					_GT_plyr_info.interior_time[i+1]=utils.time_ms()
				end
				system.yield(7) -- always at least 165 ms of yield
			end
			system.yield(7)
		end
	end)
	_GT_plyr_info.record_interior_feat.on = true
	_GT_plyr_info.record_interior_feat.hidden = true
	
	_GT_plyr_info.typing_self_feat=menu.add_feature("hidden setting to record self typing", "toggle", parent.id, function(f)
		while f.on do
			system.yield(0) -- even a 10ms delay would make it not catch the action sometimes
			if _GT_plyr_info.typing[player.player_id()+1]==false then
				if controls.is_control_just_pressed(0,245) or controls.is_control_just_pressed(0,246) then
					_GT_plyr_info.typing[player.player_id()+1]=true
					_GT_plyr_info.typing_start_time[player.player_id()+1]=utils.time()
					_GT_plyr_info.typing_stop[player.player_id()+1]=false
					_GT_plyr_info.typing_stop_time[player.player_id()+1] = -1
					system.yield(100)
				end
			elseif _GT_plyr_info.typing[player.player_id()+1]==true then
				if _GF_vk_key_down("RETURN") or _GF_vk_key_down("ESCAPE") or (_GT_plyr_info.typing_start_time[player.player_id()+1]+30 < utils.time()) then
					_GF_default_typing(player.player_id()+1)
				end
			end
		end
	end)
	_GT_plyr_info.typing_self_feat.on=true
	_GT_plyr_info.typing_self_feat.hidden=true
	
	_GT_plyr_info.plyr_speed_feat=menu.add_feature("hidden setting to record plyr speed pos", "toggle", parent.id, function(f)
		local plyr_ped,plyr_veh,speed,time_check = 0,0,0,0
		local function not_zero_nil(_val)
			if _val ~= nil and _val ~= 0 then
				return true
			end
			return false
		end
		local function record_speed_pos_time(_val,i)
			_GT_plyr_info.plyr_speed_pos_mph[i] = _GF_1_decimal(_val * 2.23694)
			_GT_plyr_info.plyr_speed_pos_kph[i] = _GF_1_decimal(_val * 3.6)
			_GT_plyr_info.plyr_speed_pos_mps[i] = _GF_1_decimal(_val)
			_GT_plyr_info.plyr_speed_pos_time[i] = utils.time_ms()
			_GT_plyr_info.plyr_speed_pos[i] = player.get_player_coords(i-1)
			_GT_plyr_info.plyr_moving[i] = _GF_num_in_range(_val * 2.23694,1,200)
			system.yield(5)
		end
		while f.on do
			system.yield(50)
			for i = 1, 32 do
				_pid = i-1
				if _GF_valid_pid(_pid) then
					if player.is_player_in_any_vehicle(_pid) and not_zero_nil(entity.get_entity_speed(player.get_player_vehicle(_pid))) then
						record_speed_pos_time(entity.get_entity_speed(player.get_player_vehicle(_pid)),i)
					elseif not_zero_nil(entity.get_entity_speed(player.get_player_ped(_pid))) then
						record_speed_pos_time(entity.get_entity_speed(player.get_player_ped(_pid)),i)
					elseif _GT_plyr_info.plyr_speed_pos_time[i] == 0 or _GT_plyr_info.plyr_speed_pos[i] == v3(0,0,0) then
						record_speed_pos_time(0,i)
					else
						time_check = (utils.time_ms()-_GT_plyr_info.plyr_speed_pos_time[i])
						if time_check > 250 then
							speed = (_GF_dist_pos_pos(player.get_player_coords(_pid),_GT_plyr_info.plyr_speed_pos[i])/(time_check/1000))
							record_speed_pos_time(speed,i)
							system.yield(5)
						end
					end
					system.yield(5)
				else
					_GT_plyr_info.plyr_speed_pos[i] = v3(0,0,0)
					_GT_plyr_info.plyr_speed_pos_mps[i] = 0
					_GT_plyr_info.plyr_speed_pos_mph[i] = 0
					_GT_plyr_info.plyr_speed_pos_kph[i] = 0
					_GT_plyr_info.plyr_speed_pos_time[i] = 0
					_GT_plyr_info.plyr_moving[i] = false
				end
			end
		end
	end)
	_GT_plyr_info.plyr_speed_feat.on=true
	_GT_plyr_info.plyr_speed_feat.hidden=true

	function _GF_plyr_info_default(I)
		_GT_plyr_info.veh[I] = -1
		_GT_plyr_info.in_veh[I] = false
		_GT_plyr_info.veh_erase_time[I] = -1
		_GT_plyr_info.veh_god[I] = false
		_GT_plyr_info.scid[I] = -1
		_GT_plyr_info.name[I] = "Player"
		_GT_plyr_info.tp_sett[I] = false
		_GT_plyr_info.kd[I] = -1
		_GT_plyr_info.money[I] = -1
		_GT_plyr_info.rank[I] = -1
		_GT_plyr_info.mph[I] = -1
		_GT_plyr_info.kph[I] = -1
		_GT_plyr_info.speed_erase_time[I] = -1
		_GT_plyr_info.otr[I] = false
		_GT_plyr_info.otr_time[I] = -1
		_GT_plyr_info.otr_1_min[I] = false
		_GT_plyr_info.otr_3_min[I] = false
		_GT_plyr_info.otr_many_min[I] = -1
		if _GT_plyr_info.otr_blip[I] ~= v3(0,0,0) then
			ui.remove_blip(_GT_plyr_info.otr_blip[I])
		end
		_GT_plyr_info.otr_blip[I] = v3(0,0,0)
		if _GT_plyr_info.undead_blip[I] ~= v3(0,0,0) then
			ui.remove_blip(_GT_plyr_info.undead_blip[I])
		end
		_GT_plyr_info.undead_blip[I] = v3(0,0,0)
		_GT_plyr_info.plyr_god[I] = false
		_GT_plyr_info.visible[I] = false
		_GT_plyr_info.invisible[I] = false
		_GT_plyr_info.modder[I] = false
		--_GT_plyr_info.interior[I] = false
		_GT_plyr_info.pos_v2[I] = v2(0,0)
		_GT_plyr_info.pos_time[I] = -1
		_GT_plyr_info.dead[I]  = false
		_GT_plyr_info.plyr_play[I]  = false
		_GT_plyr_info.color[I] = -1
		_GT_plyr_info.ip[I] = "IP"
		_GT_plyr_info.mod_flags_str[I] = ""
		_GT_plyr_info.host_priority_str[I] = "0 / 0"
		_GF_default_typing(I)
		_GT_plyr_info.join_leave_str[I]="Player"
		_GT_plyr_info.join_time[I] = -1
		_GT_plyr_info.join_time_str[I] = ""
		_GT_plyr_info.net_hash[I] = -1
		_GT_plyr_info.is_frnd[I] = false
		for m=1,#_GT_mod_info.int_str do
			player.unset_player_as_modder(I-1,_GT_mod_info.int_str[m][1])
		end
		_GF_default_pause(I)
		_GT_plyr_info.ff_jt[I] = 0
		_GT_plyr_info.ff_stlk[I] = 0
		_GT_plyr_info.ff_hide[I] = 0
		_GT_plyr_info.ff_frnd[I] = 0
	end
	
	function _GF_default_typing(I)
		_GT_plyr_info.typing[I] = false
		_GT_plyr_info.typing_start_time[I] = -1
		_GT_plyr_info.typing_stop[I] = false
		_GT_plyr_info.typing_stop_time[I] = -1
	end
	
	function _GF_default_pause(I)
		_GT_plyr_info.pause[I] = false
		_GT_plyr_info.pause_start_time[I] = -1
		_GT_plyr_info.pause_stop[I] = false
		_GT_plyr_info.pause_stop_time[I] = -1
	end
	
	_GT_plyr_info.veh_grief_choice = {}
	for i=1, 32 do
		_GT_plyr_info.veh_grief_choice[i] = {false,0}
	end
	
	_GT_plyr_info.join_leave_table ={}
	for i=1, 32 do
		_GT_plyr_info.join_leave_table[i] = {false,false,""}
	end
	
	_GT_plyr_info.log_plyrs_to_file=menu.add_feature("Log players", "toggle",0, function(f)
		local directory,file_path,file,pid,pidT
		while f.on do
			system.yield(25)
			directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\Logs\\"
			if not utils.dir_exists(directory) then
				utils.make_dir(directory)
			end
			if not utils.dir_exists(directory.."player_logs\\") then
				utils.make_dir(directory.."player_logs\\")
			end
			if not utils.dir_exists(directory.."player_logs\\"..os.date("%Y-%m").."\\") then
				utils.make_dir(directory.."player_logs\\"..os.date("%Y-%m").."\\")
			end
			file_path = "player_logs\\"..os.date("%Y-%m").."\\Player_logs_"..os.date("%Y-%m-%d")
			if not utils.file_exists(directory..file_path..".csv") then
				file = io.open(directory..file_path..".csv", "a")
				file:write(_G_GeeVer.."\nDate/Time,Join/Leave,Name,SCID,IP,PID,Friend,Host,Host Priority,Rank,K/D,Money,Modder Flags")
				file:close()
			end
			for i=1, #_GT_plyr_info.join_leave_table do
				if _GT_plyr_info.join_leave_table[i][1] == true then -- joining
					pid=i-1
					pidT=i
					if (_GT_plyr_info.join_time[i]+10 < utils.time() and _GF_good_plyr_info_log(pidT,pid)) then 
						print(_GT_plyr_info.join_time_str[pidT]..",Join,".._GT_plyr_info.join_leave_table[i][3])
						file = io.open(directory..file_path..".csv", "a")
						file:write("\n".._GT_plyr_info.join_time_str[pidT]..",Join,".._GF_join_leave_log(pidT,pid))
						file:close()
						_GT_plyr_info.join_leave_table[i][1] = false
					end
				elseif _GT_plyr_info.join_leave_table[i][2] == true then -- leaving
					print(os.date("%Y-%m-%d %H%M-%S,Leave,").._GT_plyr_info.join_leave_table[i][3])
					file = io.open(directory..file_path..".csv", "a")
					file:write("\n"..os.date("%Y-%m-%d %H%M-%S,Leave,").._GT_plyr_info.join_leave_table[i][3])
					file:close()
					_GT_plyr_info.join_leave_table[i][2] = false
				end
			end
		end
	end)
	_GT_plyr_info.log_plyrs_to_file.on=true
	_GT_plyr_info.log_plyrs_to_file.hidden=true

	
end

function _GF_good_plyr_info_log(pidT,pid)
	if _GT_plyr_info.name[pidT] ~= "Player" and _GT_plyr_info.scid[pidT] ~= -1 and _GT_plyr_info.ip[pidT] ~= "IP" and _GT_plyr_info.host_priority_str[pidT] ~= "0 / 0" and _GF_is_not_not(_GT_plyr_info.rank[pidT],-1,0,nil) and _GF_is_not_not(_GT_plyr_info.kd[pidT],-1,0,nil) and _GF_is_not_not(_GT_plyr_info.money[pidT],-1,0,nil) then
		return true
	end
end

function _GF_join_leave_log(_pidT,_pid)
	return _GT_plyr_info.name[_pidT]..",".._GT_plyr_info.scid[_pidT]..",".._GT_plyr_info.ip[_pidT]..",".._pid..",".._GF_is_frnd_str(_pid)..",".._GF_plyr_host_str(_pid)..","..tostring(player.get_player_host_priority(_pid)).." of "..tostring(player.player_count())..",".._GF_plyr_lvl(_pid)..",".._GF_plyr_kd(_pid)..",$".._GF_plyr_money(_pid)..",".._GT_plyr_info.mod_flags_str[_pidT]
end

	
function _GF_plyr_host_str(_pid)
	if player.is_player_host(_pid) then
		return "Host"
	end
	return " "	
end

function _GF_is_not_not(_value,_not1,_not2,_not3)
	if _value ~= _not1 and _value ~= _not2 and _value ~= _not3 then
		return true
	end
	return false
end

function _GF_is_frnd_str(_pid)
	if _GF_valid_pid(_pid) and player.is_player_friend(_pid) then
		return "Friend"
	end
	return " "
end

function _GF_RGBAToInt(R, G, B, A)
	A = A or 255
	return ((R&0x0ff)<<0x00)|((G&0x0ff)<<0x08)|((B&0x0ff)<<0x10)|((A&0x0ff)<<0x18)
end

function _GF_v2_from_v3(_pos)
	return v2(_pos.x,_pos.y)
end




