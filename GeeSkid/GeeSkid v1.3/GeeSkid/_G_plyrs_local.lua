-- GeeSkid v1.03

function _G_plyrs_local_do(parent)

	-----------------------------------------------------------------------------------------GEE-SKID
	------------------------------------------------------------------------------------------Players
	--------------------------------------------------------------------------------------------Local
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
	_GT_sssn_stf={}
	
	_GT_sssn_stf.ped_prnt = menu.add_feature("Players", "parent", parent.id)

	_GT_sssn_stf.veh_prnt = menu.add_feature("Vehicles", "parent", parent.id)
	
		_GT_sssn_stf.tp_prnt = menu.add_feature("Teleports", "parent", _GT_sssn_stf.veh_prnt.id)
		
		_GT_sssn_stf.hrn_bst = menu.add_feature("Horn", "parent", _GT_sssn_stf.veh_prnt.id)
	
		_GT_sssn_stf.opex_prnt = menu.add_feature("Options/Extras", "parent", _GT_sssn_stf.veh_prnt.id)
		
	_GT_sssn_stf.spwn_prnt = menu.add_feature("Spawn Vehicles", "parent", parent.id)
	
	_GT_sssn_stf.new = {}
	_GT_sssn_stf.new.feat_srch_table = {}
	_GT_spwn_veh.spwn_plate_check("spwn_ssn")
	_GT_sssn_stf.new.spwn_plate_txt = _GT_spwn_veh.spwn_plate_get("spwn_ssn")
	function _GT_sssn_stf.new.apply_upgrades(_veh)
		if _GF_is_ent(_veh) then
			_GF_ask_cntrl(_veh)
			vehicle.set_vehicle_mod_kit_type(_veh, 0)
			if _GT_sssn_stf.new.spwn_god.on then
				entity.set_entity_god_mode(_veh,true)
			end
			if _GT_sssn_stf.new.spwn_upg.on then
				if _GT_sssn_stf.new.spwn_upg.value == 0 then
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
			if _GT_sssn_stf.new.spwn_f1.on then
				_GF_veh_upgr_wheels(_veh,"f1")	
			end
			entity.set_entity_max_speed(_veh, 45000)
			vehicle.modify_vehicle_top_speed(_veh, (_GT_sssn_stf.new.spwn_spd_tq.value/100 - 1) * 100)
			if _GT_sssn_stf.new.spwn_rand_paint.on then
				if _GT_sssn_stf.new.spwn_rand_paint.value == 0 then
					_GF_veh_upgr_paint(_veh,"random")
				elseif _GT_sssn_stf.new.spwn_rand_paint.value == 1 then
					_GF_veh_upgr_paint(_veh,"random_solid")
				elseif _GT_sssn_stf.new.spwn_rand_paint.value == 2 then
					_GF_veh_upgr_paint(_veh,_GF_rand_paint_shade("Dark")) 
				else
					_GF_veh_upgr_paint(_veh,_GF_rand_paint_shade("Bright")) 
				end
			elseif _GT_sssn_stf.new.spwn_cust_paint.value == 0 then
				_GF_veh_upgr_paint(_veh,(_GT_sssn_stf.new.spwn_cust_paint_r.value * 65536 + _GT_sssn_stf.new.spwn_cust_paint_g.value * 256 + _GT_sssn_stf.new.spwn_cust_paint_b.value)) 
			else
				_GF_veh_upgr_paint(_veh,_GT_sssn_stf.new.paint_list_slct)
			end
			if _GT_sssn_stf.new.neon.choose.value == 0 then
				_GF_veh_upgr_neons(_veh,"random")
			else
				_GF_veh_upgr_neons(_veh,_GT_sssn_stf.new.neon_slct)
			end
			if _GT_sssn_stf.new.h_light.choose.value == 0 then
				_GF_veh_upgr_lights(_veh,"random")
			else
				_GF_veh_upgr_lights(_veh,_GT_sssn_stf.new.h_light_slct)
			end
			if _GT_sssn_stf.new.max_tint.on then
				vehicle.set_vehicle_window_tint(_veh,1)
			end
			if _GT_sssn_stf.new.invcn_wind.on then
				_GF_set_invncbl_wndws(_veh,true)
			end
			if _GT_sssn_stf.new.plate_i.on then
				vehicle.set_vehicle_number_plate_index(_veh, _GT_sssn_stf.new.plate_i.value)
			end
			if _GT_sssn_stf.new.plate.on then
				vehicle.set_vehicle_number_plate_text(_veh, _GT_sssn_stf.new.spwn_plate_txt)
			end
			system.yield(0)
			_GT_spwn_veh.history[#_GT_spwn_veh.history+1]=_veh
		end
	end

	_GT_sssn_stf.new.optns_prnt=menu.add_feature("Options", "parent", _GT_sssn_stf.spwn_prnt.id)


	_GT_sssn_stf.new.qck_srch_optns = menu.add_feature("Quick Search Options", "parent", _GT_sssn_stf.new.optns_prnt.id)
	menu.add_feature("Display 'quick search' test", "action", _GT_sssn_stf.new.qck_srch_optns.id, function()
		local time = utils.time_ms() + 10000
		local _table = {}
		for i=1,7 do
			_table[i] = _GT_all_veh_info[math.random(1,#_GT_all_veh_info)]
		end
		while time > utils.time_ms() do
			system.yield(0)
			_GT_spwn_veh.ovrly_srch_show(_table, "Vehicle test - Session ".._GF_round_num((time - utils.time_ms())/1000),0,_GT_sssn_stf.new.quick_x.value/300, _GT_sssn_stf.new.quick_y.value/300,false)
		end
	end)
	_GT_sssn_stf.new.quick_x = menu.add_feature("Quick search X Pos", "action_slider", _GT_sssn_stf.new.qck_srch_optns.id, function()
	end)_GF_set_feat_i_f(_GT_sssn_stf.new.quick_x,0,300,1,150)

	_GT_sssn_stf.new.quick_y = menu.add_feature("Quick search Y Pos", "action_slider", _GT_sssn_stf.new.qck_srch_optns.id, function()
	end)_GF_set_feat_i_f(_GT_sssn_stf.new.quick_y,0,300,1,175)

	_GT_sssn_stf.new.mk_mdl_clss_prnt=menu.add_feature("All vehicles by type", "parent", _GT_sssn_stf.spwn_prnt.id)
	_GT_sssn_stf.action_spwn = {}
	_GT_sssn_stf.temp_list_sort = {}
	for i=1,#_GT_class_str_list do
		_GT_sssn_stf.temp_list_sort[i]={}
		for ii=1,#_GT_all_veh_info do
			if _GT_all_veh_info[ii][6] == _GT_class_str_list[i] then
				_GT_sssn_stf.temp_list_sort[i][#_GT_sssn_stf.temp_list_sort[i]+1]=_GT_all_veh_info[ii]
			end
		end
		table.sort(_GT_sssn_stf.temp_list_sort[i], function(a, b) return a[1]:lower() <  b[1]:lower() end)
	end
	for i=1,#_GT_class_str_list do
		_GT_sssn_stf.action_spwn[#_GT_sssn_stf.action_spwn+1] = menu.add_feature(_GT_class_str_list[i], "parent",_GT_sssn_stf.new.mk_mdl_clss_prnt.id)
		for ii=1,#_GT_sssn_stf.temp_list_sort[i] do
			_GT_sssn_stf.temp_list_name = ""
			if _GT_sssn_stf.temp_list_sort[i][ii][2] == "" then
				_GT_sssn_stf.temp_list_name = _GT_sssn_stf.temp_list_sort[i][ii][1]
			else
				_GT_sssn_stf.temp_list_name = _GT_sssn_stf.temp_list_sort[i][ii][1].." - ".._GT_sssn_stf.temp_list_sort[i][ii][2]
			end
			menu.add_feature(_GT_sssn_stf.temp_list_name, "action", _GT_sssn_stf.action_spwn[i].id,function()
				_GF_session_veh_spawn_do(_GT_sssn_stf.temp_list_sort[i][ii][5])
			end)
		end
	end
	
	_GT_sssn_stf.new.spwn_upg = menu.add_feature("Upgrades", "value_str", _GT_sssn_stf.new.optns_prnt.id)
	_GT_sssn_stf.new.spwn_upg:set_str_data({"All","Only performance"})
	_GT_sssn_stf.new.spwn_upg.on=true
	_GT_sssn_stf.new.spwn_f1 = menu.add_feature("Always F1 Wheels", "toggle", _GT_sssn_stf.new.optns_prnt.id)
	_GT_sssn_stf.new.spwn_god = menu.add_feature("God-Mode", "toggle", _GT_sssn_stf.new.optns_prnt.id)
	_GT_sssn_stf.new.max_tint = menu.add_feature("Max tint", "toggle", _GT_sssn_stf.new.optns_prnt.id)
	_GT_sssn_stf.new.invcn_wind = menu.add_feature("Invincible windows", "toggle", _GT_sssn_stf.new.optns_prnt.id)
	_GT_sssn_stf.new.plate_i=menu.add_feature("Plate color", "value_str", _GT_sssn_stf.new.optns_prnt.id)
	_GT_sssn_stf.new.plate_i:set_str_data({"Blue/White","Yellow/black","Yellow/Blue","Blue/White2","Blue/White3","Yankton"})
	_GT_sssn_stf.new.plate_i.value=1
	_GT_sssn_stf.new.plate_i.on=true
	_GT_sssn_stf.new.plate = menu.add_feature("Plate text - ".._GT_sssn_stf.new.spwn_plate_txt, "toggle", _GT_sssn_stf.new.optns_prnt.id,function(f)
		if f.on and _G_GS_has_loaded then
			local status,str = 1,""
			status,str = _GF_text_input_get("Non alpha-numeric characters act as blank space",_GT_spwn_veh.spwn_plate_txt,8,0)
			if status == 0 then
				_GT_spwn_veh.spwn_plate_check("spwn_ssn")
				_GT_spwn_veh.spwn_plate_write(str,"spwn_ssn")
				_GT_sssn_stf.new.spwn_plate_txt=str
				f.name="Plate text - ".._GT_sssn_stf.new.spwn_plate_txt
			else
				f.on=false
			end
		end
	end)
	_GT_sssn_stf.new.plate.on=true
		
	_GT_sssn_stf.new.spwn_spd_tq=menu.add_feature("Vehicle max speed/torque %","action_value_i", _GT_sssn_stf.new.optns_prnt.id,function()
	end)_GF_set_feat_i_f(_GT_sssn_stf.new.spwn_spd_tq,0,700,5,100)	

	_GT_sssn_stf.new.paint_prnt = menu.add_feature("Paint", "parent", _GT_sssn_stf.new.optns_prnt.id, function ()
		_GT_sssn_stf.new.hide_paint(true)
	end)

	function _GT_sssn_stf.new.hide_paint(_bool)
		system.yield(0)
		if _bool then
			for _,feat in pairs(_GT_sssn_stf.new.paint_list) do
				feat.hidden=(not _GT_sssn_stf.new.spwn_cust_paint.on or _GT_sssn_stf.new.spwn_cust_paint.value==0)
			end
			_GT_sssn_stf.new.spwn_cust_paint_r.hidden=(not _GT_sssn_stf.new.spwn_cust_paint.on or _GT_sssn_stf.new.spwn_cust_paint.value==1)
			_GT_sssn_stf.new.spwn_cust_paint_g.hidden=(not _GT_sssn_stf.new.spwn_cust_paint.on or _GT_sssn_stf.new.spwn_cust_paint.value==1)
			_GT_sssn_stf.new.spwn_cust_paint_b.hidden=(not _GT_sssn_stf.new.spwn_cust_paint.on or _GT_sssn_stf.new.spwn_cust_paint.value==1)
		end
	end

	_GT_sssn_stf.new.spwn_rand_paint = menu.add_feature("Random paint", "value_str", _GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.spwn_cust_paint.on=not f.on
		_GT_sssn_stf.new.hide_paint(f.on)
	end)_GT_sssn_stf.new.spwn_rand_paint:set_str_data({"Non-matching", "Matching","Dark","Bright"})
	_GT_sssn_stf.new.spwn_rand_paint.on=true

	_GT_sssn_stf.new.spwn_cust_paint = menu.add_feature("Custom paint", "value_str", _GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.spwn_rand_paint.on=not f.on
		_GT_sssn_stf.new.hide_paint(f.on)
	end)_GT_sssn_stf.new.spwn_cust_paint:set_str_data({"RGB","List"})

	_GT_sssn_stf.new.spwn_cust_paint_r=menu.add_feature("Custom Red","autoaction_value_i",_GT_sssn_stf.new.paint_prnt.id)
	_GF_set_feat_i_f(_GT_sssn_stf.new.spwn_cust_paint_r,0,255,1,0)

	_GT_sssn_stf.new.spwn_cust_paint_g=menu.add_feature("Custom Green","autoaction_value_i",_GT_sssn_stf.new.paint_prnt.id)
	_GF_set_feat_i_f(_GT_sssn_stf.new.spwn_cust_paint_g,0,255,1,0)

	_GT_sssn_stf.new.spwn_cust_paint_b=menu.add_feature("Custom Blue","autoaction_value_i",_GT_sssn_stf.new.paint_prnt.id)
	_GF_set_feat_i_f(_GT_sssn_stf.new.spwn_cust_paint_b,0,255,1,0)

	function _GT_sssn_stf.new.paint_tog_do(_bool,_feat,_paint)
		if _bool then
			_GT_sssn_stf.new.paint_list_slct=_paint
			for _, feat in pairs(_GT_sssn_stf.new.paint_list) do
				if feat ~=_feat then
					feat.on = false
				end
			end
		end
	end

	_GT_sssn_stf.new.paint_list_slct = nil
	_GT_sssn_stf.new.paint_list={}

	_GT_sssn_stf.new.paint_list.pnt_Purewhite=menu.add_feature("Pure white","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Purewhite,16777215)
	end)
	_GT_sssn_stf.new.paint_list.pnt_White=menu.add_feature("White","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_White,13487565)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Cream=menu.add_feature("Cream","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Cream,10197915)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Grey=menu.add_feature("Grey","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Grey,5066061)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Black=menu.add_feature("Black","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Black,0)
	end)
	_GT_sssn_stf.new.paint_list.pnt_PastelPink=menu.add_feature("Pastel Pink","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_PastelPink,15767961)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Pink=menu.add_feature("Pink","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Pink,13317780)
	end)
	_GT_sssn_stf.new.paint_list.pnt_PinkRed=menu.add_feature("Pink/Red","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_PinkRed,14692914)
	end)
	_GT_sssn_stf.new.paint_list.pnt_WineRed=menu.add_feature("Wine Red","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_WineRed,3014656)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Red=menu.add_feature("Red","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Red,7346457)
	end)
	_GT_sssn_stf.new.paint_list.pnt_BrightRed=menu.add_feature("Bright Red","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_BrightRed,16711680)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Salmon=menu.add_feature("Salmon","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Salmon,16761514)
	end)
	_GT_sssn_stf.new.paint_list.pnt_BrightBlue=menu.add_feature("Bright Blue","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_BrightBlue,56306)
	end)
	_GT_sssn_stf.new.paint_list.pnt_LightBlue=menu.add_feature("Light Blue","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_LightBlue,6141669)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Teal=menu.add_feature("Teal","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Teal,3103859)
	end)
	_GT_sssn_stf.new.paint_list.pnt_RoyalBlue=menu.add_feature("Royal Blue","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_RoyalBlue,18309)
	end)
	_GT_sssn_stf.new.paint_list.pnt_CreamYellow=menu.add_feature("Cream Yellow","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_CreamYellow,16706473)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Yellow=menu.add_feature("Yellow","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Yellow,15779920)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Mustard=menu.add_feature("Mustard","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Mustard,8284969)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Brightyellow=menu.add_feature("Bright yellow","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Brightyellow,16757504)
	end)
	_GT_sssn_stf.new.paint_list.pnt_Schoolbus=menu.add_feature("Schoolbus","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_Schoolbus,16750350)
	end)
	_GT_sssn_stf.new.paint_list.pnt_DarkOrange=menu.add_feature("Dark Orange","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_DarkOrange,8340010)
	end)
	_GT_sssn_stf.new.paint_list.pnt_CreamGreen=menu.add_feature("Cream Green","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_CreamGreen,12183225)
	end)
	_GT_sssn_stf.new.paint_list.pnt_LightGreen=menu.add_feature("Light Green","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_LightGreen,7523442)
	end)
	_GT_sssn_stf.new.paint_list.pnt_BrightGreen=menu.add_feature("Bright Green","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_BrightGreen,2803792)
	end)
	_GT_sssn_stf.new.paint_list.pnt_DarkGreen=menu.add_feature("Dark Green","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_DarkGreen,3761721)
	end)
	_GT_sssn_stf.new.paint_list.pnt_CreamPurple=menu.add_feature("Cream Purple","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_CreamPurple,12628975)
	end)
	_GT_sssn_stf.new.paint_list.pnt_BrightPurple=menu.add_feature("Bright Purple","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_BrightPurple,8677090)
	end)
	_GT_sssn_stf.new.paint_list.pnt_DarkPurple=menu.add_feature("Dark Purple","toggle",_GT_sssn_stf.new.paint_prnt.id,function(f)
		_GT_sssn_stf.new.paint_tog_do(f.on,_GT_sssn_stf.new.paint_list.pnt_DarkPurple,4405615)
	end)
	_GT_sssn_stf.new.paint_list.pnt_DarkGreen.on=true

	_GT_sssn_stf.new.neon = {}
	_GT_sssn_stf.new.neon.list={}
	_GT_sssn_stf.new.neon_slct=nil 
	function _GT_sssn_stf.new.neon_tog_do(_bool,_feat,_neon)
		if _bool then
			_GT_sssn_stf.new.neon_slct=_neon
			for _, feat in pairs(_GT_sssn_stf.new.neon.list) do
				if feat ~=_feat then
					feat.on = false
				end
			end
		end
	end

	function _GT_sssn_stf.new.hide_neon(_bool)
		system.yield(0)
		if _bool then
			for _, feat in pairs (_GT_sssn_stf.new.neon.list) do
				feat.hidden=(_GT_sssn_stf.new.neon.choose.value==0)
			end
		end
	end

	_GT_sssn_stf.new.neon.prnt = menu.add_feature("Neon lights", "parent", _GT_sssn_stf.new.optns_prnt.id, function (f)
		_GT_sssn_stf.new.hide_neon(_GT_sssn_stf.new.neon.choose.value==0)
	end)


	_GT_sssn_stf.new.neon.choose=menu.add_feature("Neon color","autoaction_value_str",_GT_sssn_stf.new.neon.prnt.id,function(f)
		_GT_sssn_stf.new.hide_neon(true)
	end)_GT_sssn_stf.new.neon.choose:set_str_data({"Random","List"})

	_GT_sssn_stf.new.neon.list.White=menu.add_feature("White", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.White,4292796159)
	end)
	_GT_sssn_stf.new.neon.list.Blue=menu.add_feature("Blue", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.Blue,4278326783)
	end)
	_GT_sssn_stf.new.neon.list.ElectricBlue=menu.add_feature("Electric Blue", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.ElectricBlue,4278408191)
	end)
	_GT_sssn_stf.new.neon.list.MintGreen=menu.add_feature("Mint Green", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.MintGreen,4278255500)
	end)
	_GT_sssn_stf.new.neon.list.LimeGreen=menu.add_feature("Lime Green", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.LimeGreen,4284415745)
	end)
	_GT_sssn_stf.new.neon.list.Yellow=menu.add_feature("Yellow", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.Yellow,4294967040)
	end)
	_GT_sssn_stf.new.neon.list.GoldenShower=menu.add_feature("Golden Shower", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.GoldenShower,4294940165)
	end)
	_GT_sssn_stf.new.neon.list.Orange=menu.add_feature("Orange", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.Orange,4294917632)
	end)
	_GT_sssn_stf.new.neon.list.Red=menu.add_feature("Red", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.Red,4294902017)
	end)
	_GT_sssn_stf.new.neon.list.PonyPink=menu.add_feature("Pony Pink", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.PonyPink,4294914660)
	end)
	_GT_sssn_stf.new.neon.list.HotPink=menu.add_feature("Hot Pink", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.HotPink,4294903230)
	end)
	_GT_sssn_stf.new.neon.list.Purple=menu.add_feature("Purple", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.Purple,4280484351)
	end)
	_GT_sssn_stf.new.neon.list.BlackLight=menu.add_feature("Black Light", "toggle", _GT_sssn_stf.new.neon.prnt.id, function (f)
		_GT_sssn_stf.new.neon_tog_do(f.on,_GT_sssn_stf.new.neon.list.BlackLight,4279174143)
	end)
	_GT_sssn_stf.new.neon.list.MintGreen.on=true

	_GT_sssn_stf.new.h_light={}
	_GT_sssn_stf.new.h_light.list={}
	_GT_sssn_stf.new.h_light_slct=nil 

	function _GT_sssn_stf.new.h_light_tog_do(_bool,_feat,_h_light)
		if _bool then
			_GT_sssn_stf.new.h_light_slct=_h_light
			for _, feat in pairs(_GT_sssn_stf.new.h_light.list) do
				if feat ~=_feat then
					feat.on = false
				end
			end
		end
	end

	function _GT_sssn_stf.new.hide_h_light(_bool)
		system.yield(0)
		if _bool then
			for _, feat in pairs (_GT_sssn_stf.new.h_light.list) do
				feat.hidden=(_GT_sssn_stf.new.h_light.choose.value==0)
			end
		end
	end

	_GT_sssn_stf.new.h_light.prnt = menu.add_feature("Headlights", "parent", _GT_sssn_stf.new.optns_prnt.id, function (f)
		_GT_sssn_stf.new.hide_h_light(_GT_sssn_stf.new.h_light.choose.value==0)
	end)


	_GT_sssn_stf.new.h_light.choose=menu.add_feature("Headlight color","autoaction_value_str",_GT_sssn_stf.new.h_light.prnt.id,function(f)
		_GT_sssn_stf.new.hide_h_light(true)
	end)_GT_sssn_stf.new.h_light.choose:set_str_data({"Random","List"})

	_GT_sssn_stf.new.h_light.list.White=menu.add_feature("White", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.White,0)
	end)
	_GT_sssn_stf.new.h_light.list.Blue=menu.add_feature("Blue", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.Blue,1)
	end)
	_GT_sssn_stf.new.h_light.list.ElectricBlue=menu.add_feature("Electric Blue", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.ElectricBlue,2)
	end)
	_GT_sssn_stf.new.h_light.list.MintGreen=menu.add_feature("Mint Green", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.MintGreen,3)
	end)
	_GT_sssn_stf.new.h_light.list.LimeGreen=menu.add_feature("Lime Green", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.LimeGreen,4)
	end)
	_GT_sssn_stf.new.h_light.list.Yellow=menu.add_feature("Yellow", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.Yellow,5)
	end)
	_GT_sssn_stf.new.h_light.list.GoldenShower=menu.add_feature("Golden Shower", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.GoldenShower,6)
	end)
	_GT_sssn_stf.new.h_light.list.Orange=menu.add_feature("Orange", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.Orange,7)
	end)
	_GT_sssn_stf.new.h_light.list.Red=menu.add_feature("Red", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.Red,8)
	end)
	_GT_sssn_stf.new.h_light.list.PonyPink=menu.add_feature("Pony Pink", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.PonyPink,9)
	end)
	_GT_sssn_stf.new.h_light.list.HotPink=menu.add_feature("Hot Pink", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.HotPink,10)
	end)
	_GT_sssn_stf.new.h_light.list.Purple=menu.add_feature("Purple", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.Purple,11)
	end)
	_GT_sssn_stf.new.h_light.list.BlackLight=menu.add_feature("Black Light", "toggle", _GT_sssn_stf.new.h_light.prnt.id, function (f)
		_GT_sssn_stf.new.h_light_tog_do(f.on,_GT_sssn_stf.new.h_light.list.BlackLight,12)
	end)
	_GT_sssn_stf.new.h_light.list.MintGreen.on=true

	_GT_sssn_stf.spwn_srch_prnt=menu.add_feature("Make/Model search list", "parent", _GT_sssn_stf.spwn_prnt.id)
	
	_GT_sssn_stf.list_spwn = {}
	_GT_sssn_stf.list_spwn_temp = {}
	_GT_sssn_stf.list_spwn_feat=menu.add_feature("Search for vehicles", "action_value_str", _GT_sssn_stf.spwn_srch_prnt.id, function(f)
		local status,str,veh = 1
		status,str = _GF_text_input_get("Vehicle Make/Model","",25,0)
		if status == 0 then
			_GT_sssn_stf.list_spwn_temp = {}
			_GT_spwn_veh.ovrly_srch_do(str,f.value,_GT_sssn_stf.list_spwn_temp)
			if #_GT_sssn_stf.list_spwn_temp > 0 then
				for i=1,#_GT_sssn_stf.list_spwn do
					system.yield(0)
					if _GT_sssn_stf.list_spwn[i] ~= nil then menu.delete_feature(_GT_sssn_stf.list_spwn[i].id) end
				end
				_GT_sssn_stf.list_spwn = {}
				for i=1,#_GT_sssn_stf.list_spwn_temp do
					if f.value == 0 then
						_GT_sssn_stf.list_spwn[#_GT_sssn_stf.list_spwn+1]=menu.add_feature(_GT_sssn_stf.list_spwn_temp[i][1], "action", _GT_sssn_stf.spwn_srch_prnt.id,function(f,pid)
							_GF_session_veh_spawn_do(_GT_sssn_stf.list_spwn_temp[i][5])
						end)
					else
						_GT_sssn_stf.list_spwn[#_GT_sssn_stf.list_spwn+1]=menu.add_feature(_GT_sssn_stf.list_spwn_temp[i][3], "action", _GT_sssn_stf.spwn_srch_prnt.id,function(f,pid)
							_GF_session_veh_spawn_do(_GT_sssn_stf.list_spwn_temp[i][5])
						end)
					end
				end
			end
		end
	end)_GT_sssn_stf.list_spwn_feat.set_str_data(_GT_sssn_stf.list_spwn_feat,{"Model", "Make","Make or Model"})
	
	_GT_sssn_stf.quick_spwn_prnt=menu.add_feature("Quick spawn list", "parent", _GT_sssn_stf.spwn_prnt.id)
	_GT_sssn_stf.quick_spawn_feats = {}
	for i=1, #_GT_spwn_veh.quick_spawn_list do
		for ii=1, #_GT_all_veh_info do
			if _GT_all_veh_info[ii][5] == gameplay.get_hash_key(_GT_spwn_veh.quick_spawn_list[i]) then
				_GT_sssn_stf.quick_spawn_feats[i]=menu.add_feature(_GT_all_veh_info[ii][1], "action", _GT_sssn_stf.quick_spwn_prnt.id,function()
					_GF_req_stream_hash(_GT_all_veh_info[ii][5])
					_GF_session_veh_spawn_do(_GT_all_veh_info[ii][5])
				end)
				break
			end
		end
	end
	_GT_sssn_stf.quick_spwn = {}
	menu.add_feature("Quick search on-screen", "action", _GT_sssn_stf.spwn_prnt.id, function(f)
		_GT_spwn_veh.quick_start(_GT_sssn_stf.quick_spwn,"Vehicle Spawn - Session",true)
	end)

	function _GF_plyr_spwn_start()
		if _G_plyr_only_none.on then
			menu.notify("Vehicle spawns cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		elseif _G_plyr_veh_plyr_count() < 1 then
			menu.notify("No available players from selection." , _G_GeeVer, 7, 2)
		else
			return true
		end
		return false
	end
	
	function _GF_session_plyr_count_str()
		if _G_plyr_only_none.on then
			return "No players selected"
		elseif _G_plyr_veh_plyr_count() < 1 then
			return "No available players"
		end
		return _G_plyr_veh_plyr_count().." player(s) selected"
	end
	
	function _GF_session_veh_spawn_do(_hash)
		local count,int_count,veh = 0,0
		if _GF_plyr_spwn_start() then
			for pid in _GF_all_players_but_me() do
				if _GF_session_player_do(pid) then
					if _GF_is_pid_intrr(pid) then
						int_count=int_count+1
					else
						count=count+1
						_GF_req_stream_hash(_hash)
						veh = _GF_spawn_veh_at_pid_frnt(pid,_hash,false)
						if not _GF_is_ent(veh) then
							break
						else
							_GT_sssn_stf.new.apply_upgrades(veh)
						end
					end
				end
			end
			if int_count > 0 then
				menu.notify("".. count .. " vehicles spawned.\n"..int_count.." players in interior.", _G_GeeVer, 4, 2)
			else
				menu.notify("".. count .. " vehicles spawned.", _G_GeeVer, 4, 2)
			end
		end
	end
	
	_GT_sssn_stf.hold = {}
	
	_GT_sssn_stf.hold.show_rpr=false
	_GT_sssn_stf.hold.show_rpr_time=5000
	_GT_sssn_stf.hold.rpr=menu.add_feature("Hold (R) repair nearby veh", "value_i", _GT_sssn_stf.opex_prnt.id, function(f)
		local f_value,key = f.value
		while f.on do
			system.yield(25)
			key = _GT_keys_vk_name[_GT_sssn_stf.hold.rpr_key.value+1]
			f.name = "Hold ("..key..") repair nearby veh"
			if f_value ~= f.value then
				_GT_sssn_stf.hold.show_rpr_time=5000
				_GT_sssn_stf.hold.show_rpr=true
				_GT_sssn_stf.hold.show_debug.on=true
				f_value = f.value
			end
			if (not _G_plyr_only_none.on or _G_incl_empty_veh.on) and _GT_sssn_stf.hold.chk(key) then
				if _GT_sssn_stf.hold.show_in_use.on then
					_GT_sssn_stf.hold.show_rpr_time=3000
					_GT_sssn_stf.hold.show_rpr=true
					_GT_sssn_stf.hold.show_debug.on=true
				end
				_GT_sssn_stf.hold._do(_GF_veh_repair_basic,f.value)
				while _GF_vk_key_down(key) do
					system.yield(0)
				end
			end
		end 
	end)_GF_set_feat_i_f(_GT_sssn_stf.hold.rpr,5,100,5,15)
	
	_GT_sssn_stf.hold.show_upgrd=false
	_GT_sssn_stf.hold.show_upgrd_time=5000
	_GT_sssn_stf.hold.upgrd=menu.add_feature("Hold (U) upgrade nearby veh", "value_i", _GT_sssn_stf.opex_prnt.id, function(f)
		local f_value,key = f.value
		while f.on do
			system.yield(25)
			key = _GT_keys_vk_name[_GT_sssn_stf.hold.upgrd_key.value+1]
			f.name = "Hold ("..key..") upgrade nearby veh"
			if f_value ~= f.value then
				_GT_sssn_stf.hold.show_upgrd_time=5000
				_GT_sssn_stf.hold.show_upgrd=true
				_GT_sssn_stf.hold.show_debug.on=true
				f_value = f.value
			end
			if (not _G_plyr_only_none.on or _G_incl_empty_veh.on) and _GT_sssn_stf.hold.chk(key) then
				if _GT_sssn_stf.hold.show_in_use.on then
					_GT_sssn_stf.hold.show_upgrd_time=3000
					_GT_sssn_stf.hold.show_upgrd=true
					_GT_sssn_stf.hold.show_debug.on=true
				end
				_GT_sssn_stf.hold._do(_GF_veh_upgr_all_kek,f.value)
				while _GF_vk_key_down(key) do
					system.yield(0)
				end
			end
		end 
	end)_GF_set_feat_i_f(_GT_sssn_stf.hold.upgrd,5,100,5,15)
	
	_GT_sssn_stf.hold.show_dstry=false
	_GT_sssn_stf.hold.show_dstry_time=5000
	_GT_sssn_stf.hold.dstry=menu.add_feature("Hold (~) destroy nearby veh", "value_i", _GT_sssn_stf.opex_prnt.id, function(f)
		local f_value,key = f.value
		while f.on do
			system.yield(25)
			key = _GT_keys_vk_name[_GT_sssn_stf.hold.dstry_key.value+1]
			f.name = "Hold ("..key..") destroy nearby veh"
			if f_value ~= f.value then
				_GT_sssn_stf.hold.show_dstry_time=5000
				_GT_sssn_stf.hold.show_dstry=true
				_GT_sssn_stf.hold.show_debug.on=true
				f_value = f.value
			end
			if (not _G_plyr_only_none.on or _G_incl_empty_veh.on) and _GT_sssn_stf.hold.chk(key) then
				if _GT_sssn_stf.hold.show_in_use.on then
					_GT_sssn_stf.hold.show_dstry_time=3000
					_GT_sssn_stf.hold.show_dstry=true
					_GT_sssn_stf.hold.show_debug.on=true
				end
				_GT_sssn_stf.hold._do(_GF_veh_destroyed,f.value)
				while _GF_vk_key_down(key) do
					system.yield(0)
				end
			end
		end 
	end)_GF_set_feat_i_f(_GT_sssn_stf.hold.dstry,5,100,5,15)

	_GT_sssn_stf.hold.time=menu.add_feature("Hold delay (ms)", "action_value_i", _GT_sssn_stf.opex_prnt.id)
	_GF_set_feat_i_f(_GT_sssn_stf.hold.time,250,1500,25,750)
	
	_GT_sssn_stf.hold.show_in_use=menu.add_feature("Show range when in use", "toggle", _GT_sssn_stf.opex_prnt.id)
	
	_GT_sssn_stf.hold.rpr_key=menu.add_feature("Key1 for Hold Repair HIDDEN","autoaction_value_str",_GT_sssn_stf.opex_prnt.id)
	_GT_sssn_stf.hold.rpr_key.set_str_data(_GT_sssn_stf.hold.rpr_key,_GT_keys_vk_name)
	_GT_sssn_stf.hold.rpr_key.hidden=true
	_GT_sssn_stf.hold.rpr_key.value=17

	menu.add_feature("Set key for repair","action",_GT_sssn_stf.opex_prnt.id,function()
		_GF_set_keybinds(1,"Repair hold",_GT_sssn_stf.hold.rpr_key)
	end)
	
	_GT_sssn_stf.hold.upgrd_key=menu.add_feature("Key1 for Hold Upgrade HIDDEN","autoaction_value_str",_GT_sssn_stf.opex_prnt.id)
	_GT_sssn_stf.hold.upgrd_key.set_str_data(_GT_sssn_stf.hold.upgrd_key,_GT_keys_vk_name)
	_GT_sssn_stf.hold.upgrd_key.hidden=true
	_GT_sssn_stf.hold.upgrd_key.value=20

	menu.add_feature("Set key for upgrade","action",_GT_sssn_stf.opex_prnt.id,function()
		_GF_set_keybinds(1,"Upgrade hold",_GT_sssn_stf.hold.upgrd_key)
	end)
	
	_GT_sssn_stf.hold.dstry_key=menu.add_feature("Key1 for Hold Destroy HIDDEN","autoaction_value_str",_GT_sssn_stf.opex_prnt.id)
	_GT_sssn_stf.hold.dstry_key.set_str_data(_GT_sssn_stf.hold.dstry_key,_GT_keys_vk_name)
	_GT_sssn_stf.hold.dstry_key.hidden=true
	_GT_sssn_stf.hold.dstry_key.value=63

	menu.add_feature("Set key for destroy","action",_GT_sssn_stf.opex_prnt.id,function()
		_GF_set_keybinds(1,"Destroy hold",_GT_sssn_stf.hold.dstry_key)
	end)
	
	_GT_sssn_stf.hold.show_debug=menu.add_feature("Show  debugs HIDDEN", "toggle", _GT_sssn_stf.opex_prnt.id,function(f)
		local time,red_time,green_time,blue_time = utils.time_ms() + 5000,utils.time_ms(),utils.time_ms(),utils.time_ms()
		while time > utils.time_ms() do
			system.yield(5)
			if _GT_sssn_stf.hold.show_rpr then
				green_time = utils.time_ms()+_GT_sssn_stf.hold.show_rpr_time
				time = utils.time_ms() + 5000
				_GT_sssn_stf.hold.show_rpr=false
			end
			if green_time > utils.time_ms() then 
				graphics.draw_marker(28, player.get_player_coords(player.player_id()), v3(0, 90, 0), v3(0, 90, 0), v3(_GT_sssn_stf.hold.rpr.value, _GT_sssn_stf.hold.rpr.value, _GT_sssn_stf.hold.rpr.value), 0, 255, 0, math.floor((green_time-utils.time_ms()) /1000/5*100), false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
			end
			if _GT_sssn_stf.hold.show_upgrd then
				blue_time = utils.time_ms()+_GT_sssn_stf.hold.show_upgrd_time
				time = utils.time_ms() + 5000
				_GT_sssn_stf.hold.show_upgrd=false
			end
			if blue_time > utils.time_ms() then 
				graphics.draw_marker(28, player.get_player_coords(player.player_id()), v3(0, 90, 0), v3(0, 90, 0), v3(_GT_sssn_stf.hold.upgrd.value, _GT_sssn_stf.hold.upgrd.value, _GT_sssn_stf.hold.upgrd.value), 0, 0, 255, math.floor((blue_time-utils.time_ms()) /1000/5*100), false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
			end
			if _GT_sssn_stf.hold.show_dstry then
				red_time = utils.time_ms()+_GT_sssn_stf.hold.show_dstry_time
				time = utils.time_ms() + 5000
				_GT_sssn_stf.hold.show_dstry=false
			end
			if red_time > utils.time_ms() then 
				graphics.draw_marker(28, player.get_player_coords(player.player_id()), v3(0, 90, 0), v3(0, 90, 0), v3(_GT_sssn_stf.hold.dstry.value, _GT_sssn_stf.hold.dstry.value, _GT_sssn_stf.hold.dstry.value), 255, 0, 0, math.floor((red_time-utils.time_ms()) /1000/5*100), false, false, 2, false, nil, "MarkerTypeDebugSphere", false)
			end
		end
		f.on=false
	end)_GT_sssn_stf.hold.show_debug.hidden=true

	function _GT_sssn_stf.hold.chk(_key_name)
		local time = utils.time_ms() + _GT_sssn_stf.hold.time.value
		while _GF_vk_key_down(_key_name) do
			system.yield(0)
			if time < utils.time_ms() then
				return true
			end
		end
		return false
	end
	
	function _GT_sssn_stf.hold._do(_action,_dist)
		local all_veh,continue=_GF_closest_vehs()
		for i=1,#all_veh do
			continue=false
			if _GF_dist_me_ent(all_veh[i]) > _dist then
				break
			elseif _G_plyr_only_none.on and _G_incl_empty_veh.on then
				if not vehicle.get_vehicle_has_been_owned_by_player(all_veh[i]) then
					continue=true
				end
			elseif _GF_session_plyr_veh_do(all_veh[i]) then
				continue=true
			end	
			if continue then
				_action(all_veh[i],1000)
			end
		end
	end
			
	_G_incl_empty_veh=menu.add_feature("_G_incl_empty_veh HIDDEN","toggle",parent.id,function(f)
		while f.on do
			system.yield(250)
			if not _G_incl_owned_veh.on and not _G_incl_prsnl_veh.on and not _G_incl_npc_veh.on then
				f.on=false
			end
		end
	end)_G_incl_empty_veh.hidden=true
	
	_G_incl_prsnl_veh=menu.add_feature("Include empty personal vehicles","toggle",parent.id,function(f)
		if f.on then
			_G_incl_empty_veh.on=true
		end
	end)
	
	_G_incl_owned_veh=menu.add_feature("Include vehicles players have used","toggle",parent.id,function(f)
		if f.on then
			_G_incl_empty_veh.on=true
		end
	end)
	
	_G_incl_npc_veh=menu.add_feature("Include NPC vehicles","toggle",parent.id,function(f)
		if f.on then
			_G_incl_empty_veh.on=true
		end
	end)
	
	_G_plyr_only_none=menu.add_feature("No players","toggle",parent.id,function(f)
		_G_plyr_excl_friends.hidden=f.on
		_G_plyr_excl_orgmc.hidden=f.on
		_G_plyr_excl_modders.hidden=f.on
		_G_plyr_only_plyrs.hidden=f.on
		_G_on_plyrs_veh_pos_enforce.hidden=f.on
	end)
		

	
	_G_plyr_only_plyrs=menu.add_feature("Only these players","value_str",parent.id,function(f)
		_G_plyr_excl_friends.hidden=f.on 
		_G_plyr_excl_orgmc.hidden=f.on 
		_G_plyr_excl_modders.hidden=f.on 
	end)_G_plyr_only_plyrs:set_str_data({"Friends","My Org/MC","Modders"})
	
	_G_plyr_excl_friends=menu.add_feature("Exclude my friends","toggle",parent.id)

	_G_plyr_excl_orgmc=menu.add_feature("Exclude my ORG/MC/VIP","toggle",parent.id)
	
	_G_plyr_excl_modders=menu.add_feature("Exclude modders","toggle",parent.id)
		
	_G_plyr_only_none.on=true
	
	_G_on_plyrs_veh_pos_enforce=menu.add_feature(">> Check for player vehicle/position if needed","toggle", parent.id)
	
	_G_on_plyrs_veh_pos_names=menu.add_feature(">> Check name change hidden","toggle", parent.id, function(f)
		while f.on do
			system.yield(500)
			if _G_on_plyrs_veh_pos_enforce.on then
				_G_plyr_ped_explode.name= ">> Explode players"
				_G_plyr_ped_burn.name= ">> Burn players"
				_G_plyr_veh_heal.name= ">> Vehicle health"
				_G_plyr_veh_coll2.name= ">> Vehicle Collision"
				_G_plyr_veh_god2.name= ">> Vehicle God"
				_G_plyr_veh_no_lock2.name= ">> Missile anti-lock"
				_G_plyr_veh_force2.name= ">> Vehicle max speed/torque %"
				_G_plyr_veh_upgrades_action2.name= ">> Vehicle upgrades"
				_G_plyr_veh_fuck2.name=">> Fuck vehicles"
				_G_plyr_veh_kick2.name= ">> Vehicle kick"
				_G_plyr_veh_helo_fuck2.name=">> Remove helicopter rotors"
				_G_plyr_veh_rmv_weap.name=">> Remove vehicle weapons"
				_G_plyr_veh_tire_pop2.name= ">> Tire health"
				_G_plyrs_veh_tp_mean_in2.name= ">> TP to interior of"
				_G_plyrs_veh_tp_mean_out2.name= ">> TP high above"
				_G_plyrs_veh_tp_into_air2.name= ">> TP into the air"
				_G_plyrs_veh_tp_to_me2.name= ">> TP to me"
				_G_plyr_veh_flip_wrong.name=">> Flip vehicle upside down"
				_G_plyr_veh_visible.name=">> Vehicle visibility"
				_G_on_plyrs_veh_pos_enforce.name= ">> Check for player vehicle/position if needed"
			else
				_G_plyr_ped_explode.name= "Explode players"
				_G_plyr_ped_burn.name= "Burn players"
				_G_plyr_veh_heal.name= "Vehicle health"
				_G_plyr_veh_coll2.name= "Vehicle Collision"
				_G_plyr_veh_god2.name= "Vehicle God"
				_G_plyr_veh_no_lock2.name= "Missile anti-lock"
				_G_plyr_veh_force2.name= "Vehicle max speed/torque %"
				_G_plyr_veh_upgrades_action2.name= "Vehicle upgrades"
				_G_plyr_veh_fuck2.name="Fuck vehicles"
				_G_plyr_veh_kick2.name= "Vehicle kick"
				_G_plyr_veh_helo_fuck2.name="Remove helicopter rotors"
				_G_plyr_veh_rmv_weap.name="Remove vehicle weapons"
				_G_plyr_veh_tire_pop2.name= "Tire health"
				_G_plyrs_veh_tp_mean_in2.name= "TP to interior of"
				_G_plyrs_veh_tp_mean_out2.name= "TP high above"
				_G_plyrs_veh_tp_into_air2.name= "TP into the air"
				_G_plyrs_veh_tp_to_me2.name= "TP to me"
				_G_plyr_veh_flip_wrong.name="Flip vehicle upside down"
				_G_plyr_veh_visible.name="Vehicle visibility"
				_G_on_plyrs_veh_pos_enforce.name= "Check for player vehicle/position if needed"
			end
		end
	end)
	_G_on_plyrs_veh_pos_names.on=true
	_G_on_plyrs_veh_pos_names.hidden=true
	
	function _GF_session_all_veh_do(_veh)
		if _GF_valid_veh(_veh) and not _GF_any_plyr_in_veh(_veh) and (_G_incl_prsnl_veh.on or _G_incl_owned_veh.on or _G_incl_npc_veh.on) then
			local owner = decorator.decor_get_int(_veh, "Player_Vehicle")
			if owner > 0 then
				for i=1,32 do
					if _GT_plyr_info.net_hash[i]==owner then
						if i-1 == player.player_id() then
							return false
						end
						return _G_incl_prsnl_veh.on
					end
				end
			end
			if vehicle.get_vehicle_has_been_owned_by_player(_veh) then
				return _G_incl_owned_veh.on
			end
			return _G_incl_npc_veh.on
		end
		return false
	end
			
			
	function _GF_session_plyr_veh_do(_veh)
		if not _GF_valid_veh(_veh) or _G_plyr_only_none.on or _GF_me_in_that_veh(_veh) or (decorator.decor_get_int(_veh, "Player_Vehicle") == _GT_plyr_info.net_hash[player.player_id()+1]) then
			return false
		else
			for i = 1,_GF_veh_seats(_veh) do
				if ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(_veh, i-2)) then
					if not _GF_session_player_do(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(_veh, i-2))) then
						return false
					end
				end
			end
		end
		return true
	end
	
	function _GF_session_player_do(_pid)
		if _G_plyr_only_none.on or not _GF_valid_pid(_pid) then
			return false
		else
			local frnd = player.is_player_friend(_pid)
			local mddr = player.is_player_modder(_pid, -1)
			local orgmc = _GF_same_orgmc(player.player_id(),_pid)
			if _G_plyr_only_plyrs.on then
				if _G_plyr_only_plyrs.value == 0 then
					return frnd
				elseif _G_plyr_only_plyrs.value == 1 then
					return orgmc
				end
				return mddr
			else
				if _G_plyr_excl_friends.on and frnd then
					return false
				elseif _G_plyr_excl_orgmc.on and orgmc then
					return false
				elseif _G_plyr_excl_modders.on and mddr then
					return false
				end
			end
		end
		return true
	end
	-----------------------------------------------------------------------------------------GEE-SKID
	--------------------------------------------------------------------------------------PlayersPeds
	--------------------------------------------------------------------------------------------Local
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
	
	_G_plyr_ped_wntd = menu.add_feature("Set wanted level", "value_i",_GT_sssn_stf.ped_prnt.id, function(f,pid)
		if _G_plyr_only_none.on then
			menu.notify("Wanted changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
			f.on = false
		else
			while f.on do
				system.yield(1000)
				for i=0,31 do
					if _GF_session_player_do(i) and i~=player.player_id() and player.get_player_wanted_level(i) ~= f.value then
						_GF_set_wnt_lvl(i,f.value)
					end
				end
			end
		end
	end)_GF_set_feat_i_f(_G_plyr_ped_wntd,0,5,1,0)
	
	_G_plyr_ped_explode=menu.add_feature(">> Explode players","action_value_str",_GT_sssn_stf.ped_prnt.id,function(f, pid)
		local ExplodeTable = {}
		local _blame = 32
		local _blame_name
		if _G_plyr_only_none.on then
			menu.notify("Player explodes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		elseif _GF_session_plyr_start("plyr_explodes") then
			for pid in _GF_all_players_but_me() do
				if _GF_session_player_do(pid) then
					ExplodeTable[#ExplodeTable+1]=pid
				end
			end
			if f.value == 0 then
				_blame = player.player_id()
				_blame_name = "By me :)"
			elseif f.value == 1 then
				_blame_name = "By anon :)"
			elseif f.value == 2 then
				_blame = -1
				_blame_name = "Aloha snackbar :)"
			end
			_GF_plyr_ped_do(ExplodeTable,"explode",_blame,_blame_name,59,60)
		end
		ExplodeTable = nil
	end) _G_plyr_ped_explode.set_str_data(_G_plyr_ped_explode,{"Blame me","Blame no-one","Blame them"})
	
	_G_plyr_ped_burn=menu.add_feature(">> Burn players","action_value_str",_GT_sssn_stf.ped_prnt.id,function(f, pid)
		local BurnTable = {}
		local _blame = 32
		local _blame_name
		if _G_plyr_only_none.on then
			menu.notify("Player burns cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		elseif _GF_session_plyr_start("plyr_burns") then
			for pid in _GF_all_players_but_me() do
				if _GF_session_player_do(pid) then
					BurnTable[#BurnTable+1]=pid
				end
			end
			if f.value == 0 then
				_blame = player.player_id()
				_blame_name = "By me :)"
			elseif f.value == 1 then
				_blame_name = "By anon :)"
			elseif f.value == 2 then
				_blame = -1
				_blame_name = "Aloha snackbar :)"
			end
			_GF_plyr_ped_do(BurnTable,"burn",_blame,_blame_name,3,3)
		end
		BurnTable=nil
	end) _G_plyr_ped_burn.set_str_data(_G_plyr_ped_burn,{"Blame me","Blame no-one","Blame them"})

	_G_plyr_ped_sparrow=menu.add_feature(">> Drop sparrows","action_value_str",_GT_sssn_stf.ped_prnt.id,function(f, pid)
		local SparrowTable = {}
		local _blame = 32
		local _blame_name
		if _G_plyr_only_none.on then
			menu.notify("Sparrow drops cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		elseif _GF_session_plyr_start("sparrow") then
			for pid in _GF_all_players_but_me() do
				if _GF_session_player_do(pid) then
					SparrowTable[#SparrowTable+1]=pid
				end
			end
			if f.value == 0 then
				_GF_plyr_ped_do(SparrowTable,"sparrow")
			elseif f.value == 1 then
				_GF_plyr_ped_do(SparrowTable,"sparrows")
			end
		end
		SparrowTable=nil
	end) _G_plyr_ped_sparrow.set_str_data(_G_plyr_ped_sparrow,{"One", "Many"})
	
	_G_plyr_fat_bitches=menu.add_feature("Spawn angry fat bitches", "action_value_str", _GT_sssn_stf.ped_prnt.id, function(f,pid) --thnks to midnight and kek
		local intrr_count=0
		local spawns=0
		if _G_plyr_only_none.on then
			menu.notify("Fat bitches cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			local ped_model = gameplay.get_hash_key("a_f_m_fatcult_01")
			local weapon1 = gameplay.get_hash_key("weapon_machinepistol")
			local weapon2 = gameplay.get_hash_key("weapon_gusenberg")
			local veh_hash,bitch,bike
			for pid in _GF_all_players_but_me() do
				if _GF_session_player_do(pid) then
					if _GF_is_pid_intrr(pid) then
						intrr_count=intrr_count+1
					else
						spawns=spawns+1
						_GF_req_stream_hash(ped_model)
						if f.value == 0 or f.value == 1 then
							if f.value == 0 then
								veh_hash = gameplay.get_hash_key("bmx")
							else
								veh_hash = gameplay.get_hash_key("deathbike2")
							end
							_GF_req_stream_hash(veh_hash)
						end
						for i=1,3 do
							bitch =_GF_spawn_angry_ped_at_pos(_GF_front_of_pos(_GF_plyr_pos_z_guess(pid), math.random(0,359), 7, 0, .5),ped_model,weapon1,weapon2,pid)
							if f.value == 0 or f.value == 1 then
								bike = _GF_spawn_veh_at_pos(entity.get_entity_coords(bitch),veh_hash,true)
								_GF_weap_worst_simple(bike) --this removes the guns but leaves the blades. Peds suck with Deathbike guns, but will ram the shit outta someone with the blades
								ped.set_ped_into_vehicle(bitch, bike, -1)
								ai.task_vehicle_follow(bitch, bike, player.get_player_ped(pid), 150, 21759548, 50)
							else
								ai.task_go_to_entity_while_aiming_at_entity(bitch, player.get_player_ped(pid), player.get_player_ped(pid),  0.0, true, 0.0, 0.0, false, false, -957453492) -- for on foot. doesnt work perfectly
							end
							system.yield(5)
						end
					end
				end
			end
			menu.notify(""..intrr_count.." players in interior.\n"..(spawns*3).." bitches spawned\n"..spawns.." players" , _G_GeeVer, 7, 2)
		end
	end)_G_plyr_fat_bitches.set_str_data(_G_plyr_fat_bitches,{"On bicycle","On motorcycle","On foot"})
	
	_G_all_plyr_ammo_weap=menu.add_feature("Give ammo/weapons/parachute","action",_GT_sssn_stf.ped_prnt.id,function(f, pid)
		local success=false
		local found, maxAmmo
		local plyr_count = _G_plyr_veh_plyr_count()
		if _G_plyr_only_none.on then
				menu.notify("All players ammo/weapons/parachute cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		elseif plyr_count < 1 then
			menu.notify("No available players from selection." , _G_GeeVer, 7, 2)
		else
			for pid in _GF_all_players_but_me() do
				system.yield(250)
				if _GF_session_player_do(pid) and _GT_plyr_info.plyr_play[pid+1] == true then -- if theyre not playing yet you will get MANY error messages
					for i, weapon_hash in pairs(weapon.get_all_weapon_hashes()) do
						found, maxAmmo = weapon.get_max_ammo(player.get_player_ped(pid), weapon_hash)
						if (found) then
							success=true
							weapon.set_ped_ammo(player.get_player_ped(pid), weapon_hash, maxAmmo)
						else
							menu.notify("".. _GF_plyr_name(pid) .. "\nError - " .. weapon_hash .. " not found :-/", _G_GeeVer, 4, 2)
						end
					end
					if not weapon.has_ped_got_weapon(player.get_player_ped(pid), -72657034) then -- parachute
						weapon.give_delayed_weapon_to_ped(player.get_player_ped(pid), -72657034, 100, true)
						success=true
					end
				end
				if success then
					menu.notify("".. _GF_plyr_name(pid) .. "\nAmmo/weapons/parachute given :)", _G_GeeVer, 4, 2)
				end
				success=false
			end
			menu.notify("All players ammo/weapons/parachute complete", _G_GeeVer, 10, 2)
		end
	end)
	
	-----------------------------------------------------------------------------------------GEE-SKID
	---------------------------------------------------------------------------------------PlayersVeh
	--------------------------------------------------------------------------------------------Local
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------

	_G_plyr_veh_stop_zoom=menu.add_feature("Nearby Vehicles stop/zoom","value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle stop/zoom cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
			f.on=false
		else
			while f.on do
				system.yield(0)
				_G_plyr_veh_stop_zoom_npc.on=_G_incl_empty_veh.on
				if f.value == 0 then
					_GF_session_plyr_action_simple(vehicle.set_vehicle_forward_speed,0,entity.set_entity_velocity,v3(0,0,0))
				else
					_GF_session_plyr_action_simple(vehicle.set_vehicle_forward_speed,200)
				end
				
			end
		end
	end)_G_plyr_veh_stop_zoom:set_str_data({"Stop","Zoom Zoom"})
	
	_G_plyr_veh_stop_zoom_npc=menu.add_feature("Nearby Vehicles stop/zoom NPC HIDDEN","toggle",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		while f.on do
			system.yield(0)
			if _G_plyr_veh_stop_zoom.value == 0 then
				_GF_all_non_plyr_car_do(vehicle.set_vehicle_forward_speed,0,entity.set_entity_velocity,v3(0,0,0))
			else
				_GF_all_non_plyr_car_do(vehicle.set_vehicle_forward_speed,200)
			end
			f.on=(_G_plyr_veh_stop_zoom.on and _G_incl_empty_veh.on)
		end
	end)
	_G_plyr_veh_stop_zoom_npc.hidden=true
-------------------------------------------------------------------------------------------------------------------------------------
	_G_plyr_veh_float=menu.add_feature("Nearby Vehicles float","value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle float cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
			f.on=false
		else
			while f.on do
				system.yield(0)
				_G_plyr_veh_float_npc.on=_G_incl_empty_veh.on
				if f.value == 0 then
					_GF_session_plyr_action_simple(entity.set_entity_velocity,v3(0,0,25))
				else
					_GF_session_plyr_action_simple(entity.set_entity_velocity,v3(0,0,200))
				end
			end
		end
	end)_G_plyr_veh_float:set_str_data({"Gently","YEET"})
	
	_G_plyr_veh_float_npc=menu.add_feature("Nearby Vehicles float NPC HIDDEN","toggle",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		while f.on do
			system.yield(0)
			if _G_plyr_veh_float.value == 0 then
				_GF_all_non_plyr_car_do(entity.set_entity_velocity,v3(0,0,25))
			else
				_GF_all_non_plyr_car_do(entity.set_entity_velocity,v3(0,0,200))
			end
			f.on=(_G_plyr_veh_float.on and _G_incl_empty_veh.on)
		end
	end)
	_G_plyr_veh_float_npc.hidden=true
-------------------------------------------------------------------------------------------------------------------------------------
	_G_plyr_veh_go_down=menu.add_feature("Nearby Vehicles in air go down","value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle velocity changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
			f.on=false
		else
			while f.on do
				system.yield(0)
				_G_plyr_veh_go_down_npc.on=_G_incl_empty_veh.on
				if f.value == 0 then
					_GF_session_plyr_action_simple(entity.set_entity_velocity,v3(0,0,-25),nil,nil,entity.is_entity_in_air,true)
				else
					_GF_session_plyr_action_simple(entity.set_entity_velocity,v3(0,0,-200),nil,nil,entity.is_entity_in_air,true)
				end
			end
		end
	end)_G_plyr_veh_go_down:set_str_data({"Gently","YEET"})
	
	_G_plyr_veh_go_down_npc=menu.add_feature("Nearby Vehicles in air go down NPC HIDDEN","toggle",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		while f.on do
			system.yield(0)
			f.on=(_G_plyr_veh_go_down.on and _G_incl_empty_veh.on)
			if _G_plyr_veh_go_down.value == 0 then
				_GF_all_non_plyr_car_do(entity.set_entity_velocity,v3(0,0,-25),nil,nil,entity.is_entity_in_air,true)
			else
				_GF_all_non_plyr_car_do(entity.set_entity_velocity,v3(0,0,-200),nil,nil,entity.is_entity_in_air,true)
			end
		end
	end)
	_G_plyr_veh_go_down_npc.hidden=true
-------------------------------------------------------------------------------------------------------------------------------------
	_G_plyr_veh_go_up=menu.add_feature("Nearby Vehicles on ground go up","value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle velocity changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
			f.on=false
		else
			while f.on do
				system.yield(0)
				_G_plyr_veh_go_up_npc.on=_G_incl_empty_veh.on
				if f.value == 0 then
					_GF_session_plyr_action_simple(entity.set_entity_velocity,v3(0,0,25),nil,nil,entity.is_entity_in_air,false)
				else
					_GF_session_plyr_action_simple(entity.set_entity_velocity,v3(0,0,200),nil,nil,entity.is_entity_in_air,false)
				end
			end
		end
	end)_G_plyr_veh_go_up:set_str_data({"Gently","YEET"})

	_G_plyr_veh_go_up_npc=menu.add_feature("Nearby Vehicles on ground go up NPC HIDDEN","toggle",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		while f.on do
			system.yield(0)
			if _G_plyr_veh_go_up.value == 0 then
				_GF_all_non_plyr_car_do(entity.set_entity_velocity,v3(0,0,25),nil,nil,entity.is_entity_in_air,false)
			else
				_GF_all_non_plyr_car_do(entity.set_entity_velocity,v3(0,0,200),nil,nil,entity.is_entity_in_air,false)
			end
			f.on=(_G_plyr_veh_go_up.on and _G_incl_empty_veh.on)
		end
	end)
	_G_plyr_veh_go_up_npc.hidden=true
-------------------------------------------------------------------------------------------------------------------------------------
	_G_plyr_veh_grav=menu.add_feature("Gravity","value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
				menu.notify("Vehicle gravity cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
				f.on=false
		else
			while f.on do
				system.yield(0)
				_G_plyr_veh_grav_npc.on=_G_incl_empty_veh.on
				_GF_session_plyr_action_simple(entity.set_entity_gravity,f.value == 0)
			end
		end
	end)_G_plyr_veh_grav:set_str_data({"Give","Remove"})
	
	_G_plyr_veh_grav_npc=menu.add_feature("Gravity NPC HIDDEN","toggle",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		while f.on do
			system.yield(0)
			_GF_all_non_plyr_car_do(entity.set_entity_gravity,_G_plyr_veh_grav.value == 0)
			f.on=(_G_plyr_veh_grav.on and _G_incl_empty_veh.on)
		end
	end)
	_G_plyr_veh_grav_npc.hidden=true
-------------------------------------------------------------------------------------------------------------------------------------


	_G_plyr_veh_auto_repair=menu.add_feature("Auto-repair if less than %","value_i",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Auto-repair cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
			f.on=false
		else
			while f.on do
				_G_plyr_veh_auto_repair_npc.on=_G_incl_empty_veh.on
				system.yield(500)
				for i=0,31 do
					if _GF_valid_pid(i) and i ~= player.player_id() and player.is_player_in_any_vehicle(i) then
						if _GF_get_veh_cmbnd_hlth_prcnt(player.get_player_vehicle(i),true) < f.value and _GF_session_player_do(i) then
							_GF_rpr_request(player.get_player_vehicle(i),1000)
						end
					end
				end
			end
		end
	end)_GF_set_feat_i_f(_G_plyr_veh_auto_repair,50,100,5,75)

	_G_plyr_veh_auto_repair_npc=menu.add_feature("Auto-repair NPC HIDDEN","toggle",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		local all_veh
		while f.on do
			system.yield(500)
			all_veh=vehicle.get_all_vehicles()
			for i=1, #all_veh do
				if not vehicle.get_vehicle_has_been_owned_by_player(all_veh[i]) and _GF_get_veh_cmbnd_hlth_prcnt(all_veh[i],true) < _G_plyr_veh_auto_repair.value then
					_GF_rpr_request(all_veh[i],100)
				end
			end
			f.on=(_G_plyr_veh_auto_repair.on and _G_incl_empty_veh.on)
		end
	end)
	_G_plyr_veh_auto_repair_npc.hidden=true
	
	--------------------------------------------------------------------------------------------------------------------------------------------
	_GT_sssn_stf.hrn_bst_feat=menu.add_feature("Horn-boost","slider",_GT_sssn_stf.hrn_bst.id,function(f)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Horn-boost cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
			f.on=false
		else
			local _table,speed,initial = {}
			for i=1,32 do
				_table[i]=0
			end
			while f.on do
				system.yield(25)
				initial = _GT_sssn_stf.hrn_bst_initial.value
				_GT_sssn_stf.hrn_bst_feat_npc.on = _G_incl_empty_veh.on
				for i=0,31 do
					if player.is_player_valid(i) and i ~= player.player_id() and player.is_player_in_any_vehicle(i) and not _GF_is_veh_alarm_on(player.get_player_vehicle(i)) and _GF_is_veh_horn_on(player.get_player_vehicle(i)) and _table[i+1] < utils.time_ms() and _GF_session_player_do(i) then
						_table[i+1]=utils.time_ms()+_GT_sssn_stf.hrn_bst_delay.value
						if _GF_request_ctrl(player.get_player_vehicle(i),_GT_sssn_stf.hrn_bst_delay.value) then
							speed = (entity.get_entity_speed(player.get_player_vehicle(i)))
							--speed = speed + (3+(40*f.value)-(0.02*speed))
							speed = speed + (initial*3+(initial*40*f.value)-(initial*0.02*speed))
							
							speed = speed * (1.01+f.value)
							vehicle.set_vehicle_forward_speed(player.get_player_vehicle(i),speed)
						end
					end
				end
			end
		end
	end)_GF_set_feat_i_f(_GT_sssn_stf.hrn_bst_feat,0,.1,.01,0)
	
	_GT_sssn_stf.hrn_bst_delay=menu.add_feature("Boost delay","action_value_i",_GT_sssn_stf.hrn_bst.id)
	_GF_set_feat_i_f(_GT_sssn_stf.hrn_bst_delay,50,1000,50,300)
	
	_GT_sssn_stf.hrn_bst_initial=menu.add_feature("Initial boost","action_value_f",_GT_sssn_stf.hrn_bst.id)
	_GF_set_feat_i_f(_GT_sssn_stf.hrn_bst_initial,.5,3,.1,1)
	
	_GT_sssn_stf.hrn_bst_feat_npc=menu.add_feature("Horn-boost NPC HIDDEN","toggle",_GT_sssn_stf.hrn_bst.id,function(f, pid)
		local time,_table,all_veh,speed,initial = utils.time_ms(),{}
		while f.on do
			system.yield(25)
			initial = _GT_sssn_stf.hrn_bst_initial.value
			f.on = (_GT_sssn_stf.hrn_bst_feat.on and _G_incl_empty_veh.on)
			if time < utils.time_ms() then
				all_veh=_GF_closest_vehs()
				time = utils.time_ms() +2000
			end
			for i=1,#all_veh do
				if _table[all_veh[i]] == nil then
					_table[all_veh[i]] = utils.time_ms()
				end
				if _table[all_veh[i]] < utils.time_ms() and not _GF_is_veh_alarm_on(all_veh[i]) and _GF_is_veh_horn_on(all_veh[i]) and _GF_session_all_veh_do(all_veh[i]) and _GF_request_ctrl(all_veh[i],25) then
					speed = (entity.get_entity_speed(all_veh[i]))
					--speed = speed + (3+(40*_GT_sssn_stf.hrn_bst_feat.value)-(0.02*speed))
					speed = speed + (initial*3+(initial*40*_GT_sssn_stf.hrn_bst_feat.value)-(initial*0.02*speed))
					speed = speed * (1.01+_GT_sssn_stf.hrn_bst_feat.value)
					vehicle.set_vehicle_forward_speed(all_veh[i],speed)
					_table[all_veh[i]] = utils.time_ms()+math.floor(_GT_sssn_stf.hrn_bst_delay.value*.5)
				end
			end
		end
	end)
	_GT_sssn_stf.hrn_bst_feat_npc.hidden=true

	_GT_sssn_stf.hrn_hnk=menu.add_feature("Honk horn","action_value_str",_GT_sssn_stf.hrn_bst.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Horn honks cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			_GT_sssn_stf.hrn_hnk_npc.on=_G_incl_empty_veh.on
			for i=0,31 do
				if player.is_player_valid(i) and --[[i ~= player.player_id() and]] _GF_plyr_in_seat(player.get_player_vehicle(i),-1,i) and _GF_session_player_do(i) then
					if f.value == 0 and not _GF_is_veh_horn_on(player.get_player_vehicle(i)) and _GF_request_ctrl(player.get_player_vehicle(i),1000) then
						native.call(0x9C8C6504B5B63D2C,player.get_player_vehicle(i),5000,gameplay.get_hash_key("HELDDOWN"),1)
					elseif f.value == 1 and _GF_is_veh_horn_on(player.get_player_vehicle(i)) and _GF_request_ctrl(player.get_player_vehicle(i),1000) then
						native.call(0x9C8C6504B5B63D2C,player.get_player_vehicle(i),0,0,0)
					end
				end
			end
		end
	end)_GT_sssn_stf.hrn_hnk:set_str_data({"Honk","Stop"})	
	
	_GT_sssn_stf.hrn_hnk_npc=menu.add_feature("Honk horn NPC HIDDEN","toggle",_GT_sssn_stf.hrn_bst.id,function(f, pid)
		if f.on then
			local all_veh=_GF_closest_vehs()
			for i=1,#all_veh do
				if _GF_session_all_veh_do(all_veh[i]) then
					if _GT_sssn_stf.hrn_hnk.value == 0 and not _GF_is_veh_horn_on(all_veh[i]) and _GF_request_ctrl(all_veh[i],100) then
						native.call(0x9C8C6504B5B63D2C,all_veh[i],5000,gameplay.get_hash_key("HELDDOWN"),1)
					elseif _GT_sssn_stf.hrn_hnk.value == 1 and _GF_is_veh_horn_on(all_veh[i]) and _GF_request_ctrl(all_veh[i],100) then
						native.call(0x9C8C6504B5B63D2C,all_veh[i],0,0,0)
					end
				end
			end
		end
		f.on=false
	end)
	_GT_sssn_stf.hrn_hnk_npc.hidden=true
	
	
----------------------------------------------------------------------------------------------------------------------------------
	_G_plyr_veh_heal=menu.add_feature(">> Vehicle health","action_value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
				menu.notify("Vehicle health changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("health") then
				if _G_incl_empty_veh.on then
					if f.value == 0 then
						_GF_all_veh_action("repair",100,true,nil,nil)
					elseif f.value == 1 then
						_GF_all_veh_action("damage",100,true,nil,nil)
					elseif f.value == 2 then
						_GF_all_veh_action("destroy",100,true,nil,nil)
					end
				end
				if f.value == 0 then
					_GF_session_plyr_action("repair","check_both")
				elseif f.value == 1 then
					_GF_session_plyr_action("damage","check_both")
				elseif f.value == 2 then
					_GF_session_plyr_action("destroy","check_both")
				end
			end
			if _G_incl_empty_veh.on then
				if f.value == 0 then
					_GF_all_veh_action("repair",100,true,nil,nil)
				elseif f.value == 1 then
					_GF_all_veh_action("damage",100,true,nil,nil)
				else
					for i=1,3 do
						_GF_all_veh_action("destroy",100,true,nil,nil)
					end
				end
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Vehicle health changes complete", _G_GeeVer, 10, 2)
			end
		end
	end)			
	_G_plyr_veh_heal:set_str_data({
	"Repair",
	"Damage",
	"Destroy"})

	_G_plyr_veh_coll2=menu.add_feature(">> Vehicle Collision","action_value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid) 
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle Collision changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("collision") then
				if _G_incl_empty_veh.on then
					if f.value == 0 then
						_GF_all_veh_action("collision",100,true,0,true)
					elseif f.value == 1 then
						_GF_all_veh_action("collision",100,true,0,false)
					end
				end
				if f.value == 0 then
					_GF_session_plyr_action("collision","check_both",true)
				elseif f.value == 1 then
					_GF_session_plyr_action("collision","check_both",false)
				end
			end
			if _G_incl_empty_veh.on then
				if f.value == 0 then
					_GF_all_veh_action("collision",1000,true,0,true)
				elseif f.value == 1 then
					_GF_all_veh_action("collision",1000,true,0,false)
				end
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Vehicle collision changes complete", _G_GeeVer, 10, 2)
			end
		end
	end)			
	_G_plyr_veh_coll2:set_str_data({
	"Give",
	"Remove"})

	_G_plyr_veh_god2=menu.add_feature(">> Vehicle God","action_value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle God changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("god") then
				if _G_incl_empty_veh.on then
					if f.value == 0 then
						_GF_all_veh_action("god",100,true,nil,true)
					elseif f.value == 1 then
						_GF_all_veh_action("god",100,true,nil,false)
					end
				end
				if f.value == 0 then
					_GF_session_plyr_action("god","check_both",true)
				elseif f.value == 1 then
					_GF_session_plyr_action("god","check_both",false)
				end
			end
			if _G_incl_empty_veh.on then
				if f.value == 0 then
					_GF_all_veh_action("god",1000,true,nil,true)
				elseif f.value == 1 then
					_GF_all_veh_action("god",1000,true,nil,false)
				end
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Vehicle god changes complete", _G_GeeVer, 10, 2)
			end
		end
	end)			
	_G_plyr_veh_god2:set_str_data({
	"Give",
	"Remove"})

	_G_plyr_veh_no_lock2=menu.add_feature(">> Missile anti-lock","action_value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on then
			menu.notify("Missile anti-lock changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("anti_lock") then
				if f.value == 0 then
					_GF_session_plyr_action("anti_lock","check_both",false)
				elseif f.value == 1 then
					_GF_session_plyr_action("anti_lock","check_both",true)
				end
				menu.notify("Missile anti-lock changes complete", _G_GeeVer, 10, 2)
			end
		end
	end)			
	_G_plyr_veh_no_lock2:set_str_data({
	"Give",
	"Remove"})

	_G_plyr_veh_force2=menu.add_feature(">> Vehicle max speed/torque %","action_value_f",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle speed/torque changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("speed_torque") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("speed_torque",100,true,f.value/100,nil)
				end
				_GF_session_plyr_action("speed_torque","check_both",true,f.value/100)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("speed_torque",1000,true,f.value/100,nil)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Vehicle speed/torque changes complete", _G_GeeVer, 10, 2)
			end
		end
	end)_G_plyr_veh_force2.max,_G_plyr_veh_force2.min,_G_plyr_veh_force2.mod=700,0,5		
	_G_plyr_veh_force2.value=100
	
	_G_plyr_veh_fuck2=menu.add_feature(">> Fuck vehicles","action",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle fucks cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("fucked") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("fucked",100,true,nil,nil)
				end
				_GF_session_plyr_action("fucked","check_both",true)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("fucked",1000,true,nil,nil)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Vehicle fucks complete", _G_GeeVer, 10, 2)
			end
		end
	end)
	
	_G_plyr_veh_upgrades_action2=menu.add_feature(">> Vehicle Upgrades","action",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle upgrades cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("upgrades") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("upgrades",100,true,nil,nil)
				end
				_GF_session_plyr_action("upgrades","check_both",true)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("upgrades",1000,true,nil,nil)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Vehicle upgrades complete", _G_GeeVer, 10, 2)
			end
		end
	end)
	
	_G_plyr_veh_kick2=menu.add_feature(">> Vehicle kick","action",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle kicks cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("veh_kick") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("veh_kick",nil,true,nil,nil)
				end
				_GF_session_plyr_action("veh_kick","check_both",true)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("veh_kick",nil,true,nil,nil)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Vehicle kicks complete", _G_GeeVer, 10, 2)
			end
		end
	end)
	
	_G_plyr_veh_helo_fuck2=menu.add_feature(">> Remove helicopter rotors","action",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Helicopter fucks cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("remove_rotor") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("remove_rotor",100,true,nil,nil)
				end
				_GF_session_plyr_action("remove_rotor","check_both")
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("remove_rotor",1000,true,nil,nil)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Helicopter fucks complete", _G_GeeVer, 10, 2)
			end
		end
	end)
	
	_G_plyr_veh_rmv_weap=menu.add_feature(">> Remove vehicle weapons","action",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Weapon removal cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("rmv_veh_weap") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("rmv_veh_weap",100,true,nil,nil)
				end
				_GF_session_plyr_action("rmv_veh_weap","check_both")
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("rmv_veh_weap",1000,true,nil,nil)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Weapon removal complete", _G_GeeVer, 10, 2)
			end
		end
	end)
	
	_G_plyr_veh_tire_pop2=menu.add_feature(">> Tire health","action_value_str",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Tire health changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			local tire = "pop_tires"
			if f.value == 1 then
				tire = "unpop_tires"
			end
			if _GF_session_plyr_start(tire) then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action(tire,100,true,nil,nil)
				end
				_GF_session_plyr_action(tire,"check_both",true)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action(tire,1000,true,nil,nil)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Tire health changes complete", _G_GeeVer, 10, 2)
			end
		end
	end)_G_plyr_veh_tire_pop2.set_str_data(_G_plyr_veh_tire_pop2,{"Pop", "Repair"})
	
	_G_plyr_veh_flip_wrong=menu.add_feature(">> Flip vehicle upside down","action",_GT_sssn_stf.veh_prnt.id,function(f, pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle flips cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if _GF_session_plyr_start("flip_wrong") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("flip_wrong",100,true,nil,nil)
				end
				_GF_session_plyr_action("flip_wrong","check_both",true)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("flip_wrong",1000,true,nil,nil)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Vehicle flips complete", _G_GeeVer, 10, 2)
			end
		end
	end)

	_G_plyr_veh_visible=menu.add_feature(">> Vehicle visibility", "action_value_str", _GT_sssn_stf.veh_prnt.id, function(f,pid)
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle visibilty changes cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			local _bool = true
			if f.value==0 then _bool = false
			end
			if _GF_session_plyr_start("visible") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("visible",100,true,nil,_bool)
				end
				_GF_session_plyr_action("visible","check_both",_bool)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("visible",1000,true,nil,_bool)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Visibilty changes complete", _G_GeeVer, 7, 2)
			end
		end
	end)_G_plyr_veh_visible.set_str_data(_G_plyr_veh_visible,{"Invisible", "Visible"})
	
	
	_G_plyrs_veh_tp_mean_in2=menu.add_feature(">> TP to interior of","action_value_str",_GT_sssn_stf.tp_prnt.id,function(f, pid)
		local pos, loc
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle teleports cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if f.value == 0 then
				pos = v3(math.random(-82, -67), math.random(-825, -812), math.random(312, 317))
				loc = tostring("Maze bank glitch.")
			elseif f.value == 1 then
				pos = v3(math.random(129,142),math.random(-754,-743),math.random(259,261))
				loc = tostring("FIB interior.")	
			elseif f.value == 2 then
				pos = v3(math.random(-799, -757),math.random(318, 338),math.random(107, 127))
				loc = tostring("Apartment glitch.")		
			end
			if _GF_session_plyr_start("tp") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("tp",100,true,pos,false)
				end
				_GF_session_plyr_action("tp","check_both",false,pos,loc)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("tp",1000,true,pos,false)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Teleports complete", _G_GeeVer, 7, 2)
			end
		end
	end) _G_plyrs_veh_tp_mean_in2.set_str_data(_G_plyrs_veh_tp_mean_in2,{"Maze bank glitch", "FIB building top","Apartment glitch"})			
	
	_G_plyrs_veh_tp_mean_out2=menu.add_feature(">> TP high above","action_value_str",_GT_sssn_stf.tp_prnt.id,function(f, pid)
		local pos,loc
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle teleports cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if f.value == 0 then
				local ocean = math.random(0,3)
				if ocean == 0 then
					pos = v3(math.random(1230, 1250), math.random(10200, 10220), 2200) -- ocean north
				elseif ocean == 1 then
					pos = v3(math.random(410, 430), math.random(-7820, -7800), 2200) -- ocean south
				elseif ocean == 2 then
					pos = v3(math.random(7930, 7950), math.random(2180, 2200), 2200) -- ocean east
				elseif ocean == 3 then
					pos = v3(math.random(-7980, -7960), math.random(1880, 1900), 2200) -- ocean west
				end
				loc = tostring("High above the ocean.")
			elseif f.value == 1 then
				pos = v3(math.random(487, 497), math.random(5582, 5592), 2200)
				loc = tostring("High above Mt. Chiliad.")
			else
				pos = v3(math.random(-1000, 850), math.random(-1600, 130), 2200)
				loc = tostring("High above the city.")
			end
			if _GF_session_plyr_start("tp") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("tp",100,true,pos,false)
				end
				_GF_session_plyr_action("tp","check_both",true,pos,loc)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("tp",1000,true,pos,false)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Teleports complete", _G_GeeVer, 7, 2)
			end
		end
	end) _G_plyrs_veh_tp_mean_out2.set_str_data(_G_plyrs_veh_tp_mean_out2,{"The Ocean","Mt. Chiliad","The City"})		

	_G_plyrs_veh_tp_into_air2=menu.add_feature(">> TP into the air","action_value_str",_GT_sssn_stf.tp_prnt.id,function(f, pid)
		local z_pos,loc
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle teleports cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if f.value == 0 then
				loc = tostring("50m up.")
				z_pos = 50
			elseif f.value == 1 then
				loc = tostring("250m up.")
				z_pos = 250
			else
				loc = tostring("1000m up.")
				z_pos = 1000
			end
			if _GF_session_plyr_start("tp_up") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("tp_up",100,true,z_pos,true)
				end
				_GF_session_plyr_action("tp_up","check_both",true,z_pos,loc)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("tp_up",1000,true,z_pos,true)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Teleports complete", _G_GeeVer, 7, 2)
			end
		end
	end) _G_plyrs_veh_tp_into_air2.set_str_data(_G_plyrs_veh_tp_into_air2,{"50m up","250m up","1000m up"})		

	_G_plyrs_veh_tp_to_me2=menu.add_feature(">> TP their vehicles to me","action_value_str",_GT_sssn_stf.tp_prnt.id,function(f, pid)
		local _my_pos_rand,loc
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle teleports cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if f.value == 0 then
				loc = "In front of me."
				_my_pos_rand = "front"
			elseif f.value == 1 then
				loc = "250m up."
				_my_pos_rand = "250_up"
			else
				loc = tostring("1000m up.")
				_my_pos_rand = "1000_up"
			end
			if _GF_session_plyr_start("tp_2_me") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("tp_2_me",100,true,nil,false,_my_pos_rand)
				end
				_GF_session_plyr_action("tp_2_me","check_both",false,nil,loc,_my_pos_rand)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("tp_2_me",1000,true,nil,false,_my_pos_rand)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Teleports complete", _G_GeeVer, 7, 2)
			end
		end
	end) _G_plyrs_veh_tp_to_me2.set_str_data(_G_plyrs_veh_tp_to_me2,{"In front of me","250m up","1000m up"})
	
	_G_plyrs_veh_tp_to_random=menu.add_feature(">> TP to random location","action_value_str",_GT_sssn_stf.tp_prnt.id,function(f, pid)
		local _type,loc
		if _G_plyr_only_none.on and not _G_incl_empty_veh.on then
			menu.notify("Vehicle teleports cancelled\nYou must select a target" , _G_GeeVer, 7, 2)
		else
			if f.value == 0 then
				_type = "land"
				loc = "Random land location."
			elseif f.value == 1 then
				_type = "water"
				loc = "Random ocean location."
			else
				_type = "anywhere"
				loc = "Random location."
			end
			if _GF_session_plyr_start("tp") then
				if _G_incl_empty_veh.on then
					_GF_all_veh_action("random",100,true,_type,false)
				end
				_GF_random_pos(_type,"session")
				_GF_session_plyr_action("random","check_both",false,nil,loc)
			end
			if _G_incl_empty_veh.on then
				_GF_all_veh_action("random",1000,true,_type,false)
			end
			if _G_plyr_veh_plyr_count() > 0 or _G_incl_empty_veh.on then
				menu.notify("Teleports complete", _G_GeeVer, 7, 2)
			end
		end
	end) _G_plyrs_veh_tp_to_random.set_str_data(_G_plyrs_veh_tp_to_random,{"On land","In water","Anywhere"})	
end


function _GF_session_plyr_start(_action)
	local plyr_count = _G_plyr_veh_plyr_count()
	local timer = 2500 * plyr_count
	local notif_timer = math.floor(timer/1000)
	local action_str = "Changes"
	if not _G_plyr_only_none.on then
		if plyr_count > 0 then
			if _action == "god" then
				action_str = "Vehicle God changes"
			elseif _action == "collision" then
				action_str = "Vehicle Collision changes"
			elseif _action == "repair" or _action == "damage" or _action == "destroy" or _action == "health" then
				action_str = "Vehicle health changes"
			elseif _action == "anti_lock" then
				action_str = "Missile anti-lock changes"
			elseif _action == "speed_torque" then
				action_str = "Vehicle speed/torque changes"
			elseif _action == "fucked" then
				action_str = "Vehicle fucks"
			elseif _action == "upgrades" or _action == "upgrade_single" then
				action_str = "Vehicle upgrades"
			elseif _action == "veh_kick" then
				notif_timer = math.floor(notif_timer/4)
				action_str = "Vehicle kicks"
			elseif _action == "remove_rotor" then
				action_str = "Helicopter fucks"
			elseif _action == "rmv_veh_weap" then
				action_str = "Weapon removal"
			elseif _action == "pop_tires" then
				action_str = "Tire pops"
			elseif _action == "unpop_tires" then
				action_str = "Tire repairs"
			elseif _action == "visible" then
				action_str = "Visibilty changes"
			elseif _action == "tp" or _action == "tp_up" or _action == "tp_2_me" or _action == "random" then
				action_str = "Player teleports"
			elseif _action == "plyr_explodes" then
				action_str = "Player explodes"
			elseif _action == "plyr_burns" then
				action_str = "Player burns"
			elseif _action == "sparrow" then
				action_str = "Sparrow drops"
			end
			menu.notify(""..action_str.." will be attempted for up to " .. notif_timer .. " seconds.\nTotal of " .. plyr_count .. " players" , _G_GeeVer, 10, 2)
			return true
		else
			menu.notify("No available players from selection." , _G_GeeVer, 4, 2)
		end
	end
	return false
end

function _GF_session_plyr_action(_action,_type,_bool,_val,_str,_my_pos_rand)
	local Table = {}
	local unselected_player,no_need,no_veh,intrr,unable,count,complete,no_check_no_veh = 0,0,0,0,0,0,0,0
	_G_on_plyrs_veh_pos_enforce.hidden=true
	if _type == "if_has_veh" or _type == "check_both" then
		for pid in _GF_all_players_but_me() do
			if not player.is_player_in_any_vehicle(pid) then
				no_check_no_veh=no_check_no_veh+1
			elseif not _GF_session_plyr_veh_do(player.get_player_vehicle(pid)) then
				unselected_player=unselected_player+1
			else
				count=count+1
				time = utils.time_ms() + 3000
				local name = _GF_plyr_name(pid)
				local model_name = _GF_model_name(player.get_player_vehicle(pid))
				if _action == "god" then
					if entity.get_entity_god_mode(player.get_player_vehicle(pid)) ~= _bool then
						if _GF_veh_god(player.get_player_vehicle(pid),_bool,2500,name,model_name) then
							Table[#Table+1]=pid
						end
					else
						no_need=no_need+1
					end
				elseif _action == "collision" then
					if _GF_veh_collision(player.get_player_vehicle(pid),_bool,name, model_name,2500) then
						Table[#Table+1]=pid
					end
				elseif _action == "repair" then
					if _GF_veh_repair_basic(player.get_player_vehicle(pid), 2500) then
						Table[#Table+1]=pid
					end
				elseif _action == "damage" then
					if _GF_veh_damaged(player.get_player_vehicle(pid),2500, name, model_name,pid,false) then
						Table[#Table+1]=pid
					end
				elseif _action == "destroy" then
					if _GF_veh_destroyed(player.get_player_vehicle(pid),2500, name, model_name) then
						Table[#Table+1]=pid
					end
				elseif _action == "anti_lock" then
					if _GF_missile_antilock(player.get_player_vehicle(pid), _bool, name, model_name,2500) then
						Table[#Table+1]=pid
					end
				elseif _action == "speed_torque" then
					if _GF_veh_speed(player.get_player_vehicle(pid), 2500, name, model_name, _bool, _val) then
						Table[#Table+1]=pid
					end
				elseif _action == "fucked" then
					if _GF_veh_is_fucked(player.get_player_vehicle(pid), 2500,_bool) then
						Table[#Table+1]=pid
					end
				elseif _action == "upgrades" then
					if _GF_veh_upgr_all_kek(player.get_player_vehicle(pid), 1000, _bool) then
						Table[#Table+1]=pid
					end
				elseif _action == "upgrade_single" then
					if _GF_veh_upgr_one_kek(player.get_player_vehicle(pid), 1000, _val, _bool) then
						Table[#Table+1]=pid
					end
				elseif _action == "veh_kick" then
					if _GF_plyr_veh_kick(pid, _bool) then
						Table[#Table+1]=pid
					end
				elseif _action == "remove_rotor" then
					if _GF_valid_helo(player.get_player_vehicle(pid)) then
						if _GF_request_ctrl(player.get_player_vehicle(pid), 2500) then
							vehicle.set_vehicle_extra(player.get_player_vehicle(pid), 1, 0)
							vehicle.set_vehicle_extra(player.get_player_vehicle(pid), 2, 0)
							vehicle.set_vehicle_extra(player.get_player_vehicle(pid), 7, 0)
							menu.notify("".. name .. " - " .. model_name .. "\nHelicopter fucked :)", _G_GeeVer, 7, 2)
							Table[#Table+1]=pid
						else
							menu.notify("".. name .. " - " .. model_name .. "\nHelicopter fuck had whiskey-dick :(", _G_GeeVer, 7, 2)
						end
					else
						no_need=no_need+1
					end
				elseif _action == "rmv_veh_weap" then
					if _GF_does_veh_have_weap(player.get_player_vehicle(pid)) then
						if _GF_request_ctrl(player.get_player_vehicle(pid), 2500) then
							_GF_rmv_veh_weap(_veh)
							Table[#Table+1]=pid
						else
							menu.notify("".. name .. " - " .. model_name .. "\nUnable to remove weapons :(", _G_GeeVer, 7, 2)
						end
					else
						no_need=no_need+1
					end
				elseif _action == "pop_tires" then
					if _GF_veh_tires_popped(player.get_player_vehicle(pid), 2500, name, model_name,_bool) then
						Table[#Table+1]=pid
					end
				elseif _action == "unpop_tires" then
					if _GF_request_ctrl(player.get_player_vehicle(pid),2500) then
						_GF_tire_pop_simple(player.get_player_vehicle(pid),false)
						Table[#Table+1]=pid
					end
				elseif _action == "visible" then
					if entity.is_entity_visible(player.get_player_vehicle(pid)) ~= _bool then
						if _GF_request_ctrl(player.get_player_vehicle(pid), 2500) then
							entity.set_entity_visible(player.get_player_vehicle(pid),_bool)
							menu.notify("".. name .. " - " .. model_name .. "\nVisibility changed :)", _G_GeeVer, 7, 2)
							Table[#Table+1]=pid
						else
							menu.notify("".. name .. " - " .. model_name .. "\nVisibility changes FAILED :(", _G_GeeVer, 7, 2)
						end
					else
						no_need=no_need+1
					end
				elseif _action == "tp" then
					if _GF_plyr_veh_tp_simple(pid,_val, 0,_str,_bool) then
						Table[#Table+1]=pid
					end
				elseif _action == "tp_up" then
					local pos = player.get_player_coords(pid)
					if _GF_plyr_veh_tp_simple(pid,pos, _val,_str,_bool,_true) then
						Table[#Table+1]=pid
					end
				elseif _action == "tp_2_me" then
					local me=player.player_id()
					local my_pos = player.get_player_coords(me)
					local heading = player.get_player_heading(me)
					if _my_pos_rand == "front" then
						my_pos = _GF_front_of_pos(my_pos, heading, math.random(3,7), math.random(170,190), math.random(2,5))
					elseif _my_pos_rand == "250_up"	then
						my_pos.z = my_pos.z+math.random(240,260)
					elseif _my_pos_rand == "1000_up" then
						my_pos.z = my_pos.z+math.random(990,1010)
					end
					if _GF_plyr_veh_tp_simple(pid,my_pos, 0,_str,_bool) then
						Table[#Table+1]=pid
					end
				elseif _action == "random" then
					if _GF_plyr_veh_tp_simple(pid,_GT_RandPointPos[pid+1], 0,_str,_bool) then
						Table[#Table+1]=pid
					end
				elseif _action == "flip_wrong" then
					if _GF_veh_flip(all_veh[i],"flip_wrong",_time) then
						Table[#Table+1]=pid
					end
				end
			end
		end
	end
	local hover_do_table = {}
	for pid in _GF_all_players_but_me() do
		if _GF_table_has(Table,pid) then
			complete=complete+1
		elseif _GF_session_player_do(pid) then
			hover_do_table[#hover_do_table+1]=pid
		end
	end
	unable=unable+(count-no_need-#Table)
	if _G_on_plyrs_veh_pos_enforce.on then
		if _type == "tp_check" or _type == "check_both" then
			local me=player.player_id()
			local heading = player.get_player_heading(me)
			local my_ped=player.get_player_ped(me)
			local name = "Name"
			local model_name = "Vehicle"
			local my_orig_pos = player.get_player_coords(me)
			local plyr_veh = 0
			local i_tried,success,i_hovered = false,false,false
			_GF_hover_back_record()
			for i=1,#hover_do_table do
				local _pid = hover_do_table[i]
				local attempt,continue=false,false
				if _GF_valid_pid(_pid) then
					count=count+1
					local my_pos = player.get_player_coords(me)
					local plyr_pos = player.get_player_coords(_pid)
					name = _GF_plyr_name(_pid)
					local intrr_count,no_veh_count = 0,0
					intrr_count,no_veh_count,continue = _GF_plyr_veh_do(hover_do_table,_pid,name,my_pos,plyr_pos)
					intrr=intrr+intrr_count
					no_veh=no_veh+no_veh_count
					if continue then
						i_tried = true
						success = false
						attempt=true
						local do_once,stop,request = false,false,false
						local time = utils.time_ms() + 4000
						local control_time = utils.time_ms() + 3500
						local wait_time = utils.time_ms() + 2000
						local no_veh_time = utils.time_ms() + 1750
						local plyr_seat = -2
						plyr_veh = 0
						while _GF_valid_pid(_pid) and (utils.time_ms() < time) and not success and not stop do	
							system.yield(0)
							if player.is_player_in_any_vehicle(_pid) then
								plyr_veh = player.get_player_vehicle(_pid)
							else
								i_hovered = true
							end
							if i_hovered and not success and not stop then
								_GF_hover_above_player(_pid)
							end
							if plyr_veh ~= 0 and _GF_valid_veh(plyr_veh) then
								model_name = _GF_model_name(plyr_veh)
								if _action == "veh_kick" then
									if plyr_seat == -2 then
										plyr_seat = _GF_what_seat_plyr_in(plyr_veh,_pid)
									elseif plyr_seat > -2 then
										if not do_once then
											_GF_veh_kick_script(_pid)
											do_once=true
										end
										if utils.time_ms() > wait_time and vehicle.get_ped_in_vehicle_seat(plyr_veh, plyr_seat) == player.get_player_ped(_pid) then 
											ped.clear_ped_tasks_immediately(player.get_player_ped(_pid))
										end
										if _GF_no_one_in_seat(plyr_veh,plyr_seat) then
											menu.notify("".. name .. " - " .. model_name .. "\nKicked from seat:)", _G_GeeVer, 4, 2)
											success=true
										elseif utils.time_ms() > control_time then
											unable=unable+1
											stop=true
										end										
									end
								elseif not _GF_session_plyr_veh_do(plyr_veh) then
									unable=unable+1
									stop=true
								elseif _action == "remove_rotor" then
									if _GF_valid_helo(plyr_veh) then
										request=true
									else
										no_need=no_need+1
										stop=true
									end
								elseif _action == "rmv_veh_weap" then	
									if _GF_does_veh_have_weap(plyr_veh) then
										request=true
									else
										no_need=no_need+1
										stop=true
									end
								elseif _action == "visible" then
									if entity.is_entity_visible(plyr_veh) ~= _bool then
										request=true
									else
										no_need=no_need+1
										stop=true
									end
								elseif _action == "god" then
									if entity.get_entity_god_mode(plyr_veh) ~= _bool then
										request=true
									else
										no_need=no_need+1
										stop=true
									end
								else
									request=true
								end
								if request then
									if not network.has_control_of_entity(plyr_veh) then
										network.request_control_of_entity(plyr_veh)
										if utils.time_ms() > control_time then
											stop=true
											unable=unable+1
										end
									else
										if _action == "god" then
											_GF_veh_god(plyr_veh,_bool,100,name,model_name)
										elseif _action == "collision" then
											_GF_veh_collision(plyr_veh ,_bool, name, model_name)
										elseif _action == "repair" then
											_GF_veh_repair_basic(plyr_veh ,100,_pid)
										elseif _action == "damage" then
											_GF_veh_damaged(plyr_veh ,100,name, model_name, _pid,true)
										elseif _action == "destroy" then
											_GF_veh_destroyed(plyr_veh ,100,name, model_name, _pid)
										elseif _action == "anti_lock" then
											_GF_missile_antilock(plyr_veh,_bool, name, model_name)
										elseif _action == "speed_torque" then
											_GF_veh_speed(plyr_veh, 100, name, model_name, _bool, _val)
										elseif _action == "fucked" then
											_GF_veh_is_fucked(plyr_veh, 100,true,true,_pid)
										elseif _action == "upgrades" then
											_GF_veh_upgr_all_kek(plyr_veh, 100, _bool,_pid)
										elseif _action == "upgrade_single" then
											_GF_veh_upgr_one_kek(plyr_veh, 100, _val, true,_pid)
										elseif _action == "remove_rotor" then
											vehicle.set_vehicle_extra(plyr_veh, 1, 0)
											vehicle.set_vehicle_extra(plyr_veh, 2, 0)
											vehicle.set_vehicle_extra(plyr_veh, 7, 0)
											menu.notify("".. name .. " - " .. model_name .. "\nHelicopter fucked :)", _G_GeeVer, 7, 2)
										elseif _action == "rmv_veh_weap" then
											_GF_rmv_veh_weap(plyr_veh)
										elseif _action == "pop_tires" then
											_GF_veh_tires_popped(plyr_veh, 100, name, model_name,_bool)
										elseif _action == "unpop_tires" then
											if _GF_request_ctrl(player.get_player_vehicle(pid),100) then
												_GF_tire_pop_simple(player.get_player_vehicle(pid),false)
											end
										elseif _action == "visible" then
											entity.set_entity_visible(plyr_veh,_bool)
											menu.notify("".. name .. " - " .. model_name .. "\nVisibility changed :)", _G_GeeVer, 7, 2)
										elseif _action == "tp" or _action == "tp_up" or _action == "tp_2_me" or _action == "random" then
											local speed = v3(0,0,0)
											if _bool then
												speed = entity.get_entity_velocity(plyr_veh)
											end
											if _action == "tp" then
												entity.set_entity_coords_no_offset(plyr_veh,_val)
											elseif _action == "tp_up" then
												local pos = player.get_player_coords(_pid)
												pos.z=pos.z + _val
												entity.set_entity_coords_no_offset(plyr_veh,pos)
											elseif _action == "tp_2_me" then
												local my_start_pos = my_orig_pos
												if _my_pos_rand == "front" then
													my_start_pos = _GF_front_of_pos(my_start_pos, heading, math.random(3,7), math.random(170,190), math.random(2,5))
												elseif _my_pos_rand == "250_up"	then
													my_start_pos.z = my_start_pos.z+math.random(240,260)
												elseif _my_pos_rand == "1000_up" then
													my_start_pos.z = my_start_pos.z+math.random(990,1010)
												end
												entity.set_entity_coords_no_offset(plyr_veh,my_start_pos)
											elseif _action == "random" then
												entity.set_entity_coords_no_offset(plyr_veh,_GT_RandPointPos[_pid+1])
											end
											entity.set_entity_velocity(plyr_veh,speed)
											menu.notify("".. _GF_plyr_name(_pid) .. " - " .. _GF_model_name(plyr_veh) .. "\nTeleported - " .. _str .."", _G_GeeVer, 4, 2)
										elseif _action == "flip_wrong" then
											local _veh_rot=entity.get_entity_rotation(plyr_veh)
											entity.set_entity_velocity(plyr_veh,v3(0,0,0))
											vehicle.set_vehicle_on_ground_properly(plyr_veh)
											entity.set_entity_rotation(plyr_veh,v3(0,0,_veh_rot.z))
										end
										complete=complete+1
										success=true
									end
								end
							elseif utils.time_ms() > no_veh_time then
								if _action == "veh_kick" then
									no_need=no_need+1
								end
								no_veh=no_veh+1
								stop=true
							end
						end
					end
				end
				if not success and attempt and plyr_veh ~= 0 then
					menu.notify("".. name .. "\nUnsuccessful :(", _G_GeeVer, 4, 2)
				end
			end
			if i_hovered then
				_GF_hover_back_to_pos()
			end
		end
	end
	if _G_on_plyrs_veh_pos_enforce.on then
		menu.notify(""..complete.."/"..count.." players were successful.\n"..no_need.." changes were not needed.\n"..unable.." could not be affected.\n"..intrr.." were in interior.\n"..no_veh.." had no vehicle.\n"..unselected_player.." had unselected players in their vehicle.",_G_GeeVer,12,2)
	elseif no_check_no_veh > 0 then
		menu.notify(""..complete.."/"..count.." players were successful.\n"..no_need.." changes were not needed.\n"..unable.." could not be affected.\n"..intrr.." were in interior.\n"..no_check_no_veh.." had no vehicle.\n"..unselected_player.." had unselected players in their vehicle.\n*Try enabling 'check for player vehicle/position.'",_G_GeeVer,12,2)
	else
		menu.notify(""..complete.."/"..count.." players were successful.\n"..no_need.." changes were not needed.\n"..unable.." could not be affected.\n"..intrr.." were in interior.\n"..no_check_no_veh.." had no vehicle.\n"..unselected_player.." had unselected players in their vehicle.\n",_G_GeeVer,12,2)
	end
	hover_do_table={}
	Table={}
	_GF_H_var_default()
	_G_on_plyrs_veh_pos_enforce.hidden=false
end

function _GF_all_veh_action(_action,_time,_no_players,_val,_bool,_my_pos_rand)
	_no_players = _no_players or false
	_time = _time or 100
	local all_veh=_GF_closest_vehs()
	local complete = false
	local continue = false
	local speed = v3(0,0,0)
	if _action == "random" then
		_GF_random_pos(_val,"session",#all_veh)
	end
	for i=1,#all_veh do
		local time = utils.time_ms() + _time
		if _GF_valid_veh(all_veh[i]) then
			if _GF_session_all_veh_do(all_veh[i]) then
				if _action == "air_down" then
					if entity.is_entity_in_air(all_veh[i]) then
						continue=true
					end
				elseif _action == "ground_up" then
					if not entity.is_entity_in_air(all_veh[i]) then
						continue=true
					end
				elseif _action == "god" then
					if entity.get_entity_god_mode(all_veh[i]) ~= _bool then
						continue=true
					end
				elseif _action == "repair" then
					_GF_veh_repair_basic(all_veh[i], _time)
				elseif _action == "auto_repair" then	
					if vehicle.is_vehicle_damaged(all_veh[i]) then
						_GF_veh_repair_basic(all_veh[i], _time)
					end
				elseif _action == "damage" then
					_GF_veh_damaged(all_veh[i],_time,"Ped/Empty Vehicle","",nil,false)
				elseif _action == "destroy" then
					_GF_veh_destroyed(all_veh[i],_time,"Ped/Empty Vehicle","")
				elseif _action == "fucked" then
					 _GF_veh_is_fucked(all_veh[i], _time)
				elseif _action == "upgrades" then
					 _GF_veh_upgr_all_kek(all_veh[i], _time, false)
				elseif _action == "upgrade_single" then
					 _GF_veh_upgr_one_kek(all_veh[i], _time,_val, false)
				elseif _action == "veh_kick" then
					_GF_kick_all_from_veh(all_veh[i])
				elseif _action == "remove_rotor" then	
					if streaming.is_model_a_heli(entity.get_entity_model_hash(all_veh[i])) then
						continue=true
					end
				elseif _action == "rmv_veh_weap" then	
					if _GF_does_veh_have_weap(all_veh[i]) then
						continue=true
					end
				elseif _action == "visible" then	
					if entity.is_entity_visible(all_veh[i]) ~= _bool then
						continue=true
					end
				elseif _action == "flip_wrong" then
					_GF_veh_flip(all_veh[i],"flip_wrong",_time)
				else
					continue=true
				end
			end
			if continue then
				continue=false
				complete=false
				while _GF_valid_veh(all_veh[i]) and utils.time_ms() < time and not complete do
					system.yield(0)
					if _GF_ask_cntrl(all_veh[i]) then
						if _action == "stop" then
							entity.set_entity_velocity(all_veh[i],v3(0,0,0))
						elseif _action == "zoom_zoom" then
							vehicle.set_vehicle_forward_speed(all_veh[i],_val)
						elseif _action == "float" then
							entity.set_entity_velocity(all_veh[i],v3(0,0,_val))
						elseif _action == "air_down" then
							entity.set_entity_velocity(all_veh[i],v3(0,0,_val))
						elseif _action == "ground_up" then
							entity.set_entity_velocity(all_veh[i],v3(0,0,_val))
						elseif _action == "gravity" then
							entity.set_entity_gravity(all_veh[i], _bool)
						elseif _action == "gravity_f" then
							vehicle.set_vehicle_gravity_amount(all_veh[i], _val)
						elseif _action == "collision" then
							entity.set_entity_collision(all_veh[i], _bool,false)
						elseif _action == "god" then
							entity.set_entity_god_mode(all_veh[i], _bool)
						elseif _action == "speed_torque" then
							local max_speed = 45000
							if _val < 1 then
								max_speed=_val*125
							end
							entity.set_entity_max_speed(all_veh[i], max_speed)
							vehicle.modify_vehicle_top_speed(all_veh[i], (_val - 1) * 100)
						elseif _action == "remove_rotor" then
							vehicle.set_vehicle_extra(all_veh[i], 1, 0)
							vehicle.set_vehicle_extra(all_veh[i], 2, 0)
							vehicle.set_vehicle_extra(all_veh[i], 7, 0)
						elseif _action == "rmv_veh_weap" then
							_GF_rmv_veh_weap(all_veh[i])
						elseif _action == "pop_tires" then
							_GF_tire_pop_simple(all_veh[i],true)
						elseif _action == "unpop_tires" then
							_GF_tire_pop_simple(all_veh[i],false)
						elseif _action == "visible" then
							entity.set_entity_visible(all_veh[i],_bool)
							menu.notify("Visibility changed :)", _G_GeeVer, 7, 2)
						elseif _action == "tp" or _action == "tp_up" or _action == "tp_2_me" then
							if _bool then
								speed = entity.get_entity_velocity(all_veh[i])
							end
							if _action == "tp" then
								entity.set_entity_coords_no_offset(all_veh[i],_val)
							elseif _action == "tp_up" then
								local pos =  entity.get_entity_coords(all_veh[i])
								pos.z=pos.z+_val
								entity.set_entity_coords_no_offset(all_veh[i],pos)
							elseif _action == "tp_2_me" then
								local my_pos = player.get_player_coords(player.player_id())
								if _my_pos_rand == "front" then
									my_pos = _GF_front_of_pos(my_pos, player.get_player_heading(player.player_id()), math.random(10,20), math.random(170,190), math.random(2,5))
								elseif _my_pos_rand == "250_up"	then
									my_pos.z = my_pos.z+math.random(240,260)
								elseif _my_pos_rand == "1000_up" then
									my_pos.z = my_pos.z+math.random(990,1010)
								end
								entity.set_entity_coords_no_offset(all_veh[i],my_pos)
							end
							entity.set_entity_velocity(all_veh[i],speed)						
						elseif _action == "random" then
							if _bool then
								speed = entity.get_entity_velocity(all_veh[i])
							end
							entity.set_entity_coords_no_offset(all_veh[i],_GT_RandPointPos[i])
							entity.set_entity_velocity(all_veh[i],speed)
						end
						complete=true
					end
				end
			end
		end
	end
	all_veh = {}
end