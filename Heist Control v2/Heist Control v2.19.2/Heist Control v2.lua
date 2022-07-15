--[[          

    Welcome to Heist Control v2
            INF
 This script requires Trusted Mode enabled all time
 Exclusive compatibility with 2TAKE1 Menu only
 Do not contact me if you tried to edit/change anything and the script stopped working
 Developed by "jhowkNx" from 2TAKE1 Menu ~ "jkNX" from UC (UnknownCheats)
 Any suggestion, bugs and to download the latest version, visit:
https://github.com/jhowkNx/Heist-Control-v2

--]]

-- Trusted Mode Requeriment
if menu.is_trusted_mode_enabled() then
    menu.notify("Dev: jhowkNx\n\nCurrent version: v2.19.2\nUpdated on 08/Fev/2022", "Welcome to Heist Control", 7, 0x5014B4F0)
    menu.notify("* Planning to repeat the same Heist?\n\t> Wait 16 minutes to get paid again.\n\n* Whitelist Heist Members\n* Disable Protections/Spoofers\n* Keep Trusted Mode activated while using Heist Control.", "Heist Control - Tips", 10, 0x5014B4F0)
        else
    if not menu.is_trusted_mode_enabled() then
    menu.notify("Heist Control requires Trusted Mode to be activated", "Warning", 8, 0x6414F0BE)
end
    return end

-- Script core function [INT]
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
-- BOOL
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
--
local	hash
local	mask
--
function GTAO_USER_MP()
    MP_ = stats.stat_get_int(gameplay.get_hash_key("MPPLY_LAST_MP_CHAR"), 1)
       return tostring(MP_)
   end
   local CharID = "" .. GTAO_USER_MP()
--
   function CurrentMP(stat)
    local text = stat
    local hash = gameplay.get_hash_key("MPPLY_LAST_MP_CHAR")
    local MP = stats.stat_get_int(hash, 1)
    return (string.format("MP" ..MP .."_" ..text))
    end
--
    function GTA_MP()
        MPx_ = stats.stat_get_int(gameplay.get_hash_key("MPPLY_LAST_MP_CHAR"), 1)
        return tostring(MPx_)
    end
local PlayerMP = "MP" .. GTA_MP()
--
local Heist_Control = menu.add_feature("» Heist Control v2.19.2", "parent", 0, function()
end)
local PERICO_HEIST = menu.add_feature("» Cayo Perico Heist", "parent", Heist_Control.id)
local CAYO_AUTO_PRST = menu.add_feature("» Automated Presets", "parent", PERICO_HEIST.id, function()
    menu.notify("* Choose your preset outside the Submarine or in the Main Deck\n* Deactivate the preset when you finish the Heist", "Remember", 6, 0x50143CFA)
end)
local NON_EVENT = menu.add_feature("» Standard Presets [Payout $2.5 Millions]", "parent", CAYO_AUTO_PRST.id)
local AUTOMATED_SOLO = menu.add_feature("» SOLO  $2.4 MILLIONs", "parent", NON_EVENT.id)
local AUTOMATED_2P = menu.add_feature("» 2 Players  $2.4 MILLIONs", "parent", NON_EVENT.id)
local AUTOMATED_3P = menu.add_feature("» 3 Players  $2.4 MILLIONs", "parent", NON_EVENT.id)
local AUTOMATED_4P = menu.add_feature("» 4 Players  $2.4 MILLIONs", "parent", NON_EVENT.id)
local QUICK_PRST = menu.add_feature("» (1-4) Quick Preset $2.5 MILLIONs", "parent", NON_EVENT.id)
--
local WEEKLY_PRESET = menu.add_feature("» Weekly Event Presets [Payout $4.1 Millions]", "parent", CAYO_AUTO_PRST.id, function()
menu.notify(": Weekly Event Presets should only be used when actually activated by Rockstar\n\n: To make sure the event is activated\nVisit:\nwww.rockstargames.com/newswire", "", 6, 0x50F0FF14)
end)
local WEEKLY_SOLO = menu.add_feature("» SOLO  $4.1 MILLIONs", "parent", WEEKLY_PRESET.id)
local WEEKLY_F2 = menu.add_feature("» 2 Players  $4.1 MILLIONs", "parent", WEEKLY_PRESET.id)
local WEEKLY_F3 = menu.add_feature("» 3 Players  $4.1 MILLIONs", "parent", WEEKLY_PRESET.id)
local WEEKLY_F4 = menu.add_feature("» 4 Players  $4.1 MILLIONs", "parent", WEEKLY_PRESET.id)
local TELEPORT = menu.add_feature("» Custom Teleport", "parent", PERICO_HEIST.id)
local TELEPORT_QL = menu.add_feature("» Quick Teleport", "parent", TELEPORT.id)
local TELEPORTLOOT = menu.add_feature("» Island-Loot", "parent", TELEPORT.id)
local TELEPORTMANSIONO = menu.add_feature("» Mansion Exterior", "parent", TELEPORT.id)
local TELEPORTMANSIONI = menu.add_feature("» Mansion Interior", "parent", TELEPORT.id)
local TELEPORTCHESTS = menu.add_feature("» Chests", "parent", TELEPORT.id)
local PERICO_ADV = menu.add_feature("» Advanced Features", "parent", PERICO_HEIST.id)
local HSCUT_CP = menu.add_feature("» Players Payments", "parent", PERICO_ADV.id, function()
menu.notify("* High percentages affect the payment negatively", "", 5, 0x6414F0FF)
end)
local PERICO_HOST_CUT = menu.add_feature("» Your Payment", "parent", HSCUT_CP.id)
local PERICO_P2_CUT = menu.add_feature("» Player 2 Payment", "parent", HSCUT_CP.id)
local PERICO_P3_CUT = menu.add_feature("» Player 3 Payment", "parent", HSCUT_CP.id)
local PERICO_P4_CUT = menu.add_feature("» Player 4 Payment", "parent", HSCUT_CP.id)
local CAYO_BAG = menu.add_feature("» Change Bag Capacity", "parent", PERICO_ADV.id)
local CAYO_VEHICLES = menu.add_feature("» Approach Vehicles", "parent", PERICO_HEIST.id)
local CAYO_PRIMARY = menu.add_feature("» Primary Target", "parent", PERICO_HEIST.id)
local CAYO_SECONDARY = menu.add_feature("» Secondary Target", "parent", PERICO_HEIST.id)
local CAYO_WEAPONS = menu.add_feature("» Weapon Loadouts", "parent", PERICO_HEIST.id)
local CAYO_EQUIPM = menu.add_feature("» Equipments Spawn Location", "parent", PERICO_HEIST.id)
local CAYO_TRUCK = menu.add_feature("» Supply Truck Location", "parent", PERICO_HEIST.id)
local CAYO_DFFCTY = menu.add_feature("» Heist Difficulty", "parent", PERICO_HEIST.id)
local MORE_OPTIONS = menu.add_feature("::: More Options", "parent", PERICO_HEIST.id)
local CASINO_HEIST = menu.add_feature("» Diamond Casino Heist", "parent", Heist_Control.id)
local CASINO_PRESETS = menu.add_feature("» Automated Presets", "parent", CASINO_HEIST.id)

local CAH_PRESETS_TARGET = menu.add_feature("» Choose your Target", "parent", CASINO_PRESETS.id)
local CAH_DIA_TARGET = menu.add_feature("» Diamond [$3.5MI - All Players]", "parent", CAH_PRESETS_TARGET.id)
local CAH_GOLD_TARGET = menu.add_feature("» Gold [$3.5MI - All Players]", "parent", CAH_PRESETS_TARGET.id)
local CAH_CASH_TARGET = menu.add_feature("» Cash [$3.5MI - All Players]", "parent", CAH_PRESETS_TARGET.id)


local CAH_ADVCED = menu.add_feature("» Advanced Features", "parent", CASINO_HEIST.id)
local CASINO_BOARD1 = menu.add_feature("» Heist Planning [Board 1]", "parent", CASINO_HEIST.id)
local BOARD1_APPROACH = menu.add_feature("» Change Approach and Difficulty", "parent", CASINO_BOARD1.id)
local CASINO_TARGET = menu.add_feature("» Change Target", "parent", CASINO_BOARD1.id)
local CASINO_BOARD2 = menu.add_feature("» Heist Planning [Board 2]", "parent", CASINO_HEIST.id)
local CASINO_BOARD3 = menu.add_feature("» Heist Planning [Board 3]", "parent", CASINO_HEIST.id)
local CASINO_LBOARDS = menu.add_feature("» Load/Unload : Boards", "parent", CASINO_HEIST.id)
local CASINO_MORE = menu.add_feature("::: More Options", "parent", CASINO_HEIST.id)
local DOOMS_HEIST = menu.add_feature("» Doomsday Heist", "parent", Heist_Control.id)
local DOOMS_PRESETS = menu.add_feature("» Automated Presets", "parent", DOOMS_HEIST.id)
local DDHEIST_PLYR_MANAGER = menu.add_feature("» Players Payments", "parent", DOOMS_HEIST.id)
local TELEPORT_DOOMS = menu.add_feature("» Custom Teleport", "parent", DOOMS_HEIST.id)
local CLASSIC_HEISTS = menu.add_feature("» Classic Heists", "parent", Heist_Control.id)
local CLASSIC_CUT = menu.add_feature("» Your Payment (As Host)", "parent", CLASSIC_HEISTS.id)
local TH_CONTRACT = menu.add_feature("» The Contract: Agency", "parent", Heist_Control.id)
local LS_ROBBERY = menu.add_feature("» LS Tuners Robbery", "parent", Heist_Control.id)
local Heist_Inspector = menu.add_feature('» Heist Inspector', "parent", Heist_Control.id)
local TOOLS = menu.add_feature("» Tools", "parent", Heist_Control.id)

URL = ' times\n'
SUB = 'Kosatka '
AKT = 'Alkonost '
VEL = 'Velum '
STA = 'Annihilator Stealth '
KUT = 'Kurtz '
LOG = 'Longfin '
COMPLT = '\nCompleted Cayo Heist '

KOS = "CR_SUBMARINE"
STB = "CR_STRATEGIC_BOMBER"
SMG = "CR_SMUGGLER_PLANE"
STE = "CR_STEALTH_HELI"
KTT = "CR_PATROL_BOAT"
LNG = "CR_SMUGGLER_BOAT"
CPL = "H4_PLAYTHROUGH_STATUS"

PAN = "Panther Statue "
MAZ = "Madrazzo Files "
PDD = "Pink Diamond "
BON = "Bearer Bonds "
NCK = "Ruby Necklace "
TQL = "Tequilla "

PAN_ = "CR_SAPHIREPANSTAT"
MAZ_ = "CR_MADRAZO_FILES"
PDD_ = "CR_PINK_DIAMOND"
BON_ = "CR_BEARER_BONDS"
NCK_ = "CR_PEARL_NECKLACE"
TQL_ = "CR_TEQUILA"

--- This function is from Moist Menu (Credits for MOIST)

local HI_a = menu.add_feature("» Cayo Perico Inspector", "parent", Heist_Inspector.id)
    menu.add_feature("» Most used vehicles (Approach)", "action", HI_a.id, function()
    local stat = CurrentMP(KOS)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result = stats.stat_get_int(stat_hash, 0)
        --
    local stat = CurrentMP(STB)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_0 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(SMG)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_1 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(STE)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_2 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(KTT)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_3 = stats.stat_get_int(stat_hash, 0)
                --
    local stat = CurrentMP(LNG)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_4 = stats.stat_get_int(stat_hash, 0)
    menu.notify("You have chosen\n\n"..SUB ..stat_result ..URL ..AKT ..stat_result_0 ..URL ..VEL ..stat_result_1 ..URL ..STA ..stat_result_2 ..URL ..KUT ..stat_result_3 ..URL ..LOG ..stat_result_4 ..URL, "Cayo Perico Statistics", 6, 0x6478D200)
end)

menu.add_feature("» Which primary targets did I steal?", "action", HI_a.id, function()
    local stat = CurrentMP(PAN_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_0 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(MAZ_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_1 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(PDD_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_2 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(BON_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_3 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(NCK_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_4 = stats.stat_get_int(stat_hash, 0)
                --
    local stat = CurrentMP(TQL_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_5 = stats.stat_get_int(stat_hash, 0)
    menu.notify("You robbed\n\n"..PAN ..Answer_0 ..URL ..MAZ ..Answer_1 ..URL ..PDD ..Answer_2 ..URL ..BON ..Answer_3 ..URL ..NCK ..Answer_4 ..URL ..TQL ..Answer_5 ..URL, "Cayo Perico Statistics", 6, 0x6478D200)
end)

menu.add_feature("» How many times have I completed Cayo Heist?", "action", HI_a.id, function()
    local stat = CurrentMP(CPL)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_5 = stats.stat_get_int(stat_hash, 0)
    menu.notify('You played Cayo Perico Heist '..stat_result_5 ..URL, "Cayo Perico Statistics", 6, 0x6478D200)
end)

local EDIT_HI = menu.add_feature("» Editor", "parent", HI_a.id)

local valueToSet = menu.add_feature("Change how many times I did Cayo Heist", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_H4_PLAYTHROUGH_STATUS"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Kosatka values", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_SUBMARINE"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Alkonost values", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_STRATEGIC_BOMBER"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Velum values", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_SMUGGLER_PLANE"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Annihilator Stealth values", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_STEALTH_HELI"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Kurtz values", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_PATROL_BOAT"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Longfin values", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_SMUGGLER_BOAT"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change times I have stolen the Panther", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_SAPHIREPANSTAT"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change times I have stolen the Madrazzo Files", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_MADRAZO_FILES"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change times I have stolen the Pink Diamond", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_PINK_DIAMOND"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change times I have stolen the Bearer Bonds", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_BEARER_BONDS"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change times I have stolen the Ruby Necklace", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_PEARL_NECKLACE"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change times I have stolen the Tequilla", "action", EDIT_HI.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_TEQUILA"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

-- CAYO CUSTOM TELEPORT
menu.add_feature("Kosatka :: Heist Board [Call Kosatka first]", "action", TELEPORT_QL.id, function()
    menu.notify("If you teleport without calling it, you will be bugged", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1561.224,386.659,-49.685))
end)

menu.add_feature("Kosatka :: Main Deck [Call Kosatka first]", "action", TELEPORT_QL.id, function()
    menu.notify("If you teleport without calling it, you will be bugged", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1563.218,406.030,-49.667))
end)

menu.add_feature("Drainage Tunnel :: Entrance", "action", TELEPORT_QL.id, function()
    menu.notify("Teleported to Drainage Tunnel : Entrance", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5044.726,-5816.164,-11.213))
end)

menu.add_feature("Drainage Tunnel :: 2nd Checkpoint", "action", TELEPORT_QL.id, function()
    menu.notify("Teleported to Drainage Tunnel : 2nd Checkpoint", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(5054.630,-5771.519,-4.807))
end)

menu.add_feature("Main Target :: Room", "action", TELEPORT_QL.id, function()
    menu.notify("Teleported to Main Target", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(5007.895,-5755.581,15.484))
end)

menu.add_feature("Secondary Target :: Room", "action", TELEPORT_QL.id, function()
    menu.notify("Teleported to Secondary Target room", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(5003.467,-5749.352,14.840))
end)

menu.add_feature("Vault :: El Rubio Office", "action", TELEPORT_QL.id, function()
    menu.notify("Teleported to Vault", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(5010.753,-5757.639,28.845))
    entity.set_entity_rotation(pedmy,v3(2))
end)

menu.add_feature("Reduct :: Escape Gate", "action", TELEPORT_QL.id, function()
    menu.notify("Teleported to Exit", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(4992.854,-5718.537,19.880))
end)

menu.add_feature("Ocean :: Safe Escape", "action", TELEPORT_QL.id, function()
    menu.notify("Teleported to Ocean", "", 4, 0x64F06414)
    if player.is_player_in_any_vehicle ~= 1 then do
    pedmy = player.get_player_vehicle(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4905.050,-6339.578,-89.830)) end end
    if player.is_player_in_any_vehicle ~= 0 then do
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4905.050,-6339.578,-89.830)) end end
end)
--
menu.add_feature("Mansion Outside Underwater Entry", "action", TELEPORTMANSIONO.id, function()
    menu.notify("Teleported to  Mansion Underwater Entry", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5047.394, -5820.962, -12.447))
end)
    
menu.add_feature("Mansion Outside Main Gate ", "action", TELEPORTMANSIONO.id, function()
    menu.notify("Teleported to  Mansion Main Gate ", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4972.337, -5701.617, 19.887))
end)
    
menu.add_feature("Mansion Outside North Grapple Point", "action", TELEPORTMANSIONO.id, function()
    menu.notify("Teleported to  Mansion North Grapple Point", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5041.111, -5675.523, 19.292))
end)
    
menu.add_feature("Mansion Outside North Door Entry Point", "action", TELEPORTMANSIONO.id, function()
    menu.notify("Teleported to  Mansion North Door Entry Point", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5086.59, -5730.8, 15.773))
end)
    
menu.add_feature("Mansion Outside South Grapple Point", "action", TELEPORTMANSIONO.id, function()
    menu.notify("Teleported to  Mansion South Grapple Point", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4987.32, -5819.869, 19.548))
end)
    
menu.add_feature("Mansion Outside South Door Entry Point", "action", TELEPORTMANSIONO.id, function()
    menu.notify("Teleported to  Mansion South Door Entry Point", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4958.965, -5785.213, 20.839))
end)

--
menu.add_feature("Airfield Control Tower", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Airfield AA Control", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4374.47, -4577.694, 4.208))
end)
    
menu.add_feature("Airfield Power Station", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Airfield Power Control", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4478.387, -4591.498, 5.568))
end)
    
menu.add_feature("Airfield Airplane Exit Spot", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Airplane Exit Spot", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4493.552, -4472.608, 4.212))
end)
    
menu.add_feature("Airfield Loot Hanger Lower", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Hanger Lower Loot", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4437.678, -4449.029, 4.328))
end)
    
menu.add_feature("Airfield Loot Hanger Upper", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Hanger Upper Loot", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4445.451, -4444.368, 7.237))
end)
    
menu.add_feature("Airfield Loot Other Bldg", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Airfield Bldg Loot", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4503.399, -4552.043, 4.161))
end)
    
menu.add_feature("North Dock Safe Place", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  North Dock", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5064.167, -4587.988, 2.988))
end)
    
menu.add_feature("North Dock Loot Bldg 1", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  North Dock Bldg 1 Loot", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5065.108, -4592.708, 2.855))
end)
    
menu.add_feature("North Dock Loot Bldg 2", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  North Dock Bldg 2 Loot", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5134.84, -4609.992, 2.529))
end)
    
menu.add_feature("North Dock Loot Bldg 3", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  North Dock Bldg 3 Loot", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5090.356, -4682.487, 2.407))
end)
    
menu.add_feature("Weed Field Loot", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Weed Field Loot", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5331.424, -5269.504, 33.186))
end)
    
menu.add_feature("Processing Area Loot", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Processing Area Loot", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5193.133, -5134.256, 3.345))
end)
    
menu.add_feature("Main Dock Safe Place", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Main Dock ", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4847.7, -5325.062, 15.017))
end)
    
menu.add_feature("Main Dock Loot Bldg 1", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Main Dock Bldg 1 Loot ", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4923.587, -5242.541, 2.523))
end)
    
menu.add_feature("Main Dock Loot Bldg 2", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Main Dock Bldg 2 Loot ", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4998.355, -5165.41, 2.764))
end)
    
menu.add_feature("Main Dock Loot Bldg 3", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Main Dock Bldg 3 Loot ", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4961.247, -5109.312, 2.982))
end)
    
menu.add_feature("Comm Tower Base", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Comm Tower", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5270.362, -5422.213, 65.579))
end)
    
menu.add_feature("Comm Tower Level 1", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Comm Tower Level 1", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5262.419, -5428.451, 90.724))
end)
    
menu.add_feature("Comm Tower Level 2", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Comm Tower Level 2", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5263.550, -5428.477, 109.148))
end)
    
menu.add_feature("Comm Tower Level 3 Top", "action", TELEPORTLOOT.id, function()
    menu.notify("Teleported to  Comm Tower Level 3 Top", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5266.207, -5427.754, 141.047))
end)
-- 
menu.add_feature("Mansion Office", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion Office", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5008.106, -5752.442, 28.845))
end)

menu.add_feature("Mansion Basement Loot Primary", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion Basement Primary Loot", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5007.573, -5754.908, 15.484))
end)

menu.add_feature("Mansion Basement Loot Room 1", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion Basement Loot Room 1", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5001.469, -5747.327, 14.84))
end)

menu.add_feature("Mansion Room 1 Loot", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion Loot Room 1", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5084.015, -5758.132, 15.83))
end)

menu.add_feature("Mansion Room 2 Loot", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion Loot Room 2", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5009.42, -5790.591, 17.832))
end)

menu.add_feature("Mansion Room 3 Loot", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion Loot Room 3", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5031.386, -5737.249, 17.866))
end)

menu.add_feature("Mansion Exit Point Main Gate", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion Main Gate Exit Point ", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4986.727, -5723.624, 19.88))
end)

menu.add_feature("Mansion Exit Point North Grapple", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion North Grapple Exit Point ", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5024.82, -5682.374, 19.877))
end)

menu.add_feature("Mansion Exit Point South Grapple", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion South Grapple Exit Point ", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4998.833, -5801.947, 20.877))
end)

menu.add_feature("Mansion Exit Point North Door", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion North Door Exit Point", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5084.957, -5739.043, 15.677))
end)

menu.add_feature("Mansion Exit Point South Door", "action", TELEPORTMANSIONI.id, function()
menu.notify("Teleported to  Mansion South Door Exit Point", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4967.008, -5783.731, 20.878))
end)

--

menu.add_feature("Land 1", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 1", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5176.394, -4678.343, 2.427))
end)

menu.add_feature("Land 2", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 2", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4855.533, -5561.123, 27.534))
end)

menu.add_feature("Land 3", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 3", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4877.224, -4781.618, 2.068))
end)

menu.add_feature("Land 4", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 4", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5591.956, -5215.923, 14.351))
end)

menu.add_feature("Land 5", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 5", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5458.669, -5860.041, 19.973))
end)

menu.add_feature("Land 6", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 6", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4855.781, -5163.507, 2.439))
end)

menu.add_feature("Land 7", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 7", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(3898.093, -4710.935, 4.771))
end)

menu.add_feature("Land 8", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 8", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4822.828, -4322.015, 5.617))
end)

menu.add_feature("Land 9", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 9", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4535.064, -4702.882, 2.431))
end)

menu.add_feature("Land 10", "action", TELEPORTCHESTS.id, function()
menu.notify("Teleported to Land 10", "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4179.426, -4358.279, 2.686))
end)

menu.add_feature("Ocean 1", "action", TELEPORTCHESTS.id, function()
    menu.notify("Teleported to Ocean 1", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4415.093, -4653.384, -4.172))
end)
    
menu.add_feature("Ocean 2", "action", TELEPORTCHESTS.id, function()
    menu.notify("Teleported to Ocean 2", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4560.742, -4355.47, -7.187))
end)
    
menu.add_feature("Ocean 3", "action", TELEPORTCHESTS.id, function()
    menu.notify("Teleported to Ocean 3", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5262.87, -4919.246, -1.878))
end)
    
menu.add_feature("Ocean 4", "action", TELEPORTCHESTS.id, function()
    menu.notify("Teleported to Ocean 4", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4561.338, -4768.874, -2.167))
end)
    
menu.add_feature("Ocean 5", "action", TELEPORTCHESTS.id, function()
    menu.notify("Teleported to Ocean 5", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4943.188, -4294.895, -5.481))
end)
    
menu.add_feature("Ocean 6", "action", TELEPORTCHESTS.id, function()
    menu.notify("Teleported to Ocean 6", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5599.706, -5604.149, -5.064))
end)
    
menu.add_feature("Ocean 7", "action", TELEPORTCHESTS.id, function()
    menu.notify("Teleported to Ocean 7", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(3982.371, -4542.297, -5.194))
end)
    
menu.add_feature("Ocean 8", "action", TELEPORTCHESTS.id, function()
    menu.notify("Teleported to Ocean 8", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4775.263, -5394.031, -4.116))
end)
    
