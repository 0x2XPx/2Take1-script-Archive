
  
        menu.add_player_feature("climb Mount Everest", "action", 0, function(playerfeat, pid)

    local playerped3 = player.get_player_ped(pid)

    local pos = v3()
    pos.x = pos.x + 1.55
    pos.y = pos.y + 3.35



    attach_object1132 = object.create_object(1888301071, pos, true, false)
    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)

    entity.set_entity_visible(attach_object1132, false)

    local pos = v3()
    pos.z = pos.z + 1.55
    pos.x = pos.x + 1.55
    pos.y = pos.y + 3.35



    attach_object1132 = object.create_object(1888301071, pos, true, false)
    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)

entity.set_entity_visible(attach_object1132, false)

    local pos = v3()
    pos.z = pos.z - 2.00
    



    attach_object1132 = object.create_object(-1951226014, pos, true, false)
    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)

    entity.set_entity_visible(attach_object1132, false)

    
    local pos = v3()
    pos.x = pos.x + 1.55
    pos.y = pos.y + 3.35
    



    attach_object1132 = object.create_object(1888301071, pos, true, false)

    local rot = entity.get_entity_rotation(attach_object1132)
    rot.y = 180
    entity.set_entity_rotation(attach_object1132, rot)


    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)

    
    entity.set_entity_visible(attach_object1132, false)

    local pos = v3()
    pos.x = pos.x + 0.45
    pos.y = pos.y + 3.35



    attach_object1132 = object.create_object(1888301071, pos, true, false)
    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)

    entity.set_entity_visible(attach_object1132, false)

    local pos = v3()
    pos.x = pos.x + 0.80
    pos.y = pos.y + 3.35



    attach_object1132 = object.create_object(1888301071, pos, true, false)
    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)

    entity.set_entity_visible(attach_object1132, false)

    local pos = v3()
    pos.z = pos.z - 2.00
    pos.x = pos.x + 0.80
    pos.y = pos.y + 3.35



    attach_object1132 = object.create_object(1888301071, pos, true, false)
    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)
    
    entity.set_entity_visible(attach_object1132, false)


    local pos = v3()
    pos.x = pos.x + 1.30
    pos.y = pos.y + 3.95



    attach_object1132 = object.create_object(1888301071, pos, true, false)
    entity.attach_entity_to_entity(attach_object1132, playerped3, 0, pos, pos, true, true, false, 0, false)

    entity.set_entity_visible(attach_object1132, false)
    

end)