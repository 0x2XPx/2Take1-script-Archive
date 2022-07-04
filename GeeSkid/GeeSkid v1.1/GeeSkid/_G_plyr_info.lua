-- GeeSkid v1.01
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

function _GF_gta_map_do(_I,_hotkey)
	local _pid = _GT_gta_map.plyr_list[_I][1]
	_GT_gta_map.plyr_list[_I][2] = true
	if player.is_player_in_any_vehicle(_pid) and (_GT_veh_esp_table.png_true[entity.get_entity_model_hash(player.get_player_vehicle(_pid))] or _GT_veh_esp_table.png_true[_GF_class_name(player.get_player_vehicle(_pid))]) then
		_GT_gta_map.plyr_list[_I][6] = true
		if _GT_veh_esp_table.png_true[entity.get_entity_model_hash(player.get_player_vehicle(_pid))] then
			_GT_gta_map.plyr_list[_I][7] = _GT_veh_esp_table.png_int[entity.get_entity_model_hash(player.get_player_vehicle(_pid))]
			if _GF_model_name(player.get_player_vehicle(_pid)) == "Buzzard Attack Chopper" then
				_GT_gta_map.plyr_list[_I][4] = _GF_scriptdraw_heading_rot(_GT_gta_map.helo_rot)
			elseif _GT_veh_esp_table.png_rot_true[entity.get_entity_model_hash(player.get_player_vehicle(_pid))] then
				_GT_gta_map.plyr_list[_I][4] = _GF_scriptdraw_heading_rot(player.get_player_heading(_pid))
			else
				_GT_gta_map.plyr_list[_I][4] = 0
			end
		else
			_GT_gta_map.plyr_list[_I][7] = _GT_veh_esp_table.png_int[_GF_class_name(player.get_player_vehicle(_pid))]
			if _GF_class_name(player.get_player_vehicle(_pid)) == "Helicopters" then
				_GT_gta_map.plyr_list[_I][4] = _GF_scriptdraw_heading_rot(_GT_gta_map.helo_rot)
			elseif _GT_veh_esp_table.png_rot_true[_GF_class_name(player.get_player_vehicle(_pid))] then
				_GT_gta_map.plyr_list[_I][4] = _GF_scriptdraw_heading_rot(player.get_player_heading(_pid))
			else
				_GT_gta_map.plyr_list[_I][4] = 0
			end
		end
		if _GF_class_name(player.get_player_vehicle(_pid)) == "Planes" then
			_GT_gta_map.plyr_list[_I][9] = _GF_scriptdraw_heading_rot(player.get_player_heading(_pid)+180)
			_GT_gta_map.plyr_list[_I][10] = _GF_scriptdraw_heading_rot(player.get_player_heading(_pid))
		else
			_GT_gta_map.plyr_list[_I][9] = 3.125
			_GT_gta_map.plyr_list[_I][10] = 0
		end
	else
		_GT_gta_map.plyr_list[_I][6] = false
		_GT_gta_map.plyr_list[_I][4] = _GF_scriptdraw_heading_rot(player.get_player_heading(_pid))
	end
	_GT_gta_map.plyr_list[_I][3] = _GF_map_sprite_pos_do(player.get_player_coords(_pid))
	_GT_gta_map.plyr_list[_I][5] = _GF_org_color_int(_pid)+2
end

function _GF_v2_from_v3(_pos)
	return v2(_pos.x,_pos.y)
end

function _GF_scriptdraw_heading_rot(_heading)
	if _heading < 0 then
		return (360-(360-(_heading*-1))+1)/360*6.25
	end
	return (360-_heading+1)/360*6.25
end