menu.add_feature("Ocean 9", "action", TELEPORTCHESTS.id, function()
    menu.notify("Teleported to Ocean 9", "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4940.111, -5167.373, -2.564))
end)

-- CASINO CUSTOM TELEPORT
-- Removed for not being efficient

-- DOOMSDAY CUSTOM TELEPORT

menu.add_feature("» Photo screen : Submarine Board (ACT II)", "action", TELEPORT_DOOMS.id, function()
    menu.notify("Teleported sucessfully", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(515.528,4835.353,-62.587))
end)

menu.add_feature("» Prisoner cell : Submarine Room (ACT II)", "action", TELEPORT_DOOMS.id, function()
    menu.notify("Teleported sucessfully", "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(512.888,4833.033,-68.989))
end)

do
    menu.add_feature("» About", "action", Heist_Control.id, function()
    menu.notify("Many thanks to\n* haekkzer\n* kektram\n* Proddy\n* GhostOne\n* Kiddion\n* 2Take1 Devs\n\nThanks E.#7777 (Donor)\nThanks igobythisname#3730 (Donor)", "", 5, 0x50FA7878)
    menu.notify("For future updates, visit:\ngithub.com/jhowkNx/Heist-Control-v2", "Official GitHub", 5, 0x50FA7878)
    end)
end

---- AUTO (ALL PLAYERS) NO SECONDARY TARGET
do
local QUICK_SET_ANY = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 0},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_PAINT", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_PAINT_V", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_CASH_I_SCOPED", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 0},
    {"H4CNF_TARGET", 5},
    {"H4CNF_WEAPONS", 5},
    {"H4_MISSIONS", 65283},
    {"H4_PROGRESS", 126823}
}
menu.add_feature("» Load Quick Preset", "toggle", QUICK_PRST.id, function(quickcp)
    menu.notify("* There are no secondary targets\n* Steal the primary target and escape\n* Only Kosatka is available\n* Do not mess with the Players Percentage\n* You can steal the money from the safe (Optional)\n\n* Leave activated until you finish the Heist", "Information", 13, 0x5014B4F0)
    while quickcp.on do
        for i = 1, #QUICK_SET_ANY do
        stat_set_int(QUICK_SET_ANY[i][1], true, QUICK_SET_ANY[i][2])
        end
        script.set_global_i(1973496+823+56+1,145) -- original version 1710289 + 823 + 56 + 1
        script.set_global_i(1973496+823+56+2,145) -- original version 1710289 + 823 + 56 + 2
        script.set_global_i(1973496+823+56+3,145) -- original version 1710289 + 823 + 56 + 3
        script.set_global_i(1973496+823+56+4,145) -- original version 1710289 + 823 + 56 + 4
        --script.set_global_f(262145+29625,0.0)
        --script.set_global_f(262145+29626,0.0)
        --script.set_global_i(262145 + 29621,2455000)
    system.yield(0)
    end
end)
end

-- WEEKLY EVENT QUICK METHOD
do
local WEAKLY_QUICK = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", -1},
    {"H4LOOT_CASH_I", 0},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_PAINT", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_PAINT_V", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_CASH_I_SCOPED", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 0},
    {"H4CNF_TARGET", 5},
    {"H4CNF_WEAPONS", 4},
    {"H4_MISSIONS", 65283},
    {"H4_PROGRESS", 126823}
}
menu.add_feature("» Quick Preset (1-4) $4.1MI [Main Target only]", "toggle", WEEKLY_PRESET.id, function(quickSET)
    menu.notify("Information\n\n- There are no secondary targets, your goal is just to steal the primary target and escape\n\n- There are no other vehicles available besides the Kosatka\n\n- Do not mess with the percentage or targets\n\n- Disable only at end of heist", "Heist Control", 15, 0x64F06414)
    menu.notify("Note: This preset has a visual bug that shows an unusual amount at the end of the heist, however if you look in online players you can verify the true payment of other members.", "", 10, 0x501400FF)
    while quickSET.on do
        for i = 1, #WEAKLY_QUICK do
            stat_set_int(WEAKLY_QUICK[i][1], true, WEAKLY_QUICK[i][2])
        end
        script.set_global_i(1973496+823+56+1,100) -- original version 1710289 + 823 + 56 + 1
        script.set_global_i(1973496+823+56+2,145) -- original version 1710289 + 823 + 56 + 2
        script.set_global_i(1973496+823+56+3,145) -- original version 1710289 + 823 + 56 + 3
        script.set_global_i(1973496+823+56+4,145) -- original version 1710289 + 823 + 56 + 4
        script.set_global_f(262145+29625,0.0)
        script.set_global_f(262145+29626,0.0)
        script.set_global_i(262145 + 29621,4025000)
    system.yield(0)
    end
end)
end

--- CAYO AUTOMATED PRESET SOLO PLAYER
do
local AUTOMATED_1P_TARGET_5 = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 8128},
    {"H4LOOT_CASH_I_SCOPED", 8128},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 63},
    {"H4LOOT_COKE_I_SCOPED", 63},
    {"H4LOOT_COKE_C", 22},
    {"H4LOOT_COKE_C_SCOPED", 22},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 168},
    {"H4LOOT_GOLD_C_SCOPED", 168},
    {"H4LOOT_WEED_I", 16769024},
    {"H4LOOT_WEED_I_SCOPED", 16769024},
    {"H4LOOT_WEED_C", 65},
    {"H4LOOT_WEED_C_SCOPED", 65},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 207386},
    {"H4LOOT_COKE_V", 414772},
    {"H4LOOT_GOLD_V", 553029},
    {"H4LOOT_PAINT_V", 414772},
    {"H4LOOT_WEED_V", 331818},
        --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", -1},
    {"H4CNF_BS_ENTR", -1},
    {"H4CNF_BS_ABIL", -1},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}

local AUTOMATED_1P_TARGET_5_A = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature("» Panther Statue", "toggle", AUTOMATED_SOLO.id, function(SOLO_SAPH_var0)
    menu.notify("\tDon't forget to:\n\n* Fill your bag with any target\n* Leave it activated until the end of the Heist", "Cayo Perico Heist | Solo | Panther Statue", 7, 0x501E7800)
    for i = 1, #AUTOMATED_1P_TARGET_5_A do
        stat_set_int(AUTOMATED_1P_TARGET_5_A[i][1], true, AUTOMATED_1P_TARGET_5_A[i][2])
    end
        while SOLO_SAPH_var0.on do
    for i = 1, #AUTOMATED_1P_TARGET_5 do
        stat_set_int(AUTOMATED_1P_TARGET_5[i][1], true, AUTOMATED_1P_TARGET_5[i][2])
    end
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,100) -- original version 1710289 + 823 + 56 + 1
        system.yield(0)
    end
end)
end

--- CAYO AUTOMATED PRESET SOLO
do
local CAYO_SOLO_AUTO_TARGET_3 = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 3},
    {"H4LOOT_CASH_I", 63},
    {"H4LOOT_CASH_I_SCOPED", 63},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 16769024},
    {"H4LOOT_COKE_I_SCOPED", 16769024},
    {"H4LOOT_COKE_C", 22},
    {"H4LOOT_COKE_C_SCOPED", 22},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 168},
    {"H4LOOT_GOLD_C_SCOPED", 168},
    {"H4LOOT_WEED_I", 8128},
    {"H4LOOT_WEED_I_SCOPED", 8128},
    {"H4LOOT_WEED_C", 65},
    {"H4LOOT_WEED_C_SCOPED", 65},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 357386},
    {"H4LOOT_COKE_V", 714772},
    {"H4LOOT_GOLD_V", 953029},
    {"H4LOOT_PAINT_V", 714772},
    {"H4LOOT_WEED_V", 571818},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}

local USER_CAN_MDFY_PRESET_AUTO_SOLO_T3 = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature("» Pink Diamond", "toggle", AUTOMATED_SOLO.id, function(SOLO_TARGET3)
    menu.notify("\tDon't forget to:\n\n* Fill your bag with any target\n* Leave it activated until the end of the Heist", "Cayo Perico Heist | Solo | Pink Diamond", 7, 0x501E7800)
    for i = 1, #USER_CAN_MDFY_PRESET_AUTO_SOLO_T3 do
        stat_set_int(USER_CAN_MDFY_PRESET_AUTO_SOLO_T3[i][1], true, USER_CAN_MDFY_PRESET_AUTO_SOLO_T3[i][2])
    end
    while SOLO_TARGET3.on do      
    for i = 2, #CAYO_SOLO_AUTO_TARGET_3 do
        stat_set_int(CAYO_SOLO_AUTO_TARGET_3[i][1], true, CAYO_SOLO_AUTO_TARGET_3[i][2])
    end      
    script.set_global_f(262145+29625,-0.1) --pavel cut protection
    script.set_global_f(262145+29626,-0.02) --fency fee cut protection
    script.set_global_i(262145+29379,1800) -- bag protection
    script.set_global_i(1973496+823+56+1,100) -- cut original version 1710289 + 823 + 56 + 1
    system.yield(0)
    end
end)
end
----- AUTOMATED 2 PLAYERS
do
local AUTOMATED_2P_TARGET_5 = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 8128},
    {"H4LOOT_CASH_I_SCOPED", 8128},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 63},
    {"H4LOOT_COKE_I_SCOPED", 63},
    {"H4LOOT_COKE_C", 22},
    {"H4LOOT_COKE_C_SCOPED", 22},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 168},
    {"H4LOOT_GOLD_C_SCOPED", 168},
    {"H4LOOT_WEED_I", 16769024},
    {"H4LOOT_WEED_I_SCOPED", 16769024},
    {"H4LOOT_WEED_C", 65},
    {"H4LOOT_WEED_C_SCOPED", 65},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 457386},
    {"H4LOOT_COKE_V", 914772},
    {"H4LOOT_GOLD_V", 1219696},
    {"H4LOOT_PAINT_V", 914772},
    {"H4LOOT_WEED_V", 731818},
        --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local AUTOMATED_2P_TARGET_5_A = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature("» Panther Statue", "toggle", AUTOMATED_2P.id, function(AUTO_2_SAPH_var0)
    menu.notify("\tDon't forget to:\n\n* Fill your bag with any target\n* Leave it activated until the end of the Heist", "Cayo Perico Heist | Duo | Panther Statue", 7, 0x501E7800)
    menu.notify("Duo Preset - Players Payout Blocked to 50%\n\nEstimated payout for each player:\n $2.550,000\n\nBag changes are blocked to avoid payment problems", "Heist Control Payout Safety", 7, 0x50143CDC)

    for i = 1, #AUTOMATED_2P_TARGET_5_A do
    stat_set_int(AUTOMATED_2P_TARGET_5_A[i][1], true, AUTOMATED_2P_TARGET_5_A[i][2])
    end

    while AUTO_2_SAPH_var0.on do
    for i = 1, #AUTOMATED_2P_TARGET_5 do
    stat_set_int(AUTOMATED_2P_TARGET_5[i][1], true, AUTOMATED_2P_TARGET_5[i][2])
    end
    script.set_global_f(262145+29625,-0.1) --pavel cut protection
    script.set_global_f(262145+29626,-0.02) --fency fee cut protection
    script.set_global_i(262145+29379,1800) -- bag protection
    script.set_global_i(1973496+823+56+1,50)
    script.set_global_i(1973496+823+56+2,50)
    system.yield(0)
end
end)
end

--- AUTOMATED 2 Players
do
local AUTOMATED_2_TARGET_3 = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 3},
    {"H4LOOT_CASH_I", 63},
    {"H4LOOT_CASH_I_SCOPED", 63},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 16769024},
    {"H4LOOT_COKE_I_SCOPED", 16769024},
    {"H4LOOT_COKE_C", 22},
    {"H4LOOT_COKE_C_SCOPED", 22},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 168},
    {"H4LOOT_GOLD_C_SCOPED", 168},
    {"H4LOOT_WEED_I", 8128},
    {"H4LOOT_WEED_I_SCOPED", 8128},
    {"H4LOOT_WEED_C", 65},
    {"H4LOOT_WEED_C_SCOPED", 65},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 532386},
    {"H4LOOT_COKE_V", 1064772},
    {"H4LOOT_GOLD_V", 1419696},
    {"H4LOOT_PAINT_V", 1064772},
    {"H4LOOT_WEED_V", 851818},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local AUTOMATED_2_TARGET_3_A = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature("» Pink Diamond", "toggle", AUTOMATED_2P.id, function(P2_T3)
        menu.notify("\tDon't forget to:\n\n* Fill your bag with any target\n* Leave it activated until the end of the Heist", "Cayo Perico Heist | Duo | Pink Diamond", 7, 0x501E7800)
        menu.notify("Duo Preset - Players Payout Blocked to 50%\n\nEstimated payout for each player:\n $2.550,000\n\nBag changes are blocked to avoid payment problems", "Heist Control Payout Safety", 7, 0x50143CDC)
    for i = 1, #AUTOMATED_2_TARGET_3_A do
        stat_set_int(AUTOMATED_2_TARGET_3_A[i][1], true, AUTOMATED_2_TARGET_3_A[i][2])
    end
    while P2_T3.on do
    for i = 1, #AUTOMATED_2_TARGET_3 do
        stat_set_int(AUTOMATED_2_TARGET_3[i][1], true, AUTOMATED_2_TARGET_3[i][2])
    end
    script.set_global_f(262145+29625,-0.1) --pavel cut protection
    script.set_global_f(262145+29626,-0.02) --fency fee cut protection
    script.set_global_i(262145+29379,1800) -- bag protection
    script.set_global_i(1973496+823+56+1,50)
    script.set_global_i(1973496+823+56+2,50)
    system.yield(0)
end
end)
end

do
--- CAYO AUTOMATED PRESET 3 PLAYERS
local AUTOMATED_3P_TARGET_5 = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 8128},
    {"H4LOOT_CASH_I_SCOPED", 8128},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 63},
    {"H4LOOT_COKE_I_SCOPED", 63},
    {"H4LOOT_COKE_C", 22},
    {"H4LOOT_COKE_C_SCOPED", 22},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 168},
    {"H4LOOT_GOLD_C_SCOPED", 168},
    {"H4LOOT_WEED_I", 16769024},
    {"H4LOOT_WEED_I_SCOPED", 16769024},
    {"H4LOOT_WEED_C", 65},
    {"H4LOOT_WEED_C_SCOPED", 65},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 507034},
    {"H4LOOT_COKE_V", 1014069},
    {"H4LOOT_GOLD_V", 1352091},
    {"H4LOOT_PAINT_V", 1014069},
    {"H4LOOT_WEED_V", 811255},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local AUTOMATED_3P_TARGET_5_A = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature("» Panther Statue", "toggle", AUTOMATED_3P.id, function(CAYO_3P_AUTO)
        menu.notify("\tDon't forget to:\n\n* Fill your bag with any target\n* Leave it activated until the end of the Heist", "Cayo Perico Heist | Trio | Panther Statue", 7, 0x501E7800)
        menu.notify("Trio Preset - Players Payout Blocked to\n\nHost: 30%\nPlayer2: 35%\nPlayer3: 35%\n\nEstimated payout for each player:\n $2.550,000\n\nBag changes are blocked to avoid payment problems", "Heist Control Payout Safety", 7, 0x50143CDC)
    for i = 1, #AUTOMATED_3P_TARGET_5_A do
    stat_set_int(AUTOMATED_3P_TARGET_5_A[i][1], true, AUTOMATED_3P_TARGET_5_A[i][2])
    end
    while CAYO_3P_AUTO.on do    
    for i = 1, #AUTOMATED_3P_TARGET_5 do
        stat_set_int(AUTOMATED_3P_TARGET_5[i][1], true, AUTOMATED_3P_TARGET_5[i][2])
    end
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,35)
        script.set_global_i(1973496+823+56+2,35)
        script.set_global_i(1973496+823+56+3,35)
        system.yield(0)
    end
end)
end

do
--- CAYO AUTOMATED 3 PLAYERS 
local AUTOMATED_3P_TARGET_3 = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 3},
    {"H4LOOT_CASH_I", 63},
    {"H4LOOT_CASH_I_SCOPED", 63},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 16769024},
    {"H4LOOT_COKE_I_SCOPED", 16769024},
    {"H4LOOT_COKE_C", 22},
    {"H4LOOT_COKE_C_SCOPED", 22},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 168},
    {"H4LOOT_GOLD_C_SCOPED", 168},
    {"H4LOOT_WEED_I", 8128},
    {"H4LOOT_WEED_I_SCOPED", 8128},
    {"H4LOOT_WEED_C", 65},
    {"H4LOOT_WEED_C_SCOPED", 65},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 557034},
    {"H4LOOT_COKE_V", 1114069},
    {"H4LOOT_GOLD_V", 1485425},
    {"H4LOOT_PAINT_V", 1114069},
    {"H4LOOT_WEED_V", 891255},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local AUTOMATED_3P_TARGET_3_A = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature("» Pink Diamond", "toggle", AUTOMATED_3P.id, function(PATCH_3)
    menu.notify("\tDon't forget to:\n\n* Fill your bag with any target\n* Leave it activated until the end of the Heist", "Cayo Perico Heist | Trio | Pink Diamond", 7, 0x501E7800)
    menu.notify("Trio Preset - Players Payout Blocked to\n\nHost: 30%\nPlayer2: 35%\nPlayer3: 35%\n\nEstimated payout for each player:\n $2.550,000\n\nBag changes are blocked to avoid payment problems", "Heist Control Payout Safety", 7, 0x50143CDC)
    for i = 1, #AUTOMATED_3P_TARGET_3_A do
        stat_set_int(AUTOMATED_3P_TARGET_3_A[i][1], true, AUTOMATED_3P_TARGET_3_A[i][2])
    end
    while PATCH_3.on do
    for i = 2, #AUTOMATED_3P_TARGET_3 do
        stat_set_int(AUTOMATED_3P_TARGET_3[i][1], true, AUTOMATED_3P_TARGET_3[i][2])
    end
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,35)
        script.set_global_i(1973496+823+56+2,35)
        script.set_global_i(1973496+823+56+3,35)
        system.yield(0)
    end
end)
end

--- CAYO AUTOMATED PRESET 4 PLAYERS
do
local AUTOMATED_4P_TARGET_5 = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 8128},
    {"H4LOOT_CASH_I_SCOPED", 8128},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 63},
    {"H4LOOT_COKE_I_SCOPED", 63},
    {"H4LOOT_COKE_C", 22},
    {"H4LOOT_COKE_C_SCOPED", 22},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 168},
    {"H4LOOT_GOLD_C_SCOPED", 168},
    {"H4LOOT_WEED_I", 16769024},
    {"H4LOOT_WEED_I_SCOPED", 16769024},
    {"H4LOOT_WEED_C", 65},
    {"H4LOOT_WEED_C_SCOPED", 65},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 582386},
    {"H4LOOT_COKE_V", 1164772},
    {"H4LOOT_GOLD_V", 1553030},
    {"H4LOOT_PAINT_V", 1164772},
    {"H4LOOT_WEED_V", 931818},
        --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local AUTOMATED_4P_TARGET_5_A = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature("» Panther Statue", "toggle", AUTOMATED_4P.id, function(TARGET_5_A)
    menu.notify("\tDon't forget to:\n\n* Fill your bag with any target\n* Leave it activated until the end of the Heist", "Cayo Perico Heist | Squad | Panther Statue", 7, 0x501E7800)
    menu.notify("Squad Preset - Players Payout Blocked to\n\nHost: 25%\nPlayer2: 25%\nPlayer3: 25%\nPlayer4: 25%\n\nEstimated payout for each player:\n $2.550,000\n\nBag changes are blocked to avoid payment problems", "Heist Control Payout Safety", 7, 0x50143CDC)
    for i = 1, #AUTOMATED_4P_TARGET_5_A do
        stat_set_int(AUTOMATED_4P_TARGET_5_A[i][1], true, AUTOMATED_4P_TARGET_5_A[i][2])
    end
    while TARGET_5_A.on do
        for i = 1, #AUTOMATED_4P_TARGET_5 do
            stat_set_int(AUTOMATED_4P_TARGET_5[i][1], true, AUTOMATED_4P_TARGET_5[i][2])
        end
    script.set_global_f(262145+29625,-0.1) --pavel cut protection
    script.set_global_f(262145+29626,-0.02) --fency fee cut protection
    script.set_global_i(262145+29379,1800) -- bag protection
    script.set_global_i(1973496+823+56+1,25) -- player 1
    script.set_global_i(1973496+823+56+2,25) -- player 2
    script.set_global_i(1973496+823+56+3,25) -- player 3
    script.set_global_i(1973496+823+56+4,25) -- player 4
    system.yield(0)
end
end)
end

--- CAYO AUTOMATED PRESET 4 PLAYERS
do
local AUTOMATED_4P_TARGET_3 = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 3},
    {"H4LOOT_CASH_I", 63},
    {"H4LOOT_CASH_I_SCOPED", 63},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 16769024},
    {"H4LOOT_COKE_I_SCOPED", 16769024},
    {"H4LOOT_COKE_C", 22},
    {"H4LOOT_COKE_C_SCOPED", 22},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 168},
    {"H4LOOT_GOLD_C_SCOPED", 168},
    {"H4LOOT_WEED_I", 8128},
    {"H4LOOT_WEED_I_SCOPED", 8128},
    {"H4LOOT_WEED_C", 65},
    {"H4LOOT_WEED_C_SCOPED", 65},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 619886},
    {"H4LOOT_COKE_V", 1239772},
    {"H4LOOT_GOLD_V", 1653030},
    {"H4LOOT_PAINT_V", 1239772},
    {"H4LOOT_WEED_V", 991818},
     --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local AUTOMATED_4P_TARGET_3_A = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature("» Pink Diamond", "toggle", AUTOMATED_4P.id, function(PATCH_4)
    menu.notify("\tDon't forget to:\n\n* Fill your bag with any target\n* Leave it activated until the end of the Heist", "Cayo Perico Heist | Squad | Pink Diamond", 7, 0x501E7800)
    menu.notify("Squad Preset - Players Payout Blocked to\n\nHost: 25%\nPlayer2: 25%\nPlayer3: 25%\nPlayer4: 25%\n\nEstimated payout for each player:\n $2.550,000\n\nBag changes are blocked to avoid payment problems", "Heist Control Payout Safety", 7, 0x50143CDC)
    for i = 1, #AUTOMATED_4P_TARGET_3_A do
        stat_set_int(AUTOMATED_4P_TARGET_3_A[i][1], true, AUTOMATED_4P_TARGET_3_A[i][2])
    end
    while PATCH_4.on do    
    for i = 1, #AUTOMATED_4P_TARGET_3 do
    stat_set_int(AUTOMATED_4P_TARGET_3[i][1], true, AUTOMATED_4P_TARGET_3[i][2])
    end
    script.set_global_f(262145+29625,-0.1) --pavel cut protection
    script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,25) -- player 1
        script.set_global_i(1973496+823+56+2,25) -- player 2
        script.set_global_i(1973496+823+56+3,25) -- player 3
        script.set_global_i(1973496+823+56+4,25) -- player 4
        system.yield(0)
    end
end)
end

-- WEEKLY EVENT (PRESETS)
-- SOLO ONE
do
local WKLY_SOLO_PANTHER = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 6490148},
    {"H4LOOT_CASH_I_SCOPED", 6490148},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 8421904},
    {"H4LOOT_COKE_I_SCOPED", 8421904},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 1311112},
    {"H4LOOT_WEED_I_SCOPED", 1311112},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 670454},
    {"H4LOOT_COKE_V", 1340909},
    {"H4LOOT_GOLD_V", 1787878},
    {"H4LOOT_PAINT_V", 1340909},
    {"H4LOOT_WEED_V", 1072727},
         --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}

