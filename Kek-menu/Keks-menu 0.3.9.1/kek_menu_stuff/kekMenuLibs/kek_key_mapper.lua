-- Lib key_mapper version: 1.0.1
-- Made by Kektram
-- {"Name of the key", int control, int inputGroup}

local controller_keys =
	{
		{"A", 18, 2},
		{"B", 45, 2}, 
		{"X", 22, 2}, 
		{"Y", 23, 2}, 
		{"LB", 37, 2}, 
		{"RB", 44, 2}, 
		{"L2", 10, 2}, 
		{"R2", 11, 2}, 
		{"L3", 28, 2}, 
		{"R3", 29, 2}, 
		{"select", 0, 2}, 
		{"D-Pad left", 15, 2}, 
		{"D-Pad right", 74, 2}, 
		{"D-Pad up", 27, 2}, 
		{"D-Pad down", 19, 2}, 
		{"Right-stick left", 5, 2}, 
		{"Right-stick right", 1, 2}, 
		{"Right-stick up", 3, 2}, 
		{"Right-stick down", 2, 2}, 
		{"Left-stick left", 34, 2}, 
		{"Left-stick right", 9, 2}, 
		{"Left-stick up", 32, 2}, 
		{"Left-stick down", 8, 2}
	}

local keyboard_keys = 
	{
		{"A", 34, 0},
		{"B", 29, 0},
		{"C", 26, 0},
		{"D", 30, 0},
		{"E", 46, 0},
		{"F", 49, 0},
		{"G", 183, 0},
		{"H", 74, 0},
		{"K", 311, 0},
		{"L", 7, 0},
		{"M", 301, 0},
		{"N", 249, 0},
		{"P", 199, 0},
		{"Q", 44, 0},
		{"R", 45, 0},
		{"S", 33, 0},
		{"T", 245, 0},
		{"U", 303, 0},
		{"V", 0, 0},
		{"W", 32, 0},
		{"X", 252, 0},
		{"Y", 246, 0},
		{"arrow up", 172, 0},
		{"arrow down", 173, 0},
		{"arrow left", 174, 0},
		{"arrow right", 175, 0},
		{"left alt", 19, 0},
		{"f1", 288, 0},
		{"f2", 289, 0},
		{"f3", 170, 0},
		{"f5", 166, 0},
		{"f6", 167, 0},
		{"f7", 168, 0},
		{"f8", 169, 0},
		{"f9", 56, 0},
		{"f10", 57, 0},
		{"f11", 344, 0},
		{"1", 157, 0},
		{"2", 158, 0},
		{"3", 160, 0},
		{"4", 164, 0},
		{"5", 165, 0},
		{"6", 159, 0},
		{"7", 161, 0},
		{"8", 162, 0},
		{"9", 163, 0},
		{"left shift", 21, 0},
		{"Break", 3, 0},
		{"Numpad enter", 201, 0},
		{"Mouse scroll down", 14, 0},
		{"Mouse scroll up", 15, 0},
		{"Left mouse click", 142, 0},
		{"Right mouse click", 114, 0},
		{"Left control", 132, 0},
		{"Numpad 4", 124, 0},
		{"Numpad 5", 128, 0},
		{"Numpad 6", 125, 0},
		{"Numpad 7", 117, 0},
		{"Numpad 8", 127, 0},
		{"Numpad 9", 118, 0},
		{"Space", 143, 0},
		{"Insert", 121, 0},
		{"Caps lock", 137, 0},
		{"Delete", 178, 0},
		{"Tab", 192, 0},
		{"Backspace", 194, 0},
		{"Esc", 200, 0},
		{"Page down", 207, 0},
		{"Page up", 208, 0},
		{"Home", 212, 0},
		{"Enter", 215, 0},
		{"Numpad +", 314, 0},
		{"Numpad -", 315, 0},
		{"]", 40, 0}
	}

local mouse_inputs =
	{
		{"Mouse scroll down", 14, 0},
		{"Mouse scroll up", 15, 0},
		{"Mouse down", 332, 0},
		{"Mouse right", 333, 0},
		{"Left mouse click", 142, 0},
		{"Right mouse click", 114, 0}
	}

local kek_key_mapper = {}

function kek_key_mapper.get_keyboard_key_from_name(key)
	for i, key_name in pairs(keyboard_keys) do
		if key_name[1] == key then
			return key_name[2], key_name[3]
		end
	end
	return -1
end

function kek_key_mapper.get_controller_key_from_name(key)
	for i, key_name in pairs(controller_keys) do
		if key_name[1] == key then
			return key_name[2], key_name[3]
		end
	end
	return -1
end

function kek_key_mapper.get_keyboard_key_name_from_control_int(key)
	for i, key_name in pairs(keyboard_keys) do
		if key_name[2] == key then
			return key_name[1]
		end
	end
	return "TURNED OFF!"
end

function kek_key_mapper.get_controller_key_name_from_control_int(key)
	for i, key_name in pairs(controller_keys) do
		if key_name[2] == key then
			return key_name[1]
		end
	end
	return "TURNED OFF!"
end

function kek_key_mapper.get_keyboard_key_control_int_from_name(key)
	for i, key_name in pairs(keyboard_keys) do
		if key_name[1] == key then
			return key_name[2]
		end
	end
	return -1
end

function kek_key_mapper.get_controller_key_control_int_from_name(key)
	for i, key_name in pairs(controller_keys) do
		if key_name[1] == key then
			return key_name[2]
		end
	end
	return -1
end

function kek_key_mapper.get_all_keyboard_keys()
	return keyboard_keys
end

function kek_key_mapper.get_all_controller_keys()
	return controller_keys
end

return kek_key_mapper
