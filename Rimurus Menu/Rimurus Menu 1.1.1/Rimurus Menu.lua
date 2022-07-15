--UI made by GhostOne

local Feats = {}
local features = {OnlinePlayers = {}}
local currentMenu = features

require("Rimuru\\libs\\Functions lib") 
require("Rimuru\\keys") 

local alert_screen = graphics.request_scaleform_movie("MP_BIG_MESSAGE_FREEMODE")
local function loaded()
    local i = 0
    while i < 320 do
        graphics.begin_scaleform_movie_method(alert_screen, "SHOW_SHARD_WASTED_MP_MESSAGE")
        graphics.draw_scaleform_movie_fullscreen(alert_screen, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_texture_name_string("Rimurus Menu")
       graphics.scaleform_movie_method_add_param_texture_name_string(string.format("%s to open\n %s to select\n%s/%s to scroll", convertVKToKey(menuKeys.open), convertVKToKey(menuKeys.select), convertVKToKey(menuKeys.up), convertVKToKey(menuKeys.down)))
        graphics.end_scaleform_movie_method(alert_screen)
        i = i+1
        system.wait(0)
    end
end 

stuff.featMethods = {
	set_str_data = function(self, stringTable)
		assert(type(stringTable) == "table", "tried to set str_data property to a non-table value")
		self.str_data = stringTable
	end,

	toggle = function(self, bool)
		if self.type == "toggle" then
			if bool ~= nil then
				self.on = bool
				stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
					self:func()
				end, nil)
			else
				self.on = not self.on
				stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
					self:func()
				end, nil)
			end
		else
			stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
				self:func()
			end, nil)
		end
	end,

	sort_table_and_id = function(self, withInfo)
	--return ((a.info.name:lower()):set_sub(1, 1) < (b.info.name:lower()):set_sub(1, 1)) end
		if next(self) then
			table.sort(self, function(a, b) return a.pid < b.pid end)
			for k, v in pairs(self) do
				if type(k) == "number" then
					local id = v.id:gsub("%d+$", "")
					v.id = id..k
				end
			end
		end
	end,

	set_value = function(self, val)
		assert(type(val) == "number", "tried to set value property to a non-number value")
		if self.type:match("_i") or self.type:match("_val_str") then
			val = val + 0.5
			val = math.floor(val)
			self.value = val
		elseif self.type:match("_f") then
			val = (val * 10000) + 0.5
			val = math.floor(val)
			val = val / 10000
			self.value = val
		end
	end,

	set_min = function(self, val)
		assert(type(val) == "number", "tried to set min property to a non-number value")
		if self.type:match("_i") then
			val = val + 0.5
			val = math.floor(val)
			self.min = val
		elseif self.type:match("_f") then
			val = (val * 10000) + 0.5
			val = math.floor(val)
			val = val / 10000
			self.min = val
		end
	end,

	set_max = function(self, val)
		assert(type(val) == "number", "tried to set max property to a non-number value")
		if self.type:match("_i") then
			val = val + 0.5
			val = math.floor(val)
			self.max = val
		elseif self.type:match("_f") then
			val = (val * 10000) + 0.5
			val = math.floor(val)
			val = val / 10000
			self.max = val
		end
	end,

	set_mod = function(self, val)
		assert(type(val) == "number", "tried to set mod property to a non-number value")
		if self.type:match("_i") then
			val = val + 0.5
			val = math.floor(val)
			self.mod = val
		elseif self.type:match("_f") then
			val = (val * 10000) + 0.5
			val = math.floor(val)
			val = val / 10000
			self.mod = val
		end
	end

}
stuff.metatable = {
	__index = stuff.featMethods,
}

function drawOutline(x, y, w, h, Colour)
	ui.draw_rect(x, y, w, 0.003, Colour.r, Colour.g, Colour.b, Colour.a)
	ui.draw_rect(x-w/2, y+h/2, 0.003, h,  Colour.r, Colour.g, Colour.b, Colour.a)
	ui.draw_rect(x+w/2, y+h/2, 0.003, h,  Colour.r, Colour.g, Colour.b, Colour.a)
	ui.draw_rect(x, y+h, w, 0.003,  Colour.r, Colour.g, Colour.b, Colour.a) 
end