local USER_CAN_MDFY_WKLY_SOLO_PANTHER= {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature("» Panther Statue", "toggle", WEEKLY_SOLO.id, function(WEEKLY_SOLO_v0)
    menu.notify("Preset added to SOLO\n- Don't use any advanced options\n- Don't use bag modifier\n- Don't change the percentage set by the script\n- Fill your bag with ANY item (Just fill it out)\n\n- Leave this option enabled until you finish the Heist", "Cayo Perico SOLO | Panther Statue", 7, 0x6414F0FF)
    for i = 1, #USER_CAN_MDFY_WKLY_SOLO_PANTHER do
        stat_set_int(USER_CAN_MDFY_WKLY_SOLO_PANTHER[i][1], true, USER_CAN_MDFY_WKLY_SOLO_PANTHER[i][2])
    end
    while WEEKLY_SOLO_v0.on do
        for i = 1, #WKLY_SOLO_PANTHER do
        stat_set_int(WKLY_SOLO_PANTHER[i][1], true, WKLY_SOLO_PANTHER[i][2])
        end
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- Bag protection
        script.set_global_i(1973496+823+56+1,100) -- Player 1 (SOLO)
        system.yield(0)
    end
end)
end

-- WEEKLY DUO
do
local WKLY_DUO_PANTHER = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 6490148},
    {"H4LOOT_CASH_I_SCOPED", 6490148},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 8421904},
    {"H4LOOT_COKE_I_SCOPED", 8421904},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 1311112},
    {"H4LOOT_WEED_I_SCOPED", 1311112},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 920454},
    {"H4LOOT_COKE_V", 1840909},
    {"H4LOOT_GOLD_V", 2454545},
    {"H4LOOT_PAINT_V", 1840909},
    {"H4LOOT_WEED_V", 1472727},
            --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local USER_CAN_MDFY_WKLY_DUO_PANTHER = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature("» Panther Statue", "toggle", WEEKLY_F2.id, function(WEEKLY_DUO_v0)
    menu.notify("Estimated payout for each player:\n $4.100,000\n\nPlayers Cut (Blocked)\nBoth: 50% ", "Heist Control Safety", 10, 0x64C878F0)
    menu.notify("Preset added for 2 players\n- Don't use any advanced options\n- Don't use bag modifier\n- Don't change the percentage set by the script\n- Fill your bag with ANY item (Just fill it out)\n\n- Leave this option enabled until you finish the Heist", "Cayo Perico 2 Players | Panther Statue", 7, 0x6414F0FF)
    for i = 1, #USER_CAN_MDFY_WKLY_DUO_PANTHER do
    stat_set_int(USER_CAN_MDFY_WKLY_DUO_PANTHER[i][1], true, USER_CAN_MDFY_WKLY_DUO_PANTHER[i][2])
    end
    while WEEKLY_DUO_v0.on do
    for i = 1, #WKLY_DUO_PANTHER do
    stat_set_int(WKLY_DUO_PANTHER[i][1], true, WKLY_DUO_PANTHER[i][2])
    end
    script.set_global_f(262145+29625,-0.1) --pavel cut protection
    script.set_global_f(262145+29626,-0.02) --fency fee cut protection
    script.set_global_i(262145+29379,1800) -- bag protection
    script.set_global_i(1973496+823+56+1,50)
    script.set_global_i(1973496+823+56+2,50)
    system.yield(0)
end
end)
end

-- WEEKLY TRIO
do
local WKLY_TRIO_PANTHER = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 6490148},
    {"H4LOOT_CASH_I_SCOPED", 6490148},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 8421904},
    {"H4LOOT_COKE_I_SCOPED", 8421904},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 1311112},
    {"H4LOOT_WEED_I_SCOPED", 1311112},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 948051},
    {"H4LOOT_COKE_V", 1896103},
    {"H4LOOT_GOLD_V", 2528137},
    {"H4LOOT_PAINT_V", 1896103},
    {"H4LOOT_WEED_V", 1516882},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local USER_CAN_MDFY_WKLY_TRIO_PANTHER = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature("» Panther Statue", "toggle", WEEKLY_F3.id, function(WEEKLY_TRIO_v0)
    menu.notify("Estimated payout for each player:\n $4.100,000\n\nPlayers Cut (Blocked)\nHost: 30%\nOthers: 35%", "Heist Control Safety", 10, 0x64C878F0)
    menu.notify("Preset added for 3 players\n- Don't use any advanced options\n- Don't use bag modifier\n- Don't change the percentage set by the script\n- Fill your bag with ANY item (Just fill it out)\n\n- Leave this option enabled until you finish the Heist", "Cayo Perico 3 Players | Panther Statue", 7, 0x6414F0FF)
    for i = 1, #USER_CAN_MDFY_WKLY_TRIO_PANTHER do
    stat_set_int(USER_CAN_MDFY_WKLY_TRIO_PANTHER[i][1], true, USER_CAN_MDFY_WKLY_TRIO_PANTHER[i][2])
    end
        while WEEKLY_TRIO_v0.on do
        for i = 1, #WKLY_TRIO_PANTHER do
        stat_set_int(WKLY_TRIO_PANTHER[i][1], true, WKLY_TRIO_PANTHER[i][2])
        end
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,30)
        script.set_global_i(1973496+823+56+2,35)
        script.set_global_i(1973496+823+56+3,35)
        system.yield(0)
    end
end)
end

-- WEEKLY FOUR PLAYERS
do
local WKLY_FOUR_PANTHER = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 6490148},
    {"H4LOOT_CASH_I_SCOPED", 6490148},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 8421904},
    {"H4LOOT_COKE_I_SCOPED", 8421904},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 1311112},
    {"H4LOOT_WEED_I_SCOPED", 1311112},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 1045454},
    {"H4LOOT_COKE_V", 2090909},
    {"H4LOOT_GOLD_V", 2787878},
    {"H4LOOT_PAINT_V", 2090909},
    {"H4LOOT_WEED_V", 1672727},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local USER_CAN_MDFY_WKLY_FOUR_PANTHER = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature("» Panther Statue", "toggle", WEEKLY_F4.id, function(WEEKLY_FOUR_v0)
    menu.notify("Estimated payout for each player:\n $4.100,000\n\nPlayers Cut (Blocked)\nEveryone: 25%", "Heist Control Safety", 10, 0x64C878F0)
    menu.notify("Preset added for 4 players\n- Don't use any advanced options\n- Don't use bag modifier\n- Don't change the percentage set by the script\n- Fill your bag with ANY item (Just fill it out)\n\n- Leave this option enabled until you finish the Heist", "Cayo Perico 4 Players | Panther Statue", 7, 0x6414F0FF)
    for i = 1, #USER_CAN_MDFY_WKLY_FOUR_PANTHER do
        stat_set_int(USER_CAN_MDFY_WKLY_FOUR_PANTHER[i][1], true, USER_CAN_MDFY_WKLY_FOUR_PANTHER[i][2])
    end
        while WEEKLY_FOUR_v0.on do
        for i = 1, #WKLY_FOUR_PANTHER do
        stat_set_int(WKLY_FOUR_PANTHER[i][1], true, WKLY_FOUR_PANTHER[i][2])
        end
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,25) -- player 1
        script.set_global_i(1973496+823+56+2,25) -- player 2
        script.set_global_i(1973496+823+56+3,25) -- player 3
        script.set_global_i(1973496+823+56+4,25) -- player 4
        system.yield(0)
    end
end)
end

------- ADVANCED FEATURES CAYO

menu.add_feature("Custom Payout", "action", PERICO_HOST_CUT.id, function(perico_host)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1973496+823+56+1, tonumber(s))
end)

menu.add_feature("0 %", "toggle", PERICO_HOST_CUT.id, function(prio)
    while prio.on do
    script.set_global_i(1973496+823+56+1,0)
    system.yield(0)
end
end)

menu.add_feature("50 %", "action", PERICO_HOST_CUT.id, function()
    script.set_global_i(1973496+823+56+1,50)
end)

menu.add_feature("85 %", "action", PERICO_HOST_CUT.id, function()
    script.set_global_i(1973496+823+56+1,85)
end)

menu.add_feature("100 %", "action", PERICO_HOST_CUT.id, function()
        script.set_global_i(1973496+823+56+1,100)
end)

menu.add_feature("125 %", "action", PERICO_HOST_CUT.id, function()
        script.set_global_i(1973496+823+56+1,125)
end)

menu.add_feature("150 %", "action", PERICO_HOST_CUT.id, function()
        script.set_global_i(1973496+823+56+1,150)
end)

-- PLAYER 2 CUT MANAGER

menu.add_feature("Custom Payout", "action", PERICO_P2_CUT.id, function(perico2)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1973496+823+56+2, tonumber(s))
end)

menu.add_feature("0 %", "action", PERICO_P2_CUT.id, function()
        script.set_global_i(1973496+823+56+2,0)
end)

menu.add_feature("50 %", "action", PERICO_P2_CUT.id, function()
    script.set_global_i(1973496+823+56+2,50)
end)

menu.add_feature("85 %", "action", PERICO_P2_CUT.id, function()
    script.set_global_i(1973496+823+56+2,85)
end)

menu.add_feature("100 %", "action", PERICO_P2_CUT.id, function()
        script.set_global_i(1973496+823+56+2,100)
end)

menu.add_feature("125 %", "action", PERICO_P2_CUT.id, function()
        script.set_global_i(1973496+823+56+2,125)
end)

menu.add_feature("150 %", "action", PERICO_P2_CUT.id, function()
        script.set_global_i(1973496+823+56+2,150)
end)

-- PLAYER 3 CUT MANAGER

menu.add_feature("Custom Payout", "action", PERICO_P3_CUT.id, function(perico3)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1973496+823+56+3, tonumber(s))
end)

menu.add_feature("0 %", "action", PERICO_P3_CUT.id, function()
        script.set_global_i(1973496+823+56+3,0)
end)

menu.add_feature("50 %", "action", PERICO_P3_CUT.id, function()
    script.set_global_i(1973496+823+56+3,50)
end)

menu.add_feature("85 %", "action", PERICO_P3_CUT.id, function()
    script.set_global_i(1973496+823+56+3,85)
end)

menu.add_feature("100 %", "action", PERICO_P3_CUT.id, function()
        script.set_global_i(1973496+823+56+3,100)
end)

menu.add_feature("125 %", "action", PERICO_P3_CUT.id, function()
        script.set_global_i(1973496+823+56+3,125)
end)

menu.add_feature("150 %", "action", PERICO_P3_CUT.id, function()
        script.set_global_i(1973496+823+56+3,150)
end)

-- PLAYER 4 CUT MANAGER

menu.add_feature("Custom Payout", "action", PERICO_P4_CUT.id, function(perico4)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1973496+823+56+4, tonumber(s))
end)

menu.add_feature("0 %", "action", PERICO_P4_CUT.id, function()
        script.set_global_i(1973496+823+56+4,0)
end)

menu.add_feature("50 %", "action", PERICO_P4_CUT.id, function()
    script.set_global_i(1973496+823+56+4,50)
end)

menu.add_feature("85 %", "action", PERICO_P4_CUT.id, function()
    script.set_global_i(1973496+823+56+4,85)
end)

menu.add_feature("100 %", "action", PERICO_P4_CUT.id, function()
        script.set_global_i(1973496+823+56+4,100)
end)

menu.add_feature("125 %", "action", PERICO_P4_CUT.id, function()
        script.set_global_i(1973496+823+56+4,125)
end)

menu.add_feature("150 %", "action", PERICO_P4_CUT.id, function()
        script.set_global_i(1973496+823+56+4,150)
end)

menu.add_feature("» Normal Bag Limit", "action", CAYO_BAG.id, function()
    script.set_global_i(262145+29379,1800)
    menu.notify("* Your bag has been modified\n* This feature is not compatible with the Presets\n* Recommended to use with friends/randoms Heists", "Restored Bag", 5, 0x6414F000)
end)

menu.add_feature("» Simulate Bag to 2 players", "action", CAYO_BAG.id, function()
    script.set_global_i(262145+29379,3600)
    menu.notify("* Your bag has been modified\n* This feature is not compatible with the Presets\n* Recommended to use with friends/randoms Heists", "2 Players Capacity", 5, 0x6414F000)
end)

menu.add_feature("» Simulate Bag to 3 players", "action", CAYO_BAG.id, function()
    script.set_global_i(262145+29379,5400)
    menu.notify("* Your bag has been modified\n* This feature is not compatible with the Presets\n* Recommended to use with friends/randoms Heists", "3 Players Capacity", 5, 0x6414F000)
end)

menu.add_feature("» Simulate Bag to 4 players", "action", CAYO_BAG.id, function()
    script.set_global_i(262145+29379,7200)
    menu.notify("* Your bag has been modified\n* This feature is not compatible with the Presets\n* Recommended to use with friends/randoms Heists", "4 Players Capacity", 5, 0x6414F000)
end)

menu.add_feature("» Infinite Bag", "action", CAYO_BAG.id, function()
    script.set_global_i(262145+29379,9999999)
    menu.notify("* Your bag has been modified\n* This feature is not compatible with the Presets\n* Recommended to use with friends/randoms Heists", "Infinite Bag", 5, 0x6414F000)
end)

menu.add_feature("» Remove Drainage Pipe", "action", PERICO_ADV.id, function()
    for k, DOORs in pairs(object.get_all_objects()) do
        local ENT_ENTRY = entity.get_entity_model_hash(DOORs)
        local prop_chem_grill_bit = 2997331308

    if ENT_ENTRY == prop_chem_grill_bit then
          network.request_control_of_entity(DOORs)
          local timer = utils.time_ms() + 500
          while not network.has_control_of_entity(DOORs) and timer > utils.time_ms() do
            system.wait(1500)
          end
          if network.has_control_of_entity(DOORs) then
            --entity.set_entity_as_mission_entity(DOORs, true, true)
            entity.set_entity_as_no_longer_needed(DOORs)
            entity.delete_entity(DOORs)
          end
      end
    end
    menu.notify("Drainage Pipe removed", "", 3, 0x640EF3C2)
end)

-------------------------
do
local CP_VEH_KA = {
    {"H4_MISSIONS", 65283}
}
    menu.add_feature("» Submarine KOSATKA", "action", CAYO_VEHICLES.id, function()
        menu.notify("KOSATKA avaliable", "Heist Control", 3, 0xffef5a09)
        for i = 1, #CP_VEH_KA do
            stat_set_int(CP_VEH_KA[i][1], true, CP_VEH_KA[i][2])
        end
    end)
end

do
local CP_VEH_AT = {
    {"H4_MISSIONS", 65413}
}
    menu.add_feature("» Plane ALKONOST", "action", CAYO_VEHICLES.id, function()
    menu.notify("ALKONOST avaliable", "Heist Control", 3, 0xffef5a09)
        for i = 1, #CP_VEH_AT do
            stat_set_int(CP_VEH_AT[i][1], true, CP_VEH_AT[i][2])
        end
    end)
end

do
local CP_VEH_VM = {
    {"H4_MISSIONS", 65289}
}
    menu.add_feature("» Plane VELUM", "action", CAYO_VEHICLES.id, function()
    menu.notify("VELUM avaliable", "Heist Control", 3, 0xffef5a09)
        for i = 1, #CP_VEH_VM do
            stat_set_int(CP_VEH_VM[i][1], true, CP_VEH_VM[i][2])
        end
    end)
end

do
local CP_VEH_SA = {
    {"H4_MISSIONS", 65425}
}
    menu.add_feature("» Helicopter STEALTH ANNIHILATOR", "action", CAYO_VEHICLES.id, function()
    menu.notify("STEALTH ANNIHILATOR avaliable", "Heist Control", 3, 0xffef5a09)
        for i = 1, #CP_VEH_SA do
            stat_set_int(CP_VEH_SA[i][1], true, CP_VEH_SA[i][2])
        end
    end)
end

do
local CP_VEH_PB = {
    {"H4_MISSIONS", 65313}
}
    menu.add_feature("» Boat PATROL BOAT", "action", CAYO_VEHICLES.id, function()
    menu.notify("PATROL BOAT avaliable", "Heist Control", 3, 0xffef5a09)
        for i = 1, #CP_VEH_PB do
            stat_set_int(CP_VEH_PB[i][1], true, CP_VEH_PB[i][2])
        end
    end)
end

do
local CP_VEH_LN = {
    {"H4_MISSIONS", 65345}
}
    menu.add_feature("» Boat LONGFIN", "action", CAYO_VEHICLES.id, function()
    menu.notify("LONGFIN avaliable", "Heist Control", 3, 0xffef5a09)
        for i = 1, #CP_VEH_LN do
            stat_set_int(CP_VEH_LN[i][1], true, CP_VEH_LN[i][2])
        end
    end)
end

do
local CP_VEH_ALL = {
    {"H4_MISSIONS", -1}
}
    menu.add_feature("» Unlock All Vehicles", "action", CAYO_VEHICLES.id, function()
    menu.notify("All Vehicles are avaliable", "Heist Control", 3, 0xffef5a09)
        for i = 1, #CP_VEH_ALL do
            stat_set_int(CP_VEH_ALL[i][1], true, CP_VEH_ALL[i][2])
        end
    end)
end


