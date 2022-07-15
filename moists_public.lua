--many thanks to proddy for all his help making this work and rewriting my bad code to make something even better

--script main parent
local Moist = menu.add_feature("Moists Script", "parent", 0)
--script arrays etc
appdata = os.getenv("APPDATA")
local rootPath = os.getenv("APPDATA") .. "\\PopstarDevs\\2Take1Menu"

local proparray = {"prop_riot_shield","prop_minigun_01","prop_ld_bomb_anim","prop_ld_bomb_01_open","prop_ld_bomb_01","prop_swiss_ball_01","prop_distantcar_day","prop_distantcar_truck","prop_distantcar_night"}
local crash_array = {-717142431,-1806363504,707438599,2147205602,-1007599668,-1748817893,-473036318}
local crashnamearray = {"dt1_18_sq_night_slod","hei_bh1_08_details4_em_night","ss1_12_night_slod","prop_dummy_01","prop_dummy_car","prop_dummy_light","prop_dummy_plane","v_res_d_dildo_f","prop_cs_dildo_01","v_res_d_dildo_e","v_res_d_dildo_d","v_res_d_dildo_c","v_res_d_dildo_b","v_res_d_dildo_a","v_med_curtainsnewcloth2","bh1_07_flagpoles","prop_bbq_3","prop_battery_01","prop_barbell_02","prop_barbell_01","prop_bandsaw_01"}
local bone_name = {
"SKEL_Spine_Root",
"SKEL_Spine3",
"SKEL_Spine2",
"SKEL_Spine1",
"SKEL_Spine0",
"SKEL_SKEL_Pelvis",
"SKEL_SADDLE",
"SKEL_R_UpperArm",
"SKEL_R_Thigh",
"SKEL_R_Hand",
"SKEL_R_Forearm",
"SKEL_R_Foot",
"SKEL_R_Clavicle",
"SKEL_R_Calf",
"SKEL_PelvisRoot",
"SKEL_Pelvis1",
"SKEL_Pelvis",
"SKEL_Neck_2",
"SKEL_Neck_1",
"SKEL_L_UpperArm",
"SKEL_L_Thigh",
"SKEL_L_Hand",
"SKEL_L_Forearm",
"SKEL_L_Foot",
"SKEL_L_Clavicle",
"SKEL_L_Calf",
"FACE_ROOT",
"SKEL_HEAD",
"IK_Head"
}
local B_ID

local boneid = {
57597,
24818,
24817,
24816,
23553,
11816,
38180,
40269,
51826,
57005,
28252,
52301,
10706,
36864,
17916,
53251,
11816,
24532,
39317,
45509,
58271,
18905,
61163,
14201,
64729,
63931,
65068,
31086,
12844
}
local ped_bone_sel
local spawnhash
local AnonymousBounty = true
local BountyPresets = {0,1,42,69,420,666,1000,3000,5000,7000,9000,10000}

-- Remove the values in the super kick array(s) & add your own kicks
-- New Kick Events will no longer be added and shared publicly but feel free to add your own the parameters here are pretty good for a working kick

local superkick = {0x000000,0xfffffffff}

local superkick2 = {0x000000,0xfffffffff}

local superkick3 = {0x000000,0xfffffffff}

local superkick4 = {0x000000,0xfffffffff}

local attached_plyveh = {}
local attachveh_on
local ragdolltyp = {"Normal ragdoll","Falls with stiff legs/body","Narrow leg stumble","Wide leg stumble"}
local modflags = {}
local flag_as_mod = {"Moist Protex you","YouTry Kickon Them","Spectating Player(with Mod)"}
local att_offset_data = {}
local att_me = {}
local Cur_Date_Time
local mod_flag = {}
local BlacklistModFlag = player.add_modder_flag("Blacklist")
local scids = {}
local scidN = 0
local playerFeatures = {}
local selffeatures = {}
local RemoveBlacklistFeature
local MarkAsModderFeature
local vehgod = {}
local KickFeature
local lesveh = {}
local lester = {}
local dildos = {}
local attached_shit = {}
local attached_shitc = {}
local crashattach = {}
local lester_rot = v3()
local camviewpos = v3()
local hp = {500,1000,2500,2600,10000,90000}
local chp = {}
local goddeath = v3()
goddeath.x = -5784.258301
goddeath.y = -8289.385742
goddeath.z = -136.411270
local goddeath2 = v3()
goddeath2.x = -1387.175
goddeath2.y = -618.242
goddeath2.z = 30.362
local beyond_limits = v3()
beyond_limits.x = -173663.281250
beyond_limits.y = 915722.000000
beyond_limits.z = 362299.750000
local ped_pos = v3()
local CurrentIntensity
local waveintmod_i
local weaphashtbl = {}
local weapnametbl = {}
local offset_data_x
local offset_data_y
local offset_data_z
local rot_data_x
local rot_data_y
local rot_data_z
local offset_data_x2
local offset_data_y2
local offset_data_z2
local rot_data_x2
local rot_data_y2
local rot_data_z2
local fix_rot
local value_num
math.randomseed(utils.time_ms())
local playersFeature = menu.add_feature("Online Players", "parent", Moist.id)
local lobby = menu.add_feature("Online Session", "parent", Moist.id)
local protex = menu.add_feature("Online Protection", "parent", Moist.id, cb)
local self = menu.add_feature("Self Functions", "parent", Moist.id)
local selfped = menu.add_feature("Self Ped Functions", "parent", self.id)
local selfveh = menu.add_feature("Self Vehicle Modifiers", "parent", self.id)
local self_options = menu.add_feature("Self Function Settings", "parent", self.id)
local modprotex = menu.add_feature("Modder Protection", "parent", protex.id, cb)
local orbparent = menu.add_feature("Orbital Room Block", "parent", protex.id, cb)
local moistopt = menu.add_feature("Options", "parent", Moist.id)
test = menu.add_feature("Test", "parent", 0)
local water_mod = menu.add_feature("Water Modifier", "parent", moistopt.id)
local Attach_Shit = menu.add_player_feature("Attach Shit to Player", "parent", 0).id
local Player_Tools = menu.add_player_feature("Tools", "parent", 0).id
local BountyId = menu.add_player_feature("Bounty Options", "parent", 0).id


local function AddBounty(pid, value, anonymous)
	if not network.is_session_started() then return end
	local npc_bit = anonymous and 1 or 0
	for i = 0, 31 do
		if player.get_player_scid(i) ~= 4294967295 then

					script.trigger_script_event(544453591 , i, {69, pid, 1, value, 0, npc_bit, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1650640 + 9), script.get_global_i(1650640 + 10)})
			
		end
	end
end


menu.add_player_feature("Anonymous Bounty", "toggle", BountyId, function(feat, pid)
	if feat.on ~= AnonymousBounty then
		AnonymousBounty = feat.on
		local pf = menu.get_player_feature(feat.id)
		for i=1,#pf.feats do
			if pf.feats[i].on ~= AnonymousBounty then
				pf.feats[i].on = AnonymousBounty
			end
		end
	end
	return HANDLER_POP
end).threaded = false

menu.add_player_feature("Custom Value", "action", BountyId, function(feat, pid)
	local r,s = input.get("Custom Bounty Value", "", 64, 3)
	if r == 1 then
		return HANDLER_CONTINUE
	end
	
	if r == 2 then
		return HANDLER_POP
	end
	
	local value = tonumber(s)
	value = math.max(0, value)
	value = math.min(10000, value)
	AddBounty(pid, value, AnonymousBounty)
	notify_above_map("I've placed a $" .. value .. " bounty on " .. (pid == player.player_id() and "your" or player.get_player_name(pid) .. "'s") ..  " head.")
end).threaded = false

for i = 1, #BountyPresets do
	menu.add_player_feature("$" .. BountyPresets[i], "action", BountyId, function(feat, pid)
		AddBounty(pid, BountyPresets[i], AnonymousBounty)
		--notify_above_map("I've placed a $" .. BountyPresets[i] .. " bounty on " .. (pid == player.player_id() and "your" or player.get_player_name(pid) .. "'s") ..  " head.")
	end).threaded = false
end

menu.add_player_feature("Copy IP to Clipboard", "action", 0, function(feat, pid)
	local ip = player.get_player_ip(pid)
	local sip = string.format("%i.%i.%i.%i", (ip >> 24) & 0xff, ((ip >> 16) & 0xff), ((ip >> 8) & 0xff), ip & 0xff)
	utils.to_clipboard(sip)
	
end)


menu.add_player_feature("Save Players Current POS to file", "action", 0, function(feat, pid)

	local pos = v3()
	local Poslabel
	local posout
	local ped
	local posfile = io.open(appdata.."\\PopstarDevs\\2Take1Menu\\lualogs\\saveposoutput.md", "a")
	local size = posfile:seek("end")
	print(string.format(size))
	local offset = v3()
	pos = player.get_player_coords(player.player_id(pid))
	local name = player.get_player_name(pid)


	local r,s = input.get("Enter a Name to Label POS", "size", 64, 0)
	if r == 1 then
		return HANDLER_CONTINUE
	end
	
	if r == 2 then
		return HANDLER_POP

	end	

	ui.notify_above_map(string.format("%f, %f, %f", pos.x, pos.y, pos.z), "Players Position", 213)
	--savepos(string.format("\n[Position:] ****"..s.." **** \n[pos.x]\n%f, \n[pos.y]\n%f, \n[pos.z]\n%f", pos.x, pos.y, pos.z))
	savepos(string.format("\nPosition Saved From Player: "..name.."\n"..s..",				".."{"..pos.x ..", "..pos.y ..", "..pos.z.."}"))

	return HANDLER_POP
end)	




function offset_setup()
	offset_data_z = 0.0
	offset_data_y = 0.0
	offset_data_x = 0.0
	B_ID = boneid[1]
	rot_data_x = 0.0
	rot_data_y = 0.0
	rot_data_z = 0.0
	offset_data_x2 = 0.0
	offset_data_y2 = 0.0
	offset_data_z2 = 0.0
	rot_data_x2 = 0.0
	rot_data_y2 = 0.0
	rot_data_z2 = 0.0
	
end

local mod_off = menu.add_player_feature("Toggle off Modder Mark", "toggle", Player_Tools, function(feat, pid)
	if player.is_player_modder(pid, -1) == true
		then
	player.unset_player_as_modder(pid, -1)
	end
	return HANDLER_CONTINUE
end)

--dildo attachments with colision
--dildo root

local dildo_inside_V1 = menu.add_player_feature("Attach dildo in Skeleton root", "action", Attach_Shit, function(feat, pid)

        local pedd = player.get_player_ped(pid)
        local pos = v3()
		local i = #attached_shit + 1
            attached_shit[i] = object.create_object(-422877666, pos, true, false)

        entity.attach_entity_to_entity(attached_shit[i], pedd, 0, pos, pos, true, true, false, 0, false)
end)


--dildo dick
local dildo_dick = menu.add_player_feature("Attach dildo as Dick", "action", Attach_Shit, function(feat, pid)
        local pedd = player.get_player_ped(pid)
        local pos = v3()
		local offset = v3()
		offset.x = 0.0
		offset.y = 0.0
		offset.z = 0.0
		local rot = v3()
		rot.x = 293.0
		rot.y = 28.0
		rot.z = 24.0
		
        local i = #attached_shit + 1
		local bid = ped.get_ped_bone_index(pedd, 23553)
		local hash = gameplay.get_hash_key("v_res_d_dildo_f")
        attached_shit[i] = object.create_object(hash, pos, true, true)
		
        entity.attach_entity_to_entity(attached_shit[i], pedd, bid, offset, rot, true, false, false, 0, true)

end)

--dildo face
local dildo_face = menu.add_player_feature("Attach dildo to face", "action", Attach_Shit, function(feat, pid)
        local pedd = player.get_player_ped(pid)
        local pos = v3()
		local offset = v3()
		offset.x = 0.0
		offset.y = 0.0
		offset.z = 0.0
		local rot = v3()
		rot.x = -80.0
		rot.y = 260.0
		rot.z = -21.0
		
        local i = #attached_shit + 1
		local bid = ped.get_ped_bone_index(pedd, 65068)
		local hash = gameplay.get_hash_key("v_res_d_dildo_f")
        attached_shit[i] = object.create_object(hash, pos, true, true)
		
        entity.attach_entity_to_entity(attached_shit[i], pedd, bid, offset, rot, true, false, false, 0, true)

end)

--dildo pelvis
local dildo_inside_V2 = menu.add_player_feature("Attach dildo in Skeleton pelvis", "action", Attach_Shit, function(feat, pid)
        local pedd = player.get_player_ped(pid)
        local pos = v3()
        local i = #attached_shit + 1
				local bid = ped.get_ped_bone_index(pedd, 17916)
           attached_shit[i] = object.create_object(-422877666, pos, true, false)
        
        entity.attach_entity_to_entity(attached_shit[i], pedd, bid, pos, pos, true, true, false, 0, false)

end)

attachveh = menu.add_player_feature("Attach to Vehicle", "toggle", Attach_Shit, function(feat)
	if feat.on then
attachveh_on = true
	end
	if not feat.on then
attachveh_on = false
	end
end)


local CrashProp2 = menu.add_player_feature("LowLod Distant Night Car object x3", "action", Attach_Shit, function(feat, pid)
	local objhash = gameplay.get_hash_key("prop_distantcar_night")	
	if 	attachveh_on then
			local pedd = player.get_player_ped(pid)
		local plyveh = player.get_player_vehicle(pid)
        local pos = v3()
		local offset = v3()
		offset.x = -0.1
		offset.y = -0.1
		offset.z = -0.2
		local rot = v3()
		rot.x = 0.0
		rot.y = 0.0
		rot.z = 180.0
		local i = #attached_shit + 1
		
        attached_shit[i] = object.create_object(objhash, pos, true, false)
        network.request_control_of_entity(plyveh)
        entity.attach_entity_to_entity(attached_shit[i], plyveh, 1356, offset, rot, true, false, false, 0, true)
		local offset = v3()
		offset.x = 0.05 
		offset.y = 0.05
		offset.z = -0.2
		
			local i = #attached_shit + 1	
		 attached_shit[i] = object.create_object(objhash, pos, true, false)
        network.request_control_of_entity(plyveh)
        entity.attach_entity_to_entity(attached_shit[i], plyveh, 0, offset, rot, true, false, false, 0, true)
		local offset = v3()
		offset.x = 0.05 
		offset.y = 0.05
		offset.z = 0.0
		
			local i = #attached_shit + 1	
		 attached_shit[i] = object.create_object(objhash, pos, true, false)
        network.request_control_of_entity(plyveh)
        entity.attach_entity_to_entity(attached_shit[i], plyveh, 0, offset, rot, true, false, false, 0, true)
		end
	if not attachveh_on then

        local pedd = player.get_player_ped(pid)
        local pos = v3()
        local i = #attached_shit + 1

        attached_shit[i] = object.create_object(objhash, pos, true, false)
        
        entity.attach_entity_to_entity(attached_shit[i], pedd, 1356, pos, pos, true, true, false, 0, false)
	

	end	
end)

local CrashProp2 = menu.add_player_feature("LowLod Distant Night Car object x1", "action", Attach_Shit, function(feat, pid)
	local objhash = gameplay.get_hash_key("prop_distantcar_night")	
	if 	attachveh_on then
			local pedd = player.get_player_ped(pid)
		local plyveh = player.get_player_vehicle(pid)
        local pos = v3()
		local offset = v3()
		offset.x = 0.0
		offset.y = 0.0
		offset.z = -0.3
		local rot = v3()
		rot.x = 0.0
		rot.y = 0.0
		rot.z = 180.0
		local i = #attached_shit + 1
		
        attached_shit[i] = object.create_object(objhash, pos, true, false)
        network.request_control_of_entity(plyveh)
        entity.attach_entity_to_entity(attached_shit[i], plyveh, 1356, offset, rot, true, false, false, 0, true)
		end
	if not attachveh_on then

        local pedd = player.get_player_ped(pid)
        local pos = v3()
        local i = #attached_shit + 1

        attached_shit[i] = object.create_object(objhash, pos, true, false)
        
        entity.attach_entity_to_entity(attached_shit[i], pedd, 1356, pos, pos, true, true, false, 0, false)
	

	end	
end)



