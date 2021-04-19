local all = {}
local settings = {}
local hotkeys = {}
local modder_flags = {}
modder_flags[0] = {}


settings[0] = {}

-- MAIN SETTINGS

	settings[0][#settings[0] + 1] = "Section.1"
	settings["Section.1"] = "[Main]"

	settings[0][#settings[0] + 1] = "Version"
	settings["Version"] = "5.0.0.0"

	settings[0][#settings[0] + 1] = "Script.Parent"
	settings["Script.Parent"] = true

	settings[0][#settings[0] + 1] = "ExcludeFriends"
	settings["ExcludeFriends"] = true

-- BLACKLIST SETTINGS

	settings[0][#settings[0] + 1] = "Blacklist.Features.Enabled"
	settings["Blacklist.Features.Enabled"] = false

	settings[0][#settings[0] + 1] = "Blacklist.Enable"
	settings["Blacklist.Enable"] = false

	settings[0][#settings[0] + 1] = "Blacklist.AutoMark"
	settings["Blacklist.AutoMark"] = false

	settings[0][#settings[0] + 1] = "Blacklist.AutoKick"
	settings["Blacklist.AutoKick"] = false

	settings[0][#settings[0] + 1] = "Blacklist.NotifyNote"
	settings["Blacklist.NotifyNote"] = false

	settings[0][#settings[0] + 1] = "Blacklist.NotifyNoteHideDefault"
	settings["Blacklist.NotifyNoteHideDefault"] = true

	settings[0][#settings[0] + 1] = "Blacklist.Admin"
	settings["Blacklist.Admin"] = true

	settings[0][#settings[0] + 1] = "Blacklist.Admin.Kick"
	settings["Blacklist.Admin.Kick"] = false

	settings[0][#settings[0] + 1] = "Blacklist.LockLobby"
	settings["Blacklist.LockLobby"] = false

-- MODDER SETTINGS

	settings[0][#settings[0] + 1] = "Modder.Features.Enabled"
	settings["Modder.Features.Enabled"] = true

	settings[0][#settings[0] + 1] = "Modder.Database.Enable"
	settings["Modder.Database.Enable"] = false

		-- IGNOREFLAGS

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Manual"
		settings["Modder.IgnoringFlags.Manual"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Player Model"
		settings["Modder.IgnoringFlags.Player Model"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.SCID 0 Crash"
		settings["Modder.IgnoringFlags.SCID 0 Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.SCID Spoof"
		settings["Modder.IgnoringFlags.SCID Spoof"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Invalid Object Crash"
		settings["Modder.IgnoringFlags.Invalid Object Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Invalid Ped Crash"
		settings["Modder.IgnoringFlags.Invalid Ped Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Clone Spawn"
		settings["Modder.IgnoringFlags.Clone Spawn"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Model Change Crash"
		settings["Modder.IgnoringFlags.Model Change Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Player Model Change"
		settings["Modder.IgnoringFlags.Player Model Change"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.RAC"
		settings["Modder.IgnoringFlags.RAC"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Money Drop"
		settings["Modder.IgnoringFlags.Money Drop"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.SEP"
		settings["Modder.IgnoringFlags.SEP"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Attach Object"
		settings["Modder.IgnoringFlags.Attach Object"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Attach Ped"
		settings["Modder.IgnoringFlags.Attach Ped"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Net Array Crash"
		settings["Modder.IgnoringFlags.Net Array Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Net Sync Crash"
		settings["Modder.IgnoringFlags.Net Sync Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Net Event Crash"
		settings["Modder.IgnoringFlags.Net Event Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Altered Host Token"
		settings["Modder.IgnoringFlags.Altered Host Token"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Blacklist"
		settings["Modder.IgnoringFlags.Blacklist"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Modder DB"
		settings["Modder.IgnoringFlags.Modder DB"] = false

		settings[0][#settings[0] + 1] = "Modder.IgnoringFlags.Name Spoof"
		settings["Modder.IgnoringFlags.Name Spoof"] = false

		-- AUTOKICKFLAGS

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Enable"
		settings["Modder.AutokickFlags.Enable"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Any"
		settings["Modder.AutokickFlags.Any"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Manual"
		settings["Modder.AutokickFlags.Manual"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Player Model"
		settings["Modder.AutokickFlags.Player Model"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.SCID 0 Crash"
		settings["Modder.AutokickFlags.SCID 0 Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.SCID Spoof"
		settings["Modder.AutokickFlags.SCID Spoof"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Invalid Object Crash"
		settings["Modder.AutokickFlags.Invalid Object Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Invalid Ped Crash"
		settings["Modder.AutokickFlags.Invalid Ped Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Clone Spawn"
		settings["Modder.AutokickFlags.Clone Spawn"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Model Change Crash"
		settings["Modder.AutokickFlags.Model Change Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Player Model Change"
		settings["Modder.AutokickFlags.Player Model Change"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.RAC"
		settings["Modder.AutokickFlags.RAC"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Money Drop"
		settings["Modder.AutokickFlags.Money Drop"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.SEP"
		settings["Modder.AutokickFlags.SEP"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Attach Object"
		settings["Modder.AutokickFlags.Attach Object"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Attach Ped"
		settings["Modder.AutokickFlags.Attach Ped"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Net Array Crash"
		settings["Modder.AutokickFlags.Net Array Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Net Sync Crash"
		settings["Modder.AutokickFlags.Net Sync Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Net Event Crash"
		settings["Modder.AutokickFlags.Net Event Crash"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Altered Host Token"
		settings["Modder.AutokickFlags.Altered Host Token"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Blacklist"
		settings["Modder.AutokickFlags.Blacklist"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Modder DB"
		settings["Modder.AutokickFlags.Modder DB"] = false

		settings[0][#settings[0] + 1] = "Modder.AutokickFlags.Name Spoof"
		settings["Modder.AutokickFlags.Name Spoof"] = false

	settings[0][#settings[0] + 1] = "Modder.AutoUnMark.IgnoringFlags"
	settings["Modder.AutoUnMark.IgnoringFlags"] = false

	settings[0][#settings[0] + 1] = "Modder.Detections.SCID Spoof"
	settings["Modder.Detections.SCID Spoof"] = false

	settings[0][#settings[0] + 1] = "Modder.Detections.Name Spoof"
	settings["Modder.Detections.Name Spoof"] = false

	settings[0][#settings[0] + 1] = "Modder.Detections.IncludeDot"
	settings["Modder.Detections.IncludeDot"] = false

	settings[0][#settings[0] + 1] = "Modder.Detections.Invalid Script Event"
	settings["Modder.Detections.Invalid Script Event"] = false

	settings[0][#settings[0] + 1] = "Modder.KarmaScriptsfromModders"
	settings["Modder.KarmaScriptsfromModders"] = false







hotkeys[0] = {}

hotkeys[0][#hotkeys[0] + 1] = "none"
hotkeys["none"] = "none"






local function setup_modder_flags()
	for i = 0, 63 do
		local int = math.floor(math.pow(2, i))
		local tag = player.get_modder_flag_text(int)
		if tag == "" then
			break
		end
		modder_flags[0][#modder_flags[0] + 1] = tag
		modder_flags[tag] = {tag, int}
	end
	modder_flags[0][#modder_flags[0] + 1] = "Blacklist"
	modder_flags["Blacklist"] = {"Blacklist", nil}

	modder_flags[0][#modder_flags[0] + 1] = "Modder DB"
	modder_flags["Modder DB"] = {"Modder DB", nil}

	modder_flags[0][#modder_flags[0] + 1] = "Name Spoof"
	modder_flags["Name Spoof"] = {"Name Spoof", nil}

	modder_flags[0][#modder_flags[0] + 1] = "Invalid Script Event"
	modder_flags["Invalid Script Event"] = {"Invalid Script Event", nil}
	for i = 16, 63 do
		local int = math.pow(2, i)
		local tag = player.get_modder_flag_text(int)
		if tag == "" then
			break
		end
		for y = 1, #modder_flags[0] do
			if tag == modder_flags[modder_flags[0][y]][1] then
				modder_flags[modder_flags[0][y]][2] = int
			end
		end
	end
	for i = 1, #modder_flags[0] do
		if not modder_flags[modder_flags[0][i]][2] then
			modder_flags[modder_flags[0][i]][2] = player.add_modder_flag(modder_flags[modder_flags[0][i]][1])
		end
	end
end
setup_modder_flags()



all.settings = settings
all.hotkeys = hotkeys
all.modder_flags = modder_flags

return all