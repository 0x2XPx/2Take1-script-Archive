-- GeeSkid v1.01
function _GF_veh_grief_p_action(pid,_hash,_hash2,chk_time,chk_amnt,success,name,model,_value)
	if _GT_plyr_info.veh_grief_choice[pid+1][1] == true then
		if player.is_player_in_any_vehicle(pid) and not _GF_is_dead(player.get_player_vehicle(pid)) then
			if entity.get_entity_model_hash(player.get_player_vehicle(pid)) ~= _hash and entity.get_entity_model_hash(player.get_player_vehicle(pid)) ~= _hash2 then
				chk_time = utils.time_ms()
				chk_amnt = 0
			elseif utils.time_ms() > chk_time and  chk_amnt < 4 then
				success = false
				name = _GF_veh_ped_name(player.get_player_vehicle(pid),"first_plyr")
				model = _GF_model_name(player.get_player_vehicle(pid))
				if _GT_plyr_info.veh_grief_choice[pid+1][2] == 0 then
					if _GF_plyr_veh_kick(pid, true) then
						success=true
					end
				elseif _GT_plyr_info.veh_grief_choice[pid+1][2] == 1 then
					if _GF_request_ctrl(player.get_player_vehicle(pid),2000) then
						_GF_veh_destroyed_do(player.get_player_vehicle(pid), pid)
						menu.notify(""..name.. " - " ..model.. " \nVehicle destroyed :)" , _G_GeeVer, 4, 2)
						success=true
					end
				elseif _GT_plyr_info.veh_grief_choice[pid+1][2] == 2 then
					if _GF_request_ctrl(player.get_player_vehicle(pid),2000) then
						entity.set_entity_max_speed(player.get_player_vehicle(pid), 0)
						menu.notify(""..name.. " - " ..model.. " \nVehicle frozen :)" , _G_GeeVer, 4, 2)
						success=true
					end
				elseif _GT_plyr_info.veh_grief_choice[pid+1][2] == 3 then
					if _GF_dist_me_ent(player.get_player_vehicle(pid)) > 500 then
						success=true
					elseif _GF_ent_tp(player.get_player_vehicle(pid),v3(math.random(-2000,2000),math.random(-2000,5000),500), 0 ,true) then
						menu.notify(""..name.. " - " ..model.. " \nVehicle teleported away :)" , _G_GeeVer, 4, 2)
						success=true
					end
				elseif _GT_plyr_info.veh_grief_choice[pid+1][2] == 4 then
					if _GF_veh_is_fucked(player.get_player_vehicle(pid), 2000,true,false,nil) then
						success=true
					end
				end
				if success then
					chk_time = utils.time_ms()+20000
					chk_amnt = 0
				else
					chk_time = utils.time_ms()+30000
					chk_amnt = chk_amnt+1
				end
			end
		else
			chk_time = utils.time_ms()
			chk_amnt = 0
		end
	end
end

function _GF_p_plyr_do(_action,_time,_val,_pid,_hover)
	_hover=_hover or "hover"
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	local _veh = _GT_plyr_info.veh[_pid+1]
	local model_name = _GF_model_name(_veh)
	local name = _GT_plyr_info.name[_pid+1]
	local continue,complete,stop,has_veh,do_hover=false,false,false,false,false
	_GF_hover_back_record()
	local do_time = _time
	if _GT_plyr_info.interior[_pid+1] then
		menu.notify("".. name .. "\nIn interior.", _G_GeeVer, 5, 2)
	elseif _GF_valid_veh(_veh) then
		has_veh=true
	elseif _hover == "hover" then
		if _GT_plyr_info.tp_sett[_pid+1] == true then
			do_hover = true
		elseif _GF_dist_me_pid(_pid) > 250 then
			menu.notify("".. name .. "\nNo vehicle. Try enabling force check.", _G_GeeVer, 5, 2)
		else
			menu.notify("".. name .. "\nNo vehicle.", _G_GeeVer, 5, 2)
		end
	end
	if do_hover then
		if _GF_hover_check_pid_for_veh(_pid) then
			has_veh=true
			_veh = _GT_plyr_info.veh[_pid+1]
			model_name = _GF_model_name(_veh)
		else
			_GF_hover_back_to_pos()
			menu.notify("".. name .. "\nNo vehicle.", _G_GeeVer, 5, 2)
		end
	end
	if has_veh then
		local air_time = utils.time_ms() + 2000
		while not continue and not stop do
			system.yield(0)
			if _GF_valid_pid(_pid) then
				if do_hover then
					_GF_hover_above_player(_pid)
				end
			else
				stop=true
			end
			if _action == "air_down" then
				if _GF_valid_veh(_veh) and entity.is_entity_in_air(_veh) then --driving over bumps can cause this. The intent is to deny air vehicles
					if air_time < utils.time_ms() then
						if entity.is_entity_in_air(_veh) then 
							continue=true
						end
					end
				else
					stop=true
				end
			elseif _action == "ground_up" then
				if not entity.is_entity_in_air(_veh) then
					continue=true
				else
					stop=true
				end
			elseif _action == "god" then
				if entity.get_entity_god_mode(_veh) ~= _val then
					continue=true
				else
					stop=true
				end
			elseif _action == "remove_rotor" then
				if _GF_valid_helo(_veh) then
					continue=true
				else
					menu.notify(""..name .. " - " ..model_name.. "\nCannot remove rotors on this vehicle.", _G_GeeVer, 4, 2)
					stop=true
				end
			elseif _action == "cntrmsrs" then
				local hash = entity.get_entity_model_hash(_veh)
				if _G_table_countrm_models[hash] then
					continue=true
				else
					menu.notify(""..name .. " - " ..model_name.. "\nThis vehicle does not have countermeasures.", _G_GeeVer, 4, 2)
					stop=true
				end
			elseif _action == "bombs" then	
				local hash = entity.get_entity_model_hash(_veh)
				if _GF_does_veh_have_weap(_veh) then
					continue=true
				else
					menu.notify(""..name .. " - " ..model_name.. "\nThis vehicle cannot drop bombs.", _G_GeeVer, 4, 2)
					stop=true
				end
			elseif _action == "rmv_veh_weap" then	
				if _GF_does_veh_have_weap(_veh) then
					continue=true
				else
					menu.notify(""..name .. " - " ..model_name.. "\nThis vehicle does not have weapons.", _G_GeeVer, 4, 2)
					stop=true
				end
			elseif _action == "auto_repair" then
				if vehicle.is_vehicle_damaged(_veh) then
					continue=true
				else
					stop=true
				end
			else
				continue=true
			end
		end
	end
	stop=false
	if continue then
		local time = utils.time_ms() + _time
		while _GF_valid_veh(_veh) and time > utils.time_ms() and not complete and not stop do
			system.yield(0)
			if _GF_valid_pid(_pid) then
				if do_hover then
					_GF_hover_above_player(_pid)
				end
			else
				stop=true
			end
			if not network.has_control_of_entity(_veh) then
				network.request_control_of_entity(_veh)
			else
				if _action == "float" or _action == "air_down" or _action == "ground_up" then
					entity.set_entity_velocity(_veh,v3(0,0,_val))
				elseif _action == "gravity" then
					entity.set_entity_gravity(_veh, _val)
				elseif _action == "god" then
					entity.set_entity_god_mode(_veh, _val)
				elseif _action == "destroy" then	
					_GF_veh_destroyed_do(_veh, _pid)
				elseif _action == "anti_lock" then
					vehicle.set_vehicle_can_be_locked_on(_veh, _val, true)
				elseif _action == "remove_rotor" then
					vehicle.set_vehicle_extra(_veh, 1, 0)
					vehicle.set_vehicle_extra(_veh, 2, 0)
					vehicle.set_vehicle_extra(_veh, 7, 0)
				elseif _action == "pop_tires" then
					_GF_tire_pop_simple(_veh,true)
				elseif _action == "unpop_tires" then
					_GF_tire_pop_simple(_veh,false)
				elseif _action == "flip_up" then
					local rot=entity.get_entity_rotation(_veh)
					entity.set_entity_rotation(_veh,v3(rot.x,180,rot.z))
				elseif _action == "visible" then
					entity.set_entity_visible(_veh,_val)
				elseif _action == "best_weap" then
					_GF_veh_best_weap(_veh)
				elseif _action == "worst_weap" then
					_GF_weap_worst_simple(_veh)
				elseif _action == "rmv_veh_weap" then
					_GF_rmv_veh_weap(_veh)
				elseif _action == "best_armor" then
					_GF_armor_best_simple(_veh)
				elseif _action == "worst_armor" then
					_GF_armor_worst_simple(_veh)
				elseif _action == "cntrmsrs" then
					if _GF_is_this_veh(_veh,"oppressor2") then
						vehicle.set_vehicle_mod(_veh, 6, _val)
					else
						vehicle.set_vehicle_mod(_veh, 1, _val)
					end
				elseif _action == "bombs" then	
					vehicle.set_vehicle_mod(_veh, 9, _val)
				elseif _action == "repair" then
					if _GF_veh_repair_basic(_veh,250) then
						success=true
					end
				elseif _action == "damage" then
					if _GF_veh_damaged(_veh, 250, nil, nil, nil,false,false) then
						success=true
					end
				elseif _action == "upgrades" then
					if _GF_veh_upgr_all_kek(_veh, 250, false) then
						success=true
					end
				elseif _action == "upgrade_single" then	
					if _GF_veh_upgr_one_kek(_veh, 250, _val, false) then
						success=true
					end
				elseif _action == "speed_torque" then
					if _GF_veh_speed(_veh, 250, nil, nil, false, _val) then
						success=true
					end
				elseif _action == "fuck" then
					if _GF_veh_is_fucked(_veh, 250) then
						success=true
					end
				elseif _action == "freeze" then
					if _GF_veh_freeze(_veh, 250, name, model, _val, false) then
						success=true
					end
				end
				if _action == "repair" or _action == "damage" or _action == "upgrades" or _action == "upgrade_single" or _action == "speed_torque" or _action == "fuck" then
					if success then
						complete=true
					end
				else
					complete=true
				end
			end
		end
	end
	if do_hover then
		_GF_hover_back_to_pos()
	end
	_GF_H_var_default()
	if complete then
		return true
	end
end

function _GF_non_plyr_ped()
	local all_peds=ped.get_all_peds()
	for i=1,#all_peds do
		if not ped.is_ped_a_player(all_peds[i]) then
			return all_peds[i]
		end
	end
	return 100000
end
---------------------Distance/Direction
---------------------------------------

function _GF_in_grid(_pos1,_pos2,_max)
	if math.abs(_pos1.x - _pos2.x) > _max or math.abs(_pos1.y - _pos2.y) > _max or math.abs(_pos1.z - _pos2.z) > _max then
		return false
	end
	return true
end
	
function _GF_flight_calc(_dir,_speed,_rot,_up,_down,_if_needed,_reverse)
	_reverse=_reverse or false
	_rot = _rot or 0
	local dir_rot = _dir
	dir_rot.z=dir_rot.z+_rot
	if dir_rot.z < -180 then
		dir_rot.z=(math.abs(dir_rot.z)-360)*-1
	elseif dir_rot.z > 180 then
		dir_rot.z=math.abs(dir_rot.z)-360
	end
	local veh_speed = v3(0,0,0)
	if _up then
		veh_speed.z = _speed
	elseif _down then
		veh_speed.z = _speed*-1
	elseif _if_needed then
		veh_speed.z = dir_rot.x/180*_speed*2.69
		if _reverse then
			veh_speed.z=veh_speed.z*-1
		end
	else
		veh_speed.z = 0
	end
	if dir_rot.z >= -90 and dir_rot.z <= 90 then --if north
		if dir_rot.z >= 0 then --northeast
			veh_speed.x = dir_rot.z/90*-1*_speed
			veh_speed.y = (1-(dir_rot.z/90))*_speed
		else --northwest
			veh_speed.x = dir_rot.z/90*-1*_speed
			veh_speed.y = (1-(dir_rot.z/90*-1))*_speed
		end
	else --if south
		if dir_rot.z >= 90 then --southeast
			veh_speed.x = (1+((dir_rot.z-90)/90*-1))*-1*_speed
			veh_speed.y = (dir_rot.z-90)/90*-1*_speed
		else--southwest
			veh_speed.x = (1+(dir_rot.z+90)/90)*_speed
			veh_speed.y = (dir_rot.z+90)/90*_speed
		end
	end
	return veh_speed
end

function _GF_vector_to_pos(_target_pos,_ent)
	local ent_pos = entity.get_entity_coords(_ent)
	local x = _target_pos.x - ent_pos.x
	local y = _target_pos.y - ent_pos.y
	local heading = math.atan(x, y) * -180 / math.pi    
	local z_dif = (ent_pos.z - _target_pos.z)*-1
	local pitch = math.asin(z_dif/_GF_dist_pos_pos(_target_pos,ent_pos))/(2*math.pi)*360
	return v3(pitch,0,heading)
end

function _GF_vector_to_pos_head(_target_pos,_ent)
	local ent_pos = entity.get_entity_coords(_ent)
	local x = _target_pos.x - ent_pos.x
	local y = _target_pos.y - ent_pos.y
	local heading = math.atan(x, y) * -180 / math.pi    
	return v3(0,0,heading)
end

function _GF_vector_to_pos2(_target_pos,_ent)
	return v3(math.asin(((entity.get_entity_coords(_ent).z - _target_pos.z)*-1)/math.abs(_target_pos:magnitude(entity.get_entity_coords(_ent))))/(2*math.pi)*360,0,math.atan(_target_pos.x - entity.get_entity_coords(_ent).x, _target_pos.y - entity.get_entity_coords(_ent).y) * -180 / math.pi)
end
	
--#### bool hit, v3 hitPos, v3 hitSurf, Hash hitMat, Entity hitEnt    raycast(v3 start, v3 end, int intersect, Entity ignore)	
function _GF_raycast_vector(_ign_ent)
	_ign_ent = _ign_ent or 0
	local target = -1 
	local pos = player.get_player_coords(player.player_id())
	local my_pos = pos
	local my_rot = cam.get_gameplay_cam_rot()
	if player.is_player_in_any_vehicle(player.player_id()) then
		my_pos = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))+v3(0,0,2)
		pos = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
	end
	my_rot:transformRotToDir()
	my_rot = my_rot * 1000
	pos = pos + my_rot 
	local hit, ray_pos,ray_surf,ray_mat,ray_ent = worldprobe.raycast(my_pos,pos,target,_ign_ent)
	local time = utils.time_ms() + 100
	while not hit and time > utils.time_ms() do
		system.yield(10)
		pos = player.get_player_coords(player.player_id())
		my_pos = pos
		if player.is_player_in_any_vehicle(player.player_id()) then
			my_pos = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))+v3(0,0,2)
			pos = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
		end
		my_rot = cam.get_gameplay_cam_rot()
		my_rot:transformRotToDir()
		my_rot = my_rot * 1000
		pos = pos + my_rot 
		hit, ray_pos,ray_surf,ray_mat,ray_ent = worldprobe.raycast(my_pos,pos,target,_ign_ent)
	end
	if _GF_is_ent(ray_ent) and entity.get_entity_coords(ray_ent) == v3(0,0,0) then ray_ent = nil end
	return hit, ray_pos, ray_ent, _GF_dist_pos_pos(player.get_player_coords(player.player_id()),ray_pos)
end

function _GF_front_of_pos(pos, heading, distance, _head, _z)
	--_head of 180 is in front, 0 is behind
    heading = math.rad((heading - _head) * -1)
    pos.x = pos.x + (math.sin(heading) * -distance)
    pos.y = pos.y + (math.cos(heading) * -distance)
	pos.z = pos.z + _z
    return pos
end

function _GF_pos_offst_pid(_pid, _dist, _dir, _z)
	local _head = nil
	if _dir == "front" then _head = 180 end
	if _dir == "behind" then _head = 0 end
	if _head == nil then _head = math.random(0,360) end
	_z = _z or 0
	local pos = _GF_plyr_pos_z_guess(_pid)
    local heading = math.rad((player.get_player_heading(_pid) - _head) * -1)
    pos.x = pos.x + (math.sin(heading) * -_dist)
    pos.y = pos.y + (math.cos(heading) * -_dist)
	pos.z = pos.z + _z
    return pos
end

function _GF_dist_me_ent(_ent)
    -- local me_pos=player.get_player_coords(player.player_id())
    -- local ent=entity.get_entity_coords(_ent)
    -- local distance=me_pos:magnitude(ent)
    return math.abs(player.get_player_coords(player.player_id()):magnitude(entity.get_entity_coords(_ent)))
end

function _GF_dist_pos_pos(_pos1,_pos2)
    --local distance=_pos1:magnitude(_pos2)
    return math.abs(_pos1:magnitude(_pos2))
end

function _GF_dist_xy_pospos(pos1, pos2)
	-- local pos1v2 = v2(pos1.x,pos1.y)
	-- local pos2v2 = v2(pos2.x,pos2.y)
    -- local distance=pos1v2:magnitude(pos2v2)
    return math.abs(v2(pos1.x,pos1.y):magnitude(v2(pos2.x,pos2.y)))
end

