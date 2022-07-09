-- GeeSkid v1.02
-------------Teleport into plyr vehicle
---------------------------------------

function _GF_GW_board(_vk_key,_veh)
	local function board(_veh,_type)
		if _type == 0 then
			if not _GF_tp_into_free_seat(_veh) then
				menu.notify("No free seat :(",_G_GeeVer,4,2)
			end
		elseif _type == 1 then
			if not _GF_tp_into_free_seat(_veh) then
				if not _GF_veh_hijack(_veh) then
					menu.notify("No free seat\nFailed to hijack :(",_G_GeeVer,4,2)
				end
			end
		elseif not _GF_veh_hijack(_veh) then
			menu.notify("Failed to hijack :(",_G_GeeVer,4,2)
		end
	end
	for i=1,3 do
		if _GF_vk_key_down(_vk_key) or _GF_key_active(114,1) then --delay added to reduce chance of firing missiles in the vehicle when you enter
			system.yield(50)
		else
			break
		end
	end
	local plyr = nil
	if _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, -1)) then
		plyr = ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, -1))
	end
	if plyr then
		board(_veh,_G_gee_watch_passenger.value)
	elseif plyr == false then
		board(_veh,_G_gee_watch_passenger_npc.value)
	else
		board(_veh,1)
	end
end


function _GF_tp_into_free_seat(_veh)
	if _GF_valid_veh(_veh) then
		local me=player.player_id()
		local my_ped=player.get_player_ped(me)
		for i = 1,_GF_veh_seats(_veh) do
			if _GF_no_one_in_seat(_veh, i-2) then
				ped.set_ped_into_vehicle(my_ped,_veh,i-2)	
				break
			elseif _GF_remove_dead_ped_from_seat(_veh,i-2) then
				ped.set_ped_into_vehicle(my_ped,_veh,i-2)	
				break
			end
		end
		system.yield(100)
		if _GF_me_in_that_veh(_veh) then
			return true
		end
	end
	return false
end

function _GF_tp_in_out_closest_veh(_action,_speed,_key,_delay)
	if _GF_vk_key_down(_key) and _GF_key_active(114,0) then ---no right click to prevent geewatch board intererence
		local long_enough=false
		local time = utils.time_ms() + _delay
		while _GF_vk_key_down(_key) and _GF_key_active(114,0) and not long_enough do
			system.yield(0)
			if time < utils.time_ms() then
				long_enough=true
			end
		end
		if long_enough then
			if not _GF_me_in_any_veh() then
				local all_veh=vehicle.get_all_vehicles()
				_GF_sort_xyz_ent(all_veh,player.get_player_coords(player.player_id()))
				if _action == 0 then
					_GF_tp_into_free_seat(all_veh[1])
				elseif _action == 1 then
					_GF_veh_hijack(all_veh[1],true)
				elseif _action == 2 then
					if not _GF_tp_into_free_seat(all_veh[1]) then
						_GF_veh_hijack(all_veh[1],true)
					end
				end
			else
				local me=player.player_id()
				local speed=entity.get_entity_velocity(player.get_player_vehicle(me))
				local heading = player.get_player_heading(me)
				local height = 0.69 -- nice
				if vehicle.get_vehicle_class(player.get_player_vehicle(me)) == 15 then
					height = -0.45
				end
				if _GF_me_in_seat(player.get_player_vehicle(me),-1) or _GF_me_in_seat(player.get_player_vehicle(me),1) or _GF_me_in_seat(player.get_player_vehicle(me),3) then
					heading = heading - 90
				else
					heading = heading + 90
				end
				entity.set_entity_coords_no_offset(player.get_player_ped(me), _GF_front_of_pos(entity.get_entity_coords(player.get_player_vehicle(me)),heading,1.35,1,height)) -- TPs you beside the vehicle
				system.yield(50)
				if _speed == 1 then
					entity.set_entity_velocity(player.get_player_ped(me), speed*0.69) --nice    50% doesnt seem like 50%
				elseif _speed == 2 then
					entity.set_entity_velocity(player.get_player_ped(me), speed)
				end
			end
			_GF_vk_key_down_with_delay(_key)
		end
	end
end

function _GF_closest_vehs()
	local all_veh=vehicle.get_all_vehicles()
	_GF_sort_xyz_ent(all_veh,player.get_player_coords(player.player_id()))
	return all_veh
end

function _GF_veh_hijack(_veh,_bool)
	local me=player.player_id()
	local time = utils.time_ms() + 250
	_bool = _bool or true
	if _GF_valid_veh(_veh) then
		if _GF_no_one_in_seat(_veh,-1) then
			ped.set_ped_into_vehicle(player.get_player_ped(me),_veh,-1)
			return true
		elseif not _GF_me_driving(_veh) then
			ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(_veh, -1))
			while _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, -1)) and utils.time_ms() < time do
				system.yield(0)
			end
			if _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, -1)) then
				if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, -1)) and _bool then
					_GF_veh_kick_script(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, -1)))
				end
				ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(_veh, -1))
			end
			time = utils.time_ms() + 500
			while _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, -1)) and utils.time_ms() < time do
				system.yield(0)
			end
			if _GF_no_one_in_seat(_veh,-1) then
				ped.set_ped_into_vehicle(player.get_player_ped(me),_veh,-1)
				system.yield(100)
			end
			if _GF_me_driving(_veh) then
				return true
			end
		end
	end
	return false
end

function _GF_plyr_veh_do(_table,_pid,_name,_my_pos,_plyr_pos)
	local intrr,no_veh = 0,0
	local continue = true
	if _GF_is_pid_intrr(_pid) then
		continue = false
		if #_table==1 then
			menu.notify("".._name .. "" .. "" .. "\nIn interior.", _G_GeeVer, 4, 2)
		end
		intrr=intrr+1
	elseif _GF_dist_pos_pos(_my_pos,_plyr_pos) < 250 and not player.is_player_in_any_vehicle(_pid) then
		continue = false
		if #_table==1 then
			menu.notify("".._name .. "" .. "" .. "\nNot in a vehicle.", _G_GeeVer, 4, 2)
		end
		no_veh=no_veh+1
	elseif _plyr_pos.z < -75 then
		continue = false
		if #_table==1 then
			menu.notify("".._name .. "" .. "" .. "\nProbably in interior.", _G_GeeVer, 4, 2)
		end
		intrr=intrr+1
	end
	return intrr,no_veh,continue
end

