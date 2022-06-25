local ScriptName = "Speedometer"

local Paths = {}
Paths.Root = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
Paths.Cfg = Paths.Root .. "\\cfg"
Paths.Settings = Paths.Cfg .. "\\Speedometer.cfg"
Paths.LogFile = Paths.Root .. "\\" .. ScriptName .. ".log"
Paths.Scripts = Paths.Root .. "\\scripts"
Paths.Speedometer = Paths.Scripts .. "\\Speedometer"
Paths.Themes = Paths.Speedometer .. "\\Themes"
Paths.DefaultTheme = Paths.Themes .. "\\Default"

local basePrint = print
local function print(...)
	local success, result = pcall(function(...)
		local currTime = os.date("*t")
		local file = io.open(Paths.LogFile, "a")
		
		local args = {...}
		for i=1,#args do
			file:write(string.format("[%02d-%02d-%02d %02d:%02d:%02d] ", currTime.year, currTime.month, currTime.day, currTime.hour, currTime.min, currTime.sec)..tostring(args[i]).."\n")
			basePrint(args[i])
		end
		
		file:close()
	end, ...)
	if not success then
		basePrint("Error writing log: " .. result)
	end
end

local function randomFloat(lower, greater)
	return lower + math.random() * (greater - lower);
end

local function RGBAToInt(R, G, B, A)
	A = A or 255
	return ((R&0x0ff)<<0x00)|((G&0x0ff)<<0x08)|((B&0x0ff)<<0x10)|((A&0x0ff)<<0x18)
end

local function Round(num, dp)
    local mult = 10^(dp or 0)
    return math.floor(num * mult + 0.5)/mult
end

local function notify(msg, title, seconds, color)
	title = title or ScriptName
	menu.notify(msg, title, seconds, color)
	print(msg)
end

local RequiredThemeSettings = {
	"KMHDialFile",
	"KMHNeedleFile",
	"KMHMinAngle",
	"KMHMaxAngle",
	"KMHMaxSpeed",
	"KMHTextScaleMultiplier",
	"KMHValueOffsetX",
	"KMHValueOffsetY",
	"KMHValueIncludeUnits",
	
	"MPHDialFile",
	"MPHNeedleFile",
	"MPHMinAngle",
	"MPHMaxAngle",
	"MPHMaxSpeed",
	"MPHTextScaleMultiplier",
	"MPHValueOffsetX",
	"MPHValueOffsetY",
	"MPHValueIncludeUnits",
	
	"RPMDialFile",
	"RPMNeedleFile",
	"RPMMinAngle",
	"RPMMaxAngle",
	"RPMDegreesPerThousand",
	"RPMTextScaleMultiplier",
	"RPMGearOffsetX",
	"RPMGearOffsetY",
}
local RequiredThemeFiles = {
	"KMHDialFile",
	"KMHNeedleFile",
	
	"MPHDialFile",
	"MPHNeedleFile",
	
	"RPMDialFile",
	"RPMNeedleFile",
}
local function CheckTheme(dir)
	if dir:sub(-1) ~= "\\" then
		dir = dir .. "\\"
	end
	if not utils.file_exists(dir .. "Theme.cfg") then
		print("Missing file: \"" .. dir .. "Theme.cfg\"")
		return nil
	end
	local Theme = {}
	Theme.RootDir = dir
	for line in io.lines(dir .. "Theme.cfg") do
		if line:sub(1,1) ~= "#" then
			local separator = line:find("=", 1, true)
			if separator then
				local key = line:sub(1, separator - 1)
				local value = line:sub(separator + 1)
				local num = tonumber(value)
				if num then
					value = num
				elseif value == "true" then
					value = true
				elseif value == "false" then
					value = false
				end
				num = tonumber(key)
				if num then
					key = num
				end
				Theme[key] = value
			end
		end
	end
	for i=1,#RequiredThemeSettings do
		if Theme[RequiredThemeSettings[i]] == nil then
			print("Missing setting in \"" .. dir .. "Theme.cfg\": " .. RequiredThemeSettings[i])
			return nil
		end
	end
	for i=1,#RequiredThemeFiles do
		if not utils.file_exists(dir .. Theme[RequiredThemeFiles[i]]) then
			print("Missing file: \"" .. dir .. Theme[RequiredThemeFiles[i]] "\"")
			return nil
		end
	end
	return Theme
end

if Speedometer then
	notify("Speedometer already loaded.", nil, nil, RGBAToInt(255, 0, 0, 255))
	return
end

if not utils.dir_exists(Paths.Speedometer) then
	notify("Sprites directory missing in scripts directory. Try reinstalling.", nil, nil, RGBAToInt(255, 0, 0, 255))
	return
end

if not utils.dir_exists(Paths.Themes) then
	notify("Themes directory missing in Sprites directory. Try reinstalling.", nil, nil, RGBAToInt(255, 0, 0, 255))
	return
end

if not utils.dir_exists(Paths.DefaultTheme) then
	notify("Default directory missing in Themes directory. Try reinstalling.", nil, nil, RGBAToInt(255, 0, 0, 255))
	return
end