function _GF_closest_pid_to_pos(_pos)
	local pid_table = {}
	for pid in _GF_all_players_but_me() do
		pid_table[#pid_table+1]=pid
	end
	if #pid_table > 1 then
		_GF_sort_xyz_pid(pid_table,_pos,"ascending")
		return pid_table[1]
	else
		return player.player_id()
	end
end

_GT_Grid_Table = {} --shit dont work
function _GF_creat_pos_grid(_pos)
	_GT_Grid_Table = {}
	local pos = _pos
	if _GF_dist_pos_pos(player.get_player_coords(player.player_id()),pos) > 500 then
		pos.z = _GF_pos_nearby(pos,"single_closest",50,"no_water","xyz").z
		pos.z=pos.z-0.5
	end
	pos.x=pos.x-1.5
	pos.y=pos.y-1.5
	for i=1,5 do
		pos.y=pos.y+.5
		for ii=1,5 do
			pos.x=pos.x+.5
			_GT_Grid_Table[#_GT_Grid_Table+1]=pos
		end
		pos.x=pos.x-1.5
		pos.y=pos.y-1.5
	end
end

function _GF_plyr_pos_z_guess(_pid)
	local plyr_pos = player.get_player_coords(_pid)
	if _GF_dist_pos_pos(player.get_player_coords(player.player_id()),plyr_pos) > 250 and plyr_pos.z < 0 then
		plyr_pos.z = _GF_pos_nearby(plyr_pos,"single_closest",10,"water","xy").z+1
	end
	return plyr_pos
end	
	
function _GF_dist_me_pid(pid)
    -- local me_pos=player.get_player_coords(player.player_id())
    -- local pid_pos=player.get_player_coords(pid)
    -- local distance=me_pos:magnitude(pid_pos)
    return math.abs(player.get_player_coords(player.player_id()):magnitude(player.get_player_coords(pid)))
end

function _GF_sort_xy_pos(_table,_pos)
	table.sort(_table, function(a, b) return _GF_dist_xy_pospos(a,_pos) < _GF_dist_xy_pospos(b,_pos) end)
end

function _GF_sort_xyz_pos(_table,_pos)
	table.sort(_table, function(a, b) return _GF_dist_pos_pos(a,_pos) < _GF_dist_pos_pos(b,_pos) end)
end

function _GF_sort_xyz_pid(_table,_pos,_direction)
	if _direction == "ascending" then
		table.sort(_table, function(a, b) return _GF_dist_pos_pos(player.get_player_coords(a),_pos) < _GF_dist_pos_pos(player.get_player_coords(b),_pos) end)
	elseif _direction == "descending" then
		table.sort(_table, function(a, b) return _GF_dist_pos_pos(player.get_player_coords(a),_pos) > _GF_dist_pos_pos(player.get_player_coords(b),_pos) end)
	end
end

function _GF_sort_xyz_ent(_table,_pos)
	table.sort(_table, function(a, b) return _GF_dist_pos_pos(entity.get_entity_coords(a),_pos) < _GF_dist_pos_pos(entity.get_entity_coords(b),_pos) end)
end


function _GF_session_plyr_action_simple(_act1,_act1_val,_act2,_act2_val,_cndtn,_cndtn_bool,_cndtn_delay)
	if not _G_plyr_only_none.on then
		local continue = false
		for pid in _GF_all_players_but_me() do
			if _GF_session_plyr_veh_do(player.get_player_vehicle(pid)) then
				if _cndtn ~= nil and _cndtn_bool ~= nil then
					if _cndtn(player.get_player_vehicle(pid)) == _cndtn_bool then
						if _cndtn_delay ~= nil then
							_GF_delay_(_cndtn_delay)
							if _cndtn(player.get_player_vehicle(pid)) == _cndtn_bool then
								continue = true
							end
						else
							continue = true
						end
					end
				else
					continue=true
				end
				if continue and _GF_request_ctrl(player.get_player_vehicle(pid),100) then
					if _act1 == "repair" then
						_GF_veh_repair_basic(player.get_player_vehicle(pid), 1000)
					else
						if _act1 ~= nil then
							if _act1_val ~= nil then
								_act1(player.get_player_vehicle(pid),_act1_val)
							else
								_act1(player.get_player_vehicle(pid))
							end
						end
						if _act2 ~= nil then
							if _act2_val ~= nil then
								_act2(player.get_player_vehicle(pid),_act2_val)
							else
								_act2(player.get_player_vehicle(pid))
							end
						end
					end
				end
			end
			continue = false
		end
	end
end

function _GF_all_non_plyr_car_do(_act1,_act1_val,_act2,_act2_val,_cndtn,_cndtn_bool,_cndtn_delay)
	local me=player.player_id()
	local my_pos = player.get_player_coords(me)
	local all_veh=vehicle.get_all_vehicles()
	local all_veh2,all_veh3={},{}
	local continue = false
	_GF_sort_xyz_ent(all_veh,my_pos)
	local function do_stuff(_table,_time,_nthtry)
		for i=1,#_table do
			if _GF_session_all_veh_do(_table[i]) then
				if _cndtn ~= nil and _cndtn_bool ~= nil then
					if _cndtn(_table[i]) == _cndtn_bool then
						if _cndtn_delay ~= nil then
							_GF_delay_(_cndtn_delay)
							if _cndtn(_table[i]) == _cndtn_bool then
								continue = true
							end
						else
							continue = true
						end
					end
				else
					continue=true
				end
				if continue then
					if not _GF_request_ctrl(_table[i],_time) then
						if _nthtry ~= nil then
							_nthtry[#_nthtry+1]=_table[i]
						end
					elseif _act1 == "repair" then
						_GF_veh_repair_basic(_table[i], 100)
					else
						if _act1 ~= nil then
							if _act1_val ~= nil then
								_act1(_table[i],_act1_val)
							else
								_act1(_table[i])
							end
						end
						if _act2 ~= nil then
							if _act2_val ~= nil then
								_act2(_table[i],_act2_val)
							else
								_act2(_table[i])
							end
						end
					end
				end
			end
			continue=false
		end
	end
	do_stuff(all_veh,10,all_veh2)
	-- do_stuff(all_veh2,250,all_veh3) -- changed my mind
	-- do_stuff(all_veh3,1000,nil)
end
	
function _GF_plyr_veh_kick(_pid, _bool)
	_bool = _bool or false
	if not player.is_player_in_any_vehicle(_pid) then
		if _bool then
			menu.notify("".._GF_plyr_name(_pid) .. "" .. "" .. " - Not in a vehicle.", _G_GeeVer, 4, 2)
		end
	else
		local time = utils.time_ms() + 1000
		local model_name = _GF_model_name(player.get_player_vehicle(_pid))
		while player.is_player_in_any_vehicle(_pid) and utils.time_ms() < time do
			ped.clear_ped_tasks_immediately(player.get_player_ped(_pid))
			system.yield(200)
		end
		if player.is_player_in_any_vehicle(_pid) then
			_GF_veh_kick_script(_pid)
		end
		time = utils.time_ms() + 2000
		while player.is_player_in_any_vehicle(_pid) and utils.time_ms() < time do
			system.yield(0)
		end
		if not player.is_player_in_any_vehicle(_pid) then
			if _bool then
				menu.notify("".. _GF_plyr_name(_pid) .. " - " .. model_name .. "\nKicked from vehicle :)", _G_GeeVer, 7, 2)
			end
			return true
		else
			menu.notify("".. _GF_plyr_name(_pid) .. " - " .. model_name .. "\nFailed to kick :(", _G_GeeVer, 7, 2)
		end
	end
	return false
end

function _G_plyr_veh_plyr_count()
	local CountTable = {}
	for pid in _GF_all_players_but_me() do
		if _GF_session_player_do(pid) then
			CountTable[#CountTable+1]=pid
		end
	end
	local count = #CountTable
	CountTable = {}
	return count
end


-----------------------plyr/ent fire explodes
function _GF_fire_expl_ent_pid(_ent_pid, _point1, _head, _point2, _type, _delay)
	if not _GF_is_ent_or_pid(_ent_pid) then
		menu.notify("Invalid entity/pid for fire/explosion",_G_GeeVer,4,2)
	else
		local pos,heading,_blame = v3(0,0,0),180,-1
		if _GF_is_ent(_ent_pid) then
			if _GF_good_ped(_ent_pid,true,nil,nil) then -- if player
				heading = player.get_player_heading(player.get_player_from_ped(_ent_pid))
				pos=_GF_front_of_pos(player.get_player_coords(player.get_player_from_ped(_ent_pid)),heading, _point2, _head, _point1)

				_blame=_ent_pid
			else
				heading = entity.get_entity_heading(_ent_pid)
				pos=_GF_front_of_pos(entity.get_entity_coords(_ent_pid),heading, _point2, _head, _point1)
				if _GF_good_ped(_ent_pid,nil,nil,nil) then  --if ped
					_blame=_ent_pid
				else -- if vehicle or other
					_blame=100000
				end
			end
		else
			heading = player.get_player_heading(_ent_pid)
			pos=_GF_front_of_pos(player.get_player_coords(_ent_pid),heading, _point2, _head, _point1)
			_blame = player.get_player_ped(_ent_pid)
		end
		fire.add_explosion(pos, _type, true, false, 0, _blame)
		_GF_delay_(_delay)
	end
end



function _GF_plyr_ped_lock(_pid)----------------work in progress -- thanks to sgwolf
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	local name = tostring(player.get_player_name(_pid))
	local was_in_veh=false
	local my_veh
	local my_orig_pos = player.get_player_coords(me)
	local my_veh_driver
	local my_veh_pos
	local my_veh_pos_hover
	local time
	local wait_time
	local back_in_veh=false
	local lock_success=false
	local hover=false
	if _GF_me_in_any_veh() then
		my_veh=player.get_player_vehicle(me)
		my_veh_pos=entity.get_entity_coords(my_veh)
		my_veh_pos_hover = my_veh_pos
		my_veh_pos_hover.z=my_veh_pos_hover.z+50
		was_in_veh=true
		if not _GF_me_driving(my_veh) then
			if _GF_which_player_driving(my_veh) > -1 then
				my_veh_driver = _GF_which_player_driving(my_veh)
				not_me_driving=true
			end
		end
	end
	if _GF_dist_me_pid(_pid) > 300 then
		hover=true
	end
	time = utils.time_ms() + 1000
	wait_time = utils.time_ms() + 750
	while not lock_success and (utils.time_ms() < time) do
		system.yield(0)
		if hover then
			_GF_hover_above_player(_pid)
		end
		if (utils.time_ms() > wait_time) or not hover then
			if player.is_player_valid(_pid) then
				local police_ped = 0x15F8700D
				if entity.get_entity_attached_to(player.get_player_ped(_pid)) ~= police_ped then
					streaming.request_model(police_ped)
					local plyr_pos = player.get_player_coords(_pid)
					local lock_on = ped.create_ped(2, police_ped, plyr_pos, 0, false, false)
					entity.attach_entity_to_entity(lock_on, player.get_player_ped(_pid), 0, v3(0,0,0), v3(0,0,0), true, false, false, 0, true)
					if entity.is_entity_a_ped(lock_on) then
						--entity.set_entity_visible(lock_on,false) -- if invisible to me it wont lock on
						menu.notify(""..name .. "" .. "" .. "\nMissile lock-on added to player", _G_GeeVer, 4, 2)
						lock_success=true
					end
				else
					menu.notify(""..name .. "" .. "" .. "\nPlayer already has missile lock-on", _G_GeeVer, 4, 2)
				end
			end
		end
	end
	if hover then
		if was_in_veh then
			time = utils.time_ms() + 1500
			wait_time = utils.time_ms() + 1000
			while (utils.time_ms() < time) and not back_in_veh do
				system.yield(0)
				if not_me_driving then
					_GF_hover_above_player(my_veh_driver)
					if utils.time_ms() > wait_time then
						if _GF_tp_into_free_seat(player.get_player_vehicle(my_veh_driver)) then
							back_in_veh=true
						end
					end
				else
					_GF_hover_above_pos(my_veh_pos_hover)
					if utils.time_ms() > wait_time then
						if _GF_tp_into_free_seat(my_veh) then
							back_in_veh=true
						end
					end
				end
			end
			if not back_in_veh then
				my_orig_pos.z=my_orig_pos.z+3
				entity.set_entity_coords_no_offset(my_ped, my_orig_pos)
			end
		else
			entity.set_entity_coords_no_offset(my_ped, my_orig_pos)
		end
	end
end


-------------------------------Overlays
---------------------------------------
function _GF_overlay(_text,_tr,_tg,_tb,_ta,_ts,_tf,_tx,_ty)
	ui.set_text_color(_tr,_tg,_tb,_ta)				
	ui.set_text_scale(_ts)
	ui.set_text_font(_tf)
	ui.set_text_outline(true)
	ui.set_text_centre(true)
	ui.draw_text("".._text.."",v2((_tx),(_ty)))
end

function _GF_overlay_left_no_outline(_text,_tr,_tg,_tb,_ta,_ts,_tf,_tx,_ty)
	ui.set_text_color(_tr,_tg,_tb,_ta)				
	ui.set_text_scale(_ts)
	ui.set_text_font(_tf)
	ui.draw_text("".._text.."",v2((_tx),(_ty)))
end

function _GF_overlay_left(_text,_tr,_tg,_tb,_ta,_ts,_tf,_tx,_ty)
	ui.set_text_color(_tr,_tg,_tb,_ta)				
	ui.set_text_scale(_ts)
	ui.set_text_font(_tf)
	ui.set_text_outline(true)
	ui.draw_text("".._text.."",v2((_tx),(_ty)))
end

function _GF_overlay_right(_text,_tr,_tg,_tb,_ta,_ts,_tf,_tx,_ty,_wrap)
	ui.set_text_color(_tr,_tg,_tb,_ta)				
	ui.set_text_scale(_ts)
	ui.set_text_font(_tf)
	ui.set_text_outline(true)
	ui.set_text_wrap(_wrap/2,_tx)
	ui.set_text_right_justify(true)
	ui.draw_text("".._text.."",v2((_tx),(_ty)))
end

function _GF_gee_watch_overlays(aim_ent)
	if entity.is_entity_a_ped(aim_ent) or entity.is_entity_a_vehicle(aim_ent) then
		_GF_GW_overlay_text(aim_ent)
		if entity.is_entity_a_ped(aim_ent) then
			if ped.is_ped_a_player(aim_ent)  then
				if player.is_player_god(player.get_player_from_ped(aim_ent)) then
					_G_show_god()
				elseif player.is_player_in_any_vehicle(player.get_player_from_ped(aim_ent)) and player.is_player_vehicle_god(player.get_player_from_ped(aim_ent)) then
					_G_show_god()
				end
			elseif entity.get_entity_god_mode(aim_ent) then
				_G_show_god()
			elseif ped.is_ped_in_any_vehicle(aim_ent) and entity.get_entity_god_mode(ped.get_vehicle_ped_is_using(aim_ent)) then
				_G_show_god()
			end
		elseif entity.is_entity_a_vehicle(aim_ent) and entity.get_entity_god_mode(aim_ent) then
			_G_show_god()
		end
	end
end

function _GF_GW_overlay_text(aim_ent)
	local text = ""
	if _GF_GW_GE_no_interfere(_G_GeeWatchExplode_key) then
		text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchExplode_key.value+1])..":Explode  "
	end
	if _GF_GW_GE_no_interfere(_G_GeeWatchDamDes_key) then
		if (entity.is_entity_a_ped(aim_ent) and ped.is_ped_in_any_vehicle(aim_ent)) or entity.is_entity_a_vehicle(aim_ent) then
			if _G_gee_watch_destroy.on then	text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchDamDes_key.value+1]).. ":Destroy  "
			else text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchDamDes_key.value+1]).. ":Damage  "
			end
		elseif entity.is_entity_a_ped(aim_ent) and not ped.is_ped_a_player(aim_ent) then
			text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchDamDes_key.value+1]).. ":Delete  "
		end
	end
	if entity.is_entity_a_ped(aim_ent) and ped.is_ped_a_player(aim_ent) and _GF_GW_GE_no_interfere(_G_GeeWatchKick_key) then
		text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchKick_key.value+1])..":Kick  "
	end
	if _GF_GW_GE_no_interfere(_G_GeeWatchBurn_key) then
		text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchBurn_key.value+1])..":Burn  "
	end
	if (entity.is_entity_a_ped(aim_ent) and ped.is_ped_in_any_vehicle(aim_ent)) or entity.is_entity_a_vehicle(aim_ent) then	
		if _GF_GW_GE_no_interfere(_G_GeeWatchBoard_key) then
			text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchBoard_key.value+1])..":Hijack  "
		end
		if _GF_GW_GE_no_interfere(_G_GeeWatchAccel_key) then
			text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchAccel_key.value+1])..":Accel  "
		end
		if _GF_GW_GE_no_interfere(_G_GeeWatchRvrs_key) then
			text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchRvrs_key.value+1])..":Reverse  "
		end	
		if _GF_GW_GE_no_interfere(_G_GeeWatchRepair_key) then
			text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchRepair_key.value+1])..":Repair  "
		end	
		if _GF_GW_GE_no_interfere(_G_GeeWatchUpgrade_key) then
			text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchUpgrade_key.value+1])..":Upgrade  "
		end	
		if _GF_GW_GE_no_interfere(_G_GeeWatchElev_key) then
			text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchElev_key.value+1])..":Up  "
		end	
	end
	if (entity.is_entity_a_ped(aim_ent) and ped.is_ped_in_any_vehicle(aim_ent)) or entity.is_entity_a_vehicle(aim_ent) or (entity.is_entity_a_ped(aim_ent) and not ped.is_ped_a_player(aim_ent)) then	
		if _GF_GW_GE_no_interfere(_G_GeeWatchGod_key) then
			text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchGod_key.value+1])..":God  "
		end
	end
	if _GF_GW_GE_no_interfere(_G_GeeWatchNtr_key) then
		text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchNtr_key.value+1])..":Ntr  "
	end
	if _GF_GW_GE_no_interfere(_G_GeeWatchDeEleRag_key) then
		if (entity.is_entity_a_ped(aim_ent) and not ped.is_ped_a_player(aim_ent)) then text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchDeEleRag_key.value+1])..":Ragdoll"
		elseif entity.is_entity_a_vehicle(aim_ent) then text = text .. _GF_char_check(_GT_keys_vk_name[_G_GeeWatchDeEleRag_key.value+1])..":Down"
		end
	end
	_GF_overlay(text,_G_W_B_cr.value,_G_W_B_cg.value,_G_W_B_cb.value,_G_W_B_a.value,_G_W_B_s.value/300,_G_W_B_f.value,_G_W_B_x.value/300,_G_W_B_y.value/300)
	
end

function _GF_GW_GE_no_interfere(_key)
	if (_GT_keys_vk_name[_key.value+1] ~= _GT_keys_vk_name[_G_gee_eyeSelect1.value+1]) or not  _G_gee_eye_bypass.on or not _G_gee_eye_main.on then
		return true
	end
	return false
end

function _GF_BoostNotif()
	local boost,stop,text="","",""
	_boost = _GF_char_check(_GT_keys_vk_name[_G_GeeBoostSelect1.value+1])
	if _G_geeboost_set_keys.value > 0 then _boost = _boost.." ".._GF_char_check(_GT_keys_vk_name[_G_GeeBoostSelect2.value+1])
	end
	if _G_geeboost_set_keys.value > 1 then _boost = _boost.." ".._GF_char_check(_GT_keys_vk_name[_G_GeeBoostSelect3.value+1])
	end
	stop = _GF_char_check(_GT_keys_vk_name[_G_GeeStopSelect1.value+1])
	if _G_geestop_set_keys.value > 0 then stop = stop.." ".._GF_char_check(_GT_keys_vk_name[_G_GeeStopSelect2.value+1])
	end
	if _G_geestop_set_keys.value > 1 then stop = stop.." ".._GF_char_check(_GT_keys_vk_name[_G_GeeStopSelect3.value+1])
	end
	if _G_GeeBoost.on and _G_GeeStopRvrs.on then text=_boost..":Accel   "..stop..":Stop/Reverse"
	elseif _G_GeeBoost.on then text=_boost..":Accel"
	else text=stop..":Stop/Reverse"
	end
	_GF_overlay(text,_G_W_B_cr.value,_G_W_B_cg.value,_G_W_B_cb.value,_G_W_B_a.value,_G_W_B_s.value/300,_G_W_B_f.value,_G_W_B_x.value/300,_G_W_B_y.value/300)
end

function _GF_char_check(_char)
	if _char == "~" then --only virtual key i've found with this problem so this works
		return "\\~"
	end
	return _char
end

function _GF_TestNotif()
	_GF_overlay("Explode Destroy Damage Delete Kick Burn Hijack Accel Reverse Repair Upgrade Up Ragdoll Down",_G_W_B_cr.value,_G_W_B_cg.value,_G_W_B_cb.value,_G_W_B_a.value,_G_W_B_s.value/300,_G_W_B_f.value,_G_W_B_x.value/300,_G_W_B_y.value/300)
end


		
function _G_show_god()
	_GF_overlay("God",math.abs(math.random(_G_W_B_cr.value-100,_G_W_B_cr.value)),math.abs(math.random(_G_W_B_cg.value-100,_G_W_B_cg.value)),math.abs(math.random(_G_W_B_cb.value-100,_G_W_B_cb.value)),math.abs(math.random(_G_W_B_a.value-100,_G_W_B_a.value)),_G_W_B_god_s.value/300,_G_W_B_f.value,_G_W_B_god_x.value/300,_G_W_B_god_y.value/300)

end

-- function _GF_TestNotif_d()
	-- --if _G_test_d_display.on then
		-- _GF_overlay("DRIFT DRIFT DRIFT",_GT_drift_main.ovrly_cr.value,_GT_drift_main.ovrly_cg.value,_GT_drift_main.ovrly_cb.value,_GT_drift_main.ovrly_ca.value,_GT_drift_main.ovrly_s.value/300,_GT_drift_main.ovrly_f.value,_GT_drift_main.ovrly_x.value/300,_GT_drift_main.ovrly_y.value/300)
	-- --end
-- end

-- function _GF_drift_notif()
	-- if not _G_driftmod_active.on then
		-- _GF_overlay("DriftMod Ready",_GT_drift_main.ovrly_cr.value,_GT_drift_main.ovrly_cg.value,_GT_drift_main.ovrly_cb.value,_GT_drift_main.ovrly_ca.value,_GT_drift_main.ovrly_s.value/300,_GT_drift_main.ovrly_f.value,_GT_drift_main.ovrly_x.value/300,_GT_drift_main.ovrly_y.value/300)
	-- end
-- end

-- function _GF_drift_active()
	-- _GF_overlay("DRIFT ACTIVE",math.random(0,255),_GT_drift_main.ovrly_cg.value,math.random(0,255),_GT_drift_main.ovrly_ca.value,(_GT_drift_main.ovrly_s.value/300*0.9),_GT_drift_main.ovrly_f.value,_GT_drift_main.ovrly_x.value/300,_GT_drift_main.ovrly_y.value/300)	
-- end

--------------------------------Utility
---------------------------------------
function _GF_set_feat_i_f(_feat,_min,_max,_mod,_val)
	_feat.min = _min
	_feat.max = _max
	_feat.mod = _mod
	_feat.value = _val
end

function _GF_is_even_num(_val)
	if ((_val*.5) - math.floor(_val*.5)) == 0 then
		return true
	end
	return false
end

function _GF_feat_keys_name(_text,_feat,_select,_key1,_key2,_key3)
	if _select.value == 0 then
		_feat.name=_text.._GT_keys_vk_name[_key1.value+1]
	elseif _select.value == 1 then
		_feat.name=_text.._GT_keys_vk_name[_key1.value+1].." ".._GT_keys_vk_name[_key2.value+1]
	else
		_feat.name=_text.._GT_keys_vk_name[_key1.value+1].." ".._GT_keys_vk_name[_key2.value+1].." ".._GT_keys_vk_name[_key3.value+1]
	end
end

function _GF_feat_keys_notify(_text1,_select,_key1,_key2,_key3,_text2)
	local text = _text1
	if _select.value == 0 then
		text=text.._GT_keys_vk_name[_key1.value+1]
	elseif _select.value == 1 then
		text=text.._GT_keys_vk_name[_key1.value+1].." and ".._GT_keys_vk_name[_key2.value+1]
	else
		text=text.._GT_keys_vk_name[_key1.value+1].." and ".._GT_keys_vk_name[_key2.value+1].." and ".._GT_keys_vk_name[_key3.value+1]
	end
	if _text2 ~= nil then
		text=text.._text2
	end
	menu.notify(text, _G_GeeVer, 7, 7)
