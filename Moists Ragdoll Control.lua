
function Moists_RagdollControl()
-- bool SET_PED_TO_RAGDOLL(Ped ped, int time1, int time2, int ragdollType, bool p4, bool p5, bool p6) // 0xAE99FB955581844A 0x83CB5052 b323

-- time1- Time Ped is in ragdoll mode(ms)

-- time2- Unknown time, in milliseconds

-- ragdollType-
-- 0 : Normal ragdoll
-- 1 : Falls with stiff legs/body
-- 2 : Narrow leg stumble(may not fall)
-- 3 : Wide leg stumble(may not fall)

-- p4, p5, p6- No idea. In R*'s scripts they are usually either "true, true, false" or "false, false, false".

local Ragdoll_Sel = 0

local ragdolltyp = {{"Normal ragdoll", 0},{"Falls with stiff legs/body", 1},{"Narrow leg stumble(may not fall)", 2},{"Wide leg stumble(may not fall)", 3}}

local Ragdoll_Control = menu.add_feature("Moists RagDoll Control", "parent", 0)


Ragdoll_set = menu.add_feature("Set Ragdoll Type", "action_value_i", Ragdoll_Control.id, function(feat)
	
	Ragdoll_Sel = ragdolltyp[feat.value_i][2]

	ui.notify_above_map("Ragdoll Type Set to: " .. ragdolltyp[feat.value_i][2].."\n("..ragdolltyp[feat.value_i][1]..")", "Moists Ragdoll Control", 140)
end)
Ragdoll_set.max_i = #ragdolltyp
Ragdoll_set.min_i = 1
Ragdoll_set.value_i = 1



function Ragdoll0_3(feat)
	
	local Number1 = 1900
	
	local Number2 = 2000
	
	local Number3 = 2000
	
	local Number4 = 3000
	
	local Number5 = 99999
	
	local PlayerP = player.player_id()
	
	local pedd = player.get_player_ped(PlayerP)
	ped.set_ped_to_ragdoll(pedd, Number1, Number5, 0)
	ped.set_ped_to_ragdoll(pedd, Number5, Number5, Ragdoll_Sel)
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
	ped.set_ped_to_ragdoll(pedd, Number3, Number4, Ragdoll_Sel)
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
		ped.set_ped_to_ragdoll(pedd, Number3, Number4, Ragdoll_Sel)
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
		ped.set_ped_to_ragdoll(pedd, Number1, Number2, Ragdoll_Sel)
		system.wait(100)
		entity.apply_force_to_entity(pedd, 1, 2,0, 0.8, 3, 2.1, 10.3, true, false)
		system.wait(100)
		ped.set_ped_to_ragdoll(pedd, Number3, Number4, Ragdoll_Sel)
		system.wait(100)
		entity.apply_force_to_entity(pedd, 1, 2,0, 0.8, 3, 2.1, 10.3, true, false)
		system.wait(100)
		ped.set_ped_to_ragdoll(pedd, Number4, Number5, Ragdoll_Sel)
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
		ped.set_ped_to_ragdoll(pedd, Number1, Number2, Ragdoll_Sel)
		--system.wait(100)
		--entity.apply_force_to_entity(pedd, 4, 2,0, 0.8, 3, 2.1, 10.3, true, false)
		--system.wait(100)
		ped.set_ped_to_ragdoll(pedd, Number3, Number4, Ragdoll_Sel)
		--system.wait(100)
		--entity.apply_force_to_entity(pedd, 4, 2,0, 0.8, 3, 2.1, 10.3, true, false)
		--system.wait(100)
		ped.set_ped_to_ragdoll(pedd, Number4, Number5, Ragdoll_Sel)
		--system.wait(100)
		-- end
		return HANDLER_CONTINUE
	end	
	return HANDLER_POP
end


ragdoll_key = menu.add_feature("Ragdoll HotKey", "toggle", Ragdoll_Control.id, function(feat)
	if feat.on then
		
		local key = MenuKey()
		key:push_str("LCONTROL")
		key:push_str("x")
		if key:is_down() then
			rag_self.on = not rag_self.on
			ui.notify_above_map(string.format("Switching %s\n%s Ragdoll on your ped", rag_self.on and "ON" or "OFF", rag_self.on and "Setting" or "Ending"), "Moists Ragdoll Control", 140)
			system.wait(1200)
		end
	end
	return HANDLER_CONTINUE
end)
ragdoll_key.on = true 



local set_rag_self = menu.add_feature("Set Self to Ragdoll", "action", Ragdoll_Control.id, RagdollButton)

local tw2rag_self = menu.add_feature("Set Ragdoll", "toggle", Ragdoll_Control.id, Ragdolltoggle1)

local force_rag_self = menu.add_feature("Set Ragdoll Apply force", "action", Ragdoll_Control.id, Ragdoll0_3)

local twrag_self = menu.add_feature("Twitching Ragdoll", "toggle", Ragdoll_Control.id, RagdollButtontoggle)

local tw1rag_self = menu.add_feature("Twitching Ragdoll v1", "toggle", Ragdoll_Control.id, Ragdolltoggle)

rag_self = menu.add_feature("Lifeless Ragdoll(Hotkey Preset)", "toggle", Ragdoll_Control.id, function(feat)
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

end
Moists_RagdollControl()