local get = {}

function get.name(playerID)
	if player.is_player_valid(playerID) then
		return player.get_player_name(playerID)
	end
	return "Invalid Player"
end

function get.scid(playerID)
	if player.is_player_valid(playerID) then
		local SCID = player.get_player_scid(playerID)
		if SCID ~= 4294967295 then
			return SCID
		end
	end
	return -1
end

function get.ip(playerID)
    if player.is_player_valid(playerID) then
		local IP = player.get_player_ip(playerID)
		return string.format("%i.%i.%i.%i", (IP >> 24) & 0xff, ((IP >> 16) & 0xff), ((IP >> 8) & 0xff), IP & 0xff)
	end
	return "0.0.0.0"
end

function get.input(title, max_lenght, input_type, default_string)
	if not title then
		return
	end
	default_string = default_string or ""
	max_lenght = max_lenght or 128
	input_type = input_type or 0
	if input_type ~= 0 and input_type ~= 1 and input_type ~= 2 and input_type ~= 3 and input_type ~= 4 and input_type ~= 5 then
		return
	end
	local response_code, msg = input.get(title, default_string, max_lenght, input_type)
	while response_code == 1 do
		system.wait(0)
		response_code, msg = input.get(title, default_string, max_lenght, input_type)
	end
	if response_code == 2 then
		return
	end
	return msg
end

return get