-- Welcome to Heist Control -- v2.2.0
-- Do no contact me if you tried to edit something and the script stopped working --
-- Feel free to edit, make some improvements, translate and add more functions -- 
-- Made by jhowkNx "jkNX" - from 2TAKE1 Menu --
-- Any suggestion you can contact me here: 
-- https://github.com/jhowkNx/Heist-Control-v2









-- Script Main Function --

local function stat_set_int(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
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

local function stat_set_bool(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_bool(hash0, -1)
    if value0 ~= value then
        stats.stat_set_bool(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_bool(hash1, -1)
        if value1 ~= value then
            stats.stat_set_bool(hash1, value, save)
        end
    end
end

-- IMPORTANT THNGSS --

local HC2_MAIN = menu.add_feature("::: Heist Control v2", "parent", 0, function()
end)

local CPMN = menu.add_feature("# Cayo Perico Heist", "parent", HC2_MAIN.id)

local MNCP_ = menu.add_feature("# Insta-Play (Presets)", "parent", CPMN.id)

local CPPR = menu.add_feature("# Normal Presets ($2.5mi)", "parent", MNCP_.id)

local MNCP_EV_ = menu.add_feature("(!) Weekly Event Presets ($4.1mi)", "parent", MNCP_.id)

local CHMN = menu.add_feature("# Diamond Casino Heist", "parent", HC2_MAIN.id)

local DHMN = menu.add_feature("# Doomsday Heist", "parent", HC2_MAIN.id)

local DDPR = menu.add_feature("# Insta-Play (Presets)", "parent", DHMN.id)

local HHMN = menu.add_feature("# High-End Apartment Heist", "parent", HC2_MAIN.id)

local MSC = menu.add_feature("# Misc", "parent", HC2_MAIN.id)

local MUMN = menu.add_feature("# Master Unlocker", "parent", MSC.id)

-- 1:CLICK REGION
-- SOLO METHOD REGION 1:CLICK
do
----
local FCP_SET_SOLO_METHOD_0_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 124271},
    {"H4LOOT_CASH_V", 474431},
    {"H4LOOT_COKE_V", 948863},
    {"H4LOOT_GOLD_V", 1265151},
    {"H4LOOT_PAINT_V", 948863},
    {"H4LOOT_WEED_V", 759090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 125}
}

local FCP_SET_SOLO_METHOD_0_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_GOLD_V", 1198484},
    {"H4LOOT_PAINT_V", 898863},
    {"H4LOOT_WEED_V", 719090},
    {"H4LOOT_CASH_V", 449431},
    {"H4LOOT_COKE_V", 898863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_SOLO_METHOD_0_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_GOLD_V", 1131817},
    {"H4LOOT_PAINT_V", 848863},
    {"H4LOOT_WEED_V", 679090},
    {"H4LOOT_CASH_V", 424431},
    {"H4LOOT_COKE_V", 848863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_SOLO_METHOD_0_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_GOLD_V", 998484},
    {"H4LOOT_PAINT_V", 748863},
    {"H4LOOT_WEED_V", 599090},
    {"H4LOOT_CASH_V", 374431},
    {"H4LOOT_COKE_V", 748863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}

}

local FCP_SET_SOLO_METHOD_0_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_GOLD_V", 1131817},
    {"H4LOOT_PAINT_V", 848863},
    {"H4LOOT_WEED_V", 679090},
    {"H4LOOT_CASH_V", 424431},
    {"H4LOOT_COKE_V", 848863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}

}

local FCP_SET_SOLO_METHOD_0_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_GOLD_V", 598484},
    {"H4LOOT_PAINT_V", 448863},
    {"H4LOOT_WEED_V", 359090},
    {"H4LOOT_CASH_V", 224431},
    {"H4LOOT_COKE_V", 448863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}

}
-- END SOLO METHOD 1:CLICK - NO EVENT

-- SOLO METHOD (HARD) :1CLICK - NO EVENT

local FCP_SET_SOLO_METHOD_H0_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_GOLD_V", 1205151},
    {"H4LOOT_PAINT_V", 903863},
    {"H4LOOT_WEED_V", 723090},
    {"H4LOOT_CASH_V", 451931},
    {"H4LOOT_COKE_V", 903863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_SOLO_METHOD_H0_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_GOLD_V", 1131817},
    {"H4LOOT_PAINT_V", 848863},
    {"H4LOOT_WEED_V", 679090},
    {"H4LOOT_CASH_V", 424431},
    {"H4LOOT_COKE_V", 848863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_SOLO_METHOD_H0_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_GOLD_V", 1058484},
    {"H4LOOT_PAINT_V", 793863},
    {"H4LOOT_WEED_V", 635090},
    {"H4LOOT_CASH_V", 396931},
    {"H4LOOT_COKE_V", 793863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_SOLO_METHOD_H0_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_GOLD_V", 911817},
    {"H4LOOT_PAINT_V", 683863},
    {"H4LOOT_WEED_V", 547090},
    {"H4LOOT_CASH_V", 341931},
    {"H4LOOT_COKE_V", 683863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}

}

local FCP_SET_SOLO_METHOD_H0_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_GOLD_V", 1058484},
    {"H4LOOT_PAINT_V", 793863},
    {"H4LOOT_WEED_V", 635090},
    {"H4LOOT_CASH_V", 396931},
    {"H4LOOT_COKE_V", 793863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}

}

local FCP_SET_SOLO_METHOD_H0_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_GOLD_V", 471817},
    {"H4LOOT_PAINT_V", 353863},
    {"H4LOOT_WEED_V", 283090},
    {"H4LOOT_CASH_V", 176931},
    {"H4LOOT_COKE_V", 353863},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

-- END SOLO METHOD 1:CLICK

-- MENU SOLO METHOD
local SOLO0 = menu.add_feature("# SOLO", "parent", CPPR.id)

menu.add_feature("# Sinsimito Tequila : $900,000 (Normal)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_0_TQL do
        stat_set_int(FCP_SET_SOLO_METHOD_0_TQL[i][1], true, FCP_SET_SOLO_METHOD_0_TQL[i][2])
    end
end)

menu.add_feature("# Sinsimito Tequila : $990,000 (Hard)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_H0_TQL do
    stat_set_int(FCP_SET_SOLO_METHOD_H0_TQL[i][1], true, FCP_SET_SOLO_METHOD_H0_TQL[i][2])
    end
end)
-- 
menu.add_feature("# Ruby Necklace : $1,000,000 (Normal)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_0_RBY do
    stat_set_int(FCP_SET_SOLO_METHOD_0_RBY[i][1], true, FCP_SET_SOLO_METHOD_0_RBY[i][2])
end
end)

menu.add_feature("# Ruby Necklace : $1,100,000 (Hard)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_H0_RBY do
    stat_set_int(FCP_SET_SOLO_METHOD_H0_RBY[i][1], true, FCP_SET_SOLO_METHOD_H0_RBY[i][2])
end
end)
--
menu.add_feature("# Bearer Bonds : $1,100,000 (Normal)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_0_BRB do
    stat_set_int(FCP_SET_SOLO_METHOD_0_BRB[i][1], true, FCP_SET_SOLO_METHOD_0_BRB[i][2])
end
end)

menu.add_feature("# Bearer Bonds : $1,210,000 (Hard)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_H0_BRB do
    stat_set_int(FCP_SET_SOLO_METHOD_H0_BRB[i][1], true, FCP_SET_SOLO_METHOD_H0_BRB[i][2])
end
end)
--
menu.add_feature("# Minimadrazzo Files : $1,100,000 (Normal)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_0_MMF do
    stat_set_int(FCP_SET_SOLO_METHOD_0_MMF[i][1], true, FCP_SET_SOLO_METHOD_0_MMF[i][2])
    end
    end)

menu.add_feature("# Minimadrazzo Files : $1,210,000 (Hard)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_H0_MMF do
    stat_set_int(FCP_SET_SOLO_METHOD_H0_MMF[i][1], true, FCP_SET_SOLO_METHOD_H0_MMF[i][2])
end
end)
--
menu.add_feature("# Pink Diamond : $1,300,000 (Normal)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout limit: ~g~$2.550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_0_PKD do
    stat_set_int(FCP_SET_SOLO_METHOD_0_PKD[i][1], true, FCP_SET_SOLO_METHOD_0_PKD[i][2])
end
end)

menu.add_feature("# Pink Diamond : $1,430,000 (Hard)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout limit: ~g~$2.550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_H0_PKD do
    stat_set_int(FCP_SET_SOLO_METHOD_H0_PKD[i][1], true, FCP_SET_SOLO_METHOD_H0_PKD[i][2])
end
end)
--
menu.add_feature("# Panther Statue : $1,900,000 (Normal)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_SOLO_METHOD_0_PTS do
stat_set_int(FCP_SET_SOLO_METHOD_0_PTS[i][1], true, FCP_SET_SOLO_METHOD_0_PTS[i][2])
end
end)

menu.add_feature("# Panther Statue : $2,090,000 (Hard)", "action", SOLO0.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_SOLO_METHOD_H0_PTS do
stat_set_int(FCP_SET_SOLO_METHOD_H0_PTS[i][1], true, FCP_SET_SOLO_METHOD_H0_PTS[i][2])
end
end)
end

--
do
-- 2P METHOD NORMAL - NO EVENT
local FCP_SET_2P_METHOD_0_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 599431},
    {"H4LOOT_COKE_V", 1198863},
    {"H4LOOT_GOLD_V", 1598484},
    {"H4LOOT_PAINT_V", 1198863},
    {"H4LOOT_WEED_V", 959090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_0_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 586931},
    {"H4LOOT_COKE_V", 1173863},
    {"H4LOOT_GOLD_V", 1565151},
    {"H4LOOT_PAINT_V", 1173863},
    {"H4LOOT_WEED_V", 939090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_0_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 574431},
    {"H4LOOT_COKE_V", 1148863},
    {"H4LOOT_GOLD_V", 1531817},
    {"H4LOOT_PAINT_V", 1148863},
    {"H4LOOT_WEED_V", 919090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_0_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 549431},
    {"H4LOOT_COKE_V", 1098863},
    {"H4LOOT_GOLD_V", 1465151},
    {"H4LOOT_PAINT_V", 1098863},
    {"H4LOOT_WEED_V", 879090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_0_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 574431},
    {"H4LOOT_COKE_V", 1148863},
    {"H4LOOT_GOLD_V", 1531817},
    {"H4LOOT_PAINT_V", 1148863},
    {"H4LOOT_WEED_V", 919090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_0_PTS = {
    
    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 474431},
    {"H4LOOT_COKE_V", 948863},
    {"H4LOOT_GOLD_V", 1265151},
    {"H4LOOT_PAINT_V", 948863},
    {"H4LOOT_WEED_V", 759090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

-- 2P METHODS HARD - NO EVENT

local FCP_SET_2P_METHOD_H0_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 588181},
    {"H4LOOT_COKE_V", 1176363},
    {"H4LOOT_GOLD_V", 1568484},
    {"H4LOOT_PAINT_V", 1176363},
    {"H4LOOT_WEED_V", 941090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H0_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 574431},
    {"H4LOOT_COKE_V", 1148863},
    {"H4LOOT_GOLD_V", 1531817},
    {"H4LOOT_PAINT_V", 1148863},
    {"H4LOOT_WEED_V", 919090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H0_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 560681},
    {"H4LOOT_COKE_V", 1121363},
    {"H4LOOT_GOLD_V", 1495151},
    {"H4LOOT_PAINT_V", 1121363},
    {"H4LOOT_WEED_V", 897090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H0_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 533181},
    {"H4LOOT_COKE_V", 1066363},
    {"H4LOOT_GOLD_V", 1421817},
    {"H4LOOT_PAINT_V", 1066363},
    {"H4LOOT_WEED_V", 853090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H0_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 560681},
    {"H4LOOT_COKE_V", 1121363},
    {"H4LOOT_GOLD_V", 1495151},
    {"H4LOOT_PAINT_V", 1121363},
    {"H4LOOT_WEED_V", 897090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H0_PTS = {
    
    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 450681},
    {"H4LOOT_COKE_V", 901363},
    {"H4LOOT_GOLD_V", 1201817},
    {"H4LOOT_PAINT_V", 901363},
    {"H4LOOT_WEED_V", 721090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}


local MNCP_D20 = menu.add_feature("# 2 Players (50% each one: $2.5mi)", "parent", CPPR.id)

menu.add_feature("# Sinsimito Tequila : $900,000 (Normal)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_0_TQL do
    stat_set_int(FCP_SET_2P_METHOD_0_TQL[i][1], true, FCP_SET_2P_METHOD_0_TQL[i][2])
end
end)

menu.add_feature("# Sinsimito Tequila : $990,000 (Hard)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_H0_TQL do
    stat_set_int(FCP_SET_2P_METHOD_H0_TQL[i][1], true, FCP_SET_2P_METHOD_H0_TQL[i][2])
end
end)
--
menu.add_feature("# Ruby Necklace : $1,000,000 (Normal)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_0_RBY do
stat_set_int(FCP_SET_2P_METHOD_0_RBY[i][1], true, FCP_SET_2P_METHOD_0_RBY[i][2])
end
end)

menu.add_feature("# Ruby Necklace : $1,100,000 (Hard)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_H0_RBY do
stat_set_int(FCP_SET_2P_METHOD_H0_RBY[i][1], true, FCP_SET_2P_METHOD_H0_RBY[i][2])
end
end)
--
menu.add_feature("# Bearer Bonds : $1,100,000 (Normal)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_0_BRB do
        stat_set_int(FCP_SET_2P_METHOD_0_BRB[i][1], true, FCP_SET_2P_METHOD_0_BRB[i][2])
end
end)

menu.add_feature("# Bearer Bonds : $1,210,000 (Hard)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_H0_BRB do
        stat_set_int(FCP_SET_2P_METHOD_H0_BRB[i][1], true, FCP_SET_2P_METHOD_H0_BRB[i][2])
end
end)
--
menu.add_feature("# Minimadrazzo Files : $1,100,000 (Normal)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_0_MMF do
    stat_set_int(FCP_SET_2P_METHOD_0_MMF[i][1], true, FCP_SET_2P_METHOD_0_MMF[i][2])
end
end)

menu.add_feature("# Minimadrazzo Files : $1,210,000 (Hard)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_H0_MMF do
    stat_set_int(FCP_SET_2P_METHOD_H0_MMF[i][1], true, FCP_SET_2P_METHOD_H0_MMF[i][2])
end
end)
--
menu.add_feature("# Pink Diamond : $1,300,000 (Normal)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_0_PKD do
stat_set_int(FCP_SET_2P_METHOD_0_PKD[i][1], true, FCP_SET_2P_METHOD_0_PKD[i][2])
end
end)

menu.add_feature("# Pink Diamond : $1,430,000 (Hard)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_H0_PKD do
stat_set_int(FCP_SET_2P_METHOD_H0_PKD[i][1], true, FCP_SET_2P_METHOD_H0_PKD[i][2])
end
end)
--
menu.add_feature("# Panther Statue : $1,900,000 (Normal)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_0_PTS do
    stat_set_int(FCP_SET_2P_METHOD_0_PTS[i][1], true, FCP_SET_2P_METHOD_0_PTS[i][2])
end
end)

menu.add_feature("# Panther Statue : $2,090,000 (Hard)", "action", MNCP_D20.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_H0_PTS do
    stat_set_int(FCP_SET_2P_METHOD_H0_PTS[i][1], true, FCP_SET_2P_METHOD_H0_PTS[i][2])
end
end)

end

---- NEW 2P METHOD ((()))
do 

local TWOPLAYRS_TEQL_NRM_0 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 301136},
    {"H4LOOT_COKE_V", 602272},
    {"H4LOOT_GOLD_V", 803029},
    {"H4LOOT_PAINT_V", 602272},
    {"H4LOOT_WEED_V", 481818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_RBY_NRM_0 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 288636},
    {"H4LOOT_COKE_V", 577272},
    {"H4LOOT_GOLD_V", 769696},
    {"H4LOOT_PAINT_V", 577272},
    {"H4LOOT_WEED_V", 461818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_BRB_NRM_0 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 276136},
    {"H4LOOT_COKE_V", 552272},
    {"H4LOOT_GOLD_V", 736363},
    {"H4LOOT_PAINT_V", 552272},
    {"H4LOOT_WEED_V", 441818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_PDM_NRM_0 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 251136},
    {"H4LOOT_COKE_V", 502272},
    {"H4LOOT_GOLD_V", 669696},
    {"H4LOOT_PAINT_V", 502272},
    {"H4LOOT_WEED_V", 401818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_MMF_NRM_0 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 276136},
    {"H4LOOT_COKE_V", 552272},
    {"H4LOOT_GOLD_V", 736363},
    {"H4LOOT_PAINT_V", 552272},
    {"H4LOOT_WEED_V", 441818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_PP_NRM_0 = {
    
    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 176136},
    {"H4LOOT_COKE_V", 352272},
    {"H4LOOT_GOLD_V", 469696},
    {"H4LOOT_PAINT_V", 352272},
    {"H4LOOT_WEED_V", 281818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

-- HARD 

local TWOPLAYRS_TEQL_NRM_1 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 289886},
    {"H4LOOT_COKE_V", 579772},
    {"H4LOOT_GOLD_V", 773029},
    {"H4LOOT_PAINT_V", 579772},
    {"H4LOOT_WEED_V", 463818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_RBY_NRM_1 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 276136},
    {"H4LOOT_COKE_V", 552272},
    {"H4LOOT_GOLD_V", 736363},
    {"H4LOOT_PAINT_V", 552272},
    {"H4LOOT_WEED_V", 441818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_BRB_NRM_1 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 262386},
    {"H4LOOT_COKE_V", 524772},
    {"H4LOOT_GOLD_V", 699696},
    {"H4LOOT_PAINT_V", 524772},
    {"H4LOOT_WEED_V", 419818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_PDM_NRM_1 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 234886},
    {"H4LOOT_COKE_V", 469772},
    {"H4LOOT_GOLD_V", 626363},
    {"H4LOOT_PAINT_V", 469772},
    {"H4LOOT_WEED_V", 375818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_MMF_NRM_1 = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 262386},
    {"H4LOOT_COKE_V", 524772},
    {"H4LOOT_GOLD_V", 699696},
    {"H4LOOT_PAINT_V", 524772},
    {"H4LOOT_WEED_V", 419818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local TWOPLAYRS_PP_NRM_1 = {
    
    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 152386},
    {"H4LOOT_COKE_V", 304772},
    {"H4LOOT_GOLD_V", 406363},
    {"H4LOOT_PAINT_V", 304772},
    {"H4LOOT_WEED_V", 243818},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}


local NEW_METHOD_2PLYRs = menu.add_feature("# 2 Players (Host: 15% - Player2: 85%: $2.5mi)", "parent", CPPR.id)

menu.add_feature("# Sinsimito Tequila : $900,000 (Normal)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
for i = 1, #TWOPLAYRS_TEQL_NRM_0 do
    stat_set_int(TWOPLAYRS_TEQL_NRM_0[i][1], true, TWOPLAYRS_TEQL_NRM_0[i][2])
end
end)

menu.add_feature("# Sinsimito Tequila : $990,000 (Hard)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
for i = 1, #TWOPLAYRS_TEQL_NRM_1 do
    stat_set_int(TWOPLAYRS_TEQL_NRM_1[i][1], true, TWOPLAYRS_TEQL_NRM_1[i][2])
end
end)
--
menu.add_feature("# Ruby Necklace : $1,000,000 (Normal)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
for i = 1, #TWOPLAYRS_RBY_NRM_0 do
stat_set_int(TWOPLAYRS_RBY_NRM_0[i][1], true, TWOPLAYRS_RBY_NRM_0[i][2])
end
end)

menu.add_feature("# Ruby Necklace : $1,100,000 (Hard)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
for i = 1, #TWOPLAYRS_RBY_NRM_1 do
stat_set_int(TWOPLAYRS_RBY_NRM_1[i][1], true, TWOPLAYRS_RBY_NRM_1[i][2])
end
end)
--
menu.add_feature("# Bearer Bonds : $1,100,000 (Normal)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
    for i = 1, #TWOPLAYRS_BRB_NRM_0 do
        stat_set_int(TWOPLAYRS_BRB_NRM_0[i][1], true, TWOPLAYRS_BRB_NRM_0[i][2])
end
end)

menu.add_feature("# Bearer Bonds : $1,210,000 (Hard)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
    for i = 1, #TWOPLAYRS_BRB_NRM_1 do
        stat_set_int(TWOPLAYRS_BRB_NRM_1[i][1], true, TWOPLAYRS_BRB_NRM_1[i][2])
end
end)
--
menu.add_feature("# Minimadrazzo Files : $1,100,000 (Normal)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
    for i = 1, #TWOPLAYRS_MMF_NRM_0 do
    stat_set_int(TWOPLAYRS_MMF_NRM_0[i][1], true, TWOPLAYRS_MMF_NRM_0[i][2])
end
end)

menu.add_feature("# Minimadrazzo Files : $1,210,000 (Hard)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
    for i = 1, #TWOPLAYRS_MMF_NRM_1 do
    stat_set_int(TWOPLAYRS_MMF_NRM_1[i][1], true, TWOPLAYRS_MMF_NRM_1[i][2])
end
end)
--
menu.add_feature("# Pink Diamond : $1,300,000 (Normal)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
for i = 1, #TWOPLAYRS_PDM_NRM_0 do
stat_set_int(TWOPLAYRS_PDM_NRM_0[i][1], true, TWOPLAYRS_PDM_NRM_0[i][2])
end
end)

menu.add_feature("# Pink Diamond : $1,430,000 (Hard)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
for i = 1, #TWOPLAYRS_PDM_NRM_1 do
stat_set_int(TWOPLAYRS_PDM_NRM_1[i][1], true, TWOPLAYRS_PDM_NRM_1[i][2])
end
end)
--
menu.add_feature("# Panther Statue : $1,900,000 (Normal)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
    for i = 1, #TWOPLAYRS_PP_NRM_0 do
    stat_set_int(TWOPLAYRS_PP_NRM_0[i][1], true, TWOPLAYRS_PP_NRM_0[i][2])
end
end)

menu.add_feature("# Panther Statue : $2,090,000 (Hard)", "action", NEW_METHOD_2PLYRs.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 85% to the Player2", "Heist Control - Warning", 208)
    for i = 1, #TWOPLAYRS_PP_NRM_1 do
    stat_set_int(TWOPLAYRS_PP_NRM_1[i][1], true, TWOPLAYRS_PP_NRM_1[i][2])
    end
    end)
end

------
do
-- 3P METHOD - NO EVENT

local FCP_SET_3P_METHOD_0_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 520359},
    {"H4LOOT_COKE_V", 1040719},
    {"H4LOOT_GOLD_V", 1387626},
    {"H4LOOT_PAINT_V", 1040719},
    {"H4LOOT_WEED_V", 832575},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_0_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 512026},
    {"H4LOOT_COKE_V", 1024053},
    {"H4LOOT_GOLD_V", 1365403},
    {"H4LOOT_PAINT_V", 1024053},
    {"H4LOOT_WEED_V", 819242},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_0_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 503693},
    {"H4LOOT_COKE_V", 1007386},
    {"H4LOOT_GOLD_V", 1343181},
    {"H4LOOT_PAINT_V", 1007386},
    {"H4LOOT_WEED_V", 805909},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_0_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 487026},
    {"H4LOOT_COKE_V", 974053},
    {"H4LOOT_GOLD_V", 1298737},
    {"H4LOOT_PAINT_V", 974053},
    {"H4LOOT_WEED_V", 779242},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_0_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 6304800},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 1917594},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 8554821},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 503693},
    {"H4LOOT_COKE_V", 1007386},
    {"H4LOOT_GOLD_V", 1343181},
    {"H4LOOT_PAINT_V", 1007386},
    {"H4LOOT_WEED_V", 805909},
    {"H4LOOT_CASH_I_SCOPED", 6304800},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 1917594},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 8554821},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_0_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 437026},
    {"H4LOOT_COKE_V", 874053},
    {"H4LOOT_GOLD_V", 1165403},
    {"H4LOOT_PAINT_V", 874053},
    {"H4LOOT_WEED_V", 699242},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