function _G_plyrs_aim_protex_do(parent)
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------Show player aiming at me
	-------------------------------------------------------------------------------------------------
	_GT_aim_protex_main = {}
	_GT_aim_protex_main.AimAtMe = {}
	function _GT_aim_protex_main.AimDefault(i)
		_GT_aim_protex_main.AimAtMe[i] = {false,"",0,""}
	end
	for i=1,32 do
		 _GT_aim_protex_main.AimDefault(i)
	end
	
	_GT_aim_protex_main.weap_tables = {
	_GT_weap_hash_str.melee,
	_GT_weap_hash_str.handgun,
	_GT_weap_hash_str.submachine,
	_GT_weap_hash_str.shotgun,
	_GT_weap_hash_str.assault,
	_GT_weap_hash_str.machinegun,
	_GT_weap_hash_str.sniper,
	_GT_weap_hash_str.heavy,
	_GT_weap_hash_str.throwable,
	_GT_weap_hash_str.misc
	}
	
	_GT_aim_protex_main.weap_table_all={}
	
	_GT_aim_protex_main.weap_str = {}
	function _GT_aim_protex_main.record_weap_hash_str()
		for t=1,#_GT_aim_protex_main.weap_tables do
			local wep_table=_GT_aim_protex_main.weap_tables[t]
			for w=1,#wep_table do
				_GT_aim_protex_main.weap_table_all[#_GT_aim_protex_main.weap_table_all+1]=wep_table[w]
			end
		end
		-- for t=1,#_table do
			-- local wep_table=_table[t]
			-- for w=1,#wep_table do
				-- _GT_aim_protex_main.weap_str[wep_table[w][1]]=wep_table[w][2]
			-- end
		-- end
		for t=1,#_GT_aim_protex_main.weap_table_all do
			_GT_aim_protex_main.weap_str[_GT_aim_protex_main.weap_table_all[t][1]]=_GT_aim_protex_main.weap_table_all[t][2]
		end
	end
	_GT_aim_protex_main.record_weap_hash_str()

	function _GT_aim_protex_main.get_weap_name(pid)
		local weap = _GT_aim_protex_main.weap_str[ped.get_current_ped_weapon(player.get_player_ped(pid))]
		if weap == nil then
			return "Weapon"
		end
		return weap
	end
	
	-- _GT_aim_protex_main.net_hook=hook.register_net_event_hook(function(pid,target,prmtr)
		-- if target == player.player_id() and (prmtr == 18 or prmtr == 17) and player.is_player_in_any_vehicle(player.player_id()) and player.is_player_in_any_vehicle(pid) then
			-- _GT_aim_protex_main.AimAtMe[pid+1] = {true,_GF_model_name(player.get_player_vehicle(pid)),utils.time_ms() + 1000,_GT_aim_protex_main._G_plyr_aim_a.value}
		-- end
			
			-- -- if target == player.player_id() and player.is_player_in_any_vehicle(player.player_id()) and player.is_player_in_any_vehicle(pid) then
				-- -- print("NETWORK PID: ".._GF_plyr_name(pid).."  Target: ".._GF_plyr_name(target).." Prmtr: "..prmtr)
			-- -- end
	-- end)
	
	_GT_aim_protex_main._G_aim_notif=menu.add_feature("Show name of player aiming at me", "toggle", parent.id, function(feat)
		_GF_plyr_aim_overlay_hide(false)
		local y_val, y_offset,text
		local r,g,b,s,f,x
		local text = ""
		local function should_default(i)
			if i-1 == player.player_id() or not _GF_valid_pid(i-1) then
				return true
			elseif _GT_aim_protex_main.AimAtMe[i][1] and _GT_aim_protex_main.AimAtMe[i][3] < utils.time_ms() then
				return true
			end
			return false
		end
		while feat.on do
			system.yield(5)
			for i=1,32 do
				if should_default(i) then
					_GT_aim_protex_main.AimDefault(i)
				elseif _GF_aim_at_me(i-1) then
					_GT_aim_protex_main.AimAtMe[i] = {true,_GT_aim_protex_main.get_weap_name(i-1),utils.time_ms() + (_GT_aim_protex_main._G_plyr_time.value*1000),_GF_plyr_name(i-1)}
				end
			end
			_GT_aim_protex_main.show_overlay(_GT_aim_protex_main.AimAtMe)
		end
		_GF_plyr_aim_overlay_hide(true)
	end)_GT_aim_protex_main._G_aim_notif.on=true
	
	function _GT_aim_protex_main.show_overlay(_table)
		local y_val,y_offset = _GT_aim_protex_main._G_plyr_aim_y.value,_GT_aim_protex_main._G_plyr_aim_spc.value
		local r,g,b = _GT_aim_protex_main._G_plyr_aim_cr.value,_GT_aim_protex_main._G_plyr_aim_cg.value,_GT_aim_protex_main._G_plyr_aim_cb.value
		local s,f,x = _GT_aim_protex_main._G_plyr_aim_s.value/300,_GT_aim_protex_main._G_plyr_aim_f.value,_GT_aim_protex_main._G_plyr_aim_x.value/300
		local alpha,a = _GT_aim_protex_main._G_plyr_aim_a.value
		for i=1,#_table do
			if _table[i][1] and _table[i][3] > utils.time_ms() then
				a = (_table[i][3]-utils.time_ms()) /1000/(_GT_aim_protex_main._G_plyr_time.value+1)
				if a > .5 then a = _GT_aim_protex_main._G_plyr_aim_a.value else a = math.floor(a*1.5*alpha) end
				_GF_overlay(_table[i][4].." - ".._table[i][2],r,g,b,a,s,f,x,y_val/300)
				y_val = y_val + y_offset
			end
		end
	end
	
	_GT_aim_protex_main._G_aim_notif_test = menu.add_feature("Player aim overlay test?", "action", parent.id, function()
		_GT_aim_protex_main._G_aim_notif_test.hidden=true
		local _table = {}
		for i=1, 3 do
			_table[i] = {true,"Weapon "..i,utils.time_ms() + (_GT_aim_protex_main._G_plyr_time.value*1000),_GT_aim_protex_main._G_plyr_aim_a.value,"Player "..i}
		end
		local time = utils.time_ms() + (_GT_aim_protex_main._G_plyr_time.value*1000)
		while time > utils.time_ms() do
			system.yield(5)
			_GT_aim_protex_main.show_overlay(_table)
		end
		if _GT_aim_protex_main._G_aim_notif.on then
			_GT_aim_protex_main._G_aim_notif_test.hidden=false
		end
	end)

	function _GF_aim_at_me(_pid)
		if _GF_valid_pid(_pid) then
			if player.get_entity_player_is_aiming_at(_pid) == player.get_player_ped(player.player_id()) then
				return true
			end
		end
		return false
	end

	_GT_aim_protex_main._G_plyr_time = menu.add_feature("Time on screen", "autoaction_value_f", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_time.max,_GT_aim_protex_main._G_plyr_time.min,_GT_aim_protex_main._G_plyr_time.mod=5,1,.5
	_GT_aim_protex_main._G_plyr_time.value=2.5
	
	_GT_aim_protex_main._G_plyr_aim_x = menu.add_feature("X Pos", "autoaction_value_i", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_aim_x.max,_GT_aim_protex_main._G_plyr_aim_x.min,_GT_aim_protex_main._G_plyr_aim_x.mod=300,0,1

	_GT_aim_protex_main._G_plyr_aim_y = menu.add_feature("Y Pos", "autoaction_value_i", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_aim_y.max,_GT_aim_protex_main._G_plyr_aim_y.min,_GT_aim_protex_main._G_plyr_aim_y.mod=300,0,1

	_GT_aim_protex_main._G_plyr_aim_spc = menu.add_feature("Spacing", "autoaction_value_i", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_aim_spc.max,_GT_aim_protex_main._G_plyr_aim_spc.min,_GT_aim_protex_main._G_plyr_aim_spc.mod=69,1,1

	_GT_aim_protex_main._G_plyr_aim_s = menu.add_feature("Scale", "autoaction_value_i", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_aim_s.max,_GT_aim_protex_main._G_plyr_aim_s.min,_GT_aim_protex_main._G_plyr_aim_s.mod=300,75,1

	_GT_aim_protex_main._G_plyr_aim_f = menu.add_feature("Font", "autoaction_value_i", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_aim_f.max,_GT_aim_protex_main._G_plyr_aim_f.min,_GT_aim_protex_main._G_plyr_aim_f.mod=9,0,1

	_GT_aim_protex_main._G_plyr_aim_cr = menu.add_feature("Red", "autoaction_value_i", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_aim_cr.max,_GT_aim_protex_main._G_plyr_aim_cr.min,_GT_aim_protex_main._G_plyr_aim_cr.mod=255,0,15

	_GT_aim_protex_main._G_plyr_aim_cg = menu.add_feature("Green", "autoaction_value_i", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_aim_cg.max,_GT_aim_protex_main._G_plyr_aim_cg.min,_GT_aim_protex_main._G_plyr_aim_cg.mod=255,0,15

	_GT_aim_protex_main._G_plyr_aim_cb = menu.add_feature("Blue", "autoaction_value_i", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_aim_cb.max,_GT_aim_protex_main._G_plyr_aim_cb.min,_GT_aim_protex_main._G_plyr_aim_cb.mod=255,0,15

	_GT_aim_protex_main._G_plyr_aim_a = menu.add_feature("Alpha", "autoaction_value_i", parent.id, function()
	end) _GT_aim_protex_main._G_plyr_aim_a.max,_GT_aim_protex_main._G_plyr_aim_a.min,_GT_aim_protex_main._G_plyr_aim_a.mod=255,30,15

	function _GF_plyr_aim_overlay_hide(_bool)
	_GT_aim_protex_main._G_plyr_aim_spc.hidden=_bool
	_GT_aim_protex_main._G_aim_notif_test.hidden=_bool
	_GT_aim_protex_main._G_plyr_aim_x.hidden=_bool
	_GT_aim_protex_main._G_plyr_aim_y.hidden=_bool
	_GT_aim_protex_main._G_plyr_aim_s.hidden=_bool
	_GT_aim_protex_main._G_plyr_aim_f.hidden=_bool
	_GT_aim_protex_main._G_plyr_aim_cr.hidden=_bool
	_GT_aim_protex_main._G_plyr_aim_cg.hidden=_bool
	_GT_aim_protex_main._G_plyr_aim_cb.hidden=_bool
	_GT_aim_protex_main._G_plyr_aim_a.hidden=_bool
	end
	_GF_plyr_aim_overlay_hide(true)

	function _GF_plyr_aim_overlay_recc()
	_GT_aim_protex_main._G_plyr_aim_spc.value=18
	_GT_aim_protex_main._G_plyr_aim_x.value=229
	_GT_aim_protex_main._G_plyr_aim_y.value=23
	_GT_aim_protex_main._G_plyr_aim_s.value=277
	_GT_aim_protex_main._G_plyr_aim_f.value=9
	_GT_aim_protex_main._G_plyr_aim_cr.value=255
	_GT_aim_protex_main._G_plyr_aim_cg.value=0
	_GT_aim_protex_main._G_plyr_aim_cb.value=0
	_GT_aim_protex_main._G_plyr_aim_a.value=255
	end
	_GF_plyr_aim_overlay_recc()
end

function _G_plyrs_overlay_do(parent)
-------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------Show player list
-------------------------------------------------------------------------------------------------
_G_plyrs_overlay_main = {}
_G_plyrs_overlay_main.sort_parent = menu.add_feature("Sort list", "parent", parent.id)
_G_plyrs_overlay_main.show_info_parent = menu.add_feature("Select info", "parent", parent.id)
_G_plyrs_overlay_main.display_parent = menu.add_feature("Display options", "parent", parent.id)
_G_plyrs_overlay_main.sort_parent_left = menu.add_feature("Order of info on left", "parent", _G_plyrs_overlay_main.sort_parent.id)
_G_plyrs_overlay_main.sort_parent_right = menu.add_feature("Order of info on right", "parent", _G_plyrs_overlay_main.sort_parent.id)
_G_plyrs_overlay_main.text_dots = "..."
_G_plyrs_overlay_main.popo_rb=false
_G_plyrs_overlay_main.sort_bool=false

_G_plyrs_overlay_main.alpha_str = {"Fade"}
for i=1,42 do
	_G_plyrs_overlay_main.alpha_str[#_G_plyrs_overlay_main.alpha_str+1]=(50+((i-1)*5))
end

_G_plyrs_overlay_main.dist_table = {}
_G_plyrs_overlay_main.plyr_list_dist_feat=menu.add_feature("Show player dist HIDDEN", "toggle", parent.id, function(f)
	local my_pos = player.get_player_coords(player.player_id())
	local time = utils.time_ms()
	local check = false
	while f.on do
		system.yield(50)
		if time < utils.time_ms() and not _GF_in_grid(player.get_player_coords(player.player_id()),my_pos,2) then
			my_pos = player.get_player_coords(player.player_id())
			time = utils.time_ms()+500
			check = true
		end
		for i=1,32 do
			if _GF_valid_pid(i-1) then
				if _G_plyrs_overlay_main.dist_table[i] == nil or _G_plyrs_overlay_main.dist_table[i][1] == 10000 then
					_G_plyrs_overlay_main.dist_table[i]={_GF_dist_me_pid(i-1),player.get_player_coords(i-1),i-1}
				elseif i-1 == player.player_id() then
					_G_plyrs_overlay_main.dist_table[i]={0,player.get_player_coords(i-1),i-1}
				elseif check or not _GF_in_grid(player.get_player_coords(i-1),_G_plyrs_overlay_main.dist_table[i][2],2) then
					_G_plyrs_overlay_main.dist_table[i]={_GF_dist_me_pid(i-1),player.get_player_coords(i-1),i-1}
					system.yield(3)
				end
				system.yield(3)
			else
				_G_plyrs_overlay_main.dist_table[i]={10000,v3(0,0,0),i-1}
				system.yield(3)
			end
		end
		check = false
	end
end)
_G_plyrs_overlay_main.plyr_list_dist_feat.hidden=true
_G_plyrs_overlay_main.plyr_list_dist_feat.on=true

_G_plyrs_overlay_main.plyr_info_table = {}
function _G_plyrs_overlay_main.table_default(i)
	_G_plyrs_overlay_main.plyr_info_table[i] = {
	false, 	--do it
	0,		-- PID
	"",		-- name
	0,		--distance
	0,		-- kd
	0,		-- money
	0,		-- rank
	0,		-- time in session
	0,		-- host priority
	-1,		-- color
	false,	-- same color
	false,	-- 12 friend
	false,	-- 13 interior
	false,	-- 14 invisible
	}
end

_G_plyrs_overlay_main.blink = {
false, -- otr
false, -- dead
false, -- mod spec
false, -- invis
}

_G_plyrs_overlay_main.team_rgb = {
{255,255,255},-- table 1  == -1  -- white   gta reports org color as -1 when not in org/mc and momentarily when in org/mc
{247,159,123},-- table 2  ==  0  -- orange
{226,134,187},-- table 3  ==  1  -- pink
{239,238,151},-- table 4  ==  2  -- yellow
{113,169,175},-- table 5  ==  3  -- teal blue/green
{160,140,193},-- table 6  ==  4  -- purple
{141,206,167},-- table 7  ==  5  -- light green
{181,214,234},-- table 8  ==  6  -- light blue
{178,144,132},-- table 9  ==  7  -- brown
{0,  132,114},-- table 10 ==  8  -- dark green
{216,85,117},-- table 11 ==  9  -- hot pink
{255,255,255}-- table 12 == 10  -- I havent seen this as an org/mc color but without this slot here i will get an error
}

function _G_plyrs_overlay_main.plyr_rgb(_pidT,_val)
	if _GF_is_a_num(_pidT) and _pidT > 0 then
		if _val == "r" then
			return _G_plyrs_overlay_main.team_rgb[_GT_plyr_info.color[_pidT]+2][1]
		elseif _val == "g" then
			return _G_plyrs_overlay_main.team_rgb[_GT_plyr_info.color[_pidT]+2][2]
		elseif _val == "b" then
			return _G_plyrs_overlay_main.team_rgb[_GT_plyr_info.color[_pidT]+2][3]
		end
		return _G_plyrs_overlay_main.team_rgb[_GT_plyr_info.color[_pidT]+2][1],_G_plyrs_overlay_main.team_rgb[_GT_plyr_info.color[_pidT]+2][2],_G_plyrs_overlay_main.team_rgb[_GT_plyr_info.color[_pidT]+2][3]
	end
	if _val ~= nil then
		return 255
	end
	return 255,255,255
end

function _GF_police_colors(_r,_g,_b,_wntd)
	if _wntd and _G_plyrs_overlay_main.plyr_sort_wanted.on then
		if _G_plyrs_overlay_main.popo_rb == true then
			return	235,36,39
		elseif _G_plyrs_overlay_main.popo_rb == false then
			return 38,136,234
		end
	end
	return _r,_g,_b
end

function _G_plyrs_overlay_main.plyr_info_do(pidT,_pid,dead,frnd,_int,_wntd,_otr)
	local _table = _G_plyrs_overlay_main.plyr_sort_left.list
	local plyr_info = ""
	local host = player.is_player_host(_pid)
	local s_host = (script.get_host_of_this_script()==_pid)
	local its_me = (_pid == player.player_id())
	--local count,brckt1,brckt2 = 1
	if _GT_plyr_info.typing[pidT]==true then
		plyr_info=plyr_info.._G_plyrs_overlay_main.text_dots
	end
	-- local function brckt(_val)
		-- if _GF_is_even_num(_val) then
			-- return " {","}"
		-- end
		-- return " [","]"
	-- end
		-- just here for testing
		 --plyr_info=plyr_info.."   {{"..tostring(interior.get_interior_from_entity(player.get_player_ped(_pid))).."}}   "
		-- plyr_info=plyr_info.."   {{"..tostring(ui.get_blip_from_entity(player.get_player_ped(_pid))).."}}   "
	for i=1,9 do
		--brckt1,brckt2 = brckt(count)
		if _table[i] == 1 and _GT_plyr_info.pause[pidT]==true then
			plyr_info=plyr_info.." [".."Pause".."]"
			--count = count + 1
		elseif _table[i] == 2 and _GF_mission_active(_pid) then
			plyr_info=plyr_info.." [".."On Mission".."]"
			--count = count + 1
		elseif _table[i] == 3 and _int then
			plyr_info=plyr_info.." [".._GT_plyr_info.interior_str[pidT].."]"
			--count = count + 1
		elseif _table[i] == 4 and _wntd and _G_plyrs_overlay_main.plyr_sort_wanted.on then
			plyr_info=plyr_info.." ["..player.get_player_wanted_level(_pid).." STAR".."]"
			--count = count + 1
		elseif _table[i] == 5 then
			if _GT_plyr_info.loading[pidT] then 
				plyr_info=plyr_info.." [".."LOADING".."]"
				--count = count + 1
			elseif dead or player.get_player_max_health(_pid) == 0.0 then
				if player.get_player_max_health(_pid) == 0.0 then
					plyr_info=plyr_info.." [".."UN-DEAD".."]"
				else
					plyr_info=plyr_info.." [".."DEAD".."]"
					--count = count + 1
				end
			end
		elseif _table[i] == 6 then
			if host or s_host or frnd or its_me then
				plyr_info=plyr_info.." [".." "
				if host then plyr_info=plyr_info.."H" end
				if s_host then plyr_info=plyr_info.."S" end
				if frnd then plyr_info=plyr_info.."F" end
				if its_me then plyr_info=plyr_info.."Y" end
				plyr_info=plyr_info.." ".."]"
				--count = count + 1
			end
		elseif _table[i] == 7 and _otr and not _GT_plyr_info.loading[pidT] then
			plyr_info=plyr_info.." [".."OTR ".._GF_time_M_S_str(_GT_plyr_info.otr_time[pidT]).."]"
			--count = count + 1
		elseif _table[i] == 8 and _G_plyrs_overlay_main.plyr_sort_tis.on then
			plyr_info=plyr_info.." [".._GF_time_M_S_str(_GT_plyr_info.join_time[pidT]).."]"
			--count = count + 1
		elseif _table[i] == 9 and _G_plyrs_overlay_main.plyr_sort_rank.on then
			plyr_info=plyr_info.." [".._GT_plyr_info.rank[pidT].."]"
			--count = count + 1
		end


	end
	return plyr_info
end
----------------------------------------------------------------------------------------------sort left
_G_plyrs_overlay_main.plyr_sort_left = {}
_G_plyrs_overlay_main.plyr_sort_left.list = {1,2,3,4,5,6,7,8,9}
_G_plyrs_overlay_main.plyr_sort_left.str = {
"Pause",			--1
"On Mission",		--2
"Interior",			--3
"Wanted",			--4
"Loading/Dead",		--5
"Host/Friend",		--6
"Off the radar",	--7
"Time in session",	--8
"Rank"}				--9

function _G_plyrs_overlay_main.plyr_sort_left_do(_feat,_bool)
	local msg,_value = ""
	local _val_table = {}
	local _feat_table = {}
	for i=1,9 do
		if _G_plyrs_overlay_main.plyr_sort_left[i].name == _feat.name then
			_value = _feat.value
			_feat_table[i]=true
			break
		end
	end
	for i=1,9 do
		_val_table[i] = _G_plyrs_overlay_main.plyr_sort_left[i].value
	end
	for feat=1,9 do
		if not _feat_table[feat] then
			for i=1,9 do
				if not _feat_table[i] then
					if _G_plyrs_overlay_main.plyr_sort_left[i].value == _value then
						for ii=0,8 do
							if not _GF_table_has(_val_table,ii) then
								_G_plyrs_overlay_main.plyr_sort_left[i].value = ii
								_val_table[#_val_table+1] = ii
								_feat_table[i]=true
								break
							end
						end
					end
				end
			end
		end
	end
	for i=1,9 do		
		_G_plyrs_overlay_main.plyr_sort_left.list[i] = _G_plyrs_overlay_main.plyr_sort_left[i].value+1
		msg = msg..i.." - ".._G_plyrs_overlay_main.plyr_sort_left.str[_G_plyrs_overlay_main.plyr_sort_left[i].value+1].."\n"
	end
	if _bool then
		menu.notify("Player info overlay left sorted to:\n"..msg,_G_GeeVer,5)
	end
end

for i=1,9 do 
	_G_plyrs_overlay_main.plyr_sort_left[i]=menu.add_feature("Left info slot #"..i, "action_value_str", _G_plyrs_overlay_main.sort_parent_left.id,function(f)
		_G_plyrs_overlay_main.plyr_sort_left_do(_G_plyrs_overlay_main.plyr_sort_left[i],true)
	end)
	_G_plyrs_overlay_main.plyr_sort_left[i]:set_str_data(_G_plyrs_overlay_main.plyr_sort_left.str)
	_G_plyrs_overlay_main.plyr_sort_left[i].value = i-1
end

_G_plyrs_overlay_main.plyr_sort_left.default_feat=menu.add_feature("Left info slots default", "action", _G_plyrs_overlay_main.sort_parent_left.id,function(f)
	_G_plyrs_overlay_main.plyr_sort_left.list = {1,2,3,4,5,6,7,8,9}
	local msg = ""
	for i=1,9 do
		_G_plyrs_overlay_main.plyr_sort_left[i].value = i-1
		msg = msg..i.." - ".._G_plyrs_overlay_main.plyr_sort_left.str[_G_plyrs_overlay_main.plyr_sort_left[i].value+1].."\n"
	end
	menu.notify("Player info overlay left sorted to:\n"..msg,_G_GeeVer,5)
end)
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------sort right
_G_plyrs_overlay_main.plyr_sort_right = {}
_G_plyrs_overlay_main.plyr_sort_right.list = {1,2,3,4,5}
_G_plyrs_overlay_main.plyr_sort_right.str = {
"Name",
"Money",
"KD",
"Vehicle",
"Speed"
}

function _G_plyrs_overlay_main.plyr_sort_right_do(_feat,_bool)
	local msg,_value = ""
	local _val_table = {}
	local _feat_table = {}
	for i=1,5 do
		if _G_plyrs_overlay_main.plyr_sort_right[i].name == _feat.name then
			_value = _feat.value
			_feat_table[i]=true
			break
		end
	end
	for i=1,5 do
		_val_table[i] = _G_plyrs_overlay_main.plyr_sort_right[i].value
	end
	for feat=1,5 do
		if not _feat_table[feat] then
			for i=1,5 do
				if not _feat_table[i] then
					if _G_plyrs_overlay_main.plyr_sort_right[i].value == _value then
						for ii=0,4 do
							if not _GF_table_has(_val_table,ii) then
								_G_plyrs_overlay_main.plyr_sort_right[i].value = ii
								_val_table[#_val_table+1] = ii
								_feat_table[i]=true
								break
							end
						end
					end
				end
			end
		end
	end
	for i=1,5 do		
		_G_plyrs_overlay_main.plyr_sort_right.list[i] = _G_plyrs_overlay_main.plyr_sort_right[i].value+1
		msg = msg..i.." - ".._G_plyrs_overlay_main.plyr_sort_right.str[_G_plyrs_overlay_main.plyr_sort_right[i].value+1].."\n"
	end
	if _bool then
		menu.notify("Player info overlay right sorted to:\n"..msg,_G_GeeVer,5)
	end
end

for i=1,5 do 
	_G_plyrs_overlay_main.plyr_sort_right[i]=menu.add_feature("Right info slot #"..i, "action_value_str", _G_plyrs_overlay_main.sort_parent_right.id,function(f)
		_G_plyrs_overlay_main.plyr_sort_right_do(_G_plyrs_overlay_main.plyr_sort_right[i],true)
	end)
	_G_plyrs_overlay_main.plyr_sort_right[i]:set_str_data(_G_plyrs_overlay_main.plyr_sort_right.str)
	_G_plyrs_overlay_main.plyr_sort_right[i].value = i-1
end

_G_plyrs_overlay_main.plyr_sort_right.default_feat=menu.add_feature("Right info slots default", "action", _G_plyrs_overlay_main.sort_parent_right.id,function(f)
	_G_plyrs_overlay_main.plyr_sort_right.list = {1,2,3,4,5}
	local msg = ""
	for i=1,5 do
		_G_plyrs_overlay_main.plyr_sort_right[i].value = i-1
		msg = msg..i.." - ".._G_plyrs_overlay_main.plyr_sort_right.str[_G_plyrs_overlay_main.plyr_sort_right[i].value+1].."\n"
	end
	menu.notify("Player info overlay right sorted to:\n"..msg,_G_GeeVer,5)
end)
----------------------------------------------------------------------------------------------
function _G_plyrs_overlay_main.rgb_do(mod_spec,frnd,dead,otr,r,g,b,popo,_wntd,_invis)
	local _r,_g,_b = r,g,b
	if _invis and _G_plyrs_overlay_main.blink[4] then
		_r,_g,_b = 255,192,203
	elseif mod_spec and _G_plyrs_overlay_main.blink[3] then
		_r,_g,_b =  255,0,0
	elseif frnd and not dead and not otr then
		_r,_g,_b =  255,255,0
	elseif dead and _G_plyrs_overlay_main.blink[2] then
		_r,_g,_b =  0,0,0
	elseif otr and _G_plyrs_overlay_main.blink[1] then
		_r,_g,_b =  0,255,0
	end
	if popo then _r,_g,_b = _GF_police_colors(_r,_g,_b,_wntd) end
	return _r,_g,_b
end

function _G_plyrs_overlay_main.god_mod_do(_pid,_int,_invis)
	local god_mod_text=""
	local gm_table = {}
	if not _int and _GT_plyr_info.plyr_god[_pid+1] then
		gm_table[#gm_table+1]="G"
	end
	if not _int and (_GT_plyr_info.in_veh[_pid+1] and _GT_plyr_info.veh_god[_pid+1]) then
		gm_table[#gm_table+1]="VG"
	end
	if _GT_plyr_info.modder[_pid+1] then
		gm_table[#gm_table+1]="M"
	end
	if not _int and _invis then
		gm_table[#gm_table+1]="IV"
	end
	if #gm_table > 0 then
		god_mod_text=god_mod_text.."["
		for i=1,#gm_table do
			god_mod_text=god_mod_text..gm_table[i]
			if gm_table[i+1] == "IV" then
				god_mod_text=god_mod_text.." "
			end
		end
		god_mod_text=god_mod_text.."]"
	end
	
	-- local plyr_g = _GT_plyr_info.plyr_god[_pid+1]
	-- local veh_g = (_GT_plyr_info.in_veh[_pid+1] and _GT_plyr_info.veh_god[_pid+1])
	-- local plyr_m = _GT_plyr_info.modder[_pid+1]
	-- if not _int and (plyr_g or veh_g) then
		-- god_mod_text=god_mod_text.."["
		-- if plyr_m then god_mod_text=god_mod_text.."M" end
		-- if plyr_g then god_mod_text=god_mod_text.."G" end
		-- if veh_g then god_mod_text=god_mod_text.."V" end
		-- god_mod_text=god_mod_text.."]"
	-- elseif plyr_m then god_mod_text=god_mod_text.."[M]"
	-- end
	return god_mod_text
end

function _G_plyrs_overlay_main.name_do(_pid,pidT,dead) 
	local name,mod_spec ="",false
	local count,brckt1,brckt2 = 1
	local r,g,b = _G_plyrs_overlay_main.plyr_rgb(pidT)
	local _table = _G_plyrs_overlay_main.plyr_sort_right.list
	-- local function brckt(_val)
		-- if _GF_is_even_num(_val) then
			-- return " {","}"
		-- end
		-- return " [","]"
	-- end
	for i=1,5 do
		--brckt1,brckt2 = brckt(count)
		if _table[i] == 1 then name=name.." ".._GT_plyr_info.name[pidT] count = count + 1 end
		if _table[i] == 2 and _G_plyrs_overlay_main.plyr_sort_money.on then name=name.." [".._GF_plyr_money_str(_pid).."]" count = count + 1 end
		if _table[i] == 3 and _G_plyrs_overlay_main.plyr_sort_kd.on then name=name.." [".."KD ".._GT_plyr_info.kd[pidT].."]" count = count + 1 end
		if _table[i] == 4 and _GT_plyr_info.in_veh[pidT] and _G_plyrs_overlay_main.plyr_sort_veh.on then name=name.." [".._GF_model_name(_GT_plyr_info.veh[pidT]).."]" count = count + 1 end
		if _table[i] == 5 then
			if (_G_plyrs_overlay_main.plyr_sort_speed_veh.on and _GT_plyr_info.in_veh[pidT]) or (_G_plyrs_overlay_main.plyr_sort_speed_ped.on and not _GT_plyr_info.in_veh[pidT]) then 
				if _G_plyrs_overlay_main.plyr_sort_speed_type.value == 0 and _GT_plyr_info.plyr_speed_pos_mph[pidT] > _G_plyrs_overlay_main.plyr_sort_speed_above.value then 
					if _GT_plyr_info.plyr_speed_pos_mph[pidT] < 5 then
						name=name.." [".._GF_1_decimal(_GT_plyr_info.plyr_speed_pos_mph[pidT]).." MPH".."]"
					else
						name=name.." ["..math.floor(_GT_plyr_info.plyr_speed_pos_mph[pidT]).." MPH".."]"
					end
					count = count + 1
				elseif _G_plyrs_overlay_main.plyr_sort_speed_type.value == 1 and _GT_plyr_info.plyr_speed_pos_kph[pidT] > _G_plyrs_overlay_main.plyr_sort_speed_above.value then
					if _GT_plyr_info.plyr_speed_pos_kph[pidT] < 5 then
						name=name.." [".._GF_1_decimal(_GT_plyr_info.plyr_speed_pos_kph[pidT]).." KPH".."]"
					else
						name=name.." ["..math.floor(_GT_plyr_info.plyr_speed_pos_kph[pidT]).." KPH".."]"
					end
					count = count + 1
				end
			end
		end
	end
	if player.is_player_spectating(_pid) then
		local spctee =  network.get_player_player_is_spectating(_pid)
		if spctee ~= nil and _GT_plyr_info.name[spctee+1] ~= nil then
			if not _GT_plyr_info.interior[pidT] and not dead then mod_spec = true name=name.." - MODDED SPECTATE: "
			else name=name.." - Specating: " end
			name=name.._GT_plyr_info.name[spctee+1]
		end
	end
	if _GT_plyr_info.typing[pidT]==true then name=name.._G_plyrs_overlay_main.text_dots end
	return name,r,g,b,mod_spec
end



_G_plyrs_overlay_main.plyr_list_feat=menu.add_feature("Show player list", "toggle", parent.id, function(f)
	while not _G_GS_has_loaded do
		system.yield(500)
	end
	_G_plyrs_overlay_main.plyr_sort_left_do(_G_plyrs_overlay_main.plyr_sort_left[1],false)
	_GF_nearby_plyr_overlay_hide(_GF_opp_bool(f.on))
	_G_plyrs_overlay_main.plyr_list_record_feat.on=f.on
	_G_plyrs_overlay_main.popo_rb_feat.on=f.on
	_G_plyrs_overlay_main.blink_do.on=f.on
	local max_count,count,y_val, y_offset,x_pos,y_once,y_off_once,more_players_once,dist_offset,god_offset
	local r,g,b,plyr_info_offset,plyr_info,_dead,_otr,_frnd,mod_spec,god_mod_text,name,_pid,_pidT,_int,_table
	local alpha_switch,alpha_calc,alpha_fade,alpha,alpha_speed,_invis = true,100,100,255
	while f.on do
		system.yield(5)
		if _G_plyrs_overlay_main.plyr_sort_int_alpha.value == 0 then
			
			if alpha_switch then 
				alpha_calc = alpha_calc *(1.001+(_G_plyrs_overlay_main.plyr_sort_int_alpha_speed.value/1000))
				if alpha_calc >= 220 then alpha_switch = false end
			else
				alpha_calc = alpha_calc *(.999-(_G_plyrs_overlay_main.plyr_sort_int_alpha_speed.value/1000))
				if alpha_calc <= 150 then alpha_switch = true end
			end
			alpha_fade=math.floor(alpha_calc)
		else
			alpha_fade = _G_plyrs_overlay_main.alpha_str[_G_plyrs_overlay_main.plyr_sort_int_alpha.value+1]
		end
		_table = {}
		for i=1,32 do
			if _G_plyrs_overlay_main.plyr_info_table[i] ~= nil and _G_plyrs_overlay_main.plyr_info_table[i][1] and player.is_player_valid(_G_plyrs_overlay_main.plyr_info_table[i][2]) and player.get_player_name(_G_plyrs_overlay_main.plyr_info_table[i][2]) == _G_plyrs_overlay_main.plyr_info_table[i][3] then
				_table[#_table+1] = _G_plyrs_overlay_main.plyr_info_table[i]
			end
		end
		if #_table < 1 then
			system.yield(250)
		else
			max_count = _G_plyrs_overlay_main.plyr_sort_max.value
			count = 0
			y_once,y_off_once,more_players_once=false,false,false
			y_val = _G_plyrs_overlay_main.plyr_sort_y.value
			y_offset = _G_plyrs_overlay_main.plyr_sort_space_ver.value
			for i=1,#_table do
				if count < max_count then
					x_pos = _G_plyrs_overlay_main.plyr_sort_x.value
					if _G_plyrs_overlay_main.plyr_sort_column_space.on then
						if (_G_plyrs_overlay_main.plyr_sort_column_type.value == 0 and i > _GF_round_num(max_count/2)) or (_G_plyrs_overlay_main.plyr_sort_column_type.value == 1 and i > _GF_round_num(#_table/2)) then
							x_pos=x_pos+_G_plyrs_overlay_main.plyr_sort_column_space.value
							if not y_once then
								y_val = _G_plyrs_overlay_main.plyr_sort_y.value
								y_once=true
							end
						end
					end
					if i > 1 then
						if y_once and not y_off_once then y_off_once=true else y_val = y_val + y_offset	end
					end
					dist_offset = x_pos-(_G_plyrs_overlay_main.plyr_sort_space_hor.value/4*3)
					plyr_info_offset = dist_offset-.5
					--god_offset = x_pos-((x_pos-dist_offset)*(_G_plyrs_overlay_main.plyr_sort_space_hor.value/25))
					god_offset = x_pos-(_G_plyrs_overlay_main.plyr_sort_space_hor.value/4.69)
					
					_pid,_pidT = _table[i][2],_table[i][2]+1
					_otr = (_GT_plyr_info.otr_time[_pidT] ~= -1)
					_dead = _GT_plyr_info.dead[_pidT]
					_frnd = _table[i][12]
					_int = _GT_plyr_info.interior[_pidT]
					_wntd = (player.get_player_wanted_level(_pid) > 0)
					_invis = _GT_plyr_info.invisible[_pidT]
					if _int then alpha = alpha_fade else alpha = 255 end

					-- on mission,loading,time in session, off the radar etc --
					plyr_info = _G_plyrs_overlay_main.plyr_info_do(_pidT,_pid,_dead,_frnd,_int,_wntd,_otr)
					r,g,b = _G_plyrs_overlay_main.rgb_do(false,_frnd,_dead,_otr,255,255,255,true,_wntd,_invis)
					_GF_overlay_right(plyr_info,r,g,b,alpha,_G_plyrs_overlay_main.plyr_sort_scale.value/300,_G_plyrs_overlay_main.plyr_sort_font.value,plyr_info_offset/300,y_val/300,(plyr_info_offset-20)/300)
					
					-- distance --
					_GF_overlay_left(math.floor(_G_plyrs_overlay_main.dist_table[_pid+1][1]),r,g,b,alpha,_G_plyrs_overlay_main.plyr_sort_scale.value/300,_G_plyrs_overlay_main.plyr_sort_font.value,dist_offset/300,y_val/300)
					
					-- god or mod --
					god_mod_text = _G_plyrs_overlay_main.god_mod_do(_pid,_int,_invis)
					if god_mod_text ~= "" then
						r,g,b = _G_plyrs_overlay_main.rgb_do(false,false,_dead,false,255,0,0,false,false,_invis)
						_GF_overlay(god_mod_text,r,g,b,alpha,_G_plyrs_overlay_main.plyr_sort_scale.value/300,_G_plyrs_overlay_main.plyr_sort_font.value,god_offset/300,y_val/300,(god_offset-20)/300)
					end
					
					-- name,vehicle,kd,money,etc
					name,r,g,b,mod_spec = _G_plyrs_overlay_main.name_do(_pid,_pidT,_dead)
					r,g,b = _G_plyrs_overlay_main.rgb_do(mod_spec,false,_dead,false,r,g,b,false,false,false)
					_GF_overlay_left(name,r,g,b,alpha,_G_plyrs_overlay_main.plyr_sort_scale.value/300,_G_plyrs_overlay_main.plyr_sort_font.value,x_pos/300,y_val/300)
					count=count+1
				elseif count == max_count and count < #_table and not more_players_once then
					y_val = y_val + y_offset
					more_players = tostring(#_table-count)
					if #_table-count > 1 then more_players=more_players.." players hidden"	else more_players=more_players.." player hidden" end
					_GF_overlay_left(more_players,255,255,255,150,_G_plyrs_overlay_main.plyr_sort_scale.value/300,_G_plyrs_overlay_main.plyr_sort_font.value,x_pos/300,y_val/300)
					more_players_once=true
				end
			end
		end
	end
	_GF_nearby_plyr_overlay_hide(_GF_opp_bool(f.on))
	_G_plyrs_overlay_main.plyr_list_record_feat.on=f.on
	_G_plyrs_overlay_main.popo_rb_feat.on=f.on
	_G_plyrs_overlay_main.blink_do.on=f.on
end)

_G_plyrs_overlay_main.plyr_list_record_feat=menu.add_feature("Show player list HIDDEN", "toggle", parent.id, function(f)
	local top_table,other_table,end_table
	local function color_check(mine,theirs)
		if mine > -1 and theirs > -1 and mine == theirs then
			return true
		end
		return false
	end
	local function sort_for_top(_table,_val)
		top_table,other_table,bottom_table,end_table = {},{},{},{}
		for i=1,32 do
			if _G_plyrs_overlay_main.plyr_sort_interior.on and _table[i][13] then
				bottom_table[#bottom_table+1]=_table[i]
			elseif _val == 0 then
				if _table[i][12] then
					top_table[#top_table+1]=_table[i]
				else
					other_table[#other_table+1]=_table[i]
				end
			else
				if _table[i][11] then
					top_table[#top_table+1]=_table[i]
				else
					other_table[#other_table+1]=_table[i]
				end
			end
		end
		if #top_table > 0 then
			if #top_table > 1 then
				_G_plyrs_overlay_main.sort_do(top_table,_G_plyrs_overlay_main.plyr_sort_by_val.value)
			end
			for i=1,#top_table do
				end_table[#end_table+1]=top_table[i]
			end
		end
		if #other_table > 0 then
			if #other_table > 1 then
				_G_plyrs_overlay_main.sort_do(other_table,_G_plyrs_overlay_main.plyr_sort_by_val.value)
			end
			for i=1,#other_table do
				end_table[#end_table+1]=other_table[i]
			end
		end
		if #bottom_table > 0 then
			if #bottom_table > 1 then
				_G_plyrs_overlay_main.sort_do(bottom_table,_G_plyrs_overlay_main.plyr_sort_by_val.value)
			end
			for i=1,#bottom_table do
				end_table[#end_table+1]=bottom_table[i]
			end
		end
		return end_table
	end
	local function sort_for_bottom(_table)
		other_table,bottom_table,end_table = {},{},{}
		for i=1,32 do
			if _table[i][13] then
				bottom_table[#bottom_table+1]=_table[i]
			else
				other_table[#other_table+1]=_table[i]
			end
		end
		if #other_table > 0 then
			if #other_table > 1 then
				_G_plyrs_overlay_main.sort_do(other_table,_G_plyrs_overlay_main.plyr_sort_by_val.value)
			end
			for i=1,#other_table do
				end_table[#end_table+1]=other_table[i]
			end
		end
		if #bottom_table > 0 then
			if #bottom_table > 1 then
				_G_plyrs_overlay_main.sort_do(bottom_table,_G_plyrs_overlay_main.plyr_sort_by_val.value)
			end
			for i=1,#bottom_table do
				end_table[#end_table+1]=bottom_table[i]
			end
		end
		return end_table
	end
    while f.on do
		_G_plyrs_overlay_main.sort_bool=false
		for i=1,32 do
			if _GF_valid_pid(i-1) and (_G_plyrs_overlay_main.plyr_sort_self.on or i-1 ~= player.player_id()) then
				_G_plyrs_overlay_main.plyr_info_table[i] = {
					true, 											-- 1  do it
					i-1,											-- 2  PID
					_GT_plyr_info.name[i],							-- 3  name
					_G_plyrs_overlay_main.dist_table[i][1],			-- 4  distance
					_GT_plyr_info.kd[i],							-- 5  kd
					_GT_plyr_info.money[i],							-- 6  money
					_GT_plyr_info.rank[i],							-- 7  rank
					utils.time()-_GT_plyr_info.join_time[i],		-- 8  time in session
					player.get_player_host_priority(i-1),			-- 9  host priority
					_GT_plyr_info.color[i],							-- 10 color
					color_check(_GT_plyr_info.color[player.player_id()+1],_GT_plyr_info.color[i]),	-- 11 same org/mc
					player.is_player_friend(i-1),					-- 12 friend
					_GT_plyr_info.interior[i],						-- 13 interior
				}
			else
				_G_plyrs_overlay_main.table_default(i)
			end
		end
		if _G_plyrs_overlay_main.plyr_sort_top.on then
			_G_plyrs_overlay_main.plyr_info_table = sort_for_top(_G_plyrs_overlay_main.plyr_info_table,_G_plyrs_overlay_main.plyr_sort_top.value)
		elseif _G_plyrs_overlay_main.plyr_sort_interior.on then
			_G_plyrs_overlay_main.plyr_info_table = sort_for_bottom(_G_plyrs_overlay_main.plyr_info_table)
		else
			_G_plyrs_overlay_main.sort_do(_G_plyrs_overlay_main.plyr_info_table,_G_plyrs_overlay_main.plyr_sort_by_val.value)
		end
		_GF_yield_while_true(f.on and (_G_plyrs_overlay_main.sort_bool==false),250)
	end
end)
_G_plyrs_overlay_main.plyr_list_record_feat.hidden=true

function _G_plyrs_overlay_main.sort_do(_table,_val)
	if _val == 1 then -- alphabetical
		if  _G_plyrs_overlay_main.plyr_sort_asc_desc.value == 0 then table.sort(_table, function(a, b) return a[3]:lower() < b[3]:lower() end)  -- thank you mr kek
		else table.sort(_table, function(a, b) return a[3]:lower() > b[3]:lower() end)  -- thank you mr kek
		end
	elseif _val == 2 then -- distance
		if  _G_plyrs_overlay_main.plyr_sort_asc_desc.value == 0 then table.sort(_table, function(a, b) return a[4] < b[4] end)
		else table.sort(_table, function(a, b) return a[4] > b[4] end)
		end
	else -- other
		if _G_plyrs_overlay_main.plyr_sort_asc_desc.value == 0 then
			table.sort(_table, function(a, b) 
				if a[_val+2] == b[_val+2] then return a[4] < b[4]
				else return a[_val+2] < b[_val+2]
				end
			end)
		else 
			table.sort(_table, function(a, b) 
				if a[_val+2] == b[_val+2] then return a[4] > b[4]
				else return a[_val+2] > b[_val+2]
				end
			end)
		end
	end
end
		
_G_plyrs_overlay_main.blink_do=menu.add_feature("hidden - makes blinks, blink, and dots, dot", "toggle", parent.id, function(f)
	while f.on do
		system.yield(50)
		_G_plyrs_overlay_main.text_dots="..."
		for i=1,10 do
			if i < 5 then
				_G_plyrs_overlay_main.blink[i]=true
				_GF_yield_while_true(f.on,100)
				_G_plyrs_overlay_main.text_dots=_G_plyrs_overlay_main.text_dots.."."
				_G_plyrs_overlay_main.blink[i]=false
				_GF_yield_while_true(f.on,100)
				_G_plyrs_overlay_main.text_dots=_G_plyrs_overlay_main.text_dots.."."
			else
				_G_plyrs_overlay_main.text_dots=_G_plyrs_overlay_main.text_dots.."."
				_GF_yield_while_true(f.on,25)
			end
		end		
	end
end)
_G_plyrs_overlay_main.blink_do.hidden=true

_G_plyrs_overlay_main.popo_rb_feat=menu.add_feature("hidden - makes police colrs flash", "toggle", parent.id, function(f)
	while f.on do
		for i=1,4 do
			_G_plyrs_overlay_main.popo_rb=true
			_GF_yield_while_true(f.on,125)
			_G_plyrs_overlay_main.popo_rb=false
			_GF_yield_while_true(f.on,225)
		end
		_G_plyrs_overlay_main.popo_rb=nil
		_GF_yield_while_true(f.on,1000)
	end
end)
_G_plyrs_overlay_main.popo_rb_feat.hidden=true

_G_plyrs_overlay_main.plyr_sort_by_val=menu.add_feature("Player list sort by:", "autoaction_value_str", _G_plyrs_overlay_main.sort_parent.id,function()
	_G_plyrs_overlay_main.sort_bool=true
end)
_G_plyrs_overlay_main.plyr_sort_by_val.set_str_data(_G_plyrs_overlay_main.plyr_sort_by_val,{"PID","Alphabetically","Distance","K/D Ratio","Money","Rank","Time in session","Host Priority"})

_G_plyrs_overlay_main.plyr_sort_asc_desc=menu.add_feature("Player list sort type:", "autoaction_value_str", _G_plyrs_overlay_main.sort_parent.id,function()
	_G_plyrs_overlay_main.sort_bool=true
end)
_G_plyrs_overlay_main.plyr_sort_asc_desc.set_str_data(_G_plyrs_overlay_main.plyr_sort_asc_desc,{"Ascending", "Descending"})

_G_plyrs_overlay_main.plyr_sort_top = menu.add_feature("Always top of the list:", "value_str", _G_plyrs_overlay_main.sort_parent.id)
_G_plyrs_overlay_main.plyr_sort_top:set_str_data({"Friends","Org/MC"})

_G_plyrs_overlay_main.plyr_sort_interior = menu.add_feature("Interior always at bottom of list", "toggle", _G_plyrs_overlay_main.sort_parent.id)

_G_plyrs_overlay_main.plyr_sort_self = menu.add_feature("Include self on list", "toggle", _G_plyrs_overlay_main.sort_parent.id)

_G_plyrs_overlay_main.plyr_sort_money = menu.add_feature("Show money", "toggle", _G_plyrs_overlay_main.show_info_parent.id)

_G_plyrs_overlay_main.plyr_sort_rank = menu.add_feature("Show rank", "toggle", _G_plyrs_overlay_main.show_info_parent.id)

_G_plyrs_overlay_main.plyr_sort_kd = menu.add_feature("Show K/D", "toggle", _G_plyrs_overlay_main.show_info_parent.id)

_G_plyrs_overlay_main.plyr_sort_veh = menu.add_feature("Show vehicle", "toggle", _G_plyrs_overlay_main.show_info_parent.id)

_G_plyrs_overlay_main.plyr_sort_speed_veh = menu.add_feature("Show speed in a vehicle", "toggle", _G_plyrs_overlay_main.show_info_parent.id)

_G_plyrs_overlay_main.plyr_sort_speed_ped = menu.add_feature("Show speed on foot", "toggle", _G_plyrs_overlay_main.show_info_parent.id)

_G_plyrs_overlay_main.plyr_sort_speed_type = menu.add_feature("Show speed using:", "autoaction_value_str", _G_plyrs_overlay_main.show_info_parent.id)
_G_plyrs_overlay_main.plyr_sort_speed_type.set_str_data(_G_plyrs_overlay_main.plyr_sort_speed_type,{"MPH","KPH"})

_G_plyrs_overlay_main.plyr_sort_speed_above = menu.add_feature("Only show speed above", "action_value_i", _G_plyrs_overlay_main.show_info_parent.id)
_G_plyrs_overlay_main.plyr_sort_speed_above.max,_G_plyrs_overlay_main.plyr_sort_speed_above.min,_G_plyrs_overlay_main.plyr_sort_speed_above.mod=200,0,5

_G_plyrs_overlay_main.plyr_sort_wanted = menu.add_feature("Show wanted level", "toggle", _G_plyrs_overlay_main.show_info_parent.id)

_G_plyrs_overlay_main.plyr_sort_tis = menu.add_feature("Show time in session", "toggle", _G_plyrs_overlay_main.show_info_parent.id)

_G_plyrs_overlay_main.plyr_sort_column_space = menu.add_feature("Display two columns: Spacing", "value_i", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_column_space.max,_G_plyrs_overlay_main.plyr_sort_column_space.min,_G_plyrs_overlay_main.plyr_sort_column_space.mod=250,25,5

_G_plyrs_overlay_main.plyr_sort_column_type = menu.add_feature("Display two columns: Type", "autoaction_value_str", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_column_type.set_str_data(_G_plyrs_overlay_main.plyr_sort_column_type,{"If needed","Always 50/50"})

_G_plyrs_overlay_main.plyr_sort_int_alpha = menu.add_feature("Interior player alpha", "autoaction_value_str", _G_plyrs_overlay_main.display_parent.id,function(f)
	if f.value == 0 then
		_G_plyrs_overlay_main.plyr_sort_int_alpha_speed.hidden=false
	else
		_G_plyrs_overlay_main.plyr_sort_int_alpha_speed.hidden=true
	end
end)
_G_plyrs_overlay_main.plyr_sort_int_alpha.set_str_data(_G_plyrs_overlay_main.plyr_sort_int_alpha,_G_plyrs_overlay_main.alpha_str)

_G_plyrs_overlay_main.plyr_sort_int_alpha_speed = menu.add_feature("Alpha fade speed", "action_value_i", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_int_alpha_speed.max,_G_plyrs_overlay_main.plyr_sort_int_alpha_speed.min,_G_plyrs_overlay_main.plyr_sort_int_alpha_speed.mod=10,1,1
_G_plyrs_overlay_main.plyr_sort_int_alpha_speed.value=5

_G_plyrs_overlay_main.plyr_sort_max = menu.add_feature("Max Players", "autoaction_value_i", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_max.max,_G_plyrs_overlay_main.plyr_sort_max.min,_G_plyrs_overlay_main.plyr_sort_max.mod=32,1,1

_G_plyrs_overlay_main.plyr_sort_x = menu.add_feature("X Pos", "autoaction_value_i", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_x.max,_G_plyrs_overlay_main.plyr_sort_x.min,_G_plyrs_overlay_main.plyr_sort_x.mod=300,0,1

_G_plyrs_overlay_main.plyr_sort_y = menu.add_feature("Y Pos", "autoaction_value_i", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_y.max,_G_plyrs_overlay_main.plyr_sort_y.min,_G_plyrs_overlay_main.plyr_sort_y.mod=300,0,1

_G_plyrs_overlay_main.plyr_sort_space_hor = menu.add_feature("Horizontal Spacing", "autoaction_value_i", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_space_hor.max,_G_plyrs_overlay_main.plyr_sort_space_hor.min,_G_plyrs_overlay_main.plyr_sort_space_hor.mod=25,1,1

_G_plyrs_overlay_main.plyr_sort_space_ver = menu.add_feature("Vertical Spacing", "autoaction_value_i", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_space_ver.max,_G_plyrs_overlay_main.plyr_sort_space_ver.min,_G_plyrs_overlay_main.plyr_sort_space_ver.mod=25,1,1

_G_plyrs_overlay_main.plyr_sort_scale = menu.add_feature("Scale", "autoaction_value_i", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_scale.max,_G_plyrs_overlay_main.plyr_sort_scale.min,_G_plyrs_overlay_main.plyr_sort_scale.mod=300,75,1

_G_plyrs_overlay_main.plyr_sort_font = menu.add_feature("Font", "autoaction_value_i", _G_plyrs_overlay_main.display_parent.id)
_G_plyrs_overlay_main.plyr_sort_font.max,_G_plyrs_overlay_main.plyr_sort_font.min,_G_plyrs_overlay_main.plyr_sort_font.mod=9,0,1

function _GF_nearby_plyr_overlay_hide(_bool)
_G_plyrs_overlay_main.sort_parent.hidden=_bool
_G_plyrs_overlay_main.display_parent.hidden=_bool
_G_plyrs_overlay_main.show_info_parent.hidden=_bool
end
_GF_nearby_plyr_overlay_hide(true)

function _GF_plyr_nearby_overlay_recc()
_G_plyrs_overlay_main.plyr_sort_by_val.value=2
_G_plyrs_overlay_main.plyr_sort_self.on=true
_G_plyrs_overlay_main.plyr_sort_money.on=true
_G_plyrs_overlay_main.plyr_sort_rank.on=true
_G_plyrs_overlay_main.plyr_sort_kd.on=true
_G_plyrs_overlay_main.plyr_sort_veh.on=true
_G_plyrs_overlay_main.plyr_sort_max.value=32
_G_plyrs_overlay_main.plyr_sort_space_hor.value=10
_G_plyrs_overlay_main.plyr_sort_space_ver.value=5
_G_plyrs_overlay_main.plyr_sort_x.value=91
_G_plyrs_overlay_main.plyr_sort_y.value=3
_G_plyrs_overlay_main.plyr_sort_scale.value=75
_G_plyrs_overlay_main.plyr_sort_font.value=4
_G_plyrs_overlay_main.plyr_sort_column_space.on=true
_G_plyrs_overlay_main.plyr_sort_column_space.value=100
_G_plyrs_overlay_main.plyr_sort_column_type.value=1
_G_plyrs_overlay_main.plyr_sort_wanted.on=true
_G_plyrs_overlay_main.plyr_sort_tis.on=true
_G_plyrs_overlay_main.plyr_sort_speed_type.value=0
_G_plyrs_overlay_main.plyr_sort_speed_above.value=0
_G_plyrs_overlay_main.plyr_sort_speed_veh.on=true
_G_plyrs_overlay_main.plyr_sort_speed_ped.on=true
_G_plyrs_overlay_main.plyr_sort_interior.on=true
_G_plyrs_overlay_main.plyr_list_feat.on=true
end
_GF_plyr_nearby_overlay_recc()

_G_ldrbrd = {}
_G_ldrbrd.ped_veh_id={-1,-1}
_G_ldrbrd.plyr_dead={}
_G_ldrbrd.plyr_score={}
_G_ldrbrd.plyr_name={}
_G_ldrbrd.feat_name_str={}
_G_ldrbrd.last_killer=-1
_G_ldrbrd.last_death=-1

function _G_ldrbrd.default_all_tables()
	for i=1,32 do
		_G_ldrbrd.plyr_score[i]={}
		for pid=1,32 do
			_G_ldrbrd.plyr_score[i][pid]={0,0,""}
		end
		_G_ldrbrd.ped_veh_id[i]={-1,-1}
		_G_ldrbrd.plyr_dead[i]=false
		_G_ldrbrd.plyr_name[i]=""
		if player.is_player_valid(i-1) then
			_G_ldrbrd.feat_name_str[i]=_GF_plyr_name(i-1)
		else
			_G_ldrbrd.feat_name_str[i]=""
		end
	end
end
_G_ldrbrd.default_all_tables()

function _G_ldrbrd.sort(score_table)
	if _G_ldrbrd.sort_drctn.value == 0 and _G_ldrbrd.sort_by.value ~= 4 then
		if _G_ldrbrd.sort_by.value == 0 then
			table.sort(score_table, function(a, b) return a[3]:lower() < b[3]:lower()  end) 
		elseif _G_ldrbrd.sort_by.value == 1 then
			table.sort(score_table, function(a, b) 
			if a[1] == b[1] then
				return a[3]:lower() < b[3]:lower()
			end
			return a[1] < b[1] end)
		elseif _G_ldrbrd.sort_by.value == 2 then
			table.sort(score_table, function(a, b) 
			if a[2] == b[2] then
				return a[3]:lower() < b[3]:lower()
			end
			return a[2] < b[2] end)
		else
			table.sort(score_table, function(a, b) return a[7] < b[7]  end)
		end
	elseif _G_ldrbrd.sort_drctn.value == 1 then
		if _G_ldrbrd.sort_by.value == 0 then
			table.sort(score_table, function(a, b) return a[3]:lower() > b[3]:lower()  end) 
		elseif _G_ldrbrd.sort_by.value == 1 then
			table.sort(score_table, function(a, b)
			if a[1] == b[1] then
				return a[3]:lower() > b[3]:lower()
			end
			return a[1] > b[1]  end)
		elseif _G_ldrbrd.sort_by.value == 2 then
			table.sort(score_table, function(a, b)
			if a[2] == b[2] then
				return a[3]:lower() > b[3]:lower()
			end
			return a[2] > b[2]  end)
		elseif _G_ldrbrd.sort_by.value == 3 then
			table.sort(score_table, function(a, b) return a[7] > b[7]  end)
		else
			table.sort(score_table, function(a, b) return a[8] > b[8]  end)
		end
	end
end

_G_ldrbrd.record_ped_veh_id = menu.add_feature("HIDDEN record plyr ped veh id death", "toggle", _G_Leaderboard.id, function(f)
	local function record_death(_pidT,_ped_id)
		if player.player_count() > 0 then -- suicide in SP returns nil i guess
			local murderer = _GF_what_ent_killed_ped(_ped_id)
			for i=1,32 do
				if _G_ldrbrd.ped_veh_id[i][1] == murderer or _G_ldrbrd.ped_veh_id[i][2] == murderer then
					_G_ldrbrd.plyr_score[_pidT][i][2]=_G_ldrbrd.plyr_score[_pidT][i][2]+1
					_G_ldrbrd.plyr_score[i][_pidT][1]=_G_ldrbrd.plyr_score[i][_pidT][1]+1
					_G_ldrbrd.last_killer=i
					_G_ldrbrd.last_death=_pidT
					return true
				end
			end
		end
		return false
	end
	local plyr_leave = event.add_event_listener("player_leave", function(listener)
		if listener.player == player.player_id() then
			_G_ldrbrd.default_all_tables()
		end
	end)
	while f.on do
		for i=1,32 do
			if _GF_valid_pid(i-1) then
				_G_ldrbrd.ped_veh_id[i][1]=player.get_player_ped(i-1)
				_G_ldrbrd.plyr_name[i]=_GF_plyr_name(i-1)
				_G_ldrbrd.feat_name_str[i]=_GF_plyr_name(i-1)
				for pid=1,32 do
					_G_ldrbrd.plyr_score[pid][i][3]=_GF_plyr_name(i-1)
				end
				if player.is_player_in_any_vehicle(i-1) then
					_G_ldrbrd.ped_veh_id[i][2]=player.get_player_vehicle(i-1)
				else
					_G_ldrbrd.ped_veh_id[i][2]=-1
				end
			else
				if _G_ldrbrd.last_killer == i then
					_G_ldrbrd.last_killer=-1
				end
				if _G_ldrbrd.last_death == i then
					_G_ldrbrd.last_death=-1
				end
				_G_ldrbrd.ped_veh_id[i]={-1,-1}
				_G_ldrbrd.plyr_dead[i]=false
				_G_ldrbrd.plyr_name[i]=""
				_G_ldrbrd.feat_name_str[i]=""
				for pid=1,32 do
					_G_ldrbrd.plyr_score[i][pid]={0,0,""}
					_G_ldrbrd.plyr_score[pid][i]={0,0,""}
				end
			end
		end
		_G_ldrbrd.feat.set_str_data(_G_ldrbrd.feat,_G_ldrbrd.feat_name_str)
		for i=1,32 do
			if _GF_valid_pid(i-1) then
				if _GF_is_dead(player.get_player_ped(i-1)) then
					if _G_ldrbrd.plyr_dead[i] == false then
						if record_death(i,player.get_player_ped(i-1)) then
							_G_ldrbrd.plyr_dead[i]=true
						end
					end
				elseif player.is_player_playing(i-1) then
					_G_ldrbrd.plyr_dead[i] = false
				end
			end
		end
		system.yield(250)
	end
end)
_G_ldrbrd.record_ped_veh_id.on=true
_G_ldrbrd.record_ped_veh_id.hidden=true

_G_ldrbrd.feat = menu.add_feature("Show Leaderboard","value_str",_G_Leaderboard.id, function(f)
	local score_table,_table,count,name,v2_pos,text_pos
	local r,g,b,size,back_a,text_a,pid,my_r,my_g,my_b
	local f_value=f.value
	local y_val,y_ofst = 0.013,0
	local x_pos,y_pos = 0.5,0.5
	local function show_last()
		if not _G_ldrbrd.show_last.on then 
			return false
		elseif _G_ldrbrd.show_last.value == 0 and not _GF_valid_pid(_G_ldrbrd.last_killer-1) then
			return false
		elseif _G_ldrbrd.show_last.value == 1 and not _GF_valid_pid(_G_ldrbrd.last_death-1) then
			return false
		else
			local I_name
			if _G_ldrbrd.show_last.value == 0 then I_name=_GF_plyr_name(_G_ldrbrd.last_killer-1) else I_name=_GF_plyr_name(_G_ldrbrd.last_death-1) end
			for i=1,32 do
				if _G_ldrbrd.feat_name_str[i] == I_name then
					name = I_name
					my_r,my_g,my_b = _G_plyrs_overlay_main.plyr_rgb(i,nil)
					_table=_G_ldrbrd.plyr_score[i]
					f.value=i-1
					return true
				end
			end
		end
		return false
	end
	local function retrieve_info()
		_table = {}
		if not show_last() then
			for i=1,32 do
				if _G_ldrbrd.plyr_name[i] == _G_ldrbrd.feat_name_str[f.value+1] then
					name = _GF_plyr_name(i-1)
					my_r,my_g,my_b = _G_plyrs_overlay_main.plyr_rgb(i,nil)
					_table=_G_ldrbrd.plyr_score[i]
					break
				end
			end
		end
		count = 1
		score_table={}
		for i=1,32 do
			if (_table[i][1] ~= nil and _table[i][1] > 0) or (_table[i][2] ~= nil and _table[i][2] > 0)  then
				if _table[i][3] == name then
					name=name.." - ".._table[i][1].." Suicide"
				else
					count=count+1
					score_table[#score_table+1]={
					_table[i][1],
					_table[i][2],
					_table[i][3],
					_G_plyrs_overlay_main.plyr_rgb(i,"r"),
					_G_plyrs_overlay_main.plyr_rgb(i,"g"),
					_G_plyrs_overlay_main.plyr_rgb(i,"b"),
					_G_plyrs_overlay_main.dist_table[i][1],
					i-1}
				end
			end
		end
	end
	local function check_plyr_name()
		local down=false
		if f_value~=f.value then
			if f.value==f_value-1 or f_value-1==-1 then
				down=true
			end
		end
		repeat
			if _G_ldrbrd.feat_name_str[f.value+1] == "" then
				if down then
					if f.value == 0 then
						f.value=31
					else
						f.value=f.value-1
					end
				else
					if f.value == 31 then
						f.value=0
					else
						f.value=f.value+1
					end
				end
			end
		until _G_ldrbrd.feat_name_str[f.value+1] ~= ""
		f_value=f.value
	end
	while not _G_GS_has_loaded do
		system.yield(50)
	end
	while f.on do
		system.yield(5)
		check_plyr_name()
		retrieve_info()
		_G_ldrbrd.sort(score_table)
		x_pos = _G_ldrbrd.x.value
		y_pos = _G_ldrbrd.y.value
		back_a = _G_ldrbrd.back_a.value
		text_a = _G_ldrbrd.text_a.value
		size = _G_ldrbrd.size.value
		y_val = 0.04*size
		v2_pos = v2(x_pos,y_pos-y_val*count*.5)
		scriptdraw.draw_rect(v2_pos,v2(0.169*size,0.040*size*count),_GF_RGBAToInt(0,0,0,back_a))
		scriptdraw.draw_rect(v2(x_pos,y_pos-(y_val*.5)),v2(0.169*size,0.040*size),_GF_RGBAToInt(0,0,0,back_a))
		text_pos = v2(v2_pos.x*(2/3),(y_pos-(y_val*.5))*2)
		scriptdraw.draw_text(name,text_pos,text_pos,size*1.069,_GF_RGBAToInt(my_r,my_g,my_b,text_a),((1<<0)+(1<<1)+(1<<2)),nil)
		for i = 1,#score_table do
			text_pos=text_pos-v2(0,y_val*2)
			r,g,b = score_table[i][4],score_table[i][5],score_table[i][6]
			scriptdraw.draw_text(score_table[i][1],text_pos-v2(size*0.0725,0),text_pos,size*1.069,_GF_RGBAToInt(my_r,my_g,my_b,text_a),((1<<0)+(1<<1)+(1<<2)),nil)
			scriptdraw.draw_text("-",text_pos-v2(size*0.06,0),text_pos,size*1.069,_GF_RGBAToInt(255,255,255,text_a),((1<<0)+(1<<1)+(1<<2)),nil)
			scriptdraw.draw_text(score_table[i][2],text_pos-v2(size*0.0475,0)	,text_pos,size*1.069,_GF_RGBAToInt(r,g,b,text_a),((1<<0)+(1<<1)+(1<<2)),nil)
			scriptdraw.draw_text(score_table[i][3],v2(x_pos,text_pos.y)-v2(size*0.0325,0),v2(x_pos,text_pos.y),size*1.069,_GF_RGBAToInt(r,g,b,text_a),((1<<1)+(1<<2)),nil)
		end
	end
end)_G_ldrbrd.feat.set_str_data(_G_ldrbrd.feat,_G_ldrbrd.feat_name_str)

_G_ldrbrd.show_last = menu.add_feature("Always show last player who:","value_str",_G_Leaderboard.id)
_G_ldrbrd.show_last:set_str_data({"Killed","Was killed"})

_G_ldrbrd.sort_by = menu.add_feature("Sort scores","action_value_str",_G_Leaderboard.id)
_G_ldrbrd.sort_by:set_str_data({"Name","Kills","Deaths","Distance","PID"})

_G_ldrbrd.sort_drctn = menu.add_feature("Sort type","action_value_str",_G_Leaderboard.id)
_G_ldrbrd.sort_drctn:set_str_data({"Ascending","Descending"})

_G_ldrbrd.size = menu.add_feature("Size","action_value_f",_G_Leaderboard.id)
_G_ldrbrd.size.min = .1
_G_ldrbrd.size.max = 3
_G_ldrbrd.size.mod = 0.01
_G_ldrbrd.size.value = 1

_G_ldrbrd.x = menu.add_feature("X Pos","action_value_f",_G_Leaderboard.id)
_G_ldrbrd.x.min = -1
_G_ldrbrd.x.max = 1
_G_ldrbrd.x.mod = 0.01
_G_ldrbrd.x.value = 0.89

_G_ldrbrd.y = menu.add_feature("Y Pos","action_value_f",_G_Leaderboard.id)
_G_ldrbrd.y.min = -1
_G_ldrbrd.y.max = 1
_G_ldrbrd.y.mod = 0.01
_G_ldrbrd.y.value = 0.44

_G_ldrbrd.back_a = menu.add_feature("Background alpha","action_value_i",_G_Leaderboard.id)
_G_ldrbrd.back_a.min = 1
_G_ldrbrd.back_a.max = 255
_G_ldrbrd.back_a.mod = 1
_G_ldrbrd.back_a.value = 100

_G_ldrbrd.text_a = menu.add_feature("Text alpha","action_value_i",_G_Leaderboard.id)
_G_ldrbrd.text_a.min = 1
_G_ldrbrd.text_a.max = 255
_G_ldrbrd.text_a.mod = 1
_G_ldrbrd.text_a.value = 255

function _G_ldrbrd.get_highest(_1_or_2,_text)
	local temp,score,name_k,name_d=0,{},{},{}
	for i=1,32 do
		for pid=1,32 do
			if _G_ldrbrd.plyr_score[i][pid][_1_or_2] > temp and _G_ldrbrd.plyr_name[i] ~= "" and _G_ldrbrd.plyr_name[pid] ~= "" then
				temp=_G_ldrbrd.plyr_score[i][pid][_1_or_2]
			end
		end
	end
	for i=1,32 do
		for pid=1,32 do
			if _G_ldrbrd.plyr_score[i][pid][_1_or_2] >= temp and _G_ldrbrd.plyr_name[i] ~= "" and _G_ldrbrd.plyr_name[pid] ~= "" then
				score[#score+1]={_G_ldrbrd.plyr_score[i][pid][1],_G_ldrbrd.plyr_score[i][pid][2],_G_ldrbrd.plyr_name[i],_G_ldrbrd.plyr_name[pid]}
			end
		end
	end
	if temp>0 then
		local msg =""
		for i=1,#score do
			if score[i][3] == score[i][4] then
				msg=msg..score[i][3].." "..score[i][1].." suicide(s)\n"
			else
				msg=msg..score[i][3].." "..score[i][1].." - "..score[i][2].." "..score[i][4].."\n"
			end
		end
		menu.notify(msg,_G_GeeVer,5)
	else
		menu.notify("No recorded ".._text,_G_GeeVer,5)
	end
end

_G_ldrbrd.highest_kill = menu.add_feature("Who has the most kills?","action",_G_Leaderboard.id,function()
	_G_ldrbrd.get_highest(1,"kills")
end)

_G_ldrbrd.highest_death = menu.add_feature("Who has the most deaths?","action",_G_Leaderboard.id,function()
	_G_ldrbrd.get_highest(2,"deaths")
end)

------------------------------------------------------------------------------------------------------------------------------------
_G_LOS_={}
_G_LOS_._table={}

function _G_LOS_.default(i)
	_G_LOS_._table[i]={false,"",0,0,0,0,""}
end
for i=1,32 do
	_G_LOS_.default(i)
end

function _G_LOS_.sort(_table)
	if _G_LOS_.sort_drctn.value == 0 then
		if _G_LOS_.sort_by.value == 0 then
			table.sort(_table, function(a, b) return a[6] < b[6]  end) 
		else
			table.sort(_table, function(a, b) return a[2]:lower() < b[2]:lower()  end) 
		end
	else
		if _G_LOS_.sort_by.value == 0 then
			table.sort(_table, function(a, b) return a[6] > b[6]  end) 
		else
			table.sort(_table, function(a, b) return a[2]:lower() > b[2]:lower()  end) 
		end
	end
end

function _G_LOS_.get_dist(_dist)
	if _G_LOS_.dist_type.value == 0 then
		return _GF_ent_dist_str(_dist,"m")
	end
	return _GF_ent_dist_str(_dist,"ft")
end
	
function _G_LOS_.show_it(_table)
	local x_pos,y_pos,size = _G_LOS_.x.value,_G_LOS_.y.value,_G_LOS_.size.value
	local back_a = _GF_RGBAToInt(0,0,0,_G_LOS_.back_a.value)
	local y_val = 0.04*size
	local v2_pos = v2(x_pos,y_pos-y_val*(#_table+1)*.5)
	scriptdraw.draw_rect(v2_pos,v2(0.24*size,0.040*size*(#_table+1)),back_a)
	scriptdraw.draw_rect(v2(x_pos,y_pos-(y_val*.5)),v2(0.24*size,0.040*size),back_a)
	local text_pos = v2(v2_pos.x*(2/3),(y_pos-(y_val*.5))*2)
	local my_r,my_g,my_b = _G_plyrs_overlay_main.plyr_rgb(player.player_id()+1,nil)
	scriptdraw.draw_text(_GF_plyr_name(player.player_id()),text_pos,text_pos,size*1.069,_GF_RGBAToInt(my_r,my_g,my_b,_G_LOS_.text_a.value),((1<<0)+(1<<1)+(1<<2)),nil)
	for i = 1,#_table do
		text_pos=text_pos-v2(0,y_val*2)
		local text_rgba = _GF_RGBAToInt(_table[i][3],_table[i][4],_table[i][5],_G_LOS_.text_a.value)
		scriptdraw.draw_text(_G_LOS_.get_dist(_table[i][6]) ,text_pos-v2(size*0.08,0),text_pos,size*1.069,_GF_RGBAToInt(255,255,255,_G_LOS_.text_a.value),((1<<0)+(1<<1)+(1<<2)),nil)
		scriptdraw.draw_text(_table[i][2].." - ".._table[i][7],v2(x_pos,text_pos.y)-v2(size*0.0425,0),v2(x_pos,text_pos.y),size*1.069,text_rgba,((1<<1)+(1<<2)),nil)
	end
end

_G_LOS_.record = menu.add_feature("HIDDEN record LOS players", "toggle", _G_LOS_parent.id, function(f)
	while f.on do
		for i=1,32 do
			if _GF_valid_pid(i-1) and i-1 ~= player.player_id() then
				if native.call(0x0267D00AF114F17A,player.get_player_ped(i-1),player.get_player_ped(player.player_id())):__tointeger(true) == 1 then --HasEntityClearLosToEntityInFront
					_G_LOS_._table[i]={
					true,
					_GF_plyr_name(i-1),
					_G_plyrs_overlay_main.plyr_rgb(i,"r"),
					_G_plyrs_overlay_main.plyr_rgb(i,"g"),
					_G_plyrs_overlay_main.plyr_rgb(i,"b"),
					_G_plyrs_overlay_main.dist_table[i][1],
					_GT_aim_protex_main.get_weap_name(i-1)
					}
				else
					_G_LOS_.default(i)
				end
				system.yield(25)
			end
		end
		f.on=_G_LOS_.feat.on
		system.yield(25)
	end
end)_G_LOS_.record.hidden=true

_G_LOS_.feat = menu.add_feature("Show list","toggle",_G_LOS_parent.id, function(f)
	local _table
	while f.on do
		system.yield(5)
		_G_LOS_.record.on=f.on
		_table={} 
		for i=1, 32 do
			if _G_LOS_._table[i][1] then
				_table[#_table+1]=_G_LOS_._table[i]
			end
		end
		_G_LOS_.sort(_table)
		_G_LOS_.show_it(_table)
	end
end)

_G_LOS_.test = menu.add_feature("Display test","action",_G_LOS_parent.id, function(f)
	local _table,time={},utils.time_ms()+10000
	for i=1,9 do
		_table[i]={
		true,
		"Player "..i,
		math.random(50,255),
		math.random(50,255),
		math.random(50,255),
		math.random(50,5000)*.1,
		_GT_aim_protex_main.weap_table_all[math.random(1,#_GT_aim_protex_main.weap_table_all)][2]
		}
	end
	while time > utils.time_ms() do
		system.yield(5)
		f.name="Display test ".._GF_1_decimal((time-utils.time_ms())/1000)
		_G_LOS_.sort(_table)
		_G_LOS_.show_it(_table)
	end
	f.name="Display test"
end)


_G_LOS_.sort_by = menu.add_feature("Sort players","action_value_str",_G_LOS_parent.id)
_G_LOS_.sort_by:set_str_data({"Distance","Name"})

_G_LOS_.sort_drctn = menu.add_feature("Sort type","action_value_str",_G_LOS_parent.id)
_G_LOS_.sort_drctn:set_str_data({"Ascending","Descending"})

_G_LOS_.dist_type = menu.add_feature("Distance type","action_value_str",_G_LOS_parent.id)
_G_LOS_.dist_type:set_str_data({"Meters","Feet"})

_G_LOS_.size = menu.add_feature("Size","action_value_f",_G_LOS_parent.id)
_G_LOS_.size.min = .1
_G_LOS_.size.max = 3
_G_LOS_.size.mod = 0.01
_G_LOS_.size.value = 1

_G_LOS_.x = menu.add_feature("X Pos","action_value_f",_G_LOS_parent.id)
_G_LOS_.x.min = -1
_G_LOS_.x.max = 1
_G_LOS_.x.mod = 0.01
_G_LOS_.x.value = 0.69

_G_LOS_.y = menu.add_feature("Y Pos","action_value_f",_G_LOS_parent.id)
_G_LOS_.y.min = -1
_G_LOS_.y.max = 1
_G_LOS_.y.mod = 0.01
_G_LOS_.y.value = 0.44

_G_LOS_.back_a = menu.add_feature("Background alpha","action_value_i",_G_LOS_parent.id)
_G_LOS_.back_a.min = 1
_G_LOS_.back_a.max = 255
_G_LOS_.back_a.mod = 1
_G_LOS_.back_a.value = 100

_G_LOS_.text_a = menu.add_feature("Text alpha","action_value_i",_G_LOS_parent.id)
_G_LOS_.text_a.min = 1
_G_LOS_.text_a.max = 255
_G_LOS_.text_a.mod = 1
_G_LOS_.text_a.value = 255

event.add_event_listener("exit", function()
	_GT_plate_anim.reset_plate()
	hook.remove_script_event_hook(_GT_plyr_info.typing_hook)
	--hook.remove_net_event_hook(_GT_aim_protex_main.net_hook)
	local _table,count={},0
	for i=1,#_GT_my_veh_hist do
		if not _table[_GT_my_veh_hist[i]] then
			count=count+1
			_table[_GT_my_veh_hist[i]]=true
		end
	end
	menu.notify(count.." vehicles since Gee-Skid was loaded",_G_GeeVer,10,2)
	for i=1,#_GT_plyr_info.otr_blip do
		if _GT_plyr_info.otr_blip[i] ~= v3(0,0,0) then -- remove any green otr blips 
			ui.remove_blip(_GT_plyr_info.otr_blip[i])
		end	
	end		
	for i=1,#_GT_plyr_info.undead_blip do
		if _GT_plyr_info.undead_blip[i] ~= v3(0,0,0) then -- remove any undead blips 
			ui.remove_blip(_GT_plyr_info.undead_blip[i])
		end	
	end	
    menu.notify("Into the ether :(",_G_GeeVer,10,2)
	local time = _GF_2_decimals((utils.time_ms()-_G_load_time)/1000)
	if time > 60 then
		print("--- Gee-Skid unloaded - ".._GF_2_decimals(time/60).." minutes run time ---")
	else
		print("--- Gee-Skid unloaded - "..time.." seconds run time ---")
	end
end)

end


