if RSEGon then
    menu.notify('Script already loaded.')
    return
end

local function log(text, c_prefix, file_name)
    local path = os.getenv("APPDATA").."\\PopstarDevs\\2Take1Menu\\scripts"
    utils.make_dir(path.."\\RSEG")
    local log_file = io.open(path.."\\RSEG\\"..file_name, "a")
    local t = os.date("*t")
    if t.month < 10 then
        t.month = "0" .. t.month
    end
    if t.day < 10 then
        t.day = "0" .. t.day
    end
    if t.hour < 10 then
        t.hour = "0" .. t.hour
    end
    if t.min < 10 then
        t.min = "0" .. t.min
    end
    if t.sec < 10 then
        t.sec = "0" .. t.sec
    end
    local prefix = "["..t.year.."-"..t.month.."-"..t.day.." "..t.hour..":"..t.min..":"..t.sec.."] "
    if c_prefix ~= nil then
        prefix = prefix..c_prefix.." "
    end
    io.output(log_file)
    io.write(prefix..text.."\n")
    io.close(log_file)
end
-- submenus
local rsegm = menu.add_feature("RSEG", "parent", 0).id
local valuesetm = menu.add_feature("Value Settings", "parent", rsegm).id
local delaysetm = menu.add_feature("Delay Settings", "parent", rsegm).id
local searchm = menu.add_feature("Search", "parent", rsegm)
-- player submenus
local rsegp = menu.add_player_feature("RSEG", "parent", 0).id
local valuesetp = menu.add_player_feature("Value Settings", "parent", rsegp).id
local searchp = menu.add_player_feature("Search", "parent", rsegp)
-- credits
local function Credits()
menu.notify("sub1to/Cynical, Making 2take1 and its lua\nDemon Kiya, Function help and Bully\nProddy, Making some things nicer", "Credits")
end
Credits()
-- other vars
local RSEGv = "1.4.0"
local pc = 0
local pct = 0

-- value vars
local mDelay = 0
local mRangeMin
local mRangeMax
local mCountMin
local mCountMax
--
local pDelay = 0
local pRangeMin
local pRangeMax
local pCountMin
local pCountMax
--
local dMod = 0
local dNot = false
-- rseg all feature value customisaiton
mRangeMin = menu.add_feature('Arg Value Min', 'action_value_i', valuesetm, function(f)
    local error, value = input.get('Enter Min Value', '', 10, 3)

    while error == 1 do
        error, value = input.get('Enter Min Value', '', 10, 3)
        system.wait(0)
    end

    if error == 2 then
        menu.notify('Input canceled.')
        return
    end

    value = tonumber(value)

    if value < -2147483647 or value > 2147483646 then
        menu.notify('Min value must be between -2147483647 and 2147483646.')
        return
    end

    if value > mRangeMax.value then
        menu.notify('Min value cannot be higher than the max value.')
        return
    end

    f.value = value
end)
mRangeMin.min = -2147483647
mRangeMin.max = 2147483647
mRangeMin.value = -2147483647

mRangeMax = menu.add_feature('Arg Value Max', 'action_value_i', valuesetm, function(f)
    local error, value = input.get('Enter Max Value', '', 10, 3)

    while error == 1 do
        error, value = input.get('Enter Max Value', '', 10, 3)
        system.wait(0)
    end

    if error == 2 then
        menu.notify('Input canceled.')
        return
    end

    value = tonumber(value)

    if value < -2147483646 or value > 2147483647 then
        menu.notify('Min value must be between -2147483646 and 2147483647.')
        return
    end

    if value < mRangeMin.value then
        menu.notify('Max value cannot be smaller than the min value.')
        return
    end

    f.value = value
end)
mRangeMax.min = -2147483647
mRangeMax.max = 2147483647
mRangeMax.value = 2147483647

mCountMin = menu.add_feature('Arg Count Min', 'action_value_i', valuesetm, function(f)
    local error, value = input.get('Enter Max Count', '', 2, 3)

    while error == 1 do
        error, value = input.get('Enter Max Count', '', 2, 3)
        system.wait(0)
    end

    if error == 2 then
        menu.notify('Input canceled.')
        return
    end

    value = tonumber(value)

    if value < 2 or value > 9 then
        menu.notify('Min count must be between 2 and 9')
        return
    end

    if value >= mCountMax.value then
        menu.notify('Min count must be lower than the max count.')
        return
    end

    f.value = value
end)
mCountMin.min = 2
mCountMin.max = 9
mCountMin.value = 2

