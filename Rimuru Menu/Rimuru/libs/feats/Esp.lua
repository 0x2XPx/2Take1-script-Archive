local function RGBAToInt(Red, Green, Blue, Alpha)
    Alpha = Alpha or 255
    return ((Red & 0x0ff) << 0x00) | ((Green & 0x0ff) << 0x08) |
               ((Blue & 0x0ff) << 0x10) | ((Alpha & 0x0ff) << 0x18)
end

local function Get_Distance_Between_Coords(first, second)
    local x = second.x - first.x
    local y = second.y - first.y
    local z = second.z - first.z
    return math.sqrt(x * x + y * y + z * z)
end

local function drawHeart(x, y, w, h) --Stole from my cod source, made by soul
    scriptdraw.draw_line(v2(x + (w / 100 * 0), y + (h / 100 * 45)), v2(x + (w / 100 * 10), y + (h / 100 * 18)), 1, RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_line(v2(x + (w / 100 * 100), y + (h / 100 * 45)), v2(x + (w / 100 * 90), y + (h / 100 * 18)), 1, RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_line(v2(x + (w / 100 * 10), y + (h / 100 * 18)), v2(x + (w / 100 * 30), y + (h / 100 * 9)), 1, RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_line(v2(x + (w / 100 * 90), y + (h / 100 * 18)), v2(x + (w / 100 * 70), y + (h / 100 * 9)), 1, RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_line(v2(x + (w / 100 * 30), y + (h / 100 * 9)), v2(x + (w / 100 * 50), y + (h / 100 * 20)), 1, RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_line(v2(x + (w / 100 * 70), y + (h / 100 * 9)), v2(x + (w / 100 * 50), y + (h / 100 * 20)), 1, RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_line(v2(x + (w / 100 * 0), y + (h / 100 * 45)), v2(x + (w / 100 * 50), y + (h / 100 * 93)), 1, RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_line(v2(x + (w / 100 * 100), y + (h / 100 * 45)), v2(x + (w / 100 * 50), y + (h / 100 * 93)), 1, RGBAToInt(255, 0, 0, 255))
end

local function drawShaderOutline(x, y, w, h, outlineColour, insideColour)
	ui.draw_rect(x, y, w, 0.003, outlineColour.r, outlineColour.g, outlineColour.b, outlineColour.a)
	ui.draw_rect(x-w/2, y+h/2, 0.003, h+0.003,  outlineColour.r, outlineColour.g, outlineColour.b, outlineColour.a) --left
	ui.draw_rect(x+w/2, y+h/2, 0.003, h+0.003,  outlineColour.r, outlineColour.g, outlineColour.b, outlineColour.a) -- right
	ui.draw_rect(x, y+h, w, 0.003,  outlineColour.r, outlineColour.g, outlineColour.b, outlineColour.a) 

    ui.draw_rect(x, y+h/2, w, h,  insideColour.r, insideColour.g, insideColour.b, insideColour.a) 
end


function esp(type)
    for i=1, 31 do
        if i ~= player.player_id() then
            if player.is_player_valid(i) and player.get_player_health(i) > 0 then                
                local retrn, screen = graphics.project_3d_coord(player.get_player_coords(i))
                local bonrtrn, pos1 = ped.get_ped_bone_coords(player.get_player_ped(i), 0x796e, v3(-0.01, 0, 0))
                local retrn1, head = graphics.project_3d_coord(pos1)
                
                if retrn and retrn1 then
                    local screen2 = v2(screen.x/graphics.get_screen_width(), (screen.y/graphics.get_screen_height()))
                    local headpos = v2(head.x/graphics.get_screen_width(), (head.y/graphics.get_screen_height()))
                    headpos.y = headpos.y -0.04
                    
                    ui.set_text_scale(0.2)
                    ui.set_text_font(0)
                    ui.set_text_centre(0)
                    ui.set_text_color(255, 255, 255, 255)
                    ui.set_text_outline(true)
                    
                    local height = math.abs(headpos.y - screen2.y)
                    local width = (math.abs(headpos.y - screen2.y)*0.065)
                    if type == 0 then
                        ui.draw_text(player.get_player_name(i), headpos) 
                    end
                    
                    local distance = Get_Distance_Between_Coords(player.get_player_coords(i), player.get_player_coords(player.player_id()))
                    if type == 1 then
                        ui.draw_text(math.floor(distance).."ms", headpos) 
                    end
   
                    if type == 2 then
                        if not player.is_player_in_any_vehicle(i) then
                            drawHeart(screen.x/graphics.get_screen_width()/.5-1, (head.y/graphics.get_screen_height()/.5-1)*-1, 0.05, 0.08)              
                        end
                    end
                  
                    if type == 3 then
                        if not player.is_player_in_any_vehicle(i) then
                            drawShaderOutline(screen2.x, headpos.y, width, height, {r=255, g=0, b=0, a=255}, {r=0, g=0, b=0, a=120})
                        end
                    end
                  
                    if type == 4 then
                        if not player.is_player_in_any_vehicle(i) then
                            ui.draw_text(player.get_player_name(i)..math.floor(distance).."ms", headpos) 
                            drawShaderOutline(screen2.x, headpos.y, 0.01, height, {r=255, g=0, b=0, a=255}, {r=0, g=0, b=0, a=120})
                        end
                    end
                end
            end
        end
    end
end