local ThemeDirs = utils.get_all_sub_directories_in_directory(Paths.Themes)
local Themes = {}
for i=#ThemeDirs,1,-1 do
	local Theme = CheckTheme(Paths.Themes .. "\\" .. ThemeDirs[i])
	if Theme then
		Themes[ThemeDirs[i]] = Theme
	else
		table.remove(ThemeDirs, 1)
	end
end
if not Themes["Default"] then
	notify("Default theme was invalid. Try reinstalling.", nil, nil, RGBAToInt(255, 0, 0, 255))
	return
end

local SettingsTbl = {}
SettingsTbl.ThemeName = "Default"

SettingsTbl.SpeedoEnabled = true
SettingsTbl.SpeedoX = scriptdraw.pos_rel_to_pixel_x(0)
SettingsTbl.SpeedoY = scriptdraw.pos_rel_to_pixel_y(0)
SettingsTbl.SpeedoScale = 0.25
SettingsTbl.SpeedoAlpha = 0.8
SettingsTbl.SpeedoDialR = 255
SettingsTbl.SpeedoDialG = 255
SettingsTbl.SpeedoDialB = 255
SettingsTbl.SpeedoNeedleR = 255
SettingsTbl.SpeedoNeedleG = 255
SettingsTbl.SpeedoNeedleB = 255
SettingsTbl.SpeedoTextR = 255
SettingsTbl.SpeedoTextG = 255
SettingsTbl.SpeedoTextB = 255
SettingsTbl.SpeedoUnits = 0 -- 0 = KMH, 1 = MPH
SettingsTbl.SpeedoDrawValue = true
SettingsTbl.SpeedoAlwaysOn = true

SettingsTbl.TachoEnabled = true
SettingsTbl.TachoX = scriptdraw.pos_rel_to_pixel_x(0)
SettingsTbl.TachoY = scriptdraw.pos_rel_to_pixel_y(0)
SettingsTbl.TachoScale = 0.2
SettingsTbl.TachoAlpha = 0.8
SettingsTbl.TachoDialR = 255
SettingsTbl.TachoDialG = 255
SettingsTbl.TachoDialB = 255
SettingsTbl.TachoNeedleR = 255
SettingsTbl.TachoNeedleG = 255
SettingsTbl.TachoNeedleB = 255
SettingsTbl.TachoTextR = 255
SettingsTbl.TachoTextG = 255
SettingsTbl.TachoTextB = 255
SettingsTbl.TachoDrawGear = true

local player_id = player.player_id
local get_player_ped = player.get_player_ped
local is_ped_in_any_vehicle = ped.is_ped_in_any_vehicle
local get_vehicle_ped_is_using = ped.get_vehicle_ped_is_using
local has_control_of_entity = network.has_control_of_entity
local function getCurrentVehicle() 
	local pid = player_id()
	local pped = get_player_ped(pid)
	if is_ped_in_any_vehicle(pped) then
		local veh = get_vehicle_ped_is_using(pped)
		if has_control_of_entity(veh) then
			return veh
		end
	end
	return nil
end
local get_vehicle_wheel_tire_radius = vehicle.get_vehicle_wheel_tire_radius
local get_vehicle_estimated_max_speed = vehicle.get_vehicle_estimated_max_speed
local get_vehicle_max_gear = vehicle.get_vehicle_max_gear
local get_vehicle_gear_ratio = vehicle.get_vehicle_gear_ratio
local function getMaxRPM(veh)
	local wheelRadius = get_vehicle_wheel_tire_radius(veh, 0)
	local height = wheelRadius * 2 * 39.37
	local maxSpeed = get_vehicle_estimated_max_speed(veh) * 2.23694
	local maxGear = get_vehicle_max_gear(veh)
	local gearRatio = get_vehicle_gear_ratio(veh, maxGear)
	return ((gearRatio * maxSpeed * 336 * 0.8) / height) * maxGear / 1000
end

