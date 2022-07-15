local pfs = {}
pfs.scripts = utils.get_appdata_path("PopstarDevs", "") .. "\\2Take1Menu\\scripts"
pfs.lib = pfs.scripts .. "\\lib"
pfs.omnispawner = pfs.scripts .. "\\OmniSpawner"
pfs.maps = pfs.omnispawner .. "\\Omni Maps"
pfs.vehicles = pfs.omnispawner .. "\\Omni Vehicles"
pfs.log = pfs.omnispawner .. "\\OmniSpawner.log"
pfs.LIP = pfs.lib .. "\\LIP.lua"
pfs.xml2lua = pfs.lib .. "\\xml2lua.lua"
pfs.xmlParser = pfs.lib .. "\\XmlParser.lua"
pfs.xmlhandler = pfs.lib .. "\\xmlhandler\\tree.lua"
pfs.ini = pfs.omnispawner .. "\\OmniSpawner.ini"

local function check_files()
	if OmniVehicleSpawner then
		ui.notify_above_map("Omni Spawner already loaded.", "Omni Spawner", 140)
		return
	end
	if not package.path:find(pfs.lib .. "?.lua", 1, true) then package.path = package.path .. ";" .. pfs.lib .. "?.lua" end
	if not utils.dir_exists(pfs.lib) then
		ui.notify_above_map("Lib folder does not exist. Script exiting.", "Omni Spawner", 140)
		return
	end
	if not utils.dir_exists(pfs.omnispawner) then
		utils.make_dir(pfs.omnispawner)
		return
	end
	if not utils.file_exists(pfs.LIP) then
		ui.notify_above_map("LIP library does not exist. Script exiting.", "Omni Spawner", 140)
		return
	end
	if not utils.file_exists(pfs.xml2lua) then
		ui.notify_above_map("xml2lua library does not exist. Script exiting.", "Omni Spawner", 140)
		return
	end
	if not utils.file_exists(pfs.xmlParser) then
		ui.notify_above_map("XmlParser library does not exist. Script exiting.", "Omni Spawner", 140)
		return
	end
	if not utils.file_exists(pfs.xmlhandler) then
		ui.notify_above_map("xmlhandler.tree library does not exist. Script exiting.", "Omni Spawner", 140)
		return
	end
	return true
end

if not check_files() then
	ui.notify_above_map("ERROR", "ERROR", 99)
	return
end

local Settings = {}

function writelog(text)
	if not Settings.Settings.Debug then return end
    local dt = os.date("*t")
    local file = io.open(pfs.log, "a")

    io.output(file)
    io.write("["..dt.year.."-"..dt.month.."-"..dt.day.." "..dt.hour..":"..dt.min..":"..dt.sec.."] [LUA] "..text.."\n")
    io.close()
end

-- Credit: https://github.com/Dynodzzo/Lua_INI_Parser
local LIP = require("LIP")
-- Credit: https://github.com/manoelcampos/xml2lua
local xml2lua = require("xml2lua")
local handler = require("xmlhandler.tree")
local DefaultSettings = {
	["ModTitle"] = "Omni Spawner",
	["NotifColour"] = 140,
	["Debug"] = false,
	
	["SpawnInVehicle"] = true,
	["FixedZEnabled"] = false,
	["FixedZValue"] = 100,
	["NoCollision"] = false,
	["IgnoreVisible"] = false,
	["IgnoreOpacity"] = false,
	["SanitiseModExtras"] = true,
	["SetNumPlateText"] = false,
	
	["TeleportToRoot"] = true,
	["TeleportToRootZOffset"] = 0,
	["TeleportToRootZEnabled"] = false,
	["CustomRootPos"] = false,
	["CustomRootPosX"] = 0,
	["CustomRootPosY"] = 0,
	["CustomRootPosZ"] = 0,
}
if utils.file_exists(pfs.ini) then
	Settings = LIP.load(pfs.ini)
end
Settings = Settings or {}
Settings.Settings = Settings.Settings or DefaultSettings
writelog("New Omni Spawner instance")
for k,v in pairs(DefaultSettings) do
	if Settings.Settings[k] == nil then Settings.Settings[k] = v end
end
if not utils.dir_exists(pfs.vehicles) then
	writelog("Creating vehicles folder.")
	utils.make_dir(pfs.vehicles)
	ui.notify_above_map("Vehicle folder didn't exist. Created one for you.", Settings.Settings.ModTitle, Settings.Settings.NotifColour)
end
if not utils.dir_exists(pfs.maps) then
	writelog("Creating maps folder.")
	utils.make_dir(pfs.maps)
	ui.notify_above_map("Map folder didn't exist. Created one for you.", Settings.Settings.ModTitle, Settings.Settings.NotifColour)
end

local SpawnInVehicleFeature
local FixedZFeature
local NoCollisionFeature
local IgnoreVisibleFeature
local IgnoreOpacityFeature
local SetNumPlateTextFeature
local SanitiseModExtrasFeature

