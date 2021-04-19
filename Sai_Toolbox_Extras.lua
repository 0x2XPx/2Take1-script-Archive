--[[
Sai Toolbox Extras, made by Entrodor Wolfry#3502. (With the help of Sainan)
DM me if you have any script events or attachments youd like added :)

Changelog: 
    1.0.0   - initial release, added UFO attachment
    1.1.0   - changed UFO attachment, to attach a upside down one 
            - added random script events
            - added Send Custom Script Event to Player/Lobby
            - fix something that was done wrong.
    1.2.0   - added Block Passive mode
            - added extra kick events
    1.3.0   - added "args" to script_events table, so that can setup custom args for script events, rather than generalised ones
    1.4.0   - Removed extra kick events, as they did nothing.
            - added UF-OH SHIT to attachments
            - renamed Disable Passive to Block Passive
            - removed Enable Passive, cos still doesnt work
            - added extra comments, to show people how to add stuff to this script :D
    1.5.0   - added campfire attachment
            - added Black Room attachment
            - fixed unblock passive
            
--]]

local SCRIPT_NAME = "Sai Toolbox Extras v1.5.0"
if not sainans_toolbox then
    if sainans_toolbox_api_disabled then
        ui.notify_above_map(SCRIPT_NAME .. " requires the API to be enabled in Sainan's Toolbox.", SCRIPT_NAME, 6)
    else
        ui.notify_above_map(SCRIPT_NAME .. " is an extension for Sainan's Toolbox.", SCRIPT_NAME, 6)
    end
    return
end

-- extra attachments
--sainans_toolbox.add_attachable("NAME", {                      -- in case anyone wants to add their own entities (dont do any invalid entities, there is no cleanup script)
--    {EntityHash, {posx, posy, posz}, {rotx, roty, rotz}},     -- only need comma if multiple entities
--    {EntityHash, {posx, posy, posz}, {rotx, roty, rotz}}
--})
sainans_toolbox.add_attachable("UFO", {              -- attaches two UFOs to the target/s, one is upside down
	{3026699584, {0, 0, 0}, {0, 0, 0}}, 
	{3026699584, {0, 0, 0}, {0, 180, 0}}
})
sainans_toolbox.add_attachable("UF-OH SHIT", {       -- attaches 8 UFOs, at 45 degree incrememnts of rotation.
    {3026699584, {0, 0, 0}, {0, 0, 0}},
    {3026699584, {0, 0, 0}, {0, 90, 0}},
    {3026699584, {0, 0, 0}, {0, 180, 0}},
    {3026699584, {0, 0, 0}, {0, 270, 0}},
    {3026699584, {0, 0, 0}, {0, 45, 0}},
    {3026699584, {0, 0, 0}, {0, 135, 0}},
    {3026699584, {0, 0, 0}, {0, 225, 0}},
    {3026699584, {0, 0, 0}, {0, 315, 0}}
})
sainans_toolbox.add_attachable("Campfire", {         -- should be self-explanatory
    {3229200997, {0, 0, 0}, {0, 0, 0}}
})
sainans_toolbox.add_attachable("Black Room", {       -- attaches objects around player to make it look like they in black room
    {3136319403, {-1.5,    0,    0}, {180, 90, 0}},
    {3136319403, {-1.5,    0,    0}, {  0, 90, 0}},
    {3136319403, { 1.5,    0,    0}, {180, 90, 0}},
    {3136319403, { 1.5,    0,    0}, {  0, 90, 0}},
    {3136319403, {   0, -1.5,    0}, {270,  0, 0}},
    {3136319403, {   0, -1.5,    0}, { 90,  0, 0}},
    {3136319403, {   0,  1.5,    0}, {270,  0, 0}},
    {3136319403, {   0,  1.5,    0}, { 90,  0, 0}},
    {3136319403, {   0,    0, -0.5}, {180,  0, 0}},
    {3136319403, {   0,    0, -0.5}, {  0,  0, 0}},
    {3136319403, {   0,    0,  1.5}, {180,  0, 0}},
    {3136319403, {   0,    0,  1.5}, {  0,  0, 0}}
})

--extra kick events     not in use at the moment.
--local kick_events = {}
--for i = 1, #kick_events do
--  sainans_toolbox.add_kick_event(kick_events[i])
--end

-- script events for send script event option. 
local script_events = {
--  {"event name", "HASH", {ARGS, ARGS, ARGS}}    in case anyone wants to add their own events.
    {"Block Passive", "0x3a980c8f", {1, 1}},    -- Block Passive
    {"Unblock Passive", "0x3a980c8f", {2, 0}},    -- unblock passive

--test events

}


-- send script event to target
sainans_toolbox.on_register_player(function(uid, player_feature_id, player_vehicle_feature_id)
	local top_id = menu.add_feature("Send Script Event", "parent", player_feature_id).id
	for i = 1, #script_events do
    	menu.add_feature(script_events[i][1], "action", top_id, function()
			script.trigger_script_event(script_events[i][2], sainans_toolbox.uid_to_spid(uid), script_events[i][3])
			ui.notify_above_map(script_events[i][1] .. " sent to " .. sainans_toolbox.parse_uid(uid).name, SCRIPT_NAME, sainans_toolbox.get_notify_colour())
        end).threaded = false
	end
end)

-- send script event to whole lobby, meanie
local top_id = menu.add_feature("Send Script Event", "parent", sainans_toolbox.get_all_players_feature_id()).id
for i = 1, #script_events do
    menu.add_feature(script_events[i][1], "action", top_id, function()
        for spid = 0, 31 do
            if player.get_player_scid(spid) ~= -1 and spid ~= player.player_id() and (not sainans_toolbox.is_exclude_friends_on() or not player.is_player_friend(spid)) then
                script.trigger_script_event(script_events[i][2], spid, script_events[i][3])
            end
        end
        local message = "I've sent " .. script_events[i][1] .. " to everyone (except you"
            if sainans_toolbox.is_exclude_friends_on() then
                message = message .. " and your friends"
            end
        ui.notify_above_map(message .. ").", SCRIPT_NAME, sainans_toolbox.get_notify_colour())
    end).threaded = false
end
