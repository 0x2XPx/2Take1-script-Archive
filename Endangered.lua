local main = menu.add_feature("Endangered", "parent", 0)

local MyId = player.player_id
local getPed = player.get_player_ped
local function own_ped()
    return getPed(MyId())
end

local function ValidScid(scid)
    return scid ~= -1 and scid ~= 4294967295
end

local exclude_friends = true
local function valid_check(id)
  if player.is_player_valid(id) then
    local scid = player.get_player_scid(id)
    if scid ~= 4294967295 and (exclude_friends and not player.is_player_friend(id) or not exclude_friends) then
      return scid
    end
  end
  return -1
end

local getVeh = ped.get_vehicle_ped_is_using
local function MyVeh(ped)
    return getVeh(own_ped())
end

local notify = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is aiming at you :|", "Gilbert", 133)
				end
			end
		end 
	end
end

local Explode = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Got Exploded :|", "Gilbert", 2)
				end
			end
		end 
	end
end

local Ragdoll = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					fire.add_explosion(player.get_player_coords(pid), 70, true, false, 0, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Ragdolled :|", "Gilbert", 3)
				end
			end
		end 
	end
end

--[[local shake = function(aim)
	while aim.on do 
		system.wait(25)
		local own_ped = player.get_player_ped(player.player_id())
		for pid = 0, 31 do
			if ValidScid ~= -1 then 
				if player.get_entity_player_is_aiming_at(pid) == own_ped then
					fire.add_explosion(player.get_player_coords(pid), 8, false, true, 25, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Shook :|", "Gilbert", 4)
				end
			end
		end 
	end
end]]

local kick = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				while player.get_entity_player_is_aiming_at(pid) == own_ped() do
					system.wait(25)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Kicked :|", "Gilbert", 5)
					script.trigger_script_event(-85635367, pid, {28, -1, -1})
					script.trigger_script_event(-887834944, pid, {4144,-34809,58100,64826,47559,12787})	
					script.trigger_script_event(-889120084, pid, {28, -1, -1})	
					script.trigger_script_event(1189794053, pid, {28, -1, -1})	
					script.trigger_script_event(1310884765, pid, {28, -1, -1})
					script.trigger_script_event(1979460190, pid, {-1, 0})
					script.trigger_script_event(2068861029, pid, {-1000000, -10000000, -100000000, -100000000, -100000000})
					script.trigger_script_event(266760875, pid, {-1, 0})
					script.trigger_script_event(340154634, pid, {28, -1, -1})
					script.trigger_script_event(442672710, pid, {28, -1, -1})
					script.trigger_script_event(493760552, pid, {28, -1, -1})
					script.trigger_script_event(544829784, pid, {28, -1, -1})
					script.trigger_script_event(677839212, pid, {-1000000, -10000000, -100000000, -100000000, -100000000})
					script.trigger_script_event(848786118, pid, {-85547,75122,30768,-35578,-79041,1007})
					script.trigger_script_event(911331561, pid, {-1, 6, -1, -1, 6, -1, 6, -1, -10000, 0})
					script.trigger_script_event(915906776, pid, {28, -1, -1})
					script.trigger_script_event(917314517, pid, {28, -1, -1})
					script.trigger_script_event(972571707, pid, {28, -1, -1})
					script.trigger_script_event(992790930, pid, {-1, 0})
					script.trigger_script_event(-1169499038, pid, {-1, 10178, 0, 48, 0, 0, 0, 0, 0, 0})
					script.trigger_script_event(2102749046, pid, {28, -1, -1})
				end
			end
		end 
	end
end

--[[local freeze = function(aim)
	while aim.on do 
		system.wait(25)
		local own_ped = player.get_player_ped(player.player_id())
		for pid = 0, 31 do
			if ValidScid ~= -1 then 
				while player.get_entity_player_is_aiming_at(pid) == own_ped do
					system.wait(25)
					ped.clear_ped_tasks_immediately(pid)
					entity.freeze_entity(pid, true)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Has Been Frozen :|", "Gilbert", 6)
				end
			end
		end 
	end
end]]

local Anonymous = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					punish = math.random(1, 5)
					if punish == 1 then
						fire.add_explosion(player.get_player_coords(pid), 8, true, false, 0, pid)
						ui.notify_above_map("" ..player.get_player_name(pid).. " Got Exploded :|", "Gilbert", 2)
						elseif punish == 2 then 
						fire.add_explosion(player.get_player_coords(pid), 70, true, false, 0, pid)
						ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Ragdolled :|", "Gilbert", 3)
						elseif punish == 3 then
						fire.add_explosion(player.get_player_coords(pid), -1, false, true, 10, pid)
						ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Shook :|", "Gilbert", 4)
						elseif punish == 4 then 
						ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Kicked :|", "Gilbert", 5)
						script.trigger_script_event(-85635367, pid, {28, -1, -1})
						script.trigger_script_event(-887834944, pid, {4144,-34809,58100,64826,47559,12787})	
						script.trigger_script_event(-889120084, pid, {28, -1, -1})	
						script.trigger_script_event(1189794053, pid, {28, -1, -1})	
						script.trigger_script_event(1310884765, pid, {28, -1, -1})
						script.trigger_script_event(1979460190, pid, {-1, 0})
						script.trigger_script_event(2068861029, pid, {-1000000, -10000000, -100000000, -100000000, -100000000})
						script.trigger_script_event(266760875, pid, {-1, 0})
						script.trigger_script_event(340154634, pid, {28, -1, -1})
						script.trigger_script_event(442672710, pid, {28, -1, -1})
						script.trigger_script_event(493760552, pid, {28, -1, -1})
						script.trigger_script_event(544829784, pid, {28, -1, -1})
						script.trigger_script_event(677839212, pid, {-1000000, -10000000, -100000000, -100000000, -100000000})
						script.trigger_script_event(848786118, pid, {-85547,75122,30768,-35578,-79041,1007})
						script.trigger_script_event(911331561, pid, {-1, 6, -1, -1, 6, -1, 6, -1, -10000, 0})
						script.trigger_script_event(915906776, pid, {28, -1, -1})
						script.trigger_script_event(917314517, pid, {28, -1, -1})
						script.trigger_script_event(972571707, pid, {28, -1, -1})
						script.trigger_script_event(992790930, pid, {-1, 0})
						script.trigger_script_event(-1169499038, pid, {-1, 10178, 0, 48, 0, 0, 0, 0, 0, 0})
						script.trigger_script_event(2102749046, pid, {28, -1, -1})
						elseif punish == 5 then 
						fire.add_explosion(player.get_player_coords(pid), 3, true, false, 1, pid)
						ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Mollied :|", "Gilbert", 6)
						elseif punish == 6 then 
						fire.add_explosion(player.get_player_coords(pid), 13, true, false, 1, pid)
						ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Watererd :|", "Gilbert", 7)
						elseif punish == 7 then 
						fire.add_explosion(player.get_player_coords(pid), 23, true, false, 1, pid)
						ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Extinguished :|", "Gilbert", 9)
						elseif punish == 8 then 
						fire.add_explosion(player.get_player_coords(pid), 38, true, false, 1, pid)
						ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Fireworked :|", "Gilbert", 11)
						elseif punish == 9 then 
						fire.add_explosion(player.get_player_coords(pid), 63, true, false, 1, pid)
						ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Mortared :|", "Gilbert", 14)
					end
				end
			end
		end
	end
end



local molly = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then 
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					fire.add_explosion(player.get_player_coords(pid), 3, true, false, 1, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Mollied :|", "Gilbert", 6)
				end
			end
		end 
	end
end

local water = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					fire.add_explosion(player.get_player_coords(pid), 13, true, false, 1, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Watererd :|", "Gilbert", 7)
				end
			end
		end 
	end
end

local exting = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					fire.add_explosion(player.get_player_coords(pid), 23, true, false, 1, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Extinguished :|", "Gilbert", 9)
				end
			end
		end 
	end
end


local firework = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					fire.add_explosion(player.get_player_coords(pid), 38, true, false, 1, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Fireworked :|", "Gilbert", 11)
				end
			end
		end 
	end
end


local mortar = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					fire.add_explosion(player.get_player_coords(pid), 63, true, false, 1, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Mortared :|", "Gilbert", 14)
				end
			end
		end 
	end
end

local cluster = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					fire.add_explosion(player.get_player_coords(pid), 47, true, false, 1, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Mortared :|", "Gilbert", 14)
				end
			end
		end 
	end
end



local host_check = function()
	if ValidScid(scid) ~= -1 then
		local host = player.get_host()
		local name = player.get_player_name(player.get_host())
		ui.notify_above_map("" ..player.get_player_name(host).. " Is The Current Host :|", "Gilbert", 16)
	end
end 


local host = menu.add_feature("Host Shit", "parent", main.id)
menu.add_feature("Host Check?", "action", host.id, host_check)


menu.add_feature("Steal Host", "toggle", host.id, function (f)
	while f.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				local names = player.get_player_name(player.get_host())
				local host = player.get_host()
				if host ~= player.player_id() and player.get_player_scid(host) ~= 4294967295 then
				--ui.notify_above_map("Attempting to Steal Host From: " ..names.. "", "Gilbert" , 173)
				script.trigger_script_event(-85635367, host, {28, -1, -1})
				script.trigger_script_event(-887834944, host, {4144,-34809,58100,64826,47559,12787})	
				script.trigger_script_event(-889120084, host, {28, -1, -1})	
				script.trigger_script_event(1189794053, host, {28, -1, -1})	
				script.trigger_script_event(1310884765, host, {28, -1, -1})	
				script.trigger_script_event(1451659275, host, {-1, 6, -1, -1, 6, -1, 6, -1, -10000, 0})	
				script.trigger_script_event(1706248285, host, {-1, 0})	
				script.trigger_script_event(1778035417, host, {28, -1, -1})
				script.trigger_script_event(1846608629, host, {-1, 1, -1, -1, 1, -1, 1, -1, -10000, 0})
				script.trigger_script_event(1979460190, host, {-1, 0})
				script.trigger_script_event(2068861029, host, {-1000000, -10000000, -100000000, -100000000, -100000000})
				script.trigger_script_event(266760875, host, {-1, 0})
				script.trigger_script_event(340154634, host, {28, -1, -1})
				script.trigger_script_event(442672710, host, {28, -1, -1})
				script.trigger_script_event(493760552, host, {28, -1, -1})
				script.trigger_script_event(544829784, host, {28, -1, -1})
				script.trigger_script_event(677839212, host, {-1000000, -10000000, -100000000, -100000000, -100000000})
				script.trigger_script_event(848786118, host, {-85547,75122,30768,-35578,-79041,1007})
				script.trigger_script_event(911331561, host, {-1, 6, -1, -1, 6, -1, 6, -1, -10000, 0})
				script.trigger_script_event(915906776, host, {28, -1, -1})
				script.trigger_script_event(917314517, host, {28, -1, -1})
				script.trigger_script_event(972571707, host, {28, -1, -1})
				script.trigger_script_event(992790930, host, {-1, 0})
				script.trigger_script_event(-1169499038, host, {-1, 10178, 0, 48, 0, 0, 0, 0, 0, 0})
				script.trigger_script_event(2102749046, host, {28, -1, -1})
				script.trigger_script_event(285955867, host, {28, -1, -1})
			end
		end
	end	
end
end)

local lobby = menu.add_feature("Online Session", "parent", main.id)

local function hostkickall()
    local myself = player.player_id()
    if network.network_is_host() then
        for i = 0, 32 do
            if i ~= myself then
              network.network_session_kick_player(i)
            end
        end
    else            
        ui.notify_above_map("You are not Session-Host!", "Gilbert", 83)
    end
end

local hostkickall = menu.add_feature("Host Kick All", "action", lobby.id, function(feat)
hostkickall()

return HANDLER_POP
end)

local funny =  menu.add_player_feature("Funny Box", "parent", 0, function(feat, pid)
end).id

local modders =  menu.add_player_feature("Modder Detection", "parent", funny, function(feat, pid)
end).id

local unmark_modder = menu.add_player_feature("Unmark As Modder", "toggle", modders, function(prots, pid)
	while prots.on do 
		system.wait(25)
		player.unset_player_as_modder(pid, -1)
	end
end)


local hiro = function(aim)
	while aim.on do 
		system.wait(25)
		for pid = 0, 31 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
				if player.get_entity_player_is_aiming_at(pid) == own_ped() then
					for x = 35, 0, -5 do
					system.wait(30)
					local pos = player.get_player_coords(player.player_id())
					pos.z = pos.z + x
					fire.add_explosion(pos, 8, true, false, 0, pid)
					ui.notify_above_map("" ..player.get_player_name(pid).. " Is Being Hiroshima'd :|", "Gilbert", 14)
					end
				end
			end
		end 
	end
end




local Protections = menu.add_feature("Aim Protections", "parent", main.id)
menu.add_feature("Enable Aim Protections", "toggle", Protections.id, notify)
menu.add_feature("------------------------", "action", Protections.id)
menu.add_feature("Anonymous Punishment", "toggle", Protections.id, Anonymous)
menu.add_feature("Hiroshima Meatball", "toggle", Protections.id, hiro)
menu.add_feature("Explode", "toggle", Protections.id, Explode)
menu.add_feature("Molotov", "toggle", Protections.id, molly)
menu.add_feature("Water", "toggle", Protections.id, water)
menu.add_feature("Mortar Sound", "toggle", Protections.id, mortar)
menu.add_feature("Cluster", "toggle", Protections.id, cluster)
menu.add_feature("Firework", "toggle", Protections.id, firework)
menu.add_feature("Extinguisher (Annoying)", "toggle", Protections.id, exting)
menu.add_feature("Ragdoll", "toggle", Protections.id, Ragdoll)
--menu.add_feature("Camera Shake", "toggle", Protections.id, shake)
--menu.add_feature("Freeze", "toggle", Protections.id, freeze)
menu.add_feature("Kick", "toggle", Protections.id, kick)

local Cage = menu.add_player_feature("Cages", "parent", funny).id


menu.add_player_feature("Stunt Tube Cage", "action", Cage, function(playerfeat, pid)
local pos1 = player.get_player_coords(pid)
pos1.y = pos1.y - 1

local cageobjecthash = gameplay.get_hash_key("stt_prop_stunt_tube_s") 
local cageobject = object.create_object(cageobjecthash, pos1, true, false)

local rot = entity.get_entity_rotation(cageobject)
rot.y = 90
entity.set_entity_rotation(cageobject, rot)

ui.notify_above_map("Spawned Cage on PID: "..pid, "Objects", 23)
end)


menu.add_player_feature("Invisible Stunt Tube Cage", "action", Cage, function(playerfeat, pid)
local pos = v3()

local pos1 = player.get_player_coords(pid)
pos1.y = pos1.y - 1

local cageobjecthash = gameplay.get_hash_key("stt_prop_stunt_tube_s") 
local cageobject = object.create_object(cageobjecthash, pos1, true, false)

local rot = entity.get_entity_rotation(cageobject)
rot.y = 90
entity.set_entity_rotation(cageobject, rot)

entity.set_entity_visible(cageobject, false)

ui.notify_above_map("Spawned Invisible Cage on PID: "..pid, "Objects", 23)
end)


menu.add_player_feature("Paragon Cage", "action", Cage, function(playerfeat, pid)
local pos = v3()

local pos1 = player.get_player_coords(pid)
pos1.z = pos1.z + 0.50

local cageobjecthash = gameplay.get_hash_key("prop_feeder1_cr") 
local cageobject = object.create_object(cageobjecthash, pos1, true, false)

local rot = entity.get_entity_rotation(cageobject)

ui.notify_above_map("Spawned Paragon Cage on PID: "..pid, "Objects", 23)
end)

menu.add_player_feature("Invisible Paragon Cage", "action", Cage, function(playerfeat, pid)
local pos1 = player.get_player_coords(pid)
pos1.z = pos1.z + 0.50

local cageobjecthash = gameplay.get_hash_key("prop_feeder1_cr") 
local cageobject = object.create_object(cageobjecthash, pos1, true, false)

local rot = entity.get_entity_rotation(cageobject)

entity.set_entity_visible(cageobject, false)

ui.notify_above_map("Spawned Invisible Paragon Cage on PID: "..pid, "Objects", 23)
end)

local misc = menu.add_feature("Miscellaneous", "parent", main.id).id
    menu.add_feature("Crash Yourself", "action", misc, function ()
        os.execute("taskkill /F /IM GTA5.exe")
        while 1 do end
end)

local sms = menu.add_player_feature("SMS Shit", "parent", funny).id

local custom_send = menu.add_player_feature("Send Custom SMS", "action", sms, function(f, pid)
	local custom, SC = input.get("Enter Custom SMS", "", 128, 0)
		while custom == 1 do
        system.yield(0)
         	custom, SC = input.get("Enter Custom SMS", "", 128, 0)
        end
         	 if custom == 2 then
           	 return HANDLER_POP
             end
        player.send_player_sms(pid, SC)
end)




local presets0 = menu.add_player_feature("Presets", "parent", sms, function(feat, pid)
end).id

local presets = menu.add_player_feature("Racist Presets", "parent", sms, function(feat, pid)
end).id

local presets1 = menu.add_player_feature("Offensive Presets", "parent", sms, function(feat, pid)
end).id

local presets2 = menu.add_player_feature("Sexual Presets", "parent", sms, function(feat, pid)
end).id

local presets3 = menu.add_player_feature("George Floyd Presets", "parent", sms, function(feat, pid)
end).id

menu.add_player_feature("SMS Spam Nigger", "toggle", presets, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "Nigger")
end
end)

menu.add_player_feature("SMS Spam fuck your family one by one", "toggle", presets1, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "i'll fuck your family one by one, the god that you believe in and especially your mother (the absolute greek insult)")
end
end)

menu.add_player_feature("SMS Spam Some Weird Shit", "toggle", presets2, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "My cock is throbbing and i want to slap it on your pussy")
end
end)

menu.add_player_feature("SMS Spam I Cant Breathe", "toggle", presets3, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "I Cant Breathe")
end
end)

menu.add_player_feature("SMS Spam haha i cant breathe", "toggle", presets0, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "haha i cant breathe")
end
end)

menu.add_player_feature("SMS Spam You're Black", "toggle", presets0, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "You're Black")
end
end)

menu.add_player_feature("SMS Spam Your Pussy Smells Like Fish", "toggle", presets0, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "Your Pussy Smells Like Fish)")
end
end)

menu.add_player_feature("SMS Spam I Have the Fattest Cock on this planet", "toggle", presets0, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "I Have the Fattest Cock on this planet")
end
end)

 menu.add_player_feature("SMS Spam I fucked your mom last night", "toggle", presets0, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "I fucked your mom last night")
