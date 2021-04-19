local setup = {features = {}}
local path, file, s
local settings, hotkeys, modder_flags
local scripts
local mf
local g
local u = {}
local features = {
	script = 0,
	p = {},
	t = {},
	a = {}
}
local blacklist = {
	user = {},
	active = {},
	admins = {
		{"applecloning", 115643538, "Game bug testing"},
		{"BeoMonstarh", 144372813, "Game bug testing"},
		{"BlobbyFett22", 88047835, "Game bug testing"},
		{"ExoSnowBoarder", 115670847, "Game bug testing"},
		{"ExtremeThanks15", 173426004, "Game bug testing"},
		{"BailMail99", 170727774, "Online content dev/Game bug testing"},
		{"ForrestTrump69", 93759254, "Game bug testing"},
		{"KingOfGolf", 174247774, "Game bug testing"},
		{"KrustyShackles", 151975489, "Game bug testing"},
		{"PassiveSalon", 146999560, "Game bug testing"},
		{"PearBiscuits34", 179930265, "Game bug testing"},
		{"SlowMoKing", 88435236, "Game bug testing"},
		{"Smooth_Landing", 179936743, "Game bug testing"},
		{"SuperTrevor123", 179848203, "Game bug testing"},
		{"Tamehippoe", 151158634, "Game bug testing"},
		{"uwu-bend", 174623904, "Game bug testing"},
		{"VickDMF", 179936852, "Game bug testing"},
		{"AlpacaBarista", 117639190, "Game bug testing"},
		{"The_Real_Harambe", 93759401, "Game bug testing"},
		{"Flares4Lyfe", 103814653, "Game bug testing"},
		{"FluteOfMilton", 121970978, "Game bug testing"},
		{"PipPipJongles", 174623951, "Game bug testing"},
		{"YUyu-lampon", 174624061, "Game bug testing"},
		{"DeadOnAir", 10552062, "Online content dev/Game bug testing"},
		{"Poppernopple", 174625194, "Game bug testing"},
		{"KrunchyCh1cken", 174625307, "Game bug testing"},
		{"BlessedChu", 174625407, "Game bug testing"},
		{"Surgeio", 174625552, "Game bug testing"},
		{"WindmillDuncan", 174625647, "Game bug testing"},
		{"Paulverines", 138273823, "Game bug testing"},
		{"ZombieTom66", 138302559, "Game bug testing"},
		{"st1nky_p1nky", 139813495, "Game bug testing"},
		{"OilyLordAinsley", 88435916, "Game bug testing"},
		{"FruitPuncher15", 174875493, "SCTV cheater monitoring"},
		{"PisswasserMax", 171094021, "SCTV cheater monitoring"},
		{"BanSparklinWater", 173213117, "SCTV cheater monitoring"},
		{"BrucieJuiceyIV", 171093866, "SCTV cheater monitoring"},
		{"RapidRaichu", 88435362, "Game bug testing"},
		{"kingmario11", 137601710, "SCTV cheater monitoring"},
		{"DigitalFox9", 103054099, "Cheat analysis"},
		{"FoxesAreCool69", 104041189, "Cheat analysis"},
		{"SweetPlumbus", 99453882, "SCTV cheater monitoring + cheat analysis"},
		{"IM-_-Wassup", 104432921, "SCTV cheater monitoring"},
		{"WickedFalcon4054", 147604980, "Game bug testing"},
		{"aquabull", 130291558, "Game bug testing"},
		{"Ghostofwar1", 141884823, "Game bug testing"},
		{"DAWNBILLA", 131037988, "Game bug testing"},
		{"Aur3lian", 153219155, "SCTV cheater monitoring"},
		{"JulianApost4te", 155527062, "SCTV cheater monitoring"},
		{"DarkStar7171", 114982881},
		{"xCuteBunny", 119266383, "SCTV cheater monitoring"},
		{"random_123", 119958356, "SCTV cheater monitoring"},
		{"random123", 216820, "SCTV cheater monitoring"},
		{"flyingcobra16", 121397532, "SCTV cheater monitoring"},
		{"CriticalRegret", 121698158, "Cheat analysis"},
		{"ScentedPotter", 18965281, "Cheat analysis"},
		{"Huginn5", 56778561, "Cheat analysis"},
		{"Sonknuck", 63457, "Cheat analysis"},
		{"HammerDaddy69", 121943600, "SCTV cheater monitoring"},
		{"johnet123", 123017343, "Game bug testing"},
		{"bipolarcarp", 123849404, "SCTV cheater monitoring"},
		{"jakw0lf", 127448079, "Game bug testing"},
		{"Kakorot02", 129159629, "SCTV cheater monitoring"},
		{"CrazyCatPilots", 127403483, "Game bug testing"},
		{"G_ashman", 174194059, "Game bug testing"},
		{"Rossthetic", 131973478},
		{"StrongBelwas1", 64234321, "SCTV cheater monitoring"},
		{"TonyMSD1", 62409944, "SCTV cheater monitoring"},
		{"AMoreno14", 64074298, "SCTV cheater monitoring"},
		{"PayneInUrAbs", 133709045, "SCTV cheater monitoring"},
		{"shibuz_gamer123", 134412628, "SCTV cheater monitoring"},
		{"M1thras", 137579070, "SCTV cheater monitoring"},
		{"Th3_Morr1gan", 137714280, "SCTV cheater monitoring"},
		{"Z3ro_Chill", 137851207, "SCTV cheater monitoring"},
		{"Titan261", 130291511, "Game bug testing"},
		{"Coffee_Collie", 138075198},
		{"BananaGod951", 137663665, "SCTV cheater monitoring"},
		{"s0cc3r33", 9284553, "SCTV cheater monitoring"},
		{"trajan5", 147111499, "SCTV cheater monitoring"},
		{"thewho146", 6597634, "Game bug testing"},
		{"Bangers_RSG", 23659342, "Live streams"},
		{"Bash_RSG", 23659354, "Live streams"},
		{"Bubblez_RSG", 103318524, "Live streams"},
		{"ChefRSG", 132521200},
		{"Chunk_RSG", 107713114, "Live streams"},
		{"HotTub_RSG", 107713060, "Live streams"},
		{"JPEGMAFIA_RSG", 23659353, "Live streams"},
		{"Klang_RSG", 57233573, "Live streams"},
		{"Lean1_RSG", 111439945, "Live streams"},
		{"Ton_RSG", 81691532, "Live streams"},
		{"RSGWolfman", 77205006},
		{"TheUntamedVoid", 25695975},
		{"TylerTGTAB", 24646485},
		{"Wilted_spinach", 49770174},
		{"RSGINTJoe", 146452200},
		{"RSGGuestV", 54468359},
		{"RSGGuest50", 54462116},
		{"RSGGuest40", 53309582},
		{"Logic_rsg", 85593421},
		{"RSGGuest12", 21088063},
		{"RSGGuest7", 50850475},
		{"ScottM_RSG", 31586721},
		{"Rockin5", 56583239},
		{"playrockstar6", 20158753},
		{"PlayRockstar5", 20158751},
		{"PlayRockstar1", 23659351},
		{"Player8_RSG", 91031119},
		{"Player7_RSG", 91003708},
		{"MaxPayneDev16", 16396170, "Core game dev"},
		{"MaxPayneDev15", 16396157, "Core game dev"},
		{"MaxPayneDev14", 16396148, "Core game dev"},
		{"MaxPayneDev13", 16396141, "Core game dev"},
		{"MaxPayneDev12", 16396133, "Core game dev"},
		{"MaxPayneDev11", 16396126, "Core game dev"},
		{"MaxPayneDev10", 16396118, "Core game dev"},
		{"MaxPayneDev9", 16396107, "Core game dev"},
		{"MaxPayneDev8", 16396096, "Core game dev"},
		{"MaxPayneDev7", 16396091, "Core game dev"},
		{"MaxPayneDev6", 16396080, "Core game dev"},
		{"MaxPayneDev5", 16395850, "Core game dev"},
		{"MaxPayneDev4", 16395840, "Core game dev"},
		{"MaxPayneDev3", 16395850, "Core game dev"},
		{"MaxPayneDev2", 16395782, "Core game dev"},
		{"MaxPayneDev1", 16395773, "Core game dev"},
		{"MaxPayne3Dev12", 22577458, "Core game dev"},
		{"MaxPayne3Dev11", 22577440, "Core game dev"},
		{"MaxPayne3Dev9", 22577121, "Core game dev"},
		{"GTAdev4", 16395782, "Core game dev"},
		{"GTAdev3", 20158757, "Core game dev"}
	},
	active2 = {},
	whitelisted = {},
	active3 = {}
}
local modder = {
	user = {},
	active = {},
	active2 = {}
}
local events = {
	scripts = {},
	nets = {},
	chat = {}
}