-- 3P METHOD HARD - NO EVENT

local FCP_SET_3P_METHOD_H0_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 512859},
    {"H4LOOT_COKE_V", 1025719},
    {"H4LOOT_GOLD_V", 1367626},
    {"H4LOOT_PAINT_V", 1025719},
    {"H4LOOT_WEED_V", 820575},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H0_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 503693},
    {"H4LOOT_COKE_V", 1007386},
    {"H4LOOT_GOLD_V", 1343181},
    {"H4LOOT_PAINT_V", 1007386},
    {"H4LOOT_WEED_V", 805909},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H0_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 494526},
    {"H4LOOT_COKE_V", 989053},
    {"H4LOOT_GOLD_V", 1318737},
    {"H4LOOT_PAINT_V", 989053},
    {"H4LOOT_WEED_V", 791242},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H0_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 476193},
    {"H4LOOT_COKE_V", 952386},
    {"H4LOOT_GOLD_V", 1269848},
    {"H4LOOT_PAINT_V", 952386},
    {"H4LOOT_WEED_V", 761909},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H0_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 494526},
    {"H4LOOT_COKE_V", 989053},
    {"H4LOOT_GOLD_V", 1318737},
    {"H4LOOT_PAINT_V", 989053},
    {"H4LOOT_WEED_V", 791242},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H0_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 421193},
    {"H4LOOT_COKE_V", 842386},
    {"H4LOOT_GOLD_V", 1123181},
    {"H4LOOT_PAINT_V", 842386},
    {"H4LOOT_WEED_V", 673909},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

-- 3P Method MENU
local MNCP_D30 = menu.add_feature("# 3 Players (Host: 20% - Players: 40%: $2.5mi)", "parent", CPPR.id)

menu.add_feature("# Sinsimito Tequila : $900,000 (Normal)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_0_TQL do
    stat_set_int(FCP_SET_3P_METHOD_0_TQL[i][1], true, FCP_SET_3P_METHOD_0_TQL[i][2])
end
end)

menu.add_feature("# Sinsimito Tequila : $990,000 (Hard)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_H0_TQL do
    stat_set_int(FCP_SET_3P_METHOD_H0_TQL[i][1], true, FCP_SET_3P_METHOD_H0_TQL[i][2])
end
end)
--
menu.add_feature("# Ruby Necklace : $1,000,000 (Normal)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_0_RBY do
    stat_set_int(FCP_SET_3P_METHOD_0_RBY[i][1], true, FCP_SET_3P_METHOD_0_RBY[i][2])
end
end)

menu.add_feature("# Ruby Necklace : $1,100,000 (Hard)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_H0_RBY do
    stat_set_int(FCP_SET_3P_METHOD_H0_RBY[i][1], true, FCP_SET_3P_METHOD_H0_RBY[i][2])
end
end)
--
menu.add_feature("# Bearer Bonds : $1,100,000 (Normal)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_0_BRB do
        stat_set_int(FCP_SET_3P_METHOD_0_BRB[i][1], true, FCP_SET_3P_METHOD_0_BRB[i][2])
 end
 end)

 menu.add_feature("# Bearer Bonds : $1,210,000 (Hard)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_H0_BRB do
        stat_set_int(FCP_SET_3P_METHOD_H0_BRB[i][1], true, FCP_SET_3P_METHOD_H0_BRB[i][2])
 end
 end)
--
menu.add_feature("# Minimadrazzo Files : $1,100,000 (Normal)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
        for i = 1, #FCP_SET_3P_METHOD_0_MMF do
        stat_set_int(FCP_SET_3P_METHOD_0_MMF[i][1], true, FCP_SET_3P_METHOD_0_MMF[i][2])
end
end)

menu.add_feature("# Minimadrazzo Files : $1,210,000 (Hard)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
        for i = 1, #FCP_SET_3P_METHOD_H0_MMF do
        stat_set_int(FCP_SET_3P_METHOD_H0_MMF[i][1], true, FCP_SET_3P_METHOD_H0_MMF[i][2])
end
end)
--
menu.add_feature("# Pink Diamond : $1,300,000 (Normal)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_0_PKD do
    stat_set_int(FCP_SET_3P_METHOD_0_PKD[i][1], true, FCP_SET_3P_METHOD_0_PKD[i][2])
end
end)

menu.add_feature("# Pink Diamond : $1,430,000 (Hard)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_H0_PKD do
    stat_set_int(FCP_SET_3P_METHOD_H0_PKD[i][1], true, FCP_SET_3P_METHOD_H0_PKD[i][2])
end
end)
--
menu.add_feature("# Panther Statue : $1,900,000 (Normal)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_0_PTS do
    stat_set_int(FCP_SET_3P_METHOD_0_PTS[i][1], true, FCP_SET_3P_METHOD_0_PTS[i][2])
end
end)

menu.add_feature("# Panther Statue : $2,090,000 (Hard)", "action", MNCP_D30.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_H0_PTS do
    stat_set_int(FCP_SET_3P_METHOD_H0_PTS[i][1], true, FCP_SET_3P_METHOD_H0_PTS[i][2])
end
end)
end
----
-- 4P Method Normal (No Event)
do
local FCP_SET_4P_METHOD_0_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 661931},
    {"H4LOOT_COKE_V", 1323863},
    {"H4LOOT_GOLD_V", 1765151},
    {"H4LOOT_PAINT_V", 1323863},
    {"H4LOOT_WEED_V", 1059090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_0_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 655681},
    {"H4LOOT_COKE_V", 1311363},
    {"H4LOOT_GOLD_V", 1748484},
    {"H4LOOT_PAINT_V", 1311363},
    {"H4LOOT_WEED_V", 1049090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_0_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 649431},
    {"H4LOOT_COKE_V", 1298863},
    {"H4LOOT_GOLD_V", 1731817},
    {"H4LOOT_PAINT_V", 1298863},
    {"H4LOOT_WEED_V", 1039090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_0_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 636931},
    {"H4LOOT_COKE_V", 1273863},
    {"H4LOOT_GOLD_V", 1698484},
    {"H4LOOT_PAINT_V", 1273863},
    {"H4LOOT_WEED_V", 1019090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_0_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 649431},
    {"H4LOOT_COKE_V", 1298863},
    {"H4LOOT_GOLD_V", 1731817},
    {"H4LOOT_PAINT_V", 1298863},
    {"H4LOOT_WEED_V", 1019090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_0_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 599431},
    {"H4LOOT_COKE_V", 1198863},
    {"H4LOOT_GOLD_V", 1598484},
    {"H4LOOT_PAINT_V", 1198863},
    {"H4LOOT_WEED_V", 959090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

-- 4P Method (Hard)

local FCP_SET_4P_METHOD_H0_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 656306},
    {"H4LOOT_COKE_V", 1312613},
    {"H4LOOT_GOLD_V", 1750151},
    {"H4LOOT_PAINT_V", 1312613},
    {"H4LOOT_WEED_V", 1050090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H0_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 649431},
    {"H4LOOT_COKE_V", 1298863},
    {"H4LOOT_GOLD_V", 1731817},
    {"H4LOOT_PAINT_V", 1298863},
    {"H4LOOT_WEED_V", 1039090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H0_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 642556},
    {"H4LOOT_COKE_V", 1285113},
    {"H4LOOT_GOLD_V", 1713484},
    {"H4LOOT_PAINT_V", 1285113},
    {"H4LOOT_WEED_V", 1028090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H0_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 628806},
    {"H4LOOT_COKE_V", 1257613},
    {"H4LOOT_GOLD_V", 1676817},
    {"H4LOOT_PAINT_V", 1257613},
    {"H4LOOT_WEED_V", 1006090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H0_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 642556},
    {"H4LOOT_COKE_V", 1285113},
    {"H4LOOT_GOLD_V", 1713484},
    {"H4LOOT_PAINT_V", 1285113},
    {"H4LOOT_WEED_V", 1028090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H0_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 587556},
    {"H4LOOT_COKE_V", 1175113},
    {"H4LOOT_GOLD_V", 1566818},
    {"H4LOOT_PAINT_V", 1175113},
    {"H4LOOT_WEED_V", 940090},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local MNCP_D40 = menu.add_feature("# 4 Players (25% to everyone: $2.5mi)", "parent", CPPR.id)

menu.add_feature("# Sinsimito Tequila : $900,000 (Normal)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_0_TQL do
        stat_set_int(FCP_SET_4P_METHOD_0_TQL[i][1], true, FCP_SET_4P_METHOD_0_TQL[i][2])
end
end)

menu.add_feature("# Sinsimito Tequila : $990,000 (Hard)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_H0_TQL do
        stat_set_int(FCP_SET_4P_METHOD_H0_TQL[i][1], true, FCP_SET_4P_METHOD_H0_TQL[i][2])
end
end)
--
menu.add_feature("# Ruby Necklace : $1,000,000 (Normal)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_0_RBY do
    stat_set_int(FCP_SET_4P_METHOD_0_RBY[i][1], true, FCP_SET_4P_METHOD_0_RBY[i][2])
end
end)

menu.add_feature("# Ruby Necklace : $1,100,000 (Hard)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_H0_RBY do
    stat_set_int(FCP_SET_4P_METHOD_H0_RBY[i][1], true, FCP_SET_4P_METHOD_H0_RBY[i][2])
end
end)
--
menu.add_feature("# Bearer Bonds : $1,100,000 (Normal)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_0_BRB do
        stat_set_int(FCP_SET_4P_METHOD_0_BRB[i][1], true, FCP_SET_4P_METHOD_0_BRB[i][2])
 end
 end)

 menu.add_feature("# Bearer Bonds : $1,210,000 (Hard)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_H0_BRB do
        stat_set_int(FCP_SET_4P_METHOD_H0_BRB[i][1], true, FCP_SET_4P_METHOD_H0_BRB[i][2])
 end
 end)
--
menu.add_feature("# Minimadrazzo Files : $1,100,000 (Normal)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_0_MMF do
    stat_set_int(FCP_SET_4P_METHOD_0_MMF[i][1], true, FCP_SET_4P_METHOD_0_MMF[i][2])
end
end)

menu.add_feature("# Minimadrazzo Files : $1,210,000 (Hard)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_H0_MMF do
    stat_set_int(FCP_SET_4P_METHOD_H0_MMF[i][1], true, FCP_SET_4P_METHOD_H0_MMF[i][2])
end
end)
--
menu.add_feature("# Pink Diamond : $1,300,000 (Normal)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_0_PKD do
    stat_set_int(FCP_SET_4P_METHOD_0_PKD[i][1], true, FCP_SET_4P_METHOD_0_PKD[i][2])
end
end)

menu.add_feature("# Pink Diamond : $1,430,000 (Hard)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_H0_PKD do
    stat_set_int(FCP_SET_4P_METHOD_H0_PKD[i][1], true, FCP_SET_4P_METHOD_H0_PKD[i][2])
end
end)
--
menu.add_feature("# Panther Statue : $1,900,000 (Normal)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_0_PTS do
    stat_set_int(FCP_SET_4P_METHOD_0_PTS[i][1], true, FCP_SET_4P_METHOD_0_PTS[i][2])
end
end)

menu.add_feature("# Panther Statue : $2,090,000 (Hard)", "action", MNCP_D40.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_H0_PTS do
    stat_set_int(FCP_SET_4P_METHOD_H0_PTS[i][1], true, FCP_SET_4P_METHOD_H0_PTS[i][2])
end
end)
--
end

-- EVENT STATS
do
    local FCP_SET_SOLO_METHOD_H1_TQL = {

        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 0},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 131055},
        {"H4LOOT_CASH_V", 906477},
        {"H4LOOT_COKE_V", 1812954},
        {"H4LOOT_GOLD_V", 2417272},
        {"H4LOOT_PAINT_V", 1812954},
        {"H4LOOT_WEED_V", 1450363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    }
    
    local FCP_SET_SOLO_METHOD_H1_RBY = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 1},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 131055},
        {"H4LOOT_CASH_V", 878977},
        {"H4LOOT_COKE_V", 1757954},
        {"H4LOOT_GOLD_V", 2343939},
        {"H4LOOT_PAINT_V", 1757954},
        {"H4LOOT_WEED_V", 1406363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    }
    
    local FCP_SET_SOLO_METHOD_H1_BRB = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 2},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 131055},
        {"H4LOOT_CASH_V", 851477},
        {"H4LOOT_COKE_V", 1702954},
        {"H4LOOT_GOLD_V", 2270605},
        {"H4LOOT_PAINT_V", 1702954},
        {"H4LOOT_WEED_V", 1362363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    }
    
    local FCP_SET_SOLO_METHOD_H1_PKD = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 3},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 131055},
        {"H4LOOT_CASH_V", 782272},
        {"H4LOOT_COKE_V", 1564545},
        {"H4LOOT_GOLD_V", 2086059},
        {"H4LOOT_PAINT_V", 1564545},
        {"H4LOOT_WEED_V", 1251636},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    
    }
    
    local FCP_SET_SOLO_METHOD_H1_MMF = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 4},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 131055},
        {"H4LOOT_CASH_V", 851477},
        {"H4LOOT_COKE_V", 1702954},
        {"H4LOOT_GOLD_V", 2270605},
        {"H4LOOT_PAINT_V", 1702954},
        {"H4LOOT_WEED_V", 1362363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    
    }
    
    local FCP_SET_SOLO_METHOD_H1_PTS = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 5},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 131055},
        {"H4LOOT_CASH_V", 631477},
        {"H4LOOT_COKE_V", 1262954},
        {"H4LOOT_GOLD_V", 1683939},
        {"H4LOOT_PAINT_V", 1262954},
        {"H4LOOT_WEED_V", 1010363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    
    }

    local FCP_SET_SOLO_METHOD_1_TQL = {

        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 0},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 124271},
        {"H4LOOT_CASH_V", 928977},
        {"H4LOOT_COKE_V", 1857954},
        {"H4LOOT_GOLD_V", 2477272},
        {"H4LOOT_PAINT_V", 1857954},
        {"H4LOOT_WEED_V", 1486363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    }
    
    local FCP_SET_SOLO_METHOD_1_RBY = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 1},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 126823},
        {"H4LOOT_CASH_V", 903977},
        {"H4LOOT_COKE_V", 1807954},
        {"H4LOOT_GOLD_V", 2410605},
        {"H4LOOT_PAINT_V", 1807954},
        {"H4LOOT_WEED_V", 1446363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    }
    local FCP_SET_SOLO_METHOD_1_BRB = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 2},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 126823},
        {"H4LOOT_CASH_V", 878977},
        {"H4LOOT_COKE_V", 1757954},
        {"H4LOOT_GOLD_V", 2343939},
        {"H4LOOT_PAINT_V", 1757954},
        {"H4LOOT_WEED_V", 1406363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    }
    
    local FCP_SET_SOLO_METHOD_1_PKD = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 3},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 126823},
        {"H4LOOT_CASH_V", 814772},
        {"H4LOOT_COKE_V", 1629545},
        {"H4LOOT_GOLD_V", 2172726},
        {"H4LOOT_PAINT_V", 1629545},
        {"H4LOOT_WEED_V", 1303636},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    
    }
    
    local FCP_SET_SOLO_METHOD_1_MMF = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 4},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 126823},
        {"H4LOOT_CASH_V", 878977},
        {"H4LOOT_COKE_V", 1757954},
        {"H4LOOT_GOLD_V", 2343939},
        {"H4LOOT_PAINT_V", 1757954},
        {"H4LOOT_WEED_V", 1406363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    
    }
    
    local FCP_SET_SOLO_METHOD_1_PTS = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 5},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 126823},
        {"H4LOOT_CASH_V", 678977},
        {"H4LOOT_COKE_V", 1357954},
        {"H4LOOT_GOLD_V", 1810605},
        {"H4LOOT_PAINT_V", 1357954},
        {"H4LOOT_WEED_V", 1086363},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    
    }


    local MNCP_EV_SL_ = menu.add_feature("# SOLO", "parent", MNCP_EV_.id)

    menu.add_feature("# Sinsimito Tequila : $900,000 (Normal)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
        for i = 1, #FCP_SET_SOLO_METHOD_1_TQL do
            stat_set_int(FCP_SET_SOLO_METHOD_1_TQL[i][1], true, FCP_SET_SOLO_METHOD_1_TQL[i][2])
        end
    end)
    
    menu.add_feature("# Sinsimito Tequila : $990,000 (Hard)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
        for i = 1, #FCP_SET_SOLO_METHOD_H1_TQL do
            stat_set_int(FCP_SET_SOLO_METHOD_H1_TQL[i][1], true, FCP_SET_SOLO_METHOD_H1_TQL[i][2])
        end
    end)
    -- 
    menu.add_feature("# Ruby Necklace : $1,000,000 (Normal)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_1_RBY do
        stat_set_int(FCP_SET_SOLO_METHOD_1_RBY[i][1], true, FCP_SET_SOLO_METHOD_1_RBY[i][2])
    end
    end)
    
    menu.add_feature("# Ruby Necklace : $1,100,000 (Hard)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_H1_RBY do
        stat_set_int(FCP_SET_SOLO_METHOD_H1_RBY[i][1], true, FCP_SET_SOLO_METHOD_H1_RBY[i][2])
    end
    end)
    --
    menu.add_feature("# Bearer Bonds : $1,100,000 (Normal)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_1_BRB do
    stat_set_int(FCP_SET_SOLO_METHOD_1_BRB[i][1], true, FCP_SET_SOLO_METHOD_1_BRB[i][2])
    end
    end)
    
    menu.add_feature("# Bearer Bonds : $1,210,000 (Hard)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_H1_BRB do
    stat_set_int(FCP_SET_SOLO_METHOD_H1_BRB[i][1], true, FCP_SET_SOLO_METHOD_H1_BRB[i][2])
    end
    end)
    --
    menu.add_feature("# Minimadrazzo Files : $1,100,000 (Normal)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
        for i = 1, #FCP_SET_SOLO_METHOD_1_MMF do
        stat_set_int(FCP_SET_SOLO_METHOD_1_MMF[i][1], true, FCP_SET_SOLO_METHOD_1_MMF[i][2])
    end
    end)
    
    menu.add_feature("# Minimadrazzo Files : $1,210,000 (Hard)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
        for i = 1, #FCP_SET_SOLO_METHOD_H1_MMF do
        stat_set_int(FCP_SET_SOLO_METHOD_H1_MMF[i][1], true, FCP_SET_SOLO_METHOD_H1_MMF[i][2])
    end
    end)
    --
    menu.add_feature("# Pink Diamond : $1,300,000 (Normal)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout limit: ~g~$2.550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_1_PKD do
    stat_set_int(FCP_SET_SOLO_METHOD_1_PKD[i][1], true, FCP_SET_SOLO_METHOD_1_PKD[i][2])
    end
    end)
    
    menu.add_feature("# Pink Diamond : $1,430,000 (Hard)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout limit: ~g~$2.550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
        for i = 1, #FCP_SET_SOLO_METHOD_H1_PKD do
        stat_set_int(FCP_SET_SOLO_METHOD_H1_PKD[i][1], true, FCP_SET_SOLO_METHOD_H1_PKD[i][2])
        end
        end)
    --
    menu.add_feature("# Panther Statue : $1,900,000 (Normal)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_1_PTS do
    stat_set_int(FCP_SET_SOLO_METHOD_1_PTS[i][1], true, FCP_SET_SOLO_METHOD_1_PTS[i][2])
    end
    end)
    
    menu.add_feature("# Panther Statue : $2,090,000 (Hard)", "action", MNCP_EV_SL_.id, function()
        ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
        ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
        ui.notify_above_map("~h~~y~This preset is calculated for SOLO - 100%", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_SOLO_METHOD_H1_PTS do
    stat_set_int(FCP_SET_SOLO_METHOD_H1_PTS[i][1], true, FCP_SET_SOLO_METHOD_H1_PTS[i][2])
    end
    end)
end

do
 -- 2P Method
 local FCP_SET_2P_METHOD_1_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 1053977},
    {"H4LOOT_COKE_V", 2107954},
    {"H4LOOT_GOLD_V", 2810605},
    {"H4LOOT_PAINT_V", 2107954},
    {"H4LOOT_WEED_V", 1686363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_1_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 1041477},
    {"H4LOOT_COKE_V", 2082954},
    {"H4LOOT_GOLD_V", 2777272},
    {"H4LOOT_PAINT_V", 2082954},
    {"H4LOOT_WEED_V", 1666363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_1_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 1028977},
    {"H4LOOT_COKE_V", 2057954},
    {"H4LOOT_GOLD_V", 2743939},
    {"H4LOOT_PAINT_V", 2057954},
    {"H4LOOT_WEED_V", 1646363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_1_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 1003977},
    {"H4LOOT_COKE_V", 2007954},
    {"H4LOOT_GOLD_V", 2677272},
    {"H4LOOT_PAINT_V", 2007954},
    {"H4LOOT_WEED_V", 1606363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_1_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 1028977},
    {"H4LOOT_COKE_V", 2057954},
    {"H4LOOT_GOLD_V", 2743939},
    {"H4LOOT_PAINT_V", 2057954},
    {"H4LOOT_WEED_V", 1646363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_1_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 928977},
    {"H4LOOT_COKE_V", 1857954},
    {"H4LOOT_GOLD_V", 2477272},
    {"H4LOOT_PAINT_V", 1857954},
    {"H4LOOT_WEED_V", 1486363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H1_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 1042727},
    {"H4LOOT_COKE_V", 2085454},
    {"H4LOOT_GOLD_V", 2780605},
    {"H4LOOT_PAINT_V", 2085454},
    {"H4LOOT_WEED_V", 1668363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H1_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 1028977},
    {"H4LOOT_COKE_V", 2057954},
    {"H4LOOT_GOLD_V", 2743939},
    {"H4LOOT_PAINT_V", 2057954},
    {"H4LOOT_WEED_V", 1646363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H1_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 1015227},
    {"H4LOOT_COKE_V", 2030454},
    {"H4LOOT_GOLD_V", 2707272},
    {"H4LOOT_PAINT_V", 2030454},
    {"H4LOOT_WEED_V", 1624363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H1_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 987727},
    {"H4LOOT_COKE_V", 1975454},
    {"H4LOOT_GOLD_V", 2633939},
    {"H4LOOT_PAINT_V", 1975454},
    {"H4LOOT_WEED_V", 1580363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H1_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 1015227},
    {"H4LOOT_COKE_V", 2030454},
    {"H4LOOT_GOLD_V", 2707272},
    {"H4LOOT_PAINT_V", 2030454},
    {"H4LOOT_WEED_V", 1624363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_2P_METHOD_H1_PTS = {
    
    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 905227},
    {"H4LOOT_COKE_V", 1810454},
    {"H4LOOT_GOLD_V", 2413939},
    {"H4LOOT_PAINT_V", 1810454},
    {"H4LOOT_WEED_V", 1448363},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local MNCP_D20_EV = menu.add_feature("# 2 Players (50% each one: $4.1mi)", "parent", MNCP_EV_.id)

menu.add_feature("# Sinsimito Tequila : $900,000 (Normal)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_1_TQL do
    stat_set_int(FCP_SET_2P_METHOD_1_TQL[i][1], true, FCP_SET_2P_METHOD_1_TQL[i][2])
end
end)

menu.add_feature("# Sinsimito Tequila : $990,000 (Hard)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_H1_TQL do
    stat_set_int(FCP_SET_2P_METHOD_H1_TQL[i][1], true, FCP_SET_2P_METHOD_H1_TQL[i][2])
end
end)
--
menu.add_feature("# Ruby Necklace : $1,000,000 (Normal)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_1_RBY do
stat_set_int(FCP_SET_2P_METHOD_1_RBY[i][1], true, FCP_SET_2P_METHOD_1_RBY[i][2])
end
end)

menu.add_feature("# Ruby Necklace : $1,100,000 (Hard)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_H1_RBY do
stat_set_int(FCP_SET_2P_METHOD_H1_RBY[i][1], true, FCP_SET_2P_METHOD_H1_RBY[i][2])
end
end)
--
menu.add_feature("# Bearer Bonds : $1,100,000 (Normal)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_1_BRB do
        stat_set_int(FCP_SET_2P_METHOD_1_BRB[i][1], true, FCP_SET_2P_METHOD_1_BRB[i][2])
end
end)

menu.add_feature("# Bearer Bonds : $1,210,000 (Hard)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_H1_BRB do
        stat_set_int(FCP_SET_2P_METHOD_H1_BRB[i][1], true, FCP_SET_2P_METHOD_H1_BRB[i][2])
end
end)
--
menu.add_feature("# Minimadrazzo Files : $1,100,000 (Normal)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_1_MMF do
    stat_set_int(FCP_SET_2P_METHOD_1_MMF[i][1], true, FCP_SET_2P_METHOD_1_MMF[i][2])
end
end)

menu.add_feature("# Minimadrazzo Files : $1,210,000 (Hard)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_H1_MMF do
    stat_set_int(FCP_SET_2P_METHOD_H1_MMF[i][1], true, FCP_SET_2P_METHOD_H1_MMF[i][2])
end
end)
--
menu.add_feature("# Pink Diamond : $1,300,000 (Normal)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_1_PKD do
stat_set_int(FCP_SET_2P_METHOD_1_PKD[i][1], true, FCP_SET_2P_METHOD_1_PKD[i][2])
end
end)

menu.add_feature("# Pink Diamond : $1,430,000 (Hard)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_2P_METHOD_H1_PKD do
stat_set_int(FCP_SET_2P_METHOD_H1_PKD[i][1], true, FCP_SET_2P_METHOD_H1_PKD[i][2])
end
end)
--
menu.add_feature("# Panther Statue : $1,900,000 (Normal)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_1_PTS do
    stat_set_int(FCP_SET_2P_METHOD_1_PTS[i][1], true, FCP_SET_2P_METHOD_1_PTS[i][2])
end
end)

menu.add_feature("# Panther Statue : $2,090,000 (Hard)", "action", MNCP_D20_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for DUO - SET 50% to each player", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_2P_METHOD_H1_PTS do
    stat_set_int(FCP_SET_2P_METHOD_H1_PTS[i][1], true, FCP_SET_2P_METHOD_H1_PTS[i][2])
end
end)
--
end
--

do
    -- 3P Method

    local FCP_SET_3P_METHOD_1_TQL = {

        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 0},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 126823},
        {"H4LOOT_CASH_V", 899147},
        {"H4LOOT_COKE_V", 1798295},
        {"H4LOOT_GOLD_V", 2397726},
        {"H4LOOT_PAINT_V", 1798295},
        {"H4LOOT_WEED_V", 1438636},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    }
    
    local FCP_SET_3P_METHOD_1_RBY = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 1},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 126823},
        {"H4LOOT_CASH_V", 890814},
        {"H4LOOT_COKE_V", 1781628},
        {"H4LOOT_GOLD_V", 2375504},
        {"H4LOOT_PAINT_V", 1781628},
        {"H4LOOT_WEED_V", 1425302},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    }
    
    local FCP_SET_3P_METHOD_1_BRB = {
    
        {"H4CNF_TROJAN", 4},
        {"H4CNF_BS_GEN", 131071},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEAPONS", 5},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_TARGET", 2},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", -1},
        {"H4LOOT_CASH_I", 2394658},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 4793496},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 9589061},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 255},
        {"H4LOOT_PAINT", 127},
        {"H4_PROGRESS", 126823},
        {"H4LOOT_CASH_V", 882481},
        {"H4LOOT_COKE_V", 1764962},
        {"H4LOOT_GOLD_V", 2353282},
        {"H4LOOT_PAINT_V", 1764962},
        {"H4LOOT_WEED_V", 1411969},
        {"H4LOOT_CASH_I_SCOPED", 2394658},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 4793496},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 9589061},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 255},
        {"H4LOOT_PAINT_SCOPED", 127},
        {"H4_MISSIONS", 65535},
        {"H4_PLAYTHROUGH_STATUS", 200}
    }
    
    local FCP_SET_3P_METHOD_1_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 865814},
    {"H4LOOT_COKE_V", 1731628},
    {"H4LOOT_GOLD_V", 2308837},
    {"H4LOOT_PAINT_V", 1731628},
    {"H4LOOT_WEED_V", 1385302},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

    local FCP_SET_3P_METHOD_1_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
     {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
     {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 882481},
    {"H4LOOT_COKE_V", 1764962},
    {"H4LOOT_GOLD_V", 2353282},
    {"H4LOOT_PAINT_V", 1764962},
    {"H4LOOT_WEED_V", 1411969},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

    local FCP_SET_3P_METHOD_1_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 815814},
    {"H4LOOT_COKE_V", 1631628},
    {"H4LOOT_GOLD_V", 2175504},
    {"H4LOOT_PAINT_V", 1631628},
    {"H4LOOT_WEED_V", 1305302},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H1_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 891647},
    {"H4LOOT_COKE_V", 1783295},
    {"H4LOOT_GOLD_V", 2377726},
    {"H4LOOT_PAINT_V", 1783295},
    {"H4LOOT_WEED_V", 1426636},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H1_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 882481},
    {"H4LOOT_COKE_V", 1764962},
    {"H4LOOT_GOLD_V", 2353282},
    {"H4LOOT_PAINT_V", 1764962},
    {"H4LOOT_WEED_V", 1411969},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H1_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 873314},
    {"H4LOOT_COKE_V", 1746628},
    {"H4LOOT_GOLD_V", 2328837},
    {"H4LOOT_PAINT_V", 1746628},
    {"H4LOOT_WEED_V", 1397302},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H1_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 854981},
    {"H4LOOT_COKE_V", 1709962},
    {"H4LOOT_GOLD_V", 2279949},
    {"H4LOOT_PAINT_V", 1746628},
    {"H4LOOT_WEED_V", 1709962},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H1_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 873314},
    {"H4LOOT_COKE_V", 1746628},
    {"H4LOOT_GOLD_V", 2328837},
    {"H4LOOT_PAINT_V", 1746628},
    {"H4LOOT_WEED_V", 1397302},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_3P_METHOD_H1_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 799981},
    {"H4LOOT_COKE_V", 1599962},
    {"H4LOOT_GOLD_V", 2133282},
    {"H4LOOT_PAINT_V", 1599962},
    {"H4LOOT_WEED_V", 1279969},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}