mCountMax = menu.add_feature('Arg Count Max', 'action_value_i', valuesetm, function(f)
    local error, value = input.get('Enter Max Count', '', 2, 3)

    while error == 1 do
        error, value = input.get('Enter Max Count', '', 2, 3)
        system.wait(0)
    end

    if error == 2 then
        menu.notify('Input canceled.')
        return
    end

    value = tonumber(value)

    if value < 3 or value > 10 then
        menu.notify('Max count must be between 3 and 10')
        return
    end

    if value <= mCountMin.value then
        menu.notify('Max count must be greater than the min count.')
        return
    end

    f.value = value
end)
mCountMax.min = 2
mCountMax.max = 9
mCountMax.value = 9
-- rseg player feature modifications
pRangeMin = menu.add_player_feature('Arg Value Min', 'action_value_i', valuesetp, function(f, pid)
    local error, value = input.get('Enter Min Value', '', 10, 3)

    while error == 1 do
        error, value = input.get('Enter Min Value', '', 10, 3)
        system.wait(0)
    end

    if error == 2 then
        menu.notify('Input canceled.')
        return
    end

    value = tonumber(value)

    if value < -2147483647 or value > 2147483646 then
        menu.notify('Min value must be between -2147483647 and 2147483646.')
        return
    end

    if value > pRangeMax.value[pid] then
        menu.notify('Min value cannot be higher than the max value.')
        return
    end

    f.value = value
end)
pRangeMin.min = -2147483647
pRangeMin.max = 2147483647
pRangeMin.value = -2147483647

pRangeMax = menu.add_player_feature('Arg Value Max', 'action_value_i', valuesetp, function(f, pid)
    local error, value = input.get('Enter Max Value', '', 10, 3)

    while error == 1 do
        error, value = input.get('Enter Max Value', '', 10, 3)
        system.wait(0)
    end

    if error == 2 then
        menu.notify('Input canceled.')
        return
    end

    value = tonumber(value)

    if value < -2147483646 or value > 2147483647 then
        menu.notify('Min value must be between -2147483646 and 2147483647.')
        return
    end

    if value < pRangeMin.value[pid] then
        menu.notify('Max value cannot be smaller than the min value.')
        return
    end

    f.value = value
end)
pRangeMax.min = -2147483647
pRangeMax.max = 2147483647
pRangeMax.value = 2147483647

pCountMin = menu.add_player_feature('Arg Count Min', 'action_value_i', valuesetp, function(f, pid)
    local error, value = input.get('Enter Max Count', '', 2, 3)

    while error == 1 do
        error, value = input.get('Enter Max Count', '', 2, 3)
        system.wait(0)
    end

    if error == 2 then
        menu.notify('Input canceled.')
        return
    end

    value = tonumber(value)

    if value < 2 or value > 9 then
        menu.notify('Min count must be between 2 and 9')
        return
    end

    if value >= pCountMax.value[pid] then
        menu.notify('Min count must be lower than the max count.')
        return
    end

    f.value = value
end)
pCountMin.min = 2
pCountMin.max = 9
pCountMin.value = 2

pCountMax = menu.add_player_feature('Arg Count Max', 'action_value_i', valuesetp, function(f, pid)
    local error, value = input.get('Enter Max Count', '', 2, 3)

    while error == 1 do
        error, value = input.get('Enter Max Count', '', 2, 3)
        system.wait(0)
    end

    if error == 2 then
        menu.notify('Input canceled.')
        return
    end

    value = tonumber(value)

    if value < 3 or value > 10 then
        menu.notify('Max count must be between 3 and 10')
        return
    end

    if value <= pCountMin.value[pid] then
        menu.notify('Max count must be greater than the min count.')
        return
    end

    f.value = value
end)
pCountMax.min = 2
pCountMax.max = 9
pCountMax.value = 9

menu.add_feature("Delay Notifications", "toggle", delaysetm, function(f)
    if f.on then
        dNot = true
    else
        dNot = false
    end
end)
-- delay settings
local DMod = menu.add_feature("Delay Modifier", "autoaction_value_i", delaysetm, function(f)
    dMod = f.value
    if dNot then
        menu.notify("Delay Mod set to: "..dMod)
    end
    f.min = 0
    f.max = 100
    f.mod = 1
end)

