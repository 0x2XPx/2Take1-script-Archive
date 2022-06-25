--Made by GhostOne

local Ghost = {}
Ghost.charCodes = {
	{
		{0x30, "0", ")"},
		{0x31, "1", "!"},
		{0x32, "2", "@"},
		{0x33, "3", "#"},
		{0x34, "4", "$"},
		{0x35, "5", "%"},
		{0x36, "6", "^"},
		{0x37, "7", "&"},
		{0x38, "8", "*"},
		{0x39, "9", "("},
		{0x41, "A"},
		{0x42, "B"},
		{0x43, "C"},
		{0x44, "D"},
		{0x45, "E"},
		{0x46, "F"},
		{0x47, "G"},
		{0x48, "H"},
		{0x49, "I"},
		{0x4A, "J"},
		{0x4B, "K"},
		{0x4C, "L"},
		{0x4D, "M"},
		{0x4E, "N"},
		{0x4F, "O"},
		{0x50, "P"},
		{0x51, "Q"},
		{0x52, "R"},
		{0x53, "S"},
		{0x54, "T"},
		{0x55, "U"},
		{0x56, "V"},
		{0x57, "W"},
		{0x58, "X"},
		{0x59, "Y"},
		{0x5A, "Z"},
		{0x60, "0", ")"},
		{0x61, "1", "!"},
		{0x62, "2", "@"},
		{0x63, "3", "#"},
		{0x64, "4", "$"},
		{0x65, "5", "%"},
		{0x66, "6", "^"},
		{0x67, "7", "&"},
		{0x68, "8", "*"},
		{0x69, "9", "("},
		{0x20, " "},
		{0xBA, ";", ":"},
		{0xBB, "=", "+"},
		{0xBC, ",", "<"},
		{0xBD, "-", "_"},
		{0xBE, ".", ">"},
		{0xBF, "/", "?"},
		{0xC0, "`", "~"},
		{0xDB, "[", "{"},
		{0xDC, "\\", "|"},
		{0xDD, "]", "}"},
		{0xDE, "\'", "\""},
		{0x6A, "*"},
		{0x6B, "+"},
		{0x6D, "-"},
		{0x6E, "."},
		{0x6F, "/"}
	},
	{
		{0x41, "A"},
		{0x42, "B"},
		{0x43, "C"},
		{0x44, "D"},
		{0x45, "E"},
		{0x46, "F"},
		{0x47, "G"},
		{0x48, "H"},
		{0x49, "I"},
		{0x4A, "J"},
		{0x4B, "K"},
		{0x4C, "L"},
		{0x4D, "M"},
		{0x4E, "N"},
		{0x4F, "O"},
		{0x50, "P"},
		{0x51, "Q"},
		{0x52, "R"},
		{0x53, "S"},
		{0x54, "T"},
		{0x55, "U"},
		{0x56, "V"},
		{0x57, "W"},
		{0x58, "X"},
		{0x59, "Y"},
		{0x5A, "Z"}
	},
	{
		{0x41, "A"},
		{0x42, "B"},
		{0x43, "C"},
		{0x44, "D"},
		{0x45, "E"},
		{0x46, "F"},
		{0x47, "G"},
		{0x48, "H"},
		{0x49, "I"},
		{0x4A, "J"},
		{0x4B, "K"},
		{0x4C, "L"},
		{0x4D, "M"},
		{0x4E, "N"},
		{0x4F, "O"},
		{0x50, "P"},
		{0x51, "Q"},
		{0x52, "R"},
		{0x53, "S"},
		{0x54, "T"},
		{0x55, "U"},
		{0x56, "V"},
		{0x57, "W"},
		{0x58, "X"},
		{0x59, "Y"},
		{0x5A, "Z"},
		{0x60, "0"},
		{0x61, "1"},
		{0x62, "2"},
		{0x63, "3"},
		{0x64, "4"},
		{0x65, "5"},
		{0x66, "6"},
		{0x67, "7"},
		{0x68, "8"},
		{0x69, "9"},
		{0x30, "0"},
		{0x31, "1"},
		{0x32, "2"},
		{0x33, "3"},
		{0x34, "4"},
		{0x35, "5"},
		{0x36, "6"},
		{0x37, "7"},
		{0x38, "8"},
		{0x39, "9"}
	},
	{
		{0x60, "0"},
		{0x61, "1"},
		{0x62, "2"},
		{0x63, "3"},
		{0x64, "4"},
		{0x65, "5"},
		{0x66, "6"},
		{0x67, "7"},
		{0x68, "8"},
		{0x69, "9"},
		{0x30, "0"},
		{0x31, "1"},
		{0x32, "2"},
		{0x33, "3"},
		{0x34, "4"},
		{0x35, "5"},
		{0x36, "6"},
		{0x37, "7"},
		{0x38, "8"},
		{0x39, "9"}
	},
	{
		{0x60, "0"},
		{0x61, "1"},
		{0x62, "2"},
		{0x63, "3"},
		{0x64, "4"},
		{0x65, "5"},
		{0x66, "6"},
		{0x67, "7"},
		{0x68, "8"},
		{0x69, "9"},
		{0x30, "0"},
		{0x31, "1"},
		{0x32, "2"},
		{0x33, "3"},
		{0x34, "4"},
		{0x35, "5"},
		{0x36, "6"},
		{0x37, "7"},
		{0x38, "8"},
		{0x39, "9"},
		{0x6E, "."},
		{0xBE, "."},
	},
}