do
local Target_SapphirePanther = {
    {"H4CNF_TARGET", 5}
}
    menu.add_feature("» Change to Panther Statue", "action", CAYO_PRIMARY.id, function()
    menu.notify("Primary Target Modified to Panther Statue\n\n- $1.900,000 (Normal)\n- $2.090,000 (Hard)", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Target_SapphirePanther do
            stat_set_int(Target_SapphirePanther[i][1], true, Target_SapphirePanther[i][2])
        end
    end)
end

do
local Target_MadrazoF = {
    {"H4CNF_TARGET", 4}
}
    menu.add_feature("» Change to Madrazo Files", "action", CAYO_PRIMARY.id, function()
    menu.notify("Primary Target Modified to Madrazo Files\n\n- $1.100,000 (Normal)\n- $1.210,000 (Hard)", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Target_MadrazoF do
            stat_set_int(Target_MadrazoF[i][1], true, Target_MadrazoF[i][2])
        end
    end)
end

do
local Target_PinkDiamond = {
    {"H4CNF_TARGET", 3}
}
    menu.add_feature("» Change to Pink Diamond", "action", CAYO_PRIMARY.id, function()
    menu.notify("Primary Target Modified to Pink Diamond\n\n- $1.300,000 (Normal)\n- $1.430,000 (Hard)", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Target_PinkDiamond do
            stat_set_int(Target_PinkDiamond[i][1], true, Target_PinkDiamond[i][2])
        end
    end)
end

do
local Target_BearerBonds = {
    {"H4CNF_TARGET", 2}
}
    menu.add_feature("» Change to Bearer Bonds", "action", CAYO_PRIMARY.id, function()
    menu.notify("Primary Target Modified to Bearer Bonds\n\n- $1.100,000 (Normal)\n- $1.210,000 (Hard)", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Target_BearerBonds do
            stat_set_int(Target_BearerBonds[i][1], true, Target_BearerBonds[i][2])
        end
    end)
end

do
local Target_Ruby = {
    {"H4CNF_TARGET", 1}
}
    menu.add_feature("» Change to Ruby", "action", CAYO_PRIMARY.id, function()
    menu.notify("Primary Target Modified to Ruby\n\n- $1.000,000 (Normal)\n- $1.100,000 (Hard)", "Heist Control", 3, 0xffef5a09)
    for i = 1, #Target_Ruby do
            stat_set_int(Target_Ruby[i][1], true, Target_Ruby[i][2])
        end
    end)
end

do
local Target_Tequila = {
    {"H4CNF_TARGET", 0}
}
    menu.add_feature("» Change to Tequila", "action", CAYO_PRIMARY.id, function()
    menu.notify("Primary Target Modified to Tequila\n\n- $900,000 (Normal)\n- $990,000 (Hard)", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Target_Tequila do
        stat_set_int(Target_Tequila[i][1], true, Target_Tequila[i][2])
        end
    end)
end

do
local SecondaryT_RDM = {
    {"H4LOOT_CASH_I", 1319624},
    {"H4LOOT_CASH_C", 18},
    {"H4LOOT_CASH_V", 89400},
    {"H4LOOT_WEED_I", 2639108},
    {"H4LOOT_WEED_C", 36},
    {"H4LOOT_WEED_V", 149000},
    {"H4LOOT_COKE_I", 4229122},
    {"H4LOOT_COKE_C", 72},
    {"H4LOOT_COKE_V", 221200},
    {"H4LOOT_GOLD_I", 8589313},
    {"H4LOOT_GOLD_C", 129},
    {"H4LOOT_GOLD_V", 322600},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 186800},
    {"H4LOOT_CASH_I_SCOPED", 1319624},
    {"H4LOOT_CASH_C_SCOPED", 18},
    {"H4LOOT_WEED_I_SCOPED", 2639108},
    {"H4LOOT_WEED_C_SCOPED", 36},    
    {"H4LOOT_COKE_I_SCOPED", 4229122},
    {"H4LOOT_COKE_C_SCOPED", 72},
    {"H4LOOT_GOLD_I_SCOPED", 8589313},
    {"H4LOOT_GOLD_C_SCOPED", 129},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to Mixed Loot", "action", CAYO_SECONDARY.id, function()
    menu.notify("Secondary Target are now Mixed\n\nWhen using this method, the percentage and final payment is random!", "Heist Control", 3, 0xffef5a09)
    for i = 1, #SecondaryT_RDM do
        stat_set_int(SecondaryT_RDM[i][1], true, SecondaryT_RDM[i][2])
    end
end)
end

do
local SecondaryT_FCash = {
    {"H4LOOT_CASH_I", -1},
    {"H4LOOT_CASH_C", -1},
    {"H4LOOT_CASH_V", 90000},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_I", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 190000},
    {"H4LOOT_CASH_I_SCOPED", -1},
    {"H4LOOT_CASH_C_SCOPED", -1},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},    
    {"H4LOOT_COKE_I_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to full Cash", "action", CAYO_SECONDARY.id, function()
        menu.notify("Secondary Target are full Cash (only)\n\nWhen using this method, the percentage and final payment is random!", "Heist Control", 3, 0xffef5a09)
    for i = 1, #SecondaryT_FCash do
        stat_set_int(SecondaryT_FCash[i][1], true, SecondaryT_FCash[i][2])
    end
end)
end

do
local SecondaryT_FWeed = {
    {"H4LOOT_CASH_I", 0},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_WEED_I", -1},
    {"H4LOOT_WEED_C", -1},
    {"H4LOOT_WEED_V", 140000},
    {"H4LOOT_COKE_I", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 190000},
    {"H4LOOT_CASH_I_SCOPED", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", -1},
    {"H4LOOT_WEED_C_SCOPED", -1},    
    {"H4LOOT_COKE_I_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to full Weed", "action", CAYO_SECONDARY.id, function()
    menu.notify("Secondary Target are full Weed (only)\n\nWhen using this method, the percentage and final payment is random!", "Heist Control", 3, 0xffef5a09)
    for i = 1, #SecondaryT_FWeed do
        stat_set_int(SecondaryT_FWeed[i][1], true, SecondaryT_FWeed[i][2])
    end
end)
end

do
local SecondaryT_FCoke = {
    {"H4LOOT_CASH_I", 0},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_I", -1},
    {"H4LOOT_COKE_C", -1},
    {"H4LOOT_COKE_V", 210000},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 190000},
    {"H4LOOT_CASH_I_SCOPED", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},    
    {"H4LOOT_COKE_I_SCOPED", -1},
    {"H4LOOT_COKE_C_SCOPED", -1},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to full Coke", "action", CAYO_SECONDARY.id, function()
        menu.notify("Secondary Target are full Coke (only)\n\nWhen using this method, the percentage and final payment is random!", "Heist Control", 3, 0xffef5a09)
    for i = 1, #SecondaryT_FCoke do
        stat_set_int(SecondaryT_FCoke[i][1], true, SecondaryT_FCoke[i][2])
    end
end)
end

do
local SecondaryT_FGold = {
    {"H4LOOT_CASH_I", 0},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_I", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_I", -1},
    {"H4LOOT_GOLD_C", -1},
    {"H4LOOT_GOLD_V", 320000},
    {"H4LOOT_PAINT", -1},
    {"H4LOOT_PAINT_V", 190000},
    {"H4LOOT_CASH_I_SCOPED", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},    
    {"H4LOOT_COKE_I_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", -1},
    {"H4LOOT_GOLD_C_SCOPED", -1},
    {"H4LOOT_PAINT_SCOPED", -1}
}
    menu.add_feature("» Change to full Gold", "action", CAYO_SECONDARY.id, function()
    menu.notify("Secondary Target are full Gold (only)\n\nWhen using this method, the percentage and final payment is random!", "Heist Control", 3, 0xffef5a09)
    for i = 1, #SecondaryT_FGold do
        stat_set_int(SecondaryT_FGold[i][1], true, SecondaryT_FGold[i][2])
    end
end)
end

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
    menu.add_feature("» Remove All", "action", CAYO_SECONDARY.id, function()
        menu.notify("All Secondary targets has been removed", "Heist Control", 3, 0xffef5a09)
        for i = 1, #SecondaryT_Remove do
        stat_set_int(SecondaryT_Remove[i][1], true, SecondaryT_Remove[i][2])
    end
    end)
end

local CAH_2ND_TARGET_MDY = menu.add_feature("» Modify Loot Price", "parent", CAYO_SECONDARY.id, function()
    menu.notify("When using this option, the Heist panel must be updated", "", 4, 0x5014F0FA)
end)

local valueToSet = menu.add_feature("Change Cash Price", "action", CAH_2ND_TARGET_MDY.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_H4LOOT_CASH_V"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Weed Price", "action", CAH_2ND_TARGET_MDY.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_H4LOOT_WEED_V"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Coke Price", "action", CAH_2ND_TARGET_MDY.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_H4LOOT_COKE_V"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Gold Price", "action", CAH_2ND_TARGET_MDY.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_H4LOOT_GOLD_V"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature("Change Paint Price", "action", CAH_2ND_TARGET_MDY.id, function()
    local Choose, ME = input.get("Use only numbers", "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_H4LOOT_PAINT_V"), tonumber(ME),true)
    menu.notify('Value Changed to:\n'  ..ME, "", 4, 0x6414F050)
end)

local CAYO_COMPOUND = menu.add_feature("» Compound Loot", "parent", CAYO_SECONDARY.id)

do
local Compound_LT_MIX = {
    {"H4LOOT_CASH_C", 2},
    {"H4LOOT_CASH_V", 474431},
    {"H4LOOT_WEED_C", 17},
    {"H4LOOT_WEED_V", 759090},
    {"H4LOOT_COKE_C", 132},
    {"H4LOOT_COKE_V", 948863},
    {"H4LOOT_GOLD_C", 104},
    {"H4LOOT_GOLD_V", 1265151},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 948863},
    {"H4LOOT_CASH_C_SCOPED", 2},
    {"H4LOOT_WEED_C_SCOPED", 17},
    {"H4LOOT_COKE_C_SCOPED", 132},
    {"H4LOOT_GOLD_C_SCOPED", 104},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to Mixed Loot", "action", CAYO_COMPOUND.id, function()
    menu.notify("Compound Loot has been modified", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Compound_LT_MIX do
        stat_set_int(Compound_LT_MIX[i][1], true, Compound_LT_MIX[i][2])
        end
    end)
end

do
local Compound_LT_CASH = {
    {"H4LOOT_CASH_C", -1},
    {"H4LOOT_CASH_V", 90000},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 190000},
    {"H4LOOT_CASH_C_SCOPED", -1},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to full Cash", "action", CAYO_COMPOUND.id, function()
    menu.notify("Compound Loot modified to Cash", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Compound_LT_CASH do
        stat_set_int(Compound_LT_CASH[i][1], true, Compound_LT_CASH[i][2])
        end
    end)
end

do
local Compound_LT_WEED = {
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_WEED_C", -1},
    {"H4LOOT_WEED_V", 140000},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 190000},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", -1},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to full Weed", "action", CAYO_COMPOUND.id, function()
    menu.notify("Compound Loot modified to Weed", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Compound_LT_WEED do
        stat_set_int(Compound_LT_WEED[i][1], true, Compound_LT_WEED[i][2])
        end
    end)
end

do
local Compound_LT_COKE = {
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_C", -1},
    {"H4LOOT_COKE_V", 210000},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 190000},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", -1},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to full Coke", "action", CAYO_COMPOUND.id, function()
    menu.notify("Compound Loot modified to Coke", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Compound_LT_COKE do
        stat_set_int(Compound_LT_COKE[i][1], true, Compound_LT_COKE[i][2])
        end
    end)
end

do
local Compound_LT_GOLD = {
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_C", -1},
    {"H4LOOT_GOLD_V", 320000},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 190000},
    {"H4LOOT_GOLD_C_SCOPED", -1},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to full Gold", "action", CAYO_COMPOUND.id, function()
        menu.notify("Compound Loot modified to Gold", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Compound_LT_GOLD do
        stat_set_int(Compound_LT_GOLD[i][1], true, Compound_LT_GOLD[i][2])
    end
    end)
end

do
local Compound_LT_PAINT = {
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_V", 190000},
    {"H4LOOT_PAINT_SCOPED", 127}
}
    menu.add_feature("» Change to full Paint", "action", CAYO_COMPOUND.id, function()
        menu.notify("Compound Loot modified to Paint", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Compound_LT_PAINT do
        stat_set_int(Compound_LT_PAINT[i][1], true, Compound_LT_PAINT[i][2])
    end
    end)
end

do
local Remove_Compound_Paint = {
    {"H4LOOT_PAINT", 0},
    {"H4LOOT_PAINT_V", 0},
    {"H4LOOT_PAINT_SCOPED", 0}
}
    menu.add_feature("» Remove Paint (only)", "action", CAYO_COMPOUND.id, function()
    menu.notify("Paints has been removed", "Heist Control", 3, 0xffef5a09)
    for i = 1, #Remove_Compound_Paint do
    stat_set_int(Remove_Compound_Paint[i][1], true, Remove_Compound_Paint[i][2])
    end
    end)
end

do
local Remove_ALL_Compound_LT = {
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_PAINT", 0},
    {"H4LOOT_PAINT_SCOPED", 0}
}
    menu.add_feature("» Remove all", "action", CAYO_COMPOUND.id, function()
        menu.notify("All Compound loots has been removed", "Heist Control", 3, 0xffef5a09)
        for i = 1, #Remove_ALL_Compound_LT do
        stat_set_int(Remove_ALL_Compound_LT[i][1], true, Remove_ALL_Compound_LT[i][2])
    end
    end)
end

do
local Weapon_Aggressor = {
    {"H4CNF_WEAPONS", 1}
}
    menu.add_feature("» Aggressor", "action", CAYO_WEAPONS.id, function()
    menu.notify("Assault SG + Machine Pistol\nMachete + Grenade", "Aggressor Loadout", 3, 0x64A0CD14)
    for i = 1, #Weapon_Aggressor do
         stat_set_int(Weapon_Aggressor[i][1], true, Weapon_Aggressor[i][2])
        end
    end)
end

do
local Weapon_Conspirator = {
    {"H4CNF_WEAPONS", 2}
}
    menu.add_feature("» Conspirator", "action", CAYO_WEAPONS.id, function()
    menu.notify("Military Rifle + AP\nKnuckles + Stickies", "Conspirator Loadout", 3, 0x64A0CD14)
    for i = 1, #Weapon_Conspirator do
        stat_set_int(Weapon_Conspirator[i][1], true, Weapon_Conspirator[i][2])
        end
    end)
end

do
local Weapon_Crackshot = {
    {"H4CNF_WEAPONS", 3}
}
    menu.add_feature("» Crackshot", "action", CAYO_WEAPONS.id, function()
    menu.notify("Sniper + AP\nKnife + Molotov", "Crackshot Loadout", 3, 0x64A0CD14)
    for i = 1, #Weapon_Crackshot do
        stat_set_int(Weapon_Crackshot[i][1], true, Weapon_Crackshot[i][2])
        end
    end)
end

do
local Weapon_Saboteur = {
    {"H4CNF_WEAPONS", 4}
}
    menu.add_feature("» Saboteur", "action", CAYO_WEAPONS.id, function()
    menu.notify("SMG MK II + SNS Pistol\nKnife + Pipe Bomb", "Saboteur Loadout", 3, 0x64A0CD14)
    for i = 1, #Weapon_Saboteur do
        stat_set_int(Weapon_Saboteur[i][1], true, Weapon_Saboteur[i][2])
        end
    end)
end

do
local Weapon_Marksman = {
    {"H4CNF_WEAPONS", 5}
}
    menu.add_feature("» Marksman", "action", CAYO_WEAPONS.id, function()
    menu.notify("AK-47 + Pistol .50\nMachete + Pipe Bomb", "Marksman Loadout", 3, 0x64A0CD14)
    for i = 1, #Weapon_Marksman do
        stat_set_int(Weapon_Marksman[i][1], true, Weapon_Marksman[i][2])
        end
    end)
end

do
local Supress_Removal = {
    {"H4CNF_BS_GEN", 126975}
}
menu.add_feature("» Remove Suppressor", "action", CAYO_WEAPONS.id, function()
    menu.notify("Please stay away from the Submarine Heist room to update", "Suppressor Removed", 3, 0x64A0CD14)
    for i = 1, #Supress_Removal do
        stat_set_int(Supress_Removal[i][1], true, Supress_Removal[i][2])
        end
    end)
end

do
local CP_Item_SpawnPlace_AIR = {
    {"H4CNF_GRAPPEL", 2022},
    {"H4CNF_UNIFORM", 12},
    {"H4CNF_BOLTCUT", 4161},
    {"H4CNF_TROJAN", 1}
}
    menu.add_feature("» Set Equipments spawn next to Airport", "action", CAYO_EQUIPM.id, function()
    menu.notify("Equipments will spawn next to Airport:\n\n- Grappling Hook\n- Guard Clothing\n- Bolt Cutters", "Heist Control", 3, 0xffef5a09)
    for i = 1, #CP_Item_SpawnPlace_AIR do
        stat_set_int(CP_Item_SpawnPlace_AIR[i][1], true, CP_Item_SpawnPlace_AIR[i][2])
        end
    end)
end

do
local CP_Item_SpawnPlace_DKS = {
    {"H4CNF_GRAPPEL", 3671},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_TROJAN", 2}
}
    menu.add_feature("» Set Equipments spawn next to Docks", "action", CAYO_EQUIPM.id, function()
    menu.notify("Equipments will spawn next to Docks:\n\n- Grappling Hook\n- Guard Clothing\n- Bolt Cutters", "Heist Control", 3, 0xffef5a09)
    for i = 1, #CP_Item_SpawnPlace_DKS do
        stat_set_int(CP_Item_SpawnPlace_DKS[i][1], true, CP_Item_SpawnPlace_DKS[i][2])
        end
    end)
end

do
local CP_Item_SpawnPlace_CP = {
    {"H4CNF_GRAPPEL", 85324},
    {"H4CNF_UNIFORM", 61034},
    {"H4CNF_BOLTCUT", 4612},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature("» Set Equipments spawn next to Compound", "action", CAYO_EQUIPM.id, function()
    menu.notify("Equipments will spawn next to Compound:\n\n- Grappling Hook\n- Guard Clothing\n- Bolt Cutters", "Heist Control", 3, 0xffef5a09)
    for i = 1, #CP_Item_SpawnPlace_CP do
    stat_set_int(CP_Item_SpawnPlace_CP[i][1], true, CP_Item_SpawnPlace_CP[i][2])
    end
end)
end

do
local CP_TRUCK_SPAWN_mov1 = {
    {"H4CNF_TROJAN", 1}
}
    menu.add_feature("» Set Supply Truck spawn to Airport", "action", CAYO_TRUCK.id, function()
    menu.notify("Supply Truck will now spawn next to Airport", "Heist Control", 3, 0xffef5a09)
    for i = 1, #CP_TRUCK_SPAWN_mov1 do
    stat_set_int(CP_TRUCK_SPAWN_mov1[i][1], true, CP_TRUCK_SPAWN_mov1[i][2])
    end
    end)
end

do
local CP_TRUCK_SPAWN_mov2 = {
    {"H4CNF_TROJAN", 2}
}
    menu.add_feature("» Set Supply Truck spawn to North Dock", "action", CAYO_TRUCK.id, function()
    menu.notify("Supply Truck will now spawn next to North Dock", "Heist Control", 3, 0xffef5a09)
    for i = 1, #CP_TRUCK_SPAWN_mov2 do
     stat_set_int(CP_TRUCK_SPAWN_mov2[i][1], true, CP_TRUCK_SPAWN_mov2[i][2])
    end
    end)
end

do
local CP_TRUCK_SPAWN_mov3 = {
    {"H4CNF_TROJAN", 3}
}
    menu.add_feature("» Set Supply Truck spawn to Main Dock (East)", "action", CAYO_TRUCK.id, function()
    menu.notify("Supply Truck will now spawn next to Main Dock - East", "Heist Control", 3, 0xffef5a09)
    for i = 1, #CP_TRUCK_SPAWN_mov3 do
    stat_set_int(CP_TRUCK_SPAWN_mov3[i][1], true, CP_TRUCK_SPAWN_mov3[i][2])
    end
    end)
end

do
local CP_TRUCK_SPAWN_mov4 = {
    {"H4CNF_TROJAN", 4}
}
    menu.add_feature("» Set Supply Truck spawn to Main Dock (West)", "action", CAYO_TRUCK.id, function()
    menu.notify("Supply Truck will now spawn next to Main Dock (West)", "Heist Control", 3, 0xffef5a09)
    for i = 1, #CP_TRUCK_SPAWN_mov4 do
    stat_set_int(CP_TRUCK_SPAWN_mov4[i][1], true, CP_TRUCK_SPAWN_mov4[i][2])
    end
    end)
end

do
local CP_TRUCK_SPAWN_mov5 = {
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature("» Set Supply Truck spawn next to Compound", "action", CAYO_TRUCK.id, function()
    menu.notify("Supply Truck will now spawn next to Compound", "Heist Control", 3, 0xffef5a09)
    for i = 1, #CP_TRUCK_SPAWN_mov5 do
    stat_set_int(CP_TRUCK_SPAWN_mov5[i][1], true, CP_TRUCK_SPAWN_mov5[i][2])
    end
    end)
end

do
local CAYO_NORMAL = {
    {"H4_PROGRESS", 126823}
}
    menu.add_feature("» Change Difficulty to Normal", "action", CAYO_DFFCTY.id, function()
    menu.notify("Difficulty has been changed to Normal", "Difficulty Editor", 3, 0xffef5a09)
        for i = 1, #CAYO_NORMAL do
            stat_set_int(CAYO_NORMAL[i][1], true, CAYO_NORMAL[i][2])
        end
    end)
end

do
local CAYO_Hard = {
    {"H4_PROGRESS", 131055}
}
    menu.add_feature("» Change Difficulty to Hard", "action", CAYO_DFFCTY.id, function()
    menu.notify("Difficulty has been changed to Hard", "Difficulty Editor", 3, 0xffef5a09)
        for i = 1, #CAYO_Hard do
            stat_set_int(CAYO_Hard[i][1], true, CAYO_Hard[i][2])
        end
    end)
end



do
menu.add_feature("» Unlock Cayo Perico Awards", "action", MORE_OPTIONS.id, function()

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
    {"H4_H4_DJ_MISSIONS", -1}
}
    menu.notify("Cayo Perico Awards Unlocked!", "Heist Control", 3, 0xffef5a09)
    for i = 1, #CP_AWRD_IT do
    stat_set_int(CP_AWRD_IT[i][1], true, CP_AWRD_IT[i][2])
    end
    for i = 1, #CP_AWRD_BL do
    stat_set_bool(CP_AWRD_BL[i][1], true, CP_AWRD_BL[i][2])
    end
    for i=0,192,1 do
    hash, mask = stats.stat_get_bool_hash_and_mask("_HISLANDPSTAT_BOOL", i, CharID)
    stats.stat_set_masked_bool(hash, true, mask, 1, true)
    end
end)
end

do

local COMPLETE_CP_MISSIONS = {
    {"PROSTITUTES_FREQUENTE", 100}, -- I know horny boy, this has nothing to do with Cayo, but it is just a protection to avoid bugs
    {"H4_MISSIONS", -1},
    {"H4CNF_APPROACH", -1},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_GEN", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3}
}
    menu.add_feature("» Complete all Missions only", "action", MORE_OPTIONS.id, function()
    menu.notify("All missions are completed!", "Heist Control", 3, 0xffef5a09)
        for i = 1, #COMPLETE_CP_MISSIONS do
        stat_set_int(COMPLETE_CP_MISSIONS[i][1], true, COMPLETE_CP_MISSIONS[i][2])
        end
        end)
end

do
local CP_RST = {
    {"H4_MISSIONS", 0},
    {"H4_PROGRESS", 0},
    {"H4CNF_APPROACH", 0},
    {"H4CNF_BS_ENTR", 0},
    {"H4CNF_BS_GEN", 0},
    {"H4_PLAYTHROUGH_STATUS", 2}
}
menu.add_feature("» Reset Heist to Default", "action", MORE_OPTIONS.id, function()
    menu.notify("Cayo Perico Settings has been reseted", "", 3, 0x64FF78B4)
        for i = 1, #CP_RST do
        stat_set_int(CP_RST[i][1], true, CP_RST[i][2])
    end
    end)
end

do
local CH_RANDOM_PRST = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3OPT_POI", -1},
    {"H3OPT_ACCESSPOINTS", -1},
    {"H3_LAST_APPROACH", 4},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_BITSET1", 0xFFFFFFFF},
    {"H3OPT_BITSET0", 0xFFFFFFFF}
}
local CH_RANDOM_METHOD = {
    {"H3OPT_TARGET", 0,3,0,3},
    {"H3_HARD_APPROACH", 1,3,1,3},
    {"H3OPT_CREWWEAP", 1,5,1,5},
    {"H3OPT_CREWDRIVER", 1,5,1,5},
    {"H3OPT_CREWHACKER", 1,5,1,5},
    {"H3OPT_WEAPS", 0,1,0,1},
    {"H3OPT_VEHS", 0,3,0,3},
    {"H3OPT_MASKS", 1,12,1,12},
    {"H3OPT_APPROACH", 1,3,1,3}
}
menu.add_feature("» Load Random Approach", "action", CASINO_PRESETS.id, function()
    menu.notify("Make sure you have paid the heist on the planning screen before using this option\n\nRandom Preset Loaded!", "Heist Control", 3, 0x6414F0FF)
    for i = 1, #CH_RANDOM_PRST do
        stat_set_int(CH_RANDOM_PRST[i][1], true, CH_RANDOM_PRST[i][2])
        stat_set_int(CH_RANDOM_PRST[i][1], false, CH_RANDOM_PRST[i][2])
    end
    for i = 2, #CH_RANDOM_METHOD do
        stat_set_int(CH_RANDOM_METHOD[i][1], true, math.random(CH_RANDOM_METHOD[i][4], CH_RANDOM_METHOD[i][5]))
    end
end)
end

do
local CAH_SILENT_SNEAKY_PRESET_ID_DMND = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 1},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 3},
    {"H3OPT_POI", 1023},
    {"H3OPT_ACCESSPOINTS", 2047},
    {"H3OPT_CREWWEAP", 4},
    {"H3OPT_CREWDRIVER", 5},
    {"H3OPT_CREWHACKER", 4},
    {"H3OPT_WEAPS", 1},
    {"H3OPT_VEHS", 1},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_MASKS", 2},
    {"H3OPT_BITSET1", 127},
    {"H3OPT_BITSET0", 262270}
}

local SET_NORMAL = {
    {"H3_LAST_APPROACH", 0},
    {"H3_HARD_APPROACH", 0}
}
menu.add_feature("» Silent & Sneaky", "toggle", CAH_DIA_TARGET.id, function(DMND_1)
    menu.notify("Chosen Method: Silent & Sneaky\nTarget: Diamond\nPayout to all members: $3.500,000\n\n\tDon't forget to:\n* Choose the cheapest buyer\n* Use the option to remove the Crew Payout", "", 7, 0x6478283C)
    for i = 1, #CAH_SILENT_SNEAKY_PRESET_ID_DMND do
        stat_set_int(CAH_SILENT_SNEAKY_PRESET_ID_DMND[i][1], true, CAH_SILENT_SNEAKY_PRESET_ID_DMND[i][2])
    end
    while DMND_1.on do
    for i = 1, #SET_NORMAL do
        stat_set_int(SET_NORMAL[i][1], true, SET_NORMAL[i][2])
    end
    script.set_global_i(1966718+2326,42) -- 42% works for Diamond/Gold (host)
    script.set_global_i(1966718+2326+1,102) --  102% the best for Diamond || Gold 121% = 3.5 || Artwork = 132/133/134 (Very buggy) || Cash = 144
    script.set_global_i(1966718+2326+2,102)
    script.set_global_i(1966718+2326+3,102)
    script.set_global_i(262145+28456,1410065408) --Diamond
    --script.set_global_i(262145+28455,1410065408) Gold
    --script.set_global_i(262145+28453,1410065408) Cash
    system.yield(0)
    end
end)
end

do
local CAH_BIGCON_PRESET_ID_DMND = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 2},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 3},
    {"H3OPT_POI", 1023},
    {"H3OPT_ACCESSPOINTS", 2047},
    {"H3OPT_CREWWEAP", 4},
    {"H3OPT_CREWDRIVER", 3},
    {"H3OPT_CREWHACKER", 4},
    {"H3OPT_WEAPS", 0},
    {"H3OPT_VEHS", 3},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_MASKS", 2},
    {"H3OPT_BITSET1", 159},
    {"H3OPT_BITSET0", 524118}
}

local SET_NORMAL = {
    {"H3_LAST_APPROACH", 0},
    {"H3_HARD_APPROACH", 0}
}
    menu.add_feature("» BigCon", "toggle", CAH_DIA_TARGET.id, function(DMND_2)
    menu.notify("Chosen Method: BigCon\nTarget: Diamond\nPayout to all members: $3.500,000\n\n\tDon't forget to:\n* Choose the cheapest buyer\n* Use the option to remove the Crew Payout", "", 7, 0x6478283C)
    for i = 1, #CAH_BIGCON_PRESET_ID_DMND do
        stat_set_int(CAH_BIGCON_PRESET_ID_DMND[i][1], true, CAH_BIGCON_PRESET_ID_DMND[i][2])
    end
    while DMND_2.on do
    for i = 1, #SET_NORMAL do
        stat_set_int(SET_NORMAL[i][1], true, SET_NORMAL[i][2])
    end
    script.set_global_i(1966718+2326,42) -- 42% works for Diamond/Gold (host)
    script.set_global_i(1966718+2326+1,102) --  102% the best for Diamond || Gold 121% = 3.5 || Artwork = 132/133/134 (Very buggy) || Cash = 144
    script.set_global_i(1966718+2326+2,102)
    script.set_global_i(1966718+2326+3,102)
    script.set_global_i(262145+28456,1410065408) --Diamond
    --script.set_global_i(262145+28455,1410065408) Gold
    --script.set_global_i(262145+28453,1410065408) Cash
    system.yield(0)
    end
end)
end

do
local CAH_AGGRESS_PRESET_ID_DMND = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 3},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 3},
    {"H3OPT_POI", 1023},
    {"H3OPT_ACCESSPOINTS", 2047},
    {"H3OPT_CREWWEAP", 4},
    {"H3OPT_CREWDRIVER", 2},
    {"H3OPT_CREWHACKER", 4},
    {"H3OPT_WEAPS", 1},
    {"H3OPT_VEHS", 1},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_MASKS", 2},
    {"H3OPT_BITSET1", 799},
    {"H3OPT_BITSET0", 3670102}
}

local SET_NORMAL = {
    {"H3_LAST_APPROACH", 0},
    {"H3_HARD_APPROACH", 0}
}

    menu.add_feature("» Aggressive", "toggle", CAH_DIA_TARGET.id, function(DMND_3)
    menu.notify("Chosen Method: Aggressive\nTarget: Diamond\nPayout to all members: $3.500,000\n\n\tDon't forget to:\n* Choose the cheapest buyer\n* Use the option to remove the Crew Payout", "", 7, 0x6478283C)
    for i = 1, #CAH_AGGRESS_PRESET_ID_DMND do
        stat_set_int(CAH_AGGRESS_PRESET_ID_DMND[i][1], true, CAH_AGGRESS_PRESET_ID_DMND[i][2])
    end
    while DMND_3.on do
    for i = 1, #SET_NORMAL do
        stat_set_int(SET_NORMAL[i][1], true, SET_NORMAL[i][2])
    end
        script.set_global_i(1966718+2326,42) -- 42% works for Diamond/Gold (host)
        script.set_global_i(1966718+2326+1,102) --  102% the best for Diamond || Gold 121% = 3.5 || Artwork = 132/133/134 (Very buggy) || Cash = 144
        script.set_global_i(1966718+2326+2,102)
        script.set_global_i(1966718+2326+3,102)
        script.set_global_i(262145+28456,1410065408) --Diamond
        --script.set_global_i(262145+28455,1410065408) Gold
        --script.set_global_i(262145+28453,1410065408) Cash
    system.yield(0)
    end
end)
end

do
local CAH_SILENT_GOLD_PRESET = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 1},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 1},
    {"H3OPT_POI", 1023},
    {"H3OPT_ACCESSPOINTS", 2047},
    {"H3OPT_CREWWEAP", 4},
    {"H3OPT_CREWDRIVER", 3},
    {"H3OPT_CREWHACKER", 4},
    {"H3OPT_WEAPS", 1},
    {"H3OPT_VEHS", 2},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_MASKS", 2},
    {"H3OPT_BITSET1", 127},
    {"H3OPT_BITSET0", 262270}
}

local SET_NORMAL = {
    {"H3_LAST_APPROACH", 0},
    {"H3_HARD_APPROACH", 0}
}