local TeleportToRootFeature
local TeleportToRootZOffsetFeature
local CustomRootPosFeature
local CustomRootPosXFeature
local CustomRootPosYFeature
local CustomRootPosZFeature

local function SpawnXmlVehicle(filename)
	writelog("Spawning vehicle: " .. filename)
	local path = pfs.vehicles .. "\\" .. filename
	if not utils.file_exists(path) then
		writelog("Could not find file: " .. filename)
		ui.notify_above_map("Could not find file " .. filename, Settings.Settings.ModTitle, Settings.Settings.NotifColour)
		return
	end
	
	writelog("Creating XML handler")
	local xmlHandler = handler:new()
	writelog("Creating XML parser")
	local xmlParser = xml2lua.parser(xmlHandler)
	writelog("Parsing XML")
	xmlParser:parse(xml2lua.loadFile(path))
	
	if not xmlHandler.root.Vehicle then
		writelog("Could not find vehicle tag of: " .. filename)
		ui.notify_above_map("Could not find Vehicle tag of " .. filename, Settings.Settings.ModTitle, Settings.Settings.NotifColour)
		return
	end
	
	local VehXml = xmlHandler.root.Vehicle
	
	writelog("Getting rootPos")
	local rootPos = entity.get_entity_coords(player.get_player_ped(player.player_id()))
	if FixedZFeature.on then
		writelog("Setting rootPos.z")
		rootPos.z = FixedZFeature.value_i
	end
	local handles = {}
	writelog("Getting initial handle")
	local rootHandle = VehXml.InitialHandle
	writelog("Getting model hash")
	local rootHash = tonumber(VehXml.ModelHash:sub(3), 16)
	writelog("Requesting model")
	streaming.request_model(rootHash)
	while not streaming.has_model_loaded(rootHash) do system.wait(0) end
	local isVeh = false
	writelog("Checking model type")
	if streaming.is_model_a_vehicle(rootHash) then
		isVeh = true
		writelog("Spawning vehicle")
		handles[rootHandle] = vehicle.create_vehicle(rootHash, rootPos, 0.0, true, false)
	else
		writelog("Spawning object")
		handles[rootHandle] = object.create_object(rootHash, rootPos, true, false)
	end
	writelog("Setting model as not needed")
	streaming.set_model_as_no_longer_needed(rootHash)
	writelog("Checking visibility")
	if not IgnoreVisibleFeature.on and VehXml.IsVisible == "false" then
		writelog("Setting model alpha")
		entity.set_entity_alpha(handles[rootHandle], 0, false)
		writelog("Setting model visible") 
		entity.set_entity_visible(handles[rootHandle], false)
	elseif not IgnoreOpacityFeature.on and VehXml.OpacityLevel then
		writelog("Setting model alpha")
		entity.set_entity_alpha(handles[rootHandle], tonumber(VehXml.OpacityLevel), false)
	end
	
	if isVeh and VehXml.VehicleProperties then
		local props = VehXml.VehicleProperties
		writelog("Setting wheel type")
		if props.WheelType then vehicle.set_vehicle_wheel_type(handles[rootHandle], tonumber(props.WheelType)) end
		if props.Colours then
			local cols = props.Colours
			writelog("Setting vehicle colour")
			if cols.Primary and cols.Secondary and cols.Pearl and cols.Rim then vehicle.set_vehicle_color(handles[rootHandle], tonumber(cols.Primary), tonumber(cols.Secondary), tonumber(cols.Pearl), tonumber(cols.Rim)) end
			writelog("Setting smoke colour")
			if cols.tyreSmoke_R and cols.tyreSmoke_G and cols.tyreSmoke_B then vehicle.set_vehicle_tire_smoke_color(handles[rootHandle], tonumber(cols.tyreSmoke_R), tonumber(cols.tyreSmoke_G), tonumber(cols.tyreSmoke_B)) end
		end
		writelog("Setting number plate text")
		if SetNumPlateTextFeature.on and props.NumberPlateText then vehicle.set_vehicle_number_plate_text(handles[rootHandle], props.NumberPlateText) end
		writelog("Setting number plate index")
		if props.NumberPlateIndex then vehicle.set_vehicle_number_plate_index(handles[rootHandle], tonumber(props.NumberPlateIndex)) end
		writelog("Setting bulletproof tyres")
		if props.BulletProofTyres then vehicle.set_vehicle_bulletproof_tires(handles[rootHandle], props.BulletProofTyres == "true") end
		if props.ModExtras then
			for i=1,14 do
				writelog("Checking extra " .. i)
				local extra = props.ModExtras["_" .. i]
				if extra and not SanitiseModExtrasFeature.on or vehicle.does_extra_exist(handles[rootHandle], i) then
					writelog("Setting extra " .. i)
					vehicle.set_vehicle_extra(handles[rootHandle], i, extra ~= "true")
				end
			end
		end
		if props.Mods then
			for i=0,67 do
				writelog("Checking mod " .. i)
				local mod = props.Mods["_" .. i]
				if mod then
					if mod == "true" then
						writelog("Setting toggle mod: " .. mod)
						vehicle.toggle_vehicle_mod(handles[rootHandle], i, true)
					elseif mod == "false" then
						writelog("Setting toggle mod: " .. mod)
						vehicle.toggle_vehicle_mod(handles[rootHandle], i, false)
					else
						local comma = mod:find(",", 1, true)
						local index, custom
						if comma then
							index = tonumber(mod:sub(1, comma - 1))
							custom = mod:sub(comma+1) == "1"
						else
							index = tonumber(mod)
						end
						writelog("Setting mod: " .. index .. "," .. tostring(custom))
						vehicle.set_vehicle_mod(handles[rootHandle], i, index, custom)
					end
				end
			end
		end
	end
	
	if VehXml.SpoonerAttachments and VehXml.SpoonerAttachments.Attachment then
		local VehAttachments = {}
		if #VehXml.SpoonerAttachments.Attachment == 0 then
			VehAttachments[1] = VehXml.SpoonerAttachments.Attachment
		else
			VehAttachments = VehXml.SpoonerAttachments.Attachment
		end
		writelog("Attachment table: " .. #VehAttachments)
		for i=1,#VehAttachments do
			writelog("Attachment " .. i)
			local attachment = VehAttachments[i]
			writelog("Getting handle")
			local modelHandle = attachment.InitialHandle
			writelog("Getting hash")
			local modelHash = tonumber(attachment.ModelHash:sub(3), 16)
			local dynamic = false
			writelog("Getting dynamic")
			if attachment.Dynamic then dynamic = attachment.Dynamic == "true" end
			writelog("Requesting model")
			streaming.request_model(modelHash)
			while not streaming.has_model_loaded(modelHash) do system.wait(0) end
			writelog("Checking model type")
			if attachment.PedProperties then
				writelog("Spawning ped")
				handles[modelHandle] = ped.create_ped(26, modelHash, rootPos, 0.0, true, true)
			elseif streaming.is_model_a_vehicle(modelHash) then
				writelog("Spawning vehicle")
				handles[modelHandle] = vehicle.create_vehicle(modelHash, rootPos, 0.0, true, dynamic)
				if entity.is_an_entity(handles[modelHandle]) then
					decorator.decor_set_int(handles[modelHandle], "MPBitset", 1 << 10)
				end
			else
				writelog("Spawning object")
				handles[modelHandle] = object.create_object(modelHash, rootPos, true, dynamic)
			end
			writelog("Setting model as no longer needed")
			streaming.set_model_as_no_longer_needed(modelHash)
			if NoCollisionFeature.on then
				writelog("Setting collision to false")
				entity.set_entity_collision(handles[modelHandle], false, false, false)
			end
			local attachedTo = rootHandle
			local pos = v3()
			local rot = v3()
			local boneIndex = 0
			if attachment.Attachment then
				writelog("Handling attachment tag")
				local a = attachment.Attachment
				writelog("Getting attached to")
				if a.AttachedTo and handles[a.AttachedTo] then attachedTo = a.AttachedTo end
				writelog("Getting pos x")
				if a.X then pos.x = tonumber(a.X) end
				writelog("Getting pos y")
				if a.Y then pos.y = tonumber(a.Y) end
				writelog("Getting pos z")
				if a.Z then pos.z = tonumber(a.Z) end
				writelog("Getting pitch")
				if a.Pitch then rot.x = tonumber(a.Pitch) end
				writelog("Getting roll")
				if a.Roll then rot.y = tonumber(a.Roll) end
				writelog("Getting yaw")
				if a.Yaw then rot.z = tonumber(a.Yaw) end
				writelog("Getting bone index")
				if a.BoneIndex then boneIndex = tonumber(a.BoneIndex) end
			end
			writelog("Attaching to entity")
			entity.attach_entity_to_entity(handles[modelHandle], handles[attachedTo], boneIndex, pos, rot, false, not NoCollisionFeature.on, false, 2, true)
			writelog("Checking visibility")
			if not IgnoreVisibleFeature.on and attachment.IsVisible == "false" then
				writelog("Setting model alpha")
				entity.set_entity_alpha(handles[modelHandle], 0, false)
				writelog("Setting model visible")
				entity.set_entity_visible(handles[modelHandle], false)
			elseif not IgnoreOpacityFeature.on and attachment.OpacityLevel then
				writelog("Setting model alpha")
				entity.set_entity_alpha(handles[modelHandle], tonumber(attachment.OpacityLevel), false)
			end
		end
		--[[for k,v in pairs(handles) do
			for k2,v2 in pairs(handles) do
				if k ~= k2 then
					entity.set_entity_no_collision_entity(v, v2, false)
				end
			end
		end]]
	end
	
	if SpawnInVehicleFeature.on and isVeh then
		writelog("Setting player in vehicle")
		ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), handles[rootHandle], -1)
	end
	ui.notify_above_map("Spawned in " .. filename .. ".", Settings.Settings.ModTitle, Settings.Settings.NotifColour)
