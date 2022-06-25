-- Made by GhostOne

local stuff = {}
stuff.ChatSpyTable = {}

stuff.scriptHookFunction = function(source, target, params, count, stuff)
	if params[1] == 747270864 then
		if not stuff.ChatSpyTable.pidTable[source] then
			stuff.ChatSpyTable.total = stuff.ChatSpyTable.total + 1
			stuff.ChatSpyTable.pidTable[source] = {currentPos = stuff.ChatSpyTable.total, string = " is typing...", alpha = 255}
			stuff.ChatSpyTable.pidTable[source].id = menu.create_thread(function()
				stuff.typingThreadCallback(stuff, source)
			end, nil)
		end
	elseif params[1] == 3304008971 then
		if stuff.ChatSpyTable.pidTable[source] then
			stuff.ChatSpyTable.threads[#stuff.ChatSpyTable.threads + 1] = menu.create_thread(function()
				stuff.deleteThreadCallback(stuff, source)
			end, nil)
		end
	end
end

stuff.typingThreadCallback = function(stuff, source)
	while true do
		if player.get_player_name(source) and stuff.ChatSpyTable.pidTable[source].string then
			ui.set_text_scale(0.4)
			ui.set_text_color(255, 255, 255, stuff.ChatSpyTable.pidTable[source].alpha)
			ui.set_text_font(0)
			ui.set_text_outline(true)
			ui.set_text_right_justify(false)
			ui.set_text_justification(1)
			ui.draw_text(player.get_player_name(source)..stuff.ChatSpyTable.pidTable[source].string, v2(0.01, 0.2 + (stuff.ChatSpyTable.pidTable[source].currentPos * 0.03)))
		end
		system.wait(0)
	end
end

stuff.deleteThreadCallback = function(stuff, source)
	stuff.ChatSpyTable.pidTable[source].string = " closed chat box."
	while stuff.ChatSpyTable.pidTable[source].alpha > 0 do
		stuff.ChatSpyTable.pidTable[source].alpha = stuff.ChatSpyTable.pidTable[source].alpha - 5
		system.wait(10)
	end
	stuff.ChatSpyTable.total = stuff.ChatSpyTable.total - 1
	for k, v in pairs(stuff.ChatSpyTable.pidTable) do
		if type(v) == "table" then
			if v.currentPos > stuff.ChatSpyTable.pidTable[source].currentPos then
				v.currentPos = v.currentPos - 1
			end
		end
	end
	menu.delete_thread(stuff.ChatSpyTable.pidTable[source].id)
	stuff.ChatSpyTable.pidTable[source] = nil
end

menu.add_feature("Typing Indicator", "toggle", 0, function(f)
	if f.on then
		stuff.ChatSpyTable = {pidTable = {}, threads = {}}
		stuff.ChatSpyTable.total = -1
		stuff.ChatSpyTable.hook = hook.register_script_event_hook(function(source, target, params, count)
			stuff.scriptHookFunction(source, target, params, count, stuff)
		end)
	else
		for _, thread in pairs(stuff.ChatSpyTable.threads) do
			menu.delete_thread(thread)
		end
		for _, pidTable in pairs(stuff.ChatSpyTable.pidTable) do
			menu.delete_thread(pidTable.id)
		end
		hook.remove_script_event_hook(stuff.ChatSpyTable.hook)
		stuff.ChatSpyTable = {}
	end
end)

event.add_event_listener("exit", function()
	if stuff.ChatSpyTable.threads then
		for _, thread in pairs(stuff.ChatSpyTable.threads) do
			menu.delete_thread(thread)
		end
	end
	if stuff.ChatSpyTable.pidTable then
		for _, pidTable in pairs(stuff.ChatSpyTable.pidTable) do
			menu.delete_thread(pidTable.id)
		end
	end
	if stuff.ChatSpyTable.hook then
		hook.remove_script_event_hook(stuff.ChatSpyTable.hook)
	end
end)

menu.notify("Made by GhostOne\nCredits to I think Rimuru for the 'typing begin' script event", "Typing Indicator", 4, 0x00ff00)
