--[[
    Made with hate by Demon Kiya
    https://github.com/DemonKiya/2Take1Script-Revive
]]

if _2t1s then
    print('2Take1Script already loaded!')
    return menu.notify('2Take1Script already loaded!', '2Take1Script Setup', 8, 0x0000FF)
end

_2t1s = "2.5.3"

local paths = {}
paths['PDevs'] = utils.get_appdata_path('PopstarDevs', '')
paths['Menu'] = paths['PDevs'] .. '\\2Take1Menu'
paths['ModdedOutfits'] = paths['Menu'] .. '\\moddedOutfits'
paths['ModdedVehicles'] = paths['Menu'] .. '\\moddedVehicles'
paths['ConfigFolder'] = paths['Menu'] .. '\\cfg'
paths['ScriptsFolder'] = paths['Menu'] .. '\\scripts'
paths['2Take1Script'] = paths['ScriptsFolder'] .. '\\2Take1Script'
paths['ScriptData'] = paths['2Take1Script'] .. '\\Data'
paths['ScriptMapper'] = paths['2Take1Script'] .. '\\Mapper'
paths['ScriptFunctions'] = paths['2Take1Script'] .. '\\Functions'
paths['ScriptLogs'] = paths['2Take1Script'] .. '\\Logs'
paths['ScriptSettings'] = paths['2Take1Script'] .. '\\Settings'
paths['Event-Logger'] = paths['2Take1Script'] .. '\\Event-Logger'

local files = {
    ['MenuMainLog'] = paths['Menu'] .. '\\2Take1Menu.log',
    ['MenuPrepLog'] = paths['Menu'] .. '\\2Take1Prep.log',
    ['MenuNetLog'] = paths['Menu'] .. '\\net_event.log',
    ['MenuNotifLog'] = paths['Menu'] .. '\\notification.log',
    ['MenuPlayerLog'] = paths['Menu'] .. '\\player.log',
    ['MenuScriptLog'] = paths['Menu'] .. '\\script_event.log',
    ['MainLog'] = paths['ScriptLogs'] .. '\\2Take1Script.log',
    ['ChatLog'] = paths['ScriptLogs'] .. '\\Chat.log',
    ['Modder'] = paths['ScriptLogs'] .. '\\Modder.cfg',
    ['Blacklist'] = paths['ScriptLogs'] .. '\\blacklist.cfg',

    ['PlayerInfo'] = paths['ScriptFunctions'] .. '\\PlayerInfo.lua',
    ['Utils'] = paths['ScriptFunctions'] .. '\\Utils.lua',
    ['Math'] = paths['ScriptFunctions'] .. '\\Math.lua',
    ['Spawn'] = paths['ScriptFunctions'] .. '\\Spawn.lua',
    ['Threads'] = paths['ScriptFunctions'] .. '\\Threads.lua',
    ['CustomData'] = paths['ScriptData'] .. '\\CustomData.lua',
    ['StringData'] = paths['ScriptData'] .. '\\StringData.lua',
    ['ScriptEvents'] = paths['ScriptData'] .. '\\ScriptEvents.lua',
    ['Modderflags'] = paths['ScriptData'] .. '\\Modderflags.lua',

    ['NetEventMapper'] = paths['ScriptMapper'] .. '\\NetEventMapper.lua',
    ['ObjectMapper'] = paths['ScriptMapper'] .. '\\ObjectMapper.lua',
    ['VehicleMapper'] = paths['ScriptMapper'] .. '\\VehicleMapper.lua',
    ['PedMapper'] = paths['ScriptMapper'] .. '\\PedMapper.lua',
    ['WeaponMapper'] = paths['ScriptMapper'] .. '\\WeaponMapper.lua',
    ['WorldobjectMapper'] = paths['ScriptMapper'] .. '\\WorldobjectMapper.lua',
    
    ['FakeFriends'] = paths['ConfigFolder'] .. '\\scid.cfg',
    ['DefaultConfig'] = paths['ScriptSettings'] .. '\\Default.ini',
    ['Dev'] = paths['2Take1Script'] .. '\\dev.lua'
}

local settings = {
    ['2Take1Script Parent'] = {Enabled = true},
}
local customflags = require('2Take1Script.Data.Modderflags')

local setup = {}
function setup.Log(Text)
    if not Text then
        return
    end

    local File = io.open(files['MainLog'], 'a')
    io.output(File)
    io.write(Text .. '\n')
    io.close(File)
    print(Text)
end
function setup.main()
    math.randomseed(utils.time_ms())

    if not utils.dir_exists(paths['2Take1Script']) then
        print('2Take1Script folder not found...')
        menu.notify('2Take1Script folder not found...\nRedownload the script and make sure you got everything!', '2Take1Script Setup', 8, 0x0000FF)
        return false

    elseif not utils.dir_exists(paths['ScriptData']) then
        print('2Take1Script/Data folder not found...')
        menu.notify('2Take1Script/Data folder not found...\nRedownload the script and make sure you got everything!', '2Take1Script Setup', 8, 0x0000FF)
        return false

    elseif not utils.dir_exists(paths['ScriptFunctions']) then
        print('2Take1Script/Functions folder not found...')
        menu.notify('2Take1Script/Functions folder not found...\nRedownload the script and make sure you got everything!', '2Take1Script Setup', 8, 0x0000FF)
        return false
        
    elseif not utils.dir_exists(paths['ScriptMapper']) then
        print('2Take1Script/Mapper folder not found...')
        menu.notify('2Take1Script/Mapper folder not found...\nRedownload the script and make sure you got everything!', '2Take1Script Setup', 8, 0x0000FF)
        return false
    end

    local importantfiles = {
        'CustomData',
        'StringData',
        'Modderflags',
        'ScriptEvents',
        'PlayerInfo',
        'Utils',
        'Math',
        'Spawn',
        'Threads',
        'NetEventMapper',
        'ObjectMapper',
        'VehicleMapper',
        'PedMapper',
        'WeaponMapper',
        'WorldobjectMapper'
    }

    local fileError = 0
    for i = 1, #importantfiles do
        if not utils.file_exists(files[importantfiles[i]]) then
            print(importantfiles[i] .. '.lua not found...')
            menu.notify(importantfiles[i] .. '.lua not found...', '2Take1Script Setup', 8, 0x0000FF)
            fileError = fileError + 1
        end
        
    end

    if fileError > 0 then
        return false
    end

    if not utils.dir_exists(paths['ScriptLogs']) then
        utils.make_dir(paths['2Take1Script'] .. "\\Logs")
    end

    if not utils.dir_exists(paths['ScriptSettings']) then
        utils.make_dir(paths['2Take1Script'] .. "\\Settings")
    end

    return true
end

if not setup.main() then
    menu.notify("Failed to load 2Take1Script.", '2Take1Script Setup', 8, 0x0000FF)
    print('Failed to load 2Take1Script.')
    return
end

setup.Log('Loading Modder Flags...')
customflags.Load()
customflags.Load()

local get = require('2Take1Script.Functions.PlayerInfo')
local utility = require('2Take1Script.Functions.Utils')
local Math = require('2Take1Script.Functions.Math')
local Spawn = require('2Take1Script.Functions.Spawn')
local Threads = require('2Take1Script.Functions.Threads')
local customData = require('2Take1Script.Data.CustomData')
local stringData = require('2Take1Script.Data.StringData')
local scriptevent = require('2Take1Script.Data.ScriptEvents')
local mapper = {
    net = require('2Take1Script.Mapper.NetEventMapper'),
    ped = require('2Take1Script.Mapper.PedMapper'),
    veh = require('2Take1Script.Mapper.VehicleMapper'),
    obj = require('2Take1Script.Mapper.ObjectMapper'),
    world = require('2Take1Script.Mapper.WorldObjectMapper'),
    weapons = require('2Take1Script.Mapper.WeaponMapper')
}

local Script = {
    Parent = {},
    Feature = {},
    mainparent = 0,
    playerparent = 0
}

local function NotifColor(Version)
    local NotificationColors = {0x00FF00, 0x00A2FF, 0x0000FF, 0xFF0000, 0x6C3570, 0x0062FF, 0xCCFF00}

    if Script.Feature[Version .. ' Notification Color'] then
        return NotificationColors[Script.Feature[Version .. ' Notification Color'].value + 1]
    else
        return 0x00FF00
    end
end

local function Notify(Text, Version, Header)
    if not Text or not Script.Feature['Enable Script Notifications'].on then
        return
    end

    Header = Header or '2Take1Script'

    local Color = NotifColor(Version)

    menu.notify(Text, Header, Script.Feature['Notification Duration'].value, Color)

    if Script.Feature['Print Scriptlog'].on then
        print('[' .. Header .. '] ' .. Text)
    end
end

local function Log(Text, Prefix)
    local Logging
    if Script.Feature['Enable Script log'] then
        Logging = Script.Feature['Enable Script log'].on
    else
        Logging = true
    end

    if not Text or not Logging then
        return
    end

    Prefix = Prefix or ' '
    utility.write(io.open(files['MainLog'], 'a'), Math.TimePrefix() .. ' ' .. Text)
end

local function IsFakeFriend(ID)
    local FakeFriends = {}

    for Line in io.lines(files['FakeFriends']) do
        local parts = {}
        for part in Line:gmatch("[^:]+") do
            parts[#parts + 1] = part
        end
        if #parts >= 2 then
            local name = parts[1]
            local scid = tonumber(parts[2], 16)
            FakeFriends[scid] = {Name=name}
        end
    end

    if FakeFriends[get.SCID(ID)] then
        return true
    end

    return false
end

function setup.SaveSettings(File)
    if not File then
        File = files['DefaultConfig']
    end
    
    local SafeFiles = io.open(File, 'w+')
    io.output(SafeFiles)

    for Name, Data in pairs(settings) do
        io.write(tostring(Name) .. ':'.. tostring(Data.Enabled) .. ':' .. tostring(Data.Value) .. '\n')
    end

    io.close(SafeFiles)
end

function setup.LoadSettings(File)
    if not File then
        File = files['DefaultConfig']
    end

    for Line in io.lines(File) do
        local Parts = {}
        for Part in Line:gmatch("[^:]+") do
            Parts[#Parts + 1] = Part
        end

        local Name = Parts[1]
        if Script.Feature[Name] then
            if Parts[2] ~= tostring(nil) then
                if Parts[2] == 'true' then
                    Script.Feature[Name].on = true

                elseif Parts[2] == 'false' then
                    Script.Feature[Name].on = false
                end
            end

            if Parts[3] ~= tostring(nil) then
                Script.Feature[Name].value = Parts[3]
            end

        end

    end
end

function setup.Rename(File, OldName, NewName)
    if not File or not OldName or not NewName then
        return
    end

    io.remove(File)

    local NewFile = paths['ScriptSettings'] .. '\\' .. NewName .. '.ini'
    setup.SaveSettings(NewFile)

    Script.Feature['Profile ' .. NewName] = menu.add_feature(NewName, 'action_value_str', Script.Parent['Setting Profiles'], function(f)
        if f.value == 0 then
            setup.SaveSettings(File)

            Log('Settings saved to File.')
            Notify('Settings saved to File.', "Success")

        elseif f.value == 1 then
            setup.LoadSettings(File)

            Log('Settings Successfully Loaded!')
            Notify('Settings Successfully Loaded!', "Success")
            
        elseif f.value == 2 then
            local Name = get.Input('Enter Profile Name', 25, 2, 'Name')

            if not Name then
                Notify('Input canceled.')
                return
            end

            setup.Rename(NewFile, NewName, Name)
        else
            io.remove(NewFile)
            menu.delete_feature(f.id)
        end
    end)
    Script.Feature['Profile ' .. NewName]:set_str_data({'Save', 'Load', 'Rename', 'Delete'})

    menu.delete_feature(Script.Feature['Profile ' .. OldName].id)

    Log('Profile ' .. OldName ..  ' Successfully renamed to ' .. NewName)
    Notify('Profile ' .. OldName ..  ' Successfully renamed to ' .. NewName, "Success")
end

local FeatTypes = {
    ["toggle"] = 1,
    ["slider"] = 7,
    ["value_i"] = 11,
    ["value_str"] = 35,
    ["value_f"] = 131,
    ["action"] = 512,
    ["action_slider"] = 518,
    ["action_value_i"] = 522,
    ["action_value_str"] = 546,
    ["action_value_f"] = 642,
    ["autoaction_slider"] = 1030,
    ["autoaction_value_i"] = 1034,
    ["autoaction_value_str"] = 1058,
    ["autoaction_value_f"] = 1154,
    ["parent"] = 2048,
}
local neon_lights_rgb = {
    {222, 222, 255},
    {2, 21, 255},
    {3, 83, 255},
    {0, 255, 140},
    {94, 255, 1},
    {255, 255, 0},
    {255, 150, 5},
    {255, 62, 0},
    {255, 1, 1},
    {255, 50, 100},
    {255, 5, 190},
    {35, 1, 255},
    {15, 3, 255}
}
local cmds = {
    all = {
        {'cmd_clearwanted', '/clearwanted'},
        {'cmd_giveweapons', '/giveweapons'},
        {'cmd_removeweapons', '/removeweapons <playername>'},
        {'cmd_setbounty', '/setbounty <playername>'},
        {'cmd_explode', '/explode <playername>'},
        {'cmd_trap', '/trap <playername>'},
        {'cmd_kick', '/kick <playername>'},
        {'cmd_crash', '/crash <playername>'},
        {'cmd_spawn', '/spawn <NAME>'},
        {'cmd_vehiclegod', '/vehiclegod <on/off>'},
        {'cmd_upgrade', '/upgrade'},
        {'cmd_repair', '/repair'}
    },
    self = {
        {'cmd_tp', '/tp <playername>'},
        {'cmd_explode_all', '/explodeall'},
        {'cmd_scriptkick_all', '/scriptkickall'},
        {'cmd_desynckick_all', '/desynckickall'},
        {'cmd_crash_all', '/crashall'},
    }
}
local entitys = {
    ['bl_objects'] = {},
    ['peds'] = {},
    ['attach_obj'] = {},
    ['asteroids'] = {},
    ['entity_spam'] = {},
    ['obj_crash'] = {},
    ['Custom Vehicles'] = {},
    ['preview_veh'] = {},
    ['temp_veh'] = {},
    ['shooting'] = {},
    ['chat_veh'] = {},
    ['world_objects'] = {},
    ['bodyguards'] = {},
    ['bodyguards_veh'] = {},
    ['robot_weapon_left'] = {},
    ['robot_weapon_right'] = {}
}
local outfits = {
    ['police_outfit'] = {
        ['female'] = {
            ['clothes'] = {
                {0, 0},
                {0, 6},
                {0, 14},
                {0, 34},
                {0, 0},
                {0, 25},
                {0, 0},
                {0, 35},
                {0, 0},
                {0, 0},
                {0, 48}
            },
            ['props'] = {
                {0, 45, 0},
                {1, 11, 0},
                {2, 4294967295, 0},
                {6, 4294967295, -1},
                {7, 4294967295, -1}
            }
        },
        ['male'] = {
            ['clothes'] = {
                {0, 0},
                {0, 0},
                {0, 0},
                {0, 35},
                {0, 0},
                {0, 25},
                {0, 0},
                {0, 58},
                {0, 0},
                {0, 0},
                {0, 55}
            },
            ['props'] = {
                {0, 46, 0},
                {1, 13, 0},
                {2, 4294967295, 0},
                {6, 4294967295, -1},
                {7, 4294967295, -1}
            }
        }
    },
    ['bac_outfit'] = {
        ['textures'] = {},
        ['clothes'] = {},
        ['prop_text'] = {},
        ['prop_ind'] = {},
        ['gender'] = nil
    },
    ['session_crash'] = {
        ['textures'] = {},
        ['clothes'] = {},
        ['prop_text'] = {},
        ['prop_ind'] = {}
    }
}
local stathashes = {
    ['ceo_earnings'] = {
        {'LIFETIME_BUY_COMPLETE', 2000},
        {'LIFETIME_BUY_UNDERTAKEN', 2000},
        {'LIFETIME_SELL_COMPLETE', 2000},
        {'LIFETIME_SELL_UNDERTAKEN', 2000},
        {'LIFETIME_CONTRA_EARNINGS', 20000000}
    },
    ['mc_earnings'] ={
        {'LIFETIME_BIKER_BUY_COMPLET', 2000},
        {'LIFETIME_BIKER_BUY_UNDERTA', 2000},
        {'LIFETIME_BIKER_SELL_COMPLET', 2000},
        {'LIFETIME_BIKER_SELL_UNDERTA', 2000},
        {'LIFETIME_BIKER_BUY_COMPLET1', 2000},
        {'LIFETIME_BIKER_BUY_UNDERTA1', 2000},
        {'LIFETIME_BIKER_SELL_COMPLET1', 2000},
        {'LIFETIME_BIKER_SELL_UNDERTA1', 2000},
        {'LIFETIME_BIKER_BUY_COMPLET2', 2000},
        {'LIFETIME_BIKER_BUY_UNDERTA2', 2000},
        {'LIFETIME_BIKER_SELL_COMPLET2', 2000},
        {'LIFETIME_BIKER_SELL_UNDERTA2', 2000},
        {'LIFETIME_BIKER_BUY_COMPLET3', 2000},
        {'LIFETIME_BIKER_BUY_UNDERTA3', 2000},
        {'LIFETIME_BIKER_SELL_COMPLET3', 2000},
        {'LIFETIME_BIKER_SELL_UNDERTA3', 2000},
        {'LIFETIME_BIKER_BUY_COMPLET4', 2000},
        {'LIFETIME_BIKER_BUY_UNDERTA4', 2000},
        {'LIFETIME_BIKER_SELL_COMPLET4', 2000},
        {'LIFETIME_BIKER_SELL_UNDERTA4', 2000},
        {'LIFETIME_BIKER_BUY_COMPLET5', 2000},
        {'LIFETIME_BIKER_BUY_UNDERTA5', 2000},
        {'LIFETIME_BIKER_SELL_COMPLET5', 2000},
        {'LIFETIME_BIKER_SELL_UNDERTA5', 2000},
        {'LIFETIME_BKR_SELL_EARNINGS0', 20000000},
        {'LIFETIME_BKR_SELL_EARNINGS1', 20000000},
        {'LIFETIME_BKR_SELL_EARNINGS2', 20000000},
        {'LIFETIME_BKR_SELL_EARNINGS3', 20000000},
        {'LIFETIME_BKR_SELL_EARNINGS4', 20000000},
        {'LIFETIME_BKR_SELL_EARNINGS5', 20000000}
    },
    ['snacks_and_armor'] = {
        {'NO_BOUGHT_YUM_SNACKS', 30},
        {'NO_BOUGHT_HEALTH_SNACKS', 15},
        {'NO_BOUGHT_EPIC_SNACKS', 5},
        {'NUMBER_OF_ORANGE_BOUGHT', 10},
        {'NUMBER_OF_BOURGE_BOUGHT', 10},
        {'NUMBER_OF_CHAMP_BOUGHT', 5},
        {'CIGARETTES_BOUGHT', 20},
        {'MP_CHAR_ARMOUR_1_COUNT', 10},
        {'MP_CHAR_ARMOUR_2_COUNT', 10},
        {'MP_CHAR_ARMOUR_3_COUNT', 10},
        {'MP_CHAR_ARMOUR_4_COUNT', 10},
        {'MP_CHAR_ARMOUR_5_COUNT', 10}
    },
    ['xmas'] = {
        {'MPPLY_XMASLIVERIES0'},
        {'MPPLY_XMASLIVERIES1'},
        {'MPPLY_XMASLIVERIES2'},
        {'MPPLY_XMASLIVERIES3'},
        {'MPPLY_XMASLIVERIES4'},
        {'MPPLY_XMASLIVERIES5'},
        {'MPPLY_XMASLIVERIES6'},
        {'MPPLY_XMASLIVERIES7'},
        {'MPPLY_XMASLIVERIES8'},
        {'MPPLY_XMASLIVERIES9'},
        {'MPPLY_XMASLIVERIES10'},
        {'MPPLY_XMASLIVERIES11'},
        {'MPPLY_XMASLIVERIES12'},
        {'MPPLY_XMASLIVERIES13'},
        {'MPPLY_XMASLIVERIES14'},
        {'MPPLY_XMASLIVERIES15'},
        {'MPPLY_XMASLIVERIES16'},
        {'MPPLY_XMASLIVERIES17'},
        {'MPPLY_XMASLIVERIES18'},
        {'MPPLY_XMASLIVERIES19'},
        {'MPPLY_XMASLIVERIES20'}
    },
    ['kills_deaths'] = {
        'MPPLY_KILLS_PLAYERS',
        'MPPLY_DEATHS_PLAYER'
    },
    ['fast_run'] = {
        'CHAR_FM_ABILITY_1_UNLCK',
        'CHAR_FM_ABILITY_2_UNLCK',
        'CHAR_FM_ABILITY_3_UNLCK',
        'CHAR_ABILITY_1_UNLCK',
        'CHAR_ABILITY_2_UNLCK',
        'CHAR_ABILITY_3_UNLCK'
    },
    ['chc'] = {
        ['misc'] = {
            {'Remove Repeat Cooldown (-1)', 'H3_COMPLETEDPOSIX', 0, -1},
            {'Last Approach Completed (1 2 3)', 'H3_LAST_APPROACH', 0, -1, 3},
            {'Confirm First Board', 'H3OPT_BITSET1', 0, -1},
            {'Confirm Second Board', 'H3OPT_BITSET0', 0, -1}
        },
        ['board1'] = {
            {'1:Silent, 2:BigCon, 3:Aggressive', 'H3OPT_APPROACH', 0, 1, 3, 1},
            {'1:Hard, 2:Difficulty, 3:Approach', 'H3_HARD_APPROACH', 0, 1, 3, 1},
            {'0:Money, 1:Gold, 2:Art, 3:Diamond', 'H3OPT_TARGET', 0, 0, 3, 3},
            {'Unlock Points of Interests', 'H3OPT_POI', 0, 1023},
            {'Unlock Access Points', 'H3OPT_ACCESSPOINTS', 0, 2047}
        },
        ['board2'] = {
            {'1:5%, 2:9%, 3:7%, 4:10%, 5:10%', 'H3OPT_CREWWEAP', 0, 1, 5, 1},
            {'1:5%, 2:7%, 3:9%, 4:6%, 5:10%', 'H3OPT_CREWDRIVER', 0, 1, 5, 1},
            {'1:3%, 2:7%, 3:5%, 4:10%, 5:9%', 'H3OPT_CREWHACKER', 0, 1, 5, 1},
            {'Weapon Variation (0 1)', 'H3OPT_WEAPS', 0, 0, 1},
            {'Vehicle Variation (0 1 2 3)', 'H3OPT_VEHS', 0, 0, 3},
            {'Remove Duggan Heavy Guards', 'H3OPT_DISRUPTSHIP', 0, 3},
            {'Equip Heavy Armor', 'H3OPT_BODYARMORLVL', 0, 3},
            {'Scan Card Level', 'H3OPT_KEYLEVELS', 0, 2},
            {'Mask Variation (0 till 12)', 'H3OPT_MASKS', 0, 0, 12}
        }
    },
    ['perico'] = {
        {'Unlock Points of Interests', 'H4CNF_BS_GEN', 0, 131071},
        {'Redoubt Entry Points', 'H4CNF_BS_ENTR', 0, 63},
        {'Unlock Support Team', 'H4CNF_BS_ABIL', 0, 63},
        {'Weapon Variation', 'H4CNF_WEAPONS', 0, 1, 5, 5},
        {'Disruption - Unmarked Weapon', 'H4CNF_WEP_DISRP', 0, 3},
        {'Disruption - Armor Disruption', 'H4CNF_ARM_DISRP', 0, 3},
        {'Disruption - Air Support', 'H4CNF_HEL_DISRP', 0, 3},
        {'Primary Target', 'H4CNF_TARGET', 0, 1, 5, 5},
        {'Truck - Spawn Place', 'H4CNF_TROJAN', 0, 1, 5, 3},
        {'Infiltration - Escape Points', 'H4CNF_APPROACH', 0, -1},
        {'Set Missions as completed', 'H4_MISSIONS', 0, 65535},
        {'Set Difficulty (Normal or Hard)', 'H4_PROGRESS', 0, 126823, 130667},
        {'Gold Inside  Compound', 'H4LOOT_GOLD_C_SCOPED', 0, 192, 255},
        {'Paint Inside  Compound', 'H4LOOT_PAINT_SCOPED', 0, 120, 127},
        {'Gold_C Loot Price', 'H4LOOT_GOLD_C', 0, 192, 255},
        {'Gold_V Loot Price', 'H4LOOT_GOLD_V', 0, 471000, 126000, 1373000, 1598000},
        {'Paint Loot Price', 'H4LOOT_PAINT', 0, 120, 127},
        {'Paint_V Loot Price', 'H4LOOT_PAINT_V', 0, 353000, 948000, 1030000, 1198000}
    }
}

local modder_player = {}
modder_player[1] = true
local modder_scids = {}
local random_colors = {'Random Primary Color', 'Random Secondary Color', 'Random Pearlescent Color', 'Random Neon Color', 'Random Smoke Color', 'Random Xenon Color', 'Random Wheel Color'}
local rainbow_colors = {'Rainbow Primary Color', 'Rainbow Secondary Color', 'Rainbow Pearlescent Color', 'Rainbow Neon Color', 'Rainbow Smoke Color', 'Rainbow Xenon Color', 'Rainbow Wheel Color'}
local offset_height, config_preview, offset_distance = 0, false, 0
local rot_veh = v3()
local hash_c = nil
local inputs = {license_plate = nil, sms_spam = nil, player_sms_spam = nil, chat_spam = nil, custom_explosion = nil, lobby_bounty = nil, player_bounty = nil, explosion_blame = 0}
local antispam = {}
local playerlogging = {}
local playerblamekill = {}
local hooks = {script = {}, net = {}}
local model_gun, apply_invisible, balll, OceanEntity, HeightEntity, FixedHeight
local robot_objects = {}
local ptfxs = { ['flamethrower'] = nil, ['flamethrower_green'] = nil, ['alien'] = nil, ['fire_circle'] = {}, ['fire_balls'] = {}, ['fire_ass'] = nil, ['fire_ass_ball'] = nil }
local miscdata = {
    fakeinvites = {'Yacht', 'Office', 'Clubhouse', 'Office Garage', 'Tuning Workshop', 'Apartment'},
    ceomoney = {
        {'10K Work Payout', 10000, -1292453789, 0, 120000},
        {'10K Special Cargo', 10000, -1292453789, 1, 60000},
        {'10K Vehicle Cargo', 10000, 4213353345, 1, 60000},
        {'30K Cargo', 30000, 198210293, 1, 120000},
    },
    hudcomponents = {
        {'Wanted Stars', 1}, {'Bank Money', 3}, {'Wallet Money', 4}, {'Vehicle Name', 6}, {'Area Name', 7},
        {'Street Name', 9}, {'Weapon Wheel', 19}, {'Weapon Wheel Stats', 20}, {'Radio Stations', 16}, {'Aim Dot', 14}
    },
    ramps = {
        2934970695,
        3233397978,
        1290523964,
        versions = {
            {'Front', v3(0, 6, 0.2), v3(0, 0, 180)},
            {'Back', v3(0, -6, 0.2), v3(0, 0, 0)},
            {'Left', v3(-5, 0, 0.2), v3(0, 0, 270)},
            {'Right', v3(5, 0, 0.2), v3(0, 0, 90)}
        }
    },
    VehicleCategories = {
        'Compacts', 'Sedans', 'SUVs', 'Coupes', 'Muscle', 'Sports Classics', 'Sports', 'Super', 'Motorcycles',
        'Off-Road', 'Industrial', 'Utility', 'Vans', 'Cycles', 'Boats', 'Helicopters', 'Planes', 'Service',
        'Emergency', 'Military', 'Commercial', 'Open Wheel'
    },
    Animals = {
        Ground = {
            {Hash=0x61D4C771, Name="Bigfoot"},
            {Hash=0xAD340F5A, Name="Bigfoot 2"},
            {Hash=0xCE5FF074, Name="Boar"},
            {Hash=0x573201B8, Name="Cat"},
            {Hash=0xA8683715, Name="Chimp"},
            {Hash=0x14EC17EA, Name="Chop"},
            {Hash=0xFCFA9E1E, Name="Cow"},
            {Hash=0x644AC75E, Name="Coyote"},
            {Hash=0xD86B5A95, Name="Deer"},
            {Hash=0x431FC24C, Name="German Shepherd"},
            {Hash=0x6AF51FAF, Name="Hen"},
            {Hash=0x4E8F95A2, Name="Husky"},
            {Hash=0x1250D7BA, Name="Mountain Lion"},
            {Hash=0xE71D5E68, Name="Panther"},
            {Hash=0xB11BAB56, Name="Pig"},
            {Hash=0x431D501C, Name="Poodle"},
            {Hash=0x6D362854, Name="Pug"},
            {Hash=0xDFB55C81, Name="Rabbit"},
            {Hash=0xC3B52966, Name="Rat"},
            {Hash=0x349F33E1, Name="Golden Retriever"},
            {Hash=0xC2D06F53, Name="Rhesus"},
            {Hash=0x9563221D, Name="Rottweiler"},
            {Hash=0xAD7844BB, Name="Westy"}
        },
        Water = {
            {Hash=0x8BBAB455, Name="Dolphin"},
            {Hash=0x2FD800B7, Name="Fish"},
            {Hash=0x3C831724, Name="Hammershark"},
            {Hash=0x471BE4B2, Name="Humpback"},
            {Hash=0x8D8AC8B9, Name="Killerwhale"},
            {Hash=0x06C3F072, Name="Shark"},
            {Hash=0xA148614D, Name="Stingray"}
        },
        Air = {
            {Hash=0x56E29962, Name="Cormorant"},
            {Hash=0xAAB71F62, Name="Chickenhawk"},
            {Hash=0x18012A9F, Name="Crow"},
            {Hash=0x06A20728, Name="Pigeon"},
            {Hash=0xD3939DFD, Name="Seagull"}
        },
        Standard = {
            {Hash=0x9B22DBAF, Name="Franklin"},
            {Hash=0x0D7114C9, Name="Michael"},
            {Hash=0x9B810FA2, Name="Trevor"},
            {Hash=0x9C9EFFD8, Name="MP Female"},
            {Hash=0x705E61F2, Name="MP Male"}
        }
    }
}

local function Exclude()
    return Script.Feature['Exclude Friends'].on
end

local function Playercount()
    local players = 0
    for i = 0, 31 do
        if player.is_player_valid(i) then
            players = players + 1
        end
    end

    return players
end

local function Randomize(Table)
    for i = #Table, 2, -1 do
        local j = math.random(i)
        Table[i], Table[j] = Table[j], Table[i]
    end
    
    return Table
end

local function change_model(hash, water, isinvisible, isdown)
    if not Script.Feature['Safe Model Change'].on or (Script.Feature['Safe Model Change'].on and not ped.is_ped_in_any_vehicle(get.OwnPed())
    and (water and entity.is_entity_in_water(get.OwnPed()) or (not water and not entity.is_entity_in_water(get.OwnPed())))) then
        if isdown then
            utility.tp(get.OwnCoords(), 1.5)
        end
        utility.request_model(hash)
        player.set_player_model(hash)
        streaming.set_model_as_no_longer_needed(hash)
        if isinvisible then
            coroutine.yield(0)
            ped.set_ped_component_variation(get.OwnPed(), 4, 0, 0, 2)
        end
        if Script.Feature['Revert Outfit'].on then
            if hash == 0x9C9EFFD8 or hash == 0x705E61F2 then
                local gender = 'male'
                if player.is_player_female(player.player_id()) then
                    gender = 'female'
                end
                if outfits['bac_outfit']['gender'] == gender then
                    local h_clothes = outfits['bac_outfit']['clothes']
                    local h_textures = outfits['bac_outfit']['textures']
                    for y = 1, 11 do
                        ped.set_ped_component_variation(get.OwnPed(), y, h_clothes[y], h_textures[y], 2)
                    end
                    local loop = {0, 1, 2, 6, 7}
                    local h_prop_ind = outfits['bac_outfit']['prop_ind']
                    local h_prop_text = outfits['bac_outfit']['prop_text']
                    for z = 1, #loop do
                        ped.set_ped_prop_index(get.OwnPed(), loop[z], h_prop_ind[z], h_prop_text[z], 0)
                    end
                end
            end
        end
    else
        Notify('Model Change not possible!', "Error")
    end
end

local function kick_player(ID, Friendcheck)
    Friendcheck = Friendcheck or false

    if utility.valid_player(ID, Friendcheck) then
        scriptevent.kick(ID, 2)
        scriptevent.kick(ID, 1)
        scriptevent.kick(ID, 3)

    end
end

local function ToggleOff(Features)
    for i = 1, #Features do
        if Script.Feature[Features[i]] and Script.Feature[Features[i]].on then
            Script.Feature[Features[i]].on = false
        end

    end
end

local function IsEntitled(Player, Target, Command)
    local Name = get.Name(Player)
    local SCID = get.SCID(Player)
    Log('Detected Chat-Command ' .. Command .. ' from Player ' .. Name .. ' [' .. get.SCID(Player) .. ']')

    if Script.Feature['Enable Commands'].value == 0 or (Script.Feature['Enable Commands'].value == 1 and player.is_player_friend(Player)) or (Player == player.player_id()) then
        
        if not Target then
            Log('Executing Chat Command "' .. Command .. '" for Player "' .. Name .. '"')
            Notify('Executed Command: ' .. Command .. '\nPlayer: ' .. Name, "Neutral", '2Take1Script Chat Commands')
            return true, nil
        end

        local TargetID = utility.id_from_name(Target)
        local TargetName = get.Name(TargetID)
 
        if not player.is_player_valid(TargetID) then
            Log('Target doesnt exist')
            return false
        end

        if (TargetID == player.player_id() and Player ~= player.player_id()) then
            Log('Blocking Chat Command "' .. Command .. '" for Player "' .. Name .. '" with you as Target')
            Notify('Blocked Command: ' .. Command .. '\nPlayer: ' .. Name .. '\nTarget: You', "Neutral", '2Take1Script Chat Commands')
            return false

        elseif (player.is_player_friend(TargetID) and Script.Feature['Block Friends as Target'].on and Player ~= player.player_id()) then
            Log('Blocking Chat Command "' .. Command .. '" for Player "' .. Name .. '" with a Friend as Target')
            Notify('Blocked Command: ' .. Command .. '\nPlayer: ' .. Name .. '\nTarget: "' .. get.Name(TargetID) .. '" (Friend)', "Neutral", '2Take1Script Chat Commands')
            return false

        else
            Log('Executing Chat Command "' .. Command .. '" for Player "' .. Name .. '" on Target: "' .. get.Name(TargetID) .. '"')
            Notify('Executed Command: ' .. Command .. '\nPlayer: ' .. Name .. '\nTarget: "' .. get.Name(TargetID) .. '"', "Neutral", '2Take1Script Chat Commands')
            return true, TargetID
        end

    end
    return false
end

local function BlockArea(Feature)
	assert(Feature.data, "Feature needs data object with area information.")
	
	Log("Blocking Area.")
	
	for i=1,#Feature.data.Objects do
		local Object = Feature.data.Objects[i]
		
		local ent = Spawn.Object(Object.Hash)
		entitys["bl_objects"][#entitys["bl_objects"] + 1] = ent
		
		local pos = Object.Position
		if Object.Position2 then
			pos.x = math.random(pos.x, Object.Position2.x)
			pos.y = math.random(pos.y, Object.Position2.y)
			pos.z = math.random(pos.z, Object.Position2.z)
		end
		utility.set_coords(ent, pos)
		
		entity.set_entity_rotation(ent, Object.Rotation)
		
		if Object.Freeze then
			entity.freeze_entity(ent, true)
		end
		
		if Object.Invisible then
			entity.set_entity_visible(ent, false)
		end
	end
	
	if Script.Feature["Teleport to Block"].on then
		utility.tp(Feature.data.Teleport, nil, Feature.data.Heading)
	end
	
	Log("Blocking Done.")
end

local function fix_crash_screen()
    if not hash_c then
        return
    end
    change_model(hash_c)
    coroutine.yield(250)
    ped.set_ped_health(get.OwnPed(), 0)
    coroutine.yield(3500)
    local clothes = outfits['session_crash']['clothes']
    local textures = outfits['session_crash']['textures']
    for i = 1, 11 do
        ped.set_ped_component_variation(get.OwnPed(), i, clothes[i], textures[i], 2)
    end
    local loop = {0, 1, 2, 6, 7}
    local h_prop_ind = outfits['session_crash']['prop_ind']
    local h_prop_text = outfits['session_crash']['prop_text']
    for z = 1, #loop do
        ped.set_ped_prop_index(get.OwnPed(), loop[z], h_prop_ind[z], h_prop_text[z], 0)
    end
end

local function clear_legs_movement()
    local left = robot_objects['llbone']
    local right = robot_objects['rlbone']
    local main = robot_objects['tampa']
    local offsetL = v3(-4.25, 0, 12.5)
    local offsetR = v3(4.25, 0, 12.5)
    if left and right and main then
        if entity.is_an_entity(left) and entity.is_an_entity(right) and entity.is_an_entity(main) then
            utility.request_ctrl(left)
            utility.request_ctrl(right)
            utility.request_ctrl(main)
            entity.attach_entity_to_entity(left, main, 0, offsetL, v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            entity.attach_entity_to_entity(right, main, 0, offsetR, v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
        end
    end
end

local function spawn_custom_vehicle(data, place)
    Log('Attempt to spawn Custom Vehicle.')
    menu.set_menu_can_navigate(false)
    local temp_veh = {}
    local pos = v3()
    local rot = v3()
    local BONE_ID = 0
    local attach_to = 0
    local heading = 0
    local skip_upg = false
    local cur_veh = get.OwnVehicle()

    if Script.Feature['Custom Vehicles Preview'].on and entitys['preview_veh'][1] then
        utility.clear(entitys['preview_veh'])
        entitys['preview_veh'] = {}
        config_preview = false
        coroutine.yield(250)
    end

    for i = 1, #data[1] do
        utility.request_model(data[1][i], 7500)
    end

    for i = 2, #data do
        pos = get.OwnCoords()

        if data[i][6] and i == 2 then
            pos.z = pos.z + data[i][6]
        end

        if i > 2 then
            pos.z = pos.z + 25
        end

        if Script.Feature['Use Own Vehicles'].on and i == 2 and entity.get_entity_model_hash(cur_veh) == data[i][1] or data[2][1] == 0 and i == 2 and Script.Feature['Use Own Vehicles'].on and cur_veh ~= 0 then
            Log('Detected Own Vehicle, using it.')
            temp_veh[i - 1] = cur_veh
            skip_upg = true

        elseif data[2][1] == 0 and not Script.Feature['Use Own Vehicles'].on then
            Log('Failed at spawning Custom Vehicle.')
            Notify('No Vehicle found, get in a valid Vehicle', "Error")
            menu.set_menu_can_navigate(true)
            return

        else
            if streaming.is_model_a_vehicle(data[i][1]) then
                if i == 2 then
                    heading = get.OwnHeading()

                    if data[i][11] then
                        offset_distance = data[i][11]
                    else
                        offset_distance = 5
                    end

                    if data[i][12] then
                        offset_height = data[i][12]
                    else
                        offset_height = 1
                    end

                    pos = utility.OffsetCoords(pos, heading, offset_distance)
                end

                temp_veh[i - 1] = Spawn.Vehicle(data[i][1], pos, heading)
                decorator.decor_set_int(temp_veh[i - 1], 'MPBitset', 1 << 10)

                local color = math.random(0, 16777215)
                if data[i][4] then
                    color = data[i][4][1]
                end

                vehicle.set_vehicle_custom_primary_colour(temp_veh[i - 1], color)
                if data[i][4] then
                    color = data[i][4][2]
                end

                vehicle.set_vehicle_custom_secondary_colour(temp_veh[i - 1], color)
                if data[i][4] then
                    color = data[i][4][3]
                end

                vehicle.set_vehicle_custom_pearlescent_colour(temp_veh[i - 1], color)
                if data[i][4] then
                    color = data[i][4][4]
                end

                vehicle.set_vehicle_custom_wheel_colour(temp_veh[i - 1], color)
                color = math.random(0, 4)
                if data[i][4] then
                    color = data[i][4][5]
                end

                vehicle.set_vehicle_window_tint(temp_veh[i - 1], color)
                if streaming.is_model_a_plane(data[i][1]) and i > 2 then
                    vehicle.control_landing_gear(temp_veh[i - 1], 3)
                end
            else
                temp_veh[i - 1] = Spawn.Object(data[i][1], pos)
            end
        end

        if i > 2 then
            pos.z = pos.z - 25
        end

        if Script.Feature['Custom Vehicles Godmode'].on then
            entity.set_entity_god_mode(temp_veh[i - 1], true)
        end

        if data[i][5] then
            entity.set_entity_visible(temp_veh[i - 1], false)
        end

        if data[i][13] then
            entity.set_entity_alpha(temp_veh[i - 1], data[i][13], false)
        end

        if i > 2 then
            BONE_ID = 0
            if data[i][7] then
                BONE_ID = data[i][7]
            end

            attach_to = temp_veh[1]
            if data[i][8] then
                attach_to = temp_veh[data[i][8]]
            end

            local set_collision = data[i][10]
            if set_collision then
                entity.set_entity_collision(temp_veh[i - 1], false, false, false)
            else
                set_collision = false
            end

            pos = v3()
            if data[i][2] then
                pos = v3(data[i][2][1], data[i][2][2], data[i][2][3])
            end

            rot = v3()
            if data[i][3] then
                rot = v3(data[i][3][1], data[i][3][2], data[i][3][3])
            end

            if data[i][1] ~= 0 then
                entity.attach_entity_to_entity(temp_veh[i - 1], attach_to, BONE_ID, pos, rot, false, not set_collision, false, 2, true)
            end

            if data[i][9] then
                local spawned_ped
                pos = get.OwnCoords()
                spawned_ped = Spawn.Ped(data[i][9], pos)
                coroutine.yield(0)

                if Script.Feature['Custom Vehicles Godmode'].on then
                    ped.set_ped_max_health(spawned_ped, 25000000.0)
                    ped.set_ped_health(spawned_ped, 25000000.0)
                    ped.set_ped_can_ragdoll(spawned_ped, false)
                    entity.set_entity_god_mode(spawned_ped, true)
                end

                streaming.set_model_as_no_longer_needed(data[i][9])

                if data[i][1] ~= 0 then
                    ped.set_ped_into_vehicle(spawned_ped, temp_veh[i - 1], -1)
                    vehicle.set_vehicle_doors_locked(temp_veh[i - 1], 2)

                else
                    pos = v3()
                    if data[i][2] then
                        pos = v3(data[i][2][1], data[i][2][2], data[i][2][3])
                    end

                    rot = v3()
                    if data[i][3] then
                        rot = v3(data[i][3][1], data[i][3][2], data[i][3][3])
                    end

                    entity.attach_entity_to_entity(spawned_ped, attach_to, BONE_ID, pos, rot, false, not set_collision, true, 2, true)
                end

            end

        end

        if Script.Feature['Custom Vehicles Preview'].on then
            entitys['preview_veh'][#entitys['preview_veh'] + 1] = temp_veh[i - 1]

        elseif place then
            entitys[place][#entitys[place] + 1] = temp_veh[i - 1]

        else
            entitys['Custom Vehicles'][#entitys['Custom Vehicles'] + 1] = temp_veh[i - 1]
        end
    end

    if not Script.Feature['Custom Vehicles Preview'].on then
        if Script.Feature['Spawn in Custom Vehicle'].on then
            ped.set_ped_into_vehicle(get.OwnPed(), temp_veh[1], -1)
            vehicle.set_vehicle_engine_on(temp_veh[1], true, true, false)
        end
    end

    if not skip_upg then
        utility.MaxVehicle(temp_veh[1], 2)
    end

    menu.set_menu_can_navigate(true)
    Log('Spawn Custom Vehicle Done.')
end

local streetwar = {}
streetwar.targets = {}
function streetwar.spawnped()
    if #ped.get_all_peds() > 100 then
        coroutine.yield(1000)
        return
    end

    local peds = {3502104854, 32417469, 1146800212, 2557996913, 933092024, 920595805}

    local coords = get.OwnCoords() + v3(math.random(-50, 50), math.random(-50, 50), 0)
    coords.z = Math.GetGroundZ(coords.x, coords.y)

    local Ped = Spawn.Ped(peds[math.random(#peds)], coords)
    menu.create_thread(streetwar.setup, {Ped, ped.get_all_peds()})

    coroutine.yield(500)
end
function streetwar.setup(Data)
    local Ped = Data[1]
    local Targetpool = Data[2]
    utility.request_ctrl(Ped)
    
    -- check if ped is dead
    if entity.is_entity_dead(Ped) and streetwar.targets[Ped] then
        coroutine.yield(500)
        utility.clear(Ped)
        return
    end
    coroutine.yield(200)

    -- check if peds target is dead
    if streetwar.targets[Ped] and entity.is_entity_dead(streetwar.targets[Ped]) then
        utility.clear(streetwar.targets[Ped])
        streetwar.targets[Ped] = nil
    end
    coroutine.yield(200)

    -- kick from ground vehicle
    if ped.get_vehicle_ped_is_using(Ped) ~= 0 then
        local hash = entity.get_entity_model_hash(ped.get_vehicle_ped_is_using(Ped))
        if streaming.is_model_a_car(hash) or streaming.is_model_a_bike(hash) then
            utility.request_ctrl(ped.get_vehicle_ped_is_using(Ped))
            entity.set_entity_velocity(ped.get_vehicle_ped_is_using(Ped), v3())
            ped.clear_ped_tasks_immediately(Ped)
        end
    end
    coroutine.yield(200)

    -- give ped a weapon
    if not weapon.has_ped_got_weapon(Ped, 0xC78D71B4) then
        weapon.give_delayed_weapon_to_ped(Ped, 0xC78D71B4, 0, 0)
        weapon.set_ped_ammo(Ped, 0xC78D71B4, 9999)
        entity.set_entity_as_mission_entity(Ped, true, true)
    end
    coroutine.yield(200)

    -- acquire new target
    if not streetwar.targets[Ped] or streetwar.targets[Ped] == 0 then
        streetwar.targets[Ped] = Targetpool[math.random(#Targetpool)]

        while streetwar.targets[Ped] == get.OwnPed() or streetwar.targets[Ped] == Ped or entity.is_entity_dead(streetwar.targets[Ped]) do
            streetwar.targets[Ped] = Targetpool[math.random(#Targetpool)]
            coroutine.yield(0)
        end

        ai.task_combat_ped(Ped, streetwar.targets[Ped], 0, 16)
    end
    coroutine.yield(200)

    ped.set_ped_combat_attributes(Ped, 46, true)
    ped.set_ped_combat_attributes(Ped, 17, true)
    ped.set_ped_combat_attributes(Ped, 5, true)
    ped.set_ped_combat_ability(Ped, 100)
    ped.set_ped_combat_range(Ped, 2)
end

local chatevents = {}
function chatevents.LogChat(args)
    if not args.player or not args.body then
        return
    end

    utility.write(io.open(files['ChatLog'], 'a'), Math.TimePrefix() .. ' ' .. get.Name(args.player) .. ' [' .. get.SCID(args.player) .. ']: ' .. args.body)
end

function chatevents.PrintChat(args)
    if not args.player or not args.body then
        return
    end

    print('[Chat] ' .. get.Name(args.player) .. ' [' .. get.SCID(args.player) .. "]: '" .. args.body .. "'")
end

function chatevents.AntiChatSpam(args)
    if not args.player or not args.body then
        return
    end

    if #antispam > 128 then
        antispam = {}
        Log('Cleared Spam-Detection.')
    end

    if utility.valid_player(args.player, Script.Feature['Exclude Friends'].on) then
        local scid = get.SCID(args.player)
        if not antispam[scid] then
            antispam[scid] = {}
        end

        if #antispam[scid] >= 2 then
            table.remove(antispam[scid], 1)
        end

        if #antispam[scid] > 1 then
            local msg1 = antispam[scid][1][2]
            local msg2 = antispam[scid][2][2]
            local diff = antispam[scid][2][1] - antispam[scid][1][1]

            if (msg1 == msg2 and diff < 1250) or diff < 334 then
                if Script.Feature['Anti Chat Spam'].value == 0 then
                    Notify('Player: ' .. get.Name(args.player) .. '\nReason: Chat Spam\nReaction: Script Kick', "Neutral", '2Take1Script Automod')
                    kick_player(args.player)

                elseif Script.Feature['Anti Chat Spam'].value == 1 then
                    Notify('Player: ' .. get.Name(args.player) .. '\nReason: Chat Spam\nReaction: Desync Kick', "Neutral", '2Take1Script Automod')
                    network.force_remove_player(args.player)

                else
                    Notify('Player: ' .. get.Name(args.player) .. '\nReason: Chat Spam\nReaction: Crash', "Neutral", '2Take1Script Automod')
                    scriptevent.crash(args.player)
                end

                Log("Detected " .. get.Name(args.player) .. " spamming! Time between last 2 MSGs was " .. diff .. "ms and wrote these two MSG:\n'" .. msg1 .. "' and '" .. msg2 .. "'")
            end
        end
    end
end

function chatevents.PunishRussian(args)
    if not args.player or not args.body then
        return
    end
    if utility.valid_player(args.player, Script.Feature['Exclude Friends'].on) then
        for i = 1, #stringData.russian_characters do
            if string.find(args.body, stringData.russian_characters[i], 1) then
                if Script.Feature['GEO-Block Russia'].value == 0 then
                    kick_player(args.player)
                    Log('Player: ' .. get.Name(args.player) .. '\nReason: Talking Russian\nReaction: Script Kick\nDetected String: ' .. stringData.russian_characters[i])
                    Notify('Player: ' .. get.Name(args.player) .. '\nReason: Talking Russian\nReaction: Script Kick', "Neutral", '2Take1Script Automod')
                elseif Script.Feature['GEO-Block Russia'].value == 1 then
                    network.force_remove_player(args.player)
                    Log('Player: ' .. get.Name(args.player) .. '\nReason: Talking Russian\nReaction: Desync Kick\nDetected String: ' .. stringData.russian_characters[i])
                    Notify('Player: ' .. get.Name(args.player) .. '\nReason: Talking Russian\nReaction: Desync Kick', "Neutral", '2Take1Script Automod')
                elseif Script.Feature['GEO-Block Russia'].value == 2 then
                    scriptevent.crash(args.player)
                    Log('Player: ' .. get.Name(args.player) .. '\nReason: Talking Russian\nReaction: Script Crash\nDetected String: ' .. stringData.russian_characters[i])
                    Notify('Player: ' .. get.Name(args.player) .. '\nReason: Talking Russian\nReaction: Script Crash', "Neutral", '2Take1Script Automod')
                end
                return
            end
        end
    end
end

function chatevents.PunishChinese(args)
    if not args.player or not args.body then
        return
    end
    if utility.valid_player(args.player, Script.Feature['Exclude Friends'].on) then
        for i = 1, #stringData.chinese_characters do
            if string.find(args.body, stringData.chinese_characters[i], 1) then
                if Script.Feature['GEO-Block China'].value == 0 then
                    kick_player(args.player)
                    Log('Player: ' .. get.Name(args.player) .. '\nReason: Talking Chinese\nReaction: Script Kick\nDetected String: ' .. stringData.chinese_characters[i])
                    Notify('Player: ' .. get.Name(args.player) .. '\nReason: Talking Chinese\nReaction: Script Kick', "Neutral", '2Take1Script Automod')
                elseif Script.Feature['GEO-Block China'].value == 1 then
                    network.force_remove_player(args.player)
                    Log('Player: ' .. get.Name(args.player) .. '\nReason: Talking Chinese\nReaction: Desync Kick\nDetected String: ' .. stringData.chinese_characters[i])
                    Notify('Player: ' .. get.Name(args.player) .. '\nReason: Talking Chinese\nReaction: Desync Kick', "Neutral", '2Take1Script Automod')
                elseif Script.Feature['GEO-Block China'].value == 2 then
                    scriptevent.crash(args.player)
                    Log('Player: ' .. get.Name(args.player) .. '\nReason: Talking Chinese\nReaction: Script Crash\nDetected String: ' .. stringData.chinese_characters[i])
                    Notify('Player: ' .. get.Name(args.player) .. '\nReason: Talking Chinese\nReaction: Script Crash', "Neutral", '2Take1Script Automod')
                end
                return
            end
        end
    end
end

function chatevents.DetectByMessage(args)
    if not args.player or not args.body then
        return
    end
    if utility.valid_player(args.player, Script.Feature['Exclude Friends'].on) then
        local detected = false
        local dtcstring
        local stringset = stringData.ChatStrings.Safe
        if Script.Feature['Ad Blacklist Chat Strings'].value == 1 then
            stringset = stringData.ChatStrings.Aggressive
        end
        for i = 1, #stringset do
            if string.find(args.body:lower(), stringset[i], 1, true) then
                dtcstring = stringset[i]
                detected = true
            end
        end
        if detected then
            if not Script.Feature['Ad Blacklist Disable Notifications'].on then
                Notify('Player: ' .. get.Name(args.player) .. '\nReason: Chat Blacklist\nReaction: Kick', "Neutral", '2Take1Script Automod')
            end
            Log('Player: ' .. get.Name(args.player) .. '\nReason: Chat Blacklist\nReaction: Kick\nDetails: ' .. dtcstring, '[Automod]')
            if Script.Feature['Ad Blacklist Fake Friends'].on then
                if IsFakeFriend(args.player) then
                    Log('Player already exists in Blacklist')
                else
                    utility.write(io.open(files['FakeFriends'], 'a'), get.Name(args.player) .. ':' .. Math.DecToHex(get.SCID(args.player)) .. ":c")
                end
            end
            if Script.Feature['Ad Blacklist Kick Type'].value == 0 then
                kick_player(args.player)
            else
                network.force_remove_player(args.player)
            end
            detected = false
        end
    end
end

function chatevents.ChatCommands(args)
    if not args.player or not args.body then
        return
    end

    local id = args.player
    local text = args.body

    if Script.Feature['cmd_clearwanted'].on and string.find(text, '/clearwanted', 1) then
        local entitled, pl_id = IsEntitled(id, nil, 'Clear Wanted')

        if entitled then
            scriptevent.Send('Remove Wanted', {player.player_id(), scriptevent.MainGlobal(id)}, id)
        end
    end

    if Script.Feature['cmd_giveweapons'].on and string.find(text, '/giveweapons', 1) then
        local entitled, pl_id = IsEntitled(id, nil, 'Give Weapons')

        if entitled then
            local all_weapons = weapon.get_all_weapon_hashes()
            for i = 1, #all_weapons do
                if not weapon.has_ped_got_weapon(get.PlayerPed(id), all_weapons[i]) then
                    weapon.give_delayed_weapon_to_ped(get.PlayerPed(id), all_weapons[i], 0, 0)
                end
            end
        end
    end

    if Script.Feature['cmd_removeweapons'].on and string.find(text, '/removeweapons ', 1) then
        text = string.gsub(text, '/removeweapons ', '')
        local entitled, pl_id = IsEntitled(id, text, 'Remove Weapons')

        if entitled then
            weapon.remove_all_ped_weapons(get.PlayerPed(pl_id))
        end
    end

    if Script.Feature['cmd_setbounty'].on and string.find(text, '/setbounty ', 1) then
        text = string.gsub(text, '/setbounty ', '')
        local entitled, pl_id = IsEntitled(id, text, 'Set Bounty')

        if entitled then
            if script.get_host_of_this_script() == player.player_id() then
                Notify('Bounty command is not avaliable while you are Script Host', "Error", '')
                return
            end
            scriptevent.setBounty(pl_id, 10000, 1)
        end
    end

    if Script.Feature['cmd_explode'].on and string.find(text, '/explode ', 1) then
        text = string.gsub(text, '/explode ', '')
        local entitled, pl_id = IsEntitled(id, text, 'Explode')

        if entitled then
            fire.add_explosion(get.PlayerCoords(pl_id), 59, false, true, 1, get.PlayerPed(id))
            fire.add_explosion(get.PlayerCoords(pl_id), 8, false, true, 1, get.PlayerPed(id))
            fire.add_explosion(get.PlayerCoords(pl_id), 59, false, true, 1, get.PlayerPed(id))
        end
    end

    if Script.Feature['cmd_trap'].on and string.find(text, '/trap ', 1) then
        text = string.gsub(text, '/trap ', '')
        local entitled, pl_id = IsEntitled(id, text, 'Trap')

        if entitled then
            local pos = get.PlayerCoords(pl_id)
            entity.set_entity_rotation(Spawn.Object(1125864094, v3(pos.x, pos.y, pos.z - 5)), v3(0, 90, 0))
        end
    end

    if Script.Feature['cmd_kick'].on and string.find(text, '/kick ', 1) then
        text = string.gsub(text, '/kick ', '')
        local entitled, pl_id = IsEntitled(id, text, 'Kick')
        if entitled then
            network.force_remove_player(pl_id)
        end
    end
    
    if Script.Feature['cmd_crash'].on and string.find(text, '/crash ', 1) then
        text = string.gsub(text, '/crash ', '')
        local entitled, pl_id = IsEntitled(id, text, 'Crash')
        if entitled then
            scriptevent.crash(pl_id)
        end
    end

    if Script.Feature['cmd_spawn'].on and string.find(text, '/spawn ', 1) then
        text = string.gsub(text, '/spawn ', '')
        local entitled, pl_id = IsEntitled(id, nil, 'Spawn')
        if entitled then
            local hash = gameplay.get_hash_key(text)

            if hash == 956849991 or hash == 1133471123 or hash == 2803699023 or hash == 386089410 or hash == 1549009676 then
                return
            end

            if streaming.is_model_a_vehicle(hash) then
                local spawned_veh = Spawn.Vehicle(hash, utility.OffsetCoords(get.PlayerCoords(id), player.get_player_heading(id), 10), player.get_player_heading(id))
                if utility.request_ctrl(spawned_veh) then
                    vehicle.set_vehicle_window_tint(spawned_veh, 1)
                    decorator.decor_set_int(spawned_veh, 'MPBitset', 1 << 10)
                    utility.MaxVehicle(spawned_veh, 2)
                end
            end
        end
    end
    
    if Script.Feature['cmd_vehiclegod'].on and string.find(text, '/vehiclegod ', 1) then
        local entitled, pl_id = IsEntitled(id, nil, 'VehicleGod')
        if entitled then
            local veh = get.PlayerVehicle(id)
            if veh ~= 0 then
                text = string.gsub(text, '/vehiclegod ', '')
                local toggle
                if text == 'off' then
                    toggle = false
                end
                if text == 'on' then
                    toggle = true
                end
                if not utility.request_ctrl(veh, 5000) then
                    Notify('Failed to gain control over the Players vehicle.\nThe command might not have worked.', "Error")
                end
                if toggle ~= nil then
                    entity.set_entity_god_mode(veh, toggle)
                end
            else
                Notify('Couldnt find the Players vehicle, they might be too far away.', "Error")
            end
        end
    end

    if Script.Feature['cmd_upgrade'].on and string.find(text, '/upgrade', 1) then
        local entitled, pl_id = IsEntitled(id, nil, 'Upgrade')
        if entitled then
            local veh = get.PlayerVehicle(id)
            if veh ~= 0 then
                if not utility.request_ctrl(veh, 5000) then
                    Notify('Failed to gain control over the Players vehicle.\nThe command might not have worked.', "Error")
                end
                utility.MaxVehicle(veh)
            else
                Notify('Couldnt find the Players vehicle, they might be too far away.', "Error")
            end
        end
    end

    if Script.Feature['cmd_repair'].on and string.find(text, '/repair', 1) then
        local entitled, pl_id = IsEntitled(id, nil, 'Repair')
        if entitled then
            local veh = get.PlayerVehicle(id)
            if veh ~= 0 then
                if not utility.request_ctrl(veh, 5000) then
                    Notify('Failed to gain control over the Players vehicle.\nThe command might not have worked.', "Error")
                end
                utility.RepairVehicle(veh)
            else
                Notify('Couldnt find the Players vehicle, they might be too far away.', "Error")
            end
        end
    end

    if Script.Feature['cmd_tp'].on and string.find(text, '/tp ', 1) and id == player.player_id() then
        text = string.gsub(text, '/tp ', '')
        local target = utility.id_from_name(text)
        if target ~= -1 then
            local offset = 10
            local pos = get.PlayerCoords(target)
            if pos.z < -50 then
                offset = 150
            end
            utility.tp(get.PlayerPed(target), offset)
        end
    end

    if Script.Feature['cmd_explode_all'].on and string.find(text, '/explodeall', 1) and id == player.player_id() then
        for id = 0, 31 do
            if utility.valid_player(id, Script.Feature['Block Friends as Target'].on) then
                fire.add_explosion(get.PlayerCoords(id), 59, true, false, 1, get.OwnPed())
            end
        end
    end

    if Script.Feature['cmd_scriptkick_all'].on and string.find(text, '/scriptkickall', 1) and id == player.player_id() then
        for id = 0, 31 do
            if utility.valid_player(id, Script.Feature['Block Friends as Target'].on) then
                kick_player(id)
            end
            coroutine.yield(0)
        end
    end

    if Script.Feature['cmd_desynckick_all'].on and string.find(text, '/desynckickall', 1) and id == player.player_id() then
        for id = 0, 31 do
            if utility.valid_player(id, Script.Feature['Block Friends as Target'].on) then
                network.force_remove_player(id)
            end
            coroutine.yield(0)
        end
    end

    if Script.Feature['cmd_crash_all'].on and string.find(text, '/crashall', 1) and id == player.player_id() then
        for id = 0, 31 do
            scriptevent.crash(id)
            coroutine.yield(0)
        end
    end
end

function chatevents.EchoChat(args)
    if not args.player or not args.body then
        return
    end
    if args.player ~= player.player_id() then
        for i = 1, Script.Feature['Echo Chat'].value do
            network.send_chat_message(args.body, false)
        end
    end
end

local playerevents = {}
function playerevents.DetectByName(target)
    if not target then
        return
    end
    if utility.valid_player(target.player, Script.Feature['Exclude Friends'].on) then
        local detected = false
        local dtcstring
        local stringset = stringData.NameStrings.Safe
        if Script.Feature['Ad Blacklist Name Strings'].value == 1 then
            stringset = stringData.NameStrings.Aggressive
        end
        for i = 1, #stringset do
            if string.find(get.Name(target.player), stringset[i]) then
                dtcstring = stringset[i]
                detected = true
            end
        end
        if detected then
            if not Script.Feature['Ad Blacklist Disable Notifications'].on then
                Notify('Player: ' .. get.Name(target.player) .. '\nReason: Name Blacklist\nReaction: Kick', "Neutral", '2Take1Script Automod')
            end
            Log('Player: ' .. get.Name(target.player) .. '\nReason: Name Blacklist\nReaction: Kick\nDetails: ' .. dtcstring, '[Automod]')
            if Script.Feature['Ad Blacklist Fake Friends'].on then
                if IsFakeFriend(target.player) then
                    Log('Player already exists in Blacklist')
                else
                    utility.write(io.open(files['FakeFriends'], 'a'), get.Name(target.player) .. ':' .. Math.DecToHex(get.SCID(target.player)) .. ":c")
                end
            end
            if Script.Feature['Ad Blacklist Kick Type'].value == 0 then
                kick_player(target.player)
            else
                network.force_remove_player(target.player)
            end
            detected = false
        end
    end
end

function playerevents.Blacklist(target)
    if not target or not utils.file_exists(files['Blacklist']) then
        return
    end
    
    local detected = false
    local details
    local id = target.player
    local pname = get.Name(id)
    local pscid = get.SCID(id)
    local pip = get.IP(id)

    local c_blacklist = {}
    for line in io.lines(files['Blacklist']) do
        local parts = {}
        for part in line:gmatch("[^:]+") do
            parts[#parts + 1] = part
        end
        if #parts == 3 then
            local name = parts[1]
            local scid = tonumber(parts[2])
            local ip = parts[3]
            
            c_blacklist[name] = {SCID=scid, IP=ip}
            c_blacklist[scid] = {Name=name, IP=ip}
            c_blacklist[ip] = {Name=name, SCID=scid}
        end
    end

    if Script.Feature['Detection Requirement Name'].on and Script.Feature['Detection Requirement SCID'].on and Script.Feature['Detection Requirement IP'].on then
        if c_blacklist[get.Name(id)] and c_blacklist[get.Name(id)].SCID == pscid and c_blacklist[get.Name(id)].IP == pip then
            detected = true
            details = 'Matching Name, SCID & IP'
        end

    elseif Script.Feature['Detection Requirement Name'].on and Script.Feature['Detection Requirement SCID'].on then
        if c_blacklist[get.Name(id)] and c_blacklist[get.Name(id)].SCID == pscid then
            detected = true
            details = 'Matching Name & SCID'
        end

    elseif Script.Feature['Detection Requirement SCID'].on and Script.Feature['Detection Requirement IP'].on then
        if c_blacklist[get.SCID(id)] and c_blacklist[get.SCID(id)].IP == pip then
            detected = true
            details = 'Matching SCID & IP'
        end

    elseif Script.Feature['Detection Requirement Name'].on and Script.Feature['Detection Requirement IP'].on then
        if c_blacklist[get.Name(id)] and c_blacklist[get.Name(id)].IP == pip then
            detected = true
            details = 'Matching Name & IP'
        end

    elseif Script.Feature['Detection Requirement Name'].on then
        if c_blacklist[get.Name(id)] then
            detected = true
            details = 'Matching Name'
        end

    elseif Script.Feature['Detection Requirement SCID'].on then
        if c_blacklist[get.SCID(id)] then
            detected = true
            details = 'Matching SCID'
        end

    elseif Script.Feature['Detection Requirement IP'].on then
        if c_blacklist[get.IP(id)] then
            detected = true
            details = 'Matching IP'
        end

    end

    if detected then
        Log('Player: ' .. get.Name(id) .. '\nReason: Player Blacklist\nReaction: Kick\nDetails: ' .. details, '[Player Blacklist]')
        Notify('Player: ' .. get.Name(id) .. '\nReason: Player Blacklist\nReaction: Kick', "Neutral", '2Take1Script Player Blacklist')
        if Script.Feature['Player Blacklist Kick Type'].value == 0 then
            kick_player(id)
        else
            network.force_remove_player(id)
        end
    end
end

function playerevents.remember(target)
    if not target or not utils.file_exists(files['Modder']) then
        return
    end
    
    local id = target.player
    local remembered = {}

    if Script.Feature['Modder Detection Whitelist Friends'].on and player.is_player_friend(id) then
        return
    end

    for line in io.lines(files['Modder']) do
        local parts = {}
        for part in line:gmatch("[^:]+") do
            parts[#parts + 1] = part
        end
        if #parts >= 3 then
            local name = parts[1]
            local scid = tonumber(parts[2])
            local reason = parts[3]
            remembered[scid] = {Name=name, Flag=reason}
        end
    end

    
    local scid = get.SCID(id)

    if remembered[scid] then
        local name = get.Name(id)

        Notify('Player: ' .. name .. '\nReason: Remembered', "Neutral", '2Take1Script Modder Detection')
        Log('Player: ' .. name .. '\nReason: Remembered\nModderflag: ' .. remembered[scid].Flag, '[Modder Detection]')
        player.set_player_as_modder(id, customflags[1][2])
    end
end

local modderevents = {}
function modderevents.godmode(target)
    
    local rate = 1
    local InitialPos = get.PlayerCoords(target)
    coroutine.yield(20000)

    local NewPos = get.PlayerCoords(target)
    if utility.valid_modder(target, Script.Feature['Modder Detection Whitelist Friends'].on) and get.GodmodeState(target) and InitialPos:magnitude(NewPos) > 20 then
        rate = rate + 1
    end
    coroutine.yield(20000)

    InitialPos = get.PlayerCoords(target)
    if utility.valid_modder(target, Script.Feature['Modder Detection Whitelist Friends'].on) and get.GodmodeState(target) and InitialPos:magnitude(NewPos) > 20 then
        rate = rate + 1
    end
    coroutine.yield(20000)
    
    NewPos = get.PlayerCoords(target)
    if utility.valid_modder(target, Script.Feature['Modder Detection Whitelist Friends'].on) and get.GodmodeState(target) and InitialPos:magnitude(NewPos) > 20 then
        rate = rate + 1
    end
    
    if utility.valid_modder(target, Script.Feature['Modder Detection Whitelist Friends'].on) and rate > 3 then
        local Name = get.Name(target)

        if Script.Feature['Modder Detection Player Godmode'].value == 0 then
            Notify('Player: ' .. Name .. '\nReason: Player Godmode\nReaction: Notify', "Neutral", '2Take1Script Modder Detection')
            coroutine.yield(60000)

        else
            Notify('Player: ' .. Name .. '\nReason: Player Godmode\nReaction: Notify & Mark', "Neutral", '2Take1Script Modder Detection')
            Log('Player: ' .. Name .. '\nReason: Player Godmode', '[Modder Detection]')
            player.set_player_as_modder(target, customflags[8][2])

        end

    end
end

function modderevents.vehiclegodmode(target)

    local rate = 1
    local InitialPos = get.PlayerCoords(target)
    coroutine.yield(20000)
    
    local NewPos = get.PlayerCoords(target)
    if utility.valid_modder(target, Script.Feature['Modder Detection Whitelist Friends'].on) and get.VehicleGodmodeState(target) and InitialPos:magnitude(NewPos) > 20 then
        rate = rate + 1
    end
    coroutine.yield(20000)

    local InitialPos = get.PlayerCoords(target)
    if utility.valid_modder(target, Script.Feature['Modder Detection Whitelist Friends'].on) and get.VehicleGodmodeState(target) and InitialPos:magnitude(NewPos) > 20 then
        rate = rate + 1
    end
    coroutine.yield(20000)

    local NewPos = get.PlayerCoords(target)
    if utility.valid_modder(target, Script.Feature['Modder Detection Whitelist Friends'].on) and get.VehicleGodmodeState(target) and InitialPos:magnitude(NewPos) > 20 then
        rate = rate + 1
    end
    
    if utility.valid_modder(target, Script.Feature['Modder Detection Whitelist Friends'].on) and rate > 3 then
        local Name = get.Name(target)

        if Script.Feature['Modder Detection Vehicle Godmode'].value == 0 then
            Notify('Player: ' .. Name .. '\nReason: Vehicle Godmode\nReaction: Notify', "Neutral", '2Take1Script Modder Detection')
            coroutine.yield(60000)

        else
            Notify('Player: ' .. Name .. '\nReason: Vehicle Godmode\nReaction: Notify & Mark', "Neutral", '2Take1Script Modder Detection')
            Log('Player: ' .. Name .. '\nReason: Vehicle Godmode', '[Modder Detection]')
            player.set_player_as_modder(target, customflags[4][2])
            
        end

    end
end

function modderevents.autokick(target)
    if not target then
        return
    end

    local id = target.player
    local flag = target.flag
    local name = player.get_modder_flag_text(flag)
    local responses = {'Kick', 'Kick & Blacklist'}

    if name == 'Remembered' then
        coroutine.yield(500)
    end

    if utility.valid_player(id, (Script.Feature['Enable Auto Kick Modder'].value == 1)) then
        if Script.Feature['Autokick ' .. name].on then
            Log('Player: ' .. get.Name(id) .. '\nReason: ' .. name .. '\nReaction: ' .. responses[Script.Feature['Autokick ' .. name].value + 1], '[Autokick Modder]')
            Notify('Player: ' .. get.Name(id) .. '\nReason: ' .. name .. '\nReaction: ' .. responses[Script.Feature['Autokick ' .. name].value + 1], "Neutral", '2Take1Script Autokick Modder')
            
            if Script.Feature['Autokick ' .. name].value == 1 and not IsFakeFriend(id) then
                utility.write(io.open(files['FakeFriends'], 'a'), get.Name(id) .. ':' .. Math.DecToHex(get.SCID(id)) .. ":c")
            end

            network.force_remove_player(id)
            coroutine.yield(2000)

            if player.is_player_valid(id) then
                network.force_remove_player(id)
            end

        end

    end

end

function modderevents.remember(target)
    if not target then
        return
    end
    local id = target.player
    local flag = target.flag
    local text = player.get_modder_flag_text(flag)
    local name = get.Name(id)
    local scid = get.SCID(id)

    if not Script.Feature['Remember ' .. text].on then
        return
    end
    
    if not utils.file_exists(files['Modder']) then
        utility.write(io.open(files['Modder'], 'a'), name .. ':' .. scid .. ':' ..  text)
        if Script.Parent['Remember Modder Profiles'] then
            Script.Feature[name .. '/' .. text] = menu.add_feature(name, 'action_value_str',  Script.Parent['Remember Modder Profiles'], function(f)
                if f.value == 0 then
                    Notify('Name: ' .. name .. '\nSCID: ' .. scid .. '\nReason: ' .. text, "Neutral", '2Take1Script Remember Modder')
                elseif f.value == 1 then
                    local remembered = {}
                    for line2 in io.lines(files['Modder']) do
                        remembered[line2] = true
                    end

                    remembered[name .. ':' .. scid .. ':' .. text] = nil
        
                    utility.write(io.open(files['Modder'], 'w'))
                    for k in pairs(remembered) do
                        utility.write(io.open(files['Modder'], 'a'), k)
                    end

                    menu.delete_feature(f.id)
                    Notify('Entry Deleted', "Success", '2Take1Script Remember Modder')
                else
                    utils.to_clipboard(scid)
                    Notify('SCID copied to clipboard', "Success", '2Take1Script Remember Modder')
                end
            end)
            Script.Feature[name .. '/' .. text]:set_str_data({'Show Info', 'Delete', 'Copy SCID'})
        end
        return
    end

    local remembered = {}
    for line in io.lines(files['Modder']) do
        local parts = {}
        for part in line:gmatch("[^:]+") do
            parts[#parts + 1] = part
        end
        if #parts >= 3 then
            local name = parts[1]
            local scid = tonumber(parts[2])
            local reason = parts[3]
            remembered[scid] = {Name=name}
        end
    end

    if not remembered[scid] then
        utility.write(io.open(files['Modder'], 'a'), name .. ':' .. scid .. ':' ..  text)

        if Script.Parent['Remember Modder Profiles'] then
            Script.Feature[name .. '/' .. text] = menu.add_feature(name, 'action_value_str',  Script.Parent['Remember Modder Profiles'], function(f)
                if f.value == 0 then
                    Notify('Name: ' .. name .. '\nSCID: ' .. scid .. '\nReason: ' .. text, "Neutral", '2Take1Script Remember Modder')
                elseif f.value == 1 then
                    local remembered = {}
                    for line2 in io.lines(files['Modder']) do
                        remembered[line2] = true
                    end

                    remembered[name .. ':' .. scid .. ':' .. text] = nil
        
                    utility.write(io.open(files['Modder'], 'w'))
                    for k in pairs(remembered) do
                        utility.write(io.open(files['Modder'], 'a'), k)
                    end

                    menu.delete_feature(f.id)
                    Notify('Entry Deleted', "Success", '2Take1Script Remember Modder')
                else
                    utils.to_clipboard(scid)
                    Notify('SCID copied to clipboard', "Success", '2Take1Script Remember Modder')
                end
            end)
            Script.Feature[name .. '/' .. text]:set_str_data({'Show Info', 'Delete', 'Copy SCID'})
        end
    end
end

chatevents.listener =  event.add_event_listener('chat', function(message)
    local args = {player = message.player, body = message.body}

    if Script.Feature['Log Chat'].on then
        menu.create_thread(chatevents.LogChat, args)
    end

    if Script.Feature['Print Chat'].on then
        menu.create_thread(chatevents.PrintChat, args)
    end

    if Script.Feature['Ad Blacklist Chat Strings'].on then
        menu.create_thread(chatevents.DetectByMessage, args)
    end

    if Script.Feature['GEO-Block Russia'].on then
        menu.create_thread(chatevents.PunishRussian, args)
    end

    if Script.Feature['GEO-Block China'].on then
        menu.create_thread(chatevents.PunishChinese, args)
    end

    if Script.Feature['Enable Commands'].on then
        menu.create_thread(chatevents.ChatCommands, args)
    end

    if Script.Feature['Echo Chat'].on then
        menu.create_thread(chatevents.EchoChat, args)
    end
end)

playerevents.joinlistener = event.add_event_listener('player_join', function(target)
    playerlogging[target.player] = {ID = target.player, Name = get.Name(target.player)}

    if Script.Feature['Print Joining Players'].on then
        print('[2Take1] Player ' .. get.Name(target.player) .. ' [' .. get.SCID(target.player) .. ' / ' .. get.IP(target.player) .. '] joined the lobby')
    end

    if Script.Feature['Modder Detection Remember'].on then
        menu.create_thread(playerevents.remember, target)
    end

    if Script.Feature['Ad Blacklist Name Strings'].on then
        menu.create_thread(playerevents.DetectByName, target)
    end

    if Script.Feature['Enable Player Blacklist'].on then
        menu.create_thread(playerevents.Blacklist, target)
    end
end)

playerevents.leavelistener = event.add_event_listener('player_leave', function(target)
    if Script.Feature['Print Leaving Players'].on and playerlogging[target.player] then
        print('[2Take1] Player ' ..  playerlogging[target.player].Name.. " left.")
    end
    playerlogging[target.player] = nil
end)

modderevents.listener = event.add_event_listener('modder', function(target)
    if Script.Feature['Modder Detection Remember'].on then
        menu.create_thread(modderevents.remember, target)
    end

    if Script.Feature['Log Modder Detections'].on then
        local flag = player.get_modder_flag_text(target.flag)
        Log('[Modder Detection] Player: ' .. get.Name(target.player) .. ' [' .. get.SCID(target.player) .. ']\nReason: ' .. flag)
    end

    if Script.Feature['Print Modder Detections'].on then
        local flag = player.get_modder_flag_text(target.flag)
        print('[Modder Detection] Player: ' .. get.Name(target.player) .. '\nReason: ' .. flag)
    end

    if Script.Feature['Enable Auto Kick Modder'].on then
        menu.create_thread(modderevents.autokick, target)
    end
end)

local exitlistener = event.add_event_listener('exit', function()
    for i in pairs(robot_objects) do
        utility.clear({robot_objects[i]})
    end

    for i in pairs(entitys) do
        utility.clear(entitys[i])
    end

    utility.clear({model_gun})
    utility.clear({balll})
    utility.clear({ptfxs['fire_ass_ball']})

    if ptfxs['flamethrower'] then
        graphics.remove_particle_fx(ptfxs['flamethrower'], true)
    end

    if ptfxs['flamethrower_green'] then
        graphics.remove_particle_fx(ptfxs['flamethrower_green'], true)
    end

    if ptfxs['fire_circle'][1] then
        for i = 1, #ptfxs['fire_circle'] do
            graphics.remove_particle_fx(ptfxs['fire_circle'][i], true)
        end

        utility.clear(ptfxs['fire_balls'])
    end

    if ptfxs['fire_ass'] then
        graphics.remove_particle_fx(ptfxs['fire_ass'], true)
    end

    -- remove event hooks
    for i = 0, 31 do
        if hooks.script[i] then
            hook.remove_script_event_hook(hooks.script[i])
        end
    end

    for i = 0, 31 do
        if hooks.net[i] then
            hook.remove_net_event_hook(hooks.net[i])
        end
    end

    if hooks.typingplayers ~= nil then
        hook.remove_net_event_hook(hooks.typingplayers)
    end

    if hooks.typingplayers2 ~= nil then
        hook.remove_net_event_hook(hooks.typingplayers2)
    end

    if hooks.smskick ~= nil then
        hook.remove_net_event_hook(hooks.smskick)
    end

    if hooks.script_response ~= nil then
        hook.remove_net_event_hook(hooks.script_response)
    end

    if hooks.modded_script ~= nil then
        hook.remove_net_event_hook(hooks.modded_script)
    end

    if hooks.modded_net ~= nil then
        hook.remove_net_event_hook(hooks.modded_net)
    end

    if hooks.votekick ~= nil then
        hook.remove_net_event_hook(hooks.votekick)
    end

    -- remove event listeners
    event.remove_event_listener('chat', chatevents.listener)
    event.remove_event_listener('modder', modderevents.listener)
    event.remove_event_listener('player_join', playerevents.joinlistener)
    event.remove_event_listener('player_leave', playerevents.leavelistener)

    Log('2Take1Script unloaded. Cleanup Successful.')
    Notify('2Take1Script unloaded.\nCleanup Successful.', "Error")
    _2t1s = false
end)

if not utils.file_exists(files['DefaultConfig']) then
    settings['2Take1Script Parent'].Enabled = true
else
    for line in io.lines(files['DefaultConfig']) do
        local parts = {}
        for part in line:gmatch("[^:]+") do
            parts[#parts + 1] = part
        end
        local name = parts[1]
        if name == '2Take1Script Parent' then
            if tostring(parts[2]) == 'nil' then
                settings[name].Enabled = true
            elseif parts[2] == 'true' then
                settings[name].Enabled = true
            elseif parts[2] == 'false' then
                settings[name].Enabled = false
            end
            break
        end
    end
end


local function mainScript()
    setup.Log('Loading Features...')

    --Menu Main Parents
    if settings['2Take1Script Parent'].Enabled then
        Script.Parent['Main Parent'] = menu.add_feature('2Take1Script', 'parent', 0, nil)
        Script.Parent['Player Parent'] = menu.add_player_feature('2Take1Script', 'parent', 0, nil)
        Script.mainparent = Script.Parent['Main Parent'].id
        Script.playerparent = Script.Parent['Player Parent'].id
    end
    Script.Parent['local_player'] = menu.add_feature('Player Options', 'parent', Script.mainparent, nil).id
    Script.Parent['local_vehicle'] = menu.add_feature('Vehicle Options','parent', Script.mainparent, nil).id
    Script.Parent['local_modelchanger'] = menu.add_feature('Animal Model Changer', 'parent', Script.mainparent, function(f)
        if Script.Feature['Revert Outfit'].on then
            if #outfits['bac_outfit']['clothes'] < 1 then
                if player.get_player_model(player.player_id()) == 0x9C9EFFD8 or player.get_player_model(player.player_id()) == 0x705E61F2 then
                    for i = 1, 11 do
                        outfits['bac_outfit']['textures'][i] = ped.get_ped_texture_variation(get.OwnPed(), i)
                        outfits['bac_outfit']['clothes'][i] = ped.get_ped_drawable_variation(get.OwnPed(), i)
                    end
                    local loop = {0, 1, 2, 6, 7}
                    for z = 1, #loop do
                        outfits['bac_outfit']['prop_ind'][z] = ped.get_ped_prop_index(get.OwnPed(), loop[z])
                        outfits['bac_outfit']['prop_text'][z] = ped.get_ped_prop_texture_index(get.OwnPed(), loop[z])
                    end
                    local g = 'male'
                    if player.is_player_female(player.player_id()) then
                        g = 'female'
                    end
                    outfits['bac_outfit']['gender'] = g
                end
            end
        end
    end).id
    Script.Parent['local_lobby'] = menu.add_feature('Lobby Options', 'parent', Script.mainparent, nil).id
    Script.Parent['local_automod'] = menu.add_feature('Auto Moderation', 'parent', Script.mainparent, nil).id
    Script.Parent['local_modderdetection'] = menu.add_feature('Modder Detection', 'parent', Script.mainparent, nil).id
    Script.Parent['local_world'] = menu.add_feature('World Management', 'parent', Script.mainparent, nil).id
    Script.Parent['Stats Editor'] = menu.add_feature('Stats Editor', 'parent', Script.mainparent,  nil)
    Script.Parent['local_misc'] = menu.add_feature('Miscellaneous', 'parent', Script.mainparent, nil).id
    Script.Parent['local_settings'] = menu.add_feature('Settings', 'parent', Script.mainparent, nil).id

    local Trusted_Mode_Check = menu.add_feature('Trusted Mode check', 'toggle', 0, function(f)
        while f.on do
            if menu.is_trusted_mode_enabled() and network.is_session_started() then
                Script.Parent['Stats Editor'].hidden = false
            else
                Script.Parent['Stats Editor'].hidden = true
            end
            coroutine.yield(1000)
        end
    end)
    Trusted_Mode_Check.on = true
    Trusted_Mode_Check.hidden = true

    Script.Feature['Outfit Component Randomizer'] = menu.add_feature('Random Outfit Components', 'action_value_str', Script.Parent['local_player'], function(f)
        if f.value == 0 then
            utility.random_outfit(get.OwnPed(), 1)

        elseif f.value == 1 then
            utility.random_outfit(get.OwnPed(), 3)

        elseif f.value == 2 then
            utility.random_outfit(get.OwnPed(), 11)

        elseif f.value == 3 then
            utility.random_outfit(get.OwnPed(), 8)

        elseif f.value == 4 then
            utility.random_outfit(get.OwnPed(), 4)

        elseif f.value == 5 then
            utility.random_outfit(get.OwnPed(), 6)

        elseif f.value == 6 then
            utility.random_outfit(get.OwnPed(), 9)

        elseif f.value == 7 then
            utility.random_outfit(get.OwnPed(), 5)

        elseif f.value == 8 then
            utility.random_outfit(get.OwnPed(), 10)

        elseif f.value == 9 then
            utility.random_outfit(get.OwnPed(), 7)

        elseif f.value == 10 then
            ped.set_ped_random_component_variation(get.OwnPed())
        end
    end)
    Script.Feature['Outfit Component Randomizer']:set_str_data({'Mask', 'Gloves', 'Torso', 'Undershirt', 'Pants', 'Shoes', 'Armor', 'Parachute', 'Decal', 'Accessory', 'All'})

    Script.Feature['Outfit Property Randomizer'] = menu.add_feature('Random Outfit Properties', 'action_value_str', Script.Parent['local_player'], function(f)
        if f.value == 0 then
            ped.set_ped_prop_index(get.OwnPed(), 0, math.random(0, 162), 0, false)

        elseif f.value == 1 then
            ped.set_ped_prop_index(get.OwnPed(), 1, math.random(0, 41), 0, false)

        elseif f.value == 2 then
            ped.set_ped_prop_index(get.OwnPed(), 2, math.random(0, 21), 0, false)

        elseif f.value == 3 then
            ped.set_ped_prop_index(get.OwnPed(), 6, math.random(0, 20), 0, false)

        elseif f.value == 4 then
            ped.set_ped_prop_index(get.OwnPed(), 7, math.random(0, 20), 0, false)

        else
            ped.set_ped_prop_index(get.OwnPed(), 0, math.random(0, 162), 0, false)
            ped.set_ped_prop_index(get.OwnPed(), 1, math.random(0, 41), 0, false)
            ped.set_ped_prop_index(get.OwnPed(), 2, math.random(0, 21), 0, false)
            ped.set_ped_prop_index(get.OwnPed(), 6, math.random(0, 20), 0, false)
            ped.set_ped_prop_index(get.OwnPed(), 7, math.random(0, 20), 0, false)
        end
    end)
    Script.Feature['Outfit Property Randomizer']:set_str_data({'Hat', 'Glasses', 'Ear', 'Watch', 'Bracelet', 'All'})

    Script.Feature['Force Police Outfit'] = menu.add_feature('Force Police Outfit', 'toggle', Script.Parent['local_player'], function(f)
        settings['Force Police Outfit'] = {Enabled = f.on}
        while f.on do
            local Gender = 'male'
            if player.is_player_female(player.player_id()) then
                Gender = 'female'
            end

            local Outfit = outfits['police_outfit'][Gender]
            for i = 1, #Outfit['clothes'] do
                ped.set_ped_component_variation(get.OwnPed(), i, Outfit['clothes'][i][2], Outfit['clothes'][i][1], 2)
            end

            for i = 1, #Outfit['props'] do
                ped.set_ped_prop_index(get.OwnPed(), Outfit['props'][i][1], Outfit['props'][i][2], Outfit['props'][i][3], 0)
            end
            
            coroutine.yield(250)
        end
        settings['Force Police Outfit'].Enabled = f.on
    end)

    Script.Parent['Weapon Loadout'] = menu.add_feature('Weapon Loadout', 'parent', Script.Parent['local_player'], nil).id

    Script.Feature['Weapon Loadout Toggle'] = menu.add_feature('Enable Loadout', 'toggle', Script.Parent['Weapon Loadout'], function(f)
        settings['Weapon Loadout Toggle'] = {Enabled = f.on}
        while f.on do
            for i = 1, #mapper.weapons do
                local WeaponCategory = mapper.weapons[i]

                for j = 1, #WeaponCategory.Children do
                    local CurrentWeapon = WeaponCategory.Children[j]

                    if Script.Feature['Equip ' .. CurrentWeapon.Name].on and not weapon.has_ped_got_weapon(get.OwnPed(), CurrentWeapon.Hash) then
                        weapon.give_delayed_weapon_to_ped(get.OwnPed(), CurrentWeapon.Hash, 0, 0)
                        weapon.set_ped_ammo(get.OwnPed(), CurrentWeapon.Hash, 9999)

                    elseif not Script.Feature['Equip ' .. CurrentWeapon.Name].on and weapon.has_ped_got_weapon(get.OwnPed(), CurrentWeapon.Hash) then
                        weapon.remove_weapon_from_ped(get.OwnPed(), CurrentWeapon.Hash)
                    end

                    if CurrentWeapon.Components then
                        for k = 1, #CurrentWeapon.Components do
                            local CurrentComponent = CurrentWeapon.Components[k]

                            if Script.Feature['Equip ' .. CurrentWeapon.Name .. ' ' .. CurrentComponent.Name].on then
                                if weapon.has_ped_got_weapon(get.OwnPed(), CurrentWeapon.Hash) and not weapon.has_ped_got_weapon_component(get.OwnPed(), CurrentWeapon.Hash, CurrentComponent.Hash) then
                                    weapon.give_weapon_component_to_ped(get.OwnPed(), CurrentWeapon.Hash, CurrentComponent.Hash)
                                end

                            else
                                if weapon.has_ped_got_weapon(get.OwnPed(), CurrentWeapon.Hash) and weapon.has_ped_got_weapon_component(get.OwnPed(),CurrentWeapon.Hash, CurrentComponent.Hash) then
                                    weapon.remove_weapon_component_from_ped(get.OwnPed(),CurrentWeapon.Hash, CurrentComponent.Hash)
                                end
                            end

                        end

                    end

                end

            end

            coroutine.yield(0)
        end
        settings['Weapon Loadout Toggle'].Enabled = f.on
    end)

    Script.Feature['Weapon Loadout All'] = menu.add_feature('Set All', 'action_value_str', Script.Parent['Weapon Loadout'], function(f)
        if f.value == 0 then
            for i = 1, #mapper.weapons do
                local WeaponCategory = mapper.weapons[i]

                for j = 1, #WeaponCategory.Children do
                    local CurrentWeapon = WeaponCategory.Children[j]

                    Script.Feature['Equip ' .. CurrentWeapon.Name].on = true
                end

            end
        elseif f.value == 1 then
            for i = 1, #mapper.weapons do
                local WeaponCategory = mapper.weapons[i]

                for j = 1, #WeaponCategory.Children do
                    local CurrentWeapon = WeaponCategory.Children[j]

                    Script.Feature['Equip ' .. CurrentWeapon.Name].on = false
                end

            end

        end
    end)
    Script.Feature['Weapon Loadout All']:set_str_data({'Equip', 'Unequip'})

    for i = 1, #mapper.weapons do
        local WeaponCategory = mapper.weapons[i]
        Script.Parent[WeaponCategory] = menu.add_feature(WeaponCategory.Name, "parent", Script.Parent['Weapon Loadout']).id

        for j = 1, #WeaponCategory.Children do
            local CurrentWeapon = WeaponCategory.Children[j]

            if CurrentWeapon.Components then
                Script.Parent[CurrentWeapon] = menu.add_feature(CurrentWeapon.Name, "parent", Script.Parent[WeaponCategory], nil).id

                Script.Feature['Equip ' .. CurrentWeapon.Name] = menu.add_feature("Equip", 'toggle', Script.Parent[CurrentWeapon], function(f)
                    settings['Equip ' .. CurrentWeapon.Name] = {Enabled = f.on}
                end)

                for k = 1, #CurrentWeapon.Components do
                    local CurrentComponent = CurrentWeapon.Components[k]

                    Script.Feature['Equip ' .. CurrentWeapon.Name .. ' ' .. CurrentComponent.Name] = menu.add_feature(CurrentComponent.Name, 'toggle', Script.Parent[CurrentWeapon], function(f)
                        settings['Equip ' .. CurrentWeapon.Name .. ' ' .. CurrentComponent.Name] = {Enabled = f.on}
                    end)

                end

            else
                Script.Feature['Equip ' .. CurrentWeapon.Name] = menu.add_feature(CurrentWeapon.Name, "toggle", Script.Parent[WeaponCategory], function(f)
                    settings['Equip ' .. CurrentWeapon.Name] = {Enabled = f.on}
                end)
            end 

        end

    end

    Script.Parent['Weapon Modifier'] = menu.add_feature('Weapon Modifier', 'parent', Script.Parent['local_player'], nil).id

    Script.Parent['Flamethrower'] = menu.add_feature('Flamethrower', 'parent', Script.Parent['Weapon Modifier'], nil).id

    Script.Feature['Flamethrower Scale'] = menu.add_feature('Scale', 'autoaction_value_i', Script.Parent['Flamethrower'], function(f)
        settings['Flamethrower Scale'] = {Value = f.value}
    end)
    Script.Feature['Flamethrower Scale'].min = 1
    Script.Feature['Flamethrower Scale'].max = 25

    Script.Feature['Flamethrower'] = menu.add_feature('Flamethrower', 'toggle', Script.Parent['Flamethrower'], function(f)
        settings['Flamethrower'] = {Enabled = f.on}
        while f.on do
            if player.is_player_free_aiming(player.player_id()) then
                graphics.set_next_ptfx_asset('weap_xs_vehicle_weapons')
                while not graphics.has_named_ptfx_asset_loaded('weap_xs_vehicle_weapons') do
                    graphics.request_named_ptfx_asset('weap_xs_vehicle_weapons')
                    coroutine.yield(0)
                end
                if not ptfxs['alien'] then
                    ptfxs['alien'] = Spawn.Object(1803116220, get.OwnCoords())
                    entity.set_entity_collision(ptfxs['alien'], false, false, false)
                    entity.set_entity_visible(ptfxs['alien'], false)
                end
                local pos_h = Math.GetPedBoneCoords(get.OwnPed(), 0xdead)
                utility.set_coords(ptfxs['alien'], pos_h)
                entity.set_entity_rotation(ptfxs['alien'], cam.get_gameplay_cam_rot())
                if not ptfxs['flamethrower'] then
                    ptfxs['flamethrower'] = graphics.start_networked_ptfx_looped_on_entity('muz_xs_turret_flamethrower_looping', ptfxs['alien'], v3(), v3(), Script.Feature['Flamethrower Scale'].value)
                    graphics.set_particle_fx_looped_scale(ptfxs['flamethrower'], Script.Feature['Flamethrower Scale'].value)
                end
            else
                if ptfxs['flamethrower'] then
                    graphics.remove_particle_fx(ptfxs['flamethrower'], true)
                    ptfxs['flamethrower'] = nil
                    utility.clear({ptfxs['alien']})
                    ptfxs['alien'] = nil
                end
            end
            coroutine.yield(0)
        end
        if ptfxs['flamethrower'] then
            graphics.remove_particle_fx(ptfxs['flamethrower'], true)
            ptfxs['flamethrower'] = nil
            utility.clear({ptfxs['alien']})
            ptfxs['alien'] = nil
        end
        settings['Flamethrower'].Enabled = f.on
    end)

    Script.Feature['Flamethrower Green'] = menu.add_feature('Flamethrower - Green', 'toggle', Script.Parent['Flamethrower'], function(f)
        settings['Flamethrower Green'] = {Enabled = f.on}
        while f.on do
            if player.is_player_free_aiming(player.player_id()) then
                graphics.set_next_ptfx_asset('weap_xs_vehicle_weapons')
                while not graphics.has_named_ptfx_asset_loaded('weap_xs_vehicle_weapons') do
                    graphics.request_named_ptfx_asset('weap_xs_vehicle_weapons')
                    coroutine.yield(0)
                end
                if not ptfxs['alien'] then
                    ptfxs['alien'] = Spawn.Object(1803116220, get.OwnCoords())
                    entity.set_entity_collision(ptfxs['alien'], false, false, false)
                    entity.set_entity_visible(ptfxs['alien'], false)
                end
                local pos_h = Math.GetPedBoneCoords(get.OwnPed(), 0xdead)
                utility.set_coords(ptfxs['alien'], pos_h)
                entity.set_entity_rotation(ptfxs['alien'], cam.get_gameplay_cam_rot())
                if not ptfxs['flamethrower_green'] then
                    ptfxs['flamethrower_green'] =
                    graphics.start_networked_ptfx_looped_on_entity('muz_xs_turret_flamethrower_looping_sf', ptfxs['alien'], v3(), v3(), Script.Feature['Flamethrower Scale'].value)
                end
            else
                if ptfxs['flamethrower_green'] then
                    graphics.remove_particle_fx(ptfxs['flamethrower_green'], true)
                    ptfxs['flamethrower_green'] = nil
                    utility.clear({ptfxs['alien']})
                    ptfxs['alien'] = nil
                end
            end
            coroutine.yield(0)
        end
        if ptfxs['flamethrower_green'] then
            graphics.remove_particle_fx(ptfxs['flamethrower_green'], true)
            ptfxs['flamethrower_green'] = nil
            utility.clear({ptfxs['alien']})
            ptfxs['alien'] = nil
        end
        settings['Flamethrower Green'].Enabled = f.on
    end)

    Script.Parent['Shoot Objects'] = menu.add_feature('Shoot Objects', 'parent', Script.Parent['Weapon Modifier'], nil).id

    Script.Feature['Shoot Objects'] = menu.add_feature('Enable Object Shoot', 'toggle', Script.Parent['Shoot Objects'], function(f)
        settings['Shoot Objects'] = {Enabled = f.on}
        while f.on do
            for i = 1, #customData.shoot_entitys do
                if Script.Feature[customData.shoot_entitys[i].Name].on and ped.is_ped_shooting(get.OwnPed()) then
                    if #entitys['shooting'] > 128 then
                        utility.clear(entitys['shooting'])
                        entitys['shooting'] = {}
                    end
                    local pos = get.OwnCoords()
                    local dir = cam.get_gameplay_cam_rot()
                    dir:transformRotToDir()
                    dir = dir * 8
                    pos = pos + dir
                    if streaming.is_model_an_object(customData.shoot_entitys[i].Hash) then
                        entitys['shooting'][#entitys['shooting'] + 1] = Spawn.Object(customData.shoot_entitys[i].Hash, pos)
                    end
                    dir = nil
                    local pos_target = get.OwnCoords()
                    dir = cam.get_gameplay_cam_rot()
                    dir:transformRotToDir()
                    dir = dir * 100
                    pos_target = pos_target + dir
                    local vectorV3 = pos_target - pos
                    entity.apply_force_to_entity(entitys['shooting'][#entitys['shooting']], 3, vectorV3.x, vectorV3.y, vectorV3.z, 0.0, 0.0, 0.0, true, true)
                end
            end
            coroutine.yield(0)
        end
        utility.clear(entitys['shooting'])
        entitys['shooting'] = {}
        settings['Shoot Objects'].Enabled = f.on
    end)

    Script.Feature['Delete Objects'] = menu.add_feature('Delete Objects', 'action', Script.Parent['Shoot Objects'], function()
        utility.clear(entitys['shooting'])
        entitys['shooting'] = {}
    end)

    for i = 1, #customData.shoot_entitys do
        if streaming.is_model_an_object(customData.shoot_entitys[i].Hash) then
            Script.Feature[customData.shoot_entitys[i].Name] = menu.add_feature('Shoot ' .. customData.shoot_entitys[i].Name, 'toggle', Script.Parent['Shoot Objects'], function(f)
                settings[customData.shoot_entitys[i].Name] = {Enabled = f.on}
            end)
        else
            print('Shoot Objects preset ' .. customData.shoot_entitys[i].Name .. ' is invalid.')
        end
    end

    Script.Feature['Delete Gun'] = menu.add_feature('Delete Gun', 'toggle', Script.Parent['Weapon Modifier'], function(f)
        settings['Delete Gun'] = {Enabled = f.on}
        while f.on do
            if ped.is_ped_shooting(get.OwnPed()) then
                local delete = player.get_entity_player_is_aiming_at(player.player_id())
                if delete then
                    if entity.is_entity_a_ped(delete) then
                        local veh = ped.get_vehicle_ped_is_using(delete)
                        if veh ~= 0 then
                            ped.clear_ped_tasks_immediately(delete)
                            delete = veh
                        end
                    end
                    
                    if not ped.is_ped_a_player(delete) then
                        utility.clear({delete})
                    end
                end
            end
            coroutine.yield(0)
        end
        settings['Delete Gun'].Enabled = f.on
    end)

    Script.Feature['Kick Gun'] = menu.add_feature('Kick Gun', 'toggle', Script.Parent['Weapon Modifier'], function(f)
        settings['Kick Gun'] = {Enabled = f.on}
        while f.on do
            if ped.is_ped_shooting(get.OwnPed()) then
                local pl = player.get_entity_player_is_aiming_at(player.player_id())
                if ped.is_ped_a_player(pl) then
                    Notify('Kick-Gun hit: ' .. get.Name(player.get_player_from_ped(pl)), "Neutral")
                    kick_player(player.get_player_from_ped(pl))
                end
            end
            coroutine.yield(0)
        end
        settings['Kick Gun'].Enabled = f.on
    end)

    Script.Feature['Drive it Gun'] = menu.add_feature('Drive it Gun', 'toggle', Script.Parent['Weapon Modifier'], function(f)
        settings['Drive it Gun'] = {Enabled = f.on}

        while f.on do
            local OwnPed = get.OwnPed()
            if ped.is_ped_shooting(OwnPed) then
                local Entity = player.get_entity_player_is_aiming_at(player.player_id())
                
                if Entity ~= 0 then
                    if entity.is_entity_a_ped(Entity) then
                        local Vehicle = ped.get_vehicle_ped_is_using(Entity)

                        if Vehicle ~= 0 then
                            ped.clear_ped_tasks_immediately(Entity)
                            Entity = Vehicle
                        end

                    end

                    if entity.is_entity_a_vehicle(Entity) then
                        ped.set_ped_into_vehicle(OwnPed, Entity, -1)
                    end

                end

            end

            coroutine.yield(0)
        end

        settings['Drive it Gun'].Enabled = f.on
    end)

    Script.Feature['Anti Gravity Gun'] = menu.add_feature('Anti Gravity Gun', 'value_str', Script.Parent['Weapon Modifier'], function(f)
        settings['Anti Gravity Gun'] = {Enabled = f.on, Value = f.value}
        local gravity = {0, -10, 10}

        while f.on do
            local OwnPed = get.OwnPed()
            if ped.is_ped_shooting(OwnPed) then
                local Entity = player.get_entity_player_is_aiming_at(player.player_id())
                
                if Entity ~= 0 then
                    if entity.is_entity_a_ped(Entity) then
                        local Vehicle = ped.get_vehicle_ped_is_using(Entity)

                        if Vehicle ~= 0 then
                            Entity = Vehicle
                        end

                    end

                    utility.request_ctrl(Entity, 100)

                    entity.freeze_entity(Entity, false)

                    if entity.is_entity_a_vehicle(Entity) then
                        entity.set_entity_gravity(Entity, false)
                        vehicle.set_vehicle_gravity_amount(Entity, gravity[f.value + 1])
                    end

                end

            end

            settings['Anti Gravity Gun'].Value = f.value
            coroutine.yield(0)
        end

        settings['Anti Gravity Gun'].Enabled = f.on
    end)
    Script.Feature['Anti Gravity Gun']:set_str_data({'Remove', 'Reverse', 'Normalise'})

    Script.Feature['Force Gun'] = menu.add_feature('Force Gun', 'toggle', Script.Parent['Weapon Modifier'], function(f)
        settings['Force Gun'] = {Enabled = f.on}

        while f.on do
            local OwnPed = get.OwnPed()
            if ped.is_ped_shooting(OwnPed) then
                local Entity = player.get_entity_player_is_aiming_at(player.player_id())
                
                if Entity ~= 0 then
                    if entity.is_entity_a_ped(Entity) then
                        local Vehicle = ped.get_vehicle_ped_is_using(Entity)

                        if Vehicle ~= 0 then
                            Entity = Vehicle
                        end

                    end

                    entity.freeze_entity(Entity, false)

                    local Position = entity.get_entity_coords(Entity)
                    local OwnPosition = player.get_player_coords(player.player_id())
                    local Magnitude = OwnPosition:magnitude(Position)
                
                    local Velocity = (Position - OwnPosition) * (80 / Magnitude)
                    utility.request_ctrl(Entity, 100)
                
                    entity.set_entity_velocity(Entity, Velocity)

                end

            end

            coroutine.yield(0)
        end

        settings['Force Gun'].Enabled = f.on
    end)

    Script.Feature['Airstrike Gun'] = menu.add_feature('Airstrike Gun', 'toggle', Script.Parent['Weapon Modifier'], function(f)
        settings['Airstrike Gun'] = {Enabled = f.on}

        while f.on do
            local OwnPed = get.OwnPed()
            if ped.is_ped_shooting(OwnPed) then
                
                local whash = gameplay.get_hash_key('weapon_airstrike_rocket')
                local pos = get.OwnCoords()
                local dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1000
                pos = pos + dir
                local hit, hitpos, hitsurf, hash, ent = worldprobe.raycast((utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 1) + v3(0, 0, 1)), pos, -1, 0)
                while not hit do
                    pos = get.OwnCoords()
                    dir = cam.get_gameplay_cam_rot()
                    dir:transformRotToDir()
                    dir = dir * 1000
                    pos = pos + dir
                    hit, hitpos, hitsurf, hash, ent = worldprobe.raycast((utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 1) + v3(0, 0, 1)), pos, -1, 0)
                    coroutine.yield(0)
                end

                local start = hitpos + v3(0, 0, 50)
                gameplay.shoot_single_bullet_between_coords(start, hitpos, 1000, whash, get.OwnPed(), true, false, 5000)

            end

            coroutine.yield(0)
        end

        settings['Airstrike Gun'].Enabled = f.on
    end)

    Script.Parent['Model Gun'] = menu.add_feature('Model Gun', 'parent', Script.Parent['Weapon Modifier'], nil).id

    Script.Feature['Model Gun'] = menu.add_feature('Standard Model Gun (Peds)', 'toggle', Script.Parent['Model Gun'], function(f)
        settings['Model Gun'] = {Enabled = f.on}
        while f.on do
            if apply_invisible then
                entity.set_entity_visible(get.OwnPed(), false)
                if model_gun then
                    entity.set_entity_visible(model_gun, true)
                end
            else
                entity.set_entity_visible(get.OwnPed(), true)
            end
            if player.is_player_free_aiming(player.player_id()) then
                local new_model = player.get_entity_player_is_aiming_at(player.player_id())
                if new_model ~= 0 then
                    new_model = entity.get_entity_model_hash(new_model)
                    if streaming.is_model_a_ped(new_model) then
                        if model_gun then
                            utility.clear({model_gun})
                            model_gun = nil
                        end
                        local pl_model = entity.get_entity_model_hash(get.OwnPed())
                        if new_model ~= pl_model then
                            apply_invisible = false
                            coroutine.yield(50)
                            local c_weapon = ped.get_current_ped_weapon(get.OwnPed())
                            change_model(new_model)
                            coroutine.yield(25)
                            weapon.give_delayed_weapon_to_ped(get.OwnPed(), c_weapon, 0, 1)
                        end
                    elseif streaming.is_model_a_vehicle(new_model) and Script.Feature['Extended Model Gun'].on then
                        utility.clear({model_gun})
                        model_gun = nil
                        apply_invisible = true
                        model_gun = Spawn.Vehicle(new_model, get.OwnCoords())
                        entity.attach_entity_to_entity(model_gun, get.OwnPed(), 0, v3(), v3(), true, true, false, 0, true)
                    elseif streaming.is_model_an_object(new_model) and Script.Feature['Extended Model Gun'].on then
                        utility.clear({model_gun})
                        model_gun = nil
                        model_gun = Spawn.Object(new_model, get.OwnCoords())
                        apply_invisible = true
                        entity.attach_entity_to_entity(model_gun, get.OwnPed(), 0, v3(), v3(), true, true, false, 0, true)
                    end
                end
            end
            coroutine.yield(0)
        end
        utility.clear({model_gun})
        model_gun = nil
        entity.set_entity_visible(get.OwnPed(), true)
        settings['Model Gun'].Enabled = f.on
    end)

    Script.Feature['Extended Model Gun'] = menu.add_feature('Add Objects and Vehicles to Model Gun', 'toggle', Script.Parent['Model Gun'], function(f)
        settings['Extended Model Gun'] = {Enabled = f.on}
    end)

    Script.Feature['Rapid Fire'] = menu.add_feature('Rapid Fire', 'value_str', Script.Parent['Weapon Modifier'], function(f)
        settings['Rapid Fire'] = {Enabled = f.on, Value = f.value}

        while f.on do
            if f.value == 0 and player.is_player_free_aiming(player.player_id()) then
                if ped.is_ped_shooting(get.OwnPed()) then
                    for i = 1, 25 do
                        local v3_start = Math.GetPedBoneCoords(get.OwnPed(), 0x67f2)
                        local dir = cam.get_gameplay_cam_rot()
                        dir:transformRotToDir()
                        dir = dir * 1.5
                        v3_start = v3_start + dir
                        dir = nil
                        local v3_end = get.OwnCoords()
                        dir = cam.get_gameplay_cam_rot()
                        dir:transformRotToDir()
                        dir = dir * 1500
                        v3_end = v3_end + dir
                        local hash_weapon = ped.get_current_ped_weapon(get.OwnPed())
                        gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, hash_weapon, get.OwnPed(), true, false, 1000)
                        coroutine.yield(0)
                    end
                end
            elseif f.value == 1 and get.OwnVehicle() == 0 then
                if ped.is_ped_shooting(get.OwnPed()) then
                    for i = 1, 25 do
                        local v3_start = Math.GetPedBoneCoords(get.OwnPed(), 0x67f2)
                        local dir = cam.get_gameplay_cam_rot()
                        dir:transformRotToDir()
                        dir = dir * 1.5
                        v3_start = v3_start + dir
                        dir = nil
                        local v3_end = get.OwnCoords()
                        dir = cam.get_gameplay_cam_rot()
                        dir:transformRotToDir()
                        dir = dir * 1500
                        v3_end = v3_end + dir
                        local hash_weapon = ped.get_current_ped_weapon(get.OwnPed())
                        gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, hash_weapon, get.OwnPed(), true, false, 1000)
                        coroutine.yield(0)
                    end
                end
            end
            settings['Rapid Fire'].Value = f.value
            coroutine.yield(0)
        end
        settings['Rapid Fire'].Enabled = f.on
    end)
    Script.Feature['Rapid Fire']:set_str_data({'v1', 'v2'})


    Script.Parent['Health Features'] = menu.add_feature('Health Modifier', 'parent', Script.Parent['local_player'], nil).id

    Script.Feature['Fill Health'] = menu.add_feature('Fill Health', 'action', Script.Parent['Health Features'], function()
        if player.get_player_max_health(player.player_id()) ~= player.get_player_health(player.player_id()) then
            ped.set_ped_health(get.OwnPed(), max)
            Notify('Filled health!', "Success")
        end
    end)

    Script.Feature['Quick Regeneration'] = menu.add_feature('Quick Regeneration', 'toggle', Script.Parent['Health Features'], function(f)
        settings['Quick Regeneration'] = {Enabled = f.on}
        while f.on do
            local max = player.get_player_max_health(player.player_id())
            local current = player.get_player_health(player.player_id())
            if max > current then
                ped.set_ped_health(get.OwnPed(), current + 1)
            end
            coroutine.yield(0)
        end
        settings['Quick Regeneration'].Enabled = f.on
    end)

    Script.Feature['Set Health'] = menu.add_feature('Set Health: Input', 'action', Script.Parent['Health Features'], function()
        local health = get.Input('Enter Custom Health Value (100 - 1000000000)', 10, 3)
        if not health then
            Notify('Input canceled.', "Error", '')
            return
        end
        if tonumber(health) < 100 or tonumber(health) > 1000000000 then
            Notify('Value must be between 100 and 1000000000', "Error", '')
            return
        end
        ped.set_ped_health(get.OwnPed(), health)
        ped.set_ped_max_health(get.OwnPed(), health)
        Notify('Health successfully set to: ' .. health, "Success")
    end)

    Script.Feature['Unlimited regeneration'] = menu.add_feature('Unlimited Health regeneration', 'toggle', Script.Parent['Health Features'], function(f)
        settings['Unlimited regeneration'] = {Enabled = f.on}
        while f.on do
            local current = player.get_player_health(player.player_id())
            local new_health = current + current * 0.005
            if new_health < 500000000 then
                ped.set_ped_health(get.OwnPed(), new_health)
                ped.set_ped_max_health(get.OwnPed(), new_health)
            end
            coroutine.yield(0)
        end
        settings['Unlimited regeneration'].Enabled = f.on

        if Script.Feature['Revert Health'].on then
            ped.set_ped_max_health(get.OwnPed(), 328)
            ped.set_ped_health(get.OwnPed(), 328)
        end
    end)

    Script.Feature['Revert Health'] = menu.add_feature('Revert health after disabling Health regeneration', 'toggle', Script.Parent['Health Features'], function(f)
        settings['Revert Health'] = {Enabled = f.on}
    end)

    Script.Feature['Undead OTR'] = menu.add_feature('Undead OTR', 'toggle', Script.Parent['Health Features'], function(f)
        settings['Undead OTR'] = {Enabled = f.on}
        while f.on do
            local max = player.get_player_max_health(player.player_id())
            if max ~= 0 then
                ped.set_ped_max_health(get.OwnPed(), 0)
            end
            coroutine.yield(0)
        end
        settings['Undead OTR'].Enabled = f.on
        ped.set_ped_max_health(get.OwnPed(), 328)
    end)

    Script.Feature['Ragdoll Self'] = menu.add_feature('Ragdoll Self', 'action', Script.Parent['local_player'], function()
        ped.set_ped_to_ragdoll(get.OwnPed(), 2500, 0, 0)
    end)

    Script.Feature['Ragdoll Self Loop'] = menu.add_feature('Ragdoll Self (Loop)', 'toggle', Script.Parent['local_player'], function(f)
        while f.on do
            ped.set_ped_to_ragdoll(get.OwnPed(), 2500, 0, 0)
            coroutine.yield(0)
        end
    end)

    Script.Feature['Always have Parachute'] = menu.add_feature('Always have Parachute', 'toggle', Script.Parent['local_player'], function(f)
        settings['Always have Parachute'] = {Enabled = f.on}
        while f.on do
            local Ped = get.OwnPed()
            if not weapon.has_ped_got_weapon(Ped, 0xFBAB5776) then
                weapon.give_delayed_weapon_to_ped(Ped, 0xFBAB5776, 1, 1)
            end

            coroutine.yield(1000)
        end
        settings['Always have Parachute'].Enabled = f.on
    end)


    Script.Feature['Respawn at Position of Death'] = menu.add_feature('Respawn at Position of Death', 'toggle', Script.Parent['local_player'], function(f)
        settings['Respawn at Position of Death'] = {Enabled = f.on}
        while f.on do
            local pos = get.OwnCoords()

            if player.get_player_health(player.player_id()) == 0 then
                while player.get_player_health(player.player_id()) ~= player.get_player_max_health(player.player_id()) do
                    coroutine.yield(0)
                end

                pos.z = Math.GetGroundZ(pos.x, pos.y) + 1
                utility.tp(pos)
            end
            coroutine.yield(0)
        end
        settings['Respawn at Position of Death'].Enabled = f.on
    end)


    Script.Parent['Aim Protection'] = menu.add_feature('Aim Protection', 'parent', Script.Parent['local_player'], nil).id

    Script.Feature['Enable Aim Protection'] = menu.add_feature('Enable Aim Protection', 'value_str', Script.Parent['Aim Protection'], function(f)
        settings['Enable Aim Protection'] = {Enabled = f.on, Value = f.value}

        while f.on do
            local exclude
            if f.value == 0 then
                exclude = false
            else
                exclude = true
            end

            for id = 0, 31 do
                if utility.valid_player(id, exclude) then
                    local target = player.get_entity_player_is_aiming_at(id)
                    if target ~= 0 then
                        if target == get.OwnPed() then
                            if Script.Feature['Aim Protection Notify'].on then                                
                                Notify('Detected ' .. get.Name(id) .. ' aiming at you! Applying chosen punishments...', "Neutral", '2Take1Script Aim Protection')
                            end

                            if Script.Feature['Aim Protection Anonymous Explosion'].on then
                                fire.add_explosion(get.PlayerCoords(id), 8, false, true, 0, get.PlayerPed(id))
                                coroutine.yield(75)
                            end

                            if Script.Feature['Aim Protection Named Explosion'].on then
                                fire.add_explosion(get.PlayerCoords(id), 8, false, true, 0, get.OwnPed())
                                coroutine.yield(75)
                            end

                            if Script.Feature['Aim Protection Freeze'].on then
                                ped.clear_ped_tasks_immediately(get.PlayerPed(id))
                                coroutine.yield(0)
                            end

                            if Script.Feature['Aim Protection Ragdoll'].on then
                                fire.add_explosion(get.PlayerCoords(id), 13, false, true, 0, 0)
                                coroutine.yield(75)
                            end

                            if Script.Feature['Aim Protection Fire'].on then
                                graphics.set_next_ptfx_asset('scr_recrash_rescue')
                                while not graphics.has_named_ptfx_asset_loaded('scr_recrash_rescue') do
                                    graphics.request_named_ptfx_asset('scr_recrash_rescue')
                                    coroutine.yield(0)
                                end
                                graphics.start_networked_ptfx_looped_on_entity('scr_recrash_rescue_fire', get.PlayerPed(id), v3(), v3(), 1)
                                coroutine.yield(75)
                            end

                            if Script.Feature['Aim Protection Remove Weapon'].on then
                                local playerped = get.PlayerPed(id)
                                ped.set_ped_can_switch_weapons(playerped, false)
                                weapon.remove_weapon_from_ped(playerped, ped.get_current_ped_weapon(playerped))
                                ped.set_ped_can_switch_weapons(playerped, false)
                                coroutine.yield(75)
                            end

                            if Script.Feature['Aim Protection Warehouse Invite'].on then
                                scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, math.random(1, 22)}, id)
                                coroutine.yield(75)
                            end

                            if Script.Feature['Aim Protection Apartment Invite'].on then
                                scriptevent.Send('Apartment Invite', {player.player_id(), id, 1, 0, math.random(1, 113), 1, 1, 1}, id)
                                coroutine.yield(75)
                            end

                            if Script.Feature['Aim Protection Electrocute'].on then
                                local pos = get.PlayerCoords(id)
                                gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 2), pos, 0, 0x3656C8C1, get.OwnPed(), true, false, 10000)
                                coroutine.yield(75)
                            end

                            if Script.Feature['Aim Protection Kick'].on then
                                if Script.Feature['Aim Protection Kick'].value == 0 then
                                    kick_player(id)
                                else
                                    network.force_remove_player(id)
                                end
                                coroutine.yield(500)
                            end

                            if Script.Feature['Aim Protection Crash'].on then
                                scriptevent.crash(id)
                                coroutine.yield(500)
                            end
                        end
                    end
                end
            end
            settings['Enable Aim Protection'].Value = f.value
            coroutine.yield(0)
        end
        settings['Enable Aim Protection'].Enabled = f.on
    end)
    Script.Feature['Enable Aim Protection']:set_str_data({'All Players', 'Exclude Friends'})

    Script.Feature['Aim Protection Notify'] = menu.add_feature('Notify Triggered Protections', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Notify'] = {Enabled = f.on}
    end)

    Script.Feature['Aim Protection Anonymous Explosion'] = menu.add_feature('Anonymous Explosion', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Anonymous Explosion'] = {Enabled = f.on}
    end)

    Script.Feature['Aim Protection Named Explosion'] = menu.add_feature('Named Explosion', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Named Explosion'] = {Enabled = f.on}
    end)

    Script.Feature['Aim Protection Freeze'] = menu.add_feature('Freeze', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Freeze'] = {Enabled = f.on}
    end)

    Script.Feature['Aim Protection Ragdoll'] = menu.add_feature('Ragdoll', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Ragdoll'] = {Enabled = f.on}
    end)

    Script.Feature['Aim Protection Fire'] = menu.add_feature('Set on Fire', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Fire'] = {Enabled = f.on}
    end)

    Script.Feature['Aim Protection Remove Weapon'] = menu.add_feature('Remove Weapon', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Remove Weapon'] = {Enabled = f.on}
    end)

    Script.Feature['Aim Protection Apartment Invite'] = menu.add_feature('Apartment Invite', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Apartment Invite'] = {Enabled = f.on}
    end)

    Script.Feature['Aim Protection Warehouse Invite'] = menu.add_feature('Warehouse Invite', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Warehouse Invite'] = {Enabled = f.on}
    end)

    Script.Feature['Aim Protection Electrocute'] = menu.add_feature('Electrocute', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Electrocute'] = {Enabled = f.on}
    end)
    
    Script.Feature['Aim Protection Kick'] = menu.add_feature('Kick', 'value_str', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Kick'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Aim Protection Kick']:set_str_data({'Script Kick', 'Desync Kick'})

    Script.Feature['Aim Protection Crash'] = menu.add_feature('Crash', 'toggle', Script.Parent['Aim Protection'], function(f)
        settings['Aim Protection Crash'] = {Enabled = f.on}
    end)
    

    Script.Parent['Bodyguards'] = menu.add_feature('Bodyguards', 'parent', Script.Parent['local_player'], nil).id

    Script.Parent['Bodyguard Spawn Settings'] = menu.add_feature('Spawn Settings', 'parent', Script.Parent['Bodyguards'], nil).id

    Script.Feature['Bodyguard Godmode'] = menu.add_feature('Godmode Bodyguards', 'toggle', Script.Parent['Bodyguard Spawn Settings'], function(f)
        settings['Bodyguard Godmode'] = {Enabled = f.on}
    end)

    Script.Feature['Bodyguard No Ragdoll'] = menu.add_feature('Disable Ragdoll', 'toggle', Script.Parent['Bodyguard Spawn Settings'], function(f)
        settings['Bodyguard No Ragdoll'] = {Enabled = f.on}
    end)

    Script.Feature['Bodyguard Marker'] = menu.add_feature('Add Map Marker', 'toggle', Script.Parent['Bodyguard Spawn Settings'], function(f)
        settings['Bodyguard Marker'] = {Enabled = f.on}
    end)

    Script.Feature['Bodyguard Health'] = menu.add_feature('Health', 'action_value_i', Script.Parent['Bodyguard Spawn Settings'], function(f)
        local health = tonumber(get.Input('Enter Bodyguards Health Value (100 - 1000000)', 7, 3))
        if not health then
            Notify('Input canceled.', "Error", '')
            return
        end

        if health < 100 or health > 1000000 then
            Notify('Value must be between 100 and 1000000', "Error", '')
            return
        end

        f.value = health
        Notify('Bodyguards Health set to: ' .. f.value, "Success")
        settings['Bodyguard Health'] = {Value = f.value}
    end)
    Script.Feature['Bodyguard Health'].min = 100
    Script.Feature['Bodyguard Health'].max = 1000000

    for i = 1, #customData.Bodyguards do
        local name = customData.Bodyguards[i].Name
        local stringdata = {}
        for j = 1, #customData.Bodyguards[i].Children do
            stringdata[j] = customData.Bodyguards[i].Children[j].Name
        end

        Script.Feature['Bodyguard ' .. name] = menu.add_feature(name, 'autoaction_value_str', Script.Parent['Bodyguard Spawn Settings'], function(f)
            settings['Bodyguard ' .. name] = {Value = f.value}
        end)
        Script.Feature['Bodyguard ' .. name]:set_str_data(stringdata)
    end

    Script.Feature['Bodyguard Aim Shot'] = menu.add_feature('Shoot at your Aim Target', 'toggle', Script.Parent['Bodyguards'], function(f)
        settings['Bodyguard Aim Shot'] = {Enabled = f.on}
    end)

    Script.Feature['Bodyguard Behavior'] = menu.add_feature('Combat Behavior', 'autoaction_value_str', Script.Parent['Bodyguards'], function(f)
        settings['Bodyguard Behavior'] = {Value = f.value}
    end)
    Script.Feature['Bodyguard Behavior']:set_str_data({'Stationary', 'Defensive', 'Offensive'})


    Script.Feature['Bodyguard Distance'] = menu.add_feature('Max Distance To Player', 'autoaction_value_i', Script.Parent['Bodyguards'], function(f)
        settings['Bodyguard Distance'] = {Value = f.value}
    end)
    Script.Feature['Bodyguard Distance'].min = 50
    Script.Feature['Bodyguard Distance'].max = 500
    Script.Feature['Bodyguard Distance'].mod = 50


    Script.Feature['Bodyguard Formation'] = menu.add_feature('Formation', 'autoaction_value_str', Script.Parent['Bodyguards'], function(f)
        settings['Bodyguard Formation'] = {Value = f.value}
    end)
    Script.Feature['Bodyguard Formation']:set_str_data({'Nothing', 'Circle 1', 'Circle 2', 'Line'})


    Script.Feature['Bodyguard Count'] = menu.add_feature('Amount of Bodyguards', 'autoaction_value_i', Script.Parent['Bodyguards'], function(f)
        settings['Bodyguard Count'] = {Value = f.value}
    end)
    Script.Feature['Bodyguard Count'].min = 1
    Script.Feature['Bodyguard Count'].max = 7


    Script.Feature['Enable Bodyguards'] = menu.add_feature('Enable Bodyguards', 'toggle', Script.Parent['Bodyguards'], function(f)
        while f.on do
            local ped_group = player.get_player_group(player.player_id())

            local pedhash = customData.Bodyguards[1].Children[Script.Feature['Bodyguard Ped Type'].value + 1].Hash
            local weaponhash = customData.Bodyguards[2].Children[Script.Feature['Bodyguard Primary Weapon'].value + 1].Hash
            local weaponhash2 = customData.Bodyguards[3].Children[Script.Feature['Bodyguard Secondary Weapon'].value + 1].Hash

            local running = {}

            for g = 1, #entitys['bodyguards'] do
                if g > Script.Feature['Bodyguard Count'].value then
                    utility.clear(entitys['bodyguards'][g])
                    entitys['bodyguards'][g] = nil
                end
            end

            for i = 1, Script.Feature['Bodyguard Count'].value do
                if not entitys['bodyguards'][i] or entity.is_entity_dead(entitys['bodyguards'][i]) then
                    if entitys['bodyguards'][i] and entity.is_entity_dead(entitys['bodyguards'][i]) then
                        utility.clear({entitys['bodyguards'][i]})
                    end

                    local pos = get.OwnCoords()
                    pos.x = pos.x + math.random(-5, 5)
                    pos.y = pos.y + math.random(-5, 5)
                    pos.z = Math.GetGroundZ(pos.x, pos.y)

                    if pedhash == -1 then
                        entitys['bodyguards'][i] = ped.clone_ped(get.OwnPed())
                        utility.set_coords(entitys['bodyguards'][i], pos)

                    elseif pedhash == -2 then
                        local hash = customData.Bodyguards[1].Children[math.random(#customData.Bodyguards[1].Children)].Hash

                        while hash == -1 or hash == -2 do
                            hash = customData.Bodyguards[1].Children[math.random(#customData.Bodyguards[1].Children)].Hash
                        end

                        entitys['bodyguards'][i] = Spawn.Ped(hash, pos, 29)
                        if hash == 2633130371 or hash == 0x81441B71 then
                            ped.set_ped_component_variation(entitys['bodyguards'][i], 8, 1, 1, 1)
                        end
                    else
                        entitys['bodyguards'][i] = Spawn.Ped(pedhash, pos, 29)
                        if pedhash == 2633130371 or pedhash == 0x81441B71 then
                            ped.set_ped_component_variation(entitys['bodyguards'][i], 8, 1, 1, 1)
                        end
                    end

                    if Script.Feature['Bodyguard Godmode'].on then
                        entity.set_entity_god_mode(entitys['bodyguards'][i], true)
                    else
                        ped.set_ped_max_health(entitys['bodyguards'][i], Script.Feature['Bodyguard Health'].value)
                        ped.set_ped_health(entitys['bodyguards'][i], Script.Feature['Bodyguard Health'].value)
                    end

                    if Script.Feature['Bodyguard No Ragdoll'].on then
                        for j = 1, 26 do
                            ped.set_ped_ragdoll_blocking_flags(entitys['bodyguards'][i], j)
                        end
                    end

                    if Script.Feature['Bodyguard Marker'].on then
                        local blip = ui.add_blip_for_entity(entitys['bodyguards'][i])
                        ui.set_blip_sprite(blip, 310)
                        ui.set_blip_colour(blip, 80)
                    end

                    if weaponhash ~= -1 then
                        if weaponhash == -2 then
                            local hash = customData.Bodyguards[2].Children[math.random(#customData.Bodyguards[2].Children)].Hash

                            while hash == -1 or hash == -2 do
                                hash = customData.Bodyguards[2].Children[math.random(#customData.Bodyguards[2].Children)].Hash
                            end

                            weapon.give_delayed_weapon_to_ped(entitys['bodyguards'][i], hash, 0, 1)
                        else
                            weapon.give_delayed_weapon_to_ped(entitys['bodyguards'][i], weaponhash, 0, 1)
                        end
                    end

                    if weaponhash2 ~= -1 then
                        if weaponhash2 == -2 then
                            local hash = customData.Bodyguards[3].Children[math.random(#customData.Bodyguards[3].Children)].Hash

                            while hash == -1 or hash == -2 do
                                hash = customData.Bodyguards[3].Children[math.random(#customData.Bodyguards[3].Children)].Hash
                            end

                            weapon.give_delayed_weapon_to_ped(entitys['bodyguards'][i], hash, 0, 1)
                        else
                            weapon.give_delayed_weapon_to_ped(entitys['bodyguards'][i], weaponhash2, 0, 1)
                        end
                    end

                    ped.set_ped_combat_ability(entitys['bodyguards'][i], 100)
                    ped.set_can_attack_friendly(entitys['bodyguards'][i], false, false)
                    entity.set_entity_as_mission_entity(entitys['bodyguards'][i], 1, 1)
                end
                -- AI
                if not running[i] or menu.has_thread_finished(running[i]) then
                    running[i] = menu.create_thread(function(bodyguard)
                        if not entity.is_entity_dead(bodyguard) then
                            utility.request_ctrl(bodyguard)

                            if ped.get_ped_group(bodyguard) ~= ped_group then
                                ped.set_ped_as_group_member(bodyguard, ped_group)
                                ped.set_ped_never_leaves_group(bodyguard, true)
                            end

                            ped.set_ped_combat_movement(bodyguard, Script.Feature['Bodyguard Behavior'].value)
                            ped.set_group_formation(ped_group, Script.Feature['Bodyguard Formation'].value)

                            if Script.Feature['Bodyguard Aim Shot'].on then
                                if player.is_player_free_aiming(player.player_id()) then
                                    local target = player.get_entity_player_is_aiming_at(player.player_id())

                                    if target ~= 0 then
                                        ai.task_shoot_at_entity(bodyguard, target, 100, 0xC6EE6B4C)
                                    else
                                        local pos = get.OwnCoords()
                                        local dir = cam.get_gameplay_cam_rot()
                                        dir:transformRotToDir()
                                        dir = dir * math.random(1, 50)
                                        pos = pos + dir
                                        ai.task_shoot_gun_at_coord(bodyguard, pos, 100, 0xC6EE6B4C)
                                    end

                                end

                            end

                            -- TP Bodyguards back to Player
                            if get.OwnCoords():magnitude(entity.get_entity_coords(bodyguard)) > Script.Feature['Bodyguard Distance'].value then
                                utility.set_coords(bodyguard, utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), -5))
                            end
                        end
                        coroutine.yield(100)
                    end, entitys['bodyguards'][i])
                end
            end
            coroutine.yield(200)
        end
        utility.clear(entitys['bodyguards'])
        entitys['bodyguards'] = {}
    end)

    Script.Parent['Personal Vehicle'] = menu.add_feature('Personal Vehicle', 'parent', Script.Parent['local_vehicle'], nil).id

    Script.Feature['Teleport To Personal Vehicle'] = menu.add_feature('Teleport to Personal Vehicle', 'action', Script.Parent['Personal Vehicle'], function(f)
        local veh = player.get_personal_vehicle()
        local veh2 = get.OwnVehicle()
        if veh ~= 0 then
            if veh2 ~= veh then
                utility.tp(utility.OffsetCoords(entity.get_entity_coords(veh), entity.get_entity_heading(veh), -5), 0, entity.get_entity_heading(veh))
            end
        else
            Notify('No Personal Vehicle found!', "Error", '')
        end
    end)

    Script.Feature['Drive Personal Vehicle'] = menu.add_feature('Drive Personal Vehicle', 'action', Script.Parent['Personal Vehicle'], function()
        local veh = player.get_personal_vehicle()
        local veh2 = get.OwnVehicle()
        if veh ~= 0 then
            if veh2 ~= veh then
                ped.set_ped_into_vehicle(get.OwnPed(), veh, -1)
            end
        else
            Notify('No Personal Vehicle found!', "Error", '')
        end
    end)

    Script.Feature['Teleport Personal Vehicle To Me'] = menu.add_feature('Teleport Personal Vehicle to me', 'action', Script.Parent['Personal Vehicle'], function()
        local veh = player.get_personal_vehicle()
        local veh2 = get.OwnVehicle()
        if veh ~= 0 then
            if veh2 ~= veh then
                utility.set_coords(veh, utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 5))
                entity.set_entity_heading(veh, get.OwnHeading())
            end
        else
            Notify('No Personal Vehicle found!', "Error", '')
        end
    end)

    Script.Feature['TP Personal Vehicle To Me And Drive'] = menu.add_feature('Teleport Personal Vehicle to me and drive', 'action', Script.Parent['Personal Vehicle'], function()
        local veh = player.get_personal_vehicle()
        local veh2 = get.OwnVehicle()
        if veh ~= 0 then
            if veh2 ~= veh then
                utility.set_coords(veh, get.OwnCoords())
                entity.set_entity_heading(veh, get.OwnHeading())
                ped.set_ped_into_vehicle(get.OwnPed(), veh, -1)
            end
        else
            Notify('No Personal Vehicle found!', "Error", '')
        end
    end)


    Script.Parent['Vehice Colors'] = menu.add_feature('Vehicle Colors', 'parent', Script.Parent['local_vehicle'], nil).id

    Script.Feature['Vehicle Colors Speed'] = menu.add_feature('Speed in Milliseconds', 'autoaction_value_i', Script.Parent['Vehice Colors'], function(f)
        settings['Vehicle Colors Speed'] = {Value = f.value}
    end)
    Script.Feature['Vehicle Colors Speed'].min = 100
    Script.Feature['Vehicle Colors Speed'].max = 10000
    Script.Feature['Vehicle Colors Speed'].mod = 100


    Script.Parent['Random Colors'] = menu.add_feature('Random Colors', 'parent', Script.Parent['Vehice Colors'], nil).id

    
    Script.Feature['Random Primary Color'] = menu.add_feature('Random Primary', 'toggle', Script.Parent['Random Colors'], function(f)
        ToggleOff({'Synced Colors', 'Rainbow Primary Color', '100 Black'})
        settings['Random Primary Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                vehicle.set_vehicle_custom_primary_colour(veh, math.random(0, 0xffffff))
                coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
            end

            coroutine.yield(0)
        end
        settings['Random Primary Color'].Enabled = f.on
    end)
    
    Script.Feature['Random Secondary Color'] = menu.add_feature('Random Secondary', 'toggle', Script.Parent['Random Colors'], function(f)
        ToggleOff({'Synced Colors', 'Rainbow Secondary Color', '100 Black'})
        settings['Random Secondary Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                vehicle.set_vehicle_custom_secondary_colour(veh, math.random(0, 0xffffff))
                coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
            end

            coroutine.yield(0)
        end
        settings['Random Secondary Color'].Enabled = f.on
    end)

    Script.Feature['Random Wheel Color'] = menu.add_feature('Random Wheel', 'toggle', Script.Parent['Random Colors'], function(f)
        ToggleOff({'Synced Colors', 'Rainbow Wheel Color', '100 Black'})
        settings['Random Wheel Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                vehicle.set_vehicle_custom_wheel_colour(veh, math.random(0, 0xffffff))
                coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
            end

            coroutine.yield(0)
        end
        settings['Random Wheel Color'].Enabled = f.on
    end)

    Script.Feature['Random Pearlescent Color'] = menu.add_feature('Random Pearlescent', 'toggle', Script.Parent['Random Colors'], function(f)
        ToggleOff({'Synced Colors', 'Rainbow Pearlescent Color', '100 Black'})
        settings['Random Pearlescent Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                vehicle.set_vehicle_custom_pearlescent_colour(veh, math.random(0, 0xffffff))
                coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
            end

            coroutine.yield(0)
        end
        settings['Random Pearlescent Color'].Enabled = f.on
    end)

    Script.Feature['Random Neon Color'] = menu.add_feature('Random Neon Lights', 'toggle', Script.Parent['Random Colors'], function(f)
        ToggleOff({'Synced Colors', 'Rainbow Neon Color', '100 Black'})
        settings['Random Neon Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                local color = math.random(0, 0xffffff)

                vehicle.set_vehicle_neon_lights_color(veh, color)
                coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
            end

            coroutine.yield(0)
        end
        settings['Random Neon Color'].Enabled = f.on
    end)

    Script.Feature['Random Smoke Color'] = menu.add_feature('Random Smoke', 'toggle', Script.Parent['Random Colors'], function(f)
        ToggleOff({'Synced Colors', 'Rainbow Smoke Color', '100 Black'})
        settings['Random Smoke Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                local colorR = math.random(0, 255)
                local colorG = math.random(0, 255)
                local colorB = math.random(0, 255)

                vehicle.set_vehicle_tire_smoke_color(veh, colorR, colorG, colorB)
                coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
            end

            coroutine.yield(0)
        end
        settings['Random Smoke Color'].Enabled = f.on
    end)

    Script.Feature['Random Xenon Color'] = menu.add_feature('Random Xenon', 'toggle', Script.Parent['Random Colors'], function(f)
        ToggleOff({'Synced Colors', 'Rainbow Xenon Color', '100 Black'})
        settings['Random Xenon Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                vehicle.set_vehicle_headlight_color(veh, math.random(0, 12))
                coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
            end

            coroutine.yield(0)
        end
        settings['Random Xenon Color'].Enabled = f.on
    end)


    Script.Parent['Rainbow Colors'] = menu.add_feature('Rainbow Colors', 'parent', Script.Parent['Vehice Colors'], nil).id

    Script.Feature['Rainbow Primary Color'] = menu.add_feature('Rainbow Primary', 'toggle', Script.Parent['Rainbow Colors'], function(f)
        ToggleOff({'Synced Colors', 'Random Primary Color', '100 Black'})
        settings['Rainbow Primary Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                for i = 1, #neon_lights_rgb do
                    vehicle.set_vehicle_custom_primary_colour(veh, Math.RGBToHex({neon_lights_rgb[i][1], neon_lights_rgb[i][2], neon_lights_rgb[i][3]}))
                    coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
                end

            end

            coroutine.yield(0)
        end
        settings['Rainbow Primary Color'].Enabled = f.on
    end)

    Script.Feature['Rainbow Secondary Color'] = menu.add_feature('Rainbow Secondary', 'toggle', Script.Parent['Rainbow Colors'], function(f)
        ToggleOff({'Synced Colors', 'Random Secondary Color', '100 Black'})
        settings['Rainbow Secondary Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                for i = 1, #neon_lights_rgb do
                    vehicle.set_vehicle_custom_secondary_colour(veh, Math.RGBToHex({neon_lights_rgb[i][1], neon_lights_rgb[i][2], neon_lights_rgb[i][3]}))
                    coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
                end

            end

            coroutine.yield(0)
        end
        settings['Rainbow Secondary Color'].Enabled = f.on
    end)

    Script.Feature['Rainbow Wheel Color'] = menu.add_feature('Rainbow Wheel', 'toggle', Script.Parent['Rainbow Colors'], function(f)
        ToggleOff({'Synced Colors', 'Random Wheel Color', '100 Black'})
        settings['Rainbow Wheel Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                for i = 1, #neon_lights_rgb do
                    vehicle.set_vehicle_custom_wheel_colour(veh, Math.RGBToHex({neon_lights_rgb[i][1], neon_lights_rgb[i][2], neon_lights_rgb[i][3]}))
                    coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
                end

            end

            coroutine.yield(0)
        end
        settings['Rainbow Wheel Color'].Enabled = f.on
    end)

    Script.Feature['Rainbow Pearlescent Color'] = menu.add_feature('Rainbow Pearlescent', 'toggle', Script.Parent['Rainbow Colors'], function(f)
        ToggleOff({'Synced Colors', 'Random Pearlescent Color', '100 Black'})
        settings['Rainbow Pearlescent Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                for i = 1, #neon_lights_rgb do
                    vehicle.set_vehicle_custom_pearlescent_colour(veh, Math.RGBToHex({neon_lights_rgb[i][1], neon_lights_rgb[i][2], neon_lights_rgb[i][3]}))
                    coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
                end

            end

            coroutine.yield(0)
        end
        settings['Rainbow Pearlescent Color'].Enabled = f.on
    end)

    Script.Feature['Rainbow Neon Color'] = menu.add_feature('Rainbow Neon Lights', 'toggle', Script.Parent['Rainbow Colors'], function(f)
        ToggleOff({'Synced Colors', 'Random Neon Color', '100 Black'})
        settings['Rainbow Neon Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                for i = 1, #neon_lights_rgb do
                    vehicle.set_vehicle_neon_lights_color(veh, Math.RGBToHex({neon_lights_rgb[i][1], neon_lights_rgb[i][2], neon_lights_rgb[i][3]}))
                    coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
                end

            end

            coroutine.yield(0)
        end
        settings['Rainbow Neon Color'].Enabled = f.on
    end)

    Script.Feature['Rainbow Smoke Color'] = menu.add_feature('Rainbow Smoke', 'toggle', Script.Parent['Rainbow Colors'], function(f)
        ToggleOff({'Synced Colors', 'Random Smoke Color', '100 Black'})
        settings['Rainbow Smoke Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                for i = 1, #neon_lights_rgb do
                    local c = neon_lights_rgb[i]
                    vehicle.set_vehicle_tire_smoke_color(veh, c[1], c[2], c[3])
                    coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
                end

            end

            coroutine.yield(0)
        end
        settings['Rainbow Smoke Color'].Enabled = f.on
    end)

    Script.Feature['Rainbow Xenon Color'] = menu.add_feature('Rainbow Xenon', 'toggle', Script.Parent['Rainbow Colors'], function(f)
        ToggleOff({'Synced Colors', 'Random Xenon Color', '100 Black'})
        settings['Rainbow Xenon Color'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                for i = 0, 12 do
                    vehicle.set_vehicle_headlight_color(veh, i)
                    coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
                end

            end

            coroutine.yield(0)
        end
        settings['Rainbow Xenon Color'].Enabled = f.on
    end)

    Script.Feature['Synced Colors'] = menu.add_feature('Synced Colors', 'value_str', Script.Parent['Vehice Colors'], function(f)
        ToggleOff(rainbow_colors)
        ToggleOff(random_colors)
        ToggleOff({'100 Black'})
        settings['Synced Colors'] = {Enabled = f.on, Value = f.value}

        while f.on do
            if f.value == 0 then
                local veh = get.OwnVehicle()

                if utility.valid_vehicle(veh) then
                    utility.color_veh(veh, {math.random(0, 255), math.random(0, 255), math.random(0, 255)})
                    coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
                end
            end
            if f.value == 1 then
                local veh = get.OwnVehicle()

                if utility.valid_vehicle(veh) then
                    for i = 1, #neon_lights_rgb do
                        if veh ~= get.OwnVehicle() or f.value ~= 1 then
                            break
                        end

                        if not f.on then
                            settings['Synced Colors'].Enabled = f.on
                            return
                        end

                        local c = neon_lights_rgb[i]

                        utility.color_veh(veh, {c[1], c[2], c[3]}, i)
                        coroutine.yield(Script.Feature['Vehicle Colors Speed'].value)
                    end
                end
            end
            if f.value == 2 then
                local veh = get.OwnVehicle()

                if utility.valid_vehicle(veh) then
                    local step

                    step = math.floor((101 - (Script.Feature['Vehicle Colors Speed'].value / 25)) / 2)
                    if step < 1 then
                        step = 1
                    end
                    for i = 0, 255, step do
                        if not f.on then
                            settings['Synced Colors'].Enabled = f.on
                            return
                        end

                        utility.color_veh(veh, {255, i, 0})
                    end

                    step = math.floor((101 - (Script.Feature['Vehicle Colors Speed'].value / 25)) / 2)
                    if step < 1 then
                        step = 1
                    end
                    for i = 255, 0, -step do
                        if not f.on then
                            settings['Synced Colors'].Enabled = f.on
                            return
                        end
                        utility.color_veh(veh, {i, 255, 0})
                    end
                    
                    step = math.floor((101 - (Script.Feature['Vehicle Colors Speed'].value / 25)) / 2)
                    if step < 1 then
                        step = 1
                    end
                    for i = 0, 255, step do
                        if not f.on then
                            settings['Synced Colors'].Enabled = f.on
                            return
                        end
                        utility.color_veh(veh, {0, 255, i})
                    end
                    step = math.floor((101 - (Script.Feature['Vehicle Colors Speed'].value / 25)) / 2)
                    if step < 1 then
                        step = 1
                    end
                    for i = 255, 0, -step do
                        if not f.on then
                            settings['Synced Colors'].Enabled = f.on
                            return
                        end
                        utility.color_veh(veh, {0, i, 255})
                    end
                    step = math.floor((101 - (Script.Feature['Vehicle Colors Speed'].value / 25)) / 2)
                    if step < 1 then
                        step = 1
                    end
                    for i = 0, 255, step do
                        if not f.on then
                            settings['Synced Colors'].Enabled = f.on
                            return
                        end
                        utility.color_veh(veh, {i, 0, 255})
                    end
                    step = math.floor((101 - (Script.Feature['Vehicle Colors Speed'].value / 25)) / 2)
                    if step < 1 then
                        step = 1
                    end
                    for i = 255, 0, -step do
                        if not f.on then
                            settings['Synced Colors'].Enabled = f.on
                            return
                        end
                        utility.color_veh(veh, {255, 0, i})
                    end
                end
            end
            settings['Synced Colors'].Value = f.value
            coroutine.yield(0)
        end
        settings['Synced Colors'].Enabled = f.on
    end)
    Script.Feature['Synced Colors']:set_str_data({'Random', 'Rainbow', 'Smooth Rainbow'})

    Script.Feature['100 Black Single'] = menu.add_feature('100% Black', 'action', Script.Parent['Vehice Colors'], function()
        local veh = get.OwnVehicle()
        if utility.valid_vehicle(veh) then
            utility.color_veh(veh, {0, 0, 0}, 0)
            vehicle.set_vehicle_tire_smoke_color(veh, 1, 1, 1)
        else
            Notify('No valid vehicle found.', "Error")
        end
    end)

    Script.Feature['100 Black'] = menu.add_feature('100% Black', 'toggle', Script.Parent['Vehice Colors'], function(f)
        settings['100 Black'] = {Enabled = f.on}
        ToggleOff(rainbow_colors)
        ToggleOff(random_colors)
        ToggleOff({'Synced Colors'})

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.color_veh(veh, {0, 0, 0}, 0)
                vehicle.set_vehicle_tire_smoke_color(veh, 1, 1, 1)
            end

            coroutine.yield(0)
        end
        settings['100 Black'].Enabled = f.on
    end)

    Script.Parent['Explosive Horn Beam'] = menu.add_feature('Explosive Horn Beam', 'parent', Script.Parent['local_vehicle'], nil).id
    
    Script.Feature['Enable Horn Beam'] = menu.add_feature('Enable Horn Beam', 'toggle', Script.Parent['Explosive Horn Beam'], function(f)
        settings['Enable Horn Beam'] = {Enabled = f.on}
        while f.on do
            local user = player.player_id()
            if get.SCID(Script.Feature['Horn Beam For Others'].value) ~= -1 then
                user = Script.Feature['Horn Beam For Others'].value
            end
            local veh, pos, pos2, einheitsvektor, modifikator
            local vectorV3 = v3()
            local pxmin, pxmax, pymin, pymax, pzmin, pzmax
            if player.is_player_pressing_horn(user) then
                veh = get.PlayerVehicle(user)
                for i = 0, 5 do
                    pos = entity.get_entity_coords(veh)
                    coroutine.yield(5)
                    if i > 0 then
                        pos2 = entity.get_entity_coords(veh)
                        vectorV3.x = pos2.x - pos.x
                        vectorV3.y = pos2.y - pos.y
                        vectorV3.z = pos2.z - pos.z
                        if vectorV3.x ~= 0 and vectorV3.y ~= 0 and vectorV3.z ~= 0 then
                            einheitsvektor =
                                1 /
                                (((vectorV3.x * vectorV3.x) + (vectorV3.y * vectorV3.y) + (vectorV3.z * vectorV3.z)) ^
                                    0.5)
                            modifikator = math.random(Script.Feature['Horn Beam Min Range'].value, Script.Feature['Horn Beam Max Range'].value)
                            pos2.x = pos2.x + (modifikator * einheitsvektor * vectorV3.x)
                            pos2.y = pos2.y + (modifikator * einheitsvektor * vectorV3.y)
                            pos2.z = pos2.z + (modifikator * einheitsvektor * vectorV3.z)
                            pxmin = math.floor(pos2.x - Script.Feature['Horn Beam Radius'].value)
                            pxmax = math.floor(pos2.x + Script.Feature['Horn Beam Radius'].value)
                            pymin = math.floor(pos2.y - Script.Feature['Horn Beam Radius'].value)
                            pymax = math.floor(pos2.y + Script.Feature['Horn Beam Radius'].value)
                            pzmin = math.floor(pos2.z - Script.Feature['Horn Beam Radius'].value)
                            pzmax = math.floor(pos2.z + Script.Feature['Horn Beam Radius'].value)
                            pos2.x = math.random(pxmin, pxmax)
                            pos2.y = math.random(pymin, pymax)
                            pos2.z = math.random(pzmin, pzmax)
                            fire.add_explosion(pos2, Script.Feature['Horn Beam Type'].value, true, false, 0.1, 0)
                            pos2.x = math.random(pxmin, pxmax)
                            pos2.y = math.random(pymin, pymax)
                            pos2.z = math.random(pzmin, pzmax)
                            fire.add_explosion(pos2, Script.Feature['Horn Beam Type 2'].value, true, false, 0.1, 0)
                        end
                    end
                end
            end
            coroutine.yield(0)
        end
        settings['Enable Horn Beam'].Enabled = f.on
    end)

    Script.Feature['Horn Beam Type'] = menu.add_feature('Select Explosion', 'action_value_i', Script.Parent['Explosive Horn Beam'], function(f)
        settings['Horn Beam Type'] = {Value = f.value}
        Notify('Beam Explosion Type 1: ' .. f.value, "Success")
    end)
    Script.Feature['Horn Beam Type'].max = 74
    Script.Feature['Horn Beam Type'].min = 0

    Script.Feature['Horn Beam Type 2'] = menu.add_feature('Select Explosion 2', 'action_value_i', Script.Parent['Explosive Horn Beam'], function(f)
        settings['Horn Beam Type 2'] = {Value = f.value}
        Notify('Beam Explosion Type 2: ' .. f.value, "Success")
    end)
    Script.Feature['Horn Beam Type 2'].max = 74
    Script.Feature['Horn Beam Type 2'].min = 0

    Script.Feature['Horn Beam Radius'] = menu.add_feature('Select Scattering', 'action_value_i', Script.Parent['Explosive Horn Beam'], function(f)
        settings['Horn Beam Radius'] = f.value
        Notify('Beam Radius: ' .. f.value, "Success")
    end)
    Script.Feature['Horn Beam Radius'].max = 10
    Script.Feature['Horn Beam Radius'].min = 1

    Script.Feature['Horn Beam Min Range'] = menu.add_feature('Select Min Range', 'action_value_i', Script.Parent['Explosive Horn Beam'], function(f)
        settings['Horn Beam Min Range'] = {Value = f.value}
        Notify('Beam Min Range: ' .. f.value, "Success")
    end)
    Script.Feature['Horn Beam Min Range'].max = 100
    Script.Feature['Horn Beam Min Range'].min = 10
    Script.Feature['Horn Beam Min Range'].mod = 5

    Script.Feature['Horn Beam Max Range'] = menu.add_feature('Select Max Range', 'action_value_i', Script.Parent['Explosive Horn Beam'], function(f)
        settings['Horn Beam Max Range'] = {Value = f.value}
        Notify('Beam Max Range: ' .. f.value, "Success")
    end)
    Script.Feature['Horn Beam Max Range'].max = 300
    Script.Feature['Horn Beam Max Range'].min = 100
    Script.Feature['Horn Beam Max Range'].mod = 5

    Script.Feature['Horn Beam For Others'] = menu.add_feature('Enable Horn for Player', 'action_value_i', Script.Parent['Explosive Horn Beam'], function(f)
        if get.SCID(f.value) ~= -1 then
            Notify('Selected Player: ' .. get.Name(f.value), "Success")
        else
            Notify('Invalid Player.', "Error")
        end
    end)
    Script.Feature['Horn Beam For Others'].max = 31
    Script.Feature['Horn Beam For Others'].min = -1
    Script.Feature['Horn Beam For Others'].value = -1


    Script.Parent['License Plates'] = menu.add_feature('License Plates', 'parent', Script.Parent['local_vehicle'], nil).id

    Script.Feature['2Take1 License Plate'] = menu.add_feature('2Take1 License Plate', 'toggle', Script.Parent['License Plates'], function(f)
        ToggleOff({'Force Plate Text', 'License Speedometer'})
        local anim_plate = {
            {"       2", "      2T", "     2TA", "    2TAK", "   2TAKE", "  2TAKE1", " 2TAKE1 ", "2TAKE1 M", "TAKE1 ME", "AKE1 MEN", "KE1 MENU", "E1 MENU ",
            "1 MENU  ", " MENU   ", "MENU    ", "ENU     ", "NU      ", "U      ", " ", " 2Take1 ", " ", " 2Take1 ", " ", " 2Take1 ", " ", " 2Take1 ", " ", " 2Take1 ", " "
            }
        }

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)

                for i = 1, #anim_plate[1] do
                    if f.on and veh == get.OwnVehicle() then
                        vehicle.set_vehicle_number_plate_text(veh, anim_plate[1][i])
                        coroutine.yield(200)
                    else
                        break
                    end

                end

            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Force Plate Text'] = menu.add_feature('Force License Plate Text', 'toggle', Script.Parent['License Plates'], function(f)
        ToggleOff({'2Take1 License Plate', 'License Speedometer'})
        while f.on do
            if not inputs.plate_text then
                local text = get.Input('Enter License Plate Text', 8, 0)
                if text then
                    inputs.plate_text = text
                else
                    Notify('Input canceled.', "Error", '')
                    f.on = false
                    return
                end
            end
            local veh = get.OwnVehicle()
            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)
                vehicle.set_vehicle_number_plate_text(veh, inputs.plate_text)
            end
            coroutine.yield(0)
        end
        inputs.plate_text = nil
    end)

    Script.Feature['License Speedometer'] = menu.add_feature('License Plate Speedometer', 'value_str', Script.Parent['License Plates'], function(f)
        ToggleOff({'Force Plate Text', '2Take1 License Plate'})
        settings['License Speedometer'] = {Enabled = f.on, Value = f.value}

        while f.on do
            local speedovalue
            local speedoname
            
            if f.value == 0 then
                speedovalue = 3.6
                speedoname = 'KMH'
            end

            if f.value == 1 then
                speedovalue = 2.23694
                speedoname = 'MPH'
            end

            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                local speed = entity.get_entity_speed(veh) * speedovalue
                if speed < 10 and speed > 0.01 then
                    speed = string.format('%.2f', speed)

                elseif speed >= 10 and speed < 100 then
                    speed = string.format('%.1f', speed)

                elseif speed < 0.01 and f.value == 7 then
                    speed = string.format('%.5f', speed)

                else
                    speed = math.floor(speed)
                end

                utility.request_ctrl(veh)
                vehicle.set_vehicle_number_plate_text(veh, tostring(speed) .. speedoname)

            end

            settings['License Speedometer'].Value = f.value
            coroutine.yield(0)
        end
        settings['License Speedometer'].Enabled = f.on
    end)
    Script.Feature['License Speedometer']:set_str_data({'KMH', 'MPH'})


    Script.Parent['AI Driving'] = menu.add_feature('AI Driving', 'parent', Script.Parent['local_vehicle'], nil).id

    Script.Feature['AI Driving Style'] = menu.add_feature('Driving Style', 'autoaction_value_str', Script.Parent['AI Driving'])
    Script.Feature['AI Driving Style']:set_str_data({'Normal', 'Avoid Traffic', 'Rushed', 'Extremly Rushed', 'Backwards'})
    
    Script.Feature['AI Driving Start'] = menu.add_feature('Enable AI Driving', 'value_str', Script.Parent['AI Driving'], function(f)
        local drivingstyle = {786859, 572, 786469, 786980, 263595}
        local veh = 0
        local driving

        while f.on do
            if vehicle.is_vehicle_stuck_on_roof(veh) then
                vehicle.set_vehicle_on_ground_properly(veh)
            end

            if get.OwnVehicle() ~= veh then
                driving = false
            end
            
            veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                if driving then
                    goto continue
                end

                if f.value == 0 then
                    ai.task_vehicle_drive_wander(get.OwnPed(), veh, 100, drivingstyle[Script.Feature['AI Driving Style'].value  + 1])
                    driving = true

                else
                    local waypoint = ui.get_waypoint_coord()
                    if waypoint.x == 16000 then
                        goto continue
                    end

                    while f.on and f.value == 1 and waypoint.x ~= 16000 do
                        waypoint = ui.get_waypoint_coord()
                        local veh2 = entity.get_entity_model_hash(veh)
                        ai.task_vehicle_drive_to_coord(get.OwnPed(), veh, v3(waypoint.x, waypoint.y, 0), 100, 10, veh2, drivingstyle[Script.Feature['AI Driving Style'].value  + 1], 1, 1)
                        coroutine.yield(500)
                    end
                    
                    local veh = get.OwnVehicle()
                    ped.clear_ped_tasks_immediately(get.OwnPed())
                    ped.set_ped_into_vehicle(get.OwnPed(), veh, -1)
                end

            end

            ::continue::
            coroutine.yield(2500)
        end
        local veh = get.OwnVehicle()
        ped.clear_ped_tasks_immediately(get.OwnPed())
        ped.set_ped_into_vehicle(get.OwnPed(), veh, -1)
    end)
    Script.Feature['AI Driving Start']:set_str_data({'Wander Around', 'To Waypoint'})

    Script.Feature['AI Driving Stop'] = menu.add_feature('Force Stop', 'action', Script.Parent['AI Driving'], function(f)
        local veh = get.OwnVehicle()
        if utility.valid_vehicle(veh) then
            ToggleOff({'AI Driving Start'})
            ped.clear_ped_tasks_immediately(get.OwnPed())
            ped.set_ped_into_vehicle(get.OwnPed(), veh, -1)
        end
    end)

    Script.Feature['Upgrade Vehicle'] = menu.add_feature('Upgrade Vehicle', 'action_value_str', Script.Parent['local_vehicle'], function(f)
        local veh = get.OwnVehicle()
        if not utility.valid_vehicle(veh) then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if f.value == 0 then
            utility.MaxVehicle(veh)
        else
            utility.MaxVehicle(veh, 3)
        end
    end)
    Script.Feature['Upgrade Vehicle']:set_str_data({'Full', 'Random'})

    Script.Feature['Set Custom Tires'] = menu.add_feature('Set Custom Tires', 'toggle', Script.Parent['local_vehicle'], function(f)
        settings['Set Custom Tires'] = {Enabled = f.on}
        local wheel

        while f.on do
            local veh = get.OwnVehicle()
            if not utility.valid_vehicle(veh) then
                goto continue
            end
    
            wheel = vehicle.get_vehicle_mod(veh, 23)
            if wheel == -1 then
                goto continue
            end
                
            vehicle.set_vehicle_mod_kit_type(veh, 0)
            vehicle.set_vehicle_mod(veh, 23, wheel, true)

            ::continue::
            coroutine.yield(500)
        end

        local veh = get.OwnVehicle()
        if not utility.valid_vehicle(veh) then
            return
        end

        vehicle.set_vehicle_mod(veh, 23, vehicle.get_vehicle_mod(veh, 23), false)

        settings['Set Custom Tires'].Enabled = f.on
    end)

    Script.Feature['Auto Repair Vehicle'] = menu.add_feature('Auto Repair Vehicle', 'toggle', Script.Parent['local_vehicle'], function(f)
        settings['Auto Repair Vehicle'] = {Enabled = f.on}
        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                utility.request_ctrl(veh)
                utility.RepairVehicle(veh)

            end

            coroutine.yield(2000)
        end
        settings['Auto Repair Vehicle'].Enabled = f.on
    end)
    
    Script.Feature['Infinite F1 Boost'] = menu.add_feature('Infinite F1 Boost', 'toggle', Script.Parent['local_vehicle'], function(f)
        settings['Infinite F1 Boost'] = {Enabled = f.on}
        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) then
                if entity.get_entity_model_hash(veh) == 0x1446590A or entity.get_entity_model_hash(veh) == 0x8B213907 or entity.get_entity_model_hash(veh) == 0x58F77553 or entity.get_entity_model_hash(veh) == 0x4669D038 then
                    local speed = entity.get_entity_speed(veh)

                    utility.request_ctrl(veh)
                    vehicle.set_vehicle_fixed(veh)

                    if speed > 75.0 then
                        vehicle.set_vehicle_forward_speed(veh, speed)
                    end

                end

            end 

            coroutine.yield(2500)
        end
        settings['Infinite F1 Boost'].Enabled = f.on
    end)

    Script.Feature['Instant Horn Boost'] = menu.add_feature('Instant Horn Boost', 'slider', Script.Parent['local_vehicle'], function(f)
        ToggleOff({'Extreme Horn Boost'})
        settings['Instant Horn Boost'] = {Enabled = f.on, Value = f.value}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) and player.is_player_pressing_horn(player.player_id()) then
                local speed = entity.get_entity_speed(veh)
                    
                if speed < f.value then
                    utility.request_ctrl(veh)
                    vehicle.set_vehicle_forward_speed(veh, f.value)
                end

            end

            settings['Instant Horn Boost'].Value = f.value
            coroutine.yield(0)
        end
        settings['Instant Horn Boost'].Enabled = f.on
    end)
    Script.Feature['Instant Horn Boost'].max = 150
    Script.Feature['Instant Horn Boost'].min = 25
    Script.Feature['Instant Horn Boost'].mod = 25

    Script.Feature['Extreme Horn Boost'] = menu.add_feature('Extreme Horn Boost', 'slider', Script.Parent['local_vehicle'], function(f)
        ToggleOff({'Instant Horn Boost'})
        settings['Extreme Horn Boost'] = {Enabled = f.on, Value = f.value}

        while f.on do
            local veh = get.OwnVehicle()

            if utility.valid_vehicle(veh) and player.is_player_pressing_horn(player.player_id()) then
                utility.request_ctrl(veh)

                entity.set_entity_max_speed(veh, f.value)
                vehicle.set_vehicle_forward_speed(veh, f.value)
            end

            settings['Extreme Horn Boost'].Value = f.value
            coroutine.yield(0)
        end
        settings['Extreme Horn Boost'].Enabled = f.on
    end)
    Script.Feature['Extreme Horn Boost'].max = 5000
    Script.Feature['Extreme Horn Boost'].min = 250
    Script.Feature['Extreme Horn Boost'].mod = 250

    Script.Feature['Weird Entity'] = menu.add_feature('Weird Entity', 'toggle', Script.Parent['local_vehicle'], function(f)
        settings['Weird Entity'] = {Enabled = f.on}

        while f.on do
            local veh = get.OwnVehicle()
            local ent = get.OwnPed()

            if utility.valid_vehicle(veh) and not balll then
                local hash = entity.get_entity_model_hash(veh)

                balll = Spawn.Vehicle(hash, get.OwnCoords())
                ent = veh

            elseif not balll then
                balll = ped.clone_ped(get.OwnPed())
            end

            entity.set_entity_visible(ent, false)
            entity.set_entity_collision(balll, false, false, false)
            entity.set_entity_rotation(balll, v3(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180)))
            utility.set_coords(balll, get.OwnCoords())

            coroutine.yield(0)
        end
        
        utility.clear({balll})
        balll = nil

        entity.set_entity_visible(get.OwnPed(), true)
        entity.set_entity_visible(get.OwnVehicle(), true)
        settings['Weird Entity'].Enabled = f.on
    end)

    Script.Feature['Swap Vehicle Seats'] = menu.add_feature('Swap Vehicle Seat', 'autoaction_value_i', Script.Parent['local_vehicle'], function(f)
        local veh = get.OwnVehicle()
        if veh ~= 0 then
            ped.set_ped_into_vehicle(get.OwnPed(), veh, Script.Feature['Swap Vehicle Seats'].value)
        end
    end)
    Script.Feature['Swap Vehicle Seats'].min = -1
    Script.Feature['Swap Vehicle Seats'].value = -1
    Script.Feature['Swap Vehicle Seats'].max = 15

    Script.Feature['Delete Current Vehicle'] = menu.add_feature('Delete Current Vehicle', 'action', Script.Parent['local_vehicle'], function()
        local veh = get.OwnVehicle()
        if utility.valid_vehicle(veh) then
            utility.request_ctrl(veh)
            entity.delete_entity(veh)
        else
            Notify('No vehicle found.', "Error")
        end
    end)


    Script.Parent['Custom Vehicles'] = menu.add_feature('Custom Vehicles', 'parent', Script.Parent['local_vehicle'], nil).id

    Script.Parent['Moveable Robot'] = menu.add_feature('Moveable Robot', 'parent', Script.Parent['Custom Vehicles'], nil).id

    Script.Feature['Enable Robot'] = menu.add_feature('Enable Robot', 'toggle', Script.Parent['Moveable Robot'], function(f)
        if f.on then
            if not robot_objects['tampa'] then
                menu.set_menu_can_navigate(false)
                local spawn_it = true
                local veh = get.OwnVehicle()
                if veh ~= 0 then
                    if 3084515313 == entity.get_entity_model_hash(veh) then
                        robot_objects['tampa'] = veh
                        spawn_it = false
                    end
                end
                if spawn_it then
                    robot_objects['tampa'] = Spawn.Vehicle(3084515313, get.OwnCoords(), get.OwnHeading())
                    decorator.decor_set_int(robot_objects['tampa'], 'MPBitset', 1 << 10)
                    entity.set_entity_god_mode(robot_objects['tampa'], true)
                    utility.MaxVehicle(veh)
                    if Script.Feature['Spawn in Custom Vehicle'].on then
                        ped.set_ped_into_vehicle(get.OwnPed(), robot_objects['tampa'], -1)
                    end
                    vehicle.set_vehicle_mod_kit_type(robot_objects['tampa'], 0)
                    for i = 0, 18 do
                        local mod = vehicle.get_num_vehicle_mods(robot_objects['tampa'], i)-1
                        vehicle.set_vehicle_mod(robot_objects['tampa'], i, mod, true)
                        vehicle.toggle_vehicle_mod(robot_objects['tampa'], mod, true)
                    end
                    vehicle.set_vehicle_bulletproof_tires(robot_objects['tampa'], true)
                    vehicle.set_vehicle_window_tint(robot_objects['tampa'], 1)
                    vehicle.set_vehicle_number_plate_index(veh, 1)
                    vehicle.set_vehicle_number_plate_text(robot_objects['tampa'], '2Take1')
                end
            end
            if robot_objects['ppdump'] == nil then
                robot_objects['ppdump'] = Spawn.Vehicle(0x810369E2)
                entity.set_entity_god_mode(robot_objects['ppdump'], true)
                entity.attach_entity_to_entity(robot_objects['ppdump'], robot_objects['tampa'], 0, v3(0, 0, 12.5), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['llbone'] == nil then
                robot_objects['llbone'] = Spawn.Object(1803116220)
                entity.attach_entity_to_entity(robot_objects['llbone'], robot_objects['tampa'], 0, v3(-4.25, 0, 12.5), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['rlbone'] == nil then
                robot_objects['rlbone'] = Spawn.Object(1803116220)
                entity.attach_entity_to_entity(robot_objects['rlbone'], robot_objects['tampa'], 0, v3(4.25, 0, 12.5), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['lltrain'] == nil then
                robot_objects['lltrain'] = Spawn.Vehicle(1030400667)
                entity.set_entity_god_mode(robot_objects['lltrain'], true)
                entity.attach_entity_to_entity(robot_objects['lltrain'], robot_objects['llbone'], 0, v3(0, 0, -5), v3(90), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['lfoot'] == nil then
                robot_objects['lfoot'] = Spawn.Vehicle(782665360)
                entity.set_entity_god_mode(robot_objects['lfoot'], true)
                entity.attach_entity_to_entity(robot_objects['lfoot'], robot_objects['llbone'], 0, v3(0, 2, -12.5), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['rltrain'] == nil then
                robot_objects['rltrain'] = Spawn.Vehicle(1030400667)
                entity.set_entity_god_mode(robot_objects['rltrain'], true)
                entity.attach_entity_to_entity(robot_objects['rltrain'], robot_objects['rlbone'], 0, v3(0, 0, -5), v3(90), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['rfoot'] == nil then
                robot_objects['rfoot'] = Spawn.Vehicle(782665360)
                entity.set_entity_god_mode(robot_objects['rfoot'], true)
                entity.attach_entity_to_entity(robot_objects['rfoot'], robot_objects['rlbone'], 0, v3(0, 2, -12.5), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['body'] == nil then
                robot_objects['body'] = Spawn.Vehicle(1030400667)
                entity.set_entity_god_mode(robot_objects['body'], true)
                entity.attach_entity_to_entity(robot_objects['body'], robot_objects['tampa'], 0, v3(0, 0, 22.5), v3(90), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['shoulder'] == nil then
                robot_objects['shoulder'] = Spawn.Vehicle(0x810369E2)
                entity.set_entity_god_mode(robot_objects['shoulder'], true)
                entity.attach_entity_to_entity(robot_objects['shoulder'], robot_objects['tampa'], 0, v3(0, 0, 27.5), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['lheadbone'] == nil then
                robot_objects['lheadbone'] = Spawn.Object(1803116220)
                entity.attach_entity_to_entity(robot_objects['lheadbone'], robot_objects['tampa'], 0, v3(-3.25, 0, 27.5), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['rheadbone'] == nil then
                robot_objects['rheadbone'] = Spawn.Object(1803116220)
                entity.attach_entity_to_entity(robot_objects['rheadbone'], robot_objects['tampa'], 0, v3(3.25, 0, 27.5), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['lheadtrain'] == nil then
                robot_objects['lheadtrain'] = Spawn.Vehicle(1030400667)
                entity.set_entity_god_mode(robot_objects['lheadtrain'], true)
                entity.attach_entity_to_entity(robot_objects['lheadtrain'], robot_objects['lheadbone'], 0, v3(-3, 4, -5), v3(325, 0, 45), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['lhand'] == nil then
                robot_objects['lhand'] = Spawn.Vehicle(782665360)
                entity.set_entity_god_mode(robot_objects['lhand'], true)
                entity.attach_entity_to_entity(robot_objects['lhand'], robot_objects['lheadtrain'], 0, v3(0, 7.5, 0), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['rheadtrain'] == nil then
                robot_objects['rheadtrain'] = Spawn.Vehicle(1030400667)
                entity.set_entity_god_mode(robot_objects['rheadtrain'], true)
                entity.attach_entity_to_entity(robot_objects['rheadtrain'], robot_objects['rheadbone'], 0, v3(3, 4, -5), v3(325, 0, 315), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['rhand'] == nil then
                robot_objects['rhand'] = Spawn.Vehicle(782665360)
                entity.set_entity_god_mode(robot_objects['rhand'], true)
                entity.attach_entity_to_entity(robot_objects['rhand'], robot_objects['rheadtrain'], 0, v3(0, 7.5, 0), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['head'] == nil then
                robot_objects['head'] = Spawn.Object(-543669801)
                entity.attach_entity_to_entity(robot_objects['head'], robot_objects['tampa'], 0, v3(0, 0, 35), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            menu.set_menu_can_navigate(true)
            return HANDLER_CONTINUE
        end
        if not f.on then
            for i in pairs(robot_objects) do
                utility.clear({robot_objects[i]})
                robot_objects[i] = nil
            end
            if #entitys['robot_weapon_left'] ~= 0 then
                utility.clear(entitys['robot_weapon_left'])
                entitys['robot_weapon_left'] = {}
            end
            if #entitys['robot_weapon_right'] ~= 0 then
                utility.clear(entitys['robot_weapon_right'])
                entitys['robot_weapon_right'] = {}
            end
        end
    end)

    Script.Feature['Controllable Blasts'] = menu.add_feature('Controllable Blasts', 'toggle', Script.Parent['Moveable Robot'], function(f)
        if f.on then
            if not Script.Feature['Enable Robot'].on then
                coroutine.yield(2500)
            end
            local whash = gameplay.get_hash_key('weapon_airstrike_rocket')
            local pos = get.OwnCoords()
            local dir = cam.get_gameplay_cam_rot()
            dir:transformRotToDir()
            dir = dir * 1000
            pos = pos + dir
            local hit, hitpos, hitsurf, hash, ent = worldprobe.raycast((utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 2) + v3(0, 0, 4)), pos, -1, 0)
            while not hit do
                pos = get.OwnCoords()
                dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1000
                pos = pos + dir
                hit, hitpos, hitsurf, hash, ent = worldprobe.raycast((utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 2) + v3(0, 0, 4)), pos, -1, 0)
                coroutine.yield(0)
            end
            if ped.is_ped_shooting(get.OwnPed()) and get.OwnVehicle() == robot_objects['tampa'] then
                if Script.Feature['Robot Equip Weapons'].on then
                    local lobj = entitys['robot_weapon_left'][1]
                    local lheading = entity.get_entity_heading(lobj)
                    local lpos = utility.OffsetCoords(entity.get_entity_coords(lobj), lheading, 12) + v3(0, 0, 3)
                    gameplay.shoot_single_bullet_between_coords(lpos, hitpos, 1000, whash, get.OwnPed(), true, false, 50000)
                    coroutine.yield(100)
                    local robj = entitys['robot_weapon_right'][1]
                    local rheading = entity.get_entity_heading(robj)
                    local rpos = utility.OffsetCoords(entity.get_entity_coords(robj), rheading, 12) + v3(0, 0, 3)
                    gameplay.shoot_single_bullet_between_coords(rpos, hitpos, 1000, whash, get.OwnPed(), true, false, 50000)
                else
                    local start = utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 8) + v3(0, 0, 15)
                    gameplay.shoot_single_bullet_between_coords(start, hitpos, 1000, whash, get.OwnPed(), true, false, 10000)
                end
            end
        end
        settings['Controllable Blasts'] = {Enabled = f.on}
        return HANDLER_CONTINUE
    end)

    Script.Feature['Moveable Legs'] = menu.add_feature('Moveable Legs', 'toggle', Script.Parent['Moveable Robot'], function(f)
        settings['Moveable Legs'] = {Enabled = f.on}
        if f.on then
            if robot_objects['llbone'] and robot_objects['rlbone'] and robot_objects['tampa'] then
                local speed
                local left = robot_objects['llbone']
                local right = robot_objects['rlbone']
                local main = robot_objects['tampa']
                local offsetL = v3(-4.25, 0, 12.5)
                local offsetR = v3(4.25, 0, 12.5)
                for i = 0, 50 do
                    if robot_objects['tampa'] then
                        speed = entity.get_entity_speed(robot_objects['tampa'])
                        if not f.on or speed < 2.5 then
                            clear_legs_movement()
                            return HANDLER_CONTINUE
                        end
                        utility.request_ctrl(left)
                        utility.request_ctrl(right)
                        utility.request_ctrl(main)
                        entity.attach_entity_to_entity(left, main, 0, offsetL, v3(i, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
                        entity.attach_entity_to_entity(right, main, 0, offsetR, v3(360 - i, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
                        local wait = math.floor(51 - (speed / 1))
                        if wait < 1 then
                            wait = 0
                        end
                        coroutine.yield(wait)
                    end
                end
                for i = 50, -50, -1 do
                    if robot_objects['tampa'] then
                        speed = entity.get_entity_speed(robot_objects['tampa'])
                        if not f.on or speed < 2.5 then
                            clear_legs_movement()
                            return HANDLER_CONTINUE
                        end
                        utility.request_ctrl(left)
                        utility.request_ctrl(right)
                        utility.request_ctrl(main)
                        entity.attach_entity_to_entity(left, main, 0, offsetL, v3(i, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
                        entity.attach_entity_to_entity(right, main, 0, offsetR, v3(360 - i, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
                        local wait = math.floor(51 - (speed / 1))
                        if wait < 1 then
                            wait = 0
                        end
                        coroutine.yield(wait)
                    end
                end
                for i = -50, 0 do
                    if robot_objects['tampa'] then
                        speed = entity.get_entity_speed(robot_objects['tampa'])
                        if not f.on or speed < 2.5 then
                            clear_legs_movement()
                            return HANDLER_CONTINUE
                        end
                        utility.request_ctrl(left)
                        utility.request_ctrl(right)
                        utility.request_ctrl(main)
                        entity.attach_entity_to_entity(left, main, 0, offsetL, v3(i, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
                        entity.attach_entity_to_entity(right, main, 0, offsetR, v3(360 - i, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
                        local wait = math.floor(51 - (speed / 1))
                        if wait < 1 then
                            wait = 0
                        end
                        coroutine.yield(wait)
                    end
                end
            end
            return HANDLER_CONTINUE
        end
        if not f.on then
            clear_legs_movement()
        end
    end)

    Script.Feature['Robot Collision'] = menu.add_feature('Collision', 'toggle', Script.Parent['Moveable Robot'], function(f)
            settings['Robot Collision'] = {Enabled = f.on}
            if get.OwnVehicle() == robot_objects['tampa'] then
                Notify('Re-enable Robot to take effect of collision!', "Neutral")
            end
        end)

    Script.Feature['Rocket Propulsion'] = menu.add_feature('Rocket Propulsion (Visual)', 'toggle', Script.Parent['Moveable Robot'], function(f)
        if f.on and robot_objects['body'] then
            if robot_objects['spinning_1'] == nil then
                robot_objects['spinning_1'] = Spawn.Vehicle(0xFB133A17, get.OwnCoords())
                entity.set_entity_god_mode(robot_objects['spinning_1'], true)
                entity.set_entity_visible(robot_objects['spinning_1'], false)
                entity.attach_entity_to_entity(robot_objects['spinning_1'], robot_objects['body'], 0, v3(0, -5, 0), v3(-180, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            vehicle.set_heli_blades_speed(robot_objects['spinning_1'], 100)
            if robot_objects['spinning_middle'] == nil then
                robot_objects['spinning_middle'] = Spawn.Object(94602826)
                entity.set_entity_god_mode(robot_objects['spinning_middle'], true)
                entity.attach_entity_to_entity(robot_objects['spinning_middle'], robot_objects['spinning_1'], 0, v3(0, 0, 0), v3(0, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['spinning_middle2'] == nil then
                robot_objects['spinning_middle2'] = Spawn.Object(94602826)
                entity.set_entity_god_mode(robot_objects['spinning_middle2'], true)
                entity.attach_entity_to_entity(robot_objects['spinning_middle2'], robot_objects['spinning_1'], 0, v3(0, 0, 1.5), v3(0, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['spinning_middle3'] == nil then
                robot_objects['spinning_middle3'] = Spawn.Object(94602826)
                entity.set_entity_god_mode(robot_objects['spinning_middle3'], true)
                entity.attach_entity_to_entity(robot_objects['spinning_middle3'], robot_objects['spinning_1'], 0, v3(0, 0, 3), v3(0, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            local index = entity.get_entity_bone_index_by_name(robot_objects['spinning_1'], 'rotor_main')
            if robot_objects['glow_1'] == nil then
                robot_objects['glow_1'] = Spawn.Object(2655881418)
                entity.set_entity_god_mode(robot_objects['glow_1'], true)
                entity.attach_entity_to_entity(robot_objects['glow_1'], robot_objects['spinning_1'], index, v3(2, 3, 3), v3(0, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['glow_2'] == nil then
                robot_objects['glow_2'] = Spawn.Object(2655881418)
                entity.set_entity_god_mode(robot_objects['glow_2'], true)
                entity.attach_entity_to_entity(robot_objects['glow_2'], robot_objects['spinning_1'], index, v3(2, -3, 3), v3(0, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['glow_3'] == nil then
                robot_objects['glow_3'] = Spawn.Object(2655881418)
                entity.set_entity_god_mode(robot_objects['glow_3'], true)
                entity.attach_entity_to_entity(robot_objects['glow_3'], robot_objects['spinning_1'], index, v3(4, 0, 3), v3(0, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['glow_4'] == nil then
                robot_objects['glow_4'] = Spawn.Object(2655881418)
                entity.set_entity_god_mode(robot_objects['glow_4'], true)
                entity.attach_entity_to_entity(robot_objects['glow_4'], robot_objects['spinning_1'], index, v3(-2, 3, 3), v3(0, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['glow_5'] == nil then
                robot_objects['glow_5'] = Spawn.Object(2655881418)
                entity.set_entity_god_mode(robot_objects['glow_5'], true)
                entity.attach_entity_to_entity(robot_objects['glow_5'], robot_objects['spinning_1'], index, v3(-2, -3, 3), v3(0, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
            if robot_objects['glow_6'] == nil then
                robot_objects['glow_6'] = Spawn.Object(2655881418)
                entity.set_entity_god_mode(robot_objects['glow_6'], true)
                entity.attach_entity_to_entity(robot_objects['glow_6'], robot_objects['spinning_1'], index, v3(-4, 0, 3), v3(0, 0, 0), true, Script.Feature['Robot Collision'].on, false, 2, true)
            end
        end
        if not f.on then
        local delete_propulsion = {'spinning_1', 'glow_1', 'glow_2', 'glow_3', 'glow_4', 'glow_5', 'glow_6', 'spinning_middle', 'spinning_middle2', 'spinning_middle3' }
            for i = 1, #delete_propulsion do
                if robot_objects[delete_propulsion[i]] then
                    utility.clear({robot_objects[delete_propulsion[i]]})
                    robot_objects[delete_propulsion[i]] = nil
                end
            end
            return
        end
        settings['Rocket Propulsion'] = {Enabled = f.on}
        return HANDLER_CONTINUE
    end)

    Script.Feature['Robot Equip Weapons'] = menu.add_feature('Equip Miniguns on hands', 'toggle', Script.Parent['Moveable Robot'], function(f)
        settings['Robot Equip Weapons'] = {Enabled = f.on}
        if f.on and robot_objects['lheadtrain'] and robot_objects['rheadtrain'] then
            if #entitys['robot_weapon_left'] == 0 and #entitys['robot_weapon_right'] == 0 then
                local toggle_preview = false
                if Script.Feature['Custom Vehicles Preview'].on then
                    toggle_preview = true
                    settings['Custom Vehicles Preview'] = {Enabled = false}
                end
                local toggle_spawn_in = false
                if Script.Feature['Spawn in Custom Vehicle'].on then
                    toggle_spawn_in = true
                    settings['Spawn in Custom Vehicle'] = {Enabled = false}
                end
                local data = customData.custom_vehicles[1][2]
                spawn_custom_vehicle(data, 'robot_weapon_left')
                spawn_custom_vehicle(data, 'robot_weapon_right')
                local w1 = entitys['robot_weapon_left'][1]
                local w2 = entitys['robot_weapon_right'][1]
                local a1 = robot_objects['lheadtrain']
                local a2 = robot_objects['rheadtrain']
                utility.request_ctrl(w1)
                utility.request_ctrl(w2)
                utility.request_ctrl(a1)
                utility.request_ctrl(a2)
                entity.attach_entity_to_entity(w1, a1, 0, v3(0, 5, 0), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
                entity.attach_entity_to_entity(w2, a2, 0, v3(0, 5, 0), v3(), true, Script.Feature['Robot Collision'].on, false, 2, true)
                if toggle_preview then
                    Script.Feature['Custom Vehicles Preview'].on = true
                end
                if toggle_spawn_in then
                    Script.Feature['Spawn in Custom Vehicle'].on = true
                end
            end
        end
        if not f.on then
            if #entitys['robot_weapon_left'] ~= 0 then
                utility.clear(entitys['robot_weapon_left'])
                entitys['robot_weapon_left'] = {}
            end
            if #entitys['robot_weapon_right'] ~= 0 then
                utility.clear(entitys['robot_weapon_right'])
                entitys['robot_weapon_right'] = {}
            end
            return
        end
        return HANDLER_CONTINUE
    end)

    Script.Feature['Drive Robot'] = menu.add_feature('Drive Robot', 'action', Script.Parent['Moveable Robot'], function()
        if robot_objects['tampa'] then
            ped.set_ped_into_vehicle(get.OwnPed(), robot_objects['tampa'], -1)
        end
    end)

    Script.Feature['Self Destruction'] = menu.add_feature('Self Destruction', 'action', Script.Parent['Moveable Robot'], function()
        if robot_objects['tampa'] then
            for i = 1, #entitys['robot_weapon_left'] do
                entity.detach_entity(entitys['robot_weapon_left'][i])
                entity.freeze_entity(entitys['robot_weapon_left'][i], false)
                entity.set_entity_god_mode(entitys['robot_weapon_left'][i], false)
                coroutine.yield(0)
            end
            for i = 1, #entitys['robot_weapon_right'] do
                entity.detach_entity(entitys['robot_weapon_right'][i])
                entity.freeze_entity(entitys['robot_weapon_right'][i], false)
                entity.set_entity_god_mode(entitys['robot_weapon_right'][i], false)
                coroutine.yield(0)
            end
            for i in pairs(robot_objects) do
                entity.detach_entity(robot_objects[i])
                entity.freeze_entity(robot_objects[i], false)
                entity.set_entity_god_mode(robot_objects[i], false)
                coroutine.yield(0)
            end
            for i = 1, #entitys['robot_weapon_left'] do
                fire.add_explosion(entity.get_entity_coords(entitys['robot_weapon_left'][i]), 8, true, false, 0, 0)
                coroutine.yield(33)
            end
            for i = 1, #entitys['robot_weapon_right'] do
                fire.add_explosion(entity.get_entity_coords(entitys['robot_weapon_right'][i]), 8, true, false, 0, 0)
                coroutine.yield(33)
            end
            for i in pairs(robot_objects) do
                fire.add_explosion(entity.get_entity_coords(robot_objects[i]), 8, true, false, 0, 0)
                coroutine.yield(33)
             end
            entitys['robot_weapon_left'] = {}
            entitys['robot_weapon_right'] = {}
            robot_objects = {}
            Script.Feature['Enable Robot'].on = false
        end
    end)

    Script.Parent['Custom Vehicles Spawner'] = menu.add_feature('Custom Vehicles', 'parent', Script.Parent['Custom Vehicles'], nil).id

    Script.Feature['Custom Vehicles Preview'] = menu.add_feature('Preview Custom Vehicles', 'toggle', Script.Parent['Custom Vehicles Spawner'], function(f)
            if #entitys['preview_veh'] > 0 and f.on then
                if ped.is_ped_in_any_vehicle(get.OwnPed()) then
                    ped.clear_ped_tasks_immediately(get.OwnPed())
                end
                local pos = get.OwnCoords()
                if not config_preview then
                    for i = 1, #entitys['preview_veh'] do
                        entity.set_entity_no_collsion_entity(entitys['preview_veh'][i], get.OwnPed(), true)
                    end
                    config_preview = true
                end
                pos.z = pos.z + offset_height
                local heading = get.OwnHeading()
                pos = utility.OffsetCoords(pos, heading, offset_distance)
                utility.set_coords(entitys['preview_veh'][1], pos)
                entity.set_entity_rotation(entitys['preview_veh'][1], rot_veh)
                rot_veh.z = rot_veh.z + 1
                if rot_veh.z > 360 then
                    rot_veh.z = 0
                end
            end
            if not f.on then
                utility.clear(entitys['preview_veh'])
                entitys['preview_veh'] = {}
                config_preview = false
                return
            end
        return HANDLER_CONTINUE
    end)

    menu.add_feature('Delete Custom Vehicles', 'action', Script.Parent['Custom Vehicles Spawner'], function()
        Log('Clearing Custom Vehicles.')
        utility.clear(entitys['Custom Vehicles'])
        entitys['Custom Vehicles'] = {}
        utility.clear(entitys['preview_veh'])
        entitys['preview_veh'] = {}
        config_preview = false
        Notify('Cleared Custom Vehicles.', "Success")
    end)

    for i = 1, #customData.custom_vehicles do
        menu.add_feature(customData.custom_vehicles[i][1], 'action', Script.Parent['Custom Vehicles Spawner'], function()
            local data = customData.custom_vehicles[i][2]
            spawn_custom_vehicle(data)
        end)
    end

    Script.Parent['Custom Vehicles Options'] = menu.add_feature('Options', 'parent', Script.Parent['Custom Vehicles'], nil).id

    Script.Feature['Spawn in Custom Vehicle'] = menu.add_feature('Spawn in Custom Vehicle', 'toggle', Script.Parent['Custom Vehicles Options'], function(f)
        settings['Spawn in Custom Vehicle'] = {Enabled = f.on}
    end)

    Script.Feature['Use Own Vehicles'] = menu.add_feature('Use Own Vehicle for Custom ones', 'toggle', Script.Parent['Custom Vehicles Options'], function(f)
        settings['Use Own Vehicles'] = {Enabled = f.on}
    end)

    Script.Feature['Custom Vehicles Godmode'] = menu.add_feature('Godmode on Custom Vehicles', 'toggle', Script.Parent['Custom Vehicles Options'], function(f)
        settings['Custom Vehicles Godmode'] = {Enabled = f.on}
    end)


    Script.Parent['Ground Animals'] = menu.add_feature('Ground Animals', 'parent', Script.Parent['local_modelchanger'], nil).id

    for ga = 1, #miscdata.Animals.Ground do
        Script.Feature['AMC' .. miscdata.Animals.Ground[ga].Name] = menu.add_feature(miscdata.Animals.Ground[ga].Name, 'action', Script.Parent['Ground Animals'], function()
            change_model(miscdata.Animals.Ground[ga].Hash, nil, true)
        end)
    end


    Script.Parent['Water Animals'] = menu.add_feature('Water Animals', 'parent', Script.Parent['local_modelchanger'], function()
        Notify('Note that these Models will only work in Water!', "Neutral")
    end).id

    for wa = 1, #miscdata.Animals.Water do
        Script.Feature['AMC' .. miscdata.Animals.Water[wa].Name] = menu.add_feature(miscdata.Animals.Water[wa].Name, 'action', Script.Parent['Water Animals'], function()
            change_model(miscdata.Animals.Water[wa].Hash, true, true)
        end)
    end


    Script.Parent['Flying Animals'] = menu.add_feature('Flying Animals', 'parent', Script.Parent['local_modelchanger'], nil).id

    for aa = 1, #miscdata.Animals.Air do
        Script.Feature['AMC' .. miscdata.Animals.Air[aa].Name] = menu.add_feature(miscdata.Animals.Air[aa].Name, 'action', Script.Parent['Flying Animals'], function()
            change_model(miscdata.Animals.Air[aa].Hash, nil, true)
        end)
    end


    Script.Parent['Standard Models'] = menu.add_feature('Standard Models', 'parent', Script.Parent['local_modelchanger'], nil).id

    for sa = 1, #miscdata.Animals.Standard do
        Script.Feature['AMC' .. miscdata.Animals.Standard[sa].Name] = menu.add_feature(miscdata.Animals.Standard[sa].Name, 'action', Script.Parent['Standard Models'], function()
            change_model(miscdata.Animals.Standard[sa].Hash, nil, true)
        end)
    end

    Script.Feature['Model Change Input'] = menu.add_feature('Model Change: Input', 'action', Script.Parent['local_modelchanger'], function(f)
        local _input = get.Input("Enter Ped Model Name or Hash")
        if not _input then
            Notify('Input canceled.', "Error", '')
            return
        end
        local hash = _input
        if not tonumber(_input) then
            hash = gameplay.get_hash_key(_input)
        end
        if not streaming.is_model_a_ped(hash) then
            Notify('Input is not a valid ped.', "Error", '')
            return
        end
        change_model(hash, nil, true)
    end)

    Script.Feature['Safe Model Change'] = menu.add_feature('Safe Model Change', 'toggle', Script.Parent['local_modelchanger'], function(f)
        settings['Safe Model Change'] = {Enabled = f.on}
    end)

    Script.Feature['Revert Outfit'] = menu.add_feature('Revert Outfit', 'toggle', Script.Parent['local_modelchanger'], function(f)
        settings['Revert Outfit'] = {Enabled = f.on}
    end)

    Script.Feature['Fix Loading Screen'] = menu.add_feature('Fix endless loading Screen', 'action', Script.Parent['local_modelchanger'], function()
        change_model(0x9B22DBAF)
        coroutine.yield(100)
        ped.set_ped_health(get.OwnPed(), 0)
    end)

    Script.Parent['Block Areas'] = menu.add_feature('Block Areas', 'parent', Script.Parent['local_lobby'], nil).id

    Script.Feature['Teleport to Block'] = menu.add_feature('Teleport to Block', 'toggle', Script.Parent['Block Areas'], function(f)
        settings['Teleport to Block'] = {Enabled = f.on}
    end)
    
    Script.Feature['Clear blocking Objects'] = menu.add_feature('Clear blocking Objects', 'action', Script.Parent['Block Areas'], function()
        utility.clear(entitys['bl_objects'])
        entitys['bl_objects'] = {}
    end)

    for i=1,#customData.block_locations do
        local location = customData.block_locations[i]
        local parent = menu.add_feature(location.Name, "parent", Script.Parent['Block Areas']).id
        
        for j=1,#location.Children do
            local area = location.Children[j]
            
            menu.add_feature(area.Name, "action", parent, BlockArea).data = area
        end
    end



    Script.Parent['Lobby Trolling'] = menu.add_feature('Trolling', 'parent', Script.Parent['local_lobby'], nil).id

    Script.Feature['Lobby Fake Invite Spam'] = menu.add_feature('Fake Typing Indicator', 'toggle', Script.Parent['Lobby Trolling'], function(f)
        while f.on do
            for id = 0, 31 do
                scriptevent.Send('Typing Begin', {player.player_id(), 0, math.random(0, 10000)}, id, Exclude())
            end

            coroutine.yield(2000)
        end

        for id = 0, 31 do
            scriptevent.Send('Typing Stop', {player.player_id(), 0, math.random(0, 10000)}, id, Exclude())
        end

    end)

    Script.Parent['Lobby Fake Invites'] = menu.add_feature('Fake Invites', 'parent', Script.Parent['Lobby Trolling'], nil).id

    for i = 1, #miscdata.fakeinvites do
        local name = miscdata.fakeinvites[i]
        Script.Feature['Lobby '.. name ..' Invite'] = menu.add_feature(name .. ' Invite', 'action', Script.Parent['Lobby Fake Invites'], function()
            for id = 0, 31 do
                scriptevent.Send('Fake Invite', {player.player_id(), i}, id, Exclude())
            end

        end)
    end

    Script.Feature['Lobby Fake Invite Spam'] = menu.add_feature('Fake Invite Spam', 'toggle', Script.Parent['Lobby Fake Invites'], function(f)
        while f.on do
            for id = 0, 31 do
                scriptevent.Send('Fake Invite', {player.player_id(), math.random(1, 6)}, id, Exclude())
            end

            coroutine.yield(200)
        end
    end)


    Script.Parent['Lobby Notifications'] = menu.add_feature('Notifications', 'parent', Script.Parent['Lobby Trolling'], nil).id

    Script.Feature['Lobby Cash Removed'] = menu.add_feature('Cash Removed', 'action_value_str', Script.Parent['Lobby Notifications'], function(f)
        for id = 0, 31 do
            if f.value == 0 then
                scriptevent.Send('Notification 2', {player.player_id(), 689178114, math.random(-2147483647, 2147483647)}, id, Exclude())
                return
            end

            local amount = get.Input('Enter The Amount Of Money (0 - 2147483647)', 10, 3)
            if not amount then
                Notify('Input canceled.', "Error", '')
                return
            end

            scriptevent.Send('Notification 2', {player.player_id(), 689178114, amount}, id, Exclude())
        end
    end)
    Script.Feature['Lobby Cash Removed']:set_str_data({'Random Amount', 'Input'})

    Script.Feature['Lobby Cash Stolen'] = menu.add_feature('Cash Stolen', 'action_value_str', Script.Parent['Lobby Notifications'], function(f)
        for id = 0, 31 do
            if f.value == 0 then
                scriptevent.Send('Notification 2', {player.player_id(), 2187973097, math.random(-2147483647, 2147483647)}, id, Exclude())
                return
            end

            local amount = get.Input('Enter The Amount Of Money (0 - 2147483647)', 10, 3)
            if not amount then
                Notify('Input canceled.', "Error", '')
                return
            end

            scriptevent.Send('Notification 2', {player.player_id(), 2187973097, amount}, id, Exclude())
        end
    end)
    Script.Feature['Lobby Cash Stolen']:set_str_data({'Random Amount', 'Input'})

    Script.Feature['Lobby Cash Banked'] = menu.add_feature('Cash Banked', 'action_value_str', Script.Parent['Lobby Notifications'], function(f)
        for id = 0, 31 do
            if f.value == 0 then
                scriptevent.Send('Notification 2', {player.player_id(), 1990572980, math.random(-2147483647, 2147483647)}, id, Exclude())
                return
            end

            local amount = get.Input('Enter The Amount Of Money (0 - 2147483647)', 10, 3)
            if not amount then
                Notify('Input canceled.', "Error", '')
                return
            end

            scriptevent.Send('Notification 2', {player.player_id(), 1990572980, amount}, id, Exclude())
        end
    end)
    Script.Feature['Lobby Cash Banked']:set_str_data({'Random Amount', 'Input'})

    Script.Feature['Lobby Insurance Notification'] = menu.add_feature('Insurance Notification', 'action_value_str', Script.Parent['Lobby Notifications'], function(f)
        for id = 0, 31 do
            if f.value == 0 then
                scriptevent.Send('Insurance Notification', {player.player_id(), math.random(-2147483647, 2147483647)}, id, Exclude())
                return
            end

            local amount = get.Input('Enter The Amount Of Money (0 - 2147483647)', 10, 3)
            if not amount then
                Notify('Input canceled.', "Error", '')
                return
            end

            scriptevent.Send('Insurance Notification', {player.player_id(), amount}, id, Exclude())
        end
    end)
    Script.Feature['Lobby Insurance Notification']:set_str_data({'Random Amount', 'Input'})

    Script.Feature['Lobby Notification Spam'] = menu.add_feature('Notification Spam', 'value_str', Script.Parent['Lobby Notifications'], function(f)
        while f.on do
            for id = 0, 31 do
                scriptevent.Send('Notification 2', {player.player_id(), 689178114, math.random(-2147483647, 2147483647)}, id, Exclude())
                scriptevent.Send('Notification 2', {player.player_id(), 2187973097, math.random(-2147483647, 2147483647)}, id, Exclude())
                scriptevent.Send('Notification 2', {player.player_id(), 1990572980, math.random(-2147483647, 2147483647)}, id, Exclude())

                if f.value == 0 then
                    scriptevent.Send('Insurance Notification', {player.player_id(), math.random(-2147483647, 2147483647)}, id, Exclude())
                end
            end

            coroutine.yield(200)
        end
    end)
    Script.Feature['Lobby Notification Spam']:set_str_data({'Named', 'Anonymous'})


    Script.Parent['Sound Spam'] = menu.add_feature('Sound Spam', 'parent', Script.Parent['Lobby Trolling'], nil).id

    Script.Feature['Sound Spam Speed'] = menu.add_feature('Spam Delay (ms)', 'autoaction_value_i', Script.Parent['Sound Spam'], function(f)
        settings['Sound Spam Speed'] = {Value = f.value}
    end)
    Script.Feature['Sound Spam Speed'].min = 0
    Script.Feature['Sound Spam Speed'].max = 10000
    Script.Feature['Sound Spam Speed'].mod = 100

    Script.Feature['Sound Rape 1'] = menu.add_feature('Sound Rape', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, '07', v3(75, 2000, 150), 'DLC_GR_CS2_Sounds', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Short Transition In'] = menu.add_feature('Short Transition In', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'Short_Transition_In', v3(75, 2000, 150), 'PLAYER_SWITCH_CUSTOM_SOUNDSET', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound 1st Person Transition'] = menu.add_feature('1st Person Transition', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, '1st_Person_Transition', v3(75, 2000, 150), 'PLAYER_SWITCH_CUSTOM_SOUNDSET', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Mission Pass Notify'] = menu.add_feature('Mission Pass Notify', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'Mission_Pass_Notify', v3(75, 2000, 150), 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound MP Impact'] = menu.add_feature('MP Impact', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'MP_Impact', v3(75, 2000, 150), 'WastedSounds', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Wasted'] = menu.add_feature('Wasted', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'Wasted', v3(75, 2000, 150), 'DLC_IE_VV_General_Sounds', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Wasted 2'] = menu.add_feature('Wasted 2', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'Bed', v3(75, 2000, 150), 'WastedSounds', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound 10 Second Countdown'] = menu.add_feature('10 Second Countdown', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, '10s', v3(75, 2000, 150), 'MP_MISSION_COUNTDOWN_SOUNDSET', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound 5 Second Warning'] = menu.add_feature('5 Second Warning', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, '5_SEC_WARNING', v3(75, 2000, 150), 'HUD_MINI_GAME_SOUNDSET', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound 5 Second Event Start'] = menu.add_feature('5 Second Event Start Countdown', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, '5s_To_Event_Start_Countdown', v3(75, 2000, 150), 'GTAO_FM_Events_Soundset', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)
    
    Script.Feature['Sound Arming Countdown'] = menu.add_feature('Arming Countdown', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'Arming_Countdown', v3(75, 2000, 150), 'GTAO_Speed_Convoy_Soundset', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Click Special'] = menu.add_feature('Click Special', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'Click_Special', v3(75, 2000, 150), 'WEB_NAVIGATION_SOUNDS_PHONE', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Base Jump Passed'] = menu.add_feature('Base Jump Passed', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'BASE_JUMP_PASSED', v3(75, 2000, 150), 'HUD_AWARDS', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Put Phone Away'] = menu.add_feature('Put Phone Away', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'Put_Away', v3(75, 2000, 150), 'Phone_SoundSet_Michael', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Rank Up'] = menu.add_feature('Rank Up', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'RANK_UP', v3(75, 2000, 150), 'HUD_AWARDS', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Waypoint Set'] = menu.add_feature('Waypoint Set', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'WAYPOINT_SET', v3(75, 2000, 150), 'HUD_FRONTEND_DEFAULT_SOUNDSET', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Strong Wind'] = menu.add_feature('Strong Wind', 'toggle', Script.Parent['Sound Spam'], function(f)
        while f.on do
            audio.play_sound_from_coord(-1, 'Whoosh_1s_L_to_R', v3(75, 2000, 150), 'MP_LOBBY_SOUNDS', true, 10000, false)
            audio.play_sound_from_coord(-1, 'Whoosh_1s_R_to_L', v3(75, 2000, 150), 'MP_LOBBY_SOUNDS', true, 10000, false)
            coroutine.yield(Script.Feature['Sound Spam Speed'].value)
        end
    end)

    Script.Feature['Sound Phone Ringing'] = menu.add_feature('Infinite Phone Ringing', 'action', Script.Parent['Sound Spam'], function(f)
        audio.play_sound_from_coord(-1, 'Remote_Ring', v3(75, 2000, 150), 'Phone_SoundSet_Michael', true, 10000, false)
    end)


    Script.Feature['Lobby Random Apartment Invite'] = menu.add_feature('Random Apartment Invite', 'action', Script.Parent['Lobby Trolling'], function()
        for id = 0, 31 do
            scriptevent.Send('Apartment Invite', {player.player_id(), id, 1, 0, math.random(1, 113), 1, 1, 1}, id, Exclude())
        end
    end)

    Script.Feature['Lobby Apartment Invite Loop'] = menu.add_feature('Apartment Invite Loop', 'toggle', Script.Parent['Lobby Trolling'], function(f)
        while f.on do
            for id = 0, 31 do
                scriptevent.Send('Apartment Invite', {player.player_id(), id, 1, 0, math.random(1, 113), 1, 1, 1}, id, Exclude())
            end

            coroutine.yield(5000)
        end
    end)

    Script.Feature['Lobby Warehouse Invite'] = menu.add_feature('Warehouse Invite', 'action_value_str', Script.Parent['Lobby Trolling'], function(f, id)
        if f.value == 22 then
            for id = 0, 31 do
                scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, math.random(1, 22)}, id, Exclude())
            end
            return
        end

        for id = 0, 31 do
            scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, f.value + 1}, id, Exclude())
        end
    end)
	Script.Feature['Lobby Warehouse Invite']:set_str_data({
    'Elysian Island North',
    'La Puerta North',
    'La Mesa Mid',
    'Rancho West',
    'West Vinewood',
    'LSIA North',
    'Del Perro',
    'LSIA South',
    'Elysian Island South',
    'El Burro Heights',
    'Elysian Island West',
    'Textile City',
    'La Puerta South',
    'Strawberry',
    'Downtown Vinewood North',
    'La Mesa South',
    'La Mesa North',
    'Cypress Flats North',
    'Cypress Flats South',
    'West Vinewood West',
    'Rancho East',
    'Banning',
    'Random'
    })

    Script.Feature['Lobby Warehouse Invite Loop'] = menu.add_feature('Warehouse Invite Loop', 'toggle', Script.Parent['Lobby Trolling'], function(f, id)
        while f.on do
            for id = 0, 31 do
                scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, math.random(1, 22)}, id, Exclude())
            end

            coroutine.yield(5000)
        end
    end)

    Script.Feature['Lobby Script Freeze'] = menu.add_feature('Script Freeze', 'value_str', Script.Parent['Lobby Trolling'], function(f, id)
        while f.on do
            if f.value == 0 then
                for id = 0, 31 do
                    scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, 0}, id, Exclude())
                end
            else
                for id = 0, 31 do
                    scriptevent.Send('Script Freeze', {player.player_id()}, id, Exclude())
                end
            end

            coroutine.yield(200)
        end
    end)
    Script.Feature['Lobby Script Freeze']:set_str_data({'v1', 'v2'})

    Script.Feature['Lobby Freemode Mission'] = menu.add_feature('Start Freemode Mission', 'action', Script.Parent['Lobby Trolling'], function(f)
        for id = 0, 31 do
            scriptevent.Send('Start Freemode Mission', {player.player_id(), 263, 4294967295}, id, Exclude())
        end
    end)

    Script.Feature['Lobby Force Camera Forward'] = menu.add_feature('Force Camera Forward', 'toggle', Script.Parent['Lobby Trolling'], function(f)
        while f.on do
            for id = 0, 31 do
                scriptevent.Send('Camera Manipulation', {player.player_id(), 869796886, 0}, id, Exclude())
            end

            coroutine.yield(200)
        end
    end)

    Script.Feature['Lobby Transaction Error'] = menu.add_feature('Transaction Error', 'toggle', Script.Parent['Lobby Trolling'], function(f)
        while f.on do
            for id = 0, 31 do
                scriptevent.Send('Transaction Error', {player.player_id(), 50000, 0, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id, Exclude())
            end
            
            coroutine.yield(1000)
        end
    end)

    Script.Feature['Lobby Set Bounty'] = menu.add_feature("Set Bounty: Input", "action_value_str", Script.Parent['Lobby Trolling'], function(f)
        if script.get_host_of_this_script() == player.player_id() then
            Notify('This doesnt work while you are Script Host!', "Error", '')
            return
        end

        local amount = tonumber(get.Input('Enter Bounty Value (0 - 10000)', 5, 3, "10000"))
        if not amount then
            Notify('Input canceled.', "Error", '')
            return
        end

        if amount > 10000 then
            Notify('Value cannot be more than 10000!', "Error", '')
            return
        end

        for id = 0, 31 do
            if utility.valid_player(id, Script.Feature['Exclude Friends'].on) and not scriptevent.DoesPlayerHaveBounty(id) then
                scriptevent.setBounty(id, amount, f.value)
            end

            coroutine.yield(100)
        end
    end)
	Script.Feature['Lobby Set Bounty']:set_str_data({"Named", "Anonymous"})

    Script.Feature['Lobby Bounty After Death'] = menu.add_feature("Reapply Bounty after Death", "value_str", Script.Parent['Lobby Trolling'], function(f)
        if script.get_host_of_this_script() == player.player_id() then
            Notify('This doesnt work while you are Script Host!', "Error", '')
            f.on = false
            return
        end

        while f.on do
            if not inputs.lobby_bounty then
                local bounty_value = get.Input('Enter Bounty Value (0 - 10000)', 5, 3, "10000")
                if bounty_value then
                    if tonumber(bounty_value) > 10000 then
                        Notify('Value cannot be more than 10000!', "Error", '')
                        f.on = false
                        return
                    else
                        inputs.lobby_bounty = bounty_value
                    end
                else
                    Notify('Input canceled.', "Error", '')
                    f.on = false
                    return
                end
            else
                for id = 0, 31 do
                    if utility.valid_player(id, Script.Feature['Exclude Friends'].on) and entity.is_entity_dead(get.PlayerPed(id)) then
                        Notify(get.Name(id) .. ' is dead!\nReapplying bounty...', "Neutral")
                        Log(get.Name(id) .. ' is dead!\nReapplying bounty...')
                        scriptevent.setBounty(id, inputs.lobby_bounty, f.value)
                        coroutine.yield(2000)
                    end
                end
            end
            coroutine.yield(0)
        end
        inputs.lobby_bounty = nil
    end)
	Script.Feature['Lobby Bounty After Death']:set_str_data({"Named", "Anonymous"})

    Script.Feature['Lobby Vehicle Kick'] = menu.add_feature('Vehicle Kick', 'action', Script.Parent['Lobby Trolling'], function()
        for id = 0, 31 do
            scriptevent.Send('Vehicle Kick', {player.player_id(), 4294967295, 4294967295, 4294967295}, id, Exclude())
        end
    end)

    Script.Feature['Lobby Vehicle EMP'] = menu.add_feature('Vehicle EMP', 'action', Script.Parent['Lobby Trolling'], function()
        for id = 0, 31 do
            local pos = get.PlayerCoords(id)
            scriptevent.Send('Vehicle EMP', {player.player_id(), Math.ToInt(pos.x), Math.ToInt(pos.y), Math.ToInt(pos.z), 0}, id, Exclude())
        end
    end)

    Script.Feature['Lobby Destroy Personal Vehicle'] = menu.add_feature('Destroy Personal Vehicle', 'action', Script.Parent['Lobby Trolling'], function()
        for id = 0, 31 do
            if scriptevent.GetPersonalVehicle(id) == 0 then
                goto continue
            end

            scriptevent.Send('Destroy Personal Vehicle', {player.player_id(), id}, id, true)
            scriptevent.Send('Vehicle Kick', {player.player_id(), 4294967295, 4294967295, 4294967295}, id, Exclude())

            ::continue::
        end
    end)

    Script.Feature['Lobby Disable Ability to Drive'] = menu.add_feature('Disable Ability to Drive', 'action', Script.Parent['Lobby Trolling'], function()
        for id = 0, 31 do
            scriptevent.Send('Apartment Invite', {player.player_id(), player.player_id(), 4294967295, 1, 115, 0, 0, 0}, id, Exclude())
        end
    end)

    Script.Feature['Lobby Trap In Cage'] = menu.add_feature('Trap Lobby in Cage', 'action_value_str', Script.Parent['Lobby Trolling'], function(f)
        for id = 0, 31 do
            if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                if f.value == 0 then
                    local pos = get.PlayerCoords(id)

                    Spawn.Object(2718056036, v3(pos.x, pos.y, pos.z + 0.5))
                    Spawn.Object(2718056036, v3(pos.x, pos.y, pos.z - 0.5))
                    return
                end

                local pos1, pos2 = get.PlayerCoords(id), get.PlayerCoords(id)

                pos1.x = pos1.x + 1.24
                pos1.y = pos1.y + 0.24

                pos2.x = pos2.x + 0.02
                pos2.y = pos2.y + 0.82

                local cage = Spawn.Object(401136338, pos1)
                entity.set_entity_rotation(cage, v3(0, -90, 0))
                entity.freeze_entity(cage, true)
                    
                local cage2 = Spawn.Object(401136338, pos2)
                entity.set_entity_rotation(cage2, v3(90, -90, 0))
                entity.freeze_entity(cage2, true)
            end

            coroutine.yield(0)
        end
    end)
    Script.Feature['Lobby Trap In Cage']:set_str_data({'v1', 'v2'})

    Script.Feature['Lobby Trap In Cage2'] = menu.add_feature('Trap Lobby in Invisible Cage', 'action_value_str', Script.Parent['Lobby Trolling'], function(f)
        for id = 0, 31 do
            if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                if f.value == 0 then
                    local pos = get.PlayerCoords(id)

                    local cage = Spawn.Object(2718056036, v3(pos.x, pos.y, pos.z + 0.5))
                    local cage2 = Spawn.Object(2718056036, v3(pos.x, pos.y, pos.z - 0.5))

                    entity.set_entity_visible(cage, false)
                    entity.set_entity_visible(cage2, false)
                    return
                end

                local pos1, pos2 = get.PlayerCoords(id), get.PlayerCoords(id)
                    
                pos1.x = pos1.x + 1.24
                pos1.y = pos1.y + 0.24
                    
                pos2.x = pos2.x + 0.02
                pos2.y = pos2.y + 0.82
                    
                local cage = Spawn.Object(401136338, pos1)
                entity.set_entity_rotation(cage, v3(0, -90, 0))
                entity.freeze_entity(cage, true)
                    
                local cage2 = Spawn.Object(401136338, pos2)
                entity.set_entity_rotation(cage2, v3(90, -90, 0))
                entity.freeze_entity(cage2, true)
                    
                entity.set_entity_visible(cage, false)
                entity.set_entity_visible(cage2, false)
            end

            coroutine.yield(0)
        end
    end)
    Script.Feature['Lobby Trap In Cage2']:set_str_data({'v1', 'v2'})



    Script.Parent['Lobby Griefing'] = menu.add_feature('Griefing', 'parent', Script.Parent['local_lobby'], nil).id

    Script.Feature['Explosion Blame'] = menu.add_feature('Player Blame', 'action_value_str', Script.Parent['Lobby Griefing'], function(f)
        if f.value == 0 then
            inputs.explosion_blame = 0
            Notify('Explosion Kills are now anonymous.', "Success", '')

        elseif f.value == 1 then
            inputs.explosion_blame = get.OwnPed()
            Notify('You are now earning the blame for any Explosion Kills.', "Success", '')

        elseif f.value == 2 then
            Notify('Explosion Kill blame is now random.', "Success", '')

        else
            local id = get.Input('Enter the Targets Player ID', 2, 3)
            if not id then
                Notify('Input canceled.', "Error", '')
                return
            end

            if not player.is_player_valid(id) then
                Notify('Invalid Player!', "Error", '')
                return
            end

            inputs.explosion_blame = get.PlayerPed(id)
            Notify('Now blaming ' .. get.Name(id) .. ' for any Kills.', "Success", '')  
        end
    end)
    Script.Feature['Explosion Blame']:set_str_data({'Anonymous', 'Self', 'Random', 'ID Input'})

    Script.Parent['Explosion Settings'] = menu.add_feature('Custom Explosion', 'parent', Script.Parent['Lobby Griefing'], nil).id

    Script.Feature['Explosion Delay'] = menu.add_feature('Explosion Delay (ms)', 'autoaction_value_i', Script.Parent['Explosion Settings'], function(f)
        settings['Explosion Delay'] = {Value = f.value}
    end)
    Script.Feature['Explosion Delay'].min = 100
    Script.Feature['Explosion Delay'].max = 10000
    Script.Feature['Explosion Delay'].mod = 100

    Script.Feature['Explosion Invisibility'] = menu.add_feature('Invisible Explosions ', 'toggle', Script.Parent['Explosion Settings'], function(f)
        settings['Explosion Invisibility'] = {Enabled = f.on}
    end)

    Script.Feature['Explosion Silent'] = menu.add_feature('Silent Explosions', 'toggle', Script.Parent['Explosion Settings'], function(f)
        settings['Explosion Silent'] = {Enabled = f.on}
    end)

    Script.Feature['Explosion Camshake'] = menu.add_feature('Cam Shake Intensity', 'autoaction_value_i', Script.Parent['Explosion Settings'], function(f)
        settings['Explosion Camshake'] = {Value = f.value}
    end)
    Script.Feature['Explosion Camshake'].min = 0.00
    Script.Feature['Explosion Camshake'].max = 100.00
    Script.Feature['Explosion Camshake'].mod = 5.00
    
    Script.Feature['Explosion Custom'] = menu.add_feature('Explode Lobby', 'value_str', Script.Parent['Explosion Settings'], function(f)
        while f.on do
            local sounds =  true
            if Script.Feature['Explosion Silent'].on then
                sounds = false
            end

            local blame = inputs.explosion_blame

            for id = 0, 31 do
                if Script.Feature['Explosion Blame'].value == 2 then
                    local id = -1
                    while not utility.valid_player(id) do
                        id = math.random(0, 31)
                        coroutine.yield(0)
                    end
                    blame = get.PlayerPed(id)
                end

                if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                    fire.add_explosion(get.PlayerCoords(id), f.value, sounds, Script.Feature['Explosion Invisibility'].on, Script.Feature['Explosion Camshake'].value, blame)
                end

            end

            coroutine.yield(500)
        end
    end)
    Script.Feature['Explosion Custom']:set_str_data({
        'Grenade',
        'Grenade Launcher',
        'Stickybomb',
        'Molotov',
        'Rocket',
        'Tankshell',
        'Octane',
        'Car',
        'Plane',
        'Petrol Pump',
        'Bike',
        'Water',
        'Flame',
        'Water Hydrant',
        'Flame Canister',
        'Boat',
        'Ship Destroy',
        'Truck',
        'Bullet',
        'Smoke Launcher',
        'Smoke Grenade',
        'BZ Gas',
        'Flase',
        'Gas Canister 2',
        'Extinguisher',
        'Programmable AR',
        'Train',
        'Barrel',
        'Propane',
        'Blimp',
        'Flame 2',
        'Tanker',
        'Plane Rocket',
        'Vehicle Bullet',
        'Gas Tank',
        'Bird Crap',
        'Railgun',
        'Blimp 2',
        'Firework',
        'Snowball',
        'Proxmine',
        'Valkyrie Cannon',
        'Air Defence',
        'Pipe Bomb',
        'Vehicle Mine',
        'Explosive Ammo',
        'APC Shell',
        'Bomb Cluster',
        'Bomb Gas',
        'Bomb Incendiary',
        'Bomb Standard',
        'Torpedo',
        'Torpedo Underwater',
        'Bombushka Canon',
        'Bomb Cluster Secondary',
        'Hunter Barrage',
        'Hunter Cannon',
        'Rogue Cannon',
        'Mine Underwater',
        'Orbital Canon',
        'Bomb Std Wide',
        'Explosive Shotgun',
        'Oppressor MK II Cannon',
        'Mortar Kinetic',
        'Vehicle Mine Kinetic',
        'Vehicle Mine EMP',
        'Vehicle Mine Spike',
        'Vehicle Mine Slick',
        'Vehicle Mine Tar',
        'Script Drone',
        'Up-n-Atomizer',
        'Buried Mine',
        'Script Missile',
        'RC Tank Rocket',
        'Bomb Water',
        'Bomb Water Secondary',
        'Extinguisher 2',
        'Extinguisher 3',
        'Extinguisher 4',
        'Extinguisher 5',
        'Extinguisher 6',
        'Script Missile Large',
        'Submarine Big',
        'EMP',
    })

    local lobbyexplosions = {
        {Name = 'Explode Lobby', Type = 27, Camshake = 1},
        {Name = 'Set Lobby on Fire', Type = 14, Camshake = 0},
        {Name = 'Orbital Cannon Spam', Type = 59, Camshake = 10},
        {Name = 'Water Hydrant Spam', Type = 13, Camshake = 0}
    }

    for i = 1, #lobbyexplosions do
        local Name = lobbyexplosions[i].Name
        local Type = lobbyexplosions[i].Type
        local Camshake = lobbyexplosions[i].Camshake

        Script.Feature[Name] = menu.add_feature(Name, 'toggle', Script.Parent['Lobby Griefing'], function(f)
            local blame = inputs.explosion_blame
    
            if Script.Feature['Explosion Blame'].value == 2 then
                local id = -1
                while not utility.valid_player(id) do
                    id = math.random(0, 31)
                    coroutine.yield(0)
                end
    
                blame = get.PlayerPed(id)
            end
    
            while f.on do
                for id = 0, 31 do
                    if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                        fire.add_explosion(get.PlayerCoords(id), Type, true, false, Camshake, blame)
    
                    end
    
                end
    
                coroutine.yield(500)
            end

        end)
    end

    Script.Feature['Freeze Lobby'] = menu.add_feature('Freeze Lobby', 'toggle', Script.Parent['Lobby Griefing'], function(f)
        while f.on do
            for id = 0, 31 do
                if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                    ped.clear_ped_tasks_immediately(get.PlayerPed(id))
                end

            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Lobby Infinite Apartment Invite'] = menu.add_feature('Infinite Apartment Invite', 'action', Script.Parent['Lobby Griefing'], function()
        for id = 0, 31 do
            scriptevent.Send('Apartment Invite', {player.player_id(), id, 4294967295, 1, 115, 0, 0, 0}, id, Exclude())
        end
    end)

    Script.Feature['Lobby Force Cutscene'] = menu.add_feature('Force Casino Cutscene', 'action', Script.Parent['Lobby Griefing'], function()
        for id = 0, 31 do
            scriptevent.Send('Casino Cutscene', {player.player_id()}, id, Exclude())
        end
    end)

    Script.Feature['Lobby Force Island'] = menu.add_feature('Force to Perico Island', 'action', Script.Parent['Lobby Griefing'], function()
        for id = 0, 31 do
            scriptevent.Send('Force To Island', {player.player_id(), 1}, id, Exclude())
        end
    end)

    Script.Feature['Lobby Force Mission'] = menu.add_feature("Force to Mission", "action_value_str", Script.Parent['Lobby Griefing'], function(f)
        for id = 0, 31 do
            scriptevent.Send('Force To Mission', {player.player_id(), f.value}, id, Exclude())
        end
    end)
	Script.Feature['Lobby Force Mission']:set_str_data({'Severe Weather', 'Half Track', 'Night Shark AAT', 'APC Mission', 'MOC Mission', 'Tampa Mission', 'Opressor Mission 1', 'Opressor Mission 2'})

    Script.Feature['Lobby CEO'] = menu.add_feature("CEO Removal", "action_value_str", Script.Parent['Lobby Griefing'], function(f)
        for id = 0, 31 do
            if scriptevent.IsPlayerInOrg(id) then
                if f.value == 0 then
                    scriptevent.Send('CEO Kick', {player.player_id(), 1, 5}, id, Exclude())
                elseif f.value == 1 then
                    scriptevent.Send('CEO Kick', {player.player_id(), 1, 6}, id, Exclude())
                else
                    scriptevent.Send('CEO Ban', {player.player_id(), 1}, id, Exclude())
                end
            end
        end
    end)
	Script.Feature['Lobby CEO']:set_str_data({"Demiss", "Terminate", "Ban"})

    Script.Feature['Lobby Passive Mode'] = menu.add_feature("Block Passive Mode", "toggle", Script.Parent['Lobby Griefing'], function(f)
        while f.on do
            for id = 0, 31 do
                scriptevent.Send('Passive Mode', {player.player_id(), 1}, id, Exclude())
            end

            coroutine.yield(200)
        end

        for id = 0, 31 do
            scriptevent.Send('Passive Mode', {player.player_id(), 0}, id, Exclude())
        end
    end)


    Script.Parent['Lobby Friendly'] = menu.add_feature('Friendly', 'parent', Script.Parent['local_lobby'], nil).id

    Script.Parent['Lobby Spawn Vehicles'] = menu.add_feature('Spawn Vehicles', 'parent', Script.Parent['Lobby Friendly'], nil).id

    Script.Parent['Lobby Spawn Vehicle Settings'] = menu.add_feature('Spawn Settings', 'parent', Script.Parent['Lobby Spawn Vehicles'], nil).id

    Script.Feature['Lobby Spawn Vehicle Upgraded'] = menu.add_feature('Upgraded', 'value_str', Script.Parent['Lobby Spawn Vehicle Settings'], function(f)
        settings['Lobby Spawn Vehicle Upgraded'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Lobby Spawn Vehicle Upgraded']:set_str_data({'Max', 'Performance'})

    Script.Feature['Lobby Spawn Vehicle Godmode'] = menu.add_feature('Godmode', 'toggle', Script.Parent['Lobby Spawn Vehicle Settings'], function(f)
        settings['Lobby Spawn Vehicle Godmode'] = {Enabled = f.on}
    end)

    Script.Feature['Lobby Spawn Vehicle Lockon'] = menu.add_feature('Lock-on Disabled', 'toggle', Script.Parent['Lobby Spawn Vehicle Settings'], function(f)
        settings['Lobby Spawn Vehicle Lockon'] = {Enabled = f.on}
    end)

    Script.Feature['Spawn Vehicle for All'] = menu.add_feature('Model/Hash Input', 'action', Script.Parent['Lobby Spawn Vehicles'], function()
        local _input = get.Input("Enter Vehicle Name, Model Name or Hash")
        if not _input then
            Notify('Input canceled.', "Error", '')
            return
        end

        local hash = _input
        if not tonumber(_input) then
            if mapper.veh.GetHashFromName(_input) ~= nil then
                hash = mapper.veh.GetHashFromName(_input)
            else
                hash = gameplay.get_hash_key(_input)
            end
        end

        if not streaming.is_model_a_vehicle(hash) then
            Notify('Input is not a valid vehicle.', "Error", '')
            return
        end

        for id = 0, 31 do
            if player.is_player_valid(id) and id ~= player.player_id() and not get.GodmodeState(id) then
                local pos = get.PlayerCoords(id)
                pos.z = Math.GetGroundZ(pos.x, pos.y)

                local veh = Spawn.Vehicle(hash, utility.OffsetCoords(pos, get.PlayerHeading(id), 10))

                utility.request_ctrl(veh)
                decorator.decor_set_int(veh, 'MPBitset', 1 << 10)

                if Script.Feature['Lobby Spawn Vehicle Upgraded'].on then
                    utility.MaxVehicle(veh, Script.Feature['Lobby Spawn Vehicle Upgraded'].value + 1)
                end

                if Script.Feature['Lobby Spawn Vehicle Godmode'].on then
                    entity.set_entity_god_mode(veh, true)
                end

                if Script.Feature['Lobby Spawn Vehicle Lockon'].on then
                    vehicle.set_vehicle_can_be_locked_on(veh, false, false)
                end

            end
        end
    end)


    Script.Parent['Lobby CEO Money'] = menu.add_feature('CEO Money', 'parent', Script.Parent['Lobby Friendly'], function()
        if not Script.Feature['Disable Warning Messages'].on then
            Notify('Only Players who are an associate in any Organisation will receive the Money.\nEnabling multiple Loops at once can cause Transaction Errors!', "Neutral")
            coroutine.yield(5000)
        end
    end).id

    Script.Feature['Lobby CEO Loop Preset'] = menu.add_feature('Preset', 'toggle', Script.Parent['Lobby CEO Money'], function(f)
        menu.create_thread(function()
            while f.on do
                for id = 0, 31 do
                    if scriptevent.IsPlayerAssociate(id) then
                        scriptevent.Send('CEO Money', {player.player_id(), 10000, -1292453789, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id)
                    end
                end

                coroutine.yield(40000)
            end
        end, nil)
    
        coroutine.yield(5000)
        while f.on do
            for id = 0, 31 do
                if scriptevent.IsPlayerAssociate(id) then
                    scriptevent.Send('CEO Money', {player.player_id(), 30000, 198210293, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id)
                end
            end
    
            coroutine.yield(150000)
        end
    end)

    for i = 1, #miscdata.ceomoney do
        Script.Feature['Lobby CEO Loop ' .. i] = menu.add_feature(miscdata.ceomoney[i][1] .. ' (ms)', 'value_i', Script.Parent['Lobby CEO Money'], function(f)
            settings['Lobby CEO Loop ' .. i] = {Value = f.value}
            while f.on do
                for id = 0, 31 do
                    if scriptevent.IsPlayerAssociate(id) then
                        scriptevent.Send('CEO Money', {player.player_id(), miscdata.ceomoney[i][2], miscdata.ceomoney[i][3], miscdata.ceomoney[i][4], scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id)
                    end

                end

                settings['Lobby CEO Loop ' .. i].Value = f.value
                coroutine.yield(f.value)
            end

        end)
        Script.Feature['Lobby CEO Loop ' .. i].min = 10000
        Script.Feature['Lobby CEO Loop ' .. i].max = 300000
        Script.Feature['Lobby CEO Loop ' .. i].mod = 10000
        Script.Feature['Lobby CEO Loop ' .. i].value = miscdata.ceomoney[i][5]
    end

    Script.Feature['Lobby Off The Radar'] = menu.add_feature('Off The Radar', 'toggle', Script.Parent['Lobby Friendly'], function(f)
        while f.on do
            for id = 0, 31 do
                if not scriptevent.IsPlayerOTR(id) then
                    scriptevent.Send('Off The Radar', {player.player_id(), utils.time() - 60, utils.time(), 1, 1, scriptevent.MainGlobal(id)}, id)
                end

            end
            coroutine.yield(0)
        end
    end)

    Script.Feature['Lobby Bribe Authorities'] = menu.add_feature('Bribe Authorities', 'toggle', Script.Parent['Lobby Friendly'], function(f)
        while f.on do
            for id = 0, 31 do
                scriptevent.Send('Bribe Authorities', {player.player_id(), 0, 0, utils.time_ms(), 0, scriptevent.MainGlobal(id)}, id)
            end

            coroutine.yield(5000)
        end
    end)

    Script.Feature['Lobby Remove Wanted'] = menu.add_feature('Remove Wanted', 'toggle', Script.Parent['Lobby Friendly'], function(f)
        while f.on do
            for id = 0, 31 do
                if player.get_player_wanted_level(id) > 0 then
                    scriptevent.Send('Remove Wanted', {player.player_id(), scriptevent.MainGlobal(id)}, id)
                end

            end

            coroutine.yield(0)
        end
    end)


    Script.Parent['Chat Commands'] = menu.add_feature('Chat Commands', 'parent', Script.Parent['local_lobby'], nil).id

    Script.Feature['Enable Commands'] = menu.add_feature('Enable Chat Commands', 'value_str', Script.Parent['Chat Commands'], function(f)
        settings['Enable Commands'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Enable Commands']:set_str_data({'All Players', 'Friends Only'})

    Script.Feature['Block Friends as Target'] = menu.add_feature('Block Friends as Target', 'toggle', Script.Parent['Chat Commands'], function(f)
        settings['Block Friends as Target'] = {Enabled = f.on}
    end)

    Script.Parent['Command List'] = menu.add_feature('Command List', 'parent', Script.Parent['Chat Commands'], nil).id

    for i = 1, #cmds.all do
        Script.Feature[cmds.all[i][1]] = menu.add_feature(cmds.all[i][2], 'toggle', Script.Parent['Command List'], function(f)
            settings[cmds.all[i][1]] = {Enabled = f.on}
        end)
    end

    Script.Parent['Commands for Self'] = menu.add_feature('Self Only Commands', 'parent', Script.Parent['Chat Commands'], nil).id

    for i = 1, #cmds.self do
        Script.Feature[cmds.self[i][1]] = menu.add_feature(cmds.self[i][2], 'toggle', Script.Parent['Commands for Self'], function(f)
            settings[cmds.self[i][1]] = {Enabled = f.on}
        end)
    end
     

    Script.Feature['Send Chat Commands'] = menu.add_feature('Send Active Commands in Chat', 'action_value_str', Script.Parent['Chat Commands'], function(f)
        if not Script.Feature['Enable Commands'].on then
            Notify('Chat Commands are not enabled!', "Error", '')
            return
        end

        local commands = {}
        for i = 1, #cmds.all do
            if Script.Feature[cmds.all[i][1]].on then
                commands[i] = cmds.all[i][2]
            end
        end

        if #commands == 0 then
            Notify('No active Commands!', "Error", '')
            return
        end
            
        if f.value == 0 then
            network.send_chat_message('Active Chat Commands for this Session:' .. utility.print_table(commands):sub(1, -3), false)
            return
        end

        network.send_chat_message('Active Chat Commands for this Session:' .. utility.print_table(commands):sub(1, -3), true)
    end)
    Script.Feature['Send Chat Commands']:set_str_data({'All', 'Team'})

    Script.Feature['Continuously Send Commands'] = menu.add_feature('Send Commands Repeatedly (Min)', 'value_i', Script.Parent['Chat Commands'], function(f)
        while f.on do
            if Script.Feature['Enable Commands'].on then
                Notify('Chat Commands are not enabled!', "Error", '')
                f.on = false
                return
            end

            local commands = {}
            for i = 1, #cmds.all do
                if Script.Feature[cmds.all[i][1]].on then
                    commands[i] = cmds.all[i][2]
                end
            end

            if #commands == 0 then
                Notify('No active Commands!', "Error", '')
                f.on = false
                return
            end

            network.send_chat_message('Active Chat Commands for this Session:' .. utility.print_table(commands), false)
            coroutine.yield(f.value * 60000)
        end
    end)
    Script.Feature['Continuously Send Commands'].min = 5
    Script.Feature['Continuously Send Commands'].max = 60
    Script.Feature['Continuously Send Commands'].mod = 5


    Script.Parent['Chat Spam'] = menu.add_feature('Chat Spam', 'parent', Script.Parent['local_lobby'], nil).id

    Script.Feature['Disable Chat'] = menu.add_feature('Disable Chat', 'toggle', Script.Parent['Chat Spam'], function(f)
        while f.on do
            network.send_chat_message(' ', false)
            coroutine.yield(0)
        end
    end)

    Script.Feature['Chat Spam Delay'] = menu.add_feature('Spam Delay (ms)', 'autoaction_value_i', Script.Parent['Chat Spam'], function(f)
        settings['Chat Spam Delay'] = {Value = f.value}
    end)
    Script.Feature['Chat Spam Delay'].min = 100
    Script.Feature['Chat Spam Delay'].max = 10000
    Script.Feature['Chat Spam Delay'].mod = 100

    Script.Feature['Chat Spamer'] = menu.add_feature('Chat Spam', 'toggle', Script.Parent['Chat Spam'], function(f)
        while f.on do
            if not inputs.chat_spam then
                local msg = get.Input('Enter message to spam', 250)
                if msg then
                    inputs.chat_spam = msg
                else
                    Notify('Input canceled.', "Error", '')
                    f.on = false
                    return
                end
            end
            if inputs.chat_spam then
                network.send_chat_message(inputs.chat_spam, false)
                coroutine.yield(Script.Feature['Chat Spam Delay'].value)
            end
            coroutine.yield(0)
        end
        inputs.chat_spam = nil
    end)

    Script.Feature['Spam Text from Clipboard'] = menu.add_feature('Spam Text from Clipboard', 'toggle', Script.Parent['Chat Spam'], function(f)
        while f.on do
            network.send_chat_message(utils.from_clipboard(), false)
            coroutine.yield(Script.Feature['Chat Spam Delay'].value)
        end
    end)

    Script.Feature['Send Text from Clipboard'] = menu.add_feature('Paste Text from Clipboard', 'action', Script.Parent['Chat Spam'], function()
        network.send_chat_message(utils.from_clipboard(), false)
    end)

    Script.Feature['Echo Chat'] = menu.add_feature('Echo Chat X times', 'value_i', Script.Parent['Chat Spam'], function(f)
        settings['Echo Chat'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Echo Chat'].min = 1
    Script.Feature['Echo Chat'].max = 10


    Script.Parent['Lobby SMS Sender'] = menu.add_feature('SMS Sender', 'parent', Script.Parent['local_lobby'], function()
        if not Script.Feature['Disable Warning Messages'].on then
            Notify('Only Players who have Voice-Chat enabled can receive SMS.', "Neutral")
            coroutine.yield(5000)
        end
    end).id

    Script.Feature['Lobby Send Custom SMS'] = menu.add_feature('Send SMS: Input', 'action', Script.Parent['Lobby SMS Sender'], function(f)
        local Message = get.Input('Enter message to send')
        if not Message then
            Notify('Input canceled.', "Error", '')
            return
        end

        for id = 0, 31 do
            if utility.valid_player(id) then
                player.send_player_sms(id, Message)
            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Lobby Send SCID And IP'] = menu.add_feature('Send their SCID & IP', 'action', Script.Parent['Lobby SMS Sender'], function(f)
        for id = 0, 31 do
            if utility.valid_player(id) then
                player.send_player_sms(id, 'R*SCID: ' .. tostring(get.SCID(id)) .. '~n~IP: ' .. get.IP(id))
            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['SMS Delay'] = menu.add_feature('Spam Delay (ms)', 'autoaction_value_i', Script.Parent['Lobby SMS Sender'], function(f)
        settings['SMS Delay'] = {Value = f.value}
    end)
    Script.Feature['SMS Delay'].min = 100
    Script.Feature['SMS Delay'].max = 10000
    Script.Feature['SMS Delay'].mod = 100

    Script.Feature['Lobby Spam Custom SMS'] = menu.add_feature('Spam SMS: Input', 'toggle', Script.Parent['Lobby SMS Sender'], function(f)
        while f.on do
            if not inputs.sms_spam then
                local msg = get.Input('Enter message to spam')
                if msg then
                    inputs.sms_spam = msg
                else
                    Notify('Input canceled.', "Error", '')
                    f.on = false
                    return
                end
            else
                for id = 0, 31 do
                    if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                        player.send_player_sms(id, inputs.sms_spam)
                    end
                    coroutine.yield(Script.Feature['SMS Delay'].value)
                end
            end
            coroutine.yield(0)
        end
        inputs.sms_spam = nil
    end)
    
    Script.Feature['Lobby Spam SCID And IP'] = menu.add_feature('Spam their SCID & IP', 'toggle', Script.Parent['Lobby SMS Sender'], function(f)
        while f.on do
            for id = 0, 31 do
                if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                    player.send_player_sms(id, 'R*SCID: ' .. tostring(get.SCID(id)) .. '~n~IP: ' .. get.IP(id))
                end

            end

            coroutine.yield(Script.Feature['SMS Delay'].value)
        end
    end)

    Script.Parent['Lobby SMS Spam Presets'] = menu.add_feature('Spam Presets', 'parent', Script.Parent['Lobby SMS Sender'], nil).id

    for i = 1, #customData.sms_texts do
        menu.add_feature(customData.sms_texts[i], 'toggle', Script.Parent['Lobby SMS Spam Presets'], function(f)
            while f.on do
                for y = 0, 31 do
                    if utility.valid_player(y, Script.Feature['Exclude Friends'].on) then
                        player.send_player_sms(y, customData.sms_texts[i])
                    end

                end

                coroutine.yield(Script.Feature['SMS Delay'].value)
            end

        end)
    end


    Script.Parent['Lobby Miscellaneous'] = menu.add_feature('Miscellaneous', 'parent', Script.Parent['local_lobby'], nil).id

    local TypingPlayers1 = {}
    local TypingPlayers2 = {}
    local TextFlags = {
        ["NONE"] = 0,
        ["CENTER"] = 1 << 0,
        ["SHADOW"] = 1 << 1,
        ["VCENTER"] = 1 << 2,
        ["BOTTOM"] = 1 << 3,
        ["JUSTIFY_RIGHT"] = 1 << 4,
    }

    Script.Parent['Player Bar'] = menu.add_feature('Player Bar v1', 'parent', Script.Parent['Lobby Miscellaneous'], nil).id

    Script.Feature['Enable Player Bar'] = menu.add_feature('Enable', 'toggle', Script.Parent['Player Bar'], function(f)
        ToggleOff({'Enable Player Bar v2'})
        settings['Enable Player Bar'] = {Enabled = f.on}

        while f.on do
            local allign, position1, position2

            if Script.Feature['Player Bar Text Allign'].value == 0 then
                allign = TextFlags["SHADOW"]
                position1 = v2(-0.98, 0.93)
                position2 = v2(-0.98, 0.98)
            else
                allign = TextFlags["CENTER"]
                position1 = v2(-0.5, 0.93)
                position2 = v2(-0.5, 0.98)
            end

            if Script.Feature['Player Bar Background'].on then
                if Script.Feature['Player Bar Current Time'].on and Script.Feature['Player Bar Players'].on then
                    scriptdraw.draw_rect(v2(1, 1), v2(5, 0.38), Math.RGBAToInt(10, 10, 10, Script.Feature['Player Bar Background'].value))
                elseif Script.Feature['Player Bar Players'].on then
                    scriptdraw.draw_rect(v2(1, 1), v2(5, 0.32), Math.RGBAToInt(10, 10, 10, Script.Feature['Player Bar Background'].value))
                else
                    scriptdraw.draw_rect(v2(1, 1), v2(5, 0.12), Math.RGBAToInt(10, 10, 10, Script.Feature['Player Bar Background'].value))
                end
            
            end

            local color = Math.RGBAToInt(Script.Feature['Player Bar Text Red'].value, Script.Feature['Player Bar Text Green'].value, Script.Feature['Player Bar Text Blue'].value, 255)

            if Script.Feature['Player Bar Current Time'].on then
                scriptdraw.draw_text(Math.TimePrefix(), v2(-0.5, 0.98), v2(1, 1), 0.6, color, TextFlags['CENTER'])
            end
            
            if Script.Feature['Player Bar Script Version'].on then
                scriptdraw.draw_text("Version " .. _2t1s, v2(0.88, 0.98), v2(1, 1), 0.6, color, TextFlags['SHADOW'])
            end
            
            if Script.Feature['Player Bar Players'].on then
                local PlayerDisplay = {}

                for id = 0, 29 do
                    local Name, text

                    if not player.is_player_valid(id) then
                        goto continue
                    end

                    Name = get.Name(id)

                    text = " ["

                    if id == player.player_id() and Script.Feature['Player Bar Y'].on then
                        text = text .. "Y"
                    end

                    if player.is_player_modder(id, -1) and Script.Feature['Player Bar M'].on then
                        text = text .. "M"
                    end

                    if player.is_player_host(id) and Script.Feature['Player Bar H'].on then
                        text = text .. "H"
                    end

                    if script.get_host_of_this_script() == id and Script.Feature['Player Bar S'].on then
                        text = text .. "S"
                    end

                    if player.is_player_god(id) and Script.Feature['Player Bar G'].on then
                        text = text .. "G"
                    end

                    for i = 1, #TypingPlayers2 do
                        if TypingPlayers2[i] == Name and Script.Feature['Player Bar T'].on then
                            text = text .. "T"
                        end
                    end

                    text = text .. "]   "

                    if text == " []   " then
                        PlayerDisplay[Name] = Name .. "   "
                    else
                        PlayerDisplay[Name] = Name .. text
                    end

                    ::continue::
                end

                local size
                local fulltext = utility.print_table(PlayerDisplay, 3):sub(1, -3)
                if string.len(fulltext) < 400 then
                    size = 0.6
                else
                    size = 0.55
                end

                if Script.Feature['Player Bar Current Time'].on then
                    scriptdraw.draw_text(fulltext, position1, v2(1, 1), size, color, allign)
                else
                    scriptdraw.draw_text(fulltext, position2, v2(1, 1), size, color, allign)
                end
                
            end

            coroutine.yield(0)
        end

        settings['Enable Player Bar'].Enabled = f.on
    end)

    Script.Parent['Player Bar Tags'] = menu.add_feature('Player tags', 'parent', Script.Parent['Player Bar'], nil).id

    Script.Feature['Player Bar Y'] = menu.add_feature('Y = Yourself', 'toggle', Script.Parent['Player Bar Tags'], function(f)
        settings['Player Bar Y'] = {Enabled = f.on}
    end)

    Script.Feature['Player Bar M'] = menu.add_feature('M = Modder', 'toggle', Script.Parent['Player Bar Tags'], function(f)
        settings['Player Bar M'] = {Enabled = f.on}
    end)

    Script.Feature['Player Bar H'] = menu.add_feature('H = Session Host', 'toggle', Script.Parent['Player Bar Tags'], function(f)
        settings['Player Bar H'] = {Enabled = f.on}
    end)

    Script.Feature['Player Bar S'] = menu.add_feature('S = Script Host', 'toggle', Script.Parent['Player Bar Tags'], function(f)
        settings['Player Bar S'] = {Enabled = f.on}
    end)

    Script.Feature['Player Bar G'] = menu.add_feature('G = God', 'toggle', Script.Parent['Player Bar Tags'], function(f)
        settings['Player Bar G'] = {Enabled = f.on}
    end)

    Script.Feature['Player Bar T'] = menu.add_feature('T = Typing', 'toggle', Script.Parent['Player Bar Tags'], function(f)
        if hooks.typingplayers2 == nil then
            hooks.typingplayers2 = hook.register_script_event_hook(function(source, target, params, count)
                local Name = get.Name(source)
                if params[1] == scriptevent['Typing Begin'] then
                    for i = 1, #TypingPlayers2 do
                        if TypingPlayers2[i] == Name then
                            return
                        end
                    end

                    TypingPlayers2[#TypingPlayers2 + 1] = Name

                    menu.create_thread(function(ID)
                        local Name = get.Name(ID)
                        local Time = utils.time_ms() + 10000

                        while Time > utils.time_ms() and player.is_player_valid(ID) do
                            coroutine.yield(100)
                        end

                        for i = 1, #TypingPlayers2 do
                            if TypingPlayers2[i] == Name then
                                TypingPlayers2[i] = nil
                            end
                        end
                    end, source)
                    
                elseif params[1] == scriptevent['Typing Stop'] then
                    for i = 1, #TypingPlayers2 do
                        if TypingPlayers2[i] == Name then
                            TypingPlayers2[i] = nil
                        end
                    end
                    
                end
                
            end)
        else
            hook.remove_script_event_hook(hooks.typingplayers2)
            hooks.typingplayers2 = nil
        end
        settings['Player Bar T'] = {Enabled = f.on}
    end)


    Script.Parent['Player Bar Settings'] = menu.add_feature('Settings', 'parent', Script.Parent['Player Bar'], nil).id

    Script.Feature['Player Bar Background'] = menu.add_feature('Background Opacity', 'value_i', Script.Parent['Player Bar Settings'], function(f)
        settings['Player Bar Background'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Player Bar Background'].min = 5
    Script.Feature['Player Bar Background'].max = 255
    Script.Feature['Player Bar Background'].mod = 5
    Script.Feature['Player Bar Background'].value = 120

    Script.Feature['Player Bar Text Allign'] = menu.add_feature('Text Allign', 'autoaction_value_str', Script.Parent['Player Bar Settings'], function(f)
        settings['Player Bar Text Allign'] = {Value = f.value}
    end)
    Script.Feature['Player Bar Text Allign']:set_str_data({'Left', 'Center'})

    Script.Feature['Player Bar Text Red'] = menu.add_feature('Text Color Red', 'autoaction_value_i', Script.Parent['Player Bar Settings'], function(f)
        settings['Player Bar Text Red'] = {Value = f.value}
    end)
    Script.Feature['Player Bar Text Red'].min = 0
    Script.Feature['Player Bar Text Red'].max = 255
    Script.Feature['Player Bar Text Red'].mod = 5
    Script.Feature['Player Bar Text Red'].value = 255

    Script.Feature['Player Bar Text Blue'] = menu.add_feature('Text Color Blue', 'autoaction_value_i', Script.Parent['Player Bar Settings'], function(f)
        settings['Player Bar Text Blue'] = {Value = f.value}
    end)
    Script.Feature['Player Bar Text Blue'].min = 0
    Script.Feature['Player Bar Text Blue'].max = 255
    Script.Feature['Player Bar Text Blue'].mod = 5
    Script.Feature['Player Bar Text Blue'].value = 255

    Script.Feature['Player Bar Text Green'] = menu.add_feature('Text Color Green', 'autoaction_value_i', Script.Parent['Player Bar Settings'], function(f)
        settings['Player Bar Text Green'] = {Value = f.value}
    end)
    Script.Feature['Player Bar Text Green'].min = 0
    Script.Feature['Player Bar Text Green'].max = 255
    Script.Feature['Player Bar Text Green'].mod = 5
    Script.Feature['Player Bar Text Green'].value = 255

    Script.Feature['Player Bar Players'] = menu.add_feature('Display Players', 'toggle', Script.Parent['Player Bar'], function(f)
        settings['Player Bar Players'] = {Enabled = f.on}
    end)
    Script.Feature['Player Bar Current Time'] = menu.add_feature('Display Current Time', 'toggle', Script.Parent['Player Bar'], function(f)
        settings['Player Bar Current Time'] = {Enabled = f.on}
    end)

    Script.Feature['Player Bar Script Version'] = menu.add_feature('Display Script Version', 'toggle', Script.Parent['Player Bar'], function(f)
        settings['Player Bar Script Version'] = {Enabled = f.on}
    end)


    Script.Parent['Player Bar v2'] = menu.add_feature('Player Bar v2', 'parent', Script.Parent['Lobby Miscellaneous'], nil).id

    Script.Feature['Enable Player Bar v2'] = menu.add_feature('Enable', 'value_str', Script.Parent['Player Bar v2'], function(f)
        Script.Feature['Enable Player Bar'].on = false
        settings['Enable Player Bar v2'] = {Enabled = f.on, Value = f.value}

        menu.create_thread(function()
            if hooks.typingplayers == nil then
                hooks.typingplayers = hook.register_script_event_hook(function(source, target, params, count)
                    local Name = get.Name(source)
                    if params[1] == scriptevent['Typing Begin'] then
                        for i = 1, #TypingPlayers1 do
                            if TypingPlayers1[i] == Name then
                                return
                            end
                        end
    
                        TypingPlayers1[#TypingPlayers1 + 1] = Name
    
                        menu.create_thread(function(ID)
                            local Name = get.Name(ID)
                            local Time = utils.time_ms() + 10000
    
                            while Time > utils.time_ms() and player.is_player_valid(ID) do
                                coroutine.yield(100)
                            end
    
                            for i = 1, #TypingPlayers1 do
                                if TypingPlayers1[i] == Name then
                                    TypingPlayers1[i] = nil
                                end
                            end
                        end, source)
                        
                    elseif params[1] == scriptevent['Typing Stop'] then
                        for i = 1, #TypingPlayers1 do
                            if TypingPlayers1[i] == Name then
                                TypingPlayers1[i] = nil
                            end
                        end
                        
                    end
                    
                end)
            else
                hook.remove_script_event_hook(hooks.typingplayers)
                hooks.typingplayers = nil
            end
        end, nil)

        while f.on do
            if Playercount() < 16 and f.value == 0 then
                scriptdraw.draw_rect(v2(1, 1), v2(5, 0.075), Math.RGBAToInt(10, 10, 10, 220))
                scriptdraw.draw_text(Math.TimePrefix(), v2(-0.5, 0.955), v2(1, 1), 0.5, Math.RGBAToInt(255, 255, 255, 255), TextFlags["CENTER"], 8)
            else
                scriptdraw.draw_rect(v2(1, 1), v2(5, 0.15), Math.RGBAToInt(10, 10, 10, 220))
                scriptdraw.draw_text(Math.TimePrefix(), v2(-0.5, 0.922), v2(1, 1), 0.5, Math.RGBAToInt(255, 255, 255, 255), TextFlags["CENTER"], 8)
            end

            local pos = v2(-0.99, 0.992)
            local done = 0

            for i = 0, 31 do
                if player.is_player_valid(i) then
                    local Name = get.Name(i)
                    
                    local isTyping
                    for i = 1, #TypingPlayers1 do
                        if TypingPlayers1[i] == Name then
                            isTyping = true
                        end
                    end

                    if i == player.player_id() or player.is_player_friend(i) then
                        color = Math.RGBAToInt(106, 82, 182, 255)
                    elseif player.is_player_modder(i, -1) then
                        color = Math.RGBAToInt(189, 43, 43, 255)
                    elseif player.get_player_health(i) == 0 or not player.is_player_playing(i) then
                        color = Math.RGBAToInt(128, 128, 128, 255)
                    elseif isTyping then
                        color = Math.RGBAToInt(183, 152, 61, 255)
                    else
                        color = Math.RGBAToInt(255, 255, 255, 255)
                    end

                    scriptdraw.draw_text(Name, pos, v2(1, 1), 0.5, color, TextFlags["SHADOW"], 8)
                    if player.is_player_host(i) then
                        scriptdraw.draw_text(Name, pos + v2(-0.001, 0.001), v2(1, 1), 0.5, color, TextFlags["SHADOW"], 8)
                    end
                    
                end
                if player.is_player_valid(i) or f.value ~= 0 then
                    pos.x = pos.x + 0.122
                    done = done + 1
                    if done == 16 then
                        pos.x = -0.99
                        pos.y = 0.962
                    end
                end
            end

            settings['Enable Player Bar v2'].Value = f.value
            coroutine.yield(0)
        end

        settings['Enable Player Bar v2'].Enabled = f.on
    end)
    Script.Feature['Enable Player Bar v2']:set_str_data({'Dynamic', 'Static'})

    Script.Parent['Player Bar v2 Tags'] = menu.add_feature('Player Colors', 'parent', Script.Parent['Player Bar v2'], nil).id

    Script.Feature['Player Bar White'] = menu.add_feature('White = Regular Player', 'action', Script.Parent['Player Bar v2 Tags'])
    Script.Feature['Player Bar Thick '] = menu.add_feature('Thick = Session Host', 'action', Script.Parent['Player Bar v2 Tags'])
    Script.Feature['Player Bar Gray'] = menu.add_feature('Gray = Dead/Inactive', 'action', Script.Parent['Player Bar v2 Tags'])
    Script.Feature['Player Bar Purple'] = menu.add_feature('Purple = Yourself & Friends', 'action', Script.Parent['Player Bar v2 Tags'])
    Script.Feature['Player Bar Yellow'] = menu.add_feature('Yellow = Typing/Talking', 'action', Script.Parent['Player Bar v2 Tags'])
    Script.Feature['Player Bar Red'] = menu.add_feature('Red = Modder', 'action', Script.Parent['Player Bar v2 Tags'])



    Script.Parent['Lobby Custom SE'] = menu.add_feature('Custom Script Events', 'parent', Script.Parent['Lobby Miscellaneous'], nil).id

    Script.Feature['Lobby Custom SE Input'] = menu.add_feature('Send Script Event: Input', 'action', Script.Parent['Lobby Custom SE'], function(f)
        local params = {}
        local _input

        local customevent = get.Input('Enter Custom Script Event (DEC)', 32, 3)
        if not customevent then
            Notify('Input canceled.', "Error", '')
            return
        end

        while _input ~= '#' do
            _input = get.Input('Enter Parameter (DEC), to EXIT and send, enter #', 32, 0)
            if not _input then
                return
            end

            if _input == '#' then
                break
            end

            _input = tonumber(_input)

            if type(_input) == 'number' then
                params[#params + 1] = _input
            else
                return
            end
        end

        for id = 0, 31 do
            scriptevent.Send(customevent, params, id, true)
        end

        Notify('Sent Custom Script Event to Players.', "Success")
    end)

    for i = 1, #customData.custom_script_events do
        menu.add_feature(customData.custom_script_events[i].Name, 'action', Script.Parent['Lobby Custom SE'], function()
            Notify('Sent Custom Script Event to Players.', "Success")
            for y = 0, 31 do
                for x = 1, #customData.custom_script_events[i].Events do
                    scriptevent.Send(customData.custom_script_events[i].Events[x].Hash, customData.custom_script_events[i].Events[x].Args, y, true)
                end
            end
        end)
    end

    Script.Feature['Laser Beam Waypoint'] = menu.add_feature('Laser Beam Explode Waypoint', 'action', Script.Parent['Lobby Miscellaneous'], function()
        local wp = ui.get_waypoint_coord()
        if wp.x == 16000 then
            Notify('No Waypoint found!', "Error", '')
            return
        end

        local maxz = get.OwnCoords().z + 175

        for i = maxz, -50, -2 do
            local pos = v3(wp.x, wp.y, i)
            pos.x = math.floor(pos.x)
            pos.y = math.floor(pos.y)

            fire.add_explosion(pos, 59, true, false, 0, 0)

            for x = 1, 2 do
                pos.x = math.random(pos.x - 3, pos.x + 3)
                pos.y = math.random(pos.y - 3, pos.y + 3)
                fire.add_explosion(pos, 59, true, false, 0, 0)
            end

            pos.x = math.random(pos.x - 6, pos.x + 6)
            pos.y = math.random(pos.y - 6, pos.y + 6)

            fire.add_explosion(pos, 8, true, false, 0, 0)

            coroutine.yield(0)
        end
    end)

    Script.Feature['Lobby Shake Cam'] = menu.add_feature('Shake Cam', 'toggle', Script.Parent['Lobby Miscellaneous'], function(f)
        while f.on do
            local pos = v3()

            for i = 1, 10 do
                pos.x = math.random(-2700, 2700)
                pos.y = math.random(-3300, 7500)
                pos.z = Math.GetGroundZ(pos.x, pos.y) + math.random(30, 90)

                fire.add_explosion(pos, 8, false, true, 20, 0)

            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Notify Spectating Players'] = menu.add_feature('Notify Spectating Players', 'toggle', Script.Parent['Lobby Miscellaneous'], function(f)
        settings['Notify Spectating Players'] = {Enabled = f.on}
        local running = {}

        while f.on do
            for id = 0, 31 do
                if player.is_player_valid(id) and not id == player.player_id() and network.get_player_player_is_spectating(id) ~= nil then
                    if not running[id] or menu.has_thread_finished(running[id]) then
                        running[id] = menu.create_thread(function(source)
                            local spectating = network.get_player_player_is_spectating(source)
                            local name = get.Name(source)
    
                            Notify(name .. ' started spectating ' .. get.Name(spectating), "Neutral", '')
    
                            while player.is_player_valid(source) and network.get_player_player_is_spectating(source) ~= nil do
                                coroutine.yield(0)
                            end
    
                            Notify(name .. ' stopped spectating ' .. get.Name(spectating), "Neutral", '')
                        end, id) 

                    end
                    
                end

            end

            coroutine.yield(0)
        end
        settings['Notify Spectating Players'].Enabled = f.on
    end)

    Script.Feature['Notify Script-Host Migrations'] = menu.add_feature('Notify Script Host Migrations', 'toggle', Script.Parent['Lobby Miscellaneous'], function(f)
        settings['Notify Script-Host Migrations'] = {Enabled = f.on}
        while f.on do
            local scripthost = script.get_host_of_this_script()
            local name = get.Name(scripthost)
            local extracheck = name

            while scripthost == script.get_host_of_this_script() do
                coroutine.yield(500)
            end

            local newhost = script.get_host_of_this_script()
            local newname = get.Name(newhost)
            
            while newname == 'Invalid Player' do
                newname = get.Name(script.get_host_of_this_script())
                coroutine.yield(0)
            end

            if newname == extracheck then
                return
            end

            if name == 'Invalid Player' then
                Log('Script Host migrated to ' .. newname)
                Notify('Script Host migrated to ' .. newname, "Neutral", '')
            else
                Log('Script Host migrated from ' .. name .. ' to ' .. newname .. '.')
                Notify('Script Host migrated from ' .. name .. ' to ' .. newname .. '.', "Neutral", '')
            end

            coroutine.yield(0)
        end
        settings['Notify Script-Host Migrations'].Enabled = f.on
    end)

    Script.Feature['Notify Host Migrations'] = menu.add_feature('Notify Session Host Migrations', 'toggle', Script.Parent['Lobby Miscellaneous'], function(f)
        settings['Notify Host Migrations'] = {Enabled = f.on}
        while f.on do
            local scripthost = player.get_host()
            local name = get.Name(scripthost)
            local extracheck = name

            while scripthost == player.get_host() do
                coroutine.yield(500)
            end

            local newhost = player.get_host()
            local newname = get.Name(newhost)
            
            while newname == 'Invalid Player' do
                newname = get.Name(player.get_host())
                coroutine.yield(0)
            end

            if newname == extracheck then
                return
            end

            if name == 'Invalid Player' then
                Log('Session Host migrated to ' .. newname)
                Notify('Session Host migrated to ' .. newname, "Neutral", '')
            else
                Log('Session Host migrated from ' .. name .. ' to ' .. newname .. '.')
                Notify('Session Host migrated from ' .. name .. ' to ' .. newname .. '.', "Neutral", '')
            end
            
            coroutine.yield(0)
        end
        settings['Notify Host Migrations'].Enabled = f.on
    end)


    Script.Parent['Lobby Malicious'] = menu.add_feature('Malicious', 'parent', Script.Parent['local_lobby'], nil).id

    Script.Feature['Force Host'] = menu.add_feature('Force Host', 'value_str', Script.Parent['Lobby Malicious'], function(f)
        if network.network_is_host() then
            Notify('You are already Session Host!', "Error", '')
            f.on = false
            return
        end

        while f.on do
            local host = player.get_host()
            if host == player.player_id() then
                Notify('You are now Session Host!\nTurning off Feature...', "Success", '2Take1Script Force Host')
                f.on = false
                return

            elseif player.is_player_friend(host) and Script.Feature['Exclude Friends'].on then
                Notify('One of your Friends is Session Host!\nTurning off Feature...', "Success", '2Take1Script Force Host')
                f.on = false
                return

            else
                if f.value == 0 then
                    kick_player(host)
                else
                    network.force_remove_player(host)
                end
            end

            coroutine.yield(0)
        end
    end)
    Script.Feature['Force Host']:set_str_data({'Script Kick', 'Desync Kick'})

    Script.Feature['Kick Random Player'] = menu.add_feature('Kick Random Player', 'action_value_str', Script.Parent['Lobby Malicious'], function(f)
        local valid_players = 0
        local kicked = false

        for id = 0, 31 do
            if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                valid_players = valid_players + 1
            end
        end

        if valid_players == 0 then
            Notify('No valid Players found.', "Error", '')
            return
        end

        while not kicked do
            local playerid = math.random(0, 31)

            if utility.valid_player(playerid, Script.Feature['Exclude Friends'].on) then
                Notify(get.Name(playerid) .. ' has been chosen as random player and got kicked.', "Success")

                if f.value == 0 then
                    kick_player(playerid)
                else
                    network.force_remove_player(playerid)
                end

                kicked = true
            end

            coroutine.yield(0)
        end
    end)
    Script.Feature['Kick Random Player']:set_str_data({'Script Kick', 'Desync Kick'})

    Script.Feature['Lobby Host Kick'] = menu.add_feature('Host Kick', 'action', Script.Parent['Lobby Malicious'], function()
        if not network.network_is_host() then
            Notify('You are not Session Host!', "Error", '')
            return
        end

        for id = 0, 31 do
            if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                network.network_session_kick_player(id)
            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Lobby Desync Kick'] = menu.add_feature('Desync Kick', 'action', Script.Parent['Lobby Malicious'], function()
        for id = 0, 31 do
            if utility.valid_player(id, Script.Feature['Exclude Friends'].on) then
                network.force_remove_player(id)
            end
            
            coroutine.yield(0)
        end
    end)

    Script.Feature['Lobby Script Event Kick'] = menu.add_feature('Script Event Kick', 'action_value_str', Script.Parent['Lobby Malicious'], function(f)
        for id = 0, 31 do
            scriptevent.kick(id, f.value + 1, true)
            coroutine.yield(0)
        end
    end)
    Script.Feature['Lobby Script Event Kick']:set_str_data({'Normal', 'Netbail', 'Invalid Apartment Invite'})

    Script.Feature['Lobby Script Host Curse'] = menu.add_feature('Script Host Curse', 'action_value_str', Script.Parent['Lobby Malicious'], function(f)
        if script.get_host_of_this_script() == player.player_id() then
            Notify('This doesnt work while you are Script Host!', "Error", '')
            return
        end

        scriptevent.curse(f.value + 1)
    end)
    Script.Feature['Lobby Script Host Curse']:set_str_data({'v1', 'v2', 'v3'})

    Script.Feature['Lobby Script Event Crash'] = menu.add_feature('Script Event Crash', 'action', Script.Parent['Lobby Malicious'], function(f)
        for id = 0, 31 do
            scriptevent.crash(id, true)
            coroutine.yield(0)
        end
    end)

    Script.Feature['Lobby Net Event Crash'] = menu.add_feature('Net Event Crash', 'action', Script.Parent['Lobby Malicious'], function(f)
        local sounds = {
            {Name = 'ROUND_ENDING_STINGER_CUSTOM', Ref = 'CELEBRATION_SOUNDSET'},
            {Name = 'Object_Dropped_Remote', Ref = 'GTAO_FM_Events_Soundset'},
            {Name = 'Oneshot_Final', Ref = 'MP_MISSION_COUNTDOWN_SOUNDSET'},
            {Name = '5s', Ref = 'MP_MISSION_COUNTDOWN_SOUNDSET'}
        }

        local sound = sounds[math.random(#sounds)]

        local time = utils.time_ms() + 2000

        while time > utils.time_ms() do
            local pos = player.get_player_coords(player.player_id())

            for i = 1, 10 do
                audio.play_sound_from_coord(-1, sound.Name, pos, sound.Ref, true, 50000, false)
            end
            
            coroutine.yield(0)
        end
    end)

    Script.Feature['Model Change Crash'] = menu.add_feature('Model Change Crash', 'action_value_str', Script.Parent['Lobby Malicious'], function(f)
        local pos = get.OwnCoords()
        hash_c = entity.get_entity_model_hash(get.OwnPed())

        local hash1 = 2627665880
        local hash2 = 1885233650
        if player.is_player_female(player.player_id()) then
            local hashswap = hash1
            hash1 = hash2
            hash2 = hashswap
        end
    
        for i = 1, 11 do
            outfits['session_crash']['textures'][i] = ped.get_ped_texture_variation(get.OwnPed(), i)
            outfits['session_crash']['clothes'][i] = ped.get_ped_drawable_variation(get.OwnPed(), i)
        end
        local loop = {0, 1, 2, 6, 7}
        for z = 1, #loop do
            outfits['session_crash']['prop_ind'][z] = ped.get_ped_prop_index(get.OwnPed(), loop[z])
            outfits['session_crash']['prop_text'][z] = ped.get_ped_prop_texture_index(get.OwnPed(), loop[z])
        end

        if f.value == 0 then
            change_model(0x471BE4B2, nil, nil, nil)
            coroutine.yield(5000)
        elseif f.value == 1 then
            for i = 1, 32 do
                entity.set_entity_coords_no_offset(get.OwnPed(), v3(460.586, 5571.714, 781.179))

                change_model(hash1, nil, nil, nil)
            
                coroutine.yield(100)
                ped.set_ped_health(get.OwnPed(), 0)
                coroutine.yield(100)
                ped.resurrect_ped(get.OwnPed())
                coroutine.yield(300)
            
                change_model(hash2, nil, nil, nil)
            
                coroutine.yield(100)
                ped.set_ped_health(get.OwnPed(), 0)
                coroutine.yield(200)
                ped.resurrect_ped(get.OwnPed())
            end
        elseif f.value == 2 then
            local player_ped = get.OwnPed()
            for i = 1, 15 do
                entity.set_entity_coords_no_offset(get.OwnPed(), v3(-76.101, -819.124, 326.175))

                change_model(hash1, nil, nil, nil)
            
                coroutine.yield(100)
                ped.set_ped_health(get.OwnPed(), 0)
                coroutine.yield(100)
                ped.resurrect_ped(get.OwnPed())
                coroutine.yield(300)
            
                change_model(hash2, nil, nil, nil)
            
                coroutine.yield(100)
                ped.set_ped_health(get.OwnPed(), 0)
                coroutine.yield(200)
                ped.resurrect_ped(get.OwnPed())
            end
            ped.clone_ped(player_ped)
        else
            if network.network_is_host() then
                Notify('This cannot be used while you are Session Host!', "Error", '')
                return
            end

            for i = 1, 20 do
                utility.tp(v3(-6170,10837,40))

                change_model(hash1, nil, nil, nil)

                coroutine.yield(10)
                ped.set_ped_health(get.OwnPed(), 0)
                coroutine.yield(10)
                ped.resurrect_ped(get.OwnPed())
                coroutine.yield(30)

                change_model(hash2, nil, nil, nil)

                coroutine.yield(10)
                ped.set_ped_health(get.OwnPed(), 0)
                coroutine.yield(10)
                ped.resurrect_ped(get.OwnPed())
                coroutine.yield(30)
            end
            utility.tp(pos)
        end
    
        fix_crash_screen()
        utility.tp(pos)
        coroutine.yield(500)
        Notify('Crash Complete!', "Success")
    end)
    Script.Feature['Model Change Crash']:set_str_data({'v1', 'v2', 'v3', 'v4'})

    Script.Feature['Fix Crash Screen'] = menu.add_feature('Fix loading screen after Crash', 'action', Script.Parent['Lobby Malicious'], fix_crash_screen)


    Script.Parent['Auto Kick Modder'] = menu.add_feature('Auto Kick Modder', 'parent', Script.Parent['local_automod'], nil).id

    Script.Feature['Enable Auto Kick Modder'] = menu.add_feature('Enable Auto Kick', 'value_str', Script.Parent['Auto Kick Modder'], function(f)
        settings['Enable Auto Kick Modder'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Enable Auto Kick Modder']:set_str_data({'All Players', 'Exclude Friends'})

    local flagcheck = 1
    while flagcheck < player.get_modder_flag_ends() do
        local name = player.get_modder_flag_text(flagcheck)

        Script.Feature['Autokick ' .. name] = menu.add_feature(name, 'value_str', Script.Parent['Auto Kick Modder'], function(f)
            settings['Autokick ' .. name] = {Enabled = f.on, Value = f.value}

        end)
        Script.Feature['Autokick ' .. name]:set_str_data({'Kick', 'Kick & Blacklist'})

        flagcheck = flagcheck << 1
    end


    Script.Parent['Player Blacklist'] = menu.add_feature('Player Blacklist', 'parent', Script.Parent['local_automod'], nil).id

    Script.Feature['Enable Player Blacklist'] = menu.add_feature('Enable Blacklist', 'toggle', Script.Parent['Player Blacklist'], function(f)
        settings['Enable Player Blacklist'] = {Enabled = f.on}
    end)

    Script.Feature['Player Blacklist Kick Type'] = menu.add_feature('Kick Type', 'autoaction_value_str', Script.Parent['Player Blacklist'], function(f)
        settings['Player Blacklist Kick Type'] = {Value = f.value}
    end)
    Script.Feature['Player Blacklist Kick Type']:set_str_data({'Script Kick', 'Desync Kick'})

    Script.Parent['Player Blacklist Detections'] = menu.add_feature('Detection Requirements', 'parent', Script.Parent['Player Blacklist'], nil).id

    Script.Feature['Detection Requirement Name'] = menu.add_feature('Matching Name', 'toggle', Script.Parent['Player Blacklist Detections'], function(f)
        settings['Detection Requirement Name'] = {Enabled = f.on}
    end)

    Script.Feature['Detection Requirement SCID'] = menu.add_feature('Matching SCID', 'toggle', Script.Parent['Player Blacklist Detections'], function(f)
        settings['Detection Requirement SCID'] = {Enabled = f.on}
    end)

    Script.Feature['Detection Requirement IP'] = menu.add_feature('Matching IP', 'toggle', Script.Parent['Player Blacklist Detections'], function(f)
        settings['Detection Requirement IP'] = {Enabled = f.on}
    end)

    Script.Parent['Player Blacklist Profiles'] = menu.add_feature('Blacklist Profiles', 'parent', Script.Parent['Player Blacklist'], nil).id

    Script.Feature['Blacklist Profiles Add'] = menu.add_feature('Add Profile', 'action', Script.Parent['Player Blacklist Profiles'], function()
        local _input1 = get.Input('Enter Player Name', 16)
        if not _input1 then
            Notify('Input canceled.', "Error", '')
            return
        end

        local _input2 = tonumber(get.Input('Enter Player SCID', 10, 3))
        if not _input2 then
            Notify('Input canceled.', "Error", '')
            return
        end

        local _input3 = get.Input('Enter Player IP', 15, 4)
        if not _input3 then
            Notify('Input canceled.', "Error", '')
            return
        end

        local blacklist = {}

        if not utils.file_exists(files['Blacklist']) then
            goto continue
        end
        
        for line in io.lines(files['Blacklist']) do
            blacklist[line] = true
        end
        if blacklist[_input1 .. ':' .. _input2 .. ':' .. _input3] then
            Notify('Player already exists in the blacklist', "Error", '')
            return
        end

        ::continue::
        utility.write(io.open(files['Blacklist'], 'a'), _input1 .. ':' .. _input2 .. ':' .. _input3)

        Script.Feature[_input1 .. '/' .. _input2] = menu.add_feature(_input1, 'action_value_str',  Script.Parent['Player Blacklist Profiles'], function(f)
            if f.value == 0 then
                Notify('Name: ' .. _input1 .. '\nSCID: ' .. _input2 .. '\nIP: ' .. _input3, "Success", '2Take1Script Player Blacklist')
            else
                blacklist[_input1 .. ':' .. _input2 .. ':' .. _input3] = nil

                utility.write(io.open(files['Blacklist'], 'w'))
                for k in pairs(blacklist) do
                    utility.write(io.open(files['Blacklist'], 'a'), k)
                end
                menu.delete_feature(f.id)
                Notify('Entry Deleted', "Success", '2Take1Script Player Blacklist')
            end
        end)
        Script.Feature[_input1 .. '/' .. _input2]:set_str_data({'Show Info', 'Delete'})
    
        Notify('New Blacklist Entry\nName: ' .. _input1 .. '\nSCID: ' .. _input2 .. '\nIP: ' .. _input3, "Success", '2Take1Script Player Blacklist')
    end)

    if utils.file_exists(files['Blacklist']) then
        menu.create_thread(function()
            local done = 0
            for line in io.lines(files['Blacklist']) do

                local parts = {}
                for part in line:gmatch("[^:]+") do
                    parts[#parts + 1] = part
                end

                if #parts == 3 then
                    local name = parts[1]
                    local scid = parts[2]
                    local ip = parts[3]
    
                    Script.Feature[name .. '/' .. scid] = menu.add_feature(name, 'action_value_str',  Script.Parent['Player Blacklist Profiles'], function(f)
                        if f.value == 0 then
                            Notify('Name: ' .. name .. '\nSCID: ' .. scid .. '\nIP: ' .. ip, "Success", '2Take1Script Player Blacklist')
                        else
                            local blacklist = {}
                            for line2 in io.lines(files['Blacklist']) do
                                blacklist[line2] = true
                            end
                            blacklist[name .. ':' .. scid .. ':' .. ip] = nil
                
                            utility.write(io.open(files['Blacklist'], 'w'))
                            for k in pairs(blacklist) do
                                utility.write(io.open(files['Blacklist'], 'a'), k)
                            end
                            menu.delete_feature(f.id)
                            Notify('Entry Deleted', "Success", '2Take1Script Player Blacklist')
                        end
                    end)
                    Script.Feature[name .. '/' .. scid]:set_str_data({'Show Info', 'Delete'})
                end

                done = done + 1
                if done == 50 then
                    done = 0
                    coroutine.yield(0)
                end
            end
        end, nil)
    end
    

    Script.Parent['Anti Advertisement Tool'] = menu.add_feature('Anti Advertisement Tool', 'parent', Script.Parent['local_automod'], nil).id

    Script.Feature['Ad Blacklist Name Strings'] = menu.add_feature('Name String Blacklist', 'value_str', Script.Parent['Anti Advertisement Tool'], function(f)
        settings['Ad Blacklist Name Strings'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Ad Blacklist Name Strings']:set_str_data({'Safe', 'Aggressive'})

    Script.Feature['Ad Blacklist Chat Strings'] = menu.add_feature('Chat String Blacklist', 'value_str', Script.Parent['Anti Advertisement Tool'], function(f)
        settings['Ad Blacklist Chat Strings'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Ad Blacklist Chat Strings']:set_str_data({'Safe', 'Aggressive'})

    Script.Feature['Ad Blacklist Fake Friends'] = menu.add_feature('Add to Fake Friends Blacklist', 'toggle', Script.Parent['Anti Advertisement Tool'], function(f)
        settings['Ad Blacklist Fake Friends'] = {Enabled = f.on}
    end)

    Script.Feature['Ad Blacklist Disable Notifications'] = menu.add_feature('Disable Notifications', 'toggle', Script.Parent['Anti Advertisement Tool'], function(f)
        settings['Ad Blacklist Disable Notifications'] = {Enabled = f.on}
    end)

    Script.Feature['Ad Blacklist Kick Type'] = menu.add_feature('Kick Type', 'autoaction_value_str', Script.Parent['Anti Advertisement Tool'], function(f)
        settings['Ad Blacklist Kick Type'] = {Value = f.value}
    end)
    Script.Feature['Ad Blacklist Kick Type']:set_str_data({'Script Kick', 'Desync Kick'})


    Script.Parent['Vehicle Blacklist'] = menu.add_feature('Vehicle Blacklist', 'parent', Script.Parent['local_automod'], nil).id

    Script.Feature['Enable Vehicle Blacklist'] = menu.add_feature('Enable Blacklist', 'value_str', Script.Parent['Vehicle Blacklist'], function(f)
        settings['Enable Vehicle Blacklist'] = {Enabled = f.on, Value = f.value}
        local detected = {}
        while f.on do

            local exclude
            if f.value == 0 then
                exclude = false
            else
                exclude = true
            end

            for id = 0, 31 do
                if utility.valid_player(id, exclude) and detected[id] ~= true then
                    detected[id] = true
                    menu.create_thread(function(target)
                        local veh = get.PlayerVehicle(target)
                        if veh ~= 0 then
                            local guilty = false
                            local detected_veh
                            local model = entity.get_entity_model_hash(veh)
                            local checkset

                            if streaming.is_model_a_car(model) or streaming.is_model_a_bike(model) then
                                checkset = customData.vehicle_blacklist[1].Children
                            elseif streaming.is_model_a_plane(model) or streaming.is_model_a_heli(model) then
                                checkset = customData.vehicle_blacklist[2].Children
                            else
                                checkset = customData.vehicle_blacklist[3].Children
                            end

                            for i = 1, #checkset do
                                if Script.Feature['VB ' .. checkset[i].Name].on and model == checkset[i].Hash then
                                    guilty = true
                                    detected_veh = checkset[i].Name
                                end
                            end

                            if guilty then
                                Log('Player: ' .. get.Name(target) .. '\nVehicle: ' .. detected_veh, '[Vehicle Blacklist]')
                                if Script.Feature['Vehicle Blacklist Reaction'].value == 0 then
                                    Notify('Player: ' .. get.Name(target) .. '\nVehicle: ' .. detected_veh .. '\nReaction: Delete', "Neutral", '2Take1Script Vehicle Blacklist')
                                    utility.clear(get.PlayerVehicle(target))
                                    
                                elseif Script.Feature['Vehicle Blacklist Reaction'].value == 1 then
                                    Notify('Player: ' .. get.Name(target) .. '\nVehicle: ' .. detected_veh .. '\nReaction: Explode', "Neutral", '2Take1Script Vehicle Blacklist')
                                    veh = get.PlayerVehicle(target)
                                    utility.request_ctrl(veh, 100)
                                    entity.set_entity_god_mode(veh, false)
                                    entity.set_entity_velocity(veh, v3())
                                    fire.add_explosion(get.PlayerCoords(target), 59, false, true, 1, get.PlayerPed(target))
    
                                elseif Script.Feature['Vehicle Blacklist Reaction'].value == 2 then
                                    Notify('Player: ' .. get.Name(target) .. '\nVehicle: ' .. detected_veh .. '\nReaction: Vehicle Kick', "Neutral", '2Take1Script Vehicle Blacklist')
                                    scriptevent.Send('Destroy Personal Vehicle', {player.player_id(), id}, id)
                                    scriptevent.Send('Vehicle Kick', {player.player_id(), 4294967295, 4294967295, 4294967295}, id)
    
                                elseif Script.Feature['Vehicle Blacklist Reaction'].value == 3 then
                                    Notify('Player: ' .. get.Name(target) .. '\nVehicle: ' .. detected_veh .. '\nReaction: Script Kick', "Neutral", '2Take1Script Vehicle Blacklist')
                                    kick_player(target)

                                elseif Script.Feature['Vehicle Blacklist Reaction'].value == 4 then
                                    Notify('Player: ' .. get.Name(target) .. '\nVehicle: ' .. detected_veh .. '\nReaction: Desync Kick', "Neutral", '2Take1Script Vehicle Blacklist')
                                    network.force_remove_player(target)

                                elseif Script.Feature['Vehicle Blacklist Reaction'].value == 5 then
                                    Notify('Player: ' .. get.Name(target) .. '\nVehicle: ' .. detected_veh .. '\nReaction: Crash', "Neutral", '2Take1Script Vehicle Blacklist')
                                    scriptevent.crash(target)
                                end
                                coroutine.yield(10000)
                            end
                        end
                        detected[id] = nil
                    end, id)
                end
                coroutine.yield(0)
            end
            settings['Enable Vehicle Blacklist'].Value = f.value
            coroutine.yield(0)
        end
        settings['Enable Vehicle Blacklist'].Enabled = f.on
    end)
    Script.Feature['Enable Vehicle Blacklist']:set_str_data({'All Players', 'Exclude Friends'})

    Script.Feature['Vehicle Blacklist Reaction'] = menu.add_feature('Chosen Reaction', 'autoaction_value_str', Script.Parent['Vehicle Blacklist'], function(f)
        settings['Vehicle Blacklist Reaction'] = {Value = f.value}
    end)
    Script.Feature['Vehicle Blacklist Reaction']:set_str_data({'Delete Vehicle', 'Explode', 'Vehicle Kick', 'Script Kick', 'Desync Kick', 'Script Crash'})

    for i = 1, #customData.vehicle_blacklist do
        local parent = customData.vehicle_blacklist[i].Name
        Script.Parent['VB ' .. parent] = menu.add_feature(parent, 'parent', Script.Parent['Vehicle Blacklist'], nil).id

        for j = 1, #customData.vehicle_blacklist[i].Children do
            if streaming.is_model_a_vehicle(customData.vehicle_blacklist[i].Children[j].Hash) then
                local name = customData.vehicle_blacklist[i].Children[j].Name
                Script.Feature['VB ' .. name] = menu.add_feature(name, 'toggle', Script.Parent['VB ' .. parent], function(f)
                    settings['VB ' .. name] = {Enabled = f.on}

                end)
            else
                print('Vehicle Blacklist preset ' .. customData.vehicle_blacklist[i].Children[j].Name .. ' is invalid.')
            end
        end
    end


    Script.Feature['Anti Chat Spam'] =  menu.add_feature('Anti Chat Spam', 'value_str', Script.Parent['local_automod'], function(f)
        settings['Anti Chat Spam'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Anti Chat Spam']:set_str_data({'Script Kick', 'Desync Kick', 'Script Crash'})

    Script.Feature['Kick Vote-Kicker'] = menu.add_feature('Kick Vote-Kicker', 'value_str', Script.Parent['local_automod'], function(f)
        if hooks.votekick == nil then
            hooks.votekick = hook.register_net_event_hook(function(source, target, eventId)
                if utility.valid_player(source, Script.Feature['Exclude Friends'].on) and target == player.player_id() then
                    if eventId == 64 then
                        Log('Player: ' .. get.Name(source) .. '\nReason: Kick Votes\nReaction: Kick', '[Automod]')
                        if f.value == 0 then
                            Notify('Player: ' .. get.Name(source) .. '\nReason: Kick Votes\nReaction: Script Kick', "Neutral", '2Take1Script Automod')
                            kick_player(source)
                        elseif f.value == 1 then
                            Notify('Player: ' .. get.Name(source) .. '\nReason: Kick Votes\nReaction: Desync Kick', "Neutral", '2Take1Script Automod')
                            network.force_remove_player(source)
                        end
                    end
                end
            end)
        else
            hook.remove_net_event_hook(hooks.votekick)
            hooks.votekick = nil
        end
        settings['Kick Vote-Kicker'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Kick Vote-Kicker']:set_str_data({'Script Kick', 'Desync Kick'})

    Script.Feature['Kick SMS-Sender'] = menu.add_feature('Kick SMS-Sender', 'value_str', Script.Parent['local_automod'], function(f)
        if hooks.smskick == nil then
            hooks.smskick = hook.register_script_event_hook(function(source, target, params, count)
                if utility.valid_player(source, Script.Feature['Exclude Friends'].on) and target == player.player_id() then
                    if params[1] == scriptevent['SMS'] then
                        if f.value == 0 then
                            Notify('Player: ' .. get.Name(source) .. '\nReason: Sending SMS\nReaction: Script Kick', "Neutral", '2Take1Script Automod')
                            kick_player(source)
                        elseif f.value == 1 then
                            Notify('Player: ' .. get.Name(source) .. '\nReason: Sending SMS\nReaction: Desync Kick', "Neutral", '2Take1Script Automod')
                            network.force_remove_player(source)
                        end
                    end
                end
            end)
        else
            hook.remove_script_event_hook(hooks.smskick)
            hooks.smskick = nil
        end
        settings['Kick SMS-Sender'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Kick SMS-Sender']:set_str_data({'Script Kick', 'Desync Kick'})

    Script.Feature['GEO-Block Russia'] = menu.add_feature('Remove Russian Speakers', "value_str", Script.Parent['local_automod'], function(f)
        settings['GEO-Block Russia'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['GEO-Block Russia']:set_str_data({'Script Kick', 'Desync Kick', 'Script Crash'})

    Script.Feature['GEO-Block China'] = menu.add_feature('Remove Chinese Speakers', 'value_str', Script.Parent['local_automod'], function(f)
        settings['GEO-Block China'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['GEO-Block China']:set_str_data({'Script Kick', 'Desync Kick', 'Script Crash'})


    Script.Feature['Modder Detection Whitelist Friends'] = menu.add_feature('Whitelist Friends', 'toggle', Script.Parent['local_modderdetection'], function(f)
        settings['Modder Detection Whitelist Friends'] = {Enabled = f.on}
    end)

    Script.Parent['Remember Modder'] = menu.add_feature('Remember every Modder', 'parent', Script.Parent['local_modderdetection'], nil).id

    Script.Feature['Modder Detection Remember'] = menu.add_feature('Enable', 'toggle', Script.Parent['Remember Modder'], function(f)
        settings['Modder Detection Remember'] = {Enabled = f.on}
    end)

    Script.Parent['Remember Modder Profiles'] = menu.add_feature('Detected Modder', 'parent', Script.Parent['Remember Modder'], nil).id

    if utils.file_exists(files['Modder']) then
        menu.create_thread(function()
            local done = 0
            for line in io.lines(files['Modder']) do

                local parts = {}
                for part in line:gmatch("[^:]+") do
                    parts[#parts + 1] = part
                end

                if #parts == 3 then
                    local name = parts[1]
                    local scid = parts[2]
                    local reason = parts[3]
    
                    Script.Feature[name .. '/' .. reason] = menu.add_feature(name, 'action_value_str',  Script.Parent['Remember Modder Profiles'], function(f)
                        if f.value == 0 then
                            Notify('Name: ' .. name .. '\nSCID: ' .. scid .. '\nReason: ' .. reason, "Neutral", '2Take1Script Remember Modder')
                        elseif f.value == 1 then
                            local remembered = {}
                            for line2 in io.lines(files['Modder']) do
                                remembered[line2] = true
                            end
                            remembered[name .. ':' .. scid .. ':' .. reason] = nil
                
                            utility.write(io.open(files['Modder'], 'w'))
                            for k in pairs(remembered) do
                                utility.write(io.open(files['Modder'], 'a'), k)
                            end

                            menu.delete_feature(f.id)
                            Notify('Entry Deleted', "Success", '2Take1Script Remember Modder')
                        else
                            utils.to_clipboard(scid)
                            Notify('SCID copied to clipboard', "Success", '2Take1Script Remember Modder')
                        end
                    end)
                    Script.Feature[name .. '/' .. reason]:set_str_data({'Show Info', 'Delete', 'Copy SCID'})
                end

                done = done + 1
                if done == 50 then
                    done = 0
                    coroutine.yield(0)
                end
            end
        end, nil)
    end

    Script.Parent['Remember Modder Flag Selection'] = menu.add_feature('Flag Selection', 'parent', Script.Parent['Remember Modder'], nil).id

    flagcheck = 1
    while flagcheck < player.get_modder_flag_ends() do
        local name = player.get_modder_flag_text(flagcheck)

        if name ~= 'Remembered' then
            Script.Feature['Remember ' .. name] = menu.add_feature(name, 'toggle', Script.Parent['Remember Modder Flag Selection'], function(f)
                settings['Remember ' .. name] = {Enabled = f.on}
            end)
        end

        flagcheck = flagcheck << 1
    end

    Script.Feature['Modder Detection Mark All'] = menu.add_feature('Mark all as Modder', 'action', Script.Parent['local_modderdetection'], function()
        for id = 0, 31 do
            if utility.valid_modder(id, Script.Feature['Modder Detection Whitelist Friends'].on) then
                player.set_player_as_modder(id, 1)
            end
        end
    end)

    Script.Feature['Modder Detection Unmark All'] = menu.add_feature('Unmark all Modder', 'action', Script.Parent['local_modderdetection'], function()
        for id = 0, 31 do
            if utility.valid_player(id, false) then
                player.unset_player_as_modder(id, -1)
            end
        end
    end)

    Script.Feature['Modder Detection Health'] = menu.add_feature('Modded Health', 'toggle', Script.Parent['local_modderdetection'], function(f)
        settings['Modder Detection Health'] = {Enabled = f.on}
        while f.on do
            for id = 0, 31 do
                if utility.valid_modder(id, Script.Feature['Modder Detection Whitelist Friends'].on) then
                    coroutine.yield(1000)
                    local health = player.get_player_health(id)
                    local maxhealth = player.get_player_max_health(id)
                    if health > 328 or maxhealth > 328 then
                        Notify('Player: ' .. get.Name(id) .. '\nReason: Modded Health', "Neutral", '2Take1Script Modder Detection')
                        Log('Player: ' .. get.Name(id) .. '\nReason: Modded Health\nPlayer Health: ' .. health .. ' Max Health: ' .. maxhealth, '[Modder Detection]')
                        player.set_player_as_modder(id, customflags[2][2])
                    end
                end
            end
            coroutine.yield(500)
        end
        settings['Modder Detection Health'].Enabled = f.on
    end)

    Script.Feature['Modder Detection Armor'] = menu.add_feature('Modded Armor', 'toggle', Script.Parent['local_modderdetection'], function(f)
        settings['Modder Detection Armor'] = {Enabled = f.on}
        while f.on do
            for id = 0, 31 do
                coroutine.yield(25)
                if utility.valid_modder(id, Script.Feature['Modder Detection Whitelist Friends'].on) then
                    local armor = player.get_player_armour(id)
                    if armor > 50 then
                        Notify('Player: ' .. get.Name(id) .. '\nReason: Modded Armor', "Neutral", '2Take1Script Modder Detection')
                        Log('Player: ' .. get.Name(id) .. '\nReason: Modded Armor\nDetected Armor: ' .. armor, '[Modder Detection]')
                        player.set_player_as_modder(id, customflags[3][2])
                    end
                end
            end
            coroutine.yield(500)
        end
        settings['Modder Detection Armor'].Enabled = f.on
    end)

    Script.Feature['Modder Detection Player Godmode'] = menu.add_feature('Player Godmode', 'value_str', Script.Parent['local_modderdetection'], function(f)
        settings['Modder Detection Player Godmode'] = {Enabled = f.on, Value = f.value}
        local running = {}

        while f.on do
            for id = 0, 31 do
                if utility.valid_modder(id, Script.Feature['Modder Detection Whitelist Friends'].on) and get.GodmodeState(id) then
                    if not running[id] or menu.has_thread_finished(running[id]) then
                        running[id] = menu.create_thread(modderevents.godmode, id)

                    end

                end

            end

            settings['Modder Detection Player Godmode'].Value = f.value
            coroutine.yield(500)
        end
        settings['Modder Detection Player Godmode'].Enabled = f.on
    end)
    Script.Feature['Modder Detection Player Godmode']:set_str_data({'Notify', 'Notify & Mark'})

    Script.Feature['Modder Detection Vehicle Godmode'] = menu.add_feature('Vehicle Godmode', 'value_str', Script.Parent['local_modderdetection'], function(f)
        settings['Modder Detection Vehicle Godmode'] = {Enabled = f.on, Value = f.value}
        local running = {}

        while f.on do
            for id = 0, 31 do
                if utility.valid_modder(id, Script.Feature['Modder Detection Whitelist Friends'].on) and get.VehicleGodmodeState(id) then
                    if not running[id] or menu.has_thread_finished(running[id]) then
                        running[id] = menu.create_thread(modderevents.vehiclegodmode, id)

                    end

                end

            end

            settings['Modder Detection Vehicle Godmode'].Value = f.value
            coroutine.yield(500)
        end
        settings['Modder Detection Vehicle Godmode'].Enabled = f.on
    end)
    Script.Feature['Modder Detection Vehicle Godmode']:set_str_data({'Notify', 'Notify & Mark'})

    Script.Feature['Modder Detection Off The Radar'] = menu.add_feature('Modded Off The Radar', 'toggle', Script.Parent['local_modderdetection'], function(f)
        settings['Modder Detection Off The Radar'] = {Enabled = f.on}
        local detected = {}

        while f.on do
            for id = 0, 31 do
                if utility.valid_modder(id, Script.Feature['Modder Detection Whitelist Friends'].on) and detected[id] == nil then
                    if scriptevent.IsPlayerOTR(id) and not scriptevent.IsPlayerInOrg(id) then
                        detected[id] = true
                        menu.create_thread(function(target)
                            coroutine.yield(61000)
                            if utility.valid_modder(id, Script.Feature['Modder Detection Whitelist Friends'].on) and scriptevent.IsPlayerOTR(target) then
                                Notify('Player: ' .. get.Name(target) .. '\nReason: Extended Off The Radar', "Neutral", '2Take1Script Modder Detection')
                                Log('Player: ' .. get.Name(target) .. '\nReason: Extended Off The Radar', '[Modder Detection]')
                                player.set_player_as_modder(target, customflags[5][2])
                            end
                            detected[id] = nil
                        end, id)

                    elseif scriptevent.IsPlayerOTR(id) and scriptevent.IsPlayerInOrg(id) then
                        detected[id] = true
                        menu.create_thread(function(target)
                            coroutine.yield(181000)
                            if utility.valid_modder(id, Script.Feature['Modder Detection Whitelist Friends'].on) and scriptevent.IsPlayerOTR(target) then
                                Notify('Player: ' .. get.Name(target) .. '\nReason: Extended Off The Radar', "Neutral", '2Take1Script Modder Detection')
                                Log('Player: ' .. get.Name(target) .. '\nReason: Extended Off The Radar', '[Modder Detection]')
                                player.set_player_as_modder(target, customflags[5][2])
                            end
                            detected[id] = nil
                        end, id)

                    elseif player.get_player_max_health(id) <= 100 then
                        detected[id] = true
                        menu.create_thread(function(target)
                            coroutine.yield(60000)
                            local pos = get.PlayerCoords(target)
                            if utility.valid_modder(target, Script.Feature['Modder Detection Whitelist Friends'].on) and player.get_player_max_health(target) <= 100 and pos ~= v3(0, 0, 0) then
                                Notify('Player: ' .. get.Name(target) .. '\nReason: Undead Off The Radar', "Neutral", '2Take1Script Modder Detection')
                                Log('Player: ' .. get.Name(target) .. '\nReason: Undead Off The Radar', '[Modder Detection]')
                                player.set_player_as_modder(target, customflags[5][2])
                            end
                            detected[id] = nil
                        end, id)

                    end

                end

            end

            coroutine.yield(500)
        end
        settings['Modder Detection Off The Radar'].Enabled = f.on
    end)

    Script.Feature['Modder Detection Script Events'] = menu.add_feature('Modded Script Events', 'toggle', Script.Parent['local_modderdetection'], function(f)
        if hooks.modded_script == nil then
            hooks.modded_script = hook.register_script_event_hook(function(source, target, params, count)
                if utility.valid_modder(source, Script.Feature['Modder Detection Whitelist Friends'].on) and target == player.player_id() then
                    local guilty = false
                    if #params > 1 then
                        if source ~= params[2] then
                            guilty = true
                        end
                    else
                        guilty = true
                    end
                    if guilty then
                        local se = params[1] .. ', {'
                        for i = 2, #params do
                            se = se .. params[i]
                            if i ~= #params then
                                se = se .. ', '
                            end
                        end
                        se = se .. '}'
                        Notify('Player: ' .. get.Name(source) .. '\nReason: Modded Script Event', "Neutral", '2Take1Script Modder Detection')
                        Log('Player: ' .. get.Name(source) .. '\nReason: Modded Script Event\nDetected Script Event: ' .. se, '[Modder Detection]')
                        player.set_player_as_modder(source, customflags[6][2])
                    end
                end
            end)
        else
            hook.remove_script_event_hook(hooks.modded_script)
            hooks.modded_script = nil
        end
        settings['Modder Detection Script Events'] = {Enabled = f.on}
    end)

    Script.Feature['Modder Detection Max Speed'] = menu.add_feature('Max Speed Bypass', 'toggle', Script.Parent['local_modderdetection'], function(f)
        settings['Modder Detection Max Speed'] = {Enabled = f.on}
        while f.on do
            for id = 0, 31 do
                if utility.valid_modder(id, Script.Feature['Modder Detection Whitelist Friends'].on) and interior.get_interior_from_entity(get.PlayerPed(id)) == 0 then
                    local Entity
                    local MaxSpeed = 120
                    local Vehicle = get.PlayerVehicle(id)

                    if Vehicle ~= 0 then
                        Entity = Vehicle
                    else
                        Entity = get.PlayerPed(id)
                    end

                    local Speed = entity.get_entity_speed(Entity)

                    if Speed > MaxSpeed then
                        local name = get.Name(id)

                        Notify('Player: ' .. name .. '\nReason: Max Speed Bypass', "Neutral", '2Take1Script Modder Detection')
                        Log('Player: ' .. name .. '\nReason: Max Speed Bypass\nPlayer Speed: ' .. Speed * 3.6 .. 'Km/H', '[Modder Detection]')
                        player.set_player_as_modder(id, customflags[7][2])
                    end

                end

            end

            coroutine.yield(0)
        end
        settings['Modder Detection Max Speed'].Enabled = f.on
    end)

    
    Script.Feature['Real Time'] = menu.add_feature('Real Time (Clientside)', 'toggle', Script.Parent['local_world'], function(f)
        settings['Real Time'] = {Enabled = f.on}
        while f.on do
            local Time = os.date('*t')

            time.set_clock_time(Time.hour, Time.min, Time.sec)
            gameplay.clear_cloud_hat()

            coroutine.yield(0)
        end
        settings['Real Time'].Enabled = f.on
    end)


    Script.Parent['Kill Aura'] = menu.add_feature('Kill Aura/Force Field', 'parent', Script.Parent['local_world'], nil).id

    Script.Feature['Kill Aura Enable'] = menu.add_feature('Enable Kill Aura', 'value_str', Script.Parent['Kill Aura'], function(f)
        local running = {}
        local Done = 0

        while f.on do
            local Peds = ped.get_all_peds()
            for i = 1, #Peds do
                if (Peds[i] == get.OwnPed()) or (f.value == 1 and ped.is_ped_a_player(Peds[i])) or (f.value == 2 and not ped.is_ped_a_player(Peds[i])) then
                    goto continue
                end

                if not running[Peds[i]] or menu.has_thread_finished(running[Peds[i]]) then
                    running[Peds[i]] = menu.create_thread(Threads.Killaura, {Peds[i], Script.Feature['Kill Aura Range'].value, Script.Feature['Kill Aura Option'].value})
                end

                ::continue::

                Done = Done + 1
                if Done == 25 then
                    Done = 0
                    coroutine.yield(0)
                end
            end
            coroutine.yield(0)
        end
    end)
    Script.Feature['Kill Aura Enable']:set_str_data({'All Peds', 'Exclude Players', 'Players Only'})

    Script.Feature['Kill Aura Range'] = menu.add_feature('Range', 'autoaction_slider', Script.Parent['Kill Aura'], function(f)
        settings['Kill Aura Range'] = {Value = f.value}
    end)
    Script.Feature['Kill Aura Range'].min = 10
    Script.Feature['Kill Aura Range'].max = 100
    Script.Feature['Kill Aura Range'].mod = 5

    Script.Feature['Kill Aura Option'] = menu.add_feature('Option', 'autoaction_value_str', Script.Parent['Kill Aura'], function(f)
        settings['Kill Aura Option'] = {Value = f.value}
    end)
    Script.Feature['Kill Aura Option']:set_str_data({'Shoot', 'Explode'})

    Script.Feature['Force Field Enable'] = menu.add_feature('Enable Force Field', 'toggle', Script.Parent['Kill Aura'], function(f)
        settings['Force Field Enable'] = {Enabled = f.on}
        local running = {}
        local Done = 0

        while f.on do
            local Vehicles = vehicle.get_all_vehicles()

            for i = 1, #Vehicles do
                if Vehicles[i] == get.OwnVehicle() then
                    goto continue
                end

                if not running[Vehicles[i]] or menu.has_thread_finished(running[Vehicles[i]]) then
                    running[Vehicles[i]] = menu.create_thread(Threads.Forcefield, {Vehicles[i], Script.Feature['Force Field Range'].value, Script.Feature['Force Field Strength'].value})
                end

                ::continue::

                Done = Done + 1
                if Done == 25 then
                    Done = 0
                    coroutine.yield(0)
                end
            end

            coroutine.yield(0)
        end

        settings['Force Field Enable'].Enabled = f.on
    end)

    Script.Feature['Force Field Range'] = menu.add_feature('Range', 'autoaction_slider', Script.Parent['Kill Aura'], function(f)
        settings['Force Field Range'] = {Value = f.value}
    end)
    Script.Feature['Force Field Range'].min = 10
    Script.Feature['Force Field Range'].max = 100
    Script.Feature['Force Field Range'].mod = 5

    Script.Feature['Force Field Strength'] = menu.add_feature('Strength', 'autoaction_slider', Script.Parent['Kill Aura'], function(f)
        settings['Force Field Strength'] = {Value = f.value}
    end)
    Script.Feature['Force Field Strength'].min = 10
    Script.Feature['Force Field Strength'].max = 100
    Script.Feature['Force Field Strength'].mod = 5


    Script.Parent['Ped Manager'] = menu.add_feature('Ped Manager', 'parent', Script.Parent['local_world'], nil).id

    Script.Feature['Explode All Peds'] = menu.add_feature('Explode All Peds', 'toggle', Script.Parent['Ped Manager'], function(f)
        while f.on do
            local AllPeds = ped.get_all_peds()

            for i = 1, #AllPeds do
                if not ped.is_ped_a_player(AllPeds[i]) and not entity.is_entity_dead(AllPeds[i]) then
                    local Position = entity.get_entity_coords(AllPeds[i])

                    fire.add_explosion(Position, 5, true, false, 0, 0)
                end

                coroutine.yield(25)
            end

            coroutine.yield(500)
        end
    end)

    Script.Feature['Kill All Peds'] = menu.add_feature('Kill All Peds', 'toggle', Script.Parent['Ped Manager'], function(f)
        while f.on do
            local AllPeds = ped.get_all_peds()

            for i = 1, #AllPeds do
                if not ped.is_ped_a_player(AllPeds[i]) and not entity.is_entity_dead(AllPeds[i]) then
                    utility.request_ctrl(AllPeds[i])

                    ped.set_ped_health(AllPeds[i], 0)
                end

            end

            coroutine.yield(500)
        end
    end)

    Script.Feature['Shoot All Peds'] = menu.add_feature('Shoot All Peds', 'toggle', Script.Parent['Ped Manager'], function(f)
        while f.on do
            local AllPeds = ped.get_all_peds()

            for i = 1, #AllPeds do
                if not ped.is_ped_a_player(AllPeds[i]) and not entity.is_entity_dead(AllPeds[i]) then
                    if ped.get_vehicle_ped_is_using(AllPeds[i]) ~= 0 then
                        ped.clear_ped_tasks_immediately(AllPeds[i])
                    end
                    local Position = entity.get_entity_coords(AllPeds[i])

                    gameplay.shoot_single_bullet_between_coords(Position + v3(0, 0, 1), Position, 1000, 0xC472FE2, get.OwnPed(), false, true, 1000)
                end

            end

            coroutine.yield(500)
        end
    end)

    Script.Feature['Delete All Peds'] = menu.add_feature('Delete All Peds', 'toggle', Script.Parent['Ped Manager'], function(f)
        local running
        while f.on do
            
            if not running or menu.has_thread_finished(running) then
                menu.create_thread(Threads.Clearpeds, ped.get_all_peds())
            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Freeze All Peds'] = menu.add_feature('Freeze All Peds', 'toggle', Script.Parent['Ped Manager'], function(f)
        while f.on do
            local AllPeds = ped.get_all_peds()

            for i = 1, #AllPeds do
                if not ped.is_ped_a_player(AllPeds[i]) then
                    utility.request_ctrl(AllPeds[i])

                    entity.freeze_entity(AllPeds[i], true)
                end

            end

            coroutine.yield(500)
        end

        local AllPeds = ped.get_all_peds()

        for i = 1, #AllPeds do
            if not ped.is_ped_a_player(AllPeds[i]) then
                utility.request_ctrl(AllPeds[i])

                entity.freeze_entity(AllPeds[i], false)
            end

        end
    end)

    Script.Feature['Turn All Peds Invisible'] = menu.add_feature('Turn All Peds Invisible', 'toggle', Script.Parent['Ped Manager'], function(f)
        while f.on do
            local AllPeds = ped.get_all_peds()

            for i = 1, #AllPeds do
                if not ped.is_ped_a_player(AllPeds[i]) then
                    utility.request_ctrl(AllPeds[i])

                    entity.set_entity_visible(AllPeds[i], false)
                end

            end

            coroutine.yield(500)
        end

        local AllPeds = ped.get_all_peds()

        for i = 1, #AllPeds do
            if not ped.is_ped_a_player(AllPeds[i]) then
                utility.request_ctrl(AllPeds[i])

                entity.set_entity_visible(AllPeds[i], true)
            end

        end
    end)

    Script.Feature['Turn All Peds Invincible'] = menu.add_feature('Turn All Peds Invincible', 'toggle', Script.Parent['Ped Manager'], function(f)
        while f.on do
            local AllPeds = ped.get_all_peds()

            for i = 1, #AllPeds do
                if not ped.is_ped_a_player(AllPeds[i]) then
                    utility.request_ctrl(AllPeds[i])

                    entity.set_entity_god_mode(AllPeds[i], true)
                end

            end

            coroutine.yield(500)
        end
        
        local AllPeds = ped.get_all_peds()

        for i = 1, #AllPeds do
            if not ped.is_ped_a_player(AllPeds[i]) then
                utility.request_ctrl(AllPeds[i])

                entity.set_entity_god_mode(AllPeds[i], false)
            end

        end
    end)

    Script.Feature['Street War'] = menu.add_feature('Street War', 'toggle', Script.Parent['Ped Manager'], function(f)
        local running
        while f.on do
            if not running or menu.has_thread_finished(running) then
                running = menu.create_thread(streetwar.spawnped, nil)
            end

            local allpeds = ped.get_all_peds()
            for i = 1, #allpeds do
                if not ped.is_ped_a_player(allpeds[i]) then
                    menu.create_thread(streetwar.setup, {allpeds[i], allpeds})
                end

                coroutine.yield(0)
            end

            local pickups = object.get_all_pickups()
            for i = 1, #pickups do
                if entity.get_entity_model_hash(pickups[i]) == 1493691718 then
                    utility.clear(pickups[i])
                end
                coroutine.yield(0)
            end
            
            coroutine.yield(500)
        end
    end)

    Script.Feature['Kick All Peds from Vehicle'] = menu.add_feature('Kick All Peds from Vehicle', 'action', Script.Parent['Ped Manager'], function(f)
        local AllPeds = ped.get_all_peds()

        for i = 1, #AllPeds do
            if not ped.is_ped_a_player(AllPeds[i]) and ped.get_vehicle_ped_is_using(AllPeds[i]) ~= 0 then
                utility.request_ctrl(AllPeds[i])

                ped.clear_ped_tasks_immediately(AllPeds[i])
            end

        end
    end)


    Script.Parent['Vehicle Manager'] = menu.add_feature('Vehicle Manager', 'parent', Script.Parent['local_world'], nil).id

    Script.Feature['Explode All Vehicles'] = menu.add_feature('Explode All Vehicles', 'toggle', Script.Parent['Vehicle Manager'], function(f)
        while f.on do
            local AllVehicles = vehicle.get_all_vehicles()

            for i = 1, #AllVehicles do
                local Ped = vehicle.get_ped_in_vehicle_seat(AllVehicles[i], -1)

                if not ped.is_ped_a_player(Ped) and not vehicle.is_vehicle_damaged(AllVehicles[i]) then
                    local Position = entity.get_entity_coords(AllVehicles[i])

                    fire.add_explosion(Position, 72, true, false, 0, 0)
                end

                coroutine.yield(25)
            end

            coroutine.yield(500)
        end
    end)

    Script.Feature['Delete All Vehicles'] = menu.add_feature('Delete All Vehicles', 'toggle', Script.Parent['Vehicle Manager'], function(f)
        local running

        while f.on do
            if not running or menu.has_thread_finished(running) then
                running = menu.create_thread(Threads.Clearvehicles, vehicle.get_all_vehicles())

            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Freeze All Vehicles'] = menu.add_feature('Freeze All Vehicles', 'toggle', Script.Parent['Vehicle Manager'], function(f)
        while f.on do
            local AllVehicles = vehicle.get_all_vehicles()

            for i = 1, #AllVehicles do
                local Ped = vehicle.get_ped_in_vehicle_seat(AllVehicles[i], -1)

                if not ped.is_ped_a_player(Ped) then
                    utility.request_ctrl(AllVehicles[i])

                    entity.freeze_entity(AllVehicles[i], true)
                end

            end

            coroutine.yield(500)
        end

        local AllVehicles = vehicle.get_all_vehicles()

        for i = 1, #AllVehicles do
            utility.request_ctrl(AllVehicles[i])

            entity.freeze_entity(AllVehicles[i], false)
        end
    end)

    Script.Feature['Turn All Vehicles Invisible'] = menu.add_feature('Turn All Vehicles Invisible', 'toggle', Script.Parent['Vehicle Manager'], function(f)
        while f.on do
            local AllVehicles = vehicle.get_all_vehicles()

            for i = 1, #AllVehicles do
                local Ped = vehicle.get_ped_in_vehicle_seat(AllVehicles[i], -1)

                if not ped.is_ped_a_player(Ped) then
                    utility.request_ctrl(AllVehicles[i])

                    entity.set_entity_visible(AllVehicles[i], false)
                end

            end

            coroutine.yield(500)
        end

        local AllVehicles = vehicle.get_all_vehicles()

        for i = 1, #AllVehicles do
            utility.request_ctrl(AllVehicles[i])

            entity.set_entity_visible(AllVehicles[i], true)
        end
    end)

    Script.Feature['Turn All Vehicles Invincible'] = menu.add_feature('Turn All Vehicles Invincible', 'toggle', Script.Parent['Vehicle Manager'], function(f)
        while f.on do
            local AllVehicles = vehicle.get_all_vehicles()

            for i = 1, #AllVehicles do
                local Ped = vehicle.get_ped_in_vehicle_seat(AllVehicles[i], -1)

                if not ped.is_ped_a_player(Ped) then
                    utility.request_ctrl(AllVehicles[i])

                    entity.set_entity_god_mode(AllVehicles[i], true)
                end

            end

            coroutine.yield(500)
        end

        local AllVehicles = vehicle.get_all_vehicles()

        for i = 1, #AllVehicles do
            utility.request_ctrl(AllVehicles[i])

            entity.set_entity_god_mode(AllVehicles[i], false)
        end
    end)

    Script.Feature['Upgrade Nearby Vehicles'] = menu.add_feature('Upgrade Nearby Vehicles', 'toggle', Script.Parent['Vehicle Manager'], function(f)
        local running = {}
        while f.on do
            local AllVehicles = vehicle.get_all_vehicles()

            for i = 1, #AllVehicles do
                local Ped = vehicle.get_ped_in_vehicle_seat(AllVehicles[i], -1)

                if not ped.is_ped_a_player(Ped) then
                    if not running[AllVehicles[i]] or menu.has_thread_finished(running[AllVehicles[i]]) then
                        if not vehicle.is_toggle_mod_on(AllVehicles[i], 18) then
                            running[AllVehicles[i]] = menu.create_thread(Threads.Upgradevehicles, AllVehicles[i])

                        end

                    end

                end

                coroutine.yield(0)
            end

            coroutine.yield(500)
        end
    end)
    
    Script.Feature['Display Vehicle Speed'] = menu.add_feature("Display Vehicle Speed", "value_str", Script.Parent['Vehicle Manager'], function(f)
        settings['Display Vehicle Speed'] = {Enabled = f.on, Value = f.value}
        while f.on do
            local AllVehicles = vehicle.get_all_vehicles()
            local OwnPosition = player.get_player_coords(player.player_id())

            for i=1,#AllVehicles do
                if AllVehicles[i] ~= get.OwnVehicle() then
                    local Vehicle = AllVehicles[i]
                    local VehiclePosition = entity.get_entity_coords(Vehicle)
                    local Magnitude = OwnPosition:magnitude(VehiclePosition)

                    if Magnitude < 50 then
                        local Success, ScreenPos = graphics.project_3d_coord(VehiclePosition)

                        if Success then
                            ScreenPos.x = scriptdraw.pos_pixel_to_rel_x(ScreenPos.x)
                            ScreenPos.y = scriptdraw.pos_pixel_to_rel_y(ScreenPos.y)
                            
                            local Speed = entity.get_entity_speed(Vehicle)
                            local Type
                            local Text

                            if f.value == 0 then
                                Type = Speed * 3.6
                                Text = ' KM/H'

                            elseif f.value == 1 then
                                Type = Speed * 2.23694
                                Text = ' MP/H'
                            end

                            if Math.Round(Type, 2) ~= 0.0 then
                                scriptdraw.draw_text(Math.Round(Type, 2) .. Text, ScreenPos, v2(), 0.6 - 0.5 * (Magnitude / 50), 0xFFFFFFFF, 1 << 0 | 1 << 2, nil)
                            end
                        end
                    end
                end
            end
            settings['Display Vehicle Speed'].Value = f.value
            coroutine.yield(0)
        end
        settings['Display Vehicle Speed'].Enabled = f.on
        
    end)
    Script.Feature['Display Vehicle Speed']:set_str_data({'KM/H', 'MP/H'})

    Script.Feature['Change Gravity'] = menu.add_feature('Change Gravity', 'slider', Script.Parent['Vehicle Manager'], function(f)
        while f.on do
            local AllVehicles = vehicle.get_all_vehicles()
            
            for i = 1, #AllVehicles do
                local Ped = vehicle.get_ped_in_vehicle_seat(AllVehicles[i], -1)

                if not ped.is_ped_a_player(Ped) then
                    utility.request_ctrl(AllVehicles[i])

                    vehicle.set_vehicle_gravity_amount(AllVehicles[i], f.value)

                    if entity.get_entity_speed(AllVehicles[i]) == 0 then
                        vehicle.set_vehicle_forward_speed(AllVehicles[i], 1)
                    end
                end

            end
            
            coroutine.yield(500)
        end

        local AllVehicles = vehicle.get_all_vehicles()

        for i = 1, #AllVehicles do
            utility.request_ctrl(AllVehicles[i])

            vehicle.set_vehicle_gravity_amount(AllVehicles[i], 10)
        end
    end)
    Script.Feature['Change Gravity'].min = -100
    Script.Feature['Change Gravity'].max = 100
    Script.Feature['Change Gravity'].mod = 25
    Script.Feature['Change Gravity'].value = 0

    Script.Feature['Disable Collision with Vehicles'] = menu.add_feature('Disable Collision with Vehicles', 'toggle', Script.Parent['Vehicle Manager'], function(f)
        local running
        while f.on do
            local Entity
            local OwnVehicle = get.OwnVehicle()
            
            if OwnVehicle ~= 0 then
                Entity = OwnVehicle
            else
                Entity = get.OwnPed()
            end

            if not running or menu.has_thread_finished(running) then
                running =  menu.create_thread(Threads.Vehiclecollision, {vehicle.get_all_vehicles(), Entity})

            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Set Traffic Out Of Control'] = menu.add_feature('Set Traffic Out Of Control', 'toggle', Script.Parent['Vehicle Manager'], function(f)
        while f.on do
            local AllVehicles = vehicle.get_all_vehicles()

            for i = 1, #AllVehicles do
                local Ped = vehicle.get_ped_in_vehicle_seat(AllVehicles[i], -1)

                if not ped.is_ped_a_player(Ped) then
                    utility.request_ctrl(AllVehicles[i])

                    vehicle.set_vehicle_forward_speed(AllVehicles[i], 40)
                    vehicle.set_vehicle_out_of_control(AllVehicles[i], false, false)
                end

            end

            coroutine.yield(100)
        end
    end)


    Script.Parent['Object Manager'] = menu.add_feature('Object Manager', 'parent', Script.Parent['local_world'], nil).id

    Script.Feature['Delete All Objects'] = menu.add_feature('Delete All Objects', 'toggle', Script.Parent['Object Manager'], function(f)
        ToggleOff({'Drive On Ocean', 'Drive This Height'})

        local running
        while f.on do
            if not running or menu.has_thread_finished(running) then
                running = menu.create_thread(Threads.Clearobjects, object.get_all_objects())
            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Turn All Objects Invisible'] = menu.add_feature('Turn All Objects Invisible', 'toggle', Script.Parent['Object Manager'], function(f)
        while f.on do
            local AllObjects = object.get_all_objects()

            for i = 1, #AllObjects do
                utility.request_ctrl(AllObjects[i])

                entity.set_entity_visible(AllObjects[i], false)
            end

            coroutine.yield(500)
        end

        local AllObjects = object.get_all_objects()

        for i = 1, #AllObjects do
            utility.request_ctrl(AllObjects[i])

            entity.set_entity_visible(AllObjects[i], true)
        end
    end)

    Script.Feature['Make All Objects Indestructible'] = menu.add_feature('Make All Objects Indestructible', 'toggle', Script.Parent['Object Manager'], function(f)
        while f.on do
            local AllObjects = object.get_all_objects()

            for i = 1, #AllObjects do
                utility.request_ctrl(AllObjects[i])

                entity.set_entity_god_mode(AllObjects[i], true)
                entity.freeze_entity(AllObjects[i], true)
            end

            coroutine.yield(500)
        end

        local AllObjects = object.get_all_objects()

        for i = 1, #AllObjects do
            utility.request_ctrl(AllObjects[i])

            entity.set_entity_god_mode(AllObjects[i], false)
            entity.freeze_entity(AllObjects[i], false)
        end
    end)

    Script.Feature['Disable Collision with Objects'] = menu.add_feature('Disable Collision with Objects', 'toggle', Script.Parent['Object Manager'], function(f)
        local running
        while f.on do
            local Entity
            local OwnVehicle = get.OwnVehicle()

            if OwnVehicle ~= 0 then
                Entity = OwnVehicle
            else
                Entity = get.OwnPed()
            end

            if not running or menu.has_thread_finished(running) then
                running =  menu.create_thread(Threads.Objectcollision, {object.get_all_objects(), Entity})

            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Collect all Pickups'] = menu.add_feature('Collect all Pickups', 'action', Script.Parent['Object Manager'], function() 
        local AllPickups = object.get_all_pickups()

        if #AllPickups == 0 then
            Notify('No Pickups found!', "Error", '')

        else
            for i = 1, #AllPickups do
                entity.set_entity_coords_no_offset(AllPickups[i], get.OwnCoords())

                coroutine.yield(0)
            end

        end
    end)

    Script.Feature['Remove all Pickups'] = menu.add_feature('Remove all Pickups', 'action', Script.Parent['Object Manager'], function()
        local AllPickups = object.get_all_pickups()

        if #AllPickups == 0 then
            Notify('No Pickups found!', "Error", '')

        else
            utility.clear(AllPickups)
        end
    end)
    
    Script.Feature['Disable Collision with Entites'] = menu.add_feature('Disable Collision with Entites', 'toggle', Script.Parent['local_world'], function(f)
        ToggleOff({'Disable Collision with Vehicles', 'Disable Collision with Objects', 'Drive On Ocean', 'Drive This Height'})
        settings['Disable Collision with Entites'] = {Enabled = f.on}

        local running1, running2

        while f.on do
            local Entity
            local OwnVehicle = get.OwnVehicle()
            if OwnVehicle ~= 0 then
                Entity = OwnVehicle
            else
                Entity = get.OwnPed()
            end
            
            if not running1 or menu.has_thread_finished(running1) then
                running1 = menu.create_thread(Threads.Vehiclecollision, {vehicle.get_all_vehicles(), Entity})

            end

            if not running2 or menu.has_thread_finished(running2) then
                running2 = menu.create_thread(Threads.Objectcollision, {object.get_all_objects(), Entity})

            end
            
            coroutine.yield(0)
        end
        settings['Disable Collision with Entites'].Enabled = f.on
    end)

    Script.Feature['Drive On Ocean'] = menu.add_feature('Drive / Walk on the Ocean', 'toggle', Script.Parent['local_world'], function(f)
        if Script.Feature['Disable Collision with Entites'].on or Script.Feature['Disable Collision with Objects'].on then
            Notify('This doesnt work while disabling collision with objects.', nil, '')
            f.on = false
            return
        end

        if Script.Feature['Clear Area'].on or Script.Feature['Delete All Objects'].on then
            Notify('This doesnt work while constantly deleting all objects.', nil, '')
            f.on = false
            return
        end

        settings['Drive On Ocean'] = {Enabled = f.on}
        while f.on do
            local Position = get.OwnCoords()

            if OceanEntity == nil then
                OceanEntity = Spawn.Object(1822550295, v3(Position.x, Position.y, -4))

                entity.set_entity_visible(OceanEntity, false)
            end

            water.set_waves_intensity(-100000000)

            Position.z = -5
            utility.set_coords(OceanEntity, Position)

            coroutine.yield(0)
        end

        if OceanEntity then
            water.reset_waves_intensity()

            utility.clear({OceanEntity})
            OceanEntity = nil
        end

        settings['Drive On Ocean'].Enabled = f.on
    end)

    Script.Feature['Drive This Height'] = menu.add_feature('Drive / Walk this Height', 'toggle', Script.Parent['local_world'], function(f)
        if Script.Feature['Disable Collision with Entites'].on or Script.Feature['Disable Collision with Objects'].on then
            Notify('This doesnt work while disabling collision with objects.', nil, '')
            f.on = false
            return
        end

        if Script.Feature['Clear Area'].on or Script.Feature['Delete All Objects'].on then
            Notify('This doesnt work while constantly deleting all objects.', nil, '')
            f.on = false
            return
        end

        settings['Drive This Height'] = {Enabled = f.on}
        while f.on do
            local Position, Offset

            if ped.is_ped_in_any_vehicle(get.OwnPed()) then
                local veh = get.OwnVehicle()

                Position = entity.get_entity_coords(veh)
                Offset = 5.25

            else
                Position = get.OwnCoords()
                Offset = 5.85
            end

            if HeightEntity == nil then
                FixedHeight = Position.z - Offset
                HeightEntity = Spawn.Object(1822550295, v3(Position.x, Position.y, FixedHeight))

                entity.set_entity_visible(HeightEntity, false)
            end

            water.set_waves_intensity(-100000000)

            Position.z = FixedHeight
            utility.set_coords(HeightEntity, Position)

            coroutine.yield(0)
        end
        
        if HeightEntity then
            water.reset_waves_intensity()

            utility.clear({HeightEntity})
            HeightEntity = nil
            FixedHeight = nil
        end

        settings['Drive This Height'].Enabled = f.on
    end)

    Script.Feature['Clear Area'] = menu.add_feature('Clear Area', 'toggle', Script.Parent['local_world'], function(f)
        ToggleOff({'Drive On Ocean', 'Drive This Height'})

        local PedThread, VehicleThread, ObjectThread
        while f.on do

            if not PedThread or menu.has_thread_finished(PedThread) then
                PedThread = menu.create_thread(Threads.Clearpeds, ped.get_all_peds())

            end

            if not VehicleThread or menu.has_thread_finished(VehicleThread) then
                VehicleThread = menu.create_thread(Threads.Clearvehicles, vehicle.get_all_vehicles())

            end

            if not ObjectThread or menu.has_thread_finished(ObjectThread) then
                ObjectThread = menu.create_thread(Threads.Clearobjects, object.get_all_objects())

            end

            coroutine.yield(0)
        end
    end)


    Script.Feature['Reset Orbital-Cannon Cooldown'] = menu.add_feature('Reset Orbital-Cannon Cooldown', 'action', Script.Parent['Stats Editor'].id, function()
        Math.SetIntStat('ORBITAL_CANNON_COOLDOWN', true, 0)
    end)

    Script.Feature['Disable Orbital-Cannon Cooldown'] = menu.add_feature('Disable Orbital-Cannon Cooldown', 'toggle', Script.Parent['Stats Editor'].id, function(f)
        settings['Disable Orbital-Cannon Cooldown'] = {Enabled = f.on}

        while f.on do
            Math.SetIntStat('ORBITAL_CANNON_COOLDOWN', true, 0)

            coroutine.yield(2000)
        end

        settings['Disable Orbital-Cannon Cooldown'].Enabled = f.on
    end)

    Script.Feature['Fill Snacks and Armor'] = menu.add_feature('Fill Snacks and Armor', 'action', Script.Parent['Stats Editor'].id, function()
        local Hashes = stathashes['snacks_and_armor']

        for i = 1, #Hashes do
            Math.SetIntStat(Hashes[i][1], true, Hashes[i][2])
        end

        Notify('Filled Inventory with Snacks and Armor!', "Success")
        Log('Filled Inventory with Snacks and Armor!')
    end)

    Script.Feature['Fill Business Clutter'] = menu.add_feature('Fill Business Clutter', 'action_value_str', Script.Parent['Stats Editor'].id, function(f)
        if f.value == 0 then
            local Hashes = stathashes['ceo_earnings']

            for i = 1, #Hashes do
                Math.SetIntStat(Hashes[i][1], true, Hashes[i][2])
            end
        else
            local Hashes = stathashes['mc_earnings']

            for i = 1, #Hashes do
                Math.SetIntStat(Hashes[i][1], true, Hashes[i][2])
            end
        end

        Notify('Filled Business with Clutter\nFinish a legit Sell Mission to show Effect!', "Success")
    end)
    Script.Feature['Fill Business Clutter']:set_str_data({'CEO', 'MC'})

    Script.Feature['Set KD (Kills / Death)'] = menu.add_feature('Set KD (Kills / Death)', 'action', Script.Parent['Stats Editor'].id, function()
        local KD = get.Input('Enter KD (Kills / Death)', 10, 5)

        if not KD then
            Notify('Input canceled.', "Error", '')
            return
        end

        KD = tonumber(KD)
        local Hashes = stathashes['kills_deaths']
        local Multiplier = math.random(1000, 2000)
        local Kills = math.floor(KD * Multiplier)
        local Deaths = math.floor(Kills / KD)

        Log('Setting Stat ' .. Hashes[1] .. ' to: ' .. Kills .. '\nSetting Stat ' .. Hashes[2] .. ' to: ' .. Deaths)

        Math.SetIntStat(Hashes[1], false, Kills)
        Math.SetIntStat(Hashes[2], false, Deaths)

        Notify('New KD set. To update the KD, earn a legit kill or death!', "Success")
    end)

    Script.Feature['Set Mental State'] = menu.add_feature('Set Mental State', 'action_value_i', Script.Parent['Stats Editor'].id, function(f)
        Math.SetFloatStat('PLAYER_MENTAL_STATE', true, f.value)

        Notify('Set Mental State to ' .. f.value .. '.\nKill any Ped for it to apply.', "Success")
    end)
    Script.Feature['Set Mental State'].min = 0.0
    Script.Feature['Set Mental State'].max = 100.0
    Script.Feature['Set Mental State'].mod = 10.0

    Script.Feature['Unlock Xmas Liveries'] = menu.add_feature('Unlock Xmas Liveries', 'action', Script.Parent['Stats Editor'].id, function()
        local Hashes = stathashes['xmas']

        for i = 1, #Hashes do
            Math.SetIntStat(Hashes[i][1], false, -1)
        end

        Notify('Xmas Liveries Unlocked!', "Success")
    end)

    Script.Feature['Unlock Fast-Run Ability'] = menu.add_feature('Unlock Fast-Run Ability', 'action', Script.Parent['Stats Editor'].id, function()
        local Hashes = stathashes['fast_run']

        for i = 1, #Hashes do
            Math.SetIntStat(Hashes[i], true, -1)
        end

        Notify('New Ability set, Change Lobby to show Effect!', "Success")
    end)

    local pericostats = stathashes['perico']

    Script.Parent['Casino Heist Stats'] = menu.add_feature('Casino Heist', 'parent', Script.Parent['Stats Editor'].id, nil).id

    Script.Feature['Reset Heist'] = menu.add_feature('Reset Heist', 'action', Script.Parent['Casino Heist Stats'], function()
        local Hashes = stathashes['chc']['board2']
        for i = 1, #Hashes do
            Math.SetIntStat(Hashes[i][2], true, Hashes[i][3])
        end
        
        Hashes = stathashes['chc']['board1']
        for i = 1, #Hashes do
            Math.SetIntStat(Hashes[i][2], true, Hashes[i][3])
        end

        Hashes = stathashes['chc']['misc']
        for i = 1, #Hashes do
            Math.SetIntStat(Hashes[i][2], true, Hashes[i][3])
        end

        Notify('Casino Heist reset!', "Success")
    end)

    Script.Feature['Heist Quick Start'] = menu.add_feature('Quick Start', 'action_value_str', Script.Parent['Casino Heist Stats'], function(f)
        local Hashes = stathashes['chc']['misc']

        if f.value == 0 then
            Math.SetIntStat(Hashes[1][2], true, Hashes[1][4])
            Math.SetIntStat(Hashes[2][2], true, Hashes[2][4])

            Hashes = stathashes['chc']['board1']
            for i = 1, #Hashes do
                local value = Hashes[i][4]
                if Hashes[i][5] then
                    value = math.random(Hashes[i][4], Hashes[i][5])
                end
                Math.SetIntStat(Hashes[i][2], true, value)
            end

            Hashes = stathashes['chc']['misc']
            Math.SetIntStat(Hashes[3][2], true, Hashes[3][4])

            Hashes = stathashes['chc']['board2']
            for i = 1, #Hashes do
                local value = Hashes[i][4]
                if Hashes[i][5] then
                    value = math.random(Hashes[i][4], Hashes[i][5])
                end
                Math.SetIntStat(Hashes[i][2], true, value)
            end

            Hashes = stathashes['chc']['misc']
            Math.SetIntStat(Hashes[4][2], true, Hashes[4][4])
            Notify('Casino Heist set up with random execution. If you dont like it, Reset Heist and try again!', "Success")
        else
            Math.SetIntStat(Hashes[1][2], true, Hashes[1][4])
            Math.SetIntStat(Hashes[2][2], true, Hashes[2][4])

            Hashes = stathashes['chc']['board1']
            for i = 1, #Hashes do
                local value = Hashes[i][6] or Hashes[i][4]
                Math.SetIntStat(Hashes[i][2], true, value)
            end

            Hashes = stathashes['chc']['misc']
            Math.SetIntStat(Hashes[3][2], true, Hashes[3][4])

            Hashes = stathashes['chc']['board2']
            for i = 1, #Hashes do
                local value = Hashes[i][6] or Hashes[i][4]
                if #Hashes[i] == 5 then
                    value = math.random(Hashes[i][4], Hashes[i][5])
                end
                Math.SetIntStat(Hashes[i][2], true, Hashes[i][4])
            end

            Hashes = stathashes['chc']['misc']
            Math.SetIntStat(Hashes[4][2], true, Hashes[4][4])

            Notify('Casino Heist set up with highest Payout. If you dont like it, Reset Heist and try again!', "Success")
        end
    end)
    Script.Feature['Heist Quick Start']:set_str_data({'Random', 'Highest Payout'})


    Script.Parent['First Board'] = menu.add_feature('First Board', 'parent', Script.Parent['Casino Heist Stats'], nil).id

    Script.Feature['Reset last Approach'] = menu.add_feature('Reset last Approach', 'action', Script.Parent['First Board'], function()
        local Hashes = stathashes['chc']['misc']
        Math.SetIntStat(Hashes[1][2], true, Hashes[1][4])
        Math.SetIntStat(Hashes[2][2], true, Hashes[2][4])
    end)

    Script.Feature['Unlock Casino POI'] = menu.add_feature('Unlock Points of Interests', 'action', Script.Parent['First Board'], function()
        local Hashes = stathashes['chc']['board1']
        Math.SetIntStat(Hashes[4][2], true, Hashes[4][4])
    end)

    Script.Feature['Unlock Access Points'] = menu.add_feature('Unlock Access Points', 'action', Script.Parent['First Board'], function()
        local Hashes = stathashes['chc']['board1']
        Math.SetIntStat(Hashes[5][2], true, Hashes[5][4])
    end)

    Script.Feature['Set Approach'] = menu.add_feature('Set Approach', 'action_value_str', Script.Parent['First Board'], function(f)
        local Hashes = stathashes['chc']['board1']

        if f.value == 0 then
            Math.SetIntStat(Hashes[1][2], true, f.value + 1)
        end

        if f.value == 1 then
            Math.SetIntStat(Hashes[1][2], true, f.value + 1)
        end

        if f.value == 2 then
            Math.SetIntStat(Hashes[1][2], true, f.value + 1)
        end
    end)
    Script.Feature['Set Approach']:set_str_data({'Silent', 'Big Con', 'Aggressive'})

    Script.Feature['Set Last Approach'] = menu.add_feature('Set Last Approach', 'action_value_str', Script.Parent['First Board'], function(f)
        local Hashes = stathashes['chc']['board1']

        Math.SetIntStat(Hashes[2][2], true, f.value + 1)
    end)
    Script.Feature['Set Last Approach']:set_str_data({'Silent', 'Big Con', 'Aggressive'})

    Script.Feature['Set Target'] = menu.add_feature('Set Target', 'action_value_str', Script.Parent['First Board'], function(f)
        local Hashes = stathashes['chc']['board1']
        Math.SetIntStat(Hashes[3][2], true, f.value)
    end)
    Script.Feature['Set Target']:set_str_data({'Money', 'Gold', 'Art', 'Diamonds'})

    Script.Feature['Confirm First Board'] = menu.add_feature('Confirm First Board', 'action', Script.Parent['First Board'], function()
        local Hashes = stathashes['chc']['misc']
        Math.SetIntStat(Hashes[3][2], true, Hashes[3][4])
    end)


    Script.Parent['Second Board'] = menu.add_feature('Second Board', 'parent', Script.Parent['Casino Heist Stats'], nil).id

    Script.Feature['Weapon Member Payout'] = menu.add_feature('Choose Gunman', 'action_value_str', Script.Parent['Second Board'], function(f)
        local Hashes = stathashes['chc']['board2']
        Math.SetIntStat(Hashes[1][2], true, f.value + 1)
    end)
    Script.Feature['Weapon Member Payout']:set_str_data({'Karl Abolaji (5%)', 'Gustavo Mota (9%)', 'Charlie Reed (7%)', 'Chester Mccoy (10%)', 'Patrick Mcreary (8%)'})

    Script.Feature['Driver Payout'] = menu.add_feature('Choose Driver', 'action_value_str', Script.Parent['Second Board'], function(f)
        local Hashes = stathashes['chc']['board2']
        Math.SetIntStat(Hashes[2][2], true, f.value + 1)
    end)
    Script.Feature['Driver Payout']:set_str_data({'Karim Denz (5%)', 'Taliana Martinez (7%)', 'Eddie Toh (9%)', 'Zach Nelson (6%)', 'Chester Mccoy (10%)'})

    Script.Feature['Hacker Payout'] = menu.add_feature('Choose Hacker', 'action_value_str', Script.Parent['Second Board'], function(f)
        local Hashes = stathashes['chc']['board2']
        Math.SetIntStat(Hashes[3][2], true, f.value + 1)
    end)
    Script.Feature['Hacker Payout']:set_str_data({'Rickie Lukens (3%)', 'Christian Feltz (7%)', 'Yohan Blair (5%)', 'Avi Schwartzman (10%)', 'Paige Harris (9%)'})

    Script.Feature['Weapon Variation'] = menu.add_feature('Weapon Variation', 'action_value_str', Script.Parent['Second Board'], function(f)
        local Hashes = stathashes['chc']['board2']
        Math.SetIntStat(Hashes[4][2], true, f.value)
    end)
    Script.Feature['Weapon Variation']:set_str_data({'01/02', '02/02'})

    Script.Feature['Vehicle Variation'] = menu.add_feature('Vehicle Variation', 'action_value_str', Script.Parent['Second Board'], function(f)
        local Hashes = stathashes['chc']['board2']
        Math.SetIntStat(Hashes[5][2], true, f.value)
    end)
    Script.Feature['Vehicle Variation']:set_str_data({'01/04', '02/04', '03/04', '04/04'})

    Script.Feature['Remove Duggan Heavy Guards'] = menu.add_feature('Remove Duggan Heavy Guards', 'action', Script.Parent['Second Board'], function()
        local Hashes = stathashes['chc']['board2']
        Math.SetIntStat(Hashes[6][2], true, Hashes[6][4])
    end)

    Script.Feature['Equip Heavy Armor'] = menu.add_feature('Equip Heavy Armor', 'action', Script.Parent['Second Board'], function()
        local hashes = stathashes['chc']['board2']
        Math.SetIntStat(hashes[7][2], true, hashes[7][4])
    end)

    Script.Feature['Unlock Scan Cards'] = menu.add_feature('Unlock Scan Cards', 'action', Script.Parent['Second Board'], function()
        local Hashes = stathashes['chc']['board2']
        Math.SetIntStat(Hashes[8][2], true, Hashes[8][4])
    end)

    Script.Feature['Confirm Second Board'] = menu.add_feature('Confirm Second Board', 'action', Script.Parent['Second Board'], function()
        local Hashes = stathashes['chc']['misc']
        Math.SetIntStat(Hashes[4][2], true, Hashes[4][4])
    end)

    Script.Parent['Cayo Perico Stats'] = menu.add_feature('Cayo Perico Heist', 'parent', Script.Parent['Stats Editor'].id, nil).id

    Script.Feature['Reset Perico Heist'] = menu.add_feature('Reset Heist', 'action', Script.Parent['Cayo Perico Stats'], function()
        local Hashes = pericostats

        for i = 4, 18 do
            Math.SetIntStat(Hashes[i][2], true, 0)
        end

        Math.SetIntStat(Hashes[12][2], true, 110154)
        Notify('Perico Heist has been reset!', "Success")
    end)

    Script.Feature['Perico Heist Unlocks'] = menu.add_feature('Unlocks', 'action_value_str', Script.Parent['Cayo Perico Stats'], function(f)
        local hashes = pericostats
        if f.value == 0 then
            Math.SetIntStat(hashes[1][2], true, hashes[1][4])
        elseif f.value == 1 then
            Math.SetIntStat(hashes[2][2], true, hashes[2][4])
        elseif f.value == 2 then
            Math.SetIntStat(hashes[10][2], true, hashes[10][4])
        else
            Math.SetIntStat(hashes[3][2], true, hashes[3][4])
        end
    end)
    Script.Feature['Perico Heist Unlocks']:set_str_data({'Points of Interests', 'Entry Points', 'Escape Points', 'Support Team'})

    Script.Feature['Perico Primary Target'] = menu.add_feature('Primary Target', 'action_value_str', Script.Parent['Cayo Perico Stats'], function(f)
        local hashes = pericostats
        Math.SetIntStat(hashes[8][2], true, f.value)
    end)
    Script.Feature['Perico Primary Target']:set_str_data({'Tequila', 'Ruby', 'Bearer Bonds', 'Pink Diamond', 'Madrazo Files', 'Panther Statue'})

    Script.Feature['Perico Secondary Loot'] = menu.add_feature('Mansion Loot', 'action_value_str', Script.Parent['Cayo Perico Stats'], function(f)
        local hashes = pericostats

        if f.value == 0 then
            Math.SetIntStat(hashes[13][2], true, hashes[13][4])
            Math.SetIntStat(hashes[14][2], true, hashes[14][4])
            Math.SetIntStat(hashes[15][2], true, hashes[15][4])
            Math.SetIntStat(hashes[16][2], true, hashes[16][4])
            Math.SetIntStat(hashes[17][2], true, hashes[17][4])
            Math.SetIntStat(hashes[18][2], true, hashes[18][4])
            Notify('Secondary Loot set for 1 Player', "Success")

        elseif f.value == 1 then
            Math.SetIntStat(hashes[13][2], true, hashes[13][5])
            Math.SetIntStat(hashes[14][2], true, hashes[14][5])
            Math.SetIntStat(hashes[15][2], true, hashes[15][5])
            Math.SetIntStat(hashes[16][2], true, hashes[16][5])
            Math.SetIntStat(hashes[17][2], true, hashes[17][5])
            Math.SetIntStat(hashes[18][2], true, hashes[18][5])
            Notify('Secondary Loot set for 2 Players.\nPlayer Cuts: 50% Each', "Success")

        elseif f.value == 2 then
            Math.SetIntStat(hashes[13][2], true, hashes[13][5])
            Math.SetIntStat(hashes[14][2], true, hashes[14][5])
            Math.SetIntStat(hashes[15][2], true, hashes[15][5])
            Math.SetIntStat(hashes[16][2], true, hashes[16][6])
            Math.SetIntStat(hashes[17][2], true, hashes[17][5])
            Math.SetIntStat(hashes[18][2], true, hashes[18][6])
            Notify('Secondary Loot set for 3 Players.\nPlayer Cuts: Host 30%, Other Players 35%', "Success")

        elseif f.value == 3 then
            Math.SetIntStat(hashes[13][2], true, hashes[13][5])
            Math.SetIntStat(hashes[14][2], true, hashes[14][5])
            Math.SetIntStat(hashes[15][2], true, hashes[15][5])
            Math.SetIntStat(hashes[16][2], true, hashes[16][7])
            Math.SetIntStat(hashes[17][2], true, hashes[17][5])
            Math.SetIntStat(hashes[18][2], true, hashes[18][7])
            Notify('Secondary Loot set for 4 Players.\nPlayer Cuts: 25% Each', "Success")
        end
    end)
    Script.Feature['Perico Secondary Loot']:set_str_data({'1 Player', '2 Players', '3 Players', '4 Players'})

    Script.Feature['Perico Weapon Variation'] = menu.add_feature('Weapon Variation', 'action_value_str', Script.Parent['Cayo Perico Stats'], function(f)
        local hashes = pericostats
        Math.SetIntStat(hashes[4][2], true, f.value + 1)
    end)
    Script.Feature['Perico Weapon Variation']:set_str_data({'Aggressor', 'Conspirator', 'Crackshot', 'Saboteur', 'Marksman'})

    Script.Feature['Perico Disruptions'] = menu.add_feature('Enable Disruptions', 'action', Script.Parent['Cayo Perico Stats'], function(f)
        local hashes = pericostats

        Math.SetIntStat(hashes[5][2], true, hashes[5][4])
        Math.SetIntStat(hashes[6][2], true, hashes[6][4])
        Math.SetIntStat(hashes[7][2], true, hashes[7][4])
    end)

    Script.Feature['Truck Spawn Place'] = menu.add_feature('Truck Spawn Place', 'action_value_str', Script.Parent['Cayo Perico Stats'], function(f)
        local hashes = pericostats
        Math.SetIntStat(hashes[9][2], true, f.value + 1)
    end)
    Script.Feature['Truck Spawn Place']:set_str_data({'Airport', 'North Dock', 'East Main Dock', 'West Main Dock', 'Compound'})

    Script.Feature['Perico Difficulty'] = menu.add_feature('Set Difficulty', 'action_value_str', Script.Parent['Cayo Perico Stats'], function(f)
        local hashes = pericostats
        local dif

        if f.value == 0 then
            dif = hashes[12][4]
        else
            dif = hashes[12][5]
        end

        Math.SetIntStat(hashes[12][2], true, dif)
    end)
    Script.Feature['Perico Difficulty']:set_str_data({'Normal', 'Hard'})

    Script.Feature['Perico Missions Completed'] = menu.add_feature('Set Missions as completed', 'action', Script.Parent['Cayo Perico Stats'], function()
        local hashes = pericostats
        Math.SetIntStat(hashes[11][2], true, hashes[11][4])
    end)


    Script.Parent['Delete Outifts'] = menu.add_feature('Delete Custom Outfits', 'parent', Script.Parent['local_misc'], function()
        if not Script.Feature['Disable Warning Messages'].on then
            Notify('Be aware that deleting the outfits cant be reverted!', "Neutral")
        end

        local outfits = utils.get_all_files_in_directory(paths['ModdedOutfits'] .. '\\', 'ini')
        local entries = Script.Parent['Delete Outifts'].children

        for i = 1, #outfits do
            local add = true
            for y = 1, #entries do
                if entries[y].name == outfits[i] then
                    add = false
                end
            end
            if add then
                menu.add_feature(outfits[i], 'action', Script.Parent['Delete Outifts'].id, function(f)
                        if utils.file_exists(paths['ModdedOutfits'] .. '\\' .. outfits[i]) then
                            if io.remove(paths['ModdedOutfits'] .. '\\' .. outfits[i]) then
                                Log('Deleted Outfit: ' .. outfits[i])
                                return HANDLER_CONTINUE
                            end
                            Notify('ERROR deleting the file, try again!', "Error")
                            return
                        end
                    menu.delete_feature(f.id)
                end)
            end
        end
    end)

    Script.Parent['Delete Vehicles'] = menu.add_feature('Delete Custom Vehicles', 'parent', Script.Parent['local_misc'], function()
        if not Script.Feature['Disable Warning Messages'].on then
            Notify('Be aware that deleting the vehicles cant be reverted!', "Neutral")
        end

        local vehicles = utils.get_all_files_in_directory(paths['ModdedVehicles'] .. '\\', 'ini')
        local entries = Script.Parent['Delete Vehicles'].children

        for i = 1, #vehicles do
            local add = true
            for y = 1, #entries do
                if entries[y].name == vehicles[i] then
                    add = false
                end
            end
            if add then
                menu.add_feature(vehicles[i], 'action', Script.Parent['Delete Vehicles'].id, function(f)
                        if utils.file_exists(paths['ModdedVehicles'] .. '\\' .. vehicles[i]) then
                            if io.remove(paths['ModdedVehicles'] .. '\\' .. vehicles[i]) then
                                Log('Deleted Vehicle: ' .. vehicles[i])
                                return HANDLER_CONTINUE
                            end
                            Notify('ERROR deleting the file, try again!', "Error")
                            return
                        end
                    menu.delete_feature(f.id)
                end)
            end
        end
    end)


    Script.Parent['Heist Helper'] = menu.add_feature('Heist Helper', 'parent', Script.Parent['local_misc'], nil).id
    
    Script.Feature['Remove Heist Enemies'] = menu.add_feature('Remove Enemies', 'value_str', Script.Parent['Heist Helper'], function(f)
        while f.on do
            local AllPeds = ped.get_all_peds()

            for i = 1, #AllPeds do
                local Hash = entity.get_entity_model_hash(AllPeds[i])

                if Hash == 0x1EEAAD1F or Hash == 0x8D8F1B10 or Hash == 0xBEC82CA5 or Hash == 0xA217F345 or Hash == 0x1422D45B or Hash == 2127932792 or Hash == 1821116645 or Hash == 193469166 then
                    if f.value == 1 and not entity.is_entity_dead(AllPeds[i]) then
                        ped.set_ped_health(AllPeds[i], 0)

                    elseif f.value == 2 and not entity.is_entity_dead(AllPeds[i]) then
                        local Position = entity.get_entity_coords(AllPeds[i])

                        ped.clear_ped_tasks_immediately(AllPeds[i])
                        gameplay.shoot_single_bullet_between_coords(Position + v3(0, 0, 1), Position, 1000, 0xC472FE2, get.OwnPed(), false, true, 1000)
                    else
                        utility.clear({AllPeds[i]})
                    end
                end

                coroutine.yield(0)
            end

            coroutine.yield(250)
        end
    end)
    Script.Feature['Remove Heist Enemies']:set_str_data({'Delete', 'Kill', 'Shoot'})

    Script.Feature['Remove Heist Cameras'] = menu.add_feature("Remove Cameras", 'toggle', Script.Parent['Heist Helper'], function(f)
        while f.on do
            local AllCams = object.get_all_objects()

            for i = 1, #AllCams do
                local Hash = entity.get_entity_model_hash(AllCams[i])

                if Hash == 4121760380 or Hash == 3061645218 or Hash == 548760764 or Hash == 2135655372 then
                    utility.clear({AllCams[i]})
                end

                coroutine.yield(0)
            end

            coroutine.yield(250)
        end
    end)

    Script.Parent['Casino Heist Helper'] = menu.add_feature('Casino Heist', 'parent', Script.Parent['Heist Helper'], nil).id

    Script.Feature['Teleport to Boards'] = menu.add_feature('Teleport to Boards', 'action', Script.Parent['Casino Heist Helper'], function()
        utility.tp(v3(2712.885, -369.604, -54.781), 1, -173.626159)
    end)

    Script.Feature['Teleport to Arcade'] = menu.add_feature('Teleport in front of Arcade', 'action_value_str', Script.Parent['Casino Heist Helper'], function(f)
        if f.value == 0 then
            utility.tp(v3(-618.422, 282.105, 81.661), 1, 0)

        elseif f.value == 1 then
            utility.tp(v3(-240.276, 6231.523, 31.5), 1, 0)

        elseif f.value == 2 then
            utility.tp(v3(1710.239, 4755.552, 41.968), 1, 0)

        elseif f.value == 3 then
            utility.tp(v3(-1289.597, -272.637, 38.934), 1, 0)

        elseif f.value == 4 then
            utility.tp(v3(-101.949, -1774.834, 29.503), 1, 0)

        else
            utility.tp(v3(722.069, -822.387, 24.694), 1, 0)
        end
    end)
    Script.Feature['Teleport to Arcade']:set_str_data({'West Vinewood', 'Paleto Bay', 'Grapeseed', 'Rockford Hills', 'Davis', 'La Mesa'})

    Script.Feature['Teleport to Casino Entrance'] = menu.add_feature('Teleport to Casino Entrance', 'action_value_str', Script.Parent['Casino Heist Helper'], function(f)
        if f.value == 0 then
            utility.tp(v3(915.411, 52.702, 80.899), 1, -106.415)

        elseif f.value == 1 then
            utility.tp(v3(977.744, 3.755, 81.149), 1, -4.723)

        elseif f.value == 2 then
            utility.tp(v3(1002.153, 86.149, 80.990), 1, 142.887)

        elseif f.value == 3 then
            utility.tp(v3(1031.371, -268.223, 50.855), 1, -1.479)

            coroutine.yield(2000)

            utility.tp(v3(995.416, -149.775, 34.597), 1, -1.479)

        elseif f.value == 4 then
            utility.tp(v3(998.007, -56.651, 74.959), 1, -1.479)
        end
    end)
    Script.Feature['Teleport to Casino Entrance']:set_str_data({'Main Door', 'Staff Lobby', 'Waste Disposal', 'Sewer Tunnel', 'Security Tunnel'})

    Script.Feature['Casino Vault Teleports'] = menu.add_feature('Vault Teleports', 'action_value_str', Script.Parent['Casino Heist Helper'], function(f)
        if f.value == 0 then
            utility.tp(v3(2467.166, -279.148, -70.694), 1, 0)

        elseif f.value == 1 then
            utility.tp(v3(2498.584, -238.633, -70.737), 1, 0)

        elseif f.value == 2 then
            utility.tp(v3(2516.404, -238.635, -70.737), 1, 0)
        end
    end)
    Script.Feature['Casino Vault Teleports']:set_str_data({'Key Card Door', 'Vault Entrance', 'Inside Vault'})


    Script.Parent['Perico Heist Helper'] = menu.add_feature('Cayo Perico Heist', 'parent', Script.Parent['Heist Helper'], nil).id

    Script.Feature['Teleport To Submarine'] = menu.add_feature("Teleport to own Submarine", 'action', Script.Parent['Perico Heist Helper'], function()
        local AllVehicles = vehicle.get_all_vehicles()

        for i = 1, #AllVehicles do
            local Vehicle = AllVehicles[i]
            local Interior = decorator.decor_get_int(Vehicle, "Player_Submarine")

            if Interior ~= 0 then
                local Position = entity.get_entity_coords(Vehicle)
                Position.z = 2

                local Heading = entity.get_entity_heading(Vehicle)
                utility.tp(utility.OffsetCoords(Position, Heading, 40), 3, Heading - 180)

                return
            end

        end

        Notify('Submarine not found.', "Error")
    end)

    Script.Feature['Teleport To Heist Table'] = menu.add_feature("Teleport to Heist-Table", 'action', Script.Parent['Perico Heist Helper'], function()
        utility.tp(v3(1561.042, 385.902, -49.685), 1, -178.7576)
    end)

    Script.Feature['Perico Entrance Points'] = menu.add_feature('Mansion Entrance Points', 'action_value_str', Script.Parent['Perico Heist Helper'], function(f)
        if f.value == 0 then
            utility.tp(v3(4964.224, -5691.346, 20.114), 1, -149.524)

        elseif f.value == 1 then
            utility.tp(v3(5034.285, -5682.308, 19.877), 1, 141.606)

        elseif f.value == 2 then
            utility.tp(v3(5087.291, -5729.972, 15.772), 1, 138.499)

        elseif f.value == 3 then
            utility.tp(v3(4991.473, -5811.451, 20.881), 1, -18.034)

        elseif f.value == 4 then
            utility.tp(v3(4957.278, -5784.729, 20.838), 1, -91.732)

        else
            utility.tp(v3(5044.107, -5816.188, -11.397), 1, 34.794)
        end
    end)
    Script.Feature['Perico Entrance Points']:set_str_data({'Main Gate', 'North Wall', 'North Gate', 'South Wall', 'South Gate', 'Drainage Tunnel'})

    Script.Feature['Perico Mansion Loot Locations'] = menu.add_feature('Mansion Loot Locations', 'action_value_str', Script.Parent['Perico Heist Helper'], function(f)
        if f.value == 0 then
            utility.tp(v3(5006.799, -5756.157, 15.484), 1, 140.548)

        elseif f.value == 1 then
            utility.tp(v3(5082.638, -5756.555, 15.829), 1, 48.199)

        elseif f.value == 2 then
            utility.tp(v3(5008.708, -5786.344, 17.831), 1, 97.236)
            
        elseif f.value == 3 then
            utility.tp(v3(5029.218, -5735.711, 17.865), 1, 137.546)

        elseif f.value == 4 then
            utility.tp(v3(5000.238, -5749.091, 14.840), 1, 123.632)

        else
            utility.tp(v3(5009.167, -5752.860, 28.845), 1, -122.300)
        end
    end)
    Script.Feature['Perico Mansion Loot Locations']:set_str_data({'Main Target', 'House 1', 'House 2', 'House 3', 'Underground Loot', 'El Rubios Office'})

    Script.Feature['Perico Mansion Escape Points'] = menu.add_feature('Mansion Escape Points', 'action_value_str', Script.Parent['Perico Heist Helper'], function(f)
        if f.value == 0 then
            utility.tp(v3(4991.798, -5719.567, 19.880), 1, 41.611)

        elseif f.value == 1 then
            utility.tp(v3(5029.085, -5688.222, 19.877), 1, -48.452)

        elseif f.value == 2 then
            utility.tp(v3(5084.531, -5738.770, 15.677), 1, 54.853)

        elseif f.value == 3 then
            utility.tp(v3(4995.140, -5803.547, 20.877), 1, 139.820)

        elseif f.value == 4 then
            utility.tp(v3(4965.731, -5786.062, 20.877), 1, 155.017)
        end
    end)
    Script.Feature['Perico Mansion Escape Points']:set_str_data({'Main Gate', 'North Wall', 'North Gate', 'South Wall', 'South Gate'})

    Script.Feature['Perico Escape Points'] = menu.add_feature('Perico Escape Points', 'action_value_str', Script.Parent['Perico Heist Helper'], function(f)
        if f.value == 0 then
            utility.tp(v3(4947.979, -5169.805, 2.526), 1, -23.566)

        elseif f.value == 1 then
            utility.tp(v3(5130.842, -4632.660, 1.442), 1, 173.827)

        elseif f.value == 2 then
            utility.tp(v3(4488.520, -4466.0366, 4.225), 1, 59.993)

        else
            utility.tp(v3(4321.404, -3933.961, -20.377), 1, 49.476)
        end
    end)
    Script.Feature['Perico Escape Points']:set_str_data({'Main Dock', 'North Dock', 'Airstrip', 'Kosatka'})

    Script.Feature['Perico Misc Locations'] = menu.add_feature('Misc Locations', 'action_value_str', Script.Parent['Perico Heist Helper'], function(f)
        if f.value == 0 then
            utility.tp(v3(4477.896, -4579.448, 5.567), 1, -172.023)

        elseif f.value == 1 then
            utility.tp(v3(4363.452, -4566.825, 4.207), 1, -157.731)
        end
    end)
    Script.Feature['Perico Misc Locations']:set_str_data({'Power Station', 'Control Tower'})


    Script.Parent['PTFX'] = menu.add_feature('PTFX', 'parent', Script.Parent['local_misc'], nil).id

    Script.Parent['New Years Eve'] = menu.add_feature('New years eve', 'value_i', Script.Parent['PTFX'], function(f)
        while f.on do
            local Position = get.OwnCoords() + v3(0, 0, 5)

            gameplay.shoot_single_bullet_between_coords(Position, Position + v3(math.random(-25, 25), math.random(-25, 25), math.random(50, 75)), 0, 0x7F7497E5, get.OwnPed(), true, false, 125)
            coroutine.yield(f.value)
        end
    end)
    Script.Parent['New Years Eve'].max = 500
    Script.Parent['New Years Eve'].mod = 25

    Script.Feature['Sparkling Ass'] = menu.add_feature('Sparkling Ass', 'toggle', Script.Parent['PTFX'], function(f)
        while f.on do
            graphics.set_next_ptfx_asset('scr_indep_fireworks')

            while not graphics.has_named_ptfx_asset_loaded('scr_indep_fireworks') do
                graphics.request_named_ptfx_asset('scr_indep_fireworks')
                coroutine.yield(0)
            end

            graphics.start_networked_particle_fx_non_looped_at_coord('scr_indep_firework_trail_spawn', get.OwnCoords(), v3(60, 0, 0), 0.33, true, true, true)
            coroutine.yield(25)
        end
    end)

    Script.Feature['Sparkling Tires'] = menu.add_feature('Sparkling Tires', 'toggle', Script.Parent['PTFX'], function(f)
        while f.on do
            local Vehicle = get.OwnVehicle()

            if Vehicle ~= 0 then
                local wheel_index = {'wheel_lf', 'wheel_rf', 'wheel_lr', 'wheel_rr'}

                for i = 1, #wheel_index do
                    local pos_obj = Spawn.Object(1803116220, get.OwnCoords())
                    entity.set_entity_collision(pos_obj, false, false, false)
                    entity.set_entity_visible(pos_obj, false)

                    local index = entity.get_entity_bone_index_by_name(Vehicle, wheel_index[i])
                    entity.attach_entity_to_entity(pos_obj, Vehicle, index, v3(), v3(), true, true, false, 0, true)
                    graphics.set_next_ptfx_asset('scr_indep_fireworks')
                    while not graphics.has_named_ptfx_asset_loaded('scr_indep_fireworks') do
                        graphics.request_named_ptfx_asset('scr_indep_fireworks')
                        coroutine.yield(0)
                    end
                    graphics.start_networked_particle_fx_non_looped_at_coord('scr_indep_firework_trail_spawn', entity.get_entity_coords(pos_obj), v3(60, 0, 0), 0.5, true, true, true)
                    utility.request_ctrl(pos_obj, 5)
                    entity.detach_entity(pos_obj)
                    entity.set_entity_velocity(pos_obj, v3())
                    utility.set_coords(pos_obj, v3(8000, 8000, -1000))
                    entity.delete_entity(pos_obj)
                end

                coroutine.yield(25)
            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Smoke Area'] = menu.add_feature('Smoke Area', 'toggle', Script.Parent['PTFX'], function(f)
        while f.on do
            for i = 1, 16 do

                local pos = get.OwnCoords()
                local rad = 2 * math.pi
                rad = rad / 16
                rad = rad * i
                pos.x = pos.x + (18 * math.cos(rad))
                pos.y = pos.y + (18 * math.sin(rad))
                pos.z = pos.z - 2.5

                graphics.set_next_ptfx_asset('scr_recartheft')

                while not graphics.has_named_ptfx_asset_loaded('scr_recartheft') do
                    graphics.request_named_ptfx_asset('scr_recartheft')
                    coroutine.yield(0)
                end

                graphics.start_networked_particle_fx_non_looped_at_coord('scr_wheel_burnout', pos, v3(), 2.5, true, true, true)

                coroutine.yield(40)
            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Fire Circle'] = menu.add_feature('Fire Circle', 'toggle', Script.Parent['PTFX'], function(f)
        while f.on do
            if ptfxs['fire_balls'][1] == nil then
                for i = 1, 48 do
                    ptfxs['fire_balls'][i] = Spawn.Object(1803116220, get.OwnCoords())
                    entity.set_entity_collision(ptfxs['fire_balls'][i], false, false, false)
                    entity.set_entity_visible(ptfxs['fire_balls'][i], false)
                end
            end

            for i = 1, 48 do
                local pos = get.OwnCoords()
                local rad = 2 * math.pi
                rad = rad / 48
                rad = rad * math.random(1, 48)
                pos.x = pos.x + (10 * math.cos(rad))
                pos.y = pos.y + (10 * math.sin(rad))
                pos.z = pos.z - 1.5
                utility.set_coords(ptfxs['fire_balls'][i], pos)
            end

            coroutine.yield(10)

            if ptfxs['fire_circle'][1] == nil then
                for i = 1, 48 do
                    graphics.set_next_ptfx_asset('weap_xs_vehicle_weapons')
                    while not graphics.has_named_ptfx_asset_loaded('weap_xs_vehicle_weapons') do
                        graphics.request_named_ptfx_asset('weap_xs_vehicle_weapons')
                        coroutine.yield(0)
                    end
                    ptfxs['fire_circle'][i] = graphics.start_networked_ptfx_looped_on_entity('muz_xs_turret_flamethrower_looping', ptfxs['fire_balls'][i], v3(), v3(90, 0, 0), 1)
                end
            end

            coroutine.yield(0)
        end

        utility.clear(ptfxs['fire_balls'])
        ptfxs['fire_balls'] = {}

        if ptfxs['fire_circle'][1] then
            for i = 1, #ptfxs['fire_circle'] do
                graphics.remove_particle_fx(ptfxs['fire_circle'][i], true)
            end

            ptfxs['fire_circle'] = {}
        end
    end)

    Script.Feature['Fire Fart'] = menu.add_feature('Fire Fart', 'action_value_i', Script.Parent['PTFX'], function(f)
        if get.OwnVehicle() ~= 0 then
            Notify('Fire Fart in a vehicle is too dangerous, get out!', "Error")
        else
            local hash = 0x187D938D
            local dict = 'weap_xs_vehicle_weapons'
            local anim = 'muz_xs_turret_flamethrower_looping'
            local heading = get.OwnHeading()
            local spawned_veh = Spawn.Vehicle(hash, get.OwnCoords(), heading)
            utility.request_ctrl(spawned_veh)
            entity.set_entity_visible(spawned_veh, false)
            decorator.decor_set_int(spawned_veh, 'MPBitset', 1 << 10)
            ped.set_ped_into_vehicle(get.OwnPed(), spawned_veh, -1)
            coroutine.yield(500)
            graphics.set_next_ptfx_asset(dict)
            while not graphics.has_named_ptfx_asset_loaded(dict) do
                graphics.request_named_ptfx_asset(dict)
                coroutine.yield(0)
            end
            local mult = f.value
            local fire = graphics.start_networked_ptfx_looped_on_entity(anim, get.OwnPed(), v3(), v3(180, 0, 0), mult * 0.1)
            local pos = entity.get_entity_coords(spawned_veh)
            local rot = entity.get_entity_rotation(spawned_veh)
            local dir = rot
            dir:transformRotToDir()
            dir = dir * (1 * mult)
            dir.z = pos.z + 0.6666666 * mult
            local vec = dir
            entity.set_entity_velocity(spawned_veh, vec)
            coroutine.yield(250 * mult)
            graphics.remove_particle_fx(fire, true)
            while ped.is_ped_in_any_vehicle(get.OwnPed()) do
                ai.task_leave_vehicle(get.OwnPed(), spawned_veh, 16)
                coroutine.yield(25)
            end

            utility.clear({spawned_veh})
        end
    end)
    Script.Feature['Fire Fart'].max = 16
    Script.Feature['Fire Fart'].min = 4

    Script.Feature['Fire Ass'] = menu.add_feature('Fire Ass', 'toggle', Script.Parent['PTFX'], function(f)
        while f.on do

            if ptfxs['fire_ass_ball'] == nil then
                ptfxs['fire_ass_ball'] = Spawn.Object(1803116220, get.OwnCoords())
                entity.set_entity_collision(ptfxs['fire_ass_ball'], false, false, false)
                entity.set_entity_visible(ptfxs['fire_ass_ball'], false)
            end

            if ptfxs['fire_ass'] == nil then
                local dict = 'weap_xs_vehicle_weapons'
                local anim = 'muz_xs_turret_flamethrower_looping'
                graphics.set_next_ptfx_asset(dict)
                while not graphics.has_named_ptfx_asset_loaded(dict) do
                    graphics.request_named_ptfx_asset(dict)
                    coroutine.yield(0)
                end
                ptfxs['fire_ass'] = graphics.start_networked_ptfx_looped_on_entity(anim, get.OwnPed(), v3(), v3(180, 0, 0), 0.333)
            end

            local pos = get.OwnCoords()
            utility.set_coords(ptfxs['fire_ass_ball'], get.OwnCoords())

            coroutine.yield(0)
        end

        if ptfxs['fire_ass'] then
            graphics.remove_particle_fx(ptfxs['fire_ass'], true)
            ptfxs['fire_ass'] = nil
        end

        utility.clear({ptfxs['fire_ass_ball']})
        ptfxs['fire_ass_ball'] = nil
    end)


    Script.Parent['Disable HUD Components'] = menu.add_feature('Hide HUD Elements', 'parent', Script.Parent['local_misc'], nil).id

    Script.Feature['Disable Mini-Map'] = menu.add_feature('Disable All + Minimap', 'toggle', Script.Parent['Disable HUD Components'], function(f)
        while f.on do
            ui.hide_hud_and_radar_this_frame()

            coroutine.yield(0)
        end
    end)

    for i = 1, #miscdata.hudcomponents do
        Script.Feature[miscdata.hudcomponents[i][1]] = menu.add_feature(miscdata.hudcomponents[i][1], 'toggle', Script.Parent['Disable HUD Components'], function(f)
            while f.on do
                ui.hide_hud_component_this_frame(miscdata.hudcomponents[i][2])

                coroutine.yield(0)
            end
        end)
    end

    Script.Feature['Teleport High In Air'] = menu.add_feature('Teleport High in Air', 'action', Script.Parent['local_misc'], function()
        local pos = get.OwnCoords() + v3(0, 0, 5000)
        
        utility.tp(pos)
    end)

    Script.Feature['Teleport Forward'] = menu.add_feature('Teleport Forward', 'action', Script.Parent['local_misc'], function()
        local veh = get.OwnVehicle()
        if veh ~= 0 then
            local speed = entity.get_entity_speed(veh)
            utility.set_coords(veh, utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 8))
            vehicle.set_vehicle_forward_speed(veh, speed)
        else
            utility.set_coords(get.OwnPed(), utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 8))
        end
    end)


    Script.Feature['Auto TP Waypoint'] = menu.add_feature('Auto Teleport to Waypoint', 'toggle', Script.Parent['local_misc'], function(f)
        settings['Auto TP Waypoint'] = {Enabled = f.on}
        while f.on do
            local waypoint = ui.get_waypoint_coord()
            if waypoint.x ~= 16000 then
                if not network.is_session_started() then
                    local pos = get.OwnCoords()
                    local v2pos = v2()
                    v2pos.x = pos.x
                    v2pos.y = pos.y
                    if waypoint:magnitude(v2pos) > 35 then
                        local ground = Math.GetGroundZ(waypoint.x, waypoint.y)
                        utility.tp(v3(waypoint.x, waypoint.y, ground))
                    end
                    return
                end
                local target = get.OwnPed()
                if get.OwnVehicle() ~= 0 then
                    target = get.OwnVehicle()
                end
                local height = 1000
                entity.set_entity_coords_no_offset(target, v3(waypoint.x, waypoint.y, height))
                local success, ground = gameplay.get_ground_z(v3(waypoint.x, waypoint.y, height))
                while not success and height > 100 do
                    height = height - 5
                    entity.set_entity_coords_no_offset(target, v3(waypoint.x, waypoint.y, height))
                    success, ground = gameplay.get_ground_z(v3(waypoint.x, waypoint.y, height))
                end
                if height <= 100 then
                    height = 0
                    local success, ground = gameplay.get_ground_z(v3(waypoint.x, waypoint.y, height))
                    while not success and height < 1000 do
                        height = height + 10
                        success, ground = gameplay.get_ground_z(v3(waypoint.x, waypoint.y, height))
                    end
                end
                entity.set_entity_coords_no_offset(target, v3(waypoint.x, waypoint.y, ground + 1))
            end
            coroutine.yield(0)
        end
        settings['Auto TP Waypoint'].Enabled = f.on
    end)

    Script.Feature['Fake Ban Screen'] = menu.add_feature('Fake Ban Screen', 'toggle', Script.Parent['local_misc'], function(f)
        while f.on do
            local pos = v2()
            local pos2 = v2()
            local pos3 = v2()
            pos.x = 0.5
            pos.y = 0.325
            pos2.x = 0.5
            pos2.y = 0.5
            pos3.x = 0.5
            pos3.y = 0.54
            ui.set_text_scale(3.0)
            ui.set_text_font(7)
            ui.set_text_centre(0)
            ui.set_text_color(255, 206, 67, 255)
            ui.set_text_outline(true)
            ui.draw_text('alert', pos)
            ui.set_text_scale(0.5)
            ui.set_text_centre(0)
            ui.set_text_color(255, 255, 255, 255)
            ui.draw_text('You have been banned from Grand Theft Auto Online permanently', pos2)
            ui.set_text_scale(0.5)
            ui.set_text_centre(0)
            ui.draw_text('Return to Grand Theft Auto V', pos3)
            ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
            ui.draw_rect(.5, .492, .52, .0019, 255, 255, 255, 255)
            ui.draw_rect(.5, .585, .52, .0019, 255, 255, 255, 255)
            coroutine.yield(0)
        end
    end)

    Script.Feature['Lag out of Session'] = menu.add_feature('Lag out of Session', 'action', Script.Parent['local_misc'], function()
        local time = utils.time_ms() + 8500
        while time > utils.time_ms() do
        end
    end)


    Script.Parent['Menu Console'] = menu.add_feature('Menu Console', 'parent', Script.Parent['local_settings'], function()
        Notify('The lua Debug Console must be open for this!', "Neutral")
    end).id

    Script.Feature['Print Scriptlog'] = menu.add_feature('Print Script Notifications', 'toggle', Script.Parent['Menu Console'], function(f)
        settings['Print Scriptlog'] = {Enabled = f.on}
    end)

    Script.Feature['Print Chat'] = menu.add_feature('Print Chat', 'toggle', Script.Parent['Menu Console'], function(f)
        settings['Print Chat'] = {Enabled = f.on}
    end)

    Script.Feature['Print Joining Players'] = menu.add_feature('Print Joining Players', 'toggle', Script.Parent['Menu Console'], function(f)
        settings['Print Joining Players'] = {Enabled = f.on}
    end)

    Script.Feature['Print Leaving Players'] = menu.add_feature('Print Leaving Players', 'toggle', Script.Parent['Menu Console'], function(f)
        settings['Print Leaving Players'] = {Enabled = f.on}
    end)

    Script.Feature['Print Modder Detections'] = menu.add_feature('Print Modder Detections', 'toggle', Script.Parent['Menu Console'], function(f)
        settings['Print Modder Detections'] = {Enabled = f.on}
    end)


    Script.Parent['Log Settings'] = menu.add_feature('Log Settings', 'parent', Script.Parent['local_settings'], nil).id

    Script.Feature['Enable Script log'] = menu.add_feature('Enable Script logs', 'toggle', Script.Parent['Log Settings'], function(f)
        settings['Enable Script log'] = {Enabled = f.on}
        if not f.on then
            ToggleOff({'Log Modder Detections', 'Log Chat'})
        end
    end)
    Script.Feature['Enable Script log'].on = true

    Script.Feature['Log Modder Detections'] = menu.add_feature('Log Modder Detections', 'toggle', Script.Parent['Log Settings'], function(f)
        settings['Log Modder Detections'] = {Enabled = f.on}
    end)


    Script.Feature['Log Chat'] = menu.add_feature('Log Chat', 'toggle', Script.Parent['Log Settings'], function(f)
        settings['Log Chat'] = {Enabled = f.on}
    end)

    Script.Feature['Clear Script Logs'] = menu.add_feature('Clear Script Logs', 'action_value_str', Script.Parent['Log Settings'], function(f)
        local filename
        if f.value == 0 then
            filename = 'MainLog'
        elseif f.value == 1 then
            filename = 'ChatLog'
        else
            filename = 'SELog'
        end

        if utils.file_exists(files[filename]) then
            utility.write(io.open(files[filename], 'w'), 'File cleared')
            Notify('Log File cleared.', "Success", '')
        else
            Notify('Log File not found.', "Error", '')
        end
    end)
    Script.Feature['Clear Script Logs']:set_str_data({'2Take1Script.log', 'Chat.log', 'ScriptEvents.log'})

    Script.Feature['Clear Menu Logs'] = menu.add_feature('Clear Menu Logs', 'action_value_str', Script.Parent['Log Settings'], function(f)
        local filename
        if f.value == 0 then
            filename = 'MenuMainLog'
        elseif f.value == 1 then
            filename = 'MenuPrepLog'
        elseif f.value == 2 then
            filename = 'MenuNetLog'
        elseif f.value == 3 then
            filename = 'MenuNotifLog'
        elseif f.value == 4 then
            filename = 'MenuPlayerLog'
        else
            filename = 'MenuScriptLog'
        end

        if utils.file_exists(files[filename]) then
            utility.write(io.open(files[filename], 'w'), 'File cleared by 2Take1Script')
            Notify('Log File cleared.', "Success", '')
            Log('Log File "' .. filename ..'" cleared.')
        else
            Notify('Log File not found.', "Error", '')
        end
    end)
    Script.Feature['Clear Menu Logs']:set_str_data({'2Take1Menu.log', '2Take1Prep.log', 'net_events.log', 'notification.log', 'player.log', 'script_event.log'})


    Script.Parent['Notification Settings'] = menu.add_feature('Notification Settings', 'parent', Script.Parent['local_settings'], nil).id

    Script.Feature['Enable Script Notifications'] = menu.add_feature('Enable Script Notifications', 'toggle', Script.Parent['Notification Settings'], function(f)
        settings['Enable Script Notifications'] = {Enabled = f.on}
    end)
    Script.Feature['Enable Script Notifications'].on = true

    Script.Feature['Notification Duration'] = menu.add_feature('Notification Duration (sec)', 'autoaction_value_i', Script.Parent['Notification Settings'], function(f)
        settings['Notification Duration'] = {Value = f.value}
    end)
    Script.Feature['Notification Duration'].min = 1
    Script.Feature['Notification Duration'].max = 10
    Script.Feature['Notification Duration'].value = 8

    Script.Feature['Success Notification Color'] = menu.add_feature('Success Notification Color', 'autoaction_value_str', Script.Parent['Notification Settings'], function(f)
        settings['Success Notification Color'] = {Value = f.value}
    end)
    Script.Feature['Success Notification Color']:set_str_data({'Green', 'Yellow', 'Red', 'Blue', 'Purple', 'Orange', 'Cyan'})
    Script.Feature['Success Notification Color'].value = 0

    Script.Feature['Neutral Notification Color'] = menu.add_feature('Neutral Notification Color', 'autoaction_value_str', Script.Parent['Notification Settings'], function(f)
        settings['Neutral Notification Color'] = {Value = f.value}
    end)
    Script.Feature['Neutral Notification Color']:set_str_data({'Green', 'Yellow', 'Red', 'Blue', 'Purple', 'Orange', 'Cyan'})
    Script.Feature['Neutral Notification Color'].value = 1

    Script.Feature['Error Notification Color'] = menu.add_feature('Error Notification Color', 'autoaction_value_str', Script.Parent['Notification Settings'], function(f)
        settings['Error Notification Color'] = {Value = f.value}
    end)
    Script.Feature['Error Notification Color']:set_str_data({'Green', 'Yellow', 'Red', 'Blue', 'Purple', 'Orange', 'Cyan'})
    Script.Feature['Error Notification Color'].value = 2

    Script.Feature['Exclude Friends'] = menu.add_feature('Exclude Friends from Harmful Lobby Events', 'toggle', Script.Parent['local_settings'], function(f)
        settings['Exclude Friends'] = {Enabled = f.on}
    end)

    Script.Feature['Disable Warning Messages'] = menu.add_feature('Disable Warning Messages', 'toggle', Script.Parent['local_settings'], function(f)
        settings['Disable Warning Messages'] = {Enabled = f.on}
    end)

    Script.Feature['2Take1Script Parent'] = menu.add_feature('2Take1Script Parent', 'toggle', Script.Parent['local_settings'], function(f)
        settings['2Take1Script Parent'] = {Enabled = f.on}
    end)
    Script.Feature['2Take1Script Parent'].on = true


    Script.Parent['Setting Profiles'] = menu.add_feature('Setting Profiles', 'parent', Script.Parent['local_settings'], nil).id

    Script.Feature['Settings Add Profile'] = menu.add_feature('Add Profile', 'action', Script.Parent['Setting Profiles'], function()
        local Name = get.Input('Enter Profile Name', 25, 2, 'Name')

        if not Name then
            Notify('Input canceled.', "Error", '')
            return
        end

        local File = paths['ScriptSettings'] .. '\\' .. Name .. '.ini'
        setup.SaveSettings(File)

        Log('Profile ' .. Name ..  ' Successfully created!')
        Notify('Profile ' .. Name ..  ' Successfully created!', "Success")

        Script.Feature['Profile ' .. Name] = menu.add_feature(Name, 'action_value_str', Script.Parent['Setting Profiles'], function(f)
            if f.value == 0 then
                setup.SaveSettings(File)

                Log('Settings saved to File.')
                Notify('Settings saved to File.', "Success")

            elseif f.value == 1 then
                setup.LoadSettings(File)

                Log('Settings Successfully Loaded!')
                Notify('Settings Successfully Loaded!', "Success")
                
            elseif f.value == 2 then
                local NewName = get.Input('Enter Profile Name', 25, 2, 'Name')

                if not NewName then
                    Notify('Input canceled.')
                    return
                end

                setup.Rename(File, Name, NewName)
            else
                io.remove(File)
                menu.delete_feature(f.id)
            end
        end)
        Script.Feature['Profile ' .. Name]:set_str_data({'Save', 'Load', 'Rename', 'Delete'})
    end)

    Script.Feature['Save Default'] = menu.add_feature('Default', 'action_value_str', Script.Parent['Setting Profiles'], function(f)
        if f.value == 0 then
            setup.SaveSettings()
            Log('Settings saved to File.')
            Notify('Settings saved to File.', "Success")
        else
            setup.LoadSettings()
            Log('Settings Successfully Loaded!')
            Notify('Settings Successfully Loaded!', "Success")
        end
    end)
    Script.Feature['Save Default']:set_str_data({'Save', 'Load'})

    local configfiles = utils.get_all_files_in_directory(paths['ScriptSettings'], 'ini')
    for i = 1, #configfiles do
        if configfiles[i] ~= 'Default.ini' then
            local Name = configfiles[i]:sub(1, -5)

            Script.Feature['Profile ' .. Name] = menu.add_feature(Name, 'action_value_str', Script.Parent['Setting Profiles'], function(f)
                local File = paths['ScriptSettings'] .. '\\' .. Name .. '.ini'
                if f.value == 0 then
                    setup.SaveSettings(File)
                    Log('Settings saved to File.')
                    Notify('Settings saved to File.', "Success")
                elseif f.value == 1 then
                    setup.LoadSettings(File)
                    Log('Settings Successfully Loaded!')
                    Notify('Settings Successfully Loaded!', "Success")
                elseif f.value == 2 then
                    local NewName = get.Input('Enter Profile Name', 25, 2, 'Name')
    
                    if not NewName then
                        Notify('Input canceled.')
                        return
                    end
    
                    setup.Rename(File, Name, NewName)
                else
                    io.remove(File)
                    menu.delete_feature(f.id)
                end
            end)
            Script.Feature['Profile ' .. Name]:set_str_data({'Save', 'Load', 'Rename', 'Delete'})
        end
    end

-- Player Features

    Script.Parent['Player Utils'] = menu.add_player_feature('Player Utils', 'parent', Script.playerparent, nil).id

    Script.Feature['Player Waypoint'] = menu.add_player_feature('Waypoint Player', 'toggle', Script.Parent['Player Utils'], function(f, id)
        if id == player.player_id() then
            Notify('No need to do that.', "Error", '')
            f.on = false
            return
        end
        
        while f.on do
            local pos = get.PlayerCoords(id)
            ui.set_new_waypoint(v2(pos.x, pos.y))
            coroutine.yield(500)
        end

       ui.set_waypoint_off()
    end)

    Script.Feature['Player Teleport'] = menu.add_player_feature('TP to Player', 'action', Script.Parent['Player Utils'], function(f, id)
        if id == player.player_id() then
            Notify('No need to do that.', "Error", '')
            return
        end
        
        utility.tp(get.PlayerCoords(id), 3)
    end)

    Script.Feature['Player Teleport 2'] = menu.add_player_feature('Parachute to Player', 'action', Script.Parent['Player Utils'], function(f, id)
        if id == player.player_id() then
            Notify('No need to do that.', "Error", '')
            return
        end

        local Ped = get.OwnPed()
        if not weapon.has_ped_got_weapon(Ped, 0xFBAB5776) then
            weapon.give_delayed_weapon_to_ped(Ped, 0xFBAB5776, 1, 1)
        end

        if get.OwnVehicle() ~= 0 then
            ped.clear_ped_tasks_immediately(Ped)
        end

        local coords = utility.OffsetCoords(get.PlayerCoords(id), get.PlayerHeading(id), -200)
        coords.z = Math.GetGroundZ(coords.x, coords.y) + 120

        utility.tp(coords, 3)
    end)

    Script.Feature['Copy to Clipboard'] = menu.add_player_feature('Copy Info to Clipboard', 'action_value_str', Script.Parent['Player Utils'], function(f, id)
        if f.value == 0 then
            utils.to_clipboard(tostring(get.Name(id)))
        elseif f.value == 1 then
            utils.to_clipboard(get.SCID(id))
        elseif f.value == 2 then
            utils.to_clipboard(tostring(get.IP(id)))
        elseif f.value == 3 then
            utils.to_clipboard(Math.DecToHex2(get.HostToken(id)))
        end
        
        Notify('Info copied to clipboard', "Success", '')
    end)
    Script.Feature['Copy to Clipboard']:set_str_data({'Name', 'SCID', 'IP', 'Host Token'})

    Script.Feature['Player Add Fake Friends'] = menu.add_player_feature("Add to Fake Friends", "action_value_str", Script.Parent['Player Utils'], function(f, id)
        if id == player.player_id() then
            Notify('No need to do that.', "Error", '')
            return
        end

        if IsFakeFriend(id) then
            Notify('Player already exists in your Fake Friends!', "Error")
        else
            if f.value == 0 then
                utility.write(io.open(files['FakeFriends'], 'a'), get.Name(id) .. ':' .. Math.DecToHex(get.SCID(id)) .. ":c")
                Notify("Added " .. get.Name(id) .. " to the Fake Friends\nReinject the Menu for it to take effect", "Success")
            end
            if f.value == 1 then
                utility.write(io.open(files['FakeFriends'], 'a'), get.Name(id) .. ':' .. Math.DecToHex(get.SCID(id)) .. ":11")
                Notify("Added " .. get.Name(id) .. " to the Fake Friends\nReinject the Menu for it to take effect", "Success")
            end
            if f.value == 2 then
                utility.write(io.open(files['FakeFriends'], 'a'), get.Name(id) .. ':' .. Math.DecToHex(get.SCID(id)) .. ":1")
                Notify("Added " .. get.Name(id) .. " to the Fake Friends\nReinject the Menu for it to take effect", "Success")
            end
        end
    end)
	Script.Feature['Player Add Fake Friends']:set_str_data({"Blacklist + Hidden", "Friend List + Stalk", "Stalk"})

    Script.Feature['Player Remove Fake Friends'] = menu.add_player_feature("Remove from Fake Friends", "action", Script.Parent['Player Utils'], function(f, id)
        local blacklist = {}
        for line in io.lines(files['FakeFriends']) do
            local parts = {}
            for part in line:gmatch("[^:]+") do
                parts[#parts + 1] = part
            end
            if #parts >= 2 then
                local name = parts[1]
                local scid = tonumber(parts[2], 16)
                local flag = parts[3]
                blacklist[name] = {Name=name, SCID=scid, Flag=flag}
            end
        end
        if blacklist[get.Name(id)] and blacklist[get.Name(id)].SCID == get.SCID(id) then
            blacklist[get.Name(id)] = nil
        else
            Notify('Player not found.', "Error", '')
            return
        end

        blacklist['[SCID]'] = nil
        utility.write(io.open(files['FakeFriends'], 'w'), '[SCID]')
        for k in pairs(blacklist) do
            utility.write(io.open(files['FakeFriends'], 'a'), blacklist[k].Name .. ':' .. Math.DecToHex(blacklist[k].SCID) .. ':' .. blacklist[k].Flag)
        end
        Notify(get.Name(id) .. " has been removed from the Fake Friends\nReinject the Menu for it to take effect", "Success")
    end)

    Script.Feature['Add to Player Blacklist'] = menu.add_player_feature('Add to Player Blacklist', 'action', Script.Parent['Player Utils'], function(pf, id)
        if id == player.player_id() then
            Notify('No need to do that.', "Error", '')
            return
        end

        local blacklist = {}
        local name = get.Name(id)
        local scid = get.SCID(id)
        local ip = get.IP(id)

        if not utils.file_exists(files['Blacklist']) then
            goto continue
        end

        for line in io.lines(files['Blacklist']) do
            blacklist[line] = true
        end
        
        if blacklist[name .. ':' .. scid .. ':' .. ip] then
            Notify('Player already exists in the blacklist', "Error", '')
            return
        end

        ::continue::
        utility.write(io.open(files['Blacklist'], 'a'), name .. ':' .. scid .. ':' .. ip)

        Script.Feature[name .. '/' .. scid] = menu.add_feature(name, 'action_value_str',  Script.Parent['Player Blacklist Profiles'], function(f)
            if f.value == 0 then
                Notify('Name: ' .. name .. '\nSCID: ' .. scid .. '\nIP: ' .. ip, "Success", '2Take1Script Player Blacklist')
            else
                blacklist[name .. ':' .. scid .. ':' .. ip] = nil

                utility.write(io.open(files['Blacklist'], 'w'))
                for k in pairs(blacklist) do
                    utility.write(io.open(files['Blacklist'], 'a'), k)
                end
                menu.delete_feature(f.id)
                Notify('Entry Deleted', "Success", '2Take1Script Player Blacklist')
            end
        end)
        Script.Feature[name .. '/' .. scid]:set_str_data({'Show Info', 'Delete'})
    
        Notify('Player added to Blacklist.', "Success", '2Take1Script Player Blacklist')
    end)


    Script.Parent['Player Vehicle'] = menu.add_player_feature('Vehicle Options', 'parent', Script.playerparent, nil).id

    Script.Feature['Player Remote Control'] = menu.add_player_feature('Remote Control Vehicle', 'toggle', Script.Parent['Player Vehicle'], function(f, id)
        for i = 0, 31 do
            if i ~= id and player.is_player_valid(i) and Script.Feature['Player Remote Control'].on[i] then
                Notify('Feature is already on for another Player.', "Error", '')
                f.on = false
                return
            end
        end

        if id == player.player_id() then
            Notify('No point in doing this on yourself', "Error", '')
            f.on = false
            return
        end

        if network.get_player_player_is_spectating(player.player_id()) ~= nil then
            Notify('This doesnt work properly while specating someone', "Error", '')
            f.on = false
            return
        end

        local Ped = get.OwnPed()
        if interior.get_interior_from_entity(Ped) ~= 0 then
            Notify('This doesnt work while inside of a building', "Error", '')
            f.on = false
            return
        end

        local Target = get.PlayerVehicle(id)
        if Target == 0 then
            Notify('No vehicle found.', "Error", '')
            f.on = false
            return
        end

        if not utility.request_ctrl(Target, 5000) then
            Notify('Failed to gain control over the Players vehicle.', "Error", '')
            f.on = false
            return
        end

        local Hash = entity.get_entity_model_hash(Target)
        local Vehicle = Spawn.Vehicle(Hash, get.OwnCoords())

        decorator.decor_set_int(Vehicle, 'MPBitset', 1 << 10)
        utility.SetVehicleMods(Vehicle, utility.GetVehicleMods(Target), false)
        vehicle.set_vehicle_number_plate_index(Vehicle, 0)
        vehicle.set_vehicle_number_plate_text(Vehicle, ' ')

        ped.set_ped_into_vehicle(Ped, Vehicle, -1)
        utility.request_ctrl(Vehicle, 100)

        utility.set_coords(Vehicle, entity.get_entity_coords(Target))
        entity.set_entity_rotation(Vehicle, entity.get_entity_rotation(Target))
        entity.set_entity_collision(Vehicle, false, false, 0)
        entity.attach_entity_to_entity(Target, Vehicle, 0, v3(), v3(), true, false, false, 0, true)
        entity.set_entity_collision(Vehicle, true, true, 0)

        while f.on do
            utility.request_ctrl(Target)
            vehicle.set_vehicle_number_plate_index(Vehicle, 0)
            vehicle.set_vehicle_number_plate_text(Target, ' ')
            coroutine.yield(0)
        end

        local Speed = entity.get_entity_speed(Vehicle)
        local Coords = entity.get_entity_coords(Vehicle)
        Coords.z = Math.GetGroundZ(Coords.x, Coords.y)
        
        ped.clear_ped_tasks_immediately(Ped)
        utility.clear(Vehicle)
        coroutine.yield(200)

        entity.set_entity_coords_no_offset(Target, Coords + v3(0, 0, 2))
        coroutine.yield(200)

        vehicle.set_vehicle_forward_speed(Target, Speed)
        entity.set_entity_collision(Vehicle, true, true, 0)
    end)


    Script.Parent['Player Ramp Builder'] = menu.add_player_feature('Ramp Spawner', 'parent', Script.Parent['Player Vehicle'], nil).id

    Script.Feature['Player Ramp Builder Invisible'] = menu.add_player_feature('Spawn Invisible', 'toggle', Script.Parent['Player Ramp Builder'], function(f)
        settings['Player Ramp Builder Invisible'] = {Enabled = f.on}
    end)

    Script.Feature['Player Ramp Builder Remove'] = menu.add_player_feature('Delete Ramps', 'action', Script.Parent['Player Ramp Builder'], function(f, id)
        local veh = get.PlayerVehicle(id)

        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        local objects = object.get_all_objects()
        for i = 1, #objects do
            if entity.get_entity_attached_to(objects[i]) == veh then
                local hash = entity.get_entity_model_hash(objects[i])
                if hash == 2934970695 or hash == 3233397978 or hash == 1290523964 then
                    utility.clear(objects[i])
                end
            end
        end
    end)

    for ramps = 1, #miscdata.ramps.versions do
        Script.Feature['Player Ramp Builder ' .. miscdata.ramps.versions[ramps][1]] = menu.add_player_feature(miscdata.ramps.versions[ramps][1] .. ' Ramp', 'action_value_str', Script.Parent['Player Ramp Builder'], function(f, id)
            local hash = miscdata.ramps[f.value + 1]
            local veh = get.PlayerVehicle(id)

            if veh == 0 then
                Notify('No vehicle found.', "Error", '')
                return
            end

            if not utility.request_ctrl(veh, 5000) then
                Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
                return
            end

            local ramp = Spawn.Object(hash, v3())
            entity.attach_entity_to_entity(ramp, veh, 0, miscdata.ramps.versions[ramps][2], miscdata.ramps.versions[ramps][3], true, true, false, 0, true)
            if Script.Feature['Player Ramp Builder Invisible'].on[id] then
                entity.set_entity_visible(ramp, false)
            end 
        end)
        Script.Feature['Player Ramp Builder ' .. miscdata.ramps.versions[ramps][1]]:set_str_data({'Small', 'Medium', 'Big'})
    end

    Script.Feature['Player Teleport Vehicle'] = menu.add_player_feature("Teleport Vehicle", "action_value_str", Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if f.value == 3 then
            local _input1 = get.Input('Enter X coordinate', 20, 3)
            if not _input1 then
                Notify('Input canceled.', "Error", '')
                return
            end

            local _input2 = tonumber(get.Input('Enter Y coordinate', 20, 3))
            if not _input2 then
                Notify('Input canceled.', "Error", '')
                return
            end

            local _input3 = tonumber(get.Input('Enter Z coordinate', 20, 3))
            if not _input3 then
                Notify('Input canceled.', "Error", '')
                return
            end

            if not utility.request_ctrl(veh, 5000) then
                Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
            end
            
            utility.set_coords(veh, v3(_input1, _input2, _input3))
            
        else
            if not utility.request_ctrl(veh, 5000) then
                Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
            end

            if f.value == 0 then
                utility.set_coords(veh, utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 5))
            elseif f.value == 1 then

                utility.set_coords(veh, v3(120, -25, -50))
            elseif f.value == 2 then

                utility.set_coords(veh, v3(10000, -10000, 0))
            end
        end
    end)
	Script.Feature['Player Teleport Vehicle']:set_str_data({'To Me', 'Underground', 'Ocean', 'Custom Coords'})

    Script.Feature['Player Vehicle Godmode'] = menu.add_player_feature("Vehicle Godmode", "action_value_str", Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end

        if f.value == 0 then
            if entity.get_entity_god_mode(veh) then
                Notify('Players vehicle is already in godmode.', "Error", '')
                return
            end

            entity.set_entity_god_mode(veh, true) 
            
        elseif f.value == 1 then
            if not entity.get_entity_god_mode(veh) then
                Notify('Players vehicle is not in godmode.', "Error", '')
                return
            end

            entity.set_entity_god_mode(veh, false)
        end
    end)
	Script.Feature['Player Vehicle Godmode']:set_str_data({"Give", "Remove"})

    Script.Feature['Player Prevent Lock-On'] = menu.add_player_feature('Prevent Lock-On', 'action_value_str', Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end

        if f.value == 0 then
            vehicle.set_vehicle_can_be_locked_on(veh, false, false)
        elseif f.value == 1 then
            vehicle.set_vehicle_can_be_locked_on(veh, true, true)
        end
    end)
    Script.Feature['Player Prevent Lock-On']:set_str_data({'Enable', 'Disable'})

    Script.Feature['Player Upgrade Vehicle'] = menu.add_player_feature("Upgrade Vehicle", "action_value_str", Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end

        utility.MaxVehicle(veh, f.value + 1)
    end)
    Script.Feature['Player Upgrade Vehicle']:set_str_data({'Full', 'Performance', 'Random'})

    Script.Feature['Player Downgrade Vehicle'] = menu.add_player_feature("Downgrade Vehicle", "action_value_str", Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end

        vehicle.set_vehicle_mod_kit_type(veh, 0)
        if f.value == 0 then
            for i = 0, 47 do
                vehicle.set_vehicle_mod(veh, i, -1, false)
                vehicle.toggle_vehicle_mod(veh, i, false)
            end

            vehicle.set_vehicle_bulletproof_tires(veh, false)
            vehicle.set_vehicle_window_tint(veh, 0)
            vehicle.set_vehicle_number_plate_index(veh, 0)
        else
            local upgrades = {11, 12, 13, 15, 16}
            for i = 1, #upgrades do
                vehicle.set_vehicle_mod(veh, upgrades[i], -1, false)
            end
            vehicle.toggle_vehicle_mod(veh, 18, false)
            vehicle.set_vehicle_bulletproof_tires(veh, false)
        end

    end)
    Script.Feature['Player Downgrade Vehicle']:set_str_data({'Full', 'Performance'})

    Script.Feature['Player Clone Vehicle'] = menu.add_player_feature("Clone Vehicle", "action_value_str", Script.Parent['Player Vehicle'], function(f, id)
        local veh
        if f.value == 0 then
            veh = get.PlayerVehicle(id)
        else
            veh = scriptevent.GetPersonalVehicle(id)
        end

        if not veh or veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end
        
        local vehiclehash = entity.get_entity_model_hash(veh)

        local clone = Spawn.Vehicle(vehiclehash, utility.OffsetCoords(get.OwnCoords(), get.OwnHeading(), 10))
        if not clone then
            Notify('Failed to clone Vehicle, couldnt get the Vehicles Hash', "Error", '')
            return
        end

        utility.SetVehicleMods(clone, utility.GetVehicleMods(veh), true)
    end)
    Script.Feature['Player Clone Vehicle']:set_str_data({'Current Vehicle', 'Personal Vehicle'})

    Script.Feature['Player Repair Vehicle'] = menu.add_player_feature("Repair Vehicle", "action", Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end
        
        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end

        utility.RepairVehicle(veh) 
    end)

    Script.Feature['Player Delete Vehicle'] = menu.add_player_feature("Delete Vehicle", "action", Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end

        entity.delete_entity(veh)
    end)

    Script.Feature['Player Freeze Vehicle'] = menu.add_player_feature('Freeze Vehicle', 'action_value_str', Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end

        if f.value == 0 then
            entity.freeze_entity(veh, true)
        elseif f.value == 1 then
            entity.freeze_entity(veh, false)
        end
    end)
    Script.Feature['Player Freeze Vehicle']:set_str_data({'Freeze', 'Unfreeze'})

    Script.Feature['Player Vehicle Kick'] = menu.add_player_feature('Vehicle Kick', 'action', Script.Parent['Player Vehicle'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        scriptevent.Send('Vehicle Kick', {player.player_id(), 4294967295, 4294967295, 4294967295}, id)
    end)

    Script.Feature['Player Vehicle EMP'] = menu.add_player_feature('EMP (Script Event)', 'action', Script.Parent['Player Vehicle'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        local pos = get.PlayerCoords(id)
        scriptevent.Send('Vehicle EMP', {player.player_id(), Math.ToInt(pos.x), Math.ToInt(pos.y), Math.ToInt(pos.z), 0}, id)
    end)

    Script.Feature['Player Vehicle EMP Explosion'] = menu.add_player_feature('EMP Explosion', 'action_value_str', Script.Parent['Player Vehicle'], function(f, id)
        local pos = get.PlayerCoords(id)
        if f.value == 0 then
            fire.add_explosion(utility.OffsetCoords(pos, player.get_player_heading(id), 2), 83, true, false, 0, get.PlayerPed(id))
        elseif f.value == 1 then
            fire.add_explosion(utility.OffsetCoords(pos, player.get_player_heading(id), 2), 83, false, true, 0, get.PlayerPed(id))
        end
    end)
    Script.Feature['Player Vehicle EMP Explosion']:set_str_data({'Normal', 'Silent'})

    Script.Feature['Player Trap In Vehicle'] = menu.add_player_feature('Trap In Vehicle', 'action_value_str', Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end
        
        vehicle.set_vehicle_mod_kit_type(veh, 0)
        vehicle.set_vehicle_mod(veh, 16, 0, true)
        vehicle.set_vehicle_doors_locked(veh, 4)

        if f.value == 0 then
            vehicle.set_vehicle_engine_health(veh, 0)
        elseif f.value == 1 then
            utility.set_coords(veh, v3(10, 685, 186))
        end
    end)
    Script.Feature['Player Trap In Vehicle']:set_str_data({'Set on Fire', 'Drown Underwater'})

    Script.Feature['Player Tire Burst'] = menu.add_player_feature('Tire Burst Spam', 'value_i', Script.Parent['Player Vehicle'], function(f, id)
        while f.on do
            local veh = get.PlayerVehicle(id)

            if veh == 0 then
                goto continue
            end

            utility.request_ctrl(veh)
            vehicle.set_vehicle_mod_kit_type(veh, 0)
            vehicle.set_vehicle_bulletproof_tires(veh, false)
            vehicle.set_vehicle_tires_can_burst(veh, true)

            for i = 0, 6 do
                vehicle.set_vehicle_tire_burst(veh, i, true, 1000.0)
            end
            
            ::continue::
            coroutine.yield(f.value)
        end
    end)
    Script.Feature['Player Tire Burst'].min = 0
	Script.Feature['Player Tire Burst'].max = 500
	Script.Feature['Player Tire Burst'].mod = 50
    Script.Feature['Player Tire Burst'].value = 50

    Script.Feature['Player Detonate Vehicle'] = menu.add_player_feature('Detonate Vehicle (Named)', 'action', Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)

        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end

        vehicle.add_vehicle_phone_explosive_device(veh)
        if not vehicle.has_vehicle_phone_explosive_device(veh) then
            Notify('Failed to place an explosive device on the Players vehicle.', "Error", '')
            return
        end

        if entity.get_entity_god_mode(veh) then
            entity.set_entity_god_mode(veh, false)
        end
        
        vehicle.detonate_vehicle_phone_explosive_device()
    end)

    Script.Feature['Player Disable Ability to Drive'] = menu.add_player_feature('Disable Ability to Drive', 'action', Script.Parent['Player Vehicle'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        scriptevent.Send('Apartment Invite', {player.player_id(), player.player_id(), 4294967295, 1, 115, 0, 0, 0}, id)
    end)

    Script.Feature['Player Destroy Personal Vehicle'] = menu.add_player_feature('Destroy Personal Vehicle', 'action', Script.Parent['Player Vehicle'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        if scriptevent.GetPersonalVehicle(id) == 0 then
            Notify('Player has no personal vehicle', "Error", '')
            return
        end
        
        scriptevent.Send('Destroy Personal Vehicle', {player.player_id(), id}, id)
        scriptevent.Send('Vehicle Kick', {player.player_id(), 4294967295, 4294967295, 4294967295}, id)
    end)

    Script.Feature['Player Modify Speed'] = menu.add_player_feature('Modify Speed', 'action_value_str', Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if f.value == 0 then
            local speed = tonumber(get.Input('Enter modified Speed (1-1000)', 4, 3))
            if not speed then
                Notify('Input canceled.', "Error", '')
                return
            end

            if speed < 1 or speed > 1000 then
                Notify('Input must be between 1 and 1000.', "Error", '')
                return
            end

            if not utility.request_ctrl(veh, 5000) then
                Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
            end

            vehicle.modify_vehicle_top_speed(veh, speed)
        else
            if not utility.request_ctrl(veh, 5000) then
                Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
            end

            vehicle.modify_vehicle_top_speed(veh, 1)
            utility.RepairVehicle(veh)
        end
    end)
    Script.Feature['Player Modify Speed']:set_str_data({'Modify', 'Reset'})

    Script.Feature['Player Random Force'] = menu.add_player_feature('Apply random Force', 'action', Script.Parent['Player Vehicle'], function(f, id)
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            Notify('No vehicle found.', "Error", '')
            return
        end

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over the Players vehicle.\nThe feature might not have worked.', "Error", '')
        end

        local velocity = entity.get_entity_velocity(veh)
        for i = 1, 5 do
            velocity.x = math.random(math.floor(velocity.x - 50), math.floor(velocity.x + 50))
            velocity.y = math.random(math.floor(velocity.y - 50), math.floor(velocity.y + 50))
            velocity.z = math.random(math.floor(velocity.z - 50), math.floor(velocity.z + 50))
            entity.set_entity_velocity(veh, velocity)
            coroutine.yield(10)
        end
    end)



    Script.Parent['Player Trolling'] = menu.add_player_feature('Trolling', 'parent', Script.playerparent, nil).id

    Script.Parent['Player Fake Invites'] = menu.add_player_feature('Fake Invites', 'parent', Script.Parent['Player Trolling'], nil).id

    for i = 1, #miscdata.fakeinvites do
        local name = miscdata.fakeinvites[i]
        Script.Feature['Player '.. name .. ' Invite'] = menu.add_player_feature(name .. ' Invite', 'action', Script.Parent['Player Fake Invites'], function(f, id)
            if id == player.player_id() then
                Notify('This doesnt work on yourself.', "Error", '')
                return
            end
    
            scriptevent.Send('Fake Invite', {player.player_id(), i}, id)
        end)
    end

    Script.Feature['Player Fake Invite Spam'] = menu.add_player_feature('Fake Invite Spam', 'toggle', Script.Parent['Player Fake Invites'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.Send('Fake Invite', {player.player_id(), math.random(1, 6)}, id)
            coroutine.yield(200)
        end
    end)
    

    Script.Parent['Player Notifications'] = menu.add_player_feature('Notifications', 'parent', Script.Parent['Player Trolling'], nil).id

    Script.Feature['Player Cash Removed'] = menu.add_player_feature('Cash Removed', 'action_value_str', Script.Parent['Player Notifications'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        if f.value == 0 then
            scriptevent.Send('Notification 2', {player.player_id(), 689178114, math.random(-2147483647, 2147483647)}, id)
            return
        end

        local amount = get.Input('Enter The Amount Of Money (0 - 2147483647)', 10, 3)
            
        if not amount then
            Notify('Input canceled.', "Error", '')
            return
        end
            
        scriptevent.Send('Notification 2', {player.player_id(), 689178114, amount}, id)
    end)
    Script.Feature['Player Cash Removed']:set_str_data({'Random Amount', 'Input'})

    Script.Feature['Player Cash Stolen'] = menu.add_player_feature('Cash Stolen', 'action_value_str', Script.Parent['Player Notifications'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        if f.value == 0 then
            scriptevent.Send('Notification 2', {player.player_id(), 2187973097, math.random(-2147483647, 2147483647)}, id)
            return
        end

        local amount = get.Input('Enter The Amount Of Money (0 - 2147483647)', 10, 3)
            
        if not amount then
            Notify('Input canceled.', "Error", '')
            return
        end
        
        scriptevent.Send('Notification 2', {player.player_id(), 2187973097, amount}, id)
    end)
    Script.Feature['Player Cash Stolen']:set_str_data({'Random Amount', 'Input'})

    Script.Feature['Player Cash Banked'] = menu.add_player_feature('Cash Banked', 'action_value_str', Script.Parent['Player Notifications'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        if f.value == 0 then
            scriptevent.Send('Notification 2', {player.player_id(), 1990572980, math.random(-2147483647, 2147483647)}, id)
            return
        end

        local amount = get.Input('Enter The Amount Of Money (0 - 2147483647)', 10, 3)
            
        if not amount then
            Notify('Input canceled.', "Error", '')
            return
        end

        scriptevent.Send('Notification 2', {player.player_id(), 1990572980, amount}, id)
    end)
    Script.Feature['Player Cash Banked']:set_str_data({'Random Amount', 'Input'})

    Script.Feature['Player Insurance Notification'] = menu.add_player_feature('Insurance Notification', 'action_value_str', Script.Parent['Player Notifications'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        if f.value == 0 then
            scriptevent.Send('Insurance Notification', {player.player_id(), math.random(-2147483647, 2147483647)}, id)
            return
        end

        local amount = get.Input('Enter The Amount Of Money (0 - 2147483647)', 10, 3)
            
        if not amount then
            Notify('Input canceled.', "Error", '')
            return
        end

        scriptevent.Send('Insurance Notification', {player.player_id(), amount}, id)
    end)
    Script.Feature['Player Insurance Notification']:set_str_data({'Random Amount', 'Input'})

    Script.Feature['Player Notification Spam'] = menu.add_player_feature('Notification Spam', 'value_str', Script.Parent['Player Notifications'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.Send('Notification 2', {player.player_id(), 689178114, math.random(-2147483647, 2147483647)}, id)
            scriptevent.Send('Notification 2', {player.player_id(), 2187973097, math.random(-2147483647, 2147483647)}, id)
            scriptevent.Send('Notification 2', {player.player_id(), 1990572980, math.random(-2147483647, 2147483647)}, id)
            
            if f.value == 0 then
                scriptevent.Send('Insurance Notification', {player.player_id(), math.random(-2147483647, 2147483647)}, id)
            end
            coroutine.yield(200)
        end
    end)
    Script.Feature['Player Notification Spam']:set_str_data({'Named', 'Anonymous'})

    Script.Feature['Player Random Apartment Invite'] = menu.add_player_feature('Random Apartment Invite', 'action', Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        scriptevent.Send('Apartment Invite', {player.player_id(), id, 1, 0, math.random(1, 114), 1, 1, 1}, id)
    end)

    Script.Feature['Player Apartment Invite Loop'] = menu.add_player_feature('Apartment Invite Loop', 'toggle', Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.Send('Apartment Invite', {player.player_id(), id, 1, 0, math.random(1, 114), 1, 1, 1}, id)
            coroutine.yield(5000)
        end
    end)

    Script.Feature['Player Warehouse Invite'] = menu.add_player_feature('Warehouse Invite', 'action_value_str', Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        if f.value == 22 then
            scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, math.random(1, 22)}, id)
            return
        end

        scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, f.value + 1}, id)
    end)
	Script.Feature['Player Warehouse Invite']:set_str_data({
    'Elysian Island North',
    'La Puerta North',
    'La Mesa Mid',
    'Rancho West',
    'West Vinewood',
    'LSIA North',
    'Del Perro',
    'LSIA South',
    'Elysian Island South',
    'El Burro Heights',
    'Elysian Island West',
    'Textile City',
    'La Puerta South',
    'Strawberry',
    'Downtown Vinewood North',
    'La Mesa South',
    'La Mesa North',
    'Cypress Flats North',
    'Cypress Flats South',
    'West Vinewood West',
    'Rancho East',
    'Banning',
    'Random'
    })

    Script.Feature['Player Warehouse Invite Loop'] = menu.add_player_feature('Warehouse Invite Loop', 'toggle', Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This does not work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, math.random(1, 22)}, id)
            coroutine.yield(5000)
        end
    end)

    Script.Feature['Player Script Freeze'] = menu.add_player_feature('Script Freeze', 'value_str', Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            if f.value == 0 then
                scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, 0}, id)
            else
                scriptevent.Send('Script Freeze', {player.player_id()}, id)
            end

            coroutine.yield(200)
        end
    end)
    Script.Feature['Player Script Freeze']:set_str_data({'v1', 'v2'})

    Script.Feature['Player Electrocute'] = menu.add_player_feature('Electrocute', 'action', Script.Parent['Player Trolling'], function(f, id)
        local pos = get.PlayerCoords(id)
        gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 2), pos, 0, 0x3656C8C1, get.OwnPed(), true, false, 10000)
    end)

    Script.Feature['Player Looped Electrocution'] = menu.add_player_feature('Looped Electrocution', 'toggle', Script.Parent['Player Trolling'], function(f, id)
        while f.on do
            local pos = get.PlayerCoords(id)
            gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 2), pos, 0, 0x3656C8C1, get.OwnPed(), true, false, 10000)
            coroutine.yield(2500)
        end
    end)
    
    Script.Feature['Player Ragdoll'] = menu.add_player_feature('Ragdoll Player', 'action_value_str', Script.Parent['Player Trolling'], function(f, id)
        local pos = get.PlayerCoords(id)

        if f.value == 0 then
            fire.add_explosion(pos, 70, false, true, 0, get.PlayerPed(id))
            return
        end

        fire.add_explosion(pos, 13, false, true, 0, get.PlayerPed(id))
    end)
    Script.Feature['Player Ragdoll']:set_str_data({'v1', 'v2'})

    Script.Feature['Player Freemode Mission'] = menu.add_player_feature("Start Freemode Mission", "action", Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        scriptevent.Send('Start Freemode Mission', {player.player_id(), 263, 4294967295}, id)
    end)

    Script.Feature['Player Force Camera Forward'] = menu.add_player_feature('Force Camera Forward', 'toggle', Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.Send('Camera Manipulation', {player.player_id(), 869796886, 0}, id)
            coroutine.yield(100)
        end
    end)

    Script.Feature['Player Transaction Error'] = menu.add_player_feature('Transaction Error', 'toggle', Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.Send('Transaction Error', {player.player_id(), 50000, 0, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair(), 1}, id)
            coroutine.yield(1000)
        end
    end)

    Script.Feature['Player Set Bounty'] = menu.add_player_feature('Set Bounty: Input', 'action_value_str', Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        if script.get_host_of_this_script() == player.player_id() then
            Notify('This doesnt work while you are Script Host!', "Error", '')
            return
        end

        if scriptevent.DoesPlayerHaveBounty(id) then
            Notify('Player already has a Bounty!', "Error", '')
            return
        end

        local amount = get.Input('Enter Bounty Value (0 - 10000)', 5, 3, "10000")
        if not amount then
            Notify('Input canceled.', "Error", '')
            return
        end

        if tonumber(amount) > 10000 then
            Notify('Value cannot be more than 10000!', nil, '')
            return
        end

        scriptevent.setBounty(id, amount, f.value)
    end)
	Script.Feature['Player Set Bounty']:set_str_data({'Named', 'Anonymous'})

    Script.Feature['Player Bounty After Death'] = menu.add_player_feature('Reapply Bounty after Death', 'value_str', Script.Parent['Player Trolling'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        if script.get_host_of_this_script() == player.player_id() then
            Notify('This doesnt work while you are Script Host!', "Error", '')
            f.on = false
            return
        end

        local bounty_value
        while f.on do
            if not bounty_value then
                local bounty_value = get.Input('Enter Bounty Value (0 - 10000)', 5, 3, "10000")

                if not bounty_value then
                    Notify('Input canceled.', "Error", '')
                    f.on = false
                    return
                end

                if tonumber(bounty_value) > 10000 then
                    Notify('Value cannot be more than 10000!', "Error", '')
                    f.on = false
                    return
                end
            else
                if entity.is_entity_dead(get.PlayerPed(id)) then
                    Notify(get.Name(id) .. ' is dead!\nReapplying bounty...', "Neutral")
                    Log(get.Name(id) .. ' is dead!\nReapplying bounty...')
                    scriptevent.setBounty(id, inputs.player_bounty, f.value)
                    coroutine.yield(2000)
                end
            end
            
            coroutine.yield(0)
        end
    end)
	Script.Feature['Player Bounty After Death']:set_str_data({'Named', 'Anonymous'})

    Script.Feature['Player Trap In Tube'] = menu.add_player_feature("Trap in Stunt Tube", "action_value_str", Script.Parent['Player Trolling'], function(f, id)
        local pos = get.PlayerCoords(id)
        pos.z = pos.z - 5

        if f.value == 0 then
            entity.set_entity_rotation(Spawn.Object(1125864094, pos), v3(0, 90, 0))
            return
        end

        local tube = Spawn.Object(1125864094, pos)
        entity.set_entity_rotation(tube, v3(0, 90, 0))
        entity.set_entity_visible(tube, false)
    end)
	Script.Feature['Player Trap In Tube']:set_str_data({'Visible', 'Invisible'})

    Script.Feature['Player Trap In Cage'] = menu.add_player_feature('Trap in Cage', 'action_value_str', Script.Parent['Player Trolling'], function(f, id)
        local pos = get.PlayerCoords(id)
        if f.value == 0 then
            Spawn.Object(2718056036, v3(pos.x, pos.y, pos.z + 0.5))
            Spawn.Object(2718056036, v3(pos.x, pos.y, pos.z - 0.5))
            return
        end

        pos.x = pos.x + 1.24
        pos.y = pos.y + 0.24

        local cage = Spawn.Object(401136338, pos)
        entity.set_entity_rotation(cage, v3(0, -90, 0))
        entity.freeze_entity(cage, true)

        pos.x = pos.x - 1.22
        pos.y = pos.y + 0.58

        local cage2 = Spawn.Object(401136338, pos)
        entity.set_entity_rotation(cage2, v3(90, -90, 0))
        entity.freeze_entity(cage2, true)  
    end)
    Script.Feature['Player Trap In Cage']:set_str_data({'v1', 'v2'})

    Script.Feature['Player Trap In Cage2'] = menu.add_player_feature('Trap in invisible Cage', 'action_value_str', Script.Parent['Player Trolling'], function(f, id)
        local pos = get.PlayerCoords(id)
        if f.value == 0 then
            local cage = Spawn.Object(2718056036, v3(pos.x, pos.y, pos.z + 0.5))
            entity.set_entity_visible(cage, false)

            local cage2 = Spawn.Object(2718056036, v3(pos.x, pos.y, pos.z - 0.5))
            entity.set_entity_visible(cage2, false)
            return
        end

        pos.x = pos.x + 1.24
        pos.y = pos.y + 0.24

        local cage = Spawn.Object(401136338, pos)
        entity.set_entity_rotation(cage, v3(0, -90, 0))
        entity.freeze_entity(cage, true)
        entity.set_entity_visible(cage, false)

        pos.x = pos.x - 1.22
        pos.y = pos.y + 0.58

        local cage2 = Spawn.Object(401136338, pos)
        entity.set_entity_rotation(cage2, v3(90, -90, 0))
        entity.freeze_entity(cage2, true)
        entity.set_entity_visible(cage2, false)     
    end)
    Script.Feature['Player Trap In Cage2']:set_str_data({'v1', 'v2'})


    Script.Parent['Player Griefing'] = menu.add_player_feature('Griefing', 'parent', Script.playerparent, nil).id

    Script.Feature['Player Radiation Lags'] = menu.add_player_feature('Radiation Lags', 'slider', Script.Parent['Player Griefing'], function(f, id)
        while f.on do
            graphics.set_next_ptfx_asset('scr_agencyheistb')
            while not graphics.has_named_ptfx_asset_loaded('scr_agencyheistb') do
                graphics.request_named_ptfx_asset('scr_agencyheistb')

                coroutine.yield(0)
            end

            ped.clear_ped_tasks_immediately(get.PlayerPed(id))
            graphics.start_networked_ptfx_non_looped_on_entity('scr_agency3b_elec_box', get.PlayerPed(id), v3(), v3(), f.value)

            coroutine.yield(0)
        end
        graphics.remove_named_ptfx_asset('scr_agencyheistb')
    end)
	Script.Feature['Player Radiation Lags'].min = 10
	Script.Feature['Player Radiation Lags'].max = 100
	Script.Feature['Player Radiation Lags'].mod = 10


    Script.Parent['Player Blame Kill'] = menu.add_player_feature('Blame Kill', 'parent', Script.Parent['Player Griefing'], function(f, id)
        local done = 0
        for i = 0, 31 do
            if playerblamekill[i] ~= nil then
                menu.delete_player_feature(playerblamekill[i].id)
                playerblamekill[i] = nil
                done = done + 1
            end

            if done == 15 then
                done = 0
                coroutine.yield(0)
            end
        end

        for i = 0, 31 do
            if player.is_player_valid(i) then
                playerblamekill[i] = menu.add_player_feature(get.Name(i), 'action', Script.Parent['Player Blame Kill'], function(f, id)
                    ped.clear_ped_tasks_immediately(get.PlayerPed(i))
                    fire.add_explosion(get.PlayerCoords(i), 5, false, true, 1, get.PlayerPed(id))
                end)
            end
        end
    end).id

    Script.Parent['Player Blame Refresh'] = menu.add_player_feature('Refresh List', 'action', Script.Parent['Player Blame Kill'], function()
        local done = 0
        for i = 0, 31 do
            if playerblamekill[i] ~= nil then
                menu.delete_player_feature(playerblamekill[i].id)
                playerblamekill[i] = nil
                done = done + 1
            end

            if done == 5 then
                done = 0
                coroutine.yield(0)
            end
        end

        for i = 0, 31 do
            if player.is_player_valid(i) then
                playerblamekill[i] = menu.add_player_feature(get.Name(i), 'action', Script.Parent['Player Blame Kill'], function(f, id)
                    ped.clear_ped_tasks_immediately(get.PlayerPed(i))
                    fire.add_explosion(get.PlayerCoords(i), 5, true, false, 1, get.PlayerPed(id))
                end)
            end
        end
    end)

    Script.Feature['Player Ram with Vehicle'] = menu.add_player_feature('Ram with Vehicle', 'action', Script.Parent['Player Griefing'], function(f, id)
        local speed = 200
        local direction = -10

        local choice = math.random(1, 2)
        if choice == 2 then
            speed = -200
            direction = 10
        end

        local veh = Spawn.Vehicle(3078201489, utility.OffsetCoords(get.PlayerCoords(id), get.PlayerHeading(id), direction))
        entity.set_entity_rotation(veh, v3(0, 0, get.PlayerHeading(id)))
        vehicle.set_vehicle_forward_speed(veh, speed)

        coroutine.yield(2000)

        utility.clear(veh)
    end)

    Script.Feature['Player Set on Fire'] = menu.add_player_feature('Set on Fire' ,'action', Script.Parent['Player Griefing'], function(f, id)
        local ptfx

        graphics.set_next_ptfx_asset('scr_recrash_rescue')
        while not graphics.has_named_ptfx_asset_loaded('scr_recrash_rescue') do
            graphics.request_named_ptfx_asset('scr_recrash_rescue')
            coroutine.yield(0)
        end

        while not ptfx do
            ptfx = graphics.start_networked_ptfx_looped_on_entity('scr_recrash_rescue_fire', get.PlayerPed(id), v3(), v3(), 1)
            coroutine.yield(0)
        end
    end)

    
    Script.Feature['Player Perma Burn'] = menu.add_player_feature('Perma Burn', 'toggle', Script.Parent['Player Griefing'], function(f, id)
        local permaburn = 0

        while f.on do
            if not graphics.does_looped_ptfx_exist(permaburn) then
                graphics.set_next_ptfx_asset('scr_recrash_rescue')
                while not graphics.has_named_ptfx_asset_loaded('scr_recrash_rescue') do
                    graphics.request_named_ptfx_asset('scr_recrash_rescue')
                    coroutine.yield(0)
                end

                permaburn = graphics.start_networked_ptfx_looped_on_entity('scr_recrash_rescue_fire', get.PlayerPed(id), v3(), v3(), 1)
            end
            
            coroutine.yield(1000)
        end
        graphics.remove_particle_fx(permaburn)
    end)

    Script.Feature['Player Shockwave Spam'] = menu.add_player_feature('Shockwave Spam', 'toggle', Script.Parent['Player Griefing'], function(f, id)
        while f.on do
            local pos = get.PlayerCoords(id)
            pos.x = pos.x + math.random(-3, 3)
            pos.y = pos.y + math.random(-3, 3)
            pos.z = pos.z + math.random(-2, 2)

            fire.add_explosion(pos, 70, true, false, 0, 0)

            coroutine.yield(100)
        end
    end)

    Script.Feature['Player Cluster Bomb'] = menu.add_player_feature('Cluster Bomb', 'action', Script.Parent['Player Griefing'], function(f, id)
        menu.create_thread(function(Player)
            local pos = get.PlayerCoords(Player)

            fire.add_explosion(pos, 47, true, false, 5, 0)
            
            coroutine.yield(500)
    
            for i = 1, 15 do
                pos = get.PlayerCoords(Player)
                pos.x = pos.x + math.random(-6, 6)
                pos.y = pos.y + math.random(-6, 6)
                pos.z = Math.GetGroundZ(pos.x, pos.y)
    
                fire.add_explosion(pos, 54, true, false, 2, 0)
    
                coroutine.yield(50)
            end
        end, id)
    end)

    Script.Feature['Player Airstrike'] = menu.add_player_feature('Airstrike (Named)', 'action', Script.Parent['Player Griefing'], function(f, id)
        if not weapon.has_ped_got_weapon(get.OwnPed(), 0xB1CA77B1) then
            weapon.give_delayed_weapon_to_ped(get.OwnPed(), 0xB1CA77B1, 0, 0)
            coroutine.yield(200)
        end
        
        local whash = gameplay.get_hash_key('weapon_airstrike_rocket')
        local pos = get.PlayerCoords(id)
        gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 50), pos, 1000, whash, get.OwnPed(), true, false, 5000)
    end)

    Script.Feature['Player Airstrike Rain'] = menu.add_player_feature('Airstrike Rain (Named)', 'value_i', Script.Parent['Player Griefing'], function(f, id)
        if not weapon.has_ped_got_weapon(get.OwnPed(), 0xB1CA77B1) then
            weapon.give_delayed_weapon_to_ped(get.OwnPed(), 0xB1CA77B1, 0, 0)
            coroutine.yield(200)
        end

        local whash = gameplay.get_hash_key('weapon_airstrike_rocket')
        while f.on do
            local pos = get.PlayerCoords(id)
            pos.x = pos.x + math.random(-15, 15)
            pos.y = pos.y + math.random(-15, 15)
            gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 50), pos, 1000, whash, get.OwnPed(), true, false, 5000)

            coroutine.yield(f.value)
        end
    end)
    Script.Feature['Player Airstrike Rain'].min = 100
	Script.Feature['Player Airstrike Rain'].max = 1000
	Script.Feature['Player Airstrike Rain'].mod = 100
    Script.Feature['Player Airstrike Rain'].value = 500

    Script.Feature['Player Force Cutscene'] = menu.add_player_feature('Force Casino Cutscene', 'action', Script.Parent['Player Griefing'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        scriptevent.Send('Casino Cutscene', {player.player_id()}, id)
    end)

    Script.Feature['Player Force Island'] = menu.add_player_feature('Force to Perico Island', 'action', Script.Parent['Player Griefing'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        scriptevent.Send('Force To Island', {player.player_id(), 1}, id)
    end)

    Script.Feature['Player Force Mission'] = menu.add_player_feature("Force to Mission", "action_value_str", Script.Parent['Player Griefing'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        if f.value == 0 then
            scriptevent.Send('Force To Mission', {player.player_id()}, id)
            return
        end
        
        scriptevent.Send('Force To Mission', {player.player_id(), f.value}, id)
    end)
	Script.Feature['Player Force Mission']:set_str_data({'Severe Weather', 'Half Track', 'Night Shark AAT', 'APC Mission', 'MOC Mission', 'Tampa Mission', 'Opressor Mission 1', 'Opressor Mission 2'})

    Script.Feature['Player CEO'] = menu.add_player_feature("CEO Removal", "action_value_str", Script.Parent['Player Griefing'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        if not scriptevent.IsPlayerInOrg(id) then
            Notify('Player is not in any Organisation!', "Error", '')
            return
        end

        if f.value == 0 then
            scriptevent.Send('CEO Kick', {player.player_id(), 1, 5}, id)

        elseif f.value == 1 then
            scriptevent.Send('CEO Kick', {player.player_id(), 1, 6}, id)

        else
            scriptevent.Send('CEO Ban', {player.player_id(), 1}, id)
        end
    end)
	Script.Feature['Player CEO']:set_str_data({"Demiss", "Terminate", "Ban"})

    Script.Feature['Player Bounty Set & Claim'] = menu.add_player_feature('Set & Claim Bounty Loop', 'toggle', Script.Parent['Player Griefing'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        if script.get_host_of_this_script() == player.player_id() then
            Notify('This doesnt work while you are Script Host!', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.setBounty(id, 10000, 1)

            coroutine.yield(1000)
            ped.clear_ped_tasks_immediately(get.PlayerPed(id))
            fire.add_explosion(get.PlayerCoords(id), 8, false, true, 0, get.OwnPed())
            coroutine.yield(19000)
        end
    end)

    Script.Feature['Player Kill Godmode'] = menu.add_player_feature('Kill Godmode Player', 'action', Script.Parent['Player Griefing'], function(f, id)
        if id == player.player_id() then
            Notify('No need to do this.', "Error", '')
            return
        end
        
        local time
        local veh = get.PlayerVehicle(id)
        if veh == 0 then
            goto continue
        end

        if not entity.get_entity_god_mode(veh) then
            goto continue
        end

        time = utils.time_ms() + 5000

        while time > utils.time_ms() and entity.get_entity_god_mode(veh) do
            utility.request_ctrl(veh)
            entity.set_entity_god_mode(veh, false)
        end
        
        if entity.get_entity_god_mode(veh) then
            Notify('Failed to remove godmode from the Players vehicle.', "Error", '')
            return
        end

        ::continue::

        ped.clear_ped_tasks_immediately(get.PlayerPed(id))
        scriptevent.Send('Camera Manipulation', {player.player_id(), 869796886, 0}, id)
        fire.add_explosion(get.PlayerCoords(id), 8, false, true, 0, get.OwnPed())
    end)

    Script.Feature['Player Asteroid'] = menu.add_player_feature('Falling Asteroids', 'action', Script.Parent['Player Griefing'], function(f, id)
        for i = 1, 25 do
            local pos = get.PlayerCoords(id)
            pos.x = math.random(math.floor(pos.x - 80), math.floor(pos.x + 80))
            pos.y = math.random(math.floor(pos.y - 80), math.floor(pos.y + 80))
            pos.z = pos.z + math.random(45, 90)

            entitys['asteroids'][#entitys['asteroids'] + 1] = Spawn.Object(3751297495, pos, true, true)

            local force = math.random(-125, 25)
            entity.apply_force_to_entity(entitys['asteroids'][#entitys['asteroids']], 3, 0, 0, force, 0, 0, 0, true, true)
        end
        for j = 1, 25 do
            local pos = entity.get_entity_coords(entitys['asteroids'][(#entitys['asteroids'] - 25 + j)])
            fire.add_explosion(pos, 8, true, false, 0, 0)

            coroutine.yield(100)
        end
    end)
    
    Script.Feature['Player Clear Asteroids'] = menu.add_player_feature('Delete Asteroids', 'action', Script.Parent['Player Griefing'], function()
        Log('Clearing Asteroids...')
        for i = 1, #entitys['asteroids'] do
            for j = 1, 50 do
                if entity.is_an_entity(entitys['asteroids'][i]) then
                    utility.request_ctrl(entitys['asteroids'][i])
                    entity.set_entity_velocity(entitys['asteroids'][i], v3())
                    entity.set_entity_coords_no_offset(entitys['asteroids'][i], v3(8000, 8000, -1000))
                    entity.set_entity_as_mission_entity(entitys['asteroids'][i], true, true)
                    entity.set_entity_as_no_longer_needed(entitys['asteroids'][i])
                    entity.delete_entity(entitys['asteroids'][i])
                end
            end
        end
        entitys['asteroids'] = {}
        Log('Asteroids Successfully Cleared!')
        Notify('Asteroids Cleared!', "Success")
    end)

    Script.Feature['Player Infinite Apartment Invite'] = menu.add_player_feature('Infinite Apartment Invite', 'action', Script.Parent['Player Griefing'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end

        scriptevent.Send('Apartment Invite', {player.player_id(), id, 4294967295, 1, 115, 0, 0, 0}, id)
    end)

    Script.Feature['Player Passive Mode'] = menu.add_player_feature("Block Passive Mode", "toggle", Script.Parent['Player Griefing'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.Send('Passive Mode', {player.player_id(), 1}, id)
            coroutine.yield(200)
        end

        scriptevent.Send('Passive Mode', {player.player_id(), 0}, id)
    end)

    Script.Feature['Player Spam Script Events'] = menu.add_player_feature('Spam Script Events', 'value_str', Script.Parent['Player Griefing'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, math.random(1, 22)}, id)
            scriptevent.Send('Apartment Invite', {player.player_id(), id, 1, 0, math.random(1, 114), 1, 1, 1}, id)
            scriptevent.Send('Force To Mission', {player.player_id(), math.random(0, 7)}, id)
            scriptevent.Send('Force To Island', {player.player_id(), 1}, id)
            scriptevent.Send('Casino Cutscene', {player.player_id()}, id)
            coroutine.yield(0)
            scriptevent.Send('Vehicle Kick', {player.player_id(), 4294967295, 4294967295, 4294967295}, id)
            scriptevent.Send('CEO Kick', {player.player_id(), 1, 5}, id)
            scriptevent.Send('CEO Ban', {player.player_id(), 1}, id)
            scriptevent.Send('Transaction Error', {player.player_id(), 50000, 0, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair(), 1}, id)
            scriptevent.Send('Passive Mode', {player.player_id(), 1}, id)
            coroutine.yield(0)
            scriptevent.Send('Start Freemode Mission', {player.player_id(), 263, 4294967295}, id)
            scriptevent.Send('Notification 2', {player.player_id(), 689178114, math.random(-2147483647, 2147483647)}, id)
            scriptevent.Send('Notification 2', {player.player_id(), 2187973097, math.random(-2147483647, 2147483647)}, id)
            scriptevent.Send('Notification 2', {player.player_id(), 1990572980, math.random(-2147483647, 2147483647)}, id)
            scriptevent.Send('Insurance Notification', {player.player_id(), math.random(-2147483647, 2147483647)}, id)
            if f.value == 1 then
                coroutine.yield(0)
                scriptevent.Send('Warehouse Invite', {player.player_id(), 0, 1, 0}, id)
                scriptevent.Send('Apartment Invite', {player.player_id(), id, 4294967295, 1, 115, 0, 0, 0}, id)
                coroutine.yield(0)
                scriptevent.kick(id, 2)
                coroutine.yield(0)
                scriptevent.kick(id, 3)
                coroutine.yield(0)
                scriptevent.crash(id)
            end
            coroutine.yield(100)
        end
    end)
    Script.Feature['Player Spam Script Events']:set_str_data({'v1', 'v2'})


    Script.Parent['Player Friendly'] = menu.add_player_feature('Friendly', 'parent', Script.playerparent, nil).id


    Script.Parent['Player Spawn Vehicle'] = menu.add_player_feature('Spawn Vehicle', 'parent', Script.Parent['Player Friendly'], nil).id

    Script.Parent['Player Spawn Vehicle Settings'] = menu.add_player_feature('Spawn Settings', 'parent', Script.Parent['Player Spawn Vehicle'], nil).id

    Script.Feature['Player Spawn Vehicle Upgraded'] = menu.add_player_feature('Upgraded', 'value_str', Script.Parent['Player Spawn Vehicle Settings'], function(f)
        settings['Player Spawn Vehicle Upgraded'] = {Enabled = f.on, Value = f.value}
    end)
    Script.Feature['Player Spawn Vehicle Upgraded']:set_str_data({'Max', 'Performance'})

    Script.Feature['Player Spawn Vehicle Godmode'] = menu.add_player_feature('Godmode', 'toggle', Script.Parent['Player Spawn Vehicle Settings'], function(f)
        settings['Player Spawn Vehicle Godmode'] = {Enabled = f.on}
    end)

    Script.Feature['Player Spawn Vehicle Lockon'] = menu.add_player_feature('Lock-on Disabled', 'toggle', Script.Parent['Player Spawn Vehicle Settings'], function(f)
        settings['Player Spawn Vehicle Lockon'] = {Enabled = f.on}
    end)

    Script.Feature['Player Spawn Vehicle Input'] = menu.add_player_feature('Model/Hash Input', 'action', Script.Parent['Player Spawn Vehicle'], function(f, id)
        local _input = get.Input("Enter Vehicle Model Name or Hash")
        if not _input then
            Notify('Input canceled.', "Error", '')
            return
        end

        local hash = _input
        if not tonumber(_input) then
            if mapper.veh.GetHashFromName(_input) ~= nil then
                hash = mapper.veh.GetHashFromName(_input)
            else
                hash = gameplay.get_hash_key(_input)
            end
        end

        if not streaming.is_model_a_vehicle(hash) then
            Notify('Input is not a valid vehicle.', "Error", '')
            return
        end

        local pos = get.PlayerCoords(id)
        pos.z = Math.GetGroundZ(pos.x, pos.y)
        local veh = Spawn.Vehicle(hash, utility.OffsetCoords(pos, get.PlayerHeading(id), 10))

        if not utility.request_ctrl(veh, 5000) then
            Notify('Failed to gain control over spawned Vehicle.\nThe upgrades might not have worked.', "Error", '')
        end

        decorator.decor_set_int(veh, 'MPBitset', 1 << 10)
        if Script.Feature['Player Spawn Vehicle Upgraded'].on[id] then
            utility.MaxVehicle(veh, Script.Feature['Player Spawn Vehicle Upgraded'].value[id] + 1)
        end

        if Script.Feature['Player Spawn Vehicle Godmode'].on[id] then
            entity.set_entity_god_mode(veh, true)
        end

        if Script.Feature['Player Spawn Vehicle Lockon'].on[id] then
            vehicle.set_vehicle_can_be_locked_on(veh, false, false)
        end
    end)

    for i = 1, #miscdata.VehicleCategories do
        local Name = miscdata.VehicleCategories[i]

        Script.Parent['Player Spawn ' .. Name] = menu.add_player_feature(Name, 'parent', Script.Parent['Player Spawn Vehicle'], nil).id
        Script.Parent['Lobby Spawn ' .. Name] = menu.add_feature(Name, 'parent', Script.Parent['Lobby Spawn Vehicles'], nil).id
    end

    menu.create_thread(function(Vehicles)
        local done = 0
        for i = 1, #Vehicles do
            if done == 50 then
                coroutine.yield(0)
            end

            local Hash = Vehicles[i].Hash
            local Name = Vehicles[i].Name
            local Category = Vehicles[i].Category

            if (Category == "Trains") or (Category == "Invalid") or (Category == "Utility" and string.find(Name:lower(), "trai")) or not streaming.is_model_a_vehicle(Hash) then
                goto continue
            end

            menu.add_player_feature(Name, 'action', Script.Parent['Player Spawn ' .. Category], function(f, id)
                local pos = get.PlayerCoords(id)
                pos.z = Math.GetGroundZ(pos.x, pos.y)
                local veh = Spawn.Vehicle(Hash, utility.OffsetCoords(pos, get.PlayerHeading(id), 10))
    
                if not utility.request_ctrl(veh, 5000) then
                    Notify('Failed to gain control over spawned Vehicle.\nThe upgrades might not have worked.', "Error", '')
                end
    
                decorator.decor_set_int(veh, 'MPBitset', 1 << 10)
                if Script.Feature['Player Spawn Vehicle Upgraded'].on[id] then
                    utility.MaxVehicle(veh, Script.Feature['Player Spawn Vehicle Upgraded'].value[id] + 1)
                end
    
                if Script.Feature['Player Spawn Vehicle Godmode'].on[id] then
                    entity.set_entity_god_mode(veh, true)
                end
    
                if Script.Feature['Player Spawn Vehicle Lockon'].on[id] then
                    vehicle.set_vehicle_can_be_locked_on(veh, false, false)
                end
            end)

            menu.add_feature(Name, 'action', Script.Parent['Lobby Spawn ' .. Category], function(f)
                for id = 0, 31 do
                    if player.is_player_valid(id) and id ~= player.player_id() and not player.is_player_god(id) and interior.get_interior_from_entity(get.PlayerPed(id)) == 0 then
                        local pos = get.PlayerCoords(id)
                        pos.z = Math.GetGroundZ(pos.x, pos.y)
    
                        local veh = Spawn.Vehicle(Hash, utility.OffsetCoords(pos, get.PlayerHeading(id), 10))
    
                        utility.request_ctrl(veh)
                        decorator.decor_set_int(veh, 'MPBitset', 1 << 10)
    
                        if Script.Feature['Lobby Spawn Vehicle Upgraded'].on then
                            utility.MaxVehicle(veh, Script.Feature['Lobby Spawn Vehicle Upgraded'].value + 1)
                        end
    
                        if Script.Feature['Lobby Spawn Vehicle Godmode'].on then
                            entity.set_entity_god_mode(veh, true)
                        end
    
                        if Script.Feature['Lobby Spawn Vehicle Lockon'].on then
                            vehicle.set_vehicle_can_be_locked_on(veh, false, false)
                        end
    
                    end
                end
            end)

            ::continue::
            done = done + 1
        end
        
    end, mapper.veh.GetAllVehicles())

    Script.Parent['Player CEO Money'] = menu.add_player_feature('CEO Money', 'parent', Script.Parent['Player Friendly'], function()
        if not Script.Feature['Disable Warning Messages'].on then
            Notify('The Target must be an associate in any Organisation to receive the Money.\nEnabling multiple Loops at once can cause Transaction Errors!', "Neutral")
            coroutine.yield(5000)
        end
    end).id

    Script.Feature['Player CEO Loop Preset'] = menu.add_player_feature('Preset', 'value_str', Script.Parent['Player CEO Money'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        if not scriptevent.IsPlayerAssociate(id) then
            Notify('Player is not an associate.', "Error", '')
            f.on = false
            return
        end

        if f.value == 0 then
            menu.create_thread(function()
                while f.on do
                    if scriptevent.IsPlayerAssociate(id) then
                        scriptevent.Send('CEO Money', {player.player_id(), 10000, -1292453789, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id)
                    end
    
                    coroutine.yield(40000)
                end
            end, nil)
    
            coroutine.yield(5000)
            while f.on do
                if scriptevent.IsPlayerAssociate(id) then
                    scriptevent.Send('CEO Money', {player.player_id(), 30000, 198210293, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id)
                end
    
                coroutine.yield(150000)
            end

            return
        end

        local resumenormal  
        while f.on do
            if not resumenormal then
                for i = 1, 5 do
                    for j = 1, 5 do
                        if not f.on then
                            return
                        end

                        if scriptevent.IsPlayerAssociate(id) then
                            scriptevent.Send('CEO Money', {player.player_id(), 10000, -1292453789, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id)
                        end
                        
                        coroutine.yield(30000)
                    end
                        
                    if not f.on then
                        return
                    end

                    coroutine.yield(40000)

                    if scriptevent.IsPlayerAssociate(id) then
                        scriptevent.Send('CEO Money', {player.player_id(), 30000, 198210293, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id)
                    end

                    coroutine.yield(40000)
                end

                resumenormal = true
            end

            for i = 1, 10 do
                if not f.on then
                    return
                end
                 
                if scriptevent.IsPlayerAssociate(id) then
                    scriptevent.Send('CEO Money', {player.player_id(), 10000, -1292453789, 1, scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id)
                end

                coroutine.yield(30000)
            end

            resumenormal = false
        end
    end)
    Script.Feature['Player CEO Loop Preset']:set_str_data({'Fast', 'Stable'})

    for i = 1, #miscdata.ceomoney do
        Script.Feature['Player CEO Loop ' .. i] = menu.add_player_feature(miscdata.ceomoney[i][1] .. ' (ms)', 'value_i', Script.Parent['Player CEO Money'], function(f, id)
            if id == player.player_id() then
                Notify('This doesnt work on yourself.', "Error", '')
                f.on = false
                return
            end

            if not scriptevent.IsPlayerInOrg(id) or scriptevent.IsPlayerCEO(id) then
                Notify('Player is not an associate.', "Error", '')
                f.on = false
                return
            end

            
            settings['Player CEO Loop ' .. i] = {Value = f.value}

            while f.on do
                if not scriptevent.IsPlayerInOrg(id) or scriptevent.IsPlayerCEO(id) then
                    scriptevent.Send('CEO Money', {player.player_id(), miscdata.ceomoney[i][2], miscdata.ceomoney[i][3], miscdata.ceomoney[i][4], scriptevent.MainGlobal(id), scriptevent.GlobalPair()}, id)
                end

                settings['Player CEO Loop ' .. i].Value = f.value
                coroutine.yield(f.value)
            end
            
        end)
        Script.Feature['Player CEO Loop ' .. i].min = 10000
        Script.Feature['Player CEO Loop ' .. i].max = 300000
        Script.Feature['Player CEO Loop ' .. i].mod = 10000
        Script.Feature['Player CEO Loop ' .. i].value = miscdata.ceomoney[i][5]
    end

    Script.Feature['Player Off The Radar'] = menu.add_player_feature('Off The Radar', 'toggle', Script.Parent['Player Friendly'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            if not scriptevent.IsPlayerOTR(id) then
                scriptevent.Send('Off The Radar', {player.player_id(), utils.time() - 60, utils.time(), 1, 1, scriptevent.MainGlobal(id)}, id)
            end

            coroutine.yield(100)
        end
    end)

    Script.Feature['Player Bribe Authorities'] = menu.add_player_feature('Bribe Authorities', 'toggle', Script.Parent['Player Friendly'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            f.on = false
            return
        end

        while f.on do
            scriptevent.Send('Bribe Authorities', {player.player_id(), 0, 0, utils.time_ms(), 0, scriptevent.MainGlobal(id)}, id)
            coroutine.yield(5000)
        end
    end)

    Script.Feature['Player Airstrike Gun'] = menu.add_player_feature('Airstrike Gun', 'toggle', Script.Parent['Player Friendly'], function(f, id)
        while f.on do
            if ped.is_ped_shooting(get.PlayerPed(id)) then
                if not weapon.has_ped_got_weapon(get.OwnPed(), 0xB1CA77B1) then
                    weapon.give_delayed_weapon_to_ped(get.OwnPed(), 0xB1CA77B1, 0, 0)
                    coroutine.yield(1000)
                end

                local whash = gameplay.get_hash_key('weapon_airstrike_rocket')
                local junk, pos = ped.get_ped_last_weapon_impact(get.PlayerPed(id))

                gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 50), pos, 1000, whash, get.OwnPed(), true, false, 5000)

            end

            coroutine.yield(0)
        end
    end)

    Script.Feature['Player Explosive Ammo'] = menu.add_player_feature('Explosive Ammo', 'toggle', Script.Parent['Player Friendly'], function(f, id)
        while f.on do
            local Ped = get.PlayerPed(id)
            if ped.is_ped_shooting(Ped) then
                local shot, pos = ped.get_ped_last_weapon_impact(Ped)
                if shot then
                    fire.add_explosion(pos, 1, true, false, 0.5, 0)
                end
            end

            coroutine.yield(0)
        end
    end)



    Script.Parent['Ped Assassins'] = menu.add_player_feature('Ped Assassins', 'parent', Script.playerparent, nil).id

    Script.Feature['Godmode Assassins'] = menu.add_player_feature('Godmode Assassins', 'toggle', Script.Parent['Ped Assassins'], function(f)
        settings['Godmode Assassins'] = {Enabled = f.on}
    end)

    Script.Feature['Amount of Assassins'] = menu.add_player_feature('Amount of Assassins (1-10)', 'autoaction_value_i', Script.Parent['Ped Assassins'], function(f)
        settings['Amount of Assassins'] = {Value = f.value}
    end)
    Script.Feature['Amount of Assassins'].max = 10
    Script.Feature['Amount of Assassins'].min = 1

    Script.Feature['Clear Assassins'] = menu.add_player_feature('Clear Peds', 'action', Script.Parent['Ped Assassins'], function()
        Log('Clearing Ped Assassins...')
        utility.clear(entitys['peds'])
        entitys['peds'] = {}
        Log('Ped Assassins Successfully Cleared!')
        Notify('Ped Assassins Cleared!', "Success")
    end)

    Script.Feature['Ped Assassins Input'] = menu.add_player_feature('Send Assassins: Input', 'action', Script.Parent['Ped Assassins'], function(f, id)

        local _input = get.Input("Enter ped model name")
        if not _input then
            Notify('Input canceled.', "Error", '')
            return
        end

        local hash = gameplay.get_hash_key(_input)
        local pos
        
        for i = 1, Script.Feature['Amount of Assassins'].value[id] do
            local assassin = entitys['peds'][#entitys['peds'] + 1]

            pos = get.PlayerCoords(id) + v3(math.random(-50, 50), math.random(-50, 50), 0)
            pos.z = Math.GetGroundZ(pos.x, pos.y)

            assassin = Spawn.Ped(hash, pos, 26)
            if ped_type ~= 28 then
                weapon.give_delayed_weapon_to_ped(assassin, 0xDBBD7280, 1, 1)
            end

            if Script.Feature['Godmode Assassins'].on[id] then
                entity.set_entity_god_mode(assassin, true)
            else
                ped.set_ped_max_health(assassin, 328)
                ped.set_ped_health(assassin, 328)
            end

            ped.set_ped_combat_attributes(assassin, 46, true)
            ped.set_ped_combat_ability(assassin, 2)
            ped.set_ped_config_flag(assassin, 187, 0)
            ped.set_ped_can_ragdoll(assassin, false)

            menu.create_thread(Threads.Assassins, {assassin, id})
        end
    end)

    Script.Feature['Ped Assassins Clones'] = menu.add_player_feature('Send Clones', 'action', Script.Parent['Ped Assassins'], function(f, id)
        local pos
        local playerped = get.PlayerPed(id)
        local Weapon = ped.get_current_ped_weapon(playerped)
        if Weapon == 0xA2719263 or Weapon == 0xBA45E8B8 or Weapon == 0xAB564B93 or Weapon == 0x2C3731D9 or Weapon == 0x24B17070 or Weapon == 0x497FACC3 or Weapon == 0x93E220BD then
            Weapon = 0xC0A3098D
        end

        for i = 1, Script.Feature['Amount of Assassins'].value[id] do
            pos = get.PlayerCoords(id) + v3(math.random(-50, 50), math.random(-50, 50), 0)
            pos.z = Math.GetGroundZ(pos.x, pos.y)

            entitys['peds'][#entitys['peds'] + 1] = ped.clone_ped(playerped)
            
            local assassin = entitys['peds'][#entitys['peds']]

            entity.set_entity_coords_no_offset(assassin, pos)
            weapon.give_delayed_weapon_to_ped(assassin, Weapon, 1, 1)

            if Script.Feature['Godmode Assassins'].on[id] then
                entity.set_entity_god_mode(assassin, true)
            else
                ped.set_ped_max_health(assassin, 328)
                ped.set_ped_health(assassin, 328)
            end

            ped.set_ped_combat_attributes(assassin, 46, true)
            ped.set_ped_combat_ability(assassin, 2)
            ped.set_ped_config_flag(assassin, 187, 0)
            ped.set_ped_can_ragdoll(assassin, false)

            menu.create_thread(Threads.Assassins, {assassin, id})
        end
    end)

    for i = 1, #customData.ped_assassins do
        menu.add_player_feature('Send ' .. customData.ped_assassins[i].Name, 'action', Script.Parent['Ped Assassins'], function(f, id)
            local pos
            local hash = customData.ped_assassins[i].Hash
            local ped_type = customData.ped_assassins[i].PedType
            local ped_weapon = customData.ped_assassins[i].Weapon

            if not ped_weapon then 
                ped_weapon = 0xDBBD7280 
            end

            for i = 1, Script.Feature['Amount of Assassins'].value[id] do
                pos = get.PlayerCoords(id) + v3(math.random(-50, 50), math.random(-50, 50), 0)
                pos.z = Math.GetGroundZ(pos.x, pos.y)

                entitys['peds'][#entitys['peds'] + 1] = Spawn.Ped(hash, pos, ped_type)

                local assassin = entitys['peds'][#entitys['peds']]

                if ped_type ~= 28 then
                    weapon.give_delayed_weapon_to_ped(assassin, ped_weapon, 1, 1)
                end

                if Script.Feature['Godmode Assassins'].on[id] then
                    entity.set_entity_god_mode(assassin, true)
                else
                    ped.set_ped_max_health(assassin, 328)
                    ped.set_ped_health(assassin, 328)
                end

                ped.set_ped_combat_attributes(assassin, 46, true)
                ped.set_ped_combat_ability(assassin, 2)
                ped.set_ped_config_flag(assassin, 187, 0)
                ped.set_ped_can_ragdoll(assassin, false)
                ped.set_can_attack_friendly(assassin, false, false)

                menu.create_thread(Threads.Assassins, {assassin, id})
            end
        end)
    end


    Script.Parent['Player SMS Sender'] = menu.add_player_feature('SMS Sender', 'parent', Script.playerparent, function()
        if not Script.Feature['Disable Warning Messages'].on then
            Notify('Only Players who have Voice-Chat enabled can receive SMS.', "Neutral")
        end
    end).id

    Script.Feature['Player Send Custom SMS'] = menu.add_player_feature('Send SMS: Input', 'action', Script.Parent['Player SMS Sender'], function(f, id)
        local msg = get.Input('Enter message to send')
        if not msg then
            Notify('Input canceled.', "Error", '')
            return
        end

        player.send_player_sms(id, msg)
    end)

    Script.Feature['Player Send SCID And IP'] = menu.add_player_feature('Send their SCID & IP', 'action', Script.Parent['Player SMS Sender'], function(f, id)
        local scid = tostring(get.SCID(id))
        local ip = get.IP(id)

        player.send_player_sms(id, 'R*SCID: ' .. scid .. '~n~IP: ' .. ip)
    end)

    Script.Feature['Player SMS Delay'] = menu.add_player_feature('Spam Delay (ms)', 'autoaction_value_i', Script.Parent['Player SMS Sender'], function(f)
        settings['Player SMS Delay'] = {Value = f.value}
    end)
    Script.Feature['Player SMS Delay'].min = 100
    Script.Feature['Player SMS Delay'].max = 10000
    Script.Feature['Player SMS Delay'].mod = 100

    Script.Feature['Player Spam Custom SMS'] = menu.add_player_feature('Spam SMS: Input', 'toggle', Script.Parent['Player SMS Sender'], function(f, id)
        while f.on do
            if not inputs.player_sms_spam then
                local msg = get.Input('Enter message to spam')

                if not msg then
                    Notify('Input canceled.', "Error", '')
                    f.on = false
                    return
                end

                inputs.player_sms_spam = msg
            else
                player.send_player_sms(id, inputs.player_sms_spam)
            end

            coroutine.yield(Script.Feature['Player SMS Delay'].value)
        end
        inputs.player_sms_spam = nil
    end)

    Script.Feature['Player SMS SCID IP'] = menu.add_player_feature('Spam their SCID & IP', 'toggle', Script.Parent['Player SMS Sender'], function(f, id)
        while f.on do
            local scid = tostring(get.SCID(id))
            local ip = get.IP(id)

            player.send_player_sms(id, 'R*SCID: ' .. scid .. ' \nIP: ' .. ip)

            coroutine.yield(Script.Feature['Player SMS Delay'].value)
        end
    end)

    Script.Parent['Player SMS Spam Presets'] = menu.add_player_feature('Spam Presets', 'parent', Script.Parent['Player SMS Sender'], nil).id

    for i = 1, #customData.sms_texts do
        menu.add_player_feature(customData.sms_texts[i], 'toggle', Script.Parent['Player SMS Spam Presets'], function(f, id)
            while f.on do
                player.send_player_sms(id, customData.sms_texts[i])

                coroutine.yield(Script.Feature['Player SMS Delay'].value)
            end
        end)
    end
    

    Script.Parent['Player Miscellaneous'] = menu.add_player_feature('Miscellaneous', 'parent', Script.playerparent, nil).id
    
    
    Script.Parent['Player Custom SE'] = menu.add_player_feature('Custom Script Events', 'parent', Script.Parent['Player Miscellaneous'], nil).id

    Script.Feature['Player Custom SE Input'] = menu.add_player_feature('Send Script Event: Input', 'action', Script.Parent['Player Custom SE'], function(f, id)
        if id == player.player_id() then
            Notify('This doesnt work on yourself.', "Error", '')
            return
        end
        
        local params = {}
        local _input
        local customevent = get.Input('Enter Custom Script Event (DEC)', 32, 3)
        if not customevent then
            Notify('Input canceled.', "Error", '')
            return
        end
        while _input ~= '#' do
            _input = get.Input('Enter Parameter (DEC), to EXIT and send, enter #', 32)
            if not _input then
                return
            end
            if _input == '#' then
                break
            end
            _input = tonumber(_input)
            if type(_input) == 'number' then
                params[#params + 1] = _input
            else
                return
            end
        end
        scriptevent.Send(customevent, params, id)
        Notify('Sent Custom Script Event to Player.', "Success", '')
    end)

    for i = 1, #customData.custom_script_events do
        menu.add_player_feature(customData.custom_script_events[i].Name, 'action', Script.Parent['Player Custom SE'], function(f, id)
            if id == player.player_id() then
                Notify('This doesnt work on yourself.', "Error", '')
                return
            end

            Notify('Sent Custom Script Event to Player.', "Success", '')
            for x = 1, #customData.custom_script_events[i].Events do
                scriptevent.Send(customData.custom_script_events[i].Events[x].Hash, customData.custom_script_events[i].Events[x].Args, id)
            end
        end)
    end

    Script.Feature['Player Log Script Events'] = menu.add_player_feature('Log Script Events', 'toggle', Script.Parent['Player Miscellaneous'], function(f, id)
        while f.on do
            if hooks.script[id] == nil then
                hooks.script[id] = hook.register_script_event_hook(function(source, target, params, count)
                    if source == id then
                        local prefix = Math.TimePrefix()
                        local scid = get.SCID(id)
                        local name = get.Name(id)
                        local uuid = tostring(scid) .. '-' .. name
                        local file = paths['Event-Logger'] .. '\\' .. uuid .. '\\' .. 'Script-Events.log'
                        local prefix = prefix .. ' [Script-Event-Logger]'
                        local text = prefix
                        if not utils.dir_exists(paths['Event-Logger']) then
                            utils.make_dir(paths['Event-Logger'])
                        end
                        if not utils.dir_exists(paths['Event-Logger'] .. '\\' .. uuid) then
                            utils.make_dir(paths['Event-Logger'] .. '\\' .. uuid)
                        end
                        if not utils.file_exists(file) then
                            Notify("Logging to folder '2Take1Script/Event-Logger/" .. uuid, "Success")
                            text =
                                'Starting to log Script-Events from Player: ' ..
                                name .. ':' .. scid .. '\n' .. prefix
                        end
                        text = text .. '\n' .. params[1] .. ', {'
                        for i = 2, #params do
                            text = text .. params[i]
                            if i ~= #params then
                                text = text .. ', '
                            end
                        end
                        text = text .. '}\n'
                        text = text .. 'Parameter count: ' .. count - 1 .. '\n'
                        utility.write(io.open(file, 'a'), text)
                        print(text)
                    end
                end)
            end
            coroutine.yield(0)
        end
        if hooks.script[id] then
            hook.remove_script_event_hook(hooks.script[id])
            hooks.script[id] = nil
        end
    end)

    Script.Feature['Player Reset SE Log'] = menu.add_player_feature('Reset Script Event Log', 'action', Script.Parent['Player Miscellaneous'], function(f, id)
        local scid = get.SCID(id)
        local name = get.Name(id)
        local uuid = tostring(scid) .. '-' .. name
        local file = paths['Event-Logger'] .. '\\' .. uuid .. '\\' .. 'Script-Events.log'
        if utils.file_exists(file) then
            io.remove(file)
        else
            Notify('There was no log to reset.', "Error", '')
        end
    end)

    Script.Feature['Player Log Net Events'] = menu.add_player_feature('Log net_events', 'toggle', Script.Parent['Player Miscellaneous'], function(f, id)
        while f.on do
            if hooks.net[id] == nil then
                hooks.net[id] = hook.register_net_event_hook(function(source, target, eventId)
                    if source == id then
                        local prefix = Math.TimePrefix()
                        local scid = get.SCID(id)
                        local name = get.Name(id)
                        local uuid = tostring(scid) .. '-' .. name
                        local file = paths['Event-Logger'] .. '\\' .. uuid .. '\\' .. 'Net-Events.log'
                        local prefix = prefix .. ' [Net-Event-Logger]'
                        local text = prefix
                        if not utils.dir_exists(paths['Event-Logger']) then
                            utils.make_dir(paths['Event-Logger'])
                        end
                        if not utils.dir_exists(paths['Event-Logger'] .. '\\' .. uuid) then
                            utils.make_dir(paths['Event-Logger'] .. '\\' .. uuid)
                        end
                        if not utils.file_exists(file) then
                            Notify("Logging to folder 2Take1Script/Event-Logger/" .. uuid, "Success")
                            text =
                                'Starting to log Net-Events from Player: ' ..
                                name .. ':' .. scid .. '\n' .. text
                        end
                        local event_name = mapper.net.GetEventName(eventId)
                        text = text .. '\nEvent: ' .. event_name .. '\nEvent ID: ' .. eventId .. '\n'
                        utility.write(io.open(file, 'a'), text)
                    end
                end)
            end
            coroutine.yield(0)
        end
        if hooks.net[id] then
            hook.remove_net_event_hook(hooks.net[id])
            hooks.net[id] = nil
        end
    end)

    Script.Feature['Player Reset Net Log'] = menu.add_player_feature('Reset net_event Log', 'action', Script.Parent['Player Miscellaneous'], function(f, id)
        local scid = get.SCID(id)
        local name = get.Name(id)
        local uuid = tostring(scid) .. '-' .. name
        local file = paths['Event-Logger'] .. '\\' .. uuid .. '\\' .. 'Net-Events.log'
        if utils.file_exists(file) then
            io.remove(file)
        else
            Notify('There was no log to reset.', "Error", '')
        end
    end)


    Script.Parent['Entity Spam'] = menu.add_player_feature('Entity Spam', 'parent', Script.playerparent, function()
        if not Script.Feature['Disable Warning Messages'].on then
            Notify('Its recommended to keep distance from the Target while using this.', "Neutral")
            coroutine.yield(5000)
        end
    end).id

    Script.Feature['Entity Spam Amount'] = menu.add_player_feature('Amount of Entities', 'autoaction_value_i', Script.Parent['Entity Spam'], function(f)
        settings['Entity Spam Amount'] = {Value = f.value}
    end)
    Script.Feature['Entity Spam Amount'].max = 160
    Script.Feature['Entity Spam Amount'].min = 10
    Script.Feature['Entity Spam Amount'].mod = 10

    Script.Feature['Entity Spam Location'] = menu.add_player_feature('Spam Loaction', 'autoaction_value_str', Script.Parent['Entity Spam'], function(f)
        settings['Entity Spam Location'] = {Value = f.value}
    end)
    Script.Feature['Entity Spam Location']:set_str_data({'Around Player', 'Above Player', 'On top of Player'})

    Script.Feature['Entity Spam Cleanup'] = menu.add_player_feature('Automatic Cleanup', 'toggle', Script.Parent['Entity Spam'], function(f)
        settings['Entity Spam Cleanup'] = {Enabled = f.on}
    end)

    Script.Feature['Entity Spam Clear'] = menu.add_player_feature('Delete Spam Entities', 'action', Script.Parent['Entity Spam'], function()
        Log('Clearing Spam Entities...')
        utility.clear(entitys['entity_spam'])
        entitys['entity_spam'] = {}
        Log('Spam Entities Successfully Cleared!')
        Notify('Spam Entities Cleared!', "Success")
    end)

    Script.Parent['Entity Spam Presets'] = menu.add_player_feature('Spam Presets', 'parent', Script.Parent['Entity Spam'], nil).id

    for i = 1, #customData.entity_spam do
        menu.add_player_feature(customData.entity_spam[i].Name, 'action', Script.Parent['Entity Spam Presets'], function(f, id)
            local hash = customData.entity_spam[i].Hash
            local pos

            if streaming.is_model_a_ped(hash) then
                for i = 1, Script.Feature['Entity Spam Amount'].value[id] do
                    if Script.Feature['Entity Spam Location'].value[id] == 0 then
                        pos = get.PlayerCoords(id) + v3(math.random(-10, 10), math.random(-10, 10), 0)
                        pos.z = Math.GetGroundZ(pos.x, pos.y)
                    elseif Script.Feature['Entity Spam Location'].value[id] == 1 then
                        pos = get.PlayerCoords(id) + v3(0, 0, 75)
                    else
                        pos = get.PlayerCoords(id) + v3(0, 0, 1)
                    end

                    entitys['entity_spam'][#entitys['entity_spam'] + 1] = Spawn.Ped(hash, pos)
                    coroutine.yield(0)
                end

            elseif streaming.is_model_a_vehicle(hash) then
                for i = 1, Script.Feature['Entity Spam Amount'].value[id] do
                    if Script.Feature['Entity Spam Location'].value[id] == 0 then
                        pos = get.PlayerCoords(id) + v3(math.random(-10, 10), math.random(-10, 10), 0)
                        pos.z = Math.GetGroundZ(pos.x, pos.y)
                    elseif Script.Feature['Entity Spam Location'].value[id] == 1 then
                        pos = get.PlayerCoords(id) + v3(0, 0, 75)
                    else
                        pos = get.PlayerCoords(id) + v3(0, 0, 1)
                    end

                    entitys['entity_spam'][#entitys['entity_spam'] + 1] = Spawn.Vehicle(hash, pos)
                    coroutine.yield(0)
                end

            elseif streaming.is_model_an_object(hash) then
                for i = 1, Script.Feature['Entity Spam Amount'].value[id] do
                    if Script.Feature['Entity Spam Location'].value[id] == 0 then
                        pos = get.PlayerCoords(id) + v3(math.random(-10, 10), math.random(-10, 10), 0)
                        pos.z = Math.GetGroundZ(pos.x, pos.y)
                    elseif Script.Feature['Entity Spam Location'].value[id] == 1 then
                        pos = get.PlayerCoords(id) + v3(0, 0, 75)
                    else
                        pos = get.PlayerCoords(id) + v3(0, 0, 1)
                    end

                    entitys['entity_spam'][#entitys['entity_spam'] + 1] = Spawn.Object(hash, pos)
                    coroutine.yield(0)
                end

            else
                Notify('Invalid Preset!\nHash is not a valid entity', "Error", '')
                return
            end

            if not Script.Feature['Entity Spam Cleanup'].on[id] then
                Notify("Entities sent", "Success")
                return
            end

            Notify("Entities sent, starting cleanup in 10 seconds...", "Success")
            coroutine.yield(10000)
            
            utility.clear(entitys['entity_spam'])
            entitys['entity_spam'] = {}
            Notify('Cleanup complete!', "Success")
        end)
    end

    Script.Feature['Ped Spam Input'] = menu.add_player_feature('Ped: Input', 'action', Script.Parent['Entity Spam'], function(f, id)
        local _input = get.Input("Enter Ped Model Name or Hash")
        if not _input then
            Notify('Input canceled.', "Error", '')
            return
        end

        local hash = _input
        if not tonumber(_input) then
            hash = gameplay.get_hash_key(_input)
        end

        if not streaming.is_model_a_ped(hash) then
            Notify('Input is not a valid ped.', "Error", '')
            return
        end

        for i = 1, Script.Feature['Entity Spam Amount'].value[id] do
            local pos
            if Script.Feature['Entity Spam Location'].value[id] == 0 then
                pos = get.PlayerCoords(id) + v3(math.random(-10, 10), math.random(-10, 10), 0)
                pos.z = Math.GetGroundZ(pos.x, pos.y)
            elseif Script.Feature['Entity Spam Location'].value[id] == 1 then
                pos = get.PlayerCoords(id) + v3(0, 0, 10)
            else
                pos = get.PlayerCoords(id) + v3(0, 0, 1)
            end
            entitys['entity_spam'][#entitys['entity_spam'] + 1] = Spawn.Ped(hash, pos)
            coroutine.yield(0)
        end

        if not Script.Feature['Entity Spam Cleanup'].on[id] then
            Notify("Peds sent", "Success")
            return
        end

        Notify("Peds sent, starting cleanup in 10 seconds...", "Success")
        coroutine.yield(10000)

        utility.clear(entitys['entity_spam'])
        entitys['entity_spam'] = {}
        Notify('Cleanup complete!', "Success")
    end)

    Script.Feature['Vehicle Spam Input'] = menu.add_player_feature('Vehicle: Input', 'action', Script.Parent['Entity Spam'], function(f, id)
        local _input = get.Input("Enter Vehicle Model Name or Hash")
        if not _input then
            Notify('Input canceled.', "Error", '')
            return
        end

        local hash = _input
        if not tonumber(_input) then
            hash = gameplay.get_hash_key(_input)
        end

        if not streaming.is_model_a_vehicle(hash) then
            Notify('Input is not a valid vehicle.', "Error", '')
            return
        end

        for i = 1, Script.Feature['Entity Spam Amount'].value[id] do
            local pos
            if Script.Feature['Entity Spam Location'].value[id] == 0 then
                pos = get.PlayerCoords(id) + v3(math.random(-10, 10), math.random(-10, 10), 0)
                pos.z = Math.GetGroundZ(pos.x, pos.y)
            elseif Script.Feature['Entity Spam Location'].value[id] == 1 then
                pos = get.PlayerCoords(id) + v3(0, 0, 10)
            else
                pos = get.PlayerCoords(id) + v3(0, 0, 1)
            end
            entitys['entity_spam'][#entitys['entity_spam'] + 1] = Spawn.Vehicle(hash, pos)
        end

        if not Script.Feature['Entity Spam Cleanup'].on[id] then
            Notify("Vehicles sent", "Success")
            return
        end

        Notify('Vehicles sent, starting cleanup in 10 seconds...', "Success")
        coroutine.yield(10000)

        utility.clear(entitys['entity_spam'])
        entitys['entity_spam'] = {}
        Notify('Cleanup complete!', "Success") 
    end)

    Script.Feature['Object Spam Input'] = menu.add_player_feature('Object: Input', 'action', Script.Parent['Entity Spam'], function(f, id)
        local _input = get.Input("Enter Object Model Name or Hash")
        if not _input then
            Notify('Input canceled.', "Error", '')
            return
        end

        local hash = _input
        if not tonumber(_input) then
            hash = gameplay.get_hash_key(_input)
        end

        if not streaming.is_model_an_object(hash) then
            Notify('Input is not a valid object.', "Error", '')
            return
        end

        for i = 1, Script.Feature['Entity Spam Amount'].value[id] do
            local pos
            if Script.Feature['Entity Spam Location'].value[id] == 0 then
                pos = get.PlayerCoords(id) + v3(math.random(-10, 10), math.random(-10, 10), 0)
                pos.z = Math.GetGroundZ(pos.x, pos.y)
            elseif Script.Feature['Entity Spam Location'].value[id] == 1 then
                pos = get.PlayerCoords(id) + v3(0, 0, 10)
            else
                pos = get.PlayerCoords(id) + v3(0, 0, 1)
            end
            entitys['entity_spam'][#entitys['entity_spam'] + 1] = Spawn.Object(hash, pos)
            coroutine.yield(0)
        end

        if not Script.Feature['Entity Spam Cleanup'].on[id] then
            Notify("Objects sent", "Success")
            return
        end

        Notify("Objects sent, starting cleanup in 10 seconds...", "Success")
        coroutine.yield(10000)
        
        utility.clear(entitys['entity_spam'])
        entitys['entity_spam'] = {}
        Notify('Cleanup complete!', "Success") 
    end)

    Script.Feature['Dump All Entites onto Player'] = menu.add_player_feature('Dump All Entites onto Player', 'action', Script.Parent['Entity Spam'], function(f, id)
        if id == player.player_id() then
            Notify('Doing this on yourself would result in a crash.', "Error", '')
            return
        end
        
        local pos = get.PlayerCoords(id)
        local allpeds = ped.get_all_peds()
        local allvehicles = vehicle.get_all_vehicles()
        local allobjects = object.get_all_objects()
        local ownped = get.OwnPed()
        local ownvehicle = get.OwnVehicle()

        for i = 1, #allpeds do
            if allpeds[i] ~= ownped then
                entity.set_entity_coords_no_offset(allpeds[i], pos)
            end
        end
        for i = 1, #allvehicles do
            if allvehicles[i] ~= ownvehicle then
                entity.set_entity_coords_no_offset(allvehicles[i], pos)
            end
        end
        for i = 1, #allobjects do
            entity.set_entity_coords_no_offset(allobjects[i], pos)
        end
    end)
    

    Script.Parent['Player Malicious'] = menu.add_player_feature('Malicious', 'parent', Script.playerparent, nil).id

    Script.Feature['Host Kick'] = menu.add_player_feature('Host Kick', 'action', Script.Parent['Player Malicious'], function(f, id)
        if not network.network_is_host() then
            Notify('You are not Session Host!', "Error", '')
            return
        end

        network.network_session_kick_player(id)
    end)

    Script.Feature['Player Script Event Kick'] = menu.add_player_feature('Script Event Kick', 'action_value_str', Script.Parent['Player Malicious'], function(f, id)
        if id == player.player_id() then
            Notify('No point in doing that.', "Error", '')
            return
        end

        scriptevent.kick(id, f.value + 1)
    end)
    Script.Feature['Player Script Event Kick']:set_str_data({'Normal', 'Netbail', 'Invalid Apartment Invite'})

    Script.Feature['Player Script Event Crash'] = menu.add_player_feature('Script Event Crash', 'action', Script.Parent['Player Malicious'], function(f, id)
        if id == player.player_id() then
            Notify('No point in doing that.', "Error", '')
            return
        end

        scriptevent.crash(id)
    end)

    Script.Feature['Player Net Event Crash'] = menu.add_player_feature('Net Event Crash', 'action_value_str', Script.Parent['Player Malicious'], function(f, id)
        if id == player.player_id() then
            Notify('No point in doing that.', "Error", '')
            return
        end

        local sounds = {
            {Name = 'ROUND_ENDING_STINGER_CUSTOM', Ref = 'CELEBRATION_SOUNDSET'},
            {Name = 'Object_Dropped_Remote', Ref = 'GTAO_FM_Events_Soundset'},
            {Name = 'Oneshot_Final', Ref = 'MP_MISSION_COUNTDOWN_SOUNDSET'},
            {Name = '5s', Ref = 'MP_MISSION_COUNTDOWN_SOUNDSET'}
        }

        local sound = sounds[math.random(#sounds)]

        local range
        if f.value == 0 then
            range = 1
        else
            range = 100
        end

        local time = utils.time_ms() + 2500

        while time > utils.time_ms() do
            local pos = player.get_player_coords(id)

            for i = 1, 10 do
                audio.play_sound_from_coord(-1, sound.Name, pos, sound.Ref, true, range, false)
            end

            coroutine.yield(0)
        end
        
    end)
    Script.Feature['Player Net Event Crash']:set_str_data({'Low Range', 'High Range'})

    Script.Feature['Player Tow Truck Crash'] = menu.add_player_feature('Tow Truck Crash', 'action', Script.Parent['Player Malicious'], function(f, id)
        if id == player.player_id() then
            Notify('No point in doing that.', "Error", '')
            return
        end

        local pos = get.PlayerCoords(id)

        local truck = Spawn.Vehicle(0xE5A2D6C6, utility.OffsetCoords(v3(pos.x, pos.y, pos.z + 5), get.PlayerHeading(id), 10))
        local boat = Spawn.Vehicle(0x82CAC433, pos)

        entity.set_entity_visible(truck, false)
        entity.set_entity_visible(boat, false)

        entity.attach_entity_to_entity(boat, truck, 0, v3(), v3(), true, true, false, 0, true)

        Notify("Crash sent, starting cleanup in 5 seconds...", "Success")
        coroutine.yield(10000)

        utility.clear({boat, truck})
        coroutine.yield(500)

        if not entity.is_an_entity(truck) then
            Notify('Cleanup successful!', "Success")
        else
            Notify('Cleanup failed!', "Error")
        end

    end)

    Script.Feature['World Object Crash'] = menu.add_player_feature('World Object Crash', 'action_value_str', Script.Parent['Player Malicious'], function(f, id)
        if id == player.player_id() then
            Notify('No point in doing that.', "Error", '')
            return
        end

        local worldhashes = {
            386259036, 450174759, 1567950121, 1734157390, 1759812941, 2040219850, -1231365640, 1727217687, 3613262246
            -993438434, -990984874, -818431457, -681705050, -568850501, 3301528862, 3303982422, 3476535839, 3726116795
        }

        if f.value == 0 then
            local hash = worldhashes[math.random(#worldhashes)]
            local crashobj = Spawn.Worldobject(hash, get.PlayerCoords(id), true, false)
            
            Notify('Crash sent, attemping cleanup in 5 seconds. Its recommended not to look at the Target', "Success")
            coroutine.yield(5000)

            utility.clear(crashobj)
            coroutine.yield(500)

            if not entity.is_an_entity(crashobj) then
                Notify('Cleanup Successful!', "Success")
            else
                Notify('Cleanup failed!', "Error")
            end
            return
        end

        local fulltable = Randomize(worldhashes)
        local objects = {}
        
        for i = 1, #fulltable do
            local Hash = worldhashes[fulltable[i]]
            objects[#objects + 1] = Spawn.Worldobject(Hash, get.PlayerCoords(id), true, false)
        end
            
        Notify('Crash sent, attemping cleanup in 5 seconds. Its recommended not to look at the Target', "Success")
        coroutine.yield(5000)

        utility.clear(objects)
        Notify('Cleanup Complete!', "Success")
    end)
    Script.Feature['World Object Crash']:set_str_data({'v1', 'v2'})

    Script.Feature['Invalid Entity Crash'] = menu.add_player_feature('Invalid Entity Crash', 'action_value_str', Script.Parent['Player Malicious'], function(f, id)
        if id == player.player_id() then
            Notify('No point in doing that.', "Error", '')
            return
        end

        local Coords = get.PlayerCoords(id)
        local Position = get.OwnCoords()

        if not f.value == 2 and Position:magnitude(Coords) < 1000 then
            Notify('You are too close to the Target.')
            return
        end

        local crashent
        local pos = utility.OffsetCoords(Coords, get.PlayerHeading(id), 10)

        if f.value == 0 then
            local hashes = {0x3F039CBA, 0x856CFB02, 0x2D7030F3}
            crashent = Spawn.Ped(hashes[math.random(#hashes)], pos)

        elseif f.value == 1 then
            local hashes = {956849991, 1133471123, 2803699023, 386089410, 1549009676}
            crashent = Spawn.Vehicle(hashes[math.random(#hashes)], pos)

        elseif f.value == 2 then
            local hash = gameplay.get_hash_key("exc_prop_tr_meet_stool_01")
            crashent = Spawn.Object(hash, pos, true, false)
        end

        Notify('Crash sent, attemping cleanup in 5 seconds...\nAvoid going near the Target!', "Success")
        coroutine.yield(5000)

        utility.clear(crashent)
        coroutine.yield(500)

        if not entity.is_an_entity(crashent) then
            Notify('Cleanup Successful!', "Success")
        else
            Notify('Cleanup failed!', "Error")
        end
    end)
    Script.Feature['Invalid Entity Crash']:set_str_data({'Ped', 'Vehicle', 'Object'})

    Script.Feature['Invalid Outfit Crash'] = menu.add_player_feature('Invalid Outfit Crash', 'action', Script.Parent['Player Malicious'], function(f, id)
        if id == player.player_id() then
            Notify('No point in doing that.', "Error", '')
            return
        end

        local OwnPed = get.OwnPed()
        local OwnPosition = get.OwnCoords()
    
        local Torso = ped.get_ped_drawable_variation(OwnPed, 3)
        local Torso2 = ped.get_ped_drawable_variation(OwnPed, 8)
        local Feet = ped.get_ped_drawable_variation(OwnPed, 6)
        local Legs = ped.get_ped_drawable_variation(OwnPed, 4)
    
        if player.is_player_female(player.player_id()) then
            ped.set_ped_component_variation(OwnPed, 3, 415, 0, 0)
            ped.set_ped_component_variation(OwnPed, 8, 234, 0, 0)
            ped.set_ped_component_variation(OwnPed, 6, 106, 0, 0)
            ped.set_ped_component_variation(OwnPed, 4, 151, 0, 0)
        else
            ped.set_ped_component_variation(OwnPed, 3, 393, 0, 0)
            ped.set_ped_component_variation(OwnPed, 8, 189, 0, 0)
            ped.set_ped_component_variation(OwnPed, 6, 102, 0, 0)
            ped.set_ped_component_variation(OwnPed, 4, 144, 0, 0)
        end
    
        for i = 1, 10 do
            entity.set_entity_coords_no_offset(OwnPed, get.PlayerCoords(id))
            coroutine.yield(200)
        end
    
        coroutine.yield(500)
    
        ped.set_ped_component_variation(OwnPed, 3, Torso, 0, 0)
        ped.set_ped_component_variation(OwnPed, 8, Torso2, 0, 0)
        ped.set_ped_component_variation(OwnPed, 6, Feet, 0, 0)
        ped.set_ped_component_variation(OwnPed, 4, Legs, 0, 0)
        entity.set_entity_coords_no_offset(OwnPed, OwnPosition)
    
        Notify('Crash Complete!', "Success", '')
    end)

    Script.Feature['Next-Gen Crash'] = menu.add_player_feature('"Next-Gen Crash"', 'action_value_str', Script.Parent['Player Malicious'], function(f, id)
        local hashes = {1349725314, 3253274834}
        local Position = utility.OffsetCoords(get.PlayerCoords(id), get.PlayerHeading(id), 10)

        local CrashVeh = Spawn.Vehicle(hashes[f.value + 1], Position)
    
        utility.MaxVehicle(CrashVeh, nil, true)
    
        Notify('Crash sent, attemping cleanup in 5 seconds.', "Success")
        coroutine.yield(5000)

        utility.clear(CrashVeh)
        coroutine.yield(500)

        if not entity.is_an_entity(CrashVeh) then
            Notify('Cleanup Successful!', "Success")
        else
            Notify('Cleanup failed!', "Error")
        end
    end)
    Script.Feature['Next-Gen Crash']:set_str_data({'v1', 'v2'})

    Script.Feature['Player AIO Crash'] = menu.add_player_feature('AIO', 'action', Script.Parent['Player Malicious'], function(f, id)
        if id == player.player_id() then
            Notify('No point in doing that.', "Error", '')
            return
        end

        local Coords = get.PlayerCoords(id)
        local Position = get.OwnCoords()

        if Position:magnitude(Coords) < 1000 then
            Notify('You are too close to the Target.')
            return
        end

        local Entities = {}

        Notify('AIO Crash starting in 5 seconds. Dont go near the Target!', "Error", '')
        coroutine.yield(5000)

        menu.create_thread(function()
            Entities[#Entities + 1] = Spawn.Vehicle(1349725314, Coords)
    
            utility.MaxVehicle(Entities[Entities])
        end, nil)

        menu.create_thread(function()
            local hashes = {956849991, 1133471123, 2803699023, 386089410, 1549009676}

            for i = 1, #hashes do
                Entities[#Entities + 1] = Spawn.Vehicle(hashes[i], Coords)
            end
        end, nil)

        menu.create_thread(function()
            Entities[#Entities + 1] = Spawn.Object(gameplay.get_hash_key("exc_prop_tr_meet_stool_01"), Coords)
        end, nil)

        menu.create_thread(function()
            local time = utils.time_ms() + 2500

            while time > utils.time_ms() do
                local pos = player.get_player_coords(id)
    
                for i = 1, 10 do
                    audio.play_sound_from_coord(-1, "ROUND_ENDING_STINGER_CUSTOM", pos, "CELEBRATION_SOUNDSET", true, 1, false)
                end
    
                coroutine.yield(0)
            end
        end, nil)

        menu.create_thread(function()
            local hashes = {0x3F039CBA, 0x856CFB02, 0x2D7030F3}
            
            for i = 1, #hashes do
                Entities[#Entities + 1] = Spawn.Ped(hashes[i], Coords)
            end
        end, nil)

        menu.create_thread(function()
            local worldhashes = {
                386259036, 450174759, 1567950121, 1734157390, 1759812941, 2040219850, -1231365640, 1727217687, 3613262246
                -993438434, -990984874, -818431457, -681705050, -568850501, 3301528862, 3303982422, 3476535839, 3726116795
            }
            local fulltable = Randomize(worldhashes)
            
            for i = 1, #fulltable do
                local Hash = worldhashes[fulltable[i]]
                Entities[#Entities + 1] = Spawn.Worldobject(Hash, Coords, true, false)
            end
        end, nil)

        menu.create_thread(function()
            Entities[#Entities + 1] = Spawn.Vehicle(0xE5A2D6C6, Coords)
            local truck = Entities[#Entities]
            Entities[#Entities + 1] = Spawn.Vehicle(0x82CAC433, Coords)
            local boat = Entities[#Entities]
    
            entity.set_entity_visible(truck, false)
            entity.set_entity_visible(boat, false)
    
            entity.attach_entity_to_entity(boat, truck, 0, v3(), v3(), true, true, false, 0, true)
        end, nil)

        menu.create_thread(function()
            scriptevent.crash(id)
        end, nil)

        Notify('AIO Crash sent, attemping cleanup in 5 seconds...\nAvoid going near the Target!', "Success", '')
        coroutine.yield(5000)
        utility.clear(Entities)
        Notify('Cleanup Complete.', "Success", '')
    end)
-- End of Player Features

    if utils.file_exists(files['DefaultConfig']) then
        setup.Log('Loading Settings...')
        setup.LoadSettings()
    else
        setup.Log('Creating Default Config...')
        setup.SaveSettings()
    end

    if Script.Feature['Weapon Loadout Toggle'].on then
        weapon.remove_all_ped_weapons(get.OwnPed())
    end

    settings['Vehicle Blacklist Reaction'] = {Value = Script.Feature['Vehicle Blacklist Reaction'].value}
    settings['Player Bar Text Green'] = {Value = Script.Feature['Player Bar Text Green'].value}
    settings['Player Bar Text Red'] = {Value = Script.Feature['Player Bar Text Red'].value}
    settings['Player Bar Text Blue'] = {Value = Script.Feature['Player Bar Text Blue'].value}
    settings['Kill Aura Range'] = {Value = Script.Feature['Kill Aura Range'].value}
    settings['Kill Aura Option'] = {Value = Script.Feature['Kill Aura Option'].value}
    settings['Force Field Range'] = {Value = Script.Feature['Force Field Range'].value}
    settings['Force Field Strength'] = {Value = Script.Feature['Force Field Strength'].value}
    settings['Bodyguard Health'] = {Value = Script.Feature['Bodyguard Health'].value}
    settings['Bodyguard Behavior'] = {Value = Script.Feature['Bodyguard Behavior'].value}
    settings['Bodyguard Distance'] = {Value = Script.Feature['Bodyguard Distance'].value}
    settings['Bodyguard Formation'] = {Value = Script.Feature['Bodyguard Formation'].value}
    settings['Bodyguard Count'] = {Value = Script.Feature['Bodyguard Count'].value}
    settings['Vehicle Colors Speed'] = {Value = Script.Feature['Vehicle Colors Speed'].value}
    settings['AI Driving Style'] = {Value = Script.Feature['AI Driving Style'].value}
    settings['Sound Spam Speed'] = {Value = Script.Feature['Sound Spam Speed'].value}
    settings['Explosion Delay'] = {Value = Script.Feature['Explosion Delay'].value}
    settings['Explosion Camshake'] = {Value = Script.Feature['Explosion Camshake'].value}
    settings['Chat Spam Delay'] = {Value = Script.Feature['Chat Spam Delay'].value}
    settings['SMS Delay'] = {Value = Script.Feature['SMS Delay'].value}
    settings['Player Blacklist Kick Type'] = {Value = Script.Feature['Player Blacklist Kick Type'].value}
    settings['Ad Blacklist Kick Type'] = {Value = Script.Feature['Ad Blacklist Kick Type'].value}
    settings['Player Bar Text Allign'] = {Value = Script.Feature['Player Bar Text Allign'].value}

    for i = 0, 31 do
        if player.is_player_valid(i) then
            playerlogging[i] = {ID = i, Name = get.Name(i)}
        end
    end

    -- Dev stuff
    if utils.file_exists(files['Dev']) then
        _2t1sdevParent = menu.add_feature('Dev Features', 'parent', Script.mainparent, nil).id
        _2t1sdevPlayerparent = menu.add_player_feature('Dev Features', 'parent', Script.playerparent, nil).id
        local dev = loadfile(files['Dev'])
        dev()
    end

    return true
end

if mainScript() then
    setup.Log('2Take1Script Successfully executed!')
    Notify('2Take1Script Successfully executed!', "Success")
end