menu.add_feature("» Silent & Sneaky", "toggle", CAH_GOLD_TARGET.id, function(GOLD_1)
    menu.notify("Chosen Method: Silent & Sneaky\nTarget: Gold\nPayout to all members: $3.500,000\n\n\tDon't forget to:\n* Choose the cheapest buyer\n* Use the option to remove the Crew Payout", "", 7, 0x6478283C)
    for i = 1, #CAH_SILENT_GOLD_PRESET do
        stat_set_int(CAH_SILENT_GOLD_PRESET[i][1], true, CAH_SILENT_GOLD_PRESET[i][2])
    end
    while GOLD_1.on do
    for i = 1, #SET_NORMAL do
        stat_set_int(SET_NORMAL[i][1], true, SET_NORMAL[i][2])
    end
        script.set_global_i(1966718+2326,42) -- 42% works for Diamond/Gold (host)
        script.set_global_i(1966718+2326+1,121) --  102% the best for Diamond || Gold 121% = 3.5 || Artwork = 132/133/134 (Very buggy) || Cash = 144
        script.set_global_i(1966718+2326+2,121)
        script.set_global_i(1966718+2326+3,121)
        --script.set_global_i(262145+28456,1410065408) --Diamond
        script.set_global_i(262145+28455,1410065408) --Gold
        --script.set_global_i(262145+28453,1410065408) --Cash
    system.yield(0)
    end
    end)
end

do
local CAH_BIGCON_GOLD_PRESET = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 2},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 1},
    {"H3OPT_POI", 1023},
    {"H3OPT_ACCESSPOINTS", 2047},
    {"H3OPT_CREWWEAP", 4},
    {"H3OPT_CREWDRIVER", 2},
    {"H3OPT_CREWHACKER", 4},
    {"H3OPT_WEAPS", 3},
    {"H3OPT_VEHS", 3},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_MASKS", 2},
    {"H3OPT_BITSET1", 159},
    {"H3OPT_BITSET0", 524118}
}

local SET_NORMAL = {
    {"H3_LAST_APPROACH", 0},
    {"H3_HARD_APPROACH", 0}
}

menu.add_feature("» BigCon", "toggle", CAH_GOLD_TARGET.id, function(GOLD_2)
    menu.notify("Chosen Method: BigCon\nTarget: Gold\nPayout to all members: $3.500,000\n\n\tDon't forget to:\n* Choose the cheapest buyer\n* Use the option to remove the Crew Payout", "", 7, 0x6478283C)
    for i = 1, #CAH_BIGCON_GOLD_PRESET do
        stat_set_int(CAH_BIGCON_GOLD_PRESET[i][1], true, CAH_BIGCON_GOLD_PRESET[i][2])
    end
    while GOLD_2.on do
    for i = 1, #SET_NORMAL do
        stat_set_int(SET_NORMAL[i][1], true, SET_NORMAL[i][2])
    end
    script.set_global_i(1966718+2326,42) -- 42% works for Diamond/Gold (host)
    script.set_global_i(1966718+2326+1,121) --  102% the best for Diamond || Gold 121% = 3.5 || Artwork = 132/133/134 (Very buggy) || Cash = 144
    script.set_global_i(1966718+2326+2,121)
    script.set_global_i(1966718+2326+3,121)
    --script.set_global_i(262145+28456,1410065408) --Diamond
    script.set_global_i(262145+28455,1410065408) --Gold
    --script.set_global_i(262145+28453,1410065408) --Cash
system.yield(0)
    end
end)
end

do
local CAH_AGGRESSIV_GOLD_PRESET = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 3},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 1},
    {"H3OPT_POI", 1023},
    {"H3OPT_ACCESSPOINTS", 2047},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_CREWDRIVER", 2},
    {"H3OPT_VEHS", 3},
    {"H3OPT_CREWHACKER", 4},
    {"H3OPT_CREWWEAP", 2},
    {"H3OPT_WEAPS", 0},
    {"H3OPT_MASKS", 2},
    {"H3OPT_BITSET1", 799},
    {"H3OPT_BITSET0", 3670102}
}

local SET_NORMAL = {
    {"H3_LAST_APPROACH", 0},
    {"H3_HARD_APPROACH", 0}
}

menu.add_feature("» Aggressive", "toggle", CAH_GOLD_TARGET.id, function(GOLD_3)
    menu.notify("Chosen Method: Aggressive\nTarget: Gold\nPayout to all members: $3.500,000\n\n\tDon't forget to:\n* Choose the cheapest buyer\n* Use the option to remove the Crew Payout", "", 7, 0x6478283C)
    for i = 1, #CAH_AGGRESSIV_GOLD_PRESET do
        stat_set_int(CAH_AGGRESSIV_GOLD_PRESET[i][1], true, CAH_AGGRESSIV_GOLD_PRESET[i][2])
    end

    while GOLD_3.on do
    for i = 1, #SET_NORMAL do
        stat_set_int(SET_NORMAL[i][1], true, SET_NORMAL[i][2])
    end
    script.set_global_i(1966718+2326,42) -- 42% works for Diamond/Gold (host)
    script.set_global_i(1966718+2326+1,121) --  102% the best for Diamond || Gold 121% = 3.5 || Artwork = 132/133/134 (Very buggy) || Cash = 144
    script.set_global_i(1966718+2326+2,121)
    script.set_global_i(1966718+2326+3,121)
    --script.set_global_i(262145+28456,1410065408) --Diamond
    script.set_global_i(262145+28455,1410065408) --Gold
    --script.set_global_i(262145+28453,1410065408) --Cash
system.yield(0)
    end
    end)
end

do
local CAH_SILENT_CASH_PRESET = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 1},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 0},
    {"H3OPT_POI", 1023},
    {"H3OPT_ACCESSPOINTS", 2047},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_CREWDRIVER", 4},
    {"H3OPT_CREWHACKER", 4},
    {"H3OPT_CREWWEAP", 2},
    {"H3OPT_VEHS", 3},
    {"H3OPT_WEAPS", 0},
    {"H3OPT_MASKS", 2},
    {"H3OPT_BITSET1", 127},
    {"H3OPT_BITSET0", 262270}
}

local SET_NORMAL = {
    {"H3_LAST_APPROACH", 0},
    {"H3_HARD_APPROACH", 0}
}

menu.add_feature("» Silent & Sneaky", "toggle", CAH_CASH_TARGET.id, function(CASH_1)
    menu.notify("Chosen Method: Silent & Sneaky\nTarget: Cash\nPayout to all members: $3.500,000\n\n\tDon't forget to:\n* Choose the cheapest buyer\n* Use the option to remove the Crew Payout", "", 7, 0x6478283C)
    for i = 1, #CAH_SILENT_CASH_PRESET do
        stat_set_int(CAH_SILENT_CASH_PRESET[i][1], true, CAH_SILENT_CASH_PRESET[i][2])
    end

    while CASH_1.on do
    for i = 1, #SET_NORMAL do
        stat_set_int(SET_NORMAL[i][1], true, SET_NORMAL[i][2])
    end

    script.set_global_i(1966718+2326,42) -- 42% works for Diamond/Gold (host)
    script.set_global_i(1966718+2326+1,144) --  102% the best for Diamond || Gold 121% = 3.5 || Artwork = 132/133/134 (Very buggy) || Cash = 144
    script.set_global_i(1966718+2326+2,144)
    script.set_global_i(1966718+2326+3,144)
    --script.set_global_i(262145+28456,1410065408) --Diamond
    --script.set_global_i(262145+28455,1410065408) --Gold
    script.set_global_i(262145+28453,1410065408) --Cash
system.yield(0)
end
end)
end


do
local CAH_BIGCON_CASH_PRESET = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 2},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 0},
    {"H3OPT_POI", 1023},
    {"H3OPT_ACCESSPOINTS", 2047},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_CREWDRIVER", 1},
    {"H3OPT_CREWHACKER", 4},
    {"H3OPT_CREWWEAP", 4},
    {"H3OPT_VEHS", 3},
    {"H3OPT_WEAPS", 0},
    {"H3OPT_MASKS", 2},
    {"H3OPT_BITSET1", 159},
    {"H3OPT_BITSET0", 524118}
}

local SET_NORMAL = {
    {"H3_LAST_APPROACH", 0},
    {"H3_HARD_APPROACH", 0}
}

menu.add_feature("» BigCon", "toggle", CAH_CASH_TARGET.id, function(CASH_2)
    menu.notify("Chosen Method: BigCon\nTarget: Cash\nPayout to all members: $3.500,000\n\n\tDon't forget to:\n* Choose the cheapest buyer\n* Use the option to remove the Crew Payout", "", 7, 0x6478283C)
    for i = 1, #CAH_BIGCON_CASH_PRESET do
        stat_set_int(CAH_BIGCON_CASH_PRESET[i][1], true, CAH_BIGCON_CASH_PRESET[i][2])
    end
    while CASH_2.on do

    for i = 1, #SET_NORMAL do
        stat_set_int(SET_NORMAL[i][1], true, SET_NORMAL[i][2])
    end
    script.set_global_i(1966718+2326,42) -- 42% works for Diamond/Gold (host)
    script.set_global_i(1966718+2326+1,144) --  102% the best for Diamond || Gold 121% = 3.5 || Artwork = 132/133/134 (Very buggy) || Cash = 144
    script.set_global_i(1966718+2326+2,144)
    script.set_global_i(1966718+2326+3,144)
    --script.set_global_i(262145+28456,1410065408) --Diamond
    --script.set_global_i(262145+28455,1410065408) --Gold
    script.set_global_i(262145+28453,1410065408) --Cash
system.yield(0)
    end
end)
end

do
local CAH_AGGRESSIV_CASH_PRESET = {
    {"H3OPT_MODVEH", -1},
    {"H3_COMPLETEDPOSIX", -1},
    {"CAS_HEIST_FLOW", -1},
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 3},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 0},
    {"H3OPT_POI", 1023},
    {"H3OPT_ACCESSPOINTS", 2047},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", -1},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_CREWDRIVER", 2},
    {"H3OPT_VEHS", 3},
    {"H3OPT_CREWHACKER", 4},
    {"H3OPT_CREWWEAP", 5},
    {"H3OPT_WEAPS", 1},
    {"H3OPT_MASKS", 2},
    {"H3OPT_BITSET1", 799},
    {"H3OPT_BITSET0", 3670102}
}

local SET_NORMAL = {
    {"H3_LAST_APPROACH", 0},
    {"H3_HARD_APPROACH", 0}
}

menu.add_feature("» Aggressive", "toggle", CAH_CASH_TARGET.id, function(GOLD_3)
    menu.notify("Chosen Method: Aggressive\nTarget: Cash\nPayout to all members: $3.500,000\n\n\tDon't forget to:\n* Choose the cheapest buyer\n* Use the option to remove the Crew Payout", "", 7, 0x6478283C)
    for i = 1, #CAH_AGGRESSIV_CASH_PRESET do
        stat_set_int(CAH_AGGRESSIV_CASH_PRESET[i][1], true, CAH_AGGRESSIV_CASH_PRESET[i][2])
    end

    while GOLD_3.on do
    for i = 1, #SET_NORMAL do
        stat_set_int(SET_NORMAL[i][1], true, SET_NORMAL[i][2])
    end

    script.set_global_i(1966718+2326,42) -- 42% works for Diamond/Gold (host)
    script.set_global_i(1966718+2326+1,144) --  102% the best for Diamond || Gold 121% = 3.5 || Artwork = 132/133/134 (Very buggy) || Cash = 144
    script.set_global_i(1966718+2326+2,144)
    script.set_global_i(1966718+2326+3,144)
    --script.set_global_i(262145+28456,1410065408) --Diamond
    --script.set_global_i(262145+28455,1410065408) --Gold
    script.set_global_i(262145+28453,1410065408) --Cash
system.yield(0)
    end
end)
end

do
local CH_UNLCK_PT = {
    {"H3OPT_POI", -1},
    {"H3OPT_ACCESSPOINTS", -1}
}
    menu.add_feature("» Unlock all Points of Interests & Access Points", "action", CASINO_BOARD1.id, function()
    menu.notify("Unlocked Successfully", "Heist Control", 3, 0x64FF7800)
        for i = 1, #CH_UNLCK_PT do
        stat_set_int(CH_UNLCK_PT[i][1], true, CH_UNLCK_PT[i][2])
        end
    end)
end

do
local CH_Target_Diamond = {
    {"H3OPT_TARGET", 3}
}
    menu.add_feature("» Diamond", "action", CASINO_TARGET.id, function()
    menu.notify("Target changed to Diamond", "Target Editor", 3, 0x64F0AA14)
        for i = 1, #CH_Target_Diamond do
            stat_set_int(CH_Target_Diamond[i][1], true, CH_Target_Diamond[i][2])
        end
    end)
end

do
local CH_Target_Gold = {
    {"H3OPT_TARGET", 1}
}
    menu.add_feature("» Gold", "action", CASINO_TARGET.id, function()
    menu.notify("Target changed to Gold", "Target Editor", 3, 0x64F0AA14)
        for i = 1, #CH_Target_Gold do
            stat_set_int(CH_Target_Gold[i][1], true, CH_Target_Gold[i][2])
        end
    end)
end

do
local CH_Target_Artwork = {
    {"H3OPT_TARGET", 2}
}
    menu.add_feature("» Artwork", "action", CASINO_TARGET.id, function()
    menu.notify("Target changed to Artwork", "Target Editor", 3, 0x64F0AA14)
        for i = 1, #CH_Target_Artwork do
            stat_set_int(CH_Target_Artwork[i][1], true, CH_Target_Artwork[i][2])
        end
    end)
end

do
local CH_Target_Cash = {
    {"H3OPT_TARGET", 0}
}
    menu.add_feature("» Cash", "action", CASINO_TARGET.id, function()
    menu.notify("Target changed to Cash", "Target Editor", 3, 0x64F0AA14)
        for i = 1, #CH_Target_Cash do
            stat_set_int(CH_Target_Cash[i][1], true, CH_Target_Cash[i][2])
        end
    end)
end
---- CASINO ADVANCED

local CAH_PLAYER_CUT = menu.add_feature("» Players Payments", "parent", CAH_ADVCED.id, function()
    menu.notify("* High percentages affect the payment negatively", "", 5, 0x6414F0FF)
end)

do
local CAH_NON_HOSTCUT = menu.add_feature("» Your Payment as Non-Host", "parent", CAH_PLAYER_CUT.id)

menu.add_feature("Custom Payout", "action", CAH_NON_HOSTCUT.id, function(cahnon)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(2715542 + 6546, tonumber(s))
end)

menu.add_feature("0 %", "toggle", CAH_NON_HOSTCUT.id, function(non1)
    while non1.on do
    script.set_global_i(2715542 + 6546, 0)
    if not non1.on then return end
    system.wait(0)
    end
end)
    
menu.add_feature("50 %", "toggle", CAH_NON_HOSTCUT.id, function(non2)
    while non2.on do
    script.set_global_i(2715542 + 6546, 50)
    if not non2.on then return end
    system.wait(0)
    end
end)

menu.add_feature("85 %", "toggle", CAH_NON_HOSTCUT.id, function(non2)
    while non2.on do
    script.set_global_i(2715542 + 6546, 85)
    if not non2.on then return end
    system.wait(0)
    end
end)
    
menu.add_feature("100 %", "toggle", CAH_NON_HOSTCUT.id, function(non3)
    while non3.on do
    script.set_global_i(2715542 + 6546, 100)
    if not non3.on then return end
    system.wait(0)
    end
end)
    
menu.add_feature("125 %", "toggle", CAH_NON_HOSTCUT.id, function(non4)
    while non4.on do
    script.set_global_i(2715542 + 6546, 125)
    if not non4.on then return end
    system.wait(0)
    end
end)
    
menu.add_feature("150 %", "toggle", CAH_NON_HOSTCUT.id, function(non5)
    while non5.on do
    script.set_global_i(2715542 + 6546, 150)
    if not non5.on then return end
    system.wait(0)
    end
end)

menu.add_feature("200 %", "toggle", CAH_NON_HOSTCUT.id, function(non6)
    while non6.on do
    script.set_global_i(2715542 + 6546, 200)
    if not non6.on then return end
    system.wait(0)
    end
end)
end

do
local CAH_PLAYER_HOST = menu.add_feature("» Your Payment as Host", "parent", CAH_PLAYER_CUT.id)

menu.add_feature("Custom Payout", "action", CAH_PLAYER_HOST.id, function(cahhost)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1966718 + 2326, tonumber(s))
end)

menu.add_feature("0 %", "toggle", CAH_PLAYER_HOST.id, function(cahhost)
    while cahhost.on do
    script.set_global_i(1966718 + 2326, 0)
    if not cahhost.on then return end
    system.wait(0)
end
end)

menu.add_feature("35 %", "action", CAH_PLAYER_HOST.id, function()
    script.set_global_i(1966718 + 2326, 35)
end)

menu.add_feature("50 %", "action", CAH_PLAYER_HOST.id, function()
    script.set_global_i(1966718 + 2326, 50)
end)

menu.add_feature("85 %", "action", CAH_PLAYER_HOST.id, function()
    script.set_global_i(1966718 + 2326, 85)
end)

menu.add_feature("100 %", "action", CAH_PLAYER_HOST.id, function()
     script.set_global_i(1966718 + 2326, 100)
end)

menu.add_feature("125 %", "action", CAH_PLAYER_HOST.id, function()
    script.set_global_i(1966718 + 2326, 125)
end)

menu.add_feature("150 %", "action", CAH_PLAYER_HOST.id, function()
    script.set_global_i(1966718 + 2326, 150)
end)

local CAH_PLAYER_TWO = menu.add_feature("» Player 2 Payment", "parent", CAH_PLAYER_CUT.id)

menu.add_feature("Custom Payout", "action", CAH_PLAYER_TWO.id, function(cah2)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1966718 + 2326+1, tonumber(s))
end)

menu.add_feature("0 %", "action", CAH_PLAYER_TWO.id, function()
    script.set_global_i(1966718 + 2326 +1, 0)
end)

menu.add_feature("50 %", "action", CAH_PLAYER_TWO.id, function()
    script.set_global_i(1966718 + 2326 +1, 50)
end)

menu.add_feature("85 %", "action", CAH_PLAYER_TWO.id, function()
    script.set_global_i(1966718 + 2326 +1, 85)
end)

menu.add_feature("100 %", "action", CAH_PLAYER_TWO.id, function()
    script.set_global_i(1966718 + 2326 +1, 100)
end)

menu.add_feature("125 %", "action", CAH_PLAYER_TWO.id, function()
    script.set_global_i(1966718 + 2326 +1, 125)
end)

menu.add_feature("150 %", "action", CAH_PLAYER_TWO.id, function()
    script.set_global_i(1966718 + 2326 +1, 150)
end)

local CAH_PLAYER_THREE = menu.add_feature("» Player 3 Payment", "parent", CAH_PLAYER_CUT.id)

menu.add_feature("Custom Payout", "action", CAH_PLAYER_THREE.id, function(cah3)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1966718 + 2326+2, tonumber(s))
end)

menu.add_feature("0 %", "action", CAH_PLAYER_THREE.id, function()
    script.set_global_i(1966718 + 2326 +2, 0)
end)

menu.add_feature("50 %", "action", CAH_PLAYER_THREE.id, function()
    script.set_global_i(1966718 + 2326 +2, 50)
end)

menu.add_feature("85 %", "action", CAH_PLAYER_THREE.id, function()
    script.set_global_i(1966718 + 2326 +2, 85)
end)

menu.add_feature("100 %", "action", CAH_PLAYER_THREE.id, function()
    script.set_global_i(1966718 + 2326 +2, 100)
end)

menu.add_feature("125 %", "action", CAH_PLAYER_THREE.id, function()
    script.set_global_i(1966718 + 2326 +2, 125)
end)

menu.add_feature("150 %", "action", CAH_PLAYER_THREE.id, function(g)
    script.set_global_i(1966718 + 2326 +2, 150)
end)

local CAH_PLAYER_FOUR = menu.add_feature("» Player 4 Payment", "parent", CAH_PLAYER_CUT.id)

menu.add_feature("Custom Payout", "action", CAH_PLAYER_FOUR.id, function(cah4)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1966718 + 2326+3, tonumber(s))
end)

menu.add_feature("0 %", "action", CAH_PLAYER_FOUR.id, function()
    script.set_global_i(1966718 + 2326 +3, 0)
end)

menu.add_feature("50 %", "action", CAH_PLAYER_FOUR.id, function()
    script.set_global_i(1966718 + 2326 +3, 50)
end)

menu.add_feature("85 %", "action", CAH_PLAYER_FOUR.id, function()
    script.set_global_i(1966718 + 2326 +3, 85)
end)

menu.add_feature("100 %", "action", CAH_PLAYER_FOUR.id, function()
    script.set_global_i(1966718 + 2326 +3, 100)
end)

 menu.add_feature("125 %", "action", CAH_PLAYER_FOUR.id, function()
    script.set_global_i(1966718 + 2326 +3, 125)
 end)

 menu.add_feature("150 %", "action", CAH_PLAYER_FOUR.id, function()
    script.set_global_i(1966718 + 2326 +3, 150)
 end)
end

do
local CH_REM_CREW = {
    {"H3OPT_CREWWEAP", 6},
    {"H3OPT_CREWDRIVER", 6},
    {"H3OPT_CREWHACKER", 6}
}
menu.add_feature("» Remove NPC Crew Payout (Mantrap Method)", "action", CAH_ADVCED.id, function()
    menu.notify("* Only use this option after stealing the target\n* Crew payout ignored", "", 5, 0x501478DC)
    for i = 1, #CH_REM_CREW do
    stat_set_int(CH_REM_CREW[i][1], true, CH_REM_CREW[i][2])
    end
end)
end
--- CASINO DIFFICULTY
do
local CH_Diff_Hard1 = {
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 1},
    {"H3_HARD_APPROACH", 1}
}
    menu.add_feature("» Silent & Sneaky : Hard", "action", BOARD1_APPROACH.id, function()
    menu.notify("Approach changed to Silent and Sneaky (Hard)", "Heist Control", 3, 0x64FF7800)
        for i = 1, #CH_Diff_Hard1 do
        stat_set_int(CH_Diff_Hard1[i][1], true, CH_Diff_Hard1[i][2])
    end
end)
end

do
local CH_Diff_Normal1 = {
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 1},
    {"H3_HARD_APPROACH", 0}
}
    menu.add_feature("» Silent & Sneaky : Normal", "action", BOARD1_APPROACH.id, function()
    menu.notify("Approach changed to Silent and Sneaky (Normal)", "Heist Control", 3, 0x64FF7800)
        for i = 1, #CH_Diff_Normal1 do
        stat_set_int(CH_Diff_Normal1[i][1], true, CH_Diff_Normal1[i][2])
        end
    end)
end


do
local CH_Diff_Hard2 = {
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 2},
    {"H3_HARD_APPROACH", 2}
}
    menu.add_feature("» The Big Con : Hard", "action", BOARD1_APPROACH.id, function()
    menu.notify("Approach changed to BigCon (Hard)", "Heist Control", 3, 0x64FF7800)
        for i = 1, #CH_Diff_Hard2 do
        stat_set_int(CH_Diff_Hard2[i][1], true, CH_Diff_Hard2[i][2])
        end
     end)
end

do
local CH_Diff_Normal2 = {
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 2},
    {"H3_HARD_APPROACH", 0}
}
    menu.add_feature("» The Big Con : Normal", "action", BOARD1_APPROACH.id, function()
    menu.notify("Approach changed to BigCon (Normal)", "Heist Control", 3, 0x64FF7800)
        for i = 1, #CH_Diff_Normal2 do
        stat_set_int(CH_Diff_Normal2[i][1], true, CH_Diff_Normal2[i][2])
    end
end)
end

do
local CH_Diff_Hard3 = {
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 3},
    {"H3_HARD_APPROACH", 0}
}
    menu.add_feature("» Aggressive : Hard", "action", BOARD1_APPROACH.id, function()
    menu.notify("Approach changed to Aggressive (Hard)", "Heist Control", 3, 0x64FF7800)
            for i = 1, #CH_Diff_Hard3 do
            stat_set_int(CH_Diff_Hard3[i][1], true, CH_Diff_Hard3[i][2])
        end
    end)
end

do
local CH_Diff_Normal3 = {
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 3},
    {"H3_HARD_APPROACH", 0}
}
    menu.add_feature("» Aggressive : Normal", "action", BOARD1_APPROACH.id, function()
    menu.notify("Approach changed to Aggressive (Normal)", "Heist Control", 3, 0x64FF7800)
         for i = 1, #CH_Diff_Normal3 do
         stat_set_int(CH_Diff_Normal3[i][1], true, CH_Diff_Normal3[i][2])
        end
    end)
end