local MNCP_D30_EV = menu.add_feature("# 3 Players (Host: 20% - Players: 40%: $4.1mi)", "parent", MNCP_EV_.id)
menu.add_feature("# Sinsimito Tequila : $900,000 (Normal)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_3P_METHOD_1_TQL do
    stat_set_int(FCP_SET_3P_METHOD_1_TQL[i][1], true, FCP_SET_3P_METHOD_1_TQL[i][2])
end
end)

menu.add_feature("# Sinsimito Tequila : $990,000 (Hard)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_3P_METHOD_H1_TQL do
    stat_set_int(FCP_SET_3P_METHOD_H1_TQL[i][1], true, FCP_SET_3P_METHOD_H1_TQL[i][2])
end
end)
--
menu.add_feature("# Ruby Necklace : $1,000,000 (Normal)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_3P_METHOD_1_RBY do
stat_set_int(FCP_SET_3P_METHOD_1_RBY[i][1], true, FCP_SET_3P_METHOD_1_RBY[i][2])
end
end)

menu.add_feature("# Ruby Necklace : $1,100,000 (Hard)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_3P_METHOD_H1_RBY do
stat_set_int(FCP_SET_3P_METHOD_H1_RBY[i][1], true, FCP_SET_3P_METHOD_H1_RBY[i][2])
end
end)
--
menu.add_feature("# Bearer Bonds : $1,100,000 (Normal)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_1_BRB do
        stat_set_int(FCP_SET_3P_METHOD_1_BRB[i][1], true, FCP_SET_3P_METHOD_1_BRB[i][2])
end
end)

menu.add_feature("# Bearer Bonds : $1,210,000 (Hard)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_H1_BRB do
        stat_set_int(FCP_SET_3P_METHOD_H1_BRB[i][1], true, FCP_SET_3P_METHOD_H1_BRB[i][2])
end
end)
--
menu.add_feature("# Minimadrazzo Files : $1,100,000 (Normal)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_1_MMF do
    stat_set_int(FCP_SET_3P_METHOD_1_MMF[i][1], true, FCP_SET_3P_METHOD_1_MMF[i][2])
end
end)

menu.add_feature("# Minimadrazzo Files : $1,210,000 (Hard)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_H1_MMF do
    stat_set_int(FCP_SET_3P_METHOD_H1_MMF[i][1], true, FCP_SET_3P_METHOD_H1_MMF[i][2])
end
end)
--
menu.add_feature("# Pink Diamond : $1,300,000 (Normal)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_1_PKD do
    stat_set_int(FCP_SET_3P_METHOD_1_PKD[i][1], true, FCP_SET_3P_METHOD_1_PKD[i][2])
end
end)

menu.add_feature("# Pink Diamond : $1,430,000 (Hard)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_3P_METHOD_H1_PKD do
stat_set_int(FCP_SET_3P_METHOD_H1_PKD[i][1], true, FCP_SET_3P_METHOD_H1_PKD[i][2])
end
end)
--
menu.add_feature("# Panther Statue : $1,900,000 (Normal)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_1_PTS do
    stat_set_int(FCP_SET_3P_METHOD_1_PTS[i][1], true, FCP_SET_3P_METHOD_1_PTS[i][2])
end
end)

menu.add_feature("# Panther Statue : $2,090,000 (Hard)", "action", MNCP_D30_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for TRIO~n~HOST 20% - Players 40% each", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_3P_METHOD_H1_PTS do
    stat_set_int(FCP_SET_3P_METHOD_H1_PTS[i][1], true, FCP_SET_3P_METHOD_H1_PTS[i][2])
end
end)
end

do
-- 4P Method

local FCP_SET_4P_METHOD_H1_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 700213},
    {"H4LOOT_COKE_V", 1400427},
    {"H4LOOT_GOLD_V", 1867236},
    {"H4LOOT_PAINT_V", 1400427},
    {"H4LOOT_WEED_V", 1120342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H1_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 693338},
    {"H4LOOT_COKE_V", 1386677},
    {"H4LOOT_GOLD_V", 1848903},
    {"H4LOOT_PAINT_V", 1386677},
    {"H4LOOT_WEED_V", 1109342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H1_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 686463},
    {"H4LOOT_COKE_V", 1372927},
    {"H4LOOT_GOLD_V", 1830570},
    {"H4LOOT_PAINT_V", 1372927},
    {"H4LOOT_WEED_V", 1098342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H1_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 672713},
    {"H4LOOT_COKE_V", 1345427},
    {"H4LOOT_GOLD_V", 1793903},
    {"H4LOOT_PAINT_V", 1345427},
    {"H4LOOT_WEED_V", 1076342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H1_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 686463},
    {"H4LOOT_COKE_V", 1372927},
    {"H4LOOT_GOLD_V", 1830570},
    {"H4LOOT_PAINT_V", 1372927},
    {"H4LOOT_WEED_V", 1098342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_H1_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 131055},
    {"H4LOOT_CASH_V", 631463},
    {"H4LOOT_COKE_V", 1262927},
    {"H4LOOT_GOLD_V", 1683903},
    {"H4LOOT_PAINT_V", 1262927},
    {"H4LOOT_WEED_V", 1010342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_1_TQL = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 0},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 705838},
    {"H4LOOT_COKE_V", 1411677},
    {"H4LOOT_GOLD_V", 1882236},
    {"H4LOOT_PAINT_V", 1411677},
    {"H4LOOT_WEED_V", 1129342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_1_RBY = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 1},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 699588},
    {"H4LOOT_COKE_V", 1399177},
    {"H4LOOT_GOLD_V", 1865570},
    {"H4LOOT_PAINT_V", 1399177},
    {"H4LOOT_WEED_V", 1119342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_1_BRB = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 2},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 693338},
    {"H4LOOT_COKE_V", 1386677},
    {"H4LOOT_GOLD_V", 1848903},
    {"H4LOOT_PAINT_V", 1386677},
    {"H4LOOT_WEED_V", 1109342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_1_PKD = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 680838},
    {"H4LOOT_COKE_V", 1361677},
    {"H4LOOT_GOLD_V", 1815570},
    {"H4LOOT_PAINT_V", 1361677},
    {"H4LOOT_WEED_V", 1089342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_1_MMF = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 4},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 693338},
    {"H4LOOT_COKE_V", 1386677},
    {"H4LOOT_GOLD_V", 1848903},
    {"H4LOOT_PAINT_V", 1386677},
    {"H4LOOT_WEED_V", 1109342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}

local FCP_SET_4P_METHOD_1_PTS = {

    {"H4CNF_TROJAN", 4},
    {"H4CNF_BS_GEN", 131071},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEAPONS", 5},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_TARGET", 5},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 2394658},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 4793496},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 9589061},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_PAINT", 127},
    {"H4_PROGRESS", 126823},
    {"H4LOOT_CASH_V", 643338},
    {"H4LOOT_COKE_V", 1286677},
    {"H4LOOT_GOLD_V", 1715570},
    {"H4LOOT_PAINT_V", 1286677},
    {"H4LOOT_WEED_V", 1029342},
    {"H4LOOT_CASH_I_SCOPED", 2394658},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 4793496},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 9589061},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4_MISSIONS", 65535},
    {"H4_PLAYTHROUGH_STATUS", 200}
}


local MNCP_D40_EV = menu.add_feature("# 4 Players (25% to everyone: $4.1m)", "parent", MNCP_EV_.id)

menu.add_feature("# Sinsimito Tequila : $900,000 (Normal)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_4P_METHOD_1_TQL do
    stat_set_int(FCP_SET_4P_METHOD_1_TQL[i][1], true, FCP_SET_4P_METHOD_1_TQL[i][2])
end
end)

menu.add_feature("# Sinsimito Tequila : $990,000 (Hard)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sinsimito Tequila~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_4P_METHOD_H1_TQL do
    stat_set_int(FCP_SET_4P_METHOD_H1_TQL[i][1], true, FCP_SET_4P_METHOD_H1_TQL[i][2])
end
end)
--
menu.add_feature("# Ruby Necklace : $1,000,000 (Normal)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_4P_METHOD_1_RBY do
stat_set_int(FCP_SET_4P_METHOD_1_RBY[i][1], true, FCP_SET_4P_METHOD_1_RBY[i][2])
end
end)

menu.add_feature("# Ruby Necklace : $1,100,000 (Hard)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Ruby Necklace~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_4P_METHOD_H1_RBY do
stat_set_int(FCP_SET_4P_METHOD_H1_RBY[i][1], true, FCP_SET_4P_METHOD_H1_RBY[i][2])
end
end)
--
menu.add_feature("# Bearer Bonds : $1,100,000 (Normal)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_1_BRB do
        stat_set_int(FCP_SET_4P_METHOD_1_BRB[i][1], true, FCP_SET_4P_METHOD_1_BRB[i][2])
end
end)

menu.add_feature("# Bearer Bonds : $1,210,000 (Hard)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Bearer Bonds~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_H1_BRB do
        stat_set_int(FCP_SET_4P_METHOD_H1_BRB[i][1], true, FCP_SET_4P_METHOD_H1_BRB[i][2])
end
end)
--
menu.add_feature("# Minimadrazzo Files : $1,100,000 (Normal)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_1_MMF do
    stat_set_int(FCP_SET_4P_METHOD_1_MMF[i][1], true, FCP_SET_4P_METHOD_1_MMF[i][2])
end
 end)
--
menu.add_feature("# Minimadrazzo Files : $1,210,000 (Hard)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Madrazzo Files~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_H1_MMF do
    stat_set_int(FCP_SET_4P_METHOD_H1_MMF[i][1], true, FCP_SET_4P_METHOD_H1_MMF[i][2])
end
end)
--
menu.add_feature("# Pink Diamond : $1,300,000 (Normal)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_4P_METHOD_1_PKD do
stat_set_int(FCP_SET_4P_METHOD_1_PKD[i][1], true, FCP_SET_4P_METHOD_1_PKD[i][2])
end
end)

menu.add_feature("# Pink Diamond : $1,430,000 (Hard)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Pink Diamond~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
for i = 1, #FCP_SET_4P_METHOD_H1_PKD do
stat_set_int(FCP_SET_4P_METHOD_H1_PKD[i][1], true, FCP_SET_4P_METHOD_H1_PKD[i][2])
end
end)
--
menu.add_feature("# Panther Statue : $1,900,000 (Normal)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~g~Normal", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_1_PTS do
    stat_set_int(FCP_SET_4P_METHOD_1_PTS[i][1], true, FCP_SET_4P_METHOD_1_PTS[i][2])
end
end)

menu.add_feature("# Panther Statue : $2,090,000 (Hard)", "action", MNCP_D40_EV.id, function()
    ui.notify_above_map("~h~Primary Target: ~q~Sapphire Panther~n~~s~Secondary Target: ~b~Mixed~n~~s~Payout:~g~ $2,550,000", "", 2)
    ui.notify_above_map("~h~Weapon Loadout: ~y~Marksman~n~~s~Vehicle Choosed: ~g~All Unlocked~s~~n~Difficulty: ~r~Hard", "", 2)
    ui.notify_above_map("~h~~y~This preset is calculated for QUAD (4 Players)~n~Set 25% to EVERYONE", "Heist Control - Warning", 208)
    for i = 1, #FCP_SET_4P_METHOD_H1_PTS do
    stat_set_int(FCP_SET_4P_METHOD_H1_PTS[i][1], true, FCP_SET_4P_METHOD_H1_PTS[i][2])
end
end)
end

--
-- CP Vehicles
do
local CP_VEH_AVL_ALL = {

    {"H4_MISSIONS", 65535}
}

local CP_VEH_AVL_KA = {

    {"H4_MISSIONS", 65283}
}

local CP_VEH_AVL_AT = {

    {"H4_MISSIONS", 65413}
}

local CP_VEH_AVL_VM = {

    {"H4_MISSIONS", 65289}
}

local CP_VEH_AVL_SA = {

    {"H4_MISSIONS", 65425}
}

local CP_VEH_AVL_PB = {

    {"H4_MISSIONS", 65313}
}

local CP_VEH_AVL_LN = {

    {"H4_MISSIONS", 65345}
}

local sub_option_A2 = menu.add_feature("# Approach Vehicles", "parent", CPMN.id)

menu.add_feature("# Submarine: KOSATKA", "action", sub_option_A2.id, function()
    ui.notify_above_map("You chose ~h~KOSATKA", "Heist Control - Vehicles Editor", 96)
    for i = 1, #CP_VEH_AVL_KA do
        stat_set_int(CP_VEH_AVL_KA[i][1], true, CP_VEH_AVL_KA[i][2])
    end
end)

menu.add_feature("# Plane: ALKONOST", "action", sub_option_A2.id, function()
    ui.notify_above_map("You chose ~h~ALKONOST", "Heist Control - Vehicles Editor", 96)
    for i = 1, #CP_VEH_AVL_AT do
        stat_set_int(CP_VEH_AVL_AT[i][1], true, CP_VEH_AVL_AT[i][2])
    end
end)

menu.add_feature("# Plane: VELUM", "action", sub_option_A2.id, function()
    ui.notify_above_map("You chose ~h~VELUM", "Heist Control - Vehicles Editor", 96)
    for i = 1, #CP_VEH_AVL_VM do
        stat_set_int(CP_VEH_AVL_VM[i][1], true, CP_VEH_AVL_VM[i][2])
    end
end)

menu.add_feature("# Helicopter: STEALTH ANNIHILATOR", "action", sub_option_A2.id, function()
    ui.notify_above_map("You chose ~h~STEALTH ANNIHILATOR", "Heist Control - Vehicles Editor", 96)
    for i = 1, #CP_VEH_AVL_SA do
        stat_set_int(CP_VEH_AVL_SA[i][1], true, CP_VEH_AVL_SA[i][2])
    end
end)

menu.add_feature("# Boat: PATROL BOAT", "action", sub_option_A2.id, function()
    ui.notify_above_map("You chose ~h~PATROL BOAT", "Heist Control - Vehicles Editor", 96)
    for i = 1, #CP_VEH_AVL_PB do
        stat_set_int(CP_VEH_AVL_PB[i][1], true, CP_VEH_AVL_PB[i][2])
    end
end)

menu.add_feature("# Boat: LONGFIN", "action", sub_option_A2.id, function()
    ui.notify_above_map("You chose ~h~LONGFIN", "Heist Control - Vehicles Editor", 96)
    for i = 1, #CP_VEH_AVL_LN do
        stat_set_int(CP_VEH_AVL_LN[i][1], true, CP_VEH_AVL_LN[i][2])
    end
end)

menu.add_feature("# Unlock All Vehicles", "action", sub_option_A2.id, function()
    ui.notify_above_map("All Vehicles - Unlocked", "Heist Control - Vehicles Editor", 96)
    for i = 1, #CP_VEH_AVL_ALL do
        stat_set_int(CP_VEH_AVL_ALL[i][1], true, CP_VEH_AVL_ALL[i][2])
    end
end)
end

--

do
    local Target_PinkPanther = {

    {"H4CNF_TARGET", 5}
}
    
    local Target_MadrazoF = {
    
    {"H4CNF_TARGET", 4}
}
    
    local Target_PinkDiamond = {
   
    {"H4CNF_TARGET", 3}
}
    local Target_BearerBonds = {
    
    {"H4CNF_TARGET", 2}
}
    
    local Target_Ruby = {
    
    {"H4CNF_TARGET", 1}
    
}
    local Target_Tequila = {
    
    {"H4CNF_TARGET", 0}
}

    local sub_option_A1 = menu.add_feature("# Primary Target", "parent", CPMN.id)

-- feature inside the parent
menu.add_feature("# Change to Sapphire Panther", "action", sub_option_A1.id, function()
    ui.notify_above_map("~h~Primary Target Modified to ~n~~p~Sapphire Panther ~n~~g~Normal $1.900,000~n~~r~Hard $2.090,000", "Heist Control - Target Editor", 96)
    for i = 1, #Target_PinkPanther do
        stat_set_int(Target_PinkPanther[i][1], true, Target_PinkPanther[i][2])
    end
end)

menu.add_feature("# Change to Madrazo Files", "action", sub_option_A1.id, function()
    ui.notify_above_map("~h~Primary Target Modified to ~n~~y~Madrazo Files~n~ ~g~Normal $1.100,000 ~n~ ~r~Hard $1.210,000", "Heist Control - Target Editor", 96)
    for i = 1, #Target_MadrazoF do
        stat_set_int(Target_MadrazoF[i][1], true, Target_MadrazoF[i][2])
    end
end)

menu.add_feature("# Change to Pink Diamond", "action", sub_option_A1.id, function()
    ui.notify_above_map("~h~Primary Target Modified to ~n~ ~q~Pink Diamond~n~~g~Normal $1.300,000 ~n~ ~r~Hard $1.430,000", "Heist Control - Target Editor", 96)
    for i = 1, #Target_PinkDiamond do
        stat_set_int(Target_PinkDiamond[i][1], true, Target_PinkDiamond[i][2])
    end
end)

menu.add_feature("# Change to Bearer Bonds", "action", sub_option_A1.id, function()
    ui.notify_above_map("~h~Primary Target Modified to~n~~b~Bearer Bonds~n~~g~Normal $1.100,000~n~~r~Hard $1.210,000", "Heist Control - Target Editor", 96)
    for i = 1, #Target_BearerBonds do
        stat_set_int(Target_BearerBonds[i][1], true, Target_BearerBonds[i][2])
    end
end)

menu.add_feature("# Change to Ruby", "action", sub_option_A1.id, function()
    ui.notify_above_map("~h~Primary Target Modified to~n~~p~Ruby~n~~g~Normal $1.000,000~n~~r~Hard $1.100,000", "Heist Control - Target Editor", 96)
    for i = 1, #Target_Ruby do
        stat_set_int(Target_Ruby[i][1], true, Target_Ruby[i][2])
    end
end)

menu.add_feature("# Change to Tequila", "action", sub_option_A1.id, function()
    ui.notify_above_map("~h~Primary Target Modified to~n~~o~Tequila~n~~g~Normal $900,000~n~~r~Hard $990,000", "Heist Control - Target Editor", 96)
    for i = 1, #Target_Tequila do
        stat_set_int(Target_Tequila[i][1], true, Target_Tequila[i][2])
    end
end)
end
--#region