local CrashProp3 = menu.add_player_feature("LowLod Distant Day Car object Crash?", "action", Attach_Shit, function(feat, pid)
        local pedd = player.get_player_ped(pid)
        local pos = v3()
        local i = #attached_shit + 1
		local objhash = gameplay.get_hash_key("prop_distantcar_day")
           attached_shit[i] = object.create_object(objhash, pos, true, false)
        
        entity.attach_entity_to_entity(attached_shit[i], pedd, 1356, pos, pos, true, true, false, 0, false)
		
end)

local detach_del = menu.add_player_feature("Detach & Delete", "action", Attach_Shit, function(feat, pid)
	 local pedd = player.get_player_ped(pid)
	 local plyveh = player.get_player_vehicle(player.player_id())
	local attached_entity = entity.get_entity_attached_to(plyveh)
	network.request_control_of_entity(attached_entity)
		entity.detach_entity(attached_entity)
		entity.set_entity_as_no_longer_needed(attached_entity)
		entity.delete_entity(attached_entity)

	-- for i = 1, #attached_shit do
	-- network.request_control_of_entity(attached_shit[i])
		-- entity.detach_entity(attached_shit[i])
		-- entity.set_entity_as_no_longer_needed(attached_shit[i])
		-- entity.delete_entity(attached_shit[i])
	-- end
end)


	
local objcreate0 = menu.add_feature("Create object Signal Jammer", "action", test.id, function(feat)
	local me = player.player_id()
	local pedd = player.get_player_ped(me)
	local pos = v3()
	pos = player.get_player_coords(me)
	local i = #attached_shit + 1
	local objhash = gameplay.get_hash_key("ch_prop_ch_mobile_jammer_01x")
	pos.x = pos.x + 3
	attached_shit[i] = object.create_object(objhash, pos, true, false)


end)

local objcreate = menu.add_feature("Create object Remote sniper", "action", test.id, function(feat)
	local me = player.player_id()
	local pedd = player.get_player_ped(me)
	local pos = v3()
	pos = player.get_player_coords(me)
	local i = #attached_shit + 1
	local objhash = gameplay.get_hash_key("p_rcss_s")
	pos.x = pos.x + 3
	attached_shit[i] = object.create_object(objhash, pos, true, false)


end)

local objcreate1 = menu.add_feature("Create object Remote sniper folded", "action", test.id, function(feat)
	local me = player.player_id()
	local pedd = player.get_player_ped(me)
	local pos = v3()
	pos = player.get_player_coords(me)
	local i = #attached_shit + 1
	local objhash = gameplay.get_hash_key("p_rcss_folded")
	pos.x = pos.x + 3
	attached_shit[i] = object.create_object(objhash, pos, true, false)
	

end)
	
	
local posmenu = menu.add_feature("Save Current Position to file", "action", self.id, function(feat)

	local pos = v3()
	local Poslabel
	local posout
	local ped
	local posfile = io.open(appdata.."\\PopstarDevs\\2Take1Menu\\lualogs\\saveposoutput.md", "a")
	local size = posfile:seek("end")
	print(string.format(size))

	local offset = v3()
	pos = player.get_player_coords(player.player_id())

	local r,s = input.get("Enter a Name to Label POS", size, 64, 0)
	if r == 1 then
		return HANDLER_CONTINUE
	end
	
	if r == 2 then
		return HANDLER_POP

	end	

	ui.notify_above_map(string.format("%f, %f, %f", pos.x, pos.y, pos.z), "Current Position", 140)
	--savepos(string.format("\n[Position:] ****"..s.." **** \n[pos.x]\n%f, \n[pos.y]\n%f, \n[pos.z]\n%f", pos.x, pos.y, pos.z))
	savepos(string.format("\n"..s..",				".."{"..pos.x ..", "..pos.y ..", "..pos.z.."}"))

	return HANDLER_POP
	
end)

savepos = function(text)
    local file = io.open(appdata.."\\PopstarDevs\\2Take1Menu\\lualogs\\saveposoutput.md", "a")

    io.output(file)
    io.write(text)
    io.close()
end


function get_date_time()
	local d = os.date()
	local dtime = string.match(d, "%d%d:%d%d:%d%d")
	local dt = os.date("%d/%m/%y%y")
	Cur_Date_Time = (string.format("["..dt.."]".."["..dtime.."]"))
end

function flag_setup()

local i = #mod_flag + 1
	mod_flag[i] = player.add_modder_flag(flag_as_mod[1])
local i = #mod_flag + 1
	mod_flag[i] = player.add_modder_flag(flag_as_mod[2])
local i = #mod_flag + 1
	mod_flag[i] = player.add_modder_flag(flag_as_mod[3])

end


function debug_out(text)
	get_date_time()
	local file = io.open(rootPath.."\\lualogs\\Moists_debug.log", "a")
	io.output(file)
	io.write("\n"..Cur_Date_Time)
	io.write("\n"..text)
    io.close()

end

local Moist_WaveMod = function()
	local wave_int_cur = tostring("~q~~h~"..water.get_waves_intensity())
	CurrentIntensity = tostring(wave_int_cur)
	ui.notify_above_map("~w~~h~Current Wave Intensity is:".." " ..wave_int_cur.." ", "Moists Wave Mod", 212)
end


local wave_int_osd = menu.add_feature("Get Current Wave Intensity", "toggle", water_mod.id, function(feat)
	if feat.on then

		local wave_int_cur = water.get_waves_intensity()
		local pos = v2()
		pos.x = .305
        pos.y = .0001
		ui.set_text_scale(0.25)
		ui.set_text_font(0)
		ui.set_text_centre(0)
		ui.set_text_color(255, 0, 0, 255)
		ui.set_text_outline(1)
		ui.draw_text("Wave Intensity: "..wave_int_cur, pos)

		end
	return HANDLER_CONTINUE
end)
wave_int_osd.threaded = false
wave_int_osd.on = false

local waveintmodifiers = menu.add_feature("Change Wave Intensity", "action_value_i", water_mod.id, function(feat)

	local x = feat.value_i / 10
	water.set_waves_intensity(x)
	
Moist_WaveMod()
end)
waveintmodifiers.threaded = false
waveintmodifiers.hidden = false
waveintmodifiers.max_i = 500000
waveintmodifiers.min_i = -200
waveintmodifiers.mod_i = 1

menu.add_feature("Change step Size", "autoaction_i",  water_mod.id, function(feat)
    waveintmodifiers.mod_i = f.value_i
end)


local wavemodifiers = menu.add_feature("Reset Intensity", "action", water_mod.id, function(feat)

	water.reset_waves_intensity()

end)
wavemodifiers.threaded = false


no_traffic = function(feat)
    vehicle.set_vehicle_density_multipliers_this_frame(0);
    if feat.on
    then
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end

local trafoff = menu.add_feature("No World Traffic", "toggle", moistopt.id, no_traffic)
trafoff.threaded = false

no_peds = function(feat)
    ped.set_ped_density_multiplier_this_frame(0);
    if feat.on
    then
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end

local trafoff = menu.add_feature("No World Peds", "toggle", moistopt.id, no_peds)
trafoff.threaded = false

function se_kick(pid)

  for j = 1, #superkick do

        pscid = player.get_player_scid(pid)

		pname = tostring(player.get_player_name(pid))

    script.trigger_script_event(superkick[j], pid, {28, -1, -1})

end

 for i = 1, #superkick2 do


    script.trigger_script_event(superkick2[i], pid, {28, -1, -1})

end
    return HANDLER_POP
end

local super_sess_kick = menu.add_feature("super SE Kick session", "toggle", lobby.id, function(feat)
	if feat.on then
	    local me

    me = player.player_id()

    for i = 0, 32 do
        if i ~= me then

        end
		 for j = 1, #superkick do
	 script.trigger_script_event(superkick[j], i, {28, -1, -1})
		 end
	 for y = 1, #superkick2 do
	 script.trigger_script_event(superkick2[y], i, {28, -1, -1})
	 end
	end
	end
	return HANDLER_CONTINUE
	
end)

test_kick00 = menu.add_feature("Kick Number from Superkick:", "value_i",  lobby.id, function(feat)
		if feat.on then
			    local me

    me = player.player_id()

    for y = 0, 32 do
        if y ~= me then

        end

		local i = feat.value_i
					

	script.trigger_script_event (superkick[i], y, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick[i], y, {0, -1, 0})

		end
		end
	return HANDLER_CONTINUE
	
end)
test_kick00.max_i = #superkick
test_kick00.min_i = 1
test_kick00.value_i = 1

test_kick02 = menu.add_feature("Kick Number from Superkick2:", "value_i", lobby.id, function(feat)
		if feat.on then
			    local me

    me = player.player_id()

    for y = 0, 32 do
        if y ~= me then

        end
		local i = feat.value_i
					

	script.trigger_script_event (superkick2[i], y, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick2[i], y, {0, -1, 0})


		end
		end
		return HANDLER_CONTINUE
		
end)
test_kick02.max_i = #superkick2
test_kick02.min_i = 1
test_kick02.value_i = 1

test_kick03 = menu.add_feature("Kick Number from Superkick3:", "value_i", lobby.id, function(feat)
		if feat.on then
		    local me

    me = player.player_id()

    for y = 0, 32 do
        if y ~= me then

        end
		local i = feat.value_i
					

	script.trigger_script_event (superkick3[i], y, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick3[i], y, {0, -1, 0})


		end
		end
		return HANDLER_CONTINUE
		
end)
test_kick03.max_i = #superkick3
test_kick03.min_i = 1
test_kick03.value_i = 1



local notif = ui.notify_above_map
local function notify_above_map(msg)
	ui.notify_above_map(tostring(msg), "Moists Script v.1.10", 140)
end

local NoWaypoint = v2()
NoWaypoint.x = 16000
NoWaypoint.y = 16000

local function set_waypoint(pos)
	pos = pos or player.get_player_coords(player.player_id())
	if pos.x and pos.y then
		local coord = v2()
		coord.x = pos.x
		coord.y = pos.y
		ui.set_new_waypoint(coord)
	end
end


blockpassiveall = function()

	local me
	
	me	= player.player_id()

	for i=0,32 do
		if i ~= me
		then
            script.trigger_script_event(0x54BAD868, i, {1, 1})
end
end
end

markall = function()
    local me

    me = player.player_id()

    for i = 0, 32 do
        if i ~= me then

        end
	player.set_player_as_modder(i, 1)

	player.set_player_as_modder(i, mod_flag[1])

	player.set_player_as_modder(i, mod_flag[2])

   end
end


notmarkall = function()
    local me

    me = player.player_id()

    for i = 0, 32 do
        if i ~= me then

        end
player.unset_player_as_modder(i, -1)
   end
end


timedisp = function(feat)
		
			if feat.on then
		
				local pos = v2()
				
				local d = os.date()
				local dt = string.match(d, "%d%d:%d%d:%d%d")
				
				pos.x = .5
				pos.y = .01

			ui.set_text_scale(0.40)
			ui.set_text_font(0)
			ui.set_text_color(255, 255, 255, 255)
			ui.set_text_centre(1)
			ui.set_text_outline(1)
			ui.draw_text(dt, pos)
	end
	return HANDLER_CONTINUE
end

--block orbital doorway with wall
blockplaces03 = function(feat)
    local pos = v3()
    local rot = v3()
    local pos1 = v3()
    local rot1 = v3()

	pos.x = 335.719
    pos.y = 4834.571
    pos.z = -60.206
    rot.x = 0.000
    rot.y = -0.000
    rot.z = 125.000
	pos1.x = 335.71899414062
	pos1.y = 4834.5708007812
	pos1.z = -60.206390380859
    rot1.x = 0.0
    rot1.y = -0.0
    rot1.z = 125.0

    orb2block = object.create_object(561365155, pos1, true, false)
	entity.set_entity_as_mission_entity(orb2block, true, true)
    entity.set_entity_rotation(orb2block, rot1)

    ui.add_blip_for_entity(orb2block)

    return HANDLER_POP
end

--Inactive Orbital Screens over blocked doorway
--dmaged sub 3544215092
orbscreens = function(feat)
    local pos1 = v3()
    local pos2 = v3()
    local pos3 = v3()
    local pos4 = v3()
    local pos5 = v3()
	
    local rot1 = v3()
    local rot2 = v3()
    local rot3 = v3()
    local rot4 = v3()
    local rot5 = v3()


    pos1.x = 336.016083
    pos1.y = 4834.12988
    pos1.z = -58.0754662
    rot1.x = -25.160162
    rot1.y = 2.82980454e-06
    rot1.z = 122.541527

	pos2.x = 336.016083
    pos2.y = 4834.12988
    pos2.z = -58.9853134
    rot2.x = -25.160162
    rot2.y = 2.82980454e-06
    rot2.z = 122.541527

	pos3.x = 336.016083
    pos3.y = 4834.12988
    pos3.z = -59.5252228
    rot3.x = -25.160162
    rot3.y = 2.82980454e-06
    rot3.z = 122.541527

    pos4.x = 336.016083
    pos4.y = 4834.12988
	pos4.z = -57.5355568
    rot4.x = -25.160162
    rot4.y = 2.82980454e-06
    rot4.z = 122.541527

    pos5.x = 336.28463745117
    pos5.y = 4833.7241210938
	pos5.z = -80.422435760498
    rot5.x = 25.0
    rot5.y = 5.0000004768372
    rot5.z = -94.999992370605

    damagedsub = object.create_object(3544215092, pos5, true, false)
	entity.set_entity_as_mission_entity(damagedsub, true, true)

    entity.set_entity_rotation(damagedsub, rot5)

    ui.add_blip_for_entity(damagedsub)
	
    screen1 = object.create_object(2895140982, pos1, true, false)
	entity.set_entity_as_mission_entity(screen1, true, true)

    entity.set_entity_rotation(screen1, rot1)

    ui.add_blip_for_entity(screen1)

    screen2 = object.create_object(2895140982, pos2, true, false)
	entity.set_entity_as_mission_entity(screen2, true, true)
    entity.set_entity_rotation(screen2, rot2)

    ui.add_blip_for_entity(screen2)

    screen3 = object.create_object(-1399826314, pos3, true, true)
	entity.set_entity_as_mission_entity(screen3, true, true)
    entity.set_entity_rotation(screen3, rot3)

    ui.add_blip_for_entity(screen3)

    screen4 = object.create_object(2895140982, pos4, true, false)
	entity.set_entity_as_mission_entity(screen4, true, true)

    entity.set_entity_rotation(screen4, rot4)

    ui.add_blip_for_entity(screen4)

    return HANDLER_POP
end


function teleport(feat)
    local pos = v3()

    pos.x = 339.379
    pos.y = 4836.629
    pos.z = -58.999
	heading = 136.27784729004

entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
entity.set_entity_heading(player.get_player_ped(player.player_id()), heading)


    return HANDLER_POP
end

local targetdot = menu.add_feature("Target Dot 1", "toggle", moistopt.id, function(feat)

	if feat.on
	then
		local pos = v2()
		
		pos.x = .500
		pos.y = .450
	--x: 1391	y: 581	w: 21	h: 21
		ui.set_text_scale(1.0)
		ui.set_text_font(0)
		ui.set_text_centre(1)
		ui.set_text_outline(1)
		ui.draw_text(".", pos)
	

	end
	return HANDLER_CONTINUE

end)

local targetdot1 = menu.add_feature("Target Dot 2", "toggle", moistopt.id, function(feat)
	if feat.on
	then
		local pos = v2()
		
		pos.x = .4999
		pos.y = .4639
	--x: 1391	y: 581	w: 21	h: 21
		ui.set_text_scale(.65)
		ui.set_text_font(0)
		ui.set_text_centre(1)
		ui.set_text_outline(1)
		ui.draw_text(".", pos)
	

	end
			return HANDLER_CONTINUE

end)

local targetdot2 = menu.add_feature("Target Dot 3", "toggle", moistopt.id, function(feat)

	if feat.on
	then
		local pos = v2()
		
		pos.x = .4999
		pos.y = .4798

		ui.set_text_scale(0.5)
		ui.set_text_font(0)
		ui.set_text_centre(1)
		ui.set_text_outline(1)
		ui.set_text_color(255, 255, 255, 180)
		ui.draw_text("+", pos)

	end
		
		return HANDLER_CONTINUE
end)




