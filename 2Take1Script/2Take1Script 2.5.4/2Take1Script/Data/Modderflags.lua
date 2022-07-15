local customflags = {
    {'Remembered', 8388608},
    {'Modded Health', 16777216},
    {'Modded Armor', 33554432},
    {'Vehicle Godmode', 67108864},
    {'Modded Off The Radar', 134217728},
    {'Modded Script Event', 268435456},
    {'Max Speed Bypass', 536870912},
    {'Player Godmode', 1073741824}
}

function customflags.Load()
    for i = 1, #customflags do
        customflags[i][2] = 1
        while #player.get_modder_flag_text(customflags[i][2]) > 0 do
            customflags[i][2] = customflags[i][2] << 1
        end
        customflags[i][2] = player.add_modder_flag(customflags[i][1])
    end
end

return customflags