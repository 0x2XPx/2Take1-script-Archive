send1 = function(feat)

	local pid = feat.value_i
	
	local r,s = input.get("Enter Event Hash to Send (Dec/Hex)", "", 64, 0)
	if r == 1 then
		return HANDLER_CONTINUE
	end
	
	if r == 2 then
		return HANDLER_POP

	end	

	 
	script.trigger_script_event(s, pid, {0, -1, 0})
	script.trigger_script_event(s, pid, {-1, 0, -1})		 
	script.trigger_script_event(s, pid, {0, -1, 0})
	script.trigger_script_event(s, pid, {-1, 0, -1})
	script.trigger_script_event(s, pid, {28, -1, -1})
    script.trigger_script_event(s, pid, {0, -1, 0, -1, -1})
    script.trigger_script_event(s, pid, {0, -1, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1})

	return HANDLER_POP
	
end

function main()

	local test = menu.add_feature("Send Event", "action_value_i", 0, send1)
	test.max_i = 32
	test.min_i = 0
	end

main()