
-- Thank you to RulyPancake the 5th for helping

if ForceSH then
    menu.notify("Script is already loaded.", "Force Script Host", 3, 0xEA9C4D)
    return
end
ForceSH = "1.0.0"
local Lobby = menu.get_feature_by_hierarchy_key("online.lobby.force_script_host")
local Type = "toggle"
local timer = utils.time_ms()

event.add_event_listener("player_join", function(joined_player)
    if joined_player.player == player.player_id() then
        timer = utils.time_ms() + 15000
        print("Session changed, pausing Force Script Host for 15 seconds.")
    end
end)

if Lobby ~= nil then
    print("2Take1 VIP detected. Magic method available.")
    menu.notify("Notice: The <Magic> method uses 2Take1's own Force Script Host method which is far better than <Natives>, but also sends a notification every time its triggered.", "Force Script Host", 10, 0xEA9C4D)
    Type = "value_str"
end

local MainFeature = menu.add_feature("Force Script Host", Type, 0, function(f)
    while f.on do
        while timer == utils.time_ms() do
            system.yield()
        end
        if network.is_session_started() and player.is_player_valid(player.player_id()) and script.get_host_of_this_script() ~= player.player_id() then
            if f.value == 0 and Lobby ~= nil then
                Lobby:toggle()
            else
                -- Force SH Function by RulyPancake the 5th
                local time = utils.time_ms() + 8000
                while time > utils.time_ms() and script.get_host_of_this_script() ~= player.player_id() do
                    if player.is_player_valid(player.player_id()) then
                        native.call(0x6EB5F71AA68F2E8E, "freemode")
                        native.call(0x6EB5F71AA68F2E8E, "main")
                        native.call(0x741A3D8380319A81)
                    end
                    system.yield(0)
                end
            end
        end
        system.yield(8000)
    end
end)

if Lobby ~= nil then
    MainFeature:set_str_data({"Magic", "Natives"})
end