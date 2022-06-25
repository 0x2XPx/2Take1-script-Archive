local function Get_Distance_Between_Coords(first, second)
    local x = second.x - first.x
    local y = second.y - first.y
    local z = second.z - first.z
    return math.sqrt(x * x + y * y + z * z)
end

function silent_aimbot_ped()      
    local peds = ped.get_all_peds()

    for i =1, #peds do
        if Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), entity.get_entity_coords(peds[i])) <= 50 then
            if entity.is_entity_visible(peds[i]) and ped.get_ped_health(peds[i]) > 0 and player.get_player_ped(player.player_id()) ~= peds[i] then
                local rtrn, pos = ped.get_ped_bone_coords(peds[i], 0x796e, v3(0.01, 0, 0))
                local rtrn1, pos1 = ped.get_ped_bone_coords(peds[i], 0x796e, v3(-0.01, 0, 0))
                
                if rtrn and rtrn1 then
                    --gameplay.shoot_single_bullet_between_coords(pos, pos1, 1, 1198256469, player.get_player_ped(player.player_id()), true, false, 1000)
                    gameplay.shoot_single_bullet_between_coords(pos + v3(0,-10,0), pos1, 10000.00, 205991906, player.get_player_ped(player.player_id()), true, false, 10000.0)
                end
            end 
        end
    end
end

function silent_aimbot_player()      
    for i =1, 31 do
        if Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), player.get_player_coords(i)) <= 50 then
            if entity.is_entity_visible(player.get_player_ped(i)) and player.get_player_health(i) > 0 then
                local rtrn, pos = ped.get_ped_bone_coords(player.get_player_ped(i), 0x796e, v3(0.01, 0, 0))
                local rtrn1, pos1 = ped.get_ped_bone_coords(player.get_player_ped(i), 0x796e, v3(-0.01, 0, 0))
                
                if rtrn and rtrn1 then
                    --gameplay.shoot_single_bullet_between_coords(pos, pos1, 1, 1198256469, player.get_player_ped(player.player_id()), true, false, 1000)
                    gameplay.shoot_single_bullet_between_coords(pos + v3(0,-10,0), pos1, 10000.00, 205991906, player.get_player_ped(player.player_id()), true, false, 10000.0)
                end
            end 
        end
    end
end