function _GF_plyr_veh_tp_into(_table,_action,_bypass,_rand)
	_rand = _rand or false
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	local name = "Name"
	local model_name = "Vehicle"
	local my_orig_pos = player.get_player_coords(me)
	local plyr_veh,intrr,no_veh,unable,count = 0,0,0,0,0
	local i_tried,stay_there,i_hovered = false,false,false
	local _pid
	_GF_hover_back_record()
	for i=1,#_table do
		_pid = _table[i]
		local attempt,continue=false,false
		if _GF_valid_pid(_pid) then
			if _pid ~= me then
				continue = true
			else
				if _action == 0 then
					continue = true
				elseif _action == 1 then
					menu.notify("".. _GF_plyr_name(me) .. "\nYou cant steal your own seat LOL", _G_GeeVer, 4, 2)
				elseif _action == 2 and _GF_me_in_seat(_GT_plyr_info.veh[_pid+1],-1) then
					menu.notify("".. _GF_plyr_name(me) .. "\nYou cant hijack yourself LOL", _G_GeeVer, 4, 2)
				else
					continue = true
				end
			end
			if continue then
				continue=false
				count=count+1
				local my_pos = player.get_player_coords(me)
				local plyr_pos = player.get_player_coords(_pid)
				name = _GF_plyr_name(_pid)
				local intrr_count,no_veh_count = 0,0
				intrr_count,no_veh_count,continue = _GF_plyr_veh_do(_table,_pid,name,my_pos,plyr_pos)
				intrr=intrr+intrr_count
				no_veh=no_veh+no_veh_count
				if continue then
					i_tried = true
					stay_there = false
					attempt=true
					local do_once,stop = false,false
					local time = utils.time_ms() + 2000
					local wait_time = utils.time_ms() + 750
					local stop_time = utils.time_ms() + 1750
					local plyr_seat = -2
					local plyr_driver
					plyr_veh = 0
					while _GF_valid_pid(_pid) and (utils.time_ms() < time) and not stay_there and not stop do
						system.yield(0)
						if player.is_player_in_any_vehicle(_pid) then
							plyr_veh = player.get_player_vehicle(_pid)
						elseif #_table == 1 then
							if _GT_plyr_info.tp_sett[_pid+1] == true or _bypass then
								i_hovered = true
							else
								stop=true
							end
						else
							i_hovered = true
						end
						if i_hovered and not stay_there and not stop then
							_GF_hover_above_player(_pid)
						end
						if plyr_veh ~= 0 then
							model_name = _GF_model_name(plyr_veh)
							if _action == 0 then
								if _GF_tp_into_free_seat(plyr_veh) then
									stay_there=true
									system.yield(100)
								end
							elseif _action == 1 then
								if plyr_seat == -2 then
									plyr_seat = _GF_what_seat_plyr_in(plyr_veh,_pid)
								end
								if plyr_seat > -2 then
									if not do_once then
										_GF_veh_kick_script(_pid)
										do_once=true
										wait_time = utils.time_ms() + 300
									end
									if utils.time_ms() > wait_time and vehicle.get_ped_in_vehicle_seat(plyr_veh, plyr_seat) == player.get_player_ped(_pid) then 
										ped.clear_ped_tasks_immediately(player.get_player_ped(_pid))
									end
									if _GF_no_one_in_seat(plyr_veh,plyr_seat) then
										ped.set_ped_into_vehicle(my_ped,plyr_veh,plyr_seat)
										menu.notify("".. name .. " - " .. model_name .. "\nSeat stolen :)", _G_GeeVer, 4, 2)
										stay_there=true
									end
								end
							elseif _action == 2 then
								if _GF_no_one_in_seat(plyr_veh,-1) then
									ped.set_ped_into_vehicle(my_ped,plyr_veh,-1)
									menu.notify("".. name .. " - " .. model_name .. "\nHijacking! :)", _G_GeeVer, 4, 2)
									stay_there=true
								else
									if not do_once and ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(plyr_veh, -1)) then
										plyr_driver=vehicle.get_ped_in_vehicle_seat(player.get_player_vehicle(_pid), -1)
										_GF_veh_kick_script(player.get_player_from_ped(plyr_driver))
										do_once=true
										wait_time = utils.time_ms() + 300
									end
									if utils.time_ms() > wait_time and not _GF_no_one_in_seat(plyr_veh,-1) then 
										ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(plyr_veh, -1))
									end
								end
							end
						elseif utils.time_ms() > stop_time then
							no_veh=no_veh+1
							stop=true
						end
					end
					if plyr_veh ~= 0 then
						unable=unable+1
					end
				end
			end
		end
		if stay_there then
			break
		elseif attempt then
			if plyr_veh ~= 0 then
				if _action == 0 then
					menu.notify("".. name .. "\nNo free seat :(", _G_GeeVer, 4, 2)
				elseif _action == 1 then
					menu.notify("".. name .. "\nCould NOT steal seat :(", _G_GeeVer, 4, 2)
				elseif _action == 2 then
					menu.notify("".. name .. "\nUnable to hijack! :(", _G_GeeVer, 4, 2)
				end
			elseif #_table == 1 then
				if _GT_plyr_info.tp_sett[_pid+1] == false then
					menu.notify("".. name .. "\nNo vehicle. Try enabling force check.", _G_GeeVer, 5, 2)
				else
					menu.notify("".. name .. "\nNo vehicle.", _G_GeeVer, 5, 2)
				end
			end
		end
	end
	if i_tried then
		if not stay_there then
			if count > 1 then
				menu.notify(""..count.." players checked.\n"..intrr.." were in interior.\n"..no_veh.." had no vehicle.\n"..unable.." vehicles could not be TP'd into.",_G_GeeVer,10,2)
			end
			if i_hovered then
				_GF_hover_back_to_pos()
			end
		else
			system.yield(500)
			if not _GF_me_in_that_veh(plyr_veh) then
				_GF_tp_into_free_seat(plyr_veh)
			end
			if _rand then
				_G_rand_pid_last=_pid
			end
		end
	elseif count > 1 then
		menu.notify(""..count.." players checked.\n"..intrr.." were in interior.\n"..no_veh.." had no vehicle.\n"..unable.." vehicles could not be TP'd into.",_G_GeeVer,10,2)
	end
	_GF_H_var_default()
end

function _GF_tp_forward(_pos,_heading)
	local dist = 20.69
	local pos_front = _GF_front_of_pos(_pos, _heading, dist, 180, 0)
	local new_pos_front =_GF_pos_nearby(pos_front,"single_closest",100,"water")
	local found = false
	if _GF_dist_xy_pospos(pos_front,new_pos_front) < dist*.69 then
		found=true
	else
		for i=1,7 do
			dist = dist*1.469
			pos_front = _GF_front_of_pos(_pos, _heading, dist, 180, 0)
			new_pos_front =_GF_pos_nearby(pos_front,"single_closest",100,"water")
			if _GF_dist_xy_pospos(pos_front,new_pos_front) < dist*.69 then --nice
				found=true
				break
			end
		end
	end
	return found, new_pos_front
end