local CASINO_GUNMAN = menu.add_feature("» Change Gunman", "parent", CASINO_BOARD2.id)
do
local CH_GUNMAN_05 = {
    {"H3OPT_CREWWEAP", 4}
}
    menu.add_feature("» Chester McCoy (10%)", "action", CASINO_GUNMAN.id, function()
    menu.notify("Chester McCoy now as Gunman\nCut 10%", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_GUNMAN_05 do
        stat_set_int(CH_GUNMAN_05[i][1], true, CH_GUNMAN_05[i][2])
        end
    end)
end

do
local CH_GUNMAN_04 = {
    {"H3OPT_CREWWEAP", 2}
}
    menu.add_feature("» Gustavo Mota (9%)", "action", CASINO_GUNMAN.id, function()
    menu.notify("Gustavo Mota now as Gunman\nCut 9%", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_GUNMAN_04 do
        stat_set_int(CH_GUNMAN_04[i][1], true, CH_GUNMAN_04[i][2])
        end
end)
end

do
local CH_GUNMAN_03 = {
    {"H3OPT_CREWWEAP", 5}
}
    menu.add_feature("» Patrick McReary (8%)", "action", CASINO_GUNMAN.id, function()
    menu.notify("Patrick McReary now as Gunman\nCut 8%", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_GUNMAN_03 do
        stat_set_int(CH_GUNMAN_03[i][1], true, CH_GUNMAN_03[i][2])
        end
    end)
end

do
local CH_GUNMAN_02 = {
    {"H3OPT_CREWWEAP", 3}
}
    menu.add_feature("» Charlie Reed (7%)", "action", CASINO_GUNMAN.id, function()
    menu.notify("Charlie Reed now as Gunman\nCut 7%", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_GUNMAN_02 do
        stat_set_int(CH_GUNMAN_02[i][1], true, CH_GUNMAN_02[i][2])
        end
    end)
end

do
local CH_GUNMAN_01 = {
     {"H3OPT_CREWWEAP", 1}
}
    menu.add_feature("» Karl Abolaji (5%)", "action", CASINO_GUNMAN.id, function()
    menu.notify("Karl Abolaji now as Gunman\nCut 5%", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_GUNMAN_01 do
        stat_set_int(CH_GUNMAN_01[i][1], true, CH_GUNMAN_01[i][2])
        end
    end)
end


do
local CH_GUNMAN_RND = {
    {"H3OPT_CREWWEAP", 1, 5, 1 ,5}
}
    menu.add_feature("» Random Gunman Member (??%)", "action", CASINO_GUNMAN.id, function()
    menu.notify("Gunman Randomized\nCut ??", "RHeist Control", 3, 0x64F0AA14)
        for i = 1, #CH_GUNMAN_RND do
        stat_set_int(CH_GUNMAN_RND[i][1], true, math.random(CH_GUNMAN_RND[i][4], CH_GUNMAN_RND[i][5]))
         end
    end)
end

do
local CH_GUNMAN_00 = {
    {"H3OPT_CREWWEAP", 6}
}
menu.add_feature("» Remove Gunman Member (0% Payout)", "action", CASINO_GUNMAN.id, function()
    menu.notify("Gunman Member Removed", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_GUNMAN_00 do
        stat_set_int(CH_GUNMAN_00[i][1], true, CH_GUNMAN_00[i][2])
        end
    end)
end

local CASINO_GUNMAN_var = menu.add_feature("» Weapon Variation", "parent", CASINO_GUNMAN.id)

do
local CH_Gunman_var_01 = {
    {"H3OPT_WEAPS", 1}
}
    menu.add_feature("» Best Variation", "action", CASINO_GUNMAN_var.id, function()
    menu.notify("Variation Changed to the Best", "Heist Control", 3, 0x64F0AA14)
    for i = 1, #CH_Gunman_var_01 do
    stat_set_int(CH_Gunman_var_01[i][1], true, CH_Gunman_var_01[i][2])
    end
end)
end

do
local CH_Gunman_var_00 = {
    {"H3OPT_WEAPS", 0}
}
    menu.add_feature("» Worst Variation", "action", CASINO_GUNMAN_var.id, function()
    menu.notify("Variation Changed to the Worst", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_Gunman_var_00 do
        stat_set_int(CH_Gunman_var_00[i][1], true, CH_Gunman_var_00[i][2])
        end
    end)
end

local CASINO_DRIVER_TEAM = menu.add_feature("» Change Driver", "parent", CASINO_BOARD2.id)

do
local CH_DRV_MAN_05 = {
    {"H3OPT_CREWDRIVER", 5}
}
    menu.add_feature("» Chester McCoy (10%)", "action", CASINO_DRIVER_TEAM.id, function()
    menu.notify("Vehicle Variation Best\nVehicle: Everon 4 Seats\n\nVehicle Variation Good\nVehicle: Outlaw 2 Seats\n\nVehicle Variation Fine\nVehicle: Vagrant 2 Seats\n\nVehicle Variation Worst\nVehicle: Zhaba 4 Seats", "Chester McCoy Cut 10%", 5, 0x64F0AA14)
        for i = 1, #CH_DRV_MAN_05 do
        stat_set_int(CH_DRV_MAN_05[i][1], true, CH_DRV_MAN_05[i][2])
        end
    end)
end

do
local CH_DRV_MAN_04 = {
    {"H3OPT_CREWDRIVER", 3}
}
    menu.add_feature("» Eddie Toh (9%)", "action", CASINO_DRIVER_TEAM.id, function()
    menu.notify("Vehicle Variation Best\nVehicle: Komoda 4 Seats\n\nVehicle Variation Good\nVehicle: Ellie 2 Seats\n\nVehicle Variation Fine\nVehicle: Gauntlet Classic 2 Seats\n\nVehicle Variation Worst\nVehicle: Sultan Classic 4 Seats", "Eddie Toh Cut 9%", 5, 0x64F0AA14)
        for i = 1, #CH_DRV_MAN_04 do
        stat_set_int(CH_DRV_MAN_04[i][1], true, CH_DRV_MAN_04[i][2])
        end
    end)
end

do
local CH_DRV_MAN_03 = {
    {"H3OPT_CREWDRIVER", 2}
}
    menu.add_feature("» Taliana Martinez (7%)", "action", CASINO_DRIVER_TEAM.id, function()
    menu.notify("Vehicle Variation Best\nVehicle: Jugular 4 Seats\n\nVehicle Variation Good\nVehicle: Sugoi 4 Seats\n\nVehicle Variation: Fine\nVehicle Drift Yosemite 2 Seats\n\nVehicle Variation Worst\nVehicle: Retinue Mk II 2 Seats", "Taliana Martinez Cut 7%", 5, 0x64F0AA14)
        for i = 1, #CH_DRV_MAN_03 do
        stat_set_int(CH_DRV_MAN_03[i][1], true, CH_DRV_MAN_03[i][2])
        end
    end)
end

do
local CH_DRV_MAN_02 = {
    {"H3OPT_CREWDRIVER", 4}
}
    menu.add_feature("» Zach Nelson (6%)", "action", CASINO_DRIVER_TEAM.id, function()
    menu.notify("Vehicle Variation Best\nVehicle: Lectro 2 Seats\n\nVehicle Variation Good\nVehicle: Defiler 1 Seat\n\nVehicle Variation Fine\nVehicle: Stryder 1 Seat\n\nVehicle Variation Worst\nVehicle: Manchez 2 Seats", "Zach Nelson Cut 6%", 5, 0x64F0AA14)
        for i = 1, #CH_DRV_MAN_02 do
        stat_set_int(CH_DRV_MAN_02[i][1], true, CH_DRV_MAN_02[i][2])
        end
end)
end

do
local CH_DRV_MAN_01 = {
    {"H3OPT_CREWDRIVER", 1}
}
    menu.add_feature("» Karim Denz (5%)", "action", CASINO_DRIVER_TEAM.id, function()
    menu.notify("Vehicle Variation Best\nVehicle: Sentinel Classic 2 Seats\n\nVehicle Variation: Good\nVehicle: Kanjo 2 Seats\n\nVehicle Variation Fine\nVehicle: Asbo 2 Seats\n\nVehicle Variation Worst\nVehicle: Issi Classic 2 Seats", "Karim Denz Cut 5%", 5, 0x64F0AA14)
        for i = 1, #CH_DRV_MAN_01 do
        stat_set_int(CH_DRV_MAN_01[i][1], true, CH_DRV_MAN_01[i][2])
        end
end)
end

do
local CH_DRV_MAN_RND = {
    {"H3OPT_CREWDRIVER", 1, 5, 1 ,5}
}
    menu.add_feature("» Random Driver Member", "action", CASINO_DRIVER_TEAM.id, function()
    menu.notify("Crew Driver randomized", "Heist Control", 3, 0x64F0AA14)
    for i = 1, #CH_DRV_MAN_RND do
    stat_set_int(CH_DRV_MAN_RND[i][1], true, math.random(CH_DRV_MAN_RND[i][4], CH_DRV_MAN_RND[i][5]))
    end
end)
end

do
local CH_DRV_MAN_00 = {
    {"H3OPT_CREWDRIVER", 6}
}
menu.add_feature("» Remove Driver Member (0% Payout)", "action", CASINO_DRIVER_TEAM.id, function()
menu.notify("Driver Member Removed", "Heist Control", 3, 0x64F0AA14)
    for i = 1, #CH_DRV_MAN_00 do
    stat_set_int(CH_DRV_MAN_00[i][1], true, CH_DRV_MAN_00[i][2])
        end
    end)
end

local CAH_DRIVER_TEAM_var = menu.add_feature("» Vehicle Variation", "parent", CASINO_DRIVER_TEAM.id)

do
local CH_DRV_MAN_var_03 = {
    {"H3OPT_VEHS", 3}
}
menu.add_feature("» Best Variation", "action", CAH_DRIVER_TEAM_var.id, function()
menu.notify("Best Variation Selected", "Heist Control", 3, 0x64F0AA14)
    for i = 1, #CH_DRV_MAN_var_03 do
    stat_set_int(CH_DRV_MAN_var_03[i][1], true, CH_DRV_MAN_var_03[i][2])
    end
end)
end

do
local CH_DRV_MAN_var_02 = {
        {"H3OPT_VEHS", 2}
    }
    menu.add_feature("» Good Variation", "action", CAH_DRIVER_TEAM_var.id, function()
    menu.notify("Good Variation", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_DRV_MAN_var_02 do
        stat_set_int(CH_DRV_MAN_var_02[i][1], true, CH_DRV_MAN_var_02[i][2])
        end
    end)
end
do
local CH_DRV_MAN_var_01 = {
    {"H3OPT_VEHS", 1}
}
    menu.add_feature("» Fine Variation", "action", CAH_DRIVER_TEAM_var.id, function()
    menu.notify("Fine Variation", "Heist Control - Vehicle Variation", 3, 0x64F0AA14)
        for i = 1, #CH_DRV_MAN_var_01 do
        stat_set_int(CH_DRV_MAN_var_01[i][1], true, CH_DRV_MAN_var_01[i][2])
        end
    end)
end
do

local CH_DRV_MAN_var_00 = {
    {"H3OPT_VEHS", 0}
}
    menu.add_feature("» Worst Variation", "action", CAH_DRIVER_TEAM_var.id, function()
    menu.notify("Worst Variation", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_DRV_MAN_var_00 do
        stat_set_int(CH_DRV_MAN_var_00[i][1], true, CH_DRV_MAN_var_00[i][2])
        end
    end)
end

do
local CH_DRV_MAN_var_RND = {
    {"H3OPT_VEHS", 0, 3, 0, 3}
}
    menu.add_feature("» Random Car Variation", "action", CAH_DRIVER_TEAM_var.id, function()
    menu.notify("Car Randomized", "Heist Control", 3, 0x64F0AA14)
        for i = 1, #CH_DRV_MAN_var_RND do
        stat_set_int(CH_DRV_MAN_var_RND[i][1], true, math.random(CH_DRV_MAN_var_RND[i][4], CH_DRV_MAN_var_RND[i][5]))
        end
    end)
end

local CASINO_HACKERs = menu.add_feature("» Change Hacker", "parent", CASINO_BOARD2.id)
do
local CH_HCK_MAN_04 = {
    {"H3OPT_CREWHACKER", 4}
}
    menu.add_feature("» Avi Schwartzman (10%)", "action", CASINO_HACKERs.id, function()
    menu.notify("Name: Avi Schwartzman\nSkill: Expert\nTime Undetected: 3:30\nTime Detected: 2:26\nCut: 10%", "Heist Control", 5, 0x64F0AA14)
        for i = 1, #CH_HCK_MAN_04 do
        stat_set_int(CH_HCK_MAN_04[i][1], true, CH_HCK_MAN_04[i][2])
        end
end)
end

do
local CH_HCK_MAN_05 = {
    {"H3OPT_CREWHACKER", 5}
}
    menu.add_feature("» Paige Harris (9%)", "action", CASINO_HACKERs.id, function()
    menu.notify("Name: Paige Harris\nSkill: Expert\nTime Undetected: 3:25\nTime Detected: 2:23\nCut: 9%", "Heist Control", 5, 0x64F0AA14)
        for i = 1, #CH_HCK_MAN_05 do
        stat_set_int(CH_HCK_MAN_05[i][1], true, CH_HCK_MAN_05[i][2])
        end
end)
end

do
local CH_HCK_MAN_03 = {
    {"H3OPT_CREWHACKER", 2}
}
    menu.add_feature("» Christian Feltz (7%)", "action", CASINO_HACKERs.id, function()
    menu.notify("Name: Christian Feltz\nSkill: Good\nTime Undetected: 2:59\nTime Detected: 2:05\nCut: 7%", "Heist Control", 5, 0x64F0AA14)
        for i = 1, #CH_HCK_MAN_03 do
        stat_set_int(CH_HCK_MAN_03[i][1], true, CH_HCK_MAN_03[i][2])
        end
end)
end

do
local CH_HCK_MAN_02 = {
    {"H3OPT_CREWHACKER", 3}
}
    menu.add_feature("» Yohan Blair (5%)", "action", CASINO_HACKERs.id, function()
    menu.notify("Name: Yohan Blair\nSkill: Good\nTime Undetected: 2:52\nTime Detected: 2:01\nCut: 5%", "Heist Control", 5, 0x64F0AA14)
        for i = 1, #CH_HCK_MAN_02 do
        stat_set_int(CH_HCK_MAN_02[i][1], true, CH_HCK_MAN_02[i][2])
        end
end)
end

do
local CH_HCK_MAN_01 = {
    {"H3OPT_CREWHACKER", 1}
}
    menu.add_feature("» Rickie Luken (3%)", "action", CASINO_HACKERs.id, function()
    menu.notify("Name: Rickie Luken\nSkill: Poor\nTime Undetected: 2:26\nTime Detected: 1:42\nCut: 3%", "Heist Control - Hacker Member", 5, 0x64F0AA14)
        for i = 1, #CH_HCK_MAN_01 do
        stat_set_int(CH_HCK_MAN_01[i][1], true, CH_HCK_MAN_01[i][2])
        end
end)
end

do
local CH_HCK_MAN_RND = {
    {"H3OPT_CREWHACKER", 0, 5, 1, 5}
}
    menu.add_feature("» Random Hacker Member", "action", CASINO_HACKERs.id, function()
    menu.notify("Hacker member randomized", "Heist Control", 4, 0x64F0AA14)
        for i = 1, #CH_HCK_MAN_RND do
        stat_set_int(CH_HCK_MAN_RND[i][1], true, math.random(CH_HCK_MAN_RND[i][4], CH_HCK_MAN_RND[i][5]))
        end
end)
end
do
local CH_HCK_MAN_00 = {
    {"H3OPT_CREWHACKER", 6}
}
    menu.add_feature("» Remove Hacker Member (0% Payout)", "action", CASINO_HACKERs.id, function()
    menu.notify("Hacker member removed", "Heist Control", 4, 0x64F0AA14)
        for i = 1, #CH_HCK_MAN_00 do
        stat_set_int(CH_HCK_MAN_00[i][1], true, CH_HCK_MAN_00[i][2])
        end
    end)
end

local CASINO_MASK = menu.add_feature("» Choose Mask", "parent", CASINO_BOARD2.id)

do
local CH_MASK_00 = {
    {"H3OPT_MASKS", -1}
}
    menu.add_feature("» Remove Mask", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Removed", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_00 do
        stat_set_int(CH_MASK_00[i][1], true, CH_MASK_00[i][2])
        end
end)
end

do
local CH_MASK_01 = {
    {"H3OPT_MASKS", 1}
}
    menu.add_feature("» Geometric Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Geometric", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_01 do
        stat_set_int(CH_MASK_01[i][1], true, CH_MASK_01[i][2])
        end
end)
end

do
local CH_MASK_02 = {
    {"H3OPT_MASKS", 2}
}
    menu.add_feature("» Hunter Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Hunter", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_02 do
        stat_set_int(CH_MASK_02[i][1], true, CH_MASK_02[i][2])
        end
end)
end

do
local CH_MASK_03 = {
    {"H3OPT_MASKS", 3}
}
    menu.add_feature("» Oni Half Mask Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Oni Half Mask", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_03 do
    stat_set_int(CH_MASK_03[i][1], true, CH_MASK_03[i][2])
        end
    end)
end

do
local CH_MASK_04 = {
    {"H3OPT_MASKS", 4}
}
    menu.add_feature("» Emoji Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Emoji", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_04 do
        stat_set_int(CH_MASK_04[i][1], true, CH_MASK_04[i][2])
        end
end)
end

do
local CH_MASK_05 = {
    {"H3OPT_MASKS", 5}
}
    menu.add_feature("» Ornate Skull Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Ornate Skull", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_05 do
        stat_set_int(CH_MASK_05[i][1], true, CH_MASK_05[i][2])
        end
end)
end

do
local CH_MASK_06 = {
     {"H3OPT_MASKS", 6}
}
    menu.add_feature("» Lucky Fruit Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Lucky Fruit", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_06 do
        stat_set_int(CH_MASK_06[i][1], true, CH_MASK_06[i][2])
         end
end)
end

do
local CH_MASK_07 = {
    {"H3OPT_MASKS", 7}
}
    menu.add_feature("» Guerilla Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Guerilla", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_07 do
        stat_set_int(CH_MASK_07[i][1], true, CH_MASK_07[i][2])
        end
end)
end

do
local CH_MASK_08 = {
    {"H3OPT_MASKS", 8}
}
    menu.add_feature("» Clown Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Clown", "Heist Control", 2, 0x64F0AA14)
    for i = 1, #CH_MASK_08 do
     stat_set_int(CH_MASK_08[i][1], true, CH_MASK_08[i][2])
    end
end)
end

do
local CH_MASK_09 = {
    {"H3OPT_MASKS", 9}
}
    menu.add_feature("» Animal Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Animal", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_09 do
        stat_set_int(CH_MASK_09[i][1], true, CH_MASK_09[i][2])
        end
end)
end

do
local CH_MASK_10 = {
    {"H3OPT_MASKS", 10}
}
    menu.add_feature("» Riot Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Riot", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_10 do
        stat_set_int(CH_MASK_10[i][1], true, CH_MASK_10[i][2])
        end
end)
end

do
local CH_MASK_11 = {
    {"H3OPT_MASKS", 11}
}
    menu.add_feature("» Oni Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Oni Set", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_11 do
        stat_set_int(CH_MASK_11[i][1], true, CH_MASK_11[i][2])
        end
end)
end

do
local CH_MASK_12 = {
    {"H3OPT_MASKS", 12}
}
    menu.add_feature("» Hocket Set", "action", CASINO_MASK.id, function()
    menu.notify("Mask: Hockey Set", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_MASK_12 do
        stat_set_int(CH_MASK_12[i][1], true, CH_MASK_12[i][2])
    end
end)
end

do
    local CH_DUGGAN = {
{"H3OPT_DISRUPTSHIP", 3}
}
local CH_SCANC_LVL = {
    {"H3OPT_KEYLEVELS", 2}
}
    menu.add_feature("» Unlock Scan Card LVL 2", "action", CASINO_BOARD2.id, function()
    menu.notify("Scan Card LVL 2 Unlocked", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_SCANC_LVL do
        stat_set_int(CH_SCANC_LVL[i][1], true, CH_SCANC_LVL[i][2])
    end
end)
   
    menu.add_feature("» Weaken Duggan Guards", "action", CASINO_BOARD2.id, function()
    menu.notify("Duggan Guards Weakened", "Heist Control", 2, 0x64F0AA14)
        for i = 1, #CH_DUGGAN do
        stat_set_int(CH_DUGGAN[i][1], true, CH_DUGGAN[i][2])
    end
end)
end

do
local CH_UNLCK_3stboard_var1 = {
    {"H3OPT_BITSET0", -8849}
}
local CH_UNLCK_3stboard_var3bc = {
    {"H3OPT_BITSET0", -186}
}

menu.add_feature("» Remove Drill for Silent and Aggressive only", "action", CASINO_BOARD3.id, function()
menu.notify("Drill removed for Silent and Aggressive Approach", "Heist Control", 3, 0x64F06414)
    for i = 1, #CH_UNLCK_3stboard_var1 do
        stat_set_int(CH_UNLCK_3stboard_var1[i][1], true, CH_UNLCK_3stboard_var1[i][2])
     end
end)
    menu.add_feature("» Remove Drill for The Big Con only", "action", CASINO_BOARD3.id, function()
     menu.notify("Drill removed for BigCon", "Heist Control", 3, 0x64F06414)
    for i = 1, #CH_UNLCK_3stboard_var3bc do
        stat_set_int(CH_UNLCK_3stboard_var3bc[i][1], true, CH_UNLCK_3stboard_var3bc[i][2])
        end
    end)
end

do
local CH_LOAD_BOARD_var0 = {
    {"H3OPT_BITSET1", -1},
    {"H3OPT_BITSET0", -1}
}
local CH_UNLOAD_BOARD_var1 = {
    {"H3OPT_BITSET1", 0},
    {"H3OPT_BITSET0", 0}
}
menu.add_feature("» Load all Boards", "action", CASINO_LBOARDS.id, function()
    menu.notify("All Planning Board Loaded", "Heist Control", 3, 0x6400FA14)
    for i = 1, #CH_LOAD_BOARD_var0 do
        stat_set_int(CH_LOAD_BOARD_var0[i][1], true, CH_LOAD_BOARD_var0[i][2])
    end
end)

menu.add_feature("» Unload all Boards", "action", CASINO_LBOARDS.id, function()
    menu.notify("All Planning Board Unloaded", "Heist Control", 3, 0x641400FF)
    for i = 1, #CH_UNLOAD_BOARD_var1 do
        stat_set_int(CH_UNLOAD_BOARD_var1[i][1], true, CH_UNLOAD_BOARD_var1[i][2])
    end
end)
end
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
    {"CAS_HEIST_NOTS", -1},
    {"CAS_HEIST_FLOW", -1},
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
    {"H3_BOARD_DIALOGUE0", -1},
    {"H3_BOARD_DIALOGUE1", -1},
    {"H3_BOARD_DIALOGUE2", -1},
    {"H3_VEHICLESUSED", -1},
    {"H3_CR_STEALTH_1A", 100},
    {"H3_CR_STEALTH_2B_RAPP", 100},
    {"H3_CR_STEALTH_2C_SIDE", 100},
    {"H3_CR_STEALTH_3A", 100},
    {"H3_CR_STEALTH_4A", 100},
    {"H3_CR_STEALTH_5A", 100},
    {"H3_CR_SUBTERFUGE_1A", 100},
    {"H3_CR_SUBTERFUGE_2A", 100},
    {"H3_CR_SUBTERFUGE_2B", 100},
    {"H3_CR_SUBTERFUGE_3A", 100},
    {"H3_CR_SUBTERFUGE_3B", 100},
    {"H3_CR_SUBTERFUGE_4A", 100},
    {"H3_CR_SUBTERFUGE_5A", 100},
    {"H3_CR_DIRECT_1A", 100},
    {"H3_CR_DIRECT_2A1", 100},
    {"H3_CR_DIRECT_2A2", 100},
    {"H3_CR_DIRECT_2BP", 100},
    {"H3_CR_DIRECT_2C", 100},
    {"H3_CR_DIRECT_3A", 100},
    {"H3_CR_DIRECT_4A", 100},
    {"H3_CR_DIRECT_5A", 100},
    {"CR_ORDER", 100}
}
    menu.add_feature("» Unlock Casino Arcade (Trophies) & Casino Heist Awards", "action", CASINO_MORE.id, function()
    menu.notify("All Casino & Casino Heist Awards Unlocked", "", 3, 0x50FF78F0)
    for i = 1, #CH_AWRD_IT do
        stat_set_int(CH_AWRD_IT[i][1], true, CH_AWRD_IT[i][2])
    end
    for i = 2, #CH_AWRD_BL do
        stat_set_bool(CH_AWRD_BL[i][1], true, CH_AWRD_BL[i][2])
        end
    for i=0,128,1 do -- 28483 - 28355 = 128
        hash, mask = stats.stat_get_bool_hash_and_mask("_HEIST3TATTOOSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
    end

    for i=0,320,1 do -- 28354 - 28098 = 256
        hash, mask = stats.stat_get_bool_hash_and_mask("_CASINOHSTPSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
    end

    for i=0,448,1 do -- 27258 - 26810 = 448
        hash, mask = stats.stat_get_bool_hash_and_mask("_CASINOPSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
    end

    end)
end

do
local AGATHA_MS_INT= {
    {"VCM_FLOW_PROGRESS", -1},
    {"VCM_STORY_PROGRESS", 5}
}
local AGATHA_MS_BOL = {
    {"AWD_LEADER", true},
    {"VCM_FLOW_CS_FIN_SEEN", true}
}
menu.add_feature("» Skip Agatha Baker missions to the last one", "action", CASINO_MORE.id, function()
    menu.notify("Your wish was successfully granted", "", 5, 0x64F078F0)
    for i = 1, #AGATHA_MS_INT do
        stat_set_int(AGATHA_MS_INT[i][1], true, AGATHA_MS_INT[i][2])
    end
    for i = 2, #AGATHA_MS_BOL do
        stat_set_bool(AGATHA_MS_BOL[i][1], true, AGATHA_MS_BOL[i][2])
    end
end)
end

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
menu.add_feature("» Reset Heist to Default", "action", CASINO_MORE.id, function()
    menu.notify("Call to Lester and tell him to cancel the Casino Heist", "Heist Control", 3, 0x64FF78B4)
for i = 1, #CH_RST do
    stat_set_int(CH_RST[i][1], true, CH_RST[i][2])
end
end)
end
-------- DOOMSDAY HEIST
do
local DD_H_ACT1 = {
    {"GANGOPS_FLOW_MISSION_PROG", 503},
    {"GANGOPS_HEIST_STATUS", -229383},
    {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
}
    menu.add_feature("» ACT I : The Data Breaches [$2.5MI - All Players]", "toggle", DOOMS_PRESETS.id, function(ACTI)
        menu.notify("* The Heist is ready to begin\n* Payments have already been set, no more adjustments are needed.\n* Leave the option active until you finish the Heist", "The Data Breaches - ACT I", 6, 0x50F0DC14)
    while ACTI.on do
    for i = 1, #DD_H_ACT1 do
        stat_set_int(DD_H_ACT1[i][1], true, DD_H_ACT1[i][2])
    end
    script.set_global_i(1962755+812+50+1, 313)
    script.set_global_i(1962755+812+50+2, 313)
    script.set_global_i(1962755+812+50+3, 313)
    script.set_global_i(1962755+812+50+4, 313)
    system.yield(0)
end
end)
end

do
local DD_H_ACT2 = {
    {"GANGOPS_FLOW_MISSION_PROG", 240},
    {"GANGOPS_HEIST_STATUS", -229378},
    {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
}
    menu.add_feature("» ACT II : The Bogdan Problem [$2.5MI - All Players]", "toggle", DOOMS_PRESETS.id, function(ACTII)
        menu.notify("* The Heist is ready to begin\n* Payments have already been set, no more adjustments are needed.\n* Leave the option active until you finish the Heist", "The Bogdan Problem - ACT II", 6, 0x50F0DC14)
    while ACTII.on do
    for i = 1, #DD_H_ACT2 do
        stat_set_int(DD_H_ACT2[i][1], true, DD_H_ACT2[i][2])
    end
    script.set_global_i(1962755+812+50+1, 214)
    script.set_global_i(1962755+812+50+2, 214)
    script.set_global_i(1962755+812+50+3, 214)
    script.set_global_i(1962755+812+50+4, 214)
    system.yield(0)
end
end)
end

do
local DD_H_ACT3 = {
    {"GANGOPS_FLOW_MISSION_PROG", 16368},
    {"GANGOPS_HEIST_STATUS", -229380},
    {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
}
    menu.add_feature("» ACT III : The Doomsday Scenario [$2.5MI - All Players]", "toggle", DOOMS_PRESETS.id, function(ACTIII)
    menu.notify("* The Heist is ready to begin\n* Payments have already been set, no more adjustments are needed.\n* Leave the option active until you finish the Heist", "The Doomsday Scenario - ACT III", 6, 0x50F0DC14)
    while ACTIII.on do
    for i = 1, #DD_H_ACT3 do
        stat_set_int(DD_H_ACT3[i][1], true, DD_H_ACT3[i][2])
    end
    script.set_global_i(1962755+812+50+1, 170)
    script.set_global_i(1962755+812+50+2, 170)
    script.set_global_i(1962755+812+50+3, 170)
    script.set_global_i(1962755+812+50+4, 170)
    system.yield(0)
end
end)
end

do
local DDHEIST_HOST_MANAGER = menu.add_feature("» Your Payment", "parent", DDHEIST_PLYR_MANAGER.id)

menu.add_feature("Custom Payout", "action", DDHEIST_HOST_MANAGER.id, function(domhost)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1962755+812+50+1, tonumber(s))
end)

    menu.add_feature("0%", "toggle", DDHEIST_HOST_MANAGER.id, function(pay1_)
    while pay1_.on do
    script.set_global_i(1962755+812+50+1, 0)
    system.yield(0)
    end
end)

menu.add_feature("50%", "action", DDHEIST_HOST_MANAGER.id, function()
    script.set_global_i(1962755+812+50+1, 50)
end)

menu.add_feature("85%", "action", DDHEIST_HOST_MANAGER.id, function()
    script.set_global_i(1962755+812+50+1, 85)
end)

menu.add_feature("100%", "action", DDHEIST_HOST_MANAGER.id, function()
    script.set_global_i(1962755+812+50+1, 100)
end)

menu.add_feature("150%", "action", DDHEIST_HOST_MANAGER.id, function()
    script.set_global_i(1962755+812+50+1, 150)
end)

menu.add_feature("175%", "action", DDHEIST_HOST_MANAGER.id, function()
    script.set_global_i(1962755+812+50+1, 175)
end)

menu.add_feature("205%", "action", DDHEIST_HOST_MANAGER.id, function()
    script.set_global_i(1962755+812+50+1, 205)
end)
end

do
local DDHEIST_PLAYER2_MANAGER = menu.add_feature("» Player 2 Payment", "parent", DDHEIST_PLYR_MANAGER.id)
menu.add_feature("Custom Payout", "action", DDHEIST_PLAYER2_MANAGER.id, function(dom2)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1962755+812+50+2, tonumber(s))
end)

menu.add_feature("0%", "toggle", DDHEIST_PLAYER2_MANAGER.id, function(pay2_)
    while pay2_.on do
    script.set_global_i(1962755+812+50+2, 0)
    system.yield(0)
end
end)

menu.add_feature("50%", "action", DDHEIST_PLAYER2_MANAGER.id, function()
    script.set_global_i(1962755+812+50+2, 50)
end)

menu.add_feature("85%", "action", DDHEIST_PLAYER2_MANAGER.id, function()
    script.set_global_i(1962755+812+50+2, 85)
end)

menu.add_feature("100%", "action", DDHEIST_PLAYER2_MANAGER.id, function()
    script.set_global_i(1962755+812+50+2, 100)
end)

menu.add_feature("150%", "action", DDHEIST_PLAYER2_MANAGER.id, function()
    script.set_global_i(1962755+812+50+2, 150)
end)

menu.add_feature("175%", "action", DDHEIST_PLAYER2_MANAGER.id, function()
    script.set_global_i(1962755+812+50+2, 175)
end)

menu.add_feature("200%", "action", DDHEIST_PLAYER2_MANAGER.id, function()
    script.set_global_i(1962755+812+50+2, 200)
end)

menu.add_feature("205%", "action", DDHEIST_PLAYER2_MANAGER.id, function()
    script.set_global_i(1962755+812+50+2, 205)
end)
end

do
local DDHEIST_PLAYER3_MANAGER = menu.add_feature("» Player 3 Payment", "parent", DDHEIST_PLYR_MANAGER.id)

menu.add_feature("Custom Payout", "action", DDHEIST_PLAYER3_MANAGER.id, function(dom3)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1962755+812+50+3, tonumber(s))
end)

menu.add_feature("0%", "toggle", DDHEIST_PLAYER3_MANAGER.id, function(pay3_)
    while pay3_.on do
    script.set_global_i(1962755+812+50+3, 0)
    system.yield(0)
end
end)

menu.add_feature("50%", "action", DDHEIST_PLAYER3_MANAGER.id, function()
    script.set_global_i(1962755+812+50+3, 50)
end)

menu.add_feature("85%", "action", DDHEIST_PLAYER3_MANAGER.id, function()
    script.set_global_i(1962755+812+50+3, 85)
end)

menu.add_feature("100%", "action", DDHEIST_PLAYER3_MANAGER.id, function()
    script.set_global_i(1962755+812+50+3, 100)
end)

menu.add_feature("150%", "action", DDHEIST_PLAYER3_MANAGER.id, function()
    script.set_global_i(1962755+812+50+3, 150)
end)

menu.add_feature("175%", "action", DDHEIST_PLAYER3_MANAGER.id, function()
    script.set_global_i(1962755+812+50+3, 175)
end)

menu.add_feature("200%", "action", DDHEIST_PLAYER3_MANAGER.id, function()
    script.set_global_i(1962755+812+50+3, 200)
end)

menu.add_feature("205%", "action", DDHEIST_PLAYER3_MANAGER.id, function()
    script.set_global_i(1962755+812+50+3, 205)
end)
end

do
local DDHEIST_PLAYER4_MANAGER = menu.add_feature("» Player 4 Payment", "parent", DDHEIST_PLYR_MANAGER.id)

menu.add_feature("Custom Payout", "action", DDHEIST_PLAYER4_MANAGER.id, function(dom4)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1962755+812+50+4, tonumber(s))
end)

menu.add_feature("0%", "toggle", DDHEIST_PLAYER4_MANAGER.id, function(pay4_)
    while pay4_.on do
    script.set_global_i(1962755+812+50+4, 0)
    system.yield(0)
end
end)

menu.add_feature("50%", "action", DDHEIST_PLAYER4_MANAGER.id, function()
    script.set_global_i(1962755+812+50+4, 50)
end)

menu.add_feature("85%", "action", DDHEIST_PLAYER4_MANAGER.id, function()
    script.set_global_i(1962755+812+50+4, 85)
end)

menu.add_feature("100%", "action", DDHEIST_PLAYER4_MANAGER.id, function()
    script.set_global_i(1962755+812+50+4, 100)
end)

menu.add_feature("150%", "action", DDHEIST_PLAYER4_MANAGER.id, function()
    script.set_global_i(1962755+812+50+4, 150)
end)

menu.add_feature("175%", "action", DDHEIST_PLAYER4_MANAGER.id, function()
    script.set_global_i(1962755+812+50+4, 175)
end)

menu.add_feature("200%", "action", DDHEIST_PLAYER4_MANAGER.id, function()
    script.set_global_i(1962755+812+50+4, 200)
end)

menu.add_feature("205%", "action", DDHEIST_PLAYER4_MANAGER.id, function()
    script.set_global_i(1962755+812+50+4, 205)
end)
end

do
local DD_H_ULCK = {
    {"GANGOPS_HEIST_STATUS", -1},
    {"GANGOPS_HEIST_STATUS", -229384}
}
    menu.add_feature("» Unlock all Doomsday Heist", "action", DOOMS_HEIST.id, function()
    menu.notify("Call the Lester and ask to cancel the Doomsday Heist (Three Times)\nDo this only once", "Heist Control", 4, 0x64F06414)
    for i = 1, #DD_H_ULCK do
    stat_set_int(DD_H_ULCK[i][1], true, DD_H_ULCK[i][2])
    end
    end)
end

do
local DD_PREPS_DONE = {
    {"GANGOPS_FM_MISSION_PROG", -1}
}
menu.add_feature("» Complete all preparations (Not setups)", "action", DOOMS_HEIST.id, function()
    menu.notify("All Preps are completed", "Heist Control", 3, 0x64F06414)
    for i = 1, #DD_PREPS_DONE do
        stat_set_int(DD_PREPS_DONE[i][1], true, DD_PREPS_DONE[i][2])
    end
end)
end

do
local DD_H_RST = {
    {"GANGOPS_FLOW_MISSION_PROG", 240},
    {"GANGOPS_HEIST_STATUS", 0},
    {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
}
    menu.add_feature("» Reset Heist to Default", "action", DOOMS_HEIST.id, function()
    menu.notify("Doomsday restored\nGo to a new session!!!", "Heist Control", 3, 0x64F06414)
        for i = 1, #DD_H_RST do
        stat_set_int(DD_H_RST[i][1], true, DD_H_RST[i][2])
        end
    end)
    end
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
    {"MPPLY_GANGOPS_SUPPORT", -1},
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
    {"CR_GANGOP_FINALE_P3", 10},
    {"WAM_FLOW_VEHICLE_BS", -1},
    {"GANGOPS_FLOW_IMPEXP_NUM", -1}
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
menu.add_feature("» Unlock All Doomsday Awards", "action", DOOMS_HEIST.id, function()
    for i = 1, #DD_AWARDS_I do
        stat_set_int(DD_AWARDS_I[i][1], true, DD_AWARDS_I[i][2])
        stat_set_int(DD_AWARDS_I[i][1], false, DD_AWARDS_I[i][2])
    end
    for i = 1, #DD_AWARDS_B do
        stat_set_bool(DD_AWARDS_B[i][1], true, DD_AWARDS_B[i][2])
        stat_set_bool(DD_AWARDS_B[i][1], false, DD_AWARDS_B[i][2])
    end
    for i=0,64,1 do
        hash, mask = stats.stat_get_bool_hash_and_mask("_GANGOPSPSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
        end
    menu.notify("Doomsday Awards Unlocked", "", 2, 0x50FF78F0)
end)
end
-------- CLASSIC HEIST
do
menu.add_feature("Custom Payout", "action", CLASSIC_CUT.id, function(classic)
    local r, s = input.get("It is not recommended to use such high values", "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    script.set_global_i(1934631 + 3008 +1, tonumber(s))
end)

menu.add_feature("0 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 0)
    if not a.on then return end
    system.wait(0)
    end
end)
menu.add_feature("25 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 25)
    if not a.on then return end
    system.wait(0)
    end
end)
menu.add_feature("50 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 50)
    if not a.on then return end
    system.wait(0)
    end
end)
menu.add_feature("75 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 75)
    if not a.on then return end
    system.wait(0)
    end
end)
menu.add_feature("85 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 85)
    if not a.on then return end
    system.wait(0)
    end
end)
menu.add_feature("100 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 100)
    if not a.on then return end
    system.wait(0)
    end
end)
menu.add_feature("125 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 125)
    if not a.on then return end
    system.wait(0)
    end
end)
menu.add_feature("150 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 150)
    if not a.on then return end
    system.wait(0)
    end
end)
menu.add_feature("175 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 175)
    if not a.on then return end
    system.wait(0)
    end
end)
menu.add_feature("200 %", "toggle", CLASSIC_CUT.id, function(a)
    while a.on do
    script.set_global_i(1934631 + 3008 +1, 200)
    if not a.on then return end
    system.wait(0)
    end
end)
end

do
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
    menu.add_feature("» Unlock All Awards & All Classic Heists", "action", CLASSIC_HEISTS.id, function()
    menu.notify("- All achievements unlocked\n\n- All Classic Heists unlocked\n\nSwitch session or restart the game to take effect", "", 6, 0x64FF7800)
    for i = 1, #Apartment_AWD_I do
    stat_set_int(Apartment_AWD_I[i][1], true, Apartment_AWD_I[i][2])
    stat_set_int(Apartment_AWD_I[i][1], false, Apartment_AWD_I[i][2])
    for i = 1, #Apartment_AWD_B do
    stat_set_bool(Apartment_AWD_B[i][1], true, Apartment_AWD_B[i][2])
    stat_set_bool(Apartment_AWD_B[i][1], false, Apartment_AWD_B[i][2])
end
end
end)
end

do
local Apartment_SetDone = {
    {"HEIST_PLANNING_STAGE", -1}
}
    menu.add_feature("» Complete all setups", "toggle", CLASSIC_HEISTS.id, function(checkin)
    menu.notify("You may need to choose a Heist and then complete the first setup\n\nLet activated until then ;)", "", 7, 0x50FF78B4)
    while checkin.on do
    for i = 1, #Apartment_SetDone do
    stat_set_int(Apartment_SetDone[i][1], true, Apartment_SetDone[i][2])
    end
    system.yield(0)
    end
end)
end

menu.add_feature("» Fleeca Heist 15 MILLIONs", "toggle", CLASSIC_HEISTS.id, function(a)
    menu.notify("* Only works if you are the Host\n* Does not affect others players\n* Use this as your last option\n* Keep it on until the end of the Heist\n* Activate when you are on the cut screen", "Fleeca 15 Millions", 10, 0x646C1A51)
    while a.on do
    script.set_global_i(1934631 + 3008 +1,10434)
    system.yield(0)
    end
end)

menu.add_feature("» Fleeca Heist 10 MILLIONs", "toggle", CLASSIC_HEISTS.id, function(ab)
    menu.notify("* Only works if you are the Host\n* Does not affect others players\n* Use this as your last option\n* Keep it on until the end of the Heist\n* Activate when you are on the cut screen", "Fleeca 10 Millions", 10, 0x646C1A51)
    while ab.on do
    script.set_global_i(1934631 + 3008 +1,7000)
    system.yield(0)
    end
end)

menu.add_feature("» Fleeca Heist 5 MILLIONs", "toggle", CLASSIC_HEISTS.id, function(ab)
    menu.notify("* Only works if you are the Host\n* Does not affect others players\n* Use this as your last option\n* Keep it on until the end of the Heist\n* Activate when you are on the cut screen", "Fleeca 5 Millions", 10, 0x646C1A51)
    while ab.on do
    script.set_global_i(1934631 + 3008 +1,3500)
    system.yield(0)
    end
end)

-- CLASSIC CUT WEEKLY EVENT
menu.add_feature("» [2x EVENT] Fleeca Heist 15 MILLIONs", "toggle", CLASSIC_HEISTS.id, function(eg)
    menu.notify("This option should only be used when the double weekly event (2x RP and GTA$) is enabled!", "", 5, 0x641FD5E9)
    menu.notify("* Only works if you are the Host\n* Does not affect other players\n* Use this as your last option\n* Keep it on until the end of the Heist\n* Activate when you are on the cut screen", "Fleeca 15 Millions [x2 EVENT]", 10, 0x646C1A51)
    while eg.on do
    script.set_global_i(1934631+3008+1, 5217)
    system.yield(0)
    end
end)
    
menu.add_feature("» [2x EVENT] Fleeca Heist 10 MILLIONs", "toggle", CLASSIC_HEISTS.id, function(eg)
    menu.notify("This option should only be used when the double weekly event (2x RP and GTA$) is enabled!", "", 5, 0x641FD5E9)
    menu.notify("* Only works if you are the Host\n* Does not affect other players\n* Use this as your last option\n* Keep it on until the end of the Heist\n* Activate when you are on the cut screen", "Fleeca 10 Millions [x2 EVENT]", 10, 0x646C1A51)
    while eg.on do
    script.set_global_i(1934631+3008+1, 3500)
    system.yield(0)
    end
end)

menu.add_feature("» [2x EVENT] Fleeca Heist 5 MILLIONs", "toggle", CLASSIC_HEISTS.id, function(eg)
    menu.notify("This option should only be used when the double weekly event (2x RP and GTA$) is enabled!", "", 5, 0x641FD5E9)
    menu.notify("* Only works if you are the Host\n* Does not affect other players\n* Use this as your last option\n* Keep it on until the end of the Heist\n* Activate when you are on the cut screen", "Fleeca 5 Millions [x2 EVENT]", 10, 0x646C1A51)
    while eg.on do
    script.set_global_i(1934631+3008+1, 1750)
    system.yield(0)
    end
end)

------------- LS CONTRACTS
    menu.add_feature("» Increase Payout to 1 Million", "toggle", LS_ROBBERY.id, function(rob)
        menu.notify(" Always keep this option actived before starting a contract\n\n There is a cooldown for the payment, about 15-20 minutes if you plan to repeat\n\n Affects you only","", 7, 0x6414B400)
    while rob.on do
        script.set_global_i(262145+30675+0,1000000)
        script.set_global_i(262145+30675+1,1000000)
        script.set_global_i(262145+30675+2,1000000)
        script.set_global_i(262145+30675+3,1000000)
        script.set_global_i(262145+30675+4,1000000)
        script.set_global_i(262145+30675+5,1000000)
        script.set_global_i(262145+30675+6,1000000)
        script.set_global_i(262145+30675+7,1000000)
        --script.set_global_i(292668,1000000)
        script.set_global_i(262145+30674,1000000) -- reward when joining a contract
        script.set_global_i(262145+30671,0) -- IA cut removal
    system.yield(0)
    end
end)

menu.add_feature("» [2x EVENT] Increase payout to 1 Million", "toggle", LS_ROBBERY.id, function(rob0)
    menu.notify("Always keep this option actived before starting a contract\n\nThere is a cooldown for the payment, about 15-20 minutes if you plan to repeat\n\nAffects you only","", 7, 0x6414B400)
    menu.notify("This option should only be used when the double event (2x RP and GTA$) is enabled!\n\nThe payment may appear as 500,000, but in fact you will get 1 million", "", 7, 0x6400FA14)
        while rob0.on do
        script.set_global_i(262145+30675+0,500000)
        script.set_global_i(262145+30675+1,500000)
        script.set_global_i(262145+30675+2,500000)
        script.set_global_i(262145+30675+3,500000)
        script.set_global_i(262145+30675+4,500000)
        script.set_global_i(262145+30675+5,500000)
        script.set_global_i(262145+30675+6,500000)
        script.set_global_i(262145+30675+7,500000)
        --script.set_global_i(292668,500000)
        script.set_global_i(262145+30674,500000) -- reward when joining a contract
        script.set_global_i(262145+30671,0) -- IA cut removal
        system.yield(0)
    end
end)

do
local LS_CONTRACT_0_UD = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 0}
}
    menu.add_feature("» Union Depository", "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_0_UD do
        menu.notify("For immediate effect... It is recommended that you stay outside from your Workshop!\n\nChoosed: Union Depository Contract", "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_0_UD[i][1], true, LS_CONTRACT_0_UD[i][2])
    end
    end)
end

do
local LS_CONTRACT_1_SD = {
    {"TUNER_GEN_BS", 4351},
    {"TUNER_CURRENT", 1}
}
    menu.add_feature("» The Superdollar Deal", "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_1_SD do
        menu.notify("For immediate effect... It is recommended that you stay outside from your Workshop!\n\nChoosed: The Superdollar Deal Contract", "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_1_SD[i][1], true, LS_CONTRACT_1_SD[i][2])
    end
    end)
end

do
local LS_CONTRACT_2_BC = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 2}
}
    menu.add_feature("» The Bank Contract", "action", LS_ROBBERY.id, function()
    for i = 1, #LS_CONTRACT_2_BC do
    menu.notify("For immediate effect... It is recommended that you stay outside from your Workshop!\n\nChoosed: The Bank Contract", "", 6, 0x64F06414)
    stat_set_int(LS_CONTRACT_2_BC[i][1], true, LS_CONTRACT_2_BC[i][2])
    end
    end)
end

do
local LS_CONTRACT_3_ECU = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 3}
}
    menu.add_feature("» The ECU Job", "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_3_ECU do
        menu.notify("For immediate effect... It is recommended that you stay outside from your Workshop!\n\nChoosed: The ECU Job Contract", "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_3_ECU[i][1], true, LS_CONTRACT_3_ECU[i][2])
    end
    end)
end

do
local LS_CONTRACT_4_PRSN = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 4}
} 
    menu.add_feature("» The Prison Contract", "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_4_PRSN do
        menu.notify("For immediate effect... It is recommended that you stay outside from your Workshop!\n\nChoosed: The Prison Contract", "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_4_PRSN[i][1], true, LS_CONTRACT_4_PRSN[i][2])
    end
    end)
end

do
local LS_CONTRACT_5_AGC = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 5}
}
    menu.add_feature("» The Agency Deal", "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_5_AGC do
        menu.notify("For immediate effect... It is recommended that you stay outside from your Workshop!\n\nChoosed: The Agency Deal Contract", "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_5_AGC[i][1], true, LS_CONTRACT_5_AGC[i][2])
    end
    end)
end

do
local LS_CONTRACT_6_LOST = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 6}
}
    menu.add_feature("» The Lost Contract", "action", LS_ROBBERY.id, function()
    for i = 1, #LS_CONTRACT_6_LOST do
    menu.notify("For immediate effect... It is recommended that you stay outside from your Workshop!\n\nChoosed: The Lost Contract", "", 6, 0x64F06414)
    stat_set_int(LS_CONTRACT_6_LOST[i][1], true, LS_CONTRACT_6_LOST[i][2])
    end
    end)
end

do
local LS_CONTRACT_7_DATA = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 7}
}
    menu.add_feature("» The Data Contract", "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_7_DATA do
        menu.notify("For immediate effect... It is recommended that you stay outside from your Workshop!\n\nChoosed: The Data Contract", "", 6, 0x64F06414)
        menu.notify("Ignoring some dialogues between npc's can prevent you from getting paid, please don't teleport too often!", "Important", 6, 0x6414F0FF)
        stat_set_int(LS_CONTRACT_7_DATA[i][1], true, LS_CONTRACT_7_DATA[i][2])
    end
    end)
end

do
local LS_CONTRACT_MSS_ONLY = {
    {"TUNER_GEN_BS", -1}
}
    menu.add_feature("» Complete missions (only)", "action", LS_ROBBERY.id, function()
    for i = 1, #LS_CONTRACT_MSS_ONLY do
    menu.notify("Changes will only happen if you are outside your Auto-Shop\n\nMissions completed","Heist Control", 6, 0x64F06414)
    stat_set_int(LS_CONTRACT_MSS_ONLY[i][1], true, LS_CONTRACT_MSS_ONLY[i][2])
    end
    end)
end

do
local LS_TUNERS_DLC_BL = {
    {"AWD_CAR_CLUB", true},
    {"AWD_PRO_CAR_EXPORT", true},
    {"AWD_UNION_DEPOSITORY", true},
    {"AWD_MILITARY_CONVOY", true},
    {"AWD_FLEECA_BANK", true},
    {"AWD_FREIGHT_TRAIN", true},
    {"AWD_BOLINGBROKE_ASS", true},
    {"AWD_IAA_RAID", true},
    {"AWD_METH_JOB", true},
    {"AWD_BUNKER_RAID", true},
    {"AWD_STRAIGHT_TO_VIDEO", true},
    {"AWD_MONKEY_C_MONKEY_DO", true},
    {"AWD_TRAINED_TO_KILL", true},
    {"AWD_DIRECTOR", true}
}
local LS_TUNERS_DLC_IT = {
    {"AWD_CAR_CLUB_MEM", 100},
    {"AWD_SPRINTRACER", 50},
    {"AWD_STREETRACER", 50},
    {"AWD_PURSUITRACER", 50},
    {"AWD_TEST_CAR", 240},
    {"AWD_AUTO_SHOP", 50},
    {"AWD_CAR_EXPORT", 100},
    {"AWD_GROUNDWORK", 40},
    {"AWD_ROBBERY_CONTRACT", 100},
    {"AWD_FACES_OF_DEATH", 100}
}
menu.add_feature("» Unlock All Tuners Awards", "action", LS_ROBBERY.id, function()
    for i = 1, #LS_TUNERS_DLC_IT do
        stat_set_int(LS_TUNERS_DLC_IT[i][1], true, LS_TUNERS_DLC_IT[i][2])
    end
    for i = 2, #LS_TUNERS_DLC_BL do
        stat_set_bool(LS_TUNERS_DLC_BL[i][1], true, LS_TUNERS_DLC_BL[i][2])
    end
    for i=0,576,1 do
        hash, mask = stats.stat_get_bool_hash_and_mask("_TUNERPSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
    end
    script.set_global_i(262145+30817, 1)
    menu.notify("All Tuners DLC Awards Unlocked", "", 3, 0x50FF78F0)
end)
end

local ROBBERY_RESETER = menu.add_feature("::: More Options", "parent", LS_ROBBERY.id)

do
local LS_CONTRACT_MISSION_RST = {
    {"TUNER_GEN_BS", 12467}
}
menu.add_feature("» Reset Missions (only)", "action", ROBBERY_RESETER.id, function()
    for i = 1, #LS_CONTRACT_MISSION_RST do
    menu.notify("Changes will only happen if you are outside your Auto-Shop\n\nMissions reseted","Heist Control", 3, 0x64F06414)
    stat_set_int(LS_CONTRACT_MISSION_RST[i][1], true, LS_CONTRACT_MISSION_RST[i][2])
    end
    end)
end

do
local LS_CONTRACT_RST = {
    {"TUNER_GEN_BS", 8371},
    {"TUNER_CURRENT", -1},
}
menu.add_feature("» Reset Contracts", "action", ROBBERY_RESETER.id, function()
    for i = 1, #LS_CONTRACT_RST do
    menu.notify("Changes will only happen if you are outside your Auto-Shop\n\nContract reseted","Heist Control", 3, 0x64F06414)
    stat_set_int(LS_CONTRACT_RST[i][1], true, LS_CONTRACT_RST[i][2])
end
end)
end

do
local RST_COUNT_TNR = {
    {"TUNER_COUNT", 0},
    {"TUNER_EARNINGS", 0}
}
    menu.add_feature("» Reset Total Gains & Completed Missions", "action", ROBBERY_RESETER.id, function()
    for i = 1, #RST_COUNT_TNR do
    menu.notify("It may only update if you are outside your workshop\n\nThe values have been reseted", "", 4, 0x64FF7878)
    stat_set_int(RST_COUNT_TNR[i][1], true, RST_COUNT_TNR[i][2])
    end
end)
end

-- THE CONTRACT DLC

local CONTRACT_MANAGER = menu.add_feature("» VIP Contract: Dr. Dre", "parent", TH_CONTRACT.id, function()
    menu.notify("It may be necessary to log out/return to the Office PC for the values to be updated", "",  5, 0x5014F0E6)
end)
local CONTRACT_MANAGER_ = menu.add_feature("» NightLife Leak", "parent", CONTRACT_MANAGER.id)
local CONTRACT_MANAGER__ = menu.add_feature("» High Society Leak", "parent", CONTRACT_MANAGER.id)
local CONTRACT_MANAGER___ = menu.add_feature("» South Central Leak", "parent", CONTRACT_MANAGER.id)

do 
 local LEAK_NIGHTCLUB = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_BS", 3},
    {"FIXER_STORY_COOLDOWN", -1}
}
    
menu.add_feature("» The Nightclub (Prep)", "action", CONTRACT_MANAGER_.id, function()
    for i = 1, #LEAK_NIGHTCLUB do
        stat_set_int(LEAK_NIGHTCLUB[i][1], true, LEAK_NIGHTCLUB[i][2])
        end
    menu.notify("The NightClub Prep selected")
    end)
end

do 
local LEAK_MARINA = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_BS", 4},
    {"FIXER_STORY_COOLDOWN", -1}
}
       
menu.add_feature("» The Marina (Prep)", "action", CONTRACT_MANAGER_.id, function()
    for i = 1, #LEAK_MARINA do
        stat_set_int(LEAK_MARINA[i][1], true, LEAK_MARINA[i][2])
    end
    menu.notify("Marina Prep selected")
end)
end

do 
local LEAK_NIGHTLIFE = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_BS", 12},
    {"FIXER_STORY_COOLDOWN", -1}
}

menu.add_feature("» NightLife Leak (Mission)", "action", CONTRACT_MANAGER_.id, function()
    for i = 1, #LEAK_NIGHTLIFE do
        stat_set_int(LEAK_NIGHTLIFE[i][1], true, LEAK_NIGHTLIFE[i][2])
    end
        menu.notify("NightLife Mission selected")
end)
end

do 
local LEAK_COUNTRYCLUB = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 28},
    {"FIXER_STORY_COOLDOWN", -1}
}

menu.add_feature("» The Country Club (Prep)", "action", CONTRACT_MANAGER__.id, function()
    for i = 1, #LEAK_COUNTRYCLUB do
        stat_set_int(LEAK_COUNTRYCLUB[i][1], true, LEAK_COUNTRYCLUB[i][2])
    end
        menu.notify("The Country Club Prep selected")
end)
end

do 
local LEAK_GUESTLIST = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 60},
    {"FIXER_STORY_COOLDOWN", -1}
}
    
