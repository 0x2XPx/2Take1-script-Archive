function wipeOutfitsClean(mp_ped)
    local hair = ped.get_ped_drawable_variation(mp_ped, 2)
    local hair_tex = ped.get_ped_texture_variation(mp_ped, 2)

    ped.set_ped_component_variation(mp_ped, 1, 0, 0, 0) -- masks
    ped.set_ped_component_variation(mp_ped, 11, 0, 0, 0) -- tops
    ped.set_ped_component_variation(mp_ped, 4, 0, 0, 0) -- legs
    ped.set_ped_component_variation(mp_ped, 9, 0, 0, 0) -- vests
    ped.set_ped_component_variation(mp_ped, 2, hair, hair_tex, 0) -- hair
    ped.set_ped_component_variation(mp_ped, 8, 15, 0, 0) -- underhsirts
    ped.set_ped_component_variation(mp_ped, 3, 0, 0, 0) -- torso
    ped.set_ped_component_variation(mp_ped, 7, 0, 0, 0) -- accessories
    if (entity.get_entity_model_hash(mp_ped) == 2627665880) then
        ped.set_ped_component_variation(mp_ped, 6, 35, 0, 0) -- feet
    else
        ped.set_ped_component_variation(mp_ped, 6, 34, 0, 0) -- feet
    end
    ped.clear_all_ped_props(mp_ped)
end

function randomTuxedoOutfit(mp_ped)
    local random_shoes = {
        dress_shoes_male1 = select(math.random(1, 2), 0, 3),
        dress_shoes_male2 = select(math.random(1, 4), 10, 0, 9, 2)
    }

    if (entity.get_entity_model_hash(mp_ped) == 2627665880) then
        ped.set_ped_component_variation(mp_ped, 3, 3, 0, 0) -- torsos
        ped.set_ped_component_variation(mp_ped, 11, 305, select(math.random(1, 6), 0, 1, 2, 4, 5, 6), 0) -- tops
        ped.set_ped_component_variation(mp_ped, 8, math.random(216, 217), select(math.random(1, 8), 0, 1, 2, 4, 6, 10, 13, 17), 0) -- underhsirts
        ped.set_ped_component_variation(mp_ped, 7, select(math.random(1, 2), 0, 22), select(math.random(1, 5), 0, 1, 2, 6, 12), 0) -- accessories
        ped.set_ped_component_variation(mp_ped, 4, 133, select(math.random(1, 7), 0, 1, 3, 8, 17, 23, 24), 0) -- legs
        ped.set_ped_component_variation(mp_ped, 6, select(math.random(1, 3), 6, 13, 15), 0, 0) -- feet
    else
        ped.set_ped_component_variation(mp_ped, 3, 4, 0, 0) -- torsos
        ped.set_ped_component_variation(mp_ped, 11, 23, select(math.random(1, 3), 0, 1, 3), 0) -- tops
        ped.set_ped_component_variation(mp_ped, 8, 10, select(math.random(1, 7), 0, 1, 2, 3, 5, 6, 10), 0) -- underhsirts
        ped.set_ped_component_variation(mp_ped, 7, select(math.random(1, 2), 0, 21), select(math.random(1, 3), 9, 10, 11), 0) -- accessories
        ped.set_ped_component_variation(mp_ped, 4, 28, select(math.random(1, 8), 0, 3, 4, 5, 6, 8, 10, 11), 0) -- legs
        local xyz = math.random(1, 3)
        if (xyz == 1) then
            ped.set_ped_component_variation(mp_ped, 6, 10, 0, 0) -- feet
        elseif (xyz == 2) then
            ped.set_ped_component_variation(mp_ped, 6, 20, random_shoes["dress_shoes_male1"], 0) -- feet
        elseif (xyz == 3) then
            ped.set_ped_component_variation(mp_ped, 6, 21, random_shoes["dress_shoes_male2"], 0) -- feet
        end
    end
end

function randomTropicalOutfit(mp_ped)
    if (entity.get_entity_model_hash(mp_ped) == 2627665880) then
        ped.set_ped_component_variation(mp_ped, 3, 11, 0, 0) -- torsos
        ped.set_ped_component_variation(mp_ped, 11, 269, math.random(0, 25), 0) -- tops
        ped.set_ped_component_variation(mp_ped, 4, 137, math.random(0, 15), 0) -- legs
        
        if (math.random(0, 15) == 5) then
            ped.set_ped_component_variation(mp_ped, 6, 35, 0, 0) -- feet
        else
            ped.set_ped_component_variation(mp_ped, 6, select(math.random(1, 2), 15, 16), math.random(0, 11), 0) -- feet
        end
    else
        ped.set_ped_component_variation(mp_ped, 3, 0, 0, 0) -- torsos
        ped.set_ped_component_variation(mp_ped, 11, 260, math.random(0, 25), 0) -- tops
        ped.set_ped_component_variation(mp_ped, 4, 15, math.random(0, 15), 0) -- legs

        if (math.random(0, 15) == 5) then
            ped.set_ped_component_variation(mp_ped, 6, 34, 0, 0) -- feet
        else
            ped.set_ped_component_variation(mp_ped, 6, 16, math.random(0, 11), 0) -- feet
        end
    end