function _GF_tp_self_to_pid(_pid, _where)
	local name = _GF_plyr_name(_pid)
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	local pos = player.get_player_coords(_pid)
	if _GT_plyr_info.interior[_pid+1] == true then
		menu.notify(""..name .. "" .. "" .. "\nIn interior.", _G_GeeVer, 4, 2)
	elseif _where == "nearby" then
		pos = _GF_pos_nearby(pos,"single_50_dist",100,"water")
		if _GF_me_in_any_veh() then
			if not _GF_ent_tp(_GT_plyr_info.veh[me+1],pos, 0 ,false) then
				menu.notify("Failed to get control of vehicle :(", _G_GeeVer, 4, 2)
			end
		else
			entity.set_entity_coords_no_offset(my_ped,pos)
		end
	elseif _GF_dist_me_pid(_pid) < 300 or pos.z > 0 then
		if _where == "on_top" then
			pos.z=pos.z+3
		elseif _where == "behind" then
			pos = _GF_front_of_pos(pos,player.get_player_heading(_pid),5,0,1)
		end
		if _GF_me_in_any_veh() then
			if not _GF_ent_tp(_GT_plyr_info.veh[me+1],pos, 0 ,false) then
				menu.notify("Failed to get control of vehicle :(", _G_GeeVer, 4, 2)
			end
		else
			entity.set_entity_coords_no_offset(my_ped,pos)
		end
	elseif _GF_me_in_any_veh() then
		if not _GF_request_ctrl(_GT_plyr_info.veh[me+1],500) then
			menu.notify("Failed to get control of vehicle :(", _G_GeeVer, 4, 2)
		else
			pos = _GF_pos_nearby(player.get_player_coords(_pid),"single_50_dist",100,"water")
			if not _GF_ent_tp(_GT_plyr_info.veh[me+1],pos, 0 ,false) then
				menu.notify("Failed to get control of vehicle :(", _G_GeeVer, 4, 2)
			else
				local time = utils.time_ms() + 2000
				while time > utils.time_ms() do
					system.yield(0)
					pos=player.get_player_coords(_pid)
					if pos.z > 0 then
						time = utils.time_ms()
					end
				end
				pos=player.get_player_coords(_pid)
				if pos.z > 0 then
					if _where == "on_top" then
						pos.z=pos.z+3
					elseif _where == "behind" then
						pos = _GF_front_of_pos(player.get_player_coords(_pid),player.get_player_heading(_pid),5,0,1)
					end
					if not _GF_ent_tp(_GT_plyr_info.veh[me+1],pos, 0 ,false) then
						menu.notify("Failed to get control of vehicle :(\nI hope this is close enough", _G_GeeVer, 4, 2)
					end
				else
					menu.notify("I hope this is close enough", _G_GeeVer, 4, 2)
				end
			end
		end
	else
		entity.set_entity_coords_no_offset(my_ped,_GF_pos_nearby(pos,"single_50_dist",100,"water"))
		local time = utils.time_ms() + 2000
		while time > utils.time_ms() do
			system.yield(0)
			pos=player.get_player_coords(_pid)
			if pos.z > 0 then
				time = utils.time_ms()
			end
		end
		pos=player.get_player_coords(_pid)
		if pos.z > 0 then
			if _where == "on_top" then
				pos.z=pos.z+3
			elseif _where == "behind" then
				pos = _GF_front_of_pos(player.get_player_coords(_pid),player.get_player_heading(_pid),5,0,1)
			end
			entity.set_entity_coords_no_offset(my_ped,pos)
		else
			menu.notify("I hope this is close enough", _G_GeeVer, 4, 2)
		end
	end
end

------------------Pre-Plotted waypoints
---------------------------------------