menu.add_feature("» Guest List (Prep)", "action", CONTRACT_MANAGER__.id, function()
    for i = 1, #LEAK_GUESTLIST do
        stat_set_int(LEAK_GUESTLIST[i][1], true, LEAK_GUESTLIST[i][2])
    end
    menu.notify("Guest List Prep selected")
end)
end

do 
local LEAK_HIGHSOCIETY = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 124},
    {"FIXER_STORY_COOLDOWN", -1}
}
        
menu.add_feature("» High Society (Mission)", "action", CONTRACT_MANAGER__.id, function()
    for i = 1, #LEAK_HIGHSOCIETY do
        stat_set_int(LEAK_HIGHSOCIETY[i][1], true, LEAK_HIGHSOCIETY[i][2])
    end
    menu.notify("High Society Mission selected")
end)
end

do 
local LEAK_DAVIS = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 252},
    {"FIXER_STORY_COOLDOWN", -1}
}
            
menu.add_feature("» Davis (Prep)", "action", CONTRACT_MANAGER___.id, function()
    for i = 1, #LEAK_DAVIS do
        stat_set_int(LEAK_DAVIS[i][1], true, LEAK_DAVIS[i][2])
    end
    menu.notify("Davis Prep selected")
end)
end

do 
local LEAK_BALLAS = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 508},
    {"FIXER_STORY_COOLDOWN", -1}
}
                
