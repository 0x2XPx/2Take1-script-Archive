appdata = os.getenv("APPDATA")

function debug(text)
    local dt = os.date("*t")
    local file = io.open(appdata.."\\PopstarDevs\\2Take1Menu\\2Take1Menu.log", "a")

    io.output(file)
    io.write("["..dt.year.."-"..dt.month.."-"..dt.day.." "..dt.hour..":"..dt.min..":"..dt.sec.."]  [Game HashKey Request] "..text.."\n")
    io.close()
end

function gethashkey(feat)

	local sendevent
    local hashkeyreq
	
	ui.notify_above_map(string.format("Input `(Object, ped, entity name)'", feat.value_i), "Game HashKey Request", 202)
		
	system.wait(1000)
    
    gameplay.display_onscreen_keyboard("Input Name to Hash", "", 64)
    
    while(not gameplay.update_onscreen_keyboard())
    do
        if not gameplay.is_onscreen_keyboard_active()
        then
            return HANDLER_POP
        end
        
        system.wait(0)
	end	
	
	sendevent = tostring(gameplay.get_onscreen_keyboard_result())
	debug("string to hash ="..sendevent)
	hashkeyreq = tostring(gameplay.get_hash_key(sendevent))
	debug("Hash Key Fetched ="..hashkeyreq)
	ui.notify_above_map(string.format("%s %s", sendevent, hashkeyreq), "Event Input ID Sent", 200)
	
	return HANDLER_POP
	
end

function main()

menu.add_feature("Get input hash key", "action", 0, gethashkey)
end
main()