end

-- _GT_geeeye_weap = {
-- 177293209, --"Mk2 Sniper",
-- 1834241177, --"Railgun",
-- 2982836145, --"RPG",
-- 0xDB26713A, --"EMP Launcher",
-- 2138347493, --"Firework Launcher",
-- 2726580491, --"Grenade Launcher",
-- 0x4DD2DC56, --"Greanade Launcher Smoke",
-- 2939590305, --"Up-N-Atomizer"
-- }

_GT_geeeye_weap = {
gameplay.get_hash_key("weapon_heavysniper_mk2"),
gameplay.get_hash_key("weapon_railgun"),
gameplay.get_hash_key("weapon_rpg"),
gameplay.get_hash_key("weapon_emplauncher"),
gameplay.get_hash_key("weapon_firework"),
gameplay.get_hash_key("weapon_grenadelauncher"),
gameplay.get_hash_key("weapon_grenadelauncher_smoke"),
gameplay.get_hash_key("weapon_raypistol"),
}

_GT_geeeye_comp = {
gameplay.get_hash_key("COMPONENT_HEAVYSNIPER_MK2_CLIP_EXPLOSIVE"), --0x89EBDAA7, --"Mk2 Sniper",
0, --"Railgun",
0, --"RPG",
gameplay.get_hash_key("COMPONENT_EMPLAUNCHER_CLIP_01"), --"EMP Launcher",
0, --"Firework Launcher",
gameplay.get_hash_key("COMPONENT_GRENADELAUNCHER_CLIP_01 0x11AE5C97"), --"Grenade Launcher",
gameplay.get_hash_key("COMPONENT_GRENADELAUNCHER_CLIP_01 0x11AE5C97"), --"Greanade Launcher Smoke",
0, --"Up-N-Atomizer"
}

_GT_geeeye_notif = {
"Firing Gee-Eye!\nMk2 Sniper",
"Firing Gee-Eye!\nRailgun",
"Firing Gee-Eye!\nRPG",
"Firing Gee-Eye!\nEMP Launcher",
"Firing Gee-Eye!\nFirework Launcher",
"Firing Gee-Eye!\nGrenade Launcher",
"Firing Gee-Eye!\nGrenade Launcher Smoke",
"Firing Gee-Eye!\nUp-N-Atomizer",
}

_GT_chng_ped_weap = {
gameplay.get_hash_key("weapon_unarmed"),         --fists
gameplay.get_hash_key("weapon_knuckle"),         -- Kuckle Dusters = 0xD8DF3C3C
gameplay.get_hash_key("weapon_knife"),           -- knife = 0x99B507EA
gameplay.get_hash_key("weapon_battleaxe"),       -- battle axe 3441901897
gameplay.get_hash_key("weapon_stungun"),         -- stungun = 0x3656C8C1
gameplay.get_hash_key("weapon_revolver_mk2"),    -- heavy revolver mk2
gameplay.get_hash_key("weapon_machinepistol"),   -- machinepistol = 0xDB1AA450
gameplay.get_hash_key("weapon_raypistol"),       -- atomizer 0xAF3696A1
gameplay.get_hash_key("weapon_raycarbine"),      -- Unholy Hellbringer 0x476BF155
gameplay.get_hash_key("weapon_combatmg_mk2"),    -- combatmg_mk2 = 0xDBBD7280
gameplay.get_hash_key("weapon_heavysniper_mk2"), -- Heavy Sniper Mk II", 177293209
gameplay.get_hash_key("weapon_rayminigun"),      -- Widowmaker, 0xB62D1F67
gameplay.get_hash_key("weapon_emplauncher"),     -- EMP Gun", 0xDB26713A
gameplay.get_hash_key("weapon_firework"),        -- Firework launcher", 0x7F7497E5
gameplay.get_hash_key("weapon_rpg"),             -- Standard_RPG = 2982836145
gameplay.get_hash_key("weapon_railgun"),         -- railgun = 0x6D544C99

}

_GT_chng_ped_weap_ammo = {
1,--fists
1,-- Kuckle Dusters = 0xD8DF3C3C
1,-- knife = 0x99B507EA
1,-- battle axe 3441901897
1,-- stungun = 0x3656C8C1
6000,-- heavy revolver mk2
6000,-- machinepistol = 0xDB1AA450
1,-- atomizer 0xAF3696A1
1,-- Unholy Hellbringer 0x476BF155
6000,-- combatmg_mk2 = 0xDBBD7280
30,-- Heavy Sniper Mk II", 177293209
6000,-- Widowmaker, 0xB62D1F67
20,-- EMP Gun", 0xDB26713A
20,-- Firework launcher", 0x7F7497E5
20,-- Standard_RPG = 2982836145
20,-- railgun = 0x6D544C99
}

function _GF_01_to_bool(_val,_rvrs)
	if _val == 0 then
		if _rvrs == true then
			return true else return false
		end
	elseif _rvrs == true then
		return false else return true
	end
end

function _GF_bool_to_01(_bool,_rvrs)
	if _bool then
		if _rvrs == true then
			return 0 else return 1
		end
	elseif _rvrs == true then
		return 1 else return 0
	end
end
	
--------------------------------Keys
------------------------------------
function _GF_GW_no_interfere()
	if _G_watch_dog.on then
		if _GF_key_active(114,0) then --prevents you from using wrong commands when using geewatch
			return true
		end
		return false
	end
	return true
end

function _GF_no_right_click(_time) --shit dont work
	local time = utils.time_ms() + _time
	while utils.time_ms() < time do
		system.yield(0)
		controls.set_control_normal(0,114,0.0)
	end
end

function _GF_key_active(_num,_active)
	local _pressed=0.0
	if _active == 1 then
		_pressed=1.0
	end
	if controls.get_control_normal(0,_num)==_pressed then
		return true
	end
	return false
end

function _GF_feature_keys_down(_key_sett,_val1,_val2,_val3)
	if not _G_GS_type_input and _GF_GW_no_interfere() and _GT_plyr_info.typing[player.player_id()+1]==false then
		if _key_sett.value == 0 then
			if _GF_vk_key_down(_GT_keys_vk_name[_val1.value+1]) then
				return true
			end
		elseif _key_sett.value == 1 then
			if _GF_vk_key_down(_GT_keys_vk_name[_val1.value+1]) and _GF_vk_key_down(_GT_keys_vk_name[_val2.value+1]) then
				return true
			end
		elseif _GF_vk_key_down(_GT_keys_vk_name[_val1.value+1]) and _GF_vk_key_down(_GT_keys_vk_name[_val2.value+1]) and _GF_vk_key_down(_GT_keys_vk_name[_val3.value+1]) then
			return true
		end
	end
	return false
end


function _GF_vk_key_down(_key_name)
	local _G_vk_key = MenuKey()
	_G_vk_key:push_str(_key_name)
    return _G_vk_key:is_down_stepped()
end

function _GF_vk_key_down_with_delay(_key_name)
	if _GF_vk_key_down(_key_name) then
		while _GF_vk_key_down(_key_name) do
			system.yield(0)
		end
		return true
	end
	return false
end

function _GF_vk_key_down_any(_delay)
	_delay=_delay or false
	for i=1,#_GT_keys_vk_name do
		if _delay then
			_GF_vk_key_down_with_delay(_GT_keys_vk_name[i])
			return true
		elseif _GF_vk_key_down(_GT_keys_vk_name[i]) then
			return true
		end
	end
	return false
end

function _GF_set_keybinds(_num,_str,_val1,_val2,_val3)
	_GF_vk_key_down_any(true)
	system.yield(200)
	local key1,key2,key3 = _GF_capture_key_pressed(_num,_str)
	if _num == 1 then
		if key1 == -1 then
			menu.notify("No input recorded.", _G_GeeVer, 4, 7)
		else
			_val1.value=key1-1
			menu.notify("".._str.." set to: ".._GT_keys_vk_name[_val1.value+1].."", _G_GeeVer, 4, 7)
			return true
		end
	elseif _num == 2 then
		if key1 == -1 or key2 == -1 then
			menu.notify("No input recorded.", _G_GeeVer, 4, 7)
		else
			_val1.value=key1-1
			_val2.value=key2-1
			menu.notify("".._str.." set to: ".._GT_keys_vk_name[_val1.value+1].." ".._GT_keys_vk_name[_val2.value+1].."", _G_GeeVer, 4, 7)
			return true
		end
	elseif _num == 3 then
		if key1 == -1 or key2 == -1 or key3 == -1 then
			menu.notify("No input recorded.", _G_GeeVer, 4, 7)
		else
			_val1.value=key1-1
			_val2.value=key2-1
			_val3.value=key3-1
			menu.notify("".._str.." set to: ".._GT_keys_vk_name[_val1.value+1].." ".._GT_keys_vk_name[_val2.value+1].." ".._GT_keys_vk_name[_val3.value+1].."", _G_GeeVer, 4, 7)
			return true
		end
	end
	return false
end

function _GF_capture_key_pressed(_num,_str)
	local time = utils.time_ms() + 10000
	local key1,key2,key3 = -1,-1,-1
	local stop=false
	local timer
	_G_GS_type_input=true
	while time > utils.time_ms() and not stop do
		system.yield(0)
		timer = _GF_round_num((time - utils.time_ms())/1000)
		timer=tostring(timer)
		ui.draw_rect(0.5, 0.5, 1.0,1.0, 0, 0, 0, 155)
		_GF_overlay(timer,255,255,255,255,.75,0,.5,.3)
		if _GF_vk_key_down("ESCAPE") then stop = true end
		if key1 == -1 then
			_GF_overlay("".._str.." ",255,255,255,255,.75,0,.5,.5)
			for i=1,#_GT_keys_vk_name-1 do
				if _GF_vk_key_down(_GT_keys_vk_name[i]) then
					key1=i
					while _GF_vk_key_down(_GT_keys_vk_name[i]) and time > utils.time_ms() do
						ui.draw_rect(0.5, 0.5, 1.0,1.0, 0, 0, 0, 155)
						timer = _GF_round_num((time - utils.time_ms())/1000)
						_GF_overlay(timer,255,255,255,255,.75,0,.5,.3)
						_GF_overlay("".._str.." ".._GT_keys_vk_name[key1],255,255,255,255,.75,0,.5,.5)
						system.yield(0)
					end
					break
				end
			end
		end
		if _num > 1 and key1 ~= -1 and key2 == -1 and key3 == -1 then
			_GF_overlay("".._str.." ".._GT_keys_vk_name[key1].." ",255,255,255,255,.75,0,.5,.5)
			for i=1,#_GT_keys_vk_name-1 do
				if _GF_vk_key_down(_GT_keys_vk_name[i]) and i ~= key1 then
					key2=i
					while _GF_vk_key_down(_GT_keys_vk_name[i]) and time > utils.time_ms() do
						ui.draw_rect(0.5, 0.5, 1.0,1.0, 0, 0, 0, 155)
						timer = _GF_round_num((time - utils.time_ms())/1000)
						_GF_overlay(timer,255,255,255,255,.75,0,.5,.3)
						_GF_overlay("".._str.." ".._GT_keys_vk_name[key1].." ".._GT_keys_vk_name[key2],255,255,255,255,.75,0,.5,.5)
						system.yield(0)
					end
					break
				end
			end
		end
		if _num == 3 and key1 ~= -1 and key2 ~= -1 and key3 == -1 then
			_GF_overlay("".._str.." ".._GT_keys_vk_name[key1].." ".._GT_keys_vk_name[key2],255,255,255,255,.75,0,.5,.5)
			for i=1,#_GT_keys_vk_name-1 do
				if _GF_vk_key_down(_GT_keys_vk_name[i]) and i ~= key1 and i ~= key2 then
					key3=i
					while _GF_vk_key_down(_GT_keys_vk_name[i]) and time > utils.time_ms() do
						ui.draw_rect(0.5, 0.5, 1.0,1.0, 0, 0, 0, 155)
						timer = _GF_round_num((time - utils.time_ms())/1000)
						_GF_overlay(timer,255,255,255,255,.75,0,.5,.3)
						_GF_overlay("".._str.." ".._GT_keys_vk_name[key1].." ".._GT_keys_vk_name[key2].." ".._GT_keys_vk_name[key3],255,255,255,255,.75,0,.5,.5)
						system.yield(0)
					end
					break
				end
			end
		end
		if _num == 1 and key1 ~= -1 then
			stop=true
		elseif _num == 2 and key2 ~= -1 then
			stop=true
		elseif _num == 3 and key3 ~= -1 then
			stop=true
		end
	end
	_G_GS_type_input=false
	return key1,key2,key3
end

_GT_keys_vk_name = {
"A", --1
"B", --2
"C", --3
"D", --4
"E", --5
"F", --6
"G", --7
"H", --8
"I", --9
"J", --10
"K", --11
"L", --12
"M", --13
"N", --14
"O", --15
"P", --16
"Q", --17
"R", --18
"S", --19
"T", --20
"U", --21
"V", --22
"W", --23
"X", --24
"Y", --25
"Z", --26
"0", --27
"1", --28
"2", --29
"3", --30
"4", --31
"5", --32
"6", --33
"7", --34
"8", --35
"9", --36
"PERIOD", --37
"COMMA", --38
"QUESTIONMARK", --39
"APOSTROPHE", --40
"F1", --41
"F2", --42
"F3", --43
"F4", --44
"F5", --45
"F6", --46
"F7", --47
"F8", --48
"F9", --49
"F10", --50
"F11", --51
"F12", --52
"ALT", --53
"LSHIFT", --54
"RSHIFT", --55
"LCONTROL", --56
"RCONTROL", --57
"NUMLOCK", --58
"SCROLLLOCK", --59
"BACKSPACE", --60
"CLEAR", --61
"CAPSLOCK", --62
"TAB", --63
"~", --64
"PAUSE", --65
"PRINTSCREEN", --66
"INSERT", --67
"DELETE", --68
"HOME", --69
"END", --70
"RETURN", --71
"NUM0", --72
"NUM1", --73
"NUM2", --74
"NUM3", --75
"NUM4", --76
"NUM5", --77
"NUM6", --78
"NUM7", -- 79
"NUM8", --80
"NUM9", --81
"NUM+", --82
"NUM-", --83
"ESCAPE", --84
}

_GT_keys_vk_num = {
0x41,
0x42,
0x43,
0x44,
0x45,
0x46,
0x47,
0x48,
0x49,
0x4A,
0x4B,
0x4C,
0x4D,
0x4E,
0x4F,
0x50,
0x51,
0x52,
0x53,
0x54,
0x55,
0x56,
0x57,
0x58,
0x59,
0x5A,
0x30,
0x31,
0x32,
0x33,
0x34,
0x35,
0x36,
0x37,
0x38,
0x39,
0xBE,
0xBC,
0xBF,
0xDE,
0x70,
0x71,
0x72,
0x73,
0x74,
0x75,
0x76,
0x77,
0x78,
0x79,
0x7A,
0x7B,
0x12,
0xA0,
0xA1,
0xA2,
0xA3,
0x90,
0x91,
0x08,
 0xC,
0x14,
0x09,
0xC0,
0x13,
0x2C,
0x2D,
0x2E,
0x24,
0x23,
0x0D,
0x60,
0x61,
0x62,
0x63,
0x64,
0x65,
0x66,
0x67,
0x68,
0x69,
0xBB,
0xBD,
0xDC,
}

function _GF_disable_input_from_vk(_key)
	if _GT_vk_to_input_num[_key] ~= nil then
		controls.disable_control_action(0,_GT_vk_to_input_num[_key], true)
	end
end

_GT_vk_to_input_num = {
["A"] = 34,
["B"] = 29,
["C"] = 26,
["D"] = 35,
["E"] = 46,
["F"] = 49,
["G"] = 183,
["H"] = 74,
["K"] = 311,
["L"] = 7,
["M"] = 301,
["N"] = 249,
["P"] = 199,
["Q"] = 44,
["R"] = 45,
["S"] = 33,
["T"] = 245,
["U"] = 303,
["V"] = 0,
["W"] = 32,
["X"] = 252,
["Y"] = 246,
["Z"] = 48,
["1"] = 157,
["2"] = 158,
["3"] = 160,
["4"] = 164,
["5"] = 165,
["6"] = 159,
["7"] = 161,
["8"] = 162,
["9"] = 163,
["F1"] = 288,
["F2"] = 289,
["F3"] = 170,
["F5"] = 166,
["F6"] = 167,
["F7"] = 168,
["F8"] = 169,
["F9"] = 56,
["F10"] = 57,
["F11"] = 344,
["ALT"] = 19,
["LSHIFT"] = 21,
["RSHIFT"] = 21,
["LCONTROL"] = 132,
["RCONTROL"] = 132,
["BACKSPACE"] = 194,
["CAPSLOCK"] = 137,
["~"] = 243,
["TAB"] = 192,
["PAUSE"] = 3,
["INSERT"] = 121,
["DELETE"] = 178,
["HOME"] = 212,
["RETURN"] = 215,
["NUM4"] = 124,
["NUM5"] = 128,
["NUM6"] = 125,
["NUM7"] = 117,
["NUM8"] = 127,
["NUM9"] = 118,
["ESCAPE"] = 200,
["Space"] = 143,
["Page down"] = 207,
["Page up"] = 208,
["Num plus"] = 314,
["Num minus"] = 315,
["Scroll down"] = 14,
["Scroll up"] = 15,
["Mouse down"] = 332,
["Mouse right"] = 333,
["Lmouse"] = 142,
["Rmouse"] = 114,
}