function setup.load(_file)
	local main_path = utils.get_appdata_path("PopstarDevs", "") .. "\\2Take1Menu\\scripts\\2Take1Script\\Data\\"
	if utils.file_exists(main_path .. _file) then
		local data, error = loadfile(main_path .. _file)
		if not error then
			return data()
		end
		print(error)
	end
	return
end

function setup.data()
	if TwoTakeOneScript then
		return false, "Script is already loaded. Use \"Reset State\" under \"Scripts.\""
	end
	math.randomseed(utils.time_ms())
	local data = setup.load("pfs.lua")
	if data then
		path = data.path
		file = data.file
		s = data.shortcut
	else
		return false, "Error loading \"pfs.lua\"."
	end
	data = nil
	data = setup.load("shm.lua")
	if data then
		settings = data.settings
		hotkeys = data.hotkeys
		modder_flags = data.modder_flags
	else
		return false, "Error loading \"shm.lua\"."
	end
	data = nil
	data = setup.load("se.lua")
	if data then
		scripts = data
	else
		return false, "Error loading \"se.lua\"."
	end
	data = nil
	data = setup.load("mf.lua")
	if data then
		mf = data
	else
		return false, "Error loading \"mf.lua\"."
	end
	data = nil
	data = setup.load("get.lua")
	if data then
		g = data
	else
		return false, "Error loading \"get.lua\"."
	end
	TwoTakeOneScript = true
	return true
end

local success, error = setup.data()
if error then
	ui.notify_above_map("Error loading Script:\n" .. error, "~h~2Take1Script~h~&#166", 208)
	return
end

function u.write(_file, text, mode)
	if _file and text then
		mode = mode or "a"
		_file = s.o(_file, mode)
		io.output(_file)
		io.write(text .. "\n")
		io.close(_file)
		return true
	end
	return
end

function u.time()
	local time = os.date("*t")
	time.isdst = nil
	for key, value in pairs(time) do
		if #s.ts(value) == 1 then
			time[key] = "0" .. value
		end
	end
	return "[" .. time.year .. "-" .. time.month .. "-" .. time.day .. " " .. time.hour .. ":" .. time.min .. ":" .. time.sec .. "]"
end

function u.stop(feat)
	if feat.on then
		return 0
	end
	return 1
end

function u.n(text, color, header)
	if not text then
		return
	end
	color = color or 99
	header = header or "~h~2Take1Script~h~&#166"
	if settings["override_notify_color"] then
		color = settings["notify_color"]
	end
	ui.notify_above_map(text, header, color)
end

