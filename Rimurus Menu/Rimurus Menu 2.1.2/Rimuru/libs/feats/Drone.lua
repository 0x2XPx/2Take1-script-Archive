local function RGBAToInt(Red, Green, Blue, Alpha)
    Alpha = Alpha or 255
    return ((Red & 0x0ff) << 0x00) | ((Green & 0x0ff) << 0x08) |
               ((Blue & 0x0ff) << 0x10) | ((Alpha & 0x0ff) << 0x18)
end

local function round(x) return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5) end

local fade = {r = 255, g = 0, b = 0}
local function RGBFade()
    if fade.r > 0 and fade.b == 0 then
        fade.r = fade.r - 1
        fade.g = fade.g + 1
    end
    if fade.g > 0 and fade.r == 0 then
        fade.g = fade.g - 1
        fade.b = fade.b + 1
    end
    if fade.b > 0 and fade.g == 0 then
        fade.r = fade.r + 1
        fade.b = fade.b - 1
    end
end

local peds_pool, veh_pool = 0, 0

local function Pools()
    peds_pool = #ped.get_all_peds()
    veh_pool = #vehicle.get_all_vehicles()
end

local function drawHUD()
    local scale = 0.70
    local font = 4
    RGBFade()
    Pools()

    local color = {r = 255, g = 255, b = 255, a = 255}
