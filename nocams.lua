if not menu.is_trusted_mode_enabled(1 << 2) then
    menu.notify("Natives trusted mode required","No Idle Cam")
end
nocams = menu.add_feature("No Cams", "parent", 0).id
menu.add_feature("No Idle Cam", "toggle", nocams, function(f)
    while f.on do
        native.call(0xF4F2C0D4EE209E20)
        native.call(0x9E4CFFF989258472)
        system.wait(1000)
    end
end).on = true
menu.add_feature("No Stunt Jump Cam", "toggle", nocams, function(f)
    native.call(0xD79185689F8FD5DF, not f.on)
end).on = true
event.add_event_listener("exit", function() native.call(0xD79185689F8FD5DF, true) end)