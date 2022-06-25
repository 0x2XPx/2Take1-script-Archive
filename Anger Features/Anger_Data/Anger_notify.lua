local Anger_notify ={}

--make a global to detect if already loaded by other scripts and avoid version differences in a thread maybe that scan versions of the file in an array global
--test the different sprite size before using the library
--if user wants normal notify_above_map make a system to not send same notifications under 10 sec in AngerLib.Anger_Notify
--handle gif
--check problem when spamming on-off



local path_2T1 = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
local path_LogoDDS = path_2T1.."scripts\\Anger_Data\\Anger_notify\\logo.dds"
local path_iconDDS = path_2T1.."scripts\\Anger_Data\\Anger_notify\\icon64x64.dds"
local path_backgroundDDS = path_2T1.."scripts\\Anger_Data\\Anger_notify\\background300x100.dds"
--Check file existance
if not utils.file_exists(path_LogoDDS) then
	error("the DDS logo is missing. Please save it and name it in this way 'Appdata/2T1/scripts/logo.dds'. Bye")
end
--Check file existance
if not utils.file_exists(path_iconDDS) then
	error("the DDS icon file is missing. Please save it and name it in this way 'Appdata/2T1/scripts/icon-64x64.dds'. Bye")
end
--Check file existance
if not utils.file_exists(path_backgroundDDS) then
	error("the DDS background file is missing. Please save it and name it in this way 'Appdata/2T1/scripts/background-300x100.dds'. Bye")
end

---------------------------- UTILS ---------------------------------------------------------------



--d3d_draw_RGBA_to_uint32_t(int r, int g, int b, int a) 
	--exemple : d3d_draw_RGBA_to_uint32_t(255, 0, 255, 127) gives : 0x7FFF00FF
function d3d_draw_RGBA_to_uint32_t(int_r,int_g,int_b,int_a)
	
	--just to be sure
	local r= tonumber(int_r)
	local g= tonumber(int_g)
	local b= tonumber(int_b)
	local a= tonumber(int_a)
	
	--uint_32 color behavior:   0xAABBGGRR
	if r > 255 or r < 0 or g > 255 or g < 0 or b > 255 or b < 0 or a > 255 or a < 0 then
		--LogToFile (error)
	else
		local color_to_return = 0x00000000
			color_to_return = (r) << 0  |
							  (g) << 8  |
							  (b) << 16 |
							  (a) << 24
		return color_to_return
	end
end


---------------------------- DRAW ---------------------------------------------------------------

local feature_notif_state
local start_up = true
local sprite_id_logo = scriptdraw.register_sprite(path_LogoDDS)
local sprite_id_icon = scriptdraw.register_sprite(path_iconDDS)
local sprite_id_bkgd = scriptdraw.register_sprite(path_backgroundDDS)
local saved_setting_for_Anger_Better_Notifications_State
local saved_setting_for_Anger_Better_Notifications_X
local saved_setting_for_Anger_Better_Notifications_X


function Anger_notify.get_notification_features_for_settings(handle_feature_notif_state, to_save_saved_setting_for_Anger_Better_Notifications_State)
    
	feature_notif_state = handle_feature_notif_state
	saved_setting_for_Anger_Better_Notifications_State = to_save_saved_setting_for_Anger_Better_Notifications_State
	
end





function Anger_notify.d3d_draw_better_notifications(feat)
	
	
		local pos = v2(0.77,0.90)
		--[[scriptdraw.draw_rect(v2 pos_center/middle_of_rectangle_from_middle_of_screen, 
					  v2 size, 
					  uint_32 color)]]
		--[[scriptdraw.draw_rect(v2(0.89,0.95), 
					  v2(0.05,0.05), 
					  d3d_draw_RGBA_to_uint32_t(0,255,0,100))]]
					  
		--[[scriptdraw.draw_line(v2 start_from_middle_of_screen, 
						v2 end_from_middle_of_screen, 
						int size,  (no effect)
						uint_32 color)]]
		--[[scriptdraw.draw_line(v2(0.94,0.95), 
					  v2(0.98,0.97), 
					  1, 
					  d3d_draw_RGBA_to_uint32_t(255,0,0,100))]]
					  
		--[[scriptdraw.draw_sprite(int id, 
						  v2 pos_center, (if v2(1,1) ==> middle of image at max screen height and width)
						  float scale, (simple multiplier)
						  float rot, (6,28319 is a full rotation(radian))
						  int color)]]
		
		scriptdraw.draw_sprite(sprite_id_icon, 
						pos, 
						0.9, 
						0.0, 
						d3d_draw_RGBA_to_uint32_t(255,255,255,255))
		
		
		scriptdraw.draw_sprite(sprite_id_bkgd, 
						pos+v2(
						(d3d.get_sprite_origin(sprite_id_icon).x+d3d.get_sprite_size(sprite_id_icon).x*2)
						/ (graphics.get_screen_width())    , 0) , 
						0.9, 
						0.0, 
						d3d_draw_RGBA_to_uint32_t(255,255,255,255))
						
						
		
			
		--it go throught the screen side if too long
		--[[scriptdraw.draw_text(string the_string_to_display, 
					v2 pos_center_top_left_of_text_from_middle_of_screen (if no flag !!!), 
					v2 size_from_middle_of_screen (no effect), 
					float scale, (font size)
					uint32_t color, 
					uint32_t flags)]]
							-- TEXTFLAG_NONE          = 0,      "00000" = 0
								-- TEXTFLAG_NONE      ==> no text effect, no shifting
							-- TEXTFLAG_CENTER        = 1 << 0, "00001" = 1  
								-- TEXTFLAG_CENTER    ==> center horizontally from the pos_center_top_left_of_text_from_middle_of_screen
							-- TEXTFLAG_SHADOW        = 1 << 1, "00010" = 2
								-- TEXTFLAG_SHADOW    ==> very small shadow of one pixel
							-- TEXTFLAG_VCENTER       = 1 << 2, "00100" = 4
								-- TEXTFLAG_VCENTER   ==> center vertically from the pos_center_top_left_of_text_from_middle_of_screen
							-- TEXTFLAG_BOTTOM        = 1 << 3, "01000" = 8
								-- TEXTFLAG_BOTTOM    ==> center vertically from the pos_center_top_left_of_text_from_middle_of_screen
							-- TEXTFLAG_JUSTIFY_RIGHT = 1 << 4, "10000" = 16
							  --TEXTFLAG_JUSTIFY_RIGHT==> self explanatory
		scriptdraw.draw_text("test12", 
							v2(0.9,0.94), 
							v2(0.1,0.1), 
							1, 
							d3d_draw_RGBA_to_uint32_t(0,0,255,100), 
							8)
		

		--system.yield(1)
		if feat.on then
			return HANDLER_CONTINUE
		end  
    
end



--test = menu.add_feature("Use this to draw stuff", "toggle", 0, nil)
--test.renderer = Anger_Notify_Process
--test.on = true
--Anger_notify.get_notification_features_for_settings(test)
--Anger_notify.d3d_enable_better_notifications()


return Anger_notify