local draw_sprite = scriptdraw.draw_sprite
local draw_text = scriptdraw.draw_text
local pos_pixel_to_rel_x = scriptdraw.pos_pixel_to_rel_x
local pos_pixel_to_rel_y = scriptdraw.pos_pixel_to_rel_y
local function draw_speedo(theme, speed)
	local dialCol = RGBAToInt(SettingsTbl.SpeedoDialR, SettingsTbl.SpeedoDialG, SettingsTbl.SpeedoDialB, math.floor(255 * SettingsTbl.SpeedoAlpha))
	local needleCol = RGBAToInt(SettingsTbl.SpeedoNeedleR, SettingsTbl.SpeedoNeedleG, SettingsTbl.SpeedoNeedleB, math.floor(255 * SettingsTbl.SpeedoAlpha))
	
	local speedoX = SettingsTbl.SpeedoX
	local speedoY = SettingsTbl.SpeedoY
	local speedoPos = v2(pos_pixel_to_rel_x(speedoX), pos_pixel_to_rel_y(speedoY))
	local dialId
	local needleId
	local rot
	local textPos
	local text
	local textScaleMultiplier
	if SettingsTbl.SpeedoUnits == 0 then
		speed = speed * 3.6
		dialId = theme.KmhDialId
		needleId = theme.KmhNeedleId
		rot = math.rad(speed < theme.KMHMaxSpeed and (theme.KMHMinAngle + theme.KMHMaxAngle * (speed / theme.KMHMaxSpeed)) or (theme.KMHMinAngle + theme.KMHMaxAngle))
		textPos = v2(pos_pixel_to_rel_x(speedoX + theme.KMHValueOffsetX * SettingsTbl.SpeedoScale), pos_pixel_to_rel_y(speedoY + theme.KMHValueOffsetY * SettingsTbl.SpeedoScale))
		text = math.floor(speed)
		if theme.KMHValueIncludeUnits then
			text = text .. " " .. "KM/H"
		end
		textScaleMultiplier = theme.KMHTextScaleMultiplier
	else
		speed = speed * 2.23694
		needleId = theme.MphNeedleId
		dialId = theme.MphDialId
		rot = math.rad(speed < theme.MPHMaxSpeed and (theme.MPHMinAngle + theme.MPHMaxAngle * (speed / theme.MPHMaxSpeed)) or (theme.MPHMinAngle + theme.MPHMaxAngle))
		textPos = v2(pos_pixel_to_rel_x(speedoX + theme.MPHValueOffsetX * SettingsTbl.SpeedoScale), pos_pixel_to_rel_y(speedoY + theme.MPHValueOffsetY * SettingsTbl.SpeedoScale))
		text = math.floor(speed)
		if theme.MPHValueIncludeUnits then
			text = text .. " " .. "MPH"
		end
		textScaleMultiplier = theme.MPHTextScaleMultiplier
	end
	
	draw_sprite(dialId, speedoPos, SettingsTbl.SpeedoScale, 0, dialCol)
	draw_sprite(needleId, speedoPos, SettingsTbl.SpeedoScale, rot, needleCol)
	if SettingsTbl.SpeedoDrawValue then
		local textCol = RGBAToInt(SettingsTbl.SpeedoTextR, SettingsTbl.SpeedoTextG, SettingsTbl.SpeedoTextB, math.floor(255 * SettingsTbl.SpeedoAlpha))
		draw_text(text, textPos, v2(), SettingsTbl.SpeedoScale * textScaleMultiplier, textCol, 1)
	end
end
local function draw_tacho(theme, rpm, maxRPM, gear)
	local dialCol = RGBAToInt(SettingsTbl.TachoDialR, SettingsTbl.TachoDialG, SettingsTbl.TachoDialB, math.floor(255 * SettingsTbl.TachoAlpha))
	local needleCol = RGBAToInt(SettingsTbl.TachoNeedleR, SettingsTbl.TachoNeedleG, SettingsTbl.TachoNeedleB, math.floor(255 * SettingsTbl.TachoAlpha))
	
	local tachoX = SettingsTbl.TachoX
	local tachoY = SettingsTbl.TachoY
	local tachoPos = v2(pos_pixel_to_rel_x(tachoX), pos_pixel_to_rel_y(tachoY))
	local rot = 0
	if rpm > 0 then
		rot = math.rad(math.min(theme.RPMMinAngle + maxRPM * theme.RPMDegreesPerThousand * rpm, theme.RPMMaxAngle)) + randomFloat(0, 0.02)
	end
	
	draw_sprite(theme.RpmDialId, tachoPos, SettingsTbl.TachoScale, 0, dialCol)
	draw_sprite(theme.RpmNeedleId, tachoPos, SettingsTbl.TachoScale, rot, needleCol)
	if gear then
		local textCol = RGBAToInt(SettingsTbl.TachoTextR, SettingsTbl.TachoTextG, SettingsTbl.TachoTextB, math.floor(255 * SettingsTbl.TachoAlpha))
		local tachoGearPos = v2(pos_pixel_to_rel_x(tachoX + theme.RPMGearOffsetX * SettingsTbl.TachoScale), pos_pixel_to_rel_y(tachoY + theme.RPMGearOffsetY * SettingsTbl.TachoScale))
		draw_text(gear, tachoGearPos, v2(), SettingsTbl.TachoScale * theme.RPMTextScaleMultiplier, textCol, 1)
	end
end