do
    local SecondaryT_Remove = {

    {"H4LOOT_CASH_I", 0},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_I", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_PAINT", 0},
    {"H4LOOT_PAINT_V", 0},
    {"H4LOOT_CASH_I_SCOPED", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 0}
}


    local sub_option_C0 = menu.add_feature("# Secondary Target", "parent", CPMN.id)

    menu.add_feature("# Remove All Secondary Target", "action", sub_option_C0.id, function()
    ui.notify_above_map("Secondary Target has been removed", "Heist Control - Target Editor", 96)
    for i = 1, #SecondaryT_Remove do
    stat_set_int(SecondaryT_Remove[i][1], true, SecondaryT_Remove[i][2])
end
end)
end
--

do
    local Weapon_Agressor = {

    {"H4CNF_WEAPONS", 1}
}
    
    local Weapon_Conspirator = {
    
    {"H4CNF_WEAPONS", 2}
}
    
    local Weapon_Crackshot = {
    
    {"H4CNF_WEAPONS", 3}
}
    
    local Weapon_Saboteur = {
    
    {"H4CNF_WEAPONS", 4}
}
    
    local Weapon_Marksman = {
    
    {"H4CNF_WEAPONS", 5}
}

local sub_option_A2 = menu.add_feature("# Change Weapons", "parent", CPMN.id)

menu.add_feature("# Aggressor Loadout", "action", sub_option_A2.id, function()
    ui.notify_above_map("~h~~g~Aggressor Loadout~n~~y~Assault SG~n~Machine Pistol~n~Machete~n~Grenade", "Heist Control - Weapon Editor", 96)
    for i = 1, #Weapon_Agressor do
        stat_set_int(Weapon_Agressor[i][1], true, Weapon_Agressor[i][2])
    end
end)

menu.add_feature("# Conspirator Loadout", "action", sub_option_A2.id, function()
    ui.notify_above_map("~h~~g~Conspirator Loadout~n~~y~Military Rifle~n~ AP~n~Knuckles~n~Stickies", "Heist Control - Weapon Editor", 96)
    for i = 1, #Weapon_Conspirator do
        stat_set_int(Weapon_Conspirator[i][1], true, Weapon_Conspirator[i][2])
    end
end)

menu.add_feature("# Crackshot Loadout", "action", sub_option_A2.id, function()
    ui.notify_above_map("~h~~g~Crackshot Loadout~n~~y~Sniper~n~AP~n~Knife~n~Molotov", "Heist Control - Weapon Editor", 96)
    for i = 1, #Weapon_Crackshot do
        stat_set_int(Weapon_Crackshot[i][1], true, Weapon_Crackshot[i][2])
    end
end)

menu.add_feature("# Saboteur Loadout", "action", sub_option_A2.id, function()
    ui.notify_above_map("~h~~g~Saboteur Loadout~n~~y~SMG Mk2~n~SNS Pistol~n~Knife~n~Pipe Bomb", "Heist Control - Weapon Editor", 96)
    for i = 1, #Weapon_Saboteur do
        stat_set_int(Weapon_Saboteur[i][1], true, Weapon_Saboteur[i][2])
    end
end)

menu.add_feature("# Marksman Loadout", "action", sub_option_A2.id, function()
    ui.notify_above_map("~h~~g~Marksman Loadout~n~~y~AK-47~n~Pistol .50~n~Machete~n~Pipe Bomb", "Heist Control - Weapon Editor", 96)
    for i = 1, #Weapon_Marksman do
        stat_set_int(Weapon_Marksman[i][1], true, Weapon_Marksman[i][2])
    end
end)
end