--Functions
function func.add_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo, playerFeat)--, playerid)
	assert((type(nameOfFeat) == "string"), "invalid name in add_feature")
	assert((type(TypeOfFeat) == "string"), "invalid type in add_feature")
	assert(((type(parentOfFeat) == "string") or (type(parentOfFeat) == "number")) or not parentOfFeat, "invalid parent id in add_feature")
	assert((type(functionToDo) == "function") or not functionToDo, "invalid function in add_feature")
	if TypeOfFeat:match("value_i") or TypeOfFeat:match("value_f") or TypeOfFeat:match("slider") or TypeOfFeat:match("value_str") then
		TypeOfFeat = "toggle_"..TypeOfFeat
	end
	local currentParent = features
	if playerFeat then
		currentParent = features["OnlinePlayers"]
	end
	if parentOfFeat ~= 0 and parentOfFeat then
		for parentLine in parentOfFeat:gmatch("(%d+)-*") do
			if parentLine ~= "0" then
				currentParent = currentParent[tonumber(parentLine)]
			end
		end
	end
	currentParent[#currentParent + 1] = {name = nameOfFeat, type = TypeOfFeat, id = tostring(parentOfFeat).."-"..tostring(#currentParent + 1)}
	setmetatable(currentParent[#currentParent], stuff.metatable)
	currentParent[#currentParent].thread = 0
	if TypeOfFeat:match("toggle") then
		currentParent[#currentParent].on = false
	end
	if TypeOfFeat:match(".*value_str.*") then
		currentParent[#currentParent].value = 0
		currentParent[#currentParent].str_data = {}
	elseif TypeOfFeat:match(".*value") then
		currentParent[#currentParent].value = 0
		currentParent[#currentParent]:set_max(0)
		currentParent[#currentParent]:set_min(0)
		currentParent[#currentParent]:set_mod(1)
	end
	currentParent[#currentParent].hidden = false
	if functionToDo then
		if playerFeat then
			currentParent[#currentParent]["func"] = function(self)
				functionToDo(self, stuff.pid)
			end
		else
			currentParent[#currentParent]["func"] = function(self)
				functionToDo(self)
			end
		end
	end
	return currentParent[#currentParent]
end

--player feature functions

function func.add_player_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo)
	local pfeat = func.add_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo, true)
	if stuff.playerIds then
		for k, v in pairs(stuff.playerIds) do
			func.addToTable(features["OnlinePlayers"], v, 0, v.id)
		end
	end
	return pfeat
end

function func.addToTable(getTable, addTable, playerid, featId)
	for k, v in pairs(getTable) do
		if tostring(v):match("table") then
			addTable[k] = {}
			if v.type == "parent" then
				func.addToTable(v, addTable[k], 0, featId)
			else 
				for i, e in pairs(v) do
					if not addTable[k][i] then
						addTable[k][i] = e
					end
				end
			end
		else
			if not addTable[k] then
				addTable[k] = v
			end
		end
	end
end

function func.set_player_feat_parent(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo)
	local parentTable
	parentTable = func.add_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo)
	stuff.PlayerParent = parentTable
	stuff.playerIds = {}
		for i = 0, 31 do
			if player.is_player_valid(i) then
				stuff.playerIds[i] = func.add_feature(tostring(player.get_player_name(i)), "parent", parentTable.id, function(f)
					stuff.pid = i
				end)
				stuff.playerIds[i].pid = i
				func.addToTable(features["OnlinePlayers"], stuff.playerIds[i], i, stuff.playerIds[i].id)
			end
		end

		stuff.PlayerParent:sort_table_and_id(true)

	event.add_event_listener("player_join", function(listener)
		stuff.addList[listener.player] = true
	end)
	event.add_event_listener("player_leave", function(listener)
		if stuff.playerIds[listener.player] then
			stuff.deleteList[listener.player] = true
		end
	end)
	return parentTable
end

--end of player feature functions

function func.get_parent_table(id)
	if type(id) == "table" then
		id = id.id
	end
	local currentParent = features
	if id ~= 0 then
		for parentLine in id:gmatch("(%d+)-*") do
			if parentLine ~= "0" then
				currentParent = currentParent[tonumber(parentLine)]
			end
		end
	end
	return currentParent
end

function func.delete_feature(id)
	if type(id) == "table" then
		id = id.id
	end
	local Parents = {features}
	if id ~= 0 then
		for parentLine in id:gmatch("(%d+)-*") do
			if parentLine ~= "0" then
				Parents[#Parents + 1] = Parents[#Parents][tonumber(parentLine)]
			end
		end
	end
	
	table.remove(Parents[#Parents - 1], id:match("%d+$"))
	for k, v in pairs(Parents[#Parents - 1]) do
		if type(k) == "number" then
			if type(v.id) ~= "nil" then
				if tonumber(v.id:match("%d+$")) > tonumber(id:match("%d+$")) then
					local id = v.id:match("%d+$")
					v.id = v.id:gsub("%d+$", "")
					v.id = v.id..tonumber(id - 1)
				end
			end
		end
	end
	if Parents[#Parents].type == "parent" then
		local originIndex = 999
		for k = #stuff.previousMenus, 1, -1 do
			if currentMenu.id == id then
				stuff.previousMenus[k].scroll = 1
				stuff.previousMenus[k].drawScroll = 0
				currentMenu = stuff.previousMenus[k].menu
				stuff.previousMenus[k] = nil
				break
			elseif stuff.previousMenus[k].menu.id == id then
				stuff.previousMenus[k - 1].scroll = 1
				stuff.previousMenus[k - 1].drawScroll = 0
				currentMenu = stuff.previousMenus[k - 1].menu
				originIndex = k
				for i, e in pairs(stuff.previousMenus) do
					if i > originIndex - 2 then
						stuff.previousMenus[i] = nil
					end
				end
				break
			end
		end
	end
end

function func.delete_player_feature(id)
	if type(id) == "table" then
		id = id.id
	end

	local Parents = {features["OnlinePlayers"]}
	if id ~= 0 then
		for parentLine in id:gmatch("(%d+)-*") do
			if parentLine ~= "0" then
				Parents[#Parents + 1] = Parents[#Parents][tonumber(parentLine)]
			end
		end
	end

	table.remove(Parents[#Parents - 1], tonumber(id:match("%d+$")))
	for k, v in pairs(Parents[#Parents - 1]) do
		if type(k) == "number" then
			if type(v.id) ~= "nil" then
				if tonumber(v.id:match("%d+$")) > tonumber(id:match("%d+$")) then
					local id = v.id:match("%d+$")
					v.id = v.id:gsub("%d+$", "")
					v.id = v.id..tonumber(id - 1)
				end
			end
		end
	end

	local featIds = {}
	for k, v in pairs(stuff.PlayerParent) do
		if type(k) == "number" then
			featIds[#featIds + 1] = v.id..id:sub(2, #id)
		end
	end
	for k, v in pairs(featIds) do
		func.delete_feature(v)
	end
end

function func.get_player_feature(id)
	local featIds = {}
	for k, v in pairs(stuff.PlayerParent) do
		if type(k) == "number" then
			featIds[#featIds + 1] = v.id..id:sub(2, #id)
		end
	end
	local playerFeatTable = {}
	for k, v in pairs(featIds) do
		local parent = features
		if id ~= 0 then
			for parentLine in id:gmatch("(%d+)-*") do
				if parentLine ~= "0" then
					parent = parent[tonumber(parentLine)]
				end
			end
		end
		playerFeatTable[#playerFeatTable + 1] = parent
	end
	return playerFeatTable
end



function func.isKeyDown(keyNum)
    local key = MenuKey()
    key:push_vk(keyNum)
    return key:is_down()
  end

function func.doKey(time, key, doLoopedFunction, functionToDo)
	if func.isKeyDown(key) then
		functionToDo()
		local timer = utils.time_ms() + time
		while timer > utils.time_ms() and func.isKeyDown(key) do
			system.wait(0)
		end
		while timer < utils.time_ms() and func.isKeyDown(key) do
			if doLoopedFunction then
				functionToDo()
			end
			local timer = utils.time_ms() + 25
			while timer > utils.time_ms() do
				system.wait(0)
			end
		end
	end
end

local fadeColour = {r = 255, g = 0, b = 0}
local function RGBFade()
    if fadeColour.r > 0 and fadeColour.b == 0 then
        fadeColour.r = fadeColour.r - 1
        fadeColour.g = fadeColour.g + 1
    end
    if fadeColour.g > 0 and fadeColour.r == 0 then
        fadeColour.g = fadeColour.g - 1
        fadeColour.b = fadeColour.b + 1
    end
    if fadeColour.b > 0 and fadeColour.g == 0 then
        fadeColour.r = fadeColour.r + 1
        fadeColour.b = fadeColour.b - 1
    end
end

function func.draw_text(text, pos, font, scale, color, flags)
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, 255)
    ui.set_text_outline(true)
    ui.draw_text(text, pos)
end

function func.drawFeat(k, v, offset, hiddenOffset)
	stuff.drawFeatParams = {rectPos = v2(stuff.menuData.x, stuff.menuData.y - 0.16527), indexOffset = 0.0270833, scale = v2(stuff.menuData.width, 0.025), textOffset = v2(-0.097, -0.016)}
	local offset = offset or 0
	if offset == 0 then
	end
	ui.set_text_scale(0.5)
	if stuff.scroll == k + stuff.drawScroll then
		stuff.scrollHiddenOffset = hiddenOffset or stuff.scrollHiddenOffset
		--ui.set_text_color(144, 151, 245, 180)
		ui.draw_rect(stuff.drawFeatParams.rectPos.x, stuff.drawFeatParams.rectPos.y + (stuff.drawFeatParams.indexOffset * k), stuff.drawFeatParams.scale.x, stuff.drawFeatParams.scale.y, 144, 151, 245, 255)
	else
		ui.set_text_color(255, 255, 255, 180)
	end
	ui.set_text_font(6)
	ui.set_text_outline(true)
	ui.set_text_justification(1)
	if v.rightJust then
		ui.set_text_justification(v.rightJust)
	end
	if v.type == "parent" then
		ui.draw_text(v["name"], v2(stuff.drawFeatParams.rectPos.x + stuff.drawFeatParams.textOffset.x, stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.drawFeatParams.indexOffset * k)))
		func.drawFeat(k, {name = ">>", type = "action"}, 0.18)
	elseif v.type:match(".*action.*") then
		ui.draw_text(v.name, v2(stuff.drawFeatParams.rectPos.x + stuff.drawFeatParams.textOffset.x + offset, stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.drawFeatParams.indexOffset * k)))
	elseif v.type:match(".*toggle.*") then
		ui.draw_text(v.name..": "..tostring(v.on), v2(stuff.drawFeatParams.rectPos.x + stuff.drawFeatParams.textOffset.x, stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.drawFeatParams.indexOffset * k)))
	end
	if v.type then
		if v.type:match(".*value_str.*") and v.str_data then
			func.drawFeat(k, {name = "< "..tostring(v.str_data[v.value + 1]).." >", type = "action", rightJust = 0}, 0.15)
		elseif v.type:match(".*value_f") then
			func.drawFeat(k, {name = "< "..tostring(v.value).." >", type = "action", rightJust = 0}, 0.15)
		elseif v.type:match(".*value_i") then 
			func.drawFeat(k, {name = "< "..tostring(v.value).." >", type = "action", rightJust = 0}, 0.15)
		end
	end
end

local backgroundSprite = scriptdraw.register_sprite(stuff.appdata.."\\scripts\\Rimuru\\sprites\\backgroundSprite.png")
function func.DrawCurrentMenu()
	stuff.drawHiddenOffset = 0
	for k, v in pairs(currentMenu) do
		if type(k) == "number" then
			if v.hidden then
				stuff.drawHiddenOffset = stuff.drawHiddenOffset + 1
			end
		end
	end
	
	--scriptdraw.draw_sprite(backgroundSprite, v2(stuff.menuData.x-stuff.menuData.x, stuff.menuData.y-stuff.menuData.height/2), (0.512 * (1000 / scriptdraw.get_sprite_size(backgroundSprite).x)) / (2560 / graphics.get_screen_width()), 0, RGBAToInt(255, 255, 255, 255))
	ui.draw_rect(stuff.menuData.x, stuff.menuData.y, stuff.menuData.width, stuff.menuData.height, stuff.menuData.color.r, stuff.menuData.color.g, stuff.menuData.color.b, 255)
	drawOutline(stuff.menuData.x, stuff.menuData.y-stuff.menuData.height/2, stuff.menuData.width, stuff.menuData.height, {r=144, g=151, b=245, a=255})
	func.draw_text("Rimurus Menu\tv1.1.1 \t"..stuff.scroll.."/"..#currentMenu, v2(stuff.menuData.x, stuff.menuData.y-stuff.menuData.height/1.7), 0, 0.34, fadeColour, 1)

	--Info

	if #currentMenu - stuff.drawHiddenOffset > 10 then
		stuff.maxDrawScroll = #currentMenu - stuff.drawHiddenOffset - 11
	else
		stuff.maxDrawScroll = 0
	end
	if stuff.scroll > #currentMenu - stuff.drawHiddenOffset then
		stuff.scroll = #currentMenu - stuff.drawHiddenOffset
	elseif stuff.scroll < 1 then
		stuff.scroll = 1
	end
	local hiddenOffset = 0
	for k, v in pairs(currentMenu) do
		if type(k) == "number" then
			if v.hidden then
				hiddenOffset = hiddenOffset + 1
			else
				if k <= stuff.drawScroll + stuff.drawHiddenOffset + 11 and k >= stuff.drawScroll + 1 then
					func.drawFeat(k - stuff.drawScroll - hiddenOffset, v, 0, hiddenOffset)
				end
			end
		end
	end
	system.wait(0)
end

function func.activateFeatFunc(featTable)
	if featTable.func and menu.has_thread_finished(featTable.thread) then
		if not (featTable.thread) then
			featTable.thread = 0
		end
		featTable.thread = menu.create_thread(function()
			featTable:func()
		end, nil)
	end
end
--End of functions

-- Threads
menu.create_thread(function()
	loaded()
	
	while true do
		if next(stuff.deleteList) then
			for k, v in pairs(stuff.deleteList) do
				func.delete_feature(stuff.playerIds[k])
				stuff.deleteList[k] = nil
				stuff.playerIds[k] = nil
				system.wait(50)
			end
			stuff.deleteList = {}
			stuff.PlayerParent:sort_table_and_id(true)
		end
		if next(stuff.addList) then
			for k, v in pairs(stuff.addList) do
				if player.is_player_valid(k) then
					local tempTable
					stuff.playerIds[k] = func.add_feature(tostring(player.get_player_name(k)), "parent", stuff.PlayerParent.id, function(f)
						stuff.pid = k
					end)
					stuff.playerIds[k].pid = k
					func.addToTable(features["OnlinePlayers"], stuff.playerIds[k], k, stuff.playerIds[k].id)
					stuff.addList[k] = nil
					system.wait(50)
				end
			end
			stuff.addList = {}
			stuff.PlayerParent:sort_table_and_id(true)
		end
		system.wait(1000)
	end
end, nil)

menu.create_thread(function()
	while true do
		RGBFade()		
		system.wait(30)
	end
end, nil)

--key threads
menu.create_thread(function()
	while true do
		if stuff.menuToggle then
			func.DrawCurrentMenu()
			controls.disable_control_action(0, 172, true)
			controls.disable_control_action(0, 27, true)
		else
			system.wait(0)
		end
	end
end, nil)

menu.create_thread(function()
	while true do
		func.doKey(500, menuKeys.open, false, function() -- F5
			stuff.menuToggle = not stuff.menuToggle
		end)
		if stuff.menuToggle then
			func.doKey(500, menuKeys.down, true, function() -- downKey
				if stuff.scroll + stuff.scrollHiddenOffset >= #currentMenu then
					stuff.scroll = 1
					stuff.drawScroll = 0
				else
					stuff.scroll = stuff.scroll + 1
					if stuff.scroll - stuff.drawScroll + stuff.scrollHiddenOffset >= 10 and stuff.drawScroll < stuff.maxDrawScroll then
						stuff.drawScroll = stuff.drawScroll + 1
					end
				end
			end)
			func.doKey(500, menuKeys.up, true, function() -- upKey
				if stuff.scroll <= 1 then
					stuff.hiddenfeats = 0
					for k, v in pairs(currentMenu) do
						if type(v) == "table" then
							if v.hidden then
								stuff.hiddenfeats = stuff.hiddenfeats + 1
							end
						end
					end
					stuff.scroll = #currentMenu - stuff.hiddenfeats
					stuff.drawScroll = stuff.maxDrawScroll
				else
					stuff.scroll = stuff.scroll - 1
					if stuff.scroll - stuff.drawScroll + stuff.scrollHiddenOffset <= 2 and stuff.drawScroll > 0 then
						stuff.drawScroll = stuff.drawScroll - 1
					end
				end
			end)
			func.doKey(500, menuKeys.select, true, function() --enter
				if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then--and not stuff.inputOn then
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type == "parent" then
						stuff.previousMenus[#stuff.previousMenus + 1] = {menu = currentMenu, scroll = stuff.scroll, drawScroll = stuff.drawScroll, scrollHiddenOffset = stuff.scrollHiddenOffset}
						currentMenu = currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
						func.activateFeatFunc(currentMenu)
						stuff.scroll = 1
						system.wait(0)
						stuff.drawScroll = 0
						stuff.scrollHiddenOffset = 0
						while func.isKeyDown(menuKeys.select) do
							system.wait(0)
						end
					elseif currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match(".*action.*") then
						func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
					elseif currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("toggle") then
						currentMenu[stuff.scroll + stuff.scrollHiddenOffset].on = not currentMenu[stuff.scroll + stuff.scrollHiddenOffset].on
						func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
					end
				else
					system.wait(100)
				end
			end)
			func.doKey(500, menuKeys.back, false, function() --backspace
				if stuff.previousMenus[#stuff.previousMenus] then
					currentMenu = stuff.previousMenus[#stuff.previousMenus].menu
					stuff.scroll = stuff.previousMenus[#stuff.previousMenus].scroll
					stuff.drawScroll = stuff.previousMenus[#stuff.previousMenus].drawScroll
					stuff.scrollHiddenOffset = stuff.previousMenus[#stuff.previousMenus].scrollHiddenOffset
					stuff.previousMenus[#stuff.previousMenus] = nil
				end
			end)
			func.doKey(500, menuKeys.sideScrollLeft, true, function() -- left
				if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value then
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].str_data then
							if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value <= 0 then
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = #currentMenu[stuff.scroll + stuff.scrollHiddenOffset].str_data - 1
							else
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value - 1
							end
						else
							if tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) <= currentMenu[stuff.scroll + stuff.scrollHiddenOffset].min then
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = currentMenu[stuff.scroll + stuff.scrollHiddenOffset].max
							else
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) - currentMenu[stuff.scroll + stuff.scrollHiddenOffset].mod
							end
						end
					end
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type then
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("auto") or currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("toggle_value") then
							func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
						end
					end
				end
			end)
			func.doKey(500, menuKeys.sideScrollRight, true, function() -- right
				if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value then
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].str_data then
							if tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) >= tonumber(#currentMenu[stuff.scroll + stuff.scrollHiddenOffset].str_data) - 1 then
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = 0
							else
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value + 1
							end
						else
							if tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) >= currentMenu[stuff.scroll + stuff.scrollHiddenOffset].max then
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = currentMenu[stuff.scroll + stuff.scrollHiddenOffset].min
							else
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) + currentMenu[stuff.scroll + stuff.scrollHiddenOffset].mod
							end
						end
					end
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type then
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("auto") or currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("toggle_value") then
							func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
						end
					end
				end
			end)
		end
		system.wait(0)
	end
end, nil)
--End of threads

--changing menu functions to ui functions
menu.add_feature = func.add_feature
menu.add_player_feature = func.add_player_feature
menu.delete_feature = func.delete_feature
menu.delete_player_feature = func.delete_player_feature
menu.get_player_feature = func.get_player_feature
--

local localOpt = func.add_feature("Local Options", "parent", 0)
local vehOpt = func.add_feature("Vehicle Options", "parent", 0)
local spawnOpt = func.add_feature("Spawner Options", "parent", 0)
local onlineOpt = func.add_feature("Online Options", "parent", 0)
func.set_player_feat_parent("Players", "parent", onlineOpt.id)
local lobbyOpt = func.add_feature("Lobby Options", "parent", onlineOpt.id)
local settingOpt = func.add_feature("Settings", "parent", 0)

local wepOpt = func.add_feature("Object Weapons", "parent", localOpt.id)
-- Local Options
func.add_feature("Object Gun", "toggle ", localOpt.id, function(toggle)
	while toggle.on do
		ObjectGun()
		system.wait(0)
	end
end)
func.add_feature("Delete Gun", "toggle ", localOpt.id, function(toggle)
	while toggle.on do
		DeleteGun()
		system.wait(0)
	end
end)
func.add_feature("Grapple Gun", "toggle ", localOpt.id, function(toggle)
	while toggle.on do
		GrappleGun()
		system.wait(0)
	end
end)
func.add_feature("Rope Gun", "action ", localOpt.id, function(toggle)
	menu.notify("Made by zero", "", 4, RGBAToInt(144, 151, 245))	
	RopeGun()
end)
func.add_feature("Dust Gun", "toggle ", localOpt.id, function(toggle)
	while toggle.on do
		ExplosionTypeGun(80)
        ExplosionTypeGun(42)
		system.wait(0)
	end
end)

func.add_feature("BlackParade", "toggle", localOpt.id, function(toggle)
	while toggle.on do
		BlackParade()
		system.wait(0)
	end
end)

func.add_feature("Give Wings", "action", localOpt.id, function()
	local wingsHash = gameplay.get_hash_key("vw_prop_art_wings_01a")

    if streaming.is_model_valid(wingsHash) then
	    streaming.request_model(wingsHash)
	    while not streaming.has_model_loaded(wingsHash) and utils.time_ms() + 450 > utils.time_ms() do
		    system.wait(0)
	    end

	    local pos = entity.get_entity_coords(player.player_id(), true)
	    local wings = object.create_object(wingsHash, pos, true, true)

	    entity.attach_entity_to_entity(wings, player.get_player_ped(player.player_id()), ped.get_ped_bone_index(player.get_player_ped(player.player_id()), 0x5c01), v3(-1,0,0), v3(00,90,0), true, false, true, 0, true)
	    streaming.set_model_as_no_longer_needed(wingsHash)
    end
end)

func.add_feature("Remove Wings", "action", localOpt.id, function()
	local allObjects = object.get_all_objects()

	for i=1, #allObjects do
		if Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), entity.get_entity_coords(allObjects[i])) <= 2 then
			network.request_control_of_entity(allObjects[i])
			while not network.has_control_of_entity(allObjects[i]) and utils.time_ms() + 450 > utils.time_ms() do
				system.wait(0)
			end
			
		entity.delete_entity(allObjects[i])
		end
	end
end)

func.add_feature("Recon Drone", "toggle", localOpt.id, function(feat)
	menu.notify("Press E To Fire", "Made By Err_Net_Array", 6, RGBAToInt(144, 151, 245, 255))
	droneMode(feat)
end)

func.add_feature("Type As Rockstar", "action", localOpt.id, function()
	local status, msg = input.get("Input A Message", "", 100, 0)    
	network.send_chat_message(string.format("¦ %s", msg), false)
end)

func.add_feature("FlashMod", "toggle", localOpt.id, function(toggle)
	while toggle.on do
		doPTFX()
		system.wait(0)
	end
end)
--End

---Weapon Options
func.add_feature("Give FireAxe", "action", wepOpt.id, function(feat, tog)
	weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), 940833800, 0, true)
end)

func.add_feature("Give Sword", "action", wepOpt.id, function(feat, tog)
	weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), 1141786504, 0, true)
end)

func.add_feature("Give Sledgehammer", "action", wepOpt.id, function(feat, tog)
	weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), 1737195953, 0, true)
end)

func.add_feature("Give NailGun", "action", wepOpt.id, function(feat, tog)
	weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), 324215364, 0, true)
end)

--end

-- Vehicle Options
func.add_feature("GTA4 Neons", "action", vehOpt.id, function(feat, tog)
	Gta4Neons()
end)

func.add_feature("Remove Neons", "action", vehOpt.id, function(feat, tog)
	RemoveGtaNeons()
end)

func.add_feature("TP Into Personal Vehicle", "action", vehOpt.id, function()
	tpVehicle()
end)

func.add_feature("Store Vehicle In Garage", "action", vehOpt.id, function()
	vehicleBypass()
end)

func.add_feature("Destroy Personal Vehicle", "action", vehOpt.id, function()
	script.trigger_script_event(0xC2CC7762, player.player_id(), {player.player_id(), player.player_id()}) --destroy personal
end)

-- Modded Colours
local colVeh = func.add_feature("Modded Colours", "parent", vehOpt.id)

local colourList = {}
local function parseModdedcolours()
	local ini = require("Rimuru\\libs\\ini_parser") 
	local cfg = ini.parse("Rimuru\\modded colours\\"..colourList[stuff.scroll])

	setVehicleColour({r=cfg.colour.red, g=cfg.colour.green, b=cfg.colour.blue})
end

local function loadModdedColours()
	local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
	colourList = utils.get_all_files_in_directory(appdata.."scripts\\Rimuru\\modded colours", "ini")
	for i=1, #colourList do
		func.add_feature(colourList[i], "action", colVeh.id, function()
			parseModdedcolours()
		end)
	end
end
loadModdedColours()

local garageVeh = func.add_feature("Garage Vehicles", "parent", vehOpt.id)

for k,v in pairs(Slots) do
	func.add_feature(v[2], "action", garageVeh.id, function()
		if menu.is_trusted_mode_enabled() then
			script.set_global_i(2810701+911, 1) --mechanic deliver
			script.set_global_i(2810701+961, 0) --find location near road
			script.set_global_i(18196+176, 0) --insta deliver
			script.set_global_i(2810701+958, stuff.scroll) --veh index
			script.set_global_i(2810701+176, 0)
		else
			menu.notify("Enable Trusted Mode", "Rimurus Menu", 4, RGBAToInt(144, 151, 245, 255))
		end
	end)
end

--local iniVeh = func.add_feature("INI Vehicles", "parent", vehOpt.id)

--- Spawner Options
func.add_feature("Objects", "action_value_str", spawnOpt.id, function(feat)
	SpawnObj(feat.value)
end):set_str_data(objects)

func.add_feature("World Objects", "action_value_str", spawnOpt.id, function(feat)
	SpawnWrld(feat.value)
end):set_str_data(worldObjects)

func.add_feature("Spawn Objects By Name", "action", spawnOpt.id, function(feat)
	SpawnObjFromName()
end)

func.add_feature("Props", "action_value_str", spawnOpt.id, function(feat)
	SpawnProp(feat.value)
end):set_str_data(props)

func.add_feature("Peds", "action_value_str", spawnOpt.id, function(feat)
	SpawnPed(feat.value)
end):set_str_data(pedList)

func.add_feature("Animals", "action_value_str", spawnOpt.id, function(feat)
	SpawnAnimal(feat.value)
end):set_str_data(animalsPeds)

-- Lobby Options
func.add_feature("Force Remove Lobby", "action", lobbyOpt.id, function()
	for i=0, 31 do
		network.force_remove_player(i)
	end
end)

func.add_feature("Kick Lobby", "action", lobbyOpt.id, function()
	for i=0, 31 do
		script.trigger_script_event(-1991317864, i, {i, -1, -1, -1, -1})
	end
end)

func.add_feature("Force All Into Servere Weather", "action", lobbyOpt.id, function(feat, pid)
	for i=0, 31 do
		script.trigger_script_event(2020588206, i, {i, 0})
	end
end)

func.add_feature("Destroy All Personal Vehicles", "action", lobbyOpt.id, function()
	for i=0, 31 do
		script.trigger_script_event(3268179810, i, {i, i}) --destroy personal
		script.trigger_script_event(578856274, i, {i, 0, 0, 0, 0, 1, i, math.min(2147483647, gameplay.get_frame_count())}) --kickout
	end
end)

func.add_feature("Fake Money Bag Drop Lobby", "toggle", lobbyOpt.id, function(feat)
	streaming.request_model(gameplay.get_hash_key("prop_money_bag_01"))
	if streaming.has_model_loaded(gameplay.get_hash_key("prop_money_bag_01")) then
		while feat.on do
			for i=0, 31 do	
				if player.is_player_valid(i) then
					bags = object.create_object(gameplay.get_hash_key("prop_money_bag_01"), player.get_player_coords(i), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(i), false)
					entity.set_entity_heading(bags, player.get_player_heading(i))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(i))
				end
				system.wait(10)
			end		
		end
	end	
end)

func.add_feature("Fake Money Drop Lobby", "toggle", lobbyOpt.id, function(feat)
	streaming.request_model(gameplay.get_hash_key("prop_poly_bag_money"))
	if streaming.has_model_loaded(gameplay.get_hash_key("prop_poly_bag_money")) then
		while feat.on do
			for i=0, 31 do	
				if player.is_player_valid(i) then
					bags = object.create_object(gameplay.get_hash_key("prop_poly_bag_money"), player.get_player_coords(i), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(i), false)
					entity.set_entity_heading(bags, player.get_player_heading(i))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(i))
				end
				system.wait(10)
			end		
		end
	end	
end)

func.add_feature("Fake RP Drop Lobby", "toggle", lobbyOpt.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key("v_res_d_dildo_f"))
	if streaming.has_model_loaded(gameplay.get_hash_key("v_res_d_dildo_f")) then
		while feat.on do
			for i=0, 31 do	
				if player.is_player_valid(i) then
					bags = object.create_object(gameplay.get_hash_key("v_res_d_dildo_f"), player.get_player_coords(i), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(i), false)
					entity.set_entity_heading(bags, player.get_player_heading(i))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(i))
				end
				system.wait(10)
			end		
		end
	end	
end)

func.add_feature("Rain Object", "value_str", lobbyOpt.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key(objects[feat.value]))
	if streaming.has_model_loaded(gameplay.get_hash_key(objects[feat.value])) then
		while feat.on do
			for i=0, 31 do	
				if player.is_player_valid(i) then
					bags = object.create_object(gameplay.get_hash_key(objects[feat.value]), player.get_player_coords(i), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(i), false)
					entity.set_entity_heading(bags, player.get_player_heading(i))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(i))
				end
				system.wait(10)
			end		
		end
	end	
end):set_str_data(objects)

--Player Options
local malic = func.add_player_feature("Malicious Options", "parent", 0)
local misc = func.add_player_feature("Misc Options", "parent", 0)
local troll = func.add_player_feature("Trolling Options", "parent", 0)

func.add_player_feature("Force Remove", "action", malic.id, function(feat, pid)
	network.force_remove_player(pid)
end)

func.add_player_feature("Force Into Severe Weather", "action", malic.id, function(feat, pid)
	script.trigger_script_event(2020588206, pid, {pid, 0})
end)

func.add_player_feature("Kick", "action", malic.id, function(feat, pid)
	script.trigger_script_event(-1991317864, pid, {pid, -1, -1, -1, -1})
end)

--func.add_player_feature("Crash", "action", malic.id, function(feat, pid)
--	--hsw crash here
--end)

func.add_player_feature("Destroy Personal Vehicle", "action", malic.id, function(feat, pid)
		script.trigger_script_event(3268179810, pid, {pid, pid}) --destroy personal
		script.trigger_script_event(578856274, pid, {pid, 0, 0, 0, 0, 1, pid, math.min(2147483647, gameplay.get_frame_count())}) --kickout
end)

func.add_player_feature("Spawn Peds", "action_value_str", misc.id, function(feat, pid)
	SpawnPed(feat.value, 100, pid)
end):set_str_data(pedList)

--func.add_player_feature("Rain Object", "value_str", misc.id, function(feat, pid)
--	streaming.request_model(gameplay.get_hash_key(objects[feat.value]))
--	if streaming.has_model_loaded(gameplay.get_hash_key(objects[feat.value])) then
--		while feat.on do
--				if player.is_player_valid(i) then
--					bags = object.create_object(gameplay.get_hash_key(objects[feat.value]), player.get_player_coords(pid), true, true)
--					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(pid), false)
--					entity.set_entity_heading(bags, player.get_player_heading(pid))
--					entity.set_entity_coords_no_offset(bags, player.get_player_coords(pid))
--				end
--			system.wait(10)
--		end
--	end	
--end):set_str_data(objects)


func.add_player_feature("Fake Money Bag Drop", "toggle", troll.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key("prop_money_bag_01"))		
	while feat.on do
		local bags = object.create_object(gameplay.get_hash_key("prop_money_bag_01"), player.get_player_coords(pid), true, true)
		entity.set_entity_no_collsion_entity(bags, player.get_player_ped(pid), false)
			entity.set_entity_coords_no_offset(bags, player.get_player_coords(pid))
			entity.set_entity_heading(bags, player.get_player_heading(pid))
		system.wait(5)
	end		
end)

func.add_player_feature("Fake Money Drop", "toggle", troll.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key("bkr_prop_scrunched_moneypage"))		
	local bags = object.create_object(gameplay.get_hash_key("bkr_prop_scrunched_moneypage"), player.get_player_coords(pid), true, true)
	entity.set_entity_no_collsion_entity(bags, player.get_player_ped(pid), false)
	while feat.on do
			entity.set_entity_coords_no_offset(bags, player.get_player_coords(pid))
			entity.set_entity_heading(bags, player.get_player_heading(pid))
		system.wait(10)
	end		
end)

func.add_player_feature("Fake RP Drop", "toggle", troll.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key("v_res_d_dildo_f"))		
	while feat.on do
		local bags = object.create_object(gameplay.get_hash_key("v_res_d_dildo_f"), player.get_player_coords(pid), true, true)
		entity.set_entity_no_collsion_entity(bags, player.get_player_ped(pid), false)
			entity.set_entity_coords_no_offset(bags, player.get_player_coords(pid))
			entity.set_entity_heading(bags, player.get_player_heading(pid))
		system.wait(5)
	end		
end)

-- Settings
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
 
local pStates = func.add_feature("Player States", "parent", settingOpt.id)

local typing = func.add_feature("Toggle Typing", "toggle", pStates.id, function(feat)
	playerStates.typing = feat.on
end)
typing.on = playerStates.typing

local paused = func.add_feature("Toggle Paused", "toggle", pStates.id, function(feat)
	playerStates.paused = feat.on
end)
paused.on = playerStates.paused

local vip = func.add_feature("Toggle VIP", "toggle", pStates.id, function(feat)
	playerStates.vip = feat.on
end)
vip.on = playerStates.vip