local ParentId = menu.add_feature("Speedometer", "parent").id
local get_entity_speed = entity.get_entity_speed
local get_vehicle_rpm = vehicle.get_vehicle_rpm
local get_vehicle_current_gear = vehicle.get_vehicle_current_gear
local is_vehicle_engine_running = vehicle.is_vehicle_engine_running
menu.add_feature("Enabled", "toggle", ParentId, function(f)
	while f.on do
		local Theme = Themes[SettingsTbl.ThemeName] or Themes["Default"]
		Theme.KmhDialId = Theme.KmhDialId or scriptdraw.register_sprite(Theme.RootDir .. Theme.KMHDialFile)
		Theme.KmhNeedleId = Theme.KmhNeedleId or scriptdraw.register_sprite(Theme.RootDir .. Theme.KMHNeedleFile)
		Theme.MphDialId = Theme.MphDialId or scriptdraw.register_sprite(Theme.RootDir .. Theme.MPHDialFile)
		Theme.MphNeedleId = Theme.MphNeedleId or scriptdraw.register_sprite(Theme.RootDir .. Theme.MPHNeedleFile)
		Theme.RpmDialId = Theme.RpmDialId or scriptdraw.register_sprite(Theme.RootDir .. Theme.RPMDialFile)
		Theme.RpmNeedleId = Theme.RpmNeedleId or scriptdraw.register_sprite(Theme.RootDir .. Theme.RPMNeedleFile)
		local veh = nil
		if SettingsTbl.SpeedoEnabled then
			veh = veh or getCurrentVehicle()
			if veh then
				draw_speedo(Theme, get_entity_speed(veh))
			elseif SettingsTbl.SpeedoAlwaysOn then
				draw_speedo(Theme, get_entity_speed(get_player_ped(player_id())))
			end
		end
		if SettingsTbl.TachoEnabled then
			veh = veh or getCurrentVehicle()
			if veh then
				local running = is_vehicle_engine_running(veh)
				local maxRPM = running and math.min(getMaxRPM(veh), 10) or 0
				local rpm = running and get_vehicle_rpm(veh) or 0
				if SettingsTbl.TachoDrawGear then
					draw_tacho(Theme, rpm, maxRPM, get_vehicle_current_gear(veh))
				else
					draw_tacho(Theme, rpm, maxRPM)
				end
			end
		end
		system.wait(0)
	end
end).on = true
local ThemesFeat = menu.add_feature("Themes", "parent", ParentId)
for i=1,#ThemeDirs do
	menu.add_feature(ThemeDirs[i], "toggle", ThemesFeat.id, function(f)
		if f.on then
			SettingsTbl.ThemeName = f.name
			print("Setting theme to: " .. f.name)
			for i=1,ThemesFeat.child_count do
				if ThemesFeat.children[i].id ~= f.id then
					ThemesFeat.children[i].on = false
				end
			end
		elseif SettingsTbl.ThemeName == f.name then
			f.on = true
		end
	end)
end