--#region
do

    local CP_Item_SpawnPlace_AIR = {

    {"H4CNF_GRAPPEL", 2022},
    {"H4CNF_UNIFORM", 12},
    {"H4CNF_BOLTCUT", 4161},
    {"H4CNF_TROJAN", 1}
}
    
    local CP_Item_SpawnPlace_DKS = {
    
    {"H4CNF_GRAPPEL", 3671},
    {"H4CNF_UNIFORM", 5256},
     {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_TROJAN", 2}
}
    
    local CP_Item_SpawnPlace_CP = {
    
    {"H4CNF_GRAPPEL", 85324},
    {"H4CNF_UNIFORM", 61034},
    {"H4CNF_BOLTCUT", 4612},
    {"H4CNF_TROJAN", 5}
}

local ITM_SPWN = menu.add_feature("# Equipments Location", "parent", CPMN.id)

menu.add_feature("# Force Equipments to spawn next to Airport", "action", ITM_SPWN.id, function()
        ui.notify_above_map("Equipments will spawn next to Airport", "Heist Control", 96)
    for i = 1, #CP_Item_SpawnPlace_AIR do
        stat_set_int(CP_Item_SpawnPlace_AIR[i][1], true, CP_Item_SpawnPlace_AIR[i][2])
    end
end)

menu.add_feature("# Force Equipments to spawn next to Docks", "action", ITM_SPWN.id, function()
        ui.notify_above_map("Equipments will spawn at Docks", "Heist Control", 96)
    for i = 1, #CP_Item_SpawnPlace_DKS do
        stat_set_int(CP_Item_SpawnPlace_DKS[i][1], true, CP_Item_SpawnPlace_DKS[i][2])
    end
end)

menu.add_feature("# Force Equipments to spawn next to Compound", "action", ITM_SPWN.id, function()
        ui.notify_above_map("Equipments will spawn next to Compound", "Heist Control", 96)
    for i = 1, #CP_Item_SpawnPlace_CP do
        stat_set_int(CP_Item_SpawnPlace_CP[i][1], true, CP_Item_SpawnPlace_CP[i][2])
    end
end)
end

--#region

do
    local CP_TRUCK_SPAWN_mov1 = {

    {"H4CNF_TROJAN", 1}
}
    
    local CP_TRUCK_SPAWN_mov2 = {
    
    {"H4CNF_TROJAN", 2}
}
    
    local CP_TRUCK_SPAWN_mov3 = {
    
    {"H4CNF_TROJAN", 3}
}
    
    local CP_TRUCK_SPAWN_mov4 = {
    
    {"H4CNF_TROJAN", 4}
}
    
    local CP_TRUCK_SPAWN_mov5 = {
    
    {"H4CNF_TROJAN", 5}
}

    local TRCK_SPWN = menu.add_feature("# Supply Truck Location", "parent", CPMN.id)

    menu.add_feature("# Force Supply Truck to Spawn at: Airport", "action", TRCK_SPWN.id, function()
    ui.notify_above_map("Done: The Truck will spawn at Airport", "Heist Control", 96)
    for i = 1, #CP_TRUCK_SPAWN_mov1 do
    stat_set_int(CP_TRUCK_SPAWN_mov1[i][1], true, CP_TRUCK_SPAWN_mov1[i][2])
end
end)
    
    menu.add_feature("# Force Supply Truck to Spawn at: North Dock", "action", TRCK_SPWN.id, function()
    ui.notify_above_map("Done: The Truck will spawn at North Dock", "Heist Control", 96)
    for i = 1, #CP_TRUCK_SPAWN_mov2 do
    stat_set_int(CP_TRUCK_SPAWN_mov2[i][1], true, CP_TRUCK_SPAWN_mov2[i][2])
end
end)
    
    menu.add_feature("# Force Supply Truck to Spawn at: Main Dock - East", "action", TRCK_SPWN.id, function()
    ui.notify_above_map("Done: The Truck will spawn at Main Dock - East", "Heist Control", 96)
    for i = 1, #CP_TRUCK_SPAWN_mov3 do
    stat_set_int(CP_TRUCK_SPAWN_mov3[i][1], true, CP_TRUCK_SPAWN_mov3[i][2])
end
end)
    
    menu.add_feature("# Force Supply Truck to Spawn at: Main Dock - West", "action", TRCK_SPWN.id, function()
    ui.notify_above_map("Done: The Truck will spawn at Main Dock - West", "Heist Control", 96)
    for i = 1, #CP_TRUCK_SPAWN_mov4 do
    stat_set_int(CP_TRUCK_SPAWN_mov4[i][1], true, CP_TRUCK_SPAWN_mov4[i][2])
end
end)
    
    menu.add_feature("# Force Supply Truck to Spawn at: Inside Compound", "action", TRCK_SPWN.id, function()
    ui.notify_above_map("Done: The Truck will spawn at Inside Compound", "Heist Control", 96)
    for i = 1, #CP_TRUCK_SPAWN_mov5 do
    stat_set_int(CP_TRUCK_SPAWN_mov5[i][1], true, CP_TRUCK_SPAWN_mov5[i][2])
end
end)
end
---

do

    local Diff_Normal = {

    {"H4_PROGRESS", 126823}
}

    local Diff_Hard = {

    {"H4_PROGRESS", 131055}
}

    local sub_option_A0 = menu.add_feature("# Heist Difficulty", "parent", CPMN.id)

    -- feature inside the parent
    menu.add_feature("# Change Difficulty to Normal", "action", sub_option_A0.id, function()
        ui.notify_above_map("~h~Difficulty has been changed to~n~~h~~g~Normal", "Heist Control - Difficulty Editor", 96)
        for i = 1, #Diff_Normal do
            stat_set_int(Diff_Normal[i][1], true, Diff_Normal[i][2])
        end
    end)
    
    -- feature inside the parent
    menu.add_feature("# Change Difficulty to Hard", "action", sub_option_A0.id, function()
        ui.notify_above_map("~h~Difficulty has been changed to~n~~h~~r~Hard", "Heist Control - Difficulty Editor", 96)
        for i = 1, #Diff_Hard do
            stat_set_int(Diff_Hard[i][1], true, Diff_Hard[i][2])
        end
    end)
end
---

do
    local CP_AWRD_BL = {

    {"AWD_INTELGATHER", true},
    {"AWD_COMPOUNDINFILT", true},
    {"AWD_LOOT_FINDER", true},
    {"AWD_MAX_DISRUPT", true},
    {"AWD_THE_ISLAND_HEIST", true},
    {"AWD_GOING_ALONE", true},
    {"AWD_TEAM_WORK", true},
    {"AWD_MIXING_UP", true},
    {"AWD_PRO_THIEF", true},
    {"AWD_CAT_BURGLAR", true},
    {"AWD_ONE_OF_THEM", true},
    {"AWD_GOLDEN_GUN", true},
    {"AWD_ELITE_THIEF", true},
    {"AWD_PROFESSIONAL", true},
    {"AWD_HELPING_OUT", true},
    {"AWD_COURIER", true},
    {"AWD_PARTY_VIBES", true},
    {"AWD_HELPING_HAND", true},
    {"AWD_ELEVENELEVEN", true},
    {"COMPLETE_H4_F_USING_VETIR", true},
    {"COMPLETE_H4_F_USING_LONGFIN", true},
    {"COMPLETE_H4_F_USING_ANNIH", true},
    {"COMPLETE_H4_F_USING_ALKONOS", true},
    {"COMPLETE_H4_F_USING_PATROLB", true}
}
    
    local CP_AWRD_IT = {
    
    {"AWD_LOSTANDFOUND", 500000},
    {"AWD_SUNSET", 1800000},
    {"AWD_TREASURE_HUNTER", 1000000},
    {"AWD_WRECK_DIVING", 1000000},
    {"AWD_KEINEMUSIK", 1800000},
    {"AWD_PALMS_TRAX", 1800000},
    {"AWD_MOODYMANN", 1800000},
    {"AWD_FILL_YOUR_BAGS", 1000000000},
    {"AWD_WELL_PREPARED", 80},
    {"H4_H4_DJ_MISSIONS", 65535}
}

local sub_option_B1 = menu.add_feature("# Cayo Perico Awards", "parent", CPMN.id)

-- Cayo Perico Awards
menu.add_feature("# Unlock Cayo Perico Awards 1 [INT]", "action", sub_option_B1.id, function()
    ui.notify_above_map("Awards 1 Unlocked Successfully", "Heist Control - Awards", 96)
    for i = 1, #CP_AWRD_IT do
        stat_set_int(CP_AWRD_IT[i][1], true, CP_AWRD_IT[i][2])
    end
end)

-- feature inside the parent
menu.add_feature("# Unlock Cayo Perico Awards 2 [BOOL]", "action", sub_option_B1.id, function()
        ui.notify_above_map("Awards 2 Unlocked Successfully", "Heist Control - Awards", 96)
    for i = 1, #CP_AWRD_BL do
        stat_set_bool(CP_AWRD_BL[i][1], true, CP_AWRD_BL[i][2])
    end
end)
end

---
do
    local CLD_RMV = {

    {"H4_COOLDOWN", -1},
    {"H4_COOLDOWN_HARD", -1},
    {"MPPLY_H4_COOLDOWN", -1}
}

    menu.add_feature("(!) Remove Repeat Cooldown", "action", CPMN.id, function()
    ui.notify_above_map("~h~This is not a bypass for the server-side cooldown", "Heist Control", 96)
    for i = 1, #CLD_RMV do
    stat_set_int(CLD_RMV[i][1], true, CLD_RMV[i][2])
    stat_set_int(CLD_RMV[i][1], false, CLD_RMV[i][2])
    end
end)
end
---
do
    local CP_RST = {

    {"H4_MISSIONS", 0},
    {"H4_PROGRESS", 0},
    {"H4CNF_APPROACH", 0},
    {"H4CNF_BS_ENTR", 0},
    {"H4CNF_BS_GEN", 0},
    {"H4_PLAYTHROUGH_STATUS", 0}
}

    menu.add_feature("# Set Heist to Default (Reset)", "action", CPMN.id, function()
        ui.notify_above_map("Heist has been restored", "Heist Control", 96)
    for i = 1, #CP_RST do
        stat_set_int(CP_RST[i][1], true, CP_RST[i][2])
    end
end)
end
---

-- DIAMOND CASINO STUFFS

do

    local CH_1CLK_vA = {

        {"H3_LAST_APPROACH", 4},
        {"H3OPT_APPROACH", 1},
        {"H3_HARD_APPROACH", 1},
        {"H3OPT_TARGET", 3},
        {"H3OPT_POI", 1023},
        {"H3OPT_ACCESSPOINTS", 2047},
        {"H3OPT_BITSET1", -1},
        {"H3OPT_CREWWEAP", 2},
        {"H3OPT_CREWDRIVER", 5},
        {"H3OPT_CREWHACKER", 4},
        {"H3OPT_WEAPS", 0},
        {"H3OPT_VEHS", 3},
        {"H3OPT_DISRUPTSHIP", 3},
        {"H3OPT_BODYARMORLVL", 3},
        {"H3OPT_KEYLEVELS", 2},
        {"H3OPT_MASKS", 2},
        {"H3OPT_BITSET0", -1}
    }
    
     local CH_1CLK_vA_N = {
    
        {"H3_LAST_APPROACH", 4},
        {"H3OPT_APPROACH", 1},
        {"H3_HARD_APPROACH", 0},
        {"H3OPT_TARGET", 3},
        {"H3OPT_POI", 1023},
        {"H3OPT_ACCESSPOINTS", 2047},
        {"H3OPT_BITSET1", -1},
        {"H3OPT_CREWWEAP", 2},
        {"H3OPT_CREWDRIVER", 5},
        {"H3OPT_CREWHACKER", 4},
        {"H3OPT_WEAPS", 0},
        {"H3OPT_VEHS", 3},
        {"H3OPT_DISRUPTSHIP", 3},
        {"H3OPT_BODYARMORLVL", 3},
        {"H3OPT_KEYLEVELS", 2},
        {"H3OPT_MASKS", 2},
        {"H3OPT_BITSET0", -1}
    }
    
     local CH_2CLK_vA = {
    
        {"H3_LAST_APPROACH", 4},
        {"H3OPT_APPROACH", 2},
        {"H3_HARD_APPROACH", 2},
        {"H3OPT_TARGET", 3},
        {"H3OPT_POI", 1023},
        {"H3OPT_ACCESSPOINTS", 2047},
        {"H3OPT_BITSET1", -1},
        {"H3OPT_CREWWEAP", 2},
        {"H3OPT_CREWDRIVER", 5},
        {"H3OPT_CREWHACKER", 4},
        {"H3OPT_WEAPS", 0},
        {"H3OPT_VEHS", 3},
        {"H3OPT_DISRUPTSHIP", 3},
        {"H3OPT_BODYARMORLVL", 3},
        {"H3OPT_KEYLEVELS", 2},
        {"H3OPT_MASKS", 2},
        {"H3OPT_BITSET0", -1}
    }
    
     local CH_2CLK_vA_N = {
    
        {"H3_LAST_APPROACH", 4},
        {"H3OPT_APPROACH", 2},
        {"H3_HARD_APPROACH", 0},
        {"H3OPT_TARGET", 3},
        {"H3OPT_POI", 1023},
        {"H3OPT_ACCESSPOINTS", 2047},
        {"H3OPT_BITSET1", -1},
        {"H3OPT_CREWWEAP", 2},
        {"H3OPT_CREWDRIVER", 5},
        {"H3OPT_CREWHACKER", 4},
        {"H3OPT_WEAPS", 0},
        {"H3OPT_VEHS", 3},
        {"H3OPT_DISRUPTSHIP", 3},
        {"H3OPT_BODYARMORLVL", 3},
        {"H3OPT_KEYLEVELS", 2},
        {"H3OPT_MASKS", 2},
        {"H3OPT_BITSET0", -1}
    }
    
     local CH_3CLK_vA = {
    
        {"H3_LAST_APPROACH", 4},
        {"H3OPT_APPROACH", 3},
        {"H3_HARD_APPROACH", 3},
        {"H3OPT_TARGET", 3},
        {"H3OPT_POI", 1023},
        {"H3OPT_ACCESSPOINTS", 2047},
        {"H3OPT_BITSET1", -1},
        {"H3OPT_CREWWEAP", 2},
        {"H3OPT_CREWDRIVER", 5},
        {"H3OPT_CREWHACKER", 4},
        {"H3OPT_WEAPS", 1},
        {"H3OPT_VEHS", 3},
        {"H3OPT_DISRUPTSHIP", 3},
        {"H3OPT_BODYARMORLVL", 3},
        {"H3OPT_KEYLEVELS", 2},
        {"H3OPT_MASKS", 2},
        {"H3OPT_BITSET0", -1}
    }
    
     local CH_3CLK_vA_N = {
    
        {"H3_LAST_APPROACH", 4},
        {"H3OPT_APPROACH", 3},
        {"H3_HARD_APPROACH", 0},
        {"H3OPT_TARGET", 3},
        {"H3OPT_POI", 1023},
        {"H3OPT_ACCESSPOINTS", 2047},
        {"H3OPT_BITSET1", -1},
        {"H3OPT_CREWWEAP", 2},
        {"H3OPT_CREWDRIVER", 5},
        {"H3OPT_CREWHACKER", 4},
        {"H3OPT_WEAPS", 1},
        {"H3OPT_VEHS", 3},
        {"H3OPT_DISRUPTSHIP", 3},
        {"H3OPT_BODYARMORLVL", 3},
        {"H3OPT_KEYLEVELS", 2},
        {"H3OPT_MASKS", 2},
        {"H3OPT_BITSET0", -1}
    }

    local CH_0sub = menu.add_feature("# Insta-Play (Presets)", "parent", CHMN.id)

    -- Casino Heist 1CLK Variations
    menu.add_feature("# Silent & Sneaky Approach (Hard)", "action", CH_0sub.id, function()
        ui.notify_above_map("~h~Approach: ~y~Silent & Sneaky~n~~s~Difficulty: ~r~Hard~s~ ~n~~s~Target: ~b~Diamond", "", 2)
        ui.notify_above_map("~h~Vehicle: ~n~~b~Everon ~g~(Chester McCoy)~n~~s~Weapon: ~n~~b~Rifle + Shotgun ~s~~g~(Gustavo Mota)", "", 2)
        ui.notify_above_map("~h~Hacker: ~b~Avi Schwartzman~s~~n~Undetected: ~g~3 minutes 30s~n~~s~Detected: ~g~2 minutes 26s", "", 2)
        ui.notify_above_map("~h~Mask: ~b~Hunter Set", "", 2)
        for i = 1, #CH_1CLK_vA do
            stat_set_int(CH_1CLK_vA[i][1], true, CH_1CLK_vA[i][2])
        end
    end)
    
    menu.add_feature("# Silent & Sneaky Approach (Normal)", "action", CH_0sub.id, function()
        ui.notify_above_map("~h~Approach: ~y~Silent & Sneaky~n~~s~Difficulty: ~g~Normal~s~ ~n~~s~Target: ~b~Diamond", "", 2)
        ui.notify_above_map("~h~Vehicle: ~n~~b~Everon ~g~(Chester McCoy)~n~~s~Weapon: ~n~~b~Rifle + Shotgun ~s~~g~(Gustavo Mota)", "", 2)
        ui.notify_above_map("~h~Hacker: ~b~Avi Schwartzman~s~~n~Undetected: ~g~3 minutes 30s~n~~s~Detected: ~g~2 minutes 26s", "", 2)
        ui.notify_above_map("~h~Mask: ~b~Hunter Set", "", 2)
        for i = 1, #CH_1CLK_vA_N do
            stat_set_int(CH_1CLK_vA_N[i][1], true, CH_1CLK_vA_N[i][2])
        end
    end)
    
    menu.add_feature("# BigCon Approach (Hard)", "action", CH_0sub.id, function()
        ui.notify_above_map("~h~Approach: ~y~BigCon ~n~~s~Difficulty: ~r~Hard~s~ ~n~~s~Target: ~b~Diamond", "", 2)
        ui.notify_above_map("~h~Vehicle: ~n~~b~Everon ~g~(Chester McCoy)~n~~s~Weapon: ~n~~b~Rifle + Pistol ~s~~g~(Gustavo Mota)", "", 2)
        ui.notify_above_map("~h~Hacker: ~b~Avi Schwartzman~s~~n~Undetected: ~g~3 minutes 30s~n~~s~Detected: ~g~2 minutes 26s", "", 2)
        ui.notify_above_map("~h~Mask: ~b~Hunter Set~s~~n~ All costumes unlocked", "", 2)
        for i = 1, #CH_2CLK_vA do
            stat_set_int(CH_2CLK_vA[i][1], true, CH_2CLK_vA[i][2])
        end
    end)
    
    menu.add_feature("# BigCon Approach (Normal)", "action", CH_0sub.id, function()
        ui.notify_above_map("~h~Approach: ~y~BigCon ~n~~s~Difficulty: ~g~Normal~s~ ~n~~s~Target: ~b~Diamond", "", 2)
        ui.notify_above_map("~h~Vehicle: ~n~~b~Everon ~g~(Chester McCoy)~n~~s~Weapon: ~n~~b~Rifle + Pistol ~s~~g~(Gustavo Mota)", "", 2)
        ui.notify_above_map("~h~Hacker: ~b~Avi Schwartzman~s~~n~Undetected: ~g~3 minutes 30s~n~~s~Detected: ~g~2 minutes 26s", "", 2)
        ui.notify_above_map("~h~Mask: ~b~Hunter Set~s~~n~ All costumes unlocked", "", 2)
        for i = 1, #CH_2CLK_vA_N do
            stat_set_int(CH_2CLK_vA_N[i][1], true, CH_2CLK_vA_N[i][2])
        end
    end)
    
    menu.add_feature("# Aggressive Approach (Hard)", "action", CH_0sub.id, function()
        ui.notify_above_map("~h~Approach: ~y~Aggressive ~n~~s~Difficulty: ~r~Hard~s~ ~n~~s~Target: ~b~Diamond", "", 2)
        ui.notify_above_map("~h~Vehicle: ~n~~b~Everon ~g~(Chester McCoy)~n~~s~Weapon:~n~~b~Sub. + Shotgun ~s~~g~(Gustavo Mota)", "", 2)
        ui.notify_above_map("~h~Hacker: ~b~Avi Schwartzman~s~~n~Undetected: ~g~3 minutes 30s~n~~s~Detected: ~g~2 minutes 26s", "", 2)
        ui.notify_above_map("~h~Mask: ~b~Hunter Set~s~~n~ All costumes unlocked", "", 2)
        for i = 1, #CH_3CLK_vA do
            stat_set_int(CH_3CLK_vA[i][1], true, CH_3CLK_vA[i][2])
        end
    end)
    
    menu.add_feature("# Aggressive Approach (Normal)", "action", CH_0sub.id, function()
        ui.notify_above_map("~h~Approach: ~y~Aggressive ~n~~s~Difficulty: ~g~Normal~s~ ~n~~s~Target: ~b~Diamond", "", 2)
        ui.notify_above_map("~h~Vehicle: ~n~~b~Everon ~g~(Chester McCoy)~n~~s~Weapon:~n~~b~Sub. + Shotgun ~s~~g~(Gustavo Mota)", "", 2)
        ui.notify_above_map("~h~Hacker: ~b~Avi Schwartzman~s~~n~Undetected: ~g~3 minutes 30s~n~~s~Detected: ~g~2 minutes 26s", "", 2)
        ui.notify_above_map("~h~Mask: ~b~Hunter Set~s~~n~ All costumes unlocked", "", 2)
        for i = 1, #CH_3CLK_vA_N do
            stat_set_int(CH_3CLK_vA_N[i][1], true, CH_3CLK_vA_N[i][2])
        end
    end)
end
---
do
    local CH_Diff_Hard1 = {

        {"H3_LAST_APPROACH", 0},
        {"H3OPT_APPROACH", 1},
        {"H3_HARD_APPROACH", 1}
    }
    
    local CH_Diff_Normal1 = {
    
        {"H3_LAST_APPROACH", 0},
        {"H3OPT_APPROACH", 1},
        {"H3_HARD_APPROACH", 0}
    
    }
    
    local CH_Diff_Hard2 = {
    
        {"H3_LAST_APPROACH", 0},
        {"H3OPT_APPROACH", 2},
        {"H3_HARD_APPROACH", 2}
    }
    
    local CH_Diff_Normal2 = {
    
        {"H3_LAST_APPROACH", 0},
        {"H3OPT_APPROACH", 2},
        {"H3_HARD_APPROACH", 0}
    }
    
    local CH_Diff_Hard3 = {
    
        {"H3_LAST_APPROACH", 0},
        {"H3OPT_APPROACH", 3},
        {"H3_HARD_APPROACH", 3}
    }
    
    local CH_Diff_Normal3 = {
    
        {"H3_LAST_APPROACH", 0},
        {"H3OPT_APPROACH", 3},
        {"H3_HARD_APPROACH", 0}
    }
    
    -- Casino Heist - Target Related
    local CH_Target_Diamond = {
    
        {"H3OPT_TARGET", 3}
    }
    
    local CH_Target_Artwork = {
    
        {"H3OPT_TARGET", 2}
    }
    
    local CH_Target_Gold = {
    
        {"H3OPT_TARGET", 1}
    }
    
    local CH_Target_Cash = {
    
        {"H3OPT_TARGET", 0}
    }
    
    -- Casino Heist - Unlockers
    
    local CH_UNLCK_PT = {
    
        {"H3OPT_POI", 1023},
        {"H3OPT_ACCESSPOINTS", 2047}
}

    local CH_1sub = menu.add_feature("# Planning Board (1) - Options", "parent", CHMN.id)

    --- CH - Unlocker Related
    menu.add_feature("# Unlock Points of Interests & Access Points", "action", CH_1sub.id, function()
        ui.notify_above_map("Unlocked Successfully", "Heist Control - Diamond Casino", 96)
        for i = 1, #CH_UNLCK_PT do
            stat_set_int(CH_UNLCK_PT[i][1], true, CH_UNLCK_PT[i][2])
        end
    end)
    
    
    local CH_diff = menu.add_feature("# Change Approach and Difficulty", "parent", CH_1sub.id)
    
    menu.add_feature("# Silent and Sneaky Approach - Hard", "action", CH_diff.id, function()
        ui.notify_above_map("Silent & Sneaky Approach - Difficulty modified to ~h~~r~Hard", "Heist Control - Difficulty Editor", 96)
        for i = 1, #CH_Diff_Hard1 do
            stat_set_int(CH_Diff_Hard1[i][1], true, CH_Diff_Hard1[i][2])
        end
    end)
    
    menu.add_feature("# Silent and Sneaky Approach - Normal", "action", CH_diff.id, function()
        ui.notify_above_map("Silent & Sneaky Approach - Difficulty modified to ~h~~g~Normal", "Heist Control - Difficulty Editor", 96)
        for i = 1, #CH_Diff_Normal1 do
            stat_set_int(CH_Diff_Normal1[i][1], true, CH_Diff_Normal1[i][2])
        end
    end)
    
    menu.add_feature("# The Big Con Approach - Hard", "action", CH_diff.id, function()
        ui.notify_above_map("BigCon Approach - Difficulty modified to ~h~~r~Hard", "Heist Control - Difficulty Editor", 96)
        for i = 1, #CH_Diff_Hard2 do
            stat_set_int(CH_Diff_Hard2[i][1], true, CH_Diff_Hard2[i][2])
        end
    end)
    
    menu.add_feature("# The Big Con Approach - Normal", "action", CH_diff.id, function()
        ui.notify_above_map("BigCon Approach - Difficulty modified to ~h~~g~Normal", "Heist Control - Difficulty Editor", 96)
        for i = 1, #CH_Diff_Normal2 do
            stat_set_int(CH_Diff_Normal2[i][1], true, CH_Diff_Normal2[i][2])
        end
    end)
    
    menu.add_feature("# Aggressive Heist Approach - Hard", "action", CH_diff.id, function()
        ui.notify_above_map("Aggressive Approach - Difficulty modified to ~r~~h~Hard", "Heist Control - Difficulty Editor", 96)
        for i = 1, #CH_Diff_Hard3 do
            stat_set_int(CH_Diff_Hard3[i][1], true, CH_Diff_Hard3[i][2])
        end
    end)
    
    menu.add_feature("# Aggressive Heist Approach - Normal", "action", CH_diff.id, function()
        ui.notify_above_map("Aggressive Aproach - Difficulty modified to ~h~~g~Normal", "Heist Control - Difficulty Editor", 96)
        for i = 1, #CH_Diff_Normal3 do
            stat_set_int(CH_Diff_Normal3[i][1], true, CH_Diff_Normal3[i][2])
        end
    end)

    local CH_Target = menu.add_feature("# Change Target", "parent", CH_1sub.id)

menu.add_feature("# Diamond", "action", CH_Target.id, function()
    ui.notify_above_map("~h~Target modified to ~h~~b~Diamond", "Heist Control - Target Editor", 96)
    for i = 1, #CH_Target_Diamond do
        stat_set_int(CH_Target_Diamond[i][1], true, CH_Target_Diamond[i][2])
    end
end)

menu.add_feature("# Gold", "action", CH_Target.id, function()
    ui.notify_above_map("~h~Target modified to ~h~~y~Gold", "Heist Control - Target Editor", 96)
    for i = 1, #CH_Target_Gold do
        stat_set_int(CH_Target_Gold[i][1], true, CH_Target_Gold[i][2])
    end
end)

menu.add_feature("# Artwork", "action", CH_Target.id, function()
    ui.notify_above_map("~h~Target modified to ~h~~p~Artwork", "Heist Control - Target Editor", 96)
    for i = 1, #CH_Target_Artwork do
        stat_set_int(CH_Target_Artwork[i][1], true, CH_Target_Artwork[i][2])
    end
end)

menu.add_feature("# Cash", "action", CH_Target.id, function()
    ui.notify_above_map("~h~Target modified to ~h~~g~Cash", "Heist Control - Target Editor", 96)
    for i = 1, #CH_Target_Cash do
        stat_set_int(CH_Target_Cash[i][1], true, CH_Target_Cash[i][2])
    end
end)
end

do
    local CH_GUNMAN_RND = {

    {"H3OPT_CREWWEAP", 1, 5, 1 ,5}
}
    
    local CH_GUNMAN_05 = {
    
    {"H3OPT_CREWWEAP", 4}
}
    
    local CH_GUNMAN_04 = {
    
    {"H3OPT_CREWWEAP", 2}
}
    
    local CH_GUNMAN_03 = {
    
    {"H3OPT_CREWWEAP", 5}
}
    
    local CH_GUNMAN_02 = {
    
    {"H3OPT_CREWWEAP", 3}
}
    
    local CH_GUNMAN_01 = {
    
    {"H3OPT_CREWWEAP", 1}
}
    
    local CH_GUNMAN_00 = {
    
    {"H3OPT_CREWWEAP", 6}
}
----
local CH_DRV_MAN_RND = {

    {"H3OPT_CREWDRIVER", 1, 5, 1 ,5}
}

local CH_DRV_MAN_05 = {

    {"H3OPT_CREWDRIVER", 5}
}

local CH_DRV_MAN_04 = {

    {"H3OPT_CREWDRIVER", 3}
}

local CH_DRV_MAN_03 = {

    {"H3OPT_CREWDRIVER", 2}
}

local CH_DRV_MAN_02 = {

    {"H3OPT_CREWDRIVER", 4}
}

local CH_DRV_MAN_01 = {

    {"H3OPT_CREWDRIVER", 1}
}

local CH_DRV_MAN_00 = {

    {"H3OPT_CREWDRIVER", 6}
}

-- Casino Heist - Vehicle Variation

local CH_DRV_MAN_var_RND = {

    {"H3OPT_VEHS", 0, 3, 0, 3}

}

local CH_DRV_MAN_var_03 = {

    {"H3OPT_VEHS", 3}
}

local CH_DRV_MAN_var_02 = {

    {"H3OPT_VEHS", 2}
}

local CH_DRV_MAN_var_01 = {

    {"H3OPT_VEHS", 1}
}

local CH_DRV_MAN_var_00 = {

    {"H3OPT_VEHS", 0}
}
---

local CH_Gunman_var_01 = {

    {"H3OPT_WEAPS", 1}
}

local CH_Gunman_var_00 = {

    {"H3OPT_WEAPS", 0}
}
---

local CH_HCK_MAN_05 = {

    {"H3OPT_CREWHACKER", 5}
}

local CH_HCK_MAN_04 = {

    {"H3OPT_CREWHACKER", 4}
}

local CH_HCK_MAN_03 = {

    {"H3OPT_CREWHACKER", 3}
}

local CH_HCK_MAN_02 = {

    {"H3OPT_CREWHACKER", 2}
}

local CH_HCK_MAN_01 = {

    {"H3OPT_CREWHACKER", 1}
}

local CH_HCK_MAN_00 = {

    {"H3OPT_CREWHACKER", 6}
}
----

local CH_HCK_MAN_RND = {

    {"H3OPT_CREWHACKER", 0, 5, 1, 5}
   
}

-----

local CH_UNLCK_1stboard = {

    {"H3OPT_BITSET1", -1}
}

local CH_UNLCK_1stboard_un = {
    
    {"H3OPT_BITSET1", 0}
}
----

local CH_MASK_00 = {

    {"H3OPT_MASKS", -1}
}

local CH_MASK_01 = {

    {"H3OPT_MASKS", 1}
}

local CH_MASK_02 = {

    {"H3OPT_MASKS", 2}
}

local CH_MASK_03 = {

    {"H3OPT_MASKS", 3}
}

local CH_MASK_04 = {

    {"H3OPT_MASKS", 4}
}

local CH_MASK_05 = {

    {"H3OPT_MASKS", 5}
}

local CH_MASK_06 = {

    {"H3OPT_MASKS", 6}
}

local CH_MASK_07 = {

    {"H3OPT_MASKS", 7}
}

local CH_MASK_08 = {

    {"H3OPT_MASKS", 8}
}

local CH_MASK_09 = {

    {"H3OPT_MASKS", 9}
}

local CH_MASK_10 = {

    {"H3OPT_MASKS", 10}
}

local CH_MASK_11 = {

    {"H3OPT_MASKS", 11}
}

local CH_MASK_12 = {

    {"H3OPT_MASKS", 12}
}
-----

-- Casino Heist Duggan Guards

local CH_DUGGAN = {

    {"H3OPT_DISRUPTSHIP", 3}
}
-- Casino Heist Scan Card Level

local CH_SCANC_LVL = {

    {"H3OPT_KEYLEVELS", 2}
}
----

    local CH_2sub = menu.add_feature("# Planning Board (2) - Options", "parent", CHMN.id)

    local CH_Gunman = menu.add_feature("# Change Gunman", "parent", CH_2sub.id)
    
    menu.add_feature("# Chester McCoy - 10%", "action", CH_Gunman.id, function()
        ui.notify_above_map("Chester McCoy as Gunman", "Heist Control - Gunman Member", 96)
        for i = 1, #CH_GUNMAN_05 do
            stat_set_int(CH_GUNMAN_05[i][1], true, CH_GUNMAN_05[i][2])
        end
    end)
    
    menu.add_feature("# Gustavo Mota - 9%", "action", CH_Gunman.id, function()
        ui.notify_above_map("Gustavo Mota as Gunman", "Heist Control - Gunman Member", 96)
        for i = 1, #CH_GUNMAN_04 do
            stat_set_int(CH_GUNMAN_04[i][1], true, CH_GUNMAN_04[i][2])
        end
    end)
    
    menu.add_feature("# Patrick McReary - 8%", "action", CH_Gunman.id, function()
        ui.notify_above_map("Patrick McReary as Gunman", "Heist Control - Gunman Member", 96)
        for i = 1, #CH_GUNMAN_03 do
            stat_set_int(CH_GUNMAN_03[i][1], true, CH_GUNMAN_03[i][2])
        end
    end)
    
    menu.add_feature("# Charlie Reed - 7%", "action", CH_Gunman.id, function()
        ui.notify_above_map("Charlie Reed as Gunman", "Heist Control - Gunman Member", 96)
        for i = 1, #CH_GUNMAN_02 do
            stat_set_int(CH_GUNMAN_02[i][1], true, CH_GUNMAN_02[i][2])
        end
    end)
    
    menu.add_feature("# Karl Abolaji - 5%", "action", CH_Gunman.id, function()
        ui.notify_above_map("Karl Abolaji as Gunman", "Heist Control - Gunman Member", 96)
        for i = 1, #CH_GUNMAN_01 do
            stat_set_int(CH_GUNMAN_01[i][1], true, CH_GUNMAN_01[i][2])
        end
    end)
    
    menu.add_feature("# Random Gunman Member", "action", CH_Gunman.id, function()
        ui.notify_above_map("Gunman Randomized", "Heist Control - Gunman Member", 96)
        for i = 1, #CH_GUNMAN_RND do
            stat_set_int(CH_GUNMAN_RND[i][1], true, math.random(CH_GUNMAN_RND[i][4], CH_GUNMAN_RND[i][5]))
        end
    end)
    
    menu.add_feature("# Remove Gunman Member - (0% Payout)", "action", CH_Gunman.id, function()
        ui.notify_above_map("~h~~r~Gunman Member Removed", "Heist Control - Gunman Member", 96)
        for i = 1, #CH_GUNMAN_00 do
            stat_set_int(CH_GUNMAN_00[i][1], true, CH_GUNMAN_00[i][2])
        end
    end)
    
    local CH_Gunman_sub = menu.add_feature("# Weapon Variation", "parent", CH_Gunman.id)
    
    menu.add_feature("# Best Variation", "action", CH_Gunman_sub.id, function()
        ui.notify_above_map("Variation Changed to Best", "Heist Control - Gunman Weapons", 96)
        for i = 1, #CH_Gunman_var_01 do
            stat_set_int(CH_Gunman_var_01[i][1], true, CH_Gunman_var_01[i][2])
        end
    end)
    
    menu.add_feature("# Worst Variation", "action", CH_Gunman_sub.id, function()
        ui.notify_above_map("Variation Changed to Worst", "Heist Control - Gunman Weapons", 96)
        for i = 1, #CH_Gunman_var_00 do
            stat_set_int(CH_Gunman_var_00[i][1], true, CH_Gunman_var_00[i][2])
        end
    end)
    
    
    --- Casino Heist Crew Driver
    local CH_DRV_CREW = menu.add_feature("# Change Driver Crew", "parent", CH_2sub.id)
    
    menu.add_feature("# Chester McCoy - 10%", "action", CH_DRV_CREW.id, function()
        ui.notify_above_map("Chester McCoy as Driver", "Heist Control - Driver Member", 96)
        for i = 1, #CH_DRV_MAN_05 do
            stat_set_int(CH_DRV_MAN_05[i][1], true, CH_DRV_MAN_05[i][2])
        end
    end)
    
    menu.add_feature("# Eddie Toh - 9%", "action", CH_DRV_CREW.id, function()
        ui.notify_above_map("Eddie Toh as Driver", "Heist Control - Driver Member", 96)
        for i = 1, #CH_DRV_MAN_04 do
            stat_set_int(CH_DRV_MAN_04[i][1], true, CH_DRV_MAN_04[i][2])
        end
    end)
    
    menu.add_feature("# Taliana Martinez - 7%", "action", CH_DRV_CREW.id, function()
        ui.notify_above_map("Taliana Martinez as Driver", "Heist Control - Driver Member", 96)
        for i = 1, #CH_DRV_MAN_03 do
            stat_set_int(CH_DRV_MAN_03[i][1], true, CH_DRV_MAN_03[i][2])
        end
    end)
    
    menu.add_feature("# Zach Nelson - 6%", "action", CH_DRV_CREW.id, function()
        ui.notify_above_map("Zach Nelson as Driver", "Heist Control - Driver Member", 96)
        for i = 1, #CH_DRV_MAN_02 do
            stat_set_int(CH_DRV_MAN_02[i][1], true, CH_DRV_MAN_02[i][2])
        end
    end)
    
    menu.add_feature("# Karim Denz - 5%", "action", CH_DRV_CREW.id, function()
        ui.notify_above_map("Karim Denz as Driver", "Heist Control - Driver Member", 96)
        for i = 1, #CH_DRV_MAN_01 do
            stat_set_int(CH_DRV_MAN_01[i][1], true, CH_DRV_MAN_01[i][2])
        end
    end)
    
    menu.add_feature("# Random Driver Member", "action", CH_DRV_CREW.id, function()
        ui.notify_above_map("Driver Randomized", "Heist Control - Driver Member", 96)
        for i = 1, #CH_DRV_MAN_var_RND do
            stat_set_int(CH_DRV_MAN_RND[i][1], true, math.random(CH_DRV_MAN_RND[i][4], CH_DRV_MAN_RND[i][5]))
        end
    end)
    
    menu.add_feature("# Remove Driver Member - (0% Payout)", "action", CH_DRV_CREW.id, function()
        ui.notify_above_map("~h~~r~Driver Member Removed", "Heist Control - Driver Member", 96)
        for i = 1, #CH_DRV_MAN_00 do
            stat_set_int(CH_DRV_MAN_00[i][1], true, CH_DRV_MAN_00[i][2])
        end
    end)
    
    -- Casino Heist - Vehicles Variation
    
    local CH_DRV_CREW_var = menu.add_feature("# Vehicle Variation", "parent", CH_DRV_CREW.id)
    
    menu.add_feature("# Best Variation", "action", CH_DRV_CREW_var.id, function()
        ui.notify_above_map("Best Variation Selected", "Heist Control - Vehicle Editor", 96)
        for i = 1, #CH_DRV_MAN_var_03 do
            stat_set_int(CH_DRV_MAN_var_03[i][1], true, CH_DRV_MAN_var_03[i][2])
        end
    end)
    
    menu.add_feature("# Good Variation", "action", CH_DRV_CREW_var.id, function()
        ui.notify_above_map("Good Variation Selected", "Heist Control - Vehicle Editor", 96)
        for i = 1, #CH_DRV_MAN_var_02 do
            stat_set_int(CH_DRV_MAN_var_02[i][1], true, CH_DRV_MAN_var_02[i][2])
        end
    end)
    
    menu.add_feature("# Fine Variation", "action", CH_DRV_CREW_var.id, function()
        ui.notify_above_map("Fine Variation Selected", "Heist Control - Vehicle Editor", 96)
        for i = 1, #CH_DRV_MAN_var_01 do
            stat_set_int(CH_DRV_MAN_var_01[i][1], true, CH_DRV_MAN_var_01[i][2])
        end
    end)
    
    menu.add_feature("# Worst Variation", "action", CH_DRV_CREW_var.id, function()
        ui.notify_above_map("Worst Variation Selected", "Heist Control - Vehicle Editor", 96)
        for i = 1, #CH_DRV_MAN_var_00 do
            stat_set_int(CH_DRV_MAN_var_00[i][1], true, CH_DRV_MAN_var_00[i][2])
        end
    end)
    
    menu.add_feature("# Random Car Variation", "action", CH_DRV_CREW_var.id, function()
        ui.notify_above_map("Randomized", "Heist Control - Crew Editor", 96)
        for i = 1, #CH_DRV_MAN_var_RND do
            stat_set_int(CH_DRV_MAN_var_RND[i][1], true, math.random(CH_DRV_MAN_var_RND[i][4], CH_DRV_MAN_var_RND[i][5]))
        end
    end)
    
    -- Casino Heist - Crew Hacker Related
    
    local CH_HCK_CREW = menu.add_feature("# Change Hacker Crew", "parent", CH_2sub.id)
    
    menu.add_feature("# Avi Schwartzman - 10%", "action", CH_HCK_CREW.id, function()
        ui.notify_above_map("Avi Schwartzman as Hacker", "Heist Control - Hacker Member", 96)
        for i = 1, #CH_HCK_MAN_04 do
            stat_set_int(CH_HCK_MAN_04[i][1], true, CH_HCK_MAN_04[i][2])
        end
    end)
    
    menu.add_feature("# Paige Harris - 9%", "action", CH_HCK_CREW.id, function()
        ui.notify_above_map("Paige Harris as Hacker ", "Heist Control - Hacker Member", 96)
        for i = 1, #CH_HCK_MAN_05 do
            stat_set_int(CH_HCK_MAN_05[i][1], true, CH_HCK_MAN_05[i][2])
        end
    end)
    
    menu.add_feature("# Christian Feltz - 7%", "action", CH_HCK_CREW.id, function()
        ui.notify_above_map("Christian Feltz as Hacker", "Heist Control - Hacker Member", 96)
        for i = 1, #CH_HCK_MAN_03 do
            stat_set_int(CH_HCK_MAN_03[i][1], true, CH_HCK_MAN_03[i][2])
        end
    end)
    
    menu.add_feature("# Yohan Blair - 5%", "action", CH_HCK_CREW.id, function()
        ui.notify_above_map("Yohan Blair as Hacker", "Heist Control - Hacker Member", 96)
        for i = 1, #CH_HCK_MAN_02 do
            stat_set_int(CH_HCK_MAN_02[i][1], true, CH_HCK_MAN_02[i][2])
        end
    end)
    
    menu.add_feature("# Rickie Luken - 3%", "action", CH_HCK_CREW.id, function()
        ui.notify_above_map("Rickie Luken as Hacker", "Heist Control - Hacker Member", 96)
        for i = 1, #CH_HCK_MAN_01 do
            stat_set_int(CH_HCK_MAN_01[i][1], true, CH_HCK_MAN_01[i][2])
        end
    end)
    
    menu.add_feature("# Random Hacker Member", "action", CH_HCK_CREW.id, function()
        ui.notify_above_map("Hacker Randomized", "Heist Control - Hacker Member", 96)
        for i = 1, #CH_HCK_MAN_RND do
            stat_set_int(CH_HCK_MAN_RND[i][1], true, math.random(CH_HCK_MAN_RND[i][4], CH_HCK_MAN_RND[i][5]))
        end
    end)
    
    
    menu.add_feature("# Remove Hacker Member - (0% Payout)", "action", CH_HCK_CREW.id, function()
        ui.notify_above_map("~h~~r~Hacker Member Removed", "Heist Control - Hacker Member", 96)
        for i = 1, #CH_HCK_MAN_00 do
            stat_set_int(CH_HCK_MAN_00[i][1], true, CH_HCK_MAN_00[i][2])
        end
    end)
    
    -- Casino Heist - Board Loader
    
    menu.add_feature("# Load (1st/2nd) Board", "action", CHMN.id, function()
        ui.notify_above_map("Loaded", "Heist Control", 96)
        for i = 1, #CH_UNLCK_1stboard do
            stat_set_int(CH_UNLCK_1stboard[i][1], true, CH_UNLCK_1stboard[i][2])
        end
    end)
    
    menu.add_feature("# Unload (1st/2nd) Board", "action", CHMN.id, function()
        ui.notify_above_map("Unloaded", "Heist Control", 96)
        for i = 1, #CH_UNLCK_1stboard_un do
            stat_set_int(CH_UNLCK_1stboard_un[i][1], true, CH_UNLCK_1stboard_un[i][2])
        end
    end)
    
    local CH_MASK_VAR = menu.add_feature("# Choose Mask", "parent", CH_2sub.id)

    menu.add_feature("# Remove Mask", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~r~Removed", "Heist Control", 96)
        for i = 1, #CH_MASK_00 do
            stat_set_int(CH_MASK_00[i][1], true, CH_MASK_00[i][2])
        end
    end)
    
    menu.add_feature("# Geometric Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Geometric Set", "Heist Control", 96)
        for i = 1, #CH_MASK_01 do
            stat_set_int(CH_MASK_01[i][1], true, CH_MASK_01[i][2])
        end
    end)
    
    menu.add_feature("# Hunter Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Hunter Set", "Heist Control", 96)
        for i = 1, #CH_MASK_02 do
            stat_set_int(CH_MASK_02[i][1], true, CH_MASK_02[i][2])
        end
    end)
    
    menu.add_feature("# Oni Half Mask Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Oni Half Mask Set", "Heist Control", 96)
        for i = 1, #CH_MASK_03 do
            stat_set_int(CH_MASK_03[i][1], true, CH_MASK_03[i][2])
        end
    end)
    
    menu.add_feature("# Emoji Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Emoji Set", "Heist Control", 96)
        for i = 1, #CH_MASK_04 do
            stat_set_int(CH_MASK_04[i][1], true, CH_MASK_04[i][2])
        end
    end)
    
    menu.add_feature("# Ornate Skull Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Ornate Skull Set", "Heist Control", 96)
        for i = 1, #CH_MASK_05 do
            stat_set_int(CH_MASK_05[i][1], true, CH_MASK_05[i][2])
        end
    end)
    
    menu.add_feature("# Lucky Fruit Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Lucky Fruit Set", "Heist Control", 96)
        for i = 1, #CH_MASK_06 do
            stat_set_int(CH_MASK_06[i][1], true, CH_MASK_06[i][2])
        end
    end)
    
    menu.add_feature("# Guerilla Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Guerilla Set", "Heist Control", 96)
        for i = 1, #CH_MASK_07 do
            stat_set_int(CH_MASK_07[i][1], true, CH_MASK_07[i][2])
        end
    end)
    
    menu.add_feature("# Clown Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Clown Set", "Heist Control", 96)
        for i = 1, #CH_MASK_08 do
            stat_set_int(CH_MASK_08[i][1], true, CH_MASK_08[i][2])
        end
    end)
    
    menu.add_feature("# Animal Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Animal Set", "Heist Control", 96)
        for i = 1, #CH_MASK_09 do
            stat_set_int(CH_MASK_09[i][1], true, CH_MASK_09[i][2])
        end
    end)
    
    menu.add_feature("# Riot Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Riot Set", "Heist Control", 96)
        for i = 1, #CH_MASK_10 do
            stat_set_int(CH_MASK_10[i][1], true, CH_MASK_10[i][2])
        end
    end)
    
    menu.add_feature("# Oni Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Oni Set", "Heist Control", 96)
        for i = 1, #CH_MASK_11 do
            stat_set_int(CH_MASK_11[i][1], true, CH_MASK_11[i][2])
        end
    end)
    
    menu.add_feature("# Hocket Set", "action", CH_MASK_VAR.id, function()
        ui.notify_above_map("~h~Mask: ~g~Hockey Set", "Heist Control", 96)
        for i = 1, #CH_MASK_12 do
            stat_set_int(CH_MASK_12[i][1], true, CH_MASK_12[i][2])
        end
    end)
    
    menu.add_feature("# Unlock Scan Card - LVL 2", "action", CH_2sub.id, function()
        ui.notify_above_map("Scan Card LVL 2 - Applied", "Heist Control", 96)
        for i = 1, #CH_SCANC_LVL do
            stat_set_int(CH_SCANC_LVL[i][1], true, CH_SCANC_LVL[i][2])
        end
    end)
    
    menu.add_feature("# Remove Duggan Heavy Guards", "action", CH_2sub.id, function()
        ui.notify_above_map("Duggan Heavy Guards Removed", "Heist Control", 96)
        for i = 1, #CH_DUGGAN do
            stat_set_int(CH_DUGGAN[i][1], true, CH_DUGGAN[i][2])
        end
    end)