-------------------------------Kicks
------------------------------------
_GT_kicked_table_mem = {}
function _GF_add_kicked_plyr_to_log(date_time,scid,name)
	_GT_kicked_table_mem[#_GT_kicked_table_mem+1]=scid
	local directory,file_path,file
	directory = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\Logs\\"
	if not utils.dir_exists(directory) then
		utils.make_dir(directory)
	end
	if not utils.dir_exists(directory.."kicked\\") then
		utils.make_dir(directory.."kicked\\")
	end
	file_path = "players_kicked"
	if not utils.file_exists(directory.."kicked\\"..file_path..".csv") then
		file = io.open(directory.."kicked\\"..file_path..".csv", "a")
		file:write(_G_GeeVer)
		file:close()
	end
	file = io.open(directory.."kicked\\"..file_path..".csv", "a")
	file:write("\n"..date_time..","..scid..","..name)
	file:close()
end

-- function _GF_plyr_kick(_pid)
	-- local name = _GF_plyr_name(_pid)
	-- local plyr_id = _pid
	-- local count=0
	-- ::kick_em::
	-- if _GF_valid_pid(_pid) then
		-- network.force_remove_player(_pid)
		-- local time = utils.time_ms()+500
		-- while time > utils.time_ms() and name == _GF_plyr_name(plyr_id) do
			-- system.yield(0)
		-- end
		-- if name ~= _GF_plyr_name(plyr_id) then
			-- menu.notify(""..name.."\nKicked :)", _G_GeeVer, 4, 2)
			-- return true
		-- elseif count == 0 then
			-- count=1
			-- goto kick_em
		-- else
			-- menu.notify(""..name.."\nFailed to kick :(", _G_GeeVer, 4, 2)
		-- end
	-- elseif _GF_plyr_name(plyr_id) == "Player" and count == 1 then
		-- menu.notify(""..name.."\nKicked :)", _G_GeeVer, 4, 2)
		-- return true
	-- else
		-- menu.notify("Invalid player!\nFailed to kick :(", _G_GeeVer, 4, 2)
	-- end
-- end

function _GF_plyr_kick(_pid,_auto,_type,k_name)
	_auto = _auto or false
	local name,scid = _GF_plyr_name(_pid)
	local date_time = os.date("%Y-%m-%d %H%M-%S")
	local plyr_id = _pid
	local i_tried=false
	::kick_em::
	if _GF_valid_pid(_pid) then
		scid =  player.get_player_scid(_pid)
		if network.network_is_host() then network.network_session_kick_player(_pid)
		else network.force_remove_player(_pid)
		end
		local time = utils.time_ms()+500
		while time > utils.time_ms() and name == _GF_plyr_name(plyr_id) do
			system.yield(0)
		end
		if name ~= _GF_plyr_name(plyr_id) then
			_GF_kick_notif_do(_auto,_type,k_name,name,"Kicked :)")
			_GF_add_kicked_plyr_to_log(date_time,scid,name)
			return true
		elseif not i_tried then
			i_tried=true
			goto kick_em
		else
			_GF_kick_notif_do(_auto,_type,k_name,name,"Failed to kick :(")
		end
	elseif _GF_plyr_name(plyr_id) == "Player" and i_tried then
		_GF_kick_notif_do(_auto,_type,k_name,name,"Kicked :)")
		_GF_add_kicked_plyr_to_log(date_time,scid,name)
		return true
	else
		menu.notify(name.." - Invalid player!\nFailed to kick :(", _G_GeeVer, 4, 2)
	end
	return false
end

function _GF_kick_notif_do(_auto,_type,k_name,name,msg)
	if _auto then
		if k_name ~= name then
			menu.notify("".._type.."  "..k_name.." / "..name.."\n"..msg.."", _G_GeeVer, 4, 2)
		else
			menu.notify("".._type.." - "..name.."\n"..msg.."", _G_GeeVer, 4, 2)
		end
	else
		menu.notify(""..name.."\n"..msg.."", _G_GeeVer, 4, 2)
	end
end


function _GF_kick_their_org(_pid)
	if _GT_plyr_info.color[_pid+1] > -1 then
		local kick_table = {}
		for pid in _GF_all_players_but_me() do
			if _GF_same_orgmc(_pid,pid) and not player.is_player_friend(pid) and pid ~= _pid then
				kick_table[#kick_table+1]=pid
			end
		end
		for i=1,#kick_table do
			_GF_plyr_kick(kick_table[i])
		end
		_GF_plyr_kick(_pid)
	else
		menu.notify("".._GF_plyr_name(_pid).."\nNot in an org/mc.", _G_GeeVer, 4, 2)
	end
end

function _GF_kick_their_veh(_pid)
	if _GF_valid_pid(_pid) then
		if player.is_player_in_any_vehicle(_pid) then
			local kick_table = {}
			local plyr_veh = player.get_player_vehicle(_pid)
			for s = 1, _GF_veh_seats(plyr_veh) do
				local seat_check = s-2
				if not _GF_me_in_seat(plyr_veh,seat_check) and not _GF_friend_in_seat(plyr_veh,seat_check) and not _GF_plyr_in_seat(plyr_veh,seat_check,_pid) then
					local plyr =  _GF_any_plyr_in_seat(plyr_veh,seat_check)
					if plyr > -1 then
						kick_table[#kick_table+1]=plyr
					end
				end
			end
			for i=1,#kick_table do
				_GF_plyr_kick(kick_table[i])
			end
			_GF_plyr_kick(_pid)
		else
			menu.notify("".._GF_plyr_name(_pid).."\nHas no vehicle.",_G_GeeVer,4,2)
		end
	else
		menu.notify("Invalid player!\nFailed to kick :(", _G_GeeVer, 4, 2)
	end
end

function _GF_kick_all_from_veh(_veh,_excl_frnd)
	_excl_frnd = _excl_frnd or false
	local function frnd_kick(_ped)
		if _excl_frnd and ped.is_ped_a_player(_ped) then
			return (not player.is_player_friend(player.get_player_from_ped(_ped)))
		end
		return true
	end
	local function should_kick(_ped)
		return (_GF_is_ent(_ped) and player.get_player_ped(player.player_id()) ~= _ped and frnd_kick(_ped))
	end
	local function empty_veh(_veh)
		for i = 1,_GF_veh_seats(_veh) do
			if should_kick(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) then
				return false
			end
		end
		return true
	end
	for i = 1,_GF_veh_seats(_veh) do
		if should_kick(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) then
			ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(_veh, i-2))
		end
	end
	local time = utils.time_ms() + 750
	_GF_yield_while_true((time>utils.time_ms()) and not empty_veh(_veh),0)
	if empty_veh(_veh) then
		return true
	else
		for i = 1,_GF_veh_seats(_veh) do
			if should_kick(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) then
				if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) then
					_GF_veh_kick_script(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, i-2)))
					ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(_veh, i-2))
				else
					ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(_veh, i-2))
				end
			end
		end
		local time = utils.time_ms() + 750
		_GF_yield_while_true((time>utils.time_ms()) and not empty_veh(_veh),0)
		return empty_veh(_veh)
	end
end						


-------------------------------Maths
------------------------------------

function _GF_opp_rot(_val)
	if _val + 180 > 180 then 
		return _val + 180 - 360
	end
	return _val + 180
end


function _GF_dec_to_hex(num)
	return string.format("%x", num)
end

function _GF_hex_to_dec(num)
	return tonumber(num,16)
end

function _GF_plyr_moving_pos(_pid)
	if player.is_player_in_any_vehicle(_pid) then
		return (entity.get_entity_speed(player.get_player_vehicle(_pid))+2)/4, entity.get_entity_heading(player.get_player_vehicle(_pid)), entity.get_entity_coords(player.get_player_vehicle(_pid))
	else
		return entity.get_entity_speed(player.get_player_ped(_pid))/4, player.get_player_heading(_pid),player.get_player_coords(_pid)
	end
end

function _GF_geeyee_calc(_shotgun)
	_shotgun = _shotgun or false
	local v3_start,v3_end = v3(),v3()
	local offset,dist = 0,0
	local success,dir,_min,_max
	if _GF_me_in_any_veh() then
		v3_start = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
		while v3_start == nil do
			v3_start = entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
			system.wait(500)
		end
		_min,_max = entity.get_entity_model_dimensions(player.get_player_vehicle(player.player_id()))
		offset=(_max.x/3)+(_max.y/3)+(_max.z/3)
		v3_start.z=v3_start.z+offset
	else
		success, v3_start = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 0x9995, v3(0.0,0.0,-0.8))
		while not success do
			success, v3_start = ped.get_ped_bone_coords(player.get_player_ped(player.player_id()), 0x9995, v3(0.0,0.0,-0.8))
			system.wait(500)
		end
	end
	dir = cam.get_gameplay_cam_rot()
	dir:transformRotToDir()
	dir = dir * 1.5
	v3_start = v3_start + dir
	dir = nil
	if entity.is_an_entity(player.get_entity_player_is_aiming_at(player.player_id())) then
		dist = _GF_dist_me_ent(player.get_entity_player_is_aiming_at(player.player_id()))
		if dist > 100 then
			v3_end = entity.get_entity_coords(player.get_entity_player_is_aiming_at(player.player_id()))
			dir=0
		elseif entity.is_entity_a_vehicle(player.get_entity_player_is_aiming_at(player.player_id())) then
			_min,_max = entity.get_entity_model_dimensions(player.get_entity_player_is_aiming_at(player.player_id()))
			if (_max.x + _max.y + _max.z) < 7 then
				v3_end = entity.get_entity_coords(player.get_entity_player_is_aiming_at(player.player_id()))
				dir=0
			end
		elseif entity.is_entity_a_ped(player.get_entity_player_is_aiming_at(player.player_id())) then
			v3_end = entity.get_entity_coords(player.get_entity_player_is_aiming_at(player.player_id()))
			dir=0
		end
	end
	if dir == nil then
		v3_end = player.get_player_coords(player.player_id())
		dir = cam.get_gameplay_cam_rot()
		dir:transformRotToDir()
		dir = dir * 1500
		v3_end = v3_end + dir
		v3_end.z=v3_end.z-(offset*10)
	end
	if _shotgun then
		local shotgun_xy,shotgun_z,shotgun_z_neg
		if _G_gee_eye_spread_type.value == 0 then -- circular
			shotgun_z=_G_gee_eye_spread.value
			shotgun_z_neg=_G_gee_eye_spread.value		
			shotgun_xy=_G_gee_eye_spread.value
		elseif _G_gee_eye_spread_type.value == 1 then -- horizontal
			shotgun_z=0
			shotgun_z_neg=0
			shotgun_xy=math.floor(_G_gee_eye_spread.value)
		elseif _G_gee_eye_spread_type.value == 2 then -- vertical
			shotgun_z=math.floor(_G_gee_eye_spread.value*3)
			shotgun_z_neg=_G_gee_eye_spread.value
			shotgun_xy=0
		end
		if dir == 0 then
			local count = math.floor(dist)
			local div = 0
			for i=1, math.floor(dist) do
				if i ==  math.floor(dist) then
					div = count * 200
					break
				else
					count = count -1
				end
			end
			shotgun_z=math.floor(shotgun_z/div)
			shotgun_z_neg=math.floor(shotgun_z_neg/div)
			shotgun_xy=math.floor(shotgun_xy/div)
		end
		v3_end = v3_end + dir + v3(math.random(-shotgun_xy,shotgun_xy),math.random(-shotgun_xy,shotgun_xy),math.random(-shotgun_z_neg,shotgun_z))
	end
	return v3_start,v3_end
end

function _GF_2_decimals(_value)
	return math.floor(_value) + math.floor((_value - math.floor(_value)) * 100) * .01
end

function _GF_1_decimal(_value)
	return math.floor(_value) + math.floor((_value - math.floor(_value)) * 10) * .1
end

function _GF_add_commas_to_int(number)--found on a website somewhere
  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  int = int:reverse():gsub("(%d%d%d)", "%1,")
  return minus .. int:reverse():gsub("^,", "") .. fraction
end

function _GF_round_num(_value) -- i made this purely because it was annoying when the otr time counter would skip a second every so often due to math.floor
	local round=0
	if _GF_is_a_num(_value) then
		local _value_floor = math.floor(_value)
		local _value_decimal = _value - _value_floor
		if _value_decimal >= .5 then
			round = _value_floor+1
		else
			round = _value_floor
		end
	end
	return round
end




---------------------------------Names
--------------------------------------
function _GF_model_name(_veh) --sometimes model name returns nil
	local model_name=""
	if _GF_valid_veh(_veh) then
		model_name = vehicle.get_vehicle_model(_veh)
		if model_name == nil then
			model_name=""
		end
	end
	return model_name
end

function _GF_class_name(_veh)
	local class_name=""
	if _GF_valid_veh(_veh) then
		class_name = vehicle.get_vehicle_class_name(_veh)
		if class_name == nil then
			class_name=""
		end
	end
	return class_name
end

function _GF_brand_name(_veh)
	local brand_name=""
	if _GF_valid_veh(_veh) then
		brand_name = vehicle.get_vehicle_brand(_veh)
		if brand_name == nil then
			brand_name=""
		end
	end
	return brand_name
end

function _GF_veh_ped_name(_veh,_seat)
	local name = "Name"
	if _GF_valid_veh(_veh) then
		if not _GF_any_plyr_in_veh(_veh) and not _GF_any_ped_in_veh(_veh) then
			name = "Empty vehicle"
		elseif _seat == "driver" then
			name = _GF_plyr_name(vehicle.get_ped_in_vehicle_seat(_veh, -1))
			if name == "Entity" then name = "Empty seat" end
		elseif _seat == "first_plyr" then
			if _GF_any_plyr_in_veh(_veh) then
				for i=0,_GF_veh_seats(_veh) do
					name = _GF_plyr_name(vehicle.get_ped_in_vehicle_seat(_veh, i-1))
					if name ~= "Entity" and name ~= "Ped" then break end
				end
			else
				name = "Ped"
			end
		elseif _seat == "first" then
			for i=0,_GF_veh_seats(_veh) do
				name = _GF_plyr_name(vehicle.get_ped_in_vehicle_seat(_veh, i-1))
				if name ~= "Entity" then break end
			end
		end
	end	
	return name
end

function _GF_plyr_name(_pid_ped) --once or twice a player left between the time i recorded their name and used their name
	local name="Ped"
	if _GF_valid_pid(_pid_ped) or _GF_good_ped(_pid_ped,nil,nil,nil) then
		if _GF_good_ped(_pid_ped,true,nil,nil) then
			name = player.get_player_name(player.get_player_from_ped(_pid_ped))
			if name == nil then	name="Player" end
		elseif _GF_valid_pid(_pid_ped) then
			name = player.get_player_name(_pid_ped)
			if name == nil then	name="Player" end
		end
	else
		name = "Entity"
	end
	return name
end



function _GF_ent_god_toggle(_ent,_time,_bool)
	if _GF_request_ctrl(_ent,_time) then
		if _bool ~= nil then
			entity.set_entity_god_mode(_ent, _bool)
		else
			entity.set_entity_god_mode(_ent, _GF_opp_bool(entity.get_entity_god_mode(_ent)))
		end
		return true
	end
	return false
end

function _GF_GW_neuter(_ent,_time)
	if _GF_is_ent(_ent) then
		if _GT_GW_ntr[_ent+1] ~= nil and _GT_GW_ntr[_ent+1][1] then
			if _GF_valid_veh(_ent) and _GF_request_ctrl(_ent,_time) then
				if _GT_gw_ntr.veh_hlth.on then
					vehicle.set_vehicle_engine_health(_ent, 1000)
				end
				entity.set_entity_max_speed(_ent,45000)
				_GT_GW_ntr[_ent+1]={false,-1}
				return true
			elseif entity.is_entity_a_ped(_ent) then
				if _GT_gw_ntr.ped_weap.on and _GT_GW_ntr[_ent+1][2] ~= -1 then
					_GF_give_ped_weap(_ent,_GT_GW_ntr[_ent+1][2])
				end
				if not ped.is_ped_a_player(_ent) and _GF_request_ctrl(_ent,_time) then
					if _GT_gw_ntr.ped_hlth.on then
						_GF_set_ped_health(_ent,200,100)
					end
					entity.set_entity_max_speed(_ent,45000)
				end
				_GT_GW_ntr[_ent+1]={false,-1}
				return true
			end
		else
			_GT_GW_ntr[_ent+1]={false,-1}
			if _GF_valid_veh(_ent) and _GF_request_ctrl(_ent,_time) then
				if _GT_gw_ntr.veh_weap.on and _GF_does_veh_have_weap(_ent) then
					_GF_rmv_veh_weap(_ent)
				end
				if _GT_gw_ntr.veh_hlth.on then
					if _GF_get_veh_engn_hlth(_ent,false) ~= _GT_gw_ntr.veh_hlth.value then 
						vehicle.set_vehicle_engine_health(_ent, _GT_gw_ntr.veh_hlth.value)
					end
				end
				if _GT_gw_ntr.veh_speed.on then
					entity.set_entity_max_speed(_ent,_GT_gw_ntr.veh_speed.value)
				end
				_GT_GW_ntr[_ent+1]={true,-1}
				return true
			elseif entity.is_entity_a_ped(_ent) then
				if _GT_gw_ntr.ped_weap.on and ped.get_current_ped_weapon(_ent) ~= gameplay.get_hash_key("weapon_unarmed") then
					_GT_GW_ntr[_ent+1]={true,ped.get_current_ped_weapon(_ent)}
					weapon.remove_weapon_from_ped(_ent, ped.get_current_ped_weapon(_ent))
				end
				if not ped.is_ped_a_player(_ent) then
					if _GT_gw_ntr.ped_hlth.on and ped.get_ped_health(_ent) ~= _GT_gw_ntr.ped_hlth.value then
						_GF_set_ped_health(_ent,_GT_gw_ntr.ped_hlth.value,100)
					end
					if _GT_gw_ntr.ped_speed.on then
						entity.set_entity_max_speed(_ent,_GT_gw_ntr.ped_speed.value)
					end
					_GT_GW_ntr[_ent+1][1]=true
				end
				return true
			end
		end
	end
	return false
end

function _GF_opp_bool(_bool)
	if _bool then 
		return false
	end
	return true
end

function _GF_yield_while_true(_bool,_val)
	local time = utils.time_ms() + _val
	while _bool and time > utils.time_ms() do
		system.yield(0)
	end
end

-----------------------Validity checks
--------------------------------------

function _GF_is_a_str(_str)
	if _str ~= nil and type(_str) == "string" then
		return true
	end
	return false
end

function _GF_is_a_num(_num)
    if _num ~= nil and tonumber(_num) ~= nil then
        return true
    end
    return false
end

function _GF_is_ent(_ent)
	if _GF_is_a_num(_ent) and entity.is_an_entity(_ent) then
		return true
	end
	return false
end

function _GF_is_dead(_ent_pid)
	if _GF_is_ent(_ent_pid) and entity.is_entity_dead(_ent_pid) then
		return true
	elseif _GF_valid_pid(_ent_pid) and _GF_is_ent(player.get_player_ped(_ent_pid)) and entity.is_entity_dead(player.get_player_ped(_ent_pid)) then
		return true
	end
	return false
end

function _GF_is_ent_or_pid(_ent_pid)
	if _GF_is_ent(_ent_pid) or _GF_valid_pid(_ent_pid) then
		return true
	end
	return false
end

function _GF_valid_pid(_pid)
	if _GF_is_a_num(_pid) and player.is_player_valid(_pid) then
		return true
	end
	return false
end

function _GF_GS_is_loaded()
	if _G_silent_start.on then
		if _G_GS_has_loaded then
			return true
		end
		return false
	end
	return true
end

function _GF_remove_nil_entry(_table)
	for i =1, #_table do
		if _table[i] == nil then
			table.remove(_table, i)
		end
	end
end

function _GF_tablelength(t)
	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end

function _GF_all_players_but_me(...)--straight from keks. Couldnt figure this shit out on my own at the time
	local dont_ignore_me <const> = ...
	local pid, me = -1
	if not dont_ignore_me then
		me = player.player_id()
	end
	return function()
		if pid < 31 then
			local is_valid
			repeat
				pid = pid + 1
				is_valid = player.is_player_valid(pid) and (dont_ignore_me or me ~= pid)
			until pid == 31 or is_valid
			if is_valid then
				return pid
			end
		end
	end
end

function table.contains(table, element) -- kek said this was BAD
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
end

function _GF_table_has(_table, _element,_index) -- so i made this
	if _GF_is_a_num(_index) then
		for i=1,#_table do
			if _table[i][_index] == _element then
				return true
			end
		end	
	else
		for i=1,#_table do
			if _table[i] == _element then
				return true
			end
		end	
	end
	return false
end

function _GF_table_remove(_table, element)
	for i=1,#_table do
		if _table[i] == element then
			table.remove(_table,i)
			return true
		end
	end	
	return false
end

function _GF_delay_(_delay)
	local time = utils.time_ms() + _delay
	while utils.time_ms() < time do
		system.yield(0)
	end
end

function _GF_have_cntrl(_ent)
	if _GF_is_ent(_ent) and network.has_control_of_entity(_ent) then
		return true
	end
	return false
end

function _GF_ask_cntrl(_ent)
	if _GF_is_ent(_ent) then
		if network.has_control_of_entity(_ent) then
			return true
		else
			network.request_control_of_entity(_ent)
		end
	end
	return false
end

function _GF_request_ctrl(_ent, time)
    if _GF_is_ent(_ent) then
        if not _GF_have_cntrl(_ent) then
            _GF_ask_cntrl(_ent)
            time = time or 250
            local _time = utils.time_ms() + time
            while _GF_is_ent(_ent) and not _GF_have_cntrl(_ent) and _time > utils.time_ms() do
                system.yield(0)
                _GF_ask_cntrl(_ent)
            end
        end
        return _GF_have_cntrl(_ent)
    end
	return false
end

function _GF_remove_ent(_ent,_time)
	if _GF_request_ctrl(_ent,_time) then
		entity.set_entity_coords_no_offset(_ent, _GF_random_pos("water")+v3(0,0,2000))
		entity.set_entity_as_no_longer_needed(_ent)
		entity.delete_entity(_ent)
		return true
	end
	return false
end
-------------------------Peds
-----------------------------
function _GF_good_ped(_ped,_plyr,_dead,_veh)
	if _GF_is_ent(_ped) and entity.is_entity_a_ped(_ped) then
		if _plyr ~= nil and ped.is_ped_a_player(_ped) ~= _plyr then
			return false
		elseif _dead ~= nil and entity.is_entity_dead(_ped) ~= _dead then
			return false
		elseif _veh ~= nil and ped.is_ped_in_any_vehicle(_ped) ~= _veh then
			return false
		end
		return true
	end
	return false
end

