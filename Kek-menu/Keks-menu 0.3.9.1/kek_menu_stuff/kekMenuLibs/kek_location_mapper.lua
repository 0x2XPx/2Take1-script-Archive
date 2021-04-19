-- Lib location_mapper version: 0.1.1
-- Made by Kektram

local los_santos_customs =
	{
		{"Beeker's garage", v3(112, 6619, 31)},
		{"Blaine county", v3(1178, 2647, 37)},
		{"Near airport", v3(-1146, -1991, 13)},
		{"East side", v3(722, -1090, 22)},
		{"City center", v3(-357, -135, 38)},
		{"Benny's workshop", v3(-208, -1310, 31)}
	}

local ammu_nations = 
	{
		{"Blaine county center", v3(1699, 3752, 34)},
		{"Blaine county west", v3(-1113, 2690, 18)},
		{"Blaine county east", v3(2569, 303, 108)},
		{"Blaine county upper west", v3(-3164, 1082, 20)},
		{"Paleto bay", v3(-326, 6076, 31)},
		{"City north", v3(243, -45, 69)},
		{"City east", v3(844, -1025, 28)},
		{"City west", v3(-1316, -391, 36)},
		{"City center", v3(-664, -945, 21)},
		{"With range city center", v3(17, -1117, 29)},
		{"With range city south", v3(811, -2148, 29)}
	}

local casino_locations = 
	{
		{"Casino main entrance", v3(921, 42, 80)},
		{"Casino garage", v3(936, 0, 79)},
		{"Casino music locker", v3(988, 80, 81)}
	}

local kek_location_mapper = {}

local function get_vectors(location_info_table)
	local vectors = {}
	for i, location in pairs(location_info_table) do
		vectors[#vectors + 1] = location[2]
	end
	return vectors
end

function kek_location_mapper.get_casino_locations()
	return get_vectors(casino_locations)
end

function kek_location_mapper.get_los_santos_customs_locations()
	return get_vectors(los_santos_customs)
end

function kek_location_mapper.get_ammu_nation_locations()
	return get_vectors(ammu_nations)
end

return kek_location_mapper