local osdtime = menu.add_feature("Display Real Time OnScreen", "toggle", moistopt.id, timedisp)
osdtime.on = true

local crosshair = menu.add_feature("Show Weapon Recticle", "toggle", moistopt.id, function(feat)
if feat.on then

ui.show_hud_component_this_frame(14)
end
return HANDLER_CONTINUE
end)
crosshair.threaded = false

local teleorb = menu.add_feature("Teleport to block location?", "action", orbparent.id, teleport)
teleorb.threaded = false

local orbwall = menu.add_feature("Block Orbital Entrance with Wall", "action", orbparent.id, blockplaces03)
orbwall.threaded = false

local orbscreens = menu.add_feature("Orbital Inactive Screens over Block", "action", orbparent.id, orbscreens)
orbscreens.threaded = false


local allmod = menu.add_feature("Mark all Players as Modder", "action", modprotex.id, function(feat)
markall()
end)
allmod.threaded = false

local allmodt = menu.add_feature("Mark all Players as Modder", "toggle", modprotex.id, function(feat)
if feat.on then

    local me

    me = player.player_id()

    for i = 0, 32 do
        if i ~= me then

        end

	player.set_player_as_modder(i, 1)

	player.set_player_as_modder(i, mod_flag[1])

	player.set_player_as_modder(i, mod_flag[2])
   end
   end
return HANDLER_CONTINUE
end)
allmodt.threaded = false

local notallmod = menu.add_feature("UnMark all Players as Modder", "action", modprotex.id, function(feat)
notmarkall()
end)
notallmod.threaded = false


local bountyallplayerses = menu.add_feature("set 10k Bounty on Lobby", "action", lobby.id, function(feat)

	for playid = 0, 31 do

if player.get_player_scid(playid) ~= -1 or playid ~= player.player_id() then

 for j = 0, 31 do
        -- script.trigger_script_event(0x2073B3D7, j, {69, playid, 1, 9000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1651198 + 9), script.get_global_i(1651198 + 10)})
		script.trigger_script_event(544453591 , j, {69, playid, 1, 10000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1650640 + 9), script.get_global_i(1650640 + 10)})
end
end

end
end)
bountyallplayerses.threaded = false

local pasivall = menu.add_feature("Block all players Passive", "action", lobby.id, function(feat)
blockpassiveall()
end)
pasivall.threaded = false
	

local sndrape_exp_count = menu.add_feature("all Explosion Countdown", "action", lobby.id, function(feat)

	local pos = v3()

for i = 0, 31 do
	if (player.get_player_scid(i) ~= -1 and i ~= player.player_id()) then
	pos = entity.get_entity_coords(player.get_player_ped(i))
	audio.play_sound_from_coord(-1, "Explosion_Countdown", pos, "GTAO_FM_Events_Soundset", true, 1000, false)

end
end


end)
sndrape_exp_count.threaded = false

local function hostkickall()
    local me = player.player_id()
    if network.network_is_host() then
        for i = 0, 32 do
            if i ~= me then
              network.network_session_kick_player(i)
            end
        end
    else            
        notify_above_map("You are not Session-Host!")
    end
end

local hostkickall = menu.add_feature("Host Kick All", "toggle", lobby.id, function(feat)
if feat.on then
hostkickall()

end
return HANDLER_CONTINUE
end)


function playvehspdboost(pid)

	local plyveh 

plyveh = player.get_player_vehicle(pid)
network.request_control_of_entity(plyveh)

vehicle.set_vehicle_rocket_boost_refill_time(plyveh, 100000.000010)


end

function plyvehspdboost(pid)

	local plyveh 

plyveh = player.get_player_vehicle(pid)
network.request_control_of_entity(plyveh)

vehicle.set_vehicle_rocket_boost_refill_time(plyveh, 0.000010)


end

function playervehspd(pid, speed)


	local plyveh 
	local pedd = player.get_player_ped(pid)


plyveh = player.get_player_vehicle(pid)
network.request_control_of_entity(plyveh)

entity.set_entity_max_speed(plyveh, speed)


end

function expveh(pid)
	local plyveh
	local plyped = player.get_player_ped(pid)
	plyveh = player.get_player_vehicle(pid)
	network.request_control_of_entity(plyveh)
	vehicle.set_vehicle_out_of_control(plyveh, false, true)


--plyveh = ped.get_vehicle_ped_is_using(plyped)
 if plyveh ~= nil then

  network.request_control_of_entity(plyveh)
  vehicle.set_vehicle_forward_speed(plyveh, 20)                                                    
  vehicle.set_vehicle_out_of_control(plyveh, false, true)
  
end
return HANDLER_CONTINUE
end

--Self modifiers --Max Health 1:500 2:1000 3:2500 4:2600 5:10000 6:90000
local maxhp1 = menu.add_feature("Set Health to 500", "action", selfped.id, function(feat)
    local me
    local chp
    me = player.get_player_ped(player.player_id())

    ped.set_ped_max_health(me, hp[1])

    chp = tostring(ped.get_ped_max_health(me))

    ui.notify_above_map(string.format("Max Health %s Set and filled", chp), "Self Modifier", 23)

    ped.set_ped_max_health(me, hp[1])

    ped.set_ped_health(me, hp[1])

    return HANDLER_POP
end)

local maxhp2 =  menu.add_feature("Set Health to 10000", "action", selfped.id, function(feat)
    local me
    local chp

    me = player.get_player_ped(player.player_id())

    ped.set_ped_max_health(me, hp[2])

    chp = tostring(ped.get_ped_max_health(me))

    ui.notify_above_map(string.format("Max Health %s Set and filled", chp), "Self Modifier", 23)
    ped.set_ped_health(me, hp[2])

    return HANDLER_POP
end)

local maxhp3 =  menu.add_feature("Set Health Freemode Beast 2500", "action", selfped.id,  function(feat)
    local me
    local chp

    me = player.get_player_ped(player.player_id())

    ped.set_ped_max_health(me, hp[3])

    chp = tostring(ped.get_ped_max_health(me))

    ui.notify_above_map(string.format("Max Health %s Set and filled", chp), "Self Modifier", 23)

    ped.set_ped_health(me, hp[3])

    return HANDLER_POP
end)

local maxhp4 = menu.add_feature("Set Health BallisticArmour 2600", "action", selfped.id,  function(feat)
    local me
    local chp

    me = player.get_player_ped(player.player_id())

    ped.set_ped_max_health(me, hp[4])

    chp = tostring(ped.get_ped_max_health(me))

    ui.notify_above_map(string.format("Max Health %s Set and filled", chp), "Self Modifier", 23)

    ped.set_ped_health(me, hp[4])

    return HANDLER_POP
end)

local maxhp5 = menu.add_feature("Set Health to 10000", "action", selfped.id, function(feat)
    local me
    local chp

    me = player.get_player_ped(player.player_id())

    ped.set_ped_max_health(me, hp[5])

    chp = tostring(ped.get_ped_max_health(me))

    ui.notify_above_map(string.format("Max Health %s Set and filled", chp), "Self Modifier", 23)

    ped.set_ped_health(me, hp[5])

    return HANDLER_POP
end)

local maxhp6 = menu.add_feature("Set Health to 90000", "action", selfped.id, function(feat)
    local me
    local chp

    me = player.get_player_ped(player.player_id())

    ped.set_ped_max_health(me, hp[6])

    chp = tostring(ped.get_ped_max_health(me))

    ui.notify_above_map(string.format("Max Health %s Set and filled", chp), "Self Modifier", 23)

    ped.set_ped_health(me, hp[6])

    return HANDLER_POP
end)

local MeHP = menu.add_feature("Reset Health to normal", "action", selfped.id, function(feat)
    local me

    me = player.get_player_ped(player.player_id())

    ped.set_ped_max_health(me, 328)

    ped.set_ped_health(me, 328)
    ui.notify_above_map(string.format("Health Set to High Level Player\n  Default Value 328", playerid), "Self Modifier", 23)

    return HANDLER_POP
end)

	
function Ragdoll0_3(feat)

	local Number1 = 1900
	local Number2 = 2000
	local Number3 = 2000
	local Number4 = 3000
	local Number5 = 99999
	local PlayerP = player.player_id()
	local pedd = player.get_player_ped(PlayerP)


	ped.set_ped_to_ragdoll(pedd, Number1, Number5, 0)

	ped.set_ped_to_ragdoll(pedd, Number5, Number5, feat.value_i)
	entity.apply_force_to_entity(pedd, 1, 12, 20, 10.5, 31, 12.1, 10.3, true, true)				
	

end

function RagdollButton(feat)

	-- while(feat.on)
	-- do
	local Number1 = 1900
	local Number2 = 2000
	local Number3 = 2000
	local Number4 = 3000
	local PlayerP = player.player_id()
	local pedd = player.get_player_ped(PlayerP)
	
	-- if ped.can_ped_ragdoll(pedd) ==false then
	-- ped.set_ped_can_ragdoll(pedd, true)
-- else
	entity.apply_force_to_entity(pedd, 4, 10.0, 0.0, 10.0, 3.0, 0.0, 10.3, true, true)		
	ped.set_ped_to_ragdoll(pedd, Number1, Number2, 0)

	entity.apply_force_to_entity(pedd, 4, 2,0, 0.8, 3, 2.1, 10.3, false, true)				

	ped.set_ped_to_ragdoll(pedd, Number3, Number4, feat.value_i)

	-- end
		return HANDLER_POP
end


function RagdollButtontoggle(feat)

	while(feat.on)
	do
	local Number1 = 1900
	local Number2 = 2000
	local Number3 = 2000
	local Number4 = 3000
	local PlayerP = player.player_id()
	local pedd = player.get_player_ped(PlayerP)
		
	-- if ped.can_ped_ragdoll(pedd) == false then
	-- ped.set_ped_can_ragdoll(pedd, true)
	-- else

		ped.set_ped_to_ragdoll(pedd, Number1, Number2, 3)
		entity.apply_force_to_entity(pedd, 5, 2, 2, 5.8, 3, 2.1, 10.3, true, true)				
		ped.set_ped_to_ragdoll(pedd, Number3, Number4, feat.value_i)
		-- end
		return HANDLER_CONTINUE
end
	return HANDLER_POP
end


function Ragdolltoggle(feat)

	while(feat.on)
	do
	local Number1 = 1900
	local Number2 = 2000
	local Number3 = 2000
	local Number4 = 3000
	local Number5 = 99999
	local PlayerP = player.player_id()
	local pedd = player.get_player_ped(PlayerP)

	-- if ped.can_ped_ragdoll(pedd) == false then
	-- ped.set_ped_can_ragdoll(pedd, true)
	-- else
		ped.set_ped_to_ragdoll(pedd, Number1, Number2, feat.value_i)
			system.wait(100)

		entity.apply_force_to_entity(pedd, 1, 2,0, 0.8, 3, 2.1, 10.3, true, false)
			system.wait(100)

		ped.set_ped_to_ragdoll(pedd, Number3, Number4, feat.value_i)
			system.wait(100)
		entity.apply_force_to_entity(pedd, 1, 2,0, 0.8, 3, 2.1, 10.3, true, false)
			system.wait(100)

		ped.set_ped_to_ragdoll(pedd, Number4, Number5, feat.value_i)
			system.wait(100)
			-- end
		return HANDLER_CONTINUE
	end	
	return HANDLER_POP
end

function Ragdolltoggle1(feat)

	while(feat.on)
	do
	local Number1 = 1900
	local Number2 = 2000
	local Number3 = 2000
	local Number4 = 3000
	local Number5 = 99999
	local PlayerP = player.player_id()
	local pedd = player.get_player_ped(PlayerP)
		

	-- if ped.can_ped_ragdoll(pedd) == false then
	-- ped.set_ped_can_ragdoll(pedd, true)
	-- else

		ped.set_ped_to_ragdoll(pedd, Number1, Number2, feat.value_i)
			system.wait(100)

		entity.apply_force_to_entity(pedd, 4, 2,0, 0.8, 3, 2.1, 10.3, true, false)
			system.wait(100)

		ped.set_ped_to_ragdoll(pedd, Number3, Number4, feat.value_i)
			system.wait(100)
		entity.apply_force_to_entity(pedd, 4, 2,0, 0.8, 3, 2.1, 10.3, true, false)
			system.wait(100)

		ped.set_ped_to_ragdoll(pedd, Number4, Number5, feat.value_i)
			system.wait(100)
			-- end
		return HANDLER_CONTINUE

	end	

	return HANDLER_POP

end

-- function Ragdolltype_feat_value(feat)

	-- ragtype = feat.value_i
	-- RAGN = feat.value_i + 1

	-- ui.notify_above_map("Ragdoll Type Set to: " .. ragtype.."\n("..ragdolltyp[RAGN]..")", "Ragdoll Type Selection", 140)
-- end	

local osd_hotkey = menu.add_feature("Lifeless Ragdoll Hotkey", "toggle", self_options.id, function(feat)
        if feat.on then
            local key = MenuKey()
            key:push_str("LCONTROL")
            key:push_str("o")
            if key:is_down() then
                osdtime.on = not osdtime.on
                 ui.notify_above_map(string.format("Switching OSD options"), "OSD Options", 140)
            end
			end
        return HANDLER_CONTINUE
end)
osd_hotkey.on = true

local ragdoll_key = menu.add_feature("Lifeless Ragdoll", "toggle", selfped.id, function(feat)
        if feat.on then
            local key = MenuKey()
            key:push_str("LCONTROL")
            key:push_str("x")
            if key:is_down() then
                rag_self.on = not rag_self.on
                notify_above_map(string.format("Switching Lifeless Ragdoll Toggle %s\n%s Ragdoll on your ped", rag_self.on and "ON" or "OFF", rag_self.on and "Setting" or "Ending"))
            end
			end
        return HANDLER_CONTINUE
end)
ragdoll_key.on = true

rag_self = menu.add_feature("Lifeless Ragdoll", "toggle", selfped.id, function(feat)
if feat.on then
	local Number1 = 1900
	local Number2 = 2000
	local Number3 = 2000
	local Number4 = 3000
	local PlayerP = player.player_id()
	local pedd = player.get_player_ped(PlayerP)

	ped.set_ped_to_ragdoll(pedd, Number1, Number2, 0)

						entity.apply_force_to_entity(pedd, 4, 2,0, 0.8, 3, 2.1, 10.3, false, true)				
						ped.set_ped_to_ragdoll(pedd, Number3, Number4, 4)
end
			return HANDLER_CONTINUE
	




end)
	rag_self.on = false
	rag_self.threaded = false
	rag_self.max_i = #ragdolltyp
    rag_self.min_i = 1
    rag_self.value_i = 1
	
local twrag_self = menu.add_feature("Twitching Ragdoll", "value_i", selfped.id, RagdollButtontoggle)
	twrag_self.threaded = false
	twrag_self.max_i = #ragdolltyp
    twrag_self.min_i = 1
    twrag_self.value_i = 1
	
local tw1rag_self = menu.add_feature("Twitching Ragdoll v1", "value_i", selfped.id, Ragdolltoggle)
	tw1rag_self.threaded = true
	tw1rag_self.max_i = #ragdolltyp
    tw1rag_self.min_i = 1
    tw1rag_self.value_i = 1
	
local tw2rag_self = menu.add_feature("Twitching Ragdoll v2", "value_i", selfped.id, Ragdolltoggle1)
	tw2rag_self.threaded = true
	tw2rag_self.max_i = #ragdolltyp
    tw2rag_self.min_i = 1
    tw2rag_self.value_i = 1
	
local force_rag_self = menu.add_feature("Ragdoll Self with force", "action", selfped.id, Ragdoll0_3)

local set_rag_self = menu.add_feature("Set Self to Ragdoll", "action", selfped.id, RagdollButton)
	set_rag_self.threaded = false