end

function randomGolferOutfit(mp_ped)
    if (entity.get_entity_model_hash(mp_ped) == 2627665880) then
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 3, 14, 0, 0) -- torsos
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 11, math.random(400, 401), math.random(0, 7), 0) -- tops
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 4, 137, math.random(0, 15), 0) -- legs
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 6, 103, math.random(0, 23), 0) -- feet
    else
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 3, 0, 0, 0) -- torsos
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 11, math.random(382, 383), math.random(0, 7), 0) -- tops
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 4, 12, select(math.random(1, 5), 0, 4, 5, 7, 12), 0) -- legs
        ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 6, 99, math.random(0, 23), 0) -- feet
    end
end

function randomBeachOutfit(mp_ped)
    if (entity.get_entity_model_hash(mp_ped) == 2627665880) then
        
        local random_bikini = {
        bikini1 = select(math.random(1, 4), 0, 3, 10, 11),
        bikini2 = math.random(0, 11)
        }
        
        ped.set_ped_component_variation(mp_ped, 3, 15, 0, 0) -- torsos
        ped.set_ped_component_variation(mp_ped, 8, 14, 0, 0) -- underhsirts

        if (math.random(1, 2) == 1) then
            ped.set_ped_component_variation(mp_ped, 11, 15, random_bikini["bikini1"], 0) -- tops
            ped.set_ped_component_variation(mp_ped, 4, 15, random_bikini["bikini1"], 0) -- legs
        else
            ped.set_ped_component_variation(mp_ped, 11, 18, random_bikini["bikini2"], 0) -- tops
            ped.set_ped_component_variation(mp_ped, 4, 17, random_bikini["bikini2"], 0) -- legs
        end

        if (math.random(0, 15) == 5) then
            ped.set_ped_component_variation(mp_ped, 6, 35, 0, 0) -- feet
        else
            ped.set_ped_component_variation(mp_ped, 6, select(math.random(1, 2), 15, 16), math.random(0, 11), 0) -- feet
        end
    else
        ped.set_ped_component_variation(mp_ped, 3, 15, 0, 0) -- torsos
        ped.set_ped_component_variation(mp_ped, 11, 15, 0, 0)
        ped.set_ped_component_variation(mp_ped, 4, 15, math.random(0, 15), 0) -- legs

        if (math.random(0, 15) == 5) then
            ped.set_ped_component_variation(mp_ped, 6, 34, 0, 0) -- feet
        else
            ped.set_ped_component_variation(mp_ped, 6, 16, math.random(0, 11), 0) -- feet
        end
    end
end

function copyPlayerOutfitToClone(player_ped, clone_ped)
    local plyr_clothes = {
        player_mask = ped.get_ped_drawable_variation(player_ped, 1),
        player_top = ped.get_ped_drawable_variation(player_ped, 11),
        player_legs = ped.get_ped_drawable_variation(player_ped, 4),
        player_vest = ped.get_ped_drawable_variation(player_ped, 9),
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
    ped.set_ped_component_variation(clone_ped, 8, plyr_clothes["player_undershirts"], plyr_cloth_tex["player_undershirts_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 3, plyr_clothes["player_torso"], plyr_cloth_tex["player_torso_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 7, plyr_clothes["player_accessories"], plyr_cloth_tex["player_accessories_tex"], 0)
    ped.set_ped_component_variation(clone_ped, 6, plyr_clothes["player_feet"], plyr_cloth_tex["player_feet_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 0, plyr_clothes["player_hats"], plyr_cloth_tex["player_hats_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 1, plyr_clothes["player_glasses"], plyr_cloth_tex["player_glasses_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 2, plyr_clothes["player_ears"], plyr_cloth_tex["player_ears_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 6, plyr_clothes["player_watches"], plyr_cloth_tex["player_watches_tex"], 0)
    ped.set_ped_prop_index(clone_ped, 7, plyr_clothes["player_bracelets"], plyr_cloth_tex["player_bracelets_tex"], 0)
end

function barefoot(self_id, player_ped)
    if (player.is_player_female(self_id)) then
        ped.set_ped_component_variation(player_ped, 6, 35, 0, 0) -- feet
    else
        ped.set_ped_component_variation(player_ped, 6, 34, 0, 0) -- feet
    end
end