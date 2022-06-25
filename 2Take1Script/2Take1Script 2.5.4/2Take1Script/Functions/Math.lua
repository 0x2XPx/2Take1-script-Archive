local Math = {}

function Math.TimePrefix()
    local t = os.date('*t')

    if t.month < 10 then
        t.month = '0' .. t.month
    end

    if t.day < 10 then
        t.day = '0' .. t.day
    end

    if t.hour < 10 then
        t.hour = '0' .. t.hour
    end

    if t.min < 10 then
        t.min = '0' .. t.min
    end

    if t.sec < 10 then
        t.sec = '0' .. t.sec
    end

    return '[' .. t.year .. '-' .. t.month .. '-' .. t.day .. ' ' .. t.hour .. ':' .. t.min .. ':' .. t.sec .. ']'
end

function Math.RGBAToInt(Red, Green, Blue, Alpha)
    Alpha = Alpha or 255
    return ((Red&0x0ff)<<0x00)|((Green&0x0ff)<<0x08)|((Blue&0x0ff)<<0x10)|((Alpha&0x0ff)<<0x18)
end

function Math.RGBToHex(rgb)
    local hexadecimal = '0X'

    for key, value in pairs(rgb) do
        local hex = ''

        while value > 0 do
            local index = math.fmod(value, 16) + 1
            value = math.floor(value / 16)
            hex = string.sub('0123456789ABCDEF', index, index) .. hex
        end

        if string.len(hex) == 0 then
            hex = '00'
        elseif string.len(hex) == 1 then
            hex = '0' .. hex
        end

        hexadecimal = hexadecimal .. hex
    end

    return hexadecimal
end

function Math.DecToHex(dec)
    return string.format('%0X', dec)
end

function Math.DecToHex2(number)
    return string.format('%02X', number)
end

function Math.HexToDec(hex)
    return tonumber(hex, 16)
end

function Math.ToInt(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

function Math.Round(num, dp)
    local mult = 10^(dp or 0)
    return math.floor(num * mult + 0.5)/mult
end

function Math.GetGroundZ(CoordX, CoordY, Height)
    Height = Height or 800
    local Success, Ground = gameplay.get_ground_z(v3(CoordX, CoordY, Height))
    while not Success do
        Height = Height - 5
        Success, Ground = gameplay.get_ground_z(v3(CoordX, CoordY, Height))
        if Height < -200 then
            Height = -200
            Success = true
        end
    end
    return Ground
end

function Math.GetPedBoneCoords(Ped, Bone, Coord)
    Coord = Coord or v3()
    local Success, Pos_h = ped.get_ped_bone_coords(Ped, Bone, Coord)
    while not Success do
        system.wait(0)
        Success, Pos_h = ped.get_ped_bone_coords(Ped, Bone, Coord)
    end
    return Pos_h
end

function Math.SetIntStat(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash, hash
    if prefix then
        hash0 = 'MP0_' .. hash
        hash1 = 'MP1_' .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_int(hash0, -1)
    if value0 ~= value then
        stats.stat_set_int(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_int(hash1, -1)
        if value1 ~= value then
            stats.stat_set_int(hash1, value, save)
        end
    end
end
function Math.SetFloatStat(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash, hash
    if prefix then
        hash0 = 'MP0_' .. hash
        hash1 = 'MP1_' .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_float(hash0, -1)
    if value0 ~= value then
        stats.stat_set_float(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_float(hash1, -1)
        if value1 ~= value then
            stats.stat_set_float(hash1, value, save)
        end
    end
end

return Math