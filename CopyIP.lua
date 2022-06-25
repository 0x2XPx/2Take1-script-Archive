menu.add_player_feature("Copy IP", "action", 0, function(f, pid)
	if not player.is_player_valid(pid) then
		return HANDLER_POP
	end
	
	local ip = player.get_player_ip(pid)
	utils.to_clipboard(string.format("%i.%i.%i.%i", ip >> 24 & 255, ip >> 16 & 255, ip >> 8 & 255, ip & 255))
	menu.notify("IP copied to clipboard", "Copy IP", 10, 0xFFFFFF00)
end)