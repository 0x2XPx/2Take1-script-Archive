bannerList = {}

local function loadBanners()
    local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
    bannerList = utils.get_all_files_in_directory(appdata.."scripts\\Rimuru\\UI\\Banners", "png")
end
loadBanners()

local bannerSprite
local function registerBanner(pathToBanner)
    if pathToBanner ~= nil then
		local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
        bannerSprite = scriptdraw.register_sprite(appdata..pathToBanner)
    end
end

-- Settings 

local settingOpt = func.add_feature("Settings", "parent", 0)

func.add_feature("Save Settings", "action", settingOpt.id, function()
	
	local ini = require("Rimuru\\libs\\ini_parser")
    local cfg = ini.parse "Rimuru\\menuSettings.ini"
	
	if cfg then
		cfg.Position.xPosition = stuff.menuData.x
		cfg.Position.yPosition = stuff.menuData.y
		cfg.Position.maxOptions = stuff.menuData.maxOptions
		
		cfg.states.typing = playerStates.typing
		cfg.states.vip = playerStates.vip
		cfg.states.paused = playerStates.paused

		cfg.mainColour.Red = stuff.menuData.mainColour.r
		cfg.mainColour.Green = stuff.menuData.mainColour.g
		cfg.mainColour.Blue = stuff.menuData.mainColour.b
		
		cfg.backColour.Red = stuff.menuData.backColour.r
		cfg.backColour.Green = stuff.menuData.backColour.g
		cfg.backColour.Blue = stuff.menuData.backColour.b
		cfg.backColour.Alpha = stuff.menuData.backColour.a

		cfg.toggledOptions.embedScripts = menuSaveToggles.embedScripts
		cfg.toggledOptions.controllerSupport = menuSaveToggles.controllerSupport
		cfg.save()
		func.notification("Settings Saved")
	else
		func.notification("menuSettings.ini Could Not Be Found")
	end
end)

local xfun = func.add_feature("X Position", "autoaction_value_f", settingOpt.id, function(feat)
	stuff.menuData.x = feat.value
end)
xfun.max = 1
xfun.min = 0
xfun.mod = 0.002
xfun.value = stuff.menuData.x

local yfun = func.add_feature("Y Position", "autoaction_value_f", settingOpt.id, function(feat)
	stuff.menuData.y = feat.value
end)
yfun.max = 1
yfun.min = 0
yfun.mod = 0.002
yfun.value = stuff.menuData.y

local controller = func.add_feature("Controller Support", "toggle", settingOpt.id, function(feat)
	menuSaveToggles.controllerSupport = feat.on
end)
controller.on = menuSaveToggles.controllerSupport

local embed = func.add_feature("Embed Scripts", "toggle", settingOpt.id, function(feat)
	menuSaveToggles.embedScripts = feat.on
end)
embed.on = menuSaveToggles.embedScripts

local MaxOptions = func.add_feature("Max Options", "autoaction_value_i", settingOpt.id, function(feat)
	stuff.menuData.maxOptions = feat.value
end)
MaxOptions.max = 100
MaxOptions.min = 6
MaxOptions.mod = 1
MaxOptions.value = stuff.menuData.maxOptions

local menuUISub = func.add_feature("Menu UI", "parent", settingOpt.id) 
local coloursPrim = func.add_feature("Primary Colour", "parent", menuUISub.id) 
local coloursSec = func.add_feature("Background Colour", "parent", menuUISub.id) 

local redV = func.add_feature("Pimary Red", "autoaction_value_i", coloursPrim.id, function(feat)
	stuff.menuData.mainColour.r = feat.value
end)
redV.max = 255
redV.min = 0
redV.mod = 1
redV.value = stuff.menuData.mainColour.r

local greenV = func.add_feature("Primary Green", "autoaction_value_i", coloursPrim.id, function(feat)
	stuff.menuData.mainColour.g = feat.value
end)
greenV.max = 255
greenV.min = 0
greenV.mod = 1
greenV.value = stuff.menuData.mainColour.g

local blueV = func.add_feature("Primary Blue", "autoaction_value_i", coloursPrim.id, function(feat)
	stuff.menuData.mainColour.b = feat.value
end)	
blueV.max = 255
blueV.min = 0
blueV.mod = 1
blueV.value = stuff.menuData.mainColour.b

func.add_feature("RGB", "toggle", menuUISub.id, function(tog)
	while tog.on do
		stuff.menuData.mainColour.r = stuff.menuData.fadeColour.r
		stuff.menuData.mainColour.g = stuff.menuData.fadeColour.g
		stuff.menuData.mainColour.b = stuff.menuData.fadeColour.b
		system.wait(0)
	end
end)


