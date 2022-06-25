--Squidbq--
--Credit to Gee-Man521 for helping--
local local_parent = menu.add_feature("Earrape", "parent", 0)
local local_very_loud = menu.add_feature("very loud", "parent", local_parent.id)
local local_loud = menu.add_feature("loud", "parent", local_parent.id)
local local_not_that_loud = menu.add_feature("not that loud", "parent", local_parent.id)


local player_parent = menu.add_player_feature("Earrape", "parent", 0)
local player_very_loud = menu.add_player_feature("very loud", "parent", player_parent.id)
local player_loud = menu.add_player_feature("loud", "parent", player_parent.id)
local player_not_that_loud = menu.add_player_feature("not that loud", "parent", player_parent.id)

local function checknumber(_num)
    if _num ~= nil and tonumber(_num) ~= nil then
        return true
    end
    return false
end

local function text_input(_title,_default,_max,_type)
    local status,str=1
    while status == 1 do 
        system.yield(0)
        status, str = input.get(_title, _default, _max, _type)
    end
    return status,str
end

--very loud all players
menu.add_feature("Earrape all v1", "action", local_very_loud.id, function(f)
        menu.notify("Sending earrape v1 to all players...",nil,5, 0x00FF00)
        for i = 0, 100 do
            for pid = 0,31 do
                if player.is_player_valid(pid) then
                    audio.play_sound_from_coord(-1, "BED", player.get_player_coords(pid), "WASTEDSOUNDS", true, 9999, false)
                end
            end
        end
end)

menu.add_feature("Earrape all v2", "action", local_very_loud.id, function(f)
    menu.notify("Sending earrape v2 to all players...",nil,5, 0x00FF00)
    for i = 0, 100 do
        for pid = 0,31 do
            if player.is_player_valid(pid) then
                audio.play_sound_from_coord(-1, "ScreenFlash", player.get_player_coords(pid), "WastedSounds", true, 9999, false)
            end
        end
    end
end)

