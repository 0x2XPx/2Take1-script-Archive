function createClone(player_ped, clone_ped)
    local plyr_clothes = {
        player_mask = ped.get_ped_drawable_variation(player_ped, 1),
        player_top = ped.get_ped_drawable_variation(player_ped, 11),
        player_legs = ped.get_ped_drawable_variation(player_ped, 4),
        player_vest = ped.get_ped_drawable_variation(player_ped, 9),
        player_hair = ped.get_ped_drawable_variation(player_ped, 2),
        player_undershirts = ped.get_ped_drawable_variation(player_ped, 8),
        player_torso = ped.get_ped_drawable_variation(player_ped, 3),
        player_feet = ped.get_ped_drawable_variation(player_ped, 6),
        player_accessories = ped.get_ped_drawable_variation(player_ped, 7),
        player_hats = ped.get_ped_prop_index(player_ped, 0),
        player_glasses = ped.get_ped_prop_index(player_ped, 1),
        player_ears = ped.get_ped_prop_index(player_ped, 2),
        player_watches = ped.get_ped_prop_index(player_ped, 6),
        player_bracelets = ped.get_ped_prop_index(player_ped, 7),
    }
    local plyr_cloth_tex = {
        player_mask_tex = ped.get_ped_texture_variation(player_ped, 1),
        player_top_tex = ped.get_ped_texture_variation(player_ped, 11),
        player_legs_tex = ped.get_ped_texture_variation(player_ped, 4),
        player_vest_tex = ped.get_ped_texture_variation(player_ped, 9),
        player_hair_tex = ped.get_ped_texture_variation(player_ped, 2),
        player_undershirts_tex = ped.get_ped_texture_variation(player_ped, 8),
        player_torso_tex = ped.get_ped_texture_variation(player_ped, 3),
        player_accessories_tex = ped.get_ped_texture_variation(player_ped, 7),
        player_feet_tex = ped.get_ped_texture_variation(player_ped, 6),
        player_hats_tex = ped.get_ped_prop_texture_index(player_ped, 0),
        player_glasses_tex = ped.get_ped_prop_texture_index(player_ped, 1),
        player_ears_tex = ped.get_ped_prop_texture_index(player_ped, 2),
        player_watches_tex = ped.get_ped_prop_texture_index(player_ped, 6),
        player_bracelets_tex = ped.get_ped_prop_texture_index(player_ped, 7)
    }

    ped.set_ped_component_variation(clone_ped, 1, plyr_clothes["player_mask"], plyr_cloth_tex["player_mask_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 11, plyr_clothes["player_top"], plyr_cloth_tex["player_top_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 4, plyr_clothes["player_legs"], plyr_cloth_tex["player_legs_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 9, plyr_clothes["player_vest"], plyr_cloth_tex["player_vest_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 2, plyr_clothes["player_hair"], plyr_cloth_tex["player_hair_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 8, plyr_clothes["player_undershirts"], plyr_cloth_tex["player_undershirts_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 3, plyr_clothes["player_torso"], plyr_cloth_tex["player_torso_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 7, plyr_clothes["player_accessories"], plyr_cloth_tex["player_accessories_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 6, plyr_clothes["player_feet"], plyr_cloth_tex["player_feet_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 0, plyr_clothes["player_hats"], plyr_cloth_tex["player_hats_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 1, plyr_clothes["player_glasses"], plyr_cloth_tex["player_glasses_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 2, plyr_clothes["player_ears"], plyr_cloth_tex["player_ears_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 6, plyr_clothes["player_watches"], plyr_cloth_tex["player_watches_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 7, plyr_clothes["player_bracelets"], plyr_cloth_tex["player_bracelets_tex"], 0)

    local headhair = {
        haircolor = ped.get_ped_hair_color(player_ped),
        hairhighlightcolor = ped.get_ped_hair_highlight_color(player_ped)
    }

    local age = {
        age_opacity = ped.get_ped_head_overlay_opacity(player_ped, 3),
        age_val = ped.get_ped_head_overlay_value(player_ped, 3),
        age_color_type = ped.get_ped_head_overlay_color_type(player_ped, 3),
        age_color = ped.get_ped_head_overlay_color(player_ped, 3),
        age_highlight = ped.get_ped_head_overlay_highlight_color(player_ped, 3)
    }

    local facial_hair = {
        facial_hair_opacity = ped.get_ped_head_overlay_opacity(player_ped, 1),
        facial_hair_val = ped.get_ped_head_overlay_value(player_ped, 1),
        facial_hair_color_type = ped.get_ped_head_overlay_color_type(player_ped, 1),
        facial_hair_color = ped.get_ped_head_overlay_color(player_ped, 1),
        facial_hair_highlight = ped.get_ped_head_overlay_highlight_color(player_ped, 1)
    }

    local blemishes = {
        blemishes_opacity = ped.get_ped_head_overlay_opacity(player_ped, 0),
        blemishes_val = ped.get_ped_head_overlay_value(player_ped, 0),
        blemishes_color_type = ped.get_ped_head_overlay_color_type(player_ped, 0),
        blemishes_color = ped.get_ped_head_overlay_color(player_ped, 0),
        blemishes_highlight = ped.get_ped_head_overlay_highlight_color(player_ped, 0)
    }

    local sun_damage = {
        sun_damage_opacity = ped.get_ped_head_overlay_opacity(player_ped, 7),
        sun_damage_val = ped.get_ped_head_overlay_value(player_ped, 7),
        sun_damage_color_type = ped.get_ped_head_overlay_color_type(player_ped, 7),
        sun_damage_color = ped.get_ped_head_overlay_color(player_ped, 7),
        sun_damage_highlight = ped.get_ped_head_overlay_highlight_color(player_ped, 7)
    }

    local freckles = {
        freckles_opacity = ped.get_ped_head_overlay_opacity(player_ped, 9),
        freckles_val = ped.get_ped_head_overlay_value(player_ped, 9),
        freckles_color_type = ped.get_ped_head_overlay_color_type(player_ped, 9),
        freckles_color = ped.get_ped_head_overlay_color(player_ped, 9),
        freckles_highlight = ped.get_ped_head_overlay_highlight_color(player_ped, 9)
    }

    local body_blemishes = {
        body_blemishes_opacity = ped.get_ped_head_overlay_opacity(player_ped, 11),
        body_blemishes_val = ped.get_ped_head_overlay_value(player_ped, 11),
        body_blemishes_color_type = ped.get_ped_head_overlay_color_type(player_ped, 11),
        body_blemishes_color = ped.get_ped_head_overlay_color(player_ped, 11),
        body_blemishes_highlight = ped.get_ped_head_overlay_highlight_color(player_ped, 11)
    }

    local _hb = ped.get_ped_head_blend_data(player_ped)
    ped.set_ped_head_blend_data(clone_ped, _hb["shape_first"], _hb["shape_second"], _hb["shape_third"], _hb["skin_first"], _hb["skin_second"], _hb["skin_third"], _hb["mix_shape"], _hb["mix_skin"], _hb["mix_third"])
    
    if (facial_hair["facial_hair_val"] ~= nil) then
        ped.set_ped_head_overlay(clone_ped, 1, facial_hair["facial_hair_val"], facial_hair["facial_hair_opacity"])
        ped.set_ped_head_overlay_color(clone_ped, 1, facial_hair["facial_hair_color_type"], facial_hair["facial_hair_color"], facial_hair["facial_hair_highlight"])
    end

    if (age["age_val"] ~= nil) then
        ped.set_ped_head_overlay(clone_ped, 3, age["age_val"], age["age_opacity"])
        ped.set_ped_head_overlay_color(clone_ped, 3, age["age_color_type"], age["age_color"], age["age_highlight"])
    end

    if (blemishes["blemishes_val"] ~= nil) then
        ped.set_ped_head_overlay(clone_ped, 0, blemishes["blemishes_val"], blemishes["blemishes_opacity"])
        ped.set_ped_head_overlay_color(clone_ped, 0, blemishes["blemishes_color_type"], blemishes["blemishes_color"], blemishes["blemishes_highlight"])
    end

    if (sun_damage["sun_damage_val"] ~= nil) then
        ped.set_ped_head_overlay(clone_ped, 7, sun_damage["sun_damage_val"], sun_damage["sun_damage_opacity"])
        ped.set_ped_head_overlay_color(clone_ped, 7, sun_damage["sun_damage_color_type"], sun_damage["sun_damage_color"], sun_damage["sun_damage_highlight"])
    end

    if (freckles["freckles_val"] ~= nil) then
        ped.set_ped_head_overlay(clone_ped, 9, freckles["freckles_val"], freckles["freckles_opacity"])
        ped.set_ped_head_overlay_color(clone_ped, 9, freckles["freckles_color_type"], freckles["freckles_color"], freckles["freckles_highlight"])
    end

    if (body_blemishes["body_blemishes_val"] ~= nil) then
        ped.set_ped_head_overlay(clone_ped, 11, body_blemishes["body_blemishes_val"], body_blemishes["body_blemishes_opacity"])
        ped.set_ped_head_overlay_color(clone_ped, 11, body_blemishes["body_blemishes_color_type"], body_blemishes["body_blemishes_color"], body_blemishes["body_blemishes_highlight"])
    end
    ped.set_ped_hair_colors(clone_ped, headhair["haircolor"], headhair["hairhighlightcolor"])

    local FaceFeatures = {
    Nose_width = 0,
    Nose_height = 1,
    Nose_length = 2,
    Nose_bridge = 3,
    Nose_tip = 4,
    Nose_bridge = 5,
    Brow_height = 6,
    Brow_width = 7,
    Cheekbone_height = 8,
    Cheekbone_width = 9,
    Cheeks_width = 10,
    Eyes = 11,
    Lips = 12,
    Jaw_width = 13,
    Jaw_height = 14,
    Chin_length = 15,
    Chin_position = 16,
    Chin_width = 17,
    Chin_shape = 18,
    Neck_width = 19
    }

    for k, v in pairs(FaceFeatures) do
        _hb[k] = ped.get_ped_face_feature(player_ped, v)
    end

    for k, v in pairs(FaceFeatures) do
		if _hb[k] then
	        ped.set_ped_face_feature(clone_ped, v, _hb[k])
        end
	end
end


function randomizeSkinTone(mp_ped)
    local _hb = ped.get_ped_head_blend_data(mp_ped)
    ped.set_ped_head_blend_data(mp_ped, _hb["shape_first"], _hb["shape_second"], _hb["shape_third"], math.random(0, 45), math.random(0, 45), math.random(0, 45), _hb["mix_shape"], math.random(), _hb["mix_third"])
end

function wipeHeadBlend(mp_ped)
    ped.set_ped_head_blend_data(mp_ped, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end

function randomizeHeadBlend(mp_ped)
    local hb_randomizer = {
        regular_hair_colors = select(math.random(1, 29), 4, 1, 8, 17, 2, 16, 60, 56, 27, 5, 14, 9, 26, 0, 28, 15, 57, 10, 11, 29, 55, 6, 18, 13, 7, 59, 12, 3, 58),
        regular_hair_highlight_colors = select(math.random(1, 29), 12, 59, 9, 4, 17, 14, 56, 11, 15, 18, 13, 6, 0, 8, 29, 57, 5, 27, 58, 55, 60, 2, 28, 26, 3, 1, 16, 10, 7),

        fem_face_shapes1 = select(math.random(1, 17), 29, 23, 22, 35, 31, 36, 28, 33, 32, 26, 37, 25, 21, 40, 34, 27, 45),
        fem_face_shapes2 = select(math.random(1, 17), 26, 32, 22, 45, 31, 21, 35, 36, 29, 37, 28, 23, 33, 25, 40, 27, 34),

        male_face_shapes1 = select(math.random(1, 23), 13, 2, 44, 10, 0, 7, 43, 18, 12, 9, 5, 1, 17, 11, 6, 16, 4, 39, 3, 8, 19, 20, 42),
        male_face_shapes2 = select(math.random(1, 23), 39, 1, 18, 19, 13, 42, 17, 16, 20, 7, 10, 8, 12, 44, 5, 2, 4, 6, 11, 0, 9, 3, 43),

        skin_tone1 = select(math.random(1, 46), 8, 33, 24, 42, 9, 14, 5, 22, 43, 20, 30, 41, 15, 44, 19, 11, 18, 3, 45, 12, 32, 34, 16, 7, 36, 29, 21, 6, 1, 10, 23, 28, 31, 4, 17, 27, 2, 25, 35, 40, 37, 38, 39, 26, 0, 13),
        skin_tone2 = select(math.random(1, 46), 4, 36, 19, 26, 16, 20, 24, 15, 45, 21, 41, 28, 1, 37, 42, 13, 7, 38, 12, 32, 27, 34, 30, 40, 5, 35, 3, 43, 9, 8, 10, 23, 18, 22, 17, 29, 6, 33, 2, 0, 39, 14, 31, 44, 25, 11),

        mix_value = select(math.random(1, 33), 0.7, 0.9, 0.0, 0.0, 0.8, 0.1, 0.5, 0.4, 0.6, 0.8, 0.0, 0.4, 0.5, 1.0, 1.0, 0.3, 0.5, 0.2, 0.3, 0.6, 0.2, 0.2, 0.9, 0.1, 0.9, 0.1, 0.7, 0.8, 0.6, 0.3, 1.0, 0.4, 0.7)
    }

    if (entity.get_entity_model_hash(mp_ped) == 2627665880) then
        ped.set_ped_head_blend_data(mp_ped, hb_randomizer["fem_face_shapes1"], hb_randomizer["fem_face_shapes2"], 0, hb_randomizer["skin_tone1"], hb_randomizer["skin_tone2"], 0, hb_randomizer["mix_value"], hb_randomizer["mix_value"], 0)
        local xyz = math.random(0, 80)
        if (xyz ~= 24) then
            ped.set_ped_component_variation(mp_ped, 2, xyz, 0, 0) --hair 
        end
    else
        ped.set_ped_head_blend_data(mp_ped, hb_randomizer["male_face_shapes1"], hb_randomizer["male_face_shapes1"], 0, hb_randomizer["skin_tone1"], hb_randomizer["skin_tone2"], 0, hb_randomizer["mix_value"], hb_randomizer["mix_value"], 0) -- base headblend
        local xyz = math.random(0, 76)
        if (xyz ~= 23) then
            ped.set_ped_component_variation(mp_ped, 2, xyz, 0, 0) --hair 
        end
        ped.set_ped_head_overlay(mp_ped, 1, math.random(-1, 28), math.random()) -- facial hair
        ped.set_ped_head_overlay(mp_ped, 2, math.random(-1, 33), math.random()) --eyebrows
    end

    ped.set_ped_eye_color(mp_ped, select(math.random(1, 8), 6, 5, 1, 3, 0, 7, 2, 4)) -- eye colors
    ped.set_ped_hair_colors(mp_ped, hb_randomizer["regular_hair_colors"], hb_randomizer["regular_hair_highlight_colors"]) -- hair colors
    ped.set_ped_head_overlay_color(mp_ped, 1, 1, hb_randomizer["regular_hair_colors"], hb_randomizer["regular_hair_highlight_colors"]) -- facial hair colors
    ped.set_ped_head_overlay_color(mp_ped, 2, 1, hb_randomizer["regular_hair_colors"], hb_randomizer["regular_hair_highlight_colors"]) -- eyebrow colors
    ped.set_ped_head_overlay(mp_ped, 3, math.random(-1, 14), math.random()) -- skin aging
end

function randomizeHairStyles(mp_ped)
    if (entity.get_entity_model_hash(mp_ped) == 2627665880) then
        local xyz = math.random(0, 80)
        if (xyz ~= 24) then
            ped.set_ped_component_variation(mp_ped, 2, xyz, 0, 0) --hair 
        end
    else
        local xyz = math.random(0, 76)
        if (xyz ~= 23) then
            ped.set_ped_component_variation(mp_ped, 2, xyz, 0, 0) --hair 
        end
    end
end

function extraFaceFeatures(mp_ped)
    --local xyz = {0.9, 0.7, 0.9, 0.0, 0.1, 0.1, 0.4, 0.8, 0.2, 0.0, 0.8, 0.3, 0.4, 0.8, 0.7, 0.3, 0.1, 0.3, 0.5, 0.5, 0.6, 1.0, 0.6, 0.5, 1.0, 0.4, 0.7, 0.9, 0.0, 0.6, 0.2, 0.2, 1.0}

    ped.set_ped_face_feature(mp_ped, 0, math.random()) -- nose width
    ped.set_ped_face_feature(mp_ped, 1, math.random()) -- nose height
    ped.set_ped_face_feature(mp_ped, 2, math.random()) -- nose length
    ped.set_ped_face_feature(mp_ped, 3, math.random()) -- nose bridge
    ped.set_ped_face_feature(mp_ped, 4, math.random()) -- nose tip
    ped.set_ped_face_feature(mp_ped, 5, math.random()) -- nose bridge shaft

    ped.set_ped_face_feature(mp_ped, 6, math.random()) -- brow height
    ped.set_ped_face_feature(mp_ped, 7, math.random()) -- brow width
    ped.set_ped_face_feature(mp_ped, 8, math.random()) -- cheekbone height
    ped.set_ped_face_feature(mp_ped, 9, math.random()) -- cheekbone width
    ped.set_ped_face_feature(mp_ped, 10, math.random()) -- cheek width

    ped.set_ped_face_feature(mp_ped, 11, math.random()) -- eyelids
    ped.set_ped_face_feature(mp_ped, 12, math.random()) -- lips
    ped.set_ped_face_feature(mp_ped, 13, math.random()) -- jaw width
    ped.set_ped_face_feature(mp_ped, 14, math.random()) -- jaw height

    ped.set_ped_face_feature(mp_ped, 15, math.random()) -- chin length
    ped.set_ped_face_feature(mp_ped, 16, math.random()) -- chin position
    ped.set_ped_face_feature(mp_ped, 17, math.random()) -- chin width
    ped.set_ped_face_feature(mp_ped, 18, math.random()) -- chin shape
    ped.set_ped_face_feature(mp_ped, 19, math.random()) -- neck width
end

function evenMoreExtraFeatures(player_ped)
    local xyz = {0.9, 0.7, 0.9, 0.0, 0.1, 0.1, 0.4, 0.8, 0.2, 0.0, 0.8, 0.3, 0.4, 0.8, 0.7, 0.3, 0.1, 0.3, 0.5, 0.5, 0.6, 1.0, 0.6, 0.5, 1.0, 0.4, 0.7, 0.9, 0.0, 0.6, 0.2, 0.2, 1.0}
    ped.set_ped_head_overlay(player_ped, 0, math.random(-1, 23), math.random()) -- Blemishes
    ped.set_ped_head_overlay(player_ped, 7, math.random(-1, 10), math.random()) -- Sun Damage
    ped.set_ped_head_overlay(player_ped, 9, math.random(-1, 17), math.random()) -- Freckles
    ped.set_ped_head_overlay(player_ped, 11, math.random(-1, 11), math.random()) -- Body Blemishes
end

function removeExtraFaceFeatures(mp_ped)
    ped.set_ped_face_feature(mp_ped, 0, 0) -- nose width
    ped.set_ped_face_feature(mp_ped, 1, 0) -- nose height
    ped.set_ped_face_feature(mp_ped, 2, 0) -- nose length
    ped.set_ped_face_feature(mp_ped, 3, 0) -- nose bridge
    ped.set_ped_face_feature(mp_ped, 4, 0) -- nose tip
    ped.set_ped_face_feature(mp_ped, 5, 0) -- nose bridge shaft

    ped.set_ped_face_feature(mp_ped, 6, 0) -- brow height
    ped.set_ped_face_feature(mp_ped, 7, 0) -- brow width
    ped.set_ped_face_feature(mp_ped, 8, 0) -- cheekbone height
    ped.set_ped_face_feature(mp_ped, 9, 0) -- cheekbone width
    ped.set_ped_face_feature(mp_ped, 10, 0) -- cheek width

    ped.set_ped_face_feature(mp_ped, 11, 0) -- eyelids
    ped.set_ped_face_feature(mp_ped, 12, 0) -- lips
    ped.set_ped_face_feature(mp_ped, 13, 0) -- jaw width
    ped.set_ped_face_feature(mp_ped, 14, 0) -- jaw height

    ped.set_ped_face_feature(mp_ped, 15, 0) -- chin length
    ped.set_ped_face_feature(mp_ped, 16, 0) -- chin position
    ped.set_ped_face_feature(mp_ped, 17, 0) -- chin width
    ped.set_ped_face_feature(mp_ped, 18, 0) -- chin shape
    ped.set_ped_face_feature(mp_ped, 19, 0) -- neck width

    ped.set_ped_head_overlay(mp_ped, 0, 0, 0) -- Blemishes
    ped.set_ped_head_overlay(mp_ped, 7, 0, 0) -- Sun Damage
    ped.set_ped_head_overlay(mp_ped, 9, 0, 0) -- Freckles
    ped.set_ped_head_overlay(mp_ped, 11, 0, 0) -- Body Blemishes
end

function animalAI(animal, player_id, anim_dict, anim_string, toggle)
    local pos = entity.get_entity_coords(animal)
    local world_pos1 = player.get_player_coords(player_id) + 5
    local world_pos2 = player.get_player_coords(player_id) - 5
    if (pos.x <= world_pos1.x) and (pos.y <= world_pos1.y) and (pos.z <= world_pos1.z) and (pos.x >= world_pos2.x) and (pos.y >= world_pos2.y) and (pos.z >= world_pos2.z) then
        if toggle then
            ai.stop_anim_task(animal, anim_dict, anim_string, 1.0)
            ai.task_go_to_coord_by_any_means(animal, player.get_player_coords(player_id) + v3(math.random(-4, 4), math.random(-4, 4), 0), 1, 0, true, 1, 0.0)
        elseif not toggle then
            ai.task_play_anim(animal, anim_dict, anim_string, 8.0, 0, -1, 9, 0, false, false, false)
        end
    else
        ai.task_goto_entity(animal, player.get_player_ped(player_id), -1, -1, 25.0)
    end
end