end
---
do
    local CH_UNLCK_3stboard = {

    {"H3OPT_BITSET0", -1}
}
    
    local CH_UNLCK_3stboard_var1 = {
    
    {"H3OPT_BITSET0", -8849}
}
    
    local CH_UNLCK_3stboard_var3bc = {
    
    {"H3OPT_BITSET0", -186}
}
    
    local CH_UNLCK_3stboard_un = {
    
     {"H3OPT_BITSET0", 0}
}

    local CH_HEIST_BOARD3 = menu.add_feature("# Planning Board (3) - Options", "parent", CHMN.id)

menu.add_feature("# Load Planning Board (3) with all options", "action", CH_HEIST_BOARD3.id, function()
    ui.notify_above_map("Settings Loaded", "Heist Control", 96)
    for i = 1, #CH_UNLCK_3stboard do
        stat_set_int(CH_UNLCK_3stboard[i][1], true, CH_UNLCK_3stboard[i][2])
    end
end)

menu.add_feature("# Remove Drill for Silent and Agressive Approach", "action", CH_HEIST_BOARD3.id, function()
    ui.notify_above_map("Settings Loaded", "Heist Control", 96)
    for i = 1, #CH_UNLCK_3stboard_var1 do
        stat_set_int(CH_UNLCK_3stboard_var1[i][1], true, CH_UNLCK_3stboard_var1[i][2])
    end
end)

menu.add_feature("# Remove Drill BigCon Approach only", "action", CH_HEIST_BOARD3.id, function()
    ui.notify_above_map("Settings Loaded", "Heist Control", 96)
    for i = 1, #CH_UNLCK_3stboard_var3bc do
        stat_set_int(CH_UNLCK_3stboard_var3bc[i][1], true, CH_UNLCK_3stboard_var3bc[i][2])
    end
end)

menu.add_feature("# Unload the Planning Board (3)", "action", CH_HEIST_BOARD3.id, function()
    ui.notify_above_map("Settings Unloaded", "Heist Control", 96)
    for i = 1, #CH_UNLCK_3stboard_un do
        stat_set_int(CH_UNLCK_3stboard_un[i][1], true, CH_UNLCK_3stboard_un[i][2])
    end
end)
end
----
do
    local CH_AWRD_BL = {

        {"AWD_FIRST_TIME1", true},
        {"AWD_FIRST_TIME2", true},
        {"AWD_FIRST_TIME3", true},
        {"AWD_FIRST_TIME4", true},
        {"AWD_FIRST_TIME5", true},
        {"AWD_FIRST_TIME6", true},
        {"AWD_ALL_IN_ORDER", true},
        {"AWD_SUPPORTING_ROLE", true},
        {"AWD_LEADER", true},
        {"AWD_ODD_JOBS", true},
        {"AWD_SURVIVALIST", true},
        {"AWD_SCOPEOUT", true},
        {"AWD_CREWEDUP", true},
        {"AWD_MOVINGON", true},
        {"AWD_PROMOCAMP", true},
        {"AWD_GUNMAN", true},
        {"AWD_SMASHNGRAB", true},
        {"AWD_INPLAINSI", true},
        {"AWD_UNDETECTED", true},
        {"AWD_ALLROUND", true},
        {"AWD_ELITETHEIF", true},
        {"AWD_PRO", true},
        {"AWD_SUPPORTACT", true},
        {"AWD_SHAFTED", true},
        {"AWD_COLLECTOR", true},
        {"AWD_DEADEYE", true},
        {"AWD_PISTOLSATDAWN", true},
        {"AWD_TRAFFICAVOI", true},
        {"AWD_CANTCATCHBRA", true},
        {"AWD_WIZHARD", true},
        {"AWD_APEESCAPE", true},
        {"AWD_MONKEYKIND", true},
        {"AWD_AQUAAPE", true},
        {"AWD_KEEPFAITH", true},
        {"AWD_TRUELOVE", true},
        {"AWD_NEMESIS", true},
        {"AWD_FRIENDZONED", true},
        {"VCM_FLOW_CS_RSC_SEEN", true},
        {"VCM_FLOW_CS_BWL_SEEN", true},
        {"VCM_FLOW_CS_MTG_SEEN", true},
        {"VCM_FLOW_CS_OIL_SEEN", true},
        {"VCM_FLOW_CS_DEF_SEEN", true},
        {"VCM_FLOW_CS_FIN_SEEN", true},
        {"CAS_VEHICLE_REWARD", false},
        {"HELP_FURIA", true},
        {"HELP_MINITAN", true},
        {"HELP_YOSEMITE2", true},
        {"HELP_ZHABA", true},
        {"HELP_IMORGEN", true},
        {"HELP_SULTAN2", true},
        {"HELP_VAGRANT", true},
        {"HELP_VSTR", true},
        {"HELP_STRYDER", true},
        {"HELP_SUGOI", true},
        {"HELP_KANJO", true},
        {"HELP_FORMULA", true},
        {"HELP_FORMULA2", true},
        {"HELP_JB7002", true}
    }
    
    local CH_AWRD_IT = {
    
        {"CH_ARC_CAB_CLAW_TROPHY", -1},
        {"CH_ARC_CAB_LOVE_TROPHY", -1},
        {"SIGNAL_JAMMERS_COLLECTED", 50},
        {"AWD_ODD_JOBS", 52},
        {"AWD_PREPARATION", 40},
        {"AWD_ASLEEPONJOB", 20},
        {"AWD_DAICASHCRAB", 100000},
        {"AWD_BIGBRO", 40},
        {"AWD_SHARPSHOOTER", 40},
        {"AWD_RACECHAMP", 40},
        {"AWD_BATSWORD", 1000000},
        {"AWD_COINPURSE", 950000},
        {"AWD_ASTROCHIMP", 3000000},
        {"AWD_MASTERFUL", 40000},
        {"VCM_FLOW_PROGRESS", 1839072},
        {"VCM_STORY_PROGRESS", 0},
        {"H3_BOARD_DIALOGUE0", -1},
        {"H3_BOARD_DIALOGUE1", -1},
        {"H3_BOARD_DIALOGUE2", -1},
        {"H3_VEHICLESUSED", -1}
    }

    local CH_HEIST_AWD = menu.add_feature("# Diamond Casino Awards", "parent", CHMN.id)

menu.add_feature("# Unlock Casino Awards 1 [INT]", "action", CH_HEIST_AWD.id, function()
    ui.notify_above_map("Awards 1 Unlocked Successfully", "Heist Control - Awards", 96)
    for i = 1, #CH_AWRD_IT do
        stat_set_int(CH_AWRD_IT[i][1], true, CH_AWRD_IT[i][2])
    end
end)

-- feature inside the parent
menu.add_feature("# Unlock Casino Awards 2 [BOOL]", "action", CH_HEIST_AWD.id, function()
        ui.notify_above_map("Awards 2 Unlocked Successfully", "Heist Control - Awards", 96)
    for i = 1, #CH_AWRD_BL do
        stat_set_bool(CH_AWRD_BL[i][1], true, CH_AWRD_BL[i][2])
    end
end)
end
------

do
    local CLD_CH_RMV = {

    {"H3_COMPLETEDPOSIX", -1},
    {"MPPLY_H3_COOLDOWN", -1}
}

    menu.add_feature("(!) Remove Repeat Cooldown", "action", CHMN.id, function()
        ui.notify_above_map("~h~This is not a bypass for the server-side cooldown", "Heist Control", 96)
    for i = 1, #CLD_CH_RMV do
        stat_set_int(CLD_CH_RMV[i][1], true, CLD_CH_RMV[i][2])
        stat_set_int(CLD_CH_RMV[i][1], false, CLD_CH_RMV[i][2])
    end
end)
end
--------
do
    local CH_RST = {

        {"H3_LAST_APPROACH", 0},
        {"H3OPT_APPROACH", 0},
        {"H3_HARD_APPROACH", 0},
        {"H3OPT_TARGET", 0},
        {"H3OPT_POI", 0},
        {"H3OPT_ACCESSPOINTS", 0},
        {"H3OPT_BITSET1", 0},
        {"H3OPT_CREWWEAP", 0},
        {"H3OPT_CREWDRIVER", 0},
        {"H3OPT_CREWHACKER", 0},
        {"H3OPT_WEAPS", 0},
        {"H3OPT_VEHS", 0},
        {"H3OPT_DISRUPTSHIP", 0},
        {"H3OPT_BODYARMORLVL", 0},
        {"H3OPT_KEYLEVELS", 0},
        {"H3OPT_MASKS", 0},
        {"H3OPT_BITSET0", 0}
}

menu.add_feature("# Set Heist to Default (Reset)", "action", CHMN.id, function()
        ui.notify_above_map("Now call Lester and try to cancel the Casino Heist", "Heist Control", 96)
    for i = 1, #CH_RST do
        stat_set_int(CH_RST[i][1], true, CH_RST[i][2])
    end
end)
end
-----------
do
    local CH_REM_CREW = {

        {"H3OPT_CREWWEAP", 6},
        {"H3OPT_CREWDRIVER", 6},
        {"H3OPT_CREWHACKER", 6}
    }
    

menu.add_feature("# Remove all crew members (0% Payout)", "action", CHMN.id, function()
        ui.notify_above_map("~h~~y~It is recommended to use this after stealing the main target!~n~~b~All Members Removed", "Heist Control", 96)
    for i = 1, #CH_REM_CREW do
        stat_set_int(CH_REM_CREW[i][1], true, CH_REM_CREW[i][2])
    end
end)
end

