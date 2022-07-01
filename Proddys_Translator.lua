local ScriptName = "Proddy's Translator"
local Version = "1.3"

if ProddysTranslator then
	menu.notify("Script already loaded", ScriptName, 10, 0xFF0000FF)
	return
end

if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_HTTP) then
	menu.notify("Script requires HTTP trusted flag", ScriptName, 10, 0xFF0000FF)
end

ProddysTranslator = true

local Languages = {
	{ Name = "Afrikaans", Key = "af" },
	{ Name = "Albanian", Key = "sq" },
	{ Name = "Amharic", Key = "am" },
	{ Name = "Arabic", Key = "ar" },
	{ Name = "Armenian", Key = "hy" },
	{ Name = "Assamese", Key = "as" },
	{ Name = "Aymara", Key = "ay" },
	{ Name = "Azerbaijani", Key = "az" },
	{ Name = "Bambara", Key = "bm" },
	{ Name = "Basque", Key = "eu" },
	{ Name = "Belarusian", Key = "be" },
	{ Name = "Bengali", Key = "bn" },
	{ Name = "Bhojpuri", Key = "bho" },
	{ Name = "Bosnian", Key = "bs" },
	{ Name = "Bulgarian", Key = "bg" },
	{ Name = "Catalan", Key = "ca" },
	{ Name = "Cebuano", Key = "ceb" },
	{ Name = "Chichewa", Key = "ny" },
	{ Name = "Chinese", Key = "zh-CN" },
	{ Name = "Corsican", Key = "co" },
	{ Name = "Croatian", Key = "hr" },
	{ Name = "Czech", Key = "cs" },
	{ Name = "Danish", Key = "da" },
	{ Name = "Dhivehi", Key = "dv" },
	{ Name = "Dogri", Key = "doi" },
	{ Name = "Dutch", Key = "nl" },
	{ Name = "English", Key = "en" },
	{ Name = "Esperanto", Key = "eo" },
	{ Name = "Estonian", Key = "et" },
	{ Name = "Ewe", Key = "ee" },
	{ Name = "Filipino", Key = "tl" },
	{ Name = "Finnish", Key = "fi" },
	{ Name = "French", Key = "fr" },
	{ Name = "Frisian", Key = "fy" },
	{ Name = "Galician", Key = "gl" },
	{ Name = "Georgian", Key = "ka" },
	{ Name = "German", Key = "de" },
	{ Name = "Greek", Key = "el" },
	{ Name = "Guarani", Key = "gn" },
	{ Name = "Gujarati", Key = "gu" },
	{ Name = "Haitian Creole", Key = "ht" },
	{ Name = "Hausa", Key = "ha" },
	{ Name = "Hawaiian", Key = "haw" },
	{ Name = "Hebrew", Key = "iw" },
	{ Name = "Hindi", Key = "hi" },
	{ Name = "Hmong", Key = "hmn" },
	{ Name = "Hungarian", Key = "hu" },
	{ Name = "Icelandic", Key = "is" },
	{ Name = "Igbo", Key = "ig" },
	{ Name = "Ilocano", Key = "ilo" },
	{ Name = "Indonesian", Key = "id" },
	{ Name = "Irish", Key = "ga" },
	{ Name = "Italian", Key = "it" },
	{ Name = "Japanese", Key = "ja" },
	{ Name = "Javanese", Key = "jw" },
	{ Name = "Kannada", Key = "kn" },
	{ Name = "Kazakh", Key = "kk" },
	{ Name = "Khmer", Key = "km" },
	{ Name = "Kinyarwanda", Key = "rw" },
	{ Name = "Konkani", Key = "gom" },
	{ Name = "Korean", Key = "ko" },
	{ Name = "Krio", Key = "kri" },
	{ Name = "Kurdish (Kurmanji)", Key = "ku" },
	{ Name = "Kurdish (Sorani)", Key = "ckb" },
	{ Name = "Kyrgyz", Key = "ky" },
	{ Name = "Lao", Key = "lo" },
	{ Name = "Latin", Key = "la" },
	{ Name = "Latvian", Key = "lv" },
	{ Name = "Lingala", Key = "ln" },
	{ Name = "Lithuanian", Key = "lt" },
	{ Name = "Luganda", Key = "lg" },
	{ Name = "Luxembourgish", Key = "lb" },
	{ Name = "Macedonian", Key = "mk" },
	{ Name = "Maithili", Key = "mai" },
	{ Name = "Malagasy", Key = "mg" },
	{ Name = "Malay", Key = "ms" },
	{ Name = "Malayalam", Key = "ml" },
	{ Name = "Maltese", Key = "mt" },
	{ Name = "Maori", Key = "mi" },
	{ Name = "Marathi", Key = "mr" },
	{ Name = "Meiteilon (Manipuri)", Key = "mni-Mtei" },
	{ Name = "Mizo", Key = "lus" },
	{ Name = "Mongolian", Key = "mn" },
	{ Name = "Myanmar (Burmese)", Key = "my" },
	{ Name = "Nepali", Key = "ne" },
	{ Name = "Norwegian", Key = "no" },
	{ Name = "Odia (Oriya)", Key = "or" },
	{ Name = "Oromo", Key = "om" },
	{ Name = "Pashto", Key = "ps" },
	{ Name = "Persian", Key = "fa" },
	{ Name = "Polish", Key = "pl" },
	{ Name = "Portuguese", Key = "pt" },
	{ Name = "Punjabi", Key = "pa" },
	{ Name = "Quechua", Key = "qu" },
	{ Name = "Romanian", Key = "ro" },
	{ Name = "Russian", Key = "ru" },
	{ Name = "Samoan", Key = "sm" },
	{ Name = "Sanskrit", Key = "sa" },
	{ Name = "Scots Gaelic", Key = "gd" },
	{ Name = "Sepedi", Key = "nso" },
	{ Name = "Serbian", Key = "sr" },
	{ Name = "Sesotho", Key = "st" },
	{ Name = "Shona", Key = "sn" },
	{ Name = "Sindhi", Key = "sd" },
	{ Name = "Sinhala", Key = "si" },
	{ Name = "Slovak", Key = "sk" },
	{ Name = "Slovenian", Key = "sl" },
	{ Name = "Somali", Key = "so" },
	{ Name = "Spanish", Key = "es" },
	{ Name = "Sundanese", Key = "su" },
	{ Name = "Swahili", Key = "sw" },
	{ Name = "Swedish", Key = "sv" },
	{ Name = "Tajik", Key = "tg" },
	{ Name = "Tamil", Key = "ta" },
	{ Name = "Tatar", Key = "tt" },
	{ Name = "Telugu", Key = "te" },
	{ Name = "Thai", Key = "th" },
	{ Name = "Tigrinya", Key = "ti" },
	{ Name = "Tsonga", Key = "ts" },
	{ Name = "Turkish", Key = "tr" },
	{ Name = "Turkmen", Key = "tk" },
	{ Name = "Twi", Key = "ak" },
	{ Name = "Ukrainian", Key = "uk" },
	{ Name = "Urdu", Key = "ur" },
	{ Name = "Uyghur", Key = "ug" },
	{ Name = "Uzbek", Key = "uz" },
	{ Name = "Vietnamese", Key = "vi" },
	{ Name = "Welsh", Key = "cy" },
	{ Name = "Xhosa", Key = "xh" },
	{ Name = "Yiddish", Key = "yi" },
	{ Name = "Yoruba", Key = "yo" },
	{ Name = "Zulu", Key = "zu" },
}