menu.add_feature("All RSEG Delay", "autoaction_value_i", delaysetm, function(f)
    mDelay = f.value
    if dNot then
        menu.notify("All RSEG Delay set to: "..mDelay)
    end
    f.min = 0
    f.max = 2000
    f.mod = DMod.value
end)

menu.add_feature("Player RSEG Delay", "autoaction_value_i", delaysetm, function(f)
    pDelay = f.value
    if dNot then
        menu.notify("Player RSEG Delay set to: "..pDelay)
    end
    f.min = 0
    f.max = 2000
    f.mod = DMod.value
end)

menu.add_feature("Current Delay Value", "action", delaysetm, function(f)
    menu.notify("All RSEG Delay: "..mDelay.."\nPlayer RSEG Delay: "..pDelay)
end)

local sehashes = require("RSEL")
-- for RSEG ALL
--[[local function rseg(hash, pid)
    local pname = player.get_player_name(pid)
    local amount = math.random(mCountMin.value, mCountMax.value)
    local argtable = {}

    argtable[1] = math.random(0, 31)
    for i = 2, #amount do
        argtable[i] = math.random(mRangeMin.value, mRangeMax.value)
    end

    script.trigger_script_event(hash, pid, argtable)
    local RSEG = ("script.trigger_script_event("..hash..", "..pid..", ("..table.concat(argtable, ", ")..")")
    log(RSEG, "[PID: "..pid.."] [Name: "..pname.."]", "Name - "..pname..".log")
end]]
local function rseg(hash, pid)
    local pname = player.get_player_name(pid)
    local sarg1 = math.random(0, 31)
    local sarg2 = math.random(mRangeMin.value, mRangeMax.value)
    local sarg3 = math.random(mRangeMin.value, mRangeMax.value)
    local sarg4 = math.random(mRangeMin.value, mRangeMax.value)
    local sarg5 = math.random(mRangeMin.value, mRangeMax.value)
    local sarg6 = math.random(mRangeMin.value, mRangeMax.value)
    local sarg7 = math.random(mRangeMin.value, mRangeMax.value)
    local sarg8 = math.random(mRangeMin.value, mRangeMax.value)
    local sarg9 = math.random(mRangeMin.value, mRangeMax.value)
    local sarg10 = math.random(mRangeMin.value, mRangeMax.value)
    local sargs = {
        {sarg1, sarg2},
        {sarg1, sarg2, sarg3},
        {sarg1, sarg2, sarg3, sarg4},
        {sarg1, sarg2, sarg3, sarg4, sarg5},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7, sarg8},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7, sarg8, sarg9},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7, sarg8, sarg9, sarg10}
    }
    local s = math.random(mCountMin.value, mCountMax.value)
    script.trigger_script_event(hash, pid, sargs[s])
    local RSEG = ("script.trigger_script_event("..hash..", "..pid..", ("..table.concat(sargs[s], ", ")..")")
    log(RSEG, "[PID: "..pid.."] [Name: "..pname.."]", "Name - "..pname..".log")
end

local hash1 = nil
--[[local function rseg2(hash, pid)
    local pname = player.get_player_name(pid)
    local amount = math.random(pCountMin.value[pid], pCountMax.value[pid])
    local argtable = {}

    argtable[1] = math.random(0, 31)
    for i = 2, amount do
        argtable[i] = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    end

    script.trigger_script_event(hash, pid, argtable)
    local RSEG = ("script.trigger_script_event("..hash..", "..pid..", ("..table.concat(argtable, ", ")..")")
    log(RSEG, "[PID: "..pid.."] [Name: "..pname.."]", "Name - "..pname..".log")
end]]
local function rseg2(hash2, pid)
    local pname = player.get_player_name(pid)
    local sarg1 = math.random(0, 31)
    local sarg2 = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    local sarg3 = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    local sarg4 = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    local sarg5 = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    local sarg6 = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    local sarg7 = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    local sarg8 = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    local sarg9 = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    local sarg10 = math.random(pRangeMin.value[pid], pRangeMax.value[pid])
    local sargs = {
        {sarg1, sarg2},
        {sarg1, sarg2, sarg3},
        {sarg1, sarg2, sarg3, sarg4},
        {sarg1, sarg2, sarg3, sarg4, sarg5},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7, sarg8},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7, sarg8, sarg9},
        {sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7, sarg8, sarg9, sarg10}
    }
    local s = math.random(pCountMin.value[pid], pCountMax.value[pid])
    script.trigger_script_event(hash2, pid, sargs[s])
    local RSEG = ("script.trigger_script_event("..hash2..", "..pid..", ("..table.concat(sargs[s], ", ")..")")
    log(RSEG, "[PID: "..pid.."] [Name: "..pname.."]", "Name - "..pname..".log")
