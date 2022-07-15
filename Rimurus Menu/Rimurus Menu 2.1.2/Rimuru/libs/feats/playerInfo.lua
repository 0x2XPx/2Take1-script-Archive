getPlayerInfo = {
    name = "",
    scid = 0,
    coords = v3(0,0,0),
    distance = 0, 
    godmode = false,
    health = 0,
    maxHealth = 0,
    armour = 0,
    currentWeapon = "",
    hostStatus = false,
    scriptHostStatus = false,
    isModder = false,
    modderFlags = ""
}

testingInfo = {
    "test",
    "test1",
    "test2",
    "test3"
}

function playerInfoWindow(x, y, infoTable, colour)
    --#### void               draw_rect(float x, float y, float width, float height, int r, int g, int b, int a)
    
    for i=1, #infoTable do
        ui.set_text_scale(0.25)
        ui.set_text_font(0)
        ui.set_text_centre(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_outline(true)
        ui.draw_text(infoTable[i].."\n", v2(x-0.1, y))
    end
    
    ui.draw_rect(x, y, 0.3, 0.4, colour.r, colour.g, colour.b, colour.a)
end