local LangKeys = {}
local LangIndexes = {}
local LangLookupByName = {}
local LangLookupByKey = {}

for i=1,#Languages do
	local Language = Languages[i]
	LangKeys[i] = Language.Name
	LangIndexes[Language.Key] = i
	LangLookupByName[Language.Name] = Language.Key
	LangLookupByKey[Language.Key] = Language.Name
end

table.sort(LangKeys)

local Settings = {}
Settings.EnableTranslation = true
Settings.TargetLang = "en"
Settings.TranslateSelf = true

local ExcludedLanguages = {}

local Paths = {}
Paths.Root = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
Paths.Cfg = Paths.Root .. "\\cfg"
Paths.LogFile = Paths.Root .. "\\" .. ScriptName .. ".log"
Paths.Scripts = Paths.Root .. "\\scripts"

local function SaveSettings(SettingsFile, SettingsTbl)
	assert(SettingsFile, "Nil passed for SettingsFile to SaveSettings")
	assert(SettingsTbl, "Nil passed for SettingsTbl to SaveSettings")
	local file = io.open(Paths.Cfg .. "\\" .. SettingsFile .. ".cfg", "w")
	local keys = {}
	for k in pairs(SettingsTbl) do
		keys[#keys + 1] = k
	end
	table.sort(keys)
	for i=1,#keys do
		file:write(tostring(keys[i]) .. "=" .. tostring(SettingsTbl[keys[i]]) .. "\n")
	end
	file:close()
end

local function LoadSettings(SettingsFile, SettingsTbl)
	assert(SettingsFile, "Nil passed for SettingsFile to LoadSettings")
	assert(SettingsTbl, "Nil passed for SettingsTbl to LoadSettings")
	SettingsFile = Paths.Cfg .. "\\" .. SettingsFile .. ".cfg"
	if not utils.file_exists(SettingsFile) then
		return false
	end
	for line in io.lines(SettingsFile) do
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
	return true
end

LoadSettings(ScriptName, Settings)
LoadSettings(ScriptName .. " Excluded Languages", ExcludedLanguages)

local notif = menu.notify
local function notify(message, title, seconds, colour)
	title = title or (ScriptName .. " v" .. Version)
	seconds = seconds or 10
	colour = colour or 0xFF0000FF
	notif(message, title, seconds, colour)
	print(string.format("[%s] %s > %s", ScriptName .. " v" .. Version, title, message))
end

local function Translate(text, targetLang)
	local encoded = web.urlencode(text)
	print(encoded)
	if targetLang then
		targetLang = web.urlencode(targetLang)
	else
		targetLang = "en"
	end
	
	local statusCode, body = web.get("https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" .. targetLang .. "&dt=t&q=" .. encoded)
	
	if statusCode ~= 200 then
		return false, body
	end
	
	local translation, original = body:match('^%[%[%["(.-)","(.-)"')
	local sourceLang = body:match('.+"(.-)"%]%]%]$')
	
	return true, translation, sourceLang
end

local function TranslateChat(event)
	local pid = event.sender
	if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_HTTP) then
		notify("Chat message not translated because HTTP Trusted Mode not enabled.", nil, nil, 0xFF0000FF)
		return
	end
	if (Settings.TranslateSelf or pid ~= player.player_id()) and player.is_player_valid(pid) then
		local name = player.get_player_name(pid)
		
		local success, translation, sourceLang = Translate(event.body, Settings.TargetLang)
		
		if not success then
			notify("Error translating. Check console.")
			print(translation)
			return
		end
		
		if sourceLang ~= Settings.TargetLang and not ExcludedLanguages[sourceLang] then
			notify(translation, name .. ": Translated from " .. (LangLookupByKey[sourceLang] or sourceLang), nil, 0xFFFFFF00)
		end
	end
