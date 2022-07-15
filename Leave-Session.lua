menu.add_feature("Leave Session", "action", 0, function ()
	local time = utils.time_ms() + 8500
	while time > utils.time_ms() do end
end)