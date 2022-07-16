local script_func = {}

function script_func.get_global_main(pid)
    return script.get_global_i(1893551 + (1 + (pid * 599) + 510))
end

function script_func.get_global_9()
    return script.get_global_i(1921039 + 9)
end

function script_func.get_global_10()
    return script.get_global_i(1921039 + 10)
end

function script_func.get_player_money(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 56)
end

function script_func.get_player_rank(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 6)
end

function script_func.get_player_ceo_int(pid)
    return script.get_global_i(1893551 + 1 + 10 + 104 + (pid * 599))
end

function script_func.get_player_kd(pid)
    return script.get_global_f(1853131 + (1 + (pid * 888)) + 205 + 26)
end

function script_func.get_player_deaths(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 29)
end

function script_func.get_player_kills(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 28)
end

function script_func.get_player_wallet(pid)
    return script.get_global_i(1853131 + (1 + (pid * 888)) + 205 + 3)
end

function script_func.is_player_in_any_org(pid)
    if player.is_player_valid(pid) then
        if script.get_global_i(1893551 + (1 + (pid * 599)) + 10) ~= -1 then
            return true
        else
            return false
        end
    else
        return false
    end
end

function script_func.is_player_associate(pid)
    if player.is_player_valid(pid) then
        if script.get_global_i(1893551 + (1 + (pid * 599)) + 10) ~= -1 and script.get_global_i(1893551 + (1 + (pid * 599)) + 10) ~= pid then
            return true
        else
            return false
        end
    else
        return false
    end
end

function script_func.is_player_otr(pid)
    if player.is_player_valid(pid) then
        if script.get_global_i(2689224 + (1 + (pid * 451)) + 207) == 1 then
            return true
        else
            return false
        end
    else
        return false
    end
end

function script_func.get_player_money_str(pid)
	local money = script_func.get_player_money(pid)
	local money_str = tostring("$ ")
	if money >= 1000000000 then
		money = money / 1000000000
		money_str = money_str .. money .. " B"
	elseif money >= 1000000 then
		money = money / 1000000
		money_str = money_str .. money .. " M"
	elseif money >= 1000 then
		money = money / 1000
		money_str = money_str .. money .. " K"
	else
		money_str = money_str .. money
	end
	return money_str
end

return script_func