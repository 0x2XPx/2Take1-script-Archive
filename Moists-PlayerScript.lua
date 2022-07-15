appdata = os.getenv("APPDATA")

local goddeath = v3()
goddeath.x = -5784.258301
goddeath.y = -8289.385742
goddeath.z = -136.411270


function chat(name, text)
    local dt = os.date("*t")
    local file = io.open(appdata.."\\PopstarDevs\\2Take1Menu\\LUALOG\\chat.md", "a")

    io.output(file)
    io.write("<"..name.. "> " .. text)
    io.close()
end


--Util functions
local notif = ui.notify_above_map
local function notify_above_map(msg)
	ui.notify_above_map(tostring(msg), "Moists Script", 140)
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

--Event hooks
local ChatEventID = event.add_event_listener("chat", function(e)
	local sender = player.get_player_name(e.player)
	print("<" .. sender .. "> " .. e.body)
	chat(sender, e.body)	
end)

event.add_event_listener("exit", function()
	event.remove_event_listener("chat", ChatEventID)
end)

function netbailkick(pid)

script.trigger_script_event(0x8197eaf0, pid, {pid, script.get_global_i(1628955 + (1 + (pid * 614)) + 532)})
script.trigger_script_event(0x8197eaf0, pid, {pid, script.get_global_i(1628955 + (1 + (pid * 614)) + 532)})
script.trigger_script_event(0x8197eaf0, pid, {pid, script.get_global_i(1628955 + (2 + (pid * 614)) + 532)})

end

blockpassive = function(pid)

            script.trigger_script_event(0x3a980c8f, playerid, {1, 1})

end

unblockpassive = function(pid)

            script.trigger_script_event(0x3a980c8f, playerid, {2, 0})

end

blockpassiveall = function()

	local me
	
	me	= player.player_id()

	for i=0,32 do
		if i ~= me
		then
            script.trigger_script_event(0x3a980c8f, i, {1, 1})
end
end
end


--Player list
local playerFeatures = {}
local selffeatures = {}
local playersFeature = menu.add_feature("Online Players", "parent", 0)
local self = menu.add_feature("Self Modifiers", "parent", 0)

local mk2boostrefill = menu.add_feature("MK2 Boost Insta-Recharge (self)", "action", self.id, function(feat)
local myped = player.get_player_ped(player.player_id())
	if ped.is_ped_in_any_vehicle(myped) == true then
	local Curveh = ped.get_vehicle_ped_is_using(myped)
	vehicle.set_vehicle_rocket_boost_refill_time(Curveh, 0.01)
end end)
mk2boostrefill.threaded = false

for pid=0,31 do
	local f = menu.add_feature("Player " .. pid, "parent", playersFeature.id)

	local features = {}
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
	
	features["Teleport Player next2me"] = {feat = menu.add_feature("Teleport Player+Vehicle Next 2me", "toggle", f.id, function(feat)
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
				end

			end
		return HANDLER_CONTINUE
	end),  type = "toggle", callback = function()
	end}
    features["Teleport Player next2me"].feat.threaded = false
	
	features["Teleport Godmode Death"] = {feat = menu.add_feature("Teleport to Godmode Death", "toggle", f.id, function(feat)
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
	
	features["Network Kick"] = {feat = menu.add_feature("Network Bail Kick", "action", f.id, function()
        netbailkick(pid)
    end), type = "action"}
    features["Network Kick"].feat.threaded = false
	
		features["Block Passive"] = {feat = menu.add_feature("Block Passive Mode", "action", f.id, function()
        blockpassive(pid)
    end), type = "action"}
    features["Block Passive"].feat.threaded = false

		features["Unblock Passive"] = {feat = menu.add_feature("Unblock Passive Mode", "action", f.id, function()
        unblockpassive(pid)
    end), type = "action"}
    features["Unblock Passive"].feat.threaded = false
	
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
							notify_above_map("The session host is now " .. (isYou and "you" or name) .. ".")
						end
					end
					if pid == script.get_host_of_this_script() then
						tags[#tags + 1] = "S"
						if ScriptHost ~= pid then
							ScriptHost = pid
							notify_above_map("The script host is now " .. (isYou and "you" or name) .. ".")
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