mk1boostrefill = menu.add_feature("Boost Recharge v.2 MK1 Opressor (self)", "toggle", selfveh.id, function(feat)

	if feat.on then
		
	local myped = player.get_player_ped(player.player_id())
	if ped.is_ped_in_any_vehicle(myped) == true then
	local Curveh = ped.get_vehicle_ped_is_using(myped)
	if vehicle.is_vehicle_rocket_boost_active(Curveh) == false then

	return HANDLER_CONTINUE
	end
	system.wait(2000)
	vehicle.set_vehicle_rocket_boost_percentage(Curveh, 100.00)
	end
		
	return HANDLER_CONTINUE
	end
end)
mk1boostrefill.on = false

mk2boostrefill = menu.add_feature("MK2 Boost Insta-Recharge (self)", "toggle", selfveh.id, function(feat)

			if feat.on then

	
local myped = player.get_player_ped(player.player_id())
	if ped.is_ped_in_any_vehicle(myped) == true then
	local Curveh = ped.get_vehicle_ped_is_using(myped)
	vehicle.set_vehicle_rocket_boost_refill_time(Curveh, 0.000001)
end
	
return HANDLER_CONTINUE
end
end)
mk2boostrefill.threaded = false
mk2boostrefill.on = true


local mk2_rapid_fire = menu.add_feature("MK2 Rapid Fire Missiles (self)", "toggle", selfveh.id, function(feat)
		if feat.on then
local myped = player.get_player_ped(player.player_id())
	if ped.is_ped_in_any_vehicle(myped) == true then
	local Curveh = ped.get_vehicle_ped_is_using(myped)
	vehicle.set_vehicle_fixed(Curveh)
	vehicle.set_vehicle_deformation_fixed(Curveh)
end
return HANDLER_CONTINUE
end end)
mk2_rapid_fire.threaded = false
mk2_rapid_fire.on = false

local hot_key1 = menu.add_feature("mk2 rapid fire hotkey", "toggle", self_options.id, function(feat)
	if feat.on then

    local key = MenuKey()
    
    key:push_str("LCONTROL")
    key:push_str("r")
   
        if key:is_down() then
      mk2_rapid_fire.on = not mk2_rapid_fire.on
	  notify_above_map(string.format("Switching Rapid Fire %s\n%s for your Current Vehicle", mk2_rapid_fire.on and "ON" or "OFF", mk2_rapid_fire.on and "Glitch On" or "Set Repaired"))
  		end
		end		
	return HANDLER_CONTINUE
	
end)
hot_key1.on = true

local rapid_fire1 = menu.add_feature("Rapid Fire Missiles (with delay)", "value_i", selfveh.id, function(feat)

		if feat.on then
local myped = player.get_player_ped(player.player_id())
	if ped.is_ped_in_any_vehicle(myped) == true then
	local Curveh = ped.get_vehicle_ped_is_using(myped)
system.wait(feat.value_i)

	vehicle.set_vehicle_fixed(Curveh)
end
return HANDLER_CONTINUE
end end)
rapid_fire1.threaded = false
rapid_fire1.max_i = 2000
rapid_fire1.min_i = 0
rapid_fire1.value_i = 250
rapid_fire1.mod_i = 2


for pid = 0, 31 do
	local f = menu.add_feature("Player " .. pid, "parent", playersFeature.id)
	local k = menu.add_feature("Vehicle Shit", "parent", f.id)
	local m = menu.add_feature("Modder Death Shit", "parent", f.id)
	local at = menu.add_feature("Attach", "parent", f.id)
	local ato = menu.add_feature("Attach Controls", "parent", at.id)
	local atco = menu.add_feature("Attach Options", "parent", at.id)
	local t = menu.add_feature("Troll Functions", "parent", f.id)
	local g = menu.add_feature("Grief Functions", "parent", f.id)
	local v = menu.add_feature("Other Shit", "parent", g.id)
	local glab = menu.add_feature("0: Wander 1: Attack 2: Stalk", "action", g.id, nil)


	local features = {}
	
		features["ceo money"] = {feat = menu.add_feature("ceo 10k money loop", "toggle", f.id, function(feat)
		if feat.on then
		
		script.trigger_script_event(-601653676, pid, {player.player_id(), 10000, -1292453789, 1, script.get_global_i(1628237 + (1 + (pid * 615)) + 533), script.get_global_i(1650640 + 9), script.get_global_i(1650640 + 10)})
			system.wait(30000)
			end
		return HANDLER_POP
	end), type = "toggle", callback = function()
	end}
	features["ceo money"].feat.threaded = true
	

	
	features["flashys"] = {feat = menu.add_feature("Attach Random Flashing lights", "action", v.id, function(feat)
		
            local pedd = player.get_player_ped(pid)
			ped.get_ped_bone_coords(pedd, 0, offset)
			local pedbool
            local pos = v3()
			local hash = gameplay.get_hash_key("prop_dummy_light")
			local rot = v3()
			rot.x = 0.0
			rot.y = 0.0
			rot.z = 0.0
			local offset = v3()
			local offset0 = v3()
			offset0.x = 0.00
			offset0.y = 0.00
			offset0.z = 0.00
			local j = math.random(1, 10)
			B_ID =	boneid[j]
			local bidx = ped.get_ped_bone_index(pedd, B_ID)
			local i = #dildos + 1
			
               pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y / 100
				offset.y =  offset0.y + y / 100
				offset.z = offset0.z + y / 100
                dildos[i] = object.create_object(hash, pos, true, false)
				
				entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
				
                entity.apply_force_to_entity(dildos[i], 3, 0, 0, 1000, y, 0, y, true, true)
			pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y / 10
				offset.y =  offset0.y + y / 10
				offset.z = offset0.z + y / 10
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, false)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, offset, true, false, false, 0, true)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 5, 100, 0, 1000, 0, y, y, true, true)
				pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y / 100
				offset.y =  offset0.y + y / 100
				offset.z = offset0.z + y / 100
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, false)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 3, 200, 0, 1000, y, y, 0, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
				pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y * 10
				offset.y =  offset0.y + y * 10
				offset.z = offset0.z + y * 10
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, false)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 5, 100, 0, 1000, 0, y, y, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, offset, true, false, false, 0, true)
				system.wait(500)
				local i = #dildos + 1
               pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y * 10
				offset.y =  offset0.y + y * 10
				offset.z = offset0.z + y * 10
                dildos[i] = object.create_object(hash, pos, true, true)
				
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 3, 0, 0, 1000, y, 0, y, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
			pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y / 10
				offset.y =  offset0.y + y / 10
				offset.z = offset0.z + y / 10
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, offset, true, false, false, 0, true)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 5, 0, 0, 1000, 0, y, y, true, true)
				pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				
			  	offset.x = offset0.x + y / 100
				offset.y =  offset0.y + y / 100
				offset.z = offset0.z + y / 100
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 3, 0, 0, 1000, y, y, 0, true, true)
				pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, offset, true, false, false, 0, true)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				
			  	offset.x = offset0.x + y / 100
				offset.y =  offset0.y + y / 100
				offset.z = offset0.z + y / 100
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, true)
				local y = math.random(1, 20)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
                entity.apply_force_to_entity(dildos[i], 5, 0, 0, 1000, 0, y, y, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
				system.wait(500)
				for i = 1, #dildos do

                    entity.set_entity_as_no_longer_needed(dildos[i])
					--entity.delete_entity(dildos[i])
       
    end

		end), type = "action"}
    features["flashys"].feat.threaded = true

		
	features["dildobombs"] = {feat = menu.add_feature("Flashing lights From Ass Bombs", "action", v.id, function(feat)
		
            local pedd = player.get_player_ped(pid)
			ped.get_ped_bone_coords(pedd, 0, offset)
			local pedbool
            local pos = v3()
			local hash = gameplay.get_hash_key("prop_dummy_light")
			local rot = v3()
			rot.x = 0.0
			rot.y = 0.0
			rot.z = 0.0
			local offset = v3()
			local offset0 = v3()
			offset0.x = 0.00
			offset0.y = 0.00
			offset0.z = 0.00
			local j = math.random(1, 10)
			B_ID =	boneid[j]
			local bidx = ped.get_ped_bone_index(pedd, B_ID)
			local i = #dildos + 1
			
               pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y / 100
				offset.y =  offset0.y + y / 100
				offset.z = offset0.z + y / 100
                dildos[i] = object.create_object(hash, pos, true, false)
				
				entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
				
                entity.apply_force_to_entity(dildos[i], 3, 0, 0, 1000, y, 0, y, true, true)
			pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y / 10
				offset.y =  offset0.y + y / 10
				offset.z = offset0.z + y / 10
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, false)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, offset, true, false, false, 0, true)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 5, 100, 0, 1000, 0, y, y, true, true)
				pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y / 100
				offset.y =  offset0.y + y / 100
				offset.z = offset0.z + y / 100
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, false)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 3, 200, 0, 1000, y, y, 0, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
				pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y * 10
				offset.y =  offset0.y + y * 10
				offset.z = offset0.z + y * 10
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, false)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 5, 100, 0, 1000, 0, y, y, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, offset, true, false, false, 0, true)
				system.wait(500)
				local i = #dildos + 1
               pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y * 10
				offset.y =  offset0.y + y * 10
				offset.z = offset0.z + y * 10
                dildos[i] = object.create_object(hash, pos, true, true)
				
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 3, 0, 0, 1000, y, 0, y, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
			pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				offset.x = offset0.x
				offset.y =  offset0.y
				offset.z = offset0.z
			  	offset.x = offset0.x + y / 10
				offset.y =  offset0.y + y / 10
				offset.z = offset0.z + y / 10
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, offset, true, false, false, 0, true)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 5, 0, 0, 1000, 0, y, y, true, true)
				pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				
			  	offset.x = offset0.x + y / 100
				offset.y =  offset0.y + y / 100
				offset.z = offset0.z + y / 100
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
				local y = math.random(1, 20)
                entity.apply_force_to_entity(dildos[i], 3, 0, 0, 1000, y, y, 0, true, true)
				pedbool, pos = ped.get_ped_bone_coords(pedd, 0, offset)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, offset, true, false, false, 0, true)
			   local y = math.random(-50, 80)
			  	pos.x = pos.x + y / 100
				pos.y = pos.y + y / 100
				pos.z = pos.z + y / 100
				
				
				
			  	offset.x = offset0.x + y / 100
				offset.y =  offset0.y + y / 100
				offset.z = offset0.z + y / 100
			local i = #dildos + 1
                dildos[i] = object.create_object(hash, pos, true, true)
				local y = math.random(1, 20)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
                entity.apply_force_to_entity(dildos[i], 5, 0, 0, 1000, 0, y, y, true, true)
					entity.attach_entity_to_entity(dildos[i], pedd, bidx, offset, rot, true, false, false, 0, true)
				system.wait(500)
				for i = 1, #dildos do
                   pos = entity.get_entity_coords(dildos[i])
                    fire.add_explosion(pos, 60, true, false, 5, 1)
                    fire.add_explosion(pos, 60, true, false, 1, 0)
                    pos = entity.get_entity_coords(dildos[i])
                    fire.add_explosion(pos, 59, true, false, 1, 1)
                    fire.add_explosion(pos, 59, false, true, 1, 0)
                    fire.add_explosion(pos, 59, true, false, 5, 1)
                    fire.add_explosion(pos, 59, true, false, 5, 0)

                    fire.add_explosion(pos, 60, true, false, 5, 1)
                    fire.add_explosion(pos, 60, true, false, 1, 0)

                    fire.add_explosion(pos, 59, true, false, 1, 1)
                    fire.add_explosion(pos, 59, false, true, 1, 0)
                    fire.add_explosion(pos, 59, true, false, 5, 1)
                    fire.add_explosion(pos, 59, true, false, 5, 0)

					system.wait(10)
                    entity.set_entity_as_no_longer_needed(dildos[i])
					--entity.delete_entity(dildos[i])
       
    end

		end), type = "action"}
    features["dildobombs"].feat.threaded = true


--attach control

