 spawner = menu.add_feature("Moists Entity POS Control", "parent", 0)
 aimd = {}
 aimed = {}
 aimd.aimed = {}

--aimed.pos[2].x
--#aimed.pos

aimed.pos = {}
-- {["x"] = } {["y"] = } {["z"] = }

 offset_data = v3()
 rot_data = v3()
 pos_data = v3()
 pos = v3()
 rot = v3()

 offset_data_x = nil
 offset_data_y = nil
 offset_data_z = nil
 rot_data_x = nil
 rot_data_y = nil
 rot_data_z = nil
 local pos_data_x
 local pos_data_y
 local pos_data_z
 local active_object










local aim_control = menu.add_feature("Get Aim entity (LTrigger+PS:X)", "toggle", spawner.id, function(feat)

	if feat.on then
	
      if player.is_player_free_aiming(player.player_id()) and controls.is_control_pressed(1,21) then
	
		aimd.aimed[#aimd.aimed + 1] = player.get_entity_player_is_aiming_at(player.player_id())
		active_objec.max_i = #aimd.aimed
		local pos = v3()
		local i = #aimd.aimed
		local ent = aimd.aimed[i]
		aimed.pos[i] = entity.get_entity_coords(ent)
		
		
		

	
end
		return HANDLER_CONTINUE
	end

	return HANDLER_POP

end)
aim_control.on = on


local id

active_objec_on = menu.add_feature("Update Collected Aim Entity", "toggle", spawner.id, function(feat)

 if feat.on then 
	local i = tonumber(id)
 	entity.set_entity_coords_no_offset(aimd.aimed[i], aimed.pos[i])
	
	--entity.set_entity_rotation(aimd.aimed[i], rot_data)

	return HANDLER_CONTINUE
 end
 return HANDLER_POP
end)
active_objec_on.on = false


active_objec = menu.add_feature("Select Collected Aim Entity", "action_value_i", spawner.id, function(feat)
	local i = feat.value_i
	id = i



end)
active_objec.max_i = #aimd.aimed
active_objec.min_i = 1
active_objec.value_i = 1


cprecision= menu.add_feature("Precision Positioning", "toggle", spawner.id, function(feat) end)
cprecision.threaded = false


attcoll = menu.add_feature("Attach With Collision", "toggle", spawner.id, function(feat) end)
attcoll.threaded = false

coffxmod =  menu.add_feature("Change step 1 = 1/10 (0.01)", "action_value_i", spawner.id, function(f)
	pos01x.mod_i = f.value_i
	pos01y.mod_i = f.value_i
	pos01z.mod_i = f.value_i
	posr01x.mod_i = f.value_i
	posr01y.mod_i = f.value_i
	posr01z.mod_i = f.value_i
end)
coffxmod.max_i = 1000
coffxmod.min_i = 1

pos01x =  menu.add_feature("set pos x", "action_value_i", spawner.id, function(feat)
	if cprecision.on then
	local i = tonumber(id)		
	local x = tonumber(aimed.pos[i].x)

	local y = feat.value_i / 1000	

				
	aimed.pos[i].x = tonumber(x + y)
		

		
else
	local x = tonumber(aimed.pos[i].x)
	local y = feat.value_i

				
	aimed.pos[i].x = tonumber(x + y)
		
	end
end)
pos01x.max_i = 1000
pos01x.min_i = -1000
pos01x.value_i = 0
pos01x.mod_i = 1

pos01y = menu.add_feature("set pos y", "action_value_i", spawner.id, function(feat)
if cprecision.on then
	local i = tonumber(id)		
	local x = tonumber(aimed.pos[i].y)

	local y = feat.value_i / 1000	

				
	aimed.pos[i].y = tonumber(x + y)
		

		
else
	local x = tonumber(aimed.pos[i].y)
	local y = feat.value_i

				
	aimed.pos[i].y = tonumber(x + y)
		
	end
end)
pos01y.max_i = 1000
pos01y.min_i = -1000
pos01y.value_i = 0
pos01y.mod_i = 1

pos01z = menu.add_feature("set pos z", "action_value_i", spawner.id, function(feat)
if cprecision.on then
	local i = tonumber(id)		
	local x = tonumber(aimed.pos[i].z)

	local y = feat.value_i / 1000	

				
	aimed.pos[i].z = tonumber(x + y)
		

		
else
	local x = tonumber(aimed.pos[i].z)
	local y = feat.value_i

				
	aimed.pos[i].z = tonumber(x + y)
		
	end
end)
pos01z.max_i = 1000
pos01z.min_i = -1000
pos01z.value_i = 0
pos01z.mod_i = 1

posr01x =  menu.add_feature("set Rotation x", "autoaction_value_i", spawner.id, function(feat)
	rot_data_x = tonumber(feat.value_i)
end)
posr01x.max_i = 300000
posr01x.min_i = -300000
posr01x.value_i = 0
posr01x.mod_i = 1

posr01y = menu.add_feature("set Rotation y", "autoaction_value_i", spawner.id, function(feat)
	rot_data_y = tonumber(feat.value_i)
end)
posr01y.max_i = 300000
posr01y.min_i = -300000
posr01y.value_i = 0
posr01y.mod_i = 1

posr01z = menu.add_feature("set Rotation z", "autoaction_value_i", spawner.id, function(feat)
	rot_data_z = tonumber(feat.value_i)
end)
posr01z.max_i = 300000
posr01z.min_i = -300000
posr01z.value_i = 0
posr01z.mod_i = 1