end
local function SpawnIniVehicle(filename)
	writelog("Spawning vehicle: " .. filename)
	local path = pfs.vehicles .. "\\" ..filename
	if not utils.file_exists(path) then
		writelog("Could not find file: " .. filename)
		ui.notify_above_map("Could not find file " .. filename, Settings.Settings.ModTitle, Settings.Settings.NotifColour)
		return
	end
	
	local ini = LIP.load(path)
	if not ini.Vehicle and not ini.VEHICLE then
		writelog("Could not find vehicle section of: " .. filename)
		ui.notify_above_map("Could not find Vehicle section of " .. filename, Settings.Settings.ModTitle, Settings.Settings.NotifColour)
		return
	end 
	local VehIni = ini.Vehicle or ini.VEHICLE
	
	writelog("Getting rootPos")
	local rootPos = entity.get_entity_coords(player.get_player_ped(player.player_id()))
	if FixedZFeature.on then
		writelog("Setting rootPos.z")
		rootPos.z = FixedZFeature.value_i
	end
	local rootObj
	writelog("Getting model hash")
	local rootHash = VehIni.Model or VehIni.model or VehIni.hash
	if not rootHash then
		ui.notify_above_map("Could not find root model hash of" .. filename, Settings.Settings.ModTitle, Settings.Settings.NotifColour)
		return
	end
	writelog("Requesting model")
	streaming.request_model(rootHash)
	while not streaming.has_model_loaded(rootHash) do system.wait(0) end
	local isVeh = false
	writelog("Checking model type")
	if streaming.is_model_a_vehicle(rootHash) then
		isVeh = true
		writelog("Spawning vehicle")
		rootObj = vehicle.create_vehicle(rootHash, rootPos, 0.0, true, false)
	else
		writelog("Spawning object")
		rootObj = object.create_object(rootHash, rootPos, true, false)
	end
	writelog("Setting model as no longer needed")
	streaming.set_model_as_no_longer_needed(rootHash)
	
	if isVeh then
		local wheelType = VehIni.WheelsType or VehIni["wheel type"] or VehIni.wheelType
		writelog("Setting wheel type")
		if wheelType then vehicle.set_vehicle_wheel_type(rootObj, wheelType) end
		local primary = VehIni.PrimaryPaint or VehIni["primary paint"] or VehIni.primaryIndex
		local secondary = VehIni.PrimaryPaint or VehIni["secondary paint"] or VehIni.secondaryIndex
		local pearlescent = VehIni.Pearlescent or VehIni["pearlescent colour"] or VehIni.pearl
		local wheel = VehIni.WheelsColor or VehIni["wheel colour"] or VehIni.wheel
		writelog("Setting vehicle colour")
		if primary and secondary and pearlescent and wheel then vehicle.set_vehicle_color(rootObj, primary, secondary, pearlescent, wheel) end
		local tyreR = VehIni.SmokeR or VehIni["tyre smoke red"] or VehIni.tyressmoke_r
		local tyreG = VehIni.SmokeG or VehIni["tyre smoke green"] or VehIni.tyressmoke_g
		local tyreB = VehIni.SmokeB or VehIni["tyre smoke blue"] or VehIni.tyressmoke_b
		writelog("Setting smoke colour")
		if tyreR and tyreG and tyreB then vehicle.set_vehicle_tire_smoke_color(rootObj, tyreR, tyreG, tyreB) end
		local plateText = VehIni.PlateText or VehIni["plate text"] or VehIni.plate
		writelog("Setting number plate text")
		if SetNumPlateTextFeature.on and plateText and plateText:len() > 0 then vehicle.set_vehicle_number_plate_text(rootObj, plateText) end
		local plateIndex = VehIni.Unknown or VehIni["plate index"] or VehIni.plateIndex
		writelog("Setting number plate index")
		if plateIndex then vehicle.set_vehicle_number_plate_index(rootObj, plateIndex) end
		local bulletProof = VehIni.Bulletproof or VehIni["bulletproof tyres"] or VehIni.bulletproof
		writelog("Setting bulletproof tyres")
		if bulletProof then vehicle.set_vehicle_bulletproof_tires(rootObj, bulletProof == 1) end
		if ini["Vehicle Extras"] then
			for i=1,14 do
				local extra = ini["Vehicle Extras"][i]
				writelog("Checking extra " .. i)
				if extra and not SanitiseModExtrasFeature.on or vehicle.does_extra_exist(rootObj, i) then
					writelog("Setting extra " .. i)
					vehicle.set_vehicle_extra(rootObj, i, extra ~= 1)
				end
			end
		else
			for i=1,14 do
				local extra = VehIni["Extra_" .. i]
				writelog("Checking extra " .. i)
				if extra and not SanitiseModExtrasFeature.on or vehicle.does_extra_exist(rootObj, i) then
					writelog("Setting extra " .. i)
					vehicle.set_vehicle_extra(rootObj, i, extra ~= 1)
				end
			end
		end
		if ini["Vehicle Mods"] then
			for i=0,67 do
				writelog("Checking mod " .. i)
				if ini["Vehicle Toggles"] and ini["Vehicle Toggles"][i] then
					writelog("Setting toggle mod: " .. ini["Vehicle Toggles"][i])
					vehicle.toggle_vehicle_mod(rootObj, i, ini["Vehicle Toggles"][i] == 1)
				elseif ini["Vehicle Mods"][i] then
					writelog("Setting mod: " .. ini["Vehicle Mods"][i])
					vehicle.set_vehicle_mod(rootObj, i, ini["Vehicle Mods"][i])
				end
			end
		elseif ini.MODS then
			for i=0,67 do
				writelog("Checking mod " .. i)
				if ini.MODS["mod" .. i] then
					writelog("Setting mod: " .. ini.MODS["mod" .. i])
					vehicle.set_vehicle_mod(rootObj, i, ini.MODS["mod" .. i])
				end
			end
		else
			for i=0,67 do
				writelog("Checking mod " .. i)
				if VehIni["TOGGLE_" .. i] then
					writelog("Setting toggle mod: " .. VehIni["TOGGLE_" .. i])
					vehicle.toggle_vehicle_mod(rootObj, i, VehIni["TOGGLE_" .. i] == 1)
				elseif VehIni[i] then
					writelog("Setting mod: " .. VehIni[i])
					vehicle.set_vehicle_mod(rootObj, i, VehIni[i])
				end
			end
		end
	end
	
	for k,v in pairs(ini) do
		writelog("Checking potential attachment: " .. tostring(k))
		if type(k) == "number" or tostring(k):sub(1, 15) == "Attached Object" then
			writelog("Handling attachment")
			local obj
			local model = v.model or v.Model
			local pos = v3()
			local x = v.X or v.x or v["x offset"]
			local y = v.Y or v.y or v["y offset"]
			local z = v.Z or v.z or v["z offset"]
			if x then pos.x = x end
			if y then pos.y = y end
			if z then pos.z = z end
			local rot = v3()
			local pitch = v.RotX or v["pitch"]
			local roll = v.RotY or v["roll"]
			local yaw = v.RotZ or v["yaw"]
			if pitch then rot.x = pitch end
			if roll then rot.y = roll end
			if yaw then rot.z = yaw end
			
			writelog("Requesting model: " .. model)
			streaming.request_model(model)
			while not streaming.has_model_loaded(model) do system.wait(0) end
			writelog("Checking model type")
			if streaming.is_model_a_vehicle(model) then
				writelog("Spawning vehicle")
				obj = vehicle.create_vehicle(model, rootPos, 0.0, true, false)
			else
				writelog("Spawning object")
				obj = object.create_object(model, rootPos, true, false)
			end
			writelog("Setting model as no longer needed")
			streaming.set_model_as_no_longer_needed(model)
			if NoCollisionFeature.on then
				writelog("Setting model collision to false")
				entity.set_entity_collision(obj, false, false, false)
			end
			writelog("Attaching entity")
			entity.attach_entity_to_entity(obj, rootObj, 0, pos, rot, false, not NoCollisionFeature.on, false, 2, true)
		end
	end
	
	if SpawnInVehicleFeature.on and isVeh then
		writelog("Setting player in vehicle")
		ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), rootObj, -1)
	end
	ui.notify_above_map("Spawned in " .. filename .. ".", Settings.Settings.ModTitle, Settings.Settings.NotifColour)
