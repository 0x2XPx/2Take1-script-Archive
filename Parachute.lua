menu.add_feature("Infinite Parachute", "toggle", 0, function(f)
    while f.on do
        system.yield(250)
        if not weapon.has_ped_got_weapon(player.get_player_ped(player.player_id()), gameplay.get_hash_key("gadget_parachute")) then
            weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), gameplay.get_hash_key("gadget_parachute"), 0, false)
        end
    end
end)