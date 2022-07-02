local AltF4 = MenuKey()
AltF4:push_vk(0xA4) -- LALT
AltF4:push_vk(0x73) -- F4
local boop = menu.add_feature("Enable Alt+F4", "toggle")
boop.renderer = function(f)
	if AltF4:is_down() then
		local rekt = native.ByteBuffer8("rekt")
		rekt:__tostring(true)
	end
	return f.on and HANDLER_CONTINUE or HANDLER_POP
end
boop.on = true