menu.add_feature("Earrape all v3", "action", local_very_loud.id, function(f)
    menu.notify("Sending earrape v3 to all players...",nil,5, 0x00FF00)
    for i = 0, 100 do
        for pid = 0,31 do
            if player.is_player_valid(pid) then
                audio.play_sound_from_coord(-1, "Air_Defences_Activated", player.get_player_coords(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, 9999, false)
            end
        end
    end
end)

--loud all players
menu.add_feature("Earrape all v1", "action", local_loud.id, function(f)
    menu.notify("Sending earrape v1 to all players...",nil,5, 0x00FF00)
    for i = 0, 100 do
        for pid = 0,31 do
            if player.is_player_valid(pid) then
                audio.play_sound_from_coord(-1, "LOSER", player.get_player_coords(pid), "HUD_AWARDS", true, 9999, false)
            end
        end
    end
end)

--not that loud all players


menu.add_feature("Earrape all v1", "action", local_not_that_loud.id, function(f)
    menu.notify("Sending earrape v1 to all players...",nil,5, 0x00FF00)
    for i = 0, 100 do
        for pid = 0,31 do
            if player.is_player_valid(pid) then
                audio.play_sound_from_coord(-1, "Horn", player.get_player_coords(pid), "DLC_Apt_Yacht_Ambient_Soundset", true, 9999, false)
            end
        end
    end
end)


menu.add_feature("Earrape all v2", "action", local_not_that_loud.id, function(f)
    menu.notify("Sending earrape v2 to all players...",nil,5, 0x00FF00)
    for i = 0, 100 do
        for pid = 0,31 do
            if player.is_player_valid(pid) then
                audio.play_sound_from_coord(-1, "1st_Person_Transition", player.get_player_coords(pid), "PLAYER_SWITCH_CUSTOM_SOUNDSET", true, 9999, false)
            end
        end
    end
end)


--very loud on players
menu.add_player_feature("Earrape v1", "action", player_very_loud.id, function(f,pid)
    local status,str = text_input("Type range... | Minimum = 1 | Maximum = 9999","",128,3)
    if status == 0 then
        if tonumber(str) < 1 then
            menu.notify("Value is to low "..str,nil,5, 0x0000FF)
            return
        end
        if tonumber(str) > 9999 then
            menu.notify("Value is to high "..str,nil,5, 0x0000FF)
            return
        end
        menu.notify("Send earrape v1 with range: "..str,nil,5, 0x00FF00)
        for i = 0, 100 do
            audio.play_sound_from_coord(-1, "BED", player.get_player_coords(pid), "WASTEDSOUNDS", true, str, false)
        end
    else
        menu.notify("Cancelled",nil,3, 211)
    end

end)

menu.add_player_feature("Earrape v2", "action", player_very_loud.id, function(f,pid)
    local status,str = text_input("Type range... | Minimum = 1 | Maximum = 9999","",128,3)
    if status == 0 then
        if tonumber(str) < 1 then
            menu.notify("Value is to low "..str,nil,5, 0x0000FF)
            return
        end
        if tonumber(str) > 9999 then
            menu.notify("Value is to high "..str,nil,5, 0x0000FF)
            return
        end
        menu.notify("Send earrape v2 with range: "..str,nil,5, 0x00FF00)
        for i = 0, 100 do
            audio.play_sound_from_coord(-1, "ScreenFlash", player.get_player_coords(pid), "WastedSounds", true, str, false)
        end
    else
        menu.notify("Cancelled",nil,3, 211)
    end

end)

menu.add_player_feature("Earrape v3", "action", player_very_loud.id, function(f,pid)
    local status,str = text_input("Type range... | Minimum = 1 | Maximum = 9999","",128,3)
    if status == 0 then
        if tonumber(str) < 1 then
            menu.notify("Value is to low "..str,nil,5, 0x0000FF)
            return
        end
        if tonumber(str) > 9999 then
            menu.notify("Value is to high "..str,nil,5, 0x0000FF)
            return
        end
        menu.notify("Send earrape v3 with range: "..str,nil,5, 0x00FF00)
        for i = 0, 100 do
            audio.play_sound_from_coord(-1, "Air_Defences_Activated", player.get_player_coords(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, str, false)
        end
    else
        menu.notify("Cancelled",nil,3, 211)
    end

end)

--loud on players
menu.add_player_feature("Earrape v1", "action", player_loud.id, function(f,pid)
    local status,str = text_input("Type range... | Minimum = 1 | Maximum = 9999","",128,3)
    if status == 0 then
        if tonumber(str) < 1 then
            menu.notify("Value is to low "..str,nil,5, 0x0000FF)
            return
        end
        if tonumber(str) > 9999 then
            menu.notify("Value is to high "..str,nil,5, 0x0000FF)
            return
        end
        menu.notify("Send earrape v1 with range: "..str,nil,5, 0x00FF00)
        for i = 0, 100 do
            audio.play_sound_from_coord(-1, "LOSER", player.get_player_coords(pid), "HUD_AWARDS", true, str, false)
        end
    else
        menu.notify("Cancelled",nil,3, 211)
    end

end)


--not that loud on players
menu.add_player_feature("Earrape v1", "action", player_not_that_loud.id, function(f,pid)
    local status,str = text_input("Type range... | Minimum = 1 | Maximum = 9999","",128,3)
    if status == 0 then
        if tonumber(str) < 1 then
            menu.notify("Value is to low "..str,nil,5, 0x0000FF)
            return
        end
        if tonumber(str) > 9999 then
            menu.notify("Value is to high "..str,nil,5, 0x0000FF)
            return
        end
        menu.notify("Send earrape v1 with range: "..str,nil,5, 0x00FF00)
        for i = 0, 100 do
            audio.play_sound_from_coord(-1, "Horn", player.get_player_coords(pid), "DLC_Apt_Yacht_Ambient_Soundset", true, str, false)
        end
    else
        menu.notify("Cancelled",nil,3, 211)
    end

end)

menu.add_player_feature("Earrape v2", "action", player_not_that_loud.id, function(f,pid)
    local status,str = text_input("Type range... | Minimum = 1 | Maximum = 9999","",128,3)
    if status == 0 then
        if tonumber(str) < 1 then
            menu.notify("Value is to low "..str,nil,5, 0x0000FF)
            return
        end
        if tonumber(str) > 9999 then
            menu.notify("Value is to high "..str,nil,5, 0x0000FF)
            return
        end
        menu.notify("Send earrape v2 with range: "..str,nil,5, 0x00FF00)
        for i = 0, 100 do
            audio.play_sound_from_coord(-1, "1st_Person_Transition", player.get_player_coords(pid), "PLAYER_SWITCH_CUSTOM_SOUNDSET", true, str, false)
        end
    else
        menu.notify("Cancelled",nil,3, 211)
    end

end)