function _GF_all_peds_in_veh(_veh,_plyr,_dead)
	local ped_table = {}
	if _GF_valid_veh(_veh) then
		for i=0, _GF_veh_seats(_veh) do
			if _GF_good_ped(vehicle.get_ped_in_vehicle_seat(_veh, i-1),_plyr,_dead,nil) then
				ped_table[#ped_table+1]=vehicle.get_ped_in_vehicle_seat(_veh, i-1)
			end
		end
	end
	return ped_table
end

function _GF_crt_grps_w_rltnshsps(_num,_type) --made as proof of concept. Havent used
	if _num < 2 then
		menu.notify("You must have at least 2 groups.", _G_GeeVer, 3, 2)
	else
		local group_table = {}
		for i=1,_num do
			group_table[i] = ped.create_group()
		end
		for i=1,#group_table do
			for ii=1,#group_table do
				if ii ~= i then
					if group_table[ii]+1 ~= nil then
						ped.set_relationship_between_groups(_type, group_table[ii], group_table[ii]+1)
						ped.set_relationship_between_groups(_type, group_table[ii]+1, group_table[ii])
					elseif group_table[1] ~= group_table[ii]-1 then
						ped.set_relationship_between_groups(_type, group_table[ii], group_table[1])
						ped.set_relationship_between_groups(_type, group_table[1], group_table[ii])
					end
				end
			end
		end
		return group_table
	end
end


_GT_all_weap_hash = weapon.get_all_weapon_hashes()

_GT_weap_hash_str={}

_GT_weap_hash_str.melee={
{gameplay.get_hash_key("weapon_dagger"),"Antique Cavalry Dagger",0x92A27487},
{gameplay.get_hash_key("weapon_bat"),"Baseball Bat",0x958A4A8F},
{gameplay.get_hash_key("weapon_bottle"),"Broken Bottle",0xF9E6AA4B},
{gameplay.get_hash_key("weapon_crowbar"),"Crowbar",0x84BD7BFD},
{gameplay.get_hash_key("weapon_unarmed"),"Fist",0xA2719263},
{gameplay.get_hash_key("weapon_flashlight"),"Flashlight",0x8BB05FD7},
{gameplay.get_hash_key("weapon_golfclub"),"Golf Club",0x440E4788},
{gameplay.get_hash_key("weapon_hammer"),"Hammer",0x4E875F73},
{gameplay.get_hash_key("weapon_hatchet"),"Hatchet",0xF9DCBF2D},
{gameplay.get_hash_key("weapon_knuckle"),"Brass Knuckles",0xD8DF3C3C},
{gameplay.get_hash_key("weapon_knife"),"Knife",0x99B507EA},
{gameplay.get_hash_key("weapon_machete"),"Machete",0xDD5DF8D9},
{gameplay.get_hash_key("weapon_switchblade"),"Switchblade",0xDFE37640},
{gameplay.get_hash_key("weapon_nightstick"),"Nightstick",0x678B81B1},
{gameplay.get_hash_key("weapon_wrench"),"Pipe Wrench",0x19044EE0},
{gameplay.get_hash_key("weapon_battleaxe"),"Battle Axe",0xCD274149},
{gameplay.get_hash_key("weapon_poolcue"),"Pool Cue",0x94117305},
{gameplay.get_hash_key("weapon_stone_hatchet"),"Stone Hatchet",0x3813FC08},
}

_GT_weap_hash_str.handgun={
{gameplay.get_hash_key("weapon_pistol"),"Pistol",0x1B06D571},
{gameplay.get_hash_key("weapon_pistol_mk2"),"Pistol Mk II",0xBFE256D4},
{gameplay.get_hash_key("weapon_combatpistol"),"Combat Pistol",0x5EF9FEC4},
{gameplay.get_hash_key("weapon_appistol"),"AP Pistol",0x22D8FE39},
{gameplay.get_hash_key("weapon_stungun"),"Stun Gun",0x3656C8C1},
{gameplay.get_hash_key("weapon_pistol50"),"Pistol .50",0x99AEEB3B},
{gameplay.get_hash_key("weapon_snspistol"),"SNS Pistol",0xBFD21232},
{gameplay.get_hash_key("weapon_snspistol_mk2"),"SNS Pistol Mk II",0x88374054},
{gameplay.get_hash_key("weapon_heavypistol"),"Heavy Pistol",0xD205520E},
{gameplay.get_hash_key("weapon_vintagepistol"),"Vintage Pistol",0x83839C4},
{gameplay.get_hash_key("weapon_flaregun"),"Flare Gun",0x47757124},
{gameplay.get_hash_key("weapon_marksmanpistol"),"Marksman Pistol",0xDC4DB296},
{gameplay.get_hash_key("weapon_revolver"),"Heavy Revolver",0xC1B3C3D1},
{gameplay.get_hash_key("weapon_revolver_mk2"),"Heavy Revolver Mk II",0xCB96392F},
{gameplay.get_hash_key("weapon_doubleaction"),"Double Action Revolver",0x97EA20B8},
{gameplay.get_hash_key("weapon_raypistol"),"Up-n-Atomizer",0xAF3696A1},
{gameplay.get_hash_key("weapon_ceramicpistol"),"Ceramic Pistol",0x2B5EF5EC},
{gameplay.get_hash_key("weapon_navyrevolver"),"Navy Revolver",0x917F6C8C},
{gameplay.get_hash_key("weapon_gadgetpistol"),"Perico Pistol",0x57A4368C},
{gameplay.get_hash_key("weapon_stungun_mp"),"Stun Gun",0x45CD9CF3},
}

_GT_weap_hash_str.submachine={
{gameplay.get_hash_key("weapon_microsmg"),"Micro SMG",0x13532244},
{gameplay.get_hash_key("weapon_smg"),"SMG",0x2BE6766B},
{gameplay.get_hash_key("weapon_smg_mk2"),"SMG Mk II",0x78A97CD0},
{gameplay.get_hash_key("weapon_assaultsmg"),"Assault SMG",0xEFE7E2DF},
{gameplay.get_hash_key("weapon_combatpdw"),"Combat PDW",0x0A3D4D34},
{gameplay.get_hash_key("weapon_machinepistol"),"Machine Pistol",0xDB1AA450},
{gameplay.get_hash_key("weapon_minismg"),"Mini SMG",0xBD248B55},
{gameplay.get_hash_key("weapon_raycarbine"),"Unholy Hellbringer",0x476BF155},
}

_GT_weap_hash_str.shotgun={
{gameplay.get_hash_key("weapon_pumpshotgun"),"Pump Shotgun",0x1D073A89},
{gameplay.get_hash_key("weapon_pumpshotgun_mk2"),"Pump Shotgun Mk II",0x555AF99A},
{gameplay.get_hash_key("weapon_sawnoffshotgun"),"Sawed-Off Shotgun",0x7846A318},
{gameplay.get_hash_key("weapon_assaultshotgun"),"Assault Shotgun",0xE284C527},
{gameplay.get_hash_key("weapon_bullpupshotgun"),"Bullpup Shotgun",0x9D61E50F},
{gameplay.get_hash_key("weapon_musket"),"Musket",0xA89CB99E},
{gameplay.get_hash_key("weapon_heavyshotgun"),"Heavy Shotgun",0x3AABBBAA},
{gameplay.get_hash_key("weapon_dbshotgun"),"Double Barrel Shotgun",0xEF951FBB},
{gameplay.get_hash_key("weapon_autoshotgun"),"Sweeper Shotgun",0x12E82D3D},
{gameplay.get_hash_key("weapon_combatshotgun"),"Combat Shotgun",0x5A96BA4},
}

_GT_weap_hash_str.assault={
{gameplay.get_hash_key("weapon_assaultrifle"),"Assault Rifle",0xBFEFFF6D},
{gameplay.get_hash_key("weapon_assaultrifle_mk2"),"Assault Rifle Mk II",0x394F415C},
{gameplay.get_hash_key("weapon_carbinerifle"),"Carbine Rifle",0x83BF0278},
{gameplay.get_hash_key("weapon_carbinerifle_mk2"),"Carbine Rifle Mk II",0xFAD1F1C9},
{gameplay.get_hash_key("weapon_advancedrifle"),"Advanced Rifle",0xAF113F99},
{gameplay.get_hash_key("weapon_specialcarbine"),"Special Carbine",0xC0A3098D},
{gameplay.get_hash_key("weapon_specialcarbine_mk2"),"Special Carbine Mk II",0x969C3D67},
{gameplay.get_hash_key("weapon_bullpuprifle"),"Bullpup Rifle",0x7F229F94},
{gameplay.get_hash_key("weapon_bullpuprifle_mk2"),"Bullpup Rifle Mk II",0x84D6FAFD},
{gameplay.get_hash_key("weapon_compactrifle"),"Compact Rifle",0x624FE830},
{gameplay.get_hash_key("weapon_militaryrifle"),"Military Rifle",0x9D1F17E6},
{gameplay.get_hash_key("weapon_heavyrifle"),"Heavy Rifle",0xC78D71B4},
}

_GT_weap_hash_str.machinegun={
{gameplay.get_hash_key("weapon_mg"),"MG",0x9D07F764},
{gameplay.get_hash_key("weapon_combatmg"),"Combat MG",0x7FD62962},
{gameplay.get_hash_key("weapon_combatmg_mk2"),"Combat MG Mk II",0xDBBD7280},
{gameplay.get_hash_key("weapon_gusenberg"),"Gusenberg Sweeper",0x61012683},
}

_GT_weap_hash_str.sniper={
{gameplay.get_hash_key("weapon_sniperrifle"),"Sniper Rifle",0x05FC3C11},
{gameplay.get_hash_key("weapon_heavysniper"),"Heavy Sniper",0x0C472FE2},
{gameplay.get_hash_key("weapon_heavysniper_mk2"),"Heavy Sniper Mk II",0xA914799},
{gameplay.get_hash_key("weapon_marksmanrifle"),"Marksman Rifle",0xC734385A},
{gameplay.get_hash_key("weapon_marksmanrifle_mk2"),"Marksman Rifle Mk II",0x6A6C02E0},
}

_GT_weap_hash_str.heavy={
{gameplay.get_hash_key("weapon_rpg"),"RPG",0xB1CA77B1},
{gameplay.get_hash_key("weapon_grenadelauncher"),"Grenade Launcher",0xA284510B},
{gameplay.get_hash_key("weapon_grenadelauncher_smoke"),"Grenade Launcher Smoke",0x4DD2DC56},
{gameplay.get_hash_key("weapon_minigun"),"Minigun",0x42BF8A85},
{gameplay.get_hash_key("weapon_firework"),"Firework Launcher",0x7F7497E5},
{gameplay.get_hash_key("weapon_railgun"),"Railgun",0x6D544C99},
{gameplay.get_hash_key("weapon_hominglauncher"),"Homing Launcher",0x63AB0442},
{gameplay.get_hash_key("weapon_compactlauncher"),"Compact Grenade Launcher",0x0781FE4A},
{gameplay.get_hash_key("weapon_rayminigun"),"Widowmaker",0xB62D1F67},
{gameplay.get_hash_key("weapon_emplauncher"),"Compact EMP Launcher",0xDB26713A},
}

_GT_weap_hash_str.throwable={
{gameplay.get_hash_key("weapon_grenade"),"Grenade",0x93E220BD},
{gameplay.get_hash_key("weapon_bzgas"),"BZ Gas",0xA0973D5E},
{gameplay.get_hash_key("weapon_molotov"),"Molotov Cocktail",0x24B17070},
{gameplay.get_hash_key("weapon_stickybomb"),"Sticky Bomb",0x2C3731D9},
{gameplay.get_hash_key("weapon_proxmine"),"Proximity Mines",0xAB564B93},
{gameplay.get_hash_key("weapon_snowball"),"Snowballs",0x787F0BB},
{gameplay.get_hash_key("weapon_pipebomb"),"Pipe Bombs",0xBA45E8B8},
{gameplay.get_hash_key("weapon_ball"),"Baseball",0x23C9F95C},
{gameplay.get_hash_key("weapon_smokegrenade"),"Tear Gas",0xFDBC8A50},
{gameplay.get_hash_key("weapon_flare"),"Flare",0x497FACC3},
}

_GT_weap_hash_str.misc={
{gameplay.get_hash_key("weapon_petrolcan"),"Jerry Can",0x34A67B97},
{gameplay.get_hash_key("gadget_parachute"),"Parachute",0xFBAB5776},
{gameplay.get_hash_key("weapon_fireextinguisher"),"Fire Extinguisher",0x060EC506},
{gameplay.get_hash_key("weapon_hazardcan"),"Hazardous Jerry Can",0xBA536372},
{gameplay.get_hash_key("weapon_fertilizercan"),"Fertilizer Can",0x184140A1},
}

_GT_veh_weap_str = {
"VEHICLE_WEAPON_ROTORS", 
"VEHICLE_WEAPON_TANK", 
"VEHICLE_WEAPON_SEARCHLIGHT",
"VEHICLE_WEAPON_RADAR",
"VEHICLE_WEAPON_PLAYER_BULLET",
"VEHICLE_WEAPON_PLAYER_LAZER",
"VEHICLE_WEAPON_ENEMY_LASER",
"VEHICLE_WEAPON_PLAYER_BUZZARD",
"VEHICLE_WEAPON_PLAYER_HUNTER",
"VEHICLE_WEAPON_PLANE_ROCKET",
"VEHICLE_WEAPON_SPACE_ROCKET",
"VEHICLE_WEAPON_TURRET_INSURGENT",
"VEHICLE_WEAPON_PLAYER_SAVAGE",
"VEHICLE_WEAPON_TURRET_TECHNICAL",
"VEHICLE_WEAPON_NOSE_TURRET_VALKYRIE",
"VEHICLE_WEAPON_TURRET_VALKYRIE",
"VEHICLE_WEAPON_CANNON_BLAZER",
"VEHICLE_WEAPON_TURRET_BOXVILLE",
"VEHICLE_WEAPON_RUINER_BULLET",
"VEHICLE_WEAPON_RUINER_ROCKET",
"VEHICLE_WEAPON_HUNTER_MG",
"VEHICLE_WEAPON_HUNTER_MISSILE",
"VEHICLE_WEAPON_HUNTER_CANNON",
"VEHICLE_WEAPON_HUNTER_BARRAGE",
"VEHICLE_WEAPON_TULA_NOSEMG",
"VEHICLE_WEAPON_TULA_MG",
"VEHICLE_WEAPON_TULA_DUALMG",
"VEHICLE_WEAPON_TULA_MINIGUN",
"VEHICLE_WEAPON_SEABREEZE_MG",
"VEHICLE_WEAPON_MICROLIGHT_MG",
"VEHICLE_WEAPON_DOGFIGHTER_MG",
"VEHICLE_WEAPON_DOGFIGHTER_MISSILE",
"VEHICLE_WEAPON_MOGUL_NOSE",
"VEHICLE_WEAPON_MOGUL_DUALNOSE",
"VEHICLE_WEAPON_MOGUL_TURRET",
"VEHICLE_WEAPON_MOGUL_DUALTURRET",
"VEHICLE_WEAPON_ROGUE_MG",
"VEHICLE_WEAPON_ROGUE_CANNON",
"VEHICLE_WEAPON_ROGUE_MISSILE",
"VEHICLE_WEAPON_BOMBUSHKA_DUALMG",
"VEHICLE_WEAPON_BOMBUSHKA_CANNON",
"VEHICLE_WEAPON_HAVOK_MINIGUN",
"VEHICLE_WEAPON_VIGILANTE_MG",
"VEHICLE_WEAPON_VIGILANTE_MISSILE",
"VEHICLE_WEAPON_TURRET_LIMO",
"VEHICLE_WEAPON_DUNE_MG",
"VEHICLE_WEAPON_DUNE_GRENADELAUNCHER",
"VEHICLE_WEAPON_DUNE_MINIGUN",
"VEHICLE_WEAPON_TAMPA_MISSILE",
"VEHICLE_WEAPON_TAMPA_MORTAR",
"VEHICLE_WEAPON_TAMPA_FIXEDMINIGUN",
"VEHICLE_WEAPON_TAMPA_DUALMINIGUN",
"VEHICLE_WEAPON_HALFTRACK_DUALMG",
"VEHICLE_WEAPON_HALFTRACK_QUADMG",
"VEHICLE_WEAPON_APC_CANNON",
"VEHICLE_WEAPON_APC_MISSILE",
"VEHICLE_WEAPON_APC_MG",
"VEHICLE_WEAPON_ARDENT_MG",
"VEHICLE_WEAPON_TECHNICAL_MINIGUN",
"VEHICLE_WEAPON_INSURGENT_MINIGUN",
"VEHICLE_WEAPON_TRAILER_QUADMG",
"VEHICLE_WEAPON_TRAILER_MISSILE",
"VEHICLE_WEAPON_TRAILER_DUALAA",
"VEHICLE_WEAPON_NIGHTSHARK_MG",
"VEHICLE_WEAPON_OPPRESSOR_MG",
"VEHICLE_WEAPON_OPPRESSOR_MISSILE",
"VEHICLE_WEAPON_MOBILEOPS_CANNON",
"VEHICLE_WEAPON_AKULA_TURRET_SINGLE",
"VEHICLE_WEAPON_AKULA_MISSILE",
"VEHICLE_WEAPON_AKULA_TURRET_DUAL",
"VEHICLE_WEAPON_AKULA_MINIGUN",
"VEHICLE_WEAPON_AKULA_BARRAGE",
"VEHICLE_WEAPON_AVENGER_CANNON",
"VEHICLE_WEAPON_BARRAGE_TOP_MG",
"VEHICLE_WEAPON_BARRAGE_TOP_MINIGUN",
"VEHICLE_WEAPON_BARRAGE_REAR_MG",
"VEHICLE_WEAPON_BARRAGE_REAR_MINIGUN",
"VEHICLE_WEAPON_BARRAGE_REAR_GL",
"VEHICLE_WEAPON_CHERNO_MISSILE",
"VEHICLE_WEAPON_COMET_MG",
"VEHICLE_WEAPON_DELUXO_MG",
"VEHICLE_WEAPON_DELUXO_MISSILE",
"VEHICLE_WEAPON_KHANJALI_CANNON",
"VEHICLE_WEAPON_KHANJALI_CANNON_HEAVY",
"VEHICLE_WEAPON_KHANJALI_MG",
"VEHICLE_WEAPON_KHANJALI_GL",
"VEHICLE_WEAPON_REVOLTER_MG",
"VEHICLE_WEAPON_WATER_CANNON",
"VEHICLE_WEAPON_SAVESTRA_MG",
"VEHICLE_WEAPON_SUBCAR_MG",
"VEHICLE_WEAPON_SUBCAR_MISSILE",
"VEHICLE_WEAPON_SUBCAR_TORPEDO",
"VEHICLE_WEAPON_THRUSTER_MG",
"VEHICLE_WEAPON_THRUSTER_MISSILE",
"VEHICLE_WEAPON_VISERIS_MG",
"VEHICLE_WEAPON_VOLATOL_DUALMG"}
		
function _GF_weap_hash(_weap)
	if _weap ~= nil then
		if _GF_is_a_str(_weap) and _GF_table_has(_GT_all_weap_hash,gameplay.get_hash_key(_weap)) then
			return true, gameplay.get_hash_key(_weap)
		elseif _GF_table_has(_GT_all_weap_hash,_weap) then
			return true, _weap
		end
	end
	return false, nil
end

function _GF_give_ped_weap(_ped,_weapon_hash)
	local good, _weap = _GF_weap_hash(_weapon_hash)
	if _GF_good_ped(_ped,nil,nil,nil) and good then
		if not weapon.has_ped_got_weapon(_ped, _weap) then
			weapon.give_delayed_weapon_to_ped(_ped, _weap, 1, 1)
		end
		local found, ammo = weapon.get_max_ammo(_ped,_weap)
		local time = utils.time_ms() + 50
		while time > utils.time_ms() and not found do
			system.yield(0)
			found, ammo = weapon.get_max_ammo(_ped,_weap)
		end
		if found then
			weapon.set_ped_ammo(_ped, _weap,ammo)
		end
		return true
	end
	return false
end

function _GF_ped_combat_attrib(_ped,_hate,_time,_res)
	_res = _res or false
	_hate = _hate or false
	_time = _time or 50
	if _GF_request_ctrl(_ped,_time) then -- not sure if control is needed for all of this but it also verifies that theyre real
		if _res and entity.is_entity_dead(_ped) then
			local ped_veh,ped_seat=nil,nil
			if ped.is_ped_in_any_vehicle(_ped) then
				ped_veh = ped.get_vehicle_ped_is_using(_ped)
				ped_seat = _GF_what_seat_ped_in(ped_veh,_ped)
			end
			ped.resurrect_ped(_ped)
			system.yield(0)
			ped.clear_ped_tasks_immediately(_ped)
			system.yield(0)
			_GF_set_ped_health(_ped,200,25)
			native.call(0x8D8ACD8388CD99CE,_ped)--revive ped
			if _GF_valid_veh(ped_veh) and ped_seat > -2 then
				ped.set_ped_into_vehicle(_ped,ped_veh,ped_seat)
				ai.task_vehicle_drive_wander(_ped, ped_veh, 50, 786956)
			else
				ai.task_wander_standard(_ped,10,true)
			end
			system.yield(25)
		end
		_GF_ask_cntrl(_ped)
		ped.set_ped_combat_range(_ped, 2) 					-- far range
		ped.set_ped_combat_ability(_ped, 100) 				-- attack
		ped.set_ped_combat_attributes(_ped, 1, true) 		-- can use vehicles
		ped.set_ped_combat_attributes(_ped, 2, true) 		-- can do drivebys 
		ped.set_ped_combat_attributes(_ped, 3, true) 		-- can leave vehicle
		ped.set_ped_combat_attributes(_ped, 5, true) 		-- can fight unarmed
		ped.set_ped_combat_attributes(_ped, 63, false) 		-- run from tough ped
		ped.set_ped_combat_attributes(_ped, 292, false) 	-- freeze movement
		ped.set_ped_combat_attributes(_ped, 1424, true) 	-- can use weapon
		if _hate then
			_GF_ask_cntrl(_ped)
			if ped.get_ped_relationship_group_hash(_ped) ~= gameplay.get_hash_key("HATES_PLAYER") then
				ped.remove_ped_from_group(_ped)
				system.yield(0)
				ped.set_ped_relationship_group_hash(_ped, gameplay.get_hash_key("HATES_PLAYER"))
				ped.set_ped_never_leaves_group(_ped, true)
			end
			ped.set_can_attack_friendly(_ped,true,false)
			ped.set_ped_combat_attributes(_ped, 46, true) 	-- always fight
			ped.set_ped_combat_attributes(_ped, 52, true) 	-- ignore traffic
			ped.set_ped_combat_movement(_ped, 2)	 		-- offensive
			ped.set_ped_config_flag(_ped, 187, 0) 			-- is hurt
			ped.set_ped_config_flag(_ped, 188, 1) 			-- disable hurt
			ped.set_ped_config_flag(_ped, 128, 1) 			-- can be agitated
			ped.set_ped_config_flag(_ped, 183, 1) 			-- agitated
			ped.set_ped_config_flag(_ped, 229, 1) 			-- disable vehicle panic
			ped.set_ped_config_flag(_ped, 430, 1) 			-- ignore being on fire
		end
		system.yield(0)
		return true
	end
	return false
end
	
	-- local coverOptions = {
-- --         canUseCover = 0,
-- --         canUseVehicles = 1,
-- --         canDoDrivebys = 2,
-- --         canLeaveVehicle = 3,
-- --         canFightArmedPedsWhenNotArmed = 5,
-- --         canTauntInVehicle = 20,
-- --         alwaysFight = 46,
-- --         ignoreTrafficWhenDriving = 52,
-- --         fleesFromInvincibleOpponents = 63,
-- --         freezeMovement = 292,  
-- --         playerCanUseFiringWeapons = 1424  
-- --     }

function _GF_ped_ragdoll(_ped,_bool,_time)
	if _GF_request_ctrl(_ped,_time) then-- not sure if control is needed but it also verifies that theyre real
		ped.set_ped_can_ragdoll(_ped, _bool)
		if _bool == false then
			for bf = 1, 26 do
				ped.set_ped_ragdoll_blocking_flags(_ped, bf)
				system.yield(0)
			end
		end
		return true
	end
	return false
end

function _GF_set_ped_health(_ped,_num,_time)
	if _GF_is_ent(_ped) and entity.is_entity_a_ped(_ped) and ped.get_ped_health(_ped) ~= _num and _GF_request_ctrl(_ped,_time) then-- not sure if control is needed
		if ped.get_ped_max_health(_ped) < _num then
			if _num <=200 then
				ped.set_ped_max_health(_ped, 200)
			else
				ped.set_ped_max_health(_ped, _num)
			end
		end
		ped.set_ped_health(_ped, _num)
	end
end

function _GF_ped_force(aim, time,_direction)
	if _GF_request_ctrl(aim,time) then
		local pos = entity.get_entity_coords(aim)
		local force
		if not ped.is_ped_ragdoll(aim) then
			ped.set_ped_to_ragdoll(aim,1000,1000,0)
		end
		ai.task_start_scenario_in_place(aim, "WORLD_FISH_FLEE", 0, false)
		if _direction == "up" then
			entity.apply_force_to_entity(aim, 1,math.random(-2,2), math.random(-2,2), _G_ped_veh_accel.value, 0, 0, 0,   false, true)
		elseif _direction == "forward" then
			force = _GF_flight_calc(entity.get_entity_rotation(aim),_G_ped_veh_accel.value,0,false,false,true)
			entity.apply_force_to_entity(aim, 1,force.x,force.y,force.z, 0, 0, 0,   false, true)
		end
		system.yield(75)
		if _GF_dist_pos_pos(pos,entity.get_entity_coords(aim)) < 1 then
			for i=1,3 do
				if _GF_request_ctrl(aim,math.floor(time/2)) then
					if _direction == "up" then
						entity.apply_force_to_entity(aim, 1,math.random(-2,2), math.random(-2,2), _G_ped_veh_accel.value, 0, 0, 0,   false, true)
					elseif _direction == "forward" then
						force = _GF_flight_calc(entity.get_entity_rotation(aim),_G_ped_veh_accel.value,0,false,false,true)
						entity.apply_force_to_entity(aim, 1,force.x,force.y,force.z, 0, 0, 0,   false, true)
					end
					system.yield(75)
					if _GF_dist_pos_pos(pos,entity.get_entity_coords(aim)) > 1 then
						break
					end
				end
			end
		end
	end
end

function _GF_remove_dead_ped_from_seat(_veh,_seat)
	if  _GF_valid_veh(_veh) and _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) and entity.is_entity_dead(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) then
		ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(_veh, _seat))
		local time = utils.time_ms() + 500
		while _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) and time > utils.time_ms() do
			system.yield(0)
		end
		if _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) and not ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) then
			time = utils.time_ms() + 500
			while time > utils.time_ms() and _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) do
				system.yield(0)
				if _GF_ask_cntrl(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) then
					entity.set_entity_as_no_longer_needed(vehicle.get_ped_in_vehicle_seat(_veh, _seat))
					entity.delete_entity(vehicle.get_ped_in_vehicle_seat(_veh, _seat))
					time = utils.time_ms()
					system.yield(100)
				end
			end
		end
		if _GF_no_one_in_seat(_veh, _seat) then
			return true
		end
	end
	return false
