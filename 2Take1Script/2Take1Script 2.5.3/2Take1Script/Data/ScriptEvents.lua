local scriptevents = {
    ['Netbail Kick'] = 0x493FC6BB, --requires script global 1
    ['Netbail Kick 2'] = 0x9C050EC, --requires script global 1
    ['Kick 1'] = 0x37437C28,
    ['Kick 2'] = 0xB1FCAF3A,
    ['Kick 3'] = 0x364F7E34,
    ['Kick 4'] = 0xEEB39C54,
    ['Kick 5'] = 0xEA0A4E2C,
    ['Kick 6'] = 0xDB601EE5,
    ['Kick 7'] = 0x894EE698,
    ['Kick 8'] = 0xFC173895,
    ['Kick 9'] = 0x96ACD460,
    ['Kick 10'] = 0x562BAE0D,
    ['Kick 11'] = 0x428AE4D5,
    ['Kick 12'] = 0x1A0416B7,
    ['Kick 13'] = 0x95C21538,
    ['Kick 14'] = 0x8A924376,
    ['Kick 15'] = 0x68C5399F,
    ['Kick 16'] = 0x23F74138,
    ['Crash 1'] = 0xE88ECD48,
    ['Crash 2'] = 0xAD63290E,
    ['Crash 3'] = 0x39624029,
    ['Script Host Curse 1'] = 0x820DD3E4,
    ['Script Host Curse 2'] = 0x2A0520FE,
    ['Script Host Curse 3'] = 0xD11E424B,
    ['Passive Mode'] = 0x4267B065,
    ['CEO Kick'] = 0xED6F046,
    ['CEO Ban'] = 0xD26E4A01,
    ['CEO Money'] = 0x70AB59D5, --requires script global 1, pair
    ['Force To Mission'] = 0x786FBAAE,
    ['Force To Mission 2'] = 0xA517E3C8,
    ['Start Freemode Mission'] = 0x1F1FFC3A,
    ['Force To Island'] = 0xDAF8082C,
    ['Casino Cutscene'] = 0x3FAC59CA,
    ['Transaction Error'] = 0x9A6CDD38, --requires script global 1, pair
    ['Camera Manipulation'] = 0x2FC154DC,
    ['Off The Radar'] = 0xE8A824A0, --requires script global 1
    ['Bribe Authorities'] = 0x66B0F59A, --requires script global 1
    ['Insurance Notification'] = 0x2FCF970F,
    ['Notification 2'] = 0x285DDF33,
    ['Typing Begin'] = 0x2C8A72D0,
    ['Typing Stop'] = 0xC4EF2D0B,
    ['Fake Invite'] = 0x43865AE4,
    ['Apartment Invite'] = 0x23F74138,
    ['Warehouse Invite'] = 0xE56661F6,
    ['Script Freeze'] = 0x57420247,
    ['Vehicle Kick'] = 0x2280A552,
    ['Vehicle EMP'] = 0x863B6494,
    ['Destroy Personal Vehicle'] = 0xC2CC7762,
    ['SMS'] = 0x717AB445,
    ['Bounty'] = 0x4D3010A8, --requires script global pair
    ['Remove Wanted'] = 0xFA8E0C52, --requires script global 1
}

function scriptevents.MainGlobal(Target)
    return script.get_global_i(1893551 + (1 + (Target * 599) + 510))
end

function scriptevents.IsPlayerInOrg(Target)
    return script.get_global_i(1893551 + (1 + (Target * 599)) + 10) ~= -1
end

function scriptevents.IsPlayerAssociate(Target)
    return (script.get_global_i(1893551 + (1 + (Target * 599)) + 10) ~= -1 and script.get_global_i(1893551 + (1 + (Target * 599)) + 10) ~= Target)
end

function scriptevents.IsPlayerCEO(Target)
    return script.get_global_i(1893551 + (1 + (Target * 599)) + 10) == Target
end