menu.add_feature("» The Ballas (Prep)", "action", CONTRACT_MANAGER___.id, function()
    for i = 1, #LEAK_BALLAS do
        stat_set_int(LEAK_BALLAS[i][1], true, LEAK_BALLAS[i][2])
    end
    menu.notify("Ballas Prep selected")
end)
end

do 
local LEAK_STUDIO = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 2044},
    {"FIXER_STORY_COOLDOWN", -1}
}
                        
menu.add_feature("» Agency Studio (Mission)", "action", CONTRACT_MANAGER___.id, function()
    for i = 1, #LEAK_STUDIO do
        stat_set_int(LEAK_STUDIO[i][1], true, LEAK_STUDIO[i][2])
    end
    menu.notify("Studio Mission selected\n\nTo update correctly leave the apartment or change session")
end)
end

do 
local LEAK_FINAL = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 4092},
    {"FIXER_STORY_COOLDOWN", -1}
}
                    
menu.add_feature("» Final Contract: Don't Fuck with Dre", "action", CONTRACT_MANAGER___.id, function()
    for i = 1, #LEAK_FINAL do
        stat_set_int(LEAK_FINAL[i][1], true, LEAK_FINAL[i][2])
    end
    menu.notify("Final Contract selected\n\nTo update correctly leave the apartment or change session")
end)
end

--

menu.add_feature("» Modify Payphone Payment [140K]", "toggle", TH_CONTRACT.id, function(MDFY_P_PAYOUT)
    menu.notify("It only affects you", "", 5, 0x5014B4F0)
    while MDFY_P_PAYOUT.on do
        script.set_global_i(262145+31355,140000)
    system.yield(0)
    end
end)

--[[
    //
menu.add_feature("» Modify Payphone Bonus", "toggle", TH_CONTRACT.id, function(MDFY_PB_PAYOUT)
    menu.notify("It only affects you", "", 5, 0x5014B4F0)
    while MDFY_PB_PAYOUT.on do
        script.set_global_i(262145+31356,140000)
    system.yield(0)
    end
end)
--]]

menu.add_feature("» Modify Final Contract Payout (2.4 Millions)", "toggle", TH_CONTRACT.id, function(MDFY_C_PAYOUT)
    menu.notify("It only affects you", "", 5, 0x5014B4F0)
    while MDFY_C_PAYOUT.on do
        script.set_global_i(262145+31373,2400000)
    system.yield(0)
    end
end)

menu.add_feature("» [EVENT] Modify Final Contract Payout (2.4 Millions)", "toggle", TH_CONTRACT.id, function(MDFY_CE_PAYOUT)
    menu.notify("* It only affects you\n\n* Only use this option when there is a bonus payout event", "", 5, 0x5014B4F0)
    while MDFY_CE_PAYOUT.on do
        script.set_global_i(262145+31373,1600000)
    system.yield(0)
    end
end)

menu.add_feature("» Remove Security Missions/Payphone Cooldown", "toggle", TH_CONTRACT.id, function(CONT_REM_CD)
    while CONT_REM_CD.on do
        script.set_global_i(262145+31329,0)
        script.set_global_i(262145+31407,0)
        script.set_global_i(2720311, 0)
    system.yield(0)
    end
end)

menu.add_feature("» Unlock Dripfed Vehicles (Unreleased Cars)", "toggle", TH_CONTRACT.id, function(_DRIPFED)
    menu.notify("Vehicles once purchased will be in your garage until you decide to sell them\n\nKeep the option active to use them in missions, heists, etc.\n\nIf you deactivate the option, it will be invisible until it is officially released.\n\nThere is no risk of bans!")
    menu.notify("The vehicles are available at car stores")
    while _DRIPFED.on do
    script.set_global_i(262145+31481,1)
    script.set_global_i(262145+31480,1)
    script.set_global_i(262145+31479,1)
    script.set_global_i(262145+31478,1)
    script.set_global_i(262145+31477,1)
    script.set_global_i(262145+31476,1)
    script.set_global_i(262145+31475,1)
    script.set_global_i(262145+31474,1)
    system.yield(0)
end
end)

do
local CONTRACT_COMPLETE = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_BS", -1},
    {"FIXER_STORY_COOLDOWN", -1}
}

menu.add_feature("» Complete all Missions", "action", TH_CONTRACT.id, function()
    for i = 1, #CONTRACT_COMPLETE do
        stat_set_int(CONTRACT_COMPLETE[i][1], true, CONTRACT_COMPLETE[i][2])
    end
        menu.notify("Missions completed!")
end)
end

do
local TH_AWARDS_I = {
    {"AWD_CONTRACTOR", 50},
    {"AWD_COLD_CALLER", 50},
    {"AWD_PRODUCER", 60},
    {"FIXERTELEPHONEHITSCOMPL", 10},
    {"PAYPHONE_BONUS_KILL_METHOD", 10},
    {"FIXER_COUNT", 501},
    {"FIXER_SC_VEH_RECOVERED", 501},
    {"FIXER_SC_VAL_RECOVERED", 501},
    {"FIXER_SC_GANG_TERMINATED", 501},
    {"FIXER_SC_VIP_RESCUED", 501},
    {"FIXER_SC_ASSETS_PROTECTED", 501},
    {"FIXER_SC_EQ_DESTROYED", 501},
    {"FIXER_EARNINGS", 300000}

}
local TH_AWARDS_B = {
    {"AWD_TEEING_OFF", true},
    {"AWD_PARTY_NIGHT", true},
    {"AWD_BILLIONAIRE_GAMES", true},
    {"AWD_HOOD_PASS", true},
    {"AWD_STUDIO_TOUR", true},
    {"AWD_DONT_MESS_DRE", true},
    {"AWD_BACKUP", true},
    {"AWD_SHORTFRANK_1", true},
    {"AWD_SHORTFRANK_2", true},
    {"AWD_SHORTFRANK_3", true},
    {"AWD_CONTR_KILLER", true},
    {"AWD_DOGS_BEST_FRIEND", true},
    {"AWD_MUSIC_STUDIO", true},
    {"AWD_SHORTLAMAR_1", true},
    {"AWD_SHORTLAMAR_2", true},
    {"AWD_SHORTLAMAR_3", true}
}

menu.add_feature("» Unlock Awards + Clothes", "action", TH_CONTRACT.id, function()
    local BL0 = gameplay.get_hash_key(PlayerMP.."_FIXERPSTAT_BOOL0")
    local BL1 = gameplay.get_hash_key(PlayerMP.."_FIXERPSTAT_BOOL1")
    for i=0,128,1 do
        stats.stat_set_masked_bool(BL0, true, i, 1, true) -- True
        stats.stat_set_masked_bool(BL1, true, i, 1, true) -- True
    end
    for i = 1, #TH_AWARDS_I do
        stat_set_int(TH_AWARDS_I[i][1], true, TH_AWARDS_I[i][2])
        end
    for i = 1, #TH_AWARDS_B do
        stat_set_bool(TH_AWARDS_B[i][1], true, TH_AWARDS_B[i][2])
        end
    menu.notify("Awards & Clothes Unlocked", "", 5, 0x5014B4F0)
end)
end


-- TOOLS

-- Vehicle Speed From Zeromenu (Credits for him)
menu.add_feature("» Modify Vehicle Top Speed", "action", TOOLS.id, function()
    local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    local r, s = input.get("Enter a new Speed", "", 9999999, 3)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end
      
    speed = s
    if veh ~= nil then
      if not network.has_control_of_entity(veh) then
        network.request_control_of_entity(veh)  
      end 
      entity.set_entity_max_speed(veh,speed*1000)
      vehicle.modify_vehicle_top_speed(veh,speed)
      vehicle.set_vehicle_engine_torque_multiplier_this_frame(veh,speed)
      entity.get_entity_model_hash(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
    end
    menu.notify("Speed modified to\n" ..speed, "", 5, 0x5014F046)
end)

menu.add_feature("» Weaken all NPCs", "toggle", TOOLS.id, function(_RE)
    while _RE.on do
    for k, PedIA in pairs(ped.get_all_peds()) do
        if not ped.is_ped_a_player(PedIA) then
        weapon.remove_all_ped_weapons(PedIA)
        ped.set_ped_combat_movement(PedIA, 0)
        end
    end
    system.yield(1000)
    end
end)
--[[ This is a concept, works well, but depends in many things
menu.add_feature("» Remove Heli/Boats", "action", TOOLS.id, function()
    for k, DOORs in pairs(vehicle.get_all_vehicles()) do
        local ENT_ENTRY = entity.get_entity_model_hash(DOORs) or vehicle.get_all_vehicle_model_hashes(DOORs)
        local AVG = 2047212121
        local heliA = 2623428164
        local heliB = 745926877
        local boatA = 1448677353
        local truck = 1747439474

    if ENT_ENTRY == AVG or ENT_ENTRY == heliA or ENT_ENTRY == heliB or ENT_ENTRY == boatA or ENT_ENTRY == truck then
          network.request_control_of_entity(DOORs)
          local timer = utils.time_ms() + 500
          while not network.has_control_of_entity(DOORs) and timer > utils.time_ms() do
            system.wait(1500)
          end
          if network.has_control_of_entity(DOORs) then
            entity.set_entity_coords_no_offset(DOORs,v3(671.389,7613.515,-109.629))
          end
      end
    end
end)
--]]

menu.add_feature("» Allow Jobs/Missions on non public lobbies", "toggle", TOOLS.id, function(_mi)
    while _mi.on do
    script.set_global_i(2714627+744, 0) -- NETWORK::NETWORK_SESSION_GET_PRIVATE_SLOTS
    system.yield(0)
    end
    menu.notify("Now you can sell do some jobs/missions in private sessions", "", 5, 0x5014B4F0)
end)

 menu.add_feature("» Silent Mode (No notifications)", "toggle", TOOLS.id, function(quiet)
    while quiet.on do
        menu.clear_all_notifications()
    system.yield(0)
    end
 end)

 menu.add_feature("» Clear notifications", "action", TOOLS.id, function()
        menu.clear_visible_notifications()
 end)

-- Heist Cooldown Reminder
do
local COOLDOWN_REMIND = menu.add_feature("» Heist Cooldown Reminder", "parent", TOOLS.id)

menu.add_feature("» Reminder for Cayo Perico Heist", "action", COOLDOWN_REMIND.id,function(HCR_Cayo)
    menu.notify("Counting down the next 16 minutes\n\nYou can play a different Heist in the meantime\n\nThe cooldown for each Heist is individual", ":: Cayo Perico Heist", 15, 0x64FF78B4) system.wait(60000)
    system.wait(300000) menu.notify("5 minutes have passed\n\nThere are still 10 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: Cayo Perico Heist", 10, 0x64FF78B4)
    system.wait(300000) menu.notify("10 minutes have passed\n\nThere are still 6 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: Cayo Perico Heist", 10, 0x64FF78B4)
    system.wait(360000) menu.notify("16 minutes have passed\n\nThe cooldown is over!!!\n\nNow you can play and get paid again\nEnjoy!", ":: Cayo Perico Heist", 20, 0x6400FF14) 
    return
    menu.notify("Heist Cooldown Reminder has been disabled...", "", 5, 0x64781EF0)
end)

menu.add_feature("» Reminder for Diamond Casino Heist", "action", COOLDOWN_REMIND.id,function(HCR_Casino)
    menu.notify("Counting down the next 16 minutes\n\nYou can play a different Heist in the meantime\n\nThe cooldown for each Heist is individual", ":: Diamond Casino Heist", 15, 0x64FF78B4) system.wait(60000)
    system.wait(300000) menu.notify("5 minutes have passed\n\nThere are still 10 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: Diamond Casino Heist", 10, 0x64FF78B4)
    system.wait(300000) menu.notify("10 minutes have passed\n\nThere are still 6 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: Diamond Casino Heist", 10, 0x64FF78B4)
    system.wait(360000) menu.notify("16 minutes have passed\n\nThe cooldown is over!!!\n\nNow you can play and get paid again\nEnjoy!", ":: Diamond Casino Heist", 20, 0x6400FF14)
    return
    menu.notify("Heist Cooldown Reminder has been disabled...", "", 5, 0x64781EF0)
end)

menu.add_feature("» Reminder for Doomsday Heist", "action", COOLDOWN_REMIND.id,function(HCR_Dooms)
    menu.notify("Counting down the next 16 minutes\n\nYou can play a different Heist in the meantime\n\nThe cooldown for each Heist is individual", ":: Doomsday Heist", 15, 0x64FF78B4) system.wait(60000)
    system.wait(300000) menu.notify("5 minutes have passed\n\nThere are still 10 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: Doomsday Heist", 10, 0x64FF78B4)
    system.wait(300000) menu.notify("10 minutes have passed\n\nThere are still 6 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: Doomsday Heist", 10, 0x64FF78B4)
    system.wait(360000) menu.notify("16 minutes have passed\n\nThe cooldown is over!!!\n\nNow you can play and get paid again\nEnjoy!", ":: Doomsday Heist", 20, 0x6400FF14)
    return
    menu.notify("Heist Cooldown Reminder has been disabled...", "", 5, 0x64781EF0)
end)

menu.add_feature("» Reminder for Classic Heists", "action", COOLDOWN_REMIND.id,function(HCR_Classic)
    menu.notify("Counting down the next 16 minutes\n\nYou can play a different Heist in the meantime\n\nThe cooldown for each Heist is individual", ":: Classic Heists", 15, 0x64FF78B4) system.wait(60000)
    system.wait(300000) menu.notify("5 minutes have passed\n\nThere are still 10 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: Classic Heists", 10, 0x64FF78B4)
    system.wait(300000) menu.notify("10 minutes have passed\n\nThere are still 6 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: Classic Heists", 10, 0x64FF78B4)
    system.wait(360000) menu.notify("16 minutes have passed\n\nThe cooldown is over!!!\n\nNow you can play and get paid again\nEnjoy!", ":: Classic Heists", 20, 0x6400FF14)
    return 
    menu.notify("Heist Cooldown Reminder has been disabled...", "", 5, 0x64781EF0)
end)

menu.add_feature("» Reminder for LS Robbery (Contracts)", "action", COOLDOWN_REMIND.id,function(HCR_LS)
    menu.notify("Counting down the next 17 minutes\n\nYou can play a different Heist in the meantime\n\nThe cooldown for each Heist is individual", ":: LS Robbery - Contracts", 15, 0x64FF78B4) system.wait(60000)
    system.wait(300000) menu.notify("5 minutes have passed\n\nThere are still 10 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: LS Robbery - Contracts", 10, 0x64FF78B4)
    system.wait(300000) menu.notify("10 minutes have passed\n\nThere are still 7 minutes left to finish the cooldown.\n\nYou will receive another notification soon", ":: LS Robbery - Contracts", 10, 0x64FF78B4)
    system.wait(420000) menu.notify("17 minutes have passed\n\nThe cooldown is over!!!\n\nNow you can play and get paid again\nEnjoy!", ":: LS Robbery - Contracts", 20, 0x6400FF14)
    return
    menu.notify("Heist Cooldown Reminder has been disabled...", "", 5, 0x64781EF0)
end)
end

do
menu.add_feature("» Leave Session (Freeze GTA for a moment)", "action", TOOLS.id, function()
    menu.notify("Task completed", "", 3, 0x5000D214)
        local time = utils.time_ms() + 8500
        while time > utils.time_ms() do end
    end)
end