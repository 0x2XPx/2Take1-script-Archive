local mf = {}

function mf.p(name, place, callback)
	return menu.add_feature(name, "parent", place, callback)
end

function mf.t(name, place, callback)
	return menu.add_feature(name, "toggle", place, callback)
end

function mf.a(name, place, callback)
	return menu.add_feature(name, "action", place, callback)
end

function mf.v(name, place, callback)
	return menu.add_feature(name, "value_i", place, callback)
end

function mf.av(name, place, callback)
	return menu.add_feature(name, "action_value_i", place, callback)
end

function mf.aav(name, place, callback)
	return menu.add_feature(name, "autoaction_value_i", place, callback)
end

function mf.pp(name, place, callback)
	return menu.add_player_feature(name, "parent", place, callback)
end

function mf.pt(name, place, callback)
	return menu.add_player_feature(name, "toggle", place, callback)
end

function mf.pa(name, place, callback)
	return menu.add_player_feature(name, "action", place, callback)
end

function mf.pv(name, place, callback)
	return menu.add_player_feature(name, "value_i", place, callback)
end

function mf.pav(name, place, callback)
	return menu.add_player_feature(name, "action_value_i", place, callback)
end

function mf.paav(name, place, callback)
	return menu.add_player_feature(name, "autoaction_value_i", place, callback)
end

return mf