local SpeedoSettingsId = menu.add_feature("Speedometer Settings", "parent", ParentId).id
local SpeedoEnabledFeat = menu.add_feature("Enabled", "toggle", SpeedoSettingsId, function(f)
	SettingsTbl.SpeedoEnabled = f.on
end)
SpeedoEnabledFeat.on = SettingsTbl.SpeedoEnabled
local SpeedoPosXFeat = menu.add_feature("Position X", "autoaction_value_i", SpeedoSettingsId, function(f)
	SettingsTbl.SpeedoX = f.value
end)
SpeedoPosXFeat.min = 0
SpeedoPosXFeat.max = graphics.get_screen_width()
SpeedoPosXFeat.mod = 1
SpeedoPosXFeat.value = SettingsTbl.SpeedoX
menu.add_feature("Set X", "action", SpeedoSettingsId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter X", SpeedoPosXFeat.value, tostring(SpeedoPosXFeat.max):len() + 1, 3)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local X = tonumber(s)
	X = math.max(X, SpeedoPosXFeat.min)
	X = math.min(X, SpeedoPosXFeat.max)
	SpeedoPosXFeat.value = X
	SettingsTbl.SpeedoX = X
end)
local SpeedoPosYFeat = menu.add_feature("Position Y", "autoaction_value_i", SpeedoSettingsId, function(f)
	SettingsTbl.SpeedoY = f.value
end)
SpeedoPosYFeat.min = 0
SpeedoPosYFeat.max = graphics.get_screen_height()
SpeedoPosYFeat.mod = 1
SpeedoPosYFeat.value = SettingsTbl.SpeedoY
menu.add_feature("Set Y", "action", SpeedoSettingsId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter Y", SpeedoPosYFeat.value, tostring(SpeedoPosYFeat.max):len() + 1, 3)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local Y = tonumber(s)
	Y = math.max(Y, SpeedoPosYFeat.min)
	Y = math.min(Y, SpeedoPosYFeat.max)
	SpeedoPosYFeat.value = Y
	SettingsTbl.SpeedoY = Y
end)
local SpeedoScaleFeat = menu.add_feature("Scale", "autoaction_slider", SpeedoSettingsId, function(f)
	SettingsTbl.SpeedoScale = Round(f.value, 2)
end)
SpeedoScaleFeat.min = 0
SpeedoScaleFeat.max = 1
SpeedoScaleFeat.mod = 0.01
SpeedoScaleFeat.value = SettingsTbl.SpeedoScale
local SpeedoAlphaFeat = menu.add_feature("Alpha", "autoaction_slider", SpeedoSettingsId, function(f)
	SettingsTbl.SpeedoAlpha = Round(f.value, 2)
end)
SpeedoAlphaFeat.min = 0
SpeedoAlphaFeat.max = 1
SpeedoAlphaFeat.mod = 0.01
SpeedoAlphaFeat.value = SettingsTbl.SpeedoAlpha
local SpeedoDialColId = menu.add_feature("Dial Colour", "parent", SpeedoSettingsId).id
local SpeedoDialRFeat = menu.add_feature("R", "autoaction_value_i", SpeedoDialColId, function(f)
	SettingsTbl.SpeedoDialR = f.value
end)
SpeedoDialRFeat.min = 0
SpeedoDialRFeat.max = 255
SpeedoDialRFeat.mod = 5
SpeedoDialRFeat.value = SettingsTbl.SpeedoDialR
local SpeedoDialGFeat = menu.add_feature("G", "autoaction_value_i", SpeedoDialColId, function(f)
	SettingsTbl.SpeedoDialG = f.value
end)
SpeedoDialGFeat.min = 0
SpeedoDialGFeat.max = 255
SpeedoDialGFeat.mod = 5
SpeedoDialGFeat.value = SettingsTbl.SpeedoDialG
local SpeedoDialBFeat = menu.add_feature("B", "autoaction_value_i", SpeedoDialColId, function(f)
	SettingsTbl.SpeedoDialB = f.value
end)
SpeedoDialBFeat.min = 0
SpeedoDialBFeat.max = 255
SpeedoDialBFeat.mod = 5
SpeedoDialBFeat.value = SettingsTbl.SpeedoDialB
menu.add_feature("Set RGB", "action", SpeedoDialColId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter R,G,B", math.floor(SpeedoDialRFeat.value) .. "," .. math.floor(SpeedoDialGFeat.value) .. "," .. math.floor(SpeedoDialBFeat.value), 11, 0)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local parts = {}
	for token in s:gmatch("[^,]+") do
		local num = tonumber(token)
		if not num or num < 0 or num > 255 then
			notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
			return HANDLER_POP
		end
		parts[#parts + 1] = num
	end
	if #parts ~= 3 then
		notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
		return HANDLER_POP
	end
	SpeedoDialRFeat.value = parts[1]
	SettingsTbl.SpeedoDialR = parts[1]
	SpeedoDialGFeat.value = parts[2]
	SettingsTbl.SpeedoDialG = parts[2]
	SpeedoDialBFeat.value = parts[3]
	SettingsTbl.SpeedoDialB = parts[3]
end)
local SpeedoNeedleColId = menu.add_feature("Needle Colour", "parent", SpeedoSettingsId).id
local SpeedoNeedleRFeat = menu.add_feature("R", "autoaction_value_i", SpeedoNeedleColId, function(f)
	SettingsTbl.SpeedoNeedleR = f.value
end)
SpeedoNeedleRFeat.min = 0
SpeedoNeedleRFeat.max = 255
SpeedoNeedleRFeat.mod = 5
SpeedoNeedleRFeat.value = SettingsTbl.SpeedoNeedleR
local SpeedoNeedleGFeat = menu.add_feature("G", "autoaction_value_i", SpeedoNeedleColId, function(f)
	SettingsTbl.SpeedoNeedleG = f.value
end)
SpeedoNeedleGFeat.min = 0
SpeedoNeedleGFeat.max = 255
SpeedoNeedleGFeat.mod = 5
SpeedoNeedleGFeat.value = SettingsTbl.SpeedoNeedleG
local SpeedoNeedleBFeat = menu.add_feature("B", "autoaction_value_i", SpeedoNeedleColId, function(f)
	SettingsTbl.SpeedoNeedleB = f.value
end)
SpeedoNeedleBFeat.min = 0
SpeedoNeedleBFeat.max = 255
SpeedoNeedleBFeat.mod = 5
SpeedoNeedleBFeat.value = SettingsTbl.SpeedoNeedleB
menu.add_feature("Set RGB", "action", SpeedoNeedleColId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter R,G,B", math.floor(SpeedoNeedleRFeat.value) .. "," .. math.floor(SpeedoNeedleGFeat.value) .. "," .. math.floor(SpeedoNeedleBFeat.value), 11, 0)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local parts = {}
	for token in s:gmatch("[^,]+") do
		local num = tonumber(token)
		if not num or num < 0 or num > 255 then
			notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
			return HANDLER_POP
		end
		parts[#parts + 1] = num
	end
	if #parts ~= 3 then
		notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
		return HANDLER_POP
	end
	SpeedoNeedleRFeat.value = parts[1]
	SettingsTbl.SpeedoNeedleR = parts[1]
	SpeedoNeedleGFeat.value = parts[2]
	SettingsTbl.SpeedoNeedleG = parts[2]
	SpeedoNeedleBFeat.value = parts[3]
	SettingsTbl.SpeedoNeedleB = parts[3]
end)
local SpeedoTextColId = menu.add_feature("Text Colour", "parent", SpeedoSettingsId).id
local SpeedoTextRFeat = menu.add_feature("R", "autoaction_value_i", SpeedoTextColId, function(f)
	SettingsTbl.SpeedoTextR = f.value
end)
SpeedoTextRFeat.min = 0
SpeedoTextRFeat.max = 255
SpeedoTextRFeat.mod = 5
SpeedoTextRFeat.value = SettingsTbl.SpeedoTextR
local SpeedoTextGFeat = menu.add_feature("G", "autoaction_value_i", SpeedoTextColId, function(f)
	SettingsTbl.SpeedoTextG = f.value
end)
SpeedoTextGFeat.min = 0
SpeedoTextGFeat.max = 255
SpeedoTextGFeat.mod = 5
SpeedoTextGFeat.value = SettingsTbl.SpeedoTextG
local SpeedoTextBFeat = menu.add_feature("B", "autoaction_value_i", SpeedoTextColId, function(f)
	SettingsTbl.SpeedoTextB = f.value
end)
SpeedoTextBFeat.min = 0
SpeedoTextBFeat.max = 255
SpeedoTextBFeat.mod = 5
SpeedoTextBFeat.value = SettingsTbl.SpeedoTextB
menu.add_feature("Set RGB", "action", SpeedoTextColId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter R,G,B", math.floor(SpeedoTextRFeat.value) .. "," .. math.floor(SpeedoTextGFeat.value) .. "," .. math.floor(SpeedoTextBFeat.value), 11, 0)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local parts = {}
	for token in s:gmatch("[^,]+") do
		local num = tonumber(token)
		if not num or num < 0 or num > 255 then
			notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
			return HANDLER_POP
		end
		parts[#parts + 1] = num
	end
	if #parts ~= 3 then
		notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
		return HANDLER_POP
	end
	SpeedoTextRFeat.value = parts[1]
	SettingsTbl.SpeedoTextR = parts[1]
	SpeedoTextGFeat.value = parts[2]
	SettingsTbl.SpeedoTextG = parts[2]
	SpeedoTextBFeat.value = parts[3]
	SettingsTbl.SpeedoTextB = parts[3]
end)
local SpeedoUnitsFeat = menu.add_feature("Units", "autoaction_value_str", SpeedoSettingsId, function(f)
	SettingsTbl.SpeedoUnits = f.value
end)
SpeedoUnitsFeat:set_str_data({"KMH","MPH"})
SpeedoUnitsFeat.value = SettingsTbl.SpeedoUnits
local SpeedoDrawValueFeat = menu.add_feature("Draw Value", "toggle", SpeedoSettingsId, function(f)
	SettingsTbl.SpeedoDrawValue = f.on
end)
SpeedoDrawValueFeat.on = SettingsTbl.SpeedoDrawValue
local SpeedoAlwaysOnFeat = menu.add_feature("Always Show", "toggle", SpeedoSettingsId, function(f)
	SettingsTbl.SpeedoAlwaysOn = f.on
end)
SpeedoAlwaysOnFeat.on = SettingsTbl.SpeedoAlwaysOn

local TachoSettingsId = menu.add_feature("Tachometer Settings", "parent", ParentId).id
local TachoEnabledFeat = menu.add_feature("Enabled", "toggle", TachoSettingsId, function(f)
	SettingsTbl.TachoEnabled = f.on
end)
TachoEnabledFeat.on = SettingsTbl.TachoEnabled
local TachoPosXFeat = menu.add_feature("Position X", "autoaction_value_i", TachoSettingsId, function(f)
	SettingsTbl.TachoX = f.value
end)
TachoPosXFeat.min = 0
TachoPosXFeat.max = graphics.get_screen_width()
TachoPosXFeat.mod = 1
TachoPosXFeat.value = SettingsTbl.TachoX
menu.add_feature("Set X", "action", TachoSettingsId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter X", TachoPosXFeat.value, tostring(TachoPosXFeat.max):len() + 1, 3)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local X = tonumber(s)
	X = math.max(X, TachoPosXFeat.min)
	X = math.min(X, TachoPosXFeat.max)
	TachoPosXFeat.value = X
	SettingsTbl.TachoX = X
end)
local TachoPosYFeat = menu.add_feature("Position Y", "autoaction_value_i", TachoSettingsId, function(f)
	SettingsTbl.TachoY = f.value
end)
TachoPosYFeat.min = 0
TachoPosYFeat.max = graphics.get_screen_height()
TachoPosYFeat.mod = 1
TachoPosYFeat.value = SettingsTbl.TachoY
menu.add_feature("Set Y", "action", TachoSettingsId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter Y", TachoPosYFeat.value, tostring(TachoPosYFeat.max):len() + 1, 3)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local Y = tonumber(s)
	Y = math.max(Y, TachoPosYFeat.min)
	Y = math.min(Y, TachoPosYFeat.max)
	TachoPosYFeat.value = Y
	SettingsTbl.TachoY = Y
end)
local TachoScaleFeat = menu.add_feature("Scale", "autoaction_slider", TachoSettingsId, function(f)
	SettingsTbl.TachoScale = Round(f.value, 2)
end)
TachoScaleFeat.min = 0
TachoScaleFeat.max = 1
TachoScaleFeat.mod = 0.01
TachoScaleFeat.value = SettingsTbl.TachoScale
local TachoAlphaFeat = menu.add_feature("Alpha", "autoaction_slider", TachoSettingsId, function(f)
	SettingsTbl.TachoAlpha = Round(f.value, 2)
end)
TachoAlphaFeat.min = 0
TachoAlphaFeat.max = 1
TachoAlphaFeat.mod = 0.01
TachoAlphaFeat.value = SettingsTbl.TachoAlpha
local TachoDialColId = menu.add_feature("Dial Colour", "parent", TachoSettingsId).id
local TachoDialRFeat = menu.add_feature("R", "autoaction_value_i", TachoDialColId, function(f)
	SettingsTbl.TachoDialR = f.value
end)
TachoDialRFeat.min = 0
TachoDialRFeat.max = 255
TachoDialRFeat.mod = 5
TachoDialRFeat.value = SettingsTbl.TachoDialR
local TachoDialGFeat = menu.add_feature("G", "autoaction_value_i", TachoDialColId, function(f)
	SettingsTbl.TachoDialG = f.value
end)
TachoDialGFeat.min = 0
TachoDialGFeat.max = 255
TachoDialGFeat.mod = 5
TachoDialGFeat.value = SettingsTbl.TachoDialG
local TachoDialBFeat = menu.add_feature("B", "autoaction_value_i", TachoDialColId, function(f)
	SettingsTbl.TachoDialB = f.value
end)
TachoDialBFeat.min = 0
TachoDialBFeat.max = 255
TachoDialBFeat.mod = 5
TachoDialBFeat.value = SettingsTbl.TachoDialB
menu.add_feature("Set RGB", "action", TachoDialColId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter R,G,B", math.floor(TachoDialRFeat.value) .. "," .. math.floor(TachoDialGFeat.value) .. "," .. math.floor(TachoDialBFeat.value), 11, 0)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local parts = {}
	for token in s:gmatch("[^,]+") do
		local num = tonumber(token)
		if not num or num < 0 or num > 255 then
			notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
			return HANDLER_POP
		end
		parts[#parts + 1] = num
	end
	if #parts ~= 3 then
		notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
		return HANDLER_POP
	end
	TachoDialRFeat.value = parts[1]
	SettingsTbl.TachoDialR = parts[1]
	TachoDialGFeat.value = parts[2]
	SettingsTbl.TachoDialG = parts[2]
	TachoDialBFeat.value = parts[3]
	SettingsTbl.TachoDialB = parts[3]
end)
local TachoNeedleColId = menu.add_feature("Needle Colour", "parent", TachoSettingsId).id
local TachoNeedleRFeat = menu.add_feature("R", "autoaction_value_i", TachoNeedleColId, function(f)
	SettingsTbl.TachoNeedleR = f.value
end)
TachoNeedleRFeat.min = 0
TachoNeedleRFeat.max = 255
TachoNeedleRFeat.mod = 5
TachoNeedleRFeat.value = SettingsTbl.TachoNeedleR
local TachoNeedleGFeat = menu.add_feature("G", "autoaction_value_i", TachoNeedleColId, function(f)
	SettingsTbl.TachoNeedleG = f.value
end)
TachoNeedleGFeat.min = 0
TachoNeedleGFeat.max = 255
TachoNeedleGFeat.mod = 5
TachoNeedleGFeat.value = SettingsTbl.TachoNeedleG
local TachoNeedleBFeat = menu.add_feature("B", "autoaction_value_i", TachoNeedleColId, function(f)
	SettingsTbl.TachoNeedleB = f.value
end)
TachoNeedleBFeat.min = 0
TachoNeedleBFeat.max = 255
TachoNeedleBFeat.mod = 5
TachoNeedleBFeat.value = SettingsTbl.TachoNeedleB
menu.add_feature("Set RGB", "action", TachoNeedleColId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter R,G,B", math.floor(TachoNeedleRFeat.value) .. "," .. math.floor(TachoNeedleGFeat.value) .. "," .. math.floor(TachoNeedleBFeat.value), 11, 0)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local parts = {}
	for token in s:gmatch("[^,]+") do
		local num = tonumber(token)
		if not num or num < 0 or num > 255 then
			notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
			return HANDLER_POP
		end
		parts[#parts + 1] = num
	end
	if #parts ~= 3 then
		notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
		return HANDLER_POP
	end
	TachoNeedleRFeat.value = parts[1]
	SettingsTbl.TachoNeedleR = parts[1]
	TachoNeedleGFeat.value = parts[2]
	SettingsTbl.TachoNeedleG = parts[2]
	TachoNeedleBFeat.value = parts[3]
	SettingsTbl.TachoNeedleB = parts[3]
end)
local TachoTextColId = menu.add_feature("Text Colour", "parent", TachoSettingsId).id
local TachoTextRFeat = menu.add_feature("R", "autoaction_value_i", TachoTextColId, function(f)
	SettingsTbl.TachoTextR = f.value
end)
TachoTextRFeat.min = 0
TachoTextRFeat.max = 255
TachoTextRFeat.mod = 5
TachoTextRFeat.value = SettingsTbl.TachoTextR
local TachoTextGFeat = menu.add_feature("G", "autoaction_value_i", TachoTextColId, function(f)
	SettingsTbl.TachoTextG = f.value
end)
TachoTextGFeat.min = 0
TachoTextGFeat.max = 255
TachoTextGFeat.mod = 5
TachoTextGFeat.value = SettingsTbl.TachoTextG
local TachoTextBFeat = menu.add_feature("B", "autoaction_value_i", TachoTextColId, function(f)
	SettingsTbl.TachoTextB = f.value
end)
TachoTextBFeat.min = 0
TachoTextBFeat.max = 255
TachoTextBFeat.mod = 5
TachoTextBFeat.value = SettingsTbl.TachoTextB
menu.add_feature("Set RGB", "action", TachoTextColId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter R,G,B", math.floor(TachoTextRFeat.value) .. "," .. math.floor(TachoTextGFeat.value) .. "," .. math.floor(TachoTextBFeat.value), 11, 0)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	local parts = {}
	for token in s:gmatch("[^,]+") do
		local num = tonumber(token)
		if not num or num < 0 or num > 255 then
			notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
			return HANDLER_POP
		end
		parts[#parts + 1] = num
	end
	if #parts ~= 3 then
		notify("Invalid RGB format. Must be R,G,B.", nil, nil, RGBAToInt(255, 0, 0, 255))
		return HANDLER_POP
	end
	TachoTextRFeat.value = parts[1]
	SettingsTbl.TachoTextR = parts[1]
	TachoTextGFeat.value = parts[2]
	SettingsTbl.TachoTextG = parts[2]
	TachoTextBFeat.value = parts[3]
	SettingsTbl.TachoTextB = parts[3]
end)
local TachoDrawGearFeat = menu.add_feature("Draw Gear", "toggle", TachoSettingsId, function(f)
	SettingsTbl.TachoDrawGear = f.on
end)
TachoDrawGearFeat.on = SettingsTbl.TachoDrawGear

local function SaveSettings()
	local file = io.open(Paths.Settings, "w")
	for k,v in pairs(SettingsTbl) do
		file:write(tostring(k) .. "=" .. tostring(v) .. "\n")
	end
	file:close()
	notify("Saved settings.", nil, nil, RGBAToInt(0, 255, 0, 255))
end
local function LoadSettings()
	if not utils.file_exists(Paths.Settings) then return end
	for line in io.lines(Paths.Settings) do
		local separator = line:find("=", 1, true)
		if separator then
			local key = line:sub(1, separator - 1)
			local value = line:sub(separator + 1)
			local num = tonumber(value)
			if num then
				value = num
			elseif value == "true" then
				value = true
			elseif value == "false" then
				value = false
			end
			num = tonumber(key)
			if num then
				key = num
			end
			SettingsTbl[key] = value
		end
	end
	SpeedoEnabledFeat.on = SettingsTbl.SpeedoEnabled
	SpeedoPosXFeat.value = SettingsTbl.SpeedoX
	SpeedoPosYFeat.value = SettingsTbl.SpeedoY
	SpeedoScaleFeat.value = SettingsTbl.SpeedoScale
	SpeedoAlphaFeat.value = SettingsTbl.SpeedoAlpha
	SpeedoDialRFeat.value = SettingsTbl.SpeedoDialR
	SpeedoDialGFeat.value = SettingsTbl.SpeedoDialG
	SpeedoDialBFeat.value = SettingsTbl.SpeedoDialB
	SpeedoNeedleRFeat.value = SettingsTbl.SpeedoNeedleR
	SpeedoNeedleGFeat.value = SettingsTbl.SpeedoNeedleG
	SpeedoNeedleBFeat.value = SettingsTbl.SpeedoNeedleB
	SpeedoTextRFeat.value = SettingsTbl.SpeedoTextR
	SpeedoTextGFeat.value = SettingsTbl.SpeedoTextG
	SpeedoTextBFeat.value = SettingsTbl.SpeedoTextB
	SpeedoUnitsFeat.value = SettingsTbl.SpeedoUnits
	SpeedoDrawValueFeat.on = SettingsTbl.SpeedoDrawValue
	SpeedoAlwaysOnFeat.on = SettingsTbl.SpeedoAlwaysOn
	
	TachoEnabledFeat.on = SettingsTbl.TachoEnabled
	TachoPosXFeat.value = SettingsTbl.TachoX
	TachoPosYFeat.value = SettingsTbl.TachoY
	TachoScaleFeat.value = SettingsTbl.TachoScale
	TachoAlphaFeat.value = SettingsTbl.TachoAlpha
	TachoDialRFeat.value = SettingsTbl.TachoDialR
	TachoDialGFeat.value = SettingsTbl.TachoDialG
	TachoDialBFeat.value = SettingsTbl.TachoDialB
	TachoNeedleRFeat.value = SettingsTbl.TachoNeedleR
	TachoNeedleGFeat.value = SettingsTbl.TachoNeedleG
	TachoNeedleBFeat.value = SettingsTbl.TachoNeedleB
	TachoTextRFeat.value = SettingsTbl.TachoTextR
	TachoTextGFeat.value = SettingsTbl.TachoTextG
	TachoTextBFeat.value = SettingsTbl.TachoTextB
	TachoDrawGearFeat.on = SettingsTbl.TachoDrawGear
	
	if not Themes[SettingsTbl.ThemeName] then
		SettingsTbl.ThemeName = "Default"
	end
	for i=1,ThemesFeat.child_count do
		if ThemesFeat.children[i].name == SettingsTbl.ThemeName then
			ThemesFeat.children[i].on = true
			break
		end
	end
	
	notify("Loaded saved settings.", nil, nil, RGBAToInt(0, 255, 0, 255))
end
menu.add_feature("Save Settings", "action", ParentId, SaveSettings)
menu.add_feature("Load Settings", "action", ParentId, LoadSettings)
LoadSettings()

Speedometer = true