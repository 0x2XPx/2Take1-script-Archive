local allpeds
allpeds = {}
local allveh
allveh = {}
local allobj
allobj = {}
local allpickups
allpickups = {}

get_allpeds = function(feat)
    --allpeds = {}
    allpeds = ped.get_all_peds()
    --table.concat(ped.get_all_peds(), ", ")
end

get_allveh = function(feat)

    allveh = vehicle.get_all_vehicles()

end


get_allobj = function(feat)

    allobj = object.get_all_objects()

end


get_allpickups = function(feat)

    allpickups = object.get_all_pickups()

end

get_everything = function(feat)
 
	allpeds = ped.get_all_peds()
	allveh = vehicle.get_all_vehicles()
    allobj = object.get_all_objects()
    allpickups = object.get_all_pickups()
end

delete_everything = function(feat)

    local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270

    for i = 1, #allpeds do
        if not ped.is_ped_a_player(allpeds[i]) then
			network.request_control_of_entity(allpeds[i])
            entity.set_entity_coords_no_offset(allpeds[i], pos)
            entity.set_entity_as_no_longer_needed(allpeds[i])
            entity.delete_entity(allpeds[i])
        end
    end
	
	   for i = 1, #allveh do
			network.request_control_of_entity(allveh[i])
			entity.set_entity_coords_no_offset(allveh[i], pos)
            entity.set_entity_as_no_longer_needed(allveh[i])
            entity.delete_entity(allveh[i])
        end
		   for i = 1, #allobj do
			network.request_control_of_entity(allobj[i])
			entity.set_entity_coords_no_offset(allobj[i], pos)
            entity.set_entity_as_no_longer_needed(allobj[i])
            entity.delete_entity(allobj[i])
        end
		   for i = 1, #allpickups do
			network.request_control_of_entity(allpickups[i])
			entity.set_entity_coords_no_offset(allpickups[i], pos)
            entity.set_entity_as_no_longer_needed(allpickups[i])
            entity.delete_entity(allpickups[i])
        end
end

move_delete_obj = function(feat)

    local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
		   for i = 1, #allobj do
			network.request_control_of_entity(allobj[i])
			entity.set_entity_coords_no_offset(allobj[i], pos)
            entity.set_entity_as_no_longer_needed(allobj[i])
            entity.delete_entity(allobj[i])
    end
end
	

move_delete_pickups = function(feat)

    local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270	

		   for i = 1, #allpickups do
			network.request_control_of_entity(allpickups[i])
			entity.set_entity_coords_no_offset(allpickups[i], pos)
            entity.set_entity_as_no_longer_needed(allpickups[i])
            entity.delete_entity(allpickups[i])
        end
end

move_delete_peds = function(feat)
    --print(allpeds)

    local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270

    for i = 1, #allpeds do
        if not ped.is_ped_a_player(allpeds[i]) then
			network.request_control_of_entity(allpeds[i])
            entity.set_entity_coords_no_offset(allpeds[i], pos)
            entity.set_entity_as_no_longer_needed(allpeds[i])
            entity.delete_entity(allpeds[i])
        end
    end
end

move_delete_veh = function(feat)
   
    local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270

    for i = 1, #allveh do
			network.request_control_of_entity(allveh[i])
			entity.set_entity_coords_no_offset(allveh[i], pos)
            entity.set_entity_as_no_longer_needed(allveh[i])
            entity.delete_entity(allveh[i])
        end
end


function main()
    local parent = menu.add_feature("Entity Functions", "parent", 0, cb)
	local parentped = menu.add_feature("Ped Entitys", "parent", parent.id, cb)
	local parentveh = menu.add_feature("Vehicle Entitys", "parent", parent.id, cb)
	local parentobj = menu.add_feature("Object Entitys", "parent", parent.id, cb)
	
    local fetch_peds = menu.add_feature("Fetch everything into Table", "action", parent.id, get_everything)
    fetch_peds.threaded = false

    local delete_move_all = menu.add_feature("Move Fetched Entitys and Delete", "action", parent.id, delete_everything)
    delete_move_all.threaded = false
	
	local fetch_peds = menu.add_feature("Fetch all Peds into Table", "action", parentped.id, get_allpeds)
    fetch_peds.threaded = false

    local delete_move_peds = menu.add_feature("Move Fetched Entitys and Delete", "action", parentped.id, move_delete_peds)
    delete_move_peds.threaded = false
	
	local fetch_obj = menu.add_feature("Fetch all objects into Table", "action", parentobj.id, get_allobj)
    fetch_obj.threaded = false

    local delete_move_obj = menu.add_feature("Move Fetched Objects and Delete", "action", parentobj.id, move_delete_obj)
    delete_move_obj.threaded = false
	
	local fetch_pickups = menu.add_feature("Fetch all Pickups into Table", "action", parentobj.id, get_allpickups)
    fetch_pickups.threaded = false

    local delete_move_pickups = menu.add_feature("Move Fetched Pickups and Delete", "action", parentobj.id, move_delete_pickups)
    delete_move_pickups.threaded = false
	
    local fetch_veh = menu.add_feature("Fetch all Vehicles into Table", "action", parentveh.id, get_allveh)
    fetch_veh.threaded = false

    local delete_move = menu.add_feature("Move Fetched Entitys and Delete", "action", parentveh.id, move_delete_veh)
    delete_move.threaded = false
end
main()