end

-------------------------Vehicle Status
---------------------------------------


function _GF_valid_veh(_veh)
	if _GF_is_ent(_veh) and entity.is_entity_a_vehicle(_veh) and streaming.is_model_valid(entity.get_entity_model_hash(_veh)) then
		return true
	end
	return false
end

function _GF_is_this_veh(_veh,_string)
	if _GF_valid_veh(_veh) and gameplay.get_hash_key(_string) == entity.get_entity_model_hash(_veh) then
		return true
	end
	return false
end

function _GF_valid_helo(_veh)
	if _GF_valid_veh(_veh) and streaming.is_model_a_heli(entity.get_entity_model_hash(_veh)) then
		return true
	end
	return false
end

function _GF_has_free_seat(_veh)
	if _GF_valid_veh(_veh) then
		for i = 0,_GF_veh_seats(_veh) do
			if _GF_no_one_in_seat(_veh, i-1) then
				return true
			end
		end
	end
	return false
end

function _GF_player_driving(veh)
	if _GF_valid_veh(veh) then
		if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(veh, -1)) then
			return true
		end
	end
	return false
end

function _GF_which_player_driving(veh)
	for i = 0, 31 do
		if _GF_plyr_in_seat(veh,-1,i) then
			return i
		end
	end
	return -1
end

function _GF_any_plyr_in_veh(veh)
	for s = 1, _GF_veh_seats(veh) do
		if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(veh, i-2)) then
			return true
		end
	end
	return false
end

function _GF_a_plyr_in_that_veh(veh)
	for s = 1, _GF_veh_seats(veh) do
		if not _GF_me_in_seat(veh,s-2) then
			for i = 0, 31 do
				if _GF_plyr_in_seat(veh,s-2,i) then
					return i
				end
			end
		end
	end
	return -1
end

function _GF_veh_seats(_veh)
	if _GF_valid_veh(_veh) then
		return vehicle.get_vehicle_model_number_of_seats(entity.get_entity_model_hash(_veh))
	end
	return 0
end

function _GF_plyr_in_seat(_veh,_seat,_pid)
	if _GF_valid_veh(_veh) and _GF_valid_pid(_pid) then
		if vehicle.get_ped_in_vehicle_seat(_veh, _seat) == player.get_player_ped(_pid) then
			return true
		end
	end
	return false
end

function _GF_any_plyr_in_seat(_veh,_seat)
	if _GF_valid_veh(_veh) and ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) then
		return player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, _seat))
	end
	return -1
end

function _GF_what_name_in_seat(_veh,_seat)
	local name = "Ped"
	if _GF_valid_veh(_veh) and ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) then
		name = _GF_plyr_name(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, _seat)))
	end
	return name
end

function _GF_what_seat_plyr_in(_veh,_pid)
	if _GF_valid_veh(_veh) and _GF_valid_pid(_pid) then
		for i = 1,_GF_veh_seats(_veh) do
			if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) and player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) == _pid then
				return i-2
			end
		end
	end
	return -2
end

function _GF_what_seat_ped_in(_veh,_ped)
	if _GF_valid_veh(_veh) and _GF_good_ped(_ped,nil,nil,true) then
		for i = 1,_GF_veh_seats(_veh) do
			if vehicle.get_ped_in_vehicle_seat(_veh, i-2) == _ped then
				return i-2
			end
		end
	end
	return -2
end

function _GF_first_free_seat(_veh,_incl_npc)
	_incl_npc=_incl_npc or false
	-- local seat=-2
	-- local dead_fail=false
	-- local success=false
	for i = 1,_GF_veh_seats(_veh) do
		if _GF_no_one_in_seat(_veh, i-2) then
			return i-1, false
		elseif entity.is_entity_dead(vehicle.get_ped_in_vehicle_seat(_veh,  i-2)) then
			if _GF_remove_dead_ped_from_seat(_veh,i-2) then
				return i-2, false
			else
				return -2, true
			end
		elseif _incl_npc and not ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) then
			return i-2, false
		end
	end
	return -2, false
end

function _GF_any_plyr_in_veh(_veh)
	for i = 1,_GF_veh_seats(_veh) do
		if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) then
			return true
		end
	end
	return false
end

function _GF_plyr_veh(_pid)
	if _GF_valid_pid(_pid) and  player.is_player_in_any_vehicle(_pid) then
		return player.get_player_vehicle(_pid)
	end
	return nil
end

function _GF_any_ped_in_veh(_veh)
	for i = 1,_GF_veh_seats(_veh) do
		if entity.is_entity_a_ped(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) then
			return true
		end
	end
	return false
end

function _GF_any_frnd_in_veh(_veh)
	for i = 1,_GF_veh_seats(_veh) do
		if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) and player.is_player_friend(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, i-2))) then
			return true
		end
	end
	return false
end

function _GF_no_one_in_seat(_veh,_seat)
	if _GF_valid_veh(_veh) then
		if not entity.is_entity_a_ped(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) then
			return true
		end
    end
end

function _GF_friend_in_seat(_veh,_seat)
	if _GF_valid_veh(_veh) then
		if entity.is_entity_a_ped(vehicle.get_ped_in_vehicle_seat(_veh, _seat)) and player.is_player_friend(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, _seat))) then
			return true
		end
    end
end

function _GF_no_one_in_veh(_veh)
	if _GF_valid_veh(_veh) then
		local seat_count = vehicle.get_vehicle_model_number_of_seats(entity.get_entity_model_hash(_veh))
		local seat=0
		for i = 0,seat_count do
			if not _GF_no_one_in_seat(_veh,i-1) then
				seat=seat+1
			end
		end
		if seat == 0 then
			return true
		end
	end
end

function _GF_num_free_seats(_veh)
	local seat=0
	if _GF_valid_veh(_veh) then
		local seat_count = vehicle.get_vehicle_model_number_of_seats(entity.get_entity_model_hash(_veh))
		for i = 1,seat_count do
			if _GF_no_one_in_seat(_veh,i-2) then
				seat=seat+1
			end
		end
	end
	return seat
end

function _GF_me_in_seat(_veh,_seat)
	if _GF_valid_veh(_veh) then
		if vehicle.get_ped_in_vehicle_seat(_veh, _seat) == player.get_player_ped(player.player_id()) then
			return true
		end
	end
	return false
end

function _GF_me_driving(_veh)
	return  (_GF_valid_veh(_veh) and vehicle.get_ped_in_vehicle_seat(_veh, -1) == player.get_player_ped(player.player_id()))
end

function _GF_me_in_any_veh()
    if player.is_player_in_any_vehicle(player.player_id()) and _GF_valid_veh(player.get_player_vehicle(player.player_id())) then
        return true
    end
	return false
end

function _GF_me_in_that_veh(_veh)
	return (player.is_player_in_any_vehicle(player.player_id()) and player.get_player_vehicle(player.player_id()) == _veh) 
end
	
---------------------------------Spawns
---------------------------------------
function _GF_req_stream_hash(_hash)
	if not streaming.has_model_loaded(_hash) then
		streaming.request_model(_hash)
		while (not streaming.has_model_loaded(_hash)) do
			system.yield(10)
		end
	end
end

function _GF_spawn_angry_ped_at_pos(_pos,_model_hash,_weapon_hash1,_weapon_hash2,_pid)  --thnks to midnight and kek 
	local _ped=ped.create_ped(6, _model_hash,_pos, math.random(0,359), true, false)
	_GF_give_ped_weap(_ped,_weapon_hash1)
	_GF_give_ped_weap(_ped,_weapon_hash2)
	_GF_ped_combat_attrib(_ped,true)
	_GF_set_ped_health(_ped,2500,50)
	if _pid ~= nil then
		gameplay.shoot_single_bullet_between_coords(_pos, _pos + v3(0,0,.25), 0, gameplay.get_hash_key("weapon_pistol"), player.get_player_ped(_pid), false, true, 100)
		ai.task_combat_ped(_ped, player.get_player_ped(_pid), 0, 16)
	end
	_GF_ped_ragdoll(_ped,false,50)
	return _ped
end

function _GF_spawn_veh_at_pos(_pos,_hash,_upgrade,_heading)
	_upgrade = _upgrade or false
	_heading = _heading or math.random(0,359)
	local _veh = vehicle.create_vehicle(_hash, _pos+v3(0,0,100), 0.0, true, false)
	if not _GF_valid_veh(_veh) then
		menu.notify("Failed to create "..tostring(_GT_veh_hash_true_name[_hash]).."\nPossibly at max spawn limit.", _G_GeeVer, 4, 2)
	else
		entity.set_entity_heading(_veh,_heading)
		entity.set_entity_coords_no_offset(_veh, _pos)
		vehicle.set_vehicle_on_ground_properly(_veh)
		if _upgrade then
			_GF_veh_upgr_all_kek(_veh, 1000, false)	
		end
		decorator.decor_set_int(_veh, "MPBitset", 1 << 10)
		return _veh
	end
	return nil
end

function _GF_spawn_veh_at_pid_frnt(_pid,_hash,_upgrade)
	_upgrade = _upgrade or false
	if _GF_valid_pid(_pid) then
		local _veh = vehicle.create_vehicle(_hash, _GF_plyr_pos_z_guess(_pid)+v3(0,0,100), 0.0, true, false)
		if not _GF_valid_veh(_veh) then
			menu.notify("Failed to create "..tostring(_GT_veh_hash_true_name[_hash]).."\nPossibly at max spawn limit.", _G_GeeVer, 4, 2)
		else
			entity.set_entity_heading(_veh,player.get_player_heading(_pid))
			entity.set_entity_coords_no_offset(_veh, _GF_front_of_pos(_GF_plyr_pos_z_guess(_pid), player.get_player_heading(_pid), _GF_spwn_frt_dist(_pid,_veh), 180, 1.5))
			vehicle.set_vehicle_on_ground_properly(_veh)
			if _upgrade then
				_GF_veh_upgr_all_kek(_veh, 1000, false)	
			end
			decorator.decor_set_int(_veh, "MPBitset", 1 << 10)
			return _veh
		end
	end
	return nil
end

-----------------------Vehicle Movement
---------------------------------------
function _GF_veh_bounce_soft(_veh,count)
	if count < 15 then
		if _GF_request_ctrl(_veh,50) then entity.set_entity_velocity(_veh,v3(0,0,5))
		else entity.set_entity_velocity(_veh,v3(0,0,5))
		end
	elseif count > 20 and count < 45 then
		if _GF_request_ctrl(_veh,50) then entity.set_entity_velocity(_veh,v3(0,0,-6))
		else entity.set_entity_velocity(_veh,v3(0,0,-6))
		end
	end
end

function _GF_veh_bounce_hard(_veh,count)
	if count < 30 then
		if _GF_request_ctrl(_veh,50) then entity.set_entity_velocity(_veh,v3(0,0,100))
		else entity.set_entity_velocity(_veh,v3(0,0,100))
		end
	elseif count > 40 then
		if _GF_request_ctrl(_veh,50) then entity.set_entity_velocity(_veh,v3(0,0,-110))
		else entity.set_entity_velocity(_veh,v3(0,0,-110))
		end
	end
end

function _GF_vertical_velocity(_veh,speed,_name,time)
	time = time or 1000
	_name = _name or tostring("Vehicle")
	if _GF_request_ctrl(_veh,time) then
		entity.set_entity_velocity(_veh,v3(0,0,speed))
		entity.set_entity_gravity(_veh, true)
		menu.notify(_name .. "" .. "" .. " velocity changed.", _G_GeeVer, 4, 2)
	end
end

function _GF_veh_accel(aim, time)
	if _GF_request_ctrl(aim,time) then
		vehicle.set_vehicle_forward_speed(aim,_G_ped_veh_accel.value) 
	end
end

function _GF_veh_revers(aim, time)
	if _GF_request_ctrl(aim,time) then
		vehicle.set_vehicle_forward_speed(aim,(_G_ped_veh_revers.value*-1)) 
	end
end

function _GF_delete(aim, time)
	if _GF_request_ctrl(aim,time) then
		entity.delete_entity(aim) 
		return true
	end
	return false
end

function _GF_elevate(aim, time)
	if _GF_request_ctrl(aim,time) then
		entity.set_entity_velocity(aim,v3(0,0,_G_ped_veh_up.value))	
	end
end

function _G_W_de_elevate(aim, time)
	if _GF_request_ctrl(aim,time) then
		entity.set_entity_velocity(aim,v3(0,0,-_G_ped_veh_down.value))
	end
end
------------------Vehicle Movement Self
---------------------------------------
function _GF_veh_boost(self,amp)
	amp = amp or 1
	if not _GF_me_driving(self) then
		if _GF_request_ctrl(self,100) then
			entity.set_entity_max_speed(self,1000)
			vehicle.set_vehicle_forward_speed(self,(entity.get_entity_speed(self)+((_G_self_veh_accel.value*0.11)*amp)))
		end
	else
		entity.set_entity_max_speed(self,1000)
		vehicle.set_vehicle_forward_speed(self,(entity.get_entity_speed(self)+((_G_self_veh_accel.value*0.1)*amp)))
	end
end

function _GF_veh_stop(self,ground)
	ground = ground or false
	if not _GF_me_driving(self) then
		if _GF_request_ctrl(self,1000) then
			vehicle.set_vehicle_forward_speed(self,-_G_self_veh_revers.value)
			if _G_self_veh_revers.value == 0 and ground then
				vehicle.set_vehicle_on_ground_properly(self)
			end
		end
	else
		vehicle.set_vehicle_forward_speed(self,-_G_self_veh_revers.value)
		if _G_self_veh_revers.value == 0 and ground then
			vehicle.set_vehicle_on_ground_properly(self)
		end
	end
end

function _GF_apply_force_up(self)
	if not _GF_me_driving(self) then
		if _GF_request_ctrl(self,1000) then
			entity.apply_force_to_entity(self, 1,0,0, _G_self_veh_up.value,    0, 0, 0,   false, true)
		end
	else
		entity.apply_force_to_entity(self, 1,0,0, _G_self_veh_up.value,    0, 0, 0,   false, true)
	end
end

function _GF_apply_force_down(self)
	if not _GF_me_driving(self) then
		if _GF_request_ctrl(self,1000) then
			entity.apply_force_to_entity(self, 1,0,0, -_G_self_veh_down.value,    0, 0, 0,   false, true)
		end
	else
		entity.apply_force_to_entity(self, 1,0,0, -_G_self_veh_down.value,    0, 0, 0,   false, true)
	end
end
  
---------------------------Vehicle Mods
---------------------------------------
function _GF_missile_antilock(_veh, _bool, _name, _model,time)
	_name = _name or tostring("Vehicle")
	_model = _model or tostring(" ")
	time = time or 1000
	local _action 
	if _bool then
		_action = tostring("removed")
	else
		_action = tostring("given")
	end
	if _GF_request_ctrl(_veh,time) then
		vehicle.set_vehicle_can_be_locked_on(_veh, _bool, true)
		menu.notify("".._name .. " - " .. _model .. "\nAntilock ".._action.."", _G_GeeVer, 4, 2)
	return true
	end
end

function _GF_veh_grav(_veh,bool,_name,_model)
	_name = _name or tostring("Vehicle")
	_model = _model or tostring(" ")
	entity.set_entity_gravity(_veh, bool)
	if bool == true then
		menu.notify("".._name .. " - " .. _model .. " \nGravity given." , _G_GeeVer, 4, 2)
	else
		menu.notify("".._name .. " - " .. _model .. " \nGravity removed." , _G_GeeVer, 4, 2)
	end