end

local ParentId = menu.add_feature(ScriptName, "parent").id

local EnableTranslationFeat = menu.add_feature("Enable Translation", "toggle", ParentId, function(f)
	Settings.EnableTranslation = f.on
	notify("Set EnableTranslation to: " .. tostring(Settings.EnableTranslation), nil, nil, 0xFF00FF00)
	if f.on then
		if f.data then
			return
		end
		
		f.data = event.add_event_listener("chat", TranslateChat)
	else
		if not f.data then
			return
		end
		
		event.remove_event_listener("chat", f.data)
		f.data = nil
	end
end)
EnableTranslationFeat.on = Settings.EnableTranslation

local TargetLangFeat = menu.add_feature("Target Language", "autoaction_value_str", ParentId, function(f)
	Settings.TargetLang = LangLookupByName[LangKeys[f.value + 1]]
	print("Set TargetLang to: " .. Settings.TargetLang, nil, nil, 0xFF00FF00)
end)
TargetLangFeat:set_str_data(LangKeys)
TargetLangFeat.value = LangIndexes[Settings.TargetLang] - 1

local TranslateSelfFeat = menu.add_feature("Translate Self", "toggle", ParentId, function(f)
	Settings.TranslateSelf = f.on
	print("Set TranslateSelf to: " .. tostring(Settings.TranslateSelf), nil, nil, 0xFF00FF00)
end)
TranslateSelfFeat.on = Settings.TranslateSelf

local ExcludedParentId = menu.add_feature("Excluded Languages", "parent", ParentId).id

local function ExcludeLanguage(f)
	if f.on then
		ExcludedLanguages[f.data] = true
	else
		ExcludedLanguages[f.data] = nil
	end
end
for i=1,#Languages do
	local language = Languages[i]
	local feat = menu.add_feature(language.Name, "toggle", ExcludedParentId, ExcludeLanguage)
	feat.data = language.Key
	if ExcludedLanguages[language.Key] then
		feat.on = true
	end
end

menu.add_feature("Save Settings", "action", ParentId, function(f)
	SaveSettings(ScriptName, Settings)
	SaveSettings(ScriptName .. " Excluded Languages", ExcludedLanguages)
	notify("Settings Saved", nil, nil, 0xFF00FF00)
end)

menu.add_feature("Send Translated Message", "action_value_str", ParentId, function(f)
	local TargetLang = LangLookupByName[LangKeys[f.value + 1]]
	
	local r, s
	repeat
		r, s = input.get("Enter text to translate", "", 255, 0)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	
	local success, translation, sourceLang = Translate(s, TargetLang)
		
	if not success then
		notify("Error translating. Check console.")
		print(translation)
		return
	end
	
	network.send_chat_message(translation, false)
end):set_str_data(LangKeys)