------ DOOMSDAY HEIST
do
    local DD_H_ACT1 = {

        {"GANGOPS_FLOW_MISSION_PROG", 503},
        {"GANGOPS_HEIST_STATUS", -229383},
        {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
    }
    
    local DD_H_ACT2 = {
    
        {"GANGOPS_FLOW_MISSION_PROG", 240},
        {"GANGOPS_HEIST_STATUS", -229378},
        {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
    }
    
    local DD_H_ACT3 = {
    
        {"GANGOPS_FLOW_MISSION_PROG", 16368},
        {"GANGOPS_HEIST_STATUS", -229380},
        {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
    }
    
    local DD_H_RST = {
    
        {"GANGOPS_FLOW_MISSION_PROG", 240},
        {"GANGOPS_HEIST_STATUS", 0},
        {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
    }
    
    local DD_H_ULCK = {
    
        {"GANGOPS_HEIST_STATUS", -1},
        {"GANGOPS_HEIST_STATUS", -229384}
    }
    
    local DD_PREPS_DONE = {
    
        {"GANGOPS_FM_MISSION_PROG", -1}
}

menu.add_feature("# The Data Breaches - ACT1 (Skip to Final)", "action", DDPR.id, function()
    ui.notify_above_map("The Data Breaches - Loaded", "Heist Control", 96)
    for i = 1, #DD_H_ACT1 do
        stat_set_int(DD_H_ACT1[i][1], true, DD_H_ACT1[i][2])
    end
end)

menu.add_feature("# The Bogdan Problem - ACT2 (Skip to Final)", "action", DDPR.id, function()
    ui.notify_above_map("The Bogdan Problem - Loaded", "Heist Control", 96)
    for i = 1, #DD_H_ACT2 do
        stat_set_int(DD_H_ACT2[i][1], true, DD_H_ACT2[i][2])
    end
end)

menu.add_feature("# The Doomsday Scenario - ACT3 (Skip to Final)", "action", DDPR.id, function()
    ui.notify_above_map("The Doomsday Scenario - Loaded", "Heist Control", 96)
    for i = 1, #DD_H_ACT3 do
        stat_set_int(DD_H_ACT3[i][1], true, DD_H_ACT3[i][2])
    end
end)

menu.add_feature("# Unlock all Doomsday Heist", "action", DHMN.id, function()
    ui.notify_above_map("Call the Lester and ask to cancel the Doomsday Heist x3", "Heist Control", 96)
    ui.notify_above_map("Do this only once", "Heist Control", 96)
    for i = 1, #DD_H_ULCK do
        stat_set_int(DD_H_ULCK[i][1], true, DD_H_ULCK[i][2])
    end
end)

menu.add_feature("# Set Preps as done (Not setups)", "action", DHMN.id, function()
    ui.notify_above_map("All Preps are completed", "Heist Control", 96)
    for i = 1, #DD_PREPS_DONE do
        stat_set_int(DD_PREPS_DONE[i][1], true, DD_PREPS_DONE[i][2])
    end
end)

menu.add_feature("# Set Heist to Default (Reset)", "action", DHMN.id, function()
    ui.notify_above_map("Doomsday restored", "Heist Control", 96)
    ui.notify_above_map("Go to a new session!!!", "Heist Control - IMPORTANT", 27)
    for i = 1, #DD_H_RST do
        stat_set_int(DD_H_RST[i][1], true, DD_H_RST[i][2])
    end
end)
end

----

do
    local DD_AWARDS_I = {

        {"GANGOPS_FM_MISSION_PROG", -1},
        {"GANGOPS_FLOW_MISSION_PROG", -1},
        {"MPPLY_GANGOPS_ALLINORDER", 100},
        {"MPPLY_GANGOPS_LOYALTY", 100},
        {"MPPLY_GANGOPS_CRIMMASMD", 100},
        {"MPPLY_GANGOPS_LOYALTY2", 100},
        {"MPPLY_GANGOPS_LOYALTY3", 100},
        {"MPPLY_GANGOPS_CRIMMASMD2", 100},
        {"MPPLY_GANGOPS_CRIMMASMD3", 100},
        {"MPPLY_GANGOPS_SUPPORT", 100},
        {"CR_GANGOP_MORGUE", 10},
        {"CR_GANGOP_DELUXO", 10},
        {"CR_GANGOP_SERVERFARM", 10},
        {"CR_GANGOP_IAABASE_FIN", 10},
        {"CR_GANGOP_STEALOSPREY", 10},
        {"CR_GANGOP_FOUNDRY", 10},
        {"CR_GANGOP_RIOTVAN", 10},
        {"CR_GANGOP_SUBMARINECAR", 10},
        {"CR_GANGOP_SUBMARINE_FIN", 10},
        {"CR_GANGOP_PREDATOR", 10},
        {"CR_GANGOP_BMLAUNCHER", 10},
        {"CR_GANGOP_BCCUSTOM", 10},
        {"CR_GANGOP_STEALTHTANKS", 10},
        {"CR_GANGOP_SPYPLANE", 10},
        {"CR_GANGOP_FINALE", 10},
        {"CR_GANGOP_FINALE_P2", 10},
        {"CR_GANGOP_FINALE_P3", 10}
    }
    
    local DD_AWARDS_B = {
    
        {"MPPLY_AWD_GANGOPS_IAA", true},
        {"MPPLY_AWD_GANGOPS_SUBMARINE", true},
        {"MPPLY_AWD_GANGOPS_MISSILE", true},
        {"MPPLY_AWD_GANGOPS_ALLINORDER", true},
        {"MPPLY_AWD_GANGOPS_LOYALTY", true},
        {"MPPLY_AWD_GANGOPS_LOYALTY2", true},
        {"MPPLY_AWD_GANGOPS_LOYALTY3", true},
        {"MPPLY_AWD_GANGOPS_CRIMMASMD", true},
        {"MPPLY_AWD_GANGOPS_CRIMMASMD2", true},
        {"MPPLY_AWD_GANGOPS_CRIMMASMD3", true}
    }

    local DD_AWARD_SUB = menu.add_feature("# Doomsday Awards", "parent", DHMN.id)

    menu.add_feature("# Unlock Doomsday Awards [INT]", "action", DD_AWARD_SUB.id, function()
        ui.notify_above_map("Doomsday Awards Unlocked - INT", "Heist Control", 96)
        for i = 1, #DD_AWARDS_I do
            stat_set_int(DD_AWARDS_I[i][1], true, DD_AWARDS_I[i][2])
            stat_set_int(DD_AWARDS_I[i][1], false, DD_AWARDS_I[i][2])
        end
    end)
    
    menu.add_feature("# Unlock Doomsday Awards [BOOL]", "action", DD_AWARD_SUB.id, function()
        ui.notify_above_map("Doomsday Awards Unlocked - BOOL", "Heist Control", 96)
        for i = 1, #DD_AWARDS_B do
            stat_set_bool(DD_AWARDS_B[i][1], true, DD_AWARDS_B[i][2])
            stat_set_bool(DD_AWARDS_B[i][1], false, DD_AWARDS_B[i][2])
        end
    end)
end
---------
--- APARTMENT THNGS 
do
    local Apartment_SetDone = {

        {"HEIST_PLANNING_STAGE", -1}
    }
    
    -- Apartment Awards
    
    local Apartment_AWD_B = {
    
        {"MPPLY_AWD_COMPLET_HEIST_MEM", true},
        {"MPPLY_AWD_COMPLET_HEIST_1STPER", true},
        {"MPPLY_AWD_FLEECA_FIN", true},
        {"MPPLY_AWD_HST_ORDER", true},
        {"MPPLY_AWD_HST_SAME_TEAM", true},
        {"MPPLY_AWD_HST_ULT_CHAL", true},
        {"MPPLY_AWD_HUMANE_FIN", true},
        {"MPPLY_AWD_PACIFIC_FIN", true},
        {"MPPLY_AWD_PRISON_FIN", true},
        {"MPPLY_AWD_SERIESA_FIN", true},
        {"AWD_FINISH_HEIST_NO_DAMAGE", true},
        {"AWD_SPLIT_HEIST_TAKE_EVENLY", true},
        {"AWD_ALL_ROLES_HEIST", true},
        {"AWD_MATCHING_OUTFIT_HEIST", true},
        {"HEIST_PLANNING_DONE_PRINT", true},
        {"HEIST_PLANNING_DONE_HELP_0", true},
        {"HEIST_PLANNING_DONE_HELP_1", true},
        {"HEIST_PRE_PLAN_DONE_HELP_0", true},
        {"HEIST_CUTS_DONE_FINALE", true},
        {"HEIST_IS_TUTORIAL", false},
        {"HEIST_STRAND_INTRO_DONE", true},
        {"HEIST_CUTS_DONE_ORNATE", true},
        {"HEIST_CUTS_DONE_PRISON", true},
        {"HEIST_CUTS_DONE_BIOLAB", true},
        {"HEIST_CUTS_DONE_NARCOTIC", true},
        {"HEIST_CUTS_DONE_TUTORIAL", true},
        {"HEIST_AWARD_DONE_PREP", true},
        {"HEIST_AWARD_BOUGHT_IN", true}
    
    }
    
    local Apartment_AWD_I = {
    
        {"AWD_FINISH_HEISTS", 900},
        {"MPPLY_WIN_GOLD_MEDAL_HEISTS", 900},
        {"AWD_DO_HEIST_AS_MEMBER", 900},
        {"AWD_DO_HEIST_AS_THE_LEADER", 900},
        {"AWD_FINISH_HEIST_SETUP_JOB", 900},
        {"AWD_FINISH_HEIST", 900},
        {"HEIST_COMPLETION", 900},
        {"HEISTS_ORGANISED", 900},
        {"AWD_CONTROL_CROWDS", 900},
        {"AWD_WIN_GOLD_MEDAL_HEISTS", 900},
        {"AWD_COMPLETE_HEIST_NOT_DIE", 900},
        {"HEIST_START", 900},
        {"HEIST_END", 900},
        {"CUTSCENE_MID_PRISON", 900},
        {"CUTSCENE_MID_HUMANE", 900},
        {"CUTSCENE_MID_NARC", 900},
        {"CUTSCENE_MID_ORNATE", 900},
        {"CR_FLEECA_PREP_1", 5000},
        {"CR_FLEECA_PREP_2", 5000},
        {"CR_FLEECA_FINALE", 5000},
        {"CR_PRISON_PLANE", 5000},
        {"CR_PRISON_BUS", 5000},
        {"CR_PRISON_STATION", 5000},
        {"CR_PRISON_UNFINISHED_BIZ", 5000},
        {"CR_PRISON_FINALE", 5000},
        {"CR_HUMANE_KEY_CODES", 5000},
        {"CR_HUMANE_ARMORDILLOS", 5000},
        {"CR_HUMANE_EMP", 5000},
        {"CR_HUMANE_VALKYRIE", 5000},
        {"CR_HUMANE_FINALE", 5000},
        {"CR_NARC_COKE", 5000},
        {"CR_NARC_TRASH_TRUCK", 5000},
        {"CR_NARC_BIKERS", 5000},
        {"CR_NARC_WEED", 5000},
        {"CR_NARC_STEAL_METH", 5000},
        {"CR_NARC_FINALE", 5000},
        {"CR_PACIFIC_TRUCKS ", 5000},
        {"CR_PACIFIC_WITSEC", 5000},
        {"CR_PACIFIC_HACK", 5000},
        {"CR_PACIFIC_BIKES", 5000},
        {"CR_PACIFIC_CONVOY", 5000},
        {"CR_PACIFIC_FINALE", 5000},
        {"MPPLY_HEIST_ACH_TRACKER", -1}
    }

    menu.add_feature("# Set all Setups as Completed", "action", HHMN.id, function()
    for i = 1, #Apartment_SetDone do
    ui.notify_above_map("Remember to pay and watch/skip the first cutscene", "Heist Control", 96)
    stat_set_int(Apartment_SetDone[i][1], true, Apartment_SetDone[i][2])
end
end)

    local APT_HST_AWD = menu.add_feature("# Apartment Heist Awards", "parent", HHMN.id)

menu.add_feature("# Unlock Apartment Heist Awards [INT]", "action", APT_HST_AWD.id, function()
    for i = 1, #Apartment_AWD_I do
    ui.notify_above_map("~h~Apartment Awards Unlocked ~g~ INT", "Heist Control", 96)
    stat_set_int(Apartment_AWD_I[i][1], true, Apartment_AWD_I[i][2])
    stat_set_int(Apartment_AWD_I[i][1], false, Apartment_AWD_I[i][2])
end
end)

menu.add_feature("# Unlock Apartment Heist Awards [BOOL]", "action", APT_HST_AWD.id, function()
    for i = 1, #Apartment_AWD_B do
    ui.notify_above_map("~h~Apartment Awards Unlocked ~g~ BOOL", "Heist Control", 96)
    stat_set_bool(Apartment_AWD_B[i][1], true, Apartment_AWD_B[i][2])
    stat_set_bool(Apartment_AWD_B[i][1], false, Apartment_AWD_B[i][2])
end
end)
end
-------- MASTER Unlocker

do
    local ML_UNLK_XMAS = {

        {"MPPLY_XMASLIVERIES0", 2147483647},
        {"MPPLY_XMASLIVERIES1", 2147483647},
        {"MPPLY_XMASLIVERIES2", 2147483647},
        {"MPPLY_XMASLIVERIES3", 2147483647},
        {"MPPLY_XMASLIVERIES4", 2147483647},
        {"MPPLY_XMASLIVERIES5", 2147483647},
        {"MPPLY_XMASLIVERIES6", 2147483647},
        {"MPPLY_XMASLIVERIES7", 2147483647},
        {"MPPLY_XMASLIVERIES8", 2147483647},
        {"MPPLY_XMASLIVERIES9", 2147483647},
        {"MPPLY_XMASLIVERIES10", 2147483647},
        {"MPPLY_XMASLIVERIES11", 2147483647},
        {"MPPLY_XMASLIVERIES12", 2147483647},
        {"MPPLY_XMASLIVERIES13", 2147483647},
        {"MPPLY_XMASLIVERIES14", 2147483647},
        {"MPPLY_XMASLIVERIES15", 2147483647},
        {"MPPLY_XMASLIVERIES16", 2147483647}
}
    
    local ARENA_W_UNLK = {
    
        {"ARN_BS_TRINKET_TICKERS", -1},
        {"ARN_BS_TRINKET_SAVED", -1},
        {"AWD_WATCH_YOUR_STEP", 50},
        {"AWD_TOWER_OFFENSE", 50},
        {"AWD_READY_FOR_WAR", 50},
        {"AWD_THROUGH_A_LENS", 50},
        {"AWD_SPINNER", 50},
        {"AWD_YOUMEANBOOBYTRAPS", 50},
        {"AWD_MASTER_BANDITO", 50},
        {"AWD_SITTING_DUCK", 50},
        {"AWD_CROWDPARTICIPATION", 50},
        {"AWD_KILL_OR_BE_KILLED", 50},
        {"AWD_MASSIVE_SHUNT", 50},
        {"AWD_YOURE_OUTTA_HERE", 200},
        {"AWD_WEVE_GOT_ONE", 50},
        {"AWD_ARENA_WAGEWORKER", 1000000},
        {"AWD_TIME_SERVED", 1000},
        {"AWD_TOP_SCORE", 55000},
        {"AWD_CAREER_WINNER", 1000},
        {"ARENAWARS_SP", 209},
        {"ARENAWARS_SKILL_LEVEL", 20},
        {"ARENAWARS_SP_LIFETIME", 209},
        {"ARENAWARS_AP_TIER", 1000},
        {"ARENAWARS_AP_LIFETIME", 47551850},
        {"ARENAWARS_CARRER_UNLK", 44},
        {"ARN_W_THEME_SCIFI", 1000},
        {"ARN_W_THEME_APOC", 1000},
        {"ARN_W_THEME_CONS", 1000},
        {"ARN_W_PASS_THE_BOMB", 1000},
        {"ARN_W_DETONATION", 1000},
        {"ARN_W_ARCADE_RACE", 1000},
        {"ARN_W_CTF", 1000},
        {"ARN_W_TAG_TEAM", 1000},
        {"ARN_W_DESTR_DERBY", 1000},
        {"ARN_W_CARNAGE", 1000},
        {"ARN_W_MONSTER_JAM", 1000},
        {"ARN_W_GAMES_MASTERS", 1000},
        {"ARN_L_PASS_THE_BOMB", 500},
        {"ARN_L_DETONATION", 500},
        {"ARN_L_ARCADE_RACE", 500},
        {"ARN_L_CTF", 500},
        {"ARN_L_TAG_TEAM", 500},
        {"ARN_L_DESTR_DERBY", 500},
        {"ARN_L_CARNAGE", 500},
        {"ARN_L_MONSTER_JAM", 500},
        {"ARN_L_GAMES_MASTERS", 500},
        {"NUMBER_OF_CHAMP_BOUGHT", 1000},
        {"ARN_SPECTATOR_KILLS", 1000},
        {"ARN_LIFETIME_KILLS", 1000},
        {"ARN_LIFETIME_DEATHS", 500},
        {"ARENAWARS_CARRER_WINS", 1000},
        {"ARENAWARS_CARRER_WINT", 1000},
        {"ARENAWARS_MATCHES_PLYD", 1000},
        {"ARENAWARS_MATCHES_PLYDT", 1000},
        {"ARN_SPEC_BOX_TIME_MS", 86400000},
        {"ARN_SPECTATOR_DRONE", 1000},
        {"ARN_SPECTATOR_CAMS", 1000},
        {"ARN_SMOKE", 1000},
        {"ARN_DRINK", 1000},
        {"ARN_VEH_MONSTER", 31000},
        {"ARN_VEH_MONSTER", 41000},
        {"ARN_VEH_MONSTER", 51000},
        {"ARN_VEH_CERBERUS", 1000},
        {"ARN_VEH_CERBERUS2", 1000},
        {"ARN_VEH_CERBERUS3", 1000},
        {"ARN_VEH_BRUISER", 1000},
        {"ARN_VEH_BRUISER2", 1000},
        {"ARN_VEH_BRUISER3", 1000},
        {"ARN_VEH_SLAMVAN4", 1000},
        {"ARN_VEH_SLAMVAN5", 1000},
        {"ARN_VEH_SLAMVAN6", 1000},
        {"ARN_VEH_BRUTUS", 1000},
        {"ARN_VEH_BRUTUS2", 1000},
        {"ARN_VEH_BRUTUS3", 1000},
        {"ARN_VEH_SCARAB", 1000},
        {"ARN_VEH_SCARAB2", 1000},
        {"ARN_VEH_SCARAB3", 1000},
        {"ARN_VEH_DOMINATOR4", 1000},
        {"ARN_VEH_DOMINATOR5", 1000},
        {"ARN_VEH_DOMINATOR6", 1000},
        {"ARN_VEH_IMPALER2", 1000},
        {"ARN_VEH_IMPALER3", 1000},
        {"ARN_VEH_IMPALER4", 1000},
        {"ARN_VEH_ISSI4", 1000},
        {"ARN_VEH_ISSI5", 1000},
        {"ARN_VEH_ISSI", 61000},
        {"ARN_VEH_IMPERATOR", 1000},
        {"ARN_VEH_IMPERATOR2", 1000},
        {"ARN_VEH_IMPERATOR3", 1000},
        {"ARN_VEH_ZR380", 1000},
        {"ARN_VEH_ZR3802", 1000},
        {"ARN_VEH_ZR3803", 1000},
        {"ARN_VEH_DEATHBIKE", 1000},
        {"ARN_VEH_DEATHBIKE2", 1000},
        {"ARN_VEH_DEATHBIKE3", 1000}
    }
    
    local ARENA_W_UNLK_BL = {
    
        {"AWD_BEGINNER", true},
        {"AWD_FIELD_FILLER", true},
        {"AWD_ARMCHAIR_RACER", true},
        {"AWD_LEARNER", true},
        {"AWD_SUNDAY_DRIVER", true},
        {"AWD_THE_ROOKIE", true},
        {"AWD_BUMP_AND_RUN", true},
        {"AWD_GEAR_HEAD", true},
        {"AWD_DOOR_SLAMMER", true},
        {"AWD_HOT_LAP", true},
        {"AWD_ARENA_AMATEUR", true},
        {"AWD_PAINT_TRADER", true},
        {"AWD_SHUNTER", true},
        {"AWD_JOCK", true},
        {"AWD_WARRIOR", true},
        {"AWD_T_BONE", true},
        {"AWD_MAYHEM", true},
        {"AWD_WRECKER", true},
        {"AWD_CRASH_COURSE", true},
        {"AWD_ARENA_LEGEND", true},
        {"AWD_PEGASUS", true},
        {"AWD_UNSTOPPABLE", true},
        {"AWD_CONTACT_SPORT", true}
    
    }
    
    local NIGH_C_UNLK = {
    
        {"AWD_DANCE_TO_SOLOMUN", 120},
        {"AWD_DANCE_TO_TALEOFUS", 120},
        {"AWD_DANCE_TO_DIXON", 120},
        {"AWD_DANCE_TO_BLKMAD", 120},
        {"AWD_CLUB_DRUNK", 200},
        {"NIGHTCLUB_VIP_APPEAR", 700},
        {"NIGHTCLUB_JOBS_DONE", 700},
        {"NIGHTCLUB_EARNINGS", 20721002},
        {"HUB_SALES_COMPLETED", 1001},
        {"HUB_EARNINGS", 320721002},
        {"DANCE_COMBO_DURATION_MINS", 3600000},
        {"NIGHTCLUB_PLAYER_APPEAR", 9506},
        {"LIFETIME_HUB_GOODS_SOLD", 784672},
        {"LIFETIME_HUB_GOODS_MADE", 507822},
        {"DANCEPERFECTOWNCLUB", 120},
        {"NUMUNIQUEPLYSINCLUB", 120},
        {"DANCETODIFFDJS", 4},
        {"NIGHTCLUB_HOTSPOT_TIME_MS", 3600000},
        {"NIGHTCLUB_CONT_TOTAL", 20},
        {"NIGHTCLUB_CONT_MISSION", -1},
        {"CLUB_CONTRABAND_MISSION", 1000},
        {"HUB_CONTRABAND_MISSION", 1000}
    }
    
    local NIGH_C_UNLK_B = {
    
        {"AWD_CLUB_HOTSPOT", true},
        {"AWD_CLUB_CLUBBER", true},
        {"AWD_CLUB_COORD", true}
    }
    
    local NIGH_INC_PP = {
    
        {"CLUB_POPULARITY", 1000}
    }
    
    local VEHICLE_SELL_T_LIMIT = {
    
        {"MPPLY_VEHICLE_SELL_TIME", 0},
        {"MPPLY_NUM_CARS_SOLD_TODAY", 0}
    }
    
    local SHT_UNLK = {
    
        {"CRDEADLINE", 5}
    }
    
    local LMAR_UNLK_B = {
    
        {"LOW_FLOW_CS_DRV_SEEN", true},
        {"LOW_FLOW_CS_TRA_SEEN", true},
        {"LOW_FLOW_CS_FUN_SEEN", true},
        {"LOW_FLOW_CS_PHO_SEEN", true},
        {"LOW_FLOW_CS_FIN_SEEN", true},
        {"LOW_BEN_INTRO_CS_SEEN", true}
    }
    
    local LMAR_UNLK_I = {
    
        {"LOWRIDER_FLOW_COMPLETE", 3},
        {"LOW_FLOW_CURRENT_PROG", 9},
        {"LOW_FLOW_CURRENT_CALL", 9}
    }
    
    local FLY_SCHOOL_I = {
    
        {"PILOT_SCHOOL_MEDAL_0", -1},
        {"PILOT_SCHOOL_MEDAL_1", -1},
        {"PILOT_SCHOOL_MEDAL_2", -1},
        {"PILOT_SCHOOL_MEDAL_3", -1},
        {"PILOT_SCHOOL_MEDAL_4", -1},
        {"PILOT_SCHOOL_MEDAL_5", -1},
        {"PILOT_SCHOOL_MEDAL_6", -1},
        {"PILOT_SCHOOL_MEDAL_7", -1},
        {"PILOT_SCHOOL_MEDAL_8", -1},
        {"PILOT_SCHOOL_MEDAL_9", -1}
    }
    
    local FLY_SCHOOL_B = {
    
        {"PILOT_ASPASSEDLESSON_0", true},
        {"PILOT_ASPASSEDLESSON_1", true},
        {"PILOT_ASPASSEDLESSON_2", true},
        {"PILOT_ASPASSEDLESSON_3", true},
        {"PILOT_ASPASSEDLESSON_4", true},
        {"PILOT_ASPASSEDLESSON_5", true},
        {"PILOT_ASPASSEDLESSON_6", true},
        {"PILOT_ASPASSEDLESSON_7", true},
        {"PILOT_ASPASSEDLESSON_8", true},
        {"PILOT_ASPASSEDLESSON_9", true}
    }
    
    local ARCD_I_UNLK = {
    
        {"AWD_PREPARATION", 40},
        {"AWD_ASLEEPONJOB", 20},
        {"AWD_DAICASHCRAB", 100000},
        {"AWD_BIGBRO", 40},
        {"AWD_SHARPSHOOTER", 40},
        {"AWD_RACECHAMP", 40},
        {"AWD_BATSWORD", 1000000},
        {"AWD_COINPURSE", 950000},
        {"AWD_ASTROCHIMP", 3000000},
        {"AWD_MASTERFUL", 40000},
        {"SCGW_NUM_WINS_GANG_0", 50},
        {"SCGW_NUM_WINS_GANG_1", 50},
        {"SCGW_NUM_WINS_GANG_2", 50},
        {"SCGW_NUM_WINS_GANG_3", 50},
        {"CH_ARC_CAB_CLAW_TROPHY", -1},
        {"CH_ARC_CAB_LOVE_TROPHY", -1},
        {"IAP_MAX_MOON_DIST", 2147483647},
        {"IAP_INITIALS_0", 50},
        {"IAP_INITIALS_1", 50},
        {"IAP_INITIALS_2", 50},
        {"IAP_INITIALS_3", 50},
        {"IAP_INITIALS_4", 50},
        {"IAP_INITIALS_5", 50},
        {"IAP_INITIALS_6", 50},
        {"IAP_INITIALS_7", 50},
        {"IAP_INITIALS_8", 50},
        {"IAP_INITIALS_9", 50},
        {"IAP_SCORE_0", 50},
        {"IAP_SCORE_1", 50},
        {"IAP_SCORE_2", 50},
        {"IAP_SCORE_3", 50},
        {"IAP_SCORE_4", 50},
        {"IAP_SCORE_5", 50},
        {"IAP_SCORE_6", 50},
        {"IAP_SCORE_7", 50},
        {"IAP_SCORE_8", 50},
        {"IAP_SCORE_9", 50},
        {"SCGW_INITIALS_0", 69644},
        {"SCGW_INITIALS_1", 50333},
        {"SCGW_INITIALS_2", 63512},
        {"SCGW_INITIALS_3", 46136},
        {"SCGW_INITIALS_4", 21638},
        {"SCGW_INITIALS_5", 2133},
        {"SCGW_INITIALS_6", 1215},
        {"SCGW_INITIALS_7", 2444},
        {"SCGW_INITIALS_8", 38023},
        {"SCGW_INITIALS_9", 2233},
        {"SCGW_SCORE_0", 50},
        {"SCGW_SCORE_1", 50},
        {"SCGW_SCORE_2", 50},
        {"SCGW_SCORE_3", 50},
        {"SCGW_SCORE_4", 50},
        {"SCGW_SCORE_5", 50},
        {"SCGW_SCORE_6", 50},
        {"SCGW_SCORE_7", 50},
        {"SCGW_SCORE_8", 50},
        {"SCGW_SCORE_9", 50},
        {"DG_DEFENDER_INITIALS_0", 69644},
        {"DG_DEFENDER_INITIALS_1", 69644},
        {"DG_DEFENDER_INITIALS_2", 69644},
        {"DG_DEFENDER_INITIALS_3", 69644},
        {"DG_DEFENDER_INITIALS_4", 69644},
        {"DG_DEFENDER_INITIALS_5", 69644},
        {"DG_DEFENDER_INITIALS_6", 69644},
        {"DG_DEFENDER_INITIALS_7", 69644},
        {"DG_DEFENDER_INITIALS_8", 69644},
        {"DG_DEFENDER_INITIALS_9", 69644},
        {"DG_DEFENDER_SCORE_0", 50},
        {"DG_DEFENDER_SCORE_1", 50},
        {"DG_DEFENDER_SCORE_2", 50},
        {"DG_DEFENDER_SCORE_3", 50},
        {"DG_DEFENDER_SCORE_4", 50},
        {"DG_DEFENDER_SCORE_5", 50},
        {"DG_DEFENDER_SCORE_6", 50},
        {"DG_DEFENDER_SCORE_7", 50},
        {"DG_DEFENDER_SCORE_8", 50},
        {"DG_DEFENDER_SCORE_9", 50},
        {"DG_MONKEY_INITIALS_0", 69644},
        {"DG_MONKEY_INITIALS_1", 69644},
        {"DG_MONKEY_INITIALS_2", 69644},
        {"DG_MONKEY_INITIALS_3", 69644},
        {"DG_MONKEY_INITIALS_4", 69644},
        {"DG_MONKEY_INITIALS_5", 69644},
        {"DG_MONKEY_INITIALS_6", 69644},
        {"DG_MONKEY_INITIALS_7", 69644},
        {"DG_MONKEY_INITIALS_8", 69644},
        {"DG_MONKEY_INITIALS_9", 69644},
        {"DG_MONKEY_SCORE_0", 50},
        {"DG_MONKEY_SCORE_1", 50},
        {"DG_MONKEY_SCORE_2", 50},
        {"DG_MONKEY_SCORE_3", 50},
        {"DG_MONKEY_SCORE_4", 50},
        {"DG_MONKEY_SCORE_5", 50},
        {"DG_MONKEY_SCORE_6", 50},
        {"DG_MONKEY_SCORE_7", 50},
        {"DG_MONKEY_SCORE_8", 50},
        {"DG_MONKEY_SCORE_9", 50},
        {"DG_PENETRATOR_INITIALS_0", 69644},
        {"DG_PENETRATOR_INITIALS_1", 69644},
        {"DG_PENETRATOR_INITIALS_2", 69644},
        {"DG_PENETRATOR_INITIALS_3", 69644},
        {"DG_PENETRATOR_INITIALS_4", 69644},
        {"DG_PENETRATOR_INITIALS_5", 69644},
        {"DG_PENETRATOR_INITIALS_6", 69644},
        {"DG_PENETRATOR_INITIALS_7", 69644},
        {"DG_PENETRATOR_INITIALS_8", 69644},
        {"DG_PENETRATOR_INITIALS_9", 69644},
        {"DG_PENETRATOR_SCORE_0", 50},
        {"DG_PENETRATOR_SCORE_1", 50},
        {"DG_PENETRATOR_SCORE_2", 50},
        {"DG_PENETRATOR_SCORE_3", 50},
        {"DG_PENETRATOR_SCORE_4", 50},
        {"DG_PENETRATOR_SCORE_5", 50},
        {"DG_PENETRATOR_SCORE_6", 50},
        {"DG_PENETRATOR_SCORE_7", 50},
        {"DG_PENETRATOR_SCORE_8", 50},
        {"DG_PENETRATOR_SCORE_9", 50},
        {"GGSM_INITIALS_0", 69644},
        {"GGSM_INITIALS_1", 69644},
        {"GGSM_INITIALS_2", 69644},
        {"GGSM_INITIALS_3", 69644},
        {"GGSM_INITIALS_4", 69644},
        {"GGSM_INITIALS_5", 69644},
        {"GGSM_INITIALS_6", 69644},
        {"GGSM_INITIALS_7", 69644},
        {"GGSM_INITIALS_8", 69644},
        {"GGSM_INITIALS_9", 69644},
        {"GGSM_SCORE_0", 50},
        {"GGSM_SCORE_1", 50},
        {"GGSM_SCORE_2", 50},
        {"GGSM_SCORE_3", 50},
        {"GGSM_SCORE_4", 50},
        {"GGSM_SCORE_5", 50},
        {"GGSM_SCORE_6", 50},
        {"GGSM_SCORE_7", 50},
        {"GGSM_SCORE_8", 50},
        {"GGSM_SCORE_9", 50},
        {"TWR_INITIALS_0", 69644},
        {"TWR_INITIALS_1", 69644},
        {"TWR_INITIALS_2", 69644},
        {"TWR_INITIALS_3", 69644},
        {"TWR_INITIALS_4", 69644},
        {"TWR_INITIALS_5", 69644},
        {"TWR_INITIALS_6", 69644},
        {"TWR_INITIALS_7", 69644},
        {"TWR_INITIALS_8", 69644},
        {"TWR_INITIALS_9", 69644},
        {"TWR_SCORE_0", 50},
        {"TWR_SCORE_1", 50},
        {"TWR_SCORE_2", 50},
        {"TWR_SCORE_3", 50},
        {"TWR_SCORE_4", 50},
        {"TWR_SCORE_5", 50},
        {"TWR_SCORE_6", 50},
        {"TWR_SCORE_7", 50},
        {"TWR_SCORE_8", 50},
        {"TWR_SCORE_9", 50}
    
    }
    
    local ARCD_B_UNLK = {
    
        {"AWD_SCOPEOUT", true},
        {"AWD_CREWEDUP", true},
        {"AWD_MOVINGON", true},
        {"AWD_PROMOCAMP", true},
        {"AWD_GUNMAN", true},
        {"AWD_SMASHNGRAB", true},
        {"AWD_INPLAINSI", true},
        {"AWD_UNDETECTED", true},
        {"AWD_ALLROUND", true},
        {"AWD_ELITETHEIF", true},
        {"AWD_PRO", true},
        {"AWD_SUPPORTACT", true},
        {"AWD_SHAFTED", true}, 
        {"AWD_COLLECTOR", true},
        {"AWD_DEADEYE", true},
        {"AWD_PISTOLSATDAWN", true},
        {"AWD_TRAFFICAVOI", true},
        {"AWD_CANTCATCHBRA", true},
        {"AWD_WIZHARD", true},
        {"AWD_APEESCAP", true},
        {"AWD_MONKEYKIND", true},
        {"AWD_AQUAAPE", true},
        {"AWD_KEEPFAITH", true},
        {"AWD_TRUELOVE", true},
        {"AWD_NEMESIS", true},
        {"AWD_FRIENDZONED", true},
        {"IAP_CHALLENGE_0", true},
        {"IAP_CHALLENGE_1", true},
        {"IAP_CHALLENGE_2", true},
        {"IAP_CHALLENGE_3", true},
        {"IAP_CHALLENGE_4", true},
        {"IAP_GOLD_TANK", true},
        {"SCGW_WON_NO_DEATHS", true}
    }
    
    local FAST_RUN_ON = {
    
        {"CHAR_FM_ABILITY_1_UNLCK", -1},
        {"CHAR_FM_ABILITY_2_UNLCK", -1},
        {"CHAR_FM_ABILITY_3_UNLCK", -1},
        {"CHAR_ABILITY_1_UNLCK", -1},
        {"CHAR_ABILITY_2_UNLCK", -1},
        {"CHAR_ABILITY_3_UNLCK", -1}
    }
    
    local FAST_RUN_OFF = {
    
        {"CHAR_FM_ABILITY_1_UNLCK", 0},
        {"CHAR_FM_ABILITY_2_UNLCK", 0},
        {"CHAR_FM_ABILITY_3_UNLCK", 0},
        {"CHAR_ABILITY_1_UNLCK", 0},
        {"CHAR_ABILITY_2_UNLCK", 0},
        {"CHAR_ABILITY_3_UNLCK", 0}
    }
    
    local ORBT_CLDWN_ = {
    
        {"ORBITAL_CANNON_COOLDOWN", 0}
    }
    
    local INVTRY_FLL = {
    
        {"NO_BOUGHT_YUM_SNACKS", 30},
        {"NO_BOUGHT_HEALTH_SNACKS", 15},
        {"NO_BOUGHT_EPIC_SNACKS", 5},
        {"NUMBER_OF_ORANGE_BOUGHT", 10},
        {"NUMBER_OF_BOURGE_BOUGHT", 10},
        {"NUMBER_OF_CHAMP_BOUGHT", 5},
        {"CIGARETTES_BOUGHT", 20},
        {"MP_CHAR_ARMOUR_1_COUNT", 10},
        {"MP_CHAR_ARMOUR_2_COUNT", 10},
        {"MP_CHAR_ARMOUR_3_COUNT", 10},
        {"MP_CHAR_ARMOUR_4_COUNT", 10},
        {"MP_CHAR_ARMOUR_5_COUNT", 10}
    }
    
    local CONTACTx_UNLCK = {
    
        {"FM_ACT_PHN", -1},
        {"FM_ACT_PH2", -1},
        {"FM_ACT_PH3", -1},
        {"FM_ACT_PH4", -1},
        {"FM_ACT_PH5", -1},
        {"FM_VEH_TX1", -1},
        {"FM_ACT_PH6", -1},
        {"FM_ACT_PH7", -1},
        {"FM_ACT_PH8", -1},
        {"FM_ACT_PH9", -1},
        {"FM_CUT_DONE", -1},
        {"FM_CUT_DONE_2", -1}
    }
    
    local BUNKR_UNLCK = {
    
        {"SR_HIGHSCORE_1", 690},
        {"SR_HIGHSCORE_2", 1860},
        {"SR_HIGHSCORE_3", 2690},
        {"SR_HIGHSCORE_4", 2660},
        {"SR_HIGHSCORE_5", 2650},
        {"SR_HIGHSCORE_6", 450},
        {"SR_TARGETS_HIT", 269},
        {"SR_WEAPON_BIT_SET", -1}
    }
    
    local BUNKR_UNLCK_B = {
    
        {"SR_TIER_1_REWARD", true},
        {"SR_TIER_3_REWARD", true},
        {"SR_INCREASE_THROW_CAP", true}
    }
    
    local summer2020_AWARDS_BL = {
    
        {"AWD_KINGOFQUB3D", true},
        {"AWD_QUBISM", true},
        {"AWD_QUIBITS", true},
        {"AWD_GODOFQUB3D", true},
        {"AWD_GOFOR11TH", true},
        {"AWD_ELEVENELEVEN", true}
    }
    
    local Yacht_MS = {
    
        {"YACHT_MISSION_PROG", 0},
        {"YACHT_MISSION_FLOW", 21845},
        {"CASINO_DECORATION_GIFT_1", -1}
    
    }
    
    local ALN_UNLCK_M = {
    
        {"TATTOO_FM_CURRENT_32", 32768}
    }
    
    local ALN_UNLCK_F = {
    
        {"TATTOO_FM_CURRENT_32", 67108864}
    }
    
    local ALN_EG_MS = {
    
        {"LFETIME_BIKER_BUY_COMPLET5", 599},
        {"LFETIME_BIKER_BUY_UNDERTA5", 599}
    }
    
    local VEH_TRADE_PR = {
    
        {"AT_FLOW_IMPEXP_NUM", -1},
        {"AT_FLOW_VEHICLE_BS", -1},
        {"GANGOPS_FLOW_BITSET_MISS0", -1},
        {"WVM_FLOW_VEHICLE_BS", -1}
    }
    
    local OFFC_M_SHOW = {
    
        {"LIFETIME_BUY_COMPLETE", 1000},
        {"LIFETIME_BUY_UNDERTAKEN", 1000},
        {"LIFETIME_SELL_COMPLETE", 1000},
        {"LIFETIME_SELL_UNDERTAKEN", 1000},
        {"LIFETIME_CONTRA_EARNINGS", 20000000},
        {"LIFETIME_BIKER_BUY_COMPLET", 1000},
        {"LIFETIME_BIKER_BUY_UNDERTA", 1000},
        {"LIFETIME_BIKER_SELL_COMPLET", 1000},
        {"LIFETIME_BIKER_SELL_UNDERTA", 1000},
        {"LIFETIME_BIKER_BUY_COMPLET1", 1000},
        {"LIFETIME_BIKER_BUY_UNDERTA1", 1000},
        {"LIFETIME_BIKER_SELL_COMPLET1", 1000},
        {"LIFETIME_BIKER_SELL_UNDERTA1", 1000},
        {"LIFETIME_BIKER_BUY_COMPLET2", 1000},
        {"LIFETIME_BIKER_BUY_UNDERTA2", 1000},
        {"LIFETIME_BIKER_SELL_COMPLET2", 1000},
        {"LIFETIME_BIKER_SELL_UNDERTA2", 1000},
        {"LIFETIME_BIKER_BUY_COMPLET3", 1000},
        {"LIFETIME_BIKER_BUY_UNDERTA3", 1000},
        {"LIFETIME_BIKER_SELL_COMPLET3", 1000},
        {"LIFETIME_BIKER_SELL_UNDERTA3", 1000},
        {"LIFETIME_BIKER_BUY_COMPLET4", 1000},
        {"LIFETIME_BIKER_BUY_UNDERTA4", 1000},
        {"LIFETIME_BIKER_SELL_COMPLET4", 1000},
        {"LIFETIME_BIKER_SELL_UNDERTA4", 1000},
        {"LIFETIME_BIKER_BUY_COMPLET5", 1000},
        {"LIFETIME_BIKER_BUY_UNDERTA5", 1000},
        {"LIFETIME_BIKER_SELL_COMPLET5", 1000},
        {"LIFETIME_BIKER_SELL_UNDERTA5", 1000},
        {"LIFETIME_BKR_SELL_EARNINGS0", 20000000},
        {"LIFETIME_BKR_SELL_EARNINGS1", 20000000},
        {"LIFETIME_BKR_SELL_EARNINGS2", 20000000},
        {"LIFETIME_BKR_SELL_EARNINGS3", 20000000},
        {"LIFETIME_BKR_SELL_EARNINGS4", 20000000},
        {"LIFETIME_BKR_SELL_EARNINGS5", 20000000}
    
    }
    
    local VANNIL_AWD = {
    
        {"LAP_DANCED_BOUGHT", 0},
        {"LAP_DANCED_BOUGHT", 5},
        {"LAP_DANCED_BOUGHT", 10},
        {"LAP_DANCED_BOUGHT", 15},
        {"LAP_DANCED_BOUGHT", 25},
        {"PROSTITUTES_FREQUENTED", 1000}
    }
    
    local DAILY_OBJ_AWD = {
    
    
        {"AWD_DAILYOBJCOMPLETED", 0},
        {"AWD_DAILYOBJCOMPLETED", 10},
        {"AWD_DAILYOBJCOMPLETED", 25},
        {"AWD_DAILYOBJCOMPLETED", 50},
        {"AWD_DAILYOBJCOMPLETED", 100},
        {"CONSECUTIVEWEEKCOMPLETED", 0},
        {"CONSECUTIVEWEEKCOMPLETED", 7},
        {"CONSECUTIVEWEEKCOMPLETED", 28}
    }
    
    local DAILY_OBJ_AWD_B = {
    
        {"AWD_DAILYOBJWEEKBONUS", true},
        {"AWD_DAILYOBJMONTHBONUS", true}
    }

    menu.add_feature("Unlock all XMAS Liveries", "action", MUMN.id, function()
        ui.notify_above_map("~h~~b~XMAS Liveries Unlocked~n~ Even the unreleased ones", "Master Unlocker", 96)
        for i = 1, #ML_UNLK_XMAS do
            stat_set_int(ML_UNLK_XMAS[i][1], false, ML_UNLK_XMAS[i][2])
        end
    end)
    
    menu.add_feature("Remove Orbital Cannon Cooldown (risky)", "toggle", MUMN.id, function()
        for i = 1, #ORBT_CLDWN_ do
            stat_set_int(ORBT_CLDWN_[i][1], true, ORBT_CLDWN_[i][2])
        end
    end)
    
    menu.add_feature("Refill Inventory", "action", MUMN.id, function()
        for i = 1, #INVTRY_FLL do
            stat_set_int(INVTRY_FLL[i][1], true, INVTRY_FLL[i][2])
        ui.notify_above_map("~h~~b~Inventory Restored", "Master Unlocker", 96)
        end
    end)

    local ARENA_C_UNLCKS = menu.add_feature("Unlock Arena War Awards", "parent", MUMN.id)
    
    menu.add_feature("Unlock all Arena Wars Trophy and Toys - [INT]", "action", ARENA_C_UNLCKS.id, function()
        ui.notify_above_map("~h~~g~Unlocked - INT~s~", "Master Unlocker", 96)
        for i = 1, #ARENA_W_UNLK do
            stat_set_int(ARENA_W_UNLK[i][1], true, ARENA_W_UNLK[i][2])
        end
    end)
    
    menu.add_feature("Unlock all Arena Wars Trophy and Toys - [BOOL]", "action", ARENA_C_UNLCKS.id, function()
        ui.notify_above_map("~h~~g~Unlocked - BOOL~s~", "Master Unlocker", 96)
        for i = 1, #ARENA_W_UNLK_BL do
            stat_set_bool(ARENA_W_UNLK_BL[i][1], true, ARENA_W_UNLK_BL[i][2])
            stat_set_bool(ARENA_W_UNLK_BL[i][1], false, ARENA_W_UNLK_BL[i][2])
        end
    end)
    
    local NIGHT_C_UNLCKS = menu.add_feature("Unlock NighClub Awards", "parent", MUMN.id)
    
    menu.add_feature("Increase Popularity to the MAX", "action", NIGHT_C_UNLCKS.id, function()
        ui.notify_above_map("~h~~b~Popularity Increased~s~", "Master Unlocker", 96)
        for i = 1, #NIGH_INC_PP do
            stat_set_int(NIGH_INC_PP[i][1], true, NIGH_INC_PP[i][2])
        end
    end)
    
    menu.add_feature("Unlock Nightclub - [INT]", "action", NIGHT_C_UNLCKS.id, function()
        ui.notify_above_map("~h~~g~Unlocked - INT~s~", "Master Unlocker", 96)
        for i = 1, #NIGH_C_UNLK do
            stat_set_int(NIGH_C_UNLK[i][1], true, NIGH_C_UNLK[i][2])
        end
    end)
    
    menu.add_feature("Unlock Nightclub - [BOOL]", "action", NIGHT_C_UNLCKS.id, function()
        ui.notify_above_map("~h~~g~Unlocked - BOOL~s~", "Master Unlocker", 96)
        for i = 1, #NIGH_C_UNLK_B do
            stat_set_bool(NIGH_C_UNLK_B[i][1], true, NIGH_C_UNLK_B[i][2])
            stat_set_bool(NIGH_C_UNLK_B[i][1], false, NIGH_C_UNLK_B[i][2])
        end
    end)
    
    local ARCD_UNLCKS = menu.add_feature("Arcade Toys and Trophys", "parent", MUMN.id)
    
    menu.add_feature("Unlock Arcade Trophys and Toys [INT]", "action", ARCD_UNLCKS.id, function()
        ui.notify_above_map("~h~~g~Unlocked~s~ [INT]", "Master Unlocker", 96)
        for i = 1, #ARCD_I_UNLK do
            stat_set_int(ARCD_I_UNLK[i][1], true, ARCD_I_UNLK[i][2])
        end
    end)
    
    menu.add_feature("Unlock Arcade Trophys and Toys [BOOL]", "action", ARCD_UNLCKS.id, function()
        ui.notify_above_map("~h~~g~Unlocked~s~ [BOOL]", "Master Unlocker", 96)
        for i = 1, #ARCD_B_UNLK do
            stat_set_bool(ARCD_B_UNLK[i][1], true, ARCD_B_UNLK[i][2])
        end
    end)
    
    local OFF_MC_UNLCKS = menu.add_feature("Office and MC Cosmetics", "parent", MUMN.id)

    menu.add_feature("Add cosmetics items in the Office and MotoClub", "action", OFF_MC_UNLCKS.id, function()
        ui.notify_above_map("~h~~y~To Add: Sell anything and switch session", "Master Unlocker", 96)
        for i = 1, #OFFC_M_SHOW do
            stat_set_int(OFFC_M_SHOW[i][1], true, OFFC_M_SHOW[i][2])
        end
    end)
    
    menu.add_feature("Remove Vehicle Sell Daily Limit", "action", MUMN.id, function()
        ui.notify_above_map("~h~~g~Cooldown Removed", "Master Unlocker", 96)
        for i = 1, #VEHICLE_SELL_T_LIMIT do
            stat_set_int(VEHICLE_SELL_T_LIMIT[i][1], true, VEHICLE_SELL_T_LIMIT[i][2])
            stat_set_int(VEHICLE_SELL_T_LIMIT[i][1], false, VEHICLE_SELL_T_LIMIT[i][2])
        end
    end)
    
    menu.add_feature("Unlock Shotaro", "action", MUMN.id, function()
        ui.notify_above_map("~h~Now you can buy it without doing quests ;)", "Master Unlocker", 96)
        for i = 1, #SHT_UNLK do
            stat_set_int(SHT_UNLK[i][1], true, SHT_UNLK[i][2])
        end
    end)
    
    menu.add_feature("Summer 2020 Awards", "action", MUMN.id, function()
        ui.notify_above_map("~h~~g~Awards Unlocked", "Master Unlocker", 96)
        for i = 1, #summer2020_AWARDS_BL do
            stat_set_bool(summer2020_AWARDS_BL[i][1], true, summer2020_AWARDS_BL[i][2])
            stat_set_bool(summer2020_AWARDS_BL[i][1], false, summer2020_AWARDS_BL[i][2])
        end
    end)
    
    menu.add_feature("Unlock Yacht Missions", "action", MUMN.id, function()
        ui.notify_above_map("~h~~g~Yacht Missions Unlocked~s~", "Master Unlocker", 96)
        for i = 1, #Yacht_MS do
            stat_set_int(Yacht_MS[i][1], true, Yacht_MS[i][2])
        end
    end)
    
    local ALN_TT_UNLCK = menu.add_feature("Alien Tatto - Exclusive", "parent", MUMN.id)
    
    menu.add_feature("Apply the tatto for my MALE Character", "action", ALN_TT_UNLCK.id, function()
        ui.notify_above_map("~h~~g~Done, please switch session or suicide for it to show up", "Master Unlocker", 96)
        for i = 1, #ALN_UNLCK_M do
            stat_set_int(ALN_UNLCK_M[i][1], true, ALN_UNLCK_M[i][2])
        end
    end)
    
    menu.add_feature("Apply the tatto for my FEMALE Character", "action", ALN_TT_UNLCK.id, function()
        ui.notify_above_map("~h~~g~Done, please switch session or suicide for it to show up", "Master Unlocker", 96)
        for i = 1, #ALN_UNLCK_F do
            stat_set_int(ALN_UNLCK_F[i][1], true, ALN_UNLCK_F[i][2])
        end
    end)
    
    local LMAR_MISSION_SKIPPER = menu.add_feature("Skip Lamar Missions to the last one", "parent", MUMN.id)
    
    menu.add_feature("Skip Lamar Mission to the Last one [BOOL]", "action", LMAR_MISSION_SKIPPER.id, function()
        ui.notify_above_map("~h~~g~Done (BOOL), please switch session for it to take effect", "Master Unlocker", 96)
        for i = 1, #LMAR_UNLK_B do
            stat_set_bool(LMAR_UNLK_B[i][1], true, LMAR_UNLK_B[i][2])
        end
    end)
    
    menu.add_feature("Skip Lamar Mission to the Last one [INT]", "action", LMAR_MISSION_SKIPPER.id, function()
        ui.notify_above_map("~h~~g~Done (INT), please switch session for it to take effect", "Master Unlocker", 96)
        for i = 1, #LMAR_UNLK_I do
            stat_set_int(LMAR_UNLK_I[i][1], true, LMAR_UNLK_I[i][2])
        end
    end)
    
    local FLY_SCHOOL_MDLS = menu.add_feature("Unlock Flight School Awards", "parent", MUMN.id)
    
    menu.add_feature("Flight School Awards [INT]", "action", FLY_SCHOOL_MDLS.id, function()
        ui.notify_above_map("~h~~g~Unlocked [INT]", "Master Unlocker", 96)
        for i = 1, #FLY_SCHOOL_I do
            stat_set_int(FLY_SCHOOL_I[i][1], true, FLY_SCHOOL_I[i][2])
        end
    end)
    
    menu.add_feature("Flight School Awards [BOOL]", "action", FLY_SCHOOL_MDLS.id, function()
        ui.notify_above_map("~h~~g~Unlocked [BOOL]", "Master Unlocker", 96)
        for i = 1, #FLY_SCHOOL_B do
            stat_set_bool(FLY_SCHOOL_B[i][1], true, FLY_SCHOOL_B[i][2])
        end
    end)
    
    local FAST_RUN_M = menu.add_feature("Fast Run and Reload", "parent", MUMN.id)
    
    menu.add_feature("Set fast run and reload - ON", "action", FAST_RUN_M.id, function()
        ui.notify_above_map("~h~~b~Fast Run and Reload - ON", "Master Unlocker", 96)
        for i = 1, #FAST_RUN_ON do
            stat_set_int(FAST_RUN_ON[i][1], true, FAST_RUN_ON[i][2])
        end
    end)
    
    menu.add_feature("Set fast run and reload - OFF", "action", FAST_RUN_M.id, function()
        ui.notify_above_map("~h~~r~Fast Run and Reload - OFF", "Master Unlocker", 96)
        for i = 1, #FAST_RUN_OFF do
            stat_set_int(FAST_RUN_OFF[i][1], true, FAST_RUN_OFF[i][2])
        end
    end)
     
    menu.add_feature("Unlock some vehicles trade price", "action", MUMN.id, function()
        ui.notify_above_map("~h~~g~Prices Unlocked", "Master Unlocker", 96)
        for i = 1, #VEH_TRADE_PR do
            stat_set_int(VEH_TRADE_PR[i][1], true, VEH_TRADE_PR[i][2])
        end
    end)
    
    menu.add_feature("Unlock all Contacts", "action", MUMN.id, function()
        ui.notify_above_map("~h~~g~Everything Unlocked", "Master Unlocker", 96)
        for i = 1, #CONTACTx_UNLCK do
            stat_set_int(CONTACTx_UNLCK[i][1], true, CONTACTx_UNLCK[i][2])
        end
    end)
    
    menu.add_feature("Unlock Vanilla Unicorn Award", "action", MUMN.id, function()
        ui.notify_above_map("~h~~g~ # Unlocked", "Master Unlocker", 96)
        for i = 1, #VANNIL_AWD do
            stat_set_int(VANNIL_AWD[i][1], true, VANNIL_AWD[i][2])
        end
    end)
    
    local BNKR_AWARDS = menu.add_feature("Unlock Bunker Awards", "parent", MUMN.id)
    
    menu.add_feature("Trigger Alien Egg Mission", "action", BNKR_AWARDS.id, function()
        ui.notify_above_map("~h~~g~It's necessary that you change the clock time to between 9pm and 11pm", "Master Unlocker", 96)
        for i = 1, #ALN_EG_MS do
            stat_set_int(ALN_EG_MS[i][1], true, ALN_EG_MS[i][2])
        end
    end)
    
    menu.add_feature("Unlock Bunker Awards (INT)", "action", BNKR_AWARDS.id, function()
        ui.notify_above_map("~h~~g~Unlocked [INT]", "Master Unlocker", 96)
        for i = 1, #BUNKR_UNLCK do
            stat_set_int(BUNKR_UNLCK[i][1], true, BUNKR_UNLCK[i][2])
        end
    end)
    
    menu.add_feature("Unlock Bunker Awards (BOOL)", "action", BNKR_AWARDS.id, function()
        ui.notify_above_map("~h~~g~Unlocked [BOOL]", "Master Unlocker", 96)
        for i = 1, #BUNKR_UNLCK_B do
            stat_set_bool(BUNKR_UNLCK_B[i][1], true, BUNKR_UNLCK_B[i][2])
        end
    end)
    
    local DAILY_OB_AWD = menu.add_feature("Daily Objective Awards", "parent", MUMN.id)
    
    menu.add_feature("Unlock All Daily Objectives Awards (INT)", "action", DAILY_OB_AWD.id, function()
        ui.notify_above_map("~h~~g~Unlocked - INT", "Master Unlocker", 96)
        for i = 1, #DAILY_OBJ_AWD do
            stat_set_int(DAILY_OBJ_AWD[i][1], true, DAILY_OBJ_AWD[i][2])
        end
    end)
    
    menu.add_feature("Unlock All Daily Objectives Awards (BOOL)", "action", DAILY_OB_AWD.id, function()
        ui.notify_above_map("~h~~g~Unlocked - BOOL", "Master Unlocker", 96)
        for i = 1, #DAILY_OBJ_AWD_B do
            stat_set_bool(DAILY_OBJ_AWD_B[i][1], true, DAILY_OBJ_AWD_B[i][2])
        end
    end)
end
----
do

menu.add_feature("(!) Leave Session (Freeze the game for a few secs)", "action", MSC.id, function()
	local time = utils.time_ms() + 8500
	while time > utils.time_ms() do end
end)
end

do
menu.add_feature("# About HC 2.2.0", "action", HC2_MAIN.id, function()
    ui.notify_above_map("~h~Made by ~g~jhowkNx - ~b~jkNX", "~h~ ~b~Heist ~g~Control~s~", 2)
    ui.notify_above_map("~h~~y~Thanks to ~s~~n~~o~haekkzer~n~~h~~p~2TAKE1 Menu - Devs", "~h~ ~b~Heist ~g~Control~s~", 2)
    ui.notify_above_map("~h~~y~For future updates: ~n~github.com/jhowkNx/Heist-Control-v2", "Heist Control - Official Page", 2)
end)
end

ui.notify_above_map("~h~~p~  ::: Heist Control™~n~~b~  ::: Version 2.2.0","~o~~h~Made by jhowkNx" , 2)
ui.notify_above_map("~h~~y~The payment for the next heist (repeat) is 15 minutes, cannot be bypassed!", "~h~ SERVER-SIDE COOLDOWN", 2)
ui.notify_above_map("~h~~y~Note: The Weekly event at Cayo Perico should only be used when the bonus is activated by R*", "", 2)