function scriptevents.IsPlayerOTR(Target)
    return script.get_global_i(2689224 + (1 + (Target * 451)) + 207) == 1
end

function scriptevents.DoesPlayerHaveBounty(Target)
    return script.get_global_i(1835502 + (1 + (Target * 4)) + 3) == 1
end

function scriptevents.GetPersonalVehicle(Target)
    return script.get_global_i(2703660 + (173 + Target + 1))
end

function scriptevents.GlobalPair()
    return script.get_global_i(1921039 + 9), script.get_global_i(1921036 + 10)
end


function scriptevents.Send(Event, Params, Target, Friendcheck)
    if not Target or not player.is_player_valid(Target) or Target == player.player_id() then
        return
    end

    if not tonumber(Event) then
        if scriptevents[Event] then
            Event = scriptevents[Event]
        else
            return
        end
    end

    if Friendcheck and player.is_player_friend(Target) then
        return
    end

    script.trigger_script_event(Event, Target, Params)
end

function scriptevents.setBounty(Target, Amount, Anonymous)
    if not Target or not player.is_player_valid(Target) then
        return
    end

    for id = 0, 31 do
        if player.is_player_valid(id) then
            script.trigger_script_event(scriptevents['Bounty'], id, {player.player_id(), Target, 1, Amount or 10000, 0, Anonymous,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, scriptevents.GlobalPair()})
        end
    end
end

local function random_args(ID, Amount, Min, Max)
    local args = {ID}
    if not Amount or Amount == 0 then
        return args
    end

    if not Min then
        Min = -2147483647
    end

    if not Max then
        Max = 2147483647
    end

    for i = 1, Amount do
        args[#args + 1] = math.random(Min, Max)
    end

    return args
end

local function Randomize(Table)
    for i = #Table, 2, -1 do
        local j = math.random(i)
        Table[i], Table[j] = Table[j], Table[i]
    end
    
    return Table
end

function scriptevents.kick(Target, Version, Friendcheck)
    if not Target or not player.is_player_valid(Target) then
        return
    end

    Version = Version or 1
    Friendcheck = Friendcheck or false

    if Friendcheck and player.is_player_friend(Target) then
        return
    end

    if Version == 1 then
        local events = {}
        for i = 1, 15 do
            events[#events + 1] = scriptevents['Kick ' .. i]
        end

        local EventTable = Randomize(events)

        for i = 1, #EventTable do
            script.trigger_script_event(EventTable[i], Target, random_args(player.player_id(), 25))
            print(EventTable[i] .. ':' .. i)
        end

    elseif Version == 2 then
        script.trigger_script_event(scriptevents['Netbail Kick 2'], Target, {player.player_id(), scriptevents.MainGlobal(Target)})
        script.trigger_script_event(scriptevents['Netbail Kick'], Target, {player.player_id(), scriptevents.MainGlobal(Target)})
    elseif Version == 3 then
        local args = random_args(player.player_id(), 25)
        args[2] = math.random(32, 2147483647)
        args[4] = 1
        args[5] = 115
        script.trigger_script_event(scriptevents['Kick 16'], Target, args)
        args[2] = math.random(-2147483647, -1)
        script.trigger_script_event(scriptevents['Kick 16'], Target, args)
    end
end

function scriptevents.crash(Target, Friendcheck)
    if not Target or not player.is_player_valid(Target) then
        return
    end
    
    Friendcheck = Friendcheck or false

    if Friendcheck and player.is_player_friend(Target) then
        return
    end

    for i = 1, 3 do
        script.trigger_script_event(scriptevents['Crash ' .. i], Target, random_args(player.player_id(), 25))
    end
end

function scriptevents.curse(Version)
    local id = script.get_host_of_this_script()
    if player.is_player_valid(id) then
        script.trigger_script_event(scriptevents['Script Host Curse ' .. Version], id, random_args(player.player_id(), 25))
    end
end

return scriptevents