end
end)

menu.add_player_feature("SMS Spam I Have you location SKID", "toggle", presets0, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "I Have you location SKID)")
end
end)

menu.add_player_feature("SMS Spam To your desktop you go buddy", "toggle", presets0, function(f, pid)
	while f.on do
	system.wait(10)
	player.send_player_sms(pid, "To your desktop you go buddy")
end
end)

local selff = menu.add_feature("Self", "parent", main.id)

--local vehicle = menu.add_feature("Vehicle", "parent", main.id)

menu.add_feature("Send Custom SMS to lobby", "action", lobby.id, function(f, pid)
	local custom, SC = input.get("Enter Custom SMS", "", 128, 0)
		while custom == 1 do
        system.yield(0)
         	custom, SC = input.get("Enter Custom SMS", "", 128, 0)
        end
         	 if custom == 2 then
           	 return HANDLER_POP
             end

             for pid = 0 ,31 do
             	if ValidScid(scid) then
        player.send_player_sms(pid, SC)
    end
    end
end)


menu.add_feature("Unmark All the Dirty Whores", "toggle", lobby.id, function(prots, pid)
	while prots.on do 
		for pid = 0,32 do
		system.wait(25)
		player.unset_player_as_modder(pid, -1)
	end
	end
end)

menu.add_feature("Hiroshima Self", "toggle", selff.id, function(f)
	while f.on do 
		system.wait(10)
		for x = 35, 0, -5 do
			system.wait(30)
		local pos = player.get_player_coords(player.player_id())
		pos.z = pos.z + x
		fire.add_explosion(pos, 8, true, false, 0, own_ped())
	end
	end
end)

menu.add_feature("Hiroshima Niggers", "toggle", lobby.id, function(f, pid) 
	while f.on do 
		system.wait(25)
		for pid = 0, 32 do
     	 local valid = valid_check(pid)
      	 if valid ~= -1 then
			for x = 30, 0, -5 do
				system.wait(50)
				local pos = player.get_player_coords(pid)
				pos.z = pos.z + x
				fire.add_explosion(pos, 8, true, false, 0, pid)
				ui.notify_above_map("Lobby is Being Hiroshima'd :|", "Gilbert", 14)
			end
			end
		end
	end
end)

local fun = menu.add_player_feature("Fun", "parent", funny, function(f, pid)
end).id

menu.add_player_feature("Hiroshima Meatball", "toggle", fun, function(f, pid)
	while f.on do 
		system.wait(10)
		for x = 35, 0, -5 do
			system.wait(30)
		local pos = player.get_player_coords(pid)
		pos.z = pos.z + x
		fire.add_explosion(pos, 8, true, false, 0, pid)
	end
	end
end)