end
local function SpawnXmlMap(filename)
	writelog("Spawning map: " .. filename)
	local path = pfs.maps .. "\\" .. filename
	if not utils.file_exists(path) then
		writelog("Couldn't find map file: " .. filename)
		ui.notify_above_map("Could not find file " .. filename, Settings.Settings.ModTitle, Settings.Settings.NotifColour)
		return
	end
	
	writelog("Creating XML handler")
	local xmlHandler = handler:new()
	writelog("Creating XML parser")
	local xmlParser = xml2lua.parser(xmlHandler)
	writelog("Parsing XML file")
	xmlParser:parse(xml2lua.loadFile(path))
	
	if not xmlHandler.root.SpoonerPlacements then
		writelog("Couldn't find root tag of file: " .. filename)
		ui.notify_above_map("Could not find SpoonerPlacements tag of " .. filename, Settings.Settings.ModTitle, Settings.Settings.NotifColour)
		return
	end
	
	local MapXml = xmlHandler.root.SpoonerPlacements
	local rootPos = v3()
	if CustomRootPosFeature.on then
		rootPos.x = CustomRootPosXFeature.value_i
		rootPos.y = CustomRootPosYFeature.value_i
		rootPos.z = CustomRootPosZFeature.value_i
	end
	local referencePos = v3()
	referencePos.x = rootPos.x
	referencePos.y = rootPos.y
	referencePos.z = rootPos.z
	if MapXml.ReferenceCoords then
		local coords = MapXml.ReferenceCoords
		if coords.X then referencePos.x = tonumber(coords.X) + referencePos.x end
		if coords.Y then referencePos.y = tonumber(coords.Y) + referencePos.y end
		if coords.Z then referencePos.z = tonumber(coords.Z) + referencePos.z end
	end
	
	local MapPlacements = {}
	if #MapXml.Placement == 0 then
		MapPlacements[1] = MapXml.Placement
	else
		MapPlacements = MapXml.Placement
	end
	
	local handles = {}
	for i=1,#MapPlacements do
		writelog("Handling placement " .. i)
		local placement = MapPlacements[i]
		local modelHandle = placement.InitialHandle
		local modelHash = tonumber(placement.ModelHash:sub(3), 16)
		local dynamic = false
		if placement.Dynamic then dynamic = placement.Dynamic == "true" end
		local pos = v3()
		local posRot = placement.PositionRotation
		pos.x = rootPos.x + tonumber(posRot.X)
		pos.y = rootPos.y + tonumber(posRot.Y)
		pos.z = rootPos.z + tonumber(posRot.Z)
		local rot = v3()
		rot.x = tonumber(posRot.Pitch)
		rot.y = tonumber(posRot.Roll)
		rot.z = tonumber(posRot.Yaw)
		writelog("Requesting model")
		streaming.request_model(modelHash)
		while not streaming.has_model_loaded(modelHash) do system.wait(0) end
		writelog("Checking model type")
		if placement.PedProperties then
			writelog("Spawning ped")
			handles[modelHandle] = ped.create_ped(26, modelHash, pos, 0.0, true, true)
		elseif streaming.is_model_a_vehicle(modelHash) then
			writelog("Spawning vehicle")
			handles[modelHandle] = vehicle.create_vehicle(modelHash, pos, 0.0, true, dynamic)
		else
			writelog("Spawning model")
			handles[modelHandle] = object.create_object(modelHash, pos, true, dynamic)
		end
		if not handles[modelHandle] then
			streaming.request_model(1030400667)
			while not streaming.has_model_loaded(1030400667) do system.wait(0) end
			handles[modelHandle] = vehicle.create_vehicle(1030400667, pos, 0.0, true, dynamic)
		end
		writelog("Setting model as no longer needed")
		streaming.set_model_as_no_longer_needed(modelHash)
		writelog("Freezing entity")
		entity.freeze_entity(handles[modelHandle], true)
		writelog("Setting entity pos")
		entity.set_entity_coords_no_offset(handles[modelHandle], pos)
		writelog("Setting entity rot")
		entity.set_entity_rotation(handles[modelHandle], rot)
		writelog("Setting entity gravity")
		--entity.set_entity_gravity(handles[modelHandle], true)
		if not IgnoreVisibleFeature.on and placement.IsVisible == "false" then
			writelog("Setting entity alpha")
			entity.set_entity_alpha(handles[modelHandle], 0, false)
			writelog("Setting entity visible")
			entity.set_entity_visible(handles[modelHandle], false)
		elseif not IgnoreOpacityFeature.on and placement.OpacityLevel then
			writelog("Setting entity alpha")
			entity.set_entity_alpha(handles[modelHandle], tonumber(placement.OpacityLevel), false)
		end
		writelog("Setting entity collision")
		entity.set_entity_collision(handles[modelHandle], true, true, false)
		local attachment = placement.Attachment
		if attachment._attr.isAttached and attachment._attr.isAttached == "true" then
			local attachedTo = attachment.AttachedTo
			pos = v3()
			rot = v3()
			local boneIndex = 0
			if attachment.X then pos.x = tonumber(attachment.X) end
			if attachment.Y then pos.y = tonumber(attachment.Y) end
			if attachment.Z then pos.z = tonumber(attachment.Z) end
			if attachment.Pitch then rot.x = tonumber(attachment.Pitch) end
			if attachment.Roll then rot.y = tonumber(attachment.Roll) end
			if attachment.Yaw then rot.z = tonumber(attachment.Yaw) end
			if attachment.BoneIndex then boneIndex = tonumber(attachment.BoneIndex) end
			writelog("Attaching entity")
			entity.attach_entity_to_entity(handles[modelHandle], handles[attachedTo], boneIndex, pos, rot, false, true, false, 2, true)
		end
	end
	
	if TeleportToRootFeature.on then
		if TeleportToRootZOffsetFeature.on then
			referencePos.z = referencePos.z + TeleportToRootZOffsetFeature.value_i
		end
		referencePos.z = math.max(-200, referencePos.z)
		local LP = player.get_player_ped(player.player_id())
		writelog("Teleporting player to root pos")
		entity.set_entity_velocity(LP, v3())
		entity.set_entity_coords_no_offset(LP, referencePos)
	end
	ui.notify_above_map("Map spawned.", Settings.Settings.ModTitle, Settings.Settings.NotifColour)
