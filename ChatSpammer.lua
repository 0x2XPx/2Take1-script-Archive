local chatId = menu.add_feature("Chat Spammer", "parent", 0).id

local ChatMsg

menu.add_feature("Enter Custom Chat", "action", chatId, function(f)
    local r, s = input.get("Enter Chat Message", "", 64, 0)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    ChatMsg = s
end)
local ChatSpamFeat1 = menu.add_feature("Chat Spam", "value_i", chatId, function(f)
    if not f.on then return HANDLER_POP end
    if ChatMsg == nil then
        ui.notify_above_map("Set a message to spam", "Chat Spammer", 140)
        f.on = false
        return HANDLER_POP
    end
    network.send_chat_message(ChatMsg, false)
    system.wait(f.value_i)
    return HANDLER_CONTINUE
end)
ChatSpamFeat1.min_i = 100
ChatSpamFeat1.max_i = 2000
ChatSpamFeat1.mod_i = 10
ChatSpamFeat1.value_i = 500

local function SpamChat(input)
	while true do
		system.wait(input[2])
		network.send_chat_message(input[1], false)
	end
end
local SpamChatThreadId
local ChatSpamFeat2 = menu.add_feature("Set Message And Spam", "value_i", chatId, function(f)
	if SpamChatThreadId then
		menu.delete_thread(SpamChatThreadId)
		SpamChatThreadId = nil
	end
	if not f.on then
		f.data = nil
		return HANDLER_POP
	end
	if not f.data then
		local r, s = input.get("Enter Chat Message", "", 64, 0)
		if r == 1 then
			return HANDLER_CONTINUE
		end
		if r == 2 then
			f.on = false
			return HANDLER_POP
		end
		f.data = s
	end
	SpamChatThreadId = menu.create_thread(SpamChat, {f.data, f.value_i})
end)
ChatSpamFeat2.min_i = 100
ChatSpamFeat2.max_i = 2000
ChatSpamFeat2.mod_i = 10
ChatSpamFeat2.value_i = 500