features["oscdatch"] = {feat = menu.add_feature("OSD Position Data", "toggle", atco.id, function(feat)
		features["osdatch"].feat.on = false
	if feat.on then

		local osd_rdata2 = tostring(rot_data_x2..", "..rot_data_y2..", "..rot_data_z2)
		local osd_odata2 = tostring(offset_data_x2..", "..offset_data_y2..", "..offset_data_z2)
			
		local pos = v2()
		pos.x = .305
        pos.y = .0001
		ui.set_text_scale(0.25)
		ui.set_text_font(0)
		ui.set_text_centre(0)
		ui.set_text_color(255, 0, 0, 255)
		ui.set_text_outline(1)
		ui.draw_text("Attachment Positioning Data:\nOffet: "..osd_odata2.."\nRotation: "..osd_rdata2, pos)

		end
	return HANDLER_CONTINUE
end), type = "toggle"}
		features["oscdatch"].feat.threaded = false
		features["oscdatch"].feat.on = false

		features["cbone"] = {feat =  menu.add_feature("Change Bone", "action_value_i", atco.id, function(f)
			local i = f.value_i
			
			B_ID =	boneid[i]
			local BoneName = bone_name[f.value_i]
			ui.notify_above_map(string.format(BoneName), "Bone Selector", 063)
		 
		end), type = "action_value_i"}
		features["cbone"].feat.max_i = #boneid
		features["cbone"].feat.min_i = 1	
		features["cbone"].feat.value_i = 1

  		features["cprecision"] = {feat = menu.add_feature("Precision Positioning", "toggle", atco.id, function(feat) end), type = "toggle"}
		features["cprecision"].feat.threaded = false
	
	

		features["offset_reset"] = {feat = menu.add_feature("Reset All offset values", "action", atco.id, function(feat)
			features["cattach01x"].feat.value_i = 0
			features["cattach01y"].feat.value_i = 0
			features["cattach01z"].feat.value_i = 0
			features["cattachr01x"].feat.value_i = 0
			features["cattachr01y"].feat.value_i = 0
			features["cattachr01z"].feat.value_i = 0
	offset_data_x2 = 0.0
	offset_data_y2 = 0.0
	offset_data_z2 = 0.0
	rot_data_x2 = 0.0
	rot_data_y2 = 0.0
	rot_data_z2 = 0.0

			end), type = "action"}
		features["offset_reset"].feat.threaded = false


	
		  		features["attcoll"] = {feat = menu.add_feature("Attach With Collision", "toggle", atco.id, function(feat) end), type = "toggle"}
		features["attcoll"].feat.threaded = false
		
		features["coffxmod"] = {feat =  menu.add_feature("Change step 1 = 1/10 (0.01)", "autoaction_value_i", atco.id, function(f)
		  features["cattach01x"].feat.mod_i = f.value_i
		  features["cattach01y"].feat.mod_i = f.value_i
		  features["cattach01z"].feat.mod_i = f.value_i
		  features["cattachr01x"].feat.mod_i = f.value_i
		  features["cattachr01y"].feat.mod_i = f.value_i
		  features["cattachr01z"].feat.mod_i = f.value_i
		end), type = "autoaction_value_i"}
		features["coffxmod"].feat.max_i = 1000
		features["coffxmod"].feat.min_i = 1	
					
		 features["cattach01x"] = {feat =  menu.add_feature("set offset x", "autoaction_value_i", atco.id, function(feat)
		 if features["cprecision"].feat.on then
			 offset_data_x2 = tonumber(feat.value_i / 100)
			else
			offset_data_x2 = tonumber(feat.value_i)
		 end
		 end), type = "autoaction_value_i"}
		features["cattach01x"].feat.max_i = 30000
		features["cattach01x"].feat.min_i = -30000
		 features["cattach01x"].feat.value_i = 0
		 features["cattach01x"].feat.mod_i = 1
		 
		features["cattach01y"] = {feat = menu.add_feature("set offset y", "autoaction_value_i", atco.id, function(feat)
		 if features["cprecision"].feat.on then
			 offset_data_y2 = tonumber(feat.value_i / 100)
			else
			offset_data_y2 = tonumber(feat.value_i)
		 end
		end), type = "autoaction_value_i"}
		 features["cattach01y"].feat.max_i = 30000
		 features["cattach01y"].feat.min_i = -30000
		 features["cattach01y"].feat.value_i = 10
		 features["cattach01y"].feat.mod_i = 1
		 
		features["cattach01z"] = {feat = menu.add_feature("set offset z", "autoaction_value_i", atco.id, function(feat)
		 if features["cprecision"].feat.on then
			 offset_data_z2 = tonumber(feat.value_i / 100)
			else
			offset_data_z2 = tonumber(feat.value_i)
		 end
		end), type = "autoaction_value_i"}
		 features["cattach01z"].feat.max_i = 30000
		 features["cattach01z"].feat.min_i = -30000
		 features["cattach01z"].feat.value_i = 0
		 features["cattach01z"].feat.mod_i = 1

			
		 features["cattachr01x"] = {feat =  menu.add_feature("set Rotation x", "autoaction_value_i", atco.id, function(feat)

			rot_data_x2 = tonumber(feat.value_i)
		 
		 end), type = "autoaction_value_i"}
		features["cattachr01x"].feat.max_i = 300000
		features["cattachr01x"].feat.min_i = -300000
		 features["cattachr01x"].feat.value_i = 0
		 features["cattachr01x"].feat.mod_i = 1
				 
		features["cattachr01y"] = {feat = menu.add_feature("set Rotation y", "autoaction_value_i", atco.id, function(feat)

			rot_data_y2 = tonumber(feat.value_i)

		end), type = "autoaction_value_i"}
		 features["cattachr01y"].feat.max_i = 300000
		 features["cattachr01y"].feat.min_i = -300000
		 features["cattachr01y"].feat.value_i = 0
		 features["cattachr01y"].feat.mod_i = 1
		 
		features["cattachr01z"] = {feat = menu.add_feature("set Rotation z", "autoaction_value_i", atco.id, function(feat)

			rot_data_z2 = tonumber(feat.value_i)

		end), type = "autoaction_value_i"}
		 features["cattachr01z"].feat.max_i = 300000
		 features["cattachr01z"].feat.min_i = -300000
		 features["cattachr01z"].feat.value_i = 0
		 features["cattachr01z"].feat.mod_i = 1
		 
		features["attachcf1"] = {feat = menu.add_feature("Force Changes on Last Attachment", "toggle", atco.id, function(feat)
		if feat.on then
		local pedd = player.get_player_ped(pid)
        local pos = v3()
		pos = player.get_player_coords(pid)
		local offset = v3()
		offset.x = offset_data_x2
		offset.y = offset_data_y2
		offset.z = offset_data_z2
		local rot = v3()
		rot.x = rot_data_x2
		rot.y = rot_data_y2
		rot.z = rot_data_z2
		
		local i = #attached_shitc 
	
		local bidx = ped.get_ped_bone_index(pedd, B_ID)
		if features["attcoll"].feat.on then

        entity.attach_entity_to_entity(attached_shitc[i], pedd, bidx, offset, rot, true, true, false, 0, true)
		else
        entity.attach_entity_to_entity(attached_shitc[i], pedd, bidx, offset, rot, true, false, false, 0, true)
		end
		end
		return HANDLER_CONTINUE
	
			end), type = "toggle"}
		features["attachcf1"].feat.threaded = false
 	
	
 		features["cattach1"] = {feat = menu.add_feature("attach Lights Dildos etc Fixed", "action_value_i", atco.id, function(feat)
		local pedd = player.get_player_ped(pid)
		local plyveh = player.get_player_vehicle(pid)
        local pos = v3()
		pos = player.get_player_coords(pid)
		local offset = v3()
		offset.x = offset_data_x2
		offset.y = offset_data_y2
		offset.z = offset_data_z2
		local rot = v3()
		rot.x = rot_data_x2
		rot.y = rot_data_y2
		rot.z = rot_data_z2
		local i = #attached_shitc + 1
		local hash = gameplay.get_hash_key(crashnamearray[feat.value_i])
        attached_shitc[i] = object.create_object(hash, pos, true, true)

			end), type = "action_value_i"}
		features["cattach1"].feat.threaded = false
		features["cattach1"].feat.max_i = #crashnamearray
		features["cattach1"].feat.min_i = 1
		features["cattach1"].feat.value_i = 1

 
	features["cattach01"] = {feat = menu.add_feature("Select item to attach", "action_value_i", atco.id, function(feat)
		local pedd = player.get_player_ped(pid)
		
        local pos = v3()
		pos = player.get_player_coords(pid)
		local offset = v3()
		offset.x = offset_data_x2
		offset.y = offset_data_y2
		offset.z = offset_data_z2
		local rot = v3()
		rot.x = rot_data_x
		rot.y = rot_data_y
		rot.z = rot_data_z
		local i = #attached_shit + 1
		local hash = gameplay.get_hash_key(proparray[feat.value_i])
        attached_shitc[i] = object.create_object(hash, pos, true, true)

		-- local bidx = ped.get_ped_bone_index(pedd, B_ID)
		

        -- entity.attach_entity_to_entity(attached_shit[i], pedd, bidx, offset, rot, true, false, false, 0, true)

		
	
			end), type = "action_value_i"}
		features["cattach01"].feat.threaded = false
		features["cattach01"].feat.max_i = #proparray
		features["cattach01"].feat.min_i = 1
		features["cattach01"].feat.value_i = 1
		
			
	features["cdel_att"] = {feat = menu.add_feature("Delete Attachments on Player", "action", atco.id, function(feat)
		
		local pedd = player.get_player_ped(pid)
		local attached_entity = entity.get_entity_attached_to(pedd)
	network.request_control_of_entity(attached_entity)
		entity.detach_entity(attached_entity)
		entity.set_entity_as_no_longer_needed(attached_entity)
		entity.delete_entity(attached_entity)

	for i = 1, #attached_shit do
	network.request_control_of_entity(attached_shit[i])
		entity.detach_entity(attached_shitc[i])
		entity.set_entity_as_no_longer_needed(attached_shitc[i])
		entity.delete_entity(attached_shitc[i])
	end
				end), type = "action"}
	features["cdel_att"].feat.threaded = false
			
 
--attach
features["bone"] = {feat =  menu.add_feature("Change Bone", "action_value_i", ato.id, function(f)
	local i = f.value_i
	
	B_ID =	boneid[i]
	local BoneName = bone_name[f.value_i]
	ui.notify_above_map(string.format(BoneName), "Bone Selector", 063)
 
end), type = "action_value_i"}
features["bone"].feat.max_i = #boneid
features["bone"].feat.min_i = 1	
features["bone"].feat.value_i = 1

features["osdatch"] = {feat = menu.add_feature("OSD Position Data", "toggle", ato.id, function(feat)
	features["oscdatch"].feat.on = false
	if feat.on then
		local osd_rdata = tostring(rot_data_x..", "..rot_data_y..", "..rot_data_z)
		local osd_odata = tostring(offset_data_x..", "..offset_data_y..", "..offset_data_z)
			
		local pos = v2()
		pos.x = .305
        pos.y = .0001
		ui.set_text_scale(0.25)
		ui.set_text_font(0)
		ui.set_text_centre(0)
		ui.set_text_color(255, 0, 0, 255)
		ui.set_text_outline(1)
		ui.draw_text("Attachment Positioning Data:\nOffet: "..osd_odata.."\nRotation: "..osd_rdata, pos)

		end
	return HANDLER_CONTINUE
end), type = "toggle"}
		features["osdatch"].feat.threaded = false
		features["osdatch"].feat.on = false


  		features["precision"] = {feat = menu.add_feature("Precision Positioning", "toggle", ato.id, function(feat) end), type = "toggle"}
		features["precision"].feat.threaded = false

  		features["resetpos"] = {feat = menu.add_feature("Reset All Current Position Values", "action", ato.id, function(feat)
	offset_data_z = 0.0
	offset_data_y = 0.0
	offset_data_x = 0.0

	rot_data_x = 0.0
	rot_data_y = 0.0
	rot_data_z = 0.0
			end), type = "action"}
		features["resetpos"].feat.threaded = false

features["offxmod"] = {feat =  menu.add_feature("Change step 1 = 1/100 (0.01)", "action_value_i", ato.id, function(f)
  features["attach01x"].feat.mod_i = f.value_i
  features["attach01y"].feat.mod_i = f.value_i
  features["attach01z"].feat.mod_i = f.value_i
  features["attachr01x"].feat.mod_i = f.value_i
  features["attachr01y"].feat.mod_i = f.value_i
  features["attachr01z"].feat.mod_i = f.value_i
  	if features["precision"].feat.on then
  step_value = f.value_i / 100
  else
 step_value = f.value_i
	end
  ui.notify_above_map(string.format("Offset & Rotation Step Value is now:\n"..step_value), "Offset & Rotation Value", 063)
end), type = "action_value_i"}
features["offxmod"].feat.max_i = 10000
features["offxmod"].feat.min_i = 1	
	
 features["attach01x"] = {feat =  menu.add_feature("set offset x", "action_value_i", ato.id, function(feat)
 if features["precision"].feat.on then
	value_num =  feat.value_i / 100
	offset_data_x = tonumber(offset_data_x  + value_num)
	else
	value_num =  feat.value_i 
		end
	offset_data_x = tonumber(offset_data_x  + value_num)

 
 end), type = "action_value_i"}
features["attach01x"].feat.max_i = 10
features["attach01x"].feat.min_i = -10
 features["attach01x"].feat.value_i = 0
 features["attach01x"].feat.mod_i = 1
 
features["attach01y"] = {feat = menu.add_feature("set offset y", "action_value_i", ato.id, function(feat)
if features["precision"].feat.on then
	value_num =  feat.value_i / 100
	offset_data_y = tonumber(offset_data_y  + value_num)
	else
	value_num =  feat.value_i 
end
	offset_data_y = tonumber(offset_data_y  + value_num)
	
end), type = "action_value_i"}
 features["attach01y"].feat.max_i = 10
 features["attach01y"].feat.min_i = -10
 features["attach01y"].feat.value_i = 0
 features["attach01y"].feat.mod_i = 1
 
features["attach01z"] = {feat = menu.add_feature("set offset z", "action_value_i", ato.id, function(feat)
if features["precision"].feat.on then
	value_num =  feat.value_i / 100
	offset_data_z = tonumber(offset_data_z + value_num)
	else
	value_num =  feat.value_i
end
	offset_data_z = tonumber(offset_data_z  + value_num)
	
end), type = "action_value_i"}
 features["attach01z"].feat.max_i = 10
 features["attach01z"].feat.min_i = -10
 features["attach01z"].feat.value_i = 0
 features["attach01z"].feat.mod_i = 1
 	
 features["attachr01x"] = {feat =  menu.add_feature("set Rotation x", "action_value_i", ato.id, function(feat)
 if features["precision"].feat.on then
	value_num =  feat.value_i / 100
	rot_data_x = tonumber(rot_data_x  + value_num)
	else
	value_num =  feat.value_i
 end
	rot_data_x = tonumber(rot_data_x + value_num)
	
 end), type = "action_value_i"}
features["attachr01x"].feat.max_i = 10
features["attachr01x"].feat.min_i = -10
 features["attachr01x"].feat.value_i = 0
 features["attachr01x"].feat.mod_i = 1
 
features["attachr01y"] = {feat = menu.add_feature("set Rotation y", "action_value_i", ato.id, function(feat)
 if features["precision"].feat.on then
	value_num =  feat.value_i / 100
	rot_data_y = tonumber(rot_data_y  + value_num)
	else
	value_num =  feat.value_i 
	rot_data_y = tonumber(rot_data_y + value_num)
	end
end), type = "action_value_i"}
 features["attachr01y"].feat.max_i = 10
 features["attachr01y"].feat.min_i = -10
 features["attachr01y"].feat.value_i = 0
 features["attachr01y"].feat.mod_i = 1
 
