-- Add the menu option to 2take1's Script Features section.
local version = "0.0.1-beta"
local main_menu = menu.add_feature("Crusty Teleporter", "parent")

-- Define our splitter string so we don't repeat ourselves.
local file_path = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\crusty-teleporter-locations.txt"
local file_splitter_string = "|do not edit the txt file|"

-- Saved location menu options and option tracking.
local main_locations = menu.add_feature("Saved Locations","parent",main_menu.id)
local location_features = {}

-- Split function credit: https://www.codegrepper.com/code-examples/lua/lua+split+string+by+delimiter
local function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

-- Create the location file if it doesn't exist.
local function create_save_file_if_doesnt_exist()
    local file_found = io.open(file_path, "r")      

    if file_found==nil then
        file = io.open (file_path, "a+")
        io.output(file)
        io.write("")
        io.close(file)
    else
        io.close(file_found)
    end
end
create_save_file_if_doesnt_exist()

-- Generate a semi-random ID (dirty but it'll do)
math.randomseed(os.time())
local function generate_random_id()
    return os.time().."r"..math.random(1,10000)
end

-- Generate the save string for the text file.
local function generate_save_line_string(id, name, x, y, z)
    return id..file_splitter_string..name..file_splitter_string..x..","..y..","..z
end

-- Allow for updating the location (primary purposes is for renaming locations).
local function update_location(id, name, x, y, z)
    -- Loop through the file looking for the location with the specified ID.
    local found_index = false
    local file = io.open(file_path, 'r')
    local file_content = {}
    local last_checked_line = 0
    for line in file:lines() do
        last_checked_line = last_checked_line + 1
        table.insert (file_content, line)

        -- Grab the ID from the row.
        local _main_parts = split(line, file_splitter_string)
        local _location_id = _main_parts[1]

        -- Did we find the ID?
        if _location_id == id then
            found_index = last_checked_line
        end
    end
    io.close(file)

    -- If we found the ID, proceed with the edit/save.
    if found_index then
        -- Found the ID, update the row.
        file_content[found_index] = generate_save_line_string(id, name, x, y, z)

        -- Save the file.
        file = io.open(file_path, 'w')
        for index, value in ipairs(file_content) do
            file:write(value..'\n')
        end
        io.close(file)

        -- Update the method data.
        location_features[id].name = name
        location_features[id].data.id = id
        location_features[id].data.name = name
        location_features[id].data.x = x
        location_features[id].data.y = y
        location_features[id].data.z = z

        return true
    else
        -- Did not find the ID. Alert the user.
        return false
    end
end

-- Delete a location.
local function delete_location(id, name, x, y, z)
    -- Loop through the file looking for the location with the specified ID.
    local found = false
    local file = io.open(file_path, 'r')
    local file_content = {}
    for line in file:lines() do
        -- Grab the ID from the row.
        local _main_parts = split(line, file_splitter_string)
        local _location_id = _main_parts[1]

        -- Add the item location if it isn't the one we're deleting.
        if _location_id == id then
            found = true
        else
            table.insert (file_content, line)
        end
    end
    io.close(file)

    -- If we found the ID, proceed with the delete/save.
    if found then
        -- Save the file.
        file = io.open(file_path, 'w')
        for index, value in ipairs(file_content) do
            file:write(value..'\n')
        end
        io.close(file)
        
        -- The real time update in the menu is handled elsewhere, this just updates the file.
        return true
    else
        -- Did not find the ID. Alert the user.
        return false
    end
end

-- Add a placeholder if there aren't any saved locations.
local placeholder_location_feature = menu.add_feature("No saved locations.", "action", main_locations.id, function() end)

-- Adds the location to the location list.
local function append_location_to_list(id, name, x, y, z)
    -- Make sure we keep track of the feature ID so we can delete the option from the menu if they choose to remove it later.
    location_features[id] = menu.add_feature(name, "action_value_str", main_locations.id, function(option_index)
        -- Teleport
        if option_index.value == 0 then
            -- Check if we're in a vehicle.
            local _player_id = player.player_id()
            local _player_ped = player.get_player_ped(player.player_id())
            local _player_vehicle = ped.get_vehicle_ped_is_using(_player_ped)
            local _teleport_success = false

            if entity.is_an_entity(_player_vehicle) then
                -- Teleport with vehicle.
                _teleport_success = entity.set_entity_coords_no_offset(_player_vehicle, v3(location_features[id].data.x, location_features[id].data.y, location_features[id].data.z))
            else
                -- Teleport without vehicle.
                _teleport_success = entity.set_entity_coords_no_offset(_player_ped, v3(location_features[id].data.x, location_features[id].data.y, location_features[id].data.z))
            end
            
            -- Did it work?
            if _teleport_success then
                menu.notify("Teleported to \""..name.."\"!", "Crusty Teleporter", 7, 0x00009900)
            else
                menu.notify("Could not teleport to \""..name.."\".", "Crusty Teleporter", 7, 0x00000099)
            end
        end

        -- Rename
        if option_index.value == 1 then
            -- _input_status: 0 = SUCCESS, 1 = PENDING, 2 = FAILED
            local _input_status, _input_value  = input.get("What do you wish to name this location?", "", 999, 0)

            -- We have to wait for input from the user.
            if _input_status == 1 then
                return HANDLER_CONTINUE
            end
        
            -- They didn't enter a name, used our splitter string (which would cause parse errors) in the name, or something else happened causing this to fail. Notify them and abort saving.
            if _input_status == 2 or _input_value == "" or string.find(_input_value, file_splitter_string) then
                menu.notify("Could not save custom teleport location. This may be caused by an empty or invalid name.", "Crusty Teleporter", 7, 0x00000099)
                return false
            end

            -- Get the previous name.
            local previous_name = location_features[id].name

            -- Update the location in the file.
            local success = update_location(id, _input_value, x, y, z)

            -- Notify the user.
            if success then
                menu.notify("Renamed \""..previous_name.."\" to \"".._input_value.."\"!", "Crusty Teleporter", 7, 0x00009900)
            else
                menu.notify("Could not rename teleport location.", "Crusty Teleporter", 7, 0x00000099)
            end
        end

        -- Replace
        if option_index.value == 2 then
            -- Get the current coords.
            local _player_id = player.player_id()
            local _player_ped = player.get_player_ped(player.player_id())
            local _player_coords = entity.get_entity_coords(_player_ped)

            -- Update the location in the file.
            local success = update_location(id, name, _player_coords["x"], _player_coords["y"], _player_coords["z"])

            -- Notify the user.
            if success then
                menu.notify("Replaced \""..name.."\" to teleport to here!", "Crusty Teleporter", 7, 0x00009900)
            else
                menu.notify("Could not replace teleport location.", "Crusty Teleporter", 7, 0x00000099)
            end
        end

        -- Delete
        if option_index.value == 3 then
            -- Delete the location from the file.
            local success = delete_location(id)

            if success then
                menu.notify("Deleted \""..name.."\" from your saved locations.", "Crusty Teleporter", 7, 0x00009900)
                menu.delete_feature(location_features[id].id)
            else
                menu.notify("Could not delete the teleport location.", "Crusty Teleporter", 7, 0x00000099)
            end
        end
    end)
    
    -- Set the menu options.
    location_features[id]:set_str_data({
        "Teleport",
        "Rename",
        "Replace",
        "Delete"
    })

    -- Set the coordinate data.
    location_features[id].data = {}
    location_features[id].data.id = id
    location_features[id].data.name = name
    location_features[id].data.x = x
    location_features[id].data.y = y
    location_features[id].data.z = z

    -- Delete the placeholder feature if applicable.
    if placeholder_location_feature then
        menu.delete_feature(placeholder_location_feature.id)
        placeholder_location_feature = nil 
    end
end

-- Load the saved locations by looping through the save file.
file = io.open(file_path, "r")
io.input(file)
for line in io.lines(file_path) do
    -- Is our splitter string present indicating it's likely a valid line?
    if string.find(line, file_splitter_string) then
        -- Split the string to get the name and coordinates.
        local _main_parts = split(line, file_splitter_string)
        local _location_id = _main_parts[1]
        local _location_coords = split(_main_parts[3], ",")
        local _location_name,_location_coord_x,_location_coord_y,_location_coord_z = _main_parts[2], _location_coords[1], _location_coords[2], _location_coords[3]

        -- Add the option to the locations list.
        append_location_to_list(_location_id, _location_name, _location_coord_x, _location_coord_y, _location_coord_z)
    end
end
io.close(file)

-- Add the save button to the menu.
menu.add_feature("Save Current Location", 'action', main_menu.id, function()
    -- _input_status: 0 = SUCCESS, 1 = PENDING, 2 = FAILED
    local _input_status, _input_value  = input.get("What do you wish to name this location?", "", 999, 0)

    -- We have to wait for input from the user.
    if _input_status == 1 then
        return HANDLER_CONTINUE
    end

    -- They didn't enter a name, used our splitter string (which would cause parse errors) in the name, or something else happened causing this to fail. Notify them and abort saving.
    if _input_status == 2 or _input_value == "" or string.find(_input_value, file_splitter_string) then
        menu.notify("Could not save custom teleport location. This may be caused by an empty or invalid name.", "Crusty Teleporter", 7, 0x00000099)
        return false
    end

    -- Everything looks good. Let's save it.
    local _location_id = generate_random_id()
    local _player_id = player.player_id()
    local _player_ped = player.get_player_ped(player.player_id())
    local _player_coords = entity.get_entity_coords(_player_ped)
    
    -- Save the location to our file. Yes, we're using an archaic method of saving and loading data, but I don't know lua very well and want to avoid importing libraries.
    file = io.open (file_path, "a+")
    io.output(file)
    io.write(generate_save_line_string(_location_id, _input_value, _player_coords["x"], _player_coords["y"], _player_coords["z"]).."\n")
    io.close(file)

    -- Add it to the list.
    append_location_to_list(_location_id, _input_value, _player_coords["x"], _player_coords["y"], _player_coords["z"])

    -- Let them know that the location was saved successfully.
    menu.notify("Custom teleport location named \"".._input_value.."\" saved!", "Crusty Teleporter", 7, 0x00009900)
end)

-- Add manual teleportation for advanced users.
local manual_teleport_function = 
menu.add_feature("Go to Manual Coordinates (Advanced)", 'action', main_menu.id, function()
    -- _input_status: 0 = SUCCESS, 1 = PENDING, 2 = FAILED
    local _input_status, _input_value  = input.get("This is for advanced users and could break your game if used incorrectly. Enter coordinates (X,Y,Z):", "", 999, 0)

    -- We have to wait for input from the user.
    if _input_status == 1 then
        return HANDLER_CONTINUE
    end

    -- Remove spaces.
    _input_value = string.gsub(_input_value, "%s+", "")
    local _location_coords = split(_input_value, ",")

    -- They didn't enter a name, used our splitter string (which would cause parse errors) in the name, or something else happened causing this to fail. Notify them and abort saving.
    if _input_status == 2 or _input_value == "" or string.find(_input_value, file_splitter_string) then
        menu.notify("Aborted manual teleportation.", "Crusty Teleporter", 7, 0x00000099)
        return false
    end

    -- Check if we're in a vehicle.
    local _player_id = player.player_id()
    local _player_ped = player.get_player_ped(player.player_id())
    local _player_vehicle = ped.get_vehicle_ped_is_using(_player_ped)
    local _teleport_success = false

    if entity.is_an_entity(_player_vehicle) then
        -- Teleport with vehicle.
        _teleport_success = entity.set_entity_coords_no_offset(_player_vehicle, v3(_location_coords[1], _location_coords[2], _location_coords[3]))
    else
        -- Teleport without vehicle.
        _teleport_success = entity.set_entity_coords_no_offset(_player_ped, v3(_location_coords[1], _location_coords[2], _location_coords[3]))
    end
    
    -- Did it work?
    if _teleport_success then
        menu.notify("Teleported to the manually entered location!", "Crusty Teleporter", 7, 0x00009900)
    else
        menu.notify("Could not teleport to the manually entered location.", "Crusty Teleporter", 7, 0x00000099)
    end
end)

-- About
menu.add_feature("About", 'action', main_menu.id, function()
    menu.notify("Built in loving memory of my Shih Tzu Crusty, who teleported into heaven 2021-09-07.", "Crusty Teleporter", 7, 0x00009900)
    menu.notify("Version "..version, "Crusty Teleporter", 7, 0x00009900)
end)