end

function _GF_veh_god(_veh,bool,time,_name,_model)
	time = time or 0
	_name = _name or tostring("Vehicle")
	_model = _model or tostring(" ")
	if time > 0 then
		if _GF_request_ctrl(_veh, time) then
			entity.set_entity_god_mode(_veh, bool)
			if bool then
				menu.notify("".._name .. " - " .. _model .. " \nGod given." , _G_GeeVer, 4, 2)
			else 
				menu.notify("".._name .. " - " .. _model .. " \nGod removed." , _G_GeeVer, 4, 2)
			end
			return true
		end
	else
		if bool then
			menu.notify("".._name .. " - " .. _model .. " \nGod given." , _G_GeeVer, 4, 2)
		else 
			menu.notify("".._name .. " - " .. _model .. " \nGod removed." , _G_GeeVer, 4, 2)
		end
		entity.set_entity_god_mode(_veh, bool)
	end
end

function _GF_veh_collision(_veh,bool,_name, _model,_time)
	_time = _time or 1000
	_name = _name or tostring("Vehicle")
	_model = _model or tostring(" ")
	if _GF_request_ctrl(_veh, _time) then
		entity.set_entity_collision(_veh, bool,true)
		if bool == true then
			menu.notify("".._name .. " - " .. _model .. " \nCollision given." , _G_GeeVer, 4, 2)
		else
			menu.notify("".._name .. " - " .. _model .. " \nCollision removed." , _G_GeeVer, 4, 2)
		end
		return true
	end
end

-------------------------Vehicle Repair
---------------------------------------
function _GF_veh_repair_basic(aim,_time,_pid,_bool) --i had to do this in chunks because its a lot of stuff and repair is glitchy in gta and control doesnt always last 
	_bool = _bool or false
	local _1_fire,_2_basic,_3_extra,_4_rot,repaired=false,false,false,false,false
	local time = utils.time_ms() + _time
	local  _name, _model = "Name", "Vehicle"
	if _GF_valid_veh(aim) then
		local speed = entity.get_entity_velocity(aim)
		_name = _GF_veh_ped_name(aim,"first_plyr")
		_model = _GF_model_name(aim)
		while _GF_valid_veh(aim) and utils.time_ms() < time and not repaired do
			system.yield(0)
			if _pid ~= nil then
				_GF_hover_above_player(_pid)
			end
			if not _1_fire and _GF_ask_cntrl(aim) then
				_GF_rpr_fire(aim)
				_1_fire=true
			end
			if _1_fire and not _2_basic and _GF_ask_cntrl(aim) then
				_GF_rpr_basic(aim)
				_2_basic=true
			end
			if _2_basic and not _3_extra and _GF_ask_cntrl(aim) then
				_GF_rpr_extra(aim)
				_3_extra=true
			end
			if _3_extra and not _4_rot and _GF_ask_cntrl(aim) then
				_GF_rpr_rot(aim)
				system.yield(50) --without this the velocity is less likely to apply
				_4_rot=true
			end
			if _4_rot and not repaired and _GF_ask_cntrl(aim) then
				entity.set_entity_velocity(aim,speed)
				repaired=true
			end
		end
	end
	if repaired then
		if _bool then
			menu.notify("".._name .. " - " .. _model .. " \nRepaired." , _G_GeeVer, 4, 2)
		end
		return true
	else
		menu.notify("".._name .. " - " .. _model .. " \nFailed to repair." , _G_GeeVer, 4, 2)
		return false
	end
end

function _GF_rpr_request(_veh,time)
	if _GF_request_ctrl(_veh,time) then
		_GF_rpr_fire(_veh)
		_GF_rpr_basic(_veh)
		_GF_rpr_extra(_veh)
		return true
	end
	return false
end

function _GF_rpr_fire(aim)
	if entity.is_entity_on_fire(aim) then
		fire.stop_entity_fire(aim)
	end
end

function _GF_rpr_basic(aim)
	if streaming.is_model_a_heli(entity.get_entity_model_hash(aim)) then -- just in case i fucked that helo lol
		if not vehicle.is_vehicle_extra_turned_on(aim, 1) then
			vehicle.set_vehicle_extra(aim, 1, 0 == 1)
		end
		if not vehicle.is_vehicle_extra_turned_on(aim, 2) then
			vehicle.set_vehicle_extra(aim, 2, 0 == 1)
		end
		if not vehicle.is_vehicle_extra_turned_on(aim, 7) then
			vehicle.set_vehicle_extra(aim, 7, 0 == 1)
		end
	end
	_GF_tire_pop_simple(aim,false)
	vehicle.set_vehicle_undriveable(aim, false)
	vehicle.set_vehicle_fixed(aim)
	vehicle.set_vehicle_deformation_fixed(aim)
	vehicle.set_vehicle_engine_health(aim, 1000)
	native.call(0x79D3B596FE44EE8B,aim,0.0)--dirt level
end

function _GF_rpr_extra(aim)
	entity.set_entity_gravity(aim, true)
	entity.set_entity_collision(aim, true,false)
	vehicle.set_vehicle_engine_on(aim, true, true, false)
	vehicle.set_vehicle_deformation_fixed(aim)
	vehicle.set_vehicle_bulletproof_tires(aim,true)
	vehicle.set_vehicle_doors_locked(aim, 1)
	vehicle.set_vehicle_doors_locked_for_all_players(aim, false)
	if _GT_plate.style_tog.on then
		vehicle.set_vehicle_number_plate_index(aim, _GT_plate.style_tog.value)
	end
	if _GT_plate.tog.on then
		vehicle.set_vehicle_number_plate_text(aim,_GT_plate.text)
	end
end

function _GF_rpr_rot(aim)
	if vehicle.get_vehicle_class(aim) ~= 15 and vehicle.get_vehicle_class(aim) ~= 16 then
		if not vehicle.is_vehicle_on_all_wheels(aim) then
			entity.set_entity_rotation(aim,v3(0,0,entity.get_entity_heading(aim)))
		end
		if not entity.is_entity_in_air(aim) then
			vehicle.set_vehicle_on_ground_properly(aim)
		end
	elseif not entity.is_entity_in_air(aim) then
		entity.set_entity_rotation(aim,v3(0,0,entity.get_entity_heading(aim)))
		vehicle.set_vehicle_on_ground_properly(aim)
	end
end


-----------------Vehicle Damage/Destroy
---------------------------------------
function _GF_veh_damaged(_veh, _time, _name, _model, _pid,_bool,_notif)
	_name = _name or tostring("Vehicle")
	_model = _model or tostring(" ")
	_bool = _bool or false
	_notif = _notif or false
	local tire_window,health,plate,god=false,false,false,false
	local time = utils.time_ms() + _time
	while utils.time_ms() < time and _GF_valid_veh(_veh) and not plate do
		system.yield(0)
		if _bool then
			_GF_hover_above_player(_pid)
		end
		if entity.get_entity_god_mode(_veh) then
			entity.set_entity_god_mode(_veh, false)
		end
		god = entity.get_entity_god_mode(_veh)
		if not tire_window then
			if not god and _GF_ask_cntrl(_veh) then
				_GF_tire_pop_simple(_veh,true)
				_GF_set_invncbl_wndws(_veh,false)
				_GF_brk_wndws(_veh)
				tire_window=true
			end
		elseif not health then
			if not god and _GF_ask_cntrl(_veh) then
				vehicle.set_vehicle_engine_on(_veh, false, true, true)
				vehicle.set_vehicle_engine_health(_veh, 1)
				native.call(0xB77D05AC8C78AADB,_veh,0) -- set body health
				health=true
			end
		elseif not plate then
			if not _GT_plate.style_tog.on and not _GT_plate.tog.on then 
				plate = true
			elseif _GF_ask_cntrl(_veh) then
				if _GT_plate.style_tog.on then
					vehicle.set_vehicle_number_plate_index(_veh, _GT_plate.style_tog.value)
				end
				if _GT_plate.tog.on then
					vehicle.set_vehicle_number_plate_text(_veh,_GT_plate.text)
				end
				plate=true
			end
		end
	end
	if plate then
		if _notif then
			menu.notify("".._name .. " - " .. _model .. " \nDamaged." , _G_GeeVer, 4, 2)
		end
		return true
	else
		menu.notify("".._name .. " - " .. _model .. " \nFailed to damage." , _G_GeeVer, 4, 2)
	end
end
				
function _GF_veh_damage_or_destroy(_veh, time, _name, _model)
	if _G_gee_watch_destroy.on then
		_GF_veh_destroyed(_veh, time, _name, _model)
	else 
		_GF_veh_damaged(_veh, time, _name, _model)
	end
end

function _GF_veh_destroyed(_veh, time, _name, _model, _pid)
	_pid = _pid or _GF_non_plyr_ped()
	_name = _name or _GF_veh_ped_name(_veh,"first_plyr")
	_model = _model or _GF_model_name(_veh)
	if time > 0 then
		if _GF_request_ctrl(_veh,time) then
			_GF_veh_destroyed_do(_veh, _pid)
			menu.notify("".._name .. " - " .. _model .. " \nDestroyed." , _G_GeeVer, 4, 2)
			return true
		else
			_GF_veh_destroyed_do(_veh, _pid)
			_GF_veh_destroyed_do(_veh, _pid)
			menu.notify("".._name .. " - " .. _model .. " \nFailed to request control.\nTrying to destroy..." , _G_GeeVer, 5, 2)
		end
	else
		_GF_veh_destroyed_do(_veh, _pid)
		menu.notify("".._name .. " - " .. _model .. " \nDestroyed." , _G_GeeVer, 4, 2)
	end
end

function _GF_veh_destroyed_do(_veh, _pid)
	vehicle.set_vehicle_engine_on(_veh, false, false, true)
	vehicle.set_vehicle_engine_health(_veh, -4000)
	native.call(0xB77D05AC8C78AADB,_veh,0) -- set body health
	vehicle.set_vehicle_doors_locked(_veh, 4)
	vehicle.set_vehicle_doors_locked_for_all_players(_veh, true)
	vehicle.set_vehicle_number_plate_text(_veh,"G-Dstroy")
	_GF_veh_tires_popped(_veh, 50, nil, nil,false) --request control again just to ensure godmode is removed
	entity.set_entity_god_mode(_veh, false)
	-- vehicle.add_vehicle_phone_explosive_device(_veh)
	-- vehicle.detonate_vehicle_phone_explosive_device()
	vehicle.set_vehicle_undriveable(_veh, true)
	entity.set_entity_as_no_longer_needed(_veh)
	fire.add_explosion(entity.get_entity_coords(_veh), 0, true, false, 0, _pid)
	--fire.add_explosion(pos, 59, true, false, 0, _pid) -- orbital
	--fire.add_explosion(pos, 60, true, false, 0, _pid) -- bomb standard wide
end
--------------------------Vehicle Tires
---------------------------------------
function _GF_veh_tires_popped(_veh, time, _name, _model, _bool)
	_name = _name or tostring("Vehicle")
	_model = _model or tostring(" ")
	_bool = _bool or false
	if _GF_request_ctrl(_veh,time) then
		_GF_tire_pop_simple(_veh,true)
		if _bool then
			menu.notify("".._name .. " - " .. _model .. " \nTires popped :)" , _G_GeeVer, 4, 2)
		end
	end
end