function u.l(text, custom)
	if settings["log"] then
		if not text then
			return
		end
		local prefix = u.time() .. " [2Take1Script]"
		if custom then
			prefix = prefix .. custom .. " "
		end
		return u.write(file.log, prefix .. text)
	end
	return
end

function u.chat(text, plid)
	if not text then
		return
	end
	return u.write(file.chat, u.time() .. " [" .. g.name(plid) .. ":" .. g.scid(plid) .. ":" .. g.ip(plid) .. "] '" .. text .. "'")
end

function blacklist.update()
	if not s.f_exists(file.blacklist) then
		return
	end
	blacklist.user = {}
	local bl_file = s.o(file.blacklist, "r")
	for line in io.lines(file.blacklist) do
		if string.find(line, "]", 1) then
			line = line:sub(2, -2)
			blacklist.user[#blacklist.user + 1] = {}
			blacklist.user[#blacklist.user][1] = s.tn(line)
		else
			blacklist.user[#blacklist.user][#blacklist.user[#blacklist.user] + 1] = line
		end
	end
	io.close(bl_file)
end

function blacklist.add(scid, name, note)
	for i = 1, #blacklist.user do
		if s.tn(scid) == blacklist.user[i][1] then
			u.n("SCID already on Blacklist.cfg. Aborting.")
			return
		end
	end
	u.write(file.blacklist, "[" .. scid .. "]")
	u.write(file.blacklist, name)
	u.write(file.blacklist, note)
	return true
end

function blacklist.remove(scids)
	local abort = true
	for i = 1, #blacklist.user do
		for y = 1, #scids do
			if blacklist.user[i][1] == scids[y] then
				abort = false
			end
		end
	end
	if abort then
		u.n("Removing failed...\nMake sure you entered the right SCID(s).")
		return
	end
	local _file = s.o(file.blacklist, "w")
	io.output(_file)
	io.close(_file)
	local count = 0
	for i = 1, #blacklist.user do
		local add = true
		for y = 1, #scids do
			if blacklist.user[i][1] == scids[y] then
				add = false
			end
		end
		if add then
			count = count + 1
			u.write(file.blacklist, "[" .. blacklist.user[i][1] .. "]")
			u.write(file.blacklist, blacklist.user[i][2])
			u.write(file.blacklist, blacklist.user[i][3])
		end
	end
	return true, #blacklist.user - count
end

function modder.update()
	if not s.f_exists(file.modders) then
		return
	end
	modder.user = {}
	local md_file = s.o(file.modders, "r")
	for line in io.lines(file.modders) do
		if string.find(a, "={") and string.find(a, "}") then
			local cut = string.find(line, "=")
			local scid = line:sub(1, cut -1)
			line = line:sub(cut + 2, -2)
			cut = nil
			modder.user[#modder.user + 1] = {}
			modder.user[#modder.user][1] = s.tn(scid)
			while line do
				cut = string.find(line, ", ")
				if cut then
					local flag = line:sub(1, cut - 1)
					modder.user[#modder.user][#modder.user[#modder.user] + 1] = flag
					line = line:sub(cut +2)
				else
					modder.user[#modder.user][#modder.user[#modder.user] + 1] = flag
					line = nil
				end
			end
		end
	end
	io.close(md_file)
end

function modder.add(scid, flags)

end

function modder.remove(scid)

end

function modder.get_all_flags_from_player(ID)
	local flags = {}
	for y = 0, 63 do
		local int = math.floor(math.pow(2, y))
		local tag = player.get_modder_flag_text(int)
		if tag == "" then
			break
		end
		if s.is_modder(ID, int) then
			flags[#flags + 1] = tag
		end
	end
	return flags
end

function setup.features.blacklist()
	features.p["Blacklist"] = mf.p("Blacklist", features.script).id

	blacklist.update()

	if not s.f_exists(file.blacklist) then
		u.n("File does not exist.\nCreating file with example Entry.", 207)
		u.write(file.blacklist, "[999999999]")
		u.write(file.blacklist, "HereGoesTheName")
		u.write(file.blacklist, ";Optional short single-line Note about the blocked SCID (999999999). You can leave the Note and the Name blank.")
		u.n("'Blacklist.cfg' created in '2Take1Script\\CustomFiles\\'", 207)
	end
	

	--Temp function, will delete after 1-2 releases
		if s.f_exists(path.custom .. "\\2Take1Blacklist.cfg") then
			blacklist.update()
			u.n("Old Blacklist found, converting into new format.", 207)
			local oldfile = path.custom .. "\\2Take1Blacklist.cfg"
			local newIds, newNames = {}, {}
			local sf = s.o(oldfile, "r")
			if sf then
				for line in io.lines(oldfile) do
					x = 1
					for token in string.gmatch(line, "[^%s]+") do
						if x == 1 then
							blacklist.user[#blacklist.user + 1] = {}
							blacklist.user[#blacklist.user][1] = s.tn(token)
						else
							blacklist.user[#blacklist.user][#blacklist.user[#blacklist.user] + 1] = token or "NoNameFound"
							blacklist.user[#blacklist.user][#blacklist.user[#blacklist.user] + 1] = ";Optional Note - converted from old Blacklist into new one."
						end
						x = x + 1
					end
				end
			end
			io.close(sf)
			sf = s.o(file.blacklist, "w")
			io.close(sf)
			local prevent_double = {}
			for i = 1, #blacklist.user do
				local scid = blacklist.user[i][1]
				if not prevent_double[scid] then
					local name = blacklist.user[i][2] or "NoNameFound"
					local note = blacklist.user[i][3] or ";Optional Note."
					u.write(file.blacklist, "[" .. scid .. "]")
					u.write(file.blacklist, name)
					u.write(file.blacklist, note)
					prevent_double[scid] = true
				end
			end
			blacklist.update()
			--io.remove(oldfile)
		end


	features.t["Blacklist.Enable"] = mf.t("Enable SCID-Blacklist", features.p["Blacklist"], function(feat)
		settings["Blacklist.Enable"] = feat.on
		if feat.on then
			s.wait(1000)
			for i = 0, 31 do
				if s.valid(i) then
					local scid = g.scid(i)
					for y = 1, #blacklist.user do
						if scid == blacklist.user[y][1] then
							if not blacklist.active[scid] then
								blacklist.active[scid] = s.time() + s.random(15000, 25000)
								local name = g.name(i)
								local msg = "Blocked player detected\nSCID:" .. scid .. "\nCurrent:" .. name
								if name ~= blacklist.user[y][2] then
									msg = msg .. "\nBlacklisted:" .. blacklist.user[y][2]
								end
								u.n(msg, 27)
								if features.t["Blacklist.AutoMark"].on then
									u.l("Marking '" .. name .. "' as a Modder with Flag: '" .. modder_flags["Blacklist"][1] .. "'.")
									s.set_modder(i, modder_flags["Blacklist"][2])
								end
								if features.t["Blacklist.AutoKick"].on then
									-- kick player
								end
								if features.t["Blacklist.NotifyNote"].on then
									local note = blacklist.user[y][3]
									if features.t["Blacklist.NotifyNoteHideDefault"].on then
										if string.find(note, ";Optional Note", 1) then
											note = false
										end
									end
									if note then
										u.n("Blacklist-Note:\n" .. note, 27)
									end
								end
								u.l("Blocked Player detected.")
								u.l("SCID:" .. scid)
								u.l("Current:" .. name)
								if name ~= blacklist.user[y][2] then
									u.l("Blacklisted:" .. blacklist.user[y][2])
								end
							end
						end
					end
				end
			end
			for key, value in pairs(blacklist.active) do
				if value < s.time() then
					blacklist.active[key] = nil
				end
			end
		end
		return u.stop(feat)
	end)
	features.t["Blacklist.Enable"].on = settings["Blacklist.Enable"]


	features.p["Blacklist.Actions"] = mf.p("Blacklist Actions", features.p["Blacklist"]).id

		features.t["Blacklist.AutoMark"] = mf.t("Automatically mark as a Modder", features.p["Blacklist.Actions"], function(feat)
			settings["Blacklist.AutoMark"] = feat.on
		end)
		features.t["Blacklist.AutoMark"].on = settings["Blacklist.AutoMark"]
		
		features.t["Blacklist.AutoKick"] = mf.t("Automatically kick", features.p["Blacklist.Actions"], function(feat)
			settings["Blacklist.AutoKick"] = features.t["Blacklist.AutoKick"].on
		end)
		features.t["Blacklist.AutoKick"].on = settings["Blacklist.AutoKick"]


	features.p["Blacklist.Notifys"] = mf.p("Blacklist Notifys", features.p["Blacklist"]).id

		features.t["Blacklist.NotifyNote"] = mf.t("Notify Note from Player", features.p["Blacklist.Notifys"], function(feat)
			settings["Blacklist.NotifyNote"] = features.t["Blacklist.NotifyNote"].on
		end)
		features.t["Blacklist.NotifyNote"].on = settings["Blacklist.NotifyNote"]

		features.t["Blacklist.NotifyNoteHideDefault"] = mf.t("Hide default Notes", features.p["Blacklist.Notifys"], function(feat)
			settings["Blacklist.NotifyNoteHideDefault"] = features.t["Blacklist.NotifyNoteHideDefault"].on
		end)
		features.t["Blacklist.NotifyNoteHideDefault"].on = settings["Blacklist.NotifyNoteHideDefault"]

		mf.a("Count currently Blacklisted-Players", features.p["Blacklist.Notifys"], function(feat)
			u.n("Currently Blacklisted-Players: " .. #blacklist.user)
		end)


	features.p["Blacklist.Modify"] = mf.p("Blacklist Modify", features.p["Blacklist"]).id

		mf.a("Add SCID", features.p["Blacklist.Modify"], function(feat)
			local scid = g.input("Enter SCID", 10, 3)
			if not scid then
				u.n("No valid SCID, aborting...")
				return
			end
			local name = g.input("Enter optional Name", 32, 0)
			if not name or name == "" then
				name = "DefaultName"
				u.n("No Name entered, using default Name.")
			end
			local note = g.input("Enter optional Note")
			if not note or note == "" then
				note = ";Optional Note."
				u.n("No Note entered, using default note.")
			end
			if blacklist.add(scid, name, note) then
				u.n("Added " .. scid .. ":" .. name .. " to Blacklist.cfg")
				u.l("Added " .. scid .. ":" .. name .. " to Blacklist.cfg")
				blacklist.update()
			end
		end)

		mf.a("Add Session", features.p["Blacklist.Modify"], function(feat)
			local entries = 0
			for i = 0, 31 do
				if s.valid(i) and i ~= s.id() then
					if (settings["ExcludeFriends"] and not player.is_player_friend(i)) or not settings["ExcludeFriends"] then
						local scid = g.scid(i)
						local name = g.name(i)
						if blacklist.add(scid, name, ";Added Session") then
							entries = entries + 1
							u.l("Added " .. scid .. ":" .. name .. " to Blacklist.cfg")
						end
					end
				end
			end
			u.n("Added " .. entries .. " new entries to Blacklist.cfg")
			blacklist.update()
		end)

		mf.a("Remove SCID", features.p["Blacklist.Modify"], function(feat)
			local scid = g.input("Enter SCID", 10, 3)
			if not scid then
				u.n("No valid SCID, aborting...")
				return
			end
			scid = s.tn(scid)
			if blacklist.remove({scid}) then
				u.n("Removed SCID:" .. scid .. " from Blacklist.cfg")
				blacklist.update()
			end
		end)

		mf.a("Remove Session", features.p["Blacklist.Modify"], function(feat)
			local entries = 0
			local scids = {}
			for i = 0, 31 do
				if s.valid(i) and i ~= s.id() then
					if (settings["ExcludeFriends"] and not player.is_player_friend(i)) or not settings["ExcludeFriends"] then
						scids[#scids + 1] = g.scid(i)
					end
				end
			end
			local respond, count = blacklist.remove(scids)
			if respond then
				u.n("Removed " .. count .. " entries from Blacklist.cfg")
				blacklist.update()
			end
		end)

		mf.a("Clear Blacklist", features.p["Blacklist.Modify"], function(feat)
			local X = s.random(-50, 50)
			local Y = s.random(-50, 50)
			local sum = X + Y
			local confirmation = g.input("For confirmation enter the sum of this operation: " .. X .. " + " .. Y, 4, 3)
			if confirmation then
				confirmation = s.tn(confirmation)
				if confirmation == sum then
					local _file = s.o(file.blacklist, "w")
					io.output(_file)
					io.close(_file)
					u.n("Cleared Blacklist.cfg with " .. #blacklist.user .. " entries.")
					blacklist.update()
				else
					u.n("Wrong sum, try again.")
				end
			else
				u.n("Aborted clearing Blacklist.")
			end
		end)

		features.p["Blacklist.Modify.Players"] = mf.p("Blacklisted Players", features.p["Blacklist.Modify"])

			mf.a("Refresh List", features.p["Blacklist.Modify.Players"].id, function(feat)
				while #features.p["Blacklist.Modify.Players"].children ~= 1 do
					while #features.p["Blacklist.Modify.Players"].children[2].children ~= 0 do
						menu.delete_feature(features.p["Blacklist.Modify.Players"].children[2].children[1].id)
					end
					menu.delete_feature(features.p["Blacklist.Modify.Players"].children[2].id)
				end
				for i = 1, #blacklist.user do
					local scid = blacklist.user[i][1]
					local name = blacklist.user[i][2]
					local note = blacklist.user[i][3]
					local temp = mf.p(scid .. ":" .. name, features.p["Blacklist.Modify.Players"].id).id

					mf.a("Copy SCID", temp, function(feat)
						s.copy(scid)
						u.n("Copied " .. scid .. " to clipboard.")
					end)

					mf.a("Copy Name", temp, function(feat)
						s.copy(name)
						u.n("Copied " .. name .. " to clipboard.")
					end)

					mf.a("Copy Note", temp, function(feat)
						s.copy(note)
						u.n("Copied " .. note .. " to clipboard.")
					end)

					mf.a("Notify Note", temp, function(feat)
						u.n("Blacklist-Note:\n" .. note)
					end)

					mf.a("Change Note", temp, function(feat)
						local newnote = g.input("Enter optional Note")
						if not newnote or newnote == "" then
							newnote = note
							u.n("No Note entered, using old note.")
						end
						if blacklist.remove({scid}) then
							blacklist.update()
							if blacklist.add(scid, name, newnote) then
								blacklist.update()
								u.n("Changed Note, refresh list.")
							else
								u.n("ERROR2")
							end
						else
							u.n("ERROR")
						end
					end)

					mf.a("Rename", temp, function(feat)
						local newname = g.input("Enter optional Name", 32, 0)
						if not newname or newname == "" then
							newname = name
							u.n("No Name entered, using old Name.")
						end
						if blacklist.remove({scid}) then
							blacklist.update()
							if blacklist.add(scid, newname, note) then
								blacklist.update()
								u.n("Changed Name, refresh list.")
							else
								u.n("ERROR2")
							end
						else
							u.n("ERROR")
						end
					end)

					mf.a("Remove", temp, function(feat)
						if blacklist.remove({scid}) then
							u.n("Removed SCID:" .. scid .. " from Blacklist.cfg")
							blacklist.update()
						end
					end)
				end
			end)
			

	features.p["Blacklist.Admin"] = mf.p("Rockstar related SCIDs", features.p["Blacklist"]).id

		features.t["Blacklist.Admin"] = mf.t("Notify by SCID", features.p["Blacklist.Admin"], function(feat)
			settings["Blacklist.Admin"] = feat.on
			if feat.on then
				s.wait(1000)
				for i = 0, 31 do
					if s.valid(i) then
						local scid = g.scid(i)
						for y = 1, #blacklist.admins do
							if scid == blacklist.admins[y][2] then
								if not blacklist.active2[scid] then
									blacklist.active2[scid] = s.time() + s.random(15000, 25000)
									local name = g.name(i)
									local msg = "Rockstar related \nSCID found:" .. scid .. "\nCurrent:" .. name
									if name ~= blacklist.admins[y][1] then
										msg = msg .. "\nName:" .. blacklist.admins[y][1]
									end
									u.n(msg, 27)
									if features.t["Blacklist.Admin.Kick"].on then
										-- kick player
									end
									local note = blacklist.admins[y][3]
									if note then
										u.n("Business:\n" .. note, 27)
									end
									u.l("Rockstar related Player detected.")
									u.l("SCID:" .. scid)
									u.l("Current:" .. name)
									if name ~= blacklist.admins[y][1] then
										u.l("nName:" .. blacklist.admins[y][1])
									end
								end
							end
						end
					end
				end
				for key, value in pairs(blacklist.active2) do
					if value < s.time() then
						blacklist.active2[key] = nil
					end
				end
			end
			return u.stop(feat)
		end)
		features.t["Blacklist.Admin"].on = settings["Blacklist.Admin"]

		features.t["Blacklist.Admin.Kick"] = mf.t("Automatically kick Admins", features.p["Blacklist.Admin"], function(feat)
			settings["Blacklist.Admin.Kick"] = feat.on
		end)
		features.t["Blacklist.Admin.Kick"].on = settings["Blacklist.Admin.Kick"]


	features.t["Blacklist.LockLobby"] = mf.t("Lock Lobby / Kick new Players", features.p["Blacklist"], function(feat)
		settings["Blacklist.LockLobby"] = feat.on
		if feat.on then
			s.wait(1000)
			if #blacklist.whitelisted < 1 then
				for i = 0, 31 do
					if s.valid(i) then
						blacklist.whitelisted[#blacklist.whitelisted + 1] = g.scid(i)
					end
				end
			end
			for i = 0, 31 do
				if s.valid(i) and i ~= s.id() then
					if (settings["ExcludeFriends"] and not player.is_player_friend(i)) or not settings["ExcludeFriends"] then
						local scid = g.scid(i)
						local kick = true
						for y = 1, #blacklist.whitelisted do
							if scid == blacklist.whitelisted[y] then
								kick = false
							end
						end
						if kick then
							if not blacklist.active3[scid] then
								blacklist.active3[scid] = s.time() + s.random(15000, 25000)
								-- kick player
								u.n(g.name(i) .. " just joined, kicking him from locked Session.")
							end
						end
					end
				end
			end
			for key, value in pairs(blacklist.active3) do
				if value < s.time() then
					blacklist.active3[key] = nil
				end
			end
		end
		if not feat.on then
			blacklist.whitelisted = {}
			blacklist.active3 = {}
		end
		return u.stop(feat)
	end)
	features.t["Blacklist.LockLobby"].on = settings["Blacklist.LockLobby"]
end

function setup.features.modder()
	features.p["Modder"] = mf.p("Modder", features.script).id

	modder.update()

	features.p["Modder.Database.Enable"] = mf.t("Enable Modder Database", features.p["Modder"], function(feat)
		settings["Modder.Database.Enable"] = feat.on
		if feat.on then
			s.wait(2500)
			for i = 0, 31 do
				if s.valid(i) then
					local scid = g.scid(i)
					-- apply old flags


					if s.is_modder(i, -1) then
						local found = false
						for y = 1, #modder.user do
							if scid == modder.user[y][1] then
								found = y
							end
						end
						local save = false
						if found then
							local current = modder.get_all_flags_from_player(i)
							local stored = modder.user[y][2]
							if #current ~= #stored then
								modder.user[y][2] = current
								save = true
							end
						else
							modder.add(scid, modder.get_all_flags_from_player(i))
						end
					end


				end
			end
		end
		return u.stop(feat)
	end)
	features.p["Modder.Database.Enable"].on = settings["Modder.Database.Enable"]

	features.p["Modder.IgnoringFlags"] = mf.p("Ignoring Flags", features.p["Modder"]).id

		for y = 0, 63 do
			local int = math.floor(math.pow(2, y))
			local tag = player.get_modder_flag_text(int)
			if tag == "" then
				break
			end
			local temp = mf.t(tag, features.p["Modder.IgnoringFlags"], function(feat)
				if settings["Modder.IgnoringFlags." .. tag] then
					settings["Modder.IgnoringFlags." .. tag] = feat.on
				end
			end)
			if settings["Modder.IgnoringFlags." .. tag] then
				temp.on = settings["Modder.IgnoringFlags." .. tag]
			end
		end
	

	features.p["Modder.AutokickFlags"] = mf.p("Autokick Flags", features.p["Modder"]).id

		features.t["Modder.AutokickFlags.Enable"] = mf.t("Autokick selected Flags", features.p["Modder.AutokickFlags"], function(feat)
			settings["Modder.AutokickFlags.Enable"] = feat.on
			if feat.on then

			end
		end)
		features.t["Modder.AutokickFlags.Enable"].on = settings["Modder.AutokickFlags.Enable"]

		features.t["Modder.AutokickFlags.Any"] = mf.t("Autokick any Flag", features.p["Modder.AutokickFlags"], function(feat)
			settings["Modder.AutokickFlags.Any"] = feat.on
		end)
		features.t["Modder.AutokickFlags.Any"].on = settings["Modder.AutokickFlags.Any"]

		for y = 0, 63 do
			local int = math.floor(math.pow(2, y))
			local tag = player.get_modder_flag_text(int)
			if tag == "" then
				break
			end
			local temp = mf.t(tag, features.p["Modder.AutokickFlags"], function(feat)
				settings["Modder.AutokickFlags." .. tag] = feat.on
			end)
			if settings["Modder.AutokickFlags." .. tag] then
				temp.on = settings["Modder.AutokickFlags." .. tag]
			end
		end

		features.t["Modder.AutokickFlags"] = mf.t("AutokickFlags", features.p["Modder.AutokickFlags"], function(feat)
			if feat.on then
				s.wait(1000)
				for i = 0, 31 do
					if s.valid(i) and i ~= s.id() then
						if (settings["ExcludeFriends"] and not player.is_player_friend(i)) or not settings["ExcludeFriends"] then
							if s.is_modder(i, -1) then
								for v = 0, 63 do
									local int = math.floor(math.pow(2, v))
									local tag = player.get_modder_flag_text(int)
									if tag == "" then
										break
									end
									if s.is_modder(i, int) and settings["Modder.AutokickFlags." .. tag] or settings["Modder.AutokickFlags.Any"] then
										if not modder.active2[g.scid(i)] then
											modder.active2[g.scid(i)] = s.time() + s.random(15000, 30000)
											u.n("Modder " .. g.name(i) .. " has AutokickFlags: " .. tag .. "\nSending Kick!")
											-- kick
										end
									end
								end
							end
						end
					end
				end
				for key, value in pairs(modder.active2) do
					if value < s.time() then
						modder.active2[key] = nil
					end
				end
			end
			return u.stop(feat)
		end)
		features.t["Modder.AutokickFlags"].on = true
		features.t["Modder.AutokickFlags"].hidden = true


	features.p["Modder.ModifyDB"] = mf.p("Modify DB", features.p["Modder"]).id
		--		234234={"kfejf", "sfdkvmsrv"}

	features.p["Modder.AutoUnMark"] = mf.p("(Auto) un-/mark Modder", features.p["Modder"]).id

		features.t["Modder.AutoUnMark.IgnoringFlags"] = mf.t("Auto unmark ignoring Flags", features.p["Modder.AutoUnMark"], function(feat)
			settings["Modder.AutoMarkUnMark.IgnoringFlags"] = feat.on
		end)
		features.t["Modder.AutoUnMark.IgnoringFlags"] = settings["Modder.AutoUnMark.IgnoringFlags"]

		mf.a("Mark all", features.p["Modder.AutoUnMark"], function(feat)
			for i = 0, 31 do
				if s.valid(i) and i ~= s.id() then
					if (settings["ExcludeFriends"] and not player.is_player_friend(i)) or not settings["ExcludeFriends"] then
						s.set_modder(i, 1)
					end
				end
			end
		end)

		mf.a("Unmark all", features.p["Modder.AutoUnMark"], function(feat)
			for i = 0, 31 do
				if s.valid(i) and i ~= s.id() then
					if (settings["ExcludeFriends"] and not player.is_player_friend(i)) or not settings["ExcludeFriends"] then
						player.unset_player_as_modder(i, -1)
					end
				end
			end
		end)


	features.p["Modder.Detections"] = mf.p("Modder Detections", features.p["Modder"]).id

		features.t["Modder.Detections.SCID Spoof"] = mf.t("SCID Spoof", features.p["Modder.Detections"], function(feat)
			settings["Modder.Detections.SCID Spoof"] = feat.on
			if feat.on then
				s.wait(1000)
				for i = 0, 31 do
					if s.valid(i) and i ~= s.id() then
						if (settings["ExcludeFriends"] and not player.is_player_friend(i)) or not settings["ExcludeFriends"] then
							local scid = g.scid(i)
							if not s.is_modder(i, modder_flags["SCID Spoof"][2]) and scid ~= -1 and (scid < 10000 or scid > 214748364) then
								u.l(g.name(i) .. " is spoofing the SCID to " .. scid .. "!")
								u.l("Marking Player as a Modder.")
								u.n(g.name(i) .. " is spoofing the SCID to " .. scid .. "!")
								s.set_modder(i, modder_flags["SCID Spoof"][2])
							end
						end
					end
				end
			end
		end)
		features.t["Modder.Detections.SCID Spoof"].on = settings["Modder.Detections.SCID Spoof"]

		features.t["Modder.Detections.Name Spoof"] = mf.t("Name Spoof", features.p["Modder.Detections"], function(feat)
			settings["Modder.Detections.Name Spoof"] = feat.on
			if feat.on then
				s.wait(1000)
				for i = 0, 31 do
					if s.valid(i) and i ~= s.id() then
						if (settings["ExcludeFriends"] and not player.is_player_friend(i)) or not settings["ExcludeFriends"] then
							local name = g.name(i)
							local bool1 = not s.is_modder(i, modder_flags["Name Spoof"][2])
							local bool2 = not string.find(name, "^[%.%-%w_]+$")
							local bool3 = string.len(name) < 6
							local bool4 = string.len(name) > 16
							local bool5 = false
							if settings["Modder.Detections.IncludeDot"] then
								bool5 = string.find(name, "%.")
							end
							if bool1 and (bool2 or bool3 or bool4 or bool5) then
								u.n(name .. " is spoofing its Name!")
								u.l(name .. " is spoofing its Name!")
								u.l("Marking Player as a Modder.")
								s.set_modder(i, modder_flags["Name Spoof"][2])
							end
						end
					end
				end
			end
		end)
		features.t["Modder.Detections.Name Spoof"].on = settings["Modder.Detections.Name Spoof"]

		features.t["Modder.Detections.IncludeDot"] = mf.t("Include Dot (.) in Name Spoof", features.p["Modder.Detections"], function(feat)
			settings["Modder.Detections.IncludeDot"] = feat.on
		end)
		features.t["Modder.Detections.IncludeDot"].on = settings["Modder.Detections.IncludeDot"]

		features.t["Modder.Detections.Invalid Script Event"] = mf.t("Invalid Script Event", features.p["Modder.Detections"], function(feat)
			settings["Modder.Detections.Invalid Script Event"] = feat.on
			if not events.scripts[1] and feat.on then
				events.scripts[1] = hook.register_script_event_hook(function(source, target, parameter, count)
					if s.valid(source) and source ~= s.id() then
						if (settings["ExcludeFriends"] and not player.is_player_friend(source)) or not settings["ExcludeFriends"] then
							local bool1 = #parameter == 1
							local bool2 = source ~= parameter[2]
							local bool3 = #parameter > 40
							if not s.is_modder(i, modder_flags["Invalid Script Event"][2]) and (bool1 or bool2 or bool3) then
								u.l(g.name(i) .. " is sending a Invalid Script Event!")
								local event = parameter[1] .. ", {"
								for i = 2, #parameter do
									event = event .. parameter[i]
									if i ~= #parameter then
										event = event .. ", "
									end
								end
								event = event .. "}"
								u.l(event)
								u.l("Marking Player as a Modder.")
								u.n(g.name(i) .. " is sending a Invalid Script Event!")
								s.set_modder(i, modder_flags["Invalid Script Event"][2])
							end
							return false
						end
					end
				end)
			end
			if not feat.on and events.scripts[1] then
				hook.remove_script_event_hook(events.scripts[1])
				events.scripts[1] = nil
			end
		end)
		features.t["Modder.Detections.Invalid Script Event"].on = settings["Modder.Detections.Invalid Script Event"]

	features.t["Modder.KarmaScriptsfromModders"] = mf.t("Karma Scripts from Modders", features.p["Modder"], function(feat)
		if not events.scripts[2] and feat.on then
			events.scripts[2] = hook.register_script_event_hook(function(source, target, parameter, count)
				if s.is_modder(source, -1) then
					local event = parameter[1]
					table.remove(parameter, 1)
					s.script(event, source, parameter)
				end
				return false
			end)
		end
		if not feat.on and events.scripts[2] then
			hook.remove_script_event_hook(events.scripts[2])
			events.scripts[2] = nil
		end
		settings["Modder.KarmaScriptsfromModders"] = feat.on
	end)
	features.t["Modder.KarmaScriptsfromModders"].on = settings["Modder.KarmaScriptsfromModders"]









	--	- Enable DB
--
	--	- Modify
--	       Add scid -> add tags
--		   add session
--		   remove scid
--		   remove session
--		   list all players
--

-- Autokick selected Flags
	--	- Modder detections
	--		- Modded SCID X
	--		- Modded Name X
	--		- Modded Net Events
	--		- Modded Script Events X
	--		- Max-Speed-Bypass
	--		- Suspicious Stuff
	--			(health, armor, vehiclegod etc)


end

function setup.features.options()
	features.p["Options"] = mf.p("Options", features.script).id
	features.t["Blacklist.Features.Enabled"] = mf.t("Enable Blacklist.Features", features.p["Options"], function(feat)
		settings["Blacklist.Features.Enabled"] = feat.on
	end)
	features.t["Blacklist.Features.Enabled"].on = settings["Blacklist.Features.Enabled"]
	features.t["Modder.Features.Enabled"] = mf.t("Enable Modder.Features", features.p["Options"], function(feat)
		settings["Modder.Features.Enabled"] = feat.on
	end)
	features.t["Modder.Features.Enabled"].on = settings["Modder.Features.Enabled"]
end

function setup.features.load()
	if settings["ScriptParent"] then
		features.script = mf.p("2Take1Script", 0).id
	end
	if settings["Blacklist.Features.Enabled"] then
		setup.features.blacklist()
	end
	if settings["Modder.Features.Enabled"] then
		setup.features.modder()
	end
	setup.features.options()
end

setup.features.load()

--[[

karma needs testing
scid spoofing needs testing
name spoof + dot needs testing
invalid script event detection needs testing
update ModderDB








## Changelog

- Rewrite
  -\> Fixed spam from blocking a Player
  -\> Added Timeout after kicking a Player to prevent spam
  -\> Changed Layout
- Added `Add Session` -\> `Blacklist Modify`
- Added `Remove Session` -\> `Blacklist Modify`
- Added `Clear Blacklist` -\> `Blacklist Modify`
- List all Players in a Submenu (Blacklist Modify)
  - Copy SCID
  - Copy NAME
  - Copy Note
  - Notify Note
  - Change Note
  - Rename
  - Remove
- Removed `Auto Crash Admin`
- Made Feature `Automatically kick Admins` visible by default
- Added `Ignoring Flags` for Modder DB
- Added `Autokick Flags`
- Added `Autokick any Flag`
- Added `Auto unmark ignoring Flags`







-- KICK PLAYER function



REWRITE / 2Take1Script:
X	- Blacklist
X		- Enable SCID-Blacklist
X		- Blacklist Actions
X			- Automatically mark as a Modder
X			- Automatically kick
X		- Blacklist Notifys
X			- Notify Note from Player
X			- Hide default Notes
X			- Count currently Blacklisted-Players
X		- Modify Blacklist
X			- Add SCID
X			- Add Session
X			- Remove SCID
X			- Remove Session
X			- Clear Blacklist
X			- Blacklisted Players
X				- Refresh List
X				- Player X (SCID:NAME)
X					- Copy SCID
X					- Copy NAME
X					- Copy Note
X					- Notify Note
X					- Change Note
X					- Rename
X					- Remove
X		- Rockstar related SCIDs
X			- Notify by SCID
X			- Automatically kick Admins
X		- Lock Lobby / Kick new Players
	- Modder
.		- Enable Modder-Database
X		- Ignoring Flags
X			- List all Flags
X		- Auto kick Flags
X			- Autokick any Flag
X			- List all Flags
.		- Modify Database
			- Add SCID
			- Remove SCID
			- Clear Database
			- Listed Players
				- Player Y (SCID:NAME)
					- Show Modder Flags
					- Add Modder Flag
					- Remove Modder Flag
					- Remove from DB
X		- Auto mark-/unmark Modder
X			- Auto unmark ignoring flags
X			- Mark all
X			- Unmark all
		- Modder detections
X			- Modded SCID
X			- Modded Name
X			- Modded Script Events
			- Modded Net Events
			- Max-Speed-Bypass
			- Suspicious Stuff
				(health, armor, vehiclegod etc)
X		- Karma Scripts from Modders



optional, include dot for name spoof


		prof bypass
		"reich"
		"fuck"
		





--if s.valid(i) then
--	if (include or i ~= s.id()) and g.scid(i) ~= -1 then
--		if include or (settings["exclude_friends"] and not player.is_player_friend(i) or not settings["exclude_friends"]) then
--			return true
--		end
--	end
--end

]]



