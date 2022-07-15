function MoistsSpam()
local rootPath = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
utils.make_dir(rootPath .. "\\scripts\\MoistsLUA_cfg")
local Spam_Data = rootPath .. "\\scripts\\MoistsLUA_cfg\\Moists_Spamset.data"


local MoistSpam = menu.add_feature("Moists Spam Script", "parent", 0)


local player_sms = menu.add_player_feature("Moists Spam Script", "parent", 0)

local Presetsms = menu.add_player_feature("SMS Spam Preset", "parent", player_sms.id)

local PresetChat = menu.add_feature("Chat Spam Presets", "parent", MoistSpam.id)

local sms_text

local presets = {
{"Love Me", "Love Me"},
{"Eat Dick", "EAT D I C K  !"},
{"Suck Cum Drip Cunt MassSpam", "Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !Suck My Cum Dripping C U N T !"},
{"FAGGOT", "F A G G O T"},
{"Cry", "CRY"},
{"Suck", "SUCK"},
{"You Suck MassSpam", "YOU SUCK \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n "},
{"Insert Space", " "},
}


function SpamData()
	if not utils.file_exists(Spam_Data) then	return end
for line in io.lines(Spam_Data) do
    presets[#presets + 1] = {line:sub(1,8),line}
end	

end
SpamData()

for i = 1, #presets do
	menu.add_player_feature("sms: " .. presets[i][1], "toggle", Presetsms.id, function(feat, pid)
		if feat.on then
	local text = tostring(presets[i][2])
		
		player.send_player_sms(pid, text)
		
		
	return HANDLER_CONTINUE
		end
end)
end


for i = 1, #presets do
	menu.add_feature("Chat: " .. presets[i][1], "toggle", PresetChat.id, function(feat)
		if feat.on then
	local text = tostring(presets[i][2])
		
		network.send_chat_message(text, false)
		system.wait(0)
	return HANDLER_CONTINUE
		end
	end)

end

menu.add_feature("no text spam", "toggle", MoistSpam.id, function(feat)
		if feat.on then
		network.send_chat_message(" ", false)

	return HANDLER_CONTINUE
		end
	end)


menu.add_player_feature("sms spam", "toggle",  player_sms.id, function(feat, pid)
if feat.on then
player.send_player_sms(pid, "Suck My Cum Dripping CUNT! Suck My Cum Dripping CUNT!")
end
return HANDLER_CONTINUE
end)

menu.add_player_feature("sms spam", "toggle", player_sms.id, function(feat, pid)
if feat.on then
player.send_player_sms(pid, "Suck My Cum Dripping CUNT! Suck My Cum Dripping CUNT!")
end
return HANDLER_CONTINUE
end)

menu.add_player_feature("sms spam from Clipboard", "toggle", player_sms.id, function(feat, pid)
sms_text = utils.from_clipboard()
if feat.on then
player.send_player_sms(pid, sms_text)
end
return HANDLER_CONTINUE
end)

end
MoistsSpam()