-- function _GF_get_veh_wheel_list(_veh) -- wheels with tires that can pop have flags of zero even if they are powered. Wack.
	-- local _table = {}
	-- if _GF_valid_veh(_veh) then
		-- for i = 0, 9 do
			-- if _GF_is_a_num(vehicle.get_vehicle_wheel_flags(_veh, i)) and vehicle.get_vehicle_wheel_flags(_veh, i) > 0 then
				-- _table[#_table+1]=i
			-- end
		-- end
	-- end
	-- return _table
-- end

function _GF_tire_pop_simple(_veh,_bool)
--todo add vehicle specific tire pops
-- '0 = wheel_lf / bike, plane or jet front  
-- '1 = wheel_rf  
-- '2 = wheel_lm / in 6 wheels trailer, plane or jet is first one on left  
-- '3 = wheel_rm / in 6 wheels trailer, plane or jet is first one on right  
-- '4 = wheel_lr / bike rear / in 6 wheels trailer, plane or jet is last one on left  
-- '5 = wheel_rr / in 6 wheels trailer, plane or jet is last one on right  
-- '45 = 6 wheels trailer mid wheel left  --shit dont work
-- '47 = 6 wheels trailer mid wheel right  --shit dont work 

	_bool = _bool or false
	vehicle.set_vehicle_tires_can_burst(_veh,_bool)
	for i = 0, 9 do
		if _bool then
			if _GF_get_tire_health(_veh,i) ~= 0.0 then
				vehicle.set_vehicle_tire_burst(_veh, i, true, 1000.0)
				native.call(0x74C68EF97645E79D,_veh, i, 0.0) -- will affect vehicles that wouldnt pop normally such as menacer or hunter
			end
		elseif _GF_get_tire_health(_veh,i) ~= 1000.0 then
			vehicle.set_vehicle_tire_fixed(_veh, i)
			native.call(0x74C68EF97645E79D,_veh, i, 1000.0)
		end
	end
end

-------------------------Vehicle Fucked
---------------------------------------

function _GF_veh_is_fucked(_veh, _time,_bool,_hover,_pid)
	if not _GF_valid_veh(_veh) then
		menu.notify("".._GF_veh_ped_name(_veh,"first_plyr").. " \nVehicle fuck had whiskey-dick :(" , _G_GeeVer, 4, 2)
	else
		_bool = _bool or false
		_hover = _hover or false
		local _1_helo,_2_basic,fucked,rot = false,false,false
		local time = utils.time_ms() + _time
		while utils.time_ms() < time and _GF_valid_veh(_veh) and not fucked do
			system.yield(0)
			if _hover then _GF_hover_above_player(_pid)	end
			if _GF_ask_cntrl(_veh) and entity.get_entity_god_mode(_veh) then
				entity.set_entity_god_mode(_veh, false)
			end
			if _GF_ask_cntrl(_veh) and not entity.get_entity_god_mode(_veh) and not _1_helo then
				if streaming.is_model_a_heli(entity.get_entity_model_hash(_veh)) then -- fuck helos
					vehicle.set_vehicle_extra(_veh, 1, 0)
					vehicle.set_vehicle_extra(_veh, 2, 0)
					vehicle.set_vehicle_extra(_veh, 7, 0)
				end
				_1_helo=true
			end
			if _GF_ask_cntrl(_veh) and not entity.get_entity_god_mode(_veh) and _1_helo and not _2_basic then
				vehicle.set_vehicle_undriveable(_veh, true) -- fuck their vehicle in general
				vehicle.set_vehicle_doors_locked(_veh, 4) -- fuck their doorlocks
				vehicle.set_vehicle_engine_on(_veh,false,true,true) -- fuck there engine. only makes a difference in certain vehicles/situations
				vehicle.set_vehicle_engine_health(_veh, -1000) -- yeah fuck their engine
				_2_basic=true
			end
			if _GF_ask_cntrl(_veh) and not entity.get_entity_god_mode(_veh) and _2_basic and not fucked then
				rot = entity.get_entity_rotation(_veh)
				if entity.is_entity_in_air(_veh) then
					vehicle.set_vehicle_out_of_control(_veh, false, true) -- they are fucked if they crash and kicked out
					rot.x=270
					entity.set_entity_rotation(_veh,rot)
					entity.set_entity_velocity(_veh,v3(0,0,-200)) -- i hope they crash
					entity.apply_force_to_entity(_veh, 1, math.random(100,125), math.random(100,125), -200, 0, 0, 0, false, true) -- i really hope they crash
				else
					vehicle.set_vehicle_out_of_control(_veh, false, true)
					rot.z=math.random(1,360)
					entity.set_entity_rotation(_veh,rot)
					vehicle.set_vehicle_forward_speed(_veh,150)
					entity.apply_force_to_entity(_veh, 1, math.random(50,75), math.random(50,75), -50, 0, 0, 0, false, true)
				end
				fucked=true
			end
		end
		if fucked then
			if _bool then
				menu.notify("".._GF_veh_ped_name(_veh,"first_plyr") .. " - " .. _GF_model_name(_veh) .. " \nVehicle fucked :)" , _G_GeeVer, 4, 2)
			end
			return true
		else
			menu.notify("".._GF_veh_ped_name(_veh,"first_plyr") .. " - " .. _GF_model_name(_veh) .. " \nVehicle fuck had whiskey-dick :(" , _G_GeeVer, 4, 2)
		end
	end
	return false
end

--------------------------Vehicle Speed thanks to keks
---------------------------------------
function _GF_veh_speed(_veh, _time, _name, _model, _bool, _val)
	_name = _name or tostring("Vehicle")
	_model = _model or tostring(" ")
	_bool = _bool or false
	local success=false
	local velocity=false
	local max_speed = 45000
	if _val < 1 then
		max_speed=_val*125
	end
	local time = utils.time_ms() + _time
	if _GF_valid_veh(_veh) then
		local speed = entity.get_entity_velocity(_veh)
		while utils.time_ms() < time and _GF_valid_veh(_veh) and not velocity do
			system.yield(0)
			if not network.has_control_of_entity(_veh) then
				network.request_control_of_entity(_veh)
			else
				if not success then
					entity.set_entity_max_speed(_veh, max_speed)
					vehicle.modify_vehicle_top_speed(_veh, (_val - 1) * 100)
					success=true
				end
				if success and not velocity then
					entity.set_entity_velocity(_veh,speed)
					velocity=true
				end
			end
		end
		if velocity then
			if _bool then
				if _val == -10 then
					menu.notify("".._name .. " - " .. _model .. " \nVehicle changed to reverse :)" , _G_GeeVer, 4, 2)
				else
					menu.notify("".._name .. " - " .. _model .. " \nSpeed/torque changed :)" , _G_GeeVer, 4, 2)
				end
			end
			return true
		elseif _val == -10 then
			menu.notify("".. _name .. " - " .. _model .. "\nFAILED to reverse speed :(", _G_GeeVer, 7, 2)
		else
			menu.notify("".. _name .. " - " .. _model .. "\nFAILED to change speed/torque :(", _G_GeeVer, 7, 2)
		end
	else
		menu.notify("".._name .. " - " .. _model .. " \nPlease try again" , _G_GeeVer, 4, 2)
	end
end

function _GF_veh_freeze(_veh, _time, _name, _model, _freeze, _bool)
	_name = _name or tostring("Vehicle")
	_model = _model or tostring(" ")
	_bool = _bool or false
	local success=false
	local str = "un-freeze"
	local max_speed = 45000
	if _freeze then
		max_speed = 0
		str = "freeze"
	end
	local time = utils.time_ms() + _time
	if _GF_valid_veh(_veh) then
		while utils.time_ms() < time and _GF_valid_veh(_veh) and not success do
			system.yield(0)
			if not network.has_control_of_entity(_veh) then
				network.request_control_of_entity(_veh)
			else
				entity.set_entity_max_speed(_veh, max_speed)
				success=true
			end
		end
		if success then
			if _bool then
				menu.notify("".._name .. " - " .. _model .. "\nVehicle "..str.." successful :)" , _G_GeeVer, 4, 2)
			end
			return true
		else
			menu.notify("".. _name .. " - " .. _model .. "\nFailed to "..str.." :(" , _G_GeeVer, 7, 2)
		end
	else
		menu.notify("".._name .. " - " .. _model .. " \nPlease try again" , _G_GeeVer, 4, 2)
	end
end
--------------------------Vehicle upgrades thanks to keks
---------------------------------------

function _GF_veh_upgr_all_kek(_veh, _time, _notif, _pid,_paint,_neon,_headlights) -- i split this up because once in a while it takes just long enough to perform upgrades that control is lost
	_notif = _notif or false
	_paint = _paint or "random"
	_neon = _neon or "random"
	_headlights = _headlights or "random"
	local _1_basics,_2_perf,_3_wheels,_4_lights,_5_paint,_6_livery,_7_weap,upgraded = false,false,false,false,false,false,false,false
	local  _name, _model = "Name", "Vehicle"
	if _GF_valid_veh(_veh) then
		_name = _GF_veh_ped_name(_veh,"first_plyr")
		_model = _GF_model_name(_veh)
		local speed = entity.get_entity_velocity(_veh)
		if entity.is_entity_dead(_veh) then
			_GF_veh_repair_basic(_veh, _time)
		end
		local time = utils.time_ms() + _time
		while _GF_valid_veh(_veh) and (utils.time_ms() < time) and not upgraded do
			system.yield(0)
			if _GF_valid_pid(_pid) then
				_GF_hover_above_player(_pid)
			end
			if not _1_basics and _GF_ask_cntrl(_veh) then 				--basics
				vehicle.set_vehicle_mod_kit_type(_veh, 0) --upgrades wont take without this on spawned vehicles
				_GF_veh_upgr_basic(_veh)
				_1_basics=true
			end
			if _1_basics and not _2_perf and _GF_ask_cntrl(_veh) then 	--performance
				_GF_veh_upgr_perf(_veh)
				_2_perf=true
			end
			if _2_perf and not _3_wheels and _GF_ask_cntrl(_veh) then 	--wheels/tires
				_GF_veh_upgr_wheels(_veh)			
				_3_wheels=true
			end
			if _3_wheels and not _4_lights and _GF_ask_cntrl(_veh) then --headlights/neons
				_GF_veh_upgr_lights(_veh,_headlights)
				_GF_veh_upgr_neons(_veh,_neon)
				_4_lights=true
			end
			if _4_lights and not _5_paint and _GF_ask_cntrl(_veh) then 	--paint
				_GF_veh_upgr_paint(_veh,_paint)
				_5_paint=true
			end
			if _5_paint and not _6_livery and _GF_ask_cntrl(_veh) then 	--livery
				_GF_veh_upgr_livery(_veh)
				_6_livery=true
			end
			if _6_livery and not _7_weap and _GF_ask_cntrl(_veh) then 	--weapons
				_GF_veh_best_weap(_veh)
				_GF_veh_upgrades_kek_bombs_simple(_veh)
				_GF_veh_upgrades_kek_countrm_simple(_veh)
				system.yield(50)
				_7_weap=true
			end
			if _7_weap and not upgraded and _GF_ask_cntrl(_veh) then 	--plate/speed
				if _GT_plate.style_tog.on then
					vehicle.set_vehicle_number_plate_index(_veh, _GT_plate.style_tog.value)
				end
				if _GT_plate.tog.on then
					vehicle.set_vehicle_number_plate_text(_veh,_GT_plate.text)
				end
				entity.set_entity_velocity(_veh,speed)
				upgraded=true
			end
		end
	end
	if upgraded then
		if _notif then
			menu.notify("".._name.. " - " .._model.. " \nUpgraded." , _G_GeeVer, 4, 2)
		end
		return true
	else
		menu.notify("".._name.. " - " .._model.. " \nFailed to Upgrade." , _G_GeeVer, 4, 2)
		return false
	end
end

function _GF_nil_name(_name)
	if _name == nil then
		return "Name"
	else
		return _name
	end
end

function _GF_nil_model_name(_name)
	if _name == nil then
		return "Vehicle"
	else
		return _name
	end
end

function _GF_veh_upgr_one_kek(_veh, _time, _action, _notif, _pid,_paint,_neon,_headlights)
	_notif = _notif or false
	local do_once,upgraded = false,false
	local _action_string = "action"
	local time = utils.time_ms() + _time
	local  _name, _model = "Name", "Vehicle"
	if _GF_valid_veh(_veh) then
		_name = _GF_veh_ped_name(_veh,"first_plyr")
		_model = _GF_model_name(_veh)
		local speed = entity.get_entity_velocity(_veh)
		while utils.time_ms() < time and  _GF_valid_veh(_veh) and not upgraded do
			system.yield(0)
			if _GF_valid_pid(_pid) then
				_GF_hover_above_player(_pid)
			end
			if not do_once then
				if _GF_ask_cntrl(_veh) then
					if _action=="perf" then  --performance
						_GF_veh_upgr_perf(_veh)
						_action_string="Performance mods"
					elseif (_action=="wheels" or _action=="f1") then --wheels/tires
						_GF_veh_upgr_wheels(_veh,_action)	
						if _action == "wheels" then 
							_action_string="Wheels/Tires"
						else
							_action_string="F1 Wheels/Tires (If possible)"
						end
					elseif _action=="headlights" then --headlights
						_GF_veh_upgr_lights(_veh,_headlights)
						_action_string="Headlights"
					elseif _action=="neons" then --neons
						_GF_veh_upgr_neons(_veh,_neon)
						_action_string="Neon lights"
					elseif _action=="paint" then --paint
						_GF_veh_upgr_paint(_veh,_paint)
						_action_string="Paintjob"
					elseif _action=="livery" then --livery
						_GF_veh_upgr_livery(_veh)
						_action_string="Livery (If possible)"
					elseif _action=="weapons" then --weapons
						_GF_veh_best_weap(_veh)
						_GF_veh_upgrades_kek_bombs_simple(_veh)
						_GF_veh_upgrades_kek_countrm_simple(_veh)
						_action_string="Weapons (If possible)"
					end
					system.yield(50)
					do_once=true
				end
			elseif not upgraded and _GF_ask_cntrl(_veh) then --plate /speed
				vehicle.set_vehicle_number_plate_index(_veh, 1)
				vehicle.set_vehicle_number_plate_text(_veh,"Gee-Skid")
				entity.set_entity_velocity(_veh,speed)
				upgraded=true
			end
		end
	end
	if upgraded then
		if _notif then
			menu.notify("".._name .. " - " .. _model .. " \n" .. _action_string .. " - Success." , _G_GeeVer, 4, 2)
		end
		return true
	else
		menu.notify("".._name .. " - " .. _model .. " \nUpgrade - FAILED." , _G_GeeVer, 4, 2)
		return false
	end
end


function _GF_veh_upgr_basic(_veh)
	local toggle_vehicle_mods = {unk1 = 17,unk2 = 19, unk3 = 21,turbo = 18, tire_smoke = 20, xenon_lights = 22}
	for i = 0, 65 do
		if vehicle.get_num_vehicle_mods(_veh, i) > 0 and not (i == 48) and not (i == 23) and not (i == 24) and not (i == 62) then
			vehicle.set_vehicle_mod(_veh, i, math.random(0, vehicle.get_num_vehicle_mods(_veh, i) - 1))
		end
	end
	_GF_armor_best_simple(_veh)
	for _, mod in pairs(toggle_vehicle_mods) do
		vehicle.toggle_vehicle_mod(_veh, mod, true)
	end
	if not streaming.is_model_a_heli(entity.get_entity_model_hash(_veh)) then -- Prevent removal of heli rotors
		for i = 1, 9 do
			if vehicle.does_extra_exist(_veh, i) then
				vehicle.set_vehicle_extra(_veh, i, math.random(0, 1) == 1)
			end
		end
	end
end

function _GF_veh_upgr_perf(_veh)
	local performance_mods = {engine = 11,brakes = 12,transmission = 13,suspension = 15,armor = 16}
	for _, mod in pairs(performance_mods) do
		vehicle.set_vehicle_mod(_veh, mod, vehicle.get_num_vehicle_mods(_veh, mod) - 1)
	end
	vehicle.toggle_vehicle_mod(_veh, 18, true)--turbo
end

function _GF_veh_upgr_wheels(_veh,_f1)	
	local class,wheel = vehicle.get_vehicle_class(_veh)
	if class == 8 then
		if math.random(1,7) == 1 then
			vehicle.set_vehicle_wheel_type(_veh, 6) -- chrome
		else
			vehicle.set_vehicle_wheel_type(_veh, -1)
		end
	elseif _f1=="f1" then
		vehicle.set_vehicle_wheel_type(_veh, 10)
	else
		vehicle.set_vehicle_wheel_type(_veh, math.random(0, 12))
	end
	wheel = math.random(0, vehicle.get_num_vehicle_mods(_veh, 23) - 1)
	vehicle.set_vehicle_custom_wheel_colour(_veh, math.random(10^8, 10^10))
	vehicle.set_vehicle_tire_smoke_color(_veh, math.random(0, 255), math.random(0, 255), math.random(0, 255))
	if vehicle.get_num_vehicle_mods(_veh, 23) > 0 then
		vehicle.set_vehicle_mod(_veh, 23, wheel,true)
	end
	if vehicle.get_num_vehicle_mods(_veh, 24) > 0 then
		vehicle.set_vehicle_mod(_veh, 24, wheel,true)
	end
	if class ~= 8 and vehicle.get_num_vehicle_mods(_veh, 62) > 0 then
		vehicle.set_vehicle_mod(_veh, 62, math.random(0, vehicle.get_num_vehicle_mods(_veh, 62) - 1),true)
		--set_vehicle_mod(Vehicle vehicle, 62, int modIndex, bool customTires)
	end
	_GF_tire_pop_simple(_veh,false)
end

local headlight_color_prev = 0
function _GF_veh_upgr_lights(_veh,_color)
	_color = _color or "random"
	vehicle.set_vehicle_fullbeam(_veh, true)
	vehicle.toggle_vehicle_mod(_veh, 22, true) -- xenon enabled. Not sure if needed but i think so
	if _color == "random" then
		local good_color,headlight_color=false
		repeat
			headlight_color = math.random(0,12)
			if headlight_color ~= headlight_color_prev then
				headlight_color_prev=headlight_color
				good_color=true
			end
		until good_color
	else
		headlight_color_prev=_color
	end
	vehicle.set_vehicle_headlight_color(_veh,headlight_color_prev)
end

local neon_light_color_prev = 4292796159
function _GF_veh_upgr_neons(_veh,_neon)
	_neon = _neon or "random"
	for i=0,5 do
		vehicle.set_vehicle_neon_light_enabled(_veh, i-1, true)
	end
	if _neon == "random" then
		local good_neon_color=false
		local neon_light_color,neon_color_rand
		repeat
			neon_color_rand = math.random(1,13)
			neon_light_color =	_GT_neon_list_int[neon_color_rand]
			if neon_light_color ~= neon_light_color_prev then
				neon_light_color_prev=neon_light_color
				good_color=true
			end
		until good_color
	else
		neon_light_color_prev = _neon
	end
	vehicle.set_vehicle_neon_lights_color(_veh, neon_light_color_prev)
end

function _GF_veh_upgr_paint(_veh,_paint)
	local color,color2,rand
	_paint = _paint or "random"
	if _paint == "random" then
		rand=math.random(1,#_GT_paint_list_int+5)
		if rand > #_GT_paint_list_int then
			color = math.random(10^8, 10^10)
		else
			color = _GT_paint_list_int[rand]
		end
		vehicle.set_vehicle_custom_primary_colour(_veh, color)
		rand=math.random(1,#_GT_paint_list_int+5)
		if rand > #_GT_paint_list_int then
			color = math.random(10^8, 10^10)
		else
			color = _GT_paint_list_int[rand]
		end
		vehicle.set_vehicle_custom_secondary_colour(_veh, color)
		vehicle.set_vehicle_custom_pearlescent_colour(_veh, math.random(0, math.random(10^8, 10^10)))
		rand=math.random(1,#_GT_paint_list_int+5)
		if rand > #_GT_paint_list_int then
			color = math.random(10^8, 10^10)
		else
			color = _GT_paint_list_int[rand]
		end
		rand=math.random(1,#_GT_paint_list_int+5)
		if rand > #_GT_paint_list_int then
			color2 = math.random(10^8, 10^10)
		else
			color2 = _GT_paint_list_int[rand]
		end
		vehicle.set_vehicle_extra_colors(_veh, color, color2)
	elseif _paint == "random_solid" then
		rand=math.random(1,#_GT_paint_list_int+5)
		if rand > #_GT_paint_list_int then
			color = math.random(10^8, 10^10)
		else
			color = _GT_paint_list_int[rand]
		end
		vehicle.set_vehicle_custom_primary_colour(_veh, color)
		vehicle.set_vehicle_custom_secondary_colour(_veh, color)
		vehicle.set_vehicle_custom_pearlescent_colour(_veh, color)
		vehicle.set_vehicle_extra_colors(_veh, color, color)
	else
		color = _paint
		vehicle.set_vehicle_custom_primary_colour(_veh, color)
		vehicle.set_vehicle_custom_secondary_colour(_veh, color)
		vehicle.set_vehicle_custom_pearlescent_colour(_veh, color)
		vehicle.set_vehicle_extra_colors(_veh, color, color)
	end
		
	--vehicle.set_vehicle_custom_pearlescent_colour(_veh, math.random(0, math.random(10^8, 10^10)))
end

_GT_neon_list_int = {
4292796159, -- white
4278326783, -- blue
4278408191, -- elec blue
4278255500, -- mint green
4284415745, -- lime green
4294967040, -- yellow
4294940165, -- golden shower
4294917632, -- orange
4294902017, -- red
4294914660, -- pony pink
4294903230, -- hot pink
4280484351, -- purple
4279174143  -- black light
}

_GT_neon_list_name = {
"White",
"Blue",
"Electric Blue",
"Mint Green",
"Lime Green",
"Yellow",
"Golden Shower",
"Orange",
"Red",
"Pony Pink",
"Hot Pink",
"Purple",
"Black Light"
}

_GT_paint_list_int = {
16777215,	--Pure white
13487565,	--White
10197915,	--Cream
5066061,	--Grey
0,			--Black
15767961,	--Pastel Pink
13317780,	--Pink
14692914,	--Pink/Red
3014656,	--Wine Red
7346457,	--Red
16711680,	--Bright Red
16761514,	--salmon
56306,		--bright blue
6141669,	--Light Blue
3103859,	--Teal
18309,      --royal blue
16706473,	--Cream Yellow
15779920,	--Yellow
8284969,	--Mustard
16757504,	--Bright yellow
16750350,	--Schoolbus
8340010,	--Dark Orange
12183225,	--Cream Green
7523442,	--Light Green
2803792,	--Bright Green
3761721,	--Dark Green
12628975,	--Cream Purple
8677090,	--Bright Purple
4405615,	--Dark Purple
}

_GT_paint_list_name = {
"Pure white",
"White",
"Cream",
"Grey",
"Black",
"Pastel Pink",
"Pink",
"Pink/Red",
"Wine Red",
"Red",
"Bright Red",
"Salmon",
"Bright Blue",
"Light Blue",
"Teal",
"Royal Blue",
"Cream Yellow",
"Yellow",
"Mustard",
"Bright yellow",
"Schoolbus",
"Dark Orange",
"Cream Green",
"Light Green",
"Bright Green",
"Dark Green",
"Cream Purple",
"Bright Purple",
"Dark Purple",
}

function _GF_veh_upgr_livery(_veh)
	if vehicle.get_num_vehicle_mods(_veh, 48) > 0 then
		vehicle.set_vehicle_mod(_veh, 48, math.random(1, vehicle.get_num_vehicle_mods(_veh, 48) - 1))
	end
end

function _GF_veh_upgrades_kek_bombs_simple(_veh)
	if _G_table_bomb_plane_models[entity.get_entity_model_hash(_veh)] then --cluster
		vehicle.set_vehicle_mod(_veh, 9, 3)
	end
end

function _GF_veh_upgrades_kek_countrm_simple(_veh)
	if _G_table_countrm_models[entity.get_entity_model_hash(_veh)] then -- chaff
		if _GF_is_this_veh(_veh,"oppressor2") then
			vehicle.set_vehicle_mod(_veh, 6, 0)
		else
			vehicle.set_vehicle_mod(_veh, 1, 0)
		end
	end
end

function _GF_veh_best_weap(_veh)
	if _GF_valid_veh(_veh) then
		if _GF_is_this_veh(_veh,"speedo4") or _GF_is_this_veh(_veh,"apc") then
			vehicle.set_vehicle_mod(_veh, 10, 2)
		else
			if vehicle.get_num_vehicle_mods(_veh, 10) == 1 then
				vehicle.set_vehicle_mod(_veh, 10, 0)
			else
				vehicle.set_vehicle_mod(_veh, 10, 1)
			end
		end
		if _GF_is_this_veh(_veh,"khanjali") then
			vehicle.set_vehicle_mod(_veh, 5, vehicle.get_num_vehicle_mods(_veh, 5) - 1)
		end
		vehicle.set_vehicle_mod(_veh, 45, vehicle.get_num_vehicle_mods(_veh, 45) - 1)
		if _GF_is_this_veh(_veh,"tampa3") then
			vehicle.set_vehicle_mod(_veh, 1, vehicle.get_num_vehicle_mods(_veh, 1) - 1)
			vehicle.set_vehicle_mod(_veh, 2, vehicle.get_num_vehicle_mods(_veh, 2) - 1)
		end
		vehicle.set_vehicle_mod(_veh, 9, vehicle.get_num_vehicle_mods(_veh, 9) - 1)
	end
end

function _GF_weap_worst_simple(_veh)
	if _GF_valid_veh(_veh) then
		if vehicle.get_num_vehicle_mods(_veh, 10) == 1 then
			vehicle.set_vehicle_mod(_veh, 10, 1)
		elseif vehicle.get_num_vehicle_mods(_veh, 10) == 2 then
			vehicle.set_vehicle_mod(_veh, 10, 2)
		else
			vehicle.set_vehicle_mod(_veh, 10, 0)
		end
		if _GF_is_this_veh(_veh,"khanjali") then
			vehicle.set_vehicle_mod(_veh, 5, -1)
		end
		vehicle.set_vehicle_mod(_veh, 45, -1)
		if _GF_is_this_veh(_veh,"tampa3") then
			vehicle.set_vehicle_mod(_veh, 1, -1)
			vehicle.set_vehicle_mod(_veh, 2, -1)
			
		end
		vehicle.set_vehicle_mod(_veh, 9, -1)
	end
end

--mk1 10,0 homing--mk1 10,1 machine guns
--mk2 10,0 Explosive mg--mk2 10,1 homing--mk2 10,2 machine guns
--avenger 10,0 front--avenger 10,1 all--avenger 10,2 none
--deluxo 10,0 all weap--deluxo 10,1 no weap
--tampa 10,0 double gun on top--tampa 10,1 fixed gun--tampa 1, -1 removes missile--tampa 2, -1 removes mortar
--sparrow 10,0 machine guns--sparrow 10,1 homing--sparrow 10,2 no weap
--only machine gun vehicles 45,-1 no weap
--vehicles with mines 9,-1 removes mine
--khanjali 5, -1 removes grenades
--tampa 1, -1 removes missile--tampa 2, -1 removes mortar

function _GF_armor_best_simple(_veh)
	if _GF_valid_veh(_veh) then
		vehicle.set_vehicle_mod(_veh, 16, vehicle.get_num_vehicle_mods(_veh, 16) - 1)
		if not _GF_is_this_veh(_veh,"rhino") and not _GF_is_this_veh(_veh,"khanjali") then 
			vehicle.set_vehicle_mod(_veh, 5, vehicle.get_num_vehicle_mods(_veh, 5) - 1)
		end
		if _GF_is_this_veh(_veh,"tampa3") then
			vehicle.set_vehicle_mod(_veh, 7, vehicle.get_num_vehicle_mods(_veh, 7) - 1)
		end
	end
end

function _GF_armor_worst_simple(_veh)
	if _GF_valid_veh(_veh) then
		vehicle.set_vehicle_mod(_veh, 16, -1)
		if not _GF_is_this_veh(_veh,"rhino") and not  _GF_is_this_veh(_veh,"khanjali") then
			vehicle.set_vehicle_mod(_veh, 5, -1)
		end
		if _GF_is_this_veh(_veh,"tampa3") then
			vehicle.set_vehicle_mod(_veh, 7,  -1)
		end
	end
end
--tampa 5, -1 removes plating
--tampa 7, -1 removes hood plate

_G_table_bomb_plane_models = {
    [gameplay.get_hash_key("cuban800")] = true,
    [gameplay.get_hash_key("mogul")] = true,
    [gameplay.get_hash_key("rogue")] = true,
    [gameplay.get_hash_key("starling")] = true,
    [gameplay.get_hash_key("seabreeze")] = true,
    [gameplay.get_hash_key("tula")] = true,
    [gameplay.get_hash_key("bombushka")] = true,
    [gameplay.get_hash_key("hunter")] = true,
    [gameplay.get_hash_key("avenger")] = true,
    [gameplay.get_hash_key("akula")] = true,
    [gameplay.get_hash_key("volatol")] = true,
	[gameplay.get_hash_key("strikeforce")] = true,
}

_G_table_countrm_models = {
    [gameplay.get_hash_key("mogul")] = true,
    [gameplay.get_hash_key("rogue")] = true,
    [gameplay.get_hash_key("starling")] = true,
    [gameplay.get_hash_key("seabreeze")] = true,
    [gameplay.get_hash_key("tula")] = true,
    [gameplay.get_hash_key("bombushka")] = true,
    [gameplay.get_hash_key("hunter")] = true,
    [gameplay.get_hash_key("nokota")] = true,
    [gameplay.get_hash_key("pyro")] = true,
    [gameplay.get_hash_key("molotok")] = true,
    [gameplay.get_hash_key("havok")] = true,
    [gameplay.get_hash_key("alphaz1")] = true,
    [gameplay.get_hash_key("microlight")] = true,
    [gameplay.get_hash_key("howard")] = true,
    [gameplay.get_hash_key("avenger")] = true,
    [gameplay.get_hash_key("thruster")] = true,
    [gameplay.get_hash_key("volatol")] = true,
	[gameplay.get_hash_key("oppressor2")] = true,
	[gameplay.get_hash_key("strikeforce")] = true,
}