end
local function SpawnIniMap(filename)
	local path = pfs.maps .. "\\" .. filename
	if not utils.file_exists(path) then
		ui.notify_above_map("Could not find file " .. filename, Settings.Settings.ModTitle, Settings.Settings.NotifColour)
		return
	end
	
	local ini = LIP.load(path)
	ui.notify_above_map("INI Maps not yet implemented.", Settings.Settings.ModTitle, Settings.Settings.NotifColour)
end

local loadedVehicles = {}
local loadedMaps = {}

local rootId = nil
local vehFeature = nil
local iniVehFeature = nil
local xmlVehFeature = nil
local mapFeature = nil
local iniMapFeature = nil
local xmlMapFeature = nil

local function GetFiles()
	local vehFiles = {}
	local all = utils.get_all_files_in_directory(pfs.vehicles, "ini")
	for i = 1, #all do
		writelog("Found vehicle file: " .. all[i])
		vehFiles[#vehFiles + 1] = all[i]
	end
	all = utils.get_all_files_in_directory(pfs.vehicles, "xml")
	for i = 1, #all do
		writelog("Found vehicle file: " .. all[i])
		vehFiles[#vehFiles + 1] = all[i]
	end
	local mapFiles = {}
	all = utils.get_all_files_in_directory(pfs.maps, "ini")
	for i = 1, #all do
		writelog("Found map file: " .. all[i])
		mapFiles[#mapFiles + 1] = all[i]
	end
	all = utils.get_all_files_in_directory(pfs.maps, "xml")
	for i = 1, #all do
		writelog("Found map file: " .. all[i])
		mapFiles[#mapFiles + 1] = all[i]
	end
	if #vehFiles == 0 and #mapFiles == 0 then return false end
	rootId = rootId or menu.add_feature("Omni Spawner", "parent", 0).id
	vehFeature = vehFeature or menu.add_feature("Vehicles", "parent", rootId)
	iniVehFeature = iniVehFeature or menu.add_feature("INI Vehicles", "parent", vehFeature.id)
	xmlVehFeature = xmlVehFeature or menu.add_feature("XML Vehicles", "parent", vehFeature.id)
	vehFeature.hidden = true
	iniVehFeature.hidden = true
	xmlVehFeature.hidden = true
	mapFeature = mapFeature or menu.add_feature("Maps", "parent", rootId)
	iniMapFeature = iniMapFeature or menu.add_feature("INI Maps", "parent", mapFeature.id)
	xmlMapFeature = xmlMapFeature or menu.add_feature("XML Maps", "parent", mapFeature.id)
	mapFeature.hidden = true
	iniMapFeature.hidden = true
	xmlMapFeature.hidden = true
	for k,v in pairs(loadedVehicles) do
		v.hidden = true
	end
	if #vehFiles > 0 then
		vehFeature.hidden = false
		for i=1,#vehFiles do
			local filename = vehFiles[i]
			if loadedVehicles[filename] then
				loadedVehicles[filename].parent.hidden = false
				loadedVehicles[filename].hidden = false
			else
				local ext = filename:sub(-4):lower()
				if ext == ".xml" then
					xmlVehFeature.hidden = false
					loadedVehicles[filename] = menu.add_feature(filename:sub(1, -5), "action", xmlVehFeature.id, function()
						SpawnXmlVehicle(filename)
						return HANDLER_POP
					end)
				elseif ext == ".ini" then
					iniVehFeature.hidden = false
					loadedVehicles[filename] = menu.add_feature(filename:sub(1, -5), "action", iniVehFeature.id, function()
						SpawnIniVehicle(filename)
						return HANDLER_POP
					end)
				end
			end
		end
	end
	if #mapFiles > 0 then
		mapFeature.hidden = false
		for i=1,#mapFiles do
			local filename = mapFiles[i]
			if loadedMaps[filename] then
				loadedMaps[filename].hidden = false
			else
				local ext = filename:sub(-4):lower()
				if ext == ".xml" then
					xmlMapFeature.hidden = false
					loadedMaps[filename] = menu.add_feature(filename:sub(1, -5), "action", xmlMapFeature.id, function()
						SpawnXmlMap(filename)
						return HANDLER_POP
					end)
				elseif ext == ".ini" then
					iniMapFeature.hidden = false
					loadedMaps[filename] = menu.add_feature(filename:sub(1, -5), "action", iniMapFeature.id, function()
						SpawnIniMap(filename)
						return HANDLER_POP
					end)
				end
			end
		end
	end
	return true
end

if not GetFiles() then
	ui.notify_above_map("No vehicles found. Place XML files in the folder created in your scripts folder.", Settings.Settings.ModTitle, Settings.Settings.NotifColour)
	return
end

menu.add_feature("Reload Files", "action", rootId, function()
	GetFiles()
	return HANDLER_POP
end).threaded = false

SpawnInVehicleFeature = menu.add_feature("Spawn In Vehice", "toggle", vehFeature.id)
SpawnInVehicleFeature.on = Settings.Settings.SpawnInVehicle
FixedZFeature = menu.add_feature("Fixed Z Coordinate", "value_i", vehFeature.id)
FixedZFeature.min_i = 0
FixedZFeature.max_i = 2000
FixedZFeature.mod_i = 10
FixedZFeature.value_i = Settings.Settings.FixedZValue
FixedZFeature.on = Settings.Settings.FixedZEnabled
NoCollisionFeature = menu.add_feature("No Collision Attachments", "toggle", vehFeature.id)
NoCollisionFeature.on = Settings.Settings.NoCollision
IgnoreVisibleFeature = menu.add_feature("Ignore Visible Value", "toggle", vehFeature.id)
IgnoreVisibleFeature.on = Settings.Settings.IgnoreVisible
IgnoreOpacityFeature = menu.add_feature("Ignore Opacity Value", "toggle", vehFeature.id)
IgnoreOpacityFeature.on = Settings.Settings.IgnoreOpacity
SanitiseModExtrasFeature = menu.add_feature("Sanitise Mod Extras", "toggle", vehFeature.id)
SanitiseModExtrasFeature.on = Settings.Settings.SanitiseModExtras
SetNumPlateTextFeature = menu.add_feature("Set Numberplate Text", "toggle", vehFeature.id)
SetNumPlateTextFeature.on = Settings.Settings.SetNumPlateText

TeleportToRootFeature = menu.add_feature("Teleport To Root", "toggle", mapFeature.id)
TeleportToRootFeature.on = Settings.Settings.TeleportToRoot
TeleportToRootZOffsetFeature = menu.add_feature("Teleport To Root Z Offset", "action_value_i", mapFeature.id)
TeleportToRootZOffsetFeature.min_i = -2000
TeleportToRootZOffsetFeature.max_i = 2000
TeleportToRootZOffsetFeature.mod_i = 10
TeleportToRootZOffsetFeature.value_i = Settings.Settings.TeleportToRootZOffset
TeleportToRootZOffsetFeature.on = Settings.Settings.TeleportToRootZEnabled
CustomRootPosFeature = menu.add_feature("Custom Root Pos", "toggle", mapFeature.id)
CustomRootPosFeature.on = Settings.Settings.CustomRootPos
CustomRootPosXFeature = menu.add_feature("Root Pos X", "action_value_i", mapFeature.id)
CustomRootPosXFeature.min_i = -2000
CustomRootPosXFeature.max_i = 2000
CustomRootPosXFeature.mod_i = 10
CustomRootPosXFeature.value_i = Settings.Settings.CustomRootPosX
CustomRootPosYFeature = menu.add_feature("Root Pos Y", "action_value_i", mapFeature.id)
CustomRootPosYFeature.min_i = -2000
CustomRootPosYFeature.max_i = 2000
CustomRootPosYFeature.mod_i = 10
CustomRootPosYFeature.value_i = Settings.Settings.CustomRootPosY
CustomRootPosZFeature = menu.add_feature("Root Pos Z", "action_value_i", mapFeature.id)
CustomRootPosZFeature.min_i = -2000
CustomRootPosZFeature.max_i = 2000
CustomRootPosZFeature.mod_i = 10
CustomRootPosZFeature.value_i = Settings.Settings.CustomRootPosZ
menu.add_feature("Set Root to Player Pos", "action", mapFeature.id, function()
	local rootPos = entity.get_entity_coords(player.get_player_ped(player.player_id()))
	CustomRootPosXFeature.value_i = math.floor(rootPos.x)
	CustomRootPosYFeature.value_i = math.floor(rootPos.y)
	CustomRootPosZFeature.value_i = math.floor(rootPos.z)
	return HANDLER_POP
end).threaded = false


menu.add_feature("Save Settings INI", "action", rootId, function()
	Settings.Settings.SpawnInVehicle = SpawnInVehicleFeature.on
	Settings.Settings.FixedZEnabled = FixedZFeature.on
	Settings.Settings.FixedZValue = FixedZFeature.value_i
	Settings.Settings.NoCollision = NoCollisionFeature.on
	Settings.Settings.IgnoreVisible = IgnoreVisibleFeature.on
	Settings.Settings.IgnoreOpacity = IgnoreOpacityFeature.on
	Settings.Settings.SanitiseModExtras = SanitiseModExtrasFeature.on
	Settings.Settings.SetNumPlateText = SetNumPlateTextFeature.on
	
	Settings.Settings.TeleportToRoot = TeleportToRootFeature.on
	Settings.Settings.TeleportToRootZOffset = TeleportToRootZOffsetFeature.value_i
	Settings.Settings.TeleportToRootZEnabled = TeleportToRootZOffsetFeature.on
	Settings.Settings.CustomRootPos = CustomRootPosFeature.on
	Settings.Settings.CustomRootPosX = CustomRootPosXFeature.value_i
	Settings.Settings.CustomRootPosY = CustomRootPosYFeature.value_i
	Settings.Settings.CustomRootPosZ = CustomRootPosZFeature.value_i
	
	LIP.save(pfs.ini, Settings)
	ui.notify_above_map("Settings saved.", Settings.Settings.ModTitle, Settings.Settings.NotifColour)
	return HANDLER_POP
end).threaded = false

ui.notify_above_map("Omni Spawner loaded.", Settings.Settings.ModTitle, Settings.Settings.NotifColour)
OmniVehicleSpawner = true