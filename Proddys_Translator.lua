local ScriptName = "Proddy's Translator"
local Version = "1.7.3"

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
Settings.TranslateMethod = "Google1"

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

local basePrint = print
local function print(...)
	basePrint(...)
	local success, result = pcall(function(...)
		local args = {...}
		if #args == 0 then
			return
		end
		
		local currTime = os.date("*t")
		local file = io.open(Paths.LogFile, "a")
		
		for i=1,#args do
			file:write(string.format("[%02d-%02d-%02d %02d:%02d:%02d] <%s> %s\n", currTime.year, currTime.month, currTime.day, currTime.hour, currTime.min, currTime.sec, Version, tostring(args[i])))
		end
		
		file:close()
	end, ...)
	if not success then
		basePrint("Error writing log: " .. result)
	end
end

local notif = menu.notify
local function notify(message, title, seconds, colour)
	title = title or (ScriptName .. " v" .. Version)
	seconds = seconds or 10
	colour = colour or 0xFF0000FF
	notif(message, title, seconds, colour)
	print(string.format("[%s] %s > %s", ScriptName .. " v" .. Version, title, message))
end

local EscapeChars = {
	["\\"] = "\\",
	["r"] = "\r",
	["n"] = "\n",
	["t"] = "\t",
}
local function ProcessEscapeChar(char)
	return EscapeChars[char] or char
end

local function ProcessEscapeCode(code)
	return string.char(tonumber(code, 16))
end