features["attachr01z"] = {feat = menu.add_feature("set Rotation z", "action_value_i", ato.id, function(feat)
if features["precision"].feat.on then
	value_num =  feat.value_i / 100
	rot_data_z = tonumber(rot_data_z  + value_num)
	else
	value_num =  feat.value_i 
	rot_data_z = tonumber(rot_data_z + value_num)
	end
end), type = "action_value_i"}
 features["attachr01z"].feat.max_i = 10
 features["attachr01z"].feat.min_i = -10
 features["attachr01z"].feat.value_i = 0
 features["attachr01z"].feat.mod_i = 1
 
	features["attach01"] = {feat = menu.add_feature("Select item to attach", "action_value_i", ato.id, function(feat)
		local pedd = player.get_player_ped(pid)
		
        local pos = v3()
		pos = player.get_player_coords(pid)
		local offset = v3()
		offset.x = offset_data_x
		offset.y = offset_data_y
		offset.z = offset_data_z
		local rot = v3()
		rot.x = rot_data_x
		rot.y = rot_data_y
		rot.z = rot_data_z
		local i = #attached_shit + 1
		local hash = gameplay.get_hash_key(proparray[feat.value_i])
        attached_shit[i] = object.create_object(hash, pos, true, true)

		local bidx = ped.get_ped_bone_index(pedd, B_ID)
		

        entity.attach_entity_to_entity(attached_shit[i], pedd, bidx, offset, rot, true, false, false, 0, true)

		
	
			end), type = "action_value_i"}
		features["attach01"].feat.threaded = false
		features["attach01"].feat.max_i = #proparray
		features["attach01"].feat.min_i = 1
		features["attach01"].feat.value_i = 1
		

		features["attach1"] = {feat = menu.add_feature("attach Lights Dildos etc Fixed", "action_value_i", ato.id, function(feat)
		local pedd = player.get_player_ped(pid)
		local plyveh = player.get_player_vehicle(pid)
        local pos = v3()
		pos = player.get_player_coords(pid)
		local offset = v3()
		offset.x = offset_data_x
		offset.y = offset_data_y
		offset.z = offset_data_z
		local rot = v3()
		rot.x = rot_data_x
		rot.y = rot_data_y
		rot.z = rot_data_z
		local i = #attached_shit + 1
		local hash = gameplay.get_hash_key(crashnamearray[feat.value_i])
        attached_shit[i] = object.create_object(hash, pos, true, true)

        network.request_control_of_entity(plyveh)
		local b = tonumber(ped_bone_sel)
		local bidx = ped.get_ped_bone_index(pedd, B_ID)

        entity.attach_entity_to_entity(attached_shit[i], pedd, bidx, offset, rot, true, false, false, 0, true)


			end), type = "action_value_i"}
		features["attach1"].feat.threaded = false
		features["attach1"].feat.max_i = #crashnamearray
		features["attach1"].feat.min_i = 1
		features["attach1"].feat.value_i = 1
	
	
		features["attachf1"] = {feat = menu.add_feature("Force Attach all spawns", "toggle", ato.id, function(feat)
		if feat.on then
		local pedd = player.get_player_ped(pid)
		local plyveh = player.get_player_vehicle(pid)
        local pos = v3()
		pos = player.get_player_coords(pid)
		local offset = v3()
		offset.x = offset_data_x
		offset.y = offset_data_y
		offset.z = offset_data_z
		local rot = v3()
		rot.x = rot_data_x
		rot.y = rot_data_y
		rot.z = rot_data_z
		
		for i = 1, #attached_shit do
	
		local bidx = ped.get_ped_bone_index(pedd, B_ID)
		

        entity.attach_entity_to_entity(attached_shit[i], pedd, bidx, offset, rot, true, false, false, 0, true)
		end
		return HANDLER_CONTINUE
		end
			end), type = "toggle"}
		features["attachf1"].feat.threaded = false

	
	
		features["attach1"] = {feat = menu.add_feature("no attach Objects", "action_value_i", ato.id, function(feat)
		local pedd = player.get_player_ped(pid)
		local plyveh = player.get_player_vehicle(pid)
        local pos = v3()
		pos = player.get_player_coords(pid)
		local offset = v3()
		offset.x = offset_data_x / 100
		offset.y = offset_data_y / 100
		offset.z = offset_data_z / 100
		local rot = v3()
		rot.x = rot_data_x / 100
		rot.y = rot_data_y / 100
		rot.z = rot_data_z / 100
		local i = #attached_shit + 1
		local hash = gameplay.get_hash_key(crashnamearray[feat.value_i])
        attached_shit[i] = object.create_object(hash, pos, true, false)
		entity.freeze_entity(attached_shit[i], true)
		entity.set_entity_collision(attached_shit[i], false, false, 0)
			
			end), type = "action_value_i"}
		features["attach1"].feat.threaded = false
		features["attach1"].feat.max_i = #crashnamearray
		features["attach1"].feat.min_i = 1
		features["attach1"].feat.value_i = 1
	
	features["del_att"] = {feat = menu.add_feature("Delete Attachments on Player", "action", ato.id, function(feat)
		
		local pedd = player.get_player_ped(pid)
		local attached_entity = entity.get_entity_attached_to(pedd)
	network.request_control_of_entity(attached_entity)
		entity.detach_entity(attached_entity)
		entity.set_entity_as_no_longer_needed(attached_entity)
		entity.delete_entity(attached_entity)

	for i = 1, #attached_shit do
	network.request_control_of_entity(attached_shit[i])
		entity.detach_entity(attached_shit[i])
		entity.set_entity_as_no_longer_needed(attached_shit[i])
		entity.delete_entity(attached_shit[i])
	end
				end), type = "action"}
	features["del_att"].feat.threaded = false
	
	features["sendlesterop2"] = {feat = menu.add_feature("MK2 Lester", "action_value_i", g.id, function(feat)
					local attack = feat.value_i
					local pedp = player.get_player_ped(pid)
					local pos = v3()
					pos = player.get_player_coords(pid)
					pos.x = pos.x + 15
					pos.y = pos.y + 15
					ground, pos.z = gameplay.get_ground_z(pos)
					pos.z = pos.z + 20
					local model = gameplay.get_hash_key("ig_lestercrest_2")
					streaming.request_model(model)

					while (not streaming.has_model_loaded(model)) do
					system.wait(10)
					end

					local i = #lester + 1
					lester[i] = ped.create_ped(6, model, pos, pos.z, true, false)
										entity.set_entity_god_mode(lester[i], true)
					streaming.set_model_as_no_longer_needed(model)

					local vehhash = gameplay.get_hash_key("Oppressor2")

					streaming.request_model(vehhash)
					while (not streaming.has_model_loaded(vehhash)) do
					system.wait(10)
					end

					local y = #lesveh + 1
					lesveh[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
					vehicle.set_vehicle_mod_kit_type(lesveh[y], 0)
					vehicle.get_vehicle_mod(lesveh[y], 10)
					vehicle.set_vehicle_mod(lesveh[y], 10, 1, false)
					ui.add_blip_for_entity(lesveh[y])
					local blipid = ui.get_blip_from_entity(lesveh[y])
					ui.set_blip_colour(blipid, 72)
					ui.set_blip_sprite(blipid, 639)
					vehicle.set_vehicle_on_ground_properly(lesveh[y])
					entity.set_entity_god_mode(lesveh[y], true)
					vehicle.set_vehicle_doors_locked(lesveh[y], 5)

					network.request_control_of_entity(lesveh[y])

					ped.set_ped_combat_attributes(lester[i], 46, true)

					ped.set_ped_combat_attributes(lester[i], 52, true)

					ped.set_ped_combat_attributes(lester[i], 1, true)

					ped.set_ped_combat_attributes(lester[i], 2, true)

					ped.set_ped_combat_range(lester[i], 2)

					ped.set_ped_combat_ability(lester[i], 2)

					ped.set_ped_combat_movement(lester[i], 2)
					ped.set_ped_into_vehicle(lester[i], lesveh[y], -1)
					if ai.task_vehicle_drive_wander(lester[i], lesveh[y], 180, 262144) then
					system.wait(10)
					end

					vehicle.set_vehicle_doors_locked(lesveh[y], 6)

					vehicle.set_vehicle_doors_locked(lesveh[y], 2)
					entity.set_entity_coords_no_offset(lesveh[y], pos)

					

					if attack == 1 then
						ai.task_combat_ped(lester[i], pedp, 0, 16)
						else
						if attack == 2 then
						ai.task_vehicle_follow(lester[i], lesveh[y], pedp, 220, 262144, 25)
						
					end
					end


					streaming.set_model_as_no_longer_needed(vehhash)
	end), type = "action_value_i"}
		features["sendlesterop2"].feat.threaded = false
		features["sendlesterop2"].feat.max_i = 2
		features["sendlesterop2"].feat.min_i = 0
		features["sendlesterop2"].feat.value_i = 0
		
	features["Stalkerlester2"] = {feat = menu.add_feature("scramjet lester", "action_value_i", g.id, function(feat)
					local attack = feat.value_i

					local modd = 1
					local pedp = player.get_player_ped(pid)
					local pos = v3()
					pos = player.get_player_coords(pid)
					pos.x = pos.x + 15
					pos.y = pos.y - 15
					ground, pos.z = gameplay.get_ground_z(pos)

					local model = gameplay.get_hash_key("ig_lestercrest_2")
					streaming.request_model(model)

					while (not streaming.has_model_loaded(model)) do
					system.wait(10)
					end

					local i = #lester + 1
					lester[i] = ped.create_ped(6, model, pos, pos.z, true, false)
					entity.set_entity_god_mode(lester[i], true)
					streaming.set_model_as_no_longer_needed(model)

					local vehhash = gameplay.get_hash_key("scramjet")

					streaming.request_model(vehhash)
					while (not streaming.has_model_loaded(vehhash)) do
					system.wait(10)
					end

					local y = #lesveh + 1
					lesveh[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
					vehicle.set_vehicle_mod_kit_type(lesveh[y], 0)
					vehicle.get_vehicle_mod(lesveh[y], 10)
					vehicle.set_vehicle_mod(lesveh[y], 10, 0, false)
					ui.add_blip_for_entity(lesveh[y])
					local blipid = ui.get_blip_from_entity(lesveh[y])
					ui.set_blip_sprite(blipid, 634)
					vehicle.set_vehicle_on_ground_properly(lesveh[y])
					entity.set_entity_god_mode(lesveh[y], true)
					vehicle.set_vehicle_doors_locked(lesveh[y], 5)

					network.request_control_of_entity(lesveh[y])

					ped.set_ped_combat_attributes(lester[i], 46, true)

					ped.set_ped_combat_attributes(lester[i], 52, true)

					ped.set_ped_combat_attributes(lester[i], 1, true)

					ped.set_ped_combat_attributes(lester[i], 2, true)

					ped.set_ped_combat_range(lester[i], 2)

					ped.set_ped_combat_ability(lester[i], 2)

					ped.set_ped_combat_movement(lester[i], 2)
					ped.set_ped_into_vehicle(lester[i], lesveh[y], -1)
					if ai.task_vehicle_drive_wander(lester[i], lesveh[y], 180, 262144) then
					system.wait(10)
					end

					vehicle.set_vehicle_doors_locked(lesveh[y], 6)

				
					vehicle.set_vehicle_doors_locked(lesveh[y], 2)
					entity.set_entity_coords_no_offset(lesveh[y], pos)

						if attack == 1 then
						ai.task_combat_ped(lester[i], pedp, 0, 16)
						else
						if attack == 2 then
						ai.task_vehicle_follow(lester[i], lesveh[y], pedp, 220, 262144, 25)
						
					end
					end


					streaming.set_model_as_no_longer_needed(vehhash)
		end), type = "action_value_i"}
		features["Stalkerlester2"].feat.threaded = false
		features["Stalkerlester2"].feat.max_i = 2
		features["Stalkerlester2"].feat.min_i = 0
		features["Stalkerlester2"].feat.value_i = 0

		
	features["sendlesterop"] = {feat = menu.add_feature("Opressor Lester MK1", "action_value_i", g.id, function(feat)
					local attack = feat.value_i

					local modd = 1
					local pedp = player.get_player_ped(pid)
					local pos = v3()
					pos = player.get_player_coords(pid)
					pos.x = pos.x + 10
					pos.y = pos.y + 10
					ground, pos.z = gameplay.get_ground_z(pos)

					local model = gameplay.get_hash_key("ig_lestercrest_2")
					streaming.request_model(model)

					while (not streaming.has_model_loaded(model)) do
						system.wait(10)
					end

					local i = #lester + 1
					lester[i] = ped.create_ped(6, model, pos, pos.z, true, false)
					entity.set_entity_god_mode(lester[i], true)
					streaming.set_model_as_no_longer_needed(model)

					local vehhash = gameplay.get_hash_key("Oppressor")

					streaming.request_model(vehhash)
					while (not streaming.has_model_loaded(vehhash)) do
						system.wait(10)
					end

					local y = #lesveh + 1
					lesveh[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
					vehicle.set_vehicle_mod_kit_type(lesveh[y], 0)
					vehicle.get_vehicle_mod(lesveh[y], 10)
					vehicle.set_vehicle_mod(lesveh[y], 10, 0, false)
					ui.add_blip_for_entity(lesveh[y])
					local blipid = ui.get_blip_from_entity(lesveh[y])
					ui.set_blip_sprite(blipid, 559)
					vehicle.set_vehicle_on_ground_properly(lesveh[y])
					entity.set_entity_god_mode(lesveh[y], true)
					vehicle.set_vehicle_doors_locked(lesveh[y], 5)

					network.request_control_of_entity(lesveh[y])

					ped.set_ped_combat_attributes(lester[i], 46, true)

					ped.set_ped_combat_attributes(lester[i], 52, true)

					ped.set_ped_combat_attributes(lester[i], 1, true)

					ped.set_ped_combat_attributes(lester[i], 2, true)

					ped.set_ped_combat_range(lester[i], 2)

					ped.set_ped_combat_ability(lester[i], 2)

					ped.set_ped_combat_movement(lester[i], 2)
					ped.set_ped_into_vehicle(lester[i], lesveh[y], -1)
					if ai.task_vehicle_drive_wander(lester[i], lesveh[y], 180, 262144) then
					system.wait(10)
					end

					vehicle.set_vehicle_doors_locked(lesveh[y], 6)

		
					vehicle.set_vehicle_doors_locked(lesveh[y], 2)
					entity.set_entity_coords_no_offset(lesveh[y], pos)

			

						if attack == 1 then
						ai.task_combat_ped(lester[i], pedp, 0, 16)
						else
						if attack == 2 then
						ai.task_vehicle_follow(lester[i], lesveh[y], pedp, 220, 262144, 25)
						
					end
					end

					streaming.set_model_as_no_longer_needed(vehhash)
		end), type = "action_value_i"}
		features["sendlesterop"].feat.threaded = false
		features["sendlesterop"].feat.max_i = 2
		features["sendlesterop"].feat.min_i = 0
		features["sendlesterop"].feat.value_i = 0
		
	features["sendlesmonster"] = {feat = menu.add_feature("Arenawar Monster Lester", "action_value_i", g.id, function(feat)
					local attack = feat.value_i

					local modd = 1
					local pedp = player.get_player_ped(pid)
					local pos = v3()
					pos = player.get_player_coords(pid)
					pos.x = pos.x + 10
					pos.y = pos.y + 10
					ground, pos.z = gameplay.get_ground_z(pos)

					local model = gameplay.get_hash_key("ig_lestercrest_2")
					streaming.request_model(model)

					while (not streaming.has_model_loaded(model)) do
						system.wait(10)
					end

					local i = #lester + 1
					lester[i] = ped.create_ped(6, model, pos, pos.z, true, false)
					entity.set_entity_god_mode(lester[i], true)
					streaming.set_model_as_no_longer_needed(model)

					local vehhash = gameplay.get_hash_key("monster5")

					streaming.request_model(vehhash)
					while (not streaming.has_model_loaded(vehhash)) do
						system.wait(10)
					end

					local y = #lesveh + 1
					lesveh[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
					vehicle.set_vehicle_mod_kit_type(lesveh[y], 0)
					vehicle.get_vehicle_mod(lesveh[y], 10)
					vehicle.set_vehicle_mod(lesveh[y], 10, 0, false)
					ui.add_blip_for_entity(lesveh[y])
					local blipid = ui.get_blip_from_entity(lesveh[y])
					ui.set_blip_sprite(blipid, 559)
					vehicle.set_vehicle_on_ground_properly(lesveh[y])
					entity.set_entity_god_mode(lesveh[y], true)
					vehicle.set_vehicle_doors_locked(lesveh[y], 5)

					network.request_control_of_entity(lesveh[y])

					ped.set_ped_combat_attributes(lester[i], 46, true)

					ped.set_ped_combat_attributes(lester[i], 52, true)

					ped.set_ped_combat_attributes(lester[i], 1, true)

					ped.set_ped_combat_attributes(lester[i], 2, true)

					ped.set_ped_combat_range(lester[i], 2)

					ped.set_ped_combat_ability(lester[i], 2)

					ped.set_ped_combat_movement(lester[i], 2)
					ped.set_ped_into_vehicle(lester[i], lesveh[y], -1)
					if ai.task_vehicle_drive_wander(lester[i], lesveh[y], 180, 262144) then
					system.wait(10)
					end

					vehicle.set_vehicle_doors_locked(lesveh[y], 6)

		
					vehicle.set_vehicle_doors_locked(lesveh[y], 2)
					entity.set_entity_coords_no_offset(lesveh[y], pos)

			

						if attack == 1 then
						ai.task_combat_ped(lester[i], pedp, 0, 16)
						else
						if attack == 2 then
						ai.task_vehicle_follow(lester[i], lesveh[y], pedp, 220, 262144, 25)
						
					end
					end

					streaming.set_model_as_no_longer_needed(vehhash)
		end), type = "action_value_i"}
		features["sendlesmonster"].feat.threaded = false
		features["sendlesmonster"].feat.max_i = 2
		features["sendlesmonster"].feat.min_i = 0
		features["sendlesmonster"].feat.value_i = 0

	features["sendlestermtk"] = {feat = menu.add_feature("minitank Lester", "action_value_i", g.id, function(feat)
					local attack = feat.value_i
					local follow = feat.value_i
					local pedp = player.get_player_ped(pid)
					local pos = player.get_player_coords(pid)
					pos.x = pos.x + 10
					pos.y = pos.y - 10

					local model = gameplay.get_hash_key("ig_lestercrest_2")
					local vehhash = gameplay.get_hash_key("minitank")
					streaming.request_model(model)

					while (not streaming.has_model_loaded(model)) do
						system.wait(10)
					end

					local i = #lester + 1
					lester[i] = ped.create_ped(6, model, pos, pos.z, true, false)
					entity.set_entity_god_mode(lester[i], true)
					streaming.request_model(vehhash)
					while (not streaming.has_model_loaded(vehhash)) do
					system.wait(10)
					end

					local y = #lesveh + 1
					lesveh[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
					ui.add_blip_for_entity(lesveh[y])
					local blipid = ui.get_blip_from_entity(lesveh[y])
					ui.set_blip_sprite(blipid, 742)
					ped.set_ped_into_vehicle(lester[i], lesveh[y], -1)
					vehicle.set_vehicle_on_ground_properly(lesveh[y])
					entity.set_entity_god_mode(lesveh[y], true)
					vehicle.set_vehicle_doors_locked(lesveh[y], 5)

					vehicle.get_vehicle_mod(lesveh[y], 10)
					vehicle.set_vehicle_mod(lesveh[y], 10, 1, false)
					network.request_control_of_entity(lesveh[y])

					ped.set_ped_combat_attributes(lester[i], 46, true)

					ped.set_ped_combat_attributes(lester[i], 52, true)

					ped.set_ped_combat_attributes(lester[i], 1, true)

					ped.set_ped_combat_attributes(lester[i], 2, true)

					ped.set_ped_combat_range(lester[i], 2)

					ped.set_ped_combat_ability(lester[i], 2)

					ped.set_ped_combat_movement(lester[i], 2)

					if ai.task_vehicle_drive_wander(lester[i], lesveh[y], 180, 262144) then
						return HANDLER_CONTINUE
					end
					

					vehicle.set_vehicle_doors_locked(lesveh[y], 6)

					pos = player.get_player_coords(pid)

					pos.x = pos.x + 8
					pos.y = pos.y + 8
					vehicle.set_vehicle_doors_locked(lesveh[y], 2)
					entity.set_entity_coords_no_offset(lesveh[y], pos)
					vehicle.set_vehicle_on_ground_properly(lesveh[y])

					if attack == 1 then
						ai.task_combat_ped(lester[i], pedp, 0, 16)
						else
						if attack == 2 then
						ai.task_vehicle_follow(lester[i], lesveh[y], pedp, 220, 262144, 25)
						
					end
					end

					streaming.set_model_as_no_longer_needed(vehhash)
					streaming.set_model_as_no_longer_needed(model)
				
	end), type = "action_value_i"}
		features["sendlestermtk"].feat.threaded = false
		features["sendlestermtk"].feat.max_i = 2
		features["sendlestermtk"].feat.min_i = 0
		features["sendlestermtk"].feat.value_i = 0
	
	features["sendlesterapc"] = {feat = menu.add_feature("APC Lester", "action_value_i", g.id, function(feat)
					local attack = feat.value_i
					local follow = feat.value_i
					local pedp = player.get_player_ped(pid)
					local pos = player.get_player_coords(pid)
					pos.x = pos.x + 10
					pos.y = pos.y - 15

					local model = gameplay.get_hash_key("ig_lestercrest_2")
					local vehhash = gameplay.get_hash_key("apc")
					streaming.request_model(model)

					while (not streaming.has_model_loaded(model)) do
						system.wait(10)
					end

					local i = #lester + 1
					lester[i] = ped.create_ped(6, model, pos, pos.z, true, false)
					entity.set_entity_god_mode(lester[i], true)
					streaming.request_model(vehhash)
					while (not streaming.has_model_loaded(vehhash)) do
					system.wait(10)
					end

					local y = #lesveh + 1
					lesveh[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
					ui.add_blip_for_entity(lesveh[y])
					local blipid = ui.get_blip_from_entity(lesveh[y])
					ui.set_blip_sprite(blipid, 558)
					ped.set_ped_into_vehicle(lester[i], lesveh[y], -1)
					vehicle.set_vehicle_on_ground_properly(lesveh[y])
					entity.set_entity_god_mode(lesveh[y], true)
					vehicle.set_vehicle_doors_locked(lesveh[y], 5)

					vehicle.get_vehicle_mod(lesveh[y], 10)
					vehicle.set_vehicle_mod(lesveh[y], 10, 0, false)
					network.request_control_of_entity(lesveh[y])

					ped.set_ped_combat_attributes(lester[i], 46, true)

					ped.set_ped_combat_attributes(lester[i], 52, true)

					ped.set_ped_combat_attributes(lester[i], 1, true)

					ped.set_ped_combat_attributes(lester[i], 2, true)

					ped.set_ped_combat_range(lester[i], 2)

					ped.set_ped_combat_ability(lester[i], 2)

					ped.set_ped_combat_movement(lester[i], 2)

					if ai.task_vehicle_drive_wander(lester[i], lesveh[y], 180, 262144) then
					system.wait(10)
					end
					local i = #lester + 1

					lester[i] = ped.create_ped(6, model, pos, pos.z, true, false)
					entity.set_entity_god_mode(lester[i], true)
					ped.set_ped_combat_attributes(lester[i], 52, true)
					ped.set_ped_combat_attributes(lester[i], 1, true)
					ped.set_ped_combat_attributes(lester[i], 46, true)
					ped.set_ped_combat_attributes(lester[i], 2, true)
					ped.set_ped_combat_range(lester[i], 2)
					ped.set_ped_combat_ability(lester[i], 2)
					ped.set_ped_combat_movement(lester[i], 2)

					ped.set_ped_into_vehicle(lester[i], lesveh[y], 0)

					vehicle.set_vehicle_doors_locked(lesveh[y], 6)

					pos = player.get_player_coords(pid)

					pos.x = pos.x + 8
					pos.y = pos.y + 8
		
					vehicle.set_vehicle_doors_locked(lesveh[y], 2)
					entity.set_entity_coords_no_offset(lesveh[y], pos)
		

						if attack == 1 then
						ai.task_combat_ped(lester[i], pedp, 0, 16)
						else
						if attack == 2 then
						local i = #lester - 1
						ai.task_vehicle_follow(lester[i], lesveh[y], pedp, 220, 262144, 25)
						
					end
					end

					streaming.set_model_as_no_longer_needed(vehhash)
					streaming.set_model_as_no_longer_needed(model)
				
	end), type = "action_value_i"}
		features["sendlesterapc"].feat.threaded = false
		features["sendlesterapc"].feat.max_i = 2
		features["sendlesterapc"].feat.min_i = 0
		features["sendlesterapc"].feat.value_i = 0
	
	features["attachles"] = {feat = menu.add_feature("Attach Lesters onPlayer offset =", "value_i", g.id, function(feat)
					if feat.on then
						local pedd = player.get_player_ped(pid)
						local pos = v3()
						local rot = v3()
						local offset = v3()
						local o = tonumber(feat.value_i)
						local p = o / 10
						local t = o / 50
						offset.x = p
						offset.y = p
						offset.z = 0 / 5

						rot = entity.get_entity_rotation(pedd)


						--rot.z = rot.z + 180

						for i = 1, #lesveh do
							network.request_control_of_entity(lesveh[i])
							entity.attach_entity_to_entity(lesveh[i], pedd, 1356, offset, rot, true, true, true, 0, false)
						end
						if feat.on then
							for i = 1, #lester do
								ai.task_combat_ped(lester[i], pedd, 0, 16)
							end
						end

						return HANDLER_CONTINUE
					end
					if feat.on == false then
						for i = 1, #lesveh do
							entity.detach_entity(lesveh[i])
						end
						return HANDLER_CONTINUE
					end
	end), type = "value_i"}
		features["attachles"].feat.threaded = false
		features["attachles"].feat.max_i = 5000
		features["attachles"].feat.min_i = -5000
		features["attachles"].feat.value_i = -170
		features["attachles"].feat.mod_i = 3
	
	features["attachle2s"] = {feat = menu.add_feature("Attach Lesters offset v2(above) =", "value_i", g.id, function(feat)
					if feat.on then
						local pedd = player.get_player_ped(pid)
						local pos = v3()
						local rot = v3()
						local offset = v3()
						local o = tonumber(feat.value_i)
						local p = o / 10
						local t = o / 2
						offset.x = p
						offset.y = t
						offset.z = 5.0

						rot = entity.get_entity_rotation(pedd)


						rot.z = rot.z + 180

						for i = 1, #lesveh do
							pos = entity.get_entity_coords(lesveh[i])
							network.request_control_of_entity(lesveh[i])
					getz, loz =	gameplay.get_ground_z(pos)
							offset.z = loz + 20		
							entity.attach_entity_to_entity(lesveh[i], pedd, 1356, offset, rot, true, true, true, 0, false)
						end
						if feat.on then
							for i = 1, #lesveh do
								ai.task_combat_ped(lesveh[i], pedd, 0, 16)
							end
						end

						return HANDLER_CONTINUE
					end
					if feat.on == false then
						for i = 1, #lesveh do
							entity.detach_entity(lesveh[i])
						end
						return HANDLER_CONTINUE
					end
	end), type = "value_i"}
		features["attachle2s"].feat.threaded = false
		features["attachle2s"].feat.max_i = 5000
		features["attachle2s"].feat.min_i = -5000
		features["attachle2s"].feat.value_i = 80
		features["attachle2s"].feat.mod_i = 2

	features["dellesters"] = {feat = menu.add_feature("Delete Lesters + vehicles", "action", g.id, function(feat)
					for i = 1, #lester do
					entity.set_entity_coords_no_offset(lester[i], beyond_limits)
						ped.clear_ped_tasks_immediately(lester[i])
						entity.detach_entity(lester[i])

						entity.set_entity_as_no_longer_needed(lester[i])
						entity.delete_entity(lester[i])
					end
					for i = 1, #lesveh do
					entity.set_entity_coords_no_offset(lesveh[i], beyond_limits)
						entity.detach_entity(lesveh[i])
						entity.set_entity_as_no_longer_needed(lesveh[i])
						entity.delete_entity(lesveh[i])
					end
	end), type = "action"}
		features["dellesters"].feat.threaded = false

	features["attach1"] = {feat = menu.add_feature("Attach Players Vehicle Behind v1", "value_i", at.id, function(feat)
            if feat.on then
                local pedd = player.get_player_ped(player.player_id())
                local pos = v3()
                local rot = v3()
                local x = tonumber(feat.value_i)
                local offset = v3()
                offset.x = 0
                offset.y = x
                offset.z = 0
                local pped = player.get_player_ped(pid)
				local i = #attached_plyveh + 1
				
                attached_plyveh[i] = ped.get_vehicle_ped_is_using(pped)
                network.request_control_of_entity(attached_plyveh[i])

                local curveh = ped.get_vehicle_ped_is_using(pedd)

                entity.set_entity_rotation(attached_plyveh[i], entity.get_entity_rotation(curveh))

                rot = entity.get_entity_rotation(pedd)

                network.request_control_of_entity(attached_plyveh[i])
                entity.attach_entity_to_entity(attached_plyveh[i], curveh, 1356, offset, rot, true, true, false, 0, false)
				
			if entity.is_entity_attached(attached_plyveh[i]) == false and feat.on == true then
			end
			return HANDLER_CONTINUE
			
		else
		end
			local veh = player.get_player_vehicle(pid)
			local mveh = player.get_player_vehicle(player.player_id())
			if entity.is_entity_attached(veh) or entity.is_entity_attached(mveh) then
							entity.detach_entity(veh)
							entity.detach_entity(mveh)
						
						return HANDLER_CONTINUE
			end
					    return HANDLER_POP
        		end), type = "value_i"}
	features["attach1"].feat.threaded = false
		features["attach1"].feat.max_i = 1000
		features["attach1"].feat.min_i = -1000
		features["attach1"].feat.value_i = -8
		features["attach1"].feat.mod_i = 1
		
	features["attach"] = {feat = menu.add_feature("Attach Players Vehicle Behind v2", "value_i", at.id, function(feat)
            if feat.on then
                local pedd = player.get_player_ped(player.player_id())
                local pos = v3()
                local rot = v3()
                local x = tonumber(feat.value_i)
                local offset = v3()
                offset.x = 0
                offset.y = x
                offset.z = 0
                local pped = player.get_player_ped(pid)
				local i = #attached_plyveh + 1
				
                attached_plyveh[i] = ped.get_vehicle_ped_is_using(pped)
                network.request_control_of_entity(attached_plyveh[i])

                local curveh = ped.get_vehicle_ped_is_using(pedd)

                entity.set_entity_rotation(attached_plyveh[i], entity.get_entity_rotation(curveh))

                rot = entity.get_entity_rotation(pedd)

                network.request_control_of_entity(attached_plyveh[i])
                entity.attach_entity_to_entity(attached_plyveh[i], curveh, 1356, offset, rot, true, false, false, 0, false)
  
			if entity.is_entity_attached(attached_plyveh[i]) == false and feat.on == true then
			return HANDLER_CONTINUE
			end
		else
			end
		local veh = player.get_player_vehicle(pid)
			local mveh = player.get_player_vehicle(player.player_id())
			if entity.is_entity_attached(veh) or entity.is_entity_attached(mveh) then
							entity.detach_entity(veh)
							entity.detach_entity(mveh)
						
						return HANDLER_CONTINUE
			end
					    return HANDLER_POP
   
	end), type = "value_i"}
	features["attach"].feat.threaded = false
		features["attach"].feat.max_i = 1000
		features["attach"].feat.min_i = -1000
		features["attach"].feat.value_i = -8
		features["attach"].feat.mod_i = 2

	features["Waypoint"] = {feat = menu.add_feature("Set Waypoint On Player", "toggle", f.id, function(feat)
		if feat.on then
			for i=0,31 do
				if i ~= pid and playerFeatures[i].features["Waypoint"].feat then
					playerFeatures[i].features["Waypoint"].feat.on = false
				end
			end
		else
			set_waypoint(nil)
		end
		return HANDLER_POP
	end), type = "toggle", callback = function()
		set_waypoint(player.get_player_coords(pid))
	end}
	features["Waypoint"].feat.threaded = false

	-- local features = {}
	-- features["ceo money"] = {feat = menu.add_feature("ceo 10k money loop", "toggle", f.id, function(feat)
		-- if feat.on then
		
		-- script.trigger_script_event(0xa3b56d30, pid, {player.player_id(), 10000, -81613951, 1, script.get_global_i(1628955 + (1 + (pid * 614)) + 532), script.get_global_i(1651198 + 9), script.get_global_i(1651198 + 10)})
			-- system.wait(30000)
			-- end
		-- return HANDLER_POP
	-- end), type = "toggle", callback = function()
	-- end}
	-- features["ceo money"].feat.threaded = true
	
	features["boostlag"] = {feat = menu.add_feature("Lag Vehicle Boost Refill", "action", k.id, function(feat)
				local plyveh = player.get_player_vehicle(pid)
					network.request_control_of_entity(plyveh)
					vehicle.set_vehicle_rocket_boost_active(plyveh, true)
					vehicle.set_vehicle_rocket_boost_refill_time(plyveh, 999999.999999999999)
		end), type = "action"}
    features["boostlag"].feat.threaded = false
		
	features["boostrefill"] = {feat = menu.add_feature("Fast Vehicle Boost Refill", "action", k.id, function(feat)
		local plyveh = player.get_player_vehicle(pid)
					network.request_control_of_entity(plyveh)
					vehicle.set_vehicle_rocket_boost_refill_time(plyveh, 0.0000010)
		end), type = "action"}
    features["boostrefill"].feat.threaded = false
	
	features["timedexp"] = {feat = menu.add_feature("Set Vehicle Timed Explosion", "action", k.id, function(feat)
	local pos = v3()
	pos = player.get_player_coords(pid)
	local plyveh 
	local pedd = player.get_player_ped(pid)	
	if ped.is_ped_in_any_vehicle(pedd) then
	plyveh = ped.get_vehicle_ped_is_using(pedd)
	network.request_control_of_entity(plyveh)
	vehicle.add_vehicle_phone_explosive_device(plyveh)
	vehicle.set_vehicle_timed_explosion(plyveh, pedd, true)
	audio.play_sound_from_coord(-1, "Explosion_Countdown", pos, "GTAO_FM_Events_Soundset", true, 1000, false)
		end
	end), type = "action"}
    features["timedexp"].feat.threaded = false
		
	features["vehaddexpl"] = {feat = menu.add_feature("Add Explosive Device to Vehicle", "action", k.id, function(feat)
	local pos = v3()
	pos = player.get_player_coords(pid)
	local plyveh 
	local pedd = player.get_player_ped(pid)	
	if ped.is_ped_in_any_vehicle(pedd) then
	plyveh = ped.get_vehicle_ped_is_using(pedd)
	network.request_control_of_entity(plyveh)
	vehicle.add_vehicle_phone_explosive_device(plyveh)
	end
	end), type = "action"}
    features["vehaddexpl"].feat.threaded = false
			
	features["vehdetonate"] = {feat = menu.add_feature("Detonate Vehicle Explosive (named)", "action", k.id, function()
	local plyveh 
	local pedd = player.get_player_ped(pid)	
	if ped.is_ped_in_any_vehicle(pedd) then
	plyveh = ped.get_vehicle_ped_is_using(pedd)
	network.request_control_of_entity(plyveh)
	if vehicle.has_vehicle_phone_explosive_device() then
			vehicle.detonate_vehicle_phone_explosive_device()
			end
end
		end), type = "action"}
    features["vehdetonate"].feat.threaded = false
						
	features["vehspdslow"] = {feat = menu.add_feature("Set Vehicle Max Speed 10", "action", k.id, function()
			playervehspd(pid, 10.0)
		end), type = "action"}
    features["vehspdslow"].feat.threaded = false
			
	features["vehspdfast"] = {feat = menu.add_feature("Reset Vehicle Max Speed", "action", k.id, function()
        playervehspd(pid, 10000.0)
		end), type = "action"}
    features["vehspdfast"].feat.threaded = false
			
	features["boostfuck"] = {feat = menu.add_feature("Fuck Vehicle Boost", "action", k.id, function(feat)
			local plyveh = player.get_player_vehicle(pid)
					network.request_control_of_entity(plyveh)
					vehicle.set_vehicle_rocket_boost_percentage(plyveh, 2000.00)
			

		end), type = "action"}
    features["boostfuck"].feat.threaded = false
					
	features["godvehoff"] = {feat = menu.add_feature("ToggleOFF Player Vehicle God Mode", "toggle", k.id, function(feat)
			if feat.on then	
	local plyped = player.get_player_ped(pid)	
	local plyveh = player.get_player_vehicle(pid)
	network.request_control_of_entity(ped.get_vehicle_ped_is_using(plyped))
	network.request_control_of_entity(plyveh)
	entity.set_entity_god_mode(plyveh, false)

			end
		return HANDLER_CONTINUE
			end),  type = "toggle", callback = function()
	end}
    features["godvehoff"].feat.threaded = false
					
							
	features["godveh"] = {feat = menu.add_feature("ToggleON Player Vehicle God Mode", "toggle", k.id, function(feat)
			if feat.on then	
	local plyped = player.get_player_ped(pid)	
	local plyveh = player.get_player_vehicle(pid)
	network.request_control_of_entity(ped.get_vehicle_ped_is_using(plyped))
	network.request_control_of_entity(plyveh)
	entity.set_entity_god_mode(plyveh, true)
				end
		return HANDLER_CONTINUE

	end),  type = "toggle", callback = function()
	end}
    features["godveh"].feat.threaded = false
					
						
	features["vehicleexplode1"] = {feat = menu.add_feature("VehicleExplodeOnImpact ForceFwdHighSpd", "toggle", k.id, function(feat)
			if feat.on then					
					local plyped = player.get_player_ped(pid)
					local plyveh = player.get_player_vehicle(pid)
						
						if plyveh ~= nil then
									network.request_control_of_entity(plyveh)
									vehicle.set_vehicle_out_of_control(plyveh, false, true)
							end
								network.request_control_of_entity(plyveh)

								vehicle.set_vehicle_rocket_boost_percentage(plyveh, 100)
								vehicle.set_vehicle_rocket_boost_active(plyveh, true)
								vehicle.set_vehicle_forward_speed(plyveh, 200000.00)                                                    
								vehicle.set_vehicle_out_of_control(plyveh, false, true)
					end
			return HANDLER_CONTINUE
		end),  type = "toggle", callback = function()
	end}
    features["vehicleexplode1"].feat.threaded = false
					
					
	features["vehicleexplode"] = {feat = menu.add_feature("Set Vehicle Explode on Impact", "toggle", k.id, function(feat)
			if feat.on then					
					local plyped = player.get_player_ped(pid)
					local plyveh = player.get_player_vehicle(pid)
						
						if plyveh ~= nil then
									network.request_control_of_entity(plyveh)
									vehicle.set_vehicle_out_of_control(plyveh, false, true)
							end
								network.request_control_of_entity(plyveh)

								vehicle.set_vehicle_rocket_boost_percentage(plyveh, 100)
								vehicle.set_vehicle_rocket_boost_active(plyveh, true)                                              
								vehicle.set_vehicle_out_of_control(plyveh, false, true)
								 vehicle.set_vehicle_forward_speed(plyveh, 20000000.0000000)
					end
			return HANDLER_CONTINUE
		end),  type = "toggle", callback = function()
	end}
    features["vehicleexplode"].feat.threaded = false
					
	features["nomissmk2"] = {feat = menu.add_feature("Set MK2 Machineguns Only", "action", k.id, function(feat)
			
					local plyped = player.get_player_ped(pid)
					local plyveh = player.get_player_vehicle(pid)
						
						if plyveh ~= nil then
									network.request_control_of_entity(plyveh)
									
							end
								network.request_control_of_entity(plyveh)
								vehicle.set_vehicle_mod_kit_type(plyveh, 0)
								vehicle.get_vehicle_mod(plyveh, 10)

								vehicle.set_vehicle_mod(plyveh, 10, -1, false)

	end), type = "action"}
    features["nomissmk2"].feat.threaded = false
					
	features["rapidmk2"] = {feat = menu.add_feature("MK2 Rapid fire", "toggle", k.id, function(feat)
			if feat.on then					
					local plyped = player.get_player_ped(pid)
					local plyveh = player.get_player_vehicle(pid)
						
						if plyveh ~= nil then
									network.request_control_of_entity(plyveh)
									
							end
		vehicle.set_vehicle_fixed(plyveh)
	vehicle.set_vehicle_deformation_fixed(plyveh)
					end
			return HANDLER_CONTINUE
		end),  type = "toggle", callback = function()
	end}
    features["rapidmk2"].feat.threaded = false
	
	features["TeleportPlayernext2me"] = {feat = menu.add_feature("Teleport Player+Vehicle Next 2me", "toggle", f.id, function(feat)
			if feat.on then
					local plyveh 
					local pedd = player.get_player_ped(pid)
					local pos = v3()
					pos = entity.get_entity_coords(player.get_player_ped(player.player_id()))
					pos.x = pos.x + 3
				
				if ped.is_ped_in_any_vehicle(pedd) then
						plyveh = ped.get_vehicle_ped_is_using(pedd)
						network.request_control_of_entity(plyveh)
						entity.set_entity_coords_no_offset(plyveh, pos)
						--vehicle.set_vehicle_on_ground_properly(plyveh)
				end
	
				end
			return HANDLER_CONTINUE
		end),  type = "toggle", callback = function()
	end}
    features["TeleportPlayernext2me"].feat.threaded = false
		
	features["TeleportPlayerBeyondLimits"] = {feat = menu.add_feature("Teleport Player+Vehicle Beyond World Limits", "toggle", f.id, function(feat)
			if feat.on then
					local plyveh 
					local pedd = player.get_player_ped(pid)
				
				if ped.is_ped_in_any_vehicle(pedd) then
						plyveh = ped.get_vehicle_ped_is_using(pedd)
						network.request_control_of_entity(plyveh)

						entity.set_entity_coords_no_offset(plyveh, beyond_limits)
				end
	
				end
			return HANDLER_CONTINUE
		end),  type = "toggle", callback = function()
	end}
    features["TeleportPlayerBeyondLimits"].feat.threaded = false
	
	features["Teleport Godmode Death"] = {feat = menu.add_feature("Teleport to Godmode Death", "toggle", m.id, function(feat)
			if feat.on then
					local plyveh 
					local pedd = player.get_player_ped(pid)
						if ped.is_ped_in_any_vehicle(pedd) then
							plyveh = ped.get_vehicle_ped_is_using(pedd)
							network.request_control_of_entity(plyveh)
							entity.set_entity_coords_no_offset(plyveh, goddeath)
						end
				end	
			return HANDLER_CONTINUE
		end),  type = "toggle", callback = function()
	end}
    features["Teleport Godmode Death"].feat.threaded = false
		
	features["Teleport Godmode Death2"] = {feat = menu.add_feature("Teleport to Godmode Death v2", "toggle", m.id, function(feat)
			if feat.on then
				local plyveh 
				local pedd = player.get_player_ped(pid)
			
					if ped.is_ped_in_any_vehicle(pedd) then
						plyveh = ped.get_vehicle_ped_is_using(pedd)
						network.request_control_of_entity(plyveh)
						entity.set_entity_coords_no_offset(plyveh, goddeath2)
						vehicle.set_vehicle_on_ground_properly(plyveh)
					end
				end
			return HANDLER_CONTINUE
		end),  type = "toggle", callback = function()
	end}
    features["Teleport Godmode Death2"].feat.threaded = false
	
	features["Block Passive"] = {feat = menu.add_feature("Block Passive Mode", "action", f.id, function(feat)
			script.trigger_script_event(0x54BAD868, pid, {1, 1})		
		end), type = "action"}
	features["Block Passive"].feat.threaded = false

	features["Unblock Passive"] = {feat = menu.add_feature("Unblock Passive Mode", "action", f.id, function(feat)
			script.trigger_script_event(0x54BAD868, pid, {2, 0})
		end), type = "action"}
    features["Unblock Passive"].feat.threaded = false
	
	features["mark"] = {feat = menu.add_feature("Mark as Modder", "action", f.id, function(feat)
				player.set_player_as_modder(pid, 1)

					player.set_player_as_modder(pid, mod_flag[1])

		end), type = "action"}
    features["mark"].feat.threaded = false
	
	features["unmark"] = {feat = menu.add_feature("UnMark as Modder", "action", f.id, function(feat)
			player.unset_player_as_modder(pid, -1)
		end), type = "action"}
    features["unmark"].feat.threaded = false
	
			features["TERMCEO"] = {feat = menu.add_feature("Terminate CEO", "action", f.id, function(feat)
				local name = player.get_player_name(pid)
    ui.notify_above_map(string.format(name.."\n VIP ACCESS TERMINATED"), "VIP Griefing Event", 202)

    script.trigger_script_event(0x96308401, pid, {1, 1, 6})
    script.trigger_script_event(0x96308401, pid, {0, 1, 6, 0})

    return HANDLER_POP
	end), type = "action"}
    features["TERMCEO"].feat.threaded = false
			
	local r = menu.add_feature("Remove Player ", "parent", f.id)

	features["test_kick00"] = {feat = menu.add_feature("Kick Number from Superkick:", "value_i", r.id, function(feat)
		if feat.on then

		local i = feat.value_i
					

	script.trigger_script_event (superkick[i], pid, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick[i], pid, {0, -1, 0})

		end
		return HANDLER_CONTINUE
		
	end), type = "toggle"}
    features["test_kick00"].feat.threaded = false
		features["test_kick00"].feat.max_i = #superkick
		features["test_kick00"].feat.min_i = 1
		features["test_kick00"].feat.value_i = 1

	
	features["test_kick02"] = {feat = menu.add_feature("Kick Number from Superkick2:", "value_i", r.id, function(feat)
		if feat.on then

		local i = feat.value_i
					

	script.trigger_script_event (superkick2[i], pid, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick2[i], pid, {0, -1, 0})


		end
		return HANDLER_CONTINUE
		
	end), type = "toggle"}
    features["test_kick02"].feat.threaded = false
		features["test_kick02"].feat.max_i = #superkick2
		features["test_kick02"].feat.min_i = 1
		features["test_kick02"].feat.value_i = 1

	
	features["test_kick03"] = {feat = menu.add_feature("Kick Number from Superkick3:", "value_i", r.id, function(feat)
		if feat.on then

		local i = feat.value_i
					

	script.trigger_script_event (superkick3[i], pid, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick3[i], pid, {0, -1, 0})


		end
		return HANDLER_CONTINUE
		
	end), type = "toggle"}
    features["test_kick03"].feat.threaded = false
		features["test_kick03"].feat.max_i = #superkick3
		features["test_kick03"].feat.min_i = 1
		features["test_kick03"].feat.value_i = 1
	
	features["test_kick04"] = {feat = menu.add_feature("Kick Number from Superkick3:", "value_i", r.id, function(feat)
		if feat.on then

		local i = feat.value_i
					

	script.trigger_script_event (superkick4[i], pid, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick4[i], pid, {0, -1, 0})


		end
		return HANDLER_CONTINUE
		
	end), type = "toggle"}
    features["test_kick04"].feat.threaded = false
		features["test_kick04"].feat.max_i = #superkick4
		features["test_kick04"].feat.min_i = 1
		features["test_kick04"].feat.value_i = 1

	
	features["test_kick1"] = {feat = menu.add_feature("Test Kick Events 2.1", "toggle", r.id, function(feat)
		if feat.on then
		for j = 1, #superkick do
					

	script.trigger_script_event (superkick[j], pid, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick[j], pid, {0, -1, 0})

		end
		end
		return HANDLER_CONTINUE
		
	end), type = "toggle"}
    features["test_kick1"].feat.threaded = false
	
	features["test_kick2"] = {feat = menu.add_feature("Test Kick Events 2.0", "toggle", r.id, function(feat)
		if feat.on then

	for i = 1, #superkick2 do
	
	script.trigger_script_event (superkick2[i], pid, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick2[i], pid, {0, -1, 0})
		end
		end
		return HANDLER_CONTINUE
	
	end), type = "toggle"}
    features["test_kick2"].feat.threaded = false
		
	features["scriptkick"] = {feat = menu.add_feature("123 SE Kick", "action", r.id, function(feat)


	for i = 1, #superkick3 do
	
	script.trigger_script_event (superkick3[i], pid, {0, -1, 0, -1, -1})
	script.trigger_script_event (superkick3[i], pid, {0, -1, 0})

		end

	
	end), type = "action"}
    features["scriptkick"].feat.threaded = false
		
	features["scripttestkick"] = {feat = menu.add_feature("Test Global SE Kick", "action", r.id, function(feat)

	script.trigger_script_event(266760875, pid, {pid, script.get_global_i(1628237 + (1 + (pid * 615)) + 536)})
	
	end), type = "action"}
    features["scripttestkick"].feat.threaded = false
	


	playerFeatures[pid] = {feat = f, scid = -1, features = features}

	f.hidden = true
end

--Main loop
local SessionHost = nil
local ScriptHost = nil
local loopFeat = menu.add_feature("Loop", "toggle", 0, function(feat)
	if feat.on then
		local Online = network.is_session_started()
		if not Online then
			SessionHost = nil
			ScriptHost = nil
		end
		local lpid = player.player_id()
		for pid=0,31 do
			local tbl = playerFeatures[pid]
			local f = tbl.feat
			local scid = player.get_player_scid(pid)
			if scid ~= 4294967295 then
				if f.hidden then f.hidden = false end
				local name = player.get_player_name(pid)
				local isYou = lpid == pid
				local tags = {}
				if Online then
					if isYou then
						tags[#tags + 1] = "Y"
					end
					if player.is_player_vehicle_god(pid) then
					tags[#tags + 1] = ".VG."
					vehgod[pid] = "vehicle Godmode"
					
					end
					if player.is_player_god(pid) then
					tags[#tags + 1] = "G"
					end
					if player.is_player_friend(pid) then
						tags[#tags + 1] = "F"
					end
					if player.is_player_modder(pid, -1) then
						tags[#tags + 1] = "M"
					end
					if player.is_player_host(pid) then
						tags[#tags + 1] = "H"
						if SessionHost ~= pid then
							SessionHost = pid
							notify_above_map("The session host is now " .. (isYou and " you " or name) .. "  ")
						end
					end
					if pid == script.get_host_of_this_script() then
						tags[#tags + 1] = "S"
						if ScriptHost ~= pid then
							ScriptHost = pid
							notify_above_map("The script host is now " .. (isYou and " you " or name) .. "  ")
						end
					end
						if  not player.is_player_modder(pid, -1) then
						if player.is_player_spectating(pid) and player.is_player_playing(pid) and interior.get_interior_from_entity(player.get_player_ped(pid)) == 0 then
						tags[#tags + 1] = ".SPEC."
						notify_above_map("Modded Specate Detected from " .. (isYou and "you " or name) .. " ")
						player.set_player_as_modder(pid, mod_flag[3])
						end
					end
					if tbl.scid ~= scid then
						for cf_name,cf in pairs(tbl.features) do
							if cf.type == "toggle" and cf.feat.on then
								cf.feat.on = false
							end
						end
						tbl.scid = scid
						if not isYou then
							--TODO: Modder shit
						end
					end
				end
				if #tags > 0 then
					name = name .. " [" .. table.concat(tags) .. "]"
				end
				if f.name ~= name then f.name = name end
				for cf_name,cf in pairs(tbl.features) do
					if (cf.type ~= "toggle" or cf.feat.on) and cf.callback then
						local status, err = pcall(cf.callback)
						if not status then
							notify_above_map("Error running feature " .. cf_name .. " on pid " .. pid)
							print(err)
						end
					end
				end
			else
				if not f.hidden then
					f.hidden = true
					for cf_name,cf in pairs(tbl.features) do
						if cf.type == "toggle" and cf.feat.on then
							cf.feat.on = false
						end
					end
				end
			end
		end
		return HANDLER_CONTINUE
	end
	return HANDLER_POP
end)
loopFeat.hidden = true
loopFeat.threaded = false
loopFeat.on = true
flag_setup()
Moist_WaveMod()
offset_setup()
notif(string.format("Hold Left CTRL Press X Keys\nToggle Lifeless Ragdoll ON"), "Self Functions", 024)
notif(string.format("Hold Left CTRL Press R Keys\nToggle MK2 Rapid Fire ON"), "Self Functions", 021)
notif(string.format("Hold Left CTRL Press O Keys\nToggle OSD options"), "OSD Options", 066)