_G_WP_OBJ_pos=v3()
function _GF_WP_coords_get(_where)
	if ui.get_waypoint_coord().x < 16000 then
		local me=player.player_id()
		local my_pos = player.get_player_coords(me)
		local wp = v2(ui.get_waypoint_coord().x,ui.get_waypoint_coord().y)
		local wp_table = {}
		local dist=250
		repeat
			if _where == "anywhere" then
				for i=1,#_GT_WP_TP_water do
					if _GF_num_in_range(_GT_WP_TP_water[i].y,wp.y-dist,wp.y+dist) and _GF_num_in_range(_GT_WP_TP_water[i].x,wp.x-dist,wp.x+dist) then
						wp_table[#wp_table+1]=_GT_WP_TP_water[i]
					end
				end
			end
			if _GF_pos_xy_in_range(my_pos,1700,15000,-15000,-3600) then --if im in the cayo area 
				for i=1,#_GT_cayo_land do
					if _GF_num_in_range(_GT_cayo_land[i].y,wp.y-dist,wp.y+dist) and _GF_num_in_range(_GT_cayo_land[i].x,wp.x-dist,wp.x+dist) then
						wp_table[#wp_table+1]=_GT_cayo_land[i]
					end
				end
			end
			for i=1,#_GT_WP_TP_NE do
				if _GF_num_in_range(_GT_WP_TP_NE[i].y,wp.y-dist,wp.y+dist) and _GF_num_in_range(_GT_WP_TP_NE[i].x,wp.x-dist,wp.x+dist) then
					wp_table[#wp_table+1]=_GT_WP_TP_NE[i]
				end
			end	
			for i=1,#_GT_WP_TP_NW do
				if _GF_num_in_range(_GT_WP_TP_NW[i].y,wp.y-dist,wp.y+dist) and _GF_num_in_range(_GT_WP_TP_NW[i].x,wp.x-dist,wp.x+dist) then
					wp_table[#wp_table+1]=_GT_WP_TP_NW[i]
				end
			end		
			for i=1,#_GT_WP_TP_SE do
				if _GF_num_in_range(_GT_WP_TP_SE[i].y,wp.y-dist,wp.y+dist) and _GF_num_in_range(_GT_WP_TP_SE[i].x,wp.x-dist,wp.x+dist) then
					wp_table[#wp_table+1]=_GT_WP_TP_SE[i]
				end
			end
			for i=1,#_GT_WP_TP_SW do
				if _GF_num_in_range(_GT_WP_TP_SW[i].y,wp.y-dist,wp.y+dist) and _GF_num_in_range(_GT_WP_TP_SW[i].x,wp.x-dist,wp.x+dist) then
					wp_table[#wp_table+1]=_GT_WP_TP_SW[i]
				end
			end
			if #wp_table == 0 then
				dist=dist*1.5
			end
		until #wp_table > 0
		_GF_sort_xy_pos(wp_table,wp)
		_G_WP_OBJ_pos = wp_table[1]
		return true
	end
	return false
end

_G_OBJ_coords_BAD = false
function _GF_OBJ_coords_get()
	_GF_OBJ_coords_BAD = false
	local found,obj_pos = ui.get_objective_coord()
	if found then
		if obj_pos == v3(0.0,0.0,0.0) then --because the api lacks whats needed to determine where the kostaka or other blips are, they show up as 0,0,0 so this prevents you from tp'ing under the city
			_GF_OBJ_coords_BAD = true
		else
			local otr_blip = false
			for i=1,#_GT_plyr_info.otr_blip do
				if  _GT_plyr_info.otr_blip[i] ~= v3(0,0,0) and _GF_valid_pid(i-1) then 
					if _GF_dist_xy_pospos(player.get_player_coords(i-1),obj_pos) < 10  then --this ensures that i wont tp to a green otr blip i made
						otr_blip=true
						break
					end
				end
			end
			if not otr_blip then
				local un_dead_blip=false
				for i=1,#_GT_plyr_info.undead_blip do
					if  _GT_plyr_info.undead_blip[i] ~= v3(0,0,0) and _GF_valid_pid(i-1) then 
						if _GF_dist_xy_pospos(player.get_player_coords(i-1),obj_pos) < 10  then
							un_dead_blip=true
							break
						end
					end
				end
				if not un_dead_blip then
					obj_pos.z=obj_pos.z+.5
					_G_WP_OBJ_pos=obj_pos
					return true
				end
			end
		end
	end
	return false
end

_GT_LocPointPos = {}
function _GF_pos_nearby(_pos,_type,_max,_water,_xyz)
	local me=player.player_id()
	local my_pos = player.get_player_coords(me)
	_max = _max or 31
	_water = _water or "no_water"
	_xyz = _xyz or "xy"
	local table_sort_type = _GF_sort_xy_pos
	if _xyz == "xyz" then
		table_sort_type = _GF_sort_xyz_pos
	end
	local pos_table = {}
	local dist=25
	repeat
		if _water == "water" then
			for i=1,#_GT_WP_TP_water do
				if _GF_num_in_range(_GT_WP_TP_water[i].y,_pos.y-dist,_pos.y+dist) and _GF_num_in_range(_GT_WP_TP_water[i].x,_pos.x-dist,_pos.x+dist) then
					pos_table[#pos_table+1]=_GT_WP_TP_water[i]
				end
			end
		end
		if _GF_pos_xy_in_range(my_pos,1700,15000,-15000,-3600) then --if im in the cayo area 
			for i=1,#_GT_cayo_land do
				if _GF_num_in_range(_GT_cayo_land[i].y,_pos.y-dist,_pos.y+dist) and _GF_num_in_range(_GT_cayo_land[i].x,_pos.x-dist,_pos.x+dist) then
					pos_table[#pos_table+1]=_GT_cayo_land[i]
				end
			end
		end
		for i=1,#_GT_WP_TP_NE do
			if _GF_num_in_range(_GT_WP_TP_NE[i].y,_pos.y-dist,_pos.y+dist) and _GF_num_in_range(_GT_WP_TP_NE[i].x,_pos.x-dist,_pos.x+dist) then
				pos_table[#pos_table+1]=_GT_WP_TP_NE[i]
			end
		end	
		for i=1,#_GT_WP_TP_NW do
			if _GF_num_in_range(_GT_WP_TP_NW[i].y,_pos.y-dist,_pos.y+dist) and _GF_num_in_range(_GT_WP_TP_NW[i].x,_pos.x-dist,_pos.x+dist) then
				pos_table[#pos_table+1]=_GT_WP_TP_NW[i]
			end
		end		
		for i=1,#_GT_WP_TP_SE do
			if _GF_num_in_range(_GT_WP_TP_SE[i].y,_pos.y-dist,_pos.y+dist) and _GF_num_in_range(_GT_WP_TP_SE[i].x,_pos.x-dist,_pos.x+dist) then
				pos_table[#pos_table+1]=_GT_WP_TP_SE[i]
			end
		end
		for i=1,#_GT_WP_TP_SW do
			if _GF_num_in_range(_GT_WP_TP_SW[i].y,_pos.y-dist,_pos.y+dist) and _GF_num_in_range(_GT_WP_TP_SW[i].x,_pos.x-dist,_pos.x+dist) then
				pos_table[#pos_table+1]=_GT_WP_TP_SW[i]
			end
		end
		if #pos_table < _max then
			dist=dist*1.5
		end
	until #pos_table >= _max
	table_sort_type(pos_table,_pos)
	if _type == "single_random" then
		_pos = math.random(1,_max)
		_pos = pos_table[_pos]
		return _pos
	elseif _type == "single_closest" then
		_pos = pos_table[1]
		return _pos
	elseif _type == "single_50_dist" then
		for i=1,#pos_table do
			if _GF_dist_xy_pospos(pos_table[i],_pos) > 45 then
				_pos = pos_table[i]
				break
			end
		end
		return _pos
	elseif _type == "session" then
		for i=1,32 do
			_GT_LocPointPos[i]=pos_table[i]--unused/untested
		end 
	end
end

-- _GT_LocPointPos = {}
-- function _GF_pos_nearby(_pos,_type,_max,_water,_xyz)
	-- _water = _water or "no_water"
	-- _xyz = _xyz or "xy"
	-- local table_sort_type = _GF_sort_xy_pos
	-- if _xyz == "xyz" then
		-- table_sort_type = _GF_sort_xyz_pos
	-- end
	-- _max = _max or 31
	-- local pos_table = {}
	-- if _pos.y >=0 then
		-- if _pos.x >= 0 then
			-- table_sort_type(_GT_WP_TP_NE,_pos)
			-- for i=1,_max do
				-- pos_table[#pos_table+1]=_GT_WP_TP_NE[i]
			-- end
		-- else
			-- table_sort_type(_GT_WP_TP_NW,_pos)
			-- for i=1,_max do
				-- pos_table[#pos_table+1]=_GT_WP_TP_NW[i]
			-- end
		-- end
	-- else
		-- if _pos.x >= 0 then
			-- table_sort_type(_GT_WP_TP_SE,_pos)
			-- for i=1,_max do
				-- pos_table[#pos_table+1]=_GT_WP_TP_SE[i]
			-- end
		-- else
			-- table_sort_type(_GT_WP_TP_SW,_pos)
			-- for i=1,_max do
				-- pos_table[#pos_table+1]=_GT_WP_TP_SW[i]
			-- end
		-- end
	-- end
	-- if _water == "water" then
		-- table_sort_type(_GT_WP_TP_water,_pos)
		-- for i=1,_max do
			-- pos_table[#pos_table+1]=_GT_WP_TP_water[i]
		-- end
	-- end
	-- table_sort_type(pos_table,_pos)
	-- if _type == "single_random" then
		-- _pos = math.random(1,_max)
		-- _pos = pos_table[_pos]
		-- return _pos
	-- elseif _type == "single_closest" then
		-- _pos = pos_table[1]
		-- return _pos
	-- elseif _type == "single_50_dist" then
		-- for i=1,#pos_table do
			-- if _GF_dist_xy_pospos(pos_table[i],_pos) > 50 then
				-- _pos = pos_table[i]
				-- break
			-- end
		-- end
		-- return _pos
	-- elseif _type == "session" then
		-- for i=1,31 do
			-- _GT_LocPointPos[i]=pos_table[i]--unused/untested
		-- end 
	-- end
-- end

_GT_RandPointPos = {}
function _GF_random_pos(_type,_session,_max)
	local rand=5
	_max = _max or 31
	_GT_RandPointPos = {}
	if _session == "session" then
		for i=1, _max do
			if _type == "water" or _type == "anywhere" then
				rand=math.random(1,#_GT_WP_TP_water)
				_GT_RandPointPos[#_GT_RandPointPos+1]=_GT_WP_TP_water[rand]
			end
			if _type == "land" or _type == "anywhere" then
				rand=math.random(1,#_GT_WP_TP_NE)
				_GT_RandPointPos[#_GT_RandPointPos+1]=_GT_WP_TP_NE[rand]
				rand=math.random(1,#_GT_WP_TP_NW)
				_GT_RandPointPos[#_GT_RandPointPos+1]=_GT_WP_TP_NW[rand]
				rand=math.random(1,#_GT_WP_TP_SE)
				_GT_RandPointPos[#_GT_RandPointPos+1]=_GT_WP_TP_SE[rand]
				rand=math.random(1,#_GT_WP_TP_SW)
				_GT_RandPointPos[#_GT_RandPointPos+1]=_GT_WP_TP_SW[rand]
			end
		end
	else
		if _type == "land" then
			rand=math.random(1,4)
		elseif _type == "anywhere" then
			rand=math.random(1,5)
		end
		if rand == 1 then
			rand=math.random(1,#_GT_WP_TP_NE)
			rand = _GT_WP_TP_NE[rand]
		elseif rand == 2 then
			rand=math.random(1,#_GT_WP_TP_NW)
			rand = _GT_WP_TP_NW[rand]
		elseif rand == 3 then
			rand=math.random(1,#_GT_WP_TP_SE)
			rand = _GT_WP_TP_SE[rand]
		elseif rand == 4 then
			rand=math.random(1,#_GT_WP_TP_SW)
			rand = _GT_WP_TP_SW[rand]
		else
			rand=math.random(1,#_GT_WP_TP_water)
			rand = _GT_WP_TP_water[rand]
		end
		return rand
	end
end

function _GF_tp_plyr_to_wp(_pid,_where)
	local continue =false
	local pidT = _pid+1
	if _where == "objective" then
		if _GF_OBJ_coords_get() then
			continue=true
		end
	elseif ui.get_waypoint_coord().x >= 16000 then
		menu.notify("No waypoint set.", _G_GeeVer, 4, 2)
	elseif _GF_is_pid_intrr(_pid) then
		menu.notify("".._name .. "" .. "" .. "\nIn interior.", _G_GeeVer, 4, 2)
	else
		continue=true
	end
	if continue then
		local me=player.player_id()
		local my_ped=player.get_player_ped(me)
		local my_orig_pos = player.get_player_coords(me)
		local _name = _GF_plyr_name(_pid)
		local plyr_has_veh,hover_try,i_hovered = false,false,false
		local loc = "objective"
		if _where ~= "objective" then
			_GF_WP_coords_get(_where)
			loc = "waypoint"
		end
		if player.is_player_in_any_vehicle(_pid) then
			plyr_has_veh=true
			if _GF_request_ctrl(player.get_player_vehicle(_pid),2500) then
				entity.set_entity_coords_no_offset(player.get_player_vehicle(_pid),_G_WP_OBJ_pos)
				menu.notify("".._name.."\nTeleported to "..loc.."",_G_GeeVer,4,2)
				tp_success=true
			end
		elseif _GT_plyr_info.tp_sett[pidT] == true then
			i_hovered=true
			_GF_hover_back_record()
			if _GF_hover_check_pid_for_veh(_pid) then
				plyr_has_veh=true
				if _GF_hover_tp_plyr_veh(_G_WP_OBJ_pos,loc,_pid) then
					tp_success=true
				else
					hover_try=true
				end
			end
		end
		if i_hovered then
			_GF_hover_back_to_pos()
		end				
		if not plyr_has_veh then
			if _GT_plyr_info.tp_sett[pidT] == false then
				menu.notify("".. _name .. "\nNo vehicle. Try enabling force check.", _G_GeeVer, 5, 2)
			else
				menu.notify("".._name.."\nHas no vehicle.",_G_GeeVer,4,2)
			end
		elseif not tp_success and not hover_try then
			menu.notify("".._name.."\nFailed to teleport.",_G_GeeVer,4,2)
		end
	elseif _where == "objective" and _G_OBJ_coords_BAD then
		menu.notify("The menu won't let me find the objective coords.",_G_GeeVer,4,2)
	end
	_GF_H_var_default()
end

-------------------------Basic teleport
---------------------------------------
function _GF_ent_tp(_ent,_pos, _z ,_bool)
	_z = _z or 0
	_pos.z=_pos.z+_z
	_bool = _bool or false
	if _GF_request_ctrl(_ent,1500) then
		local speed = v3(0,0,0)
		if _bool then
			speed = entity.get_entity_velocity(_ent)
		end
		entity.set_entity_coords_no_offset(_ent,_pos)
		system.yield(20)
		_GF_request_ctrl(_ent,100)
		entity.set_entity_velocity(_ent,speed)
		return true
	end
	return false
end

function _GF_spwn_frt_dist(_pid,_veh)
	local front = 1.5
	if player.is_player_in_any_vehicle(_pid) then
		local _min,_max = entity.get_entity_model_dimensions(player.get_player_vehicle(_pid))
		if _min ~= nil and _max ~= nil then
			front = front + (_max.y+math.abs(_min.y))/2
		end
	end
	local _min,_max = entity.get_entity_model_dimensions(_veh)
	if _min ~= nil and _max ~= nil then
		front = front + (_max.y+math.abs(_min.y))/2
	end
	return front
end

function _GF_tp_veh_2_me(_veh)
	if _GF_request_ctrl(_veh,1500) then
		local front = _GF_spwn_frt_dist(player.player_id(),_veh)
		entity.set_entity_coords_no_offset(_veh,_GF_front_of_pos(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), front, 180, 1))
		entity.set_entity_heading(_veh, player.get_player_heading(player.player_id()))
		vehicle.set_vehicle_on_ground_properly(_veh)
		entity.set_entity_coords_no_offset(_veh,_GF_front_of_pos(player.get_player_coords(player.player_id()), player.get_player_heading(player.player_id()), front, 180, 1))
		system.yield(100)
		if _GF_dist_me_ent(_veh) < 25 then
			return true
		end
	end
end

function _GF_plyr_veh_tp_simple(_pid,_pos, _z,_loc,_speed,_veh_notif)
	_z = _z or 0
	_veh_notif = _veh_notif or false
	_pos.z = _pos.z+_z
	_loc = _loc or "Location."
	_speed = _speed or false
	local speed = v3(0,0,0)
	if player.is_player_in_any_vehicle(_pid) then
		if _GF_request_ctrl(player.get_player_vehicle(_pid),2500) then
			if _speed then
				speed = entity.get_entity_velocity(player.get_player_vehicle(_pid))
			end
			entity.set_entity_coords_no_offset(player.get_player_vehicle(_pid),_pos)
			entity.set_entity_velocity(player.get_player_vehicle(_pid),speed)
			menu.notify("".. _GF_plyr_name(_pid) .. " - " .. _GF_model_name(player.get_player_vehicle(_pid)) .. "\nTeleported - " .. _loc .."", _G_GeeVer, 4, 2)
			return true
		else
			menu.notify("".. _GF_plyr_name(_pid) .. " - " .. _GF_model_name(player.get_player_vehicle(_pid)) .. "\nFAILED to teleport - " .. _loc .."", _G_GeeVer, 4, 2)
		end
	elseif _veh_notif then
		menu.notify("".. _GF_plyr_name(_pid) .. " - Not in a vehicle.", _G_GeeVer, 4, 2)
	end
end

-----------------------Teleport players
---------------------------------------
function _G_p_veh_tp_do(_pos,_loc,_speed,_z,_pid)
	_z = _z or 0
	local pidT = _pid+1
	local name = _GT_plyr_info.name[pidT]
	if _GT_plyr_info.interior[pidT] == true then
		menu.notify("".. name .. "\nIs in interior.", _G_GeeVer, 4, 2)
	else
		local _veh = _GT_plyr_info.veh[pidT]
		local model_name = _GF_model_name(_veh)
		local speed, up = false, false
		local pos = v3()
		if _pos == "get_pos" then
			pos = entity.get_entity_coords(_veh)
		elseif _pos == "my_pos_front" then
			local me=player.player_id()
			local my_ped=player.get_player_ped(me)
			pos = _GF_front_of_pos(entity.get_entity_coords(my_ped),player.get_player_heading(me),5,180,3)
		else
			pos=_pos
		end
		if _speed == "retain_speed" then
			speed = true
		end
		if _GT_plyr_info.tp_sett[pidT] == false then
			if _GF_valid_veh(_veh) then
				if _GF_ent_tp(_veh,pos, _z ,speed) then
					menu.notify("".. name .. " - " .. model_name .. "\nTeleported - " .. _loc .."", _G_GeeVer, 4, 2)
				else
					menu.notify("".. name .. " - " .. model_name .. "\nFAILED to teleport.", _G_GeeVer, 4, 2)
				end
			else
				menu.notify("".. name .. "\nNo vehicle. Try enabling force check.", _G_GeeVer, 5, 2)
			end
		elseif _GT_plyr_info.tp_sett[pidT] == true then
			_GF_plyr_veh_tp(_pid,pos,_z,_loc, speed)
		end
	end
end

function _GF_hover_tp_plyr_veh(_pos,_loc,_pid,_speed,_z)
	_z = _z or 0
	local time = utils.time_ms() + 3000
	local wait_time = utils.time_ms() + 1750
	local pos = _pos
	pos.z=pos.z+_z
	local plyr_orig_pos = v3()
	local speeed = v3(0,0,0)
	local tp_success,plyr_has_veh,do_once = false,true,false
	while _GF_valid_pid(_pid) and not tp_success and plyr_has_veh and (utils.time_ms() < time) do
		system.yield(0)
		_GF_hover_above_player(_pid)
		if player.is_player_in_any_vehicle(_pid) then
			if not do_once then
				plyr_orig_pos = player.get_player_coords(_pid)
				do_once=true
			end
			network.request_control_of_entity(player.get_player_vehicle(_pid))
			if network.has_control_of_entity(player.get_player_vehicle(_pid)) then
				local plyr_speed = entity.get_entity_velocity(player.get_player_vehicle(_pid))
				entity.set_entity_coords_no_offset(player.get_player_vehicle(_pid),pos)
				if _speed == true then
					speeed = plyr_speed
				end
				entity.set_entity_velocity(player.get_player_vehicle(_pid),speeed)
				tp_success=true
			end
		elseif utils.time_ms() > wait_time then
			plyr_has_veh=false
		end
	end
	if not tp_success then
		if plyr_has_veh then
			menu.notify("".._GF_plyr_name(_pid).."\nFAILED to teleport.",_G_GeeVer,4,2)
		else
			menu.notify("".._GF_plyr_name(_pid).."\nHas no vehicle.",_G_GeeVer,4,2)
		end
	else
		menu.notify("".._GF_plyr_name(_pid).."\nTeleported to ".._loc.."",_G_GeeVer,4,2)
		return true
	end
end

function _GF_plyr_ped_start(_pid,_action,_blame,_blame_name,_type1,_type2)
	if _GT_plyr_info.interior[_pid+1] == true then
		menu.notify("".._GF_plyr_name(_pid) .. "" .. "" .. "\nIn interior.", _G_GeeVer, 4, 2)
	else
		local Table = {_pid}
		_GF_plyr_ped_do(Table,_action,_blame,_blame_name,_type1,_type2,"single")
	end
end

function _GF_plyr_ped_do(_table,_action,_blame,_blame_name,_type1,_type2,_single)
	_single = _single or "session"
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	local name = "Name"
	local blame = _blame
	local my_orig_pos = player.get_player_coords(me)
	local intrr,no_play,count,already_dead,no_pos,killed,god,sparrow_count = 0,0,0,0,0,0,0,0
	local i_tried,i_hovered = false,false
	local single_pid = -1
	_GF_hover_back_record()
	_GF_sort_xyz_pid(_table,my_orig_pos)
	for i=1,#_table do
		local _pid = _table[i]
		local attempt,continue=false,false
		if _GF_valid_pid(_pid) then
			count=count+1
			name = _GF_plyr_name(_pid)
			if _GT_plyr_info.interior[_pid+1] == true then
				intrr=intrr+1
			elseif _GT_plyr_info.dead[_pid+1] == true then
				already_dead=already_dead+1
			elseif _GT_plyr_info.plyr_god[_pid+1] == true then
				god=god+1
				if _action == "sparrow" or _action == "sparrows" then
					continue=true
				end
			else
				continue = true
			end
			if continue then
				i_tried = true
				attempt=true
				local do_once,stop = false,false
				local time = utils.time_ms() + 4000
				local stop_time = utils.time_ms() + 1750
				local wait_time = utils.time_ms()
				local delay = utils.time_ms()
				sparrow_count = 0
				local distance,head
				local plyr_pos = v3(0,0,0)
				while _GF_valid_pid(_pid) and (utils.time_ms() < time) and not stop do
					system.yield(0)
					if _GF_dist_xy_pospos(player.get_player_coords(me),player.get_player_coords(_pid)) < 500 then
						plyr_pos = player.get_player_coords(_pid)
					elseif _single == "session" and _G_on_plyrs_veh_pos_enforce.on then
						i_hovered = true
					elseif _single == "single" then
						single_pid = _pid
						if _GT_plyr_info.tp_sett[_pid+1] == true then
							i_hovered = true
						else
							local hopeful_pos = player.get_player_coords(_pid)
							if hopeful_pos.z > 0 then
								plyr_pos=hopeful_pos
							else
								stop=true
							end
						end
					end
					if i_hovered and not stop then
						_GF_hover_above_player(_pid)
					end
					if plyr_pos ~= v3(0,0,0) then
						if _action == "sparrow" or _action == "sparrows" then
							if player.is_player_in_any_vehicle(_pid) then
								distance = entity.get_entity_speed(player.get_player_vehicle(_pid))
								distance=(distance+2)/4
								head = entity.get_entity_heading(player.get_player_vehicle(_pid))
							else
								distance = entity.get_entity_speed(player.get_player_ped(_pid))
								distance=distance/4
								head = player.get_player_heading(_pid)
							end
							if not do_once then
								streaming.request_model(1229411063)
								wait_time = utils.time_ms() + 500
								do_once=true
							end
							if streaming.has_model_loaded(1229411063) and wait_time < utils.time_ms() and delay < utils.time_ms() then
								plyr_pos = _GF_front_of_pos(plyr_pos, head, distance, 180, 20)
								local veh = vehicle.create_vehicle(1229411063, plyr_pos, math.random(0,359), true, false)
								entity.set_entity_velocity(veh, v3(0,0,-150))
								sparrow_count = sparrow_count+1
								if _action == "sparrow" then
									stop=true
								elseif _action == "sparrows" then
									if sparrow_count == 10 then
										stop=true
									else
										time = time + 750
										delay = utils.time_ms() + 500
									end
								end	
							end
						elseif _action == "burn" or _action == "explode" then
							if _blame == -1 then
								blame = _pid
							end
							distance = entity.get_entity_speed(player.get_player_ped(_pid))
							distance=distance*0.1
							head = player.get_player_heading(_pid)
							local ped_pos = _GF_front_of_pos(plyr_pos,head,distance,180,0.25)
							fire.add_explosion(ped_pos, _type1, true, false, 0, blame)
							fire.add_explosion(ped_pos, _type2, true, false, 0, blame)
							if player.is_player_in_any_vehicle(_pid) then
								distance = entity.get_entity_speed(player.get_player_vehicle(_pid))
								distance=distance/4
								head = entity.get_entity_heading(player.get_player_vehicle(_pid))
								plyr_pos = _GF_front_of_pos(plyr_pos,head,distance,180,0.25)
								fire.add_explosion(plyr_pos, _type1, true, false, 0, blame)
								fire.add_explosion(plyr_pos, _type2, true, false, 0, blame)
							end
						end
						if _GT_plyr_info.dead[_pid+1] == true then
							killed=killed+1
							stop=true
						end
					elseif utils.time_ms() > stop_time then
						no_pos=no_pos+1
						stop=true
					end
				end
			end
		end
		if attempt then
			local check_msg = ""
			if _action == "sparrow" or _action == "sparrows" then
				if _GF_valid_pid(single_pid) and sparrow_count == 0 then
					check_msg="\nTry enabling force check."
				end
				menu.notify("".. name .. "\n"..sparrow_count.." Sparrow(s) dropped"..check_msg.."", _G_GeeVer, 4, 2)
			elseif 	_GT_plyr_info.dead[_pid+1] == false then
				menu.notify("".. name .. "\nNOT Killed :(", _G_GeeVer, 4, 2)
			elseif 	_GT_plyr_info.dead[_pid+1] == true then
				if _action == "explode" then
					menu.notify("".. name .. "  -  Exploded to death.\n" .. _blame_name .. "", _G_GeeVer, 4, 2)
				elseif _action == "burn" then
					menu.notify("".. name .. "  -  Burned to death.\n" .. _blame_name .. "", _G_GeeVer, 4, 2)
				end
			end
		end
	end
	local message = ""
	if count > 0 then message=message..killed.."/"..count.." player(s) were murdered.\n"
	end
	if already_dead > 0 then message=message..already_dead.." already dead.\n"
	end
	if god > 0 then message=message..god.." in godmode.\n"
	end
	if intrr > 0 then message=message..intrr.." in interior.\n"
	end
	if no_play > 0 then message=message..no_play.." not playing.\n"
	end
	if no_pos > 0 then message=message..no_pos.." could not be found."
	end
	if i_tried then
		if _single == "session" then
			if count > 0 then
				menu.notify("".. message .. "", _G_GeeVer, 12, 2)
			else
				menu.notify("No players affected :(", _G_GeeVer, 7, 2)
			end
		end
		if i_hovered then
			_GF_hover_back_to_pos()
		end
	elseif #_table == 1 then
		menu.notify("".. message .. "", _G_GeeVer, 12, 2)
	else
		menu.notify("No players affected :(", _G_GeeVer, 7, 2)
	end
	_GF_H_var_default()
end

function _GF_plyr_veh_tp(_pid,_pos,_z,_loc,_speed)
	_z = _z or 0
	_loc = _loc or "Location."
	_pos.z = _pos.z + _z
	_speed = _speed or false
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	local my_orig_pos = player.get_player_coords(me)
	local plyr_pos = player.get_player_coords(_pid)
	_GF_hover_back_record()
	if _GF_is_pid_intrr(_pid) then
		menu.notify("".._GF_plyr_name(_pid) .. "" .. "" .. "\nIn interior.", _G_GeeVer, 4, 2)
	elseif _GF_dist_pos_pos(my_orig_pos,plyr_pos) < 250 and not player.is_player_in_any_vehicle(_pid) then
		menu.notify("".._GF_plyr_name(_pid) .. "" .. "" .. "\nNot in a vehicle.", _G_GeeVer, 4, 2)
	elseif plyr_pos.z < -75 then
		menu.notify("".._GF_plyr_name(_pid) .. "" .. "" .. "\nProbably in interior.", _G_GeeVer, 4, 2)
	elseif not _GF_plyr_veh_tp_simple(_pid,_pos, _z,_loc,_speed,false) then
		if plyr_pos.z == -50 or _GF_dist_pos_pos(my_orig_pos,plyr_pos) > 250 then
			_GF_hover_tp_plyr_veh(_pos,_loc,_pid,_speed,_z)
			_GF_hover_back_to_pos()
		else
			menu.notify("".._GF_plyr_name(_pid) .. "" .. "" .. "\nNot in a vehicle.", _G_GeeVer, 4, 2)
		end
	end
	_GF_H_var_default()
end

function _GF_H_var_default()
_G_H_my_veh,_G_H_veh_plyr,_G_H_hash = -1,-1,-1
_G_H_my_veh_pos,_G_H_my_orig_pos = v3(),v3()
_G_H_in_intrr=false
_G_H_on_ground=false
end
_GF_H_var_default()

function _GF_hover_back_record()
	if _GF_is_pid_intrr(player.player_id()) then
		_G_H_in_intrr=true
		_G_H_my_orig_pos=player.get_player_coords(player.player_id())
	elseif _GF_me_in_any_veh() then
		_G_H_my_veh=player.get_player_vehicle(player.player_id())
		_G_H_hash = entity.get_entity_model_hash(_G_H_my_veh)
		_G_H_my_veh_pos=entity.get_entity_coords(_G_H_my_veh)
		_G_H_veh_plyr = _GF_a_plyr_in_that_veh(_G_H_my_veh)
		if entity.is_entity_in_air(_G_H_my_veh) then
			_G_H_on_ground=false
		else
			_G_H_on_ground=true
		end
		_G_H_in_intrr=false
		_G_H_my_orig_pos = v3()
	else
		_G_H_my_orig_pos=player.get_player_coords(player.player_id())
		if entity.is_entity_in_air(player.get_player_ped(player.player_id())) then
			_G_H_on_ground=false
		else
			_G_H_on_ground=true
		end
		_G_H_my_veh = -1
		_G_H_veh_plyr = -1
		_G_H_hash = -1
		_G_H_my_veh_pos = v3()
		_G_H_in_intrr=false
	end
end

function _GF_hover_back_to_pos()
	if _G_H_in_intrr then
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),_GF_pos_nearby(_G_H_my_orig_pos,"single_closest",10,"water","xyz"))
	elseif _G_H_my_orig_pos ~= v3() then
		if _G_H_on_ground then
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), (_G_H_my_orig_pos + v3(0,0,1)))
		else
			entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),_GF_pos_nearby(_G_H_my_orig_pos,"single_closest",10,"water","xyz"))
		end
	else
		local time = utils.time_ms()
		local back_in_veh,do_once,found=false,false,false
		if _G_H_my_veh == player.get_personal_vehicle() and _GF_tp_personal_veh("self_2_veh_drive") then --maybe i had my personal vehicle. gta remembers that
			back_in_veh = true
		elseif _GF_valid_pid(_G_H_veh_plyr) then -- if there was another plyr in there i'll go to where they are now
			time = utils.time_ms() + 1250
			while (utils.time_ms() < time) and not back_in_veh do 
				system.yield(0)
				if _GF_me_in_any_veh() then
					back_in_veh=true
				else
					_GF_hover_above_player(_G_H_veh_plyr)
					if not _GF_me_in_that_veh(player.get_player_vehicle(_G_H_veh_plyr)) then -- and i'll try to get in whatever vehicle they're in, hoping its the original vehicle
						_GF_tp_into_free_seat(player.get_player_vehicle(_G_H_veh_plyr))
					else
						back_in_veh=true
					end
				end
			end
		end
		local hopeful_veh=-1
		local hover_pos = _G_H_my_veh_pos + v3(0,0,50)
		if not back_in_veh then
			time = utils.time_ms() + 1250
			local wait_time = utils.time_ms() + 1000
			while (utils.time_ms() < time) and not found do --gta will not consider it a valid veh if you're too far away
				system.yield(0)
				_GF_hover_above_pos(hover_pos) -- so i go back to where it was last to hopefully find it
				if not do_once and (utils.time_ms() > wait_time) then
					local all_veh=vehicle.get_all_vehicles()
					_GF_sort_xyz_ent(all_veh,_G_H_my_veh_pos)
					for i=1,#all_veh do
						if entity.get_entity_model_hash(all_veh[i]) == _G_H_hash then --normally this finds it. Not the best option but only personal vehicle has good success
							hopeful_veh=all_veh[i]
							found = true
							break
						end
					end
					do_once=true
				end
			end
		end
		if not back_in_veh and (_GF_valid_veh(_G_H_my_veh) or _GF_valid_veh(hopeful_veh)) then --if i can find it or a vehicle with the same hash
			if _GF_valid_veh(_G_H_my_veh) then
				hover_pos = entity.get_entity_coords(_G_H_my_veh) + v3(0,0,50)
			else
				hover_pos = entity.get_entity_coords(hopeful_veh) + v3(0,0,50)
			end
			time = utils.time_ms() + 750
			while (utils.time_ms() < time) and not back_in_veh do 
				system.yield(0)
				if _GF_me_in_any_veh() then
					back_in_veh=true
				else
					_GF_hover_above_pos(hover_pos) --i will go to where it is and try to get back in
					if not _GF_me_in_any_veh() then
						_GF_tp_into_free_seat(_G_H_my_veh)
					else
						back_in_veh=true
					end
					if not _GF_me_in_any_veh() then
						_GF_tp_into_free_seat(hopeful_veh)
					else
						back_in_veh=true
					end
				end
			end
		end
		system.yield(500)
		if not _GF_me_in_any_veh() then
			if _G_H_on_ground then
				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), (_G_H_my_veh_pos + v3(0,0,1)))
			else
				entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), _GF_pos_nearby(_G_H_my_veh_pos,"single_closest",10,"water","xyz"))
			end
			system.yield(500)
			if not _GF_tp_into_free_seat(_G_H_my_veh) then
				_GF_tp_into_free_seat(hopeful_veh) 
			end
		end
	end
	_GF_H_var_default()
end

function _GF_hover_above_player(_pid)
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	local plyr_pos = player.get_player_coords(_pid)
	plyr_pos.z=plyr_pos.z+50
	entity.set_entity_coords_no_offset(my_ped, plyr_pos) 
end

function _GF_hover_check_pid_for_veh(_pid)
	local time = utils.time_ms() + 1750
	local plyr_has_veh = false
	while _GF_valid_pid(_pid) and not plyr_has_veh and (utils.time_ms() < time) do
		system.yield(0)
		_GF_hover_above_player(_pid)
		if player.is_player_in_any_vehicle(_pid) then
			plyr_has_veh=true
		end
	end
	if plyr_has_veh then
		return true
	end
end

function _GF_hover_above_ent(_ent)
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	local pos = entity.get_entity_coords(_ent)
	pos.z=pos.z+50
	entity.set_entity_coords_no_offset(my_ped, pos)
end

function _GF_hover_above_pos(_pos)
	local me=player.player_id()
	local my_ped=player.get_player_ped(me)
	entity.set_entity_coords_no_offset(my_ped, _pos) 
end
----------------------Personal/Last Veh
---------------------------------------
function _GF_tp_personal_veh(_action)
	local veh = player.get_personal_vehicle()
	local mee = player.get_player_ped(player.player_id())
	local my_veh = ped.get_vehicle_ped_is_using(mee)
	local function kick_driver(_veh)
		if _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, -1)) then
			if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, -1)) then
				_GF_veh_kick_script(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, -1)))
			end
			ped.clear_ped_tasks_immediately(vehicle.get_ped_in_vehicle_seat(_veh, -1))
		end
		time = utils.time_ms() + 250
		while _GF_is_ent(vehicle.get_ped_in_vehicle_seat(_veh, -1)) and utils.time_ms() < time do
			system.yield(0)
		end
	end
	if veh ~= 0 and veh ~= my_veh and _GF_valid_veh(veh) then
		_GF_veh_flip(veh,"flip_right",250)
		if _action == "self_2_veh" then
			local pos = entity.get_entity_coords(veh)
			pos.z = pos.z + 3
			entity.set_entity_coords_no_offset(mee, pos)
		elseif _action == "self_2_veh_drive" then
			kick_driver(veh)
			if not _GF_tp_into_free_seat(veh) then
				if not _GF_veh_hijack(veh) then
					menu.notify("No free seat. Failed to hijack. :(",_G_GeeVer,4,2)
				else
					return true
				end
			else
				return true
			end
		elseif _action == "veh_2_me" then
			kick_driver(veh)
			if not _GF_tp_veh_2_me(veh) then
				menu.notify("Could not teleport vehicle :(",_G_GeeVer,4,2)
			end
		elseif _action == "veh_2_me_drive" then
			kick_driver(veh)
			if _GF_tp_veh_2_me(veh) then
				if not _GF_tp_into_free_seat(veh) then
					if not _GF_veh_hijack(veh) then
						menu.notify("No free seat. Failed to hijack. :(",_G_GeeVer,4,2)
					end
				end
			else
				menu.notify("Could not teleport vehicle :(",_G_GeeVer,4,2)
			end
		end
	elseif veh == my_veh and _GF_me_in_any_veh() then
		menu.notify("You're already in your personal vehicle...",_G_GeeVer,4,2)
	else
		menu.notify("No personal vehicle found...",_G_GeeVer,4,2)
	end
end

function _GF_tp_last_veh(_action)
	local _veh
	if _GF_me_in_any_veh() then	_veh = _GT_my_veh_hist[#_GT_my_veh_hist-1] else	_veh = _GT_my_veh_hist[#_GT_my_veh_hist] end
	if not _GF_valid_veh(_veh) then
		menu.notify("Last vehicle not found",_G_GeeVer,4,2)
	elseif _GF_dist_pos_pos(entity.get_entity_coords(_veh),v3(0.0,0.0,0.0)) < 10 then --sometimes gta reports its pos as 0,0,0 when it cant find it
		menu.notify("Last vehicle not found",_G_GeeVer,4,2)
	elseif _action == "self_2_veh" then
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), entity.get_entity_coords(_veh)+v3(0,0,3))
	elseif _action == "self_2_veh_drive" then
		_GF_veh_flip(_veh,"flip_right",250)
		if not _GF_tp_into_free_seat(_veh) then
			if not _GF_veh_hijack(_veh) then
				menu.notify("No free seat. Failed to hijack. :(",_G_GeeVer,4,2)
			end
		end
	elseif _action == "veh_2_me" then
		_GF_veh_flip(_veh,"flip_right",250)
		if not _GF_tp_veh_2_me(_veh) then
			menu.notify("Could not teleport vehicle :(",_G_GeeVer,4,2)
		end
	elseif _action == "veh_2_me_drive" then
		_GF_veh_flip(_veh,"flip_right",250)
		if _GF_tp_veh_2_me(_veh) then
			if not _GF_tp_into_free_seat(_veh) then
				if not _GF_veh_hijack(_veh) then
					menu.notify("No free seat. Failed to hijack. :(",_G_GeeVer,4,2)
				end
			end
		else
			menu.notify("Could not teleport vehicle :(",_G_GeeVer,4,2)
		end
	end
end

