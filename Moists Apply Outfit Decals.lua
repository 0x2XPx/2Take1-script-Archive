local drawable_feature
local texture_feature

decalsnotify = function(feat)

	local playerid = player.player_id()
	local ped_id = player.get_player_ped(playerid)
	local peddrawable
	local pedtexture

	peddrawable = ped.get_ped_drawable_variation(ped_id, 10)

	ui.notify_above_map("Current Drawable: " ..peddrawable, "Current Decals", 112)

	pedtexture = ped.get_ped_texture_variation(ped_id, 10)

	ui.notify_above_map("Current Texture: " ..pedtexture, "Current Decals", 112)
end


-- decalsupd = function(feat)

	-- local playerid = player.player_id()
	-- local ped_id = player.get_player_ped(playerid)

	-- drawable_feature =  ped.get_ped_drawable_variation(ped_id, 10)
	-- texture_feature =  ped.get_ped_texture_variation(ped_id, 10)
	-- drawable_feature = ped.get_ped_drawable_variation(ped_id, 10)

-- drawidn = tonumber(ped.get_ped_drawable_variation(player.get_player_ped(player.player_id())), 10)drawable_feature())
-- textidn =tonumber(texture_feature())

-- return HANDLER_CONTINUE
-- end



setdecal01 = function(feat)

	local playerid = player.player_id()
	local ped_id = player.get_player_ped(playerid)
	local peddrawable
	local pedtexture

	peddrawable = ped.get_ped_drawable_variation(ped_id, 10)

	pedtexture = ped.get_ped_texture_variation(ped_id, 10)
			
	ped.set_ped_component_variation(ped_id, 10, drawable_feature.value_i, pedtexture, 0)

	return HANDLER_POP

end

setdecal02 = function(feat)

	local playerid = player.player_id()
	local ped_id = player.get_player_ped(playerid)
	local peddrawable
	local pedtexture

	peddrawable = ped.get_ped_drawable_variation(ped_id, 10)

	ped.set_ped_component_variation(ped_id, 10, peddrawable, texture_feature.value_i, 0)

	return HANDLER_POP

end


function main()

	local parent
	local outdecal
	local drawid
	local texid
	local palid
	local drawidn
	local textidn
	drawidn = ped.get_ped_drawable_variation(player.get_player_ped(player.player_id()), 10)
	textidn = ped.get_ped_texture_variation(player.get_player_ped(player.player_id()), 10)
	
-- local decalvalue = menu.add_feature("update decals selection", "toggle", 0, decalsupd)
-- decalvalue.threaded = false
-- decalvalue.on = false
-- decalvalue.hidden = false

    parent = menu.add_feature("Outfit Decal Overlays", "parent", 0, cb)
	outdecal = menu.add_feature("Get Current Outfit Decal ID's", "action", parent.id, decalsnotify)
	outdecal.threaded = false

	drawable_feature = menu.add_feature("Drawable ID", "autoaction_value_i", parent.id, setdecal01)
	drawable_feature.threaded = false

    if (drawable_feature) then
        drawable_feature.max_i = 100
        drawable_feature.min_i = 0
		drawable_feature.value_i = drawidn
    end                           

	texture_feature = menu.add_feature("Texture ID", "autoaction_value_i", parent.id, setdecal02)
	texture_feature.threaded = false

    if (texture_feature) then
        texture_feature.max_i = 80
        texture_feature.min_i = 0
		texture_feature.value_i = textidn
    end

end

main()