local redV = func.add_feature("Background Red", "autoaction_value_i", coloursSec.id, function(feat)
	stuff.menuData.backColour.r = feat.value
end)
redV.max = 255
redV.min = 0
redV.mod = 1
redV.value = stuff.menuData.backColour.r

local greenV = func.add_feature("Background Green", "autoaction_value_i", coloursSec.id, function(feat)
	stuff.menuData.backColour.g = feat.value
end)
greenV.max = 255
greenV.min = 0
greenV.mod = 1
greenV.value = stuff.menuData.backColour.g

local blueV = func.add_feature("Background Blue", "autoaction_value_i", coloursSec.id, function(feat)
	stuff.menuData.backColour.b = feat.value
end)	
blueV.max = 255
blueV.min = 0
blueV.mod = 1
blueV.value = stuff.menuData.backColour.b

local alphaV = func.add_feature("Background Alpha", "autoaction_value_i", coloursSec.id, function(feat)
	stuff.menuData.backColour.a = feat.value
end)	
alphaV.max = 255
alphaV.min = 0
alphaV.mod = 1
alphaV.value = stuff.menuData.backColour.a

if bannerList[1] ~= nil then --quick fix for now
	registerBanner("scripts\\Rimuru\\UI\\Banners\\" .. bannerList[1])
end

local headers = func.add_feature("Headers", "parent", menuUISub.id)

for i=1, #bannerList do
	func.add_feature(bannerList[i], "action", headers.id, function()
		registerBanner("scripts\\Rimuru\\UI\\Banners\\" .. bannerList[stuff.scroll])
	end)
end

func.add_feature("Save UI Profile", "action", menuUISub.id, function()
    local status, inputString = input.get("Give your profile a name", "", 100, 0)    
	local file = io.open(stuff.appdata.."\\scripts\\Rimuru\\UI\\"..inputString..".ini", "w")
	
	--main colour
	file:write("[mainColour]\n")
	file:write("red="..stuff.menuData.mainColour.r.."\n")
	file:write("green="..stuff.menuData.mainColour.g.."\n")
	file:write("blue="..stuff.menuData.mainColour.b.."\n")
	
	--background colour
	file:write("[backColour]\n")
	file:write("red="..stuff.menuData.backColour.r.."\n")
	file:write("green="..stuff.menuData.backColour.g.."\n")
	file:write("blue="..stuff.menuData.backColour.b)
	
	file:close()

	func.notification(inputString.." was saved")
end)

local themesSub = func.add_feature("UI Profiles", "parent", menuUISub.id)

func.add_feature("Refresh UI Profiles", "action", menuUISub.id, function()
	loadThemes(themesSub.id)
end)

loadThemes(themesSub.id)
 
local pStates = func.add_feature("Player States", "parent", settingOpt.id)

local typing = func.add_feature("Player Typing", "toggle", pStates.id, function(feat)
	playerStates.typing = feat.on
end)
typing.on = playerStates.typing

local paused = func.add_feature("Player Paused", "toggle", pStates.id, function(feat)
	playerStates.paused = feat.on
end)
paused.on = playerStates.paused

local vip = func.add_feature("Player Joined VIP", "toggle", pStates.id, function(feat)
	playerStates.vip = feat.on
end)
vip.on = playerStates.vip


--Header bullshit


function drawBanner(colour) --thanks ghost for math
	if bannerSprite ~= nil then
		--scriptdraw.draw_sprite(bannerSprite, v2(x*2-1, ((((h * graphics.get_screen_height()) / 2) - ((y- 0.5) * graphics.get_screen_height())) + ((scriptdraw.get_sprite_size(bannerSprite).y * (((2.56 * w) * (1000 / scriptdraw.get_sprite_size(bannerSprite).x)) / (2560 / graphics.get_screen_width()))) / 2)) / (graphics.get_screen_height() / 2)), 0.7, 0, colour)
		
		scriptdraw.draw_sprite(bannerSprite, v2(stuff.menuData.x * 2 - 1, ((((stuff.menuData.height * graphics.get_screen_height()) / 2) - ((stuff.menuData.y - 0.5) * graphics.get_screen_height())) + ((scriptdraw.get_sprite_size(bannerSprite).y * (((2.56 * stuff.menuData.width) * (1000 / scriptdraw.get_sprite_size(bannerSprite).x)) / (2560 / graphics.get_screen_width()))) / 2)) / (graphics.get_screen_height() / 2)), ((2.56 * stuff.menuData.width) * (1000 / scriptdraw.get_sprite_size(bannerSprite).x)) / (2560 / graphics.get_screen_width()), 0, colour)

	end
end