local function GoogleTranslate1(encodedText, targetLang)
	print("Translating with Google1")
	
	local statusCode, body = web.get("https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" .. targetLang .. "&dt=t&dj=1&source=input&q=" .. encodedText)
	
	if statusCode ~= 200 then
		return false, body
	end
	
	local sentences, sourceLang = body:match('{"sentences":(%b[]),"src":"(.-)"')
	
	if sentences == nil then
		return false, body
	end
	
	local translationTbl = {}
	for sentence in sentences:gmatch('{"trans":"(.-)","orig"') do
		translationTbl[#translationTbl + 1] = sentence
	end
	
	local translation = table.concat(translationTbl)
	translation = translation:gsub("\\u([a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9])", ProcessEscapeCode)
	translation = translation:gsub("\\(.)", ProcessEscapeChar)
	
	return true, translation, sourceLang
end

local function GoogleTranslate2(encodedText, targetLang)
	print("Translating with Google2")
	
	local statusCode, body = web.get("https://clients5.google.com/translate_a/t?client=dict-chrome-ex&sl=auto&tl="..targetLang.."&q="..encodedText)
	
	if statusCode ~= 200 then
		return false, body
	end
	
	local translation, sourceLang = body:match('^%[%["(.-)","(.-)"%]%]')
	
	if translation == nil then
		return false, body
	end
	
	translation = translation:gsub("\\u([a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9])", ProcessEscapeCode)
	translation = translation:gsub("\\(.)", ProcessEscapeChar)
	
	return true, translation, sourceLang
end

local function DeepLUsage(isFree, key)
	local statusCode, body = web.get("https://" .. (isFree and "api-free" or "api") .. ".deepl.com/v2/usage?auth_key=" .. web.urlencode(Settings.DeepLFreeKey))
	
	if statusCode ~= 200 then
		if statusCode == 429 or statusCode == 456 then
			return false, "Daily Request Limit reached."
		end
		if statusCode == 403 then
			return false, "API Key invalid."
		end
		return false, body
	end
	
	local used, limit = body:match('^{"character_count":(%d+),"character_limit":(%d+)}$')
	if not used or not limit then
		return false, "Unknown API response.\n" .. body
	end
	
	used = tonumber(used)
	limit = tonumber(limit)
	
	return true, (used / limit) * 100
end

local DeepLLanguages = {["bg"] = true,["cs"] = true,["da"] = true,["de"] = true,["en"] = true,["el"] = true,["es"] = true,["et"] = true,["fi"] = true,["fr"] = true,["hu"] = true,["it"] = true,["ja"] = true,["lt"] = true,["lv"] = true,["nl"] = true,["pl"] = true,["pt"] = true,["ro"] = true,["ru"] = true,["sk"] = true,["sl"] = true,["sv"] = true,["zh"] = true}

local function DeepLTranslate(isFree, key, encodedText, targetLang)
	if targetLang == "zh-CN" then
		targetLang = "zh"
	elseif not DeepLLanguages[targetLang] then
		print(targetLang)
		notify("The DeepL Translation Engine does not support the chosen language: " .. (LangLookupByKey[targetLang] or targetLang))
		return false, "Language not supported"
	end
	
	local statusCode, body = web.get("https://" .. (isFree and "api-free" or "api") .. ".deepl.com/v2/translate?auth_key=" .. web.urlencode(Settings.DeepLFreeKey) .. "&target_lang=" .. targetLang .. "&text=" .. encodedText)
	
	if statusCode ~= 200 then
		if statusCode == 429 or statusCode == 456 then
			return false, "Daily Request Limit reached."
		end
		if statusCode == 403 then
			return false, "API Key invalid."
		end
		return false, body
	end
	
	local translations = body:match('{"translations":(%b[])')
	
	if translations == nil then
		return false, body
	end
	
	local sourceLang
	
	local translationTbl = {}
	for lang, text in translations:gmatch('{"detected_source_language":"(.-)","text":"(.-)"}') do
		sourceLang = lang
		translationTbl[#translationTbl + 1] = text
	end
	
	local translation = table.concat(translationTbl)
	translation = translation:gsub("\\u([a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9])", ProcessEscapeCode)
	translation = translation:gsub("\\(.)", ProcessEscapeChar)
	
	sourceLang = sourceLang:lower()
	if sourceLang == "zh" then
		sourceLang = "zh-CN"
	end
	
	return true, translation, sourceLang
end
local function DeepLFreeTranslate(encodedText, targetLang)
	print("Translating with DeepL Free")
	
	if not Settings.DeepLFreeKey or Settings.DeepLFreeKey:len() == 0 then
		return false, "No key saved in settings"
	end
	
	return DeepLTranslate(true, Settings.DeepLFreeKey, encodedText, targetLang)
end

local function DeepLProTranslate(encodedText, targetLang)
	print("Translating with DeepL Pro")
	
	if not Settings.DeepLProKey or Settings.DeepLProKey:len() == 0 then
		return false, "No key saved in settings"
	end
	
	return DeepLTranslate(false, Settings.DeepLProKey, encodedText, targetLang)
end

local TranslateMethods = {
	["Google1"] = GoogleTranslate1,
	["Google2"] = GoogleTranslate2,
	["DeepLFree"] = DeepLFreeTranslate,
	["DeepLPro"] = DeepLProTranslate,
}

local TranslateMethodKeys = {}
for k in pairs(TranslateMethods) do
	TranslateMethodKeys[#TranslateMethodKeys + 1] = k
end
table.sort(TranslateMethodKeys)

local TranslateMethodIndexes = {}
for i=1,#TranslateMethodKeys do
	TranslateMethodIndexes[TranslateMethodKeys[i]] = i
end

local function Translate(text, targetLang)
	local encoded = web.urlencode(text)
	if targetLang then
		targetLang = web.urlencode(targetLang)
	else
		targetLang = "en"
	end
	
	return (TranslateMethods[Settings.TranslateMethod] or GoogleTranslate1)(encoded, targetLang)
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
	print("Set EnableTranslation to: " .. tostring(Settings.EnableTranslation))
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

local EngineParentId = menu.add_feature("Translation Engine", "parent", ParentId).id

local EngineFeat = menu.add_feature("Translation Engine", "autoaction_value_str", EngineParentId, function(f)
	Settings.TranslateMethod = TranslateMethodKeys[f.value + 1]
	print("Set TranslateMethod to: " .. Settings.TranslateMethod)
end)
EngineFeat:set_str_data(TranslateMethodKeys)
EngineFeat.value = TranslateMethodIndexes[Settings.TranslateMethod] - 1

local DeepLFreeKeyFeat = menu.add_feature("Set DeepL Free Key", "action", EngineParentId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter DeepL Free Key", Settings.DeepLFreeKey or "", 39, 0)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	
	local key = s:match("^[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]%-[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]%-[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]%-[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]%-[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]:fx$")
	if not key then
		notify("The entered key doesn't match the DeepL key format:\nxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx")
		return
	end
	
	Settings.DeepLFreeKey = key
	print("Set DeepL Free Key to: " .. Settings.DeepLFreeKey)
end)

local DeepLProKeyFeat = menu.add_feature("Set DeepL Pro Key", "action", EngineParentId, function(f)
	local r, s
	repeat
		r, s = input.get("Enter DeepL Pro Key", Settings.DeepLProKey or "", 39, 0)
		if r == 2 then return HANDLER_POP end
		system.wait(0)
	until r == 0
	
	local key = s:match("^[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]%-[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]%-[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]%-[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]%-[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]:fx$")
	if not key then
		notify("The entered key doesn't match the DeepL key format:\nxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:fx")
		return
	end
	
	Settings.DeepLProKey = key
	print("Set DeepL Pro Key to: " .. Settings.DeepLProKey)
end)

menu.add_feature("Check DeepL Free Key Usage", "action", EngineParentId, function(f)
	if not Settings.DeepLFreeKey or Settings.DeepLFreeKey:len() == 0 then
		notify("Failed to get DeepL Free usage: No key set")
		return
	end
	
	local success, usage = DeepLUsage(true, Settings.DeepLFreeKey)
	if success then
		notify(string.format("DeepL Free usage: %.3f%%", usage), nil, nil, 0xFF00FF00)
	else
		notify("Failed to get DeepL Free usage: " .. usage)
	end
end)

menu.add_feature("Check DeepL Pro Key Usage", "action", EngineParentId, function(f)
	if not Settings.DeepLProKey or Settings.DeepLProKey:len() == 0 then
		notify("Failed to get DeepL Pro usage: No key set")
		return
	end
	
	local success, usage = DeepLUsage(false, Settings.DeepLProKey)
	if success then
		notify(string.format("DeepL Pro usage: %.3f%%", usage), nil, nil, 0xFF00FF00)
	else
		notify("Failed to get DeepL Pro usage: " .. usage)
	end
end)

local TargetLangFeat = menu.add_feature("Target Language", "autoaction_value_str", ParentId, function(f)
	Settings.TargetLang = LangLookupByName[LangKeys[f.value + 1]]
	print("Set TargetLang to: " .. Settings.TargetLang)
end)
TargetLangFeat:set_str_data(LangKeys)
TargetLangFeat.value = LangIndexes[Settings.TargetLang] - 1

local TranslateSelfFeat = menu.add_feature("Translate Self", "toggle", ParentId, function(f)
	Settings.TranslateSelf = f.on
	print("Set TranslateSelf to: " .. tostring(Settings.TranslateSelf))
end)
TranslateSelfFeat.on = Settings.TranslateSelf

local ExcludedParentId = menu.add_feature("Excluded Languages", "parent", ParentId).id
local SendOptionsId = menu.add_feature("Send X Message Options", "parent", ParentId).id

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

local ShowSend = {}

local function ExcludeLanguage(f)
	if f.on then
		ExcludedLanguages[f.data] = true
	else
		ExcludedLanguages[f.data] = nil
	end
end

local function SetSendLanguage(f)
	if f.on then
		Settings["ShowSend_" .. f.data] = true
		ShowSend[f.data].hidden = false
	else
		Settings["ShowSend_" .. f.data] = nil
		ShowSend[f.data].hidden = true
	end
end

local function SendLanguage(f)
	local TargetLang = f.data
	
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
end

for i=1,#Languages do
	local language = Languages[i]
	
	local excludeFeat = menu.add_feature(language.Name, "toggle", ExcludedParentId, ExcludeLanguage)
	excludeFeat.data = language.Key
	if ExcludedLanguages[language.Key] then
		excludeFeat.on = true
	end
	
	local showFeat = menu.add_feature(language.Name, "toggle", SendOptionsId, SetSendLanguage)
	showFeat.data = language.Key
	if Settings["ShowSend_" .. language.Key] then
		showFeat.on = true
	end
	
	local sendFeat = menu.add_feature("Send " .. language.Name .. " Message", "action", ParentId, SendLanguage)
	sendFeat.data = language.Key
	if not Settings["ShowSend_" .. language.Key] then
		sendFeat.hidden = true
	end
	sendFeat.data = language.Key
	ShowSend[language.Key] = sendFeat
end