-- Huge thanks to Proddy for this function and for telling me of ways to improve this script
Ghost.Keys = {}
function Ghost.get_key(...)
    local args = {...}
    assert(#args > 0, "must give at least one key")
    local ID = table.concat(args, "|")
    if not Ghost.Keys[ID] then
        local key = MenuKey()
        for i=1,#args do
           key:push_vk(args[i])
        end
        Ghost.Keys[ID] = key
    end
    
    return Ghost.Keys[ID]
end

function Ghost.doWrite(time, key, extraArg, ignoreMax, stringTable, functionToDo)
	if Ghost.get_key(key):is_down() then
		if (extraArg and #stringTable.string < stringTable.maxLen) or ignoreMax then
			functionToDo()
		end
		local timer = utils.time_ms() + time
		while timer > utils.time_ms() and Ghost.get_key(key):is_down() and extraArg do
			system.wait(0)
		end
		while timer < utils.time_ms() and Ghost.get_key(key):is_down() and extraArg do
			if #stringTable.string < stringTable.maxLen or ignoreMax then
				functionToDo()
			end
			local timer = utils.time_ms() + 50
			while timer > utils.time_ms() do
				system.wait(0)
			end
		end
	end
end

function Ghost.scrollToMax(stringTable, dataTable)
	stringTable.maxDraw = 9999
	stringTable.drawPointer = 0
	while true do
		local sizeString = stringTable.string:gsub(" ", ".")
		if scriptdraw.get_text_size(sizeString:sub(stringTable.drawPointer, #stringTable.string), dataTable.fontSize, dataTable.font).x > 275 then
			stringTable.drawPointer = stringTable.drawPointer + 1
		else
			stringTable.maxDraw = stringTable.drawPointer
			break
		end
	end
end

function Ghost.addPointer(skipArg, character, stringTable, dataTable)
	if skipArg then
		local tempDPointer = stringTable.drawPointer
		Ghost.scrollToMax(stringTable, dataTable)
		stringTable.drawPointer = tempDPointer
	end
	if not (stringTable.pointer >= #stringTable.string) or skipArg then
		stringTable.pointer = stringTable.pointer + 1
		stringTable.locString = stringTable.locString:gsub(" ", ".")
		local sizeString = stringTable.string:gsub(" ", ".")
		if scriptdraw.get_text_size(stringTable.locString:sub(stringTable.pointer - stringTable.drawPointer + 1, #stringTable.locString), dataTable.fontSize, dataTable.font).x < 43.5 and scriptdraw.get_text_size(sizeString, dataTable.fontSize, dataTable.font).x > 275 and stringTable.drawPointer < stringTable.maxDraw then
			stringTable.drawPointer = stringTable.drawPointer + 1
			while scriptdraw.get_text_size(stringTable.locString:sub(stringTable.pointer - stringTable.drawPointer + 1, #stringTable.locString), dataTable.fontSize, dataTable.font).x == 0.0 do
				stringTable.drawPointer = stringTable.drawPointer + 1
			end
		end
	end
end

function Ghost.subPointer(moveDrawPointer, stringTable, dataTable)
	if moveDrawPointer then
		local tempDPointer = stringTable.drawPointer
		Ghost.scrollToMax(stringTable, dataTable)
		stringTable.drawPointer = tempDPointer
	end

	if not (stringTable.pointer <= 0) then
		stringTable.pointer = stringTable.pointer - 1
		if 3 >= stringTable.pointer - stringTable.drawPointer then
			if not (stringTable.drawPointer <= 0) then
				stringTable.drawPointer = stringTable.drawPointer - 1
			end
		end
	end
end

function Ghost.EBreak()
	while true do
		if Ghost.get_key(0x10, 0x1B):is_down() then
			menu.notify("Emergency break activated.")
			menu.set_menu_can_navigate(true)
		end
		system.wait(0)
	end
end

function Ghost.getInput(title, default, len, inputType, dataTable)
	--thanks to kektram for letting me know about the assert function
	assert(type(title) == "string" or type(title) == "number" or not (title), "title parameter needs to be a string")
	assert(type(default) == "string" or type(default) == "number" or not (default), "default parameter needs to be a string")
	assert(type(len) == "number" or not  (len), "length parameter needs to be a number")
	assert(type(inputType) == "number" or not (inputType), "type parameter needs to be a number")
	title = tostring(title)
	default = tostring(default)
	local EBreak = menu.create_thread(Ghost.EBreak, nil)
	local dataTable = dataTable
	if not dataTable then
		dataTable = {}
	end
	dataTable.fontSize = 0.5
	dataTable.font = 6

	inputType = inputType + 1
	if inputType then
		if inputType > 5 or inputType < 1 or not inputType then
			inputType = 1
		end
	end

	inputType = inputType or 1
	menu.set_menu_can_navigate(false)
	local stringTable = {string = default or "", title = title or "", titleSize = 0.3, maxLen = len, locString = "", displayString = ""}
	stringTable.pointer = #stringTable.string
	stringTable.drawPointer = 0
	stringTable.maxDraw = 9999
	for i = 0.65, 0.3, -0.01 do
		if scriptdraw.get_text_size(title, i).x < 330 then
			stringTable.titleSize = i
			break
		end
	end

	Ghost.scrollToMax(stringTable, dataTable)
	local timer = utils.time_ms() + 1000
	system.wait(100)

	local drawThread = menu.create_thread(function()
		while true do
			local displayTable = {string = "", scriptdrawOffset = 0}
			for i = #stringTable.string, 1, -1 do
				local tempString = stringTable.string:sub(stringTable.drawPointer + 1, stringTable.drawPointer + i)
				if scriptdraw.get_text_size(tempString, dataTable.fontSize, dataTable.font).x < 275 then
					displayTable.string = tempString
					break
				end
			end
			stringTable.displayString = displayTable.string
			if stringTable.pointerFlash then
				stringTable.locString = displayTable.string
				displayTable.string = displayTable.string:sub(1, stringTable.pointer - stringTable.drawPointer - displayTable.scriptdrawOffset).."|"..displayTable.string:sub(stringTable.pointer - stringTable.drawPointer - displayTable.scriptdrawOffset + 1, #displayTable.string)
			else
				stringTable.locString = displayTable.string
				displayTable.string = displayTable.string:sub(1, stringTable.pointer - stringTable.drawPointer - displayTable.scriptdrawOffset).." "..displayTable.string:sub(stringTable.pointer - stringTable.drawPointer - displayTable.scriptdrawOffset + 1, #displayTable.string)
			end
			displayTable.string = displayTable.string:gsub("~", "~~")
			ui.draw_rect(0.5, 0.5, 1, 1, 0, 0, 0, 100) --screenBG
			ui.draw_rect(0.5, 0.541388888888, 0.314, 0.0027777777778, 255, 255, 255, 200) --Outline down
			ui.draw_rect(0.5, 0.4986111111, 0.314, 0.0027777777778, 255, 255, 255, 200) --Outline up
			ui.draw_rect(0.3421, 0.5201, 0.0015, 0.04555555556, 255, 255, 255, 200) --Outline left
			ui.draw_rect(0.6579, 0.5201, 0.0015, 0.04555555556, 255, 255, 255, 200) --Outline right
			ui.draw_rect(0.5, 0.52, 0.314, 0.04, 0, 0, 0, 200) --insideRect
			ui.set_text_scale(dataTable.fontSize)
			ui.set_text_color(255, 255, 255, 255)
			ui.set_text_font(dataTable.font)
			ui.set_text_outline(false)
			ui.draw_text(displayTable.string, v2(0.345, 0.505))
			ui.set_text_scale(stringTable.titleSize)
			ui.set_text_color(255, 255, 255, 255)
			ui.set_text_font(0)
			ui.set_text_outline(false)
			ui.set_text_right_justify(false)
			ui.draw_text(stringTable.title, v2(0.5, 0.455))
			for i = 0, 357 do
				controls.disable_control_action(0, i, true)
			end
			system.wait(0)
		end
	end, nil)

	while true do
		if utils.time_ms() < timer - 500 then
			stringTable.pointerFlash = true
		elseif utils.time_ms() > timer - 500 then
			stringTable.pointerFlash = false
			if utils.time_ms() >= timer then
				timer = utils.time_ms() + 1000
			end
		end

		for k, v in pairs(Ghost.charCodes[inputType]) do
			Ghost.doWrite(500, v[1], not Ghost.get_key(0x11):is_down(), false, stringTable, function()
				if not Ghost.get_key(0x10):is_down() then
					stringTable.string = stringTable.string:sub(1, stringTable.pointer)..v[2]:lower()..stringTable.string:sub(stringTable.pointer + 1, #stringTable.string)
					Ghost.addPointer(true, v[2]:lower(), stringTable, dataTable)
				else
					if v[3] then
						stringTable.string = stringTable.string:sub(1, stringTable.pointer)..v[3]..stringTable.string:sub(stringTable.pointer + 1, #stringTable.string)
						Ghost.addPointer(true, v[3], stringTable, dataTable)
					else
						stringTable.string = stringTable.string:sub(1, stringTable.pointer)..v[2]..stringTable.string:sub(stringTable.pointer + 1, #stringTable.string)
						Ghost.addPointer(true, v[2], stringTable, dataTable)
					end
				end
			end)
		end

		if Ghost.get_key(0x0D):is_down() then
			dataTable.status = 0
			if inputType >= 4 then
				if tonumber(stringTable.string) then
					dataTable.input = tonumber(stringTable.string)
				else
					dataTable.input = stringTable.string
				end
			else
				dataTable.input = stringTable.string
			end
			menu.delete_thread(EBreak)
			menu.delete_thread(drawThread)
			menu.set_menu_can_navigate(true)
			return 0, dataTable.input

		elseif Ghost.get_key(0x1B):is_down() and not Ghost.get_key(0x10):is_down() then
			while Ghost.get_key(0x1B):is_down() do
				controls.disable_control_action(0, 200, true)
				system.wait(0)
			end
			controls.disable_control_action(0, 200, true)
			dataTable.status = 2
			dataTable.input = nil
			menu.delete_thread(EBreak)
			menu.delete_thread(drawThread)
			menu.set_menu_can_navigate(true)
			return 2, nil

		elseif Ghost.get_key(0x11, 0x56):is_down() then
			local clipboardString = utils.from_clipboard():gsub("[\n\r]", "")
			local charCodeString = ""

			for k, v in pairs(Ghost.charCodes[inputType]) do
				for i, e in pairs(v) do
					if i ~= 1 then
						charCodeString = charCodeString..e
					else
						if e >= 65 and e <= 90 then
							charCodeString = charCodeString..v[2]:lower()
						end
					end
				end
			end

			charCodeString = "[^"..charCodeString.."]"
			clipboardString = clipboardString:gsub(charCodeString, "")
			clipboardString = clipboardString:sub(1, stringTable.maxLen - #stringTable.string)
			stringTable.string = stringTable.string:sub(1, stringTable.pointer)..clipboardString..stringTable.string:sub(stringTable.pointer + 1, #stringTable.string)
			local tempPointer = stringTable.pointer
			local tempDraw = stringTable.drawPointer
			Ghost.scrollToMax(stringTable, dataTable)
			stringTable.drawPointer = tempDraw
			for i = 1, #clipboardString do
				Ghost.addPointer(nil, nil, stringTable, dataTable)
			end
			while Ghost.get_key(0x11, 0x56):is_down() do
				system.wait(0)
			end

		elseif Ghost.get_key(0x11, 0x43):is_down() then
			utils.to_clipboard(stringTable.string)
			while Ghost.get_key(0x11, 0x43):is_down() do
				system.wait(0)
			end
		end

		Ghost.doWrite(500, 0x08, true, true, stringTable, function()
			if Ghost.get_key(0x11, 0x08):is_down() then
				stringTable.string = ""
				stringTable.pointer = 0
				stringTable.drawPointer = 0
				stringTable.maxDraw = 0
			elseif stringTable.pointer ~= 0 then
				stringTable.string = stringTable.string:sub(1, stringTable.pointer - 1)..stringTable.string:sub(stringTable.pointer + 1, #stringTable.string)
				Ghost.subPointer(true, stringTable, dataTable)
			end
		end)

		Ghost.doWrite(500, 0x27, true, true, stringTable, function()
			if Ghost.get_key(0x11):is_down() then
				stringTable.pointer = #stringTable.string
				stringTable.drawPointer = stringTable.maxDraw
			else
				Ghost.addPointer(nil, nil, stringTable, dataTable)
			end
		end)

		Ghost.doWrite(500, 0x25, true, true, stringTable, function()
			if Ghost.get_key(0x11):is_down() then
				stringTable.pointer = 0
				stringTable.drawPointer = 0
			else
				Ghost.subPointer(false, stringTable, dataTable)
			end
		end)
		system.wait(0)
		dataTable.status = 1
		if inputType >= 4 then
			if tonumber(stringTable.string) then
				dataTable.input = tonumber(stringTable.string)
			else
				dataTable.input = stringTable.string
			end
		else
			dataTable.input = stringTable.string
		end
	end

	menu.delete_thread(EBreak)
	menu.delete_thread(drawThread)
	menu.set_menu_can_navigate(true)
end

return Ghost