end

local function SendHashAll(f)
    f.data = f.data + 1
    if f.data > #sehashes then
        f.data = 1
    end
    local me = player.player_id()
    for pid=0,31 do
        if pid ~= me and player.is_player_valid(pid) then
            rseg(sehashes[f.data], pid)
        end
    end
end
menu.add_feature("RSEG all players", "action", rsegm, function(f)
    SendHashAll(f)
end).data = 0
menu.add_feature("RSEG all players", "toggle", rsegm, function(f)
    while f.on do
        SendHashAll(f)
        system.wait(mDelay)
    end
end).data = 0

menu.add_player_feature("Reset Counter", "action", rsegp, function()
pc = 0
pct = 0
end)

menu.add_player_feature("RSEG Player", "action", rsegp, function(f, pid)
    pc = pc + 1
        if pc > #sehashes then pc = 1 end
    hash1 = sehashes[pc]
    rseg2(hash1, pid)
end)
menu.add_player_feature("RSEG Player", "toggle", rsegp, function(f, pid)
    while f.on do
        pct = pct + 1
            if pct > #sehashes then pct = 1 end
        hash1 = sehashes[pct]
        rseg2(hash1, pid)
        system.wait(pDelay)
    end
end)

local pResults = {}

local numbersearch = menu.add_player_feature('Value Search: ', 'action_value_str', searchp.id, function(f)
    local code, value = input.get('Enter Search Value', '', 10, 2)

    while code == 1 do
        coroutine.yield(0)
        code, value = input.get('Enter Search Value', '', 10, 2)
    end

    if code == 2 then
        menu.notify('Input canceled.')
        return
    end

    if #pResults > 0 then
        for i = 1, #pResults do
            menu.delete_player_feature(pResults[i].id)
            pResults[i] = nil
        end
    end

    for i = 1, #sehashes do
        if string.find(sehashes[i], value, 1) then
            pResults[#pResults + 1] = menu.add_player_feature(sehashes[i], 'action', searchp.id, function(f, pid)
                rseg2(sehashes[i], pid)
            end)
        end
    end

    menu.notify(#pResults .. ' results')

    f:set_str_data({value})
end)
numbersearch:set_str_data({' '})

menu.add_player_feature('Clear Search', 'action', searchp.id, function(f)
    if #pResults > 0 then
        for i = 1, #pResults do
            menu.delete_player_feature(pResults[i].id)
            pResults[i] = nil
        end
        menu.notify('Search cleared.')
    else
        menu.notify('No results found.')
    end
    numbersearch:set_str_data({' '})
end)

local mResults = {}

local Mnumbersearch = menu.add_feature('Value Search: ', 'action_value_str', searchm.id, function(f)
    local code, value = input.get('Enter Search Value', '', 10, 2)

    while code == 1 do
        coroutine.yield(0)
        code, value = input.get('Enter Search Value', '', 10, 2)
    end

    if code == 2 then
        menu.notify('Input canceled.')
        return
    end

    if #mResults > 0 then
        for i = 1, #mResults do
            menu.delete_feature(mResults[i].id)
            mResults[i] = nil
        end
    end

    for i = 1, #sehashes do
        if string.find(sehashes[i], value, 1) then
            mResults[#mResults + 1] = menu.add_feature(sehashes[i], 'action', searchm.id, function()
                for pid=0,31 do
                    rseg(sehashes[i], pid)
                end
            end)
        end
    end

    menu.notify(#mResults .. ' results')

    f:set_str_data({value})
end)
Mnumbersearch:set_str_data({' '})

menu.add_feature('Clear Search', 'action', searchm.id, function(f)
    if #mResults > 0 then
        for i = 1, #mResults do
            menu.delete_feature(mResults[i].id)
            mResults[i] = nil
        end
        menu.notify('Search cleared.')
    else
        menu.notify('No results found.')
    end
    Mnumbersearch:set_str_data({' '})
end)

menu.notify("RandomScriptEventGenerator successfully loaded\nVersion: "..RSEGv)
RSEGon = true