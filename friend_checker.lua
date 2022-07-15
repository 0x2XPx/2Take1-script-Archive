
function friends_check()
	for i=0,network.get_friend_count()-1 do
		
		local friendName = network.get_friend_index_name(i)
		
		local friendScid = network.get_friend_scid(friendName)
		
		local friendOnline = network.is_friend_index_online(i)
		
		local friendMplay = network.is_friend_in_multiplayer(friendName)
		print(string.format("Friend index %s %s (%s) is %s", i, friendName, friendScid, friendOnline and "online" or "offline"))
		if friendOnline then
			if friendMplay then
				ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName .. "~h~~u~\nis Playing Online", "~u~Network ~u~Presence", 172)
				else
				ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName , "~u~Network Presence", 47)
			end
			system.wait(100)
		end
	end
end


function online_friends_check_all(feat)
	if feat.on then
	local delay_time = 60000 * feat.value_i
for i=0,network.get_friend_count()-1 do
		
		local friendName = network.get_friend_index_name(i)
		
		local friendScid = network.get_friend_scid(friendName)
		
		local friendOnline = network.is_friend_index_online(i)
		
		local friendMplay = network.is_friend_in_multiplayer(friendName)
		print(string.format("Friend index %s %s (%s) is %s", i, friendName, friendScid, friendOnline and "online" or "offline"))
		if friendOnline then
			if friendMplay then
				ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName .. "~h~~u~\nis Playing Online", "~u~Network ~u~Presence", 172)
				else
				ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName , "~u~Network Presence", 47)
			end
			system.wait(200)
		end
	end

		system.wait(delay_time)
		return HANDLER_CONTINUE
	end
end

function main()

local parent = menu.add_feature("Moists Online Friends", "parent", 0)

local friendsonline = menu.add_feature("friends online?", "action", parent.id, friends_check)

local friends_online = menu.add_feature("friend's online Check every Mins:", "value_i", parent.id, function(feat)
		if feat.on then
	local delay_time = 60000 * feat.value_i
for i=0,network.get_friend_count()-1 do
		
		local friendName = network.get_friend_index_name(i)
		
		local friendScid = network.get_friend_scid(friendName)
		
		local friendOnline = network.is_friend_index_online(i)
		
		local friendMplay = network.is_friend_in_multiplayer(friendName)
		print(string.format("Friend index %s %s (%s) is %s", i, friendName, friendScid, friendOnline and "online" or "offline"))
		if friendOnline then
			if friendMplay then
				ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName .. "~h~~u~\nis Playing Online", "~u~Network ~u~Presence", 172)
				else
				ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName , "~u~Network Presence", 47)
			end
			system.wait(200)
		end
	end

		system.wait(delay_time)
		return HANDLER_CONTINUE
		end
		return HANDLER_POP
end)
friends_online.max_i = 5
friends_online.min_i = 1
friends_online.value_i = 1


end
main()