--inner crosshair
   scriptdraw.draw_rect(v2(-0.05, 0.2), v2(0.025, 0.004),
                         RGBAToInt(fade.r, fade.g, fade.b, 255))
    scriptdraw.draw_rect(v2(0.05, 0.2), v2(0.025, 0.004),
                         RGBAToInt(fade.r, fade.g, fade.b, 255))
    scriptdraw.draw_rect(v2(0, 0.3), v2(0.003, 0.025),
                         RGBAToInt(fade.r, fade.g, fade.b, 255))
    scriptdraw.draw_rect(v2(0, 0.1), v2(0.003, 0.025),
                         RGBAToInt(fade.r, fade.g, fade.b, 255))

    scriptdraw.draw_rect(v2(-0.102, 0.40), v2(0.025, 0.004),
                         RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_rect(v2(-0.115, 0.389), v2(0.003, 0.025),
                         RGBAToInt(255, 0, 0, 255))

    scriptdraw.draw_rect(v2(0.102, 0.40), v2(0.025, 0.004),
                         RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_rect(v2(0.115, 0.389), v2(0.003, 0.025),
                         RGBAToInt(255, 0, 0, 255))
--outer
    scriptdraw.draw_rect(v2(0.102, -0.015), v2(0.025, 0.004),
                         RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_rect(v2(0.113, 0.0), v2(0.003, 0.025),
                         RGBAToInt(255, 0, 0, 255))

    scriptdraw.draw_rect(v2(-0.103, -0.015), v2(0.025, 0.004),
                         RGBAToInt(255, 0, 0, 255))
    scriptdraw.draw_rect(v2(-0.115, 0.0), v2(0.003, 0.025),
                         RGBAToInt(255, 0, 0, 255))

    local playerPos = player.get_player_coords(player.player_id())

    local pos = v2()
    pos.x = 0.065
    pos.y = 0.070
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text(round(playerPos.z), pos)

    local pos2 = v2()
    pos2.x = 0.2
    pos2.y = 0.070
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("A-G", pos2)

    local pos3 = v2()
    pos3.x = 0.45
    pos3.y = 0.070
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("MAN", pos3)

    local posPed = v2()
    posPed.x = 0.45
    posPed.y = 0.9
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text(peds_pool, posPed)

    local posVeh = v2()
    posVeh.x = 0.55
    posVeh.y = 0.9
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text(veh_pool, posVeh)

    local pos4 = v2()
    pos4.x = 0.55
    pos4.y = 0.070
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("NARO", pos4)

    local pos5 = v2()
    pos5.x = 0.75
    pos5.y = 0.070
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text(round(playerPos.x), pos5)

    local pos6 = v2()
    pos6.x = 0.85
    pos6.y = 0.070
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text(round(playerPos.y), pos6)

    local pos7 = v2()
    pos7.x = 0.95
    pos7.y = 0.070
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("NIG", pos7)

    local pos8 = v2()
    pos8.x = 0.95
    pos8.y = 0.420
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("A", pos8)

    local pos9 = v2()
    pos9.x = 0.95
    pos9.y = 0.520
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("S", pos9)

    local pos10 = v2()
    pos10.x = 0.95
    pos10.y = 0.620
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("D", pos10)

    local pos11 = v2()
    pos11.x = 0.95
    pos11.y = 0.680
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("Q", pos11)

    local pos12 = v2()
    pos12.x = 0.95
    pos12.y = 0.805
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("LI", pos12)

    local pos13 = v2()
    pos13.x = 0.065
    pos13.y = 0.140
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("RAY", pos13)

    local pos14 = v2()
    pos14.x = 0.065
    pos14.y = 0.220
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("LIR", pos14)

    local pos15 = v2()
    pos15.x = 0.070
    pos15.y = 0.320 + 0.1
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("Recon Drone", pos15)

    local pos16 = v2()
    pos16.x = 0.065
    pos16.y = 0.550
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("L", pos16)

    local pos17 = v2()
    pos17.x = 0.065
    pos17.y = 0.770
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("45mm", pos17)

    local pos18 = v2()
    pos18.x = 0.065
    pos18.y = 0.875
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("10mm", pos18)

    local pos19 = v2()
    pos19.x = 0.065
    pos19.y = 0.825
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(true)
    ui.draw_text("50mm", pos19)

    local pos20 = v2()
    pos20.x = 0.065
    pos20.y = 0.725
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, color.a)
    ui.set_text_outline(pos19)
    ui.draw_text("100mm", pos20)
end

local function multiply(vector, x)
    local result = v3()
    result.x = vector.x
    result.y = vector.y
    result.z = vector.z

    result.x = result.x * x
    result.y = result.y * x
    result.z = result.z * x

    return result
end

local function add(vectorA, vectorB)
    local result = v3()
    result.x = vectorA.x
    result.y = vectorA.y
    result.z = vectorA.z

    result.x = result.x + vectorB.x
    result.y = result.y + vectorB.y
    result.z = result.z + vectorB.z

    return result
end

local function rot_to_direction(rot)
    local radiansZ = rot.z * 0.0174532924
    local radiansX = rot.x * 0.0174532924
    local num = math.abs(math.cos(radiansX))
    local dir = v3()
    dir.x = -math.sin(radiansZ) * num
    dir.y = math.cos(radiansZ) * num
    dir.z = math.sin(radiansX)
    return dir
end

function droneMode(feat)
      while feat.on do
          local player_id = player.player_id()
          local player_ped = player.get_player_ped(player_id)
          local pos = player.get_player_coords(player_id)
          local rot = entity.get_entity_rotation(player_ped)
          local dir = rot
  
          dir:transformRotToDir()
          dir = dir * 4
          pos = pos + dir
  
          ui.hide_hud_and_radar_this_frame()
          drawHUD()
  
          entity.set_entity_visible(player_ped, false)
  
          local camPos = pos
          local camRot = cam.get_gameplay_cam_rot()
  
          local camDir = rot_to_direction(camRot)
  
          local distance = 8
  
          local lengthVec = multiply(dir, distance)
  
          local lookPos = add(camPos, lengthVec)
  
          local ground, groundPos = gameplay.get_ground_z(lookPos)
  
          lookPos.z = groundPos
  
          local key = MenuKey()
          key:push_str("E")
          if key:is_down() then
              local exp1 = gameplay.get_hash_key('weapon_airstrike_rocket')
              local exp2 = gameplay.get_hash_key('WEAPON_EXPLOSION')
  
              gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 50),
                                                          lookPos, 9999, exp1,
                                                          player_ped, true, false,
                                                          9999)
              gameplay.shoot_single_bullet_between_coords(pos + v3(0, 0, 50),
                                                          lookPos, 9999, exp2,
                                                          player_ped, true, false,
                                                          9999)
              fire.add_explosion(lookPos, 41, true, false, 0.5, 0)
          end
          system.wait(1)
      end
end
